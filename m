Return-Path: <linux-kselftest+bounces-20675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F309B0869
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 17:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192441F2454D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8707115C14F;
	Fri, 25 Oct 2024 15:34:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C11021A4AB
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870474; cv=none; b=rk7HtvU43noXwt2EuBg9D/2yfVPjIyYlML5M5QukXqiqvBz/nAwY1qVXNSdf1szXzCjv84SVm6BtPhJc21JhyG6X9wQtwo5Wqpdf8CGDWCAE/9TNLvRGiMSXfhhdmPOdceP09r8wjDFVgRTIZoMqfKLzy5whOW14T5JVI64F/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870474; c=relaxed/simple;
	bh=n7H28eACAwi/fkeakhgUWuR5cTMnwAQmwvRwrEAqh84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Df+WAnYJ+4L7iz2yA9P2WlH2o9svbuBDm/PPndlTc0Ltz3ME7rmnqsrcmGxDppLLZ3nZH1GuI/Bb8mIHvecr8nGQVyBrudmZgsNqyj0dARu5ykAGL1PeMlcA5uqKQiC6CfpLqFSJRIGlFIspLzPRVZz8x0EiPUjtmKN4jCt26bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EC87339;
	Fri, 25 Oct 2024 08:35:00 -0700 (PDT)
Received: from [10.57.66.80] (unknown [10.57.66.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BA573F73B;
	Fri, 25 Oct 2024 08:34:26 -0700 (PDT)
Message-ID: <f2bef169-6ca4-4715-89bf-3680e8ea6153@arm.com>
Date: Fri, 25 Oct 2024 17:34:24 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com, broonie@kernel.org,
 dave.hansen@linux.intel.com, jeffxu@chromium.org, joey.gouly@arm.com,
 pierre.langlois@arm.com, shuah@kernel.org, sroettger@google.com,
 will@kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org
References: <20241023150511.3923558-1-kevin.brodsky@arm.com>
 <20241023150511.3923558-4-kevin.brodsky@arm.com> <ZxoooqtuqTK5CAMR@arm.com>
 <80688edf-83dd-43c6-a1a8-b69acd30f5c3@arm.com> <Zxpq0k3b9q8nWrYa@arm.com>
 <ZxpzexqNIfys3MnJ@e133380.arm.com>
 <d7d00ffc-2e92-46cb-95c2-c877723bcb5d@arm.com>
 <ZxuB/M7qMDPtLRuk@e133380.arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ZxuB/M7qMDPtLRuk@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/10/2024 13:33, Dave Martin wrote:
> On Fri, Oct 25, 2024 at 10:24:41AM +0200, Kevin Brodsky wrote:
>>>>>>> @@ -907,6 +964,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
>>>>>>>  {
>>>>>>>  	struct pt_regs *regs = current_pt_regs();
>>>>>>>  	struct rt_sigframe __user *frame;
>>>>>>> +	struct user_access_state ua_state;
>>>>>>>  
>>>>>>>  	/* Always make any pending restarted system calls return -EINTR */
>>>>>>>  	current->restart_block.fn = do_no_restart_syscall;
>>>>>>> @@ -923,12 +981,14 @@ SYSCALL_DEFINE0(rt_sigreturn)
>>>>>>>  	if (!access_ok(frame, sizeof (*frame)))
>>>>>>>  		goto badframe;
>>>>>>>  
>>>>>>> -	if (restore_sigframe(regs, frame))
>>>>>>> +	if (restore_sigframe(regs, frame, &ua_state))
>>>>>>>  		goto badframe;
>>>>>>>  
>>>>>>>  	if (restore_altstack(&frame->uc.uc_stack))
>>>>>>>  		goto badframe;
>>>>>>>  
>>>>>>> +	restore_user_access_state(&ua_state);
>>>>>>> +
>>>>>>>  	return regs->regs[0];
>>>>>>>  
>>>>>>>  badframe:
>>>>>> The saving part I'm fine with. For restoring, I was wondering whether we
>>>>>> can get a more privileged POR_EL0 if reading the frame somehow failed.
>>>>>> This is largely theoretical, there are other ways to attack like
>>>>>> writing POR_EL0 directly than unmapping/remapping the signal stack.
>>>>>>
>>>>>> What I'd change here is always restore_user_access_state() to
>>>>>> POR_EL0_INIT. Maybe just initialise ua_state above and add the function
>>>>>> call after the badframe label.
>>>>> I'm not sure I understand. When we enter this function, POR_EL0 is set
>>>>> to whatever the signal handler set it to (POR_EL0_INIT by default).
>>>>> There are then two cases:
>>>>> 1) Everything succeeds, including reading the saved POR_EL0 from the
>>>>> frame. We then call restore_user_access_state(), setting POR_EL0 to the
>>>>> value we've read, and return to userspace.
>>>>> 2) Any uaccess fails (for instance reading POR_EL0). In that case we
>>>>> leave POR_EL0 unchanged and deliver SIGSEGV.
>>>>>
>>>>> In case 2 POR_EL0 is most likely already set to POR_EL0_INIT, or
>>>>> whatever the signal handler set it to. It's not clear to me that forcing
>>>>> it to POR_EL0_INIT helps much. Either way it's doubtful that the SIGSEGV
>>>>> handler will be able to recover, since the new signal frame we will
>>>>> create for it may be a mix of interrupted state and signal handler state
>>>>> (depending on exactly where we fail).
>>>> If the SIGSEGV delivery succeeds, returning would restore the POR_EL0
>>>> set up by the previous signal handler, potentially more privileged. Does
>>>> it matter? Can it return all the way to the original context?
>> What we store into the signal frame when delivering that SIGSEGV is a
>> mixture of the original state (up to the point of failure) and the
>> signal handler's state (what we couldn't restore). It's hard to reason
>> about how that SIGSEGV handler could possibly handle this, but in any
>> case it would have to massage its signal frame so that the next
>> sigreturn does the right thing. Restoring only part of the frame records
>> is bound to cause trouble and that's true for POR_EL0 as well - I doubt
>> there's much value in special-casing it.
> This feels like a simplification?
>
> We can leave a mix of restored and unrestored state when generating the
> SIGSEGV signal frame, providing that those changes will make no
> difference when the rt_sigreturn is replayed.

I'm not sure I understand what this means. If the SIGSEGV handler were
to sigreturn without touching its signal frame, things are likely to
explode: it may be returning to the point where the original handler
called sigreturn, for instance (if the first uaccess failed during that
sigreturn call).

> POR_EL0 will make a difference, though.
>
> The POR_EL0 image in the SIGSEGV signal frame needs be the same value
> that caused the original rt_sigreturn to barf (if this is what caused
> the barf).  It should be up to the SIGSEGV handler to decide what (if
> anything) to do about that.  The kernel can't know what userspace
> intended.

Unless I'm missing something this is exactly what happens now: what we
store in the SIGSEGV frame is the POR_EL0 value the original handler was
using.

> Note that for this to work, the SIGSEGV stack (whether main or
> alternate) must be accessible with POR_EL0_INIT permissions, or the
> SIGSEGV handler must start with a (gross) asm shim to establish a
> usable POR_EL0.  But that's not really our problem here.

This is indeed orthogonal - the SIGSEGV handler will be run with
POR_EL0_INIT, like any other handler. The value we store in the frame is
unrelated.

> (I'm not saying that the kernel necessarily fails to do this -- I
> haven't checked -- but just trying to understand the problem here.)
>
>
> The actual problem here is that if the SIGSEGV handler wants to bail
> out with a siglongjmp(), there is no way to determine the correct value
> of POR_EL0 to restore.

Correct, but again this is true of any other record - for instance TPIDR2.

> I wonder whether POR_EL0 should be saved in sigjmp_buf (depending on
> whether sigjmp_buf is horribly inextensible and also full up, or merely
> horribly inextensible).

It very much feels that this is the case - if a handler relies on
longjmp() or setcontext() to restore a known state, then POR_EL0 should
be part of that state.

>
> Does anyone know whether PKRU in sigjmp_buf on x86?

I can't say for sure but I don't see PKRU being handled in
setjmp/longjmp in glibc at least.

Kevin

