Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAABE6BF900
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Mar 2023 09:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCRIey (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Mar 2023 04:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCRIex (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Mar 2023 04:34:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8408090B;
        Sat, 18 Mar 2023 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679128490; x=1710664490;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cF6OACTGETpdCpNE9ogXPkHWW2QM4YLy7vWuh9G3Jv0=;
  b=R+nAQOk2jLT9gccjhN7yg2x7iD5z50sKuBS5sK46DlWwuGKjuB9RGXS2
   eioh5QPnzDar1D/DbiBt6u7yCF8yqC0EUwTbsrlG6nZtgN9B5ZLsrBwJr
   gar0CYLuB2sCNjovo7vj7UfCoOrQx9MjKz4qfhTFstbRdQ0xhrOoPvPn1
   m4NZnApY0FbnCMOu7sYrEMh17NP5qnfDRUaFHew084+Zb5RE2tQgMYokF
   Mjm1cwKafsXYkTFECBZv0GoNn5GRDpCLbCqICITuSgasBonhNXoxRtQmm
   bGorkQ4IL+sFMCc9TxAxgk+It4RmekbVXWPiwJLzbDkyKRY8RLNAMGtfG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="424693792"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="424693792"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 01:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="769637754"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="769637754"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.252]) ([10.254.210.252])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 01:34:45 -0700
Message-ID: <89ae04a9-bba3-c93e-c8ec-92e8afaf6316@linux.intel.com>
Date:   Sat, 18 Mar 2023 16:34:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 02/12] iommu: Add nested domain support
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-3-yi.l.liu@intel.com>
 <BN9PR11MB5276265987486AC84D2039818CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276265987486AC84D2039818CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/3/17 18:25, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, March 9, 2023 4:09 PM
>>
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> Introduce a new domain type for a user space I/O address, which is nested
> 
> 'a ... address'? let's call it 'user I/O page table'.
> 

Okay, sure.

Best regards,
baolu
