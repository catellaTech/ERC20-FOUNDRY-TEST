// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import "../src/MY_TOKEN.sol";

contract MY_TOKEN_TEST is Test {
    MY_TOKEN public myToken;

    // Two accounts
    address  tony = vm.addr(1);
    address  loki = vm.addr(2);
    
    function setUp() public {
        myToken = new MY_TOKEN(tony);

        // Create Tokens
        vm.startPrank(tony);
        myToken.crearTokens();
        uint balance = myToken.balanceOf(tony);
        vm.stopPrank();
        assertEq(balance, 100e18);
        
        // approve tokens to loki
        vm.prank(tony);
        bool success = myToken.approve(loki, 50e18);// Notacion cientifica: 50e18
        assertTrue(success);
    }
    
    function testAccess() public {
        // access to the name
        assertEq(myToken.name(),"Rather");
        // access to the symbol
        assertEq(myToken.symbol(),"RTH");
        // access to  decimals
        assertEq(myToken.decimals(), 18);
        // access to supply
        assertEq(myToken.totalSupply(), 100e18);
        // access to owner
        assertEq(myToken.owner(), tony);
    }

    function testExpectToRevertTokens() public {
        // We expect revert with another user
        vm.startPrank(loki);
        vm.expectRevert("You're not the owner");
        myToken.crearTokens();
        vm.stopPrank();
    }

    function testAllowance() public {
        assertEq(myToken.allowance(tony,loki), 50e18);
        vm.stopPrank();
    }

    function testTransferFrom() public {
        vm.startPrank(loki);
        bool succesTransferFrom = myToken.transferFrom(tony, loki, 50e18);
        assertTrue(succesTransferFrom);
        vm.stopPrank();
    }

    function testBurn() public {
        testTransferFrom();
        
        vm.prank(tony);
        myToken.burnTokens(loki, 50e18);

        uint FinalLokiBalance = myToken.balanceOf(loki);
        assertEq(FinalLokiBalance, 0);
        vm.stopPrank();
    }
    function testCreateMoreTokens() public {
        testTransferFrom();

        vm.prank(tony);
        myToken.crearTokens();
        assertEq(myToken.balanceOf(tony), 150e18);

    }
}


