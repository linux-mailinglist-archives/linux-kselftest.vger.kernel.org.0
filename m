Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0282B64F16A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 20:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiLPTJV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 14:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiLPTJU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 14:09:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7A525C56;
        Fri, 16 Dec 2022 11:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671217759; x=1702753759;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ptc8LoFeoZRVNAVKqFWIUQ6xjtdBKoijae4WVedndYA=;
  b=LNF3qdKFHFUIhJ5X8Aa0emtZeHLdFZENdol+YuS7yUtW9K0f2JwVLP8b
   5bclJh43AF6osNsEcu4uJrkhJBnAruukvoaH62089NJOhJODFxxINGywf
   9J9WIuhIYQ+LoNsLNZhXehfz/juJx/lLe0ur0HlUuLFnHbxADGgbYIo0U
   KjIgZX33Nwv++j9QWcnn3lSi9fVMrIQvYe2nOgf7oBb8E8HimMvAIjv2p
   nUeBtHrlBoCk+xiUC2Dwq/ykjP7VHbFNskLH47YsoJ00lHkk9tuG05kSA
   AI/mrnokqONiLKHKF2MNUjPqetkwo2R90ropWw+HwTk6pZHRWOpT4qIoZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="346121152"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="346121152"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 11:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="713359917"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="713359917"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 16 Dec 2022 11:09:04 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 11:09:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 11:09:03 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 11:09:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G92UlFWKoC+inw2t7GWI/UbI+pnMu1zQXtG1Y7f06PKGOg8FbmCjX6YHG84ilWVKuYFgx8HvKem6RVPLZnfrX3LVpakNGbE3ajzdUcnsqUq8Po89KcR2HajPw57RUfRlZCpH7EnM1o5qk2mC3GfZ8c04+XjErM95mm46nd3Ww0Ztub/VQCjMG7EObGltPxJMT6+8yRsFB5xln7dI9xhFvgWcdn4EUnPF0rZAPs8bQsvCjkvuz9GPlrAkg20231tx9e3ywOOEI6lPI50b2HMy9uwqxTypUDBCKJ6TuowbA4+O+F1yjB6Px5y2ADmlasZu/KS2lvIqi/rvLzRRRTNk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5OtiVdi/isDXYHX8Jd9TlseJLVkRUdbS1OaVRfXgSI=;
 b=fPtcxkHDM6ms5II/Nm7S0JYM4rXp6sfwt1ckB9skkZEHxoKmfH/VllGmaPDczlHi+CiwtCsHSBrbb4Qj/GYz2B2if2EepEA2IYj4IreDfHwShsd+Y1Md+bhtco01qB7SmXkbwGMy0W4SasIIOCXq8HmJtthYa1tUIwXDoncFajwEECNc02Pi/ZYhmFG6xSEnD3b+O3okr9u8r3EyRUSYlXky2x0YQu6TrfvHBABQZirbkfmIhklFwOxpwRyc0ASNB4hrJ3djFMpGGNxwnrQ83eKiZlJMO5Ujw98shacyejUrfLwtQaD2LInDnfRfO2VNv/tAII6wRzKEZ6/cwNHRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB7266.namprd11.prod.outlook.com (2603:10b6:930:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 19:09:02 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 19:09:02 +0000
Message-ID: <843f5f7b-03b8-5d71-fdcb-51cd3f995551@intel.com>
Date:   Fri, 16 Dec 2022 11:08:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v4 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Content-Language: en-US
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>
References: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
 <20221117010541.1014481-5-tan.shaopeng@jp.fujitsu.com>
 <af1b4e59-2b4b-ddbb-2218-0e2808b718a3@intel.com>
 <TYAPR01MB6330CDB2C59C58EE77B912538B0F9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <ba5a9ef2-b4ca-5c90-cc03-2296586455a6@intel.com>
 <TYAPR01MB63300F91A0755310E78D98308B159@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <ce549bc3-7e54-b1d3-7ec5-4cde66bd468f@intel.com>
 <TYAPR01MB6330FFB9E5BA7CCDC652EE3F8B149@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <9801fa7f-5971-1f5f-1b63-0d672c32fcf1@intel.com>
 <OSZPR01MB632837AC9133DFBD2061637D8BE69@OSZPR01MB6328.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <OSZPR01MB632837AC9133DFBD2061637D8BE69@OSZPR01MB6328.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::42) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: be05a545-cc59-42a4-8d0e-08dadf98fe3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaOlPF0g8rD5qf7e3Zbq9dl20becxWZfvSJkvx+VUARofrdY3E+p1rHOL7j8Eni5I0NStbn05kKOzKN7EeOs/q969yhNPXNXbMcR/9U7nas+B1FiT/BjRBCYwdwwkMiJmA9ZeKMwy8LV3nTRD6sW6wTOEcLKVTbdCsAZbW6OfQMcf4qIlDEHb6kCDuf/U8q6rUDqatdRalCGxOUme5qflYAV5wn5HXN43ADyyozelN4Dv16mFFjnPyv2lSORg4Xmj7bf58vYNOHncOWi0WYxtX0xq3WgQP/hBwTJdBt1Ts+hCZdNaFsF8OsCi38ZMFMmSU28+qSnV57IC1C3uKDmg1JGL3upVjG1T0cwNDEAQbUMhz9ctPheiBYef4MU2/gkIvGcmHbiQC/J67tG2SZC7DIEmrV9rxQDDjaqEl8WHypVDJd004cthx1bToC2x3rhQtNoH+68dJxNKikfDBY5SxpyuTXxgHevmFjK2eP8dlkx9GXQ6ynAQUuEmjBU6N0we6sEKQ2iV+h1XRJpA1wCuM0qwbXAEd/VMpQ60ZAZXaLREa2zugbvwqxaGMV9OYRBilQM7A0pZHREcpr8/H5xAOnI6d5j8ZgHfslB9BkJX3E7rI513+Dbcsi6ILhG0oEI1g26KRhBPhiMXRDN1zNIBlJMtZwqvNKNKX+pkU51VoR83XcLh6rA2As+/E4zq+jTpo5faKtok5/swX9ZgxYG4UeGzs7zIYLJ+u6UDO55+jI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(31686004)(66899015)(110136005)(31696002)(54906003)(6486002)(316002)(83380400001)(36756003)(26005)(86362001)(6666004)(38100700002)(82960400001)(53546011)(186003)(6512007)(6506007)(2616005)(44832011)(5660300002)(2906002)(478600001)(8676002)(4326008)(41300700001)(8936002)(66556008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhWRUk3bEw2VmN4cEUyZWRzOWE1WGI2a0dCZ01abHVPS29USXN3VWJDWXVo?=
 =?utf-8?B?T1BWbVlBbVUvWDIzOGNheVJEOUVudnFPb094UTBweG9FT3J3THB4V0x1VytC?=
 =?utf-8?B?ZWZvL0lseUNURjBPZ1ErZ2JXb25RelI2TGZiYk9uVUpXN2d5clM3TG1Mdi9U?=
 =?utf-8?B?U3JSK1E5eUE3SlZCelk2b2w0TE5aaGlocWVmM0wyelVKV0hKM25Db3Q5WkdT?=
 =?utf-8?B?U0lyYXhTVmRDdmlGc0JoSjFsaGVPOXUxN0xMZ3FTMG5OR25qU1hvTFRPTmlQ?=
 =?utf-8?B?cmlnenhjcWxycjZwL1o2dThCZlFPck9pS09RSmNIUG94UlVIZmxhZS90YkhF?=
 =?utf-8?B?YytDbDJKcDZZdmlSdnUyT3RUTHZLdWgxMmkrSktCMlZSMitDNndqZzg0SC80?=
 =?utf-8?B?T3dTSXlJaG5BT0FxSFJvVHFQeVplajJockFCYklWekNpRk4zZkN2dThrY2Zu?=
 =?utf-8?B?SmhjNlh6eWhiQ3RyL0lKNEZJRGVXUVZaY3BjNTJoa3NUVk1vT2JCcTlLQXpt?=
 =?utf-8?B?QmYwb0xhK3g4L1pWOUIzMjlzbEdxcTNRL093MDN1VytxSmFjcGZJVmNNbjVN?=
 =?utf-8?B?UnBWWkllZ2NZQk45QzZ0dkRBaXdyQjFzbEFQdWJYS3JrbUVhb3M1SWo5MGlP?=
 =?utf-8?B?ZkdxQXRCd1ROUVN3eGRVVWs1aTd0WUJtSENMQmtlaDZUODlvWEk3MU1xU1F4?=
 =?utf-8?B?L05XUWxDWkxyS0ZIcDIza0UxRk5GYzcvb2xiOUUwWmR6Q05XclpTVkZobkZ5?=
 =?utf-8?B?aW5NRkJZRTRDcWVNZmFkZTE1WFl2SGs2aW40aWNEUXkxd3Zsd0p0bm80bzQ2?=
 =?utf-8?B?WkFLL1p2eHQ2QnIvY3Z3NSs3OUxIQjd5NWVBcUppU3FxZmNqeWtwa2REQWZM?=
 =?utf-8?B?N3Z2NmVHU1B0bjBxYmtkM1lLbXZoZWtSeXQ0QWNjajRoTHFOc3lIK29PVi8v?=
 =?utf-8?B?T3ovVWptSCtMdU1hZHR6WEY0MlZ0NjFaTlE1T1lVd0w1RnN4NmRvZFkzem1h?=
 =?utf-8?B?YUh5T2o0b0xkWVVHWC9yQ2lvRnN5SHNSaU5GTm5pY1ZhY2pvWVZTQVBLWmV1?=
 =?utf-8?B?YlNpbk9WblUwTEx0L0ZGS3FPaDBrbU0vZHh3WGxVV1pZMlBjZVlQQ0hCdERz?=
 =?utf-8?B?LzRoSXEyTEI0SjE4SU5lSVNobDdQQjcreHVDK1Z4aHFRSmczVHREQUt6TWVu?=
 =?utf-8?B?TzAzRjJJN0VIYTIxcnNwNkNKV0xLcUFCMWhsLzFhVG1mUTRYMVRWSFdHM21I?=
 =?utf-8?B?aFdQMyt0VlNDV3RscHVqWmdtcHFiSU55U21wSlkwWVlVbU5tY2N3eWxlNXZY?=
 =?utf-8?B?UTB5MnplNlhwaDE4aElsdkJSaWxvTFF0L0U3QXVDMnRReW9hU2c1dTZKY3hn?=
 =?utf-8?B?YVMxZ00xT3IxeC8vdWU0MWFqTlc5dit5OFN2djFUbTM1UUU3dm8vcVJoM05O?=
 =?utf-8?B?VVQrcTNMWUtYanBpNjBuaForMklQMXZ5QzlZejQ1R2hxQTZRek9aU3FKRlRz?=
 =?utf-8?B?cFNoMkJLeCtJRGhDdGcvNnNVYWJHdVhyaXhyaVZxSHRhbUViK0hxd0hGLy91?=
 =?utf-8?B?c0tDZU9MNktDWUdJTUhZd2RPREZxOUJTODVmbURqZWlJQ0pjTVRMSDdIVkJB?=
 =?utf-8?B?L0hadkZLTGliWEdMMEFwTCtINHVQWVFRMEFTb1R6Z3NuN0prZklkdzREanA5?=
 =?utf-8?B?d3UwNEpPZVA1ZWZvTXpjeTN3WlhKdFpJOWRtL0xFb3d0bFJHNjM1eHp1SXlN?=
 =?utf-8?B?WWcyb2tqb2hvNjdGVHlsa2RQQnREalRHR1lhaUdWV0VTSUYvY2tjcVlOSndv?=
 =?utf-8?B?QWpiMDc3TWlSM3pYVi9paCsvcFhueC9KVUVWMXVTZFpqRld4cEdSbXpWSEVx?=
 =?utf-8?B?blk0SHc2OU9IeVdvNy9CUXE0NkE4andOYXQvQTNOZ0xoMGJzcFZLRlNESUJl?=
 =?utf-8?B?d084S2pVNktwN2dnUk9FV1Niak5sOHB1U21ETzJsMWduR0lNclBZbWVyZ3Zi?=
 =?utf-8?B?QXNXVU9wN0wvY05JSVpTd3BHQ3cvUnAwQnkxWktmN25QRkM3RXJjekhvR3pl?=
 =?utf-8?B?RnQ1OHZ4UVNUck90VjhSWVFZSzBrY2hsS0xRUUhCeVc0U0hKV3BjT2lmSUR4?=
 =?utf-8?B?SWhhaUIrSzMxdnRJWDk5TU1GM1VhSzE5eFpjV2M5czBLTmtlN3F5QU1vWTlO?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be05a545-cc59-42a4-8d0e-08dadf98fe3f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 19:09:02.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGddDKDVCfXvlRZlQCta5XDfQF4F0Mjlha/45/kwWm/JcV4A686zzwJVZX3Lb4RRg3Jwpzfn9OelICkxzAf27NxdpKOcGWjO5xZ0/CQm7aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7266
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 12/16/2022 12:20 AM, Shaopeng Tan (Fujitsu) wrote:
> Hi Reinette
> 
>> On 12/1/2022 12:20 AM, Shaopeng Tan (Fujitsu) wrote:
>>> Hi Reinette,
>>>
>>>> On 11/30/2022 12:32 AM, Shaopeng Tan (Fujitsu) wrote:
>>>>
>>>>> Removing ctrl_handler() is only part of the fix in the next version(v5).
>>>>> All fixes as follows.
>>>>>
>>>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>>>> @@ -98,12 +98,17 @@ void cat_test_cleanup(void)
>>>>>         remove(RESULT_FILE_NAME2);
>>>>>  }
>>>>>
>>>>> +static void ctrlc_handler_child(int signum, siginfo_t *info, void
>>>>> +*ptr) {
>>>>> +       exit(EXIT_SUCCESS);
>>>>> +}
>>>>> +
>>>>
>>>> Could you please elaborate why this is necessary?
>>>
>>> If enter "ctrl-c" when running "resctrl_tests -t cat", SIGINT will be
>>> sent to all processes (parent&child).
>>>
>>> At this time, the child process receives a SIGINT signal, but does not take any
>> action.
>>> In this case the parent process may not call ctrlc_handler() as expected.
>>
>> Apologies, but I am not able to follow. My understanding is that the ideal in
>> working an failing case is for the parent to kill the child.
>> Could you please elaborate why the ctrlc_handler() may not be called?
> 
> Apologies for the late replay.
> 
> The problem is that at the time of running CAT test, 
> previous ctrlc_handler from MBM/MBA/CMT test will be inherited to child process.
> 
> Let me explain in detail:
> In resctrl_tests,the default run order of the tests is MBM->MBA->CMT->CAT.
> When running MBM, MBA, CMT, signal handler(ctrlc_handler) was set to the parent process.
> After these tests, when fork() is executed in CAT, 
> the signal handler set by MBM/MBA/CMT is inherited by the parent&child process of CAT.
> At this time, if "ctrl+c" SIGINT is sent to parent&child process,
> according to the inherited signal handler,
> the child process may kill parent process before parent process kills child process.
> Therefore, when running all tests(MBM->MBA->CMT->CAT),
> signal handler of child process need to be overridden in CAT.

Thank you for the additional details. I do not think that this should be handled
in the CAT test. The CAT test should not need to work around leftovers from the other
tests, that will just leave us with harder code to maintain. Instead, I think this should
be addressed in resctrl_val() where the signal handler is set for the
MBM/MBA/CMT tests. That is, when the test is complete and the test case
specific signal handler no longer needed (after test itself kills the child and
handler thus no longer needed), the signal handler should be reset to SIG_DFL.

This should give the CAT test a clean slate to work with.

> 
> Also, when running CAT test only,
> since there are no signal handler that can be inherited from other tests,
> signal handler of parent process need to be set.

Yes, this is clear. It is the child signal handler that was confusing to me.

Reinette
