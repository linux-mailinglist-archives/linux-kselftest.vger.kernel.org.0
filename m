Return-Path: <linux-kselftest+bounces-10561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA6E8CBBB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 09:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE4AB21829
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 07:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520D77D3E3;
	Wed, 22 May 2024 07:05:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB5F7D071;
	Wed, 22 May 2024 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716361505; cv=none; b=i6nQb0kl1gkJFStuNwLlpPqMlC2Enq/VCCagjpUIjcVXHWys+qdsm7M+x9L0cFEM3ObQTtUrfTrC2y2LKSbQRXjviyMP0DJtVGJthUS2afugUnpR+1yqIcsHGkc15zNUf64FpyE9vVCi7pqlNt9JF9ys2p7HwmxENDgFN42FBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716361505; c=relaxed/simple;
	bh=zHaooG3MwdGhCLeY+FbW88/Y5r8BsUKDwWXFlM6+5gU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LND19/o56QMzsCAyEuOX4WVKrt7lmSDvjCUNi2hnOI0GtG0el7cT9AIcmtIxnKCcNGw4AM49dwdIyRLbosBZQLVznR278n9iXZK+cRNpbi6pA1+Ig05YPjV3Cp1sp+MELEOajpFNfm/2EDbVPLCZFkRBhKfG2YET44G31UFbbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15FB4DA7;
	Wed, 22 May 2024 00:05:21 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C78AC3F766;
	Wed, 22 May 2024 00:04:53 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	kirill.shutemov@linux.intel.com,
	AneeshKumar.KizhakeVeetil@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 1/2] selftests/mm: va_high_addr_switch: Reduce test noise
Date: Wed, 22 May 2024 12:34:34 +0530
Message-Id: <20240522070435.773918-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522070435.773918-1-dev.jain@arm.com>
References: <20240522070435.773918-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When invoking the binary with "--run-hugetlb" flag, the testcases
involving the base page are anyways going to be run. Therefore, remove
duplication by invoking the binary only once.
 
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/va_high_addr_switch.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
index a0a75f302904..2c725773cd79 100755
--- a/tools/testing/selftests/mm/va_high_addr_switch.sh
+++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
@@ -57,8 +57,4 @@ check_test_requirements()
 }
 
 check_test_requirements
-./va_high_addr_switch
-
-# In order to run hugetlb testcases, "--run-hugetlb" must be appended
-# to the binary.
 ./va_high_addr_switch --run-hugetlb
-- 
2.34.1


