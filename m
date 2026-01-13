Return-Path: <linux-kselftest+bounces-48845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C1D17D9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 11:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 282F630230DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5293876D1;
	Tue, 13 Jan 2026 10:05:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08B389DEC;
	Tue, 13 Jan 2026 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298729; cv=none; b=Iplr08whcH6KYj2ClcjQ0w+i4Y3wxTZKEICpDygRd9nzqfv1OOKZnPXCdO80955tcjh6UVa2b3I47KL+fhlVV/W6w2wR0IAD2DywKmhMM/EC3E08tjMGZjicasaahvfy6m9nHumu6dwZMLn1afwwGUk2R3N+OIfKC5bnRrNzSDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298729; c=relaxed/simple;
	bh=JWXLVb707nEHkqfVhm/mbYxV2ox0Guk+FjcUauUJ6/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCswVUr8yNkOaPAX1F7wz/TP3g2GiH6htO0BNTdleszSklxvc3tO1on+tyqzMywG97Xg+FeGkRgj9pv63a4tJB+cgPb1GkWc2daM1X0o5nwilzIm3vosIRZeKlrPHayW8/iGaL3qF1ezmHrVNyDXfkzGq+I9FlMqU5DZPm5DtRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25DCF497;
	Tue, 13 Jan 2026 02:05:13 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9488E3F694;
	Tue, 13 Jan 2026 02:05:16 -0800 (PST)
Message-ID: <dcbeb11f-bebe-465a-be4e-2461d3efc21b@arm.com>
Date: Tue, 13 Jan 2026 10:05:15 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 27/30] KVM: arm64: selftests: Remove spurious check for
 single bit safe values
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
 <20251223-kvm-arm64-sme-v9-27-8be3867cb883@kernel.org>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251223-kvm-arm64-sme-v9-27-8be3867cb883@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 12/23/25 01:21, Mark Brown wrote:
> get_safe_value() currently asserts that bitfields it is generating a safe
> value for must be more than one bit wide but in actual fact it should
> always be possible to generate a safe value to write to a bitfield even if
> it is just the current value and the function correctly handles that.
> Remove the assert.
> 
> Fixes: bf09ee918053e ("KVM: arm64: selftests: Remove ARM64_FEATURE_FIELD_BITS and its last user")
> Signed-off-by: Mark Brown <broonie@kernel.org>

Yes, this assert was unneeded.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


