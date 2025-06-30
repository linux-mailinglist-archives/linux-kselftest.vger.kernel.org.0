Return-Path: <linux-kselftest+bounces-36094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEF0AED9B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 12:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3D73A631E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 10:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F112571BA;
	Mon, 30 Jun 2025 10:21:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8337834CF5;
	Mon, 30 Jun 2025 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278880; cv=none; b=osh/t4AZqzplHRQCI+jzPwI4zRG4R/TjCdMDF2WURK0/mYFRiBfWKvyWbRsgSrk7DdyX2/4S1YdxH+slOM7mMMWFXHTVDH7Kr56aEfC7acNJGrDjy6egvgyurtuXyhJ1VegcqE00idajoppFUBpqPeIP9HWZXd1noRDfv5PgoYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278880; c=relaxed/simple;
	bh=gd5ly1mJwxfTxHVXTiDXU1nAFy8ObA7vyFEsPg04wrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhIHytJNvSKlhr6Rqh5kGAmY0FrHNCuA5JTpZK3GVcGHOuP0uJX2HRwDTANcZsEdUo6ccjsIe/acPtY0rbozWCa3eascg6sdVGDnIVBu/nwWzVXZ9/2y21fLzDCDM2xd4pJRczwUlL/WCiCbDxbgU3TR7wOACQqzjdMaHsySaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20C931D34;
	Mon, 30 Jun 2025 03:21:02 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD3323F58B;
	Mon, 30 Jun 2025 03:21:15 -0700 (PDT)
Message-ID: <ee89d23e-db04-4646-a556-27117e94b5ed@arm.com>
Date: Mon, 30 Jun 2025 11:21:14 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: Support FEAT_LSFE (Large System Float
 Extension)
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20250627-arm64-lsfe-v1-0-68351c4bf741@kernel.org>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250627-arm64-lsfe-v1-0-68351c4bf741@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark,

On 6/27/25 18:20, Mark Brown wrote:
> FEAT_LSFE is optional from v9.5, it adds new instructions for atomic
> memory operations with floating point values.  We have no immediate use
> for it in kernel, provide a hwcap so userspace can discover it and allow
> the ID register field to be exposed to KVM guests.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Mark Brown (3):
>        arm64/hwcap: Add hwcap for FEAT_LSFE
>        KVM: arm64: Expose FEAT_LSFE to guests
>        kselftest/arm64: Add lsfe to the hwcaps test
> 
>   Documentation/arch/arm64/elf_hwcaps.rst   |  4 ++++
>   arch/arm64/include/asm/hwcap.h            |  1 +
>   arch/arm64/include/uapi/asm/hwcap.h       |  1 +
>   arch/arm64/kernel/cpufeature.c            |  2 ++
>   arch/arm64/kernel/cpuinfo.c               |  1 +
>   arch/arm64/kvm/sys_regs.c                 |  4 +++-
>   tools/testing/selftests/arm64/abi/hwcap.c | 21 +++++++++++++++++++++
>   7 files changed, 33 insertions(+), 1 deletion(-)


I have looked through the series and it looks good to me modulo a couple 
of minor comments left on the patches. Bare in mind fairly new here and 
this is the first use of hwcap3 so I expect more experienced review is 
required.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

> ---
> base-commit: 86731a2a651e58953fc949573895f2fa6d456841
> change-id: 20250625-arm64-lsfe-0810cf98adc2
> 
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
> 
> 


Thanks,

Ben


