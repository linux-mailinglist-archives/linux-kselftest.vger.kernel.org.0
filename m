Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC825E2CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Sep 2020 22:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgIDUcH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Sep 2020 16:32:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42074 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgIDUcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Sep 2020 16:32:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 71E8029B031
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 3/9] x86: vdso: Expose sigreturn address on vdso to the kernel
Date:   Fri,  4 Sep 2020 16:31:41 -0400
Message-Id: <20200904203147.2908430-4-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904203147.2908430-1-krisman@collabora.com>
References: <20200904203147.2908430-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Syscall user redirection requires the signal trampoline code to not be
captured, in order to support returning with a locked selector while
avoiding recursion back into the signal handler.  For ia-32, which has
the trampoline in the vDSO, expose the entry points to the kernel, such
that it can avoid dispatching syscalls from that region to userspace.

Changes since V1
  - Change return address to bool (Andy)

Suggested-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/entry/vdso/vdso2c.c           |  2 ++
 arch/x86/entry/vdso/vdso32/sigreturn.S |  2 ++
 arch/x86/entry/vdso/vma.c              | 15 +++++++++++++++
 arch/x86/include/asm/elf.h             |  1 +
 arch/x86/include/asm/vdso.h            |  2 ++
 5 files changed, 22 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 7380908045c7..2d0f3d8bcc25 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -101,6 +101,8 @@ struct vdso_sym required_syms[] = {
 	{"__kernel_sigreturn", true},
 	{"__kernel_rt_sigreturn", true},
 	{"int80_landing_pad", true},
+	{"vdso32_rt_sigreturn_landing_pad", true},
+	{"vdso32_sigreturn_landing_pad", true},
 };
 
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))
diff --git a/arch/x86/entry/vdso/vdso32/sigreturn.S b/arch/x86/entry/vdso/vdso32/sigreturn.S
index c3233ee98a6b..1bd068f72d4c 100644
--- a/arch/x86/entry/vdso/vdso32/sigreturn.S
+++ b/arch/x86/entry/vdso/vdso32/sigreturn.S
@@ -18,6 +18,7 @@ __kernel_sigreturn:
 	movl $__NR_sigreturn, %eax
 	SYSCALL_ENTER_KERNEL
 .LEND_sigreturn:
+SYM_INNER_LABEL(vdso32_sigreturn_landing_pad, SYM_L_GLOBAL)
 	nop
 	.size __kernel_sigreturn,.-.LSTART_sigreturn
 
@@ -29,6 +30,7 @@ __kernel_rt_sigreturn:
 	movl $__NR_rt_sigreturn, %eax
 	SYSCALL_ENTER_KERNEL
 .LEND_rt_sigreturn:
+SYM_INNER_LABEL(vdso32_rt_sigreturn_landing_pad, SYM_L_GLOBAL)
 	nop
 	.size __kernel_rt_sigreturn,.-.LSTART_rt_sigreturn
 	.previous
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 9185cb1d13b9..3fc323d24824 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -436,6 +436,21 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 }
 #endif
 
+bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+	const struct vdso_image *image = current->mm->context.vdso_image;
+	unsigned long vdso = (unsigned long) current->mm->context.vdso;
+
+	if (in_ia32_syscall() && image == &vdso_image_32) {
+		if (regs->ip == vdso + image->sym_vdso32_sigreturn_landing_pad ||
+		    regs->ip == vdso + image->sym_vdso32_rt_sigreturn_landing_pad)
+			return true;
+	}
+#endif
+	return false;
+}
+
 #ifdef CONFIG_X86_64
 static __init int vdso_setup(char *s)
 {
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index b9a5d488f1a5..eb41db289fe6 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -383,6 +383,7 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 					      int uses_interp);
+extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
 #define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
 
 /* Do not change the values. See get_align_mask() */
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index bbcdc7b8f963..589f489dd375 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -27,6 +27,8 @@ struct vdso_image {
 	long sym___kernel_rt_sigreturn;
 	long sym___kernel_vsyscall;
 	long sym_int80_landing_pad;
+	long sym_vdso32_sigreturn_landing_pad;
+	long sym_vdso32_rt_sigreturn_landing_pad;
 };
 
 #ifdef CONFIG_X86_64
-- 
2.28.0

