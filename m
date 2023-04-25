Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D096EE6F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 19:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjDYRis (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 13:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjDYRir (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 13:38:47 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5A2CC2E;
        Tue, 25 Apr 2023 10:38:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Q5TW52wVDz9xFHM;
        Wed, 26 Apr 2023 01:28:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3dADLD0hkGxlWAg--.5466S5;
        Tue, 25 Apr 2023 18:38:04 +0100 (CET)
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
Subject: [RFC][PATCH 3/6] verification: Introduce verify_umd_signature() and verify_umd_message_sig()
Date:   Tue, 25 Apr 2023 19:35:54 +0200
Message-Id: <20230425173557.724688-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
References: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3dADLD0hkGxlWAg--.5466S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4fKr18ZF18XFW3ZryDAwb_yoWxtrWfpF
        nY9r1FvFy3Jwn7AasxKa17Zw4fWrn5J347G3sFy3WxXFn7J3ZrKrs0gF4Y9rW5C34UJryY
        9rZFqFy3Wwn8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
        AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
        07j4T5LUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBF1jj4iAGAAAs1
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

Introduce verify_umd_signature() and verify_umd_message_sig(), to verify
UMD-parsed signatures from detached data. It aims to be used by kernel
subsystems wishing to verify the authenticity of system data, with
system-defined keyrings as trust anchor.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 certs/system_keyring.c       | 125 +++++++++++++++++++++++++++++++++++
 include/linux/verification.h |  48 ++++++++++++++
 2 files changed, 173 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index a7a49b17ceb..d4c0de4dceb 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -16,6 +16,7 @@
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include <crypto/pkcs7.h>
+#include <crypto/umd_sig.h>
 
 static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
@@ -339,6 +340,130 @@ int verify_pkcs7_signature(const void *data, size_t len,
 }
 EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
 
+#ifdef CONFIG_UMD_SIG_PARSER
+/**
+ * verify_umd_message_sig - Verify a UMD-parsed signature on system data.
+ * @data: The data to be verified (must be provided)
+ * @len: Size of @data
+ * @umd_sig: The UMD-parsed signature
+ * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
+ *					(void *)1UL for all trusted keys)
+ *					(void *)2UL for platform keys)
+ * @usage: The use to which the key is being put
+ * @view_content: Callback to gain access to content
+ * @ctx: Context for callback
+ *
+ * Verify the UMD-parsed signature of the supplied system data, against a
+ * key (if found) in the supplied trusted keyring.
+ *
+ * Return: Zero on successful verification, a negative value otherwise.
+ */
+int verify_umd_message_sig(const void *data, size_t len,
+			   struct umd_sig_message *umd_sig,
+			   struct key *trusted_keys,
+			   enum key_being_used_for usage,
+			   int (*view_content)(void *ctx,
+					       const void *data, size_t len,
+					       size_t asn1hdrlen),
+			   void *ctx)
+{
+	int ret;
+
+	/* The data should be detached - so we need to supply it. */
+	if (data && umd_sig_supply_detached_data(umd_sig, data, len)) {
+		pr_err("Failed to supply data for UMD-parsed signature\n");
+		ret = -EBADMSG;
+		goto error;
+	}
+
+	if (!trusted_keys) {
+		trusted_keys = builtin_trusted_keys;
+	} else if (trusted_keys == VERIFY_USE_SECONDARY_KEYRING) {
+#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
+		trusted_keys = secondary_trusted_keys;
+#else
+		trusted_keys = builtin_trusted_keys;
+#endif
+	} else if (trusted_keys == VERIFY_USE_PLATFORM_KEYRING) {
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+		trusted_keys = platform_trusted_keys;
+#else
+		trusted_keys = NULL;
+#endif
+		if (!trusted_keys) {
+			ret = -ENOKEY;
+			pr_devel("Platform keyring is not available\n");
+			goto error;
+		}
+	}
+
+	ret = umd_sig_verify_message(umd_sig, trusted_keys);
+	if (ret < 0)
+		goto error;
+
+	if (view_content) {
+		size_t sig_data_len;
+
+		ret = umd_sig_get_content_data(umd_sig, &data, &len,
+					       &sig_data_len);
+		if (ret < 0) {
+			if (ret == -ENODATA)
+				pr_devel("UMD-parsed signature does not contain data\n");
+			goto error;
+		}
+
+		ret = view_content(ctx, data, len, sig_data_len);
+		kfree(data);
+	}
+error:
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(verify_umd_message_sig);
+
+/**
+ * verify_umd_signature - Verify a UMD-parsed signature on system data.
+ * @data: The data to be verified (must be provided)
+ * @len: Size of @data
+ * @raw_umd_sig: The raw signature to be parsed with UMD
+ * @raw_umd_sig_len: The size of @raw_umd_sig
+ * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
+ *					(void *)1UL for all trusted keys)
+ *					(void *)2UL for platform keys)
+ * @usage: The use to which the key is being put
+ * @view_content: Callback to gain access to content
+ * @ctx: Context for callback
+ *
+ * Verify the UMD-parsed signature of the supplied system data, against a
+ * key (if found) in the supplied trusted keyring.
+ *
+ * Return: Zero on successful verification, a negative value otherwise.
+ */
+int verify_umd_signature(const void *data, size_t len,
+			 const void *raw_umd_sig, size_t raw_umd_sig_len,
+			 struct key *trusted_keys,
+			 enum key_being_used_for usage,
+			 int (*view_content)(void *ctx,
+					     const void *data, size_t len,
+					     size_t asn1hdrlen),
+			 void *ctx)
+{
+	struct umd_sig_message *umd_sig;
+	int ret;
+
+	umd_sig = umd_sig_parse_message(raw_umd_sig, raw_umd_sig_len);
+	if (IS_ERR(umd_sig))
+		return PTR_ERR(umd_sig);
+
+	ret = verify_umd_message_sig(data, len, umd_sig, trusted_keys, usage,
+				     view_content, ctx);
+
+	umd_sig_free_message(umd_sig);
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(verify_umd_signature);
+#endif /* CONFIG_UMD_SIG_PARSER */
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
diff --git a/include/linux/verification.h b/include/linux/verification.h
index f34e50ebcf6..2e44ea17f23 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -43,6 +43,7 @@ extern const char *const key_being_used_for[NR__KEY_BEING_USED_FOR];
 
 struct key;
 struct pkcs7_message;
+struct umd_sig_message;
 
 extern int verify_pkcs7_signature(const void *data, size_t len,
 				  const void *raw_pkcs7, size_t pkcs7_len,
@@ -62,6 +63,53 @@ extern int verify_pkcs7_message_sig(const void *data, size_t len,
 							size_t asn1hdrlen),
 				    void *ctx);
 
+#ifdef CONFIG_UMD_SIG_PARSER
+extern int verify_umd_message_sig(const void *data, size_t len,
+				  struct umd_sig_message *umd_sig,
+				  struct key *trusted_keys,
+				  enum key_being_used_for usage,
+				  int (*view_content)(void *ctx,
+						      const void *data,
+						      size_t len,
+						      size_t asn1hdrlen),
+				  void *ctx);
+extern int verify_umd_signature(const void *data, size_t len,
+				const void *raw_pgp, size_t pgp_len,
+				struct key *trusted_keys,
+				enum key_being_used_for usage,
+				int (*view_content)(void *ctx,
+						const void *data, size_t len,
+						size_t asn1hdrlen),
+				void *ctx);
+#else
+static inline int verify_umd_message_sig(const void *data, size_t len,
+					 struct umd_sig_message *umd_sig,
+					 struct key *trusted_keys,
+					 enum key_being_used_for usage,
+					 int (*view_content)(void *ctx,
+							     const void *data,
+							     size_t len,
+							     size_t asn1hdrlen),
+					 void *ctx)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int verify_umd_signature(const void *data, size_t len,
+				       const void *raw_umd_sig,
+				       size_t raw_umd_sig_len,
+				       struct key *trusted_keys,
+				       enum key_being_used_for usage,
+				       int (*view_content)(void *ctx,
+							   const void *data,
+							   size_t len,
+							   size_t asn1hdrlen),
+				       void *ctx)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_UMD_SIG_PARSER */
+
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
 				   struct key *trusted_keys,
-- 
2.25.1

