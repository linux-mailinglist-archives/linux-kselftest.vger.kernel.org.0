Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D68D759666
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjGSNSU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjGSNSR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:18:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC25FD;
        Wed, 19 Jul 2023 06:18:15 -0700 (PDT)
X-QQ-mid: bizesmtp68t1689772685tf75yw6o
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:18:03 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: 3M0okmaRx3grmu9MUHFbrrVNG0WzcH6N1ULMpWmAsKbuISmAuO5FAvE/jYi3P
        g7qSYNWjT9UXfSwx9OmnfYAddtleSX7TeZNg2ORN61CD9vys8r+n1tdunweA/xhXZVtMuvp
        U9DxcXQRsoxsGxKnUWmgXrvFuivUcMIc0pGXuis/bMfH3XPgmAjDUI+ZfdbTdY5SgFDxxjw
        ik3x7NFvu30HEZJepW78xk3Z2zb6o4f63p2olvK0VtT4/fUAHmnuYGq7YFJGiBpIt+my94X
        m36EH+4uzoHfnkOufpeYEKqEyj55Yhi7F6k1SAhZdKwbbbCyWcwqR7dm9PrbgolksZDjNca
        M0zp1eRc0qukXPHuAQCNJq2rz5CtJe0AgXa7GMrgb+wEPLZhQ0LXI0wBKnaiQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5670957446620679484
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 01/14] selftests/nolibc: allow report with existing test log
Date:   Wed, 19 Jul 2023 21:17:59 +0800
Message-Id: <f17b3621241f7321ecc1accbad86bc29ecc3912d.1689759351.git.falcon@tinylab.org>
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

After the tests finish, it is valuable to report and summarize with
existing test log.

This avoid rerun or run the tests again when not necessary.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index ab17e0d8b7e2..0cd17de2062c 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -206,6 +206,10 @@ rerun:
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
+# report with existing test log
+report:
+	$(Q)$(REPORT_RUN_OUT)
+
 clean:
 	$(call QUIET_CLEAN, sysroot)
 	$(Q)rm -rf sysroot
-- 
2.25.1

