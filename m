Return-Path: <linux-kselftest+bounces-10281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F738C70C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 05:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4074AB2221C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 03:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C029A9;
	Thu, 16 May 2024 03:58:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1AFB642;
	Thu, 16 May 2024 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715831914; cv=none; b=HIZb00DNGMLCtTOPTKzTXbd71hwcrWYhtRVUUaPu/dwoKWVCGGPk7AlC9r3lyscMrrhM1JPdgejX0Ijmi2dhjR4W3tVF3rsU8LEAkRfJqbg0f9JHT14Z3UjcuLIzqGajoRtYYShELiAZssaMwmLCmvwQFIFgSRWUBmi6pL7yKdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715831914; c=relaxed/simple;
	bh=Zhefvo70pHJbj6XKrgOY//OVMBUuvPbNTjnSlKyaCYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jMkQe85vOLilJXLrSW6QAX2VtlAXYdbSTn/oAzpmG7vCU059hor77Cu1SKsJ21Ucbj0hZJubAw4/VkDVzDjG6FuF0kiikDDgjSLWUI5eJQpwiDXOR6kFSzD+wMICn0u5AbHD0ZlCt+GULKkf71sInZKV/5i1jik2shfyFv2HHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96F8BDA7;
	Wed, 15 May 2024 20:58:55 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CBDA33F762;
	Wed, 15 May 2024 20:58:27 -0700 (PDT)
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
Subject: [PATCH] selftests/mm: va_high_addr_switch: Do not skip test and give warning message post FEAT_LPA2
Date: Thu, 16 May 2024 09:26:33 +0530
Message-Id: <20240516035633.143793-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Post FEAT_LPA2, Aarch64 extends the 4KB and 16KB translation granule to
large virtual addresses. Currently, the test is being skipped for said
granule sizes, because the page sizes have been statically defined; to
work around that would mean breaking the nice array of structs used for
adding testcases. Instead, don't skip the test, and encourage the user
to manually change the macros.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 .../testing/selftests/mm/va_high_addr_switch.c  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
index cfbc501290d3..ba862f51d395 100644
--- a/tools/testing/selftests/mm/va_high_addr_switch.c
+++ b/tools/testing/selftests/mm/va_high_addr_switch.c
@@ -292,12 +292,24 @@ static int supported_arch(void)
 #elif defined(__x86_64__)
 	return 1;
 #elif defined(__aarch64__)
-	return getpagesize() == PAGE_SIZE;
+	return 1;
 #else
 	return 0;
 #endif
 }
 
+#if defined(__aarch64__)
+void failure_message(void)
+{
+	printf("TEST MAY FAIL: Are you running on a pagesize other than 64K?\n");
+	printf("If yes, please change macros manually. Ensure to change the\n");
+	printf("address macros too if running defconfig on 16K pagesize,\n");
+	printf("since userspace VA = 47 bits post FEAT_LPA2.\n");
+}
+#else
+void failure_message(void) {}
+#endif
+
 int main(int argc, char **argv)
 {
 	int ret;
@@ -308,5 +320,8 @@ int main(int argc, char **argv)
 	ret = run_test(testcases, ARRAY_SIZE(testcases));
 	if (argc == 2 && !strcmp(argv[1], "--run-hugetlb"))
 		ret = run_test(hugetlb_testcases, ARRAY_SIZE(hugetlb_testcases));
+
+	if (ret)
+		failure_message();
 	return ret;
 }
-- 
2.39.2


