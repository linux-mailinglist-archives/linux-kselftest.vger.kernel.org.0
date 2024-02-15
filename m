Return-Path: <linux-kselftest+bounces-4754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA0A856468
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 14:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66220B2B46D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88FA130E52;
	Thu, 15 Feb 2024 13:28:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7D130E2E
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Feb 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003708; cv=none; b=eSyiKr0xdrXIANxS3PAiiyPBZ6vXfLdt/GvfiBvge0M1nkdJVG8ECAm94gaQJwCd6DB3lXnBeIgep67zJE1AC6/k4olBH7e4JmGtJxo20QIyKlnoArsjLSEl7edNrSLmlim3tzQMMSglR6G4kfSADdgfEEH0Fl6uL5EHeAnge+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003708; c=relaxed/simple;
	bh=yErmxTR4sdF8IYbb0NbWHYGlmsiQdjhvfNimdEVhaeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c3j6V6No9lhHqZFC/Gr+jm5XeS2YsNd76Pzso4vOlXNRrjvyp6C2Tl21Cp5Etbo9xr92BINgWtDgCH3g9vUCEufVrPNxeELtn8EotiZx0LLSR4OC+epF4NDYdzv1JM99BdT3Rd6017Ftd5SnUEjNcqOgJCiWZer2hJVYRtZoaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by baptiste.telenet-ops.be with bizsmtp
	id nRUJ2B0060LVNSS01RUJxk; Thu, 15 Feb 2024 14:28:18 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabmd-000gzE-2Y;
	Thu, 15 Feb 2024 14:28:18 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabmk-00HZka-E7;
	Thu, 15 Feb 2024 14:28:18 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] selftests: timers: clocksource-switch: Adapt progress to kselftest framework
Date: Thu, 15 Feb 2024 14:28:17 +0100
Message-Id: <7960007c8517109b592995ad10a3058fbe5aae75.1708003520.git.geert+renesas@glider.be>
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


