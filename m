Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9496A6571
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 03:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCACYq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Feb 2023 21:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCACYp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Feb 2023 21:24:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E99126FC;
        Tue, 28 Feb 2023 18:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677637484; x=1709173484;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OZGp5hXF6CZvm8yWSWR+ZVs80Q6jK1b91kMjRcBnI+k=;
  b=V5GBSAYAUVilAzSWLQ1meHlu3MabRtRZJujnG3eV18cg+WEcoR4oTnG5
   zvdt6lA2ojukHngWztv8SLTDyHaL4vASMylKaF0K3rcwawgKEGjX2KUtt
   zgaSbdRSPFhpNAQvQA7QPMGE3aUM3xft9+RzoF/FuUYHVdl1XLbNMMm1a
   IZkT8aeL5tgMz93mrPaApm0CIT7ApZG3bZnUPBTI4Ol2g9PmrmwaD0lhg
   BnqEUUF66AltrPjL0t2kOqNLZZDg6fuhSQbd7g+l0qSMqBnYDFQnKGesc
   RaWn6Puyhm0Xzu6yn8myaBm6STwnXu3zJEYE7v0gk2OWgdqk2g/C4JeZa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="314725773"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="314725773"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:24:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="706796735"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="706796735"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga001.jf.intel.com with ESMTP; 28 Feb 2023 18:24:41 -0800
Message-ID: <67dfd68d-7de5-08fc-35db-284731007b29@linux.intel.com>
Date:   Wed, 1 Mar 2023 10:23:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <909ee61a-9cbd-eda1-89a2-349348eeb735@linux.intel.com>
 <Y/y3fnSJZB7QhAKM@nvidia.com>
 <322462b2-a3e2-31a3-d520-34fe1467b26e@linux.intel.com>
 <Y/4HF2bc/uBydmgG@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y/4HF2bc/uBydmgG@nvidia.com>
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

On 2/28/23 9:52 PM, Jason Gunthorpe wrote:
> On Tue, Feb 28, 2023 at 10:10:41AM +0800, Baolu Lu wrote:
> 
>>> If a HWPT was passed in then it just leaves it unchanged which is also
>>> correct.
>> Functionally right. Above I just want to make the comment matches what
>> the real code does.
> It does, on output the pt_id is always the IOMMUFD_OBJ_HW_PAGETABLE ID
> of the attached HWPT.

OK. That's fine.

Best regards,
baolu
