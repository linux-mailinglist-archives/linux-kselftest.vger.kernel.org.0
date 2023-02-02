Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE76687A08
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 11:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjBBKV1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 05:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjBBKV0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 05:21:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F11199C0;
        Thu,  2 Feb 2023 02:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675333286; x=1706869286;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I3BObQyIUsuS842dSFNMbhIiOWbS9ICN9kPUAQN0188=;
  b=Va5q1OF+YMnzitdPjOTwSx+C2/VtboYZ4Y5uyrxazS2ej7D2biET3KOd
   7fauEJTX7coE8SouHc5gSsPO86trDieUk8mbOVzWG2U7h1jHsUN+dzVYY
   ap+hSIEUV7Bl7vH7wZyO7fnwRctZYDF1udsXI3LKyY5hqHmsOA8dbdqPv
   v5Q34hE42E8ec+aiPO+wdK/vpVmGHamNbeYptZHBQM48N4wVmnwW3krlO
   6Sv5VxLqk+M3U7NMPfWqRba8wariVdq6M+YvrY7EtvHiCDhwUlhalOlNU
   HNH1lDEe5NMD4ZJ07TAXbE0JSH8/smqaQF4kiNNEU9jRP6vsJQ9fr084f
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="327061548"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="327061548"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 02:21:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="728809060"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="728809060"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.29.248]) ([10.255.29.248])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 02:21:22 -0800
Message-ID: <d5147b2f-4698-b39f-e956-84db122e9822@linux.intel.com>
Date:   Thu, 2 Feb 2023 18:21:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, yi.l.liu@intel.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
        kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, alex.williamson@redhat.com, shuah@kernel.org
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
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

On 2023/2/2 15:05, Nicolin Chen wrote:
> +/**
> + * iommu_group_replace_domain - replace the domain that a group is attached to
> + * @new_domain: new IOMMU domain to replace with
> + * @group: IOMMU group that will be attached to the new domain
> + *
> + * This API allows the group to switch domains without being forced to go to
> + * the blocking domain in-between.
> + *
> + * If the attached domain is a core domain (e.g. a default_domain), it will act
> + * just like the iommu_attach_group().

I am not following above two lines. Why and how could iommufd set a
core domain to an iommu_group?

> + */
> +int iommu_group_replace_domain(struct iommu_group *group,
> +			       struct iommu_domain *new_domain)
> +{
> +	int ret;
> +
> +	if (!new_domain)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +	ret = __iommu_group_set_domain(group, new_domain);
> +	if (ret) {
> +		if (__iommu_group_set_domain(group, group->domain))
> +			__iommu_group_set_core_domain(group);
> +	}
> +	mutex_unlock(&group->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommu_group_replace_domain, IOMMUFD_INTERNAL);

Best regards,
baolu
