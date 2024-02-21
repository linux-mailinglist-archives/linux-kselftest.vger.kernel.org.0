Return-Path: <linux-kselftest+bounces-5114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDFD85CDC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44CE1F26750
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 02:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31A25235;
	Wed, 21 Feb 2024 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYuSwZmc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3A4C7E;
	Wed, 21 Feb 2024 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481603; cv=none; b=fHhvsNHP3Ps5fwF1cKOkE9M6p/1Sqx+HpG9YGPKezftb09CR82zOSP8hGJI28BgWU2ucK5JK/Mi7mRDMjFdhO0h8xyxdytZ0OMs4Xo4FiEApYXwZAS5dGeGdNzw0A7vBZhSQ18pi7+kNc+zZ6eywyQsyKbAadQzlPU419o8bGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481603; c=relaxed/simple;
	bh=VwMMVl1TDHBJEglnXRiz983bQqb39w+JHkpeXQTsGPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNsrdqajlgXDvaf2eKG3ea4mpwjKsf6zH5Yzxl0BDNv4CE41NYu5nhPJsO2eakd99SPeAGxyzmZiPRruCeGEdXDb/X4wqmqMpSTqYJCkdk5FB5Sucj1nDCIx8eN5LTNMyg5Ljkj7DBToH8yIK6dgY0/Gck/IOYTxVrJ9A4wWUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYuSwZmc; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso5200132e87.3;
        Tue, 20 Feb 2024 18:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708481600; x=1709086400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyL4+gid2LCVkf5A3UEC4DDd5q5l+TxrzdeM+WtCs/s=;
        b=LYuSwZmckOk46uGDqRs1PXLYiFDI1DBwTEIszXdHZTR+KrHx6xH3LGaDS6OOBMUQaY
         yPPTYEo4O7vFdAEcXuBaBJcNzohUQigLFScoajC9Zta02rAoMVmJGjGILa83x3v8KyJL
         8WP5DH4v0YpBDiUh9x65MCkejfusMrOsWQ690baVviZ8dCfiC0DS2c4BO9lYxqHJfOgl
         sMk5u0RCdsICPUqzeE180el8e6f6dAhi+hiehGxn0T0zYM7U62MkR9yH1fY8vnJ9mnrf
         0KcFv2MG01QJJM7uZCrNqvxCujM2IYm37AvWQt3DjXougKZWv4v223WiAGYQ6Hz2VwXo
         VyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708481600; x=1709086400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyL4+gid2LCVkf5A3UEC4DDd5q5l+TxrzdeM+WtCs/s=;
        b=qB+r3KTArnoHJwh29F80kgqdpe3fek59vl4WcTTFLI2r1Yh5YHvfYhhbDs3/TK9wmV
         aFAD8vXdR4watCSu5tjkQ4cu9juJQxaeg5L/raSe8PkowZu5FZt/ugfGEHW6kPwh9+fr
         lgl8YQEZGXWEczR1mbILXYLf9f4txuaPpZlD5+M3CmuZ1Nyr2UBQa9iTGmu1TBufyIu3
         ab022j+E5/AEvINicOZzJKHe2C+aaxiyxk9NUyVW/cq1cOkrV3iYOzKfkhT+MDvaWlyE
         60M5e42d41kry9l/Y3Ev0RAa9R9Xn+GuGJQP6WhZ+OL3A13ny4hqtZVfBjPsJUvKv8qc
         mtoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+oSO/irR+cvqh7K2Q24Rdu/QHrfjVavF+48VNYB/ZMmxYMxc29We6e+jjBYfMQWNOpUATUhgS8j3HgMsA8m3dLdOxMR7Rt6fX2TmNYrSBGm7jbULuc6WASv8aLeh067ibIUkMKbHvX1x3hGbtN/G+Eg0nOo+pwOR0uXOiKzZFu4Lr
X-Gm-Message-State: AOJu0YxbKQsyLGJRYrcnQU8hWCXrk2WIwZP79lejHqSCX/bNBYu+Ry4X
	0yzeYmWRgFDatjDjId2B0GyeYic+foi6Tv/FgHI3V9NQ8ghsmZyVgLgLHcTTWBrQa/HNLahM/Ye
	Yliep3ZBG1mEMthe4JvTmDxjMlJ0=
X-Google-Smtp-Source: AGHT+IHRdTziSrABqkKvSI9ZOcTbR2Q3vrcU+ABOUUUq5c2+ia7YA91JhISWBunQmlRCXavtuJjiR/cXOesvX0Bn5yk=
X-Received: by 2002:a05:6512:ba6:b0:512:bebf:1a with SMTP id
 b38-20020a0565120ba600b00512bebf001amr3977383lfv.57.1708481599992; Tue, 20
 Feb 2024 18:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705916069.git.haibo1.xu@intel.com> <68856b86a93a4188558e5d0ebac0dd6aac8e404c.1705916069.git.haibo1.xu@intel.com>
 <CAOnJCULwRTSnrQkR2o1P53R=tJ3TAxX+y+XRBesW6OFEzgFv2g@mail.gmail.com>
In-Reply-To: <CAOnJCULwRTSnrQkR2o1P53R=tJ3TAxX+y+XRBesW6OFEzgFv2g@mail.gmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Wed, 21 Feb 2024 10:13:08 +0800
Message-ID: <CAJve8om2oOLg5-wKX7m7cBTgzwqiMcb35x=nDi1edY8evXjyMw@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] KVM: riscv: selftests: Change vcpu_has_ext to a
 common function
To: Atish Patra <atishp@atishpatra.org>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>, 
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

On Wed, Feb 21, 2024 at 7:03=E2=80=AFAM Atish Patra <atishp@atishpatra.org>=
 wrote:
>
> On Mon, Jan 22, 2024 at 1:48=E2=80=AFAM Haibo Xu <haibo1.xu@intel.com> wr=
ote:
> >
> > Move vcpu_has_ext to the processor.c and rename it to __vcpu_has_ext
> > so that other test cases can use it for vCPU extension check.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  tools/testing/selftests/kvm/include/riscv/processor.h |  2 ++
> >  tools/testing/selftests/kvm/lib/riscv/processor.c     | 10 ++++++++++
> >  tools/testing/selftests/kvm/riscv/get-reg-list.c      | 11 +----------
> >  3 files changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/to=
ols/testing/selftests/kvm/include/riscv/processor.h
> > index b68b1b731a34..bd27e1c67579 100644
> > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > @@ -42,6 +42,8 @@ static inline uint64_t __kvm_reg_id(uint64_t type, ui=
nt64_t idx,
> >  #define RISCV_ISA_EXT_REG(idx) __kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
> >                                              idx, KVM_REG_SIZE_ULONG)
> >
> > +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
> > +
> >  struct ex_regs {
> >         unsigned long ra;
> >         unsigned long sp;
> > diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/=
testing/selftests/kvm/lib/riscv/processor.c
> > index 39a1e9902dec..dad73ce18164 100644
> > --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> > @@ -15,6 +15,16 @@
> >
> >  static vm_vaddr_t exception_handlers;
> >
> > +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > +{
> > +       unsigned long value =3D 0;
> > +       int ret;
> > +
> > +       ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> > +
> > +       return !ret && !!value;
> > +}
> > +
>
> Not sure what was the base patch on which this was rebased. The actual
> commit in the queue branch looks different.
>

This patch set was based on 6.7-rc8.

> https://github.com/kvm-riscv/linux/commit/5563517cc2012e3326411b360c9924d=
3f2706c8d
>
> Both seem to have the same bug though the tests fail now and require
> the following fix.
> The ext id should be uint64_t and we need to pass ext directly so that
> SBI extension tests can also pass.
>

It's weird that 6.7-rc8 has already included Andrew's change on the ISA ext=
 reg,
but this patch was not generated against his change.

commit bdf6aa328f137e184b0fce607fd585354c3742f1
Author: Andrew Jones <ajones@ventanamicro.com>
Date:   Wed Dec 13 18:09:58 2023 +0100

    RISC-V: KVM: selftests: Treat SBI ext regs like ISA ext regs

Anyway, your changes were right. Please go ahead to include them when mergi=
ng.

Thanks,
Haibo

>
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -48,7 +48,7 @@ static inline uint64_t __kvm_reg_id(uint64_t type,
> uint64_t subtype,
> KVM_REG_RISCV_SBI_SINGLE, \
> idx, KVM_REG_SIZE_ULONG)
>
> -bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext);
> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
>
> struct ex_regs {
> unsigned long ra;
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c
> b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index 282587cd4bbc..ec66d331a127 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -15,12 +15,12 @@
>
> static vm_vaddr_t exception_handlers;
>
> -bool __vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> +bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext)
> {
> unsigned long value =3D 0;
> int ret;
>
> - ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> + ret =3D __vcpu_get_reg(vcpu, ext, &value);
>
> return !ret && !!value;
> }
>
> With the above the fix, Both SBI/ISA extension tests pass.
> # ./get-reg-list
> sbi-base: PASS
> sbi-sta: PASS
> sbi-pmu: PASS
> sbi-dbcn: PASS
> aia: PASS
> fp_f: PASS
> fp_d: PASS
> 1..0 # SKIP - h not available, skipping tests
> smstateen: PASS
> sscofpmf: PASS
> sstc: PASS
> 1..0 # SKIP - svinval not available, skipping tests
> 1..0 # SKIP - svnapot not available, skipping tests
> 1..0 # SKIP - svpbmt not available, skipping tests
> zba: PASS
> zbb: PASS
> zbc: PASS
> 1..0 # SKIP - zbkb not available, skipping tests
> 1..0 # SKIP - zbkc not available, skipping tests
> 1..0 # SKIP - zbkx not available, skipping tests
> zbs: PASS
> zfa: PASS
> 1..0 # SKIP - zfh not available, skipping tests
> 1..0 # SKIP - zfhmin not available, skipping tests
> zicbom: PASS
> zicboz: PASS
> zicntr: PASS
> 1..0 # SKIP - zicond not available, skipping tests
> zicsr: PASS
> zifencei: PASS
> zihintntl: PASS
> zihintpause: PASS
> zihpm: PASS
>
>
> >  static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
> >  {
> >         return (v + vm->page_size) & ~(vm->page_size - 1);
> > diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/t=
esting/selftests/kvm/riscv/get-reg-list.c
> > index 25de4b8bc347..ed29ba45588c 100644
> > --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> > @@ -75,15 +75,6 @@ bool check_reject_set(int err)
> >         return err =3D=3D EINVAL;
> >  }
> >
> > -static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
> > -{
> > -       int ret;
> > -       unsigned long value;
> > -
> > -       ret =3D __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
> > -       return (ret) ? false : !!value;
> > -}
> > -
> >  void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
> >  {
> >         unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] =3D { 0 };
> > @@ -111,7 +102,7 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vc=
pu_reg_list *c)
> >                 __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(s->feature), 1);
> >
> >                 /* Double check whether the desired extension was enabl=
ed */
> > -               __TEST_REQUIRE(vcpu_has_ext(vcpu, s->feature),
> > +               __TEST_REQUIRE(__vcpu_has_ext(vcpu, s->feature),
> >                                "%s not available, skipping tests\n", s-=
>name);
> >         }
> >  }
> > --
> > 2.34.1
> >
>
>
> --
> Regards,
> Atish

