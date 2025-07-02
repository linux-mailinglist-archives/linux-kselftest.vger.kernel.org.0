Return-Path: <linux-kselftest+bounces-36305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF36EAF12C3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37024E2121
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008E265CD4;
	Wed,  2 Jul 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+QIY1/P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E3265CB3;
	Wed,  2 Jul 2025 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453783; cv=none; b=Ti22nFFz2zbF/PpsR+CksS0CxIzRujlRhIJZKTQeS08wb1JRPBQ9WkG0RQ+XCKUTg5itFIxnAVqHM8mBlAfMel+0i+mJzLzusj7thURWWkZeI1cf9AXTh4nSRDanG41D9KLfcSgToJl4K9KgiWNqrnEbfu77qkUMCQXB+/mdn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453783; c=relaxed/simple;
	bh=/AYgqTLwHHsTkCX7TTH1Na+bth+vthYvgf8svHl0eTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eeFMEuuywFx2jtsOkDp3zAUBI62sM9m4Wcm7tXJGUcbAHod/j93ZpQ2ZlweFR2HbCJo9VrmDbKAINAgho+hl0hxZfRUjkFT/FeguhO3ObdP2F596dBEoLxj+PCrSiNh82CeN9niO3ZVJBpCkj36xxR1u9GVmf4H4qaaiMPG295Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+QIY1/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44402C4CEF1;
	Wed,  2 Jul 2025 10:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751453782;
	bh=/AYgqTLwHHsTkCX7TTH1Na+bth+vthYvgf8svHl0eTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k+QIY1/PmOuIzJf22UR/m1hMRnPRdjJJDNoDKMzFA6bEDAwmF8Fx/RCdh0eXYHyqU
	 htxnUIfX4qPk0MS7Lh31SoAhDUnPboehUeBCInqRz1Q/xuT5xnpx2REXN2OL8jb9d0
	 j9rWOKxP33lnph4eElUMpp6HwTl21nQIi3rOshDowK3K1jYktVPw5XboPLdzljfdBr
	 IiQ4FpRVBqVZjYHyiPLL9f3DbydF2fIzcICozhhj/1Du1Sw0+qpjsqOE6o6POUI4/s
	 Yh6nLts+xsfYCkECxT2peyaAqIrT/4dGsLoXqjdeFI2S6pUaSIsPuLX/7WAHy9hzOf
	 OPo0cnkVlmThg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 02 Jul 2025 11:39:10 +0100
Subject: [PATCH v18 5/8] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-clone3-shadow-stack-v18-5-7965d2b694db@kernel.org>
References: <20250702-clone3-shadow-stack-v18-0-7965d2b694db@kernel.org>
In-Reply-To: <20250702-clone3-shadow-stack-v18-0-7965d2b694db@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/AYgqTLwHHsTkCX7TTH1Na+bth+vthYvgf8svHl0eTc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoZRAupon91RsPZowtgXu9s2bFoT3LTFEhtV2bO
 clBr336xJqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaGUQLgAKCRAk1otyXVSH
 0FxDCACC2mHvVWChuFI4lRlLaM6J147V8efbNcnYi8y6OQhLvtcNt0OjuAYnPiXUmQh3A3/lF1q
 2DIffy7Hwvi8++739hvFlgtP7rBLrogYv+y37xDYtiURDKRN1bWPJUnHmgfiz487MFze63W8U7h
 MkVXvlN9U7iQHCupb80aonCZ8xh8PhWnD15CJlsMMQ5k4PGKn9mjUaS/IZlDulP2CTrYk9tN8Ph
 L/Th2avuehYySqLbPqiyHmQQo1BWm53WwosJJuUFMCWoFBTcKzNuEBB6VVR/+VXV5ysiKeBRkW2
 6t/N3WPuobpLjYx4WyQlL9MnspQ1dq4pNTY89KL6RSLjuPgt
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


