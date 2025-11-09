Return-Path: <linux-kselftest+bounces-45199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 867B3C441F2
	for <lists+linux-kselftest@lfdr.de>; Sun, 09 Nov 2025 17:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FD054E221C
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Nov 2025 16:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9E62FFF94;
	Sun,  9 Nov 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="drlx4Ujx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tZpxlF53"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFADE19DFAB;
	Sun,  9 Nov 2025 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704549; cv=none; b=L32/Y1gmy5UPMuXuny25BuN3pNgN5HfLeZlcdb4FkAUMeSERGZIU7EdZuy3yAXQBuVvWJNWkZ6B8Pqjb7/8ayLitc6kmWhrNjSu8z7wFYDSwP7Rd3PviVakqxMTmNHjKBH+Su4TUmUhC8i2AxzNgk1aNBknj8QKiQ4BVfIpcGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704549; c=relaxed/simple;
	bh=4jod38HpsiIabqfa0pDiZe29m1VSif005vhrT0/DnUc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rqJz6Ag7ZTopezkYvVAHRrXus4HMbI9wzRhsMUyJLhkAuFpF8/ZJtDSHY3o9dNc6aCpbBPmKYDzVaMCPRlqCzQdGRxwIcghylNfWwvXod1dW+mArv+9oZL+3wCkpR387skJFjJrk+kHMfdYIwL7p46rXRf1MiM7dFQkHvFsHVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=drlx4Ujx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tZpxlF53; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F2AE7A001C;
	Sun,  9 Nov 2025 11:09:05 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sun, 09 Nov 2025 11:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762704544;
	 x=1762790944; bh=JEE330ySaodkvhl3xDjKL/tIDsvMEMAgBil3ykH1mCk=; b=
	drlx4UjxHBc4BK+/NVJU89mFSbrfOcSM+lHamYWdL3egMM8mGQLm5jNme0hu1Rht
	17ASKVfJ7qjrdeREn5wXdwvevseHMNdIxD0PLDg/GrY1oY17B5NGgz3QCVs9Pnsz
	aahHFTPIvSg43oGQ2ldcMf2dKJQHda9YZyk4beeBQMqHa1wOoEsDdp8OH73q/niD
	tTNdsiAq8d93OLEXExNoNy/umBFvSyfKYpAnKgph7sAtxtYFuv86g7XcY8RAZQgp
	BmojD/4751TwCgFscyQZhmNeuhm+uTXFZqJY/dgVY/QfR0icOlnF2vwKeEC6o3TE
	46IziJYcsvKnY8cp5l5B1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762704544; x=
	1762790944; bh=JEE330ySaodkvhl3xDjKL/tIDsvMEMAgBil3ykH1mCk=; b=t
	ZpxlF53AtCgpy5zaK9XzTSw0xrnZE1DatfrBFVrRSWYxl4bTI1mCGnn4BeoQ6Vkr
	aSauWlGgVMFTjq2hv7v9iIaAQyMrEsAFY7HaXSKggaScjCukiDUkQWSf3tAAGtw2
	AmtNmi21+TxMlkCYr+9Y564q0KWWdQn4rlJ5/iE14Hs24g0LqxSziFK37Wtoxgd5
	NFycR8/vwa/SrwPiiOY2f6yL33vU9cT9pa5eaF0D3zAxC0gN2JGYElrjix4QM/Te
	we1M6Ll2YjybsX3J6FAVqONqELdi7WGpVpm69bFae9MG4L6YJgHEyUngPIOi1VEv
	ZUoV7zykJiqiClh9ZBgNg==
X-ME-Sender: <xms:m7wQactHBjhGmjaME3x7l_Ip111ypE856jTimBmaUzpicZxXSdM4Gg>
    <xme:m7wQaUTH35MNFb2EDVu2u28sHYMVINxJnL9VcKPxRLHkM-u6vBuuEhaURZtWqYabf
    fb5Jj6sU20jG9W9VKa9yd0plFCkDu5W1TfCGBQ6md7a_7udFru3QcI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleehkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfeuvedugedugfeiffdvtdettdeifeevfffghfefvefhvdehlefhheehjedvfffg
    necuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghr
    tghpthhtohepfeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtshgsohhgvg
    hnugesrghlphhhrgdrfhhrrghnkhgvnhdruggvpdhrtghpthhtoheptggrthgrlhhinhdr
    mhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehvihhntggvnhiiohdrfhhrrg
    hstghinhhosegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhig
    rdhorhhgrdhukhdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsgh
    hrohhuphdrvghupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdp
    rhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopegrnh
    gurhgvrghssehgrghishhlvghrrdgtohhmpdhrtghpthhtohepnhhpihhgghhinhesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:m7wQabmF_YIbNBgdxFoevoHFJQ1eWu4ZnJ4xjCJtw66W2L-ukr0JXw>
    <xmx:m7wQaRuILS_f_EquuhHZJAzhvti4hsBgThcJkmS8fwUn49V9jbw22Q>
    <xmx:m7wQaSfVAsPMMG454n8tzXbzRCt1S_kSbiI9XIhUfh8Gag9s5h-lcw>
    <xmx:m7wQaVahZheDTpO_ctNR7LNi3EgQoe8W4r0T2kpj8H5LbqG5RtGjRw>
    <xmx:oLwQaSCuGOvbyudIA1SYvS95j7wbQLvk3z0UJxxth9q7U_J_OZSGmf0i>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AB7B8700026; Sun,  9 Nov 2025 11:08:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AisJtzLZ_1Kg
Date: Sun, 09 Nov 2025 17:08:27 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Andy Lutomirski" <luto@kernel.org>,
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
 "Shannon Nelson" <sln@onemain.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>
Message-Id: <7eb1a661-e5bf-45cb-a3cf-7337fb0c4173@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2511090221080.25436@angie.orcam.me.uk>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
 <b870aa47-5ed4-4dcf-a407-eca83d1733d8@app.fastmail.com>
 <6452c785-872a-4fe7-90e1-8138d73c6218@app.fastmail.com>
 <alpine.DEB.2.21.2511090221080.25436@angie.orcam.me.uk>
Subject: Re: [PATCH v5 00/34] sparc64: vdso: Switch to the generic vDSO library
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Nov 9, 2025, at 04:23, Maciej W. Rozycki wrote:
> On Sat, 8 Nov 2025, Arnd Bergmann wrote:
>
>> On other architectures, I see that parisc (always aliasing) has stubbed
>> out the vdso functions, while mips/loongson has limited the page size
>> selection to never alias. A few other mips platforms can theoretically
>> enable both small pages and vdso, but my guess is that in practice
>> they don't use the vdso (mips32/ath79) or they use 16KB pages
>> (rm, dec, ip22) based on the defconfig settings.
>
>  Umm, I'd have to dive into the details (and I hardly have the resources 
> at hand), but quite a bunch of MIPS microarchitectures suffer from cache 
> aliases; some even have VIVT caches.

I was going with this list:

$ git grep define.cpu_has_dc_aliases arch/mips/
arch/mips/include/asm/cpu-features.h:#define cpu_has_dc_aliases (cpu_data[0].dcache.flags & MIPS_CACHE_ALIASES)
arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h:#define cpu_has_dc_aliases     1
arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h:#define cpu_has_dc_aliases            0
arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h:#define cpu_has_dc_aliases           0
arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h:#define cpu_has_dc_aliases     0
arch/mips/include/asm/mach-dec/cpu-feature-overrides.h:#define cpu_has_dc_aliases               0
arch/mips/include/asm/mach-dec/cpu-feature-overrides.h:#define cpu_has_dc_aliases               (PAGE_SIZE < 0x4000)
arch/mips/include/asm/mach-ingenic/cpu-feature-overrides.h:#define cpu_has_dc_aliases   0
arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h:#define cpu_has_dc_aliases      (PAGE_SIZE < 0x4000)
arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h:#define cpu_has_dc_aliases              0
arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h:#define cpu_has_dc_aliases      0 /* see probe_pcache() */
arch/mips/include/asm/mach-ip30/cpu-feature-overrides.h:#define cpu_has_dc_aliases              0
arch/mips/include/asm/mach-loongson2ef/cpu-feature-overrides.h:#define cpu_has_dc_aliases       (PAGE_SIZE < 0x4000)
arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h:#define cpu_has_dc_aliases        (PAGE_SIZE < 0x4000)
arch/mips/include/asm/mach-malta/cpu-feature-overrides.h:/* #define cpu_has_dc_aliases  ? */
arch/mips/include/asm/mach-malta/cpu-feature-overrides.h:/* #define cpu_has_dc_aliases  ? */
arch/mips/include/asm/mach-ralink/mt7621/cpu-feature-overrides.h:#define cpu_has_dc_aliases     0
arch/mips/include/asm/mach-rm/cpu-feature-overrides.h:#define cpu_has_dc_aliases        (PAGE_SIZE < 0x4000)
arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h:#define cpu_has_dc_aliases    0

which for many platforms seems to come up with a compile-time
constant value. I hadn't checked the exact conditions for
the runtime MIPS_CACHE_ALIASES flag, but I see that the kernel
has a fairly centralized detection function in probe_pcache()
https://elixir.bootlin.com/linux/v6.17.7/source/arch/mips/mm/c-r4k.c#L1251

which is used for the 'generic' platform and those that don't set
a compile-time constant (ath25, bcm47xx, bmips, cobalt, ip32, malta,
pic32, rc32434 and tx49xx).

> (see the figures at the bottom; uptime quoted for an idea of the rate, 
> though the system hasn't been heavily loaded).  It is possible with the 
> aid of S$, which is inclusive and PIPT.

I now found commit 0f02cfbc3d9e ("MIPS: VDSO: Match data page
cache colouring when D$ aliases"), which probably does everything
necessary to just make it work reliably on mips, and should
be portable to sparc as Andy suggested as well.

     Arnd

