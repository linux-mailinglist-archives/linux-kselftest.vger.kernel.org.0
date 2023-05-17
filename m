Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A5705EA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 06:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjEQESq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 00:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEQESo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 00:18:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0272AF;
        Tue, 16 May 2023 21:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684297123; x=1715833123;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z+IBYZPTmNxHKioV7v293uNDBXJfN2UVtwCR9Fj+giM=;
  b=FS/FHcBUgbkYMXaFxUSXzrjj5BtldnCdMLvDI4XuwvGSd7M1m9soui2N
   LygqRfD506QeNerxjlGV9b96WBaV22ZGFfwcxAn1TYFG2arGGoemmH3Hb
   O/MkhrDZK2bB8jyrn823fBmA1JjGks34/6Rm/2QMHkGK/HJvoNo/e/PrD
   p63pQPmCdUPGeJqR4vY0x9fmxA48swo7MrOd7B/4XD8V2p5Q8jy6aXnH5
   o8IN3eQluOAEYeaYwvx8/qx/a32zdU2B+RtOypAh7UR8pk48C87vKfG81
   BjIy4/CJRQk17viGkHp2SH963IbvmynCLmpHHTpfLWYhX8BCm+AHKJz+A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="336213065"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="336213065"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 21:18:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="701598550"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="701598550"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 16 May 2023 21:18:40 -0700
Message-ID: <da44d7b8-aa7e-acfa-beb4-c2e524ed8562@linux.intel.com>
Date:   Wed, 17 May 2023 12:18:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        kvm@vger.kernel.org, Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 02/19] iommufd: Add iommufd_group
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <2-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <89d800bf-87cf-6a7d-85b3-74bd457b1454@linux.intel.com>
 <ZGN8/K2qg4zsaeYQ@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZGN8/K2qg4zsaeYQ@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/16/23 8:54 PM, Jason Gunthorpe wrote:
> On Tue, May 16, 2023 at 10:43:23AM +0800, Baolu Lu wrote:
>> On 5/15/23 10:00 PM, Jason Gunthorpe wrote:
>>>    void iommufd_device_destroy(struct iommufd_object *obj)
>>>    {
>>>    	struct iommufd_device *idev =
>>>    		container_of(obj, struct iommufd_device, obj);
>>>    	iommu_device_release_dma_owner(idev->dev);
>>> -	iommu_group_put(idev->group);
>>> +	iommufd_put_group(idev->igroup);
>>>    	if (!iommufd_selftest_is_mock_dev(idev->dev))
>>>    		iommufd_ctx_put(idev->ictx);
>>>    }
>>> @@ -46,7 +154,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>>>    					   struct device *dev, u32 *id)
>>>    {
>>>    	struct iommufd_device *idev;
>>> -	struct iommu_group *group;
>>> +	struct iommufd_group *igroup;
>>>    	int rc;
>>>    	/*
>>> @@ -56,9 +164,9 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>>>    	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
>>>    		return ERR_PTR(-EINVAL);
>>> -	group = iommu_group_get(dev);
>>> -	if (!group)
>>> -		return ERR_PTR(-ENODEV);
>>> +	igroup = iommufd_get_group(ictx, dev);
>>> +	if (IS_ERR(igroup))
>>> +		return ERR_CAST(igroup);
>>>    	/*
>>>    	 * For historical compat with VFIO the insecure interrupt path is
>> Hi Jason,
>>
>> Perhaps I am asking a silly question. The iommufd_group is get in
>> iommufd_device_bind(), but put in iommufd_device_destroy(). Why not put
>> it in iommufd_device_unbind()?
> It basically is like that, iommufd_device_destroy() is a helper that
> is only called by iommufd_device_unbind() through the usual
> destruction mechanism.

Oh, yes. Thank you for the explanation.

Best regards,
baolu
