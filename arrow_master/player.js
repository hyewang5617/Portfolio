class Head
{
    constructor(x, y, size)
    {
        this.x = x;
        this.y = y;
        this.size = size;
    }

    draw()
    {

        rect(this.x, this.y, this.size);
    }
}

class Body
{
    constructor(x, y, wid, hei)
    {
        this.x = x;
        this.y = y;
        this.wid = wid;
        this.hei = hei;
    }

    draw()
    {
        rect(this.x, this.y, this.wid, this.hei);
    }
}

class Leg
{
    constructor(x, y, wid, hei)
    {
        this.x = x;
        this.y = y;
        this.wid = wid;
        this.hei = hei;
    }

    draw()
    {
        rect(this.x, this.y, this.wid, this.hei);
    }
}