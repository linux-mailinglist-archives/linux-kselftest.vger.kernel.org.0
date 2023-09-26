Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4148B7AF6C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 01:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjIZXmj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 19:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjIZXkj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 19:40:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DD118E84;
        Tue, 26 Sep 2023 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695768824; x=1727304824;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=awOAqYWD+mpt+XO6eLi11sTh65jorHAwnxN9uMd3lC8=;
  b=NBdXzOXWPdl2JraTOkjgVLra0N5qq4SnHE9kDqj0CIhjJ1dG6YVPrNWH
   wC+6GCgyeP8RSZ9iShhZy+13B/r7ajj1DXVAjYKD4JSxgDGnuUINYLjiM
   TjdtCTePIMLQEW4gPRZxRvHLpY9d79DYiS0clX0GavKkYW6cbhxCMiMNr
   P66h1RxvTp8AnyH9HZRCq6eaniq95Ae3WFCEEKYC53UweM0PiNjIbmbAF
   XWmnLTasAyzBeMmUxjJsqFiGuEEQqdyZQgU6w/c3YQCHkn6oUZ2YVA2oH
   Pu54svxbpTEJzGlaTpdYDMBmITFKavxBvk5ZU19KfHwpUtP9PNgtFe0xV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="380542090"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="380542090"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 14:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="872647402"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="872647402"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 14:40:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:40:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:40:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 14:40:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 14:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYiTU5hxjfXUOS2eWP8GYJjRaFZuZZ6ktoUiePt6VpCpsBbGBqUTgiDGwyISuF4uS6HZ+HhcJbX1EjkqZpJBJ1HUIS1nDo+gjbBSf44jxXE/7fjbZF16w2SOcZbzTCRy5/zCHM1BhqhDNUAZka0oTKj66ROHBWz6702jiIGah0F6DOWqrrjJGGetUV5PPD5zUCtJvrfKvd/Ovs7aeo4JiMl8hfTF1N7dk26AE8J0X6odmwLFKSDvcrDV87HgK07y3MMLzG965IEqQMSC/n/yjh5/O/5OrsRb6+5odQHS9C+8tpdHTZ9+a6I5ly4OVgXSPp2MI95KOWKSlNkbi9Bawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCem2MqmkQpGkgmK6gfSaL8AV0fkropXytdOirug8PA=;
 b=EM/CFFAC5fORN29f8PPsRIZtX3//auxPX717IL8uIZxWvq5Iipt+6AaDvbCDQv0JqIezS2f4aztVE5KfjkA5DM36Ml3a0rBR7wdzbzhqueLJc2L18EISvza4sJ0z5y3WMv7QNjYdauOIs4mtSXFNCIFa2Cf7sP/FioH2dbb7K0bYZTXH5psyYCCTdD/YEBSXXAgaHV0cvCqgYRkr19bj2EkehZ3y/EhTanvu1iBBbQ3TQ1Hsz3IV6NuayGLvjfZQTRVSIQezEc8ScTQjiqz2PbUE5QKkYRLiSQxTMKUzGTQlQaJFuWj1XQ25NZB1ctAVVAxncphRNCrhf/dcueU1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 21:40:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 21:40:16 +0000
Message-ID: <f72ba71f-07e1-6e1c-9b8f-0724694a79b8@intel.com>
Date:   Tue, 26 Sep 2023 14:40:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/6] selftests/resctrl: Refactor feature check to use
 resource and feature name
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
 <20230915154438.82931-5-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230915154438.82931-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 445d03c7-8e2a-4c62-35dc-08dbbed92c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19ZW4eX+aFnP4m9SVskGAz/FrTqI3hgLkFWMUPRaXtTHQw/tENO3l6nJYSktUTQlYZwsZ84u5Okp0OvzVQrKsM1t++9kD6Kh4cJ0LcgJq1ujqyLoungW4EMh08wgsjfgo7eDU34esOFlixM1n46GRztho8xWz//hY8jX6t/sokihRoBRBWZ3BHXmHYqLl0zllitB+OV2QE9fgmFYX8XApyJrufjfphxmxaumh1WjDiStORsLAtIve45KfHjst4NQ/zljINavLtPSWHccrYuiDgP5dwQi2ChCPcSLSSRo3OeUb9c1UfpfnzT5/jGPc/z2GgCahGmQ0gxzxODKZFJpPpt9q24NxrcrmFSuveBcbspVMbptno5uhcihAYur7M9PHAUecs5JzXJ/QOFVwp3QICBrS6w70BEaWxz1Lv2MSUDoINy5kCB3phvLmBepu9uJF+Nar7FPt5dQOin0t9/VW/Dy+358iEOWktjaha+BepMW4ZiAUStoSEcqd6lkWKqSodLi4L8pdU3FTcIgc/pUMagm86BBgI4e5i8o4WSNGpZ7VVoC/FSVuSBtQdVgT5ysHC94PkEFNQDJ1lp/s0KnZMmDjQt8GOwI+up+EJar67eoJnvdOFtkP2G+lkBr8z0kFClfa9/L1ZJBsdcz1lM7jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(2906002)(86362001)(4744005)(6512007)(6506007)(38100700002)(5660300002)(53546011)(36756003)(83380400001)(6666004)(478600001)(6486002)(82960400001)(66574015)(4326008)(8676002)(8936002)(2616005)(41300700001)(110136005)(44832011)(31686004)(26005)(66476007)(31696002)(54906003)(66946007)(66556008)(6636002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q092V0ViRHVLVENCb3krTWtuUmtnajQ2WnQxSG9kb0pNTzVYZy9hOGJaNDMw?=
 =?utf-8?B?MGMvS3ZlMk9abkdkZWdqMlVoenYwdFFhTlFtcGVhUXF5UkdJbnBlQ3lMaFhY?=
 =?utf-8?B?d1F5ZFhUVFNpbzI5TFh2RUJsbnNYNi93UWswbkUrQmJSQytkUFRTVDVtRFRU?=
 =?utf-8?B?Ui84STArZ1hMWmkwU21JUnFPeWEzOEl3U01OQ281VGlXM0FJU0poNnBqT1hI?=
 =?utf-8?B?cDVsRzJxRFRwWFBZL1dQRmJxWmdoRCs4WEVMd0xnaU1kV3RIM2txb1NKY0g4?=
 =?utf-8?B?cnRDMDNGQlVORzEvYzNxVUxjWlAySUgvRHg2YlVWOEZETzIyL1lRTW10aUhn?=
 =?utf-8?B?aWthUnhlK3ZadmJ0M0ZzeVpyWWxWSTZqcVg5NWFwOHhsL3daUlNHWmZDM20v?=
 =?utf-8?B?NURsWHU1MGpJN2ZDbzN1dzRVQi9GR3hKY1ZuY1VGSEZuQXFraWY0M2V1ekJ2?=
 =?utf-8?B?ZnVFN3FRNTFDSHVjTm5vMHFWaXZ4K256a0E2RDB0RlhiNHpab25QdW9XMlZt?=
 =?utf-8?B?dnN0Mldyd05ucjZBRSsrUVc1aWRwM1BYekw3bkppeXNNRmFtcnJaZHo3QS9D?=
 =?utf-8?B?Qk82TDkwSThmd3I5K2lFYkRuTVhEK3Qxak9sNFVqbHIrek1JdmFIYzA4SGJB?=
 =?utf-8?B?TVQrNjNzL0dma2p3UXV4aTNLbVk3T0Y1dUhKQnJ0d0RQNVBPR1ExamV2S3Yz?=
 =?utf-8?B?aGRrOE9PR05pRW0wL1JoaVZZRXpWdFJxN1o1dmN6MkJpMno4bElxdFRrYldX?=
 =?utf-8?B?UUZ6czkrc3QzaHFsRUdyKzE5Q3ZXaUVZNTd4dkJESTBXbFF3MW9rUUxURGVE?=
 =?utf-8?B?bkRrWGNmTXRKZ3p4dk1Mb3RFQ2lOQmkxN2RObi9SbHluK3VVMDBmZjNZN3R5?=
 =?utf-8?B?Si9DT001cWVUMW5IT1lPMW5peHY2ak51TmRwQ1djZWk5UlRYWENodXBMdGNh?=
 =?utf-8?B?bzByeVJoeXBDanQrR3VQQVVpRkxOMnAzZndMV1oxbngvQVp0YWFVOE1HQ0VQ?=
 =?utf-8?B?OTJ0V1owT1B6RXBKKy9US0k5K2Rqa2FOSXJKaDJLLzZ4eG0wdnB2Q1B1Y25o?=
 =?utf-8?B?dFhDNXI1a2tBekdGZTVqNGE5Q3kvMytmOFM4ZTNsWTdOZUt1b1Y4MG9ScXRV?=
 =?utf-8?B?c1JHSkUwLzIyQlkrTUdUbUt6d2JSSG93MnhJaXg4ZDRkYUt4dXN5Snovb21L?=
 =?utf-8?B?bXNSZG1laWdxOTBWYTQ0dWJEeG4wNjJIWmFsZE14Z05pVTdhbUdJUjkrbm9u?=
 =?utf-8?B?Vy85cTJ6Y0VqQ3htY2lrT2plMTE1TGFDVTRuOTY4S0JkQ2loWHlvVHRMNmRD?=
 =?utf-8?B?L3VqZVRYTGNsZjkvTmlSK0tXeUlHc0llQUNEZWQ0S2tBMTZmQThNbW95Lytu?=
 =?utf-8?B?Wm84MXh0bUtjMVlKampPWnZER1l1S2RjMG5PN2hMYmNwc1VlNVM5dGFDVDRU?=
 =?utf-8?B?K3pIbm5GaEkxTURJK1pSbUF6QytzUEkwSFFkL2FuYjZsUEZLVW5Gck4rK0Zz?=
 =?utf-8?B?NW5tbzB0VzRtRS82d0svMDQxOHdZellQMzlOUi9nYWowVnRKZExLMitCSkRK?=
 =?utf-8?B?M0duQ2lCOGE2TXAvR1QzbmRxRkNaQ1c3ZFZrTEMvOHNTdUlMVytUMUVEQWkx?=
 =?utf-8?B?Ris1NXR6WTZGbURXWUVCOUEwdWw4QzlOYldyVWw4b2E1aFNyTlVkay8razBn?=
 =?utf-8?B?MStQREV0ZzJpZUduUG5WVnFYWDlVWlQ1cGh4RGdKb2pRcHRaak9QUVVxZDhI?=
 =?utf-8?B?ZkZBTUFKSk1YTlRNRDhNajNDSkkyZ3R3QXBjOElNN3NnRk0wN1R3WUNWMEdN?=
 =?utf-8?B?a3c2aEludU02bFVGZFcxbjhFRjludk1hNEIwbnN4R0Z2YzJnOVVIT2wvOE1q?=
 =?utf-8?B?OHRvb3F1RitnNHZBbjJUMlhWKzBYZXp0WVphUEsyTTE1WlZOSHMyNDdEUE9I?=
 =?utf-8?B?NkNnYXN1ZVExZk5EeFhtZW5mYjFKTGhtYXEyTmgwUnljV0xBK2tYVWlwNXdR?=
 =?utf-8?B?MC9uNjJDS1FrdVRGbVV0Mm05SytHUGE0OVkwVEhvSWVxc0gva2U0bUF3bjRC?=
 =?utf-8?B?eTRGZktGUm1uNzNBcndXNEtWWTIwQzFtQm9VREE1VmQvMFdMRjBoZ0NYL1VP?=
 =?utf-8?B?Q3JkTXloMmxibWt4R3NVd3dKcEUzOVMycEtiWjIrWjg4Rzg4RW9GdFN3WlVz?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 445d03c7-8e2a-4c62-35dc-08dbbed92c0c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:40:16.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NK76YHR0tMxLrzG/mmvUldU3w9MzNhQ4XeLmvZ0W2ZjM0qXhUATKXtDKo8kz+tuWubeS6Pi6VE1A7KyHGjfbq9OpJb9MNTxyxDZtNp6RwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8424
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

Hi Ilpo,

On 9/15/2023 8:44 AM, Ilpo Järvinen wrote:
> Feature check in validate_resctrl_feature_request() takes in the test
> name string and maps that to what to check per test.
> 
> Pass resource and feature names to validate_resctrl_feature_request()
> directly rather than deriving them from the test name inside the
> function which makes the feature check easier to extend for new test
> cases.
> 
> Use !! in the return statement to make the boolean conversion more
> obvious even if it is not strictly necessary from correctness point of
> view (to avoid it looking like the function is returning a freed
> pointer).
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org> # selftests/resctrl: Remove duplicate feature check from CMT test
> Cc: <stable@vger.kernel.org> # selftests/resctrl: Move _GNU_SOURCE define into Makefile

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
