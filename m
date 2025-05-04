Return-Path: <linux-kselftest+bounces-32298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4C1AA89D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 00:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C8E170DF1
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 22:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D28224C09C;
	Sun,  4 May 2025 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yOB/TjL8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF124BD1A
	for <linux-kselftest@vger.kernel.org>; Sun,  4 May 2025 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746398561; cv=none; b=mV6d89qsmv4G3Gnfs/DzGSA1CWFubv0QjTH2TrEHoxcCmcQ3EpFnVHGP1gUfyvbHNYBtu4rK632ZjhDGapUV1zEDrQzxfk8M+OkP14KgfE8r4lhFPSljMUYQUIjxZ14Hhm0428tYYm6l5Vv9YrUKwfs9fBo9pUwpVsMxDmeEXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746398561; c=relaxed/simple;
	bh=WG0aVQWqs0VbC4ZquaJ1QyTyG6xJiZ+tnvu4BHPEbhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r96vIzq8uU7jbkPnrH+wbpBDqT+YR2X1UT4IHsvlxu96OAL1hvLMc3fAsjRjmYJmj+jJqGi98sDzJdnohKCgF2zV9Y+JfNxQNudCsEtmc7NZFuS7I9ODwfMrp9tCqZgHtVvjI71WTks5AliGVLY4bUaQgZNQBP1rZglQ94E69hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yOB/TjL8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so3968085a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 04 May 2025 15:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746398559; x=1747003359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4UiHJytqyMBjkMUe4jiF7RJR+rLd9EB5rxLuUC9nlM=;
        b=yOB/TjL8xne65QYCwKvfyYekAePwkvv9w7o+yqjsdBph06PNYWb2XnjazecLhg/v42
         o2JbLnVNiTvJJKv7+WNuKMY4e1TVxtLtwu3+X/dW1fd6GMs0uI8etc3j8pJCc5DKl/I0
         JQ6HLv60lhD2hLWp3/yMLK7A8qqV2jz16w1irx4paBiUQARYBjOcE/lrc97bDlk+pQBq
         uFXMjUh+vykMVjjMBi233++uyuGWvYubhYGGofUNgVAnacUn07bFhHrPjC36tiTHISLW
         NoRCAgEENn7elyebRUZLVLNEGM2i36SeojBR/oPfrwB2tbng5fLyDCURb7JsLHkddSWX
         Mh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746398559; x=1747003359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4UiHJytqyMBjkMUe4jiF7RJR+rLd9EB5rxLuUC9nlM=;
        b=KbOalPQ2CrcBYtZ3yB1s5rkyXLIdPxApnIu9BQCAHn4eBRakiA5n6DTViZ1gfgcMzO
         WoUy1rFXgnWeox3FeQDCyzdV93rYr9Vi/9VDoJFxQupNJ9OdOy9OoKdIN6lHXB0y4aLL
         fl0k7a19GngatPOBL6cj2sTXzw3JfJLJ0BGeSWGY4SHZXgZ+TTQCUHMFtjKG6EIyYojQ
         MbV/PtQtnLQdfEtLuDVqN+hq8EkiyA0Brj5yo+zKdRMxOjDrYWEJzKtinGlWj6i5OVDY
         FIPjpDT4Gz/S8NIzIvhFs/vujOI5XvbfZOWmjpPxdfz8MsmiwImBPMk3nZhu0kyie9Oi
         xDFA==
X-Forwarded-Encrypted: i=1; AJvYcCV817p+H7BtmhAGCguofsvckysrGem5al/NGtidTkmfQsDTNF+H5yh0cSjemrlJB9sGv+7cAxtqQUG82uvXCfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6dK+9avaG7i7qLBFUC9RGpDbikpZ2epS2c3m/4ZE9lleQ55BH
	nGJcIbOkv6W6s+pZbFTZcjckgVKvIEta13642PGnUhEXzrMphlPVjcf/uapoVNbHLxnYZUBJgcv
	nOaaC7/JJeMu+kw==
X-Google-Smtp-Source: AGHT+IHpmxI7uk2byAzLuOwzl/LvQ35S8UNuCQgWihS4iwBUZaso+FHslC8sl609nY7YVNmyP5x9fzMsax0/eCE=
X-Received: from pjxx6.prod.google.com ([2002:a17:90b:58c6:b0:301:4260:4d23])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f0e:b0:2ff:6608:78cd with SMTP id 98e67ed59e1d1-30a619769b0mr8600818a91.9.1746398558977;
 Sun, 04 May 2025 15:42:38 -0700 (PDT)
Date: Sun,  4 May 2025 22:41:38 +0000
In-Reply-To: <20250504224149.1033867-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504224149.1033867-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504224149.1033867-3-tjmercier@google.com>
Subject: [PATCH v2 2/6] bpf: Add dmabuf iterator
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, song@kernel.org, alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, android-mm@google.com, simona@ffwll.ch, 
	corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev, 
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
 kernel/bpf/Makefile      |   3 +
 kernel/bpf/dmabuf_iter.c | 134 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 kernel/bpf/dmabuf_iter.c

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
index 000000000000..968762e11f73
--- /dev/null
+++ b/kernel/bpf/dmabuf_iter.c
@@ -0,0 +1,134 @@
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
+static struct dma_buf *get_next_dmabuf(struct dma_buf *dmabuf)
+{
+	struct dma_buf *ret = NULL;
+
+	/*
+	 * Look for the first/next buffer we can obtain a reference to.
+	 *
+	 * The list mutex does not protect a dmabuf's refcount, so it can be
+	 * zeroed while we are iterating. We cannot call get_dma_buf() since the
+	 * caller of this program may not already own a reference to the buffer.
+	 */
+	mutex_lock(&dmabuf_list_mutex);
+	if (dmabuf) {
+		dma_buf_put(dmabuf);
+		list_for_each_entry_continue(dmabuf, &dmabuf_list, list_node) {
+			if (file_ref_get(&dmabuf->file->f_ref)) {
+				ret = dmabuf;
+				break;
+			}
+		}
+	} else {
+		list_for_each_entry(dmabuf, &dmabuf_list, list_node) {
+			if (file_ref_get(&dmabuf->file->f_ref)) {
+				ret = dmabuf;
+				break;
+			}
+		}
+	}
+	mutex_unlock(&dmabuf_list_mutex);
+	return ret;
+}
+
+static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	if (*pos)
+		return NULL;
+
+	return get_next_dmabuf(NULL);
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
2.49.0.906.g1f30a19c02-goog


