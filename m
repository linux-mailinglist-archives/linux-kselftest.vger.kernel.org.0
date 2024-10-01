Return-Path: <linux-kselftest+bounces-18726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE2E98B65A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 10:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568AA1F22820
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 08:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD701BE23C;
	Tue,  1 Oct 2024 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa/QMWAq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40361BE233;
	Tue,  1 Oct 2024 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769577; cv=none; b=EM9PNPpxPJR/5NTUXMmZQJVfQ5LXmklreF/qlfy1zGxCzFcUJKh/jL5DRreMfuLqO+WTWk+LLApZM2Ww3sq+pgpFSAKpvVApMUWPlamAktdGpY+U3cL/0N240xukOQYiwhoY23V/Eky0g/HHB7yqkeEwIgZHVGSiOaDXcH1nqE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769577; c=relaxed/simple;
	bh=7u9cByNn+AJUO28aQhpxRgxL9HZmWejhnVAxuPd9L1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E4IfsA46EdGbBC24K4EjnSlFYrUZL6EqEQU0K7wOEnZXa/d94ylRT+DOVGqxU8Wj43whitm2KgnG7tKw7JNLVLRbI/H3+H/FTEoaFyUTnDm/+ZG5aj8Qrzi666FYmD9z8k5HETVqZRhYhoW6yB9YbrptRrgRS+iYtS3V/7dDk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa/QMWAq; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2e0b93157caso2999958a91.0;
        Tue, 01 Oct 2024 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727769574; x=1728374374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vktSfFznxxqxdyooYxAJtLpLR+uBOH4pDsLUZk+TldI=;
        b=Xa/QMWAqks6qScJW12s0S833sVNmt+nAJafSNF43CyInb/4ovUMob56d781hkMSw5v
         ZbJAGD2sZCo+65WzVpahoVSYtCbEeqHtfvsqY3R7lzEtwsMHKP+NGuRcMBfNcrC8y/q4
         8Hdin0EkcZaqTBrSfUiUo7CW6Zjrf92tjYrq6GrJKlZx/xRcQn/OR/I7CMiJQLwY+p8w
         7IUHf0hdq8LRfEQzwOFkTXR1tRlphNpewrOo0N2EHKOaSzmQthfyN7BzxGBCnaP9a/SL
         5RSLz0XhkC7BKL+o85j/X0VC57RU7DPlLbY5w7L++Zd4QFsBHKuQwmThvG/Aun0paJKg
         nhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727769574; x=1728374374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vktSfFznxxqxdyooYxAJtLpLR+uBOH4pDsLUZk+TldI=;
        b=c7KMF2IQASHCBS1rwMwfA4NG+Ui/qyhBGBRqAwIeviJR2sN0BylR6ceD7AK+PQ+sfJ
         4GAG9E2T8BwW4qOgjGoy2dBATFPwzc6aOMz5dXYzUOUTCIsp+oQ0euE0+96KXKe7Ao9J
         uvm+H+eTXEEo8ZBG1qstx28veof5siHYh8kUAVndsR1jZC/J209veot9G2CkZT+5WWNm
         PGz+3/cJCKOgU6eobmAH0BJbZLjcG+fSWpT7wMOh6wKQOfDXqVVWYm60N08Wq/+MrSi0
         zzpc4rAk7RmXykpzEarW5teOwEmgGy7CfrKFHZTsqr0FatlCF1Dcp+73BcEDqSUkN8kc
         41Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2qgfKZqP3TWW8lIf51hHl++qBjeiVByTwMEIIkSo2YLIHot5eoa8GC2xvoPcs4GVCpYjx/JlZFHN@vger.kernel.org, AJvYcCVjsVdmc2yDJ078YzHJsJLTOaAZHxBd8fhKOCv9jCpBb9JraCA7fApM7zzgj7rvY8SWQ08=@vger.kernel.org, AJvYcCWRqPZKKqEwre1g8uwjeeITxgUjNlJMnnrQLU9Vpczwz6c+84IuBJhh97Q4k2RTnz+XknuktLeI8luOx3vQ@vger.kernel.org, AJvYcCWdEcMha8DtqH/Ob2upuzntMvclFNIQQRqy3/PxGPKM4oJweE2gO2LI6ZZ/vfa2QxlD6tnWoxST2KHz/byVbHTS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0b8ywHaOQAe1hOtw0juwsyG+EQvhnwOuBKVENSftESZQxg5cT
	epdSrCTAqt9WDNMe/D2cVtOwMd7IqUWswiHmRnaJFj7TNdngsSi1
X-Google-Smtp-Source: AGHT+IH1qx+VpqO/M0ZFFo8jx2Ltv6BvYYP7WVtyTnNPIJSUx7pF6s/8RS08Pp9OK0t2pqi6/zCT9A==
X-Received: by 2002:a17:90a:2f65:b0:2d8:999a:bc37 with SMTP id 98e67ed59e1d1-2e15a34cfe8mr3372002a91.19.1727769574029;
        Tue, 01 Oct 2024 00:59:34 -0700 (PDT)
Received: from yunshenglin-MS-7549.. ([2409:8a55:301b:e120:88bd:a0fb:c6d6:c4a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16d6d2sm13168168a91.2.2024.10.01.00.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:59:33 -0700 (PDT)
From: Yunsheng Lin <yunshenglin0825@gmail.com>
X-Google-Original-From: Yunsheng Lin <linyunsheng@huawei.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-mm@kvack.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v19 04/14] mm: page_frag: avoid caller accessing 'page_frag_cache' directly
Date: Tue,  1 Oct 2024 15:58:47 +0800
Message-Id: <20241001075858.48936-5-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001075858.48936-1-linyunsheng@huawei.com>
References: <20241001075858.48936-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 74149dc4ee31..ca01880c7ad0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -753,14 +753,14 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
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
@@ -850,7 +850,7 @@ struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int len)
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
index 825ec5357691..b785425c3315 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1608,7 +1608,6 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 static void svc_sock_free(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
-	struct page_frag_cache *pfc = &svsk->sk_frag_cache;
 	struct socket *sock = svsk->sk_sock;
 
 	trace_svcsock_free(svsk, sock);
@@ -1618,8 +1617,7 @@ static void svc_sock_free(struct svc_xprt *xprt)
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
index fdf204550c9a..36543a129e40 100644
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
2.34.1


