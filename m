Return-Path: <linux-kselftest+bounces-43197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7079CBDE975
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 15:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB56484952
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A2632E73D;
	Wed, 15 Oct 2025 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahNnBIeV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C01E32E729;
	Wed, 15 Oct 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533151; cv=none; b=cGLgZbcIfXpL+J0JEQtqbc41N5RUXWIZDVIJaJUCEXM1fnDljMFuy3rQLnZ23/j8hMyB4GGNz0f+1GZA7/UlZJ57Rm3oI3XOT69LI6ib7gnq1RK9LUT0tNa+EF1e3be7x776n8QsTVmINTBGvZria03Ok2Z+M4bFjDkDxHIiFhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533151; c=relaxed/simple;
	bh=G8bBSQKlO7rId1LDmFNrephPZ8IGhE5zllPW+If3ahk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIQl00/dRjIEULHGp3pyKQU/tm0iwh16OC63n6S0twM8oQElOexIHMO0tYbBh09iRvDk/0ytqtjlkXD5iMSX5M5T8G3fRCbhnGGVh0RP15bP3Qwa+ZZSkKL+TOlF5nff1c47Q1sOBfwFmScHRKn8LyoQcTL4vV6ZOR4rdQoAmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahNnBIeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE3AC113D0;
	Wed, 15 Oct 2025 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760533148;
	bh=G8bBSQKlO7rId1LDmFNrephPZ8IGhE5zllPW+If3ahk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ahNnBIeVchAasUGr3M66wmskOmoLqKw2cgWvWpjCuPmDQgR/X7zrkXso/PWXkOxST
	 Pk5B9UDZtkgRpJy9+CRf28xaLwGJQuGSOFVkQd7//VhywobPWYSC3AhCJYxzRwl/vt
	 zRb96J0VKCcTPwKM/GNs1R2SrR5GJlWl0JGyvjgj6k1gf7wRZcL/+AMTMoUislE+v1
	 9bVMJcFRZvBCdiIp6HxG1X3fLwsZbMbq6ql2m+Y/52hayQOt3Wm9x64SIWQvS5NEY+
	 f+7fOQPEUPdGpNxSu67Og4BdynVZysIihtVidpvPR/Vmiubz7E0A2uVzFcwSnB8Pf0
	 4R+gmJ5eGnQMw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Oct 2025 13:49:11 +0100
Subject: [PATCH v22 7/8] selftests/clone3: Allow tests to flag if -E2BIG is
 a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clone3-shadow-stack-v22-7-a8c8da011427@kernel.org>
References: <20251015-clone3-shadow-stack-v22-0-a8c8da011427@kernel.org>
In-Reply-To: <20251015-clone3-shadow-stack-v22-0-a8c8da011427@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 CarlosO'Donell <codonell@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Rich Felker <dalias@libc.org>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=G8bBSQKlO7rId1LDmFNrephPZ8IGhE5zllPW+If3ahk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo75pkHLTKCUgpWHOh+ij3lvSQvDKvLdoB+SUXx
 EiKLMPd6T6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO+aZAAKCRAk1otyXVSH
 0GMzB/4wzMKj8DGLbRrvxWJPUxC6Y5DlzZKzv5BllDHRtwCSiXqg0XSiQO5Rv5E/JhfXurtIXAy
 1ZetbI1d23syPFjGtnqde4mKrEc4g3GQh5wdzQLNAWb9jW/IX+QJgKlXJZH+NahW/qF7ILxskzw
 E76a66SNVJ5P/wAO1jYokH7mrU838ZHaXqZRdAVePxbW0ohOzF2nnVlagaaKlPZjverarn+Chc+
 KpQnZ8Vssp8ZovMJSyNz116uPMK2ajRgWtb7sRvrxcJlXsfR943cOeS813rD5XceSrnVQrht8b2
 qpUY2newB1tXxYD87FEkUH3TYbZFAUF3vzaYr5kbkOxRUj2U
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
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
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
2.47.2


