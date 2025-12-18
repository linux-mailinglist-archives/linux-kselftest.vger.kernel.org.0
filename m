Return-Path: <linux-kselftest+bounces-47689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC30CCAEF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 09:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A0DD3027FC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80990330B09;
	Thu, 18 Dec 2025 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHQzHhm4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272A2F25FD;
	Thu, 18 Dec 2025 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045588; cv=none; b=kh5yvZLnwiYrutb5Xq3PzcIA9sieS9Qo1CPpij+PbylERLphh4NvpSaceRwNRgf7yfZ1pklGb/DCw7AKg7+Nq+73VRfCW/E8W6PaiaRwEhpTEiogNqxGVxp7Wl1ugW2bb7Js7I+xE9ChaI7iHHvQU3t9V4SiuUxoprXOUzJZw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045588; c=relaxed/simple;
	bh=YllyAUQhoh+CFHaQ0RGYDGwfzXhe4WlNB73hILnrir0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHGvlj1+GFkUcWaABVQRXhrlnHijShYMw7FKUzZj71HX2WeTgJPBtbtbYjmGc2C2Eg8O7SPNdGvYiCw6hfwz6V70pBHWMMzJupVhsk9h9OSCyX3LOgV/IjLwuovMv7BKH5fR1YZa/C8JGWhFnGDMAlpzbTAaIvINnvxFOMmE+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHQzHhm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968AFC4CEFB;
	Thu, 18 Dec 2025 08:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766045587;
	bh=YllyAUQhoh+CFHaQ0RGYDGwfzXhe4WlNB73hILnrir0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WHQzHhm4DBTavlRmWFQWKiZDi+4x630wN4LmXaF0Lu41Akrko/SBDMidfk5ykOBYC
	 0wBfMGD8O8yJX2PnapoS8bxe2zhr/F444GZ+9SPIrBlykkg5DnorG718OcJjwnjRVj
	 e5v5He9weMvgrB+9fyj0l+l34NmcFT7Nqw04n4JgNp13sXU0HcpePHI6Cs4uVRxTkf
	 XbUtdKmskwERnaHtOPm1cxPEkqchAK0awIEgcYb5hFyg8oUWfO30i1UW4e73nfSwbw
	 Mr1xB1ppGNyR5hhdlom6lr5B5YQKRUcKwFnZr4sdpM/u9bnJkp439PkDD5w8r3taJZ
	 V9CBI7VJljPPQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 18 Dec 2025 08:10:07 +0000
Subject: [PATCH v23 2/8] Documentation: userspace-api: Add shadow stack API
 documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-clone3-shadow-stack-v23-2-7cb318fbb385@kernel.org>
References: <20251218-clone3-shadow-stack-v23-0-7cb318fbb385@kernel.org>
In-Reply-To: <20251218-clone3-shadow-stack-v23-0-7cb318fbb385@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 CarlosO'Donell <codonell@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Rich Felker <dalias@libc.org>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3303; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YllyAUQhoh+CFHaQ0RGYDGwfzXhe4WlNB73hILnrir0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpQ7d709A1tQDvPHAcxOWwzShzZwNk9FFDtIrZu
 NufA1tJlHuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUO3ewAKCRAk1otyXVSH
 0G8UB/9O4gZ95A0cMps/ntHozyVXD672yyohi8Ta43JFciX4dj21kOlVbwyVQFHG1VOsVmWNEip
 bLWddkSPjXoW48zyaYC3na9v+wWqtkY9IlunM4dRp4TZ7uxsJVUSNmXX6XzCLwwXJZqDQ5zBw7k
 FFuD6J0q2JrKpgfmDv7qe4oC2ial3RlZmFOFGy2YD4pTilhz953XbseUPe0PKRWEUMIEQVBUWJU
 BqfpMOmBk/0cBFq4dqpsnatzrsSpf+FDp42R/CXkoUIDoaDxnd+Pj0b4AZIjQM9fVWcPX+SePJL
 2mPpTOt3q/U+gc/r6VexMe2lXuzYUcVlJCucymCpXzZXNp8O
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
index 8a61ac4c1bf1..64b0099ee161 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -63,6 +63,7 @@ Everything else
    ELF
    liveupdate
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
2.47.3


