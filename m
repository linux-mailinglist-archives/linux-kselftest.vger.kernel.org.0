Return-Path: <linux-kselftest+bounces-33534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFADAC1725
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 01:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BDA506B33
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0139C2C1791;
	Thu, 22 May 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1MDgSwfd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30522C0314
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955083; cv=none; b=XvGYP7RQcMCqYQYm4kBLC9j7sNy5MghtrMcBxsCCkvYGyqkjnRATjhc7/73JZB+VmCnijBHiuhBw89K54FdJrxtAK6ys7edaDC6UwKQh/TJco9rrZQm1LVSPKvkyauhNzzxfGolCSbpNYjyo90enrBJ18r7vjQLeKNL2YZitavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955083; c=relaxed/simple;
	bh=3dl2vczrcQV9dSvGLQh4xQBq56q7+ixMsFPkp+1hATE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A54TTxoEd2ZJllkRIxTJeASFYcH+63Hcvj0b2kqSCQyTQuIx7y4AEjNQu3uH0MWtWOur+nGr+4c4v7/to55mWULE8nrlR6pFPNmOmcbLycjvSkfcxUBVYXVXY6jIqc4q5tHi4IVifTKWpE9TzdarR+PTumnDZz2r5OAGgXW/Fws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1MDgSwfd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e9b2e7a34so4886693a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 16:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747955081; x=1748559881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+t3s6SNOuCRN33iH3dGH+rCenT32waU3wVYkXXbO4I=;
        b=1MDgSwfdzqXmx+a2BmMjvQDf2mSH2tM9f5ZLdcgDVNcmPA5z8ZACmSBH4tesLNS8NY
         0XxL/JDgWWJVBCF7rT9ioSbq1/lGtye572lObiEWMEH4qP1qxU9GO/LbwUa+5hDL2a1H
         RzyjKTriMlMTFZSfW35tE6G1ViykpDoLzcXYh0BTRfDnG+Y+SG5zRhS6J9MgOCCRa+Ju
         e5P0Wo3KmOG3jkZTdWHIKHuP6pSvQ9YhCnRj28B+RpFLWtuCftJL82LSFFj/FJn8qpUU
         aGRyMx4yf2gd78Y8LuugSZ0J3MJAbIPblUtGkcoXOOIdIdZ1W5p9Y97K/3Ya3nBcgecm
         5TuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747955081; x=1748559881;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0+t3s6SNOuCRN33iH3dGH+rCenT32waU3wVYkXXbO4I=;
        b=Ic+d/u9hOCJKw8FNO70A+XXHNmT0S8quuR8vy1hkRx9xO3FluQS+RFrgpPXmAHqsuk
         jAUNocwCWDg9mdZX4LkVhSrEycx30kK6hlsgm0czND2dkosUXA7ot7Sr6VWYdl8KEKm2
         WE+LRSeB2IBDp+YnvT4gjLUGMy8qL9QItndl3tkUr7lxArzAXlw0qElw22wCalBV5Syj
         IUee9tpE+DcMaP6o4tMqymSaV6s5Aukh23+xbOILYAsx9VqlmHHiFX1ilmwpCqI9yBgJ
         WZzxPQpEl5TgIkGFFj4631I7DFUUTEgyA0timJl2MeimWTbsBuSEQUVKpVZu3EKBynfh
         nX0g==
X-Forwarded-Encrypted: i=1; AJvYcCV1qGc9NMqoYuzSTegljEAw4yY0DiWjvfamlAbsCL1h4eREJ/P72gNhD1VTCmjmT+1N3R1Cdz3bmAhP8rr01ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YywFSGWi0LN5mjCgqmKhTVsHTviOdSPVwjKnTIWO5OsLiPnxOoN
	as/lmi4ZHV3Pely11AieciAeMi5vEwWW5uCoIE0DK+ZArMUPqPJemNbSFHZIK6PitEpAuwBV/34
	CXOHXqQu7NMvhvpsBbg==
X-Google-Smtp-Source: AGHT+IHc8w2C/hVYKlepeDUS+gdP6rU5PYG4tNWHgiwyi8QzNtjOhtc0Nria+4KwgjyX972SMuMRIqaspc+ap+w=
X-Received: from pjd15.prod.google.com ([2002:a17:90b:54cf:b0:308:861f:fddb])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b8c:b0:2ea:3f34:f18f with SMTP id 98e67ed59e1d1-310e96e746bmr1139945a91.19.1747955081045;
 Thu, 22 May 2025 16:04:41 -0700 (PDT)
Date: Thu, 22 May 2025 23:04:25 +0000
In-Reply-To: <20250522230429.941193-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522230429.941193-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522230429.941193-2-tjmercier@google.com>
Subject: [PATCH bpf-next v7 1/5] dma-buf: Rename debugfs symbols
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
2.49.0.1151.ga128411c76-goog


