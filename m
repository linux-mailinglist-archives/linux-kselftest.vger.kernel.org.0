Return-Path: <linux-kselftest+bounces-45627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 28857C5BE27
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 09:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 723183548BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCB727F01E;
	Fri, 14 Nov 2025 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="a+cGADRf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mzcu1uVa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6313AA2D;
	Fri, 14 Nov 2025 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107310; cv=none; b=phvOLLpyDWmQmTfkK8Z/H+qGG7Zn54ApWUHtvmcpIYu1h01GwyHlowdcrdedQqO29Wo9o8Jo4gTjmEyRIdJhv2hCRw1b5SezFtq5iw2sbHJUirSujYkZHsKPrHMF5fxQfjWfGYyxQg8zb+ypFqlD5fnr1NFubWMOc5xAUA8de6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107310; c=relaxed/simple;
	bh=AM99Za7F2UgjaayGXrnrD1m1mKDiPyqjuSZSYubQQs0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PslZnys0Cfwex6z8x+YukchqPKqprCY1K8oiAN23+779Jg4OBn4YfuWHnzv6UvYmzEhRcCO+4zEA+bCC2kqwrwM/vpx8k6+9HA3VUm/a6KsK91ujEw01g52bH9/Yo3kXdiKKsOrdEJ6zX0G5gTc01SPvTkHfc3jfR+awOEm2NWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=a+cGADRf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mzcu1uVa; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 599691D000F8;
	Fri, 14 Nov 2025 03:01:46 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 14 Nov 2025 03:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763107306;
	 x=1763193706; bh=GUfuQzs0UGJKCWgSC9jC5H1uycJ0SQm6HbNmJXyNyPw=; b=
	a+cGADRfy8MR6TvXl7pkksv8e+vUDXB6yzu4CgaeWjmOpm1cIQcEYeqfKCs3E0r1
	YJVUWAFbt1jZ73xhzIyoWwBeG0RhpH9yE/JHrLJKi9JQj67f09XlW7OZPfYTpeTf
	WjDcfMVJISTSlfClIRtm9pgkVOPJovuR6YDIHzNTml3XqC7M3ZylMzUsArwk8RP5
	p90FrsizJrPtGFH9YRMnagd1PIFIBL5NrOczVRAP62FKXfW6pkp5ey9bhsQD+mHr
	GZ4XoFiVn5APlhVNGxcJPj7qsCrE+DIYXb/PIY7Su5MOl3p0kbBCJxThdN3e4x3I
	Tr6zx3ISsBpj6JE9WIhoNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763107306; x=
	1763193706; bh=GUfuQzs0UGJKCWgSC9jC5H1uycJ0SQm6HbNmJXyNyPw=; b=M
	zcu1uVaRnGEHV3Rj7qsjsLiOL2E9Miv0nwggsvqYk86Mb8qytbTQCjdwW0ms5ES2
	G4zeqUGfPGzNuRc0TE6GpvQXW90K5O/O/qRTJ3NTSYb81LFosgJ2H9ET7iD5C4Uo
	P8tk3oJ20Rgfwop/RbPISZLFNBEJNSpYyNssN3T5Kdz+6DnlSWaJo29c/NCHM98T
	/af22Tew8V9mjp731zKfTxqMjPk2Szsw/zDFtResSguI9QaK+huTypo8qCAidojx
	urg08lowXQQ4DMmbqrrgjMIymqcLA41rFyclvrbuVv/OidPaL0fRNhOPyXyyJC+d
	Qkb3nFp5Jg6PsHTffQh/Q==
X-ME-Sender: <xms:6eEWaY1glke-1Rn4hsTK00kpntMel7AibwmwalQ0OXwDA454GmcTrg>
    <xme:6eEWad6dULnMZdMEKq7RJhaG2s1XMR-HzSZ2D68TNYGwcc-5jL3zoIhPfM4fXL8dE
    qFjBv17xlNRmVJ4sjH7F6t4eyP5lMU5HsEf_ctIO6ocdudW2adHmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdelvdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:6eEWaadKQ_L0DJz8Yz5-k8CqQoS2lctol6tlffglAp_0ycy8oIJ2Fg>
    <xmx:6eEWaeQy-pFOU7XP1w9riuOlI8eA6OCiEN_VRuxuAC_YqvWwg7I_vg>
    <xmx:6eEWabbeSgfC8m8XWyLODQd8bMtKdRuD3jLuuVRI7-_Xg2YlIEyDgQ>
    <xmx:6eEWaZdSKRGwjaN3tbj6jdW8G5IiVZpA7wNa25vQWL9pPQTfEZHNkA>
    <xmx:6uEWaYgs9WKUZb3mijpclU_yn_4o_kjSAYsPe14-fPdN4MqSkI2LsSl->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9C540700054; Fri, 14 Nov 2025 03:01:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMhH2wAeH5kJ
Date: Fri, 14 Nov 2025 09:01:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <c3a23032-5e25-429b-b096-e9bc0a72d026@app.fastmail.com>
In-Reply-To: <20251113-vdso-test-types-v2-12-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
 <20251113-vdso-test-types-v2-12-0427eff70d08@linutronix.de>
Subject: Re: [PATCH v2 12/14] selftests: vDSO: vdso_test_correctness: Use system call
 wrappers from vdso_syscalls.h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025, at 16:30, Thomas Wei=C3=9Fschuh wrote:

>=20
>  static void test_one_clock_gettime(int clock, const char *name)
>  {
> +	struct __kernel_timespec start, end;
>  	struct __kernel_old_timespec vdso;
> -	struct timespec start, end;
>  	int vdso_ret, end_ret;
>=20
>  	printf("[RUN]\tTesting clock_gettime for clock %s (%d)...\n", name,=20

This looks confusing to me: I can see that the existing code is
wrong because it passes a (libc-defined) timespec into the
sys_clock_gettime() that expects __kernel_old_timespec.

It looks like you are changing a sometimes-wrong type into
a consistently wrong type, but then you also change the
sys_clock_gettime() definition to return __kernel_timespec
instead of __kernel_old_timespec, so it ends up working.

Why not always use __kernel_old_timespec for the local variables
and the sys_clock_gettime() calls here?

> @@ -305,7 +291,7 @@ static void test_one_clock_gettime64(int clock, co=
nst char *name)
>=20
> 	printf("[RUN]\tTesting clock_gettime64 for clock %s (%d)...\n", name,=
 clock);
>=20
> -	if (sys_clock_gettime64(clock, &start) < 0) {
> +	if (sys_clock_gettime(clock, &start) < 0) {
> 		if (errno =3D=3D EINVAL) {
>  			vdso_ret =3D VDSO_CALL(vdso_clock_gettime64, 2, clock, &vdso);
> 			if (vdso_ret =3D=3D -EINVAL) {

This looks like the correct fix to me. We were already uses the same
types for syscall and vdso paths, and now the types match the interface.

     Arnd

