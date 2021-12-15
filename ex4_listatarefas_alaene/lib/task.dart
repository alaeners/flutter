class Todo {

	late int _id;
	String _description;
	bool _done;

	Todo(this._description, this._done);

	Todo.withId(this._id, this._description, this._done);

	int get id => _id;
	String get description => _description;
	bool get done => _done;


	set description(String newDescription) {
		if (newDescription.length <= 255) {
			_description = newDescription;
		}
	}

	set done(bool newDone) {
		_done = newDone;
	}

	// Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['description'] = _description;
		map['done'] = _done;

		return map;
	}

	// Extract a Note object from a Map object
	fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._description = map['description'];
		this._done = map['done'];
	}
}