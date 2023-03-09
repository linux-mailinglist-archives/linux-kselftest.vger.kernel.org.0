Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A216B18DB
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 02:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCIBoQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 20:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCIBoQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 20:44:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E783F8;
        Wed,  8 Mar 2023 17:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678326254; x=1709862254;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4KAyNFjB6MR3x2c7wk0ZgGpMkoqsgma6RxENs34cggA=;
  b=RC7GH2cIZPCjSSluchYz2e0bbI4kaInWq2GVeNp+l5u5WhYyJSpAK/VP
   yFs+AVy96xfNH446k/k7fzisFxnWyfnxDHQ8Y0fqvT3brz7Hi6gP2qdnj
   qJmA/1IkMVCNIR4YfCaoYYOs/tU0GK3mDChaZ54E9CrXajgrlFr6+LPng
   rzjlkrToruFd5E4whPcFxXcNtKvxTWr5GrNB51hE8BWn0EiPs+DP7GXhw
   spviah33yaAsVxkSv5WiuaAiAa+zP/idYQQBmGkYwVuM6UbJ4UBb9079m
   m+sf70gAdIaFZWUaNOsx1GoC8rKDx9bRuDQNekdJuSwSk5SGIcV6MXfdJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333797855"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="333797855"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 17:44:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="766235333"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="766235333"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2023 17:44:12 -0800
Message-ID: <a2a198ec-2a11-28f5-db2d-ca8c7ec76cbe@linux.intel.com>
Date:   Thu, 9 Mar 2023 09:43:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 05/17] iommufd: Keep track of each device's reserved
 regions instead of groups
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <5-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <9a047c7f-924d-0c8a-7055-fcbe7c84429b@linux.intel.com>
 <ZAijolW3I1BOSjpn@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZAijolW3I1BOSjpn@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/8/23 11:02 PM, Jason Gunthorpe wrote:
> On Wed, Mar 08, 2023 at 08:32:03PM +0800, Baolu Lu wrote:
>>> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>>> index 2ff192777f27d3..22863759c3bfb0 100644
>>> --- a/drivers/iommu/iommufd/iommufd_private.h
>>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>>> @@ -76,10 +76,9 @@ int iopt_table_add_domain(struct io_pagetable *iopt,
>>>    			  struct iommu_domain *domain);
>>>    void iopt_table_remove_domain(struct io_pagetable *iopt,
>>>    			      struct iommu_domain *domain);
>>> -int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
>>> -					  struct device *device,
>>> -					  struct iommu_group *group,
>>> -					  phys_addr_t *sw_msi_start);
>>> +int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
>>> +					struct device *dev,
>>> +					phys_addr_t *sw_msi_start);
>>>    int iopt_set_allow_iova(struct io_pagetable *iopt,
>>>    			struct rb_root_cached *allowed_iova);
>>>    int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,
>>
>> Perhaps a silly question. The reserved regions are enforced in IOVA when
>> a device is added to the igroup's device list. Should it be released
>> after the device is removed from the list?
> 
> Yes, it is, iommufd_hw_pagetable_detach() does it right after the
> list_del()
> 
>> This may not be appropriate because the devices may share some common
>> reserved regions, such as the IOMMU_RESV_MSI.
> 
> Common reserved regions are duplicated for every device just as they
> were duplicated for every group.
> 
> The duplicates are keyed with an owner that is equal to the 'struct
> device *' so we only remove the IOVA specific to the struct device.
> 
> The interval tree effectively unions the duplicated and overlapping
> IOVA regions during lookup.
> 
> It is done this way to avoid memory allocation on destruction
> paths. We never have to chop up merged IOVA regions or something to
> remove a device.

Ah! Yes. This has been considered. I should read further into
iopt_reserve_iova() and iopt_remove_reserved_iova(). Thanks for the
explanation.

Best regards,
baolu
