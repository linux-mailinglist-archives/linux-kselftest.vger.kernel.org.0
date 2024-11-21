Return-Path: <linux-kselftest+bounces-22421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AF79D54B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 22:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D57C1F22883
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 21:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAADB1D9A62;
	Thu, 21 Nov 2024 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cav3IMHw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED41C9B84
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224563; cv=none; b=DVb3h/Zo54AU9wI1UVFdXBNoyhXuwxuigXX0CXs/VMSvQnS9LDQtcyiDmZBbmrgI9kSS4ikZxrnyE91oqfls8AAspYeBUajHT+5R5thC8uqsaMNfOqA6svj7dCW55IKduR8etkx6LIaAP8avsUhvAWa9EVuJcb/7xtlcrXC2678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224563; c=relaxed/simple;
	bh=Z2ginHOMoysZ5Jwcvr2L9W1ayc//+kUlmYsa7C982os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhRJtC4WhKXOlFAP95VlMrSGatkxU3zApC39K3mOX3UUIJRXXJbYZkbyiiw92tdjS/5GBvWDciFEN8gfGJzFHSvdBaOAstYJWChxCETQKQH3sqPbO7MLaXsvRmSqjyHefBes9UhIDn65AO9YWSGy0AUGoXA5JpnZn/UmL8gaeN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cav3IMHw; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so15727561fa.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 13:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732224559; x=1732829359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yIePKKh7sBLlKyNSJlNNZDT4AyzR8TxY/kJvznDhEdA=;
        b=cav3IMHw3g3QXO8Cvamz2ENqUJu0RGhF+1Yk/tyP8f0o42GADSrtjgdEMlmsDQNIaS
         73oUbpUMKyXklffl8/+ZKYFn+DBoWe7R0PEWKThxvlpcfxc7hhTPtz/oo5p3vZCL/dIu
         yOkzsuQSdCjh/4pCfZ+3QUcgqRbomMN+BTBUwQsVEw7W0HKzMfmhjSZKL+0pfyl+4MnF
         aksMwYnq8hxpTUvjqFch7IifcWwbiN/tA3z9iX6sLLPMkoOcd3uSUgpM+I/JKQ9a/t3E
         1eOYMkueHdYOzh/D8fmVrq8IhiZ0t4REoFw6Y/oP8GTi2X2TQktEoX7LV7fpwdHyCGdp
         PjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732224559; x=1732829359;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIePKKh7sBLlKyNSJlNNZDT4AyzR8TxY/kJvznDhEdA=;
        b=GQclfWgiCBkf2SYEbWYcMx9t8ydV3vnvpYouY50xnJl/Jg9jn/nKMoqFchq9Fyb/CX
         q3bRu40dhfEvj0oN7hwYXmv+OYtGJRnEzpHrcUnaEpllQusVpdfrt30qayW9uuPQUqCd
         Urqu5tYtIeWkuyZEekxa2avpxCtYteF9zviN2OFT6FsXmq4hlNnEUoG+mfe+VE3PhADx
         MmD+12OJYkbujWti7t6WP8oN5O0RF9Gus4TQxabrSCwEs5rfLFTsgnMmDuMPAA7u0HIU
         mlRgMRXh8Cdz7sn6kM+8EgMg0Wz4jYewFN/epI34rm5uZ/jwxJ2r1ijQ1+2qMjEATGZu
         Vaeg==
X-Forwarded-Encrypted: i=1; AJvYcCXONAJOV3HRiQiQYdsutsaf8BFUfMw386xxNdYA4MfFBZ/nwDDddQ4KGoIjHHU7Ur//kWiUkZ2IQFXE9P3AKxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOM7RQeDK+OW2ox71xyatZomQCYMPMn0Rk5zkeU+905y5fZNcf
	5UDgq4vmkAsyLN3Xng5u36vDS88FPxrLk67WiRSET+gLo0q9xWnoCk479CRLs5I=
X-Gm-Gg: ASbGnculX3JbTfkRLWNVdhaPFknTI52nDW5YpITPDDJbPF4Qlxx1yhtCv+3/6t2OEqa
	ivRI1k8YkdkutcpQ1Z83WgtL8E3y3+PEiNT5Cgw2tSlsL1JvVyb79MWErM6sQOZhlAC+5tROwPE
	NnZ6h2zt9EkBvTopdrofBR5k3kiJvg09E2xWsaGF8X5VSiiIziitiv0myCvpQ5zr7TmFAnZmXvq
	1ks+tQh+fIHjm3qlQEEH9GOSxWPoPbvmr/S5I1sgHcWuoshnQa3xWpte+Laq/UAFH/k2w3UNTSk
	D4bTyTQ37w==
X-Google-Smtp-Source: AGHT+IFhKsMdjaWcHT5oFT99C+YjQHxqLkqwCxHmU06KQ0PZXYX2Bl6XTAjc2loHpJbQs+qWtj6gbg==
X-Received: by 2002:a05:651c:b0f:b0:2fb:65c8:b4ae with SMTP id 38308e7fff4ca-2ffa71a7b98mr1267121fa.31.1732224558718;
        Thu, 21 Nov 2024 13:29:18 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f55:fe70:5486:7392? ([2001:67c:2fbc:1:f55:fe70:5486:7392])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3c0376sm189384a12.46.2024.11.21.13.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 13:29:17 -0800 (PST)
Message-ID: <587e8015-a511-4e8e-af74-337d6383fd57@openvpn.net>
Date: Thu, 21 Nov 2024 22:29:45 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 07/23] ovpn: introduce the ovpn_socket object
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-7-de4698c73a25@openvpn.net>
 <62d382f8-ea45-4157-b54b-8fed7bdafcca@gmail.com>
 <1dffb833-1688-4572-bbf8-c6524cd84402@openvpn.net>
 <b8612694-c5b7-4b62-8b9d-783aaec1439f@openvpn.net>
 <68214df3-23b6-4da4-9ad9-b10e8878a4da@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <68214df3-23b6-4da4-9ad9-b10e8878a4da@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/11/2024 00:34, Sergey Ryazanov wrote:
> On 19.11.2024 15:44, Antonio Quartulli wrote:
>> On 15/11/2024 15:28, Antonio Quartulli wrote:
>> [...]
>>>>> +}
>>>>> +
>>>>> +static struct ovpn_socket *ovpn_socket_get(struct socket *sock)
>>>>> +{
>>>>> +    struct ovpn_socket *ovpn_sock;
>>>>> +
>>>>> +    rcu_read_lock();
>>>>> +    ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
>>>>> +    if (!ovpn_socket_hold(ovpn_sock)) {
>>>>> +        pr_warn("%s: found ovpn_socket with ref = 0\n", __func__);
>>>>
>>>> Should we be more specific here and print warning with 
>>>> netdev_warn(ovpn_sock->ovpn->dev, ...)?
>>>
>>> ACK must be an unnoticed leftover
>>
>> I take this back.
>> If refcounter is zero, I'd avoid accessing any field of the ovpn_sock 
>> object, thus the pr_warn() without any reference to the device.
> 
> If it's such unlikely scenario, then should it be:
> 
> if (WARN_ON(!ovpn_socket_hold(ovpn_sock)))
>      ovpn_sock = NULL;
> 
> ?

Yeah, makes sense.

Thanks!

> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.


