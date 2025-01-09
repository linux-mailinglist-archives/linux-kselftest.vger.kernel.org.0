Return-Path: <linux-kselftest+bounces-24132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121CCA0788D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 15:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB661889BC0
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 14:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE3219A74;
	Thu,  9 Jan 2025 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW2Mhsu9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E7216E39;
	Thu,  9 Jan 2025 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431574; cv=none; b=ddUj1G3n4GvO51t0miYXpZsobarMMDaCZbArDipuNk8qNPg+cfa613bocvY2qzX43MhFbdmXaNVgFzyrlHqlxWdyglvB3ngklxxtybtra1akfPL1PE1Jwy0vWw7c+4GWh4270K8Pske8aSLg0/rcM7Ci/tR2rZ52/ihVZja0GG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431574; c=relaxed/simple;
	bh=5/nRrtGDhDuIG6R1/X/KmK0g0dRtyepfwy0EIHoopDE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hy8SGXBCi5xyVak0hUV82kC4ZfAzG1Z7ybYlXPzUs7yLDviHzOYG+x44vRF7QSiBppqKeHkAevQah1aaindKNZdWwk3tGUj4+BB3hI8rfhWYvgNpsHZ80mPXHCb/Czffvd+J8u5V1aUTaS1Jc2xyLM7c0aYirTI4uNbROz4pFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW2Mhsu9; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6f8524f23so92952685a.2;
        Thu, 09 Jan 2025 06:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736431572; x=1737036372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usIeIp/v3yeRjofXHQEYqOeb0gxg7kz9hdNbLvCou+k=;
        b=kW2Mhsu9grmC6phmNzeEzTC+EHpktT7J9beKEnwrf976gz/8nJLZs3VrExBEkB2i52
         WWG9g0V+UUaG3KsezeGBGckhksk2o1jG4WWXfVMyvSjvtelAqKTWaocnsScg2miiFS/A
         4y1j9RciZ3NphxrHS5qS7c+jNC/YEoj4wmybxE4/U6MEqGk8nBAbIKuUWYzvek7yrVkj
         Mjy5IAqYj6FzCZNqsOK8Gm0uYHp6BCUycjaxtM9/d3ix/NNL5fDt2QJQFScsyu4UYBHC
         I5Jsro3cQr/LDv7BvPSUIY6P+zycHfVfM/fdAQfUiCxLVaXDfv3aitA2fM5SeVG3g8Ql
         1x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736431572; x=1737036372;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usIeIp/v3yeRjofXHQEYqOeb0gxg7kz9hdNbLvCou+k=;
        b=U0DHF4pJi7aC9xTJGrUBullBYATFn/gWKd0NjAG00UznghyT2EnjLaueXvXlSHtJq6
         m6Z5a+HZuRBK8ujKMxLY7FX8Y767iMmuYYPfLOEGy2RQQxRXxFfBhAY3wQy8pgpIlXCS
         IaZu3FRj1K2tkjeL31UEAb+9i+9VcV0FPTHWmSGaKrdZdmz/AbPmVNK07WDV3QMEINQl
         3Tibg5YFBlWnQ0+cQPeAqA2A97J0AE34U3vkcopLNywuAVRcu9JGjbqjpMC1eWkvQONC
         paxlb7j3kg5GF1gByumr373IxLuvjop6Zl5ZAGr8DjjwiD4voHX+Ny3oOoGtSsVfJtWv
         xaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIB1Iy+2tDihSsPSKqNXoEsduNEDzjVuFdKF1bJB6Cg33aawMLEH4T7IXgN5MGMz7FOeQ1bF4e+KbunoDJMPgc@vger.kernel.org, AJvYcCV1yOj+qLfL65J7LeGIm5lIJdxWdSaUe3v9PG21TNrmrbHg+GX7t+iFZe73ozo+Z7AxRjND7rIqbzum@vger.kernel.org, AJvYcCVFWZM59Kr4UzLmNcZPz1+IviOvJPsFjCy8ql8cHiVFY/FUOzfKacjfrr3KgPr4+BXwcDo=@vger.kernel.org, AJvYcCWBLkvZg4GoE667clSyK8p5XiyOWCPo1Y16ob8l0w4YPpnRU3hyyKfp319nwWBEk0f1YfiuGgO0BoOya+CH@vger.kernel.org, AJvYcCXH/w47YEolfGa8q238NbQTxXYLydq5VX1OoY61zW4OpAo9QAN5Ydp2wYDdEBKxbVKS4AwrDp7o@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBMh/FGJCx2WVg8SdI3wPUNbEZro9IbSX9hP29XKRdNH01sHT
	in/xlcDnqyLa5fnUNnNXKiNWWxR0gqoZ3hHkgcD3Xhw/i65XyW+k
X-Gm-Gg: ASbGnctTuKAvVk9MKK6sHuZKBhoRKyQW4Lfh2ejZKU91QbPkcasctuhkVm/YRO9JgTR
	llZ5QGUoKlT8kbBNcI5Hf08Sy0q6IOCCzeY49XN4edm+KznXBKnAePZTC6tCL4k0PIXqSCxeo4f
	iR40GUm7rUsAs68G8GdkoaZATzmLzoqqgC7hZv6OVqCjD1CeiulDt9M3H1gRLdNzZFTd9eqLO7y
	Zupdws2+zgovTUW2kCGYF/kSKccQ4EqnK1+yMI3R0Das+kKTte4ByGw5XeZhC+jUupoHiJoC+rW
	9pORtZEDR8ETsv8HjbtmDOd/cFmF
X-Google-Smtp-Source: AGHT+IH2/BuDKPaZFtSdB6sACr2yO5Ou7ULQHhJjCfbu2HLVS1xlSoeEvSTuiJj7XPE+QAB5X5egxg==
X-Received: by 2002:a05:620a:1791:b0:7b6:cbc6:c87c with SMTP id af79cd13be357-7bcd975592dmr1065034085a.30.1736431571555;
        Thu, 09 Jan 2025 06:06:11 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3502abbsm69198985a.82.2025.01.09.06.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:06:10 -0800 (PST)
Date: Thu, 09 Jan 2025 09:06:10 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <677fd7d26e090_362bc129432@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250109-tun-v2-1-388d7d5a287a@daynix.com>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-1-388d7d5a287a@daynix.com>
Subject: Re: [PATCH v2 1/3] tun: Unify vnet implementation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> Both tun and tap exposes the same set of virtio-net-related features.
> Unify their implementations to ease future changes.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  MAINTAINERS            |   1 +
>  drivers/net/Kconfig    |   5 ++
>  drivers/net/Makefile   |   1 +
>  drivers/net/tap.c      | 172 ++++++----------------------------------
>  drivers/net/tun.c      | 208 ++++++++-----------------------------------------
>  drivers/net/tun_vnet.c | 186 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/tun_vnet.h |  24 ++++++
>  7 files changed, 273 insertions(+), 324 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 910305c11e8a..1be8a452d11f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23903,6 +23903,7 @@ F:	Documentation/networking/tuntap.rst
>  F:	arch/um/os-Linux/drivers/
>  F:	drivers/net/tap.c
>  F:	drivers/net/tun.c
> +F:	drivers/net/tun_vnet.h
>  
>  TURBOCHANNEL SUBSYSTEM
>  M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 1fd5acdc73c6..255c8f9f1d7c 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -395,6 +395,7 @@ config TUN
>  	tristate "Universal TUN/TAP device driver support"
>  	depends on INET
>  	select CRC32
> +	select TUN_VNET

No need for this new Kconfig

>  static struct proto tap_proto = {
>  	.name = "tap",
> @@ -641,10 +576,10 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	struct sk_buff *skb;
>  	struct tap_dev *tap;
>  	unsigned long total_len = iov_iter_count(from);
> -	unsigned long len = total_len;
> +	unsigned long len;
>  	int err;
>  	struct virtio_net_hdr vnet_hdr = { 0 };
> -	int vnet_hdr_len = 0;
> +	int hdr_len;
>  	int copylen = 0;
>  	int depth;
>  	bool zerocopy = false;
> @@ -652,38 +587,20 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	enum skb_drop_reason drop_reason;
>  
>  	if (q->flags & IFF_VNET_HDR) {
> -		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
> -
> -		err = -EINVAL;
> -		if (len < vnet_hdr_len)
> -			goto err;
> -		len -= vnet_hdr_len;
> -
> -		err = -EFAULT;
> -		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
> -			goto err;
> -		iov_iter_advance(from, vnet_hdr_len - sizeof(vnet_hdr));
> -		if ((vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> -		     tap16_to_cpu(q, vnet_hdr.csum_start) +
> -		     tap16_to_cpu(q, vnet_hdr.csum_offset) + 2 >
> -			     tap16_to_cpu(q, vnet_hdr.hdr_len))
> -			vnet_hdr.hdr_len = cpu_to_tap16(q,
> -				 tap16_to_cpu(q, vnet_hdr.csum_start) +
> -				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
> -		err = -EINVAL;
> -		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
> +		hdr_len = tun_vnet_hdr_get(READ_ONCE(q->vnet_hdr_sz), q->flags, from, &vnet_hdr);
> +		if (hdr_len < 0) {
> +			err = hdr_len;
>  			goto err;
> +		}
> +	} else {
> +		hdr_len = 0;
>  	}
>  
> -	err = -EINVAL;
> -	if (unlikely(len < ETH_HLEN))
> -		goto err;
> -

Is this check removal intentional?

> +	len = iov_iter_count(from);
>  	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
>  		struct iov_iter i;
>  
> -		copylen = vnet_hdr.hdr_len ?
> -			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
> +		copylen = hdr_len ? hdr_len : GOODCOPY_LEN;
>  		if (copylen > good_linear)
>  			copylen = good_linear;
>  		else if (copylen < ETH_HLEN)
> @@ -697,7 +614,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  
>  	if (!zerocopy) {
>  		copylen = len;
> -		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
> +		linear = hdr_len;
>  		if (linear > good_linear)
>  			linear = good_linear;
>  		else if (linear < ETH_HLEN)
> @@ -732,9 +649,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	}
>  	skb->dev = tap->dev;
>  
> -	if (vnet_hdr_len) {
> -		err = virtio_net_hdr_to_skb(skb, &vnet_hdr,
> -					    tap_is_little_endian(q));
> +	if (q->flags & IFF_VNET_HDR) {
> +		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
>  		if (err) {
>  			rcu_read_unlock();
>  			drop_reason = SKB_DROP_REASON_DEV_HDR;
> @@ -797,23 +713,17 @@ static ssize_t tap_put_user(struct tap_queue *q,
>  	int total;
>  
>  	if (q->flags & IFF_VNET_HDR) {
> -		int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
>  		struct virtio_net_hdr vnet_hdr;
>  
>  		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
> -		if (iov_iter_count(iter) < vnet_hdr_len)
> -			return -EINVAL;
> -
> -		if (virtio_net_hdr_from_skb(skb, &vnet_hdr,
> -					    tap_is_little_endian(q), true,
> -					    vlan_hlen))
> -			BUG();
>  
> -		if (copy_to_iter(&vnet_hdr, sizeof(vnet_hdr), iter) !=
> -		    sizeof(vnet_hdr))
> -			return -EFAULT;
> +		ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
> +		if (ret < 0)
> +			goto done;
>  
> -		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
> +		ret = tun_vnet_hdr_put(vnet_hdr_len, iter, &vnet_hdr);
> +		if (ret < 0)
> +			goto done;

Please split this patch in to a series of smaller patches.

If feasible:

1. one that move the head of tun.c into tun_vnet.[hc].
2. then one that uses that also in tap.c.
3. then a separate patch for the ioctl changes.
4. then introduce tun_vnet_hdr_from_skb, tun_vnet_hdr_put
and friends in (a) follow-up patch(es).

This is subtle code. Please report what tests you ran to ensure
that it does not introduce behavioral changes / regressions.

