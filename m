Return-Path: <linux-kselftest+bounces-21200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE89B7893
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 11:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89FFB2166B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 10:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30F31991B8;
	Thu, 31 Oct 2024 10:24:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A871990AE
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370247; cv=none; b=o5Y8l55EAKDyLydwhw2K/uA8uhP2oYdS6eDcUNRrcXk6h9OVgusai250e1XTKt3xoITBOuJo1W5rS6hQ/K3d36fWLNsxqzKeLIGsxNHmnpNAs9AfJ837KoOruovmckV0ZK9PhlRAsfdX3m/eHRI8IFP0KHceww/W3u95dRkVm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370247; c=relaxed/simple;
	bh=WGwgulIeVkzfuOBB7hoqiglT9ZFqECeOoLgg8dNBXbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQoj7JjFokWF/ggACeEnJl2dDrrMmIYPJBpaF/rU4sFwLgaEFQHLDEVQherDpsDfH6XasWPWzSftf1aLEehGxQy28Q5LwJ+G6EYnciQmXvjQbLQ/rygfHe67Qb2B65HbSkuSa4scm8tWo6B7ZsRN41VksC1PO4L4TW2mg9Z8FUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D4451063;
	Thu, 31 Oct 2024 03:24:33 -0700 (PDT)
Received: from [10.44.160.105] (e126510-lin.lund.arm.com [10.44.160.105])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC8673F73B;
	Thu, 31 Oct 2024 03:23:58 -0700 (PDT)
Message-ID: <a3cd71dc-8d83-4c59-a56a-07ed1720473b@arm.com>
Date: Thu, 31 Oct 2024 11:23:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
To: Will Deacon <will@kernel.org>, Jeff Xu <jeffxu@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com, broonie@kernel.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, Dave.Martin@arm.com,
 joey.gouly@arm.com, keith.lucas@oracle.com, pierre.langlois@arm.com,
 shuah@kernel.org, sroettger@google.com, tglx@linutronix.de,
 yury.khrustalev@arm.com, linux-kselftest@vger.kernel.org, x86@kernel.org,
 Kees Cook <keescook@chromium.org>,
 Jorge Lucangeli Obes <jorgelo@chromium.org>, Jann Horn <jannh@google.com>
References: <20241029144539.111155-1-kevin.brodsky@arm.com>
 <20241029144539.111155-2-kevin.brodsky@arm.com>
 <CABi2SkUTSuk_PS9==_czM=64FGWK_5DyUe5QELxiFHtPFsKaHw@mail.gmail.com>
 <20241031093355.GA7008@willie-the-truck>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241031093355.GA7008@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/10/2024 10:33, Will Deacon wrote:
> Hi Jeff,
>
> Thanks for chiming in!
>
> On Wed, Oct 30, 2024 at 03:01:53PM -0700, Jeff Xu wrote:
>> On Tue, Oct 29, 2024 at 7:46 AM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>>> TL;DR: reset POR_EL0 to "allow all" before writing the signal frame,
>>> preventing spurious uaccess failures.
> [...]
>
>>> @@ -924,12 +982,14 @@ SYSCALL_DEFINE0(rt_sigreturn)
>>>         if (!access_ok(frame, sizeof (*frame)))
>>>                 goto badframe;
>>>
>>> -       if (restore_sigframe(regs, frame))
>>> +       if (restore_sigframe(regs, frame, &ua_state))
>>>                 goto badframe;
>>>
>>>         if (restore_altstack(&frame->uc.uc_stack))
>>>                 goto badframe;
>>>
>> Do you need to move restore_altstack ahead of restore_sigframe?
>> similar as x86 change [1],
>> the discussion for this  happened  in [2] [3]
>>
>> [1] https://lore.kernel.org/lkml/20240802061318.2140081-5-aruna.ramakrishna@oracle.com/
>> [2] https://lore.kernel.org/lkml/20240425210540.3265342-1-jeffxu@chromium.org/
>> [3] https://lore.kernel.org/lkml/d0162c76c25bc8e1c876aebe8e243ff2e6862359.camel@intel.com/
>>
>>> +       restore_user_access_state(&ua_state);
> The POR isn't restored until here ^^^, so I _think_ restore_altstack()
> is fine where it is. Kevin, can you confirm, please?

Yes, that's correct, see my earlier reply [1].

- Kevin

[1]
https://lore.kernel.org/all/cd0e114d-57eb-4c90-bb6f-9abf0cc8920f@arm.com/

