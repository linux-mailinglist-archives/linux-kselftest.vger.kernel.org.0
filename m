Return-Path: <linux-kselftest+bounces-8679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF18E8AE087
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 11:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35715B2454F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DD055C3A;
	Tue, 23 Apr 2024 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JjjwOQ6i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180456448;
	Tue, 23 Apr 2024 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862995; cv=none; b=LUUPZKbrTxiloqXUk5tXzsAgxTJw6eHlocjsGFAwteAKiMeW9lGIwdLcgLb+npZMHlqX0Ihq+ryNeluJwM6chmbqhXM+L+OGRY1v1DVxXZpcbbyp+J8zUhJohdUb57QqRfdVwkN9Yvk7JX1wM/c46ADVif0NrMtLgSBF104kaH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862995; c=relaxed/simple;
	bh=ZhShH3/3rdnIjiL1nxztMfl3ZOxaEjovEywEq+0BN6o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ud96GHdEvhp16NgvTwoRZ8BEY/yBoZqsICuTSM5gCuj6Ww5BCZC0EcX6xd69j/NVg2y8wLYeovgd3ZoIxRu4TkIfp9vsyUr++qk2F4FFoGoI1FIOdXuwJog4tLojy4XqecIuXEo0RJetg71p49V4tlB8nkSV9ONayxSHPzGxYC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JjjwOQ6i; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713862991;
	bh=ZhShH3/3rdnIjiL1nxztMfl3ZOxaEjovEywEq+0BN6o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=JjjwOQ6isr691Bw4kJAkfAfT+SMmu4biuU/dRrtYswGHFCulY/PdgxGcX7HKyBifO
	 JpcFVgdz+L5UZ1seL02TMghlOJ1RnaqNfBt/0h9MoR3tlfaGB3kt3DkcmFSg3AdEmP
	 dQkGwNTYGvF3QOLGsV6kT0azFNIQ29hcFiVUfJ0xFl31fDTnQtLR22Ulu2RQErtIYP
	 tI72e/U7ymSlS91ObLPs7XjPbWXVpfdPN3lcG0UNk3sQ/+uMr7pfuO5mWdwUMg68lt
	 AwqhJDFzmDtKqkKk9QWP1rbSD8/vD+8MeVr0YM8EiwX4Ls5FgkZgrLRmMvxI2kem5J
	 Nmyrk4NP97tEQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C2BD83780016;
	Tue, 23 Apr 2024 09:03:01 +0000 (UTC)
Message-ID: <724a4797-18dc-4011-ba48-445c1cb6a976@collabora.com>
Date: Tue, 23 Apr 2024 14:03:29 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>,
 samuel.holland@sifive.com, Conor Dooley <conor.dooley@microchip.com>,
 Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v8 24/24] KVM: riscv: selftests: Add commandline option
 for SBI PMU test
To: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org
References: <20240420151741.962500-1-atishp@rivosinc.com>
 <20240420151741.962500-25-atishp@rivosinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240420151741.962500-25-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/24 8:17 PM, Atish Patra wrote:
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
LGTM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 73 ++++++++++++++++---
>  1 file changed, 64 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> index 0fd9b76ae838..69bb94e6b227 100644
> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
> @@ -33,6 +33,13 @@ static unsigned long counter_mask_available;
>  
>  static bool illegal_handler_invoked;
>  
> +#define SBI_PMU_TEST_BASIC	BIT(0)
> +#define SBI_PMU_TEST_EVENTS	BIT(1)
> +#define SBI_PMU_TEST_SNAPSHOT	BIT(2)
> +#define SBI_PMU_TEST_OVERFLOW	BIT(3)
> +
> +static int disabled_tests;
> +
>  unsigned long pmu_csr_read_num(int csr_num)
>  {
>  #define switchcase_csr_read(__csr_num, __val)		{\
> @@ -608,19 +615,67 @@ static void test_vm_events_overflow(void *guest_code)
>  	test_vm_destroy(vm);
>  }
>  
> -int main(void)
> +static void test_print_help(char *name)
> +{
> +	pr_info("Usage: %s [-h] [-d <test name>]\n", name);
A little weird that we have pr_info named helper to print logs when it is a
userspace application, not kernel code. I'll check it in the source who
added it to the KVM tests.

> +	pr_info("\t-d: Test to disable. Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");
> +	pr_info("\t-h: print this help screen\n");
> +}
> +
> +static bool parse_args(int argc, char *argv[])
> +{
> +	int opt;
> +
> +	while ((opt = getopt(argc, argv, "hd:")) != -1) {
> +		switch (opt) {
> +		case 'd':
> +			if (!strncmp("basic", optarg, 5))
> +				disabled_tests |= SBI_PMU_TEST_BASIC;
> +			else if (!strncmp("events", optarg, 6))
> +				disabled_tests |= SBI_PMU_TEST_EVENTS;
> +			else if (!strncmp("snapshot", optarg, 8))
> +				disabled_tests |= SBI_PMU_TEST_SNAPSHOT;
> +			else if (!strncmp("overflow", optarg, 8))
> +				disabled_tests |= SBI_PMU_TEST_OVERFLOW;
> +			else
> +				goto done;
> +			break;
> +		case 'h':
> +		default:
> +			goto done;
> +		}
> +	}
> +
> +	return true;
> +done:
> +	test_print_help(argv[0]);
> +	return false;
> +}
> +
> +int main(int argc, char *argv[])
>  {
> -	test_vm_basic_test(test_pmu_basic_sanity);
> -	pr_info("SBI PMU basic test : PASS\n");
> +	if (!parse_args(argc, argv))
> +		exit(KSFT_SKIP);
> +
> +	if (!(disabled_tests & SBI_PMU_TEST_BASIC)) {
> +		test_vm_basic_test(test_pmu_basic_sanity);
> +		pr_info("SBI PMU basic test : PASS\n");
> +	}
>  
> -	test_vm_events_test(test_pmu_events);
> -	pr_info("SBI PMU event verification test : PASS\n");
> +	if (!(disabled_tests & SBI_PMU_TEST_EVENTS)) {
> +		test_vm_events_test(test_pmu_events);
> +		pr_info("SBI PMU event verification test : PASS\n");
> +	}
>  
> -	test_vm_events_snapshot_test(test_pmu_events_snaphost);
> -	pr_info("SBI PMU event verification with snapshot test : PASS\n");
> +	if (!(disabled_tests & SBI_PMU_TEST_SNAPSHOT)) {
> +		test_vm_events_snapshot_test(test_pmu_events_snaphost);
> +		pr_info("SBI PMU event verification with snapshot test : PASS\n");
> +	}
>  
> -	test_vm_events_overflow(test_pmu_events_overflow);
> -	pr_info("SBI PMU event verification with overflow test : PASS\n");
> +	if (!(disabled_tests & SBI_PMU_TEST_OVERFLOW)) {
> +		test_vm_events_overflow(test_pmu_events_overflow);
> +		pr_info("SBI PMU event verification with overflow test : PASS\n");
> +	}
>  
>  	return 0;
>  }

-- 
BR,
Muhammad Usama Anjum

