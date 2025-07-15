Return-Path: <linux-kselftest+bounces-37326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535FEB0512B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 07:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD2C1AA7C37
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 05:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0392620F1;
	Tue, 15 Jul 2025 05:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MCRjH2iv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAB24501A;
	Tue, 15 Jul 2025 05:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558311; cv=none; b=fSC989F5uEy97qO0GiIOL8/YsGgD4MuQBzT8Nkn7q1MX9r+kRYnzy180spxSyicqpjMM/htQ2cpXG36F/e79+FGtPq7aB45Kdanq34DhpCGDj823uYgtjFziboHJBNeg/SAGPdfermnVCRQM3Q8CWWhAZfHzT2xHNA5GEy1k4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558311; c=relaxed/simple;
	bh=9szHCQY3rT3vmVl4mX4u+FByo6rzsAxsYHWiIKk0Skk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVO+ek+DUVJrVaz1hlBfyuVCisBpKO44qUeBthL8leiQLN6xj0/b3o2+gcD3lnuT6szlagJYG1pSU0t07tgNCRCDj9AkjAvFpympd6PlwGa0Ys4SEXCpPG/ebE8ZIqZRbSPQa7QM9b5xKELsbLacvb/ix6Ck+ApcoQ15ymYS4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MCRjH2iv; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88AAE44299;
	Tue, 15 Jul 2025 05:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752558306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpcAUAryQqnJpja2poJMF9++SUKZn3dkdBj4SYa8tRM=;
	b=MCRjH2ivv0evxbjVj/+m51rex4KMtrT7XYvW/sTdd6168sQmcGjfYi0RoFf52+veELkNVV
	/UQTHeuiO4dhUHrVkoCwQwZl2/cqkfDlXmi1OtR/X9TqD+ohChxcO10Bg7mcReku1RIBbW
	JjwrpqsDkVXaEfwxXlUnW9qzGnRZylbw5cpyWn/0gzwETyWtUXPA6KMuNUW/jdX7Rjte3k
	3lRQcW+JxIaO9y9T0UcOJCSbR2plWksGY90yvaACfnHq/5+soMbbL5d4KrJIE21pJBrY5v
	M+IQc226fi+/CaJrkjhYzJspvBR7Kg/a9Zah8TZB4CGyd0f6LE38A1NiMitE+w==
Date: Tue, 15 Jul 2025 07:45:03 +0200
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
Subject: Re: [PATCH net-next v3 3/3] selftests: ethtool: Introduce ethernet
 PHY selftests on netdevsim
Message-ID: <20250715074503.7b5505ce@fedora.home>
In-Reply-To: <20250711165813.02e3cd80@kernel.org>
References: <20250710062248.378459-1-maxime.chevallier@bootlin.com>
	<20250710062248.378459-4-maxime.chevallier@bootlin.com>
	<20250711165813.02e3cd80@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgedtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtp
 hhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh

Hi Jakub,

On Fri, 11 Jul 2025 16:58:13 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 10 Jul 2025 08:22:47 +0200 Maxime Chevallier wrote:
> > +set -o pipefail
> > +
> > +# Check simple PHY addition and listing
> > +
> > +# Parent == 0 means that the PHY's parent is the netdev
> > +PHY_DFS=$(make_phydev_on_netdev "$NSIM_ID" 0)
> > +
> > +# First PHY gets index 1
> > +index=$(ethtool --show-phys "$NSIM_NETDEV" | grep "PHY index" | cut -d ' ' -f 3)
> > +check $? "$index" "1"
> > +
> > +# Insert a second PHY, same parent. It gets index 2.
> > +PHY2_DFS=$(make_phydev_on_netdev "$NSIM_ID" 0)
> > +
> > +# Create another netdev
> > +NSIM_ID2=$((RANDOM % 1024))
> > +NSIM_NETDEV_2=$(make_netdev_from_id "$NSIM_ID2")
> > +
> > +PHY3_DFS=$(make_phydev_on_netdev "$NSIM_ID2" 0);
> > +
> > +# Check unfiltered PHY Dump
> > +n_phy=$(ethtool --show-phys '*' | grep -c "PHY index")
> > +check $? "$n_phy" "3"
> > +
> > +# Check filtered Dump
> > +n_phy=$(ethtool --show-phys "$NSIM_NETDEV" | grep -c "PHY index")
> > +check $? "$n_phy" "2"  
> 
> Not a very strong preference, but I wonder if we should wire up the
> paths to the Python lib for drivers/net/netdevsim and switch to Python?
> It does the setup and cleanup and it gives us direct YNL access.
> More convenient for testing new stuff than jugging ethtool builds..
> But I guess you could argue that testing the CLI is good in itself.

That's totally OK for me, looking at selftests/drivers/net/netdevsim/
it was unclear to me what was the proper way forward.

My python skills are not the best, I'm basically writing C using python
syntax, but I can certainly give that a shot.

Thanks,

Maxime

