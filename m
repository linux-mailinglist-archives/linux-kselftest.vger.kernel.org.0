Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96915720EA4
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 10:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjFCIIp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 04:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjFCIIo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 04:08:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5886B1B3;
        Sat,  3 Jun 2023 01:08:43 -0700 (PDT)
X-QQ-mid: bizesmtp71t1685779713tgcqkwdm
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 16:08:32 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: XBN7tc9DADLabrxk/+QDcnBfINyYg7hhkwxt2+gkdZwvWG8oXdYSvY4ACTUEK
        n+bM6hXEGtjzMWAut9D+MR9IRJiuWBUhAMptGJTyaSGuTS+zNj2PwvFLnK6O+fEod5ePmJ4
        kzos7o/x54UwO+YylckkWOsgZYjfYkkzOkFnysR7xn77a0Nt3bl902/Q6v1226RSUYNfNWu
        rdohXqJ8xtcviTGsD4rZTt4RWdY9+j4APz5jkhrHYiZLLABKtnmK4VRSbYhhKXK0L2JlE+j
        +VGh5GKFc9D/O8lIopK9trH7Kn8+8UfZ2gzyuXCGyx3D6XP+U+U26Td3XAPDP0BjtgJJCkR
        57O8mIZIN1jazn9PjSTbpuzjwHybPXzcb9PFM1ZIXMN3MtM3KCTcxmd9fs22pH2m7/At6HL
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18070674266371447120
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v3 06/12] selftests/nolibc: use INT_MAX instead of __INT_MAX__
Date:   Sat,  3 Jun 2023 16:08:12 +0800
Message-Id: <9e48ea5aab5a988fcba923632e6681c111dd5525.1685777982.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685777982.git.falcon@tinylab.org>
References: <cover.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

nolibc now has INT_MAX in stdint.h, so, don't mix INT_MAX and
__INT_MAX__, unify them to INT_MAX.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 2a2954cb7bef..a8fcad801cf2 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -931,7 +931,7 @@ static const struct test test_names[] = {
 int main(int argc, char **argv, char **envp)
 {
 	int min = 0;
-	int max = __INT_MAX__;
+	int max = INT_MAX;
 	int ret = 0;
 	int err;
 	int idx;
@@ -979,7 +979,7 @@ int main(int argc, char **argv, char **envp)
 				 * here, which defaults to the full range.
 				 */
 				do {
-					min = 0; max = __INT_MAX__;
+					min = 0; max = INT_MAX;
 					value = colon;
 					if (value && *value) {
 						colon = strchr(value, ':');
-- 
2.25.1

