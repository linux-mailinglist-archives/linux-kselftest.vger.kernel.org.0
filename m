Return-Path: <linux-kselftest+bounces-37174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFFCB02820
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 02:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777AD4E0CA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 23:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FE7232785;
	Fri, 11 Jul 2025 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFhVLo75"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE622AE65;
	Fri, 11 Jul 2025 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278295; cv=none; b=R5TsMfaM9ckU1dzv8wSmpsE6OrhezljxJu/JzeyntHXumvVe9w9+Kv3mHAHfzme9xRuMgoRiQyBma4r3denfa7bVPyWe8C3DMCYXSO/M0uVOlSSzJeuNWV1tKTq+2+880AVHxY1Ye8dIkOaTUiERuQLvdaINXqOosXnFh9C8gEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278295; c=relaxed/simple;
	bh=jQ24sF1DB0RQpo5RAA5N57Tub4LSjckrJoBWCUmTlMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxGGUw5cf+v/Nx3af6m7stJBfcYA7r8rtxPTMDM0BD7xBqpPpxiMi1mscnd9/SQpziIgXfDkgj21BneDF4qllEeCaTU2V9H9Y3CVfWKjN2PLAvS0SMkL1pqwdtZWnHM0AdU4CUePO+P6V1WqIHiP2nju/Vx8w51ETmvTJws6ql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFhVLo75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B815EC4CEED;
	Fri, 11 Jul 2025 23:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752278295;
	bh=jQ24sF1DB0RQpo5RAA5N57Tub4LSjckrJoBWCUmTlMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KFhVLo75TYq8KRwztEHGeZITwS6aLAn4GsuKHAOH+0eory693hxIy77C88cVY6mHJ
	 1EBfMtanSr/0oXmX2Ruuqp9jlwrRE1N7hHkTAsHVU0eEQ7yE8AcQC6363wIgP+5wBJ
	 VwslvuefdI6jTJ73hYYm2bl4fJIJ/0N9UILprSvp334gjGCbkkMPtdx4AryPCiwDeM
	 oUBTEYWXiqllymowlCLR7DJBzIpxYMqqGkom6U6ZXMG7HPQgO54w4CqPiTGVVIokig
	 APw5iofoGUlWpaIB8ZzavnFaX9inFashtEXY0inl24PHRECzP8LdbcbSyWm/41Ry57
	 BWJrBzQAxIaSw==
Date: Fri, 11 Jul 2025 16:58:13 -0700
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
Subject: Re: [PATCH net-next v3 3/3] selftests: ethtool: Introduce ethernet
 PHY selftests on netdevsim
Message-ID: <20250711165813.02e3cd80@kernel.org>
In-Reply-To: <20250710062248.378459-4-maxime.chevallier@bootlin.com>
References: <20250710062248.378459-1-maxime.chevallier@bootlin.com>
	<20250710062248.378459-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 08:22:47 +0200 Maxime Chevallier wrote:
> +set -o pipefail
> +
> +# Check simple PHY addition and listing
> +
> +# Parent == 0 means that the PHY's parent is the netdev
> +PHY_DFS=$(make_phydev_on_netdev "$NSIM_ID" 0)
> +
> +# First PHY gets index 1
> +index=$(ethtool --show-phys "$NSIM_NETDEV" | grep "PHY index" | cut -d ' ' -f 3)
> +check $? "$index" "1"
> +
> +# Insert a second PHY, same parent. It gets index 2.
> +PHY2_DFS=$(make_phydev_on_netdev "$NSIM_ID" 0)
> +
> +# Create another netdev
> +NSIM_ID2=$((RANDOM % 1024))
> +NSIM_NETDEV_2=$(make_netdev_from_id "$NSIM_ID2")
> +
> +PHY3_DFS=$(make_phydev_on_netdev "$NSIM_ID2" 0);
> +
> +# Check unfiltered PHY Dump
> +n_phy=$(ethtool --show-phys '*' | grep -c "PHY index")
> +check $? "$n_phy" "3"
> +
> +# Check filtered Dump
> +n_phy=$(ethtool --show-phys "$NSIM_NETDEV" | grep -c "PHY index")
> +check $? "$n_phy" "2"

Not a very strong preference, but I wonder if we should wire up the
paths to the Python lib for drivers/net/netdevsim and switch to Python?
It does the setup and cleanup and it gives us direct YNL access.
More convenient for testing new stuff than jugging ethtool builds..
But I guess you could argue that testing the CLI is good in itself.

