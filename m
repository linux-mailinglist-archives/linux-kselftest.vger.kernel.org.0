Return-Path: <linux-kselftest+bounces-22096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434169CE0A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 14:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29DC28DED6
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968FE1D63F6;
	Fri, 15 Nov 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Qk0judhr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E31CF2A3
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678321; cv=none; b=Zz10K4iui9C60zTAQ7GCGff995TZ0uk3kRVpL1Ta3xT6S8otCnJkXm/2N+Ux3QZqgSHlRMOKTmNQDh4qpDGh5CspmmePKpmkWtrvBZXBZMvzge9gxNaymxHUJVzPH2dhQYkoDXE8sIdyxSQN+q/JCBAndVo2ioH6Hwfs09/DqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678321; c=relaxed/simple;
	bh=wEvihj3FaG6q6yux4Sp4g9xT2J7CX9ZO0jrhysEVxMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxKxIUJIAjqxFwxhIKJdxuqZnzrQRWnZTw6REQGYxHLt04XKgf+QAv/p1kFYmeWP9iZAvkcQPBbrMT/SG1hibAt/4h2wNAa5x09N2iMWV7eEmh2erw7D+QwxXKAD5AZenwos6RTkfJoANl1btFWAV7DU6bhp3AOfWr4SreIZPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Qk0judhr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539d9fffea1so1793597e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 05:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731678316; x=1732283116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ov+3BoKnMSe11D0SkLhwSbXFmwsCCeFQwOwZmC0xFp8=;
        b=Qk0judhrAu4hBwxj3IlkDvz/6ABn9lsTR2VNmgCTykDrHpPAVC6JYOUzJ4Tt05z9Ez
         vn9rh9+H+m42hn9rdJNdy1PHlQIb3u4vOIomYs+oaSn2PASDS8a0x6YLO4Prree3x5FL
         GQpDjm+0jSUdRRzEaOKOC0Hlv4OKNZSKzC7Pk58oJqyc0EaS/U3IVaCvkKD3rh8eZSdj
         KEDtC9Dfh1beK93j6E8AUyJObbk1J8/IpxJB2Zpv4UdBKRd/vCZgoNla+vzwjpij9WB3
         xxGXKSYdDbC+p1SQ3rqLyaafyPyOOzzlpEucWMOF0mJtHBCPYJaLmoboJ8Vn993+bWGC
         4kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678316; x=1732283116;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ov+3BoKnMSe11D0SkLhwSbXFmwsCCeFQwOwZmC0xFp8=;
        b=UlWwYwEHT9PK46g7LXtMl+qTsCgZzk6OU0AEpfZfUxM8dTV876hB3C4GYIALLwwJAF
         ifxmHoo1F1EHWkhkh1CYfwSkZzKQPyed1bngrhOjhwTsgFAdvAfpy3nLbTsZVZTCxM36
         u6ZBJ9rdu8H5J86/F5/bPRi0a4TTiGoGI+4ZilaLwk7qjIshie74ZsKooD/I6gsZiPwE
         3ucmeEC9dk2khMvDgkpl7H2IxRkqHvpSWLkY8Dimr36Bky8i+RyoM+SVpsKv3CN/0po0
         pnwOARP6uqXCxS3rOcknyAG7v6DCHZp6CRGANP4J053N5mdIYiopca96h4dVf5gYRqDM
         BmWw==
X-Forwarded-Encrypted: i=1; AJvYcCXsxvDiOOiswzPG+4eKnBh/PGpZnnrtfHO1dKEBxfLQ7OPjKH1qKh2t3yoRODvwatDBpN4zDARkH3qBjX1Aj9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhQ/wGAwcHfwijxMH8NaxqfHIDFHWBihyRbAIjNrw8AK6jG5f
	AIO3uMVqOFNuVugch89axk/MmahbY5aSDspLaI+chIFLCr8bkzjO/IPphIScMOE=
X-Google-Smtp-Source: AGHT+IHfp6211N2zJyxWAZDS/FNeL1B2lIvzVzZiH4FMGRoWJY7Lr3+gfzb1/aQAr6d75eCnF/HSqA==
X-Received: by 2002:a05:6512:2823:b0:535:3ca5:daa with SMTP id 2adb3069b0e04-53dab2919f6mr1543586e87.7.1731678316391;
        Fri, 15 Nov 2024 05:45:16 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:59f4:10be:886a:27eb? ([2001:67c:2fbc:1:59f4:10be:886a:27eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da244cb6sm58968975e9.0.2024.11.15.05.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 05:45:15 -0800 (PST)
Message-ID: <353a7ffd-852a-4da6-b382-ea1714c69dc1@openvpn.net>
Date: Fri, 15 Nov 2024 14:45:41 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/23] ovpn: add basic interface
 creation/destruction/management routines
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-4-de4698c73a25@openvpn.net>
 <2fd3dc9c-9d6a-494c-a4d8-a45221bf250d@gmail.com> <ZzOGqP9AAGSN2E7y@hog>
 <3da3a4a6-f88d-4b60-be99-42860e1b8b2d@openvpn.net>
 <7ba4b3a0-06ca-4273-aaf0-19f92b4de3e9@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <7ba4b3a0-06ca-4273-aaf0-19f92b4de3e9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/11/2024 23:57, Sergey Ryazanov wrote:
> On 14.11.2024 10:07, Antonio Quartulli wrote:
>> On 12/11/2024 17:47, Sabrina Dubroca wrote:
>>> 2024-11-09, 03:01:21 +0200, Sergey Ryazanov wrote:
>>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>>> +/* When the OpenVPN protocol is ran in AEAD mode, use
>>>>> + * the OpenVPN packet ID as the AEAD nonce:
>>>>> + *
>>>>> + *    00000005 521c3b01 4308c041
>>>>> + *    [seq # ] [  nonce_tail   ]
>>>>> + *    [     12-byte full IV    ] -> NONCE_SIZE
>>>>> + *    [4-bytes                   -> NONCE_WIRE_SIZE
>>>>> + *    on wire]
>>>>> + */
>>>>
>>>> Nice diagram! Can we go futher and define the OpenVPN packet header 
>>>> as a
>>>> stucture? Referencing the structure instead of using magic sizes and 
>>>> offsets
>>>> can greatly improve the code readability. Especially when it comes 
>>>> to header
>>>> construction/parsing in the encryption/decryption code.
>>>>
>>>> E.g. define a structures like this:
>>>>
>>>> struct ovpn_pkt_hdr {
>>>>    __be32 op;
>>>>    __be32 pktid;
>>>>    u8 auth[];
>>>> } __attribute__((packed));
>>>>
>>>> struct ovpn_aead_iv {
>>>>    __be32 pktid;
>>>>    u8 nonce[OVPN_NONCE_TAIL_SIZE];
>>>> } __attribute__((packed));
>>>
>>> __attribute__((packed)) should not be needed here as the fields in
>>> both structs look properly aligned, and IIRC using packed can cause
>>> the compiler to generate worse code.
>>
>> Agreed. Using packed will make certain architecture read every field 
>> byte by byte (I remember David M. biting us on this in batman-adv :))
> 
> Still curious to see an example of that strange architecture/compiler 
> combination. Anyway, as Sabrina mentioned, the header is already pretty 
> aligned. So it's up to you how to document the structure.

IIRC MIPS was one of those, but don't take my word for granted.

> 
>> This said, I like the idea of using a struct, but I don't feel 
>> confident enough to change the code now that we are hitting v12.
>> This kind of change will be better implemented later and tested 
>> carefully. (and patches are always welcome! :))
> 
> The main reason behind the structure introduction is to improve the code 
> readability. To reduce a shadow, where bugs can reside. I wonder how 
> many people have invested their time to dig through the encryption 
> preparation function?
> 
> As for risk of breaking something I should say that it can be addressed 
> by connecting the kernel implementation to pure usespace implementation, 
> which can be assumed the reference. And, I believe, it worth the benefit 
> of merging easy to understand code.
> 

I understand your point, but this is something I need to spend time on 
because the openvpn packet format is not "very stable", as in "it can 
vary depending on negotiated features".

When implementing ovpn I decided what was the supported set of features 
so to create a stable packet header, but this may change moving forward 
(there is already some work going on in userspace regarding new features 
that ovpn will have to support).
Therefore I want to take some time thinking about what's best.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


