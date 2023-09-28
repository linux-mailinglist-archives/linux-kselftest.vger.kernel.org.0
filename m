Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6BD7B2368
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 19:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjI1RKT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 13:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjI1RKK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 13:10:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCDA1BB;
        Thu, 28 Sep 2023 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695921006; x=1727457006;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3LiT6oMmo4gaYdiHui064T/ioR1Db23XGnHHoTcquXY=;
  b=BUBn7c+xhjrv7xGnYdeIgEZnGWvbN0XnXTqFNsZe78imLXgsK72c5MhP
   x0ztFUZ/1QhmJDFy6+DkIfE4HTDO4HC3P5sstWQCBF8SEeINtzH6Rn31q
   Mq1zhDxCRMC24tEK2PaCjIZHmr/rWAKwr6g+bL13DH2MaBinzYZ30w7km
   PAcyOz9hXAsaEpIiyVOQdRL07XE0mpIqJ+TrP9Jh9PO+BRn7FNwdWnuXP
   W3734DYtGtX+Y60/fYT3lxtu8iciWdOLjGOxZBueOIqC7jtrS2gMWMfjs
   G83WWnzEKYckl4h8KD5BbuyubtOHgq5SIIsnRmF8EG0I+ohos/TXEcSYU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="379394957"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="379394957"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="873342388"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="873342388"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 10:10:06 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 10:10:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 10:10:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 10:10:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 10:10:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlgpZrFUSKBvs6BPB0T6xjpoeO5m9Qx+n1RpR9oOtkmqlWe96m0p0CCUab31eVj1FBJ4imLDiHgwMF//HPA/DC5hZp2bGicncc9h8s13zOVaLdR5fU4EP/mC/w4I2uTf7zDCklpOSDWuDBrxpT5DMdMo2gopfQXDWP15TUtbv9U4QfnUOXSfjGIbe/DVpC6eKPXXhmExMCabji/Wak+sGXR7usYb4S5uKmdUk+xOYDb7NjcEMG0XJGX6A9jMInLnYCFYAjRACmOztao0y8i65ftpo8yAoeYHwzPmET5b2dvHP1ZBVSGwhIVIlZsHee3yCG2D6nyzMieMvJsu8+NCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdEPNGMmdz0fsFzU0L32ScD3qLH6NZSxJm6MjmkDlHM=;
 b=F9buZzUOnPlkZcY940yRQ/3e8qRAoIsVqxBjY4Iz7VtYhZbrYESiLIKuNbe66TSLS8mbElX8SwXX6xWGUGwKr+XU4xXhFX06Ajm73refUyg2NmHaGcUYfPFQUruthjlpH6oWw9aIUIptBmzqJW+gefBEZy7bPrrckd/sH0eLoC30jEg9YtNh+e2bbOxJ2PW6OZuPScRvAGYDhyctSLkJR0ktwc0WLLRY2WWvByQRwlBTig13D5UXcLxe8BI4lSFa2e9YCERP2sI3Bld0aDkTJFiJ6vNQ81RM5rqQ6bLzkLbDKiMxY37yNJ/BtJshe4m/DQqDD7xCk17h3MCrsAScrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 28 Sep
 2023 17:10:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 17:10:00 +0000
Message-ID: <c4a8ca3c-c847-6930-db20-5de34ecd9437@intel.com>
Date:   Thu, 28 Sep 2023 10:09:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/6] selftests/resctrl: Extend signal handler coverage
 to unmount on receiving signal
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
 <20230915154438.82931-2-ilpo.jarvinen@linux.intel.com>
 <d2d94def-742d-7661-3632-b9f7e4996415@intel.com>
 <19f893e4-45e3-4e8f-c22-13241d5ff467@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <19f893e4-45e3-4e8f-c22-13241d5ff467@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL3PR11MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: e4727e90-0885-4e4e-ca28-08dbc045bfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7AtfMTRIKSbIhwoXUiWDRqJ4vASYdUCPtNiDcLtWh4t+Reu2xqY+74V5oBJa03Cz2uuaBWzAImC4+CiKCmabSTa4vgTQlHWBXkH0b0W3bQPkwD/ui+IVvp5dD1XREw758KCTR3TfRsFESD5ZQPk/xq9Wc7IgNjai6SuMEiV8nQnA16COQSEZf42sDiZftNwN38Iz1bazl+892S7iEjuo8m39uShm5G9Be5T6Fo/YveYbvOrL0U6HYSqULX0HY9WQiYX/hF/HDkaSZZZqh//xFAe5Ha7CQgCL0tkrzhwhVDYih//H1k/22faxCxUDyDr9+1BwiRpcmoHWvPky1XmLR/pvPHIR4hmZqVukKGhm7sgZbaoqvAcNF8TcJmUVqZvJzWoK7Xr5T6HymAbryIs2hOisqVSfPnLrh5TcWJOPAQIXf1UZwVGK38HZKWJUiNr0U9+eYLXFA6PdQ0zRxqNUvnq8tWkOmDVZvL+Ax5SkEG5pPvqqbyg4KWHiZY4uPyhjscUlB5qPGi5BgOT/wbyhPkvqT2p/EhpsYMkWi4Aiq75+hKNVW3HQhp+R5guPHM+ilsAS7ACqe/9/CQpXjg/rcNdb2N4iR6LfZXg5C5lI0zcrlXj7whrj9dxZRk+KLIkNmF7ShR+QkvCi31QW5aERw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(31686004)(66556008)(66946007)(5660300002)(82960400001)(6486002)(41300700001)(44832011)(38100700002)(66476007)(2906002)(36756003)(83380400001)(8676002)(4326008)(8936002)(6506007)(6512007)(53546011)(66574015)(54906003)(6916009)(478600001)(31696002)(2616005)(316002)(86362001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFBtcnh5d2I5VVVQSUhIZHBReFNiTkdIZHJHdlI4SVplWXZiazJvaDJHaGNP?=
 =?utf-8?B?cmVJbXoyc1NmL3hjWUlxc3hXYWZlY3lVR3VLcnI2bGV3WlA2NmVtQ3V6bnJl?=
 =?utf-8?B?SkU3TFI4M1gwTlBSTGVBNytyVk5Ob292T0NLcWdUVHNBZzNRUVhkSXI0QzlF?=
 =?utf-8?B?MTZDWTVRT1g3VUdwdkV5YUFtY2FlcTNGeU1iRFQ1cXNMcTZaT1lEY2YrYmNY?=
 =?utf-8?B?RXNFR2kybTBmc3ozWFdaMUJSdStDbERkZVJsWll6QzBsU1k0Z05kNjJhanRo?=
 =?utf-8?B?VDlXRHdyOHgxa29WRlUvUi93OXUyREk5eWRick9mZ2ZOMFRRNkw1TGZ3RnFj?=
 =?utf-8?B?UHhnSFF4a0lKTTJwcUk3Z1UybjVsQzNqeGU2ZjgzVGdTRGI1T1g0TzE0aFJZ?=
 =?utf-8?B?NGZUNXBVRDNTdFozamtqUTJvR1pyN2pXZ3c1Z0UveGZJRUxiZFBwcGNEMmhN?=
 =?utf-8?B?RmZiMFg5emNnUlF0L1NkMUw0OTA3c0xjMHhpZmxUYXdFUHRjWm0rUjRFTW5T?=
 =?utf-8?B?UFJMK0J4YllMb09qS1pVcTM5QzFHSkQ5U2ZnSnVHcGx2djlmMW5RK1JMUHNK?=
 =?utf-8?B?L01rMEFPSy9MOHNLRVZ6bnJheE04ZjQ3MEJTejhqYWhoZmhHNlpHT3YwdmtD?=
 =?utf-8?B?YlY0aEc4NmY0Y1REQkJ5bHQ3KzI0cFovSVhFa3lDdjJIeUh3cXhFVnRoZjhp?=
 =?utf-8?B?Qlg1T244UEo1ZUU1b3R4RzFtWU1GdE52b1FWUlY2b3NPWE9ud0dFUG5kYTdp?=
 =?utf-8?B?VnAvZXJEVFBKMnplTUxhOEhvZ216YXg5Nm9YTWZOUTErbzRDL1FaSEJqeUY3?=
 =?utf-8?B?eXNPUGNtcjY2Mm4zRWJvMEErYzJLOW5sWTRYVk9FWE5zcXJvNzFxa0FZbUhk?=
 =?utf-8?B?TmEweDFmd01QWWhHNWVHeFdCQ2hyVDVFR3A5Rk1mQWNiZ1JHUXZucU5PTkFO?=
 =?utf-8?B?S0NEeU1WNWNMeVZLaVhJVXNMNU5IQXZPa0plOUFvOUkwUHd4ZmtBeG43UGwy?=
 =?utf-8?B?TmdYOWFubzN5OU9oVG5CQ1hQb1JoazA4cHhxTU9MUmdDVXU5b053WTUxVWxO?=
 =?utf-8?B?bDVmZE1aZTVoL3V1bzBJZGZqd29PMTZudEFaVWI5azZlMUZnV2w4SVUxR0dl?=
 =?utf-8?B?TmRlQVRyMDViYWc5ZEpWSkZqWlBLcjRwUkRiZ3Nib0owdEo4dHFudUFxcHNu?=
 =?utf-8?B?bnNYSW1ScHlUVWlnbE43MEU5WUpKanF3a3N4WUNsUWhvSVdORXJ3L3lkY1Fk?=
 =?utf-8?B?SWVnQUNvMXVWQ2dhaVY5bmxBcTg2UkxTUEQ2R3NwOEc1YkU3STljYzVPKzI1?=
 =?utf-8?B?S1ppVWVqNU1jeUtaeHRvWE5wY3FhMlFkS0V6aHFxV3EwcERiZDdzMUg5OFZw?=
 =?utf-8?B?bVNucEpDa2twdzBodDdSNDZBYzAyVlRyMm81akZYMGlTdW1aSkIrU3Z3N3J1?=
 =?utf-8?B?Z3U3UkNDQWRHUFNMdmZHaVEzc1BsTEJnL0FpOW9wUGovOGNMaWFLZEZGYWNH?=
 =?utf-8?B?TWFxSUJnUWt1dURRSC8xTDhsYjEzbk84Zk5meWdTQ1pOaExXaElsdlM2cWhW?=
 =?utf-8?B?aE1CWktMbWxVK3NvbTc3bGRwS2dqQ2daajlXSG4xMzQrMlJyQnFhRi9XTm9u?=
 =?utf-8?B?TFpZd3gvM1I4TGx4QjFrVk14SFltdWhlZXkwbE1IL3JjMnhvMUMvTjk1SlFv?=
 =?utf-8?B?eUZDQlBGZ1FlakVnVS82NXNqcENnbDNLWHdaR29pRlNEWFpGdzRTU3hqemsz?=
 =?utf-8?B?Z1p0cTlscUx2MFo1bVFZK2pCcFZTdm0zVEQrYXBMWDVXQkJEOXJjd3F0bm9T?=
 =?utf-8?B?blFJWVJnY0I3bGoyMXFveDNYRDd3Vm8zQkJnSEg5ek80ZHZIVit2Um1FK1Nm?=
 =?utf-8?B?UEFMeVNRc3dOdUNaQUFxRktacDEyUHFKU3dZdGtXMFcwbXNLQU9ZWm0vbCtn?=
 =?utf-8?B?OXRidDBEUnhRSW04eGVncjZnQU1rVlQwYTFPREg4L0pjSG4yRWFjWU1ONXlz?=
 =?utf-8?B?UTZ6aVdzKzhlTHRnYjFiRFJuRng0QVFUTXpjc1IrQ212OGpWNFhzaDIrRi96?=
 =?utf-8?B?cTNiSjlxVzFHNmJtbGJETzRsT1c2UTdkQ1FBMTc5eDVSMGJrakRrenFJdXYv?=
 =?utf-8?B?bWl1NW9IUnlzVy9MNW9sQWszbTVXRXhyZjVFZFNXVVZhb3A5VWphT1g0S1Rn?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4727e90-0885-4e4e-ca28-08dbc045bfaf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:10:00.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q21RrTarfejVS/UQxyRcsSVVpqr5zuSe7i6aqXLgln8+/z7TFuF+g8+enYBfREJzgqP/mwBUZYiIrJ3vFg2gD+fEcKGahQLvvKt5kCBt2zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6508
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/28/2023 5:47 AM, Ilpo Järvinen wrote:
> On Tue, 26 Sep 2023, Reinette Chatre wrote:
>> On 9/15/2023 8:44 AM, Ilpo Järvinen wrote:

...

>>> +
>>> +static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>>> +{
>>> +	int res;
>>> +
>>> +	ksft_print_msg("Starting MBM BW change ...\n");
>>> +
>>> +	if (test_prepare())
>>> +		return;
>>>  
>>
>> I am not sure about this. With this exit the kselftest machinery is not
>> aware of the test passing or failing. I wonder if there should not rather
>> be a "goto" here that triggers ksft_test_result()?
> 
> Yes, ksft_test_result() is needed here (I forgot to add it).
> 
>> This needs some more 
>> thought though. First, with this change test_prepare() officially gains
>> responsibility to determine if a failure is transient (just a single test
>> fails) or permanent (no use trying any other tests if this fails). For
>> the former it would then be up to the caller to call ksft_test_result()
>> and for the latter test_prepare() will call ksft_exit_fail_msg().
> 
> Well, I didn't initially have test_prepare() at all but all this was 
> within the test functions (which will be consolidated to a single function 
> by the series that comes after the two series are done + one patch from 
> Maciej).
> 
> I was just trying to do what was done previously but it seems I forgot to 
> handle the result status on signal reg fail path.
> 
> TBH, I wouldn't mind if also the signal reg fail is just up'ed to 
> ksft_exit_fail_msg(). I don't think it can ever fail with the parameters 
> given to it so its error handling feels pretty much dead-code (unless some 
> crazy thing such as apparmor does something out of the blue, I don't know 
> if apparmor has capability override sigaction() but I've seen apparmor to
> create errors that from the surface make no sense whatsoever comparable
> to this case).
> 
> So basically this discussion is now about what to do with the mount 
> failing which already does _exit() before this patch (and possibly some
> hypotethical, new prepare code after the consolidation work which also
> will have some impact and I believe we might actually want to kill 
> test_prepare() at that point anyway).

Having failure during signal handler registration also trigger ksft_exit_fail_msg()
sounds fair to me. I am also ok with keeping the exit when mount fails.

If any future test_prepare() code does not imply a test exit then I hope it would
be obvious that ksft_test_result() needs to be called. Perhaps that can
be accomplished if test_prepare() does not exit the test but instead just
returns an error code (if needed it can use ksft_print_msg() internally for
any details about particular failures) and the caller call ksft_exit_fail_msg()
if test_prepare() fails? With the caller responsible for the ksft_exit_fail_msg()
as well as ksft_test_result() then any new addition may be guided to the
right calls. This considers hypothetical future changes to code that is
being consolidated so surely no strong opinions from my side.

>> Second, that SNC warning may be an inconvenience with a new goto. Here
>> it may be ok to print that message before the test failure?
> 
> I don't follow what you're referring to with "that SNC warning". To the 
> "Intel CMT may be inaccurate ..." one?

Yes, that is the warning. I envisioned addressing the issue by adding a
goto label right before the ksft_test_result() call within run_cmt_test()
in this case (but also in run_mbm_test()). Doing so would solve the issue
that test counters are incremented on test_prepare() failure but it will
also trigger the message you note and that would be confusing to the user if
the test failure was because of signal handler registration failure.

...

>>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
>>> index 51963a6f2186..a9fe61133119 100644
>>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>>> @@ -468,7 +468,9 @@ pid_t bm_pid, ppid;
>>>  
>>>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>>>  {
>>> -	kill(bm_pid, SIGKILL);
>>> +	/* Only kill child after bm_pid is set after fork() */
>>> +	if (bm_pid)
>>> +		kill(bm_pid, SIGKILL);
>>>  	umount_resctrlfs();
>>>  	tests_cleanup();
>>>  	ksft_print_msg("Ending\n\n");
>>> @@ -485,6 +487,8 @@ int signal_handler_register(void)
>>>  	struct sigaction sigact;
>>>  	int ret = 0;
>>>  
>>> +	bm_pid = 0;
>>> +
>>
>> Since this is an initialization fix in this area ... what
>> do you think of also initializing sigact? It could just be
>> a change to
>> 	struct sigaction sigact = {};
>>
>> This will prevent registering a signal handler with 
>> uninitialized sa_flags.
> 
> Nice catch. It seems quite bad bug, I'll add another patch to fix it.
> 
> Thanks once again for your reviews! I'll also address the changelog 
> improvements you mentioned against the other patches.
> 

Thanks to you for improving the resctrl selftests so significantly.
This work is very valuable because we use it to measure and gain
confidence in the health of the resctrl subsystem.

Reinette
 
