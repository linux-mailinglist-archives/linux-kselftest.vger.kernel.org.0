Return-Path: <linux-kselftest+bounces-45894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F81C6AE7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A54D02CD60
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ACF35FF64;
	Tue, 18 Nov 2025 17:13:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5021035FF67;
	Tue, 18 Nov 2025 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485980; cv=none; b=HOh10Cbeh4PIy7dQn+fG+xs+6f5WF/15CL56IjNoynCyU1+EzrpnH+3/DHRcyO6dlk6ip4yGGzs88aCWIbW8kJbBiFA4B2wPwxyd+eVXwjln3YQiQduzs4OrLgwlHSo6SuHGI4PT1UkEOzH5mlAipVze7mzE8MblpVpDF31yEew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485980; c=relaxed/simple;
	bh=UW2Z0m3wos7rpEfOTDewIJTcl+Y64fl/37RGUqfiNVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YQ31AczyEmTUIskl3ggHWrdZF9TUETlr7YXB9LHundyKPC9aUKQRw4g4Liy6UqPTdSyW5WyssTuiI+WP0POt21tVcgOiIOvdczwjr9PMFWdKKZLVyJMRwRoZDnvbFAU0WUv5RZec4v5MCfpMjn+y2JETNa2HNhWF+ehLW98ap4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0B5E1655;
	Tue, 18 Nov 2025 09:12:50 -0800 (PST)
Received: from [10.57.39.196] (unknown [10.57.39.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC8B93F66E;
	Tue, 18 Nov 2025 09:12:53 -0800 (PST)
Message-ID: <256357dc-2f29-4af6-8efc-5222170e5e49@arm.com>
Date: Tue, 18 Nov 2025 18:12:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] arm64/ptrace: Use syscall_get_arguments()
 heleper
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
 <20251117133048.53182-8-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251117133048.53182-8-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In subject: s/heleper/helper/

On 17/11/2025 14:30, Jinjie Ruan wrote:
> The generic entry check audit context first and use
> syscall_get_arguments() helper.
>
> In order to switch to the generic entry for arm64,
>
> - Also use the helper.
>
> - Extract the syscall_enter_audit() helper to make it clear.
>
> - Check audit context for syscall_enter_audit(), which only adds
>   one additional check without any other differences as
>   audit_syscall_entry() check it first otherwise do nothing.

Presumably this is to avoid an unnecessary memcpy(). Overall these
changes make syscall_enter_audit() exactly equivalent to the generic
one, would be good to spell it out.

> No functional changes.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/ptrace.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 9af3046a2ce9..9455ccf1ecc1 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2376,6 +2376,17 @@ static void report_syscall_exit(struct pt_regs *regs)
>  	}
>  }
>  
> +static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
> +{
> +	if (unlikely(audit_context())) {
> +		unsigned long args[6];
> +
> +		syscall_get_arguments(current, regs, args);
> +		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
> +	}
> +

Nit: empty line.

- Kevin

> +}
> +
>  int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
>  {
>  	int ret;
> @@ -2406,8 +2417,7 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
>  		 syscall = syscall_get_nr(current, regs);
>  	}
>  
> -	audit_syscall_entry(syscall, regs->orig_x0, regs->regs[1],
> -			    regs->regs[2], regs->regs[3]);
> +	syscall_enter_audit(regs, syscall);
>  
>  	return regs->syscallno;
>  }

