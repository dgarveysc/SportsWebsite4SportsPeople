import React, { Component } from 'react';
import { Grid, Cell } from 'react-mdl';

class landingpage extends Component {
    render() {
        return(
            //<div><h1>Homepage</h1></div>
            <div style={{width: '100%', margin: 'auto'}}>
                <Grid className="home-grid">
                <div className="banner-text">
                        <h1> Featured Games </h1>
                </div>
                <Cell col={4}>
                    <p> [Featured Game 1]</p>
                    <img 
                    src="https://www.clipartkey.com/mpngs/m/15-152100_transparent-video-game-clipart-games-consoles-clip-art.png"
                    alt="online game placeholder"
                    className="game-img"
                    />
                </Cell>
                <Cell col={4}>
                    <p> [Featured Game 2]</p>
                    <img 
                    src="https://www.clipartkey.com/mpngs/m/15-152100_transparent-video-game-clipart-games-consoles-clip-art.png"
                    alt="online game placeholder"
                    className="game-img"
                    />
                </Cell>
                <Cell col={4}>
                    <p> [Featured Game 3]</p>
                    <img 
                    src="https://www.clipartkey.com/mpngs/m/15-152100_transparent-video-game-clipart-games-consoles-clip-art.png"
                    alt="online game placeholder"
                    className="game-img"
                    />
                </Cell>
                </Grid>
            </div>
        )
    }
}

export default landingpage;