Return-Path: <linux-kselftest+bounces-39890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63587B34E10
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 23:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AB21B25C4E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 21:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09282882BD;
	Mon, 25 Aug 2025 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n05dJE4p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC729AB0E
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157336; cv=none; b=PB+c7pHmUd3lHaMeEpvTxTbFrNhnHDi7jW+XnGSY8VrvzpEZhnhUNSHtcT9DoZ0vgbVGMp7lfoP5UJPtiTq7ciw0FJAnr61Do2TNIuVWXAAEsMc239/snbxhhXJc08heKh7ZTEBdjgC2PUzwS9q8OAEEbd7ikismcOn4cszAHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157336; c=relaxed/simple;
	bh=ki7b9RrkeSQ61NJfR2PwPTTIb/IOA3nXPz6d1bfc0nY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Si+ozHq4u8xsTlg/jyPnhdPQ1fCYmxxOzRMws6BULb8SrcYWnAIb2muOANs1INt2CodK0cOMhhichLRflfWYxNyp4gMWoUnon1mvpAWyb/AyfDoWaLxUSlFdnPgudjbs7aFIff7+y+S/eY4LCRXgeON8ZeuKX+q0R522oCs+zf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n05dJE4p; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61c386d3510so4038a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756157333; x=1756762133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAqHEjqSxRITZbrtDXf1z5R4aI+Bl4Sv2vJSYYNeGZo=;
        b=n05dJE4pU/1Vvxyd4mZ5uk4GXL20IeCORbpMZG3wYw89DhpKTuBrIE6ZwnbXncuygl
         jFDOXzJNdVUvWpAPlcal4oO4DGWcqG4XglekPMKPfdyqXoyUlXhS5Kh0LuNt1LGnpXm3
         9dNN18lNG6XRu9AgaUhO/lwTcD9rKvUdSCbQC7MRX+ZJfTZjwMCamjAM41sUreVHoyki
         Mf5SSBQDUqzQK/WhU4wPEMJTnQinnFdQTNaW327znFPbZzyYBWoX24bkNlpBNIW3Qdu6
         rIkJGfGpy94x6YfmIQpKYLkaNSnlRDf8f6Oe0deSyJrq7lRmYRt4PJl4OhwzK8xzB+iI
         kJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157333; x=1756762133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAqHEjqSxRITZbrtDXf1z5R4aI+Bl4Sv2vJSYYNeGZo=;
        b=vSsS8db9BHorTBeGc2m7lgcVILHhOxOWBxh9IGUH29YCvoOdlFTUzT553F29YVO9RU
         wrFz+L59myg8HhPmvuaCV0n0zDJPcxAW0Zi7Cxb8d9+/rWbGfnkUhJWmAlp2RMasxnzp
         Wl2OLNenzthTjM6isclvAZG3NVo/fqwO2143SSmycMq68aIZ8GqFXWGkhjwtzfghB0vC
         AmmhMupXUDAaIseLqzAgU6mn5evlAVQ8fC84K9TB2ZIuJPIQ0ePXz5wxGfxIwfFKHqe0
         Q+OICQ4bwQcySgTJCLF3h6ROLrUO3HwgzAx+ur3bqIKSC4zOhMWAZPW+KdySSAtcvV0W
         74JA==
X-Gm-Message-State: AOJu0Yz4iJbydhY3LivPX3adXb+UIcnLTN19anW0hk6WtAPfpr0ACvlq
	Nrcq3QBWOctf3KCwas6h3NiA2e/fj87iECSNzvbF4hXSle5yOV5w0+7MGUaIE4srIVXa5WT6hna
	0B2LcYMqjjNPaW0GW5+iQaONpbSDpPJkGKW63Rpok
X-Gm-Gg: ASbGncu4uW3y6P7pcPrY0NZsIOkvvsxz/CEmhu58IubqeJVJBP3spvT1NcZIfqdJKAe
	BtqqXSstJbuBss9XZtOcfl5lBQUT50TwrCpcKYJYzQclTFdYlWeLmS0OPvOqyacU550NhqhrOcY
	GN4qOdrN6JCfivw+vt4uDzYOYVtIFmdO60Spa1I4ctL2uG1uGO+VVyCT4DTOZj03tVy+LslQEE9
	lDL8liAmen+jKVe5aQF2tjIwg==
X-Google-Smtp-Source: AGHT+IEJIRUkfuqwdvU1Tz0emb8MQhZ8GaC5fb/fGtVOvXVxuDj7xD6jk2kqRpJ1sSg08zzTeeqzxVSojh6Puww+THI=
X-Received: by 2002:a50:c014:0:b0:61a:22c2:81b9 with SMTP id
 4fb4d7f45d1cf-61c8f840ab9mr19594a12.6.1756157332746; Mon, 25 Aug 2025
 14:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-11-sagis@google.com>
 <ef499c6e-d62c-450e-982b-82c53054ea53@linux.intel.com>
In-Reply-To: <ef499c6e-d62c-450e-982b-82c53054ea53@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Mon, 25 Aug 2025 16:28:38 -0500
X-Gm-Features: Ac12FXwWWa132vNURqkQ6p9Go3_mkfPqTGcEUOL8gtYD8U5sBfHY5YEYy-t3Nlo
Message-ID: <CAAhR5DGEv5acad7obi_9Fm9svm3GsK56imnLRE2oVyfvRBgtLQ@mail.gmail.com>
Subject: Re: [PATCH v8 10/30] KVM: selftests: TDX: Add report_fatal_error test
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

On Wed, Aug 13, 2025 at 5:58=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
>
>
>
> On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> > The test checks report_fatal_error functionality.
> >
> > TD guest can use TDG.VP.VMCALL<ReportFatalError> to report the fatal er=
ror
> > it has experienced. TD guest is requesting a termination with the error
> > information that include 16 general-purpose registers.
>
> I think it's worth to mention that KVM converts TDG.VP.VMCALL<ReportFatal=
Error>
> to KVM_EXIT_SYSTEM_EVENT with the type KVM_SYSTEM_EVENT_TDX_FATAL.
>

Done. Will get updated in the next version.

> >
> > Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
> > Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >   .../selftests/kvm/include/x86/tdx/tdx.h       |  6 ++-
> >   .../selftests/kvm/include/x86/tdx/tdx_util.h  |  1 +
> >   .../selftests/kvm/include/x86/tdx/test_util.h | 19 +++++++
> >   tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 18 +++++++
> >   .../selftests/kvm/lib/x86/tdx/tdx_util.c      |  6 +++
> >   .../selftests/kvm/lib/x86/tdx/test_util.c     | 10 ++++
> >   tools/testing/selftests/kvm/x86/tdx_vm_test.c | 51 ++++++++++++++++++=
-
> >   7 files changed, 108 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/=
testing/selftests/kvm/include/x86/tdx/tdx.h
> > index a7161efe4ee2..2acccc9dccf9 100644
> > --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> > @@ -4,9 +4,13 @@
> >
> >   #include <stdint.h>
> >
> > +#include "kvm_util.h"
> > +
> > +#define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
> > +
> >   #define TDG_VP_VMCALL_INSTRUCTION_IO 30
> >
> >   uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> >                                     uint64_t write, uint64_t *data);
> > -
> > +void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t da=
ta_gpa);
> >   #endif // SELFTEST_TDX_TDX_H
> > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/t=
ools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > index 57a2f5893ffe..d66cf17f03ea 100644
> > --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > @@ -15,5 +15,6 @@ struct kvm_vm *td_create(void);
> >   void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type sr=
c_type,
> >                  uint64_t attributes);
> >   void td_finalize(struct kvm_vm *vm);
> > +void td_vcpu_run(struct kvm_vcpu *vcpu);
> >
> >   #endif // SELFTESTS_TDX_KVM_UTIL_H
> > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/=
tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> > index 07d63bf1ffe1..dafeee9af1dc 100644
> > --- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> > @@ -38,4 +38,23 @@ bool is_tdx_enabled(void);
> >   void tdx_test_success(void);
> >   void tdx_test_assert_success(struct kvm_vcpu *vcpu);
> >
> > +/*
> > + * Report an error with @error_code to userspace.
> > + *
> > + * Return value from tdg_vp_vmcall_report_fatal_error() is ignored sin=
ce
> > + * execution is not expected to continue beyond this point.
> > + */
> > +void tdx_test_fatal(uint64_t error_code);
> > +
> > +/*
> > + * Report an error with @error_code to userspace.
> > + *
> > + * @data_gpa may point to an optional shared guest memory holding the =
error
> > + * string.
>
> A according to the GHCI spec, this is the optional GPA pointing to a shar=
ed guest memory, but in these TDX KVM selftest cases, it may not used that =
way. It may need some clarification about it. And based on the usage in thi=
s patch series, the name data_gpa may be misleading.
>

I can add a comment at the call site saying that the data_gpa is a
fake one for the sake of testing. Whether the data_gpa points to a
valid shared memory or not doesn't make a lot of difference from a
unit test perspective since we are testing the ReportFatalError
functionality itself.

Making the data_gpa valid for the test requires setting up additional
shared memory with no significant benefit for the test.

>
> > + *
> > + * Return value from tdg_vp_vmcall_report_fatal_error() is ignored sin=
ce
> > + * execution is not expected to continue beyond this point.
> > + */
> > +void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
> > +
> >   #endif // SELFTEST_TDX_TEST_UTIL_H
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/test=
ing/selftests/kvm/lib/x86/tdx/tdx.c
> > index f417ee75bee2..ba088bfc1e62 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> > @@ -1,5 +1,7 @@
> >   // SPDX-License-Identifier: GPL-2.0-only
> >
> > +#include <string.h>
> > +
> >   #include "tdx/tdcall.h"
> >   #include "tdx/tdx.h"
> >
> > @@ -25,3 +27,19 @@ uint64_t tdg_vp_vmcall_instruction_io(uint64_t port,=
 uint64_t size,
> >
> >       return ret;
> >   }
> > +
> > +void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t da=
ta_gpa)
> > +{
> > +     struct tdx_hypercall_args args;
> > +
> > +     memset(&args, 0, sizeof(struct tdx_hypercall_args));
> > +
> > +     if (data_gpa)
> > +             error_code |=3D 0x8000000000000000;
> > +
> > +     args.r11 =3D TDG_VP_VMCALL_REPORT_FATAL_ERROR;
> > +     args.r12 =3D error_code;
> > +     args.r13 =3D data_gpa;
> > +
> > +     __tdx_hypercall(&args, 0);
> > +}
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools=
/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > index e2bf9766dc03..5e4455be828a 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > @@ -9,6 +9,7 @@
> >   #include "kvm_util.h"
> >   #include "processor.h"
> >   #include "tdx/td_boot.h"
> > +#include "tdx/tdx.h"
> >   #include "test_util.h"
> >
> >   uint64_t tdx_s_bit;
> > @@ -603,3 +604,8 @@ void td_finalize(struct kvm_vm *vm)
> >
> >       tdx_td_finalize_mr(vm);
> >   }
> > +
> > +void td_vcpu_run(struct kvm_vcpu *vcpu)
> > +{
> > +     vcpu_run(vcpu);
> > +}
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tool=
s/testing/selftests/kvm/lib/x86/tdx/test_util.c
> > index 7355b213c344..6c82a0c3bd37 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> > @@ -59,3 +59,13 @@ void tdx_test_assert_success(struct kvm_vcpu *vcpu)
> >                   vcpu->run->io.port, vcpu->run->io.size,
> >                   vcpu->run->io.direction);
> >   }
> > +
> > +void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa)
> > +{
> > +     tdg_vp_vmcall_report_fatal_error(error_code, data_gpa);
> > +}
> > +
> > +void tdx_test_fatal(uint64_t error_code)
> > +{
> > +     tdx_test_fatal_with_data(error_code, 0);
> > +}
> > diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/test=
ing/selftests/kvm/x86/tdx_vm_test.c
> > index fdb7c40065a6..7d6d71602761 100644
> > --- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> > +++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> > @@ -3,6 +3,7 @@
> >   #include <signal.h>
> >
> >   #include "kvm_util.h"
> > +#include "tdx/tdx.h"
> >   #include "tdx/tdx_util.h"
> >   #include "tdx/test_util.h"
> >   #include "test_util.h"
> > @@ -24,7 +25,51 @@ static void verify_td_lifecycle(void)
> >
> >       printf("Verifying TD lifecycle:\n");
> >
> > -     vcpu_run(vcpu);
> > +     td_vcpu_run(vcpu);
> > +     tdx_test_assert_success(vcpu);
> > +
> > +     kvm_vm_free(vm);
> > +     printf("\t ... PASSED\n");
> > +}
> > +
> > +void guest_code_report_fatal_error(void)
> > +{
> > +     uint64_t err;
> > +
> > +     /*
> > +      * Note: err should follow the GHCI spec definition:
> > +      * bits 31:0 should be set to 0.
> > +      * bits 62:32 are used for TD-specific extended error code.
> > +      * bit 63 is used to mark additional information in shared memory=
.
> > +      */
> > +     err =3D 0x0BAAAAAD00000000;
> > +     tdx_test_fatal(err);
> > +
> > +     tdx_test_success();
> > +}
> > +
> > +void verify_report_fatal_error(void)
> > +{
> > +     struct kvm_vcpu *vcpu;
> > +     struct kvm_vm *vm;
> > +
> > +     vm =3D td_create();
> > +     td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> > +     vcpu =3D td_vcpu_add(vm, 0, guest_code_report_fatal_error);
> > +     td_finalize(vm);
> > +
> > +     printf("Verifying report_fatal_error:\n");
> > +
> > +     td_vcpu_run(vcpu);
> > +
> > +     TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
> > +     TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_TDX=
_FATAL);
> > +     TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 16);
> > +
> > +     TEST_ASSERT_EQ(vcpu->run->system_event.data[12], 0x0BAAAAAD000000=
00);
> > +     TEST_ASSERT_EQ(vcpu->run->system_event.data[13], 0);
> > +
> > +     td_vcpu_run(vcpu);
> >       tdx_test_assert_success(vcpu);
> >
> >       kvm_vm_free(vm);
> > @@ -38,9 +83,11 @@ int main(int argc, char **argv)
> >       if (!is_tdx_enabled())
> >               ksft_exit_skip("TDX is not supported by the KVM. Exiting.=
\n");
> >
> > -     ksft_set_plan(1);
> > +     ksft_set_plan(2);
> >       ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
> >                        "verify_td_lifecycle\n");
> > +     ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
> > +                      "verify_report_fatal_error\n");
> >
> >       ksft_finished();
> >       return 0;
>

