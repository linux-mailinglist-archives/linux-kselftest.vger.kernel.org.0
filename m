Return-Path: <linux-kselftest+bounces-12518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6533B913A11
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 13:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2298D280CA8
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8261130AC8;
	Sun, 23 Jun 2024 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFLZPbce"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC2212FB16;
	Sun, 23 Jun 2024 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719142005; cv=none; b=O3cB8u7/DeJ6+FSuWX/gWwuSVQGEg/IJsP7YsMTu6rBQi0WWMS7v/PcN/ipoEAn+tS/+yrg182BtcIiynGH/+WI+8Mj4gmnPnkaBaCXAoBhZo9m3qjMAHTZJb+/5pf+VDd9wZ3jRlyX3yT5Z1nUGvwgNMe6tsmHXFKwN8ezALeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719142005; c=relaxed/simple;
	bh=Ns+1fxdSm08kdtmE5k60TaoPkn5o0cedh5wov4OMD2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZpfHfySnybt8lK3t7JuGe8t4eWz1YG3nl0zx3NjfA8Q0bmmbPRtrABawB7c5/tzDeCo/HMaYFkO9dUTYOLa2XFMbQ6wscZ5Uoh9YMusTkf1A2XoIj+hSMzVQKEeW7/9Kekutwd60h0cmo6nXjqzKICSFeAmyN/AD4I4mxlbtSqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFLZPbce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18E5C4AF07;
	Sun, 23 Jun 2024 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719142005;
	bh=Ns+1fxdSm08kdtmE5k60TaoPkn5o0cedh5wov4OMD2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IFLZPbcetrCj5BKukxAaS+ERdRqTx9aaoOECDGIuHu1wh6+4VNQ/12T1gBSZSQiq/
	 NnZZHjNHZk32/n2TMMuonqxRQLiIKOlJF9C1LxTq3jBcKbUG5FgiFxNwfFzTmnOwDM
	 vYgpxyGEx8H2cpEl+SNelgzPz3vxpSrygcnt3DOrYvGnjqbMaaQNgmaaI7kBOmBcwd
	 0qdOHw9lG/7fOzuqP0Dx/MdURLbX3695SVilwjOMxZpsr+nKSCwHMdu/dCWDPVNCIN
	 R9+BrGdoFHFsnpGdYD+2vGVBpfDuITh04q0d7be2sL5PDq0QTAqe2wm6Mgd7xbvg5F
	 10n/GfZciezZg==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 23 Jun 2024 12:23:49 +0100
Subject: [PATCH RFT v6 7/9] selftests/clone3: Explicitly handle child exits
 due to signals
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-clone3-shadow-stack-v6-7-9ee7783b1fb9@kernel.org>
References: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
In-Reply-To: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
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
 Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ns+1fxdSm08kdtmE5k60TaoPkn5o0cedh5wov4OMD2s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmeAZDuosQZSpfuY3XJTQ1dqm+pascfylx6In79ck1
 oArKUXGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZngGQwAKCRAk1otyXVSH0K8zB/
 9L6I/i+8gYUI6kQtVp7l7ltMHJLuzpPbpQXr/49cOdLz3OIHrt4ya0tG/QYpqcTb62W2Nw3cdTs2ku
 K4SjKs6FTNzvF6CYCJR5OX0+YV4cZ5But9VUCNEY/ABMcDgGYNqoVHE9T6qS60opli5VQ3XW5+RYon
 NVlS0547Frnp0g/FtW8+qk8DF0eoWrudqtmWIQZ6jT4UIJYEC+iuEv9GI35ZJo79rfJOgBc02LTFm2
 XRzNoNQNMbpwWtvPZkY0pIR2EtW3pbCF1dCOOd3zAUTuYv1S5YZEy56gmJ1G3RcFr56I5ykv5jysrM
 BkpMZs71zcY9q13gbuH+063NebCnHA
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


