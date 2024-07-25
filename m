Return-Path: <linux-kselftest+bounces-14251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411BB93C9B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 22:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E051C21F58
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3A13CA99;
	Thu, 25 Jul 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cvk86bzK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2B76036
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939892; cv=none; b=VktC99WwldFWwD1Q+oTFukrQ2JCT2ehxENayhOogt770Xy45gO6LddsxTmwSUuybYmCabk8RKP1LhHC58qicvRtDcv9JzpKagwwDWy4btC8w5hrLtPJtuwuBeqe6eh1q1BfBYc/2B3jfJsX6y1kmFl7000N1QR5YwWxG2StZ+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939892; c=relaxed/simple;
	bh=ocXYsLhLf7QaaN19tzSG5c3J/wCtHlDIvC0WkhagqrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ice+ZFYnl9DSL+W8I6Q0C1/YJq434+7ZnOY5UFGFWiFRL7Crb9vBLCgHv3DMIfXfSvDTIvDR2wVZw3lqkC+usKUPivD6q1qEBVAV+bsGs28qoHU+engJA3uixx8qiMUCFihIuxE/yrTrCzaW9b+J7UMqQ6UitKev8tzqL+UnV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cvk86bzK; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0857a11862so1252211276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721939888; x=1722544688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhDuWj6ZXurQbOQDj2UH91qYn2GVJzMpZPE8P+8BWcg=;
        b=Cvk86bzKfEdZ9Ldtr+ZQ1EL9UXD2oJiAbutZ2gzOiLNfRFGaXsI/b1m9picvgOd+RK
         26yQo2YukTFEvryqxu85SLgKY9YPI3WaYu/x664VgdrDCOHSbKxCitTs+QgmhGdhfu68
         pwoHFg/3MqsflReRDMjvDi8G8cX6pcYsbCMBia7G1vhF2S/1t+MHYZiMqQY1YHJmX3Hm
         LFPQ40kKWZdE+ikzWtsDgW/wweky8b1Yit9H199IneWKPHvDo7ShKdtB+R30uxxUwO/Z
         EYqy6qK3JPOTAk8FlU3C0An73G66w/khPeWr3cPSvmcaN0VlTpifLt4EcmU8aPX9Mi8T
         pycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721939888; x=1722544688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhDuWj6ZXurQbOQDj2UH91qYn2GVJzMpZPE8P+8BWcg=;
        b=S0hb8stWjHpUO5GMo50fSXXhg/nfZB+3TGmbWlpAvf287k2W/TGwf97+wbpap+mH0g
         LSBj43NTbbLqeOCbvXZySkEY7YYFgvshUP5jT4IQeM3nmjbXTK6nSmf/z2NMUq5vibf5
         uT7ntPY8qMaKV8aJ+cNM7kGzoHxM9EfLXsh2zOv6LQ966vAI/QhO2twia4bXZheboY3C
         ChEO8AxqAhQkB0eYH/N/bVseWnySPCcuGyX7jiWhHWqVUf8G9DxlKQDwWzKm/MVsLdnf
         OFHZdPXvZbPCWAznwJhKrlohi+zeFKXbEuozbuaWAZ4SdPoa3EQiL1zy0sze4VCgekoQ
         X71w==
X-Gm-Message-State: AOJu0YzAFLgR6XjfK0/5MNn8T1hDDS0jHQzcBTFOQ0xwOWP/g3IHE5hN
	ka9wGxC5wQ99bAcVuWhWBltgXJpiLCZlIPEmmTHZFeeR4Db/UpoKuF0gf13zzOMZE6ecJ44qzxi
	YSfAmL4TxPc/V1qlw1g3fMcE2I8F9ie3PgivI
X-Google-Smtp-Source: AGHT+IECJdrU9brW0ZyCTY/l6qgMisIePUGJZ8CcYE7ptc9Vv+SM3KuDh9EzO3I07knxhTk+6U9Hm2yXCqceGYuDafY=
X-Received: by 2002:a05:6902:e10:b0:e0b:314a:14f9 with SMTP id
 3f1490d57ef6-e0b314a15demr3494865276.28.1721939887993; Thu, 25 Jul 2024
 13:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com> <20231212204647.2170650-10-sagis@google.com>
 <704b58a8-2893-4fdb-8171-395bcd7166a7@linux.intel.com>
In-Reply-To: <704b58a8-2893-4fdb-8171-395bcd7166a7@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 25 Jul 2024 15:37:55 -0500
Message-ID: <CAAhR5DHf4CmCN3Kzdtjq85DyVf6LTS1jBBDhn8yG6Y7O1_jegA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 09/29] KVM: selftests: TDX: Add report_fatal_error test
To: Binbin Wu <binbin.wu@linux.intel.com>
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

On Fri, Mar 1, 2024 at 12:52=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
>
>
>
> On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> > The test checks report_fatal_error functionality.
> >
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Ryan Afranji <afranji@google.com>
> > ---
> >   .../selftests/kvm/include/x86_64/tdx/tdx.h    |  6 ++-
> >   .../kvm/include/x86_64/tdx/tdx_util.h         |  1 +
> >   .../kvm/include/x86_64/tdx/test_util.h        | 19 ++++++++
> >   .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 39 ++++++++++++++++
> >   .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   | 12 +++++
> >   .../selftests/kvm/lib/x86_64/tdx/test_util.c  | 10 +++++
> >   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 45 ++++++++++++++++++=
+
> >   7 files changed, 131 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/too=
ls/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> > index a7161efe4ee2..1340c1070002 100644
> > --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> > +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> > @@ -3,10 +3,14 @@
> >   #define SELFTEST_TDX_TDX_H
> >
> >   #include <stdint.h>
> > +#include "kvm_util_base.h"
> >
> > -#define TDG_VP_VMCALL_INSTRUCTION_IO 30
> > +#define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
> >
> > +#define TDG_VP_VMCALL_INSTRUCTION_IO 30
> > +void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu);
> >   uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> >                                     uint64_t write, uint64_t *data);
> > +void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t da=
ta_gpa);
> >
> >   #endif // SELFTEST_TDX_TDX_H
> > diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h =
b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
> > index 274b245f200b..32dd6b8fda46 100644
> > --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
> > +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
> > @@ -12,5 +12,6 @@ struct kvm_vm *td_create(void);
> >   void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type sr=
c_type,
> >                  uint64_t attributes);
> >   void td_finalize(struct kvm_vm *vm);
> > +void td_vcpu_run(struct kvm_vcpu *vcpu);
> >
> >   #endif // SELFTESTS_TDX_KVM_UTIL_H
> > diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h=
 b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> > index b570b6d978ff..6d69921136bd 100644
> > --- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> > +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> > @@ -49,4 +49,23 @@ bool is_tdx_enabled(void);
> >    */
> >   void tdx_test_success(void);
> >
> > +/**
> > + * Report an error with @error_code to userspace.
> > + *
> > + * Return value from tdg_vp_vmcall_report_fatal_error is ignored since=
 execution
> > + * is not expected to continue beyond this point.
> > + */
> > +void tdx_test_fatal(uint64_t error_code);
> > +
> > +/**
> > + * Report an error with @error_code to userspace.
> > + *
> > + * @data_gpa may point to an optional shared guest memory holding the =
error
> > + * string.
> > + *
> > + * Return value from tdg_vp_vmcall_report_fatal_error is ignored since=
 execution
> > + * is not expected to continue beyond this point.
> > + */
> > +void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
> > +
> >   #endif // SELFTEST_TDX_TEST_UTIL_H
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/t=
esting/selftests/kvm/lib/x86_64/tdx/tdx.c
> > index c2414523487a..b854c3aa34ff 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> > @@ -1,8 +1,31 @@
> >   // SPDX-License-Identifier: GPL-2.0-only
> >
> > +#include <string.h>
> > +
> >   #include "tdx/tdcall.h"
> >   #include "tdx/tdx.h"
> >
> > +void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu)
> > +{
> > +     struct kvm_tdx_vmcall *vmcall_info =3D &vcpu->run->tdx.u.vmcall;
> > +     uint64_t vmcall_subfunction =3D vmcall_info->subfunction;
> > +
> > +     switch (vmcall_subfunction) {
> > +     case TDG_VP_VMCALL_REPORT_FATAL_ERROR:
> > +             vcpu->run->exit_reason =3D KVM_EXIT_SYSTEM_EVENT;
> > +             vcpu->run->system_event.ndata =3D 3;
> > +             vcpu->run->system_event.data[0] =3D
> > +                     TDG_VP_VMCALL_REPORT_FATAL_ERROR;
> > +             vcpu->run->system_event.data[1] =3D vmcall_info->in_r12;
> > +             vcpu->run->system_event.data[2] =3D vmcall_info->in_r13;
> > +             vmcall_info->status_code =3D 0;
> > +             break;
> > +     default:
> > +             TEST_FAIL("TD VMCALL subfunction %lu is unsupported.\n",
> > +                       vmcall_subfunction);
> > +     }
> > +}
> > +
> >   uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> >                                     uint64_t write, uint64_t *data)
> >   {
> > @@ -25,3 +48,19 @@ uint64_t tdg_vp_vmcall_instruction_io(uint64_t port,=
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
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/to=
ols/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> > index b302060049d5..d745bb6287c1 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> > @@ -10,6 +10,7 @@
> >
> >   #include "kvm_util.h"
> >   #include "test_util.h"
> > +#include "tdx/tdx.h"
> >   #include "tdx/td_boot.h"
> >   #include "kvm_util_base.h"
> >   #include "processor.h"
> > @@ -519,3 +520,14 @@ void td_finalize(struct kvm_vm *vm)
> >
> >       tdx_td_finalizemr(vm);
> >   }
> > +
> > +void td_vcpu_run(struct kvm_vcpu *vcpu)
> > +{
> > +     vcpu_run(vcpu);
> > +
> > +     /* Handle TD VMCALLs that require userspace handling. */
> > +     if (vcpu->run->exit_reason =3D=3D KVM_EXIT_TDX &&
> > +         vcpu->run->tdx.type =3D=3D KVM_EXIT_TDX_VMCALL) {
> > +             handle_userspace_tdg_vp_vmcall_exit(vcpu);
> > +     }
> > +}
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/t=
ools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> > index 6905d0ca3877..7f3cd8089cea 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
> > @@ -32,3 +32,13 @@ void tdx_test_success(void)
> >                                    TDX_TEST_SUCCESS_SIZE,
> >                                    TDG_VP_VMCALL_INSTRUCTION_IO_WRITE, =
&code);
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
> > diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/=
testing/selftests/kvm/x86_64/tdx_vm_tests.c
> > index a18d1c9d6026..8638c7bbedaa 100644
> > --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> > +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> > @@ -2,6 +2,7 @@
> >
> >   #include <signal.h>
> >   #include "kvm_util_base.h"
> > +#include "tdx/tdx.h"
> >   #include "tdx/tdx_util.h"
> >   #include "tdx/test_util.h"
> >   #include "test_util.h"
> > @@ -30,6 +31,49 @@ void verify_td_lifecycle(void)
> >       printf("\t ... PASSED\n");
> >   }
> >
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
> > +     if (err)
> > +             tdx_test_fatal(err);
>
> I find tdx_test_fatal() is called a lot and each call site checks the err
> before calling it. Is it simpler to move the check of err inside of
> tdx_test_fatal() so that the callers just call it without check it every
> time?
>
tdx_test_fatal is used for more cases than just testing error code but
we can add another higher level helper. Maybe tdx_assert_error.
>
> > +
> > +     tdx_test_success();
> > +}
> > +void verify_report_fatal_error(void)
> > +{
> > +     struct kvm_vm *vm;
> > +     struct kvm_vcpu *vcpu;
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
> > +     TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 3);
> > +     TEST_ASSERT_EQ(vcpu->run->system_event.data[0], TDG_VP_VMCALL_REP=
ORT_FATAL_ERROR);
> > +     TEST_ASSERT_EQ(vcpu->run->system_event.data[1], 0x0BAAAAAD0000000=
0);
> > +     TEST_ASSERT_EQ(vcpu->run->system_event.data[2], 0);
> > +
> > +     vcpu_run(vcpu);
> > +     TDX_TEST_ASSERT_SUCCESS(vcpu);
> > +
> > +     kvm_vm_free(vm);
> > +     printf("\t ... PASSED\n");
> > +}
> > +
> >   int main(int argc, char **argv)
> >   {
> >       setbuf(stdout, NULL);
> > @@ -40,6 +84,7 @@ int main(int argc, char **argv)
> >       }
> >
> >       run_in_new_process(&verify_td_lifecycle);
> > +     run_in_new_process(&verify_report_fatal_error);
> >
> >       return 0;
> >   }
>

