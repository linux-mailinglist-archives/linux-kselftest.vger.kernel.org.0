Return-Path: <linux-kselftest+bounces-7189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5E7898713
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81F5B289B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 12:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90C1292DD;
	Thu,  4 Apr 2024 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gr+5vDa+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85312880D
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232968; cv=none; b=h7hQG/1slkNRMKbIi1zgh4DOBtCUoXmSFXIm6+lFORO2GFMHLHAwgkuxFrvaguNH+z7PS+wT/6SqmUr9aV58Q9ezn0wQMRQLDgxLs1LxJucjh61RC6O0YzifACmH6k/G/LcAogUlNkBDMruZkIav130VTn7TOJgleNySQkq7VQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232968; c=relaxed/simple;
	bh=DwqQItygo6fFyn6PFhYMmTLsFq02mcoKOLnfPOt+Jp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHhxZ7JMRxtTcYZxS1bKeygdJmEqoMansy7SjJDj/jDPw5dtVpIy+WV+5uUQo31jeAWmHaTtwTOmt+u5zmCZ0tyCmavNZPTtpL6V/za+sBXOetclJ0+dFBuc5HhFrsoib4lo6l+ieq/QHfSMqsjqZjurmE3xqv1pGzv7QBdwA1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gr+5vDa+; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d83dddcd65so11576131fa.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712232963; x=1712837763; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M7CUkDVzN7ZtwbkfqhOOiERTsuLZVsBjpzU4ddI5VKM=;
        b=gr+5vDa+R3fqRiHDKuViRiKyRJSsYWwJbEX5CUsYodribTYf5WqJnZyMr9KBmIU0+7
         qHM+y9Xh16+wwkMAgYHwrqy9Gs9wTF24KLjDs66eSXpiIs2Y8aeeZcPvEEH4yub4PIM2
         IxcKDAS+aRG2ninq1LlzV/CR7Yj4DZ16bYSRv5+7qGqLo8Dkbw7lHmOPm81GlKctJF3k
         a/yKEIRR8vAHzKG041dbWembwJxEMdj9GYmnSXTLBVHiPCO6hkiq3vd4HEi3EsNvyNho
         0LgU9//B7EGNo72NhRiDF/N88l6YNalQWcPN4bPWG2JCmK5l/kdEgUYuSyfSWMw52xZU
         Vb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712232963; x=1712837763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7CUkDVzN7ZtwbkfqhOOiERTsuLZVsBjpzU4ddI5VKM=;
        b=ARAVG0Jb97zYxKMtx8TgHzSn6YMHMAYRPFjYbx4jYowfqFWroD/uLXevcF/ovmwasN
         Nk6gbSQxvkQSEGROCuHcrFJsZhC2zNt91GFx1KPuf2DHACSAMX7f/1RTS/kkZoBf1IaR
         egNllHSiIuqOzPiACiwmTnab4Sd4TiW+mUHRZOwoAwrwlzMSVMXLwdvIikfEOpkkeXIZ
         YfeFfI4iNTGiozUTDOsGRzREFj7iBo26iwyYVtYtF6MpRyO/h9i2U8v9hCAxcCkS83TG
         8QNZ0ANMwlPJqYpnPtqFOhDHJzFwHE1aluWqWWpHhrE+SxwLieYgxhvcaiq8JxYhubQi
         K5nw==
X-Forwarded-Encrypted: i=1; AJvYcCXkB9yoYopI3xMbsDri9LyEnLKIJmYC+s/SRgsuGst1DAXpiTYIevVbUt4iFEUTIQwVo2FS3DbQpYZMr6E95o1iDmulHfdOePEtVdaiRQBU
X-Gm-Message-State: AOJu0Yzg9pJzS72Hn6bLyKB6LSxPQIgmbedw85xDro6UkzcQY5LuZdtM
	605IykuN4XVscopJBypNxwArnqy2fwJ9vJXVI6wtPWFGbLnYmacWeoqw0zqTXps=
X-Google-Smtp-Source: AGHT+IHYFdWmSj7wn8SFyRFXMduCoplAQPqaPLjEPnPkn3UWdbmb8OMIHJOSpfY0ndz+qQW8DO3Ptg==
X-Received: by 2002:a2e:8e6d:0:b0:2d8:2799:c3b1 with SMTP id t13-20020a2e8e6d000000b002d82799c3b1mr1596767ljk.10.1712232963336;
        Thu, 04 Apr 2024 05:16:03 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id ck5-20020a5d5e85000000b0034349225fbcsm12841155wrb.114.2024.04.04.05.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:16:02 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:16:01 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@atishpatra.org>
Cc: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org, 
	Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 07/15] RISC-V: KVM: No need to exit to the user space
 if perf event failed
Message-ID: <20240404-ea40bc0237635d671e64fef6@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-8-atishp@rivosinc.com>
 <20240302-1a3c0df25f2422e1e6abecf3@orel>
 <CAOnJCUJCQjBfLZFW-3iLUB6ygyRmz1Anu+fhfrT4Lpoj2iNB5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOnJCUJCQjBfLZFW-3iLUB6ygyRmz1Anu+fhfrT4Lpoj2iNB5Q@mail.gmail.com>

On Mon, Apr 01, 2024 at 03:37:01PM -0700, Atish Patra wrote:
> On Sat, Mar 2, 2024 at 12:16 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Wed, Feb 28, 2024 at 05:01:22PM -0800, Atish Patra wrote:
> > > Currently, we return a linux error code if creating a perf event failed
> > > in kvm. That shouldn't be necessary as guest can continue to operate
> > > without perf profiling or profiling with firmware counters.
> > >
> > > Return appropriate SBI error code to indicate that PMU configuration
> > > failed. An error message in kvm already describes the reason for failure.
> >
> > I don't know enough about the perf subsystem to know if there may be
> > a concern that resources are temporarily unavailable. If so, then this
> 
> Do you mean the hardware resources unavailable because the host is using it ?

Yes (I think). The issue I'm thinking of is if kvm_pmu_create_perf_event
(perf_event_create_kernel_counter) returns something like EBUSY and then
we translate that to SBI_ERR_NOT_SUPPORTED. I'm not sure guests would
interpret not-supported as an error which means they can retry. Or if
they retry and get something other than not-supported if they'd be
confused.

Thanks,
drew
  

> 
> > patch would make it possible for a guest to do the exact same thing,
> > but sometimes succeed and sometimes get SBI_ERR_NOT_SUPPORTED.
> > sbi_pmu_counter_config_matching doesn't currently have any error types
> > specified that say "unsupported at the moment, maybe try again", which
> > would be more appropriate in that case. I do see
> > perf_event_create_kernel_counter() can return ENOMEM when memory isn't
> > available, but if the kernel isn't able to allocate a small amount of
> > memory, then we're in bigger trouble anyway, so the concern would be
> > if there are perf resource pools which may temporarily be exhausted at
> > the time the guest makes this request.
> >
> 
> For other cases, this patch ensures that guests continue to run without failure
> which allows the user in the guest to try again if this fails due to a temporary
> resource availability.
> 
> > One comment below.
> >
> > >
> > > Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
> > > Reviewed-by: Anup Patel <anup@brainfault.org>
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > ---
> > >  arch/riscv/kvm/vcpu_pmu.c     | 14 +++++++++-----
> > >  arch/riscv/kvm/vcpu_sbi_pmu.c |  6 +++---
> > >  2 files changed, 12 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> > > index b1574c043f77..29bf4ca798cb 100644
> > > --- a/arch/riscv/kvm/vcpu_pmu.c
> > > +++ b/arch/riscv/kvm/vcpu_pmu.c
> > > @@ -229,8 +229,9 @@ static int kvm_pmu_validate_counter_mask(struct kvm_pmu *kvpmu, unsigned long ct
> > >       return 0;
> > >  }
> > >
> > > -static int kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
> > > -                                  unsigned long flags, unsigned long eidx, unsigned long evtdata)
> > > +static long kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_event_attr *attr,
> > > +                                   unsigned long flags, unsigned long eidx,
> > > +                                   unsigned long evtdata)
> > >  {
> > >       struct perf_event *event;
> > >
> > > @@ -454,7 +455,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
> > >                                    unsigned long eidx, u64 evtdata,
> > >                                    struct kvm_vcpu_sbi_return *retdata)
> > >  {
> > > -     int ctr_idx, ret, sbiret = 0;
> > > +     int ctr_idx, sbiret = 0;
> > > +     long ret;
> > >       bool is_fevent;
> > >       unsigned long event_code;
> > >       u32 etype = kvm_pmu_get_perf_event_type(eidx);
> > > @@ -513,8 +515,10 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
> > >                       kvpmu->fw_event[event_code].started = true;
> > >       } else {
> > >               ret = kvm_pmu_create_perf_event(pmc, &attr, flags, eidx, evtdata);
> > > -             if (ret)
> > > -                     return ret;
> > > +             if (ret) {
> > > +                     sbiret = SBI_ERR_NOT_SUPPORTED;
> > > +                     goto out;
> > > +             }
> > >       }
> > >
> > >       set_bit(ctr_idx, kvpmu->pmc_in_use);
> > > diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
> > > index 7eca72df2cbd..b70179e9e875 100644
> > > --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
> > > +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
> > > @@ -42,9 +42,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
> > >  #endif
> > >               /*
> > >                * This can fail if perf core framework fails to create an event.
> > > -              * Forward the error to userspace because it's an error which
> > > -              * happened within the host kernel. The other option would be
> > > -              * to convert to an SBI error and forward to the guest.
> > > +              * No need to forward the error to userspace and exit the guest
> >
> > Period after guest
> >
> >
> > > +              * operation can continue without profiling. Forward the
> >
> > The operation
> >
> 
> Fixed the above two.
> 
> 
> > > +              * appropriate SBI error to the guest.
> > >                */
> > >               ret = kvm_riscv_vcpu_pmu_ctr_cfg_match(vcpu, cp->a0, cp->a1,
> > >                                                      cp->a2, cp->a3, temp, retdata);
> > > --
> > > 2.34.1
> > >
> >
> > Thanks,
> > drew
> 
> 
> 
> --
> Regards,
> Atish

