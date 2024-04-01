Return-Path: <linux-kselftest+bounces-6959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB83B89475F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 00:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F5A1C2137E
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238BA51C2B;
	Mon,  1 Apr 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="OEmtXUxR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BBB8F6F
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Apr 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011036; cv=none; b=WvYw8fmF6Qt6GJwm6g8HY9TmlgPytA5zupp8mAq8IO1D9BI+Ort+eL9kBj/Oyx3uWj3h/E3ZTI1SUvr0KiYIQ++cVpWLme26DWaSO3jFh5eZFXAaU8PU5DbhGrW8UV6TTMffWzPwYChaqSZhSxLrOcazq9iYwzcmcT8RChy2/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011036; c=relaxed/simple;
	bh=NTg0LNvASPU60r1Pc8Xg21cU9Db2pDu0bl/8+t+KWZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jj51cbYrDxj2pwwQ4uPm7U/Pvd81DII3TyXdZvcHPO9WEgaposbL+mIwzflB8Au6nxUqEzS7hliKPwX9zn58PIDIQJIf44yRil60c6C0W4fIcnsbods76lr/trkvZF3gYilKftyKnDhAgs6x5Ds0NtFc6DcylNSYkzUO2v0qcHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=OEmtXUxR; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d6ee6c9945so33638171fa.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Apr 2024 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1712011032; x=1712615832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aY4S4yPUfIj0lcZIhHGm/I+32cExDlXkzSV19aujdnE=;
        b=OEmtXUxRtFiXZW6cQjKo9p5rXSTBp/6P8FcepU+kL8H3t5v7zCxK8XLDgALUHeKAqQ
         8H7oNeNCGwmMmEchSDVVdnkeOZFZz0ExUvy4rRbVhXnC0RuYkpJUaKwmsDHlxDUj5xsA
         LaGACyClK2phAkDZxwFvBVuXisHlB8q+imrvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712011032; x=1712615832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aY4S4yPUfIj0lcZIhHGm/I+32cExDlXkzSV19aujdnE=;
        b=sCNvFiu0DDaEJgvIgan150FyoyNTaAR0cbRvoueDCqBaw8gbtcDkLDmhxMs/GPeAM9
         f8P8Quhkbk1ZjPVeVbQ2oRnEqRcwsyOk9s8Q4jkki1DC75yVyaZfsh2fC9UsOJHowdf2
         Es4EHXjVEq0zs/vMHs49rZXJ5tisJJ5dnGBweYfmMPMR6Spq2FNmxzmCWD6oEnObXzTm
         /js1SNOzzxVy4hskXykdCbiBlqDjIFU6tNAGZ8XdYI8hxqh/R4X/hTo3IilngDD90D1n
         /1Wn/qlye1xXEJVk6UPlwZsp96DNEnGDHaHEHfk7bmzNn82Dtl85xUhDSkjXncMtx503
         /g/A==
X-Forwarded-Encrypted: i=1; AJvYcCWKED8/w0yf9q4v8v7iOWBuejEZHI2hzTgaKq+7oRPw2xFy8BolJpkLThPC7LLA39SEBejvcLTZ1zmQ8sc3Jp7ldGfxmMRzqO2O7tcoSuTI
X-Gm-Message-State: AOJu0YyVbhDL3mROK6Wq21LEtKYmI/2sbuENN7QS6XN5DNqOBUr0VxvV
	RyQipR5u6RRgBgiSn15vTdLTgL/7cyLlTSR07wGGQFVJCq2jXe3mq/JJzKdjVJS+sRxAQat08d/
	MnFxC+Rr5MUGs2ln6WzILQ7wIoSoTE7A+VK2W
X-Google-Smtp-Source: AGHT+IG/nrfJyiecsCRexI+R+JQkltSWLIGxNJI1MuunG9lO7Xv1PZB0PJSIO5fHcSDuaVZDyAvA8i4t7A+QtlxnzZU=
X-Received: by 2002:a05:651c:14a:b0:2d4:514b:428 with SMTP id
 c10-20020a05651c014a00b002d4514b0428mr6412640ljd.6.1712011032590; Mon, 01 Apr
 2024 15:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010130.1380926-1-atishp@rivosinc.com> <20240229010130.1380926-8-atishp@rivosinc.com>
 <20240302-1a3c0df25f2422e1e6abecf3@orel>
In-Reply-To: <20240302-1a3c0df25f2422e1e6abecf3@orel>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 1 Apr 2024 15:37:01 -0700
Message-ID: <CAOnJCUJCQjBfLZFW-3iLUB6ygyRmz1Anu+fhfrT4Lpoj2iNB5Q@mail.gmail.com>
Subject: Re: [PATCH v4 07/15] RISC-V: KVM: No need to exit to the user space
 if perf event failed
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

On Sat, Mar 2, 2024 at 12:16=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Feb 28, 2024 at 05:01:22PM -0800, Atish Patra wrote:
> > Currently, we return a linux error code if creating a perf event failed
> > in kvm. That shouldn't be necessary as guest can continue to operate
> > without perf profiling or profiling with firmware counters.
> >
> > Return appropriate SBI error code to indicate that PMU configuration
> > failed. An error message in kvm already describes the reason for failur=
e.
>
> I don't know enough about the perf subsystem to know if there may be
> a concern that resources are temporarily unavailable. If so, then this

Do you mean the hardware resources unavailable because the host is using it=
 ?

> patch would make it possible for a guest to do the exact same thing,
> but sometimes succeed and sometimes get SBI_ERR_NOT_SUPPORTED.
> sbi_pmu_counter_config_matching doesn't currently have any error types
> specified that say "unsupported at the moment, maybe try again", which
> would be more appropriate in that case. I do see
> perf_event_create_kernel_counter() can return ENOMEM when memory isn't
> available, but if the kernel isn't able to allocate a small amount of
> memory, then we're in bigger trouble anyway, so the concern would be
> if there are perf resource pools which may temporarily be exhausted at
> the time the guest makes this request.
>

For other cases, this patch ensures that guests continue to run without fai=
lure
which allows the user in the guest to try again if this fails due to a temp=
orary
resource availability.

> One comment below.
>
> >
> > Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampl=
ing")
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/kvm/vcpu_pmu.c     | 14 +++++++++-----
> >  arch/riscv/kvm/vcpu_sbi_pmu.c |  6 +++---
> >  2 files changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> > index b1574c043f77..29bf4ca798cb 100644
> > --- a/arch/riscv/kvm/vcpu_pmu.c
> > +++ b/arch/riscv/kvm/vcpu_pmu.c
> > @@ -229,8 +229,9 @@ static int kvm_pmu_validate_counter_mask(struct kvm=
_pmu *kvpmu, unsigned long ct
> >       return 0;
> >  }
> >
> > -static int kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_=
event_attr *attr,
> > -                                  unsigned long flags, unsigned long e=
idx, unsigned long evtdata)
> > +static long kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf=
_event_attr *attr,
> > +                                   unsigned long flags, unsigned long =
eidx,
> > +                                   unsigned long evtdata)
> >  {
> >       struct perf_event *event;
> >
> > @@ -454,7 +455,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcp=
u *vcpu, unsigned long ctr_ba
> >                                    unsigned long eidx, u64 evtdata,
> >                                    struct kvm_vcpu_sbi_return *retdata)
> >  {
> > -     int ctr_idx, ret, sbiret =3D 0;
> > +     int ctr_idx, sbiret =3D 0;
> > +     long ret;
> >       bool is_fevent;
> >       unsigned long event_code;
> >       u32 etype =3D kvm_pmu_get_perf_event_type(eidx);
> > @@ -513,8 +515,10 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vc=
pu *vcpu, unsigned long ctr_ba
> >                       kvpmu->fw_event[event_code].started =3D true;
> >       } else {
> >               ret =3D kvm_pmu_create_perf_event(pmc, &attr, flags, eidx=
, evtdata);
> > -             if (ret)
> > -                     return ret;
> > +             if (ret) {
> > +                     sbiret =3D SBI_ERR_NOT_SUPPORTED;
> > +                     goto out;
> > +             }
> >       }
> >
> >       set_bit(ctr_idx, kvpmu->pmc_in_use);
> > diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pm=
u.c
> > index 7eca72df2cbd..b70179e9e875 100644
> > --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
> > +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
> > @@ -42,9 +42,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *v=
cpu, struct kvm_run *run,
> >  #endif
> >               /*
> >                * This can fail if perf core framework fails to create a=
n event.
> > -              * Forward the error to userspace because it's an error w=
hich
> > -              * happened within the host kernel. The other option woul=
d be
> > -              * to convert to an SBI error and forward to the guest.
> > +              * No need to forward the error to userspace and exit the=
 guest
>
> Period after guest
>
>
> > +              * operation can continue without profiling. Forward the
>
> The operation
>

Fixed the above two.


> > +              * appropriate SBI error to the guest.
> >                */
> >               ret =3D kvm_riscv_vcpu_pmu_ctr_cfg_match(vcpu, cp->a0, cp=
->a1,
> >                                                      cp->a2, cp->a3, te=
mp, retdata);
> > --
> > 2.34.1
> >
>
> Thanks,
> drew



--
Regards,
Atish

