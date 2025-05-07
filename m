Return-Path: <linux-kselftest+bounces-32543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44684AAD1ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 02:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE911C0504A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 00:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123AC27468;
	Wed,  7 May 2025 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFe53FlM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF81E4B2
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746576650; cv=none; b=eBigkZWJ3TzkP8H6ssSs+Xog3Q9BwLmaCrQdZO6OPCH4RB9pK1ppGuYaeXS9C1kctCNzWMSLJ1sLrE3ahjSnHmm2XPz27jbVJZneqkT27ZxfslHeNS95JJ9EE5s1TnB6hqxEvERWjFgiRWa2itKO9460CQuac0OpdmavjfFy4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746576650; c=relaxed/simple;
	bh=GtprxiIp9QPv7QUqV5NZztK4owcRpS325n/d3dKhKjY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k/mFx7C9VrM+5NuJTWSOqcaCoZl0TcmjoZW0f9klEhrSypo5qDHdNUe0cyXcQNTmkHHsJfg4CZuVX6OyGDyQgpNXx1Dba++mgO+Uz0v7XIQ9g0bnykXYidofF7rqqpuDDsP+XN34kzpCpjkXvpIMgzm/B4NdLwWtEWLsvfhfF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFe53FlM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ab450d918so120377a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 May 2025 17:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746576647; x=1747181447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J2Exutn/ZWXBPWobLv3f+bgAg3/+JyztWu0aq/wV+8U=;
        b=iFe53FlMKniurYy9wOmqsNlyeDKz2Um1/Ulxy/p/dXqSmLb1kDenB+4z0H4FP8KEv0
         r+meGJJBQnd71umHwS4iS8hRDw2oEEH6VaxVsDGbPqb0CHyRDv+TlAtmc2vB4eewSn8R
         hXpqVK/gn4bxmWSQv6+lZNuVJpY1w7u61DFFnY+WEiL/Xiq264wqWHan8c/6hQ5zxG0Y
         B6lViwg2Hua+DTRo6Mlg0R3JPZxsQX9t13ip263i5QSmHuA5HC2k6y9vd2ZneOQLWTqS
         xSbLQP37wUAH4/nzWUIMBpp6Ahoidw9QC28TnIAeRm1PTCoxcFjuAbT3meHemAedVn3t
         TL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746576647; x=1747181447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2Exutn/ZWXBPWobLv3f+bgAg3/+JyztWu0aq/wV+8U=;
        b=KlpXrqeO1WgFCeRJd51ByWck9kWSa+4VB7i57zSE3IXMH8kPqcAMjso9SypqfOKyU3
         Acp2p3R2W3bXuJpS6nJFU833uga4EBJfs6WmkDlH6eNlkbN80ox7+krx1sVGWisYduUv
         ddnyMFIx8CQxCg1Uco26Yf7AHwM3CYWm5zQTPxT/IsZnk4n1WfMf+UeEbdaG+cFn5FNE
         6HdMU6bP11+yAL15gmfvX2z3Y+xFSoIUQy7ibQ75XwWzJaIHqF3kKjrnCZorMvVhs2V0
         G2vITMmkYRTbCQB0vTnVG6Q9nEjpqo3NORakA12bxFIYa82d5LCWpN9hmXxJ05p0SMHV
         Q8Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXJExg52sywYR0olD5V6WUioLiWwFHaJa13rictJwkhMT6/L+WSxh9GxRftwXzuB0fvSZECA55z13h7rKJ3yDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+wJnqwEesN0Zk30IMcxJsjI+tED47jbL3nYqYZB/JRXmH+SN
	U2rxhHpYtEuV6UfqOGlTwiNSYxPzOg6qulc0CpZfFgcDhkf9nDV7ppecpRVLMcQCrGhERV6qnhP
	HE6ibzH4084SUeQ==
X-Google-Smtp-Source: AGHT+IFL0AeKYJWX5uQDx4vtlik1jrjuYKA2AIFKy1hdyB/rg+TpkzIfgKkb1XNyAaj5vjstqCOldZHytqVX2N0=
X-Received: from pjf8.prod.google.com ([2002:a17:90b:3f08:b0:30a:8830:9f6b])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2249:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-30aac179571mr2222024a91.8.1746576647544;
 Tue, 06 May 2025 17:10:47 -0700 (PDT)
Date: Wed,  7 May 2025 00:10:33 +0000
In-Reply-To: <20250507001036.2278781-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250507001036.2278781-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250507001036.2278781-3-tjmercier@google.com>
Subject: [PATCH bpf-next v3 2/5] bpf: Add dmabuf iterator
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com, song@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

The dmabuf iterator traverses the list of all DMA buffers.

DMA buffers are refcounted through their associated struct file. A
reference is taken on each buffer as the list is iterated to ensure each
buffer persists for the duration of the bpf program execution without
holding the list mutex.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/dma-buf/dma-buf.c |  64 ++++++++++++++++++++++++
 include/linux/dma-buf.h   |   3 ++
 kernel/bpf/Makefile       |   3 ++
 kernel/bpf/dmabuf_iter.c  | 102 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 kernel/bpf/dmabuf_iter.c

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 8d151784e302..9fee2788924e 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -19,7 +19,9 @@
 #include <linux/anon_inodes.h>
 #include <linux/export.h>
 #include <linux/debugfs.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/seq_file.h>
 #include <linux/sync_file.h>
 #include <linux/poll.h>
@@ -55,6 +57,68 @@ static void __dma_buf_list_del(struct dma_buf *dmabuf)
 	mutex_unlock(&dmabuf_list_mutex);
 }
 
+/**
+ * get_first_dmabuf - begin iteration through global list of DMA-bufs
+ *
+ * Returns the first buffer in the global list of DMA-bufs that's not in the
+ * process of being destroyed. Increments that buffer's reference count to
+ * prevent buffer destruction. Callers must release the reference, either by
+ * continuing iteration with get_next_dmabuf(), or with dma_buf_put().
+ *
+ * Returns NULL If no active buffers are present.
+ */
+struct dma_buf *get_first_dmabuf(void)
+{
+	struct dma_buf *ret = NULL, *dmabuf;
+
+	/*
+	 * The list mutex does not protect a dmabuf's refcount, so it can be
+	 * zeroed while we are iterating. We cannot call get_dma_buf() since the
+	 * caller may not already own a reference to the buffer.
+	 */
+	mutex_lock(&dmabuf_list_mutex);
+	list_for_each_entry(dmabuf, &dmabuf_list, list_node) {
+		if (file_ref_get(&dmabuf->file->f_ref)) {
+			ret = dmabuf;
+			break;
+		}
+	}
+	mutex_unlock(&dmabuf_list_mutex);
+	return ret;
+}
+
+/**
+ * get_next_dmabuf - continue iteration through global list of DMA-bufs
+ * @dmabuf:	[in]	pointer to dma_buf
+ *
+ * Decrements the reference count on the provided buffer. Returns the next
+ * buffer from the remainder of the global list of DMA-bufs with its reference
+ * count incremented. Callers must release the reference, either by continuing
+ * iteration with get_next_dmabuf(), or with dma_buf_put().
+ *
+ * Returns NULL If no additional active buffers are present.
+ */
+struct dma_buf *get_next_dmabuf(struct dma_buf *dmabuf)
+{
+	struct dma_buf *ret = NULL;
+
+	/*
+	 * The list mutex does not protect a dmabuf's refcount, so it can be
+	 * zeroed while we are iterating. We cannot call get_dma_buf() since the
+	 * caller may not already own a reference to the buffer.
+	 */
+	mutex_lock(&dmabuf_list_mutex);
+	dma_buf_put(dmabuf);
+	list_for_each_entry_continue(dmabuf, &dmabuf_list, list_node) {
+		if (file_ref_get(&dmabuf->file->f_ref)) {
+			ret = dmabuf;
+			break;
+		}
+	}
+	mutex_unlock(&dmabuf_list_mutex);
+	return ret;
+}
+
 static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
 {
 	struct dma_buf *dmabuf;
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 8ff4add71f88..1820f6db6e58 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -568,6 +568,9 @@ static inline void get_dma_buf(struct dma_buf *dmabuf)
 	get_file(dmabuf->file);
 }
 
+struct dma_buf *get_first_dmabuf(void);
+struct dma_buf *get_next_dmabuf(struct dma_buf *dmbuf);
+
 /**
  * dma_buf_is_dynamic - check if a DMA-buf uses dynamic mappings.
  * @dmabuf: the DMA-buf to check
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 70502f038b92..3a335c50e6e3 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -53,6 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
 obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
+ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
+obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
+endif
 
 CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
new file mode 100644
index 000000000000..80bca8239c6d
--- /dev/null
+++ b/kernel/bpf/dmabuf_iter.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Google LLC */
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/dma-buf.h>
+#include <linux/kernel.h>
+#include <linux/seq_file.h>
+
+BTF_ID_LIST_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
+DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_buf *dmabuf)
+
+static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	if (*pos)
+		return NULL;
+
+	return get_first_dmabuf();
+}
+
+static void *dmabuf_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct dma_buf *dmabuf = v;
+
+	++*pos;
+
+	return get_next_dmabuf(dmabuf);
+}
+
+struct bpf_iter__dmabuf {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct dma_buf *, dmabuf);
+};
+
+static int __dmabuf_seq_show(struct seq_file *seq, void *v, bool in_stop)
+{
+	struct bpf_iter_meta meta = {
+		.seq = seq,
+	};
+	struct bpf_iter__dmabuf ctx = {
+		.meta = &meta,
+		.dmabuf = v,
+	};
+	struct bpf_prog *prog = bpf_iter_get_info(&meta, in_stop);
+
+	if (prog)
+		return bpf_iter_run_prog(prog, &ctx);
+
+	return 0;
+}
+
+static int dmabuf_iter_seq_show(struct seq_file *seq, void *v)
+{
+	return __dmabuf_seq_show(seq, v, false);
+}
+
+static void dmabuf_iter_seq_stop(struct seq_file *seq, void *v)
+{
+	struct dma_buf *dmabuf = v;
+
+	if (dmabuf)
+		dma_buf_put(dmabuf);
+}
+
+static const struct seq_operations dmabuf_iter_seq_ops = {
+	.start	= dmabuf_iter_seq_start,
+	.next	= dmabuf_iter_seq_next,
+	.stop	= dmabuf_iter_seq_stop,
+	.show	= dmabuf_iter_seq_show,
+};
+
+static void bpf_iter_dmabuf_show_fdinfo(const struct bpf_iter_aux_info *aux,
+					struct seq_file *seq)
+{
+	seq_puts(seq, "dmabuf iter\n");
+}
+
+static const struct bpf_iter_seq_info dmabuf_iter_seq_info = {
+	.seq_ops		= &dmabuf_iter_seq_ops,
+	.init_seq_private	= NULL,
+	.fini_seq_private	= NULL,
+	.seq_priv_size		= 0,
+};
+
+static struct bpf_iter_reg bpf_dmabuf_reg_info = {
+	.target			= "dmabuf",
+	.feature                = BPF_ITER_RESCHED,
+	.show_fdinfo		= bpf_iter_dmabuf_show_fdinfo,
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__dmabuf, dmabuf),
+		  PTR_TO_BTF_ID_OR_NULL },
+	},
+	.seq_info		= &dmabuf_iter_seq_info,
+};
+
+static int __init dmabuf_iter_init(void)
+{
+	bpf_dmabuf_reg_info.ctx_arg_info[0].btf_id = bpf_dmabuf_btf_id[0];
+	return bpf_iter_reg_target(&bpf_dmabuf_reg_info);
+}
+
+late_initcall(dmabuf_iter_init);
-- 
2.49.0.1045.g170613ef41-goog


