Return-Path: <linux-kselftest+bounces-29607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87941A6CA10
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 13:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EB3880697
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555221A438;
	Sat, 22 Mar 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Irt5RVt3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01FF1FBE9B
	for <linux-kselftest@vger.kernel.org>; Sat, 22 Mar 2025 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742645649; cv=none; b=oDsN1/i1e/J/ZDHOfQKGmB7QPAWtYrXml6Zw5Slm1BIarCZd41Q/2QYZI20tGb8sFgrJCS677J3MrCjxQTfo04UcvsFV4kie/D5lZ44/WVn4QVULo9ie1/xZxqKJ2GBpG8uccdXrcDRcn6Zc+/DnNAyuxxs0nmKmef5hfx3XSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742645649; c=relaxed/simple;
	bh=iLuUvH+BOjwrqKZjC7j/H8dzxx6q9BF6OuiO0QRhlK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM533RYVMXF3YS68TchcpMTi6Kvvnnal+BlXoFXZuxDf3MGLdx72VQcoooCgX6QxGIN9ZUU6sHV4kD+vdn0btkrnh7P/CwR4MD3xEN3LCoUI6t3AjP/TcKA9JwW3ZGT3Ra8VxLIYZpcwkpGADECyzQpl+kTcdUGer3TJ1QPgIPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Irt5RVt3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso1809111f8f.2
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Mar 2025 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742645646; x=1743250446; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HWiG+xsp/K3sKHDmBr99lwm1kmwvHTycl73xMSShxhA=;
        b=Irt5RVt3Wg/+34xFRaCi1zdm4799Ag/5EWaD49kooVaaZOCCdIbT+zbJpRatn7Tphf
         MZoN+bwlHa9uWHos9I1dNly7Kxe7EqNahC0i0kZpsT87e4qOza9tDCPRU5FhcWZjQF6B
         ooYGxcauvRK5LJ3chskl2JPjBGuiyPBbAJ0tbWHN59aCviaTwhMabFqXiPnJSvafKBNB
         Mnib8EQUQbOvZUrWin59M6/hgRsU8In8eVeGiYc53vIsdsxCXmQALPAk3atyl7nN2mW7
         4Vx4TWZpX4Ik9F+mj0POIbHProsebxIX7ABssC6klu5bX8dpZ9zy5maGf5SwoTW1eTnM
         nYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742645646; x=1743250446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWiG+xsp/K3sKHDmBr99lwm1kmwvHTycl73xMSShxhA=;
        b=Z8/SYBE/WAETYpDngzvNvoI+HWMK1bvOkSjadbaPCvx42i5k8JN90al7fR38kUcYIO
         ViqcYVC3oWSMhWzxA7GuA1svoUCMvKDZe74Knbo+BOaIavmAocOzi4sSRSft/wNzP3OD
         w70XAmhQuUrqft473JLaorPwah11GayHW/+losh9TrH+GXS/ibuI5JifZwD7BuoSva4e
         GTkhXmlwExiyfSxXIIZaRkVEiG4CIxbj8ba3nGse0u961mgy+uHXdYchJTdqMfw4xxL6
         zREKnH0VLIoYHVR/n9DjKrmB+J5Qff4GcFh0Vu4DveDnefua8fNCu82KKVWDVH0SndIt
         YXLg==
X-Forwarded-Encrypted: i=1; AJvYcCVSQAp54OzIJibyumw4GwQCn+Rax6Ypy5mPRxmIz2GdzIl7UGvubqw60qCqpadSaY/b1UcLPvHPiuxqRf2nymM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXCbu0agMEYUFebmCv3afFILnbw+TE8mquUESAXVfv++HNHrk
	M69fKsF3fwc5cvB8/JGmTf1PlUf+fqvf00GO04PJDvxvlSEPTwjsy1rkdwVPhWU=
X-Gm-Gg: ASbGncvaCvOU8aP0JUzc49Y//mWz5KG1Hgurmh1f7s9JZLAVFQ7wsVuIA0Tp0i/BeXr
	hmHufGKp1rIRHgT6e+p3cNINZBUtlW1MrIQX3wlwNHql1uWNoq1KX0Fc5QdaaVbEKdFSldHYVn0
	LntKiLMtnGbv9wsgOcGO9ZYHGM8U7UlsltTrQng99nHDnU8VBOvovEiwDKpVlEGK0yA2cwlz1Jt
	QsjZTGeG2D47xCxszLz2hjJ39lLsPOv+L5i7LTVo6MaNexcshsx6oQPQaFI0hKazc1qKBCHQ6jS
	1+eUW2k8CmrfiWYEQX9JxhOTgpPwHPgfVYmVnIMbkoE4/vOKk8yCegYlzjFOkdSxEcbgN0pzCQ=
	=
X-Google-Smtp-Source: AGHT+IHDpqohOy/JFZMqFxMBBhwIE63mmqiaNSOUqHyk1TFZEA2JJgoaEQil96e3l0fdWRwlkr8L7g==
X-Received: by 2002:a05:6000:1fa6:b0:391:34:4fa9 with SMTP id ffacd0b85a97d-3997f899fafmr5563180f8f.0.1742645645619;
        Sat, 22 Mar 2025 05:14:05 -0700 (PDT)
Received: from localhost (cst2-173-28.cust.vodafone.cz. [31.30.173.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdb0669sm54992695e9.34.2025.03.22.05.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 05:14:05 -0700 (PDT)
Date: Sat, 22 Mar 2025 13:14:03 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v4 04/18] riscv: sbi: add SBI FWFT extension calls
Message-ID: <20250322-62ad16eaf41abd98170fa6bb@orel>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
 <20250317170625.1142870-5-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317170625.1142870-5-cleger@rivosinc.com>

On Mon, Mar 17, 2025 at 06:06:10PM +0100, Clément Léger wrote:
> Add FWFT extension calls. This will be ratified in SBI V3.0 hence, it is
> provided as a separate commit that can be left out if needed.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/kernel/sbi.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index d41a5642be24..54d9ceb7b723 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -299,6 +299,8 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>  	return 0;
>  }
>  
> +static bool sbi_fwft_supported;
> +
>  /**
>   * sbi_fwft_get() - Get a feature for the local hart
>   * @feature: The feature ID to be set
> @@ -308,7 +310,15 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>   */
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

We're missing the

 if (!ret)
    *value = ret.value;

part.

> +
> +	return sbi_err_map_linux_errno(ret.error);
>  }
>  
>  /**
> @@ -321,7 +331,15 @@ int sbi_fwft_get(u32 feature, unsigned long *value)
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
>  }
>  
>  struct fwft_set_req {
> @@ -360,6 +378,9 @@ int sbi_fwft_local_set_cpumask(const cpumask_t *mask, u32 feature,
>  		.error = ATOMIC_INIT(0),
>  	};
>  
> +	if (!sbi_fwft_supported)
> +		return -EOPNOTSUPP;
> +
>  	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
>  		return -EINVAL;
>  
> @@ -691,6 +712,11 @@ void __init sbi_init(void)
>  			pr_info("SBI DBCN extension detected\n");
>  			sbi_debug_console_available = true;
>  		}
> +		if ((sbi_spec_version >= sbi_mk_version(3, 0)) &&
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

