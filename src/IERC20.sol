// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//Interface de nuestro token ERC20
interface IERC20 {

    //Devuelve la cantidad de tokens existentes.
    function totalSupply() external view returns (uint256);

    //Devuelve la cantidad de tokens que posee una `account`.
    function balanceOf(address account) external view returns (uint256);

    /* Realiza una transferencia de tokens a un destinatario.
    Devuelve un valor booleano que indica si la operacion tuvo exito. 
    Emite un evento {Transfer}. */
    function transfer(address to, uint256 amount) external returns (bool);

    /* Devuelve el numero restante de tokens que se le permitira al `spender`
    gastar en nombre del `owner` a traves de {transferFrom}. Este valor es
    cero por defecto. Este valor cambia cuando {approve} o {transferFrom} son llamados. */
    function allowance(address owner, address spender) external view returns (uint256);

    /* Establece una `amount` como la asignacion de `spender` sobre los tokens 
    de la persona que llama. Devuelve un valor booleano que indica si la operacion tuvo exito.
    Emite un evento {Approval}. */
    function approve(address spender, uint256 amount) external returns (bool);

    /* Mueve los tokens de una direccion a otra utilizando el mecanismo de asignacion. 
    Devuelve un valor booleano que indica si la operacion tuvo exito.
    Emite un evento {Transfer}. */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    /* Se emite cuando se realiza una transferencia de tokens. 
    Ten en cuenta que `value` puede ser cero. */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* Se emite cuando la asignacion de un `spender` para un `owner` se establece mediante
    una llamada a {approve}. El `value` es la nueva asignacion. */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}