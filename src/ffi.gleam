/// Appends some HTML as a child of the given selector.
@external(javascript, "ffi", "append_child")
pub fn append_child(selector: String, html: String) -> Nil

@external(javascript, "ffi", "open_json")
pub fn open_json(path: String, cb: fn(String) -> Nil) -> Nil
