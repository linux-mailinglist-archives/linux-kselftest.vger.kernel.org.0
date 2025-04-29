Return-Path: <linux-kselftest+bounces-31923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508FCAA19F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4849A1D51
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 18:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBB6254870;
	Tue, 29 Apr 2025 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGyu/E3f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978C25485E
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950246; cv=none; b=CYyuEEeBN0HxSE1xiqhjM6fhgPX4962CYBFXG5wNGqRQqBSaSxYfytBi9O5g9axMszAuMVJGiMybqnQHvL1n9AE2+DWBO1hIgm1MyI4BWNXofAe+s2vDHOCAchn3jCFRQ1y1hfhaHu7ROLrHiI4O6whBY6WpPWiFuhW2s23Pzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950246; c=relaxed/simple;
	bh=Ziulb9mMltIWQNEALJDPRlCWsnKPBKb9mm4o9Za3zo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N72clZUhQn7HJR9QBYLE4wXFEYIg2O+6aGNgBHlPEBHt6hWzdkAS0avJyBGw6sOvnsUv9I0jow8F06beEY8cMEKX+iVGZOJZacyHVkkIEN9GYu6HBQV7+yfNheynBCYc+IatenVEQvm1pfhzW+/aNKat4ajKVDY0vUrvvsbJvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qGyu/E3f; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240aad70f2so202915ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745950243; x=1746555043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ftw/IjMpgU7GPfLzcouQoWIfms9GOb854vnlNb5+taU=;
        b=qGyu/E3fthiFZeH93oRX/PX4jUwxbwTNQFN9rDwqn4UUhnO6idkhVsVvOq54Uqe/X5
         JqqeThXu0muKP/BvVDBSuAJw1O+L5ZXhVvcmzSfGa9ARMMQ9WDq1ok0nNNwqaOqK5Qe8
         0wQKbVLZa/WNb2LPjb1UAO2sELZt44MdlhDP+sFTQhkB8qnxbXamoo0rh7HhCOrEHFf+
         PAfpztp3a+GvKt4rRVipQPLagMsc43PP0tqYxafXsWbGZuMKcc/vYq4hejMRpy7gTpMB
         nGpsTTigmEli8jWVDyQE+qy3JfAs/cnipM8BCzvJG9cYO3K7Nky3ByqO8v6u0OQT6p6m
         JdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745950243; x=1746555043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ftw/IjMpgU7GPfLzcouQoWIfms9GOb854vnlNb5+taU=;
        b=Hw/XRUj2dxb5UAUcnOSzhejOARVTLxjQIek02J3PhRd26x0a9DfNF3nft8KWRHcXjU
         zgmRRkTGKhVrX4Qs/etLZ1mHdMlfufq2zw7BWuGtiztkiwgovcQODUijzbo1Zh/zTISR
         VxVj0eb04zjqz9QxwnXUiBRLGQBVuAFXLr5yOBKrmnk0JxpkJgNiCRr3KoV8RU2gBadi
         pM5BTObtIcO17Li7g06upRCZY9JC35vWAwTVNthkUruT2LXR5ImsqlCc750MJkTJr4L0
         ovzLegE9LCHR7sLQS6rNZ3fge/TGTN6v0kutzD4beYlx5Qjm6egouPD0zWeEFEqYqq2v
         BHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0wI67LAt8xpnuzML+s6RcuJ7MHUyDiUDKaUOcxfPIB76NxlKvtoTMSpAYhIqyAras6H+gI7p4FUAKz8/adBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZHx738CfkiMyw2zih08Lmya5GeMfj32GBbvfePeEzU4ofyyzr
	2NrUUoTe7o1rEaqErqB/JjVNYJX07opBUcQ+Rea6lh8r/FN4xiRZFCIk2esm4g==
X-Gm-Gg: ASbGnctYJrckKeQSY8C8ZAtZwWDVHeLqvjq5syhR4vDBvd3DHJ18EYW3Bnpw+nN6ebD
	OF3+a4BdHVijvPfevXXpR/JDNt+DmlSUw0rSCuamG7uf/diiacO/9JYz0rpeGcUZcebR+pNwjSc
	bTIncn2Axx3quwdby4nhl2xEMOF9rn6r/APZQRoW1uNE0WsOy4w/qGpSPrZGXDd9A+Dc1o7cZs7
	+4H+2kv02N7OWcLZgFo8K5OxiZ/Ryn3QRmPH4/xBEk5iUO/zyk7nCm6At/mDem3oumLUPd/FcJg
	q+0PeK8SCarBsTU7dd0OIuzkacOQGWZpMV46R4mgML8C1CEJAGlgTO3Htw2JCokhxYRhD21y
X-Google-Smtp-Source: AGHT+IEGtuGPnrFdA7EnAS7AeHO3rAMJ1bXf2n0ATFrXiwa1CPLZUhde5Z8nusKLhSnrBiMW3CwVgA==
X-Received: by 2002:a17:902:d486:b0:224:38a:bd39 with SMTP id d9443c01a7336-22df406ab2dmr130415ad.20.1745950242565;
        Tue, 29 Apr 2025 11:10:42 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25912efbsm10222670b3a.23.2025.04.29.11.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 11:10:42 -0700 (PDT)
Date: Tue, 29 Apr 2025 18:10:31 +0000
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
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Message-ID: <aBEWFw2wq40SHjTn@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <aA_0TV0RkVOHk7Qj@google.com>
 <aBAEuP9962XweHPc@Asurada-Nvidia>
 <aBCNkcLp6XZpjYYT@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBCNkcLp6XZpjYYT@google.com>

On Tue, Apr 29, 2025 at 08:28:01AM +0000, Pranjal Shrivastava wrote:
> On Mon, Apr 28, 2025 at 03:44:08PM -0700, Nicolin Chen wrote:
> > On Mon, Apr 28, 2025 at 09:34:05PM +0000, Pranjal Shrivastava wrote:
> > > On Fri, Apr 25, 2025 at 10:58:05PM -0700, Nicolin Chen wrote:
> [...] 
> > > IIUC, one vintf can have multiple lvcmdqs and looking at the series
> > > it looks like the vcmdq_alloc allocates a single lvcmdq. Is the plan to
> > > dedicate one lvcmdq to per VM? Which means VMs can share a vintf?
> > 
> > VINTF is a vSMMU instance per SMMU. Each VINTF can have multiple
> > LVCMDQs. Each vCMDQ is allocated per IOMMUFD_CMD_VCMDQ_ALLOC. In
> > other word, VM can issue multiple IOMMUFD_CMD_VCMDQ_ALLOC calls
> > for each VTINF/vSMMU.
> > 
> 
> Ack. I'm just wondering why would a single VM want more than one vCMDQ
> per vSMMU?
> [...]

I guess the only thing on this patch from me was to understand why
would a single VM want more than one vCMDQ per vSMMU? (Just curious to
know :) )

Apart from that,
Reviewed-by: Pranjal Shrivastava <praan@google.com>

> 
> > Thanks
> > Nicolin
> 

Thanks,
Praan

