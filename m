Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6202838732D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 09:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347152AbhERHXZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 03:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347104AbhERHXU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 03:23:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C9E061059;
        Tue, 18 May 2021 07:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621322523;
        bh=w+xDNuIbQ75zIlV6X2vYSDb8rOR9eABNVP3j0dfEFa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcnN0UPkpt0PUXc4QhfASaAw9lgLQKWLTtAkxY407pB2li0zIlJsJJWuQtKWhpjz9
         MNvRoOw87ZsKKEjY2ePFQmmoiXR9pc2bjDMyzPztLqQIiXP8u1UlcHHrEYSwChuDZW
         B0zn4bC/JkLRTSG5GsZir/OgvlymYbXy4ctnotUUZv159LD6s1MoJ1ENQahot0F0x+
         bli7ZHdn8oaTZztrqvzHz1g7SeNZlyWQHa/LFzs92i34QWi61TmQT5wULNdbCKL16P
         U6O3zIffTdNqNskZHUAeUNMY4ofmzWW0/24e3WaOwpnYJaRnklQmyx+eELdehv2mM0
         2RRTo51Uil6Eg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v20 6/7] arch, mm: wire up memfd_secret system call where relevant
Date:   Tue, 18 May 2021 10:20:33 +0300
Message-Id: <20210518072034.31572-7-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210518072034.31572-1-rppt@kernel.org>
References: <20210518072034.31572-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Wire up memfd_secret system call on architectures that define
ARCH_HAS_SET_DIRECT_MAP, namely arm64, risc-v and x86.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christopher Lameter <cl@linux.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tycho Andersen <tycho@tycho.ws>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/uapi/asm/unistd.h   | 1 +
 arch/riscv/include/asm/unistd.h        | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 include/linux/syscalls.h               | 1 +
 include/uapi/asm-generic/unistd.h      | 7 ++++++-
 scripts/checksyscalls.sh               | 4 ++++
 7 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index f83a70e07df8..ce2ee8f1e361 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -20,5 +20,6 @@
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
 #define __ARCH_WANT_SYS_CLONE3
+#define __ARCH_WANT_MEMFD_SECRET
 
 #include <asm-generic/unistd.h>
diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index 977ee6181dab..6c316093a1e5 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -9,6 +9,7 @@
  */
 
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_MEMFD_SECRET
 
 #include <uapi/asm/unistd.h>
 
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 28a1423ce32e..e44519020a43 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -451,3 +451,4 @@
 444	i386	landlock_create_ruleset	sys_landlock_create_ruleset
 445	i386	landlock_add_rule	sys_landlock_add_rule
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
+447	i386	memfd_secret		sys_memfd_secret
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ecd551b08d05..a06f16106f24 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -368,6 +368,7 @@
 444	common	landlock_create_ruleset	sys_landlock_create_ruleset
 445	common	landlock_add_rule	sys_landlock_add_rule
 446	common	landlock_restrict_self	sys_landlock_restrict_self
+447	common	memfd_secret		sys_memfd_secret
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 050511e8f1f8..1a1b5d724497 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1050,6 +1050,7 @@ asmlinkage long sys_landlock_create_ruleset(const struct landlock_ruleset_attr _
 asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
 		const void __user *rule_attr, __u32 flags);
 asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
+asmlinkage long sys_memfd_secret(unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 6de5a7fc066b..28b388368cf6 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -873,8 +873,13 @@ __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
 #define __NR_landlock_restrict_self 446
 __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 
+#ifdef __ARCH_WANT_MEMFD_SECRET
+#define __NR_memfd_secret 447
+__SYSCALL(__NR_memfd_secret, sys_memfd_secret)
+#endif
+
 #undef __NR_syscalls
-#define __NR_syscalls 447
+#define __NR_syscalls 448
 
 /*
  * 32 bit systems traditionally used different
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index a18b47695f55..b7609958ee36 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -40,6 +40,10 @@ cat << EOF
 #define __IGNORE_setrlimit	/* setrlimit */
 #endif
 
+#ifndef __ARCH_WANT_MEMFD_SECRET
+#define __IGNORE_memfd_secret
+#endif
+
 /* Missing flags argument */
 #define __IGNORE_renameat	/* renameat2 */
 
-- 
2.28.0

