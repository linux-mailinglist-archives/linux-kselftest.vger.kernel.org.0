Return-Path: <linux-kselftest+bounces-42648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2F7BAF777
	for <lists+linux-kselftest@lfdr.de>; Wed, 01 Oct 2025 09:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78E61925BA3
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Oct 2025 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A5E2749DF;
	Wed,  1 Oct 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="2yJQLHZD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ytzwukjg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420627466A;
	Wed,  1 Oct 2025 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304652; cv=none; b=PnXeS8BZS+7faO9+M+4GkHkVs38jQqeJotVi0ah8T56Q/EML94k7HMwxmay0wk1vp24NtIrqfP/0CAkIcPy+dO2/8IJwaDD7JAFFVfLkutns3dXxoz/2xSCW/tVxvRLilawTclunBYyJvHcmJtnk3PIc+6RF8hBxftXdS9ltmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304652; c=relaxed/simple;
	bh=TysUxZAI7LSN6xvPr/nHtn375364lWz7ysdJrpYsi7g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e6yj51xRxIFCmpBXeDjhheo9Kjvd+iq+rQA/JKAa+GQIIDmyFPfBL+e5ith2WyIN4DvhZon5rUA1dcLIDtsVekF+cOKLpZrOOPq2wBE2LYTtlQESOekXTxKp70Zd9uB2mvhzZuyFDc1wFLWak6Zd7o9/RWvYglmWvZ3phqSf+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=2yJQLHZD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ytzwukjg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6CF91400042;
	Wed,  1 Oct 2025 03:44:08 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 03:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759304648;
	 x=1759391048; bh=sagFfB8etWtWcyIYJmDr4YdUwZeOCagtQBCzT2iAgEU=; b=
	2yJQLHZDNZsXBF9lD/7oBQhUCkBq1uHVWKyFgz/GlOk3JGMS3vKdIOqHR3dKdEsA
	D7K2khMcXkRPlSSSl0r5+XBWATlgpRAMXeEIaQVEInYlgYl3/6LU2kELN8n29ROq
	3G5kvRes0cyPDXxlJ1AReLvk/2sgwoknHSthIu9ZEwXRZVR8rYa/dPe1osnBRpGe
	cXjsUZ9AIiXhVUYJqB8znNgyIEF/2QCwbND4sRcv/pj4jKUBVfZThZncImSbD5Av
	n+3UyhmuG9nWsbdgrEaPPAYpK2PeowIXQFS0HyjC2QszOIdGv6RBtxSjVCWUcnM5
	Om5OTHSRYMH4eJ5FLLjtrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759304648; x=
	1759391048; bh=sagFfB8etWtWcyIYJmDr4YdUwZeOCagtQBCzT2iAgEU=; b=y
	tzwukjgLv55xRL35/gPXwAd8ovGvE0BJdpi4ocS8gSulQe+3vNiGLr8xd36kq0sj
	HazVs/6f4Fzsumrq1e4D4zQXh87KqXzkBTp0HAXJvoMtDf4Ee09PerQXkVtTPOhd
	j3kS6BNOMHgVpxYcQKqY4tleNtWZLJ3SyBopzviCZymBsmoGooKwzMitad1x1BGA
	MRW3wzv+3GRg3ZMUFhnrmI+bT/35zqItgVXhyvzcI/sD3x/nplR4RGblC+7S2JUb
	bCP3yNYCSUA2Kx5z7Bkygo2ShN4RTisJhbtaR4mpJ2fNxZCKbzwe+R72Dqte1eVP
	YZ0YS5jBhR73skTrqRt2g==
X-ME-Sender: <xms:yNvcaAkQiT0W4FWfWQPOdkLE2uxgga1Net3WFQydGZu33lf-CXpV1w>
    <xme:yNvcaKq9nsmw6vgwKzX6RQ4dlwEntBIGihOBVm8FYb2AVR7yS59u2eX-rU4AW6cHB
    kq9S4H5aFF8Y7-KV9J07PfccmWbTfAdlickHM2TxMbtjQVSNQwa4tE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopeifsedufihtrdgvuhdprhgtphhtthhopegtrghtrghlihhnrdhmrghrih
    hnrghssegrrhhmrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfi
    hilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghr
    nhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugiesfigvihhsshhstghhuhhhrdhnvght
X-ME-Proxy: <xmx:yNvcaBnFZWf9lPl75QgGYQYeI79FANEE-P78Oy7yFlcHlDyEfRALEA>
    <xmx:yNvcaJZIQU4FNAIvJAoDzoRtSENz2UQLf3hFB3khCnwfTXpoycPLGA>
    <xmx:yNvcaMHk8GrCWy0KTxWoNhdb87gUFPbgKfy2RTzybnd6i66hMr1WPA>
    <xmx:yNvcaIbNd2ZNDTZqwh8wkoZeCtbGJUw1MRwukBEk05VKVeLi9CmXKQ>
    <xmx:yNvcaBZKFON6Jdupivinfex_YHfhm430aEx8pha-eUyfmefOqURhbTg9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1D053700065; Wed,  1 Oct 2025 03:44:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQeYErt0RC5c
Date: Wed, 01 Oct 2025 09:43:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Willy Tarreau" <w@1wt.eu>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, shuah <shuah@kernel.org>
Cc: "Mark Brown" <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org
Message-Id: <cec27d94-c99d-4c57-9a12-275ea663dda8@app.fastmail.com>
In-Reply-To: <20250821-nolibc-enosys-v1-1-4b63f2caaa89@weissschuh.net>
References: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
 <20250821-nolibc-enosys-v1-1-4b63f2caaa89@weissschuh.net>
Subject: Re: [PATCH 1/7] tools/nolibc: remove __nolibc_enosys() fallback from
 time64-related functions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025, at 17:40, Thomas Wei=C3=9Fschuh wrote:
> These fallbacks where added when no explicit fallbacks for time64 was
> implemented. Now that these fallbacks are in place, the additional
> fallback to __nolibc_enosys() is superfluous.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Hi Thomas,

I just saw these fly by as they made it into mainline and
I noticed that there is still something wrong here:

> @@ -39,10 +39,8 @@ int sys_poll(struct pollfd *fds, int nfds, int=20
> timeout)
>  		t.tv_nsec =3D (timeout % 1000) * 1000000;
>  	}
>  	return my_syscall5(__NR_ppoll_time64, fds, nfds, (timeout >=3D 0) ? =
&t=20
> : NULL, NULL, 0);
> -#elif defined(__NR_poll)
> -	return my_syscall3(__NR_poll, fds, nfds, timeout);
>  #else
> -	return __nolibc_enosys(__func__, fds, nfds, timeout);
> +	return my_syscall3(__NR_poll, fds, nfds, timeout);
>  #endif
>  }

The change is fine, as there is always at least one of the
time64 or the old syscalls implemented, for any of the affected
calls.

However, the problem here is the default to the old time
types on 32-bit targets, for two reasons:

 - this fails when turning off CONFIG_COMPAT_32BIT_TIME
 - the old types are often too short, both for the y2038
   overflow and for the file system types.

I suspect the problem is that the kernel's uapi/linux/time.h
still defines the old types as the default, and nolibc
historically just picks it up from there.

The proper solution I think would be to do the same thing
that klibc has and use sane defaults for all the types
along with the modern syscalls. At least __kernel_time_t,
__kernel_timespec, __kernel_ino_t, __kernel_loff_t and
probably a few more. We should also consider drop the
legacy type definitions from uapi/linux/time.h and
require each libc to define their own.

      Arnd

