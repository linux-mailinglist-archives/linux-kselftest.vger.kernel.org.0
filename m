Return-Path: <linux-kselftest+bounces-22861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ED29E537C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 12:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B430128249A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056AE1DDC16;
	Thu,  5 Dec 2024 11:15:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463161DF73C;
	Thu,  5 Dec 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397324; cv=none; b=pAEwx4FNFjD7GdWTM/3OZO+Go/e9i9E0WHWKc54Tv5oXhvtf5k6AT3knUWu+0bx3uA4wlShLg58w+p7a/8p313EYv33cTssa0TNpS1rqTHunxhDO7+pquXRyeG0W8pB592DX2iTAHx6aKwsVscMNWY4sTs+0T5rI9TWX3s9T5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397324; c=relaxed/simple;
	bh=+FUIs1dS99YtogPXZFeKo+hgoWg7ip7CinhqcEF1Ee4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8fi3vtBxzCN4V5/Be3xkuEysb9B45M4Ed+rEheMy56SpTAvp14LvGQIu6GGqqXJncDkEqgf/vijDb1KU9i25c0otBw9MY6EnyBCnd1nUZvKD8y5cJ7lKrdIuqcAkEoCMvp23yKCuZOSBP+45YDtjZt4cxRVxmB/eoo9TkLI/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29852FF80C;
	Thu,  5 Dec 2024 11:15:16 +0000 (UTC)
Message-ID: <14125726-bb00-4de4-87f6-6655b0ffae58@ghiti.fr>
Date: Thu, 5 Dec 2024 12:15:16 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: selftests: Fix warnings pointer masking test
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Samuel Holland <samuel.holland@sifive.com>, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@rivosinc.com>
References: <20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com>
 <20241205-45c00adab2636bf26ce05f70@orel>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241205-45c00adab2636bf26ce05f70@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Drew,

On 05/12/2024 09:04, Andrew Jones wrote:
> On Wed, Dec 04, 2024 at 06:57:10PM -0800, Charlie Jenkins wrote:
>> When compiling the pointer masking tests with -Wall this warning
>> is present:
>>
>> pointer_masking.c: In function ‘test_tagged_addr_abi_sysctl’:
>> pointer_masking.c:203:9: warning: ignoring return value of ‘pwrite’
>> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>>    203 |         pwrite(fd, &value, 1, 0); |
>>        ^~~~~~~~~~~~~~~~~~~~~~~~ pointer_masking.c:208:9: warning:
>> ignoring return value of ‘pwrite’ declared with attribute
>> ‘warn_unused_result’ [-Wunused-result]
>>    208 |         pwrite(fd, &value, 1, 0);
>>
>> I came across this on riscv64-linux-gnu-gcc (Ubuntu
>> 11.4.0-1ubuntu1~22.04).
>>
>> Fix this by checking that the number of bytes written equal the expected
>> number of bytes written.
>>
>> Fixes: 7470b5afd150 ("riscv: selftests: Add a pointer masking test")
>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> ---
>> Changes in v2:
>> - I had ret != 2 for testing, I changed it to be ret != 1.
>> - Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
>> ---
>>   tools/testing/selftests/riscv/abi/pointer_masking.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
>> index dee41b7ee3e3..229d85ccff50 100644
>> --- a/tools/testing/selftests/riscv/abi/pointer_masking.c
>> +++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
>> @@ -189,6 +189,7 @@ static void test_tagged_addr_abi_sysctl(void)
>>   {
>>   	char value;
>>   	int fd;
>> +	int ret;
>>   
>>   	ksft_print_msg("Testing tagged address ABI sysctl\n");
>>   
>> @@ -200,14 +201,24 @@ static void test_tagged_addr_abi_sysctl(void)
>>   	}
>>   
>>   	value = '1';
>> -	pwrite(fd, &value, 1, 0);
>> +	ret = pwrite(fd, &value, 1, 0);
>> +	if (ret != 1) {
>> +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
>> +		return;
>> +	}
>> +
>>   	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
>>   			 "sysctl disabled\n");
>>   
>>   	value = '0';
>> -	pwrite(fd, &value, 1, 0);
>> -	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
>> -			 "sysctl enabled\n");
>> +	ret = pwrite(fd, &value, 1, 0);
>> +	if (ret != 1) {
>> +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
>> +		return;
>> +	}
> Could make a wrapper function for pwrite() to avoid duplicating the ret
> value check.
>
>> +
>> +	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
>> +			 "sysctl disabled\n");
> Why is this changed from expecting 0 for the return and being the
> "sysctrl enabled" test? We still write '0' to tagged_addr_disabled here.
>
>>   
>>   	set_tagged_addr_ctrl(0, false);
>>   
>>
>> ---
>> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
>> change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
>> -- 
>> - Charlie
>>
> Not part of this patch, but now that I looked at
> test_tagged_addr_abi_sysctl() I see that
> ksft_test_result_skip() is duplicated.
>
> Thanks,
> drew


Your mails often end up in my junk folder, am I the only one? Any idea 
what could be wrong?

Thanks,

Alex


>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

