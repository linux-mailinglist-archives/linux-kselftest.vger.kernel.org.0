Return-Path: <linux-kselftest+bounces-7178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011C48985D9
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC402825FB
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C6E82860;
	Thu,  4 Apr 2024 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LeY/pptd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4E7FBB6
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229305; cv=none; b=fE9ylvrhyyNsfBIK0863IidHf2MNk2dj4SN6aJYF1vrIa3eME8+LBKz2u+7pT4Yb3249rw7ijBQYy5kKwURRf20uucrc1imBGFZwZnizYFWxxH6+f60kTC8mcGvRuWPHlXuuYZlBDJ46KPlTDWw7tihubajShz5YgmXES5TJcOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229305; c=relaxed/simple;
	bh=lcJ+0RKOVKyrFkZyrW0bb1gbt91d8N2KUr9gV2aCHuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooMPwk7q2ktR/HUzkCuMnRULd58uhy5kncJ5U3TDkDOH2l36zh4WLDRwjo5EXGdVFrYpzp0njY/SKVrcfaCOMIskze668qUCWSvL68ekPA0QQ9LfNMu54aSXMsESby8de6ySXtpDuZtGfxeraDhcIABd3sQ9gxLMf8hP3QLKAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LeY/pptd; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e030624d1so1368389a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 04:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712229301; x=1712834101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25ODCdRY+Jn4wzM+mEjHDke5+vqaysXX4gL6DfhOAvg=;
        b=LeY/pptd4pc15OvlMMzvYYgW1REaFvv+8aB3TzuqRawEQUHFYNHLNVe2z1Zv/Svg6K
         Dzb64pkVl8UFOhy2Fkgwl5B9cwlN0j5M+JkXiTCRFG0yVU4xGtXSzQuYQyiZrqHAhvGE
         64jTqqgOIi3BGe0lRwZy8Lbsjmv5C3wStrplGZACVg1n2ZIwWLMmz3yNv6fZ7/HC2dbg
         LudmSqah5AIRGyQuLYy61j8mEJoAlQQqdyvvjuopvHAlsBJHmG7hd46QPvnr7EiuLJQ3
         HDqaGP/K1MQsZH4eJAs2UPbzaO82PErSFaVi8FeRah3q+LGwHpDQNsfL+rrIpET+Hbit
         nPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712229301; x=1712834101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25ODCdRY+Jn4wzM+mEjHDke5+vqaysXX4gL6DfhOAvg=;
        b=uwSKiIg5smXr9ZsVzYfQcoGr4TYABkUJTjsM/VuwYikpyqCTolsoAPrYlFxi4aP732
         yZiTMThw41YhyOhTgijh8hrDxlUiq1ck7D+J8Y1eDjPWeO6mwD3QdbZWNUJAnbQnkv9g
         Zcx83r/eoejMpQiOc+iaU1S+cGXkl4G81AEILJqf3zSwbLhhlCTruQ+kurLETNMMzLzp
         NJ5CliBigsjZ/lbsC/gms+7CrjQ0TOMmvLoIUcOGHP+EPP+cyZC/UNptWChP4ey9D54z
         VfWZObx4cxujFZL/t32bBIknyNh6L/W9PvmzXYzc49+S/EgJEE3BDukod3j1973YuNaN
         6ISA==
X-Forwarded-Encrypted: i=1; AJvYcCWDz6kh2Uo+ZOYb9KWVfdx6BHFmW6LobqhGlGtD2N/hTY76IzYyte0iUa+W3leO87C464RDhRFrdxbq+WP/AfYiBa9vCLVRrauIAmLNSjaE
X-Gm-Message-State: AOJu0Yy4N6Ksn1hGTTp8uGlYZ0P84I1wv6y9Sy5wEvAwUqY/eSqpSwZ1
	za5pVYvP9Hn7nfZCVUPLDK2ZBmn9dIKrzxOLKmq5+XW/Mibj3XVbcFjFSbJwrDM=
X-Google-Smtp-Source: AGHT+IHVQCEpGYXXQyLBKL2NnoOYXTEECAPh40NJ3Rd5iw4YTlh7y+zWHd66X26Mz6VjXnim0PWvpg==
X-Received: by 2002:a50:8e4f:0:b0:567:824:e36c with SMTP id 15-20020a508e4f000000b005670824e36cmr1856431edx.14.1712229301530;
        Thu, 04 Apr 2024 04:15:01 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id fj22-20020a0564022b9600b0056a2cc5c868sm9061098edb.72.2024.04.04.04.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:14:59 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:14:58 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 05/22] RISC-V: Add SBI PMU snapshot definitions
Message-ID: <20240404-ecddd056e774ccec7cea3be8@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-6-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-6-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:34AM -0700, Atish Patra wrote:
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
> index 4afa2cd01bae..9aada4b9f7b5 100644
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
>  #define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
> +#define SBI_PMU_START_FLAG_INIT_SNAPSHOT BIT(1)
>  
>  /* Flags defined for counter stop function */
>  #define SBI_PMU_STOP_FLAG_RESET BIT(0)
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

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

