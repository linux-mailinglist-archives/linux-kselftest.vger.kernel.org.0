Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5509D749F9F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 16:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjGFOsh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 10:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjGFOsS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 10:48:18 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841F026AA;
        Thu,  6 Jul 2023 07:47:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QxfHT2m3Cz9xFGF;
        Thu,  6 Jul 2023 22:36:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHQg0y06ZkPxkwBA--.58122S11;
        Thu, 06 Jul 2023 15:47:08 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, song@kernel.org, jolsa@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbrobinson@gmail.com,
        zbyszek@in.waw.pl, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, wiktor@metacode.biz,
        devel@lists.sequoia-pgp.org, gnupg-devel@gnupg.org,
        ebiggers@kernel.org, Jason@zx2c4.com, mail@maciej.szmigiero.name,
        antony@vennard.ch, konstantin@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 09/10] bpf: Introduce bpf_verify_uasym_signature() kfunc
Date:   Thu,  6 Jul 2023 16:42:22 +0200
Message-Id: <20230706144225.1046544-10-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
References: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHQg0y06ZkPxkwBA--.58122S11
X-Coremail-Antispam: 1UD129KBjvJXoWxCw47Cry5XFyxurWrXr45GFg_yoWrWr4UpF
        W8Kr4Svry8Jrs7Ja48Ja1fZF1rCr4vqw17G3sFy34kAFn5Xr13Z34kKF45G3s0k348trWD
        ZrWIqw43u3ZrGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
        67AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wr
        v_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
        IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZF
        pf9x07jIPfQUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4-V5wACsB
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the bpf_verify_uasym_signature() kfunc, to verify user asymmetric
key signatures. The parameters and usage are the same as for
bpf_verify_pkcs7_signature().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 kernel/trace/bpf_trace.c | 68 +++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5f2dcabad20..476b6d526de 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1281,7 +1281,7 @@ __bpf_kfunc struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
  * The key pointer is marked as invalid, to prevent bpf_key_put() from
  * attempting to decrement the key reference count on that pointer. The key
  * pointer set in such way is currently understood only by
- * verify_pkcs7_signature().
+ * verify_pkcs7_signature() and verify_uasym_signature().
  *
  * Set *id* to one of the values defined in include/linux/verification.h:
  * 0 for the primary keyring (immutable keyring of system keys);
@@ -1327,6 +1327,25 @@ __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
 }
 
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
+static int validate_key(struct bpf_key *trusted_keyring)
+{
+	int ret = 0;
+
+	if (trusted_keyring->has_ref) {
+		/*
+		 * Do the permission check deferred in bpf_lookup_user_key().
+		 * See bpf_lookup_user_key() for more details.
+		 *
+		 * A call to key_task_permission() here would be redundant, as
+		 * it is already done by keyring_search() called by
+		 * find_asymmetric_key().
+		 */
+		ret = key_validate(trusted_keyring->key);
+	}
+
+	return ret;
+}
+
 /**
  * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
  * @data_ptr: data to verify
@@ -1344,19 +1363,9 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 {
 	int ret;
 
-	if (trusted_keyring->has_ref) {
-		/*
-		 * Do the permission check deferred in bpf_lookup_user_key().
-		 * See bpf_lookup_user_key() for more details.
-		 *
-		 * A call to key_task_permission() here would be redundant, as
-		 * it is already done by keyring_search() called by
-		 * find_asymmetric_key().
-		 */
-		ret = key_validate(trusted_keyring->key);
-		if (ret < 0)
-			return ret;
-	}
+	ret = validate_key(trusted_keyring);
+	if (ret < 0)
+		return ret;
 
 	return verify_pkcs7_signature(data_ptr->data,
 				      __bpf_dynptr_size(data_ptr),
@@ -1366,6 +1375,36 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
 				      NULL);
 }
+
+/**
+ * bpf_verify_uasym_signature - Verify a user asymmetric key signature
+ * @data_ptr: Data to verify
+ * @sig_ptr: Signature of the data
+ * @trusted_keyring: Keyring with keys trusted for signature verification
+ *
+ * Verify the user asymmetric key signature *sig_ptr* against the supplied
+ * *data_ptr* with keys in a keyring referenced by *trusted_keyring*.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_verify_uasym_signature(struct bpf_dynptr_kern *data_ptr,
+					   struct bpf_dynptr_kern *sig_ptr,
+					   struct bpf_key *trusted_keyring)
+{
+	int ret;
+
+	ret = validate_key(trusted_keyring);
+	if (ret < 0)
+		return ret;
+
+	return verify_uasym_signature(data_ptr->data,
+				      __bpf_dynptr_size(data_ptr),
+				      sig_ptr->data,
+				      __bpf_dynptr_size(sig_ptr),
+				      trusted_keyring->key,
+				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
+				      NULL);
+}
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 
 __diag_pop();
@@ -1376,6 +1415,7 @@ BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
 BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_verify_uasym_signature, KF_SLEEPABLE)
 #endif
 BTF_SET8_END(key_sig_kfunc_set)
 
-- 
2.34.1

