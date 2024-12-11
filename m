Return-Path: <linux-kselftest+bounces-23148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0139EC468
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 06:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AFB1889EC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 05:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9311C07CF;
	Wed, 11 Dec 2024 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AoJl7g3P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65234C97
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733895990; cv=none; b=lZUk4oTGiRwWYZtVU6/GCuTOe4sVSe20mx7EmN5uSlPv7cQzlBJWbcSzv0JQbCO3YtxEtDmbFtxuYyk8nOxYbQQACh7jfliVJIWIMxgEJzh9cCrNa1DuObFPzY9oJiJ3e/0+7f94wcml5V8tSe1tWk1kc6cy9qigwNObz76G0QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733895990; c=relaxed/simple;
	bh=OCWFqx9DLCaDYpgULX15aNbo0sDqDgUlQ85eDq9B0EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HA+DGV7NPbP5wWdoS6k3CsipRgX3rhmKXOJPRpHPHI4+N6v5haeCAdhcZ4WA1w19aF21SxjW4HlkrShAzdvfVPrKWtf90yROOSUJUE2+33amoVEZy0qoWiLBoMEm6rzqwM45BETU0g0H/YTKx1XzFQSmjN+jtoPW6kM3E0NJ+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AoJl7g3P; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-844c5f31d48so82005639f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 21:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1733895987; x=1734500787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5oMUqHh+nk9B5mZBiaJ0vvBxq45cqgYB3xD0ERWeFs=;
        b=AoJl7g3PLCVoLeJIolnVDEbHzgOEMA5LQvlPsDzSrf6aw1djppWxGSrADIY2CLOsC3
         6rINacm1CnCeVHkpCdujCBNh4EHbSG0T2d7B6pToA9W2g8GJEsLgevik4dEAyHgG+pV7
         F+Qv3Bfv0u3X15Zi3usdJA8ULQIh4zOzOBoCEBo6m8GtBKeLuMnw5SKJQuIp2FpY6HrQ
         6MrSj+aDa3hDrVqS5n1Myw6Maea7Si8F0BVKbxduoi57EytHAnqAQ7F9eIh0mpeE49bV
         BqVsC2ynZptpuCGO+oSrUpAmm6K5kEzwMIGDu3mxc0U9QBhahR88N6Z5x0YZndUVCSgl
         y6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733895987; x=1734500787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5oMUqHh+nk9B5mZBiaJ0vvBxq45cqgYB3xD0ERWeFs=;
        b=CSbw43wo+tnUgxDiyUoXGbzE/wWHOIB1UPivcaBBiJBH/U5BjGt3qzUEVGRBhLoHtb
         IFuJk17Ndpjqng2ASCmitq2rAGv9ePTMaLzPJaQ231tBf9gRcSEpwTSJHba+WHbQ1607
         9h9cn5msE9OPODyJwHVyiDefJReHnx34Y0Y+QyEXaNLKDD2ePwnsOKF/ot0/DZifDwXc
         wa/muEvdKPtvAh23LCpfkXgKaibeF1WSfT2OYi5B2UnNpoK1FOt4qLOf2zyym2lFpA/Z
         tnEuaJia3hf/d49CFMzdCzc/8gzsSV33cHCCPtfuNZHt6pPPaSvOHidNIGBrIQ7Rtx/w
         5e1w==
X-Gm-Message-State: AOJu0YyLRzwP982c584C1Aq+SpoiXQ5ZRaNYPfICKRREX1cCFwKqMQxb
	ZWPgdjleyhMp60wESmF1U/0SjQ5ZsQJ6qgnDPVVZGN14nLu9JEXJgJsfWIM2bUY=
X-Gm-Gg: ASbGncsUJmXbZ10rF8gjsFFeuvtfqh9WW77kKIblWCyWpaoY0Bt/hUHhI650v3vo6Y8
	Fs5T56kmN0xdluql7VG0cfXWP9NwzQz2cjCi/Loz9oNxuTJurSY2jsVWn9raEVurcW+hAUatcxx
	IwBo4d+t6dtFZ1JZOeQwGcaSr43RvnHmPDGZUHkwPd2SdSnFPe/5uJysBKSzufHMWwmaLjvNQIN
	A/tILc04msdCAW1fQuCCo2NLdgiCM/dfxmMtDPLc8qq+CkCfMXKQEk4g+DbOejEO+UtN5SXvWDk
	ASQ=
X-Google-Smtp-Source: AGHT+IEmmvtcV1rwmGFlOaV5k7IoW8oaRRGsYBd4+FUMKqnq0edFVLxZ/CDUJaoapBekOklZskqkiA==
X-Received: by 2002:a05:6e02:3f87:b0:3ab:1b7a:5932 with SMTP id e9e14a558f8ab-3ab1b7a5b26mr1105265ab.18.1733895986822;
        Tue, 10 Dec 2024 21:46:26 -0800 (PST)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2c8a82832sm1075829173.81.2024.12.10.21.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 21:46:26 -0800 (PST)
Message-ID: <41025b15-2f66-481b-a2da-dbf86e2bfc10@sifive.com>
Date: Tue, 10 Dec 2024 23:46:24 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] riscv: selftests: Fix warnings pointer masking test
To: Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
 Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
References: <20241206-fix_warnings_pointer_masking_tests-v5-1-ed566c2f27e8@rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20241206-fix_warnings_pointer_masking_tests-v5-1-ed566c2f27e8@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Charlie,

On 2024-12-06 11:52 AM, Charlie Jenkins wrote:
> When compiling the pointer masking tests with -Wall this warning
> is present:
> 
> pointer_masking.c: In function ‘test_tagged_addr_abi_sysctl’:
> pointer_masking.c:203:9: warning: ignoring return value of ‘pwrite’
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   203 |         pwrite(fd, &value, 1, 0); |
>       ^~~~~~~~~~~~~~~~~~~~~~~~ pointer_masking.c:208:9: warning:
> ignoring return value of ‘pwrite’ declared with attribute
> ‘warn_unused_result’ [-Wunused-result]
>   208 |         pwrite(fd, &value, 1, 0);
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
> Changes in v5:
> - No longer skip second pwrite if first one fails
> - Use wrapper function instead of goto (Drew)
> - Link to v4: https://lore.kernel.org/r/20241205-fix_warnings_pointer_masking_tests-v4-1-0c77eb725486@rivosinc.com
> 
> Changes in v4:
> - Skip sysctl_enabled test if first pwrite failed
> - Link to v3: https://lore.kernel.org/r/20241205-fix_warnings_pointer_masking_tests-v3-1-5c28b0f9640d@rivosinc.com
> 
> Changes in v3:
> - Fix sysctl enabled test case (Drew/Alex)
> - Move pwrite err condition into goto (Drew)
> - Link to v2: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com
> 
> Changes in v2:
> - I had ret != 2 for testing, I changed it to be ret != 1.
> - Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
> ---
>  .../testing/selftests/riscv/abi/pointer_masking.c  | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
> index dee41b7ee3e3..50c4d1bc7570 100644
> --- a/tools/testing/selftests/riscv/abi/pointer_masking.c
> +++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
> @@ -185,8 +185,20 @@ static void test_fork_exec(void)
>  	}
>  }
>  
> +static bool pwrite_wrapper(int fd, void *buf, size_t count, const char *msg)
> +{
> +	int ret = pwrite(fd, buf, count, 0);
> +
> +	if (ret != count) {
> +		ksft_perror(msg);
> +		return false;
> +	}
> +	return true;
> +}
> +
>  static void test_tagged_addr_abi_sysctl(void)
>  {
> +	char *err_pwrite_msg = "failed to write to /proc/sys/abi/tagged_addr_disabled\n";
>  	char value;
>  	int fd;
>  
> @@ -200,14 +212,12 @@ static void test_tagged_addr_abi_sysctl(void)
>  	}
>  
>  	value = '1';
> -	pwrite(fd, &value, 1, 0);
> -	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> -			 "sysctl disabled\n");
> +	if (!pwrite_wrapper(fd, &value, 1, "write '1'"))
> +		ksft_test_result_fail(err_pwrite_msg);
>  
>  	value = '0';
> -	pwrite(fd, &value, 1, 0);
> -	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
> -			 "sysctl enabled\n");
> +	if (!pwrite_wrapper(fd, &value, 1, "write '0'"))
> +		ksft_test_result_fail(err_pwrite_msg);

You've removed the ksft_test_result() calls, which contain the actual behavioral
tests (set_tagged_addr_ctrl()), so the test no longer does anything but toggle
the sysctl:

# Testing fork/exec behavior
ok 55 dereference after fork
ok 56 dereference after fork+exec
# Testing tagged address ABI sysctl
# Testing tagged address ABI
ok 57 PMLEN=0 tagged address ABI
ok 58 PMLEN=7 tagged address ABI
ok 59 PMLEN=16 tagged address ABI
# Planned tests != run tests (61 != 59)
# Totals: pass:59 fail:0 xfail:0 xpass:0 skip:0 error:0

It does do the right thing if I `mount --bind /dev/full
/proc/sys/abi/tagged_addr_disabled`:

# Testing fork/exec behavior
ok 55 dereference after fork
ok 56 dereference after fork+exec
# Testing tagged address ABI sysctl
# write '1': No space left on device (28)
not ok 57 failed to write to /proc/sys/abi/tagged_addr_disabled
# write '0': No space left on device (28)
not ok 58 failed to write to /proc/sys/abi/tagged_addr_disabled
# Testing tagged address ABI
ok 59 PMLEN=0 tagged address ABI
ok 60 PMLEN=7 tagged address ABI
ok 61 PMLEN=16 tagged address ABI
# Totals: pass:59 fail:2 xfail:0 xpass:0 skip:0 error:0

So I guess the "ksft_test_result(set_tagged_addr_ctrl..." needs to go in the
else case of the pwrite_wrapper() call.

Regards,
Samuel

>  
>  	set_tagged_addr_ctrl(0, false);
>  
> 
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429


