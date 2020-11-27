Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D536F2C738B
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Nov 2020 23:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgK1Vt5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Nov 2020 16:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgK0Trl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Nov 2020 14:47:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11789C061A4F;
        Fri, 27 Nov 2020 11:32:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 14FE11F4659F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     gofmanp@gmail.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 1/7] x86: vdso: Expose sigreturn address on vdso to the kernel
Date:   Fri, 27 Nov 2020 14:32:32 -0500
Message-Id: <20201127193238.821364-2-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127193238.821364-1-krisman@collabora.com>
References: <20201127193238.821364-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Syscall user redirection requires the signal trampoline code to not be
captured, in order to support returning with a locked selector while
avoiding recursion back into the signal handler.  For ia-32, which has
the trampoline in the vDSO, expose the entry points to the kernel, such
that it can avoid dispatching syscalls from that region to userspace.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
Changes since V5
  - Change return address to bool (Andy)
---
 arch/x86/entry/vdso/vdso2c.c           |  2 ++
 arch/x86/entry/vdso/vdso32/sigreturn.S |  2 ++
 arch/x86/entry/vdso/vma.c              | 15 +++++++++++++++
 arch/x86/include/asm/elf.h             |  2 ++
 arch/x86/include/asm/vdso.h            |  2 ++
 5 files changed, 23 insertions(+)

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
index 50e5d3a2e70a..de60cd37070b 100644
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
index 44a9b9940535..66bdfe838d61 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -388,6 +388,8 @@ extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 	compat_arch_setup_additional_pages(bprm, interpreter,		\
 					   (ex->e_machine == EM_X86_64))
 
+extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
+
 /* Do not change the values. See get_align_mask() */
 enum align_flags {
 	ALIGN_VA_32	= BIT(0),
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index b5d23470f56b..98aa103eb4ab 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -29,6 +29,8 @@ struct vdso_image {
 	long sym___kernel_rt_sigreturn;
 	long sym___kernel_vsyscall;
 	long sym_int80_landing_pad;
+	long sym_vdso32_sigreturn_landing_pad;
+	long sym_vdso32_rt_sigreturn_landing_pad;
 };
 
 #ifdef CONFIG_X86_64
-- 
2.29.2

