Return-Path: <linux-kselftest+bounces-36552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA7FAF9305
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 14:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEE15A59DB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 12:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FF32D5410;
	Fri,  4 Jul 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MG0DJeXC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D738038FA3;
	Fri,  4 Jul 2025 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633218; cv=none; b=oiODozOc/mgvGiMAqFl9q3Kpl22L6BAysok5L4lirBZrRxdhLzn1YR/J42K4V7LcI2vBL7Sj0jMAc6dCLHI5u+5ZpoXlXv50baXdgVlRdpKixEw5wAZSvPuRxhINgz0R3Nrk2C7j98UKNHIu4YhwIk92y6B2J/Umb0uZNgmoLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633218; c=relaxed/simple;
	bh=1rk86AvntVp/KK+qQBI5h2T2wnKgP6ZYTlqIVUIc8hY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csJWBCVXjsSVxW7CPC1Lad7ipmobewzSvI4dKYO0M4+uflsqhduYSkmYD6BbomR53DZlCQH33e9Z0lwsXsmLMydoB13JA2t8Uoy5/v/BJtY7SL+wHi20o6PSm/CwQsNnfDhcHBdF2TF7K5ebE7imTInQrVZwqIirSF6Br6zdRaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MG0DJeXC; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 247C743277;
	Fri,  4 Jul 2025 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751633213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Blod6Od3CkwpUAIdzJOd3oqDn6Iow/ARCeXK46AAgOA=;
	b=MG0DJeXCi8aE5SYxQhke7ORPyHtu/OVya3p4KdhSUssSkrxEbj9bzoYQchj7ZYpDXsQ5Tg
	AR6dExpLGnUAm8h/oNK4bMblTSIzDaRdRm1Yym94be0zLqTgtYoJoquvm3rfsHskdntbxk
	lql01891TvwR8M2vUF2l265LsD+OSSa90KCT/PYQWLN+aJfcLfEE7QUk5oYruvpA2qihNU
	YPkaO/2twXRxQnwyfqI1ZwP07qvp6HiZA0YA4w1SvJjwFOyxh82NCjCKC23yF5rH+SeIkT
	BjMoSPymEgRV83TsK2Bg0sTmONPwA7z7NBsZDpiYdG5GIQKOQ0aHoPRw34+IrA==
Date: Fri, 4 Jul 2025 14:46:51 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: netdevsim: Add PHY support in
 netdevsim
Message-ID: <20250704144651.064e3c28@fedora.home>
In-Reply-To: <20250704124336.GL41770@horms.kernel.org>
References: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
	<20250702082806.706973-2-maxime.chevallier@bootlin.com>
	<20250704124336.GL41770@horms.kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfedulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Simon,

On Fri, 4 Jul 2025 13:43:36 +0100
Simon Horman <horms@kernel.org> wrote:

> On Wed, Jul 02, 2025 at 10:28:03AM +0200, Maxime Chevallier wrote:
> > With the introduction of phy_link_topology, we have the ability to keep
> > track of PHY devices that sit behind a net_device. While we still can
> > only attach one single PHY to a netdev, we can look at all these PHYs
> > through netlink, with the ETHTOOL_MSG_PHY_GET command.
> > 
> > Moreover, netlink commands that are targeting PHY devices also now
> > allow specifying which PHY we want to address in a given netlink
> > command.
> > 
> > That whole process comes with its own complexity, and a few bugs were
> > dicovered over the months following the introduction of  
> 
> Hi Maxime,
> 
> As it seems like there will be a v2 anyway: discovered

Thanks :)

> > phy_link_topology.  
> 
> ...
> 
> > +static struct phy_driver nsim_virtual_phy_drv[] = {
> > +	{
> > +		.name			= "Netdevsim virtual PHY driver",
> > +		.get_features		= nsim_get_features,
> > +		.match_phy_device	= nsim_match_phy_device,
> > +		.config_aneg		= nsim_config_aneg,
> > +		.read_status		= nsim_read_status,
> > +	},
> > +};
> > +
> > +module_phy_driver(nsim_virtual_phy_drv);  
> 
> I see that this has been flagged by Kernel Test Robot,
> but as I had already written most of this it seems worth sending anyway.
> 
> I am somewhat guessing at the why here, but
> I see build failures with this patch applied:
> 
> ld: drivers/net/netdevsim/phy.o: in function `phy_module_init':
> phy.c:(.init.text+0x0): multiple definition of `init_module'; drivers/net/netdevsim/netdev.o:netdev.c:(.init.text+0x0): first defined here
> ld: drivers/net/netdevsim/phy.o: in function `phy_module_exit':
> phy.c:(.exit.text+0x0): multiple definition of `cleanup_module'; drivers/net/netdevsim/netdev.o:netdev.c:(.exit.text+0x0): first defined here
> 
> I am guessing that this is because above module_phy_driver() will define
> init_module and phy_module_exit functions.  But the following lines near
> the end of drivers/net/netdevsim/netdev.c also define functions with those
> names.
> 
> module_init(nsim_module_init);
> module_exit(nsim_module_exit);
> 
> ...

I just received the kernel test robot report indeed :( Thanks for the
investigation ! I'll rework that part, sorry about that :/

Maxime

