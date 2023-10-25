Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0877D60B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 06:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjJYEHR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 00:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJYEHP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 00:07:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78258128;
        Tue, 24 Oct 2023 21:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698206833; x=1729742833;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7kgOiCUjEX20TuwCa5BbjdTWBvtzLnnvH6on/TXi1Qg=;
  b=O2oKw7of0XHX42yX6qlA5pfnAAsEUKCAON7Rbqj61mtE3NMfa7QExPGz
   9WB/YgCY9g4nZdRIslhpTRe2qTl9UyjD8GCxKM9K+Bm5uj4REOPje+JZN
   Nt6jmYaKK0Qw3dkLU8ifnRQZtsf/RaCwGQ3rCAkyE0XNiIqdZm2yY8uUS
   CEHPkim+t7JY2rNJOhRG6HyZXLkR3l4woBzU9XA0mN4H51f/CbmJTMrHp
   lwP5Ai2oi5+7cdvkD+F1TZmDgWtfnBpAkMAI3qlFf2cL6VsSSwJ7Rd7hG
   iBHkGLi6feHfAVF1Y02Mg7zWrbFzvapFcxbbsBJ3SqSE5BPEwGioVlxwv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="387049775"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="387049775"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 21:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1005863952"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="1005863952"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 21:03:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 21:03:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 21:03:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 21:03:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 21:03:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqPI90D5F1CET4XAXsEtUCjILgHwWztvyOLbIzOeKYoPS3tJEdBepWws4I6swSfp1xbA9v41AChCoFPk95//OiLY00IZLEcIVelf/Qe6u6EvTccKH8HKIr/S4ZZwFw9fu0+UTTDYoT4cTt7Qnmbh3lvUhcoTqXggZPaMghiHJw+a4RifzWUajqVnCeKBj4NN5QJlFPKe6OX7MMl6QcM3eWlErKjHv7ky3Y9gRbiePIP4j+AJVQshQYUPEIczQ5G+OsgWBMGUwif9rEgMM3nOYNslT0hrht3LY70e4KBPsgRTpIYRIYpYRYaCmD8qt0tJaEEiBLGjEvDZOXUDsqLlTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08oMlKo+qIWFSxHSZlXEEYdrASJ9xnvjB9NkJIIxg6A=;
 b=HPLCx/bhmtbq+fOlrAFKAJHmcW0+J0Lif8tf8uxyzFRa2pGJjcVMU+oKupOmjENXbj7f46kQOXj4jQCMmhOC/QpQGwFzWEtWjmN8B+bDkjgqjcsz1WACG1v2ttdR9i/5PdSHZ/5om5bZ69ZCd2ZNT8u9g9Gx7fedgLKMNlgzyLOIJKG1wch1mnSt4s2pmAJx4tdbNIIn6cfVpiX9dyMmi9UGAGry4XQKF1Rn5TwbOvdE+JCaQxeSesGVu2Ik5wi23/K37nf3+MJVr5OOoMHEgaid3QzPVApNz7WiB90zeUJymuLWmQi+F+8E+YYybACcIjBjlyIOi1TIgzWckARwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB8180.namprd11.prod.outlook.com (2603:10b6:8:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 04:03:17 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 04:03:17 +0000
Message-ID: <f278af4c-d00a-4b03-8a2b-ee1b84254e83@intel.com>
Date:   Wed, 25 Oct 2023 12:05:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] iommufd: Add a nested HW pagetable object
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
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-8-yi.l.liu@intel.com>
 <20231024171810.GO3952@nvidia.com> <ZTf+zWJE2qlgkf1M@Asurada-Nvidia>
 <20231024173139.GR3952@nvidia.com> <ZTgEApUgriFj1dKa@Asurada-Nvidia>
 <20231024180049.GV3952@nvidia.com> <ZTgKqwYdH27b8MUB@Asurada-Nvidia>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZTgKqwYdH27b8MUB@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 0179c7b4-ec95-423a-e239-08dbd50f51aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYxU2qH8YqMSqKMnMUVmQexb3bkfNHbYr1OPlUoGzq4ecujbUxHYuohr/2ccvsMsB5Rd70t0RtlH15Ok9ell2LiGwVX6KAAE0aqLftuBvsUjKp1984kCbaCrfYduTGCL5MFgWAm9sDGCnb8TyrAFfFZjZegGd5Ga26yLNJ2g8A5pk+81GmjvmVOifonCMxScLyg88z9sdAau9SBL8CtCk1i2p91GeKmkAdsnVG7CkF6xe+HZY48ehPTNYkshXGnvL7avQ9hsfnoxuLeRTiddLyo9YucKyncd/jXnr2ak+8Y7qWMl4KuKqcHbRGwCp6Uds24Wyx2AEuLGw1bN3h7v2GYdfcCzMrh1cOEUa8gqRrZMsSfsQPRNq4OdBjtoc+7czwl/AuC0eGuPzV46QEuiQZZ1vbuVcexBtsdNIvIkJin5TGe5xr1VhPDArEab0IDUqOLpmq8c/bmKSoOGh4g65Ijow6qLjgFaogPqKBd3gO4WzITXDVECu0YqBknGR69sRQeKszpZJ4PbOUXes+qJWRVypdaxiBOSWp6StlZHYqhqiTMjlobR7iOjzKGpaVTwTa5tOZ4JS4t6oi2DBeo1l1Sf7bH6N+ga88I9zBdQKhuygR+11M04eyWqt/Cc4XTS3pYGFDN2QS4sjnNpYFYHbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(53546011)(6506007)(5660300002)(6666004)(41300700001)(66899024)(26005)(83380400001)(7416002)(36756003)(2616005)(38100700002)(82960400001)(86362001)(6512007)(31696002)(2906002)(478600001)(110136005)(316002)(66946007)(66556008)(66476007)(966005)(6486002)(31686004)(8936002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajhYUTZxM0ZRYmFmS0VvU0NYdW4yWUw2TEhhQjJSWEVJbHZMNDI3SUUzVkJ1?=
 =?utf-8?B?eG15Y3Q0eTVxUm5aLzhCUnNGb1RuazdlK1VXMnM5NXU1RGQrVGl2RDZKUzI2?=
 =?utf-8?B?SXB6TWZIeXEybUQvRkZ5RHU2RGhITXdKMVlyOXRFSTZYRmFvSHhHWUFOQldR?=
 =?utf-8?B?dmgrZlc3dldzdDlEVzQwZ0lJdWhPSk0wNzFLOHlPNjJmS0hURVVVUWlXTTc5?=
 =?utf-8?B?VEZRbnZOaDdtb0xQOVpTUXlhQ090RlNOODEwZmZlUzRqOUQrQkhoa2RwQXNQ?=
 =?utf-8?B?Z3lGZ3dOcEdlQVljaG41Zkdocm9vNStsaUhWdkJLOE9ISW5rZEVNVEVGb3hH?=
 =?utf-8?B?eGNYU2pBbFhYekdqMkNUeHZiYU84blcwMTZpRjBhaGNnKy9DRU9zSVJEMEhB?=
 =?utf-8?B?RjMzTnFHMUpQYmtnQU9MVlo3SnpzU0YzWTNQb21lblMrV0dnWHUzQzJyTGx5?=
 =?utf-8?B?bzgyVlRUNDZmdlVuZjEwbmZ6WWRPYTdwaGZwd085cjVYb2RvUW1jUDA2L25C?=
 =?utf-8?B?ak03OEk4YUJXM0tzQ0t6SStNQWltYzBucFgwVGdpeWZXM25FUUlYRzY2bGpm?=
 =?utf-8?B?ZFhxeDVQZytXcGZNSzV3QU9XemszcjB3cEMwTzF3dG83dE9PZDM1VHM4TzhJ?=
 =?utf-8?B?ZENKNStJc05kME8zaHFLeFd1emF6aHhQTnhrZmZkUFltR0FvMEoyTzJDQTF0?=
 =?utf-8?B?TDJGWEp6alhBZ01kSTVZQjhrRXpXanU1QkxjN3Z2V2poUmphVS9LS2xlYVdM?=
 =?utf-8?B?d0NFTlBRc2UreFp1S2ZrbGlhanA0d0VkQkVLb28rRWhPZ1JJVDlkUGdEZGpy?=
 =?utf-8?B?cElUOWg1T3Bad0V2dnZPVnRsSEdWTHhzOXhYSWRQRWNCbHlFN25xeEcrdWsy?=
 =?utf-8?B?LzQreHVQNDc0bGZXSU1LMjhYTjZ0cVp4OXJadW1sV1g1UUhZZE54ZDYrNTJn?=
 =?utf-8?B?OHgrNnpDUk1mWmU2L3U4Z004Zk1uRWs5WE1KNUh3ZFBKY3gyM29odnMxSG14?=
 =?utf-8?B?MEkwNXdwekgrYlA2Y1g4OXY0alV6Z21zR1VYUUw0ajJOazRjWW5peG13MWtE?=
 =?utf-8?B?VjJEbWtHM0xzVzQ1YmZnWTRlQzNPcVZ0UHM1QlFSMG9DNG9TYWpRQXZRcEFo?=
 =?utf-8?B?dXE3bEYrZkEvREFQWHFRTE5XbDNUclJacnpybEVQNUc2SGJVemFZdVlYQi9l?=
 =?utf-8?B?eEx4am5UZEZtN3VhbFpVeEM2N3AyTDA3dng2dktrQVZtUjRnN3NhUGpXYWl5?=
 =?utf-8?B?OEFUWWhmbStwWXNFN0R3bVdXMDhPeXl0U0xwTGh4TzFMaG5NQkdjSlp5a0ZP?=
 =?utf-8?B?Snp0cnNDcHcvckpZV3o4Z1BVK1U0K0FSMngwckUvZjF6N09Wd0tsWFhTdmtZ?=
 =?utf-8?B?OHBpMFB3UmlXUVVGZExjTHhDdXJBSXVTcFgxR0x4eXVFcUs4SGR5bEhHallm?=
 =?utf-8?B?cnRUVXA0dzBwYWw0cVZMVWVHQXRPWVAzMlcyZEpUZnBxM0I5MnlEWEVQSFBj?=
 =?utf-8?B?bEJvU1Y3YzhJWW5oQVN1b2gvQmUwK2VKNkxoVVI5WWpVaWNGZlhWLzR4NlVt?=
 =?utf-8?B?Wm5qL2dsQUthSjJqbWltaERKbEp2T1VmSGExamxXSGdmZklPMldxVEV6dnAz?=
 =?utf-8?B?c1AwMmFLYlRhRHUxbno2SUFUVUx0UXBiSUhVSmp2bWdnck1FcytMdkw0Mlls?=
 =?utf-8?B?MEdIUUkycVU5RkpramlYWkdGWEtnNnYzTnRNN0J1MTh3Q2Z2UDZYK2tJNDhj?=
 =?utf-8?B?bWMrZ294ZUhIWXF1eFlTVWcyQVZDOWxyNXpnUG1NaTc2c3RNZzlJenc5SEha?=
 =?utf-8?B?ZXBuZWxIS1BJejFhcnlBNHR1WGN0QTBrT25xSnJFV1N0ekg5YVBla0NZNG10?=
 =?utf-8?B?M3RNU3ZnaWpHRW1VTDd2QWgzdFU1SFNUZ2xHTU1vSCtNa1VrOG1XN04xc3Zq?=
 =?utf-8?B?SGZDMGQrY3NOcHJpRVRqN29admtDMXRtQUhxTmlNNjZmUlMyUGhVSk5oL1VQ?=
 =?utf-8?B?cUd0ckV1Z1JUT3IxeVFISFVreGZsR3NnRnFLWHYvTXgwL0lUQm5TNStLdEc0?=
 =?utf-8?B?TWl3azF0MjhPZ3JNZjZGL2IxMXdQMTBwVktkOFRLbFNyVTV4OEdRQ0YwY2dt?=
 =?utf-8?Q?1u1mA90c9cCymldD2KhJxhAjK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0179c7b4-ec95-423a-e239-08dbd50f51aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 04:03:17.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cn6AAWq9M5fneBYvrHnffV3rkEILC/2dFKiqrxeSxDPJKVJgQWkAgTw5djx4qerMkvs2EFp0KZbHQYd0/myc6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8180
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/25 02:19, Nicolin Chen wrote:
> On Tue, Oct 24, 2023 at 03:00:49PM -0300, Jason Gunthorpe wrote:
>> On Tue, Oct 24, 2023 at 10:50:58AM -0700, Nicolin Chen wrote:
>>
>>>> The point is for the user_data to always be available, the driver
>>>> needs to check it if it is passed.
>>>>
>>>> This should all be plumbed to allow drivers to also customize their
>>>> paging domains too.
>>>
>>> We don't have a use case of customizing the paging domains.
>>> And our selftest isn't covering this path. Nor the case is
>>> supported by the uAPI:
>>
>> But this is the design, it is why everything is setup like this - we
>> didn't create a new op to allocate nesting domains, we made a flexible
>> user allocator.
>>
>>> 458- * A kernel-managed HWPT will be created with the mappings from the given
>>> 459- * IOAS via the @pt_id. The @data_type for this allocation must be set to
>>> 460: * IOMMU_HWPT_DATA_NONE. The HWPT can be allocated as a parent HWPT for a
>>> 461- * nesting configuration by passing IOMMU_HWPT_ALLOC_NEST_PARENT via @flags.
>>> 462- *
>>
>> Yes, that is the reality today. If someone comes to use the more
>> complete interface they need to fix that comment..
> 
> Ack.
> 
>>> Also, if we do passing in the data, we'd need to...
>>   
>>> 280-static struct iommu_domain *
>>> 281-mock_domain_alloc_user(struct device *dev, u32 flags,
>>> 282-		       struct iommu_domain *parent,
>>> 283:		       const struct iommu_user_data *user_data)
>>> 284-{
>>> 285-	struct mock_iommu_domain *mock_parent;
>>> 286-	struct iommu_hwpt_selftest user_cfg;
>>> 287-	int rc;
>>> 288-
>>> 289:	if (!user_data) {	/* must be mock_domain */
>>>
>>> ...change this to if (!parent)...
>>
>> Yes, this logic is not ideal. The parent is the request for nesting,
>> not user_data. user_data is the generic creation parameters, which are
>> not supported outside nesting
>>   
>> Like this:
>>
>> --- a/drivers/iommu/iommufd/selftest.c
>> +++ b/drivers/iommu/iommufd/selftest.c
>> @@ -286,14 +286,12 @@ mock_domain_alloc_user(struct device *dev, u32 flags,
>>          int rc;
>>   
>>          /* must be mock_domain */
>> -       if (!user_data) {
>> +       if (!parent) {
>>                  struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
>>                  bool has_dirty_flag = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>                  bool no_dirty_ops = mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
>>   
>> -               if (parent)
>> -                       return ERR_PTR(-EINVAL);
>> -               if (has_dirty_flag && no_dirty_ops)
>> +               if (user_data || (has_dirty_flag && no_dirty_ops))
>>                          return ERR_PTR(-EOPNOTSUPP);
>>                  return __mock_domain_alloc_paging(IOMMU_DOMAIN_UNMANAGED,
>>                                                    has_dirty_flag);
> 
> Yea.. Then the vt-d driver needs a similar change too (@Yi) as I
> found it almost doing the same:
> https://lore.kernel.org/linux-iommu/20231024151412.50046-8-yi.l.liu@intel.com/
> 
yes. mock driver is kind of sample code, so the intel iommu driver is doing
almost the same thing. will follow up with the branch Jason shared.

-- 
Regards,
Yi Liu
