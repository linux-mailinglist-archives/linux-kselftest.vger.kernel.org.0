Return-Path: <linux-kselftest+bounces-39385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A0FB2E1DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3FF1C80324
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606119C55E;
	Wed, 20 Aug 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="sIq1+y+J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z/YTTtwm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552522172E;
	Wed, 20 Aug 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705628; cv=none; b=ThISQeC7g4m1V9fjgsUadtp/0ECzWdrC493BPLl7sjBuwBMEQnS1Yakp+X3TZ5t9NdkXDf9hy3+oaW3OqUSbVTa1ixmQCkHIfsai01V3UKbQ3MypAaIpqMVIEoFaKRzxEx6mmrF/BE/Sb5ohwLsL4ljEVuf+iy9oZ6RO/mbzrec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705628; c=relaxed/simple;
	bh=pdFbjSbrfhG2E0+g74s4CU0XrSLCyCQ0XaRfgWqM0WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nniTTWycZ7lsU28AwMDe3p5EFB46BjuazZ/C1w76nK22FSKqpVR/3NJy6F6pT7lmzEmj7U9beOUUYvn17wxxUbGbCEkwcSFsIYA4uCoEalejLRXvCGOsCMHo116hWhysw2yqMC+uQWR6VkRJsmcfoxZoOJxY+kIOuP8OPDIWEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=sIq1+y+J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z/YTTtwm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E2A61D001CC;
	Wed, 20 Aug 2025 12:00:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 20 Aug 2025 12:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755705624; x=
	1755792024; bh=loU7CBBnyjUHgCGgbBNnfXmum/NSUm60FC9vJCJIlc4=; b=s
	Iq1+y+JdlG9Goidt7+N+iQqUdRElWituLyN9dkccE6PihBfKDNs5zfJoftd7O+5q
	bQDqGPIT+iFoufs8EheN9u+oMoQzlW+NuPQETQMnKVHYdEyk+m7HeZvhPawgbtM+
	uxkGlM8TTR7hobyQKuY/wS6+Xe8nvJguIbw8BQyHm3G8ORGix7kSjtgJZjeypLJP
	3V5gew/r8kSeeV8QB1s8zGOKIeN1PLB/9AWZ9ytkbA97xoGajQbWfvr9TpjVTwmP
	x+T0J0KGEYPjjLVXpeXSpjtWpnAMapiAp6ekWSGZ0H8V6SMMxzBZjLDEEon3LHEW
	MQ3+QdmAVeEBl5Gg2IEjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755705624; x=1755792024; bh=loU7CBBnyjUHgCGgbBNnfXmum/NSUm60FC9
	vJCJIlc4=; b=Z/YTTtwmkGFZSTwD0z4EPer6Qjddncec0sL+SFQcFB736CXdp5Y
	bO812v0lvFWDQ1dfVY3rQauonAm0Owv4xzw5JN0bLLiV0TCgoDaWmYwUWSBYoio3
	7zmpHS4xGgVQS0lDfXUzL8VhSOYGyM1dAMHKcWJ6Ha2nT/zX/KMhzEB0//0+/pwJ
	1cdKdgoLFCUi96s6OwgJXvOCKxhM5nK+855UkwuEC4SPZ5ze04rEnjroE8I0ldI6
	zhGxzc8isMQ5tDH4AYj+sdCa0f6+qxz0hU1fRMoS/4XgpOq+McdVR4dqjRvjs6cw
	iS/zAmZHyR2oWuFd+UNE0iFo8IfXNMg8NNA==
X-ME-Sender: <xms:F_GlaOqq11QgEN9_M5B55o17OozL81lgnrHzWL2ciu3kSUwBbUGvEw>
    <xme:F_GlaKDZN7tN_HUdWjFTs8dVtPB8N4aD87_jZGe3bW9ib0J_PUmdKS2OFLCeBnj07
    4nJl4yukTbsvBtc6VM>
X-ME-Received: <xmr:F_GlaKjgzxxgprt2EdYZfq8h3D1BViwuDVe1vHtXqVXfuBVMvrY4NJw02ES1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuieduge
    dtfefhkeegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgv
    thguvghvsehluhhnnhdrtghhpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprhgtphhtthhopehj
    ohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:F_GlaIYA-mbdlKKH2vuEuirrYXPibSu_xR0wrkXgW4elgYnk6KaT1Q>
    <xmx:F_GlaLmt5Obyn-_gqAT2YvLLOnRZcIbPlgU7kBo1gDxdPh8rUdsMgA>
    <xmx:F_GlaOjveOHdJ_oJjkloV16ptBshWaM4Cgtf9IBtyVLAtgVw3xHAGg>
    <xmx:F_GlaNQbYWRrXHQGgzu4nAZfhndXHFdmTjnycpvr-OtrjYONyEz9BQ>
    <xmx:GPGlaKemvXmcHt88wkdP38eWDamEsUlFS0ffRrRlkpQTtaIEnZAw7uba>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 12:00:23 -0400 (EDT)
Date: Wed, 20 Aug 2025 18:00:21 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	borisp@nvidia.com, john.fastabend@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: tls: add tests for zero-length records
Message-ID: <aKXxFeOVumfyoLw1@krikkit>
References: <20250820021952.143068-1-kuba@kernel.org>
 <20250820021952.143068-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820021952.143068-2-kuba@kernel.org>

2025-08-19, 19:19:52 -0700, Jakub Kicinski wrote:
> Test various combinations of zero-length records.
> Unfortunately, kernel cannot be coerced into producing those,
> so hardcode the ciphertext messages in the test.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/tls.c | 300 +++++++++++++++++++++++++++++-
>  1 file changed, 295 insertions(+), 5 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

