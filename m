Return-Path: <linux-kselftest+bounces-32544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14661AAD1F6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 02:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15297B6EE0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 00:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8434741760;
	Wed,  7 May 2025 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmPVv/Ix"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F12AE84
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746576653; cv=none; b=OSHlX9xnP9bmFQ49LnebfUw6InOtjYThmhLqEQkYT2IDzjk5tMlpJJ/9oRdm9jGHOuOy0tWT8RarPi5VeXD/FWBXpB+CGdUg3BGCj0sVyZxRD4K7clyF63Tdrw3dNeThABnwwWOijG8DcDHP1fSugI5CjCRrrRYhTlr9fE2tgc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746576653; c=relaxed/simple;
	bh=pyse2+fm36nrb8svFIqyM73W2uIjgmXGZFlVg/8fUik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YnMt9bnDbuxqjS8eQpskqHLRH+QQV6xjq6ZPmHfwvVsC9L6p/r4IGnMFZSmiN4EFqytFoftsxwe1UIFi1maxwlDHA+kuB1wy2KwjElAGZ2it79BJOT8grZIfmPz9k9lIIDLkWp/+Duyg/u/fHGI0WmbxZ+/WjFfTsO9APqaYRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmPVv/Ix; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22e5cd14e48so3975345ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 May 2025 17:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746576650; x=1747181450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SkxID+WP7mb4sg4ZUV6PaZg3RytzLGPGnjFriQZ17Hk=;
        b=TmPVv/IxE+dGkeNFkVIjRbpAcx+Lb38uM2KaL3fYaffMXCOO7Jm7WjXYSKxVf+gTEz
         mwLP84RgxcpuATRe6ave9DGu/lkNCGUoqnyxm1tX1pr1KTSsnXgFZmcb09IYI1lWvjWU
         S2kniz9scC3wOqg4RfStqBNbSCEo5IvOQwVeAgM4yZBT4WF8n67ivVojYNidD3xvGYQh
         LA6TVHDRZQl8Os5dFVKf1rhEbZfuv3mTCM24WkJDJALDNJhUwAiqSDzqU3rN8fWL/3Gs
         BypoGKT9Ts2B06hGw6gmqHnFmwW54U8VHbyG0mWAWsMOErBe+G9VtpiTUmguADjaODf+
         lhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746576650; x=1747181450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SkxID+WP7mb4sg4ZUV6PaZg3RytzLGPGnjFriQZ17Hk=;
        b=TfaSBS0HU72q6omwDdb0QNBrql20T2D1w02KaNdl2OFTQ05g+Nx+wZ1zdnuAJootgD
         3XyqBK+G8zMeryTWjkK0Xi0RFMILQmbVCnHk61eK3UuPPdxlVyAPUb9y3jUsIRe21IjE
         ZqkFYvCS2OXTMGmek6kKXiCgGofyproUrUQC6PMP0pKjZmeOnakBNQIVaNLndQYIFiln
         XMEXI1/zvmdrImptmdXRnUdHiZHvHelFQtvRfALEU5e61UgF7JU3Iddd7kgZH9cxgcZs
         OLtPQWAORXcTEZK1m+ntcJtcvsGj8nVHn/98KspT9g6QQsRjGzx6KejRj6QgvpiYT/iA
         +mcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOCUMq2oIavPrcaamECFITHQn0BndcikSDG+Ke3H5436mmBbgwYcthELmMKnblXx9JReI/AffzGal+pUC95wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0GUly3v7a4xsw66bxrp3k9hYUZcb6UyUN8KO/4FckH3car4J7
	4V0vcj0njJHgQHPeJNRxl4qXNQw8V6AclB9lZRzuZhqkBI26ReEZWesnYE0Un24pDWOFSqEXAUJ
	GAG2Cx+hgs0jVkA==
X-Google-Smtp-Source: AGHT+IEx7hDcQzk8ELF2Wf/YDX+04BAayFsjqz8ketxueOqk4IMFJhrgD4+bT2AOspb/6AKarjrhAJ8dHZy5bPA=
X-Received: from pjbsi7.prod.google.com ([2002:a17:90b:5287:b0:2fb:fa85:1678])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ecc6:b0:22e:1740:e561 with SMTP id d9443c01a7336-22e5ea501ccmr19570925ad.19.1746576649869;
 Tue, 06 May 2025 17:10:49 -0700 (PDT)
Date: Wed,  7 May 2025 00:10:34 +0000
In-Reply-To: <20250507001036.2278781-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250507001036.2278781-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250507001036.2278781-4-tjmercier@google.com>
Subject: [PATCH bpf-next v3 3/5] bpf: Add open coded dmabuf iterator
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

This open coded iterator allows for more flexibility when creating BPF
programs. It can support output in formats other than text. With an open
coded iterator, a single BPF program can traverse multiple kernel data
structures (now including dmabufs), allowing for more efficient analysis
of kernel data compared to multiple reads from procfs, sysfs, or
multiple traditional BPF iterator invocations.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/bpf/dmabuf_iter.c | 47 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c     |  5 +++++
 2 files changed, 52 insertions(+)

diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index 80bca8239c6d..b0478b4875ed 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -100,3 +100,50 @@ static int __init dmabuf_iter_init(void)
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
+	if (kit->dmabuf)
+		kit->dmabuf = get_next_dmabuf(kit->dmabuf);
+	else
+		kit->dmabuf = get_first_dmabuf();
+
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
index 78cefb41266a..39fe63016868 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3346,6 +3346,11 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
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
2.49.0.1045.g170613ef41-goog


