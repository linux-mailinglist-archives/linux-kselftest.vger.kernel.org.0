Return-Path: <linux-kselftest+bounces-23996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDFCA043DF
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 16:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F053A45AE
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6F21F2386;
	Tue,  7 Jan 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqI8oUkr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6CA1E377F;
	Tue,  7 Jan 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262810; cv=none; b=UyyY/vjek2VExchkNh6VJCvTqJ6puIb5G/CelxOyGRBwhzAU9b12QpdmFDT5Xg3Sz2pHJH3LY4DUaG9aXCtdi6ZNA0NWtW9kSfBMDbL+9Vvu6NosXroeo4WKBGbtsUcgINwjX/ij5EQkYiy5QKen2eOWze2w2ZNNtSZ4rpp48wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262810; c=relaxed/simple;
	bh=KlzauW3PgDKVIWbsqXawXo+ipjiNK9vtMAkDOh4G9u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPBs5TH2dRnWydVy1YmMbso+MDkBw4U+ydmgl2vSg/cVUNGczDAKyyDaNsIvMPDdb7KtyTdwvOFVG+YtOg9M1qzMqQRQxv2CLsNzGQZHAt5hQXELlp96bAm6iT6+fZ8zTY4OHqHLyWqHnV28FWIWHwdEf9f0hMX/42ymGcpyQaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqI8oUkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B28C4CED6;
	Tue,  7 Jan 2025 15:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736262810;
	bh=KlzauW3PgDKVIWbsqXawXo+ipjiNK9vtMAkDOh4G9u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqI8oUkrsXt02ErcpWwCjOZ0+kwUPWOHvsmYw1hBh1mh2dbvvPVZ2Wan01b2RdMmq
	 Bw12CenQBYNbPpk04NSbiV5xzljPk2/wp7zk8S8ftSdWoxjXND1+v4YblHl6k5MH++
	 uNHKKh5lkGKTiLC++MtN7FoSCbfohmK1LakO9YkIpUsKb9wONt2LAlg9ChpZUQeCgC
	 gSTbiGy0gG/sFw3mPAOPbR2+B5pA6Axb3g0W5e0pQzVNJzKT9fnPA6kZCDwLAs5hes
	 77se1IHjYOYnoA4b3g75FNPn3IB0wloW5wxPW75rT1h/yQj2DgpMdq/V3o4HdF6Rzj
	 HviMJNifgFAPA==
Date: Tue, 7 Jan 2025 15:13:24 +0000
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 5/9] arm64/sysreg: Update ID_AA64SMFR0_EL1 to DDI0601
 2024-09
Message-ID: <20250107151323.GA7368@willie-the-truck>
References: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
 <20241211-arm64-2024-dpisa-v4-5-0fd403876df2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-arm64-2024-dpisa-v4-5-0fd403876df2@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Dec 11, 2024 at 01:02:50AM +0000, Mark Brown wrote:
> DDI0601 2024-09 introduces SME 2.2 as well as a few new optional features,
> update sysreg to reflect the changes in ID_AA64SMFR0_EL1 enumerating them.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/tools/sysreg | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index c792bd3b0afbb5fb7e438a4d760d9f2d15621eee..d78b12c59658b480739ae797f5ea2c2f14d8d765 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1105,6 +1105,7 @@ UnsignedEnum	59:56	SMEver
>  	0b0000	SME
>  	0b0001	SME2
>  	0b0010	SME2p1
> +	0b0011	SME2p2
>  	0b0000	IMP
>  EndEnum
>  UnsignedEnum	55:52	I16I64
> @@ -1169,7 +1170,36 @@ UnsignedEnum	28	SF8DP2
>  	0b0	NI
>  	0b1	IMP
>  EndEnum
> -Res0	27:0
> +UnsignedEnum	27	SF8MM8
> +	0b0	NI
> +	0b1	IMP
> +EndEnum
> +UnsignedEnum	26	SF8MM4
> +	0b0	NI
> +	0b1	IMP
> +EndEnum

afaict, bits 27 and 26 are still RES0 in all the documentation I can
find...

Will

