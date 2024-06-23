Return-Path: <linux-kselftest+bounces-12514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5267C913A03
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 13:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF641B21C87
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 11:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1708C12FF70;
	Sun, 23 Jun 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0r6uerl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04FA12FB2F;
	Sun, 23 Jun 2024 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719141982; cv=none; b=Gl0ckdiyuc31rZ9kjAuPtgE8kghGL9YDahu3PZrj7iiC9hEp9II1hUA2ZPLD+u/1/oZzpsWTp9VvG+xrp88KSSoKWJnhMW6XnMm01xv3GgmVGwa4LJNbHGj4Js+mrCzml7xirh+dpIMJ2gfispDxrmRJhFZWxbabZieQPcw6V34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719141982; c=relaxed/simple;
	bh=+PP7awu1pf/fG6tcaOdbFq8gDfVEQNboirY/ny0xMww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqyUziaZ9Dr34q0qr5CmRvHxKUHvJTee4ueTb1qKZFQFcXsj/rYRSNYhAyxPZ27GpVpd1xRKK7tzIpRwjPKLH5R+EgiteDXGm+R3rjxqg56WNTKIIRoLq393XfFhgXwCh/4NPwO58tSqmRP7SyX6NnYJV0hnwNghEFI1PuaKvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0r6uerl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F5FC4AF0A;
	Sun, 23 Jun 2024 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719141981;
	bh=+PP7awu1pf/fG6tcaOdbFq8gDfVEQNboirY/ny0xMww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H0r6uerltPnfEq1VtK/OllBbSkAWbUCOTFZ6W1zCos7T9+sNn4UwUrrLW9A+4OQUR
	 ajFuSs/ejl5VKIWBT75tpM3SF1MbSRkh4f27GVCqJnmZIetdp4rfrv+hjheimHjbPA
	 BX60jBXDeRN0K9jpHCnBKIlVuxb0XpvLlbezraC9+unyOZcRfCMk9aW4X79+4whyvD
	 8OiPGr05yDn5s+hpwK7VaWHuKOtuMv7O28ID5M59Ftk7tmPsKFely9VIW7+WxDQfGG
	 8or/XijzOYjcTmL+iI9sy9I9438q6N8HmtrSlFAaAT0DFEaI1k/hYx6hxJJ/4wH6Hy
	 ybHWJ7srtt3XA==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 23 Jun 2024 12:23:45 +0100
Subject: [PATCH RFT v6 3/9] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-clone3-shadow-stack-v6-3-9ee7783b1fb9@kernel.org>
References: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
In-Reply-To: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
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
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+PP7awu1pf/fG6tcaOdbFq8gDfVEQNboirY/ny0xMww=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmeAZAkwpp+R8wFIKgWo2CycAiyTshvHjPn/iDZmop
 jlzBrJSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZngGQAAKCRAk1otyXVSH0Pk6B/
 0bGimYO7ZisG6Hh4arA8DQuFSyN8VsytcZkbccpGW0gw7qz3FKlGBF4L0dlty/LTH14EUMeWDMsP8Z
 eOB1lD0lwL9ZHS0GZx1l5d78yAR9u2QB8Ln2wvlP7C3zDlhVOqkJR4uREQn3hKm/CdnA5+JZJHtPth
 IQwUItWLRnOApQ3qhDI2IqK4GOcJL9/iLXVck94NG/4MbxbLC//wMy+K76dcmIbBO/yPM1d8/yMiW8
 DzmlEdlqLNKfYxzU6EYxgpB1Euq4tOvEP2ky7tXVNFS2w+QUSnQqRybE9UZxcH3lq16hxh3BugH/rE
 ggIUSE61xfmZIRyKh/tnBxJSpS+ior
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
index 1d7122a1883e..4a5e40d4c14e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1949,6 +1949,7 @@ config X86_USER_SHADOW_STACK
 	depends on AS_WRUSS
 	depends on X86_64
 	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_USER_SHADOW_STACK
 	select X86_CET
 	help
 	  Shadow stack protection is a hardware feature that detects function
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f8d35f993fe5..1b56c1077507 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -704,7 +704,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 	};
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..5ec7bc355657 100644
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
index b4cb45255a54..45416916dec1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1249,6 +1249,12 @@ config IOMMU_MM_DATA
 config EXECMEM
 	bool
 
+config ARCH_HAS_USER_SHADOW_STACK
+	bool
+	help
+	  The architecture has hardware support for userspace shadow call
+          stacks (eg, x87 CET, arm64 GCS or RISC-V Zicfiss).
+
 source "mm/damon/Kconfig"
 
 endmenu

-- 
2.39.2


