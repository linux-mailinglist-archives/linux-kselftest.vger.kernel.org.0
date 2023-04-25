Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBE46EE6F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 19:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjDYRiL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 13:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjDYRiG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 13:38:06 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF008682;
        Tue, 25 Apr 2023 10:38:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Q5TVd3SvKz9ttD6;
        Wed, 26 Apr 2023 01:28:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3dADLD0hkGxlWAg--.5466S3;
        Tue, 25 Apr 2023 18:37:40 +0100 (CET)
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
Subject: [RFC][PATCH 1/6] KEYS: asymmetric: Introduce UMD-based asymmetric key parser
Date:   Tue, 25 Apr 2023 19:35:52 +0200
Message-Id: <20230425173557.724688-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
References: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3dADLD0hkGxlWAg--.5466S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Zw1UKF1DKw15WrWxJrWfAFb_yoWkKF48pF
        WrWr18tFW8Kw1xK34rAr42gw1rtw1vyFWagw4Sqw13uasxXr4kG3yIyF45WFy7Jr1kJ34f
        trs8Xa4Utr1DtFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
        AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
        07j4hFxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBF1jj4x8MwAAsl
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce a new parser for the asymmetric key type. The parser forwards the
key payload to a User Mode Driver (UMD) handler, which replies with the
data necessary to populate a public_key structure (blob, IDs and algorithm)
and, possibly, with a key description.

The parser then validates the response, fills the key payload fields from
it, and sets the key description if provided.

The main advantage of this approach is that potential risks of parsing data
from the kernel are avoided, as the UMD handler does not have access to the
kernel memory.

If the UMD handler is corrupted, the damage is likely limited to user
space. The parser sanitizes malicious data sent by the UMD. In addition,
seccomp can further limit which system calls the UMD is authorized to
invoke.

The communication protocol between the parser and the UMD handler consists
of two main structures: msg_in for the parser request, and msg_out for the
UMD handler response.

msg_in contains a buffer for a generic request, not only for parsing keys,
and the type of command (CMD_KEY for key parsing).

msg_out contains the result of the operation to communicate to the parser,
and the specific structure umd_key_msg_out for storing the key payload
fields and the key description.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/Kconfig           |  11 ++
 crypto/asymmetric_keys/Makefile          |   5 +
 crypto/asymmetric_keys/asymmetric_type.c |   3 +-
 crypto/asymmetric_keys/umd_key.h         |  20 +++
 crypto/asymmetric_keys/umd_key_parser.c  | 203 +++++++++++++++++++++++
 crypto/asymmetric_keys/umd_key_sig_umh.h |  52 ++++++
 include/keys/asymmetric-type.h           |   1 +
 7 files changed, 294 insertions(+), 1 deletion(-)
 create mode 100644 crypto/asymmetric_keys/umd_key.h
 create mode 100644 crypto/asymmetric_keys/umd_key_parser.c
 create mode 100644 crypto/asymmetric_keys/umd_key_sig_umh.h

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 1ef3b46d6f6..5f627026476 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -85,4 +85,15 @@ config FIPS_SIGNATURE_SELFTEST
 	depends on ASYMMETRIC_KEY_TYPE
 	depends on PKCS7_MESSAGE_PARSER=X509_CERTIFICATE_PARSER
 
+config UMD_KEY_PARSER
+	bool "UMD-based parser for the asymmetric key type"
+	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select USERMODE_DRIVER
+	help
+	  This option introduces a new parser for the asymmetric key type.
+	  The parser forwards the request to a User Mode Driver (UMD) handler,
+	  which replies with the result.
+
+	  On success, the parser fills the key from the UMD handler response.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index 0d1fa1b692c..d8f266cdeeb 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -76,3 +76,8 @@ verify_signed_pefile-y := \
 
 $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
 $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
+
+#
+# UMD asymmetric key parser
+#
+obj-$(CONFIG_UMD_KEY_PARSER) += umd_key_parser.o
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 41a2f0eb4ce..f1752eb8ff8 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -431,7 +431,7 @@ static int asymmetric_key_preparse(struct key_preparsed_payload *prep)
 /*
  * Clean up the key ID list
  */
-static void asymmetric_key_free_kids(struct asymmetric_key_ids *kids)
+void asymmetric_key_free_kids(struct asymmetric_key_ids *kids)
 {
 	int i;
 
@@ -441,6 +441,7 @@ static void asymmetric_key_free_kids(struct asymmetric_key_ids *kids)
 		kfree(kids);
 	}
 }
+EXPORT_SYMBOL_GPL(asymmetric_key_free_kids);
 
 /*
  * Clean up the preparse data
diff --git a/crypto/asymmetric_keys/umd_key.h b/crypto/asymmetric_keys/umd_key.h
new file mode 100644
index 00000000000..7e641bbf884
--- /dev/null
+++ b/crypto/asymmetric_keys/umd_key.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header file of the UMD asymmetric key parser.
+ */
+
+#include <linux/usermode_driver_mgmt.h>
+#include <keys/asymmetric-subtype.h>
+#include <keys/asymmetric-parser.h>
+
+#include "umd_key_sig_umh.h"
+
+extern struct umd_mgmt key_ops;
+extern const char *pub_key_algos[PUBKEY_ALGO__LAST];
+
+int umd_get_kids(struct umd_asymmetric_key_ids *umd_kids,
+		 struct asymmetric_key_id *id[3]);
diff --git a/crypto/asymmetric_keys/umd_key_parser.c b/crypto/asymmetric_keys/umd_key_parser.c
new file mode 100644
index 00000000000..bd7d09d89f3
--- /dev/null
+++ b/crypto/asymmetric_keys/umd_key_parser.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the UMD asymmetric key parser.
+ */
+
+#include <linux/module.h>
+#include <crypto/public_key.h>
+
+#include "umd_key.h"
+
+const char *pub_key_algos[PUBKEY_ALGO__LAST] = {
+	[PUBKEY_ALGO_RSA] = "rsa",
+	[PUBKEY_ALGO_ECDSA] = "ecdsa",
+	[PUBKEY_ALGO_ECDSA_NIST_P192] = "ecdsa-nist-p192",
+	[PUBKEY_ALGO_ECDSA_NIST_P256] = "ecdsa-nist-p256",
+	[PUBKEY_ALGO_ECDSA_NIST_P384] = "ecdsa-nist-p384",
+};
+
+struct umd_mgmt key_ops = {
+	.info.driver_name = "umd_key_sig_umh",
+	.kmod = "umd_key_sig_user",
+	.lock = __MUTEX_INITIALIZER(key_ops.lock),
+};
+EXPORT_SYMBOL_GPL(key_ops);
+
+static struct public_key *get_public_key(struct msg_out *out)
+{
+	struct public_key *pub;
+
+	if (out->key.pkey_algo >= PUBKEY_ALGO__LAST) {
+		pr_err("Unexpected key algo %d\n", out->key.pkey_algo);
+		return ERR_PTR(-EBADMSG);
+	}
+
+	if (!out->key.pub_key_len) {
+		pr_err("Unexpected zero-length for public key\n");
+		return ERR_PTR(-EBADMSG);
+	}
+
+	if (out->key.pub_key_len > sizeof(out->key.pub_key)) {
+		pr_err("Public key length %ld greater than expected %ld\n",
+		       out->key.pub_key_len, sizeof(out->key.pub_key));
+		return ERR_PTR(-EBADMSG);
+	}
+
+	pub = kzalloc(sizeof(*pub), GFP_KERNEL);
+	if (!pub)
+		return ERR_PTR(-ENOMEM);
+
+	pub->id_type = "UMD";
+	pub->pkey_algo = pub_key_algos[out->key.pkey_algo];
+
+	pub->key = kmemdup(out->key.pub_key, out->key.pub_key_len, GFP_KERNEL);
+	if (!pub->key) {
+		kfree(pub);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pub->keylen = out->key.pub_key_len;
+	return pub;
+}
+
+int umd_get_kids(struct umd_asymmetric_key_ids *umd_kids,
+		 struct asymmetric_key_id **id)
+{
+	int ret = 0, i, j;
+
+	for (i = 0; i < ARRAY_SIZE(umd_kids->kid1_len); i++) {
+		if (!umd_kids->kid1_len[i] && !umd_kids->kid2_len[i])
+			continue;
+
+		if (umd_kids->kid1_len[i] > sizeof(umd_kids->kid1[0])) {
+			pr_err("Key ID 1 length %ld greater than expected %ld\n",
+			       umd_kids->kid1_len[i],
+			       sizeof(umd_kids->kid1[0]));
+			ret = -EBADMSG;
+			break;
+		}
+
+		if (umd_kids->kid2_len[i] > sizeof(umd_kids->kid2[0])) {
+			pr_err("Key ID 2 length %ld greater than expected %ld\n",
+			       umd_kids->kid2_len[i],
+			       sizeof(umd_kids->kid2[0]));
+			ret = -EBADMSG;
+			break;
+		}
+
+		id[i] = asymmetric_key_generate_id(umd_kids->kid1[i],
+						   umd_kids->kid1_len[i],
+						   umd_kids->kid2[i],
+						   umd_kids->kid2_len[i]);
+		if (!id[i]) {
+			ret = -ENOMEM;
+			break;
+		}
+	}
+
+	if (ret) {
+		for (j = 0; j < i; j++)
+			kfree(id[j]);
+	}
+
+	return ret;
+}
+
+static int umd_key_parse(struct key_preparsed_payload *prep)
+{
+	struct msg_in *in = NULL;
+	struct msg_out *out = NULL;
+	struct asymmetric_key_ids *kids = NULL;
+	struct public_key *pub = NULL;
+	int ret = -ENOMEM;
+
+	in = kzalloc(sizeof(*in), GFP_KERNEL);
+	if (!in)
+		goto out;
+
+	out = kzalloc(sizeof(*out), GFP_KERNEL);
+	if (!out)
+		goto out;
+
+	in->cmd = CMD_KEY;
+	in->data_len = prep->datalen;
+	/* Truncate the input, there might be multiple keys in the same blob. */
+	memcpy(in->data, prep->data, min(prep->datalen, sizeof(in->data)));
+
+	out->ret = -EINVAL;
+
+	ret = umd_mgmt_send_recv(&key_ops, in, sizeof(*in), out, sizeof(*out));
+	if (ret)
+		goto out;
+
+	if (out->ret) {
+		ret = out->ret;
+		goto out;
+	}
+
+	pub = get_public_key(out);
+	if (IS_ERR(pub)) {
+		ret = PTR_ERR(pub);
+		pub = NULL;
+		goto out;
+	}
+
+	kids = kzalloc(sizeof(*kids), GFP_KERNEL);
+	if (!kids) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = umd_get_kids(&out->key.kids,
+			   (struct asymmetric_key_id **)kids->id);
+	if (ret)
+		goto out;
+
+	if (strlen(out->key.key_desc)) {
+		prep->description = kstrdup(out->key.key_desc, GFP_KERNEL);
+		if (!prep->description)
+			ret = -ENOMEM;
+	}
+
+out:
+	kfree(in);
+	kfree(out);
+
+	if (ret) {
+		public_key_free(pub);
+		asymmetric_key_free_kids(kids);
+		return ret;
+	}
+
+	/* We're pinning the module by being linked against it */
+	__module_get(public_key_subtype.owner);
+	prep->payload.data[asym_subtype] = &public_key_subtype;
+	prep->payload.data[asym_key_ids] = kids;
+	prep->payload.data[asym_crypto] = pub;
+	prep->quotalen = 100;
+	return 0;
+}
+
+static struct asymmetric_key_parser umd_key_parser = {
+	.owner = THIS_MODULE,
+	.name = "umd_key",
+	.parse = umd_key_parse
+};
+
+static int __init umd_key_init(void)
+{
+	return register_asymmetric_key_parser(&umd_key_parser);
+}
+
+static void __exit umd_key_exit(void)
+{
+	unregister_asymmetric_key_parser(&umd_key_parser);
+}
+
+module_init(umd_key_init);
+module_exit(umd_key_exit);
+MODULE_LICENSE("GPL");
diff --git a/crypto/asymmetric_keys/umd_key_sig_umh.h b/crypto/asymmetric_keys/umd_key_sig_umh.h
new file mode 100644
index 00000000000..e01c9e341c6
--- /dev/null
+++ b/crypto/asymmetric_keys/umd_key_sig_umh.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header file for communication between the kernel and the UMD handler.
+ */
+
+#define MAX_KEY_SIZE 1024
+#define MAX_KEY_DESC_SIZE 256
+#define MAX_PAYLOAD_SIZE 8192
+#define MAX_KID_SIZE 256
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+enum cmds { CMD_KEY, CMD__LAST };
+
+/* Public key algorithms that the kernel supports. */
+enum pub_key_algos { PUBKEY_ALGO_RSA, PUBKEY_ALGO_ECDSA,
+		     PUBKEY_ALGO_ECDSA_NIST_P192, PUBKEY_ALGO_ECDSA_NIST_P256,
+		     PUBKEY_ALGO_ECDSA_NIST_P384, PUBKEY_ALGO__LAST };
+
+struct msg_in {
+	enum cmds cmd;
+	size_t data_len;
+	unsigned char data[MAX_PAYLOAD_SIZE];
+} __packed;
+
+struct umd_asymmetric_key_ids {
+	size_t kid1_len[3];
+	unsigned char kid1[3][MAX_KID_SIZE];
+	size_t kid2_len[3];
+	unsigned char kid2[3][MAX_KID_SIZE];
+} __packed;
+
+struct umd_key_msg_out {
+	size_t pub_key_len;
+	unsigned char pub_key[MAX_KEY_SIZE];
+	enum pub_key_algos pkey_algo;
+	struct umd_asymmetric_key_ids kids;
+	char key_desc[MAX_KEY_DESC_SIZE];
+} __packed;
+
+struct msg_out {
+	int ret;
+	union {
+		struct umd_key_msg_out key;
+	};
+} __packed;
diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index 69a13e1e5b2..acbb8c805f6 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -66,6 +66,7 @@ extern struct asymmetric_key_id *asymmetric_key_generate_id(const void *val_1,
 							    size_t len_1,
 							    const void *val_2,
 							    size_t len_2);
+void asymmetric_key_free_kids(struct asymmetric_key_ids *kids);
 static inline
 const struct asymmetric_key_ids *asymmetric_key_ids(const struct key *key)
 {
-- 
2.25.1

