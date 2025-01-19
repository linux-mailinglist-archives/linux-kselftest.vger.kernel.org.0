Return-Path: <linux-kselftest+bounces-24758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490DAA161E8
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Jan 2025 14:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6788716478A
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Jan 2025 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FF21DED70;
	Sun, 19 Jan 2025 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SNl/J3nv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94671CEE90
	for <linux-kselftest@vger.kernel.org>; Sun, 19 Jan 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737292274; cv=none; b=jeXAIJPjH7gufVQDiCTCEaYz2sBzb5E7tRPKG9sGOU2e44Y7bEGJtLiOcKGua54CBqFw9ndCZLlxH74DpbrQ2JShM4f+mG3jDJajaFmi2OLm0aKYMlkWbjNxnr1HtRz8bvzThNPsbmDzfkHs7i25Rygv7N+uVEqIfkzmuhXmYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737292274; c=relaxed/simple;
	bh=PxI044HcFUa7vo46CtAGYtaeG6xvBBraLHlWYnC24LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPxdVg16i0DKiOc/SL8R2C6AN83RxxcdWO9lDc92CbFqZgKJ9H4q+F2gcEJIiyE3bcsafmBgU/xf/wmRPgNX3+dc/PIsqgLnDbeUvhPyzy3CuVkLVHGvnqyAYs3gCE5EtpMHDUrKooAmqaJAg0S6IXFiF+HP0TQqlxXmhFPayjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SNl/J3nv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa69107179cso694886766b.0
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Jan 2025 05:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737292270; x=1737897070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mLE5zt1xaA0hZzhsIEoFc6P+/bMCydwGdk/j7kCZS0Y=;
        b=SNl/J3nv58XsCh5NplO4KQmOuIG+d/+OH4BzhpCQR6QM3NCfYVUqNxdhxh/mdwn03h
         FQR7vooUnkj6Xr7bNqbEjdwr9gd7ycYftt24QQomdfec8mULHtey34yNtm9Y/p1v5cGh
         w0oBfGR9kiVkmUZriFllvzXtfXgHLi4izLO4+sefXm/NO5igK6dfUakK2lpg5caAKNvT
         C5tPyllOVZSdvQD9d6tVaG2gcy7mXOoY0IKRYIsWJv2DJwQwyzW5bh3QGq/WWWug2r66
         dz9Uj+0G3wUyG4XBAc6MtuIa96BYY1WL9ZMWY9LUXXhc5Zg65gSLNRvWBn9nwYuLvXk+
         DopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737292270; x=1737897070;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLE5zt1xaA0hZzhsIEoFc6P+/bMCydwGdk/j7kCZS0Y=;
        b=RCXR3/rYvRr+OQi6v4wi9tyPScPy//OtbJHAoQYWjIEH74cCRgqpU6deEgX3UGWfL8
         B/AmvsG73+pUzPbj9l6K6YV41a7JgmDqcW2BhZ6ymW3VaYpcIVwRLJktqTm7rmO/PHQ1
         RwyddJa/3ELKPLUhhV0tPdZLseEEJA6KVLHe1wOwhcVPb3zWjqBibKOGWf+00j1DT6Bv
         a7dikFpaVU6woqMfKaeR0SExPqimrj+9Jn4eiJg+3Iu5QhH19SJGyL4nqeyzgV4BFM2X
         rPcgBtF7+mcudRAxC4le6PSSktr2qULnojjJxRvvlZR4KSh8R6pgiWPJKTv4EIikSGel
         lXsw==
X-Forwarded-Encrypted: i=1; AJvYcCUzWmyxiBKj8ZZ0ApmJYS5bZmpwKp3vXqnAO3VlH4FmxEVf7JzXvpJNVW19lEJI2rs9utZn9Fm1b1ReRP0Eirg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx13NJaTuc2rGPH/Acs71c4S1tL6B4rxRm4jIv/GUErkTgaL3HU
	GD2B+fLHgp6qZcibCCh4gJBjy0UXNWiq0Kpq44op0D4ywatDWvXuAF2f2wAyp1c=
X-Gm-Gg: ASbGncsyytHiQyJF43/jOnP81bI2pQoOiniyjLbbODPs87gxuk0957FXmzD8cLmq0+P
	MkEfh3eN8sZiwkPxX94UGKOcqwYklfcId9wFbHfPpkPXOUoPmjK3LhMurJvgVg0nNBhoDN6PKOj
	rU2E2GoE2wSjNwclLVsAsxOX9t231frl+BzFVBqSb8TWm+Nkrej10CWcC/Va2G/O3cs3jb9OFRA
	UNXV0i1sZ0Zsuj/Kj3HHukyoeCPROXCxMXtxr0z4BQSGji6DVDbj9M+6Zl9ToF6M/d3lZ/7LbfA
	EMQOWxm1mSUKNrIP98/df5aEmEOfid3B
X-Google-Smtp-Source: AGHT+IECCAXGKK9MG0B2ysJLsFIVmzVza0zDcuExngkVoVbTv2s1ukNPkm2y+Lev4w9cF/BG3T7IGg==
X-Received: by 2002:a17:907:72d0:b0:aae:8841:2bba with SMTP id a640c23a62f3a-ab38b15c348mr737215566b.22.1737292269923;
        Sun, 19 Jan 2025 05:11:09 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:eae3:ef5c:298c:e3cc? ([2001:67c:2fbc:1:eae3:ef5c:298c:e3cc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce1bacsm489479966b.53.2025.01.19.05.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 05:11:09 -0800 (PST)
Message-ID: <33710520-5f4f-4d33-a28d-99dc64afc9c3@openvpn.net>
Date: Sun, 19 Jan 2025 14:12:05 +0100
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
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z4qPjuK3_fQUYLJi@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2025 18:12, Sabrina Dubroca wrote:
> 2025-01-17, 13:59:35 +0100, Antonio Quartulli wrote:
>> On 17/01/2025 12:48, Sabrina Dubroca wrote:
>>> 2025-01-13, 10:31:39 +0100, Antonio Quartulli wrote:
>>>>    int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
>>>>    {
>>>> -	return -EOPNOTSUPP;
>>>> +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
>>>> +	struct ovpn_priv *ovpn = info->user_ptr[0];
>>>> +	struct ovpn_socket *ovpn_sock;
>>>> +	struct socket *sock = NULL;
>>>> +	struct ovpn_peer *peer;
>>>> +	u32 sockfd, peer_id;
>>>> +	int ret;
>>>> +
>>>> +	/* peers can only be added when the interface is up and running */
>>>> +	if (!netif_running(ovpn->dev))
>>>> +		return -ENETDOWN;
>>>
>>> Since we're not under rtnl_lock here, the device could go down while
>>> we're creating this peer, and we may end up with a down device that
>>> has a peer anyway.
>>
>> hmm, indeed. This means we must hold the rtnl_lock to prevent ending up in
>> an inconsistent state.
>>
>>>
>>> I'm not sure what this (and the peer flushing on NETDEV_DOWN) is
>>> trying to accomplish. Is it a problem to keep peers when the netdevice
>>> is down?
>>
>> This is the result of my discussion with Sergey that started in v23 5/23:
>>
>> https://lore.kernel.org/r/netdev/20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net/
>>
>> The idea was to match operational state with actual connectivity to peer(s).
>>
>> Originally I wanted to simply kee the carrier always on, but after further
>> discussion (including the meaning of the openvpn option --persist-tun) we
>> agreed on following the logic where an UP device has a peer connected (logic
>> is slightly different between MP and P2P).
>>
>> I am not extremely happy with the resulting complexity, but it seemed to be
>> blocker for Sergey.
> 
> [after re-reading that discussion with Sergey]
> 
> I don't understand why "admin does 'ip link set tun0 down'" means "we
> should get rid of all peers. For me the carrier situation goes the
> other way: no peer, no carrier (as if I unplugged the cable from my
> ethernet card), and it's independent of what the user does (ip link
> set XXX up/down). You have that with netif_carrier_{on,off}, but
> flushing peers when the admin does "ip link set tun0 down" is separate
> IMO.

The reasoning was "the user is asking the VPN to go down - it should be 
assumed that from that moment on no VPN traffic whatsoever should flow 
in either direction".
Similarly to when you bring an Eth interface dwn - the phy link goes 
down as well.

Does it make sense?

> 
> [...]
>>>>    int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
>>>>    {
>>>> -	return -EOPNOTSUPP;
>>>> +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
>>>> +	struct ovpn_priv *ovpn = info->user_ptr[0];
>>>> +	struct ovpn_peer *peer;
>>>> +	u32 peer_id;
>>>> +	int ret;
>>>> +
>>>> +	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
>>>> +			       ovpn_peer_nl_policy, info->extack);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
>>>> +			      OVPN_A_PEER_ID))
>>>> +		return -EINVAL;
>>>> +
>>>> +	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
>>>> +	peer = ovpn_peer_get_by_id(ovpn, peer_id);
>>>> +	if (!peer) {
>>>> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
>>>> +				       "cannot find peer with id %u", peer_id);
>>>> +		return -ENOENT;
>>>> +	}
>>>> +
>>>> +	netdev_dbg(ovpn->dev, "del peer %u\n", peer->id);
>>>> +	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
>>>
>>> With the delayed socket release (which is similar to what was in v11,
>>> but now with refcounting on the netdevice which should make
>>> rtnl_link_unregister in ovpn_cleanup wait [*]), we may return to
>>> userspace as if the peer was gone, but the socket hasn't been detached
>>> yet.
>>>
>>> A userspace application that tries to remove the peer and immediately
>>> re-create it with the same socket could get EBUSY if the workqueue
>>> hasn't done its job yet. That would be quite confusing to the
>>> application.
>>
>> This may happen only for TCP, because in the UDP case we would increase the
>> refcounter and keep the socket attached.
> 
> Not if we're re-attaching to a different ovpn instance/netdevice.

Right.
One more reason to go with the completion logic.

> 
>>
>> However, re-attaching the same TCP socket is hardly going to happen (in TCP
>> we have one socket per peer, therefore if the peer is going away, we're most
>> likely killing the socket too).
>>
>> This said, the complexity added by the completion seems quite tiny,
>> therefore I'll add the code you are suggesting below.
> 
> Ok.

Working on it!

Thanks!
Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


