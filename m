Return-Path: <linux-kselftest+bounces-15012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD4E94B8C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 10:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFBC280D04
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC61188CA4;
	Thu,  8 Aug 2024 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlUbUBzq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1C1422DC;
	Thu,  8 Aug 2024 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105016; cv=none; b=rytcPJRJlIVcsB2ty4wO7bl4EaFFU9J72m5YUdcRDdQde8Jhzhb7RCmTUbSB0FFrPnaUZ0XP7uLmL2gtNas+gPWt9f5p4twBmaWK76jlDR05BMGR/HBa19eQgBgHSYTNooLryfJVoUmPCy3Up2dx4iTiXvak8qWz82eQdg+W6Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105016; c=relaxed/simple;
	bh=+orwRfvizHfGXDNjTwUwjThxjP5rZLiehiVTLaa/d1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EBgJ7LwM2N0AiWlbPF3umXtiYs7JzqnKSJAbTSSlm0QaoyVncBgPf3ZaoIHbaJgUeRub6QBnxLZ1FwBgqjEEx+tzGcMFdNTFvRbTsfOJlKj5fjK2z/eGvi3gQCOsbu74PMSi9C3jvuEaZRr4Jakq/yb2GPl8HD6ZDYLKwf8EU5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlUbUBzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0D0C32786;
	Thu,  8 Aug 2024 08:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723105016;
	bh=+orwRfvizHfGXDNjTwUwjThxjP5rZLiehiVTLaa/d1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PlUbUBzqRlmP7xWmBTT579aeaF/As23HS8Gtv6Uvc83iRvn8tGvVmCIlB21QYsK8h
	 dHXW3CtBsZ0H5k5kq+sVB5ADTyiMi2ZPgtMqw5lW7nqKkHtKpghK2ZdZeR44NLC4Kv
	 uwkQfbXtfJlsQO/PUkqZXqTRpOO4/5Z4BcWOMCyvUYLg6vM1R52P6wVhtw0sIbjO9/
	 jZ5LToy4NMqv2cI8lGXq0JuELBRsB80Q6CqDc83gVTI0KeDijpFEUc1ss68vhBYLfB
	 dQPIzY70zo6WIVOOCrjg3EQVA4VVzfUihWz/1GmD93caG6BeoimG6JSPQxgPXgc1S/
	 FAa4TqvUIPBNg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 08 Aug 2024 09:15:24 +0100
Subject: [PATCH RFT v8 3/9] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-clone3-shadow-stack-v8-3-0acf37caf14c@kernel.org>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
In-Reply-To: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
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
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Hildenbrand <david@redhat.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+orwRfvizHfGXDNjTwUwjThxjP5rZLiehiVTLaa/d1s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmtH7JYGKmwMqFqel6gaUd06JMx0Dcs1EPMb2Px
 xS8sBUaNuKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZrR+yQAKCRAk1otyXVSH
 0A0qB/49bgle+hs90M96hEmr0SlTYk61h0S+da0Etb4uI9yufHVWC9eL284rHqFEYGsDSvP3H6f
 22dCUD1A8lowtEyvjV59TLqZSfW5v+nt+41FfFDXgroaegf3oHULyJpymwfd7Jil1tsWE53GmzJ
 mNBARyh3qymxlN43r1iDZVDBEITN+FnGBuF7VWUNrdJP8whHgkpVX3Um9/KnfFomebAxW9Tx+fs
 VKTcGfkSmDGgpzp4UGcnh3AtKqzFRlmMnfw/1wsb9P5Iz9P3gbGROpYjCUTYiR8TNJVmn01k5z0
 l+I+o6SP2KRmmzp/ZwEutgE257SMt8OdNuIMEVhVSXQUL6V1
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


