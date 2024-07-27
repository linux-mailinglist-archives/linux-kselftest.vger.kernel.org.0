Return-Path: <linux-kselftest+bounces-14315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58E893E16E
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 01:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68646281D43
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 23:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230F645026;
	Sat, 27 Jul 2024 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zYpo5NaO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3D28E0F
	for <linux-kselftest@vger.kernel.org>; Sat, 27 Jul 2024 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722122652; cv=none; b=lJ64P255E+KTcRXcM8NLHnp4FgZR2ImY3pdPhQI38+z0lAVCu8La4wDEnIE9bXiFp0PuAMx+Rnl8lvukamtukOSYEiGu0n1FBpglYVmCADfLki7umfv6mZM5H35i0Ako8PNptlevNUB8JyTld1V3JiJ1TB1ynJ0CEya2IEtlId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722122652; c=relaxed/simple;
	bh=nuO7vzihiJv1c6VfvqZ9dopzSQV/yn3omJmNNFU5Fkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBqXBdHsPDSKilLQjluQvni4d0Q8vtMte5idyYV2fQk7jK/3xHLkgCmgWGRaXQk4crAfYmOtuTi77Vm2f/T3ft0wurLSUKoSxFfOwIgAMTkNUbChX9kQeEvhEZ56fFTub4blgn8jcgAuNWskDjFiTi91NRbZGq0r2D1oD2LUnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zYpo5NaO; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-65fdfd7b3deso8689097b3.0
        for <linux-kselftest@vger.kernel.org>; Sat, 27 Jul 2024 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722122649; x=1722727449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4yEmtYniciXoEKJkwuK70Tje2jx27N9dXaU+niH9co=;
        b=zYpo5NaOZKifxjcXBIZtgnoNmtSzn7UbTwKqcZSojPeCBtr/Pz3/Tp9qe9KGUhk8cf
         yyV/zde0HBhRjeV68cb1rj8wwuYPT7l2+yEv2lAbs6wMD+qCVClBWCE9Ifwn4DWQ/yVQ
         xebkPJbhUmK8RQL8DGxdbi7u0nq7BRg4RVnL7/qIHfkCN6KnKx+dqQUVsPl7VJl+8Bjf
         x/y2Hwbt2LFTShCOF29Rsv3PHzr2j2QdACN9vTHLEO0I0cuz+/B5xn8aEF6Dg97FaogZ
         1kVcd4aZ58bLdK8jaQC77150cEGS0bf5GiHccGQ9VzoalFjgxj4EgNgZSY+2s8yWtTSP
         X8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722122649; x=1722727449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4yEmtYniciXoEKJkwuK70Tje2jx27N9dXaU+niH9co=;
        b=HQokrlOVWdHl39pzZhcyi1JohW3yagWq+pK5PaR/vBbJfUnW/9S9Mrsiq31nJ2j2ml
         kce6Z6z49Vtj5FNKpei9l2TER3qJKH8ngd4VJsc8soDsAIycJou6poaxMRW5gBowzvgV
         bpxROQVicq50FX/nkjcH7vahlin1SF8PGd2vWRDh7uVA7pxtRw2sy0iOFBiiMDffwIZ+
         WbZ819psHIP7k/jtGOk5KonutKNpepNNjFD8ls79qTDZVF2ZIdLLw2hjVVAsAECT6Bwr
         DSG/JiIGMc6RuJ+KSTTlAEzMLmoPU+rCAE/IaXTUr5uEgM86K9KmtKnyUVo8oFQSqLBK
         m5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtSLb2c00hPU0Ix+XU1m4Y1jDK6RvX2BBdw1CHxEkuFBI/eiAnDae2O7vFCVz2NFHbNG5JzTj41KmvlvyQQ+qh5d6Zi/UpJgB1r1zl9Bp9
X-Gm-Message-State: AOJu0YxFpnDa+K4VdVwvfW0E+zkBBOd9/HU/g0vRLJQICfTPkP4S8ClU
	wtEfk8T/rpElpjHY5zZzcxUgFUCQiA5TSFfvR/nW0XajAXOTkEjSJzgqgyv9zNmdMaGDHFVcnkB
	LbIjROWIzkRWdoAO41myLiwvzKaCGCCiIY+0O
X-Google-Smtp-Source: AGHT+IG1neJarxOVV2rFw+9+KTUgqO5z/Fa+YpV+zqf45OHqYeGWexbbXnHWKJ38xmTobbKVm/7ogvEDWeuam+aKcGA=
X-Received: by 2002:a05:6902:10c1:b0:e0b:5fdb:1cd9 with SMTP id
 3f1490d57ef6-e0b5fdb302emr2156487276.35.1722122649068; Sat, 27 Jul 2024
 16:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com> <20231212204647.2170650-17-sagis@google.com>
 <1f9d2b41-95ad-42ca-b1e5-70212b93a9c1@linux.intel.com> <ZeawWs9cAhjLb/YO@yzhao56-desk.sh.intel.com>
In-Reply-To: <ZeawWs9cAhjLb/YO@yzhao56-desk.sh.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Sat, 27 Jul 2024 18:23:56 -0500
Message-ID: <CAAhR5DGBkrRaG2OmrOnKy6wRhxi0-MxiPthEuRfkGY9ZGWR7PQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 16/29] KVM: selftests: TDX: Add TDX HLT exit test
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, linux-kselftest@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Erdem Aktas <erdemaktas@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:10=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:
>
> On Sat, Mar 02, 2024 at 03:31:07PM +0800, Binbin Wu wrote:
> > On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> > > The test verifies that the guest runs TDVMCALL<INSTRUCTION.HLT> and t=
he
> > > guest vCPU enters to the halted state.
> > >
> > > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > > Signed-off-by: Sagi Shahar <sagis@google.com>
> > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > Signed-off-by: Ryan Afranji <afranji@google.com>
> > > ---
> > >   .../selftests/kvm/include/x86_64/tdx/tdx.h    |  2 +
> > >   .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 10 +++
> > >   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 78 ++++++++++++++++=
+++
> > >   3 files changed, 90 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/t=
ools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> > > index 85ba6aab79a7..b18e39d20498 100644
> > > --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> > > +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> > > @@ -8,6 +8,7 @@
> > >   #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
> > >   #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
> > > +#define TDG_VP_VMCALL_INSTRUCTION_HLT 12
> > >   #define TDG_VP_VMCALL_INSTRUCTION_IO 30
> > >   #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
> > >   #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
> > > @@ -20,5 +21,6 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t =
*r11, uint64_t *r12,
> > >                                     uint64_t *r13, uint64_t *r14);
> > >   uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *=
ret_value);
> > >   uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t v=
alue);
> > > +uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_fl=
ag);
> > >   #endif // SELFTEST_TDX_TDX_H
> > > diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools=
/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> > > index 88ea6f2a6469..9485bafedc38 100644
> > > --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> > > +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> > > @@ -114,3 +114,13 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_=
t index, uint64_t value)
> > >     return __tdx_hypercall(&args, 0);
> > >   }
> > > +
> > > +uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_fl=
ag)
> > > +{
> > > +   struct tdx_hypercall_args args =3D {
> > > +           .r11 =3D TDG_VP_VMCALL_INSTRUCTION_HLT,
> > > +           .r12 =3D interrupt_blocked_flag,
> > > +   };
> > > +
> > > +   return __tdx_hypercall(&args, 0);
> > > +}
> > > diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tool=
s/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> > > index 5db3701cc6d9..5fae4c6e5f95 100644
> > > --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> > > +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> > > @@ -721,6 +721,83 @@ void verify_guest_msr_writes(void)
> > >     printf("\t ... PASSED\n");
> > >   }
> > > +/*
> > > + * Verifies HLT functionality.
> > > + */
> > > +void guest_hlt(void)
> > > +{
> > > +   uint64_t ret;
> > > +   uint64_t interrupt_blocked_flag;
> > > +
> > > +   interrupt_blocked_flag =3D 0;
> > > +   ret =3D tdg_vp_vmcall_instruction_hlt(interrupt_blocked_flag);
> > > +   if (ret)
> > > +           tdx_test_fatal(ret);
> > > +
> > > +   tdx_test_success();
> > > +}
> > > +
> > > +void _verify_guest_hlt(int signum);
> > > +
> > > +void wake_me(int interval)
> > > +{
> > > +   struct sigaction action;
> > > +
> > > +   action.sa_handler =3D _verify_guest_hlt;
> > > +   sigemptyset(&action.sa_mask);
> > > +   action.sa_flags =3D 0;
> > > +
> > > +   TEST_ASSERT(sigaction(SIGALRM, &action, NULL) =3D=3D 0,
> > > +               "Could not set the alarm handler!");
> > > +
> > > +   alarm(interval);
> > > +}
> > > +
> > > +void _verify_guest_hlt(int signum)
> > > +{
> > > +   struct kvm_vm *vm;
> > > +   static struct kvm_vcpu *vcpu;
> > > +
> > > +   /*
> > > +    * This function will also be called by SIGALRM handler to check =
the
> > > +    * vCPU MP State. If vm has been initialized, then we are in the =
signal
> > > +    * handler. Check the MP state and let the guest run again.
> > > +    */
> > > +   if (vcpu !=3D NULL) {
> >
> > What if the following case if there is a bug in KVM so that:
> >
> > In guest, execution of tdg_vp_vmcall_instruction_hlt() return 0, but th=
e
> > vcpu is not actually halted. Then guest will call tdx_test_success().
> >
> > And the first call of _verify_guest_hlt() will call kvm_vm_free(vm) to =
free
> > the vm, which also frees the vcpu, and 1 second later, in this path vcp=
u
> > will
> > be accessed after free.
> >
> Right. Another possibility is that if buggy KVM returns success to guest
> without putting guest to halted state, the selftest will still print
> "PASSED" because the second _verify_guest_hlt() (after waiting for 1s)
> has no chance to get executed before the process exits.
>
It sounds like in both cases we're going to hit an assert at some
point. If the VM was already freed then vcpu_mp_state_get will fail
the ioctl and assert internally or crash the process. If the guest
never halts and vcpu is still valid then the mp state assert will
fire. Either way it would be pretty obvious that something is wrong.


> > > +           struct kvm_mp_state mp_state;
> > > +
> > > +           vcpu_mp_state_get(vcpu, &mp_state);
> > > +           TEST_ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_HALTED);
> > > +
> > > +           /* Let the guest to run and finish the test.*/
> > > +           mp_state.mp_state =3D KVM_MP_STATE_RUNNABLE;
> > > +           vcpu_mp_state_set(vcpu, &mp_state);
> > > +           return;
> > > +   }
> > > +
> > > +   vm =3D td_create();
> > > +   td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> > > +   vcpu =3D td_vcpu_add(vm, 0, guest_hlt);
> > > +   td_finalize(vm);
> > > +
> > > +   printf("Verifying HLT:\n");
> > > +
> > > +   printf("\t ... Running guest\n");
> > > +
> > > +   /* Wait 1 second for guest to execute HLT */
> > > +   wake_me(1);
> > > +   td_vcpu_run(vcpu);
> > > +
> > > +   TDX_TEST_ASSERT_SUCCESS(vcpu);
> > > +
> > > +   kvm_vm_free(vm);
> > > +   printf("\t ... PASSED\n");
> > > +}
> > > +
> > > +void verify_guest_hlt(void)
> > > +{
> > > +   _verify_guest_hlt(0);
> > > +}
> > >   int main(int argc, char **argv)
> > >   {
> > > @@ -740,6 +817,7 @@ int main(int argc, char **argv)
> > >     run_in_new_process(&verify_guest_reads);
> > >     run_in_new_process(&verify_guest_msr_writes);
> > >     run_in_new_process(&verify_guest_msr_reads);
> > > +   run_in_new_process(&verify_guest_hlt);
> > >     return 0;
> > >   }
> >
> >

