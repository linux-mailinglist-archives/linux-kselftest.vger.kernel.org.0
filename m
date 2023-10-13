Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC407C862F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 14:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjJMMzA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 08:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjJMMy7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 08:54:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC1AEB;
        Fri, 13 Oct 2023 05:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697201695; x=1728737695;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=esi9Xao82eR6jpsjR+Fe5hMO9PmoW7IgVc9jFE8yPTI=;
  b=G8CTT55s43dhv+z3ELSjL5p0OqSFlqnrv1QRAipuAFPb7YHap0ZlDuB+
   Oammq7ZgzGX0cTsWKQkqOKxYwEiE05URwdr7J6NPCct08h9WWHDuPu4lN
   6R9PLi7BNvtDcgMUrvy6W3sGXTTX4T4pd2yamGEzTW1F9toRfxfQE38nm
   EF/yVITn/+Pn5/hTqKH2dfVEgsRwAmmxAx+gMkrepikx/XoFJGwpCwi1T
   enLhSFZeq+n/6EHVMDlPTUL/L/gE+9eqi5TAqVKCxKs6DO9oerOxqwAmW
   hCfnX6l7zaXALmkYO0CNMR5zLkla3fuXewThZalo/oKCzdZP8wDAg0yWL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="384038040"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="384038040"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 05:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="898548925"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="898548925"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 05:52:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 05:54:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 05:54:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 05:54:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 05:54:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDh8tndMtCcxvWekg1yj5gcoMSVuByaThSNQsX/MUH2XMgQqe9YASfqMp4WolBEOQeV3b6c8XqxfjAi6gEVvgchtcA+WdvFlyWwkwxdmfj2+s6F4svPZ9/NdMD/JAVRunvHf1jcOYMGkdG1yLfUQAGo45rs/HYCZ0MgJOt566u2lYzFWBClq7vbpAHtJZJFfMgzsA6vtgWgfk8YYLpKv8pYGG/Ro9F85pIaNMl7EDVgOPHRHBuaT6uH1QQZlK50brQND4eMNXtBx3HefFLHR04lCqM2fBdQ6evv2jPXT1gQZWrmnVY1nkafbIZxvuuobGbsc5glUx+1XND65ns5pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCYc6ZJAm2EILpJNKYZpB02umPVmtqrz81m3V85LRTo=;
 b=caXN+jmd9Z5vr+4ptNrzLUoB7d398l//YAkZIP3kRoBf03EE3ehsYwoDSqTWJxd5xIhdTYroayeT7vjIFmZibTdVeMcpD0UXBVFqQPGmeD06l4AIJnauwSK+vIaicODwMcr58wTz/QaQFeyo9C2MkTXktnKtfgLTjvsyvVvUeJ1q7Yei/C8FAKWFX74C9Y4xAL0LMX0lcQZMmlLlx6EcVEPQEVew3uJy8I3Aiay6wQwzijggEDgwsfOu8D5cP8FICrhkv4uwb8qMMaXPN9txKKgwWlR5h5bzRNy4vY3ZoahIYrd68FhYT6r+td6lg+yp6SdnqKS5OpyG1kkgKHpfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.46; Fri, 13 Oct 2023 12:54:32 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 12:54:32 +0000
Message-ID: <9a482d0b-e2f3-116a-1feb-d0b49bc21554@intel.com>
Date:   Fri, 13 Oct 2023 20:56:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v5 09/11] iommu/vt-d: Add iotlb flush for nested domain
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
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-10-yi.l.liu@intel.com>
 <BN9PR11MB52769D0ED40EB2D3D8FB56658CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52769D0ED40EB2D3D8FB56658CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM8PR11MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c146dc6-a4a9-4833-6552-08dbcbeb8b9b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMOJfnc2kE0ewbdKYdlxxBPpQS1/xylYVA7zANTazrLvXuJqMP+qj6DH0FdzGYkGuJyPviVPlmmhi1wBGL7NEM//P0SKjf9Bmjjelu3Q+q765iOvtYbJyKsVz3hzGJ+tGVuwS2M8duEo4bOyn8e0qvbM6wBrHRqLCZ9mK5qXdnZ0yF4f/r0l5kF35/BRQukT8fGUP6MDFdOrK2InfDY3I+THDBKsGc4OruOmGpjSGWaxvGIDNe8sRhqixM5EbgcaggaZWRlAwlvmanTgaJ3HdvoMa3ssBc76M5SdvgWR22VREc+eyeT5y7sksTcFS5/R4geoR4zGiKSUgvJlwmcbEHtaSbJDzyJ1QlfqeOhz8t1kYNVFSeEGQ7wtZ8S25FQPLLiPNw/y05yFk3yK6ZIC4ndHArMa5KhIqrFHr7OK9ZnTW9sJfUy/0QeIB7B3nHYLGUW1LHCJRSXvYWbyjh8EvScM8iDroY/g4Eidl/6TyLs5E4nsDBnEaRXJ7XQuATH/Yq3RSPjhT/PaTkOXsQJUzEDQiWTJm1G/Bbx23QdKcaRZm9DcrG2UkWmnMw0H2PFzkxZsVFXMu11Fok8CejqPgtxuvApiYr0lO8yIR7+hEWF7DFFxzMEKTIbgpNx/3YroryfhXfCCc4oPTquhoYuGYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6666004)(6512007)(6506007)(53546011)(478600001)(6486002)(83380400001)(2616005)(26005)(316002)(2906002)(7416002)(4744005)(41300700001)(54906003)(110136005)(5660300002)(66476007)(4326008)(66946007)(66556008)(8676002)(8936002)(36756003)(31696002)(86362001)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alZjbVZEZjhvNldCcG5qeXErNGpWQjgvMjlhZUVYczlkcUJnUUl4Y3RMTXht?=
 =?utf-8?B?Z0xycE9Yb3FZeGE4Vi9KTkVnK0pCSGxpSkx0SFpUdkdySG54b1BOaXlpRlRY?=
 =?utf-8?B?Sk1QMUtWM0lJZGtCcTRRYk5BaUtkcjg3U0RIY2ZsQmE1YzFCdWVkQ2JEamd6?=
 =?utf-8?B?REx5MGhLTlpiajBaZDJTZnh2NzZyNGNFQWF5N0FMYVBEa0VRUGNkQlJUVmgr?=
 =?utf-8?B?UVphSkd4alFzbW5aWUtWMGF4dDN2Y296UENXK0FnVGhvdnBBdVdYL0ZOdjdY?=
 =?utf-8?B?NW1yOUFVUFArZU12ZmRQTEUyZWhGdGZJMEdMczE4M3JHd1ZobC83eW95YTQw?=
 =?utf-8?B?Ui9RM0FXVGlHY3kwaFRZZFhibi82T3I0OGlSRDEzbUNjUHgyUFM0Kyt4bXZ4?=
 =?utf-8?B?TVNFVStxckJIMXprYno5eVk2a3lmYUYrQTcxZFFkdEQ0V2NRYWgvOUFoWTFY?=
 =?utf-8?B?bEw0cWNnbHNLaW9wVmljM3I1T25JaWQvS3l5S0NrWUdlTld5bVJLQ3dkY000?=
 =?utf-8?B?eE1vdHRGMUVocnVTbTRUYUYyQ1RPNjJsc2dWZ2N0b1N2R3JHa0RLZHRFanNp?=
 =?utf-8?B?SXZqbW5hQmlHMkd2cXFpSHY2T25oejFNbHQ4bGwydEw5TmlVVW81R0VTMURl?=
 =?utf-8?B?c1phdTNNNmkrWW04c0ZGOXFkLzlOcTZlUHVnM2FEUW1BNklCMUZMcjhqR1hD?=
 =?utf-8?B?NW5qQ01lUkxRWFFHSEdSbnZTNDJ5b1N0Ym02QmlFK0tKTmM1VklFeWVkaU5y?=
 =?utf-8?B?TjdXbHlTb2QyQ3lmcDRKUC9kV05hckh2UytXLzdYN0duL210aCtyOEJJNEhH?=
 =?utf-8?B?ZWkyRXFQTVpuTDZUc2hxc0tDMmprWThhUWZqZGRMR1F3MmdHM0tSRVAyOFdx?=
 =?utf-8?B?blZuT3Z0MFp6ZHlxUFRUM0x5Q2gzSFZ5a055QnBYdlpCVDFGU2lnK1BkYWVX?=
 =?utf-8?B?Wnc3WnR0bDNGU3lDaTJObFlpcnRQcHNjS0RXVklZa3EyaVJQbk5Uc3M2ZGtH?=
 =?utf-8?B?UjNBS2ZKVnlCNVhvaHVaS09oN0dxajJOdGRNRkNnM0p4RzVsQkZGVkpOcHNh?=
 =?utf-8?B?b2FNeWl4WTk5ODJuSkwzbTRVOU0xMjlTSGZ6UGxNYm5qb3B3eG4wK1dySytW?=
 =?utf-8?B?YXlaeFM4c010NUo1R2w5M29FZW15YnRUOGxTS0k1cG9GNkIvQ0FCTmZtT2Vl?=
 =?utf-8?B?UWJESzJDNlFvYU95cFhvRHp2dlR6dkZhU3VxcHBkK1ZESmRWMUNta1QvRk14?=
 =?utf-8?B?VzVqV01DRWs0bXNZRG5jUWNSa254bkNMdjRCSStTWVdiUlJ0eFRJcDQ4dUhR?=
 =?utf-8?B?Wmo4K2ZmRnlJeEtUQVRUcHJSelh4MmE3N3NFYXpJNWtEMEhkazBvZHdoU2hU?=
 =?utf-8?B?L2tzRXd4NnRqbGZ6WG8zMWdJYWZ6S2JidEgreVNCT0F2ZHhlZXRPdHlIaFVT?=
 =?utf-8?B?OWFmSEJxandWOFBGNUlkdXZnaVZqbGUxZnZVSVdNak1RRkpUcjNFV0J3Y0tF?=
 =?utf-8?B?QzdxSzhuSTd3citrOCt4R0hGTElPa0FNd3RmRmVMalUvWjJ3dmhFZjRCVC9l?=
 =?utf-8?B?SDVwUFVUbVZYeWpnVnRLQU94MFZDaldNczZ3ZlJCN1lkWDA2aEhTNGJmTE5Y?=
 =?utf-8?B?NkthaVgwam1xanJyRS8wbTdXTWhjN3NrOXBKaGpSSjREZ3UxbDFGRmhyV3Nh?=
 =?utf-8?B?bkZLbmIxWjdSNlAybnMyd3N1UU5WbDdIR3pRb0hOOUI1TnN3OTVCQ2pwRGNP?=
 =?utf-8?B?SWFZaGd5YmdkOE5oUE85MUU1TVRvYU9BdzRzb1ptUE9mSkhOUDl0bTJ0MGt5?=
 =?utf-8?B?MHZyU0JDTWdiWXI2bFNWTGQ2QW0yOUYxU0xTOGx1SEcwRmIwUzRWbFBXYWVS?=
 =?utf-8?B?RU1RNTBzUVlBK0R2RUYza3lOa2FKL1V4a2VJNFdod01FMERBZDlSTUVIMGNH?=
 =?utf-8?B?Nm9CeUgxZCt6K0xYQ0plVkttaGtPVU1nYTFjcDEwV0VXT2dkZkZDODhlSms5?=
 =?utf-8?B?SFQveXBtRXhFZUQ1Q1pzdThxZFN4UG1nRTdvTWVxMFZxM2tSN0Evdk9SVnBt?=
 =?utf-8?B?ZlpVazNwb0RzSmxJdEtSdWRhMTZqOXFxWVRKWExzZitGelhLblB4WEMrNnJ4?=
 =?utf-8?Q?Z7J0jFJdSFa1LTliRJlaDmke1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c146dc6-a4a9-4833-6552-08dbcbeb8b9b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 12:54:32.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubHLoGrG+OJgjP0aCnBfwpQAN3ivTmpXTBrmqRsBIiMTswuQht8YEjuUhVKJ28Qtg1+0bMOWC6D5KCsaSfVSHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5573
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

On 2023/9/27 14:53, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, September 21, 2023 3:54 PM
>> +
>> +	/* REVISIT:
>> +	 * VT-d has defined ITE, ICE, IQE for invalidation failure per hardware,
>> +	 * but no error code yet, so just set the error code to be 0.
>> +	 */
>> +	*cerror_idx = 0;
>> +
> 
> Is it "hardware doesn't provide error code now though it's defined in
> spec" or "intel-iommu driver doesn't retrieve the error code though
> it's provided by the hardware"?

I didn't see vtd spec defines error code for cache invalidation. :(

> 
> Is there guarantee that '0' isn't used for an existing error code or
> won't be used for any new error code later?

may need to check it.

-- 
Regards,
Yi Liu
