Return-Path: <linux-kselftest+bounces-7356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED589AEC6
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 08:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF071F2341A
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 06:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD51876;
	Sun,  7 Apr 2024 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP1IllP8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA4E6FC3;
	Sun,  7 Apr 2024 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712470143; cv=none; b=OdU0JO0yCz324ekQRo1oMyy60DbxRmU4mEIJkmW9126koD7buXq21SXb96zuXrinVP1an8DniqggKCjzp084VhnCxRGPs8PyNKeRq3fGLGYbZ+iK1NWs9lb8ONVHb6c1wMZ++Qs9OVd2VY5fH53MBU+RDgn1BbmMJs+AxBXN5lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712470143; c=relaxed/simple;
	bh=delEZxan1fnhA6L/GdiGgg5yR6lq/O1F1NB/EXbR57U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXy3axCyZoM/iKPlQPd6kINeQdO7/JQknPkfXbVw8Ymcbp6GCWIdrOMCDO2gjmyYeyDgT0ngT4XlHCoegcxB2FNHNhrerayg63VmkFjIEm5GDjl1FjvhlnoKkKjmIh0N/hwMLPNEJpSnBwPQmFOfMvdBt2XaiTa2rZ5fQOcXun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP1IllP8; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516ef30b16eso400671e87.3;
        Sat, 06 Apr 2024 23:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712470140; x=1713074940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwqhdfOJOk0MaHNZfcfnTsXGw1LNLnH298zQoiFoYps=;
        b=RP1IllP8cgpwcrhIKhXxkfN7doPW2NYdU84QCOH6lDPoV/szsdfKuQArrsv5xMJi+r
         SS30dWGoq2VANJbLIuUIjWMYEhilu5kB4fvfjP7Bw2cis6tt8lxOs28e76hrLSbJqrRB
         2wLZGgQMnVx7G4q+TDkctkSJtykYlBv9iRydqEXNMxTj9keV2F3gvGO0v65yR+TM8Ak1
         FCw/RBvPvm+fJFwb3HJHcUTvvpQkZULYdjFdIHd2/fWiab34sWgdOwQy+1FTdTgabsoz
         EYDGqUYlNg9zNilS79c9SZk6g01aG300maoWMDnfd/BC0B3RWM179HjFQujhqEJRShlD
         4oOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712470140; x=1713074940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwqhdfOJOk0MaHNZfcfnTsXGw1LNLnH298zQoiFoYps=;
        b=ZNJaUZIwvJyO7u5tozik3z6FaWtMKZg7OCcOTLEpZoeoTcvi4aGd1KAmbAsX0YIRB3
         NNeLvYgV/28i1iQBANnmwMCZJsS1z1zmUN90MhMPr6n2WslStdDxk4QjPh/PLABoJX1b
         MPVvxako/KkC7pRHp+5dbwWkVTyK/kdtYjf1ATIg01Pgv8R8iQru3DSeXBGaYMF43xhh
         gjo1IJkkwM0H4TB5AZE4sA7jcKe3HSj4P4RnJutXJhLZKdOzllm/xh+36zbsJBG9A4hL
         olWa4r0+NxPGf73lkMqU07Obmfs9D8RcklFuOCsWMS2gJxc6O6gidSvP5/qPx3aSHQCq
         14fA==
X-Forwarded-Encrypted: i=1; AJvYcCXCij/tsGJZ6kBNUYWyGRMVOORDm88sk6xAMwXET73PQVwY3IpJnqYtD5vYQ4AjUQ6WOfvkOM/pjmOzxdNvk+m24gOi74BGB6PT94DfOD1VNMnajPPgqO1/T8hOkimdmns8K6151mRflcb/dmWjmx1f3vXEdA546qTIrM9dxzWl1sb2
X-Gm-Message-State: AOJu0YwrstRvmx8M0U7skZrcyTfepJQYu25rLPfR4iMjUAPGNdOdypZC
	E2TDskmh+qylqESO2f4IQUCWKzVYNgQC5S7q7V0v1u4Q74xMA46wQAk44UJq87zcMbAVFu2xtt4
	LMv5QYWaYreLE4CPhpFHjccgvzuk=
X-Google-Smtp-Source: AGHT+IHalJgBeNYHv+OuduAaadjWLpFmG82zb9mgb6Kh58GYSp/jo01qprOElHIH7I5cRFWp08asDejmjLO69MaXlAw=
X-Received: by 2002:a19:6908:0:b0:513:ccda:bc86 with SMTP id
 e8-20020a196908000000b00513ccdabc86mr3280571lfc.4.1712470139341; Sat, 06 Apr
 2024 23:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401082019.2318193-1-haibo1.xu@intel.com> <20240402-7bd2b9ed00094befa6927b60@orel>
 <CAJve8onPGb_ZqXaU7t50893PKS=9mrbzqvthc8dYMHDFKJdUAg@mail.gmail.com> <CAK9=C2WZB1hB-1d=16gsfWB3y=xCq5=PtfDGXc-W4ERwvWjRUg@mail.gmail.com>
In-Reply-To: <CAK9=C2WZB1hB-1d=16gsfWB3y=xCq5=PtfDGXc-W4ERwvWjRUg@mail.gmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Sun, 7 Apr 2024 14:08:47 +0800
Message-ID: <CAJve8ok1NtEf7=eDKkvZ-wv4Qb2UqzFQ-mWqkP1RNQKZRwnSKA@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: selftests: Add SBI base extension test
To: Anup Patel <apatel@ventanamicro.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 12:45=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Sun, Apr 7, 2024 at 8:11=E2=80=AFAM Haibo Xu <xiaobo55x@gmail.com> wro=
te:
> >
> > On Tue, Apr 2, 2024 at 10:12=E2=80=AFPM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> > >
> > > On Mon, Apr 01, 2024 at 04:20:18PM +0800, Haibo Xu wrote:
> > > > This is the first patch to enable the base extension selftest
> > > > for the SBI implementation in KVM. Test for other extensions
> > > > will be added later.
> > >
> > > I'm not sure we want SBI tests in KVM selftests since we already
> > > plan to add them to kvm-unit-tests, where they can be used to
> > > test both KVM's SBI implementation and M-mode firmware implementation=
s.
> > > If we also have them here, then we'll end up duplicating that effort.
> > >
> >
> > Thanks for the information, Andrew!
> >
> > The SBI KVM selftest was planned last year when I talked with Anup abou=
t
> > KVM selftest support on RISC-V. Since the kvm-unit-tests has already co=
vered
> > it, I'm fine to drop the support in KVM selftest.
>
> Initially we did plan to have all SBI tests under KVM selftests but later
> we decided to have SBI tests at a common place which will benefit all
> hypervisors and M-mode firmwares implementing SBI spec.
>
> Instead of this, I suggest we should have more selfttests targeting
> AIA (CSRs, IMSIC, and APLIC) virtualization.
>

Sure.

> Regards,
> Anup
>
> >
> > Regards,
> > Haibo
> >
> > > I do like the approach of only checking for an error, rather than
> > > also for a value, for these ID getters. In kvm-unit-tests we're
> > > currently requiring that the expected value be passed in, otherwise
> > > the whole test is skipped. We could fallback to only checking for
> > > an error instead, as is done here.
> > >
> > > Thanks,
> > > drew
> > >
> > > >
> > > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > > ---
> > > >  tools/testing/selftests/kvm/Makefile          |  1 +
> > > >  .../selftests/kvm/include/riscv/processor.h   |  8 +-
> > > >  tools/testing/selftests/kvm/riscv/sbi_test.c  | 95 +++++++++++++++=
++++
> > > >  3 files changed, 103 insertions(+), 1 deletion(-)
> > > >  create mode 100644 tools/testing/selftests/kvm/riscv/sbi_test.c
> > > >
> > > > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/s=
elftests/kvm/Makefile
> > > > index 741c7dc16afc..a6acbbcad757 100644
> > > > --- a/tools/testing/selftests/kvm/Makefile
> > > > +++ b/tools/testing/selftests/kvm/Makefile
> > > > @@ -189,6 +189,7 @@ TEST_GEN_PROGS_s390x +=3D rseq_test
> > > >  TEST_GEN_PROGS_s390x +=3D set_memory_region_test
> > > >  TEST_GEN_PROGS_s390x +=3D kvm_binary_stats_test
> > > >
> > > > +TEST_GEN_PROGS_riscv +=3D riscv/sbi_test
> > > >  TEST_GEN_PROGS_riscv +=3D arch_timer
> > > >  TEST_GEN_PROGS_riscv +=3D demand_paging_test
> > > >  TEST_GEN_PROGS_riscv +=3D dirty_log_test
> > > > diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h =
b/tools/testing/selftests/kvm/include/riscv/processor.h
> > > > index ce473fe251dd..df530ac751c4 100644
> > > > --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> > > > +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> > > > @@ -178,7 +178,13 @@ enum sbi_ext_id {
> > > >  };
> > > >
> > > >  enum sbi_ext_base_fid {
> > > > -     SBI_EXT_BASE_PROBE_EXT =3D 3,
> > > > +     SBI_EXT_BASE_GET_SPEC_VERSION =3D 0,
> > > > +     SBI_EXT_BASE_GET_IMP_ID,
> > > > +     SBI_EXT_BASE_GET_IMP_VERSION,
> > > > +     SBI_EXT_BASE_PROBE_EXT,
> > > > +     SBI_EXT_BASE_GET_MVENDORID,
> > > > +     SBI_EXT_BASE_GET_MARCHID,
> > > > +     SBI_EXT_BASE_GET_MIMPID,
> > > >  };
> > > >
> > > >  struct sbiret {
> > > > diff --git a/tools/testing/selftests/kvm/riscv/sbi_test.c b/tools/t=
esting/selftests/kvm/riscv/sbi_test.c
> > > > new file mode 100644
> > > > index 000000000000..b9378546e3b6
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/kvm/riscv/sbi_test.c
> > > > @@ -0,0 +1,95 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * sbi_test - SBI API test for KVM's SBI implementation.
> > > > + *
> > > > + * Copyright (c) 2024 Intel Corporation
> > > > + *
> > > > + * Test cover the following SBI extentions:
> > > > + *  - Base: All functions in this extension should be supported
> > > > + */
> > > > +
> > > > +#include "kvm_util.h"
> > > > +#include "processor.h"
> > > > +#include "test_util.h"
> > > > +
> > > > +/*
> > > > + * Test that all functions in the base extension must be supported
> > > > + */
> > > > +static void base_ext_guest_code(void)
> > > > +{
> > > > +     struct sbiret ret;
> > > > +
> > > > +     /*
> > > > +      * Since the base extension was introduced in SBI Spec v0.2,
> > > > +      * assert if the implemented SBI version is below 0.2.
> > > > +      */
> > > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_SPEC_VERSION=
, 0,
> > > > +                     0, 0, 0, 0, 0);
> > > > +     __GUEST_ASSERT(!ret.error && ret.value >=3D 2, "Get Spec Vers=
ion Error: ret.error=3D%ld, "
> > > > +                     "ret.value=3D%ld\n", ret.error, ret.value);
> > > > +
> > > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_IMP_ID, 0,
> > > > +                     0, 0, 0, 0, 0);
> > > > +     __GUEST_ASSERT(!ret.error && ret.value =3D=3D 3, "Get Imp ID =
Error: ret.error=3D%ld, "
> > > > +                     "ret.value=3D%ld\n",
> > > > +                     ret.error, ret.value);
> > > > +
> > > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_IMP_VERSION,=
 0,
> > > > +                     0, 0, 0, 0, 0);
> > > > +     __GUEST_ASSERT(!ret.error, "Get Imp Version Error: ret.error=
=3D%ld\n", ret.error);
> > > > +
> > > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, SBI_E=
XT_BASE,
> > > > +                     0, 0, 0, 0, 0);
> > > > +     __GUEST_ASSERT(!ret.error && ret.value =3D=3D 1, "Probe ext E=
rror: ret.error=3D%ld, "
> > > > +                     "ret.value=3D%ld\n",
> > > > +                     ret.error, ret.value);
> > > > +
> > > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_MVENDORID, 0=
,
> > > > +                     0, 0, 0, 0, 0);
> > > > +     __GUEST_ASSERT(!ret.error, "Get Machine Vendor ID Error: ret.=
error=3D%ld\n", ret.error);
> > > > +
> > > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_MARCHID, 0,
> > > > +                     0, 0, 0, 0, 0);
> > > > +     __GUEST_ASSERT(!ret.error, "Get Machine Arch ID Error: ret.er=
ror=3D%ld\n", ret.error);
> > > > +
> > > > +     ret =3D sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_MIMPID, 0,
> > > > +                     0, 0, 0, 0, 0);
> > > > +     __GUEST_ASSERT(!ret.error, "Get Machine Imp ID Error: ret.err=
or=3D%ld\n", ret.error);
> > > > +
> > > > +     GUEST_DONE();
> > > > +}
> > > > +
> > > > +static void sbi_base_ext_test(void)
> > > > +{
> > > > +     struct kvm_vm *vm;
> > > > +     struct kvm_vcpu *vcpu;
> > > > +     struct ucall uc;
> > > > +
> > > > +     vm =3D vm_create_with_one_vcpu(&vcpu, base_ext_guest_code);
> > > > +     while (1) {
> > > > +             vcpu_run(vcpu);
> > > > +             TEST_ASSERT(vcpu->run->exit_reason =3D=3D UCALL_EXIT_=
REASON,
> > > > +                         "Unexpected exit reason: %u (%s),",
> > > > +                         vcpu->run->exit_reason, exit_reason_str(v=
cpu->run->exit_reason));
> > > > +
> > > > +             switch (get_ucall(vcpu, &uc)) {
> > > > +             case UCALL_DONE:
> > > > +                     goto done;
> > > > +             case UCALL_ABORT:
> > > > +                     fprintf(stderr, "Guest assert failed!\n");
> > > > +                     REPORT_GUEST_ASSERT(uc);
> > > > +             default:
> > > > +                     TEST_FAIL("Unexpected ucall %lu", uc.cmd);
> > > > +             }
> > > > +     }
> > > > +
> > > > +done:
> > > > +     kvm_vm_free(vm);
> > > > +}
> > > > +
> > > > +int main(void)
> > > > +{
> > > > +     sbi_base_ext_test();
> > > > +
> > > > +     return 0;
> > > > +}
> > > > --
> > > > 2.34.1
> > > >
> >

