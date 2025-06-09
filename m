Return-Path: <linux-kselftest+bounces-34468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2ADAD1E52
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D34188D5E4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 13:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E36257455;
	Mon,  9 Jun 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYhJEA+1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6676FC148;
	Mon,  9 Jun 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474088; cv=none; b=Eaz/4ojvTFf7DqtkYzauCLHCSUF/w9PTEKPdMq22mTPNC2/+94WsQWbeBSRUJfWuWE1Vg/VU9tYNa0LVuG89ApSPWDgZFd+eJXS/5MwcMuTsZTZ6b8Gr2zaLyg1m1hfmbdajchYv09NiJpjcZ9co6Jo4IemsexQU2vbyMpP62+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474088; c=relaxed/simple;
	bh=k56u8xsssiS9PLGw09HLQ5Vh+FXmTGCSWgKOA+mivOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQMomVKUg7eJyLH6uyMyBiX5NuraNTCgJYp4JiMJjvbte8IJEAvQ5yaJhrXOt8B9e5+ijXhxSobljyZGRqxpVMv4RjlWld2XvoO7nQcjbqNtPDqOQdqI/Ee7r3XlyUZ/MURdmiJqUvSA1cV95xkVpg63GHHl4it4+j6WJ+3XxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYhJEA+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30C0C4CEF2;
	Mon,  9 Jun 2025 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749474088;
	bh=k56u8xsssiS9PLGw09HLQ5Vh+FXmTGCSWgKOA+mivOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PYhJEA+1s/ObOKv7Ypa178hGxSaXiM2l63B65J/CXX9tuoPFJIQXbJFLkAs5plMkE
	 DuvFSDL3blwGLdSC4Qx0PJlcw1bb4vRK5a8qCnp6V7Nw2yCGhqPxctaSZChj3mJkbR
	 /IZfwDhgen8PUL3L/E2Ak8PeeVFBQZtSGXwqvq35wPCL+wV7B4rMtD/+FWfLb22KQE
	 9cJNG55mR6ZAKdZgDaOWybcgTmAYpYHXnkfr9tMme30U2dgst1Z07RvzhKC3FE3/bK
	 rTXHTCRo7hTDTAYFAlMofydBIJIw9EzoBJSVIOWfK0LuBt1Q9QmeAEUQSPpLYasP91
	 PXOYC32jhpbNg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 09 Jun 2025 13:54:03 +0100
Subject: [PATCH RFT v17 2/8] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-clone3-shadow-stack-v17-2-8840ed97ff6f@kernel.org>
References: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
In-Reply-To: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3235; i=broonie@kernel.org;
 h=from:subject:message-id; bh=k56u8xsssiS9PLGw09HLQ5Vh+FXmTGCSWgKOA+mivOY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoRtsQfr2AytDN9MacLyk+5i2dupvqdH95aEFhkibk
 2etkeA6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEbbEAAKCRAk1otyXVSH0KrcB/
 9QRS4zFupAvTyaJJjklrc43Q7fP/q8qTOx7wPDo9Zkl4gzCFb8+JkEeBXf7sJaEpz5es/7bCH7jm6V
 MSK5tyi3yZUCQw97XPBiuagM6KJyZtnksHWgN+iYGsCeDZnzOvIYHyprkB04yY8HIcP3wGbUfEMVf3
 onxoFLpvyBvqR/yu7cF3mVqdGjD9q0zp3hbeleiBzz4Clm37jr7ZbbsgZDW0UKG+/gnH7Z0ndXGWxV
 /5x4M+rZbcw4ghBXxhuCFbJnEj13q1kfBdQYJFr9GPpcArpOwQz1OzrdxwXwHTXHuxVJ/IdGMSFaEK
 38pcAPzPqLie4AC20QKdW3oXGBB6Hz
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


