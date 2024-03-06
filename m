Return-Path: <linux-kselftest+bounces-6010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957E0874053
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 20:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DE82815E9
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 19:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8105C142624;
	Wed,  6 Mar 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxtxDO+5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448E1420CC;
	Wed,  6 Mar 2024 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752903; cv=none; b=ZMj56J0xa9/tSsIBA+9tYVQE9DQjOeR/jJkamSluBvWq+Q/Y7a1Bu6+SlKp4reEgFs7cL87d5bz9SyeQ+zE/vjqmcaqwBzd6LGVTXzgaQwUMoMRHW/BSi6yQa1bMzfbaGPWbYT0B7BQWgpyGsgBC9Bq0XYTrtg67Y6HXeUx9Qyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752903; c=relaxed/simple;
	bh=A1+zHTfoU9rRBcXeGw4a+56qXArSOHtcWNhad8MSClk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7jlQzaR4vA0tTGtiET2sh2IMpTRIFJcbiG4OOuF31y5z8j1wG14L22o88VzAsVD8f7c/QR7chjy3fovdMhzV06NywTyDJbd0nIt99iwDSiWFj8DOuLZoHb2gNA1QpPMxUXMDESIxxPwzYvJN7tC7yG6s1jsE+aHD6+AW0s2ukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxtxDO+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC76C433B1;
	Wed,  6 Mar 2024 19:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709752902;
	bh=A1+zHTfoU9rRBcXeGw4a+56qXArSOHtcWNhad8MSClk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qxtxDO+5x1xaoF6gStACvvbzzPbtDNuHvZI736JYeE6FoI+gJ7TdgrsgtIN1vTs7k
	 /G1MD/5Ovfio7nu6sh3G7jrgLUCSg4+Z5OE3qwyM2H4n1vkineHoQuufClMFOQT+VS
	 KN9fnNbsbvAhmN206mr6qcmnwm4W9gaLQXbcwO8pKLkiuqiXFsQHhJOK34V7qyep8G
	 o+txlVfI7/lHY9re3ipTVVVUl9nZ4rLYsCt9uGWuk/B0vu+k/vb/qURStqawxr0XwD
	 FJlFJDPTFXrEZTz2wXy5bpea2ZvlK3g/jialcGc/4SF/nGPd8ZisroNS7bjnZ/zewu
	 LqGRjgfDCw3Lg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Mar 2024 19:21:26 +0000
Subject: [PATCH 2/2] kselftest/tty: Report a consistent test name for the
 one test we run
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-kselftest-tty-tname-v1-2-33505b31629e@kernel.org>
References: <20240306-kselftest-tty-tname-v1-0-33505b31629e@kernel.org>
In-Reply-To: <20240306-kselftest-tty-tname-v1-0-33505b31629e@kernel.org>
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Michal Sekletar <msekleta@redhat.com>, linux-serial@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3118; i=broonie@kernel.org;
 h=from:subject:message-id; bh=A1+zHTfoU9rRBcXeGw4a+56qXArSOHtcWNhad8MSClk=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtQXh2w23VKO6uMW/nY1qS590U+b+S9qbiu2reOMinVbvuoA
 49GLnYzGLAyMXAyyYoosa59lrEoPl9g6/9H8VzCDWJlApjBwcQrARJTN2f/peat13t7icrVtfmM5S9
 S7zVenpfkkiebdy5VVY9qW2/Jtn+97zi6LttS6d9ctamXELuT+6Zsc4MSzpDAvu/Nsw3P7gLtZ8gk7
 Xpy9tdDXI0a0bq1c8ZK5ilFHL+uXhEq/CeGOuZoq7724Zu33FObANxqTHiuuvbV7d9/F3oUCXQaJa5
 u5a7OVdgs7zGr3Vy4JiBXoTt31ukTE+6z8ufZXZS4PrffX3Am/Zsn6LnqOcOGRxvqleewOP88nsf5M
 KHSf+lD/206RJBG5M9Gl29Xlm28+9Fqez7le+OcDCVFTU7m10ssFy9sDZz0tfb1F9GSOO8/dqubWLg
 Hr/U97tDV9JRp3bp5itLtD8FgUAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently the tty_tstamp_update test reports a different exit message
for every path it can exit via. This can be confusing for automated systems
as the string that gets logged is interpreted as a test name so if the test
status changes they can't tell that it's the same test case that was run,
they can see that the overall status of the test program is a failure but
it's not clear that it was running the same test.

Change all the messages that are logged to be diagnostic prints and log the
name of the program as the test name.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/tty/tty_tstamp_update.c | 48 +++++++++++++++++--------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/tty/tty_tstamp_update.c b/tools/testing/selftests/tty/tty_tstamp_update.c
index 0ee97943dccc..9e1a40f5db17 100644
--- a/tools/testing/selftests/tty/tty_tstamp_update.c
+++ b/tools/testing/selftests/tty/tty_tstamp_update.c
@@ -47,42 +47,60 @@ int main(int argc, char **argv)
 	int r;
 	char tty[PATH_MAX] = {};
 	struct stat st1, st2;
+	int result = KSFT_FAIL;
 
 	ksft_print_header();
 	ksft_set_plan(1);
 
 	r = readlink("/proc/self/fd/0", tty, PATH_MAX);
-	if (r < 0)
-		ksft_exit_fail_msg("readlink on /proc/self/fd/0 failed: %m\n");
+	if (r < 0) {
+		ksft_print_msg("readlink on /proc/self/fd/0 failed: %m\n");
+		goto out;
+	}
+
+	if (!tty_valid(tty)) {
+		ksft_print_msg("invalid tty path '%s'\n", tty);
+		result = KSFT_SKIP;
+		goto out;
 
-	if (!tty_valid(tty))
-		ksft_exit_skip("invalid tty path '%s'\n", tty);
+	}
 
 	r = stat(tty, &st1);
-	if (r < 0)
-		ksft_exit_fail_msg("stat failed on tty path '%s': %m\n", tty);
+	if (r < 0) {
+		ksft_print_msg("stat failed on tty path '%s': %m\n", tty);
+		goto out;
+	}
 
 	/* We need to wait at least 8 seconds in order to observe timestamp change */
 	/* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fbf47635315ab308c9b58a1ea0906e711a9228de */
 	sleep(10);
 
 	r = write_dev_tty();
-	if (r < 0)
-		ksft_exit_fail_msg("failed to write to /dev/tty: %s\n",
-				   strerror(-r));
+	if (r < 0) {
+		ksft_print_msg("failed to write to /dev/tty: %s\n",
+			       strerror(-r));
+		goto out;
+	}
 
 	r = stat(tty, &st2);
-	if (r < 0)
-		ksft_exit_fail_msg("stat failed on tty path '%s': %m\n", tty);
+	if (r < 0) {
+		ksft_print_msg("stat failed on tty path '%s': %m\n", tty);
+		goto out;
+	}
 
 	/* We wrote to the terminal so timestamps should have been updated */
 	if (st1.st_atim.tv_sec == st2.st_atim.tv_sec &&
 	    st1.st_mtim.tv_sec == st2.st_mtim.tv_sec) {
-		ksft_test_result_fail("tty timestamps not updated\n");
-		ksft_exit_fail();
+		ksft_print_msg("tty timestamps not updated\n");
+		goto out;
 	}
 
-	ksft_test_result_pass(
+	ksft_print_msg(
 		"timestamps of terminal '%s' updated after write to /dev/tty\n", tty);
-	return EXIT_SUCCESS;
+	result = KSFT_PASS;
+
+out:
+	ksft_test_result_report(result, "tty_tstamp_update\n");
+
+	ksft_finished();
 }

-- 
2.30.2


