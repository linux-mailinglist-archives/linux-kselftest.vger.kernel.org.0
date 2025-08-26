Return-Path: <linux-kselftest+bounces-39961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D2EB36FFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 18:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E198A560F68
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD923164CA;
	Tue, 26 Aug 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="33ysxJx+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71F2D191C
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225053; cv=none; b=c5XsagS2E+a040PDtlsfFS6YOm4gfwK73evsU2cY8QJG0vyVX/Cr3j6YWNWsNqCQ09Utpd9zfU/RehScNIAa1bVk27juVGKcRUwKUSoqvthYDpXHr8XHzyKFvyjr5BAE+vwW/tlM2B666fHX602o7Npj2etuDAT0CIio8owdNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225053; c=relaxed/simple;
	bh=++ibIIwSee5BZlw9xsuvyKWduMwmT2ipzEDtn2qX8QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V09Is+s43fjdGBoHK4kOCq6ikVy6c//AQCVmaxXKgmWxXBLGfLLSXtGS/5mRUh6sm9f1zSOkSfJEU6lkbb/M9iJ1Q8wZKh63tH/Ri26M65sogXOC9orAs30Y2T1ZKbgcBmfllGfUtRJ2llDIYxiFG5feQEvTR4QG+LqnP0dAU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=33ysxJx+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b29b715106so274351cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 09:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756225050; x=1756829850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmeOjGewmIYdLLmpSjvv47FTEE8o/XmGhAICPfxGuEg=;
        b=33ysxJx+GIvGYPgduZI8p7yPsj3lePpLgr2pDIeXw8k+f0kI3XM1UnG1QVZ2PEyFLB
         W8kXsQPshX1NOGSggP8WZXZdHxaaH+z4yt6/CmM5Z4om+QifGfmhCXU0IVSVbVBuOfGT
         6PZn49le5EwUxLzfDEAPbkuEO7tN0rixO4qm9tmxs7wBHupuy0a1E4xfQ05sqpVzCKgt
         5rccP5FJETmUw+UJliN7E+GLZykOHVruBytoOrL3PR4pty93IRebQp26E7RpGNo0duKO
         IhRNe2AziWBzDqOEIqu/oaF4j7qBlVnpz7f2jHcxFv7tNK6/3MnOGby48lirQc3esxlJ
         e1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225050; x=1756829850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmeOjGewmIYdLLmpSjvv47FTEE8o/XmGhAICPfxGuEg=;
        b=kNMynDcoxuHFz058sON6FFjmEbeKr1qtR07nWkkfpvxXuaUes7bkopOLHuNmrlmcU7
         y0FQdoSVpX9ENKohPb1zh+NHLRMBCdfBgDB6Ow/073f8kYS78PpbHOLOh2fARd8stv+D
         NJ/2hKABcrpCza70lResG+1YMmoUcwkFXLXS/ayA8CRlvsiAKNZT68a1SUCENLGn45hh
         +o+x5d87rC/0f5waDIDq9sj+3VVBWKR0qj9cQ2YQLPtYdVT4RQKanFtiZTCW0dOveWoC
         iDEz61Kf9ZGdRkmWWjnQbsHJO8ssxBqhl3buRmwgk1LbJFZk7IHHgiqHPG15TF5aY8Rq
         HVDw==
X-Gm-Message-State: AOJu0YyZBu1GTD4/DAutyJQ0gMqgcj6U0qqztLdu3WL6UVIfiDQ4Cpqr
	X8cwNCMMpKeMgAH9MjjT2zQdvPJi1mcuWA4mdP8hMd1Qw3cQCjwBZiXaXSmrSIc39WRVTiBCVA1
	Q+Bdw27gPKWKJdmZgrMRPIsGHmhw9p8i9Td9yWyFq
X-Gm-Gg: ASbGncv79hnOTFflwINcaQFT6zU2CLs+PKyGcJiQPs0+1mNpksY1wn4fERG2kLeJr+2
	exdFQB2Ah71jXEkj3Z46BKUtoOmFwZzyl2WA4xUn9AOMVAKnmrl1BQB7Zr6IQRDfxg8HQIxx23u
	cJDiChV3/EyeQucBPjmRMLsxmhQ7Vn9I5b+61dfRHEdk9VjRaqvHc97zg8utP81oB2zYQnSGIv4
	/Xj+4pSzwHTpRScmhJHFv+KWuazVZpfaw7pLjyLAz8VB/4uCCtmh4MA
X-Google-Smtp-Source: AGHT+IG+wnBefR4Aymc6tYM8lOmHshFcJVJaVe41ASTYpqmV9yU3SdjF11Bbld00ig6mv+c4gYxK9oOnktn+3LIyzAk=
X-Received: by 2002:a05:622a:311:b0:4a7:1743:106b with SMTP id
 d75a77b69052e-4b2e1c96dbcmr6141361cf.6.1756225049246; Tue, 26 Aug 2025
 09:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-12-sagis@google.com>
 <8437255a-635d-4712-834a-fc8c02890d00@linux.intel.com>
In-Reply-To: <8437255a-635d-4712-834a-fc8c02890d00@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 26 Aug 2025 11:17:17 -0500
X-Gm-Features: Ac12FXzhaotM5fFrAx2rTRNTa2IlCD5CAPNHtJNuxqrdhQix7iWtknaTyf9fbgA
Message-ID: <CAAhR5DHSQuvDRMvv62Go=xMHpx77F7XRP3VqHmy+HEMSCMASgA@mail.gmail.com>
Subject: Re: [PATCH v9 11/19] KVM: selftests: Set up TDX boot parameters region
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:36=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
>
>
>
> On 8/21/2025 12:29 PM, Sagi Shahar wrote:
> > Allocate memory for TDX boot parameters and define the utility function=
s
> > necessary to fill this memory with the boot parameters.
> >
> > Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >   .../selftests/kvm/include/x86/tdx/tdx_util.h  |  4 +
> >   .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 73 ++++++++++++++++++=
+
> >   2 files changed, 77 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/t=
ools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > index ec05bcd59145..dafdc7e46abe 100644
> > --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > @@ -12,5 +12,9 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
> >   }
> >
> >   void vm_tdx_setup_boot_code_region(struct kvm_vm *vm);
> > +void vm_tdx_setup_boot_parameters_region(struct kvm_vm *vm, uint32_t n=
r_runnable_vcpus);
> > +void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
> > +void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vc=
pu *vcpu);
> > +void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_co=
de);
> >
> >   #endif // SELFTESTS_TDX_TDX_UTIL_H
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools=
/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > index 15833b9eb5d5..52dc25e0cce4 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > @@ -5,10 +5,12 @@
> >   #include "kvm_util.h"
> >   #include "processor.h"
> >   #include "tdx/td_boot.h"
> > +#include "tdx/td_boot_asm.h"
> >   #include "tdx/tdx_util.h"
> >
> >   /* Arbitrarily selected to avoid overlaps with anything else */
> >   #define TD_BOOT_CODE_SLOT   20
> > +#define TD_BOOT_PARAMETERS_SLOT      21
> >
> >   #define X86_RESET_VECTOR    0xfffffff0ul
> >   #define X86_RESET_VECTOR_SIZE       16
> > @@ -52,3 +54,74 @@ void vm_tdx_setup_boot_code_region(struct kvm_vm *vm=
)
> >       hva[1] =3D 256 - 2 - TD_BOOT_CODE_SIZE;
> >       hva[2] =3D 0xcc;
> >   }
> > +
> > +void vm_tdx_setup_boot_parameters_region(struct kvm_vm *vm, uint32_t n=
r_runnable_vcpus)
> > +{
> > +     size_t boot_params_size =3D
> > +             sizeof(struct td_boot_parameters) +
> > +             nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters)=
;
> > +     int npages =3D DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
> > +     vm_paddr_t gpa;
> > +
> > +     vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> > +                                 TD_BOOT_PARAMETERS_GPA,
> > +                                 TD_BOOT_PARAMETERS_SLOT, npages,
> > +                                 KVM_MEM_GUEST_MEMFD);
> > +     gpa =3D vm_phy_pages_alloc(vm, npages, TD_BOOT_PARAMETERS_GPA, TD=
_BOOT_PARAMETERS_SLOT);
> > +     TEST_ASSERT(gpa =3D=3D TD_BOOT_PARAMETERS_GPA, "Failed vm_phy_pag=
es_alloc\n");
> > +
> > +     virt_map(vm, TD_BOOT_PARAMETERS_GPA, TD_BOOT_PARAMETERS_GPA, npag=
es);
> > +}
> > +
> > +void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm)
> > +{
> > +     struct td_boot_parameters *params =3D
> > +             addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> > +     uint32_t cr4;
> > +
> > +     TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
> > +
> > +     cr4 =3D kvm_get_default_cr4();
> > +
> > +     /* TDX spec 11.6.2: CR4 bit MCE is fixed to 1 */
> > +     cr4 |=3D X86_CR4_MCE;
> > +
> > +     /* Set this because UEFI also sets this up, to handle XMM excepti=
ons */
> > +     cr4 |=3D X86_CR4_OSXMMEXCPT;
> > +
> > +     /* TDX spec 11.6.2: CR4 bit VMXE and SMXE are fixed to 0 */
> > +     cr4 &=3D ~(X86_CR4_VMXE | X86_CR4_SMXE);
> > +
> > +     /* Set parameters! */
> > +     params->cr0 =3D kvm_get_default_cr0();
> > +     params->cr3 =3D vm->pgd;
> > +     params->cr4 =3D cr4;
> > +     params->idtr.base =3D vm->arch.idt;
> > +     params->idtr.limit =3D kvm_get_default_idt_limit();
> > +     params->gdtr.base =3D vm->arch.gdt;
> > +     params->gdtr.limit =3D kvm_get_default_gdt_limit();
> > +
> > +     TEST_ASSERT(params->cr0 !=3D 0, "cr0 should not be 0");
> > +     TEST_ASSERT(params->cr3 !=3D 0, "cr3 should not be 0");
> > +     TEST_ASSERT(params->cr4 !=3D 0, "cr4 should not be 0");
> > +     TEST_ASSERT(params->gdtr.base !=3D 0, "gdt base address should no=
t be 0");
> > +     TEST_ASSERT(params->idtr.base !=3D 0, "idt base address should no=
t be 0");
> > +}
> > +
> > +void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vc=
pu *vcpu)
> > +{
> > +     struct td_boot_parameters *params =3D
> > +             addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> > +     struct td_per_vcpu_parameters *vcpu_params =3D
> > +             &params->per_vcpu[vcpu->id];
>
> Nit: Better to align the style on whether wrap or not due to max characte=
rs per
> line
>

Thanks, going to wrap in both functions.

> > +
> > +     vcpu_params->esp_gva =3D kvm_allocate_vcpu_stack(vm);
> > +}
> > +
> > +void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_co=
de)
> > +{
> > +     struct td_boot_parameters *params =3D addr_gpa2hva(vcpu->vm, TD_B=
OOT_PARAMETERS_GPA);
> > +     struct td_per_vcpu_parameters *vcpu_params =3D &params->per_vcpu[=
vcpu->id];
> > +
> > +     vcpu_params->guest_code =3D (uint64_t)guest_code;
> > +}
>

