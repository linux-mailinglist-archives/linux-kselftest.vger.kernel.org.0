Return-Path: <linux-kselftest+bounces-34662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AB2AD4E94
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBF71BC1D48
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60696243370;
	Wed, 11 Jun 2025 08:37:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C669243969;
	Wed, 11 Jun 2025 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631064; cv=none; b=UDLH53o2O9SWFnyM2azZBjjlw/VpuEUf4PBtHzH+69eqQ7dVoZmTasZG6YztxpTbgSkMASkBzF9jawQqSEAyY8sVGQRSkwR8+hrg6tSuuJmh4oSplgYLjWv34r5fsSa6CoLFQhfumtoLK5mkIJnQCHT1HzfyTlerEtwnNOpDHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631064; c=relaxed/simple;
	bh=YMXTcyMncS+OYLcYJJSBaiK//v5mGME8+PN5/+MBWsg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IrMQ7LJTTf2ak4OFfnXcSWQ8wBRsL4wSifLoX2TnLz1wR1mtS30o4mrXEgHkE81Zqz8TXowYzUYV40bXOqxSHEb4+DogBJyK42+B0EW1WOaKtJiKA/W7yoJkGP+L2SJuO8JONcCQjrfKD/pXjhZaF2KeYkryh4U2VtJdJlGX/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bHJv80H56zKHN79;
	Wed, 11 Jun 2025 16:37:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 60FF21A0AF7;
	Wed, 11 Jun 2025 16:37:38 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgDHhGdRQEloV8o1PA--.29312S2;
	Wed, 11 Jun 2025 16:37:38 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	lorenzo.stoakes@oracle.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pulehui@huawei.com
Subject: [PATCH] selftests/mm: Use generic read_sysfs in thuge-gen test
Date: Wed, 11 Jun 2025 08:40:11 +0000
Message-Id: <20250611084011.1047132-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHhGdRQEloV8o1PA--.29312S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWDCr4rXr1rWw48GFWDXFb_yoW8ury5pF
	s3K34j93yxKr98GryUXFs8Wry5Ar4Dt3y0y397A34rZw1UJr9IgrZ7ZasrJa1kurZ7Wayf
	Aay3Grsakr1UJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

As generic read_sysfs is available in vm_utils, let's
use is in thuge-gen test.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/mm/thuge-gen.c | 37 +++++++-------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index 95b6f043a3cb..e11dfbfa661b 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -77,40 +77,19 @@ void show(unsigned long ps)
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
+	read_sysfs(buf, &val);
 
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
@@ -173,6 +152,7 @@ void test_shmget(unsigned long size, unsigned flags)
 void find_pagesizes(void)
 {
 	unsigned long largest = getpagesize();
+	unsigned long shmmax_val = 0;
 	int i;
 	glob_t g;
 
@@ -195,7 +175,8 @@ void find_pagesizes(void)
 	}
 	globfree(&g);
 
-	if (thuge_read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
+	read_sysfs("/proc/sys/kernel/shmmax", &shmmax_val);
+	if (shmmax_val < NUM_PAGES * largest)
 		ksft_exit_fail_msg("Please do echo %lu > /proc/sys/kernel/shmmax",
 				   largest * NUM_PAGES);
 
-- 
2.34.1


