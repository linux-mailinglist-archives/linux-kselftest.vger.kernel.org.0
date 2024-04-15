Return-Path: <linux-kselftest+bounces-8007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF3C8A57E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608FA1C2144E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EC4839FE;
	Mon, 15 Apr 2024 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YXizCPX/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B761881ABF
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198944; cv=none; b=NzJA4STKzbqc+FmitjhZ8CX9LirS2QZQw2q1SknaKmwB6YRJEomhYBK12/Zm/jJpQl771/VfLJIKQnXnFDgHsM7TBexiNscu3bgqgjhhq/AzfH/ZmztLy7b8s7pgHxs3viAYQ5hdegRCemTHMOh95dSLTyJkj79aWuPe4AeWP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198944; c=relaxed/simple;
	bh=aDF7ECHno8X8wEFVrDr0xyLT5RPu7fyI4++Xbq6Hqkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0dVRwFZJav+aX7N1LlCfDiBAB6ZtLgaietmTS20c8j7DXwD4KlPkc071PpiHmjPyBdkVUexIHPpuhmvhP1z/AkJIwPsOu/xaSc17yx/5OPcSoCQPT4j9CrjSOPNAyYcZzRV8xsji10mUuicawzuoJe4jG9t5B7tUtIYNW1yRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YXizCPX/; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1982211a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713198940; x=1713803740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN2W59EliwXnJXkhzz3LAv4gwtoe49iUNaJXJxTnDts=;
        b=YXizCPX/fzbCL+nk+T/9/gMR9NIvv8G7ByYCr09JSNKRPFr4wK7lffX0fupgUi2msj
         1MNRfRB7mMccbvN/C0lFeTbW4vZLFFasuGRRoATdIzbVJqjJQUVGWed5XZ2k6TuXWIiE
         lloB2zXsu4CM7sF5FNxRRnIWLTMHC85lVxsBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198940; x=1713803740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BN2W59EliwXnJXkhzz3LAv4gwtoe49iUNaJXJxTnDts=;
        b=P7xdomByEZTnIa5Z5PLB9EGryYNmbQs1JjVKAvjn4Qyhrwd8AboOEhRr8CfXOOwb9v
         7oM+K/yxpuRVQLRKSWn1OVAfGjJuPxMUu3apkb/JalnmM0KYu+9BlDOaiBY6SKAnxMf/
         hFM51KeqeLiK/vZM3covWL4zl8PeLUin186GdJXn+LNHhUIbK5sX/bhY9GqVfC6ohBEa
         7IbR+oqSCe7Bgfuc+pjUKUhWMN1jdPztQ5uYTOYdrbzmGs93Bqfx12T25OmE2mkLmtll
         PVqVj0FUfNzXr1jgeLG88ki9Vr/YvGNFPEEaldwol1v15qxFo3llYfoBJ3GVRH5uMq9e
         eDlA==
X-Forwarded-Encrypted: i=1; AJvYcCXYrPmZefkYChszTznGa0Et71TjTDZ9+4QwmwMrCgkJU139AvCMsrrmSumepQZHJ/wSY20iRs1rDHQVf79hTqtjubPh5JY6dc2eZLRELpF3
X-Gm-Message-State: AOJu0YzKxU9xcMBifrXvxjvRc5ghEcuX0lkzYtuhKC5NPvNZmA8UeKwM
	tGY83rE4qDQDJzRY8LN5bNiIYgHStER3ie50DgoxvEBZTf1O+tp+9AwFEf9GKw==
X-Google-Smtp-Source: AGHT+IEF7hNuyDQgCTgm17ED/4J8gdxZbQtqGQQyVAQ/anHpZpNuVsagXDGzM7LF/8rq/2lkUAaPxQ==
X-Received: by 2002:a17:903:1246:b0:1e6:6bba:7c70 with SMTP id u6-20020a170903124600b001e66bba7c70mr3793369plh.36.1713198939810;
        Mon, 15 Apr 2024 09:35:39 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id mo3-20020a1709030a8300b001e510b3e807sm8137503plb.263.2024.04.15.09.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 09:35:39 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	surenb@google.com,
	merimus@google.com,
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
Subject: [PATCH v10 3/5] selftest mm/mseal memory sealing
Date: Mon, 15 Apr 2024 16:35:22 +0000
Message-ID: <20240415163527.626541-4-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240415163527.626541-1-jeffxu@chromium.org>
References: <20240415163527.626541-1-jeffxu@chromium.org>
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
 tools/testing/selftests/mm/mseal_test.c | 1836 +++++++++++++++++++++++
 3 files changed, 1838 insertions(+)
 create mode 100644 tools/testing/selftests/mm/mseal_test.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index d26e962f2ac4..98eaa4590f11 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -47,3 +47,4 @@ mkdirty
 va_high_addr_switch
 hugetlb_fault_after_madv
 hugetlb_madv_vs_map
+mseal_test
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index eb5f39a2668b..95d10fe1b3c1 100644
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
index 000000000000..06c780d1d8e5
--- /dev/null
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -0,0 +1,1836 @@
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
+static unsigned long get_vma_size(void *addr, int *prot)
+{
+	FILE *maps;
+	char line[256];
+	int size = 0;
+	uintptr_t  addr_start, addr_end;
+	char protstr[5];
+	*prot = 0;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps)
+		return 0;
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, &protstr) == 3) {
+			if (addr_start == (uintptr_t) addr) {
+				size = addr_end - addr_start;
+				if (protstr[0] == 'r')
+					*prot |= 0x4;
+				if (protstr[1] == 'w')
+					*prot |= 0x2;
+				if (protstr[2] == 'x')
+					*prot |= 0x1;
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
+	sret = syscall(__NR_mprotect, ptr, size, prot);
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
+	sret = syscall(__NR_munmap, ptr, size);
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
+	int ret = syscall(__NR_pkey_alloc, flags, init_val);
+
+	return ret;
+}
+
+static unsigned int __read_pkey_reg(void)
+{
+	unsigned int pkey_reg = 0;
+#if defined(__i386__) || defined(__x86_64__) /* arch */
+	unsigned int eax, edx;
+	unsigned int ecx = 0;
+
+	asm volatile(".byte 0x0f,0x01,0xee\n\t"
+			: "=a" (eax), "=d" (edx)
+			: "c" (ecx));
+	pkey_reg = eax;
+#endif
+	return pkey_reg;
+}
+
+static void __write_pkey_reg(u64 pkey_reg)
+{
+#if defined(__i386__) || defined(__x86_64__) /* arch */
+	unsigned int eax = pkey_reg;
+	unsigned int ecx = 0;
+	unsigned int edx = 0;
+
+	asm volatile(".byte 0x0f,0x01,0xef\n\t"
+			: : "a" (eax), "c" (ecx), "d" (edx));
+	assert(pkey_reg == __read_pkey_reg());
+#endif
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
+	ptr = sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	assert(ptr != (void *)-1);
+	*ptrOut = ptr;
+}
+
+static void setup_single_address_rw(int size, void **ptrOut)
+{
+	void *ptr;
+	unsigned long mapflags = MAP_ANONYMOUS | MAP_PRIVATE;
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
+	ptr = sys_mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
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
+#if defined(__i386__) || defined(__x86_64__) /* arch */
+	int pkey = sys_pkey_alloc(0, 0);
+
+	if (pkey > 0)
+		return true;
+#endif
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
+static void test_seal_zero_address(void)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	int prot;
+
+	/* use mmap to change protection. */
+	ptr = sys_mmap(0, size, PROT_NONE,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	FAIL_TEST_IF_FALSE(ptr == 0);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	ret = sys_mseal(ptr, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* verify the 4 pages are sealed by previous call. */
+	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(ret);
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
+	int prot;
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
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret < 0);
+
+		size = get_vma_size(ptr + page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == page_size * 3);
+	} else {
+		/* note: this will be OK, even the first page is */
+		/* already unmapped. */
+		FAIL_TEST_IF_FALSE(!ret);
+
+		size = get_vma_size(ptr + page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 0);
+	}
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
+	int prot;
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
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret < 0);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == page_size);
+
+		size = get_vma_size(ptr + page_size * 3, &prot);
+		FAIL_TEST_IF_FALSE(size == page_size);
+	} else {
+		FAIL_TEST_IF_FALSE(!ret);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 0);
+
+		size = get_vma_size(ptr + page_size * 3, &prot);
+		FAIL_TEST_IF_FALSE(size == 0);
+	}
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
+		FAIL_TEST_IF_FALSE(errno == EPERM);
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
+		FAIL_TEST_IF_FALSE(errno == EPERM);
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
+		FAIL_TEST_IF_FALSE(errno == EPERM);
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
+		FAIL_TEST_IF_FALSE(errno == EPERM);
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
+		FAIL_TEST_IF_FALSE(errno == EPERM);
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
+		FAIL_TEST_IF_FALSE(errno == EPERM);
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
+		FAIL_TEST_IF_FALSE(errno == EPERM);
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
+		FAIL_TEST_IF_FALSE(errno == EPERM);
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
+		FAIL_TEST_IF_FALSE(errno == EPERM);
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
+		FAIL_TEST_IF_FALSE(errno == EPERM);
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
+		FAIL_TEST_IF_FALSE(errno == EPERM);
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
+		FAIL_TEST_IF_FALSE(errno == EPERM);
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
+static void test_seal_merge_and_split(void)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size;
+	int ret;
+	int prot;
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
+	size = get_vma_size(ptr + page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 22 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 4);
+
+	/* use mseal to split from beginning */
+	/* (1 NONE) (1 RO_SEAL) (21 RO) (1 NONE) */
+	ret = sys_mseal(ptr + page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr + page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+	size = get_vma_size(ptr + 2 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 21 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+
+	/* use mseal to split from the end. */
+	/* (1 NONE) (1 RO_SEAL) (20 RO) (1 RO_SEAL) (1 NONE) */
+	ret = sys_mseal(ptr + 22 * page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr + 22 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+	size = get_vma_size(ptr + 2 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 20 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+
+	/* merge with prev. */
+	/* (1 NONE) (2 RO_SEAL) (19 RO) (1 RO_SEAL) (1 NONE) */
+	ret = sys_mseal(ptr + 2 * page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr +  page_size, &prot);
+	FAIL_TEST_IF_FALSE(size ==  2 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+
+	/* merge with after. */
+	/* (1 NONE) (2 RO_SEAL) (18 RO) (2 RO_SEALS) (1 NONE) */
+	ret = sys_mseal(ptr + 21 * page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr +  21 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size ==  2 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+
+	/* split and merge from prev */
+	/* (1 NONE) (3 RO_SEAL) (17 RO) (2 RO_SEALS) (1 NONE) */
+	ret = sys_mseal(ptr + 2 * page_size, 2 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr +  1 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size ==  3 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+	ret = sys_munmap(ptr + page_size,  page_size);
+	FAIL_TEST_IF_FALSE(ret < 0);
+	ret = sys_mprotect(ptr + 2 * page_size, page_size,  PROT_NONE);
+	FAIL_TEST_IF_FALSE(ret < 0);
+
+	/* split and merge from next */
+	/* (1 NONE) (3 RO_SEAL) (16 RO) (3 RO_SEALS) (1 NONE) */
+	ret = sys_mseal(ptr + 20 * page_size, 2 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+	size = get_vma_size(ptr +  20 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size ==  3 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+
+	/* merge from middle of prev and middle of next. */
+	/* (1 NONE) (22 RO_SEAL) (1 NONE) */
+	ret = sys_mseal(ptr + 2 * page_size, 20 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+	size = get_vma_size(ptr +  page_size, &prot);
+	FAIL_TEST_IF_FALSE(size ==  22 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
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
+	setup_single_address_rw(size, &ptr);
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
+	setup_single_address_rw(size, &ptr);
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
+	ksft_set_plan(80);
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
+	test_seal_merge_and_split();
+	test_seal_zero_address();
+
+	test_seal_discard_ro_anon_on_pkey(false);
+	test_seal_discard_ro_anon_on_pkey(true);
+
+	ksft_finished();
+	return 0;
+}
-- 
2.44.0.683.g7961c838ac-goog


