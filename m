Return-Path: <linux-kselftest+bounces-40938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F6DB48CBA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 14:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D555200491
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 12:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A502EFD9E;
	Mon,  8 Sep 2025 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbwgT7S/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC489235BE8;
	Mon,  8 Sep 2025 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332877; cv=none; b=HPhGVI01gYfS60a4wK6SljA6JyigvmmGkRJkOY/z06uKhw2xkPrb0WkLgoR0sFXhBoP6Q/oCCt/EiiGHciHoPs/Sqp9oXyVUyftT0BjtPVVMrXWMzT3s7RfCsySz+XK9X07sfGX/BVyWAsDM+TCxnrLxsid2Ang4A7Mjbf/3oq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332877; c=relaxed/simple;
	bh=0rgldGhbl11HMepDjkEVXMk9/p/RSLdSGL+gD3Ej80c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=So8cvBCZIqPODRMIWftFpoaLvLrPt5LPfsebbQNEK+ICSXM9ki+YA7sMkCKdFkEucLKislAGWwtrUCK/UqE5WP5ehQw5/eZ06/ufvgLTqonYbRbA6p1z4U0AN/8+MARw3MG9CSclC+anF307KNEBiTYLjASkFrzlM8CggHdJ+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbwgT7S/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A093BC4CEF1;
	Mon,  8 Sep 2025 12:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757332874;
	bh=0rgldGhbl11HMepDjkEVXMk9/p/RSLdSGL+gD3Ej80c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pbwgT7S/pSJPKHabt9S5WLRMR/XJwGiZLRmkCpmB++TU0dDfePeudaJtqvPnjpC3V
	 nLKvaJR+gi3K9226t5WCvsdqs8jO5UfPOUMaIMMqZcmo19VRExrZk1io4jlDIQRCOB
	 qTFBQsjE1R0K/yD8Hh8OjLPacwM23Z+eQOhz1r8EXpIRVjJi9beM4nBsr8P8/phdF2
	 RcgHUIEOoW3qoJj0HuiFdU1/W8LFC+Pz7urUpe7MAql3EcA+aM4QxQUwcz84rlMBEY
	 K90KTpmVhva3RqoeZxXPYRrvB8/dqlJDHXvfgJ/Hl/iuajmkH+7F+O01Lw7hcE6z2V
	 l1FxdHqZ5UEcw==
Date: Mon, 8 Sep 2025 13:01:07 +0100
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: catalin.marinas@arm.com, maz@kernel.org, oliver.upton@linux.dev,
	corbet@lwn.net, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, shuah@kernel.org,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	linuxarm@huawei.com, prime.zeng@hisilicon.com, xuwei5@huawei.com,
	yangyicong@hisilicon.com, tangchengchang@huawei.com,
	wangzhou1@hisilicon.com
Subject: Re: [PATCH v4 5/7] arm64: Add support for FEAT_{LS64, LS64_V}
Message-ID: <aL7Fgx__LeLfbDyU@willie-the-truck>
References: <20250715081356.12442-1-yangyicong@huawei.com>
 <20250715081356.12442-6-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715081356.12442-6-yangyicong@huawei.com>

On Tue, Jul 15, 2025 at 04:13:54PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Armv8.7 introduces single-copy atomic 64-byte loads and stores
> instructions and its variants named under FEAT_{LS64, LS64_V}.
> These features are identified by ID_AA64ISAR1_EL1.LS64 and the
> use of such instructions in userspace (EL0) can be trapped. In
> order to support the use of corresponding instructions in userspace:
> - Make ID_AA64ISAR1_EL1.LS64 visbile to userspace
> - Add identifying and enabling in the cpufeature list
> - Expose these support of these features to userspace through HWCAP3
>   and cpuinfo
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  Documentation/arch/arm64/booting.rst    | 12 ++++++
>  Documentation/arch/arm64/elf_hwcaps.rst |  6 +++
>  arch/arm64/include/asm/hwcap.h          |  2 +
>  arch/arm64/include/uapi/asm/hwcap.h     |  2 +
>  arch/arm64/kernel/cpufeature.c          | 51 +++++++++++++++++++++++++
>  arch/arm64/kernel/cpuinfo.c             |  2 +
>  arch/arm64/tools/cpucaps                |  2 +
>  7 files changed, 77 insertions(+)
> 
> diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
> index ee9b790c0d72..837823d49212 100644
> --- a/Documentation/arch/arm64/booting.rst
> +++ b/Documentation/arch/arm64/booting.rst
> @@ -483,6 +483,18 @@ Before jumping into the kernel, the following conditions must be met:
>  
>     - MDCR_EL3.TPM (bit 6) must be initialized to 0b0
>  
> +  For CPUs support for 64-byte loads and stores without status (FEAT_LS64):

nit: I think you're missing a word ("For CPUs with support ...").

> +
> +  - If the kernel is entered at EL1 and EL2 is present:
> +
> +    - HCRX_EL2.EnALS (bit 1) must be initialised to 0b1.
> +
> +  For CPUs support for 64-byte loads and stores with status (FEAT_LS64_V):

Same here, but also FEAT_LS64_V only applies to stores so no need to
mention loads.

> +
> +  - If the kernel is entered at EL1 and EL2 is present:
> +
> +    - HCRX_EL2.EnASR (bit 2) must be initialised to 0b1.
> +
>  The requirements described above for CPU mode, caches, MMUs, architected
>  timers, coherency and system registers apply to all CPUs.  All CPUs must
>  enter the kernel in the same exception level.  Where the values documented
> diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
> index 69d7afe56853..9e6db258ff48 100644
> --- a/Documentation/arch/arm64/elf_hwcaps.rst
> +++ b/Documentation/arch/arm64/elf_hwcaps.rst
> @@ -435,6 +435,12 @@ HWCAP2_SME_SF8DP4
>  HWCAP2_POE
>      Functionality implied by ID_AA64MMFR3_EL1.S1POE == 0b0001.
>  
> +HWCAP3_LS64
> +    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0001.
> +
> +HWCAP3_LS64_V
> +    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0010.

Given that these instructions only work on IMPLEMENTATION DEFINED memory
locations and aren't guaranteed to generate an abort if used elsewhere,
how is userspace supposed to know what to do with them?

As it stands, exposing the feature blindly feels like a bad idea to me.
Surely there needs to be a way for userspace to either probe or request
memory that supports the instructions? We should also make sure we
handle the abort properly if it occurs and presumably deliver a SIGBUS.

Will

