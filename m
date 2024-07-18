Return-Path: <linux-kselftest+bounces-13858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2993469F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 05:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036C01F22AF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 03:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFEA20DE8;
	Thu, 18 Jul 2024 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nE/UNPqc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0518EBF;
	Thu, 18 Jul 2024 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721272265; cv=none; b=ASOwA3DKpaBPAU+YvdwFMwAXdmtvs02i+MiI4zrMPd/6A/fd+tamWX53U88L8dzSUGG52Sd5mccuaCcHgv0lA7abPneFZt3K/kmiN0etkjuPK08NS9O1otcylRv/hxCbmZsNr6b29wIZn2PLw9/4flQgbU5rz/kYAdhAZ1G/cmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721272265; c=relaxed/simple;
	bh=pD2xubbTa4c6T4WNzg1CAB+MEyajjEmWSQtRqNVNtnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WgaoRdFAbacWjT3oUrUh1GzCNp8KBn/GJUYiamN+PuGHlchP+W7PWAWzYgAxcz+D5qPu7fxRMp3G+Jw7/Ufb6AyY9MTpv08EkGBD+XAH4f4WGzGCrgsry6YZvV7cZ3mwSmdyaal0Ohq5BU7JnFILhtsMxirN/4iaHyz2Dhi3K58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nE/UNPqc; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721272252; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tgQJsXXJZtuIafpHz+x3BoFD/+zTuz5fz+02sw/hJ+s=;
	b=nE/UNPqcycmdXT0rTg5+4+pY9uCjw7ilYuhx3shAHDYBWjbnDBr3Z9bW9UdG43r6yATJ/bBzhcPITyPT9HlFQ+5IHuGHPOaHs2AAiFtYJgQ/PCIoRcc4CdmHcQSE59LKYBHF8X0sJwqUi4N7npmuE0m18tghrb5LaerzZesvfRo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0WAmhdTk_1721272240;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WAmhdTk_1721272240)
          by smtp.aliyun-inc.com;
          Thu, 18 Jul 2024 11:10:52 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] selftests/mm: mseal, self_elf: Fix warning comparing pointer to 0
Date: Thu, 18 Jul 2024 11:10:39 +0800
Message-Id: <20240718031039.69861-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid pointer type value compared with 0 to make code clear.

./tools/testing/selftests/mm/mseal_test.c:486:27-28: WARNING comparing pointer to 0.
./tools/testing/selftests/mm/mseal_test.c:1399:29-30: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9552
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/mm/mseal_test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index a818f010de47..50a5b9b9399e 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -481,9 +481,8 @@ static void test_seal_zero_address(void)
 	int prot;
 
 	/* use mmap to change protection. */
-	ptr = sys_mmap(0, size, PROT_NONE,
-			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
-	FAIL_TEST_IF_FALSE(ptr == 0);
+	ptr = sys_mmap(0, size, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	FAIL_TEST_IF_FALSE(!ptr);
 
 	size = get_vma_size(ptr, &prot);
 	FAIL_TEST_IF_FALSE(size == 4 * page_size);
@@ -1390,13 +1389,12 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
 	/*
 	 * MREMAP_FIXED can move the mapping to zero address
 	 */
-	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
-			0);
+	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED, 0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
-		FAIL_TEST_IF_FALSE(ret2 == 0);
+		FAIL_TEST_IF_FALSE(!ret2);
 
 	}
 
-- 
2.32.0.3.g01195cf9f


