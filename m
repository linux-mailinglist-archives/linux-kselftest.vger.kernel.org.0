Return-Path: <linux-kselftest+bounces-7176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F8289859A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326622818FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5756480C09;
	Thu,  4 Apr 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YWvP2XVd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A578002A
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228549; cv=none; b=I9TsC2bFkDTtV6JFAaz07uf+KPSdrjjNa1n9N5q+5CByJqtUKynyaXH3EObBxnVQ/urCgCZDurstNTzNtwRU/yFA5CGVi4TEPy8nzLRIMrMQCRggQZVI3zJxmYyHQYJCr85Y0BGf5xVKO8G9MxfPlkOH3QtBaAcEDmdbZ99qhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228549; c=relaxed/simple;
	bh=t6zNz5pw//F+8XPDFb/QOAnmOim/cJz/4VwpJwe5ATY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqDDekV3GcdpMi97VBlp83fbujYYnThBHru8itYUjMnGfnlqWRNh6T4HubR/wDvPcFJzR5y8p5H4Vbq8+aP2XO+zgoNDsODQHbkZqhFo5V/Hw9p2btu+pIhdMAsqftbJ5+qJOYEtaYv/PnUbWowkv3RIAtoCTTmi/PktKoUmE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YWvP2XVd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so790476a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712228546; x=1712833346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WI/gpDqjLiJmsDmwk7gqvmJeMZiYROtcIjc07FyAt1I=;
        b=YWvP2XVdlqBwLiqzT3eoElX5vcpFppmHDh4QdZaFwzUU4tmcOJqQVju0VhWcgGHXkB
         F0TI2TMvD3WbbZWqkxet4/Ww2zzL9cdCw6OYy2CljGGOMzWKnuFqLfvFUCr7wVnZd5l7
         sO5za6A1y5o4RJ1SRmg3zE2I8G+lvRlCINEtdWQTHJoq2GmVpSvl+qTinPpTHn/+Ua0v
         iggriv/abZkweWQbxp2S74zcRIAA5YhRYDC1jBvdBdt78n0DbJeiwkJGH7c04kz/cNJV
         q8tRZn5uHcKWFtUUJdB983P4kbQVpGgdSLRij0j+p6hl6sV9F40oWakpLtNWf0Vj5hF5
         w4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228546; x=1712833346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI/gpDqjLiJmsDmwk7gqvmJeMZiYROtcIjc07FyAt1I=;
        b=dls3ChuSDMvjAapjq7hrO55GA8r90R+AIo6FPs8h03sKiCgxh5pCCMG7uR8m0fAbzh
         FyucFLUjbKC8uwmppwa8wxnxP8OAJv961fVK3VaRYzSCV79vVf1U9zTgweZVCdY3q2DK
         J2nB3GIt0KHEVclPvdEhm7ax1uGTrRt1X18AKzGb+PNqmguGSGzy4GDKOm5bdzUt9a8E
         MoW+uUaFDRTSyaYjCHx/p3YxdTZLoqQO2sfUDNSOFTJvU05Z8ufMh/XeRGS5K7oaRlfo
         vvlcKhT1tEp06Km3QCD8ujtxosyDLZGPRkHYzIQH5jQAtvdQyM8HjLLaL30wPPSWWYEX
         eIGg==
X-Forwarded-Encrypted: i=1; AJvYcCXrjqNroZXLA8e52xpLDDzMIf/HhvdX9+TfRFweHpdv/YKBIxjm9EHn6W+GQcnBKXRVnr0KPc+cwRjbir1x6pksH6j1Qm1LbRekUDVduytR
X-Gm-Message-State: AOJu0Yx8Z5wjvDfjYoiuGWXceebd+kd8RUJNYk9dxszhjZ17EtWHWS7I
	8ThSc1YZ1AoSvrT0KCp/EXsh4Chhr+qg+UwF2OjArO7ViBg/VXovgdDkP4z4oXA=
X-Google-Smtp-Source: AGHT+IH+cR5LnT4HHFFZfBDVpuneEFANhm0q0RefyMMIWR5DVI1nM63K0UMkrPub9LuoEZqin8kkoA==
X-Received: by 2002:a17:906:7954:b0:a4e:a068:7f with SMTP id l20-20020a170906795400b00a4ea068007fmr1635905ejo.49.1712228545941;
        Thu, 04 Apr 2024 04:02:25 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id an19-20020a17090656d300b00a4e58c74c9fsm5892101ejc.6.2024.04.04.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:02:25 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:02:24 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Anup Patel <anup@brainfault.org>, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 03/22] drivers/perf: riscv: Read upper bits of a
 firmware counter
Message-ID: <20240404-89ee7d7f90a5fcc91809065e@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-4-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-4-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:32AM -0700, Atish Patra wrote:
> SBI v2.0 introduced a explicit function to read the upper 32 bits
> for any firmware counter width that is longer than 32bits.
> This is only applicable for RV32 where firmware counter can be
> 64 bit.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 3e44d2fb8bf8..babf1b9a4dbe 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -57,6 +57,8 @@ asm volatile(ALTERNATIVE(						\
>  PMU_FORMAT_ATTR(event, "config:0-47");
>  PMU_FORMAT_ATTR(firmware, "config:63");
>  
> +static bool sbi_v2_available;
> +
>  static struct attribute *riscv_arch_formats_attr[] = {
>  	&format_attr_event.attr,
>  	&format_attr_firmware.attr,
> @@ -511,19 +513,29 @@ static u64 pmu_sbi_ctr_read(struct perf_event *event)
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx = hwc->idx;
>  	struct sbiret ret;
> -	union sbi_pmu_ctr_info info;
>  	u64 val = 0;
> +	union sbi_pmu_ctr_info info = pmu_ctr_list[idx];
>  
>  	if (pmu_sbi_is_fw_event(event)) {
>  		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
>  				hwc->idx, 0, 0, 0, 0, 0);
> -		if (!ret.error)
> -			val = ret.value;
> +		if (ret.error)
> +			return 0;
> +
> +		val = ret.value;
> +		if (IS_ENABLED(CONFIG_32BIT) && sbi_v2_available && info.width >= 32) {
> +			ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ_HI,
> +					hwc->idx, 0, 0, 0, 0, 0);
> +			if (!ret.error)
> +				val |= ((u64)ret.value << 32);
> +			else
> +				WARN_ONCE(1, "Unable to read upper 32 bits of firmware counter error: %d\n",
> +					  sbi_err_map_linux_errno(ret.error));

I don't think we should use sbi_err_map_linux_errno() in this case since
we don't have a 1:1 mapping of SBI errors to Linux errors and we don't
propagate the error as a Linux error. For warnings, it's better to output
the exact SBI error.

> +		}
>  	} else {
> -		info = pmu_ctr_list[idx];
>  		val = riscv_pmu_ctr_read_csr(info.csr);
>  		if (IS_ENABLED(CONFIG_32BIT))
> -			val = ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 31 | val;
> +			val |= ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 32;
>  	}
>  
>  	return val;
> @@ -1135,6 +1147,9 @@ static int __init pmu_sbi_devinit(void)
>  		return 0;
>  	}
>  
> +	if (sbi_spec_version >= sbi_mk_version(2, 0))
> +		sbi_v2_available = true;
> +
>  	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
>  				      "perf/riscv/pmu:starting",
>  				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);
> -- 
> 2.34.1
>

Thanks,
drew

