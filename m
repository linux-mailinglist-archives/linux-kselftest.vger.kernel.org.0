Return-Path: <linux-kselftest+bounces-19975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36C19A2750
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA151F230DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D341DED44;
	Thu, 17 Oct 2024 15:49:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB31DED4F
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180196; cv=none; b=qtuL68hm3xU8bdz1y80gPty36XrZiGYlPyT0RG+ewCAyzdxblzThP/9hcxHtVjzGyigHElY414hymPVLRtz98s3wlcyD4QAfTn1lxnC2eu6rGHMbAyquQmUc9sJLwF/oF9EnNpPl4bvv9vdoqBYyKX81wz4OqjsqGNJsJRHykdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180196; c=relaxed/simple;
	bh=Rc65Z9Z05tZcFc/nUXum28uJOmNz3B5eYHlSVg/hdX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwI+dQ2Dgnhx3MEw8P1tZrkWSIWTVB4RNzHsq5WEtyBmESJHbktollC1IxLMiOvRFpkNiwo2ooEL2limyj7XH8wfsHW0DDN830/K14cOr3oNHNoug+NDr5PTxCZGAb2KW9w31FtDk6qjwVz+Ktkue3aI7PA2qtxerI1Kh5oCOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC8E9FEC;
	Thu, 17 Oct 2024 08:50:20 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 292723F71E;
	Thu, 17 Oct 2024 08:49:49 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:49:46 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, jeffxu@chromium.org,
	joey.gouly@arm.com, shuah@kernel.org, will@kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/5] arm64: signal: Remove unnecessary check when saving
 POE state
Message-ID: <ZxEyGs5hLfOnIEeX@e133380.arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <20241017133909.3837547-3-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017133909.3837547-3-kevin.brodsky@arm.com>

On Thu, Oct 17, 2024 at 02:39:06PM +0100, Kevin Brodsky wrote:
> The POE frame record is allocated unconditionally if POE is
> supported. If the allocation fails, a SIGSEGV is delivered before
> setup_sigframe() can be reached. As a result there is no need to
> check that poe_offset has been checked before saving POR_EL0; this
> is in line with other frame records (FPMR, TPIDR2).
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  arch/arm64/kernel/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index dc998326e24d..f5fb48dabebe 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -1092,7 +1092,7 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
>  		err |= preserve_fpmr_context(fpmr_ctx);
>  	}
>  
> -	if (system_supports_poe() && err == 0 && user->poe_offset) {
> +	if (system_supports_poe() && err == 0) {
>  		struct poe_context __user *poe_ctx =
>  			apply_user_offset(user, user->poe_offset);
>  
> -- 
> 2.43.0
> 
> 

