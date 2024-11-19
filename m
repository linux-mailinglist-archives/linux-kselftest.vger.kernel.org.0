Return-Path: <linux-kselftest+bounces-22253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49819D23E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1937DB256E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240BC1C4606;
	Tue, 19 Nov 2024 10:51:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE11C07F9;
	Tue, 19 Nov 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013492; cv=none; b=lclY/qEBTWC4xu0wYkVHm6Bw8RrcwGyN61N/dN+FX93PApyz0IHsfi4neMBwpAG9sQcLuv5Ia6A/D/ESspmJScIIe0BlH1e5mYWP//W0nSYBw/jQ/fqqt0IIjWyYqYknxFIBH1DCuDPx6shNpNoi5XMzVvv2Ow5Ke/YPXp1LFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013492; c=relaxed/simple;
	bh=JIGVLKN9mATQFq7HcL3xBrqInCMEQGt9xDSrrJAmQik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opTLSBO025KjUpjhdQX4x2Sfl381ElIIciFZ+K3ShJQmY69Qdsr4YxvkXuGWQsTOGLi+jxzpiX55RiawWoJPI/9Ol233qGREgms/j0Qup49KcQVFxg1WsaRolWm0gXpIAiylxQmBJStFiLBhRa0SZe17hDj4LlVt1RsAOfsWlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Xt13T3pJ0z9v7Nh;
	Tue, 19 Nov 2024 18:30:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 38DBF140CAB;
	Tue, 19 Nov 2024 18:51:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3nn1LbTxnNp7pAQ--.49675S6;
	Tue, 19 Nov 2024 11:51:14 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	samitolvanen@google.com,
	da.gomez@samsung.com,
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
	linux-api@vger.kernel.org,
	linux-modules@vger.kernel.org,
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
Subject: [PATCH v6 04/15] digest_cache: Initialize digest caches
Date: Tue, 19 Nov 2024 11:49:11 +0100
Message-ID: <20241119104922.2772571-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
In-Reply-To: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwA3nn1LbTxnNp7pAQ--.49675S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr13urWfCr1xuryxuF47twb_yoW7WryDpa
	sFk3W5Krs5ZryxCw17CF12yw4Fqr9YqF47Gws8uw1ayFs2vr1qv3W0yw15ZryUXr4Uua17
	tr45K3WUur1DXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wr
	v_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIF
	yTuYvjxUsCztUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGc797QEdwACsn

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce digest_cache_init() to initialize created digest caches. Since
initialization happens after releasing both the dig_owner_mutex and
dig_user_mutex locks (to avoid a lock inversion with VFS locks), any caller
of digest_cache_get() can potentially be in charge of initializing them,
provided that it got the digest list path from digest_cache_new().

Introduce the INIT_STARTED flag, to atomically determine whether the digest
cache is being initialized and eventually do it if the flag is not yet set.

Introduce the INIT_IN_PROGRESS flag, for the other callers to wait until
the caller in charge of the initialization finishes initializing the digest
cache. Set INIT_IN_PROGRESS in digest_cache_create() and clear it in
digest_cache_init(). Finally, call clear_and_wake_up_bit() to wake up the
other callers.

Finally, introduce the INVALID flag, to let the callers which didn't
initialize the digest cache know that an error occurred during
initialization and, consequently, prevent them from using that digest
cache.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/digest_cache/internal.h |  8 ++++
 security/integrity/digest_cache/main.c     | 48 ++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/security/integrity/digest_cache/internal.h b/security/integrity/digest_cache/internal.h
index fa76ab2672ea..29bf98a974f3 100644
--- a/security/integrity/digest_cache/internal.h
+++ b/security/integrity/digest_cache/internal.h
@@ -13,6 +13,11 @@
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
@@ -110,6 +115,9 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 					 struct path *default_path,
 					 struct path *digest_list_path,
 					 char *path_str, char *filename);
+struct digest_cache *digest_cache_init(struct dentry *dentry,
+				       struct path *digest_list_path,
+				       struct digest_cache *digest_cache);
 int __init digest_cache_do_init(const struct lsm_id *lsm_id,
 				loff_t inode_offset, loff_t file_offset);
 
diff --git a/security/integrity/digest_cache/main.c b/security/integrity/digest_cache/main.c
index c644cdc2ebd7..6e94cff2b0dc 100644
--- a/security/integrity/digest_cache/main.c
+++ b/security/integrity/digest_cache/main.c
@@ -156,6 +156,9 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
 
 	/* Increment ref. count for reference returned to the caller. */
 	digest_cache = digest_cache_ref(dig_sec->dig_owner);
+
+	/* Make other digest cache requestors wait until creation complete. */
+	set_bit(INIT_IN_PROGRESS, &digest_cache->flags);
 out:
 	mutex_unlock(&dig_sec->dig_owner_mutex);
 	return digest_cache;
@@ -238,6 +241,47 @@ static struct digest_cache *digest_cache_new(struct dentry *dentry,
 	return digest_cache;
 }
 
+/**
+ * digest_cache_init - Initialize a digest cache
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ * @digest_list_path: Path structure of the digest list
+ * @digest_cache: Digest cache to initialize
+ *
+ * This function checks if the INIT_STARTED digest cache flag is set. If it is,
+ * or the caller didn't provide the digest list path, it waits until the caller
+ * that saw INIT_STARTED unset and had the path completes the initialization.
+ *
+ * The latter sets INIT_STARTED (atomically), performs the initialization,
+ * clears the INIT_IN_PROGRESS digest cache flag, and wakes up the other
+ * callers.
+ *
+ * Return: A valid and initialized digest cache on success, NULL otherwise.
+ */
+struct digest_cache *digest_cache_init(struct dentry *dentry,
+				       struct path *digest_list_path,
+				       struct digest_cache *digest_cache)
+{
+	/* Wait for digest cache initialization. */
+	if (!digest_list_path->dentry ||
+	    test_and_set_bit(INIT_STARTED, &digest_cache->flags)) {
+		wait_on_bit(&digest_cache->flags, INIT_IN_PROGRESS,
+			    TASK_UNINTERRUPTIBLE);
+		goto out;
+	}
+
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
  * @file: File descriptor of the inode for which the digest cache will be used
@@ -287,6 +331,10 @@ struct digest_cache *digest_cache_get(struct file *file)
 
 	mutex_unlock(&dig_sec->dig_user_mutex);
 
+	if (digest_cache)
+		digest_cache = digest_cache_init(dentry, &digest_list_path,
+						 digest_cache);
+
 	if (digest_list_path.dentry)
 		path_put(&digest_list_path);
 
-- 
2.47.0.118.gfd3785337b


