Return-Path: <linux-kselftest+bounces-20877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F16D29B3EE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 01:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A4B21F93
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1A3FE4;
	Tue, 29 Oct 2024 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ9zW8eN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845EB33E7;
	Tue, 29 Oct 2024 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160652; cv=none; b=YaUIaV1B+R0ZGrvGrcCFIkZ0HBSORntuG6cxBkH+/xrmWgVTNVcoNtqT0d+sKuHhpxaxUr9fhSYq005av+D8FMaeJC2x3PL13SNb90LTrdu0hVh5sWKYp2lkirFljIOrKU3yMtcl+7Vk1Ycx7NNBPx63V709BYJl2YnQ0wZM83Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160652; c=relaxed/simple;
	bh=+Gi4Oe2ngnG0SL/5UrZCeKSkpi1etLj8XBbfiJB/w3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F8LpINi5fhKCcS7v3+EJtbjgvqQPFHKR5T1igzTq+vHlo7/OP/w/LCdne+NUzknH9BbDFrWtZXVDj6hBzHCRpfOq8OAOPAJlbMjraGuszi+pS8VYOaGOvnfv/cc5jGfbtGbIEiJbPWqT9awsaoDnzRFvXYUX2BNveJPoxotehS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ9zW8eN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5C4C4CEE8;
	Tue, 29 Oct 2024 00:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730160652;
	bh=+Gi4Oe2ngnG0SL/5UrZCeKSkpi1etLj8XBbfiJB/w3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CJ9zW8eNEl+nbNIdJeSdvQYI5gETvK3MLPsfVBrggNMWzD+D/0g+a9wPhOPXuVXN1
	 vOqa5Sg2L3ZFcLRVEvLTQdxZ3ElOl6V042nbYOze7t23pzIsWDN8Hyo7M7kGVN5DYM
	 azEx2UZDBuMIg0QYTWjemf+2m7cfZNqm25p1bATsz2zze2frc9wBYjj4RI0D1MmSWd
	 7K7sIk4b2OfMFNxAsaa0LZPcXKK+Ga8bBzvhYwJ22lxkhKPj61L9NnLrwjPwNru4d8
	 AbAKbdJj6CYcVgb2AoSM7FM/bV5KiIwm4DHPFz292ZuaN5d+Ck9+ExsLB1HUKWNE3y
	 rFRyp02VHslvQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 29 Oct 2024 00:10:39 +0000
Subject: [PATCH 1/2] kselftest/arm64: Increase frequency of signal delivery
 in fp-stress
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm64-fp-stress-interval-v1-1-db540abf6dd5@kernel.org>
References: <20241029-arm64-fp-stress-interval-v1-0-db540abf6dd5@kernel.org>
In-Reply-To: <20241029-arm64-fp-stress-interval-v1-0-db540abf6dd5@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=3142; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+Gi4Oe2ngnG0SL/5UrZCeKSkpi1etLj8XBbfiJB/w3U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnICgG5FfJcG+PYxJosmkGnvgsJdS5TbhUu3+17QpS
 h8kXLwiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyAoBgAKCRAk1otyXVSH0PIWB/
 9TUp1BBy1LSk9zADPHE5KWliTKbOohtTTsS5+HTMSnTV7Zdsxh/snxGlm7bWWKVZcZJV7VaaxLdlQS
 7k50mDKGRppK5F885f0fP9cTmY2gcw1FbE3R4C03/B7yn6ygbuFmS4fIJpGanM19zSM7AHBEScXjCi
 0/niDWI8/suIlWRt7slep6/BuVu78noMlBvsfl2hBC32Sc+Nd2CLfKC7CWr4HuNziuswiYHHhu8cR4
 8+DZ0KlZn9GI1HPpZPOjhD875EI3ORHAefhMByr+LsHDOHIefArqigF6jgrREu6z2NhPudHuChIqG/
 sMKBWxeTu/QrOQ0RyeUH22fBQVOSCk
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
 tools/testing/selftests/arm64/fp/fp-stress.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index faac24bdefeb9436e2daf20b7250d0ae25ca23a7..c986c68fbcacdd295f4db57277075209193cb943 100644
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


