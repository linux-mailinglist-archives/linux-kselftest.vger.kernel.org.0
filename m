Return-Path: <linux-kselftest+bounces-22234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E340B9D2046
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 07:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BB0281AF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 06:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC263155756;
	Tue, 19 Nov 2024 06:35:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702E1465A1;
	Tue, 19 Nov 2024 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731998146; cv=none; b=Z7KfTzpc3suho25243kjEAN+LQECT5Nqx6tjfPOLCW3vee2Px9WYvRKZL5v5UHeZ+6oCn9Au/rZg71ynxYYDMlGfadJeuIHshkiZgfraS7HsOYPyjgEafBQABV+86r2HU+iRYt2viD5NI2yU+qIy8/yeWKpb8X+x572Ak/hw/h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731998146; c=relaxed/simple;
	bh=uJUdakRXNd76Rk31Mr00dtt0z76XAJn5mC7iL6LiIC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g4hNB+I0nUN6LY7pp88bPNkrtuC5m9krW1YM7tpIEq9lMPaAXzOJXJ0SST7XF0O5240uUnDo2vtJaKmK6e4gYNuAtfyPRlGm0QFFq1J6ashLZcxzeK2RjZEomeYOf53IaVmuVmUA+/1ElpV5qnfSiaBSEimdKRUkG9SaB4PbJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7673c31b56f4-48711;
	Tue, 19 Nov 2024 14:35:33 +0800 (CST)
X-RM-TRANSID:2ee7673c31b56f4-48711
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9673c31a7f21-10a1a;
	Tue, 19 Nov 2024 14:35:33 +0800 (CST)
X-RM-TRANSID:2ee9673c31a7f21-10a1a
From: guanjing <guanjing@cmss.chinamobile.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	usama.anjum@collabora.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v1] selftests: mm: Fix conversion specifiers in transact_test()
Date: Sun, 17 Nov 2024 15:12:31 +0800
Message-Id: <20241117071231.177864-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lots of incorrect conversion specifiers. Fix them.

Fixes: 46fd75d4a3c9 ("selftests: mm: add pagemap ioctl tests")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index bcc73b4e805c..fdafce0654e9 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1405,9 +1405,9 @@ static void transact_test(int page_size)
 	memset(mem, 0, 0x1000 * nthreads * pages_per_thread);
 
 	count = get_dirty_pages_reset(mem, nthreads * pages_per_thread, 1, page_size);
-	ksft_test_result(count > 0, "%s count %d\n", __func__, count);
+	ksft_test_result(count > 0, "%s count %u\n", __func__, count);
 	count = get_dirty_pages_reset(mem, nthreads * pages_per_thread, 1, page_size);
-	ksft_test_result(count == 0, "%s count %d\n", __func__, count);
+	ksft_test_result(count == 0, "%s count %u\n", __func__, count);
 
 	finish = 0;
 	for (i = 0; i < nthreads; ++i)
@@ -1429,7 +1429,7 @@ static void transact_test(int page_size)
 			ksft_exit_fail_msg("pthread_barrier_wait\n");
 
 		if (count > nthreads * access_per_thread)
-			ksft_exit_fail_msg("Too big count %d expected %d, iter %d\n",
+			ksft_exit_fail_msg("Too big count %u expected %u, iter %u\n",
 					   count, nthreads * access_per_thread, i);
 
 		c = get_dirty_pages_reset(mem, nthreads * pages_per_thread, 1, page_size);
@@ -1454,7 +1454,7 @@ static void transact_test(int page_size)
 			 * access and application gets page fault again for the same write.
 			 */
 			if (count < nthreads * access_per_thread) {
-				ksft_test_result_fail("Lost update, iter %d, %d vs %d.\n", i, count,
+				ksft_test_result_fail("Lost update, iter %u, %u vs %u.\n", i, count,
 						      nthreads * access_per_thread);
 				return;
 			}
@@ -1467,7 +1467,7 @@ static void transact_test(int page_size)
 	finish = 1;
 	pthread_barrier_wait(&end_barrier);
 
-	ksft_test_result_pass("%s Extra pages %u (%.1lf%%), extra thread faults %d.\n", __func__,
+	ksft_test_result_pass("%s Extra pages %u (%.1lf%%), extra thread faults %u.\n", __func__,
 			      extra_pages,
 			      100.0 * extra_pages / (iter_count * nthreads * access_per_thread),
 			      extra_thread_faults);
-- 
2.33.0




