Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A45E7AFD34
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 09:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjI0H5x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 03:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjI0H5v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 03:57:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034211D;
        Wed, 27 Sep 2023 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801470; x=1727337470;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9fw5JqfZGLtP0EZFkSoh3FLyEdYPUKKgalF0hPfoVOU=;
  b=QnARFQ8iJS+jx0V+QVnFyuQKrZF9HtxbNR8V5HkMQC0frGojRJCfVt2e
   WZyPPFDoz2PSGCzUb/HuNYDo/lXL3eZ0HED++tDN4AHMM73nODOuwH8Kn
   EVrc08BtMLJicCS0ftGY0iJKdR8WqJdhcEhT7yxPsAqRqrC2ZYdVNgBIT
   V+RIL50685SNcNbyZKpSsxuveqpP79ahWFfFNJuO0yMJwC8BbSgNpePwc
   CjkwE0eMs226hK3Ow4cbSxvrM6PqMYUfvC5Vk0itm+AcHc7RCm9xYh4Cs
   srH4CNL/Kx5a59hqupBhK6T+UHh07OHS0ipRl2gN58AYHwOMBjnZCyGik
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384542935"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="384542935"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:57:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="698770726"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="698770726"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.206]) ([10.254.214.206])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:57:43 -0700
Message-ID: <04af40a3-1675-4b1c-27de-39d261dcb1cf@linux.intel.com>
Date:   Wed, 27 Sep 2023 15:57:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [RFC 8/8] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-9-yi.l.liu@intel.com>
 <BN9PR11MB52766E649727842C98B7396B8CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766E649727842C98B7396B8CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/27 15:52, Tian, Kevin wrote:
>> From: Liu, Yi L<yi.l.liu@intel.com>
>> Sent: Tuesday, September 26, 2023 5:27 PM
>>
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>
>> This allows the upper layers to set a nested type domain to a PASID of a
>> device if the PASID feature is supported by the IOMMU hardware.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/nested.c | 47
>> ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
> pasid can be attached to either user hwpt or kernel hwpt.
> 
> We should also introduce a set_dev_pasid callback for non-nest domain ops.

We already have the code in Linus' tree. The idxd driver uses it for
kernel DMA with pasid.

Best regards,
baolu
