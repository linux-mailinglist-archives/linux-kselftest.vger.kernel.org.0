Return-Path: <linux-kselftest+bounces-37327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2478B05186
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 08:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266E41AA7149
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 06:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2780A2D3757;
	Tue, 15 Jul 2025 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FL3YtFnb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA12D29CD;
	Tue, 15 Jul 2025 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559725; cv=none; b=oPvrweweZvUeO7CZrpA5XOZaM2Dtx3LEz9N8fjLShVPmjeMVZNl9/8wXuLrTB6865idhE8GT+ySG5kKWUMHsGkcJGg66CngR2z+61UcJcQFgyBXohrUq3kde88G8x7/0MFEkyv9w8Dl3WphtMdbi/O0ZlgcHhzhaG9WfKeegWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559725; c=relaxed/simple;
	bh=sHNNy41ZchjJYhjkgZlkZaOxhThztJMGb/eo2DxdCqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLyUvfEhHlub53dQl9oQ/HJ7YLxPNQWLklkD9TFzci5jDyQ6RF0gU+kVMwSAWStJXJ9lqh2X/0Z9VNDokt5j+ldUWSIz4WYLUA8RKDKKUOJBd9pbdz50Xxg2xGN+IIeIsIHfjhqtuDR62gHdz/4c3QkbUUzuwPtzA/Fm2AKNhos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FL3YtFnb; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A220C44A1C;
	Tue, 15 Jul 2025 06:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752559720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tOZktrYT4fpzyCPv7EqQuQ/zV//e8X9GJdSl7TB5LE=;
	b=FL3YtFnbN1gjy9855J0Qbii5j3/f3m9kN0wV4K/I9bvgSG4cJwsDcaKZrM8H4P2xWIVTuw
	/PFKDz4wConScqL1Cv/3kUhiIbLHQYkrhQHxMjYeecubgGW4x2pBsl28cxmePEq9DC9kIo
	MCh+Pknl1cJlb+G+MEFWcRMT9LRP/VEuwST716f6Vqo+USktaZ+M+20/H96wkmYNb5E+Kk
	QTnScV97ODulv7dHlsVBfL5UF0cDn+01fEAxBGVwMm3pOinstlwkJsfJ9VD/t4RtwgMjbt
	Sq75sPbfYdW2sYp4w3SgQ2mYulyfUsKFeW8hI/LtFA76gyu+Ih1J0KQoVrZ/OA==
Date: Tue, 15 Jul 2025 08:08:37 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: netdevsim: Add PHY support in
 netdevsim
Message-ID: <20250715080837.1aa0e9dd@fedora.home>
In-Reply-To: <20250711165541.586f51e8@kernel.org>
References: <20250710062248.378459-1-maxime.chevallier@bootlin.com>
	<20250710062248.378459-2-maxime.chevallier@bootlin.com>
	<20250711165541.586f51e8@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgedtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh

On Fri, 11 Jul 2025 16:55:41 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 10 Jul 2025 08:22:45 +0200 Maxime Chevallier wrote:
> > @@ -1098,6 +1101,10 @@ static int __init nsim_module_init(void)
> >  {
> >  	int err;
> >  
> > +	err = nsim_phy_drv_register();
> > +	if (err)
> > +		return err;
> > +
> >  	err = nsim_dev_init();
> >  	if (err)
> >  		return err;  
> 
> I think you're missing error handling in this function if something
> after drv_register fails.

Ah true... Thanks

> > @@ -1124,6 +1131,7 @@ static void __exit nsim_module_exit(void)
> >  	rtnl_link_unregister(&nsim_link_ops);
> >  	nsim_bus_exit();
> >  	nsim_dev_exit();
> > +	nsim_phy_drv_unregister();
> >  }  
> 
> > +free_mdiobus:
> > +	atomic_dec(&bus_num);
> > +	mdiobus_free(mb->mii);
> > +free_pdev:
> > +	platform_device_unregister(mb->pdev);
> > +free_mb:  
> 
> Others have added netdevsim code so the entire code base doesn't follow
> what I'm about to say, but if you dont mind indulging my personal coding
> style - error handling labels on a path disjoint from the success path
> should be prefixed with err_$first-undo-action. If the error handling
> shares the path with success the label prefix should be exit_$..
> You can look at drivers/net/netdevsim/bpf.c for examples

That's totally fine by me, it makes sense :)

> > +	kfree(mb);
> > +
> > +	return NULL;
> > +}
> > +
> > +static ssize_t
> > +nsim_phy_add_write(struct file *file, const char __user *data,
> > +		   size_t count, loff_t *ppos)
> > +{
> > +	struct net_device *dev = file->private_data;
> > +	struct netdevsim *ns = netdev_priv(dev);
> > +	struct nsim_phy_device *ns_phy;
> > +	struct phy_device *pphy;
> > +	u32 parent_id;
> > +	char buf[10];
> > +	ssize_t ret;
> > +	int err;
> > +
> > +	if (*ppos != 0)
> > +		return 0;
> > +
> > +	if (count >= sizeof(buf))
> > +		return -ENOSPC;
> > +
> > +	ret = copy_from_user(buf, data, count);
> > +	if (ret)
> > +		return -EFAULT;
> > +	buf[count] = '\0';
> > +
> > +	ret = kstrtouint(buf, 10, &parent_id);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	ns_phy = nsim_phy_register();
> > +	if (IS_ERR(ns_phy))
> > +		return PTR_ERR(ns_phy);
> > +
> > +	if (!parent_id) {
> > +		if (!dev->phydev) {
> > +			err = phy_connect_direct(dev, ns_phy->phy, nsim_adjust_link,
> > +						 PHY_INTERFACE_MODE_NA);
> > +			if (err)
> > +				return err;
> > +
> > +			phy_attached_info(ns_phy->phy);
> > +
> > +			phy_start(ns_phy->phy);
> > +		} else {
> > +			phy_link_topo_add_phy(dev, ns_phy->phy, PHY_UPSTREAM_MAC, dev);
> > +		}
> > +	} else {
> > +		pphy = phy_link_topo_get_phy(dev, parent_id);
> > +		if (!pphy)
> > +			return -EINVAL;
> > +
> > +		phy_link_topo_add_phy(dev, ns_phy->phy, PHY_UPSTREAM_PHY, pphy);
> > +	}
> > +
> > +	nsim_phy_debugfs_create(ns->nsim_dev_port, ns_phy);
> > +
> > +	list_add(&ns_phy->node, &ns->nsim_dev->phy_list);  
> 
> No locks needed.. for any of this.. ?

Heh I guess some locking is needed indeed... Let me add that in the
next round...

Maxime

