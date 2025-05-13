Return-Path: <linux-kselftest+bounces-32907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCC9AB5A3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 18:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4134188B519
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4953F2BFC9B;
	Tue, 13 May 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fROx9BvQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528DE1A23AD
	for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154180; cv=none; b=dS0nyGaC0DXwlOFmXIgjXLxcisVgCGxZsQgS0wXDNxxXaf3Hw82TeiHLEQFsf4P4G1ZWFsYe5kmTkMRyN4qIbE0jhSK+g7L3pNDgTA81VkD4xNXEr7YP2Uh5rH+DH6RkFt8DLnoir6rWLag7l+VROD6HDt85Jr2pLllRyMtF7GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154180; c=relaxed/simple;
	bh=Af5UIWE0qy22f6c2JL3nAMlI/7xnmUsXK/UfA5VmQlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WZsuWca5Mm9uae2N0E9iKpMKfkdC/oPbZNFESqumddowWEYOvNpYBj7s7yL1Eg/DC9JfZ76fz6zffVfoj3xlha07ya5PLOECFZqli1nEoqMMLAxaCd2RkRMNHGizMxyboxWZGQeOOFCW7IaX6ihO5kASobk2p7jLWPDDQTfPJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fROx9BvQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ab5d34fdbso5330978a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747154177; x=1747758977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCXgFCr4xFu2oZbXQwI8tdtBERd+L0LdxpvvyzEsoGU=;
        b=fROx9BvQBFoz3Ztv8i8e7bfY827i5d0+JLuMYaORMOCLbpfLWlRQA7KNrTOzyrs83x
         yMrzVqMytrqEf5nytnusMrSmz0jXLCdy7fMTrGVSXd8Ka5/Unk0jf2+PFU/nbUW4awbM
         lkOcfvbfj490tEYYnxwqErItAMaYqlyntc6fUrpQTb7anv/BwtowK0X+WyeIzU7GqEn9
         DumvR7RElXXaYLMxxSrBXg9ElYGuwdC3SrAkE26m+vTYxuKAGQOq7TqJeyK6p8Hc6B0r
         XJggII6mmkQONHUw27VTJcMyttrZLSHzS4XOssp1rSchq0fCtir7eLnYLXZNsLNINumu
         MyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747154177; x=1747758977;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SCXgFCr4xFu2oZbXQwI8tdtBERd+L0LdxpvvyzEsoGU=;
        b=gP56LMl4s/dmGraElTQ7ogA1Cbg4cqHDqERr/6EmqZirUOsXXmuf0WPnVvPmZEUeMN
         6RxMdkiWhvAfzzJ7kjJ4hTm/Czta0Ho7DSyBKZHP4yUQw3QKlOFWV0MPOWDaOsv/X25n
         lM+NS9aZSHCC2vzQMdfD8gnbUOnFtf4+0TjgS0GlDsXEOerSJf/Z38xSS4aybdGr0BrN
         G05I0Axgbtc7e6wBKicXoq/MP4paQDjfj/Cqi0UFJSa9XddPC2ggzENPJyWBme7sm2z+
         6LvosnY8V3a/4xn2U+6yPJQGYITNt0ubvdLjYf7B9MzqloLoYAumZor6+PmEDEQeiK8+
         AUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCz+3r1jE83L5ksUZfGa7b9k7G4KTk0qJpmArJGr8DI7scmPFmGqZhXCILxeixrpraefXAh1LJoU/uhehKyFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+/18OAW/o8KJumiJ+e8CoKlIXQsf/qOW+f8pSm5D/hjeILr7
	kFgr0VdDNEufueKJyl2sTtSOtD0zeLXzpTsHLRU/eNGuzmNsBwIlSFb17tJ/FXoBp4LqQVsYWH7
	IszO9AW9EN0xpRw==
X-Google-Smtp-Source: AGHT+IGLZz9RrzXV/RpyPNzBJJXJaWizy+kazwOW9bbjzAp9H3Jgg8jjep3/JQyiE7SOpUncUoPTwbEt/qXoTYo=
X-Received: from pjbst12.prod.google.com ([2002:a17:90b:1fcc:b0:2ff:5752:a78f])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a44:b0:30a:3e8e:492c with SMTP id 98e67ed59e1d1-30e2e687a36mr249364a91.32.1747154177424;
 Tue, 13 May 2025 09:36:17 -0700 (PDT)
Date: Tue, 13 May 2025 16:35:57 +0000
In-Reply-To: <20250513163601.812317-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513163601.812317-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513163601.812317-2-tjmercier@google.com>
Subject: [PATCH bpf-next v6 1/5] dma-buf: Rename debugfs symbols
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
Acked-by: Song Liu <song@kernel.org>
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
2.49.0.1045.g170613ef41-goog


