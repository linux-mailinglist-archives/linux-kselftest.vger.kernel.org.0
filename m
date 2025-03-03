Return-Path: <linux-kselftest+bounces-28093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278E6A4CCFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 21:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B411897D5B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 20:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2693823717D;
	Mon,  3 Mar 2025 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uOFh884x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546721ADAB
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035222; cv=none; b=b2KIIs4Ydgu2bxSX4JQ+jnXO/0ryl+xyNc11kVBa1FQB4aswS/J9t10febTXg45QL6lU8MgoSXqhu7Nq+Ju2+KRKnghHxWTFiBVHg1MwkDNeeyXY5iXOEH+QLLbsmZBp3vtE9OQENT0k6pq9rdU1CN3J1cm2mlKQprQlZD7spz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035222; c=relaxed/simple;
	bh=OedX+KmRNsSP5qwD3uo/SOxs71msjzcbVQqNZ/HnSqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCf2cKMAJV/is/NDN8lLjK256yGiSd7tYVfwsJKNXHiW1XmWRRnWahTvu6SFB1/Rtm8reeiyQqrExoqkyImKRn4jUehUN1M4PwmepeUjfp0XMj/pfdnonPfpyizD3uTlvQ54V2Z0xUF9pvWncjuhZSlyu1fDx1bR82oWNMSllL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uOFh884x; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223480ea43aso122125425ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 12:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741035218; x=1741640018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5AQc/OecpKtLu8kT/3BCu+mfDeh9ylI+xKZIi5ekec=;
        b=uOFh884x43VjW66KHj/ZZO5DIK3e9SL2nYv+FKMa5847kN/GmXmVs+PWlp1QTxfN/G
         KmTY50SsLJmBQbrY73DGWjOKO8Ul+s6xPnd+GOYModSBV5WBm2Kz4WrtgYecaYBOZIoi
         Oq7YfJTCnMZYTRvbxcsGE2WBg0EIkP1mPaGanRCHWLotjO9sZugcDrXTFNZ6tMUbj3cm
         1avLGpHp5VA7h/Zikm2Zn6Mc2+2khEKH5Q5zqMIGldD4oaVmA/+jwxqRTdlVnhAbfWDI
         BDRlZvsLuLuX8gJPxGLZv8ksiIDcSmt4k5Q/jg0nCuHowlOZ6QncZgcoGRhKWC+zvvO0
         JYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741035218; x=1741640018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5AQc/OecpKtLu8kT/3BCu+mfDeh9ylI+xKZIi5ekec=;
        b=ehvz8JPYIdnb+CeP5UH/j4JhUb/+8y6uJcdd37vSTQKmsJuXN9trL8/oywdChRtmuT
         lQMsC7AcWR3WtvxizSEPyHOQXNKpiA9VXYBpXRhUCrhQJMt1t3mXJBCTugRrqNbpKgSe
         uEoxpjWYV6oYm8ANxDkkVJaMNdd2MxwqI7TVLLLIUCwrwyBUEXyVTxzCARNcgfSUad3D
         LCV3CNZJEssmqg0/APjLx0Td4cS/N6SHyEblmnuc6OrHOQdgSkI8wnf4Ww+oeGKb6z2F
         ZnGrocsC/kRNJXub9fQEgzb3xW4R0GHtAqQbMeXkpSM11Bz84qFu7h9arcDMdt1YYLfm
         /1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMS1pS//dZnV91UK41DxM3yT7lT4DweHNZvhdY3dXvB/kmxuHdMZgeX5wfRG7ljTuY9uqbqfm0tRYDjq2/1Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhPpWyBIc7qKy9eFFBwl+kd20zSsWgYMFUny4+5gTpuEsyMlxy
	wtTDiIkLeanaqYsaN9qA+XYiFSQic28N1AwW1TBlPN5HAAUOtnB35/gEr0NOmN9HdX9/KDWGZjI
	atF1sW8/+zzC2oNDRtC1ICwzDNH3yESjgFJ+Glg==
X-Gm-Gg: ASbGncstqfxW7IygdVuHBQdA99fgu++QCYT0pB9fJh/KVd0N1UOgRYxX1t6IjlmLMHw
	o/7LcHRk87WN7T4R7eeY4/tkmIIB/z9s19tuH5qFWa15v0wIr+cAbYc7d0C0GKUBZbt1eHNHrlg
	gG9J7g4H2xREjyjjbKVRpnFtUm
X-Google-Smtp-Source: AGHT+IFxmaYGsqxuWzE42pNki0QyERt8aeeJIc4FpkFS3fZJz6bTIl+8F5KKzfYsUutrBaR5UQYgO+HCr+aSIeXuR/8=
X-Received: by 2002:a17:902:ec82:b0:21f:89e5:2712 with SMTP id
 d9443c01a7336-22369247861mr199207785ad.39.1741035217946; Mon, 03 Mar 2025
 12:53:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
 <20250226-kvm_pmu_improve-v1-3-74c058c2bf6d@rivosinc.com> <20250227-eb9e3d8de1de2ff609ac8f64@orel>
In-Reply-To: <20250227-eb9e3d8de1de2ff609ac8f64@orel>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 3 Mar 2025 12:53:27 -0800
X-Gm-Features: AQ5f1Jrqg0QCQLdb27_ngzuhj87U0gO9gK8_pEhgxfLHs93uJVPCudYkbQ6uAvs
Message-ID: <CAHBxVyF=gteGvQqbCAy88heLzfAWebuUH2PXud=zvMjmxsE0YA@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: riscv: selftests: Change command line option
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 12:08=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Wed, Feb 26, 2025 at 12:25:05PM -0800, Atish Patra wrote:
> > The PMU test commandline option takes an argument to disable a
> > certain test. The initial assumption behind this was a common use case
> > is just to run all the test most of the time. However, running a single
> > test seems more useful instead. Especially, the overflow test has been
> > helpful to validate PMU virtualizaiton interrupt changes.
> >
> > Switching the command line option to run a single test instead
> > of disabling a single test also allows to provide additional
> > test specific arguments to the test. The default without any options
> > remains unchanged which continues to run all the tests.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 40 +++++++++++++++-=
--------
> >  1 file changed, 26 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/t=
esting/selftests/kvm/riscv/sbi_pmu_test.c
> > index 284bc80193bd..533b76d0de82 100644
> > --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> > +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> > @@ -39,7 +39,11 @@ static bool illegal_handler_invoked;
> >  #define SBI_PMU_TEST_SNAPSHOT        BIT(2)
> >  #define SBI_PMU_TEST_OVERFLOW        BIT(3)
> >
> > -static int disabled_tests;
> > +struct test_args {
> > +     int disabled_tests;
> > +};
> > +
> > +static struct test_args targs;
> >
> >  unsigned long pmu_csr_read_num(int csr_num)
> >  {
> > @@ -604,7 +608,11 @@ static void test_vm_events_overflow(void *guest_co=
de)
> >       vcpu_init_vector_tables(vcpu);
> >       /* Initialize guest timer frequency. */
> >       timer_freq =3D vcpu_get_reg(vcpu, RISCV_TIMER_REG(frequency));
> > +
> > +     /* Export the shared variables to the guest */
> >       sync_global_to_guest(vm, timer_freq);
> > +     sync_global_to_guest(vm, vcpu_shared_irq_count);
> > +     sync_global_to_guest(vm, targs);
> >
> >       run_vcpu(vcpu);
> >
> > @@ -613,28 +621,30 @@ static void test_vm_events_overflow(void *guest_c=
ode)
> >
> >  static void test_print_help(char *name)
> >  {
> > -     pr_info("Usage: %s [-h] [-d <test name>]\n", name);
> > -     pr_info("\t-d: Test to disable. Available tests are 'basic', 'eve=
nts', 'snapshot', 'overflow'\n");
> > +     pr_info("Usage: %s [-h] [-t <test name>]\n", name);
> > +     pr_info("\t-t: Test to run (default all). Available tests are 'ba=
sic', 'events', 'snapshot', 'overflow'\n");
>
> It's probably fine to drop '-d', since we don't make any claims about
> support, but doing so does risk breaking some CI somewhere. If that
> potential breakage is a concern, then we could keep '-d', since nothing
> stops us from having both.

I don't think we have so much legacy usage with this test that we need
to maintain both options.
Since this was merged only a few cycles ago, I assume that it's not
available in many CI to cause breakage.
If somebody running CI actually shouts that it breaks their setup,
sure. Otherwise, I feel it will be just confusing to the users.

>
> >       pr_info("\t-h: print this help screen\n");
> >  }
> >
> >  static bool parse_args(int argc, char *argv[])
> >  {
> >       int opt;
> > -
> > -     while ((opt =3D getopt(argc, argv, "hd:")) !=3D -1) {
> > +     int temp_disabled_tests =3D SBI_PMU_TEST_BASIC | SBI_PMU_TEST_EVE=
NTS | SBI_PMU_TEST_SNAPSHOT |
> > +                               SBI_PMU_TEST_OVERFLOW;
> > +     while ((opt =3D getopt(argc, argv, "h:t:n:")) !=3D -1) {
>
> '-h' doesn't need an argument and '-n' should be introduced with the next
> patch.
>

Yes. Thanks for catching it. I will fix it in v2.

> >               switch (opt) {
> > -             case 'd':
> > +             case 't':
> >                       if (!strncmp("basic", optarg, 5))
> > -                             disabled_tests |=3D SBI_PMU_TEST_BASIC;
> > +                             temp_disabled_tests &=3D ~SBI_PMU_TEST_BA=
SIC;
> >                       else if (!strncmp("events", optarg, 6))
> > -                             disabled_tests |=3D SBI_PMU_TEST_EVENTS;
> > +                             temp_disabled_tests &=3D ~SBI_PMU_TEST_EV=
ENTS;
> >                       else if (!strncmp("snapshot", optarg, 8))
> > -                             disabled_tests |=3D SBI_PMU_TEST_SNAPSHOT=
;
> > +                             temp_disabled_tests &=3D ~SBI_PMU_TEST_SN=
APSHOT;
> >                       else if (!strncmp("overflow", optarg, 8))
> > -                             disabled_tests |=3D SBI_PMU_TEST_OVERFLOW=
;
> > +                             temp_disabled_tests &=3D ~SBI_PMU_TEST_OV=
ERFLOW;
> >                       else
> >                               goto done;
> > +                     targs.disabled_tests =3D temp_disabled_tests;
> >                       break;
> >               case 'h':
> >               default:
> > @@ -650,25 +660,27 @@ static bool parse_args(int argc, char *argv[])
> >
> >  int main(int argc, char *argv[])
> >  {
> > +     targs.disabled_tests =3D 0;
> > +
> >       if (!parse_args(argc, argv))
> >               exit(KSFT_SKIP);
> >
> > -     if (!(disabled_tests & SBI_PMU_TEST_BASIC)) {
> > +     if (!(targs.disabled_tests & SBI_PMU_TEST_BASIC)) {
> >               test_vm_basic_test(test_pmu_basic_sanity);
> >               pr_info("SBI PMU basic test : PASS\n");
> >       }
> >
> > -     if (!(disabled_tests & SBI_PMU_TEST_EVENTS)) {
> > +     if (!(targs.disabled_tests & SBI_PMU_TEST_EVENTS)) {
> >               test_vm_events_test(test_pmu_events);
> >               pr_info("SBI PMU event verification test : PASS\n");
> >       }
> >
> > -     if (!(disabled_tests & SBI_PMU_TEST_SNAPSHOT)) {
> > +     if (!(targs.disabled_tests & SBI_PMU_TEST_SNAPSHOT)) {
> >               test_vm_events_snapshot_test(test_pmu_events_snaphost);
> >               pr_info("SBI PMU event verification with snapshot test : =
PASS\n");
> >       }
> >
> > -     if (!(disabled_tests & SBI_PMU_TEST_OVERFLOW)) {
> > +     if (!(targs.disabled_tests & SBI_PMU_TEST_OVERFLOW)) {
> >               test_vm_events_overflow(test_pmu_events_overflow);
> >               pr_info("SBI PMU event verification with overflow test : =
PASS\n");
> >       }
> >
> > --
> > 2.43.0
> >
>
> Otherwise,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

