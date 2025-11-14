Return-Path: <linux-kselftest+bounces-45631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 231B4C5C35F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 10:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993243AC26B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 09:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD373043C6;
	Fri, 14 Nov 2025 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NJxkIL27";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKlT1sQK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7660E2F6904;
	Fri, 14 Nov 2025 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111817; cv=none; b=RKGp2ZU19n6xAyNrCTagUdX4DxFjvgDRwRCqc3x05PDZSXueuBjAgE2pDvh3pzK3N6fPGat5xr6oYw7x4oFnXLFS4m7Y0m0o1ND/9PkY0yM34ozzlsBWFBFiWl6cHH7Vlzsew66fJZYx3+CG96P6vsFPbVdoc6YduDiYiX2PpBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111817; c=relaxed/simple;
	bh=ZVccD4ZZTKzcMQ84gW05+SrXxU7A8gux6EAT88JUkp4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e4VBdjW1r4oXNAWCu+IRrW8BVhYHmW/S0XhoHIN5sITp+VWnWSV6yog8D644j8LfTEmgUiBJoJ7wPtmpZloEr+lus7aGixBlRiJJTCLPLWyPDNn8S1LuV9pYsPMQt8MTH68L6tuaRf0jbjK+8oVyprRnuws+I04xjKGVVg89OQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NJxkIL27; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iKlT1sQK; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 79D131D00063;
	Fri, 14 Nov 2025 04:16:53 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 14 Nov 2025 04:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763111813;
	 x=1763198213; bh=jf6Qu3W9JayQIr9wipjRHjmky/pmBQPGeJHM5DVbFnQ=; b=
	NJxkIL27F/IJDXh0tPhcMF5OOAQEYkrVIGAiKyp8fDFPP3pFWRN0oCh1C+Eo3WGQ
	mqsuZhmDXwOe4eKlef/x51BX/E5K6mCU4J0jHRqSXEM6nOqnQt5SRsjzhdF9ksIS
	sb0lLfgk8eMOlfmcrDDubmOuGP/EihPCNl8Drg+pG3/yJ50nnN4jeYWTTM/KBTei
	USsEe5v63o4vjqjVqGqQEghL9m5EmExBqRKphCQyAYJMCYL8hJJbGodoiBMIO1ap
	g5TBybqzRGMMDasmfp+fyDNgduVkQbwkeQRkuLnYCoB4ekKbzdjLXkN4rZ5n+AXM
	hW+ajsw8qji2KxzGS6WpIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763111813; x=
	1763198213; bh=jf6Qu3W9JayQIr9wipjRHjmky/pmBQPGeJHM5DVbFnQ=; b=i
	KlT1sQKaEwQtPRqGVUVUDTN7UugfparsLCE4Q8slWq3Z6XzczhgEPYiwDXffjuzo
	enCVJSNBGG4MNfgcE0PCnKfiN0PbuHz5Wg4x96aJWEZni0ad/Oo/WORdWMNNQoLX
	ykYC8192WhJ90YMef0c/AAuz+jdvhzvbY6JDmmgSaFj2vBi0O+5S6Lyk379Q/wfY
	nKQILj6PN5ZU/KZc4IL4pTYo4iiJmeyJftP+pmY7uF+3ESt7KhSc59ffncVS7D5k
	PnTdsc+7sVwCLCDyVG9L0Ok5qu/ljgRJnolpE6tcFxxI1yuyGBcXPov9T3Tt96DG
	ef7fsb5xwuRqKHfboxHcw==
X-ME-Sender: <xms:hPMWaWwT7NzeZpI0JqAKIx5q44OihYqNHm_N8kJbruL1p_KM9aO-qg>
    <xme:hPMWadEgFpXRJIzreuCl2yTfvg6ggbgsUu8yBfbKqk42emltU7NrsLgl9Sar3_qR3
    z1nOcoGTEUL_8fC78jD8IzPgNto5WdmDNwniszcJKvw1PfQ-qjAuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdelgeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:hPMWacYu6_PqWzAG5JnkMBEgg74dZeU_Hoa6nq2fgWNPLvyQjgJ2fg>
    <xmx:hPMWaRcu_kuPoKXYOFamJrZ2nikl_1KHMUGhTrtdZjDzEuuhwOAkLQ>
    <xmx:hPMWaW2lsJu_oqqYTjJAGGloP4AC6AR61_zHb8iVb-mN3l-6LecFrg>
    <xmx:hPMWaYJYu5P3cqd3Cv04tuQk7lQJFOZY5mJEH1Za-aaLxfpIO0ftVg>
    <xmx:hfMWactibiVsckqS37C9b55aF-muGeiqWuxXD3J58jy2oFbaDmFd-CBD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D23A5700054; Fri, 14 Nov 2025 04:16:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ap118jhpfmOV
Date: Fri, 14 Nov 2025 10:16:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <22ec7315-49b2-4fde-bd2f-f24f2cfcec37@app.fastmail.com>
In-Reply-To: 
 <20251114093245-04b5eb56-d3ed-486b-90ff-7c7ad5cfc7e7@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
 <20251113-vdso-test-types-v2-3-0427eff70d08@linutronix.de>
 <5826549e-88a8-429c-ad42-46aeada9d21b@app.fastmail.com>
 <20251114093245-04b5eb56-d3ed-486b-90ff-7c7ad5cfc7e7@linutronix.de>
Subject: Re: [PATCH v2 03/14] selftests: vDSO: Introduce vdso_syscalls.h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025, at 09:48, Thomas Wei=C3=9Fschuh wrote:
> On Fri, Nov 14, 2025 at 09:13:02AM +0100, Arnd Bergmann wrote:
>> On Thu, Nov 13, 2025, at 16:30, Thomas Wei=C3=9Fschuh wrote:
>>=20
>> __NR_clock_getres and vdso_clock_getres() both always return a
>> __kernel_old_timespec, so I now think it's best to return that from
>> sys_clock_getres() without the __NR_clock_getres_time64 alternative
>> here and not worry about whether that is a 32-bit or 64-bit type,
>>
>> I should have thought this through better in my comments to the
>> previous version.
>>=20
>> In kernels without CONFIG_COMPAT_32BIT_TIME, we currently leave
>> out the clock_getres/clock_gettime/gettimeofday/time syscalls,
>> but still provide the vdso interfaces. For consistency we should
>> probably leave out both syscall and vdso in that configuration,
>> and then we also don't need to compare the vdso_getres result
>> against sys_getres_time64.
>
> That sounds good. But today no vDSO provides clock_getres_time64,
> so removing clock_getres from the vDSO will affect users.

In what way? When we introduced the clock_gettime64()
vdso call, we debated also adding time64(), gettimeofday_time64()
and clock_getres_time64() but decided against that based on
the argument that the libc can implement all of these efficiently
with just clock_gettime64().

If you think that clock_getres_time64() is important, I don't
mind changing that, especially now that we have a shared vdso
for all architectures. The arguments here is a bit different,
since an efficient clock_getres() function in libc requires
caching the values in userspace, while an efficient gettimeofday()
is much simpler, by calling vdso_clock_gettime_time64()

> So we will end up with some sort of inconsistency in any case.
> While I agree that it would be nice if the type mangling was unnecessa=
ry,
> I prefer to correctly test what we have today. If we decide to simplify
> the vDSO itself then we have working tests.

Sorry, I'm not following. Do you mean we need the mangling since we
support the vdso for configurations without the direct syscalls, or
do you mean something else?

I don't think we can actually build a full userspace (other than nolibc)
that works with CONFIG_COMPAT_32BIT_TIME=3Dn, so I'm not particularly
worried about testing the vdso for that case. You already skip
testing vdso_time() if sys_time() is unavailable, and I think
we can do it the exact same way for all five vdso calls.

> sys_clock_gettime() should probably be called sys_clock_gettime64(),
> as that is what it actually is.

That also seems wrong, as there is no clock_gettime64 on 64-bit
architectures, only clock_gettime.

> FYI: gettimeoday() seems to be available even in kernels without
> CONFIG_COMPAT_32BIT_TIME.

I see, that does sound like a mistake. It's relatively harmless,
but I think it would be safe to change this along with changing
the vdso to only expose the time32 interfaces when COMPAT_32BIT_TIME
is enabled.

     Arnd

