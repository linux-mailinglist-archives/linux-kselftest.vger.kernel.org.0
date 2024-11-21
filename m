Return-Path: <linux-kselftest+bounces-22419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902AC9D54AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 22:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E528247B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 21:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A851CB331;
	Thu, 21 Nov 2024 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UOloufYV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D51B1C242D
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224192; cv=none; b=tFRNugmw2oA1ffiIucrM5DDuRJAmqQCtqCUZhz57THg1/8RE2sFt+RspQyJXQfr0mFWnx9NaTjOWUIC85T+7r50cmgWVp7qhLUqRsuS4OGloa7lMAS9jYdkNLsE7fmZmoKoRFwCVNzDH9sZPdeK5wuYrOF2KDZaR4EsenvSUmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224192; c=relaxed/simple;
	bh=qywTFtD+0BzuPwD45lQta1Z8qCtNKrwLzH2n/AAZxJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwNLCAB2OkKDHcJVjoU7gtNbu9753xj2nbngkdivhRoQGv1igu3eRzjY6CdMnPsrQ1kBvPU/xXCSfn7G5SWsyWtZHloFh7bC7YEnbnQedOWJVU0RCI60uLaNe8+pKEk+q07M/YKiNz7tUy5SPnjge9eYIF4U4vNUs4I4nbqTCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UOloufYV; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so26103691fa.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 13:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732224188; x=1732828988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QuEuA2H3TWnIAf5kbxkDhfjOrhOItH/ikPCn+mNuBSA=;
        b=UOloufYVlw1TfRWIE6x1SbjxXnWauPoymuReaet4eIZrLNO9XN5Gnb9Jjh3yJ41dSt
         7cNiB0Esg/3fCXz3XVJK6Q7NTiFjMaoSFKeejEvEpJeJmK3dcd2Umws5lJxOHI5BNGN7
         cOlSlrikbaHhNfw5H+E6Okpmz4SAlFWxanu7FMYHhiWe9lHUH26b07dzhBVzs4CrQDZS
         vvSMurCU+B2lU+8aKARvhOKUGohEV81O+Trd/CDkONTtkdXLsa9ATDGKAOzrhL6N5nwZ
         1rfge98Bt9BbAfm9SuqtkBtV4O6qsCKdktVbXxC0bqRnl3ad20C3nSWNmAllKfUsQJWI
         g9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732224188; x=1732828988;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuEuA2H3TWnIAf5kbxkDhfjOrhOItH/ikPCn+mNuBSA=;
        b=Nc8keAG33Fau43WbQ975DnpwF6N6vlmiXXwIRUs9oD/88B2SwMxE9BP4nkeeANdhfn
         pYuArGd7j2kRW+FrrgDWpSl2HqoC3wSecdYCjotkyDa2Qn/D9aP1+2nz1mrLDiuMeWyV
         DiLjMkpsikL9+8wU4ozjW01xyPKTu2bVU4WQVws1TftZIFNEq/5wUVejuPkkdShkwDbC
         Ar9U/SKczfYgg+lIpqJ9o5nBPaSxput4w0ffkDo6B87TjEaRssjp6NW+VuigYpvARuf2
         STz8fN/iDwDqeZQhVcXKYW5s97zET5bMDiYG+ABuDQ+RNC845bo8CAFFksFVqzDYwH6p
         tvrw==
X-Forwarded-Encrypted: i=1; AJvYcCUjRR9SAbNCUuGzdvB89HJaMKq1+hCk5JZpoHzGvnjDbqr9toNmucOJpw6CTxDI3pb0gzl4ze10rYjfDousCts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSZ4DvklNi/JPYEM2fSnvnL+zJ/NMO0bHhEaLeU2j+3h34LRv
	A1P0g1MQTfIsn6PuckR6Jafc2tXfVOdUh3nqTJcEDLLSvbZToKPHeqSkffI5brM=
X-Gm-Gg: ASbGncvOGhgNkJt/n2K6VD4hbSjYvW/52MVJkVaKSmtoo23lm2q+KbbR9TYZYRJZ/9U
	br7jQcVn8M84Rn8gIfrBUgGzl4pUwdr6tNMN6tQ4iz3a/mL85Nsc926wsa6WPzg/izKwezqhJIb
	PGpUqHBlEyWLiTfCw5A6VAAmZs61WMzHGk+HTJ9eJ3H+sn9lSYhTYR73oWfhu9HCMpwX27n2WT/
	j8cwkiiJttm6Ush9RTAVsFFPjU/gfuqrMU928oCVch1oihHMDJ108vIya9FuubSfR6i1EQcfDNr
	cHe4/tvj3g==
X-Google-Smtp-Source: AGHT+IFxBGMOFADHnq6mp//A/vFyhDz1w54VlnkH3inEJ0BvqI+GY5tV6VrB71LNvlVlewsvGohUcQ==
X-Received: by 2002:a2e:bc16:0:b0:2fa:d604:e519 with SMTP id 38308e7fff4ca-2ffa7106413mr1944051fa.11.1732224188433;
        Thu, 21 Nov 2024 13:23:08 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f55:fe70:5486:7392? ([2001:67c:2fbc:1:f55:fe70:5486:7392])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fb6asm15223466b.92.2024.11.21.13.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 13:23:07 -0800 (PST)
Message-ID: <52661fed-f521-4cdc-b9e1-b4f3fa292e78@openvpn.net>
Date: Thu, 21 Nov 2024 22:23:36 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
 <b7d3ec11-afe4-409c-970e-8bc647364a08@gmail.com> <ZzORATd5hG614dta@hog>
 <e543a3de-44f1-4a2d-90ef-1786e222f0d8@gmail.com> <ZzR5i9sO-xwoJcDB@hog>
 <dc1b37b2-389a-466d-8559-14c496cc9583@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <dc1b37b2-389a-466d-8559-14c496cc9583@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/11/2024 00:22, Sergey Ryazanov wrote:
> On 13.11.2024 12:03, Sabrina Dubroca wrote:
>> 2024-11-13, 03:37:13 +0200, Sergey Ryazanov wrote:
>>> On 12.11.2024 19:31, Sabrina Dubroca wrote:
>>>> 2024-11-10, 15:38:27 +0200, Sergey Ryazanov wrote:
>>>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>>>> An ovpn_peer object holds the whole status of a remote peer
>>>>>> (regardless whether it is a server or a client).
>>>>>>
>>>>>> This includes status for crypto, tx/rx buffers, napi, etc.
>>>>>>
>>>>>> Only support for one peer is introduced (P2P mode).
>>>>>> Multi peer support is introduced with a later patch.
>>>>>
>>>>> Reviewing the peer creation/destroying code I came to a generic 
>>>>> question.
>>>>> Did you consider keeping a single P2P peer in the peers table as well?
>>>>>
>>>>> Looks like such approach can greatly simply the code by dropping 
>>>>> all these
>>>>> 'switch (ovpn->mode)' checks and implementing a unified peer 
>>>>> management. The
>>>>> 'peer' field in the main private data structure can be kept to 
>>>>> accelerate
>>>>> lookups, still using peers table for management tasks like removing 
>>>>> all the
>>>>> peers on the interface teardown.
>>>>
>>>> It would save a few 'switch(mode)', but force every client to allocate
>>>> the hashtable for no reason at all. That tradeoff doesn't look very
>>>> beneficial to me, the P2P-specific code is really simple. And if you
>>>> keep ovpn->peer to make lookups faster, you're not removing that many
>>>> 'switch(mode)'.
>>>
>>> Looking at the done review, I can retrospectively conclude that I 
>>> personally
>>> do not like short 'switch' statements and special handlers :)
>>>
>>> Seriously, this module has a highest density of switches per KLOC 
>>> from what
>>> I have seen before and a major part of it dedicated to handle the 
>>> special
>>> case of P2P connection.
>>
>> I think it's fine. Either way there will be two implementations of
>> whatever mode-dependent operation needs to be done. switch doesn't
>> make it more complex than an ops structure.
>>
>> If you're reading the current version and find ovpn_peer_add, you see
>> directly that it'll do either ovpn_peer_add_mp or
>> ovpn_peer_add_p2p. With an ops structure, you'd have a call to
>> ovpn->ops->peer_add, and you'd have to look up all possible ops
>> structures to know that it can be either ovpn_peer_add_mp or
>> ovpn_peer_add_p2p. If there's an undefined number of implementations
>> living in different modules (like net_device_ops, or L4 protocols),
>> you don't have a choice.
>>
>> xfrm went the opposite way to what you're proposing a few years ago
>> (see commit 0c620e97b349 ("xfrm: remove output indirection from
>> xfrm_mode") and others), and it made the code simpler.
> 
> I checked this. Florian did a nice rework. And the way of implementation 
> looks reasonable since there are more than two encapsulation modes and 
> handling is more complex than just selecting a function to call.
> 
> What I don't like about switches, that it requires extra lines of code 
> and pushes an author to introduce a default case with error handling. It 
> was mentioned that the module unlikely going to support more than two 
> modes. In this context shall we consider ternary operator usage. E.g.:

the default case can actually be dropped. That way we can have the 
compiler warn when one of the enum values is not handled in the switch 
(should there be a new one at some point).
However, the default is just a sanity check against future code changes 
which may introduce a bug.

> 
> next_run = ovpn->mode == OVPN_MODE_P2P ?
>             ovpn_peer_keepalive_work_p2p(...) :
>             ovpn_peer_keepalive_work_mp(...);

I find this ugly to read :-)
The switch is much more elegant and straightforward.

Do you agree this is getting more into a bike shed coloring discussion? :-D

Since there is not much gain in changing approach, I think it is better 
if the maintainer picks a style that he finds more suitable (or simply 
likes more). no?

> 
>>> And back to the hashtable(s) size for the MP mode. 8k-bins table looks a
>>> good choice for a normal server with 1-2Gb uplink serving up to 1k
>>> connections. But it sill unclear, how this choice can affect 
>>> installations
>>> with a bigger number of connections? Or is this module applicable for
>>> embedded solutions? E.g. running a couple of VPN servers on a home 
>>> router
>>> with a few actual connections looks like a waste of RAM. I was about to
>>> suggest to use rhashtable due to its dynamic sizing feature, but the 
>>> module
>>> needs three tables. Any better idea?
>>
>> For this initial implementation I think it's fine. Sure, converting to
>> rhashtable (or some other type of dynamically-sized hashtable, if
>> rhashtable doesn't fit) in the future would make sense. But I don't
>> think it's necessary to get the patches into net-next.

Agreed. It's in the pipe (along with other features that I have already 
implemented), but it will come later.

Regards,

> 
> Make sense. Thanks for sharing these thoughts.
> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.


