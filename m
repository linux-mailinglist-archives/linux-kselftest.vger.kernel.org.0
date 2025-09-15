Return-Path: <linux-kselftest+bounces-41536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98030B58837
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB081B23C02
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 23:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A986E2DA76F;
	Mon, 15 Sep 2025 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8i5Yq0K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E82D6E65;
	Mon, 15 Sep 2025 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978751; cv=none; b=lGDEbK0H1b8TRfzapKGgdBRLOehgc0n4wCrygEjzhN29konRCceSbfAbyQSYVESk3vqR7wtMU0dFTxHZK8bX4NWBqDzFMR3eoDXqVjgo6vgtFGVvl8CbAjihiQ3ucS+bTdiSn/8L+0lgCUFKoW1rkaja5138nBN1KGTdbChJcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978751; c=relaxed/simple;
	bh=dfXyEY8CiPyIcVQsZrmOCMoMeqoG7oZoagKIn7gHJe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGmJJZz5wUpwvcvSOVwSzN5Hv9lZtaoXqP6J2/BmT8IOaykp21Soxwfi4MR3qUd+4fJD+zkEb3QjAVPsDnF3gNPzlJlvbiBH9L+bi9JLM6F6HUYMNSxN0PLKgBmolV1NueRCi4hUQK5hBqpc8EGl28xBtkNolAb+toQ3WRGuvj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8i5Yq0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC05C4CEF1;
	Mon, 15 Sep 2025 23:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757978751;
	bh=dfXyEY8CiPyIcVQsZrmOCMoMeqoG7oZoagKIn7gHJe4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a8i5Yq0Kh2B15J2yysFbaotY1szb9xnfW953dR5DWqulV7MglRsgMEzo88RhO0OzZ
	 pdS+dCIerMO82Q9E75iUCew2wug8fqez6zrRegufUlsWn63OGq/nYy8syDCK287hzl
	 0PZwwlBgtYbY016kJVMHchYo0SVTE8vunYHFy2r836NXm9MYNjV+hEOLqYIi+6zC0F
	 hhZLn1hM3+XGtKnWrXpN+CAiQiI3oAdGFLLuuyBbF1vT34wvvL+F1s2hVpfb0CdVEl
	 Wbcm6v7hcccmufIqosSinAPJFNraTsIfehaiQapcD9Jt29fGbskL9kNrnQF4JxoOpn
	 5zq4rKlHVevZw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 16 Sep 2025 00:12:07 +0100
Subject: [PATCH v21 2/8] Documentation: userspace-api: Add shadow stack API
 documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-clone3-shadow-stack-v21-2-910493527013@kernel.org>
References: <20250916-clone3-shadow-stack-v21-0-910493527013@kernel.org>
In-Reply-To: <20250916-clone3-shadow-stack-v21-0-910493527013@kernel.org>
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
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=3290; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dfXyEY8CiPyIcVQsZrmOCMoMeqoG7oZoagKIn7gHJe4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoyKBnM33+4RwPJhEjEmKQu8soLqTjKxdLc8u6Z
 IzTwsnt67yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaMigZwAKCRAk1otyXVSH
 0J28B/4vQ5i9AtT/oZAnm/cbEtw6u3pN3y9agklJo6ROH5BtjtPs8lBXEamJ/1AhZcOnkeeLiOU
 tD0tjK7GIJbtLZEqxEcLSNHoVNPoPxXD6reaoumxmEcjxucE6xco8ioKkOdbZEXhbtALhSNNVCr
 skyOanSVsn0d8e9We5tyHc8rh0X9lFVT8hza/zMwT7QOqu9cwLEDK7gPDI/cXVRkN3d014jgEHT
 XhPdbMs9IzlWu8TkmeUst7HXspIjXLi3ndjKEpMrGQSL3QMya1QV4f7XiMCuHeItVgaQ9bUnIiZ
 odq0u3Q2qBU83MAoiaCMj82X+WCFQ7AW3tidCiIkYhRnVOMQ
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
2.47.2


