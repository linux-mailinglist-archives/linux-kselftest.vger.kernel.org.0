Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA60D7C9DD7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 05:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjJPD0U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 23:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjJPD0O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 23:26:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E3BE9;
        Sun, 15 Oct 2023 20:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697426769; x=1728962769;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yq/XUw/16psjxHFcFz2+1NupQ0jGdbYszGaU7rSHPvo=;
  b=Tco8rETIj6bHUVBmf32t3PZiPQsOmcQ9N7h/pD0z5+frmkL+otFy+Zjb
   8AzHR7YnjZQrEa+vBj5xwEBE+IeYTOJoCJu18bmKFaDd02Al9//E9/fzy
   7VFreMsPHC4G1vAuVMKX72SgmJSluz1q3BxL/tCCT/jRsmuq3WkPmjyCJ
   WxY9x6mCExPIKEX46qOk4OV1mbWGmFFlu/Zk/jLJa6YvYt+aHIUTVBPIx
   kM4kd4bvX0RQ0OVqEPK9rcv79GKZX0NDo8hmin4lR+Bv5hzOX1i4cuGFf
   VA5C3lzqXfDQFSPltxwliN4jC0bzxFT31W7ULW5OJwMHEv77Z/HVdswaC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="382664344"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="382664344"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 20:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="732148078"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="732148078"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2023 20:26:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 15 Oct 2023 20:26:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 15 Oct 2023 20:26:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 15 Oct 2023 20:26:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4KUTtRsnR2uWLlUEoF3gd7D0JewZTy3eNRGybd6Bwoe4YYD9fzbbXwjhh44fUPJ+skl3rh3D6G2YLisETcgbSDwgWbM8P0HEbG95XyNgRHHhALPTnngVeTbgzV9jif3Zm+/B0btAPKg+Ochoh2JxiSbuQ0v6XWmchtntF3HHSwhfFqkxJ7YRV+EViq2KeedKDk6GwququtD8o/5Enu1Ia0A1+0X2evtzrgywuviXKWlt/1uhgSsf6nybITrnbwonse1wGXhpgJPl2HL8g0PnsI/kmZ5MGUxZwBY5Rt4oHLB8D02Befc0Fr8wfchroduOYqMhcJv/JP3FiBRhWaiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oMntZfidvHFTwr4DfF9pf4obpxL/z/L509gTzD8d/E=;
 b=EqUFPKyxKXBol3XiLlTAZsNCIHo9C3l343Lho2M/5QbmtMXsExwy1+2c574vb9hdu2QTeM8tZQ3UXYdrz/MO40e/M2iFCU/PnhsgAgtNJJUOeN6sgDioKdSKMuykfEYY3JYHx4J9F1qzK1mPNhR773Dz+UoEWk2CRIkdkE4eTmJPanMWaXZ2IhSwplbF/BxNfmgv1niwQhwVQ/sdHyaZtKeeivsNon0uKXP+dTjdSxkUlloBP5WxCDtq53dCcO+S2XdCf9YkFN6Zeio5ZUhH9JPkVMlMIH/17nCD0aQe6S3l/P7LrKXnKzEWVOiry8Ofvgci7O4nAPLinMse5WWrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN0PR11MB6302.namprd11.prod.outlook.com (2603:10b6:208:3c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 03:25:57 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 03:25:57 +0000
Message-ID: <79f0cab5-39ad-3d98-3896-6e1ba7b8db21@intel.com>
Date:   Mon, 16 Oct 2023 11:28:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
        <joao.m.martins@oracle.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
 <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
 <20231012133917.GL3952@nvidia.com>
 <3659d9a7-d9e9-bb73-daf5-41c765e99c8c@intel.com>
 <20231013140456.GR3952@nvidia.com> <ZSmE6unIukqJ3GKu@Asurada-Nvidia>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZSmE6unIukqJ3GKu@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN0PR11MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 610981e2-c975-4717-1c0c-08dbcdf79c8c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0U7NFZjMCdQTI0nn5VAqxFAX3UNBrp568FUpTccsI3qTP2lYwljUY2uYoFYdNCR1Pup8H4rIoa/MPVWfCTIaQ0wgVwLf6f6rKLoJLBbu8MiaEUna5ku2XY1fifn3pj5Cx99qLauFeI5zGw6Xmpc5Lqds6sFg2+RRxK8gAqqLTVKdEctTTJYo843vke2wXwnIFLzuQkrWJaVozLh5gGBvK4WgwmzgKrno9cEeBEtKDZvR5twlvjNGWGHH0Hx7pwR5diIAOZeGxcsMtJnzYZeaKCuGNooPLCgKOjqqqqAdkP7E/yPuhTsR7UnjN6ILw62WS33uLS8KDxrakcreDhV72bhxpS+FwYSn4dVL5DHlDdILzOHcAcHfoVMVRgmAUOZpKZVOaYeImPv1NkJTARX60wV1IZh+NDgdVUc9K0TZt3nC77seelCLjIljYHNQEpFtS3xq1gi/ApnRAjwoLZqup+uie1Lj6djnb/QShy6bnJ8ghij5UTtby3WIDvd521VfF8ynxfIEaxX3P7UBr1FxIqFaPRazWmzww7lwVKMjFvrjQlKAFyJedGqGQi+pgzS1z6PEYFg9kJB4bwDMh80x7tiVcJsQCFBPuxIObtMKBhllLPVcBjfvCobFlv78zA2c0JVDldYxYnaEx5xmvegsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6486002)(478600001)(110136005)(66946007)(316002)(41300700001)(66556008)(7416002)(66476007)(8936002)(8676002)(4326008)(31686004)(53546011)(6506007)(31696002)(38100700002)(82960400001)(86362001)(6512007)(2616005)(26005)(36756003)(83380400001)(6666004)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRSTWFhTXVrYW53SThHSjBkdnJOd0xJUWNXUmpta0tic0R0ZUZNYUUwbTJ6?=
 =?utf-8?B?MGlOa0FrT0VMTjNaZ3phajhCV2JVR0VSekd5Zm9PNkZlbmpjNW91d1U2SUZn?=
 =?utf-8?B?aVNkN0ZPWGE1MG1Ud0ZkTDRVWjRDNFFJTXFOVFFRNnpKcEU3cHdQbzZCSmE1?=
 =?utf-8?B?bHlYeWoxcE11R2QrMFRKeUNaLzZaMVRUNmdXZHNGdHo0eGIwbjJhYXVXa3Rw?=
 =?utf-8?B?Qml1T2syOVdwRXFWd3NWK242OHJNSFRKWGdZVnJnZkVRZ0hhVHFEUDNuSkhy?=
 =?utf-8?B?VmFxOFNNd2JURWZuUUx0UCtEaSt3eG1RMWpsQ2hQcFZsR3ZpemVDQmRyT1Er?=
 =?utf-8?B?VVpoQW9PK3ZrYXRZOCthSzdWSTNTTUdLdTd2WDNsWisxYlpYQ0FueXJ2eWVk?=
 =?utf-8?B?ZWJKUlV6VW9SVGM2aW9FOWVsQzYrelZMamczWnJndkx0SjNtOEkvK2ZhZTNU?=
 =?utf-8?B?ak9odDdmd2JYOGNaSi91c083YmtEN2l4dVNyamphZUJORGRIMjlYdjdwM1Js?=
 =?utf-8?B?Zk9mdXFBVjh3T0diTTNWSktrMmFQZUxkQ04vQ3puN1VSU0FvRHlpOTFTLzVN?=
 =?utf-8?B?TVNjanhwd1FrbDd4OU84dTh6UWNmZTQ1bDhJTDV5ZVBXYUhDYzUzQW5QVkZz?=
 =?utf-8?B?bEJJajg1b1RFdlo0SXJRYVZWQTIwbVNDQVFrdlZ6bXBOWndBYmNSOVBsdk5k?=
 =?utf-8?B?RURrVE4yaXAwdTBKOXJLR2tOaTFEcVhNbGZ2SEU2V3kyOUl0RVBIMVQzS3o5?=
 =?utf-8?B?MDNLTkk2a1Q5WEhFSEhRd2J4aUR3VUxibVI2RGhSeW13ZG5nVXNKWXFZQVVZ?=
 =?utf-8?B?SmJnVkxQRzlpSlIyZncwZjRsVUJtQ0txVXFwT0ZiVjd5bDBpdHpabHhRVnpr?=
 =?utf-8?B?bjFNWTFCb0M5b1o0NVIxQUxQaDlMTjlTc0VWbnNhMCt4amVsMnVTVGFORHVu?=
 =?utf-8?B?Q3VnQ0FSUTFTMDhQaTVEM1lGS0dHL3IvL3NJYlpHZDZ0ZlVuaFlzQmdkZ3RS?=
 =?utf-8?B?NWlrNkhLdm11cEVMOW1RTHRma0pKZEJUNnVFTUZzejJTN0hGbmtnVGFqanM2?=
 =?utf-8?B?SThOQlFrYTZKY2YzWDVBRFU2ZjRLVjBvYUFvQnVnSW5iVzF3QTVoQnQvOWtF?=
 =?utf-8?B?VjNDdzk4SFAzczBxd3M3ZFBmRE5vTWxwK3NkSkY4dmY5ai9RNks3czBweWVj?=
 =?utf-8?B?T0FoQkY4RDRnZkdpMERYTXpQOFpUYVkwK2E1NG9kZVErVnF2SDZVTnhlYWM5?=
 =?utf-8?B?eVhiRDRZQTNJWFZjaWY0YzFBTXh3M0dZbmw0U1gvZ3NvemVycDdvOWhiV1Nk?=
 =?utf-8?B?Qi9DRmIxK21OV21wL3J5YkI3aThKbEI5WXg1bVN2TUZ1eHBPSWJ3QmRENUtF?=
 =?utf-8?B?YlN2YzJVL2tVczVTMDZKSzNVV1d6Yk1lWndibUxLcTNlR2RQa0FPOXk2bW8y?=
 =?utf-8?B?T014a1FveGROV0NjR1pNTWdDK1Vodk1lazh5WDB2dlVpSENSaW5rV1RQbGN6?=
 =?utf-8?B?aS9GZ0I2dFVBeEVJenl6azN4SU1XTG1Wa25tK1lmeWRhejUvWW1uRU5qQ2Uw?=
 =?utf-8?B?UlJyYXZhQklzVmFKK0dwNGloM3ZDTWg0NXF6TE54cTRRMjRPMEZ4SHNqTE0v?=
 =?utf-8?B?M0VpY2MrTFpUaG5ubVk4ZExOc2kxcTFVUFhBYU5TV3UxdHJUK3R6dU9JN0xr?=
 =?utf-8?B?Q2xvaEhRaVAzQk4veWU0Q3h2eXpvWHlHVGdaa21Fd1RlYVZ6SU1mYmxla2RS?=
 =?utf-8?B?MHppbm5VdlhwOUU3VWdnK3lScjhZcDlra3hZR0RpMU5KZTJablZ2RGdjUWtH?=
 =?utf-8?B?Y3czSU5KSU9aTXQxQ3JMR1ZyblNiNXNQK1N0ak1odFV6cThpS01OVlNDa0hz?=
 =?utf-8?B?K2VkU0xxWGQ4NmlQaW9kQThtQ3dLei9yd1hMeU9Sd3VQbUhBU2pOVG9FNU81?=
 =?utf-8?B?N0ZWTUQ2L3JzNk44YUFEQk9lQW0yNy8xc3drZnQwU3lZZVcvY2xyYmloVEtZ?=
 =?utf-8?B?czFMNVlNaGp6MktGVkZYZVBMU2pmekhaVHBsWnJ3ekhvRnIwUDhDYjVOa3ls?=
 =?utf-8?B?WG9sb0JCRWdzbytMblA5dzNhcnpDUUpweHdLWFI4MFA0cDZQSTVINnhHUVAw?=
 =?utf-8?Q?4XQbeg9UTBxVnCYik5gd29Yt1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 610981e2-c975-4717-1c0c-08dbcdf79c8c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 03:25:57.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jP3X435pYg6bQTtiGiO0wEbfIJ8pASd8eIY+4/fG3Lg7taS+FfaGVNBKs3LfyjW0NVwJX/M1Tr+H+DEDhoZGJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6302
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/14 01:56, Nicolin Chen wrote:
> On Fri, Oct 13, 2023 at 11:04:56AM -0300, Jason Gunthorpe wrote:
>> On Fri, Oct 13, 2023 at 12:33:13PM +0800, Yi Liu wrote:
>>
>>> not really. Below the users of the struct iommu_user_data in my current
>>> iommufd_nesting branch. Only the domain_alloc_user op has type as there
>>> can be multiple vendor specific alloc data types. Basically, I'm ok to
>>> make the change you suggested, just not sure if it is good to add type
>>> as it is only needed by one path.
>>
>> I don't think we should ever have an opaque data blob without a type
>> tag..
> 
> I can add those "missing" data types, and then a driver will be
> responsible for sanitizing the type along with the data_len.
> 
> I notice that the enum iommu_hwpt_data_type in the posted patch
> is confined to the alloc_user uAPI. Perhaps we should share it
> with invalidate too:

invalidation path does not need a type field today as the data
type is vendor specific, vendor driver should know the data type
when calls in.

> 
> /**
>   * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
>   * @IOMMU_HWPT_DATA_NONE: no data
>   * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
>   * @IOMMU_HWPT_DATA_ARM_SMMUV3: ARM SMMUv3 Context Descriptor Table
>   */
> enum iommu_hwpt_data_type {
> 	IOMMU_HWPT_DATA_NONE,
> 	IOMMU_HWPT_DATA_VTD_S1,
> 	IOMMU_HWPT_DATA_ARM_SMMUV3,
> };
> 
> Though inevitably we'd have to define a separate data group for
> things like set_dev_data that is related to idev v.s. hwpt:

yes, the type field is in separate data group per path.

> 
> // IOMMU_DEV_DATA_TYPE sounds like an IOMMU device, other than a
> // passthrough device, so renaming to "_IDEV_" here. And perhaps
> // "set_dev_data" could be "set_idev_data" too? Any better name?
> 
> /**
>   * enum iommu_idev_data_type - Data Type for a Device behind an IOMMU
>   * @IOMMU_IDEV_DATA_NONE: no data
>   * @IOMMU_IDEV_DATA_ARM_SMMUV3: ARM SMMUv3 specific device data
>   */
> enum iommu_idev_data_type {
> 	IOMMU_IDEV_DATA_NONE,
> 	IOMMU_IDEV_DATA_ARM_SMMUV3,
> };
> 
> /**
>   * struct iommu_idev_data_arm_smmuv3 - ARM SMMUv3 specific device data
>   * @sid: The Stream ID that is assigned in the user space
>   *
>   * The SMMUv3 specific user space data for a device that is behind an SMMU HW.
>   * The guest-level user data should be linked to the host-level kernel data,
>   * which will be used by user space cache invalidation commands.
>   */
> struct iommu_idev_data_arm_smmuv3 {
> 	__u32 sid;
> };
> 
> /**
>   * struct iommu_set_idev_data - ioctl(IOMMU_SET_IDEV_DATA)
>   * @size: sizeof(struct iommu_set_idev_data)
>   * @dev_id: The device to set an iommu specific device data
>   * @data_uptr: User pointer of the device user data
>   * @data_len: Length of the device user data
>   *
>   * The device data must be unset using ioctl(IOMMU_UNSET_IDEV_DATA), before
>   * another ioctl(IOMMU_SET_IDEV_DATA) call or before the device itself gets
>   * unbind'd from the iommufd context.
>   */
> struct iommu_set_idev_data {
> 	__u32 size;
> 	__u32 dev_id;
> 	__aligned_u64 data_uptr;
> 	__u32 data_len;
> };
> 
> Thanks
> Nic

-- 
Regards,
Yi Liu
