Return-Path: <linux-kselftest+bounces-21195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE079B7792
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 10:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E441F2500C
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EF0194A7C;
	Thu, 31 Oct 2024 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf0z3etJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0A81946A0
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367244; cv=none; b=X8dh+ZuZSLn2sBqvY2kzlkX9Uc4xr/+ZrQLVgNpQhLhANbYb59JVFcYJ1I85SOywbEGNA1j3GmlLPSCukLLb0hWJjyuBsqBy7jXWJWphrcyMfvqOOYX7NabOprnD15kCS1aNGmaB2Bys28duiyEVb80hmvNOR8wD/soPZa4Uk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367244; c=relaxed/simple;
	bh=ZFSitSgdptOVjcClSu7CfDR9yggNcE+SbsK6UcIRUOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNCczGTD8GIDeThxcj5H1Xt3wURz/C8CzW6Fhq5qLEXAUzQSgMC4ftuPN5vEnPpIpczrh9kemRfYCI0Xeebm2Mym6i/opu6NDRP+fVipcvhpokX7H6LKebuid5HH4vO9RspPI3PKc40hl77om8YQOClzfZgUw3KN2O1v6UKyN+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf0z3etJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF3CC4CEC3;
	Thu, 31 Oct 2024 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730367243;
	bh=ZFSitSgdptOVjcClSu7CfDR9yggNcE+SbsK6UcIRUOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yf0z3etJdM/pWhSVrW53SXDEgmrJsHEgI1FI6Vg3Pr9hFgrujZatLnt8sv50lGL76
	 EF8YuLVxB4sv0un+iTB8JtNuVltLJKkOOaOgMFMiS93egHDqhmBQw/IsCpOwFCFVwJ
	 SQp/Dqck738kE4KKhf6zh8ax9SFDeMA11GAKJS6J5nfhV55uE0NPL+8VhOIgatU5AV
	 anEiV6HSwu0QO48chjVJXGFEFZrTx670xbndcVyEtqLsN8roeQH3NKFCwie3JX687S
	 /a546hGLx3yHy2VhjaIrhqLD9EsenXiQHFC1QhcqY67kiF/Ya6C1CdBfxtW+mjOe2M
	 YMFECeau5OyEg==
Date: Thu, 31 Oct 2024 09:33:56 +0000
From: Will Deacon <will@kernel.org>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, Dave.Martin@arm.com,
	joey.gouly@arm.com, keith.lucas@oracle.com, pierre.langlois@arm.com,
	shuah@kernel.org, sroettger@google.com, tglx@linutronix.de,
	yury.khrustalev@arm.com, linux-kselftest@vger.kernel.org,
	x86@kernel.org, Kees Cook <keescook@chromium.org>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 1/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
Message-ID: <20241031093355.GA7008@willie-the-truck>
References: <20241029144539.111155-1-kevin.brodsky@arm.com>
 <20241029144539.111155-2-kevin.brodsky@arm.com>
 <CABi2SkUTSuk_PS9==_czM=64FGWK_5DyUe5QELxiFHtPFsKaHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkUTSuk_PS9==_czM=64FGWK_5DyUe5QELxiFHtPFsKaHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Jeff,

Thanks for chiming in!

On Wed, Oct 30, 2024 at 03:01:53PM -0700, Jeff Xu wrote:
> On Tue, Oct 29, 2024 at 7:46 AM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
> >
> > TL;DR: reset POR_EL0 to "allow all" before writing the signal frame,
> > preventing spurious uaccess failures.

[...]

> > @@ -924,12 +982,14 @@ SYSCALL_DEFINE0(rt_sigreturn)
> >         if (!access_ok(frame, sizeof (*frame)))
> >                 goto badframe;
> >
> > -       if (restore_sigframe(regs, frame))
> > +       if (restore_sigframe(regs, frame, &ua_state))
> >                 goto badframe;
> >
> >         if (restore_altstack(&frame->uc.uc_stack))
> >                 goto badframe;
> >
> Do you need to move restore_altstack ahead of restore_sigframe?
> similar as x86 change [1],
> the discussion for this  happened  in [2] [3]
> 
> [1] https://lore.kernel.org/lkml/20240802061318.2140081-5-aruna.ramakrishna@oracle.com/
> [2] https://lore.kernel.org/lkml/20240425210540.3265342-1-jeffxu@chromium.org/
> [3] https://lore.kernel.org/lkml/d0162c76c25bc8e1c876aebe8e243ff2e6862359.camel@intel.com/
> 
> > +       restore_user_access_state(&ua_state);

The POR isn't restored until here ^^^, so I _think_ restore_altstack()
is fine where it is. Kevin, can you confirm, please?

Will

