Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B9B5DC64
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 04:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfGCCPc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jul 2019 22:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbfGCCPc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jul 2019 22:15:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2872421873;
        Wed,  3 Jul 2019 02:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120130;
        bh=hMnvu1y7oW+9dgMx3Cngv884gTKh0B/1QjIVC72xhNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mszR6nHilkLbLT7UsTWdy2Kk/iEcK+TEEuFv1uTpGC7X2ehJUb245iO/1648kAnjR
         GkbkwN8IRgIXqy3XVSJJA7CBq0tSijV80hgH7xvWLTYdmqClnBA7WpoEUdm7j6PHmK
         dyRDYVOa/rLK/KRAFKdTX1G9xjSi+6J7Y66PxRWc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 09/39] selftests/powerpc: Add test of fork with mapping above 512TB
Date:   Tue,  2 Jul 2019 22:14:44 -0400
Message-Id: <20190703021514.17727-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703021514.17727-1-sashal@kernel.org>
References: <20190703021514.17727-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 16391bfc862342f285195013b73c1394fab28b97 ]

This tests that when a process with a mapping above 512TB forks we
correctly separate the parent and child address spaces. This exercises
the bug in the context id handling fixed in the previous commit.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/powerpc/mm/.gitignore |  3 +-
 tools/testing/selftests/powerpc/mm/Makefile   |  4 +-
 .../powerpc/mm/large_vm_fork_separation.c     | 87 +++++++++++++++++++
 3 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/large_vm_fork_separation.c

diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
index ba919308fe30..d503b8764a8e 100644
--- a/tools/testing/selftests/powerpc/mm/.gitignore
+++ b/tools/testing/selftests/powerpc/mm/.gitignore
@@ -3,4 +3,5 @@ subpage_prot
 tempfile
 prot_sao
 segv_errors
-wild_bctr
\ No newline at end of file
+wild_bctr
+large_vm_fork_separation
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
index 43d68420e363..f1fbc15800c4 100644
--- a/tools/testing/selftests/powerpc/mm/Makefile
+++ b/tools/testing/selftests/powerpc/mm/Makefile
@@ -2,7 +2,8 @@
 noarg:
 	$(MAKE) -C ../
 
-TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors wild_bctr
+TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors wild_bctr \
+		  large_vm_fork_separation
 TEST_GEN_FILES := tempfile
 
 top_srcdir = ../../../../..
@@ -13,6 +14,7 @@ $(TEST_GEN_PROGS): ../harness.c
 $(OUTPUT)/prot_sao: ../utils.c
 
 $(OUTPUT)/wild_bctr: CFLAGS += -m64
+$(OUTPUT)/large_vm_fork_separation: CFLAGS += -m64
 
 $(OUTPUT)/tempfile:
 	dd if=/dev/zero of=$@ bs=64k count=1
diff --git a/tools/testing/selftests/powerpc/mm/large_vm_fork_separation.c b/tools/testing/selftests/powerpc/mm/large_vm_fork_separation.c
new file mode 100644
index 000000000000..2363a7f3ab0d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/large_vm_fork_separation.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2019, Michael Ellerman, IBM Corp.
+//
+// Test that allocating memory beyond the memory limit and then forking is
+// handled correctly, ie. the child is able to access the mappings beyond the
+// memory limit and the child's writes are not visible to the parent.
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "utils.h"
+
+
+#ifndef MAP_FIXED_NOREPLACE
+#define MAP_FIXED_NOREPLACE	MAP_FIXED	// "Should be safe" above 512TB
+#endif
+
+
+static int test(void)
+{
+	int p2c[2], c2p[2], rc, status, c, *p;
+	unsigned long page_size;
+	pid_t pid;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	SKIP_IF(page_size != 65536);
+
+	// Create a mapping at 512TB to allocate an extended_id
+	p = mmap((void *)(512ul << 40), page_size, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE, -1, 0);
+	if (p == MAP_FAILED) {
+		perror("mmap");
+		printf("Error: couldn't mmap(), confirm kernel has 4TB support?\n");
+		return 1;
+	}
+
+	printf("parent writing %p = 1\n", p);
+	*p = 1;
+
+	FAIL_IF(pipe(p2c) == -1 || pipe(c2p) == -1);
+
+	pid = fork();
+	if (pid == 0) {
+		FAIL_IF(read(p2c[0], &c, 1) != 1);
+
+		pid = getpid();
+		printf("child writing  %p = %d\n", p, pid);
+		*p = pid;
+
+		FAIL_IF(write(c2p[1], &c, 1) != 1);
+		FAIL_IF(read(p2c[0], &c, 1) != 1);
+		exit(0);
+	}
+
+	c = 0;
+	FAIL_IF(write(p2c[1], &c, 1) != 1);
+	FAIL_IF(read(c2p[0], &c, 1) != 1);
+
+	// Prevent compiler optimisation
+	barrier();
+
+	rc = 0;
+	printf("parent reading %p = %d\n", p, *p);
+	if (*p != 1) {
+		printf("Error: BUG! parent saw child's write! *p = %d\n", *p);
+		rc = 1;
+	}
+
+	FAIL_IF(write(p2c[1], &c, 1) != 1);
+	FAIL_IF(waitpid(pid, &status, 0) == -1);
+	FAIL_IF(!WIFEXITED(status) || WEXITSTATUS(status));
+
+	if (rc == 0)
+		printf("success: test completed OK\n");
+
+	return rc;
+}
+
+int main(void)
+{
+	return test_harness(test, "large_vm_fork_separation");
+}
-- 
2.20.1

