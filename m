Return-Path: <linux-kselftest+bounces-45629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD7C5BE81
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 09:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C54C63549D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C066E2FB0B3;
	Fri, 14 Nov 2025 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Yj2PMyqz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sz1JfpCX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39C2F90DC;
	Fri, 14 Nov 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763108008; cv=none; b=MwhTlTy+Ww3DdI4C72Sb4IJpHnpL3OJb/YjxyRVs9ztx5JbYqA4CPTqxPWya6/92DHcoS5PVkTUP6Xujg/dMLprpx35kXL2WfhUCkvQ6Tk8v4l/XXkMr5I3RloWmJLzdEfWaDNlGHO3SgVKkqqCzHCAU7NNhhTsvAvQ3zybDUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763108008; c=relaxed/simple;
	bh=J+RlaHdKMwAn/p+R2ecykWiDI0YrUyp+K4zTOerfhmM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MIK5r4Ss+QJPMI/5avC4Gf3s+2IAVd79L0JRB0v7pYdyQwHOmb0QiSyRtGquNu5EyuBsRVWUKfjg7tB5DLyhYiWhzGgefxoYvZXkTtBJuIfvoYPd6e4j2C5cCseac+jTkY2RvWPPUBLn5HO+68QtqPvtFIWo+qjRZINzkETY3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Yj2PMyqz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sz1JfpCX; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F1AA1D0011C;
	Fri, 14 Nov 2025 03:13:23 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 14 Nov 2025 03:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763108003;
	 x=1763194403; bh=+ZUde1thpV0nElx5aeIPj4ZADyLEgPfl/O8zr2chtC8=; b=
	Yj2PMyqzLNFkUoGcgacoR8J+q74zWnjXSBKcFXoS9cO1GmWXPhrX3gJqHujvHvi7
	d9gl8lXcOTvtgZTAUGTtIUQ7Ex/Gxr6hWPecbldP/e3EInobPsDB9b8EFsdfp0jp
	PJ11jB0xnQBVBYpiZ4ajbTfUjkDynCTUWOpH1VFUooWbexdBUWHcwLS8+FUm6Xc5
	7CSeCb6o+NkJMgmMMxugfUTpZlM8FTT2rFnc6ZMyZypiHcyNR56K5Ie7+1L/R+GF
	E3uYjLHNBoVCghpDEHoCOYFY6QVDvixUDTz2aR0J4IzQS6YnTh053ehdg0vuRizn
	r69sn7j0SpyGIQ6nQVH5jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763108003; x=
	1763194403; bh=+ZUde1thpV0nElx5aeIPj4ZADyLEgPfl/O8zr2chtC8=; b=s
	z1JfpCXI2+OmRJ8hUmmREzOJt4V1cximfBOnghk3Bg8Zm3zjsQRT1V+H8wLXvQNQ
	vDq1VOX3HoQtmorplcd1J9GjyZYljuMED/lqIuScH0QbW/LcDVyGycbPqspvk5Qp
	kblnhk8KvozzovQMYoAfHSZ3jPeajCLipck6Ysy3C9L3svrJjTe98mC8goxxVY4T
	YXyQr1Yeemtolq+4+hOfYMKRwLH87A7+htNl+T15Xx3A4x3rHbVcTJfTRICXzDHS
	q8UB1v4TZ26/onLvTW48w+t0okgZco+vUZYIvyEVyRfrVdvRdl9wkNAutFcqT4QJ
	QsZKTPpBDh907/pwT870w==
X-ME-Sender: <xms:ouQWablyWUHWuleS3RmsRKefKVSz3pjgl4UGy854LNVfI3H6AnatXw>
    <xme:ouQWaZriQjy76cPdl8o-Jf91gY3erOvGaN-fEuxAjb2nJngEyugwhk5tThSwKry7V
    OovLG4OWI-ufnvyRfptyQ_TV3w-bDaji71CU3dn9Qa9YmRdNyOW6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdelfedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ouQWadNFvc2409d9-Rx1qQQ4dwHX2Fz3zLWc7yK87W0bDgWCJn5qpg>
    <xmx:o-QWaaCsI1FsCkn07A42XQLYOrOMN8dIxQsoui-Y0atyUB6aLoObRA>
    <xmx:o-QWacKbovDubLE1tiMGsAORISigMaZR_N6IRcZwzS5PlG2_yg-ELQ>
    <xmx:o-QWabOYbe51Vrgg2rGd-k678qM_ev6pvQHvCyFk_onkMhsQifRMtw>
    <xmx:o-QWaTSqgsUHqauzEV90YVPAt7TW9DzImpkynxBAcqFnjHqpGlLCcnKt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DCDD7700065; Fri, 14 Nov 2025 03:13:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ap118jhpfmOV
Date: Fri, 14 Nov 2025 09:13:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <5826549e-88a8-429c-ad42-46aeada9d21b@app.fastmail.com>
In-Reply-To: <20251113-vdso-test-types-v2-3-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
 <20251113-vdso-test-types-v2-3-0427eff70d08@linutronix.de>
Subject: Re: [PATCH v2 03/14] selftests: vDSO: Introduce vdso_syscalls.h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025, at 16:30, Thomas Wei=C3=9Fschuh wrote:
> The vDSO selftests use raw system call wrapper to validate the
> correctness of the vDSO implementation. The exactly available system
> calls differ between architectures and kernel configurations.
> Raw system calls should not use libc types as these are not necessarily
> compatible.
>
> Introduce a helper header which uses the correct types and fallbacks.

After I looked at how these are used in patch 8, I think it's
much easier to just always use the same types as the kernel interfaces
here and skip the type mangling entirely:

> +static inline
> +int sys_clock_getres(__kernel_clockid_t clock, struct=20
> __kernel_timespec *ts)
> +{
> +#ifdef __NR_clock_getres_time64
> +	return syscall(__NR_clock_getres_time64, clock, ts);
> +#else
> +	ASSERT_TIMESPEC_COMPATIBLE(typeof(*ts), struct __kernel_old_timespec=
);
> +	return syscall(__NR_clock_getres, clock, ts);
> +#endif
> +}

__NR_clock_getres and vdso_clock_getres() both always return a
__kernel_old_timespec, so I now think it's best to return that from
sys_clock_getres() without the __NR_clock_getres_time64 alternative
here and not worry about whether that is a 32-bit or 64-bit type,

I should have thought this through better in my comments to the
previous version.

In kernels without CONFIG_COMPAT_32BIT_TIME, we currently leave
out the clock_getres/clock_gettime/gettimeofday/time syscalls,
but still provide the vdso interfaces. For consistency we should
probably leave out both syscall and vdso in that configuration,
and then we also don't need to compare the vdso_getres result
against sys_getres_time64.

> +static inline
> +int sys_clock_gettime(__kernel_clockid_t clock, struct=20
> __kernel_timespec *ts)
> +{
> +#ifdef __NR_clock_gettime64
> +	return syscall(__NR_clock_gettime64, clock, ts);
> +#else
> +	ASSERT_TIMESPEC_COMPATIBLE(typeof(*ts), struct __kernel_old_timespec=
);
> +	return syscall(__NR_clock_gettime, clock, ts);
> +#endif
> +}

Same here.

> +static inline
> +int sys_gettimeofday(struct __kernel_old_timeval *tv, struct=20
> kernel_timezone *tz)
> +{
> +#ifdef __NR_gettimeofday
> +	return syscall(__NR_gettimeofday, tv, tz);
> +#else
> +	/* Architectures with vdso_gettimeofday() also have __NR_gettimeofda=
y=20
> */
> +	errno =3D ENOSYS;
> +	return -1;
> +#endif
> +}
> +
> +static inline
> +__kernel_old_time_t sys_time(__kernel_old_time_t *tloc)
> +{
> +#ifdef __NR_time
> +	return syscall(__NR_time, tloc);
> +#else
> +	/* Architectures with vdso_time() also have __NR_time */
> +	errno =3D ENOSYS;
> +	return -1;
> +#endif
> +}

These both look good to me.

     Arnd

