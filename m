Return-Path: <linux-kselftest+bounces-35719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C2BAE72E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 01:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BED3BC241
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 23:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0825D20D;
	Tue, 24 Jun 2025 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UkgWEuN9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B625C830;
	Tue, 24 Jun 2025 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806442; cv=none; b=D6Q1/L49cvfKJFYpyIbK6rzNZsIEb42Zfs+k99bdXlL++o9GXtcl33d2RZ+uIeYhdyrjC1ZPReVr6FAD2VWCGuSOoalaUYJiX1j+xDduAmHOPggCBX7lt/K/F/yllwXT3MXe7QAqbLgpKY9Vu7IT9gra7FAg9poJ8OBPMcw6MME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806442; c=relaxed/simple;
	bh=ct/IjO2+pf/ZNMC5uB4Q/L6aHydPhAqWOcLNItXVCf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mk70ukeOVyCPNst8SvA4bOT5f3aT5DRq423jfRv5VstJqYE3q9me+Oqe7kGW9NhEF8uQwXdL/p3LT4KmA+dRmzfZxkD6OyBCMwEwstBI/iwoxJNzy50yAdM7/wz27iTJv3W5jwxGg1NxGZ+0n5Lg0xuTU+tlJELGbCy9lfMHw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UkgWEuN9; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1B2F42E77;
	Tue, 24 Jun 2025 23:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750806437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ct/IjO2+pf/ZNMC5uB4Q/L6aHydPhAqWOcLNItXVCf4=;
	b=UkgWEuN9FwTwfURgqOR3X9+6dJ53Nash1PaDbat/IFev3q7g+nnQJAAlWl+kbxcoK1NuD3
	fqJHonSGa7w/Itg4SQW/sdPOJvM2+WEsGFJpso6a5/0dvg6pRzyVCFD/PHiCqWUFjAhWxT
	YYVGmgjq/KGqcPCh2sCtnFAnlLjedvQdaFCOOkINjdproTe9/U8UqOvzs0VVSrDLsxPzeR
	hKYcwOZO1b2S62stI74DmzaqeO3PH0uZCLdIWFX7d79jyBS9n38Dt3bcW8B9JkKejT7YFI
	RpQX2sHLeyD57bodSOVTOd0tmhMgn3GGbaQOdBBDEMmXQPA4a1F4UcTvMc6UZg==
Date: Wed, 25 Jun 2025 01:07:15 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, donald.hunter@gmail.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, andrew@lunn.ch, shuah@kernel.org, sdf@fomichev.me,
 gal@nvidia.com, noren@nvidia.com, ahmed.zaki@intel.com,
 wojciech.drewek@intel.com, petrm@nvidia.com, danieller@nvidia.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 03/10] netlink: specs: ethtool: replace underscores
 with dashes in names
Message-ID: <20250625010715.4cbcae07@kmaincent-XPS-13-7390>
In-Reply-To: <20250624211002.3475021-4-kuba@kernel.org>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-4-kuba@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvuddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmeegjeelfhemlegsleehmeduvggsudemhegrledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemgeejlehfmeelsgelheemudgvsgdumeehrgelvddphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtp
 hhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

Le Tue, 24 Jun 2025 14:09:55 -0700,
Jakub Kicinski <kuba@kernel.org> a =C3=A9crit :

> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen replaces special chars in names)
> but gives more uniform naming in Python.
=20
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

> Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS has=
h")
> Fixes: 46fb3ba95b93 ("ethtool: Add an interface for flashing transceiver
> modules' firmware")=20

Why do you use fixes tag? You are not fixing something broken but standardi=
zing
the python naming.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

