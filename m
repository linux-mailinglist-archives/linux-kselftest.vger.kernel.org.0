Return-Path: <linux-kselftest+bounces-45893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C91AC6AEE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FD2C4F387F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8CE3A5E6B;
	Tue, 18 Nov 2025 17:12:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1683A1CEA;
	Tue, 18 Nov 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485952; cv=none; b=i3tM9vBR/1XreMde53UnwUqlgzUJmKSeHDj0Y4U1jR+F72PKDh6yoMyoCl6W4rUhCbBrvBqVWQLhY/N9s6NQEgvuhBmgAL15vAzYpTLcoWKnuAoxRunK8+SNnrQPe7TCaT6tZffsRIgabseR248sL/UO5rd7g1figXm7L7nvhZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485952; c=relaxed/simple;
	bh=o1eaAHnccFUQBLgOt0rZXAaiezfVjexzEGuBcVhkFAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MeblHLnacx7W1isSKSKs8Kn6Uat6BIebjJzxSdv33ECuBfRomp2tv0JYkubokE2riwIaeq4d0eKStIAMpWnAbe9m2vW6MFVOiJ9wrKLEoeYSKJAqWujHLBLiLVwg+4fkfkFoxuYVrTfoFUThomzF+Oyh+WT3ErFVQXN3DRAUtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A10615A1;
	Tue, 18 Nov 2025 09:12:22 -0800 (PST)
Received: from [10.57.39.196] (unknown [10.57.39.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C72273F66E;
	Tue, 18 Nov 2025 09:12:24 -0800 (PST)
Message-ID: <e33d0fdb-e8a5-4abd-8e40-773349008b6b@arm.com>
Date: Tue, 18 Nov 2025 18:12:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/11] arm64/ptrace: Expand secure_computing() in place
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
 <20251117133048.53182-7-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251117133048.53182-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2025 14:30, Jinjie Ruan wrote:
> The generic entry expand secure_computing() in place and call
> __secure_computing() directly.
>
> In order to switch to the generic entry for arm64, refactor
> secure_computing() for syscall_trace_enter().
>
> No functional changes.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/ptrace.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 707951ad5d24..9af3046a2ce9 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2387,8 +2387,11 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
>  	}
>  
>  	/* Do the secure computing after ptrace; failures should be fast. */
> -	if (secure_computing() == -1)
> -		return NO_SYSCALL;
> +	if (flags & _TIF_SECCOMP) {
> +		ret = __secure_computing(NULL);

No argument was passed to __secure_computing() in v6, as expected since
it was removed in v6.15. Not sure why this NULL reappeared.

> +		if (ret == -1L)

ret is an int, so should be -1, not -1L.

- Kevin

> +			return NO_SYSCALL;
> +	}
>  
>  	/* Either of the above might have changed the syscall number */
>  	syscall = syscall_get_nr(current, regs);

