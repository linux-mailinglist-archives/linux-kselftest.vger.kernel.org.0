Return-Path: <linux-kselftest+bounces-28753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEE6A5C9EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 16:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22633AAA2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A0525F97A;
	Tue, 11 Mar 2025 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcnlOA/q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139ABBE67;
	Tue, 11 Mar 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708606; cv=none; b=Xnv5v2lZIstkepsSmg5TinbO4N1WekQEqvVbJsmxrpGOmxHRSfOJxnewR7HlmdlWC+03c9pZwH5vEz0T/iVdDMQfL7+3G1r6XVUr531ngkwuR9NKnfHGmgLTVFjE2impSWqVCQfRFHYMh3hgu2dGypUyIY24oadB8LTYPycQr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708606; c=relaxed/simple;
	bh=oEeQH0rYsSmg/7HCVUBRlhhmZdZyZi/GX5wONFWTHl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5IWyWLGZGL06urENCSNfgap3/dT3yeZar5pEei+MNjDn16KmyhaJF3co/p0hjmi4Wt3TEYbdWQtO2ICpXEQu9qbaWubxGL0rLvTvYpWi14stsB5P00DAA2uWH9VaTXpKSh2DH2qeYQGhvmpNvsrtoVeGP08Mz54LaWTbiDMLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcnlOA/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB9BC4CEE9;
	Tue, 11 Mar 2025 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708605;
	bh=oEeQH0rYsSmg/7HCVUBRlhhmZdZyZi/GX5wONFWTHl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QcnlOA/qtl72u3TDbJ1lf5HzJDDK9/N8eROvzhHYwUPmLATxHcUICDp1hen1ndWir
	 QGrBaBLrloZ7IFp6BYHm2IMG4+VwbkSBkGHF1qrshStzbv7DHNFg4gPXvE5fo3WjgX
	 4/XlzVZI4/r1m57wwzgx1uduuvYjlhGsDCZay6LW5wp+DkG2HmyNbSQxmIJIC89jwU
	 KtSVHfGnazLTFG1Efm66DhlGr+JHhimScQAV4myEuW1z+fZ4jqXKte9R2qSZ8AP7u4
	 zeNzULL0UmeWh6K/LQUNjQTW/r6Hh4au+GPL0jwjnQaw2kET6KZh8AzKhc8f3SuZvL
	 CwMtNKQ2dHnvQ==
Date: Tue, 11 Mar 2025 15:56:38 +0000
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
Subject: Re: [PATCH v8 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <20250311155637.GB5138@willie-the-truck>
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <7f6813dc2b62f5f396ac3172dc2a7d9bf3b47536.1740504232.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f6813dc2b62f5f396ac3172dc2a7d9bf3b47536.1740504232.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 25, 2025 at 09:25:41AM -0800, Nicolin Chen wrote:
> Aside from the IOPF framework, iommufd provides an additional pathway to
> report hardware events, via the vEVENTQ of vIOMMU infrastructure.
> 
> Define an iommu_vevent_arm_smmuv3 uAPI structure, and report stage-1 events
> in the threaded IRQ handler. Also, add another four event record types that
> can be forwarded to a VM.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Pranjal Shrivastavat <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++
>  include/uapi/linux/iommufd.h                  | 23 +++++++
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 17 ++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 60 +++++++++++--------
>  4 files changed, 82 insertions(+), 25 deletions(-)

[...]

> @@ -1866,7 +1869,14 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
>  		goto out_unlock;
>  	}
>  
> -	ret = iommu_report_device_fault(master->dev, &fault_evt);
> +	if (event->stall) {
> +		ret = iommu_report_device_fault(master->dev, &fault_evt);
> +	} else {
> +		if (master->vmaster && !event->s2)
> +			ret = arm_vmaster_report_event(master->vmaster, evt);
> +		else
> +			ret = -EOPNOTSUPP; /* Unhandled events should be pinned */
> +	}

nit: You don't need this extra indentation.

Patch looks fine:

Acked-by: Will Deacon <will@kernel.org>

Will

