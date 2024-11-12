Return-Path: <linux-kselftest+bounces-21888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8F19C60D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 19:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F300CB82BAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E1721CF84;
	Tue, 12 Nov 2024 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="GzFa7jLG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QU7yuGbG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B321C194;
	Tue, 12 Nov 2024 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432710; cv=none; b=pb3oml53AXQEJ6/1pdeVPf1shUb+twGw4soexddZitD9i03C+yMS6/mQl5Qvx8pbBclkCkAVp5ispRgYnKZaIKaKTXv7xLd/4sNgkXt/KPsKXETV1/nW4ZpuzYDGzdk+MTQAUu5gHI0cmLXjoODIiKCxr6mwGylGv00N8XFX5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432710; c=relaxed/simple;
	bh=5T+mAOmQGUGuwgb0NzVB0VxVq11xmNt5l/I4xqeDOR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOBgPiRdtqusx+01DTgpCkTDHtPUPm1dTbIGpsShloA/1kQ0rWftjp3xG6bjASyVgHYR3x6kw5LPyahZwPHH0oPB18rPSwZyFs4fvDq69aas0eKRvnNi6qhm/e1VP4L65SUHrh9T7YINBvUGZBdwuZyH8umfPC95A+nDD40UBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=GzFa7jLG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QU7yuGbG; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id A8F481D403A6;
	Tue, 12 Nov 2024 12:31:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 12 Nov 2024 12:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731432707; x=
	1731436307; bh=s6+xxQXvhzXkvyOoCBbCT7VarA6WfiyFPIHUZfxtZUI=; b=G
	zFa7jLG1cWT/l+QMM28wJShPN4UQW8P05arsOBDfylxJ3/9TgcvjKm/8+v/P/nK3
	03uIsXlzbXykeGOTpIE3VjMLsPYKJMWY7NaZxUiagiOp+veFi8WiHswObSzIUiIz
	y6czcrmDoEcRl8Mgq76C22xu0oKlhJ8tF/1f0+340Cua9vYey44vdbCxMl/L3De1
	XCzokog1Jlvo8fzcEsKAsZI0QJt5yS8d86rHjb6ipT6iCUd7GjkVSujlmrFlwOzM
	1tUyi2LfUgMfQ0Ij/3GEFaWZNiPwVBKZpZqsKsqpiKMbfR6UGIE7wDENqGKEvV2A
	bWVytrOCoXb1AD5AqbCEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731432707; x=1731436307; bh=s6+xxQXvhzXkvyOoCBbCT7VarA6WfiyFPIH
	UZfxtZUI=; b=QU7yuGbGwa8Z+V54sn/5JthnsF22tXeINVYQjVTohHgFnensyHA
	qU9EX5G1JC2dKNfZPfk2JBoYGbWxxmHlXBmz0YvZhd3FOzoupZhX2w5Y2xWNBeQD
	9AWIQnoXugYQ94QKl6w118Xs3Hveoow1TkmFeEO7OdImRLfnO8vTfbXlsYW877u/
	GUrHTL9wykAeN3GMrIiuYeaCMCzEbo5e5FtB85iu7wA98cAO2SPHRqflMvxL/HKP
	SpYV3yUI/VP+EaBe4d77lfb7fwtB1cCj1O0EsX9Vdn1RFS18t7QaksyJYYfQTmJS
	8uMp/il/TRYI5nRIDqY6SzJoNHsROf3rrEA==
X-ME-Sender: <xms:A5EzZ0avZxicPbACnSmZZemAPUn-YRcImU-qTENbgTlCjR-VFVrZ4Q>
    <xme:A5EzZ_agHByMCvQSmPF946IyZqRMBGDX58jO_KqwPYeX43c8R97kI4V3-VMPLD-gX
    0jXlCBLscGdjDmDs1s>
X-ME-Received: <xmr:A5EzZ-_k9V50mwznRx6VadZE5yrBuqhZSo-9dbqLRvZgU_cTAZ_YMlzybF3h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrhigriigrnh
    hovhdrshdrrgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhhtohhnihhosehophgv
    nhhvphhnrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:A5EzZ-qfmO1SZMWEeL67fe3hBFK3DbMlO6b8CFY8a8EF_5OzxSkzrw>
    <xmx:A5EzZ_oWpN1cgxf0RB6fIhVyMd_w8TWWHYuoyyU9PyS3nWIRc_g0Bg>
    <xmx:A5EzZ8QA4Ub8--0CtUVQ5m7yxznrX1zxCQ3TFQ2PMIz7wAdi90rgiA>
    <xmx:A5EzZ_r8ynOAQb2nqebqVpW4ehCb8JoEipI2reWxrn2MMcXdJRI4ZQ>
    <xmx:A5EzZzfnM5zGEqu92LtUmm3X7pxTRQvHEBMxG5JnTB-H-x7XeJM3jjNI>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:31:46 -0500 (EST)
Date: Tue, 12 Nov 2024 18:31:45 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
Message-ID: <ZzORATd5hG614dta@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
 <b7d3ec11-afe4-409c-970e-8bc647364a08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7d3ec11-afe4-409c-970e-8bc647364a08@gmail.com>

2024-11-10, 15:38:27 +0200, Sergey Ryazanov wrote:
> On 29.10.2024 12:47, Antonio Quartulli wrote:
> > An ovpn_peer object holds the whole status of a remote peer
> > (regardless whether it is a server or a client).
> > 
> > This includes status for crypto, tx/rx buffers, napi, etc.
> > 
> > Only support for one peer is introduced (P2P mode).
> > Multi peer support is introduced with a later patch.
> 
> Reviewing the peer creation/destroying code I came to a generic question.
> Did you consider keeping a single P2P peer in the peers table as well?
> 
> Looks like such approach can greatly simply the code by dropping all these
> 'switch (ovpn->mode)' checks and implementing a unified peer management. The
> 'peer' field in the main private data structure can be kept to accelerate
> lookups, still using peers table for management tasks like removing all the
> peers on the interface teardown.

It would save a few 'switch(mode)', but force every client to allocate
the hashtable for no reason at all. That tradeoff doesn't look very
beneficial to me, the P2P-specific code is really simple. And if you
keep ovpn->peer to make lookups faster, you're not removing that many
'switch(mode)'.

-- 
Sabrina

