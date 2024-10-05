Return-Path: <linux-kselftest+bounces-19098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37A2991619
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F4E1F2401F
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E99F14A62E;
	Sat,  5 Oct 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq2MPxUV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A991494BB;
	Sat,  5 Oct 2024 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124407; cv=none; b=Q7aFmsHp9Q+HrGYbJYHyj7eW0TqhFFC0rytHDUSPKRzjX7LRED1lzFKH6wOrMMLGUn5/J07BXuUW2G5wBNqRuJ8SOkuGmSV4fTcr7Om2e3onOV7Lxk/PISw+htfz33jFl6Q/zRC8n1QmSPl6EG2KvzVrhZCIADtLUVaorskb6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124407; c=relaxed/simple;
	bh=ewkcoFxIGUXL89FiyDyA2YmTyVasTMHDLRraAejpYow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KANxyW9LzhUAncpcLJwLdp6sMQdV+0fAhM5n/V4J7DzMpUDYOasDCu+jEaqzvyelAqinxfRRVbArCft97NDcPiv8GBOlLNO3HFA2tLV6KoeN8sey5DSreJNm5VS5EkEtSb03NMv2Wwslt5Vk7SWfBAxtobiAp+YcVpeSAvb8A8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq2MPxUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F06C4CEC2;
	Sat,  5 Oct 2024 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728124407;
	bh=ewkcoFxIGUXL89FiyDyA2YmTyVasTMHDLRraAejpYow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iq2MPxUVuM2WADq8mS7X0xIS2dpHTCo3n9bHt7wbUwro62Idzj4apa4aVk1q13jxB
	 ZooXYJ8ujykjeV7hp0xrGRZZPr3VPAwbtSfw8wwRUT6vUfcJeMjddUkOu7rOD/TN7w
	 ZP1TUjUrPXz9CvabP/XcB16xz3CA2qPhtZqq5MT5Qg0KVlw3lrGx2VPIfMEg8IJbRC
	 X3wACE3fNJYz3DpJwjvQp6Y1q6gCgoSlYqKWoMbKSKldsm+RkUMouiebFS5530kl/y
	 J6Gnfd8ViaQoAW+xY419hkvEeH91sa/Qwbd5GTsfqZ7eG79EsUKRuvbsMrqcFHUDrq
	 hP7Rs/3pgj1Zw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 05 Oct 2024 11:31:34 +0100
Subject: [PATCH RFT v11 7/8] selftests/clone3: Allow tests to flag if
 -E2BIG is a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-clone3-shadow-stack-v11-7-2a6a2bd6d651@kernel.org>
References: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
In-Reply-To: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
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
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ewkcoFxIGUXL89FiyDyA2YmTyVasTMHDLRraAejpYow=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnARXAze7RkiwBwKf6+LuNfjV37wR/IjY8FreITLGw
 XNE7/YyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwEVwAAKCRAk1otyXVSH0CPzB/
 9KoO7+Vb5jk+6ghKycsRFQy9Nvpcuk8pFGgkWEBtGE4txvdiDpjZnk5HpNjnaMgMcjg5lmgMPeovRM
 kEStv411wfmOPC5lC5/21deqkmsAQdcN0/zFfzG90jWJwev1xtEn/VS7UYaG+HrIXP3yT9B7WZkbzj
 zvXnsH5RPoudmBUmnT3dJLkh1NHRveU+tcpQJ6tN2aiIYORyTiTYVVa+PGzyTf/jm9wKCRagFpiDQv
 FAsfTzL1I0HL83UivqYcGYm73CJJ08DInSkWuH20MitXpLE9Kjlee3CcMu5KKeaBezmfGFae9MvT9U
 LdnFq0W+Qzd3L75xgpsqJP2aiJZr6U
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e066b201fa64eb17c55939b7cec18ac5d109613b..5b8b7d640e70132242fc6939450669acd0c534f9 100644
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
2.39.2


