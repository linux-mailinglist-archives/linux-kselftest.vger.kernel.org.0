Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE9749F7D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 16:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjGFOr0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 10:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjGFOrB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 10:47:01 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939291FD0;
        Thu,  6 Jul 2023 07:46:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QxfGN6k7Yz9v7VL;
        Thu,  6 Jul 2023 22:35:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHQg0y06ZkPxkwBA--.58122S8;
        Thu, 06 Jul 2023 15:46:14 +0100 (CET)
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
Subject: [RFC][PATCH 06/10] verification: Add verify_uasym_signature() and verify_uasym_sig_message()
Date:   Thu,  6 Jul 2023 16:42:19 +0200
Message-Id: <20230706144225.1046544-7-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
References: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHQg0y06ZkPxkwBA--.58122S8
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy8CrW3Wr1rurykAF43ZFb_yoWxKFW5pF
        9Yqr1rZF98Awn3Aa47Ka1I9w1fWrn5Jw17KasFy3WfZF1vq3ZrGrs0gF1YqrW5C348GFWY
        9rZFvFW3KanxAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4vZ7gAAsB
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

Introduce verify_uasym_signature() and verify_uasym_sig_message(), to
verify user asymmetric key signatures from detached data. It aims to be
used by kernel subsystems wishing to verify the authenticity of system
data, with system-defined keyrings as trust anchor.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 certs/system_keyring.c       | 125 +++++++++++++++++++++++++++++++++++
 include/linux/verification.h |  50 ++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index a7a49b17ceb..dbee2e5b732 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -16,6 +16,7 @@
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include <crypto/pkcs7.h>
+#include <crypto/uasym_keys_sigs.h>
 
 static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
@@ -339,6 +340,130 @@ int verify_pkcs7_signature(const void *data, size_t len,
 }
 EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
 
+#ifdef CONFIG_UASYM_KEYS_SIGS
+/**
+ * verify_uasym_sig_message - Verify a user asym key signature on system data
+ * @data: The data to be verified (must be provided)
+ * @len: Size of @data
+ * @uasym_sig: The signature context
+ * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
+ *					(void *)1UL for all trusted keys)
+ *					(void *)2UL for platform keys)
+ * @usage: The use to which the key is being put
+ * @view_content: Callback to gain access to content
+ * @ctx: Context for callback
+ *
+ * Verify the user asymmetric key signature of the supplied system data,
+ * against a key (if found) in the supplied trusted keyring.
+ *
+ * Return: Zero on successful verification, a negative value otherwise.
+ */
+int verify_uasym_sig_message(const void *data, size_t len,
+			     struct uasym_sig_message *uasym_sig,
+			     struct key *trusted_keys,
+			     enum key_being_used_for usage,
+			     int (*view_content)(void *ctx,
+						 const void *data, size_t len,
+						 size_t asn1hdrlen),
+			     void *ctx)
+{
+	int ret;
+
+	/* The data should be detached - so we need to supply it. */
+	if (data && uasym_sig_supply_detached_data(uasym_sig, data, len)) {
+		pr_err("Failed to supply data for user asymmetric key signature\n");
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
+	ret = uasym_sig_verify_message(uasym_sig, trusted_keys);
+	if (ret < 0)
+		goto error;
+
+	if (view_content) {
+		size_t sig_data_len;
+
+		ret = uasym_sig_get_content_data(uasym_sig, &data, &len,
+						 &sig_data_len);
+		if (ret < 0) {
+			if (ret == -ENODATA)
+				pr_devel("User asymmetric key signature does not contain data\n");
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
+EXPORT_SYMBOL_GPL(verify_uasym_sig_message);
+
+/**
+ * verify_uasym_signature - Verify a user asym key signature on system data
+ * @data: The data to be verified (must be provided)
+ * @len: Size of @data
+ * @raw_uasym_sig: The raw signature
+ * @raw_uasym_sig_len: The size of @raw_uasym_sig
+ * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
+ *					(void *)1UL for all trusted keys)
+ *					(void *)2UL for platform keys)
+ * @usage: The use to which the key is being put
+ * @view_content: Callback to gain access to content
+ * @ctx: Context for callback
+ *
+ * Verify the user asymmetric key signature of the supplied system data,
+ * against a key (if found) in the supplied trusted keyring.
+ *
+ * Return: Zero on successful verification, a negative value otherwise.
+ */
+int verify_uasym_signature(const void *data, size_t len,
+			   const void *raw_uasym_sig, size_t raw_uasym_sig_len,
+			   struct key *trusted_keys,
+			   enum key_being_used_for usage,
+			   int (*view_content)(void *ctx,
+					       const void *data, size_t len,
+					       size_t asn1hdrlen),
+			   void *ctx)
+{
+	struct uasym_sig_message *uasym_sig;
+	int ret;
+
+	uasym_sig = uasym_sig_parse_message(raw_uasym_sig, raw_uasym_sig_len);
+	if (IS_ERR(uasym_sig))
+		return PTR_ERR(uasym_sig);
+
+	ret = verify_uasym_sig_message(data, len, uasym_sig, trusted_keys, usage,
+				       view_content, ctx);
+
+	uasym_sig_free_message(uasym_sig);
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(verify_uasym_signature);
+#endif /* CONFIG_UASYM_KEYS_SIGS */
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
diff --git a/include/linux/verification.h b/include/linux/verification.h
index f34e50ebcf6..818f0ca4e12 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -43,6 +43,7 @@ extern const char *const key_being_used_for[NR__KEY_BEING_USED_FOR];
 
 struct key;
 struct pkcs7_message;
+struct uasym_sig_message;
 
 extern int verify_pkcs7_signature(const void *data, size_t len,
 				  const void *raw_pkcs7, size_t pkcs7_len,
@@ -62,6 +63,55 @@ extern int verify_pkcs7_message_sig(const void *data, size_t len,
 							size_t asn1hdrlen),
 				    void *ctx);
 
+#ifdef CONFIG_UASYM_KEYS_SIGS
+extern int verify_uasym_sig_message(const void *data, size_t len,
+				    struct uasym_sig_message *uasym_sig,
+				    struct key *trusted_keys,
+				    enum key_being_used_for usage,
+				    int (*view_content)(void *ctx,
+							const void *data,
+							size_t len,
+							size_t asn1hdrlen),
+				    void *ctx);
+extern int verify_uasym_signature(const void *data, size_t len,
+				  const void *raw_uasym_sig,
+				  size_t raw_uasym_sig_len,
+				  struct key *trusted_keys,
+				  enum key_being_used_for usage,
+				  int (*view_content)(void *ctx,
+						      const void *data,
+						      size_t len,
+						      size_t asn1hdrlen),
+				  void *ctx);
+#else
+static inline int verify_uasym_sig_message(const void *data, size_t len,
+					   struct uasym_sig_message *uasym_sig,
+					   struct key *trusted_keys,
+					   enum key_being_used_for usage,
+					   int (*view_content)(void *ctx,
+							const void *data,
+							size_t len,
+							size_t asn1hdrlen),
+					   void *ctx)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int verify_uasym_signature(const void *data, size_t len,
+					 const void *raw_uasym_sig,
+					 size_t raw_uasym_sig_len,
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
+#endif /* CONFIG_UASYM_KEYS_SIGS */
+
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
 				   struct key *trusted_keys,
-- 
2.34.1

