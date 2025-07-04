Return-Path: <linux-kselftest+bounces-36551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9CFAF92FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 14:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E875417E44B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B382D877B;
	Fri,  4 Jul 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXsQpX3y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3B42A83;
	Fri,  4 Jul 2025 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633024; cv=none; b=FD8I39rfzju/Sv1zEPfPQLqnJpP7cqveBBeOw2dR9ewCNFnEP+c5Z9PwNu1Q7l+FOOLlx2DLwQyHMi6EJVWIQ08XxftdzeBZCIO0VPRiakfjHqvos8QogUN8E2RaGUDFsYyWJouiucXJ0oDuaLn/8JcYJTAKhM0w4Rm39eANkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633024; c=relaxed/simple;
	bh=eMQ+vuj8cnqgAD61qQL9Xv3L1YC9JxKRmpAihsA5tM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt0KhQS2ddIvzC7cFZk4ITDi7NItXz44RQMgwqFhz2IbGFmYGU4HkDCRrnTSeD51WA2wcf4kX8WaK+HSPtbDGluvdqksMu09jEhiY3qcvyOFPtN8rw/gKVATYF/BnQJldNWoJI4C/CRJCrW8cE7yQ62ljz6C8oLe/W2jEDXEaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXsQpX3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D454C4CEE3;
	Fri,  4 Jul 2025 12:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751633023;
	bh=eMQ+vuj8cnqgAD61qQL9Xv3L1YC9JxKRmpAihsA5tM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXsQpX3ymJ3l69NZrjrXRwHu+ZP1PzuMuZI0x6mMcgbf+2sVu3mjLkqHGy+ZDKm8X
	 34ZRPy+4AaZEsRVq9aBgguqrHBhiSPfUNvbERoMQ2mEUo2fgJIiFY5DJse8plRTC+2
	 wAq9LKakOfQugQwJfpz302Xob1aQOxcHJhrSJEZbOr0QaEw5QsGv86FhIOOs4VIPm7
	 /+2HMGTppzg0AYdsWSiiEUw+mxbESmU6ZB+SEdk8GMdePvy96qeEeVLlc01mLjQc+O
	 iq+wnIs9N62yXvgDehxqEH+ptScu2g2hxzxNl4vxxSd8wUMbgYcyJG86vy1udoAawA
	 xTN3YEN8InEMA==
Date: Fri, 4 Jul 2025 13:43:36 +0100
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: netdevsim: Add PHY support in netdevsim
Message-ID: <20250704124336.GL41770@horms.kernel.org>
References: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
 <20250702082806.706973-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702082806.706973-2-maxime.chevallier@bootlin.com>

On Wed, Jul 02, 2025 at 10:28:03AM +0200, Maxime Chevallier wrote:
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

Hi Maxime,

As it seems like there will be a v2 anyway: discovered

> phy_link_topology.

...

> +static struct phy_driver nsim_virtual_phy_drv[] = {
> +	{
> +		.name			= "Netdevsim virtual PHY driver",
> +		.get_features		= nsim_get_features,
> +		.match_phy_device	= nsim_match_phy_device,
> +		.config_aneg		= nsim_config_aneg,
> +		.read_status		= nsim_read_status,
> +	},
> +};
> +
> +module_phy_driver(nsim_virtual_phy_drv);

I see that this has been flagged by Kernel Test Robot,
but as I had already written most of this it seems worth sending anyway.

I am somewhat guessing at the why here, but
I see build failures with this patch applied:

ld: drivers/net/netdevsim/phy.o: in function `phy_module_init':
phy.c:(.init.text+0x0): multiple definition of `init_module'; drivers/net/netdevsim/netdev.o:netdev.c:(.init.text+0x0): first defined here
ld: drivers/net/netdevsim/phy.o: in function `phy_module_exit':
phy.c:(.exit.text+0x0): multiple definition of `cleanup_module'; drivers/net/netdevsim/netdev.o:netdev.c:(.exit.text+0x0): first defined here

I am guessing that this is because above module_phy_driver() will define
init_module and phy_module_exit functions.  But the following lines near
the end of drivers/net/netdevsim/netdev.c also define functions with those
names.

module_init(nsim_module_init);
module_exit(nsim_module_exit);

...

