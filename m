Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0D46A5106
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Feb 2023 03:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjB1CTV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 21:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjB1CTU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 21:19:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386458A73;
        Mon, 27 Feb 2023 18:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677550759; x=1709086759;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A8N9428Tcr7/tfdQWiJlI1cxLImMy9WDZy/+x8nbwRk=;
  b=IskOUAHdnNjjvqmb0pqDL5CpfL12OMUv/PW1qrU3u9EuFCGAETf7VTw8
   EayFwVbagqD0qKQANXhtIIYFdIpOGvqJ0NrSq6hkpFndz1go8Fe0dtZBS
   9IqqmSikajwD2pQZF3K0VsJCtjRIRn0L/3oVdB2cbMWwE/z13EGIMox+t
   OhXjdtIuX2XTHkqJDpi/9tAWcyxCBMZwfbgcSsFMQfFirKv7K/IY5GP7v
   EfCz99vSqzaSKDPkHUhN/pyJW5n0wVEsLmCQ2a3xJMmPHJ0npXi+9vaVj
   00l9KSUo/NMwZYZ1Szsb8FHgTak1KiGkvZinzxcy1c4ZYKOOPMy2mNA5P
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="336312329"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="336312329"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 18:19:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="797889831"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="797889831"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2023 18:19:16 -0800
Message-ID: <322462b2-a3e2-31a3-d520-34fe1467b26e@linux.intel.com>
Date:   Tue, 28 Feb 2023 10:10:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <909ee61a-9cbd-eda1-89a2-349348eeb735@linux.intel.com>
 <Y/y3fnSJZB7QhAKM@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y/y3fnSJZB7QhAKM@nvidia.com>
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

On 2/27/23 10:00 PM, Jason Gunthorpe wrote:
> On Sun, Feb 26, 2023 at 11:13:16AM +0800, Baolu Lu wrote:
>> On 2/25/23 8:27 AM, Jason Gunthorpe wrote:
>>> +/**
>>> + * iommufd_device_attach - Connect a device to an iommu_domain
>>> + * @idev: device to attach
>>> + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
>>> + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
>>
>> "Output the hwpt ID" only happens when the caller input an IOAS object
>> and an auto domain was selected or created for the device.
>>
>> Do I understand it right?
> 
> Technically it always outputs the hwpt, if a hwpt is in put then the
> same hwpt is output.

 From the code point of view, the pt_id is set only when an auto domain
is selected. Otherwise, it is untouched. Hence, probably we could
describe it more accurately in the comments. That is, if auto domain is
selected, its hwpt id will be returned in pt_id and the caller could
return it to userspace.

> 
>>>    EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
>>> +/**
>>> + * iommufd_device_replace - Change the device's iommu_domain
>>> + * @idev: device to change
>>> + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
>>> + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
>>
>> If my above understanding is correct, then replace will never output a
>> hwpt id as it only happens after a successful attach.
> 
> Replace calls iommufd_device_auto_get_domain() which always sets pt_id
> on success?

Yes. replace also calls iommufd_device_auto_get_domain().

> 
> If a HWPT was passed in then it just leaves it unchanged which is also
> correct.

Functionally right. Above I just want to make the comment matches what
the real code does.

Best regards,
baolu
