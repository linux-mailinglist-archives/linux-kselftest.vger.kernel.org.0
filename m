Return-Path: <linux-kselftest+bounces-45052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DCEC3E48D
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 03:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D69834B3F7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 02:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC87C2EBB88;
	Fri,  7 Nov 2025 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJF2I0X1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D32DC783
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483940; cv=none; b=HM/zZcTGBvNdlwrD/RtZWCZDm6TPouXHZU4IzhBDcdAywCsbcc3jS/4LEo//QeD8C4QyYRkcpoiJvTuTq1yjy9raO3R3Xh8+pgBvElPcpmAVOy4h6gcnsP46tMyO2koBKyZotYnLTFwKptDkjQXsNPVFUTIVNteyFNdZVDk6kjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483940; c=relaxed/simple;
	bh=LGZkf7YP6OLV6kK3Rv7CYUIiRvg3i+u7/aOFPhkBPKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ9KUutBxFw46Ip1BaPbtyBK1jnf9VpZ7MWUzooR7Q8D/03KI++3jOHR6S7pFg0T4NXN+J/+uycItBgUe00sGzeatX8xGjEdybmyQOPu2nhgzgQpOudVeTwzD2gpKaxF0TY4Dj43x74JoXy9msMAlQR2X15vq3UU0/c8b6hcyn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJF2I0X1; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7869dee42cdso3476307b3.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 18:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762483938; x=1763088738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=to+M3YH5XNWJ8sgc76iueqXwuR+T+gGj83wJZ0qaDfw=;
        b=kJF2I0X1AKqT9qXyqG+VcidrqeN5gvl0jJRs2IONlijFLouYtf02uxAT5wGnSrLEpN
         Tp8/Zk2GFMhBzcmxkrkU9iHoerpdmNlyI+SIRMdHSdG34P9nOmE4VR6alI7kqLDI7TGQ
         zyyV7eZDwNMWoPK557DH6O7DpBHedIX0MoSdobE1CllqN7uIIgbXl7rOKBTTeGBMVyDy
         c3qte+sOn7hqBWkEohW+68dxlsTdQ8bcAW81aVvEfEVdG74BUsUvEj3tcmUgBCnsvfK6
         8SzLU8EwY+KiJfYM6GKiTvic+s0pTs7NfwYOT6NEnZpxAX0FIUso1KGlABN5oDqJpyin
         f2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762483938; x=1763088738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=to+M3YH5XNWJ8sgc76iueqXwuR+T+gGj83wJZ0qaDfw=;
        b=L7q3xnBWnFmwH/PlbSgOjuUjqF384Zl0pqgGkh3M0GWMhtZzu/enQZ0rwkifnvauF5
         ZIMH3O4DyAYRQCahCR+Gxmxo3XXoyScfGYEgHQAtvRF/IuSHUoxx2oc/3bGku+4y9KXl
         RXbvPvXt7MXCxpu9DAeX4ZlXnMbOlY229z3gQWXGD3HCenvbP7Wkb+uh9G1kSgGXQ7KK
         bDYKsP8N/YAglcvehCXouIxztY9m5sf83vV8QII374slQTRXD5MmPOySKKhZkWiWtVfU
         eZgrGxhzsqjBNK6ltnt33F/zhbO5s1qaTSaI9IiDbCuWB42rkV72o3xNKVVOX4PAl80L
         FCSg==
X-Forwarded-Encrypted: i=1; AJvYcCWBN0x31RGlGeRP1K9N+3WwO2Z64tEVpFOdeonzP8EGY1L8GCS8Rq+x1ifRR7IwVBiBYqWRBzGUG67Et1FI7iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRW52HODdFCLjPeWyhpIm9v22121tflCQhtGPPru5vsCVxIVqM
	Xa1o+7CPLrIhfQseun2GKHtcmwXvUmmkOJtwg9Kqzsnb0SsHR2lxWSCJ
X-Gm-Gg: ASbGncvy+EfxNxBAp7YS/4VOHQ8bLwMlLbMcLYGPdg5Qs0fhnPfA+KdkrV8PjdDU4Ib
	mPkbg7TN+6kFEvDUfSLPITSHQqx5CdMmjc21T27fFng/GxTyNNzLP4m7Z7GlQjBTyO4V3dVdt9/
	otzf2BE/AYyeU5qJwaEjmRafpSxP0nOVm5ayycfEc5cfMDDJhi8ediNWFfJfQqV1WbpbYX4F8lm
	N2EA8HiOYe029e2bbn+bnfy1Rc+CES1U6HF8jC69Xy6EBJiBqO6wAEV9LefZAM/ryaxxQnTz1c5
	rpsaWc5qQXoWyycmi62igxplM5izY1L6MhNsSkkO2Zm/z2emFXbgQB2opJeVwgPPOcPpFlq+WA1
	B8OyE6saN/MKEjPVuJ7sAKkkC/Fu1xd18v3xQkbZ0N8+1HLdUfYGexga/elzrJZNCAYDtEuD7mU
	j/Z7PrJWi+B2d2Obyso2XZ8y936mNwhzqL3/If
X-Google-Smtp-Source: AGHT+IEjmJ3F7jVxmWzAKOE8ZCFLH8yvuCjB7m8mU8An6yxSyAVDGX/tJUnPe0dCIHSXZMA38QvYjg==
X-Received: by 2002:a05:690e:4185:b0:63e:1563:4801 with SMTP id 956f58d0204a3-640c9d699f7mr96467d50.22.1762483937682;
        Thu, 06 Nov 2025 18:52:17 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5ca70f7sm1358837d50.12.2025.11.06.18.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 18:52:17 -0800 (PST)
Date: Thu, 6 Nov 2025 18:52:15 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Message-ID: <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
 <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>

On Thu, Nov 06, 2025 at 05:20:05PM +0100, Stefano Garzarella wrote:
> On Thu, Oct 23, 2025 at 11:27:45AM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Enable network namespace support in the virtio-vsock common transport
> > layer by declaring namespace pointers in the transmit and receive
> > paths.
> > 
> > The changes include:
> > 1. Add a 'net' field to virtio_vsock_pkt_info to carry the namespace
> >   pointer for outgoing packets.
> > 2. Store the namespace and namespace mode in the skb control buffer when
> >   allocating packets (except for VIRTIO_VSOCK_OP_RST packets which do
> >   not have an associated socket).
> > 3. Retrieve namespace information from skbs on the receive path for
> >   lookups using vsock_find_connected_socket_net() and
> >   vsock_find_bound_socket_net().
> > 
> > This allows users of virtio transport common code
> > (vhost-vsock/virtio-vsock) to later enable namespace support.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v7:
> > - add comment explaining the !vsk case in virtio_transport_alloc_skb()
> > ---
> > include/linux/virtio_vsock.h            |  1 +
> > net/vmw_vsock/virtio_transport_common.c | 21 +++++++++++++++++++--
> > 2 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 29290395054c..f90646f82993 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -217,6 +217,7 @@ struct virtio_vsock_pkt_info {
> > 	u32 remote_cid, remote_port;
> > 	struct vsock_sock *vsk;
> > 	struct msghdr *msg;
> > +	struct net *net;
> > 	u32 pkt_len;
> > 	u16 type;
> > 	u16 op;
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index dcc8a1d5851e..b8e52c71920a 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> > 					 info->flags,
> > 					 zcopy);
> > 
> > +	/*
> > +	 * If there is no corresponding socket, then we don't have a
> > +	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
> > +	 */
> 
> So, in virtio_transport_recv_pkt() should we check that `net` is not set?
> 
> Should we set it to NULL here?
> 

Sounds good to me.

> > +	if (vsk) {
> > +		virtio_vsock_skb_set_net(skb, info->net);
> 
> Ditto here about the net refcnt, can the net disappear?
> Should we use get_net() in some way, or the socket will prevent that?
> 

As long as the socket has an outstanding skb it can't be destroyed and
so will have a reference to the net, that is after skb_set_owner_w() and
freeing... so I think this is okay.

But, maybe we could simplify the implied relationship between skb, sk,
and net by removing the VIRTIO_VSOCK_SKB_CB(skb)->net entirely, and only
ever referring to sock_net(skb->sk)? I remember originally having a
reason for adding it to the cb, but my hunch is it that it was probably
some confusion over the !vsk case.

WDYT?

[...]

> > 
> > 	return virtio_transport_send_pkt_info(vsk, &info);
> > @@ -1578,7 +1593,9 @@ static bool virtio_transport_valid_type(u16 type)
> > void virtio_transport_recv_pkt(struct virtio_transport *t,
> > 			       struct sk_buff *skb)
> > {
> > +	enum vsock_net_mode net_mode = virtio_vsock_skb_net_mode(skb);
> > 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > +	struct net *net = virtio_vsock_skb_net(skb);
> 
> Okay, so this is where the skb net is read, so why we touch the virtio-vsock
> driver (virtio_transport.c) in the other patch where we changed just
> af_vsock.c?
> 
> IMO we should move that change here, or in a separate commit.
> Or maybe I missed some dependency :-)
> 

100% agree.

> Thanks,
> Stefano
> 

Thanks!

-Bobby

