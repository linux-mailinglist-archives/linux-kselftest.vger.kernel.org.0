Return-Path: <linux-kselftest+bounces-22525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5B9D938C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 09:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E6FBB26706
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9041B0F26;
	Tue, 26 Nov 2024 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Q9BJtLfU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0371E13C3F6
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610924; cv=none; b=C+wiXWsUfg9JTe6Ld0PAT2v09CuR8Mp9yNVU5/DMlsQQMacxVGdLdOwZVWDRS3xRpe/sZWp+3jdqsAuiZl4hDW+T0f5w51naZkpG6+Gg1kTJ81dhWEloTNELwZ8HEm8AiWN20E2lUR7y8LrhBbdos4BYtUqzcSI1DZAO2fHFYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610924; c=relaxed/simple;
	bh=3rYZbY/laj6UaQbhZNH4lyd9GMbKtsO0yttGqypTtQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1jN6R/YNyDZHwLoT4CFzPzpfcy2cMyfy/sZQuUhVC4wBRnULweb9HiKcb/Ha6mzXRJoroI4yd4NUEBWUFs/cSe2Op0oV68UJYyBI6OKt6P5e4syxnT9Edn0E8jNlNt6VneZdHEZO3F0212ERCBEX7gy9H9YbihZ1LwoKAFxsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Q9BJtLfU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fc968b3545so56571781fa.2
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 00:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732610919; x=1733215719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+MZ9kb8AheQESzc/F6uqoAtlAG5+xtFGNuaRLNYA3Xw=;
        b=Q9BJtLfUpzSLvIl1kwDscI3YiGIXQEriEHbdlcptto/IHn1TuZiQIuHXLZ67SwtRdP
         MoDekHV9Xb3By5luQYKGx3vsTafcSCWw394EFfF/gOCL1HTv9X7SMC1l5Rc22tmUVLK5
         WcihJcEb2UAst9d8HNGYqV5tHhYgMiw0sNVqfTVldlQi7hLnSsnt/1w0RsFgiViVSfUH
         uv+1pmtFFVC1vzE0v9W8qLcPxZsuwMSY2+zZIkOX4LAws8BsXcSNSzLfGuczQXthzZ7r
         VOtjREy8uSL0lMBW23Nf+1uOcIpxKYYlnswj00f7HFaZ1xYCoS4frzW9SERYU8f73kxj
         AFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732610919; x=1733215719;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MZ9kb8AheQESzc/F6uqoAtlAG5+xtFGNuaRLNYA3Xw=;
        b=mBuFffXO72xBT7F7hf9jkgL6S1qFhkNiosngoLDayETQSjp9ckEOyXO/J8D6Oiqc3/
         GNOvW1lii260ItdQeKhg890MCEW3vzZoNY0X0rY3VnrJlpcDu7TuBp3Ze/Zjx/0sj9/u
         a07t+v03ewYl2I6036z8mvQyG1BUMCRCCLRd/MP5DAinHdacKMVjgE0vmt9BYj7esB5h
         ToE4mzEG8cJV8gXENLf/fWizRjKtukgp8511bYldEvwA/8mDWZ3eileGI7A/qaD8Pmyz
         TNdOwnatXVLWHjXsWTEshal/uByJ0/i87+aP+dznaNgEOJ2r0vBnZ4n8YVY6IHfCi0Mr
         EL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9Zih6zs1HbP/K6doXUhu9uZ8XLJqurRysvrIZGKzwUpYccWUszIvUr5YO7HJswx1vbhlnqVkZNlJkklzxqYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK1XKskFQA2B8TZlzI2QBsH00Y1Zz/TjhYRXndpd7yXsWKszqp
	LE4QPomD+nDYTqoa0vAy5tTrmexKDsEE6CbJdx4cZsG5/+z/i1K1OZ3QLcwFRFU=
X-Gm-Gg: ASbGncshuuZPDH2lkJ/11szttygODVBPnSh7ZuSQSCPkC/YRJZ2xzSqnI3WA18Rk7Se
	nusnTbXiYmzAPUC3FAZFIJykdB9gGh2IsCIzSW3JHkkP72W6kD2+lwGMKmL3l4hgqVsiYiB+pS8
	cHYptb6nEwQj70MLcG1Cr5zA+JTNYL4y3Ql+S68UKlmNKDgMsLHJ7uaafZB/45SVNgKVeIxVrlz
	PPJiH3+6+jWEok/7+NwZ5PqBexkTIDWeEMCBDsfJyilqa4cynggp7GKhg1BdUmuzahaMZ4EpEC1
	/Mlslv1CYN+g
X-Google-Smtp-Source: AGHT+IHjuBvBQ/yyPbh4u7g3zH/LJdTXjykculvlgdDcdGtK0afVcGSyc2njgGAYLx+9kRptSg6asQ==
X-Received: by 2002:a2e:b8c3:0:b0:2ff:ca83:4fe7 with SMTP id 38308e7fff4ca-2ffca8351b9mr25394351fa.26.1732610919028;
        Tue, 26 Nov 2024 00:48:39 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:9421:3351:41c6:fc75? ([2001:67c:2fbc:1:9421:3351:41c6:fc75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b0c0esm4924552a12.27.2024.11.26.00.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:48:38 -0800 (PST)
Message-ID: <4c24d8ba-35d0-4aff-b207-9eca6eeda1fc@openvpn.net>
Date: Tue, 26 Nov 2024 09:49:12 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 sd@queasysnail.net, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
 <eabe28f9-d6a4-4bdc-a988-418e5137f3cb@gmail.com>
 <288f68cd-533a-4253-85c4-951cc4a9c862@openvpn.net>
 <aac209cc-589c-4b8a-9123-e44df9e794e4@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <aac209cc-589c-4b8a-9123-e44df9e794e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/11/2024 01:32, Sergey Ryazanov wrote:
> On 15.11.2024 17:02, Antonio Quartulli wrote:
>> On 11/11/2024 02:54, Sergey Ryazanov wrote:
>> [...]
>>
>>>> +/* Called after decrypt to write the IP packet to the device.
>>>> + * This method is expected to manage/free the skb.
>>>> + */
>>>> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct 
>>>> sk_buff *skb)
>>>> +{
>>>> +    unsigned int pkt_len;
>>>> +
>>>> +    /* we can't guarantee the packet wasn't corrupted before 
>>>> entering the
>>>> +     * VPN, therefore we give other layers a chance to check that
>>>> +     */
>>>> +    skb->ip_summed = CHECKSUM_NONE;
>>>> +
>>>> +    /* skb hash for transport packet no longer valid after 
>>>> decapsulation */
>>>> +    skb_clear_hash(skb);
>>>> +
>>>> +    /* post-decrypt scrub -- prepare to inject encapsulated packet 
>>>> onto the
>>>> +     * interface, based on __skb_tunnel_rx() in dst.h
>>>> +     */
>>>> +    skb->dev = peer->ovpn->dev;
>>>> +    skb_set_queue_mapping(skb, 0);
>>>> +    skb_scrub_packet(skb, true);
>>>> +
>>>
>>> The skb->protocol field is going to be updated in the upcoming patch 
>>> in the caller (ovpn_decrypt_post). Shall we put a comment here 
>>> clarifying, why do not touch the protocol field here?
>>
>> Well, I would personally not document missing details in a partly 
>> implemented code path.
> 
> Looks like the question wasn't precisely emphrased. By bad. Let me 
> elaborate it in more details:
> 1. usually skb->protocol is updated just before a packet leaves a module
> 2. I've not found it were it was expected
> 3. skb->protocol is updated in the caller function - 
> ovpn_decrypt_post(), along with the skb_reset_network_header() call.
> 
> The question is, shall we put some comment here in the 
> ovpn_netdev_write() function elaborating that this was done in the 
> caller? Or is such comment odd?

Ok, got it.
Mah personally I don't think it's truly needed. But I have no strong 
opinion.

> 
>>>> +    skb_reset_network_header(skb);
>>>
>>> ovpn_decrypt_post() already reseted the network header. Why do we 
>>> need it here again?
>>
>> yeah, I think this can be removed.
>>
>>>
>>>> +    skb_reset_transport_header(skb);
>>>> +    skb_probe_transport_header(skb);
>>>> +    skb_reset_inner_headers(skb);
>>>> +
>>>> +    memset(skb->cb, 0, sizeof(skb->cb));
>>>
>>> Why do we need to zero the control buffer here?
>>
>> To avoid the next layer to assume the cb is clean while it is not.
>> Other drivers do the same as well.
> 
> AFAIR, there is no convention to clean the control buffer before the 
> handing over. The common practice is a bit opposite, programmer shall 
> not assume that the control buffer has been zeroed.
> 
> Not a big deal to clean it here, we just can save some CPU cycles 
> avoiding it.

If there is no convention, then I agree with you and I'd remove it.

> 
>> I think this was recommended by Sabrina as well.
> 
> Curious. It's macsec that does not zero it, or I've not understood how 
> it was done.

I don't see it being zero'd. So I possibly misunderstood the suggestion.
I'll remove the memset.

> 
>>>> +    /* cause packet to be "received" by the interface */
>>>> +    pkt_len = skb->len;
>>>> +    if (likely(gro_cells_receive(&peer->ovpn->gro_cells,
>>>> +                     skb) == NET_RX_SUCCESS))
>>>> +        /* update RX stats with the size of decrypted packet */
>>>> +        dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
>>>> +}
>>>> +
> 
> [...]
> 
>>>> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
>>>> index 
>>>> 090a3232ab0ec19702110f1a90f45c7f10889f6f..964b566de69f4132806a969a455cec7f6059a0bd 100644
>>>> --- a/drivers/net/ovpn/socket.c
>>>> +++ b/drivers/net/ovpn/socket.c
>>>> @@ -22,6 +22,9 @@ static void ovpn_socket_detach(struct socket *sock)
>>>>       if (!sock)
>>>>           return;
>>>> +    if (sock->sk->sk_protocol == IPPROTO_UDP)
>>>> +        ovpn_udp_socket_detach(sock);
>>>> +
>>>>       sockfd_put(sock);
>>>>   }
>>>> @@ -71,6 +74,27 @@ static int ovpn_socket_attach(struct socket 
>>>> *sock, struct ovpn_peer *peer)
>>>>       return ret;
>>>>   }
>>>> +/* Retrieve the corresponding ovpn object from a UDP socket
>>>> + * rcu_read_lock must be held on entry
>>>> + */
>>>> +struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk)
>>>> +{
>>>> +    struct ovpn_socket *ovpn_sock;
>>>> +
>>>> +    if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != 
>>>> UDP_ENCAP_OVPNINUDP))
>>>> +        return NULL;
>>>> +
>>>> +    ovpn_sock = rcu_dereference_sk_user_data(sk);
>>>> +    if (unlikely(!ovpn_sock))
>>>> +        return NULL;
>>>> +
>>>> +    /* make sure that sk matches our stored transport socket */
>>>> +    if (unlikely(!ovpn_sock->sock || sk != ovpn_sock->sock->sk))
>>>> +        return NULL;
>>>> +
>>>> +    return ovpn_sock->ovpn;
>>>
>>> Now, returning of this pointer is safe. But the following TCP 
>>> transport support calls the socket release via a scheduled work. What 
>>> extends socket lifetime and makes it possible to receive a UDP packet 
>>> way after the interface private data release. Is it correct assumption?
>>
>> Sorry you lost me when sayng "following *TCP* transp[ort support calls".
>> This function is invoked only in UDP context.
>> Was that a typ0?
> 
> Yeah, you are right. The question sounds like a riddle. I should 
> eventually stop composing emails at midnight. Let me paraphrase it.

:)

> 
> The potential issue is tricky since we create it patch-by-patch.
> 
> Up to this patch the socket releasing procedure looks solid and 
> reliable. E.g. the P2P netdev destroying:
> 
>    ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
>      ovpn_peer_release_p2p
>        ovpn_peer_del_p2p
>          ovpn_peer_put
>            ovpn_peer_release_kref
>              ovpn_peer_release
>                ovpn_socket_put
>                  ovpn_socket_release_kref
>                    ovpn_socket_detach
>                      ovpn_udp_socket_detach
>                        setup_udp_tunnel_sock
>    netdev_run_todo
>      rcu_barrier  <- no running ovpn_udp_encap_recv after this point
>      free_netdev
> 
> After the setup_udp_tunnel_sock() call no new ovpn_udp_encap_recv() will 
> be spawned. And after the rcu_barrier() all running 
> ovpn_udp_encap_recv() will be done. All good.
> 

ok

> Then, the following patch 'ovpn: implement TCP transport' disjoin 
> ovpn_socket_release_kref() and ovpn_socket_detach() by scheduling the 
> socket detach function call:
> 
>    ovpn_socket_release_kref
>      ovpn_socket_schedule_release
>        schedule_work(&sock->work)
> 
> And long time after the socket will be actually detached:
> 
>    ovpn_socket_release_work
>      ovpn_socket_detach
>        ovpn_udp_socket_detach
>          setup_udp_tunnel_sock
> 
> And until this detaching will take a place, UDP handler can call 
> ovpn_udp_encap_recv() whatever number of times.
> 
> So, we can end up with this scenario:
> 
>    ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
>      ovpn_peer_release_p2p
>        ovpn_peer_del_p2p
>          ovpn_peer_put
>            ovpn_peer_release_kref
>              ovpn_peer_release
>                ovpn_socket_put
>                  ovpn_socket_release_kref
>                    ovpn_socket_schedule_release
>                      schedule_work(&sock->work)
>    netdev_run_todo
>      rcu_barrier
>      free_netdev
> 
>    ovpn_udp_encap_recv  <- called for an incoming UDP packet
>      ovpn_from_udp_sock <- returns pointer to freed memory
>      // Any access to ovpn pointer is the use-after-free
> 
>    ovpn_socket_release_work  <- kernel finally ivoke the work
>      ovpn_socket_detach
>        ovpn_udp_socket_detach
>          setup_udp_tunnel_sock
> 
> To address the issue, I see two possible solutions:
> 1. flush the workqueue somewhere before the netdev release

yes! This is what I was missing. This will also solve the "how can the 
module wait for all workers to be done before unloading?"

> 2. set ovpn_sock->ovpn = NULL before scheduling the socket detach

This makes sense too. But 1 is definitely what we need.

> 
>>> If the above is right then shall we set ->ovpn = NULL before 
>>> scheduling the socket releasing work or somehow else mark the socket 
>>> as half- destroyed?

Will think about it, it may make sense to nullify ->ovpn as well.

>>>
>>>> +}
>>>> +
>>>>   /**
>>>>    * ovpn_socket_new - create a new socket and initialize it
>>>>    * @sock: the kernel socket to embed
>>>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>>>> index 
>>>> d26d7566e9c8dfe91fa77f49c34fb179a9fb2239..d1e88ae83843f02d591e67a7995f2d6868720695 100644
>>>> --- a/drivers/net/ovpn/udp.c
>>>> +++ b/drivers/net/ovpn/udp.c
>>>> @@ -21,9 +21,95 @@
>>>>   #include "bind.h"
>>>>   #include "io.h"
>>>>   #include "peer.h"
>>>> +#include "proto.h"
>>>>   #include "socket.h"
>>>>   #include "udp.h"
>>>> +/**
>>>> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
>>>> + * @sk: socket over which the packet was received
>>>> + * @skb: the received packet
>>>> + *
>>>> + * If the first byte of the payload is DATA_V2, the packet is 
>>>> further processed,
>>>> + * otherwise it is forwarded to the UDP stack for delivery to user 
>>>> space.
>>>> + *
>>>> + * Return:
>>>> + *  0 if skb was consumed or dropped
>>>> + * >0 if skb should be passed up to userspace as UDP (packet not 
>>>> consumed)
>>>> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
>>>> + */
>>>> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>>>> +{
>>>> +    struct ovpn_peer *peer = NULL;
>>>> +    struct ovpn_struct *ovpn;
>>>> +    u32 peer_id;
>>>> +    u8 opcode;
>>>> +
>>>> +    ovpn = ovpn_from_udp_sock(sk);
>>>> +    if (unlikely(!ovpn)) {
>>>> +        net_err_ratelimited("%s: cannot obtain ovpn object from UDP 
>>>> socket\n",
>>>> +                    __func__);
>>>
>>> Probably we should zero ovpn pointer in the ovpn_sock to survive 
>>> scheduled socket release (see comment in ovpn_from_udp_sock). So, 
>>> this print should be removed to avoid printing misguiding errors.
>>
>> I am also not following this. ovpn is already NULL if we are entering 
>> this branch, no?
>>
>> And I think this condition is quite improbable as well.
> 
> Here, due to the scheduled nature of the detach function invocation, 
> ovpn_from_udp_sock() can return us a pointer to the freed memory.
> 
> So we should prevent ovpn_udp_encap_recv() invocation after the netdev 
> release by flushing the workqueue. Or we can set ovpn_sock->ovpn = NULL 
> even before scheduling the socket detaching. And in this case, 
> ovpn_from_udp_sock() returning NULL will be a legitimate case and we 
> should drop the error printing.

ok got it. it is related with the comment above.

> 
>>>> +        goto drop_noovpn;
>>>> +    }
>>>> +
>>>> +    /* Make sure the first 4 bytes of the skb data buffer after the 
>>>> UDP
>>>> +     * header are accessible.
>>>> +     * They are required to fetch the OP code, the key ID and the 
>>>> peer ID.
>>>> +     */
>>>> +    if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
>>>> +                    OVPN_OP_SIZE_V2))) {
>>>> +        net_dbg_ratelimited("%s: packet too small\n", __func__);
>>>> +        goto drop;
>>>> +    }
>>>> +
>>>> +    opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
>>>> +    if (unlikely(opcode != OVPN_DATA_V2)) {
>>>> +        /* DATA_V1 is not supported */
>>>> +        if (opcode == OVPN_DATA_V1)
>>>> +            goto drop;
>>>
>>> This packet dropping makes protocol accelerator, intendent to speed 
>>> up the data packets processing, a protocol enforcement entity, isn't 
>>> it? Shall we follow the principle of beeing liberal in what we accept 
>>> and just forward everything besides data packets upstream to a 
>>> userspace application?
>>
>> 'ovpn' only supports DATA_V2. When ovpn is in use userspace does nto 
>> expect any DATA packet to bubble up as it would not know what to do 
>> with it.
>>
>> So any decision regarding data packets should stay in 'ovpn'.
>>
>> We just decided to support the modern DATA_V2 (DATA_V1 is seldomly 
>> used nowadays).
>>
>> Moreover, it's quite impossible that a peer will send us DATA_V1 if it 
>> passed userspace handshake and negotiation.
> 
> The question was about the special handling of this packet type. If this 
> packet type is unlikely, then why should the kernel take special care of 
> it? Is this specific packet type going to crash the userspace application?

Not crash (hopefully) but will create confusion because it is 
unexpected. The userspace dataplane path is technically inactive when 
'ovpn' is in use.

The idea is that any DATA_V* packet should be handled in kernelspace and 
userspace should not need to care.

> 
>>>> +
>>>> +        /* unknown or control packet: let it bubble up to userspace */
>>>> +        return 1;
>>>> +    }
>>>> +
>>>> +    peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
>>>> +    /* some OpenVPN server implementations send data packets with the
>>>> +     * peer-id set to undef. In this case we skip the peer lookup 
>>>> by peer-id
>>>> +     * and we try with the transport address
>>>> +     */
>>>> +    if (peer_id != OVPN_PEER_ID_UNDEF) {
>>>> +        peer = ovpn_peer_get_by_id(ovpn, peer_id);
>>>> +        if (!peer) {
>>>> +            net_err_ratelimited("%s: received data from unknown 
>>>> peer (id: %d)\n",
>>>> +                        __func__, peer_id);
>>>
>>> Why do we consider a peer sending us garbage our problem? Meaning, 
>>> this peer miss can be not our fault but a malformed packet from a 3rd 
>>> party side. E.g. nowdays I can see a lot of traces of these "active 
>>> probers" in my OpenVPN logs. Shall remove this message or at least 
>>> make it debug to avoid bothering users with garbage traveling 
>>> Internet? Anyway we can not do anything regarding incoming traffic.
>>
>> It could also be a peer that believes to be connected while 'ovpn' 
>> dropped it earlier on. So this message would help the admin/user 
>> understanding what's going on. no?
> 
> It could help troubleshooting, potentionally. On the other hand, it will 
> flood the kernel log with whatever junk is floating around the Internet. 
> For sure.

Well, only packets having the right opcode in it and being large enough.
Because we have already dropped anything that doesn't look like a 
DATA_V2 packet at this point.

> 
>> Maybe make it an info/notice instead of error?
> 
> At best it can be a debug message for developers. But IMHO the really 
> best choice is to get rid of it.

But yeah, I agree with you.
Will just silently drop.

> 
>>>> +            goto drop;
>>>> +        }
>>>> +    }
> 
> -- 
> Sergey

Thanks,
Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


