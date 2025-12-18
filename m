Return-Path: <linux-kselftest+bounces-47694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78155CCADC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 09:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EB643042B34
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2427F3314A0;
	Thu, 18 Dec 2025 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a55ul0/i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFE12DE1E0;
	Thu, 18 Dec 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045626; cv=none; b=pR6yibdKQKbUMfh/nntg2OIZcm2EFErZpyK5g2n6wCqGovIb1uUeTYKa19xTmn0NDP1jhAGAKUVRylGHSkkGNJ1keKCYKVk+mZlW3To/0A791mS3ozRWHLkl0ljvDMkENredV0Qi4czy9rFB3Bl8XiKxP2PNt1VS6MTD1WrsHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045626; c=relaxed/simple;
	bh=A1dmn1Lt5Sgv7peqK8b9pCFAystHjFcAgH6JkrDrGcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TESh0fDpJQM3H+CGzKvxETvXiPUx5IAnpLWXgXThv8jU2VN8+a/4rgpWel+CbxD+gGuBOuigiqXchVI8huZbFW5kZ8fELXV2vcDQBKaUL64zQWIT4OHhnPoRWzsuTV919s7g3qFjzcIenpCLa59QFQw0fgwZoX/fa3cMJidhzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a55ul0/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817A5C113D0;
	Thu, 18 Dec 2025 08:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766045625;
	bh=A1dmn1Lt5Sgv7peqK8b9pCFAystHjFcAgH6JkrDrGcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a55ul0/iKesGTk3btVfegJA7OlyQLzSiO5XN9QWiNTaZ0VVTWzLgVsRDxdXYkrRQN
	 faWs8VydkBfKcV6JAd/5afTVkIdmCW4mfLA4WjlZMNFGG6VtAG6iy6Log7Rp/My7MY
	 2sdiu4Ejdf+9FixuoiI1V9icQMOJyYDyOQodzn8vthX9VsZ3cZIlF7eBInsHwnpHxk
	 mye8MSpgILBNpUguNeFZ9EoPAePwh6D/F6zFmlbBOeKiNPibdjxde3RLUx+GF7NOp4
	 2EpLIdWdowlTb0I1C7ZHAftQv3qp7t3t0re+zMcdS5192QRvMRz1NzwuwRYOIuTb0C
	 8+CakaO7S+aVw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 18 Dec 2025 08:10:12 +0000
Subject: [PATCH v23 7/8] selftests/clone3: Allow tests to flag if -E2BIG is
 a valid error code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clone3-shadow-stack-v23-7-7cb318fbb385@kernel.org>
References: <20251218-clone3-shadow-stack-v23-0-7cb318fbb385@kernel.org>
In-Reply-To: <20251218-clone3-shadow-stack-v23-0-7cb318fbb385@kernel.org>
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
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=A1dmn1Lt5Sgv7peqK8b9pCFAystHjFcAgH6JkrDrGcE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpQ7d/JSCYBDCqmM/wHVJTzJN5r0x+agtCQ3NX+
 Jmk+wj0Ar6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUO3fwAKCRAk1otyXVSH
 0GafB/90LBIaRWKm1cl1IIoCA7eGSlx0BnYY9504ESUUdEYLHFKaSMwm4f6t9bLIWgfxdPgbmIG
 YZo/+PBCHWvXNxbWsU7uDeiYx6f5gFSm08QH1FPpFsX6jreTrVTW1pdcEW93+2cPHzjQb6JgC33
 sgIYMwCR19X790qpYeIfXkAmugD6uhKhL0M9mF4C1y5o3Of1iceEkyuIqMxKNdX3K7fNGFiPSti
 NiwXQ5Zq9ZC/8MbyHX3EuzE5QcJAA6zv0w0ptIcGdLOtE8Y6IXOjsGTJKqlr65aCRarz7WfLT9h
 SyBdeEe7z1eYskN0gb2QrxMybNVqgv0zkCv8onhajppKfx9g
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
index 8c852d022c55..932cc64e9ae4 100644
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
2.47.3


