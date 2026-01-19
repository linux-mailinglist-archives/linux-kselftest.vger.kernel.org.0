Return-Path: <linux-kselftest+bounces-49379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F77BD3AF92
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 16:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A8CD300CCFF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E4424469E;
	Mon, 19 Jan 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQZR3dub"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD81A285;
	Mon, 19 Jan 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837851; cv=none; b=jPnj3sSrO1ORmeMUaUMK9We28WcLLmI3BvtXi3wODkv4E24vlniuXq3nM5ULipfy26tJIIb1FcAydScXf/Fz2HztNrgJUJz8T3l5vwJtd+sO5KLWZwnHztQWgeQclhfqPV16COyuSIThIftZXWuRga1OGapbVQ5SaP0/tozShnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837851; c=relaxed/simple;
	bh=8spVm2UWPNEikSMnnuFnl2MPKSCRmkDl/sho6yBQYTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCJ5B6e+ILyWEmoFv/OuhRIAnfG/yXgYBj6n/pU6EnyKnJj3q4J0VyC5PeyM5M/1M08XWC2za6u+053EazXejPcbhzRTniA/pUzxa2oqKH3qHIVd3pBZeKFmRMTV7NueS2/XoBKet8/YfGir2sFDzfI3UHrDE+TwAwQbrjmtVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQZR3dub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96ABFC116C6;
	Mon, 19 Jan 2026 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768837850;
	bh=8spVm2UWPNEikSMnnuFnl2MPKSCRmkDl/sho6yBQYTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQZR3dubIjy3jFPHfxwq4VtF8iq7w9U3jo7KQ5mdPrI6a79NWvOMUKPW8y76MqlFd
	 1OKdf0YDRgmaVqQucyxNpKkpu7RuPGh7/c/OsoEUBOeAqm8RHkCYTOLJQOjNdlUKIJ
	 33ykFO+doxlwNLEZYbry9yu08OvVtuRJgTIpeZgrv3ItljWttKA9KZUTHkJFXyjnXB
	 FG8wANrlUKO+9bKqaykc4OF38uCL/ce4+OxqH5fxdNsMauufRbomZ5BLbw1uVXTfc+
	 EUHopvX02iuhFxuqh+Pu0S2N/7fKTlXLSC4podyP1DdcZyhmDoh4/ooLpK/3lX+5qT
	 FisuSuTv/zoag==
Date: Mon, 19 Jan 2026 15:50:43 +0000
From: Will Deacon <will@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, maz@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, miko.lenczewski@arm.com,
	kevin.brodsky@arm.com, ardb@kernel.org, suzuki.poulose@arm.com,
	lpieralisi@kernel.org, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, joey.gouly@arm.com,
	yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org,
	mark.rutland@arm.com, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 RESEND 4/9] arm64: Kconfig: Detect toolchain support
 for LSUI
Message-ID: <aW5S04xS4FT0zvXv@willie-the-truck>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
 <20251214112248.901769-5-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214112248.901769-5-yeoreum.yun@arm.com>

On Sun, Dec 14, 2025 at 11:22:43AM +0000, Yeoreum Yun wrote:
> Since Armv9.6, FEAT_LSUI supplies the load/store instructions for
> previleged level to access to access user memory without clearing
> PSTATE.PAN bit.
> It's enough to add CONFIG_AS_HAS_LSUI only because the code for LSUI uses
> individual `.arch_extension` entries.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 93173f0a09c7..36e87a1a1b5c 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2227,6 +2227,11 @@ config ARM64_GCS
> 
>  endmenu # "ARMv9.4 architectural features"
> 
> +config AS_HAS_LSUI
> +	def_bool $(as-instr,.arch_extension lsui)
> +	help
> +	  Supported by LLVM 20+ and binutils 2.45+.

This is an internal Kconfig variable so please drop the help text.

Will

