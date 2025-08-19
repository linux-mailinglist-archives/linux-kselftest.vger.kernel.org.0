Return-Path: <linux-kselftest+bounces-39315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33942B2C9AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 18:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E59188B609
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 16:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEFE25785E;
	Tue, 19 Aug 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyPLfa5T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F2256C91;
	Tue, 19 Aug 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620842; cv=none; b=fVAjHwgRM2obsRbIUdte/PwUlVqYHNI3GtAY08tssftSi9MGAEXKzkm+mz8PT7ndHX0qPAMivfFU9bww9gZaxt4XltzVh/ZZ64195vh+J9kglTtdJblYNy108f6Sd5+2jAMiBalj+RD13b2g6PBtlaE9K/wYZM5er5i2xodqimQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620842; c=relaxed/simple;
	bh=hVaIM8V8kRd9AQDq914Wwe26mHFpW+Fx9glpdzPR7+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hNrcngXjLVNOTDgz1qaPWaG/JAyrT2bGQO2ViCmYr+i1uMiitr7nL1907iPzhsVYn7GcOV+qzaGQVX12ySjplsaH7CS2ZHpSZ2E/3x29uW2yi7yvlitYCUAl4BkhvANxl0us+4G9s7wvSaY7xR8uIwfEx2+dOnRwhwGFkg/L4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyPLfa5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DE8C4CEF1;
	Tue, 19 Aug 2025 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755620842;
	bh=hVaIM8V8kRd9AQDq914Wwe26mHFpW+Fx9glpdzPR7+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DyPLfa5TK2OpgwmCPBJImANFYCq6autqHJOl9oj5Jxw6GQFMyCV3UQgZju5aY74kj
	 UFf19PLU9ejKGdziB/1W66uYaCxAIMqGk+LWv5PwoHOMAOPHT528Y5D29rY3r8Tm0g
	 bxRm1u7v59lueFmlP85aut4623DemO85Ua1Ve15RSGhiIyHN7nOCp+fLzCJT00pQ3Q
	 hK9UcXPEgxEDvCs/W0/SNqlLKrwwKVfLH5WPosxHpKYh9yCGrOAjUbi3Zr2cdt9LU/
	 fakGNIWhf9n73AK+H4dLnymI68NgoLpUCEI6YVcJB2z7krir59P55AdXvZ+s7SbRrV
	 Pw/psMcw9ZYPQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 19 Aug 2025 17:21:48 +0100
Subject: [PATCH v19 2/8] Documentation: userspace-api: Add shadow stack API
 documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-clone3-shadow-stack-v19-2-bc957075479b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3291; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hVaIM8V8kRd9AQDq914Wwe26mHFpW+Fx9glpdzPR7+8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBopKXQTdY3ugJkYbJS5pLU75D0MW2jy457UDv26
 3WzN4ar6iiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKSl0AAKCRAk1otyXVSH
 0NRaB/wJySdY1ayPL1KkBWJiBZ2rO3++CePDThRvIUqVv8MSOS5JV6ExNNLfaCcL+n4mdOIRwBP
 k+Vp23qjXejxL1E49NBonyonPKK5kc0/PpZBHW3q+BPEVqBXxYsK7yz4itNzxdkCdQNFQvNLHrF
 W1cOZaoHItMs9p5NPZmQ4bXiFwPoe72IIAEl29WnhU10pFNZlUqcTqBQyWFiPVrt/hxCbnJcKV2
 eaUmQkuxUdXTLop38o/lP6W2OI/x9VR/tpDCgbCh2JCwBJV45Hgw7SZKv5cQhn12g2Z2iLasK+O
 inCZguORVZZHRYpPPwpQDMiae+5Slcnuf25s2zmPwnPLeoPC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There are a number of architectures with shadow stack features which we are
presenting to userspace with as consistent an API as we can (though there
are some architecture specifics). Especially given that there are some
important considerations for userspace code interacting directly with the
feature let's provide some documentation covering the common aspects.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/userspace-api/index.rst        |  1 +
 Documentation/userspace-api/shadow_stack.rst | 44 ++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b8c73be4fb11..0167e59b541e 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -62,6 +62,7 @@ Everything else
 
    ELF
    netlink/index
+   shadow_stack
    sysfs-platform_profile
    vduse
    futex2
diff --git a/Documentation/userspace-api/shadow_stack.rst b/Documentation/userspace-api/shadow_stack.rst
new file mode 100644
index 000000000000..65c665496624
--- /dev/null
+++ b/Documentation/userspace-api/shadow_stack.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Shadow Stacks
+=============
+
+Introduction
+============
+
+Several architectures have features which provide backward edge
+control flow protection through a hardware maintained stack, only
+writeable by userspace through very limited operations.  This feature
+is referred to as shadow stacks on Linux, on x86 it is part of Intel
+Control Enforcement Technology (CET), on arm64 it is Guarded Control
+Stacks feature (FEAT_GCS) and for RISC-V it is the Zicfiss extension.
+It is expected that this feature will normally be managed by the
+system dynamic linker and libc in ways broadly transparent to
+application code, this document covers interfaces and considerations.
+
+
+Enabling
+========
+
+Shadow stacks default to disabled when a userspace process is
+executed, they can be enabled for the current thread with a syscall:
+
+ - For x86 the ARCH_SHSTK_ENABLE arch_prctl()
+ - For other architectures the PR_SET_SHADOW_STACK_ENABLE prctl()
+
+It is expected that this will normally be done by the dynamic linker.
+Any new threads created by a thread with shadow stacks enabled will
+themselves have shadow stacks enabled.
+
+
+Enablement considerations
+=========================
+
+- Returning from the function that enables shadow stacks without first
+  disabling them will cause a shadow stack exception.  This includes
+  any syscall wrapper or other library functions, the syscall will need
+  to be inlined.
+- A lock feature allows userspace to prevent disabling of shadow stacks.
+- Those that change the stack context like longjmp() or use of ucontext
+  changes on signal return will need support from libc.

-- 
2.39.5


