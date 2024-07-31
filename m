Return-Path: <linux-kselftest+bounces-14540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C296942E02
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 14:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1991F24CAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495A11B141B;
	Wed, 31 Jul 2024 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3kh8zFj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4601AED43;
	Wed, 31 Jul 2024 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428351; cv=none; b=NkYhiQsw1GJ50j61tNg9Z9ewAOqlEJy0uFVr5N2G7mJgiPO4BRmSPzqfQlMu0gGgUXVGf0E5rZ/Hpz5MuPLowimfxhG9GqAf2R1yI/GTLYNeqdaWtlLQnlNB2Hl/jgRvqCfldXZVGeS8tN516P641zeQJwntn5enI3B1BHGItJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428351; c=relaxed/simple;
	bh=FizA8c9Fs3+e20frZgIdFeBpWm1//QTTbE58XxIvdwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WLIJ4pitnHivJ7E0/VA/RoeebtiCczpV2TXinnRM4qTMnI2zxx5puWfYfRJ4HV4JIz8ZWmSTP55fvUg7zXS/sM7F+AnIbPTRO7x8DJdaA3QI+GyJ/9kNok+mQ3jytQCmnxCd6sSBSaNQ9F1co6kXFY1ZxN19zkvr3Xl7Ei7H4uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3kh8zFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40123C4AF09;
	Wed, 31 Jul 2024 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722428350;
	bh=FizA8c9Fs3+e20frZgIdFeBpWm1//QTTbE58XxIvdwA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F3kh8zFjwH4qQ4/La1f41ikMDz5pGToDA5UrmPEo0IVIgxCMgGPlAnogpeX+CmH/0
	 k/CcNripPqKhp+6fLiJI8qIO0Ywu4txK7Jr0ysNr8L5iI33PCWh8vA+C9aBpPsA9W0
	 Wn4447wbO4ml+EWwK4njflYovIZb2AiNXkmenKGMU6Il710zm8i7yIZ6U7oM39Ksln
	 e9WiiACd4aSp6vyhqcvkbOuz0rkX3eA3Tn6xgUSDmMX0jxj47LuSUZm2DNqT5jpCS0
	 EKIQMecYug7NJmHdjqHokXBZYsS0vHLWU9H9J7fOj+QICeE2xr4UdMxR82RS22l7Zl
	 oLQqP5II8Tnfg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 31 Jul 2024 13:14:07 +0100
Subject: [PATCH RFT v7 1/9] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-clone3-shadow-stack-v7-1-a9532eebfb1d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FizA8c9Fs3+e20frZgIdFeBpWm1//QTTbE58XxIvdwA=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhrRV2quTOH6m32588m6eYmyjYnb9xogqyQdrNhsltApNOPhk
 Qll5J6MxCwMjF4OsmCLL2mcZq9LDJbbOfzT/FcwgViaQKQxcnAIwkVMX2P97Nc/z+amQNO9XFFf+nJ
 8n7Zca3LrEkmxfp/L9kwWvk/KL2ndzoq5/nqSbtaM4vkimr6ee5/2phOVTOETdJBkeVSSmKG7otHlw
 PLn7vf7s1PV7HVnb19ZLbIqs6hBxvKDZVXLv+NLXC7YwiSapXjd39Yw1/LD+vtrlMPH1IYfFfcw1LX
 0lTJ0eRFWal/a1O7EUu5/VZ2SMchTmzZ73lTl5wlw+kWlOm00efOPg+GpbpZN9QtXNIuNOwcmMi+yH
 36fPu73H0+XTn71q7GlJrd2TJRftXp/n6esomHNF/vdKie2tSaHc3pVVxf63PI7wqTSwv36TmMOV8X
 Fr8XrtC85d6dzTuJ5yL+cu5FAAAA==
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


