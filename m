Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66ABB40CA43
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 18:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhIOQfh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 12:35:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3830 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhIOQfb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 12:35:31 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H8m2Q2bSMz67hKh;
        Thu, 16 Sep 2021 00:31:58 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 18:34:09 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 7/9] diglim: Digest list uploader
Date:   Wed, 15 Sep 2021 18:31:43 +0200
Message-ID: <20210915163145.1046505-8-roberto.sassu@huawei.com>
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

Introduce a digest list uploader. Its syntax is:

upload_digest_lists <add|del> <digest list file/directory>

Its main function is to determine which digest list parsers must be
executed to parse the digest lists in the specified location. The uploader
then executes the parsers in sequence, which are expected to be in the same
directory as the uploader.

Given that this tool is not involved in the conversion of the digest lists,
it does not need to be identified as a parser by DIGLIM LSM.

It is intentionally compiled as a static binary. Otherwise, a build service
of a Linux distribution would need to be modified to generate a digest list
for each of the shared library the uploader depends on (e.g. glibc).
Instead, with a static binary, only a digest list for that binary has to be
generated.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 MAINTAINERS                        |   1 +
 tools/diglim/Makefile              |   5 +-
 tools/diglim/upload_digest_lists.c | 238 +++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 tools/diglim/upload_digest_lists.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 04b252ebd7e1..148a2a7957b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5527,6 +5527,7 @@ F:	tools/diglim/common.c
 F:	tools/diglim/common.h
 F:	tools/diglim/compact_gen.c
 F:	tools/diglim/rpm_gen.c
+F:	tools/diglim/upload_digest_lists.c
 F:	tools/testing/selftests/diglim/
 
 DIOLAN U2C-12 I2C DRIVER
diff --git a/tools/diglim/Makefile b/tools/diglim/Makefile
index 332bcd93af78..a22125ad0281 100644
--- a/tools/diglim/Makefile
+++ b/tools/diglim/Makefile
@@ -3,7 +3,7 @@
 CC := $(CROSS_COMPILE)gcc
 CFLAGS += -O2 -Wall -g -I./ -I../../usr/include/ -ggdb
 
-PROGS := compact_gen rpm_gen
+PROGS := compact_gen rpm_gen upload_digest_lists
 PROGS_EXTENDED := common.o
 
 all: $(PROGS)
@@ -19,3 +19,6 @@ compact_gen: compact_gen.c $(PROGS_EXTENDED)
 
 rpm_gen: rpm_gen.c $(PROGS_EXTENDED)
 	$(CC) $(CFLAGS) $< $(PROGS_EXTENDED) -o $@ $(LDFLAGS) -lrpm -lrpmio
+
+upload_digest_lists: upload_digest_lists.c
+	$(CC) $(CFLAGS) -static $< -o $@ $(LDFLAGS)
diff --git a/tools/diglim/upload_digest_lists.c b/tools/diglim/upload_digest_lists.c
new file mode 100644
index 000000000000..06086dd64aa3
--- /dev/null
+++ b/tools/diglim/upload_digest_lists.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Run parsers of digest list formats not recognizable by the kernel.
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <fts.h>
+#include <string.h>
+#include <stdbool.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/wait.h>
+#include <linux/limits.h>
+#include <sys/mount.h>
+#include <sys/vfs.h>
+#include <sys/stat.h>
+#include <linux/magic.h>
+
+#define MOUNT_FLAGS (MS_NOSUID | MS_NODEV | MS_NOEXEC | MS_RELATIME)
+#define PROCFS_MNTPOINT "/proc"
+#define SYSFS_MNTPOINT "/sys"
+#define SECURITYFS_MNTPOINT SYSFS_MNTPOINT "/kernel/security"
+#define DIGLIM_DIR SECURITYFS_MNTPOINT "/integrity/diglim"
+
+struct format_entry {
+	struct format_entry *next;
+	char *format;
+};
+
+struct format_entry *head;
+bool procfs_mounted;
+bool sysfs_mounted;
+bool securityfs_mounted;
+
+int add_format_parser(char *path)
+{
+	char *name;
+	char *type_start, *format_start, *format_end;
+	struct format_entry *cur, *new;
+	int ret = 0;
+
+	name = strrchr(path, '/');
+	if (!name)
+		return -EINVAL;
+
+	name++;
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
+	if (!strncmp(format_start, "compact", format_end - format_start))
+		return 0;
+
+	cur = head;
+
+	while (cur) {
+		if (!strncmp(format_start, cur->format,
+			     format_end - format_start))
+			goto out;
+
+		cur = cur->next;
+	}
+
+	new = malloc(sizeof(*new));
+	if (!new) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	new->format = strndup(format_start, format_end - format_start);
+	if (!new->format) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	new->next = head;
+	head = new;
+out:
+	if (ret < 0)
+		free(new);
+
+	return ret;
+}
+
+void free_list(void)
+{
+	struct format_entry *cur = head, *tmp;
+
+	while (cur) {
+		tmp = cur;
+		cur = tmp->next;
+		free(tmp->format);
+		free(tmp);
+	}
+}
+
+static int mount_filesystems(void)
+{
+	struct stat st;
+	struct statfs stf;
+	int ret;
+
+	if (stat("/proc/self", &st) == -1 ||
+	    statfs("/proc/self", &stf) == -1 || stf.f_type != 0x9fa0) {
+		ret = mount(PROCFS_MNTPOINT, PROCFS_MNTPOINT, "proc",
+			    MOUNT_FLAGS, NULL);
+		if (ret < 0) {
+			printf("Cannot mount procfs\n");
+			return ret;
+		}
+
+		procfs_mounted = true;
+	}
+
+	if (stat(SECURITYFS_MNTPOINT, &st) == -1 ||
+	    statfs(SYSFS_MNTPOINT, &stf) == -1 ||
+	    stf.f_type != 0x62656572) {
+		ret = mount(SYSFS_MNTPOINT, SYSFS_MNTPOINT, "sysfs",
+			    MOUNT_FLAGS, NULL);
+		if (ret < 0) {
+			printf("Cannot mount sysfs\n");
+			return ret;
+		}
+
+		sysfs_mounted = true;
+	}
+
+	if (stat(DIGLIM_DIR, &st) == -1 ||
+	    statfs(SECURITYFS_MNTPOINT, &stf) == -1 ||
+	    stf.f_type != 0x73636673) {
+		ret = mount(SECURITYFS_MNTPOINT, SECURITYFS_MNTPOINT,
+			    "securityfs", MOUNT_FLAGS, NULL);
+		if (ret < 0) {
+			printf("Cannot mount securityfs\n");
+			return ret;
+		}
+
+		securityfs_mounted = true;
+	}
+
+	return 0;
+}
+
+static void umount_filesystems(void)
+{
+	if (procfs_mounted)
+		umount(PROCFS_MNTPOINT);
+	if (securityfs_mounted)
+		umount(SECURITYFS_MNTPOINT);
+	if (sysfs_mounted)
+		umount(SYSFS_MNTPOINT);
+}
+
+int main(int argc, char *argv[])
+{
+	char *paths[2] = { NULL, NULL };
+	struct format_entry *cur;
+	char parser_path[PATH_MAX], *sep;
+	FTS *fts = NULL;
+	FTSENT *ftsent;
+	int fts_flags = (FTS_PHYSICAL | FTS_COMFOLLOW | FTS_NOCHDIR | FTS_XDEV);
+	int ret;
+
+	if (argc != 3) {
+		printf("Usage: %s add|del <digest list path>\n", argv[0]);
+		return -EINVAL;
+	}
+
+	paths[0] = argv[2];
+
+	fts = fts_open(paths, fts_flags, NULL);
+	if (!fts)
+		return -EACCES;
+
+	while ((ftsent = fts_read(fts)) != NULL) {
+		switch (ftsent->fts_info) {
+		case FTS_F:
+			ret = add_format_parser(ftsent->fts_path);
+			if (ret < 0)
+				printf("Cannot upload %s\n", ftsent->fts_path);
+
+			break;
+		default:
+			break;
+		}
+	}
+
+	fts_close(fts);
+	fts = NULL;
+
+	ret = mount_filesystems();
+	if (ret < 0)
+		goto out;
+
+	ret = readlink("/proc/self/exe", parser_path, sizeof(parser_path));
+	if (ret < 0)
+		goto out;
+
+	sep = strrchr(parser_path, '/');
+	if (!sep++) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	cur = head;
+
+	while (cur) {
+		if (fork() == 0) {
+			snprintf(sep, sizeof(parser_path) - (sep - parser_path),
+				 "%s_parser", cur->format);
+			return execlp(parser_path, parser_path, argv[1],
+				      argv[2], NULL);
+		}
+
+		wait(NULL);
+		cur = cur->next;
+	}
+
+out:
+	free_list();
+	umount_filesystems();
+	return ret;
+}
-- 
2.25.1

