Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133FD7AF977
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 06:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjI0Eet (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 00:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjI0Edt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 00:33:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC056AD06;
        Tue, 26 Sep 2023 19:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695783169; x=1727319169;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QK5sue7sVnpxLM6QQCdPLLJ+pS+Be6ivtxWAV2EGffI=;
  b=hL+tNoDsgV6wVCGRGOfakjAEbSf53oF0fPcLAfQPgMRB9PM1cKhMVmsc
   AeWAqZwRtsKRJ0OI3XHVLCz9j4gfiPOZacsCqfj03zt0N3shCh19ZTirg
   W9WORABQT+safWeEPs7L5K41aG3+Nxhoz0f8yId1u9iWBuFZbdJomtO43
   DZR2OWu5nOXDUsTaLtyndh+gYhbf0S7THXTeErU2NtbMrGElCqL9bk3Q7
   d+mSGGYLupKygAsKIlE9WjpPr4hw3quEAjsV6bHdf5haLadU8/GPOHYsQ
   TsbI1XGHwVpPCrDuIfmupFpz61v6x2/wyfpkvH3kWf3SFSPqGfeVqaM7V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366776768"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366776768"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:52:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1079958724"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="1079958724"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2023 19:52:43 -0700
Message-ID: <cd258ee3-52ca-f944-7553-6a1cd01c5f7a@linux.intel.com>
Date:   Wed, 27 Sep 2023 10:49:29 +0800
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
Subject: Re: [RFC 3/8] iommufd: Support attach/replace hwpt per pasid
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-4-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230926092651.17041-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/26/23 5:26 PM, Yi Liu wrote:
> From: Kevin Tian<kevin.tian@intel.com>
> 
> This introduces three APIs for device drivers to manage pasid attach/
> replace/detach.
> 
>      int iommufd_device_pasid_attach(struct iommufd_device *idev,
> 				    u32 pasid, u32 *pt_id);
>      int iommufd_device_pasid_replace(struct iommufd_device *idev,
> 				     u32 pasid, u32 *pt_id);
>      void iommufd_device_pasid_detach(struct iommufd_device *idev,
> 				     u32 pasid);

I am a bit puzzled. Do we really need both attach and replace interfaces
to install a hwpt onto a pasid on device? The IOMMUFD already tracks the
connections between hwpt and {device, pasid}, so it could easily call
the right iommu interfaces (attach vs. replace). Perhaps I overlooked
previous discussion on this.

Best regards,
baolu
