Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80450109E3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 13:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfKZMsU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 07:48:20 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45771 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZMsU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 07:48:20 -0500
Received: by mail-qt1-f196.google.com with SMTP id 30so21208853qtz.12
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2019 04:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yP69oNOwLRKOH1bABrCf+MIfhE/Or+bR3PI8UIEOa8o=;
        b=TCsnvbwhQ0FDfWbBUgMkKruo7ZhMBrB3n6VB+8IASb0zgRXk7/OC4pm3O9SZwQEbRI
         MlDLR9D0gFOCjEp5/WO9Z+nxkj1UkwIZnIUbMRDkPi8ycAsWS2EUvPkI0cSk5VcoYsJU
         2dMoe6j2ZrjkeYTMfqB8jF7Lxsc+tIjuq6sQw4rKBxq6FLEV15DW/CgrI/zlHqdygDST
         wWUupAtODBDahuotMQPG++lLM7Oubu7X6nLJGk81oAyVamouYvjl6e+3PMNoZ0fJQFsK
         smelWZCAkxzBBfMJY1yFeJuo20IvSV9DIkxr/Cn39LNV6KgYScwogregcpfGjl5ob/oN
         1Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yP69oNOwLRKOH1bABrCf+MIfhE/Or+bR3PI8UIEOa8o=;
        b=bPCycc/TitXFt8Fnp0S9Ve1w37fbAiF8ZuVrA4l8m0R51SLQu2cG80BfuFq9aXnoTq
         An/SqSzXlxPPGyvNJLq5ZgnzKBmkw07qgZFOjrQudADi9KglZbxnHCloeClS/3vOuK4z
         XpARoyOyr8vjDakHJdPdemq5p2EK4Vhc1OqA+h+2huAM+NW0KI1wKWwUG/o73RYNr6YH
         7FvR0/jAJlpp5He99PHTJHMAqCzr0d4xlf3X3k1D8umAci+MOgM1R1ZN2Aps20PzDZSD
         v8OHCUkGsPp7sCL8SEQqJTDF4TpzRyOjoYplhyk66xsWWQlvvtEaxvcZGdQ0bOyzl5dB
         N/Fg==
X-Gm-Message-State: APjAAAXxIGjbqptUWvOOCglJJtTici76zAbe7m2nTXEb0LRSAiCgDlqi
        vRKC54ks5WLyoG1EOrKH1D6jJVJHH7YaKyrJOAnNSA==
X-Google-Smtp-Source: APXvYqxqg2YuiESg5BwxtiVVFsY0/lo513Z/1OkGS1LPpw/CVw6krDI+9lMssFWGO4qeB4L8nhIXJc7F5Lt+dZcKeiw=
X-Received: by 2002:ac8:7943:: with SMTP id r3mr35021510qtt.49.1574772499379;
 Tue, 26 Nov 2019 04:48:19 -0800 (PST)
MIME-Version: 1.0
References: <1572919114-3886-1-git-send-email-vincent.chen@sifive.com>
 <1572919114-3886-2-git-send-email-vincent.chen@sifive.com>
 <alpine.DEB.2.21.9999.1911211225350.30580@viisi.sifive.com> <alpine.DEB.2.21.9999.1911211418320.5296@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1911211418320.5296@viisi.sifive.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Tue, 26 Nov 2019 20:48:08 +0800
Message-ID: <CABvJ_xiWWGUGTJ36_4zN+RWhrTQn1bQTAsbFR-KaCSLcPy00pw@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: add required functions to enable HAVE_REGS_AND_STACK_ACCESS_API
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 22, 2019 at 6:32 AM Paul Walmsley <paul.walmsley@sifive.com> wr=
ote:
>
> On Thu, 21 Nov 2019, Paul Walmsley wrote:
>
> > As I understand it, this patch hasn't been signed off on by Patrick.
> > I've sent him an E-mail asking him whether he's willing to add his
> > Signed-off-by:, but haven't heard back from it.
> >
> > From our discussions, I understand that this patch is based partially o=
n
> > some of his earlier, public, kprobes work.  In lieu of any response fro=
m
> > Patrick, could you please resend this patch and just note in the commit
> > description that it's partially based on one of his patches, add a Link=
:
> > line that points to the URL of the patch that it's partially based on, =
and
> > replace the Signed-off-by: with a Co-developed-by: or something similar=
?
>
> OK - just looked at the patches more closely, and I think I see what's
> going on here.  This patch looks like a rebased version of this patch:
>
> https://lore.kernel.org/linux-riscv/20181113195804.22825-2-me@packi.ch/
>
> So let's just plan to use an updated version of Patrick's original
> (below).  Please let me know if you have any comments on it or if I
> missed something -
>
>
> - Paul
>

Dear Paul,
Due to the rule of mail classification, I do not find this mail in
time. I am sorry for that.
I think it is good for me.

Thanks and regards
Vincent


> From: Patrick St=C3=A4hlin <me@packi.ch>
> Date: Tue, 13 Nov 2018 20:58:03 +0100
> Subject: [PATCH] RISC-V: Implement ptrace regs and stack API
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Needed for kprobes support. Copied and adapted from arm64 code.
>
> Signed-off-by: Patrick St=C3=A4hlin <me@packi.ch>
> [paul.walmsley@sifive.com: updated to apply; fixed checkpatch issues;
>  fixed regs_get_register() kerneldoc]
> Cc: Vincent Chen <vincent.chen@sifive.com>
> Link: https://lore.kernel.org/linux-riscv/20181113195803.CjtBCsUcG9czwiqm=
PBGKUjvl5Ojxq2SIPaioQUHXFI0@z/
> Link: https://lore.kernel.org/linux-riscv/1572919114-3886-1-git-send-emai=
l-vincent.chen@sifive.com/T/#mdb346527d25ea1959ab57ff9d1c056bcd29c7172
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/ptrace.h | 30 ++++++++++
>  arch/riscv/kernel/ptrace.c      | 99 +++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8eebbc8860bb..d5bbf4223fd2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -61,6 +61,7 @@ config RISCV
>         select SPARSEMEM_STATIC if 32BIT
>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>         select HAVE_ARCH_MMAP_RND_BITS
> +       select HAVE_REGS_AND_STACK_ACCESS_API
>
>  config ARCH_MMAP_RND_BITS_MIN
>         default 18 if 64BIT
> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptr=
ace.h
> index d48d1e13973c..50d37b123a61 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -8,6 +8,7 @@
>
>  #include <uapi/asm/ptrace.h>
>  #include <asm/csr.h>
> +#include <linux/compiler.h>
>
>  #ifndef __ASSEMBLY__
>
> @@ -60,6 +61,7 @@ struct pt_regs {
>
>  #define user_mode(regs) (((regs)->sstatus & SR_SPP) =3D=3D 0)
>
> +#define MAX_REG_OFFSET offsetof(struct pt_regs, orig_a0)
>
>  /* Helpers for working with the instruction pointer */
>  static inline unsigned long instruction_pointer(struct pt_regs *regs)
> @@ -85,6 +87,12 @@ static inline void user_stack_pointer_set(struct pt_re=
gs *regs,
>         regs->sp =3D  val;
>  }
>
> +/* Valid only for Kernel mode traps. */
> +static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
> +{
> +       return regs->sp;
> +}
> +
>  /* Helpers for working with the frame pointer */
>  static inline unsigned long frame_pointer(struct pt_regs *regs)
>  {
> @@ -101,6 +109,28 @@ static inline unsigned long regs_return_value(struct=
 pt_regs *regs)
>         return regs->a0;
>  }
>
> +int regs_query_register_offset(const char *name);
> +unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
> +                                       unsigned int n);
> +
> +/**
> + * regs_get_register() - get register value from its offset
> + * @regs:      pt_regs from which register value is gotten
> + * @offset:    offset of the register.
> + *
> + * regs_get_register() returns the value from @regs of a register
> + * identified by @offset.  The @offset is the offset of the register
> + * in struct pt_regs.  If @offset is bigger than MAX_REG_OFFSET, this
> + * returns 0.
> + */
> +static inline unsigned long regs_get_register(struct pt_regs *regs,
> +                                             unsigned int offset)
> +{
> +       if (unlikely(offset > MAX_REG_OFFSET))
> +               return 0;
> +
> +       return *(unsigned long *)((unsigned long)regs + offset);
> +}
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_RISCV_PTRACE_H */
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 1252113ef8b2..5076b30fe18b 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -125,6 +125,105 @@ const struct user_regset_view *task_user_regset_vie=
w(struct task_struct *task)
>         return &riscv_user_native_view;
>  }
>
> +struct pt_regs_offset {
> +       const char *name;
> +       int offset;
> +};
> +
> +#define REG_OFFSET_NAME(r) {.name =3D #r, .offset =3D offsetof(struct pt=
_regs, r)}
> +#define REG_OFFSET_END {.name =3D NULL, .offset =3D 0}
> +
> +static const struct pt_regs_offset regoffset_table[] =3D {
> +       REG_OFFSET_NAME(sepc),
> +       REG_OFFSET_NAME(ra),
> +       REG_OFFSET_NAME(sp),
> +       REG_OFFSET_NAME(gp),
> +       REG_OFFSET_NAME(tp),
> +       REG_OFFSET_NAME(t0),
> +       REG_OFFSET_NAME(t1),
> +       REG_OFFSET_NAME(t2),
> +       REG_OFFSET_NAME(s0),
> +       REG_OFFSET_NAME(s1),
> +       REG_OFFSET_NAME(a0),
> +       REG_OFFSET_NAME(a1),
> +       REG_OFFSET_NAME(a2),
> +       REG_OFFSET_NAME(a3),
> +       REG_OFFSET_NAME(a4),
> +       REG_OFFSET_NAME(a5),
> +       REG_OFFSET_NAME(a6),
> +       REG_OFFSET_NAME(a7),
> +       REG_OFFSET_NAME(s2),
> +       REG_OFFSET_NAME(s3),
> +       REG_OFFSET_NAME(s4),
> +       REG_OFFSET_NAME(s5),
> +       REG_OFFSET_NAME(s6),
> +       REG_OFFSET_NAME(s7),
> +       REG_OFFSET_NAME(s8),
> +       REG_OFFSET_NAME(s9),
> +       REG_OFFSET_NAME(s10),
> +       REG_OFFSET_NAME(s11),
> +       REG_OFFSET_NAME(t3),
> +       REG_OFFSET_NAME(t4),
> +       REG_OFFSET_NAME(t5),
> +       REG_OFFSET_NAME(t6),
> +       REG_OFFSET_NAME(sstatus),
> +       REG_OFFSET_NAME(sbadaddr),
> +       REG_OFFSET_NAME(scause),
> +       REG_OFFSET_NAME(orig_a0),
> +       REG_OFFSET_END,
> +};
> +
> +/**
> + * regs_query_register_offset() - query register offset from its name
> + * @name:      the name of a register
> + *
> + * regs_query_register_offset() returns the offset of a register in stru=
ct
> + * pt_regs from its name. If the name is invalid, this returns -EINVAL;
> + */
> +int regs_query_register_offset(const char *name)
> +{
> +       const struct pt_regs_offset *roff;
> +
> +       for (roff =3D regoffset_table; roff->name; roff++)
> +               if (!strcmp(roff->name, name))
> +                       return roff->offset;
> +       return -EINVAL;
> +}
> +
> +/**
> + * regs_within_kernel_stack() - check the address in the stack
> + * @regs:      pt_regs which contains kernel stack pointer.
> + * @addr:      address which is checked.
> + *
> + * regs_within_kernel_stack() checks @addr is within the kernel stack pa=
ge(s).
> + * If @addr is within the kernel stack, it returns true. If not, returns=
 false.
> + */
> +static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long=
 addr)
> +{
> +       return (addr & ~(THREAD_SIZE - 1))  =3D=3D
> +               (kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1));
> +}
> +
> +/**
> + * regs_get_kernel_stack_nth() - get Nth entry of the stack
> + * @regs:      pt_regs which contains kernel stack pointer.
> + * @n:         stack entry number.
> + *
> + * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack w=
hich
> + * is specified by @regs. If the @n th entry is NOT in the kernel stack,
> + * this returns 0.
> + */
> +unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned i=
nt n)
> +{
> +       unsigned long *addr =3D (unsigned long *)kernel_stack_pointer(reg=
s);
> +
> +       addr +=3D n;
> +       if (regs_within_kernel_stack(regs, (unsigned long)addr))
> +               return *addr;
> +       else
> +               return 0;
> +}
> +
>  void ptrace_disable(struct task_struct *child)
>  {
>         clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
> --
> 2.24.0.rc0
