Return-Path: <linux-kselftest+bounces-7913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508208A3FD5
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 03:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACDDDB20C8E
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E58B101E6;
	Sun, 14 Apr 2024 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri3lec7L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22A28EC;
	Sun, 14 Apr 2024 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713057330; cv=none; b=oAaFbbKv+gH7K+KKvXoaSGkMDA6UooTHOcL+jQPDcAA/OKrivT6QESjDkyLvB3KSOWmfhgegy2ND1N8/aSqwrggpP8ceRtGs/FL2soXazPOscysDL/H6eBXZL2k2UCohfZ9DpiZ4gjRg5H9frLpSEcRzNS8yTZSSSjN8gv4TRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713057330; c=relaxed/simple;
	bh=W/juxec0rDn1Gl/Ih629Zefv8Pt2+BZrC5+L6AhJXfo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ktmYnpOyq72ynpN5L1qSS/uCmInrErOFL5zLrArMEyy1oS2IU8JFc5GRmfWKHVGSaWra8Nz3UXipqyn444FUOaRlCCBagvCodgAs5Oe9MZIzX43Xy3r+gd/qhiRvRhUBfpAriFrpnK/2BCdns6SC9wRl8D7Q9XE/u69zyvW2efU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri3lec7L; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78edc49861aso33734185a.3;
        Sat, 13 Apr 2024 18:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713057327; x=1713662127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7eRVp2VH/Cs4kA/J+hb9FmUFgAGZZsiG5M5GE7Zk78=;
        b=Ri3lec7L/VWHYaaw0F3ODD144mYC+d83pEyUB+3+9TPKlBfdoFLtTq9ebSzIKaos/q
         ErBRT5sWFWs/9bWe9rBXBp0LJHYI7m7DNKiSzUVFOM2lvjDpW0HGeWwKypoMdnhIuXyK
         GGcqYIQvv0MQpyebTSyTl1IfA8/S6yPMHpebBnl9L9BZl1ShDwS7JTkLSHBrrOyDpYnc
         Jq2888Chgulil1luLaXUJ+/Bg6EJWvif1SXq1Yed5YZcPLo412xCXnpaSu/xMVVB4lkA
         pUgTuwU73a8YioW9JSAZCERm555VEP6fSVNyVxOsYjfOWirAvdk/Je/pfSr5Pcnt1iUo
         rv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713057327; x=1713662127;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H7eRVp2VH/Cs4kA/J+hb9FmUFgAGZZsiG5M5GE7Zk78=;
        b=X/uCKHKDZdPj3KskdAx+ovhwnt62mB4V3q7CN1T2ANrjfAn/ZkolyFRLy0LTjlkvv5
         Ka9t/lTuRgoOimnWPNdS+qHlEiWJnRgsp0yskq9IjZNW0pTUKceY+oClM6wt/FAWnZGL
         vbcpDIO4GeeWw3R/JJh4mnosKfPiSQWG7Tz1Wx3nItIr3g3EetIOt+IDlInerHYhs7dY
         z1pR9Jh+3c1PUBwSayDc3LoAv8GiKeOPVfcb8pEzcdjOVE7iiDEvA8i8hoM7vKgpjIaJ
         GBpZss0KVaiGY/45u/R/68mkY0h6EGK7T9/kKj4/AQMO2e9cYlDahBGgVQYUdcSJUYID
         Ew2A==
X-Forwarded-Encrypted: i=1; AJvYcCUkJ6Zah/OihU7eqXQYZewMCO4GXe9EP8eJEhwTAICxvNiqrIP6Az7cCblgY5RDzM/yA6ym2iXVNhtEPq4RsgptivDsHJ03NXfPMA6S3VtTVdGiCEztIhi//XrscAXjB3qOP/P1lKWqNHH9huKtdfhIi3Ei+1WyvRtGJFt8Q7UwW/A0oySP
X-Gm-Message-State: AOJu0YwndISRvRqJHca3ZRc8Z+ayPKRwxC/sG9D2UW+9uASgsuSoH8GT
	jWfZpfe0rbj32sOnMzGn8jL6Es046+PRLtRCIc0uAX9+urtcCNGhMM2SSw==
X-Google-Smtp-Source: AGHT+IE1JfuvkIDBn+zEpFSgIhDTAKBivJPsmSekKkewerjhH1CDvAUm1W/KfzRdutQD8L9SsU33VQ==
X-Received: by 2002:a0c:fbc4:0:b0:69b:57db:b6b4 with SMTP id n4-20020a0cfbc4000000b0069b57dbb6b4mr5760457qvp.21.1713057327476;
        Sat, 13 Apr 2024 18:15:27 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id y3-20020a0ceac3000000b0069b5ead3a9csm2289098qvp.119.2024.04.13.18.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 18:15:27 -0700 (PDT)
Date: Sat, 13 Apr 2024 21:15:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <661b2e2ef3396_3cb63829493@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240412155533.115507-2-richardbgobert@gmail.com>
References: <20240412155533.115507-1-richardbgobert@gmail.com>
 <20240412155533.115507-2-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v7 1/3] net: gro: add {inner_}network_offset to
 napi_gro_cb
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
> makes sure both are set correctly. In the common path there's only one
> write (skb_gro_reset_offset).
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  drivers/net/geneve.c           |  1 +
>  drivers/net/vxlan/vxlan_core.c |  1 +
>  include/net/gro.h              | 18 ++++++++++++++++--
>  net/8021q/vlan_core.c          |  2 ++
>  net/core/gro.c                 |  1 +
>  net/ethernet/eth.c             |  1 +
>  net/ipv4/af_inet.c             |  5 +----
>  net/ipv4/gre_offload.c         |  1 +
>  net/ipv6/ip6_offload.c         |  8 ++++----
>  9 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
> index d4520c3f7c09..ae596285d78c 100644
> --- a/net/ipv4/gre_offload.c
> +++ b/net/ipv4/gre_offload.c
> @@ -224,6 +224,7 @@ static struct sk_buff *gre_gro_receive(struct list_head *head,
>  	/* Adjusted NAPI_GRO_CB(skb)->csum after skb_gro_pull()*/
>  	skb_gro_postpull_rcsum(skb, greh, grehlen);
>  
> +	NAPI_GRO_CB(skb)->inner_network_offset = hlen;
>  	pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
>  	flush = 0;

Nice that this even works for ETH_P_TEB, as eth_gro_receive will
overwrite the offset written here.
  
  
>  	list_for_each_entry(p, head, list) {
>  		const struct ipv6hdr *iph2;
> @@ -327,6 +325,7 @@ static struct sk_buff *sit_ip6ip6_gro_receive(struct list_head *head,
>  	}
>  
>  	NAPI_GRO_CB(skb)->encap_mark = 1;
> +	NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);
>  
>  	return ipv6_gro_receive(head, skb);
>  }
> @@ -342,6 +341,7 @@ static struct sk_buff *ip4ip6_gro_receive(struct list_head *head,
>  	}
>  
>  	NAPI_GRO_CB(skb)->encap_mark = 1;
> +	NAPI_GRO_CB(skb)->inner_network_offset = skb_gro_offset(skb);

Do we still need encap_mark, or is it always set at the same time that
inner_network_offset becomes non-zero?


