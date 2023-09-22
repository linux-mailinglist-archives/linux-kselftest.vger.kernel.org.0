Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF077AAEAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjIVJsK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 05:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVJsK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 05:48:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB7F78F;
        Fri, 22 Sep 2023 02:48:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD60DDA7;
        Fri, 22 Sep 2023 02:48:40 -0700 (PDT)
Received: from [10.57.0.85] (unknown [10.57.0.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 905653F67D;
        Fri, 22 Sep 2023 02:47:57 -0700 (PDT)
Message-ID: <dcde6757-8d14-6460-c75e-c30d69219e4b@arm.com>
Date:   Fri, 22 Sep 2023 10:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <0d37a1b1-e7ef-fa73-d17c-629cd254ae75@linux.intel.com>
 <20230921164447.GQ13733@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230921164447.GQ13733@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-09-21 17:44, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 08:12:03PM +0800, Baolu Lu wrote:
>> On 2023/9/21 15:51, Yi Liu wrote:
>>> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>>> index 4a7c5c8fdbb4..3c8660fe9bb1 100644
>>> --- a/include/uapi/linux/iommufd.h
>>> +++ b/include/uapi/linux/iommufd.h
>>> @@ -357,6 +357,14 @@ enum iommufd_hwpt_alloc_flags {
>>>    	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
>>>    };
>>> +/**
>>> + * enum iommu_hwpt_type - IOMMU HWPT Type
>>> + * @IOMMU_HWPT_TYPE_DEFAULT: default
>>
>> How about s/default/vendor agnostic/ ?
> 
> Please don't use the word vendor :)
> 
> IOMMU_HWPT_TYPE_GENERIC perhaps if we don't like default

Ah yes, a default domain type, not to be confused with any default 
domain type, including the default default domain type. Just in case 
anyone had forgotten how gleefully fun this is :D

I particularly like the bit where we end up with this construct later:

	switch (hwpt_type) {
	case IOMMU_HWPT_TYPE_DEFAULT:
		/* allocate a domain */
	default:
		/* allocate a different domain */
	}

But of course neither case allocates a *default* domain, because it's 
quite obviously the wrong place to be doing that.

I could go on enjoying myself, but basically yeah, "default" can't be a 
type in itself (at best it would be a meta-type which could be 
requested, such that it resolves to some real type to actually 
allocate), so a good name should reflect what the type functionally 
*means* to the user. IIUC the important distinction is that it's an 
abstract kernel-owned pagetable for the user to indirectly control via 
the API, rather than one it owns and writes directly (and thus has to be 
in a specific agreed format).

Thanks,
Robin.
