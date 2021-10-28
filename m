Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F347D43E9AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 22:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhJ1UkG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 16:40:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:2684 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231332AbhJ1UkC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 16:40:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="217692550"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="217692550"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:31 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="498563000"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:37:30 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com
Cc:     seanjc@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 10/15] selftests/sgx: Add a new kselftest: unclobbered_vdso_oversubscribed
Date:   Thu, 28 Oct 2021 13:37:35 -0700
Message-Id: <7715db4882ab9fd52d21de6f62bb3b7e94dc4885.1635447301.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635447301.git.reinette.chatre@intel.com>
References: <cover.1635447301.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

Add a variation of the unclobbered_vdso test.

In the new test, create a heap for the test enclave, which has the same
size as all available Enclave Page Cache (EPC) pages in the system. This
will guarantee that all test_encl.elf pages *and* SGX Enclave Control
Structure (SECS) have been swapped out by the page reclaimer during the
load time.

This test will trigger both the page reclaimer and the page fault handler.
The page reclaimer triggered, while the heap is being created during the
load time. The page fault handler is triggered for all the required pages,
while the test case is executing.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
[reinette: rework code obtaining SGX physical memory based on most recent
upstream solution]
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Add signature from Dave.
- Add support to obtain SGX physical memory from v8 of Jarkko's patches.

 tools/testing/selftests/sgx/main.c | 114 +++++++++++++++++++++++++++++
 tools/testing/selftests/sgx/main.h |   1 +
 2 files changed, 115 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index f41fba919d06..541862c15901 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
 
+#define _GNU_SOURCE
+#include <dirent.h>
 #include <elf.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -245,6 +247,118 @@ TEST_F(enclave, unclobbered_vdso)
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
+static bool sysfs_get_ulong(const char *path, unsigned long *value)
+{
+	struct stat sbuf;
+	char buf[128];
+	ssize_t ret;
+	int fd;
+
+	ret = stat(path, &sbuf);
+	if (ret)
+		return false;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	ret = read(fd, buf, sizeof(buf));
+	if (ret < 0) {
+		close(fd);
+		return false;
+	}
+
+	errno = 0;
+	*value = strtoul(buf, NULL, 0);
+
+	close(fd);
+
+	return errno ? false : true;
+}
+
+/*
+ * Sum total available physical SGX memory across all NUMA nodes
+ *
+ * Return: total available physical SGX memory available on system or 0 if a
+ * failure is encountered.
+ */
+static unsigned long get_total_epc_mem(void)
+{
+	char *node, *path = NULL;
+	unsigned long total = 0;
+	unsigned long size = 0;
+	struct dirent *entry;
+	struct stat statbuf;
+	DIR *dp;
+	int ret;
+
+	dp = opendir(SGX_TOTAL_MEM_PATH);
+	if (!dp)
+		return 0;
+
+	while ((entry = readdir(dp))) {
+		node = strstr(entry->d_name, "node");
+		if (!node)
+			continue;
+
+		ret = asprintf(&path, "%s/%s/sgx/size",
+				SGX_TOTAL_MEM_PATH, entry->d_name);
+		if (ret == -1) {
+			total = 0;
+			goto out;
+		}
+
+		ret = stat(path, &statbuf);
+		if (ret == -1) {
+			free(path);
+			continue;
+		}
+
+		if (S_ISREG(statbuf.st_mode) && statbuf.st_size > 0) {
+			if (sysfs_get_ulong(path, &size))
+				total += size;
+		}
+
+		free(path);
+	}
+
+out:
+	closedir(dp);
+
+	return total;
+}
+
+TEST_F(enclave, unclobbered_vdso_oversubscribed)
+{
+	unsigned long total_mem;
+	struct encl_op op;
+
+	total_mem = get_total_epc_mem();
+	ASSERT_NE(total_mem, 0);
+	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	op.type = ENCL_OP_PUT;
+	op.buffer = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	op.type = ENCL_OP_GET;
+	op.buffer = 0;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+
+	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+}
+
 TEST_F(enclave, clobbered_vdso)
 {
 	struct encl_op op;
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index b45c52ec7ab3..59027df32a6a 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -7,6 +7,7 @@
 #define MAIN_H
 
 #define ENCL_HEAP_SIZE_DEFAULT	4096
+#define SGX_TOTAL_MEM_PATH	"/sys/devices/system/node"
 
 struct encl_segment {
 	void *src;
-- 
2.25.1

