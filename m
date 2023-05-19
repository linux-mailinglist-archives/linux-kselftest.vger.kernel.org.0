Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E27708D9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 04:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjESCEP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 22:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjESCEO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 22:04:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166B1192;
        Thu, 18 May 2023 19:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684461853; x=1715997853;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bigg4gk47lNFdVx20xWM4FyRwF5SyiVXdpidC4nBQUs=;
  b=eEbhIjgznOLYznoFm/eG99PcMQipNbW9ibqhp4iFz31Xs1KvrQi2iiZC
   d7RlNefv91Ccv6hArQFf9stw1shpbCVAJSynjXvZdKslfzS+wwPffvHbr
   U0DRxy2eZEbIHVffdUV/ZnHMZtaZSwsnQ1q8aOX6X35ALog6s6jvJ5TUB
   PEMzKBMuO09q50Cnt2KBaYfeG5yUkkFI0lJTTb/jEnIIa9hrQHfmqKi5W
   6farGXKFBXth1Hm9NWGerFFMPQaXucppsWhCiPpI+BsWjK2XIlqbYsuWq
   rYaFBM6mzGtr786gBXnH2ZEX10cQjpM72w11xeHEyiiiuPkbbiX30ECB9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="351093602"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="351093602"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 19:04:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876673929"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="876673929"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.160]) ([10.254.210.160])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 19:03:59 -0700
Message-ID: <d99e284d-31b1-6d04-cf14-d7b160ee3f44@linux.intel.com>
Date:   Fri, 19 May 2023 10:03:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with
 iommufd_group
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <3-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <569b959e-a702-fc19-3d67-0dde4e77251a@linux.intel.com>
 <ZGN2yvhpIvrvu74r@nvidia.com>
 <852e85b3-9fd2-bfc2-6080-82cea7ab6abd@linux.intel.com>
 <BN9PR11MB5276DE1BC30E90B1032C0E468C7E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGTMCSJKvgpyYxG/@nvidia.com>
 <5cdc1a83-f29b-6862-d513-dbfd5c500807@linux.intel.com>
 <ZGYT8RmGM+vwNzDa@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZGYT8RmGM+vwNzDa@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/5/18 20:02, Jason Gunthorpe wrote:
> On Thu, May 18, 2023 at 03:05:23PM +0800, Baolu Lu wrote:
> 
>>> It doesn't make any sense to store a struct like that in dev_iommu.
>>>
>>> The fault handler should come from the domain and we should be able to
>>> have a unique 'void *data' cookie linked to the (dev,PASID) to go
>>> along with the fault handler.
>>
>> If I get your point correctly, the iommu core should provide some places
>> for the iommufd to put a cookie for each pair of {device, pasid}, and
>> provide interfaces to manage it. For example,
> 
> I'd say when you attach a PRI capable domain (eg to a PASID) then provide
> a 'void * data' during the attach.
> 
>> If so, perhaps we need some special treatment for ARM as a user hwpt
>> actually presents the PASID table of the device and the guest setting
>> pasid table entry will not be propagated to host. Then, the @pasid in
>> above interfaces is meaningless.
> 
> As above, when attaching to a RID you'd still pass in the *data

Yes! Merging these with hwpt attach/detach would be more logical.

> 
>> 1) Move iommu faults uapi from uapi/linux/iommu.h to uapi/linux
>>    /iommufd.h and remove the former.
> 
> Please no, delete all the dead code from here and move whatever is
> still in use into include/linux/
> 
> Then we can talk about what parts of it become uAPI and how best to
> manage that on a patch by patch basis.

Okay, let's rebuild it from the ground up.

> 
>> 2) Add a device id in the iommu_fault structure.
>>   struct iommu_fault {
>>          __u32   type;
>> -       __u32   padding;
>> +       __u32   dev_id;
> 
> Why? This is iommufd internal, the void * above should cover it.

This is actually part of 1). :-)

> 
>> 3) Add the device pointer to the parameters of domain fault handler.
> 
> That makes some sense
>   
>> 4) Decouple I/O page fault handling from IOMMU_SVA in the iommu core and
>>     the drivers.
> 
> Definately, this SVA stuff need to be scrubbed out.
> 
> SVA is only a special domain type that takes the page table top from a
> mmu_stuct and a shared fault handler in the core code to do handle_mm_fault()
> 
> It should not be in drivers any more deeply than that. We still have a
> ways to go.

Agreed. In addition to fault handler, SVA usually needs to register a
callback to mm_notifier to keep the IO or device TLB cache consistent.
This part of code could also be consolidated to the core.

There are still things to do here, but the priority (from my point of
view) is to make the iopf handling framework in the iommu core more
generic, rather than just serving SVA.

Best regards,
baolu
