Return-Path: <linux-kselftest+bounces-7355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E19E89AE94
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 06:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5262BB227C3
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 04:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745481C0DF2;
	Sun,  7 Apr 2024 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KlnhA/+2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5BA35
	for <linux-kselftest@vger.kernel.org>; Sun,  7 Apr 2024 04:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712465148; cv=none; b=Hp9z9uHGQR2kjaT2neQGpxbFCdbHhEtk5yqr5xtr1Ky8v8vzsZkebV4+DWKqT32nwqeZm+Ex7ijUvKzkbKriHrzYwHDMOx+l9gT7GLr4voqBpqIOmDdxXeYZtjJHspVqH2M4swC8c1Cm65zxj/rrS1RYgGLlqo97ey5R+cqEj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712465148; c=relaxed/simple;
	bh=INxIervR3VDxQw8sARKqwRWBD00LGNPMY+fDGaAjOdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncnrZ08Pf2VHu7phu20dae+BEeIZXyaY0arga/klS1O1WqbMorpj2yG15wi4fi67y0xCbj4aKEJGK9g6G37RKl+qn/szzU+QYHturO1s3SX7NoJDRmBFcDWGGbcMgTLFIGOFkzA2Ri4RcQ7jEB2qywigRCaIu0r1CH8iFl2hvgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=KlnhA/+2; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d718ee7344so39794131fa.2
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Apr 2024 21:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712465143; x=1713069943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wx+tvzf/dqR7g3UekoPgNpWDOrGKteh8fMPAcmqeh0=;
        b=KlnhA/+2FclbG4xdZDhpyrCvbYn3h2ZROu30Hc5ocrvaEoG9pw6o2jYtbwsXXMCCDa
         dvdzZSJWGSOF4UJ+48tjTazGBl7jiXcqaCIJiqzirfncLZbm0OkgMO6HDdZLbWamVWr9
         vt/O59LulvGHDAdxcYbddx1xl5LRAy6OhO+1Q4pl/IfbMW00hkswZvCRgPewIenNo0iC
         EjSxQxrmIFsFIh1Xjkeiz42q9/Nwm0l1EfP+gtyJIopoW1QJ22Bi0CnG3Pw82Qb1lQ56
         N0COiWS50qw3iT7O0jBakZG31v7yQkOrwxkAGgy3vgS0kyCJV/YT9J6V2/QnTI8CIGDC
         DbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712465143; x=1713069943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Wx+tvzf/dqR7g3UekoPgNpWDOrGKteh8fMPAcmqeh0=;
        b=UI9N83NSH/4SoizJ97YRX1yYt54lO6vy6J5ZSIa7gbwOF4hDZ496VyD2/+0tX3p+oA
         +3SGB9uxWdhIQEy72wF/FjyfU6xj0hhh0yBdJZrpg6ZI+2KCuwQd7zxmjpXcNnH3NPUS
         51AYUpWJq1HYxMZSF6DrzkpMEkQrhY1H0TTlpK3VhEpqNyCO89Bd9mNRCBtDNGpQNFhg
         UsVmRRiRjy1EfBtHQSvyU9meBjz7JgDO29xaCVtHwkeJooAMcLIvS1qKkmDAFQzikeLg
         VQQkq5rn7bVEw4EDiBSM+73b4dS5Nrcp1SACMVkIzTWkyXG+35x/ST35XbkRYwBST2A4
         KhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLy1p08kW4ztV0aRUOiUO///eexn+rkpxXFaA5WCfnJ3LMlIcmIEEnP96AdBNUUzwpacWuKWiVL8UYXC7ZG7ZDg34stW8hwlJuPnb2VTOI
X-Gm-Message-State: AOJu0YxZkYlwLRBVnR92ctcWp7/IkfBokhlAfJA50ALChLUuLmd8YPY4
	XgzTMx8xd/F7odMNOqKfuJHyChmdyz9XMNl2Si83P7Jr6NRactWuo8X6b/BsmwrlqPfAVeZUAhb
	VwheX8jRyomeogTRkALU2yBionr5Lj/V8cTPH/g==
X-Google-Smtp-Source: AGHT+IGJCr3Wjf0U1Yter0JcM2+uSdQM/FIxnCt4+SuUS6s2NgmDGqrmbYCWLmG2K+z5rKS+5hO5vuRo+IwPtPmqIEM=
X-Received: by 2002:a2e:9f0c:0:b0:2d4:3d86:54e2 with SMTP id
 u12-20020a2e9f0c000000b002d43d8654e2mr3747138ljk.27.1712465142893; Sat, 06
 Apr 2024 21:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401082019.2318193-1-haibo1.xu@intel.com> <20240402-7bd2b9ed00094befa6927b60@orel>
 <CAJve8onPGb_ZqXaU7t50893PKS=9mrbzqvthc8dYMHDFKJdUAg@mail.gmail.com>
In-Reply-To: <CAJve8onPGb_ZqXaU7t50893PKS=9mrbzqvthc8dYMHDFKJdUAg@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Sun, 7 Apr 2024 10:15:31 +0530
Message-ID: <CAK9=C2WZB1hB-1d=16gsfWB3y=xCq5=PtfDGXc-W4ERwvWjRUg@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: selftests: Add SBI base extension test
To: Haibo Xu <xiaobo55x@gmail.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 8:11=E2=80=AFAM Haibo Xu <xiaobo55x@gmail.com> wrote=
:
>
> On Tue, Apr 2, 2024 at 10:12=E2=80=AFPM Andrew Jones <ajones@ventanamicro=
.com> wrote:
> >
> > On Mon, Apr 01, 2024 at 04:20:18PM +0800, Haibo Xu wrote:
> > > This is the first patch to enable the base extension selftest
> > > for the SBI implementation in KVM. Test for other extensions
> > > will be added later.
> >
> > I'm not sure we want SBI tests in KVM selftests since we already
> > plan to add them to kvm-unit-tests, where they can be used to
> > test both KVM's SBI implementation and M-mode firmware implementations.
> > If we also have them here, then we'll end up duplicating that effort.
> >
>
> Thanks for the information, Andrew!
>
> The SBI KVM selftest was planned last year when I talked with Anup about
> KVM selftest support on RISC-V. Since the kvm-unit-tests has already cove=
red
> it, I'm fine to drop the support in KVM selftest.

Initially we did plan to have all SBI tests under KVM selftests but later
we decided to have SBI tests at a common place which will benefit all
hypervisors and M-mode firmwares implementing SBI spec.

Instead of this, I suggest we should have more selfttests targeting
AIA (CSRs, IMSIC, and APLIC) virtualization.

Regards,
Anup

>
> Regards,
> Haibo
>
> > I do like the approach of only checking for an error, rather than
> > also for a value, for these ID getters. In kvm-unit-tests we're
> > currently requiring that the expected value be passed in, otherwise
> > the whole test is skipped. We could fallback to only checking for
> > an error instead, as is done here.
> >
> > Thanks,
> > drew
> >
> > >
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > ---
> > >  tools/testing/selftests/kvm/Makefile          |  1 +
> > >  .../selftests/kvm/include/riscv/processor.h   |  8 +-
> > >  tools/testing/selftests/kvm/riscv/sbi_test.c  | 95 +++++++++++++++++=
++
> > >  3 files changed, 103 insertions(+), 1 deletion(-)
> > >  create mode 100644 tools/testing/selftests/kvm/riscv/sbi_test.c
> > >
> > > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/sel=
ftests/kvm/Makefile
> > > index 741c7dc16afc..a6acbbcad757 100644
> > > --- a/tools/testing/selftests/kvm/Makefile
> > > +++ b/tools/testing/selftests/kvm/Makefile
> > > @@ -189,6 +189,7 @@ TEST_GEN_PROGS_s390x +=3D rseq_test
> > >  TEST_GEN_PROGS_s390x +=3D set_memory_region_test
> > >  TEST_GEN_PROGS_s390x +=3D kvm_binary_stats_test
> > >
> > > +TEST_GEN_PROGS_riscv +=3D riscv/sbi_test
> > >  TEST_GEN_PROGS_riscv +=3D arch_timer
> > >  TEST_GEN_PROGS_riscv +=3D demand_paging_test
> > >  TEST_GEN_PROGS_riscv +=3D dirty_log_test
> > > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/=
tools/testing/selftests/kvm/include/riscv/processor.h
> > > index ce473fe251dd..df530ac751c4 100644
> > > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > > @@ -178,7 +178,13 @@ enum sbi_ext_id {
> > >  };
> > >
> > >  enum sbi_ext_base_fid {
> > > -     SBI_EXT_BASE_PROBE_EXT =3D 3,
> > > +     SBI_EXT_BASE_GET_SPEC_VERSION =3D 0,
> > > +     SBI_EXT_BASE_GET_IMP_ID,
> > > +     SBI_EXT_BASE_GET_IMP_VERSION,
> > > +     SBI_EXT_BASE_PROBE_EXT,
> > > +     SBI_EXT_BASE_GET_MVENDORID,
> > > +     SBI_EXT_BASE_GET_MARCHID,
> > > +     SBI_EXT_BASE_GET_MIMPID,
> > >  };
> > >
> > >  struct sbiret {
> > > diff --git a/tools/testing/selftests/kvm/riscv/sbi_test.c b/tools/tes=
ting/selftests/kvm/riscv/sbi_test.c
> > > new file mode 100644
> > > index 000000000000..b9378546e3b6
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/kvm/riscv/sbi_test.c
> > > @@ -0,0 +1,95 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * sbi_test - SBI API test for KVM's SBI implementation.
> > > + *
> > > + * Copyright (c) 2024 Intel Corporation
> > > + *
> > > + * Test cover the following SBI extentions:
> > > + *  - Base: All functions in this extension should be supported
> > > + */
> > > +
> > > +#include "kvm_util.h"
> > > +#include "processor.h"
> > > +#include "test_util.h"
> > > +
> > > +/*
> > > + * Test that all functions in the base extension must be supported
> > > + */
> > > +static void base_ext_guest_code(void)
> > > +{
> > > +     struct sbiret ret;
> > > +
> > > +     /*
> > > +      * Since the base extension was introduced in SBI Spec v0.2,
> > > +      * assert if the implemented SBI version is below 0.2.
> > > +      */
> > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_SPEC_VERSION, =
0,
> > > +                     0, 0, 0, 0, 0);
> > > +     __GUEST_ASSERT(!ret.error && ret.value >=3D 2, "Get Spec Versio=
n Error: ret.error=3D%ld, "
> > > +                     "ret.value=3D%ld\n", ret.error, ret.value);
> > > +
> > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_IMP_ID, 0,
> > > +                     0, 0, 0, 0, 0);
> > > +     __GUEST_ASSERT(!ret.error && ret.value =3D=3D 3, "Get Imp ID Er=
ror: ret.error=3D%ld, "
> > > +                     "ret.value=3D%ld\n",
> > > +                     ret.error, ret.value);
> > > +
> > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_IMP_VERSION, 0=
,
> > > +                     0, 0, 0, 0, 0);
> > > +     __GUEST_ASSERT(!ret.error, "Get Imp Version Error: ret.error=3D=
%ld\n", ret.error);
> > > +
> > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, SBI_EXT=
_BASE,
> > > +                     0, 0, 0, 0, 0);
> > > +     __GUEST_ASSERT(!ret.error && ret.value =3D=3D 1, "Probe ext Err=
or: ret.error=3D%ld, "
> > > +                     "ret.value=3D%ld\n",
> > > +                     ret.error, ret.value);
> > > +
> > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_MVENDORID, 0,
> > > +                     0, 0, 0, 0, 0);
> > > +     __GUEST_ASSERT(!ret.error, "Get Machine Vendor ID Error: ret.er=
ror=3D%ld\n", ret.error);
> > > +
> > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_MARCHID, 0,
> > > +                     0, 0, 0, 0, 0);
> > > +     __GUEST_ASSERT(!ret.error, "Get Machine Arch ID Error: ret.erro=
r=3D%ld\n", ret.error);
> > > +
> > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_MIMPID, 0,
> > > +                     0, 0, 0, 0, 0);
> > > +     __GUEST_ASSERT(!ret.error, "Get Machine Imp ID Error: ret.error=
=3D%ld\n", ret.error);
> > > +
> > > +     GUEST_DONE();
> > > +}
> > > +
> > > +static void sbi_base_ext_test(void)
> > > +{
> > > +     struct kvm_vm *vm;
> > > +     struct kvm_vcpu *vcpu;
> > > +     struct ucall uc;
> > > +
> > > +     vm =3D vm_create_with_one_vcpu(&vcpu, base_ext_guest_code);
> > > +     while (1) {
> > > +             vcpu_run(vcpu);
> > > +             TEST_ASSERT(vcpu->run->exit_reason =3D=3D UCALL_EXIT_RE=
ASON,
> > > +                         "Unexpected exit reason: %u (%s),",
> > > +                         vcpu->run->exit_reason, exit_reason_str(vcp=
u->run->exit_reason));
> > > +
> > > +             switch (get_ucall(vcpu, &uc)) {
> > > +             case UCALL_DONE:
> > > +                     goto done;
> > > +             case UCALL_ABORT:
> > > +                     fprintf(stderr, "Guest assert failed!\n");
> > > +                     REPORT_GUEST_ASSERT(uc);
> > > +             default:
> > > +                     TEST_FAIL("Unexpected ucall %lu", uc.cmd);
> > > +             }
> > > +     }
> > > +
> > > +done:
> > > +     kvm_vm_free(vm);
> > > +}
> > > +
> > > +int main(void)
> > > +{
> > > +     sbi_base_ext_test();
> > > +
> > > +     return 0;
> > > +}
> > > --
> > > 2.34.1
> > >
>

