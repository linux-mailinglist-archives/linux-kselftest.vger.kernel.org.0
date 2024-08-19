Return-Path: <linux-kselftest+bounces-15690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ED5957459
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1AE282978
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315A11DC47E;
	Mon, 19 Aug 2024 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob5kjtRv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048EB4438B;
	Mon, 19 Aug 2024 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095574; cv=none; b=Vjun7CrYiSB23bwtgNXnjrmlaKAdxCN+yEiwbM8iI8NxDg+hlYtQHebNz+ZU2FwBptFHkK2r/PeMGAecjEAzWZ4YhANOY5goTHyq2iKAJol77uR/xSUpc1t7eK2hz6zBpz3kyF1abS6/IWIjpgQEmducACdgkd3KStHrSKwxEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095574; c=relaxed/simple;
	bh=XqaXLGAQ/MwY54koFKC2rQRtWZp0KxmYdMIZOGKT0R8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrxdLokgRk+0SjADgQ4ZzEAdwVGtVbGhbLgckdzjTgi8OHLnQm9baqS4/BWvxQQUOK9HFpeF8RFMrcbrB07j0olxNdr5yG2HibNehZqDniJxxUxsW54lqPF0N4Ee3r5Y6vFXapDapxRAtFud0WLOB8AW5xJW/UWw9LLva5/9+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob5kjtRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D5BC4AF0F;
	Mon, 19 Aug 2024 19:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724095573;
	bh=XqaXLGAQ/MwY54koFKC2rQRtWZp0KxmYdMIZOGKT0R8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ob5kjtRvMZr9p18LrWF7FYWFSgcWs7j0et9E4BUf5lYjIzKBhQDZWXKoaknEKU+4k
	 +I4ZAgY11BW0D4D7iU4ZLdV84anqTe1LmPp6SVwgnPILqRgsrOmSlkh6wtzhWx4CNj
	 f4OiHd8jPl+WBXXRr0hADi6zXVoaKcJwZkIL862p9ZVd+1jfp2QlyUng2uVG3yEayL
	 8vYJkDlHEsL+1eVOkBT8iZJ9TAA9GFyQ3P9ZhVErlVFjUsOVLnKfzElhYPls4Hxlu6
	 +cUjR37lbSmOV88FnyewuT1IjEGepxl3A2ESa0o/T+hRbWRy4ZjMbG+4/WMQ9CdrG9
	 EUSQobM/qHDHA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 19 Aug 2024 20:24:22 +0100
Subject: [PATCH RFT v9 1/8] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-clone3-shadow-stack-v9-1-962d74f99464@kernel.org>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
In-Reply-To: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
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
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3025; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XqaXLGAQ/MwY54koFKC2rQRtWZp0KxmYdMIZOGKT0R8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmw5xC0y0bUFtqGjv6GwHm2mrytwY5XdTuWUvKZVjW
 bivxP+iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsOcQgAKCRAk1otyXVSH0I41B/
 966o0WSrMUG5NtJOY/5I2Y1yYchhXGt1VpICIRl+qxiXRLo3MqBu/IdXPcwB/4gzh62RxKP9F3MT9X
 o5VXrmwpo1Clr8JfxvWfMQ6GJWJYWsJOMSAh6KNmnBxIzIl37yx4Fs6DK+ZuNgFPEpmvhtySzIbUL/
 TJpsCpgZz/4OHFa9A7PzEz2Tq814hlNUsOTmZQkQx325N2ae/vvITBLY23uJO+aahDKcQVA07rZ+eY
 ang7iLckmiq9U7DyZoqRnPenQWk2FJDd7J4C1S3FlSemckFsAGHh9NMNjfKMvoumsXGlllPRjnpLGW
 83izKsV3BUDke49LWSAWVH1z0LajVQ
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


