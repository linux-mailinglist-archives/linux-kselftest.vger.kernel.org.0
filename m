Return-Path: <linux-kselftest+bounces-43267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B08BE0F7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 00:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4836519C1708
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 22:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36B3115A0;
	Wed, 15 Oct 2025 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="FqhVJ7WC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DLrCdUvz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2F2E1F02;
	Wed, 15 Oct 2025 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760568227; cv=none; b=cJQP9C9S3avavBaezihsrzlvMKzTwIhFPte14th19paeZDwSF8hBj/TU/fksXlClU/KEjVn40XycyinbJwoOlCpn5VLFPtGtS+FmpoXsvB0e8xbEVuuahnC1JkvMf10stZZy2vkyB9n0xpuCQkOJKhSM3EkWuVxJuX7WlPXeKm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760568227; c=relaxed/simple;
	bh=2B5d/DNK2MDj2tgCsKOW6zvpdYahTcXjjQFhoYn+WR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWGw5c0kunPD+/JNUD+EKlp3GjQ+iMZg//GrnH43ifOYpOB/tNjqn4hLwOrAkvQrUj+pyD9mntMgEtX2FPIpkb9o/o51SZxK3s/brit5UKwil7Aydz0kBD7zjyEjprX2RoZQ8vDf82DPKyYJ8xeJ3Yvg20/EamZ68UWV1WZih2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=FqhVJ7WC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DLrCdUvz; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 868001D00109;
	Wed, 15 Oct 2025 18:43:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 15 Oct 2025 18:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760568222; x=
	1760654622; bh=RZ7g3F3t9IBrmhQNcaWUuHVEd50extydIwUW9LGNnFE=; b=F
	qhVJ7WCGbPwoc2LOHWLjXBsH+uU1KonxRUTdwyzX7ESM4w8uSsSDC7rodgp8xwiS
	955cEz3e1XPd9+HnX8jCtMCySXKrd6vCL6WDGT95RecjNsDf7iIcXGjzStHBkuM4
	hDZ12SivkxG81NfzbhGr7/8hYXr1Cz62C/fN+kUfyK5UfpWHFLjuOvIq+9CGlRmO
	o1Uc+W0D0iwkLhPYlYv5hY/jtGtFEgwlPP9KQreHpZHA82a1T/TqF24at3Vm2/Lw
	VCB21UpIgJAaABu4M3HgLfwyqI5vCEusqCkFpVTWA2M22uFk0/u5gPwpA5r4F2BB
	3FX7ifX2dpb0gKjKMTcbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760568222; x=1760654622; bh=RZ7g3F3t9IBrmhQNcaWUuHVEd50extydIwU
	W9LGNnFE=; b=DLrCdUvzhsqs58F+d8DuE20GgqkBdH51uJhSoWxbvjHfOAgfk2c
	nYKnKDw7BrVFsSDSBenbU2+F3Rm6wHIHe1sClSKD8N6sgdKxonx8Pyzqz1F3pwR4
	dA1zzsjJ7Nk9jx8fEO9wb9OgwVbBk4CQnuWcbu7QQ7UYy5N5SZ35wMyROcwUpg/q
	rDAqCmcIVfpdwf9My5DqXkmkkVHysVG4F2kH2CBLqvQ6zXFDL4eCa0VH40cVrpiX
	GeyUm0NsoNcx/mDbdh27ZKm6T0yhTP53h5zRDyTOOSaT9dgNIpbbTJcwkeg0l+H3
	30A3jQC95rs9CdaOg+8TjbRg4I5MpnfiXzQ==
X-ME-Sender: <xms:nSPwaAKOiPZXlNyNhRO_DjqxN3KW-J4M0l44FGfYw1xC1WIuXUHgmg>
    <xme:nSPwaHsSJKQzjquCns-8cTeoSZXdLK7Zsq_2EjtFTz1yg5DnQjzrP5Itq05hZLQdP
    Q4QyH5RWWAOOCvSOlBNF-I_JCqRZ3GGhfVOmSapw_cN6Gm8Shbeww>
X-ME-Received: <xmr:nSPwaAVrBRoS9gpLw-04gfB1HgU-O6qf25fhfjkqKuvD07fY1Wq9-iyIrq8v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhfrhgvugdrohhpvghnshhouhhrtg
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuh
    hmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhm
X-ME-Proxy: <xmx:nSPwaKJuxKT6pHOuWXA29Lbxi80U2C1H0ttC2-9MqzYxC-Y4ZXDfbQ>
    <xmx:nSPwaN8usjD_lWOuU_TbOdEpugD-hY21P4CXHcWn2hDhjx5Qbpnl1A>
    <xmx:nSPwaAONFEl8k487AtCZTiwz3KcRzisNp5tAJwudxkPr3N_uD-Bmig>
    <xmx:nSPwaB3YMKNnopdMMPVs0sQ145brnxrPxs07gVwEk5KMb3a4f_TLVg>
    <xmx:niPwaKqQsxBWSJEywjfIwFrCnt1fc3VZJT-PlvHrUO_gZgO1JHrp_vGV>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 18:43:41 -0400 (EDT)
Date: Thu, 16 Oct 2025 00:43:39 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v6 1/2] net/tls: support setting the maximum
 payload size
Message-ID: <aPAjm1tKMKxIdUlj@krikkit>
References: <20251015015243.72259-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015015243.72259-2-wilfred.opensource@gmail.com>

2025-10-15, 11:52:43 +1000, Wilfred Mallawa wrote:
> diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
> index 36cc7afc2527..dabab17ab84a 100644
> --- a/Documentation/networking/tls.rst
> +++ b/Documentation/networking/tls.rst
> @@ -280,6 +280,17 @@ If the record decrypted turns out to had been padded or is not a data
>  record it will be decrypted again into a kernel buffer without zero copy.
>  Such events are counted in the ``TlsDecryptRetry`` statistic.
>  
> +TLS_TX_MAX_PAYLOAD_LEN
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +Sets the maximum size for the plaintext of a protected record.
> +
> +When this option is set, the kernel enforces this limit on all transmitted TLS
> +records, ensuring no plaintext fragment exceeds the specified size. This can be
> +used to specify the TLS Record Size Limit [1].

Since this is now "max payload" instead of directly the record size,
we should probably add something to describe how to derive the value
to pass to TLS_TX_MAX_PAYLOAD_LEN from the record size limit:

    For TLS1.2, the record size limit can be used directly.
    For TLS1.3, limit-1 should be passed, as the record size limit
    includes 1B for the ContentType.


And possibly mention that TLS1.3 record padding is currently
unsupported, so whether it should be counted in the value passed via
this setsockopt or not is undecided. (I'm not sure we need to go that
far. Jakub, WDYT?)


[...]
> +static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
> +					    unsigned int optlen)
> +{
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
> +	u16 value;
> +
> +	if (sw_ctx && sw_ctx->open_rec)
> +		return -EBUSY;
> +
> +	if (sockptr_is_null(optval) || optlen != sizeof(value))
> +		return -EINVAL;
> +
> +	if (copy_from_sockptr(&value, optval, sizeof(value)))
> +		return -EFAULT;
> +
> +	if (value < TLS_MIN_RECORD_SIZE_LIM || value > TLS_MAX_PAYLOAD_SIZE)

For 1.3, should we allow TLS_MIN_RECORD_SIZE_LIM-1? The smallest valid
record size limit (according to rfc8449) is 64
(TLS_MIN_RECORD_SIZE_LIM), so after userspace subtracts 1 we would get
TLS_MIN_RECORD_SIZE_LIM-1?

(but this would bring back one "are we 1.2 or 1.3?" check :/)

> +		return -EINVAL;
> +
> +	ctx->tx_max_payload_len = value;
> +
> +	return 0;
> +}

-- 
Sabrina

