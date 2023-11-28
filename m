Return-Path: <linux-kselftest+bounces-691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A97FB057
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 04:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD93C1C20B40
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 03:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0046AB5;
	Tue, 28 Nov 2023 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ve9rydiA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA05138;
	Mon, 27 Nov 2023 19:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701140952; x=1732676952;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KR+7lxX1yjeOgSzvZ4SVrJjylQn8p9U0JLCmKdZOsiA=;
  b=Ve9rydiANr22ETAjwSzfMgszxMMJyeikuaDA8EDnHUOx8CqYw4Byy9az
   ldk/1hY9LzXPZc8DOahwzv3+9U5Z97oUYJz9+3rGhPNE2LYppK+XVJIa0
   dYIxOtgnxWLrict5CcsISBWJ86h0uvDSZVJXF91jCD8I26GCDz0huWglW
   3vN8pO5N2LUF+41tehfYCYi7/cImKYw00QP3tatYQK1uWq+vbImFM411I
   nyYT3kC9Hmogx6elIN2qmV6ALexZyP+IrbX18d0Lp2SZwGLRn8qgDGCnZ
   rlXouucm5JTN+TlAhOm54Q9zYZMo6byKau3zpiIzBuSQn7iiXL0uAvcVO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="459342539"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="459342539"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="9985682"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 19:09:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 19:09:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 19:09:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 19:09:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaF8BNFcdIK5M2rUExNRagXsp4EAYqtkfvlVJ7RZpGML0YqjeW+SFWrrcRPeKC8Kz3l3zfL8yx8G4vZiRLyNMcHoYiUdfD+ttys4uEHj6joDHZdpRMJOsMu7EeQPqwdo8DtKP4CiTtj1vxiwnKyPeHU25eux6X6rO0qvFNx07RiXAlB2zc2yCinIaJT3Hjn9n0sbdwgA3sJvDSHym4ktmXvhb6Go4yKeckJKwIS+ExmRlxQk5e7Q6MIJQPYVXwqSCkwPb2U2vhu9q4BBoewTY3qdFvUeQQNWfAUgfzWd1oOG7suOQk+hsuyNzcR7mfPS5AmipK6W32dY8QmZ84bsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zl/FJBZXuBtkx9Vd0he378btII5AE5z7PSSPCa3OCNM=;
 b=m0D/4phYWZXevIuZZa/gJKZIkh8umrsJuIzhS3/BDl1PUYuRa21o0gp++yVinJhuU6ccsxxnpiUB0TlMn/W6fS1B8PdJOBGBykMEQ/XlExeplvkwabsByb3/PETr29wLZe9d9QzXY/68RaDJXbaaPy9OPObJAVGusQ2euBucwfxnSpFsheqlQDEHBc1cc1ed1kCJmJnQICnElJ/Fnh596JojDAbKSmivOKPzAXO7i1s4adUwK3SZ14ykphiiz4k2SkYJoNgxKWVJ21qtpZ0mmRZ9TEJtg8VCy8tw+dOv0ZWVyz+pOsHQVAoy00b69aGp8p1OWpvvEa+ifK6TobNzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 28 Nov
 2023 03:09:08 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 03:09:08 +0000
Message-ID: <88353789-6b37-44ca-aa21-23d27fab37ee@intel.com>
Date: Tue, 28 Nov 2023 11:11:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Zeng, Xin"
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <SJ0PR11MB6744DC9B7C7D0E4122F224FD92BDA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744DC9B7C7D0E4122F224FD92BDA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ2PR11MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: c7047d7f-f32c-498a-1296-08dbefbf6285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZVk3fb9Ol/HRYOq35twO1ZgNwyahBJfxRVCKGYYZRqdnYUBTj9rkl6JJXrHYYvfq1c1UW4z4MLOGj3uckV3OH4vocM94fB2nSuO5Xib5SGJiBMZ2F6BzU71QV1M0xazTgNwgQ5/3/KtwIm+rWiwbdQJt+c8YX+beOujJSgVyvTvIEwd9BE9zehSmswlqNB2Jd9fF3XamHbS8OsX1o+JWSJdneaeNQTvo28YKmpOVVmZuW7zVZG7QnJ71Bx3J10QxO5+IO/upfYkZs3hxOZEJv/qpOWsLHi+BnUXLhlLoJNko8TKOpOCUIG5Xa1H7zkyekszoPZXjIDPpuugi1R9PLiYo9k5gS3OGtxmZEZs186lhA2vsCwuvh9JyGW2M7Zn7r4AHirzusOVG41GMtlfevKV9rHUxG4YJxQgs5zwyGuhcGVcEq4GM/gnUkXQoOiAqGLxHxN+kBPvYjUJabAjnwS1UGZTsl/Ww6COD0P9wTISYsMcso8mDlqsourlzv8tFSWXOEUqk1MDqVgyp2WhJBon5hGAtsJL4vvo/lNjeQzOhUHhjT/4Tc1f3B52BOkXQcPA1xP6zoiKe20khdtsb/OJthz++ltBUsso+MQXzM1B2AAbOiWz1v4rYl/kOlN9DmEH/W8Kpzzy24tPTFjQDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(41300700001)(2906002)(8936002)(8676002)(66946007)(66476007)(54906003)(2616005)(478600001)(7416002)(53546011)(5660300002)(6486002)(6666004)(6506007)(6512007)(31686004)(26005)(83380400001)(316002)(110136005)(66556008)(38100700002)(31696002)(86362001)(82960400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eCs2WUpocC9tS0ZrckxkL29RSlVmZ09YSlZWcmZDWjQ0TFBxOWFTT2lRYWpu?=
 =?utf-8?B?RVN4STg1SWthT3VCVmlzVG1ra1FaWkt5bkg5cUVXU3FPTGFGOFpYNWxUZkxF?=
 =?utf-8?B?MGE4NHBJT0tkMk1zZUVraWhTdTQxb2tqNE9tb0lkRU5sRUdqTUFjbEFQYWZQ?=
 =?utf-8?B?bHB5QjdxczUxWUl2cFErUlVmUU9nazZXU1dEYjJGeFdXY2RtcGVpamFZL2tp?=
 =?utf-8?B?bnQvL2FIbU53NDM0VEY1eHR5cjdpWWpUdXJBQjh5MHhxcnNJVXRkNlM1engx?=
 =?utf-8?B?bGNBM1o3ZjVKaVM1YThaS0hMOWJmYUhPZUZUNEdZTWdVYkhJcVFWalpiQTU2?=
 =?utf-8?B?RGZRRmJUa3IvNkhxK1oyaWh2Nk56RVpScFR1Z05xNHR4QTRrUDRGdnNBSzMv?=
 =?utf-8?B?QlZFdnBOVXYxMGxuaHhpTjIyd0RtVlR0NHd6UXRTQW43a1Z6OWdBY2R2VGJo?=
 =?utf-8?B?bWVxd3Y4cVIzdS9qbnJiekFZNGwwRGsweXZpaGNEN01zNWJzVGhIODNNTU9D?=
 =?utf-8?B?eGVxY2RZSjllY0U5QVhpRTRORm5xTW5pbTVwNHkvc1ZNVGNyVGM2QzRUb2lz?=
 =?utf-8?B?a29wOXI4OHVjS0pHcUhVMmRCaDdHZGh4S0t6M1FodlpnYjBCQ21DMnFsQlNo?=
 =?utf-8?B?bnFBaU0vSlFkSm5lbHhuQ2pGeXZWVFJxZmliSitLUis2aWdwa3dBc0cyNzl2?=
 =?utf-8?B?bytXMzNvTXpQWm0yaitka0FoTkdLREhsYWhVNzE3OXRjOTZjczR3SjF0SC8r?=
 =?utf-8?B?eTg3SlhpWWhNS2NCaFR1WGFFSzQ5WVVCcXpSTWNJK1lxSTZPV2pCekwrbkpv?=
 =?utf-8?B?OGJheldOcWtmcy9wU2lFSmtIZlVWUFN1aGMwZUNkUzFxUzdLUFNtd243NlNG?=
 =?utf-8?B?czlQQjlqZDI4bjRLeTBYZkpjVkhueGd3MWUvUHRUTm9NRWJDZzlxMTBZQVNx?=
 =?utf-8?B?dlNtQ1hHcDZqcmZVMDNLcE1uYkg4UDZ2WnhReHdRb1FHUHlxQzhheTRENVhy?=
 =?utf-8?B?YnlHdUU3dys1SkVUSDBBeVFDV2NNaENEcTNyQVNnVERaMUNQenRWVHdvcTZZ?=
 =?utf-8?B?MVhCNE5zOGZkZGttTnN0YkdVa2dUNmFoMzBDWEVQRXZKUUJOWDgwSzMwQXc2?=
 =?utf-8?B?ZVZKajIvYWtYU3R4em9HZU5WcUdvNWZ6SjFtUU42YUlXTDZMSWxzS2xMa0lz?=
 =?utf-8?B?ZlU0YWdiMDI1alk5M0xWVXNnbUw3cTd4MFBmS2FVcWhOenFYV3I5QnNjQ1Ey?=
 =?utf-8?B?d1dCZ1pSdlFMSU5yZ1o2L2ZvZmUyVGJOQW4zclRLLzZnbExkNXJyRUcvT1k0?=
 =?utf-8?B?UmM4cWVnVGUrMnJvc3RpbU9zWTVjbVl6VlVmRjJrOFJUWWFxWGNBaFdTdE1x?=
 =?utf-8?B?a24zMHFoa281MVVwM1B2VkV3MklZYy9iWWxTc09iRnQyNlJUa2N4ZTg5d1o5?=
 =?utf-8?B?UmN6SlRDeEM2ZGJLLy9aTlVxM2FteDY2YjFwS1Mwd28rdUVuTWRPa25KUEZa?=
 =?utf-8?B?VmdsNW5DUStHYy9UQ2VYZEpSWThvdkQ1SWh1c1YzY2gwVFYvZ1FZWUNwWjJo?=
 =?utf-8?B?K2Y2YVk5ZVNsOHNkK0ROMXBPRmJNTUdiNzhwblQvcitaMWVZT0MzSS94ZFVL?=
 =?utf-8?B?RllBcVhBcDlRQ1hiNjFYVWxpalpzV3pRaUVuK1VpdnR5ZWRHWVZYQkl4Nkg4?=
 =?utf-8?B?cWIyMm1ha3pvVnFUeDB3Y1g5TFU0VHY5anhKTC9TanVJKy9SSVZyTGVSYW5z?=
 =?utf-8?B?MFdReDd3bUdYOExlN3pvNm1xRUhkSllSSGJCMmxaejZNbjhCWDkzOXJEMFdi?=
 =?utf-8?B?ZjNpRzRnaXpoc1VKUzJJUkVUbGZrc3c4YUJlUFc2RlMyVXJ2YlB5S2RGNFRW?=
 =?utf-8?B?cGs4Uk5ZYnhoS3dTK3FneTRtcHNzTFdnT3ZGSkJ6Z0padzdya0liYUhMUWxm?=
 =?utf-8?B?cWJUMzlIMnErTGNBVFBkSkcvbmtVZjlBM3VFYWFiWUs2ektjeHZieDZ5dENn?=
 =?utf-8?B?UVlxVUtQMW1reFRTZGloSkh1LzVub0pVM1BjdlFjKzc0SHNRSUIrRHFoS3BD?=
 =?utf-8?B?aHk4MkRrcC9vZW5EU0ZWWmd3cEhIL0dIVU1MOXEwYjFBcXdvT2FlUUl0ZUlh?=
 =?utf-8?Q?i5WDiE6FmncG0PMU6A/qb1Bbe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7047d7f-f32c-498a-1296-08dbefbf6285
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 03:09:07.9688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pNCcYJDN/pfbmKOYtRmhWg8jiJD+Qi6Phi019fLNFic9Zcbh8ix0GMMFjuryLKxLO4RJmLTgFIbNPW5i4AqZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8587
X-OriginatorOrg: intel.com

On 2023/11/27 15:28, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, November 27, 2023 2:39 PM
>> Subject: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
>> ioctl
>>
>> This reports the PASID capability data to userspace via VFIO_DEVICE_FEATURE,
>> hence userspace could probe PASID capability by it. This is a bit different
>> with other capabilities which are reported to userspace when the user reads
>> the device's PCI configuration space. There are two reasons for this.
>>
>> - First, Qemu by default exposes all available PCI capabilities in vfio-pci
>>    config space to the guest as read-only, so adding PASID capability in the
>>    vfio-pci config space will make it exposed to the guest automatically while
>>    an old Qemu doesn't really support it.
>>
>> - Second, PASID capability does not exit on VFs (instead shares the cap of
>>    the PF). Creating a virtual PASID capability in vfio-pci config space needs
>>    to find a hole to place it, but doing so may require device specific
>>    knowledge to avoid potential conflict with device specific registers like
>>    hiden bits in VF config space. It's simpler by moving this burden to the
>>    VMM instead of maintaining a quirk system in the kernel.
>>
>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>> drivers/vfio/pci/vfio_pci_core.c | 47 ++++++++++++++++++++++++++++++++
>> include/uapi/linux/vfio.h        | 13 +++++++++
>> 2 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 1929103ee59a..8038aa45500e 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1495,6 +1495,51 @@ static int vfio_pci_core_feature_token(struct
>> vfio_device *device, u32 flags,
>> 	return 0;
>> }
>>
>> +static int vfio_pci_core_feature_pasid(struct vfio_device *device, u32 flags,
>> +				       struct vfio_device_feature_pasid __user
>> *arg,
>> +				       size_t argsz)
>> +{
>> +	struct vfio_pci_core_device *vdev =
>> +		container_of(device, struct vfio_pci_core_device, vdev);
>> +	struct vfio_device_feature_pasid pasid = { 0 };
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	u32 capabilities = 0;
>> +	int ret;
>> +
>> +	/* We do not support SET of the PASID capability */
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
>> +				 sizeof(pasid));
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	/*
>> +	 * Needs go to PF if the device is VF as VF shares its PF's
>> +	 * PASID Capability.
>> +	 */
>> +	if (pdev->is_virtfn)
>> +		pdev = pci_physfn(pdev);
>> +
>> +	if (!pdev->pasid_enabled)
>> +		goto out;
> 
> Does a PF bound to VFIO have pasid enabled by default?

Today, host iommu driver (at least intel iommu driver) enables it in the
time of device probe and seems not changed afterward. So yes, VFIO should
see it if pasid is enabled.

> Isn't the guest kernel's responsibility to enable pasid cap of an assigned PF?

guest kernel should not have the capability to change host's pasid
configuration. It can only write to its own vconfig emulated by
hypervisor.

> Thanks
> Zhenzhong
> 
>> +
>> +#ifdef CONFIG_PCI_PASID
>> +	pci_read_config_dword(pdev, pdev->pasid_cap + PCI_PASID_CAP,
>> +			      &capabilities);
>> +#endif
>> +
>> +	if (capabilities & PCI_PASID_CAP_EXEC)
>> +		pasid.capabilities |= VFIO_DEVICE_PASID_CAP_EXEC;
>> +	if (capabilities & PCI_PASID_CAP_PRIV)
>> +		pasid.capabilities |= VFIO_DEVICE_PASID_CAP_PRIV;
>> +
>> +	pasid.width = (capabilities >> 8) & 0x1f;
>> +
>> +out:
>> +	if (copy_to_user(arg, &pasid, sizeof(pasid)))
>> +		return -EFAULT;
>> +	return 0;
>> +}
>> +
>> int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>> 				void __user *arg, size_t argsz)
>> {
>> @@ -1508,6 +1553,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device
>> *device, u32 flags,
>> 		return vfio_pci_core_pm_exit(device, flags, arg, argsz);
>> 	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
>> 		return vfio_pci_core_feature_token(device, flags, arg, argsz);
>> +	case VFIO_DEVICE_FEATURE_PASID:
>> +		return vfio_pci_core_feature_pasid(device, flags, arg, argsz);
>> 	default:
>> 		return -ENOTTY;
>> 	}
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 495193629029..8326faf8622b 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1512,6 +1512,19 @@ struct vfio_device_feature_bus_master {
>> };
>> #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
>>
>> +/**
>> + * Upon VFIO_DEVICE_FEATURE_GET, return the PASID capability for the device.
>> + * Zero width means no support for PASID.
>> + */
>> +struct vfio_device_feature_pasid {
>> +	__u16 capabilities;
>> +#define VFIO_DEVICE_PASID_CAP_EXEC	(1 << 0)
>> +#define VFIO_DEVICE_PASID_CAP_PRIV	(1 << 1)
>> +	__u8 width;
>> +	__u8 __reserved;
>> +};
>> +#define VFIO_DEVICE_FEATURE_PASID 11
>> +
>> /* -------- API for Type1 VFIO IOMMU -------- */
>>
>> /**
>> --
>> 2.34.1
> 

-- 
Regards,
Yi Liu

