Return-Path: <linux-kselftest+bounces-34668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A310AD50B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 11:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAC21887729
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F332609C6;
	Wed, 11 Jun 2025 09:58:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E0227581;
	Wed, 11 Jun 2025 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635918; cv=none; b=DhkZZ+DsqBIjIqmDJA42Z9CgVSiDH8NKoDt5FAiDENpD0+su03r3T1N1iF+VlmSKdn+jXRdZq2GfG+PZ/DGc2/XmJzrgsExJspfAx1kiZN/MJOmhXqyvHj2xftbF1guHPapdp78NIWtRLa2fFzku3yiK3NLimfFdDHsL18/osGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635918; c=relaxed/simple;
	bh=DpPa138L+PkMw9+5t8ShqGIoXLUmpKuoPgS/XZARpHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F3hEtr/2cswYDYxw/90+xXFALTKzutjoUdaY54MivvYMihbQffStSWA7FmPDCJ4TiqWxWmBODmdRkUrE7a3b9slpo0dLITZdF/wmcif9rKh2c0wJ29heIDoewmEyf01WPbMu7zU+dhLlZBid22LF8Jgr8qQXCEV0k43OjYPGVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bHLhW1zcbzKHMfS;
	Wed, 11 Jun 2025 17:58:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9AB461A6597;
	Wed, 11 Jun 2025 17:58:33 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgDnSF1IU0lovSS5PA--.41225S2;
	Wed, 11 Jun 2025 17:58:33 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	lorenzo.stoakes@oracle.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pulehui@huawei.com
Subject: [PATCH v2] selftests/mm: Use generic read_sysfs in thuge-gen test
Date: Wed, 11 Jun 2025 10:01:06 +0000
Message-Id: <20250611100106.1331197-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSF1IU0lovSS5PA--.41225S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWfJrWkWF47Gw4xCw47XFb_yoW8tw17pF
	s3G34j9w4xtr98G34UXFs09ry5Ar4Dt3y0y3yxA34ruF18JF9IgrZ7AasrJ3WkArZ7Wayf
	Aay3Grsakr1UXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

As generic read_sysfs is available in vm_utils, let's
use is in thuge-gen test.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
v2:
- Explicit warning when ps != getpagesize(). (Lorenzo)

 tools/testing/selftests/mm/thuge-gen.c | 38 +++++++-------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index 95b6f043a3cb..8e2b08dc5762 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -77,40 +77,20 @@ void show(unsigned long ps)
 	system(buf);
 }
 
-unsigned long thuge_read_sysfs(int warn, char *fmt, ...)
+unsigned long read_free(unsigned long ps)
 {
-	char *line = NULL;
-	size_t linelen = 0;
-	char buf[100];
-	FILE *f;
-	va_list ap;
 	unsigned long val = 0;
+	char buf[100];
 
-	va_start(ap, fmt);
-	vsnprintf(buf, sizeof buf, fmt, ap);
-	va_end(ap);
+	snprintf(buf, sizeof(buf),
+		 "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
+		 ps >> 10);
+	if (read_sysfs(buf, &val) && ps != getpagesize())
+		ksft_print_msg("missing %s\n", buf);
 
-	f = fopen(buf, "r");
-	if (!f) {
-		if (warn)
-			ksft_print_msg("missing %s\n", buf);
-		return 0;
-	}
-	if (getline(&line, &linelen, f) > 0) {
-		sscanf(line, "%lu", &val);
-	}
-	fclose(f);
-	free(line);
 	return val;
 }
 
-unsigned long read_free(unsigned long ps)
-{
-	return thuge_read_sysfs(ps != getpagesize(),
-			  "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
-			  ps >> 10);
-}
-
 void test_mmap(unsigned long size, unsigned flags)
 {
 	char *map;
@@ -173,6 +153,7 @@ void test_shmget(unsigned long size, unsigned flags)
 void find_pagesizes(void)
 {
 	unsigned long largest = getpagesize();
+	unsigned long shmmax_val = 0;
 	int i;
 	glob_t g;
 
@@ -195,7 +176,8 @@ void find_pagesizes(void)
 	}
 	globfree(&g);
 
-	if (thuge_read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
+	read_sysfs("/proc/sys/kernel/shmmax", &shmmax_val);
+	if (shmmax_val < NUM_PAGES * largest)
 		ksft_exit_fail_msg("Please do echo %lu > /proc/sys/kernel/shmmax",
 				   largest * NUM_PAGES);
 
-- 
2.34.1


