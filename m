Return-Path: <linux-kselftest+bounces-4434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B784F6A4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E031C21C00
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABE669970;
	Fri,  9 Feb 2024 14:10:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75469976;
	Fri,  9 Feb 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487824; cv=none; b=Z3ZV9CIKTgV+8tmhFB5V6iyj6uuB+5Y9Uye+uvqMNCzHxCs9ro89IdEiMnQpn+hgJNnjVs2yZ5Tw/vvH/TTZEl8xcdswnZVLL8e7s8HWnqUEGR/JVG/IkN8pmtJ4w8FXVURaKjujb47kLz+DZHcwrahozw8v3h9kFgDbjCXPNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487824; c=relaxed/simple;
	bh=FtGdvX9YI63Ar23I2/KUGB7L2F297IaeVuCkyiw9Z18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNngzK2q9fiPohTERrF1FqzJMRYE0vnZXztb9O4LwwzRvanymJeQ5WAowuwN7bGFSyxaqSUqXDpalRCb680P4Qd2QWavcTj4GECIN517OSfsM2sYhN1hf7FBQbKQD2n1sBbyBimp+EX6pEUQWqKL93xAZVDWsXUDvmY4So+nQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TWZyH6gLWz9xtPR;
	Fri,  9 Feb 2024 21:51:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 51FD7140732;
	Fri,  9 Feb 2024 22:10:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHshoZMsZlvXMuAg--.65105S4;
	Fri, 09 Feb 2024 15:10:12 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
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
	petrtesarik@huaweicloud.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 02/13] security: Introduce the digest_cache LSM
Date: Fri,  9 Feb 2024 15:09:06 +0100
Message-Id: <20240209140917.846878-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
References: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshoZMsZlvXMuAg--.65105S4
X-Coremail-Antispam: 1UD129KBjvAXoWfuw4kXF4xXFWUXFWxtw4ruFg_yoW5XF1fAo
	ZYyF47Jw10gFy7ur4kCF17Aa17u3ZYq3yxAr1kJrWDZF1IvFyDJasrCa1DJFy5Jr18GF97
	A34kJw4UJFWUtr93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOx7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M28IrcIa0x
	kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
	WIevJa73UjIFyTuYvjTRNiSHDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj5o4CgABsV

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the digest_cache LSM, to collect digests from various sources
(called digest lists), and to store them in kernel memory, in a set of hash
tables forming a digest cache. Extracted digests can be used as reference
values for integrity verification of file content or metadata.

A digest cache has three types of references: in the inode security blob of
the digest list the digest cache was created from (dig_owner field); in the
security blob of the inodes for which the digest cache is requested
(dig_user field); a reference returned by digest_cache_get().

References are released with digest_cache_put(), in the first two cases
when inodes are evicted from memory, in the last case when that function is
explicitly called. Obtaining a digest cache reference means that the digest
cache remains valid and cannot be freed until releasing it and until the
total number of references (stored in the digest cache) becomes zero.

When digest_cache_get() is called on an inode to compare its digest with
a reference value, the digest_cache LSM knows which digest cache to get
from the new security.digest_list xattr added to that inode, which contains
the file name of the desired digest list digests will be extracted from.

All digest lists are expected to be in the same directory, defined in the
kernel config, and modifiable (with a later patch) at run-time through
securityfs. When the digest_cache LSM reads the security.digest_list xattr,
it uses its value as last path component, appended to the default path
(unless the default path is a file). If an inode does not have that xattr,
the default path is considered as the final destination.

The default path can be either a file or a directory. If it is a file, the
digest_cache LSM always uses the same digest cache from that file to verify
all inodes (the xattr, if present, is ignored). If it is a directory, and
the inode to verify does not have the xattr, a subsequent patch will make
it possible to iterate and lookup on the digest caches created from each
directory entry.

Digest caches are created on demand, only when digest_cache_get() is
called. The first time a digest cache is requested, the digest_cache LSM
creates it and sets its reference in the dig_owner and dig_user fields of
the respective inode security blobs. On the next requests, the previously
set reference is returned, after incrementing the reference count.

Since there might be multiple digest_cache_get() calls for the same inode,
or for different inodes pointing to the same digest list, dig_owner_mutex
and dig_user_mutex have been introduced to protect the check and assignment
of the digest cache reference in the inode security blob.

Contenders that didn't get the lock also have to wait until the digest
cache is fully instantiated (when the bit INIT_IN_PROGRESS is cleared).
Dig_owner_mutex cannot be used for waiting on the instantiation to avoid
lock inversion with the inode lock for directories.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 MAINTAINERS                                   |   6 +
 include/linux/digest_cache.h                  |  32 ++
 include/uapi/linux/lsm.h                      |   1 +
 include/uapi/linux/xattr.h                    |   3 +
 security/Kconfig                              |  11 +-
 security/Makefile                             |   1 +
 security/digest_cache/Kconfig                 |  17 +
 security/digest_cache/Makefile                |   7 +
 security/digest_cache/internal.h              |  86 ++++
 security/digest_cache/main.c                  | 397 ++++++++++++++++++
 security/security.c                           |   3 +-
 .../selftests/lsm/lsm_list_modules_test.c     |   3 +
 12 files changed, 561 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/digest_cache.h
 create mode 100644 security/digest_cache/Kconfig
 create mode 100644 security/digest_cache/Makefile
 create mode 100644 security/digest_cache/internal.h
 create mode 100644 security/digest_cache/main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d3d13fb1004b..3e3236dd0b26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6155,6 +6155,12 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-gpio-mm.c
 
+DIGEST_CACHE LSM
+M:	Roberto Sassu <roberto.sassu@huawei.com>
+L:	linux-security-module@vger.kernel.org
+S:	Maintained
+F:	security/digest_cache/
+
 DIGITEQ AUTOMOTIVE MGB4 V4L2 DRIVER
 M:	Martin Tuma <martin.tuma@digiteqautomotive.com>
 L:	linux-media@vger.kernel.org
diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
new file mode 100644
index 000000000000..e79f94a60b0f
--- /dev/null
+++ b/include/linux/digest_cache.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Public API of the digest_cache LSM.
+ */
+
+#ifndef _LINUX_DIGEST_CACHE_H
+#define _LINUX_DIGEST_CACHE_H
+
+#include <linux/fs.h>
+
+struct digest_cache;
+
+#ifdef CONFIG_SECURITY_DIGEST_CACHE
+struct digest_cache *digest_cache_get(struct dentry *dentry);
+void digest_cache_put(struct digest_cache *digest_cache);
+
+#else
+static inline struct digest_cache *digest_cache_get(struct dentry *dentry)
+{
+	return NULL;
+}
+
+static inline void digest_cache_put(struct digest_cache *digest_cache)
+{
+}
+
+#endif /* CONFIG_SECURITY_DIGEST_CACHE */
+#endif /* _LINUX_DIGEST_CACHE_H */
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index f8aef9ade549..205d969f20ff 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -62,6 +62,7 @@ struct lsm_ctx {
 #define LSM_ID_LOCKDOWN		108
 #define LSM_ID_BPF		109
 #define LSM_ID_LANDLOCK		110
+#define LSM_ID_DIGEST_CACHE	111
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 9463db2dfa9d..8a58cf4bce65 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -54,6 +54,9 @@
 #define XATTR_IMA_SUFFIX "ima"
 #define XATTR_NAME_IMA XATTR_SECURITY_PREFIX XATTR_IMA_SUFFIX
 
+#define XATTR_DIGEST_LIST_SUFFIX "digest_list"
+#define XATTR_NAME_DIGEST_LIST XATTR_SECURITY_PREFIX XATTR_DIGEST_LIST_SUFFIX
+
 #define XATTR_SELINUX_SUFFIX "selinux"
 #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
 
diff --git a/security/Kconfig b/security/Kconfig
index 52c9af08ad35..99f99cbd94cc 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -194,6 +194,7 @@ source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
+source "security/digest_cache/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -233,11 +234,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
+	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
+	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
+	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list, except for those with order
diff --git a/security/Makefile b/security/Makefile
index 59f238490665..e9b43e7b715a 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
+obj-$(CONFIG_SECURITY_DIGEST_CACHE)	+= digest_cache/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kconfig
new file mode 100644
index 000000000000..0c47d5151f07
--- /dev/null
+++ b/security/digest_cache/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+config SECURITY_DIGEST_CACHE
+	bool "Digest_cache LSM"
+	default n
+	help
+	   This option enables an LSM maintaining a cache of digests
+	   (e.g. of file content or metadata).
+
+	   This LSM can support other kernel components in making access
+	   control decisions.
+
+config DIGEST_LIST_DEFAULT_PATH
+	string
+	default "/etc/digest_lists"
+	help
+	   Default directory where digest_cache LSM expects to find digest
+	   lists.
diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makefile
new file mode 100644
index 000000000000..48848c41253e
--- /dev/null
+++ b/security/digest_cache/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for building the digest_cache LSM.
+
+obj-$(CONFIG_SECURITY_DIGEST_CACHE) += digest_cache.o
+
+digest_cache-y := main.o
diff --git a/security/digest_cache/internal.h b/security/digest_cache/internal.h
new file mode 100644
index 000000000000..5f04844af3a5
--- /dev/null
+++ b/security/digest_cache/internal.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Internal header of the digest_cache LSM.
+ */
+
+#ifndef _DIGEST_CACHE_INTERNAL_H
+#define _DIGEST_CACHE_INTERNAL_H
+
+#include <linux/lsm_hooks.h>
+#include <linux/digest_cache.h>
+
+/* Digest cache bits in flags. */
+#define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
+
+/**
+ * struct digest_cache - Digest cache
+ * @ref_count: Number of references to the digest cache
+ * @path_str: Path of the digest list the digest cache was created from
+ * @flags: Control flags
+ *
+ * This structure represents a cache of digests extracted from a digest list.
+ */
+struct digest_cache {
+	atomic_t ref_count;
+	char *path_str;
+	unsigned long flags;
+};
+
+/**
+ * struct digest_cache_security - Digest cache pointers in inode security blob
+ * @dig_owner: Digest cache created from this inode
+ * @dig_owner_mutex: Protects @dig_owner
+ * @dig_user: Digest cache requested for this inode
+ * @dig_user_mutex: Protects @dig_user
+ *
+ * This structure contains references to digest caches, protected by their
+ * respective mutex.
+ */
+struct digest_cache_security {
+	struct digest_cache *dig_owner;
+	struct mutex dig_owner_mutex;
+	struct digest_cache *dig_user;
+	struct mutex dig_user_mutex;
+};
+
+extern struct lsm_blob_sizes digest_cache_blob_sizes;
+extern char *default_path_str;
+
+static inline struct digest_cache_security *
+digest_cache_get_security(const struct inode *inode)
+{
+	if (unlikely(!inode->i_security))
+		return NULL;
+
+	return inode->i_security + digest_cache_blob_sizes.lbs_inode;
+}
+
+static inline struct digest_cache *
+digest_cache_ref(struct digest_cache *digest_cache)
+{
+	atomic_inc(&digest_cache->ref_count);
+	pr_debug("Ref (+) digest cache %s (ref count: %d)\n",
+		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
+	return digest_cache;
+}
+
+static inline struct digest_cache *
+digest_cache_unref(struct digest_cache *digest_cache)
+{
+	bool ref_is_zero = atomic_dec_and_test(&digest_cache->ref_count);
+
+	pr_debug("Ref (-) digest cache %s (ref count: %d)\n",
+		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
+	return (ref_is_zero) ? digest_cache : NULL;
+}
+
+/* main.c */
+struct digest_cache *digest_cache_create(struct dentry *dentry,
+					 struct path *digest_list_path,
+					 char *path_str, char *filename);
+
+#endif /* _DIGEST_CACHE_INTERNAL_H */
diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
new file mode 100644
index 000000000000..166798e6247e
--- /dev/null
+++ b/security/digest_cache/main.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the main code of the digest_cache LSM.
+ */
+
+#define pr_fmt(fmt) "DIGEST CACHE: "fmt
+#include <linux/namei.h>
+#include <linux/xattr.h>
+
+#include "internal.h"
+
+static int digest_cache_enabled __ro_after_init = 1;
+static struct kmem_cache *digest_cache_cache __read_mostly;
+
+char *default_path_str = CONFIG_DIGEST_LIST_DEFAULT_PATH;
+
+/**
+ * digest_cache_alloc_init - Allocate and initialize a new digest cache
+ * @path_str: Path string of the digest list
+ * @filename: Digest list file name (can be an empty string)
+ *
+ * This function allocates and initializes a new digest cache.
+ *
+ * Return: A digest_cache structure on success, NULL on error.
+ */
+static struct digest_cache *digest_cache_alloc_init(char *path_str,
+						    char *filename)
+{
+	struct digest_cache *digest_cache;
+
+	digest_cache = kmem_cache_alloc(digest_cache_cache, GFP_KERNEL);
+	if (!digest_cache)
+		return digest_cache;
+
+	digest_cache->path_str = kasprintf(GFP_KERNEL, "%s%s%s", path_str,
+					   filename[0] ? "/" : "", filename);
+	if (!digest_cache->path_str) {
+		kmem_cache_free(digest_cache_cache, digest_cache);
+		return NULL;
+	}
+
+	atomic_set(&digest_cache->ref_count, 1);
+	digest_cache->flags = 0UL;
+
+	pr_debug("New digest cache %s (ref count: %d)\n",
+		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
+
+	return digest_cache;
+}
+
+/**
+ * digest_cache_free - Free all memory occupied by the digest cache
+ * @digest_cache: Digest cache
+ *
+ * This function frees the memory occupied by the digest cache.
+ */
+static void digest_cache_free(struct digest_cache *digest_cache)
+{
+	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
+	kfree(digest_cache->path_str);
+	kmem_cache_free(digest_cache_cache, digest_cache);
+}
+
+/**
+ * digest_cache_create - Create a digest cache
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ * @digest_list_path: Path structure of the digest list
+ * @path_str: Path string of the digest list
+ * @filename: Digest list file name (can be an empty string)
+ *
+ * This function first locates, from the passed path, the digest list inode
+ * from which the digest cache will be created or retrieved (if it already
+ * exists).
+ *
+ * If dig_owner is NULL in the inode security blob, this function creates a
+ * new digest cache with reference count set to 1 (reference returned), sets
+ * it to dig_owner and consequently increments again the digest cache reference
+ * count.
+ *
+ * Otherwise, it simply increments the reference count of the existing
+ * dig_owner, since that reference is returned to the caller.
+ *
+ * Incrementing the reference count twice before calling path_put() ensures
+ * that the digest cache returned is valid even if the inode is evicted from
+ * memory (which decreases the reference count).
+ *
+ * Releasing the dig_owner_mutex lock does not mean that the digest cache is
+ * ready for use. digest_cache_create() callers that found a partially
+ * instantiated digest cache have to wait until the INIT_IN_PROGRESS bit is
+ * cleared by the caller that is actually creating that digest cache.
+ *
+ * Return: A new digest cache on success, NULL on error.
+ */
+struct digest_cache *digest_cache_create(struct dentry *dentry,
+					 struct path *digest_list_path,
+					 char *path_str, char *filename)
+{
+	struct path file_path;
+	struct digest_cache *digest_cache = NULL;
+	struct digest_cache_security *dig_sec;
+	struct inode *inode = d_backing_inode(digest_list_path->dentry);
+	bool dig_owner_exists = false;
+	int ret;
+
+	if (S_ISDIR(d_backing_inode(digest_list_path->dentry)->i_mode) &&
+	    filename[0]) {
+		ret = vfs_path_lookup(digest_list_path->dentry,
+				      digest_list_path->mnt, filename, 0,
+				      &file_path);
+		if (ret < 0) {
+			pr_debug("Cannot find digest list %s/%s\n", path_str,
+				 filename);
+			return NULL;
+		}
+
+		digest_list_path = &file_path;
+		inode = d_backing_inode(file_path.dentry);
+
+		/*
+		 * Cannot request a digest cache for the same inode the
+		 * digest cache is populated from.
+		 */
+		if (d_backing_inode(dentry) == inode)
+			return NULL;
+
+		/* No support for nested directories. */
+		if (!S_ISREG(inode->i_mode))
+			return NULL;
+	}
+
+	dig_sec = digest_cache_get_security(inode);
+	if (unlikely(!dig_sec))
+		goto out;
+
+	/* Serialize check and assignment of dig_owner. */
+	mutex_lock(&dig_sec->dig_owner_mutex);
+	if (dig_sec->dig_owner) {
+		/* Increment ref. count for reference returned to the caller. */
+		digest_cache = digest_cache_ref(dig_sec->dig_owner);
+		dig_owner_exists = true;
+		mutex_unlock(&dig_sec->dig_owner_mutex);
+		goto exists;
+	}
+
+	/* Ref. count is already 1 for this reference. */
+	digest_cache = digest_cache_alloc_init(path_str, filename);
+	if (!digest_cache) {
+		mutex_unlock(&dig_sec->dig_owner_mutex);
+		goto out;
+	}
+
+	/* Increment ref. count for reference set to dig_owner. */
+	dig_sec->dig_owner = digest_cache_ref(digest_cache);
+
+	/* Make the other lock contenders wait until creation complete. */
+	set_bit(INIT_IN_PROGRESS, &dig_sec->dig_owner->flags);
+	mutex_unlock(&dig_sec->dig_owner_mutex);
+
+	/* Creation complete, notify the other lock contenders. */
+	clear_and_wake_up_bit(INIT_IN_PROGRESS, &dig_sec->dig_owner->flags);
+exists:
+	if (dig_owner_exists)
+		/* Wait until creation complete. */
+		wait_on_bit(&dig_sec->dig_owner->flags, INIT_IN_PROGRESS,
+			    TASK_UNINTERRUPTIBLE);
+out:
+	if (digest_list_path == &file_path)
+		path_put(&file_path);
+
+	return digest_cache;
+}
+
+/**
+ * digest_cache_new - Retrieve digest list file name and request digest cache
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ *
+ * This function locates the default path. If it is a file, it directly creates
+ * a digest cache from it. Otherwise, it reads the digest list file name from
+ * the security.digest_list xattr and requests the creation of a digest cache
+ * with that file name. If security.digest_list is not found, this function
+ * requests the creation of a digest cache on the parent directory.
+ *
+ * Return: A new digest cache on success, NULL on error.
+ */
+static struct digest_cache *digest_cache_new(struct dentry *dentry)
+{
+	char filename[NAME_MAX + 1] = { 0 };
+	struct digest_cache *digest_cache = NULL;
+	struct path default_path;
+	int ret;
+
+	ret = kern_path(default_path_str, 0, &default_path);
+	if (ret < 0) {
+		pr_debug("Cannot find path %s\n", default_path_str);
+		return NULL;
+	}
+
+	/* The default path is a file, no need to get xattr. */
+	if (S_ISREG(d_backing_inode(default_path.dentry)->i_mode)) {
+		pr_debug("Default path %s is a file, not reading %s xattr\n",
+			 default_path_str, XATTR_NAME_DIGEST_LIST);
+		goto create;
+	} else if (!S_ISDIR(d_backing_inode(default_path.dentry)->i_mode)) {
+		pr_debug("Default path %s must be either a file or a directory\n",
+			 default_path_str);
+		goto out;
+	}
+
+	ret = vfs_getxattr(&nop_mnt_idmap, dentry, XATTR_NAME_DIGEST_LIST,
+			   filename, sizeof(filename) - 1);
+	if (ret <= 0) {
+		pr_debug("Digest list path not found for file %s, using %s\n",
+			 dentry->d_name.name, default_path_str);
+		goto create;
+	}
+
+	if (strchr(filename, '/')) {
+		pr_debug("%s xattr should contain only a file name, got: %s\n",
+			 XATTR_NAME_DIGEST_LIST, filename);
+		goto out;
+	}
+
+	pr_debug("Found %s xattr in %s, default path: %s, digest list: %s\n",
+		 XATTR_NAME_DIGEST_LIST, dentry->d_name.name, default_path_str,
+		 filename);
+create:
+	digest_cache = digest_cache_create(dentry, &default_path,
+					   default_path_str, filename);
+out:
+	path_put(&default_path);
+	return digest_cache;
+}
+
+/**
+ * digest_cache_get - Get a digest cache for a given inode
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ *
+ * This function tries to find a digest cache from the inode security blob of
+ * the passed dentry (dig_user field). If a digest cache was not found, it calls
+ * digest_cache_new() to create a new one. In both cases, it increments the
+ * digest cache reference count before returning the reference to the caller.
+ *
+ * The caller is responsible to call digest_cache_put() to release the digest
+ * cache reference returned.
+ *
+ * Lock dig_user_mutex to protect against concurrent requests to obtain a digest
+ * cache for the same inode, and to make other contenders wait until the first
+ * requester finishes the process.
+ *
+ * Return: A digest cache on success, NULL otherwise.
+ */
+struct digest_cache *digest_cache_get(struct dentry *dentry)
+{
+	struct digest_cache_security *dig_sec;
+	struct digest_cache *digest_cache = NULL;
+
+	if (!digest_cache_enabled)
+		return NULL;
+
+	dig_sec = digest_cache_get_security(d_backing_inode(dentry));
+	if (unlikely(!dig_sec))
+		return NULL;
+
+	/* Serialize accesses to inode for which the digest cache is used. */
+	mutex_lock(&dig_sec->dig_user_mutex);
+	if (!dig_sec->dig_user)
+		/* Consume extra reference from digest_cache_create(). */
+		dig_sec->dig_user = digest_cache_new(dentry);
+
+	if (dig_sec->dig_user)
+		/* Increment ref. count for reference returned to the caller. */
+		digest_cache = digest_cache_ref(dig_sec->dig_user);
+
+	mutex_unlock(&dig_sec->dig_user_mutex);
+	return digest_cache;
+}
+EXPORT_SYMBOL_GPL(digest_cache_get);
+
+/**
+ * digest_cache_put - Release a digest cache reference
+ * @digest_cache: Digest cache
+ *
+ * This function decrements the reference count of the digest cache passed as
+ * argument. If the reference count reaches zero, it calls digest_cache_free()
+ * to free the digest cache.
+ */
+void digest_cache_put(struct digest_cache *digest_cache)
+{
+	struct digest_cache *to_free;
+
+	to_free = digest_cache_unref(digest_cache);
+	if (!to_free)
+		return;
+
+	digest_cache_free(to_free);
+}
+EXPORT_SYMBOL_GPL(digest_cache_put);
+
+struct lsm_blob_sizes digest_cache_blob_sizes __ro_after_init = {
+	.lbs_inode = sizeof(struct digest_cache_security),
+};
+
+/**
+ * digest_cache_inode_alloc_security - Initialize inode security blob
+ * @inode: Inode for which the security blob is initialized
+ *
+ * This function initializes the digest_cache_security structure, directly
+ * stored in the inode security blob.
+ *
+ * Return: Zero.
+ */
+static int digest_cache_inode_alloc_security(struct inode *inode)
+{
+	struct digest_cache_security *dig_sec;
+
+	/* The inode security blob is always allocated here. */
+	dig_sec = digest_cache_get_security(inode);
+	mutex_init(&dig_sec->dig_owner_mutex);
+	mutex_init(&dig_sec->dig_user_mutex);
+	return 0;
+}
+
+/**
+ * digest_cache_inode_free_security - Release the digest cache references
+ * @inode: Inode for which the digest cache references are released
+ *
+ * Since the inode is being evicted, this function releases the non-needed
+ * references to the digest_caches stored in the digest_cache_security
+ * structure.
+ */
+static void digest_cache_inode_free_security(struct inode *inode)
+{
+	struct digest_cache_security *dig_sec;
+
+	dig_sec = digest_cache_get_security(inode);
+	if (!dig_sec)
+		return;
+
+	mutex_destroy(&dig_sec->dig_owner_mutex);
+	mutex_destroy(&dig_sec->dig_user_mutex);
+	if (dig_sec->dig_owner)
+		digest_cache_put(dig_sec->dig_owner);
+	if (dig_sec->dig_user)
+		digest_cache_put(dig_sec->dig_user);
+}
+
+static struct security_hook_list digest_cache_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(inode_alloc_security, digest_cache_inode_alloc_security),
+	LSM_HOOK_INIT(inode_free_security, digest_cache_inode_free_security),
+};
+
+/**
+ * digest_cache_init_once - Initialize the digest cache structure
+ * @foo: Digest cache structure to initialize
+ *
+ * This function fills the digest cache structure with zeros.
+ */
+static void digest_cache_init_once(void *foo)
+{
+	struct digest_cache *digest_cache = (struct digest_cache *)foo;
+
+	memset(digest_cache, 0, sizeof(*digest_cache));
+}
+
+static const struct lsm_id digest_cache_lsmid = {
+	.name = "digest_cache",
+	.id = LSM_ID_DIGEST_CACHE,
+};
+
+/**
+ * digest_cache_init - Initialize the digest_cache LSM
+ *
+ * Initialize the digest_cache LSM, by instantiating a cache for the
+ * digest_cache structure and by registering the digest_cache LSM hooks.
+ */
+static int __init digest_cache_init(void)
+{
+	digest_cache_cache = kmem_cache_create("digest_cache_cache",
+					       sizeof(struct digest_cache),
+					       0, SLAB_PANIC,
+					       digest_cache_init_once);
+
+	security_add_hooks(digest_cache_hooks, ARRAY_SIZE(digest_cache_hooks),
+			   &digest_cache_lsmid);
+	return 0;
+}
+
+DEFINE_LSM(digest_cache) = {
+	.name = "digest_cache",
+	.enabled = &digest_cache_enabled,
+	.init = digest_cache_init,
+	.blobs = &digest_cache_blob_sizes,
+};
diff --git a/security/security.c b/security/security.c
index da827d7cbad8..570f52d534f8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -50,7 +50,8 @@
 	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
+	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_DIGEST_CACHE) ? 1 : 0))
 
 /*
  * These are descriptions of the reasons that can be passed to the
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
index 9df29b1e3497..24fb9c038434 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -122,6 +122,9 @@ TEST(correct_lsm_list_modules)
 		case LSM_ID_LANDLOCK:
 			name = "landlock";
 			break;
+		case LSM_ID_DIGEST_CACHE:
+			name = "digest_cache";
+			break;
 		default:
 			name = "INVALID";
 			break;
-- 
2.34.1


