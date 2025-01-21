Return-Path: <linux-kselftest+bounces-24831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4AAA17A7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 10:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCED7A40DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4023B1DE8BA;
	Tue, 21 Jan 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Qi1Bz0f4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8DE1C3C04
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452857; cv=none; b=mH9Un9oPOgnRP2uCjve/E8bZ8zkbWygDL6+lA0H107ikKhcULyrDtNJjDODXhxhG49y809qEfjleQ/X2i4XdHSRum/30mXJMsYksI5JahSP6H4y9QDn/2PYNcz5SYRwbM3XiSVSsq0MebaH88hDc9Zp9WjWnjrCXuANqcD9CJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452857; c=relaxed/simple;
	bh=sptjE8ePvWtv/E7cPSexo6IwoKgq3chazBCwK1CLeso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVPL1ymuTVzOpgSbkCZOBllgYeqcIQCV/HF65klRKgyx86r8lcfdOhQZZOZeuTMASdXiqxIH5rMwdWjTvczqiQtn5oLtIaKGfhAHAcctTpibeGdBrspeg+ozssoVpZLbOtBabp4CEGO44HTQDfB235q36bPF51S96TSyQff0FqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Qi1Bz0f4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1039621866b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 01:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737452853; x=1738057653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DH1SL05raVhXv1Dr1ixVVBE1LZ8qes2g/8qu/oFQP3s=;
        b=Qi1Bz0f4TqeuI+nDEdzKQGgCFcT8ZxdgVphxa0TYgUsXC+tV8AuiSLCIQacvellmnN
         Vtm/vcNgeHSzQdGz384rgO5GewOi0BE53+558ahcAp4CJ7pA3CtUpO0uaCJPNFNmhS3j
         isisafTtOcRQMNL+9iKgXW0e/0G4pGmJfo9+zOFKLoDO0m8CyoZkeAnkEu2dEE+SKZsJ
         FcbVcadGdzNFZbzIquhZip+zECN0qIJwCrsIE1L9dsFBlRffQxqVJquOM1CVM34dBTjX
         o/s6onJWIecb+T1nS06AZiiA2Zmxw41tuUr5PF1fDIYESdbrsZTM/m2y6tLmpKY6WK7C
         +O0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737452853; x=1738057653;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH1SL05raVhXv1Dr1ixVVBE1LZ8qes2g/8qu/oFQP3s=;
        b=N+UQojApHtUFGDzzm0xK3vLTSRFHhVYBW4a94gu5Hsh7GMUOGF1YWwu4iFObx8wj8Y
         UJFWHJ2p2ixH7px+yzu2sj+MWTYbL5dBt0I4SkDaM8zSYQjduq/mH7tcM7FT3jr6SIx4
         3L20dVyYWw1liuCoAl4bJnA0R+8KUz1BNkrFWQEJJloutvlGH9oNlc//l4cDukjhKMos
         +QFKW+u8cQZ5Xed/rHRE4s9uLSr9gwAN8n0wAUsLqM0ZRXgvQFwSD46MDWe1HBNbig+Q
         lzr3cmVt1mdwSEzLSuqHI9s+IBU0FTfCeDyCMdiUfSuWoPVeJ4N576QeeibstV2+EwIb
         abPA==
X-Forwarded-Encrypted: i=1; AJvYcCW2hgGMPl3oGC8EScMYPomOmJkjBNY+1Kd6UeE6E1g4kqZHdknpVJ8Ti1n7YV0hE2CB6XrReUsSAOcU1eMOWa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtd+DiQiOsH021kgDc0DzSmJOujkKjTlQiDn+Z6AbFaEVZtwo
	Qanb/JVGiwqUWHXbwkIW7VS72wdm1ECcIuiM90NNtUAJev86wANGLToFu+OBpIs=
X-Gm-Gg: ASbGncvl2CpoZJyPJwaK+dydy2TSN31snWf9mW8g9VahreLoVF8NxqNztNl4B9W1B/L
	8DuSWnZ6mOaA8cO+ndVBc1Q+L//TKaq+RMcMaWoqSUE3OhD2R71T/NSXtpQOfLhSo8Ylv7bgzSu
	/2w5mP50sabepFuaKEMS1sAhNW9yRixUykb9jvVVueicjgPCy6SfYIUyKxraJCnqOs9HRhlCZ7B
	ss0xq9gWVtFvgq4FndLAG/s/TXH+7+5fEk9IwvedMPA7prs/4iMYbMGd6NXTV1x3Tdlbw6wgjhs
	bxTjhEbpwQ30f9pnK30d44P41lyAsLxg
X-Google-Smtp-Source: AGHT+IFQME9alqkSc/hHtEdj8zXkxcjHmPUh+4tUZOaWrdGYpK6xyHMYiHZGKwScvJ1MkNRT8Ux78g==
X-Received: by 2002:a17:907:7eaa:b0:aac:4324:977e with SMTP id a640c23a62f3a-ab38b163018mr1799577466b.27.1737452853054;
        Tue, 21 Jan 2025 01:47:33 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:2b1b:6df9:ad3c:c183? ([2001:67c:2fbc:1:2b1b:6df9:ad3c:c183])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384fce6c6sm738557766b.179.2025.01.21.01.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 01:47:32 -0800 (PST)
Message-ID: <62213f34-b5c4-46a9-b634-4ce6adbf9786@openvpn.net>
Date: Tue, 21 Jan 2025 10:48:30 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: ryazanov.s.a@gmail.com, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net> <Z4pDpqN2hCc-7DGt@hog>
 <f5507529-e61c-4b81-ab93-4ea6c8df46e9@openvpn.net> <Z4qPjuK3_fQUYLJi@hog>
 <33710520-5f4f-4d33-a28d-99dc64afc9c3@openvpn.net> <Z44gwl2d8ThTshzQ@hog>
 <94e44fdb-314c-41b0-8091-cff5789735b2@openvpn.net> <Z49rNP6KRQ8H0job@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z49rNP6KRQ8H0job@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/01/2025 10:39, Sabrina Dubroca wrote:
> 2025-01-20, 11:45:55 +0100, Antonio Quartulli wrote:
>> On 20/01/2025 11:09, Sabrina Dubroca wrote:
>>> 2025-01-19, 14:12:05 +0100, Antonio Quartulli wrote:
>>>> On 17/01/2025 18:12, Sabrina Dubroca wrote:
>>>>> 2025-01-17, 13:59:35 +0100, Antonio Quartulli wrote:
>>>>>> On 17/01/2025 12:48, Sabrina Dubroca wrote:
>>>>>>> 2025-01-13, 10:31:39 +0100, Antonio Quartulli wrote:
>>>>>>>>      int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
>>>>>>>>      {
>>>>>>>> -	return -EOPNOTSUPP;
>>>>>>>> +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
>>>>>>>> +	struct ovpn_priv *ovpn = info->user_ptr[0];
>>>>>>>> +	struct ovpn_socket *ovpn_sock;
>>>>>>>> +	struct socket *sock = NULL;
>>>>>>>> +	struct ovpn_peer *peer;
>>>>>>>> +	u32 sockfd, peer_id;
>>>>>>>> +	int ret;
>>>>>>>> +
>>>>>>>> +	/* peers can only be added when the interface is up and running */
>>>>>>>> +	if (!netif_running(ovpn->dev))
>>>>>>>> +		return -ENETDOWN;
>>>>>>>
>>>>>>> Since we're not under rtnl_lock here, the device could go down while
>>>>>>> we're creating this peer, and we may end up with a down device that
>>>>>>> has a peer anyway.
>>>>>>
>>>>>> hmm, indeed. This means we must hold the rtnl_lock to prevent ending up in
>>>>>> an inconsistent state.
>>>>>>
>>>>>>>
>>>>>>> I'm not sure what this (and the peer flushing on NETDEV_DOWN) is
>>>>>>> trying to accomplish. Is it a problem to keep peers when the netdevice
>>>>>>> is down?
>>>>>>
>>>>>> This is the result of my discussion with Sergey that started in v23 5/23:
>>>>>>
>>>>>> https://lore.kernel.org/r/netdev/20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net/
>>>>>>
>>>>>> The idea was to match operational state with actual connectivity to peer(s).
>>>>>>
>>>>>> Originally I wanted to simply kee the carrier always on, but after further
>>>>>> discussion (including the meaning of the openvpn option --persist-tun) we
>>>>>> agreed on following the logic where an UP device has a peer connected (logic
>>>>>> is slightly different between MP and P2P).
>>>>>>
>>>>>> I am not extremely happy with the resulting complexity, but it seemed to be
>>>>>> blocker for Sergey.
>>>>>
>>>>> [after re-reading that discussion with Sergey]
>>>>>
>>>>> I don't understand why "admin does 'ip link set tun0 down'" means "we
>>>>> should get rid of all peers. For me the carrier situation goes the
>>>>> other way: no peer, no carrier (as if I unplugged the cable from my
>>>>> ethernet card), and it's independent of what the user does (ip link
>>>>> set XXX up/down). You have that with netif_carrier_{on,off}, but
>>>>> flushing peers when the admin does "ip link set tun0 down" is separate
>>>>> IMO.
>>>>
>>>> The reasoning was "the user is asking the VPN to go down - it should be
>>>> assumed that from that moment on no VPN traffic whatsoever should flow in
>>>> either direction".
>>>> Similarly to when you bring an Eth interface dwn - the phy link goes down as
>>>> well.
>>>>
>>>> Does it make sense?
>>>
>>> I'm not sure. If I turn the ovpn interface down for a second, the
>>> peers are removed. Will they come back when I bring the interface back
>>> up?  That'd have to be done by userspace (which could also watch for
>>> the DOWN events and tell the kernel to flush the peers) - but some of
>>> the peers could have timed out in the meantime.
>>>
>>> If I set the VPN interface down, I expect no packets flowing through
>>> that interface (dropping the peers isn't necessary for that), but all
>>> non-data (key exchange etc sent by openvpn's userspace) should still
>>> go through, and IMO peer keepalive fits in that "non-data" category.
>>
>> This was my original thought too and my original proposal followed this idea
>> :-)
>>
>> However Sergey had a strong opinion about "the user expect no traffic
>> whatsoever".
>>
>> I'd be happy about going again with your proposed approach, but I need to be
>> sure that on the next revision nobody will come asking to revert this logic
>> again :(
> 
> Sure.
> 
>>> What does openvpn currently do if I do
>>>       ip link set tun0 down ; sleep 5 ; ip link set tun0 up
>>> with a tuntap interface?
>>
>> I think nothing happens, because userspace doesn't monitor the netdev
>> status. Therefore, unless tun closed the socket (which I think it does only
>> when the interface is destroyed), userspace does not even realize that the
>> interface went down.
> 
> So if this behavior changes once users switch from tuntap to ovpn,
> they may be surprised/unhappy.
> 

I agree here too.
I'll go back to keeping peers connected even if the iface goes down then.

Thanks

-- 
Antonio Quartulli
OpenVPN Inc.


