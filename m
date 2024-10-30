Return-Path: <linux-kselftest+bounces-21158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D1B9B6E0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858C0282ED5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 20:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DAB213EFE;
	Wed, 30 Oct 2024 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CKw6Tttj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD031DDA2D
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321267; cv=none; b=cyoCpwMiMO3Jihi6zE6KE3Gu4BsOpYYIKyVhMXPoz+nzRpew1IvQgrpRgK3dItrKu9LNcwkHZQ/a1xxWfOs4rHYPzFakhUi0VdpLpQExIq19rnr9mIzSYJwQh01jB0cd45NpAZ7esK78ol3r3Z48TA1VrAS/0lXmSHHeGQg2Ww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321267; c=relaxed/simple;
	bh=xkBOU8HHDGawwUeVGiByYGBX9nhBdgs4ZZYBKpJzD74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mcn7F+lxxAtP9/0zp7Dx8A3/mSvIN4JsK31e+6AK3aikIvuQY2i1fXY7y30mYxVKqVKdHJ+HEZwyYhudMF4KkT1Ih9NgBFTWG8Mp5fx/FHUhdhvfhWqYV5t5iz+AR2Uq94V9pcRD0Ybrs6q9vFu5RkLMUwi8uf90m6gGYC+dOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CKw6Tttj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so375599a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 13:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730321263; x=1730926063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7yaQxQU296jO/yOWyNz6bvN9BIinpfVhB4oWU13Tm/g=;
        b=CKw6Tttj/Pvq+eaAWujnKWEs37u4b4B9FfzoAvlexNdankLmc8kuR4l4DAZ+J0PgeG
         rBSUxlMCWR3ZF8MxvwjTGi6tXLyLybQFi7vYI6owZbQzeir7+gtL9iRN6edQqZaks3XY
         Jg6dGe57+wMIZfgD5uFnWTNvt9PySQTfbJQTagnB1Dnrao7qK9/7x3I5MPyKDeAAz5Nd
         1e+Yj5LkdTNRkD+VlOCgbC62pc6Prza1/sE+ntlWSJiyR+eEH095wjq5MO/BYmwESQbm
         N1p02x6ONZYSRQERIivzlJHm7HXiPDvY0wt9/arVYd2P80WUU5G/bHItB/dqY3sF8Idd
         TpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321263; x=1730926063;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yaQxQU296jO/yOWyNz6bvN9BIinpfVhB4oWU13Tm/g=;
        b=eA26z3gL4wMb9SYO3VzAwGaoxfFuL9ZDZ19AJf1QtJUKHb9e15u8TDaETAl+xEUceG
         ERvRjENuiYfW7D7fvQDGij56vCE3Hioiwn3E2Zhc51KDwMfePEmyJ/sLqb0cSRA56hE/
         rh1ZrIM9/Dt4d9Mu0ArZB3pRB4puBXNTg+VjX2e9WB36DQRJTZJL219EQBUKC4dq+Rqx
         6uHI8CIwdFbrgaERN3w1dipz+t5Zi6wp7a/QamMzPu7Jkm+P+C8SJM6FliuO3Nrv/LA2
         lo6diZM0dozhD057/xZ1ygc7fbeyxnFe3ICphEWkT5ULsDRziSnS9izsy5R2oj1E+Vvn
         CVlA==
X-Forwarded-Encrypted: i=1; AJvYcCWZfcDu6dgsEu7dvahCooIt7wxaxesW7XsC+2sSPBBfCGTba2yNTU/nZv0WrfXcBJjv/onNU0pAVYqAIybQpGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYz0puW/v/GIQgeJr4IpicuIWBa9Uj27SAUxFezZTjiN8I33FE
	dcmGfK9mjLMq+vkr1c6bXLrKblrvuRHxeJPgtb6PkFNL+6J3Z5lGkR/V2rOwKC0=
X-Google-Smtp-Source: AGHT+IEaeIfdsTwQV/5YgiGiSHgxyvx8PBYajDN9ioX9CQNqCDd7hL8eLzUt24j7ymojbMYas7Ka7A==
X-Received: by 2002:a05:6402:3584:b0:5cb:6709:3cd7 with SMTP id 4fb4d7f45d1cf-5cbbf872064mr11499479a12.4.1730321262993;
        Wed, 30 Oct 2024 13:47:42 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:3ca3:4955:91d7:e8e1? ([2001:67c:2fbc:1:3ca3:4955:91d7:e8e1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb63487fcsm4966653a12.91.2024.10.30.13.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 13:47:42 -0700 (PDT)
Message-ID: <4df15a91-4bcb-49d8-be78-28c71036ba8a@openvpn.net>
Date: Wed, 30 Oct 2024 21:47:58 +0100
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
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZyJgs6Vrvzji8qvS@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2024 17:37, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:19 +0100, Antonio Quartulli wrote:
>> +static void ovpn_peer_release(struct ovpn_peer *peer)
>> +{
>> +	ovpn_bind_reset(peer, NULL);
>> +
>> +	dst_cache_destroy(&peer->dst_cache);
> 
> Is it safe to destroy the cache at this time? In the same function, we
> use rcu to free the peer, but AFAICT the dst_cache will be freed
> immediately:
> 
> void dst_cache_destroy(struct dst_cache *dst_cache)
> {
> [...]
> 	free_percpu(dst_cache->cache);
> }
> 
> (probably no real issue because ovpn_udp_send_skb gets called while we
> hold a reference to the peer?)

Right.
That was my assumption: release happens on refcnt = 0 only, therefore no 
field should be in use anymore.
Anything that may still be in use will have its own refcounter.

> 
>> +	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
>> +	kfree_rcu(peer, rcu);
>> +}
> 
> 
> [...]
>> +static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
>> +			     enum ovpn_del_peer_reason reason)
>> +	__must_hold(&peer->ovpn->lock)
>> +{
>> +	struct ovpn_peer *tmp;
>> +
>> +	tmp = rcu_dereference_protected(peer->ovpn->peer,
>> +					lockdep_is_held(&peer->ovpn->lock));
>> +	if (tmp != peer) {
>> +		DEBUG_NET_WARN_ON_ONCE(1);
>> +		if (tmp)
>> +			ovpn_peer_put(tmp);
> 
> Does peer->ovpn->peer need to be set to NULL here as well? Or is it
> going to survive this _put?

First of all consider that this is truly something that we don't expect 
to happen (hence the WARN_ON).
If this is happening it's because we are trying to delete a peer that is 
not the one we are connected to (unexplainable scenario in p2p mode).

Still, should we hit this case (I truly can't see how), I'd say "leave 
everything as is - maybe this call was just a mistake".

Cheers,

> 
>> +
>> +		return -ENOENT;
>> +	}
>> +
>> +	tmp->delete_reason = reason;
>> +	RCU_INIT_POINTER(peer->ovpn->peer, NULL);
>> +	ovpn_peer_put(tmp);
>> +
>> +	return 0;
>> +}
> 

-- 
Antonio Quartulli
OpenVPN Inc.


