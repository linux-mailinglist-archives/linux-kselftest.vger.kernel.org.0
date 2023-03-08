Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426BC6AFCB6
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 03:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCHCJH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 21:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCHCJG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 21:09:06 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518FA9CFE6;
        Tue,  7 Mar 2023 18:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678241345; x=1709777345;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=woVR2ZD8eombgINcedIWUBQofWyG0b8s7gkpgdn6/0E=;
  b=AnKlAapxTh5JlnSs6BGKdPCx7vsppchmH8WlWsL75uA9MzQz1Vrghhcq
   nbRFPjgAydPZKPkMhJLiuJcZgf7ifoQsaDoUv832cpuyTGtc7KdBcb900
   8QSyhDeXcJNCJDfY+fAQIQ4Vtnr7mFJ4pBx6qSsa64hUuGHO00yw+/mKd
   j7b1BGKZZyt22JidsSYrxTfOq5OjQSWZuePbR3SjHJOtTy61le64THi/9
   QjIq4GaSZk2/219SYDjRNVVP1/Db0YSMW+IQ/PW6Esibilbk/4t0crnbT
   o34XsDlwgqJCdX1e5tRS73TtzEN8p77QKYoNwLB81uUnxIy9qjAWhtgng
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="324344069"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="324344069"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 18:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="740941933"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="740941933"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 07 Mar 2023 18:09:02 -0800
Message-ID: <d441b9bb-e9b2-190d-981b-1fdc288b0a07@linux.intel.com>
Date:   Wed, 8 Mar 2023 10:08:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 00/14] Add iommufd physical device operations for replace
 and alloc hwpt
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52764E0C994D6B2519BD6F9B8CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAcyEzN4102gPsWC@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZAcyEzN4102gPsWC@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/7/23 8:46 PM, Jason Gunthorpe wrote:
> On Tue, Mar 07, 2023 at 08:42:06AM +0000, Tian, Kevin wrote:
>>> From: Jason Gunthorpe<jgg@nvidia.com>
>>> Sent: Saturday, February 25, 2023 8:28 AM
>>>
>> [...]
>>> The implementation is complicated because we have to introduce some
>>> per-iommu_group memory in iommufd and redo how we think about multi-
>>> device
>>> groups to be more explicit. This solves all the locking problems in the
>>> prior attempts.
>>>
>> Now think about the pasid case.
>>
>> pasid attach is managed as a device operation today:
>> 	iommu_attach_device_pasid()
>>
>> Following it naturally we'll have a pasid array per iommufd_device to
>> track attached HWPT per pasid.
>>
>> But internally there is only one pasid table per iommu group. i.e. same
>> story as RID attach that once dev1 replaces hwpt on pasid1 then it takes
>> effect on all other devices in the same group.
> IMHO I can't belive that any actual systems that support PASID have a
> RID aliasing problem too.
> 
> I think we should fix the iommu core to make PASID per-device and
> require systems that have a RID aliasing problem to block PASID.
> 
> This is a bigger picture, if drivers have to optionally share their
> PASID tables with other drivers then we can't have per-driver PASID
> allocators at all either.

This is actually required in PCI and IOMMU core. pci_enable_pasid()
requires full ACS support on device's upstream path:

        if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
                 return -EINVAL;

and, for such PCI topology, iommu core always allocates an exclusive
iommu group.

The only place where seems to be a little messy is,

static int __iommu_set_group_pasid(struct iommu_domain *domain,
                                    struct iommu_group *group, ioasid_t 
pasid)
{
         struct group_device *device;
         int ret = 0;

         list_for_each_entry(device, &group->devices, list) {
                 ret = domain->ops->set_dev_pasid(domain, device->dev, 
pasid);
                 if (ret)
                         break;
         }

         return ret;
}

Perhaps we need a check on singleton group?

Best regards,
baolu
