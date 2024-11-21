Return-Path: <linux-kselftest+bounces-22389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391C39D4983
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 10:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E021F214AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7421BC9E2;
	Thu, 21 Nov 2024 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ij8/ohM+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996CD82890;
	Thu, 21 Nov 2024 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180033; cv=none; b=ASUV+I/Hab/GkN+hWmLRxx1sCp7fR9HgpT7AB1s8HRMAG0qMWRR9TXXAgDIa8T0dsv35aapaikdFKNJ4OwiKYKu55p1JIxiW0sRvBa7MwD+unpNsI5XbYS18ftLnmLR1OfpNV3kA7zEhLtu39gusglsrT9zQWM4rz3BSKrO04rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180033; c=relaxed/simple;
	bh=aDMNDWzbSeQ9o1aVfP6rTzzaHPUkuYNWQU5UCPGLraU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uNF+uqHuG+ZlDtjBTrTPQJpZ4r287p/DPwrECpTzzfDQrtNfGOHE8JTnZJlxc8RJfa/+Z09irwkyAVZXsxernWs13aBHutT7m/sEEQJxe3R4olQWCE0wGlpBUYIu3bR6WCzmvqw7iQ12KmEeu3zGD27iaaojAVerfu6tidR/djY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ij8/ohM+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732180032; x=1763716032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aDMNDWzbSeQ9o1aVfP6rTzzaHPUkuYNWQU5UCPGLraU=;
  b=ij8/ohM+QAYQf+TR6faExyU8EYZCuNzBOO9iR7gCoxlXiLKTSx5tA+KS
   q0b8j8L3biwMNoJqTAt5I+RlEOPU3MW8nzFdSCAzvK0qNS8HlASgrBjNc
   4BoPNebxD4bg+FKrEAa1YOcqpZOwrj9EobocNd1XJ9BD3hp9EV+8hGDAv
   a8t1w91YwqaD+5ekzlovEfw7fHkB2pBnFe7ItM2LUR8kgmluHqE42ovMG
   YGHXqXPn0yZrN8z8uT427splPgXt3cx9laqcCP5ClxVQ3f8FguynA0hBK
   H6HFaWdfXaG+eewgT4vDrbAGEP5p5nVpI4K5EWc7u4HTjc+UiY3qc1sVb
   g==;
X-CSE-ConnectionGUID: YNzG4qnuQEaSUxNKtTIX0Q==
X-CSE-MsgGUID: 4yMXRjq0QCGYc7N1EW8N1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="32524854"
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="32524854"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 01:07:11 -0800
X-CSE-ConnectionGUID: 45kF4xVhThqV6d8J3CRQig==
X-CSE-MsgGUID: aaNAg9vEQZOPQRPXTN/hig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,172,1728975600"; 
   d="scan'208";a="95253789"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.78])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 01:07:08 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kirill@shutemov.name,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/lam: Test get_user() LAM pointer handling
Date: Thu, 21 Nov 2024 10:06:51 +0100
Message-ID: <20241121090651.254054-1-maciej.wieczor-retman@intel.com>
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
Changelog v2:
- Use mmap with HIGH_ADDR to check if we're in 5 or 4 level pagetables.

 tools/testing/selftests/x86/lam.c | 89 +++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 0ea4f6813930..5818c075e1cd 100644
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
@@ -370,6 +379,59 @@ static int handle_syscall(struct testcases *test)
 	return ret;
 }
 
+static int get_user_syscall(struct testcases *test)
+{
+	int ptr_value = 0;
+	int ret = 0;
+	int fd;
+	void *p, *ptr = &ptr_value;
+
+	p = mmap((void *)HIGH_ADDR, 1, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+
+	uint64_t bitmask = (p == MAP_FAILED) ? L4_SIGN_EXT_MASK :
+					       L5_SIGN_EXT_MASK;
+
+	munmap(p, 1);
+
+	if (test->lam != 0)
+		if (set_lam(test->lam) != 0)
+			return 2;
+
+	fd = memfd_create("lam_ioctl", 0);
+	if (fd == -1)
+		exit(EXIT_FAILURE);
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
+	return ret;
+}
+
 int sys_uring_setup(unsigned int entries, struct io_uring_params *p)
 {
 	return (int)syscall(__NR_io_uring_setup, entries, p);
@@ -883,6 +945,33 @@ static struct testcases syscall_cases[] = {
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


