// SPDX-License-Identifier: MIT
// コンパイラのバージョンをチェック
pragma solidity >=0.6.8 <0.9.0;

uint256 constant TOTAL_TICKETS = 10;

// コントラクトを記載
contract Tickets {
  // public = 誰でも（別のコントラクトからでも）コントラクトの関数を呼び出して実行できる。
  // msg.sender = その関数を呼び出したユーザーのアドレスを示す、グローバル変数のこと
  // address = 20バイトの値 (Ethereumアドレスの大きさ)
  address public owner = msg.sender;
  
  // struct = 複数の型の変数をまとめて新しい型（構造体）として作ることが可能（今回はpriceとownerを項目として作っている）
  struct Ticket {
    uint256 price;
    address owner;
  }
  Ticket[TOTAL_TICKETS] public tickets;

  // constructor = コントラクトが作られた時、constructor (constructorキーワードで宣言されるファンクション)が一度だけ実行されます
  constructor() {
    // for(初期処理; 条件式; 反復する毎に行う処理)
    for (uint256 i = 0; i < TOTAL_TICKETS; i++) {
      tickets[i].price = 1e17; // 0.1 ETH
      tickets[i].owner = address(0x0);
    }
  }
  // external = 外部からのみ呼び出すことができます。
  function buyTicket(uint256 _index) external payable {
    // requireは = 例外が投げられた時にエラー文を与えることができる（基本的には外部からの入力値をチェックするのに使う）
    require(_index < TOTAL_TICKETS && _index >= 0); // && = and _indexは0以上、TOTAL_TICKETS未満の値かをチェック
    require(tickets[_index].owner == address(0x0)); // 
    require(msg.value >= tickets[_index].price); //価格以上の金額を送金しているか確認（実際の送金額の確認）
    tickets[_index].owner = msg.sender;
  }
}