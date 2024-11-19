Return-Path: <linux-kselftest+bounces-22257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2256D9D2407
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 11:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80DB285CB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 10:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096BC1C4A3F;
	Tue, 19 Nov 2024 10:52:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C411A1C5793;
	Tue, 19 Nov 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013546; cv=none; b=L6qM0zSoGDBpnaEONb6bQ2B/s1Ydzq7FZfWq7Ru6NlUYOVn/8/KlPujuv8soDrReF0PW3Zy+rDiHlYC1qLH/KSO3+Ig19n+CKaw7+2v0vcJGiOCWZEOx9yKMZiIY2JEiuqQ17G5VXYkF2iqRxmcYq2i+b7jfNyzU28MG5dSTVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013546; c=relaxed/simple;
	bh=e3ZFRZaAMQyCMmESBfpNUUcwhqDJx5Q1m5Q0JgxBdeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPjE0aN0GICeL5gwqkhIX1SQ6/8XLlCXcrdyx60+EnPmIJ94GG9Gdiz9QNaaObt3/Z0gfCXb+h42Cyz/d384YCi65DpxDSrCvJafpjoThhboUgYSd6kcH6xl6Fao+zz5LYRFqJmnIMYvNFY9bD3f5szndlvp9l2k/UHD2XY0OLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xt0xK6bxwz9v7JS;
	Tue, 19 Nov 2024 18:25:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 03F0F140119;
	Tue, 19 Nov 2024 18:52:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3nn1LbTxnNp7pAQ--.49675S10;
	Tue, 19 Nov 2024 11:52:19 +0100 (CET)
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
Subject: [PATCH v6 08/15] digest_cache: Parse tlv digest lists
Date: Tue, 19 Nov 2024 11:49:15 +0100
Message-ID: <20241119104922.2772571-9-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwA3nn1LbTxnNp7pAQ--.49675S10
X-Coremail-Antispam: 1UD129KBjvAXoW3uF13Zr15JFW3urWxKrW3Jrb_yoW8Wr4xCo
	ZIvr45Aw4rtrsIkF4kAF13Jr4rG3yYqFyrJw4fWr4DWa4rJF15tan2ka13Gas5Zw1rta9F
	yr18J3yaqw48trs7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOr7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxV
	Aaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	WY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI
	43ZEXa7IU0l4iUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGc79-IEigAAsd

From: Roberto Sassu <roberto.sassu@huawei.com>

Add digest_list_parse_tlv(), to parse TLV-formatted (Type Length Value)
digest lists. Their structure is:

[field: DIGEST_LIST_ALGO, length, value]
[field: DIGEST_LIST_NUM_ENTRIES, length, value]
[field: DIGEST_LIST_ENTRY#1, length, value (below)]
 |- [DIGEST_LIST_ENTRY_DIGEST#1, length, file digest]
 |- [DIGEST_LIST_ENTRY_PATH#1, length, file path]
[field: DIGEST_LIST_ENTRY#N, length, value (below)]
 |- [DIGEST_LIST_ENTRY_DIGEST#N, length, file digest]
 |- [DIGEST_LIST_ENTRY_PATH#N, length, file path]

DIGEST_LIST_ALGO and DIGEST_LIST_NUM_ENTRIES must have a fixed length
respectively of sizeof(u16) and sizeof(u32).

The data of the DIGEST_LIST_ENTRY field are itself in TLV format, for which
the DIGEST_LIST_ENTRY_DIGEST and DIGEST_LIST_ENTRY_PATH fields are defined.

Currently defined fields are sufficient for measurement/appraisal of file
data. More fields will be introduced later for file metadata.

Introduce digest_list_callback() to handle the digest list fields,
DIGEST_LIST_ALGO, DIGEST_LIST_NUM_ENTRIES and DIGEST_LIST_ENTRY, and the
respective field parsers parse_digest_list_algo(),
parse_digest_list_num_entries() and parse_digest_list_entry().

Introduce digest_list_entry_callback(), to handle the DIGEST_LIST_ENTRY
fields, DIGEST_LIST_ENTRY_DIGEST and DIGEST_LIST_ENTRY_PATH, and the
respective field parsers parse_digest_list_entry_digest() and
parse_digest_list_entry_path().

The TLV parser itself is implemented in lib/tlv_parser.c.

Both the TLV parser and the tlv digest list parser have been formally
verified with Frama-C (https://frama-c.com/).

The analysis has been done on this file:

https://github.com/robertosassu/rpm-formal/blob/main/validate_tlv.c

Here is the result of the analysis:

[eva:summary] ====== ANALYSIS SUMMARY ======
---------------------------------------------------------------------------
12 functions analyzed (out of 12): 100% coverage.
In these functions, 177 statements reached (out of 191): 92% coverage.
---------------------------------------------------------------------------
Some errors and warnings have been raised during the analysis:
  by the Eva analyzer:      0 errors    2 warnings
  by the Frama-C kernel:    0 errors    0 warnings
---------------------------------------------------------------------------
0 alarms generated by the analysis.
---------------------------------------------------------------------------
Evaluation of the logical properties reached by the analysis:
  Assertions        5 valid     0 unknown     0 invalid      5 total
  Preconditions    22 valid     0 unknown     0 invalid     22 total
100% of the logical properties reached have been proven.
---------------------------------------------------------------------------

The warnings are:

[eva] validate_tlv.c:256: Warning:
  this partitioning parameter cannot be evaluated safely on all states
[eva] validate_tlv.c:284: Warning:
  this partitioning parameter cannot be evaluated safely on all states

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/uapi/linux/tlv_digest_list.h          |  47 +++
 security/integrity/digest_cache/Kconfig       |   8 +
 security/integrity/digest_cache/Makefile      |   1 +
 security/integrity/digest_cache/parsers/tlv.c | 341 ++++++++++++++++++
 4 files changed, 397 insertions(+)
 create mode 100644 include/uapi/linux/tlv_digest_list.h
 create mode 100644 security/integrity/digest_cache/parsers/tlv.c

diff --git a/include/uapi/linux/tlv_digest_list.h b/include/uapi/linux/tlv_digest_list.h
new file mode 100644
index 000000000000..f2031cd70e64
--- /dev/null
+++ b/include/uapi/linux/tlv_digest_list.h
@@ -0,0 +1,47 @@
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
+#define FOR_EACH_DIGEST_LIST_FIELD(DIGEST_LIST_FIELD) \
+	DIGEST_LIST_FIELD(DIGEST_LIST_ALGO) \
+	DIGEST_LIST_FIELD(DIGEST_LIST_NUM_ENTRIES) \
+	DIGEST_LIST_FIELD(DIGEST_LIST_ENTRY) \
+	DIGEST_LIST_FIELD(DIGEST_LIST_FIELD__LAST)
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
+ * enum digest_list_fields - Digest list fields
+ *
+ * Enumerates the digest list fields.
+ */
+enum digest_list_fields {
+	FOR_EACH_DIGEST_LIST_FIELD(GENERATE_ENUM)
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
diff --git a/security/integrity/digest_cache/Kconfig b/security/integrity/digest_cache/Kconfig
index 65c07110911b..972bcf8bb765 100644
--- a/security/integrity/digest_cache/Kconfig
+++ b/security/integrity/digest_cache/Kconfig
@@ -33,3 +33,11 @@ config DIGEST_CACHE_HTABLE_DEPTH
 	  A smaller number will increase the amount of hash table slots, and
 	  make the search faster. A bigger number will decrease the number of
 	  hash table slots, but make the search slower.
+
+config DIGEST_CACHE_TLV_PARSER
+	tristate "TLV digest list parser"
+	depends on INTEGRITY_DIGEST_CACHE
+	select TLV_PARSER
+	help
+	  Add support for parsing TLV-formatted (Type Length Value)
+	  digest list.
diff --git a/security/integrity/digest_cache/Makefile b/security/integrity/digest_cache/Makefile
index d68cae690241..3b42b20d1bc0 100644
--- a/security/integrity/digest_cache/Makefile
+++ b/security/integrity/digest_cache/Makefile
@@ -3,6 +3,7 @@
 # Makefile for building the Integrity Digest Cache.
 
 obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
+obj-$(CONFIG_DIGEST_CACHE_TLV_PARSER) += parsers/tlv.o
 
 digest_cache-y := main.o secfs.o htable.o parsers.o
 
diff --git a/security/integrity/digest_cache/parsers/tlv.c b/security/integrity/digest_cache/parsers/tlv.c
new file mode 100644
index 000000000000..31e407f0a43b
--- /dev/null
+++ b/security/integrity/digest_cache/parsers/tlv.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Parse a tlv digest list.
+ */
+
+#define pr_fmt(fmt) "digest_cache TLV PARSER: "fmt
+#include <linux/module.h>
+#include <linux/tlv_parser.h>
+#include <linux/digest_cache.h>
+#include <uapi/linux/tlv_digest_list.h>
+
+#define kenter(FMT, ...) \
+	pr_debug("==> %s(" FMT ")\n", __func__, ##__VA_ARGS__)
+#define kleave(FMT, ...) \
+	pr_debug("<== %s()" FMT "\n", __func__, ##__VA_ARGS__)
+
+static const char *digest_list_fields_str[] = {
+	FOR_EACH_DIGEST_LIST_FIELD(GENERATE_STRING)
+};
+
+static const char *digest_list_entry_fields_str[] = {
+	FOR_EACH_DIGEST_LIST_ENTRY_FIELD(GENERATE_STRING)
+};
+
+struct tlv_callback_data {
+	struct digest_cache *digest_cache;
+	enum hash_algo algo;
+};
+
+/**
+ * parse_digest_list_entry_digest - Parse DIGEST_LIST_ENTRY_DIGEST field
+ * @tlv_data: Callback data
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
+					  const __u8 *field_data,
+					  __u32 field_data_len)
+{
+	int ret;
+
+	kenter(",%u,%u", field, field_data_len);
+
+	if (tlv_data->algo == HASH_ALGO__LAST) {
+		pr_debug("Digest algo not set\n");
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	if (field_data_len != hash_digest_size[tlv_data->algo]) {
+		pr_debug("Unexpected data length %u, expected %d\n",
+			 field_data_len, hash_digest_size[tlv_data->algo]);
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	ret = digest_cache_htable_add(tlv_data->digest_cache,
+				      (__u8 *)field_data, tlv_data->algo);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+/**
+ * parse_digest_list_entry_path - Parse DIGEST_LIST_ENTRY_PATH field
+ * @tlv_data: Callback data
+ * @field: Field identifier
+ * @field_data: Field data
+ * @field_data_len: Length of @field_data
+ *
+ * This function handles the DIGEST_LIST_ENTRY_PATH field (file path). It
+ * currently does not parse the data.
+ *
+ * Return: Zero.
+ */
+static int parse_digest_list_entry_path(struct tlv_callback_data *tlv_data,
+					enum digest_list_entry_fields field,
+					const __u8 *field_data,
+					__u32 field_data_len)
+{
+	kenter(",%u,%u", field, field_data_len);
+
+	kleave(" = 0");
+	return 0;
+}
+
+/**
+ * digest_list_entry_callback - DIGEST_LIST_ENTRY callback
+ * @callback_data: Callback data
+ * @field: Field identifier
+ * @field_data: Field data
+ * @field_data_len: Length of @field_data
+ *
+ * This callback handles the fields of DIGEST_LIST_ENTRY (nested) data, and
+ * calls the appropriate parser.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+static int digest_list_entry_callback(void *callback_data, __u16 field,
+				      const __u8 *field_data,
+				      __u32 field_data_len)
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
+ * @tlv_data: Callback data
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
+				  const __u8 *field_data, __u32 field_data_len)
+{
+	__u16 algo;
+	int ret = 0;
+
+	kenter(",%u,%u", field, field_data_len);
+
+	if (field_data_len != sizeof(__u16)) {
+		pr_debug("Unexpected data length %u, expected %zu\n",
+			 field_data_len, sizeof(__u16));
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	algo = __be16_to_cpu(*(__u16 *)field_data);
+
+	if (algo >= HASH_ALGO__LAST) {
+		pr_debug("Unexpected digest algo %u\n", algo);
+		ret = -EBADMSG;
+		goto out;
+	}
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
+ * parse_digest_list_num_entries - Parse DIGEST_LIST_NUM_ENTRIES field
+ * @tlv_data: Callback data
+ * @field: Field identifier
+ * @field_data: Field data
+ * @field_data_len: Length of @field_data
+ *
+ * This function parses the DIGEST_LIST_NUM_ENTRIES field (digest list entries).
+ * This field must appear after DIGEST_LIST_ALGO.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+static int parse_digest_list_num_entries(struct tlv_callback_data *tlv_data,
+					 enum digest_list_fields field,
+					 const __u8 *field_data,
+					 __u32 field_data_len)
+{
+	__u32 num_entries;
+	int ret;
+
+	kenter(",%u,%u", field, field_data_len);
+
+	if (field_data_len != sizeof(__u32)) {
+		pr_debug("Unexpected data length %u, expected %zu\n",
+			 field_data_len, sizeof(__u32));
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	if (tlv_data->algo == HASH_ALGO__LAST) {
+		pr_debug("Digest algo not yet initialized\n");
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	num_entries = __be32_to_cpu(*(__u32 *)field_data);
+
+	ret = digest_cache_htable_init(tlv_data->digest_cache, num_entries,
+				       tlv_data->algo);
+out:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+/**
+ * parse_digest_list_entry - Parse DIGEST_LIST_ENTRY field
+ * @tlv_data: Callback data
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
+				   const __u8 *field_data, __u32 field_data_len)
+{
+	int ret;
+
+	kenter(",%u,%u", field, field_data_len);
+
+	ret = tlv_parse(digest_list_entry_callback, tlv_data, field_data,
+			field_data_len, digest_list_entry_fields_str,
+			DIGEST_LIST_ENTRY_FIELD__LAST);
+
+	kleave(" = %d", ret);
+	return ret;
+}
+
+/**
+ * digest_list_callback - Digest list callback
+ * @callback_data: Callback data
+ * @field: Field identifier
+ * @field_data: Field data
+ * @field_data_len: Length of @field_data
+ *
+ * This callback handles the digest list fields, and calls the appropriate
+ * parser.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+static int digest_list_callback(void *callback_data, __u16 field,
+				const __u8 *field_data, __u32 field_data_len)
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
+	case DIGEST_LIST_NUM_ENTRIES:
+		ret = parse_digest_list_num_entries(tlv_data, field, field_data,
+						    field_data_len);
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
+static int digest_list_parse_tlv(struct digest_cache *digest_cache,
+				 const __u8 *data, size_t data_len)
+{
+	struct tlv_callback_data tlv_data = {
+		.digest_cache = digest_cache,
+		.algo = HASH_ALGO__LAST,
+	};
+
+	return tlv_parse(digest_list_callback, &tlv_data, data, data_len,
+			 digest_list_fields_str, DIGEST_LIST_FIELD__LAST);
+}
+
+static struct parser tlv_parser = {
+	.name = "tlv",
+	.owner = THIS_MODULE,
+	.func = digest_list_parse_tlv,
+};
+
+static int __init tlv_parser_init(void)
+{
+	return digest_cache_register_parser(&tlv_parser);
+}
+
+static void __exit tlv_parser_exit(void)
+{
+	digest_cache_unregister_parser(&tlv_parser);
+}
+
+module_init(tlv_parser_init);
+module_exit(tlv_parser_exit);
+
+MODULE_AUTHOR("Roberto Sassu");
+MODULE_DESCRIPTION("TLV digest list parser");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0.0");
-- 
2.47.0.118.gfd3785337b


