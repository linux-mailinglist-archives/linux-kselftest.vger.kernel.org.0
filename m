Return-Path: <linux-kselftest+bounces-24902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42665A1885B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 00:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C4B164761
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 23:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5894F1F8F0C;
	Tue, 21 Jan 2025 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KqSnP1X8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5DC1F8AFB
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737501959; cv=none; b=fxcyJm/87KnnpKenuwBGDYSNacKRKNw6Jbh2kORNmla4P66Llah4eXLGcY3Qib8NjSiMCcDquxxOC91R20gAuFP0mOOibLItuxwOfajK06FAnWdYemCEXYNYPAjcrnsu+IvE6kI2JKdYVhYe8mzMOPqxBus8HlEoZ/r+8xoW/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737501959; c=relaxed/simple;
	bh=cz/dVmW3aJtt8LKJn620gaLE9dIYgrPkUQzRMTgPKPI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=noY+FryD5kOMetEOVUtWLmwVEfrLFi+gjO1krYgpG/OFwokqf0OBe2qf4M5hoVlq3+8ZgIDWmX9p7cUzy5mUg6fDDgPocwu4NpW8HsGbpNBn7VyefS023zNRHF9kSdWQvkb8R0LYCdZFexFvEAvlIUn+1fo72pFReXoHMIlXPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KqSnP1X8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5da135d3162so10604899a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 15:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737501955; x=1738106755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3FkubpiIgIYRe5Vu+aYS/Wgeny8/cbFGmsF+cMds14=;
        b=KqSnP1X8eE8aRBTAyFCPlWkKVBzqJrj08uXjUq9RvadZL3ALPYMMupqeNG4G83o8WA
         P/x2WwFKnv9d7znIyyrR2BV0TT87yi1ZdczIAdj3yJaXwzn8+DJRXTRl26iZw8IS0hvA
         suqkzDINZeblUt/ALZfWM1wOOiapMZSr11jdR5pZ9X8lRy4iEjalT6n0CexOrTpc64+v
         nI/UQxhJQAAUohyd6pAR4mRlf2qdSoCGqLNxE3HuKTue57idE7pzs2iigUJ1ttH1A0IJ
         LXxaYGHW0wqZCyA5yc9hkvIRSGm9J7wwdejUuyHTSOi23LGvGbNEYqagXkXhsIuIW3fh
         LdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737501955; x=1738106755;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A3FkubpiIgIYRe5Vu+aYS/Wgeny8/cbFGmsF+cMds14=;
        b=NjSgYsIxXSv3fRoTxnkkIQQ5nXSeB4TtS1FYGTWHFff9QZOJVD41Vs06XVNpf8CcE6
         L3XuP3dQR8x24dN5mNO+ukfswiFE/onOJTez5akb1YykJaWIWm1rmi9l57HaNjnYtzlB
         P7ZHfMD0EkNoeGQOKWS8lOR6AJJDs3ZfpyL9mNiuppn+104mT4oobayA+0+m1A3/QuCN
         F4AN2Mk0lwdJOBcBOYjKJ4S+nJ/ADV0TNx00bln2e/lb6xWk+iSOgO+gREKtPuL5x9Iy
         OScw11dWiZQzmcWRn8R/18mNQF9pgKQJ0nQsgLiWFqN4HFkwK9UVwc0Dt6qqbnT4Wwfh
         hNsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNjuV9x+md44FMOF9kLilPYDyzWJAKU0WLHCqZ1nAXDrFqmM6v6KyFWZMWnCObK3eUuQn0pB7VFQthkBDllY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoiGeAOv+EJqHHCUT21RnM0MPb7SB4RtJlSnP0SEs8HGAGe86k
	GHkmuYiNSaB96ygkwcwnwPCPDzdV29xzOYkjqMoywq+1T8HKMNcGLWs/6+QfeAQ=
X-Gm-Gg: ASbGncvX0w16fmVDInL6Qyt7kmfizqh1HwhinX/jTBzj2m9RoPFnZmRnXJsR6rbqCsg
	3FoyaCZRIXSFaVHEHEsBnPwbxA/eG/RaBCLGGWNWiI+WzzdhT/PLb9ndvUwcC83Fhdb6yK7t/lX
	mYP3BkvnCRjIYOMXzwOxlgP1tFq7oSa2ZHZbgoUuU/4MqD4bOCtAgMynG5/kyxGQRIYRrhDCGuc
	pnzKnuAkxQ8XVijkiJ+12Y0r8F010MotHUkutznSTYSoeRhqfZRlN5hqmmlAn3e+4BdLLH6uOJY
	VYHUjGevk0BhU0YgdWhFNHL0BS+ARSKo
X-Google-Smtp-Source: AGHT+IF1N+2ejampxFsnZTvz1u8McOE3PVljexZG/PH7R1gxmqLbjNZfulX2Cc67rEf4xDeOdzUtlA==
X-Received: by 2002:a05:6402:1ed4:b0:5d2:7199:ae6 with SMTP id 4fb4d7f45d1cf-5db7d2f591emr17933035a12.9.1737501955337;
        Tue, 21 Jan 2025 15:25:55 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:2b1b:6df9:ad3c:c183? ([2001:67c:2fbc:1:2b1b:6df9:ad3c:c183])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dbcfb8ff37sm2461596a12.72.2025.01.21.15.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 15:25:53 -0800 (PST)
Message-ID: <10bb8eb7-fdcc-4ab6-8ddb-52491933659e@openvpn.net>
Date: Wed, 22 Jan 2025 00:26:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
From: Antonio Quartulli <antonio@openvpn.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net> <Z4pDpqN2hCc-7DGt@hog>
 <30c50783-096b-4114-aa55-c3edbeb38d49@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <30c50783-096b-4114-aa55-c3edbeb38d49@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/01/2025 15:52, Antonio Quartulli wrote:
> On 17/01/2025 12:48, Sabrina Dubroca wrote:
> [...]
>> -------- 8< --------
>>
>> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
>> index 72357bb5f30b..19aa4ee6d468 100644
>> --- a/drivers/net/ovpn/netlink.c
>> +++ b/drivers/net/ovpn/netlink.c
>> @@ -733,6 +733,9 @@ int ovpn_nl_peer_del_doit(struct sk_buff *skb, 
>> struct genl_info *info)
>>       netdev_dbg(ovpn->dev, "del peer %u\n", peer->id);
>>       ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
>> +    if (ret >= 0 && peer->sock)
>> +        wait_for_completion(&peer->sock_detach);
>> +
>>       ovpn_peer_put(peer);
>>       return ret;
>> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
>> index b032390047fe..6120521d0c32 100644
>> --- a/drivers/net/ovpn/peer.c
>> +++ b/drivers/net/ovpn/peer.c
>> @@ -92,6 +92,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv 
>> *ovpn, u32 id)
>>       ovpn_peer_stats_init(&peer->vpn_stats);
>>       ovpn_peer_stats_init(&peer->link_stats);
>>       INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
>> +    init_completion(&peer->sock_detach);
>>       ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
>>       if (ret < 0) {
>> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
>> index 7a062cc5a5a4..8c54bf5709ef 100644
>> --- a/drivers/net/ovpn/peer.h
>> +++ b/drivers/net/ovpn/peer.h
>> @@ -112,6 +112,7 @@ struct ovpn_peer {
>>       struct rcu_head rcu;
>>       struct work_struct remove_work;
>>       struct work_struct keepalive_work;
>> +    struct completion sock_detach;
>>   };
>>   /**
>> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
>> index a5c3bc834a35..7cefac42c3be 100644
>> --- a/drivers/net/ovpn/socket.c
>> +++ b/drivers/net/ovpn/socket.c
>> @@ -31,6 +31,8 @@ static void ovpn_socket_release_kref(struct kref *kref)
>>       sockfd_put(sock->sock);
>>       kfree_rcu(sock, rcu);
>> +
>> +    complete(&sock->peer->sock_detach);

I am moving this line to ovpn_socket_put(), right after kref_put() so 
that every peer going through the socket release will get their 
complete() invoked.

If the peer happens to be the last one owning the socket, kref_put() 
will first do the detach and only then complete() gets called.

This requires ovpn_socket_release/put() to take the peer as argument, 
but that's ok.

This way we should achieve what we needed.


Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


