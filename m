Return-Path: <linux-kselftest+bounces-22520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90C99D8F8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 01:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50427169BB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 00:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20153C14;
	Tue, 26 Nov 2024 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcWdPCd+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0879D2;
	Tue, 26 Nov 2024 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732581125; cv=none; b=iwkDambQWow8wBUUOIj4oAVvQNsshWkxcOb9bGdJoE59IxP+NpOOlg9AB6ZGEpR9r3pXKpscA++7mhYOUWKe94G7wjADobE+bpt+7nVtmF+5RJOUGY/aiOQG2pmY+RVJ5IcLofbh8Dlr+4xa2TE54LvMmSlFkAh2g9dt5iiXC3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732581125; c=relaxed/simple;
	bh=Ngn8TdyMUv8PSOVagDOj6ECOASK4zeyvRiVW5qzoYx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kv/WX2SJ2/PITeWdkJRFcnTgWZ2X/FeUclvenF+p6PtqKrgPCMmBmmqTIE+W2W5QGvsYVpfhSJp5GuCmUDn/qM0B7CRIeS1dg+GUUcLZbWB2xTxUBWq+NBViY6FhauOyZHIAwjO1n2+1Hj/+cRK/H6l7BDAX332uF+W5RewgR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcWdPCd+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so46601285e9.1;
        Mon, 25 Nov 2024 16:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732581122; x=1733185922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmam3g+c79hYbpzK7NoOmOtG1OVDoMMqoJopY9eCVOg=;
        b=KcWdPCd+HxwQKcsxX407qcigNVDUEk9uTYHLjecfokP31rPPCt13uvcKt/JBsPg+WW
         S2+kfOlWfZIfC8z7FEgsLy4M3i2e0WCMRIVdL5p6XJbbL81HJ8vsyTgz3w6BUgwz/W3M
         MkZcS3lYlHZJm9A1ntE5rjP1XCxOVF21CvYxXPEI6IBKlRwGifZCyHnP/ZodGo2Sgoov
         b3rklkRVyPmi3bBmPyWmdZbomNpJdQKP0CtcMNLCFpCox52TOZhEhWCveSBlhYPNq13e
         ZIdIoWcE/HXItMq3bpnGWs11kGwnWjnY47FSOcom28emiLjlgr9Oa7mNTLydWO4Lm/UF
         w76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732581122; x=1733185922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmam3g+c79hYbpzK7NoOmOtG1OVDoMMqoJopY9eCVOg=;
        b=T0X5mdKDO1vBmJq4OCrX3ay/p7MiHerlkd9JbHY6xbE2v823wrqPK/GPgzLljaDBoA
         AwYvGeJVq4M16zWfkZ/IYWfF4xrRmDcgU7Put5obBkun95j2ReO49A2aIIw3u5b5yLXO
         HvibRecOvKZPeSO/jZQmaq//wOqOANEW7xKpeQX+9VBmL/jwjU0cqnU4qExbogkwIRq6
         dCMM5Eq5TtCN8iHmiJezngm0G8S5s7pkNRwhVTxcox0kWgC0gHwaEgFZXykHIWi48BWi
         SuDZHK0LMb8o2wm05qcSG/F/UIeEJWJg6o5W/d4SFEt7Ghf/BpQz9pcoegBOn12RzoTL
         PhJg==
X-Forwarded-Encrypted: i=1; AJvYcCWCAOA3LTWvLkPJfeq0wymMy9HHbi6uUgGeq9+ZvxGUlqFhoPySKt07SPLN0H341z1VE2xcu3G3waLWYTg=@vger.kernel.org, AJvYcCWcbug7jkLgGTae/MtRpgnwsR2Xrct0jMIDt0fv+w8Mv8+zV1BajTtBYFwOQKHgT1QjviLxr7Zj@vger.kernel.org, AJvYcCXqUmTqbUR4pHFO41hK3gOtpwd2lCOPyI/dHuiHWju7wZm8wZi313N2xjivMR6i70gJP0cwvGvNQL2zMuaWxIDd@vger.kernel.org
X-Gm-Message-State: AOJu0Yygx4wNPICCmsGrEXmqM6zvmAx4az6PuCMHMGUqklGWGv4J3cRr
	VrN7Q65uNj7bCNw7bWpX+piIFRsj3ji4kHmIQa543ceiX+TEW6Dq
X-Gm-Gg: ASbGncvyhWOrmROhhniVrZTaix9d/2z6mw6sxlbK856z3lBl8oYaRk/CsIHCrsxcLOq
	hK+Qh6EBp2OvCCl3cpB8YrwXx4kp7INiwrDo1bZE6wg1oy4+Sn4GoD0xisr9cPOMLlIuRBdzArn
	qo/RvyprQViZTD8xAxE9Mhobn4d6f1FOC0v01oJZDrr0Dv9IO7l2RonNg5rbH4f0Xu8cL8dIZjU
	ArVnB6v68xyTQhnp7/dGaNXgjhTy0dv/yfBvly/NQAO67Fjxhc=
X-Google-Smtp-Source: AGHT+IG6qrrRoWAiXHnWfixGwyKkHdOO+5437sG+dT7PfKojCwu1ZnID9drDBmWV3nnmnjufBYKICw==
X-Received: by 2002:a05:600c:cc8:b0:434:9e46:5bc with SMTP id 5b1f17b1804b1-4349e460761mr67740185e9.10.1732581121548;
        Mon, 25 Nov 2024 16:32:01 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349dc19fd3sm69719465e9.39.2024.11.25.16.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 16:32:00 -0800 (PST)
Message-ID: <aac209cc-589c-4b8a-9123-e44df9e794e4@gmail.com>
Date: Tue, 26 Nov 2024 02:32:38 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 sd@queasysnail.net, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
 <eabe28f9-d6a4-4bdc-a988-418e5137f3cb@gmail.com>
 <288f68cd-533a-4253-85c4-951cc4a9c862@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <288f68cd-533a-4253-85c4-951cc4a9c862@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.11.2024 17:02, Antonio Quartulli wrote:
> On 11/11/2024 02:54, Sergey Ryazanov wrote:
> [...]
> 
>>> +/* Called after decrypt to write the IP packet to the device.
>>> + * This method is expected to manage/free the skb.
>>> + */
>>> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff 
>>> *skb)
>>> +{
>>> +    unsigned int pkt_len;
>>> +
>>> +    /* we can't guarantee the packet wasn't corrupted before 
>>> entering the
>>> +     * VPN, therefore we give other layers a chance to check that
>>> +     */
>>> +    skb->ip_summed = CHECKSUM_NONE;
>>> +
>>> +    /* skb hash for transport packet no longer valid after 
>>> decapsulation */
>>> +    skb_clear_hash(skb);
>>> +
>>> +    /* post-decrypt scrub -- prepare to inject encapsulated packet 
>>> onto the
>>> +     * interface, based on __skb_tunnel_rx() in dst.h
>>> +     */
>>> +    skb->dev = peer->ovpn->dev;
>>> +    skb_set_queue_mapping(skb, 0);
>>> +    skb_scrub_packet(skb, true);
>>> +
>>
>> The skb->protocol field is going to be updated in the upcoming patch 
>> in the caller (ovpn_decrypt_post). Shall we put a comment here 
>> clarifying, why do not touch the protocol field here?
> 
> Well, I would personally not document missing details in a partly 
> implemented code path.

Looks like the question wasn't precisely emphrased. By bad. Let me 
elaborate it in more details:
1. usually skb->protocol is updated just before a packet leaves a module
2. I've not found it were it was expected
3. skb->protocol is updated in the caller function - 
ovpn_decrypt_post(), along with the skb_reset_network_header() call.

The question is, shall we put some comment here in the 
ovpn_netdev_write() function elaborating that this was done in the 
caller? Or is such comment odd?

>>> +    skb_reset_network_header(skb);
>>
>> ovpn_decrypt_post() already reseted the network header. Why do we need 
>> it here again?
> 
> yeah, I think this can be removed.
> 
>>
>>> +    skb_reset_transport_header(skb);
>>> +    skb_probe_transport_header(skb);
>>> +    skb_reset_inner_headers(skb);
>>> +
>>> +    memset(skb->cb, 0, sizeof(skb->cb));
>>
>> Why do we need to zero the control buffer here?
> 
> To avoid the next layer to assume the cb is clean while it is not.
> Other drivers do the same as well.

AFAIR, there is no convention to clean the control buffer before the 
handing over. The common practice is a bit opposite, programmer shall 
not assume that the control buffer has been zeroed.

Not a big deal to clean it here, we just can save some CPU cycles 
avoiding it.

> I think this was recommended by Sabrina as well.

Curious. It's macsec that does not zero it, or I've not understood how 
it was done.

>>> +    /* cause packet to be "received" by the interface */
>>> +    pkt_len = skb->len;
>>> +    if (likely(gro_cells_receive(&peer->ovpn->gro_cells,
>>> +                     skb) == NET_RX_SUCCESS))
>>> +        /* update RX stats with the size of decrypted packet */
>>> +        dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
>>> +}
>>> +

[...]

>>> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
>>> index 
>>> 090a3232ab0ec19702110f1a90f45c7f10889f6f..964b566de69f4132806a969a455cec7f6059a0bd 100644
>>> --- a/drivers/net/ovpn/socket.c
>>> +++ b/drivers/net/ovpn/socket.c
>>> @@ -22,6 +22,9 @@ static void ovpn_socket_detach(struct socket *sock)
>>>       if (!sock)
>>>           return;
>>> +    if (sock->sk->sk_protocol == IPPROTO_UDP)
>>> +        ovpn_udp_socket_detach(sock);
>>> +
>>>       sockfd_put(sock);
>>>   }
>>> @@ -71,6 +74,27 @@ static int ovpn_socket_attach(struct socket *sock, 
>>> struct ovpn_peer *peer)
>>>       return ret;
>>>   }
>>> +/* Retrieve the corresponding ovpn object from a UDP socket
>>> + * rcu_read_lock must be held on entry
>>> + */
>>> +struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk)
>>> +{
>>> +    struct ovpn_socket *ovpn_sock;
>>> +
>>> +    if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != 
>>> UDP_ENCAP_OVPNINUDP))
>>> +        return NULL;
>>> +
>>> +    ovpn_sock = rcu_dereference_sk_user_data(sk);
>>> +    if (unlikely(!ovpn_sock))
>>> +        return NULL;
>>> +
>>> +    /* make sure that sk matches our stored transport socket */
>>> +    if (unlikely(!ovpn_sock->sock || sk != ovpn_sock->sock->sk))
>>> +        return NULL;
>>> +
>>> +    return ovpn_sock->ovpn;
>>
>> Now, returning of this pointer is safe. But the following TCP 
>> transport support calls the socket release via a scheduled work. What 
>> extends socket lifetime and makes it possible to receive a UDP packet 
>> way after the interface private data release. Is it correct assumption?
> 
> Sorry you lost me when sayng "following *TCP* transp[ort support calls".
> This function is invoked only in UDP context.
> Was that a typ0?

Yeah, you are right. The question sounds like a riddle. I should 
eventually stop composing emails at midnight. Let me paraphrase it.

The potential issue is tricky since we create it patch-by-patch.

Up to this patch the socket releasing procedure looks solid and 
reliable. E.g. the P2P netdev destroying:

   ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
     ovpn_peer_release_p2p
       ovpn_peer_del_p2p
         ovpn_peer_put
           ovpn_peer_release_kref
             ovpn_peer_release
               ovpn_socket_put
                 ovpn_socket_release_kref
                   ovpn_socket_detach
                     ovpn_udp_socket_detach
                       setup_udp_tunnel_sock
   netdev_run_todo
     rcu_barrier  <- no running ovpn_udp_encap_recv after this point
     free_netdev

After the setup_udp_tunnel_sock() call no new ovpn_udp_encap_recv() will 
be spawned. And after the rcu_barrier() all running 
ovpn_udp_encap_recv() will be done. All good.

Then, the following patch 'ovpn: implement TCP transport' disjoin 
ovpn_socket_release_kref() and ovpn_socket_detach() by scheduling the 
socket detach function call:

   ovpn_socket_release_kref
     ovpn_socket_schedule_release
       schedule_work(&sock->work)

And long time after the socket will be actually detached:

   ovpn_socket_release_work
     ovpn_socket_detach
       ovpn_udp_socket_detach
         setup_udp_tunnel_sock

And until this detaching will take a place, UDP handler can call 
ovpn_udp_encap_recv() whatever number of times.

So, we can end up with this scenario:

   ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
     ovpn_peer_release_p2p
       ovpn_peer_del_p2p
         ovpn_peer_put
           ovpn_peer_release_kref
             ovpn_peer_release
               ovpn_socket_put
                 ovpn_socket_release_kref
                   ovpn_socket_schedule_release
                     schedule_work(&sock->work)
   netdev_run_todo
     rcu_barrier
     free_netdev

   ovpn_udp_encap_recv  <- called for an incoming UDP packet
     ovpn_from_udp_sock <- returns pointer to freed memory
     // Any access to ovpn pointer is the use-after-free

   ovpn_socket_release_work  <- kernel finally ivoke the work
     ovpn_socket_detach
       ovpn_udp_socket_detach
         setup_udp_tunnel_sock

To address the issue, I see two possible solutions:
1. flush the workqueue somewhere before the netdev release
2. set ovpn_sock->ovpn = NULL before scheduling the socket detach

>> If the above is right then shall we set ->ovpn = NULL before 
>> scheduling the socket releasing work or somehow else mark the socket 
>> as half- destroyed?
>>
>>> +}
>>> +
>>>   /**
>>>    * ovpn_socket_new - create a new socket and initialize it
>>>    * @sock: the kernel socket to embed
>>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>>> index 
>>> d26d7566e9c8dfe91fa77f49c34fb179a9fb2239..d1e88ae83843f02d591e67a7995f2d6868720695 100644
>>> --- a/drivers/net/ovpn/udp.c
>>> +++ b/drivers/net/ovpn/udp.c
>>> @@ -21,9 +21,95 @@
>>>   #include "bind.h"
>>>   #include "io.h"
>>>   #include "peer.h"
>>> +#include "proto.h"
>>>   #include "socket.h"
>>>   #include "udp.h"
>>> +/**
>>> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
>>> + * @sk: socket over which the packet was received
>>> + * @skb: the received packet
>>> + *
>>> + * If the first byte of the payload is DATA_V2, the packet is 
>>> further processed,
>>> + * otherwise it is forwarded to the UDP stack for delivery to user 
>>> space.
>>> + *
>>> + * Return:
>>> + *  0 if skb was consumed or dropped
>>> + * >0 if skb should be passed up to userspace as UDP (packet not 
>>> consumed)
>>> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
>>> + */
>>> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>>> +{
>>> +    struct ovpn_peer *peer = NULL;
>>> +    struct ovpn_struct *ovpn;
>>> +    u32 peer_id;
>>> +    u8 opcode;
>>> +
>>> +    ovpn = ovpn_from_udp_sock(sk);
>>> +    if (unlikely(!ovpn)) {
>>> +        net_err_ratelimited("%s: cannot obtain ovpn object from UDP 
>>> socket\n",
>>> +                    __func__);
>>
>> Probably we should zero ovpn pointer in the ovpn_sock to survive 
>> scheduled socket release (see comment in ovpn_from_udp_sock). So, this 
>> print should be removed to avoid printing misguiding errors.
> 
> I am also not following this. ovpn is already NULL if we are entering 
> this branch, no?
> 
> And I think this condition is quite improbable as well.

Here, due to the scheduled nature of the detach function invocation, 
ovpn_from_udp_sock() can return us a pointer to the freed memory.

So we should prevent ovpn_udp_encap_recv() invocation after the netdev 
release by flushing the workqueue. Or we can set ovpn_sock->ovpn = NULL 
even before scheduling the socket detaching. And in this case, 
ovpn_from_udp_sock() returning NULL will be a legitimate case and we 
should drop the error printing.

>>> +        goto drop_noovpn;
>>> +    }
>>> +
>>> +    /* Make sure the first 4 bytes of the skb data buffer after the UDP
>>> +     * header are accessible.
>>> +     * They are required to fetch the OP code, the key ID and the 
>>> peer ID.
>>> +     */
>>> +    if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
>>> +                    OVPN_OP_SIZE_V2))) {
>>> +        net_dbg_ratelimited("%s: packet too small\n", __func__);
>>> +        goto drop;
>>> +    }
>>> +
>>> +    opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
>>> +    if (unlikely(opcode != OVPN_DATA_V2)) {
>>> +        /* DATA_V1 is not supported */
>>> +        if (opcode == OVPN_DATA_V1)
>>> +            goto drop;
>>
>> This packet dropping makes protocol accelerator, intendent to speed up 
>> the data packets processing, a protocol enforcement entity, isn't it? 
>> Shall we follow the principle of beeing liberal in what we accept and 
>> just forward everything besides data packets upstream to a userspace 
>> application?
> 
> 'ovpn' only supports DATA_V2. When ovpn is in use userspace does nto 
> expect any DATA packet to bubble up as it would not know what to do with 
> it.
> 
> So any decision regarding data packets should stay in 'ovpn'.
> 
> We just decided to support the modern DATA_V2 (DATA_V1 is seldomly used 
> nowadays).
> 
> Moreover, it's quite impossible that a peer will send us DATA_V1 if it 
> passed userspace handshake and negotiation.

The question was about the special handling of this packet type. If this 
packet type is unlikely, then why should the kernel take special care of 
it? Is this specific packet type going to crash the userspace application?

>>> +
>>> +        /* unknown or control packet: let it bubble up to userspace */
>>> +        return 1;
>>> +    }
>>> +
>>> +    peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
>>> +    /* some OpenVPN server implementations send data packets with the
>>> +     * peer-id set to undef. In this case we skip the peer lookup by 
>>> peer-id
>>> +     * and we try with the transport address
>>> +     */
>>> +    if (peer_id != OVPN_PEER_ID_UNDEF) {
>>> +        peer = ovpn_peer_get_by_id(ovpn, peer_id);
>>> +        if (!peer) {
>>> +            net_err_ratelimited("%s: received data from unknown peer 
>>> (id: %d)\n",
>>> +                        __func__, peer_id);
>>
>> Why do we consider a peer sending us garbage our problem? Meaning, 
>> this peer miss can be not our fault but a malformed packet from a 3rd 
>> party side. E.g. nowdays I can see a lot of traces of these "active 
>> probers" in my OpenVPN logs. Shall remove this message or at least 
>> make it debug to avoid bothering users with garbage traveling 
>> Internet? Anyway we can not do anything regarding incoming traffic.
> 
> It could also be a peer that believes to be connected while 'ovpn' 
> dropped it earlier on. So this message would help the admin/user 
> understanding what's going on. no?

It could help troubleshooting, potentionally. On the other hand, it will 
flood the kernel log with whatever junk is floating around the Internet. 
For sure.

> Maybe make it an info/notice instead of error?

At best it can be a debug message for developers. But IMHO the really 
best choice is to get rid of it.

>>> +            goto drop;
>>> +        }
>>> +    }

--
Sergey

