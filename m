Return-Path: <linux-kselftest+bounces-5338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30761861076
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 12:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6265C1C23630
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9B76C83;
	Fri, 23 Feb 2024 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDaZpxGk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD9241F9;
	Fri, 23 Feb 2024 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688046; cv=none; b=q4v4xdzyVg7V3LfNTXIlOStn7hWIPxqFVrmF5QqpCLNJwFc1lICGvzoaUfDb+fFz3N0Wxen8t8lgleqAg6tCOPa1724sEDO9QasXFo5NPUexCLv4q/eelLy0Z1Sta3kBNH8Qhf5Dsupf6krpkrd6hWLbKhjFVjisHrOw6dogvB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688046; c=relaxed/simple;
	bh=DiGctqgCKkLw/ZlxbVMfN/FK6a0lA5WiDsdNN455/9Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2P0lcReGDXO9bJSH+MM8YAkIjrVYFKsNiMcHcCFiOCXW1qjvKFhQVY5uHDDgC1qTA2ZieARV7uKdMCwDvlqb1UB00alNtgurqj0/aumqV10F81XV71n62lgZnSmi+ClU6M/aBMkWsvi2dBDCqHtgbFuXleS8YWoY63p+xD+cmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDaZpxGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F9BC433C7;
	Fri, 23 Feb 2024 11:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708688046;
	bh=DiGctqgCKkLw/ZlxbVMfN/FK6a0lA5WiDsdNN455/9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DDaZpxGkIrQRkiIQ/px4Nc3Jmf+b4OB6qyp8wvQYO9aF8ME09FaXvGuHCna47cMjd
	 60wUuvAve82AGputYiyPZgqy+Ym7gFyc2fDgPXohDZOB7v0qNDjStq2j/WT0EWEvKm
	 mcUQDdJ20y9hsq6MMm/fR2tkoftWrMhf0v4ARLtpj4wChfEpkgP486za+Ovz39W2vG
	 jThe7EMtqS2FWcn1SJb/1WDg7N3eDzlh7EhqgQotjIufKHtBpR7emOnAJapszSx84v
	 +cKv8mkIGhTK1LTWEpGTjiazyRuEN5YLr+cK/d/pdLThqlzgOh/TNRkCTnaR0sYRwP
	 M/elKjGCgphaw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rdToa-0064G3-9S;
	Fri, 23 Feb 2024 11:34:04 +0000
Date: Fri, 23 Feb 2024 11:34:03 +0000
Message-ID: <86msrr2z4k.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dave Martin <dave.martin@arm.com>,
	kvmarm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 02/14] arm64/fpsimd: Enable host kernel access to FPMR
In-Reply-To: <20240122-arm64-2023-dpisa-v4-2-776e094861df@kernel.org>
References: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
	<20240122-arm64-2023-dpisa-v4-2-776e094861df@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, corbet@lwn.net, shuah@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dave.martin@arm.com, kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 22 Jan 2024 16:28:05 +0000,
Mark Brown <broonie@kernel.org> wrote:
> 
> FEAT_FPMR provides a new generally accessible architectural register FPMR.
> This is only accessible to EL0 and EL1 when HCRX_EL2.EnFPM is set to 1,
> do this when the host is running. The guest part will be done along with
> context switching the new register and exposing it via guest management.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_arm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 3c6f8ba1e479..7f45ce9170bb 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -105,7 +105,7 @@
>  #define HCRX_GUEST_FLAGS \
>  	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
>  	 (cpus_have_final_cap(ARM64_HAS_MOPS) ? (HCRX_EL2_MSCEn | HCRX_EL2_MCE2) : 0))
> -#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En)
> +#define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM)
>  
>  /* TCR_EL2 Registers bits */
>  #define TCR_EL2_DS		(1UL << 32)
> 

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.

