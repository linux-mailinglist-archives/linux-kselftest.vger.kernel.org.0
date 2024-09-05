Return-Path: <linux-kselftest+bounces-17264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC48996DD76
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD9D1F2538C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721C817C9AE;
	Thu,  5 Sep 2024 15:08:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2845025;
	Thu,  5 Sep 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548914; cv=none; b=gWbTgssJ3wWSPISuO93W1vNfv7Khcc+isBBV2DD9FwvV+AJP2yz/v7aUrXeW6GHuioRfY9wp0vTXWflnX2DRMQ02zoyS7CSSySJteFtQmhxvTa3cLUQYPQKww1ThAEly+D4vjoSPGae6qTyCqTgxQKaNZvyVw9AoImFcWbibaMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548914; c=relaxed/simple;
	bh=nKIFIHoAQaNGNmBbAo1tneOiP5ff7B+juVWkf3TUudM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eW/HmbWO5EaTVpXgpGTFiG2P3wq7SOJokK/uy2dfPJqsDA+rOxk3Py+wcTkhRloI/kTwbckT3vgy6oxzMZLi3KV4dHtZD5bFjtO9Y1uY0ZHjwq7s83hcmphTtA6GR6WqiVgAOaoC/1NHtzNowBlN4j1I082pQ8nCsyFCd6l4hJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X02D00ttjz9v7JM;
	Thu,  5 Sep 2024 22:43:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 3A52114065B;
	Thu,  5 Sep 2024 23:08:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXZy_myNlmE0tUAA--.16274S10;
	Thu, 05 Sep 2024 16:08:22 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
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
Subject: [PATCH v5 08/14] digest_cache: Parse rpm digest lists
Date: Thu,  5 Sep 2024 17:05:37 +0200
Message-Id: <20240905150543.3766895-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
References: <20240905150543.3766895-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXZy_myNlmE0tUAA--.16274S10
X-Coremail-Antispam: 1UD129KBjvJXoW3GryrtF4ktw1DAFWrGFWfZrb_yoWfZw48pa
	sxGF17tr4rXF1xC3yxAF12yr1ft34qqF47XrW5CrnayFWYyr1UA3W8AryxZry5JrWDZFy7
	Gr4YgF1jvF4DJaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7I
	U0M5lUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGbZE-oKmwADsT

From: Roberto Sassu <roberto.sassu@huawei.com>

Implement a simple parser of RPM headers, that extracts the digest and the
algorithm of the packaged files from the RPMTAG_FILEDIGESTS and
RPMTAG_FILEDIGESTALGO section, and adds them to the digest cache.

The rpm digest list parser has been verified with Frama-C
(https://frama-c.com/).

The analysis has been done on this file:

https://github.com/robertosassu/rpm-formal/blob/main/validate_rpm.c

Here is the result of the analysis:

[eva:summary] ====== ANALYSIS SUMMARY ======
---------------------------------------------------------------------------
7 functions analyzed (out of 7): 100% coverage.
In these functions, 227 statements reached (out of 242): 93% coverage.
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
 security/integrity/digest_cache/Makefile      |   1 +
 .../integrity/digest_cache/parsers/parsers.h  |   2 +
 security/integrity/digest_cache/parsers/rpm.c | 220 ++++++++++++++++++
 security/integrity/digest_cache/populate.c    |   2 +
 4 files changed, 225 insertions(+)
 create mode 100644 security/integrity/digest_cache/parsers/rpm.c

diff --git a/security/integrity/digest_cache/Makefile b/security/integrity/digest_cache/Makefile
index 5cf75c961e26..681276a4c756 100644
--- a/security/integrity/digest_cache/Makefile
+++ b/security/integrity/digest_cache/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_INTEGRITY_DIGEST_CACHE) += digest_cache.o
 digest_cache-y := main.o secfs.o htable.o populate.o modsig.o
 
 digest_cache-y += parsers/tlv.o
+digest_cache-y += parsers/rpm.o
diff --git a/security/integrity/digest_cache/parsers/parsers.h b/security/integrity/digest_cache/parsers/parsers.h
index 1bbae426ab9f..3f00d29ed92a 100644
--- a/security/integrity/digest_cache/parsers/parsers.h
+++ b/security/integrity/digest_cache/parsers/parsers.h
@@ -11,3 +11,5 @@
 
 int digest_list_parse_tlv(struct digest_cache *digest_cache, const u8 *data,
 			  size_t data_len);
+int digest_list_parse_rpm(struct digest_cache *digest_cache, const u8 *data,
+			  size_t data_len);
diff --git a/security/integrity/digest_cache/parsers/rpm.c b/security/integrity/digest_cache/parsers/rpm.c
new file mode 100644
index 000000000000..6949d12707b8
--- /dev/null
+++ b/security/integrity/digest_cache/parsers/rpm.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Parse an rpm digest list (RPM package header).
+ */
+
+#define pr_fmt(fmt) "digest_cache RPM PARSER: "fmt
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
+};
+
+struct rpm_entryinfo {
+	s32 tag;
+	u32 type;
+	s32 offset;
+	u32 count;
+};
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
+	/* Possibly lower limit on tags loop. */
+	if (tags > max_tags)
+		return -EINVAL;
+
+	datasize = __be32_to_cpu(hdr->datasize);
+	if (datasize != data_len - tags * sizeof(*entry))
+		return -EINVAL;
+
+	pr_debug("Scanning %d RPM header sections\n", tags);
+	for (i = 0; i < tags; i++) {
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
+	/* Possibly lower limit on digests_count loop. */
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
+			return ret;
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
diff --git a/security/integrity/digest_cache/populate.c b/security/integrity/digest_cache/populate.c
index c118658f547a..1c68d957bf1d 100644
--- a/security/integrity/digest_cache/populate.c
+++ b/security/integrity/digest_cache/populate.c
@@ -64,6 +64,8 @@ static int digest_cache_parse_digest_list(struct digest_cache *digest_cache,
 
 	if (!strncmp(format, "tlv-", 4))
 		ret = digest_list_parse_tlv(digest_cache, data, data_len);
+	else if (!strncmp(format, "rpm-", 4))
+		ret = digest_list_parse_rpm(digest_cache, data, data_len);
 
 	return ret;
 }
-- 
2.34.1


