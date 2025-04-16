Return-Path: <linux-kselftest+bounces-30924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BB7A8AC37
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 01:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9F1443FBA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA332D92F8;
	Tue, 15 Apr 2025 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChO6wi5e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5128E5F4;
	Tue, 15 Apr 2025 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759947; cv=none; b=n6JGOoeBSm1KPktMULl2DqEe9lT4zKmUpe/SUy30e9vVVuVY8hXjyFKA1JqtVtfd4ZI6V4tp0wd3STN98u6JB7d0WlpQ3WPONFXV14+eyCLvYNFuAQABuvoiSlqRxMK6E9nLk35AXeK3mI5NLm4/AJDsy+7AVJb1zEiePkMqZgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759947; c=relaxed/simple;
	bh=58+3HJOajqHhaBuOa7ipEd3ah9IrK8/b0nQffaXKgLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dp3YqElXO/yEXGxZLJmDlac+B+AzELIBYEwaf6N2IhdyyDUofVI67rWw+PGVXFxJ5jPojHM2oq9X3uumx8McCVNl6/KtNgakbwxLZnOlRBYUYq3YQziWToBhfpgfTbfYGjUVLz0h8vNLtoStNPQDnwkwd6WT5gUPdU5IJrprz9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChO6wi5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0386EC4CEEF;
	Tue, 15 Apr 2025 23:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744759946;
	bh=58+3HJOajqHhaBuOa7ipEd3ah9IrK8/b0nQffaXKgLE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ChO6wi5eWmGTNrx4jpBFah4SIyaUy/AHH284qTVUzl1Rgul9fbmz+4GD01F/NjDOw
	 3/BhnrgP1TYLvFYCTCj/FucvgWu3cP9UiIgi7ssGuDmoy887RiWA0TUyKkpq5OuL1K
	 vYvYcn2KFyjX4jdbxswSFg0mMXxEfFOihLyWiyj++bNAUMCZL74YPkFjmuUUK/sefX
	 7bZu3jLjnLI0JM9kjt0I89lbzBXfY/VQSy1AlGGM3OJs5oyPZ44vm7W+esPMV+c1+z
	 +PooKfT+bJ0c7PyBu4fMECZREa8DxSbyMOgb9/FJoijQYJ18w2JPXYkoj1BTcNFh0N
	 nT1M5pgTfJriw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 16 Apr 2025 00:31:14 +0100
Subject: [PATCH RFT v16 7/8] selftests/clone3: Allow tests to flag if
 -E2BIG is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-clone3-shadow-stack-v16-7-2ffc9ca3917b@kernel.org>
References: <20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org>
In-Reply-To: <20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075; i=broonie@kernel.org;
 h=from:subject:message-id; bh=58+3HJOajqHhaBuOa7ipEd3ah9IrK8/b0nQffaXKgLE=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhvR/byKFBXw7es0/Xb2c9zGzpU7xloFZ2ey1s+PT2YIdPRMk
 ZHM7GY1ZGBi5GGTFFFnWPstYlR4usXX+o/mvYAaxMoFMYeDiFICJhCWz/y/mMjWqjl/WE5fxftchx5
 O1DgHh8cs+NAsF7zY/nL7yS1rgh7zzqoZTdic6fFa7dSvNa03+z3Dm3ML9L6+umO268G/8kslGGd8c
 QpNi32x8H33VNvqRlIrx/axioxyFV0VlDHwaT9eHdpR+NvtdPU1+mmFj2RyzubNON6sdVJJzrFJRWz
 Ej/XHbZu4jkXMuOjmEfS0u1Fw039BWLZclVDRBV/9Tu6Jq8BrXE765Ny5PcCi8dc78y/r+U+0Zxewr
 2j3cdmgv3KFZ93Jmd6vPmz37GOoNz7KpZYT8tC7i9mIwbP93raIl99ImnVa52oXtFUr1ezT5emIDbh
 2TkjjDXsbodWrd7U3vW3K6OH0A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The clone_args structure is extensible, with the syscall passing in the
length of the structure. Inside the kernel we use copy_struct_from_user()
to read the struct but this has the unfortunate side effect of silently
accepting some overrun in the structure size providing the extra data is
all zeros. This means that we can't discover the clone3() features that
the running kernel supports by simply probing with various struct sizes.
We need to check this for the benefit of test systems which run newer
kselftests on old kernels.

Add a flag which can be set on a test to indicate that clone3() may return
-E2BIG due to the use of newer struct versions. Currently no tests need
this but it will become an issue for testing clone3() support for shadow
stacks, the support for shadow stacks is already present on x86.

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e066b201fa64..5b8b7d640e70 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -39,6 +39,7 @@ struct test {
 	size_t size;
 	size_function size_function;
 	int expected;
+	bool e2big_valid;
 	enum test_mode test_mode;
 	filter_function filter;
 };
@@ -146,6 +147,11 @@ static void test_clone3(const struct test *test)
 	ksft_print_msg("[%d] clone3() with flags says: %d expected %d\n",
 			getpid(), ret, test->expected);
 	if (ret != test->expected) {
+		if (test->e2big_valid && ret == -E2BIG) {
+			ksft_print_msg("Test reported -E2BIG\n");
+			ksft_test_result_skip("%s\n", test->name);
+			return;
+		}
 		ksft_print_msg(
 			"[%d] Result (%d) is different than expected (%d)\n",
 			getpid(), ret, test->expected);

-- 
2.39.5


