Return-Path: <linux-kselftest+bounces-45329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD6AC4EB8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 16:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793C618C0A73
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812135B135;
	Tue, 11 Nov 2025 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cyYb0p6h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yzK4W7VM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B135B12B;
	Tue, 11 Nov 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873702; cv=none; b=qljgtHSVKV3Jo1rdFUGmCzFSB4EXzFToF/TOGhD90/zhNhP7ybBCIs2mIGYg9KolakfUtvQ52G4nXoJlp9DoVI987+vTq8O0cDoNI74djWvczvfJzUhMATU9WZ0Fy++F6z0SHx30EpiaqLaQp8xQ4dwZP4Qa0cPrTCOKy6V6uvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873702; c=relaxed/simple;
	bh=JDx07bvAPbahj4fglxAGAoCCKWjZOg5DcZxJkUZ/dLI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OfVZc3KdTZXfMHiKDBPBOY7lNAE5MY0+dQ/nQl+kFkj3OMsl198ADNALF2hmzk8BJ+HZKbhrO+qa5nz9pe4T7LhfydmTio/rI/TLcu1Y+PoOR3buc3ErWBas4Gzw+V0zDbi7aGQQaNcQg4w2NWQZ4Qrhn/OsiRHw75veBGxyz/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cyYb0p6h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yzK4W7VM; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB88114001EB;
	Tue, 11 Nov 2025 10:08:19 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 10:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762873699;
	 x=1762960099; bh=MxvLacjBhqWkhEIm3/oCehKlqfaCQSU5UAH8tpfHE+s=; b=
	cyYb0p6hj9z7RNKZzQLh6KyitQEBPD2Uu8BWwGvK3Kpd0ghmHMCaguKwOJ5MaR7U
	yeKq9NMWIYHKXHN2HaZ9TKOmDgbFa+9g3LAO9uesTkfzsMaTF/08/jcTe7aZGw+v
	81Oi+qJrvSz7Ug2IFeh8KekLxJ1e6Gtagua3qZAOhsLZm8ecQtAPmdv5faOxnC7d
	34nYQn/Zj4uP2CC2IaWMV1C+Hofsv8FwcFzKLNUDFGRkLQOYegDO2O/HpgleYYC0
	dJ1WCTSEv/RnU1Z7y59NkSJh6homfD8wyz2wS6YaYom9KSID/nLEyCLDtL0W3eqX
	H9vv2f0lphd2Uc1s2kZwwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762873699; x=
	1762960099; bh=MxvLacjBhqWkhEIm3/oCehKlqfaCQSU5UAH8tpfHE+s=; b=y
	zK4W7VMi/7kgTsasA7oljU2mGaqDBAhOi9ERV0uFjG4RlKzBcCsjxCan1MRZYtKm
	ifKkAyIcif6GRfhHFcLILY0NDms06NpJsRrLhq6DQUTsoLko9dLcvAKkuEfrrNGR
	gq1SnqHLKZHrr4TwM8iZgFeJO8HPKZltoJ41bB50lEaZGmzUGzBrSNI4ia1AdINU
	WavdsSSwaAQM4vTFZUsIzbZLLUbiWanB3M5dg65CpupCS8oj5dHkHk01YpwKR9nO
	8PUQ44aSzRauLb77fVWreOm/5Pn8RWoBr5jyfti1GdKecetqGbDpNXuRuFI2G2eh
	IyQU2DFtmomXrCJouu/Eg==
X-ME-Sender: <xms:Y1ETae5QKtPzC_ZNn83XdMWP3tW--DkrQEG9ZQyn8GGMXcl9nFUxrQ>
    <xme:Y1ETaSsdschrwNMrfZzLzD4sEGiakRwuHf5cQIzRYL4bMmYBvoLAsWyiDXz_nf_DR
    2Of2f4Gex_EwC3xQ7oq-4bnakLd-39h0zdly4uaAXCiE3Z68Ygd65o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduheduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Y1ETacj57ol8yJoH3aWbK9Jv8zJUNLKMXq1VvgPOzvueUolcGLqCgw>
    <xmx:Y1ETafFp13VQ2x8dBUxG3UiCr74T3uocqhK9KvWBRKKQE3-OpmyX6Q>
    <xmx:Y1ETaT_97NH8JM4kjTUiqNTkD69VHqf-eWnq52_VqD04Ku2dlKZ1Iw>
    <xmx:Y1ETaexo6_MGfUmNZJrqxxnbGwalW4dKQxytvAzR1kP9NFSvhC-pSQ>
    <xmx:Y1ETaYmlFzqmC2fV-SC6UYerYThFV5UsLh-nxPY78U4gQjiUdXpNeiU9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5E3AC700065; Tue, 11 Nov 2025 10:08:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5RixjiBPr7B
Date: Tue, 11 Nov 2025 16:07:58 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <2976374e-dd64-48ce-9726-56d97e94323c@app.fastmail.com>
In-Reply-To: 
 <20251111153707-0926c681-0b2a-4cc0-9074-acbe8a6371c2@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
 <20251111-vdso-test-types-v1-4-03b31f88c659@linutronix.de>
 <29dd9e11-9ae8-415a-acb3-b96af56550b0@app.fastmail.com>
 <20251111144805-ab2781fe-5424-492b-9cb3-55ebaaedc199@linutronix.de>
 <a78a17eb-1df2-471b-9c28-64619c71dc54@app.fastmail.com>
 <20251111153707-0926c681-0b2a-4cc0-9074-acbe8a6371c2@linutronix.de>
Subject: Re: [PATCH 04/10] selftests: vDSO: vdso_test_abi: Provide compatibility with
 32-bit musl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025, at 15:46, Thomas Wei=C3=9Fschuh wrote:
> On Tue, Nov 11, 2025 at 03:19:00PM +0100, Arnd Bergmann wrote:
>> Since SYS_clock_getres itself is provided by the libc implementation,
>> I wouldn't trust that this actually means the same as __NR_clock_getr=
es,
>> and it might be set to __NR_clock_getres_time64.
>
> Should that case not work anyways, as libc would also need to convert =
the
> parameters transparently?

Not sure, I certainly wouldn't expect all libc implementations to
do this the same way.

> But I'll switch it over to __NR instead.

Ok

>> >> If we are trying to validate the interface here, we should probably
>> >> call both if available. If we just want to know the result and
>> >> trust that both work correctly, I'd always use __NR_clock_getres_t=
ime64
>> >> on 32-bit systems and __NR_clock_getres on 64-bit systems.
>> >
>> > As these are vDSO and not timer selftests I think we trust the sysc=
alls.
>> > But how do we detect a native 64-bit time system? The preprocessor =
builtins
>> > won't work as a 32-bit pointer system may use 64-bit time syscalls.=
 I am not
>> > aware of the UAPI #define, beyond the absence of __NR_clock_getres_=
time64.
>>=20
>> I would just check __BITS_PER_LONG=3D32 and require a linux-5.6+ kern=
el
>> at runtime to ensure the 64-bit calls are available.
>
> That doesn't work for x32. It uses __BITS_PER_LONG but does not have
> __NR_clock_getres_time64.

Right. In C code, we can usually check for
'sizeof(time_t) > sizeof(__kernel_long_t)' to catch that case,
but that doesn't work as easily with the preprocessor.

A more complex setup using both compile-time and run-time fallbacks
would work, e.g.

static int
syscall_clock_getres_old(clockid_t clockid, struct timespec *res);
#ifdef __NR_clock_getres
       struct __kernel_old_timespec ts_old;
       ret =3D syscall(__NR_clock_getres, clockid, &ts_old);
       if (ret)
              return ret;
       res->tv_sec =3D ts_old.sec;
       res->tv_nsec =3D ts_old.tv_nsec;
       return 0;
#else
       return -ENOSYS;
#endif
}

static int
syscall_clock_getres_time64(clockid_t clockid, struct timespec *res);
#ifdef __NR_clock_getres_time64
       struct __kernel_timespec ts_64;
       ret =3D syscall(__NR_clock_getres_time64, clockid, &ts_64);
       if (ret)
              return ret;
       res->tv_sec =3D ts_64.sec;
       res->tv_nsec =3D ts_64.tv_nsec;
       return 0;
#else
       return -ENOSYS;
#endif
}

static int
syscall_clock_getres(clockid_t clockid, struct timespec *res)
{
       ret =3D syscall_clock_getres_time64(clockid, res);
       if (ret !=3D -ENOSYS)
              return ret;
       return syscall_clock_getres_old(clockid, &ts_old);
}

but the simpler check falling back to the 'old' version
is probably sufficient.

    Arnd

