Return-Path: <linux-kselftest+bounces-30052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FDA79FA1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 11:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9CA1895427
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8524624501E;
	Thu,  3 Apr 2025 09:04:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A5624501D;
	Thu,  3 Apr 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671093; cv=none; b=aB4sPOqt4U13CsPUTav9Yg6zEfKRtNolyea2WYSPkhAS+ooPb/AjmZS/2ew1wnf0tk6a6IElxTcp2DDc+gS9bHPv8ePdDM1AxhTWOgmOnzUfgoAJWqk6H4rm6vZrR36WO9Z+62phXGPXuFpvyh8tHgxOhgHuSTMPw0lrPuEx4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671093; c=relaxed/simple;
	bh=j1Fkw8epdkiaxhLhJzIHl7KWT3KcJ8DBd7ToBVFnEtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfVdp3EHe6fdnHaDEYR8xnf9XUfxxnqLX2vmDA3d0BRP33gQrqeaAgdAaKP6kme+lC4H7Zk4BgvVGDokOHCXf5baEus5dA8w2wfvDIY4ZfD57ZMQNKWEbMinU5RMpNvbPhuuQm4K+flRUTIFJYaTUaJg1GeXSlh1LAJW2jC5yKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1D12106F;
	Thu,  3 Apr 2025 02:04:52 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF29A3F63F;
	Thu,  3 Apr 2025 02:04:47 -0700 (PDT)
Message-ID: <957ccba4-2ae1-4358-b62d-3b5c44d7f1ca@arm.com>
Date: Thu, 3 Apr 2025 10:04:46 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] arm64: Provide basic EL2 setup for FEAT_{LS64,
 LS64_V} usage at EL0/1
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Cc: joey.gouly@arm.com, yuzenghui@huawei.com, shuah@kernel.org,
 jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
 linuxarm@huawei.com, prime.zeng@hisilicon.com, xuwei5@huawei.com,
 yangyicong@hisilicon.com, tangchengchang@huawei.com
References: <20250331094320.35226-1-yangyicong@huawei.com>
 <20250331094320.35226-2-yangyicong@huawei.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250331094320.35226-2-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/03/2025 10:43, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Instructions introduced by FEAT_{LS64, LS64_V} is controlled by
> HCRX_EL2.{EnALS, EnASR}. Configure all of these to allow usage
> at EL0/1.
> 
> This doesn't mean these instructions are always available in
> EL0/1 if provided. The hypervisor still have the control at
> runtime.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>   arch/arm64/include/asm/el2_setup.h | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index ebceaae3c749..0259941602c4 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -57,9 +57,19 @@
>           /* Enable GCS if supported */
>   	mrs_s	x1, SYS_ID_AA64PFR1_EL1
>   	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
> -	cbz	x1, .Lset_hcrx_\@
> +	cbz	x1, .Lskip_gcs_hcrx_\@
>   	orr	x0, x0, #HCRX_EL2_GCSEn
>   
> +.Lskip_gcs_hcrx_\@:

minor nit: For consistency, could we rename this "set_ls64", similar to 
"set_hcrx" ?

> +	/* Enable LS64, LS64_V if supported */
> +	mrs_s	x1, SYS_ID_AA64ISAR1_EL1
> +	ubfx	x1, x1, #ID_AA64ISAR1_EL1_LS64_SHIFT, #4
> +	cbz	x1, .Lset_hcrx_\@
> +	orr	x0, x0, #HCRX_EL2_EnALS
> +	cmp	x1, #ID_AA64ISAR1_EL1_LS64_LS64_V
> +	b.lt	.Lset_hcrx_\@
> +	orr	x0, x0, #HCRX_EL2_EnASR
> +
>   .Lset_hcrx_\@:
>   	msr_s	SYS_HCRX_EL2, x0
>   .Lskip_hcrx_\@:

Suzuki

