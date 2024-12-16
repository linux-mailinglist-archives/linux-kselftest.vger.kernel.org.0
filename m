Return-Path: <linux-kselftest+bounces-23400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B25B9F2CFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 10:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E21161964
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29A1201026;
	Mon, 16 Dec 2024 09:29:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA9A1B87C4;
	Mon, 16 Dec 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341358; cv=none; b=Pu9QwzV1idsfDw5vjc00uqLXn7RzT1jiT8ZcI28g/bj59p+snDn8zcTAHL8aSOHbJfXfsN15Y2wxV8gcXnjzYItilDcpe7zqXEHMcBSZK7alNh9KPhAeUzohQxQeRsH/ALql0N+D2Z1TKZ6CYFhbzQhQ900fl8XOq1TuHFqqFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341358; c=relaxed/simple;
	bh=7SNDHByJZN/N/alTZ/vDDjLBiORwwXzaGk0GZxKmI0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQqZ+8CPYqbfa3ClBnjqPV1gDx3okeCElYb/sFRzpxiXV15z9mXYGxkEnywmXoCT05YSUnqKH/706l9JSaANz4vZ9mLHzUKlGwTokznZieL1y8L9taMW5Udz4OTIjOUJCbe2htjxdBIblsId3pDKQv29/JHIl0T8xgT4qUsEQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46E1A113E;
	Mon, 16 Dec 2024 01:29:43 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E73313F720;
	Mon, 16 Dec 2024 01:29:12 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	aruna.ramakrishna@oracle.com,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH] selftests/mm: fix dependency on pkey_util.c
Date: Mon, 16 Dec 2024 09:28:49 +0000
Message-ID: <20241216092849.2140850-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <Z19Tl30BuKTfL629@tuxmaker.boeblingen.de.ibm.com>
References: <Z19Tl30BuKTfL629@tuxmaker.boeblingen.de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pkey* files can only be built on architectures that support
pkeys (pkey-helpers.h #error's otherwise). Adding pkey_util.c as
dependency to all $(TEST_GEN_FILES) is therefore a bad idea. Make it
a dependency of the pkeys tests only.

Those tests are built in 32/64-bit variants on x86_64 so we need to
add an explicit dependency there as well.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

Hi Alexander,

Thank you for the bug report, that patch indeed breaks all
architectures that don't support pkeys, I should have realised that!
This patch should fix it.

Andrew, it would make sense to squash this patch into the original
("selftests/mm: Use sys_pkey helpers consistently").

Cheers,
- Kevin

Cc: akpm@linux-foundation.org
Cc: aruna.ramakrishna@oracle.com
Cc: catalin.marinas@arm.com
Cc: dave.hansen@linux.intel.com
Cc: joey.gouly@arm.com
Cc: keith.lucas@oracle.com
Cc: ryan.roberts@arm.com
Cc: shuah@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: x86@kernel.org
Cc: linux-s390@vger.kernel.org
---
 tools/testing/selftests/mm/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 1f0743d9459d..18041de1aebf 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -147,16 +147,20 @@ TEST_FILES += write_hugetlb_memory.sh
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS): vm_util.c thp_settings.c pkey_util.c
-$(TEST_GEN_FILES): vm_util.c thp_settings.c pkey_util.c
+$(TEST_GEN_PROGS): vm_util.c thp_settings.c
+$(TEST_GEN_FILES): vm_util.c thp_settings.c
 
 $(OUTPUT)/uffd-stress: uffd-common.c
 $(OUTPUT)/uffd-unit-tests: uffd-common.c
+$(OUTPUT)/protection_keys: pkey_util.c
+$(OUTPUT)/pkey_sighandler_tests: pkey_util.c
 
 ifeq ($(ARCH),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
+$(BINARIES_32) $(BINARIES_64): pkey_util.c
+
 define gen-target-rule-32
 $(1) $(1)_32: $(OUTPUT)/$(1)_32
 .PHONY: $(1) $(1)_32
-- 
2.47.0


