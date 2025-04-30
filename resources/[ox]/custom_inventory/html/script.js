let config = {};

window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.action === 'openCustomInventory') {
        config = data.config;
        document.getElementById('inventories').style.display = 'flex';
        loadItems(data.inventory);
    } else if (data.action === 'closeCustomInventory') {
        document.getElementById('inventories').style.display = 'none';
    }
});

function loadItems(inventory) {
    const playerItemsContainer = document.getElementById('player-items');
    const targetItemsContainer = document.getElementById('target-items');

    playerItemsContainer.innerHTML = '';
    targetItemsContainer.innerHTML = '';

    // Ajouter les items du joueur
    inventory.player.forEach(item => {
        const itemElement = document.createElement('div');
        itemElement.className = 'item-slot';
        itemElement.innerText = `${item.label} x${item.count}`;
        playerItemsContainer.appendChild(itemElement);
    });

    // Ajouter les items de la cible
    inventory.target.forEach(item => {
        const itemElement = document.createElement('div');
        itemElement.className = 'item-slot';
        itemElement.innerText = `${item.label} x${item.count}`;
        targetItemsContainer.appendChild(itemElement);
    });
}

function closeInventory() {
    fetch(`https://${GetParentResourceName()}/closeInventory`, {
        method: 'POST',
        body: JSON.stringify({})
    });
}
