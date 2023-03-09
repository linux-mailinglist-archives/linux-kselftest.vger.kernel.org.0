Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED1F6B2638
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 15:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCIOGD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 09:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjCIOFn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 09:05:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB67720A12;
        Thu,  9 Mar 2023 06:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678370583; x=1709906583;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tbBO1XF9px/UsbckwD/VzZzCEHWREMG7gRd+33hcda8=;
  b=jwyBg9ysCy13eWR+1yTCMB7tkhrZyeOt0r0koUYsUp8ABjGZ9SY7Pf6m
   +NxGLQ2r9fNtRdpQE7xysNlyqZvlSo1QU4b9ghTvqs1d2tiVIcB78fzRm
   hOvqr8NaGKQMaxy7ZTBNJ34dmZx11rd1AFBoClhyXaLmxfDEuBf2BUfY0
   LagXgCYozXc+LdKkAeYLAlJwRl2kFqhVxxVScf6d+pshi0DF6MC2B7yDF
   sFJKDM6gd9/gmj6BoZcU2SJNGGWoHaKHAdvrdCUHam+AvfSMxQJEY6FCc
   AxTnuWP8mul2q/RNdrV61ERYTF8E1Hz5hYHXCk5qtJqDX5c7LQ7k8sWTN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="422718824"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="422718824"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:02:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="707619130"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="707619130"
Received: from xueyingl-mobl.ccr.corp.intel.com (HELO [10.249.171.149]) ([10.249.171.149])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 06:02:25 -0800
Message-ID: <0193b5e3-68b5-16e8-b4e8-7fc5a3175a25@linux.intel.com>
Date:   Thu, 9 Mar 2023 22:02:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/12] iommufd: Add nesting infrastructure
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230309080910.607396-1-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230309080910.607396-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/3/9 16:08, Yi Liu wrote:
> Nested translation is a hardware feature that is supported by many modern
> IOMMU hardwares. It has two stages (stage-1, stage-2) address translation
> to get access to the physical address. stage-1 translation table is owned
> by userspace (e.g. by a guest OS), while stage-2 is owned by kernel. Changes
> to stage-1 translation table should be followed by an IOTLB invalidation.

The last sentence is not always true. If any entry of the stage-1
translation table is changed from non-present to present, the IOTLB has
no chance to cache it yet. Hence there's no need for invalidation.

Best regards,
baolu
