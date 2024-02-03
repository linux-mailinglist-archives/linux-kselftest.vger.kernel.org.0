Return-Path: <linux-kselftest+bounces-4060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A0847D79
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 01:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E6328BE28
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 00:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB6B368;
	Sat,  3 Feb 2024 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvjfNJJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526DE6FAD;
	Sat,  3 Feb 2024 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918743; cv=none; b=NnJIAnU7BQyPDvbfcAa6IJrHVOslv8BAbIBWezyOx9/m/ipSXdo6P4CD2tHZdnMrHW7MBxKtkJiR28p6sFRdAH22yILmb3siFzVPKfQOhkVFmhnsyE4sxMUNLYvlYQmRaqT7CnQ7kPbNobLV+LXYed4kZAY59vu73cZWbQ/shuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918743; c=relaxed/simple;
	bh=kiK765H9QFvcPD51NDMimYIoE+CAz43kont3MOS2Ik4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TWQtvxp5/XlatL5F8sAcqJa8mXAZtvepQ90x3BHdot4ZqPZM0nE/XrXRWdL804oKRDwM6djfCoe9n5k2qeZm9UawhZooUohXFL9solBBwdIyGPKOmxnUR/7rs5n6Acj2afzqQwhlVfadfJQcglZmdTuB8tHpwvxGaZdx6GeqqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvjfNJJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC7BC43394;
	Sat,  3 Feb 2024 00:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706918742;
	bh=kiK765H9QFvcPD51NDMimYIoE+CAz43kont3MOS2Ik4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FvjfNJJC6wgrEPZLZSwTVk0ET1J7SKuJvQvF5GDxDbmYKyChIkB8ymouFyiymLkI9
	 X/owQnCAjnUc4VHI/ma1JXnlVHAbxCLDStdlMLVKfctz0xvYgYXDXcxQriO+1jGrpj
	 pu8wBs+Xva+81RL/HCsD3jrb6VgJQyFnorhJr2CwQn1TZHhjS480rhX9KQzqGfEa1e
	 C8nC5PHeOsHm1AX/s1HYJ5J4RoiDgcFTeTlYCDO67rieMulRmvT5NQrojOLyUvyYE5
	 t1JB7ozzM0Ii09hFjUFclDNHRQ/3clwsjnvOWsUZkkSNvEqZsiUeTksns2dNqcoiuA
	 2onigevkxHXBQ==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 00:04:59 +0000
Subject: [PATCH RFT v5 3/7] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-clone3-shadow-stack-v5-3-322c69598e4b@kernel.org>
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
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 David Hildenbrand <david@redhat.com>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2344; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kiK765H9QFvcPD51NDMimYIoE+CAz43kont3MOS2Ik4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvYM6UvdX1xy39P6Ycpi5xqxlbO/j3vEL7OV15CBs
 w656sDeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb2DOgAKCRAk1otyXVSH0J7YB/
 9jR2meWiqMNmTde6tFYxtIM7l52JWZsu1IZdPUbTKAJQS0NnGcrqxkEQjDA8nn2vLD9h78yX3JAa+h
 po/CqlJ9GD6TXa4uOwbojPl/j3iSOelQFjJtlLw+zwDWRbR94YUpfNf68MLbfIKvcKbGOWIt/qd5cf
 WmfeeUTbbDFr1JL44Tk7MrDzG7XVFQKEi0HfQL9bW2wrmr1mKJ//a6XEevdWmGUk3YMJc0P8NS8l8K
 ceNjmQisd2pMYDjwBDlsHg9hgdCs8lZ8mzHzqArsSGz2g7sRNf51LaDbJWbag7xjYgu9UTC0KTICn1
 s5vZjVItqQ8P/YOK3KRvImN5Dnr67B
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
index 5edec175b9bf..34553911d07d 100644
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
index 3f78ebbb795f..ff2c601f7d1c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -700,7 +700,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 	};
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..c0a782eda803 100644
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
index ffc3a2ba3a8c..9119e016777a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1261,6 +1261,12 @@ config LOCK_MM_AND_FIND_VMA
 config IOMMU_MM_DATA
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
2.30.2


