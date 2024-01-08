Return-Path: <linux-kselftest+bounces-2711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D0826996
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 09:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6961C21A99
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 08:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B964FBA57;
	Mon,  8 Jan 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVxK++d9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B2ABA4B;
	Mon,  8 Jan 2024 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704703065; x=1736239065;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GncR5FdB7gQF27APfP3bULtZ1spPn60JzQ0JnmY5Xrw=;
  b=RVxK++d9OgRnMQcfPLeMPN+fahS2Qeklrk7RyNP1uwuj3SAcfaPhyyY7
   oUd+aoI20EI7QW6Adl2Xethn/xOEjqAa213aQKYkzOL6NazJeg9IaJzCb
   XC7p9AgNOiBlfnhrDxIh0aHiHB2UAN6GNXeZ08PkOa5T1Z18VcBn58ipi
   i/jKj+VpAwanGg+EgnG09KzgB1/lrHBiuyZLOGfssJOcakfCdRft6jgbo
   7bLVuikuT09uhKhD1MyAmksDoc+QS/HCOQz/Y2zk4417aliytwzJZYLgO
   I/Qris/N49H0XtmtHD3LwtgdGojcTJB4nDxoUJ+NW0k04v/aBsDCENLHu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="400583126"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="400583126"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 00:37:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="731042280"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="731042280"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.2.99]) ([10.238.2.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 00:37:37 -0800
Message-ID: <272782f8-e17f-4f92-9d20-cbee790b4c7f@linux.intel.com>
Date: Mon, 8 Jan 2024 16:37:35 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] iommu: Add iommu_copy_struct_from_user_array
 helper
To: Yi Liu <yi.l.liu@intel.com>
Cc: alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
 robin.murphy@arm.com, baolu.lu@linux.intel.com, joro@8bytes.org,
 cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com, xin.zeng@intel.com,
 yan.y.zhao@intel.com
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-4-yi.l.liu@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231117130717.19875-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/17/2023 9:07 PM, Yi Liu wrote:
> +
> +/**
> + * iommu_copy_struct_from_user_array - Copy iommu driver specific user space
> + *                                     data from an iommu_user_data_array
> + * @kdst: Pointer to an iommu driver specific user data that is defined in
> + *        include/uapi/linux/iommufd.h
> + * @user_array: Pointer to a struct iommu_user_data_array for a user space array
> + * @data_type: The data type of the @kdst. Must match with @user_array->type
> + * @index: Index to offset the location in the array to copy user data from
> + * @min_last: The last memember of the data structure @kdst points in the

s/memember/member/

> + *            initial version.
> + * Return 0 for success, otherwise -error.
> + */
> +#define iommu_copy_struct_from_user_array(kdst, user_array, data_type,   \
> +					  index, min_last)               \
> +	__iommu_copy_struct_from_user_array(kdst, user_array, data_type, \
> +					    index, sizeof(*kdst),        \
> +					    offsetofend(typeof(*kdst),   \
> +							min_last))
> +
>   /**
>    * struct iommu_ops - iommu ops and capabilities
>    * @capable: check capability


