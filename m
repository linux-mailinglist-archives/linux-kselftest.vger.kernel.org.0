Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB026120FD
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Oct 2022 09:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJ2HZY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Oct 2022 03:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJ2HZX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Oct 2022 03:25:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B209E5FF5B;
        Sat, 29 Oct 2022 00:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667028321; x=1698564321;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pdSuXJp1XhtaXabpFFjunuzlj4sN7bGhSfVL9lBLAP4=;
  b=CpmflPo4Cp029qIyseW/8A0JsyKeJaMZJiaN3YRe//QUVrraKnpevFlc
   +IxGi7ZMvajXrxf+3OtOQBUjDnNAOojguKk2Bb6TPmTTysM0VWPGgUBJQ
   DchdKUWK45VvUROEBMNdHGsY0+0PrsHw5IMkadNb7ZGbVybnVEHbmKPS9
   z+ydSOgABYBMS4yzzaYimL10Rp4ekeCx/nWx0Bo79RLh/bMOlLmbSINKT
   u0daNpigAM8NigiMFr8DmhWTiq9ubkAH/ciOXWg6MYvavcA/vDjsYnIEc
   0dqYrDkRav0bg3qH4eYBGucE1YBOdkgjt4I1S3t70IAwYpEHQf2mE62Xb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="310341202"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="310341202"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 00:25:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="635552771"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="635552771"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.211]) ([10.254.215.211])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 00:25:02 -0700
Message-ID: <32d495bc-2dc7-1cc3-9c63-31f8172bb394@linux.intel.com>
Date:   Sat, 29 Oct 2022 15:25:00 +0800
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
Subject: Re: [PATCH v3 10/15] iommufd: IOCTLs for the io_pagetable
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
References: <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/10/26 2:12, Jason Gunthorpe wrote:
> +/**
> + * struct iommu_ioas_iova_ranges - ioctl(IOMMU_IOAS_IOVA_RANGES)
> + * @size: sizeof(struct iommu_ioas_iova_ranges)
> + * @ioas_id: IOAS ID to read ranges from
> + * @num_iovas: Input/Output total number of ranges in the IOAS
> + * @__reserved: Must be 0
> + * @allowed_iovas: Pointer to the output array of struct iommu_iova_range
> + * @out_iova_alignment: Minimum alignment required for mapping IOVA
> + *
> + * Query an IOAS for ranges of allowed IOVAs. Mapping IOVA outside these ranges
> + * is not allowed. out_num_iovas will be set to the total number of iovas and
> + * the out_valid_iovas[] will be filled in as space permits.

"out_num_iovas" and "out_valid_iovas[]" are outdated.

> + *
> + * The allowed ranges are dependent on the HW path the DMA operation takes, and
> + * can change during the lifetime of the IOAS. A fresh empty IOAS will have a
> + * full range, and each attached device will narrow the ranges based on that
> + * devices HW restrictions. Detatching a device can widen the ranges. Userspace
> + * should query ranges after every attach/detatch to know what IOVAs are valid
> + * for mapping.
> + *
> + * On input num_iovas is the length of the allowed_iovas array. On output it is
> + * the total number of iovas filled in. The ioctl will return -EMSGSIZE and set
> + * num_iovas to the required value if num_iovas is too small. In this case the
> + * caller should allocate a larger output array and re-issue the ioctl.
> + */
> +struct iommu_ioas_iova_ranges {
> +	__u32 size;
> +	__u32 ioas_id;
> +	__u32 num_iovas;
> +	__u32 __reserved;
> +	__aligned_u64 allowed_iovas;
> +	__aligned_u64 out_iova_alignment;
> +};
> +#define IOMMU_IOAS_IOVA_RANGES _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_IOVA_RANGES)
> +
> +/**
> + * struct iommu_ioas_allow_iovas - ioctl(IOMMU_IOAS_ALLOW_IOVAS)
> + * @size: sizeof(struct iommu_ioas_allow_iovas)
> + * @ioas_id: IOAS ID to allow IOVAs from

@num_iovas: The number of elements in @allowed_iovas array

> + * @allowed_iovas: Pointer to array of struct iommu_iova_range
> + *
> + * Ensure a range of IOVAs are always available for allocation. If this call
> + * succeeds then IOMMU_IOAS_IOVA_RANGES will never return a list of IOVA ranges
> + * that are narrower than the ranges provided here. This call will fail if
> + * IOMMU_IOAS_IOVA_RANGES is currently narrower than the given ranges.
> + *
> + * When an IOAS is first created the IOVA_RANGES will be maximally sized, and as
> + * devices are attached the IOVA will narrow based on the device restrictions.
> + * When an allowed range is specified any narrowing will be refused, ie device
> + * attachment can fail if the device requires limiting within the allowed range.
> + *
> + * Automatic IOVA allocation is also impacted by this call. MAP will only
> + * allocate within the allowed IOVAs if they are present.
> + *
> + * This call replaces the entire allowed list with the given list.
> + */
> +struct iommu_ioas_allow_iovas {
> +	__u32 size;
> +	__u32 ioas_id;
> +	__u32 num_iovas;
> +	__u32 __reserved;
> +	__aligned_u64 allowed_iovas;
> +};
> +#define IOMMU_IOAS_ALLOW_IOVAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_ALLOW_IOVAS)

Best regards,
baolu
