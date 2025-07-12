Return-Path: <linux-kselftest+bounces-37192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D884B02C06
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 18:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD39A6038C
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619582882B7;
	Sat, 12 Jul 2025 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="corG6KK+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE619DF60;
	Sat, 12 Jul 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752339293; cv=none; b=ScQj0ummtjCOaY0k2VfFvTWTnaYr8NYbgptdGNV+WxkbcutrvUsWXkQ+O2EL3rIlpcRl5zAGW3R17my934ytHWHmGn2qxXRISkgiQBMidTYaWri+bTRCID22igP/VHbp/u7f6Xm81N1gI8Tf0yKHOdFmXMUcEU+bLW32mLkwtnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752339293; c=relaxed/simple;
	bh=7ulItuDfjo0fn2spkVsfqLm+frVP3gh8Mp2EkflyQ+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn9X7SorsiYu5EpwvKoNUlG5Egene5Sg1IEPiCe+Q0IptuUkf6NOcac8xGfNQBx2VenMbkc3bLdErMrYcKsmgC+R8sJu5GQKEu/qy+SjJFerlx2qb6VGXH374KR/IeC8ZwDv3YMs0Uec2vXBHn7u5f4Z1Nxl1nc2kMsaM+oyof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=corG6KK+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u7JZxNPnwYbwyAWArXhk9IJzZ+TGZ4/LK+Ux1qSIQMQ=; b=corG6KK+bALYtQfb4jLjqXA+J+
	/KMHP1asfC5K1q/Rod527h1tEiV1a8m4/MMK2s+S/u/9fbk1Tu+PnV03YhDT/6jMSgmZiUXjlTpKz
	EuB2b4QfdORml3EeArXyJlUL7PWdrW6LF8BAzu4UGMXFM6loNUW5oRgqYfdRfEOgPww8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uadUk-001JnS-SD; Sat, 12 Jul 2025 18:54:38 +0200
Date: Sat, 12 Jul 2025 18:54:38 +0200
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
Message-ID: <560e7969-b859-45ed-b368-350a62cec678@lunn.ch>
References: <20250710062248.378459-1-maxime.chevallier@bootlin.com>
 <20250710062248.378459-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710062248.378459-2-maxime.chevallier@bootlin.com>

> +static int nsim_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
> +{
> +	return 0;
> +}
> +
> +static int nsim_mdio_write(struct mii_bus *bus, int phy_addr, int reg_num,
> +			   u16 val)
> +{
> +	return 0;
> +}

If i'm reading the code correctly, each PHY has its own MDIO bus? And
the PHY is always at address 0?

Maybe for address != 0, these should return -ENODEV?

I'm guessing the PHY core is going to perform reads/writes for things
like EEE? And if the MAC driver has an IOCTL handler, it could also do
reads/writes. So something is needed here, but i do wounder if hard
coded 0 is going to work out O.K? Have you looked at what accesses the
core actually does?

     Andrew

