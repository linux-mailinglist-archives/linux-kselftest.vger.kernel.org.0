Return-Path: <linux-kselftest+bounces-28597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA9DA59560
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 13:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F0316E2BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE8322A1D5;
	Mon, 10 Mar 2025 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IGb/ycba"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6322A7E3
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611435; cv=none; b=mqf24uheYe16oN78NtusuzfbmbYxxgMvSw4wa8A2hdtY/aHm7WoFoCNIFzYZrQ8MVdsyeXzHLwVMCnMPLKhqqBP5v/a1WU2ALMUQ9MeYolLPbbC9FsTQRdtMpZTxZJLXdCycIf6YAMIroJqFBRkIaaug7hGWEjI8iW7VPImgGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611435; c=relaxed/simple;
	bh=vON/EpbQV2KyfCXTBJEmZ7Ad60j+/Pa+ll4x17Dfc6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGGxq1JaOBGvZHOl0uiWDy17zVtsal3/NCNkmIjiawgle1c+7iz52CagLeSts2OkwIgKkb3+wk0YXjaA4CfNnUecmmUgMIxChBtKqefISaa8cUufaRphYyujS6w32VsVy1tZK+b6a0gw3gmRd+zA3mblmhJzna4LXi+FgfTi64g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IGb/ycba; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac298c8fa50so167451866b.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741611431; x=1742216231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZO3QaUbK7LBz+M8DPrG/4mYgNReKPrnhjLtN5pGlqD8=;
        b=IGb/ycba+Bf9DcKWgBufrd4vujbMgS8OerWEiyDsWcWMMOghjT+v0twRmr/tQo6lWp
         B6f6CVSo7QWu/uGKginnGeh3t5+UV5fOJirQ7ZNI0+iszpVFwNyrhAJ66/9Ch6PK47uH
         BfcAd0LfplCAvVRKINk6rfCIPUMqIT3Apq5mz4N421AhFMvmrQXrX7Eq4+Im7Z57dUWO
         BXMtouIKV+Ld9QtrYz3UCZTW2nhZDVBvhpj8uKqxrph6V20EgMKydUCxgTUQGwMx7lbp
         yMfMMWgiF3dEPro8NWYyS2c6n5n2R/G2NFSJ6PsVTp1ItcFviWaPN0U7zOH/E3MK2TpE
         mNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611431; x=1742216231;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO3QaUbK7LBz+M8DPrG/4mYgNReKPrnhjLtN5pGlqD8=;
        b=W3PO8RD8f8k4ZzfNf/1UC6kMvP0T+wpPT8KMh2/yP46MsOIl307fyam+ipVwij1nRY
         KIyMHusVCThBOdmW162AWmFM5bEmeFHHinA1lX3manvWeh8OqFmBuy/iRaAt6c+WdTBQ
         y+zXyiY7sN6eWENU2uxK+kZCGJ3mkrmRbxT7PtfejRJ9nlsGC45csP3UHfsJjdPXg9C3
         ang1v/QNjE4g5Fx4A8lQDTWBE0xvn3Nf64jvtJ0jZvNfw5M+JlGmyuDEIvqndzrEl0G+
         hMZvQ5PdxkbtAJzAWsZdRXl2+0s7YnuQ03kAQMvjXmfaNFLHl+feVgP3C+BWmTEWkPen
         QL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiGeEfrMQS/1/GxV+OmnTYIpT+7pJZ8OJfDwM62opqT9ISU4EjLHh4WxqeGc5BEpjJzGAIhWEUJWwAldsEQkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAK0HMCSnPaaVOXrbcOrNDtkx7gOZ2r+6QCffOviwuuEQUpawv
	UwBBc8xf/L6bCcj9JehikWC/3lXNCuB41+AliYq1V7EIpqNK3v57QU7kz+8d7jg=
X-Gm-Gg: ASbGncv1H3ZZ0wwmBA0zLtNYlVztGfCiQ38vmbGS+UrLvYRNzKLxbK/yRF1MyX0zH29
	CeIqzmLKqGn1taT//JxTvPRfyLhZ904ST9hjo6Y3jJmB+7nh1qtXYNVT6B/9qAf2sUsZBUHweFz
	W9ykAycTn5RvQzkPklZ7WCFXf1xLfh0Kg+9SIAGlxsnFZ6E5GQr78RHgmGB8eb7zAJAmlpkDFDI
	0oW4YoQ015qZ1vz19f0yMGiSFlVYH8cFZYr0QVFbsT+qn3P12ZqFeBIvm8zB+tWdkVkOa4SRqIN
	5Kol6aa0T7mGcDxziMaxIaohRdOunWDD5HVnpEz/gsRbMbqxPlR1lab2p24UpAkRfy89Dq9ocj2
	kImzFoYBXBVyvkdAkWw==
X-Google-Smtp-Source: AGHT+IHsTaxffT+MFbNnmdyJSVwTv9dOvCg922VF/G+130aQ2Uq3QUGcJlmug4ws36WIKoisVsV5bg==
X-Received: by 2002:a05:6402:430b:b0:5df:25e8:26d2 with SMTP id 4fb4d7f45d1cf-5e5e22a79ccmr32595386a12.5.1741611431032;
        Mon, 10 Mar 2025 05:57:11 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:c442:18ad:5fc3:3cfc? ([2001:67c:2fbc:1:c442:18ad:5fc3:3cfc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733f69csm6778915a12.1.2025.03.10.05.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 05:57:10 -0700 (PDT)
Message-ID: <431c7b94-87ba-4aba-9bc7-e255241dbbdf@openvpn.net>
Date: Mon, 10 Mar 2025 13:57:09 +0100
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
 <e3def5b5-3450-4ad0-aced-fd80af943c31@openvpn.net> <Z8rGnTaRE_mph_tD@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8rGnTaRE_mph_tD@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/03/2025 11:12, Sabrina Dubroca wrote:
> 2025-03-06, 11:02:50 +0100, Antonio Quartulli wrote:
>> On 05/03/2025 17:56, Sabrina Dubroca wrote:
>>> 2025-03-05, 14:14:36 +0100, Antonio Quartulli wrote:
>>>> On 05/03/2025 12:20, Sabrina Dubroca wrote:
>>>>> 2025-03-05, 00:19:32 +0100, Antonio Quartulli wrote:
>>>>>> On 04/03/2025 19:37, Sabrina Dubroca wrote:
>>>>>>> 2025-03-04, 01:33:48 +0100, Antonio Quartulli wrote:
>>>>>>>> +void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
>>>>>>>> +{
>>>>>>>> +	struct hlist_nulls_head *nhead;
>>>>>>>> +	struct sockaddr_storage ss;
>>>>>>>> +	const u8 *local_ip = NULL;
>>>>>>>> +	struct sockaddr_in6 *sa6;
>>>>>>>> +	struct sockaddr_in *sa;
>>>>>>>> +	struct ovpn_bind *bind;
>>>>>>>> +	size_t salen = 0;
>>>>>>>> +
>>>>>>>> +	spin_lock_bh(&peer->lock);
>>>>>>>> +	bind = rcu_dereference_protected(peer->bind,
>>>>>>>> +					 lockdep_is_held(&peer->lock));
>>>>>>>> +	if (unlikely(!bind))
>>>>>>>> +		goto unlock;
>>>>>>>> +
>>>>>>>> +	switch (skb->protocol) {
>>>>>>>> +	case htons(ETH_P_IP):
>>>>>>>> +		/* float check */
>>>>>>>> +		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
>>>>>>>> +			if (bind->remote.in4.sin_family == AF_INET)
>>>>>>>> +				local_ip = (u8 *)&bind->local;
>>>>>>>
>>>>>>> If I'm reading this correctly, we always reuse the existing local
>>>>>>> address when we have to re-create the bind, even if it doesn't match
>>>>>>> the skb? The "local endpoint update" chunk below is doing that, but
>>>>>>> only if we're keeping the same remote? It'll get updated the next time
>>>>>>> we receive a packet and call ovpn_peer_endpoints_update.
>>>>>>>
>>>>>>> That might irritate the RPF check on the other side, if we still use
>>>>>>> our "old" source to talk to the new dest?
>>>>>>>
>>>>>>>> +			sa = (struct sockaddr_in *)&ss;
>>>>>>>> +			sa->sin_family = AF_INET;
>>>>>>>> +			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
>>>>>>>> +			sa->sin_port = udp_hdr(skb)->source;
>>>>>>>> +			salen = sizeof(*sa);
>>>>>>>> +			break;
>>>>>>
>>>>>> I think the issue is simply this 'break' above - by removing it, everything
>>>>>> should work as expected.
>>>>>
>>>>> Only if the bind was of the correct family? Checking an IPv4 local
>>>>> address (in the bind) against an IPv6 source address in the packet (or
>>>>> the other way around) isn't going to work well.
>>>>
>>>> Ah I understand what you mean.
>>>>
>>>> The purpose of "local_ip" is to provide a working local endpoint to be used
>>>> with the new remote address.
>>>> However, if the float is switching family we can't re-use the same old local
>>>> endpoint (hence the check).
>>>> In this case we'll learn the "new" local address later.
>>>>
>>>> Does it make sense?
>>>
>>> Sure, but we could have learned it immediately from the packet we just
>>> got, whether we're changing family or not. No need to wait for the
>>> next RX packet to also learn the new local address.
>>
>> Indeed.
>>
>>>
>>> But if we now do a dst_cache_reset with the peer float,
>>> ovpn_udp*_output will have to do a new route/local address lookup and
>>> I guess that should clean up the local address stored in the bind, and
>>> then update the dst_cache with the local address we just found.
>>
>> Right and this may not truly be what we want.
>>
>> If peer X is sending packets to our IP1, we should at least try to reply
>> from the same address.
>>
>> If we have two IPs, IP1 and IP2, and both can be used to reach peer X, we
>> should always try to use the one where we received traffic from X in the
>> first place.
> 
> I had a thought that it might not be our prefered address to talk to
> X, but it would probably be, since we decided to use it (and thus X
> used it as remote to talk to us).

I am not sure I follow this sentence: I think you are just confirming 
what I said above (please correct me if I am wrong)?

> 
>> OTOH hand it is also true that with floating detection on both sides, the
>> situation will converge quickly, but there might be a reason why X chose IP1
>> as destination, therefore we should do our best to respect that.
> 
> And I guess the primary reason for X to choose IP1 would be "we sent
> packets to X from IP1".

Probably. It truly depends on who initiated the connection.

> 
>> So, even in case of float, we should still store the local endpoint and
>> attempt fetching a route that takes that into consideration.
>> Which I think is what is happening (assuming we reset the dst_cache on
>> float).
> 
> Not at the same time as float, unless ovpn_peer_endpoints_update sets
> local_ip = ip_hdr(skb)->daddr unconditionally on float?
> 
> Otherwise the next route lookup in ovpn_udpX_output will pick whatever
> source address it wants (which would likely match what's in the
> received skb during float, so probably fine anyway).
> 

But that's what the code just below in ovpn_peer_endpoints_update() 
does, no?


  223                 /* local endpoint update */
  224                 if (unlikely(bind->local.ipv4.s_addr != 
ip_hdr(skb)->daddr)) {

...

  229                         bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;


>> ovpn_udpX_output() will:
>> * get no rt from the cache
>> * possibly confirm that saddr is ok
>> * fetch the new rt using the provided saddr and daddr
>> * update the cache.
>>
>> That makes sense to me.
>> Would you agree?
> 
> With dst_cache reset on float, yes. As long as we have that, the main
> behavior seems correct to me. (maybe some corner cases will not be
> handled optimally, but that can be improved later - which is most
> likely what I've been discussing in these emails :))

Yeah :)

> 
> [this could be a useful counter to add in the future: number of floats
> and local address updates - so the user can check if that's increasing
> "too often", which would indicate something weird is happening]

ACK, good idea!

Thanks!

Ok, I'll probably wait a little more and then prepare v22.

Cheers,


-- 
Antonio Quartulli
OpenVPN Inc.


