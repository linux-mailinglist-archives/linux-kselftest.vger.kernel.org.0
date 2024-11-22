Return-Path: <linux-kselftest+bounces-22444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D49D5C12
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 10:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D4F1F21EB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215D81D0143;
	Fri, 22 Nov 2024 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DXR3a49G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81F15AAD9
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268462; cv=none; b=fPS4uuvPfIb84GGiaXSuK5//5PVvaW9OdDbJLURd1Xo+5U3qgxh/GFMYJVdN3K3T47WJxgcJi+n36vtJyL3+Junq2KaqcEH0GSGDber5zzh4Hp05lGQDuUqlcTbhEsGsX7ma/bcMeQIL9PpO4GRVROYFgwvoKlNJO5Z8VEAIN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268462; c=relaxed/simple;
	bh=Qw+K2TBALTSNxzzBGzGX/Ihre4E1ZYJsLnRL36lZSy4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Koc1mIZEsxM4lOtMrbdC+PSW8KJLBzBtIsbY0SHTWR3lniuy67wR6BdF+tOvI0LSlTo2YqdRpSR9cVJA/wUejscOAIrIVPusjOEh6xvrzImWnsms8DpzB9c2Jt3dVpjyASP+f2+2uHzmFPy5S9MEglRhM8egTydMD9WFHO/KR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DXR3a49G; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431616c23b5so10478205e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 01:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732268458; x=1732873258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97LJn5YCqDXTh6V39NfmAoq10oK1PqUT2iknosH/2/c=;
        b=DXR3a49GsTidAZYLn1OAv/DTmnOdAWDGg6QaRWu/CrsNM6PZF/BfqnNRC1mWmcc6/u
         0VWTB5pdKVwnQmEiuprJRBfIqf/F0D2dJ9bmp13+js4STHaQTjE01hEuHMiXGPxVUo5w
         Jy05MOBfYzPLlRpOnmOQ68H2ceYzv7ObfI+5VU75q8qu1n2h/5oN4vDdRWoGTpUFNpsH
         24e1BbgjqSr2UhK3ElqYINHlF9FgVD1/eqrXmvoOISNb7WJ6iggS1HKyZ3xNPEo/6l6e
         YrYeFiZ8fIvjsiWwNl0XxTRpnO1mreeLHdujuVZs5H9sh+0rtVclFN6229C80zA/Ue8q
         0J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268458; x=1732873258;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=97LJn5YCqDXTh6V39NfmAoq10oK1PqUT2iknosH/2/c=;
        b=brVbxGW08ug8IyJPeIlTftYOVue+ql4XZuEIqgBHxd3myrR6NXaJlTmifdIaCQHfA8
         MxNjrls98zxwCXuMlVhpX14YbhHlVmWC7dzaPyWtyv5LIDImE77HAOpbhc6RTXPeIwdE
         MGNeJrMptrPIIXyQm6HLNOe0S0knTG7e+fo2beElysnSIuArlCu4pqARJh4DGM+XRPmw
         MxLvM3lCgQkSNCpESvYBpo/fm7R/oUh6DKiI1KafPAjjksz0/hWGUqRYaQg+ZCjEKx+M
         M18TEZOY74h4MGki0NYhMq1uBkbYPoLhey4A5Bbmc+hQL1XLgEg71i3pnqAKg2XTnD5s
         lP9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwAdVmQXNA9itsUJvg2kU+FDCsuKqtYl+CAvrPXDKWXpIp5l90eEwa76mByLpeS0lqnSwe8ZhZk4zJeigZ5Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVeTvItnXwljHW+QymSDB0Q12X7Fyzjwo8RwVPk17Mk3hQQmc
	LT/ifrvLvAksgN3hy+MsN0XXYLtMEp6TkBEO7YQhlQT2XW40TNXyaUCFKV25flw=
X-Gm-Gg: ASbGncsLMWFd8wZNWYDNB3o5kzNJfsOfkp1Cx1Duls+QMf9kjZEGWSglQ+jHG7zNhvW
	XCqmRpQwJW5mniJ5p7UsS81hog/RlLbNO4S4lqQkl1LLtPg0PLqPN3GRRsp3JvYmp3oSfPbgxFy
	w+fiDEfMH0dM5Wr+HIMx4x3GYCb+qGmG8Erb+OkEuMq/Rg0y4AtEkhR/t0eyku/cMY64D87V6ws
	+/dQ0hE9h+Ym/v59FLvwLAH9b7ZPdruLDOovBvX29fjiepSnnxCz3qfw+0Dq7x47WWAJ0nsPY1V
	3QQKS4pU9fdw
X-Google-Smtp-Source: AGHT+IHS637NPjL79uqt/WdsXGFiQWuFUZ+E7Olk0LFmnd55jxfd9xYT5gaWtCDWILJte27UF3Zdzw==
X-Received: by 2002:a05:600c:22d4:b0:42f:84ec:3e0 with SMTP id 5b1f17b1804b1-433c5ca23bcmr52567325e9.9.1732268457829;
        Fri, 22 Nov 2024 01:40:57 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:3fbc:2352:116e:c517? ([2001:67c:2fbc:1:3fbc:2352:116e:c517])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde05898sm21624965e9.9.2024.11.22.01.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 01:40:57 -0800 (PST)
Message-ID: <5eaf74fb-ad13-4371-95b8-7a5f1f3a9cda@openvpn.net>
Date: Fri, 22 Nov 2024 10:41:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 15/23] ovpn: implement keepalive mechanism
From: Antonio Quartulli <antonio@openvpn.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-15-de4698c73a25@openvpn.net> <ZypfnyfToF1b6YAZ@hog>
 <189dbeea-127a-47e8-84f8-c8cf1cc03536@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <189dbeea-127a-47e8-84f8-c8cf1cc03536@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2024 14:20, Antonio Quartulli wrote:
[...]
>>> +static int ovpn_peer_del_nolock(struct ovpn_peer *peer,
>>> +                enum ovpn_del_peer_reason reason)
>>> +{
>>> +    switch (peer->ovpn->mode) {
>>> +    case OVPN_MODE_MP:
>>
>> I think it would be nice to add
>>
>>      lockdep_assert_held(&peer->ovpn->peers->lock);

Sabrina, in other places I have used the sparse notation __must_hold() 
instead.
Is there any preference in regards to lockdep vs sparse?

I could switch them all to lockdep_assert_held if needed.

Regards,

>>
>>> +        return ovpn_peer_del_mp(peer, reason);
>>> +    case OVPN_MODE_P2P:
>>
>> and here
>>
>>      lockdep_assert_held(&peer->ovpn->lock);
> 
> Yeah, good idea.
> __must_hold() can't work here, so lockdep_assert_held is definitely the 
> way to go.
> 
>>
>> (I had to check that ovpn_peer_del_nolock is indeed called with those
>> locks held since they're taken by ovpn_peer_keepalive_work_{mp,p2p},
>> adding these assertions would make it clear that ovpn_peer_del_nolock
>> is not an unsafe version of ovpn_peer_del)
> 
> Right, it makes sense.
> 
>>
>>> +        return ovpn_peer_del_p2p(peer, reason);
>>> +    default:
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +}
>>> +
>>>   /**
>>>    * ovpn_peers_free - free all peers in the instance
>>>    * @ovpn: the instance whose peers should be released
>>> @@ -830,3 +871,150 @@ void ovpn_peers_free(struct ovpn_struct *ovpn)
>>>           ovpn_peer_unhash(peer, OVPN_DEL_PEER_REASON_TEARDOWN);
>>>       spin_unlock_bh(&ovpn->peers->lock);
>>>   }
>>> +
>>> +static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
>>> +                        time64_t now)
>>> +{
>>> +    time64_t next_run1, next_run2, delta;
>>> +    unsigned long timeout, interval;
>>> +    bool expired;
>>> +
>>> +    spin_lock_bh(&peer->lock);
>>> +    /* we expect both timers to be configured at the same time,
>>> +     * therefore bail out if either is not set
>>> +     */
>>> +    if (!peer->keepalive_timeout || !peer->keepalive_interval) {
>>> +        spin_unlock_bh(&peer->lock);
>>> +        return 0;
>>> +    }
>>> +
>>> +    /* check for peer timeout */
>>> +    expired = false;
>>> +    timeout = peer->keepalive_timeout;
>>> +    delta = now - peer->last_recv;
>>
>> I'm not sure that's always > 0 if we finish decrypting a packet just
>> as the workqueue starts:
>>
>>    ovpn_peer_keepalive_work
>>      now = ...
>>
>>                                         ovpn_decrypt_post
>>                                           peer->last_recv = ...
>>
>>    ovpn_peer_keepalive_work_single
>>      delta: now < peer->last_recv
>>
> 
> Yeah, there is nothing preventing this from happening...but is this 
> truly a problem? The math should still work, no?
> 
> However:
> 
>>
>>
>>> +    if (delta < timeout) {
>>> +        peer->keepalive_recv_exp = now + timeout - delta;
>>
>> I'd shorten that to
>>
>>      peer->keepalive_recv_exp = peer->last_recv + timeout;
>>
>> it's a bit more readable to my eyes and avoids risks of wrapping
>> values.
>>
>> So I'd probably get rid of delta and go with:
>>
>>      last_recv = READ_ONCE(peer->last_recv)
>>      if (now < last_recv + timeout) {
>>          peer->keepalive_recv_exp = last_recv + timeout;
>>          next_run1 = peer->keepalive_recv_exp;
>>      } else if ...
>>
>>> +        next_run1 = peer->keepalive_recv_exp;
>>> +    } else if (peer->keepalive_recv_exp > now) {
>>> +        next_run1 = peer->keepalive_recv_exp;
>>> +    } else {
>>> +        expired = true;
>>> +    }
> 
> I agree this is simpler to read and gets rid of some extra operations.
> 
> [note: I took inspiration from nat_keepalive_work_single() - it could be 
> simplified as well I guess]
> 
>>
>> [...]
>>> +    /* check for peer keepalive */
>>> +    expired = false;
>>> +    interval = peer->keepalive_interval;
>>> +    delta = now - peer->last_sent;
>>> +    if (delta < interval) {
>>> +        peer->keepalive_xmit_exp = now + interval - delta;
>>> +        next_run2 = peer->keepalive_xmit_exp;
>>
>> and same here
> 
> Yeah, will change both. Thanks!
> 
> 
> Regards,
> 
> 

-- 
Antonio Quartulli
OpenVPN Inc.


