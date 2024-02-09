Return-Path: <linux-kselftest+bounces-4433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D50884F69D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8853EB2262D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E1F67E72;
	Fri,  9 Feb 2024 14:10:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0EF50247;
	Fri,  9 Feb 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487815; cv=none; b=mtve1Q73etLLnaVBslKnR1+O3poXfLvIhPq5rVn1ZRgPLZyQbTydM8wHy+bu/wndlead6Iw02u1u18yQR+MAr+MBA4gCC0+V6p8KvWDIS/IsfXAbzeCDGedIWo9fwdCaGctmwS0j2BzvFEFonqomvKi91SH8TU0CQjOXlhDU32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487815; c=relaxed/simple;
	bh=zx0scWPGoME6FPtnmqQ/jPJDt4HSMwwgJw+AlZzasdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EBW/iu2XSSI/P7Up1TyAkwYwglDXUFrMWeh0yRrfX6WuKK7375/PGCE3z4fj3A+/Cfhr6iTOkhfn8RQFWc7K8VTIg5LodQKYMF+qaX1uebkQxoQsHlsStgIltpCUmEoiLvoLiMoVcvSA0IKWaxKmGRsPA/uEbI85oNuENmFj1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TWb2W0tggz9y4TW;
	Fri,  9 Feb 2024 21:54:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DB6F614059E;
	Fri,  9 Feb 2024 22:09:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHshoZMsZlvXMuAg--.65105S3;
	Fri, 09 Feb 2024 15:09:59 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
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
	petrtesarik@huaweicloud.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 01/13] lib: Add TLV parser
Date: Fri,  9 Feb 2024 15:09:05 +0100
Message-Id: <20240209140917.846878-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
References: <20240209140917.846878-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAHshoZMsZlvXMuAg--.65105S3
X-Coremail-Antispam: 1UD129KBjvAXoW3Cr18Kw1UGrW5tF1kCw15Jwb_yoW8Jw1DKo
	ZI9rW5ur4rXr1293W8Za1kZr1UXry0gr43Aw13GrW3ua4IkayUKr43tw43G3y3Aws8Kr45
	t3sxX3y3Xw4UKrn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOx7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M28IrcIa0x
	kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
	WIevJa73UjIFyTuYvjTRMfOzDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj5o4CgAAsU

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a parser of a generic TLV format:

+-----------------+------------------+-----------------+
| data type (u64) | num fields (u64) | total len (u64) | # header
+--------------+--+---------+--------+---------+-------+
| field1 (u64) | len1 (u64) | value1 (u8 len1) |
+--------------+------------+------------------+
|     ...      |    ...     |        ...       |         # data
+--------------+------------+------------------+
| fieldN (u64) | lenN (u64) | valueN (u8 lenN) |
+--------------+------------+------------------+

Each adopter can define its own data types and fields. The TLV parser does
not need to be aware of those, and calls a callback function with the
callback data, both supplied by the adopter, for every encountered field
during parsing. The adopter can decide in the callback function how each
defined field should be handled/parsed.

Normally, calling tlv_parse() is sufficient for most of the use cases. In
addition, tlv_parse_hdr() and tlv_parse_data() are also provided for more
advanced use cases.

Nesting TLVs is also possible, a callback function can call tlv_parse() to
parse the inner structure.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 MAINTAINERS                     |   8 ++
 include/linux/tlv_parser.h      |  28 +++++
 include/uapi/linux/tlv_parser.h |  59 +++++++++
 lib/Kconfig                     |   3 +
 lib/Makefile                    |   3 +
 lib/tlv_parser.c                | 214 ++++++++++++++++++++++++++++++++
 lib/tlv_parser.h                |  17 +++
 7 files changed, 332 insertions(+)
 create mode 100644 include/linux/tlv_parser.h
 create mode 100644 include/uapi/linux/tlv_parser.h
 create mode 100644 lib/tlv_parser.c
 create mode 100644 lib/tlv_parser.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ab4fbc0bf413..d3d13fb1004b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21946,6 +21946,14 @@ W:	http://sourceforge.net/projects/tlan/
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
index 000000000000..565743b3cb30
--- /dev/null
+++ b/include/linux/tlv_parser.h
@@ -0,0 +1,28 @@
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
+typedef int (*parse_callback)(void *, __u64, const __u8 *, __u64);
+
+int tlv_parse_hdr(const __u8 **data, size_t *data_len, __u64 *parsed_data_type,
+		  __u64 *parsed_num_entries, __u64 *parsed_total_len,
+		  const char **data_types, __u64 num_data_types);
+int tlv_parse_data(parse_callback callback, void *callback_data,
+		   __u64 num_entries, const __u8 *data, size_t data_len,
+		   const char **fields, __u64 num_fields);
+int tlv_parse(__u64 expected_data_type, parse_callback callback,
+	      void *callback_data, const __u8 *data, size_t data_len,
+	      const char **data_types, __u64 num_data_types,
+	      const char **fields, __u64 num_fields);
+
+#endif /* _LINUX_TLV_PARSER_H */
diff --git a/include/uapi/linux/tlv_parser.h b/include/uapi/linux/tlv_parser.h
new file mode 100644
index 000000000000..3968c96f2518
--- /dev/null
+++ b/include/uapi/linux/tlv_parser.h
@@ -0,0 +1,59 @@
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
+ * +-----------------+------------------+-----------------+
+ * | data type (u64) | num fields (u64) | total len (u64) | # header
+ * +--------------+--+---------+--------+---------+-------+
+ * | field1 (u64) | len1 (u64) | value1 (u8 len1) |
+ * +--------------+------------+------------------+
+ * |     ...      |    ...     |        ...       |         # data
+ * +--------------+------------+------------------+
+ * | fieldN (u64) | lenN (u64) | valueN (u8 lenN) |
+ * +--------------+------------+------------------+
+ */
+
+/**
+ * struct tlv_hdr - Header of TLV format
+ * @data_type: Type of data to parse
+ * @num_entries: Number of data entries provided
+ * @_reserved: Reserved for future use (must be equal to zero)
+ * @total_len: Total length of the data blob, excluding the header
+ *
+ * This structure represents the header of the TLV data format.
+ */
+struct tlv_hdr {
+	__u64 data_type;
+	__u64 num_entries;
+	__u64 _reserved;
+	__u64 total_len;
+} __attribute__((packed));
+
+/**
+ * struct tlv_data_entry - Data entry of TLV format
+ * @field: Data field identifier
+ * @length: Data length
+ * @data: Data
+ *
+ * This structure represents a TLV entry of the data part of TLV data format.
+ */
+struct tlv_data_entry {
+	__u64 field;
+	__u64 length;
+	__u8 data[];
+} __attribute__((packed));
+
+#endif /* _UAPI_LINUX_TLV_PARSER_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 3ea1c830efab..22c833b2038d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -775,3 +775,6 @@ config POLYNOMIAL
 
 config FIRMWARE_TABLE
 	bool
+
+config TLV_PARSER
+	bool
diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..23f0b770a639 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -444,3 +444,6 @@ $(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TEST_FORTIFY_LOGS)) FORCE
 ifeq ($(CONFIG_FORTIFY_SOURCE),y)
 $(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)
 endif
+
+obj-$(CONFIG_TLV_PARSER) += tlv_parser.o
+CFLAGS_tlv_parser.o += -I lib
diff --git a/lib/tlv_parser.c b/lib/tlv_parser.c
new file mode 100644
index 000000000000..9565542932eb
--- /dev/null
+++ b/lib/tlv_parser.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the TLV parser.
+ */
+
+#define pr_fmt(fmt) "TLV PARSER: "fmt
+#include <tlv_parser.h>
+
+/**
+ * tlv_parse_hdr - Parse TLV header
+ * @data: Data to parse (updated)
+ * @data_len: Length of @data (updated)
+ * @parsed_data_type: Parsed data type (updated)
+ * @parsed_num_entries: Parsed number of data entries (updated)
+ * @parsed_total_len: Parsed length of TLV data, excluding the header (updated)
+ * @data_types: Array of data type strings
+ * @num_data_types: Number of elements of @data_types
+ *
+ * Parse the header of the TLV data format, move the data pointer to the TLV
+ * data part, decrease the data length by the length of the header, and provide
+ * the data type, number of entries and the total data length extracted from the
+ * header.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+int tlv_parse_hdr(const __u8 **data, size_t *data_len, __u64 *parsed_data_type,
+		  __u64 *parsed_num_entries, __u64 *parsed_total_len,
+		  const char **data_types, __u64 num_data_types)
+{
+	struct tlv_hdr *hdr;
+
+	if (*data_len < sizeof(*hdr)) {
+		pr_debug("Data blob too short, %lu bytes, expected %lu\n",
+			 *data_len, sizeof(*hdr));
+		return -EBADMSG;
+	}
+
+	hdr = (struct tlv_hdr *)*data;
+
+	*data += sizeof(*hdr);
+	*data_len -= sizeof(*hdr);
+
+	*parsed_data_type = __be64_to_cpu(hdr->data_type);
+	if (*parsed_data_type >= num_data_types) {
+		pr_debug("Invalid data type %llu, max: %llu\n",
+			 *parsed_data_type, num_data_types - 1);
+		return -EBADMSG;
+	}
+
+	*parsed_num_entries = __be64_to_cpu(hdr->num_entries);
+
+	if (hdr->_reserved != 0) {
+		pr_debug("_reserved must be zero\n");
+		return -EBADMSG;
+	}
+
+	*parsed_total_len = __be64_to_cpu(hdr->total_len);
+	if (*parsed_total_len > *data_len) {
+		pr_debug("Invalid total length %llu, expected: %lu\n",
+			 *parsed_total_len, *data_len);
+		return -EBADMSG;
+	}
+
+	pr_debug("Header: type: %s, num entries: %llu, total len: %lld\n",
+		 data_types[*parsed_data_type], *parsed_num_entries,
+		 *parsed_total_len);
+
+	return 0;
+}
+
+/**
+ * tlv_parse_data - Parse TLV data
+ * @callback: Callback function to call to parse the entries
+ * @callback_data: Opaque data to supply to the callback function
+ * @num_entries: Number of data entries to parse
+ * @data: Data to parse
+ * @data_len: Length of @data
+ * @fields: Array of field strings
+ * @num_fields: Number of elements of @fields
+ *
+ * Parse the data part of the TLV data format and call the supplied callback
+ * function for each data entry, passing also the opaque data pointer.
+ *
+ * The callback function decides how to process data depending on the field.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+int tlv_parse_data(parse_callback callback, void *callback_data,
+		   __u64 num_entries, const __u8 *data, size_t data_len,
+		   const char **fields, __u64 num_fields)
+{
+	const __u8 *data_ptr = data;
+	struct tlv_data_entry *entry;
+	__u64 parsed_field, len, i, max_num_entries;
+	int ret;
+
+	max_num_entries = data_len / sizeof(*entry);
+
+	/* Finite termination on num_entries. */
+	if (num_entries > max_num_entries)
+		return -EBADMSG;
+
+	for (i = 0; i < num_entries; i++) {
+		if (data_len < sizeof(*entry))
+			return -EBADMSG;
+
+		entry = (struct tlv_data_entry *)data_ptr;
+		data_ptr += sizeof(*entry);
+		data_len -= sizeof(*entry);
+
+		parsed_field = __be64_to_cpu(entry->field);
+		if (parsed_field >= num_fields) {
+			pr_debug("Invalid field %llu, max: %llu\n",
+				 parsed_field, num_fields - 1);
+			return -EBADMSG;
+		}
+
+		len = __be64_to_cpu(entry->length);
+
+		if (data_len < len)
+			return -EBADMSG;
+
+		pr_debug("Data: field: %s, len: %llu\n", fields[parsed_field],
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
+		pr_debug("Excess data: %lu bytes\n", data_len);
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+
+/**
+ * tlv_parse - Parse data in TLV format
+ * @expected_data_type: Desired data type
+ * @callback: Callback function to call to parse the data entries
+ * @callback_data: Opaque data to supply to the callback function
+ * @data: Data to parse
+ * @data_len: Length of @data
+ * @data_types: Array of data type strings
+ * @num_data_types: Number of elements of @data_types
+ * @fields: Array of field strings
+ * @num_fields: Number of elements of @fields
+ *
+ * Parse data in TLV format and call tlv_parse_data() each time the header has
+ * the same data type as the expected one.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+int tlv_parse(__u64 expected_data_type, parse_callback callback,
+	      void *callback_data, const __u8 *data, size_t data_len,
+	      const char **data_types, __u64 num_data_types,
+	      const char **fields, __u64 num_fields)
+{
+	__u64 parsed_data_type, parsed_num_entries, parsed_total_len;
+	const __u8 *data_ptr = data;
+	int ret = 0;
+
+	pr_debug("Start parsing data blob, size: %lu, expected data type: %s\n",
+		 data_len, data_types[expected_data_type]);
+
+	while (data_len) {
+		ret = tlv_parse_hdr(&data_ptr, &data_len, &parsed_data_type,
+				    &parsed_num_entries, &parsed_total_len,
+				    data_types, num_data_types);
+		if (ret < 0)
+			goto out;
+
+		/* Skip data with a different data type than expected. */
+		if (parsed_data_type != expected_data_type) {
+			/*
+			 * tlv_parse_hdr() already checked that
+			 * parsed_total_len <= data_len.
+			 */
+			data_ptr += parsed_total_len;
+			data_len -= parsed_total_len;
+			continue;
+		}
+
+		pr_debug("Found data type %s at offset %ld\n",
+			 data_types[parsed_data_type], data_ptr - data);
+
+		ret = tlv_parse_data(callback, callback_data,
+				     parsed_num_entries, data_ptr,
+				     parsed_total_len, fields, num_fields);
+		if (ret < 0)
+			goto out;
+
+		data_ptr += parsed_total_len;
+		data_len -= parsed_total_len;
+	}
+out:
+	pr_debug("End of parsing data blob, ret: %d\n", ret);
+	return ret;
+}
diff --git a/lib/tlv_parser.h b/lib/tlv_parser.h
new file mode 100644
index 000000000000..8fa8127bd13e
--- /dev/null
+++ b/lib/tlv_parser.h
@@ -0,0 +1,17 @@
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
+#include <linux/tlv_parser.h>
+
+#endif /* _LIB_TLV_PARSER_H */
-- 
2.34.1


