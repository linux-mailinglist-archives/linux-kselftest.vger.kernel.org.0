Return-Path: <linux-kselftest+bounces-17259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C97096DD5C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4BBB28202
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D9D1A00D2;
	Thu,  5 Sep 2024 15:07:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E7B19F466;
	Thu,  5 Sep 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548849; cv=none; b=h0WgCQd1hixhaIV68bDc7Gmqr2BBhX8q36Mg7BPXXZDxO4i6zTzsfvFtXOam9QmkgZpLMfuhklD9Qf9LGnsaaIUdKP5AUpMJh6CITtDy8ZWcfZzQDzTd5VN4wI6iGCS9CcxSvA6mWKVQdAuP/kllx/e8xJFHRpk6tS4LZGc1S8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548849; c=relaxed/simple;
	bh=zJ9fGbgpW2uhAFqjSpJm4/ZZVqlljgAr6Gy3scDWJhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rg6pj9mULP0ewTFRLYcRvtEb2ywQMFCS54EZ0X//SyTMgsfRUfXDO3bJwlt0MCuzuyunbP5L/U9n1v0ieMM86CmSDDAv7P42jS79xyUGj/QryODw4FGxxQtzlPDDkOKXqolQLuNLWK7bz4ucqmt7VnbtdBMtRDKLihc2f35GUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X02KJ4jjSz9v7NF;
	Thu,  5 Sep 2024 22:48:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 9161E14061D;
	Thu,  5 Sep 2024 23:07:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXZy_myNlmE0tUAA--.16274S5;
	Thu, 05 Sep 2024 16:07:13 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
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
Subject: [PATCH v5 03/14] digest_cache: Initialize digest caches
Date: Thu,  5 Sep 2024 17:05:32 +0200
Message-Id: <20240905150543.3766895-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
References: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXZy_myNlmE0tUAA--.16274S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr13urWrGr1DCw1xXr4rAFb_yoWxJF1kpa
	9Fk3W5Krs5ZryfCw17A3W2yw4Fqr9YqF47Jws8ur1ayFs3ur1qv3WIyw1UZryUJr4Uua17
	tr45K3WUCr1UXaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jSiihUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGbZE-oKmgAAsR

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce digest_cache_init() to initialize created digest caches. Since
initialization happens after releasing both the dig_owner_mutex and
dig_user_mutex locks (to avoid a lock inversion with VFS locks), any caller
of digest_cache_get() can potentially be in charge of initializing them.

Introduce the INIT_STARTED flag, to atomically determine whether the digest
cache is being initialized and eventually do it if the flag is not yet set.

Introduce the INIT_IN_PROGRESS flag, for the other callers to wait until
the caller in charge of the initialization finishes initializing the digest
cache. Set INIT_IN_PROGRESS in digest_cache_create() and clear it in
digest_cache_init(). Finally, call clear_and_wake_up_bit() to wake up the
other callers.

To avoid that the inode the digest cache is created from is evicted or
is different due to a path rename between creation and initialization, take
the path at creation time, and use it at initialization time. Since the
digest cache holds a path reference, the inode cannot be evicted or change.
However, care must be taken to ensure that digest_cache_init() is always
executed after digest_cache_create() or, otherwise, the path reference will
not be released.

Finally, introduce the INVALID flag, to let the callers which didn't
initialize the digest cache know that an error occurred during
initialization and, consequently, prevent them from using that digest
cache.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/digest_cache/internal.h |  9 ++++
 security/integrity/digest_cache/main.c     | 51 ++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index e8a13afaf2fc..54e118a2ef79 100644
--- a/security/integrity/digest_cache/internal.h
+++ b/security/integrity/digest_cache/internal.h
@@ -13,11 +13,17 @@
 #include <linux/lsm_hooks.h>
 #include <linux/digest_cache.h>
 
+/* Digest cache bits in flags. */
+#define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
+#define INIT_STARTED		1	/* Digest cache init started. */
+#define INVALID			2	/* Digest cache marked as invalid. */
+
 /**
  * struct digest_cache - Digest cache
  * @ref_count: Number of references to the digest cache
  * @path_str: Path of the digest list the digest cache was created from
  * @flags: Control flags
+ * @digest_list_path: Path structure of the digest list
  *
  * This structure represents a cache of digests extracted from a digest list.
  */
@@ -25,6 +31,7 @@ struct digest_cache {
 	atomic_t ref_count;
 	char *path_str;
 	unsigned long flags;
+	struct path digest_list_path;
 };
 
 /**
@@ -84,6 +91,8 @@ digest_cache_unref(struct digest_cache *digest_cache)
 struct digest_cache *digest_cache_create(struct dentry *dentry,
 					 struct path *digest_list_path,
 					 char *path_str, char *filename);
+struct digest_cache *digest_cache_init(struct dentry *dentry,
+				       struct digest_cache *digest_cache);
 int __init digest_cache_do_init(const struct lsm_id *lsm_id,
 				loff_t inode_offset);
 
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index 60030df04a4d..188f1dcc880e 100644
--- a/security/integrity/digest_cache/main.c
+++ b/security/integrity/digest_cache/main.c
@@ -154,6 +154,14 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 
 	/* Increment ref. count for reference returned to the caller. */
 	digest_cache = digest_cache_ref(dig_sec->dig_owner);
+
+	/* Make other digest cache requestors wait until creation complete. */
+	set_bit(INIT_IN_PROGRESS, &digest_cache->flags);
+
+	/* Get the digest list path for initialization. */
+	digest_cache->digest_list_path.dentry = digest_list_path->dentry;
+	digest_cache->digest_list_path.mnt = digest_list_path->mnt;
+	path_get(&digest_cache->digest_list_path);
 	mutex_unlock(&dig_sec->dig_owner_mutex);
 out:
 	if (digest_list_path == &file_path)
@@ -226,6 +234,45 @@ static struct digest_cache *digest_cache_new(struct dentry *dentry)
 	return digest_cache;
 }
 
+/**
+ * digest_cache_init - Initialize a digest cache
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ * @digest_cache: Digest cache to initialize
+ *
+ * This function checks if the INIT_STARTED digest cache flag is set. If it is,
+ * it waits until the caller that saw INIT_STARTED unset completes the
+ * initialization.
+ *
+ * Otherwise, it sets INIT_STARTED (atomically), performs the initialization,
+ * clears the INIT_IN_PROGRESS digest cache flag, and wakes up the other
+ * callers.
+ *
+ * Return: A valid and initialized digest cache.
+ */
+struct digest_cache *digest_cache_init(struct dentry *dentry,
+				       struct digest_cache *digest_cache)
+{
+	/* Wait for digest cache initialization. */
+	if (test_and_set_bit(INIT_STARTED, &digest_cache->flags)) {
+		wait_on_bit(&digest_cache->flags, INIT_IN_PROGRESS,
+			    TASK_UNINTERRUPTIBLE);
+		goto out;
+	}
+
+	path_put(&digest_cache->digest_list_path);
+	/* Notify initialization complete. */
+	clear_and_wake_up_bit(INIT_IN_PROGRESS, &digest_cache->flags);
+out:
+	if (test_bit(INVALID, &digest_cache->flags)) {
+		pr_debug("Digest cache %s is invalid, don't return it\n",
+			 digest_cache->path_str);
+		digest_cache_put(digest_cache);
+		digest_cache = NULL;
+	}
+
+	return digest_cache;
+}
+
 /**
  * digest_cache_get - Get a digest cache for a given inode
  * @dentry: Dentry of the inode for which the digest cache will be used
@@ -268,6 +315,10 @@ struct digest_cache *digest_cache_get(struct dentry *dentry)
 
 	mutex_unlock(&dig_sec->dig_user_mutex);
 
+	if (digest_cache)
+		/* This must be always executed, or path ref. is not released.*/
+		digest_cache = digest_cache_init(dentry, digest_cache);
+
 	return digest_cache;
 }
 EXPORT_SYMBOL_GPL(digest_cache_get);
-- 
2.34.1


