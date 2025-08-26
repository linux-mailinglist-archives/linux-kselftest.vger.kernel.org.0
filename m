Return-Path: <linux-kselftest+bounces-39958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4441B36F95
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 18:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E26361C0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDCA242D9A;
	Tue, 26 Aug 2025 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEAqUavN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5923081BC
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224310; cv=none; b=N5oG57msfRVWUYg2p3/1veVWeiyJPkDOsYnRKB5jBv1Glzj5HJ8poZ+Rl+MGg+5H6ZwmWx+EYVIAEviKXFUABPB8WS6uTcyn+JIHK9m8ElZbrgyQgFlfmOou2LY4U8nFn/3vVKIzmD9pnN9Ev907CIzqkk8L/YUqyWCYGjFj6vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224310; c=relaxed/simple;
	bh=J9vJ2+9ip+xBDaCuNEKvK4MQijG4RVOmKRiN3vMj1hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRnM4u+0yqgo79SLEkFTn+C1O9jHfK/3WE+3ExZ2GWruHzyE1xRNCQAgoyrcoDs5yAzVrH/1hLzG/l/+dGe0aCsU24+dbYxhDfBYEdsLcM8kbOr3Mkf3h5SF022rmjuRN6+lkmgzmIKmCQ8aG9WqcP4fy9XHc7o79IX8q0jPjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MEAqUavN; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b29b714f8cso436421cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756224307; x=1756829107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLdExvFTYvU58j6WoYulhsR3rHO3T8nQ/1Jf9icS5kU=;
        b=MEAqUavN2It8aQ0zGPcULUn7IaJxxy30E9JW8oC2yazouZBRnJJ6Afj0YOkfOvy9YZ
         E6VlAkWwZHTWTyUda4Rb8Zax8OQHwp/UY3m0q+hOUnJKNlr4W3Mq6UpAvVDW0aODJHIi
         mSE9ylacaps1L2gEVVK/00bFxQOIWdIgX2rq8crre+MSRga2AbeXEJEZdOB4mhC6oNAJ
         2Ssh3ROVzESdsZd06TYNMpXgnlONZMx10yRQZdAXGdT9MsxJoTKEuXarAwA9AN15x+kK
         fIEh4qBUJ4qO1i2bqMpaFgxuegV1RP/KJCYnuKwoQrQdGKjaepVVOtQBJEJPWXOelL+k
         A07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224307; x=1756829107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLdExvFTYvU58j6WoYulhsR3rHO3T8nQ/1Jf9icS5kU=;
        b=R40yyiXiiLVikQvSs35NSVJRWArqfqCejv2kF0wztCTwDvIeWUimyCtNbsHpmY7Ebd
         0zmjz+rQHSzWSv3jAxhsW4uFrEp+0L72ehVQU/hHMTzPXx3sAe59/uFPBxepwYWBh4jz
         s5s+u1KftG6BNl+IwhwYLhQTzghTPgErqkq6ibjh3uvZPhVI5zf7av9F3zE9fRf2Mf/t
         qU/tYSiBGmmR/SOqiSS1PMLcaJ1+wJ4RtMeN3m3ErfWQ3GTrVJ03kYtoZqFUUPuIvkzz
         0sIJVUT6z8dguR4vKwVdMsnvCNkBmMmBcYMLYu/coW/quq2fcXkvGxCGcDrGq+oP0hW2
         RLHQ==
X-Gm-Message-State: AOJu0YyaKAOX7F18zL22GPqE8qC/R56K2cKMUKiKoft/t8LVeOAasNv3
	svryJzFCS4fKKhpxmleNkfwuzdhlWJM/DWiUmm7KmnXkhU5fFIve7m2QCVtSJeq3+gfBM4JoiBJ
	hEGiN6+Ra8R2spY4BtScAXTy/9/2cy+45pN+vPmaR
X-Gm-Gg: ASbGncvajUdNzpWIPsb9rgxCYTLaHOhCBnP6q+kLHjUjxJs55NbOHQp6CJslm9Dxe8i
	r6gr9x4ci56hAwRUTh8xXmRv98kkGzQizgbkNaOMbOGUSkxn8cCYxA0XVihkJlhs2Cd6ERFyGUj
	lnaSYo+lyLHRn7wq0TdNvFNHUE2CeFXLUYvlB78qmoelFfy3D6+Hhio07trRzSkx56YXD6oleaY
	THwoPQKW3ZW6tn5kR7fI8mnWUgjHC1wzl9i/JzVZLrnXnKSTMYQezWT9P6gpaZA6Xs=
X-Google-Smtp-Source: AGHT+IHQofB+0fZiGVyLFKBbZzOTFAlCePKw3setaCLAGa199ccs6HjZuyQer66ydcsQhnpA2pHNLY0XytOvHQwBMHI=
X-Received: by 2002:ac8:5a49:0:b0:4ae:d2cc:ad51 with SMTP id
 d75a77b69052e-4b2e2b6d63dmr5994341cf.1.1756224306662; Tue, 26 Aug 2025
 09:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-6-sagis@google.com>
 <176247c7-6801-4e06-860e-4a6b8e77ba20@linux.intel.com>
In-Reply-To: <176247c7-6801-4e06-860e-4a6b8e77ba20@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 26 Aug 2025 11:04:54 -0500
X-Gm-Features: Ac12FXyWmbtvC2IZYpCOYC0Y6vnU76B-4TsLAYBi_s7kTMKW6NKMvVulYzN01rA
Message-ID: <CAAhR5DHbhCaR53GuKotrmLqVDRBzc1zvLN1xX+U2iJT1gEdSbg@mail.gmail.com>
Subject: Re: [PATCH v9 05/19] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 12:51=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.c=
om> wrote:
>
>
>
> On 8/21/2025 12:28 PM, Sagi Shahar wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
> > Let kvm_init_vm_address_properties() initialize vm->arch.{s_bit, tag_ma=
sk}
> > similar to SEV.
> >
> > TDX sets the shared bit based on the guest physical address width and
> > currently supports 48 and 52 widths.
> >
> > Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Co-developed-by: Sagi Shahar <sagis@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >   .../selftests/kvm/include/x86/tdx/tdx_util.h       | 14 +++++++++++++=
+
> >   tools/testing/selftests/kvm/lib/x86/processor.c    | 12 ++++++++++--
> >   2 files changed, 24 insertions(+), 2 deletions(-)
> >   create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx_ut=
il.h
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/t=
ools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > new file mode 100644
> > index 000000000000..286d5e3c24b1
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef SELFTESTS_TDX_TDX_UTIL_H
> > +#define SELFTESTS_TDX_TDX_UTIL_H
> > +
> > +#include <stdbool.h>
> > +
> > +#include "kvm_util.h"
> > +
> > +static inline bool is_tdx_vm(struct kvm_vm *vm)
> > +{
> > +     return vm->type =3D=3D KVM_X86_TDX_VM;
> > +}
>
> If the branch "vm->type !=3D KVM_X86_TDX_VM" in patch 04/19
> is still needed, this helper could be added earlier and used instead of
> open code.
>

I'm dropping the check in 04/19. See my response to Ira.

> > +
> > +#endif // SELFTESTS_TDX_TDX_UTIL_H
> > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/te=
sting/selftests/kvm/lib/x86/processor.c
> > index 1eae92957456..6dbf40cbbc2a 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > @@ -8,6 +8,7 @@
> >   #include "kvm_util.h"
> >   #include "processor.h"
> >   #include "sev.h"
> > +#include "tdx/tdx_util.h"
> >
> >   #ifndef NUM_INTERRUPTS
> >   #define NUM_INTERRUPTS 256
> > @@ -1190,12 +1191,19 @@ void kvm_get_cpu_address_width(unsigned int *pa=
_bits, unsigned int *va_bits)
> >
> >   void kvm_init_vm_address_properties(struct kvm_vm *vm)
> >   {
> > +     uint32_t gpa_bits =3D kvm_cpu_property(X86_PROPERTY_GUEST_MAX_PHY=
_ADDR);
> > +
> > +     vm->arch.sev_fd =3D -1;
> > +
> >       if (is_sev_vm(vm)) {
> >               vm->arch.sev_fd =3D open_sev_dev_path_or_exit();
> >               vm->arch.c_bit =3D BIT_ULL(this_cpu_property(X86_PROPERTY=
_SEV_C_BIT));
> >               vm->gpa_tag_mask =3D vm->arch.c_bit;
> > -     } else {
> > -             vm->arch.sev_fd =3D -1;
> > +     } else if (is_tdx_vm(vm)) {
> > +             TEST_ASSERT(gpa_bits =3D=3D 48 || gpa_bits =3D=3D 52,
> > +                         "TDX: bad X86_PROPERTY_GUEST_MAX_PHY_ADDR val=
ue: %u", gpa_bits);
> > +             vm->arch.s_bit =3D 1ULL << (gpa_bits - 1);
>
> Nit: Use BIT_ULL().
>

ACK, Will update in next version.

> > +             vm->gpa_tag_mask =3D vm->arch.s_bit;
> >       }
> >   }
> >
>

