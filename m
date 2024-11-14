Return-Path: <linux-kselftest+bounces-22017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C28D99C85EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 10:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DE91F2164D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DC51DF73C;
	Thu, 14 Nov 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QkoQhFBs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9794C85
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576057; cv=none; b=DApmQg7bo14YdrJrulDq060Ka5Z6DA6Mv1DkQIi2g/7cfT0m2WwSk7dz6RVM+UC2qiHJH2FV+Oee3tcbqjzclofc00rER6XX3XkUfvvHvoLD610R85siuShQvS15eWwwJE/gCT13MEa9ijcK3+Td+QIInLcnHHttjI6+Guwn2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576057; c=relaxed/simple;
	bh=UGkkrw6D20oDdBbfGGY08X9vRxOYR7cCmr1XIxFiWMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krk/bILNgA7Qsqakb9q/CQVApXxmsnS5b+erKq/N0h3iV1N86XaszI5DqE7RBbJlOF8OA4Ar/OaOQg9YvKj9qagpi8HGWRR3NxNjAVjJYZpzQndUHmO7SrrC/568oJBFwUc5OKpo5rMD6821n9scpfn0Fu/u7jBIwSWrc1LRUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QkoQhFBs; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cf7b79c6a6so267565a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 01:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731576053; x=1732180853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DtjkgA4Paslvtb3pQhMOxnpQn7bCQ8t0ao/oNEpfP04=;
        b=QkoQhFBsz9QxxNwAcOR3rMPoE2748ahfYtACQyfl46hisGkWwjsjdchGa/LwLZClQI
         LKb6TCaYZCFAT2X4voFCk2jT9MT8lnI4GwpaYyK4xwlhKhGUFiNlzK4bgNK1RODrMXIT
         kNObPLZUr0/HF1lBLLnzU0uni1Pz2qVH5qoO6bdGBUBVqL8CxPG6d1iXp0MQ6G/9Xc33
         xnEB0cPn+KMmdNd8Hun3pu5U7lu1zVrdbQPkt/ant1iAdte9eCrngU0CqiYou3vgyWWv
         PQAVZEcmjWaL7ZJerWdJIAIwUsTiNHU88lgHjOV9ekkAc3ogIuIvJU+2BqrtbkWp+s2f
         3G2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731576053; x=1732180853;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtjkgA4Paslvtb3pQhMOxnpQn7bCQ8t0ao/oNEpfP04=;
        b=EJ/nSmOBOgIWT8zUcxGGeEbNrklt4DAfC53wqIUnGvDxTCiQQ4qB3vH7dwddrf6s/j
         34sfv1lb4NLCoA070ZUS4wtjG5e87+johhnOKY872ibxa25PVhB5EFtFcpCbrB5P7QC/
         DOCXHpLFyirj/uPWvHKlG+r8nyRhoQLLpcBhkswC9xuFz547Ka7lEwYnSNjehAgGePuv
         4BGVCCAHq07mvYytnFlGt3IpQxfbgxyyCIsqOmEj6kzZvYPohd73qLJNm4i2yG3FDKtH
         MSjTy+L3uTmo5+5RkGldyqFVg1MUiZeGcux3+pTnB9IM+r9A2ck3K5zyJEa9aAIijosC
         q7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUMe2FFt+j4d064kpF3hxqhdBiV9NxWyd9Uceq8EZD8wcw+/PZq8TzOnnMZ8FBjRJRm2KqwAp0l9yvLZA5UM18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8QG/kUjZlAmVuc7yWbrs+VXVvhVKyc19jCGoWkD+8r5Vx/2L
	zKHbfmFQ1jULwibjJYrb+t2WouPjVYqFEM+CekzN9jAbPSwEr2kRNdZ21DDH3jI=
X-Google-Smtp-Source: AGHT+IFAgwmobPOc3o/TArjevN2Pjs1UoT66R3rgWU2zfc0tznnZvufSvE9otBQ8Px0O6ppPdGiTLQ==
X-Received: by 2002:a17:907:6e92:b0:a9e:eee8:4947 with SMTP id a640c23a62f3a-aa2076cc2f9mr242560566b.9.1731576052924;
        Thu, 14 Nov 2024 01:20:52 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:3779:22d5:a322:7c13? ([2001:67c:2fbc:1:3779:22d5:a322:7c13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df27068sm40373066b.8.2024.11.14.01.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 01:20:52 -0800 (PST)
Message-ID: <e11c5f81-cbc8-43a3-b275-7004efdcb358@openvpn.net>
Date: Thu, 14 Nov 2024 10:21:18 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net> <Zyjk781vOqV4kXhJ@hog>
 <76191b85-6844-4a85-bb9c-ad19aa5110c5@openvpn.net> <ZzTaRNeZjo48ArsR@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZzTaRNeZjo48ArsR@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2024 17:56, Sabrina Dubroca wrote:
> 2024-11-12, 15:19:50 +0100, Antonio Quartulli wrote:
>> On 04/11/2024 16:14, Sabrina Dubroca wrote:
>>> 2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
>>>> +static int ovpn_nl_peer_precheck(struct ovpn_struct *ovpn,
>>>> +				 struct genl_info *info,
>>>> +				 struct nlattr **attrs)
>>>> +{
>>>> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
>>>> +			      OVPN_A_PEER_ID))
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (attrs[OVPN_A_PEER_REMOTE_IPV4] && attrs[OVPN_A_PEER_REMOTE_IPV6]) {
>>>> +		NL_SET_ERR_MSG_MOD(info->extack,
>>>> +				   "cannot specify both remote IPv4 or IPv6 address");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
>>>> +	    !attrs[OVPN_A_PEER_REMOTE_IPV6] && attrs[OVPN_A_PEER_REMOTE_PORT]) {
>>>> +		NL_SET_ERR_MSG_MOD(info->extack,
>>>> +				   "cannot specify remote port without IP address");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
>>>> +	    attrs[OVPN_A_PEER_LOCAL_IPV4]) {
>>>> +		NL_SET_ERR_MSG_MOD(info->extack,
>>>> +				   "cannot specify local IPv4 address without remote");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	if (!attrs[OVPN_A_PEER_REMOTE_IPV6] &&
>>>> +	    attrs[OVPN_A_PEER_LOCAL_IPV6]) {
>>>
>>> I think these consistency checks should account for v4mapped
>>> addresses. With remote=v4mapped and local=v6 we'll end up with an
>>> incorrect ipv4 "local" address (taken out of the ipv6 address's first
>>> 4B by ovpn_peer_reset_sockaddr). With remote=ipv6 and local=v4mapped,
>>> we'll pass the last 4B of OVPN_A_PEER_LOCAL_IPV6 to
>>> ovpn_peer_reset_sockaddr and try to read 16B (the full ipv6 address)
>>> out of that.
>>
>> Right, a v4mapped address would fool this check.
>> How about checking if both or none addresses are v4mapped? This way we
>> should prevent such cases.
> 
> I don't know when userspace would use v4mapped addresses, 

It happens when listening on [::] with a v6 socket that has no 
"IPV6_V6ONLY" set to true (you can check ipv6(7) for more details).
This socket can receive IPv4 connections, which are implemented using 
v4mapped addresses. In this case both remote and local are going to be 
v4mapped.
However, the sanity check should make sure nobody can inject bogus 
combinations.

> but treating
> a v4mapped address as a "proper" ipv4 address should work with the
> rest of the code, since you already have the conversion in
> ovpn_nl_attr_local_ip and ovpn_nl_attr_sockaddr_remote. So maybe you
> could do something like (rough idea and completely untested):
> 
>      static int get_family(attr_v4, attr_v6)
>      {
>         if (attr_v4)
>             return AF_INET;
>         if (attr_v6) {
>             if (ipv6_addr_v4mapped(attr_v6)
>                 return AF_INET;
>             return AF_INET6;
>         }
>         return AF_UNSPEC;
>      }
> 
> 
>      // in _precheck:
>      // keep the   attrs[OVPN_A_PEER_REMOTE_IPV4] && attrs[OVPN_A_PEER_REMOTE_IPV6]  check
>      // maybe add a similar one for   LOCAL_IPV4 && LOCAL_IPV6

the latter is already covered by:

  192         if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
  193             attrs[OVPN_A_PEER_LOCAL_IPV4]) {
  194                 NL_SET_ERR_MSG_MOD(info->extack,
  195                                    "cannot specify local IPv4 
address without remote");
  196                 return -EINVAL;
  197         }
  198
  199         if (!attrs[OVPN_A_PEER_REMOTE_IPV6] &&
  200             attrs[OVPN_A_PEER_LOCAL_IPV6]) {
  201                 NL_SET_ERR_MSG_MOD(info->extack,
  202                                    "cannot specify local IPV6 
address without remote");
  203                 return -EINVAL;
  204         }


> 
>      remote_family = get_family(attrs[OVPN_A_PEER_REMOTE_IPV4], attrs[OVPN_A_PEER_REMOTE_IPV6]);
>      local_family = get_family(attrs[OVPN_A_PEER_LOCAL_IPV4], attrs[OVPN_A_PEER_LOCAL_IPV6]);
>      if (remote_family != local_family) {
>          extack "incompatible address families";
>          return -EINVAL;
>      }
> 
> That would mirror the conversion that
> ovpn_nl_attr_local_ip/ovpn_nl_attr_sockaddr_remote do.

Yeah, pretty much what I was suggested, but in a more explicit manner.
I like it.

> 
>>>>    int ovpn_nl_peer_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>>>>    {
>>> [...]
>>>> +	} else {
>>>> +		rcu_read_lock();
>>>> +		hash_for_each_rcu(ovpn->peers->by_id, bkt, peer,
>>>> +				  hash_entry_id) {
>>>> +			/* skip already dumped peers that were dumped by
>>>> +			 * previous invocations
>>>> +			 */
>>>> +			if (last_idx > 0) {
>>>> +				last_idx--;
>>>> +				continue;
>>>> +			}
>>>
>>> If a peer that was dumped during a previous invocation is removed in
>>> between, we'll miss one that's still present in the overall dump. I
>>> don't know how much it matters (I guses it depends on how the results
>>> of this dump are used by userspace), so I'll let you decide if this
>>> needs to be fixed immediately or if it can be ignored for now.
>>
>> True, this is a risk I assumed.
>> Not extremely important if you ask me, but do you have any suggestion how to
>> avoid this in an elegant and lockless way?
> 
> No, inconsistent dumps are an old problem with netlink, so I'm just
> mentioning it as something to be aware of. You can add
> genl_dump_check_consistent to let userspace know that it may have
> gotten incorrect information (you'll need to keep a counter and
> increment it when a peer is added/removed). On a very busy server you
> may never manage to get a consistent dump, if peers are going up and
> down very fast.
> 
> There's been some progress for dumping netdevices in commit
> 759ab1edb56c ("net: store netdevs in an xarray"), but that can still
> return incorrect data.

Got it. I'll keep it as it is for now, since this is not critical.

Thanks a lot.

Regards,

> 

-- 
Antonio Quartulli
OpenVPN Inc.


