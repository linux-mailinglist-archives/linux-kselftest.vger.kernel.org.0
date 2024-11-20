Return-Path: <linux-kselftest+bounces-22381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8527A9D446F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 00:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09ECE1F215C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 23:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E7C1C4A3F;
	Wed, 20 Nov 2024 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbwT+1A+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593EA13BAF1;
	Wed, 20 Nov 2024 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144934; cv=none; b=cbah1X0Oeo/PWtgihNli+0IFySO/9EbZ7AUwe+npvjcGUaNKVZCQqR02Pf8E/3FJVsP54iEmxkJJ60Vqm0VLOux9/bqecTlnJ60Q66cmq9xznBckVNEVkFjYzABX6zhaCr1rZGSiwoJC+yjky1MAKnrRf1xc3eNrXLlzqyqM1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144934; c=relaxed/simple;
	bh=leG6j0ba6KZ0GihMSblHUniuzBRKb9IgZCkbQKy/sFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hd3g5c5pdZ08NFTa+aH/pKD1DR0/zUGralcYcgKdja5AER0ETivi1vqc6CTKUy/GhkwtCs5AYpz7FGcJWkHky5qBzJFc5ATi8BPJiYeojrKH3jPAD+vevMU+cl+Rl69znPJPZUk1BEHqrvolRyZ2bsN6OOGWoQfDD65UQdUMMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbwT+1A+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-432d866f70fso2030065e9.2;
        Wed, 20 Nov 2024 15:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732144931; x=1732749731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NxDmkPyz1R+NjIq5BryGn3gO9LikOY0X1+afWkMp3OE=;
        b=gbwT+1A+sA0gI2On4y2xubAmKhvy49bQPGf2g6v0qiWyjMWyBeKqXZBMxZD0EAjvHB
         zv1RfZO+928aWNBNLt9kCFa/tWcBuHGu4JiE26XwKrez30/1Q8/Wy19nFXoajYX1xDfk
         odAx7YlneGQKZqpz7V2arxx+W5bcySD/srcFTwMSXyCjQpDxlox7eX3MVLRjqA+jSrl6
         cqSOx6K+q/fJlHr+obV+d4urmkjOOC7OYWj8RQdTc2oBdULmx/fw1iI7Rbp/2iWzi1C5
         RtOhFDVNXeMl5BiqZfCpVPmqjtgsIpJEWTgoZ59l0Qlco/KUJiCNSbpqCJZty3cELye/
         Afrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144931; x=1732749731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxDmkPyz1R+NjIq5BryGn3gO9LikOY0X1+afWkMp3OE=;
        b=XEWcVD4kecOkBYgDVI7OEZNLC+VTOutpvkbnguSFqXkWb4ORhr37/mogVqmbZXSFUT
         tqGtYPGqHmqu1SH1ip5QD88YftbzDkOH4Yo/OIu5G2s4/wPaJojw17mgKXYHvlnygBBR
         IlLUkH6oBOcZL/aTmUY3PxVUgHiWLjU8ICCCF1rlcteaAXfISD0sU9hAZ61Yg8aGst/D
         dlROoYvmf53uVZH4+pPeuXw+c5Dc9e3ojQgJ3jjfqMIOdLXZCPp1bUN8SJwbX1udgiif
         zOOn2x49Li1bxRlYZ6ccou98TOkOrgt8JIsuGMt3GLPIAOgNem3pOAOD7XPBJg+/bzr1
         xCvA==
X-Forwarded-Encrypted: i=1; AJvYcCUsDoAddH2LJMMnU4inN4XxM6i55JbtbNwaQLZtmS7PuiD8BsB0RYWy6tkngBuwhE9rpfqbickP@vger.kernel.org, AJvYcCWBflK1h7ytTX+h/a1wDETLS6Xb7HSCVNlRUcz4hkMGCLT3sR90RtlEwkocDrTS2pfkGjJSE+KPm1ySeYOWSYTH@vger.kernel.org, AJvYcCWzal737hC73UTvW+UPhR0bPxU29l9s00zLMTwVQmHSIx4KPsUYjhpv4gm93A36eyF3lfbvRKgL8uCSbv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+JAeP+FRQxQ/lKcCpQf33A/RBQwuZjivC5OB4o2P7fg1dKMAh
	fCI1J43RctywYnXceMI+M7TiEMJIOVHyLmKDf3ao7maeYhfPtnhX
X-Gm-Gg: ASbGncv0yaR6Q6jVaZ2ryF1MudBvw1pkC/+4jGPe4DO8H2QeGGttgGjvgNITBOeBnnC
	EcgtWy0Ks53moRU6OSPEXFz/W6EdAwRbBkbiEw/8rWqbBhyjt19jKsw5Ar8MLqtIMIJEDm0TXkw
	9kLNdFcZ+DR2NCX11c3SM4Yp5GdvElXoAQQsAf05wG0zLfXdcOUF+BNOBn4zjwas48KTRkhgiV/
	UdFd55mqYwqooexIR+X/2FvnL5jRIfc47XkTUnCzAD0zXDeR4Q=
X-Google-Smtp-Source: AGHT+IF7ldLMI4H03BzgKRHEJAeSj0TuM5P+qo3KfXyXGRz5AMSUaPavN8NuZMzDfmg22FIUA/m+CA==
X-Received: by 2002:a05:600c:4fd5:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-433489d46ecmr44115475e9.16.1732144930711;
        Wed, 20 Nov 2024 15:22:10 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254905389sm3269631f8f.22.2024.11.20.15.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:22:10 -0800 (PST)
Message-ID: <dc1b37b2-389a-466d-8559-14c496cc9583@gmail.com>
Date: Thu, 21 Nov 2024 01:22:44 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antonio Quartulli <antonio@openvpn.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
 <b7d3ec11-afe4-409c-970e-8bc647364a08@gmail.com> <ZzORATd5hG614dta@hog>
 <e543a3de-44f1-4a2d-90ef-1786e222f0d8@gmail.com> <ZzR5i9sO-xwoJcDB@hog>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <ZzR5i9sO-xwoJcDB@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.11.2024 12:03, Sabrina Dubroca wrote:
> 2024-11-13, 03:37:13 +0200, Sergey Ryazanov wrote:
>> On 12.11.2024 19:31, Sabrina Dubroca wrote:
>>> 2024-11-10, 15:38:27 +0200, Sergey Ryazanov wrote:
>>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>>> An ovpn_peer object holds the whole status of a remote peer
>>>>> (regardless whether it is a server or a client).
>>>>>
>>>>> This includes status for crypto, tx/rx buffers, napi, etc.
>>>>>
>>>>> Only support for one peer is introduced (P2P mode).
>>>>> Multi peer support is introduced with a later patch.
>>>>
>>>> Reviewing the peer creation/destroying code I came to a generic question.
>>>> Did you consider keeping a single P2P peer in the peers table as well?
>>>>
>>>> Looks like such approach can greatly simply the code by dropping all these
>>>> 'switch (ovpn->mode)' checks and implementing a unified peer management. The
>>>> 'peer' field in the main private data structure can be kept to accelerate
>>>> lookups, still using peers table for management tasks like removing all the
>>>> peers on the interface teardown.
>>>
>>> It would save a few 'switch(mode)', but force every client to allocate
>>> the hashtable for no reason at all. That tradeoff doesn't look very
>>> beneficial to me, the P2P-specific code is really simple. And if you
>>> keep ovpn->peer to make lookups faster, you're not removing that many
>>> 'switch(mode)'.
>>
>> Looking at the done review, I can retrospectively conclude that I personally
>> do not like short 'switch' statements and special handlers :)
>>
>> Seriously, this module has a highest density of switches per KLOC from what
>> I have seen before and a major part of it dedicated to handle the special
>> case of P2P connection.
> 
> I think it's fine. Either way there will be two implementations of
> whatever mode-dependent operation needs to be done. switch doesn't
> make it more complex than an ops structure.
> 
> If you're reading the current version and find ovpn_peer_add, you see
> directly that it'll do either ovpn_peer_add_mp or
> ovpn_peer_add_p2p. With an ops structure, you'd have a call to
> ovpn->ops->peer_add, and you'd have to look up all possible ops
> structures to know that it can be either ovpn_peer_add_mp or
> ovpn_peer_add_p2p. If there's an undefined number of implementations
> living in different modules (like net_device_ops, or L4 protocols),
> you don't have a choice.
> 
> xfrm went the opposite way to what you're proposing a few years ago
> (see commit 0c620e97b349 ("xfrm: remove output indirection from
> xfrm_mode") and others), and it made the code simpler.

I checked this. Florian did a nice rework. And the way of implementation 
looks reasonable since there are more than two encapsulation modes and 
handling is more complex than just selecting a function to call.

What I don't like about switches, that it requires extra lines of code 
and pushes an author to introduce a default case with error handling. It 
was mentioned that the module unlikely going to support more than two 
modes. In this context shall we consider ternary operator usage. E.g.:

next_run = ovpn->mode == OVPN_MODE_P2P ?
            ovpn_peer_keepalive_work_p2p(...) :
            ovpn_peer_keepalive_work_mp(...);

>> And back to the hashtable(s) size for the MP mode. 8k-bins table looks a
>> good choice for a normal server with 1-2Gb uplink serving up to 1k
>> connections. But it sill unclear, how this choice can affect installations
>> with a bigger number of connections? Or is this module applicable for
>> embedded solutions? E.g. running a couple of VPN servers on a home router
>> with a few actual connections looks like a waste of RAM. I was about to
>> suggest to use rhashtable due to its dynamic sizing feature, but the module
>> needs three tables. Any better idea?
> 
> For this initial implementation I think it's fine. Sure, converting to
> rhashtable (or some other type of dynamically-sized hashtable, if
> rhashtable doesn't fit) in the future would make sense. But I don't
> think it's necessary to get the patches into net-next.

Make sense. Thanks for sharing these thoughts.

--
Sergey

