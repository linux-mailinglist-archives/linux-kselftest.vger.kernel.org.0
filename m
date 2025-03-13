Return-Path: <linux-kselftest+bounces-28944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D51A6A5F4C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 13:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D997E19C144E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 12:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313CF2673B3;
	Thu, 13 Mar 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="o/GrbqLC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B407267381
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869861; cv=none; b=VwVc4ivuXOiEkEt690cqVq1/+3b5iEdDwXGaWAHePdRiZrZeOSonoPU/e2nwKyLtNTrpr/2PA4FPJsB6xx61M+RwWLPD8wamFyQ7AClqffhmjohHJ+wV/cP/VR8srtbeXhOLJo7l42ZHBntW7b3dZKuLKR8To49MKXwUUCh47p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869861; c=relaxed/simple;
	bh=EleUDN0p7TORHE0wSEwSE0kj+mfdR9PO/rSWsPpYYTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C931trAEHRiUWgePGEs8EHqTC3nb1/9wMHJ8sa35D0s1Bjz3DN1zO+eZV5EqDurMjzvB8Yy3b/d01gqCYXjmbJ3BxyINCBLhep12+oBwIpEiYLlhS1nWLYWEbG4/UHi36nmmSHbpUFv/GPhSpKjPBunWZ0Wo0Tew7Z8ZQXm3OSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=o/GrbqLC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0782d787so8214175e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741869857; x=1742474657; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p4eBilR3cQKKkUL6iTV1U2gPm+aqkc/I2/ErCrbp51A=;
        b=o/GrbqLCeyyu8Cw/4q1t9rjSCjvoqeKges7sjFAbL8xsEX4XHQpHVCLphDjin3B9OI
         bzH0u6lO2okzsgxF40lvXb5ECkMBJO6/cCjV6DKWv6Kglw7bDGRuvSQCrUntcbN9VjSS
         nQH0avWE+dP1UHHjTjRQ5e4RlCeU4leL0UL107u6LhJYTBUi7fey8r6o3xMEVgwBW+EB
         KFjWy39uxnnNuTrhFMFPiOvmuCqxhDcbXQ9U0Y1+4lHLBJ4+IX6f47JFGM0jPYQOYCiy
         0VBR2fo1zX4/RvWsoHbsxtYsWV8x+Ja7FTK46XSHdb4t66myUDN/WnJX6+2lVUWsnuei
         WYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741869857; x=1742474657;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4eBilR3cQKKkUL6iTV1U2gPm+aqkc/I2/ErCrbp51A=;
        b=SjWC00Tvg9E67oOdNCKB9EDVupslK9w05COfSwzh6+gap0fyKYWNtMMz39y0IV1Pe3
         95hOyScRk3t1FA8HcdApOLg3UZO8NkeKY2So5gRtZJ8Mi6ES3bq47YOVYGmPigret2cr
         ZEkV5BP58x55Z8Gz9Et9KcBucV7sriQo8VIgnlKuI0ARFLzBR10vcUqvIoLUuU/wSYHP
         ozOGtTDneQASMtB1CLidTudXQ2m5Rx/TWaOxXMzuqQBWJsAJ3Hu0qPdOAD65kt64aGD7
         ucRWER5vccwMp9ifd4oIC9V1rnJt9IsiWnJEdM2y9hJzy4LtJit5TsSYiILQ/xpiTfgu
         CX3w==
X-Forwarded-Encrypted: i=1; AJvYcCVwi0G1kNQiI8ILpnzOj9x/P+l0EVbF+9zUtdzHcsE86CNKrrx/9EB9GSXq2MSNgrRzQ94TiVByc0Qs3gqNBZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzGYBiciTY9r8br8R24XznClFULk7iODnV6OLN1AdTPPP05WO4
	mwcLVD7mngO39ulVF+fYFgzJy2/cAOprqIpTt/wvM+b/H9FcG81Q65V/nweefZ0=
X-Gm-Gg: ASbGncuNoKVDoqWy0KjQbDyPp9nxj1B3R7dj0O/m78YNs+FZwog2Hq8qYp6Aih2aPi1
	vJRvxKl8R4z7QNWiqBGhtRm4j4D9fZ1e5tSONssgjDALohHlSyeMqhEvWcICsa6vKqEsDOSgAjl
	ygHvaDasmadTp5aY7odopDDbK8nRABUiL3NktZKtovuO0nMEBjORPzabMroHNUNksKwlFJi7rGg
	Zjc5x5V9iecPw1c1VZsOrsbDzMpzE6surtc2T5ocXtFqJAybz42JrYCJyIQhNeLA54pg+VhYPfN
	aIV/9haV5QmDRc1o81B50sCV5mvuZX53BjnFclPVErs=
X-Google-Smtp-Source: AGHT+IEVKvciONpN7IaLFK/qsTCvmNWqORyhjjKaAjaSuACjOZk+fDyP3VpTM/ig5PwqolpsjOd7kg==
X-Received: by 2002:a05:6000:1a87:b0:391:1923:5a91 with SMTP id ffacd0b85a97d-39132dc4395mr17992640f8f.55.1741869857406;
        Thu, 13 Mar 2025 05:44:17 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6e87sm2097439f8f.32.2025.03.13.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:44:16 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:44:16 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v3 03/17] riscv: sbi: add SBI FWFT extension calls
Message-ID: <20250313-ce439653d16b484dba6a8d3e@orel>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-4-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310151229.2365992-4-cleger@rivosinc.com>

On Mon, Mar 10, 2025 at 04:12:10PM +0100, Clément Léger wrote:
> Add FWFT extension calls. This will be ratified in SBI V3.0 hence, it is
> provided as a separate commit that can be left out if needed.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/kernel/sbi.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 256910db1307..af8e2199e32d 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -299,9 +299,19 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>  	return 0;
>  }
>  
> +static bool sbi_fwft_supported;
> +
>  int sbi_fwft_get(u32 feature, unsigned long *value)
>  {
> -	return -EOPNOTSUPP;
> +	struct sbiret ret;
> +
> +	if (!sbi_fwft_supported)
> +		return -EOPNOTSUPP;
> +
> +	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_GET,
> +			feature, 0, 0, 0, 0, 0);
> +
> +	return sbi_err_map_linux_errno(ret.error);
>  }
>  
>  /**
> @@ -314,7 +324,15 @@ int sbi_fwft_get(u32 feature, unsigned long *value)
>   */
>  int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
>  {
> -	return -EOPNOTSUPP;
> +	struct sbiret ret;
> +
> +	if (!sbi_fwft_supported)
> +		return -EOPNOTSUPP;
> +
> +	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_SET,
> +			feature, value, flags, 0, 0, 0);
> +
> +	return sbi_err_map_linux_errno(ret.error);

sbi_err_map_linux_errno() doesn't know about SBI_ERR_DENIED_LOCKED.

>  }
>  
>  struct fwft_set_req {
> @@ -389,6 +407,9 @@ static int sbi_fwft_feature_local_set(u32 feature, unsigned long value,
>  int sbi_fwft_all_cpus_set(u32 feature, unsigned long value, unsigned long flags,
>  			  bool revert_on_fail)
>  {
> +	if (!sbi_fwft_supported)
> +		return -EOPNOTSUPP;
> +
>  	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
>  		return sbi_fwft_set(feature, value, flags);
>  
> @@ -719,6 +740,11 @@ void __init sbi_init(void)
>  			pr_info("SBI DBCN extension detected\n");
>  			sbi_debug_console_available = true;
>  		}
> +		if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&

Should check sbi_mk_version(3, 0)

> +		    (sbi_probe_extension(SBI_EXT_FWFT) > 0)) {
> +			pr_info("SBI FWFT extension detected\n");
> +			sbi_fwft_supported = true;
> +		}
>  	} else {
>  		__sbi_set_timer = __sbi_set_timer_v01;
>  		__sbi_send_ipi	= __sbi_send_ipi_v01;
> -- 
> 2.47.2
>

Thanks,
drew

