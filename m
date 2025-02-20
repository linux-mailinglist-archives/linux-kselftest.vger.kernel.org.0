Return-Path: <linux-kselftest+bounces-27113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A66EA3E63A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 22:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87EA27A87A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 20:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A4B1EB9FA;
	Thu, 20 Feb 2025 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwuPZOJ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5022087;
	Thu, 20 Feb 2025 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085231; cv=none; b=HA5NOCzDzKp8+RlpbEUGBFhvK0N7VFCFS9/CX2nAkWigzEn3gWqa0CXqKah4mFGL548lhPwN53fsr+Ytc5mWGw+JhU11BJ3+bVOzhP0Co3xPNwFFpJmHuFcWKWn/hz5YKmESBqcrBTJDhrxmKkmMKPba7DPJy1J1OtA7c+h1vsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085231; c=relaxed/simple;
	bh=wjKQPQ8w1mhfkx3/7oMVDnQGTMOD5B2byO68pcXjvio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVMRsTQg37jmHFf8ex+bjca+xhKad5fY/d9YY4s+g7sKbGKFgUhDYBDXdiKCbBUt9bbvprYchy5eUIs5A1pxfwCHxayWVXdRRAR7vLDZFFzWwyLOMNUP918H0Vzof2Pe34EUW2WWZMsCiG7uvL73q/vuaAL2GvHzsIj0AnMoOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwuPZOJ/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso2888858a91.2;
        Thu, 20 Feb 2025 13:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740085229; x=1740690029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ocAZMQJdnmPkwi++slUrJsYlfsHZyAYOpg1sHJK7ARg=;
        b=XwuPZOJ/eXtj2iL/KNjdyVodsG9gpU0FO15IvD0BGveshInsjP6zjUYbBnVnVdNDkV
         tqIYUY0iHFdBlumd186LfIO1J09hvJJE2B6O+DyuA5LaieIrJdH32fSf7yFMAItrOKGJ
         3ibUzMjFPzEBp2IH7ypuXKlTHqYU1r4QNHO8wEAGtr2+EAHX0tMaSpKm0NRXwm2I8rzh
         HOe9n8o5HZqztGJzYhPv+5r07dgemuCR6YBusT+LMXqIn70RZ1tD4JGB/RiLVt6QD/Ju
         0PBInW0yLUc/pNoMWJfmwDk21QTR+Xdnq5UcrR0u0diGl9gcoA30YgbgSnKmsTAdFosJ
         lZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740085229; x=1740690029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocAZMQJdnmPkwi++slUrJsYlfsHZyAYOpg1sHJK7ARg=;
        b=PbzcGUu84WksgXMMwVW1h+8eFwh3iFKAbZ649Uv7EfXRblMFhRkBC6ZBMb18R9d9ms
         bz3/tcxzpeiAr8W+K+7k9gQ10T8bwfagrLn5lbWLUSQTuN3PTZyUM2czgXsEIf6XKasX
         +BuNQyObwxkxfSiPVx4vasHjD/NffxRsE1YSFJwMzpxCNT0gXRQz/YxmwVg3UurdOv6S
         gAZENoRMzG10pJtKaWERhfamyoVx0PrHiG+iR80my4ZckRU6Pm2w/vczzOwXDGnX/cmd
         Q/p6xetYQu1aRgPenE1xhTXpU6frU4t6q6Mw1THkn5PZuX8O8tJHjt+D0IQDiv24HWWg
         4viw==
X-Forwarded-Encrypted: i=1; AJvYcCVAafO5HQRTtmH7+Iuq3zYlKLDtbnQNeYDYxwBZhV0R+wZWlvyovzKKsRfyIX73nqlz0vlzkRTCxCBZgvIu@vger.kernel.org, AJvYcCVcc4OnI/FNs6LkpHyvQXJfzXu4O7Yt41ADuIM+HPZC1xqk4VGxc3yXY7rrD7lgrtjTCIXyuvZCsi93RZMepP/D@vger.kernel.org, AJvYcCW13MvTdsfuoW6OyL5PU3H84cruLskDn4xekm1sV5y4tJLdJrfiVhFKnA5HgyI7PNlV/8g=@vger.kernel.org, AJvYcCWOfytg6Qmup/80oEcDsdBgBEQZy5K7Q+V24T0aPXzadGr9onFpvIY/BNy4lYyNxEwXVbiA1VKh/eDi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80Vi5K1iLJu4FEvp9DXK+hfOyPy1P4I8NXp2Kr9WTJOuch0sK
	pYP+egVHR4qDkTmHce+cZHjasVOXcjZvwZ9HG4JROnzByf7ZAoo=
X-Gm-Gg: ASbGncvXwSuFRbgg7SClnsMwM+PtrgyTeEHTAGVoj1uqZ0x41++/gUgFPi8Lwx4Chsu
	kiynt2fDFotem7hmyzje/HLkLE2zINqpuyI2jJtg3iBc28dOl/679OK9ccofrUMbi8fRwuz+Ann
	ytDO4WiT6Psok5mBUy+HcpyZuCVsh33wcmPVNBfOo9Nm7EF0h0//4lVBq3XRJsHidGLtRX0rnTc
	cvkeQC3C1edXdzFtAkUHbJUh6ohdqNnQZi+wce1ir8iucedQd5ICs5ZZjB9sA5BJC+QADHXj1ky
	GyTZu8G6fFRKr8w=
X-Google-Smtp-Source: AGHT+IFtOMuMQhxcIAllXScRB6FKHAtOBoya+bQ7QQWvGb6kPdplhyv4FFHw5xoxXDq9Yn1+KHBWWg==
X-Received: by 2002:a17:90b:3d0e:b0:2ee:f687:6acb with SMTP id 98e67ed59e1d1-2fce78a584dmr1036201a91.13.1740085229080;
        Thu, 20 Feb 2025 13:00:29 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fc13ad35absm14225674a91.25.2025.02.20.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:00:28 -0800 (PST)
Date: Thu, 20 Feb 2025 13:00:27 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v4 3/9] net: devmem: Implement TX path
Message-ID: <Z7eX6yaRsGqmSzy7@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-4-almasrymina@google.com>

On 02/20, Mina Almasry wrote:
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
> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
> of the implementation came from devmem TCP RFC v1[1], which included the
> TX path, but Stan did all the rebasing on top of netmem/net_iov.
> 
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
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
> 
> ---
>  include/linux/skbuff.h                  |  17 +++-
>  include/net/sock.h                      |   1 +
>  net/core/datagram.c                     |  48 +++++++++++-
>  net/core/devmem.c                       | 100 ++++++++++++++++++++++--
>  net/core/devmem.h                       |  41 +++++++++-
>  net/core/netdev-genl.c                  |  64 ++++++++++++++-
>  net/core/skbuff.c                       |  18 +++--
>  net/core/sock.c                         |   6 ++
>  net/ipv4/ip_output.c                    |   3 +-
>  net/ipv4/tcp.c                          |  46 ++++++++---
>  net/ipv6/ip6_output.c                   |   3 +-
>  net/vmw_vsock/virtio_transport_common.c |   5 +-
>  12 files changed, 309 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..b8783aa94c1e 100644
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
> index fac65ed30983..aac7e9d92ba5 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1823,6 +1823,7 @@ struct sockcm_cookie {
>  	u32 tsflags;
>  	u32 ts_opt_id;
>  	u32 priority;
> +	u32 dmabuf_id;
>  };
>  
>  static inline void sockcm_init(struct sockcm_cookie *sockc,
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index f0693707aece..3e60c83305cc 100644
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
> +		return -EINVAL;

It seems like the caller (skb_zerocopy_iter_stream) needs to special case
EINVAL. Right now it only expects EFAULT or EMSGSIZE (and backtracks). The
rest of errors are ignored and it reports the number of bytes copied
(which will be zero in your case, but still not what we want).

Or maybe this check needs to happen earlier? In tcp_sendmsg_locked?

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
> index b1aafc66ebb7..2e576f80b1d8 100644
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
> @@ -73,8 +74,10 @@ void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
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
> @@ -119,6 +122,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
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
> @@ -133,8 +143,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
>  	}
>  
> -	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> -
>  	net_devmem_dmabuf_binding_put(binding);
>  }
>  
> @@ -197,8 +205,9 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
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
> @@ -241,7 +250,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  	}
>  
>  	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
> -						       DMA_FROM_DEVICE);
> +						       direction);
>  	if (IS_ERR(binding->sgt)) {
>  		err = PTR_ERR(binding->sgt);
>  		NL_SET_ERR_MSG(extack, "Failed to map dmabuf attachment");
> @@ -252,13 +261,23 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  	 * binding can be much more flexible than that. We may be able to
>  	 * allocate MTU sized chunks here. Leave that for future work...
>  	 */
> -	binding->chunk_pool =
> -		gen_pool_create(PAGE_SHIFT, dev_to_node(&dev->dev));
> +	binding->chunk_pool = gen_pool_create(PAGE_SHIFT,
> +					      dev_to_node(&dev->dev));
>  	if (!binding->chunk_pool) {
>  		err = -ENOMEM;
>  		goto err_unmap;
>  	}
>  
> +	if (direction == DMA_TO_DEVICE) {
> +		binding->tx_vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
> +						 sizeof(struct net_iov *),
> +						 GFP_KERNEL);
> +		if (!binding->tx_vec) {
> +			err = -ENOMEM;
> +			goto err_free_chunks;
> +		}
> +	}
> +
>  	virtual = 0;
>  	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
>  		dma_addr_t dma_addr = sg_dma_address(sg);
> @@ -300,6 +319,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  			niov->owner = &owner->area;
>  			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
>  						      net_devmem_get_dma_addr(niov));
> +			if (direction == DMA_TO_DEVICE)
> +				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
>  		}
>  
>  		virtual += len;
> @@ -311,6 +332,9 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  	gen_pool_for_each_chunk(binding->chunk_pool,
>  				net_devmem_dmabuf_free_chunk_owner, NULL);
>  	gen_pool_destroy(binding->chunk_pool);
> +
> +	if (direction == DMA_TO_DEVICE)
> +		kvfree(binding->tx_vec);

nit: we might unconditionally kvfree() here? worst case we do
kvfree(NULL)

