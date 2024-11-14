Return-Path: <linux-kselftest+bounces-22064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D819C9579
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 23:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C551F21902
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 22:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498E61AF0DA;
	Thu, 14 Nov 2024 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi3rcmdF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6761CABA;
	Thu, 14 Nov 2024 22:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625002; cv=none; b=LrzhSnikuvtTygPYAtDxOx93xKVpWv88ZfzNlQ/gHwhNzURp/QkixNzivfUWSiYwlzDoeCOLdULkEiAIaxutQ+vGVRnhy4qum1Zl6L7XNkL8c5XUQvDi0wZJqPXyb0hZREBLkoFwQg6sNgCAysgfoiJpEW3zp+fGa23dlTXbRhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625002; c=relaxed/simple;
	bh=JpWV4BRf/EYNJJZRL8jz0IhmykUMbTzedEyEcfcFVnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWZ7xN8nRV/9ihsvBqmH57L/QJh5+c2K1XAs8bRdLbLXM78c7FmqRF0L1K+st8pclmJzOLYhv/pHy8bkayWVokMgoJbaZnOQwqJSvZ2cKDqWnh8UoJVlVndLaB3mIpDUDsDY7ihfVAC0FzTRnOmeXnXRhHOt2P9LzFBArRNI3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi3rcmdF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38207c86695so878797f8f.2;
        Thu, 14 Nov 2024 14:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731624999; x=1732229799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+cX0QqP0V6My/hoYTQYVWX/B4DMyUqRZBvg+yn80VBo=;
        b=Oi3rcmdFv9A74Q3bJutd5s3jCNuiDtL/AbmADAHa+UtWZfjusN4gz2qjnPT1y8EMD0
         BTICeeGmOkr3nU7dOnGOrWLF1ZxtBXuhqVKHrVlTn4TETTilCw7cRp3fAG5J8wPt2Ovu
         m2KRg0+aVyMUBAuhX5kg2lfFPTbyNrgTvNI4dal+QcF2qPZR3kclynipqE1+LAV1sqG5
         UfrM+mzdoJgbqE9xc1jCarbYIeU4wKa6xWQ2e8o+9Xhf4M3WXfnpZfKJwn/x4Zl06giB
         85IhWkV1HYhcteH3xHeDTn6HLTKGOQmjZBJnz9bvyNd2BpHXp/KlCcSlPA41Jw2xywdb
         jDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731624999; x=1732229799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cX0QqP0V6My/hoYTQYVWX/B4DMyUqRZBvg+yn80VBo=;
        b=f8YzmfR65Rn+HWlVRilFYTWwJRV8oAFtJE1YY6fkYi0XmgbhhcOQ6T99V5rgj2TRlO
         vXn0D2OWKBEvQXVPT1DDdPdzkbsFj03NcAHhrR+kici7bFwJjJEVFtjTVi9LETqxU0A8
         lad71YJbElu4RWNKDXa7v3oRyfU0UWymCOwY2yjGgnXy6yFCdMIp3lDqYQFt1DPqCWsZ
         Yx8A6drXCINBBeuuddUEzitTLLUB8rkBCgsEe313Jqy+QSgjvPhqH5r0ahkcMJjubIis
         Mx3NgjAfvM+WFEiyLzZiYVfPO9EyLaJm3ra5wxPaFVdKKFIo4MlstQBMbRndKGmrfVPx
         RRfw==
X-Forwarded-Encrypted: i=1; AJvYcCVhL97bEs0v3kacCNWDik5SRcD1acGEh2hBP4zh0AzEVB3KLLoCbfRKAyR9wFQJ8Crc6B6barHBWpYzMQM=@vger.kernel.org, AJvYcCWo7jnjq5/SBm0hh7KLRiqQK0oS0Pjv/OtPvVV6liXNp0RzDfvOQIdnVwLIjDm16YyiKj+RWiMM@vger.kernel.org, AJvYcCXrzIh8nqUjEIcCazWpxPa0WxEGxd8wn3K9FTFW2Iuvu8LqFfZnjC7RDfq3N0k+idhEtlNwhaiPVBvulOSe9i00@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ2PX+f0p16OKLyGhccIagePIjsQDXem90Tgl0SpYg7Cazj261
	4fYNwmjN6rzkYy4f/k4u1Fsa6PH49j+E45OyBTuNMCzFaF8wF/cM
X-Google-Smtp-Source: AGHT+IG3f65CkTus0jOC7jY2c+VqSfHeaC8Gijd7TeChDPb3WwSHSulsmwqUatGBzbufr2w5SLH4GQ==
X-Received: by 2002:a05:6000:4714:b0:37d:452b:478f with SMTP id ffacd0b85a97d-382258f1082mr344653f8f.4.1731624998795;
        Thu, 14 Nov 2024 14:56:38 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbbca7sm2736484f8f.47.2024.11.14.14.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 14:56:37 -0800 (PST)
Message-ID: <7ba4b3a0-06ca-4273-aaf0-19f92b4de3e9@gmail.com>
Date: Fri, 15 Nov 2024 00:57:09 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/23] ovpn: add basic interface
 creation/destruction/management routines
To: Antonio Quartulli <antonio@openvpn.net>,
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
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <3da3a4a6-f88d-4b60-be99-42860e1b8b2d@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.11.2024 10:07, Antonio Quartulli wrote:
> On 12/11/2024 17:47, Sabrina Dubroca wrote:
>> 2024-11-09, 03:01:21 +0200, Sergey Ryazanov wrote:
>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>> +/* When the OpenVPN protocol is ran in AEAD mode, use
>>>> + * the OpenVPN packet ID as the AEAD nonce:
>>>> + *
>>>> + *    00000005 521c3b01 4308c041
>>>> + *    [seq # ] [  nonce_tail   ]
>>>> + *    [     12-byte full IV    ] -> NONCE_SIZE
>>>> + *    [4-bytes                   -> NONCE_WIRE_SIZE
>>>> + *    on wire]
>>>> + */
>>>
>>> Nice diagram! Can we go futher and define the OpenVPN packet header as a
>>> stucture? Referencing the structure instead of using magic sizes and 
>>> offsets
>>> can greatly improve the code readability. Especially when it comes to 
>>> header
>>> construction/parsing in the encryption/decryption code.
>>>
>>> E.g. define a structures like this:
>>>
>>> struct ovpn_pkt_hdr {
>>>    __be32 op;
>>>    __be32 pktid;
>>>    u8 auth[];
>>> } __attribute__((packed));
>>>
>>> struct ovpn_aead_iv {
>>>    __be32 pktid;
>>>    u8 nonce[OVPN_NONCE_TAIL_SIZE];
>>> } __attribute__((packed));
>>
>> __attribute__((packed)) should not be needed here as the fields in
>> both structs look properly aligned, and IIRC using packed can cause
>> the compiler to generate worse code.
> 
> Agreed. Using packed will make certain architecture read every field 
> byte by byte (I remember David M. biting us on this in batman-adv :))

Still curious to see an example of that strange architecture/compiler 
combination. Anyway, as Sabrina mentioned, the header is already pretty 
aligned. So it's up to you how to document the structure.

> This said, I like the idea of using a struct, but I don't feel confident 
> enough to change the code now that we are hitting v12.
> This kind of change will be better implemented later and tested 
> carefully. (and patches are always welcome! :))

The main reason behind the structure introduction is to improve the code 
readability. To reduce a shadow, where bugs can reside. I wonder how 
many people have invested their time to dig through the encryption 
preparation function?

As for risk of breaking something I should say that it can be addressed 
by connecting the kernel implementation to pure usespace implementation, 
which can be assumed the reference. And, I believe, it worth the benefit 
of merging easy to understand code.

--
Sergey

