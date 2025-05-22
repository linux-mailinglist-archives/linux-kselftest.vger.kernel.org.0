Return-Path: <linux-kselftest+bounces-33536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEE4AC1735
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 01:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787FD506A64
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325E2C2AD0;
	Thu, 22 May 2025 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOgMu2XD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FB2C1794
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955087; cv=none; b=UA7JWFQVvxJkvZReQ8zot5jcqyBbqksKdOqa3C0DMRXYCJtiBEzrUwDD7nJxpM/Iz2iX7mJ5xyBv3ObX+kkDinjeUWOS0F0xrSiNtw4AhIyWBpKCWhGYk3UqwuukcmQWu7exsORqn9xZ1umV0oRgUyKTzoKgDWMDWS9bbI8DAUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955087; c=relaxed/simple;
	bh=IzIhp5f9UkPPUd0nWSAK8FUbuMqu0g7cAdmTXHizgXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ARKyaQ/0XpwMkr+Slh4h20wgNT4T9WifC3EhIhiE+4m/ZxoAL1PTjz1BJaCj37rmjRklsEOVzOLawBm6ir7b9a4EInJNzl2X8Yb7lI5r7bPp9G8eBQHNbJ/3IPo8OhsKxgOpRvvSMDLB7ca/XOQNHib9AujrefmfyADjctthOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOgMu2XD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e895056f0so9111053a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 16:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747955084; x=1748559884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/g8JyMw2VwyJ/m9TjS/SiUKpJwsf5OkBbH7oNpMPS0=;
        b=QOgMu2XDkHI0o07iYFksuqsZF4C/4WsXVza3rkoSuzqKJccwjQ33KkLaH2f9jBu9Oo
         T012Po2JMJTqPAC3QyvsaRgRxpeDfDTNLIGylQoEDsldqDSyHJSCSeRqGg7hTgyScH4a
         9RJHoQbiJoMWqQzMcd/GVfoh5UBk8FktBB+XWUmABtOFxTBewbrF262HszjqU/r57tFq
         0ihdSoZwgovovLnU6lPKR5FjWWfolj67SZlGzGzyHyzyBzSLgEo1CLSpwmd2/dKb9jzs
         ZU5/5LEc+8dqjyOvkOEXUJBTOGf0n5+lGF1cZxXQcnjM5qCoyfa3sebWOz5P0xYC/4oX
         7E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747955084; x=1748559884;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G/g8JyMw2VwyJ/m9TjS/SiUKpJwsf5OkBbH7oNpMPS0=;
        b=lHNidUiqL/sFkCeieClCzZHnTTnawt8D8S8h8b9r9q+xrazU5H3QEDM1w+uIG1htUL
         CNbbp5wzuZnj0PTNXD1bEGqeBfBCaq1H0Jvxv9EbhYtrVKwveq8st206s5r8hkUER43h
         dFydxnISDopYkOUiGGKM1NX0T0wvuGNgKKYfnv/TiFnwrW20a2ZoapOOFaDxKQ3N742D
         hlW6Lvx7V+oG94JCa7cSdZWZCToQKnOJSKukHmz0PFHeVY+cbHPeTAmlK66XG7qHV7Z0
         JY63j5lihCjFGXC2AFcbvLGg+Yj/p+spp1vxaZZ/RewbhgqZ5Rs+lAKL4W0cAOJnMaSN
         qQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXp1wfjvCc6pQGdEMIWlmyRVrZ7IOuBBfu53ruqs/hJKKdwFuDJ+a3W6xnl0QI4V1Rb5w+MNwYn2eF75uKGP/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcaI6SgUTU3J+PNH+LucATi8ekgBvwWyUpg7ogt0OnHiHXPul3
	UeTm//c9besS2NLjUeRdTmYChfbwm5vY9Sf/EVxzZWJ0cB/KaelvjVSjk2Rp825nFEavT6qIO+I
	mH41dpe+NVNi2bmjKTQ==
X-Google-Smtp-Source: AGHT+IFHuZm2aKEEnirqMLyqXI/q0B8Co6Lr8MSquOHmj/BaEI70fa0f5cgugQZD5uKAyXECH9AT3FapY42Phlk=
X-Received: from pjf6.prod.google.com ([2002:a17:90b:3f06:b0:2ea:9d23:79a0])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3905:b0:30e:9349:2d93 with SMTP id 98e67ed59e1d1-310e972b4famr1252004a91.28.1747955084272;
 Thu, 22 May 2025 16:04:44 -0700 (PDT)
Date: Thu, 22 May 2025 23:04:27 +0000
In-Reply-To: <20250522230429.941193-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522230429.941193-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522230429.941193-4-tjmercier@google.com>
Subject: [PATCH bpf-next v7 3/5] bpf: Add open coded dmabuf iterator
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, song@kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This open coded iterator allows for more flexibility when creating BPF
programs. It can support output in formats other than text. With an open
coded iterator, a single BPF program can traverse multiple kernel data
structures (now including dmabufs), allowing for more efficient analysis
of kernel data compared to multiple reads from procfs, sysfs, or
multiple traditional BPF iterator invocations.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Acked-by: Song Liu <song@kernel.org>
---
 kernel/bpf/dmabuf_iter.c | 48 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c     |  5 +++++
 2 files changed, 53 insertions(+)

diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index 83ef54d78b62..4dd7ef7c145c 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -100,3 +100,51 @@ static int __init dmabuf_iter_init(void)
 }
=20
 late_initcall(dmabuf_iter_init);
+
+struct bpf_iter_dmabuf {
+	/*
+	 * opaque iterator state; having __u64 here allows to preserve correct
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
+	struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
+
+	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
+	BUILD_BUG_ON(__alignof__(*kit) !=3D __alignof__(*it));
+
+	kit->dmabuf =3D NULL;
+	return 0;
+}
+
+__bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *i=
t)
+{
+	struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
+
+	if (kit->dmabuf)
+		kit->dmabuf =3D dma_buf_iter_next(kit->dmabuf);
+	else
+		kit->dmabuf =3D dma_buf_iter_begin();
+
+	return kit->dmabuf;
+}
+
+__bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it)
+{
+	struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
+
+	if (kit->dmabuf)
+		dma_buf_put(kit->dmabuf);
+}
+
+__bpf_kfunc_end_defs();
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c1113b74e1e2..bd17ed5bfc4b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3386,6 +3386,11 @@ BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLE=
EPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_TRUST=
ED_ARGS)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF_T=
RUSTED_ARGS)
+#ifdef CONFIG_DMA_SHARED_BUFFER
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_S=
LEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE=
)
+#endif
 BTF_KFUNCS_END(common_btf_ids)
=20
 static const struct btf_kfunc_id_set common_kfunc_set =3D {
--=20
2.49.0.1151.ga128411c76-goog


