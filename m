Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2370443A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 06:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjEPEHo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 00:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEPEHn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 00:07:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C7E2;
        Mon, 15 May 2023 21:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684210062; x=1715746062;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YziHanXZZgtVTeTDOEw80tR1iSfnjM4PSBzGx7IvwG8=;
  b=IAa/7aDjwKKijbiMrzYOZj7EDgG1v2IVbs4kYdvSGrDQhU6t+dcv2Seb
   PuJstTZJK/DAajNG2BjQc/hGOLgQE2X94pHvw4gOzBdXjTPZ7jH2EFsSu
   QN9x8NQLkTb4rcUvwafrLTjXn5ITm8UtawMaBvAKdIYF8geOF/UQqdLpH
   WYeBETcPEw+rJwPJjIqbydE0DSWQ1EqHicMt0VeG6CF5YeNmDano+9yJh
   5Qy8sGcp5jqe9XS4sU2W88vK14tcqF9MO/G2ExZtW7hp90ifjWZ66xxsT
   av/0sONBpO+jIzwV6XzGPSZPjUG2yDkNdlqsy7K58mVz/aAmL6UwqCD3A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="350210793"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="350210793"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 21:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="704237247"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="704237247"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga007.fm.intel.com with ESMTP; 15 May 2023 21:07:39 -0700
Message-ID: <2944e798-1599-df10-398f-1afa6e983bf2@linux.intel.com>
Date:   Tue, 16 May 2023 12:07:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        kvm@vger.kernel.org, Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 01/19] iommufd: Move isolated msi enforcement to
 iommufd_device_bind()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org
References: <1-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
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
> With the recent rework this no longer needs to be done at domain
> attachment time, we know if the device is usable by iommufd when we bind
> it.
> 
> The value of msi_device_has_isolated_msi() is not allowed to change while
> a driver is bound.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
