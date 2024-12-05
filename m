Return-Path: <linux-kselftest+bounces-22855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF99E4F37
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 09:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B521881F43
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C971E1CEEAA;
	Thu,  5 Dec 2024 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aV1vdHiN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D168D1CEE90
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385858; cv=none; b=qGysmI4/75Aw9SoOo3hAmeaFHKpm0camG0V2llbJSlMNtRXnFucAdL/vLXpBIVncamQ6MO7x94znyZJWluxwaMDJnDc0oTPlPz9XWNYEMk1N14pgER/0i+3Zf7q+wtssaohLnPyiKsh30CUhm3eOxtOgOygjbdkKXJaAIRHw6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385858; c=relaxed/simple;
	bh=ixraG1CQjXDP5c66O4Asp4V5AnPbWcu64y7+hgfdIE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Doo7dltw2N/fJNCUDoRR3xvWd1PNTrSoZRkntgrPkLYV7aN2wZT3x1JihEdKoyPhqNHtGCsDCGjepAVJ7TkJCXyEIb5OJyxmbbK0XiHqeoybjGwz8lk6tfjRozGJ3dp3u2t1UNZk/t2VXuGxxPyOjqx4QHMBy/c1JMou84B39b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aV1vdHiN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso5866815e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Dec 2024 00:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733385854; x=1733990654; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TnSIHwdu3quqhv+Cz0nE/XBqXLH5eziio57wDL0PsRk=;
        b=aV1vdHiNbLOUpsEA0Wt9mYumIRFgeTxij634eWO1ufidxfpzmjVWGUJC2F/Kk8ADru
         kuhQuwBwpLKHtLMGpI6p0Uolaw2wiyT7ShVfYcP1hOfz2Xoj856DRenjwWbvdHZU7vVe
         u/DKpU7i3BwnXXfdq6Vy3SNXT8Vhn7Q7Nn9+EIx5gBBk+eK4J/AQqoTp6jxIfCUfIbNx
         zuDU0sehRw4M76jFYHstaxrUZfW/utYMkcuZR0k1mLGnSkTJ8MVsHQI58avu/IAFRVXZ
         JAo5SAdfeZ5pktcTgg31HoD/ap2gBHEpSSHkA5q7hcOSiWyXuV2tx8L/R7V1FY7/jFrH
         z7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733385854; x=1733990654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnSIHwdu3quqhv+Cz0nE/XBqXLH5eziio57wDL0PsRk=;
        b=K+FTpv96yuePUl3jeOnqDgHZYV1Me7xYO+Ct1x/X6TRBbbafInqTB3hlUVnIBj5/sP
         CRp81VDViMhaYlliQGFBIxySQatTnl8ZrJPVMYEF6VvB4p1JhQ/WxOGCvs5jx/F58Xyq
         sq98BArNb528CLCA9KzCzmM+lWiilTvt4cAqct0bmY1oEXs6ajAAgwpFKDVcLYL7TgcA
         1NBA0iuvslRIIdbrxQZs4avEP9NWx7NyLLkBWMUZtwZbpWxRM77pz0BlGLvvxiIz1fqr
         932uji+tLBKoF8s4nbuKxZKTDBjNUQeWsidOaGgC8NFfWIniTQ6ljJP6QDhOXRrPhDZP
         9ltw==
X-Forwarded-Encrypted: i=1; AJvYcCWRdBgqgPnWoL+MBEAEOiJu3Flk+CBtr37n38RKQTcR5R3LGJ6AYzjV+W7MflYr0dGCB48/f3oIpJmqRYogos8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydhpu07bj5esRPTg4PZQaHEsdgnyh5DKf4ouiK1oM/6tNrcLzm
	ildFoK4nbhG/iiA9+SMhiykk408dq3m7lkzCFiTwikbcxCqQ/A8swhpjwBhhlHQ=
X-Gm-Gg: ASbGncs+g22b37WLQ9xr97Zxi0N+ljX3Xp6pd7c07IH7i+zWxv5UsOoevNd87xyqA74
	uMTKB7TRr2J7P2izQ9h0C4KVV0h17LVwUYdjFEXToNEISn5dnpw/Z14Q1uDKR2o5XLIM+0lYkzF
	QE/9jHIZMXpLZKUSZmK5suT8e9prJJRsicX4Bu3/G3YpYcrSxQ32r+V0G7scfHCYknYl89Tlv+q
	svRjUDLgQ03IgUvWlp+X0JeQnyNgas4c1+Z6nxOKmtVjk+yPs9VqDWrLvLrBHTi73xwQFQqfOk2
	Lw8=
X-Google-Smtp-Source: AGHT+IHU2VquhTAR/13KfHBqWHIbC3cUWDM716tluhLEd/E2UqZwbVxHTzKrH1IAK5EQfXHSpOQh/g==
X-Received: by 2002:a5d:64e8:0:b0:385:f5c4:b318 with SMTP id ffacd0b85a97d-385fd3ed9e9mr7535160f8f.31.1733385854019;
        Thu, 05 Dec 2024 00:04:14 -0800 (PST)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fc514fcsm1249141f8f.48.2024.12.05.00.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 00:04:13 -0800 (PST)
Date: Thu, 5 Dec 2024 09:04:12 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v2] riscv: selftests: Fix warnings pointer masking test
Message-ID: <20241205-45c00adab2636bf26ce05f70@orel>
References: <20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com>

On Wed, Dec 04, 2024 at 06:57:10PM -0800, Charlie Jenkins wrote:
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
> Changes in v2:
> - I had ret != 2 for testing, I changed it to be ret != 1.
> - Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
> ---
>  tools/testing/selftests/riscv/abi/pointer_masking.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
> index dee41b7ee3e3..229d85ccff50 100644
> --- a/tools/testing/selftests/riscv/abi/pointer_masking.c
> +++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
> @@ -189,6 +189,7 @@ static void test_tagged_addr_abi_sysctl(void)
>  {
>  	char value;
>  	int fd;
> +	int ret;
>  
>  	ksft_print_msg("Testing tagged address ABI sysctl\n");
>  
> @@ -200,14 +201,24 @@ static void test_tagged_addr_abi_sysctl(void)
>  	}
>  
>  	value = '1';
> -	pwrite(fd, &value, 1, 0);
> +	ret = pwrite(fd, &value, 1, 0);
> +	if (ret != 1) {
> +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
> +		return;
> +	}
> +
>  	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
>  			 "sysctl disabled\n");
>  
>  	value = '0';
> -	pwrite(fd, &value, 1, 0);
> -	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
> -			 "sysctl enabled\n");
> +	ret = pwrite(fd, &value, 1, 0);
> +	if (ret != 1) {
> +		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
> +		return;
> +	}

Could make a wrapper function for pwrite() to avoid duplicating the ret
value check.

> +
> +	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> +			 "sysctl disabled\n");

Why is this changed from expecting 0 for the return and being the
"sysctrl enabled" test? We still write '0' to tagged_addr_disabled here.

>  
>  	set_tagged_addr_ctrl(0, false);
>  
> 
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
> -- 
> - Charlie
>

Not part of this patch, but now that I looked at
test_tagged_addr_abi_sysctl() I see that
ksft_test_result_skip() is duplicated.

Thanks,
drew

> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

