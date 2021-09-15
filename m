Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A92940CA45
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhIOQfi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 12:35:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3831 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhIOQfc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 12:35:32 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H8m296JqLz67tWW;
        Thu, 16 Sep 2021 00:31:45 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 18:34:10 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 8/9] diglim: RPM parser
Date:   Wed, 15 Sep 2021 18:31:44 +0200
Message-ID: <20210915163145.1046505-9-roberto.sassu@huawei.com>
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

Introduce a parser of the RPM digest list, which converts the digest lists
to the compact format and uploads the converted digest lists to the kernel.

It takes as input the type of operation to perform, add or delete, and the
file or directory with the files to process.

Also the RPM parser is intentionally compiled as a static binary to avoid
to generate a compact digest list also for its dependencies.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 MAINTAINERS               |   1 +
 tools/diglim/Makefile     |   5 +-
 tools/diglim/rpm_parser.c | 483 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 488 insertions(+), 1 deletion(-)
 create mode 100644 tools/diglim/rpm_parser.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 148a2a7957b7..1efc1724376e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5527,6 +5527,7 @@ F:	tools/diglim/common.c
 F:	tools/diglim/common.h
 F:	tools/diglim/compact_gen.c
 F:	tools/diglim/rpm_gen.c
+F:	tools/diglim/rpm_parser.c
 F:	tools/diglim/upload_digest_lists.c
 F:	tools/testing/selftests/diglim/
 
diff --git a/tools/diglim/Makefile b/tools/diglim/Makefile
index a22125ad0281..7019c5b9fad9 100644
--- a/tools/diglim/Makefile
+++ b/tools/diglim/Makefile
@@ -3,7 +3,7 @@
 CC := $(CROSS_COMPILE)gcc
 CFLAGS += -O2 -Wall -g -I./ -I../../usr/include/ -ggdb
 
-PROGS := compact_gen rpm_gen upload_digest_lists
+PROGS := compact_gen rpm_gen upload_digest_lists rpm_parser
 PROGS_EXTENDED := common.o
 
 all: $(PROGS)
@@ -22,3 +22,6 @@ rpm_gen: rpm_gen.c $(PROGS_EXTENDED)
 
 upload_digest_lists: upload_digest_lists.c
 	$(CC) $(CFLAGS) -static $< -o $@ $(LDFLAGS)
+
+rpm_parser: rpm_parser.c $(PROGS_EXTENDED)
+	$(CC) $(CFLAGS) -static $< $(PROGS_EXTENDED) -o $@ $(LDFLAGS)
diff --git a/tools/diglim/rpm_parser.c b/tools/diglim/rpm_parser.c
new file mode 100644
index 000000000000..f8a4b63b2fa8
--- /dev/null
+++ b/tools/diglim/rpm_parser.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Parse RPM header and upload digest list to the kernel.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <ctype.h>
+#include <fts.h>
+#include <rpm/rpmtag.h>
+#include <rpm/rpmpgp.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/xattr.h>
+#include <sys/mount.h>
+#include <linux/diglim.h>
+#include <linux/hash_info.h>
+#include <bits/endianness.h>
+
+#include "common.h"
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+#include <linux/byteorder/big_endian.h>
+#else
+#include <linux/byteorder/little_endian.h>
+#endif
+
+#define SYSFS_MNTPOINT "/sys"
+#define SECURITYFS_MNTPOINT SYSFS_MNTPOINT "/kernel/security"
+#define DIGLIM_DIR SECURITYFS_MNTPOINT "/integrity/diglim"
+#define DIGEST_LIST_ADD DIGLIM_DIR "/digest_list_add"
+#define DIGEST_LIST_DEL DIGLIM_DIR "/digest_list_del"
+#define DIGEST_LIST_LABEL DIGLIM_DIR "/digest_list_label"
+#define DIGEST_LIST_DIR "/etc/digest_lists"
+
+#define MOUNT_FLAGS (MS_NOSUID | MS_NODEV | MS_NOEXEC | MS_RELATIME)
+
+enum hash_algo pgp_algo_mapping[PGPHASHALGO_SHA224 + 1] = {
+	[PGPHASHALGO_MD5] = HASH_ALGO_MD5,
+	[PGPHASHALGO_SHA1] = HASH_ALGO_SHA1,
+	[PGPHASHALGO_SHA224] = HASH_ALGO_SHA224,
+	[PGPHASHALGO_SHA256] = HASH_ALGO_SHA256,
+	[PGPHASHALGO_SHA384] = HASH_ALGO_SHA384,
+	[PGPHASHALGO_SHA512] = HASH_ALGO_SHA512,
+};
+
+struct rpm_hdr {
+	int32_t magic;
+	int32_t reserved;
+	int32_t tags;
+	int32_t datasize;
+} __attribute__((packed));
+
+struct rpm_entryinfo {
+	int32_t tag;
+	int32_t type;
+	int32_t offset;
+	int32_t count;
+} __attribute__((packed));
+
+/* from lib/hexdump.c (Linux kernel) */
+static int hex_to_bin(char ch)
+{
+	if ((ch >= '0') && (ch <= '9'))
+		return ch - '0';
+	ch = tolower(ch);
+	if ((ch >= 'a') && (ch <= 'f'))
+		return ch - 'a' + 10;
+	return -1;
+}
+
+int _hex2bin(unsigned char *dst, const char *src, size_t count)
+{
+	while (count--) {
+		int hi = hex_to_bin(*src++);
+		int lo = hex_to_bin(*src++);
+
+		if ((hi < 0) || (lo < 0))
+			return -1;
+
+		*dst++ = (hi << 4) | lo;
+	}
+	return 0;
+}
+
+static u8 *new_digest_list(enum hash_algo algo, enum compact_types type,
+			   u16 modifiers, u32 count)
+{
+	u8 *digest_list;
+	struct compact_list_hdr *hdr;
+
+	digest_list = calloc(1, sizeof(struct compact_list_hdr) +
+			     count * hash_digest_size[algo]);
+	if (!digest_list)
+		return NULL;
+
+	hdr = (struct compact_list_hdr *)digest_list;
+	hdr->version = 1;
+	hdr->type = __cpu_to_le16(type);
+	hdr->modifiers = __cpu_to_le16(modifiers);
+	hdr->algo = __cpu_to_le16(algo);
+	return digest_list;
+}
+
+static int upload_digest_list(int add_del_fd, int label_fd, u8 *digest_list,
+			      char *label)
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
+	ret = write(label_fd, label, strlen(label) + 1);
+	if (ret < 0 || ret != strlen(label) + 1)
+		return -EIO;
+
+	ret = write(add_del_fd, digest_list, sizeof(*hdr) + datalen);
+	if (ret < 0) {
+		if (errno == EEXIST || errno == ENOENT)
+			return 0;
+
+		return ret;
+	} else if (ret != sizeof(*hdr) + datalen) {
+		return -EIO;
+	}
+
+	return ret;
+}
+
+static int parse_rpm(int add_del_fd, int label_fd, char *path,
+		     struct stat *st, bool only_immutable)
+{
+	void *buf, *bufp, *bufendp, *datap;
+	struct rpm_hdr *hdr;
+	int32_t tags;
+	struct rpm_entryinfo *entry;
+	void *digests = NULL, *algo_buf = NULL, *modes = NULL, *sizes = NULL;
+	void *dirnames = NULL, *basenames = NULL, *dirindexes = NULL;
+	char **dirnames_ptr = NULL;
+	u8 *digest_list = NULL, *digest_list_immutable = NULL;
+	u32 digests_count = 0, dirnames_count = 0;
+	u16 algo = HASH_ALGO_MD5;
+	char *label = strrchr(path, '/') + 1;
+	int ret = 0, fd_rpm, i, dirname_len;
+
+	const unsigned char rpm_header_magic[8] = {
+		0x8e, 0xad, 0xe8, 0x01, 0x00, 0x00, 0x00, 0x00
+	};
+
+	if (st->st_size < sizeof(*hdr)) {
+		printf("Missing RPM header\n");
+		return -EINVAL;
+	}
+
+	fd_rpm = open(path, O_RDONLY);
+	if (fd_rpm < 0) {
+		printf("Cannot access %s (%d)\n", path, -errno);
+		return -EACCES;
+	}
+
+	buf = bufp = mmap(NULL, st->st_size, PROT_READ | PROT_WRITE,
+			  MAP_PRIVATE, fd_rpm, 0);
+
+	close(fd_rpm);
+
+	if (bufp == MAP_FAILED)
+		return -ENOMEM;
+
+	if (memcmp(bufp, rpm_header_magic, sizeof(rpm_header_magic))) {
+		printf("Invalid RPM header\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (struct rpm_hdr *)bufp;
+	tags = __be32_to_cpu(hdr->tags);
+	datap = bufp + sizeof(*hdr) + tags * sizeof(struct rpm_entryinfo);
+	bufendp = bufp + st->st_size;
+	bufp += sizeof(*hdr);
+
+	for (i = 0; i < tags && (bufp + sizeof(*entry)) <= bufendp;
+	     i++, bufp += sizeof(*entry)) {
+		entry = bufp;
+
+		switch (__be32_to_cpu(entry->tag)) {
+		case RPMTAG_FILEDIGESTS:
+			digests = datap + __be32_to_cpu(entry->offset);
+			digests_count = __be32_to_cpu(entry->count);
+			break;
+		case RPMTAG_FILEDIGESTALGO:
+			algo_buf = datap + __be32_to_cpu(entry->offset);
+			break;
+		case RPMTAG_DIRNAMES:
+			dirnames = datap + __be32_to_cpu(entry->offset);
+			dirnames_count = __be32_to_cpu(entry->count);
+			break;
+		case RPMTAG_BASENAMES:
+			basenames = datap + __be32_to_cpu(entry->offset);
+			break;
+		case RPMTAG_DIRINDEXES:
+			dirindexes = datap + __be32_to_cpu(entry->offset);
+			break;
+		case RPMTAG_FILEMODES:
+			modes = datap + __be32_to_cpu(entry->offset);
+			break;
+		case RPMTAG_FILESIZES:
+			sizes = datap + __be32_to_cpu(entry->offset);
+			break;
+
+		if (digests && algo_buf && modes && dirnames && basenames &&
+		    dirindexes)
+			break;
+		}
+	}
+
+	if (!digests || !modes || !sizes || !dirnames || !basenames ||
+	    !dirindexes) {
+		ret = 0;
+		goto out;
+	}
+
+	if (algo_buf && algo_buf + sizeof(u32) <= bufendp)
+		algo = pgp_algo_mapping[__be32_to_cpu(*(u32 *)algo_buf)];
+
+	digest_list = new_digest_list(algo, COMPACT_FILE, 0, digests_count);
+	if (!digest_list) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	digest_list_immutable = new_digest_list(algo, COMPACT_FILE,
+						(1 << COMPACT_MOD_IMMUTABLE),
+						digests_count);
+	if (!digest_list_immutable) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	dirnames_ptr = calloc(dirnames_count, sizeof(*dirnames_ptr));
+	if (!dirnames_ptr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < dirnames_count; i++) {
+		dirname_len = strlen(dirnames) + 1;
+
+		if (dirnames + dirname_len > bufendp) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		dirnames_ptr[i] = dirnames;
+		dirnames += dirname_len;
+	}
+
+	for (i = 0; i < digests_count; i++) {
+		int digest_str_len = strlen(digests);
+		int basename_str_len = strlen(basenames);
+		u8 *digest_list_ptr = digest_list;
+		struct compact_list_hdr *cur_hdr;
+		u32 dirindex;
+		u32 size;
+		u16 mode;
+
+		if (digests + digest_str_len * 2 + 1 > bufendp) {
+			printf("RPM header read at invalid offset\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (basenames + basename_str_len + 1 > bufendp) {
+			printf("RPM header read at invalid offset\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (dirindexes + sizeof(u32) > bufendp) {
+			printf("RPM header read at invalid offset\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (sizes + sizeof(u32) > bufendp) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (modes + sizeof(u16) > bufendp) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (!digest_str_len) {
+			digests += digest_str_len + 1;
+			basenames += basename_str_len + 1;
+			dirindexes += sizeof(u32);
+			sizes += sizeof(u32);
+			modes += sizeof(u16);
+			continue;
+		}
+
+		dirindex = __be32_to_cpu(*(u32 *)dirindexes);
+		size = __be32_to_cpu(*(u32 *)sizes);
+		mode = __be16_to_cpu(*(u16 *)modes);
+
+		if (((mode & 0111) || !(mode & 0222)) && size)
+			digest_list_ptr = digest_list_immutable;
+
+		if ((strstr(dirnames_ptr[dirindex], "/lib/modules") &&
+		    strncmp(basenames, "modules.", 8)) ||
+		    strstr(dirnames_ptr[dirindex], "/lib/firmware") ||
+		    strstr(dirnames_ptr[dirindex], "/usr/libexec/sudo"))
+			digest_list_ptr = digest_list_immutable;
+
+		if (only_immutable && digest_list_ptr != digest_list_immutable)
+			continue;
+
+		cur_hdr = (struct compact_list_hdr *)digest_list_ptr;
+
+		ret = _hex2bin(digest_list_ptr + sizeof(*cur_hdr) +
+			       cur_hdr->count * hash_digest_size[algo],
+			       digests, digest_str_len / 2);
+		if (ret < 0)
+			goto out;
+
+		digests += digest_str_len + 1;
+		basenames += basename_str_len + 1;
+		dirindexes += sizeof(u32);
+		sizes += sizeof(u32);
+		modes += sizeof(u16);
+
+		cur_hdr->count++;
+		cur_hdr->datalen += hash_digest_size[algo];
+	}
+
+	ret = upload_digest_list(add_del_fd, label_fd, digest_list, label);
+	if (ret < 0) {
+		printf("Failed to upload digest list\n");
+		goto out;
+	}
+
+	ret = upload_digest_list(add_del_fd, label_fd, digest_list_immutable,
+				 label);
+	if (ret < 0)
+		printf("Failed to upload digest list\n");
+out:
+	munmap(buf, st->st_size);
+	free(digest_list);
+	free(digest_list_immutable);
+	free(dirnames_ptr);
+	return ret;
+}
+
+int parse_digest_list(char *name)
+{
+	char *type_start, *format_start, *format_end;
+
+	type_start = strchr(name, '-');
+	if (!type_start++)
+		return 0;
+
+	format_start = strchr(type_start, '-');
+	if (!format_start++)
+		return 0;
+
+	format_end = strchr(format_start, '-');
+	if (!format_end)
+		return 0;
+
+	if (format_end - format_start != 3 ||
+	    strncmp(format_start, "rpm", 3))
+		return 0;
+
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	FTS *fts = NULL;
+	FTSENT *ftsent;
+	int fts_flags = (FTS_PHYSICAL | FTS_COMFOLLOW | FTS_NOCHDIR | FTS_XDEV);
+	char *paths[2] = { NULL, NULL };
+	char *add_del_path = DIGEST_LIST_ADD;
+	char path[PATH_MAX], *path_ptr = path;
+	bool only_immutable = false;
+	struct stat st;
+	int ret, add_del_fd = -1, label_fd = -1;
+
+	if (argc < 3) {
+		printf("Usage: %s add|del <digest list path>\n",
+		       argv[0]);
+		return -EINVAL;
+	}
+
+	if (stat(argv[2], &st) == -1)
+		return -ENOENT;
+
+	strncpy(path, argv[2], sizeof(path) - 1);
+
+	if (!S_ISDIR(st.st_mode)) {
+		path_ptr = strrchr(path, '/');
+		if (!path_ptr)
+			path_ptr = path;
+		else
+			path_ptr++;
+	} else {
+		path_ptr = path + strlen(path);
+	}
+
+	strncpy(path_ptr, "/.immutable", sizeof(path) - (path_ptr - path));
+	if (!stat(path, &st))
+		only_immutable = true;
+
+	paths[0] = argv[2];
+
+	if (!strcmp(argv[1], "del"))
+		add_del_path = DIGEST_LIST_DEL;
+
+	add_del_fd = open(add_del_path, O_WRONLY);
+	if (add_del_fd < 0) {
+		printf("Unable to open %s\n", add_del_path);
+		return -EACCES;
+	}
+
+	label_fd = open(DIGEST_LIST_LABEL, O_WRONLY);
+	if (label_fd < 0) {
+		printf("Unable to open %s\n", DIGEST_LIST_LABEL);
+		ret = -EACCES;
+		goto out;
+	}
+
+	fts = fts_open(paths, fts_flags, NULL);
+	if (!fts) {
+		printf("Unable to open %s\n", argv[2]);
+		ret = -EACCES;
+		goto out;
+	}
+
+	while ((ftsent = fts_read(fts)) != NULL) {
+		switch (ftsent->fts_info) {
+		case FTS_F:
+			if (!parse_digest_list(ftsent->fts_name))
+				break;
+
+			ret = parse_rpm(add_del_fd, label_fd,
+					ftsent->fts_path, ftsent->fts_statp,
+					only_immutable);
+			if (ret < 0)
+				printf("Cannot parse %s\n", ftsent->fts_path);
+			break;
+		default:
+			break;
+		}
+	}
+
+out:
+	if (add_del_fd >= 0)
+		close(add_del_fd);
+	if (label_fd >= 0)
+		close(label_fd);
+	if (fts)
+		fts_close(fts);
+
+	return 0;
+}
-- 
2.25.1

