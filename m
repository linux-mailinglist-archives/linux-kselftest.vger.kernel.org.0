Return-Path: <linux-kselftest+bounces-22103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5909CE79B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 16:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC01283590
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4931D5148;
	Fri, 15 Nov 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NNZ9dmcT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D41CEEAA
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682928; cv=none; b=daRiXQccZy9Yb9yPFuerNlh73Qx6XcMgcBSeU8tUuJpPL0RAiZxifbs7lrst+S6lkf6C5bDXwIse15TaRHFhPAhr9gnAYDzDR5ptdStCzQK2zbOm6uIsiNJ99I/cIuaO+EcIeAsQfLGJkqa3v4RHpDC76vnXlflzoVt6qCXPC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682928; c=relaxed/simple;
	bh=8avGz2uStbfiOeHgcSppXI3lyg//LNPX/QYBtkPHETs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uU6JpUVQFnPCtugv0tVTvi8oPiMZkY9tG9DJxvYodLfGWPbDuNkbSbS69JjylvDhwaT+CqIIDrPImzi0IUdqxiCDg++8JD/MDbHowdqO5MWjp+2rGMbhMRtBOaac8Qdf/3tjmixNNC8Ve4BRhxC7i9g+sMWESD4ZbvPM03S8fpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NNZ9dmcT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3823194a879so94190f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 07:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731682923; x=1732287723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+KRG+xR26JPgKnKl+zgTUX9WmO2aclLYJoeiMSQ7eZ8=;
        b=NNZ9dmcTDumJy4ls0soaXIe8YwE3/QlFt646raw4amMcHwxVr/dX5MwEUmRt0UVYg1
         6Xcm6iO6mNvQh+S1KgW/dIPqRYSSGqRL7UMT/pwRUwac+t3eJxJyXRvsoB2poc4DrRat
         uRIx6SFlui+pQQXWbowAlUR3hLjnlzbeKsL/nwVlTDbBNUMfbFz+zJPMx4TdB4QIO0CH
         q+PQIFXfYdfaAVSLfCf7dP715TXE2cvuGmw+k1dTETTpmsm/S+TJ8hjbXHbPU1G8361j
         1qVkmKZtq90YNBivBUFH0Ahr9Fmd9YahiEl0LrWKqPVQUsDC12vlIVRjwXk7PESzrt5c
         2iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682923; x=1732287723;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KRG+xR26JPgKnKl+zgTUX9WmO2aclLYJoeiMSQ7eZ8=;
        b=l9JbjEhs+8lp212GPpfyXdZ8T934IzJzhp0V7jIkH68tc/9ZujCrNb/A+9fs7fddkV
         bv1tlMHrtCsAcpiJ9SGgQPbnwWzhVMGOFIEanJr1Pt44asdt8HcMmh63B9CQNt+8MKfO
         FnGkSdabvKCbipDRVD1Og2rnd2lry1yqwpJ4G9X5Pwdr8CnkSfLU9SQkmZgP9olUT6Dr
         lnWYmtIm6F7816LP9Pmb/WnyBaK11RvAtrStXbyBzrf9X2EfahFXeU28zxlZLoN0V8gW
         o5bnkr3UHZE9EVGeTqyyJ/utu9dI8vZnBI0eXykETpTUyNmPavGeeIjVlr2XDkYt/3ae
         Zdag==
X-Forwarded-Encrypted: i=1; AJvYcCVXY8sgr9e8LaiV3Mcct5VhrqRKcBjFxAoorr3+ECmV9Pgf029TNCwiAr8zrbSr7n83lvZIy+vXRWKk6kS88j0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv7Jjfl4ddl2E8YW4nAMRXTrhtwdqwLlCM61uqrJi04wq56z2q
	J0MQ3cYEXRTXPazJZjudI+FHpH9k/iHSqkY82k9GFcZI8PbRBqmLTiNhztsHU0I=
X-Google-Smtp-Source: AGHT+IGoaq6IxF5JKv0QXl4ovp1iUvSNYYrTn9zcpzec5/zG4S0O5fq1TFh5PoDP5AKow6h6x+T9lA==
X-Received: by 2002:a05:6000:2c6:b0:382:1c58:5787 with SMTP id ffacd0b85a97d-38225a89fe4mr2814514f8f.46.1731682922399;
        Fri, 15 Nov 2024 07:02:02 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:59f4:10be:886a:27eb? ([2001:67c:2fbc:1:59f4:10be:886a:27eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbbc4fsm4602869f8f.46.2024.11.15.07.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:02:01 -0800 (PST)
Message-ID: <288f68cd-533a-4253-85c4-951cc4a9c862@openvpn.net>
Date: Fri, 15 Nov 2024 16:02:27 +0100
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
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <eabe28f9-d6a4-4bdc-a988-418e5137f3cb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2024 02:54, Sergey Ryazanov wrote:
[...]

>> +/* Called after decrypt to write the IP packet to the device.
>> + * This method is expected to manage/free the skb.
>> + */
>> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff 
>> *skb)
>> +{
>> +    unsigned int pkt_len;
>> +
>> +    /* we can't guarantee the packet wasn't corrupted before entering 
>> the
>> +     * VPN, therefore we give other layers a chance to check that
>> +     */
>> +    skb->ip_summed = CHECKSUM_NONE;
>> +
>> +    /* skb hash for transport packet no longer valid after 
>> decapsulation */
>> +    skb_clear_hash(skb);
>> +
>> +    /* post-decrypt scrub -- prepare to inject encapsulated packet 
>> onto the
>> +     * interface, based on __skb_tunnel_rx() in dst.h
>> +     */
>> +    skb->dev = peer->ovpn->dev;
>> +    skb_set_queue_mapping(skb, 0);
>> +    skb_scrub_packet(skb, true);
>> +
> 
> The skb->protocol field is going to be updated in the upcoming patch in 
> the caller (ovpn_decrypt_post). Shall we put a comment here clarifying, 
> why do not touch the protocol field here?

Well, I would personally not document missing details in a partly 
implemented code path.

> 
>> +    skb_reset_network_header(skb);
> 
> ovpn_decrypt_post() already reseted the network header. Why do we need 
> it here again?

yeah, I think this can be removed.

> 
>> +    skb_reset_transport_header(skb);
>> +    skb_probe_transport_header(skb);
>> +    skb_reset_inner_headers(skb);
>> +
>> +    memset(skb->cb, 0, sizeof(skb->cb));
> 
> Why do we need to zero the control buffer here?

To avoid the next layer to assume the cb is clean while it is not.
Other drivers do the same as well.

I think this was recommended by Sabrina as well.

> 
>> +    /* cause packet to be "received" by the interface */
>> +    pkt_len = skb->len;
>> +    if (likely(gro_cells_receive(&peer->ovpn->gro_cells,
>> +                     skb) == NET_RX_SUCCESS))
>> +        /* update RX stats with the size of decrypted packet */
>> +        dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
>> +}
>> +
>> +static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>> +{
>> +    struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
>> +
>> +    if (unlikely(ret < 0))
>> +        goto drop;
>> +
>> +    ovpn_netdev_write(peer, skb);
>> +    /* skb is passed to upper layer - don't free it */
>> +    skb = NULL;
>> +drop:
>> +    if (unlikely(skb))
>> +        dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
>> +    ovpn_peer_put(peer);
>> +    kfree_skb(skb);
>> +}
>> +
>> +/* pick next packet from RX queue, decrypt and forward it to the 
>> device */
> 
> The function now receives packets from externel callers. Should we 
> update the above comment?

yap will do.

[...]

>> --- /dev/null
>> +++ b/drivers/net/ovpn/proto.h
>> @@ -0,0 +1,75 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*  OpenVPN data channel offload
>> + *
>> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
>> + *
>> + *  Author:    Antonio Quartulli <antonio@openvpn.net>
>> + *        James Yonan <james@openvpn.net>
>> + */
>> +
>> +#ifndef _NET_OVPN_OVPNPROTO_H_
>> +#define _NET_OVPN_OVPNPROTO_H_
>> +
>> +#include "main.h"
>> +
>> +#include <linux/skbuff.h>
>> +
>> +/* Methods for operating on the initial command
>> + * byte of the OpenVPN protocol.
>> + */
>> +
>> +/* packet opcode (high 5 bits) and key-id (low 3 bits) are combined in
>> + * one byte
>> + */
>> +#define OVPN_KEY_ID_MASK 0x07
>> +#define OVPN_OPCODE_SHIFT 3
>> +#define OVPN_OPCODE_MASK 0x1F
> 
> Instead of defining mask(s) and shift(s), we can define only masks and 
> use bitfield API (see below).
> 
>> +/* upper bounds on opcode and key ID */
>> +#define OVPN_KEY_ID_MAX (OVPN_KEY_ID_MASK + 1)
>> +#define OVPN_OPCODE_MAX (OVPN_OPCODE_MASK + 1)
>> +/* packet opcodes of interest to us */
>> +#define OVPN_DATA_V1 6 /* data channel V1 packet */
>> +#define OVPN_DATA_V2 9 /* data channel V2 packet */
>> +/* size of initial packet opcode */
>> +#define OVPN_OP_SIZE_V1 1
>> +#define OVPN_OP_SIZE_V2    4
>> +#define OVPN_PEER_ID_MASK 0x00FFFFFF
>> +#define OVPN_PEER_ID_UNDEF 0x00FFFFFF
>> +/* first byte of keepalive message */
>> +#define OVPN_KEEPALIVE_FIRST_BYTE 0x2a
>> +/* first byte of exit message */
>> +#define OVPN_EXPLICIT_EXIT_NOTIFY_FIRST_BYTE 0x28
> 
>  From the above list of macros, OVPN_KEY_ID_MAX, OVPN_OPCODE_MAX, 
> OVPN_OP_SIZE_V1, OVPN_KEEPALIVE_FIRST_BYTE, and 
> OVPN_EXPLICIT_EXIT_NOTIFY_FIRST_BYTE are unused and looks like should be 
> removed.

ACK

> 
>> +/**
>> + * ovpn_opcode_from_skb - extract OP code from skb at specified offset
>> + * @skb: the packet to extract the OP code from
>> + * @offset: the offset in the data buffer where the OP code is located
>> + *
>> + * Note: this function assumes that the skb head was pulled enough
>> + * to access the first byte.
>> + *
>> + * Return: the OP code
>> + */
>> +static inline u8 ovpn_opcode_from_skb(const struct sk_buff *skb, u16 
>> offset)
>> +{
>> +    u8 byte = *(skb->data + offset);
>> +
>> +    return byte >> OVPN_OPCODE_SHIFT;
> 
> For example here, the shift can be replaced with bitfield macro:
> 
> #define OVPN_OPCODE_PKTTYPE_MSK  0xf8000000
> #define OVPN_OPCODE_KEYID_MSK    0x07000000
> #define OVPN_OPCODE_PEERID_MSK   0x00ffffff
> 
> static inline u8 ovpn_opcode_from_skb(...)
> {
>      u32 opcode = be32_to_cpu(*(__be32 *)(skb->data + offset));
> 
>      return FIELD_GET(OVPN_OPCODE_PKTTYPE_MSK, opcode);
> }
> 
> And the upcoming ovpn_opcode_compose() can be implemented like this:
> 
> static inline u32 ovpn_opcode_compose(u8 opcode, u8 key_id, u32 peer_id)
> {
>      return FIELD_PREP(OVPN_OPCODE_PKTTYPE_MSK, opcode) |
>             FIELD_PREP(OVPN_OPCODE_KEYID_MSK, key_id) |
>             FIELD_PREP(OVPN_OPCODE_PEERID_MSK, peer_id);
> }
> 
> And with this size can be even embedded into ovpn_aead_encrypt() to make 
> the header composing more clear.

I wasn't aware of the bitfield API.

Yeah, it looks cleaner and gives a better definition of the first 4 
bytes of the header.

There is also GENMASK() that helps with creating MASKs instead of 
hardcofing the bits in hex.

Will give it a try, thanks!

> 
>> +}
>> +
>> +/**
>> + * ovpn_peer_id_from_skb - extract peer ID from skb at specified offset
>> + * @skb: the packet to extract the OP code from
>> + * @offset: the offset in the data buffer where the OP code is located
>> + *
>> + * Note: this function assumes that the skb head was pulled enough
>> + * to access the first 4 bytes.
>> + *
>> + * Return: the peer ID.
>> + */
>> +static inline u32 ovpn_peer_id_from_skb(const struct sk_buff *skb, 
>> u16 offset)
>> +{
>> +    return ntohl(*(__be32 *)(skb->data + offset)) & OVPN_PEER_ID_MASK;
>> +}
>> +
>> +#endif /* _NET_OVPN_OVPNPROTO_H_ */
>> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
>> index 
>> 090a3232ab0ec19702110f1a90f45c7f10889f6f..964b566de69f4132806a969a455cec7f6059a0bd 100644
>> --- a/drivers/net/ovpn/socket.c
>> +++ b/drivers/net/ovpn/socket.c
>> @@ -22,6 +22,9 @@ static void ovpn_socket_detach(struct socket *sock)
>>       if (!sock)
>>           return;
>> +    if (sock->sk->sk_protocol == IPPROTO_UDP)
>> +        ovpn_udp_socket_detach(sock);
>> +
>>       sockfd_put(sock);
>>   }
>> @@ -71,6 +74,27 @@ static int ovpn_socket_attach(struct socket *sock, 
>> struct ovpn_peer *peer)
>>       return ret;
>>   }
>> +/* Retrieve the corresponding ovpn object from a UDP socket
>> + * rcu_read_lock must be held on entry
>> + */
>> +struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk)
>> +{
>> +    struct ovpn_socket *ovpn_sock;
>> +
>> +    if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != 
>> UDP_ENCAP_OVPNINUDP))
>> +        return NULL;
>> +
>> +    ovpn_sock = rcu_dereference_sk_user_data(sk);
>> +    if (unlikely(!ovpn_sock))
>> +        return NULL;
>> +
>> +    /* make sure that sk matches our stored transport socket */
>> +    if (unlikely(!ovpn_sock->sock || sk != ovpn_sock->sock->sk))
>> +        return NULL;
>> +
>> +    return ovpn_sock->ovpn;
> 
> Now, returning of this pointer is safe. But the following TCP transport 
> support calls the socket release via a scheduled work. What extends 
> socket lifetime and makes it possible to receive a UDP packet way after 
> the interface private data release. Is it correct assumption?

Sorry you lost me when sayng "following *TCP* transp[ort support calls".
This function is invoked only in UDP context.
Was that a typ0?

> 
> If the above is right then shall we set ->ovpn = NULL before scheduling 
> the socket releasing work or somehow else mark the socket as half- 
> destroyed?
> 
>> +}
>> +
>>   /**
>>    * ovpn_socket_new - create a new socket and initialize it
>>    * @sock: the kernel socket to embed
>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>> index 
>> d26d7566e9c8dfe91fa77f49c34fb179a9fb2239..d1e88ae83843f02d591e67a7995f2d6868720695 100644
>> --- a/drivers/net/ovpn/udp.c
>> +++ b/drivers/net/ovpn/udp.c
>> @@ -21,9 +21,95 @@
>>   #include "bind.h"
>>   #include "io.h"
>>   #include "peer.h"
>> +#include "proto.h"
>>   #include "socket.h"
>>   #include "udp.h"
>> +/**
>> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
>> + * @sk: socket over which the packet was received
>> + * @skb: the received packet
>> + *
>> + * If the first byte of the payload is DATA_V2, the packet is further 
>> processed,
>> + * otherwise it is forwarded to the UDP stack for delivery to user 
>> space.
>> + *
>> + * Return:
>> + *  0 if skb was consumed or dropped
>> + * >0 if skb should be passed up to userspace as UDP (packet not 
>> consumed)
>> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
>> + */
>> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>> +{
>> +    struct ovpn_peer *peer = NULL;
>> +    struct ovpn_struct *ovpn;
>> +    u32 peer_id;
>> +    u8 opcode;
>> +
>> +    ovpn = ovpn_from_udp_sock(sk);
>> +    if (unlikely(!ovpn)) {
>> +        net_err_ratelimited("%s: cannot obtain ovpn object from UDP 
>> socket\n",
>> +                    __func__);
> 
> Probably we should zero ovpn pointer in the ovpn_sock to survive 
> scheduled socket release (see comment in ovpn_from_udp_sock). So, this 
> print should be removed to avoid printing misguiding errors.

I am also not following this. ovpn is already NULL if we are entering 
this branch, no?

And I think this condition is quite improbable as well.

> 
>> +        goto drop_noovpn;
>> +    }
>> +
>> +    /* Make sure the first 4 bytes of the skb data buffer after the UDP
>> +     * header are accessible.
>> +     * They are required to fetch the OP code, the key ID and the 
>> peer ID.
>> +     */
>> +    if (unlikely(!pskb_may_pull(skb, sizeof(struct udphdr) +
>> +                    OVPN_OP_SIZE_V2))) {
>> +        net_dbg_ratelimited("%s: packet too small\n", __func__);
>> +        goto drop;
>> +    }
>> +
>> +    opcode = ovpn_opcode_from_skb(skb, sizeof(struct udphdr));
>> +    if (unlikely(opcode != OVPN_DATA_V2)) {
>> +        /* DATA_V1 is not supported */
>> +        if (opcode == OVPN_DATA_V1)
>> +            goto drop;
> 
> This packet dropping makes protocol accelerator, intendent to speed up 
> the data packets processing, a protocol enforcement entity, isn't it? 
> Shall we follow the principle of beeing liberal in what we accept and 
> just forward everything besides data packets upstream to a userspace 
> application?

'ovpn' only supports DATA_V2. When ovpn is in use userspace does nto 
expect any DATA packet to bubble up as it would not know what to do with it.

So any decision regarding data packets should stay in 'ovpn'.

We just decided to support the modern DATA_V2 (DATA_V1 is seldomly used 
nowadays).

Moreover, it's quite impossible that a peer will send us DATA_V1 if it 
passed userspace handshake and negotiation.

> 
>> +
>> +        /* unknown or control packet: let it bubble up to userspace */
>> +        return 1;
>> +    }
>> +
>> +    peer_id = ovpn_peer_id_from_skb(skb, sizeof(struct udphdr));
>> +    /* some OpenVPN server implementations send data packets with the
>> +     * peer-id set to undef. In this case we skip the peer lookup by 
>> peer-id
>> +     * and we try with the transport address
>> +     */
>> +    if (peer_id != OVPN_PEER_ID_UNDEF) {
>> +        peer = ovpn_peer_get_by_id(ovpn, peer_id);
>> +        if (!peer) {
>> +            net_err_ratelimited("%s: received data from unknown peer 
>> (id: %d)\n",
>> +                        __func__, peer_id);
> 
> Why do we consider a peer sending us garbage our problem? Meaning, this 
> peer miss can be not our fault but a malformed packet from a 3rd party 
> side. E.g. nowdays I can see a lot of traces of these "active probers" 
> in my OpenVPN logs. Shall remove this message or at least make it debug 
> to avoid bothering users with garbage traveling Internet? Anyway we can 
> not do anything regarding incoming traffic.

It could also be a peer that believes to be connected while 'ovpn' 
dropped it earlier on. So this message would help the admin/user 
understanding what's going on. no?

Maybe make it an info/notice instead of error?

> 
>> +            goto drop;
>> +        }
>> +    }
>> +
>> +    if (!peer) {
> 
> AFAIU, this condition can true only in case of peer_id beeing equal to 
> OVPN_PEER_ID_UNDEF, right? In this case the condition check can be 
> replaced by simple 'else' statement.
> 

This part was actually rewritten already, so better wait for v12 before 
further discussing.

> And to make code more corresponding to the above comment regarding 
> implementations that send undefined peer-id, can we swap sides of the 
> lookup method selection? E.g.
> 
> /* Comment about fancy implementations sending undefined peer-id */
> if (peer_id == OVPN_PEER_ID_UNDEF) {
>    /* Do transport address based loockup */
> } else {
>    /* Do peer-id based loockup */
> }
> 
>> +        /* data packet with undef peer-id */
>> +        peer = ovpn_peer_get_by_transp_addr(ovpn, skb);
>> +        if (unlikely(!peer)) {
>> +            net_dbg_ratelimited("%s: received data with undef peer-id 
>> from unknown source\n",
>> +                        __func__);
>> +            goto drop;
>> +        }
>> +    }
>> +
>> +    /* pop off outer UDP header */
>> +    __skb_pull(skb, sizeof(struct udphdr));
>> +    ovpn_recv(peer, skb);
>> +    return 0;
>> +
>> +drop:
>> +    if (peer)
>> +        ovpn_peer_put(peer);
> 
> AFAIU, the peer is alway NULL here. Shall we remove the above check?

yeah simplified as well already.

Thanks!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


