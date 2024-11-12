Return-Path: <linux-kselftest+bounces-21902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239729C658D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 00:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD02D2844BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4A921CF82;
	Tue, 12 Nov 2024 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2w0J/Jq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD642FC23;
	Tue, 12 Nov 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455765; cv=none; b=VPC44qZOjcR41arHXOcDntasJVLaIBz1bpEOZghPHgGkTKf/gbaJSGBbvR3FwhqvFhpe2Rs/BpKuSAUqf14PTmHLGrVUlU+HqLsSXR89mtxn3B0BV0AIdDrhYVS0ZnDh8FPP/iyB4kQLq3AbVOhr9Hb4pDS5ZWF0+q3RwItWuaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455765; c=relaxed/simple;
	bh=z+DRKjJHzcUGE/2W2detPEAAaU2VP4blQBH+jOMdy24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5RaumWsKPysYI+3QlxZMy1qtmUDEfYuWkBjkDJX+a2ruSlEA/Et+gFQwYJjN1QqobJm74gTI5eozaGkNOYviNk1oZ28Blep5RXf+rx2/YHlJm/4/Yh5ZbIQ5tnr0jdk1OzqNk57QKxPBWx75CqM1w91xnYC6p0xMMRu0fJEBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2w0J/Jq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so51069405e9.3;
        Tue, 12 Nov 2024 15:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731455762; x=1732060562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPX2HubMD2XkMQ4pQh5hLYBi/zSrflbsVt51KzFPBlo=;
        b=k2w0J/Jq+UwpqGYhwKYt31TbKk5/ZHfAMEXCP7Yfw6e46cd9T4xMUsvN7T6yObVDn1
         /batg3xiWUMGYj1eGwJ0gf9uLmQUs5Qo5yjyzNlwBkL7rf51k/VNTN9hfxQk9994mHQl
         Y6m67c8Q1NcNBbGVAyA+gU7xETNSuNiYVJx3lDmmMQCSgzydbh0d5UkSyADhbAakvzJT
         Fidn6UEkgdWL+xoP5aOceZZFoJbXo/d3BmPb89SqPnXLXHjwFzi7LjlbhI6eUTnAjFfP
         jB8smLIfVV0YmTCKN1KTh/hsKpGxhgewEehh1rU1kt+pKb5+kEGv2Vl5v1UmtnMzIfCQ
         b91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731455762; x=1732060562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPX2HubMD2XkMQ4pQh5hLYBi/zSrflbsVt51KzFPBlo=;
        b=eu8w41QVh9xd1Oron+TqhlqqRAJ2kkyo5yvPEmqX5IbNWeWK/oFs1xFkJ4LaAVPmu8
         2meTVou/hB8DqCTjFV7Y7iCc4EQpDVBpzqMgLFg5VoSxuSKrX2O7Is6vBwrmh05QrlUj
         nvn1+a2tCd4JCK6KPrTPvwQoIW1pVRvfGb5l3lsVQSdVHFjEvqkEaer+kc26XowaJ8k3
         x+YzozF6azv0DIv3hp4wlwB7Gm92ERGFN00+NtIvcjI8oGRg9sk7tEf2SRQ0c44bmAb5
         gpWg4qK9sTt9eTOBaSPXJzpyEzAdiPWqsUuubbcmVOywf8rPvZpMN2znxHu8aOx5aaIA
         XzPA==
X-Forwarded-Encrypted: i=1; AJvYcCUz0S7h6L762l+G5Q+LGYXa9PaXJ1zaJdWcA28mBYU/9Viog/U/+OHf+ck4h4AkpVvxJKaal0RKYTZAU0xY0pnO@vger.kernel.org, AJvYcCVs1HeM9N3r4mf4JP8GkrJK3t3iGTMY5g7GbTs6T1FcO5S/JIZrQmaKj7mtGRWKd2rFBlfu9Vnz10IO6W4=@vger.kernel.org, AJvYcCWspvcbhEBVYKb+6O1qlVkYcDpNvPz/1VZBJJ+QjwTPiaEf+sfkEo9DcEN+JoBEhbaoZ5Jx+EhM@vger.kernel.org
X-Gm-Message-State: AOJu0YzrRUeWxLzfwOJlCUEe0XyHs5Mf4xFx/2uhhHA29jVyA70kfwpx
	L5Sp0r1tWDGfE6AZeQmEB+Pom2ErOzjPJ6J9KzDXJGngNFAGFY5A
X-Google-Smtp-Source: AGHT+IEiPiDkzgyTkv+vPfbi8V7ooV4hxHnzF/1ZiQ+HRyevtIERuTCQFRxzEeicrb8xWRyjyI+4Nw==
X-Received: by 2002:a05:600c:4e50:b0:431:2b66:44f7 with SMTP id 5b1f17b1804b1-432cd47dacemr38913695e9.31.1731455761437;
        Tue, 12 Nov 2024 15:56:01 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d55038c5sm3502225e9.19.2024.11.12.15.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 15:56:00 -0800 (PST)
Message-ID: <7e98323f-a1cd-4922-a3c0-b98dbb209e93@gmail.com>
Date: Wed, 13 Nov 2024 01:56:31 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/23] ovpn: add basic interface
 creation/destruction/management routines
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antonio Quartulli <antonio@openvpn.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-4-de4698c73a25@openvpn.net>
 <2fd3dc9c-9d6a-494c-a4d8-a45221bf250d@gmail.com> <ZzOGqP9AAGSN2E7y@hog>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <ZzOGqP9AAGSN2E7y@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.2024 18:47, Sabrina Dubroca wrote:
> 2024-11-09, 03:01:21 +0200, Sergey Ryazanov wrote:
>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>> +/* When the OpenVPN protocol is ran in AEAD mode, use
>>> + * the OpenVPN packet ID as the AEAD nonce:
>>> + *
>>> + *    00000005 521c3b01 4308c041
>>> + *    [seq # ] [  nonce_tail   ]
>>> + *    [     12-byte full IV    ] -> NONCE_SIZE
>>> + *    [4-bytes                   -> NONCE_WIRE_SIZE
>>> + *    on wire]
>>> + */
>>
>> Nice diagram! Can we go futher and define the OpenVPN packet header as a
>> stucture? Referencing the structure instead of using magic sizes and offsets
>> can greatly improve the code readability. Especially when it comes to header
>> construction/parsing in the encryption/decryption code.
>>
>> E.g. define a structures like this:
>>
>> struct ovpn_pkt_hdr {
>>    __be32 op;
>>    __be32 pktid;
>>    u8 auth[];
>> } __attribute__((packed));
>>
>> struct ovpn_aead_iv {
>>    __be32 pktid;
>>    u8 nonce[OVPN_NONCE_TAIL_SIZE];
>> } __attribute__((packed));
> 
> __attribute__((packed)) should not be needed here as the fields in
> both structs look properly aligned, and IIRC using packed can cause
> the compiler to generate worse code.

True, the fields are pretty good aligned and from code generation 
perspective packed indication is unneeded. I suggested to mark structs 
as packed mostly as a documentation to clearly state that these 
structures represent specific memory layout.

>>> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
>>> index 8516c1ccd57a7c7634a538fe3ac16c858f647420..84d294aab20b79b8e9cb9b736a074105c99338f3 100644
>>> --- a/include/uapi/linux/if_link.h
>>> +++ b/include/uapi/linux/if_link.h
>>> @@ -1975,4 +1975,19 @@ enum {
>>>    #define IFLA_DSA_MAX	(__IFLA_DSA_MAX - 1)
>>> +/* OVPN section */
>>> +
>>> +enum ovpn_mode {
>>> +	OVPN_MODE_P2P,
>>> +	OVPN_MODE_MP,
>>> +};
>>
>> Mode min/max values can be defined here and the netlink policy can reference
>> these values:
>>
>> enum ovpn_mode {
>>    OVPN_MODE_P2P,
>>    OVPN_MODE_MP,
>>    __OVPN_MODE_MAX
>> };
>>
>> #define OVPN_MODE_MIN OVPN_MODE_P2P
>> #define OVPN_MODE_MAX (__OVPN_MODE_MAX - 1)
>>
>> ... = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_MIN, OVPN_MODE_MAX)
> 
> I don't think there's much benefit to that, other than making the diff
> smaller on a (very unlikely) patch that would add a new mode in the
> future. It even looks more inconvenient to me when reading the code
> ("ok what are _MIN and _MAX?  the code is using _P2P and _MP, do they
> match?").

I would answer yes. Just prefer to trust these kind of statements until 
it crashes badly. Honestly, I never thought that referring to a max 
value might raise such a question. Can you give an example why it should 
be meaningful to know exact min/max values of an unordered set?

I suggested to define boundaries indeed for documentation purpose. Diff 
reduction is also desirable, but as you already mentioned, here it is 
not the case. Using specific values in a range declaration assigns them 
with extra semantic. Like, MODE_P2P is also a minimal possible value 
while MODE_MP has this extra meaning of minimal possible value. And we 
can learn this only from the policy which is specified far way from the 
modes declarations. I also see policies declaration as referring to 
already defined information rather than creating new meanings. On 
another hand the NL policy is the only user, so maybe we should left it 
as-is for the sake of simplicity.

--
Sergey

