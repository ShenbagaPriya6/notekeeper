document.addEventListener('DOMContentLoaded', function() {
    // Fetch notes on page load
    fetchNotes();

    // Function to fetch and display notes
    function fetchNotes() {
        fetch('fetchNotes.jsp')
            .then(response => response.json())
            .then(data => {
                const notesList = document.getElementById('notes');
                notesList.innerHTML = '';
                data.forEach(note => {
                    const li = document.createElement('li');
                    li.textContent = `Title: ${note.title}, Subject: ${note.subject}, Content: ${note.content}`;
                    notesList.appendChild(li);
                });
            });
    }
    document.addEventListener('DOMContentLoaded', function () {
        const searchForm = document.getElementById('searchForm');
        const notesList = document.getElementById('notes-list');
        const notesUl = document.getElementById('notes');
        const goBackButton = document.getElementById('goBack');
        const addNoteSection = document.getElementById('add-note');
        const searchNotesSection = document.getElementById('search-notes');
    
        // Handle search form submission
        searchForm.addEventListener('submit', function (event) {
            event.preventDefault();
    
            const criteria = document.getElementById('criteria').value;
            const query = document.getElementById('query').value;
    
            fetch(`searchNotes.jsp?criteria=${criteria}&query=${query}`)
                .then(response => response.json())
                .then(data => {
                    displayNotes(data);
                })
                .catch(error => console.error('Error:', error));
        });
    
        // Function to display notes
        function displayNotes(notes) {
            notesUl.innerHTML = '';
            notes.forEach(note => {
                const li = document.createElement('li');
    
                const title = document.createElement('h3');
                title.textContent = note.title;
                li.appendChild(title);
    
                const subject = document.createElement('p');
                subject.textContent = `Subject: ${note.subject}`;
                li.appendChild(subject);
    
                const content = document.createElement('p');
                content.textContent = note.content;
                li.appendChild(content);
    
                const createdAt = document.createElement('span');
                createdAt.textContent = `Created at: ${note.created_at}`;
                li.appendChild(createdAt);
    
                notesUl.appendChild(li);
            });
    
            addNoteSection.style.display = 'none';
            searchNotesSection.style.display = 'none';
            notesList.style.display = 'block';
        }
    
        // Handle Go Back button click
        goBackButton.addEventListener('click', function () {
            notesList.style.display = 'none';
            addNoteSection.style.display = 'block';
            searchNotesSection.style.display = 'block';
        });
    });
    
    
    // Display success message if redirected from addNote.jsp
    if (window.location.search.includes('success=true')) {
        alert('Note added successfully!');
    }
});
