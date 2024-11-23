Return-Path: <linux-kselftest+bounces-22469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116AC9D6B84
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 22:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8B7B21387
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 21:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCF1165EFC;
	Sat, 23 Nov 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwhOaMv2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A87156F45;
	Sat, 23 Nov 2024 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732395924; cv=none; b=U10MMNf9QqUdan/mSd4dW6CiAtmcy/CxhwcSbeIcRUaehRWC0StAo6SutVXUss3OMxQKzX73W+xDPSUERB6z8YobZg8RdEWx3eg0P71WsB9oN11uhof+Nla+HtvvJLKY+WCokpYJ6TpSgk/0Cf86RgmWhJLmzalmnLmnDu4oizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732395924; c=relaxed/simple;
	bh=lFrmQIF99tvlGJBEwKu2+j83YqEYB7LOzIyhVFUlGPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWiFwr5AESlyjW1JjY+Czga2TrzpNq0qsHwjSc+jSZOgB44PbqhdIxXgtKtPDOfVQguWKEec+rYjYgwUnFuUBt4ihhJNhmUHyrK9dliCVuzb1oYX3Nfpe8lKGCWB8aIlxWdp6dVLYlIjkEcvfsBxIqQynbtIUsEnmoN/Nx3/0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwhOaMv2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3824a8a5c56so2217652f8f.3;
        Sat, 23 Nov 2024 13:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732395921; x=1733000721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OwhHFRff8gph+NM7VDcWm8LJ5lFFl4p2wcgVr3VMUiQ=;
        b=HwhOaMv2vwJ0Ut84zx/i4VXBztK8+uzZEXsTsb7kyjr45xJDM97MiIYbsD9c0e0wSB
         71aVhJLMb9Jp/oqtIS8fX9WK47P9uKxzJUjHcKQ4EExxyZqpM66QMD/U9y0s8Z3VKibM
         bXzRpdclA3iLZyl5W8lQXhcbL7ELV+Z+ueR9EqTrGn0A2jqy3zmQ+/YcRuA+rRT1omy4
         1AqbHWjOBAaLMIrD8sH4SaqGVSzqNyQ8qxqf4gt0nDJ3ZoL3ahsVq+SWT5Z6dkbvc0mr
         D8Vtj6KCBwzHtRJU+3bZNW1W5z1OMVwmPH/AFdGWJygNeaNmF284OXPekowKMk5E3Kwv
         nDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732395921; x=1733000721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwhHFRff8gph+NM7VDcWm8LJ5lFFl4p2wcgVr3VMUiQ=;
        b=MdB9JfG/Ulcgi0l2CzRFtxF+NLypktJJT5buXZUhT9KV+km2xm9FINzsjrQCh3I6+r
         jZlwu4mCUP4bM7qI8Ia2ve9linXa56PrQ3A0l9Lti0wQVnXglg2x007i0A3E4zjQR8kQ
         0nAF16IyAOJEdn1DybUIBV2V4jOC7Nm9mVXUeHwQmaqHyzQ6mZ9eb9Y//Fise5ouHxpV
         QS+ec/8oX4yrPxksDy/oerbXbDQzq2/OczCiqECLY2ohksuN8xhzXfgz4ntpKDRFBcP4
         PrUGYijaKuSXTF3rGvrZk9ZeaOLjOKOvt8BuqxY7ESD4rOnCtilBe0Y46EfmDGYorT4m
         +RXA==
X-Forwarded-Encrypted: i=1; AJvYcCW+UoRYgUFp2ZSjMJh7tyEzNmvQAcwfh7KL1UeUpYtBIHpsilPQ3U0vu7fUT44wy0dAfxyJmRWlZgVbvRE=@vger.kernel.org, AJvYcCXLMnKdbMw+TsfxNA+ZiT+Vb9ApTk2Q3aHoShxJ4nUSCxLpLHoTezhoMLOEaAny3hnBoA7Vgl5O@vger.kernel.org, AJvYcCXllU5FKkH8RshYffOZMLgyQmi30bJSYDE5TWCdxTHzK6uMxE8UAMJn06eGOBoBQCJGWzAOw2qCW72bODy++Y/4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe5pSeno2mQQPVM/mwWYn1IJsfFIHxGQlmVojLLhS6NwDWeEgq
	vTkjkR4+wYuzR9+xT7Fv39AKB94ZVgeLBvxqLCC3mmLJaXD+CWcs
X-Gm-Gg: ASbGncth0gqcBlRb80/Yc+6vYzNhEyQWY6Pwp096Bry7iXxtQGaGiQUqmcc2I34c9FV
	GhSzYTcPcRCiRa3Am6OgdTHlvmnbNI+Sjahy30ExXnwAnwigwfyv+5gucEEW0ZHw2DFNl4lREz1
	01ul1KGndPSWwu0CWrKScTkJhZwvYsW2qQLI1bQl1rk9PuG3+EHmT0U0Of53gHmrA4eP6nITxZl
	k+c8cN0+Av/l7BMTkqAJKRUwqAvC2bLGBc+TeybWzM1MhXnEk4=
X-Google-Smtp-Source: AGHT+IFl9uTIBNPR+FGLhcjSU/OABqXj/9lc0b55pXFjEcAbdgdPPy+tu6Ocfy/Nw+I/Z+CXrUESgg==
X-Received: by 2002:a05:6000:1449:b0:382:2f62:bd3e with SMTP id ffacd0b85a97d-38260b6b641mr6574257f8f.27.1732395920715;
        Sat, 23 Nov 2024 13:05:20 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe901esm6227213f8f.87.2024.11.23.13.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 13:05:20 -0800 (PST)
Message-ID: <a1d70ccf-9731-4ec1-b4c3-606ee7073c18@gmail.com>
Date: Sat, 23 Nov 2024 23:05:56 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
To: Antonio Quartulli <antonio@openvpn.net>,
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
 <52661fed-f521-4cdc-b9e1-b4f3fa292e78@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <52661fed-f521-4cdc-b9e1-b4f3fa292e78@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.11.2024 23:23, Antonio Quartulli wrote:
> On 21/11/2024 00:22, Sergey Ryazanov wrote:
>> On 13.11.2024 12:03, Sabrina Dubroca wrote:
>>> 2024-11-13, 03:37:13 +0200, Sergey Ryazanov wrote:
>>>> On 12.11.2024 19:31, Sabrina Dubroca wrote:
>>>>> 2024-11-10, 15:38:27 +0200, Sergey Ryazanov wrote:
>>>>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>>>>> An ovpn_peer object holds the whole status of a remote peer
>>>>>>> (regardless whether it is a server or a client).
>>>>>>>
>>>>>>> This includes status for crypto, tx/rx buffers, napi, etc.
>>>>>>>
>>>>>>> Only support for one peer is introduced (P2P mode).
>>>>>>> Multi peer support is introduced with a later patch.
>>>>>>
>>>>>> Reviewing the peer creation/destroying code I came to a generic 
>>>>>> question.
>>>>>> Did you consider keeping a single P2P peer in the peers table as 
>>>>>> well?
>>>>>>
>>>>>> Looks like such approach can greatly simply the code by dropping 
>>>>>> all these
>>>>>> 'switch (ovpn->mode)' checks and implementing a unified peer 
>>>>>> management. The
>>>>>> 'peer' field in the main private data structure can be kept to 
>>>>>> accelerate
>>>>>> lookups, still using peers table for management tasks like 
>>>>>> removing all the
>>>>>> peers on the interface teardown.
>>>>>
>>>>> It would save a few 'switch(mode)', but force every client to allocate
>>>>> the hashtable for no reason at all. That tradeoff doesn't look very
>>>>> beneficial to me, the P2P-specific code is really simple. And if you
>>>>> keep ovpn->peer to make lookups faster, you're not removing that many
>>>>> 'switch(mode)'.
>>>>
>>>> Looking at the done review, I can retrospectively conclude that I 
>>>> personally
>>>> do not like short 'switch' statements and special handlers :)
>>>>
>>>> Seriously, this module has a highest density of switches per KLOC 
>>>> from what
>>>> I have seen before and a major part of it dedicated to handle the 
>>>> special
>>>> case of P2P connection.
>>>
>>> I think it's fine. Either way there will be two implementations of
>>> whatever mode-dependent operation needs to be done. switch doesn't
>>> make it more complex than an ops structure.
>>>
>>> If you're reading the current version and find ovpn_peer_add, you see
>>> directly that it'll do either ovpn_peer_add_mp or
>>> ovpn_peer_add_p2p. With an ops structure, you'd have a call to
>>> ovpn->ops->peer_add, and you'd have to look up all possible ops
>>> structures to know that it can be either ovpn_peer_add_mp or
>>> ovpn_peer_add_p2p. If there's an undefined number of implementations
>>> living in different modules (like net_device_ops, or L4 protocols),
>>> you don't have a choice.
>>>
>>> xfrm went the opposite way to what you're proposing a few years ago
>>> (see commit 0c620e97b349 ("xfrm: remove output indirection from
>>> xfrm_mode") and others), and it made the code simpler.
>>
>> I checked this. Florian did a nice rework. And the way of 
>> implementation looks reasonable since there are more than two 
>> encapsulation modes and handling is more complex than just selecting a 
>> function to call.
>>
>> What I don't like about switches, that it requires extra lines of code 
>> and pushes an author to introduce a default case with error handling. 
>> It was mentioned that the module unlikely going to support more than 
>> two modes. In this context shall we consider ternary operator usage. 
>> E.g.:
> 
> the default case can actually be dropped. That way we can have the 
> compiler warn when one of the enum values is not handled in the switch 
> (should there be a new one at some point).
> However, the default is just a sanity check against future code changes 
> which may introduce a bug.
> 
>>
>> next_run = ovpn->mode == OVPN_MODE_P2P ?
>>             ovpn_peer_keepalive_work_p2p(...) :
>>             ovpn_peer_keepalive_work_mp(...);
> 
> I find this ugly to read :-)

Yeah. Doesn't look pretty as well.

Just to conclude the discussion. Considering what we discussed here and 
the Sabrina's point regarding the trampoline penalty for indirect 
invocation, we do not have a better solution for now other than using 
switches everywhere.

--
Sergey

