Return-Path: <linux-kselftest+bounces-17369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7643996EC4E
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 09:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9451B1C22B02
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 07:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3A15821D;
	Fri,  6 Sep 2024 07:42:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936715697A;
	Fri,  6 Sep 2024 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608573; cv=none; b=FaukBjdjnl/l3BydvJjldQ3RxyzQafca+Quml+hUukVFb167aEfXlx+E2J7erkdBc0SFNMlFvsk4d/UxaDCERYLRromu9TPBeeCl+qLKNryIhF9qlf9PHX8OLn6rz7sCbzPxzOayTGpCH5p0eTyZF7ViJGS4l37nv+xoJoUHnjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608573; c=relaxed/simple;
	bh=T6XLUoAFcXSxruwAYQmBy6F0E6rBy/538u2+YcV2SNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQq/imfsODMB3nSjkkEfUiX4xMtWYxidAbZ41+LaCaS8E7dxHpKHlJNCdDZM1uKBvT0jFyqg0e3Fm4NTZmucXgFwAMB0WLTVAOB8W1H8bTRj4FnZ166qjy7+Cxz19wos2se6rpJLo66X9o9HtItzS5hVyE7eu6aCx366KYz17XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X0Sqj3ntrz1j8Dx;
	Fri,  6 Sep 2024 15:42:25 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 19E2B1402CD;
	Fri,  6 Sep 2024 15:42:48 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 15:42:47 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	Alexander Duyck <alexanderduyck@fb.com>, Chuck Lever
	<chuck.lever@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Eric
 Dumazet <edumazet@google.com>, David Howells <dhowells@redhat.com>, Marc
 Dionne <marc.dionne@auristor.com>, Jeff Layton <jlayton@kernel.org>, Neil
 Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
	<trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Shuah Khan
	<shuah@kernel.org>, <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-afs@lists.infradead.org>,
	<linux-nfs@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v18 04/14] mm: page_frag: avoid caller accessing 'page_frag_cache' directly
Date: Fri, 6 Sep 2024 15:36:36 +0800
Message-ID: <20240906073646.2930809-5-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240906073646.2930809-1-linyunsheng@huawei.com>
References: <20240906073646.2930809-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Use appropriate frag_page API instead of caller accessing
'page_frag_cache' directly.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/vhost/net.c                                   |  2 +-
 include/linux/page_frag_cache.h                       | 10 ++++++++++
 net/core/skbuff.c                                     |  6 +++---
 net/rxrpc/conn_object.c                               |  4 +---
 net/rxrpc/local_object.c                              |  4 +---
 net/sunrpc/svcsock.c                                  |  6 ++----
 tools/testing/selftests/mm/page_frag/page_frag_test.c |  2 +-
 7 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f16279351db5..9ad37c012189 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1325,7 +1325,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 			vqs[VHOST_NET_VQ_RX]);
 
 	f->private_data = n;
-	n->pf_cache.va = NULL;
+	page_frag_cache_init(&n->pf_cache);
 
 	return 0;
 }
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 67ac8626ed9b..0a52f7a179c8 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -7,6 +7,16 @@
 #include <linux/mm_types_task.h>
 #include <linux/types.h>
 
+static inline void page_frag_cache_init(struct page_frag_cache *nc)
+{
+	nc->va = NULL;
+}
+
+static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
+{
+	return !!nc->pfmemalloc;
+}
+
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
 void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a52638363ea5..a5f8e4e0c649 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -752,14 +752,14 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 	if (in_hardirq() || irqs_disabled()) {
 		nc = this_cpu_ptr(&netdev_alloc_cache);
 		data = page_frag_alloc(nc, len, gfp_mask);
-		pfmemalloc = nc->pfmemalloc;
+		pfmemalloc = page_frag_cache_is_pfmemalloc(nc);
 	} else {
 		local_bh_disable();
 		local_lock_nested_bh(&napi_alloc_cache.bh_lock);
 
 		nc = this_cpu_ptr(&napi_alloc_cache.page);
 		data = page_frag_alloc(nc, len, gfp_mask);
-		pfmemalloc = nc->pfmemalloc;
+		pfmemalloc = page_frag_cache_is_pfmemalloc(nc);
 
 		local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 		local_bh_enable();
@@ -849,7 +849,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
 		len = SKB_HEAD_ALIGN(len);
 
 		data = page_frag_alloc(&nc->page, len, gfp_mask);
-		pfmemalloc = nc->page.pfmemalloc;
+		pfmemalloc = page_frag_cache_is_pfmemalloc(&nc->page);
 	}
 	local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
 
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 1539d315afe7..694c4df7a1a3 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -337,9 +337,7 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
 	 */
 	rxrpc_purge_queue(&conn->rx_queue);
 
-	if (conn->tx_data_alloc.va)
-		__page_frag_cache_drain(virt_to_page(conn->tx_data_alloc.va),
-					conn->tx_data_alloc.pagecnt_bias);
+	page_frag_cache_drain(&conn->tx_data_alloc);
 	call_rcu(&conn->rcu, rxrpc_rcu_free_connection);
 }
 
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 504453c688d7..a8cffe47cf01 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -452,9 +452,7 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 #endif
 	rxrpc_purge_queue(&local->rx_queue);
 	rxrpc_purge_client_connections(local);
-	if (local->tx_alloc.va)
-		__page_frag_cache_drain(virt_to_page(local->tx_alloc.va),
-					local->tx_alloc.pagecnt_bias);
+	page_frag_cache_drain(&local->tx_alloc);
 }
 
 /*
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 6b3f01beb294..dcfd84cf0694 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1609,7 +1609,6 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 static void svc_sock_free(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
-	struct page_frag_cache *pfc = &svsk->sk_frag_cache;
 	struct socket *sock = svsk->sk_sock;
 
 	trace_svcsock_free(svsk, sock);
@@ -1619,8 +1618,7 @@ static void svc_sock_free(struct svc_xprt *xprt)
 		sockfd_put(sock);
 	else
 		sock_release(sock);
-	if (pfc->va)
-		__page_frag_cache_drain(virt_to_head_page(pfc->va),
-					pfc->pagecnt_bias);
+
+	page_frag_cache_drain(&svsk->sk_frag_cache);
 	kfree(svsk);
 }
diff --git a/tools/testing/selftests/mm/page_frag/page_frag_test.c b/tools/testing/selftests/mm/page_frag/page_frag_test.c
index 5395a36e4030..a4bd543d6950 100644
--- a/tools/testing/selftests/mm/page_frag/page_frag_test.c
+++ b/tools/testing/selftests/mm/page_frag/page_frag_test.c
@@ -117,7 +117,7 @@ static int __init page_frag_test_init(void)
 	u64 duration;
 	int ret;
 
-	test_nc.va = NULL;
+	page_frag_cache_init(&test_nc);
 	atomic_set(&nthreads, 2);
 	init_completion(&wait);
 
-- 
2.33.0


