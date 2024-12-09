Return-Path: <linux-kselftest+bounces-23004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 453DD9E8F3D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7843A1622F0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8B0216E36;
	Mon,  9 Dec 2024 09:50:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715C8216E33;
	Mon,  9 Dec 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737855; cv=none; b=Mmy9gJGve/EowFIWIRuLT0cx5Rc0GBC1P/ELW0kvlipXgKNAyQcJ9Ahn11kjDXl5+oA7L9XgNaCtMZBgqjUjr8dXt+oEDYVnM+rdP17meuN24bQ5V5znGOP2ZYSzbyXAYTLExmzJmqyhWgZFJPRvJGoJ1UzsEELpauaxesLuwno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737855; c=relaxed/simple;
	bh=OTGf8VEEawHsSwgCO/QNszJeSLWzUA2hrxo/Kg8O+pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzZ0b46EC9nLuOIAK4cT8uOt7fLGzvVcd0CWp0Urffagw6XjUjh0aZVfiHmEoteALgnK94/ZgzUOBKZXVQM60Txg+yrcftMZtGv+z+fnAUzrok21uxI7fy6eeypbItT8PZu4pdVXR8nw05aBDQstsmDd/pbFhml/IWuoWx5vEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20D711650;
	Mon,  9 Dec 2024 01:51:21 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 173E63F720;
	Mon,  9 Dec 2024 01:50:50 -0800 (PST)
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
Subject: [PATCH 06/14] selftests/mm: Remove unused pkey helpers
Date: Mon,  9 Dec 2024 09:50:11 +0000
Message-ID: <20241209095019.1732120-7-kevin.brodsky@arm.com>
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

Commit 5f23f6d082a9 ("x86/pkeys: Add self-tests") introduced a
number of helpers and functions that don't seem to have ever been
used. Let's remove them.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pkey-helpers.h    | 34 --------------------
 tools/testing/selftests/mm/protection_keys.c | 34 --------------------
 2 files changed, 68 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index f7cfe163b0ff..472febd992eb 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -26,9 +26,7 @@
 #ifndef DEBUG_LEVEL
 #define DEBUG_LEVEL 0
 #endif
-#define DPRINT_IN_SIGNAL_BUF_SIZE 4096
 extern int dprint_in_signal;
-extern char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
 
 extern int test_nr;
 extern int iteration_nr;
@@ -171,38 +169,6 @@ static inline void write_pkey_reg(u64 pkey_reg)
 			pkey_reg, __read_pkey_reg());
 }
 
-/*
- * These are technically racy. since something could
- * change PKEY register between the read and the write.
- */
-static inline void __pkey_access_allow(int pkey, int do_allow)
-{
-	u64 pkey_reg = read_pkey_reg();
-	int bit = pkey * 2;
-
-	if (do_allow)
-		pkey_reg &= (1<<bit);
-	else
-		pkey_reg |= (1<<bit);
-
-	dprintf4("pkey_reg now: %016llx\n", read_pkey_reg());
-	write_pkey_reg(pkey_reg);
-}
-
-static inline void __pkey_write_allow(int pkey, int do_allow_write)
-{
-	u64 pkey_reg = read_pkey_reg();
-	int bit = pkey * 2 + 1;
-
-	if (do_allow_write)
-		pkey_reg &= (1<<bit);
-	else
-		pkey_reg |= (1<<bit);
-
-	write_pkey_reg(pkey_reg);
-	dprintf4("pkey_reg now: %016llx\n", read_pkey_reg());
-}
-
 #define ALIGN_UP(x, align_to)	(((x) + ((align_to)-1)) & ~((align_to)-1))
 #define ALIGN_DOWN(x, align_to) ((x) & ~((align_to)-1))
 #define ALIGN_PTR_UP(p, ptr_align_to)	\
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 4990f7ab4cb7..fcbebc4490b4 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -53,7 +53,6 @@ int test_nr;
 
 u64 shadow_pkey_reg;
 int dprint_in_signal;
-char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
 
 void cat_into_file(char *str, char *file)
 {
@@ -397,12 +396,6 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	dprint_in_signal = 0;
 }
 
-int wait_all_children(void)
-{
-	int status;
-	return waitpid(-1, &status, 0);
-}
-
 void sig_chld(int x)
 {
 	dprint_in_signal = 1;
@@ -817,39 +810,12 @@ void *malloc_pkey_hugetlb(long size, int prot, u16 pkey)
 	return ptr;
 }
 
-void *malloc_pkey_mmap_dax(long size, int prot, u16 pkey)
-{
-	void *ptr;
-	int fd;
-
-	dprintf1("doing %s(size=%ld, prot=0x%x, pkey=%d)\n", __func__,
-			size, prot, pkey);
-	pkey_assert(pkey < NR_PKEYS);
-	fd = open("/dax/foo", O_RDWR);
-	pkey_assert(fd >= 0);
-
-	ptr = mmap(0, size, prot, MAP_SHARED, fd, 0);
-	pkey_assert(ptr != (void *)-1);
-
-	mprotect_pkey(ptr, size, prot, pkey);
-
-	record_pkey_malloc(ptr, size, prot);
-
-	dprintf1("mmap()'d for pkey %d @ %p\n", pkey, ptr);
-	close(fd);
-	return ptr;
-}
-
 void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
 
 	malloc_pkey_with_mprotect,
 	malloc_pkey_with_mprotect_subpage,
 	malloc_pkey_anon_huge,
 	malloc_pkey_hugetlb
-/* can not do direct with the pkey_mprotect() API:
-	malloc_pkey_mmap_direct,
-	malloc_pkey_mmap_dax,
-*/
 };
 
 void *malloc_pkey(long size, int prot, u16 pkey)
-- 
2.47.0


