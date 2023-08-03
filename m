Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFD276DEF1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 05:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjHCDZy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 23:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjHCDZN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 23:25:13 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342D230D3;
        Wed,  2 Aug 2023 20:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691033088; x=1722569088;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ICQshYmMfbXZrwMngTGz4HUFiYda9PJa/FB3HICeWPs=;
  b=H/mgz5ldWeM56GcB0a7HhGSHj1imk/vE2u/FSdULKhWYhGX7k+nYxc6x
   caA761u0lw9iOO5fVotwNNVIlKQ93D1HSwt8ihwJaeagGjJhikWLk6IiF
   8y6afutuKsOiMhTv5swBNQdC5FY0zDdH9KDtD7vSFys+Isz5Ip1iGvK86
   Trr9sqwTBRU7iieuHZFtapx+a/gq8CjehmLBfu4yPw7M3iOEryvZoIrYF
   5ztAa5w8dU+/YiqV+lcT/GCXzkOgMON/7txzh1bjN9CLGFEVCNq6yCWDX
   J4WzAE4jHeFeYbJ+C0h1LIla/v4Z2YPuKATDtQQ6XzNnYE3I4/1yDAQh8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350050674"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="350050674"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="1060074437"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="1060074437"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.34]) ([10.255.31.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:24:42 -0700
Message-ID: <58ae9095-28f2-a44a-b0e5-be82e1eae9d9@linux.intel.com>
Date:   Thu, 3 Aug 2023 11:24:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/8/2 15:46, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, July 24, 2023 7:14 PM
>>
>> +static int intel_nested_cache_invalidate_user(struct iommu_domain
>> *domain,
>> +					      void *user_data)
>> +{
>> +	struct iommu_hwpt_vtd_s1_invalidate_desc *req = user_data;
>> +	struct iommu_hwpt_vtd_s1_invalidate *inv_info = user_data;
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	unsigned int entry_size = inv_info->entry_size;
>> +	u64 uptr = inv_info->inv_data_uptr;
>> +	u64 nr_uptr = inv_info->entry_nr_uptr;
>> +	struct device_domain_info *info;
>> +	u32 entry_nr, index;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	if (get_user(entry_nr, (uint32_t __user *)u64_to_user_ptr(nr_uptr)))
>> +		return -EFAULT;
>> +
>> +	for (index = 0; index < entry_nr; index++) {
>> +		ret = copy_struct_from_user(req, sizeof(*req),
>> +					    u64_to_user_ptr(uptr + index *
>> entry_size),
>> +					    entry_size);
> 
> If continuing this direction then the driver should also check minsz etc.
> for struct iommu_hwpt_vtd_s1_invalidate and iommu_hwpt_vtd_s1_invalidate_desc
> since they are uAPI and subject to change.

Agreed.

> 
>> +		if (ret) {
>> +			pr_err_ratelimited("Failed to fetch invalidation
>> request\n");
>> +			break;
>> +		}
>> +
>> +		if (req->__reserved || (req->flags &
>> ~IOMMU_VTD_QI_FLAGS_LEAF) ||
>> +		    !IS_ALIGNED(req->addr, VTD_PAGE_SIZE)) {
>> +			ret = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		spin_lock_irqsave(&dmar_domain->lock, flags);
>> +		list_for_each_entry(info, &dmar_domain->devices, link)
>> +			intel_nested_invalidate(info->dev, dmar_domain,
>> +						req->addr, req->npages);
>> +		spin_unlock_irqrestore(&dmar_domain->lock, flags);
> 
> Disabling interrupt while invalidating iotlb is certainly unacceptable.
> 
> Actually there is no need to walk devices. Under dmar_domain there
> is already a list of attached iommu's.

Walking device is only necessary when invalidating device TLB. For iotlb
invalidation, it only needs to know the iommu's.

Best regards,
baolu
