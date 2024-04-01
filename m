Return-Path: <linux-kselftest+bounces-6958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59EE89475C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 00:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB77B2137B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 22:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6647A51016;
	Mon,  1 Apr 2024 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="DisrqAxU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1D8F6F
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Apr 2024 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010991; cv=none; b=Ey42SfZM7RUjFcAjq25pWF7NUlWz7M7CzlqnOtqLRdlFqYPAz00TpADr8kBFsCWpzsh6bFVug855idXA/Z7/y8NHRV46UIlZ01uKbcQmgqXQytspUdMDvQoCe1Fz4TJL7JP9g2YUnz1MfZKA/7iKwJHQZb+S3bWXTykg+u3UGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010991; c=relaxed/simple;
	bh=l7tANeGH1NplxmfJX0fGMQhsUOfslz3MessZ0Nyt/LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AF0UdopYU0x9aLxlEC/4GkismABdrR0dW7oQNudC9Cm2WK9EJQ3AEnqPIi1mbGKCa2mgC+IT/1PLvxMwPSCxvzVSc7PEtUQTloOg9/GMWr4fBcGcEmgaeXhpckptleLKont4TQh1NyOM4IQPRY7Jb+I6uGjjBnrGa3Tbc6MnAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=DisrqAxU; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d4979cd8c8so43959921fa.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Apr 2024 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1712010987; x=1712615787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvDPAlziQ7mAcfBxPAH8ZIQ8p10MVAgkj4gxes2yMQc=;
        b=DisrqAxUy3BCQfM4f/Zt71IkTmx7bHrq4pBldO3p7LqiZu0SRspCq420BwVxoHtfe8
         7wX4LjTV1/zVeTPTgyibfcMHN2fOMpg7ytgym7ORAOPgq27uK63bYaOj5VKwj7jOdEKf
         l8HuUEwqz2y7SMu4muEBMDwEKKVrfN6XflxCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712010987; x=1712615787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvDPAlziQ7mAcfBxPAH8ZIQ8p10MVAgkj4gxes2yMQc=;
        b=Hf1MWgPs1wnXP969gCND6Oz6Zr1sXDelXwQXm6ymVoY3JI03oXgPz7RUS+8DX/UnGS
         7kHx7cHxaRHbayM9OUNe9WCUPYrhwF3PZD+M2TPYGIzqNBKRL+XfiVjvqxItOAJdiE4A
         Yl/l0A6cE2n7VaZAO0rTAiLgzCdG1PvK5cYWJP2T2GSaaHI3TG+8zcezkatfrPtSj6hl
         7bo4MrWTFdDf7dmmuEBVM/zX4qSiEU0GndthKK3pS8RdXI5y/BjsnA7RYZ4qbe+2lrlm
         Xzhl2kD7kAfxV+v0hmIUS5Sk5kznjj3FV5e6OYTOIUUQdqdZXEYJL8c7kNXWTY0fP7RN
         Mmrg==
X-Forwarded-Encrypted: i=1; AJvYcCUtprOgyySWGonn+6LGiWIiHnJDT6dtVPhJxctDN5u5lNbXX053yM2HLvHNqySShWc+hLYyTx4eUtYPIqPvjt6qWR+DWMORgfxSOL3+CSkt
X-Gm-Message-State: AOJu0YyMe3DhpgFB8IIdWKvL4lNB6xLr1hWbCcVsl1ppyS3Fg0dlgSsq
	qDTkkXYVEc6oJyn0VWadPKfXqzqrPqxGhSMr4PY4sURf5u0wB5b9vImk2dDTQDdH0trVaaPkpxx
	AoLTxJrHuuOL5V9yZQ5MKFsbZ845VGBKkaU53
X-Google-Smtp-Source: AGHT+IEISW7E+Ezw5vjEMx6zUqgUMTTf0rKbH/YyFvkddIlkMXtwQtIYHwJcyp5Givggct6PxukvH0f6QWkg7m5WUHY=
X-Received: by 2002:a2e:b710:0:b0:2d5:9f6f:1df2 with SMTP id
 j16-20020a2eb710000000b002d59f6f1df2mr4822642ljo.0.1712010986601; Mon, 01 Apr
 2024 15:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010130.1380926-1-atishp@rivosinc.com> <20240229010130.1380926-9-atishp@rivosinc.com>
 <20240302-6ae8fe37b90f127bc9be737f@orel>
In-Reply-To: <20240302-6ae8fe37b90f127bc9be737f@orel>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 1 Apr 2024 15:36:14 -0700
Message-ID: <CAOnJCUKjZWnS_SaR78Fy5AUOxrd+4gBx=_YrA=FQCa20iwifNQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/15] RISC-V: KVM: Implement SBI PMU Snapshot feature
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

On Sat, Mar 2, 2024 at 1:49=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Wed, Feb 28, 2024 at 05:01:23PM -0800, Atish Patra wrote:
> > PMU Snapshot function allows to minimize the number of traps when the
> > guest access configures/access the hpmcounters. If the snapshot feature
> > is enabled, the hypervisor updates the shared memory with counter
> > data and state of overflown counters. The guest can just read the
> > shared memory instead of trap & emulate done by the hypervisor.
> >
> > This patch doesn't implement the counter overflow yet.
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/kvm_vcpu_pmu.h |   7 ++
> >  arch/riscv/kvm/vcpu_pmu.c             | 120 +++++++++++++++++++++++++-
> >  arch/riscv/kvm/vcpu_sbi_pmu.c         |   3 +
> >  drivers/perf/riscv_pmu_sbi.c          |   2 +-
> >  4 files changed, 129 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include=
/asm/kvm_vcpu_pmu.h
> > index 395518a1664e..586bab84be35 100644
> > --- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
> > +++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> > @@ -50,6 +50,10 @@ struct kvm_pmu {
> >       bool init_done;
> >       /* Bit map of all the virtual counter used */
> >       DECLARE_BITMAP(pmc_in_use, RISCV_KVM_MAX_COUNTERS);
> > +     /* The address of the counter snapshot area (guest physical addre=
ss) */
> > +     gpa_t snapshot_addr;
> > +     /* The actual data of the snapshot */
> > +     struct riscv_pmu_snapshot_data *sdata;
> >  };
> >
> >  #define vcpu_to_pmu(vcpu) (&(vcpu)->arch.pmu_context)
> > @@ -85,6 +89,9 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu =
*vcpu, unsigned long ctr_ba
> >  int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long c=
idx,
> >                               struct kvm_vcpu_sbi_return *retdata);
> >  void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
> > +int kvm_riscv_vcpu_pmu_setup_snapshot(struct kvm_vcpu *vcpu, unsigned =
long saddr_low,
> > +                                   unsigned long saddr_high, unsigned =
long flags,
> > +                                   struct kvm_vcpu_sbi_return *retdata=
);
>
> I prefer to name this function
>
> kvm_riscv_vcpu_pmu_snapshot_set_shmem
>

Sure.

> >  void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu);
> >  void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu);
> >
> > diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> > index 29bf4ca798cb..74865e6050a1 100644
> > --- a/arch/riscv/kvm/vcpu_pmu.c
> > +++ b/arch/riscv/kvm/vcpu_pmu.c
> > @@ -311,6 +311,81 @@ int kvm_riscv_vcpu_pmu_read_hpm(struct kvm_vcpu *v=
cpu, unsigned int csr_num,
> >       return ret;
> >  }
> >
> > +static void kvm_pmu_clear_snapshot_area(struct kvm_vcpu *vcpu)
> > +{
> > +     struct kvm_pmu *kvpmu =3D vcpu_to_pmu(vcpu);
> > +     int snapshot_area_size =3D sizeof(struct riscv_pmu_snapshot_data)=
;
> > +
> > +     if (kvpmu->sdata) {
> > +             memset(kvpmu->sdata, 0, snapshot_area_size);
> > +             if (kvpmu->snapshot_addr !=3D INVALID_GPA)
>
> It's a KVM bug if we have non-null sdata but snapshot_addr is INVALID_GPA=
,
> right? Maybe we should warn if we see that. We can also move the memset
> inside the if block.
>

Added a warning.

> > +                     kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr,
> > +                                          kvpmu->sdata, snapshot_area_=
size);
> > +             kfree(kvpmu->sdata);
> > +             kvpmu->sdata =3D NULL;
> > +     }
> > +     kvpmu->snapshot_addr =3D INVALID_GPA;
> > +}
> > +
> > +int kvm_riscv_vcpu_pmu_setup_snapshot(struct kvm_vcpu *vcpu, unsigned =
long saddr_low,
> > +                                   unsigned long saddr_high, unsigned =
long flags,
> > +                                   struct kvm_vcpu_sbi_return *retdata=
)
> > +{
> > +     struct kvm_pmu *kvpmu =3D vcpu_to_pmu(vcpu);
> > +     int snapshot_area_size =3D sizeof(struct riscv_pmu_snapshot_data)=
;
> > +     int sbiret =3D 0;
> > +     gpa_t saddr;
> > +     unsigned long hva;
> > +     bool writable;
> > +
> > +     if (!kvpmu) {
> > +             sbiret =3D SBI_ERR_INVALID_PARAM;
> > +             goto out;
> > +     }
>
> Need to check that flags is zero or return SBI_ERR_INVALID_PARAM.
>

Fixed.

> > +
> > +     if (saddr_low =3D=3D -1 && saddr_high =3D=3D -1) {
>
> We introduced SBI_STA_SHMEM_DISABLE for these magic -1's for STA. Since
> SBI is using the -1 approach for all its shmem, then maybe we should
> rename SBI_STA_SHMEM_DISABLE to SBI_SHMEM_DISABLE and then use them here
> too.
>

Fixed

> > +             kvm_pmu_clear_snapshot_area(vcpu);
> > +             return 0;
> > +     }
> > +
> > +     saddr =3D saddr_low;
> > +
> > +     if (saddr_high !=3D 0) {
> > +             if (IS_ENABLED(CONFIG_32BIT))
> > +                     saddr |=3D ((gpa_t)saddr << 32);
> > +             else
> > +                     sbiret =3D SBI_ERR_INVALID_ADDRESS;
> > +             goto out;
> > +     }
> > +
> > +     if (kvm_is_error_gpa(vcpu->kvm, saddr)) {
> > +             sbiret =3D SBI_ERR_INVALID_PARAM;
> > +             goto out;
> > +     }
>
> Does the check above provide anything more than what the check below does=
?
>
You are correct. I have removed the check

> > +
> > +     hva =3D kvm_vcpu_gfn_to_hva_prot(vcpu, saddr >> PAGE_SHIFT, &writ=
able);
> > +     if (kvm_is_error_hva(hva) || !writable) {
> > +             sbiret =3D SBI_ERR_INVALID_ADDRESS;
> > +             goto out;
> > +     }
> > +
> > +     kvpmu->snapshot_addr =3D saddr;
> > +     kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC);
> > +     if (!kvpmu->sdata)
>
> Should reset snapshot_addr to INVALID_GPA here on error. Or maybe we
> should just set snapshot_addr to saddr at the bottom of this function if
> we make it.
>

Done.

> > +             return -ENOMEM;
> > +
> > +     if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area=
_size)) {
> > +             kfree(kvpmu->sdata);
> > +             kvpmu->snapshot_addr =3D INVALID_GPA;
> > +             sbiret =3D SBI_ERR_FAILURE;
>
> I agree we should return this SBI error for this case, but unfortunately
> the spec is missing the
>
>  SBI_ERR_FAILED - The request failed for unspecified or unknown other rea=
sons.
>
> that we have for other SBI functions. I guess we should keep the code lik=
e
> this and open a PR to the spec.
>

I have created a blanket github issue for now. I will send a PR.

> > +     }
> > +
> > +out:
> > +     retdata->err_val =3D sbiret;
> > +
> > +     return 0;
> > +}
> > +
> >  int kvm_riscv_vcpu_pmu_num_ctrs(struct kvm_vcpu *vcpu,
> >                               struct kvm_vcpu_sbi_return *retdata)
> >  {
> > @@ -344,20 +419,33 @@ int kvm_riscv_vcpu_pmu_ctr_start(struct kvm_vcpu =
*vcpu, unsigned long ctr_base,
> >       int i, pmc_index, sbiret =3D 0;
> >       struct kvm_pmc *pmc;
> >       int fevent_code;
> > +     bool snap_flag_set =3D flags & SBI_PMU_START_FLAG_INIT_FROM_SNAPS=
HOT;
>
> This function should confirm no undefined bits are set in flags and the
> spec should specify that the reserved flags must be zero otherwise an
> invalid param will be returned.
>
> Also here would should confirm that only one of the two flags is set,
> otherwise return invalid param, as they've specified to be mutually
> exclusive.
>

That makes sense. Update the same github issue.
(https://github.com/riscv-non-isa/riscv-sbi-doc/issues/145)

I will make the necessary changes in a separate series after the spec is me=
rged.

> Regarding the spec, the note about the counter value not being modified
> unless SBI_PMU_START_SET_INIT_VALUE is set should be modified to state
> unless either of the two flags are set (so I think we need another spec
> PR).
>
> (The same flags checking/specifying comments apply to the other functions
> with flags too.)
>

Noted (https://github.com/riscv-non-isa/riscv-sbi-doc/issues/146).

> >
> >       if (kvm_pmu_validate_counter_mask(kvpmu, ctr_base, ctr_mask) < 0)=
 {
> >               sbiret =3D SBI_ERR_INVALID_PARAM;
> >               goto out;
> >       }
> >
> > +     if (snap_flag_set && kvpmu->snapshot_addr =3D=3D INVALID_GPA) {
> > +             sbiret =3D SBI_ERR_NO_SHMEM;
> > +             goto out;
> > +     }
> > +
> >       /* Start the counters that have been configured and requested by =
the guest */
> >       for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
> >               pmc_index =3D i + ctr_base;
> >               if (!test_bit(pmc_index, kvpmu->pmc_in_use))
> >                       continue;
> >               pmc =3D &kvpmu->pmc[pmc_index];
> > -             if (flags & SBI_PMU_START_FLAG_SET_INIT_VALUE)
> > +             if (flags & SBI_PMU_START_FLAG_SET_INIT_VALUE) {
> >                       pmc->counter_val =3D ival;
> > +             } else if (snap_flag_set) {
> > +                     kvm_vcpu_read_guest(vcpu, kvpmu->snapshot_addr, k=
vpmu->sdata,
> > +                                         sizeof(struct riscv_pmu_snaps=
hot_data));
>
> The snapshot read should be outside the for_each_set_bit() loop and we
> should warn and abort the counter starting if the read fails.
>

Fixed. This should also fall under the SBI_ERR_FAILURE category.

> > +                     /* The counter index in the snapshot are relative=
 to the counter base */
> > +                     pmc->counter_val =3D kvpmu->sdata->ctr_values[i];
> > +             }
> > +
> >               if (pmc->cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW) {
> >                       fevent_code =3D get_event_code(pmc->event_idx);
> >                       if (fevent_code >=3D SBI_PMU_FW_MAX) {
> > @@ -398,14 +486,21 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *=
vcpu, unsigned long ctr_base,
> >  {
> >       struct kvm_pmu *kvpmu =3D vcpu_to_pmu(vcpu);
> >       int i, pmc_index, sbiret =3D 0;
> > +     u64 enabled, running;
> >       struct kvm_pmc *pmc;
> >       int fevent_code;
> > +     bool snap_flag_set =3D flags & SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
> >
> > -     if (kvm_pmu_validate_counter_mask(kvpmu, ctr_base, ctr_mask) < 0)=
 {
> > +     if ((kvm_pmu_validate_counter_mask(kvpmu, ctr_base, ctr_mask) < 0=
)) {
>
> Added unnecessary () here.
>

Fixed.

> >               sbiret =3D SBI_ERR_INVALID_PARAM;
> >               goto out;
> >       }
> >
> > +     if (snap_flag_set && kvpmu->snapshot_addr =3D=3D INVALID_GPA) {
> > +             sbiret =3D SBI_ERR_NO_SHMEM;
> > +             goto out;
> > +     }
> > +
> >       /* Stop the counters that have been configured and requested by t=
he guest */
> >       for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
> >               pmc_index =3D i + ctr_base;
> > @@ -438,9 +533,28 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *v=
cpu, unsigned long ctr_base,
> >               } else {
> >                       sbiret =3D SBI_ERR_INVALID_PARAM;
> >               }
> > +
> > +             if (snap_flag_set && !sbiret) {
> > +                     if (pmc->cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW)
> > +                             pmc->counter_val =3D kvpmu->fw_event[feve=
nt_code].value;
> > +                     else if (pmc->perf_event)
> > +                             pmc->counter_val +=3D perf_event_read_val=
ue(pmc->perf_event,
> > +                                                                      =
 &enabled, &running);
> > +                     /* TODO: Add counter overflow support when sscofp=
mf support is added */
> > +                     kvpmu->sdata->ctr_values[i] =3D pmc->counter_val;
> > +                     kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, =
kvpmu->sdata,
> > +                                          sizeof(struct riscv_pmu_snap=
shot_data));
>
> Should just set a boolean here saying that the snapshot needs an update
> and then do the update outside the for_each_set_bit loop.
>

Done.

> > +             }
> > +
> >               if (flags & SBI_PMU_STOP_FLAG_RESET) {
> >                       pmc->event_idx =3D SBI_PMU_EVENT_IDX_INVALID;
> >                       clear_bit(pmc_index, kvpmu->pmc_in_use);
> > +                     if (snap_flag_set) {
> > +                             /* Clear the snapshot area for the upcomi=
ng deletion event */
> > +                             kvpmu->sdata->ctr_values[i] =3D 0;
> > +                             kvm_vcpu_write_guest(vcpu, kvpmu->snapsho=
t_addr, kvpmu->sdata,
> > +                                                  sizeof(struct riscv_=
pmu_snapshot_data));
>
> The spec isn't clear on this (so we should clarify it), but I'd expect
> that a caller who set both the reset and the snapshot flag would want
> the snapshot from before the reset when this call completes and then
> assume that when they start counting again, and look at the snapshot
> again, that those new counts would be from the reset values. Or maybe
> not :-) Maybe they want to do a reset and take a snapshot in order to
> look at the snapshot and confirm the reset happened? Either way, it
> seems we should only do one of the two here. Either update the snapshot
> before resetting, and not again after reset, or reset and then update
> the snapshot (with no need to update before).
>

The reset call should happen when the event is deleted by the perf
framework in supervisor.
If we don't clear the values, the shared memory may have stale data of
last read counters
which is not ideal. That's why, I am clearing it upon resetting.
The actual counter value should be read while stopping the counters.

I thought the current description is clear enough as it says

"SBI_PMU_STOP_FLAG_RESET - Reset the counter to event mapping."

Do you feel we should be more explicit about this ?

> > +                     }
> >               }
> >       }
> >
> > @@ -566,6 +680,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
> >       kvpmu->num_hw_ctrs =3D num_hw_ctrs + 1;
> >       kvpmu->num_fw_ctrs =3D SBI_PMU_FW_MAX;
> >       memset(&kvpmu->fw_event, 0, SBI_PMU_FW_MAX * sizeof(struct kvm_fw=
_event));
> > +     kvpmu->snapshot_addr =3D INVALID_GPA;
> >
> >       if (kvpmu->num_hw_ctrs > RISCV_KVM_MAX_HW_CTRS) {
> >               pr_warn_once("Limiting the hardware counters to 32 as spe=
cified by the ISA");
> > @@ -625,6 +740,7 @@ void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcp=
u)
> >       }
> >       bitmap_zero(kvpmu->pmc_in_use, RISCV_MAX_COUNTERS);
> >       memset(&kvpmu->fw_event, 0, SBI_PMU_FW_MAX * sizeof(struct kvm_fw=
_event));
> > +     kvm_pmu_clear_snapshot_area(vcpu);
> >  }
> >
> >  void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu)
> > diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pm=
u.c
> > index b70179e9e875..9f61136e4bb1 100644
> > --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
> > +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
> > @@ -64,6 +64,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *v=
cpu, struct kvm_run *run,
> >       case SBI_EXT_PMU_COUNTER_FW_READ:
> >               ret =3D kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata=
);
> >               break;
> > +     case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
> > +             ret =3D kvm_riscv_vcpu_pmu_setup_snapshot(vcpu, cp->a0, c=
p->a1, cp->a2, retdata);
> > +             break;
> >       default:
> >               retdata->err_val =3D SBI_ERR_NOT_SUPPORTED;
> >       }
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index 8de5721e8019..1a22ce1ff8c8 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -802,7 +802,7 @@ static noinline void pmu_sbi_start_ovf_ctrs_snapsho=
t(struct cpu_hw_events *cpu_h
> >       struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_ad=
dr;
> >
> >       for_each_set_bit(idx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTER=
S) {
> > -             if (ctr_ovf_mask & (1 << idx)) {
> > +             if (ctr_ovf_mask & (BIT(idx))) {
> >                       event =3D cpu_hw_evt->events[idx];
> >                       hwc =3D &event->hw;
> >                       max_period =3D riscv_pmu_ctr_get_width_mask(event=
);
> > --
> > 2.34.1
> >
>
> Thanks,
> drew



--=20
Regards,
Atish

