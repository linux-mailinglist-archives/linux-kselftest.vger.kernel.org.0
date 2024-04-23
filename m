Return-Path: <linux-kselftest+bounces-8674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CF68AE063
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D8F28275A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457E55E45;
	Tue, 23 Apr 2024 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vXf+/DXa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792B482EE;
	Tue, 23 Apr 2024 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862693; cv=none; b=qZ2a/tbEHZg1z6y0iLse/CZ5PcC820ArWIJz+ZINuj4j/tILjBWebBi5h+ez0Km3z66xEHzavvCIiTcN1pKFHFn8U5FLWFOHs9LZAkd4N0ASvSjeRb2tq9IpCJ47aUIZoaqnLCl3RwlBGJm/eMcH+nIGDbUWOTTXMZhSYt5N4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862693; c=relaxed/simple;
	bh=L/PIHK5+MUSnlGJTRqiF36FvWG0X7EQOemV2hQ9TZUM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kz7BeE9M/QHhC5jiIFQwXVAGX1Q/V3TlkFxAefkq5Yy59sRYO9a57rkoukwko3F7nyCFi678W8QOKmmqrtxt7O1wTFgqpw3OaD/UcRxlETQYbXH+vJ5OUt6acweqQz/pBBz4dedvK4XUsT9uTYaoRpZP7mWz8sYDDcj+V66766g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vXf+/DXa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713862690;
	bh=L/PIHK5+MUSnlGJTRqiF36FvWG0X7EQOemV2hQ9TZUM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=vXf+/DXaADWNVr+F5/n1bwojDoFgaDmpU/WJSb2zTdyEeWktQMCE3D7vvSnjZFabI
	 p0fiBT+WyCSg6qrpW8BBorzpyBYvXWtXWpUg7X15fhEmR4x7dONbPl93y0Xrcq+UYI
	 zTCYmZDav+zzqhqVDrVADzYpOo9H0OPzoIjY6VLoDnPXCCjKkxxrU40dxZ0xPxYBOZ
	 j2/lymoEz6fxlDqa7D9lVAT3s3Z3UUw3BupJWzyl4XJS8xOnJnlPNIEAAKFhQpmhqj
	 IWCV72eKoodxgflK0gwFSr8dLBHglenUQvmk6Zwqalalnpx7hO0EJ8rE0s42t5Lul+
	 2qz2wTqJkaavg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 792B23780016;
	Tue, 23 Apr 2024 08:58:02 +0000 (UTC)
Message-ID: <ab2d90ee-6fc9-4149-bf00-dd0cf53d5496@collabora.com>
Date: Tue, 23 Apr 2024 13:58:32 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, samuel.holland@sifive.com,
 Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v8 20/24] KVM: riscv: selftests: Add SBI PMU extension
 definitions
To: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org
References: <20240420151741.962500-1-atishp@rivosinc.com>
 <20240420151741.962500-21-atishp@rivosinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240420151741.962500-21-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/24 8:17 PM, Atish Patra wrote:
> The SBI PMU extension definition is required for upcoming SBI PMU
> selftests.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
LGTM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

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

-- 
BR,
Muhammad Usama Anjum

