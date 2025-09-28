Return-Path: <linux-kselftest+bounces-42560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1940BA78CD
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 23:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0696F188BF57
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 21:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BC5257848;
	Sun, 28 Sep 2025 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ubAQnLIl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FjY9XfEQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1055227;
	Sun, 28 Sep 2025 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759095895; cv=none; b=lsXvDtZ80gsFINy/Z5cCbErwShmG6qQg/uDwgzzeruUf4WbjVtfkC+Hx2+cApma2C/iTL0n3dSKK7xvD1e3IYU2J61h+fco7KxBUnbSKQskYW9+HRobLtEJk7GaIWI9LgGH1yj2+K78Y17dj7ilsaYITB8paPO5BMVviVem6ttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759095895; c=relaxed/simple;
	bh=mnyp6ggCgjhXODC8DRmRebtTZhDxTAmYNjSsq6/rszk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOBvZ1fLz6+Sm3IFuDw9EaKryzxrbMHLtiJ/Ow/UsXfeferm5K8PB7b35SH0i+bPcCDc7AElmab8y15M3wR/rjJIuzUbfMZIIFvVdWwYuCeWbpcLIXvVfA2kxnaTTEztsUDWgJAwFGZ/57IiIr6yiiZxj7/H9oJbvmm/uXa4WfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ubAQnLIl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FjY9XfEQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A19B1140007F;
	Sun, 28 Sep 2025 17:44:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 28 Sep 2025 17:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1759095890; x=1759182290; bh=bqOTAR5nmMnMgij4YPWgX8pCUapbTKor
	rwgCldxv+vU=; b=ubAQnLIlgJQ1csTNEk0wgB/6b8xAIBcAh3HAtChheo9HoHka
	y1atsvu/42Izd4b2fBSQoiKMLzML9zb1WeUSBzWsLSTXN+nYOelctywIiojyWLMN
	iMeqtfWOKSbZ3l6yjyy2VL1GQAriEcyefB0V6dkY99Jy0Uv7b8Gy0V0LrRxxC3A3
	e7TLyGGemBzqSykJjOYxIjLFTlb5Jg/eNuBvwbd4eNQUL90lAmy1B4Dv1edgLj29
	25yPrfxoRN8l98AgwRFC2AjT1LyDmaV9OA9SrtdLWy41/peOdCzylTdFVzd5LKB0
	g4caHgErLUE9GSaOPn8C1VOgzMQXRprljGHEzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759095890; x=
	1759182290; bh=bqOTAR5nmMnMgij4YPWgX8pCUapbTKorrwgCldxv+vU=; b=F
	jY9XfEQjG6yfmbOmL2Vj8EPbmT5xAmu4gke9b1j85rC1LOOJlcG6aN1ODMeBwJ2z
	xaASKdii38aoVpJDPFOBLO29VsjqG2MpTbWMaBAjN/7Rot0ibUbFWUCoRfvy4qNM
	2Bu3ng9lgQIuIAdaCAB/A9i6Y4Ui4C8HDW09dW5noIaTHqkhoKAy7NfjnADNyHrb
	MLQ6eTyaazXUGNKzoepixQFbPmvs06Mw6Px0/F/XyvMo4g646RXl4qKQ5quienZy
	ijniryLx5XR7Fmcf6s39wTqPjBDZzxza5e4nYOFTV0pYtNBULb0m94ACvU1vC9O5
	xHE7Smp9KcqB9qvGSlf4g==
X-ME-Sender: <xms:UqzZaLuVCHaHL1dXWWo7gVpW4XAoST_uWK80ReVuNbFTJYWALUwoIg>
    <xme:UqzZaAK2V8jXLCXeJmxSRnw7XOHDSWVLV6pi_eZRJdsv7tonagKc4iPErelWzp1Sl
    tDnKMkQV4RuiIomLUeD7P1y69riVIVtDJop1FOMIMPFMHYpHQTI4-g>
X-ME-Received: <xmr:UqzZaHaYLWiXPmNodfaK5rmH91R1SxuLbJ5AlH6hM9P8SRXZbYfsMyR7MjIq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejiedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgfdvgeeitefffedvgfdutdelgeeihfegueehteevveegveejudelfeff
    ieehledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhfrhgvugdrmhgrlhhlrgifrgesfi
    gutgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmh
    hlohhfthdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhguse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:UqzZaLk1rGOmyO1He8MPxqi3CohSvlkQe3_A6Rrgz3pDiTWgyubwXg>
    <xmx:UqzZaNWdjTzP7gUnltCcDMJUVASQjOhX1Z6neVB08YXj6nu4ljdFCA>
    <xmx:UqzZaNLQk9i3WJOHwZbrBRCpFZ_5HLoh4oN8t0tGAo8kW2aVBdq1Bw>
    <xmx:UqzZaNsooISRzeh5yEtyXLgG1yj-3McLdWJsn3tH3mRzfPsHEAR1YQ>
    <xmx:UqzZaMbvTxZHOoDBETUgoDK8OSId_1e5rsgxH58kReMnD7JbGMnWKD_v>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 17:44:49 -0400 (EDT)
Date: Sun, 28 Sep 2025 23:44:47 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] net/tls: support maximum record size limit
Message-ID: <aNmsTxyg75HHkmIJ@krikkit>
References: <20250923053207.113938-1-wilfred.opensource@gmail.com>
 <aNQvgD7AvFe7-sAv@krikkit>
 <4a83e2f526013516e2827a4ff8899b0437d08a25.camel@wdc.com>
 <aNW0OxiN8M2hv7Qu@krikkit>
 <bfc1bab9a8f2f51e19ba4fd57a6b8bdf69683d42.camel@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfc1bab9a8f2f51e19ba4fd57a6b8bdf69683d42.camel@wdc.com>

2025-09-25, 23:37:09 +0000, Wilfred Mallawa wrote:
> On Thu, 2025-09-25 at 23:29 +0200, Sabrina Dubroca wrote:
> > 2025-09-25, 05:39:14 +0000, Wilfred Mallawa wrote:
> > > On Wed, 2025-09-24 at 19:50 +0200, Sabrina Dubroca wrote:
> > > > > @@ -1111,6 +1180,11 @@ static int tls_get_info(struct sock *sk,
> > > > > struct sk_buff *skb, bool net_admin)
> > > > >  			goto nla_failure;
> > > > >  	}
> > > > >  
> > > > > +	err = nla_put_u16(skb, TLS_INFO_TX_RECORD_SIZE_LIM,
> > > > > +			  ctx->tx_record_size_limit);
> > > > 
> > > > I'm not sure here: if we do the +1 adjustment we'd be consistent
> > > > with
> > > > the value reported by getsockopt, but OTOH users may get confused
> > > > about seeing a value larger than TLS_MAX_PAYLOAD_SIZE.
> > > Makes sense to keep the behaviour the same as getsockopt() right?
> > > So
> > > add the +1 changes here based on version (same as getsockopt()). In
> > > which case, it should never exceed TLS_MAX_PAYLOAD_SIZE.
> > 
> > The max value for 1.3 is TLS_MAX_PAYLOAD_SIZE+1 (after adjustment),
> > since it's the max value that will be accepted by setsockopt (after
> > passing the "value - 1 > TLS_MAX_PAYLOAD_SIZE" check). And it's the
> > value most users will see since it's the default.
>
> Ah I see what you mean.  In regards to "but OTOH users may get confused
> about seeing a value larger than TLS_MAX_PAYLOAD_SIZE.", do you think
> it's sufficient to document TLS_MAX_PAYLOAD_SIZE and specify that for
> TLS 1.3 this doesn't include the ContentType byte?

I guess it will have to do. Otherwise, unless someone has another
idea, we're back to the discussion on v3 (ie setting the actual
payload size instead of the record limit).

-- 
Sabrina

