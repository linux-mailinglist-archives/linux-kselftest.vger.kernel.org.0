Return-Path: <linux-kselftest+bounces-22384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC059D44E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 01:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AFE1F219BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 00:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBFE2309B3;
	Thu, 21 Nov 2024 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8bXj084"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9023098E;
	Thu, 21 Nov 2024 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732148948; cv=none; b=aZwrkJgYsLmywYI5/dijys+nl8x9fmHKXEskqY3yfzRJlFdxsMZYtgv+/9B7bH5zNl4ctTynHNkwiJ6QJBzSAi6yC6Kre4BKizlZrwQec9TTnfvT28wnwVqo/5WOI6KphPo+9PpwvWPIGCDEpBhhFM7GbGKezzTyRFY0QPMoOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732148948; c=relaxed/simple;
	bh=ADwrhXPHxiG/lWbdGMI7aKDtnfo7BJH5nHp+YJOCkes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNUau9sqgzZj7VkksjMBD9qf3fNYuO/ti2nVUrtZztDqL9m0OyyH7JkO9wKz7MdRHyIN4/ZsdMhukP+NAZCOI0/rImUKNXUoor59YrEtFOeBZvOfCze6YGLAJdbvD8+5BYNCA02d8u1I4CPUVJAjXkAr9oOxD1o4dis22PBJymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8bXj084; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-381ee2e10dfso168092f8f.0;
        Wed, 20 Nov 2024 16:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732148945; x=1732753745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNFqJNwdtTIM52uDabF+RixwG4yWSl0dwHZ/Bz5L1s8=;
        b=l8bXj084l7s47amLmgoHrCjH9QRA1jbSInl6eUlxNarVb1z5TOpDKrRfIi/C97fRl9
         plIrtiq5VfUDTB9TMaujpNumE4U8G7M67fr2yhzenykps0HB+R/QCsOgoE1Jxiu8UITI
         COpZP20jmPn29Px0c4wB9tJbQuDjl30/p4o/olIyBhcoy65BdF92/1A9QRsk0TvbcU1P
         k/JLTAYGQ/tX0tB+FHTuQPt64Ym/C1Lot1zVsCHbwOejJqpVSMZCkHYCypEyxjMjr1o6
         4zpI/sW98rod8zhaJW1SbsVZNYs+SR7sNFfYaW0LyH9UcOjSxh/V8K5ixFtplWMmzZGL
         mraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732148945; x=1732753745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNFqJNwdtTIM52uDabF+RixwG4yWSl0dwHZ/Bz5L1s8=;
        b=St3gqnxLvT5xt5KOKYlkI6C+jCRr87wfl9qsnOwAJ3wp2RkJDCrqESAjgdoPTfo6tz
         7aHqTcNOEFBpvfqI3mrKO8TCRzUt8AHJ8LrFyBVLXAiacJsk+w0Ps5KA4+2r5jzdzBKt
         UuJZtSwCiD9ng55E7vzYAwUsUnSwJkbp+tzepmAWpHozKs685eWJTC+m6M59WLl9PZe8
         R2J4kZ8HTk9Z06xpU4+UL3BH42q15n8PgYPeWvFf8C5FBIpA33AyydEY/9vxn4YagsXL
         LucRP3KO+1tfY5TiOk3ywpVwTqSx7500VaYVHlLF7KdKVz1h6+92NjBZzalS7ZQf6Mex
         7hvg==
X-Forwarded-Encrypted: i=1; AJvYcCUQE10yCbgoGh6uRTexi6u482rLM6PKY8fTtTnDIGWgR/2/uZcXqBKyNWxFghm7XV54j11Z8JoK@vger.kernel.org, AJvYcCUwxZn8/iiQYniNm/it1k2zMPKzINKJuhve3SpaAiRjEoUX/p7RRN1LGsoJ61Xj8VgjSn5g03wEeGWccfD19TWN@vger.kernel.org, AJvYcCXPYJRXg8OwkEoStl0v52/c3krvHXRMwsyty7Xev5brhSL55qAepty5789cF30R4bI5z/4OHW1PZl0z6a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKvDkghOYSRQCcb0n4ArWBDa1M+xBC4+DQx+rMmuIWTVtgXeb
	Bp+HpwPw3YBGTYrrftLB5vrFFgn+0bZzme5HdTNQgDaWsGeeD5kN
X-Google-Smtp-Source: AGHT+IHwrxS7Q3wPuiO3CIM8LKgPUIos8L4eyZFj2A2FlBmlQwt9D7cuEebrGVqCQWqGXFrooaiQqQ==
X-Received: by 2002:a5d:6c63:0:b0:382:43ee:9f70 with SMTP id ffacd0b85a97d-38254ae44a7mr3730200f8f.22.1732148945289;
        Wed, 20 Nov 2024 16:29:05 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493ee59sm3343620f8f.103.2024.11.20.16.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 16:29:03 -0800 (PST)
Message-ID: <7d221595-bd57-4b8d-9c2a-007ad1e33ba1@gmail.com>
Date: Thu, 21 Nov 2024 02:29:37 +0200
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
 <4fe9f0d5-a8ac-4f2e-aee7-00cbeaf2f0aa@gmail.com>
 <387d3fc5-9ff6-4a8e-b766-5e30d0aef4a4@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <387d3fc5-9ff6-4a8e-b766-5e30d0aef4a4@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.11.2024 16:39, Antonio Quartulli wrote:
> On 11/11/2024 00:54, Sergey Ryazanov wrote:
>> Another one forgotten question, sorry about this. Please find the 
>> question inlined.
>>
>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>   /* Send user data to the network
>>>    */
>>>   netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
>>>   {
>>> +    struct ovpn_struct *ovpn = netdev_priv(dev);
>>> +    struct sk_buff *segments, *curr, *next;
>>> +    struct sk_buff_head skb_list;
>>> +    __be16 proto;
>>> +    int ret;
>>> +
>>> +    /* reset netfilter state */
>>> +    nf_reset_ct(skb);
>>> +
>>> +    /* verify IP header size in network packet */
>>> +    proto = ovpn_ip_check_protocol(skb);
>>> +    if (unlikely(!proto || skb->protocol != proto)) {
>>> +        net_err_ratelimited("%s: dropping malformed payload packet\n",
>>> +                    dev->name);
>>> +        dev_core_stats_tx_dropped_inc(ovpn->dev);
>>> +        goto drop;
>>> +    }
>>
>> The above check implies that kernel can feed a network device with 
>> skb-  >protocol value mismatches actual skb content. Can you share any 
>> example of such case?
>>
>> If you just want to be sure that the user packet is either IPv4 or 
>> IPv6 then it can be done like this and without error messages:
>>
>> /* Support only IPv4 or IPv6 traffic transporting */
>> if (unlikely(skb->protocol == ETH_P_IP || skb->protocol == ETH_P_IPV6))
>>      goto drop;
> 
> It look good, but I will still increase the drop counter, because 
> something entered the interface and we are trashing it.

Sure. I just shared a minimalistic example and don't mind if the case 
will be counted. Just a small hint, the counter can be moved to the 
'drop:' label below.


And sorry for misguiding, the '->protocol' field value has network 
endians, so constants should be wrapped in htons():

if (unlikely(skb->protocol == htons(ETH_P_IP) ||
              skb->protocol == htons(ETH_P_IPV6)))
     goto drop;

> Why not printing a message? The interface is not Ethernet based, so I 
> think we should not expect anything else other than v4 or v6, no?

Non-Ethernet encapsulation doesn't give any guaranty that packets will 
be IPv4/IPv6 only. There are 65k possible 'protocols' and this is an 
interface function, which technically can be called with any protocol type.

With this given, nobody wants to flood the log with messages for every 
MPLS/LLDP/etc packet. Especially with messages saying that the packet is 
malformed and giving no clue, why the packet was considered wrong.

--
Sergey

