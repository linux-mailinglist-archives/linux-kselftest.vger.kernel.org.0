Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFEA749F63
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjGFOqU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjGFOqN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 10:46:13 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EF2173F;
        Thu,  6 Jul 2023 07:46:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QxfFN70tgz9xFGd;
        Thu,  6 Jul 2023 22:35:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHQg0y06ZkPxkwBA--.58122S5;
        Thu, 06 Jul 2023 15:45:20 +0100 (CET)
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
Subject: [RFC][PATCH 03/10] KEYS: asymmetric: Introduce a parser for user asymmetric keys and sigs
Date:   Thu,  6 Jul 2023 16:42:16 +0200
Message-Id: <20230706144225.1046544-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
References: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHQg0y06ZkPxkwBA--.58122S5
X-Coremail-Antispam: 1UD129KBjvJXoW3tryfGr17ZrWUXw1rGF13XFb_yoWkKrW8pa
        4fWry3trZ8twn7CrWfAr47Gr47ur4ruFWagF95CF1SvFs0vr1kCrW8KFy0gFy8Ka48Gry8
        J3yYqFyDGw1kJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
        AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r
        4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
        Xa7IU04xRDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4-V4wABsG
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

Introduce the common parser for user asymmetric keys and signatures. The
data format is TLV-based, and consists of a header and the data.

Key and signature blobs can be parsed with the new function uasym_parse().
Each caller of that function should provide a callback function,
responsible to parse their fields, and an opaque data pointer to be used by
the callback function to store the parsed data.

The same data format will be used to store both keys and signatures, albeit
with different fields.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/Kconfig        |  12 ++
 crypto/asymmetric_keys/Makefile       |   7 +
 crypto/asymmetric_keys/uasym_parser.c | 201 ++++++++++++++++++++++++++
 crypto/asymmetric_keys/uasym_parser.h |  30 ++++
 include/uapi/linux/uasym_parser.h     |  91 ++++++++++++
 5 files changed, 341 insertions(+)
 create mode 100644 crypto/asymmetric_keys/uasym_parser.c
 create mode 100644 crypto/asymmetric_keys/uasym_parser.h
 create mode 100644 include/uapi/linux/uasym_parser.h

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 1ef3b46d6f6..4f86fe78efd 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -85,4 +85,16 @@ config FIPS_SIGNATURE_SELFTEST
 	depends on ASYMMETRIC_KEY_TYPE
 	depends on PKCS7_MESSAGE_PARSER=X509_CERTIFICATE_PARSER
 
+config UASYM_KEYS_SIGS
+	tristate "User asymmetric keys and signatures"
+	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	help
+	  This option enables user asymmetric keys and signatures. They are
+	  keys and signatures converted in user space from their native
+	  format (e.g. PGP), to the TLV format (Type-Length-Value) understood
+	  by the kernel.
+
+	  Key and signature-specific fields are defined in the UAPI interface,
+	  so that user space converters can reference them.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index 0d1fa1b692c..ac3955d834f 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -76,3 +76,10 @@ verify_signed_pefile-y := \
 
 $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
 $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
+
+#
+# User asymmetric keys and signatures
+#
+obj-$(CONFIG_UASYM_KEYS_SIGS) += uasym_keys_sigs.o
+uasym_keys_sigs-y := \
+	uasym_parser.o
diff --git a/crypto/asymmetric_keys/uasym_parser.c b/crypto/asymmetric_keys/uasym_parser.c
new file mode 100644
index 00000000000..e207f350c40
--- /dev/null
+++ b/crypto/asymmetric_keys/uasym_parser.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the user asymmetric keys and signature parser.
+ */
+
+#define pr_fmt(fmt) "UASYM PARSER: "fmt
+
+#include "uasym_parser.h"
+
+const char *data_types_str[] = {
+	FOR_EACH_DATA_TYPE(GENERATE_STRING)
+};
+
+const char *fields_str[] = {
+	FOR_EACH_FIELD(GENERATE_STRING)
+};
+
+/**
+ * uasym_parse_hdr - Parse a user asymmetric key or signature header
+ * @data: Data to parse (updated)
+ * @data_len: Length of @data (updated)
+ * @data_type: Data type (updated)
+ * @num_fields: Data fields (updated)
+ * @total_len: Length of key or signature, excluding the header (updated)
+ *
+ * Parse the header of a user asymmetric key or signature, update the data
+ * pointer and length, and provide the data type, number of fields and the
+ * length of that element.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+int uasym_parse_hdr(const u8 **data, size_t *data_len, u8 *data_type,
+		    u16 *num_fields, u64 *total_len)
+{
+	struct uasym_hdr *hdr;
+
+	if (*data_len < sizeof(*hdr)) {
+		pr_debug("Data blob too short, %lu bytes, expected %lu\n",
+			 *data_len, sizeof(*hdr));
+		return -EBADMSG;
+	}
+
+	hdr = (struct uasym_hdr *)*data;
+
+	*data += sizeof(*hdr);
+	*data_len -= sizeof(*hdr);
+
+	*data_type = hdr->data_type;
+	if (*data_type >= TYPE__LAST) {
+		pr_debug("Invalid data type %u\n", *data_type);
+		return -EBADMSG;
+	}
+
+	if (hdr->_reserved0 != 0) {
+		pr_debug("_reserved0 must be zero\n");
+		return -EBADMSG;
+	}
+
+	*num_fields = be16_to_cpu(hdr->num_fields);
+	if (*num_fields >= FIELD__LAST) {
+		pr_debug("Too many fields %u, max: %u\n", *num_fields,
+			 FIELD__LAST);
+		return -EBADMSG;
+	}
+
+	if (hdr->_reserved1 != 0) {
+		pr_debug("_reserved1 must be zero\n");
+		return -EBADMSG;
+	}
+
+	*total_len = be64_to_cpu(hdr->total_len);
+	if (*total_len > *data_len) {
+		pr_debug("Invalid total length %llu, expected: %lu\n",
+			 *total_len, *data_len);
+		return -EBADMSG;
+	}
+
+	pr_debug("Header: type: %s, num fields: %d, total len: %lld\n",
+		 data_types_str[hdr->data_type], *num_fields, *total_len);
+
+	return 0;
+}
+
+/**
+ * uasym_parse_data - Parse a user asymmetric key or signature data
+ * @callback: Callback function to call to parse the fields
+ * @callback_data: Opaque data to supply to the callback function
+ * @num_fields: Data fields
+ * @data: Data to parse
+ * @data_len: Length of @data
+ *
+ * Parse the data part of a user asymmetric key or signature and call the
+ * supplied callback function for each data field, passing also the opaque
+ * data pointer.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+int uasym_parse_data(parse_callback callback, void *callback_data,
+		     u16 num_fields, const u8 *data, size_t data_len)
+{
+	const u8 *data_ptr = data;
+	struct uasym_entry *entry;
+	u16 field;
+	u32 len;
+	int ret, i;
+
+	for (i = 0; i < num_fields; i++) {
+		if (data_len < sizeof(*entry))
+			return -EBADMSG;
+
+		entry = (struct uasym_entry *)data_ptr;
+		data_ptr += sizeof(*entry);
+		data_len -= sizeof(*entry);
+
+		field = be16_to_cpu(entry->field);
+		len = be32_to_cpu(entry->length);
+
+		if (data_len < len)
+			return -EBADMSG;
+
+		pr_debug("Data: field: %s, len: %d\n", fields_str[field], len);
+
+		if (!len)
+			continue;
+
+		ret = callback(callback_data, field, data_ptr, len);
+		if (ret < 0) {
+			pr_debug("Parsing of field %s failed, ret: %d\n",
+				 fields_str[field], ret);
+			return -EBADMSG;
+		}
+
+		data_ptr += len;
+		data_len -= len;
+	}
+
+	if (data_len) {
+		pr_debug("Excess data: %ld bytes\n", data_len);
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+
+/**
+ * uasym_parse - Parse a user asymmetric key or signature
+ * @expected_data_type: Desired data type
+ * @callback: Callback function to call to parse the fields
+ * @callback_data: Opaque data to supply to the callback function
+ * @data: Data to parse
+ * @data_len: Length of @data
+ *
+ * Parse a user asymmetric key or signature and call the supplied callback
+ * function for each data field, passing also the opaque data pointer.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+int uasym_parse(enum data_types expected_data_type, parse_callback callback,
+		void *callback_data, const u8 *data, size_t data_len)
+{
+	u8 data_type;
+	u16 num_fields;
+	u64 total_len;
+	int ret = 0;
+
+	pr_debug("Start parsing data blob, size: %ld, expected data type: %s\n",
+		 data_len, data_types_str[expected_data_type]);
+
+	while (data_len) {
+		ret = uasym_parse_hdr(&data, &data_len, &data_type, &num_fields,
+				      &total_len);
+		if (ret < 0)
+			goto out;
+
+		if (data_type == expected_data_type)
+			break;
+
+		/*
+		 * uasym_parse_hdr() already checked that total_len <= data_len.
+		 */
+		data += total_len;
+		data_len -= total_len;
+	}
+
+	if (!data_len) {
+		pr_debug("Data type %s not found\n",
+			 data_types_str[expected_data_type]);
+		ret = -ENOENT;
+		goto out;
+	}
+
+	ret = uasym_parse_data(callback, callback_data, num_fields, data,
+			       total_len);
+out:
+	pr_debug("End of parsing data blob, ret: %d\n", ret);
+	return ret;
+}
diff --git a/crypto/asymmetric_keys/uasym_parser.h b/crypto/asymmetric_keys/uasym_parser.h
new file mode 100644
index 00000000000..985dda6aad3
--- /dev/null
+++ b/crypto/asymmetric_keys/uasym_parser.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header file of user asymmetric keys and signatures.
+ */
+
+#include <keys/asymmetric-subtype.h>
+#include <keys/asymmetric-parser.h>
+
+#include <uapi/linux/uasym_parser.h>
+
+#define kenter(FMT, ...) \
+	pr_debug("==> %s("FMT")\n", __func__, ##__VA_ARGS__)
+#define kleave(FMT, ...) \
+	pr_debug("<== %s()"FMT"\n", __func__, ##__VA_ARGS__)
+
+typedef int (*parse_callback)(void *, enum fields, const u8 *, u32);
+
+extern const char *data_types_str[];
+extern const char *fields_str[];
+
+int uasym_parse_hdr(const u8 **data, size_t *data_len, u8 *data_type,
+		    u16 *num_fields, u64 *total_len);
+int uasym_parse_data(parse_callback callback, void *callback_data,
+		     u16 num_fields, const u8 *data, size_t data_len);
+int uasym_parse(enum data_types expected_data_type, parse_callback callback,
+		void *callback_data, const u8 *data, size_t data_len);
diff --git a/include/uapi/linux/uasym_parser.h b/include/uapi/linux/uasym_parser.h
new file mode 100644
index 00000000000..8f0bc235492
--- /dev/null
+++ b/include/uapi/linux/uasym_parser.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the user space interface for user asymmetric keys and signatures.
+ */
+
+#ifndef _UAPI_LINUX_UASYM_PARSER_H
+#define _UAPI_LINUX_UASYM_PARSER_H
+
+#include <linux/types.h>
+#include <linux/pub_key_info.h>
+
+/*
+ * User asymmmetric key and signature format:
+ *
+ * +----------------+-----------------+-----------------+
+ * | data type (u8) | num fields (u16)| total len (u64) |
+ * +--------------+-+----------+------+-----------+-----+
+ * | field1 (u16) | len1 (u32) | value1 (u8 len1) |
+ * +--------------+------------+------------------+
+ * |     ...      |    ...     |        ...       |
+ * +--------------+------------+------------------+
+ * | fieldN (u16) | lenN (u32) | valueN (u8 lenN) |
+ * +--------------+------------+------------------+
+ */
+
+/**
+ * struct uasym_hdr - Header of user asymmetric keys and signatures
+ * @data_type: Type of data to parse
+ * @_reserved0: Reserved for future use
+ * @num_fields: Number of fields provided
+ * @_reserved1: Reserved for future use
+ * @total_len: Total length of the data blob, excluding the header
+ *
+ * This structure represents the header of the user asymmetric keys and
+ * signatures format.
+ */
+struct uasym_hdr {
+	__u8 data_type;
+	__u8 _reserved0;
+	__u16 num_fields;
+	__u32 _reserved1;
+	__u64 total_len;
+} __packed;
+
+/**
+ * struct uasym_entry - Data entry of user asymmetric keys and signatures
+ * @field: Data field identifier
+ * @length: Data length
+ * @data: Data
+ *
+ * This structure represents a TLV entry of the data part of the user
+ * asymmetric keys and signatures format.
+ */
+struct uasym_entry {
+	__u16 field;
+	__u32 length;
+	__u8 data[];
+} __packed;
+
+#define FOR_EACH_DATA_TYPE(DATA_TYPE) \
+	DATA_TYPE(TYPE__LAST)
+
+#define FOR_EACH_FIELD(FIELD) \
+	FIELD(FIELD__LAST)
+
+#define GENERATE_ENUM(ENUM) ENUM,
+#define GENERATE_STRING(STRING) #STRING,
+
+/**
+ * enum data_types - Type of data to parse
+ *
+ * Enumerates the type of data to parse.
+ */
+enum data_types {
+	FOR_EACH_DATA_TYPE(GENERATE_ENUM)
+};
+
+/**
+ * enum fields - Data fields
+ *
+ * Enumerates the data fields. Some belongs to keys, some to signatures.
+ */
+enum fields {
+	FOR_EACH_FIELD(GENERATE_ENUM)
+};
+
+#endif /* _UAPI_LINUX_UASYM_PARSER_H */
-- 
2.34.1

