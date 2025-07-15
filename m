Return-Path: <linux-kselftest+bounces-37359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569F7B0602C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 16:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F131C50321B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 14:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B52EE975;
	Tue, 15 Jul 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZyyESEX+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2A26D4F2;
	Tue, 15 Jul 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587796; cv=none; b=qE80pI5T9aylvr8ZndICzdsM0T+TTUTeC01ZaDMtNtd8E/lij7sDSPHqQT13YOjCmRC1PMTcgCSYNfjr5hu7L73PQEz62FPJYjM5RrazZFfGq+HCq/ITVSY1kouhEWO/zS784g5zFnR4iF0dihQDnCrVtIZe/ZIo3u/tSNoah4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587796; c=relaxed/simple;
	bh=Uh3hup0gyT8O7gjxDRHFs/RGrrn3/M3E0Umu7GLkyQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuXcTtF9Wska349cC0+A9MUjk0FvNyDfnX+Ph1FvIlYiv0wtscrBSHaIibskYSnsBU9gEL2vgEaUtTsUb4XqMrS0cUq6/Mm1ZwEYCE+7iDvWNkY/4hl0qMekf6iKeQsdd/pFNCvXRA6BIESIICGQlHww0ImYJ1Qzeg3bj6lOFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZyyESEX+; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1021141D02;
	Tue, 15 Jul 2025 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752587786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43FRh/i1G09dO+5AcP8rK/l3vtnkO9GEUpWV7yM7c1c=;
	b=ZyyESEX+s8cQH35ATLn0ouNsfMbn4NozOqS93qCkYrmI7omzqQqjMKXIvN/L6mizGXJV3B
	YduC2vfw9NeVTdQ6oYkUkg+sZ+IIWMMMTgAW/ng0OBy3KSntqUzZYiVHn1UGHYmmY3Gcxz
	mPUUAOE/FFw/GiWtQr/tAJzafmzVl8tyYWCY3kQ7WppikfIiBGN7JE6XtWZmNKF0MDn23T
	ZW1gs/JdsI/mJ2Lt6WXNAmTKf4i+ezkdgofrtiGJ9XIzGnm/DGXeAUbnvqNFjM8C9yHGOz
	JV/pGKc0LpEdzGAIMGDzZ/tVss5peFJhH/fkE5ywisBUGvCJnOstQ3yT3Bgfcw==
Date: Tue, 15 Jul 2025 15:56:23 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: netdevsim: Add PHY support in
 netdevsim
Message-ID: <20250715155623.59fbc2c9@fedora.home>
In-Reply-To: <9c30b1ab-95fe-4238-950e-23bbd1bb1632@lunn.ch>
References: <20250710062248.378459-1-maxime.chevallier@bootlin.com>
	<20250710062248.378459-2-maxime.chevallier@bootlin.com>
	<560e7969-b859-45ed-b368-350a62cec678@lunn.ch>
	<20250715080532.07883d74@fedora.home>
	<9c30b1ab-95fe-4238-950e-23bbd1bb1632@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehhedttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

> > On Sat, 12 Jul 2025 18:54:38 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >   
> > > > +static int nsim_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int nsim_mdio_write(struct mii_bus *bus, int phy_addr, int reg_num,
> > > > +			   u16 val)
> > > > +{
> > > > +	return 0;
> > > > +}    
> > > 
> > > If i'm reading the code correctly, each PHY has its own MDIO bus? And
> > > the PHY is always at address 0?  
> > 
> > Yes indeed. 
> >   
> > > Maybe for address != 0, these should return -ENODEV?  
> > 
> > That could be done yes, but I don't think this will ever happen as this
> > is only ever going to be used in netdevsim, which also controls the PHY
> > instantiation. I'm OK to add the ENODEV though :)  
> 
> It makes the simulation more realistic. The other option is to return
> 0xffff on read, which is what a real MDIO bus would do when you access
> an address without a device.
> 
> It currently should not happen, but this is the sort of framework
> which will get expanded with time. So this low hanging fruit could
> avoid issues later.

True, I'm fine with the 0xffff return on address != 0

> > For the record, the first draft implementation I had locally used a
> > single MDIO bus on which we could register up to 32 netdevsim PHYs, but
> > that wasn't enough. At some point Jakub pointed me to the case of
> > netlink DUMP requests that would be too large to fit in a single
> > netlink message (default threshold for that is > 4K messages), so to
> > test that with the phy_link_topology stuff, I had to add around 150
> > PHYs...  
> 
> I'm happy with an MDIO bus per PHY, for the reasons you give.
> 
> > > I'm guessing the PHY core is going to perform reads/writes for things
> > > like EEE? And if the MAC driver has an IOCTL handler, it could also do
> > > reads/writes. So something is needed here, but i do wounder if hard
> > > coded 0 is going to work out O.K? Have you looked at what accesses the
> > > core actually does?  
> > 
> > I don't see that driver being useful outside of netdevsim, so at
> > least we have a good idea of what the MAC driver will do.
> >
> > There'e no ioctl, but we can be on the safe side and stub it a bit more.
> > 
> > From the tests I've been running, I didn't encounter any side-effect
> > but I only tested very simple cases (set link up, run ethtool, etc.)  
> 
> It is hard to say where this will lead. We have seen bugs with EEE, so
> being able to test that might be interesting to someone. Given that is
> all in the core, that would require implementing the C45 over C22 and
> the EEE registers.
> 
> > I've considered re-using swphy for example, and using an emulated MDIO
> > bus for netdevsim PHY, but my fear was that this would in the end get
> > too complex.  
> 
> Yes, i thought about that too. But i agree, that is the wrong way to
> go. We would end up adding a lot of features to swphy which never get
> used in real system, and potentially had bugs to real systems. An
> emulated PHY for netdevsim might start as a copy/paste of swphy, but i
> would then expect it to quickly diverge.

So should we instead move to a netdevsim PHY model where we would
emulate an mdio bus and use a pure genphy driver instead ?

If you see some future for nsim PHY as a testing ground for phylib (and
not only for ethnl), that would make sense :)

Maxime

