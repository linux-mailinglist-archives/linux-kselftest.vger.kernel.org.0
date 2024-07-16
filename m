Return-Path: <linux-kselftest+bounces-13798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B97A93300A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 20:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E080428302C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4231A0705;
	Tue, 16 Jul 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx/UZ7uv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9161A0702;
	Tue, 16 Jul 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154763; cv=none; b=Ivq7Y+wvAgFrW5gTSd/oezujiO7B5tkXD9tuyCL55MudqRFjboK6g5G/63iBQO4A25asaR4td9mY3E4UfFNnU8C/hVAHT6NEuAzCgOvqnCSOYn7jSBf9eOLuz3Cdw5FFLPHv4/qP16+j2FX2fCd+NMNQCJDqT1tbTON0qyeAgao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154763; c=relaxed/simple;
	bh=mtGDAUdXJWHAEsDvZy5VJGLwCEj/vW4M9yrffQCipnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksPGzFm3Jd8JE7MhX2YUfTg2Wbi/OuzcJmEe32C7C2KbqUCrJIXCdGodFDFFU8nShwXqPLcXoTjou95q3+cnKxFV1leDS/34oVBxRRjIVW36gYl29lVLoK6wd4MmmAYU/SlNrkJ16Alc1ZqoQUzWK9Hfp6wl+0TgzP45qJWbTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx/UZ7uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50978C116B1;
	Tue, 16 Jul 2024 18:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154763;
	bh=mtGDAUdXJWHAEsDvZy5VJGLwCEj/vW4M9yrffQCipnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gx/UZ7uvfX5C6gcqq0SW5Sqt2SAeY3tZ/KIuVutNAga1lfoaStN9YC8Q3hakoQUK7
	 6JFcDRq6j9lXiaiSUHieleYivAGYAE0KCscwKKnI7TWeWh6XMVz0csC3NKU6Pc2Qqr
	 uJ2vA+ZcvCakff6Nse8ijZR10yAV1fUuuzZbgHtPTatTIMhy/dQbhXvR9TIUbmLm6V
	 qDnAQHscaN9xkeqWjM7dGNp/tZ1jZEj7/BXEk4FgU/6rAvXRc3LawHbOKTMb0sboAk
	 Ld+Ql7AWhwPnmGex416WnarwYWlFgOYzGhcrnRhkdNY3YtdvN42Vg1Nz3s29wN+dH3
	 7AvuSZmToBfQw==
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
Subject: [PATCH AUTOSEL 6.9 07/11] selftest/timerns: fix clang build failures for abs() calls
Date: Tue, 16 Jul 2024 14:31:51 -0400
Message-ID: <20240716183222.2813968-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183222.2813968-1-sashal@kernel.org>
References: <20240716183222.2813968-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
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


