Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FAC611FD5
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Oct 2022 05:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJ2Dng (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 23:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJ2Dnf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 23:43:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A61C8D7C;
        Fri, 28 Oct 2022 20:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667015014; x=1698551014;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lwhcsqVAPcB+BRLzzkySku/43hUGK299jANuukpJQiU=;
  b=DU5uUi+sMPvwvQvrMrsKVZ7QYkhHdRbqX3edVEUBiX13HbqjrMb5Zjeo
   PHEstuGA4JyAm3XM8ER+4XJKw8Q2ON8Q3DT9eWSAfZDIKjjA3W9x5gT9z
   yZCeUG/39seUm49yg0mno4PoeehngrAK3ynElWQ/cNvFtXTAKHLrh3Eu4
   44prwvaoYNMnf8Yo2jk5BU14jvVq4Is03d5ax0FVyyZMo38hlze/oI2o1
   7hf6fyHD/vBT6+6AkrixetzF6jYZGazQ4MSxq8mh5H1+/aT+7y9DsWlyR
   7FDqZv9FtaYggSrj1xpsRo/RArb6CAU77zibHcxobyCJQ4LV1UpGOJEVk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="309723947"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="309723947"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 20:43:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="635522260"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="635522260"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.211]) ([10.254.215.211])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 20:43:25 -0700
Message-ID: <8b165b88-eea1-c891-2754-33209a2711bf@linux.intel.com>
Date:   Sat, 29 Oct 2022 11:43:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Cc:     baolu.lu@linux.intel.com, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 05/15] iommufd: File descriptor, context, kconfig and
 makefiles
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <5-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <9a837538-6333-0973-c6f4-229064026330@linux.intel.com>
 <Y1lq2JJt1yLrzNjs@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y1lq2JJt1yLrzNjs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/10/27 1:14, Jason Gunthorpe wrote:
> On Wed, Oct 26, 2022 at 08:58:23PM +0800, Baolu Lu wrote:
>>> +	[_IOC_NR(_ioctl) - IOMMUFD_CMD_BASE] = {                               \
>>> +		.size = sizeof(_struct) +                                      \
>>> +			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
>>> +					  sizeof(_struct)),                    \
>>> +		.min_size = offsetofend(_struct, _last),                       \
>>> +		.ioctl_num = _ioctl,                                           \
>>> +		.execute = _fn,                                                \
>>> +	}
>>> +static struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>>
>> How about making the ops "static const"?
> 
> Yes both const's were missed
> 
>>> +static void __exit iommufd_exit(void)
>>> +{
>>> +	misc_deregister(&iommu_misc_dev);
>>> +}
>>> +
>>> +module_init(iommufd_init);
>>> +module_exit(iommufd_exit);
>>> +
>>> +MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
>>> +MODULE_LICENSE("GPL");
>>
>> Could above be "GPL v2"?
> 
> It should be just "GPL", see Documentation/process/license-rules.rst:
> 
>      "GPL v2"                      Same as "GPL". It exists for historic

Ah! Thanks for letting me know this.

> 
>>> --- /dev/null
>>> +++ b/include/uapi/linux/iommufd.h
>>> @@ -0,0 +1,55 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>> +/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES.
>>> + */
>>> +#ifndef _UAPI_IOMMUFD_H
>>> +#define _UAPI_IOMMUFD_H
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/ioctl.h>
>>> +
>>> +#define IOMMUFD_TYPE (';')
>>> +
>>> +/**
>>> + * DOC: General ioctl format
>>> + *
>>> + * The ioctl mechanims follows a general format to allow for extensibility. Each
>>                  ^^^^^^^^^ mechanism?
> 
> How about "interface" ?

Yes. It works.

With above addressed,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
