Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43E574E9F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 11:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGKJNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 05:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjGKJNr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 05:13:47 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F81D10A;
        Tue, 11 Jul 2023 02:13:43 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx2epFHa1kJHIDAA--.4690S3;
        Tue, 11 Jul 2023 17:13:41 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvM5EHa1kgHAoAA--.49364S2;
        Tue, 11 Jul 2023 17:13:40 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kselftest@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v6] selftests/clone3: Fix broken test under !CONFIG_TIME_NS
Date:   Tue, 11 Jul 2023 17:13:34 +0800
Message-Id: <1689066814-13295-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxvM5EHa1kgHAoAA--.49364S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw4UZr1xJFy3trW7GF47Jrc_yoW8trW5pF
        yxZw1DKFWFga17tFyDZw1qgFWrGF4kXrW0qF4UZ34UAr1fWryrZr4xKa48JFyUK3yFv39Y
        yFyfGF47uF1UXagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxYiiDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When execute the following command to test clone3 under !CONFIG_TIME_NS:

  # make headers && cd tools/testing/selftests/clone3 && make && ./clone3

we can see the following error info:

  # [7538] Trying clone3() with flags 0x80 (size 0)
  # Invalid argument - Failed to create new process
  # [7538] clone3() with flags says: -22 expected 0
  not ok 18 [7538] Result (-22) is different than expected (0)
  ...
  # Totals: pass:18 fail:1 xfail:0 xpass:0 skip:0 error:0

This is because if CONFIG_TIME_NS is not set, but the flag
CLONE_NEWTIME (0x80) is used to clone a time namespace, it
will return -EINVAL in copy_time_ns().

If kernel does not support CONFIG_TIME_NS, /proc/self/ns/time
will be not exist, and then we should skip clone3() test with
CLONE_NEWTIME.

With this patch under !CONFIG_TIME_NS:

  # make headers && cd tools/testing/selftests/clone3 && make && ./clone3
  ...
  # Time namespaces are not supported
  ok 18 # SKIP Skipping clone3() with CLONE_NEWTIME
  ...
  # Totals: pass:18 fail:0 xfail:0 xpass:0 skip:1 error:0

Fixes: 515bddf0ec41 ("selftests/clone3: test clone3 with CLONE_NEWTIME")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v6: Rebase on 6.5-rc1 and update the commit message

 tools/testing/selftests/clone3/clone3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e60cf4d..1c61e3c 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -196,7 +196,12 @@ int main(int argc, char *argv[])
 			CLONE3_ARGS_NO_TEST);
 
 	/* Do a clone3() in a new time namespace */
-	test_clone3(CLONE_NEWTIME, 0, 0, CLONE3_ARGS_NO_TEST);
+	if (access("/proc/self/ns/time", F_OK) == 0) {
+		test_clone3(CLONE_NEWTIME, 0, 0, CLONE3_ARGS_NO_TEST);
+	} else {
+		ksft_print_msg("Time namespaces are not supported\n");
+		ksft_test_result_skip("Skipping clone3() with CLONE_NEWTIME\n");
+	}
 
 	/* Do a clone3() with exit signal (SIGCHLD) in flags */
 	test_clone3(SIGCHLD, 0, -EINVAL, CLONE3_ARGS_NO_TEST);
-- 
2.1.0

