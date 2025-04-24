Return-Path: <linux-kselftest+bounces-31534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FD4A9AB5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 13:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92F05A3DEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F76920A5E1;
	Thu, 24 Apr 2025 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Gy0EJs10"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6C7DA6D
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492795; cv=none; b=SddZB92Xt6fZPhPedbKUhWUv0sqRcxV/+AwYyw+K3l/4hKLeAyIpEUHl/vIvcn2PPCaPVBR2BahXrDH2Ajh6djdkAULMXAglLhecL1a8DhczF7v7vctmG9jocx6S9D52icxA9ksfYIe0bQ38WkpvqatfWu6b9hSgBOlhrxWxmn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492795; c=relaxed/simple;
	bh=6ZbEQkK5v1recDZlp8qUumVPv5BX8yXmX7kuXiecGNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SruDGCrpFQx4Z7RZeJZjtcq6xov7bCnX8ulGKffDdF+CUWtYQXbdiao7Nyb8qfHK3Ruth327gIJDdxPOL+TkAA6YebRg4cOH17sQMf46u+oBB5UPne/leffUik5IChsNdActAh6td9ZBsuOfSgPl7ppId9ospbzA0EHbhqK60+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Gy0EJs10; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so5977205e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 04:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745492792; x=1746097592; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xaFlU49KHj/WqsyzkJFZpLzZkQa35ucQoiXjJp4Ub20=;
        b=Gy0EJs10rMvro03mVTAfkh2uOmSqhv5l6CqSh2herdP8uC3jkqB/pZ6fxqq/fOgXJH
         JhPkfyD2FELWaG9ZoWwKJA2sd/AHWYNuVAQ+4p3ohqdhFu3ODFLIC7rmC4KfngpeCKGh
         dNXtvoA67a+Q80x43HpEKcE13PsxgXybGrHtNFg5gUfaaDC+d9+kdwb+L0A4uAjHD7vO
         RRlW8co/etNkSCy7aDbO7+fXHYLJeglYLHM+Ew0EsRpRIKMJA6n2oBVs2IePUUdpLqP4
         2nUfKo8OmxUUZj7UqiBqjQEK02XBFWuBkWPU/GmuOc0bkZByY2LWSp0fXiYsdcwUOOqH
         lS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745492792; x=1746097592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaFlU49KHj/WqsyzkJFZpLzZkQa35ucQoiXjJp4Ub20=;
        b=adx8x3lVNKuBmJqS/WiVOjxE7/Y3O0F3a47bvM++LR9lpyOCAgiRXw9pDbtckwB8hJ
         BaqIjYQRu8OJC5unWuwM2zCQtZNynCkou51wzcK8cY/EsKjxCLC6ZxKxbnjd/MyOSJ28
         FUe2o9+TJuu8KsW3NjJ4f+Pz5/q9L8ET04Sgtqt7VWFbDOd+IqskuqSfKrpxCaEg/iOt
         l44mzY5GZuXEvKfnkn459dy54J1tTU/aqNxzuODqGSQB3bFxMF5tHQhNrVg9YgBLkoTj
         XS0IVJdqh+8lrEdMSFUqCapqsd39qf6tiVM8UdquHVMMHbMOqvMQfUWANszkJHjuOWOv
         zBTg==
X-Forwarded-Encrypted: i=1; AJvYcCUOmYVCh/+myH4RV99y3IU/F7Vgv5RIaBMV64pd3IiEYy9ydAJQ42CTel2/FJ4qZXdgCYMVCkIONKzBKBUVjUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhkZ2FRovE0WuUNm0sK3cIMnt1mXxgYzDM23DC/rUgW6Asgfs/
	8H3JJ807FWiXUlPmYqcjUdDEbU3b6CtFKuBLyX+X+2o1eT16JcOAuijMQwTNphk=
X-Gm-Gg: ASbGncvbLaqr0YgzSzMP+7RHvpNapZvmFjU9VyH7Tym2X4l3X5frIiVdc/19FqpiX1z
	oTo3+2pBpHJaeY+auPoLHokjjFx7qHgN538SuQLjP5Ki2SJpESd4TWpGINT+njZBHhos6i12Hc/
	JaA9kXL2UH2KJDlY7L2nT1OhlJAEA64ty/9xCMlEDtgYCa5Jzh+xsRpEhM6bb8dStir8BKu56SJ
	lWLdYd7JteDA9FP7/ve2ZPa5+qbC34uM1XYUinp3rFHb7oQ91V/MXC8n287gb977R6Va4dUkGEh
	qVoA3jwCSSYSyYxBCrvg799uWeX6
X-Google-Smtp-Source: AGHT+IGdWaGhxvTRb6GutdDIuLG/aiIZCV4CCAGWlaD0KDkW+nhzZtqNPgORxU7ENnJYG2P45T9aiQ==
X-Received: by 2002:a05:600c:1c93:b0:43c:fded:9654 with SMTP id 5b1f17b1804b1-4409bd32458mr16398415e9.19.1745492791956;
        Thu, 24 Apr 2025 04:06:31 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2a13bdsm16546245e9.9.2025.04.24.04.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 04:06:31 -0700 (PDT)
Date: Thu, 24 Apr 2025 13:06:30 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v5 04/13] riscv: sbi: add SBI FWFT extension calls
Message-ID: <20250424-c0700f89bcd29438d6d8d65c@orel>
References: <20250417122337.547969-1-cleger@rivosinc.com>
 <20250417122337.547969-5-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417122337.547969-5-cleger@rivosinc.com>

On Thu, Apr 17, 2025 at 02:19:51PM +0200, Clément Léger wrote:
> Add FWFT extension calls. This will be ratified in SBI V3.0 hence, it is
> provided as a separate commit that can be left out if needed.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/kernel/sbi.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 379981c2bb21..7b062189b184 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -299,6 +299,8 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>  	return 0;
>  }
>  
> +static bool sbi_fwft_supported;

At some point we may want an SBI extension bitmap, but this is only the
second SBI extension supported boolean that I'm aware of, so I guess we're
still OK for now.

> +
>  /**
>   * sbi_fwft_set() - Set a feature on the local hart
>   * @feature: The feature ID to be set
> @@ -309,7 +311,15 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
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
> @@ -348,6 +358,9 @@ int sbi_fwft_local_set_cpumask(const cpumask_t *mask, u32 feature,
>  		.error = ATOMIC_INIT(0),
>  	};
>  
> +	if (!sbi_fwft_supported)
> +		return -EOPNOTSUPP;
> +
>  	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
>  		return -EINVAL;
>  
> @@ -679,6 +692,11 @@ void __init sbi_init(void)
>  			pr_info("SBI DBCN extension detected\n");
>  			sbi_debug_console_available = true;
>  		}
> +		if ((sbi_spec_version >= sbi_mk_version(3, 0)) &&
> +		    (sbi_probe_extension(SBI_EXT_FWFT) > 0)) {

Unnecessary (), but I see it's consistent with the expressions above.

> +			pr_info("SBI FWFT extension detected\n");
> +			sbi_fwft_supported = true;
> +		}
>  	} else {
>  		__sbi_set_timer = __sbi_set_timer_v01;
>  		__sbi_send_ipi	= __sbi_send_ipi_v01;
> -- 
> 2.49.0
>

Besides the () nit

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

