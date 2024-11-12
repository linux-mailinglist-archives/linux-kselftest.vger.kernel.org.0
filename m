Return-Path: <linux-kselftest+bounces-21850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C2A9C52D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 11:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF961F2144E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 10:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870CC20DD66;
	Tue, 12 Nov 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="N+6BIUfT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DBF189B9F
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406342; cv=none; b=SicICMIvTeEOkEAFybKXbOIK+XA7ZcJ5pZwd7ln84ux11XvzH2wu5bBrL/i4yhT9GipttTC2Mv5u4jJHXCEZr1suvIm1FT0BXzW2qm9qJULjd43JwlRooQ19zelJeuxhQlNJ/EDuddtRS9kKusGfEuFOCmAUP7QBMTioHMtTBY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406342; c=relaxed/simple;
	bh=o9ZT2BfINZiN+DFUgw3tTlBBxGPfQ1Yrr9gMZ8OE3YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFTS9iYRIgyBT6a4Y5Yq9phIXzo1QwbQ9Ba8BDrg9khLCb1rFOjngLa5i8ByUCUzCQyrFXxiLdPtGof0uJPRqNH0oTggws+ng+lPvYP8XmH8vO2AgM36iNKgMmaQ8XTTIVolDMPJBRj+ikNJmwW8XPi647O+D17vnWcAGUfXPEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=N+6BIUfT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa15ede48e0so119998766b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 02:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731406338; x=1732011138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3tHE0oTRLSEliz0G8uefC0ruhg6YgFjDGMCm96JQBjc=;
        b=N+6BIUfTZmO1UBtdZxWhHf5o3c+1nju6VerhhtKroe5hMEtTJ7YmGLtercyGQlJHWM
         OUqosr3y21hcofE4JEgeIbr+hsmsgXY4SOU40IFo4iWMLNkoRWcnCwTtMkpWHymqAunk
         iP2+tpR5nOgto1zv9fKnx50HoAqlxq+c8ren3MZVejOq71CvQBBZC5VXyvFS76frRQey
         mxl3PuUijFeEkR056wUT6N1A/z28GK/Dzso1rb2LnhxusmKe9m4TchA7d5Gtn+QHZ8G3
         2fBnKNOO9jXEmjM3XD0nL62avcLTJ8ChBe6o4YjAhbW/NvjlKyYHSe+EKXOZdlIi1x9n
         p2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731406338; x=1732011138;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tHE0oTRLSEliz0G8uefC0ruhg6YgFjDGMCm96JQBjc=;
        b=ltOK2R+yDToXXYRm3w6iSIRsC/nn7aqqvOKTnZ5RGGmuM0z0QGuVldR6SYJpN/qtCG
         1rHSza3sH7Hw+0LGSkxyIFoQLvm9ePQdbbRlCJwSqsfgTHjEyv9QLSNPuBAyAbMahQuY
         eWI5T1KvsnoGbKWEUnz16kUYONwqColHzzuQD4Tte+4Pwgau0qhnD9y3gEyRybiIeIaA
         1ztXcC6p1lp2b8uk4wcLX9fW2szHq1PB4dMrSgRSA85fn+HA7c9ifIG+Vm8+6RbPOW+z
         VDhxc1qD0MsoHTX6bdtIQcN3PznzmHEe3puk31zwgYOH3ectlFZTH3DkRsc/0c6tp0Tw
         NApw==
X-Forwarded-Encrypted: i=1; AJvYcCXfsjh+YPfU/hX5Acrv5N9rYf1hAqaaIvz1fXjROXmG58sxfu9byJq/JBvLWf4MGSGhtk5iGCFT6pzGkOcMc1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/boZq0LB3B9+fbkp+ofDSDBKGdpbIWPWC4nTGgIZlgpA4Jlkl
	WCZNS6exUZAdYQzvZ8tLTsoeuIVbGHaB/f3Vs8JdQmXwC3UMK3z/ypTEhLmY/W4=
X-Google-Smtp-Source: AGHT+IHYbDn7N6wRklA2XlvZRyZHnFXIvOVsCTI7Ehg3j9PF6abCxcO4AnyIsVdRhInJg9PFrYHcnw==
X-Received: by 2002:a17:906:c112:b0:a99:6036:90a with SMTP id a640c23a62f3a-a9eeff0d262mr1551241466b.14.1731406338322;
        Tue, 12 Nov 2024 02:12:18 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:b088:6400:3195:f3e9? ([2001:67c:2fbc:1:b088:6400:3195:f3e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9f42d85789sm136956866b.13.2024.11.12.02.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 02:12:17 -0800 (PST)
Message-ID: <ea28f799-cd93-4b69-86b0-28bc03217d0c@openvpn.net>
Date: Tue, 12 Nov 2024 11:12:41 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net> <ZyJgs6Vrvzji8qvS@hog>
 <4df15a91-4bcb-49d8-be78-28c71036ba8a@openvpn.net> <ZyoZwIOno_U_yMPF@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZyoZwIOno_U_yMPF@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2024 14:12, Sabrina Dubroca wrote:
> 2024-10-30, 21:47:58 +0100, Antonio Quartulli wrote:
>> On 30/10/2024 17:37, Sabrina Dubroca wrote:
>>> 2024-10-29, 11:47:19 +0100, Antonio Quartulli wrote:
>>>> +static void ovpn_peer_release(struct ovpn_peer *peer)
>>>> +{
>>>> +	ovpn_bind_reset(peer, NULL);
>>>> +
>>>> +	dst_cache_destroy(&peer->dst_cache);
>>>
>>> Is it safe to destroy the cache at this time? In the same function, we
>>> use rcu to free the peer, but AFAICT the dst_cache will be freed
>>> immediately:
>>>
>>> void dst_cache_destroy(struct dst_cache *dst_cache)
>>> {
>>> [...]
>>> 	free_percpu(dst_cache->cache);
>>> }
>>>
>>> (probably no real issue because ovpn_udp_send_skb gets called while we
>>> hold a reference to the peer?)
>>
>> Right.
>> That was my assumption: release happens on refcnt = 0 only, therefore no
>> field should be in use anymore.
>> Anything that may still be in use will have its own refcounter.
> 
> My worry is that code changes over time, assumptions are forgotten,
> and we end up with code that was a bit odd but safe not being safe
> anymore.

Yeah, makes sense.
I'll move the call to dst_cache_destroy() and to kfree(peer) in a RCU 
callback.

Thanks!

> 
>>>
>>>> +	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
>>>> +	kfree_rcu(peer, rcu);
>>>> +}
>>>
>>>
>>> [...]
>>>> +static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
>>>> +			     enum ovpn_del_peer_reason reason)
>>>> +	__must_hold(&peer->ovpn->lock)
>>>> +{
>>>> +	struct ovpn_peer *tmp;
>>>> +
>>>> +	tmp = rcu_dereference_protected(peer->ovpn->peer,
>>>> +					lockdep_is_held(&peer->ovpn->lock));
>>>> +	if (tmp != peer) {
>>>> +		DEBUG_NET_WARN_ON_ONCE(1);
>>>> +		if (tmp)
>>>> +			ovpn_peer_put(tmp);
>>>
>>> Does peer->ovpn->peer need to be set to NULL here as well? Or is it
>>> going to survive this _put?
>>
>> First of all consider that this is truly something that we don't expect to
>> happen (hence the WARN_ON).
>> If this is happening it's because we are trying to delete a peer that is not
>> the one we are connected to (unexplainable scenario in p2p mode).
>>
>> Still, should we hit this case (I truly can't see how), I'd say "leave
>> everything as is - maybe this call was just a mistake".
> 
> Yeah, true, let's leave it. Thanks.
> 

-- 
Antonio Quartulli
OpenVPN Inc.


