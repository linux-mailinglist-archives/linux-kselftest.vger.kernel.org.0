Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69214738455
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjFUNDj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFUNDi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:03:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91DA10D5;
        Wed, 21 Jun 2023 06:03:36 -0700 (PDT)
X-QQ-mid: bizesmtp74t1687352607trbau5dm
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 21:03:25 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: ILHsT53NKPg/RSsp3DyOM0IrCTgvq+RSzeZGducQwjaxszgrcCMeeownE2tA4
        +BVPLe7BzjU1z2iPHSeffjNHNylrfJxkTw57m2aYbxzx84fb52mICxq+p5vA7mqvHdVIvd1
        USShcG2eswk8lOF/rzGVwlpHfpNt6LRyZKTHR8gEScymWSUOyv13eQiJfo7OcrTZyW3ZcXU
        dui8Sx9skGbMDWJX0xcHJDh+ull9vHRiROd+TOzWiKUYW3q8NzCavlpXzI1ewaHEygQ3+2u
        qOMjo+00peNcp0KDzjX2gbumc9P8O7C2GiBRLUxb5va5v9Im3Qwm6acbFFlXXw/mt6Tbv/p
        dyKpgBuGUatolsmvvt8loXCHCLD8b2iTJVO37PXUaiP9orbKeuX2KHUVNRf+A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11819404568078845102
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 08/17] selftests/nolibc: fix up failures when there is no procfs
Date:   Wed, 21 Jun 2023 21:03:07 +0800
Message-Id: <6ba1291bf6a687dbd0d7dd20c65583a535157b17.1687344643.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687344643.git.falcon@tinylab.org>
References: <cover.1687344643.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When there is no procfs support, the /proc is not mountable, but the
/proc directory has been created in the prepare() stage and therefore,
the checking of /proc in the run_syscall() stage will be always true and
at last will fail all of the procfs dependent test cases.

To solve this issue, one method is checking /proc/self instead of /proc,
another one is removing the /proc directory completely (when there is
really no procfs support), we apply the second method to avoid mislead
the users.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 9673c338d42e..e5a218ef8a2d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -928,8 +928,11 @@ int prepare(void)
 
 	/* try to mount /proc if not mounted. Silently fail otherwise */
 	if (stat("/proc/.", &stat_buf) == 0 || mkdir("/proc", 0755) == 0) {
-		if (stat("/proc/self", &stat_buf) != 0)
-			mount("/proc", "/proc", "proc", 0, 0);
+		if (stat("/proc/self", &stat_buf) != 0) {
+			/* If not mountable, remove /proc completely to avoid misuse */
+			if (mount("none", "/proc", "proc", 0, 0) != 0)
+				rmdir("/proc");
+		}
 	}
 
 	return 0;
-- 
2.25.1

