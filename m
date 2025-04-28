Return-Path: <linux-kselftest+bounces-31764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB4BA9EF0E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 13:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376BD7A40B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 11:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB6926562B;
	Mon, 28 Apr 2025 11:26:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397A62641DE
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839611; cv=none; b=RrTrFL3I9w+Xg/1HX+B3uJwOU2KI5wNdIp8QhR9Vi5AS/45mHdQhsXSvA4iN4UNrM7O9vgM+j+3+1LDYU/37Lb63xgH6DAu+RmkSNnVfO9ruean0+03qM2gfsyv5tTxlnNzSM38F2YnJFSy0+N0VB4QN1jTIz6kKCClpDx1CKpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839611; c=relaxed/simple;
	bh=O9SIO+O4YfF78ixDd98wXc/IQFIu5PJ8TjGSSZQt4nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLf4f3PRTYQK5OH/bUIpPtRDM0wo+y4N7xxcdvglDaDEBmLqBXfeRF/AjCxOni7iv5txMIFYfd7hERWEVCnzcQwr/7+MMhUimdEr3kdJzlsTmV8rUct5p0/kAlHoHkjBEbKLVWFY0NlsJ3X0HERDKICscMr5R/yPKUV+pJ9iqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF09C1516;
	Mon, 28 Apr 2025 04:26:42 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC3053F673;
	Mon, 28 Apr 2025 04:26:47 -0700 (PDT)
Message-ID: <f44eabb4-9b5e-479b-b78b-e9c918b3798c@arm.com>
Date: Mon, 28 Apr 2025 12:26:46 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] KVM: arm64: Make MTE_frac masking conditional on
 MTE capability
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, shuah@kernel.org
References: <20250414124059.1938303-1-ben.horgan@arm.com>
 <20250414124059.1938303-3-ben.horgan@arm.com> <86bjshjz5x.wl-maz@kernel.org>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <86bjshjz5x.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

On 4/27/25 18:24, Marc Zyngier wrote:
> On Mon, 14 Apr 2025 13:40:58 +0100,
> Ben Horgan <ben.horgan@arm.com> wrote:
>> [...]
>> +	/*
>> +	 * Previously MTE_frac was hidden from guest. However, if the
>> +	 * hardware supports MTE2 but not MTE_ASYM_FAULT then a value
>> +	 * of 0 for this field indicates that the hardware supports
>> +	 * MTE_ASYNC. Whereas, 0xf indicates MTE_ASYNC is not supported.
>> +	 *
>> +	 * As KVM must accept values from KVM provided by user-space,
>> +	 * when ID_AA64PFR1_EL1.MTE is 2 allow user-space to set
>> +	 * ID_AA64PFR1_EL1.MTE_frac to 0. However, ignore it to avoid
>> +	 * incorrectly claiming hardware support for MTE_ASYNC in the
>> +	 * guest.
>> +	 */
>> +
>> +	if (mte == ID_AA64PFR1_EL1_MTE_MTE2 &&
> 
> The spec says that MTE_frac is valid if ID_AA64PFR1_EL1.MTE >= 0b0010.
> Not strictly equal to 0b0010 (which represents MTE2). Crucially, MTE3
> should receive the same treatment.

This is specific to MTE2 as when MTE3 is supported MTE_ASYM_FAULT is 
also supported and when MTE_ASYM_FAULT is supported the spec says 
MTE_frac is 0.
> 
>> +	    user_mte_frac == ID_AA64PFR1_EL1_MTE_frac_ASYNC) {
>> +		user_val &= ~ID_AA64PFR1_EL1_MTE_frac_MASK;
>> +		user_val |= hw_val & ID_AA64PFR1_EL1_MTE_frac_MASK;
> 
> This means you are unconditionally propagating what the HW supports,
> which feels dodgy, specially considering that we don't know how
> MTE_frac is going to evolve in the future.
> 
> I think you should limit the fix to the exact case we're mitigating
> here, not blindly overwrite the guest's view with the HW's capability.

Sure, better safe than sorry. I can update the if condition to the below.

u8 hw_mte_frac = SYS_FIELD_GET(ID_AA64PFR1_EL1, MTE_frac, hw_val);
...
if (mte == ID_AA64PFR1_EL1_MTE_MTE2 &&
     hw_mte_frac == ID_AA64PFR1_EL1_MTE_frac_NI &&
     user_mte_frac == ID_AA64PFR1_EL1_MTE_frac_ASYNC)

> 
> Thanks,
> 
> 	M.
> 

Thanks,

Ben


