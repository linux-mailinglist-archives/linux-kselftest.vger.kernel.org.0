Return-Path: <linux-kselftest+bounces-40549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B6B3FC34
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1394E1D9B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0782F4A0A;
	Tue,  2 Sep 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVuWTeEh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCA2836A3;
	Tue,  2 Sep 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808555; cv=none; b=tdC5OinueBvIGXVz9FbchB2PHolNFHB85dqXLGRWo7JIkqMLPdvRFGfnuy85Nm46CZBDQiNdF51Z/2w5RABUthHK71cAr+HUt21SIGZdEBHh7al7womMXEoPK0ks3NvXIe4PYbpykqvD5sgGwwKUtmRbHQiireSkCWVWKx+pJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808555; c=relaxed/simple;
	bh=ezL+4DeZdmcwM1aOt0IjT9Heuymi4ERrDFr1xBHVoaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uiWYr0Ib7ZxyuuJM7YHeGDVZhJ9w00400xMr7g7CBS7EVB413Me736/uim6tEZa4qT+3ZMOiwiZehgAwj6jn7UmbPHVurFRZZ5iMKgTKnqJBktXHohugfb3hF/JCV2BFpWZAfuDcOweGhhyN6tB74i9LZwXv0tI8lDCFyMsbBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVuWTeEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8655AC4CEED;
	Tue,  2 Sep 2025 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808555;
	bh=ezL+4DeZdmcwM1aOt0IjT9Heuymi4ERrDFr1xBHVoaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jVuWTeEheko+2ailkmfcNMumzyUjZfUqujJxFDwB2W7+wGnuea3X4Th+s7ExK4E5t
	 J0XZMRF7gvXZFRBsBnNouaZIhR1UM70HikMpEBckz8sVNrzequewLUiPzWV61PfwLM
	 RNOTugcMYWPOqZIB/c+Kq7i+28zf9KQsd4q9MYSENeehowbyQwvpVTjtzqJYSZR/Lr
	 o7BsYcwUW8lewELDJUhnX+WXFSrRuviwLVQhUyz+dRpcUjek4H2i9ULMwqFNmUatU9
	 YEn012M5AkztAHvIeY87IeYzoGOd+8xbjJC5nnY901YmUh3VZiaaAdTvV46cLg88vm
	 /nbLGAXS2Ab6Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 11:21:46 +0100
Subject: [PATCH v20 2/8] Documentation: userspace-api: Add shadow stack API
 documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-clone3-shadow-stack-v20-2-4d9fff1c53e7@kernel.org>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
In-Reply-To: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3290; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ezL+4DeZdmcwM1aOt0IjT9Heuymi4ERrDFr1xBHVoaw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBotsVUHWgG1vwknbFT86yhj+SPeFJI9f0+BAWbt
 ZD2fRGsGfeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbFVAAKCRAk1otyXVSH
 0ERAB/9/57aYZcpXltdrAkJBQ4IPy11apdLVyGggNwrw1ZE9zwyIQSBTqG7XQ7WsLwNe1KbKZkQ
 ZI3QG5OnA/M/e0kN3gTnjtlmO6xsWw2d8t5JQIQjCmAka3RKBNDn+WqCEPJWNh8AIwE7vW34R+q
 IsqBuCPes0CkoYCaoWdDoQdNi+KF/J7oduQJZhTylUG59CiXnXUVsK1W5fZpsCmkJ9Np6Z6vzEa
 1H8Ml3lfZ+yjBvOhw3l8yqELobMUenIYjBxIoyQGuxI3japf/x4zNX+/WwgeaZChn1Y2KE6hkbv
 cOz+vwLVLdl4cuv5AH1ZhVWMbCwLB7AOUTMaVFi2lJlyk0R0
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
index 000000000000..42617d0470ba
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
+writable by userspace through very limited operations.  This feature
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


