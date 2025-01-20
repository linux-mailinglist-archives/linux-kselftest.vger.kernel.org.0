Return-Path: <linux-kselftest+bounces-24784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813EEA16AFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 11:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F7C18847BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC201B87EB;
	Mon, 20 Jan 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LYhlgR6B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AD91B413E
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737369903; cv=none; b=FNOSiTaXP+4DgpAjftEY3jZIYPgfDAx9BDR31+GQhG9rotDsAD4i00CilZPJF9UZIvBSzTcy6RZvImTsDIgOPZl2axRVJQL7gVqYYe0XfFL7WB2uUm693GQUu2x3t0FufQGkd/fvXADmVeC2n5hF4gT2tkfzNn06NQPrQoh+HsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737369903; c=relaxed/simple;
	bh=ZwbFzqUySg04g+J61JRhojFx9CIb7wZjgIo/yIp/HTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDpdNPg9Jk2f66UFdovXnIXLb9+O35vU2O8M+KpLxMVEiKfOlOJye6e0kvDIM8Sx1NBu2rPHGjuvklWK/TApVjZL10zTttsl+tmC8LKF7PqIcHsctV43Fzv7hWOY11zAJ7/7f4O31R6Q+B9v5qNNBLuE5gBScC29gcSynQpVgpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LYhlgR6B; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab2e308a99bso914869166b.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 02:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737369900; x=1737974700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MqJKhy5kLhVFaIapkuvUo4we5xGxARCqFNLks0rY808=;
        b=LYhlgR6BIwi3ZDKDRQgrcAx77TQYkzUXmCikHLqXmIqiUJkscHdT5aiGYA28wYObz8
         xBNXoIa61BzTJAuC/nJsgFsi4msRNtB5it/E0WO9A29kbRCi+SyQsc6sG2sOxmvjX1Ia
         tjVVULZZWt2fWbu13nMVIXaHQO6A5AQsKGggmStk21SjZbIflrePkDP5JaWmLkwiFznh
         ehchGjkjZQUhPTNYpdK8THBCjKSD6d6OJEFK8m1fInPgYd4ZKRT5uqXPYen9aAnCRWkU
         FEbn38q18yoXs4tLBXi9FnKmTj9ZqRI4BwSZE50Y62eJ+8FW09NlWRzl5fhbacTBbWMk
         rIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737369900; x=1737974700;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqJKhy5kLhVFaIapkuvUo4we5xGxARCqFNLks0rY808=;
        b=rozOY69qQzK1W2hO22GF0urtVIgWHKMzIN7bH+VSBHSLHIShSXWEOKHn7rKTVPe5Tk
         1SaqplAnWirv12HuEMK0dXZ3wO5Npg3Sa5VWW3LMwqH/KfMEBqNsU83/832qfeFxqnki
         s9B/OKmQD1c7sL8dXLnJXe3VwXRPXRQlpnNc3UuPt37WEViJM/9hGOjArxGm4y6G+pvu
         +PvzzRPngReevUmX4KH2o19EGXwFzAmyJUQKzxAXuc/Q6XNGL7wKx8HFMi5TATDBksEl
         Mm//z3iRTxDeggPxwGdMvO7HQrpVrDFm6Sw7ZbpXKA3Vzp3JzEElgPKGM/eMoiN1Q8jN
         9oEg==
X-Forwarded-Encrypted: i=1; AJvYcCV6vYqm3jdbH8aRA9XArHO5eYlFLJWc+SQzOzHKryisWO4s+BHryd9rHm8sC4HsreEeEKCBZxyRp8M4uBJa/9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCce/CvQ436+cftmKeHG7bxIguId8I4KjMR3ARfSgZwOdqLlC
	UFOfgjOQJCA0AOHvqB7fsES3ailzAxz10IYOjtSt20ehIBpwCSFvIQMGQ9UCkTg=
X-Gm-Gg: ASbGncuJBQ7DDOD17Dq2r5x7foNUJYJ38AxUl+NfasR2UzPYzFaJV5ZircO1LIERgVR
	JfTI844HnhkEnKuZGNR5XnopJ0zKV0KqYzHc2hrCZNqdncC3SnoARiQwakJRJaN7tygh8N+4efI
	NCWx8MDtS9M+aaouS9nYJAIt5g1wBJ+Xy0PYDwoRYJ4u/LDF3WZoTb0gGeP2ERrOM8E4Z+AZZRD
	Fo0H60/S9TlIbCQz2j+wtlmQfwVFoGT1Svui4HzQ4UIgdW6b0P4XqOweZkTPkr/+9PUYvc2jOf5
	JIpW9kgo3bpXeq1nq0st5XHb9GKK2qOR
X-Google-Smtp-Source: AGHT+IF3fRbQ2Fvy6yFQwmK5hjjFl8KNGcFaD5RvsN+jHayRTJvYfGjls6RNCvLX8y/OMC3QbGKYMg==
X-Received: by 2002:a17:906:f887:b0:ab3:9aba:ce7d with SMTP id a640c23a62f3a-ab39abad4c6mr784865566b.1.1737369899687;
        Mon, 20 Jan 2025 02:44:59 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:113d:ece6:3d2f:3a40? ([2001:67c:2fbc:1:113d:ece6:3d2f:3a40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f2903esm602969066b.109.2025.01.20.02.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 02:44:59 -0800 (PST)
Message-ID: <94e44fdb-314c-41b0-8091-cff5789735b2@openvpn.net>
Date: Mon, 20 Jan 2025 11:45:55 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
To: ryazanov.s.a@gmail.com, Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net> <Z4pDpqN2hCc-7DGt@hog>
 <f5507529-e61c-4b81-ab93-4ea6c8df46e9@openvpn.net> <Z4qPjuK3_fQUYLJi@hog>
 <33710520-5f4f-4d33-a28d-99dc64afc9c3@openvpn.net> <Z44gwl2d8ThTshzQ@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z44gwl2d8ThTshzQ@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/01/2025 11:09, Sabrina Dubroca wrote:
> 2025-01-19, 14:12:05 +0100, Antonio Quartulli wrote:
>> On 17/01/2025 18:12, Sabrina Dubroca wrote:
>>> 2025-01-17, 13:59:35 +0100, Antonio Quartulli wrote:
>>>> On 17/01/2025 12:48, Sabrina Dubroca wrote:
>>>>> 2025-01-13, 10:31:39 +0100, Antonio Quartulli wrote:
>>>>>>     int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
>>>>>>     {
>>>>>> -	return -EOPNOTSUPP;
>>>>>> +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
>>>>>> +	struct ovpn_priv *ovpn = info->user_ptr[0];
>>>>>> +	struct ovpn_socket *ovpn_sock;
>>>>>> +	struct socket *sock = NULL;
>>>>>> +	struct ovpn_peer *peer;
>>>>>> +	u32 sockfd, peer_id;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	/* peers can only be added when the interface is up and running */
>>>>>> +	if (!netif_running(ovpn->dev))
>>>>>> +		return -ENETDOWN;
>>>>>
>>>>> Since we're not under rtnl_lock here, the device could go down while
>>>>> we're creating this peer, and we may end up with a down device that
>>>>> has a peer anyway.
>>>>
>>>> hmm, indeed. This means we must hold the rtnl_lock to prevent ending up in
>>>> an inconsistent state.
>>>>
>>>>>
>>>>> I'm not sure what this (and the peer flushing on NETDEV_DOWN) is
>>>>> trying to accomplish. Is it a problem to keep peers when the netdevice
>>>>> is down?
>>>>
>>>> This is the result of my discussion with Sergey that started in v23 5/23:
>>>>
>>>> https://lore.kernel.org/r/netdev/20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net/
>>>>
>>>> The idea was to match operational state with actual connectivity to peer(s).
>>>>
>>>> Originally I wanted to simply kee the carrier always on, but after further
>>>> discussion (including the meaning of the openvpn option --persist-tun) we
>>>> agreed on following the logic where an UP device has a peer connected (logic
>>>> is slightly different between MP and P2P).
>>>>
>>>> I am not extremely happy with the resulting complexity, but it seemed to be
>>>> blocker for Sergey.
>>>
>>> [after re-reading that discussion with Sergey]
>>>
>>> I don't understand why "admin does 'ip link set tun0 down'" means "we
>>> should get rid of all peers. For me the carrier situation goes the
>>> other way: no peer, no carrier (as if I unplugged the cable from my
>>> ethernet card), and it's independent of what the user does (ip link
>>> set XXX up/down). You have that with netif_carrier_{on,off}, but
>>> flushing peers when the admin does "ip link set tun0 down" is separate
>>> IMO.
>>
>> The reasoning was "the user is asking the VPN to go down - it should be
>> assumed that from that moment on no VPN traffic whatsoever should flow in
>> either direction".
>> Similarly to when you bring an Eth interface dwn - the phy link goes down as
>> well.
>>
>> Does it make sense?
> 
> I'm not sure. If I turn the ovpn interface down for a second, the
> peers are removed. Will they come back when I bring the interface back
> up?  That'd have to be done by userspace (which could also watch for
> the DOWN events and tell the kernel to flush the peers) - but some of
> the peers could have timed out in the meantime.
> 
> If I set the VPN interface down, I expect no packets flowing through
> that interface (dropping the peers isn't necessary for that), but all
> non-data (key exchange etc sent by openvpn's userspace) should still
> go through, and IMO peer keepalive fits in that "non-data" category.

This was my original thought too and my original proposal followed this 
idea :-)

However Sergey had a strong opinion about "the user expect no traffic 
whatsoever".

I'd be happy about going again with your proposed approach, but I need 
to be sure that on the next revision nobody will come asking to revert 
this logic again :(

> 
> 
> What does openvpn currently do if I do
>      ip link set tun0 down ; sleep 5 ; ip link set tun0 up
> with a tuntap interface?

I think nothing happens, because userspace doesn't monitor the netdev 
status. Therefore, unless tun closed the socket (which I think it does 
only when the interface is destroyed), userspace does not even realize 
that the interface went down.

Regards,

> 

-- 
Antonio Quartulli
OpenVPN Inc.


