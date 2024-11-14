Return-Path: <linux-kselftest+bounces-22012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC17E9C84A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 09:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A290528517A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 08:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28EF1F7550;
	Thu, 14 Nov 2024 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Jkz0aoep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7A1F7077
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571899; cv=none; b=h7Viw1VzQFZCPAjn2zeRmxAaEKB90wn3BmwuSxAlsjQ9YUxWocN4cHdBFwXUGhi+7X5Z5vOsr2OvhDONKEWb5igrPVvWPCGBddksKbK7Y352Ohx7CK4KKV5TTN5otaQTfz0CHPedBD539Eize4t7Sj2V6hzusFpmhSvE0RTdsBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571899; c=relaxed/simple;
	bh=dbIbz3t0cEpW3r7Wy8SR6AhtdgpUROKxXtAsVLqqPLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGuxj6nHNDD5tC4G7exfZ2rJsP3tc3AWGiPHRUkRb/rJAOs+3sDQPLh60pJWXHuyyu2Y+29L0rGmeTzqNf10lUou1ET7Yi6ObdKaIISUgxMhg4/O3AYfaZybGIRQ4QJ0OZNb1knqnQUaFbsVVH3Bmp8n5eY6XBn6UG78uTSzkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Jkz0aoep; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso41981366b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 00:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731571896; x=1732176696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lhi2XcdyoNb77R//XCSb7tUnf+SSZyDwvqz+0gWmS2A=;
        b=Jkz0aoepK2Sj+XF2zGM3m4zzdxjKczXv2SqcpKrUswJOjeurexlOFdeH5NR4KlHAcb
         GEJ6Xwy+p4KTeD2in8Fo+ro2f/ICS8+knYwWmHXtoNkV9+8GMoe3kAVytnyaODvc15Gn
         AVAC0183dhrLUGC7ndFvef3TXmTJ609i/ch4ddgne4Dmhtm82X+SLy+fQ6jpkcnXrIns
         qGmCs9Vi2E6mTcBBDv9qdc1gEH4u+m//q+wNT1zeAH3WFG4MNEDxA1zNFOUooWNRn7xE
         rKyZv1YMkhtIyeWL4AhGkqNYc9gAJl5uzTIAKuBZJ/7omyCv3WqHiFKxtQK3mbM/J3zL
         sceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731571896; x=1732176696;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lhi2XcdyoNb77R//XCSb7tUnf+SSZyDwvqz+0gWmS2A=;
        b=Rjd3/ATBcoMC53aQPkrwlqdDgrp3AChxKqb5X4nFNCQq6lsN4Hhnw6p6R4jfTt1sVT
         CFY+brruJFSKsfyZNSCkZImNXch5QolAxQE2xJ5eUdH2pTFcvbpEUkeR35CQ8g6vs+tI
         5KvgAPpdxIysdomyTa+0XeOIg+VuTteNIC3c0M3ivnqcZiE1gZpX4OsLpVCeQOSYf0Ww
         Ktx49cFJgSW05Wa8eybfa5rCtXKtP5bBntmqYFHYnKlmcBoa4BUXEoWsSbZ9LiiKKlrN
         GgeT4KkcKprpBJWV6S1Zrl0dZQIl9wnb0fEmmkjgY8gGhdSKY3bz/UOdVYaWjySv0OwU
         0t8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUH/7rtSwsQ2EmSym77MwtoMaW4GzBOBXb8Sk6bC0CReQAaPP/lIS+3kveKWBvkE+2+aK6bnu3W1a7utsLZPBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxivd3PqEQ7E8r9OvTP8CtGF+dHJXWkboKLQIb3r9Gyk4q7I3ac
	RtOImmL6LiKOGVkKG2pk1E93n+H/VBljh3cH9MDnQzoSQUy6x/6PocJanFOzJCo=
X-Google-Smtp-Source: AGHT+IHn8GzlUpFSwlHPxZF4Bet/aeH5Llo7f+cI3x6kBTlWSqRynAOg9Usx4t4FBNGnpyRoDEnKxA==
X-Received: by 2002:a17:907:5cb:b0:a9a:1792:f1a with SMTP id a640c23a62f3a-aa1f8043f6amr520374466b.7.1731571895602;
        Thu, 14 Nov 2024 00:11:35 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:3779:22d5:a322:7c13? ([2001:67c:2fbc:1:3779:22d5:a322:7c13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd782sm33977466b.129.2024.11.14.00.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 00:11:35 -0800 (PST)
Message-ID: <2a90f702-3061-46b6-aafa-cf8c1ba3d0de@openvpn.net>
Date: Thu, 14 Nov 2024 09:12:01 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 15/23] ovpn: implement keepalive mechanism
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-15-de4698c73a25@openvpn.net> <ZypfnyfToF1b6YAZ@hog>
 <189dbeea-127a-47e8-84f8-c8cf1cc03536@openvpn.net> <ZzSBG-RPUlpgVFhA@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZzSBG-RPUlpgVFhA@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2024 11:36, Sabrina Dubroca wrote:
> 2024-11-12, 14:20:45 +0100, Antonio Quartulli wrote:
>> On 05/11/2024 19:10, Sabrina Dubroca wrote:
>>> 2024-10-29, 11:47:28 +0100, Antonio Quartulli wrote:
>>>> @@ -105,6 +132,9 @@ void ovpn_decrypt_post(void *data, int ret)
>>>>    		goto drop;
>>>>    	}
>>>> +	/* keep track of last received authenticated packet for keepalive */
>>>> +	peer->last_recv = ktime_get_real_seconds();
>>>
>>> It doesn't look like we're locking the peer here so that should be a
>>> WRITE_ONCE() (and READ_ONCE(peer->last_recv) for all reads).
>>
>> Is that because last_recv is 64 bit long (and might be more than one word on
>> certain architectures)?
>>
>> I don't remember having to do so for reading/writing 32 bit long integers.
> 
> AFAIK it's not just that. The compiler is free to do the read/write in
> any way it wants when you don't specify _ONCE. On the read side, it
> could read from memory a single time or multiple times (getting
> possibly different values each time), or maybe split the load
> (possibly reading chunks from different values being written in
> parallel).

Ok, thanks. Will switch to WRITE/READ_ONE then.

> 
>> I presume we need a WRITE_ONCE also upon initialization in
>> ovpn_peer_keepalive_set() right?
>> We still want to coordinate that with other reads/writes.
> 
> I think it makes sense, yes.

ACK

[...]
> 
>>>> +	/* check for peer timeout */
>>>> +	expired = false;
>>>> +	timeout = peer->keepalive_timeout;
>>>> +	delta = now - peer->last_recv;
>>>
>>> I'm not sure that's always > 0 if we finish decrypting a packet just
>>> as the workqueue starts:
>>>
>>>     ovpn_peer_keepalive_work
>>>       now = ...
>>>
>>>                                          ovpn_decrypt_post
>>>                                            peer->last_recv = ...
>>>
>>>     ovpn_peer_keepalive_work_single
>>>       delta: now < peer->last_recv
>>>
>>
>> Yeah, there is nothing preventing this from happening...but is this truly a
>> problem? The math should still work, no?
> 
> We'll fail "delta < timeout" (which we shouldn't), so we'll end up
> either in the "expired = true" case, or not updating
> keepalive_recv_exp. Both of these seem not ideal.

delta is signed, so it'll end up being a negative value and "delta < 
timeout" should not fail then. Unless I am missing something.

Anyway, this was just an exercise to understand what was going on.
I already changed the code as per your suggestion (the fact that we are 
still discussing this chunk proves that it needed to be simplified :))

> 
>>
>> However:
>>
>>>
>>>
>>>> +	if (delta < timeout) {
>>>> +		peer->keepalive_recv_exp = now + timeout - delta;
>>>
>>> I'd shorten that to
>>>
>>>       peer->keepalive_recv_exp = peer->last_recv + timeout;
>>>
>>> it's a bit more readable to my eyes and avoids risks of wrapping
>>> values.
>>>
>>> So I'd probably get rid of delta and go with:
>>>
>>>       last_recv = READ_ONCE(peer->last_recv)
>>>       if (now < last_recv + timeout) {
>>>       	peer->keepalive_recv_exp = last_recv + timeout;
>>>       	next_run1 = peer->keepalive_recv_exp;
>>>       } else if ...
>>>
>>>> +		next_run1 = peer->keepalive_recv_exp;
>>>> +	} else if (peer->keepalive_recv_exp > now) {
>>>> +		next_run1 = peer->keepalive_recv_exp;
>>>> +	} else {
>>>> +		expired = true;
>>>> +	}
>>
>> I agree this is simpler to read and gets rid of some extra operations.
>>
>> [note: I took inspiration from nat_keepalive_work_single() - it could be
>> simplified as well I guess]
> 
> Ah, ok. I wanted to review this code when it was posted but didn't
> have time :(

It can still be fixed ;)


Thanks.
Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


