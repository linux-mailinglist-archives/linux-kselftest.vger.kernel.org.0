Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C34B693FB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 09:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBMIfA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 03:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjBMIeu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 03:34:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AFDA25D;
        Mon, 13 Feb 2023 00:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676277289; x=1707813289;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cwbWY0MYycEcAmZ1WT+ohW6HXdmMTj+4gVFJ3q+KyUo=;
  b=kTY8dzc1UBlCNRZJEF4uYVXS8DWsZwzOlmiBHYPSwnqn8hX4WZKtDioW
   9je0n1wYk7QBk+1RZ6P3xd6zM7MUYUbtcHOcekXHv/Fi8aU0rGP9TwkvL
   NZIK1vNpqnRFpNBsvSCt4hIX5JpZmDZgVjiQFRp+cLuHLQd8wa5lvJjF8
   zOcCEn1SmpwaBsPwSMMBPd7CMvz9amPG0K/PWGEJczl7iFw+RD96wz2QR
   +cpsX+zfLU6wzBTyu8dRlRjvs2bp/WqshcDH3AHw5nyuWLclQTFgUOvHi
   H2jg8E3pSVXWm7EXzUQD40SECAD4HWqPv3XhY7cI/hDjR8oVvECRBH6Wy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="329468498"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="329468498"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 00:34:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="701185884"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="701185884"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.169.207]) ([10.249.169.207])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 00:34:34 -0800
Message-ID: <ff0b2a68-8aeb-426b-0fb4-010c5e7b20b8@linux.intel.com>
Date:   Mon, 13 Feb 2023 16:34:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     baolu.lu@linux.intel.com, Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 02/10] iommu: Introduce a new
 iommu_group_replace_domain() API
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <fa81379dca611c1d9f50f9d8cd2bca0d4ec7f965.1675802050.git.nicolinc@nvidia.com>
 <20230210165110.4e89ce55.alex.williamson@redhat.com>
 <Y+bk+GSCPKOJfr1f@nvidia.com>
 <BL1PR11MB527176BE1F6DFA3D2942664D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB527176BE1F6DFA3D2942664D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/2/13 10:24, Tian, Kevin wrote:
>> From: Jason Gunthorpe<jgg@nvidia.com>
>> Sent: Saturday, February 11, 2023 8:45 AM
>>
>> On Fri, Feb 10, 2023 at 04:51:10PM -0700, Alex Williamson wrote:
>>> On Tue, 7 Feb 2023 13:17:54 -0800
>>> Nicolin Chen<nicolinc@nvidia.com>  wrote:
>>>
>>>> qemu has a need to replace the translations associated with a domain
>>>> when the guest does large-scale operations like switching between an
>>>> IDENTITY domain and, say, dma-iommu.c.
>>>>
>>>> Currently, it does this by replacing all the mappings in a single
>>>> domain, but this is very inefficient and means that domains have to be
>>>> per-device rather than per-translation.
>>>>
>>>> Provide a high-level API to allow replacements of one domain with
>>>> another. This is similar to a detach/attach cycle except it doesn't
>>>> force the group to go to the blocking domain in-between.
>>>>
>>>> By removing this forced blocking domain the iommu driver has the
>>>> opportunity to implement an atomic replacement of the domains to the
>>>> greatest extent its hardware allows.
>>>>
>>>> It could be possible to adderss this by simply removing the protection
>>>> from the iommu_attach_group(), but it is not so clear if that is safe
>>>> for the few users. Thus, add a new API to serve this new purpose.
>>>>
>>>> Atomic replacement allows the qemu emulation of the viommu to be
>> more
>>>> complete, as real hardware has this ability.
>>> I was under the impression that we could not atomically switch a
>>> device's domain relative to in-flight DMA.
> it's possible as long as the mappings for in-flight DMA don't change
> in the transition.
> 

It also requires the mappings in old and new domains are identical. In
another word, any IOVA should be translated to a same result no matter
through the old domain, the new domain, or hardware caches.

A similar replacement has been implemented in the code. For example,
the Intel IOMMU driver dynamically transforms a large range (2M or 1G)
mapping from discrete 4k pages to a super pages to improve the paging
cache efficiency.

Best regards,
baolu
