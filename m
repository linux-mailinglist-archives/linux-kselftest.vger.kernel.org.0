Return-Path: <linux-kselftest+bounces-6683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EB388D1ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 23:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BAC1F80F09
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 22:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BCF1422AB;
	Tue, 26 Mar 2024 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vj8MGMv2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF91411DF
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493478; cv=none; b=OzcXvv6hTwJiD5CNcj+dFIh+qLEUOIssFfKnM4O2/fQ2YGvd6vaYOEMylsrwgAEksqa+qFO/H/eQpcZxLatFJQXLJSSromWJNUr5C61l/UsMtAcK+w2ZMg8K26TzrfIuZzYHJRLWyFfk0CfzYt9Zz1My9S6o3qcfuWR8H5ToN5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493478; c=relaxed/simple;
	bh=4bQC0nH2KIvZclmkOqKc19qwUKi/wgQR9JLqL+isVK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VQRgkV7iF7ilAwp4ZOhf9qdo5QUhVQ5l92U1CC0ts6uwQ427R2tP6rsyw9+EmEYwqgynWEyjdO8s0teHqSlWm4P0GBwRJS3YF3mO9vqbBtvW4aRtqGIYZpTXLrN/GlgjlsVXbMCQHyQ+AnFTiYBBwBoXql/Ufm5fZWpr6e+5MRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vj8MGMv2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so11392801276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 15:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711493473; x=1712098273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F350dI+skgJYiK+XCvsY0v/XAn+ornEyKgo6nGy2INk=;
        b=Vj8MGMv2hFuqYY4HXpxPLvfnKzc73vb+zFHwCc8s7aP2t0P5vRhAWUZ1YVp4xGVyQD
         2w53+0lgt3qyHO3H/ChqQkTNT0LA1Weovpd1FBq8zc/Q6KnPV5jJpyJmYdlP+EIegDm3
         xYT8UPinMtZ8V6KVB96JFTMT1igULWUJDfeAlXYVVQ2MH8+tXwMlENMK45uigCSpiu7v
         itPxRDo4fA8pGsPfezlTRO74hV4iYvGv4SdAbELoY65L2SVHfh3OrYnNXsKhel5lqifI
         1LgZTuBOTmgCIHXpCAWLd+87tyD8JkAVMB8y3zTFFvC4mspkRWsd7d/jDldmtggYyB7D
         axog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711493473; x=1712098273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F350dI+skgJYiK+XCvsY0v/XAn+ornEyKgo6nGy2INk=;
        b=wCBjbOiKfQnojN5MoOpR3g+4EHWC7PCOqSle/i8SnPc5onXcV2nAdA0hEkKRus3WQB
         lPW+bAYYOZbg1hT09h07Rai53Y3X24lUKEqfLP9wGofMWU++xGaFwnrKpnKgjYmhts7l
         ZrqqrJRp7V+iZNabn+brko17vaAoM7LaZRMEtMz41bqr9GKb7bfZv8jswB5Gq7YSBMgz
         /gv/VVCLa8+KrpLZvF0W87fEAsKRjxvcTWuQZpgY02+bIhnkV35mCpb+MORPYOWK/1dp
         QXWQ55rQBFlyX/eH+qgC5O8idAdxr0GrHPLRoEL44jPFb1KKL5rpFffdaAZtJw3W3a90
         9dgg==
X-Forwarded-Encrypted: i=1; AJvYcCXuPXH3r69b6g7MFELCKJgg9RFaqEWC5v8TxbgjibO2Dgu5ZiGuOzpdPRrcz84+I3eu/w9ouUl+HuWNHkSiMDisZfyYklVhxbi59w9npn+T
X-Gm-Message-State: AOJu0YwPISceuLIilx8+44PFeAE9xOb5Dl/RatPSpNjFhvfbPn/EP59x
	viEtQN1g81tDaucvOymKZfj28QtUw0lD8/aM/agZns1hiCuvSYaEnXkQem5+G3H+yVD7lrD44n9
	juv/RcRcZnByuPvAIQAknaA==
X-Google-Smtp-Source: AGHT+IEC9AB/nJ/GfN/wSDBZsiNcveQxlpicHlMmMb9ORnhYDXmhNgoiDBd2dgW3yIydIS8UtvtZfJFANbtBPuNMUQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:c51e:bdd0:7cc8:695c])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:154b:b0:dc9:5ef8:2b2d with
 SMTP id r11-20020a056902154b00b00dc95ef82b2dmr3472795ybu.4.1711493472836;
 Tue, 26 Mar 2024 15:51:12 -0700 (PDT)
Date: Tue, 26 Mar 2024 15:50:39 -0700
In-Reply-To: <20240326225048.785801-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326225048.785801-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326225048.785801-9-almasrymina@google.com>
Subject: [RFC PATCH net-next v7 08/14] memory-provider: dmabuf devmem memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement a memory provider that allocates dmabuf devmem in the form of
net_iov.

The provider receives a reference to the struct netdev_dmabuf_binding
via the pool->mp_priv pointer. The driver needs to set this pointer for
the provider in the net_iov.

The provider obtains a reference on the netdev_dmabuf_binding which
guarantees the binding and the underlying mapping remains alive until
the provider is destroyed.

Usage of PP_FLAG_DMA_MAP is required for this memory provide such that
the page_pool can provide the driver with the dma-addrs of the devmem.

Support for PP_FLAG_DMA_SYNC_DEV is omitted for simplicity & p.order !=
0.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v6:
- refactor new memory provider functions into net/core/devmem.c (Pavel)

v2:
- Disable devmem for p.order != 0

v1:
- static_branch check in page_is_page_pool_iov() (Willem & Paolo).
- PP_DEVMEM -> PP_IOV (David).
- Require PP_FLAG_DMA_MAP (Jakub).

---
 include/net/netmem.h            | 15 ++++++
 include/net/page_pool/helpers.h | 22 +++++++++
 include/net/page_pool/types.h   |  2 +
 net/core/devmem.c               | 82 +++++++++++++++++++++++++++++++++
 net/core/page_pool.c            | 38 +++++++--------
 5 files changed, 137 insertions(+), 22 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 74eeaa34883e..34aa1c80c1ca 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -126,6 +126,21 @@ static inline struct page *netmem_to_page(netmem_ref netmem)
 	return (__force struct page *)netmem;
 }
 
+static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return (struct net_iov *)((__force unsigned long)netmem &
+					  ~NET_IOV);
+
+	DEBUG_NET_WARN_ON_ONCE(true);
+	return NULL;
+}
+
+static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
+{
+	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
+}
+
 static inline netmem_ref page_to_netmem(struct page *page)
 {
 	return (__force netmem_ref)page;
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index c6a55eddefae..eb736506c3ce 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -453,4 +453,26 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
+static inline void page_pool_set_pp_info(struct page_pool *pool,
+					 netmem_ref netmem)
+{
+	netmem_set_pp(netmem, pool);
+	netmem_or_pp_magic(netmem, PP_SIGNATURE);
+
+	/* Ensuring all pages have been split into one fragment initially:
+	 * page_pool_set_pp_info() is only called once for every page when it
+	 * is allocated from the page allocator and page_pool_fragment_page()
+	 * is dirtying the same cache line as the page->pp_magic above, so
+	 * the overhead is negligible.
+	 */
+	page_pool_fragment_netmem(netmem, 1);
+	if (pool->has_init_callback)
+		pool->slow.init_callback(netmem, pool->slow.init_arg);
+}
+
+static inline void page_pool_clear_pp_info(netmem_ref netmem)
+{
+	netmem_clear_pp_magic(netmem);
+	netmem_set_pp(netmem, NULL);
+}
 #endif /* _NET_PAGE_POOL_HELPERS_H */
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index f04af1613f59..5b58c9e185a4 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -141,6 +141,8 @@ struct pp_memory_provider_params {
 	void *mp_priv;
 };
 
+extern const struct memory_provider_ops dmabuf_devmem_ops;
+
 struct page_pool {
 	struct page_pool_params_fast p;
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 84e88955ff2d..01337de7d6a4 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -341,3 +341,85 @@ int net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	return err;
 }
 #endif
+
+/*** "Dmabuf devmem memory provider" ***/
+
+static int mp_dmabuf_devmem_init(struct page_pool *pool)
+{
+	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+
+	if (!binding)
+		return -EINVAL;
+
+	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
+		return -EOPNOTSUPP;
+
+	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+		return -EOPNOTSUPP;
+
+	if (pool->p.order != 0)
+		return -E2BIG;
+
+	net_devmem_dmabuf_binding_get(binding);
+	return 0;
+}
+
+static netmem_ref mp_dmabuf_devmem_alloc_pages(struct page_pool *pool,
+					       gfp_t gfp)
+{
+	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+	netmem_ref netmem;
+	struct net_iov *niov;
+	dma_addr_t dma_addr;
+
+	niov = net_devmem_alloc_dmabuf(binding);
+	if (!niov)
+		return 0;
+
+	dma_addr = net_iov_dma_addr(niov);
+
+	netmem = net_iov_to_netmem(niov);
+
+	page_pool_set_pp_info(pool, netmem);
+
+	if (page_pool_set_dma_addr_netmem(netmem, dma_addr))
+		goto err_free;
+
+	pool->pages_state_hold_cnt++;
+	trace_page_pool_state_hold(pool, netmem, pool->pages_state_hold_cnt);
+	return netmem;
+
+err_free:
+	net_devmem_free_dmabuf(niov);
+	return 0;
+}
+
+static void mp_dmabuf_devmem_destroy(struct page_pool *pool)
+{
+	struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
+
+	net_devmem_dmabuf_binding_put(binding);
+}
+
+static bool mp_dmabuf_devmem_release_page(struct page_pool *pool,
+					  netmem_ref netmem)
+{
+	WARN_ON_ONCE(!netmem_is_net_iov(netmem));
+	WARN_ON_ONCE(atomic_long_read(netmem_get_pp_ref_count_ref(netmem)) !=
+		     1);
+
+	page_pool_clear_pp_info(netmem);
+
+	net_devmem_free_dmabuf(netmem_to_net_iov(netmem));
+
+	/* We don't want the page pool put_page()ing our net_iovs. */
+	return false;
+}
+
+const struct memory_provider_ops dmabuf_devmem_ops = {
+	.init			= mp_dmabuf_devmem_init,
+	.destroy		= mp_dmabuf_devmem_destroy,
+	.alloc_pages		= mp_dmabuf_devmem_alloc_pages,
+	.release_page		= mp_dmabuf_devmem_release_page,
+};
+EXPORT_SYMBOL(dmabuf_devmem_ops);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index c7bffd08218b..a0544b680e8a 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -12,6 +12,7 @@
 
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
+#include <net/netdev_rx_queue.h>
 
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -20,12 +21,15 @@
 #include <linux/poison.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/genalloc.h>
+#include <net/devmem.h>
 
 #include <trace/events/page_pool.h>
 
 #include "page_pool_priv.h"
 
 DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+EXPORT_SYMBOL(page_pool_mem_providers);
 
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
@@ -178,7 +182,9 @@ static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params,
 			  int cpuid)
 {
+	const struct memory_provider_ops *mp_ops = NULL;
 	unsigned int ring_qsize = 1024; /* Default */
+	void *mp_priv = NULL;
 	int err;
 
 	memcpy(&pool->p, &params->fast, sizeof(pool->p));
@@ -251,6 +257,16 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
+	if (pool->p.queue) {
+		mp_ops = READ_ONCE(pool->p.queue->mp_params.mp_ops);
+		mp_priv = READ_ONCE(pool->p.queue->mp_params.mp_priv);
+	}
+
+	if (mp_ops && mp_priv) {
+		pool->mp_ops = mp_ops;
+		pool->mp_priv = mp_priv;
+	}
+
 	if (pool->mp_ops) {
 		err = pool->mp_ops->init(pool);
 		if (err) {
@@ -444,28 +460,6 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 	return false;
 }
 
-static void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
-{
-	netmem_set_pp(netmem, pool);
-	netmem_or_pp_magic(netmem, PP_SIGNATURE);
-
-	/* Ensuring all pages have been split into one fragment initially:
-	 * page_pool_set_pp_info() is only called once for every page when it
-	 * is allocated from the page allocator and page_pool_fragment_page()
-	 * is dirtying the same cache line as the page->pp_magic above, so
-	 * the overhead is negligible.
-	 */
-	page_pool_fragment_netmem(netmem, 1);
-	if (pool->has_init_callback)
-		pool->slow.init_callback(netmem, pool->slow.init_arg);
-}
-
-static void page_pool_clear_pp_info(netmem_ref netmem)
-{
-	netmem_clear_pp_magic(netmem);
-	netmem_set_pp(netmem, NULL);
-}
-
 static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 						 gfp_t gfp)
 {
-- 
2.44.0.396.g6e790dbe36-goog


