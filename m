Return-Path: <linux-kselftest+bounces-7175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D69D898587
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 12:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085EF283596
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 10:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4283581AC6;
	Thu,  4 Apr 2024 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EgFKUwWD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF588062B
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228260; cv=none; b=TLsv2U6h+ET6OIzwQNb/nKgvbanacEtWKj4wKNS+ms/9aY9bmnCrQNVQDTKNo8h0zkfPXqMdbpoSmbYkiiIaW002G1cFCbbe+C+KltP5k8tQxPYiyglhaoI0QrLSv6n/75E3H3tguXNSNrh6j8HBKaMl3cr1beqFMJFLuyi8dh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228260; c=relaxed/simple;
	bh=ABMMBOx08NYLaWVA70cAng/zCf9URmS/qE7QPN7wSqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4ipEi/ZOqO4kTzcTKgOmWX4R0EPV065TXh4O+JOKq+ojDNdg5BKSL5IqFTWcXj0F0/c5JIBNNtd/OoJC02RfGtQZdSqCGVur24Tcf4j/kVPUcy7xNy1+1adeiblK/De8T0TlnOqPxfAY55BgxsNmM0g9jF2q2jowTAfYo5OEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EgFKUwWD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4162b68c9b3so2164905e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712228256; x=1712833056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NfiVdFmLV4FF6ye93fatZUexM6Nb9SSia8q2nnOXyFw=;
        b=EgFKUwWDPVNDePk/KXf2czFbxvz3kBg4zZ7zoKDoZVVN5AvanvPgdUHT32+tk/YJAO
         r7r9qy7Phbk17MM0W5paRwknCcj9U4TJmKvGBQ2L1yJBYrKAHyTaLcDwdmYEwamUhPqg
         zrBhGcQayyfh98mfPyAwwmChPyyLoQI0t+ULGAUHioLbMaeV5JZcTqd3QA179+pf8N/S
         YSCPi1eWcDF0lqhIL/RHBQUBP9rdAARzSBFPZHbeZJV+Jeo2cTxo0ba7YLEfDjygrYsz
         VCiX6KNPyZqQ67T5dy7FnAb3DlKIWY72GWKSnXircdOxslVpE7u5qp8E77AprsYt/w88
         ni3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228256; x=1712833056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfiVdFmLV4FF6ye93fatZUexM6Nb9SSia8q2nnOXyFw=;
        b=dQQiJR6CHJi5AOpS/q5ZKTuSXU404Sp4uIbufXb6CD0G1rHx838QtY6fz0mCpcdhkG
         EErLh4UFfCIdwjKk9fA8NwXxLiyPfhVhBRahdzORdNqmaRSbE8E5TyvyI6zItluWTV9F
         8YAL8AijYd+uQOOilav8wBFj8kyCoq4KSX8EDPezweHOky1yhE3/HMP33SRhI36nWtPL
         YiUeW/sRQFTa44u6FbkpsuJKKswbZbTlArOLR7FA/z/WThC4SYS2je7UiCRzLzk4tn/1
         DSm1/WboWFYP3LSBgnaqMzzEIISyrPj91l3Df2lF5pgT0XpWGLWcRGRWhrBKr6DZmRGJ
         qzaw==
X-Forwarded-Encrypted: i=1; AJvYcCXFvryfYx7fm8qN3oe16gRPFLtxSu7lzdUFm61nMUL1Kfi3sL+rUBtD4PtXui+6kDdjGNqdpAwbugPxOkTvbIUiUHg40yaXSl26AEnLb6d2
X-Gm-Message-State: AOJu0YzlS0+3IPBLdVv2BxjyVvDS0DPw1Fx5ZHsb0iC+f2MQH8+ZNfWB
	FpJj9St90YCdcM7t6whHkUz352w9SeGBphuug7fLHnHJ9rUIXvshrStnVooLEDE=
X-Google-Smtp-Source: AGHT+IEnFxataSYbqmGau+kOJUtlvfE0YzrGrXzfyVqVkslxmfUNW4m89ij6/Ce78ACjrYhuGGGyAQ==
X-Received: by 2002:a5d:51cf:0:b0:343:9fec:eb35 with SMTP id n15-20020a5d51cf000000b003439feceb35mr1526223wrv.24.1712228256052;
        Thu, 04 Apr 2024 03:57:36 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id bo15-20020a056000068f00b003434c6d9916sm11436771wrb.110.2024.04.04.03.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:57:35 -0700 (PDT)
Date: Thu, 4 Apr 2024 12:57:34 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Anup Patel <anup@brainfault.org>, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 02/22] RISC-V: Add FIRMWARE_READ_HI definition
Message-ID: <20240404-6fc14e149cd82bb0ee8f088c@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-3-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403080452.1007601-3-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:31AM -0700, Atish Patra wrote:
> SBI v2.0 added another function to SBI PMU extension to read
> the upper bits of a counter with width larger than XLEN.
> 
> Add the definition for that function.
> 
> Reviewed-by: Clément Léger <cleger@rivosinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 6e68f8dff76b..ef8311dafb91 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -131,6 +131,7 @@ enum sbi_ext_pmu_fid {
>  	SBI_EXT_PMU_COUNTER_START,
>  	SBI_EXT_PMU_COUNTER_STOP,
>  	SBI_EXT_PMU_COUNTER_FW_READ,
> +	SBI_EXT_PMU_COUNTER_FW_READ_HI,
>  };
>  
>  union sbi_pmu_ctr_info {
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

