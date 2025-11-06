Return-Path: <linux-kselftest+bounces-45023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E69C3CCB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 18:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47F4188C419
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597D234DB53;
	Thu,  6 Nov 2025 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PtsuK0f3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2I7NVcIl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09912C0F96;
	Thu,  6 Nov 2025 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449731; cv=none; b=XdVPVKOMwU+THz2V/wutkJNkY0zZSj7CHucnS7AUmDE6pH8x0+xtuiBV3mSE1Ad8ZgxfSp2mZS+jqFUCJVh/2HC4IpUOrAcubaitWb0wBBgZZLY2s3Pf+lyc02mP4XDrvpqgZMxy8TajLWeB4P3YZqeoFcGf7cxMaTDEA4W5Ink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449731; c=relaxed/simple;
	bh=BVWSmu5KMUgAwmVaEZPq6gthhO/L/UWXLJBrNnPU1UA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UYz40lNisaHI6PlVsTwNAz7ffbrWLGNZZIYhy7snbPA49+2PBxaN/lALsrrka54iteaFpZkrXdkMMewcTIJEB3jiv1KiDQ/LfbirdKnWa8OWbMfd1z40ESoQxrSZ3BPhJsQ5oSqX/vgwoBIk9OLQT67eRu0BF7j4cQbMTnQQqmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PtsuK0f3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2I7NVcIl; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7131AEC025B;
	Thu,  6 Nov 2025 12:22:07 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 06 Nov 2025 12:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762449727;
	 x=1762536127; bh=TQ4GgdM8KMjiFNoveJBSCQRm3uDbF8oZgBhhE89LoX4=; b=
	PtsuK0f319LO45lQah6VIlHKcBebKDpwzs+8+S63Ih2uA1rnN8V+VHZwIo2IR6gE
	UotFl2nTxcby+j5R8f+Vmuhxgv4Hm5O90ixA7ZgJVMPMdu/irmAXQa3pHZxYlZUc
	Y3f3UI4bGgKxUqnYTCJr8stJZjZ49rN3UUh+m/DZ2yRbXZ06n5E35cbZ7jN2ns4R
	YE4x8CAbK0h4ChU4SWLti5Pf+Q+ujzQi+QAQehiYOzJbLeI8TuzyVsoRzZGYGEV2
	A792tJTOa9P3sKs4bNkVl89ferrG8+rQk6iKTByyeeLSfS2GncgY4E+R048EQ6c8
	OuiDEnH515NYfsukF4a9Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762449727; x=
	1762536127; bh=TQ4GgdM8KMjiFNoveJBSCQRm3uDbF8oZgBhhE89LoX4=; b=2
	I7NVcIlWD2z3AfmYy/yeycsO4xGBqfCc1aJomcwzCoFur0AJ2uwG5Pxj9ZVMWP/P
	3fkJnC+MlLYdb1437+n4JwWje2YGCl5TBbkERKxQek8I3DXRTHm2Ov/xL3gU1AUH
	lP25GALiK/8YCJS8GJQMXZISwykI/bvZzMQbD6IqleeaQ1xHQk/pf4XLW8a89ZNv
	OX95Ffje2Bgdlk2/B9QwfyYmnNd/eTvKG06IuZyVGFox9K+C6ON4INyUtY+B4P7i
	/U1aaoL3jCfy65gUg/S0o/6AqzGuFurnw9i9bJjp27E1jQXjw2J61Znbq74l6Sdk
	spCFNTas3qBD8tC8Dw+Jw==
X-ME-Sender: <xms:PNkMaZMO1lPn7wub_x6RJYgXvPR-dmuVBOLe0MmQ3izKbD81hs6pnA>
    <xme:PNkMaWwaT8hRBGLxXu_WTAWlI-HdBAVJFL4oRJhvE5E1lv6zloisZkL9eWoT0SWaT
    IBdHg99pY-IDRQaDME0mJ54bwa48zwh-Mbn5smpD0W0gHaoCVNujIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepkedvuefhiedtueeijeevtdeiieejfeelvefffeelkeeiteejffdvkefgteeuhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeefkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhssghoghgvnh
    gusegrlhhphhgrrdhfrhgrnhhkvghnrdguvgdprhgtphhtthhopegtrghtrghlihhnrdhm
    rghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepvhhinhgtvghniihordhfrhgrsh
    gtihhnohesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrh
    houhhprdgvuhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhr
    tghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtoheprghnug
    hrvggrshesghgrihhslhgvrhdrtghomhdprhgtphhtthhopehnphhighhgihhnsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:PNkMaVUYfrmc5te1EUxSvgQ8TRVDaDGzRierkf5jayA311IlXx5ADA>
    <xmx:PNkMabX_DlTmYrLzD_sdL2tXkJ4F4s076mdaMi8qr6vq8DbuWNylbw>
    <xmx:PNkMaYMfKmo2E2B0ITXYRv6LyemjW9LOLDP3wOmyt7voffmGNPYxVA>
    <xmx:PNkMafizk25mJNDFFaNeFGIdB428VC0-WvGeQMoXVrdUlnXuPgrPYA>
    <xmx:P9kMaUCgmYPQKJzxhj8GAva_-VVQifLJ9oCwH3jMqxAHtW82r16n0xOk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 78838700054; Thu,  6 Nov 2025 12:22:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AisJtzLZ_1Kg
Date: Thu, 06 Nov 2025 18:20:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Nick Alcock" <nick.alcock@oracle.com>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 shuah <shuah@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Shannon Nelson" <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 "Arnd Bergmann" <arnd@kernel.org>
Message-Id: <95430a56-1ee4-46e2-814e-01a8cd074a48@app.fastmail.com>
In-Reply-To: 
 <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
Subject: Re: [PATCH v5 00/34] sparc64: vdso: Switch to the generic vDSO library
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025, at 11:01, Thomas Wei=C3=9Fschuh wrote:
> The generic vDSO provides a lot common functionality shared between
> different architectures. SPARC is the last architecture not using it,
> preventing some necessary code cleanup.
>
> Make use of the generic infrastructure.
>
> Follow-up to and replacement for Arnd's SPARC vDSO removal patches:
> https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org/
>
> SPARC64 can not map .bss into userspace, so the vDSO datapages are
> switched over to be allocated dynamically. This requires changes to the
> s390 and random subsystem vDSO initialization as preparation.
> The random subsystem changes in turn require some cleanup of the vDSO
> headers to not end up as ugly #ifdef mess.
>
> Tested on a Niagara T4 and QEMU.
>
> This has a semantic conflict with my series "vdso: Reject absolute
> relocations during build" [0]. The last patch of this series expects a=
ll
> users of the generic vDSO library to use the vdsocheck tool.
> This is not the case (yet) for SPARC64. I do have the patches for the
> integration, the specifics will depend on which series is applied firs=
t.
>
> Based on v6.18-rc1.

I had a look at this version and everything looks fine to me.

Acked-by: Bergmann <arnd@arndb.de>

I see that you have sent the series 'to' a lot of people, so
I'm not sure who you expect to merge it. I assume this will all
go through the tip/timers/vdso branch, unless you need me to
pick it up through the asm-generic tree instead.

     Arnd

