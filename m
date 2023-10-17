Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4937CB965
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 05:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjJQDqe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 23:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQDqd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 23:46:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FA19E;
        Mon, 16 Oct 2023 20:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697514391; x=1729050391;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0AJPLBHdJkK/ogkWUIprcubAgXXwP1TU5Bm+V9Rz5zY=;
  b=b/U8TzHp769aV59xvDD9CW5FjcCXjEsAiyxFUR3yareAI3oqNJD56my9
   f0WCj0xsbYhVudXbwKHpuUP+AQaaSNFXRZwvITJF0zsC2QFbjQoNYCC1P
   Bybjh8sT05riWPp0OIatokpMvbxxpY/MrA9u3+rSRsdPjVcTmkjzoBX1C
   faOStyZd230ww7IG0jgwv4h+kQS930pVXDZ5I+i5VRICPhaCf2zWKGX6a
   kmVYqFx5qCl1Vt3/NLEesNOhyGoO8kF9AiLRdDmHYq4T/cfo6dHUgATgq
   k7qY76mtIKIgHDw8R6CoM24yr4b5lvMvtD6XpTsqGbK5hcMaOZIiY22ME
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365044689"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="365044689"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 20:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="3914051"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 20:46:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 20:46:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 20:46:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 20:46:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvPOWcmcF9kGPnZ7MHGQzHJcrYbjCff9Ym9KWh9mNoxEn8//OTGtNrTbkKGb+Mv/L4OQw+1Gbmtwgn7D9EnstTghIQH5b44HgpsJ+peP0fnfifbDE7t2FiMnnR3hVNuOXM71t2weN2F00WPLvC4ch8BicqniY1DTZ3F1t4QMV1hS166iBXf20OLCpUS8oguFn2yEfcSXPxFc5SikTpWnmJUykbTEuVGR4QV7V5TbeQrsSodp9i2Y8tvS+c4XAOcYzYcVPxH7Dw6FGkdvnT58xtCu/wycjHWMlUd3nyx2jafruHUdrnHKXW+aQMRuFtNzHV21GBcb9+58saA3J5GOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1SclMYZqWJ6qlawXWufltoaF+uS5u33SVabM67LWVs=;
 b=Wwjdkzgft2KY1Ci6j153HNSeLWAM0uH0MgnQ9U1hLbs2QnEdQtyZ+mNn+dtB0oHNkWdVg6RrP2I7CyvpzP+PcBrKuwxEJeeZPMbsh0jtLs+zhUHiD/oMhe656QP4PdJK0VCAFAWQkxyZeg2iBnRmY75bsupMWNjAOf712fOc9PqYnRPGKcqHIb03TolC2oRKnToUXCHpG0zNVNc887f/J4B8tQIW3pUrudMNGidIBl3yP/Y5FRrh9+1mfXAg6nW19YGaHLkbX4EhtVcLAfyilCwdxZ91DQV12vk4Q5O6SwPglqd+pVNZPusiCwXqQfkZMlCkUxm5r7Dd1V+EHRTkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 03:46:25 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::8df:98a8:95d7:5bf4]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::8df:98a8:95d7:5bf4%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 03:46:25 +0000
Message-ID: <9982749e-b6c4-43d6-cea0-2da5abb3ed17@intel.com>
Date:   Tue, 17 Oct 2023 11:46:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/6] iommufd/hw_pagetable: Use domain_alloc_user op for
 domain allocation
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
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
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-3-yi.l.liu@intel.com>
 <00163e5f-1a5a-a5c6-baa1-12b2a97e12b7@intel.com>
 <ZS13WVj4wpHeNeKP@Asurada-Nvidia>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <ZS13WVj4wpHeNeKP@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:802:19::31) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|PH8PR11MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c1e438-5379-4749-6c82-08dbcec3a326
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F92F35tFaOJaNsQcSKy+fcDzpfdV8CF4et50za/ihmS4kcGORW+h4oZCWgQ6PNXZ2B9jYeNoMBPhUnv+OVJHIWS5b44qYhcaZt7DAT/yEhdOVn06GmQ5dxO2Xu22ZKcsD+46oSp2Zi7K6G9CEn/xEY9RS4xalhhIoo0FLExl9ZpExdStniWLfZIreo1O8S5gJCEV2UAxhrpaB39ZiUkybuBMTfd4UZqpT6jjrtoIKtI3/GNgK9I0dJCTbubOonL9KgE60c1iiiavRUntWiKbaJh9ytomqnctzzz0w8F7dSWAjrbBWCBwm+CENtTQZwJUR+PQGd2Zl+Qh1NHq/zjgC5Djo0vmX69O1oYaGA6gfss5QoQzkp0dLUCMc8V0GTa7CbWKrajnlUX1RPx35Gnz6P3yJZTWcy11dBI9KenvDos89v4OvMimQBvqms0HlgVg8FX2VhMGE/OxpJM+6ilAynEUAGLI8ZCV+W4lg8sl3LHKwqNzaNhCzjU8Va3nwJZRBygUY1TP5YjtYtcjgJ6/F9bR7D/zS1Omh53PrBd+k/Q8tImBxiZIJ/8oFvzZertAKZP6buU6C4e3XGJofcl2KHbNy+DCbsMVD8RfdEiohdfelFkP1BIgCFDfBPzLW7ac
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6506007)(53546011)(5660300002)(6666004)(2906002)(26005)(36756003)(2616005)(83380400001)(4744005)(82960400001)(38100700002)(86362001)(6512007)(31696002)(7416002)(478600001)(6486002)(966005)(41300700001)(6916009)(316002)(66556008)(66476007)(66946007)(31686004)(4326008)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUFhakZEbStLd1pUK0cvU0V0Y1hIMWNzS0VBWWprcUw0ZUxNSkxDQ3l0WFBG?=
 =?utf-8?B?d1VKSXYrNFNHdTMyRTE1WG00QnJYbk5icCtLRkZFd2xUUWUxZzFzZERPU29S?=
 =?utf-8?B?WGVMNDhJb2ZtcVhLYnFvaktWS0dBZjg4SHJoNWlWZWdyMkRQR2dMcTdWUUxH?=
 =?utf-8?B?VW5rRVZOU2RMMUpOYkhxTUo0NHdQQnFhMW9jZ3BWa0dkU3JFdjdTdktLZk9t?=
 =?utf-8?B?MGwyYW16VGhmVnpqMUFhemlpaURDdi9Tekl2TG5nRkVUb2Ezc3JDd3RCa0M5?=
 =?utf-8?B?NHIrSXZtNE5ZQ2NJMzdadWJiQy9KOGpYMTcrenZGcWF2MDdVUzYxTkJQTzNB?=
 =?utf-8?B?YmFlNTIzQmNGcDBDcUozSDZEZXRCTDcydzZwdmh2QWlQK1NhVm5YSUd5Qlp0?=
 =?utf-8?B?UHUzYlg5UTF5ZHhrd0g0U2lKRmJiVFMyN1JKSWRjTVpyU2M5cCt0M1ZCN1NK?=
 =?utf-8?B?S1ZpaXNSQ1h0QUQxMlFWSXNQaVNYWVBTbDhQS0JROG5uUGxjUEpqRVNkVlNw?=
 =?utf-8?B?MEhjZ3A3RW5xb2J6WG82WUJPaE11MnlWUW9sVWpvakYyNlpwdFlYK0ZpMFZL?=
 =?utf-8?B?UW5wcVBMWmVXaWR1MUlpOXA5U09SWTJFM01OKy9vUmY0RnM4R3ZOREFWbjZN?=
 =?utf-8?B?MGRyaVNEQ0JBME42NEhiQWpTZ0lieW4wQmZIUW44TURUMXBmc0hHYk5IcEtr?=
 =?utf-8?B?S0FxbmcvTENTYmxscVN3aEtlcWdZTHFSVW1IV2FmSDRrc2doZkhSbklWUHdE?=
 =?utf-8?B?aUM5dUxCV20reFkwaThzd0FyaU0rNEdlUnpTQVd6Qnd3eHRva3JZSjNLamI2?=
 =?utf-8?B?N1BNY3QwQWZXd1EzSVhQVytKZU5LSU1Sck1XQXFqMG1iUHp0R1dZWGxrRk1W?=
 =?utf-8?B?dElTbWRxUm1ZUFpmUEpUbFRRSjI0blVJZ2hoL1lRUzRySmVLd0FGODBiRDdW?=
 =?utf-8?B?RWxob2NNY0FjLzJNMFRGdDJKMU9tTTJ2azU3cldWTkk5d2hoR2c5cmllVEIw?=
 =?utf-8?B?M0hCWi9SS2kvZUpjNjhORGoyQ1owMmpKRndMbDBQaG9ReXRpYU9YdlY2ZnRW?=
 =?utf-8?B?V2JQbFNiRU1yS0RkclhKZjFmdFFDMUhzc0pYa2ZoOU5iem4weUxVYnBoTDM5?=
 =?utf-8?B?K2RubktrOU85MjdWZEpreHhxV1ZjZWRtNk43VWZ1aWlWVmZXTzZHVXFNQzJh?=
 =?utf-8?B?aXBrM0s2a0pVdGF3UVJDRnhCeXVrTXhnSldrYVlhNklwbkJwMEppY0ovd3lM?=
 =?utf-8?B?aS9Rcmt1UUpMRlZ2QTBuK1dsMHc1UlVqbVZMVXY5SWphSGhodnJMK3h2Si9E?=
 =?utf-8?B?QkFnUWZOKzdzc0V3ancralo4bVRCeFVxLzNqcHdnVG1ibDBsZ3REbTI1LzFO?=
 =?utf-8?B?d0RTMjE0R1p5Y2dQZEI2NXVxRndrSVJVb243KzA2dElmdmlzeStyQnBBRWFr?=
 =?utf-8?B?S1daNzM1YVdJUFBTNHBQRi8yUnRRZlV2UGpMbHpHWTlrQTNzQ1RXeGxYWE9Y?=
 =?utf-8?B?ZG52L1dXU0VxVkZ5V1VVMkoxS2hiTzdyTFJ6bWJxbDZhdFJReGhUVzMzb056?=
 =?utf-8?B?cEdqcUNKZ0dCaFZPZFBSM3R3Y3YxZHBHRElRWHdDRmk0UWszcEVIVkUxRTVh?=
 =?utf-8?B?blovdUFTSDFhZEROL0JMY2JmTnJkZ1Mvc2IwYUNLbDhjOS9YRy83RVlMZDVi?=
 =?utf-8?B?S0krRDdBRmdkYUtmSWcyQjB0U3FoN0tVS0lkL0tId0R2RDBIR0pwSHNDODR0?=
 =?utf-8?B?alRWZmsrdmlnV2FwOWZIZVcxRTJFTFlzL0kzckthYWtQdmxPYjZWZy9UbFFS?=
 =?utf-8?B?WGhlU0dZNXZhTGlhNSt1dVQ2RHZveGZWZFBocUYxc2l1OURjNjBIcnROc0po?=
 =?utf-8?B?T3JjbDcrSUpSYk5YOFpSSDNkWTE4THhmK3BuTmxXTUJsd3RCejZJRUZZWjNo?=
 =?utf-8?B?QTd5dmQxTkgzZzBiclZqVWhhQWZHTjc2ajVmVk5laTIveVhNYmJFaE1jbnBC?=
 =?utf-8?B?KzJaMmovVXl0ZS9Pcm4wYzhUNjBnTnFmeDFMdHl5T01mSndpVEY4NWZqRENm?=
 =?utf-8?B?aUR4SmdJUUJwNUpxTTJiNnQwS25CSVE3RlJhQ3Z3QXc5QmdDMEtmZERrTUJ6?=
 =?utf-8?Q?k3pood9V6p87jSCq9Yl9QkPor?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c1e438-5379-4749-6c82-08dbcec3a326
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 03:46:25.7747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7yk/hacpGzfaA+nQvX/9isDgGaq05K420o30jkoivwzd78ob3DCgNFAq4ZnR0htr633MGpCnXptDaodUybeGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8013
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


On 10/17/2023 1:48 AM, Nicolin Chen wrote:
> On Mon, Oct 16, 2023 at 04:16:05PM +0800, Liu, Jingqi wrote:
>   
>> @@ -88,10 +90,19 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>>         refcount_inc(&ioas->obj.users);
>>         hwpt->ioas = ioas;
>>
>> -       hwpt->domain = iommu_domain_alloc(idev->dev->bus);
>> -       if (!hwpt->domain) {
>> -               rc = -ENOMEM;
>> -               goto out_abort;
>> +       if (ops->domain_alloc_user) {
>> +               hwpt->domain = ops->domain_alloc_user(idev->dev, 0);
>>
>> Seems a "flags" parameter needs to be passed to 'domain_alloc_user()'.
>> Like this:
>>          hwpt->domain = ops->domain_alloc_user(idev->dev, flags);
> 
> There's no "flags" parameter until the following PATCH-3:
> https://lore.kernel.org/linux-iommu/20230928071528.26258-4-yi.l.liu@intel.com/
> 
Yes. I had noticed that "flags" parameter is added in PATCH-3.
Thanks for your clarification.

BR,
Jingqi

> Thanks
> Nicolin
