Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B856A6526
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 02:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCAB6Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Feb 2023 20:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCAB6P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Feb 2023 20:58:15 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E233AA5;
        Tue, 28 Feb 2023 17:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677635894; x=1709171894;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JvUgqcrgfQlznLASCJxhJivg+YLodSnLHw0JHLUxNf0=;
  b=c7eVIA4S6o/WJReO3+yIlWpTvW2sZgAl8Dut15dnWHFYgoU61m2CX/lg
   Osym+AnUNZjjWcVReWqOcnnKtDXbOn+C2n9X6neLUuRtRScVc+y3x/m03
   57dcVBbV6PFyiii2ha43lPrOdkFWvKD5l2ju7cN9JcnrGUvgj5ORjgj25
   q9TAsQbSuyFxspsAkz/jaW8+UwYg+ouGq2VI4326BGLBckv6YG1J8C6Of
   T3tsTVBJx1lTOVZcCokUIdYTXAiZ/7+EkRCqALGozjUnigLTQ8taVoi01
   gqTgwTpFsLwzqRVc4wlfBVWrmSGK5JGeHDaxmDDo95pFYIJFZJ2bZdSO6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336590406"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="336590406"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 17:56:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="651828038"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="651828038"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2023 17:56:12 -0800
Message-ID: <91e8d0ee-ee28-0866-85c9-2b499a5dcc38@linux.intel.com>
Date:   Wed, 1 Mar 2023 09:55:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <cdbc3707-d326-26d4-3adc-ff2ed80aa2ba@linux.intel.com>
 <Y/y3A4LJqunT0ZwS@nvidia.com>
 <adfd78d1-006e-5e7c-236b-cc00e8afb8c0@linux.intel.com>
 <Y/4G4u/uYA3eg7OY@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y/4G4u/uYA3eg7OY@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/28/23 9:51 PM, Jason Gunthorpe wrote:
> On Tue, Feb 28, 2023 at 09:50:52AM +0800, Baolu Lu wrote:
>> On 2/27/23 9:58 PM, Jason Gunthorpe wrote:
>>> On Sun, Feb 26, 2023 at 11:01:59AM +0800, Baolu Lu wrote:
>>>> On 2/25/23 8:27 AM, Jason Gunthorpe wrote:
>>>>> @@ -437,25 +517,77 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
>>>>>     		struct iommufd_ioas *ioas =
>>>>>     			container_of(pt_obj, struct iommufd_ioas, obj);
>>>>> -		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
>>>>> -		if (rc)
>>>>> +		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
>>>>> +							      do_attach);
>>>>> +		if (IS_ERR(destroy_hwpt))
>>>>>     			goto out_put_pt_obj;
>>>>>     		break;
>>>>>     	}
>>>>>     	default:
>>>>> -		rc = -EINVAL;
>>>>> +		destroy_hwpt = ERR_PTR(-EINVAL);
>>>>>     		goto out_put_pt_obj;
>>>>>     	}
>>>>> +	iommufd_put_object(pt_obj);
>>>>> -	refcount_inc(&idev->obj.users);
>>>>> -	rc = 0;
>>>>> +	/* This destruction has to be after we unlock everything */
>>>>> +	if (destroy_hwpt)
>>>> Should this be
>>>>
>>>> 	if (!IS_ERR_OR_NULL(destroy_hwpt))
>>>>
>>>> ?
>>> Never use IS_ERR_OR_NULL ..
>> Can you please elaborate a bit on this? I can still see a lot of use of
>> it in the tree.
> Yes, sadly. It is usually some signal of toxic confusion about what
> things mean.
> 
> A function that returns an ERR_PTR should very rarely return NULL, and
> if it does return NULL then NULL wasn't an error.

That's true.

> Further you should never store an ERR_PTR in some structure and then
> later try to test it, that is madness.
> 
> So with properly structured code the need should not exist.
> 
> https://lore.kernel.org/all/20130109150427.GL3931@n2100.arm.linux.org.uk/

It's clear to me now. Thanks a lot for the explanation.

Best regards,
baolu
