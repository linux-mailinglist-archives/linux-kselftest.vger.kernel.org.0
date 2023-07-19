Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779CB75967B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjGSNUb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSNUb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:20:31 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA8A113;
        Wed, 19 Jul 2023 06:20:29 -0700 (PDT)
X-QQ-mid: bizesmtp85t1689772819twb1jfej
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:20:17 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: D2GZf6M6C/hj3mYQLM88nlD2/Bu6nnA6SGYdUSehcdKNVIGkXjN0KKlH1XkyC
        rw0zS+R2oehzieMoKnE3XC/UQkcpuzTLEUl+IxDag2sW11hJq2NSTs7tUnFs+JzstgFTm5z
        unpbSl/Fy6JIRLdNKwSRjWWZcPoHTLevni6NilJdqG0HPbQYUziCJIwMOZTF/BalkMtXf1Z
        rg2TWC0UCXFlS4Mm/5bPdxy2C9eqJxIKdO4G9XibDMP1pDpjj4nHRMxaErBf7q3RL9LArh8
        v6Pm5gNrD4QtMj53G8dK9AE0fovcIj8My5M5mpCmpmtQey5kV0H9GckANp7Kxuf+NHHYnLm
        GK2vkuxrrObADSOGo6OgsZqq/KTPwc4rCfUiky0LLCakI/9hbyVhwEscb0Jgg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14450965798290048757
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 03/14] selftests/nolibc: print running log to screen
Date:   Wed, 19 Jul 2023 21:20:17 +0800
Message-Id: <1373113bdaf2d4812c3d712684bd0019f992a032.1689759351.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689759351.git.falcon@tinylab.org>
References: <cover.1689759351.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When poweroff fails, qemu-system will hang there without any output.

It is very hard to debug in such case, let's print the running log to
the screen to allow users to learn what is happening at the first
glance, without editing the Makefile manually every time.

To get a clean output, the 'grep status' command can be used.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 8c531518bb9f..f1c8e4a0f1b2 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -168,7 +168,7 @@ libc-test: nolibc-test.c
 
 # common macros for logging
 RUN_OUT = $(CURDIR)/run.out
-LOG_OUT = > "$(RUN_OUT)"
+LOG_OUT = | tee "$(RUN_OUT)"
 REPORT_RUN_OUT = $(REPORT) "$(RUN_OUT)"
 
 # local libc-test
-- 
2.25.1

