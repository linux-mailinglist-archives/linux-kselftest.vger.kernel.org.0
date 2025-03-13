Return-Path: <linux-kselftest+bounces-28947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33417A5F507
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 13:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B3F1893010
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D1526770C;
	Thu, 13 Mar 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="APOaxmmg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46F02676CB
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870658; cv=none; b=Zmrc+RQaNCcnMaHfIypniEb9mKoPZHmQvzaDb4XgVhkrxALOgXeKhtSq3pRtDHIqvwsH6FypfzN7SxoaRkLCFWpGT3ASVNuOq1W8gC5ST1obUbmx0qwBj6YrLtNfdV7FGyXqokY+cCnp5Pa/uruuRHrFPz1Z/uEn1WaRWaUKi4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870658; c=relaxed/simple;
	bh=3SJF7mpLxysqOLGs7s+q7f1LccNakiGDFqv7+deqaJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okX+k53kirEOk8JSg5XHbjwC1bX7Wy1I8h0uk23E+YjQW6aTEUT+tgElUQbhwbomhv1jxy1Ljkixpuibs0tprRmoTfTucuLYfZwlvA+3wB7bSrNML14YnXaJlT1IYwRXjf4xxRbud2nKFILAtklRU+y1NFNw+eksohPPVKzrUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=APOaxmmg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3911748893aso559052f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741870654; x=1742475454; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oU2CWGwDlIJhGLUqCxoni4cHhWUsK2iDFsgYYpF/oTQ=;
        b=APOaxmmggK32pxXRV68Rk7ps3GTf785tyvV1NoRdGow8T4TVJgHByJSrANXI4wyqHJ
         HHefvHlSgNUGh5DMal/5KsbjTtJ+XgyfwSk/CKlC50hkaC5pX2Yubu8+c5noE26g7JL+
         YsB7X7S1oDbUEalvVXLbg79kOdbDBCD82zricwFglb3VbUpLTSE/AZ+v2ki8Md/Z5trv
         taCeWZc8/TnH9fqWGL2Nkq26Hrnuog/oVL2lOFiRzNhd0bXILM/PMp+vZ6BFQGqefBgq
         pPng4xVPyagpcbUdhWCmOn1d39cPa2l8KGOOWadD2KTiMq2q4ewFFULdG4CMfGSrScxk
         6W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741870654; x=1742475454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oU2CWGwDlIJhGLUqCxoni4cHhWUsK2iDFsgYYpF/oTQ=;
        b=BYQS8G2GpmYabk6dYvJTdR4Y0u4Wc4QKMAhh8KHSE6wgH5gghZxsG3mAbKFr0VxXBK
         6UTYj93/t5ThhHFeq8eulbMGGHyAyl4gWKGjbPvkSSetkD0lcZeKLMkoaNhGcLjvpYEB
         2I7fulknT/JuBbug4hRqVWEihc2FOQkUiBSPDZ0yaVzujuqmDS9HwTW6FA7vOWmav+H2
         jK2fMLda/Jl+vWC1WU9vkqX3ygRpfGm07GiVAW3s3qKMzMBClMypUo4DDYEjeJyAEvbn
         4M1SbbsOG6Aiui4MBKqvJqobOczC85dVCy8cxjuL2RF+Pe/SrvqEO3xaLkBW90uNMNAx
         Pn/A==
X-Forwarded-Encrypted: i=1; AJvYcCVAM3mReBjLJkEThV6LfVF6N1x8Vhxl6dNMKsUMj5SiUYOHXq4q5fgUFxTfJXJI6jvZA8Qlmm9FG/g10c6uOEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeVjKWGU6otXAyc9EMyGThkq2sAQSa7i0+li10l7959DYmya3
	UFRNHsTJHhbsCnchDd21SJAUbexHQfL+0VmDet3JrIliG9mT+/iOi7QDj/uditE=
X-Gm-Gg: ASbGnctoIa50ug5GjU+p/o0j6sqrYBPeTT5CwiIgxysKGTwNniOAZ2dMKmCFh83Z3mG
	YtJ52Hs2g9GzgziuPz4pWY1ATx+uXcTHS2AYQBeYt33Jp3jL+9BQfvCUiBr8MlO5YYtDiW/Hnf+
	DmrCrgvRPYr2QGcSy5Uh56IceephB05azXDiS9uc6z4MxRfUawJE6DWiUScgU4VTsTDDVQJl9kP
	A9K0GETVlKdvLbb5IRsMC+PXmlKUpVwf4vGCKM5XaYQR+gU3g20oW2Nf2pwVXC0Z74udWs36Uh0
	ErjqDkPaLyzoQagmxEsFtsqLqHD/GHcC
X-Google-Smtp-Source: AGHT+IGM1DblGtxykFocIp33D2K47p5ADdU4DE4GFvOo3U3iDj70FwK79o4wmAKz0GgKu55I89czxg==
X-Received: by 2002:a5d:64ac:0:b0:390:e889:d1cf with SMTP id ffacd0b85a97d-39132dc561cmr20667619f8f.37.1741870654174;
        Thu, 13 Mar 2025 05:57:34 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c2690sm2044096f8f.25.2025.03.13.05.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:57:33 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:57:32 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v3 05/17] riscv: misaligned: use on_each_cpu() for scalar
 misaligned access probing
Message-ID: <20250313-311b94f9bafe73bcd41158a1@orel>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-6-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310151229.2365992-6-cleger@rivosinc.com>

On Mon, Mar 10, 2025 at 04:12:12PM +0100, Clément Léger wrote:
> schedule_on_each_cpu() was used without any good reason while documented
> as very slow. This call was in the boot path, so better use
> on_each_cpu() for scalar misaligned checking. Vector misaligned check
> still needs to use schedule_on_each_cpu() since it requires irqs to be
> enabled but that's less of a problem since this code is ran in a kthread.
> Add a comment to explicit that.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/kernel/traps_misaligned.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 90ac74191357..ffac424faa88 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -616,6 +616,11 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
>  		return false;
>  	}
>  
> +	/*
> +	 * While being documented as very slow, schedule_on_each_cpu() is used
> +	 * since kernel_vector_begin() that is called inside the vector code
> +	 * expects irqs to be enabled or it will panic().

which expects

> +	 */
>  	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
>  
>  	for_each_online_cpu(cpu)
> @@ -636,7 +641,7 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
>  
>  static bool unaligned_ctl __read_mostly;
>  
> -static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
> +static void check_unaligned_access_emulated(void *arg __always_unused)
>  {
>  	int cpu = smp_processor_id();
>  	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
> @@ -677,7 +682,7 @@ bool check_unaligned_access_emulated_all_cpus(void)
>  	 * accesses emulated since tasks requesting such control can run on any
>  	 * CPU.
>  	 */
> -	schedule_on_each_cpu(check_unaligned_access_emulated);
> +	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
>  
>  	for_each_online_cpu(cpu)
>  		if (per_cpu(misaligned_access_speed, cpu)
> -- 
> 2.47.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

