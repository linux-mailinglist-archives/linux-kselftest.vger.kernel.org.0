Return-Path: <linux-kselftest+bounces-31725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AE4A9DF9C
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 08:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8C15A65DD
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 06:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16B523FC66;
	Sun, 27 Apr 2025 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyVacN3W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417D23F412;
	Sun, 27 Apr 2025 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745735292; cv=none; b=f2hbAZE/Ze8P5QslN0VzkxdeihH+NKZ4tjhtojEJyY0+ylaq4A8Er/hnkNamNKU5uysieAI+nCC5LHKaUQU7f6PGsYd9Z9Zh+SnV0bI7s+YJk2ThsUHKf1Oe5KfL2seIna10bbIRuaitMxjhSluGAzAAiSYumRI1NCuNOcz4Yf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745735292; c=relaxed/simple;
	bh=a2U2SlgQI1bryyjViVU51BvLU6tMztBGgxaJGgkhS3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THnFIOKKMUCVIkPbLYAARwenscE16A/Oj1Wdq43zJ4MwtFQOiry7v0q79EGk7iJ8F6ySPKuKCtWQSESfbDN327uhybo0cz+JBxkMj8I1n9TwY27fli2JfxAHHHjUjc9iHtnSUMHtSasGVcgaKYXNLWulHmzhb8FP4JV0cDAFKic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyVacN3W; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745735291; x=1777271291;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a2U2SlgQI1bryyjViVU51BvLU6tMztBGgxaJGgkhS3I=;
  b=cyVacN3WuntkTL4jEBmmhEzfMbOrtTyLWL9WMZy7lJEGPKyzCLIiyKxd
   zg0yQ8OcXJBYW1CUBtGG6gn6HiguqB24oep8MIkhxOeI4rwHe7MAtXcE2
   7q9l4O48IKWgJI1QckF8lhxZnGjVHyB2CvkpJ14j6tGisoubrQQmKZ9N9
   hGdjXcjkXirY7K0TjRsdf4hbEm3qSWpkeTTt5EoWZZMh4tArgufR2mk4N
   wI5tMWOMLgWStu/rfyqGf4ijoXLQkgTOQvFlocyeyHRIRT4G8+zkerwnk
   9lqYkq1ZCESoXpZsY6+OUFsGLy815YdNCNfg9raBkP7MPLiN4j17zn5Fe
   Q==;
X-CSE-ConnectionGUID: lnzulz8XQ6C5dUF3IbLlsA==
X-CSE-MsgGUID: Kg5ZuPhpRfCzi5f2ptt0xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="58326565"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="58326565"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 23:28:10 -0700
X-CSE-ConnectionGUID: 9w3DTI3ARqWE4clFyzRfDg==
X-CSE-MsgGUID: /2mg6I5GSyaCmMoT2ZQ9sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="138218331"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 23:28:04 -0700
Message-ID: <ee9d46f2-5953-4ca4-adac-c3e35c9001a3@linux.intel.com>
Date: Sun, 27 Apr 2025 14:23:54 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/22] iommufd/viommu: Add driver-allocated vDEVICE
 support
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com, vasant.hegde@amd.com
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <14781558dbc291e515b5e249535e3c08290a6792.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <14781558dbc291e515b5e249535e3c08290a6792.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/25 13:57, Nicolin Chen wrote:
> @@ -120,6 +128,13 @@ struct iommufd_viommu {
>    *                    array->entry_num to report the number of handled requests.
>    *                    The data structure of the array entry must be defined in
>    *                    include/uapi/linux/iommufd.h
> + * @vdevice_alloc: Allocate a vDEVICE object and init its driver-level structure
> + *                 or HW procedure. Note that the core-level structure is filled
> + *                 by the iommufd core after calling this op. @virt_id carries a
> + *                 per-vIOMMU virtual ID for the driver to initialize its HW.

I'm wondering whether the 'per-vIOMMU virtual ID' is intended to be
generic for other features that might require a vdevice. I'm also not
sure where this virtual ID originates when I read it here. Could it
potentially come from the KVM instance? If so, how about retrieving it
directly from a struct kvm pointer? My understanding is that vIOMMU in
IOMMUFD acts as a handle to KVM, so perhaps we should maintain a
reference to the kvm pointer within the iommufd_viommu structure?

> + * @vdevice_destroy: Clean up all driver-specific parts of an iommufd_vdevice.
> + *                   The memory of the vDEVICE will be free-ed by iommufd core
> + *                   after calling this op
>    */
>   struct iommufd_viommu_ops {
>   	void (*destroy)(struct iommufd_viommu *viommu);
> @@ -128,6 +143,10 @@ struct iommufd_viommu_ops {
>   		const struct iommu_user_data *user_data);
>   	int (*cache_invalidate)(struct iommufd_viommu *viommu,
>   				struct iommu_user_data_array *array);
> +	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
> +						 struct device *dev,
> +						 u64 virt_id);
> +	void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
>   };

Thanks,
baolu

