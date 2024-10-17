Return-Path: <linux-kselftest+bounces-19974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F869A274D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94E11C26A76
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754961DED69;
	Thu, 17 Oct 2024 15:49:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8805F1DE8AF
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180180; cv=none; b=dggGSIAWWi+vbhC4OabL8sPum1Fljq8eECtfxEDK6gsS5IvJWwDWeb9EQFc30vHtr5kgy4vJNPnRUUaUehc6mdtEjtHTUUfseEX6UIPt//Aun/1XuIRvmBaoTQI2YYcVWebU+wijRQ1d3f5HrA+UibQehUEETWT9Avy3aiTkcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180180; c=relaxed/simple;
	bh=wb+mWFLO56Q6v5VlKfF9ZVIuhulUE375eo9jmO558CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1eqrrGk1zZ45ZTujtMTBEI9OQWbl8klWq0WtEBfxyaNuIImxtqJk7vp1RBqnHXUTiopy2x12/2MfD7BpkLRznbd14yWQ8wjS7YrebrHtD627FJ1/PX+9+BLgos0Rwhn9yFln5xKDQGWPpFGbfoG2vZCLUdkTKI43+8RJJxa+DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51175FEC;
	Thu, 17 Oct 2024 08:50:04 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 565D93F71E;
	Thu, 17 Oct 2024 08:49:32 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:49:29 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, jeffxu@chromium.org,
	joey.gouly@arm.com, shuah@kernel.org, will@kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/5] arm64: signal: Remove unused macro
Message-ID: <ZxEyCTf/Zt9kcHVv@e133380.arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <20241017133909.3837547-2-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017133909.3837547-2-kevin.brodsky@arm.com>

On Thu, Oct 17, 2024 at 02:39:05PM +0100, Kevin Brodsky wrote:
> Commit 33f082614c34 ("arm64: signal: Allow expansion of the signal
> frame") introduced the BASE_SIGFRAME_SIZE macro but it has
> apparently never been used.

Nit: Should there be a statement of what the patch does?

Same throughout the series.

(Yes, I know it's in the subject line, but Mutt doesn't think that's
part of the message body, so I can't see it now that I'm replying...
and submitting-patches.rst and e.g., maintainer-tip.rst seem to take
the same policy, albeit without quite stating it explicitly.)

> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Weird.  Maybe there are places where this could have been used, but I
guess we have managed fine without it.

Or possibly some unmerged version of the SVE patches used this but it
disappeared in refactoring.

Either way:

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/kernel/signal.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 561986947530..dc998326e24d 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -66,7 +66,6 @@ struct rt_sigframe_user_layout {
>  	unsigned long end_offset;
>  };
>  
> -#define BASE_SIGFRAME_SIZE round_up(sizeof(struct rt_sigframe), 16)
>  #define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
>  #define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
>  
> -- 
> 2.43.0
> 
> 

