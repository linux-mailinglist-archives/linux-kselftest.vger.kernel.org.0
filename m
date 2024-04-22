Return-Path: <linux-kselftest+bounces-8593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8EC8AC3B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 07:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C491C21898
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 05:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1B31803E;
	Mon, 22 Apr 2024 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="o6tQD90I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431FF1759F
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 05:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763972; cv=none; b=mTwyVpu8t1bHoU6MNAovTJTNsuVredpdn+XwBfYq/mJS6sUtUvVNZNkip2yK5WggG9w/pCKxb/scPm3DYMf2i6ZuWomOa3/jXQSGvcvJAJF1QjqlI7l6ZVygyeP9cpJ6kTTx9KJEFdLGBDZuhy+5MzHSLKHs2FyQS0wWSH+ydJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763972; c=relaxed/simple;
	bh=BwCdWcMLmgKeTy/zl1TsPBXPPuxkE/Xsmo260vkgIDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgnW6ZXKPbu7aAUJBxhL5PAdiEtwrkjeKGLv5naHvcOMwRAgBYoiNOQpirhNPYY2HqXgJ1xMcjT3GdqkUuAGbQx5Pf5snMaOjtpaKbP8Yz7U5ZWTXvTTu7SMEmGjrKE4VyubxDNOEag8U0e0dJCKKj/3jtFb/hAaT5kfqgVysdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=o6tQD90I; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36bff60429cso9407575ab.2
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Apr 2024 22:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713763970; x=1714368770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mSLO7qsMu9ScrRVYm3QHz5Wa7uqrp1Jo4sRqwEm41k=;
        b=o6tQD90ICgKGUhcbrhk1jF3W+tlwQyTzOMCPEuDBKXwb7XAeo2TRjRwTAGKDHdsGBX
         4t/GLY8tVkSf5IQ7cDbqBdQRiKlYUV2yWxdhi7+MrHdhuMP0d7kULVF61AWI+kl/ALtH
         VmtSmgQQ/LxURYZZjf7JZxM4vSOYG2XuVWcTnzVVmvfd2OQ9T9d/M43yOF2piP9ncmBZ
         i0/Y/WGQAV9wZON4/r+Egvl03Ma0PgSKEuvw57rs6UwMznjUI2yTi4AD9w7HrMowtZTm
         OuVRzWteq23FoVe+983P33VvHrVz+rzc4axkuGn/HJC+MfliELkHuOxMlm8mgLps3dxL
         z2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763970; x=1714368770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mSLO7qsMu9ScrRVYm3QHz5Wa7uqrp1Jo4sRqwEm41k=;
        b=hMbHHucHJzVvZ1j80nZzebOMh/bvSBxUmyFuzkUfZRNxL3LcpEVemMwaTN8urHxgJU
         UJAyPWhlAvnVbMyjAUe0OU5cl5CuZ9bg+3YDAadz4R8A4UYORBuH+13M9HVXSL0eBgB5
         VNn3NdmAv2F1cLGqwJnn/AGGssWP6VRqHtPU9sLukptNFBDISvdmEfsceW7CWqIW4db3
         4Kc67kp4C1MQW4kifqQ3q/dJbT6xoQme/ZYADtuP0ZXV4xxyz7OkKWVOgqZRB4J0Z917
         J+/+FSULwFrv1/qNM3ur1ehZ0F/YB22iV4Tj0vR+N9mUD3sKOtM2AJK5z7n7N4rj9huA
         JO7A==
X-Forwarded-Encrypted: i=1; AJvYcCUk/5GZw8Gbjz8QSiV7pGc3QYfvFbLkLX0BaTB1OfM2I4GoMBVbwQJgN1mel11z8N8IEdLRjXkp8TThOcb6PPPqAuJ/4g7o5zZvpGovUXty
X-Gm-Message-State: AOJu0YxEJdxUxc1Yi71+P+NSmYQnHGpgFxaUYDrkSZNyiaamsSV4Vn9Q
	QeluFrCmbfselKUxzd/NrGZWOcVWeMnR71hRw5zwcZN0QmjP3EsBav1Kfn5rdCOLLPkJFZyI2tg
	PNnjLpRoWZmAcsSQrFAMoAT2j2iutmVJw4pOXyg==
X-Google-Smtp-Source: AGHT+IEqy96d9EYvPfCKQbMdPNUPl6DZT781YdOhP9O47wLCNvRvtopYWldFwJankgX0sYeovuf51APBEHy0ooQ/k/Q=
X-Received: by 2002:a05:6e02:144d:b0:36a:686:b3bf with SMTP id
 p13-20020a056e02144d00b0036a0686b3bfmr13479495ilo.17.1713763970407; Sun, 21
 Apr 2024 22:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-25-atishp@rivosinc.com>
In-Reply-To: <20240420151741.962500-25-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 11:02:39 +0530
Message-ID: <CAAhSdy0Bo1+SomNva+A_Phd=gu_+wcqXTV_-ioqCCVEr1cXJBA@mail.gmail.com>
Subject: Re: [PATCH v8 24/24] KVM: riscv: selftests: Add commandline option
 for SBI PMU test
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, samuel.holland@sifive.com, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 5:18=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> SBI PMU test comprises of multiple tests and user may want to run
> only a subset depending on the platform. The most common case would
> be to run all to validate all the tests. However, some platform may
> not support all events or all ISA extensions.
>
> The commandline option allows user to disable any set of tests if
> they want to.
>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 73 ++++++++++++++++---
>  1 file changed, 64 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/tes=
ting/selftests/kvm/riscv/sbi_pmu_test.c
> index 0fd9b76ae838..69bb94e6b227 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> @@ -33,6 +33,13 @@ static unsigned long counter_mask_available;
>
>  static bool illegal_handler_invoked;
>
> +#define SBI_PMU_TEST_BASIC     BIT(0)
> +#define SBI_PMU_TEST_EVENTS    BIT(1)
> +#define SBI_PMU_TEST_SNAPSHOT  BIT(2)
> +#define SBI_PMU_TEST_OVERFLOW  BIT(3)
> +
> +static int disabled_tests;
> +
>  unsigned long pmu_csr_read_num(int csr_num)
>  {
>  #define switchcase_csr_read(__csr_num, __val)          {\
> @@ -608,19 +615,67 @@ static void test_vm_events_overflow(void *guest_cod=
e)
>         test_vm_destroy(vm);
>  }
>
> -int main(void)
> +static void test_print_help(char *name)
> +{
> +       pr_info("Usage: %s [-h] [-d <test name>]\n", name);
> +       pr_info("\t-d: Test to disable. Available tests are 'basic', 'eve=
nts', 'snapshot', 'overflow'\n");
> +       pr_info("\t-h: print this help screen\n");
> +}
> +
> +static bool parse_args(int argc, char *argv[])
> +{
> +       int opt;
> +
> +       while ((opt =3D getopt(argc, argv, "hd:")) !=3D -1) {
> +               switch (opt) {
> +               case 'd':
> +                       if (!strncmp("basic", optarg, 5))
> +                               disabled_tests |=3D SBI_PMU_TEST_BASIC;
> +                       else if (!strncmp("events", optarg, 6))
> +                               disabled_tests |=3D SBI_PMU_TEST_EVENTS;
> +                       else if (!strncmp("snapshot", optarg, 8))
> +                               disabled_tests |=3D SBI_PMU_TEST_SNAPSHOT=
;
> +                       else if (!strncmp("overflow", optarg, 8))
> +                               disabled_tests |=3D SBI_PMU_TEST_OVERFLOW=
;
> +                       else
> +                               goto done;
> +                       break;
> +               case 'h':
> +               default:
> +                       goto done;
> +               }
> +       }
> +
> +       return true;
> +done:
> +       test_print_help(argv[0]);
> +       return false;
> +}
> +
> +int main(int argc, char *argv[])
>  {
> -       test_vm_basic_test(test_pmu_basic_sanity);
> -       pr_info("SBI PMU basic test : PASS\n");
> +       if (!parse_args(argc, argv))
> +               exit(KSFT_SKIP);
> +
> +       if (!(disabled_tests & SBI_PMU_TEST_BASIC)) {
> +               test_vm_basic_test(test_pmu_basic_sanity);
> +               pr_info("SBI PMU basic test : PASS\n");
> +       }
>
> -       test_vm_events_test(test_pmu_events);
> -       pr_info("SBI PMU event verification test : PASS\n");
> +       if (!(disabled_tests & SBI_PMU_TEST_EVENTS)) {
> +               test_vm_events_test(test_pmu_events);
> +               pr_info("SBI PMU event verification test : PASS\n");
> +       }
>
> -       test_vm_events_snapshot_test(test_pmu_events_snaphost);
> -       pr_info("SBI PMU event verification with snapshot test : PASS\n")=
;
> +       if (!(disabled_tests & SBI_PMU_TEST_SNAPSHOT)) {
> +               test_vm_events_snapshot_test(test_pmu_events_snaphost);
> +               pr_info("SBI PMU event verification with snapshot test : =
PASS\n");
> +       }
>
> -       test_vm_events_overflow(test_pmu_events_overflow);
> -       pr_info("SBI PMU event verification with overflow test : PASS\n")=
;
> +       if (!(disabled_tests & SBI_PMU_TEST_OVERFLOW)) {
> +               test_vm_events_overflow(test_pmu_events_overflow);
> +               pr_info("SBI PMU event verification with overflow test : =
PASS\n");
> +       }
>
>         return 0;
>  }
> --
> 2.34.1
>

