Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9596EE6FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjDYRjJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbjDYRjH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 13:39:07 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9B114F5F;
        Tue, 25 Apr 2023 10:38:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q5TWG6w3Cz9xFQD;
        Wed, 26 Apr 2023 01:28:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3dADLD0hkGxlWAg--.5466S6;
        Tue, 25 Apr 2023 18:38:16 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 4/6] bpf: Introduce bpf_verify_umd_signature() kfunc
Date:   Tue, 25 Apr 2023 19:35:55 +0200
Message-Id: <20230425173557.724688-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
References: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3dADLD0hkGxlWAg--.5466S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4UJFWkuFW5uryUWryfZwb_yoWrWr1rpF
        W8Krsavry8Jrs7Ja4rJa1fZF4FkF4vqw17G3sFk3s7uFn5Xr13Z348KF4UG3s0k348trWD
        ZrWIqw45u3W7GaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
        v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07jxwIDUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBF1jj4x8NAAAsi
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the bpf_verify_umd_signature() kfunc, to verify UMD-parsed
signatures. The parameters and usage are the same as for
bpf_verify_pkcs7_signature().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 kernel/trace/bpf_trace.c | 69 ++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e8da032bb6f..c9cae337596 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1271,7 +1271,7 @@ __bpf_kfunc struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
  * The key pointer is marked as invalid, to prevent bpf_key_put() from
  * attempting to decrement the key reference count on that pointer. The key
  * pointer set in such way is currently understood only by
- * verify_pkcs7_signature().
+ * verify_pkcs7_signature() and verify_umd_signature().
  *
  * Set *id* to one of the values defined in include/linux/verification.h:
  * 0 for the primary keyring (immutable keyring of system keys);
@@ -1317,6 +1317,27 @@ __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
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
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
+}
+
 /**
  * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
  * @data_ptr: data to verify
@@ -1334,19 +1355,9 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
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
 				      bpf_dynptr_get_size(data_ptr),
@@ -1356,6 +1367,35 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
 				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
 				      NULL);
 }
+
+/**
+ * bpf_verify_umd_signature - Verify a UMD-parsed signature
+ * @data_ptr: Data to verify
+ * @sig_ptr: Signature of the data
+ * @trusted_keyring: Keyring with keys trusted for signature verification
+ *
+ * Verify the UMD-parsed signature *sig_ptr* against the supplied *data_ptr*
+ * with keys in a keyring referenced by *trusted_keyring*.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_verify_umd_signature(struct bpf_dynptr_kern *data_ptr,
+					 struct bpf_dynptr_kern *sig_ptr,
+					 struct bpf_key *trusted_keyring)
+{
+	int ret;
+
+	ret = validate_key(trusted_keyring);
+	if (ret < 0)
+		return ret;
+
+	return verify_umd_signature(data_ptr->data,
+				    bpf_dynptr_get_size(data_ptr),
+				    sig_ptr->data, bpf_dynptr_get_size(sig_ptr),
+				    trusted_keyring->key,
+				    VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
+				    NULL);
+}
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 
 __diag_pop();
@@ -1366,6 +1406,7 @@ BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
 BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_verify_umd_signature, KF_SLEEPABLE)
 #endif
 BTF_SET8_END(key_sig_kfunc_set)
 
-- 
2.25.1

