Return-Path: <linux-kselftest+bounces-14544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C1942E0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 14:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1752D284E30
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7701B3720;
	Wed, 31 Jul 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW2HY8+I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15F61B29DA;
	Wed, 31 Jul 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428374; cv=none; b=UurbHIWTXblweaekVM2WxMGrodYr7uIHR3a9bkmpysN8k6yRAGa/UxMrHCxthaNa6NkzUCiDTpSRuTH6rQ2icQIf04JUVbLsfha1KsyhMJIQxteEmWAlNmAgdlMVvr2P45LFlokRgeUV4cYB8MVyBh8zah8BGQZZ2c+b5I9dk8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428374; c=relaxed/simple;
	bh=A6PuiVWBdiPH6Nr/YX1UnFJ8RTIAC1FidWNruHY9Zks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bllXNNuKyvr/CPxrWt8hntubRonWPLTwEqdMJ29MJdqzTZIyC3Rjd0iNvtD2/ac78Dejw2EMq9WW6RsljlVbD4Xq2GP9Jbm8XGKmyRfTKxwN0mq3dU74E2JUIz7twh2S88MmYzjDAUyxI/zs3jG2FrqFAoy6IPK09BZRvYAeT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW2HY8+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D755AC4AF0E;
	Wed, 31 Jul 2024 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722428374;
	bh=A6PuiVWBdiPH6Nr/YX1UnFJ8RTIAC1FidWNruHY9Zks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aW2HY8+I0zEnqLmV92KvQNoP+0nx87JB6F3ibWQRE7q0OBFlqhlzKxLHDhUUO8OEb
	 fATyiOXXHOvkhdlzqfDXGdOVUdjYjvmdjx319idtAh5/fEubWbAATi1/hir9GXVQvR
	 MWQJp7Iaexc/pbDxaaE1WgIg+6Ifv9q7MqCzYy5RfwiYFfaUPMK3nRtW8HbOhPuyw6
	 uHXK6S+LzhkgiiUTnri6eWCa/XScl24lpcxQ/vEdnlR99fBVfMYMS+tkgHvuLBzuji
	 Ka9duASceCDOUCQqM5J9CqlO+gwELEdIzENf14InNeFxR0rE9YlnzMFW+J3TOPurTn
	 cou51WG8/wtcQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 31 Jul 2024 13:14:11 +0100
Subject: [PATCH RFT v7 5/9] selftests/clone3: Remove redundant flushes of
 output streams
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-clone3-shadow-stack-v7-5-a9532eebfb1d@kernel.org>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
In-Reply-To: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
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
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=broonie@kernel.org;
 h=from:subject:message-id; bh=A6PuiVWBdiPH6Nr/YX1UnFJ8RTIAC1FidWNruHY9Zks=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmqiuv9nAXNTzad6mi6/LJyQNW3JnA0igS4K4G/Mxf
 bbfpB0aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZqorrwAKCRAk1otyXVSH0GuCB/
 9j9XiiEOtEOi1/O4et0H9uIvHoYKcdjA6c8FWg4z3Z5keZPVszhDrao7xk2OdU4HLA3qsx2GQ0We/J
 nzqkAP8kpaD7vkiyM/CQ1tMOXYy1uFh6/oa8raLaKBz+g0ZpjeIVvHyu8g7yCDTi0PzEBhDvGQMzY8
 FFQbAsCPBfuRbxuN3bW+hDsv6AOT8+n0SmptxAOupN9j7i17vytPbToPD+r5lIhSN8r6lXyxNbrkMP
 AZwIX0iVfhyIAyalVH0PN0vQcUCez31iwV7K3D5PhDG+ZlZXN6YPFCg2vbbjfOFaJDPMFZ03O93Cmn
 fswDLwnpkonYgiDlWCkey3U7kujBhb
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


