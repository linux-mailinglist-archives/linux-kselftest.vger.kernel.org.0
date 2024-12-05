Return-Path: <linux-kselftest+bounces-22856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A206A9E4F80
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 09:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81984167E14
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 08:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528451B2186;
	Thu,  5 Dec 2024 08:16:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDE1940B1;
	Thu,  5 Dec 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386565; cv=none; b=DZFFmp50dSV+LnwljQEQw7IqNeMkOeYOusdRR0jttZihlEJqAFOCdrP6W2ZYDyA81LmDTrciKSX2RwymkpRbNcQPdZyKWWvpX6r0rPnefNV+25sixN4kJsm5LsggwvJg7GKG+8lHdo4/xMzvSImamAtdoSk1LeYmlnZ6BFe0Hr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386565; c=relaxed/simple;
	bh=aE3NYRNv3Kk2Mhx9uX80BNMos/Wvt8Z5kJNseVrDcIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2vLrhSLLTn0DuU2rjCIBrtTR4WW+bGzunAOfGa8r+88eFNsD799v2mHEfafVgRQS5iP2HjzbeNIkF4jekWnQ0fRcl79E6c7MGpFEC5L7AqLWbV4v0E3Xa2AvOwLmHeVGRBb1Pqj+mGujm6AGicr+1km2YokUe9YuuKzLWILfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id CC5A4C32EA;
	Thu,  5 Dec 2024 08:11:56 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 803C6240002;
	Thu,  5 Dec 2024 08:11:47 +0000 (UTC)
Message-ID: <697a402b-0305-489d-bf4e-aa5e7fa4b2aa@ghiti.fr>
Date: Thu, 5 Dec 2024 09:11:46 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: selftests: Fix warnings pointer masking test
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
References: <20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Charlie,

On 05/12/2024 03:57, Charlie Jenkins wrote:
> When compiling the pointer masking tests with -Wall this warning
> is present:
>
> pointer_masking.c: In function ‘test_tagged_addr_abi_sysctl’:
> pointer_masking.c:203:9: warning: ignoring return value of ‘pwrite’
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>    203 |         pwrite(fd, &value, 1, 0); |
>        ^~~~~~~~~~~~~~~~~~~~~~~~ pointer_masking.c:208:9: warning:
> ignoring return value of ‘pwrite’ declared with attribute
> ‘warn_unused_result’ [-Wunused-result]
>    208 |         pwrite(fd, &value, 1, 0);
>
> I came across this on riscv64-linux-gnu-gcc (Ubuntu
> 11.4.0-1ubuntu1~22.04).
>
> Fix this by checking that the number of bytes written equal the expected
> number of bytes written.
>
> Fixes: 7470b5afd150 ("riscv: selftests: Add a pointer masking test")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v2:
> - I had ret != 2 for testing, I changed it to be ret != 1.
> - Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
> ---
>   tools/testing/selftests/riscv/abi/pointer_masking.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
> index dee41b7ee3e3..229d85ccff50 100644
> --- a/tools/testing/selftests/riscv/abi/pointer_masking.c
> +++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
> @@ -189,6 +189,7 @@ static void test_tagged_addr_abi_sysctl(void)
>   {
>   	char value;
>   	int fd;
> +	int ret;
>   
>   	ksft_print_msg("Testing tagged address ABI sysctl\n");
>   
> @@ -200,14 +201,24 @@ static void test_tagged_addr_abi_sysctl(void)
>   	}
>   
>   	value = '1';
> -	pwrite(fd, &value, 1, 0);
> +	ret = pwrite(fd, &value, 1, 0);
> +	if (ret != 1) {
> +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
> +		return;
> +	}
> +
>   	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
>   			 "sysctl disabled\n");
>   
>   	value = '0';
> -	pwrite(fd, &value, 1, 0);
> -	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
> -			 "sysctl enabled\n");
> +	ret = pwrite(fd, &value, 1, 0);
> +	if (ret != 1) {
> +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
> +		return;
> +	}
> +
> +	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> +			 "sysctl disabled\n");

Why did you change the test from 0 to -EINVAL here?

Thanks,

Alex


>   
>   	set_tagged_addr_ctrl(0, false);
>   
>
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429

