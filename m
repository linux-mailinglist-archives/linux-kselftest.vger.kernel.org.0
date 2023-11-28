Return-Path: <linux-kselftest+bounces-740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53127FC338
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 19:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F601C20A32
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373E03D0BB;
	Tue, 28 Nov 2023 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQGSXBCq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149293D0B7;
	Tue, 28 Nov 2023 18:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16881C433C9;
	Tue, 28 Nov 2023 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701196301;
	bh=FEKtInmB6mFDaJj7WRZ2UJIP9/hPzlhQkMpJUP8BQq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vQGSXBCqvGEMZ2UGNc/k3sueJ/0xAn0JGZtWRTeJMW8QfxGKGCUlbFfyVQ/kXxAL7
	 aHorcGPy4fzLwczlDEqpeBm86lGWyL/bGpyrvgpa0WT4u3/P5GJkanYDkj4cIgnZtK
	 nXE2VMVNDIjhFxafrFuG4CH8TFA9O2tCQQo4OzKQk0q/FkDP+L63IeKqsO8KI10PZH
	 Ad002X3tuMULKYoR/Q/VEGrJYaxMM1VZpwF8XhAsfpNZeMKLT9FwqMmT6XXpr3WmTD
	 9B2eqqRQCjHcY1CJoQn2+R8vawiZpc7TSH/lpvr42zF5GJHEhCyRtwJSam6oDzCH0u
	 gR4T5fZJAyTUg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 28 Nov 2023 18:22:39 +0000
Subject: [PATCH RFT v4 1/5] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-clone3-shadow-stack-v4-1-8b28ffe4f676@kernel.org>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
In-Reply-To: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
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
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 David Hildenbrand <david@redhat.com>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FEKtInmB6mFDaJj7WRZ2UJIP9/hPzlhQkMpJUP8BQq8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlZjH9q/8Nlzp/TG+PgL0EvlGN8OLT68zSuMbPXhVL
 bnUpawSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZWYx/QAKCRAk1otyXVSH0CnMB/
 9p+BnvjI0CIzEWBV4qurYBRenRV4sjx4O7HYkpsWjqGHePRDmKVr88xJ433w44HMaBhcQU8hEx+CkQ
 2D5qU8DfgX/f0wMdog1UL80/3U1pST30q10lc6apfD58b9oxt0qCMKtklP5i4PdY/AFlcPoIRmhe+V
 E4We3sX9dmV3tr26I8frU1NvYKabv8aPYLtBix25xh84y0rWrPxD2OfXUDuTzE8gyVUhnoQZ79G0Kr
 AQw2VJX0LwZXHCrj8vi0bAV6ZG+PUqbLvUlzRJnwvi8my+aiw5alLBPJg4iW4SGckAkFYzhzLY+hk5
 LHpbCzabhZnIHRLp2D43SJyprTblfr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since multiple architectures have support for shadow stacks and we need to
select support for this feature in several places in the generic code
provide a generic config option that the architectures can select.

Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/x86/Kconfig   | 1 +
 fs/proc/task_mmu.c | 2 +-
 include/linux/mm.h | 2 +-
 mm/Kconfig         | 6 ++++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41bb092..14b7703a9a2b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1952,6 +1952,7 @@ config X86_USER_SHADOW_STACK
 	depends on AS_WRUSS
 	depends on X86_64
 	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_USER_SHADOW_STACK
 	select X86_CET
 	help
 	  Shadow stack protection is a hardware feature that detects function
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ef2eb12906da..f0a904aeee8e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -699,7 +699,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 	};
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..10462f354614 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -341,7 +341,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 /*
  * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
  * support core mm.
diff --git a/mm/Kconfig b/mm/Kconfig
index 89971a894b60..6713bb3b0b48 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1270,6 +1270,12 @@ config LOCK_MM_AND_FIND_VMA
 	bool
 	depends on !STACK_GROWSUP
 
+config ARCH_HAS_USER_SHADOW_STACK
+	bool
+	help
+	  The architecture has hardware support for userspace shadow call
+          stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
+
 source "mm/damon/Kconfig"
 
 endmenu

-- 
2.30.2


