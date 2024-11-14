Return-Path: <linux-kselftest+bounces-22032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C299C8DE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6671282DB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8971632EF;
	Thu, 14 Nov 2024 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CH6HU9S8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8B11420A8
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597936; cv=none; b=ozIr5BPe1QlkNVmlB60CDEWYO8NhaxEx6sVqX0GZPQ2G0ZfmvJMQUsDkJo7Rs48w/HsTLWs6MP/fwT2I3cd4v0X7Q1z65yLY7gR8J63U+UYelDWbPFyUIqthfi+Sxdi/REga5wEjzHWdhJwXQGMhcDpvypt6Xmxle1IFyks1PTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597936; c=relaxed/simple;
	bh=mRZeQuL4XRfisNey/RHHYIr9augB4IqqB8Uzbvdxpe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/6t2M9A6hlUtJM07PyVzdk5ip/t3HQniEn6kVp7bJDoee4ImTVR2pE3CvD4uXGbzxv8cUIwb6i4E6eKYUe+YyCbzdc/1LkRSlJga8zr+9sQoSKvDAafvJNY0XyvWwPKV4oaWtirG2WoBPXYa70mUUYERnw/OfSbQQZpcqt+tn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CH6HU9S8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so7240405e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 07:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731597931; x=1732202731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RftQrf6wG+QOdh77tzk6PbMNJeRphHKH6IPCz+WPl5E=;
        b=CH6HU9S8abRmLzGx/JgpyjmDN4lM93/n7Zr2BKL1yi6Cb39kCd+ekoKsb9k6VSgzZV
         y2tn9WJtF8BZqEOAAghkWHSxa5eYgU9VnqDJBqL9qb/K+Ffm1Ylq7RYnIOxhMFSTGhha
         KweCvF8ZYDXTWWRPZXB2nDF1FV9V14nrcqSAq8eWRcdXgljuBxy6ddXEvT+sjSkLaa/7
         UjQ9DVtfutr+RfvoLIccDwZoVCSrEauoRKU+RQjoosGwHZAzdB2c9mMw0/ZSJ8X+Ur7r
         koZcsQavHGB/dsLUEglnWb8H0wI4yN+q6qkMRvn+66Sgpuj01TQcfcQyDRyRKWbKoAPp
         e5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731597931; x=1732202731;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RftQrf6wG+QOdh77tzk6PbMNJeRphHKH6IPCz+WPl5E=;
        b=qsPn/sB3ajdTALLan7JHpqOWq7qSBO+kvjrAkaLqnTV3Ge3xiOiMuju39b9tjk7nSM
         iiDnfNctsUE4YeAoYmB6txFYIhYPtQsh+wJ3pntx1UwYU9yhyoFcKZnFKwxCcgqAznZ+
         j6Ybg9pzlhSlHAqV1JLjG/DHlcLTRbnDZZebJdPozHwuROEJEErDLTY/oZ/Nsq1mw9QD
         rj2khJDQxH5dOnhiMvZbegrUhkOWfiSM9iTYWt1IIfACt6STgO7O+B7VItQipxjFLG/P
         R7Z3T1bRiotllJHdaYc/KABFkjf/Jz9iEgdkNh1S8mihKNG4AJRhI5v935iceLoLZw15
         TfSg==
X-Forwarded-Encrypted: i=1; AJvYcCXOQxeCR4Zr+U9i5GD5tBjW/C3QXl8X8udxXrxFovWhU1fyqfuhaaow0oSIr7ipc6wGZU7DN575zuDh35WAZOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4fZoohBtw72lAMoUcaaU9iAmUbjiy7NXyiVFnov+C3kimRwb
	e/eBv7oFw8sgqqEgS2FDz5WKREtIyTdSg1jnALbFWwPOjt28SH4Ou24miZvV0w8=
X-Google-Smtp-Source: AGHT+IFTEiRcthhWkVevUSVFjA91cV/GXKHMEq/kYqqKfQKNAm01BeMHYie21i7C8OWu47OP88k8CQ==
X-Received: by 2002:a05:600c:4fd5:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-432da77e9f3mr23882855e9.8.1731597931584;
        Thu, 14 Nov 2024 07:25:31 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:e7c9:910b:dd41:da18? ([2001:67c:2fbc:1:e7c9:910b:dd41:da18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265c9asm27133775e9.16.2024.11.14.07.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:25:31 -0800 (PST)
Message-ID: <7b7f8808-9e4a-4302-9266-9a051c2ff27b@openvpn.net>
Date: Thu, 14 Nov 2024 16:25:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 08/23] ovpn: implement basic TX path (UDP)
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net>
 <85858c63-4dc5-468e-8335-6ac77f314e33@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <85858c63-4dc5-468e-8335-6ac77f314e33@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/2024 23:32, Sergey Ryazanov wrote:
[...]
>> +/* send skb to connected peer, if any */
>> +static void ovpn_send(struct ovpn_struct *ovpn, struct sk_buff *skb,
>> +              struct ovpn_peer *peer)
>> +{
>> +    struct sk_buff *curr, *next;
>> +
>> +    if (likely(!peer))
>> +        /* retrieve peer serving the destination IP of this packet */
>> +        peer = ovpn_peer_get_by_dst(ovpn, skb);
>> +    if (unlikely(!peer)) {
>> +        net_dbg_ratelimited("%s: no peer to send data to\n",
>> +                    ovpn->dev->name);
>> +        dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +        goto drop;
>> +    }
> 
> The function is called only from ovpn_xmit_special() and from 
> ovpn_net_xmit(). The keepalive always provides a peer object, while 
> ovpn_net_xmit() never do it. If we move the peer lookup call into 
> ovpn_net_xmit() then we can eliminate all the above peer checks.

yeah, I think that's a good idea! See below..

> 
>> +
>> +    /* this might be a GSO-segmented skb list: process each skb
>> +     * independently
>> +     */
>> +    skb_list_walk_safe(skb, curr, next)
>> +        if (unlikely(!ovpn_encrypt_one(peer, curr))) {
>> +            dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +            kfree_skb(curr);
>> +        }
>> +
>> +    /* skb passed over, no need to free */
>> +    skb = NULL;
>> +drop:
>> +    if (likely(peer))
>> +        ovpn_peer_put(peer);
>> +    kfree_skb_list(skb);
>> +}

..because this error path disappears as well.

And I can move the stats increment to ovpn_net_xmit() in order to avoid 
counting keepalive packets as vpn data.

>>   /* Send user data to the network
>>    */
>>   netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
>>   {
>> +    struct ovpn_struct *ovpn = netdev_priv(dev);
>> +    struct sk_buff *segments, *curr, *next;
>> +    struct sk_buff_head skb_list;
>> +    __be16 proto;
>> +    int ret;
>> +
>> +    /* reset netfilter state */
>> +    nf_reset_ct(skb);
>> +
>> +    /* verify IP header size in network packet */
>> +    proto = ovpn_ip_check_protocol(skb);
>> +    if (unlikely(!proto || skb->protocol != proto)) {
>> +        net_err_ratelimited("%s: dropping malformed payload packet\n",
>> +                    dev->name);
>> +        dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +        goto drop;
>> +    }
>> +
>> +    if (skb_is_gso(skb)) {
>> +        segments = skb_gso_segment(skb, 0);
>> +        if (IS_ERR(segments)) {
>> +            ret = PTR_ERR(segments);
>> +            net_err_ratelimited("%s: cannot segment packet: %d\n",
>> +                        dev->name, ret);
>> +            dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +            goto drop;
>> +        }
>> +
>> +        consume_skb(skb);
>> +        skb = segments;
>> +    }
>> +
>> +    /* from this moment on, "skb" might be a list */
>> +
>> +    __skb_queue_head_init(&skb_list);
>> +    skb_list_walk_safe(skb, curr, next) {
>> +        skb_mark_not_on_list(curr);
>> +
>> +        curr = skb_share_check(curr, GFP_ATOMIC);
>> +        if (unlikely(!curr)) {
>> +            net_err_ratelimited("%s: skb_share_check failed\n",
>> +                        dev->name);
>> +            dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +            continue;
>> +        }
>> +
>> +        __skb_queue_tail(&skb_list, curr);
>> +    }
>> +    skb_list.prev->next = NULL;
>> +
> 
> I belive, the peer lookup should be done here to call ovpn_send() with 
> proper peer object and simplify it.

ACK

> 
>> +    ovpn_send(ovpn, skb_list.next, NULL);
>> +
>> +    return NETDEV_TX_OK;
>> +
>> +drop:
>>       skb_tx_error(skb);
>> -    kfree_skb(skb);
>> +    kfree_skb_list(skb);
>>       return NET_XMIT_DROP;
>>   }

[...]

>> +/**
>> + * ovpn_udp_send_skb - prepare skb and send it over via UDP
>> + * @ovpn: the openvpn instance
>> + * @peer: the destination peer
>> + * @skb: the packet to send
>> + */
>> +void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
>> +               struct sk_buff *skb)
>> +{
>> +    struct ovpn_bind *bind;
>> +    unsigned int pkt_len;
>> +    struct socket *sock;
>> +    int ret = -1;
>> +
>> +    skb->dev = ovpn->dev;
>> +    /* no checksum performed at this layer */
>> +    skb->ip_summed = CHECKSUM_NONE;
>> +
>> +    /* get socket info */
>> +    sock = peer->sock->sock;
>> +    if (unlikely(!sock)) {
>> +        net_warn_ratelimited("%s: no sock for remote peer\n", __func__);
> 
> If we do not have netdev_{err,warn,etc}_ratelimited() helper functions, 
> can we at least emulate it like this:
> 
> net_warn_ratelimited("%s: no UDP sock for remote peer #%u\n",
>                       netdev_name(ovpn->dev), peer->id);

that's what I try to do, but some prints have escaped my axe.
Will fix that, thanks!

> 
> or just use netdev_warn_once(...) since the condition looks more 
> speculative than expected.
> 
> Peer id and interface name are more informative than just a function name.

Yeah, I use the function name in some debug messages, although not 
extremely useful.

Will make sure the iface name is always printed (there are similar 
occurrences like this)

> 
>> +        goto out;
>> +    }
>> +
>> +    rcu_read_lock();
>> +    /* get binding */
>> +    bind = rcu_dereference(peer->bind);
>> +    if (unlikely(!bind)) {
>> +        net_warn_ratelimited("%s: no bind for remote peer\n", __func__);
> 
> Ditto
> 
>> +        goto out_unlock;
>> +    }
>> +
>> +    /* crypto layer -> transport (UDP) */
>> +    pkt_len = skb->len;
>> +    ret = ovpn_udp_output(ovpn, bind, &peer->dst_cache, sock->sk, skb);
>> +
>> +out_unlock:
>> +    rcu_read_unlock();
>> +out:
>> +    if (unlikely(ret < 0)) {
>> +        dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +        kfree_skb(skb);
>> +        return;
>> +    }
>> +
>> +    dev_sw_netstats_tx_add(ovpn->dev, 1, pkt_len);
>> +}
>> +
>>   /**
>>    * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it 
>> to ovpn
>>    * @sock: socket to configure
>> diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
>> index 
>> f2507f8f2c71ea9d5e5ac5446801e2d56f86700f..e60f8cd2b4ac8f910aabcf8ed546af59d6ca4be4 100644
>> --- a/drivers/net/ovpn/udp.h
>> +++ b/drivers/net/ovpn/udp.h
>> @@ -9,9 +9,17 @@
>>   #ifndef _NET_OVPN_UDP_H_
>>   #define _NET_OVPN_UDP_H_
>> +#include <linux/skbuff.h>
>> +#include <net/sock.h>
>> +
>> +struct ovpn_peer;
>>   struct ovpn_struct;
>> +struct sk_buff;
> 
> This declaration looks odd since we already have skbuff.h included above.

I believe originally there was no include, then I need to add that.
Will double check,

Thanks a lot!
Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


