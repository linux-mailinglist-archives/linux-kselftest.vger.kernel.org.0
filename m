Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9DD72BE82
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 12:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjFLKNw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 06:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjFLKNW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 06:13:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EAD46A6;
        Mon, 12 Jun 2023 02:54:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 89B476606E9A;
        Mon, 12 Jun 2023 10:54:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686563655;
        bh=SjDGf2SNMcjDK66xmbsxwO0e5mfU/9DarkBr2D33KK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5xPMxchf9475mvOgqV8KOXB51ccreXiNMBeNfeEElbq3ZYRVna6om8JKgIiYTnG3
         x2Yvek0sRb81U+y3PTdeRR/osPnnf+hKxljHUB+94udHC3aJWhoCAkFVHeDyDhe32Q
         0FV8lDdfeCD12yeFfv5hkuNmEKaxPR6fqT6HW9nlRwzuRpbh7UcUAcsEUhA5jzigSe
         XU2nlXOEpkQ4D97Qly830Ffo0EA+BIj+5w5u5s4w2DuAHLHlmdHa0kSBNDAyxBrwoU
         it2aPS02XNfoyFnqrpqzM1RoQXS5RSKXhE7R5htjdOVWg6b2przC+iVc88ORuAradl
         +YPfBOZ3E3aNQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: mm: remove duplicate unneeded defines
Date:   Mon, 12 Jun 2023 14:53:47 +0500
Message-Id: <20230612095347.996335-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612095347.996335-1-usama.anjum@collabora.com>
References: <20230612095347.996335-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove all defines which aren't needed after correctly including the
kernel header files.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/cow.c               |  1 +
 tools/testing/selftests/mm/hugepage-shm.c      |  4 ----
 tools/testing/selftests/mm/hugepage-vmemmap.c  |  4 ----
 tools/testing/selftests/mm/khugepaged.c        |  1 +
 tools/testing/selftests/mm/madv_populate.c     |  7 -------
 .../testing/selftests/mm/map_fixed_noreplace.c |  4 ----
 tools/testing/selftests/mm/map_hugetlb.c       | 12 ------------
 tools/testing/selftests/mm/map_populate.c      |  2 --
 tools/testing/selftests/mm/mlock-random-test.c |  1 +
 tools/testing/selftests/mm/mlock2.h            |  8 --------
 tools/testing/selftests/mm/mrelease_test.c     | 10 +---------
 tools/testing/selftests/mm/mremap_dontunmap.c  |  4 ----
 tools/testing/selftests/mm/on-fault-limit.c    |  4 ----
 tools/testing/selftests/mm/pkey-powerpc.h      |  3 ---
 tools/testing/selftests/mm/pkey-x86.h          | 18 ------------------
 tools/testing/selftests/mm/protection_keys.c   | 13 ++-----------
 tools/testing/selftests/mm/vm_util.h           | 10 ----------
 17 files changed, 6 insertions(+), 100 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index e4c5095e74fc..7324ce5363c0 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <assert.h>
+#include <linux/mman.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 #include <sys/wait.h>
diff --git a/tools/testing/selftests/mm/hugepage-shm.c b/tools/testing/selftests/mm/hugepage-shm.c
index e2527f32005b..478bb1e989e9 100644
--- a/tools/testing/selftests/mm/hugepage-shm.c
+++ b/tools/testing/selftests/mm/hugepage-shm.c
@@ -35,10 +35,6 @@
 #include <sys/shm.h>
 #include <sys/mman.h>
 
-#ifndef SHM_HUGETLB
-#define SHM_HUGETLB 04000
-#endif
-
 #define LENGTH (256UL*1024*1024)
 
 #define dprintf(x)  printf(x)
diff --git a/tools/testing/selftests/mm/hugepage-vmemmap.c b/tools/testing/selftests/mm/hugepage-vmemmap.c
index 557bdbd4f87e..5b354c209e93 100644
--- a/tools/testing/selftests/mm/hugepage-vmemmap.c
+++ b/tools/testing/selftests/mm/hugepage-vmemmap.c
@@ -13,10 +13,6 @@
 
 #define MAP_LENGTH		(2UL * 1024 * 1024)
 
-#ifndef MAP_HUGETLB
-#define MAP_HUGETLB		0x40000	/* arch specific */
-#endif
-
 #define PAGE_SIZE		4096
 
 #define PAGE_COMPOUND_HEAD	(1UL << 15)
diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index e88ee039d0eb..030667cb5533 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <unistd.h>
 
+#include <linux/mman.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <sys/types.h>
diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index 262eae6b58f2..60547245e479 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -20,13 +20,6 @@
 #include "../kselftest.h"
 #include "vm_util.h"
 
-#ifndef MADV_POPULATE_READ
-#define MADV_POPULATE_READ	22
-#endif /* MADV_POPULATE_READ */
-#ifndef MADV_POPULATE_WRITE
-#define MADV_POPULATE_WRITE	23
-#endif /* MADV_POPULATE_WRITE */
-
 /*
  * For now, we're using 2 MiB of private anonymous memory for all tests.
  */
diff --git a/tools/testing/selftests/mm/map_fixed_noreplace.c b/tools/testing/selftests/mm/map_fixed_noreplace.c
index eed44322d1a6..598159f3df1f 100644
--- a/tools/testing/selftests/mm/map_fixed_noreplace.c
+++ b/tools/testing/selftests/mm/map_fixed_noreplace.c
@@ -13,10 +13,6 @@
 #include <stdlib.h>
 #include <unistd.h>
 
-#ifndef MAP_FIXED_NOREPLACE
-#define MAP_FIXED_NOREPLACE 0x100000
-#endif
-
 static void dump_maps(void)
 {
 	char cmd[32];
diff --git a/tools/testing/selftests/mm/map_hugetlb.c b/tools/testing/selftests/mm/map_hugetlb.c
index 312889edb84a..193281560b61 100644
--- a/tools/testing/selftests/mm/map_hugetlb.c
+++ b/tools/testing/selftests/mm/map_hugetlb.c
@@ -19,18 +19,6 @@
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
 
-#ifndef MAP_HUGETLB
-#define MAP_HUGETLB 0x40000 /* arch specific */
-#endif
-
-#ifndef MAP_HUGE_SHIFT
-#define MAP_HUGE_SHIFT 26
-#endif
-
-#ifndef MAP_HUGE_MASK
-#define MAP_HUGE_MASK 0x3f
-#endif
-
 /* Only ia64 requires this */
 #ifdef __ia64__
 #define ADDR (void *)(0x8000000000000000UL)
diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
index 6b8aeaa0bf7a..240f2d9dae7a 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -17,9 +17,7 @@
 #include <string.h>
 #include <unistd.h>
 
-#ifndef MMAP_SZ
 #define MMAP_SZ		4096
-#endif
 
 #define BUG_ON(condition, description)					\
 	do {								\
diff --git a/tools/testing/selftests/mm/mlock-random-test.c b/tools/testing/selftests/mm/mlock-random-test.c
index 782ea94dee2f..1fba77df7f62 100644
--- a/tools/testing/selftests/mm/mlock-random-test.c
+++ b/tools/testing/selftests/mm/mlock-random-test.c
@@ -7,6 +7,7 @@
 #include <sys/resource.h>
 #include <sys/capability.h>
 #include <sys/mman.h>
+#include <linux/mman.h>
 #include <fcntl.h>
 #include <string.h>
 #include <sys/ipc.h>
diff --git a/tools/testing/selftests/mm/mlock2.h b/tools/testing/selftests/mm/mlock2.h
index 2a6e76c226bc..8e02991b313c 100644
--- a/tools/testing/selftests/mm/mlock2.h
+++ b/tools/testing/selftests/mm/mlock2.h
@@ -4,14 +4,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 
-#ifndef MLOCK_ONFAULT
-#define MLOCK_ONFAULT 1
-#endif
-
-#ifndef MCL_ONFAULT
-#define MCL_ONFAULT (MCL_FUTURE << 1)
-#endif
-
 static int mlock2_(void *start, size_t len, int flags)
 {
 #ifdef __NR_mlock2
diff --git a/tools/testing/selftests/mm/mrelease_test.c b/tools/testing/selftests/mm/mrelease_test.c
index 37b6d33b9e84..dca21042b679 100644
--- a/tools/testing/selftests/mm/mrelease_test.c
+++ b/tools/testing/selftests/mm/mrelease_test.c
@@ -9,18 +9,10 @@
 #include <stdlib.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <asm-generic/unistd.h>
 #include "vm_util.h"
-
 #include "../kselftest.h"
 
-#ifndef __NR_pidfd_open
-#define __NR_pidfd_open -1
-#endif
-
-#ifndef __NR_process_mrelease
-#define __NR_process_mrelease -1
-#endif
-
 #define MB(x) (x << 20)
 #define MAX_SIZE_MB 1024
 
diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
index f01dc4a85b0b..ca2359835e75 100644
--- a/tools/testing/selftests/mm/mremap_dontunmap.c
+++ b/tools/testing/selftests/mm/mremap_dontunmap.c
@@ -15,10 +15,6 @@
 
 #include "../kselftest.h"
 
-#ifndef MREMAP_DONTUNMAP
-#define MREMAP_DONTUNMAP 4
-#endif
-
 unsigned long page_size;
 char *page_buffer;
 
diff --git a/tools/testing/selftests/mm/on-fault-limit.c b/tools/testing/selftests/mm/on-fault-limit.c
index 634d87dfb2a4..b5888d613f34 100644
--- a/tools/testing/selftests/mm/on-fault-limit.c
+++ b/tools/testing/selftests/mm/on-fault-limit.c
@@ -6,10 +6,6 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 
-#ifndef MCL_ONFAULT
-#define MCL_ONFAULT (MCL_FUTURE << 1)
-#endif
-
 static int test_limit(void)
 {
 	int ret = 1;
diff --git a/tools/testing/selftests/mm/pkey-powerpc.h b/tools/testing/selftests/mm/pkey-powerpc.h
index 1ebb586b2fbc..ae5df26104e5 100644
--- a/tools/testing/selftests/mm/pkey-powerpc.h
+++ b/tools/testing/selftests/mm/pkey-powerpc.h
@@ -3,9 +3,6 @@
 #ifndef _PKEYS_POWERPC_H
 #define _PKEYS_POWERPC_H
 
-#ifndef SYS_mprotect_key
-# define SYS_mprotect_key	386
-#endif
 #ifndef SYS_pkey_alloc
 # define SYS_pkey_alloc		384
 # define SYS_pkey_free		385
diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index e32ae8a1cd99..814758e109c0 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -5,29 +5,11 @@
 
 #ifdef __i386__
 
-#ifndef SYS_mprotect_key
-# define SYS_mprotect_key	380
-#endif
-
-#ifndef SYS_pkey_alloc
-# define SYS_pkey_alloc		381
-# define SYS_pkey_free		382
-#endif
-
 #define REG_IP_IDX		REG_EIP
 #define si_pkey_offset		0x14
 
 #else
 
-#ifndef SYS_mprotect_key
-# define SYS_mprotect_key	329
-#endif
-
-#ifndef SYS_pkey_alloc
-# define SYS_pkey_alloc		330
-# define SYS_pkey_free		331
-#endif
-
 #define REG_IP_IDX		REG_RIP
 #define si_pkey_offset		0x20
 
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 0381c34fdd56..48dc151f8fca 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -294,15 +294,6 @@ void pkey_access_deny(int pkey)
 	pkey_disable_set(pkey, PKEY_DISABLE_ACCESS);
 }
 
-/* Failed address bound checks: */
-#ifndef SEGV_BNDERR
-# define SEGV_BNDERR		3
-#endif
-
-#ifndef SEGV_PKUERR
-# define SEGV_PKUERR		4
-#endif
-
 static char *si_code_str(int si_code)
 {
 	if (si_code == SEGV_MAPERR)
@@ -476,7 +467,7 @@ int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
 			ptr, size, orig_prot, pkey);
 
 	errno = 0;
-	sret = syscall(SYS_mprotect_key, ptr, size, orig_prot, pkey);
+	sret = syscall(__NR_pkey_mprotect, ptr, size, orig_prot, pkey);
 	if (errno) {
 		dprintf2("SYS_mprotect_key sret: %d\n", sret);
 		dprintf2("SYS_mprotect_key prot: 0x%lx\n", orig_prot);
@@ -1684,7 +1675,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 		return;
 	}
 
-	sret = syscall(SYS_mprotect_key, ptr, size, PROT_READ, pkey);
+	sret = syscall(__NR_pkey_mprotect, ptr, size, PROT_READ, pkey);
 	pkey_assert(sret < 0);
 }
 
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index e57ace1323a7..c7fa61f0dff8 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -60,13 +60,3 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 
 #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
 #define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
-
-#ifndef MADV_PAGEOUT
-#define MADV_PAGEOUT 21
-#endif
-#ifndef MADV_POPULATE_READ
-#define MADV_POPULATE_READ 22
-#endif
-#ifndef MADV_COLLAPSE
-#define MADV_COLLAPSE 25
-#endif
-- 
2.39.2

