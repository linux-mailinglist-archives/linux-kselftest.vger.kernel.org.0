Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA62117D925
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 07:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgCIGAN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 02:00:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42238 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIGAN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 02:00:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so4202192pgs.9
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Mar 2020 23:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=stcCKmy7SQ9g7ZsTv/Pq3Lw9qpVXYew7FPspFo97R1U=;
        b=gJp31reB6ClzmNR1R2v2gOATZAITpN46NAJ0cvKIVbXKLBFaNRMQzIePwSwbLKGW1t
         79GgNMGSryFeVFbF1jCM96E2uPD4PvmOhPRirXGac6PMgr2bVfKH+9IeO9sl+FdZsuYA
         srm86vq5RiZDwe9S+ZDZ5dk8j41SB6qFN8NK7fjGQFWJsXnDfScPk8KKt1KarUhABL5v
         VCUpuxpUClz4qsl2UKRAXcBTvgzmNZq329W45MstjZhAKpYwK/XoCL2jrq75H/UIOFPX
         9ZD8JKv6jeUD/1R5KhDqSOc1CkXOTsT9ImxyYWvPAWQBT7JrqG3OfBWZvd5rIaSZy5S0
         /UCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stcCKmy7SQ9g7ZsTv/Pq3Lw9qpVXYew7FPspFo97R1U=;
        b=hkK+Ykp1jNhkr2tM+ejW2aT4CdEWR/06Tgkw5EMYFucrGZT+9IjLHM6CsguV49Z2sr
         Id0IQ+hJmEU2bQm8o+pOoc6virrHPwjdwXd6CrcFWo1zhxxHo7XiCuiID3jjyfuETXrH
         T50E0RjdoD+Ffkf09GyPsly4t+Enky5jBc+XeAMYOXHvA+AaQdIW3CmieZQvUq2GmPgB
         sV6OCu4M09wpTWz0kPGq5n4oGH0F7B7jbekJQ9JLxYWxVL9UWZ3wmZY3ThK0F91db5jw
         CWidjr1Z8YGYMerbFrxyQRBR3QOhbfEAksZO3YGpJ/3/5t0TLVR89zqtjYBvrqB5eAPP
         Ap1A==
X-Gm-Message-State: ANhLgQ0bjgOrQVdQe9MzejqQ8kIYMZBxkURzjDTblonzyyGGU7I1+6ko
        pnNtdG/Wu/1RY6OPObKeiQw2UiAcR0DqbQ==
X-Google-Smtp-Source: ADFU+vuEtUImgh7ch4GRkP8XYQmAOIQAu/igdoFQz/noDPDwlIRoYCHkyrpafAGqVh9GUxwwk7Up8w==
X-Received: by 2002:a63:c546:: with SMTP id g6mr14349732pgd.243.1583733611220;
        Sun, 08 Mar 2020 23:00:11 -0700 (PDT)
Received: from VincentChen-ThinkPad-T480s.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id nh4sm3033061pjb.39.2020.03.08.23.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Mar 2020 23:00:10 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        mathieu.desnoyers@efficios.com
Cc:     linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH V2 1/3] riscv: add required functions to enable HAVE_REGS_AND_STACK_ACCESS_API
Date:   Mon,  9 Mar 2020 13:59:50 +0800
Message-Id: <1583733592-22873-2-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583733592-22873-1-git-send-email-vincent.chen@sifive.com>
References: <1583733592-22873-1-git-send-email-vincent.chen@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Patrick Stählin <me@packi.ch>

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
index 73f029eae0cc..fa98b279257e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -66,6 +66,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_ARCH_KASAN if MMU && 64BIT
+	select HAVE_REGS_AND_STACK_ACCESS_API
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index ee49f80c9533..9fc685659eb1 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -8,6 +8,7 @@
 
 #include <uapi/asm/ptrace.h>
 #include <asm/csr.h>
+#include <linux/compiler.h>
 
 #ifndef __ASSEMBLY__
 
@@ -59,7 +60,7 @@ struct pt_regs {
 #endif
 
 #define user_mode(regs) (((regs)->status & SR_PP) == 0)
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
index 407464201b91..bdfee5eff777 100644
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
+	REG_OFFSET_NAME(epc),
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
+	REG_OFFSET_NAME(status),
+	REG_OFFSET_NAME(badaddr),
+	REG_OFFSET_NAME(cause),
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
+	for (roff = regoffset_table; roff->name; roff++)
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

