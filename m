Return-Path: <linux-kselftest+bounces-16870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B1B966DDE
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 02:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5A31C224C4
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 00:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7845A46522;
	Sat, 31 Aug 2024 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0bjCWzW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B652B9D7
	for <linux-kselftest@vger.kernel.org>; Sat, 31 Aug 2024 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725065018; cv=none; b=aK7kx160dIcnlGLg9FUka1/koXABgnIhxNUlMx9Xopjkjb6zN2eMGkMOGVLmPXWHGuYpfagLvbfsEFd8ZjqMSOxeeNMQD8EB4GHtlX+xDAOqSAAfM94utn28DHSVIGCHC6J2IovLoyskT8zCjfjuMr4I9eV2efo+94cFfRVNzNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725065018; c=relaxed/simple;
	bh=ncnSQGHMHtR1njSdvvuSJBbdOHsUVUyYKA8idT8ytfk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PzvzREWHapuDYzI5hsziKYiXoy1mJ+70JYJemVRePeKjI2VIwY0qcF46dXyEXVDgTmaKB6b1vOomLsXM975AKkF9h+hATaYJc8pCCAQ2GNYgoWvNqvfM1DGLjYAKqfhRBalljnPT0BAGpoKhgIq4wiUMn+n8RoRNKk9ObZ9r7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0bjCWzW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-69a0536b23aso47812497b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 17:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725065011; x=1725669811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt8VQbg/IyDrLaYuaLsX/ErEComlcrcLp21qg9SiU6M=;
        b=i0bjCWzWQrl9di2e44OANBRpyj/tLrmsslQYBsumNzjucjTXup+LXri5bpHgXsT6Jy
         onU6zPfSu6yykSkjITL9y8LVuSc/mE7aATTGsgNWSsLpKTdXW1fp8+VjWzBLt+sZAWT+
         lae0GBsei/23GI1DfiCeIe419Eif+HV4N6LzOC9bojfbPjoQotLfM2EOYBw+cf6sxCkf
         DObbqaT7JHd+hdNcv99nDfkmhVRxzUPh3YnHmdl9eFNUiPJFc8KfYNl3ZuQOuupsVHwq
         2KskP38+S3E7WZ5JJRQXnvkbWUYFv4yPdSzxZxoTAoDhPz4rSLLMznAGxo1BBJwREJso
         o/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725065011; x=1725669811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt8VQbg/IyDrLaYuaLsX/ErEComlcrcLp21qg9SiU6M=;
        b=PPbP836EqRpCllZudTQ7vB+DZQdvNJuKBB+nwMlELxQ29eihFJVzuIZUolY/DFUNR4
         uj7Xu9dGmlcljSWRxzMyfyp03LCmcQGjwGd+kJCrNFfP7lHGl+J/sA7n9n5NCj0Olw2M
         hwUcnkJNczU8VDMl9S1XYYnuHRpz/+IAQnYLBwLPJ6Vv7MorvmbN2UQLLLoloiHpWDw4
         bhBGI8+hbXeRoYHi7XiRnrE4nQau0h26kB6dqg244r+rf5gVHaItkEpSKrHypg/4HwqN
         Y+RLD18rUIW6oF7cl6DTjJg0cezVAI4Kw2BaO38dvStvpyF9G5HrFTTkqZcWz12qHdi1
         l19A==
X-Forwarded-Encrypted: i=1; AJvYcCUNJjUjwPfRcV8haPvClRGsXjGan04TNeYWak1NDn9pNG7ArAmZ0lAK1HZ+0qleG47tettXet/z2qsBrJ08Qiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0wkypKYPX+mm90WIyAJgQ5iJMSeKawZsgU3j7ZT+2pjbdqBig
	YKk1NjwqqMbh8iGJ0j+CMgOy+MXDz93aL4FtpnT7wwwsk+gfi6mGn7O8/kveveIuXWMbN8ykq3X
	8/M2FV7FDp+UaeIcirOnnWw==
X-Google-Smtp-Source: AGHT+IH0v+Lk/7bRc7Yo/TbUA0Vy9P+A0jzGq8M8Es2kI0GBN9TtAqXkY082vvzQu+k3SufM4DFvbN30Ws6wBWCRxA==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a5b:407:0:b0:e0b:f93:fe8c with SMTP id
 3f1490d57ef6-e1a79ce6cd9mr202342276.0.1725065011607; Fri, 30 Aug 2024
 17:43:31 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:43:05 +0000
In-Reply-To: <20240831004313.3713467-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831004313.3713467-1-almasrymina@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831004313.3713467-6-almasrymina@google.com>
Subject: [PATCH net-next v24 05/13] page_pool: devmem support
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Convert netmem to be a union of struct page and struct netmem. Overload
the LSB of struct netmem* to indicate that it's a net_iov, otherwise
it's a page.

Currently these entries in struct page are rented by the page_pool and
used exclusively by the net stack:

struct {
	unsigned long pp_magic;
	struct page_pool *pp;
	unsigned long _pp_mapping_pad;
	unsigned long dma_addr;
	atomic_long_t pp_ref_count;
};

Mirror these (and only these) entries into struct net_iov and implement
netmem helpers that can access these common fields regardless of
whether the underlying type is page or net_iov.

Implement checks for net_iov in netmem helpers which delegate to mm
APIs, to ensure net_iov are never passed to the mm stack.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>

---

v23:
- Fix comment on netmem_is_perf_nid (Jakub)

v19:
- Move page_pool_set_dma_addr(_netmem) to page_pool_priv.h
- Don't reset niov dma_addr on allocation/free. Instead, it's set once
  when the binding happens and it never changes (Jakub)

v17:
- Rename netmem_to_pfn to netmem_pfn_trace (Jakub)
- Move some low level netmem helpers to netmem_priv.h (Jakub).

v13:
- Move NET_IOV dependent changes to this patch.
- Fixed comment (Pavel)
- Applied Reviewed-by from Pavel.

v9: https://lore.kernel.org/netdev/20240403002053.2376017-8-almasrymina@google.com/
- Remove CONFIG checks in netmem_is_net_iov() (Pavel/David/Jens)

v7:
- Remove static_branch_unlikely from netmem_to_net_iov(). We're getting
  better results from the fast path in bench_page_pool_simple tests
  without the static_branch_unlikely, and the addition of
  static_branch_unlikely doesn't improve performance of devmem TCP.

  Additionally only check netmem_to_net_iov() if
  CONFIG_DMA_SHARED_BUFFER is enabled, otherwise dmabuf net_iovs cannot
  exist anyway.

  net-next base: 8 cycle fast path.
  with static_branch_unlikely: 10 cycle fast path.
  without static_branch_unlikely: 9 cycle fast path.
  CONFIG_DMA_SHARED_BUFFER disabled: 8 cycle fast path as baseline.

  Performance of devmem TCP is at 95% line rate is regardless of
  static_branch_unlikely or not.

v6:
- Rebased on top of the merged netmem_ref type.
- Rebased on top of the merged skb_pp_frag_ref() changes.

v5:
- Use netmem instead of page* with LSB set.
- Use pp_ref_count for refcounting net_iov.
- Removed many of the custom checks for netmem.

v1:
- Disable fragmentation support for iov properly.
- fix napi_pp_put_page() path (Yunsheng).
- Use pp_frag_count for devmem refcounting.

Cc: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>

---
 include/net/netmem.h             | 122 +++++++++++++++++++++++++++++--
 include/net/page_pool/helpers.h  |  39 ++--------
 include/trace/events/page_pool.h |  12 +--
 net/core/devmem.c                |   8 ++
 net/core/netmem_priv.h           |  31 ++++++++
 net/core/page_pool.c             |  25 ++++---
 net/core/page_pool_priv.h        |  26 +++++++
 net/core/skbuff.c                |  23 +++---
 8 files changed, 217 insertions(+), 69 deletions(-)
 create mode 100644 net/core/netmem_priv.h

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 0fbc0999091a..ac6c7945117b 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -9,13 +9,51 @@
 #define _NET_NETMEM_H
 
 #include <net/devmem.h>
+#include <net/net_debug.h>
 
 /* net_iov */
 
+DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
+
+/*  We overload the LSB of the struct page pointer to indicate whether it's
+ *  a page or net_iov.
+ */
+#define NET_IOV 0x01UL
+
 struct net_iov {
+	unsigned long __unused_padding;
+	unsigned long pp_magic;
+	struct page_pool *pp;
 	struct dmabuf_genpool_chunk_owner *owner;
+	unsigned long dma_addr;
+	atomic_long_t pp_ref_count;
 };
 
+/* These fields in struct page are used by the page_pool and net stack:
+ *
+ *	struct {
+ *		unsigned long pp_magic;
+ *		struct page_pool *pp;
+ *		unsigned long _pp_mapping_pad;
+ *		unsigned long dma_addr;
+ *		atomic_long_t pp_ref_count;
+ *	};
+ *
+ * We mirror the page_pool fields here so the page_pool can access these fields
+ * without worrying whether the underlying fields belong to a page or net_iov.
+ *
+ * The non-net stack fields of struct page are private to the mm stack and must
+ * never be mirrored to net_iov.
+ */
+#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
+	static_assert(offsetof(struct page, pg) == \
+		      offsetof(struct net_iov, iov))
+NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
+NET_IOV_ASSERT_OFFSET(pp, pp);
+NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
+NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
+#undef NET_IOV_ASSERT_OFFSET
+
 static inline struct dmabuf_genpool_chunk_owner *
 net_iov_owner(const struct net_iov *niov)
 {
@@ -46,20 +84,37 @@ net_iov_binding(const struct net_iov *niov)
  */
 typedef unsigned long __bitwise netmem_ref;
 
+static inline bool netmem_is_net_iov(const netmem_ref netmem)
+{
+	return (__force unsigned long)netmem & NET_IOV;
+}
+
 /* This conversion fails (returns NULL) if the netmem_ref is not struct page
  * backed.
- *
- * Currently struct page is the only possible netmem, and this helper never
- * fails.
  */
 static inline struct page *netmem_to_page(netmem_ref netmem)
 {
+	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
+		return NULL;
+
 	return (__force struct page *)netmem;
 }
 
-/* Converting from page to netmem is always safe, because a page can always be
- * a netmem.
- */
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
@@ -67,17 +122,70 @@ static inline netmem_ref page_to_netmem(struct page *page)
 
 static inline int netmem_ref_count(netmem_ref netmem)
 {
+	/* The non-pp refcount of net_iov is always 1. On net_iov, we only
+	 * support pp refcounting which uses the pp_ref_count field.
+	 */
+	if (netmem_is_net_iov(netmem))
+		return 1;
+
 	return page_ref_count(netmem_to_page(netmem));
 }
 
-static inline unsigned long netmem_to_pfn(netmem_ref netmem)
+static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
 {
+	if (netmem_is_net_iov(netmem))
+		return 0;
+
 	return page_to_pfn(netmem_to_page(netmem));
 }
 
+static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
+{
+	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
+}
+
+static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
+{
+	return __netmem_clear_lsb(netmem)->pp;
+}
+
+static inline atomic_long_t *netmem_get_pp_ref_count_ref(netmem_ref netmem)
+{
+	return &__netmem_clear_lsb(netmem)->pp_ref_count;
+}
+
+static inline bool netmem_is_pref_nid(netmem_ref netmem, int pref_nid)
+{
+	/* NUMA node preference only makes sense if we're allocating
+	 * system memory. Memory providers (which give us net_iovs)
+	 * choose for us.
+	 */
+	if (netmem_is_net_iov(netmem))
+		return true;
+
+	return page_to_nid(netmem_to_page(netmem)) == pref_nid;
+}
+
 static inline netmem_ref netmem_compound_head(netmem_ref netmem)
 {
+	/* niov are never compounded */
+	if (netmem_is_net_iov(netmem))
+		return netmem;
+
 	return page_to_netmem(compound_head(netmem_to_page(netmem)));
 }
 
+static inline void *netmem_address(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return NULL;
+
+	return page_address(netmem_to_page(netmem));
+}
+
+static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
+{
+	return __netmem_clear_lsb(netmem)->dma_addr;
+}
+
 #endif /* _NET_NETMEM_H */
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 2b43a893c619..793e6fd78bc5 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -216,7 +216,7 @@ page_pool_get_dma_dir(const struct page_pool *pool)
 
 static inline void page_pool_fragment_netmem(netmem_ref netmem, long nr)
 {
-	atomic_long_set(&netmem_to_page(netmem)->pp_ref_count, nr);
+	atomic_long_set(netmem_get_pp_ref_count_ref(netmem), nr);
 }
 
 /**
@@ -244,7 +244,7 @@ static inline void page_pool_fragment_page(struct page *page, long nr)
 
 static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
 {
-	struct page *page = netmem_to_page(netmem);
+	atomic_long_t *pp_ref_count = netmem_get_pp_ref_count_ref(netmem);
 	long ret;
 
 	/* If nr == pp_ref_count then we have cleared all remaining
@@ -261,19 +261,19 @@ static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
 	 * initially, and only overwrite it when the page is partitioned into
 	 * more than one piece.
 	 */
-	if (atomic_long_read(&page->pp_ref_count) == nr) {
+	if (atomic_long_read(pp_ref_count) == nr) {
 		/* As we have ensured nr is always one for constant case using
 		 * the BUILD_BUG_ON(), only need to handle the non-constant case
 		 * here for pp_ref_count draining, which is a rare case.
 		 */
 		BUILD_BUG_ON(__builtin_constant_p(nr) && nr != 1);
 		if (!__builtin_constant_p(nr))
-			atomic_long_set(&page->pp_ref_count, 1);
+			atomic_long_set(pp_ref_count, 1);
 
 		return 0;
 	}
 
-	ret = atomic_long_sub_return(nr, &page->pp_ref_count);
+	ret = atomic_long_sub_return(nr, pp_ref_count);
 	WARN_ON(ret < 0);
 
 	/* We are the last user here too, reset pp_ref_count back to 1 to
@@ -282,7 +282,7 @@ static inline long page_pool_unref_netmem(netmem_ref netmem, long nr)
 	 * page_pool_unref_page() currently.
 	 */
 	if (unlikely(!ret))
-		atomic_long_set(&page->pp_ref_count, 1);
+		atomic_long_set(pp_ref_count, 1);
 
 	return ret;
 }
@@ -401,9 +401,7 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
 
 static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
 {
-	struct page *page = netmem_to_page(netmem);
-
-	dma_addr_t ret = page->dma_addr;
+	dma_addr_t ret = netmem_get_dma_addr(netmem);
 
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
 		ret <<= PAGE_SHIFT;
@@ -423,24 +421,6 @@ static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
 	return page_pool_get_dma_addr_netmem(page_to_netmem((struct page *)page));
 }
 
-static inline bool page_pool_set_dma_addr_netmem(netmem_ref netmem,
-						 dma_addr_t addr)
-{
-	struct page *page = netmem_to_page(netmem);
-
-	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
-		page->dma_addr = addr >> PAGE_SHIFT;
-
-		/* We assume page alignment to shave off bottom bits,
-		 * if this "compression" doesn't work we need to drop.
-		 */
-		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
-	}
-
-	page->dma_addr = addr;
-	return false;
-}
-
 /**
  * page_pool_dma_sync_for_cpu - sync Rx page for CPU after it's written by HW
  * @pool: &page_pool the @page belongs to
@@ -463,11 +443,6 @@ static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
 				      page_pool_get_dma_dir(pool));
 }
 
-static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
-{
-	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
-}
-
 static inline bool page_pool_put(struct page_pool *pool)
 {
 	return refcount_dec_and_test(&pool->user_cnt);
diff --git a/include/trace/events/page_pool.h b/include/trace/events/page_pool.h
index 543e54e432a1..31825ed30032 100644
--- a/include/trace/events/page_pool.h
+++ b/include/trace/events/page_pool.h
@@ -57,12 +57,12 @@ TRACE_EVENT(page_pool_state_release,
 		__entry->pool		= pool;
 		__entry->netmem		= (__force unsigned long)netmem;
 		__entry->release	= release;
-		__entry->pfn		= netmem_to_pfn(netmem);
+		__entry->pfn		= netmem_pfn_trace(netmem);
 	),
 
-	TP_printk("page_pool=%p netmem=%p pfn=0x%lx release=%u",
+	TP_printk("page_pool=%p netmem=%p is_net_iov=%lu pfn=0x%lx release=%u",
 		  __entry->pool, (void *)__entry->netmem,
-		  __entry->pfn, __entry->release)
+		  __entry->netmem & NET_IOV, __entry->pfn, __entry->release)
 );
 
 TRACE_EVENT(page_pool_state_hold,
@@ -83,12 +83,12 @@ TRACE_EVENT(page_pool_state_hold,
 		__entry->pool	= pool;
 		__entry->netmem	= (__force unsigned long)netmem;
 		__entry->hold	= hold;
-		__entry->pfn	= netmem_to_pfn(netmem);
+		__entry->pfn	= netmem_pfn_trace(netmem);
 	),
 
-	TP_printk("page_pool=%p netmem=%p pfn=0x%lx hold=%u",
+	TP_printk("page_pool=%p netmem=%p is_net_iov=%lu, pfn=0x%lx hold=%u",
 		  __entry->pool, (void *)__entry->netmem,
-		  __entry->pfn, __entry->hold)
+		  __entry->netmem & NET_IOV, __entry->pfn, __entry->hold)
 );
 
 TRACE_EVENT(page_pool_update_nid,
diff --git a/net/core/devmem.c b/net/core/devmem.c
index ad222d108d37..727e5ee39f30 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -18,6 +18,8 @@
 #include <net/page_pool/helpers.h>
 #include <trace/events/page_pool.h>
 
+#include "page_pool_priv.h"
+
 /* Device memory support */
 
 /* Protected by rtnl_lock() */
@@ -81,6 +83,10 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	index = offset / PAGE_SIZE;
 	niov = &owner->niovs[index];
 
+	niov->pp_magic = 0;
+	niov->pp = NULL;
+	atomic_long_set(&niov->pp_ref_count, 0);
+
 	return niov;
 }
 
@@ -268,6 +274,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 		for (i = 0; i < owner->num_niovs; i++) {
 			niov = &owner->niovs[i];
 			niov->owner = owner;
+			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
+						      net_devmem_get_dma_addr(niov));
 		}
 
 		virtual += len;
diff --git a/net/core/netmem_priv.h b/net/core/netmem_priv.h
new file mode 100644
index 000000000000..7eadb8393e00
--- /dev/null
+++ b/net/core/netmem_priv.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __NETMEM_PRIV_H
+#define __NETMEM_PRIV_H
+
+static inline unsigned long netmem_get_pp_magic(netmem_ref netmem)
+{
+	return __netmem_clear_lsb(netmem)->pp_magic;
+}
+
+static inline void netmem_or_pp_magic(netmem_ref netmem, unsigned long pp_magic)
+{
+	__netmem_clear_lsb(netmem)->pp_magic |= pp_magic;
+}
+
+static inline void netmem_clear_pp_magic(netmem_ref netmem)
+{
+	__netmem_clear_lsb(netmem)->pp_magic = 0;
+}
+
+static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
+{
+	__netmem_clear_lsb(netmem)->pp = pool;
+}
+
+static inline void netmem_set_dma_addr(netmem_ref netmem,
+				       unsigned long dma_addr)
+{
+	__netmem_clear_lsb(netmem)->dma_addr = dma_addr;
+}
+#endif
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2abe6e919224..52659db2d765 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -24,8 +24,11 @@
 
 #include <trace/events/page_pool.h>
 
+#include "netmem_priv.h"
 #include "page_pool_priv.h"
 
+DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
+
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
@@ -358,7 +361,7 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 		if (unlikely(!netmem))
 			break;
 
-		if (likely(page_to_nid(netmem_to_page(netmem)) == pref_nid)) {
+		if (likely(netmem_is_pref_nid(netmem, pref_nid))) {
 			pool->alloc.cache[pool->alloc.count++] = netmem;
 		} else {
 			/* NUMA mismatch;
@@ -454,10 +457,8 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
 
 static void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 {
-	struct page *page = netmem_to_page(netmem);
-
-	page->pp = pool;
-	page->pp_magic |= PP_SIGNATURE;
+	netmem_set_pp(netmem, pool);
+	netmem_or_pp_magic(netmem, PP_SIGNATURE);
 
 	/* Ensuring all pages have been split into one fragment initially:
 	 * page_pool_set_pp_info() is only called once for every page when it
@@ -472,10 +473,8 @@ static void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
 
 static void page_pool_clear_pp_info(netmem_ref netmem)
 {
-	struct page *page = netmem_to_page(netmem);
-
-	page->pp_magic = 0;
-	page->pp = NULL;
+	netmem_clear_pp_magic(netmem);
+	netmem_set_pp(netmem, NULL);
 }
 
 static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
@@ -692,8 +691,9 @@ static bool page_pool_recycle_in_cache(netmem_ref netmem,
 
 static bool __page_pool_page_can_be_recycled(netmem_ref netmem)
 {
-	return page_ref_count(netmem_to_page(netmem)) == 1 &&
-	       !page_is_pfmemalloc(netmem_to_page(netmem));
+	return netmem_is_net_iov(netmem) ||
+	       (page_ref_count(netmem_to_page(netmem)) == 1 &&
+		!page_is_pfmemalloc(netmem_to_page(netmem)));
 }
 
 /* If the page refcnt == 1, this will try to recycle the page.
@@ -728,6 +728,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
 		/* Page found as candidate for recycling */
 		return netmem;
 	}
+
 	/* Fallback/non-XDP mode: API user have elevated refcnt.
 	 *
 	 * Many drivers split up the page into fragments, and some
@@ -949,7 +950,7 @@ static void page_pool_empty_ring(struct page_pool *pool)
 	/* Empty recycle ring */
 	while ((netmem = (__force netmem_ref)ptr_ring_consume_bh(&pool->ring))) {
 		/* Verify the refcnt invariant of cached pages */
-		if (!(page_ref_count(netmem_to_page(netmem)) == 1))
+		if (!(netmem_ref_count(netmem) == 1))
 			pr_crit("%s() page_pool refcnt %d violation\n",
 				__func__, netmem_ref_count(netmem));
 
diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
index 90665d40f1eb..2142caeddb7c 100644
--- a/net/core/page_pool_priv.h
+++ b/net/core/page_pool_priv.h
@@ -3,10 +3,36 @@
 #ifndef __PAGE_POOL_PRIV_H
 #define __PAGE_POOL_PRIV_H
 
+#include <net/page_pool/helpers.h>
+
+#include "netmem_priv.h"
+
 s32 page_pool_inflight(const struct page_pool *pool, bool strict);
 
 int page_pool_list(struct page_pool *pool);
 void page_pool_detached(struct page_pool *pool);
 void page_pool_unlist(struct page_pool *pool);
 
+static inline bool page_pool_set_dma_addr_netmem(netmem_ref netmem,
+						 dma_addr_t addr)
+{
+	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
+		netmem_set_dma_addr(netmem, addr >> PAGE_SHIFT);
+
+		/* We assume page alignment to shave off bottom bits,
+		 * if this "compression" doesn't work we need to drop.
+		 */
+		return addr != (dma_addr_t)netmem_get_dma_addr(netmem)
+				       << PAGE_SHIFT;
+	}
+
+	netmem_set_dma_addr(netmem, addr);
+	return false;
+}
+
+static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
+{
+	return page_pool_set_dma_addr_netmem(page_to_netmem(page), addr);
+}
+
 #endif
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a52638363ea5..d9634ab342cc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -88,6 +88,7 @@
 #include <linux/textsearch.h>
 
 #include "dev.h"
+#include "netmem_priv.h"
 #include "sock_destructor.h"
 
 #ifdef CONFIG_SKB_EXTENSIONS
@@ -920,9 +921,9 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
-static bool is_pp_page(struct page *page)
+static bool is_pp_netmem(netmem_ref netmem)
 {
-	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
+	return (netmem_get_pp_magic(netmem) & ~0x3UL) == PP_SIGNATURE;
 }
 
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
@@ -1020,9 +1021,7 @@ EXPORT_SYMBOL(skb_cow_data_for_xdp);
 #if IS_ENABLED(CONFIG_PAGE_POOL)
 bool napi_pp_put_page(netmem_ref netmem)
 {
-	struct page *page = netmem_to_page(netmem);
-
-	page = compound_head(page);
+	netmem = netmem_compound_head(netmem);
 
 	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
 	 * in order to preserve any existing bits, such as bit 0 for the
@@ -1031,10 +1030,10 @@ bool napi_pp_put_page(netmem_ref netmem)
 	 * and page_is_pfmemalloc() is checked in __page_pool_put_page()
 	 * to avoid recycling the pfmemalloc page.
 	 */
-	if (unlikely(!is_pp_page(page)))
+	if (unlikely(!is_pp_netmem(netmem)))
 		return false;
 
-	page_pool_put_full_netmem(page->pp, page_to_netmem(page), false);
+	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
 
 	return true;
 }
@@ -1061,7 +1060,7 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data)
 static int skb_pp_frag_ref(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo;
-	struct page *head_page;
+	netmem_ref head_netmem;
 	int i;
 
 	if (!skb->pp_recycle)
@@ -1070,11 +1069,11 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
 	shinfo = skb_shinfo(skb);
 
 	for (i = 0; i < shinfo->nr_frags; i++) {
-		head_page = compound_head(skb_frag_page(&shinfo->frags[i]));
-		if (likely(is_pp_page(head_page)))
-			page_pool_ref_page(head_page);
+		head_netmem = netmem_compound_head(shinfo->frags[i].netmem);
+		if (likely(is_pp_netmem(head_netmem)))
+			page_pool_ref_netmem(head_netmem);
 		else
-			page_ref_inc(head_page);
+			page_ref_inc(netmem_to_page(head_netmem));
 	}
 	return 0;
 }
-- 
2.46.0.469.g59c65b2a67-goog


