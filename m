Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6DE74B62F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGGSWy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGGSWy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:22:54 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8391FEF;
        Fri,  7 Jul 2023 11:22:52 -0700 (PDT)
X-QQ-mid: bizesmtp72t1688754163tbz6971n
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:22:42 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: QNtCjCnA38/H8JL0FER4UCqbooVsJKjujOZR7fq9q4G4ESPFiFBGxztBtSgfP
        PZsdw5sU119JWuA2HNJG/m4x0mXNF/z/OS8dmW0Cg2+xJ8gVBgpMI6Zav7XN7up1qM2y2oA
        oZ1+HgVmMp3HRpuxUYTC0LVUkxCvY0bhOeeCZakge+0az92sUVw28BTtt0ncnttqGRFn849
        pC/01mK0+HW4HqJTG2aWVWd9zs1QB4H6sZThngmPEvtEbJcYPUJcAuRMnOKiTqaLIqIXGau
        z41S45Tp5E3YncOK+NJzAH3C+8Tiv8RkSZad1GD68651407qqv47L/zz7YClpFUYGD5T3UI
        3gebTUjnabwoCh364SLMcwiPnmmT9acCpgX6HtDkkTyitn5TR4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3309041285388814565
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 01/18] selftests/nolibc: add run-libc-test target
Date:   Sat,  8 Jul 2023 02:22:39 +0800
Message-Id: <d4f1a611ee7f37c31cfdd6a26511f50b71f962ff.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
References: <cover.1688750763.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

allow run and report glibc or musl based libc-test.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 000621f21adc..d408b688b291 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -132,6 +132,10 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 libc-test: nolibc-test.c
 	$(QUIET_CC)$(CC) -o $@ $<
 
+run-libc-test: libc-test
+	$(Q)./libc-test > "$(CURDIR)/run.out" || :
+	$(Q)$(REPORT) $(CURDIR)/run.out
+
 # qemu user-land test
 run-user: nolibc-test
 	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
-- 
2.25.1

