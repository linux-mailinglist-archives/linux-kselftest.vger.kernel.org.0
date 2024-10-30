Return-Path: <linux-kselftest+bounces-21160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318359B6E38
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3DC282145
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 20:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE5420604B;
	Wed, 30 Oct 2024 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Xl95dUNS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4219CC24
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321884; cv=none; b=YUCMQME/ptxa6/lyaSh++PfKMnoeF7kLe5To0nVqT4hwF2QkgnC/DZBZDGfu3qyg7d0PofBvRZQlc3NLbbbHy0yNMlwEVhk/PvYG937RLLwmufvGzN0dAGor1cGf0pXJOMefYDPidJ1o2ATJFw4o2kSU5P/pCsfbc/PXepR7+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321884; c=relaxed/simple;
	bh=i/1Qa3FWUpi7jl8R5KZcjwqYnJSOvQSdA04yPxmOGE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLcxLqTdi6ZmQwn0DFOh1HLSCrkAjGax+n5gWOIjQZGqU8cw644Y4yhGbbQYGIjgZP6UkcgVKxEz5ekeBX5t7nJ424Gkar/Gy+QSFpA/j05vNktbP+NXOUY9LnG57BAItAQAhzoQDpvGudpjij8a1YHcWoRJE6NSw9R9gvsEVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Xl95dUNS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so2213665e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 13:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730321880; x=1730926680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SN5iKKgACryua0sxDhTtQQnF+tdLag5QxV/KT7cwFRQ=;
        b=Xl95dUNSarL/gzjZhlas13cLJwLrLNu9imiWk14vVTLYbmK7SosWJ9x993dDnVGoFz
         wGNSe2UOZ3cAovw4sfIQN1h3AQnFjcpxOwhLOsRZeDHN007wYudWkRjRE6CKrA+uD11v
         fHzM0ljcATb1Rvwvx+VxZRDtfinJG8zk43amyRgLAA/6RAAY+l5UwENHbcCdvXSUCK1N
         sVqMnwRo+VtD9vxIBr597OLjvVeVxjUMB1Fg5Ob+hwIw5YsWbX0+bQih7JicLKAbf+c7
         jZKKkDwIuGB03EtM0dhRD2swv20/tvROQxKK1yAFl9S7fhzRruVWnrj8fVPhiYD5YYwQ
         SzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321880; x=1730926680;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SN5iKKgACryua0sxDhTtQQnF+tdLag5QxV/KT7cwFRQ=;
        b=PBGX7tzhA5/HhRa2iU5WEnIdWFeg4fj4kLJbnnlpW0ZRKBRkAMzRGVZ96rvbuhhmry
         ZhX4T5kK+Lzq1I8P1lKRzqPgg9pDoK2VBPD1wgvPIgiZtfwkDkdXe6q18ABvoLOfyGWS
         Dk/qfeMisYWqMNcH8GYmgsNFS+IhdaWLuHFGuhBhWjp9kH1e5H/dg3h+Z86OEkntOHkB
         XJ3y69w9cGk/0fubddhpbqsEqfzIB1Nz4VntmexpX9Iuc0K3vrpxuqLjwggj4po//2ba
         bw5pgQzs1RAVTsyCrZ1J6m8s5NaXZKrAGt5geAx0s5UwmZduMZhSYyJqYMxdfb3IY/p1
         i1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVulFjwoKXhtULNsSIsofVdwNfIacKaIMwWsamrKGN+BuC4WZxDldkKgQoWborpPI1chAWPElf5ZilOQk15CWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTjt9CG6nW5y4+iPSsCNL8xXT/bDv8unIZRcftMxU8sdgouU+1
	W0nd+7+9iDYt3LdooXtGIaPHL/SAOZVmZIYeMK42BNC9gABgnDypMs/zpsFdjME=
X-Google-Smtp-Source: AGHT+IEUhyR6K6nh/IDmkibbUslakzmYM2gD9Wm2X3s1io2zDV4LvwzM6GwKXLhz9+LmWUz6Igz7hA==
X-Received: by 2002:a05:600c:19d3:b0:431:46fe:4cad with SMTP id 5b1f17b1804b1-4319ac9b4bbmr145381885e9.9.1730321879800;
        Wed, 30 Oct 2024 13:57:59 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:3ca3:4955:91d7:e8e1? ([2001:67c:2fbc:1:3ca3:4955:91d7:e8e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d685278sm1532275e9.36.2024.10.30.13.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 13:57:59 -0700 (PDT)
Message-ID: <33aa1e2c-37e8-48ff-9589-f5cd7f4914ea@openvpn.net>
Date: Wed, 30 Oct 2024 21:58:15 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 08/23] ovpn: implement basic TX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net> <ZyJpcbHJI5MqZHVB@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZyJpcbHJI5MqZHVB@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2024 18:14, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:21 +0100, Antonio Quartulli wrote:
>> +static void ovpn_send(struct ovpn_struct *ovpn, struct sk_buff *skb,
>> +		      struct ovpn_peer *peer)
>> +{
>> +	struct sk_buff *curr, *next;
>> +
>> +	if (likely(!peer))
>> +		/* retrieve peer serving the destination IP of this packet */
>> +		peer = ovpn_peer_get_by_dst(ovpn, skb);
>> +	if (unlikely(!peer)) {
>> +		net_dbg_ratelimited("%s: no peer to send data to\n",
>> +				    ovpn->dev->name);
>> +		dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +		goto drop;
>> +	}
>> +
>> +	/* this might be a GSO-segmented skb list: process each skb
>> +	 * independently
>> +	 */
>> +	skb_list_walk_safe(skb, curr, next)
> 
> nit (if you end up reposting): there should probably be some braces
> around the (multi-line) loop body.

ACK

> 
>> +		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
>> +			dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +			kfree_skb(curr);
>> +		}
> 
>> +void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
>> +		       struct sk_buff *skb)
>> +{
> [...]
>> +	/* crypto layer -> transport (UDP) */
>> +	pkt_len = skb->len;
>> +	ret = ovpn_udp_output(ovpn, bind, &peer->dst_cache, sock->sk, skb);
>> +
>> +out_unlock:
>> +	rcu_read_unlock();
>> +out:
>> +	if (unlikely(ret < 0)) {
>> +		dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +		kfree_skb(skb);
>> +		return;
>> +	}
>> +
>> +	dev_sw_netstats_tx_add(ovpn->dev, 1, pkt_len);
> 
> If I'm following things correctly, that's already been counted:
> 
> ovpn_udp_output -> ovpn_udp4_output -> udp_tunnel_xmit_skb
>                                      -> iptunnel_xmit
>                                      -> iptunnel_xmit_stats
> 
> which does (on success) the same thing as dev_sw_netstats_tx_add. On

Right. This means we can remove that call to tx_add().

> failure it increments a different tx_dropped counter than what
> dev_core_stats_tx_dropped_inc, but they should get summed in the end.

It seems they are summed up in dev_get_tstats64(), therefore I should 
remove the tx_dropped_inc() call to avoid double counting.

Thanks!

Cheers,

> 
>> +}
> 

-- 
Antonio Quartulli
OpenVPN Inc.


