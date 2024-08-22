Return-Path: <linux-kselftest+bounces-15987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4BF95ACA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 06:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B471F2283A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 04:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4612442A9B;
	Thu, 22 Aug 2024 04:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="R0YXP83E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434251CAA6
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 04:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724301577; cv=none; b=snokEXg+b7eaA4+Ck2fqLZngpCGfyKh0wmQPQ3/eOI0U5mjwIxjsI+c5bxoYjMJyiRytNKc6tniUngRt1CatIG8PFxqR4E8estkgVxDEeHi/di3AZTneTnTsh5AIeUNrCbYwlVaD85qHSyQOT2bp1STjVkMKSXLWBeleYWzzC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724301577; c=relaxed/simple;
	bh=si1+5ckOBPzI1ghXUuFTsZOYlXHhTyB/XUwwp/ozvcI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e9P2qDvqBDDT+4ooSBTRGhIsbJovrqhmrzTSMb67XdPVjD9ftQNcpazccY6PKgJPkqAIicM6SWTsHVhxeS+WyHCN9zQOrz1CUjwaatgq0M2Rw6tDocN6wpgi/PsKnh1riXmubwOUnJuILOAsYk9Cq1NeUYMPg/8ggk5eCH11Sgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=R0YXP83E; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=AA4WaTEkNjbjrZGfNu4KV2H8PXXj+NYazaOW4bROYjE=; b=R0YXP83Ems8aowdPQLXqMLRTEr
	UMg28z+t/0ETQKuqxL8mNjw9KyQLxq2PH3M7MQtRJ1lXWGsTD0qGFi6Ru2FNHNFZwz505w4925L33
	/VDw2NTIup6D+mbmt8Ot482GSUdW86XLKUn9vKTYVtFfJv6p0J1y+h2Vi1GdkRanZwrXo8H6miWoZ
	TT7mRW8a7eaVptD34V8BBhIYRrjoJ5VXepW8dYdK+hlU5KwOAlP8ttYWVy+e65oqcRN/bb209hoFp
	LobdO8fZsri+6bnlBQ+pL5Kbt4K9d32OYtoH+7IrIimaxX+T2/5ZiingxDiA2pDnWNR9+7O+4FcId
	7X1yDzfg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgzbg-00000003z5d-32D3
	for linux-kselftest@vger.kernel.org;
	Thu, 22 Aug 2024 04:39:32 +0000
Date: Thu, 22 Aug 2024 05:39:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-kselftest@vger.kernel.org
Subject: [PATCH] test coverage for dup_fd() failure handling in unshare_fd()
Message-ID: <20240822043932.GT504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	At some point there'd been a dumb braino during the dup_fd()
calling conventions change; caught by smatch and immediately fixed.
The trouble is, there had been no test coverage for the dup_fd() failure
handling - neither in kselftests nor in LTP.  Fortunately, it can be
triggered on stock kernel - ENOMEM would require fault injection, but
EMFILE can be had with sysctl alone (fs.nr_open).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
--- 
diff --git a/tools/testing/selftests/core/Makefile b/tools/testing/selftests/core/Makefile
index ce262d097269..8e99f87f5d7c 100644
--- a/tools/testing/selftests/core/Makefile
+++ b/tools/testing/selftests/core/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -g $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := close_range_test
+TEST_GEN_PROGS := close_range_test unshare_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/core/unshare_test.c b/tools/testing/selftests/core/unshare_test.c
new file mode 100644
index 000000000000..7fec9dfb1b0e
--- /dev/null
+++ b/tools/testing/selftests/core/unshare_test.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/kernel.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <unistd.h>
+#include <sys/resource.h>
+#include <linux/close_range.h>
+
+#include "../kselftest_harness.h"
+#include "../clone3/clone3_selftests.h"
+
+TEST(unshare_EMFILE)
+{
+	pid_t pid;
+	int status;
+	struct __clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+	int fd;
+	ssize_t n, n2;
+	static char buf[512], buf2[512];
+	struct rlimit rlimit;
+	int nr_open;
+
+	fd = open("/proc/sys/fs/nr_open", O_RDWR);
+	ASSERT_GE(fd, 0);
+
+	n = read(fd, buf, sizeof(buf));
+	ASSERT_GT(n, 0);
+	ASSERT_EQ(buf[n - 1], '\n');
+
+	ASSERT_EQ(sscanf(buf, "%d", &nr_open), 1);
+
+	ASSERT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));
+
+	/* bump fs.nr_open */
+	n2 = sprintf(buf2, "%d\n", nr_open + 1024);
+	lseek(fd, 0, SEEK_SET);
+	write(fd, buf2, n2);
+
+	/* bump ulimit -n */
+	rlimit.rlim_cur = nr_open + 1024;
+	rlimit.rlim_max = nr_open + 1024;
+	EXPECT_EQ(0, setrlimit(RLIMIT_NOFILE, &rlimit)) {
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
+		exit(EXIT_FAILURE);
+	}
+
+	/* get a descriptor past the old fs.nr_open */
+	EXPECT_GE(dup2(2, nr_open + 64), 0) {
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
+		exit(EXIT_FAILURE);
+	}
+
+	/* get descriptor table shared */
+	pid = sys_clone3(&args, sizeof(args));
+	EXPECT_GE(pid, 0) {
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
+		exit(EXIT_FAILURE);
+	}
+
+	if (pid == 0) {
+		int err;
+
+		/* restore fs.nr_open */
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
+		/* ... and now unshare(CLONE_FILES) must fail with EMFILE */
+		err = unshare(CLONE_FILES);
+		EXPECT_EQ(err, -1)
+			exit(EXIT_FAILURE);
+		EXPECT_EQ(errno, EMFILE)
+			exit(EXIT_FAILURE);
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+TEST_HARNESS_MAIN

