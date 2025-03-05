Return-Path: <linux-kselftest+bounces-28311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310D6A5006D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 14:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CC816BB6A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0E24633D;
	Wed,  5 Mar 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Nr2dnttS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CCB24501D
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180639; cv=none; b=nYDsn71fX5rWNKacZL/EfyeCqPYYMNTqOoaQaaOtdeWQ+Mv+apHOhXwE9PN44caA3IHwCehZeTm/i2Xe0f06P70Th3y3tT8y4nFyyGI1jFlOnCWW3gogtRSMCu2sSDBt4ccNlDQ3RBGes/mhFiXYUvteVYqIsoPocy5miCZ8GDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180639; c=relaxed/simple;
	bh=2kxHOADdMaBJ2diMMR7f3Fz/guxN2SEgJZkgoL6/lJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOQ5PvmhRquJ+Xt6Ze3mJIM5Mk3TXVyrfLLI7Bibh/cU9sbArnu36GQhoq4LAth+ys9CYhmFM8rnQpkM1XGt2p7ZUldDKk/gZ9FzkAul/DEItyNrBjnjU43lUw0CZ/X/Nk9eMokYja+rK1KqC2G6FOEd47GrlzvvkzJkujT7FTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Nr2dnttS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso46224415e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 05:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741180635; x=1741785435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6N01sDPWZVW3FIPmf2JkMC4QdlVlUkWYnKGuNikmOwk=;
        b=Nr2dnttSS5udPt5LBLeFCEjM99AKV1stfi4dhqppWSZ9Bk0OUfaTSaYjcBGhDK2N3y
         RGDBS6VR+ePFZDhNm1TglpB44ynyavh8DwTP4xOh17G31cFD01wxLIikEV0W4PY3jtgO
         N5hCxA7HUpvjKYllwKsQktZL0fJcQR11PR2UeEvP5wMDrQ7mH0eu7ISkArs/thzo6T3r
         NuvtMTwWDMBAsY3Hnq1zv3dYwGfe1VwPBO4FkzQOTrqnA8CwE6qf07Ivblzc+6u85OqQ
         f+uk1LY3Cxj22qsz2EeZ5wwqC27JlrkOJwLbEzW7LpJZbD9ij3GqRLdwuTxqlwwqq6MO
         b5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180635; x=1741785435;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6N01sDPWZVW3FIPmf2JkMC4QdlVlUkWYnKGuNikmOwk=;
        b=k4jgt1ZP3278/BCC3vbB2DeDvVt1jigE7mAc3/loSJWcecxp7Vb6nYFNt17GepHrYM
         GTa0L8ANvmJ5itD1vMfkv6MikEkgIAdaYSdLdTOjizfbaKwyJWPabWRYBOLZp7T5kAxU
         1NeF5kRO8slEFXDDJkVCKEwVVQouN1hC0eiAcmqK8nsHpgUiiQMDKKfFqbVsU0x9R+rm
         Pv6knFMw2Gv/BgK15ddZaOe5wLfU5+Mq5gi6rgDZX1X/LT7uGQu9zCDUMc3jaoUr1Rfi
         EXwGmTu1lzZOfettrQ/bvE4blTpYz4JLv9/G/mbQLWtSnbxaCE1VsEQlaarP5Ap8mozh
         v/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbgku1aFcS23n8Rw/OQFTLoku/436ggH/V7cCydMQPeC1f+V/z6m6FSu0Rljwq5Q8aPAcCaG2rfCQou6NmyFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3UeqlkA8CasLV3+L+MhW/ARB7DtHtmSBsGEIBjC4LiKntcIq
	uRrRpw0qRcEIA72dadlNWAyHduQ1OiNMtpAw3/HyiQ8CT3qd4zEErzfDPecXV1w=
X-Gm-Gg: ASbGnctyBjaWKWsbS/SWhHzIu2iQqiDJewk9BysrLlWnNZEVLfPkfvK8BW6EFNErXKZ
	brxcJbZ44b2+59lA+lH3ssZNLjfnUTjoR/ZiWG8ZWkZFk0CePxbR7e2XrLU9SEs91Xgpv0HxNWO
	Pg0TCu6EuX1pnonR2HA7oyCzlC8S4tz23huquQTLtz8KsZCGz+cOEz7YA6vxkCiJwCGHdANHci2
	eGhhvnv2+KsWUQwQm/NfNRCgSAO7WhY7mVzTS7YuooH+z9DtOxyBFS8s7FdN6i29l4g+99mCDxF
	XYNdiRapaV2J7WS0hbsDqZuhzXFWjYov7c5j10aWacMXAI7FMmaQ8Rz0FQVI58brvM9SO/CSOrg
	Am3Ex
X-Google-Smtp-Source: AGHT+IHRg0l/1N8uHFnYb4bX5yYHlChPZNy+86wJV5dCxTO5VpvzzPCHs43ZAYtx/q1KNZyZRo48PQ==
X-Received: by 2002:a05:6000:1844:b0:390:de59:470d with SMTP id ffacd0b85a97d-3911f760290mr2386582f8f.24.1741180635465;
        Wed, 05 Mar 2025 05:17:15 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:6b84:f104:e1bf:5d7? ([2001:67c:2fbc:1:6b84:f104:e1bf:5d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7dcfsm21291872f8f.55.2025.03.05.05.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 05:17:14 -0800 (PST)
Message-ID: <52bdddf9-99e0-4b87-8bae-c0a8f32beba8@openvpn.net>
Date: Wed, 5 Mar 2025 14:17:13 +0100
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
 <71c1db26-f147-4578-89ae-c5b95da0ec9a@openvpn.net> <Z8gjXLepPcRByLTZ@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8gjXLepPcRByLTZ@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 11:11, Sabrina Dubroca wrote:
> 2025-03-05, 02:00:21 +0100, Antonio Quartulli wrote:
>> On 05/03/2025 00:09, Sabrina Dubroca wrote:
>>> 2025-03-04, 13:11:28 +0100, Antonio Quartulli wrote:
>>>> On 04/03/2025 13:00, Sabrina Dubroca wrote:
>>>>> 2025-03-04, 01:33:50 +0100, Antonio Quartulli wrote:
>>>>>>     int ovpn_nl_key_new_doit(struct sk_buff *skb, struct genl_info *info)
>>>>>>     {
>>>>> ...
>>>>>> +	pkr.slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
>>>>>> +	pkr.key.key_id = nla_get_u16(attrs[OVPN_A_KEYCONF_KEY_ID]);
>>>>>> +	pkr.key.cipher_alg = nla_get_u16(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);
>>>>>
>>>>>
>>>>> [...]
>>>>>> +static int ovpn_nl_send_key(struct sk_buff *skb, const struct genl_info *info,
>>>>>> +			    u32 peer_id, enum ovpn_key_slot slot,
>>>>>> +			    const struct ovpn_key_config *keyconf)
>>>>>> +{
>>>>> ...
>>>>>> +	if (nla_put_u32(skb, OVPN_A_KEYCONF_SLOT, slot) ||
>>>>>> +	    nla_put_u32(skb, OVPN_A_KEYCONF_KEY_ID, keyconf->key_id) ||
>>>>>> +	    nla_put_u32(skb, OVPN_A_KEYCONF_CIPHER_ALG, keyconf->cipher_alg))
>>>>>
>>>>> That's a bit inconsistent. nla_put_u32 matches the generated policy,
>>>>> but the nla_get_u{8,16} don't (and nla_get_u16 also doesn't match "u8
>>>>> key_id" it's getting stored into).
>>>>>
>>>>> [also kind of curious that the policy/spec uses U32 with max values of 1/2/7]
>>>>
>>>>   From https://www.kernel.org/doc/html/next/userspace-api/netlink/specs.html#fix-width-integer-types
>>>>
>>>> "Note that types smaller than 32 bit should be avoided as using them does
>>>> not save any memory in Netlink messages (due to alignment)."
>>>>
>>>> Hence I went for u32 attributes, although values stored into them are much
>>>> smaller.
>>>
>>> Right.
>>
>> What's wrong with key_id being u8 tough?
> 
> Nothing. It would make a little bit more sense to use nla_get_u16 if
> key_id was u16 (even with OVPN_A_KEYCONF_KEY_ID defined as U32), or to
> use nla_get_u8 for u8, but here it was just 3 different int sizes and
> that triggered my "uh? what?" :)
> 
>> I am a bit reluctant to change all key_id fields/variables to u32, just
>> because the netlink APIs prefers using u32 instead of u8.
>>
>> Keeping variables/fields u8 allows to understand what values we're going to
>> store internally.
> 
> Sure.
> 
>> And thanks to the netlink policy we know that no larger value will be
>> attempted to be saved, even if the field is actually u32.
> 
> Yes.
> 

Ok :)

Then I'll make sure they all use nla_get/put_u32, but will still store 
the key_id in a u8 field.

Cheers!

-- 
Antonio Quartulli
OpenVPN Inc.


