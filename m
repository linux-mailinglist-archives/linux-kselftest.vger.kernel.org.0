Return-Path: <linux-kselftest+bounces-47303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C801CB0173
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 14:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32068300AFDC
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A5B2749E0;
	Tue,  9 Dec 2025 13:48:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBDE2517B9;
	Tue,  9 Dec 2025 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288101; cv=none; b=SXhgx4zCKouY43S7J/xP546lSw/6LBfr9gKb4NiNiu1xERSw4wH9u8MbQIHEduZJQooXQLpZE0fAbMyTFGoNqUXg0VAkGTzMCmaLE9KhIDvvGJphaUCAhO2jDvpJZyT14vV9dfAMw/Lw0m5EKbp2UwBHMPTW25iLVNglGdhv2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288101; c=relaxed/simple;
	bh=gddq2R5cK/VQ8vWmoB6iTMgNXT3j1CoVNdciN8Yj6E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hz5lj94ASZ0/yjaOiBFLKeCLR2E13/tp0afRyCMmiWX5vgYyXtvbrHvIEwpVIV+sgdTJbvsfwLPyP++vtTh1RJmRKYpQ0/VqS2qEOXrUQCTu/Jrbsz5QdqSkmiGA3rvjSIFxwT5Wt/xKcN+zqpIW2qtz2UM0T5cTcrM7wHqtWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 774D21758;
	Tue,  9 Dec 2025 05:48:10 -0800 (PST)
Received: from [10.57.45.100] (unknown [10.57.45.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C94C3F762;
	Tue,  9 Dec 2025 05:48:12 -0800 (PST)
Message-ID: <746211f0-74b7-4935-a036-48a00bb5701b@arm.com>
Date: Tue, 9 Dec 2025 14:48:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/16] arm64: Inline el0_svc_common()
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, tglx@linutronix.de, peterz@infradead.org,
 luto@kernel.org, shuah@kernel.org, kees@kernel.org, wad@chromium.org,
 deller@gmx.de, macro@orcam.me.uk, charlie@rivosinc.com, ldv@strace.io,
 mark.rutland@arm.com, song@kernel.org, ryan.roberts@arm.com,
 ada.coupriediaz@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 pengcan@kylinos.cn, dvyukov@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
 <20251204082123.2792067-15-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251204082123.2792067-15-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/12/2025 09:21, Jinjie Ruan wrote:
> After switch arm64 to Generic Entry, the compiler no longer inlines

Did it inline it before this series?

> el0_svc_common() into do_el0_svc(). So inline el0_svc_common() and it
> has 1% performance uplift on perf bench basic syscall on kunpeng920
> as below.
>
> | Metric     | W/O this patch | With this patch | Change    |
> | ---------- | -------------- | --------------- | --------- |
> | Total time | 2.195 [sec]    | 2.171 [sec]     |  ↓1.1%   |
> | usecs/op   | 0.219575       | 0.217192        |  ↓1.1%   |
> | ops/sec    | 4,554,260      | 4,604,225       |  ↑1.1%    |
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

I think this is sensible - do_el0_svc() is clearly hot and the small
increase in code size is completely justified. It also removes a
performance regression when enabling CONFIG_COMPAT (without it
el0_svc_common() has only one caller so it should be inlined regardless).

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> ---
>  arch/arm64/kernel/syscall.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 47e193a1cfff..5aa51da9ec25 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -66,8 +66,8 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  	choose_random_kstack_offset(get_random_u16());
>  }
>  
> -static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> -			   const syscall_fn_t syscall_table[])
> +static __always_inline void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> +					   const syscall_fn_t syscall_table[])
>  {
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  	unsigned long flags = read_thread_flags();

