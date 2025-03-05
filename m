Return-Path: <linux-kselftest+bounces-28310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF9A50061
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 14:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FE13B659E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7924886A;
	Wed,  5 Mar 2025 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="M918CpJX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB22459E0
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180482; cv=none; b=XZmV7bJQbX8thtYN/fHtgPrIqnZV705HQ52s7qidQFaFzXqxr/3d5XcbdJxFvtn0hki5o91PPPSpcNwKWtYKS9lg2hReIJmjaW9k2ve9ph2vEJ6d4mNBCEbwrDPTJmvrrg2hQ4O/zzVm3s6Z1ZbJVIauORNMCxPB71onUbgdXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180482; c=relaxed/simple;
	bh=45jOoVrmf7ZgsWRQTRQMoL7DQrUxdR4U7TSnyXd4qBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YV4TAzOLGmuUtxjnZGzzTjIFa23E3fKzsK8/swjyDCL9+Gehw06kLeazKEV2R4Ob7C+M+vFbKIi3rhPNWW4hKtcN+2kUgi1j2UQQ5r04lU5gpxk06wPvdEdmqsSlUwvx8iVRvC47Xpxsp4TAEzVxkVTm6skRUPphf5opFFC3hns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=M918CpJX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bc4b1603fso20997685e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 05:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741180478; x=1741785278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XEqSsXZW/jbuOh14QtUUC+Zr2EQieIMuWtS2Rh7iO5I=;
        b=M918CpJXfbCqe+/UZD3A7pY13TSRer1ZXjxScZgwbQEq2yKtc7kWBcv6Vk+WST8PIo
         4Z/vZKWYFpx1ytmWIcv1yBlOP2DcFoXD7c4jljeG8pVvahYAFrZJtbM9OTSIEJC/i9C6
         pOY7RlR8A3Hk905Zf/Vl8M62Xe5bfg8idr4QddovJwQBh8Wx9FCs1mcOSNAuEsopvRHS
         sfAGVvGM3ev2ImgL5FXJDK+AMRJYQ7VksSjPSd4IeMjpT7bwL9aot+jgEfBOb6LFqW3H
         B9kJVisgw5qXTiUljiem3/DxH5aafId3pRmYKzvLVXbQx6+dL+fj+cTLzvKCRgMTA/bA
         TGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180478; x=1741785278;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEqSsXZW/jbuOh14QtUUC+Zr2EQieIMuWtS2Rh7iO5I=;
        b=gxY/baOaXQgeUuswPn8E6/ySlWwJnJlK9pNWITpOxNL8swEaSBNQVy7NGfqB/Z9rdK
         vs3QdHKMCwdrXXIjXFkiwpI0hWKICCZq8R3Kf9wZ+d86a5i2lRGpk76Qke3qMI9bDXgL
         O/0gbR8vb3RWbjL+EgoxkAlbpTDckIa4OhLxap6r9h/aWOfsB0beSNMlOT/Abi7ciuFU
         Ks17hO2g4vU34jkaDrl2JoRKBLpEH2lzvA7mcVKQ/rUnR4LvM0roI0Bez0afULLWd+lS
         jL64oFdxtPJYtUzl0m7Z23SK2tKXTgFp0ZLrii+gvWGaY/Uxd21GJL/1KxFf45M8VmBy
         aO1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRzBwRX8bnDlVPArI+aSNOsaxuK6u3sXud6CCUlRGw6mp8SocuVO1d6E4WyzDcBJQ47bf86HIyCYzrHsEEjgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqK3WMszoitzwP24b01LwRDUGKzzIrBcDSD+4wH/A+hAKM4Vmc
	NMeIo5esjudd4UZuVUcF3qYDygEElQRhEw4zdWlWFiu3HBUGf9xRakHegSVBkc8=
X-Gm-Gg: ASbGncsGQv03aGIOTblphmBLN5Z5gUCF2Wb4FFmHYhKmSzPQnPFCSCFfvupMhinUqhC
	pRNSuDJQMUP20w2vE7Keag6Vh7VPRtkDXRPj6DphKxECyFuEaDqyOyTRUsTqX3aSbGJZ35dAGuV
	8ywBEfLHQZUYpekbMT2lEvHL+hGCL/vm7F/Col1igg4W8f4lKMvZqS49rpDZFMbec0R31u6bdYK
	xgtIB2l5rvQLUFk8PyL26vyCYCMEJdO3WxCTO7ThM9Z8pm7R5eAdlN34rxdv/ykNna6YGrZJgwQ
	k0hdfuU0jiJejVtBofvGSKZvom/ZPOb6rgCx7DHEVdx7esVUiYqSODa7wGv17mKEKScC4Ao1/i0
	JSCZc
X-Google-Smtp-Source: AGHT+IEiy2/nia8pCn08JsrQD76so2zLJRCd191TfiknY5z43RmcsNheKM7EvMhfTHGqALR0SaGfxA==
X-Received: by 2002:a05:600c:1d0b:b0:43b:cd12:8c92 with SMTP id 5b1f17b1804b1-43bd2ad7566mr22952425e9.31.1741180478132;
        Wed, 05 Mar 2025 05:14:38 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:6b84:f104:e1bf:5d7? ([2001:67c:2fbc:1:6b84:f104:e1bf:5d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426d34csm17415685e9.5.2025.03.05.05.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 05:14:37 -0800 (PST)
Message-ID: <cd9df084-8633-49f0-a851-ed2b1c9946d3@openvpn.net>
Date: Wed, 5 Mar 2025 14:14:36 +0100
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
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8gzbz6YjdeGPqgu@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 12:20, Sabrina Dubroca wrote:
> 2025-03-05, 00:19:32 +0100, Antonio Quartulli wrote:
>> On 04/03/2025 19:37, Sabrina Dubroca wrote:
>>> 2025-03-04, 01:33:48 +0100, Antonio Quartulli wrote:
>>>> A peer connected via UDP may change its IP address without reconnecting
>>>> (float).
>>>
>>> Should that trigger a reset of the peer->dst_cache? And same when
>>> userspace updates the remote address? Otherwise it seems we could be
>>> stuck with a cached dst that cannot reach the peer.
>>
>> Yeah, that make sense, otherwise ovpn_udpX_output would just try over and
>> over to re-use the cached source address (unless it becomes unavailable).
> 
> Not just the source address, the routing entry too. I'm more concerned
> about that: trying to reuse a a cached routing entry that was good for
> the previous remote address, but not for the new one.
> 
> 
> [adding your next email]
>> I spent some more time thinking about this.
>> It makes sense to reset the dst cache when the local address changes, but
>> not in case of float (remote address changed).
>>
>> That's because we always want to first attempt sending packets using the
>> address where the remote peer sent the traffic to.
>> Should that not work (quite rare), then we have code in ovpn_udpX_output
>> that will reset the cache and attempt a different address.
> 
> I don't think the code in ovpn_udpX_output will reset the cache unless
> it was made invalid by a system-wide routing table update (see
> dst_cache_per_cpu_get).
> 
> 	rt = dst_cache_get_ip4(cache, &fl.saddr);
> 	if (rt)
> 		goto transmit;
> ...
> transmit:
> 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
> 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
> 			    fl.fl4_dport, false, sk->sk_no_check_tx);
> 
> 
> So it seems that as long as dst_cache_get_ip4 gets us a dst (which
> AFAIU will happen, unless we did a dst_cache_reset or something else
> made the cached dst invalid -- and ovpn's floating/endpoint update
> doesn't do that), we'll just use it.

Mh yeah, you're right.
Then I'll reset the cache also when a float is detected.

> 
> 
>>>> +void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
>>>> +{
>>>> +	struct hlist_nulls_head *nhead;
>>>> +	struct sockaddr_storage ss;
>>>> +	const u8 *local_ip = NULL;
>>>> +	struct sockaddr_in6 *sa6;
>>>> +	struct sockaddr_in *sa;
>>>> +	struct ovpn_bind *bind;
>>>> +	size_t salen = 0;
>>>> +
>>>> +	spin_lock_bh(&peer->lock);
>>>> +	bind = rcu_dereference_protected(peer->bind,
>>>> +					 lockdep_is_held(&peer->lock));
>>>> +	if (unlikely(!bind))
>>>> +		goto unlock;
>>>> +
>>>> +	switch (skb->protocol) {
>>>> +	case htons(ETH_P_IP):
>>>> +		/* float check */
>>>> +		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
>>>> +			if (bind->remote.in4.sin_family == AF_INET)
>>>> +				local_ip = (u8 *)&bind->local;
>>>
>>> If I'm reading this correctly, we always reuse the existing local
>>> address when we have to re-create the bind, even if it doesn't match
>>> the skb? The "local endpoint update" chunk below is doing that, but
>>> only if we're keeping the same remote? It'll get updated the next time
>>> we receive a packet and call ovpn_peer_endpoints_update.
>>>
>>> That might irritate the RPF check on the other side, if we still use
>>> our "old" source to talk to the new dest?
>>>
>>>> +			sa = (struct sockaddr_in *)&ss;
>>>> +			sa->sin_family = AF_INET;
>>>> +			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
>>>> +			sa->sin_port = udp_hdr(skb)->source;
>>>> +			salen = sizeof(*sa);
>>>> +			break;
>>
>> I think the issue is simply this 'break' above - by removing it, everything
>> should work as expected.
> 
> Only if the bind was of the correct family? Checking an IPv4 local
> address (in the bind) against an IPv6 source address in the packet (or
> the other way around) isn't going to work well.

Ah I understand what you mean.

The purpose of "local_ip" is to provide a working local endpoint to be 
used with the new remote address.
However, if the float is switching family we can't re-use the same old 
local endpoint (hence the check).
In this case we'll learn the "new" local address later.

Does it make sense?

Cheers,

> 
> 
>> I thin this is a leftover from when float check and endpoint update were two
>> different functions/switch blocks.
>>
>>>> +		}
>>>> +
>>>> +		/* local endpoint update */
>>>> +		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
>>>> +			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
>>>> +					    netdev_name(peer->ovpn->dev),
>>>> +					    peer->id, &bind->local.ipv4.s_addr,
>>>> +					    &ip_hdr(skb)->daddr);
>>>> +			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
>>>> +		}
>>>> +		break;
> 

-- 
Antonio Quartulli
OpenVPN Inc.


