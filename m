Return-Path: <linux-kselftest+bounces-42426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1373BA188F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 23:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7DF1C2496C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC4A31E8A7;
	Thu, 25 Sep 2025 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="j7GI8KR5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GzHyPI6K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C772D0606;
	Thu, 25 Sep 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835778; cv=none; b=X/UACUVxwA7zKZfqmA+ElscME/mWblU8rIr/HlkQWNBgfZIneJgbru1rZu3eMvROjy0lbUZXvMEwbKLmb0LNd3P+HKBsDEYiV4QV3N+312ZyKTrRQBM9u/gEB2KDJiAaNtFqe/jZivMrboTsVMFZapQk7cHm2KQnyxECtl6suhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835778; c=relaxed/simple;
	bh=nU0iYwCQnlSmw5yBlXrF7I66fGXmBwqxgfW69Er0acI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+EltLBSzCbIA6QnNZoqh/lX8lcf92PHSsVkWuUVqRmF98RtvXt1+LqxzGgOgOy5YNQM8DArG2jc3D7olZCsnTZ8JrfheInAbe1bm9hWf4XCqACt/VrNxNrIbeK3Lc3Eq22UpABgOEvT/DuPM4e+btMhh9bT2r1vF3jSXOBdGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=j7GI8KR5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GzHyPI6K; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4953BEC0232;
	Thu, 25 Sep 2025 17:29:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 25 Sep 2025 17:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1758835774; x=1758922174; bh=GC/Q1ACXxMMzMjnRKBYD0oL9mQX91Hl7
	49jKbfI6tmw=; b=j7GI8KR5XQuAPHpemdB2VcGSpCpLuq7LnMMLHFDNj2agL3ai
	ZIygT2mnvcxkG2JsoHIcTpaNRteNADcwuee2GN5D5j9UA1ZViSuW01M5geBRk3ed
	wpeBFeDR6PxJKo5CKk90qiN208nE7ORrP17n5mu7wMc4N5eisEkV6GKEXG168dPO
	pkJ7qR+Cq6GqT22yWEaFkIcuC1m3/JQJ5euaxyUMvi6UEehkFWsLscfELZkAL4Az
	Zf2YnrQZZq3Ts+96a7i9bCL5GMnOYibltZNVSpPBZCZFkeXc8qIi1yiZhPDQwbxF
	7eaB1eAkJITOr2IO/mU4wQZ7l/CMIbXGiVJqCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758835774; x=
	1758922174; bh=GC/Q1ACXxMMzMjnRKBYD0oL9mQX91Hl749jKbfI6tmw=; b=G
	zHyPI6KwJ+QnhkIt2tlCN6h2GmvzDCajIcOYY+0ebJU9U8O/kqFQxFTImcS1LQXK
	wJ466j7fA8J6q439hrbbBNNb7OF15VGYP0/MAyTr+35c7zPod4d6W4Z18FjX1tiV
	iOkS+OM2GYZ90uyU9IY/vLuV29G4w2Kdjm+oGeobUWxGxJ6Sxo4nxgvajRnDqgOZ
	xo0QFZmwI4S7pgEwvNR48OdPVL9BewLtwdBvrSzHdjLHObdX23EZ6qTRxDh6WXuF
	r4m+XWjZsDHmm0ruhy0i1lxxPWFG7nD5wstyQuMuj+2+9WqyfcXo/svIo/5x/2Lu
	YcQqwnBR/pK9AwoT5IhJw==
X-ME-Sender: <xms:PbTVaJQFBu7l7xbm-4uRSe7bQ7aT2-2Wu7QVDSGUxKsPdWkPYtF0yg>
    <xme:PbTVaKClegVWNrXfTjRqSpNVYdDGtOeuQis6cDIMKD2hmSPkVoM7KvLffdcYmgwFU
    LrmVuNPbl-5kvUS-78u_H33rfBhxsQVg0l2lQvUEwNuArpQ47FlP4M>
X-ME-Received: <xmr:PbTVaJuMBiZbdoqCOrU0sgx4Po3Ea5G2gs42Kw_EHkjdvlUUZF9oYTpYjRO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgfdvgeeitefffedvgfdutdelgeeihfegueehteevveegveejudelfeff
    ieehledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhfrhgvugdrmhgrlhhlrgifrgesfi
    gutgdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthho
    pegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhinhhugidqkh
    hsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhh
    nhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PbTVaA-oazsC8BJcTfkOJ8vUa6ykrdG59jE5HhAy-4YL7kax1sEZYQ>
    <xmx:PbTVaIRHxpNYSbQveFqxdroIGYzm5DLY3EoingIQJ95gRT-E5ZEdww>
    <xmx:PbTVaKWe2FdsMab3YxlN6o0Wok2KDB5oIvauWQisOLEo3MBrll0xpg>
    <xmx:PbTVaC9KwJxUg0_8w7aPen79M-P3hHvWfQnnxVUDU7iHLGEDtGnUrg>
    <xmx:PrTVaOTXwRaSAvuDIxXJ-Gbp4mzIvO5SLsP_5GMsqNe8s9J4IQ-5XzP8>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 17:29:33 -0400 (EDT)
Date: Thu, 25 Sep 2025 23:29:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] net/tls: support maximum record size limit
Message-ID: <aNW0OxiN8M2hv7Qu@krikkit>
References: <20250923053207.113938-1-wilfred.opensource@gmail.com>
 <aNQvgD7AvFe7-sAv@krikkit>
 <4a83e2f526013516e2827a4ff8899b0437d08a25.camel@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a83e2f526013516e2827a4ff8899b0437d08a25.camel@wdc.com>

2025-09-25, 05:39:14 +0000, Wilfred Mallawa wrote:
> On Wed, 2025-09-24 at 19:50 +0200, Sabrina Dubroca wrote:
> > > @@ -1111,6 +1180,11 @@ static int tls_get_info(struct sock *sk,
> > > struct sk_buff *skb, bool net_admin)
> > >  			goto nla_failure;
> > >  	}
> > >  
> > > +	err = nla_put_u16(skb, TLS_INFO_TX_RECORD_SIZE_LIM,
> > > +			  ctx->tx_record_size_limit);
> > 
> > I'm not sure here: if we do the +1 adjustment we'd be consistent with
> > the value reported by getsockopt, but OTOH users may get confused
> > about seeing a value larger than TLS_MAX_PAYLOAD_SIZE.
> Makes sense to keep the behaviour the same as getsockopt() right? So
> add the +1 changes here based on version (same as getsockopt()). In
> which case, it should never exceed TLS_MAX_PAYLOAD_SIZE.

The max value for 1.3 is TLS_MAX_PAYLOAD_SIZE+1 (after adjustment),
since it's the max value that will be accepted by setsockopt (after
passing the "value - 1 > TLS_MAX_PAYLOAD_SIZE" check). And it's the
value most users will see since it's the default.

-- 
Sabrina

