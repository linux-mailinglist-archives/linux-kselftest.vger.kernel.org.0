Return-Path: <linux-kselftest+bounces-15016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09E894B8D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 10:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1371C244F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0DB18991A;
	Thu,  8 Aug 2024 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBZMaw+q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E77188CC5;
	Thu,  8 Aug 2024 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105055; cv=none; b=K74NBJpM/1sc1PnW/MYfnzhr+j2vChQIfU3lBXXz9QAlatb5dvPSmK11/C+JqG4Rzcz5h9BDItGiLHhSZ0b1+U3YIBsGprmkJyYiRUmnK8W/P7rMYcIfSnM62qTDVzkPVe1+f0NYBuuoc9T7UJmJ7zvpuQUctmQa4wzI2q5U86o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105055; c=relaxed/simple;
	bh=Ns+1fxdSm08kdtmE5k60TaoPkn5o0cedh5wov4OMD2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWsPZ+NDtfqm6jXxuDUDUgAHgQogJiu/OsgOn7z8hVEk4T1n4GpdK8ht+yKjaoYKEdt3rGKu9vxtGLXKhdB4cb7/a5R+0SH1YaddvgKzzpjwD9y1qGmdP/th2VCI33soM0TRTtP83tMXiT7v4FvIrtrVM6omfDYxPovqssARMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBZMaw+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63484C4AF13;
	Thu,  8 Aug 2024 08:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723105054;
	bh=Ns+1fxdSm08kdtmE5k60TaoPkn5o0cedh5wov4OMD2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IBZMaw+qQ3UIbw0tHOmQ75l/zS9cgxy0dS/VomfuFsE9NihOtqzzWUinj+v68lsrA
	 ZDMNE/CvsMaycQeKLTCXaayVOPtVDVJqf58qTOtemqUawMDvaS5puqdqGas9TZBLsD
	 w9QWUMHYAOjJpT5SkKE78xKAkngi+8PEUUyZps7u1J3Ozzy44vwp+8kBcVahHg4c9l
	 wrDAwjL3QtOy8qZ6XKk5btm13c6JVklV3aYht/MXN+si51dqtqmTPSTXHdu/mjmPNT
	 tGWfxTAw0seyhEmb0y3BBPJlze6GM2WrFRbvkANXXY+yx0jIVInznvWcpXvMCm53p7
	 ApK8pCNT6buCQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 08 Aug 2024 09:15:28 +0100
Subject: [PATCH RFT v8 7/9] selftests/clone3: Explicitly handle child exits
 due to signals
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-clone3-shadow-stack-v8-7-0acf37caf14c@kernel.org>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
In-Reply-To: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
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
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ns+1fxdSm08kdtmE5k60TaoPkn5o0cedh5wov4OMD2s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmtH7Pt250n9U88Z0izycnwrJNTy8HRaEsVEjKz
 ErcU3cXzQiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZrR+zwAKCRAk1otyXVSH
 0LMXB/9yr+1rHyn3A47ReERM2mxpFBh1kzPItdZ1NEsMB0oVm2CJZEjoDd6rnZ+YO8e2lM53QBX
 Wkx8am19cBrO1sD2+B6STFI5HNcGGEa9DVeX+SE4X2BiEGidFOV/7Kfh7ED3W6oz1sNFzh0is5X
 XLHugTDQE+I4Ce3uBAiSQ7fc9fdTAU6dKYSNquskuZSfP6IE9JfcsT9O63aHhB3bwFu4O792Mp7
 X8LozPalk9chxwlLrZvDWtQ0oA+lobpkRdwEGRpD/zH4s7IqlT3/PH+YaEx5Xjb66ohTGffx6Hg
 zmeLt6T6dfKOxK1xfk0Wj4cTtD0BLV1BR2bveF6kwXoKslsw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to improve diagnostics and allow tests to explicitly look for
signals check to see if the child exited due to a signal and if it did
print the code and return it as a positive value, distinct from the
negative errnos currently returned.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e066b201fa64..3b3a08e6a34d 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -111,6 +111,13 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 		ksft_print_msg("waitpid() returned %s\n", strerror(errno));
 		return -errno;
 	}
+
+	if (WIFSIGNALED(status)) {
+		ksft_print_msg("Child exited with signal %d\n",
+			       WTERMSIG(status));
+		return WTERMSIG(status);
+	}
+
 	if (!WIFEXITED(status)) {
 		ksft_print_msg("Child did not exit normally, status 0x%x\n",
 			       status);

-- 
2.39.2


