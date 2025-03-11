Return-Path: <linux-kselftest+bounces-28754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F46A5C9FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 17:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855617AD35D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36F5260A28;
	Tue, 11 Mar 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYrFmUvf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3203BE67;
	Tue, 11 Mar 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708643; cv=none; b=oJt630bvsM/dfK4G+Wup5I2ssXDhMB51+qwuZ68zU7He9A9vwJNTPr8CJ0iz2w85Zn7B7JfQGxzBmqORSboZjthWqlPhQEN/A0RHcMfzzH0BSPvfOBpZ5OcqpaTmTgF7xnrnf/y9rX9tw0sc6/RmanVKshiJjIhx26n79ihu4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708643; c=relaxed/simple;
	bh=BZTxXXA67zvcYZUPAms2o1IQhwkgm/4LnFmDVxI2ONs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYr2aIlSTN/o94qzp9Rn4W0d1sHMmab2lCeBi5Z9jMR6tiuuE4yuIkSfgICtV3+OFV4a8OsfOKKu3+MBMfHHpQgsAnC6RcNoz9RKWA3zPoOYLxY/EU9K2w5lmQgId9TMuiz4JQk8nRjlnYKlvzZd5a5LZGsIBoHGJMYMhWmboGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYrFmUvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D941C4CEEC;
	Tue, 11 Mar 2025 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708643;
	bh=BZTxXXA67zvcYZUPAms2o1IQhwkgm/4LnFmDVxI2ONs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYrFmUvfLJTnTAUuNsvf7jl110FlX1XQjHYJv6UtMkxM487T1UwPjrJnb/KFOOXDY
	 4c/FTYEtU3qswKyPGejNRtq9L4QnNxy+rDETa8i1IAL2MhiMEW+6PJnE6ajqGYLfL8
	 JHDnS7kP7oW2bNHPkridid0tOs53GJHG9msqCSX/ReUA415polcodWwWksAHJXoQwk
	 Q7zbpaLmB369VDgojkiXPq1kNn+gICyoTQ0g91wrOQkty74sa2qKd3by0RjZGS6WNw
	 fqrMTu3Rb7/NHMMay2gFyahQ3CSkmM+sNuZejCnSqzmPMrrEf+Q4+Prhg3OjPWvlZH
	 XOobXYZ3D+D9g==
Date: Tue, 11 Mar 2025 15:57:16 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	praan@google.com, patches@lists.linux.dev
Subject: Re: [PATCH v8 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <20250311155714.GC5138@willie-the-truck>
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 25, 2025 at 09:25:40AM -0800, Nicolin Chen wrote:
> Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
> be the first use case. Since the vsid reader will be the eventq handler
> that already holds a streams_mutex, reuse that to fenche the vmaster too.

"fenche"?

> Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers to set
> or unset the master->vmaster point. Put these helpers inside the existing

s/point/pointer/

> arm_smmu_attach_prepare/commit().
> 
> For identity/blocked ops that don't call arm_smmu_attach_prepare/commit(),
> add a simpler arm_smmu_master_clear_vmaster helper to unset the vmaster.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Pranjal Shrivastavat <praan@google.com>

(per Pranjal: please fix his mis-spelling of his own name here and in
the other patches too!)

> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 28 ++++++++++++
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 45 +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 18 +++++++-
>  3 files changed, 90 insertions(+), 1 deletion(-)

[...]

> @@ -1055,9 +1062,30 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
>  				       struct iommu_domain *parent,
>  				       struct iommufd_ctx *ictx,
>  				       unsigned int viommu_type);
> +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> +				    struct arm_smmu_nested_domain *nested_domain);
> +void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
> +void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
>  #else
>  #define arm_smmu_hw_info NULL
>  #define arm_vsmmu_alloc NULL
> +
> +static inline int
> +arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> +				struct arm_smmu_nested_domain *nested_domain)
> +{
> +	return 0; /* NOP */
> +}

Please drop this comment.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 5aa2e7af58b4..6b712b1ab429 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -85,6 +85,51 @@ static void arm_smmu_make_nested_domain_ste(
>  	}
>  }
>  
> +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> +				    struct arm_smmu_nested_domain *nested_domain)
> +{
> +	struct arm_smmu_vmaster *vmaster;
> +	unsigned long vsid;
> +	int ret;
> +
> +	iommu_group_mutex_assert(state->master->dev);
> +
> +	/* Skip invalid vSTE */
> +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> +		return 0;

Ok, and we don't need to set 'state->vmaster' in this case because we
only report stage-1 faults back to the vSMMU?

With the nits fixed:

Acked-by: Will Deacon <will@kernel.org>

Thanks,

Will

