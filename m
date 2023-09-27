Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49757AF876
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 05:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjI0DKl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 23:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjI0DIk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 23:08:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA9170D;
        Tue, 26 Sep 2023 19:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695781251; x=1727317251;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AydsJicsTjhS4lwN66GX3GcPaMOacXh1JO4dOr+xExI=;
  b=W3gDhIvHsEzweWYkj3DoIY2+dNDSyxmJjuheHxS4cPaxY+8e1fVP39fv
   KAv92EQhnspZWdqc8Kqypwu5EDgUU1q+fZAbECKrrhJ/eML10zpuvxraN
   NcBBQETnzyrXDfq7i1z5cwF49HmB335vyOForKmoqn5Za7nR8HTDkJzN3
   TMnO0I88eZU+e9tK6ymzp3Gunb65598orEFlLqtOBOtXopZjRa2HZZXIj
   XbzH52cjCrdyXf3SBdNbRRHZEQARorR1maDMvIvMQ2BBQYlOZkmpwCh5n
   niyspcWJTOOZoX3A5blyyOw3ef7FGWWNlF5e9DZ4qCtmHKvCkF1XmLWkG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381611481"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="381611481"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864616370"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="864616370"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 26 Sep 2023 19:20:45 -0700
Message-ID: <e73f3a0e-5c1b-674e-7ef1-53d963a540d3@linux.intel.com>
Date:   Wed, 27 Sep 2023 10:17:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [RFC 2/8] iommufd: replace attach_fn with a structure
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-3-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230926092651.17041-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/26/23 5:26 PM, Yi Liu wrote:
> Most of the core logic before conducting the actual device attach/
> replace operation can be shared with pasid attach/replace. Create
> a new structure so more information (e.g. pasid) can be later added
> along with the attach_fn.
> 
> Signed-off-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/device.c          | 35 ++++++++++++++++---------
>   drivers/iommu/iommufd/iommufd_private.h |  8 ++++++
>   2 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 645ab5d290fe..4fa4153c5df7 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -597,8 +597,11 @@ iommufd_device_do_replace(struct iommufd_device *idev,
>   	return ERR_PTR(rc);
>   }
>   
> -typedef struct iommufd_hw_pagetable *(*attach_fn)(
> -	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
> +static struct iommufd_hw_pagetable *do_attach(struct iommufd_device *idev,
> +		struct iommufd_hw_pagetable *hwpt, struct attach_data *data)
> +{
> +	return data->attach_fn(idev, hwpt);
> +}

I assume that this change was made because we need to pass the pasid
value to the attach_fn() callback.

If so, how about passing it directly to attach_fn() function?

typedef struct iommufd_hw_pagetable *(*attach_fn)(
		struct iommufd_device *idev,
		struct iommufd_hw_pagetable *hwpt,
		ioasid_t pasid);

In no pasid case, use IOMMU_NO_PASID.

Best regards,
baolu
