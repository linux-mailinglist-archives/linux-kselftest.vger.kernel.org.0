Return-Path: <linux-kselftest+bounces-44090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD72C0D287
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 12:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684363BFBAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AB22F3C23;
	Mon, 27 Oct 2025 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="lf95dUxy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qE4sf2xr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7029B8DC;
	Mon, 27 Oct 2025 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564729; cv=none; b=C4WzqV6rc5SBq/Kwnv7t7gmNDHGVHe7RbI6QxRvOujGcbmaiL4dLlekDkgKsYo6aacgPA+ADgOGpEypNWf7dfzB8bnnuG3q93G6RQHAGJzYRKJBKuvwRd3U8xzSczmaZY9q/RV+6XO/RhZeXS5OTiI0Dq0pXComkqVc3tRa76v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564729; c=relaxed/simple;
	bh=mzJ6tgFelr1ieJHNluyutTvelTfoU7hmkhH46j4QKzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7OstRW7RBL8Eu+zagB4QwPo+72LMuLlOQop7oQJoj3G9iJUnNwe8XMKen/nBnFeemlkjxNTLuUjuvKdzLOeTG0GRdmIjFCLVwwpYY61IOd/lAwyaMfWjAHQ7Q2TVGuQZmwNNtDXNIJksDsPe1Nv9ikNDKg3wyxVONqopTWbyJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=lf95dUxy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qE4sf2xr; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C97351D00093;
	Mon, 27 Oct 2025 07:32:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 27 Oct 2025 07:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761564724; x=
	1761651124; bh=t1ECxHugQwC1OkNvzakKYf0xv9CfVeGrcJAJJJWnXQ4=; b=l
	f95dUxybDKtE608vj7RLT7i62smFIz3nrtU4wTY4OOQaXYZgHSGBfndRkcMXduRf
	lr8b1VhQdqtBrUD9ClCgByggGW5KrLSo2TQgaPR/Luyral0dIRmYtegZPkmOjzA1
	lKQKxgwm7aN+XXZZ8cMhMfyKmuH0YuhvW0enzMUUIdo/zjDm47R1ybfqIrK+ZNEh
	oQGjcTnTUpvUn2IEnpopyl7SSiVVPhZUONVEbmCMFn3GvoIpsCDCEC44rglK40f5
	39/JPw7/ERuR03yGZUOX0KgSmlbtG8zpN5+TB/unDFArEyAOph7erRoXbz0Gowa7
	Nu7zNnEhD36r0RnvTzldg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761564724; x=1761651124; bh=t1ECxHugQwC1OkNvzakKYf0xv9CfVeGrcJA
	JJJWnXQ4=; b=qE4sf2xrq00QMi3aVUsYnK3KIjS3GMFE6dOCbg//QvvhOlYqXY+
	OJe1p8lFwx7L1erlL01bgL7dcP+uvD6GBFhr26NvbB4o5WEr7uD2JQTJFTdUDOsd
	de6/ncRvFhaqT4fleKbgnfDjT2tmG8xkrthVkEcLerC/wQQwk7DE3MLZq9qbjbZR
	X/gINeklo9/tiOI5Kg+Bpp0SLQucyxfgdVge+jLSjJu9stzTLaXSDElzdbfQGDKP
	4KSnZPUMHJuN4mTp9Q+yN1UqeUMR5IQGNPzLY+Xgn/oYNUVELx3Cdu9cEjXwasm6
	u3fHrax5203zac5d2SXVVjvgc0As32vFUbA==
X-ME-Sender: <xms:NFj_aL1JpDvxc60KWMktgBtFDfCKlKY_lZjlXQWnJzbkH-YJVOCd4A>
    <xme:NFj_aNwmNX2HwbaL3dr_LhacYROHOO-hwlKGOiK8rMDhM7tyjsKNjeNEXpVCXgB8u
    F63EZEc0Qj_9QlzZSWFy3JyeqyJv3hMzLRPpvWxIK33eERXmspWiMY>
X-ME-Received: <xmr:NFj_aEiB0nL1qlfv1ohBS8DE5_QvA35kJsLnuz2IoZToQQgZVzxC6JEXZheH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnheptefghfevheejueehgeekveeuueevgfeggfduieefhfffgfellefgteef
    iefgvedtnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhfrhgvugdrohhp
    vghnshhouhhrtggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmh
    hlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:NFj_aCMDqNK2xsTNO6WUNBa_TxtsPb2bU6qKM5GMhqEmTxCFcqvCLQ>
    <xmx:NFj_aPdPCQL3S7GvrRZqvgH-KD44AaRzl9BgCxpYtEThfe-g1NmeMQ>
    <xmx:NFj_aEw1ocP_UjgVnUf4zzM5tihv2VbpKNv2p17lV0BZYIH4LgPPBg>
    <xmx:NFj_aM2MEQ6jwVwdcHDnWs44a3gxjU6FKHw5tPDnHBScnwMkfBQVZA>
    <xmx:NFj_aFdre-8YRlbTSx6l6ru3Ovxa9seYmG63-sPmTz64duzxfKCs9QNn>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:32:03 -0400 (EDT)
Date: Mon, 27 Oct 2025 12:32:02 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wilfred Mallawa <wilfred.opensource@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v8 1/2] net/tls: support setting the maximum
 payload size
Message-ID: <aP9YMiW9V7Dkhu_1@krikkit>
References: <20251022001937.20155-1-wilfred.opensource@gmail.com>
 <20251023184404.4dd617f0@kernel.org>
 <cd557c5b11b04da060f07d3849dc46e7b3625ed1.camel@gmail.com>
 <20251024163336.5fba5cd1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024163336.5fba5cd1@kernel.org>

2025-10-24, 16:33:36 -0700, Jakub Kicinski wrote:
> On Fri, 24 Oct 2025 12:11:11 +1000 Wilfred Mallawa wrote:
> > In the previous record_size_limit approach for TLS 1.3, we need to
> > account for the ContentType byte. Which complicates get/setsockopt()
> > and tls_get_info(), where in setsockopt() for TLS 1.3 we need to
> > subtract 1 to the user provided value and in getsockopt() we need add 1
> > to keep the symmetry between the two (similarly in tls_get_info()). The
> > underlying assumption was that userspace passes up directly what the
> > endpoint specified as the record_size_limit.
> > 
> > With this approach we don't need to worry about it and we can pass the
> > responsibility to user-space as documented, which I think makes the
> > kernel code simpler.
> 
> But we haven't managed to avoid that completely:
> 
> +	if (value < TLS_MIN_RECORD_SIZE_LIM - (tls_13 ? 1 : 0) ||

We could, by taking a smaller minimum payload size than what the RFC
says (anything that allows us to make progress, maybe 8B?). ie, I
don't think we have to be as strict as rfc8449 (leave the userspace
library in charge of rejecting bogus values during negotiation of this
extension).

> I understand the motivation, the kernel code is indeed simpler.

Also more consistent: the kernel syscalls work with record payload (at
the send()/recv() level). The rest is hidden. Userspace could try an
approximation by sending max_payload-sized chunks with MSG_EOR.

> Last night I read the RFC and then this patch, and it took me like
> 10min to get all of it straight in my head.

I don't find this stuff very clear either tbh, but maybe that's a
problem in the RFC itself.

>  Maybe I was tried but
> I feel like the user space developers will judge us harshly for 
> the current uAPI.

But userspace libraries have to do the same computations on their side
if they want to implement this RFC. They have to figure out what the
max payload size is as they're building the record, they can't just
chop off a bit at the end after filling it.

Quick grepping through gnutls got me to this:
https://gitlab.com/gnutls/gnutls/-/blob/eb3c9febfa9969792b8ac0ca56ee9fbd9b0bd7ee/lib/ext/record_size_limit.c#L104-106

So I have a slight preference for not being tied to a (kind of
confusing) RFC.

-- 
Sabrina

