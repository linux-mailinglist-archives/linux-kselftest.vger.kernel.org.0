Return-Path: <linux-kselftest+bounces-31902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0A0AA0F8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 16:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803819208E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA8521767D;
	Tue, 29 Apr 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WounUNd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C564431;
	Tue, 29 Apr 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938068; cv=none; b=LreflitbBeZ/H2A0/MIMDcJveFjFsNS3QE+ZAX+0kpKI5Dq/rbv3rOBkaBybiTKwd5jTjUVAYJlCdGpj2q7AbIVmnYL6KYPKhKQif6lpoNM/Ijg3CP1okGCjuQTfe/gT59kQvzVRKLqTWEc7b6GBnNucnXLgDUq5VYzPYb6eX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938068; c=relaxed/simple;
	bh=MkI4ziZBimRv816hWldVx0OhLFYQifsD85oE9/WnLRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjaYbOogKzX+jp9vBqN1Tjiz0w7FaKYq24edlO64lZDHt0MlXJ/gboQ+dzhIvya1VX3VC5BcYRCzoLWn/XIwGSk2g1UL2bafSRSWt3Ws5z3Z6KMfTmL/6NeiPohnkX9CuCdkClTv6Xd/XNC7MgAkeESEI15aPTmG3ud5O6pki18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WounUNd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260D3C4CEE9;
	Tue, 29 Apr 2025 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745938067;
	bh=MkI4ziZBimRv816hWldVx0OhLFYQifsD85oE9/WnLRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WounUNd0eulkbpb9nJFmNARDRgOJTxWgeMgzH+GDzDf531FCG9u/sJRkf8STQXOoL
	 83QzAImFpqMM1G17D15FJtTsD5R2wn2IrUxESFrKXDJbgRag1YixTQUbloDXDL9vKP
	 7G03r2CI8E4gKGRiQ2KUj7OqbcnX67iSeTmYaeXJnCIRD6WXVycSpTGOnKf9z7zxW7
	 0ki19ufPc6GaekIxi0XTBarycL659yJyvh5/dyGEXVjOretV0Lvgt4QVrAkrJLFZjY
	 K9ViELGkkrG+xpkBX8ccC4JkJra8R3/p33ncT5agcM8OUBX+ecboK5AhAil73NpKrg
	 N8zBNzVv/l9YA==
Date: Tue, 29 Apr 2025 15:47:40 +0100
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, catalin.marinas@arm.com,
	maz@kernel.org, oliver.upton@linux.dev, corbet@lwn.net,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	yangyicong@hisilicon.com, joey.gouly@arm.com, yuzenghui@huawei.com,
	shuah@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, xuwei5@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH v2 1/6] arm64: Provide basic EL2 setup for FEAT_{LS64,
 LS64_V} usage at EL0/1
Message-ID: <20250429144739.GB26174@willie-the-truck>
References: <20250331094320.35226-1-yangyicong@huawei.com>
 <20250331094320.35226-2-yangyicong@huawei.com>
 <957ccba4-2ae1-4358-b62d-3b5c44d7f1ca@arm.com>
 <a520bb9c-839d-fd96-7ecf-365371e65e44@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a520bb9c-839d-fd96-7ecf-365371e65e44@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 07, 2025 at 11:50:45AM +0800, Yicong Yang wrote:
> On 2025/4/3 17:04, Suzuki K Poulose wrote:
> > On 31/03/2025 10:43, Yicong Yang wrote:
> >> From: Yicong Yang <yangyicong@hisilicon.com>
> >>
> >> Instructions introduced by FEAT_{LS64, LS64_V} is controlled by
> >> HCRX_EL2.{EnALS, EnASR}. Configure all of these to allow usage
> >> at EL0/1.
> >>
> >> This doesn't mean these instructions are always available in
> >> EL0/1 if provided. The hypervisor still have the control at
> >> runtime.
> >>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> ---
> >>   arch/arm64/include/asm/el2_setup.h | 12 +++++++++++-
> >>   1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> >> index ebceaae3c749..0259941602c4 100644
> >> --- a/arch/arm64/include/asm/el2_setup.h
> >> +++ b/arch/arm64/include/asm/el2_setup.h
> >> @@ -57,9 +57,19 @@
> >>           /* Enable GCS if supported */
> >>       mrs_s    x1, SYS_ID_AA64PFR1_EL1
> >>       ubfx    x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
> >> -    cbz    x1, .Lset_hcrx_\@
> >> +    cbz    x1, .Lskip_gcs_hcrx_\@
> >>       orr    x0, x0, #HCRX_EL2_GCSEn
> >>   +.Lskip_gcs_hcrx_\@:
> > 
> > minor nit: For consistency, could we rename this "set_ls64", similar to "set_hcrx" ?
> > 
> 
> IIUC, set_xxx really touches the registers and skip_xxx should just check and prepare
> the feature bits. so here using .Lskip_gcs_hrcx_\@ should be more proper and consistent
> with other places in el2_setup.h, like __init_el2_debug/__init_el2_fgt which also use
> .Lskip_xxx for skipping an unsupported feature?

fwiw, I think the label names are fine as you have them.

Will

