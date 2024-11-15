Return-Path: <linux-kselftest+bounces-22101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B50F9CE16B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0AE281456
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872771D4358;
	Fri, 15 Nov 2024 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Eegd4ZWk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701CF1D4350
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681554; cv=none; b=g++0piyZZ2bZBCUVJfvla81FYXGWN1TgXpQ+C2X7p0/eTjsew3VfCtgfab4W5ZijRoeT3uRejrTLgco4ZGVzpn1pmrZmCqhAvrsNQ3TI5WEMMx7s+V67eNz5KhpM4EL+h7M6Ug9w8IIKVenTTHYW1/BryeJ1YHMaD5S9dE2sNik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681554; c=relaxed/simple;
	bh=4tlLltxo+Hj+0MDVTEjHpvj7Ka2vLnni5nupXYpEmNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RN79eZxKKjRwP4j5BfFvWXEZ5BdKSDwrlzHJ4yaqd1CoA7I78Emhb5w7yYQHgvu3R5o7rPi7Q3ALudOoJRDz8dqDb5C/ETePCSmAKqmiD6IrgkEs6mbo1EjStVsCEZmdHizBouQcQorVcWZNSINXo57a0K76JJ+0AMUgVnsQf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Eegd4ZWk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431481433bdso6271805e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 06:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731681551; x=1732286351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jFC7sT7ccqdUHp1cDL4XMUSFjZj93CegQi4p8wl3lxA=;
        b=Eegd4ZWksJGs7+btMgWSHnjZqw8+8MnfNZZNcLisS+OzjYTgeKzNZglSeLxL3EkMJN
         w2x929T7qK/lAt8h+zKhX2ZsUPdPkUOzOs0Xaf3tyounzZ3eA0t4CdDMWBFt3h2IMTx6
         /2xa3rbjj2J1nN9BuS2tqJl+XX0SSMZvh0L7KPWwFpvpzTtjftK2nEQqjx9pyzSIyljP
         a56fDEo/IwAQG5ntknQZ0vcn4d0nYC6SHw/XY7tlUGHfpaP/NcziVdRtQFqliBTFIyI+
         zvow4xX7G+dP49KgnOYRwS8+UNJ/+Hc3RDgUq4cnz4Hl/V4hQJrwrS4Dg5L3+ixmCz7C
         Dpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681551; x=1732286351;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFC7sT7ccqdUHp1cDL4XMUSFjZj93CegQi4p8wl3lxA=;
        b=Vsu6R1NflubWasx4Wf3ViSWK7jxMorYsjzQYLv3hgCDLyAGVtSCWKVmCxgDO53/dHF
         NFteKGuEeDe7orR1OU6ub0fWs7DzVkWZr/5rAffWJRYCFaIc+HVdl9jIqM7b0TgjGz3Q
         AzDjNmo5U8AI2gkc2CKrf37EZh14mSf5sDZGYFPaRwbQDUfwivrDqkjxswSRy6DQChqW
         rjqnRO+Pu0xxAYUz5TaDTtqvVL0RNDNrA9AeWJ8yf5qOHdL1oPcEFgqSxLxj1sWqAueH
         8eCeO/F2DTawf6+QQvKRcvWNjZd7TuGTk45365105oxTJK53XBQnGU8ZK84l9zsNLmOw
         Rwyg==
X-Forwarded-Encrypted: i=1; AJvYcCVfGYL7KnSaUbHC+ByT4YUVifIPLe6eP8MjEnMiT+ajbI55irsGyamz77uIJUUskpvPVL6MO++rj4rDBtdIGzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeb6fQPRdu0LLzG8OjRIUM+UYlxPnFMfRI6B7k36UDcHuiPfkl
	1mTZxXsbXiCeQ+mzI3mUAcGvZC4gXSmf7Rq9qt6l3gFtGMT1mhhZUWDOdXtSt9VDI1rnfg0wx73
	r
X-Google-Smtp-Source: AGHT+IHynH3QnvU6nVv7lZXeKUim6BKbTkTiRuQ7hpZ9Jr52HVBBSOHcVHcsmd9GfvobRtv2iCKJvw==
X-Received: by 2002:a05:600c:3584:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-432df725532mr23699705e9.11.1731681550884;
        Fri, 15 Nov 2024 06:39:10 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:59f4:10be:886a:27eb? ([2001:67c:2fbc:1:59f4:10be:886a:27eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da24459bsm60768935e9.6.2024.11.15.06.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 06:39:10 -0800 (PST)
Message-ID: <387d3fc5-9ff6-4a8e-b766-5e30d0aef4a4@openvpn.net>
Date: Fri, 15 Nov 2024 15:39:36 +0100
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
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <4fe9f0d5-a8ac-4f2e-aee7-00cbeaf2f0aa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2024 00:54, Sergey Ryazanov wrote:
> Another one forgotten question, sorry about this. Please find the 
> question inlined.
> 
> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>   /* Send user data to the network
>>    */
>>   netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
>>   {
>> +    struct ovpn_struct *ovpn = netdev_priv(dev);
>> +    struct sk_buff *segments, *curr, *next;
>> +    struct sk_buff_head skb_list;
>> +    __be16 proto;
>> +    int ret;
>> +
>> +    /* reset netfilter state */
>> +    nf_reset_ct(skb);
>> +
>> +    /* verify IP header size in network packet */
>> +    proto = ovpn_ip_check_protocol(skb);
>> +    if (unlikely(!proto || skb->protocol != proto)) {
>> +        net_err_ratelimited("%s: dropping malformed payload packet\n",
>> +                    dev->name);
>> +        dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +        goto drop;
>> +    }
> 
> The above check implies that kernel can feed a network device with skb- 
>  >protocol value mismatches actual skb content. Can you share any 
> example of such case?
> 
> If you just want to be sure that the user packet is either IPv4 or IPv6 
> then it can be done like this and without error messages:
> 
> /* Support only IPv4 or IPv6 traffic transporting */
> if (unlikely(skb->protocol == ETH_P_IP || skb->protocol == ETH_P_IPV6))
>      goto drop;

It look good, but I will still increase the drop counter, because 
something entered the interface and we are trashing it.

Why not printing a message? The interface is not Ethernet based, so I 
think we should not expect anything else other than v4 or v6, no?

Thanks.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


