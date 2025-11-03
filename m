Return-Path: <linux-kselftest+bounces-44638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F911C2AE58
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 11:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0061C3A8667
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 09:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A72FABF7;
	Mon,  3 Nov 2025 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="VaE0XOGs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZBsvVHQU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609468405C;
	Mon,  3 Nov 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163978; cv=none; b=nUaMPrgsmV2+t2UYFtqVZOeBmJ+75hfS0ECo8Jm7aB9HQf3+eqfmua+NE5goUwmzIz2bi2WOXHo8QuGz4S/40ClWo8rXDEBjoUMQOp/IqSKqhsO4phXFBzOkDliscws1PAZYh+2bM1g1Sxk61wutcG26TSYBO6I+bKxgYe0VyYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163978; c=relaxed/simple;
	bh=/185EXukW1YoAfSt0R/ts2WEh9FI/8+19d9aNbAhETw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKgE0HRfQ1CMdnnflhONxsmI3GaTlWoS/Uao2dWVSrzBKnbC/Q8PcNg3n7RgOs0DHv8Kl04DBs3tZyK9Upj3EvpSUbVMbDtoXLg+AXXWNz0dafX7uBnizMemz7nZNESl0gMQ81b4bY12FPuLvceq+CuX/xoMtRc87ZPLh+esJAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=VaE0XOGs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZBsvVHQU; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4682B140016D;
	Mon,  3 Nov 2025 04:59:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 03 Nov 2025 04:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1762163974; x=1762250374; bh=EoRTOUiqNo2cvNRwLXJuVMPRCrEn4Z9F
	qfz67AyZ8ys=; b=VaE0XOGsLoPWkUQZjnRbVu+9vhSJ8yT4THye/iIuq0x7Vg3H
	XhYDeztRK3nqC/50GT4fABUZ+dSrb0WwPYUfeRaSqPnj3uz2AUvLyQXtisgrlksj
	zF0K9deND+YrDLIOJLRsXZQB++vGiaOULFkxERKZoUK3ZAI3wKj7fN4S08rEl8es
	USJdjGP3mvkw0gs+yNrbQbA1uhBSna0yikX6o5UrXyOdzc2j7Q3E7/yhGWDwDIYr
	Txhhqt2XXXWA7kFns4LJYEbCf6Z81lilIVIqvo8gem2zntgQvbnAgknmZQirAB1x
	sQrDjGfZ0mR9NVKbFYUsURwoZDfvTxFx4N08eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762163974; x=
	1762250374; bh=EoRTOUiqNo2cvNRwLXJuVMPRCrEn4Z9Fqfz67AyZ8ys=; b=Z
	BsvVHQUMinQkRNXclXAjr75SpWgGB+RpPVy1E9pDEnqfbsQ13o5i0xmPao7+biMP
	jLW9OaLTe0kIhWsTdnlKym7n5uQUQQz3hqDklEOY6LgShGdgv6NIzseZ/IpPZlLq
	nSdDreW2OVW528uvx8FZzf9mgCqkOJi+NLiYsAFSyP8+3Tir2HlAMkznD9dc2hwP
	dJQC/JSG27RmaZ7F3Ka3Iis+MAJV0q3g2XVCEKoBLneKxkqRXtaa4H+0pURz0uzG
	yb9TvWVVBFj7hiu/BJxxSFBxEYLhzU05Ab2ZCbk351Aq8WesjWyYhXwGPXNtSvX2
	RGPzsUpS0tg+PHDjZwf8Q==
X-ME-Sender: <xms:BX0IaZLarJa_RiorcFZp3ZxY9zsxqdj1SVhj_KQJ03rIiaAqhgE64A>
    <xme:BX0IaSoffggrfVvhlb5ry4ajsOWlX4ns1Mv1ptnq6zopYQ14xH_CTVX9aQFVfB_cN
    kKx5T31DBmSNQ-OmIStXyS-TdOFThFZdqBZU5aIhZA29MqOFKZGug>
X-ME-Received: <xmr:BX0IaUX0MLIL5_-EFcstSWxjb5c91s5FUxGa2DEX90D2jO8l792AHjNX3bFS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpeevuddvtdevheetkedvieeugeehieevjeekteefgfeffeefjefgvdef
    tdelueefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhl
    rdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepfigrnhhglhhirghnghejgeeshhhurgifvghirdgtohhmpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthh
    dprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BX0Iaf1MYafNoAC3fvlsl6zPNNxdQLgWqPVV0le4FCyimamSlaxfEA>
    <xmx:BX0IaTRdVT-zS-E7bKmstT2DhOnkhyTNuXKmPgJUMICYrbNOYDCKOA>
    <xmx:BX0IaTTvb8zvKIqNajaTD7INixABmx9dYmvz0kWu0Wv7LgySfbcYdA>
    <xmx:BX0IaUXQn9aZtP0TSyYNvrkLzwNBVM-c9mcXZGa1nSIxWwF_ErQgHA>
    <xmx:Bn0IaYf64TuLWHc3xIjnfXwfeVZ32b-k6jdwU7zmtBv1_NkeGkN-dYE3>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 04:59:33 -0500 (EST)
Date: Mon, 3 Nov 2025 10:59:31 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wang Liang <wangliang74@huawei.com>
Cc: kuba@kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-features.sh fail
Message-ID: <aQh9A647mJzBeBI_@krikkit>
References: <20251030032203.442961-1-wangliang74@huawei.com>
 <aQPxN5lQui5j8nK8@krikkit>
 <2ea387c7-cd15-44cc-8789-af3fbe0460a3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ea387c7-cd15-44cc-8789-af3fbe0460a3@huawei.com>

2025-11-03, 16:58:42 +0800, Wang Liang wrote:
> 
> 在 2025/10/31 7:13, Sabrina Dubroca 写道:
> > 2025-10-30, 11:22:03 +0800, Wang Liang wrote:
> > > This patch adds executable permission to script 'ethtool-features.sh', and
> > > check 'ethtool --json -k' support.
> > Those are two separate things, probably should be two separate patches.
> 
> 
> Ok, I will extract the executable permission change to a new patch.
> 
> > 
> > [...]
> > > @@ -7,6 +7,11 @@ NSIM_NETDEV=$(make_netdev)
> > >   set -o pipefail
> > > +if ! ethtool --json -k $NSIM_NETDEV > /dev/null 2>&1; then
> > I guess it's improving the situation, but I've got a system with an
> > ethtool that accepts the --json argument, but silently ignores it for
> >   -k (ie `ethtool --json -k $DEV` succeeds but doesn't produce a json
> > output), which will still cause the test to fail later.
> 
> 
> That is indeed a bit strange.
> 
> I'm not sure the best way to handle this situation now. Maybe update ethtool
> instead of checking the output is not a bad method.

That's what Jakub was suggesting in his answer [1]. ethtool has
supported json output for -k for almost 4 years, running upstream
selftests with a version of ethtool older than that doesn't really
make sense, so only the "permission change" patch is really needed.

[1] https://lore.kernel.org/netdev/20251030170217.43e544ad@kernel.org/

-- 
Sabrina

