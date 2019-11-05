Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF51EF319
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2019 02:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfKEB7E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Nov 2019 20:59:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33251 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbfKEB7D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Nov 2019 20:59:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id u23so12885321pgo.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2019 17:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKe5vka41vCk7IJBHRB0aU/h2BDmqOkfTUawjJnfeSU=;
        b=kqzGoQTrxwP3jEQq+Yl+YrUma3unFzu79pdCMhJiuD8Ksbdd8H6J2IMXxzus5hAQXl
         jawP+rzmoae5W6MB/cQeq7UL2tMioZDcsRvX7uAVlpOu3y3ZNl+SjoJ1IPnbAU1LB0Vk
         bKj8uQbbbANJIk9/Go4vcAiyGc8+2PBAeXIfDUQ/YhkgUZwB+hYs/mx4gk0HBUShZpXe
         c6/RxTCzkwJS5SHh6nm19fEiQMBSqvBR1fT2FGIBIH423yyKXaD1a9xF/nVJsX/QvDAD
         XQSmki1VYaHnkYiXEHQ8jsZheB2F31Ndnu8eOtlzGF5lYY6lfEUJfsTO58KhhXeXLVhC
         lnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKe5vka41vCk7IJBHRB0aU/h2BDmqOkfTUawjJnfeSU=;
        b=ZnhK9M11LVfCh+M2QGnptqLwA2bDWUc3RlYzWa4EKXbekqYnH9gWi+x1qyW7uNI9GE
         8BbuhhI5HsAJL0Pd8COP2cJRwVwXyjSunsXx101UCAw2WKKi0NPP5Kftte5y8/7QW2HO
         lUzcwom6eP1e36StcUomTIRWCeylRQKP2ckwepU61dnAZ3dYZ+puGHTR6GFY+kOV7B9r
         gEEkdlmQD091T1/Mbf/DsLQlIm/7Dyh4XLPJy/mj7c8K11UjhQWsudI41IIsCc5ztorj
         LoTADuYmy1EdPf8h1aMReSs+guhjfXUCMAZ+ZIlGM3k/jIYodHnrJgwkxHRZsqWMBhbs
         pi4w==
X-Gm-Message-State: APjAAAUNwc/eDJAh4rrNj/gtfORjBBxuzA9mDvHi/MKjSC3WEoEpwTd9
        nqF3WhEq9kd4FOhZmMCHNE11ZQ==
X-Google-Smtp-Source: APXvYqwtM23oxRwflZx1y81RMNLN2ECVpJdBVhvgKUWdOhUuSlJxbqlk8BuK0F22fNGLMEtYVGVIIA==
X-Received: by 2002:a63:e056:: with SMTP id n22mr32592549pgj.73.1572919141406;
        Mon, 04 Nov 2019 17:59:01 -0800 (PST)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id j6sm16484444pfa.124.2019.11.04.17.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Nov 2019 17:59:00 -0800 (PST)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     paul.walmsley@sifive.com, mathieu.desnoyers@efficios.com
Cc:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        vincent.chen@sifive.com,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>
Subject: [PATCH 1/3] riscv: add required functions to enable HAVE_REGS_AND_STACK_ACCESS_API
Date:   Tue,  5 Nov 2019 09:58:32 +0800
Message-Id: <1572919114-3886-2-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572919114-3886-1-git-send-email-vincent.chen@sifive.com>
References: <1572919114-3886-1-git-send-email-vincent.chen@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to select HAVE_REGS_AND_STACK_ACCESS_API, adding the APIs
required by kprobes to access pt_regs and stack entries to the RISC-V
ports.

Signed-off-by: Patrick Stählin <me@packi.ch>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ptrace.h | 29 +++++++++++-
 arch/riscv/kernel/ptrace.c      | 99 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8eebbc8860bb..d5bbf4223fd2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -61,6 +61,7 @@ config RISCV
 	select SPARSEMEM_STATIC if 32BIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select HAVE_ARCH_MMAP_RND_BITS
+	select HAVE_REGS_AND_STACK_ACCESS_API
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index d48d1e13973c..635b7b5506ec 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -8,6 +8,7 @@
 
 #include <uapi/asm/ptrace.h>
 #include <asm/csr.h>
+#include <linux/compiler.h>
 
 #ifndef __ASSEMBLY__
 
@@ -59,7 +60,7 @@ struct pt_regs {
 #endif
 
 #define user_mode(regs) (((regs)->sstatus & SR_SPP) == 0)
-
+#define MAX_REG_OFFSET offsetof(struct pt_regs, orig_a0)
 
 /* Helpers for working with the instruction pointer */
 static inline unsigned long instruction_pointer(struct pt_regs *regs)
@@ -79,6 +80,12 @@ static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 {
 	return regs->sp;
 }
+
+static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+{
+	return regs->sp;
+}
+
 static inline void user_stack_pointer_set(struct pt_regs *regs,
 					  unsigned long val)
 {
@@ -101,6 +108,26 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->a0;
 }
 
+int regs_query_register_offset(const char *name);
+
+unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n);
+/**
+ * regs_get_register() - get register value from its offset
+ * @regs:	pt_regs from which register value is gotten
+ * @offset:	offset of the register.
+ *
+ * regs_get_register returns the value of a register whose offset from @regs.
+ * The @offset is the offset of the register in struct pt_regs.
+ * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
+ */
+static inline unsigned long regs_get_register(struct pt_regs *regs,
+					      unsigned int offset)
+{
+	if (unlikely(offset > MAX_REG_OFFSET))
+		return 0;
+
+	return *(unsigned long *)((unsigned long)regs + offset);
+}
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 1252113ef8b2..2ae450d67659 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -125,6 +125,105 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	return &riscv_user_native_view;
 }
 
+struct pt_regs_offset {
+	const char *name;
+	int offset;
+};
+
+#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
+#define REG_OFFSET_END {.name = NULL, .offset = 0}
+
+static const struct pt_regs_offset regoffset_table[] = {
+	REG_OFFSET_NAME(sepc),
+	REG_OFFSET_NAME(ra),
+	REG_OFFSET_NAME(sp),
+	REG_OFFSET_NAME(gp),
+	REG_OFFSET_NAME(tp),
+	REG_OFFSET_NAME(t0),
+	REG_OFFSET_NAME(t1),
+	REG_OFFSET_NAME(t2),
+	REG_OFFSET_NAME(s0),
+	REG_OFFSET_NAME(s1),
+	REG_OFFSET_NAME(a0),
+	REG_OFFSET_NAME(a1),
+	REG_OFFSET_NAME(a2),
+	REG_OFFSET_NAME(a3),
+	REG_OFFSET_NAME(a4),
+	REG_OFFSET_NAME(a5),
+	REG_OFFSET_NAME(a6),
+	REG_OFFSET_NAME(a7),
+	REG_OFFSET_NAME(s2),
+	REG_OFFSET_NAME(s3),
+	REG_OFFSET_NAME(s4),
+	REG_OFFSET_NAME(s5),
+	REG_OFFSET_NAME(s6),
+	REG_OFFSET_NAME(s7),
+	REG_OFFSET_NAME(s8),
+	REG_OFFSET_NAME(s9),
+	REG_OFFSET_NAME(s10),
+	REG_OFFSET_NAME(s11),
+	REG_OFFSET_NAME(t3),
+	REG_OFFSET_NAME(t4),
+	REG_OFFSET_NAME(t5),
+	REG_OFFSET_NAME(t6),
+	REG_OFFSET_NAME(sstatus),
+	REG_OFFSET_NAME(sbadaddr),
+	REG_OFFSET_NAME(scause),
+	REG_OFFSET_NAME(orig_a0),
+	REG_OFFSET_END,
+};
+
+/**
+ * regs_query_register_offset() - query register offset from its name
+ * @name:	the name of a register
+ *
+ * regs_query_register_offset() returns the offset of a register in struct
+ * pt_regs from its name. If the name is invalid, this returns -EINVAL;
+ */
+int regs_query_register_offset(const char *name)
+{
+	const struct pt_regs_offset *roff;
+
+	for (roff = regoffset_table; roff->name != NULL; roff++)
+		if (!strcmp(roff->name, name))
+			return roff->offset;
+	return -EINVAL;
+}
+
+/**
+ * regs_within_kernel_stack() - check the address in the stack
+ * @regs:      pt_regs which contains kernel stack pointer.
+ * @addr:      address which is checked.
+ *
+ * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
+ * If @addr is within the kernel stack, it returns true. If not, returns false.
+ */
+static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
+{
+	return (addr & ~(THREAD_SIZE - 1))  ==
+		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1));
+}
+
+/**
+ * regs_get_kernel_stack_nth() - get Nth entry of the stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @n:		stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
+ * is specified by @regs. If the @n th entry is NOT in the kernel stack,
+ * this returns 0.
+ */
+unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
+{
+	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
+
+	addr += n;
+	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+		return *addr;
+	else
+		return 0;
+}
+
 void ptrace_disable(struct task_struct *child)
 {
 	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-- 
2.7.4

