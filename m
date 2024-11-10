Return-Path: <linux-kselftest+bounces-21751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279759C354F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 00:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B211B20AB8
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 23:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF191537C3;
	Sun, 10 Nov 2024 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL/7LJI/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BC1369AA;
	Sun, 10 Nov 2024 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731282865; cv=none; b=NH3KQjxPe4h5nqkJDF5GUCdLPNxJxXzzgK5MUlXnFiKGoN5YdI0HHs4vCSwg3D9/2Oi2/VZH5dOk7UNPK73+YVTcwlYfJu2wm6FgWRVddP/qaDqWQSP0GRJIai0qOrSd/PSaUZA+9M4xuNFJp1H8OPkmsCMGLsQuBxkdfCIy+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731282865; c=relaxed/simple;
	bh=19yDs/31GYUWDhn4lID+6CLSRhUWyT2LRtZkzFlK2Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KU5eyp9zTI63qg3+Fb2rBdpxuG+PL5t8Xz2s1iM+oFHwJAhyhfx5yPncevLkkT1awpaFTRUcfcrFYYwERkhai0caR9YU1WXzdsSWaps8nrlO1bOJ2pTZJcuShfGDtfKH3B8164mHQX8kMKe1jt72a0xFvxn470Hwrvj1Tkt/57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL/7LJI/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso50779585e9.0;
        Sun, 10 Nov 2024 15:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731282862; x=1731887662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lZUhLcHVpSjAQwpeA2pvIOp+QE5t1wmk05QqmJ3vbE=;
        b=fL/7LJI/I8XtBfO0RS9WqZAeCmAeHphPwOsY7O6V4NJoG2gcvGf2UjovtW5cV6KBNT
         8rsRV/lwgloCPxgwyNIuM9+O0C3w9QvPaUKGDyJdwpfIg36AGfB3UlLUkSIGLARFbQUl
         TzZl2zZDgYe7+NPeaTgY7j8BGThK1sYJa2fo13vBhPZ24Gn64UHbE2rThrv5tjJ7A7Yf
         8HyDSamZWp1CQg7if6nqANgKAzcu3G0zvSfWlB/t3y9m52NzL4h+sIqSjJBHvsHH7yM7
         RtW41wd6Y4nwPFZt452vgnTTUx9B8MbaRNYLMTS43bmiwYP8i2KkyfRFmCI1v2Ve1tdC
         6zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731282862; x=1731887662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lZUhLcHVpSjAQwpeA2pvIOp+QE5t1wmk05QqmJ3vbE=;
        b=lA2tUD1dWQaZt0GOoJxwkbcUnj4CyUYuHiZfgl/bk2+8JtM8z4r2K0zY1PDHUAyv/J
         I69ixtkhWMKrM0wClKgOFdffT4m/LPASZwvIe+Fjs2buk/IjuPansHRde2jHOxidEYIE
         w57VMCZctqavg7EKdSeJKRVYzWWfoEfnK2e16ETmWGinEjEikwobPyR2Nk1wbH15DbD1
         4odnHFXONWfzTaT4hlIkQUfZ9VSbXGnWV6Gvu9C9lDLHpMRJafEgEpWYMaqzW5CfsLik
         nkTXl3ZHvX+BXT794o8MJwb3sgaT8qhr3Q0Kcnt1hcHxhu08aQOzfsyJ/rqjYPSNcc45
         yH3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7wp1I34IRVBdYWA950vs+fVuxy31BGrpsFs9FxY75EPGoVVU94S1V7tZ0SIBMXJi2zSc3Uv62bpzxLJ8=@vger.kernel.org, AJvYcCXV6w8kyHJJo/12rb6/q4n8KMFu/wW6N2GNKx8dX0ZZNUEEeSOU9XRjrAxcCRGeV1Sfn4k7gEpIH9JXMxPXydpW@vger.kernel.org, AJvYcCXkCjYfhd3iEviJng22keenPglJlgKSrpMogVTrGp5wNyn6+2F1w1By4Pno4JafiCJ2FYnCWYBs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+okb5aqluA8qPYZbwTQLw+A303wHsx2Twz3RABcMQS1CwUW2E
	6XzjJmXaiLb7QGNxy4kdj8J3Itp2IG8nqbc2h0StXUfJy5gGU7bb
X-Google-Smtp-Source: AGHT+IGarWm8oToH3Rwe7AOH7Eh8fDG0bJj/ggB6PhSH/OoGCYJndvQOHrePSmx8gG9gP5Fkr85hRQ==
X-Received: by 2002:a05:600c:34c8:b0:431:604d:b22 with SMTP id 5b1f17b1804b1-432b750acc4mr114467695e9.16.1731282861508;
        Sun, 10 Nov 2024 15:54:21 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c1298sm191399085e9.24.2024.11.10.15.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 15:54:21 -0800 (PST)
Message-ID: <4fe9f0d5-a8ac-4f2e-aee7-00cbeaf2f0aa@gmail.com>
Date: Mon, 11 Nov 2024 01:54:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 08/23] ovpn: implement basic TX path (UDP)
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Another one forgotten question, sorry about this. Please find the 
question inlined.

On 29.10.2024 12:47, Antonio Quartulli wrote:
>   /* Send user data to the network
>    */
>   netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
> +	struct ovpn_struct *ovpn = netdev_priv(dev);
> +	struct sk_buff *segments, *curr, *next;
> +	struct sk_buff_head skb_list;
> +	__be16 proto;
> +	int ret;
> +
> +	/* reset netfilter state */
> +	nf_reset_ct(skb);
> +
> +	/* verify IP header size in network packet */
> +	proto = ovpn_ip_check_protocol(skb);
> +	if (unlikely(!proto || skb->protocol != proto)) {
> +		net_err_ratelimited("%s: dropping malformed payload packet\n",
> +				    dev->name);
> +		dev_core_stats_tx_dropped_inc(ovpn->dev);
> +		goto drop;
> +	}

The above check implies that kernel can feed a network device with 
skb->protocol value mismatches actual skb content. Can you share any 
example of such case?

If you just want to be sure that the user packet is either IPv4 or IPv6 
then it can be done like this and without error messages:

/* Support only IPv4 or IPv6 traffic transporting */
if (unlikely(skb->protocol == ETH_P_IP || skb->protocol == ETH_P_IPV6))
     goto drop;

> +
> +	if (skb_is_gso(skb)) {
> +		segments = skb_gso_segment(skb, 0);
> +		if (IS_ERR(segments)) {
> +			ret = PTR_ERR(segments);
> +			net_err_ratelimited("%s: cannot segment packet: %d\n",
> +					    dev->name, ret);
> +			dev_core_stats_tx_dropped_inc(ovpn->dev);
> +			goto drop;
> +		}
> +
> +		consume_skb(skb);
> +		skb = segments;
> +	}
> +
> +	/* from this moment on, "skb" might be a list */
> +
> +	__skb_queue_head_init(&skb_list);
> +	skb_list_walk_safe(skb, curr, next) {
> +		skb_mark_not_on_list(curr);
> +
> +		curr = skb_share_check(curr, GFP_ATOMIC);
> +		if (unlikely(!curr)) {
> +			net_err_ratelimited("%s: skb_share_check failed\n",
> +					    dev->name);
> +			dev_core_stats_tx_dropped_inc(ovpn->dev);
> +			continue;
> +		}
> +
> +		__skb_queue_tail(&skb_list, curr);
> +	}
> +	skb_list.prev->next = NULL;
> +
> +	ovpn_send(ovpn, skb_list.next, NULL);
> +
> +	return NETDEV_TX_OK;
> +
> +drop:
>   	skb_tx_error(skb);
> -	kfree_skb(skb);
> +	kfree_skb_list(skb);
>   	return NET_XMIT_DROP;
>   }

--
Sergey

