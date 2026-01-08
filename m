Return-Path: <linux-kselftest+bounces-48566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29095D067CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 23:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDA4B3038281
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 22:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A896D337BA6;
	Thu,  8 Jan 2026 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rEWcm3Fz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBFC334361
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 22:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767913007; cv=none; b=KUEHvHrLQPZslwEBMMbdjhQjNAYLWo0CqTk430Ws6GR/kscr1pFP2Gef61SWAwURoWsQ2BIEEHIAzEuE2fBMaDbuecrKDAG7Ad7Uj+T6zRqA6lWFGuSUD4BjB8K969pVKqtZrKpHx4KpMChPOjTEbKFLVyu08SwvewliAgwQJ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767913007; c=relaxed/simple;
	bh=O6ot7CPctdPFw6WHudhxbDM8ZE4E8EaTJG3EnZslIx8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s9PJnWQ/mj4LXFjzfIAwNjp7qFel+N0TF55gzySncLRbdEiLL5tO1wxWJ1c9gCIFKA7oYhHkpeuSW30N0MZUWc1tpQc7riXktRSafqHBML+TMbGBfQrCCtze9qcd+2X6vuQvy1JAXwuzDiKUvl+IwCDed1o0cW15xdrRWQ4cjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rEWcm3Fz; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11f44c1b352so14876050c88.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 14:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767913005; x=1768517805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dJJFhVKyiKKoV+I6tkl9SP4apjw+O1s0pu7zT4uXhoI=;
        b=rEWcm3FzBG6Quo3FVczNQFeX1M/PpmRajo9yqRGjOQOAtrr6/2wig65ycv293oDUE0
         N4jrSbe9T7kAzh+kl1aSApqqrZO8bprMvnPYxHocYFtWPbgbBuMEIaKwX19iuvVT77XS
         Rc4iyrl4g+XjNgzQlFrD1sCb22649XBilp/En8r3Iin02qAeqBm8gZUtsj8q8S47fPf2
         G2CuDsDxQIJgSr+YDYmiEwyH3DsLoqf5w4hevb707LQ8fPEaXvsp9KE/3h5C1Ao9Q5td
         ceJI1ykbvcj8Nu0utoEyBKp7RAiJP2bL1XxUBLuU/M7u0pww6iUeiphZAjaulAiHGD6u
         Qaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767913005; x=1768517805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJJFhVKyiKKoV+I6tkl9SP4apjw+O1s0pu7zT4uXhoI=;
        b=hHCthsi53V6XslLrVKDV8fyj6B/agay7SZFk4Oy1L8LcXBTGZa22smrKvyCczMFWFH
         u64DGq2Sk07D30BIN4OMWwetFyZrOGxp/drj+fddzoGI8lqD4C8zryInGHZsouNmkIqt
         YiIBfEXT+Ts1e6BjfKpTW2g+8RAHllPpo5fKVdSbErm5uW7mjFQ3WrRK+vJB4CA0btn9
         puU4INouWASTEmPsCelGSWbIGkFUZc3FpSj/0bo4ZZJHBPcyP7HIo6Pnujf0KzGVr+8I
         Ov+kuHTK5iReY+uPV8/wJ9Syz9wvUEpUC476EWm9mxItH0EmIXNfJl1uzpaFpVcfnVgT
         kdJA==
X-Forwarded-Encrypted: i=1; AJvYcCWIqu1qUmO+hXSHPgiO6U7G1okW/08t5lFJqw5CNzDyqyC0YMxvV+lBeYE1eUfHLmWQro2OHFDIni0UTEMOMGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdMqQrPT2gTJ1HUsgdyf5OgFLKOZlD0MofkCXToE7Xe6405Ep
	BGfP5H1hbGocBcc4g2s0hKPewwBRqyh3TyWTBj7MjI3IFbb/kTFV4Z75fDe6++kpzgJOZc1Aa6g
	gShaaO/GYOsvHiw==
X-Google-Smtp-Source: AGHT+IH3CAgfHxDvv2J1GeCokRZ2S0eL3vzB4naD0DGXvhIrgl0bXBb/VDYWZsHKr5BZFHhvYXCyyWn/7qi9tQ==
X-Received: from dlbbs14.prod.google.com ([2002:a05:7022:90e:b0:11b:b756:3e9b])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:aa9:b0:11b:9386:7ecc with SMTP id a92af1059eb24-121f8b5f7a4mr7253173c88.41.1767913005229;
 Thu, 08 Jan 2026 14:56:45 -0800 (PST)
Date: Thu,  8 Jan 2026 14:55:18 -0800
In-Reply-To: <20260108225523.3268383-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108225523.3268383-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108225523.3268383-2-wusamuel@google.com>
Subject: [PATCH bpf-next v2 1/4] bpf: Add wakeup_source iterator
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a BPF iterator for traversing through wakeup_sources.

Setup iterators to traverse through a SRCUs of wakeup_sources. This is a
more elegant and efficient traversal than going through the options
today, such as at /sys/class/wakeup, or through debugfs.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/bpf/Makefile             |   3 +
 kernel/bpf/wakeup_source_iter.c | 103 ++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 kernel/bpf/wakeup_source_iter.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 79cf22860a99..1259373298e1 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -66,6 +66,9 @@ obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
 ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
 obj-$(CONFIG_BPF_SYSCALL) += dmabuf_iter.o
 endif
+ifeq ($(CONFIG_PM_SLEEP),y)
+obj-$(CONFIG_BPF_SYSCALL) += wakeup_source_iter.o
+endif
 
 CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source_iter.c
new file mode 100644
index 000000000000..ab83d212a1f9
--- /dev/null
+++ b/kernel/bpf/wakeup_source_iter.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Google LLC */
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/kernel.h>
+#include <linux/pm_wakeup.h>
+#include <linux/seq_file.h>
+
+struct bpf_iter__wakeup_source {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct wakeup_source *, wakeup_source);
+};
+
+static void *wakeup_source_iter_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	int *srcuidx = seq->private;
+	struct wakeup_source *ws;
+	loff_t i;
+
+	*srcuidx = wakeup_sources_read_lock();
+
+	ws = wakeup_sources_walk_start();
+	for (i = 0; ws && i < *pos; i++)
+		ws = wakeup_sources_walk_next(ws);
+
+	return ws;
+}
+
+static void *wakeup_source_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct wakeup_source *ws = v;
+
+	++*pos;
+
+	return wakeup_sources_walk_next(ws);
+}
+
+static void wakeup_source_iter_seq_stop(struct seq_file *seq, void *v)
+{
+	int *srcuidx = seq->private;
+
+	if (*srcuidx >= 0)
+		wakeup_sources_read_unlock(*srcuidx);
+	*srcuidx = -1;
+}
+
+static int __wakeup_source_seq_show(struct seq_file *seq, void *v, bool in_stop)
+{
+	struct bpf_iter_meta meta = {
+		.seq = seq,
+	};
+	struct bpf_iter__wakeup_source ctx = {
+		.meta = &meta,
+		.wakeup_source = v,
+	};
+	struct bpf_prog *prog = bpf_iter_get_info(&meta, in_stop);
+
+	if (prog)
+		return bpf_iter_run_prog(prog, &ctx);
+
+	return 0;
+}
+
+static int wakeup_source_iter_seq_show(struct seq_file *seq, void *v)
+{
+	return __wakeup_source_seq_show(seq, v, false);
+}
+
+static const struct seq_operations wakeup_source_iter_seq_ops = {
+	.start	= wakeup_source_iter_seq_start,
+	.next	= wakeup_source_iter_seq_next,
+	.stop	= wakeup_source_iter_seq_stop,
+	.show	= wakeup_source_iter_seq_show,
+};
+
+static const struct bpf_iter_seq_info wakeup_source_iter_seq_info = {
+	.seq_ops		= &wakeup_source_iter_seq_ops,
+	.seq_priv_size		= sizeof(int),
+};
+
+static struct bpf_iter_reg bpf_wakeup_source_reg_info = {
+	.target			= "wakeup_source",
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{
+			offsetof(struct bpf_iter__wakeup_source, wakeup_source),
+			PTR_TO_BTF_ID_OR_NULL
+		},
+	},
+	.seq_info		= &wakeup_source_iter_seq_info,
+};
+
+DEFINE_BPF_ITER_FUNC(wakeup_source, struct bpf_iter_meta *meta,
+		     struct wakeup_source *wakeup_source)
+BTF_ID_LIST_SINGLE(bpf_wakeup_source_btf_id, struct, wakeup_source)
+
+static int __init wakeup_source_iter_init(void)
+{
+	bpf_wakeup_source_reg_info.ctx_arg_info[0].btf_id = bpf_wakeup_source_btf_id[0];
+	return bpf_iter_reg_target(&bpf_wakeup_source_reg_info);
+}
+
+late_initcall(wakeup_source_iter_init);
-- 
2.52.0.457.g6b5491de43-goog


