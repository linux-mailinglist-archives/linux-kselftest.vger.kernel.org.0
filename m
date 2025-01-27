Return-Path: <linux-kselftest+bounces-25236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983F6A1D99A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 16:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14897A56F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEFA157493;
	Mon, 27 Jan 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMYRJKFy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A62B15573F;
	Mon, 27 Jan 2025 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991961; cv=none; b=pK9yKZf4C2C3Hhh/5p1efyufnYY8I5YRSAHzpui4Ct9GXzWwNzpFe3V2/G2SfQv6SuRcdP1TVTWROkF6YpOGA/ypqFTslbBgnuYYYcjWjGMOP6beA6SAlGrHl/8Q58ZviIV6BwmFN0WPVQA7hmE5RYrNtxVSsST2zGwHHKc8WzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991961; c=relaxed/simple;
	bh=BESMgBwWxqrQ8LgJ1bKgxPdpSxs9VxfJab81KkvW+Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tU3v789+Lsw5KgX42STNn+Po7b5k4ISfdvsVmG1tA0DvGtcZvmO/FNMVv87NVkoqrX4JP827OWEULHHYqo/dPrTcqhSUAyd4P0yeyB5NrASVH/RkG45811SGIYxQqEZrp4GfB3SGNbHAh0p6QrkleRM1EMrLzcgOjnLSDq2SBhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMYRJKFy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737991960; x=1769527960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BESMgBwWxqrQ8LgJ1bKgxPdpSxs9VxfJab81KkvW+Nc=;
  b=KMYRJKFyM8t+wwcP/0Sgqmwh7aP3HoYjU6qhCQUhx6uYwo4murXS1PUS
   v7ELSx0d1cpL+5W/87KGRstsWS+MQKUxdav4enz6u4CP3ecQNDUvPVTmX
   QstqlCwOsDVgtLXmOLqj98fQoJByCHxvelpgOdNMH67TGAGzEgRet/pY7
   JcM6+ar6YinbSm4nTnRRI/on4+i7B2YbySjdyq5PegQ1wPUrLjMJavAli
   XyYs0w1ijPx2bRg9gFS57w7ftpNP8YDuVhtrz2CVqV2SJSuTWi4Cw7qSW
   1E/FiYM4zgWfkI/VHDn4K8tuj9iT9ydyJFVDMCAObDJ1RICrTRfo0ooJY
   A==;
X-CSE-ConnectionGUID: 4xi4M4//R++FW6Ym2n4M8Q==
X-CSE-MsgGUID: OFcEJ+lcQveffwZbTHubWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="38344130"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="38344130"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:32:40 -0800
X-CSE-ConnectionGUID: 8SI6fRs7Toq1GrCbTqua3w==
X-CSE-MsgGUID: TkKOcupjQ1W0VXRogpqXpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="108991074"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.88])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:32:37 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	hpa@zytor.com,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kirill@shutemov.name,
	maciej.wieczor-retman@intel.com
Subject: [PATCH v6 3/3] selftests/lam: Test get_user() LAM pointer handling
Date: Mon, 27 Jan 2025 16:31:57 +0100
Message-ID: <1624d9d1b9502517053a056652d50dc5d26884ac.1737990375.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1737990375.git.maciej.wieczor-retman@intel.com>
References: <cover.1737990375.git.maciej.wieczor-retman@intel.com>
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

Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
get_user() in its implementation. Execute the syscall with differently
tagged pointers to verify that valid user pointers are passing through
and invalid kernel/non-canonical pointers are not.

[1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v6:
- Update la57 checking function name.
- Fix typo and add comment to the ioctl() usage.

Changelog v4:
- Use the changed cpu_has_la57() instead of mmap() to figure out current
  paging level.
- Apply Kirill's other comments: Remove redundant always true check,
  close the ioctl file before exiting, change mapping size to PAGE_SIZE
  so it looks less odd.
- Turn this patch into a series and move some text to the cover letter.

Changelog v3:
- mmap the pointer passed to get_user to high address if 5 level paging
  is enabled and to low address if 4 level paging is enabled.

Changelog v2:
- Use mmap with HIGH_ADDR to check if we're in 5 or 4 level pagetables.

 tools/testing/selftests/x86/lam.c | 108 ++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 140011bc39c0..6e013dfac35e 100644
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
@@ -389,6 +398,78 @@ static int handle_syscall(struct testcases *test)
 	return ret;
 }
 
+static int get_user_syscall(struct testcases *test)
+{
+	uint64_t ptr_address, bitmask;
+	int fd, ret = 0;
+	void *ptr;
+
+	if (la57_enabled()) {
+		bitmask = L5_SIGN_EXT_MASK;
+		ptr_address = HIGH_ADDR;
+	} else {
+		bitmask = L4_SIGN_EXT_MASK;
+		ptr_address = LOW_ADDR;
+	}
+
+	ptr = mmap((void *)ptr_address, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+
+	if (ptr == MAP_FAILED) {
+		perror("failed to map byte to pass into get_user");
+		return 1;
+	}
+
+	if (set_lam(test->lam) != 0) {
+		ret = 2;
+		goto error;
+	}
+
+	fd = memfd_create("lam_ioctl", 0);
+	if (fd == -1) {
+		munmap(ptr, PAGE_SIZE);
+		exit(EXIT_FAILURE);
+	}
+
+	switch (test->later) {
+	case GET_USER_USER:
+		/* Control group - properly tagged user pointer */
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
+	/*
+	 * Use FIOASYNC ioctl because it utilizes get_user() internally and is
+	 * very non-invasive to the system. Pass differently tagged pointers to
+	 * get_user() in order to verify that valid user pointers are going
+	 * through and invalid kernel/non-canonical pointers are not.
+	 */
+	if (ioctl(fd, FIOASYNC, ptr) != 0)
+		ret = 1;
+
+	close(fd);
+error:
+	munmap(ptr, PAGE_SIZE);
+	return ret;
+}
+
 int sys_uring_setup(unsigned int entries, struct io_uring_params *p)
 {
 	return (int)syscall(__NR_io_uring_setup, entries, p);
@@ -902,6 +983,33 @@ static struct testcases syscall_cases[] = {
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
2.47.1


