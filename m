Return-Path: <linux-kselftest+bounces-21867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835FB9C5A1F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 15:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B402836BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4C21FC7F3;
	Tue, 12 Nov 2024 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Sz9E9+ZA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A71FCC59
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421170; cv=none; b=kTRyxFTQUMu1oik+ANwLfvd5Bv9C34Icn42l3yoen5LshdQ+K+a3HgVx+u+EhL/XReIQH7GNmZOKRG4EBQyRWWZ/yPsQgjLA0a4R7JEcvI5QVvsuBShoAPiRIMfPVco2zwk8XYUW2434KUZ3ulKzwAT+YPbfRXf1R7LdokhbWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421170; c=relaxed/simple;
	bh=UgWGUxQrgroW2O3xwz7zrSkFTRT1Hzi0vM7s2113muM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UX7wqkz5oaIFMvSweGW9iNJ96baGA2nUqW3WW86rHV8+0ngJgLGPnknxlNcqBB/bmpqeb+IfQf0NT0qxWxqmXEvZlECw3zw+qwnPsMTGovzu8e6SDLKThA0oWJdjupaegKyqljnPTkIHV0A7In0R+BFwfANui0TBrqJOkd2+lqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Sz9E9+ZA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso72217935e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 06:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731421167; x=1732025967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ouwpe3U1VNNXY4rrBgXu/Mf/TO0yFXkbYc5of/uzJGU=;
        b=Sz9E9+ZAg79HitsHUKV5c7XCzGFm04CUdhGPqcFIMHRlAT1z3X0dPC4USZPbBD9ymQ
         YP9GAJcEAut7qZoy6kcKhynENEXH9MNkgnpzj/y5YbGF+5meYRT9o194swCWhgmv1xkm
         vMjCZNNDuLTZysDh0kC+Zpfz4vQotHhfS9KkqJRdE6iRKgIDxPHS96uKUkAToNsywbXY
         fBspIcmi3IOA+m5ijNF/DLBaDToArB7eqY05N3UhZ1xAqEdE9gGPBt9uS8D/RmeNysT4
         +CRloFgi+k/Kzu+l7Q3mYsIn15ZXwd8hoz5tJ6i1wARu4DR+62kKAZNmJqV6vic20AYk
         rBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731421167; x=1732025967;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ouwpe3U1VNNXY4rrBgXu/Mf/TO0yFXkbYc5of/uzJGU=;
        b=e+Cie0VZ6gR/V2Ddp4GR7KZoFTRZMlxY77GH47lp9Be+TYtXwYf0/sMIFK71bjp+Tj
         vOS3DDopGmds/O/yJUYLqS2GwreqtYYPfMAnToZyCJm7TEpgeUi4TNPRO9f4dNo8nM8b
         HYKe7nYLNjqGPnuK+XnmDelOQ+wDBLd7zvMUAh3XaOc95eyKqazK185P7mrpVPZYfaj+
         1EpMMGe3hXMZL/3Dt8iE+W6TCqYem5HhK7gaCAAqVmJxeU/rknlTy/H31bEp1WInBYZh
         O0tCsn9XTyoXd2wpheTyVvc7wS1sl5lNg4Sv8fdtyVfXrlNEoeQgtrlu5qg2ZxwrkR9/
         5/pw==
X-Forwarded-Encrypted: i=1; AJvYcCV77GbxKpuKuJB7gUq4rHhODaGrYVhdAo0rywz1WU/aUDol0+Xi0yK/QrQammrKu/R28fo+CMuKc9RZLwGBR4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxS6fjhR2ZahwKtWRdaEHZLr1pRiU4377huxv8NqwBymmUfbg
	rg5Hy2EOI1XQfepluYbZpWVj6gKEB2Eiufsd7cqSvWwL7fUO/+qRei044babrkI=
X-Google-Smtp-Source: AGHT+IFcXxQ5/fzYuiypE24Dq1y2dgnucVzcXyurE+jz5OGLSXY1VVEfoMoIbV9WUXIWhEEhUbN6fg==
X-Received: by 2002:a05:600c:1c9b:b0:431:5c7b:e939 with SMTP id 5b1f17b1804b1-432b750b52amr194451145e9.18.1731421166382;
        Tue, 12 Nov 2024 06:19:26 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:e829:c484:5241:93b2? ([2001:67c:2fbc:1:e829:c484:5241:93b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5b96sm219599745e9.41.2024.11.12.06.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:19:25 -0800 (PST)
Message-ID: <76191b85-6844-4a85-bb9c-ad19aa5110c5@openvpn.net>
Date: Tue, 12 Nov 2024 15:19:50 +0100
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
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zyjk781vOqV4kXhJ@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2024 16:14, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
>> +static int ovpn_nl_peer_precheck(struct ovpn_struct *ovpn,
>> +				 struct genl_info *info,
>> +				 struct nlattr **attrs)
>> +{
>> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
>> +			      OVPN_A_PEER_ID))
>> +		return -EINVAL;
>> +
>> +	if (attrs[OVPN_A_PEER_REMOTE_IPV4] && attrs[OVPN_A_PEER_REMOTE_IPV6]) {
>> +		NL_SET_ERR_MSG_MOD(info->extack,
>> +				   "cannot specify both remote IPv4 or IPv6 address");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
>> +	    !attrs[OVPN_A_PEER_REMOTE_IPV6] && attrs[OVPN_A_PEER_REMOTE_PORT]) {
>> +		NL_SET_ERR_MSG_MOD(info->extack,
>> +				   "cannot specify remote port without IP address");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
>> +	    attrs[OVPN_A_PEER_LOCAL_IPV4]) {
>> +		NL_SET_ERR_MSG_MOD(info->extack,
>> +				   "cannot specify local IPv4 address without remote");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!attrs[OVPN_A_PEER_REMOTE_IPV6] &&
>> +	    attrs[OVPN_A_PEER_LOCAL_IPV6]) {
> 
> I think these consistency checks should account for v4mapped
> addresses. With remote=v4mapped and local=v6 we'll end up with an
> incorrect ipv4 "local" address (taken out of the ipv6 address's first
> 4B by ovpn_peer_reset_sockaddr). With remote=ipv6 and local=v4mapped,
> we'll pass the last 4B of OVPN_A_PEER_LOCAL_IPV6 to
> ovpn_peer_reset_sockaddr and try to read 16B (the full ipv6 address)
> out of that.

Right, a v4mapped address would fool this check.
How about checking if both or none addresses are v4mapped? This way we 
should prevent such cases.


> 
>> +		NL_SET_ERR_MSG_MOD(info->extack,
>> +				   "cannot specify local IPV6 address without remote");
>> +		return -EINVAL;
>> +	}
> 
> 
> [...]
>>   int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
> [...]
>> +	ret = ovpn_nl_peer_modify(peer, info, attrs);
>> +	if (ret < 0) {
>> +		ovpn_peer_put(peer);
>> +		return ret;
>> +	}
>> +
>> +	/* ret == 1 means that VPN IPv4/6 has been modified and rehashing
>> +	 * is required
>> +	 */
>> +	if (ret > 0) {
> 
> && mode == MP ?
> 
> I don't see ovpn_nl_peer_modify checking that before returning 1, and
> in P2P mode ovpn->peers will be NULL.

Right.
I was wondering if it's better to add the check on the return statement 
of ovpn_nl_peer_modify...but I think it's more functional to add it 
here, as per your suggestion.

> 
>> +		spin_lock_bh(&ovpn->peers->lock);
>> +		ovpn_peer_hash_vpn_ip(peer);
>> +		spin_unlock_bh(&ovpn->peers->lock);
>> +	}
>> +
>> +	ovpn_peer_put(peer);
>> +
>> +	return 0;
>> +}
> 
>>   int ovpn_nl_peer_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>>   {
> [...]
>> +	} else {
>> +		rcu_read_lock();
>> +		hash_for_each_rcu(ovpn->peers->by_id, bkt, peer,
>> +				  hash_entry_id) {
>> +			/* skip already dumped peers that were dumped by
>> +			 * previous invocations
>> +			 */
>> +			if (last_idx > 0) {
>> +				last_idx--;
>> +				continue;
>> +			}
> 
> If a peer that was dumped during a previous invocation is removed in
> between, we'll miss one that's still present in the overall dump. I
> don't know how much it matters (I guses it depends on how the results
> of this dump are used by userspace), so I'll let you decide if this
> needs to be fixed immediately or if it can be ignored for now.

True, this is a risk I assumed.
Not extremely important if you ask me, but do you have any suggestion 
how to avoid this in an elegant and lockless way?

IIRC I got inspired by the station dump in the mac80211 code, which 
probably assumes the same risk.

> 
>> +
>> +			if (ovpn_nl_send_peer(skb, info, peer,
>> +					      NETLINK_CB(cb->skb).portid,
>> +					      cb->nlh->nlmsg_seq,
>> +					      NLM_F_MULTI) < 0)
>> +				break;
>> +
>> +			/* count peers being dumped during this invocation */
>> +			dumped++;
>> +		}
>> +		rcu_read_unlock();
>> +	}
>> +
>> +out:
>> +	netdev_put(ovpn->dev, &ovpn->dev_tracker);
>> +
>> +	/* sum up peers dumped in this message, so that at the next invocation
>> +	 * we can continue from where we left
>> +	 */
>> +	cb->args[1] += dumped;
>> +	return skb->len;
>>   }
>>   
>>   int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
>> +	struct ovpn_struct *ovpn = info->user_ptr[0];
>> +	struct ovpn_peer *peer;
>> +	u32 peer_id;
>> +	int ret;
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
>> +		return -EINVAL;
>> +
>> +	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
>> +			       ovpn_peer_nl_policy, info->extack);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
>> +			      OVPN_A_PEER_ID))
>> +		return -EINVAL;
>> +
>> +	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
>> +
>> +	peer = ovpn_peer_get_by_id(ovpn, peer_id);
>> +	if (!peer)
> 
> maybe c/p the extack from ovpn_nl_peer_get_doit?

Yes, will do.

Thanks a lot.
Regards,

> 
>> +		return -ENOENT;
>> +
>> +	netdev_dbg(ovpn->dev, "%s: peer id=%u\n", __func__, peer->id);
>> +	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
>> +	ovpn_peer_put(peer);
>> +
>> +	return ret;
>>   }
> 

-- 
Antonio Quartulli
OpenVPN Inc.


