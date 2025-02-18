Return-Path: <linux-kselftest+bounces-26822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D019FA39094
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 02:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A4E171DC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 01:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C93F13B7B3;
	Tue, 18 Feb 2025 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEk7WWFK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE6219FC;
	Tue, 18 Feb 2025 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739843258; cv=none; b=ZCW1soHSPuOfXQACEzfjQQoOXB+JrgCNifx2R+q8/bD+cgo7DYQZmm5aR5cMzLJ0K063m1O+dmCSQnrAm/NB6TDVrm8OdHuoHC9bpastLZSUnIBYHg3GWpRr0lvDtvpHb2+N5+lp1KfSJfLDUgVsR3PPbPE864ndlnOyRmBYeOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739843258; c=relaxed/simple;
	bh=MD0O++YsPWI7g9h2EbnImSYEctbv5gi+1ZvRA2ioAg4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YcChCDfsiHD1qPtY8FUfL/0qbLTAJvzThfaEv0QJ7YeX8ScH0N+qzgh534zmlPcZPZlGsqYCIGvVOEHjAv3X4mCh0G7oAB6wMZ9DEwkfeFCoLLV5mfYdXho04dMw3g6a/GQQgQIMlZ9UuHWUxS3KqdWdQXGm1U/lAS+TxmxirGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEk7WWFK; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471fe5e0a80so4487661cf.1;
        Mon, 17 Feb 2025 17:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739843256; x=1740448056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2cOjmO89AYodXPo11gNtDewEZteT2LNDBnbm1wOXKY=;
        b=CEk7WWFKhKLQ4CzCFitMPBQj4WSH6C1YrG3XPYuf4x+Ljls8uMzEUL74ucBTRMaz6B
         1H5Ww90rW0RrHwCqrN4sySo2pnudFB835Txy1T2ZDX18a0fML26Q4nMfdbJw4fvpEQG8
         UZ3wK6+77X0n99XdSEBdJ/c1hOaD23S1UysxtBeSPHsHbLrqurEgbAQJhjgPDAOhnAg5
         xKkusZFhYlPuAe4EEWXfuG6HdQjN48E7YoZLNyTYHN0xKTe9dKOt1ZrTOUvb2rHlwxCW
         YALWjrdKDHjXT2NMFawOgdMWRhPp0EXo04U2ahDCrbu5YGWmJ4LyedXd4cVALmyCzBkU
         iuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739843256; x=1740448056;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A2cOjmO89AYodXPo11gNtDewEZteT2LNDBnbm1wOXKY=;
        b=tTfDrnFc1TBoNg/6g8RkmqPvv2mVqsR5H1XQCluadQy842jrRKio4Ulpo/1uL+Q87S
         q29hseNWz2/5AQ9SVgNQ1UdxKFH2qtZyo6cm2AIvg72QRodq5Sr1L1oRFOHYIl6eNxnl
         3mK3caPyhTCMMm3sZzqEC3kM64+rgK+qDJZWMx5VfuOYG6fFBNw+wMrSsr7giCMLLx3Z
         0lPU5RHDtrO3Ykef2MxJd0p/T2xwfk0Dr4HRrvA++maohUlkJ6molVORjAbHHYyPPB2P
         BcASuAsZQD76Bk5yrmjqbg5zSd173kTK/WxwwEPfcjlI8rdtYS5JSaskkFqE0Di62GPa
         oNWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBiG8YL1BdJ38K1EOqzWUOJWynEhveMa6iHcaNG7OuJFZAjH2iAcwyzmv7zBga5Qss7ZY=@vger.kernel.org, AJvYcCWYehNfMgLuKnwdxdzcoh1JoIivFO9PWqmExe2mb7aPOsjBNxfp7GSH9hNS8xynDSb2uAe6i6XA@vger.kernel.org, AJvYcCWj9sfQjHoVhML8x4iJO+ikRmJnr13uMxbGCHJnfbmdEs2ra6ad2+wqKj+AkFcWy8dX2kk6eh4CZUS0GEDdeNJ7@vger.kernel.org, AJvYcCX8z6imlkDcmdudHdgqZxgPxDNmfC3OpuOujHbJ2ezfA4/0tGkU/AtPRBqrhfyXJZd2IIpiGqebe9JCU8O9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OKQOyQEFTLle0eHFVpMm2zBqJetQqrIwYtkfQdJZwHoSfv7u
	rGGh/etptj5oi7/9B/QTU1kUDkJpartRX/kitQSylAPsMnaB1rUC
X-Gm-Gg: ASbGnctpqwVd+CjNCGTGMdyhRUpAlW0ephcEP7gb+tu47eRanssBL4mTbLKc4+c5y9g
	sOtq7auamY31FwJES3GfcAbIg6QWyN3qnz6FZmBnOBu0EFzR3fZNBZoZo2HnE8cS3Ho2YpbuHnQ
	33krX+fU/IXnY7zvB0DoeBWqVUCr5C5yz3E9ScjEA1Mh8QC1zBMv6+45ml3jvvouumv4ZtwftNm
	oMWrpwBpGpSHE4LS0z0J3con3mkau9TF2idG7cd8m0jTv3379m9tRGFYfhlA8CMgL89ekGZWWnU
	BjFGMjba4JC44g+j2Z2n4KhJVvRbJa6dRWgt0nEcBNzBFmZfNdONmXrVfxmWnx8=
X-Google-Smtp-Source: AGHT+IFGgETKhlo/uMkwC6itYIAoHfWPc1J6iqltxry1ghsVvueLEc/nCmHXq/x8V7O65Ks6+inS6Q==
X-Received: by 2002:ac8:7c47:0:b0:471:97db:60d4 with SMTP id d75a77b69052e-471dbe8d755mr137648981cf.45.1739843255555;
        Mon, 17 Feb 2025 17:47:35 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2a130adsm53812931cf.26.2025.02.17.17.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:47:35 -0800 (PST)
Date: Mon, 17 Feb 2025 20:47:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 hawk@kernel.org, 
 marcus.wichelmann@hetzner-cloud.de
Message-ID: <67b3e6b6b9dc6_c0e2529482@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250217172308.3291739-3-marcus.wichelmann@hetzner-cloud.de>
References: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de>
 <20250217172308.3291739-3-marcus.wichelmann@hetzner-cloud.de>
Subject: Re: [PATCH bpf-next v2 2/6] net: tun: enable transfer of XDP metadata
 to skb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcus Wichelmann wrote:
> When the XDP metadata area was used, it is expected that the same
> metadata can also be accessed from TC, as can be read in the description
> of the bpf_xdp_adjust_meta helper function. In the tun driver, this was
> not yet implemented.
> 
> To make this work, the skb that is being built on XDP_PASS should know
> of the current size of the metadata area. This is ensured by adding
> calls to skb_metadata_set. For the tun_xdp_one code path, an additional
> check is necessary to handle the case where the externally initialized
> xdp_buff has no metadata support (xdp->data_meta == xdp->data + 1).
> 
> More information about this feature can be found in the commit message
> of commit de8f3a83b0a0 ("bpf: add meta pointer for direct access").
> 
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> ---
>  drivers/net/tun.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index c95ab9c46bd2..3dde6cd29a84 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1604,7 +1604,8 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
>  
>  static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
>  				       struct page_frag *alloc_frag, char *buf,
> -				       int buflen, int len, int pad)
> +				       int buflen, int len, int pad,
> +				       int metasize)
>  {
>  	struct sk_buff *skb = build_skb(buf, buflen);
>  
> @@ -1613,6 +1614,8 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
>  
>  	skb_reserve(skb, pad);
>  	skb_put(skb, len);
> +	if (metasize)
> +		skb_metadata_set(skb, metasize);
>  	skb_set_owner_w(skb, tfile->socket.sk);
>  
>  	get_page(alloc_frag->page);
> @@ -1672,6 +1675,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	char *buf;
>  	size_t copied;
>  	int pad = TUN_RX_PAD;
> +	int metasize = 0;
>  	int err = 0;
>  
>  	rcu_read_lock();
> @@ -1699,7 +1703,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	if (hdr->gso_type || !xdp_prog) {
>  		*skb_xdp = 1;
>  		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
> -				       pad);
> +				       pad, metasize);
>  	}
>  
>  	*skb_xdp = 0;
> @@ -1734,12 +1738,18 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  
>  		pad = xdp.data - xdp.data_hard_start;
>  		len = xdp.data_end - xdp.data;
> +
> +		/* It is known that the xdp_buff was prepared with metadata
> +		 * support, so no additional check is necessary.
> +		 */
> +		metasize = xdp.data - xdp.data_meta;
>  	}
>  	bpf_net_ctx_clear(bpf_net_ctx);
>  	rcu_read_unlock();
>  	local_bh_enable();
>  
> -	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
> +	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad,
> +			       metasize);
>  
>  out:
>  	bpf_net_ctx_clear(bpf_net_ctx);
> @@ -2456,6 +2466,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>  	struct sk_buff_head *queue;
>  	u32 rxhash = 0, act;
>  	int buflen = hdr->buflen;
> +	int metasize = 0;
>  	int ret = 0;
>  	bool skb_xdp = false;
>  	struct page *page;
> @@ -2510,6 +2521,10 @@ static int tun_xdp_one(struct tun_struct *tun,
>  	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>  	skb_put(skb, xdp->data_end - xdp->data);
>  
> +	metasize = max(xdp->data - xdp->data_meta, 0);

Can xdp->data_meta ever be greater than xdp->data?

This is pointer comparison, which is tricky wrt type. It likely is
ptrdiff_t and thus signed. But may want to use max_t(long int, ..) to
make this explicit.

> +	if (metasize)
> +		skb_metadata_set(skb, metasize);
> +

Not strictly needed. As skb_metadata_clear is just
skb_metadata_set(skb, 0). But also not wrong, so fine to keep.

>  	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		kfree_skb(skb);
> -- 
> 2.43.0
> 



