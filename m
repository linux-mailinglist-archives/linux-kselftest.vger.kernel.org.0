Return-Path: <linux-kselftest+bounces-13926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E077A937A3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 17:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3772FB21240
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C1E145B25;
	Fri, 19 Jul 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aouf/E/9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB36FD3
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jul 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721404745; cv=none; b=g9+8z8PhHu8O+3wc4J0ON2YtU6DFH8FYvHGGm+T9J0QHAeZNi9FUCGvvpxNVl2Tm7TbsthY3b2DWZcJ8+3poMuYzwstqBnna7UMReUUTy74fwLveghLjoILYbcrLhVogGOBu6LdogsMkzcaLiOoZ4/gGBFeV6FxqCeDg+Rp5q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721404745; c=relaxed/simple;
	bh=S6gA3Pky3kRLWgK4099csZaRIGqlKAMPaKHzObsFk4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=plnCB2E33+etupCol0twNf2+9elNoE6Sktdurc5OUzT1yfML31g0zssqKQWJRHPf/8NO6J1XioyVy7oCXPH8bdcUTL7wEkGnHJ/m9lzCDFdXrAEggd2dXYX1w98Wppqz3FrcOd4JyzuzhhFfX/hhzMeLwUb5B/G4bnjDMPEG/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aouf/E/9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e036440617fso5063424276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jul 2024 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721404742; x=1722009542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmVLmXG6HUEZ1zgQ+Jo6sV2CT1wbQkb6tcz4M5bcpCY=;
        b=aouf/E/9E4Ri8oCj1ZuzrffA5K4UHrrHMfyFMzseXcKnahwdZYIsBWsh/SXgn2Sv3o
         Qprc7KNA6bMINzwZrfu5W2fD65E0KQ7ElwopVSlGedZH4RJ2u32dSHTBQpmzkt1J9YeB
         Afbj/V14ksvd+lygVbawphe3RtpaCGPB5puHI7M5jS7zcKMx4kCVy+Ue5LYrlmqv803y
         wYdzRIA1Khh+z4DzbpEOaBkcWH878WETOcGj3KULf8223SGini0WuvQrb+YlqKjtY5gl
         R8mnE3A0yna9a+wPb3hOJZJ32VdllhYXZj532xAWH1yM2PEVfD223dH0uj11aYYYftmM
         zY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721404742; x=1722009542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmVLmXG6HUEZ1zgQ+Jo6sV2CT1wbQkb6tcz4M5bcpCY=;
        b=oNeytl0P41fQRCR9yv7zHHX50ZH0f/rbHSd7CsPHGOf9dH34nB93kBADQ9JNXs4Sh2
         U22IZioU94J1owSALSqtxSs4/g3UedEWtbcf6boIt0SU6ulxv/YgyFqFPquhlqjH5xp5
         aMDqsGC2IMB1VucX/Fd6xoZB3HVNBtszRTNG4j1fx4hS8J3+z+qo67CgXEhArr7pDgPV
         0uo0uZpy665xyQVEsI7JI6/rTSIXLWFxNxbr25/zCNUTszmx5oLKuox3qlCZp39wSb2C
         8an/2kSiyw5ugg26rUAfOl2HcdPEhxWSZOVm5RqyqfUBxyfpBQpcVmatQ8tWQzZP9/8D
         4Pmg==
X-Forwarded-Encrypted: i=1; AJvYcCUaMi7DqULUl6s7sRrwka8k7Q3Rbwj5sz9/IaGy2o/4sb3cwEVIP2F9n43BHcP0NR3AhhePgo7wlQUy5lCnZPwvRr6XF4zrpdGhLDUCUWxC
X-Gm-Message-State: AOJu0YwbV9iigBivyrLY3pdS20okTKWTJhbh18k4aXuFxYAYKVcB0W2O
	5c0IWV57OWzMF8/Qy1IMgDSIMTP5mdYlhtk0e3MrC4c+PjAArD13L/Ofaa3cqDnkCvtraZO7Jk6
	cxw==
X-Google-Smtp-Source: AGHT+IEpJ18W6MbHK885Kx8gIxJoghb67upLSE4Rrad0klqxY1BrfqtTnDl4Xu8dBPLpSgMh4ccA4wiMAMM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:114b:b0:e05:6532:166 with SMTP id
 3f1490d57ef6-e086fdea67cmr166276.1.1721404741724; Fri, 19 Jul 2024 08:59:01
 -0700 (PDT)
Date: Fri, 19 Jul 2024 08:59:00 -0700
In-Reply-To: <099D0BF1-BDC6-489F-B780-174AFEE8F491@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-10-xin3.li@intel.com>
 <ZmoYvcbFBPJ5ARma@google.com> <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFH86n_YY5ModwK@google.com> <099D0BF1-BDC6-489F-B780-174AFEE8F491@zytor.com>
Message-ID: <ZpqNREwyn4LzN2tp@google.com>
Subject: Re: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and guest
From: Sean Christopherson <seanjc@google.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xin3 Li <xin3.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"shuah@kernel.org" <shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, Ravi V Shankar <ravi.v.shankar@intel.com>, 
	"xin@zytor.com" <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 18, 2024, H. Peter Anvin wrote:
> On July 12, 2024 8:12:51 AM PDT, Sean Christopherson <seanjc@google.com> wrote:
> >On Wed, Jul 10, 2024, Xin3 Li wrote:
> >> > On Wed, Feb 07, 2024, Xin Li wrote:
> >> > > Switch MSR_IA32_FRED_RSP0 between host and guest in
> >> > > vmx_prepare_switch_to_{host,guest}().
> >> > >
> >> > > MSR_IA32_FRED_RSP0 is used during ring 3 event delivery only, thus
> >> > > KVM, running on ring 0, can run safely with guest FRED RSP0, i.e., no
> >> > > need to switch between host/guest FRED RSP0 during VM entry and exit.
> >> > >
> >> > > KVM should switch to host FRED RSP0 before returning to user level,
> >> > > and switch to guest FRED RSP0 before entering guest mode.
> >> > 
> >> > Heh, if only KVM had a framework that was specifically designed for context
> >> > switching MSRs on return to userspace.  Translation: please use the
> >> > user_return_msr() APIs.
> >> 
> >> IIUC the user return MSR framework works for MSRs that are per CPU
> >> constants, but like MSR_KERNEL_GS_BASE, MSR_IA32_FRED_RSP0 is a per
> >> *task* constant, thus we can't use it.
> >
> >Ah, in that case, the changelog is very misleading and needs to be fixed.
> >Alternatively, is the desired RSP0 value tracked anywhere other than the MSR?
> >E.g. if it's somewhere in task_struct, then kvm_on_user_return() would restore
> >the current task's desired RSP0.  Even if we don't get fancy, avoiding the RDMSR
> >to get the current task's value would be nice.
> 
> Hm, perhaps the right thing to do is to always invoke this function before a
> context switch happens if that happens before return to user space?

Actually, if the _TIF_NEED_RSP0_LOAD doesn't provide a meaningful benefit (or
y'all just don't want it :-) ), what KVM could do is restore MSR_IA32_FRED_RSP0
when putting the vCPU and the vCPU is not being scheduled out, i.e. if and only
if KVM can't guarantee a context switch.

If the vCPU/task is being scheduled out, update_task_stack() is guaranteed to
write MSR_IA32_FRED_RSP0 with the new task's value.

On top of kvm/next, which adds the necessary vcpu->scheduled_out:

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5c6bb26463e8..4532ae943f2a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1338,15 +1338,9 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 
        wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 
-       if (guest_can_use(vcpu, X86_FEATURE_FRED)) {
-               /*
-                * MSR_IA32_FRED_RSP0 is top of task stack, which never changes.
-                * Thus it should be initialized only once.
-                */
-               if (unlikely(vmx->msr_host_fred_rsp0 == 0))
-                       vmx->msr_host_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
-               wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_guest_fred_rsp0);
-       }
+       if (cpu_feature_enabled(X86_FEATURE_FRED) &&
+           guest_can_use(vcpu, X86_FEATURE_FRED))
+               wrmsrns(MSR_IA32_FRED_RSP0, vmx->msr_guest_fred_rsp0);
 #else
        savesegment(fs, fs_sel);
        savesegment(gs, gs_sel);
@@ -1392,9 +1386,13 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
 #ifdef CONFIG_X86_64
        wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_host_kernel_gs_base);
 
-       if (guest_can_use(&vmx->vcpu, X86_FEATURE_FRED)) {
+       if (cpu_feature_enabled(X86_FEATURE_FRED) &&
+           guest_can_use(&vmx->vcpu, X86_FEATURE_FRED)) {
                vmx->msr_guest_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
-               wrmsrl(MSR_IA32_FRED_RSP0, vmx->msr_host_fred_rsp0);
+
+               if (!vcpu->scheduled_out)
+                       wrmsrns(MSR_IA32_FRED_RSP0,
+                                (unsigned long)task_stack_page(task) + THREAD_SIZE);
        }
 #endif
        load_fixmap_gdt(raw_smp_processor_id());


