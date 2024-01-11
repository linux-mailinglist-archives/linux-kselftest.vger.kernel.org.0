Return-Path: <linux-kselftest+bounces-2877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C866582B828
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 00:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E3D1F26155
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 23:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096A459B7F;
	Thu, 11 Jan 2024 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BVRlDzfO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CDA5A0FA
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso3873697a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 15:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705016551; x=1705621351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcYdXCkKdqehFzmOm+HXZie7w1W3pjKwit2K9GkDH9c=;
        b=BVRlDzfOYi1WbKHGZOaFOe8u74F9x66RupYOjQmSvNcMQuMaCeOZyM+74a6SaKXOvs
         5AziNV72P1IOkiicDsPorr0nv8F55MIgnNdPwRQ/9k7XuQpix4DusKN4PEE/jcxhd1QI
         Zr8Uy0SpvoW/A5cZ0hu2JfVO5c7EFH/gBBkPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705016551; x=1705621351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcYdXCkKdqehFzmOm+HXZie7w1W3pjKwit2K9GkDH9c=;
        b=B4u3Rqzu4LPJH9AjDgBO2i7MD94VzqYqFpqd1lf868FflrF+xQvskJAFc6KcJBd68E
         od63+3TZ4SR+aDHj+D8/FQC4ovcRLVX8VHpFVjotW2HqUYCs4Km/Txu0MJilkSJJl6y4
         uoQTCIoWtN0Hat4HBrxDg9s7dKvg/HOKEBNlcomPIwaFns6cmBOwu9OOnLRouPAdHPcM
         vQunTjDjxE1d0vRNfcLRKH3Lhsho/F2408CVICgVJK9QLuP0jTXpCYMUz9lb+YxphvHl
         9lgDAEnMKbL2MB7z2ZRCsYP+BfraGC9qIt/xHJFZ3Bfmz7NGm5ZKbGRWX16CFX2QtIwi
         7wmA==
X-Gm-Message-State: AOJu0YyVbdKGOfN8X44YMe+ZOp4UmUIK+ljEMMxg2AKrI9a2LN++SJKh
	Ux4J1d2pWXPheRrFfo9FEdmUDlG/X8VE
X-Google-Smtp-Source: AGHT+IHU75uJ0Wvg3lQHixUjmhlVAzf8wbMcd8tK8ycBFISwWk5LQrHICdK44djiru+r8Ycxv+OULg==
X-Received: by 2002:a17:90b:3b91:b0:28c:8477:3ef9 with SMTP id pc17-20020a17090b3b9100b0028c84773ef9mr590180pjb.60.1705016550750;
        Thu, 11 Jan 2024 15:42:30 -0800 (PST)
Received: from localhost (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.gmail.com with UTF8SMTPSA id ok6-20020a17090b1d4600b0028d3de92a08sm2293744pjb.48.2024.01.11.15.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 15:42:30 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	rdunlap@infradead.org
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	deraadt@openbsd.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v6 3/4] selftest mm/mseal memory sealing
Date: Thu, 11 Jan 2024 23:41:40 +0000
Message-ID: <20240111234142.2944934-4-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
In-Reply-To: <20240111234142.2944934-1-jeffxu@chromium.org>
References: <20240111234142.2944934-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

selftest for memory sealing change in mmap() and mseal().

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/.gitignore   |    1 +
 tools/testing/selftests/mm/Makefile     |    1 +
 tools/testing/selftests/mm/mseal_test.c | 1997 +++++++++++++++++++++++
 3 files changed, 1999 insertions(+)
 create mode 100644 tools/testing/selftests/mm/mseal_test.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 4ff10ea61461..76474c51c786 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -46,3 +46,4 @@ gup_longterm
 mkdirty
 va_high_addr_switch
 hugetlb_fault_after_madv
+mseal_test
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 2453add65d12..ba36a5c2b1fc 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -59,6 +59,7 @@ TEST_GEN_FILES += mlock2-tests
 TEST_GEN_FILES += mrelease_test
 TEST_GEN_FILES += mremap_dontunmap
 TEST_GEN_FILES += mremap_test
+TEST_GEN_FILES += mseal_test
 TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += pagemap_ioctl
 TEST_GEN_FILES += thuge-gen
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
new file mode 100644
index 000000000000..feb26b946358
--- /dev/null
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -0,0 +1,1997 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/mman.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <stdbool.h>
+#include "../kselftest.h"
+#include <syscall.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <fcntl.h>
+#include <assert.h>
+#include <sys/ioctl.h>
+#include <sys/vfs.h>
+#include <sys/stat.h>
+
+/*
+ * need those definition for manually build using gcc.
+ * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 mseal_test.c -o mseal_test
+ */
+#ifndef MAP_SEALABLE
+#define MAP_SEALABLE 0x8000000
+#endif
+
+#ifndef PROT_SEAL
+#define PROT_SEAL 0x04000000
+#endif
+
+#ifndef PKEY_DISABLE_ACCESS
+# define PKEY_DISABLE_ACCESS    0x1
+#endif
+
+#ifndef PKEY_DISABLE_WRITE
+# define PKEY_DISABLE_WRITE     0x2
+#endif
+
+#ifndef PKEY_BITS_PER_KEY
+#define PKEY_BITS_PER_PKEY      2
+#endif
+
+#ifndef PKEY_MASK
+#define PKEY_MASK       (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
+#endif
+
+#define FAIL_TEST_IF_FALSE(c) do {\
+		if (!(c)) {\
+			ksft_test_result_fail("%s, line:%d\n", __func__, __LINE__);\
+			goto test_end;\
+		} \
+	} \
+	while (0)
+
+#define SKIP_TEST_IF_FALSE(c) do {\
+		if (!(c)) {\
+			ksft_test_result_skip("%s, line:%d\n", __func__, __LINE__);\
+			goto test_end;\
+		} \
+	} \
+	while (0)
+
+
+#define TEST_END_CHECK() {\
+		ksft_test_result_pass("%s\n", __func__);\
+		return;\
+test_end:\
+		return;\
+}
+
+#ifndef u64
+#define u64 unsigned long long
+#endif
+
+static unsigned long get_vma_size(void *addr)
+{
+	FILE *maps;
+	char line[256];
+	int size = 0;
+	uintptr_t  addr_start, addr_end;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps)
+		return 0;
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (sscanf(line, "%lx-%lx", &addr_start, &addr_end) == 2) {
+			if (addr_start == (uintptr_t) addr) {
+				size = addr_end - addr_start;
+				break;
+			}
+		}
+	}
+	fclose(maps);
+	return size;
+}
+
+/*
+ * define sys_xyx to call syscall directly.
+ */
+static int sys_mseal(void *start, size_t len)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(__NR_mseal, start, len, 0);
+	return sret;
+}
+
+static int sys_mprotect(void *ptr, size_t size, unsigned long prot)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(SYS_mprotect, ptr, size, prot);
+	return sret;
+}
+
+static int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
+		unsigned long pkey)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(__NR_pkey_mprotect, ptr, size, orig_prot, pkey);
+	return sret;
+}
+
+static void *sys_mmap(void *addr, unsigned long len, unsigned long prot,
+	unsigned long flags, unsigned long fd, unsigned long offset)
+{
+	void *sret;
+
+	errno = 0;
+	sret = (void *) syscall(__NR_mmap, addr, len, prot,
+		flags, fd, offset);
+	return sret;
+}
+
+static int sys_munmap(void *ptr, size_t size)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(SYS_munmap, ptr, size);
+	return sret;
+}
+
+static int sys_madvise(void *start, size_t len, int types)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(__NR_madvise, start, len, types);
+	return sret;
+}
+
+static int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
+{
+	int ret = syscall(SYS_pkey_alloc, flags, init_val);
+
+	return ret;
+}
+
+static unsigned int __read_pkey_reg(void)
+{
+	unsigned int eax, edx;
+	unsigned int ecx = 0;
+	unsigned int pkey_reg;
+
+	asm volatile(".byte 0x0f,0x01,0xee\n\t"
+			: "=a" (eax), "=d" (edx)
+			: "c" (ecx));
+	pkey_reg = eax;
+	return pkey_reg;
+}
+
+static void __write_pkey_reg(u64 pkey_reg)
+{
+	unsigned int eax = pkey_reg;
+	unsigned int ecx = 0;
+	unsigned int edx = 0;
+
+	asm volatile(".byte 0x0f,0x01,0xef\n\t"
+			: : "a" (eax), "c" (ecx), "d" (edx));
+	assert(pkey_reg == __read_pkey_reg());
+}
+
+static unsigned long pkey_bit_position(int pkey)
+{
+	return pkey * PKEY_BITS_PER_PKEY;
+}
+
+static u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
+{
+	unsigned long shift = pkey_bit_position(pkey);
+
+	/* mask out bits from pkey in old value */
+	reg &= ~((u64)PKEY_MASK << shift);
+	/* OR in new bits for pkey */
+	reg |= (flags & PKEY_MASK) << shift;
+	return reg;
+}
+
+static void set_pkey(int pkey, unsigned long pkey_value)
+{
+	unsigned long mask = (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
+	u64 new_pkey_reg;
+
+	assert(!(pkey_value & ~mask));
+	new_pkey_reg = set_pkey_bits(__read_pkey_reg(), pkey, pkey_value);
+	__write_pkey_reg(new_pkey_reg);
+}
+
+static void setup_single_address(int size, void **ptrOut)
+{
+	void *ptr;
+
+	ptr = sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE | MAP_SEALABLE, -1, 0);
+	assert(ptr != (void *)-1);
+	*ptrOut = ptr;
+}
+
+static void setup_single_address_rw_sealable(int size, void **ptrOut, bool sealable)
+{
+	void *ptr;
+	unsigned long mapflags = MAP_ANONYMOUS | MAP_PRIVATE;
+
+	if (sealable)
+		mapflags |= MAP_SEALABLE;
+
+	ptr = sys_mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1, 0);
+	assert(ptr != (void *)-1);
+	*ptrOut = ptr;
+}
+
+static void clean_single_address(void *ptr, int size)
+{
+	int ret;
+
+	ret = munmap(ptr, size);
+	assert(!ret);
+}
+
+static void seal_single_address(void *ptr, int size)
+{
+	int ret;
+
+	ret = sys_mseal(ptr, size);
+	assert(!ret);
+}
+
+bool seal_support(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+
+	ptr = sys_mmap(NULL, page_size, PROT_READ | PROT_SEAL, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (ptr == (void *) -1)
+		return false;
+
+	ret = sys_mseal(ptr, page_size);
+	if (ret < 0)
+		return false;
+
+	return true;
+}
+
+bool pkey_supported(void)
+{
+	int pkey = sys_pkey_alloc(0, 0);
+
+	if (pkey > 0)
+		return true;
+	return false;
+}
+
+static void test_seal_addseal(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	ret = sys_mseal(ptr, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_unmapped_start(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	/* munmap 2 pages from ptr. */
+	ret = sys_munmap(ptr, 2 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* mprotect will fail because 2 pages from ptr are unmapped. */
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* mseal will fail because 2 pages from ptr are unmapped. */
+	ret = sys_mseal(ptr, size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	ret = sys_mseal(ptr + 2 * page_size, 2 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_unmapped_middle(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	/* munmap 2 pages from ptr + page. */
+	ret = sys_munmap(ptr + page_size, 2 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* mprotect will fail, since middle 2 pages are unmapped. */
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* mseal will fail as well. */
+	ret = sys_mseal(ptr, size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* we still can add seal to the first page and last page*/
+	ret = sys_mseal(ptr, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_mseal(ptr + 3 * page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_unmapped_end(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	/* unmap last 2 pages. */
+	ret = sys_munmap(ptr + 2 * page_size, 2 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* mprotect will fail since last 2 pages are unmapped. */
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* mseal will fail as well. */
+	ret = sys_mseal(ptr, size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* The first 2 pages is not sealed, and can add seals */
+	ret = sys_mseal(ptr, 2 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_multiple_vmas(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split the vma into 3. */
+	ret = sys_mprotect(ptr + page_size, 2 * page_size,
+			PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* mprotect will get applied to all 4 pages - 3 VMAs. */
+	ret = sys_mprotect(ptr, size, PROT_READ);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* use mprotect to split the vma into 3. */
+	ret = sys_mprotect(ptr + page_size, 2 * page_size,
+			PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* mseal get applied to all 4 pages - 3 VMAs. */
+	ret = sys_mseal(ptr, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_split_start(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split at middle */
+	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* seal the first page, this will split the VMA */
+	ret = sys_mseal(ptr, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* add seal to the remain 3 pages */
+	ret = sys_mseal(ptr + page_size, 3 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_split_end(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split at middle */
+	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* seal the last page */
+	ret = sys_mseal(ptr + 3 * page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* Adding seals to the first 3 pages */
+	ret = sys_mseal(ptr, 3 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_invalid_input(void)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(8 * page_size, &ptr);
+	clean_single_address(ptr + 4 * page_size, 4 * page_size);
+
+	/* invalid flag */
+	ret = syscall(__NR_mseal, ptr, size, 0x20);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* unaligned address */
+	ret = sys_mseal(ptr + 1, 2 * page_size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* length too big */
+	ret = sys_mseal(ptr, 5 * page_size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* length overflow */
+	ret = sys_mseal(ptr, UINT64_MAX/page_size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* start is not in a valid VMA */
+	ret = sys_mseal(ptr - page_size, 5 * page_size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_zero_length(void)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	ret = sys_mprotect(ptr, 0, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* seal 0 length will be OK, same as mprotect */
+	ret = sys_mseal(ptr, 0);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* verify the 4 pages are not sealed by previous call. */
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_twice(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	ret = sys_mseal(ptr, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* apply the same seal will be OK. idempotent. */
+	ret = sys_mseal(ptr, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mprotect(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	if (seal)
+		seal_single_address(ptr, size);
+
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_start_mprotect(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	if (seal)
+		seal_single_address(ptr, page_size);
+
+	/* the first page is sealed. */
+	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	/* pages after the first page is not sealed. */
+	ret = sys_mprotect(ptr + page_size, page_size * 3,
+			PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_end_mprotect(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	if (seal)
+		seal_single_address(ptr + page_size, 3 * page_size);
+
+	/* first page is not sealed */
+	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* last 3 page are sealed */
+	ret = sys_mprotect(ptr + page_size, page_size * 3,
+			PROT_READ | PROT_WRITE);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mprotect_unalign_len(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	if (seal)
+		seal_single_address(ptr, page_size * 2 - 1);
+
+	/* 2 pages are sealed. */
+	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_mprotect(ptr + page_size * 2, page_size,
+			PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mprotect_unalign_len_variant_2(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+	if (seal)
+		seal_single_address(ptr, page_size * 2 + 1);
+
+	/* 3 pages are sealed. */
+	ret = sys_mprotect(ptr, page_size * 3, PROT_READ | PROT_WRITE);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_mprotect(ptr + page_size * 3, page_size,
+			PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mprotect_two_vma(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split */
+	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	if (seal)
+		seal_single_address(ptr, page_size * 4);
+
+	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_mprotect(ptr + page_size * 2, page_size * 2,
+			PROT_READ | PROT_WRITE);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mprotect_two_vma_with_split(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split as two vma. */
+	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* mseal can apply across 2 vma, also split them. */
+	if (seal)
+		seal_single_address(ptr + page_size, page_size * 2);
+
+	/* the first page is not sealed. */
+	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* the second page is sealed. */
+	ret = sys_mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	/* the third page is sealed. */
+	ret = sys_mprotect(ptr + 2 * page_size, page_size,
+			PROT_READ | PROT_WRITE);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	/* the fouth page is not sealed. */
+	ret = sys_mprotect(ptr + 3 * page_size, page_size,
+			PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mprotect_partial_mprotect(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* seal one page. */
+	if (seal)
+		seal_single_address(ptr, page_size);
+
+	/* mprotect first 2 page will fail, since the first page are sealed. */
+	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mprotect_two_vma_with_gap(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split. */
+	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* use mprotect to split. */
+	ret = sys_mprotect(ptr + 3 * page_size, page_size,
+			PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* use munmap to free two pages in the middle */
+	ret = sys_munmap(ptr + page_size, 2 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* mprotect will fail, because there is a gap in the address. */
+	/* notes, internally mprotect still updated the first page. */
+	ret = sys_mprotect(ptr, 4 * page_size, PROT_READ);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* mseal will fail as well. */
+	ret = sys_mseal(ptr, 4 * page_size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* the first page is not sealed. */
+	ret = sys_mprotect(ptr, page_size, PROT_READ);
+	FAIL_TEST_IF_FALSE(ret == 0);
+
+	/* the last page is not sealed. */
+	ret = sys_mprotect(ptr + 3 * page_size, page_size, PROT_READ);
+	FAIL_TEST_IF_FALSE(ret == 0);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mprotect_split(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split. */
+	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* seal all 4 pages. */
+	if (seal) {
+		ret = sys_mseal(ptr, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* mprotect is sealed. */
+	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+
+	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_READ);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mprotect_merge(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split one page. */
+	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* seal first two pages. */
+	if (seal) {
+		ret = sys_mseal(ptr, 2 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* 2 pages are sealed. */
+	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	/* last 2 pages are not sealed. */
+	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_READ);
+	FAIL_TEST_IF_FALSE(ret == 0);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_munmap(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* 4 pages are sealed. */
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+/*
+ * allocate 4 pages,
+ * use mprotect to split it as two VMAs
+ * seal the whole range
+ * munmap will fail on both
+ */
+static void test_seal_munmap_two_vma(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split */
+	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	ret = sys_munmap(ptr, page_size * 2);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_munmap(ptr + page_size, page_size * 2);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+/*
+ * allocate a VMA with 4 pages.
+ * munmap the middle 2 pages.
+ * seal the whole 4 pages, will fail.
+ * note: one of the pages are sealed
+ * munmap the first page will be OK.
+ * munmap the last page will be OK.
+ */
+static void test_seal_munmap_vma_with_gap(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	ret = sys_munmap(ptr + page_size, page_size * 2);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	if (seal) {
+		/* can't have gap in the middle. */
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(ret < 0);
+	}
+
+	ret = sys_munmap(ptr, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_munmap(ptr + page_size * 2, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_munmap(ptr, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_munmap_start_freed(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* unmap the first page. */
+	ret = sys_munmap(ptr, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* seal the last 3 pages. */
+	if (seal) {
+		ret = sys_mseal(ptr + page_size, 3 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* unmap from the first page. */
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		/* note: this will be OK, even the first page is */
+		/* already unmapped. */
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_munmap_end_freed(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+	/* unmap last page. */
+	ret = sys_munmap(ptr + page_size * 3, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* seal the first 3 pages. */
+	if (seal) {
+		ret = sys_mseal(ptr, 3 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* unmap all pages. */
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_munmap_middle_freed(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+	/* unmap 2 pages in the middle. */
+	ret = sys_munmap(ptr + page_size, page_size * 2);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* seal the first page. */
+	if (seal) {
+		ret = sys_mseal(ptr, page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* munmap all 4 pages. */
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mremap_shrink(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* shrink from 4 pages to 2 pages. */
+	ret2 = mremap(ptr, size, 2 * page_size, 0, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EACCES);
+	} else {
+		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
+
+	}
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mremap_expand(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+	/* ummap last 2 pages. */
+	ret = sys_munmap(ptr + 2 * page_size, 2 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	if (seal) {
+		ret = sys_mseal(ptr, 2 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* expand from 2 page to 4 pages. */
+	ret2 = mremap(ptr, 2 * page_size, 4 * page_size, 0, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EACCES);
+	} else {
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+	}
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mremap_move(bool seal)
+{
+	void *ptr, *newPtr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+	setup_single_address(size, &newPtr);
+	clean_single_address(newPtr, size);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* move from ptr to fixed address. */
+	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newPtr);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EACCES);
+	} else {
+		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
+
+	}
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mmap_overwrite_prot(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* use mmap to change protection. */
+	ret2 = sys_mmap(ptr, size, PROT_NONE,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EACCES);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mmap_expand(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+	/* ummap last 4 pages. */
+	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	if (seal) {
+		ret = sys_mseal(ptr, 8 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* use mmap to expand. */
+	ret2 = sys_mmap(ptr, size, PROT_READ,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EACCES);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mmap_shrink(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* use mmap to shrink. */
+	ret2 = sys_mmap(ptr, 8 * page_size, PROT_READ,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EACCES);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mremap_shrink_fixed(bool seal)
+{
+	void *ptr;
+	void *newAddr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+	setup_single_address(size, &newAddr);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* mremap to move and shrink to fixed address */
+	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+			newAddr);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EACCES);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 == newAddr);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mremap_expand_fixed(bool seal)
+{
+	void *ptr;
+	void *newAddr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(page_size, &ptr);
+	setup_single_address(size, &newAddr);
+
+	if (seal) {
+		ret = sys_mseal(newAddr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* mremap to move and expand to fixed address */
+	ret2 = mremap(ptr, page_size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
+			newAddr);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EACCES);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 == newAddr);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mremap_move_fixed(bool seal)
+{
+	void *ptr;
+	void *newAddr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+	setup_single_address(size, &newAddr);
+
+	if (seal) {
+		ret = sys_mseal(newAddr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* mremap to move to fixed address */
+	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newAddr);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EACCES);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 == newAddr);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mremap_move_fixed_zero(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/*
+	 * MREMAP_FIXED can move the mapping to zero address
+	 */
+	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+			0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EACCES);
+	} else {
+		FAIL_TEST_IF_FALSE(ret2 == 0);
+
+	}
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mremap_move_dontunmap(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* mremap to move, and don't unmap src addr. */
+	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EACCES);
+	} else {
+		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
+
+	}
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/*
+	 * The 0xdeaddead should not have effect on dest addr
+	 * when MREMAP_DONTUNMAP is set.
+	 */
+	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
+			0xdeaddead);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EACCES);
+	} else {
+		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
+		FAIL_TEST_IF_FALSE((long)ret2 != 0xdeaddead);
+
+	}
+
+	TEST_END_CHECK();
+}
+
+
+static void test_seal_mmap_seal(void)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	ptr = sys_mmap(NULL, size, PROT_READ | PROT_SEAL, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = sys_munmap(ptr, size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_merge_and_split(void)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size;
+	int ret;
+
+	/* (24 RO) */
+	setup_single_address(24 * page_size, &ptr);
+
+	/* use mprotect(NONE) to set out boundary */
+	/* (1 NONE) (22 RO) (1 NONE) */
+	ret = sys_mprotect(ptr, page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+	ret = sys_mprotect(ptr + 23 * page_size, page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr + page_size);
+	FAIL_TEST_IF_FALSE(size == 22 * page_size);
+
+	/* use mseal to split from beginning */
+	/* (1 NONE) (1 RO_SEAL) (21 RO) (1 NONE) */
+	ret = sys_mseal(ptr + page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr + page_size);
+	FAIL_TEST_IF_FALSE(size == page_size);
+	size = get_vma_size(ptr + 2 * page_size);
+	FAIL_TEST_IF_FALSE(size == 21 * page_size);
+
+	/* use mseal to split from the end. */
+	/* (1 NONE) (1 RO_SEAL) (20 RO) (1 RO_SEAL) (1 NONE) */
+	ret = sys_mseal(ptr + 22 * page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr + 22 * page_size);
+	FAIL_TEST_IF_FALSE(size == page_size);
+	size = get_vma_size(ptr + 2 * page_size);
+	FAIL_TEST_IF_FALSE(size == 20 * page_size);
+
+	/* merge with prev. */
+	/* (1 NONE) (2 RO_SEAL) (19 RO) (1 RO_SEAL) (1 NONE) */
+	ret = sys_mseal(ptr + 2 * page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr +  page_size);
+	FAIL_TEST_IF_FALSE(size ==  2 * page_size);
+
+	/* merge with after. */
+	/* (1 NONE) (2 RO_SEAL) (18 RO) (2 RO_SEALS) (1 NONE) */
+	ret = sys_mseal(ptr + 21 * page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr +  21 * page_size);
+	FAIL_TEST_IF_FALSE(size ==  2 * page_size);
+
+	/* split and merge from prev */
+	/* (1 NONE) (3 RO_SEAL) (17 RO) (2 RO_SEALS) (1 NONE) */
+	ret = sys_mseal(ptr + 2 * page_size, 2 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr +  1 * page_size);
+	FAIL_TEST_IF_FALSE(size ==  3 * page_size);
+	ret = sys_munmap(ptr + page_size,  page_size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+	ret = sys_mprotect(ptr + 2 * page_size, page_size,  PROT_NONE);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* split and merge from next */
+	/* (1 NONE) (3 RO_SEAL) (16 RO) (3 RO_SEALS) (1 NONE) */
+	ret = sys_mseal(ptr + 20 * page_size, 2 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr +  20 * page_size);
+	FAIL_TEST_IF_FALSE(size ==  3 * page_size);
+
+	/* merge from middle of prev and middle of next. */
+	/* (1 NONE) (22 RO_SEAL) (1 NONE) */
+	ret = sys_mseal(ptr + 2 * page_size, 20 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr +  page_size);
+	FAIL_TEST_IF_FALSE(size ==  22 * page_size);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_mmap_merge(void)
+{
+
+	void *ptr, *ptr2;
+	unsigned long page_size = getpagesize();
+	unsigned long size;
+	int ret;
+
+	/* (24 RO) */
+	setup_single_address(24 * page_size, &ptr);
+
+	/* use mprotect(NONE) to set out boundary */
+	/* (1 NONE) (22 RO) (1 NONE) */
+	ret = sys_mprotect(ptr, page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+	ret = sys_mprotect(ptr + 23 * page_size, page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr + page_size);
+	FAIL_TEST_IF_FALSE(size == 22 * page_size);
+
+	/* use munmap to free 2 segment of memory. */
+	/* (1 NONE) (1 free) (20 RO) (1 free) (1 NONE) */
+	ret = sys_munmap(ptr + page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_munmap(ptr + 22 * page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* apply seal to the middle */
+	/* (1 NONE) (1 free) (20 RO_SEAL) (1 free) (1 NONE) */
+	ret = sys_mseal(ptr + 2 * page_size, 20 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr + 2 * page_size);
+	FAIL_TEST_IF_FALSE(size == 20 * page_size);
+
+	/* allocate a mapping at beginning, and make sure it merges. */
+	/* (1 NONE) (21 RO_SEAL) (1 free) (1 NONE) */
+	ptr2 = sys_mmap(ptr + page_size, page_size, PROT_READ | PROT_SEAL,
+		MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+	size = get_vma_size(ptr + page_size);
+	FAIL_TEST_IF_FALSE(size == 21 * page_size);
+
+	/* allocate a mapping at end, and make sure it merges. */
+	/* (1 NONE) (22 RO_SEAL) (1 NONE) */
+	ptr2 = sys_mmap(ptr + 22 * page_size, page_size, PROT_READ | PROT_SEAL,
+		MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+	size = get_vma_size(ptr + page_size);
+	FAIL_TEST_IF_FALSE(size == 22 * page_size);
+
+	TEST_END_CHECK();
+}
+
+static void test_not_sealable(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	ptr = sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = sys_mseal(ptr, size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	TEST_END_CHECK();
+}
+
+static void test_mmap_fixed_change_to_sealable(void)
+{
+	int ret;
+	void *ptr, *ptr2;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	ptr = sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = sys_mseal(ptr, size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	ptr2 = sys_mmap(ptr, size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_SEALABLE, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr2 == ptr);
+
+	ret = sys_mseal(ptr, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_mmap_fixed_change_to_not_sealable(void)
+{
+	int ret;
+	void *ptr, *ptr2;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	ptr = sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE | MAP_SEALABLE, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ptr2 = sys_mmap(ptr, size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr2 == ptr);
+
+	ret = sys_mseal(ptr, size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	TEST_END_CHECK();
+}
+
+static void test_merge_sealable(void)
+{
+	int ret;
+	void *ptr, *ptr2;
+	unsigned long page_size = getpagesize();
+	unsigned long size;
+
+	/* (24 RO) */
+	setup_single_address(24 * page_size, &ptr);
+
+	/* use mprotect(NONE) to set out boundary */
+	/* (1 NONE) (22 RO) (1 NONE) */
+	ret = sys_mprotect(ptr, page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+	ret = sys_mprotect(ptr + 23 * page_size, page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr + page_size);
+	FAIL_TEST_IF_FALSE(size == 22 * page_size);
+
+	/* (1 NONE) (RO) (4 free) (17 RO) (1 NONE) */
+	ret = sys_munmap(ptr + 2 * page_size,  4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr + page_size);
+	FAIL_TEST_IF_FALSE(size == 1 * page_size);
+	size = get_vma_size(ptr +  6 * page_size);
+	FAIL_TEST_IF_FALSE(size == 17 * page_size);
+
+	/* (1 NONE) (RO) (1 free) (2 RO) (1 free) (17 RO) (1 NONE) */
+	ptr2 = sys_mmap(ptr + 3 * page_size, 2 * page_size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_SEALABLE, -1, 0);
+	size = get_vma_size(ptr + 3 * page_size);
+	FAIL_TEST_IF_FALSE(size == 2 * page_size);
+
+	/* (1 NONE) (RO) (1 free) (20 RO) (1 NONE) */
+	ptr2 = sys_mmap(ptr + 5 * page_size, 1 * page_size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_SEALABLE, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+	size = get_vma_size(ptr + 3 * page_size);
+	FAIL_TEST_IF_FALSE(size == 20 * page_size);
+
+	/* (1 NONE) (RO) (1 free) (19 RO) (1 RO_SEAL) (1 NONE) */
+	ret = sys_mseal(ptr + 22 * page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* (1 NONE) (RO) (not sealable) (19 RO) (1 RO_SEAL) (1 NONE) */
+	ptr2 = sys_mmap(ptr + 2 * page_size, page_size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+	size = get_vma_size(ptr + page_size);
+	FAIL_TEST_IF_FALSE(size == page_size);
+	size = get_vma_size(ptr + 2 * page_size);
+	FAIL_TEST_IF_FALSE(size == page_size);
+
+	/* (1 NONE) (1 free) (1 NOT_SEALABLE) (19 free) (1 RO_SEAL) (1 NONE) */
+	ret = sys_munmap(ptr + page_size,  page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	ret = sys_munmap(ptr + 3 * page_size,  19 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* (1 NONE) (2 NOT_SEALABLE) (19 free) (1 RO_SEAL) (1 NONE) */
+	ptr2 = sys_mmap(ptr + page_size, page_size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+	size = get_vma_size(ptr + page_size);
+	FAIL_TEST_IF_FALSE(size == 2 * page_size);
+
+	/* (1 NONE) (21 NOT_SEALABLE)(1 RO_SEAL) (1 NONE) */
+	ptr2 = sys_mmap(ptr + 3 * page_size, 19 * page_size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+	size = get_vma_size(ptr + page_size);
+	FAIL_TEST_IF_FALSE(size == 21 * page_size);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_discard_ro_anon_on_rw(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address_rw_sealable(size, &ptr, seal);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* sealing doesn't take effect on RW memory. */
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* base seal still apply. */
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_discard_ro_anon_on_pkey(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	int pkey;
+
+	SKIP_TEST_IF_FALSE(pkey_supported());
+
+	setup_single_address_rw_sealable(size, &ptr, seal);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	pkey = sys_pkey_alloc(0, 0);
+	FAIL_TEST_IF_FALSE(pkey > 0);
+
+	ret = sys_mprotect_pkey((void *)ptr, size, PROT_READ | PROT_WRITE, pkey);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* sealing doesn't take effect if PKRU allow write. */
+	set_pkey(pkey, 0);
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* sealing will take effect if PKRU deny write. */
+	set_pkey(pkey, PKEY_DISABLE_WRITE);
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	/* base seal still apply. */
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_discard_ro_anon_on_filebacked(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	int fd;
+	unsigned long mapflags = MAP_PRIVATE;
+
+	if (seal)
+		mapflags |= MAP_SEALABLE;
+
+	fd = memfd_create("test", 0);
+	FAIL_TEST_IF_FALSE(fd > 0);
+
+	ret = fallocate(fd, 0, 0, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ptr = sys_mmap(NULL, size, PROT_READ, mapflags, fd, 0);
+	FAIL_TEST_IF_FALSE(ptr != MAP_FAILED);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* sealing doesn't apply for file backed mapping. */
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+	close(fd);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_discard_ro_anon_on_shared(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	unsigned long mapflags = MAP_ANONYMOUS | MAP_SHARED;
+
+	if (seal)
+		mapflags |= MAP_SEALABLE;
+
+	ptr = sys_mmap(NULL, size, PROT_READ, mapflags, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* sealing doesn't apply for shared mapping. */
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+static void test_seal_discard_ro_anon(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	if (seal)
+		seal_single_address(ptr, size);
+
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		FAIL_TEST_IF_FALSE(ret < 0);
+	else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	TEST_END_CHECK();
+}
+
+int main(int argc, char **argv)
+{
+	bool test_seal = seal_support();
+
+	ksft_print_header();
+
+	if (!test_seal)
+		ksft_exit_skip("sealing not supported, check CONFIG_64BIT\n");
+
+	if (!pkey_supported())
+		ksft_print_msg("PKEY not supported\n");
+
+	ksft_set_plan(85);
+
+	test_seal_addseal();
+	test_seal_unmapped_start();
+	test_seal_unmapped_middle();
+	test_seal_unmapped_end();
+	test_seal_multiple_vmas();
+	test_seal_split_start();
+	test_seal_split_end();
+	test_seal_invalid_input();
+	test_seal_zero_length();
+	test_seal_twice();
+
+	test_seal_mprotect(false);
+	test_seal_mprotect(true);
+
+	test_seal_start_mprotect(false);
+	test_seal_start_mprotect(true);
+
+	test_seal_end_mprotect(false);
+	test_seal_end_mprotect(true);
+
+	test_seal_mprotect_unalign_len(false);
+	test_seal_mprotect_unalign_len(true);
+
+	test_seal_mprotect_unalign_len_variant_2(false);
+	test_seal_mprotect_unalign_len_variant_2(true);
+
+	test_seal_mprotect_two_vma(false);
+	test_seal_mprotect_two_vma(true);
+
+	test_seal_mprotect_two_vma_with_split(false);
+	test_seal_mprotect_two_vma_with_split(true);
+
+	test_seal_mprotect_partial_mprotect(false);
+	test_seal_mprotect_partial_mprotect(true);
+
+	test_seal_mprotect_two_vma_with_gap(false);
+	test_seal_mprotect_two_vma_with_gap(true);
+
+	test_seal_mprotect_merge(false);
+	test_seal_mprotect_merge(true);
+
+	test_seal_mprotect_split(false);
+	test_seal_mprotect_split(true);
+
+	test_seal_munmap(false);
+	test_seal_munmap(true);
+	test_seal_munmap_two_vma(false);
+	test_seal_munmap_two_vma(true);
+	test_seal_munmap_vma_with_gap(false);
+	test_seal_munmap_vma_with_gap(true);
+
+	test_munmap_start_freed(false);
+	test_munmap_start_freed(true);
+	test_munmap_middle_freed(false);
+	test_munmap_middle_freed(true);
+	test_munmap_end_freed(false);
+	test_munmap_end_freed(true);
+
+	test_seal_mremap_shrink(false);
+	test_seal_mremap_shrink(true);
+	test_seal_mremap_expand(false);
+	test_seal_mremap_expand(true);
+	test_seal_mremap_move(false);
+	test_seal_mremap_move(true);
+
+	test_seal_mremap_shrink_fixed(false);
+	test_seal_mremap_shrink_fixed(true);
+	test_seal_mremap_expand_fixed(false);
+	test_seal_mremap_expand_fixed(true);
+	test_seal_mremap_move_fixed(false);
+	test_seal_mremap_move_fixed(true);
+	test_seal_mremap_move_dontunmap(false);
+	test_seal_mremap_move_dontunmap(true);
+	test_seal_mremap_move_fixed_zero(false);
+	test_seal_mremap_move_fixed_zero(true);
+	test_seal_mremap_move_dontunmap_anyaddr(false);
+	test_seal_mremap_move_dontunmap_anyaddr(true);
+	test_seal_discard_ro_anon(false);
+	test_seal_discard_ro_anon(true);
+	test_seal_discard_ro_anon_on_rw(false);
+	test_seal_discard_ro_anon_on_rw(true);
+	test_seal_discard_ro_anon_on_shared(false);
+	test_seal_discard_ro_anon_on_shared(true);
+	test_seal_discard_ro_anon_on_filebacked(false);
+	test_seal_discard_ro_anon_on_filebacked(true);
+	test_seal_mmap_overwrite_prot(false);
+	test_seal_mmap_overwrite_prot(true);
+	test_seal_mmap_expand(false);
+	test_seal_mmap_expand(true);
+	test_seal_mmap_shrink(false);
+	test_seal_mmap_shrink(true);
+
+	test_seal_mmap_seal();
+	test_seal_merge_and_split();
+	test_seal_mmap_merge();
+
+	test_not_sealable();
+	test_merge_sealable();
+	test_mmap_fixed_change_to_sealable();
+	test_mmap_fixed_change_to_not_sealable();
+
+	test_seal_discard_ro_anon_on_pkey(false);
+	test_seal_discard_ro_anon_on_pkey(true);
+
+	ksft_finished();
+	return 0;
+}
-- 
2.43.0.275.g3460e3d667-goog


