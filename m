Return-Path: <linux-kselftest+bounces-27488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A79A44773
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7A11882887
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEC4194147;
	Tue, 25 Feb 2025 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1+90Mwc2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A86192D9A
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503312; cv=none; b=oRgMuAG/G34DveSLx4yv+hbhZdYqE2I558lI3L/FC2ezD/UDOtghP7jztReQPxteS4U1cXMg0w8BhMoE1GBiJtdI7a3qWUVhpbjQaMai9bvED8Aj3yusNbBEmUB4zpCF1N/GIKQdYTtb1+RrDxhvDaC9SYaLznxGLz7TpU0OGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503312; c=relaxed/simple;
	bh=SS9kgyaImj6RHK5LJn7d2R6kJ3V1FoRJ0mFcyFKs1aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhvmZitxB+QFVdyo8BNlG811EkGctHUzfEe1NvjybagD55BcdeM6CjijyxZlY+7NtBSmENYvShUiaDFKE7cMDjq2T7WSTpfFNCAIiiXWkM5G2W6/QAAxj/L7oFEaO97zFR12CLksWWk3TVxC5DzIcRAs1ZRDp2AqKG/q06+5Yow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1+90Mwc2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2212222d4cdso177745ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 09:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740503309; x=1741108109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1QM6kau2iQ4j6ZEaDdmG4fMZZFTf4UoSv3ypQuKbFJw=;
        b=1+90Mwc2tBTehc48eAdUaVeASRqHpq6148FESDI3wonZcgPuiM8ddmoGqsMMpOOGWF
         RwHdsMJL/7i0ZPXQzGm1EnbMF/WPCBqHcKcSHykx7E6VhAgejGNnmm8aD76BADryfK52
         rDwA/mLwrT/Xv6W7jwP3T0qYWMf6NY3BEdyQRVKYinPBktKurSCW+RYXr4K0g//SjNT2
         V/6qieZycgjxgyBjkYvto6mxcEM5kRgn+QG2LSluWa9LuJcuejeOlWlAQMnP4oB+dx19
         6uklvoKdzZp3m4PV/YTtO9fJ9Kn2ziOW4/OPm36Qil/8SSnyQkFFWeuN7++7MVESIf+9
         KoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503309; x=1741108109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QM6kau2iQ4j6ZEaDdmG4fMZZFTf4UoSv3ypQuKbFJw=;
        b=qWyTpFxWpLKLsnCI7nboo0yRhHb7gwviWCVnzAo3myNC71XXTyNYL83vRgyGyvpL8s
         synWt9XqdY2xAYhKs66j+Vi+cFgeU3C+yfba4DgD9/u+WgwTojlGVKzKGGOLp0Kfst71
         KWJeVHKkmp9TJkvWLqy80wgDT3VLLRPkjpKuSU0YxsfpyYOhuqMETaLhrHL4uGZNfi5M
         vWcwrtGEEAcxZjDGLLbMDPA4T2aamwsjSZM+teUmHMBpsP1M5Q+GH3RF45tpVDdtcb7C
         T6t3PR4zT50Esfc4XG6vWs+Oey453bglJBPlTZZpHObLhNBeX1KVYIiaydwhOWO1jAxl
         EaVw==
X-Forwarded-Encrypted: i=1; AJvYcCV05uR6UB5d93dzCm5wV56ABjGicqnFPQjMM4/sk7dVnm6O7w8PWYp9h4bnJ3tkzTT2hLZGKJqW1qfbB3KYZYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmozfVLZ1RcwcQi70V+BEOnoxtiDCPWblkzZV+Brc6steseYK
	eHJ8FoxcbRk3l78b2gutmIGaO0wT9EKBSTN2MVFOfTlL5HW+vFgg/8m2dMCztQ==
X-Gm-Gg: ASbGnctbTdCb5BfduvW2klvLIEmDZgGnboUQxGqmIJQg3gbpPy8bWz4tOLTjBP1ofWC
	tkg+gWJ7HIYFKg6bVlSPwVvTQTX+E4tgzToAJXTGKjs1LXp00DZ/vhIkWu9WpWzfAk8xp1buaPb
	InDpMYOx1wXaXBHQzQqyegc96FHRCZAu19f4zk598ahpiykxVpXGnm0AOecuZA+YVkij8uZ/kMr
	zYlXI3xAv0zy1lg59QWDwxS4jnQbNAHBYeBPz9Z88/+Mo+f1kw1XLPYLfMyXB8fp0rpWIf3BhVe
	0rmfB04QT093uJ6dV4IYt3FftuTXD0NQ/Q2YD5pkwUkPuDUSZ+N2sMWl6Y5KCSA=
X-Google-Smtp-Source: AGHT+IHxrabWDtym7s/ddOkqBHoBfq1ZqP6yAIbeWpN90fX7xeP+90KuPUzmekpH3adGkKddVDiEdg==
X-Received: by 2002:a17:902:ec90:b0:216:607d:c867 with SMTP id d9443c01a7336-22307aabb1cmr3599065ad.29.1740503308535;
        Tue, 25 Feb 2025 09:08:28 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9ae8sm1757069b3a.120.2025.02.25.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:08:27 -0800 (PST)
Date: Tue, 25 Feb 2025 17:08:16 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com, corbet@lwn.net,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z735AMlhP29YEndU@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
 <Z7zYLBLZGKim-5UL@google.com>
 <Z7zlH74/orq9HF7Q@Asurada-Nvidia>
 <Z7zqdrQn7Q8yXfcn@google.com>
 <Z7zxsbJsOFp41Dzd@Asurada-Nvidia>
 <Z70EnQ5CXacc4ysT@Asurada-Nvidia>
 <20250225160225.GA593877@nvidia.com>
 <Z73yt4r0iDFwbty2@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73yt4r0iDFwbty2@Asurada-Nvidia>

On Tue, Feb 25, 2025 at 08:41:27AM -0800, Nicolin Chen wrote:
> On Tue, Feb 25, 2025 at 12:02:25PM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 24, 2025 at 03:45:33PM -0800, Nicolin Chen wrote:
> > 
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > @@ -95,8 +95,6 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > >  
> > >  	iommu_group_mutex_assert(state->master->dev);
> > >  
> > > -	if (domain->type != IOMMU_DOMAIN_NESTED)
> > > -		return 0;
> > >  	nested_domain = to_smmu_nested_domain(domain);
> > >  
> > >  	/* Skip invalid vSTE */
> > > @@ -122,19 +120,9 @@ void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
> > >  {
> > >  	struct arm_smmu_master *master = state->master;
> > >  
> > > -	mutex_lock(&master->smmu->streams_mutex);
> > > -	if (state->vmaster != master->vmaster) {
> > > -		kfree(master->vmaster);
> > > -		master->vmaster = state->vmaster;
> > > -	}
> > > -	mutex_unlock(&master->smmu->streams_mutex);
> > > -}
> > > -
> > > -void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> > > -{
> > >  	mutex_lock(&master->smmu->streams_mutex);
> > >  	kfree(master->vmaster);
> > > -	master->vmaster = NULL;
> > > +	master->vmaster = state->vmaster;
> > >  	mutex_unlock(&master->smmu->streams_mutex);
> > >  }
> > 
> > I'd leave the clear_vmaster just for clarity. Commit should not be
> > unpaired with prepare in the other functions.
> > 
> > It looks fine with this on top too
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Ack. I added it back and a #ifdef to the vmaster: 
> 
> +void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> +{
> +       struct arm_smmu_attach_state state = { .master = master };
> +
> +       arm_smmu_attach_commit_vmaster(&state);
> +}
> [...]
> @@ -824,6 +829,9 @@ struct arm_smmu_master {
>         struct arm_smmu_device          *smmu;
>         struct device                   *dev;
>         struct arm_smmu_stream          *streams;
> +#ifdef CONFIG_ARM_SMMU_V3_IOMMUFD
> +       struct arm_smmu_vmaster         *vmaster; /* use smmu->streams_mutex */
> +#endif
>         /* Locked by the iommu core using the group mutex */
>         struct arm_smmu_ctx_desc_cfg    cd_table;
>         unsigned int                    num_streams;
> @@ -972,6 +980,9 @@ struct arm_smmu_attach_state {
>         bool disable_ats;
>         ioasid_t ssid;
>         /* Resulting state */
> +#ifdef CONFIG_ARM_SMMU_V3_IOMMUFD
> +       struct arm_smmu_vmaster *vmaster;
> +#endif
>         bool ats_enabled;
>  };
> 

Umm.. I'm not too sure how I feel about these #ifdefs _between_ a struct
definition. Given that currently, the arm_smmu_v3.h file doesn't have
such `#ifdef CONFIG`s between structs. I'd say, in case
CONFIG_ARM_SMMU_V3_IOMMUFD is turned off, we can simply leave the
vmaster ptr NULL?


-Praan




