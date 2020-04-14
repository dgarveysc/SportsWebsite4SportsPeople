import React, { Component } from 'react';
import { Footer, FooterSection, FooterDropDownSection, FooterLinkList } from 'react-mdl';
import { Link } from 'react-router-dom';

class footer extends Component {
    render() {
        return(
            <Footer className="footer-text" size="mega">
            <FooterSection type="middle">
                <FooterDropDownSection title="Features">
                    <FooterLinkList>
                        <Link to="/">About</Link>
                        <Link to="/">About</Link>
                        <Link to="/">About</Link>
                        <Link to="/">About</Link>
                    </FooterLinkList>
                </FooterDropDownSection>
                <FooterDropDownSection title="Details">
                    <FooterLinkList>
                        <Link to="/">About</Link>
                        <Link to="/">About</Link>
                        <Link to="/">About</Link>
                    </FooterLinkList>
                </FooterDropDownSection>
                <FooterDropDownSection title="Technology">
                    <FooterLinkList>
                        <Link to="/">About</Link>
                        <Link to="/">About</Link>
                        <Link to="/">About</Link>
                        <Link to="/">About</Link>
                        <Link to="/">About</Link>
                    </FooterLinkList>
                </FooterDropDownSection>
                <FooterDropDownSection title="FAQ">
                    <FooterLinkList>
                        <Link to="/">About</Link>
                        <Link to="/">About</Link>
                        <Link to="/">About</Link>
                    </FooterLinkList>
                </FooterDropDownSection>
            </FooterSection>
            <FooterSection type="bottom" logo="Title">
                <FooterLinkList>
                    <Link to="/">About</Link>
                    <Link to="/">About</Link>
                </FooterLinkList>
            </FooterSection>
        </Footer>
        )
    }
}

export default footer;