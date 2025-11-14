Return-Path: <linux-kselftest+bounces-45637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D31C5CAAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 11:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1834F4F4175
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466143128AB;
	Fri, 14 Nov 2025 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="K2ppTtny";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZmhUvRh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2F5313279;
	Fri, 14 Nov 2025 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116883; cv=none; b=pLtHihGolV1mYYHshK3LIz5zO6tiyns4un0yEnyxmIndkHwph2Woyx+Mykdr57pxCqBTYNoKpKg4zalEeI8WNm+nzjFlsaZ1kRRnWbaehI8cEhojZ3OgKTLlT+MSDdHfin8v+6rS/xtE2JEMc5XbpGkq61XbpDRTgpvol75wf0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116883; c=relaxed/simple;
	bh=BlWX5TwKK9UsIfOdOqxRMWJ3PJGZ4rnasWgYxToHYzU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JCDbSrFcsNVrGzIrzxxiW1baQzJTrLJAofrYB9GU+B0IBAFXUm9LnAbsGrP5gf74i7xOAa3+k1UmRIryUur+2rruwQBlmDex8XDjOPpB/TrQExHyklfBj8M5HiMbEjkfmfJ46g+RPbIgu77/ZCI2GdtdpB6jkAHrsXNnlLZ8GtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=K2ppTtny; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZmhUvRh; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F9A51D000B5;
	Fri, 14 Nov 2025 05:41:19 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 14 Nov 2025 05:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763116878;
	 x=1763203278; bh=duabn7YrLYFVynrWmnVneK+z+LnJhk/xuK3tjoE6SCw=; b=
	K2ppTtnyZ97G7M+sz4/QDzhOa4R1q5+PJpTwn4bYqO8yBLTqBvgyX1UgRerPhwVx
	86pV2uxn5Mvx5CtjPUflvWDFDyFOnbD4cQoHh73Vyt7cKuhMzZ2douhLisAKXbg8
	1rMsNGFTi1KlLuXhqdmtH0I8eBbsUzfo775bF+Dbhfwk3jfnbpWV8GxoTJ4IB73k
	FRHfsVuFoEkYR2kZvfgjLsAbBviuhtPxdwkCnRUV+n5UYC52rU5Gub1uynPTYPS7
	qKiEM35YFTFKS4gwRuyfNs2gwOhpNiB3d3ONpNtzSxv8gAl165Ni4VxxtCLqaicX
	oWXvu/c5FJ3TioDByXDA4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763116878; x=
	1763203278; bh=duabn7YrLYFVynrWmnVneK+z+LnJhk/xuK3tjoE6SCw=; b=W
	ZmhUvRhKAsZfgZaqfSb1yR+RD0nEvhYWd6wtGisbc5Bw/4u9N9p/KKtQKBPiCqO4
	MfgDWiy4QGjyWvh02ayFZSPgn1S3wDpAeTAN9bnd9MXe31NQa/APOblEQ/wTQ3rI
	FEQPhixUxy1sOWzpsf4bYOBq/jNOPkv7Eia2s/FmsGyb5ycoe20M1ssxh49yn2Ko
	9AfHV5I33kGazcDBZLCDisFmfmFw7O8/F1ZyVA/DsnN738R8UqEDvZ4o//ilZqF+
	x2rV7PAls0IuN4XjX1797Ig2MmQRckrqwHqnBM5Sv+ry8CK7bifyxrii+aYlRI6o
	84++OWDT8YSwMeQw/FbFQ==
X-ME-Sender: <xms:TgcXaShrPr8tLrxoZvHbNaVPhoJB9Gvk4HUI_RXZiTruBDWFEofzCg>
    <xme:TgcXad1jSNZI-Y7vxTGdeu9vChS3tIzj0S4nUQYYzcR1JwPorcibkVvFaaNCnKvoH
    pfFot4SKty8mgZpFFt8tatV-9rXgCbGQe3MhGcIzdPt7HJ7gwOFdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdelieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvhhinhgtvghniihordhfrhgrshgtihhnohesrghrmhdrtghomhdprh
    gtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidrug
    gvpdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhn
    ihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TgcXaYL7hDu43JjPCPDmmm0yYIOHQ2I1T1Y-vuTtbWUqkBvRQicilA>
    <xmx:TgcXaSNCu7uRx6i4slBe5hpbMSJxOI6PkSAgM87BLw21HvFuivEocA>
    <xmx:TgcXaYn2RPIKRw4M_F7du0MHkK4sPU-mz5kUS7ml_VOpRFRLzjWqjA>
    <xmx:TgcXaW4Jkb8jRItcEgj1HO75-ENrmtJVSzoBWM6l23oU7eaQ26aPmw>
    <xmx:TgcXaQNc4PsMO0m4ZfaIji1DQlzc3PvTLHNmcC_n3F1dslBxs3h_9_Ai>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6ADB2700054; Fri, 14 Nov 2025 05:41:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ap118jhpfmOV
Date: Fri, 14 Nov 2025 11:40:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <db53e96f-d0c4-4702-aee5-1c38c69074cd@app.fastmail.com>
In-Reply-To: 
 <20251114102555-293562eb-f1f9-47e1-bc2d-59f26a7283fa@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
 <20251113-vdso-test-types-v2-3-0427eff70d08@linutronix.de>
 <5826549e-88a8-429c-ad42-46aeada9d21b@app.fastmail.com>
 <20251114093245-04b5eb56-d3ed-486b-90ff-7c7ad5cfc7e7@linutronix.de>
 <22ec7315-49b2-4fde-bd2f-f24f2cfcec37@app.fastmail.com>
 <20251114102555-293562eb-f1f9-47e1-bc2d-59f26a7283fa@linutronix.de>
Subject: Re: [PATCH v2 03/14] selftests: vDSO: Introduce vdso_syscalls.h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025, at 11:02, Thomas Wei=C3=9Fschuh wrote:
> On Fri, Nov 14, 2025 at 10:16:01AM +0100, Arnd Bergmann wrote:
>> On Fri, Nov 14, 2025, at 09:48, Thomas Wei=C3=9Fschuh wrote:
>> If you think that clock_getres_time64() is important, I don't
>> mind changing that, especially now that we have a shared vdso
>> for all architectures. The arguments here is a bit different,
>> since an efficient clock_getres() function in libc requires
>> caching the values in userspace, while an efficient gettimeofday()
>> is much simpler, by calling vdso_clock_gettime_time64()
>
> I don't think it is important. For my SPARC vDSO series I even
> dropped the regular clock_getres() after your request. But because it
> doesn't exist we need to handle the presence of vdso_clock_getres() and
> the simultaneous absence of sys_clock_getres() in the test.

But that is the other way round, right? On sparc32 we have
(optionally) sys_clock_getres() but never vdso_clock_getres().

>> I don't think we can actually build a full userspace (other than noli=
bc)
>> that works with CONFIG_COMPAT_32BIT_TIME=3Dn, so I'm not particularly
>> worried about testing the vdso for that case.
>
> musl 1.2 started to always use 64-bit times. Looking at both the musl =
and glibc
> code, they always try the 64-bit variant first.
> I think they should work fine.

No, musl only uses the time64 syscalls when it actually passes
a 64-bit time value, but e.g. still uses __NR_futex instead of
__NR_futex_time64 when waiting for a futex without a timeout, and it use=
s=20
__NR_clock_settime instead of __NR_clock_settime_time64 when setting a
time within the 32-bit time_t range (1902..2037).

> Personally I'd like to have tests for the functionality that exists.
> Even if there are currently no users.
>
>> You already skip testing vdso_time() if sys_time() is unavailable, an=
d I
>> think we can do it the exact same way for all five vdso calls.
>
> That was an oversight.

Ok. So you'd want to check all the time32 and time64 vdso calls
against the __kernel_timespec values returned from
sys_clock_get{res_time64,time64} and their 64-bit equivalents?

I think in this case we have to actually address the inconsistency
in the rounding between the interfaces, which I don't think is
well documented and possibly differs across implementations.

As far as I can tell, gettimeofday() always returns the
CLOCK_REALTIME value rounded down to full microseconds and
truncated to signed 'long' seconds, while time() returns the
CLOCK_REALTIME_COARSE value rounded down to full seconds.
This can be a second earlier than a previous CLOCK_REALTIME
value.

I see that glibc's time() function uses CLOCK_REALTIME_COARSE
to be consistent with the Linux sys_time() and vdso_time(),
while musl's time() uses CLOCK_REALTIME for consistency with
gettimeofday() and sensible user expectations.

>> > sys_clock_gettime() should probably be called sys_clock_gettime64(),
>> > as that is what it actually is.
>>=20
>> That also seems wrong, as there is no clock_gettime64 on 64-bit
>> architectures, only clock_gettime.
>
> I referred to the type that it returns, which is always 64-bit.
> Another name, without the sys_ prefix, would be better.

Right, but then I would make it return 'struct timespec', not
'struct __kernel_timespec', because it's no longer the kernel
interface.

>> > FYI: gettimeoday() seems to be available even in kernels without
>> > CONFIG_COMPAT_32BIT_TIME.
>>=20
>> I see, that does sound like a mistake. It's relatively harmless,
>> but I think it would be safe to change this along with changing
>> the vdso to only expose the time32 interfaces when COMPAT_32BIT_TIME
>> is enabled.
>
> IMO that would need to be another series with its own discussion.

Sure.

      Arnd

