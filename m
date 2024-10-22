Return-Path: <linux-kselftest+bounces-20362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1928E9A963B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 04:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46B01F2282A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1581386B3;
	Tue, 22 Oct 2024 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDhx3o6t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC357E59A;
	Tue, 22 Oct 2024 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729564120; cv=none; b=lsp6WgFzFR0l21n13hFdli4///Pq3TQJO+zXgm70wA9R/JGEvkW9gid5DV+0OyoLkhVcDXHqnNlMUSRdeBDaaxWucljXmnq2n8kZMDqwue/gUFFG/OUvZ3GgrBphMqjv810a2DvRJHy4nWfYWisixvG9XG+3cSH6WlLqBoAX2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729564120; c=relaxed/simple;
	bh=iEVflV2wjj9RZWicdMKZ+yzF/35ywBCnw8lgo8VyfoU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MVXr7Bf60J64bqDez0kR1wfx6aBMHA8jYBLlG8Q6gq9yv1CiLM93WzXE+39Fy6BCdUMdGUPXqFqWMG1lyp09xXe4UkpADEQ+9ZZaszv5NKlI7jZs/qlptKoOr01mTlGQFAnMkXNlhCRi9ZjKVM3M8mzsejQrmUVgwVEmSN3CDWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDhx3o6t; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729564118; x=1761100118;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iEVflV2wjj9RZWicdMKZ+yzF/35ywBCnw8lgo8VyfoU=;
  b=BDhx3o6tNg+HuP8wLbPwCwmq9HJH/ookgI9b9iidfw0HfQrzKlIZpfh0
   dgYUiKxy/F9lWBNxfSBX26GMpODlqOjjryyx4o56JMyq+Fm1g8foiLQgd
   BXz8SnPW2m2Led3DhqWiyliFv4A8C3muOfXE4T1OPPRkgJSAKm6OBvAWW
   ynSP5zbN4ZxWLY0mJh3XVsXDQeldDbGeLIfPNT+86lbvI1Pa2SIWcNu/Z
   5X6YODS5dpABuvAslx5Tg528h1fQ2vDoDIhy0D8+5wlS4cSSbJsl/Yg/u
   z6S99vbSANI+LKQLs1Btwj8mEL/ECCvoUEMtJSNn/ozUIODma6mVnPcU6
   Q==;
X-CSE-ConnectionGUID: OFu6AEzqRzmlf8VSnv/cUQ==
X-CSE-MsgGUID: 93ir9znMQPatp3v/lcWDMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28954295"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28954295"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 19:28:38 -0700
X-CSE-ConnectionGUID: V/GHqH7dS5aJ9QT0c3vq+w==
X-CSE-MsgGUID: 1rV8F+TdROq4Rkx6rM0JtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79288212"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 19:28:33 -0700
Message-ID: <b2c75705-2998-4e51-90f4-00b8bab785f5@linux.intel.com>
Date: Tue, 22 Oct 2024 10:28:30 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com, aik@amd.com,
 zhangfei.gao@linaro.org, patches@lists.linux.dev
Subject: Re: [PATCH v4 02/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 will@kernel.org
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <74fec8c38a7d568bd88beba9082b4a5a4bc2046f.1729553811.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <74fec8c38a7d568bd88beba9082b4a5a4bc2046f.1729553811.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/22 8:19, Nicolin Chen wrote:
> + * @viommu_alloc: Allocate an iommufd_viommu on a physical IOMMU instance behind
> + *                the @dev, as the set of virtualization resources shared/passed
> + *                to user space IOMMU instance. And associate it with a nesting
> + *                @parent_domain. The @viommu_type must be defined in the header
> + *                include/uapi/linux/iommufd.h
> + *                It is suggested to call iommufd_viommu_alloc() helper for
> + *                a bundled allocation of the core and the driver structures,
> + *                using the given @ictx pointer.
>    * @pgsize_bitmap: bitmap of all possible supported page sizes
>    * @owner: Driver module providing these ops
>    * @identity_domain: An always available, always attachable identity
> @@ -591,6 +601,10 @@ struct iommu_ops {
>   	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid,
>   				 struct iommu_domain *domain);
>   
> +	struct iommufd_viommu *(*viommu_alloc)(
> +		struct device *dev, struct iommu_domain *parent_domain,
> +		struct iommufd_ctx *ictx, unsigned int viommu_type);

Is the vIOMMU object limited to a parent domain?

Thanks,
baolu

