Return-Path: <linux-kselftest+bounces-2549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21318821764
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 06:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181771C211C2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 05:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F97BED6;
	Tue,  2 Jan 2024 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y/L8t0BE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C20423C3;
	Tue,  2 Jan 2024 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704173561;
	bh=2juRjiTk2yf2Invlzo8FhJ7DM0AxRqUdtU6w5CejRpQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Y/L8t0BEZ/W9E4wQ8+eUXmBSexrMU4m1q++W2phLH2hRmo0DZWlI5Qf+7t8C4VQs/
	 cB46jRgqbHaxXyB6cD0szhIWV7M+ejNMHkwCCNSl8OCgCQhkWKUl5sCA+IqkTPLs20
	 9aYiyjR+vnsRaltJjDlq8uk7D3ySnNntMcEitiyU7G6sMqCae4dv+206znDCkVMiSL
	 Qq6F5nvCdwkQx8OiF3Y613+xjK/ZZy8P9KC4QIM9lvBN1OhmDYZ75JNV1KqdFHPSyt
	 8wudk/47hy0pnVxwB4idNKG1Pd+m18ESUUrB9h5KebqNXAv+vQwdAeJ8XWaSEuoa7Y
	 8vzyTpyx6fafg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9A3C83780C21;
	Tue,  2 Jan 2024 05:32:39 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: mm: hugepage-mmap: conform to TAP format output
Date: Tue,  2 Jan 2024 10:32:22 +0500
Message-ID: <20240102053223.2099572-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/hugepage-mmap.c | 23 ++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-mmap.c b/tools/testing/selftests/mm/hugepage-mmap.c
index 955ef87f382c..267eea2e0e0b 100644
--- a/tools/testing/selftests/mm/hugepage-mmap.c
+++ b/tools/testing/selftests/mm/hugepage-mmap.c
@@ -22,6 +22,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include "../kselftest.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -37,7 +38,7 @@
 
 static void check_bytes(char *addr)
 {
-	printf("First hex is %x\n", *((unsigned int *)addr));
+	ksft_print_msg("First hex is %x\n", *((unsigned int *)addr));
 }
 
 static void write_bytes(char *addr)
@@ -55,7 +56,7 @@ static int read_bytes(char *addr)
 	check_bytes(addr);
 	for (i = 0; i < LENGTH; i++)
 		if (*(addr + i) != (char)i) {
-			printf("Mismatch at %lu\n", i);
+			ksft_print_msg("Error: Mismatch at %lu\n", i);
 			return 1;
 		}
 	return 0;
@@ -66,20 +67,20 @@ int main(void)
 	void *addr;
 	int fd, ret;
 
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	fd = memfd_create("hugepage-mmap", MFD_HUGETLB);
-	if (fd < 0) {
-		perror("memfd_create() failed");
-		exit(1);
-	}
+	if (fd < 0)
+		ksft_exit_fail_msg("memfd_create() failed: %s\n", strerror(errno));
 
 	addr = mmap(ADDR, LENGTH, PROTECTION, FLAGS, fd, 0);
 	if (addr == MAP_FAILED) {
-		perror("mmap");
 		close(fd);
-		exit(1);
+		ksft_exit_fail_msg("mmap(): %s\n", strerror(errno));
 	}
 
-	printf("Returned address is %p\n", addr);
+	ksft_print_msg("Returned address is %p\n", addr);
 	check_bytes(addr);
 	write_bytes(addr);
 	ret = read_bytes(addr);
@@ -87,5 +88,7 @@ int main(void)
 	munmap(addr, LENGTH);
 	close(fd);
 
-	return ret;
+	ksft_test_result(!ret, "Read same data\n");
+
+	ksft_exit(!ret);
 }
-- 
2.42.0


