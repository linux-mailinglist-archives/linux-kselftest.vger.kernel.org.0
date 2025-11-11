Return-Path: <linux-kselftest+bounces-45312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C0C4DF35
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 13:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E4E188337C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25511261B8A;
	Tue, 11 Nov 2025 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cmpQpyT3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VunrRh3C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B762550D4;
	Tue, 11 Nov 2025 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865188; cv=none; b=nkBZBNBXF7d0fCSn97sQaoxephUNq24JvFkGIbk5zs5Tc1Vlo0Jkac9MWgskMHa12b2WD3fLSXK3sdJ9If80bQPTHEj+3fpOMbeHukuSNsEFW/ZJuzmH4MDNuG/FDB1kgapD6P8wPU2H+1hSabDGoLgmzQjo6V4kZy5L249e7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865188; c=relaxed/simple;
	bh=+D8jGoDpBa6xNo69zWsaU6PunpWeTPRMygAk91kfZN0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uzDV8Wd4E7clK7qhtM195CVBqJTPqhW/glQZsFElwe0zGAwUXf0p9PurlZTYD1WngsTVx/ATLz7B8jKAM4kL9NYcZEwU9kWUDCT15mfJ1JTrzj3RPNt7Ffuos3Xw7eFMYZgQRJVnUSrmEv2qzWu3da51/x9cCJHzgeW3p2joSUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cmpQpyT3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VunrRh3C; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7073514000F5;
	Tue, 11 Nov 2025 07:46:24 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 07:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762865184;
	 x=1762951584; bh=qPSPi7QKsWbBdZTy5b2peWWJFo3JmlmoZ6aUudf3qcc=; b=
	cmpQpyT32o12/yKmdmlYsHXboPxRIxWAizKxd0/9YzBhy0/UEKLknNjI+3fTIO0q
	7FU9sDw+hXE1aVSucaL2vd42AHytkYHA79HSPbFYwMDjP8Yuv6jnT35Mf+bVJHlE
	Fc/5cTI4IlnHNFGfly+Ip2zf23lN+9kXHMpnTYg4Lr/ycDdd8q3U0B6VVS3z5pXD
	7bkOMrA6Ln1TKIOt2WPWXSgfsM3Mjud6BHgZrSBku3cUyXSGpcICIn0zOjM6q/NP
	fUeOLpdHvpWntYiBQEtN7Lg8LDUBTfyZjTdh/syMSnZ3bGTs2uv1DChvqL3kMO6I
	AKKpsTKgoU4XuQ3QTLg66w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762865184; x=
	1762951584; bh=qPSPi7QKsWbBdZTy5b2peWWJFo3JmlmoZ6aUudf3qcc=; b=V
	unrRh3C50B8nlC2ySniXwHhyhI3jX7KuMzD/qvAKGTr+FjPomCAWJrwjQp7UfSMT
	COn7W9RYQTK7fztKnBilzo14mV1uulpouTCYAEHFZSXwYe0prCaVvL9iSjqOrhOn
	uVnZp3eSjGyVImrA+32aTzsybajHHCU5TuZcn9Qt8e1z3tWdbhjuA1h/LcY0BbbL
	jAb/suWuven/2HAbkb1Cjn8POg3hBaviaECtanR7YfloSuMcfQj5G1nLtwa5RQsK
	7U28JyPW7VXu6X/MSnxC/zBAHCjjUt8/fHkQ3zCFBac36gs6aBtwlPhWrCPL3rLL
	rCMR9eFotMxAkHi5ESROg==
X-ME-Sender: <xms:IDATaW27QQWmFxXXCV1Fjxac0TlGJfwvGc0aDsNfs2cKeSnDtNjonw>
    <xme:IDATaT6Pa3Wpuy-syJNCmiMv-OHamFR8GBcGPduJ0ozl52gAgM873Cc9NTonNZgwA
    ypNCBSJ0rB_44njWIctjYv3BcsPzGn74FsdQjEBGoKF-16LssJAdLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduvdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:IDATaYcNvlAGEPqong-TCBN9LE_UiAUdbzKsopWPbwG_bRD4ozvaVQ>
    <xmx:IDATaURs1P1vO3-jXrv_6sn6sqF3SwIqwfB1iJF8qp-5c0p6NIlQXQ>
    <xmx:IDATaZaMQSfVYyFYSaD97M5SIbOfNXzDSc2ZhVeAni_S0Hop1xHaPw>
    <xmx:IDATafea6NdIYt3gSdap1__-SvRXgkL43zjVVQO7J4tcYA3OIW47fA>
    <xmx:IDATaWjTw9Mlxp8qK4ELluiWv9jMmKwvknWI7lOuIT5NEwg5qE7vckUE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 10E65700063; Tue, 11 Nov 2025 07:46:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVKYIwYTPfqF
Date: Tue, 11 Nov 2025 13:45:56 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <3bdfd610-ec7a-4f3c-ba9f-ec48eecc0835@app.fastmail.com>
In-Reply-To: <20251111-vdso-test-types-v1-2-03b31f88c659@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
 <20251111-vdso-test-types-v1-2-03b31f88c659@linutronix.de>
Subject: Re: [PATCH 02/10] selftests: vDSO: Introduce vdso_types.h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025, at 11:49, Thomas Wei=C3=9Fschuh wrote:
> +/*
> + * UAPI headers from the libc may be older and not provide these.
> + */
> +#if KERNEL_VERSION(5, 5, 0) > LINUX_VERSION_CODE
> +typedef __kernel_long_t		__kernel_old_time_t;
> +
> +struct __kernel_old_timespec {
> +	__kernel_old_time_t	tv_sec;
> +	long			tv_nsec;
> +};
> +#endif

Doesn't this also need to define __kernel_old_timeval, which you
refer to below?

> +typedef __kernel_time_t (*vdso_time_t)(__kernel_time_t *t);

This I think needs to be __kernel_old_time_t instead of __kernel_time_t.

       Arnd

