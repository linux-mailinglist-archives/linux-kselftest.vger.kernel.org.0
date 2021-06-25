Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BDF3B47AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 18:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFYQ7E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 12:59:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3308 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYQ67 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 12:58:59 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GBNDy142vz6G8m4;
        Sat, 26 Jun 2021 00:46:26 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 25 Jun 2021 18:56:35 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        <selinux@vger.kernel.org>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [RFC][PATCH 01/12] ima: Add digest, algo, measured parameters to ima_measure_critical_data()
Date:   Fri, 25 Jun 2021 18:56:03 +0200
Message-ID: <20210625165614.2284243-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625165614.2284243-1-roberto.sassu@huawei.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ima_measure_critical_data() allows any caller in the kernel to provide a
buffer, so that is measured by IMA if an appropriate policy is set. Some
information that could be useful to the callers are the digest of the
buffer included in the new measurement entry, the digest algorithm and
whether the buffer was measured.

This patch modifies the definition of ima_measure_critical_data() to
include three new parameters: digest, algo and measured. If they are NULL,
the function behaves as before and just measures the buffer, if requested
with the IMA policy. Otherwise, it also writes the digest, algorithm and
whether the buffer is measured to the provided pointers.

If the pointers are not NULL, the digest is calculated also if there is no
matching rule in the IMA policy.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Cc: Prakhar Srivastava <prsriva02@gmail.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 include/linux/ima.h                          |  8 +++--
 security/integrity/ima/ima.h                 |  3 +-
 security/integrity/ima/ima_appraise.c        |  3 +-
 security/integrity/ima/ima_asymmetric_keys.c |  3 +-
 security/integrity/ima/ima_init.c            |  3 +-
 security/integrity/ima/ima_main.c            | 32 ++++++++++++++++----
 security/integrity/ima/ima_queue_keys.c      |  2 +-
 security/selinux/ima.c                       |  5 +--
 8 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 61d5723ec303..f7fd931456c7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
+#include <crypto/hash_info.h>
 struct linux_binprm;
 
 #ifdef CONFIG_IMA
@@ -36,7 +37,8 @@ extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
 extern void ima_measure_critical_data(const char *event_label,
 				      const char *event_name,
 				      const void *buf, size_t buf_len,
-				      bool hash);
+				      bool hash, u8 *digest,
+				      enum hash_algo *algo, bool *measured);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
@@ -140,7 +142,9 @@ static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {
 static inline void ima_measure_critical_data(const char *event_label,
 					     const char *event_name,
 					     const void *buf, size_t buf_len,
-					     bool hash) {}
+					     bool hash, u8 *digest,
+					     enum hash_algo *algo,
+					     bool *measured) {}
 
 #endif /* CONFIG_IMA */
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f0e448ed1f9f..fff31065d600 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -268,7 +268,8 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 				struct inode *inode, const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
 				int pcr, const char *func_data,
-				bool buf_hash);
+				bool buf_hash, u8 *digest, enum hash_algo *algo,
+				bool *measured);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ef9dcfce45d4..3fcbf1bfa449 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -357,7 +357,8 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
 			process_buffer_measurement(&init_user_ns, NULL, digest, digestsize,
 						   "blacklisted-hash", NONE,
-						   pcr, NULL, false);
+						   pcr, NULL, false, NULL, NULL,
+						   NULL);
 	}
 
 	return rc;
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index c985418698a4..4370bf7b8866 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -62,5 +62,6 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 */
 	process_buffer_measurement(&init_user_ns, NULL, payload, payload_len,
 				   keyring->description, KEY_CHECK, 0,
-				   keyring->description, false);
+				   keyring->description, false, NULL, NULL,
+				   NULL);
 }
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5076a7d9d23e..a4dcd15187a8 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -154,7 +154,8 @@ int __init ima_init(void)
 	ima_init_key_queue();
 
 	ima_measure_critical_data("kernel_info", "kernel_version",
-				  UTS_RELEASE, strlen(UTS_RELEASE), false);
+				  UTS_RELEASE, strlen(UTS_RELEASE), false, NULL,
+				  NULL, NULL);
 
 	return rc;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 287b90509006..04d1aed5adae 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -833,6 +833,9 @@ int ima_post_load_data(char *buf, loff_t size,
  * @pcr: pcr to extend the measurement
  * @func_data: func specific data, may be NULL
  * @buf_hash: measure buffer data hash
+ * @digest: buffer digest will be written to
+ * @algo: digest algorithm
+ * @measured: whether the buffer has been measured by IMA
  *
  * Based on policy, either the buffer data or buffer data hash is measured
  */
@@ -840,7 +843,8 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 				struct inode *inode, const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
 				int pcr, const char *func_data,
-				bool buf_hash)
+				bool buf_hash, u8 *digest, enum hash_algo *algo,
+				bool *measured)
 {
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
@@ -861,7 +865,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 	int action = 0;
 	u32 secid;
 
-	if (!ima_policy_flag)
+	if (!ima_policy_flag && (!digest || !algo || !measured))
 		return;
 
 	template = ima_template_desc_buf();
@@ -883,7 +887,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 		action = ima_get_action(mnt_userns, inode, current_cred(),
 					secid, 0, func, &pcr, &template,
 					func_data);
-		if (!(action & IMA_MEASURE))
+		if (!(action & IMA_MEASURE) && (!digest || !algo || !measured))
 			return;
 	}
 
@@ -914,6 +918,15 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 		event_data.buf_len = digest_hash_len;
 	}
 
+	if (digest && algo) {
+		memcpy(digest, iint.ima_hash->digest,
+		       hash_digest_size[ima_hash_algo]);
+		*algo = ima_hash_algo;
+	}
+
+	if (!(action & IMA_MEASURE))
+		return;
+
 	ret = ima_alloc_init_template(&event_data, &entry, template);
 	if (ret < 0) {
 		audit_cause = "alloc_entry";
@@ -924,8 +937,11 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 	if (ret < 0) {
 		audit_cause = "store_entry";
 		ima_free_template_entry(entry);
+		goto out;
 	}
 
+	if (measured)
+		*measured = true;
 out:
 	if (ret < 0)
 		integrity_audit_message(AUDIT_INTEGRITY_PCR, NULL, eventname,
@@ -956,7 +972,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 
 	process_buffer_measurement(file_mnt_user_ns(f.file), file_inode(f.file),
 				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
-				   NULL, false);
+				   NULL, false, NULL, NULL, NULL);
 	fdput(f);
 }
 
@@ -967,6 +983,9 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
  * @buf: pointer to buffer data
  * @buf_len: length of buffer data (in bytes)
  * @hash: measure buffer data hash
+ * @digest: buffer digest will be written to
+ * @algo: digest algorithm
+ * @measured: whether the buffer has been measured by IMA
  *
  * Measure data critical to the integrity of the kernel into the IMA log
  * and extend the pcr.  Examples of critical data could be various data
@@ -976,14 +995,15 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 void ima_measure_critical_data(const char *event_label,
 			       const char *event_name,
 			       const void *buf, size_t buf_len,
-			       bool hash)
+			       bool hash, u8 *digest, enum hash_algo *algo,
+			       bool *measured)
 {
 	if (!event_name || !event_label || !buf || !buf_len)
 		return;
 
 	process_buffer_measurement(&init_user_ns, NULL, buf, buf_len, event_name,
 				   CRITICAL_DATA, 0, event_label,
-				   hash);
+				   hash, digest, algo, measured);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index 979ef6c71f3d..97ed974651fd 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -165,7 +165,7 @@ void ima_process_queued_keys(void)
 						   entry->keyring_name,
 						   KEY_CHECK, 0,
 						   entry->keyring_name,
-						   false);
+						   false, NULL, NULL, NULL);
 		list_del(&entry->list);
 		ima_free_key_entry(entry);
 	}
diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index 34d421861bfc..af1016dbb5aa 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -86,7 +86,8 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
 	}
 
 	ima_measure_critical_data("selinux", "selinux-state",
-				  state_str, strlen(state_str), false);
+				  state_str, strlen(state_str), false, NULL,
+				  NULL, NULL);
 
 	kfree(state_str);
 
@@ -103,7 +104,7 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
 	}
 
 	ima_measure_critical_data("selinux", "selinux-policy-hash",
-				  policy, policy_len, true);
+				  policy, policy_len, true, NULL, NULL, NULL);
 
 	vfree(policy);
 }
-- 
2.25.1

