Return-Path: <linux-kselftest+bounces-37489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C09B0886B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 10:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142223AEDF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F1B2877ED;
	Thu, 17 Jul 2025 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOSFBXon"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5C2853E3;
	Thu, 17 Jul 2025 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742186; cv=none; b=Uul8sWlVTomaex982JqSC8EbBKpVxEX5L2kKwhkJ6Hpav+q2z9xZWvmEYcAuamGBRoT1haz8PgvlWlpoV2ckRKH9CkMJfdcGe8yjupa6HX1wARcDSO9QMX06P1/4uXOtHdGF5ZS7a4blva+xD93Pcnlze5bel0KXAu+dzuM3b4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742186; c=relaxed/simple;
	bh=1LaZMmufVKTiGZ1B+WdO3aR89rghURP6uEd2rsuld3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL9e5oKlUjS9ucQ5mjvUh0BU+g6Brv0/KYcuskKS5IiJ5gO/O9ejZfHvaT7wdQQxAbncbTszZJ6Ar3tQUoqCR1qXM1h/GqGkV6bE0/KFYryhjpPIDQC9eTIi1vqTSivu0pVsN5eDbZZLv4Z5Vihy50P8PEbKVnJNvUyU327jMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOSFBXon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DE7C4CEED;
	Thu, 17 Jul 2025 08:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752742185;
	bh=1LaZMmufVKTiGZ1B+WdO3aR89rghURP6uEd2rsuld3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lOSFBXonALTq4dkOywT4xN2hhzCqX0iqVkTVuJJXa9C+H+FN9PkqbyO++9Mocnm5o
	 TlSekzaBH6Pn6oaDakF4NIRz9K9B0pwRmhyf+81WMF80SRwwOorv57DUCjzoItdwyd
	 fdIzVUxI4Yl0bgZ+BGfo5jzvRmFTSlYhMP3KZDlQmlmYMRbLb8vbR96EOxqttldm3L
	 CFoa7CpqGqfB6RZzgn4zJcdDjgdvfFCG1ShybgH1FM1Ka+fDvFUC076bL5DklbnXZE
	 fOQ+SImE0z8OiZQtbxTElodRLlanUXmH1gehrnxsHT95TTc4+Ty6LK1an5NU6FSeg6
	 vSiIYpw/35h/g==
Date: Thu, 17 Jul 2025 09:49:37 +0100
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
Message-ID: <aHi5IUXqHJZGB67M@willie-the-truck>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <375ac2b056764534bb7c10ecc4f34a0bae82b108.1752126748.git.nicolinc@nvidia.com>
 <aHE4Y-fbucm-j-yi@willie-the-truck>
 <aHahEP0+LKmeA/Tf@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHahEP0+LKmeA/Tf@Asurada-Nvidia>

Hi Nicolin,

On Tue, Jul 15, 2025 at 11:42:24AM -0700, Nicolin Chen wrote:
> Sorry for the late response.

No problem at all.

> On Fri, Jul 11, 2025 at 05:14:27PM +0100, Will Deacon wrote:
> > >  /* MMIO registers */
> > >  #define ARM_SMMU_IDR0			0x0
> > > @@ -720,6 +721,10 @@ struct arm_smmu_impl_ops {
> > >  	int (*init_structures)(struct arm_smmu_device *smmu);
> > >  	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
> > >  		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
> > > +	const size_t vsmmu_size;
> > > +	const enum iommu_viommu_type vsmmu_type;
> > > +	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
> > > +			  const struct iommu_user_data *user_data);
> > 
> > It would be nice to avoid adding data members to the ops structure, if
> 
> You mean the "vsmmu_size" and "vsmmu_type" right?

Yup.

> So you want them to be removed, by having two impl_ops:
> 	size_t get_vsmmu_size(enum iommu_viommu_type vsmmu_type);
> 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
> 			  const struct iommu_user_data *user_data);
> 
> right?

Yes, please.

> > at all possible. The easiest thing would probably be to add a function
> > for getting the vsmmu size and then pushing the two checks against
> > 'vsmmu_type' down into the impl_ops callbacks so that:
> > 
> >   1. If the type is IOMMU_VIOMMU_TYPE_ARM_SMMUV3, we don't bother with
> >      the impl_ops at all in arm_vsmmu_init() and arm_smmu_get_viommu_size()
> 
> Hmm, I was hoping for an implementation could support the default
> IOMMU_VIOMMU_TYPE_ARM_SMMUV3 while having its own viommu_ops or so.
> But I think your suggestion is fine since there is no such a use
> case at this moment :)
> 
> >   2. Otherwise, we pass the type into the impl_ops and they can check it
> > 
> > Of course, that can be a patch on top of the series as there's no point
> > respinning the whole just for this.
> 
> Thanks for that! I can draft a patch to send later this week once
> the requirements are confirmed.

Thank you!

Will

