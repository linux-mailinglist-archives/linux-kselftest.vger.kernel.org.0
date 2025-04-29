Return-Path: <linux-kselftest+bounces-31954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A28FAA3B84
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ADBD7B749C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680CD25E82A;
	Tue, 29 Apr 2025 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwWvexLT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C540254AE1
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965953; cv=none; b=jDXSx2a3efXXTN2pEYH5F+LMNRU0Ey+9nwNnNphw/IQM5gICgtxJN1mevpnhPEjURQjTL+uDFpxBCkyb3pVvZKQ5uyJoq148jjcQV6kfjN+bN/ymAz6txPQugyVwxpoDXiPkPJKl7IN0xoq0G/p8Qsg24h0G0UrNQtNiaQrQ4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965953; c=relaxed/simple;
	bh=XyBy/9ECM3Ji4+OBncyGrKzNcU3QNO+8BOFD1+2XlAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYyDPmq4Ehy93c15e3OtH4r6nS1XY8oX5u0UfUUt2AnfrtNU599VtQ8E8EOZU4u29PMkjsSeCrMn0PO54/lKq+qYTyFWQupaxDRc40dSn8gdal5NX6W/iORHpYU4fBjoIhu4Y2VUvFv/q0QDzxH88e7o6AlKNrcadcKcN/BEt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwWvexLT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2263428c8baso88105ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 15:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745965951; x=1746570751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AnNdE+HhwllnOl/nQBW5AcYsgv32dfnq2/SzhhfRlf8=;
        b=rwWvexLTBdEWejSdxauOPCNpXzoZ9paZdJBwWQybvKf7xKXfHvi3y/7Io2hVYwmOrQ
         wXFBCF1Ia3MSMqI3+szJNyc5GxkwJR5cGs5OChQ2FACg8mkDGxzuJzggVaC/rRjyyals
         SfSt/4RSYtBxtFmzXJKkXrv+70QaQuLDi2wD7rwd2M0SeCSDJq7LdsuqWrY7p9rjX5sx
         raMfYPyv69hsPVZnMA/2MwiaEMFzEO+UpRnATSq2t9I41l+5jRpnihcqWvcm1gVyjryX
         +uNOYFSLtl67QgqBFZXzBpXi9nwFVNNgFf51MvskDcCNS+2Pq82HK37B/VnK+FJgjx9+
         oysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745965951; x=1746570751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnNdE+HhwllnOl/nQBW5AcYsgv32dfnq2/SzhhfRlf8=;
        b=Oafg2/6FMZg/f+H8zmzmiu6xON4MUkko3oQUiCTEMOoO9+aPNap4vaJYTKf1zlMdmQ
         LHUjlDL8AR4Jv85eKVYPWez3rW6ZI8LHXSY8ucpc/OY56DDxRl1kT788oU+lG+J14ZYE
         12iLX3IlWbybFKVgpxjUVTZeLVFIRgrU/EvYFFn+iMXy7dSudRmUIPS5TE29m4B2fYIS
         Wf/Ow8M2lfQ2M6urMy5VBGlFa6eIWEwWEOfPSmc52JVEwKjIfpVZJytPrg3lJmFEiQbF
         lyj5Tykppyo8nrLlKZETzUo886ImpMk+Ul9i4DwtODusYpsZwTWUSt5Qp2BQzTcGVSWc
         1GRg==
X-Forwarded-Encrypted: i=1; AJvYcCVNiKoJD247SiSgVsgcklFFbeSdnLSmqvVek2mv2CA6VoZkATDIN6/GmfcrukbpWDfG16/fcZhO63iIgrGYut4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynudLFMav74J4EN5VBkaWa+sZ2FDRPjAMi8zaP7nKQeSOcvklW
	NIMhCrAy9R5+IxeftV3H4BEzyaNeQrqOAOxE4dM1/tS90oep8BhfTTq87E4SMQ==
X-Gm-Gg: ASbGncvWSLlNxrFhuig1qvtx/sSv3cyD9aK2n5v65612SZSDsDbpfDLnM5HAORUs0Ft
	XWylHjb5wmR16p6BsetenUVB5cbEO8zHiE62CLIPYfuUCwIDQmqeOA8BhpvNGOoH+7G72jMPzY9
	odnWGnue/Ub4ddchPHEHTTC6OzZ9uTf6NUKpCX0IqudQSoqG48v+EPhyPvj8U+ovP9gCLD1452Q
	YHZ9pesmAueewQbaEb15M4RNpdJLO8lcOxRwsFWVKZ/UDQyoIZlkNY2CEdqfVKYkpJjP+OLcIyW
	xrgz3FdqgP5n1YFNPyjWqW4o3TYq2TD6VDPj5xkNsBszuCupNm1O8bf1uBE3muJZ/cJv2GZC
X-Google-Smtp-Source: AGHT+IEjjGwm4LgyP1atx5l0JHqL9FPxuMAodaX4BR9dLcCBJPPs8xL/z9odFgYaKsV2MBnWB05wdw==
X-Received: by 2002:a17:903:1a24:b0:223:4b4f:160c with SMTP id d9443c01a7336-22df5496af5mr477235ad.27.1745965950581;
        Tue, 29 Apr 2025 15:32:30 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7403991f046sm236228b3a.41.2025.04.29.15.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:32:30 -0700 (PDT)
Date: Tue, 29 Apr 2025 22:32:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 20/22] iommu/tegra241-cmdqv: Do not statically map
 LVCMDQs
Message-ID: <aBFTc1Q1r_jrnJ63@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <3981a819a4714b21d11d5c6de561a2d0c6411947.1745646960.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3981a819a4714b21d11d5c6de561a2d0c6411947.1745646960.git.nicolinc@nvidia.com>

On Fri, Apr 25, 2025 at 10:58:15PM -0700, Nicolin Chen wrote:
> To simplify the mappings from global VCMDQs to VINTFs' LVCMDQs, the design
> chose to do static allocations and mappings in the global reset function.
> 
> However, with the user-owned VINTF support, it exposes a security concern:
> if user space VM only wants one LVCMDQ for a VINTF, statically mapping two
> LVCMDQs creates a hidden VCMDQ that user space could DoS attack by writing
> ramdon stuff to overwhelm the kernel with unhandleable IRQs.
> 

Nit: I think it's worth mentioning that the current HW only supports 2
LVCMDQs. Since it's not clear from the driver as it calculates this by:

        regval = readl_relaxed(REG_CMDQV(cmdqv, PARAM));
        cmdqv->num_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2,regval);
        cmdqv->num_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
	cmdqv->num_lvcmdqs_per_vintf = cmdqv->num_vcmdqs / cmdqv->num_vintfs;

Or maybe, re-word it to "if user space VM only wants one LVCMDQ for a
VINTF, the current driver statically maps num_lvcmdqs_per_vintf which
creates hidden vCMDQs [..]"

> Thus, to support the user-owned VINTF feature, a LVCMDQ mapping has to be
> done dynamically.
> 
> HW allows pre-assigning global VCMDQs in the CMDQ_ALLOC registers, without
> finalizing the mappings by keeping CMDQV_CMDQ_ALLOCATED=0. So, add a pair
> of map/unmap helper that simply sets/clears that bit.
> 
> Delay the LVCMDQ mappings to tegra241_vintf_hw_init(), and the unmappings
> to tegra241_vintf_hw_deinit().
> 
> However, the dynamic LVCMDQ mapping/unmapping can complicate the timing of
> calling tegra241_vcmdq_hw_init/deinit(), which write LVCMDQ address space,
> i.e. requiring LVCMDQ to be mapped. Highlight that with a note to the top
> of either of them.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 37 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 8d418c131b1b..869c90b660c1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -351,6 +351,7 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
>  
>  /* HW Reset Functions */
>  
> +/* This function is for LVCMDQ, so @vcmdq must not be unmapped yet */
>  static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
>  {
>  	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
> @@ -379,6 +380,7 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
>  	dev_dbg(vcmdq->cmdqv->dev, "%sdeinited\n", h);
>  }
>  
> +/* This function is for LVCMDQ, so @vcmdq must be mapped prior */
>  static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
>  {
>  	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
> @@ -404,16 +406,42 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
>  	return 0;
>  }
>  
> +/* Unmap a global VCMDQ from the pre-assigned LVCMDQ */
> +static void tegra241_vcmdq_unmap_lvcmdq(struct tegra241_vcmdq *vcmdq)
> +{
> +	u32 regval = readl(REG_CMDQV(vcmdq->cmdqv, CMDQ_ALLOC(vcmdq->idx)));
> +	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
> +
> +	writel(regval & ~CMDQV_CMDQ_ALLOCATED,
> +	       REG_CMDQV(vcmdq->cmdqv, CMDQ_ALLOC(vcmdq->idx)));
> +	dev_dbg(vcmdq->cmdqv->dev, "%sunmapped\n", h);
> +}
> +
>  static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
>  {
> -	u16 lidx;
> +	u16 lidx = vintf->cmdqv->num_lvcmdqs_per_vintf;
>  
> -	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++)
> -		if (vintf->lvcmdqs && vintf->lvcmdqs[lidx])
> +	/* HW requires to unmap LVCMDQs in descending order */
> +	while (lidx--) {
> +		if (vintf->lvcmdqs && vintf->lvcmdqs[lidx]) {
>  			tegra241_vcmdq_hw_deinit(vintf->lvcmdqs[lidx]);
> +			tegra241_vcmdq_unmap_lvcmdq(vintf->lvcmdqs[lidx]);
> +		}
> +	}
>  	vintf_write_config(vintf, 0);
>  }
>  
> +/* Map a global VCMDQ to the pre-assigned LVCMDQ */
> +static void tegra241_vcmdq_map_lvcmdq(struct tegra241_vcmdq *vcmdq)
> +{
> +	u32 regval = readl(REG_CMDQV(vcmdq->cmdqv, CMDQ_ALLOC(vcmdq->idx)));
> +	char header[64], *h = lvcmdq_error_header(vcmdq, header, 64);
> +
> +	writel(regval | CMDQV_CMDQ_ALLOCATED,
> +	       REG_CMDQV(vcmdq->cmdqv, CMDQ_ALLOC(vcmdq->idx)));
> +	dev_dbg(vcmdq->cmdqv->dev, "%smapped\n", h);
> +}
> +
>  static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
>  {
>  	u32 regval;
> @@ -441,8 +469,10 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
>  	 */
>  	vintf->hyp_own = !!(VINTF_HYP_OWN & readl(REG_VINTF(vintf, CONFIG)));
>  
> +	/* HW requires to map LVCMDQs in ascending order */
>  	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++) {
>  		if (vintf->lvcmdqs && vintf->lvcmdqs[lidx]) {
> +			tegra241_vcmdq_map_lvcmdq(vintf->lvcmdqs[lidx]);
>  			ret = tegra241_vcmdq_hw_init(vintf->lvcmdqs[lidx]);
>  			if (ret) {
>  				tegra241_vintf_hw_deinit(vintf);
> @@ -476,7 +506,6 @@ static int tegra241_cmdqv_hw_reset(struct arm_smmu_device *smmu)
>  		for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
>  			regval  = FIELD_PREP(CMDQV_CMDQ_ALLOC_VINTF, idx);
>  			regval |= FIELD_PREP(CMDQV_CMDQ_ALLOC_LVCMDQ, lidx);
> -			regval |= CMDQV_CMDQ_ALLOCATED;
>  			writel_relaxed(regval,
>  				       REG_CMDQV(cmdqv, CMDQ_ALLOC(qidx++)));
>  		}

I can't confirm HW behaviour but the changes make sense to me.

Acked-by: Pranjal Shrivastava <praan@google.com>

Thanks!

> -- 
> 2.43.0
> 

