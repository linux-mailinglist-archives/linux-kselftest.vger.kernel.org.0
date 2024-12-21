Return-Path: <linux-kselftest+bounces-23709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635F09F9D91
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 01:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C043816C150
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 00:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087017BB24;
	Sat, 21 Dec 2024 00:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xV4ZicyZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76292149C7D
	for <linux-kselftest@vger.kernel.org>; Sat, 21 Dec 2024 00:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734742305; cv=none; b=eOBp4F21lpnMYUB1qABLUPf9cUqBPybXRoRxVNqelznZhsh0fYnTHzKWyhnaZF8w8yW0P+N4VuytScnf4bWNtT8yMJoJradAJf8M6O3hu0LrraVr1zAm+8OjbVnDJHxkUtJ5MA6or88geIeLvcMZFptL9YFPWVUX39LVjWdRPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734742305; c=relaxed/simple;
	bh=IINc7iQX/r7LYdrEQhak9aKmKhNQAg2DZGRwc2+9I94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tW3WY7vTFThFhs9Qitg35ttl1HUwrKxfrKJwjnDz2ySPlN/AYbmrdiuVLQXL0YrzleKJv5j+HDm8T3NRu81GSPdUhdJlg7qHvVi3G//UydDbiYgwie1jCYcHawgZ5bZPsWxS5Uj3UEDQZwfZfd4sJOc8aPLGs26pcqCpL/pygTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xV4ZicyZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7eaac1e95ffso1647084a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 16:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734742302; x=1735347102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZSE0w2/Y5onWcsN4W4n34gva14f/out2BJyIZxl9Q0=;
        b=xV4ZicyZwFJdWRL2dv9PUY3tgBZgnIpCS+y150QqyxXxYbeq9NOzpmIowsP745p8Uc
         0qSBRUH3VE6OOJJUg53rvjdFQv2pUZaA5yhEeVxcEiOFqx95TgnU29jq6FX1KQYGIFdQ
         BDcSmEUcKcko5RafqvpKJDstIb3vSzYbS8V+DiX5LLlxxkwIW55s9lhNoiF/zNkPp8E4
         PMeWb7En6wbMIjsDbN9BlqZoTo7Ky/UqxQTGyVh+KC8vzwwL2cfZOiO4KUEcvNlmOjmM
         5Ty8n6IsDClerws0mkP+568cKV0BI59c1pdr9VLk89CCCvQq1UyBJcUYXH0sQNUZoV3v
         Cp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734742302; x=1735347102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZSE0w2/Y5onWcsN4W4n34gva14f/out2BJyIZxl9Q0=;
        b=uI6XXNUiuLtDS0S/pIhNCNL1lYsamtf51EP63L9EsF2BLcOUNmWbSTVV/Be891D+4+
         s2LOlgWseWQWidSoS48mt09p93RgsDwQADPGJGtlwzD06Nf3UW6syEe/m3rNI9MGMX74
         gwhkW85MxBeralq1Qn+jO7abdUw4QmVmJGO18F7ES2ngMKAwUh/KXME3LFxTjMvJ046N
         KkBm0/vN2McmJCBCvCtDznbi0QhY4ap0GnCFbqbljtT9RwrFjg8ODKakoV1hogvxNrqr
         LjoNaALLccAzeNt0ypipr4DKKsFufbstRhuzUVLXz7BFgCHvWy6SXzHCr/O9tjYXY+Bk
         hdTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMPzjAYldy6KAweo3wDWnhSWVR+4bNKmjZIlUizH1Rjx/+/TTSMAtCJqwQINpbFpKp6AQXNan6lyqUSgNFPBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzw5qm5fgGX10dlAIvVZqmGMz8f0KIwT5G57ZO2K3e6ChOsLQi
	3XjjS7P5+1HRXMy8oJaEuNBt8XdqmWjAfT087DNTYWJ/4z/M7t4trNJwVNZXDyTECsGZhW/ALUO
	YVNyZ5g6ZNm2mIACHko7aMA==
X-Google-Smtp-Source: AGHT+IEVonbxTJJnb/MSXmpgW2Kj8xiEDkigF5HqD2BqY7pxwYAoFbcUNdEZ7bbAazV4BPucfe0/kWlx29dFavSHaw==
X-Received: from pgjo21.prod.google.com ([2002:a63:e355:0:b0:826:36c0:d549])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:258c:b0:1db:915b:ab11 with SMTP id adf61e73a8af0-1e5e04946b1mr9353594637.24.1734742301979;
 Fri, 20 Dec 2024 16:51:41 -0800 (PST)
Date: Sat, 21 Dec 2024 00:42:36 +0000
In-Reply-To: <20241221004236.2629280-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241221004236.2629280-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241221004236.2629280-6-almasrymina@google.com>
Subject: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"

Augment dmabuf binding to be able to handle TX. Additional to all the RX
binding, we also create tx_vec and tx_iter needed for the TX path.

Provide API for sendmsg to be able to send dmabufs bound to this device:

- Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from,
  and the offset into the dmabuf to send from.
- MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf.

Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
implementation, while disabling instances where MSG_ZEROCOPY falls back
to copying.

We additionally look up the dmabuf to send from by id, then pipe the
binding down to the new zerocopy_fill_skb_from_devmem which fills a TX skb
with net_iov netmems instead of the traditional page netmems.

We also special case skb_frag_dma_map to return the dma-address of these
dmabuf net_iovs instead of attempting to map pages.

Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the meat
of the implementation came from devmem TCP RFC v1[1], which included the
TX path, but Stan did all the rebasing on top of netmem/net_iov.

Cc: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/skbuff.h                  | 13 +++-
 include/net/sock.h                      |  2 +
 include/uapi/linux/uio.h                |  5 ++
 net/core/datagram.c                     | 40 ++++++++++-
 net/core/devmem.c                       | 91 +++++++++++++++++++++++--
 net/core/devmem.h                       | 40 +++++++++--
 net/core/netdev-genl.c                  | 65 +++++++++++++++++-
 net/core/skbuff.c                       |  8 ++-
 net/core/sock.c                         |  9 +++
 net/ipv4/tcp.c                          | 36 +++++++---
 net/vmw_vsock/virtio_transport_common.c |  4 +-
 11 files changed, 281 insertions(+), 32 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..e90dc0c4d542 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1711,9 +1711,10 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
 
 void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref);
 
+struct net_devmem_dmabuf_binding;
 int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 			    struct sk_buff *skb, struct iov_iter *from,
-			    size_t length);
+			    size_t length, bool is_devmem);
 
 int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 				struct iov_iter *from, size_t length);
@@ -1721,12 +1722,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
 					  struct msghdr *msg, int len)
 {
-	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len);
+	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len,
+				       false);
 }
 
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			     struct msghdr *msg, int len,
-			     struct ubuf_info *uarg);
+			     struct ubuf_info *uarg,
+			     struct net_devmem_dmabuf_binding *binding);
 
 /* Internal */
 #define skb_shinfo(SKB)	((struct skb_shared_info *)(skb_end_pointer(SKB)))
@@ -3697,6 +3700,10 @@ static inline dma_addr_t __skb_frag_dma_map(struct device *dev,
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
index d4bdd3286e03..75bd580fe9c6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1816,6 +1816,8 @@ struct sockcm_cookie {
 	u32 tsflags;
 	u32 ts_opt_id;
 	u32 priority;
+	u32 dmabuf_id;
+	u64 dmabuf_offset;
 };
 
 static inline void sockcm_init(struct sockcm_cookie *sockc,
diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
index 649739e0c404..41490cde95ad 100644
--- a/include/uapi/linux/uio.h
+++ b/include/uapi/linux/uio.h
@@ -38,6 +38,11 @@ struct dmabuf_token {
 	__u32 token_count;
 };
 
+struct dmabuf_tx_cmsg {
+	__u32 dmabuf_id;
+	__u64 dmabuf_offset;
+};
+
 /*
  *	UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
  */
diff --git a/net/core/datagram.c b/net/core/datagram.c
index f0693707aece..3b09995db894 100644
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
@@ -692,9 +694,41 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 	return 0;
 }
 
+static int zerocopy_fill_skb_from_devmem(struct sk_buff *skb,
+					 struct msghdr *msg,
+					 struct iov_iter *from, int length)
+{
+	int i = skb_shinfo(skb)->nr_frags;
+	int orig_length = length;
+	netmem_ref netmem;
+	size_t size;
+
+	while (length && iov_iter_count(from)) {
+		if (i == MAX_SKB_FRAGS)
+			return -EMSGSIZE;
+
+		size = min_t(size_t, iter_iov_len(from), length);
+		if (!size)
+			return -EFAULT;
+
+		netmem = net_iov_to_netmem(iter_iov(from)->iov_base);
+		get_netmem(netmem);
+		skb_add_rx_frag_netmem(skb, i, netmem, from->iov_offset, size,
+				       PAGE_SIZE);
+
+		iov_iter_advance(from, size);
+		length -= size;
+		i++;
+	}
+
+	iov_iter_advance(&msg->msg_iter, orig_length);
+
+	return 0;
+}
+
 int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 			    struct sk_buff *skb, struct iov_iter *from,
-			    size_t length)
+			    size_t length, bool is_devmem)
 {
 	unsigned long orig_size = skb->truesize;
 	unsigned long truesize;
@@ -702,6 +736,8 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 
 	if (msg && msg->msg_ubuf && msg->sg_from_iter)
 		ret = msg->sg_from_iter(skb, from, length);
+	else if (unlikely(is_devmem))
+		ret = zerocopy_fill_skb_from_devmem(skb, msg, from, length);
 	else
 		ret = zerocopy_fill_skb_from_iter(skb, from, length);
 
@@ -735,7 +771,7 @@ int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
 	if (skb_copy_datagram_from_iter(skb, 0, from, copy))
 		return -EFAULT;
 
-	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U);
+	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U, NULL);
 }
 EXPORT_SYMBOL(zerocopy_sg_from_iter);
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index f7e06a8cba01..81f1b715cfa6 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -15,6 +15,7 @@
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
+#include <net/sock.h>
 #include <trace/events/page_pool.h>
 
 #include "devmem.h"
@@ -63,8 +64,10 @@ void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
+	kfree(binding->tx_vec);
 	kfree(binding);
 }
+EXPORT_SYMBOL(__net_devmem_dmabuf_binding_free);
 
 struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
@@ -109,6 +112,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
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
 
@@ -122,8 +132,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
 	}
 
-	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
-
 	net_devmem_dmabuf_binding_put(binding);
 }
 
@@ -174,8 +182,9 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
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
@@ -183,6 +192,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx, i;
 	unsigned long virtual;
+	struct iovec *iov;
 	int err;
 
 	dmabuf = dma_buf_get(dmabuf_fd);
@@ -218,13 +228,19 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	}
 
 	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
-						       DMA_FROM_DEVICE);
+						       direction);
 	if (IS_ERR(binding->sgt)) {
 		err = PTR_ERR(binding->sgt);
 		NL_SET_ERR_MSG(extack, "Failed to map dmabuf attachment");
 		goto err_detach;
 	}
 
+	if (!binding->sgt || binding->sgt->nents == 0) {
+		err = -EINVAL;
+		NL_SET_ERR_MSG(extack, "Empty dmabuf attachment");
+		goto err_detach;
+	}
+
 	/* For simplicity we expect to make PAGE_SIZE allocations, but the
 	 * binding can be much more flexible than that. We may be able to
 	 * allocate MTU sized chunks here. Leave that for future work...
@@ -236,6 +252,19 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 		goto err_unmap;
 	}
 
+	if (direction == DMA_TO_DEVICE) {
+		virtual = 0;
+		for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx)
+			virtual += sg_dma_len(sg);
+
+		binding->tx_vec = kcalloc(virtual / PAGE_SIZE + 1,
+					  sizeof(struct iovec), GFP_KERNEL);
+		if (!binding->tx_vec) {
+			err = -ENOMEM;
+			goto err_unmap;
+		}
+	}
+
 	virtual = 0;
 	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
 		dma_addr_t dma_addr = sg_dma_address(sg);
@@ -277,11 +306,21 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 			niov->owner = owner;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
+
+			if (direction == DMA_TO_DEVICE) {
+				iov = &binding->tx_vec[virtual / PAGE_SIZE + i];
+				iov->iov_base = niov;
+				iov->iov_len = PAGE_SIZE;
+			}
 		}
 
 		virtual += len;
 	}
 
+	if (direction == DMA_TO_DEVICE)
+		iov_iter_init(&binding->tx_iter, WRITE, binding->tx_vec,
+			      virtual / PAGE_SIZE + 1, virtual);
+
 	return binding;
 
 err_free_chunks:
@@ -302,6 +341,21 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
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
@@ -332,6 +386,33 @@ void net_devmem_put_net_iov(struct net_iov *niov)
 	net_devmem_dmabuf_binding_put(niov->owner->binding);
 }
 
+struct net_devmem_dmabuf_binding *
+net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc)
+{
+	struct net_devmem_dmabuf_binding *binding;
+	int err = 0;
+
+	binding = net_devmem_lookup_dmabuf(sockc->dmabuf_id);
+	if (!binding || !binding->tx_vec) {
+		err = -EINVAL;
+		goto out_err;
+	}
+
+	if (sock_net(sk) != dev_net(binding->dev)) {
+		err = -ENODEV;
+		goto out_err;
+	}
+
+	iov_iter_advance(&binding->tx_iter, sockc->dmabuf_offset);
+	return binding;
+
+out_err:
+	if (binding)
+		net_devmem_dmabuf_binding_put(binding);
+
+	return ERR_PTR(err);
+}
+
 /*** "Dmabuf devmem memory provider" ***/
 
 int mp_dmabuf_devmem_init(struct page_pool *pool)
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 54e30fea80b3..f923c77d9c45 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -11,6 +11,8 @@
 #define _NET_DEVMEM_H
 
 struct netlink_ext_ack;
+struct sockcm_cookie;
+struct sock;
 
 struct net_devmem_dmabuf_binding {
 	struct dma_buf *dmabuf;
@@ -27,6 +29,10 @@ struct net_devmem_dmabuf_binding {
 	 * The binding undos itself and unmaps the underlying dmabuf once all
 	 * those refs are dropped and the binding is no longer desired or in
 	 * use.
+	 *
+	 * net_devmem_get_net_iov() on dmabuf net_iovs will increment this
+	 * reference, making sure that that the binding remains alive until all
+	 * the net_iovs are no longer used.
 	 */
 	refcount_t ref;
 
@@ -42,6 +48,10 @@ struct net_devmem_dmabuf_binding {
 	 * active.
 	 */
 	u32 id;
+
+	/* iov_iter representing all possible net_iov chunks in the dmabuf. */
+	struct iov_iter tx_iter;
+	struct iovec *tx_vec;
 };
 
 #if defined(CONFIG_NET_DEVMEM)
@@ -66,8 +76,10 @@ struct dmabuf_genpool_chunk_owner {
 
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
@@ -104,10 +116,10 @@ static inline u32 net_iov_binding_id(const struct net_iov *niov)
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
@@ -126,6 +138,9 @@ struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
 
+struct net_devmem_dmabuf_binding *
+net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc);
+
 #else
 struct net_devmem_dmabuf_binding;
 
@@ -144,11 +159,17 @@ __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 
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
@@ -186,6 +207,17 @@ static inline u32 net_iov_binding_id(const struct net_iov *niov)
 {
 	return 0;
 }
+
+static inline void
+net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
+{
+}
+
+static inline struct net_devmem_dmabuf_binding *
+net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif
 
 #endif /* _NET_DEVMEM_H */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 00d3d5851487..b9928bac94da 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -850,7 +850,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, info->extack);
+	binding = net_devmem_bind_dmabuf(netdev, DMA_FROM_DEVICE, dmabuf_fd,
+					 info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock;
@@ -907,10 +908,68 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
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
index 815245d5c36b..eb6b41a32524 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1882,8 +1882,10 @@ EXPORT_SYMBOL_GPL(msg_zerocopy_ubuf_ops);
 
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			     struct msghdr *msg, int len,
-			     struct ubuf_info *uarg)
+			     struct ubuf_info *uarg,
+			     struct net_devmem_dmabuf_binding *binding)
 {
+	struct iov_iter *from = binding ? &binding->tx_iter : &msg->msg_iter;
 	int err, orig_len = skb->len;
 
 	if (uarg->ops->link_skb) {
@@ -1901,12 +1903,12 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			return -EEXIST;
 	}
 
-	err = __zerocopy_sg_from_iter(msg, sk, skb, &msg->msg_iter, len);
+	err = __zerocopy_sg_from_iter(msg, sk, skb, from, len, binding != NULL);
 	if (err == -EFAULT || (err == -EMSGSIZE && skb->len == orig_len)) {
 		struct sock *save_sk = skb->sk;
 
 		/* Streams do not free skb on error. Reset to prev state. */
-		iov_iter_revert(&msg->msg_iter, skb->len - orig_len);
+		iov_iter_revert(from, skb->len - orig_len);
 		skb->sk = sk;
 		___pskb_trim(skb, orig_len);
 		skb->sk = save_sk;
diff --git a/net/core/sock.c b/net/core/sock.c
index e7bcc8952248..ed7089310f0d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2908,6 +2908,7 @@ EXPORT_SYMBOL(sock_alloc_send_pskb);
 int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 		     struct sockcm_cookie *sockc)
 {
+	struct dmabuf_tx_cmsg dmabuf_tx;
 	u32 tsflags;
 
 	BUILD_BUG_ON(SOF_TIMESTAMPING_LAST == (1 << 31));
@@ -2961,6 +2962,14 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 		if (!sk_set_prio_allowed(sk, *(u32 *)CMSG_DATA(cmsg)))
 			return -EPERM;
 		sockc->priority = *(u32 *)CMSG_DATA(cmsg);
+		break;
+	case SCM_DEVMEM_DMABUF:
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(struct dmabuf_tx_cmsg)))
+			return -EINVAL;
+		dmabuf_tx = *(struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg);
+		sockc->dmabuf_id = dmabuf_tx.dmabuf_id;
+		sockc->dmabuf_offset = dmabuf_tx.dmabuf_offset;
+
 		break;
 	default:
 		return -EINVAL;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..406dc2993742 100644
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
+			binding = net_devmem_get_sockc_binding(sk, &sockc);
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
index 9acc13ab3f82..286e6cd5ad34 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -104,8 +104,8 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
 {
 	if (zcopy)
 		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
-					       &info->msg->msg_iter,
-					       len);
+					       &info->msg->msg_iter, len,
+					       false);
 
 	return memcpy_from_msg(skb_put(skb, len), info->msg, len);
 }
-- 
2.47.1.613.gc27f4b7a9f-goog


