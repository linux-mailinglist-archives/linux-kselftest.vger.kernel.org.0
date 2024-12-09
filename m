Return-Path: <linux-kselftest+bounces-23006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AEE9E8F43
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FFB2837C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB40216E3F;
	Mon,  9 Dec 2024 09:50:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAAA217F42;
	Mon,  9 Dec 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737859; cv=none; b=GUhlhr1aEmqJhiGrMYSUnHHJkPkn1mQ5EYs+fwOY8nKmWQ+owCpDZ2UIDj1Bj9K+inhOk7QFNL9SaDmQ6NVD9tGy48N5k50ib33Bol4DGnhL0dnYssWdU8o+3aX8e4Wvdei9MmsVSXkCGSqVsgoHM0pu8lopq9JhZvQWRQMCS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737859; c=relaxed/simple;
	bh=zNkIo5hae2LdxyHj/3sUZk6S/Uq9FTP7Tep+fwfB2Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jP0uVSdDYPXVodXTtE1U5OOIiMxfBeQAOf6bpXIFi9jTjo/CMUfjOAX7OMmzPVThO5lZhdWLM+WpCTY8BK2ME8NWIeCYLd1CY4iLxOrvkQenn5B5+5omKt0Dmc5ESoK/t06r5ES6a7vmE1nAnmvzz7itI5kImngWLbVQvXxSbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABF5B113E;
	Mon,  9 Dec 2024 01:51:25 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A27463F720;
	Mon,  9 Dec 2024 01:50:55 -0800 (PST)
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
Subject: [PATCH 08/14] selftests/mm: Ensure pkey-*.h define inline functions only
Date: Mon,  9 Dec 2024 09:50:13 +0000
Message-ID: <20241209095019.1732120-9-kevin.brodsky@arm.com>
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

Headers should not define non-inline functions, as this prevents
them from being included more than once in a given program.
pkey-helpers.h and the arch-specific headers it includes currently
define multiple such non-inline functions.

In most cases those functions can simply be made inline - this patch
does just that. read_ptr() is an exception as it must not be
inlined. Since it is only called from protection_keys.c, we just move it
there.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pkey-arm64.h      | 4 ++--
 tools/testing/selftests/mm/pkey-helpers.h    | 8 +-------
 tools/testing/selftests/mm/pkey-powerpc.h    | 4 ++--
 tools/testing/selftests/mm/pkey-x86.h        | 6 +++---
 tools/testing/selftests/mm/protection_keys.c | 7 +++++++
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-arm64.h b/tools/testing/selftests/mm/pkey-arm64.h
index d9d2100eafc0..9897e31f16dd 100644
--- a/tools/testing/selftests/mm/pkey-arm64.h
+++ b/tools/testing/selftests/mm/pkey-arm64.h
@@ -81,11 +81,11 @@ static inline int get_arch_reserved_keys(void)
 	return NR_RESERVED_PKEYS;
 }
 
-void expect_fault_on_read_execonly_key(void *p1, int pkey)
+static inline void expect_fault_on_read_execonly_key(void *p1, int pkey)
 {
 }
 
-void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+static inline void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
 {
 	return PTR_ERR_ENOTSUP;
 }
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 84376ab09545..bc81275a89d9 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -84,13 +84,7 @@ extern void abort_hooks(void);
 # define noinline __attribute__((noinline))
 #endif
 
-noinline int read_ptr(int *ptr)
-{
-	/* Keep GCC from optimizing this away somehow */
-	barrier();
-	return *ptr;
-}
-
+noinline int read_ptr(int *ptr);
 void expected_pkey_fault(int pkey);
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
diff --git a/tools/testing/selftests/mm/pkey-powerpc.h b/tools/testing/selftests/mm/pkey-powerpc.h
index 3d0c0bdae5bc..1bad310d282a 100644
--- a/tools/testing/selftests/mm/pkey-powerpc.h
+++ b/tools/testing/selftests/mm/pkey-powerpc.h
@@ -91,7 +91,7 @@ static inline int get_arch_reserved_keys(void)
 			return NR_RESERVED_PKEYS_64K_3KEYS;
 }
 
-void expect_fault_on_read_execonly_key(void *p1, int pkey)
+static inline void expect_fault_on_read_execonly_key(void *p1, int pkey)
 {
 	/*
 	 * powerpc does not allow userspace to change permissions of exec-only
@@ -105,7 +105,7 @@ void expect_fault_on_read_execonly_key(void *p1, int pkey)
 /* 4-byte instructions * 16384 = 64K page */
 #define __page_o_noops() asm(".rept 16384 ; nop; .endr")
 
-void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+static inline void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
 {
 	void *ptr;
 	int ret;
diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index ac91777c8917..f7ecd335df1e 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -113,7 +113,7 @@ static inline u32 pkey_bit_position(int pkey)
 #define XSTATE_PKEY	0x200
 #define XSTATE_BV_OFFSET	512
 
-int pkey_reg_xstate_offset(void)
+static inline int pkey_reg_xstate_offset(void)
 {
 	unsigned int eax;
 	unsigned int ebx;
@@ -148,7 +148,7 @@ static inline int get_arch_reserved_keys(void)
 	return NR_RESERVED_PKEYS;
 }
 
-void expect_fault_on_read_execonly_key(void *p1, int pkey)
+static inline void expect_fault_on_read_execonly_key(void *p1, int pkey)
 {
 	int ptr_contents;
 
@@ -157,7 +157,7 @@ void expect_fault_on_read_execonly_key(void *p1, int pkey)
 	expected_pkey_fault(pkey);
 }
 
-void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+static inline void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
 {
 	return PTR_ERR_ENOTSUP;
 }
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index fcbebc4490b4..82ece325b70c 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -54,6 +54,13 @@ int test_nr;
 u64 shadow_pkey_reg;
 int dprint_in_signal;
 
+noinline int read_ptr(int *ptr)
+{
+	/* Keep GCC from optimizing this away somehow */
+	barrier();
+	return *ptr;
+}
+
 void cat_into_file(char *str, char *file)
 {
 	int fd = open(file, O_RDWR);
-- 
2.47.0


