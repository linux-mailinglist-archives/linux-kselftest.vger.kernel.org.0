Return-Path: <linux-kselftest+bounces-19093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ED599160A
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572F3283C80
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB169149013;
	Sat,  5 Oct 2024 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxVRdiJH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40913A250;
	Sat,  5 Oct 2024 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124372; cv=none; b=UZ82oGOGrSIu352RhBB8eSK6FaDUrD4FGbo3MxgT5AQ4HADuWZRrqdphrntiXx76yU3ULQc6i2P5wMRkjKu06mEr4rvPDhDhnwY9gFoJIc7HNoziBlgJyIiugLqj7mt4yV2868yFf3C7qdDSil8N/WHnxg3J12d+jHITvHgZHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124372; c=relaxed/simple;
	bh=tec4v7YIW6lSCaG+Grv8LNbscxtN/Lm0HS7zRkM5EGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uHMYvsG0Y0p3lsalP67YPQlycFSEBoUa2+3jsjQzaQ7s72TM6bNZWGSIPsDy5J8X45M54u4m8Qv8PMTmIEufZ93QdHFJ5p6ev3LGB2+1IFa531VcAUTDR1i6pDRLgLbMqXqZVWvx7Wad0UywuDIIToo4Ns5Y/xUU4fAbCj5UqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxVRdiJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A34C4CECF;
	Sat,  5 Oct 2024 10:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728124372;
	bh=tec4v7YIW6lSCaG+Grv8LNbscxtN/Lm0HS7zRkM5EGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AxVRdiJHniLUMm9xJo6RstC2rz4Q7adj3zUc4DaLQuJJwft0JcshjJVatI5Wu756e
	 9uSdA+XwGZwdYnYHN+KxN0Q0iSdI8WfS1fRKPPuyxz3+kO4O2zR5TOTBha14/itWaa
	 gskoLSZz01XK4DA5iN6cwdpwVv8XvtpJ/iZs+hEyzCdEk9eCjNeeWAMCny8I+3ZgGt
	 st8az0NKEd+TpxcdCP6omqozrzk9QKyVTw2ga+zEIwi0X/j5WX4M8OXieDF5A6BsW1
	 vCIdXSZ7ba2G+r5Q6zZ46zYGk+94kVAA0RmbOSibw666z6eyakzWx1pVI+lxeT2D1D
	 6D8AlCbPHs/HA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 05 Oct 2024 11:31:29 +0100
Subject: [PATCH RFT v11 2/8] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-clone3-shadow-stack-v11-2-2a6a2bd6d651@kernel.org>
References: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
In-Reply-To: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
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
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=3137; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tec4v7YIW6lSCaG+Grv8LNbscxtN/Lm0HS7zRkM5EGk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnARW8SkYUT0D/Hh1aLXz4STfUnladQ+MlUroGKZIR
 78H1KVOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwEVvAAKCRAk1otyXVSH0IfAB/
 9dmXLrxIwAFg60Ni/ida60svBBatUI0FLf34hoHpyMsqfiA2XNe2kLSAMJ5AR16AtHKT5m8zceCdOr
 WC0de3ohrka+wdCUPKPpL3SSsVeBeipUDAJIWnGO7wwF7UJxlUkZVsb4u0v0QLkYT+92XuMv9SXYFc
 CV3NWrqEpCZzddjqvGOOqNTlwtx6TjAUXs/q+W7DcJrobFKU0QBqnqsWpkXsHNUgrzAoHbqRHiEHBr
 nwRZTXlWldf0Cc8SmV3cDfjKnikzK7TbeQbyrdZu8Ty8qvt9QNs/tG9CV41zbetenWY5eqv30bWqN2
 uqbvyZ2heC7V3q5GUYjN/LnObt7zJv
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/userspace-api/index.rst        |  1 +
 Documentation/userspace-api/shadow_stack.rst | 41 ++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 274cc7546efc2a042d2dc00aa67c71c52372179a..c39709bfba2c5682d0d1a22444db17c17bcf01ce 100644
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
index 0000000000000000000000000000000000000000..c576ad3d7ec12f0f75bffa4e2bafd0c9d7230c9f
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


