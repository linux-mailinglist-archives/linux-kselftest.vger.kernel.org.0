Return-Path: <linux-kselftest+bounces-39318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2DCB2C9A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 18:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611547BB7C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D8027B335;
	Tue, 19 Aug 2025 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS++6vJd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29127AC32;
	Tue, 19 Aug 2025 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620864; cv=none; b=QSW+8lksp4YLEVoXdJzp2rhsPjWrBDbAC0UiI/IbKAFi3eI3n9L08EWwiySX8YuW7PIWDDQmd0Fg51L8G3B1K0u5MEgBTh0scFl5ddlumHB/fs0jPsfok55iNNUoVG+1apiRNbokPIAiJJS/0Y3GfnD8xXSZ0aSZkrd4I5vlskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620864; c=relaxed/simple;
	bh=E5jTrDbxtCpIeDLiMUwge4Mqphic3I5ve2LQ4cJCm7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OG8to3NZ4MaS8WlJNgzvfI/HsD/RYWfDiSiLZfuVyM4vJRug5SDT4iayknufC8MghvVdhLoJ61xIEzMFFrwbkSFc7G6c3NMjBGSNpSVbCSBd6wYdp3LhB8OXBJCJs6xlUUpAEYhnjLbAavVl3hWRzkjxWp3bGcfpXP/XnagIVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS++6vJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF34CC4CEF1;
	Tue, 19 Aug 2025 16:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755620864;
	bh=E5jTrDbxtCpIeDLiMUwge4Mqphic3I5ve2LQ4cJCm7o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KS++6vJdhA02yEzbb0qk9D8K14YkIzxiwIyt0M1N6hXDs8Bc16T6lWkN8I5u5o82z
	 4+vMSpmueGiiebZsh5OpE45M57b/nKqdO6kOKjJPwKrskzDOO2gudXLyx7B030bgwn
	 4ddcT9xyNvjhDELohwns6pFQwhV/E2rC8DxGkiw6TTc5Tg9qweSyHKyXLqp0ZXcgop
	 Zsei1Ca0AKyskEOyMJBRWm18ULVxQQlkiKjyhteRhpY+LJ4Dpvxvla3LLpBEEYKak9
	 CjSM36xXbKDo5P5/hkY7nPYUGshrfLenTNyRxajXpG/Ky7Zsr7pFVJoMhhCcKbOPGR
	 1iiSW+HT5gbog==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 19 Aug 2025 17:21:51 +0100
Subject: [PATCH v19 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-clone3-shadow-stack-v19-5-bc957075479b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=E5jTrDbxtCpIeDLiMUwge4Mqphic3I5ve2LQ4cJCm7o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBopKXSx20XuLhIePiF8ibu/ryFRcdQSedJ/vEaJ
 1c7WVKs80+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKSl0gAKCRAk1otyXVSH
 0PRTB/9tD6cOeMNKk5lyZVv7/lLxOBFVoeYnGGizqdEV+J58ggFgrYlRBOE5EaBiNCLh/nTbUaP
 HCxLGVAn/02v69fcbQXiwkhJllHc3stS4q5cLePgtwnSJFv01HKWNSr4Bv0euH2hr0/uSK8/wKC
 q31xj02i+fwJ9zF2hHyHUBwcJAduuW42xj0cu1bMi/cqjMnLIkfavdJSHGbIRdPuoTD/fl1Yb0s
 CcjPKFydm+iQT1iEXm6zk8sMLBxlcx3YB4mNm4fY5bSdIITy1F5l1/V8oOlHW/ecPh0Nyd83xu2
 vV/GXxSVAp7AXb2hUrkisQDgDWMRYxWnBs92hJ4ykmKkK7tG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since there were widespread issues with output not being flushed the
kselftest framework was modified to explicitly set the output streams
unbuffered in commit 58e2847ad2e6 ("selftests: line buffer test
program's stdout") so there is no need to explicitly flush in the clone3
tests.

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3_selftests.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index eeca8005723f..939b26c86d42 100644
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
2.39.5


