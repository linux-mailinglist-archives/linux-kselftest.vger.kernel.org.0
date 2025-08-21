Return-Path: <linux-kselftest+bounces-39433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE1CB2ECAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80395E513B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2BB2797AE;
	Thu, 21 Aug 2025 04:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNZALIag"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88215747D
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755749960; cv=none; b=hKyQG7eZ/3gYn0ecI6DPbA2/hYJIxf5WkAIUtDG+/fdkPi+bi1SNMZXfVCkKLrjI6FcWj0VxsxPIITZkvXgbpWfzEb3Y3Fan1z04SqX6iyoaPj1zNYk2bFd0dk87XilGZs6Yk2x2QEpEKCHur3+KdKCm76JOyhX9/ZOibBZfX68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755749960; c=relaxed/simple;
	bh=mLMFC0C3/5IYPZBdGWGfi6UMw0OxU4iEzKoZF3Geulw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSJFaxT1y6lboQ1Rq97iA5x0urtSBMZohRMWBN7FyYyO6UI/VDCCSExB73Orpkevn9LlFLlTTvRAuB5Q3UsqWJBBhDSpe3KHCsUUnySSqCm00QiTMPOa5AJlBf7MzRqY6PSAMiWxOjOniJgSNtJiXotrqr1dFOS5Lz7rgo6lH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNZALIag; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b12b123e48so189541cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755749957; x=1756354757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OikHl75TpFQqjnLWQ+CU37QDx0j9NBeqS6pI2A2u2ic=;
        b=SNZALIagKi8AQKyNrotiPdDsIQwyVQ0SlA4yqkaqyWOLbcqla0yufv0B5UmQp/x8z9
         wjhvij3JVRWUJQ1KuEwOyiQ2QbzPu8sGzG5g5bAb8AIFdycZ8EPenqEHLmJ36Ye9suW8
         EI+rdzWO19HtZE2SCgcfRUlFQCHxorDLrzDdD8dt9mEp1SlhskzxWsYXxa1gkTGs1TFw
         vktCQK6L4LeY0IGpoy+nSK/DhMUzVy3QdMNx5khcItxFcu6z6aPIssH0EK2msSS7/uHu
         zr0Qj4N82ru4nSSP1RYwroRyUggvVLk2TTJksQE3fJj3qEfTKPTDoRMzvbQ79TN5D/Eg
         MFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755749957; x=1756354757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OikHl75TpFQqjnLWQ+CU37QDx0j9NBeqS6pI2A2u2ic=;
        b=IN8lx8LbrJPNTaHBWDPBMonmE+QhL26Lg8R5uh2Bk0RBGgfegbTgxIt/5jgWpV60X0
         Yzi4XtMcLinPuqaE4CryT7zbR7wvNHFXJST6BHKJ4HJTWTFnGlXEDXH3jSGMUHfdMfko
         YNuEHcDUJqLSSs+Pau+VB34qkBB1HeDyYP9MSx3tbwd5HxDlufga8nbOoxcLkyHGS7cZ
         9FWFqObkii11QUhOZy3x0FV2zgM9Cgkj3r3Yvu4V6UeVJqiU98B5rWfjVsvoMt/xQ0y3
         YLFLMSvQNELD5qTTWEzPeTT3/XlltG2JcWtkI9wvlJE1/PXKqdYcEaw/RIHil7Wk98Ak
         uh8Q==
X-Gm-Message-State: AOJu0Yw95LJwbkhZTZtMxyTehyhy/hNNO8+Rq7+8zONdqc+1R6FXV0TT
	wwBLlmmge8Hwwo+R6iZeJGKHjeMNqPcDwAaIaAkTDNxiS6i2tQ9Zh9yepTije3EpoAd6VBJoAKr
	Cbxg+essRk0dTlLsGD3aYq3afmxKxC2+LrPjkRMDD
X-Gm-Gg: ASbGncvcz+Yfc6NIKj5+K8/cF5O04GkM/dIknB/GPp0vxueMiGJ5l7QKPqTxrdVVCxu
	81QauuTfHQ8e6GNBFaF3uy3O6QIpbqwpMHxtAXC2zUpZNC7AZ2dsVCDCRef08I/dJC+Y/PRlW1V
	cQydybeibTUXCZ7pdeilRisH3ZyTahxHcI+70k3RRBaSeVPZgWuLQeHHcTpZu02Ykd6/MAcMB+V
	o/kn8kRzWfpnDezmckT27JRD2nw6lMvQqIYZBjSKFuCPzprAPcwUAG4DA==
X-Google-Smtp-Source: AGHT+IGWmsTXJmBRgJBzasw3DCVPv4lv0w0VS3ocPl3iXFrzV0AfTLjliYvzYDW+ciEP5sRu/pcLhUivCZTe0zqOPuA=
X-Received: by 2002:a05:622a:113:b0:4a9:e17a:6288 with SMTP id
 d75a77b69052e-4b29fa36463mr1929161cf.13.1755749956987; Wed, 20 Aug 2025
 21:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-10-sagis@google.com>
 <dd008c55-e92e-4762-9ca3-fa05eec34db8@linux.intel.com>
In-Reply-To: <dd008c55-e92e-4762-9ca3-fa05eec34db8@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Wed, 20 Aug 2025 23:19:05 -0500
X-Gm-Features: Ac12FXzcp8TGqKXljdY_4b0NeJYdvWFh4R6V40TiHmdHUxDMuWpkaJn1yEtE7dw
Message-ID: <CAAhR5DGuKBSpxmvC1URZJoZuD+_o7p1fTBOVZk3fjnaiWfGQ3A@mail.gmail.com>
Subject: Re: [PATCH v8 09/30] KVM: selftests: TDX: Add TDX lifecycle test
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:36=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
>
>
>
> On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> > From: Erdem Aktas <erdemaktas@google.com>
> >
> > Adding a test to verify TDX lifecycle by creating a TD and running a
> > dummy TDG.VP.VMCALL <Instruction.IO> inside it.
> >
> > Co-developed-by: Sagi Shahar <sagis@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >   tools/testing/selftests/kvm/Makefile.kvm      |  4 +
> >   .../selftests/kvm/include/x86/tdx/tdcall.h    | 32 +++++++
> >   .../selftests/kvm/include/x86/tdx/tdx.h       | 12 +++
> >   .../selftests/kvm/include/x86/tdx/test_util.h | 41 ++++++++
> >   .../selftests/kvm/lib/x86/tdx/tdcall.S        | 95 ++++++++++++++++++=
+
> >   tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 27 ++++++
> >   .../selftests/kvm/lib/x86/tdx/test_util.c     | 61 ++++++++++++
> >   tools/testing/selftests/kvm/x86/tdx_vm_test.c | 47 +++++++++
> >   8 files changed, 319 insertions(+)
> >   create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdcall=
.h
> >   create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> >   create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/test_u=
til.h
> >   create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
> >   create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> >   create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/test_util.=
c
> >   create mode 100644 tools/testing/selftests/kvm/x86/tdx_vm_test.c
>
> It's better to split the patch to the lib/utility part and the test case =
part.
>

I will split it in v9.

> >
> > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/s=
elftests/kvm/Makefile.kvm
> > index b429c92e07d8..4a147d498bd2 100644
> > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > @@ -31,6 +31,9 @@ LIBKVM_x86 +=3D lib/x86/ucall.c
> >   LIBKVM_x86 +=3D lib/x86/vmx.c
> >   LIBKVM_x86 +=3D lib/x86/tdx/tdx_util.c
> >   LIBKVM_x86 +=3D lib/x86/tdx/td_boot.S
> > +LIBKVM_x86 +=3D lib/x86/tdx/tdcall.S
> > +LIBKVM_x86 +=3D lib/x86/tdx/tdx.c
> > +LIBKVM_x86 +=3D lib/x86/tdx/test_util.c
> >
> >   LIBKVM_arm64 +=3D lib/arm64/gic.c
> >   LIBKVM_arm64 +=3D lib/arm64/gic_v3.c
> > @@ -148,6 +151,7 @@ TEST_GEN_PROGS_x86 +=3D rseq_test
> >   TEST_GEN_PROGS_x86 +=3D steal_time
> >   TEST_GEN_PROGS_x86 +=3D system_counter_offset_test
> >   TEST_GEN_PROGS_x86 +=3D pre_fault_memory_test
> > +TEST_GEN_PROGS_x86 +=3D x86/tdx_vm_test
> >
> >   # Compiled outputs used by test targets
> >   TEST_GEN_PROGS_EXTENDED_x86 +=3D x86/nx_huge_pages_test
> > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h b/too=
ls/testing/selftests/kvm/include/x86/tdx/tdcall.h
> > new file mode 100644
> > index 000000000000..a6c966e93486
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Adapted from arch/x86/include/asm/shared/tdx.h */
> > +
> > +#ifndef SELFTESTS_TDX_TDCALL_H
> > +#define SELFTESTS_TDX_TDCALL_H
> > +
> > +#include <linux/bits.h>
> > +#include <linux/types.h>
> > +
> > +#define TDX_HCALL_HAS_OUTPUT BIT(0)
> > +
> > +#define TDX_HYPERCALL_STANDARD 0
> > +
> > +/*
> > + * Used in __tdx_hypercall() to pass down and get back registers' valu=
es of
> > + * the TDCALL instruction when requesting services from the VMM.
> > + *
> > + * This is a software only structure and not part of the TDX module/VM=
M ABI.
> > + */
> > +struct tdx_hypercall_args {
> > +     u64 r10;
> > +     u64 r11;
> > +     u64 r12;
> > +     u64 r13;
> > +     u64 r14;
> > +     u64 r15;
> > +};
> > +
> > +/* Used to request services from the VMM */
> > +u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long fla=
gs);
> > +
> > +#endif // SELFTESTS_TDX_TDCALL_H
> > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/=
testing/selftests/kvm/include/x86/tdx/tdx.h
> > new file mode 100644
> > index 000000000000..a7161efe4ee2
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef SELFTEST_TDX_TDX_H
> > +#define SELFTEST_TDX_TDX_H
> > +
> > +#include <stdint.h>
> > +
> > +#define TDG_VP_VMCALL_INSTRUCTION_IO 30
> > +
> > +uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> > +                                   uint64_t write, uint64_t *data);
> > +
> > +#endif // SELFTEST_TDX_TDX_H
> > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/=
tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> > new file mode 100644
> > index 000000000000..07d63bf1ffe1
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef SELFTEST_TDX_TEST_UTIL_H
> > +#define SELFTEST_TDX_TEST_UTIL_H
> > +
> > +#include <stdbool.h>
> > +
> > +#include "tdcall.h"
> > +
> > +#define TDX_TEST_SUCCESS_PORT 0x30
> > +#define TDX_TEST_SUCCESS_SIZE 4
> > +
> > +/* Port I/O direction */
> > +#define PORT_READ    0
> > +#define PORT_WRITE   1
> > +
> > +/*
> > + * Run a test in a new process.
> > + *
> > + * There might be multiple tests running and if one test fails, it wil=
l
> > + * prevent the subsequent tests to run due to how tests are failing wi=
th
> > + * TEST_ASSERT function. run_in_new_process() will run a test in a new=
 process
> > + * context and wait for it to finish or fail to prevent TEST_ASSERT to=
 kill the
> > + * main testing process.
> > + */
> > +int run_in_new_process(void (*func)(void));
> > +
> > +/*
> > + * Verify that the TDX is supported by KVM.
> > + */
> > +bool is_tdx_enabled(void);
> > +
> > +/*
> > + * Report test success to userspace.
> > + *
> > + * Use tdx_test_assert_success() to assert that this function was call=
ed in the
> > + * guest.
> > + */
> > +void tdx_test_success(void);
> > +void tdx_test_assert_success(struct kvm_vcpu *vcpu);
> > +
> > +#endif // SELFTEST_TDX_TEST_UTIL_H
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S b/tools/t=
esting/selftests/kvm/lib/x86/tdx/tdcall.S
> > new file mode 100644
> > index 000000000000..b10769d1d557
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
> > @@ -0,0 +1,95 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Adapted from arch/x86/coco/tdx/tdcall.S */
> > +
> > +/*
> > + * TDCALL is supported in Binutils >=3D 2.36, add it for older version=
.
> > + */
> > +#define tdcall               .byte 0x66,0x0f,0x01,0xcc
> > +
> > +#define TDX_HYPERCALL_r10 0 /* offsetof(struct tdx_hypercall_args, r10=
) */
> > +#define TDX_HYPERCALL_r11 8 /* offsetof(struct tdx_hypercall_args, r11=
) */
> > +#define TDX_HYPERCALL_r12 16 /* offsetof(struct tdx_hypercall_args, r1=
2) */
> > +#define TDX_HYPERCALL_r13 24 /* offsetof(struct tdx_hypercall_args, r1=
3) */
> > +#define TDX_HYPERCALL_r14 32 /* offsetof(struct tdx_hypercall_args, r1=
4) */
> > +#define TDX_HYPERCALL_r15 40 /* offsetof(struct tdx_hypercall_args, r1=
5) */
> > +
>
> As Sean suggested in an earlier patch, replicating the functionality of t=
he
> kernel's OFFSET() could remove the hard-coded offset.
>
> > +/*
> > + * Bitmasks of exposed registers (with VMM).
> > + */
> > +#define TDX_R10 0x400
> > +#define TDX_R11 0x800
> > +#define TDX_R12 0x1000
> > +#define TDX_R13 0x2000
> > +#define TDX_R14 0x4000
> > +#define TDX_R15 0x8000
>
> Is BIT() better?
>

Done. Initially I had a problem including <linux/bits.h> here but I
ended up defining __ASSEMBLY__ manually to solve the issue.

> > +
> > +#define TDX_HCALL_HAS_OUTPUT 0x1
> > +
> > +/*
> > + * These registers are clobbered to hold arguments for each
> > + * TDVMCALL. They are safe to expose to the VMM.
> > + * Each bit in this mask represents a register ID. Bit field
> > + * details can be found in TDX GHCI specification, section
> > + * titled "TDCALL [TDG.VP.VMCALL] leaf".
> > + */
> > +#define TDVMCALL_EXPOSE_REGS_MASK    ( TDX_R10 | TDX_R11 | \
> > +                                       TDX_R12 | TDX_R13 | \
> > +                                       TDX_R14 | TDX_R15 )
>
> #define TDVMCALL_EXPOSE_REGS_MASK    \
>          (TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15)
>
> to save one line?

Done.

> > +
> > +.code64
> > +.section .text
> > +
> > +.globl __tdx_hypercall
> > +.type __tdx_hypercall, @function
> > +__tdx_hypercall:
> > +     /* Set up stack frame */
> > +     push %rbp
> > +     movq %rsp, %rbp
> > +
> > +     /* Save callee-saved GPRs as mandated by the x86_64 ABI */
> > +     push %r15
> > +     push %r14
> > +     push %r13
> > +     push %r12
> > +
> > +     /* Mangle function call ABI into TDCALL ABI: */
> > +     /* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
> > +     xor %eax, %eax
> > +
> > +     /* Copy hypercall registers from arg struct: */
> > +     movq TDX_HYPERCALL_r10(%rdi), %r10
> > +     movq TDX_HYPERCALL_r11(%rdi), %r11
> > +     movq TDX_HYPERCALL_r12(%rdi), %r12
> > +     movq TDX_HYPERCALL_r13(%rdi), %r13
> > +     movq TDX_HYPERCALL_r14(%rdi), %r14
> > +     movq TDX_HYPERCALL_r15(%rdi), %r15
> > +
> > +     movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
> > +
> > +     tdcall
> > +
> > +     /* TDVMCALL leaf return code is in R10 */
> > +     movq %r10, %rax
> > +
> > +     /* Copy hypercall result registers to arg struct if needed */
> > +     testq $TDX_HCALL_HAS_OUTPUT, %rsi
> > +     jz .Lout
> > +
> > +     movq %r10, TDX_HYPERCALL_r10(%rdi)
> > +     movq %r11, TDX_HYPERCALL_r11(%rdi)
> > +     movq %r12, TDX_HYPERCALL_r12(%rdi)
> > +     movq %r13, TDX_HYPERCALL_r13(%rdi)
> > +     movq %r14, TDX_HYPERCALL_r14(%rdi)
> > +     movq %r15, TDX_HYPERCALL_r15(%rdi)
> > +.Lout:
> > +     /* Restore callee-saved GPRs as mandated by the x86_64 ABI */
> > +     pop %r12
> > +     pop %r13
> > +     pop %r14
> > +     pop %r15
> > +
> > +     pop %rbp
> > +     ret
> > +
> > +/* Disable executable stack */
> > +.section .note.GNU-stack,"",%progbits
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/test=
ing/selftests/kvm/lib/x86/tdx/tdx.c
> > new file mode 100644
> > index 000000000000..f417ee75bee2
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> > @@ -0,0 +1,27 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include "tdx/tdcall.h"
> > +#include "tdx/tdx.h"
> > +
> > +uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> > +                                   uint64_t write, uint64_t *data)
> > +{
> > +     struct tdx_hypercall_args args =3D {
> > +             .r10 =3D TDX_HYPERCALL_STANDARD,
> > +             .r11 =3D TDG_VP_VMCALL_INSTRUCTION_IO,
> > +             .r12 =3D size,
> > +             .r13 =3D write,
> > +             .r14 =3D port,
> > +     };
> > +     uint64_t ret;
> > +
> > +     if (write)
> > +             args.r15 =3D *data;
> > +
> > +     ret =3D __tdx_hypercall(&args, write ? 0 : TDX_HCALL_HAS_OUTPUT);
> > +
> > +     if (!write)
> > +             *data =3D args.r11;
> > +
> > +     return ret;
> > +}
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tool=
s/testing/selftests/kvm/lib/x86/tdx/test_util.c
> > new file mode 100644
> > index 000000000000..7355b213c344
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> > @@ -0,0 +1,61 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <stdbool.h>
> > +#include <stdint.h>
> > +#include <stdlib.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +
> > +#include "kvm_util.h"
> > +#include "tdx/tdx.h"
> > +#include "tdx/test_util.h"
> > +
> > +int run_in_new_process(void (*func)(void))
> > +{
> > +     int wstatus;
> > +     pid_t ret;
> > +
> > +     if (fork() =3D=3D 0) {
> > +             func();
> > +             exit(0);
> > +     }
> > +     ret =3D wait(&wstatus);
> > +     if (ret =3D=3D -1)
> > +             return -1;
> > +
> > +     if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus))
> > +             return -1;
> > +     else if (WIFSIGNALED(wstatus))
> > +             return -1;
> > +
> > +     return 0;
> > +}
> > +
> > +bool is_tdx_enabled(void)
> > +{
> > +     return !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_TDX_VM));
> > +}
> > +
> > +void tdx_test_success(void)
> > +{
> > +     uint64_t code =3D 0;
> > +
> > +     tdg_vp_vmcall_instruction_io(TDX_TEST_SUCCESS_PORT, TDX_TEST_SUCC=
ESS_SIZE,
> > +                                  PORT_WRITE, &code);
> > +}
> > +
> > +/*
> > + * Assert that tdx_test_success() was called in the guest.
> > + */
> > +void tdx_test_assert_success(struct kvm_vcpu *vcpu)
> > +{
> > +     TEST_ASSERT((vcpu->run->exit_reason =3D=3D KVM_EXIT_IO) &&
> > +                 (vcpu->run->io.port =3D=3D TDX_TEST_SUCCESS_PORT) &&
> > +                 (vcpu->run->io.size =3D=3D TDX_TEST_SUCCESS_SIZE) &&
> > +                 (vcpu->run->io.direction =3D=3D PORT_WRITE),
> > +                 "Unexpected exit values while waiting for test comple=
tion: %u (%s) %d %d %d\n",
> > +                 vcpu->run->exit_reason,
> > +                 exit_reason_str(vcpu->run->exit_reason),
> > +                 vcpu->run->io.port, vcpu->run->io.size,
> > +                 vcpu->run->io.direction);
> > +}
> > diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/test=
ing/selftests/kvm/x86/tdx_vm_test.c
> > new file mode 100644
> > index 000000000000..fdb7c40065a6
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> > @@ -0,0 +1,47 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <signal.h>
> > +
> > +#include "kvm_util.h"
> > +#include "tdx/tdx_util.h"
> > +#include "tdx/test_util.h"
> > +#include "test_util.h"
> > +
> > +static void guest_code_lifecycle(void)
> > +{
> > +     tdx_test_success();
> > +}
> > +
> > +static void verify_td_lifecycle(void)
> > +{
> > +     struct kvm_vcpu *vcpu;
> > +     struct kvm_vm *vm;
> > +
> > +     vm =3D td_create();
> > +     td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> > +     vcpu =3D td_vcpu_add(vm, 0, guest_code_lifecycle);
> > +     td_finalize(vm);
> > +
> > +     printf("Verifying TD lifecycle:\n");
> > +
> > +     vcpu_run(vcpu);
> > +     tdx_test_assert_success(vcpu);
> > +
> > +     kvm_vm_free(vm);
> > +     printf("\t ... PASSED\n");
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +     ksft_print_header();
> > +
> > +     if (!is_tdx_enabled())
> > +             ksft_exit_skip("TDX is not supported by the KVM. Exiting.=
\n");
> > +
> > +     ksft_set_plan(1);
> > +     ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
> > +                      "verify_td_lifecycle\n");
> > +
> > +     ksft_finished();
> > +     return 0;
> > +}
>

