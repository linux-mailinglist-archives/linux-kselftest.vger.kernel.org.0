Return-Path: <linux-kselftest+bounces-22442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4809D5B57
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 09:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A661F21BEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F71BD4FB;
	Fri, 22 Nov 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjezCsCg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7461BD9F5;
	Fri, 22 Nov 2024 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265736; cv=none; b=qViRGQsA3gQUX+NPN8XVr1v4915cmttbW6Mi6E0vxrlv59qMaCRRah3/rk5YfOloQVY1wkhb0jO0cHWLQc8o+RiaEnWWbQDBgzpuz8Ap3uBIzS53nAPNEOMkxpoCBL2JBNAvMJN7gsm8FPE/h8tWJnqsLyGeThVp9FkHThqgcPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265736; c=relaxed/simple;
	bh=PIggoC4Qh9d2n40adshFVBIHZZFCQI5/5MeR1Q1P89M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjhASW7HfzvtuQ2tlXpm/cIBMOfyMQe8saQjXxUL45X38PluuZsEo21U6wNQhf12ekSCEHdFkn4J5GaxrqI0IAv1MTUiKFUKAQk/DxQe2fD2bqD2mwik1lSxXXUlc+oOh2IVFzkEXqVigB8KeeCWQYZfuaMLwxLtI9crp4RB0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjezCsCg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732265734; x=1763801734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PIggoC4Qh9d2n40adshFVBIHZZFCQI5/5MeR1Q1P89M=;
  b=NjezCsCgFsFhxlBxBjMaxA2VLcwi80JFuHiU64av6mjY9Xa9NWIIqq6X
   vySydy9e+QwUZjNKuMlb9ppLGdJAHJ6vWGN3EV0mVM5QXxu5W3GsRODFT
   fBVvUi+09nK1AS/pu3ENuS4DBQMNoJuJq1NJ7NIrYne48TDB0cjc4PEMW
   U+hA1bJV2/IVLHC/wVquGCBpcoq+DR/gi9zxzPn+hwxSo+HMjDXoEMfGg
   rmtJcwplEJYLtf3svFldrjzio67he4cVRUZgFPgCmlXnY0/lEKJJtqCPN
   Ue7vkbpI+Rx8JMEg1B6hfIDwV+VySSg+534y9tU3hroadu62WVdkNgRMr
   A==;
X-CSE-ConnectionGUID: DDP1p8H7RySeC5H4TooIHQ==
X-CSE-MsgGUID: udZDXY4HQJ+HHvfqeyDpNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="49833197"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="49833197"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 00:55:33 -0800
X-CSE-ConnectionGUID: z5nclqM3SIaBNQ6kaP3ZBg==
X-CSE-MsgGUID: oMNO8R79Rs62wZt9zBYD1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90454969"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO wieczorr-mobl1.intel.com) ([10.245.245.234])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 00:55:30 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kirill@shutemov.name,
	maciej.wieczor-retman@intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3] selftests/lam: Test get_user() LAM pointer handling
Date: Fri, 22 Nov 2024 09:55:20 +0100
Message-ID: <20241122085521.270802-1-maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent change in how get_user() handles pointers [1] has a specific case
for LAM. It assigns a different bitmask that's later used to check
whether a pointer comes from userland in get_user().

While currently commented out (until LASS [2] is merged into the kernel)
it's worth making changes to the LAM selftest ahead of time.

Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
get_user() in its implementation. Execute the syscall with differently
tagged pointers to verify that valid user pointers are passing through
and invalid kernel/non-canonical pointers are not.

Code was tested on a Sierra Forest Xeon machine that's LAM capable. The
test was ran without issues with both the LAM lines from [1] untouched
and commented out. The test was also ran without issues with LAM_SUP
both enabled and disabled.

4/5 level pagetables code paths were also successfully tested in Simics
on a 5-level capable machine.

[1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
[2] https://lore.kernel.org/all/20240710160655.3402786-1-alexander.shishkin@linux.intel.com/

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v3:
- mmap the pointer passed to get_user to high address if 5 level paging
  is enabled and to low address if 4 level paging is enabled.

Changelog v2:
- Use mmap with HIGH_ADDR to check if we're in 5 or 4 level pagetables.

 tools/testing/selftests/x86/lam.c | 110 ++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 0ea4f6813930..616a523c3262 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -4,6 +4,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/syscall.h>
+#include <sys/ioctl.h>
 #include <time.h>
 #include <signal.h>
 #include <setjmp.h>
@@ -43,7 +44,15 @@
 #define FUNC_INHERITE           0x20
 #define FUNC_PASID              0x40
 
+/* get_user() pointer test cases */
+#define GET_USER_USER           0
+#define GET_USER_KERNEL_TOP     1
+#define GET_USER_KERNEL_BOT     2
+#define GET_USER_KERNEL         3
+
 #define TEST_MASK               0x7f
+#define L5_SIGN_EXT_MASK        (0xFFUL << 56)
+#define L4_SIGN_EXT_MASK        (0x1FFFFUL << 47)
 
 #define LOW_ADDR                (0x1UL << 30)
 #define HIGH_ADDR               (0x3UL << 48)
@@ -370,6 +379,80 @@ static int handle_syscall(struct testcases *test)
 	return ret;
 }
 
+static int get_user_syscall(struct testcases *test)
+{
+	uint64_t ptr_address, bitmask;
+	void *p, *ptr;
+	int ret = 0;
+	int fd;
+
+	p = mmap((void *)HIGH_ADDR, 1, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+
+	if (p == MAP_FAILED) {
+		bitmask = L4_SIGN_EXT_MASK;
+		ptr_address = LOW_ADDR;
+
+	} else {
+		bitmask = L5_SIGN_EXT_MASK;
+		ptr_address = HIGH_ADDR;
+	}
+
+	munmap(p, 1);
+
+	ptr = mmap((void *)ptr_address, 1, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+
+	if (ptr == MAP_FAILED) {
+		perror("failed to map byte to pass into get_user");
+		return 1;
+	}
+
+	if (test->lam != 0) {
+		if (set_lam(test->lam) != 0) {
+			ret = 2;
+			goto error;
+		}
+	}
+
+	fd = memfd_create("lam_ioctl", 0);
+	if (fd == -1) {
+		munmap(ptr, 1);
+		exit(EXIT_FAILURE);
+	}
+
+	switch (test->later) {
+	case GET_USER_USER:
+		/* Control group - properly tagger user pointer */
+		ptr = (void *)set_metadata((uint64_t)ptr, test->lam);
+		break;
+	case GET_USER_KERNEL_TOP:
+		/* Kernel address with top bit cleared */
+		bitmask &= (bitmask >> 1);
+		ptr = (void *)((uint64_t)ptr | bitmask);
+		break;
+	case GET_USER_KERNEL_BOT:
+		/* Kernel address with bottom sign-extension bit cleared */
+		bitmask &= (bitmask << 1);
+		ptr = (void *)((uint64_t)ptr | bitmask);
+		break;
+	case GET_USER_KERNEL:
+		/* Try to pass a kernel address */
+		ptr = (void *)((uint64_t)ptr | bitmask);
+		break;
+	default:
+		printf("Invalid test case value passed!\n");
+		break;
+	}
+
+	if (ioctl(fd, FIOASYNC, ptr) != 0)
+		ret = 1;
+
+error:
+	munmap(ptr, 1);
+	return ret;
+}
+
 int sys_uring_setup(unsigned int entries, struct io_uring_params *p)
 {
 	return (int)syscall(__NR_io_uring_setup, entries, p);
@@ -883,6 +966,33 @@ static struct testcases syscall_cases[] = {
 		.test_func = handle_syscall,
 		.msg = "SYSCALL:[Negative] Disable LAM. Dereferencing pointer with metadata.\n",
 	},
+	{
+		.later = GET_USER_USER,
+		.lam = LAM_U57_BITS,
+		.test_func = get_user_syscall,
+		.msg = "GET_USER: get_user() and pass a properly tagged user pointer.\n",
+	},
+	{
+		.later = GET_USER_KERNEL_TOP,
+		.expected = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = get_user_syscall,
+		.msg = "GET_USER:[Negative] get_user() with a kernel pointer and the top bit cleared.\n",
+	},
+	{
+		.later = GET_USER_KERNEL_BOT,
+		.expected = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = get_user_syscall,
+		.msg = "GET_USER:[Negative] get_user() with a kernel pointer and the bottom sign-extension bit cleared.\n",
+	},
+	{
+		.later = GET_USER_KERNEL,
+		.expected = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = get_user_syscall,
+		.msg = "GET_USER:[Negative] get_user() and pass a kernel pointer.\n",
+	},
 };
 
 static struct testcases mmap_cases[] = {
-- 
2.46.2


