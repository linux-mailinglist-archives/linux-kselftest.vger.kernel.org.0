Return-Path: <linux-kselftest+bounces-21060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C3F9B5826
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 01:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C671C25CB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288648F7D;
	Wed, 30 Oct 2024 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQDOJqxm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED063CB;
	Wed, 30 Oct 2024 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246539; cv=none; b=K2wTlQVKL6ka4FD5F0J927Zlf+f30tgVhyd1hqw1WE9eWSuyXmoZS5Xt0Y2mVQzFGqjXoCfGNMu4TAchGUD7LPZp/8W2su4B7BK0/RT2FlnydgyY6vtdNAKwAyNfBigRj6NhhFTGRPVg0Vxcjqmh63pDqNGnB4l8qg0NxIi4C6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246539; c=relaxed/simple;
	bh=ZTF3X5004ugxu+b0r8whBammEg+NJnKe47itkV+Nzn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agCY3b6pjT9PDp+DTJIDW0i8R8Di95BxS9cvu72qbehwk0pMez54WE+ofhxrN8szYRmWn5STdCqkdVF4SFprhyf5biS4CJrjguT/7kHFgyDrCN90f+F3tQ6afDDFbhFQ3uU6mE+2qutK4floMLmTNkLE+hYEDPNyKB/PgcVXXrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQDOJqxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B96C4CEE6;
	Wed, 30 Oct 2024 00:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730246538;
	bh=ZTF3X5004ugxu+b0r8whBammEg+NJnKe47itkV+Nzn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kQDOJqxmlCo+b8vm1je6stxuX61EXkKfESgokOQ/AGJ9HYuTrFJBdeBHATvhzK75A
	 FfYZVlSwoKeKYuHryjM3HLdb2yVjUSjdExW0mnFNVytYociEp7NHM3flJFjW7nK+jO
	 sdoQ5H1vAivIRZGR95Yn5yZ9LP1tsV3nbQHt01+2nw2Rd5vs6CYKbaTxHAC4xD3Z8m
	 +81dnaNmDZwZPvpBq5jQh/feSLgqKsBhWLjwbSwqVHUyWrTkAakI639nhcCusko83c
	 1sQTk63gWMS1bFF6PCsFMVakMfvP3V7cFAZ1Tk8pN8UiA40DVHzBy60wU55UM6UoYL
	 dHyJyfq0kJgiw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Oct 2024 00:02:02 +0000
Subject: [PATCH v2 1/2] kselftest/arm64: Increase frequency of signal
 delivery in fp-stress
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-arm64-fp-stress-interval-v2-1-bd3cef48c22c@kernel.org>
References: <20241030-arm64-fp-stress-interval-v2-0-bd3cef48c22c@kernel.org>
In-Reply-To: <20241030-arm64-fp-stress-interval-v2-0-bd3cef48c22c@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=3429; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZTF3X5004ugxu+b0r8whBammEg+NJnKe47itkV+Nzn0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIXeFYSH8SGYUE/hJ8iQ2ZUyfWpkt2Dk/ZTv7+x1X
 OSLwqTiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyF3hQAKCRAk1otyXVSH0CUGB/
 sHLIuDk/FjxdcsHp3mOCJNmYoruZN13js6UA45pOJSK0IElqkbQDzOTc3emdQmh4RwUAr8zTLkBYn3
 dyXdEhVoRWrOEDSVS1aRh4ppE/LOv2rcCjq0ZhgFsn0B9YKFTTJTMQFBxizmt4hiZ/asHJUHof+Ko3
 m+pVNLKYtvGMAgmWlekFYK4Mwv/D7JT81Blu4O3K/XL1IqktL+njQEpnZhuU3AI2usd02jDZQyX8ro
 zc9rrffUMIGyYl6jv2mMurXNR8J9mpzeu1jXYFdGqmiidlQldbpPMZ9yciDO7LDPdta0DppNUKydY+
 K9ncEw/UKKAvXCdYGXvG4l5wKKB59u
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently we only deliver signals to the processes being tested about once
a second, meaning that the signal code paths are subject to relatively
little stress. Increase this frequency substantially to 25ms intervals,
along with some minor refactoring to make this more readily tuneable and
maintain the 1s logging interval. This interval was chosen based on some
experimentation with emulated platforms to avoid causing so much extra load
that the test starts to run into the 45s limit for selftests or generally
completely disconnect the timeout numbers from the

We could increase this if we moved the signal generation out of the main
supervisor thread, though we should also consider that he percentage of
time that we spend interacting with the floating point state is also a
consideration.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index faac24bdefeb9436e2daf20b7250d0ae25ca23a7..71d02c701bf56be56b7ad00a5f6614e33dc8e01b 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -28,6 +28,9 @@
 
 #define MAX_VLS 16
 
+#define SIGNAL_INTERVAL_MS 25
+#define LOG_INTERVALS (1000 / SIGNAL_INTERVAL_MS)
+
 struct child_data {
 	char *name, *output;
 	pid_t pid;
@@ -449,7 +452,7 @@ static const struct option options[] = {
 int main(int argc, char **argv)
 {
 	int ret;
-	int timeout = 10;
+	int timeout = 10 * (1000 / SIGNAL_INTERVAL_MS);
 	int cpus, i, j, c;
 	int sve_vl_count, sme_vl_count;
 	bool all_children_started = false;
@@ -505,7 +508,7 @@ int main(int argc, char **argv)
 		       have_sme2 ? "present" : "absent");
 
 	if (timeout > 0)
-		ksft_print_msg("Will run for %ds\n", timeout);
+		ksft_print_msg("Will run for %d\n", timeout);
 	else
 		ksft_print_msg("Will run until terminated\n");
 
@@ -578,14 +581,14 @@ int main(int argc, char **argv)
 			break;
 
 		/*
-		 * Timeout is counted in seconds with no output, the
-		 * tests print during startup then are silent when
-		 * running so this should ensure they all ran enough
-		 * to install the signal handler, this is especially
-		 * useful in emulation where we will both be slow and
-		 * likely to have a large set of VLs.
+		 * Timeout is counted in poll intervals with no
+		 * output, the tests print during startup then are
+		 * silent when running so this should ensure they all
+		 * ran enough to install the signal handler, this is
+		 * especially useful in emulation where we will both
+		 * be slow and likely to have a large set of VLs.
 		 */
-		ret = epoll_wait(epoll_fd, evs, tests, 1000);
+		ret = epoll_wait(epoll_fd, evs, tests, SIGNAL_INTERVAL_MS);
 		if (ret < 0) {
 			if (errno == EINTR)
 				continue;
@@ -625,8 +628,9 @@ int main(int argc, char **argv)
 			all_children_started = true;
 		}
 
-		ksft_print_msg("Sending signals, timeout remaining: %d\n",
-			       timeout);
+		if ((timeout % LOG_INTERVALS) == 0)
+			ksft_print_msg("Sending signals, timeout remaining: %d\n",
+				       timeout);
 
 		for (i = 0; i < num_children; i++)
 			child_tickle(&children[i]);

-- 
2.39.2


