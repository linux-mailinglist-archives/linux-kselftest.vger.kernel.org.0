Return-Path: <linux-kselftest+bounces-13831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE9933BE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 13:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457201C22C89
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3220417F39A;
	Wed, 17 Jul 2024 11:10:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA37E3FB83;
	Wed, 17 Jul 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214638; cv=none; b=MxfpEJeT6e4bVlnT7m1+ocscDZwE+8l1h4vwK8xrCbg6cKTwEoisnryDFM1YeJ9tR+/7DX+G4xsDFbyCaCNuP0wvWNIG5ziZWpLl+6tLPbZ1DzbO7C3G/nYYehVLKVZD8M5AfMY52u7P7U96ygsQMBVqwE0YUBblwPVHcmcoE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214638; c=relaxed/simple;
	bh=nDkjnI69T9KE0jKxAoLLVrdU1MBcRYLTpfhBPKM04dM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=quiASMaacvc9wbdblBdNn0GKYGd8dwh2sp1Q+VtkgbcEVtIpXczDcDesttIqIi4EJKVYLiGjek02vn3zs0H4okmX32RKGyOwqOr93jLUlyVJ+9LRxpBsyDHj3KubUmevNxUkEev6gjc6fFXuHN3X81jIlFF1gXSWBsSuMpwvShw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 047461063;
	Wed, 17 Jul 2024 04:10:58 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.43.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 68B0B3F762;
	Wed, 17 Jul 2024 04:10:29 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Anshuman.Khandual@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] selftests/mm: Skip test for non-LPA2 and non-LVA systems
Date: Wed, 17 Jul 2024 16:40:11 +0530
Message-Id: <20240717111011.316037-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Post my improvement of the test:
https://lore.kernel.org/all/20240522070435.773918-3-dev.jain@arm.com/
The test begins to fail on 4k and 16k pages, on non-LPA2 systems. To
reduce noise in the CI systems, let us skip the test when higher address
space is not implemented.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
The patch applies on linux-next.

 tools/testing/selftests/mm/va_high_addr_switch.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
index fa7eabfaf841..c6040e1d6e53 100644
--- a/tools/testing/selftests/mm/va_high_addr_switch.c
+++ b/tools/testing/selftests/mm/va_high_addr_switch.c
@@ -293,6 +293,18 @@ static int run_test(struct testcase *test, int count)
 	return ret;
 }
 
+/* Check if userspace VA > 48 bits */
+static int high_address_present(void)
+{
+	void *ptr = mmap((void *)(1UL << 50), 1, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	if (ptr == MAP_FAILED)
+		return 0;
+
+	munmap(ptr, 1);
+	return 1;
+}
+
 static int supported_arch(void)
 {
 #if defined(__powerpc64__)
@@ -300,7 +312,7 @@ static int supported_arch(void)
 #elif defined(__x86_64__)
 	return 1;
 #elif defined(__aarch64__)
-	return 1;
+	return high_address_present();
 #else
 	return 0;
 #endif
-- 
2.34.1


