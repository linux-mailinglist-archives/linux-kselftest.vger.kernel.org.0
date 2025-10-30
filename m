Return-Path: <linux-kselftest+bounces-44462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57847C22AD3
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 00:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A99401B14
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 23:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D47133BBBC;
	Thu, 30 Oct 2025 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="vVqEII+U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F212ZySe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20369335548;
	Thu, 30 Oct 2025 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761866051; cv=none; b=W88eWzYjnku7jVdVb9LBSvQlPZfeLRjbcrXK6Kuxd4xMnlCPRZOiDoRUM5OupfIYGmxhDzgeFlOc3pvYOXq9j8u9gBfS5doisYCCCLdcKZXvdYIyBKAHbK86xbVcBzfqxhsNxztU3JnPVAL/h973sIyyFOvA0eVXEyKOg9h1xWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761866051; c=relaxed/simple;
	bh=VkpxH/aNZJ1sWs1dcWM4kxr74o7MohPGI95zg3LCaRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMGpd9F87+DSFutZ85096Pl450yt35w3s0BfRLeK5Ghlv33gfiJvEdY1pj+WcpRRpTTkcCPnUiSFYCJLPu8p55173JoDA8cSRJl/Z0LbfwwIbhY+hBmOB53JDAWLGiUhjKHwp6byYi0BFPAd6TgevSthp0evu/j+ES2JspxxdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=vVqEII+U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F212ZySe; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AEB091D0011B;
	Thu, 30 Oct 2025 19:14:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 19:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761866043; x=
	1761952443; bh=yCCSB16VttoS39Nva4lOmpiC3bm0XNohLUOlFJO11uc=; b=v
	VqEII+UkVaange1yXPJod3u3SCq4TkpCmxpSjXyr8fUkjoYc33Ckkpij0S6NOi3b
	1FnkrTtNkZcdZEpUSpzCCjngKAY2nnoMUOJmACN+HgmxYsaPP35qq9Em5ga1jEfI
	2RaxQ2zLM+MokgrXuJcQBZZcodQi927F8N0BarccwO6u1ETSezU7k04SrA2BORJL
	ChNxHRpWdfp6JlmlKJbEL0NxCk4E86V0Ls3UiL8n4Fk6p0gOD7KgpdyCXzgyjEzf
	EQaI3ausqGGpvDLdXmV3VrHQWL6cuMYNkmKgeH1Zhr9AH+W4IxV8wBpYR1Qtn5bG
	HVxYKvowOXVoGkMaum04w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761866043; x=1761952443; bh=yCCSB16VttoS39Nva4lOmpiC3bm0XNohLUO
	lFJO11uc=; b=F212ZySe1fxsV5NS78RynNsQd8lF99m2QJTMzidAV+ybY0rmPPX
	M3A8l2UGsCaqerK1UFeySElYxURB8xx1dzKxilygDFjQlFF6PYoCceSoQW9YYPXP
	nE3lViO2uIZ7FbJcSVLyesDEcicALxOmU2L4kOESbCZxJnpQloxmlSS2xZr/yheg
	FVaz00ZzgYiKgFr61LDrMygfJwf6uZ8+0V0wnd9JCXTfZBs/FGxuzKk8ApLPavMg
	F6rRxhl3Vx4cHtSkmfc2JS/HrYOreUjckk9Zqr4vrA9o44+mtOJsbNQOwPg3qnAP
	ekZ3Oe3Q0DFg0QMHfUP4l6pii8NWW3ayZHQ==
X-ME-Sender: <xms:OvEDaYTAuCHWJ1ZMEGonFI62jYmZW7SIOqXNkUSEVj-rAUicGb91yw>
    <xme:OvEDaSfc-ldbm0Qg5FmDBPqQhKSguqE8MvYgwudX5YNEHqxNvUoQA7qtIyM85Pq1Q
    xZopL77nlNma3X7vHTK4AnS82Gg6ZAekR3xuXEACQxWCBgTqf5lEpki>
X-ME-Received: <xmr:OvEDaZupfBfyJBwCA9cC9UiDDsRunj4Lx7VgKj-8Nkd1uHYj88jUiKIMXj6I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfigrnhhglhhirghnghejgeeshhhurgifvg
    hirdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhhuh
    grhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OvEDaWJsH2Ne-QNfE4uLKS2w312pqnvLlhpsmVn-Y2hYAIxLPXRNAw>
    <xmx:OvEDaVZ_kB3OlRHoEAOHJgeSyQ2zhzJTNzskoPu4thBSTiaKU3EA_Q>
    <xmx:OvEDaRnDtZB01j-udHSNbR7Orasn8KDZsLpso5HvQ6ioRFbMCWciiQ>
    <xmx:OvEDabUPI5MpA8glbmKKrhEFZ1YKXecs5D3AKTS0J_nEVfTt3VJ6fQ>
    <xmx:O_EDaQWGGJCLfQYRyXuezN9vKSaegQO0oNTiawj_PQX6U9otquMnba70>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 19:14:01 -0400 (EDT)
Date: Fri, 31 Oct 2025 00:13:59 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wang Liang <wangliang74@huawei.com>
Cc: kuba@kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-features.sh fail
Message-ID: <aQPxN5lQui5j8nK8@krikkit>
References: <20251030032203.442961-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030032203.442961-1-wangliang74@huawei.com>

2025-10-30, 11:22:03 +0800, Wang Liang wrote:
> This patch adds executable permission to script 'ethtool-features.sh', and
> check 'ethtool --json -k' support. 

Those are two separate things, probably should be two separate patches.

[...]
> @@ -7,6 +7,11 @@ NSIM_NETDEV=$(make_netdev)
>  
>  set -o pipefail
>  
> +if ! ethtool --json -k $NSIM_NETDEV > /dev/null 2>&1; then

I guess it's improving the situation, but I've got a system with an
ethtool that accepts the --json argument, but silently ignores it for
 -k (ie `ethtool --json -k $DEV` succeeds but doesn't produce a json
output), which will still cause the test to fail later.

-- 
Sabrina

