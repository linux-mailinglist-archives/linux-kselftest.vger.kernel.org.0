Return-Path: <linux-kselftest+bounces-36819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D05FAFE77D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 13:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD497B4AE4
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A316D29009A;
	Wed,  9 Jul 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AwbJ+PTV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B3228F524;
	Wed,  9 Jul 2025 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059974; cv=none; b=Ivan6aa7TRAAjPcOJrkRDvJJhGvkuZVk0v6XRFujkV/SGgL+lIm+EtySYt8qVE/vIh6x7tHGsB5V95WzGjAp6dCURlR7wiakj2iPrDPIX4fv0/tHARxmICA617DCSCto6Q1idshWts6Db2qmWs4ZTBqxY2j15wbGgRSVbhWNKRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059974; c=relaxed/simple;
	bh=URnW/UGiKI1+mA6CAcMxYpU7wlYxklb25J02kMDL3zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NA5DwDtq8rfX7vdM9J9Z4zcUiYVVwUnegj/QL5CCcn+ZqX+OH9UT7HD0ytmA9fg/YwUHik6JHcDv1OHOvAHYmhSkoe6NiJ+A7w7EsSjGgLfu4yHrstKkvGfj3WZbsnkfQSuIbGtJtWAqRLWGsvVrVNI6BIgVCT/R3qun1LWp9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AwbJ+PTV; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05BB443A20;
	Wed,  9 Jul 2025 11:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752059964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iCHLPtESbfpbp85kiNVyKFls4xs+R9n/2d/k55Cwns=;
	b=AwbJ+PTVYd2d5MaeWRbLOdvxyos7ExIxXuCwC6KtnHyPgdYpbhNTG8RwF9J5LPbtOa9NPC
	zugXTh7WYqh12Yhn6lp8so3m8rHWEflOcTxD0KxXcmypykt3lJ8VO+osOiHUYZsVEq3yqO
	XO7BTvS/cX5tIYWYbvphJKk2ZL9yfv2E3QBCjeKVYv/uW3dNNZZcVyyZcmtbhOs4Mx5WUP
	gqxW3gp5oGxq0xEN1126CNgHwhya3geKrM+gR14FLXoJ0N7Oj0NHN6cRjWrvbBYouQgLHk
	b3zK164yNShj1QNTCbi5hskukGohl/5ddw9GdeqJwnKfCOvsl7yUyUghGaQdcQ==
Date: Wed, 9 Jul 2025 13:19:21 +0200
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
Subject: Re: [PATCH net-next v2 0/3] netdevsim: add support for PHY devices
Message-ID: <20250709131921.20e77cde@fedora>
In-Reply-To: <20250708135553.7fb9eeac@kernel.org>
References: <20250708115531.111326-1-maxime.chevallier@bootlin.com>
	<20250708135553.7fb9eeac@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgfejgeegheeitefgleehgeejiedvheefudelhfeijedutdeihfeijeetgfegfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrr
 dhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue, 8 Jul 2025 13:55:53 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue,  8 Jul 2025 13:55:27 +0200 Maxime Chevallier wrote:
> > Here's a V2 for the netdevsim PHY support, including a bugfix for
> > NETDEVSIM=m as well as a round of shellcheck cleanups for
> > ethtool-phy.sh.
> > 
> > The idea of this series is to allow attaching virtual PHY devices to
> > netdevsim, so that we can test PHY-related ethtool commands. This can be
> > extended in the future for phylib testing as well.  
> 
> Appears to break the build for BPF CI:
> 
> https://github.com/kernel-patches/bpf/actions/runs/16150854854/job/45581507731

aw :( I'll follow-up on that then, sorry :(

Maxime

