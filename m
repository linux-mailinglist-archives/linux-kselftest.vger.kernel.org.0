Return-Path: <linux-kselftest+bounces-20956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEAD9B4BE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C2E1C2290F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD83206E7A;
	Tue, 29 Oct 2024 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUTXdvw1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C9A1E507;
	Tue, 29 Oct 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211334; cv=none; b=XKXxmwIECeSUkTdpq8LBbso7DnilIsOjwdFjboN6xqttmIxfK2go1QQpqo++jQRPBrUV63gqjGyzPykUk7hA6n2uktB/BJ9J/IqxWBDQKw2Cv32G0yFgDur49T1qak3xxLyrtW/I2PMQ2bopJm4XINxuHhDWz7CJKKiAiJyla8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211334; c=relaxed/simple;
	bh=vn3Jy7U8Kr606XKwuMr/9U1lMzlyFHE13781XmAPJTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMheoS1CEjuQwb4BZdQcMv2E5BKoIXKThXR/pw74BXnd142AX2geB9EiUgpiftMHqYFL/rOp1hU11YuKOoBeiEUvfQoipTfVUjkfacqqT2tlI6gVeEoiqk+3ilTOVt8prtFdDTqjmQ5kfRHtgPjpHkfcR71QBvneWr+beZgiHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUTXdvw1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730211332; x=1761747332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vn3Jy7U8Kr606XKwuMr/9U1lMzlyFHE13781XmAPJTM=;
  b=bUTXdvw1PhEdd+YdxuHIEEBjyfUz2AIm1zgerzap23HWmS+39JCTFZs1
   HIe/gJN8mwvQoIm/1VzRmmHISzxIoUGErQ6jF87+Kl8YWQBJ4WymnqPrw
   L9lMknro6gLMZAbx/t+ZHv2/nScpq4bubT25QmNg5KXPDWOwhODeLcZmn
   H7Zo7nqNw2Ew58ZAeO/i19Xy1qj5VDj5z8wDmki7XpNMbbpG8LmgxYnM5
   pzWgFIxSWXtNZJXXjvYJBsPUso9OIQN/FcefacmSWWwt7cxtJLIsb5Mfb
   XdM5UnYFHaCnLhTj8BiS+TtK96PAanQyI51uvbka92Dy70nuEIjznOGWj
   A==;
X-CSE-ConnectionGUID: GaY6ZA/ZQ3uNpwhnFGrSFg==
X-CSE-MsgGUID: bn7s7oz+Sg+V+9tbQoaDSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="41252608"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="41252608"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 07:15:31 -0700
X-CSE-ConnectionGUID: OXhBVyCyTZSe0g6WtEzk3g==
X-CSE-MsgGUID: aoxULuKgQCuIUshc/F96iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82042910"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.38])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 07:15:28 -0700
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
Subject: [PATCH] selftests/lam: Test get_user() LAM pointer handling
Date: Tue, 29 Oct 2024 15:14:20 +0100
Message-ID: <20241029141421.715686-1-maciej.wieczor-retman@intel.com>
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

[1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
[2] https://lore.kernel.org/all/20240710160655.3402786-1-alexander.shishkin@linux.intel.com/

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/x86/lam.c | 85 +++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 0ea4f6813930..3c53d4b7aa61 100644
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
@@ -43,10 +44,19 @@
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
+#define L5_ADDR                 (0x1UL << 48)
 
 #define MALLOC_LEN              32
 
@@ -370,6 +380,54 @@ static int handle_syscall(struct testcases *test)
 	return ret;
 }
 
+static int get_user_syscall(struct testcases *test)
+{
+	int ret = 0;
+	int ptr_value = 0;
+	void *ptr = &ptr_value;
+	int fd;
+
+	uint64_t bitmask = ((uint64_t)ptr & L5_ADDR) ? L5_SIGN_EXT_MASK :
+						       L4_SIGN_EXT_MASK;
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
@@ -883,6 +941,33 @@ static struct testcases syscall_cases[] = {
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


