Return-Path: <linux-kselftest+bounces-2710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ECA8268AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 08:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7660281999
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041C8C06;
	Mon,  8 Jan 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqy1+qxg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED28BE3;
	Mon,  8 Jan 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704699294; x=1736235294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H22OiCmXKA/Jr7ukOv8t27r8p7fZrpkasq/T1pnZ5NA=;
  b=jqy1+qxgrMy3D+HtlySvDupTvlly5b/6d/nepc6z8Dq9aGT/4F2sJMRj
   F6YLHQvKjpDMn8C/rm0WzHaf7Oe3GWyvlY7tdOWepnKcstn5m8odI2EnZ
   tNOikv2CLc4IJS51H+oCXhFUMWkWME9GhqnhwDtTU89yOptE20nOnwmjg
   pquK5auh2upcWJw1B1UXjgGvy1+hD1gP3be4UNTPlVj3ucftvTR90arwz
   66ECgTX+0e9yyOiPfjtJea9nOETU9SxVJa1MdPgPUviFKaaUFVbGH9SVQ
   5kL5yaNeFxKabBKdqwvzxBfAh1ya53/TA9MqNw76HyTMfmxWaqNE9XbKv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="464214776"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="464214776"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 23:33:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="15838089"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.2.99]) ([10.238.2.99])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 23:32:58 -0800
Message-ID: <632616b2-ab84-4d2d-bef2-4b564322f78f@linux.intel.com>
Date: Mon, 8 Jan 2024 15:32:55 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] iommu: Add cache_invalidate_user op
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
 kevin.tian@intel.com, robin.murphy@arm.com, baolu.lu@linux.intel.com,
 cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com, xin.zeng@intel.com,
 yan.y.zhao@intel.com
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-2-yi.l.liu@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231117130717.19875-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/17/2023 9:07 PM, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>
> The updates of the PTEs in the nested page table will be propagated to the
> hardware caches on both IOMMU (IOTLB) and devices (DevTLB/ATC).
>
> Add a new domain op cache_invalidate_user for the userspace to flush the
> hardware caches for a nested domain through iommufd. No wrapper for it,
> as it's only supposed to be used by iommufd. Then, pass in invalidation
> requests in form of a user data array conatining a number of invalidation

s/conatining/containing/
> data entries.
>

