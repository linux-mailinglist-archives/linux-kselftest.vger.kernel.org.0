Return-Path: <linux-kselftest+bounces-32297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49652AA89CA
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 00:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA64A3B3982
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 22:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E98248886;
	Sun,  4 May 2025 22:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YIquyM7I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A17221733
	for <linux-kselftest@vger.kernel.org>; Sun,  4 May 2025 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746398557; cv=none; b=m9Sb56qHW2/AR/5eKIGIRoNHFu2/5mruimpuoYvtTfemF2xVlv+ih3yQ+DjvnBPI4qI3M7hTdaUFWzDB3QN745ijtYEN5YBqHwy38wwf7zNnw5f8uTh4k764WFwnJPfj+t+4ZXLrAbVThPNBECsVFojEtDt2bNsUQOnjHVr0j1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746398557; c=relaxed/simple;
	bh=plYEAZXEJOj715kvO6oVS5+f4qMO2olfRWFgWjOJTHE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ijSvKR05NioYmH7XVzy4NnHdWBrJnPfM4cN1pMDFO8sA51i9FPpiajsjFyEWGJjURGCHwMxf3RibUztrzNFhU8DvlJUHykZjcD+urVbMAKPNI2fCksIf7s5eAxC5QnT4BslTbT4/3awgSav3An/kWfBO02ezaPNqMzx61LYzmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YIquyM7I; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2265a09dbfcso52146475ad.0
        for <linux-kselftest@vger.kernel.org>; Sun, 04 May 2025 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746398555; x=1747003355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckXDF8xieUFQIQxzOmiI9sqno29aVoAtYHBanW2+fHw=;
        b=YIquyM7IssoBExHW8gQTSlSoqHwuVpWaHsSq3Yw6ziWiikoQSKVdt4xDsdTDjgJwKV
         GKcZuIjbPUrgujAvxg7ChMfZDMkdsSXrBehn/+OWGH/bVWlaV/1Mok8otHVeJ5CYP6Hz
         fbiQ+eGFB5i+OxC7MsZkASAbx0ZaZk3WTxWKLlLamfCbkkiA0t9kZWz0pe+eHUzfi4yI
         bqYGT0UdzN8jgb7rc4rkmCm2AyDJBNN9x8VX0JS81sbuv2ocRDB9ScyNYka+Ud/V/SlA
         4X/ZXd4TqI0+AKiMAbpSNYbFeuZ14/kabj4zZr6lbInimoWMhkxK7u6ddnG6CgCGyNTy
         9ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746398555; x=1747003355;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ckXDF8xieUFQIQxzOmiI9sqno29aVoAtYHBanW2+fHw=;
        b=sZd2saVoxUFqsCLLrrIg5A+CdhJj/pVxgyfZqS7qvrHqrRhJoCQ/8VBVH3JYtFdEg+
         63P8C8EW2y5da2+6vEyvMISLcs12qUk+xqrJlC0jFWGWlWF0fUtrnoAcqX7Bc76R80ZA
         W/bex2nU8p2+6AYoCQR8dDQkQuNTJLBfsWPmpGcfUy7SQKcEnzwLPNPaAnEabMQ94bhr
         mqq/a+jOw4AqKmpAWBRSvQXnjcySeKtVIelPVQWBXrIR+bGt3Uo3HuxjkE5xxTEiC2/w
         NTnG9l/DeXeowyHnAmPkD37dooI/DxoCgP4IlRuuF2P6f6dOgeVHuynEfxqlziCBBTdE
         F/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpkz2AFZq0NhdrPv6rmkI7cjTYCtrYmbLe33c3roXQMn6ZGpTBkSzUj8g0PwSYn8VNp4RBaZhIt0NGBZID35s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZq+eXMFNknTov7jrmM98IA0y4Z06vDbrSxxhqDtDjdN+QEAM
	0gEx92IduZYCF1tmtlnLNGF7s+FSlPq1Ymz+4f46ojy2ttDJo3LrZ/AAJZRoJqPcuF+7IJx2oGg
	pShnHInILk+vyTw==
X-Google-Smtp-Source: AGHT+IEkWjaqnLMdDQbZ+f0poRIDMkyZsZ3KlGS8VJQg5pRE9CqcoIxxzUWp4c/vchXpX5iXi013MrjaGhiu8cc=
X-Received: from plkp1.prod.google.com ([2002:a17:902:6b81:b0:220:ea57:34e3])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce88:b0:223:668d:eba9 with SMTP id d9443c01a7336-22e1e8e9d97mr88068775ad.10.1746398555098;
 Sun, 04 May 2025 15:42:35 -0700 (PDT)
Date: Sun,  4 May 2025 22:41:37 +0000
In-Reply-To: <20250504224149.1033867-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504224149.1033867-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504224149.1033867-2-tjmercier@google.com>
Subject: [PATCH v2 1/6] dma-buf: Rename and expose debugfs symbols
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
Content-Transfer-Encoding: quoted-printable

Expose the debugfs list and mutex so they are usable for the creation of
a BPF iterator for dmabufs without the need for CONFIG_DEBUG_FS. Rename
the symbols so it's clear debugfs is not required, and that the list
contains dmabufs and not some other type.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
v2: Make the DMA buffer list independent of CONFIG_DEBUG_FS per Christian K=
=C3=B6nig
 drivers/dma-buf/dma-buf.c | 40 +++++++++++++++------------------------
 include/linux/dma-buf.h   |  6 ++++--
 2 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 5baa83b85515..7260bdd77c75 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -35,35 +35,25 @@
=20
 static inline int is_dma_buf_file(struct file *);
=20
-#if IS_ENABLED(CONFIG_DEBUG_FS)
-static DEFINE_MUTEX(debugfs_list_mutex);
-static LIST_HEAD(debugfs_list);
+DEFINE_MUTEX(dmabuf_list_mutex);
+LIST_HEAD(dmabuf_list);
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
index 36216d28d8bd..ebcd208272bf 100644
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
@@ -370,10 +371,8 @@ struct dma_buf {
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
@@ -556,6 +555,9 @@ struct dma_buf_export_info {
 	struct dma_buf_export_info name =3D { .exp_name =3D KBUILD_MODNAME, \
 					 .owner =3D THIS_MODULE }
=20
+extern struct list_head dmabuf_list;
+extern struct mutex dmabuf_list_mutex;
+
 /**
  * get_dma_buf - convenience wrapper for get_file.
  * @dmabuf:	[in]	pointer to dma_buf
--=20
2.49.0.906.g1f30a19c02-goog


