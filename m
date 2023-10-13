Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5027C7CAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 06:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjJMEbL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 00:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMEbK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 00:31:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9265DB7;
        Thu, 12 Oct 2023 21:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697171466; x=1728707466;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vkEjldME8qHGNK3LboKYsiTWApWVzLTxQhSUz6QCYe0=;
  b=WT0vv2RdEn/ZcalbuyPIZoFq+kNbxByfiZlW19eBgqSAaw/2Xq9cV9tF
   0WTEO24MVpVUOrirblZ5+j8dPFhfr5LwZ97v2yZtxMan+VE4CWBXHGK2E
   HdH0FEtWdPyjuC3bWBAla2N4jQTLl//vvITz6rcQyzOO0P2YhbWc4zQmj
   FrlPnKQB2Qawl3qGoggalkiax5FUIzlIu89ARzHlP7MQIikOPwMZPWT54
   CWseyuM9+rdLXW+pBMKu4FTu2aW5HZj3X1uO8G8pE/3q34Z8HyjMiD+R9
   OWuvkiXLWerrv/NJL2QWhYNsZMQlLFfQzxMZu4SrLRBQxSkvoWskGInif
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="388968624"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="388968624"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 21:31:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="824886547"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="824886547"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 21:31:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 21:31:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 21:31:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 21:31:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 21:31:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YetWrxW9Gaiw0LcKVNlzgkRd7Az40vaBzFn03JOngIoi/tFIWVqKWvftFFz1A0zEz/rB+pxpLOVNzpeMIqjdWzeKSEylR5Dc0+zD9egtUpcUeWdK30MNE95omec8wk0yU9M3CrYU2KCKAN2MfCLudCiEzmyoVU640voSJPOB2eaePhZCR34mTy5wGkVHjFKFKm1H68qvmBE6bM178G5Fj9oQD57oladm1kDogM9z6qLH4+DHELkN/RzO0LWaOqid1qqnrzGmykYItuWVQtyWsuermaPCtn8GFzgluYjTtbF8nUG6tmtup/h+Us/BkSEtMIO1KDvz2PbZkecQ4L2r5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb3Q2kMaIFqqFzWHOMTcMgxgj2beDA+XaSf2VyqmAmA=;
 b=IqQ70c+0GvHtC9hpHtfeyrM67xAoObOs6dlHxc0cg+zkdGl1NX7fPNHpK+2k0qLuvHcPq2yRXlAcUJjr2DkU+SuTlU1Lq9FrSdr+Xp9s2xu59albFeYgSS9FQaYkyBs36mLUJHliIj8szs1fVTdsNVUD3L4Dfj/PFGzdMMqnnaTYj7ehPi1ATAliNJWflwMGoIxkJtW/8cSDEZAdNxNF6KZUCW5BiFZGM0mN6iAYdRUoJILXvu3bn9BzoTW+WpVEgJfEYxwuQoaM2yEUXn1iLq8cnN6kKAHzuG3zkjUAFJW4OaRCyvXoyw6Jv8Dg/THQEDkmp291sjPWupZUGZ6iSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA0PR11MB4637.namprd11.prod.outlook.com (2603:10b6:806:97::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 04:30:57 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 04:30:57 +0000
Message-ID: <3659d9a7-d9e9-bb73-daf5-41c765e99c8c@intel.com>
Date:   Fri, 13 Oct 2023 12:33:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
 <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
 <20231012133917.GL3952@nvidia.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231012133917.GL3952@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA0PR11MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b0316b-3eb1-4956-7793-08dbcba531b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Oq7kNjuEJ+aQKWETmcPIN1NrkCVvX0W6d2VSuPXdExY3zjqFER7foa/THB9bddonPtJMxI26sewOTvnPktus703IVbC3z56siJ8oeae2sbvaTYwVPpFsPru7iYg07KQ3omEV9iAfoNu8JGn3OesoVeE6nUOJIhWR+U8rRQ6R5vnmVaOyPFaDSeTsT8CSzWDTlCX0htBp3gCb/czj3OgfTiOIT2sZviUtn2MiZRPjTGBk0YbpMR9mFcZ21tFHb+ZdzLQLdZA3kKopip2SL0JC347yyjgUBB72DmI07PzW6z10vKnmW6Nre8Xsi8Y8+DJezcw+yy3UYBbqTmpCW0vbkboARs6aBbBcyXClNRp35YJJ3S4Uf/ojEkWqZffa2W7+fpOexXMWgMKlBGCFUGb2X34xxfA7w93vXu49OxdEVsOErRiZQQDXA5yEbl4B+UVee3x7+E9hUBhqR6rHY/VlTE71fCHnqj9eLXy9gyLXk+syaz47kBh8tXZnF/uhHLoVfc6XvVd8Zt7fD0RPfQ38FY9wmlxdu0YcXmRAnSmqbul17pdR6NSv+gefyDQ9qgUHGZy08GLl9V3lB8oDwR54WoRYEzbmrSRMh2MBYL01U6z2Ltp3YMfOgyl6RXHCDKYc4DtmlwZXt/lcDy8vUApsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(7416002)(6666004)(6486002)(2906002)(31696002)(966005)(478600001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(66556008)(66476007)(66946007)(6916009)(316002)(36756003)(83380400001)(82960400001)(26005)(6506007)(31686004)(2616005)(6512007)(38100700002)(53546011)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTdZS3NUZGJCbmVoc1pWZ3l1N0cySU45ZE9TUW03MklYcDM1bU8xZU5ySWEz?=
 =?utf-8?B?emR0T1BKSmJYQ2NDdmozajhuNUZLNkVmWkowbTE3bVJTczFlZWxtQzIvQkx0?=
 =?utf-8?B?UWlHbW8xd2xESzBJR1RDSHMvQTkvejN3VXVRd0hCVjVlR1Z6N3pYUXdsNFhP?=
 =?utf-8?B?QjFTdWU4STRPbWM5dUk0Y0ZnQmhGSE9IZEtLL3A2MWpCcnJWME1YcDFVNTBl?=
 =?utf-8?B?UzltdElhNVgxc0RZMzFnbUZMbU9PQU1MOTdPdjZZQ2VrNU1wNzdTbk1QYWVk?=
 =?utf-8?B?T1A5eVFobHhWV0ZhSVhLUzhTc2JrTERNMHdjZFVaaW02TFdjUWJjL0tCZkpN?=
 =?utf-8?B?TzRwNzFhWlUveVZORVVCWnpsbGZaWGlZQlBUZVFja3gvd0hXU1NGSU9YNGVD?=
 =?utf-8?B?dWU0YTh1dDNNQUh1dTFtS3g5OXZReklwQTVHb0tFSWZ2TjRvakJsVk13NzJx?=
 =?utf-8?B?Q2w4aG1sRFFRV0NNM3pONlhRWUNRTXAwWXBmRjA3SHlQUnRlM2ViRmtHRnBn?=
 =?utf-8?B?a0pqMEVxalNoRlBEQWorSnVTTDBCeXZMVnFhcUI2d0VtbENyR052OGVFb0Zu?=
 =?utf-8?B?QmJmeTZKTExWNVc4QzVZTDBSUjFyLzhBQUFFQmowV3NzSXRRbDloM09GdUZZ?=
 =?utf-8?B?dm1OTnRLZjlDYzRYSEpMdGlldGhLUUlBaTBvc0J3OVY0MzNPbTJOSDlQK2ZN?=
 =?utf-8?B?VGlLcDhVTG5pbmR4WlQydjUzcEhmN3BXcGE1ZnY1TjhtS250T1ZaSnRnU3E0?=
 =?utf-8?B?RWpGeFhJUDFiVCt6a1VMUjYzOXFmVTZSNEQ3VlRxYUhHbVFVVno3cXhySlNU?=
 =?utf-8?B?dWRUUTBkc0hUb1Zhb0VFUExrRHloenArM1pIWDVhMExydThsZU44QlkvbjlO?=
 =?utf-8?B?ZDE1dUNlMEx3RTVXTWVBVm5OQm12YlV0WVVWSHZiYisxeXpwdy9Vb0Z2SmdZ?=
 =?utf-8?B?b0dqNkl2SFFTWG9nRFliOTRJRFN4VFE2eFo2Mkh2ZFRXc01qdVN3TmRCWFpa?=
 =?utf-8?B?VWFLU2VnMXYvUnA3eElqQW9NUW55YkxHanV1NHpLVk1HMXdVbC9HYXBBUitw?=
 =?utf-8?B?UnVLeUlhNmtUSW5ubWlmSWxKczZZZ3Bac25VaDdDT0JRVUM4Tldad3BSaVlZ?=
 =?utf-8?B?SWlkNy9tNlR4Nmx2VWN2dnk5QUVPdWV1TUlLeHZVQ1NuZ1g2WjRWUHM3UnQy?=
 =?utf-8?B?SVB3UmU4aHRCZzd6L0RvcEY4NWRkTmpJaXdUU1Z5VGhOV3gybk5FVWtDWnkz?=
 =?utf-8?B?K0ZMd1Z4L3F2S1NjeU44VUVYbkplL1BlWWlkeWl0clYzbHF3b05YeTF6SDlC?=
 =?utf-8?B?eWszS2doZlJuOFN5d0ZMamg4WnZSVnY1Y3drS0UzNmJEVmMzaU9YM0ZzK0ho?=
 =?utf-8?B?Y3FKU2szdG9UdTNCTE9LZGliT2RsRElZVmxpcis1K3NxU1dsNGNQd1o5TTg3?=
 =?utf-8?B?Nmx4K3hMR0pRR2xMcG8zV2g1d1VGY29PLzhwV3Q2Y1plM1VwNmdQWVcveVY3?=
 =?utf-8?B?L0hjTlJYVkl4OHc0K3RwYit5VTZQZ2drNnkyQ2pkd0N0bE10U0VUYnNLelpD?=
 =?utf-8?B?Z2IrYlEwakxaUHltQlNLTmZMbG5vRm9iS2FxWEpFcnBHU1Q4S0lTY21LNits?=
 =?utf-8?B?M2c5NUtmd0lOUVNRcVR0WTdDRmMyS0FhYXdybWVXUHFSTHJSZFV6V3lpSGxR?=
 =?utf-8?B?bXgzV2F3Z0tkeEJUdFc0NWRMUGlGZmFQN2t4MGVCOVIrRmthaXdEVU03VytN?=
 =?utf-8?B?cEx3N0Q4ay9YOEpteDRZZEU2MUIyZk8xZU54Y1djeXppQmpYajBIaDdSbDd6?=
 =?utf-8?B?OVppaUx1QlF3cU51Q200Ky9RVUpackZQWGo4THFqUXIvMVVzVFV1UVYxTkZK?=
 =?utf-8?B?UUlwOHhvNTNzWk9UQjdPUkxLcHZXL0k3djdGQVM0TmJvUEZZeUtkT2RJRnFF?=
 =?utf-8?B?azRaMWxXZjRjZ1VFWkhVRnd0Y0xZenFwQloxZENIUWswS3ovWVJkTG1YRDhn?=
 =?utf-8?B?blVOazFVMWYwem1EUTUvOXVoUzBVMGcvUit5OGJVTlQrWWpNZmw5NjhJVFUy?=
 =?utf-8?B?VG43dU5zOC9xeUV3RStiSlBidHpuVXpUUDJFL3RwMUk4cWd4UjBLOVdtdDBH?=
 =?utf-8?Q?oXEEGasuK14b8w5/I9CzjzV4D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b0316b-3eb1-4956-7793-08dbcba531b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 04:30:57.0728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLlO3UMvdt4OX9F5qmekhVKvzTumV5YlXAfSZB98vxW7Mj3HIT4ydTsupU6B7m/R3lyMTpK7I1XTiZrWQhoP6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4637
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/12 21:39, Jason Gunthorpe wrote:
> On Thu, Oct 12, 2023 at 05:11:09PM +0800, Yi Liu wrote:
>> On 2023/10/11 00:58, Jason Gunthorpe wrote:
>>> On Thu, Sep 21, 2023 at 12:51:22AM -0700, Yi Liu wrote:
>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>>> index 660dc1931dc9..12e12e5563e6 100644
>>>> --- a/include/linux/iommu.h
>>>> +++ b/include/linux/iommu.h
>>>> @@ -14,6 +14,7 @@
>>>>    #include <linux/err.h>
>>>>    #include <linux/of.h>
>>>>    #include <uapi/linux/iommu.h>
>>>> +#include <uapi/linux/iommufd.h>
>>>
>>> Oh we should definately avoid doing that!
>>> Maybe this is a good moment to start a new header file exclusively for
>>> iommu drivers and core subsystem to include?
>>>
>>>    include/linux/iommu-driver.h
>>>
>>> ?
>>>
>>> Put iommu_copy_user_data() and  struct iommu_user_data in there
>>>
>>> Avoid this include in this file.
>>
>> sure. btw. seems all the user of this API and structure are in the
>> drivers/iommu directory. can we just putting them in
>> drivers/iommu/iommu-priv.h?
> 
> iommu-priv.h should be private to the core iommu code, and we sort of
> extended it to iommufd as well.
> 
> iommu-driver.h would be "private" to the core and all the drivers
> only.
> 
> As include ../.. is often frown on at large scale it is probably
> better to be in include/linux

got it.

> 
>> Just one concern. There are other paths (like cache_invalidate of
>> this series and Nic's set_dev_data) uses this struct as well. I'm
>> a bit worrying if it is good to put type here as type is meaningful
>> for the domain_alloc_user path.
> 
> There is always a type though? I haven't got that far in the series
> yet to see..

not really. Below the users of the struct iommu_user_data in my current
iommufd_nesting branch. Only the domain_alloc_user op has type as there
can be multiple vendor specific alloc data types. Basically, I'm ok to
make the change you suggested, just not sure if it is good to add type
as it is only needed by one path.

	/* Domain allocation and freeing by the iommu driver */
	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
	struct iommu_domain *(*domain_alloc_user)(struct device *dev, u32 flags,
						  enum iommu_hwpt_type hwpt_type,
						  struct iommu_domain *parent,
						  const struct iommu_user_data *user_data);


	int (*set_dev_user_data)(struct device *dev,
				 const struct iommu_user_data *user_data);
	void (*unset_dev_user_data)(struct device *dev);


	int (*cache_invalidate_user)(struct iommu_domain *domain,
				     struct iommu_user_data_array *array,
				     u32 *error_code);

above code snippet is from below file:

https://github.com/yiliu1765/iommufd/blob/iommufd_nesting/include/linux/iommu.h

-- 
Regards,
Yi Liu
