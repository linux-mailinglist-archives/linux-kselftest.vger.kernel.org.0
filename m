Return-Path: <linux-kselftest+bounces-13801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7274A933027
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 20:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C341F230FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 18:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389AB1A38C8;
	Tue, 16 Jul 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNn1D8Nz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C33A1A38C2;
	Tue, 16 Jul 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154821; cv=none; b=fqYD3ghSQDAY2JNfJZ6f4p67DQTwZOYzPW/Yu/UYjnt1npuywho5YsV2p4wqfCSSRaRNr5O1KAN+sZHay3wUaQphpCynpCUDhqvNgyREM+I7DdVUMbF31Wc87zb3sP7lpFg0p27pU/jzr9M7A6owLoVpw74iZlM6sIRFE91egg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154821; c=relaxed/simple;
	bh=mtGDAUdXJWHAEsDvZy5VJGLwCEj/vW4M9yrffQCipnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSvLoavYd4iSNiqJ4yXqYqTgjx40UgQFUandurUbUDwixu++/wUX941OLwQSpvZQB3DCPg4OFacvVr6cdu/rqHI1nt/n/ZOTMOQFzm6ADoEY6DqDCx/D1zT1ai2GwQ6HObJdxNtjiYseCNKLApyEbQsH23X9YIA5yInol3w5jek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNn1D8Nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56926C4AF0B;
	Tue, 16 Jul 2024 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154820;
	bh=mtGDAUdXJWHAEsDvZy5VJGLwCEj/vW4M9yrffQCipnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNn1D8NzDR6kZ4jhnp2Mw5VWOpWb3tS8Y0BpevT3rQg9bE4jwbBb3hMSEBTkQxfkR
	 LR1sWR0zgzGPQxiql6fi1W42eb7Wwk0dxh9uSADAkPzJ6LLcMfnCC22Y+vmQWwlV+e
	 yttBExHMCjfu9TQdC27YRurKJDhyz1CBgPHaUnjc/xCoWWg5n6nfJWuN9Ghi29+ZoZ
	 K6o4tmlfYcg3dkZPcqVeINvv6UYJGffG0zEn6RlrX+HTXF4ycNCh43OCsjoO5U8P49
	 UkDJ7wZDh8s/az/dzMRJ8QgEKjoGDM6KF/u5PU4Rfjz9QcjL1FeAfMO+AnHxBax3Bf
	 Eqn7kvqtGFn5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Hubbard <jhubbard@nvidia.com>,
	Dmitry Safonov <dima@arista.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrei Vagin <avagin@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	nathan@kernel.org,
	0x7f454c46@gmail.com,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 4/8] selftest/timerns: fix clang build failures for abs() calls
Date: Tue, 16 Jul 2024 14:33:01 -0400
Message-ID: <20240716183324.2814275-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183324.2814275-1-sashal@kernel.org>
References: <20240716183324.2814275-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
Content-Transfer-Encoding: 8bit

From: John Hubbard <jhubbard@nvidia.com>

[ Upstream commit f76f9bc616b7320df6789241ca7d26cedcf03cf3 ]

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang warns about mismatches between the expected and required
integer length being supplied to abs(3).

Fix this by using the correct variant of abs(3): labs(3) or llabs(3), in
these cases.

Reviewed-by: Dmitry Safonov <dima@arista.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: Andrei Vagin <avagin@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/timens/exec.c       | 6 +++---
 tools/testing/selftests/timens/timer.c      | 2 +-
 tools/testing/selftests/timens/timerfd.c    | 2 +-
 tools/testing/selftests/timens/vfork_exec.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index e40dc5be2f668..d12ff955de0d8 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -30,7 +30,7 @@ int main(int argc, char *argv[])
 
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec) > 5)
+			if (labs(tst.tv_sec - now.tv_sec) > 5)
 				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
 		}
 		return 0;
@@ -50,7 +50,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now.tv_sec) > 5)
+		if (labs(tst.tv_sec - now.tv_sec) > 5)
 			return pr_fail("%ld %ld\n",
 					now.tv_sec, tst.tv_sec);
 	}
@@ -70,7 +70,7 @@ int main(int argc, char *argv[])
 		/* Check that a child process is in the new timens. */
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
+			if (labs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
 				return pr_fail("%ld %ld\n",
 						now.tv_sec + OFFSET, tst.tv_sec);
 		}
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 5e7f0051bd7be..5b939f59dfa4d 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -56,7 +56,7 @@ int run_test(int clockid, struct timespec now)
 			return pr_perror("timerfd_gettime");
 
 		elapsed = new_value.it_value.tv_sec;
-		if (abs(elapsed - 3600) > 60) {
+		if (llabs(elapsed - 3600) > 60) {
 			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
 					      clockid, elapsed);
 			return 1;
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index 9edd43d6b2c13..a4196bbd6e33f 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -61,7 +61,7 @@ int run_test(int clockid, struct timespec now)
 			return pr_perror("timerfd_gettime(%d)", clockid);
 
 		elapsed = new_value.it_value.tv_sec;
-		if (abs(elapsed - 3600) > 60) {
+		if (llabs(elapsed - 3600) > 60) {
 			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
 					      clockid, elapsed);
 			return 1;
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
index beb7614941fb1..5b8907bf451dd 100644
--- a/tools/testing/selftests/timens/vfork_exec.c
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -32,7 +32,7 @@ static void *tcheck(void *_args)
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now->tv_sec) > 5) {
+		if (labs(tst.tv_sec - now->tv_sec) > 5) {
 			pr_fail("%s: in-thread: unexpected value: %ld (%ld)\n",
 				args->tst_name, tst.tv_sec, now->tv_sec);
 			return (void *)1UL;
@@ -64,7 +64,7 @@ static int check(char *tst_name, struct timespec *now)
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now->tv_sec) > 5)
+		if (labs(tst.tv_sec - now->tv_sec) > 5)
 			return pr_fail("%s: unexpected value: %ld (%ld)\n",
 					tst_name, tst.tv_sec, now->tv_sec);
 	}
-- 
2.43.0


