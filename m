Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA8640CA3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhIOQfa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 12:35:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3828 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhIOQf3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 12:35:29 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H8m2P0HXFz67hPW;
        Thu, 16 Sep 2021 00:31:57 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 18:34:08 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 5/9] diglim: Compact digest list generator
Date:   Wed, 15 Sep 2021 18:31:41 +0200
Message-ID: <20210915163145.1046505-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915163145.1046505-1-roberto.sassu@huawei.com>
References: <20210915163145.1046505-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a generator for the compact digest lists, which can be directly
uploaded to the kernel.

This tool can be used to generate a digest list from a file or the files in
the specified directory.

Files with execute permissions, without write permissions, those in
/lib/modules (not files starting with modules.) and in /lib/firmware are
marked as immutable (IMA with appraisal in enforcing mode will deny
writes).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 MAINTAINERS                |   4 +
 tools/diglim/Makefile      |  18 ++
 tools/diglim/common.c      |  79 +++++++++
 tools/diglim/common.h      |  59 +++++++
 tools/diglim/compact_gen.c | 349 +++++++++++++++++++++++++++++++++++++
 5 files changed, 509 insertions(+)
 create mode 100644 tools/diglim/Makefile
 create mode 100644 tools/diglim/common.c
 create mode 100644 tools/diglim/common.h
 create mode 100644 tools/diglim/compact_gen.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 94220e40b7e2..b752790c06ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5522,6 +5522,10 @@ F:	security/integrity/diglim/ima.c
 F:	security/integrity/diglim/loader.c
 F:	security/integrity/diglim/methods.c
 F:	security/integrity/diglim/parser.c
+F:	tools/diglim/Makefile
+F:	tools/diglim/common.c
+F:	tools/diglim/common.h
+F:	tools/diglim/compact_gen.c
 F:	tools/testing/selftests/diglim/
 
 DIOLAN U2C-12 I2C DRIVER
diff --git a/tools/diglim/Makefile b/tools/diglim/Makefile
new file mode 100644
index 000000000000..45efa554449d
--- /dev/null
+++ b/tools/diglim/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CC := $(CROSS_COMPILE)gcc
+CFLAGS += -O2 -Wall -g -I./ -I../../usr/include/ -ggdb
+
+PROGS := compact_gen
+PROGS_EXTENDED := common.o
+
+all: $(PROGS)
+
+clean:
+	rm -fr $(PROGS) $(PROGS_EXTENDED)
+
+common.o: common.c
+	$(CC) -c $(CFLAGS) $< -o $@
+
+compact_gen: compact_gen.c $(PROGS_EXTENDED)
+	$(CC) $(CFLAGS) $< $(PROGS_EXTENDED) -o $@ $(LDFLAGS) -lcrypto
diff --git a/tools/diglim/common.c b/tools/diglim/common.c
new file mode 100644
index 000000000000..dd5ff4b186b3
--- /dev/null
+++ b/tools/diglim/common.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2005,2006,2007,2008 IBM Corporation
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Common functions and data.
+ */
+
+#include <sys/random.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <malloc.h>
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <linux/types.h>
+#include <linux/hash_info.h>
+
+#include "common.h"
+
+char *compact_types_str[COMPACT__LAST] = {
+	[COMPACT_PARSER] = "parser",
+	[COMPACT_FILE] = "file",
+	[COMPACT_METADATA] = "metadata",
+	[COMPACT_DIGEST_LIST] = "digest_list",
+};
+
+const char *const hash_algo_name[HASH_ALGO__LAST] = {
+	[HASH_ALGO_MD4]		= "md4",
+	[HASH_ALGO_MD5]		= "md5",
+	[HASH_ALGO_SHA1]	= "sha1",
+	[HASH_ALGO_RIPE_MD_160]	= "rmd160",
+	[HASH_ALGO_SHA256]	= "sha256",
+	[HASH_ALGO_SHA384]	= "sha384",
+	[HASH_ALGO_SHA512]	= "sha512",
+	[HASH_ALGO_SHA224]	= "sha224",
+	[HASH_ALGO_RIPE_MD_128]	= "rmd128",
+	[HASH_ALGO_RIPE_MD_256]	= "rmd256",
+	[HASH_ALGO_RIPE_MD_320]	= "rmd320",
+	[HASH_ALGO_WP_256]	= "wp256",
+	[HASH_ALGO_WP_384]	= "wp384",
+	[HASH_ALGO_WP_512]	= "wp512",
+	[HASH_ALGO_TGR_128]	= "tgr128",
+	[HASH_ALGO_TGR_160]	= "tgr160",
+	[HASH_ALGO_TGR_192]	= "tgr192",
+	[HASH_ALGO_SM3_256]	= "sm3",
+	[HASH_ALGO_STREEBOG_256] = "streebog256",
+	[HASH_ALGO_STREEBOG_512] = "streebog512",
+};
+
+const int hash_digest_size[HASH_ALGO__LAST] = {
+	[HASH_ALGO_MD4]		= MD5_DIGEST_SIZE,
+	[HASH_ALGO_MD5]		= MD5_DIGEST_SIZE,
+	[HASH_ALGO_SHA1]	= SHA1_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_160]	= RMD160_DIGEST_SIZE,
+	[HASH_ALGO_SHA256]	= SHA256_DIGEST_SIZE,
+	[HASH_ALGO_SHA384]	= SHA384_DIGEST_SIZE,
+	[HASH_ALGO_SHA512]	= SHA512_DIGEST_SIZE,
+	[HASH_ALGO_SHA224]	= SHA224_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_128]	= RMD128_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_256]	= RMD256_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_320]	= RMD320_DIGEST_SIZE,
+	[HASH_ALGO_WP_256]	= WP256_DIGEST_SIZE,
+	[HASH_ALGO_WP_384]	= WP384_DIGEST_SIZE,
+	[HASH_ALGO_WP_512]	= WP512_DIGEST_SIZE,
+	[HASH_ALGO_TGR_128]	= TGR128_DIGEST_SIZE,
+	[HASH_ALGO_TGR_160]	= TGR160_DIGEST_SIZE,
+	[HASH_ALGO_TGR_192]	= TGR192_DIGEST_SIZE,
+	[HASH_ALGO_SM3_256]	= SM3256_DIGEST_SIZE,
+	[HASH_ALGO_STREEBOG_256] = STREEBOG256_DIGEST_SIZE,
+	[HASH_ALGO_STREEBOG_512] = STREEBOG512_DIGEST_SIZE,
+};
diff --git a/tools/diglim/common.h b/tools/diglim/common.h
new file mode 100644
index 000000000000..d33e5082c17c
--- /dev/null
+++ b/tools/diglim/common.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2005,2006,2007,2008 IBM Corporation
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header of common.c
+ */
+
+#include <sys/random.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <malloc.h>
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <linux/types.h>
+#include <linux/hash_info.h>
+
+#include "../../usr/include/linux/diglim.h"
+
+#define MD5_DIGEST_SIZE 16
+#define SHA1_DIGEST_SIZE 20
+#define RMD160_DIGEST_SIZE 20
+#define SHA256_DIGEST_SIZE 32
+#define SHA384_DIGEST_SIZE 48
+#define SHA512_DIGEST_SIZE 64
+#define SHA224_DIGEST_SIZE 28
+#define RMD128_DIGEST_SIZE 16
+#define RMD256_DIGEST_SIZE 32
+#define RMD320_DIGEST_SIZE 40
+#define WP256_DIGEST_SIZE 32
+#define WP384_DIGEST_SIZE 48
+#define WP512_DIGEST_SIZE 64
+#define TGR128_DIGEST_SIZE 16
+#define TGR160_DIGEST_SIZE 20
+#define TGR192_DIGEST_SIZE 24
+#define SM3256_DIGEST_SIZE 32
+#define STREEBOG256_DIGEST_SIZE 32
+#define STREEBOG512_DIGEST_SIZE 64
+
+#define COMPACT_LIST_SIZE_MAX (64 * 1024 * 1024 - 1)
+
+/* kernel types */
+typedef u_int8_t u8;
+typedef u_int16_t u16;
+typedef u_int32_t u32;
+typedef u_int64_t u64;
+
+extern char *compact_types_str[COMPACT__LAST];
+extern const char *const hash_algo_name[HASH_ALGO__LAST];
+extern const int hash_digest_size[HASH_ALGO__LAST];
diff --git a/tools/diglim/compact_gen.c b/tools/diglim/compact_gen.c
new file mode 100644
index 000000000000..0bfe8584de46
--- /dev/null
+++ b/tools/diglim/compact_gen.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Generate compact digest lists.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include <limits.h>
+#include <openssl/sha.h>
+#include <openssl/evp.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <fts.h>
+#include <string.h>
+#include <getopt.h>
+#include <linux/hash_info.h>
+#include <bits/endianness.h>
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+#include <linux/byteorder/big_endian.h>
+#else
+#include <linux/byteorder/little_endian.h>
+#endif
+
+#include "common.h"
+
+static int gen_filename_prefix(char *filename, int filename_len, int pos,
+			       const char *format, enum compact_types type)
+{
+	return snprintf(filename, filename_len, "%d-%s_list-%s-",
+			(pos >= 0) ? pos : 0, compact_types_str[type], format);
+}
+
+static int calc_digest(u8 *digest, void *data, u64 len, enum hash_algo algo)
+{
+	EVP_MD_CTX *mdctx;
+	const EVP_MD *md;
+	int ret = -EINVAL;
+
+	OpenSSL_add_all_algorithms();
+
+	md = EVP_get_digestbyname(hash_algo_name[algo]);
+	if (!md)
+		goto out;
+
+	mdctx = EVP_MD_CTX_create();
+	if (!mdctx)
+		goto out;
+
+	if (EVP_DigestInit_ex(mdctx, md, NULL) != 1)
+		goto out_mdctx;
+
+	if (EVP_DigestUpdate(mdctx, data, len) != 1)
+		goto out_mdctx;
+
+	if (EVP_DigestFinal_ex(mdctx, digest, NULL) != 1)
+		goto out_mdctx;
+
+	ret = 0;
+out_mdctx:
+	EVP_MD_CTX_destroy(mdctx);
+out:
+	EVP_cleanup();
+	return ret;
+}
+
+static int calc_file_digest(u8 *digest, char *path, enum hash_algo algo)
+{
+	void *data = MAP_FAILED;
+	struct stat st;
+	int fd, ret = 0;
+
+	if (stat(path, &st) == -1)
+		return -EACCES;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -EACCES;
+
+	if (st.st_size) {
+		data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (data == MAP_FAILED) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	ret = calc_digest(digest, data, st.st_size, algo);
+out:
+	if (data != MAP_FAILED)
+		munmap(data, st.st_size);
+
+	close(fd);
+	return ret;
+}
+
+static u8 *new_digest_list(enum hash_algo algo, enum compact_types type,
+			   u16 modifiers)
+{
+	u8 *digest_list;
+	struct compact_list_hdr *hdr;
+
+	digest_list = mmap(NULL, COMPACT_LIST_SIZE_MAX, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	if (digest_list == MAP_FAILED) {
+		printf("Cannot allocate buffer\n");
+		return NULL;
+	}
+
+	hdr = (struct compact_list_hdr *)digest_list;
+	memset(hdr, 0, sizeof(*hdr));
+
+	hdr->version = 1;
+	hdr->type = __cpu_to_le16(type);
+	hdr->modifiers = __cpu_to_le16(modifiers);
+	hdr->algo = __cpu_to_le16(algo);
+	return digest_list;
+}
+
+static int write_digest_list(int fd, u8 *digest_list)
+{
+	struct compact_list_hdr *hdr;
+	u32 datalen;
+	ssize_t ret;
+
+	hdr = (struct compact_list_hdr *)digest_list;
+	if (!hdr->count)
+		return 0;
+
+	datalen = hdr->datalen;
+	hdr->count = __cpu_to_le32(hdr->count);
+	hdr->datalen = __cpu_to_le32(hdr->datalen);
+
+	ret = write(fd, digest_list, sizeof(*hdr) + datalen);
+	if (ret != sizeof(*hdr) + datalen)
+		return -EIO;
+
+	return ret;
+}
+
+static int gen_compact_digest_list(char *input, enum hash_algo algo,
+				   u8 *digest_list, u8 *digest_list_immutable)
+{
+	FTS *fts = NULL;
+	FTSENT *ftsent;
+	int fts_flags = (FTS_PHYSICAL | FTS_COMFOLLOW | FTS_NOCHDIR | FTS_XDEV);
+	char *paths[2] = { input, NULL };
+	u8 *digest_list_ptr = digest_list;
+	struct compact_list_hdr *cur_hdr;
+	int ret;
+
+	if (!digest_list)
+		digest_list_ptr = digest_list_immutable;
+
+	fts = fts_open(paths, fts_flags, NULL);
+	if (!fts) {
+		printf("Unable to open %s\n", input);
+		return -EACCES;
+	}
+
+	while ((ftsent = fts_read(fts)) != NULL) {
+		switch (ftsent->fts_info) {
+		case FTS_F:
+			if (((ftsent->fts_statp->st_mode & 0111) ||
+			    !(ftsent->fts_statp->st_mode & 0222)) &&
+			    ftsent->fts_statp->st_size)
+				digest_list_ptr = digest_list_immutable;
+
+			if ((strstr(ftsent->fts_path, "/lib/modules") &&
+			    strncmp(ftsent->fts_name, "modules.", 8)) ||
+			    strstr(ftsent->fts_path, "/lib/firmware"))
+				digest_list_ptr = digest_list_immutable;
+
+			cur_hdr = (struct compact_list_hdr *)digest_list_ptr;
+
+			ret = calc_file_digest(digest_list_ptr +
+					sizeof(*cur_hdr) + cur_hdr->datalen,
+					ftsent->fts_path, algo);
+			if (ret < 0) {
+				printf("Cannot calculate digest of %s\n",
+				       ftsent->fts_path);
+				continue;
+			}
+
+			cur_hdr->count++;
+			cur_hdr->datalen += hash_digest_size[algo];
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static void usage(char *progname)
+{
+	printf("Usage: %s <options>\n", progname);
+	printf("Options:\n");
+	printf("\t-d <output directory>: directory digest lists are written to\n"
+	       "\t-i <path>: file/directory the digest list is generated from\n"
+	       "\t-t <type>: type of compact list to generate\n"
+	       "\t-a <algo>: digest algorithm\n"
+	       "\t-f: force the digest list to be immutable\n"
+	       "\t-h: display help\n");
+}
+
+int main(int argc, char *argv[])
+{
+	char path[PATH_MAX];
+	char filename[NAME_MAX + 1];
+	char *output_dir = NULL, *input = NULL;
+	enum compact_types type = COMPACT_FILE;
+	enum hash_algo algo = HASH_ALGO_SHA256;
+	u8 *digest_list = NULL, *digest_list_immutable = NULL;
+	char *input_ptr;
+	struct stat st;
+	int c;
+	int ret, fd = -1, force_immutable = 0;
+
+	while ((c = getopt(argc, argv, "d:i:t:a:fh")) != -1) {
+		switch (c) {
+		case 'd':
+			output_dir = optarg;
+			break;
+		case 'i':
+			input = optarg;
+			break;
+		case 't':
+			for (type = 0; type < COMPACT__LAST; type++)
+				if (!strcmp(compact_types_str[type], optarg))
+					break;
+			if (type == COMPACT__LAST) {
+				printf("Invalid type %s\n", optarg);
+				exit(1);
+			}
+			break;
+		case 'a':
+			for (algo = 0; algo < HASH_ALGO__LAST; algo++)
+				if (!strcmp(hash_algo_name[algo], optarg))
+					break;
+			if (algo == HASH_ALGO__LAST) {
+				printf("Invalid algo %s\n", optarg);
+				exit(1);
+			}
+			break;
+		case 'f':
+			force_immutable = 1;
+			break;
+		case 'h':
+			usage(argv[0]);
+			exit(0);
+		default:
+			printf("Invalid option %c\n", c);
+			exit(1);
+		}
+	}
+
+	if (!output_dir) {
+		printf("Output directory not specified\n");
+		exit(1);
+	}
+
+	if (!input) {
+		printf("Input file/directory not specified\n");
+		exit(1);
+	}
+
+	if (stat(input, &st) == -1) {
+		printf("Input file/directory not found or not accessible\n");
+		exit(1);
+	}
+
+	if (stat(output_dir, &st) == -1)
+		mkdir(output_dir, 0755);
+
+	gen_filename_prefix(filename, sizeof(filename), 0, "compact", type);
+
+	input_ptr = strrchr(input, '/');
+	if (input_ptr)
+		input_ptr++;
+	else
+		input_ptr = input;
+
+	snprintf(path, sizeof(path), "%s/%s%s", output_dir, filename,
+		 input_ptr);
+
+	if (!force_immutable) {
+		digest_list = new_digest_list(algo, type, 0);
+		if (!digest_list) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	digest_list_immutable = new_digest_list(algo, type,
+						(1 << COMPACT_MOD_IMMUTABLE));
+	if (!digest_list_immutable) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd < 0) {
+		printf("Unable to create %s\n", path);
+		ret = -errno;
+		goto out;
+	}
+
+	ret = gen_compact_digest_list(input, algo, digest_list,
+				      digest_list_immutable);
+	if (ret < 0) {
+		printf("Unable to generate the digest list from %s\n", input);
+		goto out;
+	}
+
+	if (!force_immutable) {
+		ret = write_digest_list(fd, digest_list);
+		if (ret < 0) {
+			printf("Unable to write the digest list to %s\n", path);
+			goto out;
+		}
+	}
+
+	ret = write_digest_list(fd, digest_list_immutable);
+	if (ret < 0)
+		printf("Unable to write the digest list to %s\n", path);
+out:
+	if (digest_list)
+		munmap(digest_list, COMPACT_LIST_SIZE_MAX);
+	if (digest_list_immutable)
+		munmap(digest_list_immutable, COMPACT_LIST_SIZE_MAX);
+
+	if (fd >= 0)
+		close(fd);
+
+	if (ret < 0)
+		unlink(path);
+
+	return ret;
+}
-- 
2.25.1

