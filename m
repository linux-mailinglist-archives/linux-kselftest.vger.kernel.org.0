Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37133749F6E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 16:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjGFOqm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 10:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjGFOq1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 10:46:27 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1F01BEF;
        Thu,  6 Jul 2023 07:46:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QxfCj66dhz9xFbn;
        Thu,  6 Jul 2023 22:33:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHQg0y06ZkPxkwBA--.58122S6;
        Thu, 06 Jul 2023 15:45:38 +0100 (CET)
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
Subject: [RFC][PATCH 04/10] KEYS: asymmetric: Introduce the user asymmetric key parser
Date:   Thu,  6 Jul 2023 16:42:17 +0200
Message-Id: <20230706144225.1046544-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
References: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHQg0y06ZkPxkwBA--.58122S6
X-Coremail-Antispam: 1UD129KBjvJXoWfJrWDXr4UtF1rZr4rtFy7KFg_yoWDWr18pa
        yrWryUKFW5Kwn2k3y3Ar17Kw12qry8ZFWagFyrAr1ak3sxXr4kGrWI9F4xuFyUtr1kt393
        tr4UZFyUKr1DtrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
        67AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wr
        v_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
        IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIF
        yTuYvjxUI-eODUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4-V4wACsF
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

Introduce a new parser for user asymmetric keys, in TLV format. User space
tools are expected to convert keys from their original format to the TLV
format.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/Kconfig            |   1 +
 crypto/asymmetric_keys/Makefile           |   3 +-
 crypto/asymmetric_keys/asymmetric_type.c  |   3 +-
 crypto/asymmetric_keys/uasym_key_parser.c | 229 ++++++++++++++++++++++
 crypto/asymmetric_keys/uasym_parser.h     |   5 +
 include/keys/asymmetric-type.h            |   1 +
 include/uapi/linux/uasym_parser.h         |   7 +
 7 files changed, 247 insertions(+), 2 deletions(-)
 create mode 100644 crypto/asymmetric_keys/uasym_key_parser.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 4f86fe78efd..d4b8f52a126 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -88,6 +88,7 @@ config FIPS_SIGNATURE_SELFTEST
 config UASYM_KEYS_SIGS
 	tristate "User asymmetric keys and signatures"
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select CRYPTO_PUB_KEY_INFO
 	help
 	  This option enables user asymmetric keys and signatures. They are
 	  keys and signatures converted in user space from their native
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index ac3955d834f..6708a9e81ed 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -82,4 +82,5 @@ $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
 #
 obj-$(CONFIG_UASYM_KEYS_SIGS) += uasym_keys_sigs.o
 uasym_keys_sigs-y := \
-	uasym_parser.o
+	uasym_parser.o \
+	uasym_key_parser.o
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index a5da8ccd353..53d0fc26eac 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -430,7 +430,7 @@ static int asymmetric_key_preparse(struct key_preparsed_payload *prep)
 /*
  * Clean up the key ID list
  */
-static void asymmetric_key_free_kids(struct asymmetric_key_ids *kids)
+void asymmetric_key_free_kids(struct asymmetric_key_ids *kids)
 {
 	int i;
 
@@ -440,6 +440,7 @@ static void asymmetric_key_free_kids(struct asymmetric_key_ids *kids)
 		kfree(kids);
 	}
 }
+EXPORT_SYMBOL_GPL(asymmetric_key_free_kids);
 
 /*
  * Clean up the preparse data
diff --git a/crypto/asymmetric_keys/uasym_key_parser.c b/crypto/asymmetric_keys/uasym_key_parser.c
new file mode 100644
index 00000000000..2de3f9afa64
--- /dev/null
+++ b/crypto/asymmetric_keys/uasym_key_parser.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the user asymmetric key parser.
+ */
+
+#define pr_fmt(fmt) "UASYM KEY: "fmt
+#include <linux/module.h>
+#include <crypto/public_key.h>
+#include <crypto/pub_key_info.h>
+
+#include "uasym_parser.h"
+
+static int parse_key_pub(struct public_key *pub, enum fields field,
+			 const u8 *field_data, u32 field_data_len)
+{
+	int ret = 0;
+
+	kenter(",%u,%u", field, field_data_len);
+
+	pub->key = kmemdup(field_data, field_data_len, GFP_KERNEL);
+	if (!pub->key) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pub->keylen = field_data_len;
+	pr_debug("Key length in bytes: %d\n", pub->keylen);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+int parse_key_algo(const char **pkey_algo, enum fields field,
+		   const u8 *field_data, u32 field_data_len)
+{
+	u8 algo;
+	int ret = 0;
+
+	kenter(",%u,%u", field, field_data_len);
+
+	if (field_data_len != sizeof(u8)) {
+		pr_debug("Unexpected data length %u, expected %lu\n",
+			 field_data_len, sizeof(u8));
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	algo = *field_data;
+
+	if (algo >= PKEY_ALGO__LAST) {
+		pr_debug("Unexpected public key algo %u\n", algo);
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	*pkey_algo = pub_key_algo_name[algo];
+	pr_debug("Public key algo: %s\n", *pkey_algo);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+int parse_key_kid(struct asymmetric_key_id **id, enum fields field,
+		  const u8 *field_data, u32 field_data_len)
+{
+	int ret = 0;
+
+	kenter(",%u,%u", field, field_data_len);
+
+	*id = asymmetric_key_generate_id(field_data, field_data_len, NULL, 0);
+	if (!*id) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pr_debug("Key/auth identifier: %*phN\n", (*id)->len, (*id)->data);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+static int parse_key_desc(struct key_preparsed_payload *prep, enum fields field,
+			  const u8 *field_data, u32 field_data_len)
+{
+	int ret = 0;
+
+	kenter(",%u,%u", field, field_data_len);
+
+	if (field_data[field_data_len - 1] != '\0') {
+		pr_err("Non-terminated string\n");
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	prep->description = kstrndup(field_data, field_data_len, GFP_KERNEL);
+	if (!prep->description) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pr_debug("Key description: %s\n", prep->description);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+struct callback_struct {
+	struct public_key *pub;
+	struct asymmetric_key_ids *kids;
+	struct key_preparsed_payload *prep;
+};
+
+static int key_callback(void *callback_data, enum fields field,
+			const u8 *field_data, u32 field_data_len)
+{
+	struct callback_struct *cb_s = (struct callback_struct *)callback_data;
+	struct asymmetric_key_id **id;
+	int ret;
+
+	switch (field) {
+	case KEY_PUB:
+		ret = parse_key_pub(cb_s->pub, field, field_data,
+				    field_data_len);
+		break;
+	case KEY_ALGO:
+		ret = parse_key_algo(&cb_s->pub->pkey_algo, field, field_data,
+				     field_data_len);
+		break;
+	case KEY_KID0:
+		id = (struct asymmetric_key_id **)&cb_s->kids->id[0];
+		ret = parse_key_kid(id, field, field_data, field_data_len);
+		break;
+	case KEY_KID1:
+		id = (struct asymmetric_key_id **)&cb_s->kids->id[1];
+		ret = parse_key_kid(id, field, field_data, field_data_len);
+		break;
+	case KEY_KID2:
+		id = (struct asymmetric_key_id **)&cb_s->kids->id[2];
+		ret = parse_key_kid(id, field, field_data, field_data_len);
+		break;
+	case KEY_DESC:
+		ret = parse_key_desc(cb_s->prep, field, field_data,
+				     field_data_len);
+		break;
+	default:
+		/* Just ignore non-relevant fields. */
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+static int uasym_key_parse(struct key_preparsed_payload *prep)
+{
+	struct callback_struct cb_s;
+	int ret;
+
+	kenter("");
+
+	cb_s.pub = kzalloc(sizeof(*cb_s.pub), GFP_KERNEL);
+	if (!cb_s.pub) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cb_s.pub->id_type = "UASYM_KEY";
+
+	cb_s.kids = kzalloc(sizeof(*cb_s.kids), GFP_KERNEL);
+	if (!cb_s.kids) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cb_s.prep = prep;
+
+	ret = uasym_parse(TYPE_KEY, key_callback, &cb_s, prep->data,
+			  prep->datalen);
+	if (ret < 0)
+		goto out;
+
+	if (!cb_s.pub->key || !cb_s.pub->pkey_algo ||
+	    (!cb_s.kids->id[0] && !cb_s.kids->id[1] && !cb_s.kids->id[2])) {
+		pr_debug("Incomplete data\n");
+		ret = -ENOENT;
+		goto out;
+	}
+
+	/* We're pinning the module by being linked against it */
+	__module_get(public_key_subtype.owner);
+	prep->payload.data[asym_subtype] = &public_key_subtype;
+	prep->payload.data[asym_key_ids] = cb_s.kids;
+	prep->payload.data[asym_crypto] = cb_s.pub;
+	prep->quotalen = 100;
+out:
+	kleave(" = %d", ret);
+
+	if (ret < 0) {
+		public_key_free(cb_s.pub);
+		asymmetric_key_free_kids(cb_s.kids);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct asymmetric_key_parser uasym_key_parser = {
+	.owner = THIS_MODULE,
+	.name = "uasym_key",
+	.parse = uasym_key_parse
+};
+
+static int __init uasym_key_init(void)
+{
+	return register_asymmetric_key_parser(&uasym_key_parser);
+}
+
+static void __exit uasym_key_exit(void)
+{
+	unregister_asymmetric_key_parser(&uasym_key_parser);
+}
+
+module_init(uasym_key_init);
+module_exit(uasym_key_exit);
+MODULE_LICENSE("GPL");
diff --git a/crypto/asymmetric_keys/uasym_parser.h b/crypto/asymmetric_keys/uasym_parser.h
index 985dda6aad3..0f629fb7a9b 100644
--- a/crypto/asymmetric_keys/uasym_parser.h
+++ b/crypto/asymmetric_keys/uasym_parser.h
@@ -28,3 +28,8 @@ int uasym_parse_data(parse_callback callback, void *callback_data,
 		     u16 num_fields, const u8 *data, size_t data_len);
 int uasym_parse(enum data_types expected_data_type, parse_callback callback,
 		void *callback_data, const u8 *data, size_t data_len);
+
+int parse_key_algo(const char **pkey_algo, enum fields field,
+		   const u8 *field_data, u32 field_data_len);
+int parse_key_kid(struct asymmetric_key_id **id, enum fields field,
+		  const u8 *data, u32 data_len);
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
diff --git a/include/uapi/linux/uasym_parser.h b/include/uapi/linux/uasym_parser.h
index 8f0bc235492..42e0087ac2b 100644
--- a/include/uapi/linux/uasym_parser.h
+++ b/include/uapi/linux/uasym_parser.h
@@ -62,9 +62,16 @@ struct uasym_entry {
 } __packed;
 
 #define FOR_EACH_DATA_TYPE(DATA_TYPE) \
+	DATA_TYPE(TYPE_KEY) \
 	DATA_TYPE(TYPE__LAST)
 
 #define FOR_EACH_FIELD(FIELD) \
+	FIELD(KEY_PUB) \
+	FIELD(KEY_ALGO) \
+	FIELD(KEY_KID0) \
+	FIELD(KEY_KID1) \
+	FIELD(KEY_KID2) \
+	FIELD(KEY_DESC) \
 	FIELD(FIELD__LAST)
 
 #define GENERATE_ENUM(ENUM) ENUM,
-- 
2.34.1

