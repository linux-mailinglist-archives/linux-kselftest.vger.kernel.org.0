Return-Path: <linux-kselftest+bounces-13862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2503F934795
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 07:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563991C20FFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 05:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD4942078;
	Thu, 18 Jul 2024 05:25:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E38800;
	Thu, 18 Jul 2024 05:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721280323; cv=none; b=KKHuMAylwAGYq9C1CFVb5FZnAkammQIyRphiAyfp/nmFB4Ou/vtkGPUNH+Q6cKNx86bNNiwftFwEBYlUhS08grMOyrCZCUEQyTWEhxDguSz5vSHHmnotegk+7dbfiUWVgHALX7NhTPGIYQHFujTfZkR3RmBtsdFoAPws/3on37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721280323; c=relaxed/simple;
	bh=LYzfa7TtiK5UVAdOzXGtjV/cw1DkMVWzYJHOLDgebsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SuEe2jtVw3vBbJDBbFj7ivQJPHz8NObPIecnFez7QxnjVk2l4N1VUATpuLDku18xuJ0hj/uF+xffJ91T9mEuB4N+lOMw1wpWhIm3hIbonFnTozoPRYLAF8Fyts6tkNnD6jQKqcKCNOsu5YG0vZM7VLkgSNXHCsGp5FoPLIsf2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 728E91063;
	Wed, 17 Jul 2024 22:25:44 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE6013F766;
	Wed, 17 Jul 2024 22:25:15 -0700 (PDT)
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
Subject: [PATCH v2] selftests/mm: Skip test for non-LPA2 and non-LVA systems
Date: Thu, 18 Jul 2024 10:55:04 +0530
Message-Id: <20240718052504.356517-1-dev.jain@arm.com>
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

v1->v2:
 - Guard with ifdeffery to prevent compiler warning on other arches

Signed-off-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
The patch applies on linux-next.

 tools/testing/selftests/mm/va_high_addr_switch.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
index fa7eabfaf841..896b3f73fc53 100644
--- a/tools/testing/selftests/mm/va_high_addr_switch.c
+++ b/tools/testing/selftests/mm/va_high_addr_switch.c
@@ -293,6 +293,20 @@ static int run_test(struct testcase *test, int count)
 	return ret;
 }
 
+#ifdef __aarch64__
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
+#endif
+
 static int supported_arch(void)
 {
 #if defined(__powerpc64__)
@@ -300,7 +314,7 @@ static int supported_arch(void)
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


