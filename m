Return-Path: <linux-kselftest+bounces-20540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840E09AE332
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 13:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD4E1F214B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 11:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC41A1C761C;
	Thu, 24 Oct 2024 10:59:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467ED1C4A23
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767597; cv=none; b=ErZd4dnLyzqufDiDancqJcHBJNiy8bJDZ5o2v9QplU/N4dDNzcG3DLw2sDM60xiTeEtLFiRQmNZjj7nczo8KE6aq9ptPJnoxgPcRL1MZ6pX9m3rfFeT7XQJUsq/YYgXlNv90BIxM9OWBgwRc81u2t3k0cSsDSViUSrnVy/fNRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767597; c=relaxed/simple;
	bh=dtH0yW2PAq1QsfXNAKakmxRNzP87CId6JwTZJP3pGjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyEXKuN8erHgLS2Z31o5BiRYSRAnUIYHLgtDso/ZvSSMvH0kg4zXkFkuZPE/CFzaaBUf7lJzKswa80j7dQ6dpUMiyKJm3XFLeE399qWRPtmCj4iEexPXwXy2wegmE2TaJMk6XbwPcL2pmiEc9jUtanerQl/vWD4ZIv45mqPQVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6713B339;
	Thu, 24 Oct 2024 04:00:24 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25F983F71E;
	Thu, 24 Oct 2024 03:59:49 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:59:46 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, dave.hansen@linux.intel.com,
	dave.martin@arm.com, jeffxu@chromium.org, joey.gouly@arm.com,
	pierre.langlois@arm.com, shuah@kernel.org, sroettger@google.com,
	will@kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 3/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
Message-ID: <ZxoooqtuqTK5CAMR@arm.com>
References: <20241023150511.3923558-1-kevin.brodsky@arm.com>
 <20241023150511.3923558-4-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023150511.3923558-4-kevin.brodsky@arm.com>

On Wed, Oct 23, 2024 at 04:05:09PM +0100, Kevin Brodsky wrote:
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index f5fb48dabebe..d2e4e50977ae 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -66,9 +66,63 @@ struct rt_sigframe_user_layout {
>  	unsigned long end_offset;
>  };
>  
> +/*
> + * Holds any EL0-controlled state that influences unprivileged memory accesses.
> + * This includes both accesses done in userspace and uaccess done in the kernel.
> + *
> + * This state needs to be carefully managed to ensure that it doesn't cause
> + * uaccess to fail when setting up the signal frame, and the signal handler
> + * itself also expects a well-defined state when entered.
> + */
> +struct user_access_state {
> +	u64 por_el0;
> +};
> +
>  #define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
>  #define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
>  
> +/*
> + * Save the unpriv access state into ua_state and reset it to disable any
> + * restrictions.
> + */
> +static void save_reset_user_access_state(struct user_access_state *ua_state)
> +{
> +	if (system_supports_poe()) {
> +		/*
> +		 * Enable all permissions in all 8 keys
> +		 * (inspired by REPEAT_BYTE())
> +		 */
> +		u64 por_enable_all = (~0u / POE_MASK) * POE_RXW;

I think this should be ~0ul.

> @@ -907,6 +964,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  {
>  	struct pt_regs *regs = current_pt_regs();
>  	struct rt_sigframe __user *frame;
> +	struct user_access_state ua_state;
>  
>  	/* Always make any pending restarted system calls return -EINTR */
>  	current->restart_block.fn = do_no_restart_syscall;
> @@ -923,12 +981,14 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  	if (!access_ok(frame, sizeof (*frame)))
>  		goto badframe;
>  
> -	if (restore_sigframe(regs, frame))
> +	if (restore_sigframe(regs, frame, &ua_state))
>  		goto badframe;
>  
>  	if (restore_altstack(&frame->uc.uc_stack))
>  		goto badframe;
>  
> +	restore_user_access_state(&ua_state);
> +
>  	return regs->regs[0];
>  
>  badframe:

The saving part I'm fine with. For restoring, I was wondering whether we
can get a more privileged POR_EL0 if reading the frame somehow failed.
This is largely theoretical, there are other ways to attack like
writing POR_EL0 directly than unmapping/remapping the signal stack.

What I'd change here is always restore_user_access_state() to
POR_EL0_INIT. Maybe just initialise ua_state above and add the function
call after the badframe label.

Either way:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

