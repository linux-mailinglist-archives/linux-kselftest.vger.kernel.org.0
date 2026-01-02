Return-Path: <linux-kselftest+bounces-48071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 050B9CEEC75
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 15:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56EB5300F32C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED05721FF48;
	Fri,  2 Jan 2026 14:40:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881E721CC49;
	Fri,  2 Jan 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767364811; cv=none; b=ml6z1mG/fccydBgDm1Y3GY/8vrTmrRj+iz2y9PsImGEo3daOlFw+WO4RvdsjL2gzWFoz7ByzQpmH7ctjm81UOp0Qd0ShohzPeWiFLXByyeTM1E/IasSpyB10q5pZ9Ym46+McSUo9Eu//PMx9DHr8fdEq8GIWQ0GsnSU27lnYXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767364811; c=relaxed/simple;
	bh=HwRCdGkFkfRiHY3VP6cbpdrjulr3klm3j/PC4U+Dnu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6lypO+gZxISAXE8MKVcLMUqn/6arzWt+AAonS91sIw/a62ynpE9Ftrhfb6YQ0pPzNW6qPWL4xJunyrGXMKtjGRPn3clOdot+G32Uo5LtRkcVF1E5JPJu0Lqk1PrPwNNsy2FNDHJZBSbDpasFSNNGJWUcIUuo5QH5gdGBkvlY5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCA2A497;
	Fri,  2 Jan 2026 06:40:00 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D457E3F63F;
	Fri,  2 Jan 2026 06:40:05 -0800 (PST)
Message-ID: <e3c6cd7b-0a18-4016-8131-cd14d1b32300@arm.com>
Date: Fri, 2 Jan 2026 14:40:04 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] KVM: selftests: arm64: Report set_id_reg reads of
 test registers as tests
To: Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Oliver Upton <oupton@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251219-kvm-arm64-set-id-regs-aarch64-v3-0-bfa474ec3218@kernel.org>
 <20251219-kvm-arm64-set-id-regs-aarch64-v3-1-bfa474ec3218@kernel.org>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251219-kvm-arm64-set-id-regs-aarch64-v3-1-bfa474ec3218@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 12/19/25 19:28, Mark Brown wrote:
> Currently when we run guest code to validate that the values we wrote to
> the registers are seen by the guest we assert that these values match using
> a KVM selftests level assert, resulting in unclear diagnostics if the test
> fails. Replace this assert with reporting a kselftest test per register.
> 
> In order to support getting the names of the registers we repaint the array
> of ID_ registers to store the names and open code the rest.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/kvm/arm64/set_id_regs.c | 74 +++++++++++++++++++------
>  1 file changed, 57 insertions(+), 17 deletions(-)
> 

Looks like an improvement to me.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben


