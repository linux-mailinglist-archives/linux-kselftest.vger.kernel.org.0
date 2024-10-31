Return-Path: <linux-kselftest+bounces-21194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED329B76B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 09:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804541C20B50
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 08:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316CA146019;
	Thu, 31 Oct 2024 08:45:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E5C8F5C
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364341; cv=none; b=BxbrLD/0Vd0+KAYCtzbxuGn9M/tHal4MHW/9XtGcfun/Y9pI81THEJl7Gf9Gg77D/E1moBnc7Vl8gzVik61OjEuQTOl1Pt5kSFkSTM3quvmKA39dId4mbcAH7XK5ajZN8oWQAC4L1fJ9AM4jKZiPflU6yT1lbtkxOdfYvzmMUlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364341; c=relaxed/simple;
	bh=bEha7Wd8bJH1xj75gUraLExnoFmVXfcjeOzjOkGNOqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2wcaFwU7sly8gyNqjvYITrRFAOJ5wXQtSEZGlzRWsB6Ooe27dhvdfcNoP0oFQkhm4eFPoVrNSBaFJz6X6IMyKUP+svi0WkhjhsUk2gMxkuJ38WR9bAk46HX3JyCHRV1RO/YHxcFwVV0OJFauf4sTpZ5zO2cLWXbKAi3QGzoKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95EDB1063;
	Thu, 31 Oct 2024 01:46:06 -0700 (PDT)
Received: from [10.57.66.133] (unknown [10.57.66.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 138CE3F66E;
	Thu, 31 Oct 2024 01:45:31 -0700 (PDT)
Message-ID: <cd0e114d-57eb-4c90-bb6f-9abf0cc8920f@arm.com>
Date: Thu, 31 Oct 2024 09:45:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
To: Jeff Xu <jeffxu@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com, broonie@kernel.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, Dave.Martin@arm.com,
 joey.gouly@arm.com, keith.lucas@oracle.com, pierre.langlois@arm.com,
 shuah@kernel.org, sroettger@google.com, tglx@linutronix.de, will@kernel.org,
 yury.khrustalev@arm.com, linux-kselftest@vger.kernel.org, x86@kernel.org,
 Kees Cook <keescook@chromium.org>,
 Jorge Lucangeli Obes <jorgelo@chromium.org>, Jann Horn <jannh@google.com>
References: <20241029144539.111155-1-kevin.brodsky@arm.com>
 <20241029144539.111155-2-kevin.brodsky@arm.com>
 <CABi2SkUTSuk_PS9==_czM=64FGWK_5DyUe5QELxiFHtPFsKaHw@mail.gmail.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <CABi2SkUTSuk_PS9==_czM=64FGWK_5DyUe5QELxiFHtPFsKaHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 23:01, Jeff Xu wrote:
>> -static int restore_poe_context(struct user_ctxs *user)
>> +static int restore_poe_context(struct user_ctxs *user,
>> +                              struct user_access_state *ua_state)
>>  {
>>         u64 por_el0;
>>         int err = 0;
>> @@ -282,7 +338,7 @@ static int restore_poe_context(struct user_ctxs *user)
>>
>>         __get_user_error(por_el0, &(user->poe->por_el0), err);
>>         if (!err)
>> -               write_sysreg_s(por_el0, SYS_POR_EL0);
>> +               ua_state->por_el0 = por_el0;
>>
>>         return err;
>>  }
>> @@ -850,7 +906,8 @@ static int parse_user_sigframe(struct user_ctxs *user,
>>  }
>>
>>  static int restore_sigframe(struct pt_regs *regs,
>> -                           struct rt_sigframe __user *sf)
>> +                           struct rt_sigframe __user *sf,
>> +                           struct user_access_state *ua_state)
>>  {
>>         sigset_t set;
>>         int i, err;
>> @@ -899,7 +956,7 @@ static int restore_sigframe(struct pt_regs *regs,
>>                 err = restore_zt_context(&user);
>>
>>         if (err == 0 && system_supports_poe() && user.poe)
>> -               err = restore_poe_context(&user);
>> +               err = restore_poe_context(&user, ua_state);
>>
>>         return err;
>>  }
>> @@ -908,6 +965,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
>>  {
>>         struct pt_regs *regs = current_pt_regs();
>>         struct rt_sigframe __user *frame;
>> +       struct user_access_state ua_state;
>>
>>         /* Always make any pending restarted system calls return -EINTR */
>>         current->restart_block.fn = do_no_restart_syscall;
>> @@ -924,12 +982,14 @@ SYSCALL_DEFINE0(rt_sigreturn)
>>         if (!access_ok(frame, sizeof (*frame)))
>>                 goto badframe;
>>
>> -       if (restore_sigframe(regs, frame))
>> +       if (restore_sigframe(regs, frame, &ua_state))
>>                 goto badframe;
>>
>>         if (restore_altstack(&frame->uc.uc_stack))
>>                 goto badframe;
>>
> Do you need to move restore_altstack ahead of restore_sigframe?

This is not necessary because restore_sigframe() no longer writes to
POR_EL0. restore_poe_context() (above) now saves the original POR_EL0
value into ua_state, and it is restore_user_access_state() (called below
just before returning to userspace) that actually writes to POR_EL0,
after all uaccess is completed.

Having said that, I somehow missed the call to restore_altstack() when
writing the commit message, so these changes in sys_rt_sigreturn are in
fact necessary. Good catch! At least the patch itself should be doing
the right thing.

- Kevin

> similar as x86 change [1],
> the discussion for this  happened  in [2] [3]
>
> [1] https://lore.kernel.org/lkml/20240802061318.2140081-5-aruna.ramakrishna@oracle.com/
> [2] https://lore.kernel.org/lkml/20240425210540.3265342-1-jeffxu@chromium.org/
> [3] https://lore.kernel.org/lkml/d0162c76c25bc8e1c876aebe8e243ff2e6862359.camel@intel.com/
>
> Thanks
> -Jeff
>
>
>> +       restore_user_access_state(&ua_state);
>> +
>>         return regs->regs[0];


