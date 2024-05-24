Return-Path: <linux-kselftest+bounces-10667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853848CE6CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 16:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3C42813CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5666486643;
	Fri, 24 May 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="v6rR/A02";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m79tD6Sr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A925686279;
	Fri, 24 May 2024 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560145; cv=none; b=uXITjeFCcj5oouGNBagDYtkCqONxqtX6PDAeANskAyVu98y90bdqv8/QNo6zqrJ+AZnaSwVaFstKPSBv3MY01T945avXgzy9FCACgT53MTlOS0wqnTy7l8ItuQIfyTg98yiMESKDItEsdraIO9KelkDyq/Vl6h+ZXMZHs4ecuuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560145; c=relaxed/simple;
	bh=EXGqEZ+6IZa4t+vQ3br7xmeU+42xs9OcjiGVeuVCtOg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BkKU13AzBGpp4hrmiptXAUuXehuUDzBHCfxYijd/3ccpvqDAF3Y7thMjWicMFZVD4FXPXxF7z0tHbKEEh4HjH27KX5mOXRI0ZPYsJlPCwCwr8g3see4jS8HUyQ18Ptpmjw1+x2OMW4yY/4Ry0U1hZ8Ed/7yZ4a6bD1MEqHIcM3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=v6rR/A02; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m79tD6Sr; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id B33BE1800122;
	Fri, 24 May 2024 10:15:39 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Fri, 24 May 2024 10:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1716560139;
	 x=1716646539; bh=SX/ETyfE9F87YnrwRyr03ccHrX8ow3V9bkqTKeM04kI=; b=
	v6rR/A02Ruy16iWS6ZBc6fQaUbkzd7fhoSdR7XuFBW+6lRqbYkD1Q/zgMyaNW0JI
	HGkLx3K/2yz9MADgxKjl2Zr7SNDijV/AVL6mTMxqg1WWPz76Uk1sSz8B+OOLdEgA
	5HtzcOdaER2bv21IoM0OZu8DVn1a7B8oAwOFnX7fvIZtNxtY+hXg0Bh0DxibDiYj
	j3eoEJctlY6BI+NGu9f4Lzimgz/96bMrK43T+sub2YOz0YTc2Iy0vAtJNdomnavb
	sTAJ8gcNeiLWOSRci9zoZp8wngEtUwMrIbXZHa+fVMGl2PrpzGsWTgo/HDiaPRvE
	AJWMLO0M+qEO5/8wjSim/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716560139; x=
	1716646539; bh=SX/ETyfE9F87YnrwRyr03ccHrX8ow3V9bkqTKeM04kI=; b=m
	79tD6Sr8WShuEz7/pN+BUHj8WoSUFBqud4bBvEao+oVGHHX+H6lksrlSNDl0AoNX
	K15AipgiBHVtBl7qhqAp6pYFylrMnMGHjlTgpfVciD/FTq9COhGt/9V5x8wGCzCa
	DzBHavzXv6cLssOpVOYJpGKGzcpiTAxzT8E0VKwi8ntrvrUC/iCz26m4lAcRFzge
	om7zSS3XgrAS6NxMEmjdkwyLSW+1b+WpYLmde8+4dBL+pGTqFoUgxJ5zefsOgqKi
	ox35v7j8wAQ4r5riW5PeUmLN0bjf8hp8z/CmY4Cp+hzi2awlRjD/O9pRpEg+TES1
	vfkyix+YDWj88GNIRYO+w==
X-ME-Sender: <xms:CqFQZpfW6zqJtLtPvnKLvRU8aKos4TCzPnnxwvBnZUc1MQ9eR-sUgw>
    <xme:CqFQZnMkYAbQlVGybXkF8pPwtMIMv1SXV4GCnhfFPxBnUnFGk4o1kxq0pLE2-XMnR
    54AEVrvnoP_jG6_wI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdff
    rghvihguucfthhgvihhnshgsvghrghdfuceouggrvhhiugesrhgvrggurghhvggrugdrvg
    huqeenucggtffrrghtthgvrhhnpefgvefhteeivddvkefhveekfefgvdeuleeiffeihfej
    vdettdevvefgveeugffhleenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegurghvihgusehrvggruggrhhgvrggurdgvuh
X-ME-Proxy: <xmx:CqFQZigvE2PZLctxOyKy2_1paXAx2z5Ona3v8BHwPanW9s5Nd-325g>
    <xmx:C6FQZi9wTNkD7YDLuamsDR4oJkPb8Em3gkdHVb99FdjrG3sBnh_Nfw>
    <xmx:C6FQZlvC7Zvcep-wCnzQk08fq2Hk94oK2iZryQJFHUpx3logYyQdtA>
    <xmx:C6FQZhEfpJeOnDoSyRHv2hWtkHWB_C719RBfNJGGhbZ8Ha6WMtf1Ng>
    <xmx:C6FQZlFSBHsoOBIemMsgghotBoCfBV6bxvJ5sdLGL-Y8cEdwpU50t5P6>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DAC861700093; Fri, 24 May 2024 10:15:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <79b3aa3e-bc70-410e-9646-0b6880a4a74b@app.fastmail.com>
In-Reply-To: <20240524033933.135049-2-jeffxu@google.com>
References: <20240524033933.135049-1-jeffxu@google.com>
 <20240524033933.135049-2-jeffxu@google.com>
Date: Fri, 24 May 2024 16:15:06 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Jeff Xu" <jeffxu@chromium.org>, "Jeff Xu" <jeffxu@google.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, cyphar@cyphar.com,
 dmitry.torokhov@gmail.com, "Daniel Verkamp" <dverkamp@chromium.org>,
 hughd@google.com, jorgelo@chromium.org, "Kees Cook" <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org,
 =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
 skhan@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memfd: fix MFD_NOEXEC_SEAL to be non-sealable by default
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, May 24, 2024, at 5:39 AM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
>
> By default, memfd_create() creates a non-sealable MFD, unless the
> MFD_ALLOW_SEALING flag is set.
>
> When the MFD_NOEXEC_SEAL flag is initially introduced, the MFD created
> with that flag is sealable, even though MFD_ALLOW_SEALING is not set.
> This patch changes MFD_NOEXEC_SEAL to be non-sealable by default,
> unless MFD_ALLOW_SEALING is explicitly set.
>
> This is a non-backward compatible change. However, as MFD_NOEXEC_SEAL
> is new, we expect not many applications will rely on the nature of
> MFD_NOEXEC_SEAL being sealable. In most cases, the application already
> sets MFD_ALLOW_SEALING if they need a sealable MFD.

This does not really reflect the effort that went into this. Shouldn't t=
his be something along the lines of:

    This is a non-backward compatible change. However, MFD_NOEXEC_SEAL
    was only recently introduced and a codesearch revealed no breaking
    users apart from dbus-broker unit-tests (which have a patch pending
    and explicitly support this change).

> Additionally, this enhances the useability of  pid namespace sysctl
> vm.memfd_noexec. When vm.memfd_noexec equals 1 or 2, the kernel will
> add MFD_NOEXEC_SEAL if mfd_create does not specify MFD_EXEC or
> MFD_NOEXEC_SEAL, and the addition of MFD_NOEXEC_SEAL enables the MFD
> to be sealable. This means, any application that does not desire this
> behavior will be unable to utilize vm.memfd_noexec =3D 1 or 2 to
> migrate/enforce non-executable MFD. This adjustment ensures that
> applications can anticipate that the sealable characteristic will
> remain unmodified by vm.memfd_noexec.
>
> This patch was initially developed by Barnab=C3=A1s P=C5=91cze, and Ba=
rnab=C3=A1s
> used Debian Code Search and GitHub to try to find potential breakages
> and could only find a single one. Dbus-broker's memfd_create() wrapper
> is aware of this implicit `MFD_ALLOW_SEALING` behavior, and tries to
> work around it [1]. This workaround will break. Luckily, this only
> affects the test suite, it does not affect
> the normal operations of dbus-broker. There is a PR with a fix[2]. In
> addition, David Rheinsberg also raised similar fix in [3]
>
> [1]:=20
> https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46f2=
67d4a8784cb/src/util/misc.c#L114
> [2]: https://github.com/bus1/dbus-broker/pull/366
> [3]:=20
> https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.e=
u/
>
> Cc: stable@vger.kernel.org
> Fixes: 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
> Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Reviewed-by: David Rheinsberg <david@readahead.eu>

Looks good! Thanks!
David

