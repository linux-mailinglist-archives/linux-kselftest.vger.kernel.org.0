Return-Path: <linux-kselftest+bounces-1373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EDD808FF1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 19:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24D5B20C5D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC0746BA4;
	Thu,  7 Dec 2023 18:33:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479B1709
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 10:33:19 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f5c7:c244:a7e3:47bf])
	by xavier.telenet-ops.be with bizsmtp
	id KWZG2B00S2nBfCd01WZGRb; Thu, 07 Dec 2023 19:33:17 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rBJB7-00BL2d-Md;
	Thu, 07 Dec 2023 19:33:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rBJBU-003ZDD-Az;
	Thu, 07 Dec 2023 19:33:16 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] selftests: timers: clocksource-switch: Adapt progress to kselftest framework
Date: Thu,  7 Dec 2023 19:33:10 +0100
Message-Id: <6d7a665392e75c0af8fd4ad5b95bd3f0489236ee.1701973869.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adapting the test to the kselftest framework, a few printf() calls
indicating test progress were not updated.

Fix this by replacing these printf() calls by ksft_print_msg() calls.

Fixes: ce7d101750ff8450 ("selftests: timers: clocksource-switch: adapt to kselftest framework")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
When just running the test, the output looks like:

    # Validating clocksource arch_sys_counter
    TAP version 13
    1..12
    ok 1 CLOCK_REALTIME
    ...
    # Validating clocksource ffca0000.timer
    TAP version 13
    1..12
    ok 1 CLOCK_REALTIME
    ...

When redirecting the test output to a file, the progress prints are not
interspersed with the test output, but collated at the end:

    TAP version 13
    1..12
    ok 1 CLOCK_REALTIME
    ...
    TAP version 13
    1..12
    ok 1 CLOCK_REALTIME
    ...
    # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:6 error:0
    # Validating clocksource arch_sys_counter
    # Validating clocksource ffca0000.timer
    ...

This makes it hard to match the test results with the timer under test.
Is there a way to fix this?  The test does use fork().

Thanks!
---
 tools/testing/selftests/timers/clocksource-switch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index c5264594064c8516..83faa4e354e389c2 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -156,8 +156,8 @@ int main(int argc, char **argv)
 	/* Check everything is sane before we start switching asynchronously */
 	if (do_sanity_check) {
 		for (i = 0; i < count; i++) {
-			printf("Validating clocksource %s\n",
-				clocksource_list[i]);
+			ksft_print_msg("Validating clocksource %s\n",
+					clocksource_list[i]);
 			if (change_clocksource(clocksource_list[i])) {
 				status = -1;
 				goto out;
@@ -169,7 +169,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	printf("Running Asynchronous Switching Tests...\n");
+	ksft_print_msg("Running Asynchronous Switching Tests...\n");
 	pid = fork();
 	if (!pid)
 		return run_tests(runtime);
-- 
2.34.1


