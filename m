Return-Path: <linux-kselftest+bounces-44704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BEFC30A75
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 12:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39373189C497
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B452D8DA7;
	Tue,  4 Nov 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="u9bHmOJJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zJBvIECz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAC32D9EE3;
	Tue,  4 Nov 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254300; cv=none; b=UR7pM8rn53KFTi4m7YZCV6EGRBicWKzLs1emq56Qm+fslCruVioO4QeI4G6J7A9xIXpJCYNIxXykgIWWnMeij707kuQ2yig7Is17b3fzywdgHsSJ6kPBAwUGwKvpqksYdey75AJyxVlv6yqXF/2IBw8we1/vmP25JBTNKJqgUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254300; c=relaxed/simple;
	bh=mnnjEoZG7SCrvo/98JBq1+J/edDSNk2PsJilNdtTjGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWnat3x05P4TX05PuwWyo08RE0hRO6Bi5zFPXw9hmUxEGkD5b2PBRi1C9q2ZuCjmSbckawaepgnscfbPWBm53sgpyVGqtTY71MQK5hpnM1/Gh5+zBDJyLe+bFgjTmnGVyii9zSDrYwUxaNnuuHBk+ltkNd18wZleNZc4XK4dH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=u9bHmOJJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zJBvIECz; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E99D81D004E5;
	Tue,  4 Nov 2025 06:04:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Nov 2025 06:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762254295; x=
	1762340695; bh=dAKnNYKCOZLWWlDSxnoE7+xMSmMtjXAvFcmPRzidAyU=; b=u
	9bHmOJJjVL8bANBsqNriNlKUVhGbC1dBFRf1qPSxVJwKWvlVqyqGO1MzMPemaQFx
	GdhSYtrP/TfpTPgDnYOX2qfNy32i/JZjFwThzevkyUq8s7WN2ukHr1eVbh65mKBb
	Q4lWsuDrAyfvffuhgnm+WUhnRkt9Iw9+xMhR59xBtGSLP8ix5emur3nMSAoudFaL
	dkoPK8V71Cee9/1X9HWDRjibRqJ4Q4rwsA97JZOt6QtshrVx260t08pkB7QvQtnF
	N8reNBMilVtElrW2AL/9l9MW/4gO4xC+YHqAiDFoges6l0Ih6rolbAhlYKHB2Ujo
	u89A1cn258uQaKFxpBcAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762254295; x=1762340695; bh=dAKnNYKCOZLWWlDSxnoE7+xMSmMtjXAvFcm
	PRzidAyU=; b=zJBvIECzJop+kODsr9Iklplxx9kuhepW8FAgWBGk17jLyTEY6gi
	cQlsAnSNHIE5vN++/UItVoU8A/fPadksbqInjpra02jizRZqIUHr4Git3YKSuRWH
	MaO6jn/IvAjyVdt2gWIqq4ZKgZ6w4h3rcEI2ogsn57vNTzcNqM0qgqAb4Uyhvkcg
	6zKTzJlhhKmqBU9MhIBsE4dE6DhTSUxz45b4oQVbMT3DGiqJzoG0uI7ewdK5PGmv
	2xOnfVXBi1YQqi8rCs1Yt1npFHfOBKoq4AGOMhHOIra4AxoMGkWBdtgwo6GEYUxz
	C/PWFFEZ1gZ0NoUnUYAaeidgaX+I6gsBWJw==
X-ME-Sender: <xms:1t0JaceVscXoOblLcO6qu3Kx6IQ6Fkce5jbaYTjlRqt4iQZOSUenJw>
    <xme:1t0Jaa7bS2y0rOkJdteeqCnywOCdXogODZAumO3GylbJGTe9ALFERrMxiSRYS6whA
    BGyyE_4xoXTECGuycM5wXCbMGGiVaKTWmHbZyFJQfD6KyxLK7u_Hj0>
X-ME-Received: <xmr:1t0JaRbAACYyhzeF2qwV6I4OZxG33q9AOmv_ZeXteLEFMkqB6m8jrqK4qKxf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedtkeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1t0JacGA86B4jibY7-PgUQ15JCu-DMoDqpJV0mrF85uosowDmker7A>
    <xmx:190JacmFviT6lEZhdz9YFn62r0UVWQvNbaEaefcQlnE0bp0X3XkbLw>
    <xmx:190JaRDUHaX5yHuqayKjD2IItMfTepZo7UtuIIsudivRfoxtSv6AJQ>
    <xmx:190JaeAyZJiQ5CSp4bRklta1bQySiyGHknAt7c-Fh_fcWpq05ZHXYQ>
    <xmx:190JacxDygH31MmBzbHd0x5HDl0c2op7DUQ_7jReLF7FEf-IPHQK3Ra3>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 06:04:54 -0500 (EST)
Date: Tue, 4 Nov 2025 12:04:52 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wang Liang <wangliang74@huawei.com>, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-features.sh fail
Message-ID: <aQnd1HQ-b7wFI2WP@krikkit>
References: <20251030032203.442961-1-wangliang74@huawei.com>
 <aQPxN5lQui5j8nK8@krikkit>
 <20251030170217.43e544ad@kernel.org>
 <aQiANPQU9ZEa0zCo@krikkit>
 <20251103160133.31c856a4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103160133.31c856a4@kernel.org>

2025-11-03, 16:01:33 -0800, Jakub Kicinski wrote:
> On Mon, 3 Nov 2025 11:13:08 +0100 Sabrina Dubroca wrote:
> > 2025-10-30, 17:02:17 -0700, Jakub Kicinski wrote:
> > > On Fri, 31 Oct 2025 00:13:59 +0100 Sabrina Dubroca wrote:  
> > > > I guess it's improving the situation, but I've got a system with an
> > > > ethtool that accepts the --json argument, but silently ignores it for
> > > >  -k (ie `ethtool --json -k $DEV` succeeds but doesn't produce a json
> > > > output), which will still cause the test to fail later.  
> > > 
> > > And --json was added to -k in Jan 2022, that's pretty long ago.
> > > I'm not sure we need this aspect of the patch at all..  
> > 
> > Ok.  Then maybe a silly idea: for the tests that currently have some
> > form of "$TOOL is too old" check, do we want to remove those after a
> > while? If so, how long after the feature was introduced in $TOOL?
> > 
> > Or should we leave them, but not accept new checks to exclude
> > really-old versions of tools?  Do we need to document the cut-off ("we
> > don't support tool versions older than 2 years for networking
> > selftests" [or similar]) somewhere in Documentation/ ?
> 
> FWIW my current thinking is to prioritize test development and kernel
> needs over the ability to run ksft on random old set of tools and have
> clean skips. IOW avoid complicating writing tests by making the author
> also responsible for testing versions of all tools.

I see. I liked Andrew's idea ("embed the date the requirement was
added into the test"), but it goes completely in the opposite
direction.

Figuring out why exactly a test failed in case of an old tool
(unexpected output passed to some pipe/parsing, exit with a non-zero
code, maybe other issues) is not always obvious. So without version
checks on the tools, I think we have to assume that the test requires
the latest version of all tools it calls (or at least a very recent
one). Which I guess is reasonable for upstream kernel development.

> The list of tools which need to be updated or installed for all
> networking tests to pass is rather long. My uneducated guess
> is all these one off SKIP patches don't amount to much. Here for
> example author is fixing one test, I'm pretty sure that far more
> tests depend on -k --json.

A quick grep found only a few more (in python scripts under
drivers/net) for -k. But (also from a quick grep) many tests seem to
use jq without checking that the command is present.

So I guess you would lean toward not accepting any such patch, not
requiring new tests to have SKIP checks, but leaving any existing
checks in? (and I suspect removing all the existing ones wouldn't
actually reduce the flow of "add check for too old $tool" patches, so
it probably doesn't make sense to do that)

-- 
Sabrina

