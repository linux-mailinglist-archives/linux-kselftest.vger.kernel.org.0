Return-Path: <linux-kselftest+bounces-32299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D6AA89DA
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 00:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E273B230B
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 22:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31E324FC09;
	Sun,  4 May 2025 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpjTLyji"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA224E4DD
	for <linux-kselftest@vger.kernel.org>; Sun,  4 May 2025 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746398565; cv=none; b=bABKXtKnpCkNMWjBpqqT3qqT99VGvz22o8q32nbQgLC/C20ny4BxR8jABrLMGahzVMVGcibpdR0Wq9QK6GAR0JPRz4OQIBoV/yIo/Frw4YYVE5w0Ue/+n9T3KuREFkZbj8283A6DyCj4XRi8Jj4KrXx2ijKjYM9jhU2R3MpwgXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746398565; c=relaxed/simple;
	bh=hpi+1WKsldoD7aaDq11Ugd6+x4oQPbat+b3N9LvEESI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L+VxEiDYjCe1CIwzkO0M0lmpLWzTfBaUFRDh7YPXR5GsXhT3o4vf1OoAd7vDssUtqBxQ2YlnOup5BFC7rjbiTE5MxnMY9yGJkdQgxQIsGlb3XQXjSDgQO9pHlUF9ulnUS4BwxEqgO9jVffj0+7ru3Ensu/h2TF53Wdhf53WlaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpjTLyji; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30a59538b17so1525965a91.3
        for <linux-kselftest@vger.kernel.org>; Sun, 04 May 2025 15:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746398563; x=1747003363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXDdbmilM6kw4tmaPJb1OY6Nmv5TWjsHKnabAlzq4nA=;
        b=UpjTLyjiXAgxj0kUulgUa99ZWXz3Y3322TUQbjjL/SFYMpRX3ufBEtRG0gcxRrKs5K
         egF5zO1jpCJCsTgXlICnlDi42rr8o3/9A4EbJGdmpWLCwb6wpH67NXrphGpMKu9iZqfS
         zYudNS+m6MOGqUtBz3BfwNiYkluWFexOTrptMobyqyGJ51rrIDaJ0YIUGcrV3Ij31TV9
         95DmSmuFMeR2LIZa8G7UqqgfMDHwBClBDZcaHKpIT5JkzsKs7s0Ysbaw42Wt1IzyK1aY
         emsnzXrKdalZoMoF7VKPlScvE+fswcQ3PF06w0rcXnyxuvd7642IyPLeqlX8vd8gPN+0
         PS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746398563; x=1747003363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXDdbmilM6kw4tmaPJb1OY6Nmv5TWjsHKnabAlzq4nA=;
        b=k/n9WVNELn6Vq9/IXb51TLkBn6R72AnEY3+XU+kkkpya5MBKElt0s2YUJBtISVor7t
         +Qx44zjUDc7s0FfbjXRnZ1j3DaujqjcCyfjJKqiiBRQBYeuVGPTwbYthslv0mGgD51ZG
         kPC9xd3He1D1ODkpYg8+YTRhaWvl9AG/DOg7KlWW3SPik+hROGi8f+pYUBoM0b5DFvxF
         jmn0va4urE+yhIA2yovh7PznccOn5u3jwccrVqJGYls0Uac6+9SYIPeYM8OwBdkWnBKh
         gaeT2xalea8kqzAf9RDSr3Vi4Qn3rAzUsdIVL4YWiq5D/KKfJedlaUWIqpJ4wKPg9Z5X
         eFOw==
X-Forwarded-Encrypted: i=1; AJvYcCVYrtPHtGzvP6oNK9YOaCuUdJwYbu6WgroFMjV2G2AU58RxlTtR5hYZWku7L19xrdQmmvqOmZOrxRKREGAzzeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSs9l3VxISOWChmeCZeiPdwsgWHulyl9ViAfloHlrcdzTRcv6L
	QGrdOFggSm0/k9QaR5aFJVqrhZWnR983Ul4QSDH50VQRVfFBOFdg+Pnd790lmAbOETSuWcl0tcJ
	yqCArjEXS2hNptA==
X-Google-Smtp-Source: AGHT+IHeuhPkqCORnCnlODfZEgoM3mxo+4Qkj5bGxDZDkA2AvS1Wg0vNaQ4AA42Kn2PJNuaQSmzdVlm4/hxRO/Q=
X-Received: from pjbee11.prod.google.com ([2002:a17:90a:fc4b:b0:2fb:fa85:1678])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f8c:b0:305:5f32:d9f0 with SMTP id 98e67ed59e1d1-30a4e5c5e9dmr15101935a91.19.1746398563275;
 Sun, 04 May 2025 15:42:43 -0700 (PDT)
Date: Sun,  4 May 2025 22:41:39 +0000
In-Reply-To: <20250504224149.1033867-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504224149.1033867-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504224149.1033867-4-tjmercier@google.com>
Subject: [PATCH v2 3/6] bpf: Add open coded dmabuf iterator
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

This open coded iterator allows for more flexibility when creating BPF
programs. It can support output in formats other than text. With an open
coded iterator, a single BPF program can traverse multiple kernel data
structures (now including dmabufs), allowing for more efficient analysis
of kernel data compared to multiple reads from procfs, sysfs, or
multiple traditional BPF iterator invocations.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/bpf/dmabuf_iter.c | 43 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c     |  5 +++++
 2 files changed, 48 insertions(+)

diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index 968762e11f73..ebf9794241ef 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -132,3 +132,46 @@ static int __init dmabuf_iter_init(void)
 }
 
 late_initcall(dmabuf_iter_init);
+
+struct bpf_iter_dmabuf {
+	/* opaque iterator state; having __u64 here allows to preserve correct
+	 * alignment requirements in vmlinux.h, generated from BTF
+	 */
+	__u64 __opaque[1];
+} __aligned(8);
+
+/* Non-opaque version of bpf_iter_dmabuf */
+struct bpf_iter_dmabuf_kern {
+	struct dma_buf *dmabuf;
+} __aligned(8);
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
+{
+	struct bpf_iter_dmabuf_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
+	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
+
+	kit->dmabuf = NULL;
+	return 0;
+}
+
+__bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it)
+{
+	struct bpf_iter_dmabuf_kern *kit = (void *)it;
+
+	kit->dmabuf = get_next_dmabuf(kit->dmabuf);
+	return kit->dmabuf;
+}
+
+__bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it)
+{
+	struct bpf_iter_dmabuf_kern *kit = (void *)it;
+
+	if (kit->dmabuf)
+		dma_buf_put(kit->dmabuf);
+}
+
+__bpf_kfunc_end_defs();
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..49de5eae44da 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3294,6 +3294,11 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
+#ifdef CONFIG_DMA_SHARED_BUFFER
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
+#endif
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.49.0.906.g1f30a19c02-goog


