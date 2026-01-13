Return-Path: <linux-kselftest+bounces-48854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E1AD18415
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 11:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA817302F028
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C659338A71E;
	Tue, 13 Jan 2026 10:53:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC51E3806DD;
	Tue, 13 Jan 2026 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301584; cv=none; b=Aac6RN4vgrPMwqsjSdbGYPUiiNkqVJAmL1/L+uaO0tS6mU5pXVUO6IKhk9Q5PPZOC5OGpytiUpf+3+BdSF08QWeKGNkZRrVWZ0Jhrb/7+zmCYqezOQ41Gw0PvMmZtJzXi8bw9PAUcK2cfn0r8IZLcgK/NLFKGZDnCp9TapWz7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301584; c=relaxed/simple;
	bh=4ud7s/x//wWO9M9VSXwDrnbrgUVZaWyUIXKR42pioi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnr4s0bzFAg/ZUOHTNrQaokF/0maCukABjfC9ENCBYa6Avq6rCXCBtVLk1Twj+Xu3H7tj6iLVtwXL1IZm5srCxp9ZPDRCU7rgskWEbfRvhJyjbB7153bBRY/XpJMDj8siaTzRlWPLyGAnIDs3Wwlx4DvoGZovTkoMrhMLwYJMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D8BD497;
	Tue, 13 Jan 2026 02:52:55 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E56233F5A1;
	Tue, 13 Jan 2026 02:52:58 -0800 (PST)
Message-ID: <75ea1f3d-7589-4946-bffe-406459ee77d2@arm.com>
Date: Tue, 13 Jan 2026 10:52:57 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 28/30] KVM: arm64: selftests: Skip impossible invalid
 value tests
To: Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-28-8be3867cb883@kernel.org>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251223-kvm-arm64-sme-v9-28-8be3867cb883@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 12/23/25 01:21, Mark Brown wrote:
> The set_id_regs test currently assumes that there will always be invalid
> values available in bitfields for it to generate but this may not be the
> case if the architecture has defined meanings for every possible value for
> the bitfield. An assert added in commit bf09ee918053e ("KVM: arm64:
> selftests: Remove ARM64_FEATURE_FIELD_BITS and its last user") refuses to
> run for single bit fields which will show the issue most readily but there
> is no reason wider ones can't show the same issue.
> 
> Rework the tests for invalid value to check if an invalid value can be
> generated and skip the test if not, removing the assert.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/kvm/arm64/set_id_regs.c | 58 ++++++++++++++++++++-----
>  1 file changed, 46 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
> index 322cd13b9352..641194c5005a 100644
> --- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
> +++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
> @@ -318,11 +318,12 @@ uint64_t get_safe_value(const struct reg_ftr_bits *ftr_bits, uint64_t ftr)
>  }
>  
>  /* Return an invalid value to a given ftr_bits an ftr value */
> -uint64_t get_invalid_value(const struct reg_ftr_bits *ftr_bits, uint64_t ftr)
> +uint64_t get_invalid_value(const struct reg_ftr_bits *ftr_bits, uint64_t ftr,
> +			   bool *skip)
>  {
>  	uint64_t ftr_max = ftr_bits->mask >> ftr_bits->shift;
>  
> -	TEST_ASSERT(ftr_max > 1, "This test doesn't support single bit features");
> +	*skip = false;
>  
>  	if (ftr_bits->sign == FTR_UNSIGNED) {
>  		switch (ftr_bits->type) {
> @@ -330,42 +331,72 @@ uint64_t get_invalid_value(const struct reg_ftr_bits *ftr_bits, uint64_t ftr)
>  			ftr = max((uint64_t)ftr_bits->safe_val + 1, ftr + 1);

Don't you want the check you've got in the signed case here to deal with
safe_val or ftr being equal to ftr_max. In the 1 bit case we there won't
be any invalid values if the safe_val and ftr are different.

>  			break;
>  		case FTR_LOWER_SAFE:
> +			if (ftr == ftr_max)
> +				*skip = true;
>  			ftr++;
>  			break;
>  		case FTR_HIGHER_SAFE:
> +			if (ftr == 0)
> +				*skip = true;
>  			ftr--;
>  			break;
>  		case FTR_HIGHER_OR_ZERO_SAFE:
> -			if (ftr == 0)
> +			switch (ftr) {
> +			case 0:
>  				ftr = ftr_max;
> -			else
> +				break;
> +			case 1:
> +				*skip = true;
> +				break;
> +			default:
>  				ftr--;
> -			break;
> +				break;
> +			}

Missing break for the outer switch statement.

>  		default:
> +			*skip = true;
>  			break;
>  		}
>  	} else if (ftr != ftr_max) {
>  		switch (ftr_bits->type) {
>  		case FTR_EXACT:
>  			ftr = max((uint64_t)ftr_bits->safe_val + 1, ftr + 1);
> +			if (ftr > ftr_max)
> +				*skip = true;
>  			break;
>  		case FTR_LOWER_SAFE:
> -			ftr++;
> +			if (ftr == ftr_max)
> +				*skip = true;

This is the opposite condition of the enclosing else if.

> +			else
> +				ftr++;
>  			break;
>  		case FTR_HIGHER_SAFE:
> -			ftr--;
> -			break;
> -		case FTR_HIGHER_OR_ZERO_SAFE:
>  			if (ftr == 0)
> -				ftr = ftr_max - 1;
> +				*skip = true;

Isn't ftr_max, -1, invalid in FTR_HIGHER_SAFE case when ftr is 0. Also,
need to check for the actual highest.

>  			else
>  				ftr--;
>  			break;
> +		case FTR_HIGHER_OR_ZERO_SAFE:
> +			switch (ftr) {
> +			case 0:
> +				if (ftr_max > 1)
> +					ftr = ftr_max - 1;
> +				else
> +					*skip = true;
> +				break;
> +			case 1:
> +				*skip = true;
> +				break;
> +			default:
> +				ftr--;
> +				break;
> +			break;
> +			}
>  		default:
> +			*skip = true;
>  			break;
>  		}
>  	} else {
> -		ftr = 0;
> +		*skip = true;

Why do we always skip when signed and ftr is -1? Wouldn't 0 be an
invalid in the FTR_LOWER_SAFE case.

>  	}
>  
>  	return ftr;
> @@ -400,12 +431,15 @@ static void test_reg_set_fail(struct kvm_vcpu *vcpu, uint64_t reg,
>  	uint8_t shift = ftr_bits->shift;
>  	uint64_t mask = ftr_bits->mask;
>  	uint64_t val, old_val, ftr;
> +	bool skip;
>  	int r;
>  
>  	val = vcpu_get_reg(vcpu, reg);
>  	ftr = (val & mask) >> shift;
>  
> -	ftr = get_invalid_value(ftr_bits, ftr);
> +	ftr = get_invalid_value(ftr_bits, ftr, &skip);
> +	if (skip)
> +		return;
>  
>  	old_val = val;
>  	ftr <<= shift;
> 


Thanks,

Ben


