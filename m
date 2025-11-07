Return-Path: <linux-kselftest+bounces-45104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B79C40611
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 15:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BAF34F1A39
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EDE2F12C6;
	Fri,  7 Nov 2025 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImPR8EIN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mLk97YuD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5D292B44
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525869; cv=none; b=o6rr8w3F17yMzGA1fK5pTu/RnGocgyI4r8ZwBkOIfYAtYSzOgIlWF2eEk1Wd+6GFdXpYx3Qh6ELcLGcrdhRGxRV2Z2x4T47O7Mcz0bgASVfjrs0atXcJS53mozDk39C0TX1kdtiMKq08YoI5IaSoUCLM9pChw0U1WkntXRBkof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525869; c=relaxed/simple;
	bh=4ACT8X04sb6fAW3+47LxhHcq7/anCem7+kuAeIdPdiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnF92Gh5hywvGaAXWp6ztsGZSknrpcJCkvHILd1KT8bXCDh+Ys0sdLmhrn2GcGMRFQuxHS1V6UbS0y1RXVQddYS02GvBqEs6kQZ6nPJkA79Za7FMhCLhH6wMrXP9MB9FUwMWMZ8PntxMuYyRiBmV7lZifEjgq9rRaD2wZ9UucT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImPR8EIN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mLk97YuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762525867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xL9UWKNVFseJyc8ZZEBbh4eUS+K/pGNVZX2OMNyP0Mg=;
	b=ImPR8EINkprteyKzchrBv35Kg+KZ4z+feJMQnXNI2ZKydf2fEHDeMHkRh6yyOQ/fvU6x8z
	EOrvFgofYAZnJYctsIh45pNoPoT36qXpnvKQ2VKVlWrJOx9xY8T4mV/DWefC02XTX2Uo1u
	Cc7o7NMjxmawpu+c+xQMdtYRMk84GJA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-cxUa6WkbPr2nViR6xGjJqw-1; Fri, 07 Nov 2025 09:31:03 -0500
X-MC-Unique: cxUa6WkbPr2nViR6xGjJqw-1
X-Mimecast-MFC-AGG-ID: cxUa6WkbPr2nViR6xGjJqw_1762525862
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b72ad85ee9aso98474666b.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 06:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762525862; x=1763130662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xL9UWKNVFseJyc8ZZEBbh4eUS+K/pGNVZX2OMNyP0Mg=;
        b=mLk97YuDYnfIMKSd3JKJTZrltUK5pFbg40ErvP8RuWFTwQaOgCdWIEABTiQkxTvgXS
         IN+8xcaiO2Wz70H8leqWjgwlAEPtfBF3tc6Z+k9ZLfvPbevMmJr1cf/HTHrx+xhWNy/N
         SfvR8k3VQSudhECmQeU+1VtiePzpZ1tjOwtPWXn4HLsfEOh+/o6rgNlYLYjXyjluVs2X
         bKmdLt9Rq6A1RIBuHeJ39twkX3f+84ZaJyagUzUEfANjCBv+sGJ5w6efmik0heIpsSOn
         OiNEPO/8OI1eLrPOHRWuRR7I8VfRE7+ynJEsWqEY3HVsZCqt14548/7O9I06rwb9mArS
         DpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525862; x=1763130662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xL9UWKNVFseJyc8ZZEBbh4eUS+K/pGNVZX2OMNyP0Mg=;
        b=NhK4a3Zl9JkdvOG7SODCQqhq5K8P+yeE1juegE9tXFQ2s7Qnt/O3HUyM1ISFI79dWu
         ZLwmOi8GWVwiUk7PN/n4VI3CXohjyEQEtqzSrDKDYElVibRn4qd8I1yjjU7B6L70Au/h
         FoqepELcawWbpEv7lwviWbIaUtjQMl2Vuan95d237UzUVQLHjzTLHpz1lmsY2CUzpTCI
         5Y0Zp9SIp3S3+N2Lun1FdbjtEf/HVHncL5qSAfBh1uEbrWuYBbbTBbONIgKM+3kchmOg
         Od1FoQVF+pVYjW9n5sxyGWJ91tO+fPu3yh8ujhBK5j3Jne9xdTvDdxEfgfRND1JzAq/T
         dGug==
X-Forwarded-Encrypted: i=1; AJvYcCX7LuiR+kQ4vUHX7FlRkNe3UIg0MErXV9aOFgejDh3nOrFpmYgc8nZb/H7IZn5TJazINwPZNXpg9t9FM/JtBpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjx4CVLrBjyI+FTRA/zg0QXF4K5MR1kO2Dfs4Th0qb3e67Nf3M
	42RAlmXTPgcLx3hCK9C5OojPfRYPXwaECEiGODafr/VBGnw6oWGek4kVtxG648K7bd2N9hSE8sq
	q+foFJ/zetUJ6lMicNEhrgvlZ4SiHjPtvuB8ismq2RetCxfmLgjyXFLyTRzRMcWaxKtHA6g==
X-Gm-Gg: ASbGncsIs6sa3XOKSlrDw6JDe837DSHMe35sNv65WTxOBW7Egob9RZdEyzPum+9tpmk
	vZUoEGcEUwBCWCKsKBBGmztriMKwov/e6I+EEy44RysevPO0szb6eRprDNOiR+G6zaAzLfCYCtP
	uy1Fg+HPaR79+kn/++geOHB1ZSBYdyZEMswY/v7BnQb40Utw9lxg3ZAFZys2izpHfOhMBfR78OO
	FovjA62JiEc3q/7UMuB2EnWbvjV+JHi99LhdEcryg0P4tgpA+vGX9qWnsvc2FpXgBoB8NoBsPPG
	Y4Oz2eEs80Nkaaqum3H1Pig/RJG72hETqy4oaoLl7jTEhFgCrG4x6qAL8vBsTS06mwVDdwlH/Vu
	ZuW1WtHjR7b7q1coHGZePACzmAcghKTN5ZamyGZXcJVKNIwcJXAI=
X-Received: by 2002:a17:907:9713:b0:b70:b4db:ae83 with SMTP id a640c23a62f3a-b72c0db4a61mr338300966b.60.1762525862121;
        Fri, 07 Nov 2025 06:31:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVGP6jVhYiYdDeDEvDFwhwEthJq43aCkNDIhOMB5uynFpxGPUKrXfFtjd4lbRPq2WOuVI1vw==
X-Received: by 2002:a17:907:9713:b0:b70:b4db:ae83 with SMTP id a640c23a62f3a-b72c0db4a61mr338295766b.60.1762525861624;
        Fri, 07 Nov 2025 06:31:01 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa11295sm256401966b.67.2025.11.07.06.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:31:01 -0800 (PST)
Date: Fri, 7 Nov 2025 15:30:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Message-ID: <4d365ifyw5ncyboonznnnm6ua7psyt3ripzpvtyd35qa5zsgwv@f2kfgzgoc26c>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
 <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>
 <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>

On Thu, Nov 06, 2025 at 06:52:15PM -0800, Bobby Eshleman wrote:
>On Thu, Nov 06, 2025 at 05:20:05PM +0100, Stefano Garzarella wrote:
>> On Thu, Oct 23, 2025 at 11:27:45AM -0700, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > Enable network namespace support in the virtio-vsock common transport
>> > layer by declaring namespace pointers in the transmit and receive
>> > paths.
>> >
>> > The changes include:
>> > 1. Add a 'net' field to virtio_vsock_pkt_info to carry the namespace
>> >   pointer for outgoing packets.
>> > 2. Store the namespace and namespace mode in the skb control buffer when
>> >   allocating packets (except for VIRTIO_VSOCK_OP_RST packets which do
>> >   not have an associated socket).
>> > 3. Retrieve namespace information from skbs on the receive path for
>> >   lookups using vsock_find_connected_socket_net() and
>> >   vsock_find_bound_socket_net().
>> >
>> > This allows users of virtio transport common code
>> > (vhost-vsock/virtio-vsock) to later enable namespace support.
>> >
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> > ---
>> > Changes in v7:
>> > - add comment explaining the !vsk case in 
>> > virtio_transport_alloc_skb()
>> > ---
>> > include/linux/virtio_vsock.h            |  1 +
>> > net/vmw_vsock/virtio_transport_common.c | 21 +++++++++++++++++++--
>> > 2 files changed, 20 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> > index 29290395054c..f90646f82993 100644
>> > --- a/include/linux/virtio_vsock.h
>> > +++ b/include/linux/virtio_vsock.h
>> > @@ -217,6 +217,7 @@ struct virtio_vsock_pkt_info {
>> > 	u32 remote_cid, remote_port;
>> > 	struct vsock_sock *vsk;
>> > 	struct msghdr *msg;
>> > +	struct net *net;
>> > 	u32 pkt_len;
>> > 	u16 type;
>> > 	u16 op;
>> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > index dcc8a1d5851e..b8e52c71920a 100644
>> > --- a/net/vmw_vsock/virtio_transport_common.c
>> > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > @@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>> > 					 info->flags,
>> > 					 zcopy);
>> >
>> > +	/*
>> > +	 * If there is no corresponding socket, then we don't have a
>> > +	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
>> > +	 */
>>
>> So, in virtio_transport_recv_pkt() should we check that `net` is not set?
>>
>> Should we set it to NULL here?
>>
>
>Sounds good to me.
>
>> > +	if (vsk) {
>> > +		virtio_vsock_skb_set_net(skb, info->net);
>>
>> Ditto here about the net refcnt, can the net disappear?
>> Should we use get_net() in some way, or the socket will prevent that?
>>
>
>As long as the socket has an outstanding skb it can't be destroyed and
>so will have a reference to the net, that is after skb_set_owner_w() and
>freeing... so I think this is okay.
>
>But, maybe we could simplify the implied relationship between skb, sk,
>and net by removing the VIRTIO_VSOCK_SKB_CB(skb)->net entirely, and only
>ever referring to sock_net(skb->sk)? I remember originally having a
>reason for adding it to the cb, but my hunch is it that it was probably
>some confusion over the !vsk case.
>
>WDYT?

If vsk == NULL, I'm expecting that also skb->sk is not valid, right?

Indeed we call skb_set_owner_w() only if vsk != NULL in 
virtio_transport_alloc_skb().

Maybe we need to change virtio_transport_recv_pkt() where the `net` 
should be passed in some way by the caller, so maybe this is the reason 
why you needed it in the cb. But also in that case, I think we can get 
the `net` in some way and pass it to virtio_transport_recv_pkt() and 
avoid the change in the cb:
- vsock_lookpback.c in vsock_loopback_work() we can use vsock->net
- vhost/vsock.c in vhost_vsock_handle_tx_kick(), ditto we can use 
   vsock->net
- virtio_transport.c we can just pass always the dummy_net

Same fot the net_mode.

Maybe the real problem is in the send_pkt callbacks, where the skb is 
used to get the socket, but as you mention, I think in this path 
skb_set_owner_w() is already called, so we can get that info from there 
in some way.

Not sure, but yeah, if we can remove that, it will be much clear IMO.

Thanks,
Stefano


