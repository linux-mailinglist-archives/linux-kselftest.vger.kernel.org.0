Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9427A9E05
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 21:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjIUTxn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 15:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjIUTxc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 15:53:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED1990F15;
        Thu, 21 Sep 2023 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318444; x=1726854444;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HY1sm+rBkYtBd+6vBns4g32g88NP2b9P0RK55lZf5eM=;
  b=O1+KVf7KYfaUo7bnrEkA2Jd4GC9XnoNkIlyscEjdiTfXzrLbYjTkod/X
   zDqEgegT8ZL/YkrzJQh+CyqnmUOqKkFFSHIOASsIURIB/MJqOl2AEpf3b
   gQqK0V6v7uyX4Ka4UgiBkgn6IShskrDBkDDipim97gTBi2hLT4ldxg21N
   LGiMgNKcGE5vOZMn98vMih6CCs1pzZznu/gjYu4QWFVqP8QR/uEXVkPMr
   N5WscN1JzcgtE3jndOGl/+yMOD7/4I8fisngE6gTKjvuky6eFaH9ukUH+
   ijF8NW/BEMLiP8n+2yrr/kXGF9HX6zuU+WnWYDWF+1xhQ3p2DOlaq/OaG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="377792033"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="377792033"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="747070867"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="747070867"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.213]) ([10.254.213.213])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:11:01 -0700
Message-ID: <4b17d331-957b-44d3-8a19-0b2ccc59150b@linux.intel.com>
Date:   Thu, 21 Sep 2023 20:10:58 +0800
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
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/21 15:51, Yi Liu wrote:
> +/**
> + * iommu_copy_user_data - Copy iommu driver specific user space data
> + * @dst_data: Pointer to an iommu driver specific user data that is defined in
> + *            include/uapi/linux/iommufd.h
> + * @src_data: Pointer to a struct iommu_user_data for user space data info
> + * @data_len: Length of current user data structure, i.e. sizeof(struct _dst)
> + * @min_len: Initial length of user data structure for backward compatibility.
> + *           This should be offsetofend using the last member in the user data
> + *           struct that was initially added to include/uapi/linux/iommufd.h
> + */
> +static inline int iommu_copy_user_data(void *dst_data,
> +				       const struct iommu_user_data *src_data,
> +				       size_t data_len, size_t min_len)
> +{
> +	if (WARN_ON(!dst_data || !src_data))
> +		return -EINVAL;
> +	if (src_data->len < min_len || data_len < src_data->len)
> +		return -EINVAL;
> +	return copy_struct_from_user(dst_data, data_len,
> +				     src_data->uptr, src_data->len);
> +}

I am not sure that I understand the purpose of "min_len" correctly. It
seems like it would always be equal to data_len?

Or, it means the minimal data length that the iommu driver requires?

Best regards,
baolu
