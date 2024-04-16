Return-Path: <linux-kselftest+bounces-8101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 875858A666D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF931B24FEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 08:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08DA85286;
	Tue, 16 Apr 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PdOYWbRE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C262907
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257349; cv=none; b=FVscwP6yxQ+ATFvU9xmBbjW2enidoNgHeoJeo2HRfbT8x+XmyTkXAmvVkGgHPZnlz0h7oH26DzE9fq1qmoiz/mR0fU7Mnu7Uhuf7mRc0dnsUMT8tGCud2kSi9STT8Oj7i+aYGxXrLWo2QV0vAL/iD9rAa30OYC0CidOYXRhkv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257349; c=relaxed/simple;
	bh=5Ugj44ELKaezQMYHW4xB3ZcmBsV3qnLcoNGHNm1mHxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3tcwSlXA0aGm+ve3RwN5dnpJRd+znRC7on20Uy4mu19R/VAtjD4fYz4645Rq3hMw71kqsryhpVyG8XmvXXx9h8KO0NzSOPUqCl8h+crc5r9BWhNi2hrY9Lu9XaKshmpP352zWAWnIgUd6oqTpPfyqWRACkhp7lA4a+9Nne8OEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PdOYWbRE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a4df5d83c7so2678337a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713257347; x=1713862147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YB4OKZ5azyoBQVdDaeHRwpejD252N/Wm8xYNs68na58=;
        b=PdOYWbREAycb+IT5cv0/iFArt+jZqZKo8J7Vy8pwYMFdow2wq3pdH1uWBFOgw/+qKU
         Hh8lCRGtZrRtTdIHw44XdwaTc2ip/kDJ7DC+RxkuvvUavkpJ92gzUZXLmSBdbkCF95dy
         KVTjfW3sS8xeieHpQuVW9hHr9w+lffE62ofon0pUPPVOMHUNvRZvpHgxf8nJ7OrvOnKi
         6pcPVpr4nunH9u4MjyG/U0v7eDZF+i3SDUKbaL70dNyA+q38Or6Wgq7wSIMSIIiLZZ6s
         ehpDuojEDSMQzoF+PqB5l97JLVQIXEzPlHr7nbZoWeQx5hI4DVEWun7EBG7TkwaZzVd3
         wtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713257347; x=1713862147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YB4OKZ5azyoBQVdDaeHRwpejD252N/Wm8xYNs68na58=;
        b=e+NLignOA+dpHB4WvTZfXXbjPO7T7320ct3sjglyEVxyi4Q0I09HcZ6Bza2p3k20xj
         vYabfEhEyoEdZuTXpCIhqZmnDqEH8fKZ5ugzUYF7D44OF1FiVSU0tEqUKHnAIQK0Z0N0
         +sxodyg5P4DjH9zMC3XoA4dXCJk/xU7keuYT9Lv4w/2DqUUafRaHvaKMFCJXJch0V1sp
         NSZ1n73mNqhyjK6fOeNXZntgN/R9iBKNA12IODhP6vGS5wqbwJ/TScjlQtfUxGpk6PuW
         DIv1ZrX3EYAFi16sEywFjUdSNWaOjTeQLCwKaiE8LJV/UPsfoWE7wWajTNrpRd6Lp0LM
         VhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4lQqNz0PaNqS6i29ZfSH8M9yWoBvkqfiF3wwxhbVdHCVL4pvmKPOZtNia+lzog26Ce2uBAbA+Nkawhu8tp4SCXIktx1Tq1IoWhcrXk4N7
X-Gm-Message-State: AOJu0YwRyE4HadkQp42tRSSokJE9f/2GwI3jROU7u47oWCSpbQauujos
	v584DICIjq+/0D+TDuy/AQEn0kO7FdY8H/l3JS0XNC+QAaIFYCFnPe0aNYvf7eA=
X-Google-Smtp-Source: AGHT+IE5kvYAIrAzLyhCQG7YuKZN0xkJ8aTxnfQzZtfDgG4X+MG0/9j9aFOlv84kCs3vDDCZ3jMEMA==
X-Received: by 2002:a17:90a:ae12:b0:2a0:5f10:990c with SMTP id t18-20020a17090aae1200b002a05f10990cmr11367042pjq.10.1713257347059;
        Tue, 16 Apr 2024 01:49:07 -0700 (PDT)
Received: from [172.16.0.33] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090abf0900b002a610ef880bsm8721392pjs.6.2024.04.16.01.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:49:06 -0700 (PDT)
Message-ID: <be9a80a3-64f1-4848-94a4-031a3ea797ad@rivosinc.com>
Date: Tue, 16 Apr 2024 01:49:04 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 24/24] KVM: riscv: selftests: Add commandline option
 for SBI PMU test
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-25-atishp@rivosinc.com>
 <20240415-8b9ad5a7e968b1808e99e3da@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240415-8b9ad5a7e968b1808e99e3da@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 06:43, Andrew Jones wrote:
> On Wed, Apr 10, 2024 at 05:07:52PM -0700, Atish Patra wrote:
>> SBI PMU test comprises of multiple tests and user may want to run
>> only a subset depending on the platform. The most common case would
>> be to run all to validate all the tests. However, some platform may
>> not support all events or all ISA extensions.
>>
>> The commandline option allows user to disable particular test if they
>> want to.
>>
>> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   .../selftests/kvm/riscv/sbi_pmu_test.c        | 77 ++++++++++++++++---
>>   1 file changed, 68 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> index 0fd9b76ae838..57025b07a403 100644
>> --- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> +++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
>> @@ -33,6 +33,16 @@ static unsigned long counter_mask_available;
>>   
>>   static bool illegal_handler_invoked;
>>   
>> +enum sbi_pmu_test_id {
>> +	SBI_PMU_TEST_BASIC = 0,
>> +	SBI_PMU_TEST_EVENTS,
>> +	SBI_PMU_TEST_SNAPSHOT,
>> +	SBI_PMU_TEST_OVERFLOW,
>> +	SBI_PMU_TEST_MAX,
>> +};
>> +
>> +static int disabled_test_id = SBI_PMU_TEST_MAX;
> 
> I think we should allow specifying '-d' multiple times in case a user
> wants to disable more than one type of test. So we should set a bit
> in this variable instead of assigning it. We could also flip it
> around. If the user uses '-e' to enable test type then only type
> will be run, but then we'd probably want to allow multiple '-e'
> too so it doesn't gain anything.
> 

Sure. Added multiple disable option.

>> +
>>   unsigned long pmu_csr_read_num(int csr_num)
>>   {
>>   #define switchcase_csr_read(__csr_num, __val)		{\
>> @@ -608,19 +618,68 @@ static void test_vm_events_overflow(void *guest_code)
>>   	test_vm_destroy(vm);
>>   }
>>   
>> -int main(void)
>> +static void test_print_help(char *name)
>>   {
>> -	test_vm_basic_test(test_pmu_basic_sanity);
>> -	pr_info("SBI PMU basic test : PASS\n");
>> +	pr_info("Usage: %s [-h] [-d <test name>]\n", name);
>> +	pr_info("\t-d: Test to disable. Available tests are 'basic', 'events', 'snapshot', 'overflow'\n");
>> +	pr_info("\t-h: print this help screen\n");
>> +}
>>   
>> -	test_vm_events_test(test_pmu_events);
>> -	pr_info("SBI PMU event verification test : PASS\n");
>> +static bool parse_args(int argc, char *argv[])
>> +{
>> +	int opt;
>> +
>> +	while ((opt = getopt(argc, argv, "hd:")) != -1) {
>> +		switch (opt) {
>> +		case 'd':
>> +			if (!strncmp("basic", optarg, 5))
>> +				disabled_test_id = SBI_PMU_TEST_BASIC;
>> +			else if (!strncmp("events", optarg, 6))
>> +				disabled_test_id = SBI_PMU_TEST_EVENTS;
>> +			else if (!strncmp("snapshot", optarg, 8))
>> +				disabled_test_id = SBI_PMU_TEST_SNAPSHOT;
>> +			else if (!strncmp("overflow", optarg, 8))
>> +				disabled_test_id = SBI_PMU_TEST_OVERFLOW;
>> +			else
>> +				goto done;
>> +			break;
>> +		break;
> 
> Extra 'break'
> 

Fixed. Thanks for catching this.

>> +		case 'h':
>> +		default:
>> +			goto done;
>> +		}
>> +	}
>>   
>> -	test_vm_events_snapshot_test(test_pmu_events_snaphost);
>> -	pr_info("SBI PMU event verification with snapshot test : PASS\n");
>> +	return true;
>> +done:
>> +	test_print_help(argv[0]);
>> +	return false;
>> +}
>>   
>> -	test_vm_events_overflow(test_pmu_events_overflow);
>> -	pr_info("SBI PMU event verification with overflow test : PASS\n");
>> +int main(int argc, char *argv[])
>> +{
>> +	if (!parse_args(argc, argv))
>> +		exit(KSFT_SKIP);
>> +
>> +	if (disabled_test_id != SBI_PMU_TEST_BASIC) {
>> +		test_vm_basic_test(test_pmu_basic_sanity);
>> +		pr_info("SBI PMU basic test : PASS\n");
>> +	}
>> +
>> +	if (disabled_test_id != SBI_PMU_TEST_EVENTS) {
>> +		test_vm_events_test(test_pmu_events);
>> +		pr_info("SBI PMU event verification test : PASS\n");
>> +	}
>> +
>> +	if (disabled_test_id != SBI_PMU_TEST_SNAPSHOT) {
>> +		test_vm_events_snapshot_test(test_pmu_events_snaphost);
>> +		pr_info("SBI PMU event verification with snapshot test : PASS\n");
>> +	}
>> +
>> +	if (disabled_test_id != SBI_PMU_TEST_OVERFLOW) {
>> +		test_vm_events_overflow(test_pmu_events_overflow);
>> +		pr_info("SBI PMU event verification with overflow test : PASS\n");
>> +	}
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.34.1
>>
> 
> Thanks,
> drew
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


