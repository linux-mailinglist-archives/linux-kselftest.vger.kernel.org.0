Return-Path: <linux-kselftest+bounces-36564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9AAAF943F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9865E1693AC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B312F85FC;
	Fri,  4 Jul 2025 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pF54Zabe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5932D5C67;
	Fri,  4 Jul 2025 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635981; cv=none; b=IB6eT4BtngqRee824OHQ/fd9oXzmF4ZZJ8QxM2f5K9kVyhq8knWD1JUPbwWcYWiAwJwWksP/+/WsKTcr6Om0lUwFs6ZL9w+xLKUrEYk3HaBVNAsd6ehdQmjUnnm3r4j8NjkIytAf1ORTbRKXccVNBDWNI5CNRyy7eRB4ahbg4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635981; c=relaxed/simple;
	bh=ZNiYpFPz0MTrBUKkxiacvU3OH5FaFqbvURFWrhZVIQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwlkSBnSrqmUKSml1Ba05G9r8tpF89zJGtbavRk4tDYMC7TB4alGcdtXnzvSXJyYjp+PdIdQGmL3sixUwCxn6TSOw/vfXDxwejsNUAAlOuv0ibVzQSFj16NVAe93dIEeusw4ymjWnAMFbstShwxp/2x+7J+xcqw+exyCYI3O1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pF54Zabe; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F351444304;
	Fri,  4 Jul 2025 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751635975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQdyVc1Nt+DZCPgyJ1ee7bBq0GR3KHn8pgte7or1P7M=;
	b=pF54ZabevbwtFQ9u5lw2mSb54vxexY219ycj27JXahiwYZJIv2n4ZL3PsbGcaL8+MbkkwU
	ja2Y5jRFA16V/TjQJ44OHiAZJHN5Hcvui+i521GiPSTh2fWrBWNakm/hiuSnu4BElPCeLq
	UktrEQnVSq30LvKj0OjEosYrBdkUQrct+ibaf7IopgqdDM86fQChPr44Mefjwg0RBZ6Lmz
	LhTEw9vQ9FKH2++5Bbck8TzNA+WV2l4oMRdd9PjYI1bfXlUWzV572EJbsO9asjL9GUZoHP
	9mDHBH79D7KpgU56nV2NR8adtvYDHS5ovZaMw1bNehubuaYlugfGguvOKZxnlg==
Date: Fri, 4 Jul 2025 15:32:50 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: ethtool: Introduce ethernet PHY
 selftests on netdevsim
Message-ID: <20250704153250.6ec18427@fedora.home>
In-Reply-To: <20250704132019.GM41770@horms.kernel.org>
References: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
	<20250702082806.706973-4-maxime.chevallier@bootlin.com>
	<20250704132019.GM41770@horms.kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfedvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 4 Jul 2025 14:20:19 +0100
Simon Horman <horms@kernel.org> wrote:

> On Wed, Jul 02, 2025 at 10:28:05AM +0200, Maxime Chevallier wrote:
> > Now that netdevsim supports PHY device simulation, we can start writing
> > some tests to cover a little bit all PHY-related ethtool commands.
> > 
> > So far we only test the basic use of "ethtool --show-phys", with :
> >  - A simple command to get a PHY we just added
> >  - A DUMP command listing PHYs on multiple netdevsim instances
> >  - A Filtered DUMP command listing all PHYs on a netdevsim
> > 
> > Introduce some helpers to create netdevsim PHYs, and a new test file.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>  
> 
> Hi Maxime,
> 
> We have recently started running shellcheck as part of our CI (NIPA).
> Could you do so for the scripts added and modified by this patch?

Sure thing, I'll do that :)

> 
> > ---
> >  .../selftests/drivers/net/netdevsim/config    |  1 +
> >  .../drivers/net/netdevsim/ethtool-common.sh   | 15 +++++
> >  .../drivers/net/netdevsim/ethtool-phy.sh      | 64 +++++++++++++++++++  
> 
> Should ethtool-phy.sh be added to TEST_PROGS the Makefile in
> the same directory?

Ah yes I forgot that. So any file in that TEST_PROGS list will end-up
being run in NAPI tests ?

Maxime

