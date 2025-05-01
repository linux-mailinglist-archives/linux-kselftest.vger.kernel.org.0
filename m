Return-Path: <linux-kselftest+bounces-32102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C16EAA65CC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319D77A3150
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 21:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D88721B9E7;
	Thu,  1 May 2025 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTkceKgU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E418024
	for <linux-kselftest@vger.kernel.org>; Thu,  1 May 2025 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746136006; cv=none; b=R9v/0B5KWb9VrdZuijmPn7f/ukspiIQhm/tmJeAdSvvVEeOBdgoPY70vvtJzYYE5cdS7jHHbAG1jhlRczLp2Fd3bWP0gNbkX22FkYmf3xwq95W0L9SOsifc01AMBaze3e90ACY7VZ+aXYD2iCv3ZJFAPnF2I2mVlVfi0slqEXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746136006; c=relaxed/simple;
	bh=zREa4RUqnytl3tRJyZ1VEkek+EoTDe7j9JuQy8pDoNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EL6Y4ShZK1lxTdRNHeMV1RRT5YoP6dLQiWW2mriCeOGY83o2UQoLehJpUP2D/J7sevdwwhKeZEfFlOyqz1Z3XKT4ejYxQ+HifcVv9xFaM6RBP5nG1L7xmVTa5z9zAJYZpUZ1ZLyANWOjBqBxLkf/Uwnsq4LO9nio4f1fnhy5Uhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTkceKgU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240aad70f2so60765ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 01 May 2025 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746136004; x=1746740804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9r6A8pjeBdT9CIMooiOuLDzT6g9hy9vPLljDSfADzUo=;
        b=oTkceKgU1fwRgCeiBHdOVVleK0UQDBd+qgip2AN1ETiW458Z9oPH/rWRCS5P6VDz8Y
         hzqu+S9m/CAx6+VisWqhD216nV+O2FVPrbFB/KlO8gWXeDZqZxq+SGGzz90Vw+cMD4VS
         iwQjU63Y5e1YPHMqm0H1UhxQGUbpf1Nahts4M3wp5r2CYj6b0r8UnM/ZtuqQ70D18qHK
         N1NTIU++zFzlcF5s2ll+4A7ddH2Xd985B4eX63VWoO29ZqibvoZ+0hZX0AUHOXDRkUeb
         s29B34ksf2fhViKkv5qeKgbB16+vOVf12knKFWz4cmb4GQWZPot6VQdmKBCNg/bcgX5c
         kfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746136004; x=1746740804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r6A8pjeBdT9CIMooiOuLDzT6g9hy9vPLljDSfADzUo=;
        b=kmYkWRj/4bOCi5uI4fUIZjU+33vFiNwmtjRaWLPyBU8DaEK3DZ6V0btJKzb6WRQeqL
         6xAv7eD9CV0ShoQFuPyylvw6lzB+qAptNozCeuniw445V3S8yZj43Mv3ACTr5qX0LWRO
         LT5Zm5Mq7pNja0QrH6JbuC1ASCB7967tVIM/fokaKQqVzmUOF/qxK9VPiY4UsfyE4XRj
         rimtIXbalUR3ZhH91S0l5v1DWL4Qp2mIwjBAPX2kf79GxntX+dXgjeWMvLjK2RhhkBq5
         5uXJjlVLwwp1RD8S3vNYg1l1EcsFjmoooxuoF0tiBojijnbabeABkhruZmjJwPZclhg6
         jRlA==
X-Forwarded-Encrypted: i=1; AJvYcCUK8FzCwZ1KJfmymiDexRiZAZPdCCIZjNiPAdrCB5+frK1AZxJKylREbGU0oNe2zsPfs3L5IM0I7frLIQ5pjPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhDeuGhE31lXMfQSpS3c3FOJ5QMWLR4ey4DEoa9vDfYJzmk3l
	mhEVG1bKmMuKcOuRmTxYdptluqQr1L/r4alkuLdREcu+M1QAvKHmy6c/A7dKnQ==
X-Gm-Gg: ASbGnctHDh+l54Pi+YagDDRdujGVurRkI6Wx7MlJyGw3WgwH7mofIM5j8xAHDCgCfi6
	1yh5SGeACrtam0FvAMklwhan037ReM/A/Hk4HsyhbeOf14xrciHhwBlYeYF7uUGPD98PCcpanLg
	BYpjYM4uwyvSERZPnaQlQNSeMq/PZnbi/J25CD70PgNjlafRVak+SjFovmOfkDC8NmuVoDubrP+
	2Ipwu9W8BAgBcMBg4OiEbyAgzKMaYIrJgqyVTgIOwgpj6CAiIBFZjsAgfOMCUEPLzZlweTeoRk2
	IGQi+GBLMvu15WSRDNxLQgP8BAm12GZsi1xsNXuC0aXRATQavJbxgpiym5OnNV/5R7vL+pCs
X-Google-Smtp-Source: AGHT+IFwvKnjZtLoQ4bY59+1gUvZDTEb4mowMJ0K70YKwsiOKp0lgYtmDTG0AdFCxAuctUKRuXVbug==
X-Received: by 2002:a17:902:db02:b0:21f:631c:7fc9 with SMTP id d9443c01a7336-22e03c81070mr3938175ad.0.1746136004118;
        Thu, 01 May 2025 14:46:44 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fa8611424sm129648a12.73.2025.05.01.14.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 14:46:43 -0700 (PDT)
Date: Thu, 1 May 2025 21:46:32 +0000
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
Subject: Re: [PATCH v2 21/22] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aBPruHaehW4yU-ez@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <b81b2332f793a9ffccc528d821f2ed3ac051f9e0.1745646960.git.nicolinc@nvidia.com>
 <aBKdMaFLPFJYegIS@google.com>
 <aBKmk6PNFreeyfLh@Asurada-Nvidia>
 <aBLGUby2dIiYCe7S@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBLGUby2dIiYCe7S@Asurada-Nvidia>

On Wed, Apr 30, 2025 at 05:54:41PM -0700, Nicolin Chen wrote:
> On Wed, Apr 30, 2025 at 03:39:22PM -0700, Nicolin Chen wrote:
> > On Wed, Apr 30, 2025 at 09:59:13PM +0000, Pranjal Shrivastava wrote:
> > > >  enum iommu_viommu_type {
> > > >  	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
> > > >  	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
> > > > +	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
> > > > +};
> > > 
> > > This is a little confusing.. I understand that we need a new viommu type
> > > to copy the new struct iommu_viommu_tegra241_cmdqv b/w the user & kernel
> > > 
> > > But, in a previous patch (Add vsmmu_alloc impl op), we add a check to
> > > fallback to the standard type SMMUv3, if the impl_ops->vsmmu_alloc 
> > > returns -EOPNOTSUPP:
> > > 
> > > 	if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
> > > 		vsmmu = master->smmu->impl_ops->vsmmu_alloc(
> > > 			master->smmu, s2_parent, ictx, viommu_type, user_data);
> > > 	if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
> > > 		if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> > > 			return ERR_PTR(-EOPNOTSUPP);
> > > 		/* Fallback to standard SMMUv3 type if viommu_type matches */
> > > 		vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
> > > 					     &arm_vsmmu_ops);
> > > 
> > > Now, if we'll ALWAYS try to allocate an impl-specified vsmmu first, even
> > > when the viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3, we are anyways
> > > going to return back from the impl_ops->vsmmu_alloc with -EOPNOTSUPP.
> > 
> > That's not necessarily true. An impl_ops->vsmmu_alloc can support
> > IOMMU_VIOMMU_TYPE_ARM_SMMUV3 potentially, e.g. an impl could just
> > toggle a few special bits in a register and return a valid vsmmu
> > pointer.
> > 
> > It doesn't work like this with VCMDQ as it supports its own type,
> > but for the long run I think we should pass in the standard type
> > to impl_ops->vsmmu_alloc too.
> > 
> > > Then we'll again check if the retval was -EOPNOTSUPP and re-check the
> > > viommu_type requested.. which seems a little counter intuitive.
> > 
> > It's just prioritizing the impl_ops->vsmmu_alloc. Similar to the
> > probe, if VCMDQ is missing or encountering some initialization
> > problem, give it a chance to fallback to the standard SMMU.
> 
> I changed to this and it should be clear now:
> 
> +       /* Prioritize the impl that may support IOMMU_VIOMMU_TYPE_ARM_SMMUV3 */
> +       if (master->smmu->impl_ops && master->smmu->impl_ops->vsmmu_alloc)
> +               vsmmu = master->smmu->impl_ops->vsmmu_alloc(
> +                       master->smmu, s2_parent, ictx, viommu_type, user_data);
> +       if (PTR_ERR(vsmmu) == -EOPNOTSUPP) {
> +               /* Otherwise, allocate an IOMMU_VIOMMU_TYPE_ARM_SMMUV3 here */
> +               if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> +                       vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu,
> +                                                    core, &arm_vsmmu_ops);
> 

This looks good! Thanks!

> Thanks
> Nicolin

Praan

