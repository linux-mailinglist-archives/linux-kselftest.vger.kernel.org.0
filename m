Return-Path: <linux-kselftest+bounces-25230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1CBA1D87B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 15:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3487A3E11
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D9DFC0B;
	Mon, 27 Jan 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFvt2H4h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E783D64;
	Mon, 27 Jan 2025 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988401; cv=none; b=PXkgqyYyBFTNH3YCZN33QkeuBM6kxTFlX9IdIhTju8/ITnbjuXMIPkzoCpj1m2z42jejLGNrvad0Q6hVNEihjMGA/GEHAnE5/T5f+CYuseC89ae9CYYFaIKlQRxa1nhjaRdneyPYKW1TAkbeNifO3Y5ZumgknO0TK2ajGKLEVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988401; c=relaxed/simple;
	bh=FaRAosq2Dn/9WrhcX9lSIG96XO9n67MGygKTNGXSyGo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kc1cXzu+vQU8SuH4osXD+tCfMFMBL8RnaB6cny6M5GAX9vS0q1VXz2/AYvDJkFzW/qF+2UpXaxVgt3eiIXNmeaCeyzKLbBec8u+Wv3f19BE4j+0qFotAe84apk5TRoY10lXtWFr7cs3CilYkVeqR0JfU6mNxWbn9W0OZf9hYs5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFvt2H4h; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so671058985a.2;
        Mon, 27 Jan 2025 06:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737988398; x=1738593198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTaRABt9WEj+gqGe6GqcQlVywh5NvD+IMM2h++oT6ik=;
        b=RFvt2H4hUV9l8FAchALgP/vY6hgesORmpdTglgvKvYbNMs98J8RfnLj5o2SUNnEiYO
         zS2W86T0K1OrT9ycG9M1UCvTjqflD5111NFpNxumMZnvuMR6sA486surUxWxSUs2/qe3
         dayxcgJJ119fjDAwT9QGd6n8lEYRVgVi1OgTQhPJ0NPofmIjT+UXLiutNrc3FnIr9fmJ
         wiotPZd6j9dbZ3rxfMv7hKGABuO3WK5U2LVCvgv0t3YBb1IXhIIrASvHfkaYJKEu5cIw
         tXQr7TB4ubdDciSbu/qAaNf5OZCaFX12NasRwJBOFxNUjNr/2hyRNNxSTIrvJhugZRBD
         w/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737988398; x=1738593198;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZTaRABt9WEj+gqGe6GqcQlVywh5NvD+IMM2h++oT6ik=;
        b=FKr6iA1QE0C5axz/2Okrf7xfQ+7u+sH74DvxCCc7Cyz/hnTdrnLrOCY3w9X2p15KwP
         +oFDQyVsRAIdE9txpmPF9GmtFpiTgyR9qJD9WQmIlwbnYe/c2ekJtXGyJw5/mecTMITN
         2A0McQK+bDWcSLk9I8HsSVaGPDVGe0SZDSJBlYzyNyuJD7qxn3Cg7+61pmXawpWH1H1d
         N6rRoRPB84R3z9mIewfizQZ8D8WnESmF5mxhj/8ZS486ZUiu5YQPHKApg4MVp51+PMxU
         j2Wq9s4KPWsit4sYJJyWUe+ZQsO1M3L6BcbUybG58grJhmSxr94VjQsux1d33hTvtWkH
         GWIg==
X-Forwarded-Encrypted: i=1; AJvYcCVZpCGNGOJDbyE4YCyD90y7qFs3oPSCn+WOe5VpFtYHik/+UYEMh0LzZ6HKJrJZKTZGVmrVExX3@vger.kernel.org, AJvYcCVl92kxQ20w5OZqT9OlEJ82osWPfbISb1d+KdGpNCDUbH6nA/IcyO5hIfsb1Zzb6+wbphSRwyJtZWYV7lQ=@vger.kernel.org, AJvYcCW+ae5PAc59k6SMRYbZdDuvi6d/jJWh7wOfI6SEd9g4dXADXhFf4znXqJp4PRtSI/MMxUcpaRlZHQr/ldrr2kx5@vger.kernel.org
X-Gm-Message-State: AOJu0YzLpX7viAjY/hk3g38g+FU4k+fPXFWx/hq7Hg2bWvyliC6dk8tr
	gPkFqDyZN2dHBMv2DZdYHepTuPDydT0F+q9Xb1EsWRvfZi1k2Nilclugtw==
X-Gm-Gg: ASbGncsMJCSwfI4RYGplhXrcNcSId/483Chgt0/+VVFLgkZh1d+gZpvAt0j9AMwVJVt
	8JrJIEEfGeu/BNfLlGwb/AHGOW7Gd2J4zakkN6vpjQMghXbrLeBlBQ3p0Mtsm96ogx1PmQEKHRh
	gcBNbt/pqCogu6E5offgGrlPvpB1tGZn6nEvtD8axaeXescU0BY83/TvgD+gwuVi2vZjVuw11k8
	WZM8QMbrjeulnWESZhX1KyC23d0IIpiXN2WlTKqchx9DD08V6BYo9qbZj4KwHoGQZ55XlUJod/V
	qY5ZZNtFQ+0Qfzyh+p5xnWppNOQOEuN45fnKD912VcK71QVqbdAf
X-Google-Smtp-Source: AGHT+IFW9c4VoXRtbmmXIJoIVD+GxDMQBIhzDLUsHtgRq8DIDe3eTZKvXdArclp3f300/smiAEtY2w==
X-Received: by 2002:a05:622a:15c8:b0:45d:8be9:b0e6 with SMTP id d75a77b69052e-46e12bdc8bemr668652771cf.43.1737988397639;
        Mon, 27 Jan 2025 06:33:17 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51e4ea35b4bsm1445410e0c.6.2025.01.27.06.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:33:16 -0800 (PST)
Date: Mon, 27 Jan 2025 09:33:16 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yan Zhai <yan@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Josh Hunt <johunt@akamai.com>, 
 Alexander Duyck <alexander.h.duyck@linux.intel.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6797992c28a23_3f1a294d6@willemb.c.googlers.com.notmuch>
In-Reply-To: <Z5cgWh/6bRQm9vVU@debian.debian>
References: <Z5cgWh/6bRQm9vVU@debian.debian>
Subject: Re: [PATCH] udp: gso: fix MTU check for small packets
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yan Zhai wrote:
> Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoided GSO
> for small packets. But the kernel currently dismisses GSO requests only
> after checking MTU on gso_size. This means any packets, regardless of
> their payload sizes, would be dropped when MTU is smaller than requested
> gso_size.

Is this a realistic concern? How did you encounter this in practice.

It *is* a misconfiguration to configure a gso_size larger than MTU.

> Meanwhile, EINVAL would be returned in this case, making it
> very misleading to debug.

Misleading is subjective. I'm not sure what is misleading here. From
my above comment, I believe this is correctly EINVAL.

That said, if this impacts a real workload we could reconsider
relaxing the check. I.e., allowing through packets even when an
application has clearly misconfigured UDP_SEGMENT.

> 
> Ideally, do not check any GSO related constraints when payload size is
> smaller than requested gso_size, and return EMSGSIZE on MTU check
> failure consistently for all packets to ease debugging.
> 
> Fixes: 4094871db1d6 ("udp: only do GSO if # of segs > 1")
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  net/ipv4/udp.c                       | 18 ++++++++----------
>  net/ipv6/udp.c                       | 18 ++++++++----------
>  tools/testing/selftests/net/udpgso.c | 14 ++++++++++++++
>  3 files changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index c472c9a57cf6..9aed1b4a871f 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1137,13 +1137,13 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
>  	uh->len = htons(len);
>  	uh->check = 0;
>  
> -	if (cork->gso_size) {
> +	if (cork->gso_size && datalen > cork->gso_size) {
>  		const int hlen = skb_network_header_len(skb) +
>  				 sizeof(struct udphdr);
>  
>  		if (hlen + cork->gso_size > cork->fragsize) {
>  			kfree_skb(skb);
> -			return -EINVAL;
> +			return -EMSGSIZE;
>  		}
>  		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
>  			kfree_skb(skb);
> @@ -1158,15 +1158,13 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
>  			return -EIO;
>  		}
>  
> -		if (datalen > cork->gso_size) {
> -			skb_shinfo(skb)->gso_size = cork->gso_size;
> -			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
> -			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
> -								 cork->gso_size);
> +		skb_shinfo(skb)->gso_size = cork->gso_size;
> +		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
> +		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
> +							 cork->gso_size);
>  
> -			/* Don't checksum the payload, skb will get segmented */
> -			goto csum_partial;
> -		}
> +		/* Don't checksum the payload, skb will get segmented */
> +		goto csum_partial;
>  	}
>  
>  	if (is_udplite)  				 /*     UDP-Lite      */
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 6671daa67f4f..6cdc8ce4c6f9 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1385,13 +1385,13 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
>  	uh->len = htons(len);
>  	uh->check = 0;
>  
> -	if (cork->gso_size) {
> +	if (cork->gso_size && datalen > cork->gso_size) {
>  		const int hlen = skb_network_header_len(skb) +
>  				 sizeof(struct udphdr);
>  
>  		if (hlen + cork->gso_size > cork->fragsize) {
>  			kfree_skb(skb);
> -			return -EINVAL;
> +			return -EMSGSIZE;
>  		}
>  		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
>  			kfree_skb(skb);
> @@ -1406,15 +1406,13 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
>  			return -EIO;
>  		}
>  
> -		if (datalen > cork->gso_size) {
> -			skb_shinfo(skb)->gso_size = cork->gso_size;
> -			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
> -			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
> -								 cork->gso_size);
> +		skb_shinfo(skb)->gso_size = cork->gso_size;
> +		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
> +		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
> +							 cork->gso_size);
>  
> -			/* Don't checksum the payload, skb will get segmented */
> -			goto csum_partial;
> -		}
> +		/* Don't checksum the payload, skb will get segmented */
> +		goto csum_partial;
>  	}
>  
>  	if (is_udplite)
> diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
> index 3f2fca02fec5..fb73f1c331fb 100644
> --- a/tools/testing/selftests/net/udpgso.c
> +++ b/tools/testing/selftests/net/udpgso.c
> @@ -102,6 +102,13 @@ struct testcase testcases_v4[] = {
>  		.gso_len = CONST_MSS_V4,
>  		.r_num_mss = 1,
>  	},
> +	{
> +		/* datalen <= MSS < gso_len: will fall back to no GSO */
> +		.tlen = CONST_MSS_V4,
> +		.gso_len = CONST_MSS_V4 + 1,
> +		.r_num_mss = 0,
> +		.r_len_last = CONST_MSS_V4,
> +	},
>  	{
>  		/* send a single MSS + 1B */
>  		.tlen = CONST_MSS_V4 + 1,
> @@ -205,6 +212,13 @@ struct testcase testcases_v6[] = {
>  		.gso_len = CONST_MSS_V6,
>  		.r_num_mss = 1,
>  	},
> +	{
> +		/* datalen <= MSS < gso_len: will fall back to no GSO */
> +		.tlen = CONST_MSS_V6,
> +		.gso_len = CONST_MSS_V6 + 1,
> +		.r_num_mss = 0,
> +		.r_len_last = CONST_MSS_V6,
> +	},
>  	{
>  		/* send a single MSS + 1B */
>  		.tlen = CONST_MSS_V6 + 1,
> -- 
> 2.30.2
> 
> 



