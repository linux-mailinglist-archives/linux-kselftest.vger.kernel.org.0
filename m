Return-Path: <linux-kselftest+bounces-18759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FF698C180
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 17:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66833285435
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E225B26AF6;
	Tue,  1 Oct 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XRzJGVkV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E91C9EC9
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796281; cv=none; b=ANjbAeEpjxH/tf5eghkfSigj+xIQIn+NrMn/WHsripZMZHLlX5zaMX+hFkGyWSP8B1xuj8FwNUljzAF4AycJH58ncQFr3vtSyh5lzgWWtLk6RTyatpAISgQgHXLwwHIgghu1+/QjEfFgK+XMvOZXdX9V/ZZzlzFeo+HpZmzN3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796281; c=relaxed/simple;
	bh=von7HGYPPt3GYDWzaPe5IFX1KPbsWjjFdkuYVkZQ2Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/z5MDt/FSOdHkdTCcR5R+aS+2SrLAG1ooLJvOgY/C84yK3N8fj4QiO+TMLn/NB6pX4N1i53rtgHJWlXzK0wSTQLw+02+MGOskCKKFDhu3n+rmlLML6E1ETKgjSeGhhxHcVoORgMIKvbRWx50uBiVqzq4eo0R1eqBPmEZ5qa0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XRzJGVkV; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 1 Oct 2024 08:24:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727796277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2hl11LMqGSp9at+HMjXIsFHZ/DScXnW36d/r3sG9uQo=;
	b=XRzJGVkVOLg+1C5VqKjeZ8+kU7+TmI6xKAymLx02M8t0sAYuYFUERF7HRUe6eERr7iIYIT
	khH+D5OBz/NItgnK6j2LMfkj15iL5HB/0SL84vxrPzgEe5ID8xg7OyV7D7ArZgFiA/6/hC
	yX8vZMqfFjJuV08GRJ3rMaOwi93atAY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH v5 2/5] KVM: arm64: Add PSCI v1.3 SYSTEM_OFF2 function
 for hibernation
Message-ID: <ZvwUK34LYeGuBV2H@linux.dev>
References: <20240926184546.833516-1-dwmw2@infradead.org>
 <20240926184546.833516-3-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926184546.833516-3-dwmw2@infradead.org>
X-Migadu-Flow: FLOW_OUT

Hi David,

On Thu, Sep 26, 2024 at 07:37:57PM +0100, David Woodhouse wrote:
> @@ -392,6 +403,32 @@ static int kvm_psci_1_x_call(struct kvm_vcpu *vcpu, u32 minor)
>  			break;
>  		}
>  		break;
> +	case PSCI_1_3_FN_SYSTEM_OFF2:
> +		kvm_psci_narrow_to_32bit(vcpu);
> +		fallthrough;
> +	case PSCI_1_3_FN64_SYSTEM_OFF2:
> +		if (minor < 3)
> +			break;
> +
> +		arg = smccc_get_arg1(vcpu);
> +		if (arg != PSCI_1_3_HIBERNATE_TYPE_OFF) {
> +			val = PSCI_RET_INVALID_PARAMS;
> +			break;
> +		}

This is missing a check that arg2 must be zero.

> +		kvm_psci_system_off2(vcpu);
> +		/*
> +		 * We shouldn't be going back to guest VCPU after
> +		 * receiving SYSTEM_OFF2 request.
> +		 *
> +		 * If user space accidentally/deliberately resumes
> +		 * guest VCPU after SYSTEM_OFF2 request then guest
> +		 * VCPU should see internal failure from PSCI return
> +		 * value. To achieve this, we preload r0 (or x0) with
> +		 * PSCI return value INTERNAL_FAILURE.
> +		 */
> +		val = PSCI_RET_INTERNAL_FAILURE;
> +		ret = 0;
> +		break;
>  	default:
>  		return kvm_psci_0_2_call(vcpu);
>  	}
> -- 
> 2.44.0
>

-- 
Thanks,
Oliver

