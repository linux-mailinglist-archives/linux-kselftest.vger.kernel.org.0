Return-Path: <linux-kselftest+bounces-14542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFB0942E07
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 14:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7317F1F219BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1421B150E;
	Wed, 31 Jul 2024 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWOs+qlv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009861B0139;
	Wed, 31 Jul 2024 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428363; cv=none; b=U4CFinKcxIWX8gZTWlK1diN8ZHs/qMKHkUzqEkcpME/XdJw8jo/R7tgiNGRnzvVHBDZy2KusuWA1F/Hj+v1NFhBizeS29JwA0QWU1+3YjBgoAdej/5n4H70Kv5a5RtgFyueip8Sxi2pCI7v3awFvDjaSs+QcTyNVkpylAWFyYPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428363; c=relaxed/simple;
	bh=+orwRfvizHfGXDNjTwUwjThxjP5rZLiehiVTLaa/d1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLB2V0nF8JRNLA22IIMRGyiYNIvxuLSLlAK1d+y504LPvb7SLHYr3At1aFY7gtNCi4+8xIT/gfTFNIwo83/4yIp5EDNYNVRF7f6QjGcd/u1C9EApFAv/crviTWeqZ5QkVNH2Fnxl1HpvO6uckvtVJrEiU/gxOtlLEr4aKZVzRrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWOs+qlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A27C4AF13;
	Wed, 31 Jul 2024 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722428362;
	bh=+orwRfvizHfGXDNjTwUwjThxjP5rZLiehiVTLaa/d1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bWOs+qlv4epwrENJqKaeWdap3YUIqdJACjgPkfeNIjyzZRd36GEAl5uaQNKXtW43F
	 2ezXPVtPp/7MRuJ9J7KdTRvaNuLnSg398DYW9CGY4N+h5ULtndjhwV0gIzM85xwDZh
	 jueBKxZDxpao7NZgu4FPF+UqeHVg1EGAFG7nfDFYdkRTOzzFYIDYZxd0ERBBHpjDvX
	 GHbBM7Ig8gWREsFGHB/pSQNiot+y0oQwqKlAgtwft/UuiRFVzUj4hWRHEsFFG3K/74
	 ss6D4S2HIcVVrqqNJLpqsOS6Lr8RuwAY2ThY65Xaw22zHGWfq8Miq24Go3JEN00wX6
	 JCaOjir12V6UA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 31 Jul 2024 13:14:09 +0100
Subject: [PATCH RFT v7 3/9] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-clone3-shadow-stack-v7-3-a9532eebfb1d@kernel.org>
References: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
In-Reply-To: <20240731-clone3-shadow-stack-v7-0-a9532eebfb1d@kernel.org>
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
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Hildenbrand <david@redhat.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+orwRfvizHfGXDNjTwUwjThxjP5rZLiehiVTLaa/d1s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmqiutmyS6KTfVaKVigjkcIuwaZLNIiG+JN6PPqQ/s
 xUOeyxaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZqorrQAKCRAk1otyXVSH0Bm4CA
 CCun+l32pjSurBbTGV9CwVflFXomBm+PLhUX3xQqbnFO4r7Ri/kFkaynaqnhWQwUNPuZDbJKnfkvpJ
 e7ZdrZSa+pNCYjLQZ3SHMoN9q0dJ6L6yvjqaoEGXEY3x2xh+gW087xJDgfq5bczoUn9OMdbWsmofs8
 QEWE9kqlYyejLuEfpF2DR9E4ZqJtZ+PAEr8l9ZkfVh8q+ObCJyCVC86HuVVTC2SqKP0U2yNBZeUpkU
 KzyJa+8qy6lCtw7XLKkRaAnRty3ofxk0nBUb5vzYlmrBuYzzPrIL3Zg4Sofktw5SdoQogisuy4OnzT
 3Li1xi1aOx/lujfdw3JdUGzC5KwIyz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since multiple architectures have support for shadow stacks and we need to
select support for this feature in several places in the generic code
provide a generic config option that the architectures can select.

Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/x86/Kconfig   | 1 +
 fs/proc/task_mmu.c | 2 +-
 include/linux/mm.h | 2 +-
 mm/Kconfig         | 6 ++++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2a0e..320e1f411163 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1957,6 +1957,7 @@ config X86_USER_SHADOW_STACK
 	depends on AS_WRUSS
 	depends on X86_64
 	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_USER_SHADOW_STACK
 	select X86_CET
 	help
 	  Shadow stack protection is a hardware feature that detects function
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5f171ad7b436..0ea49725f524 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -984,7 +984,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 #ifdef CONFIG_64BIT
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..3357625c1db3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -342,7 +342,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 /*
  * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
  * support core mm.
diff --git a/mm/Kconfig b/mm/Kconfig
index b72e7d040f78..3167be663bca 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1263,6 +1263,12 @@ config IOMMU_MM_DATA
 config EXECMEM
 	bool
 
+config ARCH_HAS_USER_SHADOW_STACK
+	bool
+	help
+	  The architecture has hardware support for userspace shadow call
+          stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
+
 source "mm/damon/Kconfig"
 
 endmenu

-- 
2.39.2


