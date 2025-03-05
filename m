Return-Path: <linux-kselftest+bounces-28259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA82A4F253
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 01:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015D4188F668
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0589F4ED;
	Wed,  5 Mar 2025 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KDKq6ARw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585ECD2FF
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133993; cv=none; b=EheB7j7+mg5Iapdc27Nt+mkLWierqYlyqYarxOasXeZghInNKOwL45Rlz7q8PhKJG1p7WJ4HBqqkXMCy8mZ/UqqnyDTcQjKbyLqXK0jmJlHx2Z2nxbukB46Sfy+WEj5jlmmBeKm52j/74E9qoTElypby2pp9HLQ9slpxS9ysAMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133993; c=relaxed/simple;
	bh=ZK68s+96odAp9mghpE9eTFA98cGvGR3nuInRJl6fJPM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uSCQQVbSf6IqArUAZPx1TDRs51GNKUif7MFWrS1skTAhKTjNGE6EGUqOYppI/sBArGwNZkfoHvzZah90ei5JRUwOtyCS1JIchXFZH2hk06Zy0Ztgiq0LZWdBHxBqbUaR++4mHmHMTIVB4V18GHzdag5u0L4aSiWDjZG7w9REf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KDKq6ARw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb379so4779628a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 16:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741133987; x=1741738787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6D4CeO3v05+ZBtc5CEcrGKWIhNna/EuPVsXiAB6x+mw=;
        b=KDKq6ARw53HPLVILzGlRUebxTCAbzMQ9Owvkc33Smwfmk6U+evXkvQTWY8zGBFNpCb
         l60YZokhss/Y0jrPpjaEDHY6LjXbdYNeQGq5XzvvgLLiNH1VTiWpEeubEBx45a6sNukm
         YNvhPn97d3GwbLa+TLTqMYPB/ahiXIqbLSEsnVTWi0NIbbrAssO+LUeQ3ltopNlDypz4
         pqpsT2fdG/c+1VhtHGLWJtWcCJvY407coN2RIBqatmyFqv6eDdzsqpfRA4LFtocAmsbw
         qH757tCFzP6W2GIfV1y68ALbVMU/h0rHLWmMGTMxpMG6cxnwAKVQJLaEOup1VLXM6Upy
         U+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133987; x=1741738787;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6D4CeO3v05+ZBtc5CEcrGKWIhNna/EuPVsXiAB6x+mw=;
        b=VYdHhV6Ko4yYWqXX2flS4sh+XRgng68MUFSzsAuJskxbH8rtYMHitFWg5YGW1OMnzw
         Gp8UgQytC4QlUXpJ6MmD273DjQVws9CUSMuo3ikMwTh1lKAs6T5QDzqgLI+Lx55dkCuK
         8d6TksZ8g1W40VngbZpHqaHVB9aom4erXbSjF4fsoxDciiFVHfeUQP27HgS8NHGlNPGR
         eHRRqMonsi7TK7ItrmCjhAfCIk3puqkVlzms0Qr7TfPFt80t70KZUWe8NfplzexhwQq2
         3Tpu7keeUJYs1qldQnZcl0I+XE5rdyDT4M+oJMtV2h8eZfFFxH+nj8c5I0G6HGRt9CAp
         k+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXuIBQk8MXozOGCeRhAIj83N9RioNHNIFWr5dGxcVGjP0enPISRsF14HHLC2C0NnYdWgR1iJ5278odbOo53G7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YycmOOpIu6oBEOIy3oAV76OOe2Ww8VvlTCEUgZrB2SfMBKoyxq0
	CSlKd0j1diXnrzbjJ3J9r4bKYHl+g8aLXbKLoATbaMMop6XYF2v0xAdLxzkE0Hk=
X-Gm-Gg: ASbGncvXX+D8+6hgS0vP/ddtnZQJ5rJ8Xn5LxfRpkwSx0BlKCRs0+kw1JsmqhTfWROB
	CcK08u8SuzpKFE37dAPJRFvPdOwTdVTq9Bi2A3ll7qsm3WVyjb6Qif6FwHckSAVTNeoo7+nbN+d
	PYfzm0jnX8p0aUq9hfIkNEO2Ifm2cBFbRD8wYLm4iCbcE6YgvQtfpNzQiO2rsvS61aB9XiWibqU
	bYyyy1ushylgjDOel+1NdYHokAB0pehjhKaVqWjrHx73Ay9wYQF8bZgeZBroyAyE2B2X6V0uP47
	fCAnbYssvdaSXkb4/QBpZZbYMxo1KORPCnQvxz3dPNs6s/SPhv9TzjvtX3lh3W78v4c3g2mDZ3L
	kHFJ5qZA=
X-Google-Smtp-Source: AGHT+IGUKpII5ucG6P2P0Im4u16sx6ubJmJfDIB+rxJ8m//Mn7nLKISpOLu5ZLftwyo3mtLq9b8Kug==
X-Received: by 2002:a05:6402:5203:b0:5e1:9725:bb3e with SMTP id 4fb4d7f45d1cf-5e59f4869femr1173648a12.28.1741133987449;
        Tue, 04 Mar 2025 16:19:47 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:2107:3d4f:958a:fa5f? ([2001:67c:2fbc:1:2107:3d4f:958a:fa5f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e50fcfe981sm6051928a12.27.2025.03.04.16.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 16:19:45 -0800 (PST)
Message-ID: <82aa82df-e378-4cf8-a296-1ebd1ab14413@openvpn.net>
Date: Wed, 5 Mar 2025 01:19:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 18/24] ovpn: add support for peer floating
From: Antonio Quartulli <antonio@openvpn.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-18-d3cbb74bb581@openvpn.net> <Z8dIXjwZ3QmiEcd-@hog>
 <9c919407-fb91-48d7-bf2d-8437c2f3f4da@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <9c919407-fb91-48d7-bf2d-8437c2f3f4da@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 00:19, Antonio Quartulli wrote:
> On 04/03/2025 19:37, Sabrina Dubroca wrote:
>> 2025-03-04, 01:33:48 +0100, Antonio Quartulli wrote:
>>> A peer connected via UDP may change its IP address without reconnecting
>>> (float).
>>
>> Should that trigger a reset of the peer->dst_cache? And same when
>> userspace updates the remote address? Otherwise it seems we could be
>> stuck with a cached dst that cannot reach the peer.
> 
> Yeah, that make sense, otherwise ovpn_udpX_output would just try over 
> and over to re-use the cached source address (unless it becomes 
> unavailable).

I spent some more time thinking about this.
It makes sense to reset the dst cache when the local address changes, 
but not in case of float (remote address changed).

That's because we always want to first attempt sending packets using the 
address where the remote peer sent the traffic to.
Should that not work (quite rare), then we have code in ovpn_udpX_output 
that will reset the cache and attempt a different address.


Cheers,


-- 
Antonio Quartulli
OpenVPN Inc.


