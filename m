Return-Path: <linux-kselftest+bounces-32671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67637AB0286
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 20:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23C74A7262
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2D42874E0;
	Thu,  8 May 2025 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xqmL1q9u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60B6286D75
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728445; cv=none; b=m7ZV4ksr54NF70nA/rtgA2uprVpzeyn1HYwViprf00BCmRE/vDJPTZbK3cujdYhFbJPXDlX+Ut3glccGmrD9KpwSKssOUiE3/e1RKj18QuynJKSMxZ5pHCtKkCUGN7vT7B6JCIyt3WwHI7oCY+Wq22WuGMBqKs0nfxL7l78bwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728445; c=relaxed/simple;
	bh=GbXaL24mRRMDksleSDxcOFUC5KMYC6HWfApNSrGVOWg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c2SIkkQbsah2hVoNWhcnS95RVJWv5d4bx0QNrolthQKwSFqgsFivt9TZWyC3pWaiC+kKqP3UnXW+x41rOgsSNIw8BXORcXd+iRn1QclJ5AUf2KGWao+cinOS8QLWlroxINlPg3CG1LVL2bOAWHar4PgBajUnj/+Ws5YM+MHAoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xqmL1q9u; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22e816139b8so10734145ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 May 2025 11:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746728443; x=1747333243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Vp8YXWr6Q9MhLUnJJwXEStdYmj5bU/GPVl/VBDwV4c=;
        b=xqmL1q9uNDih3MGq+DMCu5p0eYNKiX92XLDkaP6aaoiJDtxjEmCru3SguuHvmQrsqg
         UaDYo3rbpdCAmSBFf/qtvSoJh+wDBZ94Tikkj6un733ArMdIJxU7iBb304SlrDPLkGiW
         rB9vNkesDu+Ox/ZspQEl6Ic0sbTE1V6058/W2jjJj0OOM0S31DCC3VW/eYPP53gBlkK7
         VkGxmoWCXw7XPCz5EBUoMyjtjGgKqpAbfQgteBJunpyvkM96ieQiU6+HXg0BQU3pFivk
         Fudz+wT+V3YK256E8VZp4GaQlXthKIFCH137/gQJLQu/nYdq16tAtsbTbfTEGPr8Bljy
         bErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746728443; x=1747333243;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Vp8YXWr6Q9MhLUnJJwXEStdYmj5bU/GPVl/VBDwV4c=;
        b=OtLqg0yRLX5l1SaeahwUJvLrdo2L77wZxNyZtV+xV8qeKOwr/tceFsMmCzGoZTBtfr
         rxX/hjXcbaDFZgSIZ06zXpzLz1huXiPyr8acAHdAOYP34PyWk2rJa8PvTn92m0in93CZ
         VbNgFuaHgDcv5AmqHvxbkBVe3UauvbnuZ8xVIxbL06wGefwshLTV3msR5qrZtSpL2Nos
         eXVwGgjL8gSgEXy8LzqS2lBj41IqP4tD8Aqh+mekJMZ5BpBJCsaY5U6uPOxBurQddBLb
         Jkm7X7j2OgyDKFwPyztvrUBs95GlAXCx+wpQnkHnFu8mhGDk4ICkJjLXNYvIHWhgFgl1
         Zccg==
X-Forwarded-Encrypted: i=1; AJvYcCWbbIWoxeY4CKzbVqscX4oCdCeeEp7j7tVwNs/9QOwIP81pGhLr9wKt7PxnHrac8KaNsrjDtfSKpztWuEcJiok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPTAe8C6XXxXU11ysJvAVJpkhQYat5AVpnBehmLG633Cup0ug
	K8puP+lxtq1Eplt3U0WY+zEIxEIyoFXqbJrwEyoy/L8wqnAelJs556M86NCxlRTsbqv9UX3jKPZ
	T9XQxtvRSXxOdiw==
X-Google-Smtp-Source: AGHT+IGWYpqMym7eTmx2XCcVX3iEosdKCY4ug6FsGOVqYVYRZsv5uVL6cLxdaconQp+47Y7Cu3p54R4CvDNBpvM=
X-Received: from plkh7.prod.google.com ([2002:a17:903:19e7:b0:220:efca:379c])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d48a:b0:220:ca39:d453 with SMTP id d9443c01a7336-22fc8b6131amr5261665ad.17.1746728443187;
 Thu, 08 May 2025 11:20:43 -0700 (PDT)
Date: Thu,  8 May 2025 18:20:20 +0000
In-Reply-To: <20250508182025.2961555-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508182025.2961555-2-tjmercier@google.com>
Subject: [PATCH bpf-next v4 1/5] dma-buf: Rename debugfs symbols
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

Rename the debugfs list and mutex so it's clear they are now usable
without the need for CONFIG_DEBUG_FS. The list will always be populated
to support the creation of a BPF iterator for dmabufs.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c | 40 +++++++++++++++------------------------
 include/linux/dma-buf.h   |  2 --
 2 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 5baa83b85515..8d151784e302 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -35,35 +35,25 @@
=20
 static inline int is_dma_buf_file(struct file *);
=20
-#if IS_ENABLED(CONFIG_DEBUG_FS)
-static DEFINE_MUTEX(debugfs_list_mutex);
-static LIST_HEAD(debugfs_list);
+static DEFINE_MUTEX(dmabuf_list_mutex);
+static LIST_HEAD(dmabuf_list);
=20
-static void __dma_buf_debugfs_list_add(struct dma_buf *dmabuf)
+static void __dma_buf_list_add(struct dma_buf *dmabuf)
 {
-	mutex_lock(&debugfs_list_mutex);
-	list_add(&dmabuf->list_node, &debugfs_list);
-	mutex_unlock(&debugfs_list_mutex);
+	mutex_lock(&dmabuf_list_mutex);
+	list_add(&dmabuf->list_node, &dmabuf_list);
+	mutex_unlock(&dmabuf_list_mutex);
 }
=20
-static void __dma_buf_debugfs_list_del(struct dma_buf *dmabuf)
+static void __dma_buf_list_del(struct dma_buf *dmabuf)
 {
 	if (!dmabuf)
 		return;
=20
-	mutex_lock(&debugfs_list_mutex);
+	mutex_lock(&dmabuf_list_mutex);
 	list_del(&dmabuf->list_node);
-	mutex_unlock(&debugfs_list_mutex);
+	mutex_unlock(&dmabuf_list_mutex);
 }
-#else
-static void __dma_buf_debugfs_list_add(struct dma_buf *dmabuf)
-{
-}
-
-static void __dma_buf_debugfs_list_del(struct dma_buf *dmabuf)
-{
-}
-#endif
=20
 static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int bufle=
n)
 {
@@ -115,7 +105,7 @@ static int dma_buf_file_release(struct inode *inode, st=
ruct file *file)
 	if (!is_dma_buf_file(file))
 		return -EINVAL;
=20
-	__dma_buf_debugfs_list_del(file->private_data);
+	__dma_buf_list_del(file->private_data);
=20
 	return 0;
 }
@@ -689,7 +679,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_exp=
ort_info *exp_info)
 	file->f_path.dentry->d_fsdata =3D dmabuf;
 	dmabuf->file =3D file;
=20
-	__dma_buf_debugfs_list_add(dmabuf);
+	__dma_buf_list_add(dmabuf);
=20
 	return dmabuf;
=20
@@ -1630,7 +1620,7 @@ static int dma_buf_debug_show(struct seq_file *s, voi=
d *unused)
 	size_t size =3D 0;
 	int ret;
=20
-	ret =3D mutex_lock_interruptible(&debugfs_list_mutex);
+	ret =3D mutex_lock_interruptible(&dmabuf_list_mutex);
=20
 	if (ret)
 		return ret;
@@ -1639,7 +1629,7 @@ static int dma_buf_debug_show(struct seq_file *s, voi=
d *unused)
 	seq_printf(s, "%-8s\t%-8s\t%-8s\t%-8s\texp_name\t%-8s\tname\n",
 		   "size", "flags", "mode", "count", "ino");
=20
-	list_for_each_entry(buf_obj, &debugfs_list, list_node) {
+	list_for_each_entry(buf_obj, &dmabuf_list, list_node) {
=20
 		ret =3D dma_resv_lock_interruptible(buf_obj->resv, NULL);
 		if (ret)
@@ -1676,11 +1666,11 @@ static int dma_buf_debug_show(struct seq_file *s, v=
oid *unused)
=20
 	seq_printf(s, "\nTotal %d objects, %zu bytes\n", count, size);
=20
-	mutex_unlock(&debugfs_list_mutex);
+	mutex_unlock(&dmabuf_list_mutex);
 	return 0;
=20
 error_unlock:
-	mutex_unlock(&debugfs_list_mutex);
+	mutex_unlock(&dmabuf_list_mutex);
 	return ret;
 }
=20
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 36216d28d8bd..8ff4add71f88 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -370,10 +370,8 @@ struct dma_buf {
 	 */
 	struct module *owner;
=20
-#if IS_ENABLED(CONFIG_DEBUG_FS)
 	/** @list_node: node for dma_buf accounting and debugging. */
 	struct list_head list_node;
-#endif
=20
 	/** @priv: exporter specific private data for this buffer object. */
 	void *priv;
--=20
2.49.0.1015.ga840276032-goog


