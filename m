Return-Path: <linux-kselftest+bounces-22769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36C79E2B37
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 19:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE7E1681D4
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 18:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5A1FE471;
	Tue,  3 Dec 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOmQ/MYd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD41FDE14;
	Tue,  3 Dec 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251448; cv=none; b=uE9lPuXh3TbneFWMy2u/K3c5OA3msbErjPfV6krj7wm7Sr7YGrxTp13zGvQ14GdtS65JDg1sJG+JmrxwyNCpUr6Wlqgh7yL8fYK4PQ4N+gLx/x/DH1721/37J6ZAW5aV06stSMkw+OtAA4MA1wyQMpZtI1VKGTTVTbHk0M65+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251448; c=relaxed/simple;
	bh=ZEnTeNnz3soYJ8jfAeIX2G+RpIQ8/WUP7NzW6qh0PyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dihwkS26uLxTUhUYgM+TGNOwaZ9Z60ZZUocZ/4Sg8PWHsncRcZnBWbEFJBzO1+3D1q6n6XxM6da9MBEeVbdYRteQ56rmuvAyvWfKnX3q/5jBZ0zx4MGWdB65m38Xi0kjuhJxvVC4o4MnH6E1n6IivoC7lYdRX/UwOrFXKPN+9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOmQ/MYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDDEC4CED6;
	Tue,  3 Dec 2024 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733251447;
	bh=ZEnTeNnz3soYJ8jfAeIX2G+RpIQ8/WUP7NzW6qh0PyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HOmQ/MYdc4rf52ZigX9MahM4ULEpJRU/8QkQgEig9ZquIHPW4nRGoTrAjd9ZrbAIB
	 W0jxodOg0l0j3s0lotvxCucvkltBKZQyTAocQrLiCFK4QvO7kb66BiSBKfsAhbYTb+
	 7wb6rRVsxe44qglKBcog26w35BeYxMtXCtcIpDU5qTvCLKBjL4L6tNL81fkfVZYk1K
	 gaIAy2QhYmcKcdjwIOqL7qiOL1w7i+MKht3G3AMwu0OwtF6apJI7NQKTyHYSx7kvN2
	 YEADmtpzfMlPviENcY0W8OHjoDDNN6EYBEcceGc4srBNvURL3KuK5+LSXovyHBHqn3
	 VuwL73Fa0MHPw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 18:43:36 +0000
Subject: [PATCH RFT v13 2/8] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-clone3-shadow-stack-v13-2-93b89a81a5ed@kernel.org>
References: <20241203-clone3-shadow-stack-v13-0-93b89a81a5ed@kernel.org>
In-Reply-To: <20241203-clone3-shadow-stack-v13-0-93b89a81a5ed@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3258; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZEnTeNnz3soYJ8jfAeIX2G+RpIQ8/WUP7NzW6qh0PyE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnT1FfY4pgm2uLre1h902tbQAs/VMJe5teTGcpUhCy
 GPiV4MWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ09RXwAKCRAk1otyXVSH0HV2B/
 44qfmh5aBH3h8IktPq0nTCPnatWS558g2Aar6WDEabay7IfM/pHRDm/45T7faWg27iKAHFhmNyLi26
 O8Xr50LHWb+T4TUNlrnexb6p4oIa9EtTUriOhZ4DLHmUM1ttrFnRi2tVOhX4rUYIwKgpASLPyYK+dB
 FLYSbXH8on25PQOIixiGDUlPUkGz/b5jAmgm+3sl4PFE+s2G7CLgrXSjnFHqQuT2EVd82H/qy5i068
 VhJMcCJ/ozXahM+ywWr1yvPYWEqSYYyiSNkIFSm/zdeie3meXTu6MVJDVRXY4pHRoKv8VeHg66L6UU
 fJkv6axxMZJQuUSUK7/Ik/v1D2Snlh
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/userspace-api/index.rst        |  1 +
 Documentation/userspace-api/shadow_stack.rst | 42 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

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
index 0000000000000000000000000000000000000000..9d0d4e79cfa7c47d3208dd53071a3d0b86c18575
--- /dev/null
+++ b/Documentation/userspace-api/shadow_stack.rst
@@ -0,0 +1,42 @@
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


