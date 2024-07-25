Return-Path: <linux-kselftest+bounces-14246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B6193C92A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 21:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC141F21265
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 19:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363B646522;
	Thu, 25 Jul 2024 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rv+hE6tC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4352651C5A
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937155; cv=none; b=hrX7UTPCht1ISa7sz7ZrklzaEiSv6U8KulUMOGGeJAQTBvsAZxPAuTRhaAZaPEqGJJp4cM6QxqMcK6lGgzHLbo13ySnI6CFbVDusq0Y3tDtO5kduT0PM646vBC6yLH7du8Zpr1zxfZgk1kjkpxi3dkE7bEnn/uGlvCRVoUQ4PB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937155; c=relaxed/simple;
	bh=S6qPUYYzAfjcp57EBZoerITwEw97UgHwcuSYx0FQpGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vz9l+3zCYSZXyTdW1ALZtYR2qWNfZtk+Hh7An/TGqTvPVmo9X+FhBuyBvOx8uW9j2jkhWunPBsBgl14hdNyHlX5QPwGD0bzg7gBqSiUcUBXiXPlhlk5wWbC/pvP9iWvzwAigPdYtzZ/yKDxGPdeMVHeshf55C+L2KLzDIEwB3ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rv+hE6tC; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0874f138aeso1243849276.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721937152; x=1722541952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmvF7JSitK/Lbt+S8Ef7rsUKiM+CmvTYnpcIXireHNk=;
        b=rv+hE6tChmMmsDLT8GS9Ivibox/cakIgBEkZ7wu0P0tW9vmgQ6fnmcAiU2iPZ57Crq
         iGyB1Ihvvcut4khAkzQGDmPyeWXpxdQ21I1mSU7z3+xLlp1Jy21NbIT+66YoQr4akQ/X
         rJ2xx4BuWIs9UGn1Xe7Lsjv3txrBp6p0SL9CxqejWk4kFRhE0/EEIHnxoFqznUJTVBXL
         FqtonbOoeizp/MLy9CHMaMVSLHYz+RHuVzUMp2UyGFdpR9jdUubqISah81aQ/xxyAqQ8
         R1qHBny64EMQSx6eA/8p8QfSvtPq2YRw3pb490FwWNy0OetKpyJAJt9pFswh6ZXtRdTb
         xkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937152; x=1722541952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmvF7JSitK/Lbt+S8Ef7rsUKiM+CmvTYnpcIXireHNk=;
        b=OVmcEjXDXRqKU0HFYigUXVqpXPz07pA4eYTf+QxQzNVAolPSi4ID1hwSrXB4pp/tsH
         9XfOh88qoCZrCP8ZaP4sI/5NJ8aUa/G0cHfjfS5TaskoCf+pDC7gZlqGbimQzaf1rHEK
         DuUXGhY+ge4baDQSt4A8aM25ZkxGpufdkjHjjn15aUut0TlVLey9k9BN0gRK1kcs6YGP
         D7LpU8T4Z0s4ddnmswJFHYWtpnG+GTjjB8BrrxTrkTAgjoImKYMOenSB8Db8ymWWUs8E
         Fpua5Pji9Z5pV2BVHXKODr5XcacChdVzt8mLZ8KIOlR+SUj92J+DBia5LyURK37EsLD6
         dfNw==
X-Gm-Message-State: AOJu0YwBUAVXyNoQ2qm/siRt5u2ZqFwVGjPjQq8ZlQ9C9PbF6ojPojQr
	LlUabUn8yzuw9hWRUVfCa9QjgNVuLzfMZmomMzTNxJu/qddUzXkN8QF8iNWtDs9jvV8MreeR/8E
	6NwCQAd1niRbeyxDFukgRnrAigD0lCh+/+8aeBZ1/+DvvHi8N5RDc
X-Google-Smtp-Source: AGHT+IEj7ZX2Fld7qL9GrVfFbgPabN6TPthfiRSq2x6GsFMTL3WDmsNd2RUJFRa994qovk1XqN1M+p5ev9qqzjRDdFA=
X-Received: by 2002:a05:6902:1401:b0:e03:645f:2099 with SMTP id
 3f1490d57ef6-e0b22fae743mr4849923276.8.1721937151961; Thu, 25 Jul 2024
 12:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com> <20231212204647.2170650-9-sagis@google.com>
 <0b34990b-8a3f-487e-891e-64d3d4d68613@intel.com>
In-Reply-To: <0b34990b-8a3f-487e-891e-64d3d4d68613@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 25 Jul 2024 14:52:20 -0500
Message-ID: <CAAhR5DFzTUrvUSsBcXwNBfxVxTYkMLkiTD5P+nQBL==Dr5WZeA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 08/29] KVM: selftests: TDX: Add TDX lifecycle test
To: "Chen, Zide" <zide.chen@intel.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>, 
	Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 4:33=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wr=
ote:
>
>
>
> On 12/12/2023 12:46 PM, Sagi Shahar wrote:
> > From: Erdem Aktas <erdemaktas@google.com>
> >
> > Adding a test to verify TDX lifecycle by creating a TD and running a
> > dummy TDG.VP.VMCALL <Instruction.IO> inside it.
> >
> > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > Signed-off-by: Ryan Afranji <afranji@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > ---
> >  tools/testing/selftests/kvm/Makefile          |  4 +
> >  .../selftests/kvm/include/x86_64/tdx/tdcall.h | 35 ++++++++
> >  .../selftests/kvm/include/x86_64/tdx/tdx.h    | 12 +++
> >  .../kvm/include/x86_64/tdx/test_util.h        | 52 +++++++++++
> >  .../selftests/kvm/lib/x86_64/tdx/tdcall.S     | 90 +++++++++++++++++++
> >  .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 27 ++++++
> >  .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   |  1 +
> >  .../selftests/kvm/lib/x86_64/tdx/test_util.c  | 34 +++++++
> >  .../selftests/kvm/x86_64/tdx_vm_tests.c       | 45 ++++++++++
> >  9 files changed, 300 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdca=
ll.h
> >  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdx.=
h
> >  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/test=
_util.h
> >  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
> >  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> >  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/test_uti=
l.c
> >  create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> >
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selft=
ests/kvm/Makefile
> > index a35150ab855f..80d4a50eeb9f 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -52,6 +52,9 @@ LIBKVM_x86_64 +=3D lib/x86_64/vmx.c
> >  LIBKVM_x86_64 +=3D lib/x86_64/sev.c
> >  LIBKVM_x86_64 +=3D lib/x86_64/tdx/tdx_util.c
> >  LIBKVM_x86_64 +=3D lib/x86_64/tdx/td_boot.S
> > +LIBKVM_x86_64 +=3D lib/x86_64/tdx/tdcall.S
> > +LIBKVM_x86_64 +=3D lib/x86_64/tdx/tdx.c
> > +LIBKVM_x86_64 +=3D lib/x86_64/tdx/test_util.c
> >
> >  LIBKVM_aarch64 +=3D lib/aarch64/gic.c
> >  LIBKVM_aarch64 +=3D lib/aarch64/gic_v3.c
> > @@ -152,6 +155,7 @@ TEST_GEN_PROGS_x86_64 +=3D set_memory_region_test
> >  TEST_GEN_PROGS_x86_64 +=3D steal_time
> >  TEST_GEN_PROGS_x86_64 +=3D kvm_binary_stats_test
> >  TEST_GEN_PROGS_x86_64 +=3D system_counter_offset_test
> > +TEST_GEN_PROGS_x86_64 +=3D x86_64/tdx_vm_tests
> >
> >  # Compiled outputs used by test targets
> >  TEST_GEN_PROGS_EXTENDED_x86_64 +=3D x86_64/nx_huge_pages_test
> > diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/=
tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
> > new file mode 100644
> > index 000000000000..78001bfec9c8
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Adapted from arch/x86/include/asm/shared/tdx.h */
> > +
> > +#ifndef SELFTESTS_TDX_TDCALL_H
> > +#define SELFTESTS_TDX_TDCALL_H
> > +
> > +#include <linux/bits.h>
> > +#include <linux/types.h>
> > +
> > +#define TDG_VP_VMCALL_INSTRUCTION_IO_READ 0
> > +#define TDG_VP_VMCALL_INSTRUCTION_IO_WRITE 1
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
> > diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/too=
ls/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> > new file mode 100644
> > index 000000000000..a7161efe4ee2
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
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
> > diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h=
 b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> > new file mode 100644
> > index 000000000000..b570b6d978ff
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> > @@ -0,0 +1,52 @@
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
> > +/**
> > + * Assert that tdx_test_success() was called in the guest.
> > + */
> > +#define TDX_TEST_ASSERT_SUCCESS(VCPU)                                 =
       \
> > +     (TEST_ASSERT(                                                   \
> > +             ((VCPU)->run->exit_reason =3D=3D KVM_EXIT_IO) &&         =
   \
> > +             ((VCPU)->run->io.port =3D=3D TDX_TEST_SUCCESS_PORT) &&   =
   \
> > +             ((VCPU)->run->io.size =3D=3D TDX_TEST_SUCCESS_SIZE) &&   =
   \
> > +             ((VCPU)->run->io.direction =3D=3D                        =
   \
> > +                     TDG_VP_VMCALL_INSTRUCTION_IO_WRITE),            \
> > +             "Unexpected exit values while waiting for test completion=
: %u (%s) %d %d %d\n", \
> > +             (VCPU)->run->exit_reason,                               \
> > +             exit_reason_str((VCPU)->run->exit_reason),              \
> > +             (VCPU)->run->io.port, (VCPU)->run->io.size,             \
> > +             (VCPU)->run->io.direction))
> > +
> > +/**
> > + * Run a test in a new process.
> > + *
> > + * There might be multiple tests we are running and if one test fails,=
 it will
> > + * prevent the subsequent tests to run due to how tests are failing wi=
th
> > + * TEST_ASSERT function. The run_in_new_process function will run a te=
st in a
> > + * new process context and wait for it to finish or fail to prevent TE=
ST_ASSERT
> > + * to kill the main testing process.
> > + */
> > +void run_in_new_process(void (*func)(void));
> > +
> > +/**
> > + * Verify that the TDX is supported by KVM.
> > + */
> > +bool is_tdx_enabled(void);
> > +
> > +/**
> > + * Report test success to userspace.
> > + *
> > + * Use TDX_TEST_ASSERT_SUCCESS() to assert that this function was call=
ed in the
> > + * guest.
> > + */
> > +void tdx_test_success(void);
> > +
> > +#endif // SELFTEST_TDX_TEST_UTIL_H
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S b/tool=
s/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
> > new file mode 100644
> > index 000000000000..df9c1ed4bb2d
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
> > @@ -0,0 +1,90 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Adapted from arch/x86/coco/tdx/tdcall.S */
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
> > +/*
> > + * Bitmasks of exposed registers (with VMM).
> > + */
> > +#define TDX_R10 0x400
> > +#define TDX_R11 0x800
> > +#define TDX_R12 0x1000
> > +#define TDX_R13 0x2000
> > +#define TDX_R14 0x4000
> > +#define TDX_R15 0x8000
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
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/t=
esting/selftests/kvm/lib/x86_64/tdx/tdx.c
> > new file mode 100644
> > index 000000000000..c2414523487a
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> > @@ -0,0 +1,27 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include "tdx/tdcall.h"
> > +#include "tdx/tdx.h"
> > +
> > +uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> > +                                   uint64_t write, uint64_t *data)
> > +{
> > +     uint64_t ret;
> > +     struct tdx_hypercall_args args =3D {
> > +             .r10 =3D TDX_HYPERCALL_STANDARD,
> > +             .r11 =3D TDG_VP_VMCALL_INSTRUCTION_IO,
> > +             .r12 =3D size,
> > +             .r13 =3D write,
> > +             .r14 =3D port,
> > +     };
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
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/to=
ols/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> > index 063ff486fb86..b302060049d5 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> > @@ -224,6 +224,7 @@ static void tdx_enable_capabilities(struct kvm_vm *=
vm)
> >                     KVM_X2APIC_API_USE_32BIT_IDS |
> >                             KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK);
> >       vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
> > +     vm_enable_cap(vm, KVM_CAP_MAX_VCPUS, 512);
>
> Since TDX spec doesn't define max vCPUs, is it a good idea to fix it to
> 512 in this common code?
>
> How about to move this line to the specific test case where you are
> actually verifying this capability?
>
> For example, move it to PATCH v5 21/29] KVM: selftests: TDX: Add
> TDG.VP.INFO test
>
> + vm_enable_cap(vm, KVM_CAP_MAX_VCPUS, 512);
> ...
>
> TEST_ASSERT_EQ(ret_max_vcpus, 512);
>

See Yan Zhao's comment above. This was needed in the previous
implementation of TDX and without it the tests would fail. With the
new fix I'm going to remove this from the common code.

>
>

