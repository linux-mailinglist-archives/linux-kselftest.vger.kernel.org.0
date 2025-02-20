Return-Path: <linux-kselftest+bounces-27035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2216A3CF17
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 03:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C80189A247
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D451DC05F;
	Thu, 20 Feb 2025 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlBnPRdM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620261D5CE7
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017369; cv=none; b=Y+tdD93nHYwxXlLbg6PTWObwlUti/i7Uvros2gVVNQDILiLBomIPRrEG0Zd2yX3F2h30dptENUUdYnrOHo8sWXDAP+Bh8xtl91WNqzZX0zl+L1cBo2PpLPRKz+QBeiFACm6SYsqB5HsqY7aCci9RI+Dm2Ui83Ib5F2PEVXh1p24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017369; c=relaxed/simple;
	bh=e5hPF12eEJLftTNryZbJDs4ubF/USuqVahDAV/kwMiM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BCdDM5QSaix62c/kW9l+rsRZ979PkLPf9H27ddDwI+A/ThSzcm3mPqfVnhSIjKoB121CSqIEHCur9wQbnWeQycVtxKUwxX4sFRS8f7gI+8dE2cpkL5/CahMBUgbdb6SMY44HXytHKzzEI2Gmu6ekYzw0RmtQNzlhapeORXNnZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nlBnPRdM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220e04e67e2so10983405ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 18:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740017366; x=1740622166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=quOt6cIc6toB/KE2mpDVuKSMVPSUKODHhLxEz5QkXPo=;
        b=nlBnPRdMd3jx1UyaHkggJC7HIVxbIymUSliVa4YCifyOegQeYtM6fpDSOJRl3RwZ0e
         bbeWPW4WdEBHpMyn8fr1Bm0W8X9eSo3/nzUJSnQ4qHuGErbYcN+GkgyolQnx1YKM/1iG
         gTDYfMblQTwCzLl2WdbBRSCX46/wrQs5Iu5ZMo3pxDC7tvqqSN/IelGpY24iHdVfItAV
         zZbs+FTb/+nrgBNj4uGBPl+WGjJOE3LCh89PujnrcxdEJhwZkaqCmiz8cEHnVKZJ5iZ2
         t8AbDd9hjOVWaQ0EAGtCxPu4z3a48N5/GbDx5aJ+lhmP6tpO86ZAtGQsXtnm1Sur++1o
         /orA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740017366; x=1740622166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quOt6cIc6toB/KE2mpDVuKSMVPSUKODHhLxEz5QkXPo=;
        b=AkxHosPTqqFdRUr5TtnKFBH0zxu/GJF734kejuIzIoIerOFGs9i9zJ49SjOKiaDaRf
         MxuqY+QwgqZ9e4mn640lOta1YIOvH7uXT+iR1LwZGvUmPeFCJeuyJBjBy9ycHrjEMDBU
         o1mwrFI/qLb/8qKrmqIEubaYGKcJWDUthIIDspGaWaiUf5C9ufLQ6GKs/4p43LDhOtPd
         mkesLHGcYXrGwN3bSllFHcjQVrJruO7lcQFv1v5SsRYbTGloPe+T/aGD2/+/8hrQ50f6
         J7frnC6Ai2v+XyxyUtgmNB/+ebV7mgQEVhBjbAJ8hgIY6OBCAz/mJhdcsFXlmnC5bcFF
         8vNA==
X-Forwarded-Encrypted: i=1; AJvYcCXXhEGmOICQXvPgnj+1GqgAPOhiuVL+f1Ojme4AqHrS2niC9hugg8IlSXrfNZdOABVOhCTqsJyc8qHWqtBSHmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgccJo0E/pah7bjIcdnTdZ0+u/+vSpsOn2hHxp9jf7xEYjgiR
	NEkz8KqYTo3OQUUyeEt6pSqOyczt/XtwYdDc6BUrpgSwUnktITD9kY+12VRvmX0fsIBsNYrPHPA
	1Bjx0E7iyvEIZZ6zxzSPvxA==
X-Google-Smtp-Source: AGHT+IGSoO0GGIzikoGJKWqXOqz6rpD+nq1kteh9bCYGon+EO4UAEWFbDa90cbaW8OVDKqDl0BcrGHEJEkWIbDITeg==
X-Received: from plbkh8.prod.google.com ([2002:a17:903:648:b0:221:751f:dafa])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ecca:b0:220:e9ef:ec98 with SMTP id d9443c01a7336-221709622b7mr104598725ad.19.1740017365815;
 Wed, 19 Feb 2025 18:09:25 -0800 (PST)
Date: Thu, 20 Feb 2025 02:09:08 +0000
In-Reply-To: <20250220020914.895431-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220020914.895431-4-almasrymina@google.com>
Subject: [PATCH net-next v4 3/9] net: devmem: Implement TX path
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
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

v4:
- Remove dmabuf_tx_cmsg definition and just use __u32 for the dma-buf id
  (Willem).
- Check that iov_iter_type() is ITER_IOVEC in
  zerocopy_fill_skb_from_iter() (Pavel).
- Fix binding->tx_vec not being freed on error paths (Paolo).
- Make devmem patch mutually exclusive with msg->ubuf_info path (Pavel).
- Check that MSG_ZEROCOPY and SOCK_ZEROCOPY are provided when
  sockc.dmabuf_id is provided.
- Don't mm_account_pinned_pages() on devmem TX (Pavel).

v3:
- Use kvmalloc_array instead of kcalloc (Stan).
- Fix unreachable code warning (Simon).

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
 include/linux/skbuff.h                  |  17 +++-
 include/net/sock.h                      |   1 +
 net/core/datagram.c                     |  48 +++++++++++-
 net/core/devmem.c                       | 100 ++++++++++++++++++++++--
 net/core/devmem.h                       |  41 +++++++++-
 net/core/netdev-genl.c                  |  64 ++++++++++++++-
 net/core/skbuff.c                       |  18 +++--
 net/core/sock.c                         |   6 ++
 net/ipv4/ip_output.c                    |   3 +-
 net/ipv4/tcp.c                          |  46 ++++++++---
 net/ipv6/ip6_output.c                   |   3 +-
 net/vmw_vsock/virtio_transport_common.c |   5 +-
 12 files changed, 309 insertions(+), 43 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..b8783aa94c1e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1707,13 +1707,16 @@ static inline void skb_set_end_offset(struct sk_buff *skb, unsigned int offset)
 extern const struct ubuf_info_ops msg_zerocopy_ubuf_ops;
 
 struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
-				       struct ubuf_info *uarg);
+				       struct ubuf_info *uarg, bool devmem);
 
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
index fac65ed30983..aac7e9d92ba5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1823,6 +1823,7 @@ struct sockcm_cookie {
 	u32 tsflags;
 	u32 ts_opt_id;
 	u32 priority;
+	u32 dmabuf_id;
 };
 
 static inline void sockcm_init(struct sockcm_cookie *sockc,
diff --git a/net/core/datagram.c b/net/core/datagram.c
index f0693707aece..3e60c83305cc 100644
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
@@ -692,9 +694,49 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
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
+	/* Devmem filling works by taking an IOVEC from the user where the
+	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to
+	 * send from. We do not support other iter types.
+	 */
+	if (iov_iter_type(from) != ITER_IOVEC)
+		return -EINVAL;
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
@@ -702,6 +744,8 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
 
 	if (msg && msg->msg_ubuf && msg->sg_from_iter)
 		ret = msg->sg_from_iter(skb, from, length);
+	else if (unlikely(binding))
+		ret = zerocopy_fill_skb_from_devmem(skb, from, length, binding);
 	else
 		ret = zerocopy_fill_skb_from_iter(skb, from, length);
 
@@ -735,7 +779,7 @@ int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
 	if (skb_copy_datagram_from_iter(skb, 0, from, copy))
 		return -EFAULT;
 
-	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U);
+	return __zerocopy_sg_from_iter(NULL, NULL, skb, from, ~0U, NULL);
 }
 EXPORT_SYMBOL(zerocopy_sg_from_iter);
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index b1aafc66ebb7..2e576f80b1d8 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -17,6 +17,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
+#include <net/sock.h>
 #include <trace/events/page_pool.h>
 
 #include "devmem.h"
@@ -73,8 +74,10 @@ void __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
+	kvfree(binding->tx_vec);
 	kfree(binding);
 }
+EXPORT_SYMBOL(__net_devmem_dmabuf_binding_free);
 
 struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
@@ -119,6 +122,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
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
 
@@ -133,8 +143,6 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
 	}
 
-	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
-
 	net_devmem_dmabuf_binding_put(binding);
 }
 
@@ -197,8 +205,9 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
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
@@ -241,7 +250,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	}
 
 	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
-						       DMA_FROM_DEVICE);
+						       direction);
 	if (IS_ERR(binding->sgt)) {
 		err = PTR_ERR(binding->sgt);
 		NL_SET_ERR_MSG(extack, "Failed to map dmabuf attachment");
@@ -252,13 +261,23 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
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
+		binding->tx_vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
+						 sizeof(struct net_iov *),
+						 GFP_KERNEL);
+		if (!binding->tx_vec) {
+			err = -ENOMEM;
+			goto err_free_chunks;
+		}
+	}
+
 	virtual = 0;
 	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
 		dma_addr_t dma_addr = sg_dma_address(sg);
@@ -300,6 +319,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 			niov->owner = &owner->area;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
+			if (direction == DMA_TO_DEVICE)
+				binding->tx_vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
 		}
 
 		virtual += len;
@@ -311,6 +332,9 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	gen_pool_for_each_chunk(binding->chunk_pool,
 				net_devmem_dmabuf_free_chunk_owner, NULL);
 	gen_pool_destroy(binding->chunk_pool);
+
+	if (direction == DMA_TO_DEVICE)
+		kvfree(binding->tx_vec);
 err_unmap:
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
 					  DMA_FROM_DEVICE);
@@ -325,6 +349,21 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
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
 void net_devmem_get_net_iov(struct net_iov *niov)
 {
 	net_devmem_dmabuf_binding_get(net_devmem_iov_binding(niov));
@@ -335,6 +374,53 @@ void net_devmem_put_net_iov(struct net_iov *niov)
 	net_devmem_dmabuf_binding_put(net_devmem_iov_binding(niov));
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
index 946f2e015746..a8b79c0e01b3 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -48,6 +48,12 @@ struct net_devmem_dmabuf_binding {
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
@@ -66,12 +72,15 @@ struct dmabuf_genpool_chunk_owner {
 
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
 
 static inline struct dmabuf_genpool_chunk_owner *
 net_devmem_iov_to_chunk_owner(const struct net_iov *niov)
@@ -100,10 +109,10 @@ static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
 	       ((unsigned long)net_iov_idx(niov) << PAGE_SHIFT);
 }
 
-static inline void
+static inline bool
 net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
 {
-	refcount_inc(&binding->ref);
+	return refcount_inc_not_zero(&binding->ref);
 }
 
 static inline void
@@ -123,6 +132,11 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
 
 bool net_is_devmem_iov(struct net_iov *niov);
+struct net_devmem_dmabuf_binding *
+net_devmem_get_binding(struct sock *sk, unsigned int dmabuf_id);
+struct net_iov *
+net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding, size_t addr,
+		       size_t *off, size_t *size);
 
 #else
 struct net_devmem_dmabuf_binding;
@@ -147,11 +161,17 @@ __net_devmem_dmabuf_binding_free(struct net_devmem_dmabuf_binding *binding)
 
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
@@ -190,6 +210,19 @@ static inline bool net_is_devmem_iov(struct net_iov *niov)
 {
 	return false;
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
index 73420edd3f1f..1faa2cf4057f 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -872,7 +872,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, info->extack);
+	binding = net_devmem_bind_dmabuf(netdev, DMA_FROM_DEVICE, dmabuf_fd,
+					 info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock;
@@ -929,10 +930,67 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
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
+	sock_binding_list = genl_sk_priv_get(&netdev_nl_family,
+					     NETLINK_CB(skb).sk);
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
+err_unlock:
+	rtnl_unlock();
+err_genlmsg_free:
+	nlmsg_free(rsp);
+	return err;
 }
 
 void netdev_nl_sock_priv_init(struct list_head *priv)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 815245d5c36b..7ff68502e752 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1695,7 +1695,8 @@ void mm_unaccount_pinned_pages(struct mmpin *mmp)
 }
 EXPORT_SYMBOL_GPL(mm_unaccount_pinned_pages);
 
-static struct ubuf_info *msg_zerocopy_alloc(struct sock *sk, size_t size)
+static struct ubuf_info *msg_zerocopy_alloc(struct sock *sk, size_t size,
+					    bool devmem)
 {
 	struct ubuf_info_msgzc *uarg;
 	struct sk_buff *skb;
@@ -1710,7 +1711,7 @@ static struct ubuf_info *msg_zerocopy_alloc(struct sock *sk, size_t size)
 	uarg = (void *)skb->cb;
 	uarg->mmp.user = NULL;
 
-	if (mm_account_pinned_pages(&uarg->mmp, size)) {
+	if (likely(!devmem) && mm_account_pinned_pages(&uarg->mmp, size)) {
 		kfree_skb(skb);
 		return NULL;
 	}
@@ -1733,7 +1734,7 @@ static inline struct sk_buff *skb_from_uarg(struct ubuf_info_msgzc *uarg)
 }
 
 struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
-				       struct ubuf_info *uarg)
+				       struct ubuf_info *uarg, bool devmem)
 {
 	if (uarg) {
 		struct ubuf_info_msgzc *uarg_zc;
@@ -1763,7 +1764,8 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
 
 		next = (u32)atomic_read(&sk->sk_zckey);
 		if ((u32)(uarg_zc->id + uarg_zc->len) == next) {
-			if (mm_account_pinned_pages(&uarg_zc->mmp, size))
+			if (likely(!devmem) &&
+			    mm_account_pinned_pages(&uarg_zc->mmp, size))
 				return NULL;
 			uarg_zc->len++;
 			uarg_zc->bytelen = bytelen;
@@ -1778,7 +1780,7 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
 	}
 
 new_alloc:
-	return msg_zerocopy_alloc(sk, size);
+	return msg_zerocopy_alloc(sk, size, devmem);
 }
 EXPORT_SYMBOL_GPL(msg_zerocopy_realloc);
 
@@ -1882,7 +1884,8 @@ EXPORT_SYMBOL_GPL(msg_zerocopy_ubuf_ops);
 
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			     struct msghdr *msg, int len,
-			     struct ubuf_info *uarg)
+			     struct ubuf_info *uarg,
+			     struct net_devmem_dmabuf_binding *binding)
 {
 	int err, orig_len = skb->len;
 
@@ -1901,7 +1904,8 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			return -EEXIST;
 	}
 
-	err = __zerocopy_sg_from_iter(msg, sk, skb, &msg->msg_iter, len);
+	err = __zerocopy_sg_from_iter(msg, sk, skb, &msg->msg_iter, len,
+				      binding);
 	if (err == -EFAULT || (err == -EMSGSIZE && skb->len == orig_len)) {
 		struct sock *save_sk = skb->sk;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 53c7af0038c4..3f9502269b1c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2965,6 +2965,12 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 		if (!sk_set_prio_allowed(sk, *(u32 *)CMSG_DATA(cmsg)))
 			return -EPERM;
 		sockc->priority = *(u32 *)CMSG_DATA(cmsg);
+		break;
+	case SCM_DEVMEM_DMABUF:
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
+			return -EINVAL;
+		sockc->dmabuf_id = *(u32 *)CMSG_DATA(cmsg);
+
 		break;
 	default:
 		return -EINVAL;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index ea7a260bec8a..7d8a5f3fae9b 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1015,7 +1015,8 @@ static int __ip_append_data(struct sock *sk,
 				uarg = msg->msg_ubuf;
 			}
 		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
-			uarg = msg_zerocopy_realloc(sk, length, skb_zcopy(skb));
+			uarg = msg_zerocopy_realloc(sk, length, skb_zcopy(skb),
+						    false);
 			if (!uarg)
 				return -ENOBUFS;
 			extra_uref = !skb_zcopy(skb);	/* only ref on new uarg */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6a8f19a10911..374c275a83b4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1055,6 +1055,7 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 {
+	struct net_devmem_dmabuf_binding *binding = NULL;
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct ubuf_info *uarg = NULL;
 	struct sk_buff *skb;
@@ -1067,6 +1068,16 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 	flags = msg->msg_flags;
 
+	sockc = (struct sockcm_cookie){ .tsflags = READ_ONCE(sk->sk_tsflags),
+					.dmabuf_id = 0 };
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
@@ -1074,7 +1085,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 				zc = MSG_ZEROCOPY;
 		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
 			skb = tcp_write_queue_tail(sk);
-			uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb));
+			uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb),
+						    !!sockc.dmabuf_id);
 			if (!uarg) {
 				err = -ENOBUFS;
 				goto out_err;
@@ -1083,12 +1095,27 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 				zc = MSG_ZEROCOPY;
 			else
 				uarg_to_msgzc(uarg)->zerocopy = 0;
+
+			if (sockc.dmabuf_id) {
+				binding = net_devmem_get_binding(sk, sockc.dmabuf_id);
+				if (IS_ERR(binding)) {
+					err = PTR_ERR(binding);
+					binding = NULL;
+					goto out_err;
+				}
+			}
 		}
 	} else if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES) && size) {
 		if (sk->sk_route_caps & NETIF_F_SG)
 			zc = MSG_SPLICE_PAGES;
 	}
 
+	if (sockc.dmabuf_id &&
+	    (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
+		err = -EINVAL;
+		goto out_err;
+	}
+
 	if (unlikely(flags & MSG_FASTOPEN ||
 		     inet_test_bit(DEFER_CONNECT, sk)) &&
 	    !tp->repair) {
@@ -1127,15 +1154,6 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		/* 'common' sending to sendq */
 	}
 
-	sockc = (struct sockcm_cookie) { .tsflags = READ_ONCE(sk->sk_tsflags)};
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
 
@@ -1252,7 +1270,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 					goto wait_for_space;
 			}
 
-			err = skb_zerocopy_iter_stream(sk, skb, msg, copy, uarg);
+			err = skb_zerocopy_iter_stream(sk, skb, msg, copy, uarg,
+						       binding);
 			if (err == -EMSGSIZE || err == -EEXIST) {
 				tcp_mark_push(tp, skb);
 				goto new_segment;
@@ -1333,6 +1352,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	/* msg->msg_ubuf is pinned by the caller so we don't take extra refs */
 	if (uarg && !msg->msg_ubuf)
 		net_zcopy_put(uarg);
+	if (binding)
+		net_devmem_dmabuf_binding_put(binding);
 	return copied + copied_syn;
 
 do_error:
@@ -1350,6 +1371,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		sk->sk_write_space(sk);
 		tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LIMITED);
 	}
+	if (binding)
+		net_devmem_dmabuf_binding_put(binding);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(tcp_sendmsg_locked);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index d577bf2f3053..e9e752f08f87 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1523,7 +1523,8 @@ static int __ip6_append_data(struct sock *sk,
 				uarg = msg->msg_ubuf;
 			}
 		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
-			uarg = msg_zerocopy_realloc(sk, length, skb_zcopy(skb));
+			uarg = msg_zerocopy_realloc(sk, length, skb_zcopy(skb),
+						    false);
 			if (!uarg)
 				return -ENOBUFS;
 			extra_uref = !skb_zcopy(skb);	/* only ref on new uarg */
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 7f7de6d88096..6e7b727c781c 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -87,7 +87,7 @@ static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
 
 		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
 					    iter->count,
-					    NULL);
+					    NULL, false);
 		if (!uarg)
 			return -1;
 
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
2.48.1.601.g30ceb7b040-goog


