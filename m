Return-Path: <linux-kselftest+bounces-21865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293A29C5990
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2332819CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942131FBF65;
	Tue, 12 Nov 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Aa2V97Gu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77C1FBCAF
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419550; cv=none; b=KwCejJGTnM7IPy5XlAftOtEJoUZDFpea6unH1Okv72YWMcJ1iCP8BV/l5zS838AeehactKueDz337dLBNP6/86nkHcnxdcU9GGFutaba4WiRpwC85yhIGO+mXFT70JCQXxjZ1/MEp4SW+rYjtjUJPEALgheOi4SYX7aUEND286k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419550; c=relaxed/simple;
	bh=7dL1Ei8s8LcEly9MeawI6sWofkKiP6SlNezkoxADASs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxX4ld+Ie/03w08XqJevPpxl3ZadYMHLPVAUSiOWQbiK/ZbkeJr24kt+d5OZW1uaL99tJJnyF7Qa08syqyxj2m0kfTwPiuZ2amVaUoHq6fSZuFHVZZgwrV8XHBL9l6VanmZ1yosQT1mORi67Ir7jbhTAmKcrI4V8qt/Kr50OmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Aa2V97Gu; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cec93719ccso7452393a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 05:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731419547; x=1732024347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=caVXeJrdHRZKvkmt5CrTO9g9Z2IsueyYvYdQUlvgtKU=;
        b=Aa2V97GucIBWlWXsuFjzV0ATr4ZQ5OXbH9a+UOjaadwKd3jIuyOFKbRErJo3oEREN1
         2dIN+HwMoJnb5Q2IXf9p+41v0OLYUrXIXZYnIgPaEnb7/tBmtIC5KwbzTjwNG6cT0EMW
         vXcUWz/2OaThv/1pt71i+WcNMsedjbJOu45cOqh/OOkIRnV2/JeKfBf0572muJuWHd40
         mNz5YInn8X4VdzcY8R8u1A4HgI2y84gPCNMEW5nsbs8i1FbkeFjAWSx4nkwRhmRQ7Ctt
         YH09L/OVy/EXD2QR0jG3vDkwH+K+hd92sX9wkVjT4EgN1TYGFEvnbewpFfc22Nr7Pjru
         hmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419547; x=1732024347;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caVXeJrdHRZKvkmt5CrTO9g9Z2IsueyYvYdQUlvgtKU=;
        b=r93Hj2j3IqCwtWrfSloIZE8RqYeyb2ReRzr0KLmkiXIhTuPWQVpYCrSCT7B0WOxq50
         oKR6BZXweeQID0RRqibWdqDpLLSKU8xKeKTnFCgyfjerRskOw41CiDEL4Oxnv5Io+kTv
         Nuc58h5tR/W2eb80MizheJRljo4MMwaHN0cRRWzIFlIwbaqXo+9m2ZClQApOE+nOPt+Y
         cCi/2jz2Q+x2SN060mlO7GDHVtjJPG3sIx4hkg9JTD2juP8Ac2w1PNPF84AfglxY1EQ+
         P3oFh5ve67MPNdlBoIrtCuGy04SMEoeU51DB3gT7G/dVJLSR6IpC2ko9MmwZ1G8PnRuC
         xWig==
X-Forwarded-Encrypted: i=1; AJvYcCXQkFI9g8S9nvHJsetnA1EDys8u0wLzK+r2t1tUgG3kaGx5vaOsxjNHQobQwRRvL/13HDlJ+b2qFqaeprHDHOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWKFAfB3BbtaFLYZyp3bpmo++cwijWKIOOTLvRTUrAQ3KXf7O
	nxYSqyZMQ35/xW9mu40LbuU29B0UtLi91PUNqCIkRsolO9bO4AErqGDW21tGIkU=
X-Google-Smtp-Source: AGHT+IFJkboknrQASMJfThfzI2bREfLg6hevUW0NS36sBjniM2EHuevaQMV/FcVYiCCY8jGNNaTksA==
X-Received: by 2002:a17:907:3e0a:b0:a99:403e:2578 with SMTP id a640c23a62f3a-aa1b1024ddfmr282939266b.5.1731419546739;
        Tue, 12 Nov 2024 05:52:26 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:e829:c484:5241:93b2? ([2001:67c:2fbc:1:e829:c484:5241:93b2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2d979sm732456866b.181.2024.11.12.05.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 05:52:26 -0800 (PST)
Message-ID: <0a5e0d83-2fd5-4281-8aea-7f5c80aee06b@openvpn.net>
Date: Tue, 12 Nov 2024 14:52:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 17/23] ovpn: add support for peer floating
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-17-de4698c73a25@openvpn.net> <Zyiu7d5X7GcTK3Hq@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zyiu7d5X7GcTK3Hq@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/11/2024 12:24, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:30 +0100, Antonio Quartulli wrote:
>> +static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
>> +				    const struct sockaddr_storage *ss,
>> +				    const u8 *local_ip)
>> +	__must_hold(&peer->lock)
>> +{
>> +	struct ovpn_bind *bind;
>> +	size_t ip_len;
>> +
>> +	/* create new ovpn_bind object */
>> +	bind = ovpn_bind_from_sockaddr(ss);
>> +	if (IS_ERR(bind))
>> +		return PTR_ERR(bind);
>> +
>> +	if (local_ip) {
>> +		if (ss->ss_family == AF_INET) {
>> +			ip_len = sizeof(struct in_addr);
>> +		} else if (ss->ss_family == AF_INET6) {
>> +			ip_len = sizeof(struct in6_addr);
>> +		} else {
>> +			netdev_dbg(peer->ovpn->dev, "%s: invalid family for remote endpoint\n",
>> +				   __func__);
> 
> ratelimited since that can be triggered from packet processing?

ACK

> 
> 
> [...]
>> +void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
> [...]
>> +
>> +	switch (family) {
>> +	case AF_INET:
>> +		sa = (struct sockaddr_in *)&ss;
>> +		sa->sin_family = AF_INET;
>> +		sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
>> +		sa->sin_port = udp_hdr(skb)->source;
>> +		salen = sizeof(*sa);
>> +		break;
>> +	case AF_INET6:
>> +		sa6 = (struct sockaddr_in6 *)&ss;
>> +		sa6->sin6_family = AF_INET6;
>> +		sa6->sin6_addr = ipv6_hdr(skb)->saddr;
>> +		sa6->sin6_port = udp_hdr(skb)->source;
>> +		sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
>> +							 skb->skb_iif);
>> +		salen = sizeof(*sa6);
>> +		break;
>> +	default:
>> +		goto unlock;
>> +	}
>> +
>> +	netdev_dbg(peer->ovpn->dev, "%s: peer %d floated to %pIScp", __func__,
> 
>                                                %u for peer->id?
> 
> and ratelimited too, probably.
> 
> (also in ovpn_peer_update_local_endpoint in the previous patch)

Technically we don't expect that frequent float/endpoint updates, but 
should they happen..better to be protected.

ACK

> 
>> +		   peer->id, &ss);
>> +	ovpn_peer_reset_sockaddr(peer, (struct sockaddr_storage *)&ss,
>> +				 local_ip);
> 
> skip the rehash if this fails? peer->bind will still be the old one so
> moving it to the new hash chain won't help (the lookup will fail).

Yeah, it makes sense.

Thanks a lot.
Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


