Return-Path: <linux-kselftest+bounces-23054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50B9E9B8F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 17:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBD91886AB2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72208148316;
	Mon,  9 Dec 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bVkN6oLN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D8148FF5
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761533; cv=none; b=QQTF32W2QyzQWs6RnYnrrgUfAAYvCDVxC0GQrhxjbMmarujTPkAtKJtIpLy/JQoDkUB7PDFaOnTiraznSfUm46YT1A4LKgcfNWBXm8rmrxblzhSom6kcHZYLU+280zhU7QDdY2VyuVSZ+BoF8r2MIIRr4GmebyWbGs0ZtWZ9irI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761533; c=relaxed/simple;
	bh=fM5PGHA8vi65zWnX1BTN1MEY/EibjwplQVAS2tIjGfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIx3fpOr7E42ujchDIFB5IvanqWhk3qcQonRDhLXUgQTxvFDCmpSmK2cFeu0I8vnjn1f3ppP+1fl2dOyMz4k/8jQVwA1b91l/LJM9SH5V9ZCvsvOZZsxHB8cXUe8b7Ey+sX1hlx0IfWPx71DQ3ES2urmc/MWkGQKXZe8z43XSf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bVkN6oLN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382610c7116so2351849f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 08:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733761530; x=1734366330; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2pxOWI3xrkwAHNRcOrURto35zEibdpN2tF3/Hg076U=;
        b=bVkN6oLNjP2L8gqd88coYfxJ4zP7c0V/XoyyCqllo/Sf4TT/A/XjSXg+Bkj5tv0pDT
         A5YowKjBWmEpJAVaNi+H/NlV/rUCKfwTcg7fKk4zbA+a1UCNeia8VUwu9bljsYJlpI0O
         +qZOY7OLZrJ/5w8ANygij3LrV/Q22Oz2SderFXCgXChoGTTEPcgXHe6T8NifTD5xj+Ws
         b0h/Ekj6wBjscI03icY/qhqiEe6Q5dER3OU5ETmKAxC6BGmjEB+62sODaXEEx55jNWRO
         ZS/sbaAH+f3QfivLHshNNNDj/YAZh46rCk7p6xQn2qpYxGyyIoxbxeUa5XGfOcxz1UmO
         V9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761530; x=1734366330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2pxOWI3xrkwAHNRcOrURto35zEibdpN2tF3/Hg076U=;
        b=Bv2/U2wtIUit0e/1n9h/L34gDGI+N7qexNaj5Qg29yGLFvMnQs5UuwO+860QrMeyVm
         JUXQcU08m8GAP6mijz5ciccSnWOm8MaxDyTPNbtF6Ci9tbMIjzDL1iSYNvrRsgIOdpEM
         yva9aL86eyWu215fhrNomSXDSAbwf1Yh1dWs6V3aYgVhieTnbawRX8ToIWK8d1wJ5t2m
         EPfhpXSWCb2S6Ulu/GpvqhFbHSsV81/udaTWhWlEdcDOZRykdMcLk4wMmtfJ4iaKQOOQ
         N51OkFiXmg7jTmxH6i208NyhcOkKFyslFcKzhjSKOd7rxoZNI6V33Ge5xv6KSXswkNWH
         Ulcg==
X-Forwarded-Encrypted: i=1; AJvYcCXv9liWpQQhg2MB7cw85FpuGtUquw96NZuU8+4eiCD3okjXOVtui45iMmPuLrnpAu/1SlRE9WjPx0eWI9gEKKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJt7+isl0DkSkmVqCc40otYnnEDz8udAeiqkgL/oiErLy8mMHK
	2FrxxGf+QlY0DdHq30GZF88b89YEPIZNd5uI7kWzlQ/8AlKoS6B42FPQFQ9XT08=
X-Gm-Gg: ASbGnct5o5bTYL3xMe03v6PkEwXSBOxJZoUpMiKhDXQ73B7RVlp/188p/KMGJ96oUUg
	vztIgc7WlzD5SiUJWUs5VqAY5f/ls87kJvscHNIF8RvrX28ijJ+6bG7ToLk0DfWUv/HUw+999tG
	OLevLsUpfk8Vr1kE1NfmVDjn5uIHKagioPcUceJ6At+mvbHdIBiEd3IMfP6Cxfp9ZOtdjOwFBAu
	wP6lUybA3Y2bnODoWkhWRFBamvozF+YXWx/I5L8YB33U7kTigr2nV+zWQshuaJZwNWpkq5qLuUY
	DlEZrqwEAsuB
X-Google-Smtp-Source: AGHT+IG0YRY/AI+hYtU/jY/moJvUMH8alDa4Bfs7WysfLm7PTeWvvswR1hSEHB/r4Jz0ywy3oKLk4w==
X-Received: by 2002:a5d:64e6:0:b0:385:f220:f798 with SMTP id ffacd0b85a97d-386453d269dmr814304f8f.6.1733761529729;
        Mon, 09 Dec 2024 08:25:29 -0800 (PST)
Received: from localhost (dialin-242125.rol.raiffeisen.net. [195.254.242.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219096d8sm13826119f8f.78.2024.12.09.08.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 08:25:29 -0800 (PST)
Date: Mon, 9 Dec 2024 17:25:28 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v5] riscv: selftests: Fix warnings pointer masking test
Message-ID: <20241209-393e756fd92bdfe890b1d4ae@orel>
References: <20241206-fix_warnings_pointer_masking_tests-v5-1-ed566c2f27e8@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206-fix_warnings_pointer_masking_tests-v5-1-ed566c2f27e8@rivosinc.com>

On Fri, Dec 06, 2024 at 09:52:11AM -0800, Charlie Jenkins wrote:
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

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

