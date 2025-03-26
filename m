Return-Path: <linux-kselftest+bounces-29809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A32ADA713EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 10:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BB116D77A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E21A3A80;
	Wed, 26 Mar 2025 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="T8MHJ5xH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663E15381A
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982110; cv=none; b=nyGAvnZPttP00aMal3vgx5Cg83SSWIztAIszVCqky1SO+Tw0ERPgKXnrbN/+FxXmBd+moVz7DpL5v1TdYkfO3SUZ/1iRTOsQZvoPRZl1fLd2bo57HOd0YD0CCJ3m+GlN+Lcb12U3cRsBFI9drVG1WUHFmawp57NlmATfZTmT9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982110; c=relaxed/simple;
	bh=ISabU0E3fu0452iayrNgZrmlLzjVXWIHFLotfHhziGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6QebRdw2dtyuFPcYPG6vWkCA6GimFHBnFqPx+HAxZ3o78uoGonULBvDFuEl16eVteInMXnWW2mHh2sw0o3FvsNUI7yWaJksLoYXHR4/lK06USSnU2TEEOzYtnpMMQERAYQMyYZOi4KklOax96zOYnUM5Fd5Rf+wGQgk3qgPpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=T8MHJ5xH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so32945565e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 02:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742982107; x=1743586907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GoU//2qfq0QPGRTFzA3Xn4cTBC1VtNTWsDdUYjJn3us=;
        b=T8MHJ5xHXQe755E1rHQPUxIzvf7djbE6Zls5qXv0RMyjyM/gIjY8xtSuWuqFJg5uFp
         of/1FxAU4cqU5fDn1G7b3XFm/CZZN7Ro/jynSvzpNx29/duVPX/MI0ssrYkNVe/Enp6S
         B59mAHJP4rfeCrHjYqp5XdwUkzxMd52ZGH1meXHdKUHG/3a9hIHE7oMCvW7F/+SLJbuX
         NIWXipceMWhnDO7W93Q38gMA34uWogcLhFkdWj2iMNtvywimSOiaBudWkgpLSvx2ildT
         nS+PTUOz2m9bTZJTewApd7Kx59whhRU6hqs/DAFh+lzF+mzB/BIJLdW3Kign2JdfTFwJ
         zRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742982107; x=1743586907;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoU//2qfq0QPGRTFzA3Xn4cTBC1VtNTWsDdUYjJn3us=;
        b=D6p6dzdTW4NlCR4q8lAkHl1mntxVrTk/8zRTgzbDz+g3Nw5iKWHCDp3jqhBtxos2Uk
         dD19pZDx032OkJjKK+KVxn6bng9oS1egLhI6aZmBfbAVJXiJMJzru0eXWfcRfuCoTho9
         Ah8etgg7k2AxEhASb9z7bdAQq1AuOIlnV5gVpAvHh6XdOufIpvkaHMiDwa3XbpwuK2Vh
         mlI9WtPjrToD0CHTXkTD/0lalzPnGBUfFzSW8x91jFF5bTAHs9ERHCMJkPVMP3HjA04r
         RKTEFH8AaKb/FWN7M9r7PZJ7kbpRB6ulVvMS1BCCT2kD+88y0dW033maFaI5Z9V0bnKz
         566A==
X-Forwarded-Encrypted: i=1; AJvYcCVHBInAFSxSvYT+9AJcuNzxe6dZXJgH2WhfTVYz7/Y+SNbd/NiFOr/y8nJtqOvgZM1NNY5Nv22PCEUcGZEVlZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7aygctxTTceTfhER9JnlpIVIxezHt0LhmaDB7XMBmCNNBhCO
	//OzSxlleyxLyeCtJVV0z0CRdoTDLw0N8QScSiWbTe7rseKnlQ39B0Vdd6ESNAUjmjYWeHRym1F
	/B78IU1RjcuJhYWEYcVh/C53I7hti65POmSb7dhqjt15UK7yKnWNsD6wVLtk=
X-Gm-Gg: ASbGnctaY5ITl4hrgUZZHUkzWEOng5woloYQgnewaaOWXEAxcDZnPQbi4n3d3aCKI4N
	cLKTTVo79am3bdtWd41bqQjMgDuieoq9tdgQf6nPlM3kLHyZOsAXtKhW0+o8sUduQvGJYLtHetn
	ghN7SOM3cIjMEPjlq37RRQk/8ejUUjdK0rDDq5jPZScDXx9F/ONQ/bcTByivMW9Dq7o6VdzkrkR
	eGGV21gnGY2bDmfJC5Y9ijcW+cDH4JcqFsGj4Bx/39loH3zplhp3P91KL1ouGuLFpxYDELVufLa
	ZdB37PS4+O+mZLOOsBfVKVjs5uF21h6n7Gc4G+IKkReTqKDW8ggigHqEdbAxjEpxXgPpYcIpvaI
	27w==
X-Google-Smtp-Source: AGHT+IEAGL9RFotWijGvXbqc5Rmo8PnluTujZdy1rqdwDnnrI1fEJ6aPUsyN/Y7fzirzHgDdr+n8MQ==
X-Received: by 2002:a05:600c:1e04:b0:43b:cd0d:9466 with SMTP id 5b1f17b1804b1-43d62c6121dmr114855335e9.9.1742982106558;
        Wed, 26 Mar 2025 02:41:46 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e3b:3856:9645:30d? ([2001:67c:2fbc:1:e3b:3856:9645:30d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f556afsm225873895e9.19.2025.03.26.02.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 02:41:46 -0700 (PDT)
Message-ID: <58712444-1de7-4076-b850-4c6035792931@openvpn.net>
Date: Wed, 26 Mar 2025 10:41:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v24 09/23] ovpn: implement packet processing
To: Qingfang Deng <dqfext@gmail.com>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Xiao Liang <shaw.leon@gmail.com>
References: <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net>
 <20250325020802.7632-1-dqfext@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250325020802.7632-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/03/2025 03:07, Qingfang Deng wrote:
[...]
>> -static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>> +void ovpn_decrypt_post(void *data, int ret)
>>   {
>> -	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
>> +	struct ovpn_crypto_key_slot *ks;
>> +	unsigned int payload_offset = 0;
>> +	struct sk_buff *skb = data;
>> +	struct ovpn_peer *peer;
>> +	__be16 proto;
>> +	__be32 *pid;
>> +
>> +	/* crypto is happening asynchronously. this function will be called
>> +	 * again later by the crypto callback with a proper return code
>> +	 */
>> +	if (unlikely(ret == -EINPROGRESS))
>> +		return;
>> +
>> +	payload_offset = ovpn_skb_cb(skb)->payload_offset;
>> +	ks = ovpn_skb_cb(skb)->ks;
>> +	peer = ovpn_skb_cb(skb)->peer;
>> +
>> +	/* crypto is done, cleanup skb CB and its members */
>> +
>> +	if (likely(ovpn_skb_cb(skb)->iv))
>> +		kfree(ovpn_skb_cb(skb)->iv);
> 
> NULL check before kfree is unnecessary, as kfree(NULL) is a noop.

Right, will drop the check.

> 
>> +
>> +	if (likely(ovpn_skb_cb(skb)->sg))
>> +		kfree(ovpn_skb_cb(skb)->sg);
>> +
>> +	if (likely(ovpn_skb_cb(skb)->req))
>> +		aead_request_free(ovpn_skb_cb(skb)->req);
> 
> Likewise.

ACK

> 
>>   
>>   	if (unlikely(ret < 0))
>>   		goto drop;
>>   
>> +	/* PID sits after the op */
>> +	pid = (__force __be32 *)(skb->data + OVPN_OPCODE_SIZE);
>> +	ret = ovpn_pktid_recv(&ks->pid_recv, ntohl(*pid), 0);
>> +	if (unlikely(ret < 0)) {
>> +		net_err_ratelimited("%s: PKT ID RX error for peer %u: %d\n",
>> +				    netdev_name(peer->ovpn->dev), peer->id,
>> +				    ret);
>> +		goto drop;
>> +	}
>> +
>> +	/* point to encapsulated IP packet */
>> +	__skb_pull(skb, payload_offset);
>> +
>> +	/* check if this is a valid datapacket that has to be delivered to the
>> +	 * ovpn interface
>> +	 */
>> +	skb_reset_network_header(skb);
>> +	proto = ovpn_ip_check_protocol(skb);
>> +	if (unlikely(!proto)) {
>> +		/* check if null packet */
>> +		if (unlikely(!pskb_may_pull(skb, 1))) {
>> +			net_info_ratelimited("%s: NULL packet received from peer %u\n",
>> +					     netdev_name(peer->ovpn->dev),
>> +					     peer->id);
>> +			goto drop;
>> +		}
>> +
>> +		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
>> +				     netdev_name(peer->ovpn->dev), peer->id);
>> +		goto drop;
>> +	}
>> +	skb->protocol = proto;
>> +
>> +	/* perform Reverse Path Filtering (RPF) */
>> +	if (unlikely(!ovpn_peer_check_by_src(peer->ovpn, skb, peer))) {
>> +		if (skb->protocol == htons(ETH_P_IPV6))
>> +			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI6c\n",
>> +					    netdev_name(peer->ovpn->dev),
>> +					    peer->id, &ipv6_hdr(skb)->saddr);
>> +		else
>> +			net_dbg_ratelimited("%s: RPF dropped packet from peer %u, src: %pI4\n",
>> +					    netdev_name(peer->ovpn->dev),
>> +					    peer->id, &ip_hdr(skb)->saddr);
>> +		goto drop;
>> +	}
>> +
>>   	ovpn_netdev_write(peer, skb);
>>   	/* skb is passed to upper layer - don't free it */
>>   	skb = NULL;
>>   drop:
>>   	if (unlikely(skb))
>>   		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
>> -	ovpn_peer_put(peer);
>> +	if (likely(peer))
>> +		ovpn_peer_put(peer);
>> +	if (likely(ks))
>> +		ovpn_crypto_key_slot_put(ks);
>>   	kfree_skb(skb);
>>   }
>>   

[...]

>> --- /dev/null
>> +++ b/drivers/net/ovpn/pktid.h
>> @@ -0,0 +1,87 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*  OpenVPN data channel offload
>> + *
>> + *  Copyright (C) 2020-2025 OpenVPN, Inc.
>> + *
>> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
>> + *		James Yonan <james@openvpn.net>
>> + */
>> +
>> +#ifndef _NET_OVPN_OVPNPKTID_H_
>> +#define _NET_OVPN_OVPNPKTID_H_
>> +
>> +#include "proto.h"
>> +
>> +/* If no packets received for this length of time, set a backtrack floor
>> + * at highest received packet ID thus far.
>> + */
>> +#define PKTID_RECV_EXPIRE (30 * HZ)
>> +
>> +/* Packet-ID state for transmitter */
>> +struct ovpn_pktid_xmit {
>> +	atomic64_t seq_num;
> 
> pktid is 32-bit so atomic_t should be enough (see below).
> 
>> +};
>> +
>> +/* replay window sizing in bytes = 2^REPLAY_WINDOW_ORDER */
>> +#define REPLAY_WINDOW_ORDER 8
>> +
>> +#define REPLAY_WINDOW_BYTES BIT(REPLAY_WINDOW_ORDER)
>> +#define REPLAY_WINDOW_SIZE  (REPLAY_WINDOW_BYTES * 8)
>> +#define REPLAY_INDEX(base, i) (((base) + (i)) & (REPLAY_WINDOW_SIZE - 1))
>> +
>> +/* Packet-ID state for receiver.
>> + * Other than lock member, can be zeroed to initialize.
>> + */
>> +struct ovpn_pktid_recv {
>> +	/* "sliding window" bitmask of recent packet IDs received */
>> +	u8 history[REPLAY_WINDOW_BYTES];
>> +	/* bit position of deque base in history */
>> +	unsigned int base;
>> +	/* extent (in bits) of deque in history */
>> +	unsigned int extent;
>> +	/* expiration of history in jiffies */
>> +	unsigned long expire;
>> +	/* highest sequence number received */
>> +	u32 id;
>> +	/* highest time stamp received */
>> +	u32 time;
>> +	/* we will only accept backtrack IDs > id_floor */
>> +	u32 id_floor;
>> +	unsigned int max_backtrack;
>> +	/* protects entire pktd ID state */
>> +	spinlock_t lock;
>> +};
>> +
>> +/* Get the next packet ID for xmit */
>> +static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid, u32 *pktid)
>> +{
>> +	const s64 seq_num = atomic64_fetch_add_unless(&pid->seq_num, 1,
>> +						      0x100000000LL);
>> +	/* when the 32bit space is over, we return an error because the packet
>> +	 * ID is used to create the cipher IV and we do not want to reuse the
>> +	 * same value more than once
>> +	 */
>> +	if (unlikely(seq_num == 0x100000000LL))
>> +		return -ERANGE;
> 
> You may use a 32-bit atomic_t, instead of checking if it equals
> 0x1_00000000, check if it wraparounds to zero.
> Additionally, you don't need full memory ordering as you just want an
> incrementing value:
> 
> int seq_num = atomic_fetch_inc_relaxed(&pid->seq_num);
> 
> if (unlikely(!seq_num))
> 	...

But then if we have concurrent invocations of ovpn_pktid_xmit_next() 
only the first one will error out on wrap-around, while the others will 
return no error (seq_num becomes > 0) and will allow the packets to go 
through.

This is not what we want.

> 
>> +
>> +	*pktid = (u32)seq_num;
>> +
>> +	return 0;
>> +}
>> +
>> +/* Write 12-byte AEAD IV to dest */
>> +static inline void ovpn_pktid_aead_write(const u32 pktid,
>> +					 const u8 nt[],
>> +					 unsigned char *dest)
>> +{
>> +	*(__force __be32 *)(dest) = htonl(pktid);
>> +	BUILD_BUG_ON(4 + OVPN_NONCE_TAIL_SIZE != OVPN_NONCE_SIZE);
>> +	memcpy(dest + 4, nt, OVPN_NONCE_TAIL_SIZE);
>> +}
>> +

Qingfang, may I ask you to remove from your reply non-relevant code 
(like I did above), especially in such long patches, as it becomes a bit 
tedious to spot your comments and I may miss something.

Thanks a lot!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


