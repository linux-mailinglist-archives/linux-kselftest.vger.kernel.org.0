Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF150EC8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 01:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbiDYXYD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 19:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237390AbiDYXYA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 19:24:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC75B193CB;
        Mon, 25 Apr 2022 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650928855; x=1682464855;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pusQKFfKlitH8vv+PbtJauKBDvkr4MHXyQUM9ohc5d0=;
  b=bLvBhhS5FOuMyMdbsUN6af1gsfzis3RD7OtlQyMynnt2zQJ0s86LHfc6
   Y4TLqyhIC/VSxriX1Fv3DoPo7IfZwAf00FBf94IgsA4+lBXhEne/7fMG9
   fipqwkDbrvmd7Uc+SmOrcjanH1l9uTvSWXbehToI0rxglIa2PFGvE2YEE
   z6cVZy0/rYTUvpESe4p8M7oZBT4bS+t9rPoIHIzGr6LrWDHGh+x6IXhuK
   nFECGpnc9ilz5L2lltaTq54RrPn/YLJD7OZNZcJEd1yfwK74FPMdtFee6
   pQ8koCQCxArcFsDgN+nqsGE4fIfyN6d55qtGsY6M4flDZpwmziKxtSy5F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245315742"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="245315742"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 16:20:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="532352782"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 25 Apr 2022 16:20:55 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 16:20:54 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 16:20:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 16:20:54 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 16:20:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3gTAdXaz0QV9Wa9mypP8lNcjtTNv1jgIdNv+KxkROJlEHgNo5E2yLzoRc5+DgdX6eJI1fSBnzmCCDxV582mGOB3BOChVbdXLMT0jVEF1aAdjX+SVR/xTiEWs2oCBc/bmNnzNMCjfmqgRKlDPK9u14yxxCUrFR2KpqJnDn0MnytSnIXWyt6ohrwtIpWNmP+CvhxAzi1jIGnTg+qgc7NOmtIuN5DbNOPtgJHt+vUKUNnaswTaXT3uriN8P4uzV+COsWjsJOg3JZ49ouzLn2m2kv8jzkuzp+ySmUkueOhLhF02hSOpn7GrgNVx37qx9rVUZGO/fM8kHmqPp+sKy2Tspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pusQKFfKlitH8vv+PbtJauKBDvkr4MHXyQUM9ohc5d0=;
 b=GL69mcEQd6t9gGArnC6RJj5vR/SXrteoxM+nEfeuPhd95qKZ2pnY9IYNDAJQpAU7Cmron32rD6Gy01igikd69OTItVoY6vPT6eXP5x1pIozcX4s5NgbAvLwtYgwTBiRAw3EUKKzEfpoTObztZ8aQGMt7yTUqhkyEiLtBVnvjtGeSzfvWdt9CKM/0z50QGTxyPp2ExuobzP7U56Dxvf7fLrVdRWHWmZz7oy53jKRaNUNufcZ9pSKGmEbD+tE3sG4+CSjemPHeG01QjYViwKFxBN7POLPFBj3+rQXkSAsiIoBRD/TpXuIJqcORrJSqhvckHfi5X+YSjzt6/fFfvVPHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB4218.namprd11.prod.outlook.com (2603:10b6:5:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Mon, 25 Apr
 2022 23:20:52 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 23:20:52 +0000
Message-ID: <63386b10-fcc4-0672-4e0e-5d68f8c3b422@intel.com>
Date:   Mon, 25 Apr 2022 16:20:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH v5 0/2] selftests/resctrl: Print a message if the result
 of MBM&CMT tests is failed on Intel CPU
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220323080928.1586408-1-tan.shaopeng@jp.fujitsu.com>
 <1920a6b6-bc1b-31db-4c1b-efccc189daa5@linuxfoundation.org>
 <9a1d0420-d99a-e4a8-c6de-729b56e9c1f0@intel.com>
 <488995ee-2a00-321c-126f-8ed7f8b82635@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <488995ee-2a00-321c-126f-8ed7f8b82635@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:334::19) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37a42273-66c6-48de-e6ec-08da27123d7d
X-MS-TrafficTypeDiagnostic: DM6PR11MB4218:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB421853EE41CD5DB4A5DC2F59F8F89@DM6PR11MB4218.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OqGE+qhd9g+ldHXBZnPYaLSxLAds6qlKD/SST1TBU9WDYQ1sZII1KJFVnANJ9HmbuvhFRs/mHqOiZ8o4s/BC2Octg4F7qYxDWL2IUsEK/VRMmB8YioZyqE9udyX/LXYJGhw9LNJuKvcTd5/6J+z3yglwOgJvtUvuab+H7m1HGKZDWoaIYPgwAiwbFQG9wyjDNl0XE9kBvlumCKOM73g0mlSgij64UkYq/IH1dBes/bxuaff7RSYefYdQDG7viQW9sMaaeU6p61i7JqP4HhzPi0u9V0Xo6qPGcoQU2r4/dnzeKbTrqjS7EfO1uXw0Zz83lBw6sUbTuLVz5vonTqL2Ksw+Gk/OVf1CKahl5ab5UNVhUO0R+5+Vcy9vWndd2jKom2LWUQ0Zxpykn/bRLh1d7Bmt3OO0c++Y8c7TmJ3aDZX3+YJCvQUZ8u8Q+oWQtpsBtaoC1nlfElXqJ1/vrM2CEHpxdp1pUorB+nCiPbkW0tYLiRjOgAWRk10xYExHVF5YsewLK56ZqDf+xddhaL19gKmZ6jojrFTGKTG/YN5rxJDN8+PA4yPcS+jkKoAcSH2TNXuztHuERdI7eypPGfRENB6uPtm/vQOtJeFSEfSw0NJjbvjKjK5BFZ86N+WCpSLhH4XijgUN4WAlPGjRsRD0G1PIrcBwp4lLH0KlEuol8fPHBVKqypNKgvGKR/+Vi0dNLunVem7Z1XnxaVgf5cjFeWKkn5+MaNWhJKBi1h0LqK/FSD9F/lqcDojMkSuCLGB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(44832011)(38100700002)(186003)(508600001)(6486002)(8676002)(36756003)(4326008)(31686004)(31696002)(66946007)(66476007)(66556008)(2906002)(8936002)(4744005)(2616005)(26005)(5660300002)(316002)(6512007)(6666004)(53546011)(6506007)(82960400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2VqWkF5MFNTR0ZSS3dVVWJObCtuT2t4VnN6UkZjOW5Tc083NGdERkJ6Qlhv?=
 =?utf-8?B?U2NqK2hwbXR2OWZtTGZqV0w0T29RcHZzbDNOM3lOY3BzYW80UnNoMlJjN1ZT?=
 =?utf-8?B?U1BSS0lyck1ZVUVCMFFqdmwwNHhrYXExNUhvUm5rQUpzMXREK0pSeThXVkRM?=
 =?utf-8?B?cENPNWpGSWVpck9UWmFtSjhGOHFLWlJTUlE4M2pCUTdjVkx6U3hXZnNlQmNF?=
 =?utf-8?B?Z0ZDa25DQlFkQ2gydjhGYWpRN0crbGNkZEpsQVY4N0FKbytMV0ErYXpDT1pR?=
 =?utf-8?B?RGZCQzR5aERhYi8rSDNIcTJYVDh0cllDV3JDZ3JkbEI1dmJ2RDhxWDlwcnh2?=
 =?utf-8?B?Z3dEaXhOdmN3c3BhQVlUWmMvVHRsRW1EZ3MxcFZWQUJod1A5N1VjWEZZQzJ0?=
 =?utf-8?B?QU1HcU10MXd0c2NGdXRkSjJJcXhadHFtY1hmSzloYUFJSVViV2NILzNzOFJV?=
 =?utf-8?B?K2RZSU43dUJyeTdPOVZaYmJFcXNaMHpxVzJXa0NlbithWXhmTTZIVjR3Rzg4?=
 =?utf-8?B?RWZ0YzBzTnRuOUdyYWt1ai8yc2tHemZuTnFNTVdXdW8vUndMQkRMaWNlZnBv?=
 =?utf-8?B?WHZWVmdoWTBSOXozL2Rqc3d0NXdBblVraENTVVNHM0J6YVVhc3BkRVpmRjdM?=
 =?utf-8?B?TjlMYkUwei9oZjY4NXdGMm9JMWFVTkYySnZ4RzFQV21JUFRvWHBmTzYyeEwr?=
 =?utf-8?B?S1F0dndrWE1scjg5SVhxK3hxWXRjYncwZC84NXhuZE8xaVFCMDhXWDhwcUpD?=
 =?utf-8?B?R2hBYkczVkJTWk91MzQwaEJtTnQ3V29rZkJNbG5pWmFVWEoyQVE2VEkrQzRy?=
 =?utf-8?B?TmZCd3krUTJ1VG85TVFPQjVReC9sRDRqaHdxVk5oZ0N4RVFwS1ZycTk4THJN?=
 =?utf-8?B?em5kdzBPaWw4WEZhTFVDUjJNRUhkYWpRM0ZmRnBYVVpRODkyNGgzZFNIakl5?=
 =?utf-8?B?aHh4Z2hBNm9CZml1NWRVY3FmUkYweHN0eEdhM3dmMzFVNXd6RHBrQVBhMHBE?=
 =?utf-8?B?SDNyZmZjb05iR3pJQysvUlRrakFPNmlOT0gyWkV6Z1pIVE1jYk9mSXRKSUxr?=
 =?utf-8?B?MzFuK1gvTGFIcmVYNjcydW5aY0pVck5aYnQ3TEdNdWlWUER1UnJJVm9Uei9D?=
 =?utf-8?B?VTZ3N0xsby93VXFiTVJOd3FtZU43NGNUQUlrY20yY1EyUlZ2R1FNT3R1Z3NV?=
 =?utf-8?B?b1FBVlV3R25vOEROalNiSExuKy80YUZQWUYzMW5KbEpJbHZPbjZkVklXbGYv?=
 =?utf-8?B?bEVOU1hLL0lvZ0podGVSU1NvWXFIVTVvUUhtV1E3a3N6KzUwUDFGKzlaYnNR?=
 =?utf-8?B?bUJhVldDNFBteW1tcmMyd0wxdDF6Q2x1dGNJaWFsT2VGckY2SG42eGlnMElw?=
 =?utf-8?B?Z1hlN0FDaSt6bCtyaFlHNjNXaWpxeFdqUzQ1VjZJbmkxR1lNUXFDRjAyeHNJ?=
 =?utf-8?B?cERWVVJLQ0g0QU1sRzY5djRWWU15NUNwbFZ3WHBCTm4xS3pocUJjRFNkZjlh?=
 =?utf-8?B?WHpHWGQyWjlJTkx1WTF3b21kQSs3alVWOW1EcVZsYzZNYTRmRnQzMWE5SnNZ?=
 =?utf-8?B?Mm5Ua0YwYXJIREc5ZWxMQkxFSVNKR3RXdjNYSW9Ib1cweWFCVTFsSFlrL0gy?=
 =?utf-8?B?QmhacGI5UWRkODhwWmxVSk5EZlE3ODdLZkJLWTZFa3dDRVlmMG1YbWx4ZTBp?=
 =?utf-8?B?NUdFV3NxcU9UM3dXQXdsSmVudnpLTkJwZGhNWUxPS2VDK0liNk1LeGVvTExV?=
 =?utf-8?B?SUlMZEdrdlUvdE4wNXZJc1FWeFdPcmNYU2ZwVEV2TUhHMWpMNVh6ZjhUKzhD?=
 =?utf-8?B?NE1DQVd0SklNY2tqanBJMTRUMHorckJMeXhKMkZXMzdBUnlzZWl6ZHg1OWlz?=
 =?utf-8?B?NDFteDRESi9aNVJUSnZTTmxzQkRUYkZtN2RMQXJPUTNGZEJRaDY5UnpaTHZ1?=
 =?utf-8?B?RVJpT29XTUxTV0hkTkZYVEhtazB2VW5Cdy9TeUw0Z1QwSTVrZ1pSWFhya25r?=
 =?utf-8?B?dUJjSFU5cTZRdE1KN011TDY1WEwrOEZrMTh1aGFLSzU5TGZDeWlOYzVDeWdJ?=
 =?utf-8?B?QVExUklRT2NnRUMyRlpzY0JSWmJ5N0d2Mmo4L3dEbDlxYlVpZFRDZ1FCOW9u?=
 =?utf-8?B?eFV4VWh0YVFpcFIzMHZnMzR5QytPa09zaG1tWXFvaGwvS2YrNFhqUGdvTUZD?=
 =?utf-8?B?QUxkVHBUdlh5T1hRb2hSejArZDE3MEtuc1R6K2oyTnZkRjZueFZjYXlkS0NH?=
 =?utf-8?B?R2R0R2VrallnMXJQNW13WWJLOGQ3Nm9pOHM3Ykt6bCtaTTZEOGJqem53VHlr?=
 =?utf-8?B?Wkg4Q0w0UDhJdm91Tm9rV3V0Qi9WWE1XVVhiQ1NnTXRpVCsyckdoQUlTaDZY?=
 =?utf-8?Q?eE0DWfZYPeHEFuc8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a42273-66c6-48de-e6ec-08da27123d7d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 23:20:52.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1g+y+9AfENZyO2YowK3RtJ6gHSyqAkOEmgXoCs5zrmP0wCOVu+rAMUHciDqwB8U5qkkDSyn5tiiVlCM9FJHQRgXTMyVdTKxXd9+B0k/IDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4218
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 4/25/2022 4:00 PM, Shuah Khan wrote:
> Thanks for the ping. The changes are a bit more extensive for a fix based
> on my review comments. I queued these two in linux-kselftest next branch
> for 5.19-rc1.

That's great. Thank you very much Shuah. Also thank you for picking up
Shaopeng's other resctrl kselftest series.

Reinette
