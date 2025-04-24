module scoreboard(score, ws, ls);
input[1:0] score;
output wire [4:0] ws;
output wire [4:0] ls;

reg [4:0] up;
reg [4:0] down;

always @ (score)
begin
if(score == 1)
up <= up +1;
else if(score == 3)
down <= down + 1;
end
endmodule
