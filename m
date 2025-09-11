Return-Path: <linux-kselftest+bounces-41255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19460B53832
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 17:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9498E482FAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A4C352096;
	Thu, 11 Sep 2025 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6zXuT/z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615B322A3B;
	Thu, 11 Sep 2025 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605821; cv=none; b=ZdvmxoqlIhSPkLdA7Au1vEEYjaAd31AL1Q4jCDGKOFMXAyj+5cCTD+cI2FaEk4396jZa0YY0I01RgZc8E5nYXWLM951PcR5ApRIuDIFjQUCaKHzt8iFZcqB+mMnTHq9C4pskMVkqpVnWSBxH/BVMjLbxu/eXflHV3ZwEwNcgbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605821; c=relaxed/simple;
	bh=KrP0T2DcrwhQKhYMWfFSKZufjGZ6OuhA6JrtiaI9b+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDXwFeaDtcJgESCQqIBJkzM1GeYsJjCpR5dm9XlmabllmrMC7wdHc/srJnLNNemeym/aTSGsM+d1nNEh5AG4Uare7BxzR22M9ZKucU+gpgwBn/emj5K4RRTIzdkk7jOXRANh/yCnIkrR1crXaKGDe74rFLzD+37pOaoLTJxRQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6zXuT/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A9AC4CEF5;
	Thu, 11 Sep 2025 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757605821;
	bh=KrP0T2DcrwhQKhYMWfFSKZufjGZ6OuhA6JrtiaI9b+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6zXuT/zvwAvW/LwpZj95aIEc1iO6la+8BhMyRIFh+A823lmW0h0fUNxNZLxsH/rS
	 Yz0eSycTxUvy/Tv3ocvDpEbrh5ZTXZwzreTCjUT+Am2S+6K96ulA40DxURNB31xlRP
	 NRKR6OSIVKo+P0kQIy7DBQYfZDxIcVzp7pEA+MaSzfPYQciq5bp3lGX3Wlr2H4rx6h
	 VkItVoTHHwzx6pM1IylBMm05gQgVfxVQKTfmab6LxEZ7EF/Gmtfn/oTY7sQtDuPwK5
	 TfqKexDtTMPfk5hg73O6a/EOqzggZWFGXm+GNh+uq2ERCEKw3pfIk4XOIIDqnQiXJF
	 NEO4AozbipWaQ==
Date: Thu, 11 Sep 2025 16:50:14 +0100
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: yangyicong@hisilicon.com, catalin.marinas@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, corbet@lwn.net,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	shuah@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, xuwei5@huawei.com,
	tangchengchang@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH v4 5/7] arm64: Add support for FEAT_{LS64, LS64_V}
Message-ID: <aMLvtpaCgRqPAU2Z@willie-the-truck>
References: <20250715081356.12442-1-yangyicong@huawei.com>
 <20250715081356.12442-6-yangyicong@huawei.com>
 <aL7Fgx__LeLfbDyU@willie-the-truck>
 <5d2ba565-715b-9b17-951b-f805dde5988b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d2ba565-715b-9b17-951b-f805dde5988b@huawei.com>

On Tue, Sep 09, 2025 at 09:48:04AM +0800, Yicong Yang wrote:
> On 2025/9/8 20:01, Will Deacon wrote:
> > On Tue, Jul 15, 2025 at 04:13:54PM +0800, Yicong Yang wrote:
> >> diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
> >> index 69d7afe56853..9e6db258ff48 100644
> >> --- a/Documentation/arch/arm64/elf_hwcaps.rst
> >> +++ b/Documentation/arch/arm64/elf_hwcaps.rst
> >> @@ -435,6 +435,12 @@ HWCAP2_SME_SF8DP4
> >>  HWCAP2_POE
> >>      Functionality implied by ID_AA64MMFR3_EL1.S1POE == 0b0001.
> >>  
> >> +HWCAP3_LS64
> >> +    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0001.
> >> +
> >> +HWCAP3_LS64_V
> >> +    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0010.
> > 
> > Given that these instructions only work on IMPLEMENTATION DEFINED memory
> > locations and aren't guaranteed to generate an abort if used elsewhere,
> > how is userspace supposed to know what to do with them?
> > 
> 
> per ARM DDI0487 L.b section C3.2.6,
> 
>   When the instructions access a memory type that is not one of the following,
>   a data abort for unsupported Exclusive or atomic access is generated...

That's about the memory _type_. I'm talking about a supported memory type
(e.g. writeback cacheable) but when the physical location doesn't support
the instruction. That's captured a little later in the same section:

  | If the target memory location does not support the LD64B or ST64B
  | instructions, then one of the following behaviors occurs:
  |  * A stage 1 Data Abort, reported using the DFSC code of 0b110101,
  |    is generated.
  |  * The instruction performs the memory accesses, but the accesses
  |    are not single-copy atomic above the byte level

and I think that's a bad interface to expose blindly to userspace solely
as a boolean hwcap.

Will

