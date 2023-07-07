Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5921274B64F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjGGSbO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGGSbN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:31:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54F61FEF;
        Fri,  7 Jul 2023 11:31:11 -0700 (PDT)
X-QQ-mid: bizesmtp70t1688754662te5egk8k
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:31:01 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: PKnEab4175t4fCCOaBAG1HRV81wFqu79uG2ElbrfdLJwsbLmf/CHfWIq9WAI9
        mMFnF0T8uJJKqWbNdtqiG25QO4SZTc/5v+vF0QjEbwoV6LvXa+rvxJh3jEdUlFWVb6LR4qT
        ggOTspUaWlNe0z1hX91OLQPCKvzL9hlo7r/mLz8b4kn5RD2Ba+xtkmtkwHXvOGNVRH0Ryh/
        RL0wtktRXRgVSMi0RCpmdFuu+PKJ3ojDGKMN6iFeFcEWjz9JTziXwBImIl+XxB0eEVMK8om
        hAV/dbwMFZjxwn+E1mOxPIH3n+1uxl5juYkt7Ck667Ld7eCN2B7c16RCpWfm+RdsvtA4kCK
        jA/t04jmFwNVxd8rX5tkljtH2Nounrgw7iUqiTzDPbo0Pe9HIc9xFbPP9h4AQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11273642194411821185
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 07/18] selftests/nolibc: prefer <sys/reboot.h> to <linux/reboot.h>
Date:   Sat,  8 Jul 2023 02:30:58 +0800
Message-Id: <08f966f8e00b3537701bb10ef651f2ccf3e2d8b4.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
References: <cover.1688750763.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since both glibc and musl provide RB_ flags via <sys/reboot.h>, and we
just add RB_ flags for nolibc, let's use RB_ flags instead of
LINUX_REBOOT_ flags and only reserve the required <sys/reboot.h> header.

This allows compile libc-test for musl libc without the linux headers.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index fea1b06131f6..12ecae85403e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -15,7 +15,6 @@
 #include <string.h>
 #ifndef _NOLIBC_STDIO_H
 /* standard libcs need more includes */
-#include <linux/reboot.h>
 #include <sys/io.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
@@ -1180,7 +1179,7 @@ int main(int argc, char **argv, char **envp)
 		 */
 		printf("Leaving init with final status: %d\n", !!ret);
 		if (ret == 0)
-			reboot(LINUX_REBOOT_CMD_POWER_OFF);
+			reboot(RB_POWER_OFF);
 #if defined(__x86_64__)
 		/* QEMU started with "-device isa-debug-exit -no-reboot" will
 		 * exit with status code 2N+1 when N is written to 0x501. We
-- 
2.25.1

