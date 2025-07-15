Return-Path: <linux-kselftest+bounces-37365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A10B062B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 17:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB8017DD73
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF939238176;
	Tue, 15 Jul 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ei0Q77Nd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4E22F767;
	Tue, 15 Jul 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592583; cv=none; b=PDuRlHO4qWvP3MAPV2/1DWoWVueAw2r3iqmmaC4pp/cyqjI7NzWdcS3sqW6vhO01awmMCUkYASowNtd0mfknmTYxorqgt2KJKkzQQX3CJphvQLSE2ZIueDFPZ+6BsFG8Zn1DMRPwgb2tjyzvSOFsbnegJtcVvm6nlhX1EhkfK9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592583; c=relaxed/simple;
	bh=CameZqhyMnF3uRQId02vfWAB7R9WzzSrERV65cZXMhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KS6geIYja8UvyZqPt/siY1Wx8qScp3P8lFJQ2sWtXG73HOhi1AJU/IlYx98YPDY4pPS2/Z2JIKQIvSdawDjLeEmC/Apxv9Q+o6syvMTfqSV0Q2V886d3Fx2qt4s3pAnj/I3mQAEdhYtoAwAsGaIlz5Kc4RF8MQqNKsTDP0IH7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ei0Q77Nd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1s/c5TXLWDQNHvX75HyiTuO0Y3o3f7RT446/8QEJLzU=; b=ei0Q77NdSlcv04akI9/PHYZxPl
	phGogfaZxOD1d/l5qKZOlvfjac1mUJlfPc+z8RASWWqXC4P3251wBKnL22D+hwnuxeJfFxKXcMjqR
	kEv5z5IHC0FokBS+8+ABw/rZuDB0ZdDTtiHUk6eY9xd7mwZW3jkQg5QgM4QG9zDr4RbY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubhO1-001bH9-DY; Tue, 15 Jul 2025 17:16:05 +0200
Date: Tue, 15 Jul 2025 17:16:05 +0200
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
Message-ID: <97a56e9d-6a8e-46b4-9e66-5544b470a270@lunn.ch>
References: <20250710062248.378459-1-maxime.chevallier@bootlin.com>
 <20250710062248.378459-2-maxime.chevallier@bootlin.com>
 <560e7969-b859-45ed-b368-350a62cec678@lunn.ch>
 <20250715080532.07883d74@fedora.home>
 <9c30b1ab-95fe-4238-950e-23bbd1bb1632@lunn.ch>
 <20250715155623.59fbc2c9@fedora.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715155623.59fbc2c9@fedora.home>

> So should we instead move to a netdevsim PHY model where we would
> emulate an mdio bus and use a pure genphy driver instead ?

I think what you have is a good start. It actually requires somebody
who is interesting in testing to take it further. And i doubt a pure
genphy driver is sufficient, i guess it will need a driver specific
for simulation. There is some things you can test via the PHY driver
API, and other stuff you need to emulate registers. So it will end up
with a hybrid of both.

	Andrew

