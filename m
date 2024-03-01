Return-Path: <linux-kselftest+bounces-5709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543DF86DFFD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07741F21B70
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179C6BFD6;
	Fri,  1 Mar 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ojxr+zuC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B232F6BFC9
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291654; cv=none; b=uySwHrf1/CzGZvXytRtnC6hZyK8jkx8OmGfoWL6QhtpvlFwqlnL+Ml+q5QvGAYIJ/9fB56Ei7Iymf0pDo2xwJfIq6kQaOgALewbbyco280ZHYVHisu0FBnhxQp4cCu7SUtaRxHWbcQDRNqOHL5YsMBWU3l7Ddohim2TtrnNIkPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291654; c=relaxed/simple;
	bh=zkbtf2XhdXqJAJc2oYBIfqC9jUyxnkqSO9tew8V0bg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unog0ZAeeeDbhhPGiTZz5y/0RDDzI4MvrxJARCnf/kHVMovCn9fbzaDusq1fpznrappUAoEIZN8hlDV8brGTzrvYGUVZeQvHkTRJ9X+Cp5QxMw7s60efUf95GgxOTiw8klXiJHXXHIkxW/KuQhOE2s+9aosnDwGtV3aIla2M18Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ojxr+zuC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512fb30dbc9so1793666e87.2
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Mar 2024 03:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709291651; x=1709896451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXt56DDN1trQQI8RIOoz0OKV0RNEBNHuWLr8xaraJVQ=;
        b=ojxr+zuC/PpK426wnS6w13kYyIzL9mBC8UehHmts6Yk/0Z9Qw8Cstg9MvvOL9+Lvte
         lHCuR63R26xspRTGe2jEJiy4suoIIdhHSPJ/34rjXLIU2tKl/p3+WS4UM8BmvqTPYl55
         QkhFiLiOJHmYnFv3YKsrLvOLWlD+ds4EBnQ2Cuk+00DpEUVZqpRyN7jZ6H1E85n5Fbr/
         L38Es5opuNC6cPXWNcxrmRPEWXZ+HB/nH3OLJvm/dto6FeuqSpiCeXqf6tcga/f3R+IV
         rNETlhe409XcbtV1NkVXIPL5XcqutRt2Tw97zmhL+KI+UiZH5bVzvzd5k/4Rm8ZrHZfz
         Zdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291651; x=1709896451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXt56DDN1trQQI8RIOoz0OKV0RNEBNHuWLr8xaraJVQ=;
        b=hClDqs1LIzlWRj5taaIBxMIXTf9FZf1INEmC98ndt3MzenyzHufAxLNNorBOD38zXf
         344Vf8qhEEjLTG3xKGHCBvofYSxySkCVA4qrDnNoRGx5mGWI2nburKc1fJJJ6vyTGciv
         nn8Lliv56/4MLims92kajPL252ScJspgjOLiTKY2LswZf6d98aneBctpyLTaPtPhFvEz
         UL9DhYPRpUXYWN2+kJmWC+Emp02VKxJfSzUH8SuCf+zedq+U1zR2ZEcT+tmLWlaFa9I1
         cVsUKIUAeOnEnNWXCNR0mWjBLEMzItuwnduVmqB/0VLbbwM+kfocsvQHXbVIkUdTG4HV
         eCvg==
X-Forwarded-Encrypted: i=1; AJvYcCUXyM0OKHqhaEdIV3Pz10kMzM56caO5nGDdJn/lNMXdR+A8f4MY7Dbx1KfpUNhOhLoEzmShNwpIjdwJkwylYCb1ZsRQPGeTQ9DB8Xqd806F
X-Gm-Message-State: AOJu0YzIEKoeqZtJk/PPW9eIkS/hZwttadRxVaN2vVoDtnOnoiqzFq5s
	0/6pC9dQ/oIGXaZtTHp5WNRzgR5MfliMi0mkf7jbLphQwHBCoJFz0u93yHf3eMk=
X-Google-Smtp-Source: AGHT+IEMU3X0u8IVUbmn5Hd0kEbruFTDCYQR+XS7mqKnTdFj2a5iVEk93dn2ijW3fSXhfMFxgwHqFQ==
X-Received: by 2002:a05:6512:2388:b0:512:be8e:79da with SMTP id c8-20020a056512238800b00512be8e79damr1364981lfv.8.1709291650643;
        Fri, 01 Mar 2024 03:14:10 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm4292371wru.112.2024.03.01.03.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:14:10 -0800 (PST)
Date: Fri, 1 Mar 2024 12:14:09 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@atishpatra.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 04/15] RISC-V: Add SBI PMU snapshot definitions
Message-ID: <20240301-1a1aa2a2c04640c34749cb5f@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-5-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229010130.1380926-5-atishp@rivosinc.com>

On Wed, Feb 28, 2024 at 05:01:19PM -0800, Atish Patra wrote:
> SBI PMU Snapshot function optimizes the number of traps to
> higher privilege mode by leveraging a shared memory between the S/VS-mode
> and the M/HS mode. Add the definitions for that extension and new error
> codes.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index ef8311dafb91..dfa830f7d54b 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -132,6 +132,7 @@ enum sbi_ext_pmu_fid {
>  	SBI_EXT_PMU_COUNTER_STOP,
>  	SBI_EXT_PMU_COUNTER_FW_READ,
>  	SBI_EXT_PMU_COUNTER_FW_READ_HI,
> +	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
>  };
>  
>  union sbi_pmu_ctr_info {
> @@ -148,6 +149,13 @@ union sbi_pmu_ctr_info {
>  	};
>  };
>  
> +/* Data structure to contain the pmu snapshot data */
> +struct riscv_pmu_snapshot_data {
> +	u64 ctr_overflow_mask;
> +	u64 ctr_values[64];
> +	u64 reserved[447];
> +};
> +
>  #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
>  #define RISCV_PMU_RAW_EVENT_IDX 0x20000
>  
> @@ -244,9 +252,11 @@ enum sbi_pmu_ctr_type {
>  
>  /* Flags defined for counter start function */
>  #define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)

A patch before this which changes all flags to use BIT() instead of shifts
would be good, since otherwise the new flags are inconsistent.

> +#define SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT BIT(1)

This is named SBI_PMU_START_FLAG_INIT_SNAPSHOT in the spec.

>  
>  /* Flags defined for counter stop function */
>  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> +#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
>  
>  enum sbi_ext_dbcn_fid {
>  	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
> @@ -285,6 +295,7 @@ struct sbi_sta_struct {
>  #define SBI_ERR_ALREADY_AVAILABLE -6
>  #define SBI_ERR_ALREADY_STARTED -7
>  #define SBI_ERR_ALREADY_STOPPED -8
> +#define SBI_ERR_NO_SHMEM	-9
>  
>  extern unsigned long sbi_spec_version;
>  struct sbiret {
> -- 
> 2.34.1
>

Thanks,
drew

