Return-Path: <linux-kselftest+bounces-23717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 185FF9F9E62
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 06:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC93718906D8
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 05:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186981DF246;
	Sat, 21 Dec 2024 05:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrZHPL6N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D310B70818;
	Sat, 21 Dec 2024 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734757785; cv=none; b=qmfVVPfmkIdyKmkcd8zEQPxVHkV7jANY0F63xtHoH4NOMsuUd8H08rNRFmOpB1sZJLuG+CtOVzTnyROKbuUB8VIsy5XP62y6pPH2ygCBruNd2NLz0iLhtJtbIKt7XnJ2+IuHwEfIxhC22mvaIuKJzu4vCFSPY7aMSUwsLp2TS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734757785; c=relaxed/simple;
	bh=Z86DzIft3/3rSp5Wp2TDxcINq88A13Sx0PrBkbMpUBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgGQ7ahC4cKtmgqUH/qT+7hmKQRBcseCJSteNNq2AddcTu0EAaOfNJNpatJ3nkXhCGjUiYHXmKJl78hBbP8lTMTsWzwGkSJsL/b4MuoKkO605eE6W8HNsFFFOT+fWxSB30a03QbiY0vmt6TRy4dgU6vWuJxXwKzftTRUo89mSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrZHPL6N; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso1882687a91.1;
        Fri, 20 Dec 2024 21:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734757782; x=1735362582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rvEt3UE6ou0S7VZmVwUU8HiV7blPtUnDVEKDxcOLD8Y=;
        b=UrZHPL6NhYcPyi7le/JaDF/0dnrcvoqis6aKOIyeO1d85j2mD8Wo/xQ5Zr1rcLeoLK
         zYY/Obq4Lx6M/fmvTi8dIIP+Ahy4GnspuzRHOhU6LTe4x7jKURFG1xvZ2QgNFsN37CPz
         0kUPB0YzEdRyBCWdzv1Nk8juz+mrV1IMqYvZR8GcGH3HcFgLLFurxr7hCzvwc2uiBtOO
         WXCvoMnJJCGuuWr0OoUrlqa8PaNcF0S3ubaAX3pwUV6fXCq7xslgQmgrmSlaXWIDVX8W
         OmaIRVejWZDFjCvSUpq0GMH2jmP2Ce4iACPVRgp6xAwqXgliYy8HEgCt8VDdmhJP+/rx
         mJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734757782; x=1735362582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvEt3UE6ou0S7VZmVwUU8HiV7blPtUnDVEKDxcOLD8Y=;
        b=NQGHncUuwKaoDKpsNyHG5yFLZjpSecddrsWM8A41rSW9JQgZHn1eU5Rzbv55/jdKkf
         sZkR6TbLw9XrrYaY39bc7qfCV26XRxxWUjUH+5V4V1/6z/lFE2HlARfs6iB4/RQqEnrY
         YR/4OFw2oW8xNmL9NvgRvq4xgbfmtAbQsK+S6YL6vkXvNdejqb/xx5Gs9OXIEN95V4f0
         A9Z4MhXwNmtsjjpWCAMmzxI2IjWRdnzBduH5546gJsyql803Y/uITNWZu+Y4KqrgYkzN
         Vr9QhjJJG8l6pBr15kvUKlpSNdaBVn95824lWOkl5euS9jYApCqiKUM5/k+0WIVl0Ctt
         ChEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1U9KnBCusu4ZHDAMvsTWir8P6Ijf6KoMhQgr9wRHcQJj8bm64VBFC/TZsxcYsZ0R1Dcwd+za/aGId@vger.kernel.org, AJvYcCVAzbGJFyuUIDRDcfMmXGXhOesRIV7p+DMg/BkRdsDUdQkVRH1jGkVOfVZ9r0F6nIqkzsKebJ0vvsgiPHhqSoRL@vger.kernel.org, AJvYcCVqCCcS12/CYq/ZvAWXCa2vMalo86ZFOWjOS67pPAcq2NjPEQJjN0Ng0qo0SkmRxXwKA68=@vger.kernel.org, AJvYcCXmXulpqWL/KRAjbiW49Sdz7iBBnqKiGZS/cTC7Ox0zxE8dK8RttoaCEekYgqJsWjARFFdwk58y5+/DQXeO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9zhPunh9z/hS02RwPgFRicWGLY9PjfdI+VfDnRgPXLyViAVTo
	T8/IISxERXTJI+zr0ooytC9ECFxrgIOiSwAarfqzdvh1OxSf9aI=
X-Gm-Gg: ASbGncuAq/2O+EGDNjiMhrPvcQNJDQvA1i2kKdM1tCyKERU8htF77OKg3A0D4wRdx/Y
	qOsrkURpq3SZKIUlktGT/8SIScw4XwvEWhTkLlGRue7OcbebavWto62arhWPkxXSBozj2rO/DTe
	+3r9PSG69DPtxMFxR1KYz2UB7sYTUClhYDGH5UdEskKiNkfVAd0CzsG/wHagCxIijRuDRDV/a0P
	thnvdgeX2lJLyv+1nrf5DCjrxj8bkiz1AoDiGPBO3Hd6Xlr21heY8Cd
X-Google-Smtp-Source: AGHT+IHR4v8fIh0lotqItBAmv4tODyxHMuNahE16i7ziZrTX0L+kSGddNqr6hpDSKLkE7b4Ybc+mEQ==
X-Received: by 2002:a17:90a:d645:b0:2ef:30ec:14c9 with SMTP id 98e67ed59e1d1-2f452e4ad37mr7682298a91.18.1734757781913;
        Fri, 20 Dec 2024 21:09:41 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9705d7sm37267185ad.102.2024.12.20.21.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 21:09:41 -0800 (PST)
Date: Fri, 20 Dec 2024 21:09:40 -0800
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
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Subject: Re: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
Message-ID: <Z2ZNlGCbQXMondI7@mini-arch>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241221004236.2629280-6-almasrymina@google.com>

On 12/21, Mina Almasry wrote:
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
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..e90dc0c4d542 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1711,9 +1711,10 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
>  
>  void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref);
>  
> +struct net_devmem_dmabuf_binding;
>  int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>  			    struct sk_buff *skb, struct iov_iter *from,
> -			    size_t length);
> +			    size_t length, bool is_devmem);
>  
>  int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>  				struct iov_iter *from, size_t length);
> @@ -1721,12 +1722,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>  static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
>  					  struct msghdr *msg, int len)
>  {
> -	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len);
> +	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len,
> +				       false);
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
> @@ -3697,6 +3700,10 @@ static inline dma_addr_t __skb_frag_dma_map(struct device *dev,
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
> index d4bdd3286e03..75bd580fe9c6 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1816,6 +1816,8 @@ struct sockcm_cookie {
>  	u32 tsflags;
>  	u32 ts_opt_id;
>  	u32 priority;
> +	u32 dmabuf_id;
> +	u64 dmabuf_offset;
>  };
>  
>  static inline void sockcm_init(struct sockcm_cookie *sockc,
> diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
> index 649739e0c404..41490cde95ad 100644
> --- a/include/uapi/linux/uio.h
> +++ b/include/uapi/linux/uio.h
> @@ -38,6 +38,11 @@ struct dmabuf_token {
>  	__u32 token_count;
>  };
>  
> +struct dmabuf_tx_cmsg {
> +	__u32 dmabuf_id;
> +	__u64 dmabuf_offset;
> +};
> +
>  /*
>   *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
>   */
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index f0693707aece..3b09995db894 100644
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
> @@ -692,9 +694,41 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>  	return 0;
>  }
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
>  
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f7e06a8cba01..81f1b715cfa6 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -15,6 +15,7 @@
>  #include <net/netdev_queues.h>
>  #include <net/netdev_rx_queue.h>
>  #include <net/page_pool/helpers.h>
> +#include <net/sock.h>
>  #include <trace/events/page_pool.h>
>  
>  #include "devmem.h"
> @@ -63,8 +64,10 @@ void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
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
>  int mp_dmabuf_devmem_init(struct page_pool *pool)
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 54e30fea80b3..f923c77d9c45 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -11,6 +11,8 @@
>  #define _NET_DEVMEM_H
>  
>  struct netlink_ext_ack;
> +struct sockcm_cookie;
> +struct sock;
>  
>  struct net_devmem_dmabuf_binding {
>  	struct dma_buf *dmabuf;
> @@ -27,6 +29,10 @@ struct net_devmem_dmabuf_binding {
>  	 * The binding undos itself and unmaps the underlying dmabuf once all
>  	 * those refs are dropped and the binding is no longer desired or in
>  	 * use.
> +	 *
> +	 * net_devmem_get_net_iov() on dmabuf net_iovs will increment this
> +	 * reference, making sure that that the binding remains alive until all
> +	 * the net_iovs are no longer used.
>  	 */
>  	refcount_t ref;
>  
> @@ -42,6 +48,10 @@ struct net_devmem_dmabuf_binding {
>  	 * active.
>  	 */
>  	u32 id;
> +
> +	/* iov_iter representing all possible net_iov chunks in the dmabuf. */
> +	struct iov_iter tx_iter;
> +	struct iovec *tx_vec;
>  };
>  
>  #if defined(CONFIG_NET_DEVMEM)
> @@ -66,8 +76,10 @@ struct dmabuf_genpool_chunk_owner {
>  
>  void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
>  struct net_devmem_dmabuf_binding *
> -net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> -		       struct netlink_ext_ack *extack);
> +net_devmem_bind_dmabuf(struct net_device *dev,
> +		       enum dma_data_direction direction,
> +		       unsigned int dmabuf_fd, struct netlink_ext_ack *extack);
> +struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
>  int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
>  				    struct net_devmem_dmabuf_binding *binding,
> @@ -104,10 +116,10 @@ static inline u32 net_iov_binding_id(const struct net_iov *niov)
>  	return net_iov_owner(niov)->binding->id;
>  }
>  
> -static inline void
> +static inline bool
>  net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
>  {
> -	refcount_inc(&binding->ref);
> +	return refcount_inc_not_zero(&binding->ref);
>  }
>  
>  static inline void
> @@ -126,6 +138,9 @@ struct net_iov *
>  net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
>  void net_devmem_free_dmabuf(struct net_iov *ppiov);
>  
> +struct net_devmem_dmabuf_binding *
> +net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc);
> +
>  #else
>  struct net_devmem_dmabuf_binding;
>  
> @@ -144,11 +159,17 @@ __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
>  
>  static inline struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> +		       enum dma_data_direction direction,
>  		       struct netlink_ext_ack *extack)
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
>  
> +static inline struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
> +{
> +	return NULL;
> +}
> +
>  static inline void
>  net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  {
> @@ -186,6 +207,17 @@ static inline u32 net_iov_binding_id(const struct net_iov *niov)
>  {
>  	return 0;
>  }
> +
> +static inline void
> +net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
> +{
> +}
> +
> +static inline struct net_devmem_dmabuf_binding *
> +net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
>  #endif
>  
>  #endif /* _NET_DEVMEM_H */
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 00d3d5851487..b9928bac94da 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -850,7 +850,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto err_unlock;
>  	}
>  
> -	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, info->extack);
> +	binding = net_devmem_bind_dmabuf(netdev, DMA_FROM_DEVICE, dmabuf_fd,
> +					 info->extack);
>  	if (IS_ERR(binding)) {
>  		err = PTR_ERR(binding);
>  		goto err_unlock;
> @@ -907,10 +908,68 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  	return err;
>  }
>  
> -/* stub */
>  int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return 0;
> +	struct net_devmem_dmabuf_binding *binding;
> +	struct list_head *sock_binding_list;
> +	struct net_device *netdev;
> +	u32 ifindex, dmabuf_fd;
> +	struct sk_buff *rsp;
> +	int err = 0;
> +	void *hdr;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_FD))
> +		return -EINVAL;
> +
> +	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
> +	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
> +
> +	sock_binding_list =
> +		genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
> +	if (IS_ERR(sock_binding_list))
> +		return PTR_ERR(sock_binding_list);
> +
> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!rsp)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr) {
> +		err = -EMSGSIZE;
> +		goto err_genlmsg_free;
> +	}
> +
> +	rtnl_lock();
> +
> +	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> +	if (!netdev || !netif_device_present(netdev)) {
> +		err = -ENODEV;
> +		goto err_unlock;
> +	}
> +
> +	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
> +					 info->extack);
> +	if (IS_ERR(binding)) {
> +		err = PTR_ERR(binding);
> +		goto err_unlock;
> +	}
> +
> +	list_add(&binding->list, sock_binding_list);
> +
> +	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
> +	genlmsg_end(rsp, hdr);
> +
> +	rtnl_unlock();
> +
> +	return genlmsg_reply(rsp, info);
> +
> +	net_devmem_unbind_dmabuf(binding);
> +err_unlock:
> +	rtnl_unlock();
> +err_genlmsg_free:
> +	nlmsg_free(rsp);
> +	return err;
>  }
>  
>  void netdev_nl_sock_priv_init(struct list_head *priv)
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 815245d5c36b..eb6b41a32524 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1882,8 +1882,10 @@ EXPORT_SYMBOL_GPL(msg_zerocopy_ubuf_ops);
>  
>  int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
>  			     struct msghdr *msg, int len,
> -			     struct ubuf_info *uarg)
> +			     struct ubuf_info *uarg,
> +			     struct net_devmem_dmabuf_binding *binding)
>  {
> +	struct iov_iter *from = binding ? &binding->tx_iter : &msg->msg_iter;

For tx, I feel like this needs a copy of binding->tx_iter:

	struct iov_iter tx_iter = binding->tx_iter;
	struct iov_iter *from = binding ? &tx_iter : &msg->msg_iter;

Or something similar (rewind?). The tx_iter is advanced in
zerocopy_fill_skb_from_devmem but never reset back it seems (or I'm
missing something). In you case, if you call sendmsg twice with the same
offset, the second one will copy from 2*offset.

But I'd vote to move away from iov_iter on the tx side. From my initial
testing, the perf wasn't great. It's basically O(n_chunks) on every
message (iov_iter_advance does linear walk over the chunks). So when we call
several sendmsg() with 4k chunks and increasing offset,
this blows up to O(n_chunks^2). I tried to "fix" it by caching previous iter
position so the next sendmsg can continue without rewinding, but it was
a bit messy.

I have this simplified constant time version in [1], pls take a look
and lmk what you think (zerocopy_fill_skb_from_devmem and
net_devmem_get_niov_at). It is significantly faster and much simpler.

1: https://github.com/fomichev/linux/commit/3b3ad4f36771a376c204727e5a167c4993d4c65a#diff-a3bb611c084dada9bcd3ef6c5f9a17f6c5d58eb8e168aa9b07241841e96f6b94R710

