Return-Path: <linux-kselftest+bounces-48534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12214D0492D
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35B4135790A2
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B003B27F017;
	Thu,  8 Jan 2026 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="UP/PAx3d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r9uci75Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B228134C;
	Thu,  8 Jan 2026 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886999; cv=none; b=Q6iR6UZ98CHRc7FRgJqj+Ph3oa7MiKdFciXA/HB7QzUUD948b8BdI140pTzfNsrc7Bf4JBo+5HJii9c8quVi02P9ZxFE+Y2dNIkF4A9P4nzPoK8paKD0z1sGKj/iieNHt8WSReQw33VziuyHBIw8K0zEiEbSAbuMCuZ0AAiBwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886999; c=relaxed/simple;
	bh=7x42XwwSIRZThfbW9Ey9zly6QwxtxRjOjewiKXJxo5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEZ/NcSa3LK8YOVvW+iN9rOHPZA1JpJxUEVouFSlqmp6bWJ9HaVfsANhMdFPaCUkCujj4r2ObTJ3XQz9471GimLSu6pB2+x3mPWK51lNhlk8n/4UwUMJtEMEjItA08vI8Cde08l5+qU9iU38Q4EASNbpkpG9Ad/tEhHKokCKvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=UP/PAx3d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r9uci75Y; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FCD51400010;
	Thu,  8 Jan 2026 10:43:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 08 Jan 2026 10:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1767886996; x=
	1767973396; bh=4sIOPLF50k3Ko3BJlN7CS7OkqCNTNgQuuq+79nYB9UI=; b=U
	P/PAx3dAbfikHrjbSZSRs3e19aXRgGPmQSQrLxFJ2hOPU3WAiPGlBH+8WZwGM90U
	mBVTX5yyLdmyhnicD42IpI85G214Krhl1xnNTTCezPKCdZrvgdZDVxk62IvAZuf7
	HZ6pO6UXr/k4Nrzkq5dryLopeWgQiwPbMWk86jmvX6/JiJIk5AYc15ck1T0nROXf
	1a1+LtHVE6p9EdxgIzRKB03r1AndlK4OZPdMC0brmrMi+RvtUhrUcuUp9ZtgxeCQ
	jnA+7mXqGmtxft1LVUKSb0V29EKm6S0h33ggFYoH75gaxazM9jcl9SoRofR1zfXW
	hrqLs90t0dSHiSMlK+82Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767886996; x=1767973396; bh=4sIOPLF50k3Ko3BJlN7CS7OkqCNTNgQuuq+
	79nYB9UI=; b=r9uci75YXES+pHj5iNuqyh5gsgfG36qXUAHI6c77ipRQrkiImH5
	n2C7aMJSGyHJATgHn2i3epWM3XgUd6tFOJ8ZqN8Y+dC+DqWVvuc7wR2h13bbmmhC
	+rafR7RVySiJP4Ycm5rmtExbq+o+Z8ctF4Y3NZu9fDO1r2AklWddNI7xSOAIiTQj
	j3ieuwQSB+BFTN64qlr2ML3dKd2h+kZrFmosPwZZeNH6BDW+zkMlVuKJcY66eXsn
	hPKi97t+vHA7KvBKj0VPNkPPMlwltgt0OizTdmebZ5seifWZlMLRtZulT90OERv/
	LfPVHsncbq0fFbhClDA9JCQ+9yaWFQygIUA==
X-ME-Sender: <xms:k9BfaaT-ulMDjgPoTjm8EO_t7BUeaUYWPuwiJhn56e6QOJSCjmLCgw>
    <xme:k9BfaUt5IqwWELgsDPgNqbNCgWGkr1An6tP5guY0jaCRVNnZNVxurwIHpdhxlsLKK
    wZHwLjhI8ulgW17EDbGnug-7KTAkbyVk9cgorfUjwJ8PVjiRaAqWSE>
X-ME-Received: <xmr:k9BfacE2S6DoCPXwhi1HKKnL33s_bFywQd3u3qykbMkF1LV2QtRn1yt44B3K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuieduge
    dtfefhkeegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvght
    uggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:k9BfaVxsxbxKJ9Xw5U0BPz64-1VWpUu1pY7B0Pdd5DzMxkw5JVzKOA>
    <xmx:lNBfaW3HQDWJGSG6mSO70eEnlYHkxCvnC0gVWC6yLaTR-Z8XHJPoZg>
    <xmx:lNBfaVq-CLY2DNydnN8Q7gvm9MbXJnFM3S6UPsrmyQximJZFWuaf0A>
    <xmx:lNBfaTUhXFdDawWiJbfkTlC-_10NlS1IqZfAxQ5HN1qwcdo0qRMSjw>
    <xmx:lNBfaRXP1dDDvyDNDTARkqeKBbVdC0ngDZfMDD1wT72S7QD7L5LK66ay>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 10:43:15 -0500 (EST)
Date: Thu, 8 Jan 2026 16:43:14 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: tls: avoid flakiness in data_steal
Message-ID: <aV_Qkmfo6VPCN_gt@krikkit>
References: <20260106200205.1593915-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260106200205.1593915-1-kuba@kernel.org>

2026-01-06, 12:02:05 -0800, Jakub Kicinski wrote:
> We see the following failure a few times a week:
> 
>   #  RUN           global.data_steal ...
>   # tls.c:3280:data_steal:Expected recv(cfd, buf2, sizeof(buf2), MSG_DONTWAIT) (10000) == -1 (-1)
>   # data_steal: Test failed
>   #          FAIL  global.data_steal
>   not ok 8 global.data_steal
> 
> The 10000 bytes read suggests that the child process did a recv()
> of half of the data using the TLS ULP and we're now getting the
> remaining half. The intent of the test is to get the child to
> enter _TCP_ recvmsg handler, so it needs to enter the syscall before
> parent installed the TLS recvmsg with setsockopt(SOL_TLS).
> 
> Instead of the 10msec sleep send 1 byte of data and wait for the
> child to consume it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: sd@queasysnail.net
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/tls.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

