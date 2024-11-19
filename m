Return-Path: <linux-kselftest+bounces-22267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC59D2499
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 12:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46038283C69
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3892C1C6F76;
	Tue, 19 Nov 2024 11:10:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F01C4A18;
	Tue, 19 Nov 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014636; cv=none; b=CTHVFWh9w994CgDI/13SMLjpBbsOlEVKYcHmsa8kFXXDjkhg6otrNu55cmcObjPfSmvlR2Gf7fryqLGGzXHdvkMCYFoayh2vxb/Dx6eO75hW29nh/fhuxVwZbgX85Xcg3Qs6Q+o2QrMlvf3RfIQpJQghdMvxkwSfHasa2dkS51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014636; c=relaxed/simple;
	bh=suQp6CI3XDMPcDm8PiVZCYv/COsGp+w2F16O72yFRh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcKfhYjbfaLJDAGXvr1uRRVuaYxweE4fPo15bng1eSy+7wdCSTuvEoLLTg6Rm8jZx4vp3Rh3pEQFLHCmlnIN4ad9NbesDRAco1NDt/YAe7gZZFwuimwBgJzMJ/sZgM5cT3HyQUWbjLTSTdkQv7Xbo0UV4wIpbbcMiCtDTf7XowA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xt12N57Nwz9v7Hv;
	Tue, 19 Nov 2024 18:29:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 8144514011F;
	Tue, 19 Nov 2024 18:50:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3nn1LbTxnNp7pAQ--.49675S3;
	Tue, 19 Nov 2024 11:50:25 +0100 (CET)
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
Subject: [PATCH v6 01/15] lib: Add TLV parser
Date: Tue, 19 Nov 2024 11:49:08 +0100
Message-ID: <20241119104922.2772571-2-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwA3nn1LbTxnNp7pAQ--.49675S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW3ZF45tryxXry3XF4fKrg_yoW3ury3p3
	ZxWw1fGr48Jw1xCrWfGr4Utr1rXrs5uFy7tFy8WryFvrs2yr1DGrWDGry0gryxtryvkr1q
	qa4agFy5Kr1DXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j-
	kuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGc79-IEfwABsp

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a parser of a generic Type-Length-Value (TLV) format:

+--------------+--+---------+--------+---------+
| field1 (u16) | len1 (u32) | value1 (u8 len1) |
+--------------+------------+------------------+
|     ...      |    ...     |        ...       |
+--------------+------------+------------------+
| fieldN (u16) | lenN (u32) | valueN (u8 lenN) |
+--------------+------------+------------------+

Each adopter can define its own fields. The TLV parser does not need to be
aware of those, but lets the adopter obtain the data and decide how to
continue.

After processing a TLV entry, call the callback function also with the
callback data provided by the adopter. The latter can decide how to
interpret the TLV entry depending on the field ID.

Nesting TLVs is also possible, the callback function can call tlv_parse()
to parse the inner structure.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 MAINTAINERS                     |  8 +++
 include/linux/tlv_parser.h      | 32 ++++++++++++
 include/uapi/linux/tlv_parser.h | 41 ++++++++++++++++
 lib/Kconfig                     |  3 ++
 lib/Makefile                    |  2 +
 lib/tlv_parser.c                | 87 +++++++++++++++++++++++++++++++++
 lib/tlv_parser.h                | 18 +++++++
 7 files changed, 191 insertions(+)
 create mode 100644 include/linux/tlv_parser.h
 create mode 100644 include/uapi/linux/tlv_parser.h
 create mode 100644 lib/tlv_parser.c
 create mode 100644 lib/tlv_parser.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76ded..1f7ffa1c9dbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23388,6 +23388,14 @@ W:	http://sourceforge.net/projects/tlan/
 F:	Documentation/networking/device_drivers/ethernet/ti/tlan.rst
 F:	drivers/net/ethernet/ti/tlan.*
 
+TLV PARSER
+M:	Roberto Sassu <roberto.sassu@huawei.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	include/linux/tlv_parser.h
+F:	include/uapi/linux/tlv_parser.h
+F:	lib/tlv_parser.*
+
 TMIO/SDHI MMC DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
 L:	linux-mmc@vger.kernel.org
diff --git a/include/linux/tlv_parser.h b/include/linux/tlv_parser.h
new file mode 100644
index 000000000000..0c72742af548
--- /dev/null
+++ b/include/linux/tlv_parser.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header file of TLV parser.
+ */
+
+#ifndef _LINUX_TLV_PARSER_H
+#define _LINUX_TLV_PARSER_H
+
+#include <uapi/linux/tlv_parser.h>
+
+/**
+ * typedef callback - Callback after parsing TLV entry
+ * @callback_data: Opaque data to supply to the callback function
+ * @field: Field identifier
+ * @field_data: Field data
+ * @field_len: Length of @field_data
+ *
+ * This callback is invoked after a TLV entry is parsed.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+typedef int (*callback)(void *callback_data, __u16 field,
+			const __u8 *field_data, __u32 field_len);
+
+int tlv_parse(callback callback, void *callback_data, const __u8 *data,
+	      size_t data_len, const char **fields, __u32 num_fields);
+
+#endif /* _LINUX_TLV_PARSER_H */
diff --git a/include/uapi/linux/tlv_parser.h b/include/uapi/linux/tlv_parser.h
new file mode 100644
index 000000000000..171d0cfd2c4c
--- /dev/null
+++ b/include/uapi/linux/tlv_parser.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the user space interface for the TLV parser.
+ */
+
+#ifndef _UAPI_LINUX_TLV_PARSER_H
+#define _UAPI_LINUX_TLV_PARSER_H
+
+#include <linux/types.h>
+
+/*
+ * TLV format:
+ *
+ * +--------------+--+---------+--------+---------+
+ * | field1 (u16) | len1 (u32) | value1 (u8 len1) |
+ * +--------------+------------+------------------+
+ * |     ...      |    ...     |        ...       |
+ * +--------------+------------+------------------+
+ * | fieldN (u16) | lenN (u32) | valueN (u8 lenN) |
+ * +--------------+------------+------------------+
+ */
+
+/**
+ * struct tlv_entry - Entry of TLV format
+ * @field: Field identifier
+ * @length: Data length
+ * @data: Data
+ *
+ * This structure represents an entry of the TLV format.
+ */
+struct tlv_entry {
+	__u16 field;
+	__u32 length;
+	__u8 data[];
+} __attribute__((packed));
+
+#endif /* _UAPI_LINUX_TLV_PARSER_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index b38849af6f13..9141dcfc1704 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -777,3 +777,6 @@ config POLYNOMIAL
 
 config FIRMWARE_TABLE
 	bool
+
+config TLV_PARSER
+	bool
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..630de494eab5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -393,5 +393,7 @@ obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
 obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
+obj-$(CONFIG_TLV_PARSER) += tlv_parser.o
+CFLAGS_tlv_parser.o += -I lib
 
 subdir-$(CONFIG_FORTIFY_SOURCE) += test_fortify
diff --git a/lib/tlv_parser.c b/lib/tlv_parser.c
new file mode 100644
index 000000000000..dbbe08018b4d
--- /dev/null
+++ b/lib/tlv_parser.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the TLV parser.
+ */
+
+#define pr_fmt(fmt) "tlv_parser: "fmt
+#include <tlv_parser.h>
+
+/**
+ * tlv_parse - Parse TLV data
+ * @callback: Callback function to call to parse the entries
+ * @callback_data: Opaque data to supply to the callback function
+ * @data: Data to parse
+ * @data_len: Length of @data
+ * @fields: Array of field strings
+ * @num_fields: Number of elements of @fields
+ *
+ * Parse the TLV data format and call the supplied callback function for each
+ * entry, passing also the opaque data pointer.
+ *
+ * The callback function decides how to process data depending on the field.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+int tlv_parse(callback callback, void *callback_data, const __u8 *data,
+	      size_t data_len, const char **fields, __u32 num_fields)
+{
+	const __u8 *data_ptr = data;
+	struct tlv_entry *entry;
+	__u16 parsed_field;
+	__u32 len;
+	int ret;
+
+	if (data_len > U32_MAX) {
+		pr_debug("Data too big, size: %zd\n", data_len);
+		return -E2BIG;
+	}
+
+	while (data_len) {
+		if (data_len < sizeof(*entry))
+			return -EBADMSG;
+
+		entry = (struct tlv_entry *)data_ptr;
+		data_ptr += sizeof(*entry);
+		data_len -= sizeof(*entry);
+
+		parsed_field = __be16_to_cpu(entry->field);
+		if (parsed_field >= num_fields) {
+			pr_debug("Invalid field %u, max: %u\n",
+				 parsed_field, num_fields - 1);
+			return -EBADMSG;
+		}
+
+		len = __be32_to_cpu(entry->length);
+
+		if (data_len < len)
+			return -EBADMSG;
+
+		pr_debug("Data: field: %s, len: %u\n", fields[parsed_field],
+			 len);
+
+		if (!len)
+			continue;
+
+		ret = callback(callback_data, parsed_field, data_ptr, len);
+		if (ret < 0) {
+			pr_debug("Parsing of field %s failed, ret: %d\n",
+				 fields[parsed_field], ret);
+			return ret;
+		}
+
+		data_ptr += len;
+		data_len -= len;
+	}
+
+	if (data_len) {
+		pr_debug("Excess data: %zu bytes\n", data_len);
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tlv_parse);
diff --git a/lib/tlv_parser.h b/lib/tlv_parser.h
new file mode 100644
index 000000000000..e663966deac5
--- /dev/null
+++ b/lib/tlv_parser.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header file of TLV parser.
+ */
+
+#ifndef _LIB_TLV_PARSER_H
+#define _LIB_TLV_PARSER_H
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/limits.h>
+#include <linux/tlv_parser.h>
+
+#endif /* _LIB_TLV_PARSER_H */
-- 
2.47.0.118.gfd3785337b


