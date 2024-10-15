Return-Path: <linux-kselftest+bounces-19716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA399E164
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 10:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF67D1F23266
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 08:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C701CC8B1;
	Tue, 15 Oct 2024 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj+yDT/W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106C20EB;
	Tue, 15 Oct 2024 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981810; cv=none; b=pvQdQmP1rQcsYdtEaMyYzOO+OLVMwmYfMEqgtCtIeXn3TahvyMuzZB8b9UJjmFzXqI5NFFLpD9AuGrb6dya+++UNI1K6b9zR5VYcnxb8jO8f4lLk1Z39as4Z2SSO/JK2n36qIQR4YxVNjJqJ0Eq2GYMbIXHcezVgx7/h9I1yzQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981810; c=relaxed/simple;
	bh=06dJZHS66A71lj9oUznmqWr9W6VxU6J1K+HYBMM/Tk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNlmIykVIxxhn+xHAOw1H9Wi3stfBtpeeUcW0FwZ6aYC/JgoJ4LIqXu12/6k4KxRQqPm6h4qS9xjSZIW/80FmLiQiuv35PKBBBb1LOqkVGSPgPEP8Z/YQoKrxdZDnA2tIrB+O5CFj2tX8QbVvwjNb4l05tJztKvdVlQamX+/bmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj+yDT/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD3DC4CEC7;
	Tue, 15 Oct 2024 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728981810;
	bh=06dJZHS66A71lj9oUznmqWr9W6VxU6J1K+HYBMM/Tk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nj+yDT/WdHuYCim03XBhU4w8EJ/W+IaCk0xR/MyZ8sfgPXrUcbla4DjTUK1juVkJg
	 0ges5wq9+8fIZiFV9f0ao7hbBXWaaBTELnxgmXACbzE6Fo7+btlkJZla0GeSuHcuP8
	 gZ9bK3cSL28BGxqxKQ0uSEddNERzFz/jeIAtlB4b4nQa1w7i6Q+C2XER0qCJyObfDx
	 8qQTHE6Yy5/qvUujsW7xlnFR3N+WEfSNueuQGDn11vyvOokFeS+H6YdfrMUhulrxqF
	 p26dcfVHZJrRpVfFCLnf6UPH5t80Um1sEAGFvh2OmoBmywTteK0HASsE7K+6k2fSXy
	 WorJbexAL+lXw==
Date: Tue, 15 Oct 2024 09:43:24 +0100
From: Will Deacon <will@kernel.org>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, alex.williamson@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	zhenzhong.duan@intel.com, linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: Re: [PATCH v2 5/6] iommu/arm-smmu-v3: Make smmuv3 set_dev_pasid() op
 support replace
Message-ID: <20241015084322.GA19079@willie-the-truck>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-6-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912130427.10119-6-yi.l.liu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Sep 12, 2024 at 06:04:26AM -0700, Yi Liu wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> set_dev_pasid() op is going to be enhanced to support domain replacement
> of a pasid. This prepares for this op definition.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 8 +++++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 2 +-
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 645da7b69bed..1d3e71569775 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -349,7 +349,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
>  	 * get reassigned
>  	 */
>  	arm_smmu_make_sva_cd(&target, master, domain->mm, smmu_domain->cd.asid);
> -	ret = arm_smmu_set_pasid(master, smmu_domain, id, &target);
> +	ret = arm_smmu_set_pasid(master, smmu_domain, id, &target, old);
>  
>  	mmput(domain->mm);
>  	return ret;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ed2b106e02dd..f7a73b854151 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2824,7 +2824,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  }
>  
>  static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
> -				      struct device *dev, ioasid_t id)
> +				     struct device *dev, ioasid_t id,
> +				     struct iommu_domain *old)
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> @@ -2850,7 +2851,7 @@ static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
>  	 */
>  	arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
>  	return arm_smmu_set_pasid(master, to_smmu_domain(domain), id,
> -				  &target_cd);
> +				  &target_cd, old);
>  }
>  
>  static void arm_smmu_update_ste(struct arm_smmu_master *master,
> @@ -2880,7 +2881,7 @@ static void arm_smmu_update_ste(struct arm_smmu_master *master,
>  
>  int arm_smmu_set_pasid(struct arm_smmu_master *master,
>  		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
> -		       struct arm_smmu_cd *cd)
> +		       struct arm_smmu_cd *cd, struct iommu_domain *old)
>  {
>  	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
>  	struct arm_smmu_attach_state state = {
> @@ -2890,6 +2891,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>  		 * already attached, no need to set old_domain.
>  		 */
>  		.ssid = pasid,
> +		.old_domain = old,

nit: The existing comment says "no need to set old_domain" and now you're
doing exactly that! Please can you update the commentary (probably just
remove the comment entirely)?

Cheers,

Will

