Return-Path: <linux-kselftest+bounces-4058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4106847D73
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 01:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D7C28BF13
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 00:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F7D625;
	Sat,  3 Feb 2024 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quybCE13"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A22C9A;
	Sat,  3 Feb 2024 00:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918731; cv=none; b=tJkx8rTqV4Bv37TmnTjpZOsYKxG4tJDwX1AWDysjxWqCeE1dhDv+ZPHCs/5Qm16T5YxapPApxLBFfj0XU7c53Qn4lIZIsx7Ea7TIlPn+rNytO7MYWtTX5ZjUBhUk6WcZPocSYGIL+BYaZu1VDGuqzSPJ1R08JbBVor/ySxwG35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918731; c=relaxed/simple;
	bh=+CKBuAS1U0g6d+plSKonOkK5ibGpCzW6nF3Z/9khEN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ChsKEgAqkxbYCcPdAHmDN0Ko4klJXFzZRsdqVY4Ydx0bWrhcoVcHe15ReH92bctL5eiq7T1anJYg3yGXVUZnf4UwitP59IV4vOHkPQJ7NeRT9J4rNL56fD29Ml6p35derTYVjlJIjqHG1cGQBKGh26amgfprAObsXmpcwJ/BeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quybCE13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BD5C433F1;
	Sat,  3 Feb 2024 00:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706918730;
	bh=+CKBuAS1U0g6d+plSKonOkK5ibGpCzW6nF3Z/9khEN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=quybCE139kulUgOUUZjY60sg/CxCkpadcp7ma3i/0fJ6wBtmhbyOzaZriSCPxLHn3
	 T1GSx0+JbDJon40BkHC0YAv3EydPOs9/Dt4jb/BSb+Svny03ArFWdWL+hexE6cwgdX
	 UPGofI+FnjVB0/y9eZORoXham4OmvoqJiQ/Af6y8nsbWK/RQsN9g7LwSUUW0EgUKaG
	 sddnyDiK7vLa6Jp2JWYIzUFMOqdnXEbE1N/70xKYIyxrz+EpOHhi2tTZpni9N++rA3
	 QOldOTbqRGmv5PQpUzVXIT3hDN/VYjbr4nS0k87kPUVzVno3c/3h5OgtiCURGHYV9y
	 ebD53AvWiT1lg==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 00:04:57 +0000
Subject: [PATCH RFT v5 1/7] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-clone3-shadow-stack-v5-1-322c69598e4b@kernel.org>
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
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
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, 
 jannh@google.com, bsegall@google.com, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2879; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+CKBuAS1U0g6d+plSKonOkK5ibGpCzW6nF3Z/9khEN8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvYM4PfeqziRGhW4IOCIb95VJvN7t5rCF8sHAO12V
 PtiRT4uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb2DOAAKCRAk1otyXVSH0OcVCA
 CC6svYp+IuzT1RotcWcIvb3o558FjYjpMZ9P/76i+BXyygGOGbC+MetefOydO4RvlDTVNOefQ+HtHj
 UO+s6V3pE0jwJIbLFR/4m9XvCAWcD/+jJdapcCWp/ruR8ynxHXDPYzh2xm09rfixLaRzeAOjcIAxBD
 xL0Rto4cD/372AyJxEMKu5YEKTfzo5z5Yaiptukfw3eVkZOzft2M0hoTl1N9SussHL9XEA+1d7WEnv
 /RvOdN1DT0plk1mCJVO41YdyMIu1//ZrsfYsP6UGsqcpCDtBFdU09Gq9DoY096D9bre26gkg6PdK/Z
 +1vpAgD5vIv6jerTf6qByqgxistU3S
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
index 09f61bd2ac2e..c142183d9c98 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -27,6 +27,7 @@ place where this information is gathered.
    iommufd
    media/index
    netlink/index
+   shadow_stack
    sysfs-platform_profile
    vduse
    futex2
diff --git a/Documentation/userspace-api/shadow_stack.rst b/Documentation/userspace-api/shadow_stack.rst
new file mode 100644
index 000000000000..c6e5ab795b60
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
+application code, this document covers interfaces and considerations
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
+themsleves have shadow stacks enabled.
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
+- This that change the stack context like longjmp() or use of ucontext
+  changes on signal return will need support from libc.

-- 
2.30.2


