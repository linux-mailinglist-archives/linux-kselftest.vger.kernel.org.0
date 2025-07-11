Return-Path: <linux-kselftest+bounces-37173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B84B02816
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 02:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E724E2C3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 23:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAC622579E;
	Fri, 11 Jul 2025 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+jMazXu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABC224AFC;
	Fri, 11 Jul 2025 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278143; cv=none; b=Z4wTIt5Fqvdzqt4mq27vCrzAoV9veX83EOIhRHsSiyCqJCZk87eAmh+hxJGCQ8hPbcxf5Gn1EDi2xrXVlOIhTWArpvyYlycSl3nqRSlkYmWtKqe6DyVcvn8Iccagxcr/RnT+0rmxHay+PQnZvH844Tv6tYYMW/WQq5E75+h42gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278143; c=relaxed/simple;
	bh=agC97SuzfuoGpmFEeAGfsfWb9Zbkh2hZUVa2ZICQfgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpfdgKPpC8CIWEWVA3TvNnkbEs3Kd246AelpOFCfv37W/cDJGTIXnhZXpBr3aHYdseRSx2HTH5XSLKXFvO+a+7cKnpBQF9WAEACuOGdLBzW4QIQCCR/0GzbRBghY83bmnhx7zcG3vB2MzmI5Hgpj/HDQpcud28MYqHdLdrpoNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+jMazXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6682C4CEED;
	Fri, 11 Jul 2025 23:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752278142;
	bh=agC97SuzfuoGpmFEeAGfsfWb9Zbkh2hZUVa2ZICQfgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V+jMazXuc42rPHB+RgmnSUt3K5cOgrTcf43wY3sNYkb1s5uEPc+2N+kGBERVFHSuB
	 XNfrebw1pzmX8ip5wm/BDOONVb9VadiSWGj4KXc4EQfN4BUm08ee95IX+CLAyWCB43
	 MMCFf6Tfru8hFdc7ydemHHLrGguJ9SeIM5upbiksCHwLj6V9USlT29ObzrE2/3XrNF
	 2B28AucdTY7gbWKwOWL8Z90jZPKuyjT/Qe46w930TTyRpGohxbdCMSX5U0f1FJr0Yh
	 vdnpGYkSzBNxJXVyfv63oLoQfE9shUxd3vaXeN4LUHNv3a6ilfMTd413U5P7RmnAHS
	 bO3T0IT76DHMQ==
Date: Fri, 11 Jul 2025 16:55:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
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
Message-ID: <20250711165541.586f51e8@kernel.org>
In-Reply-To: <20250710062248.378459-2-maxime.chevallier@bootlin.com>
References: <20250710062248.378459-1-maxime.chevallier@bootlin.com>
	<20250710062248.378459-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 08:22:45 +0200 Maxime Chevallier wrote:
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

I think you're missing error handling in this function if something
after drv_register fails.

> @@ -1124,6 +1131,7 @@ static void __exit nsim_module_exit(void)
>  	rtnl_link_unregister(&nsim_link_ops);
>  	nsim_bus_exit();
>  	nsim_dev_exit();
> +	nsim_phy_drv_unregister();
>  }

> +free_mdiobus:
> +	atomic_dec(&bus_num);
> +	mdiobus_free(mb->mii);
> +free_pdev:
> +	platform_device_unregister(mb->pdev);
> +free_mb:

Others have added netdevsim code so the entire code base doesn't follow
what I'm about to say, but if you dont mind indulging my personal coding
style - error handling labels on a path disjoint from the success path
should be prefixed with err_$first-undo-action. If the error handling
shares the path with success the label prefix should be exit_$..
You can look at drivers/net/netdevsim/bpf.c for examples

> +	kfree(mb);
> +
> +	return NULL;
> +}
> +
> +static ssize_t
> +nsim_phy_add_write(struct file *file, const char __user *data,
> +		   size_t count, loff_t *ppos)
> +{
> +	struct net_device *dev = file->private_data;
> +	struct netdevsim *ns = netdev_priv(dev);
> +	struct nsim_phy_device *ns_phy;
> +	struct phy_device *pphy;
> +	u32 parent_id;
> +	char buf[10];
> +	ssize_t ret;
> +	int err;
> +
> +	if (*ppos != 0)
> +		return 0;
> +
> +	if (count >= sizeof(buf))
> +		return -ENOSPC;
> +
> +	ret = copy_from_user(buf, data, count);
> +	if (ret)
> +		return -EFAULT;
> +	buf[count] = '\0';
> +
> +	ret = kstrtouint(buf, 10, &parent_id);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ns_phy = nsim_phy_register();
> +	if (IS_ERR(ns_phy))
> +		return PTR_ERR(ns_phy);
> +
> +	if (!parent_id) {
> +		if (!dev->phydev) {
> +			err = phy_connect_direct(dev, ns_phy->phy, nsim_adjust_link,
> +						 PHY_INTERFACE_MODE_NA);
> +			if (err)
> +				return err;
> +
> +			phy_attached_info(ns_phy->phy);
> +
> +			phy_start(ns_phy->phy);
> +		} else {
> +			phy_link_topo_add_phy(dev, ns_phy->phy, PHY_UPSTREAM_MAC, dev);
> +		}
> +	} else {
> +		pphy = phy_link_topo_get_phy(dev, parent_id);
> +		if (!pphy)
> +			return -EINVAL;
> +
> +		phy_link_topo_add_phy(dev, ns_phy->phy, PHY_UPSTREAM_PHY, pphy);
> +	}
> +
> +	nsim_phy_debugfs_create(ns->nsim_dev_port, ns_phy);
> +
> +	list_add(&ns_phy->node, &ns->nsim_dev->phy_list);

No locks needed.. for any of this.. ?
-- 
pw-bot: cr

