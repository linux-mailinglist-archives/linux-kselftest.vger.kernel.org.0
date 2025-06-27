Return-Path: <linux-kselftest+bounces-35955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048F1AEB1F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 11:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7323864039E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9969293C66;
	Fri, 27 Jun 2025 09:04:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E586293C48;
	Fri, 27 Jun 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015069; cv=none; b=bkbJb3V4wbvE7lpLAz+TaxvOH9tiUC7LDEA4zZ9tJRpJumqF2w7agpXoW8FkRPv28zNDMtIpHKEdpKMReF43Ccr00lJaT4v6nXN9msCTLgTH0LWUVEZOmnhCNTsyE4m2hJHi34Vi4R0lX2GDIudq1hFRXNcsIqweNkVUS8QTPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015069; c=relaxed/simple;
	bh=WK6qQPO9YtNDQ0NAVtBK294K4n0DYb70ujFjHoVezxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbR/J9kUcr9s9gRLw2+N7Q21tyey5mdZur2MevJDKQvvDBCTAvt3pNQeshLmAbfNU7g3sz85RbE3t7xvmAzcNk8XGelFjXC77651N8GHG0+O8kWgeiJCo6aKDLl6Cei55cV6tTxxyGN+FToDQ7KPMZBQeIIpYRxJAQiQM//ZIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FDAA1A00;
	Fri, 27 Jun 2025 02:04:09 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F7633F762;
	Fri, 27 Jun 2025 02:04:23 -0700 (PDT)
Message-ID: <603eb4c7-5570-438c-b747-cdcc67b09ea6@arm.com>
Date: Fri, 27 Jun 2025 10:04:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/22] arm64: Generate sign macro for sysreg Enums
To: Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250626200459.1153955-1-coltonlewis@google.com>
 <20250626200459.1153955-3-coltonlewis@google.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250626200459.1153955-3-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Colton,

On 6/26/25 21:04, Colton Lewis wrote:
> There's no reason Enums shouldn't be equivalent to UnsignedEnums and
> explicitly specify they are unsigned. This will avoid the annoyance I
> had with HPMN0.
An Enum can be annotated with the field's sign by updating it to 
UnsignedEnum or SignedEnum. This is explained in [1].

With this change ID_AA64PFR1_EL1.MTE_frac would be marked as unsigned 
when it should really be considered signed.

Enum	43:40	MTE_frac
	0b0000	ASYNC
	0b1111	NI
EndEnum


> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>   arch/arm64/tools/gen-sysreg.awk | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
> index f2a1732cb1f6..fa21a632d9b7 100755
> --- a/arch/arm64/tools/gen-sysreg.awk
> +++ b/arch/arm64/tools/gen-sysreg.awk
> @@ -308,6 +308,7 @@ $1 == "Enum" && (block_current() == "Sysreg" || block_current() == "SysregFields
>   	parse_bitdef(reg, field, $2)
>   
>   	define_field(reg, field, msb, lsb)
> +	define_field_sign(reg, field, "false")
>   
>   	next
>   }

Thanks,

Ben

[1] 
https://lore.kernel.org/all/20221207-arm64-sysreg-helpers-v4-1-25b6b3fb9d18@kernel.org/


