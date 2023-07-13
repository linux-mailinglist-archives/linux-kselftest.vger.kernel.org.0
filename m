Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E8E752D43
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 00:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjGMWzj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 18:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjGMWzi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 18:55:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BBA272E;
        Thu, 13 Jul 2023 15:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689288937; x=1720824937;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=qPmiuHz776KRvSSkUbBcGVCOUoHp2tMnd/W6miLgvZk=;
  b=THJc256e7myngaEMCvPLLKxGYuBULUjd4WDYnWRPY1FZRS8lzx3y9/fl
   /JEVwfWB7+bDGS1WQvPrlHFnnCxIptkqwVjtS39fGDy3jvCBsVj5dng8J
   4B92b2OoEQ06uR+ysVqNw85Vhabze4gPTYMZXtCvhD0iUR7Z6V3q626tr
   WIyxDfoZVY38EuH3JthagLuzUZglpk/V9TERCkMQwsIJldPd0K04/LZV/
   LxlQJMt81+JfX3Xu62YhTpV/ab0ThOb6CCNb/AHsjOC/rmLE5+E66n9xE
   vcKn9IRBuijZIuKN/9P2GYpwIhTj3Cs9Ti8hH7TObloRt6bvwCFgcRKho
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="344930426"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="344930426"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 15:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="787638960"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="787638960"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jul 2023 15:55:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 15:55:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 15:55:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 15:55:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 15:55:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsUrGikrv6KE8LUvtqzimEXKRgDVe0GurYMLULKeLUaQDQ4hF+wT7cxgvOd9BpU6cZY9SUOXeQy/6ZdmiRMW7S8hXAoXZodS4w63sdW5z+y2f9gLLSnyfKxhyBOhd/9sqnZhpJhJ2ivVsXM2uh/nWoY5oNcJDGDVrQ+7kjE3ZTPcalD6mpXDEmVpDwKroMPk7L8vhE5nUSiIUQf36fy6cbaTt2S9PI45C9FRkvXiSp4HnbfD7qsgLlLmmQXQHVaVDKBeF9/Tklx8cfZUSHrNQGOOgLYOEiYGK43ghBLpJ26UGiaJwtf4sIVZgNCC2iHrnI7T7h6PDrWYHrpo3e6cag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMInf6SpjoISdAzUBOGYpaS7loHU+BcpYGYSEPBZUMg=;
 b=Mv0TpGYzEHvig7nryGNOsx64tnEJlMsRu1swJ35SdrAJVsRINPw1cOTXXuu0IVGbB0A40OCMsboUjLJSenYf5IZfbnuEp5wGFzVJTi1v7bwps7V2EiR76hv/bLg0loYv+gmteverGWmQVhv8juBhW890jHcwg0/Y5kbaN2phpiG+D7L2a7WivWyxl5DR1tnDeMVM05Xqb5djSdZk0ay0RTLnG8Kzn2gprGgFbkMw9lkxhY5SiVCLlCSD+ImieSDdrAcBaffqfVD8+hk2afi/PDmmtT5GOGt5YK7rAiJneDIf1ZuVEvCX2cGtE2DjiddfnxZGTSxU+6S8C2Usfqb+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Thu, 13 Jul
 2023 22:55:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 22:55:20 +0000
Message-ID: <59fd7956-caf8-03de-10a5-f37036219134@intel.com>
Date:   Thu, 13 Jul 2023 15:55:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 06/19] selftests/resctrl: Move resctrl FS mount/umount
 to higher level
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-7-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:303:6b::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: 623b805e-bb70-49aa-9b3a-08db83f43b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XkGfIqGRC11C11BhoLlwLbX5hHSwJe6QZg3lRw3TM9b+i536R8G4qll58Pd5ZINPGQQvnHtXADj27MMI5gGynoBepUqMMTk+CNrETABgy8WAB2BAlcKZA5koNCwAdO5XcO0hdno3zKGxZ9Zf1nTZOu0U36r44Bg1pm4QsInmeFR/EWb07xswQCDlvCcxm4CBTJz36eYmKgp+XzKVG23JqWEysk7pabzObpVHb08YrgWvpW2peJfIpcGmjKtZhOqTOwF3HrsBYEHis+M1gPibaDj1ODnh5tZXPVEr2qOeKw4ci3NV/uuMU8PCxRcthzFdaTNe/vNPjhKz3KbW9ubjQsksQxJgMXntfunJp8VuGTbHzLOJhFCMwJj1Bl/4bDWqDE4wqkPe4KbQE2iwWu9b+amU8qj1kx/v7jVZEX71Ryzmm9WuGBojtEYUep9RXE7gqj78APGoKqLCiYXrs7nJjNWt0gIYQvO2drHL94/aXMq4Z7snNshAvsBaNWhvkVoQ0Y5XHhG5G3nouoC+Pm+48Rf9T6+vaexF/MW/UqHF7nWZ5sadZacnKo+zyaHi/FCO0OWNZ7NndKCjTuBCFtw+rtY/Y0kyQZad8BSojHqIZiGSzJU+ggs5CVLTZOVidjj18Pp+inJQzZ4UO/IyrssPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(53546011)(186003)(41300700001)(26005)(6506007)(478600001)(110136005)(31686004)(316002)(66556008)(66946007)(66476007)(8936002)(5660300002)(8676002)(44832011)(6512007)(6486002)(66574015)(2616005)(4744005)(2906002)(83380400001)(38100700002)(82960400001)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1Vd1JJY1NBVlIzNXdkeFpESzJSZ21PRUJYTWh5V0F3d3JRRkhpc0hVYVhT?=
 =?utf-8?B?eUppeSswRDY2MTlFUkYzREk1eTRHNUM5V0owM0NXNW45Mk92TDFvS1R5U3Zr?=
 =?utf-8?B?eWdLdHZGakdxT1NwYzRqR0lkRXRkdjZ5SmhTMjFKa3Y5MjMvTE1jeG9VaTls?=
 =?utf-8?B?QkVYak5XMDlONFZBazFuTW5iblZiZFIwWmgwTEQ1T1hOZlQyck9iemdoMnRl?=
 =?utf-8?B?S01yUGhTRFJNUU1Bbk50c01xcHVwaC9EMks0cDBzTWRGRnhXSmZVcjQ2bmt0?=
 =?utf-8?B?Skx6Y0NLMDlyVTlXSFBDLzRsV1lkcXRrdXlZN3FzVkRTREtqTjBDeFlUZmRJ?=
 =?utf-8?B?UVIrVXVnSEg3MXpjOUwzVmFyRWVwRUdESkxFN2tNRkNCdi8xMEtNQmU2MWY4?=
 =?utf-8?B?K01EeWFXbEtSbGJrUWRVNldySHBENTlyRDFHd3JQb0xIWGFJL1ZKR0xJMmZi?=
 =?utf-8?B?TjlOdVBBbVdsTzgyTGM4Z0NUVkZBVEgvTFU0NXdNREs3SDNjM0dIeThldEoz?=
 =?utf-8?B?eld5ZlVPaWcrRUVlVVBwM0FjcHQyQTcySjZrUmQ0eHZ1QXNFR0ZCVURUd25Q?=
 =?utf-8?B?WmhMaWZjRFpCMWxiRzcwdTh0S0ZLdXNremQ0SEdqL0kzOXp2QVl3L0EyY2ZK?=
 =?utf-8?B?eHdOREtqbW43TVovTnptdHV5alJOUVNsYmdjOGgvMmVadlpmbDRPRUFrL3Fs?=
 =?utf-8?B?bWs0Z3c5WkE2VzdTY3lHY3lYY2ZHTTUycmRhLzFsMWN1NGdGb25NY0lmdDFh?=
 =?utf-8?B?ckJoR2ZBYmJXQ1RZNUVWdHFDbGpzWldJNVhhK3NIMzd4UXhhQ1VBOWttbHcw?=
 =?utf-8?B?by9DZWcrVTFORjR6MVZrMUVSb2p3TktIOW9mTUZXYnVrZGMrODEzOUIxUFNU?=
 =?utf-8?B?azNQamJJdllITkZFVkJ0ZnBpS0dIQ1ErNUJHQkwrOHV2SzdOUG43RVJxZEpN?=
 =?utf-8?B?WjB2Uml0bElWT0FnUUhXY3lXYjlrQnkrMHNqNGlseTJuT1NzODR0TXYvU0lr?=
 =?utf-8?B?dlFkckpQN1JXNmY1ZWo0dnhwblR6NGg4ZFB6TGpVTkliM3p0ZVAvTWRzcnFh?=
 =?utf-8?B?L1FJcEViV1lhVDF3Sm9nVVhiazZ3ZVIraFJReGdKYUVmWDlTOHQ2NnltdVQx?=
 =?utf-8?B?Q0Y5UmlMaTNROUg0TlEvcVdBNGRWQS8zVllhVXhad1poVXc2cTdTcllScXR2?=
 =?utf-8?B?Y3lWc3VxYWh6L0FuWUhmdEhzUTFlSmVBWGVaYTcxOWRjdWYyNWNxWi9HOWRK?=
 =?utf-8?B?NjBlWGpDblpXUm43RVcvYkdNTW9uQVVYOGIxTWtGMDBHUE5LUTdIbVVBeXp1?=
 =?utf-8?B?dHpJR2RBcmFwYzJZMlZKOXdudklDOXRNbEV3d05idVVySmt2VHFDOG9tejF1?=
 =?utf-8?B?b0VGL25RTERJWjUyQ1c5TVdKWkFNTlcxZTB6ZXZTQVZDYWpsRXFZRTZUcXZV?=
 =?utf-8?B?bG00OG5waEdMMVc2emdCcmxDclJxSjV0MWY2Mm93OUFJMWFNYVAzQVRxUU9k?=
 =?utf-8?B?VUlycjZuN2p1eDJsUjdENGJsazNSMU1QL1hic1NWVWRBM3NmeGtZeWdKRXBP?=
 =?utf-8?B?OTFOZ29XaWJJVTJEaU5ydlhUeHEraDdJdHlwdTMrK2ZOaEdFN1NTUGZCZ1Fj?=
 =?utf-8?B?UGh0Mk5rbVhhOGF1eVh0dGFPaGZrbTAwRXVoMWFZa3pUVzVlc0cyN2dBSEVp?=
 =?utf-8?B?bnVzTHJqT0xoVnJ4NERCc0RWMDViRURERStMcnA3MmZidndwOWZ2dXJSK2pN?=
 =?utf-8?B?WkwvSTRWcnpQdTNPZVlOU290OTUweWF5Y1preVBFS1V2VG1lZ0xwbDRidDNl?=
 =?utf-8?B?bkxIbmpLQWF4QUtjOFY5QmZ4TnoxVElzT1kxVXVKMHdIOHF5eGxzTVJuMXYv?=
 =?utf-8?B?aytmc3hJNW53M3dYbFVnamJ4Vjc5V2UrTFQ5b1cwUzlGOThSUGFjYnk4dXVy?=
 =?utf-8?B?T1E4Yld0SHpQSUVOQ1UwSmhIWVNFMU03VFVPV21CRkVhSFVleDJ6MEExa1pi?=
 =?utf-8?B?N1V1a3B5V253dG14a3A5WkZRUjhTajZ1dTZzOHNXVk1qMzZ3dDBVQkpCL3FV?=
 =?utf-8?B?ZkxUMDMydmwxZE9JMkUrL21hVDRiT3VIVXFQRmQzVDhnTnBCdklaUUNhcDB3?=
 =?utf-8?B?UVUyTWZBRE9NNjErMERQT0gvSDlveWkrTFpjdWZ0RkUyc3NyRWcyWHJtTThE?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 623b805e-bb70-49aa-9b3a-08db83f43b99
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 22:55:19.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzJwfE4U+d8kAFXQqoF8SL6fLrND6cv4eq6C7gG7FJ2/kMVsFlGjhxKu0IVmeFbdfBEvrMv3TeQodW0WLNDWsXO/16niWhFM8O9amGBJak0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> A few places currently lack umounting resctrl FS on error paths:
>   - cmt_resctrl_val() has multiple error paths with direct return.
>   - cat_perf_miss_val() has multiple error paths with direct return.
> In addition, validate_resctrl_feature_request() is called by
> run_mbm_test() and run_mba_test(). Neither MBA nor MBM test tries to
> umount resctrl FS.
> 
> Each and every test does require resctrl FS to be present already for
> feature check. Thus, it makes sense to just mount it on higher level in
> resctrl_tests.c and properly pair it with umount.
> 
> Move resctrl FS (re)mount/unmount into each test function in
> resctrl_tests.c. Make feature validation to simply check that resctrl
> FS is mounted.
> 
> Fixes: 91db4fd9019a ("selftests/resctrl: Remove duplicate codes that clear each test result file")

Could you please elaborate how this commit is the culprit?


Reinette
