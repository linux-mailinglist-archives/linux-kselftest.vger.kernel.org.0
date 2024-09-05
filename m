Return-Path: <linux-kselftest+bounces-17269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4DA96DD99
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447B01C258C7
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3AE197A9B;
	Thu,  5 Sep 2024 15:10:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600551BDDF;
	Thu,  5 Sep 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549046; cv=none; b=i8PxXIr/um6DJECgbEONDJYgH7odMcKbhBYHrSNsGVO6BC9AwVzLqhwTYcFMAmrv00HvF56r/ZTg8wXnHWNtATS8uDRj2B0csWKnFa5E1gQ71ou5opuBGzO+Aadd8JHVbY4HAut0jODye3eEgjR7OX2PDiQPNWV7MJ3etmLxpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549046; c=relaxed/simple;
	bh=UnxBR8ZHe5ALw1itHq2enkEHja+63PQbrt2dXUrUMO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uVbfh8N0pwQp73jAk7UNks33pRxwIssGppTWyyXy9sbUqzDyGyMp3M/tm6s51FH50nvDFgqZKklijt1c6wpHdePfz2A0Yl9l/K4uS8kIGFJKSuGH7HhPexRUybae6Pvmz7zSxxqODfcDERQyAICtj50u9J3F+UBIBMilKL9uBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X02GT2dJjz9v7JY;
	Thu,  5 Sep 2024 22:45:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 8F582140519;
	Thu,  5 Sep 2024 23:10:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHmTCzydlmEFVUAA--.29644S5;
	Thu, 05 Sep 2024 16:10:34 +0100 (CET)
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
Subject: [PATCH v5 13/14] selftests/digest_cache: Add selftests for the Integrity Digest Cache
Date: Thu,  5 Sep 2024 17:05:42 +0200
Message-Id: <20240905150543.3766895-14-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAHmTCzydlmEFVUAA--.29644S5
X-Coremail-Antispam: 1UD129KBjvAXoWfKFWxuw18WryUZw1xKw45KFg_yoW7tr1xAo
	Zagr4UJw18Wr17CFWkuF13Jay3Ww45t347Xr95XrWqqF1FyryUK3Wvka15t345WryFqr9x
	ZF4Sqw13Ar4xtr97n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO87kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	Wl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07jS
	iihUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MK6AAAsp

From: Roberto Sassu <roberto.sassu@huawei.com>

Add tests to verify the correctness of the Integrity Digest Cache, in
all_test.c.

Add the kernel module digest_cache_kern.ko, to let all_test call the API
of the Integrity Digest Cache through the newly introduced
digest_cache_test file in <securityfs>/integrity/digest_cache.

Test coverage information:

File 'security/integrity/digest_cache/reset.c'
Lines executed:100.00% of 53
File 'security/integrity/digest_cache/main.c'
Lines executed:90.50% of 200
File 'security/integrity/digest_cache/modsig.c'
Lines executed:42.86% of 21
File 'security/integrity/digest_cache/htable.c'
Lines executed:93.75% of 80
File 'security/integrity/digest_cache/populate.c'
Lines executed:92.73% of 55
File 'security/integrity/digest_cache/verif.c'
Lines executed:85.11% of 47
File 'security/integrity/digest_cache/dir.c'
Lines executed:92.72% of 151
File 'security/integrity/digest_cache/secfs.c'
Lines executed:56.00% of 25
File 'security/integrity/digest_cache/parsers/tlv.c'
Lines executed:80.00% of 85
File 'security/integrity/digest_cache/parsers/rpm.c'
Lines executed:88.31% of 77

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/digest_cache/.gitignore |   3 +
 tools/testing/selftests/digest_cache/Makefile |  24 +
 .../testing/selftests/digest_cache/all_test.c | 749 ++++++++++++++++++
 tools/testing/selftests/digest_cache/common.c |  78 ++
 tools/testing/selftests/digest_cache/common.h | 134 ++++
 .../selftests/digest_cache/common_user.c      |  47 ++
 .../selftests/digest_cache/common_user.h      |  17 +
 tools/testing/selftests/digest_cache/config   |   1 +
 .../selftests/digest_cache/generators.c       | 248 ++++++
 .../selftests/digest_cache/generators.h       |  19 +
 .../selftests/digest_cache/testmod/Makefile   |  16 +
 .../selftests/digest_cache/testmod/kern.c     | 501 ++++++++++++
 13 files changed, 1838 insertions(+)
 create mode 100644 tools/testing/selftests/digest_cache/.gitignore
 create mode 100644 tools/testing/selftests/digest_cache/Makefile
 create mode 100644 tools/testing/selftests/digest_cache/all_test.c
 create mode 100644 tools/testing/selftests/digest_cache/common.c
 create mode 100644 tools/testing/selftests/digest_cache/common.h
 create mode 100644 tools/testing/selftests/digest_cache/common_user.c
 create mode 100644 tools/testing/selftests/digest_cache/common_user.h
 create mode 100644 tools/testing/selftests/digest_cache/config
 create mode 100644 tools/testing/selftests/digest_cache/generators.c
 create mode 100644 tools/testing/selftests/digest_cache/generators.h
 create mode 100644 tools/testing/selftests/digest_cache/testmod/Makefile
 create mode 100644 tools/testing/selftests/digest_cache/testmod/kern.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index bc8fe9e8f7f2..cc0b314a235f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -15,6 +15,7 @@ TARGETS += cpu-hotplug
 TARGETS += damon
 TARGETS += devices/error_logs
 TARGETS += devices/probe
+TARGETS += digest_cache
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
 TARGETS += drivers/s390x/uvdevice
diff --git a/tools/testing/selftests/digest_cache/.gitignore b/tools/testing/selftests/digest_cache/.gitignore
new file mode 100644
index 000000000000..392096e18f4e
--- /dev/null
+++ b/tools/testing/selftests/digest_cache/.gitignore
@@ -0,0 +1,3 @@
+/*.mod
+/*_test
+/*.ko
diff --git a/tools/testing/selftests/digest_cache/Makefile b/tools/testing/selftests/digest_cache/Makefile
new file mode 100644
index 000000000000..1b819201f406
--- /dev/null
+++ b/tools/testing/selftests/digest_cache/Makefile
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS_EXTENDED = digest_cache_kern.ko
+TEST_GEN_PROGS := all_test
+
+$(OUTPUT)/%.ko: $(wildcard common.[ch]) testmod/Makefile testmod/kern.c
+	$(call msg,MOD,,$@)
+	$(Q)$(MAKE) -C testmod
+	$(Q)cp testmod/digest_cache_kern.ko $@
+
+LOCAL_HDRS += common.h common_user.h generators.h
+CFLAGS += -ggdb -Wall -Wextra $(KHDR_INCLUDES)
+
+OVERRIDE_TARGETS := 1
+override define CLEAN
+	$(call msg,CLEAN)
+	$(Q)$(MAKE) -C testmod clean
+	rm -Rf $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED)
+	rm -Rf $(OUTPUT)/common.o $(OUTPUT)/common_user.o $(OUTPUT)/generators.o
+	rm -Rf $(OUTPUT)/common.mod
+endef
+
+include ../lib.mk
+
+$(OUTPUT)/all_test: common.c common.h common_user.c common_user.h generators.c
diff --git a/tools/testing/selftests/digest_cache/all_test.c b/tools/testing/selftests/digest_cache/all_test.c
new file mode 100644
index 000000000000..fc84917e9250
--- /dev/null
+++ b/tools/testing/selftests/digest_cache/all_test.c
@@ -0,0 +1,749 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the tests of the Integrity Digest Cache.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <limits.h>
+#include <fts.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/xattr.h>
+#include <sys/syscall.h>
+#include <linux/module.h>
+
+#include "generators.h"
+
+#include "../kselftest_harness.h"
+#include "../../../../include/uapi/linux/xattr.h"
+
+#define BASE_DIR_TEMPLATE "/tmp/digest_cache_test_dirXXXXXX"
+#define DIGEST_LISTS_SUBDIR "digest_lists"
+#define NUM_DIGEST_LISTS_PREFETCH MAX_WORKS
+
+FIXTURE(shared_data) {
+	char base_dir[sizeof(BASE_DIR_TEMPLATE)];
+	char digest_lists_dir[sizeof(BASE_DIR_TEMPLATE) +
+			      sizeof(DIGEST_LISTS_SUBDIR)];
+	int base_dirfd, digest_lists_dirfd, kernfd, pathfd, cmd_len;
+};
+
+FIXTURE_SETUP(shared_data)
+{
+	char cmd[1024];
+	int fd, i, cmd_len;
+
+	/* Create the base directory. */
+	snprintf(self->base_dir, sizeof(self->base_dir), BASE_DIR_TEMPLATE);
+	ASSERT_NE(NULL, mkdtemp(self->base_dir));
+
+	/* Open base directory. */
+	self->base_dirfd = open(self->base_dir, O_RDONLY | O_DIRECTORY);
+	ASSERT_NE(-1, self->base_dirfd);
+
+	/* Create the digest_lists subdirectory. */
+	snprintf(self->digest_lists_dir, sizeof(self->digest_lists_dir),
+		 "%s/%s", self->base_dir, DIGEST_LISTS_SUBDIR);
+	ASSERT_EQ(0, mkdirat(self->base_dirfd, DIGEST_LISTS_SUBDIR, 0600));
+	self->digest_lists_dirfd = openat(self->base_dirfd, DIGEST_LISTS_SUBDIR,
+					  O_RDONLY | O_DIRECTORY);
+	ASSERT_NE(-1, self->digest_lists_dirfd);
+
+	fd = open("digest_cache_kern.ko", O_RDONLY);
+	ASSERT_LT(0, fd);
+
+	ASSERT_EQ(0, syscall(SYS_finit_module, fd, "", 0));
+	close(fd);
+
+	/* Open kernel test interface. */
+	self->kernfd = open(DIGEST_CACHE_TEST_INTERFACE, O_RDWR, 0600);
+	ASSERT_NE(-1, self->kernfd);
+
+	/* Open kernel digest list path interface. */
+	self->pathfd = open(DIGEST_CACHE_PATH_INTERFACE, O_RDWR, 0600);
+	ASSERT_NE(-1, self->pathfd);
+
+	/* Write the path of the digest lists directory. */
+	ASSERT_LT(0, write(self->pathfd, self->digest_lists_dir,
+			   strlen(self->digest_lists_dir)));
+
+	/* Ensure that no verifier is enabled at the beginning of a test. */
+	for (i = 0; i < VERIF__LAST; i++) {
+		cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s",
+				   commands_str[DIGEST_CACHE_DISABLE_VERIF],
+				   verifs_str[i]);
+		ASSERT_EQ(cmd_len, write(self->kernfd, cmd, cmd_len));
+	}
+}
+
+FIXTURE_TEARDOWN(shared_data)
+{
+	FTS *fts = NULL;
+	FTSENT *ftsent;
+	int fts_flags = (FTS_PHYSICAL | FTS_COMFOLLOW | FTS_NOCHDIR | FTS_XDEV);
+	char *paths[2] = { self->base_dir, NULL };
+	char cmd[1024];
+	int cmd_len;
+
+	/* Close digest_lists subdirectory. */
+	close(self->digest_lists_dirfd);
+
+	/* Close base directory. */
+	close(self->base_dirfd);
+
+	/* Delete files and directories. */
+	fts = fts_open(paths, fts_flags, NULL);
+	if (fts) {
+		while ((ftsent = fts_read(fts)) != NULL) {
+			switch (ftsent->fts_info) {
+			case FTS_DP:
+				rmdir(ftsent->fts_accpath);
+				break;
+			case FTS_F:
+			case FTS_SL:
+			case FTS_SLNONE:
+			case FTS_DEFAULT:
+				unlink(ftsent->fts_accpath);
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
+	/* Release digest cache reference, if the test was interrupted. */
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s",
+			   commands_str[DIGEST_CACHE_PUT]);
+	write(self->kernfd, cmd, cmd_len);
+
+	/* Close kernel test interface. */
+	close(self->kernfd);
+
+	/* Close kernel digest list path interface. */
+	close(self->pathfd);
+
+	syscall(SYS_delete_module, "digest_cache_kern", 0);
+}
+
+static int query_test(int kernfd, char *base_dir, char *filename,
+		      enum hash_algo algo, int start_number, int num_digests)
+{
+	u8 digest[MAX_DIGEST_SIZE] = { 0 };
+	char digest_str[MAX_DIGEST_SIZE * 2 + 1] = { 0 };
+	int digest_len = hash_digest_size[algo];
+	char cmd[1024];
+	int ret, i, cmd_len;
+
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s/%s",
+			   commands_str[DIGEST_CACHE_GET], base_dir, filename);
+	ret = write(kernfd, cmd, cmd_len);
+	if (ret != cmd_len)
+		return -errno;
+
+	ret = 0;
+
+	*(u32 *)digest = start_number;
+
+	for (i = 0; i < num_digests; i++) {
+		bin2hex(digest_str, digest, digest_len);
+
+		cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s/%s|%s:%s",
+				   commands_str[DIGEST_CACHE_LOOKUP], base_dir,
+				   filename, hash_algo_name[algo], digest_str);
+		ret = write(kernfd, cmd, cmd_len);
+		if (ret != cmd_len) {
+			ret = -errno;
+			goto out;
+		} else {
+			ret = 0;
+		}
+
+		(*(u32 *)digest)++;
+	}
+out:
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s",
+			   commands_str[DIGEST_CACHE_PUT]);
+	write(kernfd, cmd, cmd_len);
+	return ret;
+}
+
+static enum pgp_algos get_pgp_algo(enum hash_algo algo)
+{
+	unsigned long i;
+
+	for (i = DIGEST_ALGO_MD5; i < ARRAY_SIZE(pgp_algo_mapping); i++)
+		if (pgp_algo_mapping[i] == algo)
+			return i;
+
+	return DIGEST_ALGO_SHA224 + 1;
+}
+
+static void test_parser(struct _test_data_shared_data *self,
+			struct __test_metadata *_metadata,
+			char *digest_list_filename, char *filename,
+			enum hash_algo algo, int start_number, int num_digests,
+			unsigned int failure)
+{
+	int expected_ret = (failure) ? -ENOENT : 0;
+
+	if (!strncmp(digest_list_filename, "tlv-", 4)) {
+		ASSERT_EQ(0, gen_tlv_list(self->digest_lists_dirfd,
+					  digest_list_filename, algo,
+					  start_number, num_digests,
+					  (enum tlv_failures)failure));
+	} else if (!strncmp(digest_list_filename, "rpm-", 4)) {
+		enum pgp_algos pgp_algo = get_pgp_algo(algo);
+
+		if (pgp_algo == DIGEST_ALGO_SHA224 + 1)
+			return;
+
+		ASSERT_EQ(0, gen_rpm_list(self->digest_lists_dirfd,
+					  digest_list_filename, algo, pgp_algo,
+					  start_number, num_digests,
+					  (enum rpm_failures)failure));
+	}
+
+	ASSERT_EQ(0, create_file(self->base_dirfd, filename,
+				 digest_list_filename));
+	ASSERT_EQ(expected_ret, query_test(self->kernfd, self->base_dir,
+					   filename, algo, start_number,
+					   num_digests));
+
+	unlinkat(self->digest_lists_dirfd, digest_list_filename, 0);
+	unlinkat(self->base_dirfd, filename, 0);
+}
+
+/*
+ * Verify that the tlv digest list parser returns success on well-formatted
+ * digest lists, for each defined hash algorithm.
+ */
+TEST_F(shared_data, tlv_parser_ok)
+{
+	enum hash_algo algo;
+
+	/* Test every known algorithm. */
+	for (algo = 0; algo < HASH_ALGO__LAST; algo++)
+		test_parser(self, _metadata, "tlv-digest_list", "file", algo,
+			    0, 5, TLV_NO_FAILURE);
+}
+
+/*
+ * Verify that the tlv digest list parser returns failure on invalid digest
+ * lists.
+ */
+TEST_F(shared_data, tlv_parser_error)
+{
+	enum tlv_failures failure;
+
+	/* Test every failure. */
+	for (failure = 0; failure < TLV_FAILURE__LAST; failure++)
+		test_parser(self, _metadata, "tlv-digest_list", "file",
+			    HASH_ALGO_SHA224, 0, 1, failure);
+}
+
+/*
+ * Verify that the rpm digest list parser returns success on well-formatted
+ * digest lists, for each defined hash algorithm.
+ */
+TEST_F(shared_data, rpm_parser_ok)
+{
+	enum hash_algo algo;
+
+	/* Test every known algorithm. */
+	for (algo = 0; algo < HASH_ALGO__LAST; algo++)
+		test_parser(self, _metadata, "rpm-digest_list", "file", algo,
+			    0, 5, RPM_NO_FAILURE);
+}
+
+/*
+ * Verify that the rpm digest list parser returns failure on invalid digest
+ * lists.
+ */
+TEST_F(shared_data, rpm_parser_error)
+{
+	enum rpm_failures failure;
+
+	/* Test every failure. */
+	for (failure = 0; failure < RPM_FAILURE__LAST; failure++)
+		test_parser(self, _metadata, "rpm-digest_list", "file",
+			    HASH_ALGO_SHA224, 0, 1, failure);
+}
+
+static void test_default_path(struct _test_data_shared_data *self,
+			      struct __test_metadata *_metadata, bool file)
+{
+	char path[PATH_MAX];
+	size_t path_len;
+
+	if (file) {
+		path_len = snprintf(path, sizeof(path),
+				    "%s/%s/tlv-digest_list", self->base_dir,
+				    DIGEST_LISTS_SUBDIR);
+		ASSERT_LT(0, write(self->pathfd, path, path_len));
+	}
+
+	ASSERT_EQ(0, gen_tlv_list(self->digest_lists_dirfd, "tlv-digest_list",
+				  HASH_ALGO_SHA1, 0, 1, TLV_NO_FAILURE));
+
+	ASSERT_EQ(0, create_file(self->base_dirfd, "file", NULL));
+
+	ASSERT_EQ(0, query_test(self->kernfd, self->base_dir, "file",
+				HASH_ALGO_SHA1, 0, 1));
+}
+
+/*
+ * Verify that the digest cache created from the default path (regular file)
+ * can be retrieved and used for lookup.
+ */
+TEST_F(shared_data, default_path_file)
+{
+	test_default_path(self, _metadata, true);
+}
+
+/*
+ * Verify that the digest cache created from the default path (directory)
+ * can be retrieved and used for lookup.
+ */
+TEST_F(shared_data, default_path_dir)
+{
+	test_default_path(self, _metadata, false);
+}
+
+static void test_file_changes(struct _test_data_shared_data *self,
+			      struct __test_metadata *_metadata,
+			      enum file_changes change)
+{
+	char digest_list_filename[] = "tlv-digest_list";
+	char digest_list_filename_new[] = "tlv-digest_list6";
+	char digest_list_filename_xattr[] = "tlv-digest_list7";
+	char digest_list_path[sizeof(self->digest_lists_dir) +
+			      sizeof(digest_list_filename)];
+	int fd;
+
+	ASSERT_EQ(0, gen_tlv_list(self->digest_lists_dirfd,
+				  digest_list_filename, HASH_ALGO_SHA1, 0, 1,
+				  TLV_NO_FAILURE));
+
+	ASSERT_EQ(0, create_file(self->base_dirfd, "file",
+				 digest_list_filename));
+
+	ASSERT_EQ(0, query_test(self->kernfd, self->base_dir, "file",
+				HASH_ALGO_SHA1, 0, 1));
+
+	switch (change) {
+	case FILE_WRITE:
+		fd = openat(self->digest_lists_dirfd, digest_list_filename,
+			    O_WRONLY);
+		ASSERT_NE(-1, fd);
+
+		ASSERT_EQ(4, write(fd, "1234", 4));
+		close(fd);
+		break;
+	case FILE_TRUNCATE:
+		snprintf(digest_list_path, sizeof(digest_list_path),
+			 "%s/%s", self->digest_lists_dir, digest_list_filename);
+		ASSERT_EQ(0, truncate(digest_list_path, 4));
+		break;
+	case FILE_FTRUNCATE:
+		fd = openat(self->digest_lists_dirfd, digest_list_filename,
+			    O_WRONLY);
+		ASSERT_NE(-1, fd);
+		ASSERT_EQ(0, ftruncate(fd, 4));
+		close(fd);
+		break;
+	case FILE_UNLINK:
+		ASSERT_EQ(0, unlinkat(self->digest_lists_dirfd,
+				      digest_list_filename, 0));
+		break;
+	case FILE_RENAME:
+		ASSERT_EQ(0, renameat(self->digest_lists_dirfd,
+				      digest_list_filename,
+				      self->digest_lists_dirfd,
+				      digest_list_filename_new));
+		break;
+	case FILE_SETXATTR:
+		fd = openat(self->base_dirfd, "file", O_WRONLY);
+		ASSERT_NE(-1, fd);
+
+		ASSERT_EQ(0, fsetxattr(fd, XATTR_NAME_DIGEST_LIST,
+				       digest_list_filename_xattr,
+				       strlen(digest_list_filename_xattr) + 1,
+				       0));
+		close(fd);
+		break;
+	case FILE_REMOVEXATTR:
+		fd = openat(self->base_dirfd, "file", O_WRONLY);
+		ASSERT_NE(-1, fd);
+
+		ASSERT_EQ(0, fremovexattr(fd, XATTR_NAME_DIGEST_LIST));
+		close(fd);
+
+		/*
+		 * Removing security.digest_list does not cause a failure,
+		 * the digest can be still retrieved via directory lookup.
+		 */
+		ASSERT_EQ(0, query_test(self->kernfd, self->base_dir, "file",
+					HASH_ALGO_SHA1, 0, 1));
+
+		return;
+	default:
+		break;
+	}
+
+	ASSERT_NE(0, query_test(self->kernfd, self->base_dir, "file",
+				HASH_ALGO_SHA1, 0, 1));
+}
+
+/*
+ * Verify that operations on a digest list cause a reset of the digest cache,
+ * and that the digest is not found in the invalid/missing digest list.
+ */
+TEST_F(shared_data, file_reset)
+{
+	enum file_changes change;
+
+	/* Test for every file change. */
+	for (change = 0; change < FILE_CHANGE__LAST; change++)
+		test_file_changes(self, _metadata, change);
+}
+
+static void query_test_with_failures(struct _test_data_shared_data *self,
+				     struct __test_metadata *_metadata,
+				     int start_number, int num_digests,
+				     int *removed, int num_removed)
+{
+	char filename[NAME_MAX + 1];
+	int i, j, expected_ret;
+
+	for (i = start_number; i < start_number + num_digests; i++) {
+		expected_ret = 0;
+
+		for (j = 0; j < num_removed; j++) {
+			if (removed[j] == i) {
+				expected_ret = -ENOENT;
+				break;
+			}
+		}
+
+		snprintf(filename, sizeof(filename), "file%d", i);
+
+		ASSERT_EQ(expected_ret, query_test(self->kernfd, self->base_dir,
+						   filename, HASH_ALGO_SHA1, i,
+						   1));
+	}
+}
+
+/*
+ * Verify that changes in the digest list directory are monitored and that
+ * a digest cannot be found if the respective digest list file has been moved
+ * away from the directory, and that a digest can be found if the respective
+ * digest list has been moved/created in the directory.
+ */
+TEST_F(shared_data, dir_reset)
+{
+	char filename[NAME_MAX + 1];
+	int i, removed[10];
+
+	for (i = 0; i < 10; i++) {
+		snprintf(filename, sizeof(filename), "file%d", i);
+		ASSERT_EQ(0, create_file(self->base_dirfd, filename, NULL));
+		snprintf(filename, sizeof(filename), "tlv-digest_list%d", i);
+		ASSERT_EQ(0, gen_tlv_list(self->digest_lists_dirfd,
+					  filename, HASH_ALGO_SHA1, i, 1,
+					  TLV_NO_FAILURE));
+	}
+
+	query_test_with_failures(self, _metadata, 0, 10, removed, 0);
+
+	ASSERT_EQ(0, unlinkat(self->digest_lists_dirfd, "tlv-digest_list7", 0));
+
+	removed[0] = 7;
+
+	query_test_with_failures(self, _metadata, 0, 10, removed, 1);
+
+	ASSERT_EQ(0, renameat(self->digest_lists_dirfd, "tlv-digest_list6",
+			      self->base_dirfd, "tlv-digest_list6"));
+
+	removed[1] = 6;
+
+	query_test_with_failures(self, _metadata, 0, 10, removed, 2);
+
+	ASSERT_EQ(0, renameat(self->base_dirfd, "tlv-digest_list6",
+			      self->digest_lists_dirfd, "tlv-digest_list6"));
+
+	query_test_with_failures(self, _metadata, 0, 10, removed, 1);
+
+	ASSERT_EQ(0, create_file(self->base_dirfd, "file10", NULL));
+	ASSERT_EQ(0, gen_tlv_list(self->digest_lists_dirfd, "tlv-digest_list10",
+				  HASH_ALGO_SHA1, 10, 1, TLV_NO_FAILURE));
+
+	query_test_with_failures(self, _metadata, 0, 11, removed, 1);
+}
+
+static void _check_verif_data(struct _test_data_shared_data *self,
+			      struct __test_metadata *_metadata,
+			      char *digest_list_filename, int num,
+			      enum hash_algo algo, bool check_dir)
+{
+	char digest_list_filename_kernel[NAME_MAX + 1];
+	char cmd[1024], number[20];
+	u8 digest[MAX_DIGEST_SIZE] = { 0 };
+	char digest_str[MAX_DIGEST_SIZE * 2 + 1] = { 0 };
+	int len, cmd_len;
+
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s/file",
+			   commands_str[DIGEST_CACHE_GET], self->base_dir);
+	ASSERT_EQ(cmd_len, write(self->kernfd, cmd, cmd_len));
+
+	/*
+	 * If a directory digest cache was requested, we need to do a lookup,
+	 * to make the kernel module retrieve verification data from the digest
+	 * cache of the directory entry.
+	 */
+	if (check_dir) {
+		*(u32 *)digest = num;
+
+		bin2hex(digest_str, digest, hash_digest_size[algo]);
+
+		cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s/file|%s:%s",
+				   commands_str[DIGEST_CACHE_LOOKUP],
+				   self->base_dir, hash_algo_name[algo],
+				   digest_str);
+		ASSERT_EQ(cmd_len, write(self->kernfd, cmd, cmd_len));
+	}
+
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s",
+			   commands_str[DIGEST_CACHE_SET_VERIF],
+			   verifs_str[VERIF_FILENAMES]);
+	ASSERT_EQ(cmd_len, write(self->kernfd, cmd, cmd_len));
+
+	ASSERT_LT(0, read(self->kernfd, digest_list_filename_kernel,
+			  sizeof(digest_list_filename_kernel)));
+	ASSERT_EQ(0, strcmp(digest_list_filename, digest_list_filename_kernel));
+
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s",
+			   commands_str[DIGEST_CACHE_SET_VERIF],
+			   verifs_str[VERIF_NUMBER]);
+	ASSERT_EQ(cmd_len, write(self->kernfd, cmd, cmd_len));
+
+	len = read(self->kernfd, number, sizeof(number) - 1);
+	ASSERT_LT(0, len);
+	number[len] = '\0';
+	ASSERT_EQ(num, atoi(number));
+
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s",
+			   commands_str[DIGEST_CACHE_PUT]);
+	write(self->kernfd, cmd, cmd_len);
+}
+
+static void check_verif_data(struct _test_data_shared_data *self,
+			     struct __test_metadata *_metadata)
+{
+	char digest_list_filename[NAME_MAX + 1];
+	char cmd[1024];
+	int i, cmd_len;
+
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s",
+			   commands_str[DIGEST_CACHE_ENABLE_VERIF],
+			   verifs_str[VERIF_FILENAMES]);
+	ASSERT_EQ(cmd_len, write(self->kernfd, cmd, cmd_len));
+
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s",
+			   commands_str[DIGEST_CACHE_ENABLE_VERIF],
+			   verifs_str[VERIF_NUMBER]);
+	ASSERT_EQ(cmd_len, write(self->kernfd, cmd, cmd_len));
+
+	/*
+	 * Reverse order is intentional, so that directory entries are created
+	 * in the opposite order as when they are searched (when prefetching is
+	 * requested).
+	 */
+	for (i = 10; i >= 0; i--) {
+		snprintf(digest_list_filename, sizeof(digest_list_filename),
+			 "%d-tlv-digest_list%d", i, i);
+		ASSERT_EQ(0, gen_tlv_list(self->digest_lists_dirfd,
+					  digest_list_filename, HASH_ALGO_SHA1,
+					  i, 1, TLV_NO_FAILURE));
+
+		ASSERT_EQ(0, create_file(self->base_dirfd, "file",
+					 digest_list_filename));
+
+		_check_verif_data(self, _metadata, digest_list_filename, i,
+				  HASH_ALGO_SHA1, false);
+
+		ASSERT_EQ(0, unlinkat(self->base_dirfd, "file", 0));
+	}
+
+	for (i = 0; i < 11; i++) {
+		ASSERT_EQ(0, create_file(self->base_dirfd, "file", NULL));
+		snprintf(digest_list_filename, sizeof(digest_list_filename),
+			 "%d-tlv-digest_list%d", i, i);
+		_check_verif_data(self, _metadata, digest_list_filename, i,
+				  HASH_ALGO_SHA1, true);
+		ASSERT_EQ(0, unlinkat(self->base_dirfd, "file", 0));
+	}
+}
+
+/*
+ * Verify that the correct verification data can be retrieved from the digest
+ * caches (without digest list prefetching).
+ */
+TEST_F(shared_data, verif_data_no_prefetch)
+{
+	check_verif_data(self, _metadata);
+}
+
+/*
+ * Verify that the correct verification data can be retrieved from the digest
+ * caches (with digest list prefetching).
+ */
+TEST_F(shared_data, verif_data_prefetch)
+{
+	ASSERT_EQ(0, lsetxattr(self->base_dir, XATTR_NAME_DIG_PREFETCH,
+			       "1", 1, 0));
+
+	check_verif_data(self, _metadata);
+}
+
+static void check_prefetch_list(struct _test_data_shared_data *self,
+				struct __test_metadata *_metadata,
+				int start_number, int end_number)
+{
+	char digest_list_filename[NAME_MAX + 1], filename[NAME_MAX + 1];
+	char digest_lists[1024] = { 0 }, digest_lists_kernel[1024];
+	char cmd[1024];
+	int i, cmd_len;
+
+	snprintf(filename, sizeof(filename), "file%d", end_number);
+	snprintf(digest_list_filename, sizeof(digest_list_filename),
+		 "%d-tlv-digest_list%d", end_number, end_number);
+	ASSERT_EQ(0, create_file(self->base_dirfd, filename,
+				 digest_list_filename));
+
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s/%s",
+			   commands_str[DIGEST_CACHE_GET], self->base_dir,
+			   filename);
+	ASSERT_EQ(cmd_len, write(self->kernfd, cmd, cmd_len));
+
+	ASSERT_LT(0, read(self->kernfd, digest_lists_kernel,
+			  sizeof(digest_lists_kernel)));
+
+	for (i = start_number; i <= end_number; i++) {
+		if (digest_lists[0])
+			strcat(digest_lists, ",");
+
+		snprintf(digest_list_filename, sizeof(digest_list_filename),
+			 "%d-tlv-digest_list%d", i, i);
+		strcat(digest_lists, digest_list_filename);
+	}
+
+	ASSERT_EQ(0, strcmp(digest_lists, digest_lists_kernel));
+
+	ASSERT_EQ(0, unlinkat(self->base_dirfd, filename, 0));
+
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s",
+			   commands_str[DIGEST_CACHE_PUT]);
+	write(self->kernfd, cmd, cmd_len);
+}
+
+static void check_prefetch_list_async(struct _test_data_shared_data *self,
+				      struct __test_metadata *_metadata)
+{
+	char digest_list_filename[NAME_MAX + 1], filename[NAME_MAX + 1];
+	char digest_lists[1024] = { 0 }, digest_lists_kernel[1024];
+	char cmd[1024];
+	int i, cmd_len;
+
+	for (i = 0; i < NUM_DIGEST_LISTS_PREFETCH; i++) {
+		snprintf(filename, sizeof(filename), "file%d",
+			 NUM_DIGEST_LISTS_PREFETCH - 1 - i);
+		snprintf(digest_list_filename, sizeof(digest_list_filename),
+			 "%d-tlv-digest_list%d", i, i);
+		ASSERT_EQ(0, create_file(self->base_dirfd, filename,
+					 digest_list_filename));
+	}
+
+	/* Do batch of get/put to test the kernel for concurrent requests. */
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s/file|%d|%d",
+			   commands_str[DIGEST_CACHE_GET_PUT_ASYNC],
+			   self->base_dir, 0, NUM_DIGEST_LISTS_PREFETCH - 1);
+	ASSERT_EQ(cmd_len, write(self->kernfd, cmd, cmd_len));
+
+	ASSERT_LT(0, read(self->kernfd, digest_lists_kernel,
+			  sizeof(digest_lists_kernel)));
+
+	for (i = 0; i < NUM_DIGEST_LISTS_PREFETCH; i++) {
+		if (digest_lists[0])
+			strcat(digest_lists, ",");
+
+		snprintf(digest_list_filename, sizeof(digest_list_filename),
+			 "%d-tlv-digest_list%d", i, i);
+		strcat(digest_lists, digest_list_filename);
+	}
+
+	ASSERT_EQ(0, strcmp(digest_lists, digest_lists_kernel));
+}
+
+static void prepare_prefetch(struct _test_data_shared_data *self,
+			     struct __test_metadata *_metadata)
+{
+	char digest_list_filename[NAME_MAX + 1];
+	char cmd[1024];
+	int i, cmd_len;
+
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s",
+			   commands_str[DIGEST_CACHE_ENABLE_VERIF],
+			   verifs_str[VERIF_PREFETCH]);
+	ASSERT_EQ(cmd_len, write(self->kernfd, cmd, cmd_len));
+
+	cmd_len = snprintf(cmd, sizeof(cmd), "%s|%s",
+			   commands_str[DIGEST_CACHE_SET_VERIF],
+			   verifs_str[VERIF_PREFETCH]);
+	ASSERT_EQ(cmd_len, write(self->kernfd, cmd, cmd_len));
+
+	for (i = NUM_DIGEST_LISTS_PREFETCH - 1; i >= 0; i--) {
+		snprintf(digest_list_filename, sizeof(digest_list_filename),
+			 "%d-tlv-digest_list%d", i, i);
+		ASSERT_EQ(0, gen_tlv_list(self->digest_lists_dirfd,
+					  digest_list_filename, HASH_ALGO_SHA1,
+					  i, 1, TLV_NO_FAILURE));
+	}
+
+	ASSERT_EQ(0, fsetxattr(self->digest_lists_dirfd,
+			       XATTR_NAME_DIG_PREFETCH, "1", 1, 0));
+}
+
+/*
+ * Verify that digest lists are prefetched when requested, in the correct order
+ * (synchronous version).
+ */
+TEST_F(shared_data, prefetch_sync)
+{
+	int i;
+
+	prepare_prefetch(self, _metadata);
+
+	for (i = 2; i < NUM_DIGEST_LISTS_PREFETCH; i += 3)
+		check_prefetch_list(self, _metadata, i - 2, i);
+}
+
+/*
+ * Verify that digest lists are prefetched when requested, in the correct order
+ * (asynchronous version).
+ */
+TEST_F(shared_data, prefetch_async)
+{
+	prepare_prefetch(self, _metadata);
+
+	check_prefetch_list_async(self, _metadata);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/digest_cache/common.c b/tools/testing/selftests/digest_cache/common.c
new file mode 100644
index 000000000000..75c0ef50deb8
--- /dev/null
+++ b/tools/testing/selftests/digest_cache/common.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Add common code for testing the Integrity Digest Cache.
+ */
+
+#include "common.h"
+
+const char *commands_str[DIGEST_CACHE__LAST] = {
+	[DIGEST_CACHE_GET] = "get",
+	[DIGEST_CACHE_LOOKUP] = "lookup",
+	[DIGEST_CACHE_PUT] = "put",
+	[DIGEST_CACHE_ENABLE_VERIF] = "enable_verif",
+	[DIGEST_CACHE_DISABLE_VERIF] = "disable_verif",
+	[DIGEST_CACHE_SET_VERIF] = "set_verif",
+	[DIGEST_CACHE_GET_PUT_ASYNC] = "get_put_async",
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
+	[HASH_ALGO_SHA3_256]    = "sha3-256",
+	[HASH_ALGO_SHA3_384]    = "sha3-384",
+	[HASH_ALGO_SHA3_512]    = "sha3-512",
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
+	[HASH_ALGO_SHA3_256]    = SHA3_256_DIGEST_SIZE,
+	[HASH_ALGO_SHA3_384]    = SHA3_384_DIGEST_SIZE,
+	[HASH_ALGO_SHA3_512]    = SHA3_512_DIGEST_SIZE,
+};
+
+const char *verifs_str[] = {
+	[VERIF_FILENAMES] = "kprobe_filenames",
+	[VERIF_NUMBER] = "kprobe_number",
+	[VERIF_PREFETCH] = "kprobe_prefetch",
+};
diff --git a/tools/testing/selftests/digest_cache/common.h b/tools/testing/selftests/digest_cache/common.h
new file mode 100644
index 000000000000..fd3d2958cc15
--- /dev/null
+++ b/tools/testing/selftests/digest_cache/common.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header of common.c.
+ */
+
+#ifndef _COMMON_H
+#define _COMMON_H
+#include <linux/types.h>
+
+#include "../../../../include/uapi/linux/hash_info.h"
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
+#define SHA3_224_DIGEST_SIZE	(224 / 8)
+#define SHA3_256_DIGEST_SIZE	(256 / 8)
+#define SHA3_384_DIGEST_SIZE	(384 / 8)
+#define SHA3_512_DIGEST_SIZE	(512 / 8)
+
+#define DIGEST_CACHE_DIR "/sys/kernel/security/integrity/digest_cache"
+#define DIGEST_CACHE_TEST_INTERFACE "/sys/kernel/security/digest_cache_test"
+#define DIGEST_CACHE_PATH_INTERFACE DIGEST_CACHE_DIR "/default_path"
+#define MAX_DIGEST_SIZE 64
+
+#define RPMTAG_FILEDIGESTS 1035
+#define RPMTAG_FILEDIGESTALGO 5011
+
+#define RPM_INT32_TYPE 4
+#define RPM_STRING_ARRAY_TYPE 8
+
+#define MAX_WORKS 21
+
+typedef __u8 u8;
+typedef __u16 u16;
+typedef __u32 u32;
+typedef __s32 s32;
+typedef __u64 u64;
+
+enum commands {
+	DIGEST_CACHE_GET,		// args: <path>
+	DIGEST_CACHE_LOOKUP,		// args: <algo>|<digest>
+	DIGEST_CACHE_PUT,		// args:
+	DIGEST_CACHE_ENABLE_VERIF,	// args: <verif name>
+	DIGEST_CACHE_DISABLE_VERIF,	// args: <verif name>
+	DIGEST_CACHE_SET_VERIF,		// args: <verif name>
+	DIGEST_CACHE_GET_PUT_ASYNC,	// args: <path>|<start#>|<end#>
+	DIGEST_CACHE__LAST,
+};
+
+enum tlv_failures { TLV_NO_FAILURE,
+		    TLV_FAILURE_ALGO_LEN,
+		    TLV_FAILURE_HDR_LEN,
+		    TLV_FAILURE_ALGO_MISMATCH,
+		    TLV_FAILURE_NUM_DIGESTS,
+		    TLV_FAILURE__LAST
+};
+
+enum rpm_failures { RPM_NO_FAILURE,
+		    RPM_FAILURE_WRONG_MAGIC,
+		    RPM_FAILURE_BAD_DATA_OFFSET,
+		    RPM_FAILURE_WRONG_TAGS,
+		    RPM_FAILURE_WRONG_DIGEST_COUNT,
+		    RPM_FAILURE_DIGEST_WRONG_TYPE,
+		    RPM_FAILURE__LAST
+};
+
+enum file_changes { FILE_WRITE,
+		    FILE_TRUNCATE,
+		    FILE_FTRUNCATE,
+		    FILE_UNLINK,
+		    FILE_RENAME,
+		    FILE_SETXATTR,
+		    FILE_REMOVEXATTR,
+		    FILE_CHANGE__LAST
+};
+
+enum VERIFS {
+	VERIF_FILENAMES,
+	VERIF_NUMBER,
+	VERIF_PREFETCH,
+	VERIF__LAST
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
+extern const char *commands_str[DIGEST_CACHE__LAST];
+extern const char *const hash_algo_name[HASH_ALGO__LAST];
+extern const int hash_digest_size[HASH_ALGO__LAST];
+extern const char *verifs_str[VERIF__LAST];
+
+#endif /* _COMMON_H */
diff --git a/tools/testing/selftests/digest_cache/common_user.c b/tools/testing/selftests/digest_cache/common_user.c
new file mode 100644
index 000000000000..929420e1bbe6
--- /dev/null
+++ b/tools/testing/selftests/digest_cache/common_user.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Add common code in user space for testing the Integrity Digest Cache.
+ */
+
+#include <stddef.h>
+
+#include "common_user.h"
+
+static const char hex_asc[] = "0123456789abcdef";
+
+#define hex_asc_lo(x)   hex_asc[((x) & 0x0f)]
+#define hex_asc_hi(x)   hex_asc[((x) & 0xf0) >> 4]
+
+const enum hash_algo pgp_algo_mapping[DIGEST_ALGO_SHA224 + 1] = {
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
+static inline char *hex_byte_pack(char *buf, unsigned char byte)
+{
+	*buf++ = hex_asc_hi(byte);
+	*buf++ = hex_asc_lo(byte);
+	return buf;
+}
+
+char *bin2hex(char *dst, const void *src, size_t count)
+{
+	const unsigned char *_src = src;
+
+	while (count--)
+		dst = hex_byte_pack(dst, *_src++);
+	return dst;
+}
diff --git a/tools/testing/selftests/digest_cache/common_user.h b/tools/testing/selftests/digest_cache/common_user.h
new file mode 100644
index 000000000000..4eef52cc5c27
--- /dev/null
+++ b/tools/testing/selftests/digest_cache/common_user.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header of common_user.c.
+ */
+
+#include <linux/types.h>
+#include <stddef.h>
+
+#include "common.h"
+
+extern const enum hash_algo pgp_algo_mapping[DIGEST_ALGO_SHA224 + 1];
+
+char *bin2hex(char *dst, const void *src, size_t count);
diff --git a/tools/testing/selftests/digest_cache/config b/tools/testing/selftests/digest_cache/config
new file mode 100644
index 000000000000..2822fc7ad1d3
--- /dev/null
+++ b/tools/testing/selftests/digest_cache/config
@@ -0,0 +1 @@
+CONFIG_INTEGRITY_DIGEST_CACHE=y
diff --git a/tools/testing/selftests/digest_cache/generators.c b/tools/testing/selftests/digest_cache/generators.c
new file mode 100644
index 000000000000..c7791a3589f2
--- /dev/null
+++ b/tools/testing/selftests/digest_cache/generators.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Generate digest lists for testing.
+ */
+
+#include <stddef.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <limits.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/xattr.h>
+#include <asm/byteorder.h>
+
+#include "generators.h"
+#include "../../../../include/uapi/linux/hash_info.h"
+#include "../../../../include/uapi/linux/xattr.h"
+#include "../../../../include/uapi/linux/tlv_digest_list.h"
+#include "../../../../include/uapi/linux/tlv_parser.h"
+
+int gen_tlv_list(int temp_dirfd, char *digest_list_filename,
+		 enum hash_algo algo, int start_number, int num_digests,
+		 enum tlv_failures failure)
+{
+	u64 _algo = __cpu_to_be64(algo);
+	u8 digest[MAX_DIGEST_SIZE] = { 0 };
+	int digest_len = hash_digest_size[algo];
+	int digest_len_to_copy = digest_len;
+	int ret, fd, i;
+
+	struct tlv_data_entry algo_entry = {
+		.field = __cpu_to_be64(DIGEST_LIST_ALGO),
+		.length = __cpu_to_be64(sizeof(_algo)),
+	};
+
+	struct tlv_data_entry entry_digest = {
+		.field = __cpu_to_be64(DIGEST_LIST_ENTRY_DIGEST),
+		.length = __cpu_to_be64(digest_len),
+	};
+
+	struct tlv_hdr entry_hdr = {
+		.data_type = __cpu_to_be64(DIGEST_LIST_ENTRY_DATA),
+		._reserved = 0,
+		.num_entries = __cpu_to_be64(1),
+		.total_len = __cpu_to_be64(sizeof(entry_digest) + digest_len),
+	};
+
+	struct tlv_data_entry entry_entry = {
+		.field = __cpu_to_be64(DIGEST_LIST_ENTRY),
+		.length = __cpu_to_be64(sizeof(entry_hdr) +
+					__be64_to_cpu(entry_hdr.total_len)),
+	};
+
+	struct tlv_hdr hdr = {
+		.data_type = __cpu_to_be64(DIGEST_LIST_FILE),
+		._reserved = 0,
+		.num_entries = __cpu_to_be64(1 + num_digests),
+		.total_len = __cpu_to_be64(sizeof(algo_entry) +
+					   __be64_to_cpu(algo_entry.length) +
+					   num_digests * (sizeof(entry_entry) +
+					   __be64_to_cpu(entry_entry.length)))
+	};
+
+	switch (failure) {
+	case TLV_FAILURE_ALGO_LEN:
+		algo_entry.length = algo_entry.length / 2;
+		break;
+	case TLV_FAILURE_HDR_LEN:
+		hdr.total_len--;
+		break;
+	case TLV_FAILURE_ALGO_MISMATCH:
+		_algo = __cpu_to_be64(algo - 1);
+		break;
+	case TLV_FAILURE_NUM_DIGESTS:
+		num_digests = 0;
+		break;
+	default:
+		break;
+	}
+
+	fd = openat(temp_dirfd, digest_list_filename,
+		    O_WRONLY | O_CREAT | O_TRUNC, 0600);
+	if (fd == -1)
+		return -errno;
+
+	ret = write(fd, (u8 *)&hdr, sizeof(hdr));
+	if (ret != sizeof(hdr))
+		return -errno;
+
+	ret = write(fd, (u8 *)&algo_entry, sizeof(algo_entry));
+	if (ret != sizeof(algo_entry))
+		return -errno;
+
+	ret = write(fd, (u8 *)&_algo, sizeof(_algo));
+	if (ret != sizeof(_algo))
+		return -errno;
+
+	*(u32 *)digest = start_number;
+
+	for (i = 0; i < num_digests; i++) {
+		ret = write(fd, (u8 *)&entry_entry, sizeof(entry_entry));
+		if (ret != sizeof(entry_entry))
+			return -errno;
+
+		ret = write(fd, (u8 *)&entry_hdr, sizeof(entry_hdr));
+		if (ret != sizeof(entry_hdr))
+			return -errno;
+
+		ret = write(fd, (u8 *)&entry_digest, sizeof(entry_digest));
+		if (ret != sizeof(entry_digest))
+			return -errno;
+
+		ret = write(fd, digest, digest_len_to_copy);
+		if (ret != digest_len_to_copy)
+			return -errno;
+
+		(*(u32 *)digest)++;
+	}
+
+	close(fd);
+	return 0;
+}
+
+int gen_rpm_list(int temp_dirfd, char *digest_list_filename,
+		 enum hash_algo algo, enum pgp_algos pgp_algo, int start_number,
+		 int num_digests, enum rpm_failures failure)
+{
+	u32 _pgp_algo = __cpu_to_be32(pgp_algo);
+	u8 digest[MAX_DIGEST_SIZE] = { 0 };
+	char digest_str[MAX_DIGEST_SIZE * 2 + 1];
+	struct rpm_hdr hdr;
+	struct rpm_entryinfo algo_entry, digest_entry;
+	int digest_len = hash_digest_size[algo];
+	int ret, fd, d_len, i;
+
+	d_len = hash_digest_size[algo] * 2 + 1;
+
+	hdr.magic = __cpu_to_be32(0x8eade801);
+	hdr.reserved = 0;
+	hdr.tags = __cpu_to_be32(1);
+
+	/*
+	 * Skip the algo section, to ensure that the parser recognizes MD5 as
+	 * the default hash algorithm.
+	 */
+	if (algo != HASH_ALGO_MD5)
+		hdr.tags = __cpu_to_be32(2);
+
+	hdr.datasize = __cpu_to_be32(d_len * num_digests);
+
+	if (algo != HASH_ALGO_MD5)
+		hdr.datasize = __cpu_to_be32(sizeof(u32) + d_len * num_digests);
+
+	digest_entry.tag = __cpu_to_be32(RPMTAG_FILEDIGESTS);
+	digest_entry.type = __cpu_to_be32(RPM_STRING_ARRAY_TYPE);
+	digest_entry.offset = 0;
+	digest_entry.count = __cpu_to_be32(num_digests);
+
+	algo_entry.tag = __cpu_to_be32(RPMTAG_FILEDIGESTALGO);
+	algo_entry.type = __cpu_to_be32(RPM_INT32_TYPE);
+	algo_entry.offset = __cpu_to_be32(d_len * num_digests);
+	algo_entry.count = __cpu_to_be32(1);
+
+	switch (failure) {
+	case RPM_FAILURE_WRONG_MAGIC:
+		hdr.magic++;
+		break;
+	case RPM_FAILURE_BAD_DATA_OFFSET:
+		algo_entry.offset = __cpu_to_be32(UINT_MAX);
+		break;
+	case RPM_FAILURE_WRONG_TAGS:
+		hdr.tags = __cpu_to_be32(2 + 10);
+		break;
+	case RPM_FAILURE_WRONG_DIGEST_COUNT:
+		/* We need to go beyond the algorithm, to fail. */
+		digest_entry.count = __cpu_to_be32(num_digests + 5);
+		break;
+	case RPM_FAILURE_DIGEST_WRONG_TYPE:
+		digest_entry.type = __cpu_to_be32(RPM_INT32_TYPE);
+		break;
+	default:
+		break;
+	}
+
+	fd = openat(temp_dirfd, digest_list_filename,
+		    O_WRONLY | O_CREAT | O_TRUNC, 0600);
+	if (fd == -1)
+		return -errno;
+
+	ret = write(fd, (u8 *)&hdr, sizeof(hdr));
+	if (ret != sizeof(hdr))
+		return -errno;
+
+	if (algo != HASH_ALGO_MD5) {
+		ret = write(fd, (u8 *)&algo_entry, sizeof(algo_entry));
+		if (ret != sizeof(algo_entry))
+			return -errno;
+	}
+
+	ret = write(fd, (u8 *)&digest_entry, sizeof(digest_entry));
+	if (ret != sizeof(digest_entry))
+		return -errno;
+
+	*(u32 *)digest = start_number;
+
+	for (i = 0; i < num_digests; i++) {
+		bin2hex(digest_str, digest, digest_len);
+
+		ret = write(fd, (u8 *)digest_str, d_len);
+		if (ret != d_len)
+			return -errno;
+
+		(*(u32 *)digest)++;
+	}
+
+	if (algo != HASH_ALGO_MD5) {
+		ret = write(fd, (u8 *)&_pgp_algo, sizeof(_pgp_algo));
+		if (ret != sizeof(_pgp_algo))
+			return -errno;
+	}
+
+	close(fd);
+	return 0;
+}
+
+int create_file(int temp_dirfd, char *filename, char *digest_list_filename)
+{
+	int ret = 0, fd;
+
+	fd = openat(temp_dirfd, filename, O_WRONLY | O_CREAT | O_TRUNC, 0600);
+	if (fd == -1)
+		return -errno;
+
+	if (!digest_list_filename)
+		goto out;
+
+	ret = fsetxattr(fd, XATTR_NAME_DIGEST_LIST, digest_list_filename,
+			strlen(digest_list_filename) + 1, 0);
+	if (ret == -1)
+		ret = -errno;
+out:
+	close(fd);
+	return ret;
+}
diff --git a/tools/testing/selftests/digest_cache/generators.h b/tools/testing/selftests/digest_cache/generators.h
new file mode 100644
index 000000000000..1c83e531b799
--- /dev/null
+++ b/tools/testing/selftests/digest_cache/generators.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header of generators.c.
+ */
+
+#include "common.h"
+#include "common_user.h"
+
+int gen_tlv_list(int temp_dirfd, char *digest_list_filename,
+		 enum hash_algo algo, int start_number, int num_digests,
+		 enum tlv_failures failure);
+int gen_rpm_list(int temp_dirfd, char *digest_list_filename,
+		 enum hash_algo algo, enum pgp_algos pgp_algo, int start_number,
+		 int num_digests, enum rpm_failures failure);
+int create_file(int temp_dirfd, char *filename, char *digest_list_filename);
diff --git a/tools/testing/selftests/digest_cache/testmod/Makefile b/tools/testing/selftests/digest_cache/testmod/Makefile
new file mode 100644
index 000000000000..1ba1c7f08658
--- /dev/null
+++ b/tools/testing/selftests/digest_cache/testmod/Makefile
@@ -0,0 +1,16 @@
+KDIR ?= ../../../../..
+
+MODULES = digest_cache_kern.ko
+
+obj-m += digest_cache_kern.o
+
+digest_cache_kern-y := kern.o ../common.o
+
+all:
+	+$(Q)$(MAKE) -C $(KDIR) M=$$PWD modules
+
+clean:
+	+$(Q)$(MAKE) -C $(KDIR) M=$$PWD clean
+
+install: all
+	+$(Q)$(MAKE) -C $(KDIR) M=$$PWD modules_install
diff --git a/tools/testing/selftests/digest_cache/testmod/kern.c b/tools/testing/selftests/digest_cache/testmod/kern.c
new file mode 100644
index 000000000000..1c76deb384ad
--- /dev/null
+++ b/tools/testing/selftests/digest_cache/testmod/kern.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the kernel module to interact with the Integrity Digest Cache.
+ */
+
+#define pr_fmt(fmt) "digest_cache TESTMOD: "fmt
+#include <linux/module.h>
+#include <linux/namei.h>
+#include <linux/security.h>
+#include <linux/dynamic_debug.h>
+#include <linux/digest_cache.h>
+#include <linux/kprobes.h>
+#include <linux/cpu.h>
+#include <linux/kernel_read_file.h>
+#include <crypto/hash_info.h>
+
+#include "../common.h"
+
+struct verif {
+	int (*update)(struct file *file);
+	ssize_t (*read)(struct file *file, char __user *buf, size_t datalen,
+			loff_t *ppos);
+	bool enabled;
+};
+
+struct read_work {
+	struct work_struct work;
+	char *path_str;
+	int ret;
+};
+
+static struct dentry *test;
+static struct digest_cache *digest_cache;
+static uintptr_t found;
+static int cur_verif_index;
+static u8 prefetch_buf[4096];
+static struct read_work w[MAX_WORKS];
+
+static int filenames_update(struct file *file)
+{
+	char *filename = (char *)file->f_path.dentry->d_name.name;
+
+	return digest_cache_verif_set(file, verifs_str[VERIF_FILENAMES],
+				      filename, strlen(filename) + 1);
+}
+
+static int number_update(struct file *file)
+{
+	const char *filename = file_dentry(file)->d_name.name;
+	size_t filename_len = strlen(filename);
+	u64 number = U64_MAX;
+	int ret;
+
+	while (filename_len) {
+		if (filename[filename_len - 1] < '0' ||
+		    filename[filename_len - 1] > '9')
+			break;
+
+		filename_len--;
+	}
+
+	ret = kstrtoull(filename + filename_len, 10, &number);
+	if (ret < 0) {
+		pr_debug("Failed to convert filename %s into number\n",
+			 file_dentry(file)->d_name.name);
+		return ret;
+	}
+
+	return digest_cache_verif_set(file, verifs_str[VERIF_NUMBER], &number,
+				      sizeof(number));
+}
+
+static int prefetch_update(struct file *file)
+{
+	char *filename = (char *)file->f_path.dentry->d_name.name;
+	char *start_ptr = prefetch_buf, *end_ptr;
+	int ret;
+
+	ret = digest_cache_verif_set(file, "kprobe_test", "1", 1);
+	if (!ret) {
+		/* Don't include duplicates of requested digest lists. */
+		while ((end_ptr = strchrnul(start_ptr, ','))) {
+			if (end_ptr > start_ptr &&
+			    !strncmp(start_ptr, filename, end_ptr - start_ptr))
+				return 0;
+
+			if (!*end_ptr)
+				break;
+
+			start_ptr = end_ptr + 1;
+		}
+	}
+
+	if (prefetch_buf[0])
+		strlcat(prefetch_buf, ",", sizeof(prefetch_buf));
+
+	strlcat(prefetch_buf, filename, sizeof(prefetch_buf));
+	return 0;
+}
+
+static ssize_t filenames_read(struct file *file, char __user *buf,
+			      size_t datalen, loff_t *ppos)
+{
+	loff_t _ppos = 0;
+	char *filenames_list;
+
+	filenames_list = digest_cache_verif_get(found ?
+						(struct digest_cache *)found :
+						digest_cache,
+						verifs_str[VERIF_FILENAMES]);
+	if (!filenames_list)
+		return -ENOENT;
+
+	return simple_read_from_buffer(buf, datalen, &_ppos, filenames_list,
+				       strlen(filenames_list) + 1);
+}
+
+static ssize_t number_read(struct file *file, char __user *buf, size_t datalen,
+			   loff_t *ppos)
+{
+	loff_t _ppos = 0;
+	u64 *number;
+	char temp[20];
+	ssize_t len;
+
+	number = digest_cache_verif_get(found ? (struct digest_cache *)found :
+					digest_cache, verifs_str[VERIF_NUMBER]);
+	if (!number)
+		return -ENOENT;
+
+	len = snprintf(temp, sizeof(temp), "%llu", *number);
+
+	return simple_read_from_buffer(buf, datalen, &_ppos, temp, len);
+}
+
+static ssize_t prefetch_read(struct file *file, char __user *buf,
+			     size_t datalen, loff_t *ppos)
+{
+	loff_t _ppos = 0;
+	ssize_t ret;
+
+	ret = simple_read_from_buffer(buf, datalen, &_ppos, prefetch_buf,
+				      strlen(prefetch_buf) + 1);
+	memset(prefetch_buf, 0, sizeof(prefetch_buf));
+	return ret;
+}
+
+static struct verif verifs_methods[] = {
+	[VERIF_FILENAMES] = { .update = filenames_update,
+			      .read = filenames_read },
+	[VERIF_NUMBER] = { .update = number_update, .read = number_read },
+	[VERIF_PREFETCH] = { .update = prefetch_update, .read = prefetch_read },
+};
+
+static void digest_cache_get_put_work(struct work_struct *work)
+{
+	struct read_work *w = container_of(work, struct read_work, work);
+	struct digest_cache *digest_cache;
+	struct path path;
+
+	w->ret = kern_path(w->path_str, 0, &path);
+	if (w->ret < 0)
+		return;
+
+	digest_cache = digest_cache_get(path.dentry);
+
+	path_put(&path);
+
+	if (!digest_cache) {
+		w->ret = -ENOENT;
+		return;
+	}
+
+	digest_cache_put(digest_cache);
+	w->ret = 0;
+}
+
+static int digest_cache_get_put_async(char *path_str, int start_number,
+				      int end_number)
+{
+	int ret = 0, i;
+
+	cpus_read_lock();
+	for (i = start_number; i <= end_number; i++) {
+		w[i].path_str = kasprintf(GFP_KERNEL, "%s%u", path_str, i);
+		if (!w[i].path_str) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		INIT_WORK_ONSTACK(&w[i].work, digest_cache_get_put_work);
+		schedule_work_on(i % num_online_cpus(), &w[i].work);
+	}
+	cpus_read_unlock();
+
+	for (i = start_number; i <= end_number; i++) {
+		if (!w[i].path_str)
+			continue;
+
+		flush_work(&w[i].work);
+		destroy_work_on_stack(&w[i].work);
+		kfree(w[i].path_str);
+		w[i].path_str = NULL;
+		if (!ret)
+			ret = w[i].ret;
+	}
+
+	return ret;
+}
+
+static ssize_t write_request(struct file *file, const char __user *buf,
+			     size_t datalen, loff_t *ppos)
+{
+	char *data, *data_ptr, *cmd_str, *path_str, *algo_str, *digest_str;
+	char *verif_name_str, *start_number_str, *end_number_str;
+	u8 digest[64];
+	struct path path;
+	int ret, cmd, algo, verif_index, start_number, end_number;
+
+	data = memdup_user_nul(buf, datalen);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	data_ptr = data;
+
+	cmd_str = strsep(&data_ptr, "|");
+	if (!cmd_str) {
+		pr_debug("No command\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	cmd = match_string(commands_str, DIGEST_CACHE__LAST, cmd_str);
+	if (cmd < 0) {
+		pr_err("Unknown command %s\n", cmd_str);
+		ret = -ENOENT;
+		goto out;
+	}
+
+	switch (cmd) {
+	case DIGEST_CACHE_GET:
+		found = 0UL;
+
+		path_str = strsep(&data_ptr, "|");
+		if (!path_str) {
+			pr_debug("No path\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = kern_path(path_str, 0, &path);
+		if (ret < 0) {
+			pr_debug("Cannot find file %s\n", path_str);
+			goto out;
+		}
+
+		if (digest_cache) {
+			pr_debug("Digest cache exists, doing a put\n");
+			digest_cache_put(digest_cache);
+		}
+
+		digest_cache = digest_cache_get(path.dentry);
+		ret = digest_cache ? 0 : -ENOENT;
+		pr_debug("digest cache get %s, ret: %d\n", path_str, ret);
+		path_put(&path);
+		break;
+	case DIGEST_CACHE_LOOKUP:
+		if (!digest_cache) {
+			pr_debug("No digest cache\n");
+			ret = -ENOENT;
+			goto out;
+		}
+
+		path_str = strsep(&data_ptr, "|");
+		if (!path_str) {
+			pr_debug("No path\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		algo_str = strsep(&data_ptr, ":");
+		digest_str = data_ptr;
+
+		if (!algo_str || !digest_str) {
+			pr_debug("No algo or digest\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		algo = match_string(hash_algo_name, HASH_ALGO__LAST, algo_str);
+		if (algo < 0) {
+			pr_err("Unknown algorithm %s", algo_str);
+			ret = -ENOENT;
+			goto out;
+		}
+
+		ret = hex2bin(digest, digest_str, hash_digest_size[algo]);
+		if (ret < 0) {
+			pr_debug("Invalid digest %s\n", digest_str);
+			goto out;
+		}
+
+		ret = kern_path(path_str, 0, &path);
+		if (ret < 0) {
+			pr_debug("Cannot find file %s\n", path_str);
+			goto out;
+		}
+
+		ret = -ENOENT;
+
+		found = digest_cache_lookup(path.dentry, digest_cache, digest,
+					    algo);
+		path_put(&path);
+		if (found)
+			ret = 0;
+
+		pr_debug("%s:%s lookup %s, ret: %d\n", algo_str, digest_str,
+			 path_str, ret);
+		break;
+	case DIGEST_CACHE_PUT:
+		if (digest_cache) {
+			digest_cache_put(digest_cache);
+			digest_cache = NULL;
+		}
+		ret = 0;
+		pr_debug("digest cache put, ret: %d\n", ret);
+		break;
+	case DIGEST_CACHE_ENABLE_VERIF:
+	case DIGEST_CACHE_DISABLE_VERIF:
+		memset(prefetch_buf, 0, sizeof(prefetch_buf));
+		fallthrough;
+	case DIGEST_CACHE_SET_VERIF:
+		verif_name_str = strsep(&data_ptr, "|");
+		if (!verif_name_str) {
+			pr_debug("No verifier name\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		verif_index = match_string(verifs_str, ARRAY_SIZE(verifs_str),
+					   verif_name_str);
+		if (verif_index < 0) {
+			pr_err("Unknown verifier name %s\n", verif_name_str);
+			ret = -ENOENT;
+			goto out;
+		}
+
+		if (cmd == DIGEST_CACHE_ENABLE_VERIF)
+			verifs_methods[verif_index].enabled = true;
+		else if (cmd == DIGEST_CACHE_DISABLE_VERIF)
+			verifs_methods[verif_index].enabled = false;
+		else
+			cur_verif_index = verif_index;
+
+		ret = 0;
+		pr_debug("digest cache %s %s, ret: %d\n", cmd_str,
+			 verif_name_str, ret);
+		break;
+	case DIGEST_CACHE_GET_PUT_ASYNC:
+		path_str = strsep(&data_ptr, "|");
+		if (!path_str) {
+			pr_debug("No path\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		start_number_str = strsep(&data_ptr, "|");
+		if (!start_number_str) {
+			pr_debug("No start number\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = kstrtoint(start_number_str, 10, &start_number);
+		if (ret < 0) {
+			pr_debug("Invalid start number %s\n", start_number_str);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		end_number_str = strsep(&data_ptr, "|");
+		if (!end_number_str) {
+			pr_debug("No end number\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = kstrtoint(end_number_str, 10, &end_number);
+		if (ret < 0) {
+			pr_debug("Invalid end number %s\n", end_number_str);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (end_number - start_number >= MAX_WORKS) {
+			pr_debug("Too many works (%d), max %d\n",
+				 end_number - start_number, MAX_WORKS - 1);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = digest_cache_get_put_async(path_str, start_number,
+						 end_number);
+		pr_debug("digest cache %s on %s, start: %d, end: %d, ret: %d\n",
+			 cmd_str, path_str, start_number, end_number, ret);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+out:
+	kfree(data);
+	return ret ?: datalen;
+}
+
+static ssize_t read_request(struct file *file, char __user *buf, size_t datalen,
+			    loff_t *ppos)
+{
+	return verifs_methods[cur_verif_index].read(file, buf, datalen, ppos);
+}
+
+static const struct file_operations digest_cache_test_ops = {
+	.open = generic_file_open,
+	.write = write_request,
+	.read = read_request,
+	.llseek = generic_file_llseek,
+};
+
+static int __kprobes kernel_post_read_file_hook(struct kprobe *p,
+						struct pt_regs *regs)
+{
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	struct file *file = (struct file *)regs_get_kernel_argument(regs, 0);
+	enum kernel_read_file_id id = regs_get_kernel_argument(regs, 3);
+#else
+	struct file *file = NULL;
+	enum kernel_read_file_id id = READING_UNKNOWN;
+#endif
+	int ret, i;
+
+	if (id != READING_DIGEST_LIST)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(verifs_methods); i++) {
+		if (!verifs_methods[i].enabled)
+			continue;
+
+		ret = verifs_methods[i].update(file);
+		if (ret < 0)
+			return 0;
+	}
+
+	return 0;
+}
+
+static struct kprobe kp = {
+	.symbol_name = "security_kernel_post_read_file",
+};
+
+static int __init digest_cache_test_init(void)
+{
+	int ret;
+
+	kp.pre_handler = kernel_post_read_file_hook;
+
+	ret = register_kprobe(&kp);
+	if (ret < 0) {
+		pr_err("register_kprobe failed, returned %d\n", ret);
+		return ret;
+	}
+
+	test = securityfs_create_file("digest_cache_test", 0660, NULL, NULL,
+				      &digest_cache_test_ops);
+	if (IS_ERR(test)) {
+		ret = PTR_ERR(test);
+		goto out_kprobe;
+	}
+
+	return 0;
+out_kprobe:
+	unregister_kprobe(&kp);
+	return ret;
+}
+
+static void __exit digest_cache_test_fini(void)
+{
+	if (digest_cache)
+		digest_cache_put(digest_cache);
+
+	securityfs_remove(test);
+	unregister_kprobe(&kp);
+	pr_debug("kprobe at %p unregistered\n", kp.addr);
+}
+
+module_init(digest_cache_test_init);
+module_exit(digest_cache_test_fini);
+MODULE_LICENSE("GPL");
-- 
2.34.1


