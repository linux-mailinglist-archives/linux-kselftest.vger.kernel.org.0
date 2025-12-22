Return-Path: <linux-kselftest+bounces-47819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 651ACCD55A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 10:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC01A30124D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DFA311957;
	Mon, 22 Dec 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="STIHjuVS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t/idEr93"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705C20DD48;
	Mon, 22 Dec 2025 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396316; cv=none; b=GNYcdtqvhvgAWJVERLVRkOpPHq+JY2dZnsYM6AkVRhYkQMKIl06sd8WFLeLNfS4K7J6zymDsVQPhuy1XxGeLCOk37wpEjmwlBW1hKk4CcdoF3IckF1ETN2ogmVHlN9khGjgD1+wYcEWd1QJTB5kSwaAZ50dEQu0NBIhUCvy4D74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396316; c=relaxed/simple;
	bh=i27ofHa0zl5RlVhwdabhZ9YlgEaNJJCkhZMxZ3VsROM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=evggRuWmN5pgvNq/Wpkl3Edt64jKU8gR/zkO5bfo/TARY6xHk6k5vcGmB4MG13ekRuvqt+y3RuJ+zMci/M0RWE5zemD9NkHbdcQU+E5KcuKPRhEpiGnYZt+fntTLMoJ7XKPCfAjNj14vjCU8NpZGfzIYwu+8wqStNclAvsRic4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=STIHjuVS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t/idEr93; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id AC2851D0008A;
	Mon, 22 Dec 2025 04:38:33 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Mon, 22 Dec 2025 04:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766396313;
	 x=1766482713; bh=y0h8mJ71Svv0O6rwh0Q0uXx+KWERlXhUzXJbAf3ehIg=; b=
	STIHjuVSUcTxqC5bKKW7cVBjJRfwITR+0ZbjDDo4pn4ZeXuT97ecXup0mXf++8dr
	gxhWOfvVwxqtg+89DKwgNeE1wHpJvlzZwvfwTomVQqgrjnuorcPun1PyzOtmHLzC
	qX3hpEChUe0cqutED1Wbt+jGpcevgRUgtSy+a/t9ExkfKhdsydTFo7Owb+XBBDrC
	q2yzQ1BM2RC5ShfwmYtArB9w1S9XSOvDRNDqXuM/t3ed0ZWgs+IVjghEpPubVHqb
	1stgOhDy3uDjUaN7tJSb7xRIliypQWZyz3ePj+kRRRmH05WW9GUBX/uIcci3yRKf
	f9/YtifpA8fPz3sMwV4isA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766396313; x=
	1766482713; bh=y0h8mJ71Svv0O6rwh0Q0uXx+KWERlXhUzXJbAf3ehIg=; b=t
	/idEr93amSROv6vCHO/AoaisR9/6KzGFpvNtXKoZjKV2j/hwrmUiphRVG63TNLjz
	9JkhY3JHmMOrddrPkOV29h48IyELnftyOm1VoPsk4PhCGbhYo1VefBj6KAk5WqDI
	UI2Pgd1ALQQ0dLURwtwm6BQrO4CgiCgjvHeWi87QZ6c+LJ7sPhxY9mArGCY8J/Nw
	zPr8KyfwkOWpamoOY9Uz5Qy3zbAR6qj81uM81VFX2eHSdac9hZ3MyBLC/cSCRi5h
	1aG0ccO8sVqEkpGp5GH7C+SqZMwHkK9rXeUAp29aXMdQY7MdGnnlfMnCr/Ax4xjZ
	3twwR4tlunBvCRU+/v3AQ==
X-ME-Sender: <xms:mRFJaXaVpQFdF65TdAghQDj4wbNwAcknIZ-7yMvmEGkOg57LXrN_pg>
    <xme:mRFJaRN7H3CJap8w9qDuMO4BTDFfSa_xGxDvT-7uptp1IPZig4F8an_4Cvnff3UPS
    PBI7ank4uGcb6TcDM16ovSUATSGk1Jvf68XeEqVrThXei9xYDMGXmk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehieeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhn
    uggsrdguvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhe
    dvvdegjedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoh
    ephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfiesudifthdrvghupdhrtghp
    thhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    khhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigseifvghishhsshgthhhuhhdrnhgvth
X-ME-Proxy: <xmx:mRFJaUk7eKAaulWP0HSixBc7MFxpNvWTzdGatzINpCQ4PDmmsQB7Xg>
    <xmx:mRFJacwtvVFUZSMW30Q_kAjaSR4uxOGq5mEbegUAmpmyfWf28-iAJQ>
    <xmx:mRFJaeMP-zq9d-kfklyUSnKiWOJvTejhgRkV_PryebWsQ1Qt7qpSIg>
    <xmx:mRFJaQr34CM9UeAkie5bsCRoo-L6K53Xp5OcHHt_fxDHqwxlMznO6g>
    <xmx:mRFJaRKqPUHTWSUabwe2mM46ubR6XHZsGMs6OYsW70K0AO63P3fcR0q6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 55CA5C40054; Mon, 22 Dec 2025 04:38:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2Xa-rA5Pma3
Date: Mon, 22 Dec 2025 10:38:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Willy Tarreau" <w@1wt.eu>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <603f8d3b-1fd7-4f68-b9e7-04093f1bc117@app.fastmail.com>
In-Reply-To: <20251220-nolibc-uapi-types-v3-8-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
 <20251220-nolibc-uapi-types-v3-8-c662992f75d7@weissschuh.net>
Subject: Re: [PATCH v3 08/14] tools/nolibc: use custom structs timespec and timeval
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025, at 14:55, Thomas Wei=C3=9Fschuh wrote:
>=20
> +struct timespec {
> +	__kernel_old_time_t	tv_sec;
> +	long			tv_nsec;
> +};
> +#define _STRUCT_TIMESPEC
> +
> +struct timeval {
> +	__kernel_old_time_t	tv_sec;
> +	__kernel_suseconds_t	tv_usec;
> +};
> +
> +#define timeval __nolibc_kernel_timeval
> +#include <linux/time.h>
> +#undef timeval

This looks like an appropriate workaround for nolibc so
it can work with old kernel headers, but I feel like we
need to also fix the kernel headers so at some point in
the future we won't need those workarounds any more.

    Arnd

