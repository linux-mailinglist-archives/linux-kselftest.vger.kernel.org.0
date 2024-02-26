Return-Path: <linux-kselftest+bounces-5426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F4F8669B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 06:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B871C21476
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 05:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767DA1B81C;
	Mon, 26 Feb 2024 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1uakqmO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325218B1A;
	Mon, 26 Feb 2024 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708926478; cv=none; b=t6W8Bj82fVOPHyk+ODRArWvG4heL6iWBkeVnKXqoEljJRSqQ2fnEiihl35KSXfN4BsW3c0I/Loyg58XtxsyRTeOM8mZ+YxI/hcVXNOjJF899bZZnllVXWTeS5flNNGSdxtaJvr12VV9678PWQeN5gET3XjL6LNE7OdMfNgkIbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708926478; c=relaxed/simple;
	bh=K5EhxfTyAeXjdOEJjG8brOnAyWwyn43VJQUtjt5uYys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6vQM+7uPv0HX2FUHsCMe4KNAMl1ZPE58Y5frE2j1O2dYzRyJN9SPSRrjWtJYATzWA/KoicnWBn4NAvxsgpTMg7FOiUeEzetPBr1wFYnqsmA1DuLEIG3O6i/1Bs03d+FavabA40XjXksawMWvJhRboJHH6WrL7WlOW8HOgueYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1uakqmO; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512be9194b7so2368089e87.1;
        Sun, 25 Feb 2024 21:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708926474; x=1709531274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9AaAZqwaMM3hlPPn5OnhezHOMjAT7L8+u/HDWjjaS8=;
        b=b1uakqmO/D2CzoQVU8ZPt+TwplksCa7+wYDn+eiQqiN3OhvCwJikDOT4JPayv9c/mt
         s+wNJwD1oVw5cThMRS4wyjYBfCDmJsIJsDLtyul/pnLv3GUdlQQI4JbuSORY85ONxAWq
         pZIvkKJSxdCtZPj9CawjvXWH1pF6I6LkHeNndUYGB+xno6EMxGYgPb1ftut5MKFq7ksr
         T90kYlTC3NJVvm2R6LIKEC3NdKikW/SVjsB7a2eDA/io5dw9SVH8IhP050HY8qA97oFr
         uRYoCasRfwJuIk7YImF7KL43vVlKGdxg1ebuT7VjJ3tkFv/uecg49M+0+4vQEb8Iza7a
         iFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708926474; x=1709531274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9AaAZqwaMM3hlPPn5OnhezHOMjAT7L8+u/HDWjjaS8=;
        b=s8hc2woXJGj7SSxZuPl92ENFh3lG1xKr7nUe5xtirt+2ROlGQJ0oE5t5nt2DSJFsoH
         EEipTqIe0ZKNp+Ud7PUI0Rx8GRX8OIab33fPHX2bejYb86vhkGcltOzHkz68WIcemAEV
         0KIh9E0DtZTJLu0wFmoreNt0FIhMdovnGDPucIGhBF7fVfVLWaUBMcGoiO78Gyn5O8iG
         DhzOP1uGb2P6AXIC/CwOFjck7B3UYA+t0vADXIVgBq+BdlC5AIY/sClcdzX/jStVzwwx
         PrHNEA2e6HwvuNSKS9fuVmlKDm05HIgisPlNpt58xWTfyF0dpzV/lHI9LVG8QVcz+qqp
         y6uA==
X-Forwarded-Encrypted: i=1; AJvYcCUrueDtqdaoNfjrVLKN6n9ioofogRBm59IOS2jqsX3CDn6d2dYIcXb5m5+o5UmzdsrYaNACgYLvRr5ACAaf6jJymKhBZdvCLJHpu3IBct7623wl6TljDrtXScba8EZi4lX6FF/N5JJrRpTh8mDodGWpNBPkLX8B+cdWV6RAtFl1I/0D
X-Gm-Message-State: AOJu0YyCXrmBXgMeQmPAyBd3KVMtlO9fIMhiI1uuXZKqZh11Yp/z3b4f
	wzgbbgLwvT714fIrhIMByLFzHlEpHmyI66eFFrpPCaJHs3hi3Fu+WUT2obG8HtCZQ5394p8GX+T
	zNSiIrWY1WaO8FlXAh3ejSCS8ATU=
X-Google-Smtp-Source: AGHT+IFxFgCdVShdGgyihbmMGEdbb3FMU62WepRd4W/KTlGzWNAcQNvEg4IXZJAq58ExfevYjpOnAjGeQM4aCs7o1so=
X-Received: by 2002:a05:6512:314d:b0:512:e1e3:cd2c with SMTP id
 s13-20020a056512314d00b00512e1e3cd2cmr2961307lfi.69.1708926474284; Sun, 25
 Feb 2024 21:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705916069.git.haibo1.xu@intel.com> <68856b86a93a4188558e5d0ebac0dd6aac8e404c.1705916069.git.haibo1.xu@intel.com>
 <CAOnJCULwRTSnrQkR2o1P53R=tJ3TAxX+y+XRBesW6OFEzgFv2g@mail.gmail.com>
 <CAJve8om2oOLg5-wKX7m7cBTgzwqiMcb35x=nDi1edY8evXjyMw@mail.gmail.com>
 <2c96c61a-2685-4cee-9cef-963ed833bf92@rivosinc.com> <CAAhSdy2TVSt=gCJRf78AzXNVFKy8MGJ+QspSEHeedT7GPAYkUQ@mail.gmail.com>
In-Reply-To: <CAAhSdy2TVSt=gCJRf78AzXNVFKy8MGJ+QspSEHeedT7GPAYkUQ@mail.gmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Mon, 26 Feb 2024 13:47:42 +0800
Message-ID: <CAJve8onL5YB2w6duAr2H=8yJMh=SPsZCvgu+suhd=9U1_egHOg@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] KVM: riscv: selftests: Change vcpu_has_ext to a
 common function
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atishp@rivosinc.com>, Atish Patra <atishp@atishpatra.org>, 
	Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Guo Ren <guoren@kernel.org>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Samuel Holland <samuel@sholland.org>, Minda Chen <minda.chen@starfivetech.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Sean Christopherson <seanjc@google.com>, Peter Xu <peterx@redhat.com>, 
	Like Xu <likexu@tencent.com>, Vipin Sharma <vipinsh@google.com>, Thomas Huth <thuth@redhat.com>, 
	Aaron Lewis <aaronlewis@google.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 1:20=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Wed, Feb 21, 2024 at 2:07=E2=80=AFPM Atish Patra <atishp@rivosinc.com>=
 wrote:
> >
> > On 2/20/24 18:13, Haibo Xu wrote:
> > > On Wed, Feb 21, 2024 at 7:03=E2=80=AFAM Atish Patra <atishp@atishpatr=
a.org> wrote:
> > >>
> > >> On Mon, Jan 22, 2024 at 1:48=E2=80=AFAM Haibo Xu <haibo1.xu@intel.co=
m> wrote:
> > >>>
> > >>> Move vcpu_has_ext to the processor.c and rename it to __vcpu_has_ex=
t
> > >>> so that other test cases can use it for vCPU extension check.
> > >>>
> > >>> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > >>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > >>> ---
> > >>>   tools/testing/selftests/kvm/include/riscv/processor.h |  2 ++
> > >>>   tools/testing/selftests/kvm/lib/riscv/processor.c     | 10 ++++++=
++++
> > >>>   tools/testing/selftests/kvm/riscv/get-reg-list.c      | 11 +-----=
-----
> > >>>   3 files changed, 13 insertions(+), 10 deletions(-)
> > >>>
> > >>> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h =
b/tools/testing/selftests/kvm/include/riscv/processor.h
> > >>> index b68b1b731a34..bd27e1c67579 100644
> > >>> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > >>> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > >>> @@ -42,6 +42,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type=
, uint64_t idx,
> > >>>   #define RISCV_ISA_EXT_REG(idx) __kvm_reg_id(KVM_REG_RISCV_ISA_EXT=
, \
> > >>>                                               idx, KVM_REG_SIZE_ULO=
NG)
> > >>>
> > >>> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
> > >>> +
> > >>>   struct ex_regs {
> > >>>          unsigned long ra;
> > >>>          unsigned long sp;
> > >>> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/to=
ols/testing/selftests/kvm/lib/riscv/processor.c
> > >>> index 39a1e9902dec..dad73ce18164 100644
> > >>> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> > >>> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> > >>> @@ -15,6 +15,16 @@
> > >>>
> > >>>   static vm_vaddr_t exception_handlers;
> > >>>
> > >>> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > >>> +{
> > >>> +       unsigned long value =3D 0;
> > >>> +       int ret;
> > >>> +
> > >>> +       ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value=
);
> > >>> +
> > >>> +       return !ret && !!value;
> > >>> +}
> > >>> +
> > >>
> > >> Not sure what was the base patch on which this was rebased. The actu=
al
> > >> commit in the queue branch looks different.
> > >>
> > >
> > > This patch set was based on 6.7-rc8.
> > >
> > >> https://github.com/kvm-riscv/linux/commit/5563517cc2012e3326411b360c=
9924d3f2706c8d
> > >>
> > >> Both seem to have the same bug though the tests fail now and require
> > >> the following fix.
> > >> The ext id should be uint64_t and we need to pass ext directly so th=
at
> > >> SBI extension tests can also pass.
> > >>
> > >
> > > It's weird that 6.7-rc8 has already included Andrew's change on the I=
SA ext reg,
> > > but this patch was not generated against his change.
> > >
> > > commit bdf6aa328f137e184b0fce607fd585354c3742f1
> > > Author: Andrew Jones <ajones@ventanamicro.com>
> > > Date:   Wed Dec 13 18:09:58 2023 +0100
> > >
> > >      RISC-V: KVM: selftests: Treat SBI ext regs like ISA ext regs
> > >
> > > Anyway, your changes were right. Please go ahead to include them when=
 merging.
> > >
> >
> > I am not sure what happened. Probably, a merge conflict issue.
> >
> > I just realized I forgot to copy paste another fix in arch timer
> >
> > +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> > @@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
> >          int nr_vcpus =3D test_args.nr_vcpus;
> >
> >          vm =3D vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> > -       __TEST_REQUIRE(__vcpu_has_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC)=
,
> > +       __TEST_REQUIRE(__vcpu_has_ext(vcpus[0],
> > RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSTC)),
>
> I have squashed this change into an existing commit in riscv_kvm_queue.
>
> Thanks,
> Anup
>

Thanks a lot, Anup!

> >
> >
> > > Thanks,
> > > Haibo
> > >
> > >>
> > >> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > >> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > >> @@ -48,7 +48,7 @@ static inline uint64_t __kvm_reg_id(uint64_t type,
> > >> uint64_t subtype,
> > >> KVM_REG_RISCV_SBI_SINGLE, \
> > >> idx, KVM_REG_SIZE_ULONG)
> > >>
> > >> -bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
> > >> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
> > >>
> > >> struct ex_regs {
> > >> unsigned long ra;
> > >> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c
> > >> b/tools/testing/selftests/kvm/lib/riscv/processor.c
> > >> index 282587cd4bbc..ec66d331a127 100644
> > >> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> > >> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> > >> @@ -15,12 +15,12 @@
> > >>
> > >> static vm_vaddr_t exception_handlers;
> > >>
> > >> -bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > >> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext)
> > >> {
> > >> unsigned long value =3D 0;
> > >> int ret;
> > >>
> > >> - ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> > >> + ret =3D __vcpu_get_reg(vcpu, ext, &value);
> > >>
> > >> return !ret && !!value;
> > >> }
> > >>
> > >> With the above the fix, Both SBI/ISA extension tests pass.
> > >> # ./get-reg-list
> > >> sbi-base: PASS
> > >> sbi-sta: PASS
> > >> sbi-pmu: PASS
> > >> sbi-dbcn: PASS
> > >> aia: PASS
> > >> fp_f: PASS
> > >> fp_d: PASS
> > >> 1..0 # SKIP - h not available, skipping tests
> > >> smstateen: PASS
> > >> sscofpmf: PASS
> > >> sstc: PASS
> > >> 1..0 # SKIP - svinval not available, skipping tests
> > >> 1..0 # SKIP - svnapot not available, skipping tests
> > >> 1..0 # SKIP - svpbmt not available, skipping tests
> > >> zba: PASS
> > >> zbb: PASS
> > >> zbc: PASS
> > >> 1..0 # SKIP - zbkb not available, skipping tests
> > >> 1..0 # SKIP - zbkc not available, skipping tests
> > >> 1..0 # SKIP - zbkx not available, skipping tests
> > >> zbs: PASS
> > >> zfa: PASS
> > >> 1..0 # SKIP - zfh not available, skipping tests
> > >> 1..0 # SKIP - zfhmin not available, skipping tests
> > >> zicbom: PASS
> > >> zicboz: PASS
> > >> zicntr: PASS
> > >> 1..0 # SKIP - zicond not available, skipping tests
> > >> zicsr: PASS
> > >> zifencei: PASS
> > >> zihintntl: PASS
> > >> zihintpause: PASS
> > >> zihpm: PASS
> > >>
> > >>
> > >>>   static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
> > >>>   {
> > >>>          return (v + vm->page_size) & ~(vm->page_size - 1);
> > >>> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/too=
ls/testing/selftests/kvm/riscv/get-reg-list.c
> > >>> index 25de4b8bc347..ed29ba45588c 100644
> > >>> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > >>> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > >>> @@ -75,15 +75,6 @@ bool check_reject_set(int err)
> > >>>          return err =3D=3D EINVAL;
> > >>>   }
> > >>>
> > >>> -static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > >>> -{
> > >>> -       int ret;
> > >>> -       unsigned long value;
> > >>> -
> > >>> -       ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value=
);
> > >>> -       return (ret) ? false : !!value;
> > >>> -}
> > >>> -
> > >>>   void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c=
)
> > >>>   {
> > >>>          unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] =3D { 0=
 };
> > >>> @@ -111,7 +102,7 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struc=
t vcpu_reg_list *c)
> > >>>                  __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(s->feature)=
, 1);
> > >>>
> > >>>                  /* Double check whether the desired extension was =
enabled */
> > >>> -               __TEST_REQUIRE(vcpu_has_ext(vcpu, s->feature),
> > >>> +               __TEST_REQUIRE(__vcpu_has_ext(vcpu, s->feature),
> > >>>                                 "%s not available, skipping tests\n=
", s->name);
> > >>>          }
> > >>>   }
> > >>> --
> > >>> 2.34.1
> > >>>
> > >>
> > >>
> > >> --
> > >> Regards,
> > >> Atish
> >

