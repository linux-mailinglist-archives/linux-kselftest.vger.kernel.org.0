Return-Path: <linux-kselftest+bounces-28094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E064A4CD7A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 22:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EE3188F6B8
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 21:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE1214A93;
	Mon,  3 Mar 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="s7BJda2u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB21EEA36
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037281; cv=none; b=Td/hd+lo2ZTlJNx5RTJorQyBSGeA3KhhG5LlDY64GhgpuXPYdkdGnN63KztQCfCK11t3O0Q6brCkfKWRmZ8iG3QI2NB2XTsdPnc2mpD9qDJa8XIpZwSAeWer7mLIXK71PwveVySlmbsYXu6O2BXnZwVUw/JGW+EJYYRrMrKTOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037281; c=relaxed/simple;
	bh=BZpx2gEPJd0PbhiRp9w8O40w2vRLkWNOVY9o7RR6hiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OP4i9+no4d/7TTfsR2hv5tq6WchFMfYhI2yp6ZpsKOJXTuCqrPMNZhyQzW19x0WrK8+bOPqijxkyighE4j7YDZ6XQJr36vlBgijejkuk6U2k3JRyH9I4tv7S0SMNgrMypwjSsC9bqVLwWfh9LNNexGJRn0/VGpwXU7l040YvsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=s7BJda2u; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22349bb8605so95255795ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 13:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741037278; x=1741642078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5+6u/YZI5K5WSEGZ9NbKf7JrIHJ+VjnAiqNVQjLR1U=;
        b=s7BJda2uMTrkTrB5J0AbWvMnXcwH9GEWJadsCnZ+gwNGIBxNkzd64dpo/ikmiVV28e
         shtbUZVw7z4RBMVibt5phKRletpUML9JkzwUIHKxftDSenFtCOM64/RuNHsMSRSXMMG9
         r+gte/u5URlJSuSIf9hx8bzfeQ6xMAYCuX3WOX2EjbDq3fAi3US50dbfAsub3xbZ0jKJ
         xQmCi9/M6zI950tAkOtTnkuurT2ANbrBi+n4oDPHjm8gWJCQ43k0gmabrG9pIYDsvLhH
         l5mPeqi3hmhPBnd3ZHz+A+OtBppbT2gwvTFW7B5g+LVnAq8+vRsqexL/Y6EW9zAOebaX
         nhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741037278; x=1741642078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5+6u/YZI5K5WSEGZ9NbKf7JrIHJ+VjnAiqNVQjLR1U=;
        b=Uf8HHCl23Lkl6L9dQ8oFYoD8wKVsC5JosHXcsPKNplpcBotx30OLxm1VIat746f4VQ
         SE2qOeMN5EQoI9wwqHC6ub9Wy4FmE2O2srXbGYP2pIUHGe6RphWlmQERTfLSDBWx9uIu
         HJrr1bm3Q3q2IzkXafQuxiqMdVaQ3kr8eMHG+dqYwEDq30UfNkn8ExomYjbfT30T7Npb
         6ojvzoXW3c+uhGmShLRykWZyuSulRusiZKXvWUpCDEbZ5XzMNb9Sblr87xBPh1Fgv2lX
         PpAMafblq33IAl1sAPN1R0COjh/U3Ggq/yEx0uxW2994YGwpEEkdbAScYwtIa6EhRBEn
         2EJA==
X-Forwarded-Encrypted: i=1; AJvYcCXaJYjMCmFVayfpvY7EfDvqC1NLsZC6suqCWsMD4apMa2Qnfp+9sP1kJLw5IJqMM0+S3NtNBVdQvbEbROEjkg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UEbjTcvpW07FZBJsPXAc8Xz5rRHL6IkB0XyJ62s/2LS7MGfD
	JBA/7+PJwOwipHtQ3sKizSJesXjkfffH7wC7agUmZ+K1/mNlBwgkcIV2utfi6w9e3SuMwchZrI0
	30+TrMrirzLr/jyd6ADYXySD9/i77tFXA+mVJow==
X-Gm-Gg: ASbGnctWPVVXmfA+RXL5TxZ35FWm+iwZRU/ZC9aids2EuZLonN1t5E2srCLRb2nkiyx
	e6uHfu4ktRMnBCLr0TaBnebwUPGfsnLw5CAIVjQ+YvnpZUIWoMHX9UmboHFlczarlA2+39y78Tx
	QGgdaMsPcn6JkMQYF2NNOYNxXg
X-Google-Smtp-Source: AGHT+IFWa898pYBSsl/XtTire00C+/Mez1s46zY3VD5s0DWQi6LGPCXHd85UBauAj0l5XQztYMk3Koj9EeRJt1F3O/w=
X-Received: by 2002:a05:6a00:10d5:b0:736:54c9:df2c with SMTP id
 d2e1a72fcca58-73654c9e5damr7398143b3a.15.1741037278523; Mon, 03 Mar 2025
 13:27:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
 <20250226-kvm_pmu_improve-v1-4-74c058c2bf6d@rivosinc.com> <20250227-f7b303813dab128b5060b0c3@orel>
In-Reply-To: <20250227-f7b303813dab128b5060b0c3@orel>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 3 Mar 2025 13:27:47 -0800
X-Gm-Features: AQ5f1JoAkFSTZhtomPL4SLm3WBUMZBjoFu7rVfDIUHdBaeUMfROdiGWXnMT4KxU
Message-ID: <CAHBxVyGGw6Ur4Kdd8Vvwp6viKWPx64w7gNvNiUzmAGeXF2PGoA@mail.gmail.com>
Subject: Re: [PATCH 4/4] KVM: riscv: selftests: Allow number of interrupts to
 be configurable
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 12:16=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Wed, Feb 26, 2025 at 12:25:06PM -0800, Atish Patra wrote:
> > It is helpful to vary the number of the LCOFI interrupts generated
> > by the overflow test. Allow additional argument for overflow test
> > to accommodate that. It can be easily cross-validated with
> > /proc/interrupts output in the host.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 36 ++++++++++++++++=
++++----
> >  1 file changed, 30 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/t=
esting/selftests/kvm/riscv/sbi_pmu_test.c
> > index 533b76d0de82..7c273a1adb17 100644
> > --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> > +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> > @@ -39,8 +39,10 @@ static bool illegal_handler_invoked;
> >  #define SBI_PMU_TEST_SNAPSHOT        BIT(2)
> >  #define SBI_PMU_TEST_OVERFLOW        BIT(3)
> >
> > +#define SBI_PMU_OVERFLOW_IRQNUM_DEFAULT 5
> >  struct test_args {
> >       int disabled_tests;
> > +     int overflow_irqnum;
> >  };
> >
> >  static struct test_args targs;
> > @@ -478,7 +480,7 @@ static void test_pmu_events_snaphost(void)
> >
> >  static void test_pmu_events_overflow(void)
> >  {
> > -     int num_counters =3D 0;
> > +     int num_counters =3D 0, i =3D 0;
> >
> >       /* Verify presence of SBI PMU and minimum requrired SBI version *=
/
> >       verify_sbi_requirement_assert();
> > @@ -495,11 +497,15 @@ static void test_pmu_events_overflow(void)
> >        * Qemu supports overflow for cycle/instruction.
> >        * This test may fail on any platform that do not support overflo=
w for these two events.
> >        */
> > -     test_pmu_event_overflow(SBI_PMU_HW_CPU_CYCLES);
> > -     GUEST_ASSERT_EQ(vcpu_shared_irq_count, 1);
> > +     for (i =3D 0; i < targs.overflow_irqnum; i++)
> > +             test_pmu_event_overflow(SBI_PMU_HW_CPU_CYCLES);
> > +     GUEST_ASSERT_EQ(vcpu_shared_irq_count, targs.overflow_irqnum);
> > +
> > +     vcpu_shared_irq_count =3D 0;
> >
> > -     test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
> > -     GUEST_ASSERT_EQ(vcpu_shared_irq_count, 2);
> > +     for (i =3D 0; i < targs.overflow_irqnum; i++)
> > +             test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
> > +     GUEST_ASSERT_EQ(vcpu_shared_irq_count, targs.overflow_irqnum);
> >
> >       GUEST_DONE();
> >  }
> > @@ -621,8 +627,11 @@ static void test_vm_events_overflow(void *guest_co=
de)
> >
> >  static void test_print_help(char *name)
> >  {
> > -     pr_info("Usage: %s [-h] [-t <test name>]\n", name);
> > +     pr_info("Usage: %s [-h] [-t <test name>] [-n <number of LCOFI int=
errupt for overflow test>]\n",
> > +             name);
> >       pr_info("\t-t: Test to run (default all). Available tests are 'ba=
sic', 'events', 'snapshot', 'overflow'\n");
> > +     pr_info("\t-n: Number of LCOFI interrupt to trigger for each even=
t in overflow test (default: %d)\n",
> > +             SBI_PMU_OVERFLOW_IRQNUM_DEFAULT);
> >       pr_info("\t-h: print this help screen\n");
> >  }
> >
> > @@ -631,6 +640,8 @@ static bool parse_args(int argc, char *argv[])
> >       int opt;
> >       int temp_disabled_tests =3D SBI_PMU_TEST_BASIC | SBI_PMU_TEST_EVE=
NTS | SBI_PMU_TEST_SNAPSHOT |
> >                                 SBI_PMU_TEST_OVERFLOW;
> > +     int overflow_interrupts =3D -1;
>
> Initializing to -1 made me think that '-n 0' would be valid and a way to
> disable the overflow test, but...
>

Is there any benefit ? I found it much more convenient to select a
single test and run instead of disabling
a single test.

Once you single or a set of tests, all other tests are disabled anyways.

> > +
> >       while ((opt =3D getopt(argc, argv, "h:t:n:")) !=3D -1) {
> >               switch (opt) {
> >               case 't':
> > @@ -646,12 +657,24 @@ static bool parse_args(int argc, char *argv[])
> >                               goto done;
> >                       targs.disabled_tests =3D temp_disabled_tests;
> >                       break;
> > +             case 'n':
> > +                     overflow_interrupts =3D atoi_positive("Number of =
LCOFI", optarg);
>
> ...here we use atoi_positive() and...
>
> > +                     break;
> >               case 'h':
> >               default:
> >                       goto done;
> >               }
> >       }
> >
> > +     if (overflow_interrupts > 0) {
>
> ...here we only change from the default of 5 for nonzero.
>
> Should we allow '-n 0'? Otherwise overflow_interrupts can be initialized
> to zero (not that it matters).
>

I will change the default value to 0 to avoid ambiguity for now.
Please let me know if you strongly think we should support -n 0.
We can always support it. I just don't see the point of specifying the
test with options to disable it anymore.

> > +             if (targs.disabled_tests & SBI_PMU_TEST_OVERFLOW) {
> > +                     pr_info("-n option is only available for overflow=
 test\n");
> > +                     goto done;
> > +             } else {
> > +                     targs.overflow_irqnum =3D overflow_interrupts;
> > +             }
> > +     }
> > +
> >       return true;
> >  done:
> >       test_print_help(argv[0]);
> > @@ -661,6 +684,7 @@ static bool parse_args(int argc, char *argv[])
> >  int main(int argc, char *argv[])
> >  {
> >       targs.disabled_tests =3D 0;
> > +     targs.overflow_irqnum =3D SBI_PMU_OVERFLOW_IRQNUM_DEFAULT;
> >
> >       if (!parse_args(argc, argv))
> >               exit(KSFT_SKIP);
> >
> > --
> > 2.43.0
> >
>
> Thanks,
> drew

