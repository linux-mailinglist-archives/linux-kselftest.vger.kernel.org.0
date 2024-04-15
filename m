Return-Path: <linux-kselftest+bounces-7980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC818A53E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A421F20ECB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D7882481;
	Mon, 15 Apr 2024 14:29:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5817581F;
	Mon, 15 Apr 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191372; cv=none; b=RuHtcp/Eu58Gujt9rVT7Y/eVskVBuOLXd5dK9Zomz8XdzxVKbAlxPUiUvp02Dr6fFfGy5pQ+e89WX2xSKAVMXXJaQsUMyOC3A9gcRghQVuUzA68NahFsHBuRP6zcvEaggNsak5Bvhk7AV4mbiB3M0gnZfPF1erZYOo2VHk6hGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191372; c=relaxed/simple;
	bh=eZVYIloM9fbMgIPKvwe5elCHLztDhHM/7Cp7llmzsw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wb3zbKM+gJSnYhaQLimQOWPdl9RuuhuUQZLZdg0i2bBOOoxKS+p+w2tp/N5Yl2MYjwGkJ354CYu64NScZHxu1RVo2jU9QvP+UzV+3pAdyeD/TdY34qCzQ7JoCv38xe9HKrex8fit/NTOhNUWzIFyAiANa6K0TG3ngjOy45FQpKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VJ8Ck4rrHz9v7PM;
	Mon, 15 Apr 2024 22:08:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 9E0DE140801;
	Mon, 15 Apr 2024 22:29:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHshqQOR1mrL1NBg--.21472S4;
	Mon, 15 Apr 2024 15:29:21 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	mic@digikod.net
Cc: linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	linux-integrity@vger.kernel.org,
	wufan@linux.microsoft.com,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	dhowells@redhat.com,
	jikos@kernel.org,
	mkoutny@suse.com,
	ppavlu@suse.com,
	petr.vorel@gmail.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 12/14] digest_cache: Notify digest cache events
Date: Mon, 15 Apr 2024 16:24:34 +0200
Message-Id: <20240415142436.2545003-13-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshqQOR1mrL1NBg--.21472S4
X-Coremail-Antispam: 1UD129KBjvAXoW3tw47KFyfCFWxXr47uF4xtFb_yoW8Wry7Go
	ZYyF47uw48WFy5uFWkCFy7AayUW3ySgw4xAr1kGrZ8ZF18t34UJ3Z7GF1DJFy3Gr18GrZ7
	A34kX3yUJFW8Jr97n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOe7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr
	1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x
	07j4MKtUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5h0wAAAsV

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce digest_cache_register_notifier() and
digest_cache_unregister_notifier() to let the subscribers know about events
occurring on digest caches. Subscribers should provide a callback, to be
invoked for every notification.

Introduce a notification list for each digest cache, and populate it with
inodes passed to digest_cache_get(), when dig_user of that inode is still
NULL so that there are no duplicates.

Then, on setting the RESET bit, emit a DIGEST_CACHE_RESET notification,
passing the affected digest cache and inodes, so that subscribers can
eventually invalidate a cached security decision on that inode.

On a file digest cache reset, emit a DIGEST_CACHE_RESET notification also
for the parent directory digest cache and the inodes using it, since
requestors might have looked up digests through that digest cache. Those
requestors will see changes by performing another lookup.

On setting the RESET_USER bit, emit a notification only for the inode
signaled by the LSM hook, since only the link between that inode and its
digest cache is changing (due to changing the security.digest_list xattr).

Finally, free the notification list with digest_cache_notify_inodes_free(),
when the digest cache is freed.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/digest_cache.h     |  34 ++++++++
 security/digest_cache/Makefile   |   2 +-
 security/digest_cache/internal.h |  26 ++++++
 security/digest_cache/main.c     |  12 +++
 security/digest_cache/notifier.c | 135 +++++++++++++++++++++++++++++++
 security/digest_cache/reset.c    |  42 +++++++++-
 6 files changed, 248 insertions(+), 3 deletions(-)
 create mode 100644 security/digest_cache/notifier.c

diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
index 9db8128513ca..950f3a58a861 100644
--- a/include/linux/digest_cache.h
+++ b/include/linux/digest_cache.h
@@ -15,6 +15,28 @@
 
 struct digest_cache;
 
+/**
+ * enum digest_cache_event - Events occurring on a digest cache
+ *
+ * This enum lists all the events occurring on a digest cache, to be notified
+ * outside the digest_cache LSM.
+ */
+enum digest_cache_event {
+	DIGEST_CACHE_RESET,
+};
+
+/**
+ * struct digest_cache_event_data - Information on digest cache events
+ * @digest_cache: Digest cache
+ * @inode: Inode for which the digest cache was requested
+ *
+ * This structure holds information about events occurring on a digest cache.
+ */
+struct digest_cache_event_data {
+	struct digest_cache *digest_cache;
+	struct inode *inode;
+};
+
 /**
  * typedef digest_cache_found_t - Digest cache reference as numeric value
  *
@@ -48,6 +70,8 @@ int digest_cache_verif_set(struct file *file, const char *verif_id, void *data,
 			   size_t size);
 void *digest_cache_verif_get(struct digest_cache *digest_cache,
 			     const char *verif_id);
+int digest_cache_register_notifier(struct notifier_block *nb);
+int digest_cache_unregister_notifier(struct notifier_block *nb);
 
 #else
 static inline struct digest_cache *digest_cache_get(struct dentry *dentry)
@@ -79,5 +103,15 @@ static inline void *digest_cache_verif_get(struct digest_cache *digest_cache,
 	return NULL;
 }
 
+static inline int digest_cache_register_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int digest_cache_unregister_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_SECURITY_DIGEST_CACHE */
 #endif /* _LINUX_DIGEST_CACHE_H */
diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makefile
index 3d5e600a2c45..7577b099c170 100644
--- a/security/digest_cache/Makefile
+++ b/security/digest_cache/Makefile
@@ -5,7 +5,7 @@
 obj-$(CONFIG_SECURITY_DIGEST_CACHE) += digest_cache.o
 
 digest_cache-y := main.o secfs.o htable.o populate.o modsig.o verif.o dir.o \
-		  reset.o
+		  reset.o notifier.o
 
 digest_cache-y += parsers/tlv.o
 digest_cache-y += parsers/rpm.o
diff --git a/security/digest_cache/internal.h b/security/digest_cache/internal.h
index c816929c4743..d930132cc963 100644
--- a/security/digest_cache/internal.h
+++ b/security/digest_cache/internal.h
@@ -21,6 +21,19 @@
 #define RESET			4	/* Digest cache to be recreated. */
 #define RESET_USER		5	/* Dig_user pointer to be released. */
 
+/**
+ * struct notify_inode - Structure with inode for which notification is emitted
+ * @list: Linked list
+ * @inode: Inode for which a notification is emitted
+ *
+ * This structure contains an inode for which a notification of a digest cache
+ * event is emitted.
+ */
+struct notify_inode {
+	struct list_head list;
+	struct inode *inode;
+};
+
 /**
  * struct readdir_callback - Structure to store information for dir iteration
  * @ctx: Context structure
@@ -126,6 +139,7 @@ struct htable {
  * @path_str: Path of the digest list the digest cache was created from
  * @flags: Control flags
  * @verif_data: Verification data regarding the digest list
+ * @notify_inodes: List of inodes for which a notification is emitted
  * @mutex: Protect digest cache modifications
  *
  * This structure represents a cache of digests extracted from a digest list.
@@ -137,6 +151,7 @@ struct digest_cache {
 	char *path_str;
 	unsigned long flags;
 	struct list_head verif_data;
+	struct list_head notify_inodes;
 	struct mutex mutex;
 };
 
@@ -261,4 +276,15 @@ void digest_cache_inode_post_setxattr(struct dentry *dentry, const char *name,
 void digest_cache_inode_post_removexattr(struct dentry *dentry,
 					 const char *name);
 
+/* notifier.c */
+int digest_cache_notify_inode_add(struct digest_cache *digest_cache,
+				  struct inode *inode);
+void digest_cache_notify_inodes_free(struct digest_cache *digest_cache);
+void digest_cache_notify(struct digest_cache *digest_cache, struct inode *inode,
+			 enum digest_cache_event event);
+void digest_cache_notify_multiple(struct digest_cache *digest_cache,
+				  enum digest_cache_event event);
+int digest_cache_register_notifier(struct notifier_block *nb);
+int digest_cache_unregister_notifier(struct notifier_block *nb);
+
 #endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
index ce3518a33c80..6fe0864f938f 100644
--- a/security/digest_cache/main.c
+++ b/security/digest_cache/main.c
@@ -51,6 +51,7 @@ static struct digest_cache *digest_cache_alloc_init(char *path_str,
 	INIT_LIST_HEAD(&digest_cache->htables);
 	INIT_LIST_HEAD(&digest_cache->verif_data);
 	INIT_LIST_HEAD(&digest_cache->dir_entries);
+	INIT_LIST_HEAD(&digest_cache->notify_inodes);
 	mutex_init(&digest_cache->mutex);
 
 	pr_debug("New digest cache %s (ref count: %d)\n",
@@ -70,6 +71,7 @@ static void digest_cache_free(struct digest_cache *digest_cache)
 	digest_cache_htable_free(digest_cache);
 	digest_cache_verif_free(digest_cache);
 	digest_cache_dir_free(digest_cache);
+	digest_cache_notify_inodes_free(digest_cache);
 	mutex_destroy(&digest_cache->mutex);
 
 	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
@@ -398,6 +400,7 @@ struct digest_cache *digest_cache_get(struct dentry *dentry)
 	struct digest_cache_security *dig_sec;
 	struct digest_cache *digest_cache = NULL;
 	struct inode *inode = d_backing_inode(dentry);
+	int ret;
 
 	if (!digest_cache_enabled)
 		return NULL;
@@ -420,6 +423,15 @@ struct digest_cache *digest_cache_get(struct dentry *dentry)
 		/* Consume extra reference from digest_cache_create(). */
 		dig_sec->dig_user = digest_cache_new(dentry);
 		up_read(&default_path_sem);
+
+		if (dig_sec->dig_user) {
+			ret = digest_cache_notify_inode_add(dig_sec->dig_user,
+							    inode);
+			if (ret < 0) {
+				digest_cache_put(dig_sec->dig_user);
+				dig_sec->dig_user = NULL;
+			}
+		}
 	}
 
 	if (dig_sec->dig_user)
diff --git a/security/digest_cache/notifier.c b/security/digest_cache/notifier.c
new file mode 100644
index 000000000000..06e4730e4434
--- /dev/null
+++ b/security/digest_cache/notifier.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the notifier of the digest_cache LSM.
+ */
+
+#define pr_fmt(fmt) "DIGEST CACHE: "fmt
+
+#include "internal.h"
+
+static BLOCKING_NOTIFIER_HEAD(chain);
+
+static const char * const events_str[] = {
+	[DIGEST_CACHE_RESET] = __stringify(DIGEST_CACHE_RESET),
+};
+
+/**
+ * digest_cache_notify_inode_add - Add inode to digest cache notification list
+ * @digest_cache: Digest cache
+ * @inode: Inode to add
+ *
+ * This function adds an inode to the digest cache notification list, so that
+ * notifications are emitted for that inode.
+ *
+ * Return: Zero on success, -ENOMEM on error.
+ */
+int digest_cache_notify_inode_add(struct digest_cache *digest_cache,
+				  struct inode *inode)
+{
+	struct notify_inode *notify_inode;
+
+	notify_inode = kmalloc(sizeof(*notify_inode), GFP_KERNEL);
+	if (!notify_inode)
+		return -ENOMEM;
+
+	notify_inode->inode = inode;
+
+	mutex_lock(&digest_cache->mutex);
+	list_add_tail(&notify_inode->list, &digest_cache->notify_inodes);
+	pr_debug("Added inode %lu to notification list of digest cache %s\n",
+		 inode->i_ino, digest_cache->path_str);
+	mutex_unlock(&digest_cache->mutex);
+	return 0;
+}
+
+/**
+ * digest_cache_notify_inodes_free - Free digest cache notification list
+ * @digest_cache: Digest cache
+ *
+ * This function removes all inodes from the notification list of the passed
+ * digest cache and frees the memory. Does not need locking, since it is called
+ * only at the time the digest cache is freed.
+ */
+void digest_cache_notify_inodes_free(struct digest_cache *digest_cache)
+{
+	struct notify_inode *p, *q;
+
+	list_for_each_entry_safe(p, q, &digest_cache->notify_inodes, list) {
+		list_del(&p->list);
+		pr_debug("Removed inode %lu from notification list of digest cache %s\n",
+			 p->inode->i_ino, digest_cache->path_str);
+		kfree(p);
+	}
+}
+
+/**
+ * digest_cache_notify - Emit notification for an inode
+ * @digest_cache: Digest cache
+ * @inode: Inode for which a digest cache is used
+ * @event: Event to notify
+ *
+ * This function emits a notification of a digest cache event for an affected
+ * inode.
+ */
+void digest_cache_notify(struct digest_cache *digest_cache, struct inode *inode,
+			 enum digest_cache_event event)
+{
+	struct digest_cache_event_data event_data = {
+		.digest_cache = digest_cache,
+		.inode = inode,
+	};
+
+	pr_debug("Notify event %s for inode %lu using digest cache %s\n",
+		 events_str[event], inode->i_ino, digest_cache->path_str);
+
+	blocking_notifier_call_chain(&chain, event, &event_data);
+}
+
+/**
+ * digest_cache_notify_multiple - Emit notification for all inodes in the list
+ * @digest_cache: Digest cache
+ * @event: Event to notify
+ *
+ * This function emits a notification for all inodes in the notification list
+ * of the passed digest cache.
+ */
+void digest_cache_notify_multiple(struct digest_cache *digest_cache,
+				  enum digest_cache_event event)
+{
+	struct notify_inode *p;
+
+	list_for_each_entry(p, &digest_cache->notify_inodes, list)
+		digest_cache_notify(digest_cache, p->inode, event);
+}
+
+/**
+ * digest_cache_register_notifier() - Register a digest cache notifier
+ * @nb: Notifier block with the callback
+ *
+ * This function registers a new notifier for events occurring on digest caches.
+ *
+ * Return: Zero on success, -EEXIST on error.
+ */
+int digest_cache_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&chain, nb);
+}
+EXPORT_SYMBOL(digest_cache_register_notifier);
+
+/**
+ * digest_cache_unregister_notifier() - Unregister a digest cache notifier
+ * @nb: Notifier block with the callback
+ *
+ * This function unregisters a previously registered notifier.
+ *
+ * Return: Zero on success, -ENOENT on error.
+ */
+int digest_cache_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&chain, nb);
+}
+EXPORT_SYMBOL(digest_cache_unregister_notifier);
diff --git a/security/digest_cache/reset.c b/security/digest_cache/reset.c
index e07222b0e0e8..bb3b4108ba3b 100644
--- a/security/digest_cache/reset.c
+++ b/security/digest_cache/reset.c
@@ -10,6 +10,29 @@
 #define pr_fmt(fmt) "DIGEST CACHE: "fmt
 #include "internal.h"
 
+/**
+ * digest_cache_notify_dir_entry_reset - Notify dir entry reset
+ * @dir: Directory containing the digest lists
+ *
+ * Emit a notification for the directory containing the digest lists about a
+ * reset occurring on a directory entry.
+ */
+
+static void digest_cache_notify_dir_entry_reset(struct inode *dir)
+{
+	struct digest_cache_security *dir_dig_sec;
+
+	dir_dig_sec = digest_cache_get_security(dir);
+	if (unlikely(!dir_dig_sec))
+		return;
+
+	mutex_lock(&dir_dig_sec->dig_owner_mutex);
+	if (dir_dig_sec->dig_owner)
+		digest_cache_notify_multiple(dir_dig_sec->dig_owner,
+					     DIGEST_CACHE_RESET);
+	mutex_unlock(&dir_dig_sec->dig_owner_mutex);
+}
+
 /**
  * digest_cache_reset_owner - Reset dig_owner
  * @inode: Inode of the digest list/directory containing the digest list
@@ -19,6 +42,9 @@
  * (if unset), so that digest_cache_get() and digest_cache_create() respectively
  * release and clear dig_user and dig_owner in the inode security blob. This
  * causes new callers of digest_cache_get() to get a new digest cache.
+ *
+ * After setting RESET, it emits a notification for all inodes using the digest
+ * cache.
  */
 static void digest_cache_reset_owner(struct inode *inode, const char *reason)
 {
@@ -30,9 +56,12 @@ static void digest_cache_reset_owner(struct inode *inode, const char *reason)
 
 	mutex_lock(&dig_sec->dig_owner_mutex);
 	if (dig_sec->dig_owner &&
-	    !test_and_set_bit(RESET, &dig_sec->dig_owner->flags))
+	    !test_and_set_bit(RESET, &dig_sec->dig_owner->flags)) {
 		pr_debug("Resetting %s (dig_owner), reason: %s\n",
 			 dig_sec->dig_owner->path_str, reason);
+		digest_cache_notify_multiple(dig_sec->dig_owner,
+					     DIGEST_CACHE_RESET);
+	}
 	mutex_unlock(&dig_sec->dig_owner_mutex);
 }
 
@@ -55,9 +84,12 @@ static void digest_cache_reset_user(struct inode *inode, const char *reason)
 
 	mutex_lock(&dig_sec->dig_user_mutex);
 	if (dig_sec->dig_user &&
-	    !test_and_set_bit(RESET_USER, &dig_sec->dig_user->flags))
+	    !test_and_set_bit(RESET_USER, &dig_sec->dig_user->flags)) {
 		pr_debug("Resetting %s (dig_user), reason: %s\n",
 			 dig_sec->dig_user->path_str, reason);
+		digest_cache_notify(dig_sec->dig_user, inode,
+				    DIGEST_CACHE_RESET);
+	}
 	mutex_unlock(&dig_sec->dig_user_mutex);
 }
 
@@ -74,11 +106,14 @@ static void digest_cache_reset_user(struct inode *inode, const char *reason)
 int digest_cache_path_truncate(const struct path *path)
 {
 	struct inode *inode = d_backing_inode(path->dentry);
+	struct inode *dir = d_backing_inode(path->dentry->d_parent);
 
 	if (!S_ISREG(inode->i_mode))
 		return 0;
 
 	digest_cache_reset_owner(inode, "file_truncate");
+	/* Dir digest cache users should know a dir entry changed. */
+	digest_cache_notify_dir_entry_reset(dir);
 	return 0;
 }
 
@@ -101,6 +136,9 @@ void digest_cache_file_release(struct file *file)
 	digest_cache_reset_owner(file_inode(file), "file_file_release");
 	if (file->f_mode & FMODE_CREATED)
 		digest_cache_reset_owner(dir, "dir_file_release");
+	else
+		/* Dir digest cache users should know a dir entry changed. */
+		digest_cache_notify_dir_entry_reset(dir);
 }
 
 /**
-- 
2.34.1


