Return-Path: <linux-kselftest+bounces-20546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA5F9AE974
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 16:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07F21C22600
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9B31E47D8;
	Thu, 24 Oct 2024 14:55:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D629A1E3DE8
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781757; cv=none; b=rqBUuo7dLYiGd6Q7T6J6KAAVki/19SyR7a0j131FqijxuVoYUhVxA+4tzndbyhy5uSAr5EmG/eKmzLd7hFnN47sdDfuP0G2HoBDXrV1RM2Be2k79nMAYMctzeU8Fkej2W6nOxBFHA2MciQn3Y1+4Swk/CaZt3lrBZuP4q/g0e4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781757; c=relaxed/simple;
	bh=t0v/B8kHnRFEsx8v71R/NvclxfOwIwmDVTZbN2JpgyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtIY541PthLlI63o3CNQPXv0udskDgQDs1wXxwgH+bFWsYU+Gp7qdkRRO3nbx8mf7Nz25vksDXzlpSeY7RkcEA+diZddebFumbZSU8n3DE8Tqlbt573KYUH2dPh8PtGH002tz2Um4vlV9kj8xkHsmjDrEdPWwTx0Y5/7PQM4Nlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF329339;
	Thu, 24 Oct 2024 07:56:24 -0700 (PDT)
Received: from [10.44.160.105] (e126510-lin.lund.arm.com [10.44.160.105])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 052A53F528;
	Thu, 24 Oct 2024 07:55:50 -0700 (PDT)
Message-ID: <80688edf-83dd-43c6-a1a8-b69acd30f5c3@arm.com>
Date: Thu, 24 Oct 2024 16:55:48 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com, broonie@kernel.org,
 dave.hansen@linux.intel.com, dave.martin@arm.com, jeffxu@chromium.org,
 joey.gouly@arm.com, pierre.langlois@arm.com, shuah@kernel.org,
 sroettger@google.com, will@kernel.org, linux-kselftest@vger.kernel.org,
 x86@kernel.org
References: <20241023150511.3923558-1-kevin.brodsky@arm.com>
 <20241023150511.3923558-4-kevin.brodsky@arm.com> <ZxoooqtuqTK5CAMR@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ZxoooqtuqTK5CAMR@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/2024 12:59, Catalin Marinas wrote:
> On Wed, Oct 23, 2024 at 04:05:09PM +0100, Kevin Brodsky wrote:
>> +/*
>> + * Save the unpriv access state into ua_state and reset it to disable any
>> + * restrictions.
>> + */
>> +static void save_reset_user_access_state(struct user_access_state *ua_state)
>> +{
>> +	if (system_supports_poe()) {
>> +		/*
>> +		 * Enable all permissions in all 8 keys
>> +		 * (inspired by REPEAT_BYTE())
>> +		 */
>> +		u64 por_enable_all = (~0u / POE_MASK) * POE_RXW;
> I think this should be ~0ul.

It is ~0u on purpose, because unlike in REPEAT_BYTE(), I only wanted the
lower 32 bits to be filled with POE_RXW (we only have 8 keys, the top 32
bits are RES0). That said, given that D128 has 4-bit pkeys, we could
anticipate and fill the top 32 bits too (should make no difference on D64).

>> @@ -907,6 +964,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
>>  {
>>  	struct pt_regs *regs = current_pt_regs();
>>  	struct rt_sigframe __user *frame;
>> +	struct user_access_state ua_state;
>>  
>>  	/* Always make any pending restarted system calls return -EINTR */
>>  	current->restart_block.fn = do_no_restart_syscall;
>> @@ -923,12 +981,14 @@ SYSCALL_DEFINE0(rt_sigreturn)
>>  	if (!access_ok(frame, sizeof (*frame)))
>>  		goto badframe;
>>  
>> -	if (restore_sigframe(regs, frame))
>> +	if (restore_sigframe(regs, frame, &ua_state))
>>  		goto badframe;
>>  
>>  	if (restore_altstack(&frame->uc.uc_stack))
>>  		goto badframe;
>>  
>> +	restore_user_access_state(&ua_state);
>> +
>>  	return regs->regs[0];
>>  
>>  badframe:
> The saving part I'm fine with. For restoring, I was wondering whether we
> can get a more privileged POR_EL0 if reading the frame somehow failed.
> This is largely theoretical, there are other ways to attack like
> writing POR_EL0 directly than unmapping/remapping the signal stack.
>
> What I'd change here is always restore_user_access_state() to
> POR_EL0_INIT. Maybe just initialise ua_state above and add the function
> call after the badframe label.

I'm not sure I understand. When we enter this function, POR_EL0 is set
to whatever the signal handler set it to (POR_EL0_INIT by default).
There are then two cases:
1) Everything succeeds, including reading the saved POR_EL0 from the
frame. We then call restore_user_access_state(), setting POR_EL0 to the
value we've read, and return to userspace.
2) Any uaccess fails (for instance reading POR_EL0). In that case we
leave POR_EL0 unchanged and deliver SIGSEGV.

In case 2 POR_EL0 is most likely already set to POR_EL0_INIT, or
whatever the signal handler set it to. It's not clear to me that forcing
it to POR_EL0_INIT helps much. Either way it's doubtful that the SIGSEGV
handler will be able to recover, since the new signal frame we will
create for it may be a mix of interrupted state and signal handler state
(depending on exactly where we fail).

Kevin

