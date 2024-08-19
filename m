Return-Path: <linux-kselftest+bounces-15692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A79957460
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56BE0B222B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8631DC479;
	Mon, 19 Aug 2024 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd4C6R14"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266D1DC472;
	Mon, 19 Aug 2024 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095587; cv=none; b=JfvZHdWLzU+Y+M5XgHSgm8I2dyv1hu4hHJrxnQg7ZQQk0N2N+MWZxoH3fC34kkxA+djRPk2h1l94c+KRcKyNyb4r+1Sh7WBhmyTy5Meg8adrZ5s5IfGrsSQtN1GXZQHhSd2FOPf2buVwUv0+iSSnBHpdRvJZ/uviXDmLtKhnupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095587; c=relaxed/simple;
	bh=aXGeSW3grtLdSnTdx5+gSzbAczg0duMe8mDGJOGSfWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dpv5SCgg9/HYDiTv8AnvsB/3YNFFp3nC8spMclruHXiKlYV7QovkAETU9jrXagbD6uNL9ySMOmRdxmppB5MtQ9qbKnGfFbxe3kEi1r/DaSubnbJKtVFjsewS8xqxq2xLUT/bVsjc7fa8jbh3G9d7yX4Uc5Mgl7FSXPgLbZjCSRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd4C6R14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE48C32782;
	Mon, 19 Aug 2024 19:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724095586;
	bh=aXGeSW3grtLdSnTdx5+gSzbAczg0duMe8mDGJOGSfWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rd4C6R14skBr2RVjD+O1OmP4EBeK7xQUQ7zeyPiSllKC5WvXA3aRpdfcBA6gqzo2W
	 wNwP5P0ay2oJ/8wDLZXMj+jQ5pr0gpUllyLzVkVdWAa8yT9ySHeuS+twdi53D0Q/ro
	 YYocL2lRTrvFZWechjbXEP3aNwVuVMuzBkfowu+SQnUUJK1sfqm1cL4CZxR9EYRfS2
	 shTGNqfGeTaMLYNRspkzI9nymPoGwiRHjlsSPWKAB+T+TbYzwWCg2lJohgqjt5Dcta
	 16ToXfGKn5lVUg1qut6O0GNRnWhbVSUePNvrKFIc/MmQpj5MBQCqW63RxNmIicSLFO
	 dNU6Pj7NmXfVw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 19 Aug 2024 20:24:24 +0100
Subject: [PATCH RFT v9 3/8] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-clone3-shadow-stack-v9-3-962d74f99464@kernel.org>
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
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aXGeSW3grtLdSnTdx5+gSzbAczg0duMe8mDGJOGSfWQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmw5xErfFb8uONK8Tu4hC9CX4D4YDjcDcyOx9eluD1
 i0BbB/+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsOcRAAKCRAk1otyXVSH0CtNB/
 0caOlpo1xwqfHAFBQsdbD1OvYyCrdARg02XBPV65LoK6zEPBCmDOIKyXtu04AjNqtaqDYgOKP/7/MA
 I6FHFbMnTWZBqH7da12ttE+GnDcLOXuMBFzKxmBBHB5TD4/PIFSeJnhcpvTQU6+Orppqqbi+ZMa3av
 YCyqWSCaA20CzQXRopsezRH0hZCIXP2Jx+Rj006BuHl637WU3S5uB4hO8JQHGExvl6GDZYBwgxOHYt
 asBkwv8mkPTZIyKxfKNZMey5vVjrtGb4gqxbPx/it62qKxEsL6IHdOxqWVjjrIjIPyopittdmN5Nd7
 8x9eAONMsPj8vpYt5Lj35R6HAsXcLK
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


