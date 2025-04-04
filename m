Return-Path: <linux-kselftest+bounces-30085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521AEA7B33F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 02:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4089617316B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 00:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDEA1F12F3;
	Fri,  4 Apr 2025 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajBTl75I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D56D1465A1;
	Fri,  4 Apr 2025 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725131; cv=none; b=JGX7b3nylQBeCThOHVKTpUz0RRdwYlmmIUISQNOrSU5UCbUnSPpLIAj5ibxEPJ5Bjodw9oOSOw8BIMF2Xjf1MjLeMjmGE0he6l1bDMVZSvXrpnPJrJKhazGsAOEaZVSJiBCCnJ+gHGRLtwuLZjcuFBv6cOoE2Ky5N21VHkJhtNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725131; c=relaxed/simple;
	bh=++Lt+jTTYNcu9oPcAbtsWGYTU7EFvOohEY+9xVf6pDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ratnrRmLHTMXB+mwubvi6t7Iaz4x7vmvilsS6a07deaqX9TpWcafd/zQqiq+TBAcd7h7X9S3Kw02p34rumXRUWrE7bBUYiVWq2DQkCr6BMUXVs3v8cwHRjL76qGACpgpR2KBcniGvU5LuR4cs97HU0gt/KB1KfUdyGGjfzZ2TE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajBTl75I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680AFC4CEE3;
	Fri,  4 Apr 2025 00:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725131;
	bh=++Lt+jTTYNcu9oPcAbtsWGYTU7EFvOohEY+9xVf6pDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajBTl75IPMMZAd7SfK8suHREh/P0Lf8B7B3x1aRebxoapxASmDl0S0sHp7XiXnwOr
	 K501+WgeImzH2TDLGVnVbKitJpONoFhApOvo+6ONPYy5A08s4rdJ8CVSayiEAttLe7
	 Ei2fMTTAOPvaTL0ISMYGbfm3gpz7iBu/d30H9B0xNZKtU/uYCsUG+cWyMWoCdmaC7j
	 YcJItS6cmChaoJQxhcXQk43mYSOMnKJ/gnOhz+ZXiwWpFHZGtyUIT4vPtp5w8g6wNW
	 S6DFbw+dbja7jk6bT2njxJBye5WTJyIkzodCzUR6sv8rriqmxhx5bx/kxWIGE7TpUC
	 +VzDOBt0SwfTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Feng Yang <yangfeng@kylinos.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrii@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	yonghong.song@linux.dev,
	mattbobrowski@google.com,
	xukuohai@huawei.com,
	yepeilin@google.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 16/22] selftests/bpf: Fix cap_enable_effective() return code
Date: Thu,  3 Apr 2025 20:04:45 -0400
Message-Id: <20250404000453.2688371-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000453.2688371-1-sashal@kernel.org>
References: <20250404000453.2688371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Feng Yang <yangfeng@kylinos.cn>

[ Upstream commit 339c1f8ea11cc042c30c315c1a8f61e4b8a90117 ]

The caller of cap_enable_effective() expects negative error code.
Fix it.

Before:
  failed to restore CAP_SYS_ADMIN: -1, Unknown error -1

After:
  failed to restore CAP_SYS_ADMIN: -3, No such process
  failed to restore CAP_SYS_ADMIN: -22, Invalid argument

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20250305022234.44932-1-yangfeng59949@163.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/cap_helpers.c         | 8 ++++----
 tools/testing/selftests/bpf/cap_helpers.h         | 1 +
 tools/testing/selftests/bpf/prog_tests/verifier.c | 4 ++--
 tools/testing/selftests/bpf/test_loader.c         | 6 +++---
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/cap_helpers.c b/tools/testing/selftests/bpf/cap_helpers.c
index d5ac507401d7c..98f840c3a38f7 100644
--- a/tools/testing/selftests/bpf/cap_helpers.c
+++ b/tools/testing/selftests/bpf/cap_helpers.c
@@ -19,7 +19,7 @@ int cap_enable_effective(__u64 caps, __u64 *old_caps)
 
 	err = capget(&hdr, data);
 	if (err)
-		return err;
+		return -errno;
 
 	if (old_caps)
 		*old_caps = (__u64)(data[1].effective) << 32 | data[0].effective;
@@ -32,7 +32,7 @@ int cap_enable_effective(__u64 caps, __u64 *old_caps)
 	data[1].effective |= cap1;
 	err = capset(&hdr, data);
 	if (err)
-		return err;
+		return -errno;
 
 	return 0;
 }
@@ -49,7 +49,7 @@ int cap_disable_effective(__u64 caps, __u64 *old_caps)
 
 	err = capget(&hdr, data);
 	if (err)
-		return err;
+		return -errno;
 
 	if (old_caps)
 		*old_caps = (__u64)(data[1].effective) << 32 | data[0].effective;
@@ -61,7 +61,7 @@ int cap_disable_effective(__u64 caps, __u64 *old_caps)
 	data[1].effective &= ~cap1;
 	err = capset(&hdr, data);
 	if (err)
-		return err;
+		return -errno;
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/cap_helpers.h b/tools/testing/selftests/bpf/cap_helpers.h
index 6d163530cb0fd..8dcb28557f762 100644
--- a/tools/testing/selftests/bpf/cap_helpers.h
+++ b/tools/testing/selftests/bpf/cap_helpers.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/capability.h>
+#include <errno.h>
 
 #ifndef CAP_PERFMON
 #define CAP_PERFMON		38
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 3ee40ee9413a9..88cb75b65cecd 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -118,7 +118,7 @@ static void run_tests_aux(const char *skel_name,
 	/* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here */
 	err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
 	if (err) {
-		PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(err));
+		PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
 		return;
 	}
 
@@ -128,7 +128,7 @@ static void run_tests_aux(const char *skel_name,
 
 	err = cap_enable_effective(old_caps, NULL);
 	if (err)
-		PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(err));
+		PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(-err));
 }
 
 #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 53b06647cf57d..8a403e5aa3145 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -773,7 +773,7 @@ static int drop_capabilities(struct cap_state *caps)
 
 	err = cap_disable_effective(caps_to_drop, &caps->old_caps);
 	if (err) {
-		PRINT_FAIL("failed to drop capabilities: %i, %s\n", err, strerror(err));
+		PRINT_FAIL("failed to drop capabilities: %i, %s\n", err, strerror(-err));
 		return err;
 	}
 
@@ -790,7 +790,7 @@ static int restore_capabilities(struct cap_state *caps)
 
 	err = cap_enable_effective(caps->old_caps, NULL);
 	if (err)
-		PRINT_FAIL("failed to restore capabilities: %i, %s\n", err, strerror(err));
+		PRINT_FAIL("failed to restore capabilities: %i, %s\n", err, strerror(-err));
 	caps->initialized = false;
 	return err;
 }
@@ -959,7 +959,7 @@ void run_subtest(struct test_loader *tester,
 		if (subspec->caps) {
 			err = cap_enable_effective(subspec->caps, NULL);
 			if (err) {
-				PRINT_FAIL("failed to set capabilities: %i, %s\n", err, strerror(err));
+				PRINT_FAIL("failed to set capabilities: %i, %s\n", err, strerror(-err));
 				goto subtest_cleanup;
 			}
 		}
-- 
2.39.5


