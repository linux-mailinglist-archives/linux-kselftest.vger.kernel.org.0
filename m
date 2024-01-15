Return-Path: <linux-kselftest+bounces-2961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED82882D498
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 08:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05FB8B20A53
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D53C0E;
	Mon, 15 Jan 2024 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GXO9YEPS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9541663AA;
	Mon, 15 Jan 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705303984;
	bh=rRQZLwAtR4o/VCOAcxTzVSxdZ70bLgI9faWJJSJCsAc=;
	h=From:To:Cc:Subject:Date:From;
	b=GXO9YEPS9ah8KzQBBmYq2zTQ8EXx61CYFKebrzMonKYCXxDbjWZTjw7hHmB00Irk4
	 qG4tgLvhIH/RZlwBB/Us60q5DJWpt+EgCDQiD6mj3stX0zVEiIBZPXAXOkz1OebYVi
	 SWvpwFyk+zxxpuufBiddr/mgfEpmFBKEhnhpB5H+LjpQm9rGth+Nqnlsem98XSw+84
	 edi3gQdsTxJwMcFw71BUCVdkhtPOunql0K3TLyAnOmek8pRNGhSqpvSMW9b6zyC0YA
	 sHvs+MzaU9+NKaVOM/0ZAwvcaaygPhcB24md/WrHWhslctzLv4F51+qv6Iiq8Efqrr
	 8jtdxvayhgIIA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DFFA737813DD;
	Mon, 15 Jan 2024 07:33:02 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] selftests/mm: hugepage-shm: conform test to TAP format output
Date: Mon, 15 Jan 2024 12:32:37 +0500
Message-ID: <20240115073247.1280266-1-usama.anjum@collabora.com>
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

The "." was being printed inside for loop to indicate the writes
progress. This was extraneous and hence removed in the patch.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/hugepage-shm.c | 47 +++++++++++------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-shm.c b/tools/testing/selftests/mm/hugepage-shm.c
index 478bb1e989e9..f949dbbc3454 100644
--- a/tools/testing/selftests/mm/hugepage-shm.c
+++ b/tools/testing/selftests/mm/hugepage-shm.c
@@ -34,11 +34,10 @@
 #include <sys/ipc.h>
 #include <sys/shm.h>
 #include <sys/mman.h>
+#include "../kselftest.h"
 
 #define LENGTH (256UL*1024*1024)
 
-#define dprintf(x)  printf(x)
-
 /* Only ia64 requires this */
 #ifdef __ia64__
 #define ADDR (void *)(0x8000000000000000UL)
@@ -54,44 +53,42 @@ int main(void)
 	unsigned long i;
 	char *shmaddr;
 
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	shmid = shmget(2, LENGTH, SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
-	if (shmid < 0) {
-		perror("shmget");
-		exit(1);
-	}
-	printf("shmid: 0x%x\n", shmid);
+	if (shmid < 0)
+		ksft_exit_fail_msg("shmget: %s\n", strerror(errno));
+
+	ksft_print_msg("shmid: 0x%x\n", shmid);
 
 	shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
 	if (shmaddr == (char *)-1) {
-		perror("Shared memory attach failure");
 		shmctl(shmid, IPC_RMID, NULL);
-		exit(2);
+		ksft_exit_fail_msg("Shared memory attach failure: %s\n", strerror(errno));
 	}
-	printf("shmaddr: %p\n", shmaddr);
 
-	dprintf("Starting the writes:\n");
-	for (i = 0; i < LENGTH; i++) {
+	ksft_print_msg("shmaddr: %p\n", shmaddr);
+
+	ksft_print_msg("Starting the writes:");
+	for (i = 0; i < LENGTH; i++)
 		shmaddr[i] = (char)(i);
-		if (!(i % (1024 * 1024)))
-			dprintf(".");
-	}
-	dprintf("\n");
+	ksft_print_msg("Done.\n");
 
-	dprintf("Starting the Check...");
+	ksft_print_msg("Starting the Check...");
 	for (i = 0; i < LENGTH; i++)
-		if (shmaddr[i] != (char)i) {
-			printf("\nIndex %lu mismatched\n", i);
-			exit(3);
-		}
-	dprintf("Done.\n");
+		if (shmaddr[i] != (char)i)
+			ksft_exit_fail_msg("\nIndex %lu mismatched\n", i);
+	ksft_print_msg("Done.\n");
 
 	if (shmdt((const void *)shmaddr) != 0) {
-		perror("Detach failure");
 		shmctl(shmid, IPC_RMID, NULL);
-		exit(4);
+		ksft_exit_fail_msg("Detach failure: %s\n", strerror(errno));
 	}
 
 	shmctl(shmid, IPC_RMID, NULL);
 
-	return 0;
+	ksft_test_result_pass("Completed test\n");
+
+	ksft_finished();
 }
-- 
2.42.0


