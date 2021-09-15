Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862A640CA3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhIOQfb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 12:35:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3829 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhIOQfa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 12:35:30 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H8m2P53Mfz67j6Y;
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
Subject: [RFC][PATCH 6/9] diglim: RPM digest list generator
Date:   Wed, 15 Sep 2021 18:31:42 +0200
Message-ID: <20210915163145.1046505-7-roberto.sassu@huawei.com>
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

Introduce the generator of RPM digest lists, which takes the RPM header
from a package or the RPM DB. Optionally, it appends the RPM header
signature with the same format of kernel modules and ID PKEY_ID_PGP.

This type of digest list can be loaded through the user space parser
rpm_parser, which is introduced in a subsequent patch.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 MAINTAINERS            |   1 +
 tools/diglim/Makefile  |   5 +-
 tools/diglim/rpm_gen.c | 334 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+), 1 deletion(-)
 create mode 100644 tools/diglim/rpm_gen.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b752790c06ea..04b252ebd7e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5526,6 +5526,7 @@ F:	tools/diglim/Makefile
 F:	tools/diglim/common.c
 F:	tools/diglim/common.h
 F:	tools/diglim/compact_gen.c
+F:	tools/diglim/rpm_gen.c
 F:	tools/testing/selftests/diglim/
 
 DIOLAN U2C-12 I2C DRIVER
diff --git a/tools/diglim/Makefile b/tools/diglim/Makefile
index 45efa554449d..332bcd93af78 100644
--- a/tools/diglim/Makefile
+++ b/tools/diglim/Makefile
@@ -3,7 +3,7 @@
 CC := $(CROSS_COMPILE)gcc
 CFLAGS += -O2 -Wall -g -I./ -I../../usr/include/ -ggdb
 
-PROGS := compact_gen
+PROGS := compact_gen rpm_gen
 PROGS_EXTENDED := common.o
 
 all: $(PROGS)
@@ -16,3 +16,6 @@ common.o: common.c
 
 compact_gen: compact_gen.c $(PROGS_EXTENDED)
 	$(CC) $(CFLAGS) $< $(PROGS_EXTENDED) -o $@ $(LDFLAGS) -lcrypto
+
+rpm_gen: rpm_gen.c $(PROGS_EXTENDED)
+	$(CC) $(CFLAGS) $< $(PROGS_EXTENDED) -o $@ $(LDFLAGS) -lrpm -lrpmio
diff --git a/tools/diglim/rpm_gen.c b/tools/diglim/rpm_gen.c
new file mode 100644
index 000000000000..fbee65ea0394
--- /dev/null
+++ b/tools/diglim/rpm_gen.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Generate RPM digest lists.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include <limits.h>
+#include <rpm/rpmlib.h>
+#include <rpm/header.h>
+#include <rpm/rpmts.h>
+#include <rpm/rpmdb.h>
+#include <rpm/rpmlog.h>
+#include <rpm/rpmtag.h>
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
+#include "../../usr/include/linux/diglim.h"
+
+const unsigned char rpm_header_magic[8] = {
+	0x8e, 0xad, 0xe8, 0x01, 0x00, 0x00, 0x00, 0x00
+};
+
+/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
+#define MODULE_SIG_STRING "~Module signature appended~\n"
+
+enum pkey_id_type {
+	PKEY_ID_PGP,		/* OpenPGP generated key ID */
+	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
+	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
+};
+
+/*
+ * Module signature information block.
+ *
+ * The constituents of the signature section are, in order:
+ *
+ *	- Signer's name
+ *	- Key identifier
+ *	- Signature data
+ *	- Information block
+ */
+struct module_signature {
+	u8	algo;		/* Public-key crypto algorithm [0] */
+	u8	hash;		/* Digest algorithm [0] */
+	u8	id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
+	u8	signer_len;	/* Length of signer's name [0] */
+	u8	key_id_len;	/* Length of key identifier [0] */
+	u8	__pad[3];
+	__be32	sig_len;	/* Length of signature data */
+};
+
+static int gen_filename_prefix(char *filename, int filename_len, int pos,
+			       const char *format, enum compact_types type)
+{
+	return snprintf(filename, filename_len, "%d-%s_list-%s-",
+			(pos >= 0) ? pos : 0, compact_types_str[type], format);
+}
+
+static void gen_filename(Header rpm, int pos, enum compact_types type,
+			 char *filename, int filename_len, char *output_format)
+{
+	rpmtd name = rpmtdNew(), version = rpmtdNew();
+	rpmtd release = rpmtdNew(), arch = rpmtdNew();
+	int prefix_len;
+
+	headerGet(rpm, RPMTAG_NAME, name, 0);
+	headerGet(rpm, RPMTAG_VERSION, version, 0);
+	headerGet(rpm, RPMTAG_RELEASE, release, 0);
+	headerGet(rpm, RPMTAG_ARCH, arch, 0);
+
+	prefix_len = gen_filename_prefix(filename, filename_len, pos,
+					 output_format, type);
+
+	snprintf(filename + prefix_len, filename_len - prefix_len,
+		 "%s-%s-%s.%s", rpmtdGetString(name), rpmtdGetString(version),
+		 rpmtdGetString(release), rpmtdGetString(arch));
+
+	rpmtdFree(name);
+	rpmtdFree(version);
+	rpmtdFree(release);
+	rpmtdFree(arch);
+}
+
+static int find_package(Header rpm, char *package)
+{
+	rpmtd name = rpmtdNew();
+	int found = 0;
+
+	headerGet(rpm, RPMTAG_NAME, name, 0);
+	if (!strncmp(rpmtdGetString(name), package, strlen(package)))
+		found = 1;
+
+	rpmtdFree(name);
+	return found;
+}
+
+static int write_rpm_header(Header rpm, int dirfd, char *filename)
+{
+	rpmtd immutable;
+	ssize_t ret;
+	int fd;
+
+	fd = openat(dirfd, filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd < 0)
+		return -EACCES;
+
+	ret = write(fd, rpm_header_magic, sizeof(rpm_header_magic));
+	if (ret != sizeof(rpm_header_magic)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	immutable = rpmtdNew();
+	headerGet(rpm, RPMTAG_HEADERIMMUTABLE, immutable, 0);
+	ret = write(fd, immutable->data, immutable->count);
+	if (ret != immutable->count) {
+		ret = -EIO;
+		goto out;
+	}
+
+	rpmtdFree(immutable);
+out:
+	close(fd);
+
+	if (ret < 0)
+		unlinkat(dirfd, filename, 0);
+
+	return ret;
+}
+
+static int write_rpm_header_signature(Header rpm, int dirfd, char *filename)
+{
+	struct module_signature modsig = { 0 };
+	rpmtd signature = rpmtdNew();
+	int ret, fd;
+
+	headerGet(rpm, RPMTAG_RSAHEADER, signature, 0);
+	fd = openat(dirfd, filename, O_WRONLY | O_APPEND);
+	if (fd < 0) {
+		ret = -errno;
+		goto out;
+	}
+
+	modsig.id_type = PKEY_ID_PGP;
+	modsig.sig_len = signature->count;
+	modsig.sig_len = __cpu_to_be32(modsig.sig_len);
+
+	ret = write(fd, signature->data, signature->count);
+	if (ret != signature->count) {
+		ret = -EIO;
+		goto out_fd;
+	}
+
+	ret = write(fd, &modsig, sizeof(modsig));
+	if (ret != sizeof(modsig)) {
+		ret = -EIO;
+		goto out_fd;
+	}
+
+	ret = write(fd, MODULE_SIG_STRING, sizeof(MODULE_SIG_STRING) - 1);
+	if (ret != sizeof(MODULE_SIG_STRING) - 1) {
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = 0;
+out_fd:
+	close(fd);
+out:
+	rpmtdFree(signature);
+
+	if (ret < 0)
+		unlinkat(dirfd, filename, 0);
+
+	return ret;
+}
+
+static void usage(char *progname)
+{
+	printf("Usage: %s <options>\n", progname);
+	printf("Options:\n");
+	printf("\t-d <output directory>: directory digest lists are written to\n"
+	       "\t-r <RPM path>: RPM package the digest list is generated from (all RPM packages in DB if not specified)\n"
+	       "\t-p <package>: selected RPM package in RPM DB\n"
+	       "\t-h: display help\n");
+}
+
+static void gen_rpm_digest_list(Header rpm, int dirfd, char *filename)
+{
+	int ret;
+
+	ret = write_rpm_header(rpm, dirfd, filename);
+	if (ret < 0) {
+		printf("Cannot generate %s digest list\n", filename);
+		return;
+	}
+
+	ret = write_rpm_header_signature(rpm, dirfd, filename);
+	if (ret < 0)
+		printf("Cannot add signature to %s digest list\n",
+		       filename);
+}
+
+int main(int argc, char *argv[])
+{
+	char filename[NAME_MAX + 1];
+	rpmts ts = NULL;
+	Header hdr;
+	FD_t fd;
+	rpmdbMatchIterator mi;
+	rpmVSFlags vsflags = 0;
+	char *input_package = NULL, *selected_package = NULL;
+	char *output_dir = NULL;
+	struct stat st;
+	int c;
+	int ret, dirfd;
+
+	while ((c = getopt(argc, argv, "d:r:p:h")) != -1) {
+		switch (c) {
+		case 'd':
+			output_dir = optarg;
+			break;
+		case 'r':
+			input_package = optarg;
+			break;
+		case 'p':
+			selected_package = optarg;
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
+	if (stat(output_dir, &st) == -1)
+		mkdir(output_dir, 0755);
+
+	dirfd = open(output_dir, O_RDONLY | O_DIRECTORY);
+	if (dirfd < 0) {
+		printf("Unable to open %s, ret: %d\n", output_dir, -errno);
+		ret = -errno;
+		goto out;
+	}
+
+	ts = rpmtsCreate();
+	if (!ts) {
+		rpmlog(RPMLOG_NOTICE, "rpmtsCreate() error..\n");
+		ret = -EACCES;
+		goto out;
+	}
+
+	ret = rpmReadConfigFiles(NULL, NULL);
+	if (ret != RPMRC_OK) {
+		rpmlog(RPMLOG_NOTICE, "Unable to read RPM configuration.\n");
+		ret = -EACCES;
+		goto out;
+	}
+
+	if (input_package) {
+		vsflags |= _RPMVSF_NODIGESTS;
+		vsflags |= _RPMVSF_NOSIGNATURES;
+		rpmtsSetVSFlags(ts, vsflags);
+
+		fd = Fopen(input_package, "r.ufdio");
+		if ((!fd) || Ferror(fd)) {
+			rpmlog(RPMLOG_NOTICE,
+			       "Failed to open package file %s, %s\n",
+			       input_package, Fstrerror(fd));
+			ret = -EACCES;
+			goto out_rpm;
+		}
+
+		ret = rpmReadPackageFile(ts, fd, "rpm", &hdr);
+		Fclose(fd);
+
+		if (ret != RPMRC_OK) {
+			rpmlog(RPMLOG_NOTICE,
+			       "Could not read package file %s\n",
+			       input_package);
+			goto out_rpm;
+		}
+
+		gen_filename(hdr, 0, COMPACT_FILE, filename, sizeof(filename),
+			     "rpm");
+
+		gen_rpm_digest_list(hdr, dirfd, filename);
+		headerFree(hdr);
+		goto out_rpm;
+	}
+
+	mi = rpmtsInitIterator(ts, RPMDBI_PACKAGES, NULL, 0);
+	while ((hdr = rpmdbNextIterator(mi)) != NULL) {
+		gen_filename(hdr, 0, COMPACT_FILE, filename, sizeof(filename),
+			     "rpm");
+
+		if (strstr(filename, "gpg-pubkey") != NULL)
+			continue;
+
+		if (selected_package && !find_package(hdr, selected_package))
+			continue;
+
+		gen_rpm_digest_list(hdr, dirfd, filename);
+	}
+
+	rpmdbFreeIterator(mi);
+out_rpm:
+	rpmFreeRpmrc();
+	rpmtsFree(ts);
+out:
+	close(dirfd);
+	return ret;
+}
-- 
2.25.1

