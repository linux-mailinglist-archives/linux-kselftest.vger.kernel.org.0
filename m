Return-Path: <linux-kselftest+bounces-15010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3286E94B8C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 10:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0B41C2317B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B257B18950F;
	Thu,  8 Aug 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLAJzT6W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EA01891D1;
	Thu,  8 Aug 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104996; cv=none; b=d3az54dAt4NbqDgCqUtnEDEXvpnPY/bBwOYE9icIWtnc54SH9fq4lj12rUlHI4zk+DzA0liXgPkWXxeANQdq8sTS5hXChpSdcqj6HtsT1L0CwgJZOoIKSZglw5RMLQ2FyD/GGRAoOFZuL35RatJG1J3qiK3lNwnEiS+qxE5xWmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104996; c=relaxed/simple;
	bh=FizA8c9Fs3+e20frZgIdFeBpWm1//QTTbE58XxIvdwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCbg2MYfCXJ6fSJ2VrNmcNgqHsZ4+nuADl9E+adIU5l8aviBGimEt3aa4Z30BQ7WXkFsVz+exIKIbgRcDJfgQWTp6HwwbS3mucWEVikUrDjnwSU1sYQNzTXuadCLVzjik7W7QOYqeauM7nyzEm5zPMoGhox+yFHxPPtymUJ3w44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLAJzT6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E89C32782;
	Thu,  8 Aug 2024 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723104996;
	bh=FizA8c9Fs3+e20frZgIdFeBpWm1//QTTbE58XxIvdwA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kLAJzT6W7m/lM2zkNzq9U5SCJxu0MbBiSVPrWg9yX6uXMHuadiF/bV75GP8UWIQpG
	 HVnSr79L9ylicm/uzK1uXL7DwTPtliVvK1aZPlRg5GaVuPQNJ9morrLNN2DcWpVm9X
	 Bee8yYHih+1NZ5WdMiVp23HqmlYaeABIi8j2RhM/fuQrt3ik6qtHyAyIhn0JejSEwv
	 FUICkup/wrgxVdCtPe6exe4jLaYjoSP4ryKjzdzqH/QEtZwx3TZyznxuIpwRuIum8x
	 SzCXPWeoeMRwiWs5Yqr7XdAitt6BFUeICIWQ16i50hIuki+06tDxVTTAT5RPTCumIR
	 F5HMTGMOxYijg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 08 Aug 2024 09:15:22 +0100
Subject: [PATCH RFT v8 1/9] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-clone3-shadow-stack-v8-1-0acf37caf14c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FizA8c9Fs3+e20frZgIdFeBpWm1//QTTbE58XxIvdwA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmtH7GV/Qmw4MPNa/Yt+q3JnWEuqZVe6AYkX8fc
 mW5VJl0FpuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZrR+xgAKCRAk1otyXVSH
 0Kl3B/4oWEGLxUtMiKyuxu1YTC7an8I7PGkVCEcQ6ChkYL20j8nIMmyBne990Yi4ChtmhQIiekw
 TlXmzS4Vb4NdiUXd2nc4q+HH/rAaLkSSPT+EcF1d0jhc4X4xr67Io3UoF0zBgZytqYi+cZcFlcN
 9nNate33T9LAqXQn/O/LauwxTW1ISe6PcToN++WRiq6AhYSahgEv/lcP6xtO1DkCB7a9i8Hp0Uu
 WnzQI6/PikZw0jR2gWUMd5lYyI3LVP0NAfhgtdryxnL3bb0mhOvdeQXNgh4BY3hfWXGg21Rk2IF
 hXn08S3bLE9AKqGpRK/OAY4BErTOSDDJKIaV2+h5/r7U1tYv
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There are a number of architectures with shadow stack features which we are
presenting to userspace with as consistent an API as we can (though there
are some architecture specifics). Especially given that there are some
important considerations for userspace code interacting directly with the
feature let's provide some documentation covering the common aspects.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/userspace-api/index.rst        |  1 +
 Documentation/userspace-api/shadow_stack.rst | 41 ++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 274cc7546efc..c39709bfba2c 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -59,6 +59,7 @@ Everything else
 
    ELF
    netlink/index
+   shadow_stack
    sysfs-platform_profile
    vduse
    futex2
diff --git a/Documentation/userspace-api/shadow_stack.rst b/Documentation/userspace-api/shadow_stack.rst
new file mode 100644
index 000000000000..c576ad3d7ec1
--- /dev/null
+++ b/Documentation/userspace-api/shadow_stack.rst
@@ -0,0 +1,41 @@
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
2.39.2


