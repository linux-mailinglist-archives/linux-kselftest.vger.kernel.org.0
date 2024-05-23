Return-Path: <linux-kselftest+bounces-10613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63A8CCE28
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 10:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E471F21D4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4908313D254;
	Thu, 23 May 2024 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="bbi9wCEX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IrVVz1iY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1413CFB7;
	Thu, 23 May 2024 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452686; cv=none; b=WR+Q6kyd8etbRAaddKsSOhvLntgLkSduhjKNJ8jBdDELY7bYzq+C11EttiC+X+JShfF6Wqrrrzx7gOhj7QCjfIYAMvQ3ZHE97HYP2jWpfWOdLQ3/wCuBgGae0RaMfioD4Fwxr4jvSdAyhguN3OsPvjAVY7nDjKyj6Sky8Wls36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452686; c=relaxed/simple;
	bh=xP59lqobFIBfQ9MOhx/Wcx58biVRgohQI2O/XYsPjxc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pCvGJl64b7JM8zDmW0S3zSGbzhUYG7uVLkbaRPcEOBFulKclbTkENUE4/I7poGjGglpk095hXvUKgNhevQxW3FpGzo41pbsMJPvVxiRR7BVlYVHAYiNhHE++hFfaD6pCjgOQ6EQ3uHlno24CXWZmFWxzK2loaDLBvMvwqqmst9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=bbi9wCEX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IrVVz1iY; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id CEE1718000C3;
	Thu, 23 May 2024 04:24:40 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Thu, 23 May 2024 04:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1716452680;
	 x=1716539080; bh=uQ1XIZZzVzDnVHgFVVR9WB3UmecDQC4WcoxUGP3/pSA=; b=
	bbi9wCEXusq1PCAmAYxC4BiT27Y40Ap08kAkdhBLZgdMw/bGbiv2m8vsxcFVgmru
	q1OKDPeRBpEmFr9Cux8fOA0Av7QX/pUbN56fvGRN/GQ3Yq3+4uCieiqqF9VrX/ey
	B+RX/qDbkSBDH9dILn59EbowqykCzjPEExmQxTMNk8r5HlV7752kVMwqN3I83ZVl
	rrdP3OOhATAc+/OiEq7j9stxIgCA37KIB+ELIm7YnWK93kLM2SLBHZmlGUoDnOc4
	e5TXMv56KeOVl4RoJitRzb72QYevGQ4n0yqQpO6ae1Qwvambj+iSimpMjcuQqbb2
	s83XtM7ZZ7b6w6echlAw6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716452680; x=
	1716539080; bh=uQ1XIZZzVzDnVHgFVVR9WB3UmecDQC4WcoxUGP3/pSA=; b=I
	rVVz1iYth6Czg8j1qlzSei4KHsHk6i+iAIZb4h97+FiMw3x2pC1Wx8pjym0Y2czl
	PFYMs18JfaAGDc3KXI+uViAvvsi2a+OWbTUeyMX4JzMmW8pYVy+aabMwvk+O1t0j
	cFsoE0nhI6EMqrwcvF+vjkskxERjNkO4DG2VRh7aSm1GlttBA9EOUFRISMvIe/Ds
	SNEXzqJ+1twWXspR4etxVWREVenq7W6wRzr3OwswSNFVFgAQ+O3WComfcxo3QA+W
	GM4uNOKBx77LmoBwx6tG7FqCy1pYoASliHS+fJFT7VMvpPYiUtz8xaGpgPRuxGB3
	0Y6ab0XbWd3sMsnygt6tg==
X-ME-Sender: <xms:SP1OZp23Z6lyzNyhkGuoc2_RiEJwcR3eXBFXARD6DAvZZlV0o3BRmA>
    <xme:SP1OZgFY0gJZvgIkAtLu9GzYQk8Jiv6zbtkneqGrLD_7AB9yiNlG4QYhyG9K8rd8Y
    XGHvv2p9aLSv0TTJ6M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdff
    rghvihguucfthhgvihhnshgsvghrghdfuceouggrvhhiugesrhgvrggurghhvggrugdrvg
    huqeenucggtffrrghtthgvrhhnpefgleejleduiedvfeevjeevieduledvjeeljeelvedt
    uedvgeejjefhvdefhffgieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrvhhiugesrhgv
    rggurghhvggrugdrvghu
X-ME-Proxy: <xmx:SP1OZp627CQUZWumLRL_y-qFCF8hLB3I_CJJ-288c8wJL0uEyoEHaw>
    <xmx:SP1OZm0hZweVYJ7PfqXhwrHOtjDgYYL_IHV1P1epwocPM5W6oS8L5g>
    <xmx:SP1OZsHtsGGbu5IdrbmPdtYaN6EYt1XaXNXdkZnlty2tM7HQISjwpw>
    <xmx:SP1OZn89w5r0T-DPR_WTli6ZgQDYgM40w60wq8SsHpcCqi_kBvVgVQ>
    <xmx:SP1OZv-tL447aLQolAZ5j1fj4aFENRlMnunOutk3TL8Ah6wvvVC3ket9>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0828D1700093; Thu, 23 May 2024 04:24:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <08450f80-4c33-40db-886f-fee18e531545@app.fastmail.com>
In-Reply-To: 
 <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
References: <20240513191544.94754-1-pobrn@protonmail.com>
 <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
 <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
Date: Thu, 23 May 2024 10:24:19 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Jeff Xu" <jeffxu@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dmitry.torokhov@gmail.com, "Daniel Verkamp" <dverkamp@chromium.org>,
 hughd@google.com, jorgelo@chromium.org, skhan@linuxfoundation.org,
 "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, May 23, 2024, at 4:25 AM, Barnab=C3=A1s P=C5=91cze wrote:
> 2024. m=C3=A1jus 23., cs=C3=BCt=C3=B6rt=C3=B6k 1:23 keltez=C3=A9ssel, =
Andrew Morton=20
> <akpm@linux-foundation.org> =C3=ADrta:
>> It's a change to a userspace API, yes?  Please let's have a detailed
>> description of why this is OK.  Why it won't affect any existing user=
s.
>
> Yes, it is a uAPI change. To trigger user visible change, a program ha=
s to
>
>  - create a memfd
>    - with MFD_NOEXEC_SEAL,
>    - without MFD_ALLOW_SEALING;
>  - try to add seals / check the seals.
>
> This change in essence reverts the kernel's behaviour to that of Linux=20
> <6.3, where
> only `MFD_ALLOW_SEALING` enabled sealing. If a program works correctly=20
> on those
> kernels, it will likely work correctly after this change.
>
> I have looked through Debian Code Search and GitHub, searching for=20
> `MFD_NOEXEC_SEAL`.
> And I could find only a single breakage that this change would case:=20
> dbus-broker
> has its own memfd_create() wrapper that is aware of this implicit=20
> `MFD_ALLOW_SEALING`
> behaviour[0], and tries to work around it. This workaround will break.=20
> Luckily,
> however, as far as I could tell this only affects the test suite of=20
> dbus-broker,
> not its normal operations, so I believe it should be fine. I have=20
> prepared a PR
> with a fix[1].

We asked for exactly this fix before, so I very much support this. Our t=
est-suite in `dbus-broker` merely verifies what the current kernel behav=
ior is (just like the kernel selftests). I am certainly ok if the kernel=
 breaks it. I will gladly adapt the test-suite.

Previous discussion was in:

    [PATCH] memfd: support MFD_NOEXEC alongside MFD_EXEC
    https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead=
.eu/

Note that this fix is particularly important in combination with `vm.mem=
fd_noexec=3D2`, since this breaks existing user-space by enabling sealin=
g on all memfds unconditionally. I also encourage backporting to stable =
kernels.

Reviewed-by: David Rheinsberg <david@readahead.eu>

Thanks
David

