Return-Path: <linux-kselftest+bounces-25454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F619A237A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 00:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D3D18861CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 23:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A961F1311;
	Thu, 30 Jan 2025 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn3LSvLv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98EF19DF99;
	Thu, 30 Jan 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738278468; cv=none; b=c+Owu4PTCCDQh2Al+DWwS8bIbKLqxUDfpxyQh/L1wK7nL3rWjwhqYWHebL0M/5wr5ErxZuAHMVwcQfTxNMyu3dHWNXyGJkwJinpzmxMfQWFIPVayPxQCpGz2wz116P6um/V9JuFNqZpRhNPEaWvp5aEDvOA6xJ3obGPk2JDUzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738278468; c=relaxed/simple;
	bh=zznR7FPGDV4d61fO+YkXDRR3sLL7kPHFNlkpZDxvurI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS5UOxy9pNJ8oyeBDEqc+a1yqBOwQWKGIT6hljJAewBkTohjydYk+VUhJhC0VBzwLcsAMApNb6u/28ivwngKQCh/0MKlFHhBTtZQStVLKE0MfrcbQn/Kf9fr75OMQiCQFquCqfQ6IlD3f5lMLV5tH4ulHXiZlxus2oKzs1J0CI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mn3LSvLv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21bc1512a63so25983945ad.1;
        Thu, 30 Jan 2025 15:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738278466; x=1738883266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLH0EDTrIwblWaDZPjgeOUgI3kzlzdm+VAPxTCShJC0=;
        b=mn3LSvLvZaH3gbdoSJj5DE4wHxgva6jJHvjzMfVUrhx7CxEw0YWBcM+LWeaojnnOUX
         czmO65yt+RpW4R2miL/dRgSu341p2hfu2GtlyaruuDje/lUHwweA2N/MUYUnteiG/Kj5
         RAy2mldU1CD7UXrI5Z2f/KCmruYxsqgBS0P69t9pjENYrHgY1eQygRC1JS4W00Yz3QI4
         3QsbZLm4WVXF4Q9z25clMLBtCp1/bu595Cr2Mfu56MDYGfoj5OQ5XbSsIJdSli8K5DCj
         oEXkpOa7CZwctEg/HacwNTdSoprWMk/c2wK9W+yJF4zff25HTSqlxNK7ez15t819xC+s
         ooSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738278466; x=1738883266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLH0EDTrIwblWaDZPjgeOUgI3kzlzdm+VAPxTCShJC0=;
        b=SihW6R+oprm9uKK9xcqD33fYJE6GwShOKy07fTj5Dm9yU33XkSqmSDH1rNGNwraI94
         ZkpNbSQsGzy46+n2IJia9C7YGn9tFfOD4PnZ2QhY93B8qTp8Nx8sOZBemknnD+QGJHx6
         vTsyGSnSr/6bzf+Bt/S/IcO6tKhK/aYTCkTUQq3KFLlDw5pVzlOWGQ7m7Opy2eaiElrE
         2S4eK4fTCoMeHmMBZXo3BORagwI2oiICtKyq2gbpAH2MJzyrc3ZOCaA5UZzWupDsHkT/
         K8BH0/rfxTlq4HeRI2X1HltYiUZThtM9m+guCUXnZDheQ7K2E1+fiNUkDsOSxZu6oQi1
         VkpA==
X-Forwarded-Encrypted: i=1; AJvYcCU+xLgliWljG7ZTV1PwAnvaasjtv1HwvN6HAa2fB/Ulico1NtHXlCcO+CpmVRzI/KrU/j9r1EuLCSog@vger.kernel.org, AJvYcCVTnFNP92CHyfJIkVCFz4jqWUNl7k1ZBi/DhhVOqy8ZBUAp5SY4R3Athn2oJrTIVMb04weNhbTZuVMQ8EgI@vger.kernel.org, AJvYcCVqWfXvZcR++2pNw1dfYByvJfIHA0FBpaYBrBEIPDG8O40CGXvVpSy6AtKRtqBtnJa1CV4=@vger.kernel.org, AJvYcCVx53aOfGlFItcmO3diETllnUgmsUlFeiDZdJjJh08r0Axl/glcq9yRzblrAt6MaGpXyOPnPZ6xGLECFlHs4ABt@vger.kernel.org
X-Gm-Message-State: AOJu0YzrTUCLv0am3lOUBZp/yrq+zSrHvn3wMHq/TYaZVqUOB8iECzFW
	VZC6Q2bRYU4micqM1FfvpFbzXPK8H8zUGExwgd3oDmDB/yO77OA=
X-Gm-Gg: ASbGncslOiM+r4a7ieDlsGIb7tmc9QEDQc8w4dwcn8yGrEniYCvByz9uHYzTU+8+ROn
	Az4QtF5xDXNM58jC8tF0B3A+qXjDo/6SBx80+S+9e8Beu1S2BGquVUJk6SfFCRpxtP7mZOXlgRW
	+zDmkX1RKFksVViUcf+xn2zmI7QJtq2JGjcSjyElk0V/jtgK5MlqLy/qUF0V7EdrNS9he7zxagm
	cus9TA2wpYts3rgDN393AAbnSNOQRLuYhT0oRK1qjH7g/qvePcAKuRnazhDEGHr1vshwjvenGZX
	sFrwH7+uXXiMxBQ=
X-Google-Smtp-Source: AGHT+IH2XTHYe58NDulFcNjmK8MdJ7Y9FXxenn+aLkLYrAJGqiSJ+bj4gLpE5mL6zi67UYuq9FOdxA==
X-Received: by 2002:a05:6a21:6da4:b0:1e0:cf39:846a with SMTP id adf61e73a8af0-1ed7a5ee741mr14589795637.29.1738278465958;
        Thu, 30 Jan 2025 15:07:45 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe631bfe7sm2022991b3a.33.2025.01.30.15.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 15:07:45 -0800 (PST)
Date: Thu, 30 Jan 2025 15:07:44 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
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
	Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH RFC net-next v2 5/6] net: devmem: Implement TX path
Message-ID: <Z5wGQCZUwiiovJHk@mini-arch>
References: <20250130211539.428952-1-almasrymina@google.com>
 <20250130211539.428952-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130211539.428952-6-almasrymina@google.com>

On 01/30, Mina Almasry wrote:
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
> 
> ---
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
>  include/linux/skbuff.h                  | 15 +++-
>  include/net/sock.h                      |  1 +
>  include/uapi/linux/uio.h                |  6 +-
>  net/core/datagram.c                     | 41 ++++++++++-
>  net/core/devmem.c                       | 96 +++++++++++++++++++++++--
>  net/core/devmem.h                       | 42 +++++++++--
>  net/core/netdev-genl.c                  | 65 ++++++++++++++++-
>  net/core/skbuff.c                       |  6 +-
>  net/core/sock.c                         |  8 +++
>  net/ipv4/tcp.c                          | 36 +++++++---
>  net/vmw_vsock/virtio_transport_common.c |  3 +-
>  11 files changed, 285 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..3ff8f568c382 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1711,9 +1711,12 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
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
> index 8036b3b79cd8..09eb918525b6 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1822,6 +1822,7 @@ struct sockcm_cookie {
>  	u32 tsflags;
>  	u32 ts_opt_id;
>  	u32 priority;
> +	u32 dmabuf_id;
>  };
>  
>  static inline void sockcm_init(struct sockcm_cookie *sockc,
> diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
> index 649739e0c404..866bd5dfe39f 100644
> --- a/include/uapi/linux/uio.h
> +++ b/include/uapi/linux/uio.h
> @@ -38,10 +38,14 @@ struct dmabuf_token {
>  	__u32 token_count;
>  };
>  
> +struct dmabuf_tx_cmsg {
> +	__u32 dmabuf_id;
> +};
> +
>  /*
>   *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
>   */
> - 
> +
>  #define UIO_FASTIOV	8
>  #define UIO_MAXIOV	1024
>  
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index f0693707aece..c989606ff58d 100644
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
> @@ -692,9 +694,42 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
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
> @@ -702,6 +737,8 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>  
>  	if (msg && msg->msg_ubuf && msg->sg_from_iter)
>  		ret = msg->sg_from_iter(skb, from, length);
> +	else if (unlikely(binding))
> +		ret = zerocopy_fill_skb_from_devmem(skb, from, length, binding);
>  	else
>  		ret = zerocopy_fill_skb_from_iter(skb, from, length);
>  
> @@ -735,7 +772,7 @@ int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
>  	if (skb_copy_datagram_from_iter(skb, 0, from, copy))
>  		return -EFAULT;
>  
> -	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U);
> +	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U, NULL);
>  }
>  EXPORT_SYMBOL(zerocopy_sg_from_iter);
>  
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 20985a570662..796338b1599e 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -16,6 +16,7 @@
>  #include <net/netdev_queues.h>
>  #include <net/netdev_rx_queue.h>
>  #include <net/page_pool/helpers.h>
> +#include <net/sock.h>
>  #include <trace/events/page_pool.h>
>  
>  #include "devmem.h"
> @@ -64,8 +65,10 @@ void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
>  	dma_buf_detach(binding->dmabuf, binding->attachment);
>  	dma_buf_put(binding->dmabuf);
>  	xa_destroy(&binding->bound_rxqs);
> +	kfree(binding->tx_vec);
>  	kfree(binding);
>  }
> +EXPORT_SYMBOL(__net_devmem_dmabuf_binding_free);
>  
>  struct net_iov *
>  net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
> @@ -110,6 +113,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
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
> @@ -123,8 +133,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
>  	}
>  
> -	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> -
>  	net_devmem_dmabuf_binding_put(binding);
>  }
>  
> @@ -185,8 +193,9 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
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
> @@ -229,7 +238,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>  	}
>  
>  	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
> -						       DMA_FROM_DEVICE);
> +						       direction);
>  	if (IS_ERR(binding->sgt)) {
>  		err = PTR_ERR(binding->sgt);
>  		NL_SET_ERR_MSG(extack, "Failed to map dmabuf attachment");
> @@ -240,13 +249,22 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
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
> +		binding->tx_vec = kcalloc(dmabuf->size / PAGE_SIZE,
> +					  sizeof(struct net_iov *), GFP_KERNEL);

Let's make this kvcalloc (and kvfree in the release path)? Otherwise
we'll get ENOMEM here for a reasonably sized dmabufs..

The rest looks good, I'll try to run it on my side today/tomorrow..

