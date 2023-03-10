Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA16B3FAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 13:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCJMwG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 07:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJMwE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 07:52:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD910B1E0;
        Fri, 10 Mar 2023 04:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678452720; x=1709988720;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xJvBjtXFbTfnxL0oNKT/W4JlLqLJwv/8uOZC3buZbiQ=;
  b=SG929EYJlfcx5a/2IFs1Ft+uBZbRUEBswylRvWUTgA1I+e+aYKGxmdZa
   pj9yYHJ91LjGP6OvF3wQ/utM0XxiEaNF/J36bieb66RUpJx+6+pMNOdDd
   UJTCh8aekTLJ0NFCn6soAS0/uRO0dqmdd9oqhLK+yB2Mzra0Y9JGpQJ+D
   FdAuimVI6xaPq2wL0NsGOVnd/D7/nTvVooZZbArn+3gMGyUUKrKG84YsT
   ZCT5QU2sz0M1QMUBi9nYuKOA+hTCl/3vk8uR+HOr+Nptc08Z3WWlGrsB+
   F8Y+NiOSY8kNaBpFAQ8LjkBdnXXYvIkgSljcIYBorrYvIx8ZHpOh3OQj7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="336738975"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="336738975"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 04:51:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="655173436"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="655173436"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.50]) ([10.254.213.50])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 04:51:52 -0800
Message-ID: <9119912c-21d2-263f-ef7a-53e2eb827b18@linux.intel.com>
Date:   Fri, 10 Mar 2023 20:51:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 05/12] iommufd/hw_pagetable: Do not populate user-managed
 hw_pagetables
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-6-yi.l.liu@intel.com>
 <b0ea86fd-8350-f694-a93a-a8ccecd0c8e7@linux.intel.com>
 <ZArTN9tIDKuvmuje@Asurada-Nvidia>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZArTN9tIDKuvmuje@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/3/10 14:50, Nicolin Chen wrote:
> On Fri, Mar 10, 2023 at 10:25:10AM +0800, Baolu Lu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 3/9/23 4:09 PM, Yi Liu wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> A user-managed hw_pagetable does not need to get populated, since it is
>>> managed by a guest OS. Move the iopt_table_add_domain and list_add_tail
>>> calls into a helper, where the hwpt pointer will be redirected to its
>>> hwpt->parent if it's available.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> ---
>>>    drivers/iommu/iommufd/hw_pagetable.c | 20 ++++++++++++++++++--
>>>    1 file changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
>>> index 16e92a1c150b..6e45ec0a66fa 100644
>>> --- a/drivers/iommu/iommufd/hw_pagetable.c
>>> +++ b/drivers/iommu/iommufd/hw_pagetable.c
>>> @@ -43,6 +43,23 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
>>>        return 0;
>>>    }
>>>
>>> +static int iommufd_hw_pagetable_link_ioas(struct iommufd_hw_pagetable *hwpt)
>>> +{
>>> +     int rc;
>>> +
>>> +     if (hwpt->parent)
>>> +             hwpt = hwpt->parent;
>>> +
>>> +     if (!list_empty(&hwpt->hwpt_item))
>>> +             return 0;
>>
>> What is above check for? Is it "the hwpt has already been inserted into
>> the hwpt list of its ioas in another place"?
>>
>> If so, is it possible that hwpt will be deleted from the list even when
>> this user hwpt is still linked to the ioas?
> 
> It means that the hwpt is already linked to the ioas. And the
> hwpt_item can be only empty after a destroy().
> 
> With that being said, after I think it through, perhaps Yi's
> previous change removing it might be better. So, it could be:
> 
> -------------------------------------------------------------------------------
> +	/*
> +	 * Only a parent hwpt needs to be linked to the IOAS. And a hwpt->parent
> +	 * must be linked to the IOAS already, when it's being allocated.
> +	 */
>   	if (hwpt->parent)
> -		hwpt = hwpt->parent;
> -
> -	if (!list_empty(&hwpt->hwpt_item))
>   		return 0;
>   
> -------------------------------------------------------------------------------
> 
> I was concerned about the case where a device gets attached to
> the nested hwpt without staging at the parent hwpt first. But,
> the link between the parent hwpt and the IOAS happened inside
> the allocation function now, not attach() any more.

Yes, it's clearer.

Best regards,
baolu
