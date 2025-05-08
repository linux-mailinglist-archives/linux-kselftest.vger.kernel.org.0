Return-Path: <linux-kselftest+bounces-32679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF5AB0469
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 22:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801F24A88B8
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E175328C001;
	Thu,  8 May 2025 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L0zvo6Ua"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5C6288C23
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735462; cv=none; b=RoaAFF/cp9G7rSS74xg+pfj8vVNzxH58UORMePAyCSOnd3d3KYQGAswd9EbIb1QUPDDo7VZW+EaQXBcY1d6mGmvdkOf+n9Cm89JfomBC3g/y8Mw4QxHZjeRHo53tdlB4CQG/dSIDjuB1Sy/uUexQEg2/gzOCQcGn+weLvO/RjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735462; c=relaxed/simple;
	bh=vQw7+x3sCXM1CFdwcjqiaFcmIlu+p5tMyKAhdv0KA9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ3lrFy+yeuPRpfGjcPpTIXc8icOFSvhkR+O8c9g8EiyGX4qQszWXLBIa9fsRsG+UyFD6yquiCf//wJkNmkDn/T06MkSd4J8pa3FLE2tn+bLVNyAsbOD7r+RVuLybpBQkFAFQoc8YrdKngn6KqDny9wUW1lTHsZ7HPHv9OnJZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L0zvo6Ua; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <adbf1bdb-b4a6-4004-91a2-8ae1a7c6485d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746735446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xW1lyde1rFoYHMdSte95ffiRHM0n9sNPG5Z2FF4OZhU=;
	b=L0zvo6Uag5ujjLttWPBQRpOjKck0A5r5ywbrj41FXX+z3dHgUk0x2eXomtoQssNCK+iBy3
	RirtEwpbTb/ma2HieBXVtB24FXb/KN4AxY/YiVsFaIiSWU3PNo5aPXAAelxFmCtu6o0DwU
	gh9pwRbnSKEBkg162bdGTfqujxdAOt8=
Date: Thu, 8 May 2025 13:17:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 01/14] riscv: sbi: add Firmware Feature (FWFT) SBI
 extensions definitions
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
 <20250424173204.1948385-2-cleger@rivosinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250424173204.1948385-2-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/24/25 10:31 AM, ClÃ©ment LÃ©ger wrote:
> The Firmware Features extension (FWFT) was added as part of the SBI 3.0
> specification. Add SBI definitions to use this extension.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Tested-by: Samuel Holland <samuel.holland@sifive.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/include/asm/sbi.h | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 3d250824178b..bb077d0c912f 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -35,6 +35,7 @@ enum sbi_ext_id {
>   	SBI_EXT_DBCN = 0x4442434E,
>   	SBI_EXT_STA = 0x535441,
>   	SBI_EXT_NACL = 0x4E41434C,
> +	SBI_EXT_FWFT = 0x46574654,
>   
>   	/* Experimentals extensions must lie within this range */
>   	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
> @@ -402,6 +403,33 @@ enum sbi_ext_nacl_feature {
>   #define SBI_NACL_SHMEM_SRET_X(__i)		((__riscv_xlen / 8) * (__i))
>   #define SBI_NACL_SHMEM_SRET_X_LAST		31
>   
> +/* SBI function IDs for FW feature extension */
> +#define SBI_EXT_FWFT_SET		0x0
> +#define SBI_EXT_FWFT_GET		0x1
> +
> +enum sbi_fwft_feature_t {
> +	SBI_FWFT_MISALIGNED_EXC_DELEG		= 0x0,
> +	SBI_FWFT_LANDING_PAD			= 0x1,
> +	SBI_FWFT_SHADOW_STACK			= 0x2,
> +	SBI_FWFT_DOUBLE_TRAP			= 0x3,
> +	SBI_FWFT_PTE_AD_HW_UPDATING		= 0x4,
> +	SBI_FWFT_POINTER_MASKING_PMLEN		= 0x5,
> +	SBI_FWFT_LOCAL_RESERVED_START		= 0x6,
> +	SBI_FWFT_LOCAL_RESERVED_END		= 0x3fffffff,
> +	SBI_FWFT_LOCAL_PLATFORM_START		= 0x40000000,
> +	SBI_FWFT_LOCAL_PLATFORM_END		= 0x7fffffff,
> +
> +	SBI_FWFT_GLOBAL_RESERVED_START		= 0x80000000,
> +	SBI_FWFT_GLOBAL_RESERVED_END		= 0xbfffffff,
> +	SBI_FWFT_GLOBAL_PLATFORM_START		= 0xc0000000,
> +	SBI_FWFT_GLOBAL_PLATFORM_END		= 0xffffffff,
> +};
> +
> +#define SBI_FWFT_PLATFORM_FEATURE_BIT		BIT(30)
> +#define SBI_FWFT_GLOBAL_FEATURE_BIT		BIT(31)
> +
> +#define SBI_FWFT_SET_FLAG_LOCK			BIT(0)
> +
>   /* SBI spec version fields */
>   #define SBI_SPEC_VERSION_DEFAULT	0x1
>   #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
> @@ -419,6 +447,11 @@ enum sbi_ext_nacl_feature {
>   #define SBI_ERR_ALREADY_STARTED -7
>   #define SBI_ERR_ALREADY_STOPPED -8
>   #define SBI_ERR_NO_SHMEM	-9
> +#define SBI_ERR_INVALID_STATE	-10
> +#define SBI_ERR_BAD_RANGE	-11
> +#define SBI_ERR_TIMEOUT		-12
> +#define SBI_ERR_IO		-13
> +#define SBI_ERR_DENIED_LOCKED	-14
>   
>   extern unsigned long sbi_spec_version;
>   struct sbiret {

Reviewed-by: Atish Patra <atishp@rivosinc.com>

