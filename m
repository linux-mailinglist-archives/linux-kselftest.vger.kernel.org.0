Return-Path: <linux-kselftest+bounces-37329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61592B051D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 08:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE524E203D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 06:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF841262FD2;
	Tue, 15 Jul 2025 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VkJuX+M2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74014B672;
	Tue, 15 Jul 2025 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561238; cv=none; b=R64eqBFUFXtOicstF0q9lZmB36aMNTAUZGXBYe8v+MlydeOLr3q8Jphso521mbi2xLmKLiYXTpJ0dL76LHoYnEQh2KPo4PfcPoVjhxmq0M8RdY5a7YRpu94d2HbPKzVx3m/Dh3bOHK3JOJEiYnoPZqOmSOmdFCdxBetmpegcai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561238; c=relaxed/simple;
	bh=WC45c/DnzmSKE85Z1Qai86T8LgFzFt5mXdfv7rXwSO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVOcVpYxzLANZk2/YmVgVR+5mi1e+XHmBPKc4WxQieqpUXA/vXdye58fszg3WhXF52SsMoFHNtm0njD9iev4TKCv367itgrUHCCzzgk/rLQ87zJ4V2O+eM1lH1gbmoAnYosUJgekO2qXxQxoEbuN+yhySycqrUqfekwfg6B+5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VkJuX+M2; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id C11B8587043;
	Tue, 15 Jul 2025 06:05:42 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A02E44354;
	Tue, 15 Jul 2025 06:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752559535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vRRRofKzYTk4D1n78QDRieI6X+rxdAzS6AVWnX1z1A=;
	b=VkJuX+M2u8O9YDU70VOX5FCojosBhI8llh9v5jiH+jd27KMO5RVflqQX+rDLZmZmOptQIB
	S04bNJ5t/QKOVxc+qJ6hAoJ09ZMl4nvxEHmQQ7n32u0IoEGKdj1j155KJnHfbVxFUf6vku
	S6Fadh5pANHce0LFYSpI8KTZ+HWb1agKX8jbACJjR44yrzCcD+t83r9oI8fl7xMFrKSr6V
	ioZZ0nEpQBR+nwEDnuVEX1KOQD29IBRa4oioNTeniKDxizJffYOJwWaapVJ0I1q/1mWXlF
	pRpMroalkrMQfOWbBfxaGXZ+WG8w83j1Myw+WAAdqtghs6vVnvhCjhw5JX/B+g==
Date: Tue, 15 Jul 2025 08:05:32 +0200
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
Subject: Re: [PATCH net-next v3 1/3] net: netdevsim: Add PHY support in
 netdevsim
Message-ID: <20250715080532.07883d74@fedora.home>
In-Reply-To: <560e7969-b859-45ed-b368-350a62cec678@lunn.ch>
References: <20250710062248.378459-1-maxime.chevallier@bootlin.com>
	<20250710062248.378459-2-maxime.chevallier@bootlin.com>
	<560e7969-b859-45ed-b368-350a62cec678@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgedtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevieevgeehgfekgedtledvleeuieelheegiefftdeuhfelvddufeelheegteevgeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Sat, 12 Jul 2025 18:54:38 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static int nsim_mdio_read(struct mii_bus *bus, int phy_addr, int reg_n=
um)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int nsim_mdio_write(struct mii_bus *bus, int phy_addr, int reg_=
num,
> > +			   u16 val)
> > +{
> > +	return 0;
> > +} =20
>=20
> If i'm reading the code correctly, each PHY has its own MDIO bus? And
> the PHY is always at address 0?

Yes indeed.=20

> Maybe for address !=3D 0, these should return -ENODEV?

That could be done yes, but I don't think this will ever happen as this
is only ever going to be used in netdevsim, which also controls the PHY
instantiation. I'm OK to add the ENODEV though :)

For the record, the first draft implementation I had locally used a
single MDIO bus on which we could register up to 32 netdevsim PHYs, but
that wasn't enough. At some point Jakub pointed me to the case of
netlink DUMP requests that would be too large to fit in a single
netlink message (default threshold for that is > 4K messages), so to
test that with the phy_link_topology stuff, I had to add around 150
PHYs...

> I'm guessing the PHY core is going to perform reads/writes for things
> like EEE? And if the MAC driver has an IOCTL handler, it could also do
> reads/writes. So something is needed here, but i do wounder if hard
> coded 0 is going to work out O.K? Have you looked at what accesses the
> core actually does?

I don't see that driver being useful outside of netdevsim, so at
least we have a good idea of what the MAC driver will do.

There'e no ioctl, but we can be on the safe side and stub it a bit more.

=46rom the tests I've been running, I didn't encounter any side-effect
but I only tested very simple cases (set link up, run ethtool, etc.)

I've considered re-using swphy for example, and using an emulated MDIO
bus for netdevsim PHY, but my fear was that this would in the end get
too complex. Let's say we want to add a new netdevsim debugfs
file that allows us to control what is the speed reported by the phy,
if we want to report say 10G speeds, we also need to emulate C45, etc.

I guess at some point, we will run into scenarios where phylib is going
to call some genphy helpers, it really depends on how deep we want to go
with this netdevsim PHY driver.

The use-cases that I saw were :
 - Being able to test the netlink stuff now that we have the ability to
know which PHY handles which command
 - In the future, write some tests for the linkmode reporting (that I
broke once with phy_caps)
 - When PHY Muxes eventually get there, I'd also like to netdevsim
that.

However that's just my view of the thing, we could also consider having
this driver rely purely on MDIO emulation, where the MDIO registers
would behave exactly as specified in C22/C37/C45, but that's quite more
complex :)

I'm open for any improvement or ideas on that driver :)

>      Andrew

Thanks for the review,

Maxime

