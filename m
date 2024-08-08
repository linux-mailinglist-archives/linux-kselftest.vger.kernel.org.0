Return-Path: <linux-kselftest+bounces-15014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A7494B8CC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 10:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B9F1F231C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 08:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C8189913;
	Thu,  8 Aug 2024 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6aLwdSg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFB1891C3;
	Thu,  8 Aug 2024 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105035; cv=none; b=FOyv8Y5xEllQK0rtil8b5B+JrmrSPtrnHGb3u9QyR7Taz/4sZh58tu+BHLD24dpyYHo2GENTLyM6gMsJHVTl6ugNvP0OhzidE2rSVguq3amvQPWJCY1UOjvdA2Z+SKKslAFGTaKAt9WMEMrdW8BxTQN5JjxfUsNM6ycBShTc+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105035; c=relaxed/simple;
	bh=A6PuiVWBdiPH6Nr/YX1UnFJ8RTIAC1FidWNruHY9Zks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFs/Ty/8xGTpWNQ/IzpBYmhvtEJhQl0spiAo2K2rtgiTw3XDAdeBrVo7xgTeR63El+dQNm5L0xAFOQokQ78z60iYNizxaDksVJX1RfWrvWYeHNFltSh/+6Fcj7TsfT7CUsNHUu+/PdEG/vastjUkxjOtAmCC51PkP5RIvk1fVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6aLwdSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412F2C32782;
	Thu,  8 Aug 2024 08:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723105035;
	bh=A6PuiVWBdiPH6Nr/YX1UnFJ8RTIAC1FidWNruHY9Zks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g6aLwdSgMq9nygmMRtLkLbcnDuvauEA1hOSKKL2QfcWenhlsujD/D60GLLRGwVMAh
	 v+KHn8t45fjM3aV5iB9Gviyz7vbweT1/6mubzj8+Exny+FYyd07j1QhT6HGIRIo/00
	 aU5Or1u7Ln4IFCivJy1zkUVlwpdc2wyPNExuAwPWPViFX90gPj5gvJIaTItoRm9fI6
	 zGmvkg2nlQOhDn+89sMLKuMz3vS02sm5ntrjMl6sUJiOkpKLQ0YAqqR/YxiBlCpiXp
	 YtkDv1x6d7xgSoA/Zv90+Sr9wAMC9rS0BP2SKvayiJMusLyxvTyOAUs/h/rmLUB9vH
	 FS8OazxB+YnaQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 08 Aug 2024 09:15:26 +0100
Subject: [PATCH RFT v8 5/9] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-clone3-shadow-stack-v8-5-0acf37caf14c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=broonie@kernel.org;
 h=from:subject:message-id; bh=A6PuiVWBdiPH6Nr/YX1UnFJ8RTIAC1FidWNruHY9Zks=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmtH7MofVvNn5TwW6oDgCIJDA/rG8resOEgJSiQ
 x3UDzkReHCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZrR+zAAKCRAk1otyXVSH
 0DhqB/4kV/FvNAFx8tENnuwi8D3w95LyZ5gT0ZMOM2b7QGftmaU3Irdyrvl9EhOk/rmarlkltIq
 bR6gKXqZjT7JQ0EQby3RNkAWqFU803QJFlmiwzGo7GOyoxDrRgMPJvcGAMtRcO19deAeUR5FO8W
 pf+9xNb7kCMdAvs4Wpm0ro7i5QMVtjN6dCc9K5weLAP2LSMAywZAxOaa0ldyO3Av+2WeFnGlU7U
 K8I1claSdCMXVqzjU3O3bx71634PF+q8HNzaRoh+Q+mHExxXvfWiT8Ea31EupbTKFk1Ewm8hHAW
 Ua2e94v9igAIe/61CP8qeIbEHozn6m0p0laUZIsHQNynanTH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since there were widespread issues with output not being flushed the
kselftest framework was modified to explicitly set the output streams
unbuffered in commit 58e2847ad2e6 ("selftests: line buffer test
program's stdout") so there is no need to explicitly flush in the clone3
tests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3_selftests.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index 3d2663fe50ba..39b5dcba663c 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -35,8 +35,6 @@ struct __clone_args {
 
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
 {
-	fflush(stdout);
-	fflush(stderr);
 	return syscall(__NR_clone3, args, size);
 }
 

-- 
2.39.2


