Return-Path: <linux-kselftest+bounces-27718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B944A47785
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 09:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7EE16FFEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 08:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9DE225417;
	Thu, 27 Feb 2025 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EnoNz4dm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96C22157B
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644185; cv=none; b=XazRp86LuJaUcbn3p3BC29wJsV7k5KiNj8Q6egVTkiAOkYeX6tyXeoX94acW+MOOjwS7HtVJfzjQdJdRPgpCNfxjkUbjha9Bs0yzG1aeGlk8qhvBDF262CVD71/XUaaK0xm7NyAJmqhEmj0XCHiRrH+6w4q96LF03eQPynsgOIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644185; c=relaxed/simple;
	bh=9kotOf/80zjGjwSPL1iPbKHTAaLkUSSv99p6A0UlVJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCvk5txd3S9b3Zpo8n+hd5cngmdzYGFznXaODUIvTC/FQOkVXHsKO3oY3n8hiBfUpkIkHTWvhCv++ZtMHfD+YvemK+lF/1H9dw991ptJmvQgTaGEfCz3kynDtgxOkW7HppCiOKZlp3YpHczwWkil+6CWkpzkxZNfqzxQAoRccko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EnoNz4dm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4399d14334aso5917445e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 00:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740644181; x=1741248981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNuCHwKGXQWAf4mt8sNekn31y9wTAPf53BsIAPyDFlg=;
        b=EnoNz4dmJd7f0NEA4UXkv7aP6B174avNLBBEK5LyYmWNNnZEEwT7UEq/IsYIHgddnF
         Y9ksm2ZetWZLhubDbo8dhR9pjdjk1ZetBTWVOlZpV/3W/58aA3GNeKPEUITUFLJBZk0j
         LVpGZJkEx2C8jsiNiuViIWEtotA6sjlFWGqnnlgNgMuylSZz38wRBdiZgIcvPdAlkK1k
         PrgMJE9AuMWbzwAFiGdtM8oAa3o1VukD6ZGe2wxqXhGm4LWLejDI8C/nShfJ75hNY5fM
         9n9b1oeoNlNOSvf5fVU/UyNpVvBnsZIRq5MzC9XEcGkKYApYNSfD5h74W46fL2ymcThq
         NG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740644181; x=1741248981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNuCHwKGXQWAf4mt8sNekn31y9wTAPf53BsIAPyDFlg=;
        b=UJbuXeiCr3h0yQhvlTcvaJ7yZwWXqm1z9Pc2X3Pp2N7G3Ow12/8yQuiVSsq1xiw0Qp
         Z30yXsY8m56FkCN57j6sycCCFezZKJBTyah41JqdE27RrdRGPB5DaJkIg1P6CFrZ+wPQ
         YgUU/MvVYjFs/j6eiEdafoqgoppELQ6hjZ0kAqk1bsUozScIujxX1Rt/D3OhChAnZ1Q3
         BfeeR4RAjc89BoNMtHy2iyocZftOwCYkmnAkCDcjE/MiXnAiVO6r8piY3bXXQ8yhtD/2
         3ORgEdom4zFFEwSyUdlGjlE/nt2p46Tk4+WhXxDK5bCFiTaGfbUuF0vNHViDTZwTU9NZ
         wJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBy4QWOt42byJ8jzoYCYoY//7pBrnNOtjACETYUM473xqUIiQYyP/MwED8eDXd60l8yPVWUw9aFRlFWqPcDnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHcL6xAskPStoKKyi99dkD7b/Nz6GGBx5qiEyQM3cmrQWbyHhM
	TIJ0v/IzDiWrHIEPS6nh/PROianEmuGCjzkQW5TYFGUWi1myuzhCBrfpVIwyxQg=
X-Gm-Gg: ASbGncu2wHJ733JedbVUetzkFzJiGfUuT7Dz5f6dcUm57TkfQyggVwZ4brMKPwzhed4
	2HQtKqM+fmAdhcXnPGP7PgQ7SlkHdKDbMuxY5+OGlL4FizrJQAmYomf2NdoofRDTnP0iRuzuWvB
	tdPD8y3B1D2q5Um8ByhdUUJNe1XXKbRKw15OsoYXHdzGcxIBJdNfdfTPDMJwxGKJ6N/45fzU6Wa
	XoxfnTvBZSBcVraGfJRTCaPyXzcWt4FePhuYfO5hBQI1+7zoO0h26dMUebNsxIKchdjdIozTI8G
	ZFqFihIm52Z5OA==
X-Google-Smtp-Source: AGHT+IGtkCGpzCQFwmHGo5aZlDGSlBp1jN55CoUYkN1FZsHypqajvqpmjpcHqYvMPO3dlRrienJsOQ==
X-Received: by 2002:a05:600c:3588:b0:439:6304:e28a with SMTP id 5b1f17b1804b1-43ab8f6fe56mr58126325e9.0.1740644180644;
        Thu, 27 Feb 2025 00:16:20 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::8cf0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796051sm1260460f8f.12.2025.02.27.00.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:16:20 -0800 (PST)
Date: Thu, 27 Feb 2025 09:16:19 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: riscv: selftests: Allow number of interrupts to
 be configurable
Message-ID: <20250227-f7b303813dab128b5060b0c3@orel>
References: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
 <20250226-kvm_pmu_improve-v1-4-74c058c2bf6d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-kvm_pmu_improve-v1-4-74c058c2bf6d@rivosinc.com>

On Wed, Feb 26, 2025 at 12:25:06PM -0800, Atish Patra wrote:
> It is helpful to vary the number of the LCOFI interrupts generated
> by the overflow test. Allow additional argument for overflow test
> to accommodate that. It can be easily cross-validated with
> /proc/interrupts output in the host.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 36 ++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> index 533b76d0de82..7c273a1adb17 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> @@ -39,8 +39,10 @@ static bool illegal_handler_invoked;
>  #define SBI_PMU_TEST_SNAPSHOT	BIT(2)
>  #define SBI_PMU_TEST_OVERFLOW	BIT(3)
>  
> +#define SBI_PMU_OVERFLOW_IRQNUM_DEFAULT 5
>  struct test_args {
>  	int disabled_tests;
> +	int overflow_irqnum;
>  };
>  
>  static struct test_args targs;
> @@ -478,7 +480,7 @@ static void test_pmu_events_snaphost(void)
>  
>  static void test_pmu_events_overflow(void)
>  {
> -	int num_counters = 0;
> +	int num_counters = 0, i = 0;
>  
>  	/* Verify presence of SBI PMU and minimum requrired SBI version */
>  	verify_sbi_requirement_assert();
> @@ -495,11 +497,15 @@ static void test_pmu_events_overflow(void)
>  	 * Qemu supports overflow for cycle/instruction.
>  	 * This test may fail on any platform that do not support overflow for these two events.
>  	 */
> -	test_pmu_event_overflow(SBI_PMU_HW_CPU_CYCLES);
> -	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 1);
> +	for (i = 0; i < targs.overflow_irqnum; i++)
> +		test_pmu_event_overflow(SBI_PMU_HW_CPU_CYCLES);
> +	GUEST_ASSERT_EQ(vcpu_shared_irq_count, targs.overflow_irqnum);
> +
> +	vcpu_shared_irq_count = 0;
>  
> -	test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
> -	GUEST_ASSERT_EQ(vcpu_shared_irq_count, 2);
> +	for (i = 0; i < targs.overflow_irqnum; i++)
> +		test_pmu_event_overflow(SBI_PMU_HW_INSTRUCTIONS);
> +	GUEST_ASSERT_EQ(vcpu_shared_irq_count, targs.overflow_irqnum);
>  
>  	GUEST_DONE();
>  }
> @@ -621,8 +627,11 @@ static void test_vm_events_overflow(void *guest_code)
>  
>  static void test_print_help(char *name)
>  {
> -	pr_info("Usage: %s [-h] [-t <test name>]\n", name);
> +	pr_info("Usage: %s [-h] [-t <test name>] [-n <number of LCOFI interrupt for overflow test>]\n",
> +		name);
>  	pr_info("\t-t: Test to run (default all). Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");
> +	pr_info("\t-n: Number of LCOFI interrupt to trigger for each event in overflow test (default: %d)\n",
> +		SBI_PMU_OVERFLOW_IRQNUM_DEFAULT);
>  	pr_info("\t-h: print this help screen\n");
>  }
>  
> @@ -631,6 +640,8 @@ static bool parse_args(int argc, char *argv[])
>  	int opt;
>  	int temp_disabled_tests = SBI_PMU_TEST_BASIC | SBI_PMU_TEST_EVENTS | SBI_PMU_TEST_SNAPSHOT |
>  				  SBI_PMU_TEST_OVERFLOW;
> +	int overflow_interrupts = -1;

Initializing to -1 made me think that '-n 0' would be valid and a way to
disable the overflow test, but...

> +
>  	while ((opt = getopt(argc, argv, "h:t:n:")) != -1) {
>  		switch (opt) {
>  		case 't':
> @@ -646,12 +657,24 @@ static bool parse_args(int argc, char *argv[])
>  				goto done;
>  			targs.disabled_tests = temp_disabled_tests;
>  			break;
> +		case 'n':
> +			overflow_interrupts = atoi_positive("Number of LCOFI", optarg);

...here we use atoi_positive() and...

> +			break;
>  		case 'h':
>  		default:
>  			goto done;
>  		}
>  	}
>  
> +	if (overflow_interrupts > 0) {

...here we only change from the default of 5 for nonzero.

Should we allow '-n 0'? Otherwise overflow_interrupts can be initialized
to zero (not that it matters).

> +		if (targs.disabled_tests & SBI_PMU_TEST_OVERFLOW) {
> +			pr_info("-n option is only available for overflow test\n");
> +			goto done;
> +		} else {
> +			targs.overflow_irqnum = overflow_interrupts;
> +		}
> +	}
> +
>  	return true;
>  done:
>  	test_print_help(argv[0]);
> @@ -661,6 +684,7 @@ static bool parse_args(int argc, char *argv[])
>  int main(int argc, char *argv[])
>  {
>  	targs.disabled_tests = 0;
> +	targs.overflow_irqnum = SBI_PMU_OVERFLOW_IRQNUM_DEFAULT;
>  
>  	if (!parse_args(argc, argv))
>  		exit(KSFT_SKIP);
> 
> -- 
> 2.43.0
>

Thanks,
drew

