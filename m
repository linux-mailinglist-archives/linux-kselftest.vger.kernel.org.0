Return-Path: <linux-kselftest+bounces-23988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85205A04296
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271E43A4F84
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5820D1F0E51;
	Tue,  7 Jan 2025 14:29:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1268E1F190A
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Jan 2025 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260190; cv=none; b=oSBzbr8nqeGICNsRK5uEWnzteiFaxkK0TPTRo5RU5JstvlNUn4OXw9UYcovyjkMcRe/j4iSoFgg0RSX1oxZt2AyZrkldE0AKERoVwk0mB1IXuMR+3IRQk2T6owq/HWa9ovowUZ8FvSqHuadZZda7FE2mlrZekuPh2w57cnxN35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260190; c=relaxed/simple;
	bh=uZE/s2iAwhl0+VAhfDf4vnki1M7xmPCT5qAAtCGyS68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dknQZRL+sNEit8Ha2pwz6O2HhPux/Tiasowsn/Imt2nSuWGB406fiwiXLff+3zlJY9sTuZpzmDBS3HI5q+F5DrgPu9dwiww4Pyf4HQ/ZsytvGvEmLtaBegA2/pLb94WTSTQ+H6HANaSUrSnlaZBtS+6PzmZoLSlXbFsK3xNqs/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90A771424;
	Tue,  7 Jan 2025 06:30:14 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 355483F59E;
	Tue,  7 Jan 2025 06:29:45 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1] selftests/mm: static process_madvise() wrapper for guard-pages
Date: Tue,  7 Jan 2025 14:29:35 +0000
Message-ID: <20250107142937.1870478-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recently introduced guard-pages mm selftest uses the
process_madvise() syscall, a wrapper for which was added to glibc v2.36.
For those of us stuck with older distributions this causes a compile
error when compiling the mm selftests. For example Ubuntu 22.04 uses
glibc 2.35, which does not have the wrapper.

To workaround the issue, let's introduce our own static
process_madvise() wrapper that uses glibc's syscall() helper.

While we are at it, add the guard-page test suite to run_vmtests.sh so
that it can be automatically run by CI systems.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Applies on top of mm-unstable (f349e79bfbf3)

Thanks,
Ryan

 tools/testing/selftests/mm/guard-pages.c  | 10 ++++++++--
 tools/testing/selftests/mm/run_vmtests.sh |  5 +++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
index d8f8dee9ebbd..ece37212a8a2 100644
--- a/tools/testing/selftests/mm/guard-pages.c
+++ b/tools/testing/selftests/mm/guard-pages.c
@@ -55,6 +55,12 @@ static int pidfd_open(pid_t pid, unsigned int flags)
 	return syscall(SYS_pidfd_open, pid, flags);
 }

+static ssize_t sys_process_madvise(int pidfd, const struct iovec *iovec,
+				   size_t n, int advice, unsigned int flags)
+{
+	return syscall(__NR_process_madvise, pidfd, iovec, n, advice, flags);
+}
+
 /*
  * Enable our signal catcher and try to read/write the specified buffer. The
  * return value indicates whether the read/write succeeds without a fatal
@@ -419,7 +425,7 @@ TEST_F(guard_pages, process_madvise)
 	ASSERT_EQ(munmap(&ptr_region[99 * page_size], page_size), 0);

 	/* Now guard in one step. */
-	count = process_madvise(pidfd, vec, 6, MADV_GUARD_INSTALL, 0);
+	count = sys_process_madvise(pidfd, vec, 6, MADV_GUARD_INSTALL, 0);

 	/* OK we don't have permission to do this, skip. */
 	if (count == -1 && errno == EPERM)
@@ -440,7 +446,7 @@ TEST_F(guard_pages, process_madvise)
 	ASSERT_FALSE(try_read_write_buf(&ptr3[19 * page_size]));

 	/* Now do the same with unguard... */
-	count = process_madvise(pidfd, vec, 6, MADV_GUARD_REMOVE, 0);
+	count = sys_process_madvise(pidfd, vec, 6, MADV_GUARD_REMOVE, 0);

 	/* ...and everything should now succeed. */

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 2fc290d9430c..00c3f07ea100 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -45,6 +45,8 @@ separated by spaces:
 	vmalloc smoke tests
 - hmm
 	hmm smoke tests
+- madv_guard
+	test madvise(2) MADV_GUARD_INSTALL and MADV_GUARD_REMOVE options
 - madv_populate
 	test memadvise(2) MADV_POPULATE_{READ,WRITE} options
 - memfd_secret
@@ -375,6 +377,9 @@ CATEGORY="mremap" run_test ./mremap_dontunmap

 CATEGORY="hmm" run_test bash ./test_hmm.sh smoke

+# MADV_GUARD_INSTALL and MADV_GUARD_REMOVE tests
+CATEGORY="madv_guard" run_test ./guard-pages
+
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate

--
2.43.0


