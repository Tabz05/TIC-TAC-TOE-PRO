class MultiPlayerGameModel{

   final String? multiPlayerGameId;
   final String? sender;
   final String? receiver;

   String? turn;

   bool? enableTap;

   bool? gameOver;
   String? winner;

   bool? senderHasJoined;
   bool? receiverHasJoined;
   bool? cancelled;

   List<String>? board=[];
   
   MultiPlayerGameModel({this.multiPlayerGameId,this.sender,this.receiver,this.turn,this.enableTap,this.gameOver,this.winner,this.senderHasJoined,this.receiverHasJoined,this.cancelled,this.board});

}