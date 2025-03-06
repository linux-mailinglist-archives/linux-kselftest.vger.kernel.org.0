Return-Path: <linux-kselftest+bounces-28397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E5A5474E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 11:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF467AA187
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 10:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75EC20AF8D;
	Thu,  6 Mar 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NzqatPjf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A875202C44
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255378; cv=none; b=G0QLoIWl/4ucoD60EFAPQ+lO4MwjAetKkMsEAw7F45M4J9FJYRNUstwez1Q+DG2mosXtS1CdOQ1OuCe0aUY4ecfj85Jv29swiJ04IRNsuAzSzWtZcJWmd2IKy+19rX2hYjTYhxpkoXqUTU41lp1bEuT7lMIUVV2uD3rY9UR4WIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255378; c=relaxed/simple;
	bh=a8PePnP6Da9TatKC4r183l014uL/MB4JIaip0KYl0eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6568ZZ0t0o5j7MVJv1QMkINieuAnltQgUV8fl5xVQw0udZIlIr26QMJ2/0IZBs0OQPmx+50Nh3rqQKQd0NHiP8LQvAhMoH2wBrZVctc9sJnSnycMb8UcnmO75oGq+h6GVy36nJDZaS1+fqTSrNSxDscM0ECMSI3igyqiqG1BM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NzqatPjf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso677532a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 02:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741255374; x=1741860174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NjA/0x1ULbdGmJAhtVrbQ19bSfwG1MXXmI+NBV/yxT4=;
        b=NzqatPjf/88cIsrrdK2V0c9AyyKpREboscok1bxm74kRAG2AuKOuQMBMGtg13ZVtOP
         m+xKY7PMa3sOxUS+qHFYicBJQfeLVxm8xQ0fHxtfxytkL4sC0vO97uWe8VFYl2o5B/Al
         DZspDKSISf+79caWhxfOu8nmN8X3uoBmPrqDm90VvWjwXfb5PVzpGJcNUqirhLiUyPdl
         aDzblB1IBqbhgEKge4nM/+PQC+vibx3mKeP9t+Ek04BAgPMgd3M4bVZzoyDocvGrtgbq
         ViBDTte4pJdOG2h6AwG3kWuDKZA6hT+GpiyV88uJydK+FuxLg1dJCj6NAv3qNZmrOG7D
         xcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741255374; x=1741860174;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjA/0x1ULbdGmJAhtVrbQ19bSfwG1MXXmI+NBV/yxT4=;
        b=mx6PUvbvVWpVkyOw4QrvyjKkHVF5qhq2tvLcBsx5Wp7Ra3D8BWV178EYUXtyxDFJqX
         j7RSJucsRjdEvZVqZzKaXD/zmq3iFcJ6ooOVl2Kz6oOPkvfZPwT/pczNIWvvMqy2L63J
         1jamXzubg2L9HqJUFsbfkqeOjjoenkGngYWnOPx4hckg2OGxC1ZiP+em8ob4mwIK0SPY
         LdGR9SzFb03qkxDhRZ+cYdGgXzgNY1Jq+HRg1Je5podURvZ3hRgZtGMZhb8OoV+0jmts
         mF7ZHIQb2YqHLQZfvW2iUaOEJnHpey6h8Ta4bI1epFvpkYp0ElYX90O/acNKGttkmsGE
         TUTw==
X-Forwarded-Encrypted: i=1; AJvYcCXGQeIWsRwWPptMAN/CKlsI6eJUrBWieq6C5xHsyxzRKrwUXsrOFQA2DqRPklGvgOUvAWApAxvpIPxhz3WmeSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMPnYI461EDqN1CbwNfKk5zbxULbZKDbWmW+wLdoML0mCnHiFp
	yf7UFHtQQQzT8b94Vd3d1csWMifj2GXIld45ElPezVU2weiUv6gmUYWTaixozoc=
X-Gm-Gg: ASbGncsBmj0CF0wn2Rlvf0WvnUbbp+4QesZWnGUUBM5fup7i6D3cxNVcLomzvOkAS+g
	161ocd+wBkyEBwZCElRKT8Hl6ikClEJtp2crggXD0fJF98ipTrrZ0+3RcqVFKYx+KjxetQzijXb
	YtoYqvL2cuRoFdmVhJ92VbdVRbCcWkE8cCTNBNtkwxuF6bzWXe477pkpgXPLAyXpUr0OwFHedlC
	Czie03pKvy1UgylPlxMMrYdP4JGRrAX81pEdIeN1/+Nk9Oyh0fco9ShsjFzE0O8DqV26g7jyVTk
	1fcF05bIELcMQAPbXcAQTLmVh/M/5gu4OAvKUxt6XpsFUanfpwZ4w5Ussbed/fl+50DO31edQEO
	5k24S4to=
X-Google-Smtp-Source: AGHT+IG/MX6Ctc3Sop+bjN6l6wOSX1XkN7zoXS/g0txiaNk9dp7eFWZRrKBRB2smH9x66Qm1lITf3Q==
X-Received: by 2002:a05:6402:540c:b0:5de:5263:ae79 with SMTP id 4fb4d7f45d1cf-5e59f3d6532mr6189327a12.12.1741255373377;
        Thu, 06 Mar 2025 02:02:53 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:b199:f7fb:728b:9279? ([2001:67c:2fbc:1:b199:f7fb:728b:9279])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7669fd0sm678988a12.51.2025.03.06.02.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:02:52 -0800 (PST)
Message-ID: <e3def5b5-3450-4ad0-aced-fd80af943c31@openvpn.net>
Date: Thu, 6 Mar 2025 11:02:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 18/24] ovpn: add support for peer floating
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
 <20250304-b4-ovpn-tmp-v21-18-d3cbb74bb581@openvpn.net> <Z8dIXjwZ3QmiEcd-@hog>
 <9c919407-fb91-48d7-bf2d-8437c2f3f4da@openvpn.net> <Z8gzbz6YjdeGPqgu@hog>
 <cd9df084-8633-49f0-a851-ed2b1c9946d3@openvpn.net> <Z8iCKvIfFaskshlz@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8iCKvIfFaskshlz@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 17:56, Sabrina Dubroca wrote:
> 2025-03-05, 14:14:36 +0100, Antonio Quartulli wrote:
>> On 05/03/2025 12:20, Sabrina Dubroca wrote:
>>> 2025-03-05, 00:19:32 +0100, Antonio Quartulli wrote:
>>>> On 04/03/2025 19:37, Sabrina Dubroca wrote:
>>>>> 2025-03-04, 01:33:48 +0100, Antonio Quartulli wrote:
>>>>>> A peer connected via UDP may change its IP address without reconnecting
>>>>>> (float).
>>>>>
>>>>> Should that trigger a reset of the peer->dst_cache? And same when
>>>>> userspace updates the remote address? Otherwise it seems we could be
>>>>> stuck with a cached dst that cannot reach the peer.
>>>>
>>>> Yeah, that make sense, otherwise ovpn_udpX_output would just try over and
>>>> over to re-use the cached source address (unless it becomes unavailable).
>>>
>>> Not just the source address, the routing entry too. I'm more concerned
>>> about that: trying to reuse a a cached routing entry that was good for
>>> the previous remote address, but not for the new one.
>>>
>>>
>>> [adding your next email]
>>>> I spent some more time thinking about this.
>>>> It makes sense to reset the dst cache when the local address changes, but
>>>> not in case of float (remote address changed).
>>>>
>>>> That's because we always want to first attempt sending packets using the
>>>> address where the remote peer sent the traffic to.
>>>> Should that not work (quite rare), then we have code in ovpn_udpX_output
>>>> that will reset the cache and attempt a different address.
>>>
>>> I don't think the code in ovpn_udpX_output will reset the cache unless
>>> it was made invalid by a system-wide routing table update (see
>>> dst_cache_per_cpu_get).
>>>
>>> 	rt = dst_cache_get_ip4(cache, &fl.saddr);
>>> 	if (rt)
>>> 		goto transmit;
>>> ...
>>> transmit:
>>> 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
>>> 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
>>> 			    fl.fl4_dport, false, sk->sk_no_check_tx);
>>>
>>>
>>> So it seems that as long as dst_cache_get_ip4 gets us a dst (which
>>> AFAIU will happen, unless we did a dst_cache_reset or something else
>>> made the cached dst invalid -- and ovpn's floating/endpoint update
>>> doesn't do that), we'll just use it.
>>
>> Mh yeah, you're right.
>> Then I'll reset the cache also when a float is detected.
> 
> Ok, thanks.
> 
>>>
>>>
>>>>>> +void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
>>>>>> +{
>>>>>> +	struct hlist_nulls_head *nhead;
>>>>>> +	struct sockaddr_storage ss;
>>>>>> +	const u8 *local_ip = NULL;
>>>>>> +	struct sockaddr_in6 *sa6;
>>>>>> +	struct sockaddr_in *sa;
>>>>>> +	struct ovpn_bind *bind;
>>>>>> +	size_t salen = 0;
>>>>>> +
>>>>>> +	spin_lock_bh(&peer->lock);
>>>>>> +	bind = rcu_dereference_protected(peer->bind,
>>>>>> +					 lockdep_is_held(&peer->lock));
>>>>>> +	if (unlikely(!bind))
>>>>>> +		goto unlock;
>>>>>> +
>>>>>> +	switch (skb->protocol) {
>>>>>> +	case htons(ETH_P_IP):
>>>>>> +		/* float check */
>>>>>> +		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
>>>>>> +			if (bind->remote.in4.sin_family == AF_INET)
>>>>>> +				local_ip = (u8 *)&bind->local;
>>>>>
>>>>> If I'm reading this correctly, we always reuse the existing local
>>>>> address when we have to re-create the bind, even if it doesn't match
>>>>> the skb? The "local endpoint update" chunk below is doing that, but
>>>>> only if we're keeping the same remote? It'll get updated the next time
>>>>> we receive a packet and call ovpn_peer_endpoints_update.
>>>>>
>>>>> That might irritate the RPF check on the other side, if we still use
>>>>> our "old" source to talk to the new dest?
>>>>>
>>>>>> +			sa = (struct sockaddr_in *)&ss;
>>>>>> +			sa->sin_family = AF_INET;
>>>>>> +			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
>>>>>> +			sa->sin_port = udp_hdr(skb)->source;
>>>>>> +			salen = sizeof(*sa);
>>>>>> +			break;
>>>>
>>>> I think the issue is simply this 'break' above - by removing it, everything
>>>> should work as expected.
>>>
>>> Only if the bind was of the correct family? Checking an IPv4 local
>>> address (in the bind) against an IPv6 source address in the packet (or
>>> the other way around) isn't going to work well.
>>
>> Ah I understand what you mean.
>>
>> The purpose of "local_ip" is to provide a working local endpoint to be used
>> with the new remote address.
>> However, if the float is switching family we can't re-use the same old local
>> endpoint (hence the check).
>> In this case we'll learn the "new" local address later.
>>
>> Does it make sense?
> 
> Sure, but we could have learned it immediately from the packet we just
> got, whether we're changing family or not. No need to wait for the
> next RX packet to also learn the new local address.

Indeed.

> 
> But if we now do a dst_cache_reset with the peer float,
> ovpn_udp*_output will have to do a new route/local address lookup and
> I guess that should clean up the local address stored in the bind, and
> then update the dst_cache with the local address we just found.

Right and this may not truly be what we want.

If peer X is sending packets to our IP1, we should at least try to reply 
from the same address.

If we have two IPs, IP1 and IP2, and both can be used to reach peer X, 
we should always try to use the one where we received traffic from X in 
the first place.

OTOH hand it is also true that with floating detection on both sides, 
the situation will converge quickly, but there might be a reason why X 
chose IP1 as destination, therefore we should do our best to respect that.

So, even in case of float, we should still store the local endpoint and 
attempt fetching a route that takes that into consideration.
Which I think is what is happening (assuming we reset the dst_cache on 
float).

ovpn_udpX_output() will:
* get no rt from the cache
* possibly confirm that saddr is ok
* fetch the new rt using the provided saddr and daddr
* update the cache.

That makes sense to me.
Would you agree?

-- 
Antonio Quartulli
OpenVPN Inc.


