Return-Path: <linux-kselftest+bounces-2756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0DA828938
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 16:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395121F255A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8463A1DF;
	Tue,  9 Jan 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j/1bOdps"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063339FFA
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jan 2024 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d426ad4433so15285735ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jan 2024 07:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704815164; x=1705419964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuOQWclETKGPsdHEQB013zpnSgE6/I93Y6G9VS4QK3Y=;
        b=j/1bOdpsSSlrEuq4hMxkivfjgib/N7KTad3cqZFZEAOC6pHXBYQHPsvOzF89mY0HPe
         rhPKSlKZAu8/jaqZTTKh43En9hrpEVaR2VUok35Dz1iAzDGDb+Fq7QSOV/rVvrYieB3y
         wTPVYpgBBQfVuALLcxz+TBbfRxke4ixuAWmW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704815164; x=1705419964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuOQWclETKGPsdHEQB013zpnSgE6/I93Y6G9VS4QK3Y=;
        b=qpjjizWDf2ycfePc8AHBEriFcj1sENLAV3RFFQsLeMMzMsdh7vhokrUj8KL1N2pG6q
         SRMPzRIPPzBvnaFqVKZP09Chw+YC+cCgBSZf7lFfx8PulNsh0Zti1OyDUCvwC6Y+3cEj
         r06o75vU6VxJiW6v83tLZD0H2JHl11+LOzJCjy0/W//fk0UMkAUTP4nxPzdizVkrAHs7
         zRgSXYDAfVZjrdPj7wsJT7lpsgvsPIOMmFAb1AhqZ1rs78KsAnLRNIRZOFlYNIXwwXzR
         ELjUQ2YA6oYfgmrd8lJa15MM8OiLnR5OR6JY/eUgA6rZyXMxWIs5dcDjXlZ+4s2ZP97P
         OnYw==
X-Gm-Message-State: AOJu0YxUTSD1NGqklUCtvc+LoLgF4Uv964/GqOsZM24YIWIvtW+ES8Gp
	mfJpUa5x1ojdLN0hqAi7WoYnVU8L/e2N
X-Google-Smtp-Source: AGHT+IE0FZ/h6ROF2YCoOYADtNCyaALgFMxItzDLDD9ZpzcOR0kIFI02UMQE+E5t9WN32KQ6xbARcA==
X-Received: by 2002:a17:902:a50a:b0:1d4:bcf0:560e with SMTP id s10-20020a170902a50a00b001d4bcf0560emr2929094plq.31.1704815164266;
        Tue, 09 Jan 2024 07:46:04 -0800 (PST)
Received: from localhost (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.gmail.com with UTF8SMTPSA id q1-20020a170902bd8100b001d06b63bb98sm1946721pls.71.2024.01.09.07.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 07:46:03 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com
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
Subject: [RFC PATCH v5 3/4] selftest mm/mseal memory sealing
Date: Tue,  9 Jan 2024 15:45:41 +0000
Message-ID: <20240109154547.1839886-4-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.195.gebba966016-goog
In-Reply-To: <20240109154547.1839886-1-jeffxu@chromium.org>
References: <20240109154547.1839886-1-jeffxu@chromium.org>
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
 tools/testing/selftests/mm/mseal_test.c | 1989 +++++++++++++++++++++++
 3 files changed, 1991 insertions(+)
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
index dede0bcf97a3..652c07ff81f5 100644
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
index 000000000000..c42f5f31f974
--- /dev/null
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -0,0 +1,1989 @@
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
+#ifndef DEBUG
+#define LOG_TEST_ENTER()	{}
+#else
+#define LOG_TEST_ENTER()	{ksft_print_msg("%s\n", __func__); }
+#endif
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
+static void setup_single_address_sealable(int size, void **ptrOut, bool sealable)
+{
+	void *ptr;
+	unsigned long mapflags = MAP_ANONYMOUS | MAP_PRIVATE;
+
+	if (sealable)
+		mapflags |= MAP_SEALABLE;
+
+	ptr = sys_mmap(NULL, size, PROT_READ, mapflags, -1, 0);
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
+static void test_seal_addseal(void)
+{
+	LOG_TEST_ENTER();
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	ret = sys_mseal(ptr, size);
+	assert(!ret);
+}
+
+static void test_seal_unmapped_start(void)
+{
+	LOG_TEST_ENTER();
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	/* munmap 2 pages from ptr. */
+	ret = sys_munmap(ptr, 2 * page_size);
+	assert(!ret);
+
+	/* mprotect will fail because 2 pages from ptr are unmapped. */
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	assert(ret < 0);
+
+	/* mseal will fail because 2 pages from ptr are unmapped. */
+	ret = sys_mseal(ptr, size);
+	assert(ret < 0);
+
+	ret = sys_mseal(ptr + 2 * page_size, 2 * page_size);
+	assert(!ret);
+}
+
+static void test_seal_unmapped_middle(void)
+{
+	LOG_TEST_ENTER();
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	/* munmap 2 pages from ptr + page. */
+	ret = sys_munmap(ptr + page_size, 2 * page_size);
+	assert(!ret);
+
+	/* mprotect will fail, since middle 2 pages are unmapped. */
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	assert(ret < 0);
+
+	/* mseal will fail as well. */
+	ret = sys_mseal(ptr, size);
+	assert(ret < 0);
+
+	/* we still can add seal to the first page and last page*/
+	ret = sys_mseal(ptr, page_size);
+	assert(!ret);
+
+	ret = sys_mseal(ptr + 3 * page_size, page_size);
+	assert(!ret);
+}
+
+static void test_seal_unmapped_end(void)
+{
+	LOG_TEST_ENTER();
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	/* unmap last 2 pages. */
+	ret = sys_munmap(ptr + 2 * page_size, 2 * page_size);
+	assert(!ret);
+
+	/* mprotect will fail since last 2 pages are unmapped. */
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	assert(ret < 0);
+
+	/* mseal will fail as well. */
+	ret = sys_mseal(ptr, size);
+	assert(ret < 0);
+
+	/* The first 2 pages is not sealed, and can add seals */
+	ret = sys_mseal(ptr, 2 * page_size);
+	assert(!ret);
+}
+
+static void test_seal_multiple_vmas(void)
+{
+	LOG_TEST_ENTER();
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
+	assert(!ret);
+
+	/* mprotect will get applied to all 4 pages - 3 VMAs. */
+	ret = sys_mprotect(ptr, size, PROT_READ);
+	assert(!ret);
+
+	/* use mprotect to split the vma into 3. */
+	ret = sys_mprotect(ptr + page_size, 2 * page_size,
+			PROT_READ | PROT_WRITE);
+	assert(!ret);
+
+	/* mseal get applied to all 4 pages - 3 VMAs. */
+	ret = sys_mseal(ptr, size);
+	assert(!ret);
+}
+
+static void test_seal_split_start(void)
+{
+	LOG_TEST_ENTER();
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split at middle */
+	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
+	assert(!ret);
+
+	/* seal the first page, this will split the VMA */
+	ret = sys_mseal(ptr, page_size);
+	assert(!ret);
+
+	/* add seal to the remain 3 pages */
+	ret = sys_mseal(ptr + page_size, 3 * page_size);
+	assert(!ret);
+}
+
+static void test_seal_split_end(void)
+{
+	LOG_TEST_ENTER();
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split at middle */
+	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
+	assert(!ret);
+
+	/* seal the last page */
+	ret = sys_mseal(ptr + 3 * page_size, page_size);
+	assert(!ret);
+
+	/* Adding seals to the first 3 pages */
+	ret = sys_mseal(ptr, 3 * page_size);
+	assert(!ret);
+}
+
+static void test_seal_invalid_input(void)
+{
+	LOG_TEST_ENTER();
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
+	assert(ret < 0);
+
+	/* unaligned address */
+	ret = sys_mseal(ptr + 1, 2 * page_size);
+	assert(ret < 0);
+
+	/* length too big */
+	ret = sys_mseal(ptr, 5 * page_size);
+	assert(ret < 0);
+
+	/* length overflow */
+	ret = sys_mseal(ptr, UINT64_MAX/page_size);
+	assert(ret < 0);
+
+	/* start is not in a valid VMA */
+	ret = sys_mseal(ptr - page_size, 5 * page_size);
+	assert(ret < 0);
+}
+
+static void test_seal_zero_length(void)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	ret = sys_mprotect(ptr, 0, PROT_READ | PROT_WRITE);
+	assert(!ret);
+
+	/* seal 0 length will be OK, same as mprotect */
+	ret = sys_mseal(ptr, 0);
+	assert(!ret);
+
+	/* verify the 4 pages are not sealed by previous call. */
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	assert(!ret);
+}
+
+static void test_seal_twice(void)
+{
+	LOG_TEST_ENTER();
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	setup_single_address(size, &ptr);
+
+	ret = sys_mseal(ptr, size);
+	assert(!ret);
+
+	/* apply the same seal will be OK. idempotent. */
+	ret = sys_mseal(ptr, size);
+	assert(!ret);
+}
+
+static void test_seal_mprotect(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(ret < 0);
+	else
+		assert(!ret);
+}
+
+static void test_seal_start_mprotect(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	/* pages after the first page is not sealed. */
+	ret = sys_mprotect(ptr + page_size, page_size * 3,
+			PROT_READ | PROT_WRITE);
+	assert(!ret);
+}
+
+static void test_seal_end_mprotect(bool seal)
+{
+	LOG_TEST_ENTER();
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
+	assert(!ret);
+
+	/* last 3 page are sealed */
+	ret = sys_mprotect(ptr + page_size, page_size * 3,
+			PROT_READ | PROT_WRITE);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+}
+
+static void test_seal_mprotect_unalign_len(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect(ptr + page_size * 2, page_size,
+			PROT_READ | PROT_WRITE);
+	assert(!ret);
+}
+
+static void test_seal_mprotect_unalign_len_variant_2(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect(ptr + page_size * 3, page_size,
+			PROT_READ | PROT_WRITE);
+	assert(!ret);
+}
+
+static void test_seal_mprotect_two_vma(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split */
+	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
+	assert(!ret);
+
+	if (seal)
+		seal_single_address(ptr, page_size * 4);
+
+	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_mprotect(ptr + page_size * 2, page_size * 2,
+			PROT_READ | PROT_WRITE);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+}
+
+static void test_seal_mprotect_two_vma_with_split(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split as two vma. */
+	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
+	assert(!ret);
+
+	/* mseal can apply across 2 vma, also split them. */
+	if (seal)
+		seal_single_address(ptr + page_size, page_size * 2);
+
+	/* the first page is not sealed. */
+	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
+	assert(!ret);
+
+	/* the second page is sealed. */
+	ret = sys_mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	/* the third page is sealed. */
+	ret = sys_mprotect(ptr + 2 * page_size, page_size,
+			PROT_READ | PROT_WRITE);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	/* the fouth page is not sealed. */
+	ret = sys_mprotect(ptr + 3 * page_size, page_size,
+			PROT_READ | PROT_WRITE);
+	assert(!ret);
+}
+
+static void test_seal_mprotect_partial_mprotect(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(ret < 0);
+	else
+		assert(!ret);
+}
+
+static void test_seal_mprotect_two_vma_with_gap(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split. */
+	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
+	assert(!ret);
+
+	/* use mprotect to split. */
+	ret = sys_mprotect(ptr + 3 * page_size, page_size,
+			PROT_READ | PROT_WRITE);
+	assert(!ret);
+
+	/* use munmap to free two pages in the middle */
+	ret = sys_munmap(ptr + page_size, 2 * page_size);
+	assert(!ret);
+
+	/* mprotect will fail, because there is a gap in the address. */
+	/* notes, internally mprotect still updated the first page. */
+	ret = sys_mprotect(ptr, 4 * page_size, PROT_READ);
+	assert(ret < 0);
+
+	/* mseal will fail as well. */
+	ret = sys_mseal(ptr, 4 * page_size);
+	assert(ret < 0);
+
+	/* the first page is not sealed. */
+	ret = sys_mprotect(ptr, page_size, PROT_READ);
+	assert(ret == 0);
+
+	/* the last page is not sealed. */
+	ret = sys_mprotect(ptr + 3 * page_size, page_size, PROT_READ);
+	assert(ret == 0);
+}
+
+static void test_seal_mprotect_split(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split. */
+	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
+	assert(!ret);
+
+	/* seal all 4 pages. */
+	if (seal) {
+		ret = sys_mseal(ptr, 4 * page_size);
+		assert(!ret);
+	}
+
+	/* mprotect is sealed. */
+	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+
+	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_READ);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+}
+
+static void test_seal_mprotect_merge(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split one page. */
+	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
+	assert(!ret);
+
+	/* seal first two pages. */
+	if (seal) {
+		ret = sys_mseal(ptr, 2 * page_size);
+		assert(!ret);
+	}
+
+	/* 2 pages are sealed. */
+	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	/* last 2 pages are not sealed. */
+	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_READ);
+	assert(ret == 0);
+}
+
+static void test_seal_munmap(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		assert(!ret);
+	}
+
+	/* 4 pages are sealed. */
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
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
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* use mprotect to split */
+	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
+	assert(!ret);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		assert(!ret);
+	}
+
+	ret = sys_munmap(ptr, page_size * 2);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_munmap(ptr + page_size, page_size * 2);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
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
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	ret = sys_munmap(ptr + page_size, page_size * 2);
+	assert(!ret);
+
+	if (seal) {
+		/* can't have gap in the middle. */
+		ret = sys_mseal(ptr, size);
+		assert(ret < 0);
+	}
+
+	ret = sys_munmap(ptr, page_size);
+	assert(!ret);
+
+	ret = sys_munmap(ptr + page_size * 2, page_size);
+	assert(!ret);
+
+	ret = sys_munmap(ptr, size);
+	assert(!ret);
+}
+
+static void test_munmap_start_freed(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+
+	/* unmap the first page. */
+	ret = sys_munmap(ptr, page_size);
+	assert(!ret);
+
+	/* seal the last 3 pages. */
+	if (seal) {
+		ret = sys_mseal(ptr + page_size, 3 * page_size);
+		assert(!ret);
+	}
+
+	/* unmap from the first page. */
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		assert(ret < 0);
+	else
+		/* note: this will be OK, even the first page is */
+		/* already unmapped. */
+		assert(!ret);
+}
+
+static void test_munmap_end_freed(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+	/* unmap last page. */
+	ret = sys_munmap(ptr + page_size * 3, page_size);
+	assert(!ret);
+
+	/* seal the first 3 pages. */
+	if (seal) {
+		ret = sys_mseal(ptr, 3 * page_size);
+		assert(!ret);
+	}
+
+	/* unmap all pages. */
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+}
+
+static void test_munmap_middle_freed(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address(size, &ptr);
+	/* unmap 2 pages in the middle. */
+	ret = sys_munmap(ptr + page_size, page_size * 2);
+	assert(!ret);
+
+	/* seal the first page. */
+	if (seal) {
+		ret = sys_mseal(ptr, page_size);
+		assert(!ret);
+	}
+
+	/* munmap all 4 pages. */
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+}
+
+static void test_seal_mremap_shrink(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(!ret);
+	}
+
+	/* shrink from 4 pages to 2 pages. */
+	ret2 = mremap(ptr, size, 2 * page_size, 0, 0);
+	if (seal) {
+		assert(ret2 == MAP_FAILED);
+		assert(errno == EACCES);
+	} else {
+		assert(ret2 != MAP_FAILED);
+
+	}
+}
+
+static void test_seal_mremap_expand(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+	/* ummap last 2 pages. */
+	ret = sys_munmap(ptr + 2 * page_size, 2 * page_size);
+	assert(!ret);
+
+	if (seal) {
+		ret = sys_mseal(ptr, 2 * page_size);
+		assert(!ret);
+	}
+
+	/* expand from 2 page to 4 pages. */
+	ret2 = mremap(ptr, 2 * page_size, 4 * page_size, 0, 0);
+	if (seal) {
+		assert(ret2 == MAP_FAILED);
+		assert(errno == EACCES);
+	} else {
+		assert(ret2 == ptr);
+
+	}
+}
+
+static void test_seal_mremap_move(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(!ret);
+	}
+
+	/* move from ptr to fixed address. */
+	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newPtr);
+	if (seal) {
+		assert(ret2 == MAP_FAILED);
+		assert(errno == EACCES);
+	} else {
+		assert(ret2 != MAP_FAILED);
+
+	}
+}
+
+static void test_seal_mmap_overwrite_prot(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(!ret);
+	}
+
+	/* use mmap to change protection. */
+	ret2 = sys_mmap(ptr, size, PROT_NONE,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (seal) {
+		assert(ret2 == MAP_FAILED);
+		assert(errno == EACCES);
+	} else
+		assert(ret2 == ptr);
+}
+
+static void test_seal_mmap_expand(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+	/* ummap last 4 pages. */
+	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
+	assert(!ret);
+
+	if (seal) {
+		ret = sys_mseal(ptr, 8 * page_size);
+		assert(!ret);
+	}
+
+	/* use mmap to expand. */
+	ret2 = sys_mmap(ptr, size, PROT_READ,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (seal) {
+		assert(ret2 == MAP_FAILED);
+		assert(errno == EACCES);
+	} else
+		assert(ret2 == ptr);
+}
+
+static void test_seal_mmap_shrink(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(!ret);
+	}
+
+	/* use mmap to shrink. */
+	ret2 = sys_mmap(ptr, 8 * page_size, PROT_READ,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (seal) {
+		assert(ret2 == MAP_FAILED);
+		assert(errno == EACCES);
+	} else
+		assert(ret2 == ptr);
+}
+
+static void test_seal_mremap_shrink_fixed(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(!ret);
+	}
+
+	/* mremap to move and shrink to fixed address */
+	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+			newAddr);
+	if (seal) {
+		assert(ret2 == MAP_FAILED);
+		assert(errno == EACCES);
+	} else
+		assert(ret2 == newAddr);
+}
+
+static void test_seal_mremap_expand_fixed(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(!ret);
+	}
+
+	/* mremap to move and expand to fixed address */
+	ret2 = mremap(ptr, page_size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
+			newAddr);
+	if (seal) {
+		assert(ret2 == MAP_FAILED);
+		assert(errno == EACCES);
+	} else
+		assert(ret2 == newAddr);
+}
+
+static void test_seal_mremap_move_fixed(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(!ret);
+	}
+
+	/* mremap to move to fixed address */
+	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newAddr);
+	if (seal) {
+		assert(ret2 == MAP_FAILED);
+		assert(errno == EACCES);
+	} else
+		assert(ret2 == newAddr);
+}
+
+static void test_seal_mremap_move_fixed_zero(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	void *newAddr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		assert(!ret);
+	}
+
+	/*
+	 * MREMAP_FIXED can move the mapping to zero address
+	 */
+	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+			0);
+	if (seal) {
+		assert(ret2 == MAP_FAILED);
+		assert(errno == EACCES);
+	} else {
+		assert(ret2 == 0);
+
+	}
+}
+
+static void test_seal_mremap_move_dontunmap(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	void *newAddr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		assert(!ret);
+	}
+
+	/* mremap to move, and don't unmap src addr. */
+	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0);
+	if (seal) {
+		assert(ret2 == MAP_FAILED);
+		assert(errno == EACCES);
+	} else {
+		assert(ret2 != MAP_FAILED);
+
+	}
+}
+
+static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	void *newAddr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	setup_single_address(size, &ptr);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		assert(!ret);
+	}
+
+	/*
+	 * The 0xdeaddead should not have effect on dest addr
+	 * when MREMAP_DONTUNMAP is set.
+	 */
+	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
+			0xdeaddead);
+	if (seal) {
+		assert(ret2 == MAP_FAILED);
+		assert(errno == EACCES);
+	} else {
+		assert(ret2 != MAP_FAILED);
+		assert((long)ret2 != 0xdeaddead);
+
+	}
+}
+
+
+static void test_seal_mmap_seal(void)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	void *ret2;
+
+	ptr = sys_mmap(NULL, size, PROT_READ | PROT_SEAL, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr != (void *)-1);
+
+	ret = sys_munmap(ptr, size);
+	assert(ret < 0);
+
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	assert(ret < 0);
+}
+
+static void test_seal_merge_and_split(void)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size;
+	int ret;
+	void *ret2;
+
+	/* (24 RO) */
+	setup_single_address(24 * page_size, &ptr);
+
+	/* use mprotect(NONE) to set out boundary */
+	/* (1 NONE) (22 RO) (1 NONE) */
+	ret = sys_mprotect(ptr, page_size, PROT_NONE);
+	assert(!ret);
+	ret = sys_mprotect(ptr + 23 * page_size, page_size, PROT_NONE);
+	assert(!ret);
+	size = get_vma_size(ptr + page_size);
+	assert(size == 22 * page_size);
+
+	/* use mseal to split from beginning */
+	/* (1 NONE) (1 RO_SEAL) (21 RO) (1 NONE) */
+	ret = sys_mseal(ptr + page_size, page_size);
+	assert(!ret);
+	size = get_vma_size(ptr + page_size);
+	assert(size == page_size);
+	size = get_vma_size(ptr + 2 * page_size);
+	assert(size == 21 * page_size);
+
+	/* use mseal to split from the end. */
+	/* (1 NONE) (1 RO_SEAL) (20 RO) (1 RO_SEAL) (1 NONE) */
+	ret = sys_mseal(ptr + 22 * page_size, page_size);
+	assert(!ret);
+	size = get_vma_size(ptr + 22 * page_size);
+	assert(size == page_size);
+	size = get_vma_size(ptr + 2 * page_size);
+	assert(size == 20 * page_size);
+
+	/* merge with prev. */
+	/* (1 NONE) (2 RO_SEAL) (19 RO) (1 RO_SEAL) (1 NONE) */
+	ret = sys_mseal(ptr + 2 * page_size, page_size);
+	assert(!ret);
+	size = get_vma_size(ptr +  page_size);
+	assert(size ==  2 * page_size);
+
+	/* merge with after. */
+	/* (1 NONE) (2 RO_SEAL) (18 RO) (2 RO_SEALS) (1 NONE) */
+	ret = sys_mseal(ptr + 21 * page_size, page_size);
+	assert(!ret);
+	size = get_vma_size(ptr +  21 * page_size);
+	assert(size ==  2 * page_size);
+
+	/* split and merge from prev */
+	/* (1 NONE) (3 RO_SEAL) (17 RO) (2 RO_SEALS) (1 NONE) */
+	ret = sys_mseal(ptr + 2 * page_size, 2 * page_size);
+	assert(!ret);
+	size = get_vma_size(ptr +  1 * page_size);
+	assert(size ==  3 * page_size);
+	ret = sys_munmap(ptr + page_size,  page_size);
+	assert(ret < 0);
+	ret = sys_mprotect(ptr + 2 * page_size, page_size,  PROT_NONE);
+	assert(ret < 0);
+
+	/* split and merge from next */
+	/* (1 NONE) (3 RO_SEAL) (16 RO) (3 RO_SEALS) (1 NONE) */
+	ret = sys_mseal(ptr + 20 * page_size, 2 * page_size);
+	assert(!ret);
+	size = get_vma_size(ptr +  20 * page_size);
+	assert(size ==  3 * page_size);
+
+	/* merge from middle of prev and middle of next. */
+	/* (1 NONE) (22 RO_SEAL) (1 NONE) */
+	ret = sys_mseal(ptr + 2 * page_size, 20 * page_size);
+	assert(!ret);
+	size = get_vma_size(ptr +  page_size);
+	assert(size ==  22 * page_size);
+}
+
+static void test_seal_mmap_merge(void)
+{
+	LOG_TEST_ENTER();
+
+	void *ptr, *ptr2;
+	unsigned long page_size = getpagesize();
+	unsigned long size;
+	int ret;
+	void *ret2;
+
+	/* (24 RO) */
+	setup_single_address(24 * page_size, &ptr);
+
+	/* use mprotect(NONE) to set out boundary */
+	/* (1 NONE) (22 RO) (1 NONE) */
+	ret = sys_mprotect(ptr, page_size, PROT_NONE);
+	assert(!ret);
+	ret = sys_mprotect(ptr + 23 * page_size, page_size, PROT_NONE);
+	assert(!ret);
+	size = get_vma_size(ptr + page_size);
+	assert(size == 22 * page_size);
+
+	/* use munmap to free 2 segment of memory. */
+	/* (1 NONE) (1 free) (20 RO) (1 free) (1 NONE) */
+	ret = sys_munmap(ptr + page_size, page_size);
+	assert(!ret);
+
+	ret = sys_munmap(ptr + 22 * page_size, page_size);
+	assert(!ret);
+
+	/* apply seal to the middle */
+	/* (1 NONE) (1 free) (20 RO_SEAL) (1 free) (1 NONE) */
+	ret = sys_mseal(ptr + 2 * page_size, 20 * page_size);
+	assert(!ret);
+	size = get_vma_size(ptr + 2 * page_size);
+	assert(size == 20 * page_size);
+
+	/* allocate a mapping at beginning, and make sure it merges. */
+	/* (1 NONE) (21 RO_SEAL) (1 free) (1 NONE) */
+	ptr2 = sys_mmap(ptr + page_size, page_size, PROT_READ | PROT_SEAL,
+		MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	assert(ptr != (void *)-1);
+	size = get_vma_size(ptr + page_size);
+	assert(size == 21 * page_size);
+
+	/* allocate a mapping at end, and make sure it merges. */
+	/* (1 NONE) (22 RO_SEAL) (1 NONE) */
+	ptr2 = sys_mmap(ptr + 22 * page_size, page_size, PROT_READ | PROT_SEAL,
+		MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	assert(ptr != (void *)-1);
+	size = get_vma_size(ptr + page_size);
+	assert(size == 22 * page_size);
+}
+
+static void test_not_sealable(void)
+{
+	LOG_TEST_ENTER();
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	ptr = sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr != (void *)-1);
+
+	ret = sys_mseal(ptr, size);
+	assert(ret < 0);
+}
+
+static void test_mmap_fixed_change_to_sealable(void)
+{
+	LOG_TEST_ENTER();
+	int ret;
+	void *ptr, *ptr2;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	ptr = sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr != (void *)-1);
+
+	ret = sys_mseal(ptr, size);
+	assert(ret < 0);
+
+	ptr2 = sys_mmap(ptr, size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_SEALABLE, -1, 0);
+	assert(ptr2 == ptr);
+
+	ret = sys_mseal(ptr, size);
+	assert(!ret);
+}
+
+static void test_mmap_fixed_change_to_not_sealable(void)
+{
+	LOG_TEST_ENTER();
+	int ret;
+	void *ptr, *ptr2;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+
+	ptr = sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE | MAP_SEALABLE, -1, 0);
+	assert(ptr != (void *)-1);
+
+	ptr2 = sys_mmap(ptr, size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr2 == ptr);
+
+	ret = sys_mseal(ptr, size);
+	assert(ret < 0);
+}
+
+static void test_merge_sealable(void)
+{
+	LOG_TEST_ENTER();
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
+	assert(!ret);
+	ret = sys_mprotect(ptr + 23 * page_size, page_size, PROT_NONE);
+	assert(!ret);
+	size = get_vma_size(ptr + page_size);
+	assert(size == 22 * page_size);
+
+	/* (1 NONE) (RO) (4 free) (17 RO) (1 NONE) */
+	ret = sys_munmap(ptr + 2 * page_size,  4 * page_size);
+	assert(!ret);
+	size = get_vma_size(ptr + page_size);
+	assert(size == 1 * page_size);
+	size = get_vma_size(ptr +  6 * page_size);
+	assert(size == 17 * page_size);
+
+	/* (1 NONE) (RO) (1 free) (2 RO) (1 free) (17 RO) (1 NONE) */
+	ptr2 = sys_mmap(ptr + 3 * page_size, 2 * page_size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_SEALABLE, -1, 0);
+	size = get_vma_size(ptr + 3 * page_size);
+	assert(size == 2 * page_size);
+
+	/* (1 NONE) (RO) (1 free) (20 RO) (1 NONE) */
+	ptr2 = sys_mmap(ptr + 5 * page_size, 1 * page_size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE | MAP_SEALABLE, -1, 0);
+	assert(ptr2 != (void *)-1);
+	size = get_vma_size(ptr + 3 * page_size);
+	assert(size == 20 * page_size);
+
+	/* (1 NONE) (RO) (1 free) (19 RO) (1 RO_SEAL) (1 NONE) */
+	ret = sys_mseal(ptr + 22 * page_size, page_size);
+	assert(!ret);
+
+	/* (1 NONE) (RO) (not sealable) (19 RO) (1 RO_SEAL) (1 NONE) */
+	ptr2 = sys_mmap(ptr + 2 * page_size, page_size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr2 != (void *)-1);
+	size = get_vma_size(ptr + page_size);
+	assert(size == page_size);
+	size = get_vma_size(ptr + 2 * page_size);
+	assert(size == page_size);
+
+	/* (1 NONE) (1 free) (1 NOT_SEALABLE) (19 free) (1 RO_SEAL) (1 NONE) */
+	ret = sys_munmap(ptr + page_size,  page_size);
+	assert(!ret);
+	ret = sys_munmap(ptr + 3 * page_size,  19 * page_size);
+	assert(!ret);
+
+	/* (1 NONE) (2 NOT_SEALABLE) (19 free) (1 RO_SEAL) (1 NONE) */
+	ptr2 = sys_mmap(ptr + page_size, page_size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr2 != (void *)-1);
+	size = get_vma_size(ptr + page_size);
+	assert(size == 2 * page_size);
+
+	/* (1 NONE) (21 NOT_SEALABLE)(1 RO_SEAL) (1 NONE) */
+	ptr2 = sys_mmap(ptr + 3 * page_size, 19 * page_size, PROT_READ,
+		MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr2 != (void *)-1);
+	size = get_vma_size(ptr + page_size);
+	assert(size == 21 * page_size);
+}
+
+static void test_seal_discard_ro_anon_on_rw(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	setup_single_address_rw_sealable(size, &ptr, seal);
+	assert(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		assert(!ret);
+	}
+
+	/* sealing doesn't take effect on RW memory. */
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	assert(!ret);
+
+	/* base seal still apply. */
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+}
+
+static void test_seal_discard_ro_anon_on_pkey(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	int pkey;
+
+	setup_single_address_rw_sealable(size, &ptr, seal);
+	assert(ptr != (void *)-1);
+
+	pkey = sys_pkey_alloc(0, 0);
+	assert(pkey > 0);
+
+	ret = sys_mprotect_pkey((void *)ptr, size, PROT_READ | PROT_WRITE, pkey);
+	assert(!ret);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		assert(!ret);
+	}
+
+	/* sealing doesn't take effect if PKRU allow write. */
+	set_pkey(pkey, 0);
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	assert(!ret);
+
+	/* sealing will take effect if PKRU deny write. */
+	set_pkey(pkey, PKEY_DISABLE_WRITE);
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	/* base seal still apply. */
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+}
+
+static void test_seal_discard_ro_anon_on_filebacked(bool seal)
+{
+	LOG_TEST_ENTER();
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
+	assert(fd > 0);
+
+	ret = fallocate(fd, 0, 0, size);
+	assert(!ret);
+
+	ptr = sys_mmap(NULL, size, PROT_READ, mapflags, fd, 0);
+	assert(ptr != MAP_FAILED);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		assert(!ret);
+	}
+
+	/* sealing doesn't apply for file backed mapping. */
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	assert(!ret);
+
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+	close(fd);
+}
+
+static void test_seal_discard_ro_anon_on_shared(bool seal)
+{
+	LOG_TEST_ENTER();
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
+	assert(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		assert(!ret);
+	}
+
+	/* sealing doesn't apply for shared mapping. */
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	assert(!ret);
+
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+}
+
+static void test_seal_discard_ro_anon_invalid_shared(bool seal)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	int fd;
+
+	fd = open("/proc/self/maps", O_RDONLY);
+	ptr = sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, fd, 0);
+	assert(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		assert(!ret);
+	}
+
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	assert(!ret);
+
+	ret = sys_munmap(ptr, size);
+	assert(ret < 0);
+	close(fd);
+}
+
+static void test_seal_discard_ro_anon(bool seal)
+{
+	LOG_TEST_ENTER();
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
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = sys_munmap(ptr, size);
+	if (seal)
+		assert(ret < 0);
+	else
+		assert(!ret);
+}
+
+static void test_mmap_seal_discard_ro_anon(void)
+{
+	LOG_TEST_ENTER();
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+
+	ptr = sys_mmap(NULL, size, PROT_READ | PROT_WRITE | PROT_SEAL,
+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr != (void *)-1);
+
+	ret = sys_mprotect(ptr, size, PROT_READ);
+	assert(!ret);
+
+	ret = sys_madvise(ptr, size, MADV_DONTNEED);
+	assert(ret < 0);
+
+	ret = sys_munmap(ptr, size);
+	assert(ret < 0);
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
+int main(int argc, char **argv)
+{
+	bool test_seal = seal_support();
+
+	if (!test_seal) {
+		ksft_print_msg("sealing not supported (check CONFIG_64BIT)\n");
+		return 0;
+	}
+
+	test_seal_addseal();
+
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
+	if (pkey_supported()) {
+		test_seal_discard_ro_anon_on_pkey(false);
+		test_seal_discard_ro_anon_on_pkey(true);
+	} else
+		ksft_print_msg("PKEY not supported, skip pkey related test\n");
+
+	ksft_print_msg("Done\n");
+	return 0;
+}
-- 
2.43.0.195.gebba966016-goog


