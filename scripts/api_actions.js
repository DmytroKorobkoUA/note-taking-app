const axios = require('axios');

const baseUrl = 'http://localhost:3000/v1';

let authToken = null;

async function authenticate(username, password) {
    try {
        const response = await axios.post(`${baseUrl}/auth/login`, { username, password });

        // Assuming the response contains a 'data' object with a 'token' property
        if (response.data && response.data.token) {
            authToken = response.data.token;
            console.log('Authenticated successfully. Token:', authToken);
        } else {
            console.error('Authentication failed: Invalid response');
        }
    } catch (error) {
        console.error('Authentication failed:', error.message);
    }
}

async function listNotes() {
    try {
        const response = await axios.get(`${baseUrl}/notes`);
        console.log('All Notes(before creating new one and updating):', response.data);
    } catch (error) {
        console.error('Error listing notes:', error.message);
    }
}

async function createNote(title, content) {
    try {
        const response = await axios.post(`${baseUrl}/users/notes`, { title, content }, {
            headers: authToken ? { Authorization: `Bearer ${authToken}` } : {}
        });
        console.log('New Note was created successfully. Response status:', response.status);
    } catch (error) {
        console.error('Error creating note:', error.message);
    }
}

async function updateNote(noteId, title, content) {
    try {
        const response = await axios.patch(`${baseUrl}/users/notes/${noteId}`, { title, content }, {
            headers: authToken ? { Authorization: `Bearer ${authToken}` } : {}
        });
        console.log('Updated Note:', response.data);
    } catch (error) {
        console.error('Error updating note:', error.message);
    }
}

// Usage examples for showing results via terminal
authenticate('admin', 'StrongPassword!').then(() => {
    // Listing notes does not require authentication
    listNotes();

    // Creating a new note requires authentication
    createNote('New Note', 'This is a new note');

    // Updating a note requires authentication
    updateNote(1, 'Updated Note', 'This note has been updated');
});
