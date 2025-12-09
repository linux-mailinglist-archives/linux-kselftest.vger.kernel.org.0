Return-Path: <linux-kselftest+bounces-47347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DE1CB15EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 23:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D8AF303E641
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 22:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCA62F8BDF;
	Tue,  9 Dec 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyF0x2Rr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B554C2F83AE;
	Tue,  9 Dec 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321083; cv=none; b=Xwk2bsnNy7B5zCgFf9MUlRUYEnCsZbYI5pqNAm1MlQRrGH1vvDDS5W5RCJiYrP2Kyq+N+96BKYfQ/th3L8x9LKbt2A/tTjfUCAx9dRulipeRg/29/YthbHGbh3zrP17QBuavqHqGGomHBru/1Ac0SvYrsg8VVeyGPHbUciuWF5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321083; c=relaxed/simple;
	bh=V4BtB+Q9IqNyD2A3rjl7JlZezM4qtcAUXtmGwddZn08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6dCCLkywm+RtFM68Q9i7omBD/ZMHcdt8PLI3gY/X6iUDjdtetHqpHcTcPkQCo+iL+RQowlPrYVLBS5mQkLnfJwlCYOxFZl6DD9FS5fOHDO98Fd/eQdAvHSfrzT4zzIsOA5bHGAXbELanDyw/lLAQpHgGQKp65eMgOkU2ksYBng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyF0x2Rr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A0AC4CEF5;
	Tue,  9 Dec 2025 22:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765321083;
	bh=V4BtB+Q9IqNyD2A3rjl7JlZezM4qtcAUXtmGwddZn08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KyF0x2RrVkq9JUm5RQ7+FgEqlpUBzgXk7WBFB9jUst56wTkI1MRZtn+CHNRoXPYnk
	 /g5wPbLYlIovoKCmAM4ATtx4QCwNMY0w7cvorFWDfhIZGFKpFe6yLuN1ntRxcolIq8
	 ZiaXTb/XO/dwb6urwzSpVyUFwR9GNBGiksrkPrUXNeyhGAZCkGBo8Y8LzKzyhe+sw9
	 SHbWmvGm5PAfcCq5SGmLuw4kbFfnqBS9cOzMGnwEiLJZcjou7ALLdTPJ/nVCXn5yKy
	 pPAICOaiqI8UXhE5gWMUwA8BWIHzT+u5IY6ynMztH4IFMnDtqF2Av5i2eXZF6tu3Ie
	 CJ0+TajSD2CXA==
Date: Tue, 9 Dec 2025 14:58:01 -0800
From: Oliver Upton <oupton@kernel.org>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 22/24] KVM: arm64: Add KVM_CAP to partition the PMU
Message-ID: <aTipeb2fAmUtSzzX@kernel.org>
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <20251209205121.1871534-23-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-23-coltonlewis@google.com>

On Tue, Dec 09, 2025 at 08:51:19PM +0000, Colton Lewis wrote:
> +
> +7.245 KVM_CAP_ARM_PARTITION_PMU
> +-------------------------------------
> +

Why can't this be a vCPU attribute similar to the other vPMU controls?
Making the UAPI consistent will make it easier for userspace to reason
about it.

Better yet, we could make the UAPI such that userspace selects a PMU
implementation and the partitioned-ness of the PMU at the same time.

> @@ -132,6 +134,16 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		}
>  		mutex_unlock(&kvm->lock);
>  		break;
> +	case KVM_CAP_ARM_PARTITION_PMU:
> +		if (kvm->created_vcpus) {
> +			r = -EBUSY;
> +		} else if (!kvm_pmu_partition_ready()) {
> +			r = -EPERM;
> +		} else {
> +			r = 0;
> +			kvm_pmu_partition_enable(kvm, cap->args[0]);
> +		}
> +		break;
>  	default:
>  		break;
>  	}
> @@ -388,6 +400,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_ARM_PMU_V3:
>  		r = kvm_supports_guest_pmuv3();
>  		break;
> +	case KVM_CAP_ARM_PARTITION_PMU:
> +		r = kvm_pmu_partition_ready();

"ready" is very confusing in this context, as KVM will never be ready to
support the feature on a system w/o the prerequisites.

Thanks,
Oliver

