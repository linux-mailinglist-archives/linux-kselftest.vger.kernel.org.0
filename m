Return-Path: <linux-kselftest+bounces-20247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2A39A617F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 12:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1B11C25322
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A151E4929;
	Mon, 21 Oct 2024 10:06:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929161E0087
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505177; cv=none; b=OJU/Fqbu3PfddO02rI0YKmwQQLTVG9wHVmdd2ogjb9XXdKmKmaUDs+RzM2aBM/jluGrxA431503nKk5MJFlYHDhzzTHHa7G+/9bdOMfxN3gStDalTg0VK69qxmRoypa8i851ek166anDOFZ21dCfJT9LZrZr0ooaMER2adOmdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505177; c=relaxed/simple;
	bh=TmgUSCbYLK4N3zEEng+XB7JrRwqIkvClbDPnoim+FKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQlmF4QkqMkZtFpyFz8Hgj2xJtLteHaEm3sKNl9TH0CJbHszUmNxOkh70sik/Axw9aenkdbcgzf+kzdgNRICXpq4ax+8vTWfOwrpsdl8bvRaxn7/MaRGcWI+MMXfBh7OdJ12601ZDQazgvk0d99fUQlRBA0h7ZxijRj8M7OgtN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 812CEDA7;
	Mon, 21 Oct 2024 03:06:44 -0700 (PDT)
Received: from [10.57.65.82] (unknown [10.57.65.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 477263F73B;
	Mon, 21 Oct 2024 03:06:10 -0700 (PDT)
Message-ID: <cf75979b-b94f-46cf-a8d0-37e5843a0d29@arm.com>
Date: Mon, 21 Oct 2024 12:06:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com, broonie@kernel.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, jeffxu@chromium.org,
 joey.gouly@arm.com, shuah@kernel.org, will@kernel.org,
 linux-kselftest@vger.kernel.org, x86@kernel.org
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <20241017133909.3837547-4-kevin.brodsky@arm.com>
 <ZxEzAzmlIG66ZPVn@e133380.arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ZxEzAzmlIG66ZPVn@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2024 17:53, Dave Martin wrote:
> [...]
>> +/*
>> + * Save the unpriv access state into ua_state and reset it to disable any
>> + * restrictions.
>> + */
>> +static void save_reset_unpriv_access_state(struct unpriv_access_state *ua_state)
> Would _user_ be more consistent naming than _unpriv_ ?

I did ponder on the naming. I considered user_access/uaccess instead of
unpriv_access, but my concern is that it might imply that only uaccess
is concerned, while in reality loads/stores that userspace itself
executes are impacted too. I thought using the "unpriv" terminology from
the Arm ARM (used for stage 1 permissions) might avoid such
misunderstanding. I'm interested to hear opinions on this, maybe
accuracy sacrifices readability.

> Same elsewhere.
>
>> +{
>> +	if (system_supports_poe()) {
>> +		/*
>> +		 * Enable all permissions in all 8 keys
>> +		 * (inspired by REPEAT_BYTE())
>> +		 */
>> +		u64 por_enable_all = (~0u / POE_MASK) * POE_RXW;
> Yikes!
>
> Seriously though, why are we granting permissions that the signal
> handler isn't itself going to have over its own stack?
>
> I think the logical thing to do is to think of the write/read of the
> signal frame as being done on behalf of the signal handler, so the
> permissions should be those we're going to give the signal handler:
> not less, and (so far as we can approximate) not more.

Will continue that discussion on the cover letter.

>
>> +
>> +		ua_state->por_el0 = read_sysreg_s(SYS_POR_EL0);
>> +		write_sysreg_s(por_enable_all, SYS_POR_EL0);
>> +		/* Ensure that any subsequent uaccess observes the updated value */
>> +		isb();
>> +	}
>> +}
>> +
>> +/*
>> + * Set the unpriv access state for invoking the signal handler.
>> + *
>> + * No uaccess should be done after that function is called.
>> + */
>> +static void set_handler_unpriv_access_state(void)
>> +{
>> +	if (system_supports_poe())
>> +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
>> +
> Spurious blank line?

Thanks!

>> +}
> [...]
>
>> @@ -1252,9 +1310,11 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
>>  {
>>  	struct rt_sigframe_user_layout user;
>>  	struct rt_sigframe __user *frame;
>> +	struct unpriv_access_state ua_state;
>>  	int err = 0;
>>  
>>  	fpsimd_signal_preserve_current_state();
>> +	save_reset_unpriv_access_state(&ua_state);
> (Trivial nit: maybe put the blank line before this rather than after?
> This has nothing to do with "settling" the kernel's internal context
> switch state, and a lot to do with generaing the signal frame...)

In fact considering the concern Catalin brought up with POR_EL0 being
reset even when we fail to deliver the signal [1], I'm realising this
call should be moved after get_sigframe(), since the latter doesn't use
uaccess and can fail.

[1] https://lore.kernel.org/linux-arm-kernel/Zw6D2waVyIwYE7wd@arm.com/

>>  
>>  	if (get_sigframe(&user, ksig, regs))
>>  		return 1;
> [...]
>
>> @@ -1273,6 +1333,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
>>  			regs->regs[1] = (unsigned long)&frame->info;
>>  			regs->regs[2] = (unsigned long)&frame->uc;
>>  		}
>> +		set_handler_unpriv_access_state();
> This bit feels prematurely factored?  We don't have separate functions
> for the other low-level preparation done here...

I preferred to have a consistent API for all manipulations of POR_EL0,
the idea being that if more registers are added to struct
unpriv_access_state, only the *unpriv_access* helpers need to be amended.

> It works either way though, and I don't have a strong view.
>
> Overall, this all looks reasonable.

Thanks for the review!

Kevin

