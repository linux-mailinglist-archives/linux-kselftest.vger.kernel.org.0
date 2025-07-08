Return-Path: <linux-kselftest+bounces-36760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701A1AFCD18
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 16:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3161E7B38B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4DB2DECDF;
	Tue,  8 Jul 2025 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ogUOJPh2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D92DECD4;
	Tue,  8 Jul 2025 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983988; cv=none; b=qUIwP7+ad0/y/K/XYHqysj9TvFniqcMejjxKJXEDiAoN8TBzOnqix/YT9VjSKoQxpAEVT1Lf+IlSiF89Dn1ZzjOzqrkcy0BWo0pGy4ver70vLj2fGVE3ne3jcW/F4N3B+b/fF3u3DicLemTOaX74g68HtM8CZy+vKFWm883eLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983988; c=relaxed/simple;
	bh=mUa5VGfPK7WXD/1exqzxKMcLrIOHwOGywgEaVxTJK+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFavBvtYENYyH0KplCCx6qcQf7Bi4t1uprHKrMO42hsKKhtCKLtxWziXHiFEWkHcpFq9t0r/y2EtI5WuBSbiaBjDHEojkdd+2QPF0DWII9fDDGu69FFjNBCkMTg/iPwOFIpS2LZBr4AlTeyqSZmK8meDpaY4zjktyAqpGJrwfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ogUOJPh2; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B192442C4;
	Tue,  8 Jul 2025 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751983984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHgoV1J57kxgaPxatKiQwpkPJq0wS14OFtwNdQBZLYI=;
	b=ogUOJPh2phW8rRkZiDPVUySob0EeiFY37jzsRhS9zbj6BfCghW3oj4Cj09whsGdywKFMQN
	21HB/lw8zNfC1liuLPbeiVv0mF0dv2opleJFBIx3twZ0hxKRSo7oGzH7umad8Zeji/OEi9
	8c6R+j58lxFkhv1ewI8iaHEQ8mGjKF5AZIVKVz190kkrxaP4PdmQdcdhdYsHbl9k/D+MbZ
	b7hur0wSBM8plY6vNg04QbKvNtAK5sn56dFWtaANCK9zypcan2upsrR6xiArXZVQgaNEJg
	ko2rklFYR6LMhQZVTRN8J4H3IK0FLo30rKSuCTvAkpubX+BD1fH6zwamQttWeg==
Date: Tue, 8 Jul 2025 16:13:00 +0200
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
Subject: Re: [PATCH net-next 1/3] net: netdevsim: Add PHY support in
 netdevsim
Message-ID: <20250708161300.53e96d47@fedora>
In-Reply-To: <c6685b48-b525-47bd-8364-a26d787b1e3a@lunn.ch>
References: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
	<20250702082806.706973-2-maxime.chevallier@bootlin.com>
	<c6685b48-b525-47bd-8364-a26d787b1e3a@lunn.ch>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepledtrdejiedriedvrddujedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdejiedriedvrddujedupdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoo
 hhtlhhinhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Andrew,

On Tue, 8 Jul 2025 16:01:06 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static int nsim_phy_state_link_set(void *data, u64 val)
> > +{
> > +	struct nsim_phy_device *ns_phy = (struct nsim_phy_device *)data;
> > +
> > +	ns_phy->link = !!val;
> > +
> > +	phy_trigger_machine(ns_phy->phy);
> > +
> > +	return 0;
> > +}
> > +
> > +static int nsim_phy_state_link_get(void *data, u64 *val)
> > +{
> > +	struct nsim_phy_device *ns_phy = (struct nsim_phy_device *)data;
> > +
> > +	*val = ns_phy->link;
> > +
> > +	return 0;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(nsim_phy_state_link_fops, nsim_phy_state_link_get,
> > +			 nsim_phy_state_link_set, "%llu\n");
> > +
> > +static void nsim_phy_debugfs_create(struct nsim_dev_port *port,
> > +				    struct nsim_phy_device *ns_phy)
> > +{
> > +	char phy_dir_name[sizeof("phy") + 10];
> > +
> > +	sprintf(phy_dir_name, "phy%u", ns_phy->phy->phyindex);
> > +
> > +	/* create debugfs stuff */
> > +	ns_phy->phy_dir = debugfs_create_dir(phy_dir_name, port->ddir);
> > +
> > +	debugfs_create_file("link", 0600, ns_phy->phy_dir, ns_phy, &nsim_phy_state_link_fops);  
> 
> Maybe this can be converted into:
> 
> debugfs_create_bool("link", 0600, ns_phy->phy_dir, &ns_phy->link);
> 
> You loose the phy_trigger_machine(), but that might actually be
> good. PHYs are async to any operation you take on them. It can take up
> to 1 second due to the polling before any change is reported. So any
> user space tools which expect an immediate state change are broken. So
> leaving the PHY state machine to poll the PHY to notice the link has
> changed is a better simulation.

That's true indeed... Simpler and more accurate, I'll add that in V3.

Thanks for the feedback :)

Maxime


