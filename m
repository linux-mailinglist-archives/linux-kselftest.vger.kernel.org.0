Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36F5704388
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 04:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjEPCoK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 22:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjEPCoD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 22:44:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086965BB4;
        Mon, 15 May 2023 19:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684205042; x=1715741042;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PQC9n1gXUZAOwEzChv+hdaQZHcZ4tJdAn2yzVm4wFag=;
  b=I/zKEefwXyOlCEYKfa7By2R0EP6OoEBOS9YctGYh/LdL3kIY71LcV1WQ
   YaAYJJXkCUf32AN9FmI/CCrYN/4x9V+9dSR6i3FjRQsLRI01Dj+WflzHB
   cXlbzZyWbeM24OqbFG6yGj1uZYWNuLPRZQZH2RGA2kArcZjgKTAgIO3jR
   BR49EnuUdJvUWAVshp+YmkyeINPMaCvQWi2smSvilTlILzHsihZ/nYOx9
   WGxsuxV2aIfcIZ0Z7DITsofPawM+AUnbltFXxf96ZHNWWVpTmn6dn4uXg
   i9sRLl6eNLCHUt6p4Su8OPq2ADlTk2MNjQ4LnNL2jCOFhTbBRTEnmQgyf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="437704663"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="437704663"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 19:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="770856241"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="770856241"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 15 May 2023 19:43:59 -0700
Message-ID: <89d800bf-87cf-6a7d-85b3-74bd457b1454@linux.intel.com>
Date:   Tue, 16 May 2023 10:43:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        kvm@vger.kernel.org, Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 02/19] iommufd: Add iommufd_group
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org
References: <2-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/15/23 10:00 PM, Jason Gunthorpe wrote:
>   void iommufd_device_destroy(struct iommufd_object *obj)
>   {
>   	struct iommufd_device *idev =
>   		container_of(obj, struct iommufd_device, obj);
>   
>   	iommu_device_release_dma_owner(idev->dev);
> -	iommu_group_put(idev->group);
> +	iommufd_put_group(idev->igroup);
>   	if (!iommufd_selftest_is_mock_dev(idev->dev))
>   		iommufd_ctx_put(idev->ictx);
>   }
> @@ -46,7 +154,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>   					   struct device *dev, u32 *id)
>   {
>   	struct iommufd_device *idev;
> -	struct iommu_group *group;
> +	struct iommufd_group *igroup;
>   	int rc;
>   
>   	/*
> @@ -56,9 +164,9 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>   	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
>   		return ERR_PTR(-EINVAL);
>   
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return ERR_PTR(-ENODEV);
> +	igroup = iommufd_get_group(ictx, dev);
> +	if (IS_ERR(igroup))
> +		return ERR_CAST(igroup);
>   
>   	/*
>   	 * For historical compat with VFIO the insecure interrupt path is

Hi Jason,

Perhaps I am asking a silly question. The iommufd_group is get in
iommufd_device_bind(), but put in iommufd_device_destroy(). Why not put
it in iommufd_device_unbind()?

Best regards,
baolu
