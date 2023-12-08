Return-Path: <linux-kselftest+bounces-1412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610E809B98
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 06:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB42B20D3E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 05:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A55668;
	Fri,  8 Dec 2023 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHqW05BF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C0C10D8;
	Thu,  7 Dec 2023 21:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702012498; x=1733548498;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eMqZIBfmXsW4JIGVz2VpEyeyCc8OAVvggzWL9Lorv+E=;
  b=KHqW05BFCOsrKdTN0f28nOoNf0Ekp5GLHowo324aWo/3rVQnzUm7FkGK
   LLPte9FZP04ZqtRIrQuguESpWyilpvlo8hMPCOZm/lA0DMPfFLPi2Ac1w
   IlE6OE7l8q8gxGpFa/zic3lyemFmBVjHktR+BZkIYRoJHFoMq2g82TY8C
   tXaD1UMAOj1btoxmSMVFfMdoPPgobtnCUm9vX96SnzPpcrOM8Alqoldou
   i/2ICWFS3u21Ogy4fxgAKJn8aVM0mfaBfY6i2OfKrPxIV3ebsh/IG5JR6
   cdwMHgsIo3fIKLKxSK+kUiXVqPcKHXOKgJuUW/XMKu8pow+W3tIBLZpM7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="480554314"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="480554314"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 21:14:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="775684230"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="775684230"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2023 21:14:54 -0800
Message-ID: <8d29c6fb-0928-4c11-a9af-02647597cb4e@linux.intel.com>
Date: Fri, 8 Dec 2023 13:10:17 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <CGME20231204150747eucas1p2365e92a7ac33ba99b801d7c800acaf6a@eucas1p2.samsung.com>
 <20231204150744.db3hfpq4v55cuavn@localhost>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231204150744.db3hfpq4v55cuavn@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/23 11:07 PM, Joel Granados wrote:
> On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
>> Hi folks,
>>
>> This series implements the functionality of delivering IO page faults to
>> user space through the IOMMUFD framework for nested translation. Nested
> Does this mean the IOPF_CAPABLE HWPT needs to be parented by a HWPT
> created with IOMMU_HWPT_ALLOC_NEST_PARENT set?

No. It's generic, nested translation is simply a use case that is
currently feasible.

Best regards,
baolu

