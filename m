Return-Path: <linux-kselftest+bounces-7973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F18A5372
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4691F21A5C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA6076410;
	Mon, 15 Apr 2024 14:26:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C725176045;
	Mon, 15 Apr 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191212; cv=none; b=UMYIpYKSRdoplJO4gl1f306jHP7+oP06srxgCNvFavBGsMM+7Uc1fxLgCXL0ELqgTW/NXgqwJUrKlsInx3MEaB1NSFO4WTXGEOHixhHcRwaLT3OH/2k8qFu1F40aVI4vZrfhgzjp76hfJWu4SjVOVciutSjNFmuo8V0oJzIyUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191212; c=relaxed/simple;
	bh=ZakGaqYvWHQu0xsmUPyOoBT1PL9LRpLAIlDrVvxlUps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pz1ZW6LAw7kSWKPZH7UcczFBi8zsige7Mflc2yw8GhQnCV9l8QVsiuXfayrC2w5akeXqzq+MQ75Fy7MpYHVScL1acUfw1ahmZSYWqx7oaERktu+63MqVIxE63p8TfXReEV+rJ/Nb5kBT8nKa2umY0hgaX9VcdUqoO9ahYxaAyNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VJ8Fj3BjRz9xGn5;
	Mon, 15 Apr 2024 22:10:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B25681404FC;
	Mon, 15 Apr 2024 22:26:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnoSWrOB1myEJGBg--.9473S8;
	Mon, 15 Apr 2024 15:26:39 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	mic@digikod.net
Cc: linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	linux-integrity@vger.kernel.org,
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
Subject: [PATCH v4 06/14] digest_cache: Parse tlv digest lists
Date: Mon, 15 Apr 2024 16:24:28 +0200
Message-Id: <20240415142436.2545003-7-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwBnoSWrOB1myEJGBg--.9473S8
X-Coremail-Antispam: 1UD129KBjvAXoW3uF13Cw43uF4DuF4UXw45Awb_yoW8Ww1Dto
	Z0vF4UAw4rtr429F4kCF13Ar4rG3yYqFyrAw4fGr4DW3W8tFy5ta1kCa15Ga98Zw1rtFZF
	yr18J3yFqrWUKrs7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOO7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
	67AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wr
	v_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZF
	pf9x07jxWrAUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5x11AAAsH

From: Roberto Sassu <roberto.sassu@huawei.com>

Add digest_list_parse_tlv(), to parse TLV-formatted (Type Length Value)
digest lists. Their structure is:

[header: DIGEST_LIST_FILE, num fields, total len]
[field: DIGEST_LIST_ALGO, length, value]
[field: DIGEST_LIST_ENTRY#1, length, value (below)]
 |- [header: DIGEST_LIST_ENTRY_DATA, num fields, total len]
 |- [DIGEST_LIST_ENTRY_DIGEST#1, length, file digest]
 |- [DIGEST_LIST_ENTRY_PATH#1, length, file path]
[field: DIGEST_LIST_ENTRY#N, length, value (below)]
 |- [header: DIGEST_LIST_ENTRY_DATA, num fields, total len]
 |- [DIGEST_LIST_ENTRY_DIGEST#N, length, file digest]
 |- [DIGEST_LIST_ENTRY_PATH#N, length, file path]

DIGEST_LIST_ALGO must have a fixed length of sizeof(u64).

The data of the DIGEST_LIST_ENTRY field are itself in TLV format.

Currently defined fields are sufficient for measurement/appraisal of file
data. More fields will be introduced later for file metadata.

Introduce digest_list_file_callback() to handle the DIGEST_LIST_FILE
fields, DIGEST_LIST_ALGO and DIGEST_LIST_ENTRY, and the respective field
parsers parse_digest_list_algo() and parse_digest_list_entry().

Also introduce digest_list_entry_data_callback(), to handle the
DIGEST_LIST_ENTRY_DATA (nested) fields, DIGEST_LIST_ENTRY_DIGEST and
DIGEST_LIST_ENTRY_PATH, and the respective field parsers
parse_digest_list_entry_digest() and parse_digest_list_entry_path().

The TLV parser itself is defined in lib/tlv_parser.c.

Both the TLV parser and the tlv digest list parser have been formally
verified with Frama-C (https://frama-c.com/).

The analysis has been done on this file:

https://github.com/robertosassu/rpm-formal/blob/main/validate_tlv.c

Here is the result of the analysis:

[eva:summary] ====== ANALYSIS SUMMARY ======
---------------------------------------------------------------------------
13 functions analyzed (out of 13): 100% coverage.
In these functions, 240 statements reached (out of 254): 94% coverage.
---------------------------------------------------------------------------
Some errors and warnings have been raised during the analysis:
  by the Eva analyzer:      0 errors    4 warnings
  by the Frama-C kernel:    0 errors    0 warnings
---------------------------------------------------------------------------
0 alarms generated by the analysis.
---------------------------------------------------------------------------
Evaluation of the logical properties reached by the analysis:
  Assertions        5 valid     0 unknown     0 invalid      5 total
  Preconditions    24 valid     0 unknown     0 invalid     24 total
100% of the logical properties reached have been proven.
---------------------------------------------------------------------------

The warnings are:

[eva] validate_tlv.c:437: Warning:
  this partitioning parameter cannot be evaluated safely on all states
[eva] validate_tlv.c:445: Warning:
  this partitioning parameter cannot be evaluated safely on all states
[eva] validate_tlv.c:354: Warning:
  this partitioning parameter cannot be evaluated safely on all states
[eva] validate_tlv.c:382: Warning:
  this partitioning parameter cannot be evaluated safely on all states

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/uapi/linux/tlv_digest_list.h    |  72 ++++++
 security/digest_cache/Kconfig           |   1 +
 security/digest_cache/Makefile          |   2 +
 security/digest_cache/parsers/parsers.h |  13 ++
 security/digest_cache/parsers/tlv.c     | 299 ++++++++++++++++++++++++
 security/digest_cache/populate.c        |   4 +
 6 files changed, 391 insertions(+)
 create mode 100644 include/uapi/linux/tlv_digest_list.h
 create mode 100644 security/digest_cache/parsers/parsers.h
 create mode 100644 security/digest_cache/parsers/tlv.c

diff --git a/include/uapi/linux/tlv_digest_list.h b/include/uapi/linux/tlv_digest_list.h
new file mode 100644
index 000000000000..8c97a46901c1
--- /dev/null
+++ b/include/uapi/linux/tlv_digest_list.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Export definitions of the tlv digest list.
+ */
+
+#ifndef _UAPI_LINUX_TLV_DIGEST_LIST_H
+#define _UAPI_LINUX_TLV_DIGEST_LIST_H
+
+#include <linux/types.h>
+
+#define FOR_EACH_DIGEST_LIST_TYPE(DIGEST_LIST_TYPE) \
+	DIGEST_LIST_TYPE(DIGEST_LIST_FILE) \
+	DIGEST_LIST_TYPE(DIGEST_LIST__LAST)
+
+#define FOR_EACH_DIGEST_LIST_FIELD(DIGEST_LIST_FIELD) \
+	DIGEST_LIST_FIELD(DIGEST_LIST_ALGO) \
+	DIGEST_LIST_FIELD(DIGEST_LIST_ENTRY) \
+	DIGEST_LIST_FIELD(DIGEST_LIST_FIELD__LAST)
+
+#define FOR_EACH_DIGEST_LIST_ENTRY_TYPE(DIGEST_LIST_ENTRY_TYPE) \
+	DIGEST_LIST_ENTRY_TYPE(DIGEST_LIST_ENTRY_DATA) \
+	DIGEST_LIST_ENTRY_TYPE(DIGEST_LIST_ENTRY__LAST)
+
+#define FOR_EACH_DIGEST_LIST_ENTRY_FIELD(DIGEST_LIST_ENTRY_FIELD) \
+	DIGEST_LIST_ENTRY_FIELD(DIGEST_LIST_ENTRY_DIGEST) \
+	DIGEST_LIST_ENTRY_FIELD(DIGEST_LIST_ENTRY_PATH) \
+	DIGEST_LIST_ENTRY_FIELD(DIGEST_LIST_ENTRY_FIELD__LAST)
+
+#define GENERATE_ENUM(ENUM) ENUM,
+#define GENERATE_STRING(STRING) #STRING,
+
+/**
+ * enum digest_list_types - Types of digest list
+ *
+ * Enumerates the types of digest list to parse.
+ */
+enum digest_list_types {
+	FOR_EACH_DIGEST_LIST_TYPE(GENERATE_ENUM)
+};
+
+/**
+ * enum digest_list_fields - Digest list fields
+ *
+ * Enumerates the digest list fields.
+ */
+enum digest_list_fields {
+	FOR_EACH_DIGEST_LIST_FIELD(GENERATE_ENUM)
+};
+
+/**
+ * enum digest_list_entry_types - Types of data stored in DIGEST_LIST_ENTRY
+ *
+ * Enumerates the types of data stored in DIGEST_LIST_ENTRY (nested TLV data).
+ */
+enum digest_list_entry_types {
+	FOR_EACH_DIGEST_LIST_ENTRY_TYPE(GENERATE_ENUM)
+};
+
+/**
+ * enum digest_list_entry_fields - DIGEST_LIST_ENTRY fields
+ *
+ * Enumerates the DIGEST_LIST_ENTRY fields.
+ */
+enum digest_list_entry_fields {
+	FOR_EACH_DIGEST_LIST_ENTRY_FIELD(GENERATE_ENUM)
+};
+
+#endif /* _UAPI_LINUX_TLV_DIGEST_LIST_H */
diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kconfig
index 71017954e5c5..cb4fa44e8f2a 100644
--- a/security/digest_cache/Kconfig
+++ b/security/digest_cache/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config SECURITY_DIGEST_CACHE
 	bool "Digest_cache LSM"
+	select TLV_PARSER
 	default n
 	help
 	  This option enables an LSM maintaining a cache of digests
diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makefile
index c1452437d02f..a383b6ef2550 100644
--- a/security/digest_cache/Makefile
+++ b/security/digest_cache/Makefile
@@ -5,3 +5,5 @@
 obj-$(CONFIG_SECURITY_DIGEST_CACHE) += digest_cache.o
 
 digest_cache-y := main.o secfs.o htable.o populate.o modsig.o
+
+digest_cache-y += parsers/tlv.o
diff --git a/security/digest_cache/parsers/parsers.h b/security/digest_cache/parsers/parsers.h
new file mode 100644
index 000000000000..1bbae426ab9f
--- /dev/null
+++ b/security/digest_cache/parsers/parsers.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Digest list parsers.
+ */
+
+#include "../internal.h"
+
+int digest_list_parse_tlv(struct digest_cache *digest_cache, const u8 *data,
+			  size_t data_len);
diff --git a/security/digest_cache/parsers/tlv.c b/security/digest_cache/parsers/tlv.c
new file mode 100644
index 000000000000..97e2c36b93a8
--- /dev/null
+++ b/security/digest_cache/parsers/tlv.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Parse a tlv digest list.
+ */
+
+#define pr_fmt(fmt) "TLV DIGEST LIST: "fmt
+#include <linux/tlv_parser.h>
+#include <uapi/linux/tlv_digest_list.h>
+
+#include "parsers.h"
+
+#define kenter(FMT, ...) \
+	pr_debug("==> %s(" FMT ")\n", __func__, ##__VA_ARGS__)
+#define kleave(FMT, ...) \
+	pr_debug("<== %s()" FMT "\n", __func__, ##__VA_ARGS__)
+
+const char *digest_list_types_str[] = {
+	FOR_EACH_DIGEST_LIST_TYPE(GENERATE_STRING)
+};
+
+const char *digest_list_fields_str[] = {
+	FOR_EACH_DIGEST_LIST_FIELD(GENERATE_STRING)
+};
+
+const char *digest_list_entry_types_str[] = {
+	FOR_EACH_DIGEST_LIST_ENTRY_TYPE(GENERATE_STRING)
+};
+
+const char *digest_list_entry_fields_str[] = {
+	FOR_EACH_DIGEST_LIST_ENTRY_FIELD(GENERATE_STRING)
+};
+
+struct tlv_callback_data {
+	struct digest_cache *digest_cache;
+	u64 parsed_data_type;
+	u64 parsed_num_entries;
+	u64 parsed_total_len;
+	enum hash_algo algo;
+};
+
+/**
+ * parse_digest_list_entry_digest - Parse DIGEST_LIST_ENTRY_DIGEST field
+ * @tlv_data: Parser callback data
+ * @field: Field identifier
+ * @field_data: Field data
+ * @field_data_len: Length of @field_data
+ *
+ * This function parses the DIGEST_LIST_ENTRY_DIGEST field (file digest).
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+static int parse_digest_list_entry_digest(struct tlv_callback_data *tlv_data,
+					  enum digest_list_entry_fields field,
+					  const u8 *field_data,
+					  u64 field_data_len)
+{
+	int ret;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	if (tlv_data->algo == HASH_ALGO__LAST) {
+		pr_debug("Digest algo not set\n");
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	if (field_data_len != hash_digest_size[tlv_data->algo]) {
+		pr_debug("Unexpected data length %llu, expected %d\n",
+			 field_data_len, hash_digest_size[tlv_data->algo]);
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	ret = digest_cache_htable_add(tlv_data->digest_cache, (u8 *)field_data,
+				      tlv_data->algo);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+/**
+ * parse_digest_list_entry_path - Parse DIGEST_LIST_ENTRY_PATH field
+ * @tlv_data: Parser callback data
+ * @field: Field identifier
+ * @field_data: Field data
+ * @field_data_len: Length of @field_data
+ *
+ * This function handles the DIGEST_LIST_ENTRY_PATH field (file path). It
+ * currently does not parse the data.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+static int parse_digest_list_entry_path(struct tlv_callback_data *tlv_data,
+					enum digest_list_entry_fields field,
+					const u8 *field_data,
+					u64 field_data_len)
+{
+	kenter(",%u,%llu", field, field_data_len);
+
+	kleave(" = 0");
+	return 0;
+}
+
+/**
+ * digest_list_entry_data_callback - DIGEST_LIST_ENTRY_DATA callback
+ * @callback_data: Callback data
+ * @field: Field identifier
+ * @field_data: Field data
+ * @field_data_len: Length of @field_data
+ *
+ * This callback handles the fields of DIGEST_LIST_ENTRY_DATA (nested) data,
+ * and calls the appropriate parser.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+static int digest_list_entry_data_callback(void *callback_data, u64 field,
+					   const u8 *field_data,
+					   u64 field_data_len)
+{
+	struct tlv_callback_data *tlv_data;
+	int ret;
+
+	tlv_data = (struct tlv_callback_data *)callback_data;
+
+	switch (field) {
+	case DIGEST_LIST_ENTRY_DIGEST:
+		ret = parse_digest_list_entry_digest(tlv_data, field,
+						     field_data,
+						     field_data_len);
+		break;
+	case DIGEST_LIST_ENTRY_PATH:
+		ret = parse_digest_list_entry_path(tlv_data, field, field_data,
+						   field_data_len);
+		break;
+	default:
+		pr_debug("Unhandled field %s\n",
+			 digest_list_entry_fields_str[field]);
+		/* Just ignore non-relevant fields. */
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+/**
+ * parse_digest_list_algo - Parse DIGEST_LIST_ALGO field
+ * @tlv_data: Parser callback data
+ * @field: Field identifier
+ * @field_data: Field data
+ * @field_data_len: Length of @field_data
+ *
+ * This function parses the DIGEST_LIST_ALGO field (digest algorithm).
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+static int parse_digest_list_algo(struct tlv_callback_data *tlv_data,
+				  enum digest_list_fields field,
+				  const u8 *field_data, u64 field_data_len)
+{
+	u64 algo;
+	int ret;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	if (field_data_len != sizeof(u64)) {
+		pr_debug("Unexpected data length %llu, expected %lu\n",
+			 field_data_len, sizeof(u64));
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	algo = __be64_to_cpu(*(u64 *)field_data);
+
+	if (algo >= HASH_ALGO__LAST) {
+		pr_debug("Unexpected digest algo %llu\n", algo);
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	ret = digest_cache_htable_init(tlv_data->digest_cache,
+				       tlv_data->parsed_num_entries, algo);
+	if (ret < 0)
+		goto out;
+
+	tlv_data->algo = algo;
+
+	pr_debug("Digest algo: %s\n", hash_algo_name[algo]);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+/**
+ * parse_digest_list_entry - Parse DIGEST_LIST_ENTRY field
+ * @tlv_data: Parser callback data
+ * @field: Field identifier
+ * @field_data: Field data
+ * @field_data_len: Length of @field_data
+ *
+ * This function parses the DIGEST_LIST_ENTRY field.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+static int parse_digest_list_entry(struct tlv_callback_data *tlv_data,
+				   enum digest_list_fields field,
+				   const u8 *field_data, u64 field_data_len)
+{
+	int ret;
+
+	kenter(",%u,%llu", field, field_data_len);
+
+	ret = tlv_parse(DIGEST_LIST_ENTRY_DATA, digest_list_entry_data_callback,
+			tlv_data, field_data, field_data_len,
+			digest_list_entry_types_str, DIGEST_LIST_ENTRY__LAST,
+			digest_list_entry_fields_str,
+			DIGEST_LIST_ENTRY_FIELD__LAST);
+
+	kleave(" = %d", ret);
+	return ret;
+}
+
+/**
+ * digest_list_file_callback - DIGEST_LIST_FILE callback
+ * @callback_data: Callback data
+ * @field: Field identifier
+ * @field_data: Field data
+ * @field_data_len: Length of @field_data
+ *
+ * This callback handles the fields of DIGEST_LIST_FILE data, and calls the
+ * appropriate parser.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+static int digest_list_file_callback(void *callback_data, u64 field,
+				     const u8 *field_data, u64 field_data_len)
+{
+	struct tlv_callback_data *tlv_data;
+	int ret;
+
+	tlv_data = (struct tlv_callback_data *)callback_data;
+
+	switch (field) {
+	case DIGEST_LIST_ALGO:
+		ret = parse_digest_list_algo(tlv_data, field, field_data,
+					     field_data_len);
+		break;
+	case DIGEST_LIST_ENTRY:
+		ret = parse_digest_list_entry(tlv_data, field, field_data,
+					      field_data_len);
+		break;
+	default:
+		pr_debug("Unhandled field %s\n",
+			 digest_list_fields_str[field]);
+		/* Just ignore non-relevant fields. */
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+/**
+ * digest_list_parse_tlv - Parse a tlv digest list
+ * @digest_cache: Digest cache
+ * @data: Data to parse
+ * @data_len: Length of @data
+ *
+ * This function parses a tlv digest list.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+int digest_list_parse_tlv(struct digest_cache *digest_cache, const u8 *data,
+			  size_t data_len)
+{
+	struct tlv_callback_data tlv_data = {
+		.digest_cache = digest_cache,
+		.algo = HASH_ALGO__LAST
+	};
+	int ret;
+
+	ret = tlv_parse_hdr(&data, &data_len, &tlv_data.parsed_data_type,
+			    &tlv_data.parsed_num_entries,
+			    &tlv_data.parsed_total_len,
+			    digest_list_types_str, DIGEST_LIST__LAST);
+	if (ret < 0)
+		return ret;
+
+	if (tlv_data.parsed_data_type != DIGEST_LIST_FILE)
+		return 0;
+
+	return tlv_parse_data(digest_list_file_callback, &tlv_data,
+			      tlv_data.parsed_num_entries, data, data_len,
+			      digest_list_fields_str, DIGEST_LIST_FIELD__LAST);
+}
diff --git a/security/digest_cache/populate.c b/security/digest_cache/populate.c
index 415e638f587b..13645ec4bb2b 100644
--- a/security/digest_cache/populate.c
+++ b/security/digest_cache/populate.c
@@ -12,6 +12,7 @@
 #include <linux/kernel_read_file.h>
 
 #include "internal.h"
+#include "parsers/parsers.h"
 
 /**
  * digest_cache_parse_digest_list - Parse a digest list
@@ -65,6 +66,9 @@ static int digest_cache_parse_digest_list(struct digest_cache *digest_cache,
 		 filename[0] ? "/" : "", filename, (int)(next_sep - format),
 		 format, data_len);
 
+	if (!strncmp(format, "tlv-", 4))
+		ret = digest_list_parse_tlv(digest_cache, data, data_len);
+
 	return ret;
 }
 
-- 
2.34.1


