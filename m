Return-Path: <linux-kselftest+bounces-7354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BDC89AE1A
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 04:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E409C281994
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 02:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E515C0;
	Sun,  7 Apr 2024 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRnwqjXX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415EA935;
	Sun,  7 Apr 2024 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712457669; cv=none; b=N4S8gq8YwJl2QzCDXQmR2KDWDknJWzcGp2GvIFTD8OUArjNWo5Z5lrpZInS5usbDluFQ3QwAOhV87pJRWcmLric0lZyR6QBEFNJM32QGgyMX192eoWHmfEt5We3aqdVmjh4e4iYdOGOEplIls8k59bijNJLtLafuT4cF6qqjT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712457669; c=relaxed/simple;
	bh=jE8wYV7ClylQm1BWuzREFYyBRBC/QLEWOZoJ5AuIi5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwHGC6Rj/sk8PKVCJPNkm6Fs1KlOROZH+V4JW1i7Xz3E4FOhSiCdxdIjDnluQ01dmDrTcKj+8xfqs/rZ2009vuKlEyII9VpANFeaoC1GeFy1PtCBWiEDvOnfHpIuNYcIyPCszDsZEDDmQha/FiEcBSrzgr4+u70iEvyYH5k9FSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRnwqjXX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d47ce662so3050071e87.1;
        Sat, 06 Apr 2024 19:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712457666; x=1713062466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svi7IG4j1NCRd7Qsuibjxz4QatOdbrOlqhYRp4ynUhA=;
        b=fRnwqjXX9bBprzYPn4eqjndNI88CTqWYjLBipZ2c87woM1vBOpGDFiubr2BrPT7JwO
         Hq3p1obCTou4ee+ri6ho6rhYoyb8WpBpcVEFxcFUIbkBQSWTpzmOw7IvzBEG2BQYymuK
         9Ab9goZGU1cG6w626tPvVVi87lcbsC9MS++C/qd9sEwDy6Tf0EbXi2WR0wz68r9V0zoE
         A6bOzvmidJsmY+/XpYUcChJkrbxAvVGE+TAJakZ1lvPhwxmmQ/G/eiXaMMj7ma5xBdTi
         5mOxGoCTIesbwvzRFdG8ahAbu0pvxWsmi88jrVDIHOhix54qB4EMbPQd7fg5nu4Qebhq
         RKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712457666; x=1713062466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svi7IG4j1NCRd7Qsuibjxz4QatOdbrOlqhYRp4ynUhA=;
        b=ey+PFsEzZnKdjRaTa4pUxI4Ye435rCqQ3hUodLK55AeeXX3d45Rt0E3yJTC5gTO6a3
         SETsu5DeYHlVG/61m651WLgLSSjsov34/tHMVLIfAP940h5DtiqACvzCh71Vah3giShe
         CTAbADHfElq+wnNfL/GeopN9pou0TvmbZPJr55lRXIz04wTIg/fn2w6kMAFMxPxU550E
         L+QGtM0RxNAngSnwjFO8dCBkavlUvmC3tYTxWGWFZ022RaKg32rmShMlSUbNWso+dyIv
         rLF1SHLi8B0QQvMkf/kB18+EUPpN1psMqy17Upk7QOOuNz4cDrsqZx/IgN3yKNXkGEd8
         PNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8FXPXzAIGMnuPyxp/1FUNjwNilmjwdbFGbXukVQWdrJzEAeEYb0kJ1mKI6iP9tSQLnmIqrgrFAf6L7Yp99HkxJylqBtYn8AoPK6B1YYKKcrat7u9dQRHypOD+yLNNqFD3Agbhy4AP9ASCU6vuMSGT6vz+TOyub0A237oA0wlJgtm4
X-Gm-Message-State: AOJu0YxnijzEDXMbX5Gh/7U6q/pqOMNMPm45wyED5odbKpBcOEQyRO3n
	Dy52n8Wo0BsfWOBxWJ2DMWIzmvTvu6nzJ4L0f9ZcUrZA0w5Dy0NlN58t14rKpPEfq45++oZPhCK
	dfr+QtXqHRkK3p4a/riQ4+iWX31o=
X-Google-Smtp-Source: AGHT+IGWhN1NiFvJL3wo1zaH/XA3X0sToWCJylJisJevqvEm+O++z85W13bqOe6L/e+DrbufZDhUvIpgKc3pOrd4vSU=
X-Received: by 2002:ac2:5612:0:b0:513:ebb5:d9b0 with SMTP id
 v18-20020ac25612000000b00513ebb5d9b0mr4104722lfd.52.1712457665721; Sat, 06
 Apr 2024 19:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401082019.2318193-1-haibo1.xu@intel.com> <20240402-7bd2b9ed00094befa6927b60@orel>
In-Reply-To: <20240402-7bd2b9ed00094befa6927b60@orel>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Sun, 7 Apr 2024 10:40:54 +0800
Message-ID: <CAJve8onPGb_ZqXaU7t50893PKS=9mrbzqvthc8dYMHDFKJdUAg@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: selftests: Add SBI base extension test
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 10:12=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Mon, Apr 01, 2024 at 04:20:18PM +0800, Haibo Xu wrote:
> > This is the first patch to enable the base extension selftest
> > for the SBI implementation in KVM. Test for other extensions
> > will be added later.
>
> I'm not sure we want SBI tests in KVM selftests since we already
> plan to add them to kvm-unit-tests, where they can be used to
> test both KVM's SBI implementation and M-mode firmware implementations.
> If we also have them here, then we'll end up duplicating that effort.
>

Thanks for the information, Andrew!

The SBI KVM selftest was planned last year when I talked with Anup about
KVM selftest support on RISC-V. Since the kvm-unit-tests has already covere=
d
it, I'm fine to drop the support in KVM selftest.

Regards,
Haibo

> I do like the approach of only checking for an error, rather than
> also for a value, for these ID getters. In kvm-unit-tests we're
> currently requiring that the expected value be passed in, otherwise
> the whole test is skipped. We could fallback to only checking for
> an error instead, as is done here.
>
> Thanks,
> drew
>
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  tools/testing/selftests/kvm/Makefile          |  1 +
> >  .../selftests/kvm/include/riscv/processor.h   |  8 +-
> >  tools/testing/selftests/kvm/riscv/sbi_test.c  | 95 +++++++++++++++++++
> >  3 files changed, 103 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/kvm/riscv/sbi_test.c
> >
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selft=
ests/kvm/Makefile
> > index 741c7dc16afc..a6acbbcad757 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -189,6 +189,7 @@ TEST_GEN_PROGS_s390x +=3D rseq_test
> >  TEST_GEN_PROGS_s390x +=3D set_memory_region_test
> >  TEST_GEN_PROGS_s390x +=3D kvm_binary_stats_test
> >
> > +TEST_GEN_PROGS_riscv +=3D riscv/sbi_test
> >  TEST_GEN_PROGS_riscv +=3D arch_timer
> >  TEST_GEN_PROGS_riscv +=3D demand_paging_test
> >  TEST_GEN_PROGS_riscv +=3D dirty_log_test
> > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/to=
ols/testing/selftests/kvm/include/riscv/processor.h
> > index ce473fe251dd..df530ac751c4 100644
> > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > @@ -178,7 +178,13 @@ enum sbi_ext_id {
> >  };
> >
> >  enum sbi_ext_base_fid {
> > -     SBI_EXT_BASE_PROBE_EXT =3D 3,
> > +     SBI_EXT_BASE_GET_SPEC_VERSION =3D 0,
> > +     SBI_EXT_BASE_GET_IMP_ID,
> > +     SBI_EXT_BASE_GET_IMP_VERSION,
> > +     SBI_EXT_BASE_PROBE_EXT,
> > +     SBI_EXT_BASE_GET_MVENDORID,
> > +     SBI_EXT_BASE_GET_MARCHID,
> > +     SBI_EXT_BASE_GET_MIMPID,
> >  };
> >
> >  struct sbiret {
> > diff --git a/tools/testing/selftests/kvm/riscv/sbi_test.c b/tools/testi=
ng/selftests/kvm/riscv/sbi_test.c
> > new file mode 100644
> > index 000000000000..b9378546e3b6
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/riscv/sbi_test.c
> > @@ -0,0 +1,95 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * sbi_test - SBI API test for KVM's SBI implementation.
> > + *
> > + * Copyright (c) 2024 Intel Corporation
> > + *
> > + * Test cover the following SBI extentions:
> > + *  - Base: All functions in this extension should be supported
> > + */
> > +
> > +#include "kvm_util.h"
> > +#include "processor.h"
> > +#include "test_util.h"
> > +
> > +/*
> > + * Test that all functions in the base extension must be supported
> > + */
> > +static void base_ext_guest_code(void)
> > +{
> > +     struct sbiret ret;
> > +
> > +     /*
> > +      * Since the base extension was introduced in SBI Spec v0.2,
> > +      * assert if the implemented SBI version is below 0.2.
> > +      */
> > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_SPEC_VERSION, 0,
> > +                     0, 0, 0, 0, 0);
> > +     __GUEST_ASSERT(!ret.error && ret.value >=3D 2, "Get Spec Version =
Error: ret.error=3D%ld, "
> > +                     "ret.value=3D%ld\n", ret.error, ret.value);
> > +
> > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_IMP_ID, 0,
> > +                     0, 0, 0, 0, 0);
> > +     __GUEST_ASSERT(!ret.error && ret.value =3D=3D 3, "Get Imp ID Erro=
r: ret.error=3D%ld, "
> > +                     "ret.value=3D%ld\n",
> > +                     ret.error, ret.value);
> > +
> > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_IMP_VERSION, 0,
> > +                     0, 0, 0, 0, 0);
> > +     __GUEST_ASSERT(!ret.error, "Get Imp Version Error: ret.error=3D%l=
d\n", ret.error);
> > +
> > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, SBI_EXT_B=
ASE,
> > +                     0, 0, 0, 0, 0);
> > +     __GUEST_ASSERT(!ret.error && ret.value =3D=3D 1, "Probe ext Error=
: ret.error=3D%ld, "
> > +                     "ret.value=3D%ld\n",
> > +                     ret.error, ret.value);
> > +
> > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_MVENDORID, 0,
> > +                     0, 0, 0, 0, 0);
> > +     __GUEST_ASSERT(!ret.error, "Get Machine Vendor ID Error: ret.erro=
r=3D%ld\n", ret.error);
> > +
> > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_MARCHID, 0,
> > +                     0, 0, 0, 0, 0);
> > +     __GUEST_ASSERT(!ret.error, "Get Machine Arch ID Error: ret.error=
=3D%ld\n", ret.error);
> > +
> > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_MIMPID, 0,
> > +                     0, 0, 0, 0, 0);
> > +     __GUEST_ASSERT(!ret.error, "Get Machine Imp ID Error: ret.error=
=3D%ld\n", ret.error);
> > +
> > +     GUEST_DONE();
> > +}
> > +
> > +static void sbi_base_ext_test(void)
> > +{
> > +     struct kvm_vm *vm;
> > +     struct kvm_vcpu *vcpu;
> > +     struct ucall uc;
> > +
> > +     vm =3D vm_create_with_one_vcpu(&vcpu, base_ext_guest_code);
> > +     while (1) {
> > +             vcpu_run(vcpu);
> > +             TEST_ASSERT(vcpu->run->exit_reason =3D=3D UCALL_EXIT_REAS=
ON,
> > +                         "Unexpected exit reason: %u (%s),",
> > +                         vcpu->run->exit_reason, exit_reason_str(vcpu-=
>run->exit_reason));
> > +
> > +             switch (get_ucall(vcpu, &uc)) {
> > +             case UCALL_DONE:
> > +                     goto done;
> > +             case UCALL_ABORT:
> > +                     fprintf(stderr, "Guest assert failed!\n");
> > +                     REPORT_GUEST_ASSERT(uc);
> > +             default:
> > +                     TEST_FAIL("Unexpected ucall %lu", uc.cmd);
> > +             }
> > +     }
> > +
> > +done:
> > +     kvm_vm_free(vm);
> > +}
> > +
> > +int main(void)
> > +{
> > +     sbi_base_ext_test();
> > +
> > +     return 0;
> > +}
> > --
> > 2.34.1
> >

