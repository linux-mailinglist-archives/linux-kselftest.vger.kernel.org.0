Return-Path: <linux-kselftest+bounces-8409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC5F8AA96C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 09:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B82E1C21BC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF21054907;
	Fri, 19 Apr 2024 07:44:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4391C4CE12;
	Fri, 19 Apr 2024 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512647; cv=none; b=RZwM6uDTi6m0453wQWE4QE9iVf/XRRt0udeyij66dEmrsHhAl+LwMFSrBtB7L0c7HwfRZmFkC0Yfx5JLAjrOZ+RWb8kr5/jEwL3VF0ZxIFm2QMEF5MsefigVScLoN2tbHdtCl9T9mp/A8LP6BvOG+xbnRJr4cvHNB/cfTR/lVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512647; c=relaxed/simple;
	bh=nokdrwL4556IzeyiKU8jJaU6NofPKf4P+wYN5FKPACI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUyjUwcwxyQ3yNkH8Yv5DIARpNTuEwUDaDrBx3IIFRiudvs1CZV5slPnRK9ZgjBk/V3SHZzuj7WZ+n51Sej49Eo7MbtsgZiBntWqgYUBipeAUsV9yUMm5x+WO9y7ZV8RXTzYtiwI1EZZNXVYGs6zEZxaiEV5ioyE/HNhcY/ZG7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD9682F;
	Fri, 19 Apr 2024 00:44:33 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F6D43F792;
	Fri, 19 Apr 2024 00:44:03 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Shivansh Vij <shivanshvij@outlook.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 4/5] selftests/mm: Enable soft-dirty tests on arm64
Date: Fri, 19 Apr 2024 08:43:43 +0100
Message-Id: <20240419074344.2643212-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419074344.2643212-1-ryan.roberts@arm.com>
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that arm64 supports soft-dirty tracking lets enable the tests, which
were previously disabled for arm64 to reduce noise.

This reverts commit f6dd4e223d87 ("selftests/mm: skip soft-dirty tests
on arm64").

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/Makefile        |  5 +----
 tools/testing/selftests/mm/madv_populate.c | 26 ++--------------------
 tools/testing/selftests/mm/run_vmtests.sh  |  5 +----
 3 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index eb5f39a2668b..7f1a6ad09534 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -65,6 +65,7 @@ TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += uffd-stress
 TEST_GEN_FILES += uffd-unit-tests
+TEST_GEN_FILES += soft-dirty
 TEST_GEN_FILES += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
 TEST_GEN_FILES += ksm_functional_tests
@@ -72,10 +73,6 @@ TEST_GEN_FILES += mdwe_test
 TEST_GEN_FILES += hugetlb_fault_after_madv
 TEST_GEN_FILES += hugetlb_madv_vs_map

-ifneq ($(ARCH),arm64)
-TEST_GEN_FILES += soft-dirty
-endif
-
 ifeq ($(ARCH),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
 CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_program.c)
diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index 17bcb07f19f3..60547245e479 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -264,35 +264,14 @@ static void test_softdirty(void)
 	munmap(addr, SIZE);
 }

-static int system_has_softdirty(void)
-{
-	/*
-	 * There is no way to check if the kernel supports soft-dirty, other
-	 * than by writing to a page and seeing if the bit was set. But the
-	 * tests are intended to check that the bit gets set when it should, so
-	 * doing that check would turn a potentially legitimate fail into a
-	 * skip. Fortunately, we know for sure that arm64 does not support
-	 * soft-dirty. So for now, let's just use the arch as a corse guide.
-	 */
-#if defined(__aarch64__)
-	return 0;
-#else
-	return 1;
-#endif
-}
-
 int main(int argc, char **argv)
 {
-	int nr_tests = 16;
 	int err;

 	pagesize = getpagesize();

-	if (system_has_softdirty())
-		nr_tests += 5;
-
 	ksft_print_header();
-	ksft_set_plan(nr_tests);
+	ksft_set_plan(21);

 	sense_support();
 	test_prot_read();
@@ -300,8 +279,7 @@ int main(int argc, char **argv)
 	test_holes();
 	test_populate_read();
 	test_populate_write();
-	if (system_has_softdirty())
-		test_softdirty();
+	test_softdirty();

 	err = ksft_get_fail_cnt();
 	if (err)
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index c2c542fe7b17..29806d352c73 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -395,10 +395,7 @@ then
 	CATEGORY="pkey" run_test ./protection_keys_64
 fi

-if [ -x ./soft-dirty ]
-then
-	CATEGORY="soft_dirty" run_test ./soft-dirty
-fi
+CATEGORY="soft_dirty" run_test ./soft-dirty

 CATEGORY="pagemap" run_test ./pagemap_ioctl

--
2.25.1


