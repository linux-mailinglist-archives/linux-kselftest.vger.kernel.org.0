Return-Path: <linux-kselftest+bounces-18484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452B79886FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 16:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7F5281130
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7538175B;
	Fri, 27 Sep 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POAMUXUe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D52191
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446948; cv=none; b=Z2vk8rH5k8EDkkVtVfbLO+FodGuqfdIbXeGP/17qTAr1LD4vAvgA1W2YzeDFb53oJwojjxCMB+EzN7JPv9ie10w4PUDrXa9FnhynP7qrRJbRE7TbXCb1INt9hxy5a68Vo+lJPF9+b5QrYA3nvMhU5qfpT9XjT9iyXCo1T2AOZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446948; c=relaxed/simple;
	bh=Ch2iEEf7t3BPPxauvPjzbm5y3oiW6BijuAn8NuC5kGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jigovjvu9n5O7buH9pDSUxP4Lpks9EprBL5cUj1fldVb7vRombA7EWcsgY+gs3UwWarO8HEDV/zBI0Hx1mHam8B5eNolqoMCIv0ru9fCFO+lb7cDmvL0B/8RvSfWWu49NTmVqtyQDCE08NM/VkAa6PXrmM2A8bLIfyOlow/ph+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POAMUXUe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb1dd2886so259845e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727446945; x=1728051745; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hhj4ZQ6Xld1eIudfd0RTNxx6Jiz8E1lbDuETxH/nQZM=;
        b=POAMUXUexwL5zKcfaGjIhvnSS7zMkNTK8/JrXwfXmO4bUar3dty6PHMQ7X2YQ/SPrN
         viuqv7Ar7ifW5BmAX2BLE95ZHixMPPXDyFtDBv62hfVcziOXDrqrT5Iyqlaz2ERYjBuk
         PFnIrgoLbchz7YqO3UIyZJUtNYcDIQm5SatZYLLTUo6WRIV8xFSZNxUv+aR8CiOXvRiV
         uLutSYNZAV9d10nUZ4f5nCAt1U2u/etLXqm9/j5tiRboyg+Z3Z+JGAxLZZrbIx9BihYm
         cZnov3h9SJbkXJfdMNQhQxEXeJfE2IADV1WfaCdN1KE68GssfW2RobyiAtJHSKWaTWuE
         7WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727446945; x=1728051745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhj4ZQ6Xld1eIudfd0RTNxx6Jiz8E1lbDuETxH/nQZM=;
        b=DHz09NXKoBgv5ptcd23FpO8mlDiaIweWhPkwdmkbchP26VKka/EVaufIl/j1jtNi/0
         VcMskguDfqZmaubUfvpYt3pPUe30osOazV0vXZTR16iWgSRZNWvwNVfM9oHm9sgSrxOd
         46H3S4ZIGCw2/ni3TtmCCwhyFEtUdeuLI4gQ4mK7qU7KDsEXtxfL20O/8wEDDjF3Cr/b
         3c4McqSXnryZZhev/Pasumv2/vP8lVARQNpIHrtcIf1LtTseHFp5qi2iTccJDKEORVIJ
         pxM1YGVskmeQ90/PXvhpT+aojOef91iv4LBKTxdVd+ID3oZw7i73aCnPTcUyFTh59lDx
         bPOw==
X-Forwarded-Encrypted: i=1; AJvYcCWjl/AJevsbfMFlC7yno1M1HlWZgiL9nnYWLU/brIbSxIA0u9WpIiBfpTKL23SeTZPrBaiP/fsJTMQrZQJESG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylU8dJcUbU/Bi+01+WrJHJHCZo1UWu1riNns68JNfWb0GbYU3N
	2xA32RbQrTQLXP3oiwSRreKOv1rNVF2KZBgmGXxouWECVzDoIFFVeF3GHQwoMg==
X-Google-Smtp-Source: AGHT+IEyha9B5v1BC8Ql2C8y6hVRirTJDh8x//Y8F1dggxgjTZk/aBm90T880breDpO4GrzY3E7fHQ==
X-Received: by 2002:a05:600c:3d9b:b0:426:7018:2e2f with SMTP id 5b1f17b1804b1-42f59b52c0amr3701145e9.5.1727446944666;
        Fri, 27 Sep 2024 07:22:24 -0700 (PDT)
Received: from google.com (105.93.155.104.bc.googleusercontent.com. [104.155.93.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e13944sm28884195e9.30.2024.09.27.07.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 07:22:24 -0700 (PDT)
Date: Fri, 27 Sep 2024 14:22:20 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <Zva_nFXZgT4MEfDg@google.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <Zva4PJ3FhpMlWxhF@google.com>
 <20240927140141.GA4568@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240927140141.GA4568@nvidia.com>

On Fri, Sep 27, 2024 at 11:01:41AM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 27, 2024 at 01:50:52PM +0000, Mostafa Saleh wrote:
> 
> > My understanding of IOMMUFD is very little, but AFAICT, that means that
> > it’s assumed that each device can only have one stream ID(RID)?
> > 
> > As I can see in patch 17 in arm_smmu_convert_viommu_vdev_id(), it
> > converts the virtual ID to a physical one using master->streams[0].id.
> > 
> > Is that correct or am I missing something?
> > 
> > As I am looking at similar problem for paravirtual IOMMU with pKVM, where
> > the UAPI would be something similar to:
> > 
> > 	GET_NUM_END_POINTS(dev) => nr_sids
> > 
> > 	SET_END_POINT_VSID(dev, sid_index, vsid)
> > 
> > Similar to what VFIO does with IRQs.
> > 
> > As a device can have many SIDs.
> 
> We don't support multi SID through this interface, at least in this
> version.
> 
> To do multi-sid you have to inform the VM of all the different pSIDs
> the device has and then setup the vSID/pSID translation to map them
> all to the HW invalidation logic.

Why would the VM need to know the pSID? The way I view this is quite close to
how irq works, the VM only views the GSI which is the virtualized number.
The VMM then would need to configure vSID->pSID translation, also without
knowing the actual pSID, just how many SIDs are there per-device; very similar to
how it configures IRQs through
VFIO_DEVICE_GET_INFO/VFIO_DEVICE_SET_IRQS.

And as long as we only allow 1:1 vSID to pSID mapping, I guess it would be
easy to implement.

> 
> Which is alot more steps, and we have no use case right now. Multi-sid
> is also not something I expect to see in any modern PCI device, and
> this is VFIO PCI...
> 

Ah, I thought IOMMUFD would be used instead of VFIO_TYPE1*, which should cover
platform devices (VFIO-platform) or am I missing something?

And multi-SIDs is common in platform devices and this would be quite
restricting, and I was hoping to support the pKVM vIOMMU through IOMMUFD
interface.

If possible, can the UAPI be designed with this in mind, even if not
implemented now?

Thanks,
Mostafa

> Jason

