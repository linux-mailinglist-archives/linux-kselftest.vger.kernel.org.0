Return-Path: <linux-kselftest+bounces-20615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D079AFC76
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 10:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5471F212F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7469D1D0F63;
	Fri, 25 Oct 2024 08:24:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8549C1D0DDE
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844691; cv=none; b=BSnxqsn9Rc/XzVjhJ0CVKQkMNawcgTVaIFpxCiuGiEgIVjWA51kMbaB60NMgjNY4gD/R0drngcJLkhj3vA/LfFlCPGH+VcipL4OWpIMioOVXjLlkvIzuw44q2rodFNlk2KLxrg0X4W3uXqkNvlkN6o8ylfZQCUDYR+BBsBWkvlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844691; c=relaxed/simple;
	bh=I0g7Gf3Gl2TWQ0J0QDsJ/FgKn21iZYDQ+FNzOJmqve0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJERSJi45qO8Wpv9SBAXCRV2J/mqOqWmrllb4/YeK/BG1s4z/iQgrS71YMrYHecxxPTwcC1Bw7FfjI3r5PfoaHzPB/uB12mkjNAyQxzYg7F3wjbMDZc5cseQ5bENWK+welVYWNtUhvk3Af2uApTpwoT5o2wWeKfpulJwUnOQII8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44C32339;
	Fri, 25 Oct 2024 01:25:16 -0700 (PDT)
Received: from [10.57.66.80] (unknown [10.57.66.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4033F3F73B;
	Fri, 25 Oct 2024 01:24:43 -0700 (PDT)
Message-ID: <d7d00ffc-2e92-46cb-95c2-c877723bcb5d@arm.com>
Date: Fri, 25 Oct 2024 10:24:41 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
To: Dave Martin <Dave.Martin@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com, broonie@kernel.org,
 dave.hansen@linux.intel.com, jeffxu@chromium.org, joey.gouly@arm.com,
 pierre.langlois@arm.com, shuah@kernel.org, sroettger@google.com,
 will@kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org
References: <20241023150511.3923558-1-kevin.brodsky@arm.com>
 <20241023150511.3923558-4-kevin.brodsky@arm.com> <ZxoooqtuqTK5CAMR@arm.com>
 <80688edf-83dd-43c6-a1a8-b69acd30f5c3@arm.com> <Zxpq0k3b9q8nWrYa@arm.com>
 <ZxpzexqNIfys3MnJ@e133380.arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ZxpzexqNIfys3MnJ@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/2024 18:19, Dave Martin wrote:
> On Thu, Oct 24, 2024 at 04:42:10PM +0100, Catalin Marinas wrote:
>> On Thu, Oct 24, 2024 at 04:55:48PM +0200, Kevin Brodsky wrote:
>>> On 24/10/2024 12:59, Catalin Marinas wrote:
>>>> On Wed, Oct 23, 2024 at 04:05:09PM +0100, Kevin Brodsky wrote:
>>>>> +/*
>>>>> + * Save the unpriv access state into ua_state and reset it to disable any
>>>>> + * restrictions.
>>>>> + */
>>>>> +static void save_reset_user_access_state(struct user_access_state *ua_state)
>>>>> +{
>>>>> +	if (system_supports_poe()) {
>>>>> +		/*
>>>>> +		 * Enable all permissions in all 8 keys
>>>>> +		 * (inspired by REPEAT_BYTE())
>>>>> +		 */
>>>>> +		u64 por_enable_all = (~0u / POE_MASK) * POE_RXW;
>>>> I think this should be ~0ul.
>>> It is ~0u on purpose, because unlike in REPEAT_BYTE(), I only wanted the
>>> lower 32 bits to be filled with POE_RXW (we only have 8 keys, the top 32
>>> bits are RES0). That said, given that D128 has 4-bit pkeys, we could
>>> anticipate and fill the top 32 bits too (should make no difference on D64).
>> I guess we could leave it as 32-bit for now and remember to update it
>> when we enable more keys with D128. Setting the top RES0 bits doesn't
>> hurt either since they are already documented in the Arm ARM. Up to you,
>> it's fine like above as well.
> Can we maybe just have a brute-force loop that constructs the value
> using the appropriate #define macros?
>
> The compiler will const-fold it; I'd be prepared to bet that the
> generated code would be identical...

Fine by me, I suppose I was too eager to use the one-liner I had found
:) Building that value based on arch_max_pkey() is probably a better
idea in the long run. (And indeed the codegen is the same, it boils down
to a mov w0, #0x77777777 in both case.)

>>>>> @@ -907,6 +964,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
>>>>>  {
>>>>>  	struct pt_regs *regs = current_pt_regs();
>>>>>  	struct rt_sigframe __user *frame;
>>>>> +	struct user_access_state ua_state;
>>>>>  
>>>>>  	/* Always make any pending restarted system calls return -EINTR */
>>>>>  	current->restart_block.fn = do_no_restart_syscall;
>>>>> @@ -923,12 +981,14 @@ SYSCALL_DEFINE0(rt_sigreturn)
>>>>>  	if (!access_ok(frame, sizeof (*frame)))
>>>>>  		goto badframe;
>>>>>  
>>>>> -	if (restore_sigframe(regs, frame))
>>>>> +	if (restore_sigframe(regs, frame, &ua_state))
>>>>>  		goto badframe;
>>>>>  
>>>>>  	if (restore_altstack(&frame->uc.uc_stack))
>>>>>  		goto badframe;
>>>>>  
>>>>> +	restore_user_access_state(&ua_state);
>>>>> +
>>>>>  	return regs->regs[0];
>>>>>  
>>>>>  badframe:
>>>> The saving part I'm fine with. For restoring, I was wondering whether we
>>>> can get a more privileged POR_EL0 if reading the frame somehow failed.
>>>> This is largely theoretical, there are other ways to attack like
>>>> writing POR_EL0 directly than unmapping/remapping the signal stack.
>>>>
>>>> What I'd change here is always restore_user_access_state() to
>>>> POR_EL0_INIT. Maybe just initialise ua_state above and add the function
>>>> call after the badframe label.
>>> I'm not sure I understand. When we enter this function, POR_EL0 is set
>>> to whatever the signal handler set it to (POR_EL0_INIT by default).
>>> There are then two cases:
>>> 1) Everything succeeds, including reading the saved POR_EL0 from the
>>> frame. We then call restore_user_access_state(), setting POR_EL0 to the
>>> value we've read, and return to userspace.
>>> 2) Any uaccess fails (for instance reading POR_EL0). In that case we
>>> leave POR_EL0 unchanged and deliver SIGSEGV.
>>>
>>> In case 2 POR_EL0 is most likely already set to POR_EL0_INIT, or
>>> whatever the signal handler set it to. It's not clear to me that forcing
>>> it to POR_EL0_INIT helps much. Either way it's doubtful that the SIGSEGV
>>> handler will be able to recover, since the new signal frame we will
>>> create for it may be a mix of interrupted state and signal handler state
>>> (depending on exactly where we fail).
>> If the SIGSEGV delivery succeeds, returning would restore the POR_EL0
>> set up by the previous signal handler, potentially more privileged. Does
>> it matter? Can it return all the way to the original context?

What we store into the signal frame when delivering that SIGSEGV is a
mixture of the original state (up to the point of failure) and the
signal handler's state (what we couldn't restore). It's hard to reason
about how that SIGSEGV handler could possibly handle this, but in any
case it would have to massage its signal frame so that the next
sigreturn does the right thing. Restoring only part of the frame records
is bound to cause trouble and that's true for POR_EL0 as well - I doubt
there's much value in special-casing it.

>
> That seems a valid concern.
>
> It looks a bit like we don't back out the temporary change to POR_EL0
> if writing the sigframe fails, so the temporary "allow all" perms might
> get saved out into the SIGSEGV sigframe on the alternate signal
> stack, and will then be restored as the user thread's POR_EL0 when the
> SIGSEGV returns.

It sounds like you're referring to the delivery case, not the return
case. In the delivery case (setup_rt_frame()), the "allow all" value
will never be saved into the sigframe because we call
restore_user_access_state() if anything failed (this is new in v2,
exactly to prevent that scenario).

Kevin

