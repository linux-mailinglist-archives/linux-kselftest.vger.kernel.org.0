Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8B2F0F39
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jan 2021 10:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbhAKJgc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jan 2021 04:36:32 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:40743 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728218AbhAKJgc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jan 2021 04:36:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0ULL1Qc0_1610357738;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULL1Qc0_1610357738)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Jan 2021 17:35:43 +0800
From:   YANG LI <abaci-bugfix@linux.alibaba.com>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, shuah@kernel.org, amit.kachhap@arm.com,
        vincenzo.frascino@arm.com, gabor.kertesz@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        YANG LI <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] arm64: mte: style: Simplify bool comparison
Date:   Mon, 11 Jan 2021 17:35:37 +0800
Message-Id: <1610357737-68678-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck warning:
./tools/testing/selftests/arm64/mte/check_buffer_fill.c:84:12-35:
WARNING: Comparison to bool

Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci Robot<abaci@linux.alibaba.com>
---
 tools/testing/selftests/arm64/mte/check_buffer_fill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/mte/check_buffer_fill.c b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
index c9fa141..75fc482 100644
--- a/tools/testing/selftests/arm64/mte/check_buffer_fill.c
+++ b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
@@ -81,7 +81,7 @@ static int check_buffer_underflow_by_byte(int mem_type, int mode,
 		last_index = 0;
 		/* Set some value in tagged memory and make the buffer underflow */
 		for (j = sizes[i] - 1; (j >= -underflow_range) &&
-				       (cur_mte_cxt.fault_valid == false); j--) {
+				       (!cur_mte_cxt.fault_valid); j--) {
 			ptr[j] = '1';
 			last_index = j;
 		}
-- 
1.8.3.1

