Return-Path: <linux-kselftest+bounces-34636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF985AD4999
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 05:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CED8189CC30
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 03:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC681B87F2;
	Wed, 11 Jun 2025 03:45:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED16C8FE;
	Wed, 11 Jun 2025 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613520; cv=none; b=o3oK53h+rQtS/BVOeEkeIXUtddLxvQ0oxginv20ABf2w6ql3KW6af2/AjNfvSUW83JkWNbAcXt+ppWXcXGnYCVArGc/IKLEDSia/RZmDtAfPw6chWDFq5R/D2ztm9REQYU18vpHmrEeKao+4bUpV9RGUpC+CoFgjKVTtg28M7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613520; c=relaxed/simple;
	bh=yxPpEZKRlcPhVzBirYEswfS6uV977vjcwVzBZWkAgF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+eMkzMkZ2yDpaANtKH8Dkbp3IOcRsBTiZ+ziGZwGPBSIfEcHSSfE0ORNnpm0Mxm4Z8Ab+UNGRBATE89WbX8m2Akwti5j1VaklrF1zNT+s2q7okQrQuW+3kNK7hKI0D+WsP3rorVzJnUwTl12+as9LwmIm38nq+vNnwul1Yt+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59E1B168F;
	Tue, 10 Jun 2025 20:44:58 -0700 (PDT)
Received: from [10.164.146.17] (J09HK2D2RT.blr.arm.com [10.164.146.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC1563F66E;
	Tue, 10 Jun 2025 20:45:13 -0700 (PDT)
Message-ID: <9b378582-44eb-4fbb-a03a-40eb317daebd@arm.com>
Date: Wed, 11 Jun 2025 09:15:10 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] KVM: selftests: Change MDSCR_EL1 register holding
 variables as uint64_t
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>, linux-kernel@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 kvm@vger.kernel.org, kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
References: <20250610053128.4118784-1-anshuman.khandual@arm.com>
 <20250610053128.4118784-3-anshuman.khandual@arm.com>
 <864iwnedjk.wl-maz@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <864iwnedjk.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/06/25 10:31 PM, Marc Zyngier wrote:
> On Tue, 10 Jun 2025 06:31:28 +0100,
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>> Change MDSCR_EL1 register holding local variables as uint64_t that reflects
>> its true register width as well.
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Oliver Upton <oliver.upton@linux.dev>
>> Cc: Joey Gouly <joey.gouly@arm.com>
>> Cc: kvm@vger.kernel.org
>> Cc: kvmarm@lists.linux.dev
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  tools/testing/selftests/kvm/arm64/debug-exceptions.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/arm64/debug-exceptions.c b/tools/testing/selftests/kvm/arm64/debug-exceptions.c
>> index c7fb55c9135b..e34963956fbc 100644
>> --- a/tools/testing/selftests/kvm/arm64/debug-exceptions.c
>> +++ b/tools/testing/selftests/kvm/arm64/debug-exceptions.c
>> @@ -140,7 +140,7 @@ static void enable_os_lock(void)
>>  
>>  static void enable_monitor_debug_exceptions(void)
>>  {
>> -	uint32_t mdscr;
>> +	uint64_t mdscr;
>>  
>>  	asm volatile("msr daifclr, #8");
>>  
>> @@ -223,7 +223,7 @@ void install_hw_bp_ctx(uint8_t addr_bp, uint8_t ctx_bp, uint64_t addr,
>>  
>>  static void install_ss(void)
>>  {
>> -	uint32_t mdscr;
>> +	uint64_t mdscr;
>>  
>>  	asm volatile("msr daifclr, #8");
>>  
> 
> Why change this in the place that matters *the least*?
> 
> arch/arm64/kernel/debug-monitors.c is full of 32bit manipulation of
> this register, and that's only one example of it. So if you are going
> to change this, please do it fully, not as a random change in a random
> file.

The first patch in this series changes mdscr system register to 64 bit
in the mentioned file (i.e arch/arm64/kernel/debug-monitors.c). 

> 
> Thanks,
> 
> 	M.
> 


