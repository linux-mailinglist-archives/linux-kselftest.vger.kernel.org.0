Return-Path: <linux-kselftest+bounces-36215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E83AF0446
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 22:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F885175C0D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 20:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F2728312E;
	Tue,  1 Jul 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWxZZ2sm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A995027EFE2
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751400228; cv=none; b=EFmL8qBfFFlSIZO7mLVchcpxmTW764WEVtec61e7fajcwCD1ZDWxoeMgoEF9kjyCudtNGG2cGncu380EgDvqhW8xH7FUUxY9BlP1ZN670c350d21CJOi9bnk2OjF7BSOZAUPbq9OX1Ix/I5K7BPUdFvJPYlMcbjd8i7DizYrmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751400228; c=relaxed/simple;
	bh=58rJfG6CwvkRx2KRC7Bb3Gpy0xeB+CUY4kcxFJRCUYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eND5SzdPT+IHFxO/eIKH+gC4NG2o7buSWH9hyvmH+SgUrbvjNGvMcsqSPVh10aiR0E6rqEZz9F7h4VBdAjJr5KpXBOH16HdQZdznYlIeqkIc8tv1SqqrvyWfCvkKyHMxbd938Akk4ZXI/r8fW+cH8CoRfNqsLmyL9ZzbhAefBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWxZZ2sm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235e389599fso317175ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751400226; x=1752005026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bktMfbMPWDOoqz4tBJCnWTjUNN8jSJQyh7h6qa9T1Cs=;
        b=VWxZZ2smbJup4TKCuT5YnV8iiDV24Ni3CKAxCo87z4Dp2oJy9Vx1NL1MHZs1xgcvrF
         XLoahWiVdlwepNu3eNOcwu0Chia0pPuVqXpLQknqewO/3AIBtFU6lWe7DXDPwBW/GN3j
         W9622Eid9kn9kztEQcX+mS1Ake3GUa06i3gqjeGTGcZnoJsC4Kzpj+SZI0czHSC9BjWa
         g7kafS2tZIKS/4oFNuBmpOsABl8LJxD7snb+1YnrZm1o87qvGMfgfvLPZSxx00DGJfht
         qVCEQ0mdPvMQBZRSRHDxbwOVXaGA4pj3/lC2Bgu4poYKjApXlSjPYK85uZgB3WBq23F/
         m7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751400226; x=1752005026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bktMfbMPWDOoqz4tBJCnWTjUNN8jSJQyh7h6qa9T1Cs=;
        b=kJkPXxGs74fE55gxL/ZEP858jAW6KtWuhpTMri8QmoLaDvw7dZid9Kcoqqe10gVBSU
         YrMaieczNKROPSQN7zQY6fzfk471Wb8mKgLcnC+A+leK0Ls/g9BGjHHPwqx+E87IdptQ
         lMOWL2vQLE0vxCywbib2V7LpW15z2rbongefdIUo5FreoIJdYI+uEHuw7NtoZaai1XIu
         JuD6U+asd7ftV3ZWiQBAaYngBE2j+z19zgeeHiL5UzVfOB/hR3L9HKujDEegM9VIbC+K
         0Ug9TyWu4fmJa63tjqet/Gwr4uJoiRCkF/S0x6w2MoMy/YGCrAbFQntxVslmzQzXHhs3
         1jPw==
X-Forwarded-Encrypted: i=1; AJvYcCXGzWwjSq2Cext2EWrImkVSookOGTTph8GpsC8oetD6PSURWzITQZwXUs6vdNXacBIVMs/Om2ovjOYysaHLJIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNB7Z8+QEtwh3BHSmY1efjbqNlK0nWPhnlGp4KNqFLUwgYrsud
	EUsu8dvmQFbN6/WVCD5TNo8avBNT9/arhy2vnUZ9cbwwwt8bzEeOoMuWGRmBBMnQAQ==
X-Gm-Gg: ASbGncsxOlK3vwz20b02Bo8scwvGyca4FfWvdaqQ85pjd/MmQNAEYGWW63E4nMQPnfw
	vMcFP/IMYTmAswZcIKZ00qMw9im7dJlmwHZ1QCvKzRz72Wxk7yGzQ143Tyl/FN/B3B7wZ5Usmoj
	B/ZnUZTu3mDo96dbLkzncZQ9QSakDY1c32Oz0M1BIqjzzEZVauk/yfc2WmxJWuUoVVt6jiBk3Af
	YnLf24e5cQoOZaLsqRmzsy552bslCwTJPKJhcGBGMB7dFSDaO1KqiplwNR048iWvQh+cGOBkP+S
	pemhZuHRXgLVCo9CTJpzzdMpKzGfpa3/hERuEPr2MN/TOh8yxgONDhukKNnVfGuhUOGm306DAFu
	KI+RvMDyT9l0wS04i0sEq
X-Google-Smtp-Source: AGHT+IH8wLGT2ZcmFXbUpUVEBUVQ8i42Tf/vT9/rYGPbC+3uemlbkYYLsI4PH85g9JH5U3HDbnRtDg==
X-Received: by 2002:a17:903:46cf:b0:234:afcf:d9e2 with SMTP id d9443c01a7336-23c6010bde4mr3665345ad.17.1751400225511;
        Tue, 01 Jul 2025 13:03:45 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bb7dsm112415425ad.90.2025.07.01.13.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 13:03:44 -0700 (PDT)
Date: Tue, 1 Jul 2025 20:03:35 +0000
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
Message-ID: <aGQ_F7Qx3scbbA-J@google.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <539ee2ec112162abdba511574e2205a77b425059.1750966133.git.nicolinc@nvidia.com>
 <aGQGm1-i4M75b9Qp@google.com>
 <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>

On Tue, Jul 01, 2025 at 12:42:32PM -0700, Nicolin Chen wrote:
> On Tue, Jul 01, 2025 at 04:02:35PM +0000, Pranjal Shrivastava wrote:
> > On Thu, Jun 26, 2025 at 12:34:58PM -0700, Nicolin Chen wrote:
> > >  /**
> > >   * enum iommu_hw_info_type - IOMMU Hardware Info Types
> > >   * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
> > > @@ -598,12 +619,15 @@ struct iommu_hw_info_arm_smmuv3 {
> > >   * @IOMMU_HW_INFO_TYPE_DEFAULT: Input to request for a default type
> > >   * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
> > >   * @IOMMU_HW_INFO_TYPE_ARM_SMMUV3: ARM SMMUv3 iommu info type
> > > + * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
> > > + *                                     SMMUv3) info type
> > 
> > I know that the goal here is to mention that Tegra241 CMDQV is an
> > extension for Arm SMMUv3, but this comment could be misunderstood as the
> > "type" being an extension to IOMMU_HW_INFO_TYPE_ARM_SMMUV3. How about we
> 
> IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV only reports CMDQV structure.
> VMM still needs to poll the IOMMU_HW_INFO_TYPE_ARM_SMMUV3. It's
> basically working as "type being an extension".
> 

Ohh okay, I see.. I thought we were describing the HW.

> > Sorry to be nit-picky here, I know that the code is clear, but I've seen
> > people don't care to read more than the uapi descriptions. Maybe we
> > could re-write this comment, here and everywhere else?
> 
> I can change this thought:
> 
> + * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
> + *                                    SMMUv3) enabled ARM SMMUv3 type
> 

Yes, that helps, thanks!

> > > +/**
> > > + * struct tegra241_vintf_sid - Virtual Interface Stream ID Replacement
> > > + * @core: Embedded iommufd_vdevice structure, holding virtual Stream ID
> > > + * @vintf: Parent VINTF pointer
> > > + * @sid: Physical Stream ID
> > > + * @idx: Replacement index in the VINTF
> > > + */
> > > +struct tegra241_vintf_sid {
> > > +	struct iommufd_vdevice core;
> > > +	struct tegra241_vintf *vintf;
> > > +	u32 sid;
> > > +	u8 idx;
> > >  };
> > 
> > AFAIU, This seems to be a handle for sid -> vintf mapping.. it yes, then
> > I'm not sure if "Virtual Interface Stream ID Replacement" clarifies that?
> 
> No. It's for vSID to pSID mappings. I had it explained in commit log:
> 

I get that, it's for vSID -> pSID mapping which also "happens to" point
to the vintf.. all I wanted to say was that the description is unclear..
We could've described it as "Vintf SID map" or something, but I guess
it's fine the way it is too.. your call.

> For ATC invalidation commands that hold an SID, it requires all devices to
> register their virtual SIDs to the SID_MATCH registers and their physical
> SIDs to the pairing SID_REPLACE registers, so that HW can use those as a
> lookup table to replace those virtual SIDs with the correct physical SIDs.
> Thus, implement the driver-allocated vDEVICE op with a tegra241_vintf_sid
> structure to allocate SID_REPLACE and to program the SIDs accordingly.
> 
> > > @@ -351,6 +394,29 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
> > >  
> > >  /* HW Reset Functions */
> > >  
> > > +/*
> > > + * When a guest-owned VCMDQ is disabled, if the guest did not enqueue a CMD_SYNC
> > > + * following an ATC_INV command at the end of the guest queue while this ATC_INV
> > > + * is timed out, the TIMEOUT will not be reported until this VCMDQ gets assigned
> > > + * to the next VM, which will be a false alarm potentially causing some unwanted
> > > + * behavior in the new VM. Thus, a guest-owned VCMDQ must flush the TIMEOUT when
> > > + * it gets disabled. This can be done by just issuing a CMD_SYNC to SMMU CMDQ.
> > > + */
> > > +static void tegra241_vcmdq_hw_flush_timeout(struct tegra241_vcmdq *vcmdq)
> > > +{
> > > +	struct arm_smmu_device *smmu = &vcmdq->cmdqv->smmu;
> > > +	u64 cmd_sync[CMDQ_ENT_DWORDS] = {};
> > > +
> > > +	cmd_sync[0] = FIELD_PREP(CMDQ_0_OP, CMDQ_OP_CMD_SYNC) |
> > > +		      FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
> > > +
> > > +	/*
> > > +	 * It does not hurt to insert another CMD_SYNC, taking advantage of the
> > > +	 * arm_smmu_cmdq_issue_cmdlist() that waits for the CMD_SYNC completion.
> > > +	 */
> > > +	arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, cmd_sync, 1, true);
> > > +}
> > 
> > If I'm getting this right, it issues a CMD_SYNC to the Host's CMDQ i.e.
> > the non-CMDQV CMDQ, the main CMDQ of the SMMUv3? (i.e. the CMDQ present
> > without the Tegra241 CMDQV extension?)
> >
> > so.. basically on every VM switch, there would be an additional CMD_SYNC
> > issued to the non-CMDQV CMDQ to flush the TIMEOUT and we'll poll for
> > it's completion?
> 
> The main CMDQ exists regardless whether CMDQV extension is there or
> not. The CMD_SYNC can be issued to any (v)CMDQ. The smmu->cmdq is
> just the easiest one to use here.
> 

I see. Thanks!

> > > @@ -380,6 +448,12 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
> > >  	dev_dbg(vcmdq->cmdqv->dev, "%sdeinited\n", h);
> > >  }
> > >  
> > > +/* This function is for LVCMDQ, so @vcmdq must be mapped prior */
> > > +static void _tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
> > > +{
> > > +	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
> > > +}
> > > +
> > 
> > Not sure why we broke this off to a function, will there be more stuff
> > here or is this just to use it in tegra241_vcmdq_hw_init_user as well?
> 
> I can take it off.
> 

Nah, that's okay, I was just curious.

> > > @@ -429,6 +504,10 @@ static void tegra241_vintf_hw_deinit(struct tegra241_vintf *vintf)
> > >  		}
> > >  	}
> > >  	vintf_write_config(vintf, 0);
> > > +	for (sidx = 0; sidx < vintf->cmdqv->num_sids_per_vintf; sidx++) {
> > > +		writel(0, REG_VINTF(vintf, SID_MATCH(sidx)));
> > > +		writel(0, REG_VINTF(vintf, SID_REPLACE(sidx)));
> > > +	}
> > >  }
> > 
> > I'm assuming we call the de-init while switching VMs and hence we need
> > to clear these to avoid spurious SID replacements in the new VM? Or do
> > they not reset to 0 when the HW is reset?
> 
> The driver does not reset HW when tearing down a VM, but only sets
> VINTF's enable bit to 0. So, it should just set other configuration
> bits to 0 as well.
> 
> > > +static struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
> > > +	.destroy = tegra241_cmdqv_destroy_vintf_user,
> > > +	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
> > > +	.cache_invalidate = arm_vsmmu_cache_invalidate,
> > 
> > I see that we currently use the main cmdq to issue these cache
> > invalidations (there's a FIXME in arm_vsmmu_cache_invalidate). I was
> > hoping for this series to change that but I'm assuming there's another
> > series coming for that?
> > 
> > Meanwhile, I guess it'd be good to call that out for folks who have
> > Grace and start trying out this feature.. I'm assuming they won't see
> > as much perf improvement with this series alone since we're still using
> > the main CMDQ in the upstream code?
> 
> VCMDQ only accelerates invalidation commands.
> 

I get that.. but I see we're using `arm_vsmmu_cache_invalidate` here
from arm-smmu-v3-iommufd.c which seems to issue all commands to
smmu->cmdq as of now (the code has a FIXME as well), per the code:

	/* FIXME always uses the main cmdq rather than trying to group by type */
        ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, last->cmd,
					  cur - last, true);

I was hoping this FIXME to be addressed in this series..

> That is for non-invalidation commands that VCMDQ doesn't support,
> so they still have to go in the standard nesting pathway.
> 
> Let's add a line:
> 	/* for non-invalidation commands use */

Umm.. I was talking about the cache_invalidate op? I think there's some
misunderstanding here? What am I missing?

> 
> Nicolin

Thanks
Praan

