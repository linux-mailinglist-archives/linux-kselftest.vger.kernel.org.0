Return-Path: <linux-kselftest+bounces-37134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F83B02170
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6C8A65439
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFE52EF293;
	Fri, 11 Jul 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apaK87ld"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573627A91D;
	Fri, 11 Jul 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250475; cv=none; b=EYgE52+XwH8M6RK/kkDyq5CL4iT5ztCyHmrhxyOCJw8RE2BWUVqVE0SFNmsUiTqYC37MXg/eSmvmH3g7qhUBc/BB6r6szE636qJFCHafmkmI/RZx+qz8PR6dNHm9RFhrjIdXRi/CcgsNR7xvH8DMPUZzFJzZYLh+7iHSgmZJIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250475; c=relaxed/simple;
	bh=GmeNQXQW8OBcvcvO6HZildjusv3m9QHJ5AApHT58lZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEbV3Zo936yeDfKstY3qSl5Jn8x8+HyASDNN8T/sYYeDYWuzY6fDUzAXh3AyNqUCRA/zI3Ymqpfnj1FdiyyPq/Vl3tadOCADxxZiTrIxNaNFRCBoU7RjFT/OesvHGA7IxAoTw3xKYybWUpjviMU/8utjSawL0vyyh0xKODw7z4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apaK87ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C421C4CEF5;
	Fri, 11 Jul 2025 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752250475;
	bh=GmeNQXQW8OBcvcvO6HZildjusv3m9QHJ5AApHT58lZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apaK87ldOYn5FK2tDeGRDePprHq+beg+q9HsLOWJ2j13cMBCS6+mx0WcltPJsdS3w
	 CzYun59+ByQ3TdmVIVWrGlL/W8WcIzaPbfTXsbA5FtiIxqz5ZbhVvShMT6Uf9cL0PN
	 4ytZp94nPA10Y7DtWLizwiEYUSknZl+OyAs0DUYaItDecpCuVhE4QDWkqNIHSJi7sp
	 LWi25pGc9/uHHZ07X+TmzULZC8hajpmCywurY5p6K7szAY7mgPFz6xddS8AdBVgpm6
	 fmH0Ugvb/IhmTZU+IPSaCKy2NvVBQrpYO4pajykZ1XzB949TL/eMqMY5t9EE4AzX1R
	 jyy6Psd53fAxQ==
Date: Fri, 11 Jul 2025 17:14:27 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v9 23/29] iommu/arm-smmu-v3-iommufd: Add vsmmu_size/type
 and vsmmu_init impl ops
Message-ID: <aHE4Y-fbucm-j-yi@willie-the-truck>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <375ac2b056764534bb7c10ecc4f34a0bae82b108.1752126748.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <375ac2b056764534bb7c10ecc4f34a0bae82b108.1752126748.git.nicolinc@nvidia.com>

Hey Nicolin,

On Wed, Jul 09, 2025 at 10:59:15PM -0700, Nicolin Chen wrote:
> An impl driver might want to allocate its own type of vIOMMU object or the
> standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3 by setting up its own SW/HW bits, as
> the tegra241-cmdqv driver will add IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.
> 
> Add vsmmu_size/type and vsmmu_init to struct arm_smmu_impl_ops. Prioritize
> them in arm_smmu_get_viommu_size() and arm_vsmmu_init().
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 5 +++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 8 ++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index c1ced4d4b6d1..6183f212539a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -16,6 +16,7 @@
>  #include <linux/sizes.h>
>  
>  struct arm_smmu_device;
> +struct arm_vsmmu;
>  
>  /* MMIO registers */
>  #define ARM_SMMU_IDR0			0x0
> @@ -720,6 +721,10 @@ struct arm_smmu_impl_ops {
>  	int (*init_structures)(struct arm_smmu_device *smmu);
>  	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
>  		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
> +	const size_t vsmmu_size;
> +	const enum iommu_viommu_type vsmmu_type;
> +	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
> +			  const struct iommu_user_data *user_data);

It would be nice to avoid adding data members to the ops structure, if
at all possible. The easiest thing would probably be to add a function
for getting the vsmmu size and then pushing the two checks against
'vsmmu_type' down into the impl_ops callbacks so that:

  1. If the type is IOMMU_VIOMMU_TYPE_ARM_SMMUV3, we don't bother with
     the impl_ops at all in arm_vsmmu_init() and arm_smmu_get_viommu_size()

  2. Otherwise, we pass the type into the impl_ops and they can check it

Of course, that can be a patch on top of the series as there's no point
respinning the whole just for this.

Cheers,

Will

