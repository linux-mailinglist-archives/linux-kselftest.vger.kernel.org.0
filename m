Return-Path: <linux-kselftest+bounces-23009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF2E9E8F4A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3B3283A07
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB73121884A;
	Mon,  9 Dec 2024 09:51:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF43217F46;
	Mon,  9 Dec 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737866; cv=none; b=GeTd6ja27B25k10jEzxyxELEmrmzy4dX34x3jr9V6fCBuBadRlBMA39Z5R0YEsVcrNqrLusMQzjaEWq3uPSRl3A7vXl21Vfbk92G7uSwdrZ9NTvlYYgn6eJx5O949t3EJWYnHuxdOC+UgmHbuEkYrp0AAOBpnKVR+9gbfZW1T6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737866; c=relaxed/simple;
	bh=1rovK4xACo+Uae25R9N1cspFd1shrZb34V9Tm5s9LN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2mMmyji0u+5++YHI8uRAdzCdoKPd8fSAVuAF76AuIY4Y+nGxXytOnEDfJXk8mAnlAYXPpokCMbhwdgnOBCWzvKeAVmjWy58j0GaNGyrbOJKfP11IORE1C8Ld8N57nJFxF678mp86GRA8tjnjCPMc2jMlJo0yy0v/9+maaa/oCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A82F6143D;
	Mon,  9 Dec 2024 01:51:32 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E7263F720;
	Mon,  9 Dec 2024 01:51:02 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	aruna.ramakrishna@oracle.com,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 11/14] selftests/mm: Use sys_pkey helpers consistently
Date: Mon,  9 Dec 2024 09:50:16 +0000
Message-ID: <20241209095019.1732120-12-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209095019.1732120-1-kevin.brodsky@arm.com>
References: <20241209095019.1732120-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sys_pkey_alloc, sys_pkey_free and sys_mprotect_pkey are currently
used in protections_keys.c, while pkey_sighandler_tests.c calls the
libc wrappers directly (e.g. pkey_mprotect()). This is probably ok
when using glibc (those symbols appeared a while ago), but Musl does
not currently provide them. The logging in the helpers from
pkey-helpers.h can also come in handy.

Make things more consistent by using the sys_pkey helpers in
pkey_sighandler_tests.c too. To that end their implementation is
moved to a common .c file (pkey_util.c). This also enables calling
is_pkeys_supported() outside of protections_keys.c, since it relies
on sys_pkey_{alloc,free}.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/Makefile           |  4 +-
 tools/testing/selftests/mm/pkey-helpers.h     |  2 +
 .../selftests/mm/pkey_sighandler_tests.c      |  8 ++--
 tools/testing/selftests/mm/pkey_util.c        | 40 +++++++++++++++++++
 tools/testing/selftests/mm/protection_keys.c  | 35 ----------------
 5 files changed, 48 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_util.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 814b17a43385..1f0743d9459d 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -147,8 +147,8 @@ TEST_FILES += write_hugetlb_memory.sh
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS): vm_util.c thp_settings.c
-$(TEST_GEN_FILES): vm_util.c thp_settings.c
+$(TEST_GEN_PROGS): vm_util.c thp_settings.c pkey_util.c
+$(TEST_GEN_FILES): vm_util.c thp_settings.c pkey_util.c
 
 $(OUTPUT)/uffd-stress: uffd-common.c
 $(OUTPUT)/uffd-unit-tests: uffd-common.c
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 6f0ab7b42738..f080e97b39be 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -89,6 +89,8 @@ extern void abort_hooks(void);
 
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
+int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
+		unsigned long pkey);
 
 /* For functions called from protection_keys.c only */
 noinline int read_ptr(int *ptr);
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index e1aaeb65cfae..c73cee192b88 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -311,8 +311,8 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 	__write_pkey_reg(pkey_reg);
 
 	/* Protect the new stack with MPK 1 */
-	pkey = pkey_alloc(0, 0);
-	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
+	pkey = sys_pkey_alloc(0, 0);
+	sys_mprotect_pkey(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
 
 	/* Set up alternate signal stack that will use the default MPK */
 	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
@@ -484,8 +484,8 @@ static void test_pkru_sigreturn(void)
 	__write_pkey_reg(pkey_reg);
 
 	/* Protect the stack with MPK 2 */
-	pkey = pkey_alloc(0, 0);
-	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
+	pkey = sys_pkey_alloc(0, 0);
+	sys_mprotect_pkey(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
 
 	/* Set up alternate signal stack that will use the default MPK */
 	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
diff --git a/tools/testing/selftests/mm/pkey_util.c b/tools/testing/selftests/mm/pkey_util.c
new file mode 100644
index 000000000000..ca4ad0d44ab2
--- /dev/null
+++ b/tools/testing/selftests/mm/pkey_util.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "pkey-helpers.h"
+
+int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
+{
+	int ret = syscall(SYS_pkey_alloc, flags, init_val);
+	dprintf1("%s(flags=%lx, init_val=%lx) syscall ret: %d errno: %d\n",
+			__func__, flags, init_val, ret, errno);
+	return ret;
+}
+
+int sys_pkey_free(unsigned long pkey)
+{
+	int ret = syscall(SYS_pkey_free, pkey);
+	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
+	return ret;
+}
+
+int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
+		unsigned long pkey)
+{
+	int sret;
+
+	dprintf2("%s(0x%p, %zx, prot=%lx, pkey=%lx)\n", __func__,
+			ptr, size, orig_prot, pkey);
+
+	errno = 0;
+	sret = syscall(__NR_pkey_mprotect, ptr, size, orig_prot, pkey);
+	if (errno) {
+		dprintf2("SYS_mprotect_key sret: %d\n", sret);
+		dprintf2("SYS_mprotect_key prot: 0x%lx\n", orig_prot);
+		dprintf2("SYS_mprotect_key failed, errno: %d\n", errno);
+		if (DEBUG_LEVEL >= 2)
+			perror("SYS_mprotect_pkey");
+	}
+	return sret;
+}
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index f43cf3b75d8e..3688571e6b39 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -460,34 +460,6 @@ static pid_t fork_lazy_child(void)
 	return forkret;
 }
 
-int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
-		unsigned long pkey)
-{
-	int sret;
-
-	dprintf2("%s(0x%p, %zx, prot=%lx, pkey=%lx)\n", __func__,
-			ptr, size, orig_prot, pkey);
-
-	errno = 0;
-	sret = syscall(__NR_pkey_mprotect, ptr, size, orig_prot, pkey);
-	if (errno) {
-		dprintf2("SYS_mprotect_key sret: %d\n", sret);
-		dprintf2("SYS_mprotect_key prot: 0x%lx\n", orig_prot);
-		dprintf2("SYS_mprotect_key failed, errno: %d\n", errno);
-		if (DEBUG_LEVEL >= 2)
-			perror("SYS_mprotect_pkey");
-	}
-	return sret;
-}
-
-int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
-{
-	int ret = syscall(SYS_pkey_alloc, flags, init_val);
-	dprintf1("%s(flags=%lx, init_val=%lx) syscall ret: %d errno: %d\n",
-			__func__, flags, init_val, ret, errno);
-	return ret;
-}
-
 static int alloc_pkey(void)
 {
 	int ret;
@@ -534,13 +506,6 @@ static int alloc_pkey(void)
 	return ret;
 }
 
-int sys_pkey_free(unsigned long pkey)
-{
-	int ret = syscall(SYS_pkey_free, pkey);
-	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
-	return ret;
-}
-
 /*
  * I had a bug where pkey bits could be set by mprotect() but
  * not cleared.  This ensures we get lots of random bit sets
-- 
2.47.0


