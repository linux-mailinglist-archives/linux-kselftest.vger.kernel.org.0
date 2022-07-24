Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B20F57F393
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Jul 2022 09:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiGXHEz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Jul 2022 03:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiGXHEy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Jul 2022 03:04:54 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADDC167D0;
        Sun, 24 Jul 2022 00:04:47 -0700 (PDT)
X-QQ-mid: bizesmtp81t1658646283tv99idw0
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:04:41 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: QityeSR92A2um1S4Mab87VbEW/8LxWZAgASXUNLJmIJiMQSes6kY7uX9m3700
        OQItUh3WFmF79lezzi81zuBdO2c1xnZEY2RjgHDo+xLHjHBpIVfA0uo/8aFFkCPnWdu6aiG
        P60gSFh3ZIu+Qjxn6J1AcelFdM0OrTc8fdAWuHQCzTagT+rE4ZoD/3c0kYdZzFb19dfg94D
        nSdda7pz83fEzMoJ8y2CTdkouk9zxsZXvdzkWpqkcldtQBZv7KH6REQzoHUF8oCWja/LFbp
        nT9ptUMRQMZvBWmW57cBmqGtIU07l2kPPDXj4ThVjYonQIsI3D0yr1h1m6ds5XUFV9RvG+Y
        0y9HAgAHFcqDQFQ2bZrSpn+YpCFlTA9C/A3AgTT0Zrt9o+Z0gA=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        shuah@kernel.org
Cc:     cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] selftests/cgroup: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:04:35 +0800
Message-Id: <20220724070435.7999-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
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

