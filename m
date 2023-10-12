Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB52D7C6905
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjJLJJH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 05:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjJLJJG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 05:09:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C748490;
        Thu, 12 Oct 2023 02:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697101744; x=1728637744;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=27UNpudW71yekNNWp3J8ODIQ3ePdo0MBIswQBu++NfY=;
  b=JoZyTuI3OBOEaohqwi8vx+N2yXA/p4No1MXoh1VeLG+G6YmDPUwS7dRC
   YfNpVX5+wfUnpNRJ8fbiQvcW0AYBMqncOi7Y3t4GAlCI4KN4Q244zyb9D
   Mi5mabPt6Nmdkj4gWx6n+b9r/zQ/SMTuCO5Wr7WMUYcwO6wpXpzbp5NIp
   PWZOppNDn4G5XVTPB/bSs5ZKH33UW85PozrcTy58uz+SXvTL147OCziez
   lUOQ4tZwck392qOB4GSagdx0UWlUtBqlII2M6ImL5tw3qPboqpCeBMR+k
   npdAE2I1M5xbfV3DkGti0tsll1TG7ndaLaEvNrPPplh1w+zclkxuzqyMa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="369936730"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="369936730"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 02:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="898009505"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="898009505"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 02:07:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 02:09:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 02:09:02 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 02:09:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFhi74JU61jvuosa5kHPD8nN7wdsD6nYAX2/svItbF3NLDPGpJnb1/jSa0LIqVfLNyoN2fXgGspfukU2/CBXvvBTkeBs8v8xkJK9ZjhY0MGLelBRKPO3zqw3WqOvxvWlW+mKTwNG/CObGr/Qr4br/fPCdNgXFkMr/ZklcKugEtdD7uhSKdIPbOkFbr+MIq+mHlzcfDjfuceAgfdSno/HnwGKeLcSBabYLuvXkZDO+nwf+/nOSo1q29sF5PMuTof5OReb0v5V6A5va7FkNNfzIOgTSxIw0LbAu04wwgJ6veZjEktLdZqE/tvsVbi92L3k/nEjAUyjS4XMHrfzAtpdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnvMFg1SzdhOpWC8k/735TJmr5AzxzYAPtPQag1bKII=;
 b=ViHKBRYhpLUBJx0m7k5mfWq9sJFAaLFuYg3BLOliLeUtNOxijTYrsbfmov9HBCLSQa/+eJdeP8LX58vlSiC8aoXs8x53V1n6lvrXZNixqKQv9QTcarqt7ilI5Urkb2Wfmgm3PLnjqjiS1gwyhMCkrHzhXzGjUfNvKYt/7Zw77tl8Ih9xcHkIcbp8wb9HDQ+SXMaj8EBimhabCXZXTaoWN2qGfeXX8pvUIefey9BvCroeFOG7J2Ede60melj1p6hiu0MrQJhPgSBfd63SmNwyEDMw8eRGglYiVhjgPFw8zujf6QdWJDCHYjyvEEo2yHI8H6O2DVSHr9PJafln345Qfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH8PR11MB7992.namprd11.prod.outlook.com (2603:10b6:510:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 09:08:59 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 09:08:59 +0000
Message-ID: <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
Date:   Thu, 12 Oct 2023 17:11:09 +0800
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
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231010165844.GQ3952@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:820::28) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH8PR11MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 19929f29-a5a8-4dd3-1683-08dbcb02de4a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MB5glmaONgCAXSshbX9CXcqeJ23m0HiQCu2sr6Qp5BtBObi7tANEphOtGRczWLLqUVvIt8evf6lmBBqoJgsoaH8VmyJxFo21yye8c071jhYlpNb6BNnvX1UTkLABj0+eo0ZN33v2MgwyUQCZZ7+c+O4fY7Z//B3ISRlehATn5Wkuxs6NMq/tO+od1XdZE+X6rYh2H/ex6y2aWTTzCXJM4lwo1QrAV9WPTqozx0JGfRjH4WPL2q8uUpFx58Xo/LX/QsycXsEpr5/pyyo+/PqRFIGIhdjHyqgQviFTqNY1zlNmoJgRT25ieWITpAJLaMYNbM8cuxWuju2c1wQGrQD+pCCBsZnOhHt1zdzQ6SS2U9JVKn+7vthBkRyablNsVkM+mpwXP3zYzl6AQr5JmqLHXL5MvO3wZfZqvXzfnT0KSuW5cS4ljR8awLKgSravsURsLDhbbM7i1VWGE3M3bZPjv0XVoVS+N/ntExozLvQW1SshT58bUWZAEQ9kXyurdEQY5CZAM4mA2UuZLD+z4yUnywsBbY0m0qmdJ3gec3TB4x45dtXTl84Tibpi0xMWi4Ja4XTMMAJIbtxWNo3K6x6vaUhY1PxNdHvn7sAe4ehmc8+9rbeIWCWFE6ZwMfQ2I51j0BTc9N7XPbjtER8qXrckNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6506007)(53546011)(83380400001)(31686004)(26005)(38100700002)(6512007)(7416002)(86362001)(2906002)(31696002)(5660300002)(6486002)(4326008)(8676002)(8936002)(6666004)(316002)(6916009)(66556008)(66946007)(36756003)(66476007)(41300700001)(2616005)(82960400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTl6V0dLSUtxSVZEOGRoZ1ptSE9qYm1FYkdsZmlzZ3hCMUI4WG1KQVdaQnFl?=
 =?utf-8?B?SUVNaVEwWGJKSHJBWW5UOVlWOVdaRjRlaWpDNk5sRUJ5QjBtZFdGOUNiMlFV?=
 =?utf-8?B?eTlVbmN5S0VrSXhsYXNLakZkMFpvbFlIbUlMaXA2WTVtMTFGT05rdEQ4N3M3?=
 =?utf-8?B?SGhhSS9nZ0pERFF5dC9nUW1vYkppLzRiSUdZSGpLd1BaclF2K1JRZEZhSnhN?=
 =?utf-8?B?VGQ4WDhtamhMK0xZNzJTNnN0aHNKUnB0RUlRMDRhek9NV2FQSHZWMzlyVk5U?=
 =?utf-8?B?ejRlU0FZUDhaSXMzWnFOLzI1dkpGZis4Z0owVmgzZG9yQmgrVmpQMFhUU3pG?=
 =?utf-8?B?UGRPN3UyQkJGMHlZL2xWeFdwNHkzSFhoS3BEWWRVVmpVZXliSVhPblUxL2hR?=
 =?utf-8?B?ak5rSnVLZjJNelRzSWIvNDBmUHgya2g3YWRHNUZrYUdNZ0VSQWpQaDdkWkJs?=
 =?utf-8?B?Nit3RklHUCt5OFdHd21NWitxcExNd1NRMTVxR0JJY0FOcTJnRElYK2Nuc3g1?=
 =?utf-8?B?SUJHUmMvZzcrSmJZd1dyMzZyYkRCeVRtWkEzSnhjQ01yby9SbjNydGVWSmpJ?=
 =?utf-8?B?UEJkUFcrN0tsQTZwWlc4eTArMm0zNHlNc1VqME9qT0xWMGM5YngxamVqRWg5?=
 =?utf-8?B?U0VtWU5WWjNWbi9pNlRnZjZ4SjRkTHpFVUhrRWR4bjkzNmtRbkpYeCsrN2dJ?=
 =?utf-8?B?MVNQNVloYS9vR1pWYzM1WjROYkZ3TWFORDY3WnhlS3M4YWdkM3RCYlE3TGh0?=
 =?utf-8?B?NU52eUtkaDJzQkZuc3lEWTdtWVA3MzNQUXFKNGhidno0RkdMUnJBQVBFZUVF?=
 =?utf-8?B?RzFhYmZ0YXAyUHk1Tjdwb1hMVjA4SmM5Z2FSNEdCbFBQSm83bWlQWm5RRkVC?=
 =?utf-8?B?eDd4d0syMjg4QlNHZjZoMjhJWWo4THl2azI1UkEwc2dLUHRDYkNqYkwzZHpP?=
 =?utf-8?B?bGF2STlpN3djU1ZkUE96bE8rTGRGSmFZM2dBakh2bVZLQk1UTEs3RTNDdmY5?=
 =?utf-8?B?VUZzYkR1YlYwOG1NQjFKM1UwQ1NmdVkvMjJkWGR4MTFtUCtzM1lEcFpqcTBU?=
 =?utf-8?B?M3dHRGN0Smo4NGVNMWUrdUFVckpQelY1OWx5aEdnWHBhYVZTSkpZdXMxZHl6?=
 =?utf-8?B?VlhaQVVXT0pxWDBVMGNNSGtXSHNnTG9BZUlLOG5SM2VjVkNqN1hQNTZOZ01v?=
 =?utf-8?B?a2VDcks1RTloWnU2K1ZhY2MxYVlHMFZIR1F0Q3hCM29zMENaLzMrMjNxbHZk?=
 =?utf-8?B?enNXUzRCbFJRWmNZM1JodUwrMTl2RTFaL1dhbG93c0pkRUJCSnBOQUVXb2xU?=
 =?utf-8?B?Sm9YbkxwVWg2QUcwOW1HU0hvWkh5aW9DOEUxV0VPN2F2bnFnM3ZXaUhjNDVY?=
 =?utf-8?B?ZTFYZ0ZnL0hjbUlmS1IzZ055SE9QYVRoMWlkMTk4SmVWVVpBN2tzQzZqSFQ1?=
 =?utf-8?B?SVJkbGN2SzNYa3BiZ2lpU3l0K2FWS0hYN2tORXNzVHFBeVNUUkN6LzM3eW1z?=
 =?utf-8?B?aURSdGwyYmczdFliRFREMDczU05YWXVaK3lrU1Nha3NyT1hISkpvMXQrQ2dQ?=
 =?utf-8?B?WjB4RnVINTFlQThwUy9pUmRwdk91cWREWFFleWxRTVUrVWpYaEM0TVZzTlFq?=
 =?utf-8?B?VUdDQmEwUy9WWWdybDErK0J1K1hNcmlpZlR2dDNqSWQ3UTBuQUtwRVIzcEpa?=
 =?utf-8?B?dHFUSVgrMzdjZk01dnhaM2x4c3FBcjcwUG9xVndlMS9VN2tWb1E5ZWR5ampx?=
 =?utf-8?B?TTZ1TERNTXJSeThGMXVmelpjQ3BONmIwWWJ4QWw2L0RsUkFFQzY4OG1TSEFj?=
 =?utf-8?B?QXY4bUMwVFRIcXAydjFrMjR0RUFrcmQwZ1NqV0o0SVNHTlJZNlZNSTNCV2pG?=
 =?utf-8?B?SXVLMmpaZEU2LzZhSmltVENwbFVHNGVCVWIvY2Q0L3VBSDNrNGxxOFYwUXhT?=
 =?utf-8?B?TjRWTlNVa0NwRUFURkpzMUppY2VEa2dmVnozTFlFNWZVeCtJM043QXVFb0wv?=
 =?utf-8?B?cW5lbW5ZSTF3WitmTEhJWjVISzc2OEtYL0tMWEYvZUhIbWpZa3kzL21qbzY4?=
 =?utf-8?B?KzQ5emM3TUJMTEUxa1dtYWFJY3RLNVB5MnpaNWZFbVVYOG5iNnFXenpzcC9F?=
 =?utf-8?Q?syrKgGA/MZrExFLYzuGpt/BUJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19929f29-a5a8-4dd3-1683-08dbcb02de4a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:08:59.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9r+zBYkg+GQzsGA8PqpJMh+DtUMtcBQJ64eKv+aVKV6jjD6y+LXGEYXsGJi7lP7gMFG2EqdeiD2gyM2uKa3lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7992
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/11 00:58, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 12:51:22AM -0700, Yi Liu wrote:
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 660dc1931dc9..12e12e5563e6 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -14,6 +14,7 @@
>>   #include <linux/err.h>
>>   #include <linux/of.h>
>>   #include <uapi/linux/iommu.h>
>> +#include <uapi/linux/iommufd.h>
> 
> Oh we should definately avoid doing that!
>    
> Maybe this is a good moment to start a new header file exclusively for
> iommu drivers and core subsystem to include?
> 
>   include/linux/iommu-driver.h
> 
> ?
> 
> Put iommu_copy_user_data() and  struct iommu_user_data in there
> 
> Avoid this include in this file.

sure. btw. seems all the user of this API and structure are in the
drivers/iommu directory. can we just putting them in
drivers/iommu/iommu-priv.h?

> 
>>   #define IOMMU_READ	(1 << 0)
>>   #define IOMMU_WRITE	(1 << 1)
>> @@ -227,6 +228,41 @@ struct iommu_iotlb_gather {
>>   	bool			queued;
>>   };
>>   
>> +/**
>> + * struct iommu_user_data - iommu driver specific user space data info
>> + * @uptr: Pointer to the user buffer for copy_from_user()
>> + * @len: The length of the user buffer in bytes
>> + *
>> + * A user space data is an uAPI that is defined in include/uapi/linux/iommufd.h
>> + * Both @uptr and @len should be just copied from an iommufd core uAPI structure
>> + */
>> +struct iommu_user_data {
>> +	void __user *uptr;
>> +	size_t len;
>> +};
> 
> Put the "hwpt_type" in here and just call it type

I assume this is a change related to the above comment to avoid
including uapi/linux/iommufd.h. right?

Just one concern. There are other paths (like cache_invalidate of
this series and Nic's set_dev_data) uses this struct as well. I'm
a bit worrying if it is good to put type here as type is meaningful
for the domain_alloc_user path.

-- 
Regards,
Yi Liu
