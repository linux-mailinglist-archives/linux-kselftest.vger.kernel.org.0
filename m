Return-Path: <linux-kselftest+bounces-26821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C23A3908A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 02:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC8D1681D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 01:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6532BB15;
	Tue, 18 Feb 2025 01:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Q0m0Ig"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0324B28;
	Tue, 18 Feb 2025 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739843148; cv=none; b=ZOUrIbBEZ2KqRPEC8iiUsSo41IU4Z+kdA08yi6u3LP7H0SdxZJWqIRF9Qjm/ChbjoRXdP4deM0BMv8xLpRfk2jlxDIrlM2gOaF1wGKl0fScGEc3s7B1y+/zNoRa4a2YFsBu8s0uziK585dePg02bxiKrrN1Pas8dA2Wxev4hhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739843148; c=relaxed/simple;
	bh=dd/BMDQd5O0kXlv442P9JNNpgKzbK3YBUOBGDlr3DzA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=B2WpwWCJQeFJr05xqKtPt5l2S8QJDNKNB6uFQY2kWUepVqzooN7F31lAZlJ9OrGoBs1uYIxBOh4lpgyW8JintIvFfQJHT6SxovaQsMnPcVfsM5rpvciRggVS4SfBL21p0TbPJjp/aX3ifostZPE85qVm8Q9rOytE9EuEy2AIoAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+Q0m0Ig; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c079f1d96fso579733685a.1;
        Mon, 17 Feb 2025 17:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739843145; x=1740447945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIcnEGluZXpiACMlDdbOZBn8bkJXu1LahqOjG7kWmtM=;
        b=T+Q0m0Ig0FvWM1sb7EKPmqxbG2mNGgQ/cZumATHyl/PP0yXROPOCA3l6E9g7zh7+Vp
         BXZ8IuVUZM/G30595ckxpEK+8sbICvF+N5ELED63m43LkubUz3iCoWn1DjSle4n6htqw
         ESIFv/OK1W9GM4SzFX+IwdkZSupsP/TbNT6OsdnyfPnoeA7kWUxrE/YOcPPTbVOwHsFz
         fAb9vm23K4YLFF1cfgAJPXg26qlJcVtIJm2MZ3dSu9EX7TlPLF/66URs4rqL9IHpzfWe
         orJYNTy0XiSQFQqUOQKM0Ip2NxKzpWMa3u/tTEQ9AZFhuXhFLnuF78sIr3uUoNAQjcBP
         mLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739843145; x=1740447945;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kIcnEGluZXpiACMlDdbOZBn8bkJXu1LahqOjG7kWmtM=;
        b=tc86CNEfNiiyHVn3nQnTYPyP2DPT1EygJrvOdQyD3N1wuv9hwFxOL7KGyUTimnueiS
         6pnZvHsvKEqEPZCho+Cfb9hjAr7qeG1PmV9Xe02wWufFu9Sm+cYjaCbovZvOcdiVHgvk
         rvF7t1Bo0FPXkrRJ6vrA55dBab+fvxpoCwpP1EAf/pKL0AI8/lSd6px8FzKEbLyZOT5D
         HpC6wIpCz0Iy8KPvs7XO1EqO09BJt15+WwgAkRSXooeD5SvpXo06f+UMS9yoJCMAMOgh
         VvS4TCgoCcWx/BUejO7tzkqcDzsvy4pWUgg2JoRmReK1L6uQfH1mOLksKShgKHs0Nh7X
         h/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUC6DW+r+62k3+BWUWN2E0PTzNahOxFZMh97BlX0E8I/hRLMzIsaGj/WTHvEQXrpyr/xXELk17oyUD3bqF+@vger.kernel.org, AJvYcCUq2rxSUCZL1UVyagDARdlpdTG9er6/8Qe2JbubhJmxOAGvyvoSMd2kXhcidop3LXfW7KTqBqWTlC/cDNo/Hrzb@vger.kernel.org, AJvYcCX4y1lUFNawIjNH+gNvyDM4JQoXocBih/4ijcVkVaewtog7e3vUKJBsB6EUuaFtfPEdFxo=@vger.kernel.org, AJvYcCX7nUbXsvV06MSRzAvzitxcUXvW5szPAP7MOYjpY4WRN54wBQwIZgC/tM8A31ffm97Nix/QRYc+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5yfaImO2/Ne4ka2JDxWL8zgkZTgGBJOvsOb3eMiraLQh89XpF
	Lclgc/DEGXT4kBZda8OPiem40Vpi+pz+JPDPhuuHbqHE1U4LR8I0GLemJA==
X-Gm-Gg: ASbGncuM8gHeCUercHhmKoHKozUCBfyAd4NswkApb6jJpOuJGkH99Aqsjn5oT+B7YZ8
	hWNEpkVhcB5t0Fzf0C3HlbaMfeYcbDFGbwlxN775oEPOI2qDvKlxgAQcQa02KkrQ/bVlPM1/dZ7
	tHYJwWB68W+icimddZ3LX+7oLKDp+NU2hYC0BxdepBWsfBWAVI17OlCGjVpJxEWn+XALZ5Zn7C5
	UNcY+N7vZRvx1E0kywAvXN17OfEH7bL2BAJplOsjdcnLMAp0qHpiZmHnEjw3EhrebI+xH74eDvA
	mgQJTbopUEP0RB9Cb+iOzB+jgiBRtOeTDVAN2d2us5HM4rOjpqZ17Z/g5JhQ8e0=
X-Google-Smtp-Source: AGHT+IGWSoB4hoQA0eu73Z6Sc4usTrO+4HkQXDvbBvSWR5UF0FQROE5OGv3zuYl64VJSXqFRNwqHeQ==
X-Received: by 2002:a05:620a:269b:b0:7c0:af16:b4b0 with SMTP id af79cd13be357-7c0af16b5f6mr25161985a.12.1739843145397;
        Mon, 17 Feb 2025 17:45:45 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c6088aesm602311185a.48.2025.02.17.17.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:45:44 -0800 (PST)
Date: Mon, 17 Feb 2025 20:45:44 -0500
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
Message-ID: <67b3e64856f5d_c0e2529442@willemb.c.googlers.com.notmuch>
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

Is it ever possible for xdp->data_meta to be greater than xdp->data?

This is pointer arithmetic, which is a bit complex wrt type. This is
likely ptrdiff_t, which is signed. But may want to use max_t(int, to
make this more explicit.

> +	if (metasize)
> +		skb_metadata_set(skb, metasize);
> +

Technically not needed as skb_metadata_clear is just
skb_metadata_set(skb, 0). But fine to test and elide.

>  	if (virtio_net_hdr_to_skb(skb, gso, tun_is_lttle_endian(tun))) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		kfree_skb(skb);
> -- 
> 2.43.0
> 



