Return-Path: <linux-kselftest+bounces-28262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F099A4F32B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 02:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A712D3A6FBB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 01:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E15FDA7;
	Wed,  5 Mar 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="AjnalfrL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EC317579
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136428; cv=none; b=SCQFIZ8/M49dO6sn080ylGIWsjzsfXhXWF/+k7Z9fV7ddFNsY5hbUVsDswB06xtL3sVY+UTB7VPS4bwWrnTBgNOWwLVRZNnNXLBfjXxGcqOlYiQtsfhrPXYI7A+6/N3sYd1BHVMvcZ7m1ccC8Q2FQQ/XAwW6qLETdNtdf1PAgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136428; c=relaxed/simple;
	bh=FRqmXYpYVBt8WeZOTp6ZTdH2x+Rqo3KDqIOZpuj4mN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gI8eodQ1hDuoXBfzMp9KrluNnq9V9g7Y+amXTX5kd3phbKSrmDO5nrothyif4VcpQY9kSdOvYO5NLiiemUWvKbCEha2RmKeb9GY+hSwGE+9YwLqXnVdDM0knLflzgeaKDbn6lORvTyaVf45Vt9DI7yKNTRJPTw6lkJ4yyILuElk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=AjnalfrL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso10249758a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 17:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741136424; x=1741741224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=chlUX2BPGTU5TeZ1kFFp37lGXktq1FgiG+bxYUO8kTk=;
        b=AjnalfrLCIreR9PBMDyUPDsCkViRaWgsDAoL+b4DrtIlMlzstx+58eTkM7sEbHA48h
         nsQ7PezbNoI92/AqBg8Ptp2uk0ryrLcNvF4RT61p//vIpHJHc6M77jgHZfoRHTCfKRC5
         HupfNj9Vrr84qsV1F+kvPYXcJSw6C7gPk/zwGODA2ECmQ2f6+yEv3oo3wLtaYhhcf51K
         Ol/VN5PEvPmHHegyynZkUrSLEFB7NpfwgXXv9Q7POgWjbabkTzlwd8UxtT3ncIW1kuyp
         L8WZtL4+86rOZuQXVXXjCL+PAUPf/Hw+ghzrgC9GmXvvoak1iQ/53Z+X0TBGESixVdqA
         KwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741136424; x=1741741224;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chlUX2BPGTU5TeZ1kFFp37lGXktq1FgiG+bxYUO8kTk=;
        b=c56XmGu1OeuM/WYKH8xQb12Qku7+N7lgiYbYRc8YT/c4AEFGRAkFP07hJ3oXM0zyZx
         +173GyfEuHu2OD2qmo46uILFTKltArtsUvs99mip18FblcxJi8ZH7oUIt+ZEEU28D1mQ
         tlRh5b85STgtWkJA51ei7mN9TctAs0R5/lMgQy86CP49XRR23N1Zv4j1vGrk/E6lrN0Y
         2k7Y31eO52ZCuNTkVmbwNMFvASzT7MY3h08WoDAbMRB/+DvOkSqxxrdz2lhpwI91lFXv
         AF2kfM8inl6rq/Q2u+7X1cxaEMGsqYkO7CX9Tst40DChhB9VZeySs8Je7nBduAN6qMbV
         0pVw==
X-Forwarded-Encrypted: i=1; AJvYcCW8usGk/iTwGmgmhKJ+IuthJyu//87BjI3yi/bvAIjs/28BgFwHpwMjOMMCuxqsj1tFRDqYfVAaNRppyDtlJxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNvzLUKlRVO1BvgY9PLG25dw7Z+uPo7hvPke8pOKqzYI/JnNmO
	n5j1wJSY0RC3TpKtaNUewlAj2ypudu0E5Ai1E63fU/p+GENg1VtGOvo4WYAYE6g=
X-Gm-Gg: ASbGncsv72tVW0l4/iHLiLEhcJY72rf8kCevkde6vjUILWnUrgHQvJ74Kh2YTaXeUd9
	bRCTUFbZjiAwqhvJC6/JeSIt9Ku0kVR6zOUPZ3ssFZDI0dPHND08uOpywsFlQc61MaY4OXR98sT
	2lsbnWXJXMkdvOlX4nR0HKKNjmHUUUSomRlgHt+5TDu/K4vkkmA36dd3d4LCp2YdEk6B32MV3mT
	4HW8zNKLmQ8OHTr21wPciCjPWr968IQPU3sfoAxKHXlZR1brz976iAvFG/I2sUIPHXUnrX1CTaB
	ExF2/dvJuqOsqFRNcEgba2Bfo5H6dxeQIToGaZqgaG6SgLFuKey0yafxPeGAgBlP8HHVjabCGSp
	oOKXw55g=
X-Google-Smtp-Source: AGHT+IGwWVFOLcxV0LkUngHq3HFjXHad4jOYWm8uX/RmfUfR8dI9IG0CksFEVnyNPrbp4SNz8LPd6Q==
X-Received: by 2002:a17:907:94d1:b0:ac1:def4:ce20 with SMTP id a640c23a62f3a-ac20d8bc96fmr114851166b.18.1741136423329;
        Tue, 04 Mar 2025 17:00:23 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:2107:3d4f:958a:fa5f? ([2001:67c:2fbc:1:2107:3d4f:958a:fa5f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1fa431529sm165373366b.148.2025.03.04.17.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 17:00:22 -0800 (PST)
Message-ID: <71c1db26-f147-4578-89ae-c5b95da0ec9a@openvpn.net>
Date: Wed, 5 Mar 2025 02:00:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 20/24] ovpn: implement key add/get/del/swap via
 netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-20-d3cbb74bb581@openvpn.net> <Z8braoc3yeBY7lcE@hog>
 <07c73e1d-3c9c-46c7-92cd-28d728929d18@openvpn.net> <Z8eIJH1LtTtfljSj@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8eIJH1LtTtfljSj@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 00:09, Sabrina Dubroca wrote:
> 2025-03-04, 13:11:28 +0100, Antonio Quartulli wrote:
>> On 04/03/2025 13:00, Sabrina Dubroca wrote:
>>> 2025-03-04, 01:33:50 +0100, Antonio Quartulli wrote:
>>>>    int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
>>>>    {
>>> ...
>>>> +	pkr.slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
>>>> +	pkr.key.key_id = nla_get_u16(attrs[OVPN_A_KEYCONF_KEY_ID]);
>>>> +	pkr.key.cipher_alg = nla_get_u16(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);
>>>
>>>
>>> [...]
>>>> +static int ovpn_nl_send_key(struct sk_buff *skb, const struct genl_info *info,
>>>> +			    u32 peer_id, enum ovpn_key_slot slot,
>>>> +			    const struct ovpn_key_config *keyconf)
>>>> +{
>>> ...
>>>> +	if (nla_put_u32(skb, OVPN_A_KEYCONF_SLOT, slot) ||
>>>> +	    nla_put_u32(skb, OVPN_A_KEYCONF_KEY_ID, keyconf->key_id) ||
>>>> +	    nla_put_u32(skb, OVPN_A_KEYCONF_CIPHER_ALG, keyconf->cipher_alg))
>>>
>>> That's a bit inconsistent. nla_put_u32 matches the generated policy,
>>> but the nla_get_u{8,16} don't (and nla_get_u16 also doesn't match "u8
>>> key_id" it's getting stored into).
>>>
>>> [also kind of curious that the policy/spec uses U32 with max values of 1/2/7]
>>
>>  From https://www.kernel.org/doc/html/next/userspace-api/netlink/specs.html#fix-width-integer-types
>>
>> "Note that types smaller than 32 bit should be avoided as using them does
>> not save any memory in Netlink messages (due to alignment)."
>>
>> Hence I went for u32 attributes, although values stored into them are much
>> smaller.
> 
> Right.

What's wrong with key_id being u8 tough?

I am a bit reluctant to change all key_id fields/variables to u32, just 
because the netlink APIs prefers using u32 instead of u8.

Keeping variables/fields u8 allows to understand what values we're going 
to store internally.

And thanks to the netlink policy we know that no larger value will be 
attempted to be saved, even if the field is actually u32.


Cheers,


-- 
Antonio Quartulli
OpenVPN Inc.


