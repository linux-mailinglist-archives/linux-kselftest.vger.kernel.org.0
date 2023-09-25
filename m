Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70A77AD03A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 08:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjIYGfu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 02:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjIYGfs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 02:35:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DCCA2;
        Sun, 24 Sep 2023 23:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695623742; x=1727159742;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xGagsF1Rk2xzQMSKMa5GQ2Ig/4EvLy+tCCwsTKGmppU=;
  b=eIfLAhdadhMORIfmkA99NPuWBw8Upgn83RJETHlc2tZHzKFxB7CdiDds
   0j+Vbqmnb7/z/WSYbd5EBbxoRQigvp+WHPgQCG/g7CoBRK8BwilmnJYon
   xvsbm6K4kwJsb3d0q6xBopFA/j3QjKnxNKWCU4H05+9z6eQdIwM2aj8ji
   IDVryr0MO2Gu0zJ+SW8bieWKp3j0O6rr4b+NeZ4F3zHvgnJJtDigAItcX
   3/czDahOPrwf+wTMRU70sMqfD+fsJqUSf9w1QtrFwn6MKbU4Hwt3dhp0V
   day81kNFC3Ixyp5xqdIhwVbhsBzKaikaNR3Pq45ONetCyny6uhin8tvbv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445282316"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445282316"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="724882328"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="724882328"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2023 23:35:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:35:38 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:35:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 23:35:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 23:35:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dD4t9HTct1wjjFviHseo9oDI+//HnJb9YjXXTY+/F65JJ40stK8+tuuC/dyGT4cGyVol11lWPowlfub/eosuC46IDuiNmxsF5ny/79vpXXF5nNdWYTiroVQypoDtmSMaXCm8u1nmtUQfaiNrPV6BHB59QlRQuLFe8/4JDuQ/L697ulENwcDtR7l5twg7cYd23OOdxazsCOJf3eWkHAZkY+C3p8JJDsjHu7ugD9RjZS/12OtvbtWHlNixalqY3YA2xa8kkLTeb22wPUepRueExH4XCFVEfbjS6qQYz7n+6ZLpdo9VaKhulqCjPqd3b1xjqMDpT11pbhJOpeaJsNW2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNKcMLhHipo9yKKcabNL95FAuK6Gp+4EUNROHZ54OR4=;
 b=nMg/5GuWlvjKpjRYaZ5z0cffHUp/l1RVrGcXzV3OyTHMpZ3ootzO8pKcm3TCTxoVEY+beO1mOfTlpceMw5UgpkCjqwZ4t2ZzTI7ER4YP37sfGE9ROgaDH55TdYVa4r+PNaaZ2EWw2UCk0wwC/dKxgRcK8wZmvvExR14JaUSDHlSQe83co1julJORfBsOEfMOZlAuhDjsA8gOR6Ef2DcY70x/293zCiHd7ygn5JgevKfjnrLsSgk+8CgtcBw22l2Ulyom2HbQg74fqCGc48gioUUYyVeBkOlR/5G8D9Jnfb7HGY5tlA8k+Ov+dv3w/KZCtt6iatlxPi2c/Xac6R7ZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6090.namprd11.prod.outlook.com (2603:10b6:930:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Mon, 25 Sep
 2023 06:35:35 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 06:35:34 +0000
Message-ID: <95fb3095-d9a1-6051-8e88-cc25fafc2dd0@intel.com>
Date:   Mon, 25 Sep 2023 14:37:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
 <20230919092523.39286-7-yi.l.liu@intel.com>
 <7aa8fd9e-e43d-db68-bdb6-fe4f891255ca@linux.intel.com>
 <20230920130522.GV13733@nvidia.com>
 <DS0PR11MB7529609BC4574A17ECE469A2C3F9A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <20230920131822.GZ13733@nvidia.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20230920131822.GZ13733@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0205.apcprd04.prod.outlook.com
 (2603:1096:4:187::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: ed83d199-ba0f-44fa-1ab6-08dbbd919f72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktGrTtf6DOBeiNsz9lQFqfQXZtOxYMe6/C/XHr7Wzassl9wOC4BXTj65Dt5B52TlbNjwvtQvyWyZZtTgpEo1BpeGo443YEffsx+B4q0HzLtDFpNHS72RcCtk2VeuAQ8bDQOxqt98zrVPQB18VXvkg3pJPD4SJex/QQmYuuXAh0TNNj3FojSVSJVuSfkNGm5W1ZvGVBiItsc1DkBmyPuzs+441NmyjS5gTjiHkiYqm6qkCzRWyX0XCLcYcN/Mh0NZb7H3CD0NMXlBghG/Vw/nJejpcVve2N071TOYBpnmk8WChlAOf/2vB845Debi0Qci+BNzaqor3ZUxl1Qy30oL758JCiNi4MjLBk3S2yWDY/7SsHiVhLlBqs9wGB61miiTP81Yd4KQ/hiaZJKaKGHm3IluPfPXV9s8tchhzAN4by/VIzcEoeWBTYBJN9BW91lR2o4XHTVGw/xsVt/OQe58QnjFdqq3qjjTQ5rwJoKoH4E9PyaKZKFt0vt52E8Z7a/CJk2RD4WU8vIBBA4T8j0Ozwhacy5okWxUDwUPxjjC9sASHE+0pUAmpFG26dUJrA8f5AMiB131M3JB5ZMPkxOM2a/1XJH5xFif6A3VxNthBE8UtzTEvPmV4ZbFCBrqcPWU4L7YOLoOSv/SObgBfP0aeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(6506007)(6666004)(6512007)(53546011)(6486002)(36756003)(54906003)(478600001)(5660300002)(8936002)(2616005)(66556008)(66946007)(316002)(7416002)(2906002)(26005)(8676002)(4326008)(66476007)(31696002)(41300700001)(6916009)(38100700002)(82960400001)(86362001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU0rUkdYS2RRRDlXTm0yVmg1YUJXZjZJOGlpYlR3bmxpbHEyM2FWSmp6Tm9C?=
 =?utf-8?B?bGtJUjRHNWNLeTRDcDBsTWxyejJxTEt6dGUvbUN2V1dBSFhWdmUxS1ZQN2E2?=
 =?utf-8?B?ZkV3ZGFSZzVUcDliamMrS3o5WVpJUU1TaGxscGU0NU4ybGUyS1k3ME54TUpW?=
 =?utf-8?B?bks3aG43SmVrdklTRVVVWTRsZHJDOHRBbHlUZFJBVjYvL2hCT3dvYStRVEsx?=
 =?utf-8?B?SGhLN0Q0SDU5ZkVDTys0V3V5cUlyZTFaWTdGUFVCcDFLMmhuR1FLamxMbWtC?=
 =?utf-8?B?MUlHUnBVb05DemJ5Y2t6UTNqUkdEUDBoSExHS2t4UUJGZ3JFUHpsYURXWC9D?=
 =?utf-8?B?N0k3b3BJQkY0eisxSk9GN0lwZkV2cHFQV3REazExVTl2bkdhcTdOMXVnbzhm?=
 =?utf-8?B?UG82UjQrbGtrK000bmdGaGs1VjJsSlhJaStEZGNpUHVXNW1MYllUZEo5TlRB?=
 =?utf-8?B?ZzRSM0pzWGRCc0dzd09WS0J4di9laDRZSS9SUWVLTmRnTWwwcU9qRVZLVzNZ?=
 =?utf-8?B?VzNJV1JEbk1YaVFETkplQ2VXMTFPdTducktVanN5R2E5RGNrTTNaczR3eVBw?=
 =?utf-8?B?T3ovalhOVjhqUlVOcU9sWVYvS3lFNkxDL2tHcFAyTlkwUXhCbGVYN3B6YjdH?=
 =?utf-8?B?TGR1MVJaNitvMzNBbXFYdllQd3A1c1hCdzhHOEp0UlRReUMxZUo0akpOZmdl?=
 =?utf-8?B?UjdvbWVqbFpUc1cyU3ZuK2wwdkdpNFE3M2JSb2k3T1lmUGoyTzRnWCs0Tklj?=
 =?utf-8?B?VWdMdFBnWXViQjQ3aEpDZU9tZFRsY3hvTk02cWJFdnlqZVdVaE8zMk12WDVy?=
 =?utf-8?B?RUxjNXlJQWphWDJqTXBoZ3ZBY0tkSEFSR1lEaXN5OFRnZm5kT3puK2tWUkE3?=
 =?utf-8?B?YkRTQkl4aCt0TUpNTHJBS3ZUeityTytFdml4OFJ2TmNaZE9haHBOY0Y1V2xy?=
 =?utf-8?B?SDNWTEI4RUl6NjgzbWlLQTVPTTZmMUx1TVBZMXdVeW1UQzNyTGMwYkFIaEdB?=
 =?utf-8?B?aUowZjcvSlE4M1NnTm5YNVV1NkhJWTNDWkFJdklyVnA1NDIwaWF5RWVNWWwx?=
 =?utf-8?B?QlBocmd1UEhuVnBSNXlQcVZJbkVUY05vUzdtN3pJSkR5SUJUY3lVYjdSVGx3?=
 =?utf-8?B?UEhwako4elg4NGNtbHI2UUVSRWVJR2tOTFpBUm1QRVVrN0QyMFNyYkY2SWha?=
 =?utf-8?B?cG0zQjJwNjAxOFU1M0QvaEJBY1B6eXF6ODZnMkc3eUwydnVnc04zcjFHVmoz?=
 =?utf-8?B?TlFvMERyc0FUYVNHWVEvYXVBUnRpZnlSSUNDbERPMXFaaUFsTzdDYVdhdXNV?=
 =?utf-8?B?M0JpN3BwMEtDMitwS0l5R29oM1hhVjhjWkNsYjNDNWpZQktVMVFJYjBLSytt?=
 =?utf-8?B?QmhXVnhNcUlZQmlVRFgyQXVXZUl3VzQrZEZaYjNQcXFSOVVOK3F6YVc1b0cz?=
 =?utf-8?B?WXdhQ2V3TVEzdFpnNUJLY2IxaXFINGlzSk9DMlRsQ3k4TnJpSWUvbm15dDJz?=
 =?utf-8?B?NGI2cnphS1dXZ2JZeUUrKytUL3hQZ3Bkd2EwNFgwSnVBSUFtRWphOW1aUE9E?=
 =?utf-8?B?UmptNXp2bzNSMVZhMitTRGlQTjNHaTlJUFJBeTNzNi9WUlpua1JWNy8vdEdu?=
 =?utf-8?B?UlNLQmNWZ2FxbVY2cjlvdUFjYnNzZmM1UWxwMWZIWEJ3TDdHN3lubWpWQXE1?=
 =?utf-8?B?d1lmTDZnYW5EbUR6RndQVzlwMFo0Z0tBVFNzaVp1ampOK0czelY2V1hoSkFW?=
 =?utf-8?B?SFB1OWJ1TUtZMzNjcG1YZ2UrOVo1WGtQcjZJMk9XakZUUmlNU0JxT09RS09D?=
 =?utf-8?B?TU9KMDIvMXdOTy9sTFFIVCtQUGJwOXdCcFJXaDYvQ3F3TXBWcEFJazNZdnh3?=
 =?utf-8?B?ZkVaK21RS0lNblpZNnU0N1p6R2N2VWd0eTkzd3g1Mk15ZGp5WEFML3o3dDNL?=
 =?utf-8?B?RlFWQ3RKWWIwSWhQdGRuYXlua05kb2JqYzUxSGE0Z2VnNWlyVkdFUk1qY1B6?=
 =?utf-8?B?akcyV00rRVo0cCtWZWtyWG5IZmNXWU5kaGt4UWRtQUd6K1M1aWExTC92K3FR?=
 =?utf-8?B?RkQ2M1NDTFBpa2hTSTBlZFFtdEpZN29Dd3RhWVY5b2s1SHRaWm93OE0rYWhP?=
 =?utf-8?Q?Qd+q1Vn7QrHsF02swm0OLVewX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed83d199-ba0f-44fa-1ab6-08dbbd919f72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 06:35:34.9298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVK9jdlW3d7C+tJH1h8VqSngSylcnjTgmiwjFYgZ5464nIlNj9yeKnsGLmUx6bCACxPcXuCRYo4mBgD8eaSDLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/20 21:18, Jason Gunthorpe wrote:
> On Wed, Sep 20, 2023 at 01:10:04PM +0000, Liu, Yi L wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>> Sent: Wednesday, September 20, 2023 9:05 PM
>>>
>>> On Wed, Sep 20, 2023 at 01:28:41PM +0800, Baolu Lu wrote:
>>>>>
>>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>>> index 5db283c17e0d..491bcde1ff96 100644
>>>>> --- a/drivers/iommu/intel/iommu.c
>>>>> +++ b/drivers/iommu/intel/iommu.c
>>>>> @@ -4074,6 +4074,25 @@ static struct iommu_domain
>>> *intel_iommu_domain_alloc(unsigned type)
>>>>>    	return NULL;
>>>>>    }
>>>>> +static struct iommu_domain *
>>>>> +intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
>>>>> +{
>>>>> +	struct iommu_domain *domain;
>>>>> +	struct intel_iommu *iommu;
>>>>> +
>>>>> +	iommu = device_to_iommu(dev, NULL, NULL);
>>>>> +	if (!iommu)
>>>>> +		return ERR_PTR(-ENODEV);
>>>>> +
>>>>> +	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu-
>>>> ecap))
>>>>> +		return ERR_PTR(-EOPNOTSUPP);
>>>
>>> There is a check missing for supported flags
>>>
>>>   if (flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT))
>>> 	return ERR_PTR(-EOPNOTSUPP);
>>
>> Well, the iommufd has such check. But I also noticed your another
>> reply to Weijiang. So your preference is to do the flags validation
>> in iommu driver instead of iommufd. Isn't it?
> 
> The core code should check that only kernel known bits are set
> 
> The driver code should check that only driver supported bits are set.
> 
> Today there is only one bit so the checks are the same code.
> 
> Tomorrow when we add a new bit the checks will not be the same

fair enough. I'll have the check in both core and iommu driver.

    if (flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT))
  	return ERR_PTR(-EOPNOTSUPP);


-- 
Regards,
Yi Liu
