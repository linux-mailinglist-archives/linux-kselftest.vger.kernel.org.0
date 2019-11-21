Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97172105CB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2019 23:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfKUWc0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Nov 2019 17:32:26 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46614 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKUWc0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Nov 2019 17:32:26 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so5388302iol.13
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2019 14:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Mjy3unUiwbhbt7LD7CSsL8EBh3Y2S/CME2ratkULkBQ=;
        b=OjJ6mjWeHmje7MOQnaO4xZuQCLiyEwdanPC3DCnDtDoSfs5eajJ3ApR7CPlBXj+qFr
         oRYfPHcBGbdiGzS8XGsNT/iTZTC37EY44NefCoRmOF6AFsP55KRQhKWtT1qS0kvIvgA5
         W99vNo06cqcGUT3FRgQyeticVTyL5FkzAbVDUttidBfr+ZQmzDUL9gS2LQfTQz0tw5Mt
         GQSiYU0qfRcDKwmh/7GUy/Nf6wuwd3te+Zzu93qLr71qRWvAEfW2Qi2YWF5YKYK4UFtc
         plMHhybM7HsdICm/65RGDtFH+r3hmE2vkppuFr4D3i8ANdpMpG0HVjDKAn0TR+KtwqF8
         B6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Mjy3unUiwbhbt7LD7CSsL8EBh3Y2S/CME2ratkULkBQ=;
        b=pyaWMGU3Vawc7kK/C7QBltXhN2mUUqvBboxp4nOE5DyRGO4jidScVYb2YUpPfbJofb
         TJLCKqDvQqttj+bk2RJ0nbLDyqj8+lfjnr5AAqmGHULaN52jizcT96svGIo/Lc9+atCV
         adi5MRvEQa4YG8Cds6LfpFurvWIa2IKA7oK+s6MppXzOO6bUjQXPm7OxnuZZ0jnmPnW3
         cFH+zTW0hMTRN3wJNrWwnMYzZ3Ka8Uy+OYrli+mFu5VYRDgrbF18rXFsyp08m+ue+m9d
         BXqcYzHq5xugFiE4ToEPuOJ88G7FKag68Fmkbf5qRxMSMqbB+F2D0EexR2vBDRcC6YiX
         gjpw==
X-Gm-Message-State: APjAAAU491F3xXoxpvbjmUY/gNJXlneBdN+Ng+sNQ/oO/wdPIdx856j6
        61PXvK9nliv0PihbQ7Xc35G6UQ==
X-Google-Smtp-Source: APXvYqzt5fLVR5ViYOucREEC8Zd7myW4vTOLMDFDsHrZAuPr1y6iVk++dez6fIbdKwbshPskbBSgfg==
X-Received: by 2002:a5d:9153:: with SMTP id y19mr10046116ioq.26.1574375545426;
        Thu, 21 Nov 2019 14:32:25 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id d11sm1843269ill.17.2019.11.21.14.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 14:32:21 -0800 (PST)
Date:   Thu, 21 Nov 2019 14:32:16 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Vincent Chen <vincent.chen@sifive.com>
cc:     =?ISO-8859-15?Q?Patrick_St=E4hlin?= <me@packi.ch>,
        mathieu.desnoyers@efficios.com, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: add required functions to enable
 HAVE_REGS_AND_STACK_ACCESS_API
In-Reply-To: <alpine.DEB.2.21.9999.1911211225350.30580@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1911211418320.5296@viisi.sifive.com>
References: <1572919114-3886-1-git-send-email-vincent.chen@sifive.com> <1572919114-3886-2-git-send-email-vincent.chen@sifive.com> <alpine.DEB.2.21.9999.1911211225350.30580@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-214833690-1574375536=:5296"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-214833690-1574375536=:5296
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 Nov 2019, Paul Walmsley wrote:

> As I understand it, this patch hasn't been signed off on by Patrick.
> I've sent him an E-mail asking him whether he's willing to add his=20
> Signed-off-by:, but haven't heard back from it.
>=20
> From our discussions, I understand that this patch is based partially on=
=20
> some of his earlier, public, kprobes work.  In lieu of any response from=
=20
> Patrick, could you please resend this patch and just note in the commit=
=20
> description that it's partially based on one of his patches, add a Link:=
=20
> line that points to the URL of the patch that it's partially based on, an=
d=20
> replace the Signed-off-by: with a Co-developed-by: or something similar?

OK - just looked at the patches more closely, and I think I see what's=20
going on here.  This patch looks like a rebased version of this patch:

https://lore.kernel.org/linux-riscv/20181113195804.22825-2-me@packi.ch/

So let's just plan to use an updated version of Patrick's original=20
(below).  Please let me know if you have any comments on it or if I=20
missed something -


- Paul

From: Patrick St=C3=A4hlin <me@packi.ch>
Date: Tue, 13 Nov 2018 20:58:03 +0100
Subject: [PATCH] RISC-V: Implement ptrace regs and stack API
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Needed for kprobes support. Copied and adapted from arm64 code.

Signed-off-by: Patrick St=C3=A4hlin <me@packi.ch>
[paul.walmsley@sifive.com: updated to apply; fixed checkpatch issues;
 fixed regs_get_register() kerneldoc]
Cc: Vincent Chen <vincent.chen@sifive.com>
Link: https://lore.kernel.org/linux-riscv/20181113195803.CjtBCsUcG9czwiqmPB=
GKUjvl5Ojxq2SIPaioQUHXFI0@z/
Link: https://lore.kernel.org/linux-riscv/1572919114-3886-1-git-send-email-=
vincent.chen@sifive.com/T/#mdb346527d25ea1959ab57ff9d1c056bcd29c7172
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ptrace.h | 30 ++++++++++
 arch/riscv/kernel/ptrace.c      | 99 +++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8eebbc8860bb..d5bbf4223fd2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -61,6 +61,7 @@ config RISCV
 =09select SPARSEMEM_STATIC if 32BIT
 =09select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 =09select HAVE_ARCH_MMAP_RND_BITS
+=09select HAVE_REGS_AND_STACK_ACCESS_API
=20
 config ARCH_MMAP_RND_BITS_MIN
 =09default 18 if 64BIT
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrac=
e.h
index d48d1e13973c..50d37b123a61 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -8,6 +8,7 @@
=20
 #include <uapi/asm/ptrace.h>
 #include <asm/csr.h>
+#include <linux/compiler.h>
=20
 #ifndef __ASSEMBLY__
=20
@@ -60,6 +61,7 @@ struct pt_regs {
=20
 #define user_mode(regs) (((regs)->sstatus & SR_SPP) =3D=3D 0)
=20
+#define MAX_REG_OFFSET offsetof(struct pt_regs, orig_a0)
=20
 /* Helpers for working with the instruction pointer */
 static inline unsigned long instruction_pointer(struct pt_regs *regs)
@@ -85,6 +87,12 @@ static inline void user_stack_pointer_set(struct pt_regs=
 *regs,
 =09regs->sp =3D  val;
 }
=20
+/* Valid only for Kernel mode traps. */
+static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+{
+=09return regs->sp;
+}
+
 /* Helpers for working with the frame pointer */
 static inline unsigned long frame_pointer(struct pt_regs *regs)
 {
@@ -101,6 +109,28 @@ static inline unsigned long regs_return_value(struct p=
t_regs *regs)
 =09return regs->a0;
 }
=20
+int regs_query_register_offset(const char *name);
+unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
+=09=09=09=09=09unsigned int n);
+
+/**
+ * regs_get_register() - get register value from its offset
+ * @regs:=09pt_regs from which register value is gotten
+ * @offset:=09offset of the register.
+ *
+ * regs_get_register() returns the value from @regs of a register
+ * identified by @offset.  The @offset is the offset of the register
+ * in struct pt_regs.  If @offset is bigger than MAX_REG_OFFSET, this
+ * returns 0.
+ */
+static inline unsigned long regs_get_register(struct pt_regs *regs,
+=09=09=09=09=09      unsigned int offset)
+{
+=09if (unlikely(offset > MAX_REG_OFFSET))
+=09=09return 0;
+
+=09return *(unsigned long *)((unsigned long)regs + offset);
+}
 #endif /* __ASSEMBLY__ */
=20
 #endif /* _ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 1252113ef8b2..5076b30fe18b 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -125,6 +125,105 @@ const struct user_regset_view *task_user_regset_view(=
struct task_struct *task)
 =09return &riscv_user_native_view;
 }
=20
+struct pt_regs_offset {
+=09const char *name;
+=09int offset;
+};
+
+#define REG_OFFSET_NAME(r) {.name =3D #r, .offset =3D offsetof(struct pt_r=
egs, r)}
+#define REG_OFFSET_END {.name =3D NULL, .offset =3D 0}
+
+static const struct pt_regs_offset regoffset_table[] =3D {
+=09REG_OFFSET_NAME(sepc),
+=09REG_OFFSET_NAME(ra),
+=09REG_OFFSET_NAME(sp),
+=09REG_OFFSET_NAME(gp),
+=09REG_OFFSET_NAME(tp),
+=09REG_OFFSET_NAME(t0),
+=09REG_OFFSET_NAME(t1),
+=09REG_OFFSET_NAME(t2),
+=09REG_OFFSET_NAME(s0),
+=09REG_OFFSET_NAME(s1),
+=09REG_OFFSET_NAME(a0),
+=09REG_OFFSET_NAME(a1),
+=09REG_OFFSET_NAME(a2),
+=09REG_OFFSET_NAME(a3),
+=09REG_OFFSET_NAME(a4),
+=09REG_OFFSET_NAME(a5),
+=09REG_OFFSET_NAME(a6),
+=09REG_OFFSET_NAME(a7),
+=09REG_OFFSET_NAME(s2),
+=09REG_OFFSET_NAME(s3),
+=09REG_OFFSET_NAME(s4),
+=09REG_OFFSET_NAME(s5),
+=09REG_OFFSET_NAME(s6),
+=09REG_OFFSET_NAME(s7),
+=09REG_OFFSET_NAME(s8),
+=09REG_OFFSET_NAME(s9),
+=09REG_OFFSET_NAME(s10),
+=09REG_OFFSET_NAME(s11),
+=09REG_OFFSET_NAME(t3),
+=09REG_OFFSET_NAME(t4),
+=09REG_OFFSET_NAME(t5),
+=09REG_OFFSET_NAME(t6),
+=09REG_OFFSET_NAME(sstatus),
+=09REG_OFFSET_NAME(sbadaddr),
+=09REG_OFFSET_NAME(scause),
+=09REG_OFFSET_NAME(orig_a0),
+=09REG_OFFSET_END,
+};
+
+/**
+ * regs_query_register_offset() - query register offset from its name
+ * @name:=09the name of a register
+ *
+ * regs_query_register_offset() returns the offset of a register in struct
+ * pt_regs from its name. If the name is invalid, this returns -EINVAL;
+ */
+int regs_query_register_offset(const char *name)
+{
+=09const struct pt_regs_offset *roff;
+
+=09for (roff =3D regoffset_table; roff->name; roff++)
+=09=09if (!strcmp(roff->name, name))
+=09=09=09return roff->offset;
+=09return -EINVAL;
+}
+
+/**
+ * regs_within_kernel_stack() - check the address in the stack
+ * @regs:      pt_regs which contains kernel stack pointer.
+ * @addr:      address which is checked.
+ *
+ * regs_within_kernel_stack() checks @addr is within the kernel stack page=
(s).
+ * If @addr is within the kernel stack, it returns true. If not, returns f=
alse.
+ */
+static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long a=
ddr)
+{
+=09return (addr & ~(THREAD_SIZE - 1))  =3D=3D
+=09=09(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1));
+}
+
+/**
+ * regs_get_kernel_stack_nth() - get Nth entry of the stack
+ * @regs:=09pt_regs which contains kernel stack pointer.
+ * @n:=09=09stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack whi=
ch
+ * is specified by @regs. If the @n th entry is NOT in the kernel stack,
+ * this returns 0.
+ */
+unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int=
 n)
+{
+=09unsigned long *addr =3D (unsigned long *)kernel_stack_pointer(regs);
+
+=09addr +=3D n;
+=09if (regs_within_kernel_stack(regs, (unsigned long)addr))
+=09=09return *addr;
+=09else
+=09=09return 0;
+}
+
 void ptrace_disable(struct task_struct *child)
 {
 =09clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
--=20
2.24.0.rc0

--8323329-214833690-1574375536=:5296--
