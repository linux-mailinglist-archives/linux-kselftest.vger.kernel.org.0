Return-Path: <linux-kselftest+bounces-32994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1A8AB7AA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 02:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D62B8C4093
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 00:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE4072614;
	Thu, 15 May 2025 00:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVQ9JN6W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD3746E
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747269222; cv=none; b=SdRprCiY3JFlioiA9nsfIBYKubpwr57wy14r4i/IkoZ+JOxG3XDLHNhlmgSzmC0RJAIMC7nPHYhmsKPPo+Gi7Uy2PvvKycO1jh6F5dTjtjC1BAWuyMHwaZ27C+ysRSzt9rbaY33WdeKvcXPr541EuqrhCRr+S+s8hZW+bUdOe+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747269222; c=relaxed/simple;
	bh=kWsTqq0lhBMvBNJ0ZtIHiTgXO8OwzpD8p2bSnfGsB4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gvTcMy6K9DgL1MFAXPWAh5WVQ/svNB+00vEKzwGuAkVjRoV1B0DTsICdOV/JRG2fS1W1ckOxPY5w0gRLjxKubSKmdlXdiQYgcCHrIuuRFImwdhmkgjawEXaocZif3obfysBHzYHzmMPpHY0d6yoVUtBqdktv/pE5m/AQjDejvPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVQ9JN6W; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22fafbbe51fso5455515ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 17:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747269218; x=1747874018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rglF/R5KGMHdjiJ2t6dRwR5H/A5Ey37gucnisvzxi0s=;
        b=dVQ9JN6WuOjMcxel8aEUJzlHkH6MCVPTDm7b18SyF/CwUChE49fMCr1C8I48ag/PwH
         Is2mL3EBGGsbm2GvJpL1qS5PlZ8wfMi8fnvNmSLsow05W5hIAaemnpLqgTinOMO1IH4Z
         Y56ysH++uvrZ/3qlgLjiC+MHJTFb2aYH/WzrbOL4FH7G5cpBp/TkI9Eq9RwmlVSzIbun
         RJkREqPM703c6y82wFRmNEFFPjZaPzsH+R0fwCQK/xbwqxiJ/8nClSu4+6rBVOLChMzC
         1/DKKnQub04X1NCsb9bBitytLdYxhzOqZ/OOL744aqhbGtCz+9M20nKH0QP+Ee7144NX
         Hc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747269218; x=1747874018;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rglF/R5KGMHdjiJ2t6dRwR5H/A5Ey37gucnisvzxi0s=;
        b=WwchRi/Jl9ncJ4OKKzWnyi4fjp3KXJFOJjVkatrqFxRZGoQcSOHa79W1up1vvgSPAS
         YJFO6ODsmge6/bTvGcXp6x3c03Fuou4NzxkwWTjd2GyK9ZuYIPw7R3nLfqriPQHx7o5j
         QgzJGC+fSf/3SMpMKHfytXFeFgx5MW0+mJnXJokXHcP0srioynjuul53sO3oHOxH/wGL
         xjRbuihxRAlMws/I5DIF6dVTafCsuADeNiyPKcsa20LbU+T/yY/R+422H1F6WnoluJYF
         bcmJ59HvyBJbgpPSfIehStm+NQ9doD2bfAAbXQl07FW3pmXC3Obd5OOQyqihn5VioBDD
         oWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyphejfc98PUYp4gA1kna/m2ZzQuBUN2U2NhBrVmakPGuTokpB+bax7E/kgmKiAT0ppfZ9XFw3Aj47ygPXzKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt6GvixTAU6YWrsn5s7x6xmXoz6Zc509NoA9HS0adXXTUKV5NF
	3v5dQ0HGR1Lu1ojPpn90Ysnk83Y3BW2h1CQP+rDCB+b2ppKpavAVin7h6gGTnmlz07FIjei06a2
	kjQ==
X-Google-Smtp-Source: AGHT+IFk5amrAydk8MqHTBzn+9OeH6tHjtTovD4ZDO0wIQz+gLvtk/uGbMGbdXJBPpjYoOvEfN2C4N4FPJ8=
X-Received: from plblm5.prod.google.com ([2002:a17:903:2985:b0:223:fb3a:ac08])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cf:b0:220:e5be:29c7
 with SMTP id d9443c01a7336-231981a2d5fmr72176585ad.39.1747269218174; Wed, 14
 May 2025 17:33:38 -0700 (PDT)
Date: Wed, 14 May 2025 17:33:36 -0700
In-Reply-To: <CAL715WLfr5k=Rz0cQ08xS=eHEyRn83PBTiqQ5H7iX4qH=jiS8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-22-mizhang@google.com>
 <4d55c919-92ab-4bfe-a8c2-c0a756546f7c@intel.com> <CAL715WLfr5k=Rz0cQ08xS=eHEyRn83PBTiqQ5H7iX4qH=jiS8A@mail.gmail.com>
Message-ID: <aCU2YEpU0dOk7RTk@google.com>
Subject: Re: [PATCH v4 21/38] KVM: x86/pmu/vmx: Save/load guest
 IA32_PERF_GLOBAL_CTRL with vm_exit/entry_ctrl
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Eranian Stephane <eranian@google.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025, Mingwei Zhang wrote:
> On Wed, Mar 26, 2025 at 9:51=E2=80=AFAM Chen, Zide <zide.chen@intel.com> =
wrote:
> > > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > > index 6ad71752be4b..4e8cefcce7ab 100644
> > > --- a/arch/x86/kvm/pmu.c
> > > +++ b/arch/x86/kvm/pmu.c
> > > @@ -646,6 +646,30 @@ void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
> > >       }
> > >  }
> > >
> > > +static void kvm_pmu_sync_global_ctrl_from_vmcs(struct kvm_vcpu *vcpu=
)
> > > +{
> > > +     struct msr_data msr_info =3D { .index =3D MSR_CORE_PERF_GLOBAL_=
CTRL };
> > > +
> > > +     if (!kvm_mediated_pmu_enabled(vcpu))
> > > +             return;
> > > +
> > > +     /* Sync pmu->global_ctrl from GUEST_IA32_PERF_GLOBAL_CTRL. */
> > > +     kvm_pmu_call(get_msr)(vcpu, &msr_info);
> > > +}
> > > +
> > > +static void kvm_pmu_sync_global_ctrl_to_vmcs(struct kvm_vcpu *vcpu, =
u64 global_ctrl)
> > > +{
> > > +     struct msr_data msr_info =3D {
> > > +             .index =3D MSR_CORE_PERF_GLOBAL_CTRL,
> > > +             .data =3D global_ctrl };
> > > +
> > > +     if (!kvm_mediated_pmu_enabled(vcpu))
> > > +             return;
> > > +
> > > +     /* Sync pmu->global_ctrl to GUEST_IA32_PERF_GLOBAL_CTRL. */
> > > +     kvm_pmu_call(set_msr)(vcpu, &msr_info);

Eh, just add a dedicated kvm_pmu_ops hook.  Feeding this through set_msr() =
avoids
adding another hook, but makes the code hard to follow and requires the abo=
ve
ugly boilerplate.

> > > +}
> > > +
> > >  bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
> > >  {
> > >       switch (msr) {
> > > @@ -680,7 +704,6 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct=
 msr_data *msr_info)
> > >               msr_info->data =3D pmu->global_status;
> > >               break;
> > >       case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
> > > -     case MSR_CORE_PERF_GLOBAL_CTRL:
> > >               msr_info->data =3D pmu->global_ctrl;
> > >               break;
> > >       case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
> > > @@ -731,6 +754,9 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct=
 msr_data *msr_info)
> >
> >
> > pmu->global_ctrl doesn't always have the up-to-date guest value, need t=
o
> > sync from vmcs/vmbc before comparing it against 'data'.
> >
> > +               kvm_pmu_sync_global_ctrl_from_vmcs(vcpu);
> >                 if (pmu->global_ctrl !=3D data) {
>=20
> Good catch. Thanks!
>=20
> This is why I really prefer just unconditionally syncing the global
> ctrl from VMCS to pmu->global_ctrl and vice versa.
>=20
> We might get into similar problems as well in the future.

The problem isn't conditional synchronization, it's that y'all reinvented t=
he
wheel, poorly.  This is a solved problem via EXREG and wrappers.

That said, I went through the exercise of adding a PERF_GLOBAL_CTRL EXREG a=
nd
associated wrappers, and didn't love the result.  Host writes should be rar=
e, so
the dirty tracking is overkill.  For reads, the cost of VMREAD is lower tha=
n
VMWRITE (doesn't trigger consistency check re-evaluation on VM-Enter), and =
is
dwarfed by the cost of switching all other PMU state.

So I think for the initial implementation, it makes sense to propagated wri=
tes
to the VMCS on demand, but do VMREAD after VM-Exit (if VM-Enter was success=
ful).
We can always revisit the optimization if/when we optimize the PMU world sw=
itches,
e.g. to defer them if there are no active host events.

> > > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > > index 8a7af02d466e..ecf72394684d 100644
> > > --- a/arch/x86/kvm/vmx/nested.c
> > > +++ b/arch/x86/kvm/vmx/nested.c
> > > @@ -7004,7 +7004,8 @@ static void nested_vmx_setup_exit_ctls(struct v=
mcs_config *vmcs_conf,
> > >               VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
> > >               VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
> > >               VM_EXIT_SAVE_VMX_PREEMPTION_TIMER | VM_EXIT_ACK_INTR_ON=
_EXIT |
> > > -             VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
> > > +             VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
> > > +             VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL;

This is completely wrong.  Stuffing VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL here
advertises support for KVM emulation of the control, and that support is no=
n-existent
in this patch (and series).

Just drop this, emulation of VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL can be done
separately.

> > > +     mediated =3D kvm_mediated_pmu_enabled(vcpu);
> > > +     if (cpu_has_load_perf_global_ctrl()) {
> > > +             vm_entry_controls_changebit(vmx,
> > > +                     VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL, mediated);
> > > +             /*
> > > +              * Initialize guest PERF_GLOBAL_CTRL to reset value as =
SDM rules.
> > > +              *
> > > +              * Note: GUEST_IA32_PERF_GLOBAL_CTRL must be initialize=
d to
> > > +              * "BIT_ULL(pmu->nr_arch_gp_counters) - 1" instead of p=
mu->global_ctrl
> > > +              * since pmu->global_ctrl is only be initialized when g=
uest
> > > +              * pmu->version > 1. Otherwise if pmu->version is 1, pm=
u->global_ctrl
> > > +              * is 0 and guest counters are never really enabled.
> > > +              */
> > > +             if (mediated)
> > > +                     vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL,
> > > +                                  BIT_ULL(pmu->nr_arch_gp_counters) =
- 1);

This belongs in common code, as a call to the aforementioned hook to propag=
ate
PERF_GLOBAL_CTRL to hardware.

> > > +     }
> > > +
> > > +     if (cpu_has_save_perf_global_ctrl())
> > > +             vm_exit_controls_changebit(vmx,
> > > +                     VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
> > > +                     VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL, mediated);
> > >  }
> > >
> > >  static void intel_pmu_init(struct kvm_vcpu *vcpu)
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index ff66f17d6358..38ecf3c116bd 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -4390,6 +4390,13 @@ void vmx_set_constant_host_state(struct vcpu_v=
mx *vmx)
> > >
> > >       if (cpu_has_load_ia32_efer())
> > >               vmcs_write64(HOST_IA32_EFER, kvm_host.efer);
> > > +
> > > +     /*
> > > +      * Initialize host PERF_GLOBAL_CTRL to 0 to disable all counter=
s
> > > +      * immediately once VM exits. Mediated vPMU then call perf_gues=
t_exit()
> > > +      * to re-enable host perf events.
> > > +      */
> > > +     vmcs_write64(HOST_IA32_PERF_GLOBAL_CTRL, 0);

This needs to be conditioned on the mediated PMU being enabled, because thi=
s field
is not constant when using the emulated PMU (or no vPMU).

> > > @@ -8451,6 +8462,15 @@ __init int vmx_hardware_setup(void)
> > >               enable_sgx =3D false;
> > >  #endif
> > >
> > > +     /*
> > > +      * All CPUs that support a mediated PMU are expected to support=
 loading
> > > +      * and saving PERF_GLOBAL_CTRL via dedicated VMCS fields.
> > > +      */
> > > +     if (enable_mediated_pmu &&
> > > +         (WARN_ON_ONCE(!cpu_has_load_perf_global_ctrl() ||
> > > +                       !cpu_has_save_perf_global_ctrl())))

This needs to be conditioned on !HYPERVISOR, or it *will* fire.

And placing this check here, without *any* mention of *why* you did so, is =
evil
and made me very grumpy.  I had to discover the hard way that you checked t=
he
VMCS fields here, instead of in kvm_init_pmu_capability() where it logicall=
y
belongs, because the VMCS configuration isn't yet initialized.

Grumpiness aside, I don't like this late clear of enable_mediated_pmu, as i=
t risks
a variation of the problem you're trying to avoid, i.e. risks consuming the=
 variable
between kvm_init_pmu_capability() and here.

I don't see any reason why setup_vmcs_config() can't be called before
kvm_x86_vendor_init(), so unless I'm missing/forgetting something, let's ju=
st do
that, and move these checks where they belong.

