Return-Path: <linux-kselftest+bounces-44650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E77B7C2CA58
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 16:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172361896A9B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDFB313E1E;
	Mon,  3 Nov 2025 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="1hT9t5A3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zlaq5SCo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB4427FD68;
	Mon,  3 Nov 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182070; cv=none; b=Y9PY6jlHKpXq70YLSXzZiIBhrcA08874QrDDAk8Wz1vM7WCsA2oId1hrTocJOQvgZkYkYiQI53rr1CqW1vEujdU3oAyNu92hvJzQrpmhPjpw5SsGWUDLlRl33DqxE6RwmOzgIpZAzBAzz7iEVco9kiSJCo06zoeQA6EJrNnnZ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182070; c=relaxed/simple;
	bh=Fa2A1KQHl0Ok5OmCFsWDeoz3FriRH/Ae+vmGgtQZjC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ+H9S6LzvtJDOdal9OXNl30kVLBfrZ5a27Xqp8SDTHA4I/JgwXRwFWnuXG+i0QQaXe0NT+y7u8o24Czi7S36PWoAhZVEOyiTeINCxzbX4vbrinC1d5thGlFPF6lBSy4vaLEY6Gchsq+nn+/zBWHbjtv/SS+TciAspHudJAESUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=1hT9t5A3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zlaq5SCo; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 232E57A0009;
	Mon,  3 Nov 2025 10:01:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 03 Nov 2025 10:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762182063; x=
	1762268463; bh=fOxVgiixhmAbuujQPmcHI1Sf2R/F0nB3JienkE+5nAI=; b=1
	hT9t5A3qJK96SQR/9+7MAfJPSMx+MHD4rGqV0qOfx6e84JMKkr9OuV0G2ZAO2qnv
	kdFCBPxjcnyASgQvxjIQkp5Z4NVC6OF2JkbhQ4pv8z++kZ9TE7YjHj+VjIwxvbx8
	ZvsBf7r1YlPQHA5MQbs4uLEzRsLp+RkGTZhBq5R+7YEI4V2Wov1X8bj3iJuy4Sdo
	ccxwZxPGSXx41XFVj4AD84uHDMam3CNmisZnvib/EUYMsZ1KylVtFIroi1foXnSy
	zMrban7bc7vnIgPsQ3Z0CNBoc32gD1Aua6JGFcSEwMwO5crbnmx8e8PBxzAU7YJA
	yjkQekhh/2YV+yYVt5NSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762182063; x=1762268463; bh=fOxVgiixhmAbuujQPmcHI1Sf2R/F0nB3Jie
	nkE+5nAI=; b=zlaq5SCoi14NK0mj0XOVba/jyhe5entm0MxsfYCv2WBZq9jbKRO
	2q6WMWPsHrNj1UYrXZErDmO+Pbhe3eJwnYdGT76l2PdGjrejjw5qDtpCzKhy1CBy
	Z/yjj1pTn9OPASdXOtl6+r2YjrexiF7dYaIUfgk3dWFgyPR+hLadSBbuNsTuhQH4
	NRwShZO12Br6mKER71jh/awjqR1vZ/gMGFQMNaP/deN5seg6LYgDnduLvQ2jLcof
	NvGLrwlrOmWkF/Sp8GtoD/4cCvMqxbfz5OIlwJieMePh9JHw08B6qoutlbPFk/yh
	MK5ojQTART1B53EBgMHTV0T5FTFZN72Kn2g==
X-ME-Sender: <xms:r8MIaSdw1blZIIgwYmqasHUovTs_AZ3zpb0lWb5CpypDcRZD8vH24g>
    <xme:r8MIaY4WQiZAqgsly30XyB2bxiptVKz4T_ukHzAqmAigThk016y0PxZ7MblgoDSgS
    QRYQNbi5VhcfnNUeix8MZIOMLJ-tvqY7rea6UqyDaT9Xs70_1adDg>
X-ME-Received: <xmr:r8MIaXYRPRNBws8mlDnEJPUwqIoYyTxYlQN5Q49QsP20eyRJ6i9qPTmI4Gip>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifrghnghhlihgr
    nhhgjeegsehhuhgrfigvihdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhhuh
    grhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:r8MIaaFmPhmH1MAYFp_fF5rN-G6pyKe2Q2U834QSV_ZGf6jqgVa-Gg>
    <xmx:r8MIaSmmqdEo7Cbg5j381ZKQNbxHYAriXT-i9ryEgglJTb5K-jP2Og>
    <xmx:r8MIafDc0JynqmYo5QiD5mfrDClmJrE9tHb9Sqcb--Si8iuHVkQzuw>
    <xmx:r8MIaUA6GFi5TcCopkQJ_pI-NlBkr7dcRrpH4E0xGHbyM99bYlK__w>
    <xmx:r8MIaazGBeIh4ADPJ7t9QsrtRJ7yojCJHWQb3IMpfvOH6QVi434BB4B7>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 10:01:02 -0500 (EST)
Date: Mon, 3 Nov 2025 16:01:00 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Wang Liang <wangliang74@huawei.com>,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-features.sh fail
Message-ID: <aQjDrMH34QVz6e1E@krikkit>
References: <20251030032203.442961-1-wangliang74@huawei.com>
 <aQPxN5lQui5j8nK8@krikkit>
 <20251030170217.43e544ad@kernel.org>
 <aQiANPQU9ZEa0zCo@krikkit>
 <e014c4c5-105a-43cb-9411-ec139af2b2a1@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e014c4c5-105a-43cb-9411-ec139af2b2a1@lunn.ch>

2025-11-03, 14:36:00 +0100, Andrew Lunn wrote:
> On Mon, Nov 03, 2025 at 11:13:08AM +0100, Sabrina Dubroca wrote:
> > 2025-10-30, 17:02:17 -0700, Jakub Kicinski wrote:
> > > On Fri, 31 Oct 2025 00:13:59 +0100 Sabrina Dubroca wrote:
> > > > >  set -o pipefail
> > > > >  
> > > > > +if ! ethtool --json -k $NSIM_NETDEV > /dev/null 2>&1; then  
> > > > 
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
> 
> Another option is to turn them into a hard fail, after X years.

If the "skip if too old" check is removed, the test will fail when run
with old tools (because whatever feature is needed will not be
supported, so somewhere in the middle of test execution there will be
a failure - but the developer will have to figure out "tool too old"
from some random command failing).

"check version + hard fail" makes it clear, but the (minor) benefit of
simply dropping the check is removing a few unneeded lines.

> My
> guess is, tests which get skipped because the test tools are too old
> frequently get ignored. Tests which fail are more likely to be looked
> at, and the tools updated.
> 
> Another idea is have a dedicated test which simply tests the versions
> of all the tools. And it should only pass if the installed tools are
> sufficiently new that all test can pass. If you have tools which are
> in the grey zone between too old to cause skips, but not old enough to
> cause fails, you then just have one failing test you need to turn a
> blind eye to.

That's assumming people run all the tests every time. Is that really
the case, or do people often run the 2-5 tests that cover the area
they care about? For example it doesn't make much sense to run nexthop
and TC tests for a macsec patch (and the other way around). If my
iproute is too old to run some nexthop or TC tests, I can still run
the tests I really need for my patch.

But maybe if the tests are run as "run everything" (rather than
manually running a few of them), ensuring all the needed tools are
recent enough makes sense.

-- 
Sabrina

