document.addEventListener('DOMContentLoaded', function() {
    loadCampaigns();
});

document.getElementById('add-campaign-btn').addEventListener('click', function() {
    let title = document.getElementById('campaign-title').value;
    let description = document.getElementById('campaign-description').value;
    let date = document.getElementById('campaign-date').value;
    let location = document.getElementById('campaign-location').value;
    let time = document.getElementById('campaign-time').value;
    let imageInput = document.getElementById('campaign-image');
    let imageFile = imageInput.files[0];

    if (!title || !description || !date || !location || !time || !imageFile) {
        alert('Please enter all campaign details, including an image.');
        return;
    }

    let reader = new FileReader();
    reader.onload = function(event) {
        let newCampaign = {
            id: Date.now(), // Unique ID for each campaign
            title,
            description,
            date,
            location,
            time,
            image: event.target.result
        };

        let campaigns = JSON.parse(localStorage.getItem('campaigns')) || [];
        campaigns.push(newCampaign);
        localStorage.setItem('campaigns', JSON.stringify(campaigns));

        displayCampaign(newCampaign);
        resetForm();
    };
    reader.readAsDataURL(imageFile);
});

function displayCampaign(campaign) {
    let campaignList = document.getElementById('campaign-list');
    let campaignItem = document.createElement('div');
    campaignItem.classList.add('campaign-item');
    campaignItem.setAttribute('data-id', campaign.id);
    campaignItem.innerHTML = `
        <img src="${campaign.image}" alt="Campaign Image" class="campaign-image">
        <div class="campaign-details">
            <h3>${campaign.title}</h3>
            <p>${campaign.description}</p>
            <p><strong>Date:</strong> ${campaign.date}</p>
            <p><strong>Location:</strong> ${campaign.location}</p>
            <p><strong>Time:</strong> ${campaign.time}</p>
            <button class="edit-btn">Edit</button>
            <button class="delete-btn">Delete</button>
        </div>
    `;
    campaignList.appendChild(campaignItem);

    campaignItem.querySelector('.delete-btn').addEventListener('click', function() {
        deleteCampaign(campaign.id, campaignItem);
    });

    campaignItem.querySelector('.edit-btn').addEventListener('click', function() {
        editCampaign(campaign.id, campaignItem);
    });
}

function loadCampaigns() {
    let campaigns = JSON.parse(localStorage.getItem('campaigns')) || [];
    campaigns.forEach(displayCampaign);
}

function deleteCampaign(id, element) {
    let campaigns = JSON.parse(localStorage.getItem('campaigns')) || [];
    campaigns = campaigns.filter(campaign => campaign.id !== id);
    localStorage.setItem('campaigns', JSON.stringify(campaigns));
    element.remove();
}

function editCampaign(id, element) {
    let campaigns = JSON.parse(localStorage.getItem('campaigns')) || [];
    let campaign = campaigns.find(c => c.id === id);
    
    let newTitle = prompt('Edit Campaign Title:', campaign.title);
    let newDescription = prompt('Edit Description:', campaign.description);
    let newDate = prompt('Edit Date:', campaign.date);
    let newLocation = prompt('Edit Location:', campaign.location);
    let newTime = prompt('Edit Time:', campaign.time);

    if (newTitle && newDescription && newDate && newLocation && newTime) {
        campaign.title = newTitle;
        campaign.description = newDescription;
        campaign.date = newDate;
        campaign.location = newLocation;
        campaign.time = newTime;

        localStorage.setItem('campaigns', JSON.stringify(campaigns));
        
        element.querySelector('h3').textContent = newTitle;
        element.querySelector('p').textContent = newDescription;
        element.querySelectorAll('p')[1].innerHTML = `<strong>Date:</strong> ${newDate}`;
        element.querySelectorAll('p')[2].innerHTML = `<strong>Location:</strong> ${newLocation}`;
        element.querySelectorAll('p')[3].innerHTML = `<strong>Time:</strong> ${newTime}`;
    }
}

function resetForm() {
    document.getElementById('campaign-title').value = '';
    document.getElementById('campaign-description').value = '';
    document.getElementById('campaign-date').value = '';
    document.getElementById('campaign-location').value = '';
    document.getElementById('campaign-time').value = '';
    document.getElementById('campaign-image').value = '';
}