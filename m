Return-Path: <linux-kselftest+bounces-37354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C003B05BFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 15:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E684E7E41
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 13:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746242E337E;
	Tue, 15 Jul 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ylZ6l0lR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBFD2E2F0F;
	Tue, 15 Jul 2025 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585803; cv=none; b=BhCdFFMyKYA4K+VT5wX5Y2xWdGka4KBYa/TTsXRglL4b6H4jv57m89ZXedxlvak5HhthLRTQzag2j4lyZREym6sGS+btQc4jdQN1fRYX58lfY6QLwWVUMZAizhDf2arJzR1vna3JS56//LRsBoxfgXle94wCEFIddhgWowsaVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585803; c=relaxed/simple;
	bh=aY6ZaG5WJYdCxl0AClIrPZMwSFXEQcXvsxkGjAF8aAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeVEW7zehNd5DdIF2CfPLsuORKiqT5DLFbwDrs2Hr9+xriidl3r1yx/4XsHsdI9VaEG+B96bAvV1oPqsrE2MclyNMqV0BOJtg/typSCbWk947dYw4cjpQUb3BS4wUPNLxbaF8Z0KY46/ctFiX0MS58kBkl4IKw5t4CPPR8LvZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ylZ6l0lR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ViDPxI/KxGr7NADEG4gWhmQ263UIueGoq3NzkFo2Nl0=; b=ylZ6l0lRmi2YdHKCYUYwpbUh3a
	jcbZcCpnHItIyk68/FBkomJjoLU9j7mpQ82fcYzswPIaVP7Lnj512tVWd7mNMQuexziaoJVHJ0fVh
	oUQD3aVqd5e1nfI3SvxDeglHIE8n7iKVCkL1fnMmpnyu9lG8zZpmVjxHfy4qVEtxcpGA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubfck-001a8I-Ub; Tue, 15 Jul 2025 15:23:10 +0200
Date: Tue, 15 Jul 2025 15:23:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: netdevsim: Add PHY support in
 netdevsim
Message-ID: <9c30b1ab-95fe-4238-950e-23bbd1bb1632@lunn.ch>
References: <20250710062248.378459-1-maxime.chevallier@bootlin.com>
 <20250710062248.378459-2-maxime.chevallier@bootlin.com>
 <560e7969-b859-45ed-b368-350a62cec678@lunn.ch>
 <20250715080532.07883d74@fedora.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715080532.07883d74@fedora.home>

On Tue, Jul 15, 2025 at 08:05:32AM +0200, Maxime Chevallier wrote:
> On Sat, 12 Jul 2025 18:54:38 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +static int nsim_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static int nsim_mdio_write(struct mii_bus *bus, int phy_addr, int reg_num,
> > > +			   u16 val)
> > > +{
> > > +	return 0;
> > > +}  
> > 
> > If i'm reading the code correctly, each PHY has its own MDIO bus? And
> > the PHY is always at address 0?
> 
> Yes indeed. 
> 
> > Maybe for address != 0, these should return -ENODEV?
> 
> That could be done yes, but I don't think this will ever happen as this
> is only ever going to be used in netdevsim, which also controls the PHY
> instantiation. I'm OK to add the ENODEV though :)

It makes the simulation more realistic. The other option is to return
0xffff on read, which is what a real MDIO bus would do when you access
an address without a device.

It currently should not happen, but this is the sort of framework
which will get expanded with time. So this low hanging fruit could
avoid issues later.

> For the record, the first draft implementation I had locally used a
> single MDIO bus on which we could register up to 32 netdevsim PHYs, but
> that wasn't enough. At some point Jakub pointed me to the case of
> netlink DUMP requests that would be too large to fit in a single
> netlink message (default threshold for that is > 4K messages), so to
> test that with the phy_link_topology stuff, I had to add around 150
> PHYs...

I'm happy with an MDIO bus per PHY, for the reasons you give.

> > I'm guessing the PHY core is going to perform reads/writes for things
> > like EEE? And if the MAC driver has an IOCTL handler, it could also do
> > reads/writes. So something is needed here, but i do wounder if hard
> > coded 0 is going to work out O.K? Have you looked at what accesses the
> > core actually does?
> 
> I don't see that driver being useful outside of netdevsim, so at
> least we have a good idea of what the MAC driver will do.
>
> There'e no ioctl, but we can be on the safe side and stub it a bit more.
> 
> From the tests I've been running, I didn't encounter any side-effect
> but I only tested very simple cases (set link up, run ethtool, etc.)

It is hard to say where this will lead. We have seen bugs with EEE, so
being able to test that might be interesting to someone. Given that is
all in the core, that would require implementing the C45 over C22 and
the EEE registers.

> I've considered re-using swphy for example, and using an emulated MDIO
> bus for netdevsim PHY, but my fear was that this would in the end get
> too complex.

Yes, i thought about that too. But i agree, that is the wrong way to
go. We would end up adding a lot of features to swphy which never get
used in real system, and potentially had bugs to real systems. An
emulated PHY for netdevsim might start as a copy/paste of swphy, but i
would then expect it to quickly diverge.

	Andrew

