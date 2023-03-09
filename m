Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04F86B18FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 03:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCICEs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 21:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCICEr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 21:04:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7739293E07;
        Wed,  8 Mar 2023 18:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678327486; x=1709863486;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=if4EnRdVTqRFluZZ15aJg5/tmUStcMzTqA7YH2M70BE=;
  b=dEutXpZ8vLSpJLmZ5XHcuUYIkl+/bsdedroh5CJJd/cL9WANktq7JgTT
   VAe3Ibi85SkRVRWxKDG0xfVk4AJbWsJJIBfZ6JF09cxFKyjHKEVdqK7YZ
   H3YoVK3dUHocGAG+rdHQoWA7RdmC74cWR4+7eW1vZ91AsBC+okTLjK6dC
   x11D2LsgWgR0kIiGZjpSV4oEX8TS2vrtswreX/UPQ5xyB3ucnTcsoI/R+
   /wEONwiEdTpGozij9GIwa+i/zOKuKK7NsZkBZ0JVCESeLw9unQKaPjUXB
   Fo2w6c7Hq0RqG25PSn634I0A+YatffBPt/I7eVhySlqjKm1Hia93bzI4j
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="363966962"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="363966962"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="679564801"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="679564801"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 08 Mar 2023 18:04:44 -0800
Message-ID: <5e19a851-cf75-4591-e3fa-8d10d5b7e85f@linux.intel.com>
Date:   Thu, 9 Mar 2023 10:03:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 09/17] iommufd: Add enforced_cache_coherency to
 iommufd_hw_pagetable_alloc()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <9-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <07b337da-e215-434b-b84f-8fadd07e3020@linux.intel.com>
 <ZAikdKoQkSfqxMxc@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZAikdKoQkSfqxMxc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/8/23 11:06 PM, Jason Gunthorpe wrote:
> On Wed, Mar 08, 2023 at 09:04:47PM +0800, Baolu Lu wrote:
>>> +	/* Try to upgrade the domain we have */
>>> +	if (idev->enforce_cache_coherency) {
>>> +		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
>>> +		if (rc)
>>> +			return rc;
>> As "HWPT should have the coherency set properly for the device that it
>> is being created for when it is created", is it an incompatible case if
>>
>> 	idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency
>>
>> ?
>>
>> If so, why not,
>>
>> 	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency)
>> 		return -EINVAL;
> In principle you can create a HWPT for device A and then later attach
> it to device B
> 
> If B requires coherency then we try to upgrade the existing domain.
> 
> This is an effort to try an minimize the number of domains that we
> need to have for simpe IOAS based cases where we don't want to spawn
> two auto domains

OK. Clear to me now. Actually hwpt->enforce_cache_coherency makes sense
only after it is attached to an idev.

Best regards,
baolu
