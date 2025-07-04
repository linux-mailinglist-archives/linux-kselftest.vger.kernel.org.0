Return-Path: <linux-kselftest+bounces-36562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2F7AF93D8
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FA0189D388
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEBD2F85DD;
	Fri,  4 Jul 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1rnLoTG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6371FC3;
	Fri,  4 Jul 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635226; cv=none; b=lANkjEvEJrNGFUsO3WrBgK0VoQ5aW+X5roz2joEOk0Cird4cGD998mm79MMGh//gjNYNqeEIULrHJuDCfuBYC7q1fWKwsVSf1p6n9ouQYmeeER1jRtd8W5SGamN3MX8Nh1OBmKZtGIjSGmV4eG0fdeOfyL3EH62MhjYrZJiSdp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635226; c=relaxed/simple;
	bh=E22YtMZTkR47Wy1MgCwxvROHlw1OXESfmqj7ZX28cqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOMip3DQlVTfvoUP+qbP3RM/cBaARrrovFsbnGVHlZrhXRJNMxPpWnyKvM46AxjRYPMEJ045gDjqR65YkGWZ1AcqRDJLUYlbBz0U/QJIT1EKhcHMT/lUG6mMCV83U+t0I5hb3Y4IAjcWSVOOB3B0GpEejYynLLOvefSNnq8nyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1rnLoTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490C7C4CEE3;
	Fri,  4 Jul 2025 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751635226;
	bh=E22YtMZTkR47Wy1MgCwxvROHlw1OXESfmqj7ZX28cqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1rnLoTGg9cU81lRJDad4WyocHeKRrv6pdAGHIdWLPhBvNyfKGfWXhNojQCHcDlpC
	 8AcoKk25fnpCFr2fcIBNAyFgPF/Z6UQI28e4vzLJhqDsJEhjGstJm/XFHnGP6N8J7a
	 UEtpo4l+YsUUrlg7tFvThQLAF3Y/DgSvRv68J9v1dH8wefeC1OaU4+XwljcBcsRuEA
	 VPYklgFSNxaUCx/Wiy4LuClOhKpIU7QTxbp4/bqfn61Gtj/HzZtbKxthNUFPWBiP42
	 csj7MOMYePlkGbJ/h9Y2YKSg0EdLSnFXv4+DorCR9s9VJWNQXL6wXOtUmDjL/fFpUI
	 Qw1+6Arh/D8ag==
Date: Fri, 4 Jul 2025 14:20:19 +0100
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
Subject: Re: [PATCH net-next 3/3] selftests: ethtool: Introduce ethernet PHY
 selftests on netdevsim
Message-ID: <20250704132019.GM41770@horms.kernel.org>
References: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
 <20250702082806.706973-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702082806.706973-4-maxime.chevallier@bootlin.com>

On Wed, Jul 02, 2025 at 10:28:05AM +0200, Maxime Chevallier wrote:
> Now that netdevsim supports PHY device simulation, we can start writing
> some tests to cover a little bit all PHY-related ethtool commands.
> 
> So far we only test the basic use of "ethtool --show-phys", with :
>  - A simple command to get a PHY we just added
>  - A DUMP command listing PHYs on multiple netdevsim instances
>  - A Filtered DUMP command listing all PHYs on a netdevsim
> 
> Introduce some helpers to create netdevsim PHYs, and a new test file.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Hi Maxime,

We have recently started running shellcheck as part of our CI (NIPA).
Could you do so for the scripts added and modified by this patch?

> ---
>  .../selftests/drivers/net/netdevsim/config    |  1 +
>  .../drivers/net/netdevsim/ethtool-common.sh   | 15 +++++
>  .../drivers/net/netdevsim/ethtool-phy.sh      | 64 +++++++++++++++++++

Should ethtool-phy.sh be added to TEST_PROGS the Makefile in
the same directory?

...

