Return-Path: <linux-kselftest+bounces-43659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC07BF683B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 14:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED12134599B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7F3314C4;
	Tue, 21 Oct 2025 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="P2TSt6sH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vMqbhdBh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9A330B0B;
	Tue, 21 Oct 2025 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050708; cv=none; b=G12YY22il6WTAeVBFOT7y6ElsFxbGfMXhoBCMicdLkGs6Vbl5dZKzcGD0lpODOZs/4n0GO0F0YP/jS7X+rnBC2fWASUhJvGydKeJrfVbX2u7sce4pyJSbSjiJHJmL8/PU1LMUO9FuqwEj2ZL6HvyOtRXVlpT06t2sL7OKYFM9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050708; c=relaxed/simple;
	bh=R2kJsOH4TDONKCo/+SareOThYcnZIqqWXQFph/AdTYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBxvlJUKRBitdARPt5G2Yc7+zET8zP+h/oRuUPo7Sb8+1eknI8LVw90wWITkYDEKNDYfey7UeMo9+hyhxO3BffdIAkhmiQi5etRSieA1CjH5p8FMny2AFFbONUG3YjBmB06WY40NAsirQf2FxCi69/Py6Q/9cMjfkbKtkTA/Hj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=P2TSt6sH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vMqbhdBh; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C4561D000BF;
	Tue, 21 Oct 2025 08:45:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 21 Oct 2025 08:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761050701; x=
	1761137101; bh=VJQvSbwrg6PINiCTEISqmNZW2C/OLur61op4W7UVtDI=; b=P
	2TSt6sHjjBDDorM42j9GKt4/tgcMBn1FXxZ7HhlOL7z7Q8Vb7kZDh+FU7SnlVOUi
	AeLVe7Z0Qjhi6csKEJ+4lukk2Gq4JwAXIDw5hdRpa1YmoEE+XOE+sRnCgRSvYdXp
	USJ/jNU4vMFRFG+eHUF+hT1sCAFRs7yKGAqHVEvp1EObA/gQho0hgdgFrhzqs/Ws
	FQ7DuqLIim4qE0zqoNujHFnkTUGeE48bn0xbl3wMgg+L9NN+RJXTiy/caRLiWHJM
	VYYb1liFB2twI1J1LbHxSqxqn0tNIojF02WWuqzueBP94f1rj5h0+KX2+mTpDSlB
	tmOFzLN/dUGp2BV2Z++Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761050701; x=1761137101; bh=VJQvSbwrg6PINiCTEISqmNZW2C/OLur61op
	4W7UVtDI=; b=vMqbhdBhiisP9/h906Pa93HVoN1eHWP6+PCfpqY1ZJipF9Ekzb8
	l5/QmJUYATXKLcLugOeBtKh6vKeKyeY75KbwGuYHmR3kbiqSAVgv/rU3JExBqDtz
	JLG+QShw6uSimDNyOm0RPneOtzElg6xGkmRA7B+pnyB1CSNOYdamqrPSlCkE7dVw
	OGnDIcsVvWb2r5YYeKqFt3QFoBfnp3UDv0kc3up4qGaPshhPNnUlV9PC/AUSrPH3
	F/J/iY0OrxHha+PYenITLu7ZEReecwV5jashTOmGUZzZYC+MEKksqxIp4ZnvoTbZ
	IEeeM5fMnbiVU1XX6QzNGC3Eqx+J3sVhjJw==
X-ME-Sender: <xms:TID3aJLtBfJPrcK55rpKBVyE-jiiq7j0uG1pTfOghs-4aOud14q6Jw>
    <xme:TID3aBjTbz8i_yRwEa2N5rBO-jhYbq6feEcJyCvqiECQ1aygy71K5yYCczXrqUhaW
    UJVO0Fanuh7mkCA7cws-hdto3-dyekpChwmqs3LU1sUGJMPWEfQPw>
X-ME-Received: <xmr:TID3aGICICdxniT7o8tqvlsFb4siRwfYZ6NM3fVy6vTzBs6mRFE-C0U-36g0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhfrhgvugdrohhpvghnshhouhhrtg
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhm
X-ME-Proxy: <xmx:TID3aIgkUiBTsH-6aK2KRGnVCp7Oorqdm7VtIyRSvlkaAwxziLPqgw>
    <xmx:TID3aM1d8tmPbNB_pJgsycnVQfcxxA1FWF7h3txsCOml3IXlVLx80w>
    <xmx:TID3aGhC2-YFYWeUZqYVc3UDZyUMJaVUrnJg0o-rgmVG0j8toWIY8w>
    <xmx:TID3aF-7D0UvCz7lGrFOuPvJpETkWvYlK86vL_1-SGpZqAxVxSElzA>
    <xmx:TYD3aBCdKB9q3gzfEsv-AdpflRZjXBqpzcg7KPJfs0hzt5ryLPbRyjPE>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 08:45:00 -0400 (EDT)
Date: Tue, 21 Oct 2025 14:44:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH net-next v7 1/2] net/tls: support setting the maximum
 payload size
Message-ID: <aPeASl1RRAKMmuhC@krikkit>
References: <20251021092917.386645-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021092917.386645-2-wilfred.opensource@gmail.com>

2025-10-21, 19:29:17 +1000, Wilfred Mallawa wrote:
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 39a2ab47fe72..b234d44bd789 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -541,6 +541,32 @@ static int do_tls_getsockopt_no_pad(struct sock *sk, char __user *optval,
>  	return 0;
>  }
>  
> +static int do_tls_getsockopt_tx_payload_len(struct sock *sk, char __user *optval,
> +					    int __user *optlen)
> +{
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	u16 payload_len = ctx->tx_max_payload_len;
> +	int len;
> +
> +	if (get_user(len, optlen))
> +		return -EFAULT;
> +
> +	/* For TLS 1.3 payload length includes ContentType */
> +	if (ctx->prot_info.version == TLS_1_3_VERSION)
> +		payload_len++;

I'm not sure why you introduced this compared to v6?

The ContentType isn't really payload (stuff passed to send() by
userspace), so I think the setsockopt behavior (ignoring the extra 1B)
makes more sense.

Either way, we should really avoid this asymmetry between getsockopt
and setsockopt. Whatever value is fed through setsockopt should be
what we get back with getsockopt. Otherwise, the API gets quite
confusing for users.


The rest of the patch looks ok.

-- 
Sabrina

