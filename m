Return-Path: <linux-kselftest+bounces-23113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF50C9EB77E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33042820D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7D233D70;
	Tue, 10 Dec 2024 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOUMN7Tc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D61C07ED;
	Tue, 10 Dec 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850601; cv=none; b=FN06FKpDrMdHqbq7m608K2Np+NTqIWxh83BiksMr9K8QEkU6D68M0y/VeIji+v8OZJIi1HsFQU7TVzKcyxAfy//IBLmVyt0IBTlo8sjm6S/URF2978RTvMIv/ffdpR8VlWFP61n4ZMJ1GHSIdZXeEKIKtKfn/OfLs1wOASWjHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850601; c=relaxed/simple;
	bh=2Lcmq7SHHNoVqPiQ1a9keIwEUzJcb799Uq6YwdCactM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0EvRMsV2i44n6gJstgYUNE0tT/aeWNQSFV79zoODV2vfW41MPHJi5C9D4qLSDLhfv7tSrW91H/rOmLqMhBsc3Rl0Rpug61VjrVhQeMYW2XjXHKplXi93mPUQFr3VrM9Ruj5UuT85B2r0MZfdyTGxGPOpEOy6hl8GkWwyi3/oOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOUMN7Tc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783CAC4CED6;
	Tue, 10 Dec 2024 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733850600;
	bh=2Lcmq7SHHNoVqPiQ1a9keIwEUzJcb799Uq6YwdCactM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOUMN7Tc4of6hly92PWfFlwTA8xXM7VUYU4bNYDTSXF5sc6BM3VXU2Vig0QEc+AEe
	 B1bLwSJepN5c33ArBzRH/+2pfEq9bq/zGF3WIdULrNuXpP1H/DUZTn6BTurWdhn31k
	 lgmllm0L8VibP5t8qgXhC4Z5W443RodVG3Kh8Bfkaz6ttEMteL6rd+fiatbPoa3jit
	 zTzD5bHnDOW6C3AMOBf8ljeQk7bvJny9XNdkjva9Qx+j/8MPGE1Iv58QlOzoj6xPJV
	 WzOXQUuppv12EqtG5qRvWoW22GOh7S6MNxeGdySvWKax0o1KLpqnuF3pGZAb20h7hq
	 lhndv/N0MNHSg==
Date: Tue, 10 Dec 2024 17:09:55 +0000
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
Subject: Re: [PATCH v3 2/9] arm64/sysreg: Update ID_AA64ISAR3_EL1 to DDI0601
 2024-09
Message-ID: <20241210170953.GB16075@willie-the-truck>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
 <20241203-arm64-2024-dpisa-v3-2-a6c78b1aa297@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203-arm64-2024-dpisa-v3-2-a6c78b1aa297@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 03, 2024 at 12:39:21PM +0000, Mark Brown wrote:
> DDI0601 2024-09 defines several new feature flags in ID_AA64ISAR3_EL1,
> update our description in sysreg to reflect these.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/tools/sysreg | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 911f16c82ebd3ee98ffed965b02a5c6b153bc50c..c5af604eda6a721cedf5c9c68d6f7038156de651 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1566,7 +1566,23 @@ EndEnum
>  EndSysreg
>  
>  Sysreg	ID_AA64ISAR3_EL1	3	0	0	6	3
> -Res0	63:16
> +Res0	63:32
> +UnsignedEnum	31:28	FPRCVT
> +	0b0000	NI
> +	0b0010	IMP
> +EndEnum
> +UnsignedEnum	27:24	LSUI
> +	0b0000	NI
> +	0b0010	IMP
> +EndEnum
> +UnsignedEnum	23:20	OCCMO
> +	0b0000	NI
> +	0b0010	IMP
> +EndEnum
> +UnsignedEnum	19:16	LSFE
> +	0b0000	NI
> +	0b0010	IMP

These IMP encodings look wrong to me -- the document you reference in
the commit message uses 0b0001 for the "implemented" cases.

Can we _please_ just generate this stuff. It feels like we've been
making silly typos over and over again with the current approach so
either it's hard or we're not very good at it. Either way, it should be
automated.

Others have managed it [1], so it's clearly do-able.

Will

[1] https://github.com/ashwio/arm64-sysreg-lib

