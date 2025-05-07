Return-Path: <linux-kselftest+bounces-32542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4334AAD1E8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 02:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AFE520505
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EAA101C8;
	Wed,  7 May 2025 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sAmHL/F/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE2BA34
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746576647; cv=none; b=pEw1rbnS4SA1uk/EXD4EUgOVZOQI1nFYUoRlMuLR7Q/PvlfRrDCWlY9U1eERvYnk+n+jjM1ycgusNShWoMFB2uDcUpRqUM8v0c97AIHMepAb5GjVvmaH+xRV5KxIAZY/HUM20d6wpeOL1JycmM+xM/RmoKTKHc1Xv3zzXoWm1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746576647; c=relaxed/simple;
	bh=ENt9bNqDrtAazaMY+B4/iaikxMlx71ALLPLjwDEqI+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JAw8FjMC9woYVqsQoF7lXVv+A1mck/2AZx3tGTNwf/ubU6OxQY+5BT4xntm+2bqBYROwguzUwumdgXKziVXd7vJeM6x6BWcrkuIBRZlZPeqKCsCRfBoRQnGX8itGsTU2SWqnQqEf2MnEcdtIZBjJFXb5Ure/5IaXEymTZNqRw8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sAmHL/F/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b1fe8e65d17so450523a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 May 2025 17:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746576645; x=1747181445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AT/BLkjp9kSyaWDX07QeDnXSY64MOvBoRMn6GL7z2E=;
        b=sAmHL/F/3ckILytdC4hjDMZHP14weZK2Dz9p8Wd4lUx+uvPhzJCMGV/BCtzukuYO3D
         hosfkplEQSEdYt5kVrFzKhNhKB3h6jJgHb+DFl4RP/jULDWPJW9oNWSJ7u0I7xCsdW7r
         dOI74COjC/BCdH/KD3MWSrnHnakhiB9+m6ydJKJdTRteJ20TtO1XH/8QPCtoIgo6dKfQ
         qAPz8n6KZQjLgGKnkCkfkwm7fVmCigVr+TrAirlefTtcKBqGL/g2pN9xmnyoLrIE9qyQ
         2Ug/AUbsohR/Wy3HTfER5XMVF5OJRcVm+M0dVoeflN27bKJcHCHYHsIVW+SDQowHcY8v
         Y+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746576645; x=1747181445;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3AT/BLkjp9kSyaWDX07QeDnXSY64MOvBoRMn6GL7z2E=;
        b=ELzO9ogu4kNdZyKGoNKHBrax5xSD+PhM8edY6DmUMPeDFrbmFYFg+a2x1jB9e0ql4O
         h+zcszIKgms30UN0DL+9QmiYx6N5DKauMVx+Sezll2ZxYD9oIW13ZojnmoNMF4dVhAyG
         Pf1wiZ3+o86xcI47sXkeeDD8bUL/UlFtTb+0CRk6sbTNahlICDBfqrt5ICGYPEqHuLUQ
         WHpkAC+g+XtV2zWH+zD2rPfSCsZ0ynchXNW0u/Ait4UnmsO3EI1DNzwcG4qhak7P6phL
         vRmo9uiYN2FDK5UqQwQRUsccXjZYdi6co7KqqvHpNtkqSWF9sCFAFGsZUf8FQCX2ElI4
         wRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTkdHnUqEIveji4dnKMd7TnqqGyW6k9Vsft940C1Emk9Z7fbTkRlqES6L152QAjyKwBu2KpiBoWCtzlEci/7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCszuJa1mY8YLTBS7LMLg9NtPrRlg99mRBSvYqoKlI04iaxzpm
	a714P3DnsFzdboave5IQT1CpZmx2ady9FSmVgPG6zRpSgfKkoM3H1DO8WBKZqOE+VkWMcpdesaJ
	GGjZkSCJsaADPWw==
X-Google-Smtp-Source: AGHT+IGjv/c2fzF3ZsIcOt5Mn1/YxqtlksyqIqxhrRJxhS2Uqg6AkhPc6dULFKkD5F2xqt9stbeixjUXT9WMVA0=
X-Received: from pji12.prod.google.com ([2002:a17:90b:3fcc:b0:2fc:c98:ea47])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7d1:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-30aac29bfd7mr1774601a91.30.1746576645059;
 Tue, 06 May 2025 17:10:45 -0700 (PDT)
Date: Wed,  7 May 2025 00:10:32 +0000
In-Reply-To: <20250507001036.2278781-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250507001036.2278781-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250507001036.2278781-2-tjmercier@google.com>
Subject: [PATCH bpf-next v3 1/5] dma-buf: Rename debugfs symbols
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
2.49.0.1045.g170613ef41-goog


