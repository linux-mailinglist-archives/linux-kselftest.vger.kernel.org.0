Return-Path: <linux-kselftest+bounces-1894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAB581285E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 07:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BC0282891
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 06:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541AED28E;
	Thu, 14 Dec 2023 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="lhFWUWZ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9052E107
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 22:44:34 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b86f3cdca0so5952050b6e.3
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 22:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702536274; x=1703141074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxtiy01D8WpTYbLcMD+XHOmT3EOIKEJTAtmXTdX58vM=;
        b=lhFWUWZ/M5A9H75XVqXeeaRQLoxE1agNv2KgPpbL7X8QG2cJY446sqLefE9oRtcoEJ
         kHKBwWDECGK1Y8cdZOizt0NAN3I3iaI0liL8RFPGG/yuDgySlhINBzDF5joPmdzOjgEn
         BXrWnJn1ln9EtyZgDwqDyNZb9I5KtqVkF5XKV2Bgli90TXVFKzwS+N9HBy/Ylr/v0iLL
         hZXo/WErCLavzHhToLrZLCHh10LLOk9O5NXJeQfCicNu3XS+koQn4PpNY6Kq96hV5G9Q
         WYnIKACI3nt/ONIvahrFKdGVZp6MdWCrj9wnsTYNl91Q5WO5QOP0De15l83SCug/gdL5
         WdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536274; x=1703141074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxtiy01D8WpTYbLcMD+XHOmT3EOIKEJTAtmXTdX58vM=;
        b=V7ZGTALmWxMk0UkPtRtwq6ZEpamY9DhKVT4iz3HJtqCK45352xt/KjNloVIY3BDuHg
         wl5gIThzuJtv+Nfkc3pL3GK/hx6IMR5XFL/ww4+HzUd3f/Y04rjf6I7aXlCrMThfAnrq
         al37kHOWySPXycUWxO1HLZH8xxjwKGRH/gtr5mrlA6yr44ooDBgYv+bv5Qds12AiTydC
         b1N56LXZtT4cNvznoW5r2/LUkcz6lZHmdGOCG/BXQzByDfLk1YcL7Y10w0i+Yo7LoFkw
         /7WE+kF/XTin5ogkEV9SuGo2cebIm/eOKxbQVHw6L6lt8b6HXpAsCknLimJvNLLijUk7
         Iltg==
X-Gm-Message-State: AOJu0YwPkKMouTN3QNDHWNZiOU4StzWJ7MayvYMmE/hcRF+tJHpjH+eL
	Z8wzLc1vNgGrLtnG1H3qfFCqW5ovUnr3MlVJg2c8Ig==
X-Google-Smtp-Source: AGHT+IEPsCwgVMN/5iD2oOj8vwOEPOEacEvG4g4lr9eVc/vyryWU5/8R+8uC7/Gdwf/ytphMPl6gKCzWeBK6P1MjHrE=
X-Received: by 2002:a05:6808:13c4:b0:3b9:dea6:f336 with SMTP id
 d4-20020a05680813c400b003b9dea6f336mr11212909oiw.50.1702536273720; Wed, 13
 Dec 2023 22:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702371136.git.haibo1.xu@intel.com> <0343a9e4bfa8011fbb6bca0286cee7eab1f17d5d.1702371136.git.haibo1.xu@intel.com>
In-Reply-To: <0343a9e4bfa8011fbb6bca0286cee7eab1f17d5d.1702371136.git.haibo1.xu@intel.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 14 Dec 2023 12:14:22 +0530
Message-ID: <CAAhSdy3hXNvGiSL0VToDp2GbWcaPveg8SoMeGFeGL=MmuCpsCg@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] KVM: selftests: Enable tunning of err_margin_us
 in arch timer test
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Greentime Hu <greentime.hu@sifive.com>, 
	wchen <waylingii@gmail.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Heiko Stuebner <heiko@sntech.de>, Minda Chen <minda.chen@starfivetech.com>, 
	Samuel Holland <samuel@sholland.org>, Jisheng Zhang <jszhang@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Peter Xu <peterx@redhat.com>, Like Xu <likexu@tencent.com>, 
	Vipin Sharma <vipinsh@google.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Aaron Lewis <aaronlewis@google.com>, 
	Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc, Hi Oliver,

On Tue, Dec 12, 2023 at 2:52=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> There are intermittent failures occured when stressing the
> arch-timer test in a Qemu VM:
>
>  Guest assert failed,  vcpu 0; stage; 4; iter: 3
>  =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
>    aarch64/arch_timer.c:196: config_iter + 1 =3D=3D irq_iter
>    pid=3D4048 tid=3D4049 errno=3D4 - Interrupted system call
>       1  0x000000000040253b: test_vcpu_run at arch_timer.c:248
>       2  0x0000ffffb60dd5c7: ?? ??:0
>       3  0x0000ffffb6145d1b: ?? ??:0
>    0x3 !=3D 0x2 (config_iter + 1 !=3D irq_iter)e
>
> Further test and debug show that the timeout for an interrupt
> to arrive do have random high fluctuation, espectially when
> testing in an virtual environment.
>
> To alleviate this issue, just expose the timeout value as user
> configurable and print some hint message to increase the value
> when hitting the failure..
>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>

Can you please review this patch ?

We want to take this entire series through the KVM RISC-V tree.

Regards,
Anup

> ---
>  .../selftests/kvm/aarch64/arch_timer.c        |  8 +++++--
>  tools/testing/selftests/kvm/arch_timer.c      | 22 +++++++++++++------
>  .../selftests/kvm/include/timer_test.h        |  1 +
>  .../testing/selftests/kvm/riscv/arch_timer.c  |  8 +++++--
>  4 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/tes=
ting/selftests/kvm/aarch64/arch_timer.c
> index 4b421d421c3f..139eecbf77e7 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -131,10 +131,14 @@ static void guest_run_stage(struct test_vcpu_shared=
_data *shared_data,
>
>                 /* Setup a timeout for the interrupt to arrive */
>                 udelay(msecs_to_usecs(test_args.timer_period_ms) +
> -                       TIMER_TEST_ERR_MARGIN_US);
> +                       test_args.timer_err_margin_us);
>
>                 irq_iter =3D READ_ONCE(shared_data->nr_iter);
> -               GUEST_ASSERT_EQ(config_iter + 1, irq_iter);
> +               __GUEST_ASSERT(config_iter + 1 =3D=3D irq_iter,
> +                       "config_iter + 1 =3D 0x%lx, irq_iter =3D 0x%lx.\n=
"
> +                       "  Guest timer interrupt was not trigged within t=
he specified\n"
> +                       "  interval, try to increase the error margin by =
[-e] option.\n",
> +                       config_iter + 1, irq_iter);
>         }
>  }
>
> diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/sel=
ftests/kvm/arch_timer.c
> index 60963fce16f2..5050022fd345 100644
> --- a/tools/testing/selftests/kvm/arch_timer.c
> +++ b/tools/testing/selftests/kvm/arch_timer.c
> @@ -5,16 +5,17 @@
>   * The guest's main thread configures the timer interrupt and waits
>   * for it to fire, with a timeout equal to the timer period.
>   * It asserts that the timeout doesn't exceed the timer period plus
> - * an error margin of 100us.
> + * an user configurable error margin(default to 100us).
>   *
>   * On the other hand, upon receipt of an interrupt, the guest's interrup=
t
>   * handler validates the interrupt by checking if the architectural stat=
e
>   * is in compliance with the specifications.
>   *
>   * The test provides command-line options to configure the timer's
> - * period (-p), number of vCPUs (-n), and iterations per stage (-i).
> - * To stress-test the timer stack even more, an option to migrate the
> - * vCPUs across pCPUs (-m), at a particular rate, is also provided.
> + * period (-p), number of vCPUs (-n), iterations per stage (-i), and tim=
er
> + * interrupt arrival error margin (-e). To stress-test the timer stack e=
ven
> + * more, an option to migrate the vCPUs across pCPUs (-m), at a particul=
ar
> + * rate, is also provided.
>   *
>   * Copyright (c) 2021, Google LLC.
>   */
> @@ -34,6 +35,7 @@ struct test_args test_args =3D {
>         .nr_iter =3D NR_TEST_ITERS_DEF,
>         .timer_period_ms =3D TIMER_TEST_PERIOD_MS_DEF,
>         .migration_freq_ms =3D TIMER_TEST_MIGRATION_FREQ_MS,
> +       .timer_err_margin_us =3D TIMER_TEST_ERR_MARGIN_US,
>         .reserved =3D 1,
>  };
>
> @@ -179,8 +181,9 @@ static void test_run(struct kvm_vm *vm)
>
>  static void test_print_help(char *name)
>  {
> -       pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_p=
eriod_ms]\n",
> -               name);
> +       pr_info("Usage: %s [-h] [-n nr_vcpus] [-i iterations] [-p timer_p=
eriod_ms]\n"
> +               "\t\t    [-m migration_freq_ms] [-o counter_offset]\n"
> +               "\t\t    [-e timer_err_margin_us]\n", name);
>         pr_info("\t-n: Number of vCPUs to configure (default: %u; max: %u=
)\n",
>                 NR_VCPUS_DEF, KVM_MAX_VCPUS);
>         pr_info("\t-i: Number of iterations per stage (default: %u)\n",
> @@ -190,6 +193,8 @@ static void test_print_help(char *name)
>         pr_info("\t-m: Frequency (in ms) of vCPUs to migrate to different=
 pCPU. 0 to turn off (default: %u)\n",
>                 TIMER_TEST_MIGRATION_FREQ_MS);
>         pr_info("\t-o: Counter offset (in counter cycles, default: 0) [aa=
rch64-only]\n");
> +       pr_info("\t-e: Interrupt arrival error margin(in us) of the guest=
 timer (default: %u)\n",
> +               TIMER_TEST_ERR_MARGIN_US);
>         pr_info("\t-h: print this help screen\n");
>  }
>
> @@ -197,7 +202,7 @@ static bool parse_args(int argc, char *argv[])
>  {
>         int opt;
>
> -       while ((opt =3D getopt(argc, argv, "hn:i:p:m:o:")) !=3D -1) {
> +       while ((opt =3D getopt(argc, argv, "hn:i:p:m:o:e:")) !=3D -1) {
>                 switch (opt) {
>                 case 'n':
>                         test_args.nr_vcpus =3D atoi_positive("Number of v=
CPUs", optarg);
> @@ -216,6 +221,9 @@ static bool parse_args(int argc, char *argv[])
>                 case 'm':
>                         test_args.migration_freq_ms =3D atoi_non_negative=
("Frequency", optarg);
>                         break;
> +               case 'e':
> +                       test_args.timer_err_margin_us =3D atoi_non_negati=
ve("Error Margin", optarg);
> +                       break;
>                 case 'o':
>                         test_args.counter_offset =3D strtol(optarg, NULL,=
 0);
>                         test_args.reserved =3D 0;
> diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/tes=
ting/selftests/kvm/include/timer_test.h
> index 968257b893a7..b1d405e7157d 100644
> --- a/tools/testing/selftests/kvm/include/timer_test.h
> +++ b/tools/testing/selftests/kvm/include/timer_test.h
> @@ -22,6 +22,7 @@ struct test_args {
>         int nr_iter;
>         int timer_period_ms;
>         int migration_freq_ms;
> +       int timer_err_margin_us;
>         /* Members of struct kvm_arm_counter_offset */
>         uint64_t counter_offset;
>         uint64_t reserved;
> diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testi=
ng/selftests/kvm/riscv/arch_timer.c
> index 13bf184d1ff5..45a139dc7ce3 100644
> --- a/tools/testing/selftests/kvm/riscv/arch_timer.c
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -55,10 +55,14 @@ static void guest_run(struct test_vcpu_shared_data *s=
hared_data)
>
>                 /* Setup a timeout for the interrupt to arrive */
>                 udelay(msecs_to_usecs(test_args.timer_period_ms) +
> -                       TIMER_TEST_ERR_MARGIN_US);
> +                       test_args.timer_err_margin_us);
>
>                 irq_iter =3D READ_ONCE(shared_data->nr_iter);
> -               GUEST_ASSERT_EQ(config_iter + 1, irq_iter);
> +               __GUEST_ASSERT(config_iter + 1 =3D=3D irq_iter,
> +                       "config_iter + 1 =3D 0x%lx, irq_iter =3D 0x%lx.\n=
"
> +                       "  Guest timer interrupt was not trigged within t=
he specified\n"
> +                       "  interval, try to increase the error margin by =
[-e] option.\n",
> +                       config_iter + 1, irq_iter);
>         }
>  }
>
> --
> 2.34.1
>

