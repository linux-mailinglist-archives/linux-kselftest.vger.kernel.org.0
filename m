Return-Path: <linux-kselftest+bounces-36302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBE7AF12B8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D080B4E17E3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A8325D219;
	Wed,  2 Jul 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFf/OrrR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CFC2620D5;
	Wed,  2 Jul 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453764; cv=none; b=qH61B8u1gx3z4DdGPblqzWSyFxSKho9M+1IPlAUMeqi1768q1GlxdYZplhpbrMTzFKmBvMT13Ae6e1tDNv9ITk1HCq4oWP3EBQV/zzSCrj7TukzhZjgOXK8uJEXi5F2x/whpzpKzyf7qPxFcYSzhSZ8SGy6LqlL584nVpbg8428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453764; c=relaxed/simple;
	bh=k56u8xsssiS9PLGw09HLQ5Vh+FXmTGCSWgKOA+mivOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PWjwO/uFaPaMOLvBfO+s/UIXAS3rBTtHTw5Xpm3kbirhtDIFU5jGMGbGgTgv7auYJfQpkD169811yFynSsapNvjjS6IxLZ2TpUc6rfkISGdTGRaNQUvJZAh/MKm11QdBt29Rzn9Rz/orHbKJ3ItcBTwruvkMv7YgasaaS+0aPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFf/OrrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34E2C4CEF2;
	Wed,  2 Jul 2025 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751453763;
	bh=k56u8xsssiS9PLGw09HLQ5Vh+FXmTGCSWgKOA+mivOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sFf/OrrRWEiWuGChX/mHs69k2aXYKWfCAcDzbLuhIrIzATjX3/bL7tLUVnTT1UcUH
	 dCST+p0w86z42k/6YHwSeP+91QdtMHF9+5/J4XmRpzELWONIIHphEdZtMJUxM9k7wN
	 FObOpuhscYdiNkaXK6ZQW4t5v+443LMU+15FEZK7RghnlIIOrHaXHFrQXjdo4Ir57s
	 w+976bULnl7VE56OTtNYqE5qZpztpaWAkzby1LDpMhtZ3wGZnqMGG5Q1n38sovd+ad
	 pQ4SwJRgoMwFjrGeP3fhWnR/TtYhcQvo6gJVAILKITyjWqJ8YB/ZSFUMJNDHQznKIw
	 byhv8n5Gv1khA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 02 Jul 2025 11:39:07 +0100
Subject: [PATCH v18 2/8] Documentation: userspace-api: Add shadow stack API
 documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-clone3-shadow-stack-v18-2-7965d2b694db@kernel.org>
References: <20250702-clone3-shadow-stack-v18-0-7965d2b694db@kernel.org>
In-Reply-To: <20250702-clone3-shadow-stack-v18-0-7965d2b694db@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3235; i=broonie@kernel.org;
 h=from:subject:message-id; bh=k56u8xsssiS9PLGw09HLQ5Vh+FXmTGCSWgKOA+mivOY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoZRAr3JzTRxdKSy0JwJpM4izsXEVT9eN5yN8Ao
 iXCK30vIz6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaGUQKwAKCRAk1otyXVSH
 0B85B/9Y8opr8gsQfnzJE5Y/ZwQldIgnizyHf3YaBuU4JXPZpB+w0Z2rOu5kUTpKQL2MHpz5VIg
 klHGyQuyq5feCdua+9/T6cYN09rQ8AG/OhySjXfptuwz8nDKnfAgWIW0Ym961pcs+pR9I0mK/gT
 P5Aw6n5mi17odhX6PtDR+RGfa9L20ejGMPEZDbjDKs2n9uqZDvpFg/kS/e1Zm7AaZg2gTYeap3L
 VCNMMiR0tptBk1Mbf0pkD5pJQlR9rV2QwbEZcd5e7rmjEmK1i+EZiDrhsbi+D4LpxXCuQTM32OO
 1YJ5Wdk441AdmOyerG/+SKs1NAN282e+5koqpidv6T1bKA8g
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


