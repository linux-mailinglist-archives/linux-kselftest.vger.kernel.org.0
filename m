Return-Path: <linux-kselftest+bounces-45896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C1C6AEFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B9653A87CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F6A31ED65;
	Tue, 18 Nov 2025 17:13:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE331ED6D;
	Tue, 18 Nov 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486039; cv=none; b=lhMZ1d8JDTgKarArnPGSrAg38VwjUZQATsHxEySFnt0WKOVTg5KUzkxSHgRxrhve7UaDW3roVEIQolVvvCcxv695YZV2O7tM8tyJiPsC4e/6UEyuAXfTDUtHfcnEoawV9YpXKrJ3JjbSedlEgCWvKtjcQcfdEqWSLBMELLjZUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486039; c=relaxed/simple;
	bh=gvha+EHC4vVKf0FqABBk3VOEMuSrMGzpWVe4YM7bQbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ewiK9kY2nHYOzGEjOEoQ4WU8Lx3L84ICni1B6oxoFI6dUzIIlqO60gUw6l6/gAzPXOHXLnw6j2XCznWmiJdfzU3YVgMF35dAs8A22VS4u4SZ1mZmgR7y5SaFWN37XbjjwBtzDQAbHcpLkc65Wr8DzEJ9ywG9R08pIhEesakiyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB40E1691;
	Tue, 18 Nov 2025 09:13:49 -0800 (PST)
Received: from [10.57.39.196] (unknown [10.57.39.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27E0E3F66E;
	Tue, 18 Nov 2025 09:13:51 -0800 (PST)
Message-ID: <e37844e3-8810-42c1-bae1-30b2e7868b80@arm.com>
Date: Tue, 18 Nov 2025 18:13:49 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/11] entry: Add has_syscall_work() helper
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, tglx@linutronix.de, peterz@infradead.org,
 luto@kernel.org, shuah@kernel.org, kees@kernel.org, wad@chromium.org,
 akpm@linux-foundation.org, ldv@strace.io, macro@orcam.me.uk, deller@gmx.de,
 mark.rutland@arm.com, song@kernel.org, mbenes@suse.cz, ryan.roberts@arm.com,
 ada.coupriediaz@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 pengcan@kylinos.cn, dvyukov@google.com, kmal@cock.li, lihongbo22@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251117133048.53182-1-ruanjinjie@huawei.com>
 <20251117133048.53182-10-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251117133048.53182-10-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2025 14:30, Jinjie Ruan wrote:
> Add has_syscall_work() helper to facilitate reuse of this
> function in other places.
>
> No functional changes.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  include/linux/entry-common.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index cd6dacb2d8bf..e0f94e937e84 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -44,6 +44,11 @@
>  				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
>  				 ARCH_SYSCALL_WORK_EXIT)
>  
> +static inline bool has_syscall_work(unsigned long work)
> +{
> +	return unlikely(work & SYSCALL_WORK_ENTER);

I'm not sure this is a good idea, since the generic syscall machinery
has two separate sets of flags (SYSCALL_WORK_ENTER and
SYSCALL_WORK_EXIT). Of course we could reflect that in the helper's
name, but since it's only used twice after patch 10, maybe we don't need
a helper at all.

- Kevin

> +}
> +
>  /**
>   * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
>   * @regs:	Pointer to currents pt_regs
> @@ -91,7 +96,7 @@ static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *re
>  {
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  
> -	if (work & SYSCALL_WORK_ENTER)
> +	if (has_syscall_work(work))
>  		syscall = syscall_trace_enter(regs, syscall, work);
>  
>  	return syscall;

