Return-Path: <linux-kselftest+bounces-7974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5C78A537D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29531C208DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416EF679E5;
	Mon, 15 Apr 2024 14:27:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D556757EA;
	Mon, 15 Apr 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191224; cv=none; b=n6LVE9+6ecRZ5fNjPtLzaRZcw5mBI/zNEJZhW90QfZmCqBgaJOM2NpqUOAX3HcakcgHXETF+sAB2y5R4DpWmojIvhGzTNDGxUMK0VMnCgKBLbOU0L/gjigVbtCFYwbiHQtrRuEb1e7P7FAA4ni5XexRRqDfNcgwonExMu5nKfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191224; c=relaxed/simple;
	bh=1w6+ARBuKc1e3AGxOhMbRPheBxo51IgHoyMaEowjJCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gyQp3HzI40XazwxIKsH3PV3/QQP1HD/4HqjKb2+ydc6O4dCQjSi96Db/ktbo2aokyx5htqFBzqzw0ej/Wi+fCwYD9AhetR38G9gmSDCQYxu81FieMvuq02NFPW/BDR4NY5MzId2CCQExiSHMpODqpbeBUjJfeknul+yvM6nycLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VJ88t2X8Mz9xGYB;
	Mon, 15 Apr 2024 22:06:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id D47AD1407FC;
	Mon, 15 Apr 2024 22:26:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnoSWrOB1myEJGBg--.9473S9;
	Mon, 15 Apr 2024 15:26:56 +0100 (CET)
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
Subject: [PATCH v4 07/14] digest_cache: Parse rpm digest lists
Date: Mon, 15 Apr 2024 16:24:29 +0200
Message-Id: <20240415142436.2545003-8-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBnoSWrOB1myEJGBg--.9473S9
X-Coremail-Antispam: 1UD129KBjvJXoW3GryrtF43AF18Xry5XFWkZwb_yoWfCF47pa
	sxGr17trs5XF1xAw4xAF17tr1xt34DtFsrXrW8urnayrZFyr1UA3W8AryIvry5JrWDZFy7
	Gr4YgF17Xr4DJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXV
	W8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZE
	Xa7IU04rW7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5x11gAAsF

From: Roberto Sassu <roberto.sassu@huawei.com>

Implement a simple parser of RPM headers, that extracts the digest and the
algorithm of the packaged files from the RPMTAG_FILEDIGESTS and
RPMTAG_FILEDIGESTALGO section, and add them to the digest cache.

The rpm digest list parser has been verified with Frama-C
(https://frama-c.com/).

The analysis has been done on this file:

https://github.com/robertosassu/rpm-formal/blob/main/validate_rpm.c

Here is the result of the analysis:

[eva:summary] ====== ANALYSIS SUMMARY ======
---------------------------------------------------------------------------
7 functions analyzed (out of 7): 100% coverage.
In these functions, 228 statements reached (out of 246): 92% coverage.
---------------------------------------------------------------------------
No errors or warnings raised during the analysis.
---------------------------------------------------------------------------
0 alarms generated by the analysis.
---------------------------------------------------------------------------
Evaluation of the logical properties reached by the analysis:
Assertions        6 valid     0 unknown     0 invalid      6 total
Preconditions    29 valid     0 unknown     0 invalid     29 total
100% of the logical properties reached have been proven.
---------------------------------------------------------------------------

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/digest_cache/Makefile          |   1 +
 security/digest_cache/parsers/parsers.h |   2 +
 security/digest_cache/parsers/rpm.c     | 223 ++++++++++++++++++++++++
 security/digest_cache/populate.c        |   2 +
 4 files changed, 228 insertions(+)
 create mode 100644 security/digest_cache/parsers/rpm.c

diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makefile
index a383b6ef2550..eca4076497e6 100644
--- a/security/digest_cache/Makefile
+++ b/security/digest_cache/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_SECURITY_DIGEST_CACHE) += digest_cache.o
 digest_cache-y := main.o secfs.o htable.o populate.o modsig.o
 
 digest_cache-y += parsers/tlv.o
+digest_cache-y += parsers/rpm.o
diff --git a/security/digest_cache/parsers/parsers.h b/security/digest_cache/parsers/parsers.h
index 1bbae426ab9f..3f00d29ed92a 100644
--- a/security/digest_cache/parsers/parsers.h
+++ b/security/digest_cache/parsers/parsers.h
@@ -11,3 +11,5 @@
 
 int digest_list_parse_tlv(struct digest_cache *digest_cache, const u8 *data,
 			  size_t data_len);
+int digest_list_parse_rpm(struct digest_cache *digest_cache, const u8 *data,
+			  size_t data_len);
diff --git a/security/digest_cache/parsers/rpm.c b/security/digest_cache/parsers/rpm.c
new file mode 100644
index 000000000000..6c7fe9c9121c
--- /dev/null
+++ b/security/digest_cache/parsers/rpm.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Parse an rpm digest list (RPM package header).
+ */
+
+#define pr_fmt(fmt) "RPM DIGEST LIST: "fmt
+#include <linux/module.h>
+
+#include "parsers.h"
+
+#define RPMTAG_FILEDIGESTS 1035
+#define RPMTAG_FILEDIGESTALGO 5011
+
+#define RPM_INT32_TYPE 4
+#define RPM_STRING_ARRAY_TYPE 8
+
+struct rpm_hdr {
+	u32 magic;
+	u32 reserved;
+	u32 tags;
+	u32 datasize;
+} __packed;
+
+struct rpm_entryinfo {
+	s32 tag;
+	u32 type;
+	s32 offset;
+	u32 count;
+} __packed;
+
+enum pgp_algos {
+	DIGEST_ALGO_MD5		=  1,
+	DIGEST_ALGO_SHA1	=  2,
+	DIGEST_ALGO_RMD160	=  3,
+	/* 4, 5, 6, and 7 are reserved. */
+	DIGEST_ALGO_SHA256	=  8,
+	DIGEST_ALGO_SHA384	=  9,
+	DIGEST_ALGO_SHA512	= 10,
+	DIGEST_ALGO_SHA224	= 11,
+};
+
+static const enum hash_algo pgp_algo_mapping[DIGEST_ALGO_SHA224 + 1] = {
+	[DIGEST_ALGO_MD5]	= HASH_ALGO_MD5,
+	[DIGEST_ALGO_SHA1]	= HASH_ALGO_SHA1,
+	[DIGEST_ALGO_RMD160]	= HASH_ALGO_RIPE_MD_160,
+	[4]			= HASH_ALGO__LAST,
+	[5]			= HASH_ALGO__LAST,
+	[6]			= HASH_ALGO__LAST,
+	[7]			= HASH_ALGO__LAST,
+	[DIGEST_ALGO_SHA256]	= HASH_ALGO_SHA256,
+	[DIGEST_ALGO_SHA384]	= HASH_ALGO_SHA384,
+	[DIGEST_ALGO_SHA512]	= HASH_ALGO_SHA512,
+	[DIGEST_ALGO_SHA224]	= HASH_ALGO_SHA224,
+};
+
+/**
+ * digest_list_parse_rpm - Parse an rpm digest list
+ * @digest_cache: Digest cache
+ * @data: Data to parse
+ * @data_len: Length of @data
+ *
+ * This function parses an rpm digest list.
+ *
+ * Return: Zero on success, a POSIX error code otherwise.
+ */
+int digest_list_parse_rpm(struct digest_cache *digest_cache, const u8 *data,
+			  size_t data_len)
+{
+	const unsigned char rpm_header_magic[8] = {
+		0x8e, 0xad, 0xe8, 0x01, 0x00, 0x00, 0x00, 0x00
+	};
+	const struct rpm_hdr *hdr;
+	const struct rpm_entryinfo *entry;
+	u32 tags, max_tags, datasize;
+	u32 digests_count, max_digests_count;
+	u32 digests_offset, algo_offset;
+	u32 digest_len, pkg_pgp_algo, i;
+	bool algo_offset_set = false, digests_offset_set = false;
+	enum hash_algo pkg_kernel_algo = HASH_ALGO_MD5;
+	u8 rpm_digest[SHA512_DIGEST_SIZE];
+	int ret;
+
+	if (data_len < sizeof(*hdr)) {
+		pr_debug("Not enough data for RPM header, current %ld, expected: %ld\n",
+			 data_len, sizeof(*hdr));
+		return -EINVAL;
+	}
+
+	if (memcmp(data, rpm_header_magic, sizeof(rpm_header_magic))) {
+		pr_debug("RPM header magic mismatch\n");
+		return -EINVAL;
+	}
+
+	hdr = (const struct rpm_hdr *)data;
+	data += sizeof(*hdr);
+	data_len -= sizeof(*hdr);
+
+	tags = __be32_to_cpu(hdr->tags);
+	max_tags = data_len / sizeof(*entry);
+
+	/* Finite termination on tags loop. */
+	if (tags > max_tags)
+		return -EINVAL;
+
+	datasize = __be32_to_cpu(hdr->datasize);
+	if (datasize != data_len - tags * sizeof(*entry))
+		return -EINVAL;
+
+	pr_debug("Scanning %d RPM header sections\n", tags);
+	for (i = 0; i < tags; i++) {
+		if (data_len < sizeof(*entry))
+			return -EINVAL;
+
+		entry = (const struct rpm_entryinfo *)data;
+		data += sizeof(*entry);
+		data_len -= sizeof(*entry);
+
+		switch (__be32_to_cpu(entry->tag)) {
+		case RPMTAG_FILEDIGESTS:
+			if (__be32_to_cpu(entry->type) != RPM_STRING_ARRAY_TYPE)
+				return -EINVAL;
+
+			digests_offset = __be32_to_cpu(entry->offset);
+			digests_count = __be32_to_cpu(entry->count);
+			digests_offset_set = true;
+
+			pr_debug("Found RPMTAG_FILEDIGESTS at offset %u, count: %u\n",
+				 digests_offset, digests_count);
+			break;
+		case RPMTAG_FILEDIGESTALGO:
+			if (__be32_to_cpu(entry->type) != RPM_INT32_TYPE)
+				return -EINVAL;
+
+			algo_offset = __be32_to_cpu(entry->offset);
+			algo_offset_set = true;
+
+			pr_debug("Found RPMTAG_FILEDIGESTALGO at offset %u\n",
+				 algo_offset);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!digests_offset_set)
+		return 0;
+
+	if (algo_offset_set) {
+		if (algo_offset >= data_len)
+			return -EINVAL;
+
+		if (data_len - algo_offset < sizeof(u32))
+			return -EINVAL;
+
+		pkg_pgp_algo = *(u32 *)&data[algo_offset];
+		pkg_pgp_algo = __be32_to_cpu(pkg_pgp_algo);
+		if (pkg_pgp_algo > DIGEST_ALGO_SHA224) {
+			pr_debug("Unknown PGP algo %d\n", pkg_pgp_algo);
+			return -EINVAL;
+		}
+
+		pkg_kernel_algo = pgp_algo_mapping[pkg_pgp_algo];
+		if (pkg_kernel_algo >= HASH_ALGO__LAST) {
+			pr_debug("Unknown mapping for PGP algo %d\n",
+				 pkg_pgp_algo);
+			return -EINVAL;
+		}
+
+		pr_debug("Found mapping for PGP algo %d: %s\n", pkg_pgp_algo,
+			 hash_algo_name[pkg_kernel_algo]);
+	}
+
+	digest_len = hash_digest_size[pkg_kernel_algo];
+
+	if (digests_offset > data_len)
+		return -EINVAL;
+
+	/* Worst case, every digest is a \0. */
+	max_digests_count = data_len - digests_offset;
+
+	/* Finite termination on digests_count loop. */
+	if (digests_count > max_digests_count)
+		return -EINVAL;
+
+	ret = digest_cache_htable_init(digest_cache, digests_count,
+				       pkg_kernel_algo);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < digests_count; i++) {
+		if (digests_offset == data_len)
+			return -EINVAL;
+
+		if (!data[digests_offset]) {
+			digests_offset++;
+			continue;
+		}
+
+		if (data_len - digests_offset < digest_len * 2 + 1)
+			return -EINVAL;
+
+		ret = hex2bin(rpm_digest, (const char *)&data[digests_offset],
+			      digest_len);
+		if (ret < 0) {
+			pr_debug("Invalid hex format for digest %s\n",
+				 &data[digests_offset]);
+			return -EINVAL;
+		}
+
+		ret = digest_cache_htable_add(digest_cache, rpm_digest,
+					      pkg_kernel_algo);
+		if (ret < 0)
+			return ret;
+
+		digests_offset += digest_len * 2 + 1;
+	}
+
+	return ret;
+}
diff --git a/security/digest_cache/populate.c b/security/digest_cache/populate.c
index 13645ec4bb2b..1770c8385017 100644
--- a/security/digest_cache/populate.c
+++ b/security/digest_cache/populate.c
@@ -68,6 +68,8 @@ static int digest_cache_parse_digest_list(struct digest_cache *digest_cache,
 
 	if (!strncmp(format, "tlv-", 4))
 		ret = digest_list_parse_tlv(digest_cache, data, data_len);
+	else if (!strncmp(format, "rpm-", 4))
+		ret = digest_list_parse_rpm(digest_cache, data, data_len);
 
 	return ret;
 }
-- 
2.34.1


