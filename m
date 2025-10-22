Return-Path: <linux-kselftest+bounces-43803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38468BFE5A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 23:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10313A8CF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 21:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2EB303A03;
	Wed, 22 Oct 2025 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="xXVX6YRy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9qlZ4P4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C9927B354;
	Wed, 22 Oct 2025 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761169896; cv=none; b=COxvKno0rElx0kHIwQnb65MMicMc1jNOiq0TOfvcSHLS27TRkzoLjap5PzmrcQRPFgY7vdtHKTqlhIo05mx3A7mKPQlY9OQLxwM3n2onV8i68ah9KUsz70kghwIKiXv9p21Yv2+G26JS6lR89bnwwjwSRbhf2qp6lp9WIBjsN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761169896; c=relaxed/simple;
	bh=Csgx4084U4YDwsPrv6JpNx5OAIwV3UyzmT8/vFsITOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvXg4iRVTj+Ti1NDL7tOa50eWdYO79EUCJnADDFHs1+m1qv/lDn0UydacIfBTH1iHDcrXq7sOgpt+Sauyj/dRyV1oxpOe4veinqKWolVWrhW9V8vEP8IQaB1Dv5Bv881QH0GWyxphJmXNgICSUcw6c6plewh0dakidYstvspfD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=xXVX6YRy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9qlZ4P4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 72BE51D0009F;
	Wed, 22 Oct 2025 17:51:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 22 Oct 2025 17:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761169893; x=
	1761256293; bh=RCNv2Xdr29ryAQQMTausXK/triuxRIwwwzMKrwP1sU4=; b=x
	XVX6YRyhmqDB3V7gO9zZBGw8EnUMjrS6Kjxw+fFYnwg67fQFZspl7Vbtgc7/X+2e
	rs5nBlXxTXKn0P75a4JMwRsNDLzOdKWFo0qS5HdamudV9nUIgDdqImXMR6NQW6++
	DkjoUcGBW1dshHaawXHNLtsz9APH9uXwv37DcjlDFOH+MQWUsZNfGy5rAVMZNH9c
	R4f5yTyAJc5JWc9Bq8TJIuQukuhii/E1BLl3JuZuh0TN3AhNrtEX144P1xYpjvWm
	vq3wbGlj54hgTHhLF6jvCxov48xmy7K1pUGDEeLla+uO6B9TFB6yZpGK75DbHO+K
	O4fohGVFWYEdu6tvNYsog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761169893; x=1761256293; bh=RCNv2Xdr29ryAQQMTausXK/triuxRIwwwzM
	KrwP1sU4=; b=T9qlZ4P4hpsNSuXNZOh10BEp2+Z4K5AmR9rhdTeW81z2pJxrmA9
	e16JBzTJeRCSrEemIAerX6f16Zr0Xq+SrFREma8+e70s/21lDPa0XPp3k4OZQZ61
	u/OCU0u28/LCMZcClV/QGkO3IR6ACq38GyYpEvMKoMhRfXeKzym3XoVxvWI+vTw1
	bpX7P7k8d2an6A3yAzz/mUj+A4AkYhajPzNbsIQIqXBDto/xR5D3agO+JbYSAluP
	45DyXIOL5GtCCU/3bNcdESLc9lNr7iCo5V+nC6/7tl6uaOf2eMXl+Pk9FZq14ZXU
	0np5azoAxUhKlIlFzW0sbCbMVZY+l+0pBGA==
X-ME-Sender: <xms:5FH5aKmrR35NBcaOHtH-ZnU13VZ4KvdtyOrOd9OPx51oz6nnXdJ2ew>
    <xme:5FH5aONsajfHEwLJUu24DwEwcZ48TRHzgehvE2hlSoH9trYsydTM2w0Iq4oycC4iS
    qagW7_6RsXTqvc6iUWIMhQ6W5akqdqMKu1FgPJim8Sun5Yl1mAkj9Y>
X-ME-Received: <xmr:5FH5aNHfI7Qv9jVyvkvZVJAggnk8W6BWLwqvrP5SrY7HTSTdX10ERsLtqq7P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegjedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:5FH5aMsmPQgFdYa9xUmgCswYELwoaQ0d3GVbxVf0rRe1ufilzCrJsA>
    <xmx:5FH5aFSGzuya7gYYqqkTKbjQQWr3dAsDHeHWwQPbyXckOXFcrULu4g>
    <xmx:5FH5aOPNdSmW7vOaMRqqTxkgyzw2FTLj44KrvyE9b_lDRBbeT3UEaA>
    <xmx:5FH5aL6gkbkmqN9FYGfvLM-uVpJu4tRvUltwYiYppc2oGzP9zq4bbw>
    <xmx:5VH5aC8GjaelXwU53UjKdSoNjXuU-TVFVJunSqBp9AYWR9cPWoQrxYRl>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 17:51:32 -0400 (EDT)
Date: Wed, 22 Oct 2025 23:51:30 +0200
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
Subject: Re: [PATCH net-next v8 2/2] selftests: tls: add tls
 record_size_limit test
Message-ID: <aPlR4l220mtkjM5B@krikkit>
References: <20251022001937.20155-1-wilfred.opensource@gmail.com>
 <20251022001937.20155-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022001937.20155-2-wilfred.opensource@gmail.com>

2025-10-22, 10:19:37 +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Test that outgoing plaintext records respect the tls TLS_TX_MAX_PAYLOAD_LEN
> set using setsockopt(). The limit is set to be 128, thus, in all received
> records, the plaintext must not exceed this amount.
> 
> Also test that setting a new record size limit whilst a pending open
> record exists is handled correctly by discarding the request.
> 
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
> V7 -> V8:
>  - Drop TLS 1.3 tests for the removed getsockopt() changes from V7 
> ---
>  tools/testing/selftests/net/tls.c | 141 ++++++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

