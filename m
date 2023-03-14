Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7996B878D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 02:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCNBW6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 21:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCNBW5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 21:22:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02292723;
        Mon, 13 Mar 2023 18:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678756975; x=1710292975;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OUI0KAqzX6HRtQ1btpkwYcjNSuwmRYDjxtZoO3vTVow=;
  b=HIHt/Fmcd2ioAxMW+qZPGjLI2kphAlVq/GzYqopDCgiZ5aCVCDG4mPB+
   edgYuwcc9UxttsmU2q5eop07dPek746U24SSYPGGuJUkANWNE3GQiB65z
   yTPqgfIBNndRwF6ViIrnaFNajM6vboELWBCXSqtOXXSgC82dZGxmbVO52
   pQgDsyesFGCUzchKDthszLVMV45WKRjsSMbKIQ6bBK+1WpIANKLLuJAm1
   p3X1dS4Z9MmoBMvZm97CAo2nSHtqqfZx2bv12N6I++pkJ8ByP3x1ddLm2
   95PNWMdGfzDjtdCi9TQJ3IbGTYfdgGw2bjrvAMRcMbKZDwGf3ntNN7/KX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="325665989"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="325665989"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="822169385"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="822169385"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2023 18:22:49 -0700
Message-ID: <cb440b59-0d35-8e1f-f9ce-e5947261c362@linux.intel.com>
Date:   Tue, 14 Mar 2023 09:21:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 5/5] iommu/vt-d: Add nested domain support
Content-Language: en-US
To:     "Liu, Jingqi" <jingqi.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com
References: <20230309082207.612346-1-yi.l.liu@intel.com>
 <20230309082207.612346-6-yi.l.liu@intel.com>
 <bf434709-4bb3-a7bd-4b5a-9f495bd3a104@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <bf434709-4bb3-a7bd-4b5a-9f495bd3a104@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/13/23 5:11 PM, Liu, Jingqi wrote:
>> +struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
>> +					       const void *user_data)
>> +{
>> +	const struct iommu_hwpt_intel_vtd *vtd = user_data;
>> +	struct dmar_domain *domain;
>> +
> 
> Would it be better to add the following check ?
> 
> 	if (WARN_ON(!user_data))
> 		return NULL;

The iommufd has already done the sanity check. Considering that this
callback is only for iommufd purpose, the individual driver has no need
to check it.

Best regards,
baolu
