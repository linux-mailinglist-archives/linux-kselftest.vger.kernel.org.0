Return-Path: <linux-kselftest+bounces-12512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9724B9139FD
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 13:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110EAB21C26
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 11:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F18130485;
	Sun, 23 Jun 2024 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAfq89hP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405612BF1B;
	Sun, 23 Jun 2024 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719141970; cv=none; b=jsq7B0891K1fJ81VRoGyawp9Sb8kam3e576N4m9JQUOMSBoiCs6UNmwF3I0RFhpO0IFmRmbkCbZr9ZV4ZRUK1zM5Yg8YIvHqh0i2H6wKrKgZ942xvvZHMFVUsuuFjrm7NP4/NFFd9knNMiXD5lL31kIuoTmHMz1dBhE6J13eGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719141970; c=relaxed/simple;
	bh=wg70GnzKrhp9dkteytxJEie2tAvypKkmqJWIs8mga50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ap1xeQEArV71oYmaRIqWAkRTFGe4wmTcA/ELCr2evwJf29aYfBXHw+/rNz0VoPW+KxR/6zx5FLN8trHtBOA5OVp/Oa9OY6DRlmffYsg5mqlzWd5/7ahjigdKTskoIwqrvrFkpbpb6xVZ/YIP29ordnCoRxmXY0yaGBbvaOFBURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAfq89hP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A2CC4AF0D;
	Sun, 23 Jun 2024 11:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719141969;
	bh=wg70GnzKrhp9dkteytxJEie2tAvypKkmqJWIs8mga50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oAfq89hP2V7Zvzi+qkcMkzK5hhZHD4wMbMVmJvWGJmmXKDqWXsDEau63viloqDc1R
	 W2KaoxxQlKUJnfe5WdY9xy8MvU9WGRjDbAb0cVMXZwMDf7205Y1gqARDIejUZug95M
	 15QmGK8dlQReS3D8G9JJCpAs0FyfzhRfc8AHWcwR8TTVRLEU8nnhaNyo2MRQlN8Rvp
	 UEzyPcZgdP86izQ+eHeqwJPXxSjNmXcEVo8+iiOkfmd324ncO6sdCpnqCS3K7F8HZg
	 hzKjkNMkWXq85+qb7YJocbqrvkYLAHyxWq0rUfr7h+K1HAUjk56jvdc00qTfdWCMtW
	 A54dAtebRTJcg==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 23 Jun 2024 12:23:43 +0100
Subject: [PATCH RFT v6 1/9] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-clone3-shadow-stack-v6-1-9ee7783b1fb9@kernel.org>
References: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
In-Reply-To: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
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
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wg70GnzKrhp9dkteytxJEie2tAvypKkmqJWIs8mga50=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmeAY+LYldXTGeJ8hQ2+ThQ+Z7M+FrBp8cmI4lrLKE
 cLryo6WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZngGPgAKCRAk1otyXVSH0D9tB/
 4oWCxsAyuN/gQ2nuegfiWIPqYREm59mR5jOChMT0q3+9gYJLQUbelzu91ysU78+o2bTryhhf+sve/S
 p9+5pa1bZQzx6cfv4mdU7kX4FOlUpvKFyRK2A1z8SLkO3RMvc5IOO0n/MoW2Xwh+SAYjP8jHZXMs+q
 79W2l0l+DO7Ds4oFPRq0a0mKoTvCtE2a8G7k2aFPuSn0hlUwf8GpJybXwnvMrh+X/TTqFH8fNyAHho
 LjK6z1qVBrb6xcleorx/em5iXwyF110OWZ2RhBtN6wjEnCSgev8df/h/eKpjcul16jPKTSKUUH/3SO
 +GMVWV/GVyVinsBMRF5kkj3f906d5E
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
index 5926115ec0ed..d60a6dc0cbcf 100644
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


