Return-Path: <linux-kselftest+bounces-48429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC960CFFE38
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 21:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1570A300D669
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 20:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A473644D3;
	Wed,  7 Jan 2026 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9k8CT2B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A003624D8
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805520; cv=none; b=OYRyaJRqXx1E3ndEBPnUDeE/+IklJ4Fr22NkQIslEoc/Kl1Igi9retmR3EhOvZSRX7K3XwS7JZ7DaySZZgNf93ipfu2UuC4ICPNsfz2l32HV03g04HiDq2onXF1I/hiLJLCO1BzHloHI4ftrN954BkyxdqmfIubqZvJc1pit3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805520; c=relaxed/simple;
	bh=GZVPnIihlbssrlAxnEReq4xRAteXUX7SCOOZGsQW5EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTv50EUNSBK6b0ssmY2qwI7oFWg4MbZfdsHMYZkafJwvXD9Gm4qmGruBcu36zKA23SOzIhR4IRQx6M5zgMDtqiUA8gdMKPqDhwUN/aGxSZaLLaMP7vuGl65AMZHPFdqvcv6AxyH4Sl7Qg+GZYCdo4cz9zbYVSVzikK+flJCKJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9k8CT2B; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2627269d5so241790285a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 09:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767805517; x=1768410317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOc8XfG+0s04myYixo5Pf4CHGB1gH0OMOC9SxKCE8Xo=;
        b=B9k8CT2BOs46lSMT9jF+qAMoMzBY8WRc4BUjN65S+IwiGDxy7GLhk7yKpCCbP8fuUO
         ZoDEemxFxhsyQj2ERol15t6RwvT0Cbm0sddEgr1n+1lmaKajIDzZyq0kUO2glvNJ5d/k
         AYzq/TSWh80u82SKfiijeFHP+CFiPAGnVz4xHmJRfOaSl3B4DbpszZU6g5KBVzdxeNWf
         QOM7ZtfeRGMv6FZsvQsbYa7OD1wZ8G49jimFb5wCSQKvYovq8rgNCa1vTtHNQnta0ejt
         HnDILz/cIbUBepJwiVIWkwvnJi2ZJQSRyKl6giGN1c3sl2EPDbs+ZYmVJzRjmYBSWb9L
         bEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767805517; x=1768410317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOc8XfG+0s04myYixo5Pf4CHGB1gH0OMOC9SxKCE8Xo=;
        b=FR/GeViQ0nEL20GThZhe8kH46uSUaBOFEhnpmXOt02qzkHv7QNamnOzbIsp3zEO+hg
         zNA8hS59OkkSzUu3TdSj6JL0lgwp89TNE5zOzuBYSnkc3+0/bn3dTaJfp/KlRyDiHqb3
         ivIKzE53IXlaDP91vbPc/sdqjcffMaLKAYDrAgWY6hceXjI866dgw1J9fU9VrqoH61x/
         K99/CSrugxpRt77+c67GyFyiNaqgwyo5cIZ2pR2Erbg2/OPnfLpiK2VSpYsDQObi/5cx
         p9ntwzTeB0uekAZqvui9KVfjhHHhXFpr+YAYDtR3LMEPi65UoOM8CCxBA2DXZSnDcMNI
         zcgA==
X-Forwarded-Encrypted: i=1; AJvYcCUDnVj1+vXmioxaptAVuFpVWykHDC6BywZQTfx0AVxcRsVObmwmm2GRd4AFGHeB1M4pWdkF1VNjdyqHiq0TKuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVYEuxAtWWQtjSSqiVDujD5IREuBo5KshuHnFCAk2OHNgTRHu8
	EhHvRWQU1yDr//Wj6HqOJOH5OIj9tZcLivpg6BJ6hRQLExFGPhz//GzN
X-Gm-Gg: AY/fxX6mwut9fgdY4ysMNopoMl+wGpGWAHpPjHBMMilmV963lGi2Rn+1UOiakeunlWg
	D1uV+c52A058er8p1kmA3DTQOHZO9WEWT/oXDbtG9zGiKOyv4ADG6xvbL0kB1sG4hQJ8WrvhIZj
	x4eLpOkVjvjl5awy5C51YnSwwRjUCGtgEWDyDs44YZ0XQMXQOyX+IhpzGalgzDXSEa6H9Py3sYb
	pgB3NnVouFtbd9RKU+p6IbsejXY3MV7lch9HuD7ksQtf6tlsZoxqh7QhlesHGV4P5oHD+PCkZtc
	f/FC+d3/bmJSdwiI0fVuJeQ3LGb9ogYrMw1zRtrkyz6DqETM9RXJou5w9Zrx0k+yVf1FJ6DBVn2
	clOfmHS6tTbmlcdSyRlAshqpLDEAR87/t47ZspFrRoogUbHo6M/ivL7Fd5OFsPRfyXyoJTMe7G5
	wwmdNkrohf49T8NXs0
X-Google-Smtp-Source: AGHT+IHexZZHvIX4wJ9N9GsO9bANEN/avMjXKz+s9jn7FEl2rkDaHTwvV6tUPNS67dV+YcgpZH3t+Q==
X-Received: by 2002:a05:620a:7087:b0:8be:64e5:52b9 with SMTP id af79cd13be357-8c389408be6mr323212485a.57.1767805517246;
        Wed, 07 Jan 2026 09:05:17 -0800 (PST)
Received: from ?IPV6:2601:18f:901:12c::100d? ([2601:18f:901:12c::100d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51cdcesm405934685a.26.2026.01.07.09.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 09:05:16 -0800 (PST)
Message-ID: <099019ee-05f4-457b-a82b-0fac55d8dd48@gmail.com>
Date: Wed, 7 Jan 2026 12:05:15 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net-next v2] ipv6: use the right ifindex when replying
 to icmpv6 from localhost
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260107153841.5030-1-fmancera@suse.de>
Content-Language: en-US
From: Brian Haley <haleyb.dev@gmail.com>
In-Reply-To: <20260107153841.5030-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fernando,

On 1/7/26 10:38 AM, Fernando Fernandez Mancera wrote:
> When replying to a ICMPv6 echo request that comes from localhost address
> the right output ifindex is 1 (lo) and not rt6i_idev dev index. Use the
> skb device ifindex instead. This fixes pinging to a local address from
> localhost source address.
> 
> $ ping6 -I ::1 2001:1:1::2 -c 3
> PING 2001:1:1::2 (2001:1:1::2) from ::1 : 56 data bytes
> 64 bytes from 2001:1:1::2: icmp_seq=1 ttl=64 time=0.037 ms
> 64 bytes from 2001:1:1::2: icmp_seq=2 ttl=64 time=0.069 ms
> 64 bytes from 2001:1:1::2: icmp_seq=3 ttl=64 time=0.122 ms
> 
> 2001:1:1::2 ping statistics
> 3 packets transmitted, 3 received, 0% packet loss, time 2032ms
> rtt min/avg/max/mdev = 0.037/0.076/0.122/0.035 ms
> 
> Fixes: 1b70d792cf67 ("ipv6: Use rt6i_idev index for echo replies to a local address")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: no changes
> ---
>   net/ipv6/icmp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index 5d2f90babaa5..5de254043133 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -965,7 +965,9 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
>   	fl6.daddr = ipv6_hdr(skb)->saddr;
>   	if (saddr)
>   		fl6.saddr = *saddr;
> -	fl6.flowi6_oif = icmp6_iif(skb);
> +	fl6.flowi6_oif = ipv6_addr_type(&fl6.daddr) & IPV6_ADDR_LOOPBACK ?
> +			 skb->dev->ifindex :
> +			 icmp6_iif(skb);
>   	fl6.fl6_icmp_type = type;
>   	fl6.flowi6_mark = mark;
>   	fl6.flowi6_uid = sock_net_uid(net, NULL);

Using ipv6_addr_loopback(&fl6.daddr) might be more efficient as it does 
a direct comparison of the address.

-Brian

