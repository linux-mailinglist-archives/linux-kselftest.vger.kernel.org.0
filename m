Return-Path: <linux-kselftest+bounces-22423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F039D54D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 22:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BFC6B20ECA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 21:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A480F1D9A6F;
	Thu, 21 Nov 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="b/Y4CJwd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C11CB9EB
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225170; cv=none; b=J1HRHH0COCpbPOSh+Kv2VkM3lCYeRsFWvbaB6f/bHcU06eUtDdyIsLqt+SbhUMcOujRJGACvampOTX/TUM4UxaA/zog9uBr23e8v5zROlO8fao17Y9RjI/TWVWY2so0AN8q4sE6F5P9WxhDqjFB0/16X2PlNSpmu9Fcg8PXNLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225170; c=relaxed/simple;
	bh=6O4/oSn2BUc82HocclQZjAVjC1XlfqUd6oiVCfxd5P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VE8vYMwBXnuOhYW1BCwLqw7IP4VS1ETbIUeIK8b+fD7eyaPKGPqXrmuUaFl19bZrGAWZryJQZUQCtGOkvjDas9vvcC6SuhAikLa+Nj2lL67XD/50fg4yJluhzrOZcc8fBALPJzcL3IpxofnA0hDR1nC2hC8bxP/WzWO0I8qrUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=b/Y4CJwd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso251572666b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 13:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732225166; x=1732829966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TTWHyH0/pd4NGuN+mYmXD7mccA5WSLeaf5E+h3Fti+0=;
        b=b/Y4CJwdOM5YGdnixCQGceICMqf1kKtyT7GN2uJMJGqg4VlgpAMF45Bcr0a6yQWnma
         dVYgXwXrjSCVo6JxIpiFB6mfj279NTddLPw3FMpdPxeuydm+VLP7gGRG/Ew2mpFCu5rt
         sSGJt0RYzEUgnigCXK5KCO9/s1rTqs/hx2OjmHXhAo2YDWsWE2gwrWSO29JTJMynI95W
         4mh1hzxGJhPZ+hYp3/X6zBK6M/haUMV7TaGwtwvmqywgVLwJ/0Y5+V2/oRuQlz+hG8uU
         Y37OHtGo3a0YBAIwE72sFdN57//uOYkORHYRCm1x2GoENDRbQcC+3x0U5qGojQ0hYSRM
         aIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732225166; x=1732829966;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTWHyH0/pd4NGuN+mYmXD7mccA5WSLeaf5E+h3Fti+0=;
        b=lOpAS7wjoWovFepgS/QgdKgg9Z4jf6tiosPAFI/mAHAwwp78IdV5GPyQHLhrl2S6Eo
         SsqOa4VEtHopkudn92j29tJq0gj8dRl45IkpHdT0lelrdHkAGjnjBjhnmwIembQngriW
         3sxXR+5wk6U71ZfQOgRbJSylrQphn6sHFeqfrbnn1QhL9aYxHqRBy//0+N4rhaGHWmg6
         cyh/greLGyoxUA9E6ndAYjqrwcvf2GSkd3bQLAAnJQ0n/VgsdOsLZj1UgjZAIY7Px1+U
         6mbuQ6eGHrPTYLJQcYfDbJx8QvrTmYgWfGQIvqvNtASR1N1+rppPrT9aSWXKDm4FSa6D
         UHJg==
X-Forwarded-Encrypted: i=1; AJvYcCWqD2hEqXQHBQqpj0SlPEEBln/jOAehvpU2X+kwEUEOaZzvn2ax+6l05My6P2KA3RktssiZXDhDlbFJCmtN6VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRK9TQG3xs6VlGHUq1EhMCBXJYVRKkTpkCo5lADtzatYgHDw3
	CuGF07hT2dV70YJiz/VEU0Mf++Ndi+A1RHXnOvSYvj5U/bOQwjPY/Sg8dXu5DNk=
X-Gm-Gg: ASbGncsgUUG/iJFqNoFQQXcUWKXTMrqB7y+xEeAu0rT+nvHiaTg2hxqqbeTbxxMx5NR
	xCf9jZ98Hrqg+N4zCw8cJe3UaPSrlg0bGH3s4uBsZUvFdRtFx+96yhTo1X7NQceoQ5dOk+uVoi4
	NaCxxWL8AGceRhHk6Cf/s53H4rIHslhS1fwkDKlcH+lr2nOtsP05d5vdsmgP0jPkYFpJ4XHWYt2
	/TIh5VQgdGHsqCaii1DRQfOZV3EqhmPugQwOBaFw4uDJLkxCy191nybxvzbKJlJYe1rVwXGdSj1
	O2/mvTQ2Dg==
X-Google-Smtp-Source: AGHT+IFt5e/WxtJQsJ1nDQuKfsyN25g9aKQVzA/tscnYlEDUeizxR85YU+6sdhgyib1KDjt00pA5UQ==
X-Received: by 2002:a17:907:7756:b0:aa4:9b6a:bd77 with SMTP id a640c23a62f3a-aa5099a2a8dmr59376166b.17.1732225165811;
        Thu, 21 Nov 2024 13:39:25 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f55:fe70:5486:7392? ([2001:67c:2fbc:1:f55:fe70:5486:7392])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f5fdesm16640266b.72.2024.11.21.13.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 13:39:25 -0800 (PST)
Message-ID: <e767dc62-85bc-4e80-aed9-b2957cd37c78@openvpn.net>
Date: Thu, 21 Nov 2024 22:39:54 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 08/23] ovpn: implement basic TX path (UDP)
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net>
 <4fe9f0d5-a8ac-4f2e-aee7-00cbeaf2f0aa@gmail.com>
 <387d3fc5-9ff6-4a8e-b766-5e30d0aef4a4@openvpn.net>
 <7d221595-bd57-4b8d-9c2a-007ad1e33ba1@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <7d221595-bd57-4b8d-9c2a-007ad1e33ba1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/11/2024 01:29, Sergey Ryazanov wrote:
> On 15.11.2024 16:39, Antonio Quartulli wrote:
>> On 11/11/2024 00:54, Sergey Ryazanov wrote:
>>> Another one forgotten question, sorry about this. Please find the 
>>> question inlined.
>>>
>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>>   /* Send user data to the network
>>>>    */
>>>>   netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device 
>>>> *dev)
>>>>   {
>>>> +    struct ovpn_struct *ovpn = netdev_priv(dev);
>>>> +    struct sk_buff *segments, *curr, *next;
>>>> +    struct sk_buff_head skb_list;
>>>> +    __be16 proto;
>>>> +    int ret;
>>>> +
>>>> +    /* reset netfilter state */
>>>> +    nf_reset_ct(skb);
>>>> +
>>>> +    /* verify IP header size in network packet */
>>>> +    proto = ovpn_ip_check_protocol(skb);
>>>> +    if (unlikely(!proto || skb->protocol != proto)) {
>>>> +        net_err_ratelimited("%s: dropping malformed payload packet\n",
>>>> +                    dev->name);
>>>> +        dev_core_stats_tx_dropped_inc(ovpn->dev);
>>>> +        goto drop;
>>>> +    }
>>>
>>> The above check implies that kernel can feed a network device with 
>>> skb-  >protocol value mismatches actual skb content. Can you share 
>>> any example of such case?
>>>
>>> If you just want to be sure that the user packet is either IPv4 or 
>>> IPv6 then it can be done like this and without error messages:
>>>
>>> /* Support only IPv4 or IPv6 traffic transporting */
>>> if (unlikely(skb->protocol == ETH_P_IP || skb->protocol == ETH_P_IPV6))
>>>      goto drop;
>>
>> It look good, but I will still increase the drop counter, because 
>> something entered the interface and we are trashing it.
> 
> Sure. I just shared a minimalistic example and don't mind if the case 
> will be counted. Just a small hint, the counter can be moved to the 
> 'drop:' label below.

ok, will double check. thanks

> 
> 
> And sorry for misguiding, the '->protocol' field value has network 
> endians, so constants should be wrapped in htons():
> 
> if (unlikely(skb->protocol == htons(ETH_P_IP) ||
>               skb->protocol == htons(ETH_P_IPV6)))

yap yap, already considered. thanks for pointing it out though.

>      goto drop;
> 
>> Why not printing a message? The interface is not Ethernet based, so I 
>> think we should not expect anything else other than v4 or v6, no?
> 
> Non-Ethernet encapsulation doesn't give any guaranty that packets will 
> be IPv4/IPv6 only. There are 65k possible 'protocols' and this is an 
> interface function, which technically can be called with any protocol type.
> 
> With this given, nobody wants to flood the log with messages for every 
> MPLS/LLDP/etc packet. Especially with messages saying that the packet is 
> malformed and giving no clue, why the packet was considered wrong.

Ok, I see. I am dropping the message then.

Regards,

> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.


