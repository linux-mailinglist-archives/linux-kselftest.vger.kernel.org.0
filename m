Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DA81B04A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDTIms (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 04:42:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60734 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTIms (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 04:42:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jQS0n-00069P-Op; Mon, 20 Apr 2020 08:42:41 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2][next] selftests: khugepaged: fix several spelling mistakes
Date:   Mon, 20 Apr 2020 09:42:41 +0100
Message-Id: <20200420084241.65433-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There a are several spelling mistakes in various messages. Fix these.

There are three spelling mistakes in various messages. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/vm/khugepaged.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
index 490055290d7f..399a67d54e52 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -537,7 +537,7 @@ static void collapse_max_ptes_none(void)
 	p = alloc_mapping();
 
 	fill_memory(p, 0, (hpage_pmd_nr - max_ptes_none - 1) * page_size);
-	if (wait_for_scan("Do not collapse with max_ptes_none exeeded", p))
+	if (wait_for_scan("Do not collapse with max_ptes_none exceeded", p))
 		fail("Timeout");
 	else if (check_huge(p))
 		fail("Fail");
@@ -576,7 +576,7 @@ static void collapse_swapin_single_pte(void)
 		goto out;
 	}
 
-	if (wait_for_scan("Collapse with swaping in single PTE entry", p))
+	if (wait_for_scan("Collapse with swapping in single PTE entry", p))
 		fail("Timeout");
 	else if (check_huge(p))
 		success("OK");
@@ -607,7 +607,7 @@ static void collapse_max_ptes_swap(void)
 		goto out;
 	}
 
-	if (wait_for_scan("Do not collapse with max_ptes_swap exeeded", p))
+	if (wait_for_scan("Do not collapse with max_ptes_swap exceeded", p))
 		fail("Timeout");
 	else if (check_huge(p))
 		fail("Fail");
@@ -654,14 +654,14 @@ static void collapse_single_pte_entry_compound(void)
 		fail("Fail");
 	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
 
-	printf("Split huge page leaving single PTE mapping compount page...");
+	printf("Split huge page leaving single PTE mapping compound page...");
 	madvise(p + page_size, hpage_pmd_size - page_size, MADV_DONTNEED);
 	if (!check_huge(p))
 		success("OK");
 	else
 		fail("Fail");
 
-	if (wait_for_scan("Collapse PTE table with single PTE mapping compount page", p))
+	if (wait_for_scan("Collapse PTE table with single PTE mapping compound page", p))
 		fail("Timeout");
 	else if (check_huge(p))
 		success("OK");
@@ -685,7 +685,7 @@ static void collapse_full_of_compound(void)
 	else
 		fail("Fail");
 
-	printf("Split huge page leaving single PTE page table full of compount pages...");
+	printf("Split huge page leaving single PTE page table full of compound pages...");
 	madvise(p, page_size, MADV_NOHUGEPAGE);
 	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
 	if (!check_huge(p))
@@ -908,7 +908,7 @@ static void collapse_max_ptes_shared()
 		else
 			fail("Fail");
 
-		if (wait_for_scan("Do not collapse with max_ptes_shared exeeded", p))
+		if (wait_for_scan("Do not collapse with max_ptes_shared exceeded", p))
 			fail("Timeout");
 		else if (!check_huge(p))
 			success("OK");
-- 
2.25.1

