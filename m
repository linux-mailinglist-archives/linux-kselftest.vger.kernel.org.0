Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D287A97FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 19:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjIUR3W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 13:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjIUR2r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 13:28:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C2653649;
        Thu, 21 Sep 2023 10:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316605; x=1726852605;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C2g69B99mcxWi9Q2D69yxsBnzZaEHHrRxUrs3EY2EDM=;
  b=L0ejLB3pv5OS8qPgBezhNlZxNQyd0vYTcs4TcTksd18yFwppNgFBsFLR
   oM16mdfyhu0nDNBBW4dfStLsXVoOks6GsQFX1JAEdlNmvDCRb3mfGbCn6
   zcNvOU14AktmfvKdX+NA2iNXFJnuAHzy6CvoQ4Fb/g8z7M4ZCa7/YG7qe
   boEax8Hai7G42yunaJEXVmuEhHiDlV7xfClAJDnIpYxFWflyP2QqoI0v9
   l6/PK6TBtllsEPVrA/BfYu06JDMYmhcqDWfxR1C5aCu6VLFNCrfxOtZ9/
   ExfvlJBe6U5bQtRlJMnZOPVNk8tXftWnFAjJ8B7IOSje3JPKiLZ8lB4gw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444606275"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="444606275"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="920706101"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="920706101"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.213]) ([10.254.213.213])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:12:06 -0700
Message-ID: <0d37a1b1-e7ef-fa73-d17c-629cd254ae75@linux.intel.com>
Date:   Thu, 21 Sep 2023 20:12:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230921075138.124099-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/21 15:51, Yi Liu wrote:
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 4a7c5c8fdbb4..3c8660fe9bb1 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -357,6 +357,14 @@ enum iommufd_hwpt_alloc_flags {
>   	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
>   };
>   
> +/**
> + * enum iommu_hwpt_type - IOMMU HWPT Type
> + * @IOMMU_HWPT_TYPE_DEFAULT: default

How about s/default/vendor agnostic/ ?

> + */
> +enum iommu_hwpt_type {
> +	IOMMU_HWPT_TYPE_DEFAULT,
> +};
> +
>   /**
>    * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
>    * @size: sizeof(struct iommu_hwpt_alloc)

Best regards,
baolu
