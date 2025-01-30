Return-Path: <linux-kselftest+bounces-25447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB84A23680
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 22:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DB13A3B96
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 21:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED41F3D51;
	Thu, 30 Jan 2025 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5FkZp9q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1BF1F2C56
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271753; cv=none; b=hfX1S0veVLNFr6c+l5Z1e5/tifClN/7jReiXWuK8Og/eQG1r4A5ASjlINT1TINzNorMIP9uxxeamRt9PP3YSodxTYAtkbLT3lQDvY+Uaj5EXA3tvFCQpPweIBapb5EXVmwSzPclgF8nS5mHerev3SoHf7YURvKbLQXt+yEGz/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271753; c=relaxed/simple;
	bh=/uknsmzOoUo2AdnBk1rVUhiIg4unhsT5mhFtuI1Eqi8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QUkkA9znJ4glnJF8LvZLy7ywXfyh6yDNxOP66Ay1OvkM1lQz8aY1hfng/4uRtVnn31WUE9/TNszB2AvgbIbc8sua3m2h5J85Kni0yye5aEc5BI50SAuj7mvaOSt3zDdI1GoCk7eQrKxIFjPX/ZkU8jhH40I5E634y4BOhkuU0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h5FkZp9q; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2161d5b3eb5so23924205ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 13:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738271750; x=1738876550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDk3QDS0XhOw3yXbWbE/Vg50WGFMxpH0ic4EdkM2RAQ=;
        b=h5FkZp9qySq8YHhtrR3Au+9wJLyfoSFjg6o+cloJV21DQTwxAG9S9jPrudgfKnwuTk
         N05arV8xtCBOuyfC/Z+BWIsz70jxbIexCc1z8Ne53K1/VecZL5x1+DT7S5HMJUJhdLuC
         ZbkDvV9vc71J9tpbOShPKKgEy+CTCfFwjutxWKocop4mH3814tq0OfJiAc6Iibg+GQ0A
         ZcHHbUWyfARVZ8iKGujmbogeQYgBgbmLFQUadOUQOEwAqrnT9BFNHLUHhW/QrYpX9rJD
         dhDiwhxPkHXV6V9/hpA+CNer3kmLjbm7tihrsN/cCr2twmvMoBy3yk8wd0MGUxBqIP8P
         laQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738271750; x=1738876550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDk3QDS0XhOw3yXbWbE/Vg50WGFMxpH0ic4EdkM2RAQ=;
        b=VLn310IsDeCBVPNUb0ZAIIFkw52otA/CtAXcfkpWFdE3JBRQYNSL4dSYK2b5nNCuZ/
         w+6eA1iib3qN9qmk8QLSaDpGsSZvxnLOeED7aIeBbIg98OtO/j2Rgi3+xKJSP8alkB68
         DhXJo2OXRgW3/8svj1hRWHzjuCVvHhAN29DrnZIu6a0RmKfoZjzwSu25wHKXdlrqU/Qi
         u35xsjUjqLlJ/3UitJ1/zDP6rA+YYlqyxPV8GmHwx4GbRLSxgl86Yd0jSspDCk974+/W
         zeSuY61HJxInhuG1VpItdPB0DIb//mNsLp1ewmTVTEHGgMI7Pwh9ruLWLsZfXfKjHoOi
         L0oA==
X-Forwarded-Encrypted: i=1; AJvYcCWXjHHxTtTaYBoZtCZmYB2MihRKUM0tEcxDPs7hjl6P1Ce+WfyfZToMfJ9da2wuGKqPQibeoYqqNVwubxg8xPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9EXjq6k5EE21G9o5RmLpPD89nwVt8C/6dgOsta72GSqGMCSc
	nowjm1QFb8psznqTNHLdhti5IYb+CQTwj31vfPxbpFkjnF236wVt3o23+CHp1205XPrSHLTSxQm
	5utzkFWS7a1bwaIzr4BYiHw==
X-Google-Smtp-Source: AGHT+IHcaz6CmOrsYbzsvMJeE/blq+/BkvNmzMyDJWRKsl8YFQuxYBw7Zu7NR1mzLDYYc6WsnZx0PxjaPPLL1jiawQ==
X-Received: from plbkp5.prod.google.com ([2002:a17:903:2805:b0:216:2c51:475d])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e84b:b0:215:b087:5d62 with SMTP id d9443c01a7336-21dd7deec73mr138184945ad.36.1738271750486;
 Thu, 30 Jan 2025 13:15:50 -0800 (PST)
Date: Thu, 30 Jan 2025 21:15:38 +0000
In-Reply-To: <20250130211539.428952-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250130211539.428952-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130211539.428952-6-almasrymina@google.com>
Subject: [PATCH RFC net-next v2 5/6] net: devmem: Implement TX path
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

Augment dmabuf binding to be able to handle TX. Additional to all the RX
binding, we also create tx_vec needed for the TX path.

Provide API for sendmsg to be able to send dmabufs bound to this device:

- Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
- MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.

Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
implementation, while disabling instances where MSG_ZEROCOPY falls back
to copying.

We additionally pipe the binding down to the new
zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmems
instead of the traditional page netmems.

We also special case skb_frag_dma_map to return the dma-address of these
dmabuf net_iovs instead of attempting to map pages.

Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
of the implementation came from devmem TCP RFC v1[1], which included the
TX path, but Stan did all the rebasing on top of netmem/net_iov.

Cc: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>


---

v2:
- Remove dmabuf_offset from the dmabuf cmsg.
- Update zerocopy_fill_skb_from_devmem to interpret the
  iov_base/iter_iov_addr as the offset into the dmabuf to send from
  (Stan).
- Remove the confusing binding->tx_iter which is not needed if we
  interpret the iov_base/iter_iov_addr as offset into the dmabuf (Stan).
- Remove check for binding->sgt and binding->sgt->nents in dmabuf
  binding.
- Simplify the calculation of binding->tx_vec.
- Check in net_devmem_get_binding that the binding we're returning
  has ifindex matching the sending socket (Willem).
---
 include/linux/skbuff.h                  | 15 +++-
 include/net/sock.h                      |  1 +
 include/uapi/linux/uio.h                |  6 +-
 net/core/datagram.c                     | 41 ++++++++++-
 net/core/devmem.c                       | 96 +++++++++++++++++++++++--
 net/core/devmem.h                       | 42 +++++++++--
 net/core/netdev-genl.c                  | 65 ++++++++++++++++-
 net/core/skbuff.c                       |  6 +-
 net/core/sock.c                         |  8 +++
 net/ipv4/tcp.c                          | 36 +++++++---
 net/vmw_vsock/virtio_transport_common.c |  3 +-
 11 files changed, 285 insertions(+), 34 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..3ff8f568c382 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1711,9 +1711,12 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
 
 void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref);
 
+struct net_devmem_dmabuf_binding;
+
 int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 			    struct sk_buff *skb, struct iov_iter *from,
-			    size_t length);
+			    size_t length,
+			    struct net_devmem_dmabuf_binding *binding);
 
 int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 				struct iov_iter *from, size_t length);
@@ -1721,12 +1724,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
 					  struct msghdr *msg, int len)
 {
-	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len);
+	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len,
+				       NULL);
 }
 
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			     struct msghdr *msg, int len,
-			     struct ubuf_info *uarg);
+			     struct ubuf_info *uarg,
+			     struct net_devmem_dmabuf_binding *binding);
 
 /* Internal */
 #define skb_shinfo(SKB)	((struct skb_shared_info *)(skb_end_pointer(SKB)))
@@ -3697,6 +3702,10 @@ static inline dma_addr_t __skb_frag_dma_map(struct device *dev,
 					    size_t offset, size_t size,
 					    enum dma_data_direction dir)
 {
+	if (skb_frag_is_net_iov(frag)) {
+		return netmem_to_net_iov(frag->netmem)->dma_addr + offset +
+		       frag->offset;
+	}
 	return dma_map_page(dev, skb_frag_page(frag),
 			    skb_frag_off(frag) + offset, size, dir);
 }
diff --git a/include/net/sock.h b/include/net/sock.h
index 8036b3b79cd8..09eb918525b6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1822,6 +1822,7 @@ struct sockcm_cookie {
 	u32 tsflags;
 	u32 ts_opt_id;
 	u32 priority;
+	u32 dmabuf_id;
 };
 
 static inline void sockcm_init(struct sockcm_cookie *sockc,
diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
index 649739e0c404..866bd5dfe39f 100644
--- a/include/uapi/linux/uio.h
+++ b/include/uapi/linux/uio.h
@@ -38,10 +38,14 @@ struct dmabuf_token {
 	__u32 token_count;
 };
 
+struct dmabuf_tx_cmsg {
+	__u32 dmabuf_id;
+};
+
 /*
  *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
  */
- 
+
 #define UIO_FASTIOV	8
 #define UIO_MAXIOV	1024
 
diff --git a/net/core/datagram.c b/net/core/datagram.c
index f0693707aece..c989606ff58d 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -63,6 +63,8 @@
 #include <net/busy_poll.h>
 #include <crypto/hash.h>
 
+#include "devmem.h"
+
 /*
  *	Is a socket 'connection oriented' ?
  */
@@ -692,9 +694,42 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 	return 0;
 }
 
+static int
+zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
+			      int length,
+			      struct net_devmem_dmabuf_binding *binding)
+{
+	int i = skb_shinfo(skb)->nr_frags;
+	size_t virt_addr, size, off;
+	struct net_iov *niov;
+
+	while (length && iov_iter_count(from)) {
+		if (i == MAX_SKB_FRAGS)
+			return -EMSGSIZE;
+
+		virt_addr = (size_t)iter_iov_addr(from);
+		niov = net_devmem_get_niov_at(binding, virt_addr, &off, &size);
+		if (!niov)
+			return -EFAULT;
+
+		size = min_t(size_t, size, length);
+		size = min_t(size_t, size, iter_iov_len(from));
+
+		get_netmem(net_iov_to_netmem(niov));
+		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
+				       size, PAGE_SIZE);
+		iov_iter_advance(from, size);
+		length -= size;
+		i++;
+	}
+
+	return 0;
+}
+
 int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 			    struct sk_buff *skb, struct iov_iter *from,
-			    size_t length)
+			    size_t length,
+			    struct net_devmem_dmabuf_binding *binding)
 {
 	unsigned long orig_size = skb->truesize;
 	unsigned long truesize;
@@ -702,6 +737,8 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 
 	if (msg && msg->msg_ubuf && msg->sg_from_iter)
 		ret = msg->sg_from_iter(skb, from, length);
+	else if (unlikely(binding))
+		ret = zerocopy_fill_skb_from_devmem(skb, from, length, binding);
 	else
 		ret = zerocopy_fill_skb_from_iter(skb, from, length);
 
@@ -735,7 +772,7 @@ int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
 	if (skb_copy_datagram_from_iter(skb, 0, from, copy))
 		return -EFAULT;
 
-	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U);
+	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U, NULL);
 }
 EXPORT_SYMBOL(zerocopy_sg_from_iter);
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 20985a570662..796338b1599e 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -16,6 +16,7 @@
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
+#include <net/sock.h>
 #include <trace/events/page_pool.h>
 
 #include "devmem.h"
@@ -64,8 +65,10 @@ void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
+	kfree(binding->tx_vec);
 	kfree(binding);
 }
+EXPORT_SYMBOL(__net_devmem_dmabuf_binding_free);
 
 struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
@@ -110,6 +113,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	unsigned long xa_idx;
 	unsigned int rxq_idx;
 
+	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+
+	/* Ensure no tx net_devmem_lookup_dmabuf() are in flight after the
+	 * erase.
+	 */
+	synchronize_net();
+
 	if (binding->list.next)
 		list_del(&binding->list);
 
@@ -123,8 +133,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
 	}
 
-	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
-
 	net_devmem_dmabuf_binding_put(binding);
 }
 
@@ -185,8 +193,9 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 }
 
 struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
-		       struct netlink_ext_ack *extack)
+net_devmem_bind_dmabuf(struct net_device *dev,
+		       enum dma_data_direction direction,
+		       unsigned int dmabuf_fd, struct netlink_ext_ack *extack)
 {
 	struct net_devmem_dmabuf_binding *binding;
 	static u32 id_alloc_next;
@@ -229,7 +238,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	}
 
 	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
-						       DMA_FROM_DEVICE);
+						       direction);
 	if (IS_ERR(binding->sgt)) {
 		err = PTR_ERR(binding->sgt);
 		NL_SET_ERR_MSG(extack, "Failed to map dmabuf attachment");
@@ -240,13 +249,22 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	 * binding can be much more flexible than that. We may be able to
 	 * allocate MTU sized chunks here. Leave that for future work...
 	 */
-	binding->chunk_pool =
-		gen_pool_create(PAGE_SHIFT, dev_to_node(&dev->dev));
+	binding->chunk_pool = gen_pool_create(PAGE_SHIFT,
+					      dev_to_node(&dev->dev));
 	if (!binding->chunk_pool) {
 		err = -ENOMEM;
 		goto err_unmap;
 	}
 
+	if (direction == DMA_TO_DEVICE) {
+		binding->tx_vec = kcalloc(dmabuf->size / PAGE_SIZE,
+					  sizeof(struct net_iov *), GFP_KERNEL);
+		if (!binding->tx_vec) {
+			err = -ENOMEM;
+			goto err_free_chunks;
+		}
+	}
+
 	virtual = 0;
 	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
 		dma_addr_t dma_addr = sg_dma_address(sg);
@@ -288,6 +306,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 			niov->owner = owner;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
+			if (direction == DMA_TO_DEVICE)
+				binding->tx_vec[owner->base_virtual / PAGE_SIZE + i] = niov;
 		}
 
 		virtual += len;
@@ -313,6 +333,21 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	return ERR_PTR(err);
 }
 
+struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
+{
+	struct net_devmem_dmabuf_binding *binding;
+
+	rcu_read_lock();
+	binding = xa_load(&net_devmem_dmabuf_bindings, id);
+	if (binding) {
+		if (!net_devmem_dmabuf_binding_get(binding))
+			binding = NULL;
+	}
+	rcu_read_unlock();
+
+	return binding;
+}
+
 void dev_dmabuf_uninstall(struct net_device *dev)
 {
 	struct net_devmem_dmabuf_binding *binding;
@@ -343,6 +378,53 @@ void net_devmem_put_net_iov(struct net_iov *niov)
 	net_devmem_dmabuf_binding_put(niov->owner->binding);
 }
 
+struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
+							 unsigned int dmabuf_id)
+{
+	struct net_devmem_dmabuf_binding *binding;
+	struct dst_entry *dst = __sk_dst_get(sk);
+	int err = 0;
+
+	binding = net_devmem_lookup_dmabuf(dmabuf_id);
+	if (!binding || !binding->tx_vec) {
+		err = -EINVAL;
+		goto out_err;
+	}
+
+	/* The dma-addrs in this binding are only reachable to the corresponding
+	 * net_device.
+	 */
+	if (!dst || !dst->dev || dst->dev->ifindex != binding->dev->ifindex) {
+		err = -ENODEV;
+		goto out_err;
+	}
+
+	return binding;
+
+out_err:
+	if (binding)
+		net_devmem_dmabuf_binding_put(binding);
+
+	return ERR_PTR(err);
+}
+
+struct net_iov *
+net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
+		       size_t virt_addr, size_t *off, size_t *size)
+{
+	size_t idx;
+
+	if (virt_addr >= binding->dmabuf->size)
+		return NULL;
+
+	idx = virt_addr / PAGE_SIZE;
+
+	*off = virt_addr % PAGE_SIZE;
+	*size = PAGE_SIZE - *off;
+
+	return binding->tx_vec[idx];
+}
+
 /*** "Dmabuf devmem memory provider" ***/
 
 int mp_dmabuf_devmem_init(struct page_pool *pool)
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 8b51caff5a0e..874e891e70e0 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -46,6 +46,12 @@ struct net_devmem_dmabuf_binding {
 	 * active.
 	 */
 	u32 id;
+
+	/* Array of net_iov pointers for this binding, sorted by virtual
+	 * address. This array is convenient to map the virtual addresses to
+	 * net_iovs in the TX path.
+	 */
+	struct net_iov **tx_vec;
 };
 
 #if defined(CONFIG_NET_DEVMEM)
@@ -70,12 +76,15 @@ struct dmabuf_genpool_chunk_owner {
 
 void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding);
 struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
-		       struct netlink_ext_ack *extack);
+net_devmem_bind_dmabuf(struct net_device *dev,
+		       enum dma_data_direction direction,
+		       unsigned int dmabuf_fd, struct netlink_ext_ack *extack);
+struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack);
+void net_devmem_bind_tx_release(struct sock *sk);
 void dev_dmabuf_uninstall(struct net_device *dev);
 
 static inline struct dmabuf_genpool_chunk_owner *
@@ -108,10 +117,10 @@ static inline u32 net_iov_binding_id(const struct net_iov *niov)
 	return net_iov_owner(niov)->binding->id;
 }
 
-static inline void
+static inline bool
 net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
 {
-	refcount_inc(&binding->ref);
+	return refcount_inc_not_zero(&binding->ref);
 }
 
 static inline void
@@ -130,6 +139,12 @@ struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
 
+struct net_devmem_dmabuf_binding *
+net_devmem_get_binding(struct sock *sk, unsigned int dmabuf_id);
+struct net_iov *
+net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding, size_t addr,
+		       size_t *off, size_t *size);
+
 #else
 struct net_devmem_dmabuf_binding;
 
@@ -153,11 +168,17 @@ __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 
 static inline struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
+		       enum dma_data_direction direction,
 		       struct netlink_ext_ack *extack)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
+{
+	return NULL;
+}
+
 static inline void
 net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 {
@@ -195,6 +216,19 @@ static inline u32 net_iov_binding_id(const struct net_iov *niov)
 {
 	return 0;
 }
+
+static inline struct net_devmem_dmabuf_binding *
+net_devmem_get_binding(struct sock *sk, unsigned int dmabuf_id)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct net_iov *
+net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding, size_t addr,
+		       size_t *off, size_t *size)
+{
+	return NULL;
+}
 #endif
 
 #endif /* _NET_DEVMEM_H */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 0e41699df419..9ba6994e2a05 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -854,7 +854,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, info->extack);
+	binding = net_devmem_bind_dmabuf(netdev, DMA_FROM_DEVICE, dmabuf_fd,
+					 info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock;
@@ -911,10 +912,68 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-/* stub */
 int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return 0;
+	struct net_devmem_dmabuf_binding *binding;
+	struct list_head *sock_binding_list;
+	struct net_device *netdev;
+	u32 ifindex, dmabuf_fd;
+	struct sk_buff *rsp;
+	int err = 0;
+	void *hdr;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_FD))
+		return -EINVAL;
+
+	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
+	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
+
+	sock_binding_list =
+		genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
+	if (IS_ERR(sock_binding_list))
+		return PTR_ERR(sock_binding_list);
+
+	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(rsp, info);
+	if (!hdr) {
+		err = -EMSGSIZE;
+		goto err_genlmsg_free;
+	}
+
+	rtnl_lock();
+
+	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
+	if (!netdev || !netif_device_present(netdev)) {
+		err = -ENODEV;
+		goto err_unlock;
+	}
+
+	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
+					 info->extack);
+	if (IS_ERR(binding)) {
+		err = PTR_ERR(binding);
+		goto err_unlock;
+	}
+
+	list_add(&binding->list, sock_binding_list);
+
+	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
+	genlmsg_end(rsp, hdr);
+
+	rtnl_unlock();
+
+	return genlmsg_reply(rsp, info);
+
+	net_devmem_unbind_dmabuf(binding);
+err_unlock:
+	rtnl_unlock();
+err_genlmsg_free:
+	nlmsg_free(rsp);
+	return err;
 }
 
 void netdev_nl_sock_priv_init(struct list_head *priv)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 815245d5c36b..6289ffcbb20b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1882,7 +1882,8 @@ EXPORT_SYMBOL_GPL(msg_zerocopy_ubuf_ops);
 
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			     struct msghdr *msg, int len,
-			     struct ubuf_info *uarg)
+			     struct ubuf_info *uarg,
+			     struct net_devmem_dmabuf_binding *binding)
 {
 	int err, orig_len = skb->len;
 
@@ -1901,7 +1902,8 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			return -EEXIST;
 	}
 
-	err = __zerocopy_sg_from_iter(msg, sk, skb, &msg->msg_iter, len);
+	err = __zerocopy_sg_from_iter(msg, sk, skb, &msg->msg_iter, len,
+				      binding);
 	if (err == -EFAULT || (err == -EMSGSIZE && skb->len == orig_len)) {
 		struct sock *save_sk = skb->sk;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index eae2ae70a2e0..353669f124ab 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2911,6 +2911,7 @@ EXPORT_SYMBOL(sock_alloc_send_pskb);
 int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 		     struct sockcm_cookie *sockc)
 {
+	struct dmabuf_tx_cmsg dmabuf_tx;
 	u32 tsflags;
 
 	BUILD_BUG_ON(SOF_TIMESTAMPING_LAST == (1 << 31));
@@ -2964,6 +2965,13 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 		if (!sk_set_prio_allowed(sk, *(u32 *)CMSG_DATA(cmsg)))
 			return -EPERM;
 		sockc->priority = *(u32 *)CMSG_DATA(cmsg);
+		break;
+	case SCM_DEVMEM_DMABUF:
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct dmabuf_tx_cmsg)))
+			return -EINVAL;
+		dmabuf_tx = *(struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg);
+		sockc->dmabuf_id = dmabuf_tx.dmabuf_id;
+
 		break;
 	default:
 		return -EINVAL;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..44198ae7e44c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1051,6 +1051,7 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 {
+	struct net_devmem_dmabuf_binding *binding = NULL;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct ubuf_info *uarg = NULL;
 	struct sk_buff *skb;
@@ -1063,6 +1064,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 	flags = msg->msg_flags;
 
+	sockcm_init(&sockc, sk);
+	if (msg->msg_controllen) {
+		err = sock_cmsg_send(sk, msg, &sockc);
+		if (unlikely(err)) {
+			err = -EINVAL;
+			goto out_err;
+		}
+	}
+
 	if ((flags & MSG_ZEROCOPY) && size) {
 		if (msg->msg_ubuf) {
 			uarg = msg->msg_ubuf;
@@ -1080,6 +1090,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			else
 				uarg_to_msgzc(uarg)->zerocopy = 0;
 		}
+
+		if (sockc.dmabuf_id != 0) {
+			binding = net_devmem_get_binding(sk, sockc.dmabuf_id);
+			if (IS_ERR(binding)) {
+				err = PTR_ERR(binding);
+				binding = NULL;
+				goto out_err;
+			}
+		}
 	} else if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES) && size) {
 		if (sk->sk_route_caps & NETIF_F_SG)
 			zc = MSG_SPLICE_PAGES;
@@ -1123,15 +1142,6 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		/* 'common' sending to sendq */
 	}
 
-	sockcm_init(&sockc, sk);
-	if (msg->msg_controllen) {
-		err = sock_cmsg_send(sk, msg, &sockc);
-		if (unlikely(err)) {
-			err = -EINVAL;
-			goto out_err;
-		}
-	}
-
 	/* This should be in poll */
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
@@ -1248,7 +1258,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 					goto wait_for_space;
 			}
 
-			err = skb_zerocopy_iter_stream(sk, skb, msg, copy, uarg);
+			err = skb_zerocopy_iter_stream(sk, skb, msg, copy, uarg,
+						       binding);
 			if (err == -EMSGSIZE || err == -EEXIST) {
 				tcp_mark_push(tp, skb);
 				goto new_segment;
@@ -1329,6 +1340,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	/* msg->msg_ubuf is pinned by the caller so we don't take extra refs */
 	if (uarg && !msg->msg_ubuf)
 		net_zcopy_put(uarg);
+	if (binding)
+		net_devmem_dmabuf_binding_put(binding);
 	return copied + copied_syn;
 
 do_error:
@@ -1346,6 +1359,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		sk->sk_write_space(sk);
 		tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LIMITED);
 	}
+	if (binding)
+		net_devmem_dmabuf_binding_put(binding);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(tcp_sendmsg_locked);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 7f7de6d88096..f6d4bb798517 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -107,8 +107,7 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
 {
 	if (zcopy)
 		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
-					       &info->msg->msg_iter,
-					       len);
+					       &info->msg->msg_iter, len, NULL);
 
 	return memcpy_from_msg(skb_put(skb, len), info->msg, len);
 }
-- 
2.48.1.362.g079036d154-goog


