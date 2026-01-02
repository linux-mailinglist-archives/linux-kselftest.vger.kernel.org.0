Return-Path: <linux-kselftest+bounces-48072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A618CEEC7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3AA1300EA19
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C021FF48;
	Fri,  2 Jan 2026 14:42:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26049463;
	Fri,  2 Jan 2026 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767364966; cv=none; b=rV05+DMXKznNoXWWE8jRwzBUmtQ3dpHL/HgQU7nPSVaFWTwftZQaTy3dxzOFdLVL8CrmOERSqd1zh8MvtWDD9uIihFO4UXuzFm8OEWdTs1D2q6MOBU6jl4ohWMVryEFJOA9L5mlHsaFkcmgakF5HqT2zjc6NVueBR3jbaDt5eGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767364966; c=relaxed/simple;
	bh=j+0md4xMGQDF5koODOqbddxSR8/pVlmIT/xX8zVwaUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYPddKnVEMjX55DAJXqVuLOKQjrYzvoDbtfD5864PZvSNh59Cd6qParYLWqFGqSOMFIUCDM/Nj+iki1CjGd4S7OiFzMeX52s/cuRn6ccgyL0YuSUJbZyqMqWnyRUakTPo8LpcuwL37LUX667YsTtk1u3tqFRHVTnWrEHqnYWtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5011C497;
	Fri,  2 Jan 2026 06:42:36 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45D1E3F63F;
	Fri,  2 Jan 2026 06:42:41 -0800 (PST)
Message-ID: <99f23278-47de-4ee5-8ca5-18387f187f16@arm.com>
Date: Fri, 2 Jan 2026 14:42:39 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] KVM: selftests: arm64: Report register reset tests
 individually
To: Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Oliver Upton <oupton@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251219-kvm-arm64-set-id-regs-aarch64-v3-0-bfa474ec3218@kernel.org>
 <20251219-kvm-arm64-set-id-regs-aarch64-v3-2-bfa474ec3218@kernel.org>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251219-kvm-arm64-set-id-regs-aarch64-v3-2-bfa474ec3218@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 12/19/25 19:28, Mark Brown wrote:
> set_id_regs tests that registers have their values preserved over reset.
> Currently it reports all registers in a single test with an instantly fatal
> assert which isn't great for diagnostics, it's hard to tell which register
> failed or if it's just one register. Change this to report each register as
> a separate test so that it's clear from the program output which registers
> have problems.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/kvm/arm64/set_id_regs.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


