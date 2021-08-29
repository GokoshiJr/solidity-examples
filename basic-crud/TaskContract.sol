pragma solidity ^0.8.6; // indicamos la version de solidity que vamos a usar

contract TaskContract {
    
    // colocamos el public para observar el valor de la variable de manera publica cuando hagamos deploy
    string public message = "Hello World";
    int public number = 10;
    
    // funcion que devuelve un valor
    int n = 30;
    // indicamos la visibilidad public, que retorna returns (int), como no estamos alterando la funcion 
    // sino devolviendo un valor debemos colocar view
    function my_number() public view returns (int) {
        return n;
    }
    
    
    uint next_id;
    
    // con la palabra struct definimos que propiedades vamos a guardar para un dato
    struct Task {
        uint id;
        string name;
        string description;
    }
    
    Task[] tasks; // array de tareas
    
    function create_task(string memory _name, string memory _description) public {
        tasks.push(Task(next_id, _name, _description));
        next_id++;
    }
    
    // por convencion en solidity los parametros llevan _
    // memory, solo va a estar guardado un momento al ejecutarse la funcion y no guardados en la blockchain
    function read_task(uint _id) public view returns (uint, string memory, string memory) {
        uint i = find_index(_id);
        return (tasks[i].id, tasks[i].name, tasks[i].description);
    }
    
    // internal es como private
    // view para no alterar los datos, solo verlos
    // indicamos que retorna
    function find_index(uint _id) internal view returns (uint) {
        for (uint i = 0; i < tasks.length; i++) {
            if (tasks[i].id == _id) {
                return i;
            }
        }
        revert('Task not found'); // si no encontramos el id, lanzamos un error
    }
    
    function update_task(uint _id, string memory _name, string memory _description) public {
        uint i = find_index(_id);
        tasks[i].name = _name;
        tasks[i].description = _description;
    }
    
    // como tal no se pueden eliminar datos de la blockchain, por lo tanto esta funcion
    // delete_task va a poner las tareas en un estado por defecto
    function delete_task(uint _id) public {
        uint i = find_index(_id);
        delete tasks[i];
    }
}