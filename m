Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC93570431C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 03:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjEPBt5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 21:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEPBtz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 21:49:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F511BD0;
        Mon, 15 May 2023 18:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684201794; x=1715737794;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yoBH6vhYXirTJn4ngLQetM+EEw/EqS96eNcX9cDbZ/o=;
  b=BR04lS4lP/ELMB8tQoS067kbCPNy39tya0lNKYcdtOBpA4roEG1G1Aeg
   YKmAxRUCqlkp2q2j0JyBzgTQiNJ1dEl9N6D9TmHAXQ5sarZxgrrMEnLe5
   X4E0cHVpBEepw1U5mB/YC1Cwg0cVf6TfE3ec8l4qb0aLbPd/nB4ckSYZg
   qxq7/QjOBWaHSCrJh51nIX4JfsQuspI9Cbsea1wFqsZBobY8LThLt4ywt
   lRPUw2Etu408HkPLbjRrmiNcnWQrOJw8ScCkqiaf5h6Niu3ki4Z6HTqEA
   xjNug+iSQY8UxovqRQ/rDYrhsHiWnnovzBF6F0Qb+r/l6nu6ku6S+TstG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="340716246"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="340716246"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 18:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="790880836"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="790880836"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 15 May 2023 18:49:48 -0700
Message-ID: <57101685-35c3-8a71-9a39-a6d9fd58414c@linux.intel.com>
Date:   Tue, 16 May 2023 09:49:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
Subject: Re: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Content-Language: en-US
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230511143024.19542-1-yi.l.liu@intel.com>
 <20230511143024.19542-4-yi.l.liu@intel.com>
 <6ab2d63e-4dcc-6562-9698-d23300c7d1ae@linux.intel.com>
 <DS0PR11MB752940450312B2E0529C3DC6C3789@DS0PR11MB7529.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DS0PR11MB752940450312B2E0529C3DC6C3789@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/15/23 2:14 PM, Liu, Yi L wrote:
>> -----Original Message-----
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Friday, May 12, 2023 1:39 PM
>> To: Liu, Yi L<yi.l.liu@intel.com>;joro@8bytes.org;alex.williamson@redhat.com;
>> jgg@nvidia.com; Tian, Kevin<kevin.tian@intel.com>;robin.murphy@arm.com
>> Cc:baolu.lu@linux.intel.com;cohuck@redhat.com;eric.auger@redhat.com;
>> nicolinc@nvidia.com;kvm@vger.kernel.org;mjrosato@linux.ibm.com;
>> chao.p.peng@linux.intel.com;yi.y.sun@linux.intel.com;peterx@redhat.com;
>> jasowang@redhat.com;shameerali.kolothum.thodi@huawei.com;lulu@redhat.com;
>> suravee.suthikulpanit@amd.com;iommu@lists.linux.dev;linux-kernel@vger.kernel.org;
>> linux-kselftest@vger.kernel.org; Duan, Zhenzhong<zhenzhong.duan@intel.com>
>> Subject: Re: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
>>
>> On 5/11/23 10:30 PM, Yi Liu wrote:
>>> Under nested IOMMU translation, userspace owns the stage-1 translation
>>> table (e.g. the stage-1 page table of Intel VT-d or the context table
>>> of ARM SMMUv3, and etc.). Stage-1 translation tables are vendor specific,
>>> and needs to be compatiable with the underlying IOMMU hardware. Hence,
>>> userspace should know the IOMMU hardware capability before creating and
>>> configuring the stage-1 translation table to kernel.
>>>
>>> This adds IOMMU_DEVICE_GET_HW_INFO to query the IOMMU hardware
>> information
>>> for a given device. The returned data is vendor specific, userspace needs
>>> to decode it with the structure mapped by the @out_data_type field.
>>>
>>> As only physical devices have IOMMU hardware, so this will return error
>>> if the given device is not a physical device.
>>>
>>> Co-developed-by: Nicolin Chen<nicolinc@nvidia.com>
>>> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
>>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>>> ---
>>>    drivers/iommu/iommufd/device.c          | 72 +++++++++++++++++++++++++
>>>    drivers/iommu/iommufd/iommufd_private.h |  1 +
>>>    drivers/iommu/iommufd/main.c            |  3 ++
>>>    include/uapi/linux/iommufd.h            | 37 +++++++++++++
>>>    4 files changed, 113 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>>> index 051bd8e99858..bc99d092de8f 100644
>>> --- a/drivers/iommu/iommufd/device.c
>>> +++ b/drivers/iommu/iommufd/device.c
>>> @@ -263,6 +263,78 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
>>>    }
>>>    EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, IOMMUFD);
>>>
>>> +static int iommufd_zero_fill_user(u64 ptr, int bytes)
>>> +{
>>> +	int index = 0;
>>> +
>>> +	for (; index < bytes; index++) {
>>> +		if (put_user(0, (uint8_t __user *)u64_to_user_ptr(ptr + index)))
>>> +			return -EFAULT;
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd)
>>> +{
>>> +	struct iommu_hw_info *cmd = ucmd->cmd;
>>> +	unsigned int length = 0, data_len;
>>> +	struct iommufd_device *idev;
>>> +	const struct iommu_ops *ops;
>>> +	void *data = NULL;
>>> +	int rc = 0;
>>> +
>>> +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
>>> +	if (IS_ERR(idev))
>>> +		return PTR_ERR(idev);
>>> +
>>> +	ops = dev_iommu_ops(idev->dev);
>>> +	if (!ops->hw_info)
>>> +		goto done;
>> If the iommu driver doesn't provide a hw_info callback, it still
>> returns success?
> Yes, as noted in the cover letter. It's for a remark from Jason. In such
> case, the out_data_type is NULL, it means no specific data is filled
> in the buffer pointed by cmd->data_ptr.
> 
> - Let IOMMU_DEVICE_GET_HW_INFO succeed even the underlying iommu driver
>     does not have driver-specific data to report per below remark.
>     https://lore.kernel.org/kvm/ZAcwJSK%2F9UVI9LXu@nvidia.com/

Oh, I overlooked that. Thanks for the explanation. It's fair enough.

Best regards,
baolu
