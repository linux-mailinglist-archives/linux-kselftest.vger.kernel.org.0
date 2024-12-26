Return-Path: <linux-kselftest+bounces-23759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C939FCE27
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 22:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F06F3A02D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 21:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501A619922A;
	Thu, 26 Dec 2024 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3ZehT+c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA521684B0;
	Thu, 26 Dec 2024 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735249960; cv=none; b=HB4Y9eRuxMp6hGrdv4k7snNfVSseullgIOt2GhvNweFCMdh6AZYfssVPWwgxZDHfFUxt1qeMNGypkJn13542P6RNx0b6IC74EJO1Ek+ec1jkUJgwPEfkOo5UOU0vq9Am2W1qkVK7AT24oRP5+C2YMSgkuNm+dATEJFyU//KCAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735249960; c=relaxed/simple;
	bh=f0g+9TpEftpkkRVmtnHw291rFkWzuN6lKnMDT0w0rTw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XjpSzzfywJ4JNd11on3FNHnUsHcSgb5E3b1wE+5hy36/WPHe1uLX0Jgz9XHzoVv9YRh0cgENygibmBMSGy511h/UHDHlf74RxqdOViNCzGg8mzAlRcS02g4ei8psp+shb3tn8HvBC8VBZc5d+PVrmaVaQxrIKMJkYaEOjgV0RzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3ZehT+c; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b9e2c1e3baso236165585a.3;
        Thu, 26 Dec 2024 13:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735249956; x=1735854756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5skAppR4fNztbvfmLBwOHnkr1eseDSJEMLlqTr/k3KU=;
        b=O3ZehT+cGIh5i9qxAMS72AS8wCyYAzM9WdRpU8MTCU3DLg806ZUprLI+fZTJNjxxEl
         3kyZkEAWQ+2e1X+sfWQemDu2ZU44zrGHfcSEdWqPOoJAX2D30s1uIAJYEYKEvXWb7IDx
         hJFA62J0ok2BMevhIayNAtGGXjuXNnyF8JDoCqcYtZpCsjnML+0p2R/6XXApLNl8zUlV
         xfrEvR1lBhf1BVOLQlHxsF7c/++ZFGCR2h/ZnmMZUUt6DNMoHeQsTL9+zKqoizupAz5g
         667+BHIicNCjwd/Lo1x9ZxVCHBambnRre5PiqZzxbqLXaG0eoExDtpTOUrf9wUIR7OK3
         JsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735249956; x=1735854756;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5skAppR4fNztbvfmLBwOHnkr1eseDSJEMLlqTr/k3KU=;
        b=c7nd44O0TOpUx3o+7ptO325H5yhw7dy5qG0+IPUzJ9+NeJSeqJcb/XLROpzidglxwq
         dHmQOoKh/wgaw2vxyN+SleU/joUYYI5BgvtrCuG/y+Uvcf4uCjBR74TMLUo8hyTFmTeS
         a0asBRFoq2w7mWhdNZVrPE7/YEe/WRVoYpzHzqQ2vY+6jMFQsYGmkj/6VXJcZ8Bjp0fu
         ldt+VV6pj4vRRt6F+TCKArYf7qb8kdAOpIMfaprNtvPNGSeiBc55jdpi7TxxyYi2wsaI
         EWsQjYdYBcWWgPP8AWcKH0vpzWKW1e0BMcDBK4AEOizNaWQDjhX9sfa/KrvfIeTLz5cR
         xMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq+ziuwsMKVw760ymOaHjo4zPUfJJuGGx6pojyo0B/YMy2SdSPdnIhsYlQP1J6vjN2xXrxeW2DAFdRZhp5@vger.kernel.org, AJvYcCW/1IfhM/EJt4yod6rSutan2UouFred/0bGRJtsDsCUrF7CxN62UsTu/HJGf4grn/shRlE=@vger.kernel.org, AJvYcCW3he9tylbynODkDBmdJbaJneC8NUX+XwWGtsYsUC/fpxj+uiHdTMYjL3utGFd/vgERoGRd3c7fwzQM3MXN6wUF@vger.kernel.org, AJvYcCWans+Kkjf1HDuOvT7PBdc2Dh4baXPrymhWlS+M5hS1lk8p03eFEbqefxwJJrs54FVHn2jwTmeq3oEW@vger.kernel.org, AJvYcCWopEh1F3xj+g9Ssy5pfO5SAh8ziOzr0VZVxfzEB3oP7LdqlFq/ny92AdUvCwnuIeceD9X/VnKB@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBcf1Izk/aM8j6fp22H9XMYWrp2Z1KsCJXt6jPGlr9DgqcuSG
	Ysh76bv/WM8ouHjNlFCoMQB7kZML0aV+AFxyfg1+reuwLzgm7AO0oFZh8A==
X-Gm-Gg: ASbGnctU1nbbou1OD04LTmUe+BeszeEqFxpRp5r7I3qNy+o6w/3jndkhrf5kFvVtUzg
	7EwGtxMIqfbKQdbgeLpUBcU9hYuC+N9p4Cn51dDgTlYUJjl7ssZBB0YQtlfGl+e6nIfjOWTs3rP
	WC5cn3loXmS1ttgSdiTLjis+ql46yx9RiMIMtkQ4TOa0b/fzjaBXVBWa+AwNlkbqajRW6K5EaM1
	MIuhgxsQMUwTQutxejdYZmAb5ZUaIXxj53LZ4M16drIf9bu2bCdobum72tkvRPvzRS/IJOU/hm3
	al39cjit7bYgTb80cbQOxxpR2uuHAj7Vew==
X-Google-Smtp-Source: AGHT+IFaZ98AGT4ItA96YaK7A/6hrexLBSr8q1i1ics39770GhB9RyM9ZoJ876sVuq+UmZz8G5NF6Q==
X-Received: by 2002:a05:620a:4045:b0:7b6:c543:7e54 with SMTP id af79cd13be357-7b9ba75c1aamr3705501285a.22.1735249956410;
        Thu, 26 Dec 2024 13:52:36 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bbfc5sm650803285a.1.2024.12.26.13.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 13:52:35 -0800 (PST)
Date: Thu, 26 Dec 2024 16:52:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 David Ahern <dsahern@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Joe Damato <jdamato@fastly.com>, 
 dw@davidwei.uk
Message-ID: <676dd022d1388_1d346b2947@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241221004236.2629280-6-almasrymina@google.com>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-6-almasrymina@google.com>
Subject: Re: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mina Almasry wrote:
> Augment dmabuf binding to be able to handle TX. Additional to all the RX
> binding, we also create tx_vec and tx_iter needed for the TX path.
> 
> Provide API for sendmsg to be able to send dmabufs bound to this device:
> 
> - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from,
>   and the offset into the dmabuf to send from.
> - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.
> 
> Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
> implementation, while disabling instances where MSG_ZEROCOPY falls back
> to copying.
> 
> We additionally look up the dmabuf to send from by id, then pipe the
> binding down to the new zerocopy_fill_skb_from_devmem which fills a TX skb
> with net_iov netmems instead of the traditional page netmems.
> 
> We also special case skb_frag_dma_map to return the dma-address of these
> dmabuf net_iovs instead of attempting to map pages.
> 
> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
> of the implementation came from devmem TCP RFC v1[1], which included the
> TX path, but Stan did all the rebasing on top of netmem/net_iov.
> 
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>  include/linux/skbuff.h                  | 13 +++-
>  include/net/sock.h                      |  2 +
>  include/uapi/linux/uio.h                |  5 ++
>  net/core/datagram.c                     | 40 ++++++++++-
>  net/core/devmem.c                       | 91 +++++++++++++++++++++++--
>  net/core/devmem.h                       | 40 +++++++++--
>  net/core/netdev-genl.c                  | 65 +++++++++++++++++-
>  net/core/skbuff.c                       |  8 ++-
>  net/core/sock.c                         |  9 +++
>  net/ipv4/tcp.c                          | 36 +++++++---
>  net/vmw_vsock/virtio_transport_common.c |  4 +-
>  11 files changed, 281 insertions(+), 32 deletions(-)
> 

> +static int zerocopy_fill_skb_from_devmem(struct sk_buff *skb,
> +					 struct msghdr *msg,
> +					 struct iov_iter *from, int length)
> +{
> +	int i = skb_shinfo(skb)->nr_frags;
> +	int orig_length = length;
> +	netmem_ref netmem;
> +	size_t size;
> +
> +	while (length && iov_iter_count(from)) {
> +		if (i == MAX_SKB_FRAGS)
> +			return -EMSGSIZE;
> +
> +		size = min_t(size_t, iter_iov_len(from), length);
> +		if (!size)
> +			return -EFAULT;

On error, should caller skb_zerocopy_iter_stream rewind from, rather
than (or as well as) msg->msg_iter?
> +
> +		netmem = net_iov_to_netmem(iter_iov(from)->iov_base);
> +		get_netmem(netmem);
> +		skb_add_rx_frag_netmem(skb, i, netmem, from->iov_offset, size,
> +				       PAGE_SIZE);
> +
> +		iov_iter_advance(from, size);
> +		length -= size;
> +		i++;
> +	}
> +
> +	iov_iter_advance(&msg->msg_iter, orig_length);

What does this do if sendmsg is called with NULL as buffer?
> +
> +	return 0;
> +}
> +
>  int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>  			    struct sk_buff *skb, struct iov_iter *from,
> -			    size_t length)
> +			    size_t length, bool is_devmem)
>  {
>  	unsigned long orig_size = skb->truesize;
>  	unsigned long truesize;
> @@ -702,6 +736,8 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>  
>  	if (msg && msg->msg_ubuf && msg->sg_from_iter)
>  		ret = msg->sg_from_iter(skb, from, length);
> +	else if (unlikely(is_devmem))
> +		ret = zerocopy_fill_skb_from_devmem(skb, msg, from, length);
>  	else
>  		ret = zerocopy_fill_skb_from_iter(skb, from, length);
>  
> @@ -735,7 +771,7 @@ int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
>  	if (skb_copy_datagram_from_iter(skb, 0, from, copy))
>  		return -EFAULT;
>  
> -	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U);
> +	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U, NULL);
>  }
>  EXPORT_SYMBOL(zerocopy_sg_from_iter);

>  struct net_iov *
>  net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
> @@ -109,6 +112,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  	unsigned long xa_idx;
>  	unsigned int rxq_idx;
>  
> +	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> +
> +	/* Ensure no tx net_devmem_lookup_dmabuf() are in flight after the
> +	 * erase.
> +	 */
> +	synchronize_net();
> +

What precisely does this protect?

synchronize_net() ensures no packet is in flight inside an rcu
readside section. But a packet can still be in flight, such as posted
to the device or queued in a qdisc.

>  	if (binding->list.next)
>  		list_del(&binding->list);
>  
> @@ -122,8 +132,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
>  	}
>  
> -	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> -
>  	net_devmem_dmabuf_binding_put(binding);
>  }
>  
> @@ -174,8 +182,9 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
>  }
>  
>  struct net_devmem_dmabuf_binding *
> -net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> -		       struct netlink_ext_ack *extack)
> +net_devmem_bind_dmabuf(struct net_device *dev,
> +		       enum dma_data_direction direction,
> +		       unsigned int dmabuf_fd, struct netlink_ext_ack *extack)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
>  	static u32 id_alloc_next;
> @@ -183,6 +192,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  	struct dma_buf *dmabuf;
>  	unsigned int sg_idx, i;
>  	unsigned long virtual;
> +	struct iovec *iov;
>  	int err;
>  
>  	dmabuf = dma_buf_get(dmabuf_fd);
> @@ -218,13 +228,19 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  	}
>  
>  	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
> -						       DMA_FROM_DEVICE);
> +						       direction);
>  	if (IS_ERR(binding->sgt)) {
>  		err = PTR_ERR(binding->sgt);
>  		NL_SET_ERR_MSG(extack, "Failed to map dmabuf attachment");
>  		goto err_detach;
>  	}
>  
> +	if (!binding->sgt || binding->sgt->nents == 0) {
> +		err = -EINVAL;
> +		NL_SET_ERR_MSG(extack, "Empty dmabuf attachment");
> +		goto err_detach;
> +	}
> +
>  	/* For simplicity we expect to make PAGE_SIZE allocations, but the
>  	 * binding can be much more flexible than that. We may be able to
>  	 * allocate MTU sized chunks here. Leave that for future work...
> @@ -236,6 +252,19 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  		goto err_unmap;
>  	}
>  
> +	if (direction == DMA_TO_DEVICE) {
> +		virtual = 0;
> +		for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx)
> +			virtual += sg_dma_len(sg);
> +
> +		binding->tx_vec = kcalloc(virtual / PAGE_SIZE + 1,

instead of open coding this computation repeatedly, consider a local
variable. And parentheses and maybe round_up().

> +					  sizeof(struct iovec), GFP_KERNEL);
> +		if (!binding->tx_vec) {
> +			err = -ENOMEM;
> +			goto err_unmap;
> +		}
> +	}
> +
>  	virtual = 0;
>  	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
>  		dma_addr_t dma_addr = sg_dma_address(sg);
> @@ -277,11 +306,21 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  			niov->owner = owner;
>  			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
>  						      net_devmem_get_dma_addr(niov));
> +
> +			if (direction == DMA_TO_DEVICE) {
> +				iov = &binding->tx_vec[virtual / PAGE_SIZE + i];

why does this start counting at virtual / PAGE_SIZE, rather than 0?

> +				iov->iov_base = niov;
> +				iov->iov_len = PAGE_SIZE;
> +			}
>  		}
>  
>  		virtual += len;
>  	}
>  
> +	if (direction == DMA_TO_DEVICE)
> +		iov_iter_init(&binding->tx_iter, WRITE, binding->tx_vec,
> +			      virtual / PAGE_SIZE + 1, virtual);
> +
>  	return binding;
>  
>  err_free_chunks:
> @@ -302,6 +341,21 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  	return ERR_PTR(err);
>  }
>  
> +struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
> +{
> +	struct net_devmem_dmabuf_binding *binding;
> +
> +	rcu_read_lock();
> +	binding = xa_load(&net_devmem_dmabuf_bindings, id);
> +	if (binding) {
> +		if (!net_devmem_dmabuf_binding_get(binding))
> +			binding = NULL;
> +	}
> +	rcu_read_unlock();
> +
> +	return binding;
> +}
> +
>  void dev_dmabuf_uninstall(struct net_device *dev)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
> @@ -332,6 +386,33 @@ void net_devmem_put_net_iov(struct net_iov *niov)
>  	net_devmem_dmabuf_binding_put(niov->owner->binding);
>  }
>  
> +struct net_devmem_dmabuf_binding *
> +net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc)
> +{
> +	struct net_devmem_dmabuf_binding *binding;
> +	int err = 0;
> +
> +	binding = net_devmem_lookup_dmabuf(sockc->dmabuf_id);

This lookup is from global xarray net_devmem_dmabuf_bindings.

Is there a check that the socket is sending out through the device
to which this dmabuf was bound with netlink? Should there be?
(e.g., SO_BINDTODEVICE).

> +	if (!binding || !binding->tx_vec) {
> +		err = -EINVAL;
> +		goto out_err;
> +	}
> +
> +	if (sock_net(sk) != dev_net(binding->dev)) {
> +		err = -ENODEV;
> +		goto out_err;
> +	}
> +
> +	iov_iter_advance(&binding->tx_iter, sockc->dmabuf_offset);
> +	return binding;
> +
> +out_err:
> +	if (binding)
> +		net_devmem_dmabuf_binding_put(binding);
> +
> +	return ERR_PTR(err);
> +}
> +
>  /*** "Dmabuf devmem memory provider" ***/
>  

> @@ -1063,6 +1064,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  
>  	flags = msg->msg_flags;
>  
> +	sockcm_init(&sockc, sk);
> +	if (msg->msg_controllen) {
> +		err = sock_cmsg_send(sk, msg, &sockc);
> +		if (unlikely(err)) {
> +			err = -EINVAL;
> +			goto out_err;
> +		}
> +	}
> +
>  	if ((flags & MSG_ZEROCOPY) && size) {
>  		if (msg->msg_ubuf) {
>  			uarg = msg->msg_ubuf;
> @@ -1080,6 +1090,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  			else
>  				uarg_to_msgzc(uarg)->zerocopy = 0;
>  		}
> +
> +		if (sockc.dmabuf_id != 0) {
> +			binding = net_devmem_get_sockc_binding(sk, &sockc);
> +			if (IS_ERR(binding)) {
> +				err = PTR_ERR(binding);
> +				binding = NULL;
> +				goto out_err;
> +			}
> +		}

