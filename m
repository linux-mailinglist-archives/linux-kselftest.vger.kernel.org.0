Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECAD7CBE2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjJQIxT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 04:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbjJQIxS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 04:53:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37271107;
        Tue, 17 Oct 2023 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697532796; x=1729068796;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L5N7p8xeJeuo2tokkDexTxb3XZ0KgGQohHS81kW7Fww=;
  b=e3e14RqTOFDA7Nz9jJZ9bvy4BANshT5NwWzDdbNc0P9zGIAh/ls2RpXU
   9fACQ2pNywmTNA7TwpepY9StzhJspiEAkkmP23zARC6iWZFYljjpZPcRl
   mZbnKGfkJlUmvtpmgth1EsFpbAWcRDmceOpghbQcYPW6TgN6vgPC4sKQF
   fUOo0/13tleg68uFZo3LHmnXZOKAfHIbeNeQONXviApBzHroyzMJHv1Zl
   ag5AgAglBJ/QCps97Lg56vXKiGJKX6HBQHZjyC9SmAqPNmsc50JgHB6Nm
   Ce/X9iNg8gxviHSJVcrBe9H7a+7LLYhKrIwa3lpFRRkdrPbRXkpKCUyro
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365994061"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="365994061"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:52:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="846739667"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="846739667"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 01:52:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 01:52:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 01:52:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 01:52:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 01:52:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9Qd41QcMzlrlibKINYCdFZ672yGd21b4mAag+UK4UcV1Xol0tI77BUP65pTnUDQMdHAEniD5ngxb+svlfyzJZDT1dMJ4tDmZCsCYNTGkN5h4iLfBqneWxbtUIXPNQuAHQ0LoSp+tfWbti9PFDWQ/sSAfJZ9ik/gEyZIbo6c7c3ZUAvgR1ZA4nOluVsbM69/xE3xuf2MIUw91BbmsODP4LrrInHvgR4Jwhn/exFWbJRec3jeMV9lzdOP1Wfz59b+JmPQJXCV1FJXe5sdbI2Uh4atB3x+KJRfOXJqCVQ4OrTkmu2M7FEjdiRIyhFsUvWVIfaUxCseuczrrPb/SoE81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74oyIp3SU35ioGhEKBHCGb5pdoXKVpnQLIqe2zjEl/Y=;
 b=IZueSXc5yv6ud/vzRJztjdeX6rOAi4tqQ6EiQe0w16DUWHE1qi2XCRshm3nqyzs9urEc7w8YebD/KIpLBlREJEmS/m1dU1nudj5/9cNsH7tqfB9iREfkjEePWEw2yQ5M/fRol0dmCpBIO3oy1owYMydwCSMcJiSU5kkgurmJhje07s0kp9AotptNY3F/B7zRveFYUHuKzGAOF5H8zrhJobw8cj7lJ+WljkabuBGzxyx3jISLIuxJ+oxuA+giyflX+E1k8M7h2o4WVC7kqnBY8Ktasy36q9p+u6gawEJsHT+x6QbpZn8MBjT3WcUM3Y0rIKEuZ+hdNWq6/S5JhBaTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB7584.namprd11.prod.outlook.com (2603:10b6:806:305::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 08:52:53 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 08:52:53 +0000
Message-ID: <36725a11-b74c-da8e-b621-1a4f8055d779@intel.com>
Date:   Tue, 17 Oct 2023 16:55:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/17] iommufd: Support IOMMU_HWPT_ALLOC allocation
 with user data
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
 <20230921075138.124099-11-yi.l.liu@intel.com>
 <20231013151923.GV3952@nvidia.com> <ZSmvkxuEq7M13KYE@Asurada-Nvidia>
 <20231014000709.GL3952@nvidia.com> <ZSnmId5g2m/UnxKY@Asurada-Nvidia>
 <bd6c6a0f-3b7e-ca7c-468f-d8fe7fb382fb@intel.com>
 <20231016115907.GQ3952@nvidia.com> <ZS2Eisb94o3inW7V@Asurada-Nvidia>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZS2Eisb94o3inW7V@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: e633c2b1-232f-4d88-6feb-08dbceee72c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DWGvESn097+D3j6uGreVK6GuwtLJMR6fkQ6f+0LgjRr81A3kgiyUzGKWU/b9GWGD8Eax3ZcFdRnsYLeQR5y5k6Rlgck5wHs/Q8Z9/uEB2ecM8d/EquLMQgCES1XRnvjuKGsbvcpQy7cFf38yZo5fhLWDfC4FZ459GNxyN4ju0GcUTGNdS+q6Fh2NDFXQjrdfqktPd7OLtuywTuWdahg6mNyS3/VerruMLqowtQf2PB1ly4fAH79ki/qOSCpide4uKZZD/O4p7Y3CNHX4HsBslBssPZFL0o/Q6yUPPjuQ1WZOgXEXIye4PUZsYoITk9/7Td0p+BnPoXWLDf+l0Q9J8wYBUUz47yN+9VYzFhGWWLGSnb/mqY0Mj3sX/k/o3pYfoolOEROBraPxp/vHttyLuEvHem+OwlQ6BF9hQPxuhtUVzznBm28GoASCLUFlvPniJ1V5BCsJLQXKHYRoiWVZVNzk69vMqS3ukw8B67PZsTNBEY96j93X2kxnT0UQx0fjKmtDRWY+vrvmPPxyZeuQ8yppiqHjCKAoxUpJ6ax8TaZVeOFFU8WdNRPplkomSUicSa2wQwcBh35lHoEOKVZxLZJPdn6bcLxznYXtgPSaKCvU1zYbbQnXiAmRQnzvfKqC2QaXtqANu8Ja/dwD+pgUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(66556008)(66476007)(66946007)(316002)(26005)(110136005)(6666004)(478600001)(6506007)(82960400001)(6486002)(6512007)(53546011)(5660300002)(41300700001)(86362001)(7416002)(31696002)(2906002)(83380400001)(4326008)(8676002)(8936002)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDNJeDBQMGYyQnNWRzB3TG52SzlLbHNJWXFybEJvaUViS3R0WUdGQklya1Vx?=
 =?utf-8?B?dnFmVGY1OGY4NFc5OFhGSWR5Rkp2TWd3a2s1V1dHR2lQa1prT0xWVURPbExa?=
 =?utf-8?B?RUJ0QTl2YnEyMmZ1UUNRM1hyTnllRDhsUGNQYmppZlRNaVFDb0l1dGEwWFJD?=
 =?utf-8?B?TjN3eWoraXlqdmlTMW16R21KbVJPdTE0Ti81eUxpN1JYdlBiMWtYYnJKRWYw?=
 =?utf-8?B?VEZrRHNOWjhvdXp6L2ZTeEtBYUVFM1dWRExTNDV4YnZRL3R1ZVVCdmdrL3ZR?=
 =?utf-8?B?YXA5a1RkRE02RHJ0LzU4Y1ZTVjg2SVordjRpL1J0Y2J0Zmo3dk11dEVMMDAy?=
 =?utf-8?B?Z2VXUDUzQ05Qc3ZSbllvQWplM1QvbjZUb0NXTzlHUFQrTENXcEFXK3RDVjha?=
 =?utf-8?B?bHBRSUlNQ1JGRXh0UVU0dndTUUhabEpRMG1LSVNVNkFodjMzUkhVY2t3cFRt?=
 =?utf-8?B?TlE3WFdSVVN2YmZZMitNZFBzS1JEeTlKeEppSWozRG5ia1QrbThabTBtVGFB?=
 =?utf-8?B?U0IwbmpzVjRpSWYvU0VOaUNwMGR2dmo1RW5Ja0FjeGNZOVRJck1MY0hQd0Zi?=
 =?utf-8?B?bk9LUE1QUm9NQnRlVFA2cUpLcll1UnM3WjBrekRNTE1ZbjdQeXdOUEZDZU5J?=
 =?utf-8?B?RGpYejFGRFFjeG90TWxMK3FSc2JLRWVTMjdjakRXMU5JRGg2RTRIMXJWSjVi?=
 =?utf-8?B?WlZxVGg3S2JJaFRFWjVaYW92NGJSbENlaVcrUkJ5KzhHYTIvMGtFMDVGY2dy?=
 =?utf-8?B?MEN5YzBYbUsrUW9jZkNjZmVsTEEvU2FDUVZHeExCeC96bWo2b2dwREJKMGFk?=
 =?utf-8?B?MzZzc2dxL2hXSTA3OElxWEFXcHYvbGFpcWh3b3hRc2kzdENuSmNqbktQaHdm?=
 =?utf-8?B?Rzcrck1MVC83d0dvNjFyZDdheWo2bWc0WU9HVTYrTjlkcEtJQVlibnlkWXdX?=
 =?utf-8?B?OVRjOGxIMW1hUlA2VVlEZ3laQzNlVXZwRlJXaU9pWm54S1dYOVpZRlVmc1lG?=
 =?utf-8?B?Wjh6c1JDRU1BVU9VQnBDbVVsNzQybkZ2WFd4NER5SjEwOVkvemR6TmR2NEVD?=
 =?utf-8?B?VnB3UzlXTVIzelFJSmJXOHFzSHhrSXlFTy96RWliZ0NDeDh0dUxUOXEzOTY5?=
 =?utf-8?B?Y2p4OHF4SEpnMmNoMU5EWWx4TUNZZ2NJZGNQbEtCZGNiYVFPTlBtbm1WYTZ5?=
 =?utf-8?B?OStNaEQzSlFITUpTcDI0VlZiT3NGU3FTcjhWR0tZSHdmUHBuWTl6K2I3N1I5?=
 =?utf-8?B?Sng4cTJrS0tXNzBmdGhzZ0crQzdya3U3YmF6OFpyMjNmOVJ4NkpBM2pPNlhz?=
 =?utf-8?B?YnFaNDZsM3Q0NDRUYVkvQWUxalVZZVhqdEp5TEdENXljVmtCcU5ISklnckV2?=
 =?utf-8?B?VkF6akVZYk02L1IzMUVQeERDbWpnVU5YbDFTV1Q2bkgzTzdmK1dLeXlnSk1i?=
 =?utf-8?B?QS91ZFBDaHk4VUxIUEVaZ09GLzV2bjVLMGVka3g0Yk43M0NqbGlYbnViVHRq?=
 =?utf-8?B?Z2hHamZBdWphYTJVbDV4dFdGQzRCSlRhL0ZNd09Ea205dGZvdUpKQW5GUGJ6?=
 =?utf-8?B?ekZqdmkwSjl5OVROVFVLYzc0ZWhoTDhrb01RcFBxV1ZNL2RUUmhVbURmLytn?=
 =?utf-8?B?MHd3NlM3a1NUWThHOFhIUE9aVkhSWmozK2haalJwbmlJUXllR2xJbWY5ODU1?=
 =?utf-8?B?NXdWVTZWeUdCSXVTRXBjYXROYnJVbThKUWlWQmo4S3MzN0VDeVRudW1aVWRv?=
 =?utf-8?B?Q2hRMWQrMVVMMFdpeXB6eWdDeTZTWXJCcUl3Sm9WWUk0aHJYSEdPNEwzbEZJ?=
 =?utf-8?B?cnMxZU5uQU9LYlNucEpxT041NmN4TnIxdHlBV3ZlQktJRkxUWHBUUms1cnYv?=
 =?utf-8?B?NW5QNkNDTnBtTlIzc1loMkEvaXh0cU5ldmg1WFF5Q2xnRTVzV0pERHVQbVBG?=
 =?utf-8?B?a3ZXdUV0QXJxOTNCbXBhUmVSTEMvSTRJZUdlcHJveGhuM016MnJpaGRzTTR2?=
 =?utf-8?B?UjJJb0pzZ0I0c1JXNVMwT1h0WUo1a002MmJPVGhpK095ZXFCbGFHTGl2UTJJ?=
 =?utf-8?B?TTZuSWNqdVlLR2RRRGFmcmFBNStmR3VBQlI5Mjc5MnVzM25zSGNqR1lNa1o1?=
 =?utf-8?Q?bE5FVOq3ZhSO7q3sZI1NF6Wcz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e633c2b1-232f-4d88-6feb-08dbceee72c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 08:52:53.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbcFfmobexHY1cThwxgMTunSuJlCdmJ8cqw0rfM/OocgHfU+o20qxFH4foZsK74sxgQ2iqp/3tflciIaVGAs5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7584
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

On 2023/10/17 02:44, Nicolin Chen wrote:
> On Mon, Oct 16, 2023 at 08:59:07AM -0300, Jason Gunthorpe wrote:
>> On Mon, Oct 16, 2023 at 03:03:04PM +0800, Yi Liu wrote:
>>> Current nesting series actually extends HWPT_ALLOC ioctl to accept user
>>> data for allocating domain with vendor specific data. Nested translation
>>> happens to be the usage of it. But nesting requires invalidation. If we
>>> want to do further split, then this new series would be just "extending
>>> HWPT_ALLOC to accept vendor specific data from userspace". But it will
>>> lack of a user if nesting is separated. Is this acceptable? @Jason
>>
>> I'd still like to include the nesting allocation and attach parts
>> though, even if they are not usable without invalidation ..
> 
> This is the latest series that I reworked (in bottom-up order):
>   iommu: Add a pair of helper to copy struct iommu_user_data{_array}
>   iommufd: Add IOMMU_HWPT_INVALIDATE
>   iommufd: Add a nested HW pagetable object
>   iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
>   iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
>   iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
>   iommufd/device: Add helpers to enforce/remove device reserved regions
>   iommu: Add IOMMU_DOMAIN_NESTED and cache_invalidate_user op
>   iommu: Pass in parent domain with user_data to domain_alloc_user op

following Jason's comment, it looks like we can just split the cache
invalidation path out. Then the above looks good after removing
"iommufd: Add IOMMU_HWPT_INVALIDATE" and also the cache_invalidate_user
callback in "iommu: Add IOMMU_DOMAIN_NESTED and cache_invalidate_user op".
Is it? @Jason

> Perhaps we can have a preparatory series to merge first:
>   iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
>   iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
>   iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
>   iommufd/device: Add helpers to enforce/remove device reserved regions
> 
> Then next cycle would be basically 4 patches + selftests:
>   iommufd: Add IOMMU_HWPT_INVALIDATE
>   iommufd: Add a nested HW pagetable object
>   iommu: Add IOMMU_DOMAIN_NESTED and cache_invalidate_user op
>   iommu: Pass in parent domain with user_data to domain_alloc_user op
> 
> The preparatory series doesn't involve functional changes yet have
> a good amount of pieces to simplify the "nested HW pagetable" that
> is basically nested_alloc/abort/destroy.
> >>> BTW. Do we still have unsolved issue on the invalidation path?
>>
>> I'm not sure, there were so many different versions of it we need to
>> go back over it and check the dirver implementations again
> 
> Only this v4 has the latest array-based invalidation design. And
> it should be straightforward for drivers to define entry/request
> structures. It might be a bit rush to review/finalize it at the
> stage of rc6 though.

yes, before v4, the cache invalidation path is simple and vendor
drivers have their own handling.

-- 
Regards,
Yi Liu
