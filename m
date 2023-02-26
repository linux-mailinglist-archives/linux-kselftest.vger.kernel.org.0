Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8EF6A2D30
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Feb 2023 04:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBZDKh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Feb 2023 22:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZDKg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Feb 2023 22:10:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94998EB72;
        Sat, 25 Feb 2023 19:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677381035; x=1708917035;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MnGgGG690MrqMdCmd1NNGfR/VC2G3XNNomAqNGjX3Ao=;
  b=NJUBZi4Dxmf4kLgDsMCWeKXRrE0urnYQA6NcQxA7rIXR1rEe8E7sP+F+
   c6lFopIm5ubqFwV++FarPoYovRcIhQtHeLGEbsnG5gd73fReavaL/0Voh
   RKooxi0LVpg2UkiIKgJfJj6FCzxhR1casE4ChBCez0a9qE4JlPRbrx9Np
   sw9+06VqzMIEQDxZZveGb8pF8Yh4JIdKd0ThXgByOHWm5/UNJcQLN+MyG
   YTBN+2Tfepww9mC/+mHjgTIZEeB/+ZgtaVTT6vIxLlVdI3/mvVQErcG/s
   k0ams6prKSPfVHuHnnnOOl+2hKOn89ii6oUi/RF9QzNvqeuyxL73Yd82D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="314104939"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="314104939"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 19:10:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="1002259676"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="1002259676"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 25 Feb 2023 19:10:33 -0800
Message-ID: <cdbc3707-d326-26d4-3adc-ff2ed80aa2ba@linux.intel.com>
Date:   Sun, 26 Feb 2023 11:01:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
References: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
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

On 2/25/23 8:27 AM, Jason Gunthorpe wrote:
> @@ -437,25 +517,77 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
>   		struct iommufd_ioas *ioas =
>   			container_of(pt_obj, struct iommufd_ioas, obj);
>   
> -		rc = iommufd_device_auto_get_domain(idev, ioas, pt_id);
> -		if (rc)
> +		destroy_hwpt = iommufd_device_auto_get_domain(idev, ioas, pt_id,
> +							      do_attach);
> +		if (IS_ERR(destroy_hwpt))
>   			goto out_put_pt_obj;
>   		break;
>   	}
>   	default:
> -		rc = -EINVAL;
> +		destroy_hwpt = ERR_PTR(-EINVAL);
>   		goto out_put_pt_obj;
>   	}
> +	iommufd_put_object(pt_obj);
>   
> -	refcount_inc(&idev->obj.users);
> -	rc = 0;
> +	/* This destruction has to be after we unlock everything */
> +	if (destroy_hwpt)

Should this be

	if (!IS_ERR_OR_NULL(destroy_hwpt))

?

> +		iommufd_hw_pagetable_put(idev->ictx, destroy_hwpt);
> +	return 0;
>   
>   out_put_pt_obj:
>   	iommufd_put_object(pt_obj);
> -	return rc;
> +	return PTR_ERR(destroy_hwpt);
> +}

Best regards,
baolu
