Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC126EE6F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 19:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjDYRi0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 13:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjDYRiY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 13:38:24 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A06A13F83;
        Tue, 25 Apr 2023 10:38:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Q5TVs3K0Qz9xFg5;
        Wed, 26 Apr 2023 01:28:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3dADLD0hkGxlWAg--.5466S4;
        Tue, 25 Apr 2023 18:37:52 +0100 (CET)
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
Subject: [RFC][PATCH 2/6] KEYS: asymmetric: Introduce UMD-based asymmetric key signature parser
Date:   Tue, 25 Apr 2023 19:35:53 +0200
Message-Id: <20230425173557.724688-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
References: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3dADLD0hkGxlWAg--.5466S4
X-Coremail-Antispam: 1UD129KBjvAXoWfJr18trW5Jr4kXw1rKF4xXrb_yoW8CF4DKo
        WfWr45G3W5tr1UCF4agw1kArs5ZFWDGa1UJw4rWF9IvFWqvw1kCrs5Ca47GrWSqwn8Krnx
        ZryrtryxJFW0g3Z3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUO57kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
        yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
        AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
        W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
        v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
        vjxUxiihUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBF1jj4x8MwABsk
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

Like for keys, add a parser of asymmetric key signatures which forwards the
request to a UMD handler (the same used for keys) and obtains from it the
parsed fields (blob, public key algo, hash algo, signature encoding, and
additional data required for the verification).

Introduce an API for each phase of the signature verification: signature
parsing, supplying/getting the data for the verification, calculating the
digest, doing the actual signature verification and, finally, freeing the
allocated memory.

Extend the communication protocol with the UMD handler, by introducing the
new specific structure umd_sig_msg_out, to be included in msg_out, and by
introducing the new command CMD_SIG.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 MAINTAINERS                              |   1 +
 crypto/asymmetric_keys/Kconfig           |  11 +
 crypto/asymmetric_keys/Makefile          |   5 +
 crypto/asymmetric_keys/umd_key.h         |   8 +
 crypto/asymmetric_keys/umd_key_sig_umh.h |  21 +-
 crypto/asymmetric_keys/umd_sig_parser.c  | 416 +++++++++++++++++++++++
 include/crypto/umd_sig.h                 |  71 ++++
 7 files changed, 532 insertions(+), 1 deletion(-)
 create mode 100644 crypto/asymmetric_keys/umd_sig_parser.c
 create mode 100644 include/crypto/umd_sig.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 782242fef7f..dd210bbcc2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3205,6 +3205,7 @@ F:	Documentation/crypto/asymmetric-keys.rst
 F:	crypto/asymmetric_keys/
 F:	include/crypto/pkcs7.h
 F:	include/crypto/public_key.h
+F:	include/crypto/umd_sig.h
 F:	include/linux/verification.h
 
 ASYNCHRONOUS TRANSFERS/TRANSFORMS (IOAT) API
diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 5f627026476..d312feae88e 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -96,4 +96,15 @@ config UMD_KEY_PARSER
 
 	  On success, the parser fills the key from the UMD handler response.
 
+config UMD_SIG_PARSER
+	bool "UMD-based parser for asymmetric key signatures"
+	depends on UMD_KEY_PARSER
+	help
+	  This option introduces a new parser for asymmetric key signatures.
+	  The parser forwards the request to a User Mode Driver (UMD) handler
+	  (the same used for keys), which replies with the result.
+
+	  On success, the parser fills the signature from the UMD handler
+	  response.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index d8f266cdeeb..060c699fbb2 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -81,3 +81,8 @@ $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
 # UMD asymmetric key parser
 #
 obj-$(CONFIG_UMD_KEY_PARSER) += umd_key_parser.o
+
+#
+# UMD signature parser
+#
+obj-$(CONFIG_UMD_SIG_PARSER) += umd_sig_parser.o
diff --git a/crypto/asymmetric_keys/umd_key.h b/crypto/asymmetric_keys/umd_key.h
index 7e641bbf884..91da42c5aa8 100644
--- a/crypto/asymmetric_keys/umd_key.h
+++ b/crypto/asymmetric_keys/umd_key.h
@@ -18,3 +18,11 @@ extern const char *pub_key_algos[PUBKEY_ALGO__LAST];
 
 int umd_get_kids(struct umd_asymmetric_key_ids *umd_kids,
 		 struct asymmetric_key_id *id[3]);
+
+struct umd_sig_message {
+	struct public_key_signature *sig;
+	size_t data_len;
+	const void *data;
+	size_t sig_data_len;
+	const void *sig_data;
+};
diff --git a/crypto/asymmetric_keys/umd_key_sig_umh.h b/crypto/asymmetric_keys/umd_key_sig_umh.h
index e01c9e341c6..5f5ae81a9de 100644
--- a/crypto/asymmetric_keys/umd_key_sig_umh.h
+++ b/crypto/asymmetric_keys/umd_key_sig_umh.h
@@ -7,22 +7,29 @@
  * Header file for communication between the kernel and the UMD handler.
  */
 
+#include <linux/hash_info.h>
+
 #define MAX_KEY_SIZE 1024
 #define MAX_KEY_DESC_SIZE 256
 #define MAX_PAYLOAD_SIZE 8192
 #define MAX_KID_SIZE 256
+#define MAX_SIG_SIZE MAX_KEY_SIZE
+#define MAX_SIG_DATA_SIZE 1024
 
 #ifndef __packed
 #define __packed __attribute__((packed))
 #endif
 
-enum cmds { CMD_KEY, CMD__LAST };
+enum cmds { CMD_KEY, CMD_SIG, CMD__LAST };
 
 /* Public key algorithms that the kernel supports. */
 enum pub_key_algos { PUBKEY_ALGO_RSA, PUBKEY_ALGO_ECDSA,
 		     PUBKEY_ALGO_ECDSA_NIST_P192, PUBKEY_ALGO_ECDSA_NIST_P256,
 		     PUBKEY_ALGO_ECDSA_NIST_P384, PUBKEY_ALGO__LAST };
 
+/* Signature encodings that the kernel supports. */
+enum sig_encodings { SIG_ENC_PKCS1, SIG_ENC_X962, SIG_ENC_RAW, SIG_ENC__LAST };
+
 struct msg_in {
 	enum cmds cmd;
 	size_t data_len;
@@ -44,9 +51,21 @@ struct umd_key_msg_out {
 	char key_desc[MAX_KEY_DESC_SIZE];
 } __packed;
 
+struct umd_sig_msg_out {
+	size_t sig_len;
+	unsigned char sig[MAX_SIG_SIZE];
+	enum pub_key_algos pkey_algo;
+	enum hash_algo hash_algo;
+	enum sig_encodings enc;
+	struct umd_asymmetric_key_ids auth_ids;
+	size_t sig_data_len;
+	unsigned char sig_data[MAX_SIG_DATA_SIZE];
+} __packed;
+
 struct msg_out {
 	int ret;
 	union {
 		struct umd_key_msg_out key;
+		struct umd_sig_msg_out sig;
 	};
 } __packed;
diff --git a/crypto/asymmetric_keys/umd_sig_parser.c b/crypto/asymmetric_keys/umd_sig_parser.c
new file mode 100644
index 00000000000..03bc2310f89
--- /dev/null
+++ b/crypto/asymmetric_keys/umd_sig_parser.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the UMD asymmetric key signature parser.
+ */
+
+#include <linux/module.h>
+#include <keys/asymmetric-subtype.h>
+#include <keys/asymmetric-parser.h>
+#include <crypto/public_key.h>
+#include <crypto/umd_sig.h>
+#include <crypto/hash_info.h>
+#include <crypto/hash.h>
+
+#include "umd_key.h"
+
+const char *sig_encodings[SIG_ENC__LAST] = {
+	[SIG_ENC_PKCS1] = "pkcs1",
+	[SIG_ENC_X962] = "x962",
+	[SIG_ENC_RAW] = "raw",
+};
+
+static struct public_key_signature *get_sig(struct msg_out *out)
+{
+	struct public_key_signature *sig = NULL;
+	int ret;
+
+	if (!out->sig.sig_len) {
+		pr_err("Unexpected zero-length for signature\n");
+		return ERR_PTR(-EBADMSG);
+	}
+
+	if (out->sig.sig_len > sizeof(out->sig.sig)) {
+		pr_err("Signature length %ld greater than expected %ld\n",
+		       out->sig.sig_len, sizeof(out->sig.sig));
+		return ERR_PTR(-EBADMSG);
+	}
+
+	if (out->sig.pkey_algo >= PUBKEY_ALGO__LAST) {
+		pr_err("Unexpected key algo %d\n", out->sig.pkey_algo);
+		return ERR_PTR(-EBADMSG);
+	}
+
+	if (out->sig.hash_algo >= HASH_ALGO__LAST) {
+		pr_err("Unexpected hash algo %d\n", out->sig.hash_algo);
+		return ERR_PTR(-EBADMSG);
+	}
+
+	if (out->sig.enc >= SIG_ENC__LAST) {
+		pr_err("Unexpected signature encoding %d\n", out->sig.enc);
+		return ERR_PTR(-EBADMSG);
+	}
+
+	sig = kzalloc(sizeof(*sig), GFP_KERNEL);
+	if (!sig)
+		return ERR_PTR(-ENOMEM);
+
+	sig->s = kmemdup(out->sig.sig, out->sig.sig_len, GFP_KERNEL);
+	if (!sig->s) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	sig->s_size = out->sig.sig_len;
+
+	ret = umd_get_kids(&out->sig.auth_ids, sig->auth_ids);
+	if (ret)
+		goto out;
+
+	sig->pkey_algo = pub_key_algos[out->sig.pkey_algo];
+	sig->hash_algo = hash_algo_name[out->sig.hash_algo];
+	sig->digest_size = hash_digest_size[out->sig.hash_algo];
+	sig->encoding = sig_encodings[out->sig.enc];
+out:
+	if (ret) {
+		public_key_signature_free(sig);
+		sig = ERR_PTR(ret);
+	}
+
+	return sig;
+}
+
+static int get_sig_data(struct msg_out *out, struct umd_sig_message *umd_sig)
+{
+	if (!out->sig.sig_data_len)
+		return 0;
+
+	if (out->sig.sig_data_len > sizeof(out->sig.sig_data)) {
+		pr_err("Additional data length %ld greater than expected %ld\n",
+		       out->sig.sig_data_len, sizeof(out->sig.sig_data));
+		return -EBADMSG;
+	}
+
+	umd_sig->sig_data = kmemdup(out->sig.sig_data, out->sig.sig_data_len,
+				    GFP_KERNEL);
+	if (!umd_sig->sig_data)
+		return -ENOMEM;
+
+	umd_sig->sig_data_len = out->sig.sig_data_len;
+	return 0;
+}
+
+/**
+ * umd_sig_parse_message - Parse a signature with a UMD handler
+ * @sig_data: Signature blob
+ * @sig_len: Length of signature blob
+ *
+ * Pass the signature blob to a UMD handler and fill a public_key_signature
+ * structure from the UMD handler response.
+ *
+ * Return: A umd_sig_message structure on success, an error pointer on error.
+ */
+struct umd_sig_message *umd_sig_parse_message(const u8 *sig_data,
+					      size_t sig_len)
+{
+	struct msg_in *in = NULL;
+	struct msg_out *out = NULL;
+	struct umd_sig_message *umd_sig = NULL;
+	int ret = -ENOMEM;
+
+	if (sig_len > sizeof(in->data))
+		return ERR_PTR(-EINVAL);
+
+	in = kzalloc(sizeof(*in), GFP_KERNEL);
+	if (!in)
+		goto out;
+
+	out = kzalloc(sizeof(*out), GFP_KERNEL);
+	if (!out)
+		goto out;
+
+	in->cmd = CMD_SIG;
+	in->data_len = sig_len;
+	memcpy(in->data, sig_data, sig_len);
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
+	umd_sig = kzalloc(sizeof(*umd_sig), GFP_KERNEL);
+	if (!umd_sig) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	umd_sig->sig = get_sig(out);
+	if (IS_ERR(umd_sig->sig)) {
+		ret = PTR_ERR(umd_sig->sig);
+		umd_sig->sig = NULL;
+		goto out;
+	}
+
+	ret = get_sig_data(out, umd_sig);
+out:
+	if (ret) {
+		if (umd_sig) {
+			public_key_signature_free(umd_sig->sig);
+			kfree(umd_sig);
+		}
+
+		umd_sig = ERR_PTR(ret);
+	}
+
+	kfree(in);
+	kfree(out);
+	return umd_sig;
+}
+EXPORT_SYMBOL_GPL(umd_sig_parse_message);
+
+/**
+ * umd_sig_supply_detached_data - Supply the data to verify a UMD-parsed sig
+ * @umd_sig: The UMD-parsed signature
+ * @data: The data to be verified
+ * @data_len: The amount of data
+ *
+ * Supply the detached data needed to verify a UMD-parsed signature. Note that
+ * no attempt to retain/pin the data is made. That is left to the caller. The
+ * data will not be modified by umd_sig_verify_message() and will not be freed
+ * when the UMD-parsed signature is freed.
+ *
+ * Return: Zero on success, -EINVAL if data are already supplied.
+ */
+int umd_sig_supply_detached_data(struct umd_sig_message *umd_sig,
+				 const void *data, size_t data_len)
+{
+	if (umd_sig->data) {
+		pr_debug("Data already supplied\n");
+		return -EINVAL;
+	}
+	umd_sig->data = data;
+	umd_sig->data_len = data_len;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(umd_sig_supply_detached_data);
+
+/**
+ * umd_sig_get_content_data - Get access to content data and additional data
+ * @umd_sig: The UMD-parsed signature
+ * @_data: Place to return a pointer to the data
+ * @_data_len: Place to return the data length
+ * @_headerlen: Size of the additional data
+ *
+ * Get access to the data associated to the UMD-parsed signature. This includes
+ * the content data eventually supplied by the caller of the UMD signatures API,
+ * and the additional data resulting from the signature parsing, appended at the
+ * end (the ordering can be configurable in the future).
+ *
+ * Data is allocated, to concatenate together the two data sources, and must be
+ * freed by the caller. It is presented in a way that is suitable for
+ * calculating the digest for verifying the signature.
+ *
+ * Return: Zero if the data and additional data can be provided,
+ *         a negative value on error.
+ */
+int umd_sig_get_content_data(struct umd_sig_message *umd_sig,
+			     const void **_data, size_t *_data_len,
+			     size_t *_headerlen)
+{
+	void *data;
+
+	if (!umd_sig->data)
+		return -ENODATA;
+
+	if (!_data)
+		goto skip_data;
+
+	data = kmalloc(umd_sig->data_len + umd_sig->sig->data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memcpy(data, umd_sig->data, umd_sig->data_len);
+	memcpy(data + umd_sig->data_len, umd_sig->sig->data,
+	       umd_sig->sig->data_size);
+	*_data = data;
+skip_data:
+	if (_data_len)
+		*_data_len = umd_sig->data_len + umd_sig->sig->data_size;
+	if (_headerlen)
+		*_headerlen = umd_sig->sig->data_size;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(umd_sig_get_content_data);
+
+static int umd_sig_digest(struct umd_sig_message *umd_sig)
+{
+	struct public_key_signature *sig = umd_sig->sig;
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	size_t desc_size;
+	int ret;
+
+	/* The digest was calculated already. */
+	if (sig->digest)
+		return 0;
+
+	tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
+	if (IS_ERR(tfm))
+		return (PTR_ERR(tfm) == -ENOENT) ? -ENOPKG : PTR_ERR(tfm);
+
+	desc_size = crypto_shash_descsize(tfm) + sizeof(*desc);
+
+	ret = -ENOMEM;
+	sig->digest = kmalloc(sig->digest_size, GFP_KERNEL);
+	if (!sig->digest)
+		goto error_no_desc;
+
+	desc = kzalloc(desc_size, GFP_KERNEL);
+	if (!desc)
+		goto error_no_desc;
+
+	desc->tfm = tfm;
+
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+
+	ret = crypto_shash_update(desc, umd_sig->data, umd_sig->data_len);
+	if (ret < 0)
+		goto error;
+
+	ret = crypto_shash_finup(desc, umd_sig->sig_data, umd_sig->sig_data_len,
+				 sig->digest);
+error:
+	kfree(desc);
+error_no_desc:
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+/**
+ * umd_sig_get_digest - Obtain the digest and algorithm of the data to verify
+ * @umd_sig: The UMD-parsed signature
+ * @digest: The buffer the digest is written to
+ * @digest_len: The length of @digest
+ * @hash_algo: The algorithm the digest is calculated with
+ *
+ * Calculate the digest of data to verify with the UMD-parsed signature, if
+ * not calculated already. Pass the pointer of the digest from the
+ * public_key_signature structure, the length and the algorithm to the caller.
+ *
+ * Return: Zero on success, a negative value otherwise.
+ */
+int umd_sig_get_digest(struct umd_sig_message *umd_sig, const u8 **digest,
+		       u32 *digest_len, enum hash_algo *hash_algo)
+{
+	struct public_key_signature *sig = umd_sig->sig;
+	int i, ret;
+
+	ret = umd_sig_digest(umd_sig);
+	if (ret)
+		return ret;
+
+	*digest = sig->digest;
+	*digest_len = sig->digest_size;
+
+	i = match_string(hash_algo_name, HASH_ALGO__LAST, sig->hash_algo);
+	if (i >= 0)
+		*hash_algo = i;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(umd_sig_get_digest);
+
+static struct key *get_key(struct umd_sig_message *umd_sig, struct key *keyring)
+{
+	struct public_key_signature *sig = umd_sig->sig;
+	struct key *key;
+
+	key = find_asymmetric_key(keyring, sig->auth_ids[0], sig->auth_ids[1],
+				  sig->auth_ids[2], true);
+	if (IS_ERR(key)) {
+		pr_debug("Public key not found (#%*phN, #%*phN, #%*phN)\n",
+			 sig->auth_ids[0]->len, sig->auth_ids[0]->data,
+			 sig->auth_ids[1]->len, sig->auth_ids[1]->data,
+			 sig->auth_ids[2]->len, sig->auth_ids[2]->data);
+
+		switch (PTR_ERR(key)) {
+			/* Hide some search errors */
+		case -EACCES:
+		case -ENOTDIR:
+		case -EAGAIN:
+			return ERR_PTR(-ENOKEY);
+		default:
+			return ERR_CAST(key);
+		}
+	}
+
+	return key;
+}
+
+/**
+ * umd_sig_verify_message - Verify the UMD-parsed signature
+ * @umd_sig: The UMD-parsed signature
+ * @keyring: Keyring containing the key for signature verification
+ *
+ * Calculate the digest, search the key for signature verification, and verify
+ * the signature.
+ *
+ * Return: Zero if the signature is valid, a negative value otherwise.
+ */
+int umd_sig_verify_message(struct umd_sig_message *umd_sig, struct key *keyring)
+{
+	const struct public_key *pub;
+	struct key *key;
+	int ret;
+
+	ret = umd_sig_digest(umd_sig);
+	if (ret < 0)
+		return ret;
+
+	key = get_key(umd_sig, keyring);
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	pub = key->payload.data[asym_crypto];
+
+	if (strcmp(pub->pkey_algo, umd_sig->sig->pkey_algo) != 0 &&
+	    (strncmp(pub->pkey_algo, "ecdsa-", 6) != 0 ||
+	     strcmp(umd_sig->sig->pkey_algo, "ecdsa") != 0)) {
+		ret = -EKEYREJECTED;
+		goto out;
+	}
+
+	ret = verify_signature(key, umd_sig->sig);
+out:
+	key_put(key);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(umd_sig_verify_message);
+
+/**
+ * umd_sig_free_message - Free the memory allocated
+ * @umd_sig: The UMD-parsed signature
+ *
+ * Free the memory allocated for the verification of the UMD-parsed signature.
+ */
+void umd_sig_free_message(struct umd_sig_message *umd_sig)
+{
+	if (!umd_sig)
+		return;
+
+	kfree(umd_sig->sig_data);
+	public_key_signature_free(umd_sig->sig);
+	kfree(umd_sig);
+}
+EXPORT_SYMBOL_GPL(umd_sig_free_message);
diff --git a/include/crypto/umd_sig.h b/include/crypto/umd_sig.h
new file mode 100644
index 00000000000..89b6646a4aa
--- /dev/null
+++ b/include/crypto/umd_sig.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header of the UMD asymmetric key signature parser.
+ */
+
+#ifndef _CRYPTO_UMD_SIG_H
+#define _CRYPTO_UMD_SIG_H
+
+#include <linux/verification.h>
+#include <linux/hash_info.h>
+#include <crypto/public_key.h>
+
+struct key;
+struct umd_sig_message;
+
+#ifdef CONFIG_UMD_SIG_PARSER
+extern struct umd_sig_message *umd_sig_parse_message(const u8 *sig_data,
+						     size_t sig_len);
+extern int umd_sig_supply_detached_data(struct umd_sig_message *umd_sig,
+					const void *data, size_t data_len);
+extern int umd_sig_get_content_data(struct umd_sig_message *umd_sig,
+				    const void **_data, size_t *_data_len,
+				    size_t *_headerlen);
+extern int umd_sig_get_digest(struct umd_sig_message *umd_sig, const u8 **buf,
+			      u32 *len, enum hash_algo *hash_algo);
+extern int umd_sig_verify_message(struct umd_sig_message *umd_sig,
+				  struct key *keyring);
+extern void umd_sig_free_message(struct umd_sig_message *umd_sig);
+#else
+static inline struct umd_sig_message *umd_sig_parse_message(const u8 *sig_data,
+							    size_t sig_len)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline int umd_sig_supply_detached_data(struct umd_sig_message *umd_sig,
+					       const void *data, size_t data_len)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int umd_sig_get_content_data(struct umd_sig_message *umd_sig,
+					   const void **_data,
+					   size_t *_data_len,
+					   size_t *_headerlen)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int umd_sig_get_digest(struct umd_sig_message *umd_sig, const u8 **buf,
+				     u32 *len, enum hash_algo *hash_algo)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int umd_sig_verify_message(struct umd_sig_message *umd_sig,
+					 struct key *keyring)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void umd_sig_free_message(struct umd_sig_message *umd_sig)
+{
+}
+
+#endif /* CONFIG_UMD_SIG_PARSER */
+#endif /* _CRYPTO_UMD_SIG_H */
-- 
2.25.1

