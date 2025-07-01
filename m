Return-Path: <linux-kselftest+bounces-36219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35588AF0511
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 22:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1271C485098
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 20:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27CD302044;
	Tue,  1 Jul 2025 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDpRt3cO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC22F236D
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402621; cv=none; b=AB21Gr+/X59L4VaAFt7qHm7tNt69L9+DL7Pp8XzLccNu05Q9MPTZBpQA5HZF4Pj09KtmdNDpA64NDGENElR8nhWt/6CAYHQ86gc8kBOntRUq0CLJ0ynn7InGMENGJ4/t/Q9/9kprzsxwhSAPYCwfMaDpAtKnJzcQB7vii0GUaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402621; c=relaxed/simple;
	bh=t6w6HZ3d39NHLiwdzdaqKTFFJH+mBfnQBGoBzloEzXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9x9TGNEKh0P9PujAUIIjIcX0M7aEGZ4zMC8GWSnoqh7UAW+cDn4GmKmPMcW06hbcrNQC3UT/OfNWL7QGEAGt4qFi2yWSB+Y8KHYBgXMKF6riP0yQfjJamutt1IKagS9kDofhAG2e/iYklNF0tq1zWJ0w31gjqKvEENDBYj8zJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDpRt3cO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e389599fso326015ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751402619; x=1752007419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp4ARI8yx8eK5+ZYKJ4V0qAwq8T5VmfMZEWG24JsVtU=;
        b=tDpRt3cOlJV+0eYx3cpvFlgyFkuAy70sDvbRT8UUSM/hdogqjjLUMhCc4DGgn8F/ly
         g4XyQLBApGchqcqnUuyzf4YCQlXhYFIiM1zatFRfpc3rPYOVU1xoPEZcfilf/bvhUCYH
         uTGT+CbAnxpwSRZvfUGXbb5TUFtu3+Vz7e1zhFf9jCE7cZVQte/+iI5czrdcS1mRrjQE
         8JAM5RTOZDtWCzwYl6smx0oPKN48GhcM/jIcj0aq0MOH8/+QeWw7VL2j1uP9TSY6O03D
         eiIrlm5hUd2mqDeRDrfsu1q9EMftSDckGVd5n1RPbXi3lGUAY1wY15z+mT1GeUuy+xos
         MBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751402619; x=1752007419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp4ARI8yx8eK5+ZYKJ4V0qAwq8T5VmfMZEWG24JsVtU=;
        b=T9e8LZSYCu0qx5MqgGO0in2KRnkBIvJkL2lAnz46IzYtpHOsgk5Ltra6EAPlSkDWR2
         8wNbyxfIQrBwTHeksQHaRnoRYXGjz4Z9KrH3DgBSVUZOMPJGDmJyMaeI3jhuqB5vxWmr
         8heNd9L5ePOGi5fkXLGYkRtR986lOtMEOvF4YGK/JK/DcSeCje1zG2otU9mv157jL7zf
         KNtvC+6emHoeN81O7mP/ROkZjEfze9cFHwiDEaEz0lzzzPfsSisEd8BF/JuzS0AtTo+L
         a7n1LJ0CnIpMRCr3XyfSuWkzNzWmGi5wTu3g2wsZv100HtQj6jdcmlZ9/TZghfe7gKoO
         EptQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCjBRqGg6//zjYwsaUTIRtoeMM3jTYj5HlxG0/HgKUIMPmXkXS55xohXY1AUMffd28WnXyGbqD7G7BgKdfuZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6xvqED5+x38wA++qzy9nBjyAliK4npPcMFbFJNQUPW3DIKCEk
	ID7S4B9tSrjk4bLBTzcMEgQscHWXCFkNdX6u8Sz7YVo4MgIJy3TwynV79CnZaU3wZA==
X-Gm-Gg: ASbGncvYC631Q1QyjRCVAxLxtr7Mxj0eQjQP+Yna3aaW+ZVkwjQYB+cVp2OXO18msXM
	y1+5Bz0hxwMquPkKhO1XFeR4xaz4e+nR2jya9YC/B28QiTlGTbG8eCnrUVQczzd82f2+IAp+Tjj
	EEz/x54SdFrB+MesNS4EpGMVkyGMzGbYVO5Anb0f7I0tIHcwH5c4EOFhCgu4ek7lGEDVCIj5cO3
	yztICGHM6S8VjhR1UivoadlUcnqofqI4mnrvdmmAzE6X9z27V8LPZ3OT3hi9nXVgj32b7tZ2gcw
	5OD71TARIjvG8qql1mAk2kIGTSZzUEuRMUjEGUME3h5imKYZU3FsDMiya7WwLp4ozONMgrUampa
	WVvY11U16rkNdDufSXD1V
X-Google-Smtp-Source: AGHT+IEgQNF03gTMPFMuZ5i4oqeFgT9l/mftJxCXd5iV8tzIDEl3pR9lFMVTJeBzdy2r/6gfVZ+O7w==
X-Received: by 2002:a17:902:e54e:b0:231:d0ef:e8ff with SMTP id d9443c01a7336-23c5ff29f9dmr4133295ad.8.1751402619181;
        Tue, 01 Jul 2025 13:43:39 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541bdeasm12778586b3a.53.2025.07.01.13.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 13:43:38 -0700 (PDT)
Date: Tue, 1 Jul 2025 20:43:30 +0000
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
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aGRIctg4T6cQECx4@google.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <539ee2ec112162abdba511574e2205a77b425059.1750966133.git.nicolinc@nvidia.com>
 <aGQGm1-i4M75b9Qp@google.com>
 <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
 <aGQ_F7Qx3scbbA-J@google.com>
 <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGRDtYRXFLoT+PrI@Asurada-Nvidia>

On Tue, Jul 01, 2025 at 01:23:17PM -0700, Nicolin Chen wrote:
> On Tue, Jul 01, 2025 at 08:03:35PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Jul 01, 2025 at 12:42:32PM -0700, Nicolin Chen wrote:
> > > On Tue, Jul 01, 2025 at 04:02:35PM +0000, Pranjal Shrivastava wrote:
> > > > On Thu, Jun 26, 2025 at 12:34:58PM -0700, Nicolin Chen wrote:
> > > > > +/**
> > > > > + * struct tegra241_vintf_sid - Virtual Interface Stream ID Replacement
> > > > > + * @core: Embedded iommufd_vdevice structure, holding virtual Stream ID
> > > > > + * @vintf: Parent VINTF pointer
> > > > > + * @sid: Physical Stream ID
> > > > > + * @idx: Replacement index in the VINTF
> > > > > + */
> > > > > +struct tegra241_vintf_sid {
> > > > > +	struct iommufd_vdevice core;
> > > > > +	struct tegra241_vintf *vintf;
> > > > > +	u32 sid;
> > > > > +	u8 idx;
> > > > >  };
> > > > 
> > > > AFAIU, This seems to be a handle for sid -> vintf mapping.. it yes, then
> > > > I'm not sure if "Virtual Interface Stream ID Replacement" clarifies that?
> > > 
> > > No. It's for vSID to pSID mappings. I had it explained in commit log:
> > > 
> > 
> > I get that, it's for vSID -> pSID mapping which also "happens to" point
> > to the vintf.. all I wanted to say was that the description is unclear..
> > We could've described it as "Vintf SID map" or something, but I guess
> > it's fine the way it is too.. your call.
> 
> The "replace" word is borrowed from the "SID_REPLACE" HW register.
> 
> But I think it's okay to call it just "mapping", if that makes it
> clearer.
> 

Anything works. Maybe let it be as is.

> > > > > +static struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
> > > > > +	.destroy = tegra241_cmdqv_destroy_vintf_user,
> > > > > +	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
> > > > > +	.cache_invalidate = arm_vsmmu_cache_invalidate,
> > > > 
> > > > I see that we currently use the main cmdq to issue these cache
> > > > invalidations (there's a FIXME in arm_vsmmu_cache_invalidate). I was
> > > > hoping for this series to change that but I'm assuming there's another
> > > > series coming for that?
> > > > 
> > > > Meanwhile, I guess it'd be good to call that out for folks who have
> > > > Grace and start trying out this feature.. I'm assuming they won't see
> > > > as much perf improvement with this series alone since we're still using
> > > > the main CMDQ in the upstream code?
> > > 
> > > VCMDQ only accelerates invalidation commands.
> > > 
> > 
> > I get that.. but I see we're using `arm_vsmmu_cache_invalidate` here
> > from arm-smmu-v3-iommufd.c which seems to issue all commands to
> > smmu->cmdq as of now (the code has a FIXME as well), per the code:
> > 
> > 	/* FIXME always uses the main cmdq rather than trying to group by type */
> >         ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, last->cmd,
> > 					  cur - last, true);
> > 
> > I was hoping this FIXME to be addressed in this series..
> 
> Oh, that's not related.
> 
> The main goal of this series is to route all invalidation commands
> to the VCMDQ HW. And this is where Grace users can see perf gains
> mentioned in the cover letter or commit log, from eliminating the
> VM Exits at those most frequently used commands.
> 
> Any non-invalidation commands will just reuse what we have with the
> standard SMMU nesting. And even if we did something to that FIXME,
> there is no significant perf gain as it's going down the trapping
> pathway, i.e. the VM Exits are always there.
> 
> > > That is for non-invalidation commands that VCMDQ doesn't support,
> > > so they still have to go in the standard nesting pathway.
> > > 
> > > Let's add a line:
> > > 	/* for non-invalidation commands use */
> > 
> > Umm.. I was talking about the cache_invalidate op? I think there's some
> > misunderstanding here? What am I missing?
> 
> That line is exactly for cache_invalidate. All the non-invalidation
> commands will be sent to he arm_vsmmu_cache_invalidate() by VMM, as
> it means.
> 
> Or perhaps calling them "non-accelerated commands" would be nicer.

Uhh okay, so there'll be a separate driver in the VM issuing invalidation
commands directly to the CMDQV thus we don't see any of it's part here?

AND for non-invalidation commands, we trap out and the VMM ends up
calling the `cache_invalidate` op of the viommu?

Is that understanding correct?

> 
> Thanks
> Nicolin

Thanks
Praan

