Return-Path: <linux-kselftest+bounces-6960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A1689481C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 02:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF21B2095E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 00:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B78C10F4;
	Tue,  2 Apr 2024 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="RVS6sKmA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D9ECF
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016206; cv=none; b=SSwoFaO0JffmpNKSLaCCKM+gPAMflYN+1EXdgwZ/VkBCUECD8huPFr1rg3Qn5u1Lwh1ey0XArxaZoG7QKw/8DCcLdWhWheHjp9Sfz5koWSPckjDWyDThTjKGOPJQFU6tJzw+DRc1I0TH8jQ1YPTwLqd7Ip7+b3jRu0MOAiFbXQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016206; c=relaxed/simple;
	bh=UbUOKl9k6eim5BVsBevTJYH27bWJlDt3QLEPXT/wVe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1tTfvoBhh18GOubpVnaasQIm11HozLESvDy+Mzda12BxqEbz8Iu+dWa0zyaWtbVcyISeaYXOnEKJcI1fQS4mmBsT/ltvk9QOw3Y84BT2M9SxVWStRnlwKKnXu5U/SdjSX0Kkz95uegJSFPVf86EzNhFgNiDufD6dvTvp0klDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=RVS6sKmA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so57140221fa.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Apr 2024 17:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1712016202; x=1712621002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LpjA6xd6xlBGjNTJ6MuV0HfZSYXbeYaDUkFVss0Z5c=;
        b=RVS6sKmAelMHa6MO54ZbGfq2QfnnhqQ7XaM8bsnu4NgulQA6cDopGr4CunBUP6ZcnK
         rb3Vl0w6kaxi1FLOTZ4YWOt+20tM9RcKNosGFi+QSwegM7lHcZfZhWJiQr4ZNr/jXIiM
         WXukog1BcwqMBLyUX215V0sSDfs0oYRUUGCDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712016202; x=1712621002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LpjA6xd6xlBGjNTJ6MuV0HfZSYXbeYaDUkFVss0Z5c=;
        b=T2rYoo+oYZecRa0IAlyT5kgeb9sJvwQx/N/9T9IGbaWJLxi3EurtCrDh1I2zmR/f3S
         7Y3G40BHRtsknTyWmq4aHImADbAaTLDLyvAa1tOBl2XcK/wkscZt4RYU1e4sAUB1NbmB
         wMAMfL9jKnT6PUDWnumpCHuwhbwWBHy+wmMviAP8DfI3BeuyZQhg+6m3pqFjzHHwEvhY
         Bv3QpZOuTdTaTGxrnSwXVoVGZIOhLHf3Sg2Zd63zxATwsuYjOIbEuMeWuyEnRENYeGXW
         mVOoD632jdRCJ8y6LepNusogydJeQ1f3lWfhIYXbD2xGaWUHaqg/Zg6IYWwrVnEAkbbE
         y+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVF8gqj+iPMMqrykjqwsTMgSouR2MbpeNTm8F3XAVCEa9bgFiNYVLgmWcZPkgwrFby5m7IehIhYYz/1qDEM0HQ0fkp8Bw28SZJt5msomS08
X-Gm-Message-State: AOJu0YwM19BSt5ZZZ0POsKHSqcMgBb1/11G1bcIB+jz7p+mZ6gfQboAM
	9VF/nbVm2+SvWbNnW8Q2yCsHH5ri5unn0KFTiJr14gUuiMNwN6Odjyi1ZbjC28tATDppRF1V1HQ
	Le+WtLz8r6dXmLIz1Vc/UrIOjMS+71T7lv39s
X-Google-Smtp-Source: AGHT+IE7Nrp4r+qkgZI4BQovwwilbzr9TjDgxtRtV9MXzMaFvrX/1xxBUV6XGq/tqEcLNZyMEuM/iuEIfi4wAyvr9GM=
X-Received: by 2002:a2e:90d3:0:b0:2d4:2f37:1e27 with SMTP id
 o19-20020a2e90d3000000b002d42f371e27mr8063062ljg.18.1712016202170; Mon, 01
 Apr 2024 17:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010130.1380926-1-atishp@rivosinc.com> <20240229010130.1380926-11-atishp@rivosinc.com>
 <20240302-7679c8f67984ccae734926ba@orel>
In-Reply-To: <20240302-7679c8f67984ccae734926ba@orel>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 1 Apr 2024 17:03:10 -0700
Message-ID: <CAOnJCUKrjiT7DNdhVCVGsX4vHVUHX53P9vVMLcvQ1EKcEogB5w@mail.gmail.com>
Subject: Re: [PATCH v4 10/15] RISC-V: KVM: Support 64 bit firmware counters on RV32
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org, 
	Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 2:52=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Wed, Feb 28, 2024 at 05:01:25PM -0800, Atish Patra wrote:
> > The SBI v2.0 introduced a fw_read_hi function to read 64 bit firmware
> > counters for RV32 based systems.
> >
> > Add infrastructure to support that.
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/kvm_vcpu_pmu.h |  4 ++-
> >  arch/riscv/kvm/vcpu_pmu.c             | 37 ++++++++++++++++++++++++++-
> >  arch/riscv/kvm/vcpu_sbi_pmu.c         |  6 +++++
> >  3 files changed, 45 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include=
/asm/kvm_vcpu_pmu.h
> > index 8cb21a4f862c..e0ad27dea46c 100644
> > --- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
> > +++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> > @@ -20,7 +20,7 @@ static_assert(RISCV_KVM_MAX_COUNTERS <=3D 64);
> >
> >  struct kvm_fw_event {
> >       /* Current value of the event */
> > -     unsigned long value;
> > +     u64 value;
> >
> >       /* Event monitoring status */
> >       bool started;
> > @@ -91,6 +91,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu =
*vcpu, unsigned long ctr_ba
> >                                    struct kvm_vcpu_sbi_return *retdata)=
;
> >  int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long c=
idx,
> >                               struct kvm_vcpu_sbi_return *retdata);
> > +int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned =
long cidx,
> > +                                   struct kvm_vcpu_sbi_return *retdata=
);
> >  void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
> >  int kvm_riscv_vcpu_pmu_setup_snapshot(struct kvm_vcpu *vcpu, unsigned =
long saddr_low,
> >                                     unsigned long saddr_high, unsigned =
long flags,
> > diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> > index a02f7b981005..469bb430cf97 100644
> > --- a/arch/riscv/kvm/vcpu_pmu.c
> > +++ b/arch/riscv/kvm/vcpu_pmu.c
> > @@ -196,6 +196,29 @@ static int pmu_get_pmc_index(struct kvm_pmu *pmu, =
unsigned long eidx,
> >       return kvm_pmu_get_programmable_pmc_index(pmu, eidx, cbase, cmask=
);
> >  }
> >
> > +static int pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cid=
x,
> > +                           unsigned long *out_val)
> > +{
> > +     struct kvm_pmu *kvpmu =3D vcpu_to_pmu(vcpu);
> > +     struct kvm_pmc *pmc;
> > +     int fevent_code;
> > +
> > +     if (!IS_ENABLED(CONFIG_32BIT))
>
> Let's remove the CONFIG_32BIT check in kvm_sbi_ext_pmu_handler() and then
> set *out_val to zero here and return success. Either that, or we should
> WARN or something here since it's a KVM bug to get here with
> !CONFIG_32BIT.
>

I added a warning here to prevent any sort of kvm bug. Returning
silently with out_val to zero from here may hide that.

The CONFIG_32BIT check in kvm_sbi_ext_pmu_handler also avoids
unnecessary code execution
(even though they are few) in case the lower privilege mode software
invokes the read_hi by mistake
for non RV32.


> > +             return -EINVAL;
> > +
> > +     pmc =3D &kvpmu->pmc[cidx];
>
> Uh oh! We're missing range validation of cidx! And I see we're missing it
> in pmu_ctr_read() too. We need the same check we have in
> kvm_riscv_vcpu_pmu_ctr_info(). I think the other SBI functions are OK,
> but it's worth a triple check.
>

Good catch. Thanks. Fixed it.

> > +
> > +     if (pmc->cinfo.type !=3D SBI_PMU_CTR_TYPE_FW)
> > +             return -EINVAL;
> > +
> > +     fevent_code =3D get_event_code(pmc->event_idx);
> > +     pmc->counter_val =3D kvpmu->fw_event[fevent_code].value;
> > +
> > +     *out_val =3D pmc->counter_val >> 32;
> > +
> > +     return 0;
> > +}
> > +
> >  static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
> >                       unsigned long *out_val)
> >  {
> > @@ -702,6 +725,18 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vc=
pu *vcpu, unsigned long ctr_ba
> >       return 0;
> >  }
> >
> > +int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned =
long cidx,
> > +                                   struct kvm_vcpu_sbi_return *retdata=
)
> > +{
> > +     int ret;
> > +
> > +     ret =3D pmu_fw_ctr_read_hi(vcpu, cidx, &retdata->out_val);
> > +     if (ret =3D=3D -EINVAL)
> > +             retdata->err_val =3D SBI_ERR_INVALID_PARAM;
> > +
> > +     return 0;
>
> I see this follows the pattern we have with kvm_riscv_vcpu_pmu_ctr_read
> and pmu_ctr_read, but I wonder if we really need the
> kvm_riscv_vcpu_pmu_ctr_read() and kvm_riscv_vcpu_pmu_fw_ctr_read_hi()
> wrapper functions?
>

pmu_ctr_read is invoked from kvm_riscv_vcpu_pmu_read_hpm as well.
That's why I have a wrapper to read the counters in the SBI path.
kvm_riscv_vcpu_pmu_ctr_read

kvm_riscv_vcpu_pmu_fw_ctr_read_hi just followed the pattern.

If we refactor the firmware counter read and hpmcounter read to be
separate functions,
we won't need the wrapper though. But I am not sure if it will
actually improve the code readability.

If you think it's better that way, I will modify it.

Looking at this code, we should definitely change the
kvm_riscv_vcpu_pmu_ctr_read
to kvm_riscv_vcpu_pmu_fw_ctr_read to reflect the real purpose.

> > +}
> > +
> >  int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long c=
idx,
> >                               struct kvm_vcpu_sbi_return *retdata)
> >  {
> > @@ -775,7 +810,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
> >                       pmc->cinfo.csr =3D CSR_CYCLE + i;
> >               } else {
> >                       pmc->cinfo.type =3D SBI_PMU_CTR_TYPE_FW;
> > -                     pmc->cinfo.width =3D BITS_PER_LONG - 1;
> > +                     pmc->cinfo.width =3D 63;
> >               }
> >       }
> >
> > diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pm=
u.c
> > index 9f61136e4bb1..58a0e5587e2a 100644
> > --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
> > +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
> > @@ -64,6 +64,12 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *=
vcpu, struct kvm_run *run,
> >       case SBI_EXT_PMU_COUNTER_FW_READ:
> >               ret =3D kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata=
);
> >               break;
> > +     case SBI_EXT_PMU_COUNTER_FW_READ_HI:
> > +             if (IS_ENABLED(CONFIG_32BIT))
> > +                     ret =3D kvm_riscv_vcpu_pmu_fw_ctr_read_hi(vcpu, c=
p->a0, retdata);
> > +             else
> > +                     retdata->out_val =3D 0;
> > +             break;
> >       case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
> >               ret =3D kvm_riscv_vcpu_pmu_setup_snapshot(vcpu, cp->a0, c=
p->a1, cp->a2, retdata);
> >               break;
> > --
> > 2.34.1
> >
>
> Thanks,
> drew



--=20
Regards,
Atish

