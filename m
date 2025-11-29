Return-Path: <linux-kselftest+bounces-46724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF9FC93BEF
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 11:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C7333468A2
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BE626D4CA;
	Sat, 29 Nov 2025 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dkbF/YgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ToluMmLW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73122B5A3;
	Sat, 29 Nov 2025 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764411733; cv=none; b=moySxT8IqPuvXIo1qs5NGHYXxT211o1SNGbozRBgOjFG78UmffPRN05ar4J1UsVE89NCmT+TE8QOtdYzisODwaJpvBG6sdrYw7wRd1T0VE4bjHUtMqYwU3Me1UsyXxvWCnbLbtQpVRBSgi8XrHGTbZZeH2R6TB08OrVeQuFbhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764411733; c=relaxed/simple;
	bh=oVz44O4lt9xJul45styEiQsd5Qo4kmSSz0E2+IoHbdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPSIqhymYb5RKIYD6yIg+9WVXMuldxP6PIKxZN/f/AZ3qLUE74eJTmt8y8FGFqfnUPXw40XePN9vkcbGnNeXncZohl7cxQZSkDCZrUDeanvHrVKzDMNYZbeUDEe28ywkL2Mx4OT074SdK3shIIV4N7DtozdajhFX3aHjbmMC7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dkbF/YgT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ToluMmLW; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0477DEC0101;
	Sat, 29 Nov 2025 05:22:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 29 Nov 2025 05:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1764411729; x=
	1764498129; bh=jlPq/Wh5BfJbRcxs5REUD2RG4sozKHuQgt5SRlpBaA4=; b=d
	kbF/YgTEk/mvpv+u80Ys0Atl7ZniPzPKaqAdnNN8CMyemobQxJuI+EFKqjq2r5jh
	wuoBTWuedGHQbKW5C26sAss6TGX9CqijY59prIJypAERum9VatV08pI5YVVnus2L
	gpR4hLOaUyhNtfiGffgjjHJyCT4uAVGylgS2G6oE6CUCKyyfPllS4BSVx9F3OffZ
	zUEAJE9zBajvT+zBlrNQwtnPDqkRf7J9+sHSVXGK2uN+uLqUYCeuDams1BTcFtFU
	tUhWwNEsb8/OutHdti5LGOTd/xWfwRf/MlwGp/2y6sZcstL+LzOQ374/f9m3LEBZ
	tccJUMerLLDtaEq70f8cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764411729; x=1764498129; bh=jlPq/Wh5BfJbRcxs5REUD2RG4sozKHuQgt5
	SRlpBaA4=; b=ToluMmLWPwrKiANLLaL+5rLfsokdw7XsNN2srTOy7V221n5FQKU
	SnTT/dmEE1+qq5IGN0CClgQUY8j73ubJ+g9B/RlBBoohhM+XxlrkD6k7RL0Z+Sp6
	6K9I7YUoST58GZ/YgSX5b8yPLZJG80SxMBllLXgn3UzQNOhFfb2W8qwL0DZpeIW0
	+6oVYh6hCPz7TZUxxl/QOVs6G83ac3EB5fi52z+EEVWhYuhSs2RGvZAXWW+cm7wI
	OT40WKrgsTkmT4lV5lPo8090V2gg81rW1xxBaydwaGOZSDfNswCD57bIxC4wMOX/
	v5Wq+q+qdleNaLmyyXFMDiPYrtiWAxkGsRw==
X-ME-Sender: <xms:UMkqafYGWYcuJdUoFVZJVpMipl_uXfYzDzJJVz4k8lDX0d1wUqOdaA>
    <xme:UMkqaUZy8zRDQCbld7l8127RwtUltnDROl2pxxOGIUmHL7kuqPoSwNHCtc-AB5GJN
    TYNIt1wfM9gBVQb0kxwncfI8Rm_rkfjQApknimyd4eOfk_3yy-Faw>
X-ME-Received: <xmr:UMkqacz0muQlQet9M6uwSORlonUxAiRLfmXR11ZrFxA9zjYuI3pcukcKTsxkP0vHTHnYGcAMBFr0ccPvnAQPIkP1_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedvvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrnhhkihhtkhhhuhhshhifrghhrgdrlhhinhhugiesghhmrghilhdrtghomhdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuh
    hmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtth
    hopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:UMkqaYeTa-QXFWrPb87OZNYvDNMw8RZjKZTYQIaL_T33qCeNgA0keA>
    <xmx:UMkqaZ7cR4TV17GOzc0JFVOEovtrer_h3Glyw-Jjc2M1ksI680syEg>
    <xmx:UMkqaVJp76qGzRDrqGiIHCHS7BtYrcTqD6AsFaY-BNsl3N08fMYthg>
    <xmx:UMkqaZzHdQugoLHZlNdL_PhSS9SP0KyTzcHv6BNkLx61OZP_keCMPQ>
    <xmx:UMkqaTb8vGRoPm3lmQGgdfwSEOJxZsRTWylUzLnUZg5G-wA7PrdHFHLe>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Nov 2025 05:22:08 -0500 (EST)
Date: Sat, 29 Nov 2025 11:22:06 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: tls: fix read/write of garbage value
Message-ID: <aSrJTmtJqOX0rNDh@krikkit>
References: <20251129063726.31210-1-ankitkhushwaha.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251129063726.31210-1-ankitkhushwaha.linux@gmail.com>

2025-11-29, 12:07:26 +0530, Ankit Khushwaha wrote:
> In 'poll_partial_rec_async' a uninitialized char variable 'token' with
> *garbage* value is used for write/read instruction to synchronize
> between threads via a pipe.
> 
> tls.c:2833:26: warning: variable 'token' is uninitialized
>       when passed as a const pointer argument here
>       [-Wuninitialized-const-pointer]
>  2833 |            EXPECT_EQ(write(p[1], &token, 1), 1); /* Barrier #1 */
> 
> Initialize 'token' to '\0' to prevent write/read of garbage value.

I'm not opposed to making the compiler happy, but in this case
"garbage" is completely fine, we don't care about the value.

So I think the subject and the commit message should talk about
"silencing a compiler warning" rather than "fixing use of garbage
value".

And your patch should indicate the target tree in the subject (here,
with [PATCH net-next]), see
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

-- 
Sabrina

