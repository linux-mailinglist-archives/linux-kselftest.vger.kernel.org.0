Return-Path: <linux-kselftest+bounces-44639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2013BC2AF0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 11:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9FB1890D56
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FC62FD1B1;
	Mon,  3 Nov 2025 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="kqMjXicZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w3onH9kl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2EF2FCC1A;
	Mon,  3 Nov 2025 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164795; cv=none; b=N5rGdhY8ujv1F2a0GRwRJwKiCjN3sjDNqcKXGaP8Sr95/5FxbEquoblmZYUeYEQZ39hfpD7XLg383N2JSbRn/AlMR9+/FJ3hlfBxc1K64j1EQ0hvpHRiE9FK+IFYYI4NnUkAdtgtctBPCjNpEPOrWxtmvxUUd/JQgl4BcO0x8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164795; c=relaxed/simple;
	bh=bpf2t2heDUODgJfZj+NZfgZ/cxrsVFEpR0CWsncHMTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tcn6M/P5FBZhHQZyGrG3PVmM8wSMSC4eByxFwfz7JPVPRBUfx5MYAsFWtIqVlWB+D7MxC49aG1ZlOhnx37hGzn/on7UyHOQQK/sN+j+49vLEIKvNINyW4wW/swefA93mGtjVRNVSOiqQuDOMRUpOPh7QKpQPX59Seo5yyo59XeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=kqMjXicZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w3onH9kl; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 039381400073;
	Mon,  3 Nov 2025 05:13:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 03 Nov 2025 05:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762164790; x=
	1762251190; bh=Ph7fd5U8yh1YN0vWovDGVRktrZteGa4WOq+oJ560qtY=; b=k
	qMjXicZ457j5uRPF1+RRwxmdfk4N3W4pQ2okwpp96yU6dbVl95mdHOfGvt4a56K0
	t64mpHoxKOFNcigoqyU4gGfzD3NRtYXFEDvSuLbcumRtpFIWmVxo6pblAJii6DpF
	fZ5TnBwlIuMrNKxmlYj4V14eqdNjOFjL6asvjisHzsF4qHbkKrwvdy1hu7hxApvN
	hOxjOO5mUjWL623EESMBfzUcOyR5AzP2cg32xLG/A3OVCkzGjbUWl32Gsz+wicHQ
	XROZvLPaUvxzrqLkJO+dnMwAxQPtYgNCl/fKhRjeqCDZZx1QFoaXbV2vtH1XWFv7
	QHE4E8CxAjZPjQmYCDI0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762164790; x=1762251190; bh=Ph7fd5U8yh1YN0vWovDGVRktrZteGa4WOq+
	oJ560qtY=; b=w3onH9klcmbuEvZKBB7ydPw0bZUpTTIFVxRmmrJ1HZXvl3kDLjs
	HpcHF/tKPoOCjvB8edxd+hkurQIZEZb0+ybnMMilbwEStT0ye7ZhWS/qEGMcU9iF
	pWxCrQKp9MZy4uYDU+SHRyURaPy9q6H7hTFStzvWr8S/K0wzz11iqPgV7Hs+4T2H
	PPisdcHS9SZtOMClFFHBVMDV9Fp9yAQlfBw+MfBRgRJcnpq8Fzx/2xXDVvvyBnxp
	UKPM4TuTtyyee6WvP9ycvnX5JbJCCgXuLf7mtKcVH2wC2WZK9loD7TB3yGb8ea1A
	qtos4/lNPkWEJ/SOPYX3og0qu+35SUFUrnA==
X-ME-Sender: <xms:NoAIac9egyq_2UerKk1EVNRAWOJon-6HjdoIDZp1y_vQw5N5X4hyGg>
    <xme:NoAIaRakmxeIX0za0LepgOZK6GSjAWghKp2vgMqJSKszh-zp6KExNgS3bbecK3oao
    zQsQ_HiixCfZuyivKL4IbBrwW6lCjtxBVEjLxnY4RPmpWZITiMVKQA>
X-ME-Received: <xmr:NoAIaV6E5rQoYvzwtc1e2vtdNLlOJebG1tSJBEUxMM_MADbkMjG1LDwu43Iy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeifrghnghhlihgrnhhgjeegsehhuhgrfigvihdrtghomhdprhgtphhtthho
    pegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhhuh
    grhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NoAIaWnDgEn7KlPY5pLTfNlxQp_IH6paLXIvRNzUsiB_tqBqZUTSEA>
    <xmx:NoAIaVHXpvWdSicvV2cvxJKdoqJCPi9khXfOru3g8f5aeAxXT081wA>
    <xmx:NoAIafi6qGpwZzixLN4SNLqjQy2llzltK8_Rm9P1sqiPM9GiSutJJw>
    <xmx:NoAIaajz3I0AR8aypVohRjf0yWqxfFdYCB96M3dAOP56CaZSrqijsg>
    <xmx:NoAIaTTyHkciMSbClL_WaEmlA6rKzK686BOB21MfnBJPHLVH4Q2EqGXZ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 05:13:09 -0500 (EST)
Date: Mon, 3 Nov 2025 11:13:08 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wang Liang <wangliang74@huawei.com>, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-features.sh fail
Message-ID: <aQiANPQU9ZEa0zCo@krikkit>
References: <20251030032203.442961-1-wangliang74@huawei.com>
 <aQPxN5lQui5j8nK8@krikkit>
 <20251030170217.43e544ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030170217.43e544ad@kernel.org>

2025-10-30, 17:02:17 -0700, Jakub Kicinski wrote:
> On Fri, 31 Oct 2025 00:13:59 +0100 Sabrina Dubroca wrote:
> > >  set -o pipefail
> > >  
> > > +if ! ethtool --json -k $NSIM_NETDEV > /dev/null 2>&1; then  
> > 
> > I guess it's improving the situation, but I've got a system with an
> > ethtool that accepts the --json argument, but silently ignores it for
> >  -k (ie `ethtool --json -k $DEV` succeeds but doesn't produce a json
> > output), which will still cause the test to fail later.
> 
> And --json was added to -k in Jan 2022, that's pretty long ago.
> I'm not sure we need this aspect of the patch at all..

Ok.  Then maybe a silly idea: for the tests that currently have some
form of "$TOOL is too old" check, do we want to remove those after a
while? If so, how long after the feature was introduced in $TOOL?

Or should we leave them, but not accept new checks to exclude
really-old versions of tools?  Do we need to document the cut-off ("we
don't support tool versions older than 2 years for networking
selftests" [or similar]) somewhere in Documentation/ ?

-- 
Sabrina

