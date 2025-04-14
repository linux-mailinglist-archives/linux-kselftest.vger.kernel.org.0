Return-Path: <linux-kselftest+bounces-30804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EC2A88F91
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 00:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603107A5935
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 22:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D0A1F4188;
	Mon, 14 Apr 2025 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MFNDM1jm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5001DF98F
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744671184; cv=none; b=sOD5X3eT4mXDKrUIrcGDNLKzyOe6pE0LcvxqvGVvhMua9xyF6pAs3SN5kfBAQNqv9Ln6NUM58fXDV7Wv29Cgtrr+gVNFFPcZUWcbNAewh91Pd5mhWEG763hCGvaVm36R8IgCwnhOpoICx4B4Ty+jjGB1o9rOwXEIdLrokdue5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744671184; c=relaxed/simple;
	bh=ZxcRVXhRdEjtMHXZUPaBq9B7u5rzOMBpKemS0lYYXzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XjlAy5+gdY0nMq+we6iOwyumonFu8hYAUk3Lr9JKDjEEp4zYwgaMUbEPd3ZXyS8iqF1pL42pNW1gMQs7P5VrR3yv/iS5TB/RyMIq7eQWf/V9Ep021KtEfRxKDhIE8El3PLF7pFWhlUb9j2iBKSKW8dvwN/L4ZS1GcqNKutdr568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MFNDM1jm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3082946f829so4419901a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 15:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744671182; x=1745275982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJrdRumDqZ5uqDqo6HIvT1i7XS9qBKy2EYr2kcfYfkI=;
        b=MFNDM1jmSY3r4PUUGU2TnJR/9If8XyJXVL9LXpNBuZmztlBmuJFoNvdypFo0+vEjZh
         3XaEmZZkgX4UZ3EsqpwrP1J/5LprsR4SrmUiCfQexqvskfpx2Q/8bHjiXbdV8ygOGxLw
         PIfXlMoasV2iSQcCAL2OpFlYd4cimnL0htq9miAN9VV8SATWByE/xCBanEYgo3FpYPX+
         ZH7zFDdIuZG7MX7jlhlUaZwDJuCc1dR2aBygPbW/pHs6/Pn2P1dJ9YZUDzWkNkwNJXSy
         v+94ux0KPk5UWjl9Do2JDQDtuzZ2KvYdWvQ0kyaE1afJAYGodMrRp8Ss55BqSBj2OSqO
         +E9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744671182; x=1745275982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJrdRumDqZ5uqDqo6HIvT1i7XS9qBKy2EYr2kcfYfkI=;
        b=R91W9ib5QiizUSNV4wZkdkOCLBxJYscvjWfBKV2Q3PXc9+tG62wiIa+WB6SrrX7DB5
         32nIz0lPRo+MxXvhc3/E5OWORg9mqbzj+ypmNtU1Uy5kzmxC1GifYunhzz8OB7wboUmY
         tbfOhOdg3CV5KWloKi7i3q7k0t1vqtuQV78NNNprdpQHb3iLEM8osBdh0C0jY9lpmEUD
         9dRvR/KBfZ04C4WuZfSUF4eMZupz7BfLDb1QB03QYbdFTTzmI7OgQq+HM/Acev4Loskx
         NqvbXUcZFECl1RUh7834hmaFulfFiiT0YqwwOi53evxHPu5wdJEaSt+iiY1SXwqHcgar
         YW+w==
X-Forwarded-Encrypted: i=1; AJvYcCWBUL0G3Q0tepGJfyh8G4OVdryZHCZIGsn4y3yyE5Zrde7gRPwwpxn5h9mX06MSgPzM/n7+k0ek59UdDoUxSvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWuNMj+CWgVgjvoXpR1e6w32V8B99+mPvOOXvCd6UBueSS/9Lb
	bo617Oz3GoxMSvtYqKWIp43odgqZlijdxK8Y23heUDTVyoP+PB2RaDZ+RnQ39C1Xdz8Q1cDTjXG
	cjvU7AMqom0AIXA==
X-Google-Smtp-Source: AGHT+IHdhGyVRFQrYACqs6CpKKEAPawP/7gzm2A4TvPbteK5I88D550DNb1nfh3BQI2ey0zXeU9GGoMDGDE66H8=
X-Received: from pllw4.prod.google.com ([2002:a17:902:7b84:b0:220:d668:ff81])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b2f:b0:215:a179:14ca with SMTP id d9443c01a7336-22bea49529cmr197698465ad.2.1744671182407;
 Mon, 14 Apr 2025 15:53:02 -0700 (PDT)
Date: Mon, 14 Apr 2025 22:52:24 +0000
In-Reply-To: <20250414225227.3642618-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414225227.3642618-2-tjmercier@google.com>
Subject: [PATCH 1/4] dma-buf: Rename and expose debugfs symbols
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, android-mm@google.com, simona@ffwll.ch, 
	corbet@lwn.net, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

Expose the debugfs list and mutex so they are usable for the creation of
a BPF iterator for dmabufs. Rename the symbols so it's clear they
contain dmabufs and not some other type.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/dma-buf/dma-buf.c | 22 +++++++++++-----------
 include/linux/dma-buf.h   |  6 ++++++
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 5baa83b85515..affb47eb8629 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -36,14 +36,14 @@
 static inline int is_dma_buf_file(struct file *);
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-static DEFINE_MUTEX(debugfs_list_mutex);
-static LIST_HEAD(debugfs_list);
+DEFINE_MUTEX(dmabuf_debugfs_list_mutex);
+LIST_HEAD(dmabuf_debugfs_list);
 
 static void __dma_buf_debugfs_list_add(struct dma_buf *dmabuf)
 {
-	mutex_lock(&debugfs_list_mutex);
-	list_add(&dmabuf->list_node, &debugfs_list);
-	mutex_unlock(&debugfs_list_mutex);
+	mutex_lock(&dmabuf_debugfs_list_mutex);
+	list_add(&dmabuf->list_node, &dmabuf_debugfs_list);
+	mutex_unlock(&dmabuf_debugfs_list_mutex);
 }
 
 static void __dma_buf_debugfs_list_del(struct dma_buf *dmabuf)
@@ -51,9 +51,9 @@ static void __dma_buf_debugfs_list_del(struct dma_buf *dmabuf)
 	if (!dmabuf)
 		return;
 
-	mutex_lock(&debugfs_list_mutex);
+	mutex_lock(&dmabuf_debugfs_list_mutex);
 	list_del(&dmabuf->list_node);
-	mutex_unlock(&debugfs_list_mutex);
+	mutex_unlock(&dmabuf_debugfs_list_mutex);
 }
 #else
 static void __dma_buf_debugfs_list_add(struct dma_buf *dmabuf)
@@ -1630,7 +1630,7 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 	size_t size = 0;
 	int ret;
 
-	ret = mutex_lock_interruptible(&debugfs_list_mutex);
+	ret = mutex_lock_interruptible(&dmabuf_debugfs_list_mutex);
 
 	if (ret)
 		return ret;
@@ -1639,7 +1639,7 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 	seq_printf(s, "%-8s\t%-8s\t%-8s\t%-8s\texp_name\t%-8s\tname\n",
 		   "size", "flags", "mode", "count", "ino");
 
-	list_for_each_entry(buf_obj, &debugfs_list, list_node) {
+	list_for_each_entry(buf_obj, &dmabuf_debugfs_list, list_node) {
 
 		ret = dma_resv_lock_interruptible(buf_obj->resv, NULL);
 		if (ret)
@@ -1676,11 +1676,11 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 
 	seq_printf(s, "\nTotal %d objects, %zu bytes\n", count, size);
 
-	mutex_unlock(&debugfs_list_mutex);
+	mutex_unlock(&dmabuf_debugfs_list_mutex);
 	return 0;
 
 error_unlock:
-	mutex_unlock(&debugfs_list_mutex);
+	mutex_unlock(&dmabuf_debugfs_list_mutex);
 	return ret;
 }
 
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 36216d28d8bd..7754608453dc 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/scatterlist.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/dma-mapping.h>
 #include <linux/fs.h>
 #include <linux/dma-fence.h>
@@ -556,6 +557,11 @@ struct dma_buf_export_info {
 	struct dma_buf_export_info name = { .exp_name = KBUILD_MODNAME, \
 					 .owner = THIS_MODULE }
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+extern struct list_head dmabuf_debugfs_list;
+extern struct mutex dmabuf_debugfs_list_mutex;
+#endif
+
 /**
  * get_dma_buf - convenience wrapper for get_file.
  * @dmabuf:	[in]	pointer to dma_buf
-- 
2.49.0.604.gff1f9ca942-goog


