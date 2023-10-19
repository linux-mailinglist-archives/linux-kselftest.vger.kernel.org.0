Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA5F7D0544
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 01:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbjJSXJP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 19:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346702AbjJSXJO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 19:09:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6D6106;
        Thu, 19 Oct 2023 16:09:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179AFC433C8;
        Thu, 19 Oct 2023 23:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697756949;
        bh=8yGOMG36olUp/akMh6rkuC0OaLA9uG3cci6pDHR/HKQ=;
        h=From:Date:Subject:To:Cc:From;
        b=iaONNIo4GXEAc6LG9sii40eI0VJA2RVDByIZU2NBnbRR8wwh6qRYCrHRLUZRXioIA
         Xa0P6ZNX4g07KD2y4SmAVbVPVLlbOVcNFnSy34jQFLa88Yqv3NjHmGumKlq0Erxe0E
         3/c9dV7mYCly5QMt9ZfDzHDdLpY1jPCrBeEocsib7exqqDjEyq+7hvljuaQTVZN09I
         0V4NvQjygZ3z87xeUo31vtHRtu1PW0BR65RvQWTS9fdPNpvC955rJHHyHByWFAPZy7
         ASU67y0TyXT6e9obouXjYDsVRAqcc99aGEOQ24VDlRFJ4Ggnk29bfYC0/woqVgp8qT
         3mhd0mjN+/8Ng==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 20 Oct 2023 00:08:12 +0100
Subject: [PATCH] selftests/clone3: Skip new time namespace test when
 unsupported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-kselftest-clone3-time-ns-v1-1-31a17e072a05@kernel.org>
X-B4-Tracking: v=1; b=H4sIANy2MWUC/x3MQQqDMBBG4avIrDuQGGlsr1JctPFPO2hjyQQpi
 Hc3uPwW722kyAKle7NRxioqS6qwl4bC55neYBmrqTWts8beeFLMsUALh3lJcFzkC07K3pnXNXa
 298FTzX8ZUf7n+jHs+wF42ZOHagAAAA==
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Tobias Klauser <tklauser@distanz.ch>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2679; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8yGOMG36olUp/akMh6rkuC0OaLA9uG3cci6pDHR/HKQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlMbcRep0GTdt5oyAi825blRZSaZH7USK88m/1E3BS
 UKczc0iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTG3EQAKCRAk1otyXVSH0KW5B/
 4u8e3wydjWCGQEJ3+M0KT+Tky+F6+CuKDBXeJActy6lTbpjsKP5MvRhI503Z8alJVCI81xegAC7cHM
 MaE+/vltgmRHlkdGi2s5BQbMYNK1kIbopX6ize2XAsNiZC8sIW3ReK35Q31Lceoak625eN4vldBm9S
 cYLl9UEeddxNPUK1f2xexmxZxtF2XEsOILhROPVrBp38eWJWniFqORJN11gRqLQN+1KZ9gjSkm5j33
 YnPGKeDF8Odw7ARshA4dcIJujm1VTECf7dFf4fZucQC91yLKDWbvJvbzoMP3qc7EPl0Wq5l/XNAm+l
 AdrJhF54FmtsHvR31M0FNCdYBfBewg
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use a filter function to skip the time namespace test on systems with
!CONFIG_TIME_NS. This reworks a fix originally done by Tiezhu Yang prior
to the refactoring in 34dce23f7e40 ("selftests/clone3: Report descriptive
test names"). The changelog from their fix explains the issue very clearly:

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
Original-fix-from: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 9429d361059e..915846bc32cc 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -138,6 +138,16 @@ static bool not_root(void)
 	return false;
 }
 
+static bool timens_unsupported(void)
+{
+	if (access("/proc/self/ns/time", F_OK) == 0) {
+		ksft_print_msg("Time namespaces are not supported\n");
+		return true;
+	}
+
+	return false;
+}
+
 static size_t page_size_plus_8(void)
 {
 	return getpagesize() + 8;
@@ -282,6 +292,7 @@ static const struct test tests[] = {
 		.size = 0,
 		.expected = 0,
 		.test_mode = CLONE3_ARGS_NO_TEST,
+		.filter = timens_unsupported,
 	},
 	{
 		.name = "exit signal (SIGCHLD) in flags",

---
base-commit: 8d4099dd0727acfc8b0f644eacaf852f9d5dc649
change-id: 20231019-kselftest-clone3-time-ns-730b6f4187c7

Best regards,
-- 
Mark Brown <broonie@kernel.org>

