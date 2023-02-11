Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA35692E09
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Feb 2023 04:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBKDmx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 22:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBKDmx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 22:42:53 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A13E5B74B;
        Fri, 10 Feb 2023 19:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676086972; x=1707622972;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mb6jH6AmOE4FzUbSjuwgu/iwgBs2C4fgrjOWh5cufe0=;
  b=EjmK2QvgQoxHCABhMzT300KrNS5JLm0TrwJZTUS+cGOjlEcYKCGtzJge
   4NxQxXYX07WdpZVblwBF5O8WO5Sy5vnoEP9UjEljDz2MoS5oEFfbTKbfr
   gfrepF2gOsoReh+EuTXQ718tl602LlEvcsyx5myYAQvKYr9Ld+IznmhwW
   NYDJzOhscO1meiIYXl34OtzD0P6T2dSqxOV99Py/uquXzOfSdBLlIOufD
   YFtsounEBstZUyi2+xYU6a+vIE9dUI2MORpa1ZROmLBBCxiCH3b3jdlfz
   wJiPYzDMoOcmA/NEhaL6RfNUmFWRdDphnD0haMfDf8UvyLMnLCzlUcO7B
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="331883145"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="331883145"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:42:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="842224646"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="842224646"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.168.175]) ([10.249.168.175])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:42:46 -0800
Message-ID: <8665f299-fd4f-738a-6492-59f0deef444f@linux.intel.com>
Date:   Sat, 11 Feb 2023 11:42:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/6] iommu: Add new iommu op to get iommu hardware
 information
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-2-yi.l.liu@intel.com>
 <BN9PR11MB5276CB88298F97177A7AAF448CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276CB88298F97177A7AAF448CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/2/10 15:28, Tian, Kevin wrote:
>> From: Liu, Yi L<yi.l.liu@intel.com>
>> Sent: Thursday, February 9, 2023 12:17 PM
>> @@ -223,6 +224,11 @@ struct iommu_iotlb_gather {
>>   /**
>>    * struct iommu_ops - iommu ops and capabilities
>>    * @capable: check capability
>> + * @hw_info: IOMMU hardware capabilities. The type of the returned data
>> is
> is it 'info' or 'capability'?

hw_info. IOMMU core does not care about specific content, so it is not
necessary to define it as capability or anything else.

Perhaps we need to change the comments a bit, say, "IOMMU hardware
information"?

Best regards,
baolu

