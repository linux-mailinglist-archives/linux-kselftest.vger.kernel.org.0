Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651175B1C81
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 14:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiIHMLu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 08:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiIHML3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 08:11:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0177411C178;
        Thu,  8 Sep 2022 05:11:22 -0700 (PDT)
X-QQ-mid: bizesmtp78t1662639077tmqaueo2
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:11:15 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: QityeSR92A2vF5ibAnglKqP4azF3Uav5POCQlNgEV6EmQshA0MG9mqKRg0B64
        xEWZcNhK1Bku8cnulowRR8vlzEAOPFToKODY+eqhbQRMIWsdFWJ4gryYeIxlwd54Xb3vYdf
        +Jg03YwzICYtXN+E7M82uwBk1puy+1e400bBDrMOOxZ7dUQnUxRSLu4gvjCW4NMj0TX3kGt
        HZNyFRvVcqOAFyCZcr10oULhv8+tXkgJPYB3ks2M6JuIZCjICGY+en6JyCRf0j+/Z3QqfFv
        jAxze6gy5uJhyDSBv56sEYGdzCw7wPOnabLmICKlbzkoMT12dvcdLOTf+sAfowtrR4hayvM
        ky/1f72YBLdh6IH0nPxsykHTosFTl3PGltq7j0s
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        shuah@kernel.org
Cc:     cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] selftests/cgroup: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:11:07 +0800
Message-Id: <20220908121107.4814-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 tools/testing/selftests/cgroup/test_freezer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index ff519029f6f4..b479434e87b7 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -740,7 +740,7 @@ static int test_cgfreezer_ptraced(const char *root)
 
 	/*
 	 * cg_check_frozen(cgroup, true) will fail here,
-	 * because the task in in the TRACEd state.
+	 * because the task in the TRACEd state.
 	 */
 	if (cg_freeze_wait(cgroup, false))
 		goto cleanup;
-- 
2.36.1

