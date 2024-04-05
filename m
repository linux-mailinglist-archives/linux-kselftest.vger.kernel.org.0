Return-Path: <linux-kselftest+bounces-7279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D98899CC4
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 14:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2DAB231CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA1516C854;
	Fri,  5 Apr 2024 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Qp/HdHac"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD016ABCE
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319613; cv=none; b=APWI3If0pMh8DLCl2N8tGWa7jEhosH3SxbdaV5jyhiu+Snq/PopzESr/zz7NPyJe5uBNeyT7/j6eLWzdwZkKmIcgLgar2bBD2kMrZtALgFr2hwmcTQVwrGUixDpqcwUuMty1ludGfxxvOv6JO/MmyfEifQOe+GLE6zKs/Dgjj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319613; c=relaxed/simple;
	bh=QvT4ozHWD3CjUArG6dq9y/ZxSh4Rx9h9I/c69ZvPWTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa8QlY3L/mss86FL2ssrOR1c7gvlSmy+XB8p2kTzy7mjh7G0VmwaWCaXApwgHu/LEX93iB0MNslcOdZdZix8Cnlt7wGxw7PJCBgtgsqxYhcQSsG94PA04FHKbzgE76lR1x6Qql6x0vRU2rR4ZFlXb5OQ36etW/dV7+fMjmmbBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Qp/HdHac; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so2960927a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712319610; x=1712924410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3Ue/COd7xzip1h5OQAnlWq7u3bU48JD2sac4Wso5xg=;
        b=Qp/HdHacBiC9NzqV3JO6hxgWf2/7u2V84UrEZpfPnvI+UBdzIeuZx1uyUDDDJ9qQLn
         3f0b7q9FdnJxYGfPl9pyaVNEuKaQpSojikNiOYpkcCjAeC+v59IENaTxJXwNsX01ypOI
         MB4pUtVNDGW+l1CCfJj/nlrL0B/FmehMKLiH2Gv3KgEymiNOwZDq477Qwm1aQSHRKle1
         kFqQexsUqzQD4qtl9JFqJXje6NXvQrfc3HKUT+kGc46WECyJt/CtTZQsWiz9ZFXQq/Lu
         sAkxsZIOZ9n9TEvZZ9Sf0vtaFSvSf/6kRi6FMl88+yDzGdAWWbF9CiHmpE3/eL9eF4L5
         uDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712319610; x=1712924410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3Ue/COd7xzip1h5OQAnlWq7u3bU48JD2sac4Wso5xg=;
        b=AejI5c/UXOBIOFZkjIoShjccJ7ulwKxDeVli8GGGNP4EChvVS1tAER37jNGze8WUvq
         Zlpz1lyUR3eQz/dwmGjVDsNAR6ZPORtiS7QM9eALC7AyfthHquGle7VqKu434iSHLVac
         z8dQVyn+3/bT4TWs80abiSzp05kds8yVohix1M+lQh73DtE1eOVw9Db2jjfwlBxGkC5S
         G0ETDVFFZvqr5zlRhPMjgaBCnKiiWAXjYFfBVLW/juprttMM/jvjfPjHOWAeSI+3zmvl
         9xhUn1UAb0PGlKZd8xa7FZTEhhG+TfPpx/Pr6Mw1ATYatihsOwIDfii54pVMMsCkoj5t
         SoNA==
X-Forwarded-Encrypted: i=1; AJvYcCXOpvY5wR95IWVpuHOx6xc4jea3iDXMYjrsQ4LyTqaPGfWQIHzYIoqkJiiqXtjWBe13WEkvddQ0wKMfU1XyGip4Cq9o3+Ue/V+JrXbvR42D
X-Gm-Message-State: AOJu0YzxPNpoEUh0rsXq4J10eVDJDFHtCMrKnHEdnJuwhEkJFkN7fdVX
	tP6IS4lSU6HILRZcrF9YhPpEjxNreBGNGn2vIJSt9MjjgmQBJJ4e2gsB1B9iS0Q=
X-Google-Smtp-Source: AGHT+IF0CC6ogogXzpTL4zy1ENTK47UYVZiCW2YoU20z8kyqiFEfeNZFbwkqt8ICTVLi3dEuo7O6xQ==
X-Received: by 2002:a17:906:55d4:b0:a4d:b0e9:efbc with SMTP id z20-20020a17090655d400b00a4db0e9efbcmr973887ejp.17.1712319610180;
        Fri, 05 Apr 2024 05:20:10 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id u15-20020a170906408f00b00a4e583adcc7sm767504ejj.99.2024.04.05.05.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:20:09 -0700 (PDT)
Date: Fri, 5 Apr 2024 14:20:08 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 19/22] KVM: riscv: selftests: Add SBI PMU extension
 definitions
Message-ID: <20240405-1f8409c47501740fe808adbb@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-20-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-20-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:48AM -0700, Atish Patra wrote:
> The SBI PMU extension definition is required for upcoming SBI PMU
> selftests.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  .../testing/selftests/kvm/include/riscv/sbi.h | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
> index ba04f2dec7b5..6675ca673c77 100644
> --- a/tools/testing/selftests/kvm/include/riscv/sbi.h
> +++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
> @@ -29,17 +29,83 @@
>  enum sbi_ext_id {
>  	SBI_EXT_BASE = 0x10,
>  	SBI_EXT_STA = 0x535441,
> +	SBI_EXT_PMU = 0x504D55,
>  };
>  
>  enum sbi_ext_base_fid {
>  	SBI_EXT_BASE_PROBE_EXT = 3,
>  };
> +enum sbi_ext_pmu_fid {
> +	SBI_EXT_PMU_NUM_COUNTERS = 0,
> +	SBI_EXT_PMU_COUNTER_GET_INFO,
> +	SBI_EXT_PMU_COUNTER_CFG_MATCH,
> +	SBI_EXT_PMU_COUNTER_START,
> +	SBI_EXT_PMU_COUNTER_STOP,
> +	SBI_EXT_PMU_COUNTER_FW_READ,
> +	SBI_EXT_PMU_COUNTER_FW_READ_HI,
> +	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> +};
> +
> +union sbi_pmu_ctr_info {
> +	unsigned long value;
> +	struct {
> +		unsigned long csr:12;
> +		unsigned long width:6;
> +#if __riscv_xlen == 32
> +		unsigned long reserved:13;
> +#else
> +		unsigned long reserved:45;
> +#endif
> +		unsigned long type:1;
> +	};
> +};
>  
>  struct sbiret {
>  	long error;
>  	long value;
>  };
>  
> +/** General pmu event codes specified in SBI PMU extension */
> +enum sbi_pmu_hw_generic_events_t {
> +	SBI_PMU_HW_NO_EVENT			= 0,
> +	SBI_PMU_HW_CPU_CYCLES			= 1,
> +	SBI_PMU_HW_INSTRUCTIONS			= 2,
> +	SBI_PMU_HW_CACHE_REFERENCES		= 3,
> +	SBI_PMU_HW_CACHE_MISSES			= 4,
> +	SBI_PMU_HW_BRANCH_INSTRUCTIONS		= 5,
> +	SBI_PMU_HW_BRANCH_MISSES		= 6,
> +	SBI_PMU_HW_BUS_CYCLES			= 7,
> +	SBI_PMU_HW_STALLED_CYCLES_FRONTEND	= 8,
> +	SBI_PMU_HW_STALLED_CYCLES_BACKEND	= 9,
> +	SBI_PMU_HW_REF_CPU_CYCLES		= 10,
> +
> +	SBI_PMU_HW_GENERAL_MAX,
> +};
> +
> +/* SBI PMU counter types */
> +enum sbi_pmu_ctr_type {
> +	SBI_PMU_CTR_TYPE_HW = 0x0,
> +	SBI_PMU_CTR_TYPE_FW,
> +};
> +
> +/* Flags defined for config matching function */
> +#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
> +#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
> +#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
> +#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
> +#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
> +#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
> +#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
> +#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
> +
> +/* Flags defined for counter start function */
> +#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
> +#define SBI_PMU_START_FLAG_INIT_SNAPSHOT BIT(1)
> +
> +/* Flags defined for counter stop function */
> +#define SBI_PMU_STOP_FLAG_RESET BIT(0)
> +#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
> +
>  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  			unsigned long arg1, unsigned long arg2,
>  			unsigned long arg3, unsigned long arg4,
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

