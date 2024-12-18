Return-Path: <linux-kselftest+bounces-23516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4F09F6A25
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 16:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA327A1785
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 15:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C35199E8B;
	Wed, 18 Dec 2024 15:36:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A783CD2;
	Wed, 18 Dec 2024 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536195; cv=none; b=OiPoaBKKAFDEyzBMrAzfGYxpKjWN2orsEMaucjoS4zymx8XhlkOn0N0+ITOHsHfUr7Xy0nCd9VmM7VmEVC+4P9Kwkk1wt7hjjSzoUQ0zYKVAjkpk6hfapsUv1UBYaQxjGrBd5uocd6+ECNihsiOLvWDk1SpTNOZU3FrCG1kRFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536195; c=relaxed/simple;
	bh=kT4eymhP2u/GPLQ8X0Ru8V9ehbUU48RLG5RIyaDq9kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3p1YHjqylbghIjredyEtmu/DYv5uQ7yJXYiOcpFmz8Un5H8PYx9jTFSy+XZ9oW0q5MMNUjKvZpUHt10uwYITgq4jOmT30EEDhPbP0qYmGjZmREmhYpXd7J65oykRj4VOnlTMr/yrPuw2qJPWzvuHxeyfjYbQvhYOVv0y9AUTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D04C497;
	Wed, 18 Dec 2024 07:36:59 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D82623F7B4;
	Wed, 18 Dec 2024 07:36:28 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	kernel test robot <lkp@intel.com>,
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
	x86@kernel.org
Subject: [PATCH] selftests/mm: Fix -Wnull-dereference on Clang
Date: Wed, 18 Dec 2024 15:36:15 +0000
Message-ID: <20241218153615.2267571-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209095019.1732120-5-kevin.brodsky@arm.com>
References: <20241209095019.1732120-5-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dereferencing a null pointer on Clang is not a good idea - it will
entirely optimise out the dereference. Make the pointer volatile to
force the access (and fault).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412140850.4TW4YBqc-lkp@intel.com/
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

Hi Andrew,

Another fixup for an issue reported by the LKP CI (building with Clang
instead of GCC). This should be squashed into the patch I'm replying to:
"selftests/mm: Fix -Warray-bounds warnings in pkey_sighandler_tests"

Cheers,
- Kevin

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
---
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index 17bbfcd552c6..1ac8c8809880 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -161,7 +161,7 @@ static void *thread_segv_with_pkey0_disabled(void *ptr)
 	__write_pkey_reg(pkey_reg_restrictive_default());
 
 	/* Segfault (with SEGV_MAPERR) */
-	*(int *)NULL = 1;
+	*(volatile int *)NULL = 1;
 	return NULL;
 }
 
@@ -192,7 +192,7 @@ static void *thread_segv_maperr_ptr(void *ptr)
 	__write_pkey_reg(pkey_reg);
 
 	/* Segfault */
-	*(int *)NULL = 1;
+	*(volatile int *)NULL = 1;
 	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
 	return NULL;
 }
-- 
2.47.0


