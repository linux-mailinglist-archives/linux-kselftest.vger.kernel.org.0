Return-Path: <linux-kselftest+bounces-22580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47E9DAC93
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 18:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA76281E48
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48BA2010EC;
	Wed, 27 Nov 2024 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gC9hVAep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784D4201101;
	Wed, 27 Nov 2024 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728969; cv=none; b=htLE7QVkylzdWZOrwCQCXopdcas3YxUiiGUcRWWR7phw9n/R0DPCOTXN6a7Ai+sGbHBarVweFl9LrBnIsZdCqKCzTchdj+Gh6AKAFF+/EXBes3YTBE2J7sHxAjR3tFSDU3b17CLIIGMG0TUxfVVr55gKB4zLJYNH4CKoO9O7W+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728969; c=relaxed/simple;
	bh=tNMPuF9n5H1gSULGpD5Nersb7zlDJF4+Kn0ZO5uEySo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpsxzKfojhcIhllHFJmAZ8u5MpFjV38CDM0tqL8EiDx762AaHujQC6YD/B/BJkdCwP1F9SBo22SD8pKJ/i6p8u2rLsnP1P2ie40om5ohlCxPLldWE9NiZgJH34qz6GdvCLKn78IRhL3u7IeycHu/N+BhgEcoKdn0yHcY4gchsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gC9hVAep; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732728968; x=1764264968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tNMPuF9n5H1gSULGpD5Nersb7zlDJF4+Kn0ZO5uEySo=;
  b=gC9hVAepJHezkuCxrPVegmfFuoQqttnMu3I7nc+stnC1YiqwPVTnmlS3
   E59iuBsWgmr0mc87UlvHLR2weGDaLstGFVjtvDk131FZMN8sqFGKiWnng
   2qCEvjo+DlhJKzfe+azZoKbgPXF6g5RndcfPE4X+SruL0C0xGMZT6fg2O
   9AQwCsrN1upyw2APolYa6IRT1M+CTlbr/JJxyAAHqhaUclLFrCHbPtTCB
   Ys/WqZ8wWNpWSxRjStA8BMZNz9DEXhxpD4FQ8uOGxnVJIVSzG2NV21jhW
   4tIHKCcmlpsBMb06/mW2imSB4A2DUmUHGJCiuamJE86p5HZnw8SgQctGg
   Q==;
X-CSE-ConnectionGUID: T3nttad7Rf2fL8ZtvThEIA==
X-CSE-MsgGUID: Hly1Za2/QhW7bR5wvwXAKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43607529"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="43607529"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 09:36:07 -0800
X-CSE-ConnectionGUID: IsgYw56XS8mDr1ohmmSkXw==
X-CSE-MsgGUID: ZvhCikDwRjGFCCH0ZLETUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="91626381"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.193])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 09:36:04 -0800
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
	maciej.wieczor-retman@intel.com,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v5 3/3] selftests/lam: Test get_user() LAM pointer handling
Date: Wed, 27 Nov 2024 18:35:31 +0100
Message-ID: <df3790293723dff0b020deb4863828389eb41060.1732728879.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
References: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
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
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
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

 tools/testing/selftests/x86/lam.c | 102 ++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 4ec37a4be007..b602541e7bdf 100644
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
@@ -373,6 +382,72 @@ static int handle_syscall(struct testcases *test)
 	return ret;
 }
 
+static int get_user_syscall(struct testcases *test)
+{
+	uint64_t ptr_address, bitmask;
+	int fd, ret = 0;
+	void *ptr;
+
+	if (cpu_has_la57()) {
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
+	close(fd);
+error:
+	munmap(ptr, PAGE_SIZE);
+	return ret;
+}
+
 int sys_uring_setup(unsigned int entries, struct io_uring_params *p)
 {
 	return (int)syscall(__NR_io_uring_setup, entries, p);
@@ -886,6 +961,33 @@ static struct testcases syscall_cases[] = {
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


