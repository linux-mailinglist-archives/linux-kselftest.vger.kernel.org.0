Return-Path: <linux-kselftest+bounces-14611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7640E944852
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2151A1F28B6F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A3A156F3A;
	Thu,  1 Aug 2024 09:30:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1BC13C8EE;
	Thu,  1 Aug 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504629; cv=none; b=ORYcbfBJAfJr8G3ZlH4ao7YqDbpBgVvurwZd3zRnQ9SN+B6JQ0nv5l4QeSRcrjn5dA2G2hjzYl4sYEqln2bTewhdUcuYm0aJpihHZYNTvg5wnsftphfKGMN9iG2+FdIpZuUgi4UHc7SidbCpIu+2UaYg2Tfh49zTNHzoqVVXC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504629; c=relaxed/simple;
	bh=/OTW+2gYWzzGtg5eh5Ri6h4zgQIrGeCZb7gtCGgQcJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3TbEMR7zhO8+cmWhkwGHCS20i124fcdeZfXLyUB+yVafotxXnghXZ0ZyQ8Aj/4qHIEWhBwmi+JESipFVFyeI34gyN43WGVDXCACLBMabc9HQTXRvhTqeOCC3VO3AGS23Mmi5aPYeq96rwC/0BsFV2YpVvB55xe9GJpBSQGnSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A013EDA7;
	Thu,  1 Aug 2024 02:30:52 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 681BB3F5A1;
	Thu,  1 Aug 2024 02:30:25 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:30:20 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: arm64: Correct feature test for S1PIE in
 get-reg-list
Message-ID: <20240801093020.GA841418@e124191.cambridge.arm.com>
References: <20240731-kvm-arm64-fix-s1pie-test-v1-1-a9253f3b7db4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-kvm-arm64-fix-s1pie-test-v1-1-a9253f3b7db4@kernel.org>

On Wed, Jul 31, 2024 at 05:21:13PM +0100, Mark Brown wrote:
> The ID register for S1PIE is ID_AA64MMFR3_EL1.S1PIE which is bits 11:8 but
> get-reg-list uses a shift of 4, checking SCTLRX instead. Use a shift of 8
> instead.
> 
> Fixes: 5f0419a0083b ("KVM: selftests: get-reg-list: add Permission Indirection registers")
> Signed-off-by: Mark Brown <broonie@kernel.org>

Argh!

Thanks for spotting that.

Reviewed-by: Joey Gouly <joey.gouly@arm.com>

> ---
>  tools/testing/selftests/kvm/aarch64/get-reg-list.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> index 709d7d721760..4abebde78187 100644
> --- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> @@ -32,13 +32,13 @@ static struct feature_id_reg feat_id_regs[] = {
>  	{
>  		ARM64_SYS_REG(3, 0, 10, 2, 2),	/* PIRE0_EL1 */
>  		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
> -		4,
> +		8,
>  		1
>  	},
>  	{
>  		ARM64_SYS_REG(3, 0, 10, 2, 3),	/* PIR_EL1 */
>  		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
> -		4,
> +		8,
>  		1
>  	}
>  };
> 
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20240731-kvm-arm64-fix-s1pie-test-a40b6be58d7b
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

