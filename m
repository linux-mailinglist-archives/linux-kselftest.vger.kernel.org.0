Return-Path: <linux-kselftest+bounces-15913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A50C095A574
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511DD1F22E77
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D263416F297;
	Wed, 21 Aug 2024 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN2T3qhn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60CC16EB7B;
	Wed, 21 Aug 2024 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724269845; cv=none; b=MNrR+nAYG4tQiAd16/8xRbQkupeTmpbbEg7K+zrk/K7W7GBa7K2CNMHH9t6H4Jy+WbxpBHIBETq2tPHifVnPa0GLklH0oaiy17qOC4wU1ErSbj8zQ1x8BmTeHOud4moJFiMedof33ijFEh5ITVPr92W3hBeklCdFaV9u7mekq4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724269845; c=relaxed/simple;
	bh=aXGeSW3grtLdSnTdx5+gSzbAczg0duMe8mDGJOGSfWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tX2y1JI/4mOHGHOXU1+dF/3TM05PCCXh0xIW4oRO7p1s4ZMCW0t/Z5bsPOWnafo/5j6mbPveSyUXoYibshE11QncRtilr7NNXIiOSx6NUSrcuNW4zq/g5SwbU5fP09qQvC4jBCCQxksvrH02wtR56sndqR+l/euPx8lyvqeFexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN2T3qhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3818C4AF14;
	Wed, 21 Aug 2024 19:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724269845;
	bh=aXGeSW3grtLdSnTdx5+gSzbAczg0duMe8mDGJOGSfWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nN2T3qhnP3Fc7aDH2vnn5Wh55dpYvG/xNiLW6sXa6fi2g/B5EHTzeruwWoL8CJBpw
	 zCoeqkd5o/NwJx28FWrZ8X8LNK8NOIVJNRIdkXRF/XIwqNswb9pPDntu3Kd3QIQcAi
	 twi/S36nZ/ctECqqfi+K1aQdJYaCzEBeXykTDpXd5PFuyItRvphiULb4YQOZjHKwMF
	 jus4zKdcw1p3RGYcAtigQoUU2z16lhkZxAsNc9pXeJeHKR+dhyMafLHulytf7DeHOv
	 9oj56TwmyRZpJ7cU/V9DALazcAyoiRhhlB4Avs53Jm0B70rflG2vcop0Gfigu48QAu
	 mHi5+dHm3eejQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 21 Aug 2024 20:49:49 +0100
Subject: [PATCH RFT v10 3/8] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-clone3-shadow-stack-v10-3-06e8797b9445@kernel.org>
References: <20240821-clone3-shadow-stack-v10-0-06e8797b9445@kernel.org>
In-Reply-To: <20240821-clone3-shadow-stack-v10-0-06e8797b9445@kernel.org>
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
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aXGeSW3grtLdSnTdx5+gSzbAczg0duMe8mDGJOGSfWQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxkT1JN82YTNd5Xc0roP8UmiPdvmd5OWFRddLsNLv
 //dr4cGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsZE9QAKCRAk1otyXVSH0FDzB/
 0ZfPd+KtGJCqx7/ZvTOUYTKzVXC0z0TBbi5IgAilS7zxjiigAyO0zvtpmXtwbcCylnVsuBBVd3sMtR
 rbbhP4kdkc1ZwbABsA3ZAgJ0l+fW7gQg06EA5b2jfZeKukw21l9Xcw+C7svCh0tOpTemv4NXsFU+QL
 jgiZmRpZGACM2P84WgM6WzQFjiJgNlQcz13anzTGERChPh4+NQGTBuVGIb8RgZbUTAPQjfvWNUabx3
 3cvmLOWef5yrq9YlSTlS9mC4SstHLZ5IeJtNQ+iGjVpPwaVBIh7L+40rGdBTyAb1MBj6tTAUqS8OrQ
 m5Ii2cWg4xjAq9BFQkLFBe5bDDGvX7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since multiple architectures have support for shadow stacks and we need to
select support for this feature in several places in the generic code
provide a generic config option that the architectures can select.

Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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


