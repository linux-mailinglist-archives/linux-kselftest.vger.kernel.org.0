Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9713D6120F1
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Oct 2022 09:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ2HTx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Oct 2022 03:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJ2HTw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Oct 2022 03:19:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADAA2648D;
        Sat, 29 Oct 2022 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667027986; x=1698563986;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FhmH3plE0BSGDSUDNHfqp0mdEEM+/mvoaPeadfpkBxc=;
  b=MyWMXcREeIB3slWphO3CUX7aSykcpLIHbUf5pgNQ2d1XsHUHWbM6NiS9
   vnrrQi1bq0kH3Xn4VJYW08TcTaeO7of0SnCL4evrLlxe6qqVeTD0KMqPm
   bE0VY3EYDRUMvyn9XkXLOe8kmMmze3GKh/2wze3/Xf0q10bnTB+hfuFrt
   l8dbPQtP8H+RwvMz6xbsV8KvE2N3vrjpSayyrKE8dpS2WSzsNLoUXJj9X
   R7f9qny9Y9WyajOMpOLE3HSu/QUIWvLxpaevOJdpPcB5xh/p7Lj0/VXjP
   rgKAvaC/ESlcGgFMiJ8Mtp+455mUnXVE1wxLHNciLH+CcZNJDiqvTsMeh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="308644827"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="308644827"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 00:19:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="701992575"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="701992575"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.211]) ([10.254.215.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 00:19:39 -0700
Message-ID: <b43a183f-b06a-6abb-0ec8-498e2a62f92d@linux.intel.com>
Date:   Sat, 29 Oct 2022 15:19:36 +0800
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
Subject: Re: [PATCH v3 12/15] iommufd: Add kAPI toward external drivers for
 physical devices
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
References: <12-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <12-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/10/26 2:12, Jason Gunthorpe wrote:
> +/*
> + * When automatically managing the domains we search for a compatible domain in
> + * the iopt and if one is found use it, otherwise create a new domain.
> + * Automatic domain selection will never pick a manually created domain.
> + */
> +static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
> +					  struct iommufd_ioas *ioas,
> +					  unsigned int flags)
> +{
> +	struct iommufd_hw_pagetable *hwpt;
> +	int rc;
> +
> +	/*
> +	 * There is no differentiation when domains are allocated, so any domain
> +	 * that is willing to attach to the device is interchangeable with any
> +	 * other.
> +	 */
> +	mutex_lock(&ioas->mutex);
> +	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
> +		if (!hwpt->auto_domain ||
> +		    !refcount_inc_not_zero(&hwpt->obj.users))
> +			continue;
> +
> +		rc = iommufd_device_do_attach(idev, hwpt, flags);
> +		refcount_dec(&hwpt->obj.users);
> +		if (rc) {
> +			/*
> +			 * FIXME: Requires the series to return EINVAL for
> +			 * incompatible domain attaches.
> +			 */
> +			if (rc == -EINVAL)
> +				continue;
> +			goto out_unlock;
> +		}
> +		goto out_unlock;

Can the above code be simplified as:

		if (rc == -EINVAL)
			continue;
		goto out_unlock;
?

> +	}
> +
> +	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev->dev);
> +	if (IS_ERR(hwpt)) {
> +		rc = PTR_ERR(hwpt);
> +		goto out_unlock;
> +	}
> +	hwpt->auto_domain = true;
> +
> +	rc = iommufd_device_do_attach(idev, hwpt, flags);
> +	if (rc)
> +		goto out_abort;
> +	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
> +
> +	mutex_unlock(&ioas->mutex);
> +	iommufd_object_finalize(idev->ictx, &hwpt->obj);
> +	return 0;
> +
> +out_abort:
> +	iommufd_object_abort_and_destroy(idev->ictx, &hwpt->obj);
> +out_unlock:
> +	mutex_unlock(&ioas->mutex);
> +	return rc;
> +}

Best regards,
baolu
