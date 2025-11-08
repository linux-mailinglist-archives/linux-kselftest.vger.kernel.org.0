Return-Path: <linux-kselftest+bounces-45160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77AC42B1D
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 11:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EE2E4E1C63
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FD32FABE0;
	Sat,  8 Nov 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cEZyamzN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="11RmOGKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF052F7444;
	Sat,  8 Nov 2025 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762597103; cv=none; b=gQsWb78G+SKum81vyf40V7h/2OMCYc6TNlIwbdItmXiT4GkX4rvZMcraJ4PyQ1hVGwOxMcpFfRkBiaSm020DdBICPMP6bVRBE7Eo9bIhzTUWOvhywVpC3JzIiLbRJpMB+Ogo9YEbH9uoz+x+O6N9iKlOgjS+bhq5UYqgJshm4XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762597103; c=relaxed/simple;
	bh=QTxCrFOVl8+EangfedcvqHwXcRI1j/48+hg1imipcUI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MdpqV7/BIkEGASjcEwcGgDcStqgEGhFKRgHdZLJ+nndr18bPfhTHl/3av6BvpbdvHJ9zZ8U6XMVXCnKLQ8H50AxhfHA0nFN7SioNzqT1tiv6FPhMjBXN/W7UUCw5MAKD/OlfM6zHQMf+XTE5W+LKrK4pYOzePkIvAl1ZUwOUjkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cEZyamzN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=11RmOGKC; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A5837A0191;
	Sat,  8 Nov 2025 05:18:19 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sat, 08 Nov 2025 05:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762597099;
	 x=1762683499; bh=Dy0X8O4MO1t7FqOwhn0j3XKQ7MaNsGXpyV2kiweRlxs=; b=
	cEZyamzNzoH9Icjv4IiQ7MKixYg2dbnKHuP4eSZS/o93PgE6kQ/CWnpSQuyZyBxx
	Wj6JgdMWTE2GD2KXK2w0u4TdkhZydi440gIa2367xIqal79Y3KxNhf5p0AhBwmx/
	VCTP94eOxOsZ/+iw45TAaa6TcQt0gBltvqKLZWqaGRL4GmLG3gkoxcoes2xRyISA
	MKiFHVimYVkDcsc0B028g11jnZY3t1pYZhDpA2KyW/g4itvadMZMjnaC9IyrvexB
	b6zYB4UY9AuPGgtL3RHrPe0sHVhqFKTIGan1Sc0Qr6WzSFn6w+uQspJfA+IlKvG1
	5M28rHkO7xmoqtTSGxvGoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762597099; x=
	1762683499; bh=Dy0X8O4MO1t7FqOwhn0j3XKQ7MaNsGXpyV2kiweRlxs=; b=1
	1RmOGKCzj3MrA3S6VHgbq421YPN8O9I8PzYPEWUd2LQirK9sjwdaLiunDdPudTVF
	oX/iVYhG0uSIDf0Gl9dU/alRQ1Ej12EmiLCWrpyZtHbaytqsF5F8Z46o4jhirvqo
	1epc1/Q4gaW0SqkMaLk5a4V1iVXL/ClvJz8Snlp4ipuFT6PPUnPCQuN8uW4ZKie7
	SiN9SCXu0FasH7p25jgc9VvED10nMU0OMLDGBcMiBrPoGi+xZSoLNl0XC6SqHBgZ
	3eLNB+33wHqfRFOgXTOp1aS8OPqGdA3rIij6tYqtY9ZkN4/PpEmzGWcWKkFXyfNB
	e5FU0No5QaEl/U4N2hHWQ==
X-ME-Sender: <xms:6BgPaRRIxWq5jmixg_10_Mir1jteEarI8RHW4m_r0Uav9t2rdu-niA>
    <xme:6BgPaVl8wFr6gnthaPgSZ1M--DxmnG-g4QebP9dC6AukR-lRUWxEsQWMyCk97OG7m
    cBfqOHQC0ZW8IRacTFMIUtogXSfeABR1Fv0bJ4MRaVF_NYnIpMvguc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledvvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepfeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehtshgsohhgvghnugesrghlphhhrgdrfhhrrghnkhgvnhdruggvpd
    hrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphht
    thhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpdhrtghpthhtoh
    eplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegthhhrihhs
    thhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdr
    ihgurdgruhdprhgtphhtthhopegrnhgurhgvrghssehgrghishhlvghrrdgtohhmpdhrtg
    hpthhtohepnhhpihhgghhinhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6BgPadWPlUcsGuyo71NaCjKc2YPRvI8gEEyapzU7K_qFqodZYdUZ3Q>
    <xmx:6BgPaSpqRRWVcjAk5v2CbNcnKLucrzxVs6Dc8Su2mEhLGCTJBU1Bgw>
    <xmx:6BgPaWY1zqG1CIgxQ5UaNJjuXvzVKu57KP9C9K20ZkpR-xWGduNZIg>
    <xmx:6BgPaeAB_UvzAn5Sll1yJnfyxEU8_O8ud3cRWf5fHo0_lPSXl6gamw>
    <xmx:6xgPaQGtgyz68Oh7u7-54VIZcOrGpiuEK0ob3TA8JT0rnP2-R9S_7KgC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA459700065; Sat,  8 Nov 2025 05:18:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AisJtzLZ_1Kg
Date: Sat, 08 Nov 2025 11:17:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Lutomirski" <luto@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
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
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>
Message-Id: <6452c785-872a-4fe7-90e1-8138d73c6218@app.fastmail.com>
In-Reply-To: <b870aa47-5ed4-4dcf-a407-eca83d1733d8@app.fastmail.com>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
 <b870aa47-5ed4-4dcf-a407-eca83d1733d8@app.fastmail.com>
Subject: Re: [PATCH v5 00/34] sparc64: vdso: Switch to the generic vDSO library
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025, at 01:17, Andy Lutomirski wrote:
> On Thu, Nov 6, 2025, at 2:01 AM, Thomas Wei=C3=9Fschuh wrote:
>
> Now I'm not an expert on any architecture that has these aliasing=20
> (coloring?) issues, but from my limited understanding, it ought to be=20
> possible to choose a correctly colored address to map the vdso data=20
> given where it's being mapped from.  If there's an issue with gatherin=
g=20
> a bunch of basically arbitrarily relatively positioned physical pages=20
> into their necessary arrangement in usermode, you could presumably fix=20
> it either with some linker script magic or by rearranging the C code t=
o=20
> stick everything into a multipage structure.

On 32-bit Arm, we only allow VDSO on CPUs that have nonaliasing caches
but not on the rare ARMv4/v5 CPUs. From the public information I could
find, it appears that similarly all SPARC CPUs from the past 20 years
(Leon 3/4/5, SPARC64, Niagara, M5/M6/M7/M8, ...) are also nonaliasing,
though at least UltraSPARC IV (released 2004) and earlier models still
had an aliasing VIPT dcache.

Someone more familiar with SPARC should double-check that, but I would
expect that we can gate the VDSO on the actual cache topology.

On other architectures, I see that parisc (always aliasing) has stubbed
out the vdso functions, while mips/loongson has limited the page size
selection to never alias. A few other mips platforms can theoretically
enable both small pages and vdso, but my guess is that in practice
they don't use the vdso (mips32/ath79) or they use 16KB pages
(rm, dec, ip22) based on the defconfig settings.

      Arnd

