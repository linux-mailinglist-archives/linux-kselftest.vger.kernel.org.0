Return-Path: <linux-kselftest+bounces-36820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE43AFE7E2
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 13:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654774A7911
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAC82D3A86;
	Wed,  9 Jul 2025 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OtIZDkm3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B6293C57;
	Wed,  9 Jul 2025 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060908; cv=none; b=ix0LkKKWue2HEPRsrC22Gf/VQItzx8phrW/F/Tz49Yd3gdjgb3gKJjjXzwH87Y8bTF3Y8D7fZmS+YEU9ohEcjqxPApj5MFO4qjn7YS9lc+s/2duAv9SnPOgK6NcKaPRF9SHAVLx8fXf5xh4OsmKoefauNDcPuChvOqygqZVw2+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060908; c=relaxed/simple;
	bh=oblwm8tMGNrZF5HFXoNDxy5pPBMbR1TevhAMMCwDFj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/SWBYur/4rWD2RJGwI+vbL/sShV0c+9UT6nuFJZioWqh1IOWDCpGtq/5zCJuGDOAKNCNv4QQYh8tyRuoC8Z/61QRanFTuL07zRuA69piQXTP6w8CG3WFKiwa24+UNMFQyexpcZwAmPbHFg8eiQsGgsuZ6DdfwiPFbvcDitSvzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OtIZDkm3; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 713EA449D6;
	Wed,  9 Jul 2025 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752060898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fg+lF8iCUctj//lCFSpvYMAI+SIBkJhPfi7cfKPHguU=;
	b=OtIZDkm3ZbnfELbWNy5PaHZUrLwjjYGRrP0yT4tEpIrTnwP29OLeG0wFC5/lwDSbb+LA8u
	siBCHRXdNP7JkSSJxfFhZHWKoJXu7JaRLvqxZD6BueETrv4RJe9iCQf57PKbPBxsDxVIlL
	/r4z5u8Dt/ZrD+2s4hOrFL9HQAKSStUt5x79BNFMsvCSi/8J0qOoqviRACm0e17KyF5OSg
	VjC+Tn+Gkims3XUcQNrlS52diOLCnIOH82C4i+ipeEpeUPCsX3MjN1W/kwTqyHAmLc1rcE
	FEGEnvCyF0etkzYqPVUfbCnKB1lnAo2Tej0lq2BCsmznbZYY4v4KjBvCzC3l7w==
Date: Wed, 9 Jul 2025 13:34:56 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: netdevsim: Add PHY support in
 netdevsim
Message-ID: <20250709133456.46a1908e@fedora>
In-Reply-To: <20250708115531.111326-2-maxime.chevallier@bootlin.com>
References: <20250708115531.111326-1-maxime.chevallier@bootlin.com>
	<20250708115531.111326-2-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvl
 hdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm

On Tue,  8 Jul 2025 13:55:28 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> With the introduction of phy_link_topology, we have the ability to keep
> track of PHY devices that sit behind a net_device. While we still can
> only attach one single PHY to a netdev, we can look at all these PHYs
> through netlink, with the ETHTOOL_MSG_PHY_GET command.
> 
> Moreover, netlink commands that are targeting PHY devices also now
> allow specifying which PHY we want to address in a given netlink
> command.
> 
> That whole process comes with its own complexity, and a few bugs were
> dicovered over the months following the introduction of
> phy_link_topology.
> 
> As devices with multiple PHYs are fairly uncommon, testing the corner
> cases of multi-phy setups proves to be difficult.
> 
> To that extent, introduce PHY support in netdevsim. The main goal (for
> now) is not to be able to test PHYlib, but these phy-specific
> netlink interfaces.
> 
> These netdevsim PHYs use a custom phy_driver that relies on
> re-implementing the phy_driver callbacks. In other words, this is not a
> PHY driver that relies on mdio emulation, and will not work with any of
> the genphy helpers.
> 
> The debugfs API for PHY creation and deletion works as follows :
> 
> PHY device creation :
> 
> echo $ID > /sys/kernel/debug/netdevsim/netdevsimXXX/ports/YY/phy_add
> 
> if $ID is 0, then the PHY parent will be the netdev corresponding to the
> port's netdev. The first PHY that is added with the netdev as a parent
> will be attached to the netdev.
> 
> if $ID > 0, the index must correspond to a previously added PHY. This
> allows creating any arbitrary tree of PHYs.
> 
> Upon PHY addition, a phyXX directory will be created, XX being the
> phyindex of the PHY in the topology:
> 
>  [...]/ports/YY/phyXX/
> 
> This directory contains a "link" file, allowing to toggle the virtual
> PHY's link state.
> 
> One can then list the PHYs with "ethtool --show-phys ethX".
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/netdevsim/Makefile    |   4 +
>  drivers/net/netdevsim/dev.c       |   2 +
>  drivers/net/netdevsim/netdev.c    |   8 +
>  drivers/net/netdevsim/netdevsim.h |  25 ++
>  drivers/net/netdevsim/phy.c       | 398 ++++++++++++++++++++++++++++++
>  5 files changed, 437 insertions(+)
>  create mode 100644 drivers/net/netdevsim/phy.c
> 
> diff --git a/drivers/net/netdevsim/Makefile b/drivers/net/netdevsim/Makefile
> index f8de93bc5f5b..49f4c515e5e3 100644
> --- a/drivers/net/netdevsim/Makefile
> +++ b/drivers/net/netdevsim/Makefile
> @@ -21,3 +21,7 @@ endif
>  ifneq ($(CONFIG_MACSEC),)
>  netdevsim-objs += macsec.o
>  endif
> +
> +ifneq ($(CONFIG_PHYLIB),)
> +netdevsim-objs += phy.o
> +endif
> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> index b3647691060c..1ebb4f5b3bdd 100644
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -1510,6 +1510,7 @@ static int nsim_dev_reload_create(struct nsim_dev *nsim_dev,
>  	devlink = priv_to_devlink(nsim_dev);
>  	nsim_dev = devlink_priv(devlink);
>  	INIT_LIST_HEAD(&nsim_dev->port_list);
> +	INIT_LIST_HEAD(&nsim_dev->phy_list);
>  	nsim_dev->fw_update_status = true;
>  	nsim_dev->fw_update_overwrite_mask = 0;
>  
> @@ -1583,6 +1584,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
>  	nsim_dev->switch_id.id_len = sizeof(nsim_dev->switch_id.id);
>  	get_random_bytes(nsim_dev->switch_id.id, nsim_dev->switch_id.id_len);
>  	INIT_LIST_HEAD(&nsim_dev->port_list);
> +	INIT_LIST_HEAD(&nsim_dev->phy_list);
>  	nsim_dev->fw_update_status = true;
>  	nsim_dev->fw_update_overwrite_mask = 0;
>  	nsim_dev->max_macs = NSIM_DEV_MAX_MACS_DEFAULT;
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index e36d3e846c2d..ff891536f691 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -952,6 +952,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
>  
>  	nsim_macsec_init(ns);
>  	nsim_ipsec_init(ns);
> +	nsim_phy_init(ns);
>  
>  	err = register_netdevice(ns->netdev);
>  	if (err)
> @@ -968,6 +969,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
>  	return 0;
>  
>  err_ipsec_teardown:
> +	nsim_phy_teardown(ns);
>  	nsim_ipsec_teardown(ns);
>  	nsim_macsec_teardown(ns);
>  	nsim_bpf_uninit(ns);
> @@ -1058,6 +1060,7 @@ void nsim_destroy(struct netdevsim *ns)
>  	RCU_INIT_POINTER(ns->peer, NULL);
>  	unregister_netdevice(dev);
>  	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
> +		nsim_phy_teardown(ns);
>  		nsim_macsec_teardown(ns);
>  		nsim_ipsec_teardown(ns);
>  		nsim_bpf_uninit(ns);
> @@ -1098,6 +1101,10 @@ static int __init nsim_module_init(void)
>  {
>  	int err;
>  
> +	err = nsim_phy_drv_register();
> +	if (err)
> +		return err;
> +
>  	err = nsim_dev_init();
>  	if (err)
>  		return err;
> @@ -1124,6 +1131,7 @@ static void __exit nsim_module_exit(void)
>  	rtnl_link_unregister(&nsim_link_ops);
>  	nsim_bus_exit();
>  	nsim_dev_exit();
> +	nsim_phy_drv_unregister();
>  }
>  
>  module_init(nsim_module_init);
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index 809dd29fc5fe..c73d16e67a3c 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -314,6 +314,7 @@ struct nsim_dev {
>  	struct list_head bpf_bound_maps;
>  	struct netdev_phys_item_id switch_id;
>  	struct list_head port_list;
> +	struct list_head phy_list;
>  	bool fw_update_status;
>  	u32 fw_update_overwrite_mask;
>  	u32 max_macs;
> @@ -419,6 +420,30 @@ static inline void nsim_macsec_teardown(struct netdevsim *ns)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_PHYLIB)
> +void nsim_phy_init(struct netdevsim *ns);
> +void nsim_phy_teardown(struct netdevsim *dev);
> +int nsim_phy_drv_register(void);
> +void nsim_phy_drv_unregister(void);
> +#else
> +static inline void nsim_phy_init(struct netdevsim *ns)
> +{
> +}
> +
> +static inline void nsim_phy_teardown(struct netdevsim *ns);

Meh... that's why this fails, stray ';' that slept through the cracks
when building netdevsim with CONFIG_PHYLIB=n ...

I'll address that,

Maxime


