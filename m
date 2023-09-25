Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03177AD29C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 10:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjIYICP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 04:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjIYICO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 04:02:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031BBE3;
        Mon, 25 Sep 2023 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695628927; x=1727164927;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2BzDBwKAVGWZW5bjYPETPn/FpFO36BDHugTlU76Wjg0=;
  b=EESii5ZLB9D//wcnDipV2Xw7g/FPEQIEgw78h8f1O+lDd840RPZEfkhW
   kCxQnh98wZagLfFDohwhOcwYknHfhV4rrRF4Etpgo1DTlYSWJLdpBrden
   u3ffB9EY3k0HS6s7yLXYXvBnzd54i36qoFJV0Zi6JNkfD04Cj5SB76Ucs
   HKdjeiW5ucYBmKqchH1Nq3T/9vTbK8prPzXdCao2jHCXD4QBw7WARvxgx
   IVlkAaalMa0RyqzmQw3H0Gfzg1Wv+MR71tKRmteuS5mgfHMBDDPKcLnV2
   nmjZngZYb0MWdXVOfIIMq2sT/z/X7Uy/L0g2gUyQei/5OEcRjkxW6NtLo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="383956260"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="383956260"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 01:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="783388156"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="783388156"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.168.76]) ([10.249.168.76])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 01:01:58 -0700
Message-ID: <473d4050-2f2a-f9a2-6c40-3efd5b582b4e@linux.intel.com>
Date:   Mon, 25 Sep 2023 16:01:55 +0800
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
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <4b17d331-957b-44d3-8a19-0b2ccc59150b@linux.intel.com>
 <15831871-cace-f954-6af1-328039ffda16@intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <15831871-cace-f954-6af1-328039ffda16@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/25 14:22, Yi Liu wrote:
> On 2023/9/21 20:10, Baolu Lu wrote:
>> On 2023/9/21 15:51, Yi Liu wrote:
>>> +/**
>>> + * iommu_copy_user_data - Copy iommu driver specific user space data
>>> + * @dst_data: Pointer to an iommu driver specific user data that is 
>>> defined in
>>> + *            include/uapi/linux/iommufd.h
>>> + * @src_data: Pointer to a struct iommu_user_data for user space 
>>> data info
>>> + * @data_len: Length of current user data structure, i.e. 
>>> sizeof(struct _dst)
>>> + * @min_len: Initial length of user data structure for backward 
>>> compatibility.
>>> + *           This should be offsetofend using the last member in the 
>>> user data
>>> + *           struct that was initially added to 
>>> include/uapi/linux/iommufd.h
>>> + */
>>> +static inline int iommu_copy_user_data(void *dst_data,
>>> +                       const struct iommu_user_data *src_data,
>>> +                       size_t data_len, size_t min_len)
>>> +{
>>> +    if (WARN_ON(!dst_data || !src_data))
>>> +        return -EINVAL;
>>> +    if (src_data->len < min_len || data_len < src_data->len)
>>> +        return -EINVAL;
>>> +    return copy_struct_from_user(dst_data, data_len,
>>> +                     src_data->uptr, src_data->len);
>>> +}
>>
>> I am not sure that I understand the purpose of "min_len" correctly. It
>> seems like it would always be equal to data_len?
> 
> no, it will not be equal to data_len once there is extension in the
> uAPI structure.
> 
>> Or, it means the minimal data length that the iommu driver requires?
> 
> it is the minimal data length the uAPI requires. min_len is finalized
> per the upstream of the first version of the uAPI.

So, it looks like a constant. Perhaps we should document it in the
uapi/iommuf.h and avoid using it as a parameter of a helper function?

Best regards,
baolu
