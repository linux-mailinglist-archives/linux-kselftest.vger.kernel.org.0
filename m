Return-Path: <linux-kselftest+bounces-30360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDA6A80295
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 13:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4811B1883A1F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C751263C6D;
	Tue,  8 Apr 2025 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEDnffPo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA076266EEA
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112692; cv=none; b=ZiHS4sQkcaEl0FTHdJKLox1REduKpmtZL4dLm1dtuczotsT21Dd2HuHsN8aODLrl0KkckcU3VCY/rjs9/YZpLTJ9bxLkeabAsjciQMyKsuBfr35+I3fAmrvGLQJp8GM/tpqJ2fYPHV96H3vA8cR17Ff0W2QrfIEp9XcQ9YnVsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112692; c=relaxed/simple;
	bh=sVnWWYifDzNHWDD5ZdDHNMXXvkM1H7Mr10Ssgl0n+6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSek5QPdZ4RMirrDVAZ89XsbHkRprw/FExwbWL0WcdrGE0Z63xtrnsDDhrN8vXkEGnbB0xuRqawDYsQNwJenLHK/h17XGNqX8H9Oahrul+zecMCRr3nidspbmBu9TWQXAYwtKNt5eMuPRtEG/V+E4Cq9lfEgze3zp6kazYPEcig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEDnffPo; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bf8632052so47395431fa.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Apr 2025 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744112687; x=1744717487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JrYauhzusPrI0iXB3x51m5sg6uFNXWBUmKbASQyHV2k=;
        b=gEDnffPoi/BaYCY/J0wQAXVy/xuJWs0K1YXcXKq+noC3BsdYmtR5bE+9n25XPFai04
         AUK9YLeLUJ0uGcpgf0cn5swmDSIuv6gCUL3B1BlkxQ3zek2kR3j0TWU+rOPnUGxeRL4E
         r70lAnJg2Yqq6aU0jAn5hpTug2In0gbLnP+jfJpNhpb82xmV7BB32Vf1xdKyp0mG4dni
         RJ33XTbj7v8rCotisfpi3K5J8G+hdoC2BHXxONUPQikSsH4YJgASgdBg4Rd69E1HtGX7
         hn6MvEn+bs09blcdaXc9NQrvHWvePjzQxO/Rqx0GVkMbhbzQPuISgDxiZi/k8s/LsWMH
         oJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744112687; x=1744717487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrYauhzusPrI0iXB3x51m5sg6uFNXWBUmKbASQyHV2k=;
        b=MiBCpRX37dk2PzE9Wb0iKxNcfP71BPkgyNZkEuzKrHW1+079y7dEuw4LwHtCvk7Lrg
         R5ypKkoNUSu76eJ/L9bNwYdRbWEa2V0RnQ5vTuIMpYF9M4zTQ59vG5vl3T/bUS18KzZV
         pmjWOq4AkLuNfesIY+SAt/2aUKt2CSdo29dKwgOnf8bBsWjkEcEqYN1AoYLXLbZeWLPi
         oTS9vqHucC7E8LgoDcYvyJsuEFhWvg81q9ryoJM0gHtbe8MKInd0k7H2A7agbq0L2Npi
         p46xVdn60DGiwuDQ9WMjbx1ICcXXJ76aA7SBQtlc+mYQPODVrHYM+/DWTN/wlimhq9iu
         ePgg==
X-Forwarded-Encrypted: i=1; AJvYcCXewuqz/UXVQ0C+ssVgaQwbZtQDnD7mTKI0nFMtYlQ2LJjjHdBFolkaLGBtX8pK4FKwA/UIf0WoEefdAAttets=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXe8ZVjpZrshPCrzML19jLcdRHz7zHOe2Jl+hAnyEcvABn5Z2s
	G3I2/6I7Qq5eomR8cvo2bYvyLzfRmLySKPJQefwBBZw0iKQ1gqOGWh9QSOGtWbTVjiBqMNnpVzJ
	1Eh3BabZ1BYY/NR5dXbxPQQnh2rQ+t4CEh3piow==
X-Gm-Gg: ASbGncsTQBLRLtm413xxho/PGAbfF5WPTo1sJlPPNH8wN81R6RSBro/VqG9QS9Y03cB
	7yLxCKXlPlDdnk1PQxtVtjrWsxdVb1cvtISkmJeZJKh1UTHRW36q65MIpVmDLS6bknVlwtDTkp0
	fczibe4AgE8aZ2XaQks0puHH3CgESnKBw=
X-Google-Smtp-Source: AGHT+IHjL36c4DD0hqrS7NUmvzOjx/3kG/kPwxU+j7cHEhXKV/Zh3wqhtcKt/lEg9h3aP4E8pKAxMXueT2IArw3DOF0=
X-Received: by 2002:a05:651c:882:b0:307:9555:dc5e with SMTP id
 38308e7fff4ca-30f0be04016mr46411251fa.3.1744112686911; Tue, 08 Apr 2025
 04:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740504232.git.nicolinc@nvidia.com> <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
 <CABQgh9Fuh2HdBH7pyAteawZBpa55ZzfR9dv2K4RF=Ps4yhREbw@mail.gmail.com> <Z/QSuMzJVGOcTx60@nvidia.com>
In-Reply-To: <Z/QSuMzJVGOcTx60@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 8 Apr 2025 19:44:34 +0800
X-Gm-Features: ATxdqUE5HzSx71KLyQAI3wDnKvY_BQRF_RJmPVNkaKt2N6Ua3aAx7RZCkWtktDg
Message-ID: <CABQgh9FObG8-Qsp-nqoTP-fC7VkPoi1ooHPQ1=s5uW_2BTL9vw@mail.gmail.com>
Subject: Re: [PATCH v8 12/14] iommu/arm-smmu-v3: Introduce struct arm_smmu_vmaster
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, 
	joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org, 
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com, smostafa@google.com, 
	ddutile@redhat.com, yi.l.liu@intel.com, praan@google.com, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Apr 2025 at 02:00, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> On Mon, Apr 07, 2025 at 08:08:57PM +0800, Zhangfei Gao wrote:
> > Hi, Nico
> >
> > On Wed, 26 Feb 2025 at 01:35, Nicolin Chen <nicolinc@nvidia.com> wrote:
> > >
> > > Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
> > > be the first use case. Since the vsid reader will be the eventq handler
> > > that already holds a streams_mutex, reuse that to fenche the vmaster too.
> > >
> > > Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers to set
> > > or unset the master->vmaster point. Put these helpers inside the existing
> > > arm_smmu_attach_prepare/commit().
> > >
> > > For identity/blocked ops that don't call arm_smmu_attach_prepare/commit(),
> > > add a simpler arm_smmu_master_clear_vmaster helper to unset the vmaster.
> > >
> > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Reviewed-by: Pranjal Shrivastavat <praan@google.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> >
> > >
> > > +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > > +                                   struct arm_smmu_nested_domain *nested_domain)
> > > +{
> > > +       struct arm_smmu_vmaster *vmaster;
> > > +       unsigned long vsid;
> > > +       int ret;
> > > +
> > > +       iommu_group_mutex_assert(state->master->dev);
> > > +
> > > +       /* Skip invalid vSTE */
> > > +       if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > > +               return 0;
> >
> > Why this is removed in v9 and 6.15-rc1?
> >
> > I tested 6.15-rc1 the qemu failed to boot with qemu branch:
> > for_iommufd_veventq-v8
> > "failed to attach the bypass pagetable"
>
> Here is the problem: v9 isn't compatible with v8 :)
>
> Would you please try for-v9 version?
> https://github.com/nicolinc/qemu/commits/wip/for_iommufd_veventq-v9

Thanks Nico

I tried this branch, it works with 6.15-rc1

Thanks

