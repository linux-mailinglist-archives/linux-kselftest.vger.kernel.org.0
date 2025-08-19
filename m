Return-Path: <linux-kselftest+bounces-39320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038AEB2C9C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 18:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413EF5C2BA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23DE25785E;
	Tue, 19 Aug 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8r6ilfH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D11214A6A;
	Tue, 19 Aug 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620876; cv=none; b=Dc0oRtKRqTeBKxpML3L0qFDmNbDBz+FxZpfbuCTEobFnxAY29nRblsjmpSI4ZChNOPckf2UzU5rHIXvMt6c61l2EmFrbQ0Ve4E3PvyGmn8H8Y/CqakcPeFPmGSv/RrsHdCHXqxI6YXB9/DDMyADZM1MzBZu1bBl4LxsItBVhHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620876; c=relaxed/simple;
	bh=8IZxQR2EJWcC8CtTN5ZvDL0ZGuJwJUzmD8bnJ/92bkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EAVfxW3Oe7tTjmpPel7WYS90XfknGjhFoDenNtoMM3SoysIPTDVjjeTN+hMpglkfYW3kMsEagtTHnM6ZdK7x7e86JkCQveRR8BOcBRLAYLsBdVu0/Vp5cfmfwWPRZEqpxxUT7W8Q1xPbvxx5KEzNO+OI0PS3hVVOYbb2Jwlu7p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8r6ilfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9669CC19421;
	Tue, 19 Aug 2025 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755620876;
	bh=8IZxQR2EJWcC8CtTN5ZvDL0ZGuJwJUzmD8bnJ/92bkQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G8r6ilfHHGQ7GjSE9WFdweYjEjMxoBVX50S+NDSRWCjj6h9zLbpnGBvovKZyeO7nb
	 YFCqWONmAe9IaZeDnn10oPTAURZFbjMgoupkqlmQrq59Oi2bitCMF1RrZ44KABzNXR
	 PW3oAly13FJmRrwKB1j/Kac+SepTjn4fgGmZhyaRNDeiu05TDZ2mBsPVfBPHgd2wYU
	 7M7AUWBKj8p9vCPd8cfdrmJdLIWH1HNx5z91Lo81SBg4XTXH48vkqlkIzWnifKx3TM
	 0rnHRFxpnbzV8JdS2+aDLN53s2Z/cDYFHvoy3gYA44m3wzc6rjV8vXqMelaW6pc1wp
	 xXUxtCbInXzvQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 19 Aug 2025 17:21:53 +0100
Subject: [PATCH v19 7/8] selftests/clone3: Allow tests to flag if -E2BIG is
 a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-clone3-shadow-stack-v19-7-bc957075479b@kernel.org>
References: <20250819-clone3-shadow-stack-v19-0-bc957075479b@kernel.org>
In-Reply-To: <20250819-clone3-shadow-stack-v19-0-bc957075479b@kernel.org>
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
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8IZxQR2EJWcC8CtTN5ZvDL0ZGuJwJUzmD8bnJ/92bkQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBopKXTiaTNYXEL7eVrB66m1hpHLBTUk8zXThuHz
 MmL7+wlfoWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKSl0wAKCRAk1otyXVSH
 0GgAB/4+ZjjtJ/ZQej1kUcB7oSFe6zl3cTPBDsV3yDkrvMfk+xEYVV5VFZUfCmpqEfqfKTef8/e
 IA6ILUKJq0ge0leTKm74xP/hLJfmluH41auWlEIWns4fJTjMDVzrhlxs5OBaQeUSObd3kmHbAil
 kubyh06T9FXrJAj0DxKdatAB42hPjz9Ba7a3JmYpcKg0Kgn00R8TgAgPikh+xzZVvEch4zSaM5d
 CKFe7lgZXAy/6nAv+c5E9zPlaxzUMGUmGAV1NWwT3yySBdrJEZ4ZlpIhvtDPbdR1zz91GmKhp6X
 26RfbRfI5Sarxb6gMXMGcNdE7mQu/urvDmJ76kFgBfuye4ov
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
2.39.5


