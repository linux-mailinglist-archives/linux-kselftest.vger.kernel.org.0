Return-Path: <linux-kselftest+bounces-3621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76D583D939
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 12:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C881C2452C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 11:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C9814016;
	Fri, 26 Jan 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Eo4Ds7gZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476317BA3;
	Fri, 26 Jan 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268096; cv=none; b=UrCRisd6gL/fEctRsBIS6uFsy/rODNhqK2EEl+SGmWD4qQzk4w8H1rLxSwgmDyGJSJGu4kn6+yIW1Q8OBIl3MFemGINw85RoW1IQdSy94wKSAlfrFGBuROoxIsbkSo5WE0N7h7GfzEttePPkPKk00L/LLc8TQgv61XaUes2fiwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268096; c=relaxed/simple;
	bh=zr0XdrCeozGCHNrEz9eIS0AqUmrXwsL2hLb6jsLfr0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Li+sUi38BVDGIA7XAvaPLcBD/g79tVSEXS2NcR1LP9lUQj8c4h4kRgsfR5PDwyBl6u7FN591mRQ2F9Tnq3w5oDeuvl52jX0DJoeLL6OQK9CzuBbKhudtraSKmnnesjL2gPhtNNGAM9UeRYtwD8uWLPejyoSX/PGuRgfjSEWRIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Eo4Ds7gZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706268092;
	bh=zr0XdrCeozGCHNrEz9eIS0AqUmrXwsL2hLb6jsLfr0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=Eo4Ds7gZ0n2T2bHkapPWCIldbMKQXWdm+7CVk8150CPq/ZGvWKp3/E1zTxJas7uvu
	 83oi/D4WO04eqIYu0a0qVMWLJ4x1xKAdQfxecmV8wSyxID6hrRAiqghTSbaU9ycl//
	 cxknX56Yg42Mu7l4RIFG4ga0CLPx5YjcsjBYctX+nJWWeB/T1Cnmt9gP+OKpURA1Ph
	 JFa8C/KAx/Uce4l6WMkjPpc5guCMqJcVckIloWKp0zD1PsFD0OfhPxBu2+jeBvVpYl
	 yceXbDGg25Mk2bttqkiggQGRjAuPWPLqBemd8A51ApZ6O+4VpxmiMpJ2JFWDf8JLM7
	 uzElHOGqwpxhA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4B6ED3782072;
	Fri, 26 Jan 2024 11:21:30 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] selftests/mm: hugepage-shm: conform test to TAP format output
Date: Fri, 26 Jan 2024 16:21:20 +0500
Message-ID: <20240126112129.1480265-1-usama.anjum@collabora.com>
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
Changes since v3:
- Rebased on top of next-20230125
---
 tools/testing/selftests/mm/hugepage-shm.c | 47 +++++++++++------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-shm.c b/tools/testing/selftests/mm/hugepage-shm.c
index 478bb1e989e9f..f949dbbc34540 100644
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


