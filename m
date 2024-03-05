Return-Path: <linux-kselftest+bounces-5875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0798712FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 03:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3F11F250D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 02:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00407EEF3;
	Tue,  5 Mar 2024 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RP0+u7X1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627BF7E0EA
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Mar 2024 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604143; cv=none; b=S8v5iOEJe0JUcO+DidFjEDveFKNukDeoc3dfxiWCdoEz/CzsQB/vkjYYFgTsdvEaRnTxwK1uWq8ops715CsXZB8xbwP8h5WtH8lpxFX2jIwbshx5HCHzOmOWDpF9fRfwYPKIme4POer5wxS8yEd4cCkr9zX0DgWoSNyq9reFgbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604143; c=relaxed/simple;
	bh=CBkia3F06CuPcVqYc1E2oaD9qB4csiiy6tPKTs3axrc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VWcwiRd8H9UX/qCj6OBOKrueq9Ow6OPcGklsVVIFvxweUCreIkx4/rNfoVZZgUnSkJXkomEReUF1LBujEaNSYQSK61X5eFeWLQtOcpcHGLKz8bqMRQMBuajxLRlB2RomDmiC3VPoPImKo+7MQGKfbIAxJat0AWmrOD/c6sqaoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RP0+u7X1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608e4171382so67829767b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Mar 2024 18:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709604137; x=1710208937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=byPVwM06Y0oEPlUZgHka14Nm3J9bKSTxMh+j9bVfhME=;
        b=RP0+u7X1RbgJrrk7oCN6yxZeqbm6dSTpERpzE4b5pziQub90+TQtTF13kSLgJC90RU
         A3L0EL/2Llgrt8yh1wg4yzpqFZnESLLBJ0JckNieEFXigR947T++AP6ErLvKW2dTcDGD
         dKfjLYPNCqDCjZzsm23HBokKvPIVIgOOEWP5YcF8Z4TDsWNiluTrKYMsWM+uBHcHZ7gI
         jEywNiHmky3GMOyPhvE2v+dEy0LqvWvV8QV3wj6Y3egOytlAmpFVPRhPdtbR/D3k4vys
         7Ai66M+qPn3iUzbuRD1EJB23eV20A/6nIn0hYODfoZIzQwedwUzdsMYpd/Ti365W03ar
         Dv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604137; x=1710208937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byPVwM06Y0oEPlUZgHka14Nm3J9bKSTxMh+j9bVfhME=;
        b=EOxZA9SmqxYNCgHif9sugeoSGhtvNNiA1PCdOYrA2R0evOjJSuntJBBcfP9KoM2INT
         szSJ1HHf6Jx6ESOP2RUnTCbQs4AuvvrJUNU/O3XWi0SqG5n688AWEOUCsDrk9m8tKpfS
         RRfWgwcur1gO0/LNvmuROkR74q/emOnmUWQkvdL01jqirwN6ihxCvlXSvxCyG+BYcMiK
         ugrnoNX/NGf3EfjP/yiHhNZky/oH/fU3CwTncB0IdFmH1MnbcV8c1Ssv4nz/3CiIrJxV
         KrTM1ac/DVpepdMAgBX1B6pLVGUNMJIuZ7wMujWkOJnWqNvbr2T5KZ/idHbGxpPvBCjm
         E6vg==
X-Forwarded-Encrypted: i=1; AJvYcCXOejIuitmjdKkhCmmRd46IAbJhGA2960cPubf0BhStPZaZ1BreZcjl4bIaOIOml+Fkp1jJTrhGvdFjdWJjZVHZ9yvDZd9RiNiSYbXufyFz
X-Gm-Message-State: AOJu0YwvqPTkOlMS3mN/5zqDIWR9z0fg9LkNeoerjD+KjOErx2bxm3SB
	cMozfs8eV7OUpEBLoXVjB+5ABjBCzUVjvLOtZfINrmoTOdrsGfd4OP4oRZ5YM9oow2+lYYj9++z
	zWYWDERl5RpM3B+CXV9Jsag==
X-Google-Smtp-Source: AGHT+IEoXl0wNdHnbs6D9FyjuWe8y/qyisOWLTyu22a+L//Vxmoz1SXuDH6MSW6bIn4oo2iyEmWJJoNV4OBrBIfN8g==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b614:914c:63cd:3830])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:f0b:b0:dcc:79ab:e522 with
 SMTP id et11-20020a0569020f0b00b00dcc79abe522mr463378ybb.11.1709604137118;
 Mon, 04 Mar 2024 18:02:17 -0800 (PST)
Date: Mon,  4 Mar 2024 18:01:44 -0800
In-Reply-To: <20240305020153.2787423-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305020153.2787423-10-almasrymina@google.com>
Subject: [RFC PATCH net-next v6 09/15] memory-provider: dmabuf devmem memory provider
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
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
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
 include/net/netmem.h            | 14 ++++++
 include/net/page_pool/helpers.h | 21 +++++++++
 include/net/page_pool/types.h   |  2 +
 net/core/devmem.c               | 82 +++++++++++++++++++++++++++++++++
 net/core/page_pool.c            | 35 ++++++--------
 5 files changed, 132 insertions(+), 22 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 8699788d587d..a2de9411025d 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -127,6 +127,20 @@ static inline struct page *netmem_to_page(netmem_ref netmem)
 	return (__force struct page *)netmem;
 }
 
+static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
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
index c6a55eddefae..00682b4de6e8 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -453,4 +453,25 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
+static inline void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
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
index e29e77f7934e..096cd2455b2c 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -136,6 +136,8 @@ struct memory_provider_ops {
 	bool (*release_page)(struct page_pool *pool, netmem_ref netmem);
 };
 
+extern const struct memory_provider_ops dmabuf_devmem_ops;
+
 struct page_pool {
 	struct page_pool_params_fast p;
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 57d3a1f223ef..3ced312f7860 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -329,3 +329,85 @@ int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 	return err;
 }
 #endif
+
+/*** "Dmabuf devmem memory provider" ***/
+
+static int mp_dmabuf_devmem_init(struct page_pool *pool)
+{
+	struct netdev_dmabuf_binding *binding = pool->mp_priv;
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
+	netdev_dmabuf_binding_get(binding);
+	return 0;
+}
+
+static netmem_ref mp_dmabuf_devmem_alloc_pages(struct page_pool *pool,
+					       gfp_t gfp)
+{
+	struct netdev_dmabuf_binding *binding = pool->mp_priv;
+	netmem_ref netmem;
+	struct net_iov *niov;
+	dma_addr_t dma_addr;
+
+	niov = netdev_alloc_dmabuf(binding);
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
+	netdev_free_dmabuf(niov);
+	return 0;
+}
+
+static void mp_dmabuf_devmem_destroy(struct page_pool *pool)
+{
+	struct netdev_dmabuf_binding *binding = pool->mp_priv;
+
+	netdev_dmabuf_binding_put(binding);
+}
+
+static bool mp_dmabuf_devmem_release_page(struct page_pool *pool,
+					  netmem_ref netmem)
+{
+	WARN_ON_ONCE(!netmem_is_net_iov(netmem));
+	WARN_ON_ONCE(atomic_long_read(netmem_get_pp_ref_count_ref(netmem))
+			!= 1);
+
+	page_pool_clear_pp_info(netmem);
+
+	netdev_free_dmabuf(netmem_to_net_iov(netmem));
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
index 22e3d439da18..2cee7d9f6ca6 100644
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
@@ -178,6 +182,7 @@ static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params,
 			  int cpuid)
 {
+	struct netdev_dmabuf_binding *binding = NULL;
 	unsigned int ring_qsize = 1024; /* Default */
 	int err;
 
@@ -251,6 +256,14 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
+	if (pool->p.queue)
+		binding = READ_ONCE(pool->p.queue->binding);
+
+	if (binding) {
+		pool->mp_ops = &dmabuf_devmem_ops;
+		pool->mp_priv = binding;
+	}
+
 	if (pool->mp_ops) {
 		err = pool->mp_ops->init(pool);
 		if (err) {
@@ -444,28 +457,6 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
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
2.44.0.rc1.240.g4c46232300-goog


