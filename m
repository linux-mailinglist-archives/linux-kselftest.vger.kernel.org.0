Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7576C26E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 03:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjHBBq4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 21:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjHBBqz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 21:46:55 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA9294;
        Tue,  1 Aug 2023 18:46:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b974031aeaso97925271fa.0;
        Tue, 01 Aug 2023 18:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690940812; x=1691545612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsKmz+eFUseyOKOPFhHpD42XS/KyMD4dBoKs0nMOLag=;
        b=qZ1PxoU6psOoiqgWciXycfTg7aRkhjzQINjFhE8vrzCJb/acfBSQyviRScHN2RW4Nd
         yTMYCYLXT16fZmikAhihVP2s9ZtEwBX0zz5MsZTS4fNws4FoR1vOAXeJkhIH6BmCZgwx
         UDFuKeKMMuezMHadiYghS7cF6em50lYSuq/KuUFWwx31vjk0I/IQVMhkm+yj209IYDoJ
         uL0bIqwj5UJ/UXzLat8kXw6zton6VpByLjwtE+ej0aJ3gryxMqipzjpnyazeuMasqnLH
         yFtjzU2UQ+ikvpI2Fz/1FYnvvQb7QOPBaowdmritXeVpFPBCLtfRhh8rKWKUb13t1lgM
         YJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690940812; x=1691545612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsKmz+eFUseyOKOPFhHpD42XS/KyMD4dBoKs0nMOLag=;
        b=CZEdUuBdJp9TL7gvicWwhtl3OkZ7b3lvMcQqluu0B5BbfjCq0hFj9Bgk62MGTB5cTo
         Z/viAdHqJP4a56lGajc+Fu/0sdnTZ6iwoM0D1On6wQUueDSp5+YLVWtasH6n/pbyKIJD
         kMiypcWL7LqzKJ3FQ0qKYmF8ySKqKK+kNSDxaNfdtPtO0p+78ZHf9HaROHFurDapEazt
         W5721ms2ZZVny89TtK0wH0nwkP1x3STkmRle9g/tI7rbxEZckZjHc4T3NGnf3Pz/hwhv
         SXQkbjV+1tGqoc33yMU1zILPSP1fEOYmE++6a3U+RsKpcQWUulpbeJVxU8EffRjwlo2U
         8jDw==
X-Gm-Message-State: ABy/qLZe/WKdCllWA0g+kzjN3tqz6qErSh4znWTsZ0ks4NUbDbi5YcJJ
        CazYSqWnUVEF1Y5S84Zivj1+rldxMrMPD9l4WBk=
X-Google-Smtp-Source: APBJJlGpyW4icM5vduUDmRPyj4J0OKEZQ1GS7gn8mocY4HjaKL/EDbWZm1gkZYGYFt/8z3LfnCwUmTTOXg7llJFGfHk=
X-Received: by 2002:a2e:8e92:0:b0:2b9:edcd:8770 with SMTP id
 z18-20020a2e8e92000000b002b9edcd8770mr4011571ljk.43.1690940811662; Tue, 01
 Aug 2023 18:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690364259.git.haibo1.xu@intel.com> <7e9d2d5518375083f10c92a3d1acd98914f69fd8.1690364259.git.haibo1.xu@intel.com>
 <20230728-21d0e3ecb0d8916fd9d9bceb@orel>
In-Reply-To: <20230728-21d0e3ecb0d8916fd9d9bceb@orel>
From:   Haibo Xu <xiaobo55x@gmail.com>
Date:   Wed, 2 Aug 2023 09:46:40 +0800
Message-ID: <CAJve8o=jukVQ96uUKYwA=TOQyJngj9rGOZGYWo+bGWd_LOC=0g@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: riscv: selftests: Add exception handling support
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Colton Lewis <coltonlewis@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 5:37=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Jul 27, 2023 at 03:20:06PM +0800, Haibo Xu wrote:
> > Add the infrastructure for exception handling in riscv selftests.
> > Currently, the guest_unexp_trap handler was used by default, which
> > aborts the test. Customized handlers can be enabled by calling
> > vm_install_exception_handler(vector) or vm_install_interrupt_handler().
> >
> > The code is inspired from that of x86/arm64.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/Makefile          |   1 +
> >  .../selftests/kvm/include/riscv/processor.h   |  49 +++++++++
> >  .../selftests/kvm/lib/riscv/handlers.S        | 101 ++++++++++++++++++
> >  .../selftests/kvm/lib/riscv/processor.c       |  57 ++++++++++
> >  4 files changed, 208 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S
> >
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selft=
ests/kvm/Makefile
> > index c692cc86e7da..70f3a5ba991e 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -52,6 +52,7 @@ LIBKVM_s390x +=3D lib/s390x/diag318_test_handler.c
> >  LIBKVM_s390x +=3D lib/s390x/processor.c
> >  LIBKVM_s390x +=3D lib/s390x/ucall.c
> >
> > +LIBKVM_riscv +=3D lib/riscv/handlers.S
> >  LIBKVM_riscv +=3D lib/riscv/processor.c
> >  LIBKVM_riscv +=3D lib/riscv/ucall.c
> >
> > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/to=
ols/testing/selftests/kvm/include/riscv/processor.h
> > index d00d213c3805..9ea6e7bedc61 100644
> > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > @@ -9,6 +9,7 @@
> >
> >  #include "kvm_util.h"
> >  #include <linux/stringify.h>
> > +#include <asm/csr.h>
> >
> >  static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
> >                                   uint64_t  size)
> > @@ -38,6 +39,54 @@ static inline uint64_t __kvm_reg_id(uint64_t type, u=
int64_t idx,
> >                                            KVM_REG_RISCV_TIMER_REG(name=
), \
> >                                            KVM_REG_SIZE_U64)
> >
> > +struct ex_regs {
> > +     unsigned long ra;
> > +     unsigned long sp;
> > +     unsigned long gp;
> > +     unsigned long tp;
> > +     unsigned long t0;
> > +     unsigned long t1;
> > +     unsigned long t2;
> > +     unsigned long s0;
> > +     unsigned long s1;
> > +     unsigned long a0;
> > +     unsigned long a1;
> > +     unsigned long a2;
> > +     unsigned long a3;
> > +     unsigned long a4;
> > +     unsigned long a5;
> > +     unsigned long a6;
> > +     unsigned long a7;
> > +     unsigned long s2;
> > +     unsigned long s3;
> > +     unsigned long s4;
> > +     unsigned long s5;
> > +     unsigned long s6;
> > +     unsigned long s7;
> > +     unsigned long s8;
> > +     unsigned long s9;
> > +     unsigned long s10;
> > +     unsigned long s11;
> > +     unsigned long t3;
> > +     unsigned long t4;
> > +     unsigned long t5;
> > +     unsigned long t6;
> > +     unsigned long epc;
> > +     unsigned long status;
> > +     unsigned long cause;
> > +};
> > +
> > +#define VECTOR_NUM  2
> > +#define EC_NUM  32
> > +#define EC_MASK  (EC_NUM - 1)
>
> nit: My personal preference is to use something like NR_VECTORS and
> NR_EXCEPTIONS for these, since *_NUM type names are ambiguous with
> named indices.
>
> > +
> > +void vm_init_trap_vector_tables(struct kvm_vm *vm);
> > +void vcpu_init_trap_vector_tables(struct kvm_vcpu *vcpu);
>
> I think we should use a common name for these prototypes that the other
> architectures agree to and then put them in a common header. My vote for
> the naming is,
>
>   void vm_init_vector_tables(struct kvm_vm *vm);
>   void vcpu_init_vector_tables(struct kvm_vcpu *vcpu);
>
> > +
> > +typedef void(*handler_fn)(struct ex_regs *);
> > +void vm_install_exception_handler(struct kvm_vm *vm, int ec, handler_f=
n handler);
>
> I'd also put this typedef and prototype in a common header
> (with s/ec/vector/ to what you have here)
>
> > +void vm_install_interrupt_handler(struct kvm_vm *vm, handler_fn handle=
r);
>
> I guess this one can stay risc-v specific for now since no other arch is
> using it.
>
> > +
> >  /* L3 index Bit[47:39] */
> >  #define PGTBL_L3_INDEX_MASK                  0x0000FF8000000000ULL
> >  #define PGTBL_L3_INDEX_SHIFT                 39
> > diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/t=
esting/selftests/kvm/lib/riscv/handlers.S
> > new file mode 100644
> > index 000000000000..ce0b1d5415b9
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
> > @@ -0,0 +1,101 @@
> > +// SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2023 Intel Corporation
> > + */
> > +
> > +#include <asm/csr.h>
>
> General note for all the asm below, please format with the first operand
> aligned, so
>
> <tab>op<tab>operand1, operand2, ...
>
> > +
> > +.macro save_context
> > +     addi sp, sp, (-8*34)
> > +
> > +     sd x1, 0(sp)
> > +     sd x2, 8(sp)
> > +     sd x3, 16(sp)
> > +     sd x4, 24(sp)
> > +     sd x5, 32(sp)
> > +     sd x6, 40(sp)
> > +     sd x7, 48(sp)
> > +     sd x8, 56(sp)
> > +     sd x9, 64(sp)
> > +     sd x10, 72(sp)
> > +     sd x11, 80(sp)
> > +     sd x12, 88(sp)
> > +     sd x13, 96(sp)
> > +     sd x14, 104(sp)
> > +     sd x15, 112(sp)
> > +     sd x16, 120(sp)
> > +     sd x17, 128(sp)
> > +     sd x18, 136(sp)
> > +     sd x19, 144(sp)
> > +     sd x20, 152(sp)
> > +     sd x21, 160(sp)
> > +     sd x22, 168(sp)
> > +     sd x23, 176(sp)
> > +     sd x24, 184(sp)
> > +     sd x25, 192(sp)
> > +     sd x26, 200(sp)
> > +     sd x27, 208(sp)
> > +     sd x28, 216(sp)
> > +     sd x29, 224(sp)
> > +     sd x30, 232(sp)
> > +     sd x31, 240(sp)
> > +
> > +     csrr s0, CSR_SEPC
> > +     csrr s1, CSR_SSTATUS
> > +     csrr s2, CSR_SCAUSE
> > +     sd s0, 248(sp)
> > +     sd s1, 256(sp)
> > +     sd s2, 264(sp)
> > +.endm
>
> Let's create a restore_context macro too in order to maintain balance.
>
> > +
> > +.balign 4
> > +.global exception_vectors
> > +exception_vectors:
> > +     save_context
> > +     move a0, sp
> > +     la ra, ret_from_exception
> > +     tail route_exception
> > +
> > +.global ret_from_exception
> > +ret_from_exception:
> > +     ld s2, 264(sp)
> > +     ld s1, 256(sp)
> > +     ld s0, 248(sp)
> > +     csrw CSR_SCAUSE, s2
> > +     csrw CSR_SSTATUS, s1
> > +     csrw CSR_SEPC, s0
> > +
> > +     ld x31, 240(sp)
> > +     ld x30, 232(sp)
> > +     ld x29, 224(sp)
> > +     ld x28, 216(sp)
> > +     ld x27, 208(sp)
> > +     ld x26, 200(sp)
> > +     ld x25, 192(sp)
> > +     ld x24, 184(sp)
> > +     ld x23, 176(sp)
> > +     ld x22, 168(sp)
> > +     ld x21, 160(sp)
> > +     ld x20, 152(sp)
> > +     ld x19, 144(sp)
> > +     ld x18, 136(sp)
> > +     ld x17, 128(sp)
> > +     ld x16, 120(sp)
> > +     ld x15, 112(sp)
> > +     ld x14, 104(sp)
> > +     ld x13, 96(sp)
> > +     ld x12, 88(sp)
> > +     ld x11, 80(sp)
> > +     ld x10, 72(sp)
> > +     ld x9, 64(sp)
> > +     ld x8, 56(sp)
> > +     ld x7, 48(sp)
> > +     ld x6, 40(sp)
> > +     ld x5, 32(sp)
> > +     ld x4, 24(sp)
> > +     ld x3, 16(sp)
> > +     ld x2, 8(sp)
> > +     ld x1, 0(sp)
> > +
> > +     addi sp, sp, (8*34)
> > +     sret
> > diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/=
testing/selftests/kvm/lib/riscv/processor.c
> > index d146ca71e0c0..f1b0be58a5dc 100644
> > --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> > @@ -13,6 +13,8 @@
> >
> >  #define DEFAULT_RISCV_GUEST_STACK_VADDR_MIN  0xac0000
> >
> > +static vm_vaddr_t exception_handlers;
> > +
> >  static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
> >  {
> >       return (v + vm->page_size) & ~(vm->page_size - 1);
> > @@ -367,3 +369,58 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned=
 int num, ...)
> >  void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
> >  {
> >  }
> > +
> > +struct handlers {
> > +     handler_fn exception_handlers[VECTOR_NUM][EC_NUM];
> > +};
> > +
> > +void route_exception(struct ex_regs *regs)
> > +{
> > +     struct handlers *handlers =3D (struct handlers *)exception_handle=
rs;
> > +     int vector =3D 0, ec;
> > +
> > +     ec =3D regs->cause & ~CAUSE_IRQ_FLAG;
> > +     if (ec >=3D EC_NUM)
> > +             goto guest_unexpected_trap;
> > +
> > +     /* Use the same handler for all the interrupts */
> > +     if (regs->cause & CAUSE_IRQ_FLAG) {
> > +             vector =3D 1;
> > +             ec =3D 0;
> > +     }
> > +
> > +     if (handlers && handlers->exception_handlers[vector][ec])
> > +             return handlers->exception_handlers[vector][ec](regs);
> > +
> > +guest_unexpected_trap:
> > +     return guest_unexp_trap();
>
> I think we want this to have consistent behavior with the other
> architectures, so we should be issuing a UCALL_UNHANDLED.
>
> > +}
> > +
> > +void vcpu_init_trap_vector_tables(struct kvm_vcpu *vcpu)
> > +{
> > +     extern char exception_vectors;
> > +
> > +     vcpu_set_reg(vcpu, RISCV_CSR_REG(stvec), (unsigned long)&exceptio=
n_vectors);
> > +}
> > +
> > +void vm_init_trap_vector_tables(struct kvm_vm *vm)
> > +{
> > +     vm->handlers =3D __vm_vaddr_alloc(vm, sizeof(struct handlers),
> > +                                vm->page_size, MEM_REGION_DATA);
> > +
> > +     *(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)=
) =3D vm->handlers;
> > +}
> > +
> > +void vm_install_exception_handler(struct kvm_vm *vm, int ec, void (*ha=
ndler)(struct ex_regs *))
> > +{
> > +     struct handlers *handlers =3D addr_gva2hva(vm, vm->handlers);
> > +
>
> Add assert here that ec is valid.
>
> > +     handlers->exception_handlers[0][ec] =3D handler;
> > +}
> > +
> > +void vm_install_interrupt_handler(struct kvm_vm *vm, void (*handler)(s=
truct ex_regs *))
> > +{
> > +     struct handlers *handlers =3D addr_gva2hva(vm, vm->handlers);
> > +
> > +     handlers->exception_handlers[1][0] =3D handler;
> > +}
> > --
> > 2.34.1
> >
>
> Besides some nits and wanting to get more consistency with the other
> architectures, this looks good to me.
>

Thanks for the review! Will fix them in v2.

> Thanks,
> drew
