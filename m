Return-Path: <linux-kselftest+bounces-30244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B82A7DD35
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 14:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20F91890F05
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 12:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137A92459DF;
	Mon,  7 Apr 2025 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1QJa5vY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726A244EAB
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744027754; cv=none; b=BvP9D5ExzU0VWi8BPIvZ+7pInuE6KaaEM8xZQ1Y60x5Ur3UojyWFWWOPxN96kaj1EnEq2uKeiU7DQrZtJHSUs1+ypnUjDuTVDnd63hYfzdwIjI2Jzun6di0HWngMl8mUyo9RYm26plvG1tvnQgLshAxAW/A707qwWGSa+K2cnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744027754; c=relaxed/simple;
	bh=sBCQHBDcAUpG17ddyItmIuUCIWSKR3D3zFJjSYLtoVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbXz6uF3GJMnXoftM6XZ4tbyGkJKqUCSDNx7+KJVOpMfE8e5dYSjYuk+xovtfardRRbBGya4im7s0DYFxIlPcdwKUE144upvS7DWqe5R8dDcRck7F+fcqOS1TywSqxIBDxItesy4OtUVQsSuzAOmbodrFHpwlXl9scsjeundI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O1QJa5vY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so41102371fa.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744027749; x=1744632549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/LHFPsYBw0bwDf6dVcpDSJnHybANIimgmPtryFgNPA=;
        b=O1QJa5vY6mTfmLs4ycXkNd6aOG9TDOigmEPs4fGrs6HMlbtovJIojTYeLGjotYTCEi
         Nu6iahUJ6uSbz3VOCihPxCibWBcX53WqJWABSHx51ja9uZWjhVGK6+c2s0Xf84/jo0TL
         sIeRlZwEVDfcRnGsdTgXbAu5wIYRW02VQofWNVlYgUYF6FGFvJhvX+ny1je2EkvMmMDK
         3k3b7uqj4/3izloAXQNSCGOrJnl5C3ximExbC/8fyjr8Nqn5qhZWy6YgwdiPPH4QXdRB
         NbqhoiRDg1WssFrf8I/vOaF897YXt9zSMnkgOYRqlCGfaF2uukSl0YqXO1xA2WFFmNgR
         v+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744027749; x=1744632549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/LHFPsYBw0bwDf6dVcpDSJnHybANIimgmPtryFgNPA=;
        b=v16Ea4qCInxprEy1dyFAmcDvIpnXpYkxPIdY3tf3ruoT5fS/y2Z9Dg8beh1yYn4UBm
         J6EZ+aEZCuqUnx0Q/5uYjS0V4OvrAmbBvl9aOVm+zbsF04ZC/VFqwDr2WAIrF2SXRCy5
         jJTT5JPBNh3tiruKLqjETERPqWrNnoRXku6Ovv85nFNf/q6l9Q/H3WuVm+ZR01dIojiK
         t+9WjdddxSNBkZZng98G7//aknqjibAkO2U3RpH5pQvKgPXcvfzOyn99TN96RL58xSAm
         xAk63oG2XkS2RUHpYsmcD9PbgGO8WgQtszamaZnxRtGHgLOpPzjaAzCuw3yq63LCoeeF
         rfVA==
X-Forwarded-Encrypted: i=1; AJvYcCVccDWAf+JlgHqYmGE1QFHtRKiWMrviyTfRws11jAk+O6uIrD2JvOWmxoVvYpXa1yLXXCptwolLohXVTq9nx44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn1IfGQhx4dYPBYg0ZtP1AaN6EP5gPdwShOsjeY6XVn6ytqPmZ
	l2sGIp75v+/KSRorb06hoo//gu9ZT2zDLi5omYsmpRd6L8t6/FsWMjH3dhWzG1fL9YSh+tZU78R
	bj6Qd0W5Z27nkVYAOQ8R93RvVBv8Z1u3iJ9j+WQ==
X-Gm-Gg: ASbGnct+TXLHKFXMyCpzYdW7j4UYm0Oar7j+Ogt5xj3uLwIkmH+DSRF2nB2FZSCN8R3
	0C7lb5A4c6bFF8WdWzsThUdtehUDN24G3S7aUqnf0sdvWaeqLZWV/JoxMRs9xvtTk9dmnH8xxpc
	XHV/rtzcGlZeuNT3Fd8ddPYtvJxmajI8zAgDInupgG7g==
X-Google-Smtp-Source: AGHT+IE7avfocEmD5lqNIyS63JcSTkkwf3BvTJpAGhR9l+oQoFSuLjrFiN2oMnoA2mOmJOAmlfiARgKB+FZMo6LuuCU=
X-Received: by 2002:a2e:bc1b:0:b0:308:f580:729e with SMTP id
 38308e7fff4ca-30f0a180dd0mr35506541fa.27.1744027749231; Mon, 07 Apr 2025
 05:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740504232.git.nicolinc@nvidia.com> <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
In-Reply-To: <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 7 Apr 2025 20:08:57 +0800
X-Gm-Features: ATxdqUE-WE2mGG2qPqESoLiVUp7LnTlD7II4G1YhfYdYp1Eq06d5HdYvjf8h2-k
Message-ID: <CABQgh9Fuh2HdBH7pyAteawZBpa55ZzfR9dv2K4RF=Ps4yhREbw@mail.gmail.com>
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

Hi, Nico

On Wed, 26 Feb 2025 at 01:35, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
> be the first use case. Since the vsid reader will be the eventq handler
> that already holds a streams_mutex, reuse that to fenche the vmaster too.
>
> Also add a pair of arm_smmu_attach_prepare/commit_vmaster helpers to set
> or unset the master->vmaster point. Put these helpers inside the existing
> arm_smmu_attach_prepare/commit().
>
> For identity/blocked ops that don't call arm_smmu_attach_prepare/commit(),
> add a simpler arm_smmu_master_clear_vmaster helper to unset the vmaster.
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Pranjal Shrivastavat <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---

>
> +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> +                                   struct arm_smmu_nested_domain *nested_domain)
> +{
> +       struct arm_smmu_vmaster *vmaster;
> +       unsigned long vsid;
> +       int ret;
> +
> +       iommu_group_mutex_assert(state->master->dev);
> +
> +       /* Skip invalid vSTE */
> +       if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> +               return 0;

Why this is removed in v9 and 6.15-rc1?

I tested 6.15-rc1 the qemu failed to boot with qemu branch:
for_iommufd_veventq-v8
"failed to attach the bypass pagetable"

After adding this "skip check" back, the qemu works again.

Do we need to add this back?

Thanks

