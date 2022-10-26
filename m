Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA14B60E11D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 14:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiJZMpc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 08:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiJZMpa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 08:45:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374508BB8A;
        Wed, 26 Oct 2022 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666788329; x=1698324329;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ABNx+msEoxiE0Up/NA4YUsZE1sxvOirm9dovIGgVQBY=;
  b=eH7reX7OgdEIT5Us9JYkZEdF4sVa4hzCT/kGcwmvGEpz8F9+x0h+5/jj
   bB4YWbEJ87gOTVQDueRtYOjzOxcRKCGd99ATT0H3U9UPi5Hz2fUE6LJO9
   uMdVxscTqtkmpzRXafPvWKoiEZQcKw43VtLYQhH8VXa3R18Xi+n9kn7Dz
   0sO5p7IJndkH8WjkJPNBAYz/60ZBMjVokhpzOfR6Xbw2ZdB1dkWCd+Xjg
   i+Z515Zz56T/bfDxjmsmq+ayuynOxkg3Jy0tUw0AHpNBSOyEvxavh86+K
   taypGzJzpP7yQMWzONHvVNInx+ZYGvzHKUso5+K82aLoHP+14/3EwOftd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="334552548"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="334552548"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 05:45:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="609938092"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="609938092"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.188]) ([10.254.213.188])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 05:45:17 -0700
Message-ID: <2bcba1f1-e142-a752-eae5-69249f5a1021@linux.intel.com>
Date:   Wed, 26 Oct 2022 20:45:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Cc:     baolu.lu@linux.intel.com,
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
Subject: Re: [PATCH v3 01/15] iommu: Add IOMMU_CAP_ENFORCE_CACHE_COHERENCY
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, bpf@vger.kernel.org,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
References: <1-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/10/26 2:12, Jason Gunthorpe wrote:
> This queries if a domain linked to a device should expect to support
> enforce_cache_coherency() so iommufd can negotiate the rules for when a
> domain should be shared or not.
> 
> For iommufd a device that declares IOMMU_CAP_ENFORCE_CACHE_COHERENCY will
> not be attached to a domain that does not support it.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
