Return-Path: <linux-kselftest+bounces-29649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A3EA6DF93
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0541894EB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4C6263C8F;
	Mon, 24 Mar 2025 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghkYaMu/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E82638BF;
	Mon, 24 Mar 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833505; cv=none; b=j7sp82v4jSoKAOqSMXnVHmHuVXF7Rzw1uiS1j8JZ1pGZHW6QB2DllRPvQfpW19w03zUykksLIjcgMt3+W+1J1CMHLTQGxNXaHSSpPNyFMGhCTBdeNZcBJzTRtM8L9tW0jYxIVN2Cxy0LLtRQCTMwaj4ABbhZtB/acrb+juiRUNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833505; c=relaxed/simple;
	bh=nKiaV2uy994lXoUMTABtnMyxxM77OqDyio0SZZIffOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlOoZ90fWRQ6tLc7cBqGsEzwdtTQPffiiV0T3LJfxEyzqSnONB5wnsh00lQ1NIXiriMeSBShyFYUvcHp+VJ1549s6DAVLFoyh0l+i3V0Ln9F+nIzC/21plCSrr+qWbLAmxgG8GhDml0L5PzZy1rmxQoV9Buh9EWipgsyrlmP6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghkYaMu/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22622ddcc35so15895285ad.2;
        Mon, 24 Mar 2025 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742833502; x=1743438302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xgwbZFV4k14U0YMVn2vdNZn0XHzElupWe5Rio/k7zP8=;
        b=ghkYaMu/mpjx0jgfnayzX69LSz7S8UbiytUN78W9VXoB+6yLDbwAmpWPl//wmFgXot
         896tNAk5op9emHSc+/oiIIAFklOACQGOW1rkeimFaHttY0c45ourWYzq1nMuGn8INDM4
         id9YaPHO3T2yevnHuxMG/VOwFbyafj7XuqBVZWQzzkt9oqAkXG64V0pjotX6VZ2KvdkW
         V8HetI+C/ApASvzGbYI3V+/RWbw+8GcGTzWHhHOhGNcyDiNOkpTXl8IudnQbClFXgB3W
         cJ80hrhvKIt909RHIanYLjC9NiT+Q1eHjthDbfzzCL1X1BHr+zjuS0TxWxvndXNNOfS1
         zM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833502; x=1743438302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgwbZFV4k14U0YMVn2vdNZn0XHzElupWe5Rio/k7zP8=;
        b=lzn1XZMoMbBjunCce42hVD1Ne3Ea0tvso8NtKA2eGD7zlUAKrUxtjIJf5djvZKwt0b
         IEbXNUYfLYi8ju4pNS7XRixmM4WnoQAxrGZdWfRLIM+/Bs8qWOBpB06vDgQj4ciIv8NC
         5PW8DFO68P67a1ECemUHpRN/bYAG+XFOMdEHzM2fv56Cdl+fbGZreY5+TMBONHNMYriF
         MFisuDKTjR3aVCQNv/ssR+RQ32aU601wljBZ3ApdSykv+g2/zjZEBUknyG4ItA5a2xHc
         rcdajcXnOfDYazoBklFPoXA/gIkZe4jkzqUl6OdwHHMA0geCBmI4FaO09ee6esECnf/F
         b8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUjS01FfLPg5wr0j9WwuA8kPzVm/H2+2cx+2hnRJl4EsG4JY9DXEQqU9+WtqHOtNmXcIkIgRzTU6Kq8oPx5tMS9@vger.kernel.org, AJvYcCVUUyWqLfSwUpIgqfIBRvZ4dyXhL+bUb1Hr2gC4Q3A9n34W8U4JA9h0kcAxAZSHeJoE5rpCfSsUg3J/@vger.kernel.org, AJvYcCWzeh2lwAhZUVYCAKQOVbrXcmDRPGy9J/atbrDaPvZiUfVuYGUoD8ajlitJgTAp1sq1DpVSARqdciXtlOfk@vger.kernel.org, AJvYcCXNi6pG/1XJoUdsLwEzMlDYkSkRvz8BkjEy9+YV9/bWbULdV+B/yjXIkReao8CdukixAi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuY6d2WW/Jm38armMs71eMYtUbPzl3hnxqdNwuW43M2c+bA22P
	v8YzmgWbEQSovKyZvVmrtSATBZksIULhYvKS+SHTPXkFWfriZxA=
X-Gm-Gg: ASbGncuxUMSTp0CM52AWI88NxZIQNsodmQYcIbv2wnhHplMu13YOgKD26RrrBPigALR
	jNqm/fJf+TuAYkjp7IntW0XtUszIrNaMS+0L/fFw7n/+nTNw8dtuBpak7UqYXbER3nPyR0Tabkt
	a/uG8f4o1+xMOKUBcJaDJKNC2nOk2mnsV/eCllb5qu9jzStOmXo0gpnW6pOM+ZzCZHsy9le2I8Z
	G5B/BXH4/naOz/76mjnb/yF3HQeT3CZR8bMzkYKVuFAMU/IK6vz8M95A0F16GQ5flJRzEV5X5f8
	UKjY7ny3/BPReWsffCSsF1hHf2VTskNi6lR45uteI5hYpPcy0hg8iW0=
X-Google-Smtp-Source: AGHT+IGiKdTRdw+DiZr6HOCnUFelGGI14bMpQuoiyBGUP2qfPnA02Nacb7vxr2vvXb4uQfUTp7x5gw==
X-Received: by 2002:a17:902:d48b:b0:21f:52e:939e with SMTP id d9443c01a7336-22780d8ff5bmr203919345ad.28.1742833502117;
        Mon, 24 Mar 2025 09:25:02 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811e34cfsm73122975ad.201.2025.03.24.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:25:01 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:25:00 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v7 4/9] net: devmem: Implement TX path
Message-ID: <Z-GHXCOgP0pZBSlS@mini-arch>
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250308214045.1160445-5-almasrymina@google.com>

On 03/08, Mina Almasry wrote:
> Augment dmabuf binding to be able to handle TX. Additional to all the RX
> binding, we also create tx_vec needed for the TX path.
> 
> Provide API for sendmsg to be able to send dmabufs bound to this device:
> 
> - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
> - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.
> 
> Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
> implementation, while disabling instances where MSG_ZEROCOPY falls back
> to copying.
> 
> We additionally pipe the binding down to the new
> zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmems
> instead of the traditional page netmems.
> 
> We also special case skb_frag_dma_map to return the dma-address of these
> dmabuf net_iovs instead of attempting to map pages.
> 
> The TX path may release the dmabuf in a context where we cannot wait.
> This happens when the user unbinds a TX dmabuf while there are still
> references to its netmems in the TX path. In that case, the netmems will
> be put_netmem'd from a context where we can't unmap the dmabuf, Resolve
> this by making __net_devmem_dmabuf_binding_free schedule_work'd.
> 
> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
> of the implementation came from devmem TCP RFC v1[1], which included the
> TX path, but Stan did all the rebasing on top of netmem/net_iov.
> 
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> ---
> 
> v6:
> - Retain behavior that MSG_FASTOPEN succeeds even if cmsg is invalid
>   (Paolo).
> - Rework the freeing of tx_vec slightly to improve readability. Now it
>   has its own err label (Paolo).
> - Squash making unbinding scheduled work (Paolo).
> - Add comment to clarify that net_iovs stuck in the transmit path hold
>   a ref on the underlying dmabuf binding (David).
> - Fix the comment on how binding refcounting works on RX (the comment
>   was not matching the existing code behavior).
> 
> v5:
> - Return -EFAULT from zerocopy_fill_skb_from_devmem (Stan)
> - don't null check before kvfree (stan).
> 
> v4:
> - Remove dmabuf_tx_cmsg definition and just use __u32 for the dma-buf id
>   (Willem).
> - Check that iov_iter_type() is ITER_IOVEC in
>   zerocopy_fill_skb_from_iter() (Pavel).
> - Fix binding->tx_vec not being freed on error paths (Paolo).
> - Make devmem patch mutually exclusive with msg->ubuf_info path (Pavel).
> - Check that MSG_ZEROCOPY and SOCK_ZEROCOPY are provided when
>   sockc.dmabuf_id is provided.
> - Don't mm_account_pinned_pages() on devmem TX (Pavel).
> 
> v3:
> - Use kvmalloc_array instead of kcalloc (Stan).
> - Fix unreachable code warning (Simon).
> 
> v2:
> - Remove dmabuf_offset from the dmabuf cmsg.
> - Update zerocopy_fill_skb_from_devmem to interpret the
>   iov_base/iter_iov_addr as the offset into the dmabuf to send from
>   (Stan).
> - Remove the confusing binding->tx_iter which is not needed if we
>   interpret the iov_base/iter_iov_addr as offset into the dmabuf (Stan).
> - Remove check for binding->sgt and binding->sgt->nents in dmabuf
>   binding.
> - Simplify the calculation of binding->tx_vec.
> - Check in net_devmem_get_binding that the binding we're returning
>   has ifindex matching the sending socket (Willem).
> ---
>  include/linux/skbuff.h                  |  17 +++-
>  include/net/sock.h                      |   1 +
>  net/core/datagram.c                     |  48 ++++++++++-
>  net/core/devmem.c                       | 105 ++++++++++++++++++++++--
>  net/core/devmem.h                       |  61 +++++++++++---
>  net/core/netdev-genl.c                  |  64 ++++++++++++++-
>  net/core/skbuff.c                       |  18 ++--
>  net/core/sock.c                         |   6 ++
>  net/ipv4/ip_output.c                    |   3 +-
>  net/ipv4/tcp.c                          |  50 ++++++++---
>  net/ipv6/ip6_output.c                   |   3 +-
>  net/vmw_vsock/virtio_transport_common.c |   5 +-
>  12 files changed, 330 insertions(+), 51 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 14517e95a46c..67a7e069a9bf 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1707,13 +1707,16 @@ static inline void skb_set_end_offset(struct sk_buff *skb, unsigned int offset)
>  extern const struct ubuf_info_ops msg_zerocopy_ubuf_ops;
>  
>  struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
> -				       struct ubuf_info *uarg);
> +				       struct ubuf_info *uarg, bool devmem);
>  
>  void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref);
>  
> +struct net_devmem_dmabuf_binding;
> +
>  int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>  			    struct sk_buff *skb, struct iov_iter *from,
> -			    size_t length);
> +			    size_t length,
> +			    struct net_devmem_dmabuf_binding *binding);
>  
>  int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>  				struct iov_iter *from, size_t length);
> @@ -1721,12 +1724,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>  static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
>  					  struct msghdr *msg, int len)
>  {
> -	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len);
> +	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len,
> +				       NULL);
>  }
>  
>  int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
>  			     struct msghdr *msg, int len,
> -			     struct ubuf_info *uarg);
> +			     struct ubuf_info *uarg,
> +			     struct net_devmem_dmabuf_binding *binding);
>  
>  /* Internal */
>  #define skb_shinfo(SKB)	((struct skb_shared_info *)(skb_end_pointer(SKB)))
> @@ -3697,6 +3702,10 @@ static inline dma_addr_t __skb_frag_dma_map(struct device *dev,
>  					    size_t offset, size_t size,
>  					    enum dma_data_direction dir)
>  {
> +	if (skb_frag_is_net_iov(frag)) {
> +		return netmem_to_net_iov(frag->netmem)->dma_addr + offset +
> +		       frag->offset;
> +	}
>  	return dma_map_page(dev, skb_frag_page(frag),
>  			    skb_frag_off(frag) + offset, size, dir);
>  }
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8daf1b3b12c6..59875bed75e7 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1816,6 +1816,7 @@ struct sockcm_cookie {
>  	u32 tsflags;
>  	u32 ts_opt_id;
>  	u32 priority;
> +	u32 dmabuf_id;
>  };
>  
>  static inline void sockcm_init(struct sockcm_cookie *sockc,
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index f0693707aece..09c74a1d836b 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -63,6 +63,8 @@
>  #include <net/busy_poll.h>
>  #include <crypto/hash.h>
>  
> +#include "devmem.h"
> +
>  /*
>   *	Is a socket 'connection oriented' ?
>   */
> @@ -692,9 +694,49 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +static int
> +zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
> +			      int length,
> +			      struct net_devmem_dmabuf_binding *binding)
> +{
> +	int i = skb_shinfo(skb)->nr_frags;
> +	size_t virt_addr, size, off;
> +	struct net_iov *niov;
> +
> +	/* Devmem filling works by taking an IOVEC from the user where the
> +	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to
> +	 * send from. We do not support other iter types.
> +	 */
> +	if (iov_iter_type(from) != ITER_IOVEC)
> +		return -EFAULT;
> +
> +	while (length && iov_iter_count(from)) {
> +		if (i == MAX_SKB_FRAGS)
> +			return -EMSGSIZE;
> +
> +		virt_addr = (size_t)iter_iov_addr(from);
> +		niov = net_devmem_get_niov_at(binding, virt_addr, &off, &size);
> +		if (!niov)
> +			return -EFAULT;
> +
> +		size = min_t(size_t, size, length);
> +		size = min_t(size_t, size, iter_iov_len(from));
> +
> +		get_netmem(net_iov_to_netmem(niov));
> +		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
> +				       size, PAGE_SIZE);
> +		iov_iter_advance(from, size);
> +		length -= size;
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
>  int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>  			    struct sk_buff *skb, struct iov_iter *from,
> -			    size_t length)
> +			    size_t length,
> +			    struct net_devmem_dmabuf_binding *binding)
>  {
>  	unsigned long orig_size = skb->truesize;
>  	unsigned long truesize;
> @@ -702,6 +744,8 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>  
>  	if (msg && msg->msg_ubuf && msg->sg_from_iter)
>  		ret = msg->sg_from_iter(skb, from, length);
> +	else if (unlikely(binding))
> +		ret = zerocopy_fill_skb_from_devmem(skb, from, length, binding);
>  	else
>  		ret = zerocopy_fill_skb_from_iter(skb, from, length);
>  
> @@ -735,7 +779,7 @@ int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
>  	if (skb_copy_datagram_from_iter(skb, 0, from, copy))
>  		return -EFAULT;
>  
> -	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U);
> +	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U, NULL);
>  }
>  EXPORT_SYMBOL(zerocopy_sg_from_iter);
>  
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 0cf3d189f06c..393e30d72dc8 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -17,6 +17,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/page_pool/memory_provider.h>
> +#include <net/sock.h>
>  #include <trace/events/page_pool.h>
>  
>  #include "devmem.h"
> @@ -54,8 +55,10 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
>  	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
>  }
>  
> -void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
> +void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
>  {
> +	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
> +
>  	size_t size, avail;
>  
>  	gen_pool_for_each_chunk(binding->chunk_pool,
> @@ -73,8 +76,10 @@ void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
>  	dma_buf_detach(binding->dmabuf, binding->attachment);
>  	dma_buf_put(binding->dmabuf);
>  	xa_destroy(&binding->bound_rxqs);
> +	kvfree(binding->tx_vec);
>  	kfree(binding);
>  }
> +EXPORT_SYMBOL(__net_devmem_dmabuf_binding_free);
>  
>  struct net_iov *
>  net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
> @@ -119,6 +124,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
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
>  	if (binding->list.next)
>  		list_del(&binding->list);
>  

One thing forgot to mention: we should probably do the same for the
allocation path? Move the binding->id allocation to the end of the 
routine to make sure we 'post' fully initialized bindings? Otherwise,
net_devmem_bind_dmabuf migh race with the sendmsg?

