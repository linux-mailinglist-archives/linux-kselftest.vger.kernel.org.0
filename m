Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC847AE533
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 07:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjIZFsF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 01:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjIZFsE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 01:48:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E955E9;
        Mon, 25 Sep 2023 22:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695707277; x=1727243277;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CUbUHRnlCcQQlG5yP2zKahGSDm4CN7zFcmbTMZUo3lA=;
  b=Yat9B9iCRxTSy2j+5qj/0VSFikWH0gFlbAAKU61A8Khk8N/AjlgDPoI8
   CXPrVMKtz2eJXG8hsMXtLTLJ90c2rKt24aqQ//ow3dEFBqRCTX0Vhpwwk
   dLwikgYfJdxHdfCKo/5xbwfPRe2eBn0B6ECbtUhoRlnzk8PFBoieyTRMC
   ouSgma4g99pstyS2RNzozyWCTNi5jH4D5zAa4usyEUOT6In/SahWvX+/q
   T4+1f8RONqyJTta921oc9VJpH4oboquDGTOBpCMqECWvMtFZxrFiJUXUx
   RKUUzsvu/vQfoVBv4OnARaGYqWZxiwEx+YvTlDs6q3rqCMvnfcHUK26Ju
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447987472"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="447987472"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="742236124"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="742236124"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 22:47:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:47:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 22:47:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 22:47:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xke0qULQ2g0L1qThpp0vtzSBWv9iIxEC7294O8Jw7RGRjBJ0ySz+64RKGJNV5S2Q98k30TR4vM3tJ8OZAmqsf2GgkSoMST25GCuNQZDVQVp40iVKpBnr/qHq6ZtsAdpL91Hu7QhqM755UjWzQhAMrpmJ47ifurVwlBBtq5Q9q67Dx4YCgN79gwJOCgUkulY/pcwLCFYS9JMoOYj84bJ6XP7zgXpqDN3NxXxNYRmDSsnacENG39xAqnpUWW4CHYx8Ga975SXmJS6kdCPqebid0g5OIrkdhpzr+xlAitIdkIZNHz8B9YKnYoMJ1RpdUQyZh/OgqsSYguBM3pISL/lpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZbyimxF7VRh2vSo//uo9Zx0YlMazZ2+kYyOCFvssEo=;
 b=T+vfvBCiRF3EGO8fNtditoCG5/WzD1epyTA08ipwTNCpuuMrRSE/3PS8lr1Q+AOyO9gD9RUJ5bzy+eEi1Z4/B18TWgF6bq8l0a79kOmGwyPnQRKjyV+CAKOBbajxEJl8rY3E+XY6WNXRwuuOXHy7AKOflPRz+67y+Hv/d31UQpW3f/OzMJio5qWvUwyh8UyrYv57Z+DUwgYlYg0pLumiKFZUuYbnz/R5YcEIVeZzbfEQKVzxJqxC3SPDkpOf7KDtMP6caRP9HRoXeZ+vhk0wHweVt5QGpjNIkCEwsWV6dZaeNOjk8VaD8x/7cxCSkZ2C1Tc3eaW1kcsp8RTykosBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB8012.namprd11.prod.outlook.com (2603:10b6:510:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:47:52 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 05:47:52 +0000
Message-ID: <8e459e7b-2951-e252-b1ec-c2dd6d047aff@intel.com>
Date:   Tue, 26 Sep 2023 13:50:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] iommufd/hw_pagetable: Support allocating nested
 parent domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-5-yi.l.liu@intel.com>
 <BN9PR11MB5276DBCF4B2DCF894C4E53278CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276DBCF4B2DCF894C4E53278CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: e269d7c8-6ec0-4a87-6c28-08dbbe541f38
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svw4lGjR2n9k4M8I/IXvkISVlqCq17zR+NaRmrvUdlAZ7ERSvyNkSDSo2LVL3v74XyUF8nf0EiuJX4VqnSjwSMjCW1AzCjBNsRcfE39cm4I0Lc6mKPfJtCsmzxpEbtvYyyC05iZARLjtVPLTvnTN7AX8rsDGboVH98rIQdVIMMcFfgL+4Ie7wnLWYRmoCteiUF6MTMP0tU9siYPxikisr8YSwGsemYjVqtHxBT3+Ve+MUpaVJZcIuNIrNHrWaFljzcRZho8I2xm2a2RSWbV3fK3nWKvpSa8BEK4exovEbtf6pOmDxPER3/cY8wNomAs55T5nY/OJEaThHS6OwDW32bIZ9jw9VRDswiO0rJjU2CYnoyAkcHu3GBlpqp0GBw/6j29lJp5E3oryR2tbxj56EEAN0a9YEZgpzCElshjxXjUzKyRbisiG234YFyZSoGhG3DLEsFvg4oPTaO8keXiWb/e3Ib9af6a+SzU7Ub/69ZvwoHOI62CaCKkn0aacMStJPvc8jgoWaDMtcFVYf98e7Us1tsX6Q/HHqiBeemUMmigOUgqAQLY0xpWLVt1vdrObGNcM6htLv0SEG7uCz7sv18B+GdSlTKZKIOKGc3l0bflxuf5pBTgNh3Zpj0bJADJmjYP5Q3fdmNckz3OfOkHtsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(83380400001)(26005)(2616005)(86362001)(82960400001)(31696002)(38100700002)(6486002)(36756003)(8936002)(4326008)(8676002)(2906002)(66946007)(54906003)(66476007)(4744005)(66556008)(478600001)(316002)(7416002)(31686004)(41300700001)(5660300002)(6512007)(110136005)(6506007)(6666004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm9qaWdUOXlKZzVUeVYwZFFTWjQyQm12b3U5Y0F1UXZCN1o4UTM4d2lucVpq?=
 =?utf-8?B?TjFPcDJOdTF0ZG9VTWJabVFMN1Vud0FDRGRTcnpQa0Z0cGVCbFdZN1YxdlVL?=
 =?utf-8?B?YmMwRUxrbWZlSFlCcnFpZUhnMWdyeVZuTlN4TkZJcEIwTUxmK2JDSzB6VElu?=
 =?utf-8?B?NDJVZ1g3R1MrTWFkS1RNbng0Rzl4K2NIMllMNVd3Um0wd2VuQzV6RFRMc3F5?=
 =?utf-8?B?dHpVb3lHM3FVRDVESndiTUE4bFZ3SCtsWkxEM2dxL0cxZk5aeDEvK3JZaENh?=
 =?utf-8?B?NDRBMzRqemtHRXlHRmxmemVFOHBMbnJmRlF1ekg1bnFZU0o5TnNXMGNoU0xP?=
 =?utf-8?B?V3RaZ3hjcjFPbTZSWjlUeFRrOC9wczhxbFpEV2RXV2tjYXpHRk40dTY0VzRr?=
 =?utf-8?B?cGFoZXVRZ2hQNHBVbXBTQ2U3STk3M2ZLK055cXl4dlpzclNlWTM4VDB4aXNT?=
 =?utf-8?B?UWdaZVBMKzZicy90bE5mRFgzOW9vSFZWdk5kKys0dXBITlV1TUtrRUwrZ1dI?=
 =?utf-8?B?Q0ovSjdEWjA5S0UrL2pSWEtoVUNBWXZtYnVMS1dyVnYxOTdlSVh2OTRBd2N5?=
 =?utf-8?B?UklkVElRRWY1ME44eTFGTGtsWVdTMm1ESG5BdVBReTlHR0NqN2VQNSt4bXhZ?=
 =?utf-8?B?Tm5kL2hGUTljQnhVYVRJQno2OEYyMmlVUmgrSGpMdlEyUkc0SFpISDhpSjgx?=
 =?utf-8?B?cFVoYjR4Sk9kNWRmNW9HaDF0SFkxTitUR212YUlvaHhVeXhIaGM3Vi9qK2pP?=
 =?utf-8?B?ZGMxbkR0eEpuTDBURjcrVnUrR1F2ak5obHVJU2xQNHl4VVh0NkVqbHRFdlBo?=
 =?utf-8?B?NDVTenlIdHZXOWhjaFVFankrUll0ZFQ2L2JnN2tZWmk2OVp4cnVwYUNhQ1F5?=
 =?utf-8?B?SnYxZnMyS2NtcEtXR3ZKZFAvb2pIZEJ3aEhqL2JUQVhvcFBZQTQ0RU5zSzdC?=
 =?utf-8?B?NjFDbzVtcjl6Slg3am9peCtLeFh6RjdrSlJrV0c3Vm1VRUlmLzFwMTNDMCto?=
 =?utf-8?B?anVqQUI0ZjNpSTFnMHZDTGl6bUh3QUJoaFdRWldmN243alBEWUlSYkkwQWRF?=
 =?utf-8?B?eFNwdUtFMzY3TVRKTFpGZzJuQnVMWkFvcm1QOTVDNFF0UkNFU0Q0Wk4vWUZX?=
 =?utf-8?B?TmNlSHRONDdxYUhDaEloNUNjOTd5Um41ZWhYM0FBS2tRaFE5SzBTWTBSaHpI?=
 =?utf-8?B?K2prSFBJeFcvSUJXeW1Kb1ZrZkx3RlVmZ0N2eFBnQUpDZkhLeUl2eUZud2ZE?=
 =?utf-8?B?U0lxa3FrUUJHY1gzTS9nbVA1SUNNTStBTngxbWJ1RDlWSk5ndDQyZXNWajd4?=
 =?utf-8?B?M2RKYkxDTUNmQ2drQXdhU3lIczhWYUVFdTJ5NU10WWNPM2NWb3RuS0UrS1Vs?=
 =?utf-8?B?em1QRWhRQ0EraGtwU3A5dFIxN25hWU90OFdBYy9tZHpyZU03Q0dWSGNJeTIv?=
 =?utf-8?B?a1MyWHlZRzNJMWZ5V0t5WDlVeVUwZDdRSlBiZXlqdThvYW9LSWN2Q1gzZm5O?=
 =?utf-8?B?UnVNZXF1ZEx6YzdsVUlEM1FKZkpmYkQ1d2ExK21sbHI4VTJhMGl0NS9NVTBL?=
 =?utf-8?B?bmFmVkt5TDE3T0dPUjFqR1lud3lSdE1xTTAwWkdiM1M2Qlk0cFNVM0Q2Tmd6?=
 =?utf-8?B?NnNkb0ptbWE4WUVEbXdZemFDUGwwWUdWSWxuSGJ5TnNXcndIOEwwSzBFeFM4?=
 =?utf-8?B?MVdtNWRLc2J3czNtRUhsS1Rmc3JhSmFram9LTVlZNCtOMjZtRDJXZE1ZTG5K?=
 =?utf-8?B?Z3AvT0h2WFdYT1lib2hBMWY0RzVmSzd6T0lJUzBMU05GWXptRnB2SnRZQWg2?=
 =?utf-8?B?Y1lYK3BEbjkvR2dxMHpvNGxLdDY2Rjc1aHVTWHdDTndFcUdQNmx3WkZoLzhv?=
 =?utf-8?B?MWoyZVdTTm1vZVFUbk9DUkMwQnBIc2RjOUtJa2FobFNqUkR3bXROQUw5UDAr?=
 =?utf-8?B?NEtNMTI5c1I0SHhMOUg3U3NBNWVHaDNsUUQzbDhRTklLTC83ZUtHME9MSVdE?=
 =?utf-8?B?ZEUyY2UyZERzVmc3ejljTWk2QTNqTW9YQnVtcFJVZHZvZi9wOHcvazU4alBx?=
 =?utf-8?B?N3djMmhETFBXOC9XcHhwUlYyNFZrU1dCb1JMUUdrREl1SSttRW9WbU9KUjVk?=
 =?utf-8?Q?H9Mlmy+09r4mfjljb2jFRlYXC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e269d7c8-6ec0-4a87-6c28-08dbbe541f38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 05:47:51.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAGUttno3lFZilVN0Tm8k3TkJpeO0sdTg7vVQp9Mi/hxSRNlV84rkKCoAbHDPrbhnFUYkxHVew8hElT4eDGRdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8012
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/26 13:32, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, September 19, 2023 5:25 PM
>>
>> @@ -83,6 +83,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx,
>> struct iommufd_ioas *ioas,
>>
>>   	lockdep_assert_held(&ioas->mutex);
>>
>> +	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ops-
>>> domain_alloc_user)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
> 
> if (flags && !ops->domain_alloc_user)
> 	return ERR_PTR(-EOPNOTSUPP);
> 
> as long as flags is non-zero we'll need the new alloc_user ops.

yes.

-- 
Regards,
Yi Liu
