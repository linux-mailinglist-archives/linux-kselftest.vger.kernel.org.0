Return-Path: <linux-kselftest+bounces-7185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBAC898689
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120601F2106C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00D84D30;
	Thu,  4 Apr 2024 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oBqxLggq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8055083CDE
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231743; cv=none; b=S9tL0ys9XsdmGDmySEPLCFjaHndM4bv5ZLYH1szX6wmYL7ZTctz1jbJ+dc4qPYD55n9PpXzNrdZmyHArUHvu1kMCEEsikHg4kFBGq3P2UIb/KMU3q2K6eTQwgqYYgyCME8Yig/cxehIxaKrFByytVWvn7AnIKQX2C9/K3h6JYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231743; c=relaxed/simple;
	bh=cte0IjkEbEgza+ss/nMD9HI6t7MmFsQCgkQHAAdfVDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVmrJ9lg4gjVEuYsXhbJsLpxiJNZfOYSkXqHouYkA2s1kBBVMDHBEA/8mWUBlA+SzLEhRjmlK4c4kraCE2I5ZC2hJkSKYiTnjNKqT2R/Qjx1GJJj5YvvajUHzWrRXu+nOFSOSOYIaCovr4ArHGhVI5Vt6qbZySSkNAf6yTfWY44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oBqxLggq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so1306613a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712231740; x=1712836540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MggdLhtScC0WHbexLHVciQeNa0pa9gvC6PekQ9uXyqA=;
        b=oBqxLggqgMDZSS2fvdRdMwp3lzRR+d5XtfjDiZ5oXytLTFJFHQohnFdRs5hB6+TWdJ
         2wiU2B4qDk8guaxZjJY3cTns4BFBRjbgveHBjSE34hv19CyKrMRbQUkgNZQgDYcjV6FI
         e9RPahmkf2fFvtENAESNDjh71DyWybFPJhzuUZvcQ794xKb/rESwm7UTfElpvLkAfMQr
         vUvWO8dMS/wYK7nX5pnjmw6XJPu7G21WSd78zIMNYz2AqyvNSZFZof2fyG8aNTakJBxj
         jcaSaltHywbEGmiqy5vdjBEgNQTJ8pO/kH+71P1diWWSj9DEfigNoo1yZNHAYEAfJ2aw
         atNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231740; x=1712836540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MggdLhtScC0WHbexLHVciQeNa0pa9gvC6PekQ9uXyqA=;
        b=NodqC096wooRyTNd6HwanCWulMdhZib7C02I4NV5Pq/SKsNDfuHgfAknGND8SC9n8a
         w8DlAcU2vOzccIHhh8lr+mtMebRkTtkdrI7FEeSSPr0LnqtBkB9Yz11/9M1oyUfk3Gob
         hu5sOQA2sX4b1vTSAAYokJ/aBDN4oLdxW8rJdZmYOCE4D7tG9tsTe8mfLynfn5A7s5IN
         cEpb9NSLQYiQ1QT+tnhl3MFQO/z0LNr/R4nRSNJ2nbGvceGVF09p51ogGhO9/Gfz6P9D
         eRpwhafPHFgnQmcjbwpnOenEFXrWFT/ypW9j2KHCPrKG10soYEynQ+OZjSxi5UPic/8G
         V2vg==
X-Forwarded-Encrypted: i=1; AJvYcCUfiA0XSmMkq5Pq8czLKDGvsWWnuuhkaAN47MLjOavV7UF2NfJjPxtuLH2Yo0FwVGlgm/upV0vrTNo0pPyA6r6VZptT7TQdOxAVQG5Wp3tH
X-Gm-Message-State: AOJu0YxFEqJdmKigYj4TPzEmOmQRes3Nwd7D+PHmhncpH5F5MelZ4izz
	wUG33LnYVF49dZV1bB0R5XB8g4g3OSfPmgGAN43PCVaKB1Vz0whBTrMW8mJGjEE=
X-Google-Smtp-Source: AGHT+IHbQVR5kRtT5eSzAIoLj4j7ezmt7zb8/dHcxiB8NsIJPag3OPp4cCgWeUncPmPWCdmuF6F7iw==
X-Received: by 2002:a50:d71e:0:b0:56e:2393:cee4 with SMTP id t30-20020a50d71e000000b0056e2393cee4mr346003edi.9.1712231739832;
        Thu, 04 Apr 2024 04:55:39 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id a88-20020a509ee1000000b0056dc0e21a7dsm6860407edf.4.2024.04.04.04.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:55:39 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:55:38 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 07/22] drivers/perf: riscv: Fix counter mask iteration
 for RV32
Message-ID: <20240404-f10f72395cc0b25971541ece@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-8-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-8-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:36AM -0700, Atish Patra wrote:
> For RV32, used_hw_ctrs can have more than 1 word if the firmware chooses
> to interleave firmware/hardware counters indicies. Even though it's a
> unlikely scenario, handle that case by iterating over all the words
> instead of just using the first word.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 8c3475d55433..82336fec82b8 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -771,13 +771,15 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  {
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>  	unsigned long flag = 0;
> +	int i;
>  
>  	if (sbi_pmu_snapshot_available())
>  		flag = SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
>  
> -	/* No need to check the error here as we can't do anything about the error */
> -	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
> -		  cpu_hw_evt->used_hw_ctrs[0], flag, 0, 0, 0);
> +	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
> +		/* No need to check the error here as we can't do anything about the error */
> +		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
> +			  cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
>  }
>  
>  /*
> @@ -789,7 +791,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>  static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
>  						unsigned long ctr_ovf_mask)
>  {
> -	int idx = 0;
> +	int idx = 0, i;
>  	struct perf_event *event;
>  	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
>  	unsigned long ctr_start_mask = 0;
> @@ -797,11 +799,12 @@ static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt
>  	struct hw_perf_event *hwc;
>  	u64 init_val = 0;
>  
> -	ctr_start_mask = cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
> -
> -	/* Start all the counters that did not overflow in a single shot */
> -	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_mask,
> -		  0, 0, 0, 0);
> +	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
> +		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
> +		/* Start all the counters that did not overflow in a single shot */
> +		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG, ctr_start_mask,
> +			0, 0, 0, 0);
> +	}
>  
>  	/* Reinitialize and start all the counter that overflowed */
>  	while (ctr_ovf_mask) {
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

