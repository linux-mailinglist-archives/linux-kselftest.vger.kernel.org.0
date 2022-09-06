Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BF05AF57A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 22:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiIFUKi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 16:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiIFUKP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 16:10:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35E3DBC80F;
        Tue,  6 Sep 2022 13:05:14 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-34-72.rev.numericable.fr [85.170.34.72])
        by linux.microsoft.com (Postfix) with ESMTPSA id C7ACA20B929C;
        Tue,  6 Sep 2022 12:58:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C7ACA20B929C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662494306;
        bh=Y3tZA2UfXIUdO651eZpQHa6bop0UrWXdjXGmdZD7XUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I0ImiMk2OSzmHAF9EcIea/Iv6FlA7LB/hWbPy9LpmWBxA/OWCrauZk3R6t9VWJC0j
         3itEgHNH7uQHYpyP7WU01yZH1+GyGnywJA1qfj5ePpesxIZc6DIPD0paS1A2iERyfe
         wJx8sQQLjg4QvCTa3T51mNdXaCtjSca+V+FF1wrE=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Geliang Tang <geliang.tang@suse.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 1/5] bpf: Make ring buffer overwritable.
Date:   Tue,  6 Sep 2022 21:56:42 +0200
Message-Id: <20220906195656.33021-2-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906195656.33021-1-flaniel@linux.microsoft.com>
References: <20220906195656.33021-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

By default, BPF ring buffer are size bounded, when producers already filled the
buffer, they need to wait for the consumer to get those data before adding new
ones.
In terms of API, bpf_ringbuf_reserve() returns NULL if the buffer is full.

This patch permits making BPF ring buffer overwritable.
When producers already wrote as many data as the buffer size, they will begin to
over write existing data, so the oldest will be replaced.
As a result, bpf_ringbuf_reserve() never returns NULL.

To avoid memory consumption, this patch writes data backward like overwritable
perf ring buffer added in
commit 9ecda41acb97 ("perf/core: Add ::write_backward attribute to perf event").

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 include/uapi/linux/bpf.h |  3 +++
 kernel/bpf/ringbuf.c     | 43 ++++++++++++++++++++++++++++++----------
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 59a217ca2dfd..c87a667649ab 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1227,6 +1227,9 @@ enum {
 
 /* Create a map that is suitable to be an inner map with dynamic max entries */
 	BPF_F_INNER_MAP		= (1U << 12),
+
+/* Create an overwritable BPF_RINGBUF */
+	BFP_F_RB_OVERWRITABLE	= (1U << 13),
 };
 
 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index ded4faeca192..369c61cfe8aa 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -12,7 +12,7 @@
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>
 
-#define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE)
+#define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE | BFP_F_RB_OVERWRITABLE)
 
 /* non-mmap()'able part of bpf_ringbuf (everything up to consumer page) */
 #define RINGBUF_PGOFF \
@@ -37,6 +37,8 @@ struct bpf_ringbuf {
 	u64 mask;
 	struct page **pages;
 	int nr_pages;
+	__u8 overwritable: 1,
+	     __reserved:    7;
 	spinlock_t spinlock ____cacheline_aligned_in_smp;
 	/* Consumer and producer counters are put into separate pages to allow
 	 * mapping consumer page as r/w, but restrict producer page to r/o.
@@ -127,7 +129,12 @@ static void bpf_ringbuf_notify(struct irq_work *work)
 	wake_up_all(&rb->waitq);
 }
 
-static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
+static inline bool is_overwritable(struct bpf_ringbuf *rb)
+{
+	return !!rb->overwritable;
+}
+
+static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node, __u32 flags)
 {
 	struct bpf_ringbuf *rb;
 
@@ -142,6 +149,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	rb->mask = data_sz - 1;
 	rb->consumer_pos = 0;
 	rb->producer_pos = 0;
+	rb->overwritable = !!(flags & BFP_F_RB_OVERWRITABLE);
 
 	return rb;
 }
@@ -170,7 +178,7 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 
 	bpf_map_init_from_attr(&rb_map->map, attr);
 
-	rb_map->rb = bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_node);
+	rb_map->rb = bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_node, attr->map_flags);
 	if (!rb_map->rb) {
 		kfree(rb_map);
 		return ERR_PTR(-ENOMEM);
@@ -248,6 +256,7 @@ static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
 
 	cons_pos = smp_load_acquire(&rb->consumer_pos);
 	prod_pos = smp_load_acquire(&rb->producer_pos);
+
 	return prod_pos - cons_pos;
 }
 
@@ -325,14 +334,24 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	}
 
 	prod_pos = rb->producer_pos;
-	new_prod_pos = prod_pos + len;
 
-	/* check for out of ringbuf space by ensuring producer position
-	 * doesn't advance more than (ringbuf_size - 1) ahead
-	 */
-	if (new_prod_pos - cons_pos > rb->mask) {
-		spin_unlock_irqrestore(&rb->spinlock, flags);
-		return NULL;
+	if (!is_overwritable(rb)) {
+		new_prod_pos = prod_pos + len;
+
+		/* check for out of ringbuf space by ensuring producer position
+		 * doesn't advance more than (ringbuf_size - 1) ahead
+		 */
+		if (new_prod_pos - cons_pos > rb->mask) {
+			spin_unlock_irqrestore(&rb->spinlock, flags);
+			return NULL;
+		}
+	} else {
+		/*
+		 * With overwritable ring buffer we go from the end toward the
+		 * beginning.
+		 */
+		prod_pos -= len;
+		new_prod_pos = prod_pos;
 	}
 
 	hdr = (void *)rb->data + (prod_pos & rb->mask);
@@ -457,10 +476,14 @@ BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, u64, flags)
 
 	switch (flags) {
 	case BPF_RB_AVAIL_DATA:
+		if (is_overwritable(rb))
+			return -EINVAL;
 		return ringbuf_avail_data_sz(rb);
 	case BPF_RB_RING_SIZE:
 		return rb->mask + 1;
 	case BPF_RB_CONS_POS:
+		if (is_overwritable(rb))
+			return -EINVAL;
 		return smp_load_acquire(&rb->consumer_pos);
 	case BPF_RB_PROD_POS:
 		return smp_load_acquire(&rb->producer_pos);
-- 
2.25.1

