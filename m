Return-Path: <linux-kselftest+bounces-6084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC95E875CA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 04:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8591C20FCC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 03:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29022C1BA;
	Fri,  8 Mar 2024 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YXgYcrG7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1B2C1AD;
	Fri,  8 Mar 2024 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709867855; cv=none; b=VHyRK3UsYgQfSIT24ZPIZXipOrwjtiVvPgsNTjD0Ev/gioi6EgRGr+BBzCDe08ihn1v091qW9PGjAsHElYMlFdHRoQ+wuIVA/cUJ6iXlGl+/nrI4fFrI/4Dfni3Lall7zSiI5vG5YHQ4F5H4qd1bbUKOPo4zb/j8TYxCRmjsCSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709867855; c=relaxed/simple;
	bh=VGSKY29NysOoo2tRtbDnGFbEUiLW+yLrbtm4EZl4mCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KArHMxFOnw4+IFIlruqnA5tMn+bGvAnIFXZm/MONGDrhoXDtGP1xoMRIIU4W7s3kZTMdvPpI5rxOaLPOe01yGUi6t9aZCYnah1+u51naFMDOJ+3r7LAu1mgj38HdorIqYRUhdg7V7Ve7qpTVWI36ju2PVHcocSE9t3npKMSqT60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YXgYcrG7; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709867849; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZzSoZX//TlGoWXQpwWVKWs7b879WAWEYa8PXOZdwjSU=;
	b=YXgYcrG7r4l/NpUa0/gw5ITOTaXjZz4VeGttnO0CK9L7GYmX2YKvNSmHa1zWS3alVfEn/6EGm8GwN/OGbZ+DlA3mdVEAhXb+DJUrutBAEJQOMRJp0yhsHcga7cj9zSh+G+gOHswxN4DXdY3K8pwa8sjSi6NoDXNwoefKjJs+97w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W21N1N0_1709867847;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W21N1N0_1709867847)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 11:17:29 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	shuah@kernel.org,
	corbet@lwn.net
Cc: xlpang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	xiangzao@linux.alibaba.com,
	yixingrui@linux.alibaba.com,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 2/4] pstore: add a /sys/module entry for loaded backends
Date: Fri,  8 Mar 2024 11:16:54 +0800
Message-Id: <20240308031656.9672-3-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308031656.9672-1-xiangzao@linux.alibaba.com>
References: <20240308031656.9672-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a /sys/module entry for loaded pstore backends which
provide users and testcases with a standarized interface to retrieve
information on which pstore backends are currently registered.

Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 fs/pstore/inode.c    | 38 ++++++++++++++++++++++++++++++++++++++
 fs/pstore/internal.h |  1 +
 fs/pstore/platform.c |  9 ++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index bee71c7da995..5800fa4abfce 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/kobject.h>
 #include <linux/fs.h>
 #include <linux/fsnotify.h>
 #include <linux/pagemap.h>
@@ -491,6 +492,43 @@ int __init pstore_init_fs(void)
 	return err;
 }
 
+static ssize_t loaded_backend_show(struct kobject *k,
+				   struct kobj_attribute *attr, char *buf)
+{
+	struct pstore_info_list *entry;
+	char *old, *loaded_backend = NULL;
+
+	mutex_lock(&psback_lock);
+	list_for_each_entry(entry, &psback->list_entry, list)
+		if (!loaded_backend)
+			loaded_backend = kstrdup(entry->psi->name, GFP_KERNEL);
+		else {
+			old = loaded_backend;
+			loaded_backend = kasprintf(GFP_KERNEL, "%s,%s",
+						   old, entry->psi->name);
+			kfree(old);
+		}
+	mutex_unlock(&psback_lock);
+
+	return sprintf(buf, "%s\n", loaded_backend);
+}
+
+static struct kobj_attribute backend_attribute =
+	__ATTR(loaded_backend, 0444, loaded_backend_show, NULL);
+
+int __init pstore_init_entry(void)
+{
+	int err = 0;
+	struct kobject *pstore_kobj;
+
+	pstore_kobj = kset_find_obj(module_kset, "pstore");
+	if (pstore_kobj) {
+		err = sysfs_create_file(pstore_kobj, &backend_attribute.attr);
+		kobject_put(pstore_kobj);
+	}
+	return err;
+}
+
 void __exit pstore_exit_fs(void)
 {
 	unregister_filesystem(&pstore_fs_type);
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index 4b1c7ba27052..ffc86b04c5cc 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -47,6 +47,7 @@ extern void	pstore_record_init(struct pstore_record *record,
 
 /* Called during pstore init/exit. */
 int __init	pstore_init_fs(void);
+int __init	pstore_init_entry(void);
 void __exit	pstore_exit_fs(void);
 
 #endif
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index a1742b39fb88..5c10a546cdf0 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -841,7 +841,14 @@ static void pstore_timefunc(struct timer_list *unused)
 
 static int __init pstore_init(void)
 {
-	return pstore_init_fs();
+	int ret;
+
+	ret = pstore_init_fs();
+	if (ret)
+		return ret;
+
+	ret = pstore_init_entry();
+	return ret;
 }
 late_initcall(pstore_init);
 
-- 
2.39.3


