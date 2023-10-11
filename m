Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C9A7C4866
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 05:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344976AbjJKDWY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 23:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJKDWX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 23:22:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D5D91;
        Tue, 10 Oct 2023 20:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696994541; x=1728530541;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mfGQA09nt+pjnB7NA+LILPA/SIcWHOBZ2pc/nhd6wsU=;
  b=FxB1iKyUWuDSxDosftBfKNMxNfGxAlA8qBZLKFWmP5c4cyx63syUC8Fh
   RRiT0ABrcRREH+HkOa/ik8v7k/PabXdu4SBEdG7srNGsJmntgwyBz69ON
   phsTfr7xsEq1fdrTB5xELm7cfnR3VLauhSTVFvXZnQkfb02rNBnTpypLf
   PuVbzFm3esfVsMrkMRt97aJjbytIfFVL5dobXXm3mKTamsQWfUJ6V3U4p
   LHn4RMtolp/aI7L4D2sZk+x3zMBgRK6iqJY9ytCTeN/Fe2KrWCp1QHELL
   kNBpjDbKHxvKKHhcBKw49Iz9mIlbi8dtXvVmS2Ncz1v7A5irhJcJfpaEe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="364852543"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="364852543"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 20:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877501933"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="877501933"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2023 20:22:15 -0700
Message-ID: <558c3038-11b4-4afe-b441-fe62b646a192@linux.intel.com>
Date:   Wed, 11 Oct 2023 11:18:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v2 6/6] iommu/vt-d: Add domain_alloc_user op
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-7-yi.l.liu@intel.com>
 <20231010164355.GA74795@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231010164355.GA74795@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/11/23 12:43 AM, Jason Gunthorpe wrote:
> On Thu, Sep 28, 2023 at 12:15:28AM -0700, Yi Liu wrote:
>> This adds the domain_alloc_user op implementation. It supports allocating
>> domains to be used as parent under nested translation.
>>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 5db283c17e0d..017aed5813d8 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4074,6 +4074,33 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>>   	return NULL;
>>   }
>>   
>> +static struct iommu_domain *
>> +intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct intel_iommu *iommu;
>> +
>> +	if (flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT))
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	iommu = device_to_iommu(dev, NULL, NULL);
>> +	if (!iommu)
>> +		return ERR_PTR(-ENODEV);
> Why isn't this just
> 
> 	struct device_domain_info *info = dev_iommu_priv_get(dev)
> 	struct intel_iommu *iommu = info->iommu
> 
> ???
> 
> Same question for almost all other calls to this function! The one in
> probe is reasonable, but I don't think it should be ever called again.
> 
> I'm going to leave this, but please make a series cleaning all the
> device_to_iommu() stuff next cycle..

Sure. I also have a plan to do this. device_to_iommu() is only needed in
the probe path. For runtime callbacks, we can just retrieve it from the
device's iommu private data.

Best regards,
baolu
