Return-Path: <linux-kselftest+bounces-45313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E24C4E02D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A723A32AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A626290;
	Tue, 11 Nov 2025 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UqtWHWSc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xsSGmQ/7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DC3AA1A4;
	Tue, 11 Nov 2025 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865967; cv=none; b=avnSxxCkPqFTekg/GBu39gEDEf+N5Z+hmYTgXWUFDOKpFsbnHvAcwvMtwuNIs45UhSGksUPRGtEyCOEBYZciyFJglk7/CHVf1B8cIer2GWxxfovppN7LmY+bgysl1aeMusF9VAoywNbUUn9k5guXzvbLc48eVls550cOLf31oWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865967; c=relaxed/simple;
	bh=byl3iwP0rDxRmVpU3HYfkY1xTveCtw/y/ASjLYrcWdA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V2JvYgJy7MIK0hB9+PvoBar8bbCejvix9Bw9w2LBEftq7zLivnGFRA/uMymzJhdLBCZqYhqyaz/0S15LCHt6pblsGwTUXRsMdrNQIrJpORF22lA1UpcDzHtNmP2cUUhq8OreBlH8RqchNzgm1mLnshQ2Q3H7qTuyuLewx0r39nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UqtWHWSc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xsSGmQ/7; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F130EC0183;
	Tue, 11 Nov 2025 07:59:25 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 07:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762865965;
	 x=1762952365; bh=lpZ/xuA4REV8ZqmvRWc8U7MR0aL6JOz5DLY/YkHrw9k=; b=
	UqtWHWScYmiVul6s0RQOIos8pdzTB+NUEpkxiwWBBXXpvQBQZmceO0sJWmXhHaUO
	Ue5SjkpYWIv+CrJF+358rv5Um65ldn162OBdqLEYGWvp1BMBaNItTFDSJ236ljH3
	UyB+s3OdF/bOzbQfL3luE0pBj4qUICHxVNw0YYwgDILlfGe7YlePxCgz1EkNZ7Is
	zxJxtkBdYh9G6Es07wf9z2r7osm7Rz1h2FY8VuG82u2RrJmSHtUOW6XLqHojU6Xl
	38cxWmsVFWK1VKnXcmAds8Fq6U1ZN8l36qJ0PqaYPDQ9hs3nidEB6OlZNLvC7iQK
	i6HQZ7lrcj/30goutiVCMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762865965; x=
	1762952365; bh=lpZ/xuA4REV8ZqmvRWc8U7MR0aL6JOz5DLY/YkHrw9k=; b=x
	sSGmQ/7E9E3pqz0aYax7BxnB7Ohe2Ai/IMwtxMvAFPxb3dnOU7DB915wf0b/NFqi
	LpK9ScL0/JOyVb7Tgvw/KzoAMG+ZkyRye1CBAmiZF5ymH+DhMLLpAXw1q11um/t3
	bpu8kjZThO7KeVX7UD7/W2m4PJazsQSu4YvxYyjDodXCli9wHc24plpndarD6Rti
	mPovccDyvit/TTneO97YHbB/TzQMXpRqqP8ffqOhWHigG0ELwpgEPKWvtUGzVENW
	Dez1F2Sy8K7/DqxrmAm34D7NZpvVJq8cbT0fXDDKkPAC/xNzQWjt3jGtK0Rbtfpe
	KSv8M6p0u5794QAmbEsxw==
X-ME-Sender: <xms:LDMTacJmPJUOMS65REH6oCKh4efqNTNNhKOUa5UpEXqW9ahNQ5IjTg>
    <xme:LDMTaW_gcKF7Ai4FSctoQD5FhpiA7P3uX_ZbQ36qCGzr0yPIQv1ll8dbhXs7GjKQZ
    8KJUDWBc1cmQwuHvzne_SxBDB_W2f1vpf2rzcGOpX0sxAMLHP3xf24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduvdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:LDMTaZwmmJhmb7RfxaHmaaOndIe_wmmglbdB_wo4nvBtD-6ruRaWBQ>
    <xmx:LDMTaTX4ld0Xsh4WQ7G7zXqfacLqK54TtOamYNDEmHDS6Rd7nyBIHA>
    <xmx:LDMTaTOokFBQuNSsckkmwEMbglX48-zBIX20rTzJPpHuW2pj0yOVwg>
    <xmx:LDMTadBqIhzOV20ccI31YAGRwX5QrNW5V_VMD2fT1xhcRcwEvv1YDw>
    <xmx:LTMTad1PeIzSn5WBhkfWaPoUul2bzlnWrFPuW_vHicCEh0EqdEnWN5Ut>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D0E25700054; Tue, 11 Nov 2025 07:59:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5RixjiBPr7B
Date: Tue, 11 Nov 2025 13:59:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <29dd9e11-9ae8-415a-acb3-b96af56550b0@app.fastmail.com>
In-Reply-To: <20251111-vdso-test-types-v1-4-03b31f88c659@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
 <20251111-vdso-test-types-v1-4-03b31f88c659@linutronix.de>
Subject: Re: [PATCH 04/10] selftests: vDSO: vdso_test_abi: Provide compatibility with
 32-bit musl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025, at 11:49, Thomas Wei=C3=9Fschuh wrote:
> The 32-bit time variants on musl have different names, provide a fallb=
ack.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  tools/testing/selftests/vDSO/vdso_test_abi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c=20
> b/tools/testing/selftests/vDSO/vdso_test_abi.c
> index=20
> bb5a5534ae7e8a46d7e68a561684c29a752b866d..0a6b16a21369642384d43b0efd1b=
ca227a2a4298=20
> 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_abi.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
> @@ -166,7 +166,11 @@ static void=20
> vdso_test_clock_getres(__kernel_clockid_t clk_id)
>  		clock_getres_fail++;
>  	}
>=20
> +#ifdef SYS_clock_getres
>  	ret =3D syscall(SYS_clock_getres, clk_id, &sys_ts);
> +#else
> +	ret =3D syscall(SYS_clock_getres_time32, clk_id, &sys_ts);
> +#endif
>=20

I think this #ifdef check is not reliable enough and may hide
bugs. As with the other syscalls, the best way to call these
is to either use __NR_clock_getres_time64 on __kernel_timespec, or
to use __NR_clock_getres on __kernel_old_timespec.

If we are trying to validate the interface here, we should probably
call both if available. If we just want to know the result and
trust that both work correctly, I'd always use __NR_clock_getres_time64
on 32-bit systems and __NR_clock_getres on 64-bit systems.

      Arnd

