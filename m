Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96A861A648
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 01:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiKEAHg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 20:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKEAHg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 20:07:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EDA317F8;
        Fri,  4 Nov 2022 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667606855; x=1699142855;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SK2sI5aDoV9/etevfTVRBjvDW9ZuCS66qUATN3sgJBw=;
  b=ayEmehNwuQ/zjz1ydkXJ7oAEdaPl42r03VNwDT7lLUrh21bhAA46/DbQ
   0YLA0aRb1FjWYgpb7tJmwiz8i3Xud/6tgHQFfN0XgRX970+dsMXfvCQlX
   poPUIRZXR+yEPpvr1xFh3R9c/UqHkD3WyPa17HmkUzNCAMX2hC6+YpKQy
   ayNN+yKvjMwBdnddCX0K6jH7VoRaFHsa1O/RK/sK6ZpEEm7AbNk05ZhcY
   1xtW3Vdg3u3X4N6/74dkes1/vQLezkGF4YVkFbDdxtee3DSii9GwKeUfQ
   a7E6ncv8pgiDv3TKNhSCPHXXJ6IfstaUVLV6V5xQHBF6GTV6TAUywMu/z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="293432643"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="293432643"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 17:07:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="760501944"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="760501944"
Received: from ztao-mobl.ccr.corp.intel.com (HELO [10.254.213.180]) ([10.254.213.180])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 17:07:26 -0700
Message-ID: <2d2b467b-da07-2b96-27c9-569b727dd8c9@linux.intel.com>
Date:   Sat, 5 Nov 2022 08:07:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
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
Subject: Re: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
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
References: <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/10/26 2:12, Jason Gunthorpe wrote:
> +static int iommufd_fill_cap_iova(struct iommufd_ioas *ioas,
> +				 struct vfio_info_cap_header __user *cur,
> +				 size_t avail)
> +{
> +	struct vfio_iommu_type1_info_cap_iova_range __user *ucap_iovas =
> +		container_of(cur,
> +			     struct vfio_iommu_type1_info_cap_iova_range __user,
> +			     header);
> +	struct vfio_iommu_type1_info_cap_iova_range cap_iovas = {
> +		.header = {
> +			.id = VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE,
> +			.version = 1,
> +		},
> +	};
> +	struct interval_tree_span_iter span;

Intel 0day robot reported:

commit: 954c5e0297d664c7f46c628b3151567b53afe153 [14/15] iommufd: vfio 
container FD ioctl compatibility
config: m68k-randconfig-s053-20221104 (attached as .config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce:
         wget 
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
-O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # apt-get install sparse
         # sparse version: v0.6.4-39-gce1a6720-dirty
         git remote add internal-blu2-usb 
git://bee.sh.intel.com/git/blu2/usb.git
         git fetch --no-tags internal-blu2-usb iommu/iommufd/v3
         git checkout 954c5e0297d664c7f46c628b3151567b53afe153
         # save the config file
         mkdir build_dir && cp config build_dir/.config
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross 
C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k 
SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
 >> drivers/iommu/iommufd/vfio_compat.c:294:17: sparse: sparse: cast 
removes address space '__user' of expression

vim +/__user +294 drivers/iommu/iommufd/vfio_compat.c

    288	
    289	static int iommufd_fill_cap_iova(struct iommufd_ioas *ioas,
    290					 struct vfio_info_cap_header __user *cur,
    291					 size_t avail)
    292	{
    293		struct vfio_iommu_type1_info_cap_iova_range __user *ucap_iovas =
  > 294			container_of(cur,
    295				     struct vfio_iommu_type1_info_cap_iova_range __user,
    296				     header);
    297		struct vfio_iommu_type1_info_cap_iova_range cap_iovas = {
    298			.header = {
    299				.id = VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE,
    300				.version = 1,
    301			},
    302		};
    303		struct interval_tree_span_iter span;
    304	
    305		interval_tree_for_each_span(&span, &ioas->iopt.reserved_itree, 0,
    306					    ULONG_MAX) {
    307			struct vfio_iova_range range;
    308	
    309			if (!span.is_hole)
    310				continue;
    311			range.start = span.start_hole;
    312			range.end = span.last_hole;
    313			if (avail >= struct_size(&cap_iovas, iova_ranges,
    314						 cap_iovas.nr_iovas + 1) &&
    315			    copy_to_user(&ucap_iovas->iova_ranges[cap_iovas.nr_iovas],
    316					 &range, sizeof(range)))
    317				return -EFAULT;
    318			cap_iovas.nr_iovas++;
    319		}
    320		if (avail >= struct_size(&cap_iovas, iova_ranges, 
cap_iovas.nr_iovas) &&
    321		    copy_to_user(ucap_iovas, &cap_iovas, sizeof(cap_iovas)))
    322			return -EFAULT;
    323		return struct_size(&cap_iovas, iova_ranges, cap_iovas.nr_iovas);
    324	}
    325	

Best regards,
baolu
