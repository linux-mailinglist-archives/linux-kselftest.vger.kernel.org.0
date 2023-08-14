Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C940E77BF45
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjHNRua (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 13:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjHNRuB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 13:50:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C89394;
        Mon, 14 Aug 2023 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692035400; x=1723571400;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5nfwOtamjWZV1hribeSpLG3/er7VGtb5OwMtSP/+81E=;
  b=WPPwHKPE+aOBYbP4vTOVrDOLkIN+W7ClmS9Yd6BhviIcSibFpC4sdJd/
   oG1c3XgfEbqBG/6m/JyrnpthIJYhjqgGA54cufNBzzUC7N0GswUU8qkxX
   +hkLRnufxI07LUfPXb9/1F8HOj1dzstTtTCHp1XJyIJ+kI6Vhpje9hiTA
   WuNLaBoa2uDQStdRzCAI4K1xi9168hpm/sIYIg+dB1yMlfFkB2YjwZpmS
   fUOX/Ydxgawe5Psx0E8fp1t4hOpvx8jaFRTH+GeN+x6KPCIccGOW4XMFN
   RxXLmQimjks5hF+mjXUIJPO2qwhvMJ65Fst92rRTKdpcqql+JbHTIVt28
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357066774"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="357066774"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 10:50:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736604083"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="736604083"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2023 10:49:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:49:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:49:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 10:49:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 10:49:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UauQBD3TEa3QSVrUJmlf4dqwCfu7MzYqOmT+BYpwjP9Ttbf0H6pBCBnrySvexTN6RirGcvUiG5+tVPeTYcwtbwgBpykufGO7ZPE5gv7Nq52jufccUZ+EGcAq2u/h8zYf10/THwmCUlSTrVtQoaM31fMs0/DqD5PT968RrHPf/NC89qOvXfjIeMw3sGfMfpOpULN14E30Wg4mvNhB6ndO+eyFvxDIm+U55Vl6tRxVDIRFMHBM8+lQa2scifotUVd9liBWjPJwM+t32a/HXkeTG80Wn3yuz0/hzml1wOI4qc1dVLB3RvzoTVtnDTWHmTyh9xS+JDi040cPABMewArjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0iY8bniEvqlUv/DnxDf0xddBzbGHROwsDUORV8eo1w=;
 b=nJLRB5/ZE34Ky3Cu0LByN0fHsNfE314EYcNFNCIeCnuPwLy+p1t3XbcGNL0SfjP9aW+dFb0/oP1oY7d/TuHuzkpjAwBJtphdCKXN2OlaDrzBMS1BwYKJoHgalQIBtT1/J+/yri1pezdXHs7wAfFM77Q7ipBt1/jyBH05o5hf6QGdZ3gy53Wt+S2Zj0X9LfISM6/SncogGoOG/iGSy2AQBLxKyAt0JLdzcfC3gcSFmi8kx2/tjKANZwrZYLe688H6pQzaJXaqKUjCzpEZEpo9j3DV9ynPjPCNACz+ht9bqV3ibbOu9v4ZPlRM3I7l38sotqNDn4sBzJ36H/y8Wh1ZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 17:49:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 17:49:57 +0000
Message-ID: <610023b1-a7c4-cc16-a912-aa22fb42c9e8@intel.com>
Date:   Mon, 14 Aug 2023 10:49:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH 4/7] selftests/resctrl: Simplify span lifetime
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
 <20230808091625.12760-5-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230808091625.12760-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:303:8e::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd2714f-64df-4c4b-b090-08db9ceedf8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aI3sY4JtnAO9HrKjwWAW+zIUVZ/aJZpyfvYLym7opYlFlZF0bvIh9RHQx66s2Y5nCqGdMl/qO/dNdGdMKVs53nmneC7rcAHT1f4R6VakFCVCdDtGKj3bWnN3WSz5nrFKFDTEYEr42T6u+QgQqbtj59S92z3mXOkcG8PyeAiN8JQDq931n407SAUKmW0R8m/5e2OkSI9eZbIK8Fn/Isons2CbyFGVQgysIiCG+AQIyvTRljM4JXgp/vbo/g+QSlgIzF/WfUmJa9reFA0xjEaNWaWXbl7xxEWyX4MoJHvAIlhekNQlyEbu2141cGAhkVHJRVlYKyoYsD19DheULaanoQcc8cLNoHbGCCKIZcZxY0hn8aa/89vAy0IHPJ8bAM033r/4sYJGp+Wh1cJN38eLvMt5KSj3ukSa1NYM0arXGBatyUwyZv/q9RoCK6Q+gw6Tc/6Oj0Eh3C3JG3GVHiufKvDKsjSxLYZg3O+BHz0ZaPPtMRxqnzWF9y1cSjGKtGWDWjW117VaVbQjxOvWZFYf6HAqqVSXwx0zKw9GZ5loxj9xDxmxsrDUM1hKeLjZTeHKftM8faHGP+T83rb/7MP/a71tLLHgcu1Vq/CS3ZVtMbW4RQ7Ben9ExQZEQXe3I7GQGjfVWRRSA65gRmyPbTeGSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(1800799006)(186006)(38100700002)(110136005)(6486002)(6666004)(478600001)(82960400001)(2906002)(5660300002)(36756003)(4744005)(86362001)(31696002)(44832011)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(53546011)(26005)(83380400001)(2616005)(66574015)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0F2bFdWcmZXdlFja1BMcWVpdGdmNFZMSGxKZk0ycmxiRHJUNXRyWWh6ajBH?=
 =?utf-8?B?SXdSQUtJVWZscmV3WUNpQzBxMzJwcmk0TUNzbng2WVppTTZDbis2Y3hQZ2Vk?=
 =?utf-8?B?SjYrTTAwaExyRGVLQ3NpUEtjT2RzQUN4VitNK0psRXdZOSt6SDd2d3FpVTU0?=
 =?utf-8?B?RUdUWlA0UGwrYW9mcktRMzZzQnZFRFlCbUlEQnd4YjNRSEwrQWpYOW5aSjdi?=
 =?utf-8?B?QjhrYVpFeGY2SlFtTTE0eXRnNjhpN3pZWXdRa1k3Z0tGQkFEQTBaTkYzV1hC?=
 =?utf-8?B?NXBybklDbEE2RjZPZnBHL0NLTGd0VjcyOUgrdVhKQWVSNnBOZ28wcDN4a0dr?=
 =?utf-8?B?NklJbGNmZExlSngxL3BGNjNrTk03dlp0RXQvODlUOHRQbU1JRUtlSXR2REhJ?=
 =?utf-8?B?YUZXVndYL1VUWnNSUHIzODAxQ2hCeXNhNklBdGxlQzJJdlRMaHhmNHBmSjBG?=
 =?utf-8?B?a2ZaVENkcHFXYmhUQ0ZUdmRCdHRaUjNDVVk3M3VsNDQvcndXUUxETC9Kb0Yr?=
 =?utf-8?B?cCt0elovZnBWcVdtaTY1NlNCZ3JyQUN0VS95RW1rYlpBdzRNa1BLT3pCUGFq?=
 =?utf-8?B?VlpXUjhxbTFrajg4TTg4MFVFeWk2U01IVTVQVnkrOGxnS29hZVpVQTVKOVdn?=
 =?utf-8?B?WVp6bHo0R1lZUGNpRDhDM25HV2Q4L0huOXJmaE1yOXFLWTlNZkhWRENKL05C?=
 =?utf-8?B?Qm1zTDV3SHRkb3o3NUMwUTREWWw5V0UrSnRISndTSDlnTWtPMFNhbHA2UjM2?=
 =?utf-8?B?SzFTRStGWVc3aHJTWTdzbzM3Tkd3cG02eWtqZHZkVkl0NUFTNnhYT0dTWDJp?=
 =?utf-8?B?UTBzUjJRWE41OTRzQlFtYVpRQ0Jhc0hQTnhFdDJOVDhHTkdCVnNJSWZzOGl2?=
 =?utf-8?B?WGZFVWJZaWJaVHBHMlR0K1JGVk9pQlc1ZlBDTXNQY0lhTVpSbWdiNTNRalJw?=
 =?utf-8?B?dXQ4a2E4Y0tqTVl4SC9DbHRqNHNqK3JFaVJZRGplMUlYVmVndVE5VWNHU3h6?=
 =?utf-8?B?ampTbTFkOVJadTJxYUxZZVBJSVZpUjVkQXNXcThwekJObzFrNEtoTHUyNkR2?=
 =?utf-8?B?TnRzUWdITWJGZEY5eDg1SlMvcWpyV0ZwN3BYZjc2ZXl0MDZDdXZvMWtCV3lH?=
 =?utf-8?B?cFpyRTBGOWpyN2hVdzBGaGhYWmU3YU9pMG5TdWJmMURLb0MxN3FoV1NnNFBq?=
 =?utf-8?B?YTNFUmV0ZU1GNWdlWXJPd0NCR0Vjb01pR0krekZ6dFBSaEJrU01oSUZNSG1r?=
 =?utf-8?B?MUF6UkZrdGpKaUhhMkhGT2xyeUxJRDV6Q1RNbEJ0RHJrOHRqZXBUOS9INnNq?=
 =?utf-8?B?ajBwZ2MyVUFnV1hnS1hXekxlUjlCSVFpVEJVVzE3VlMwd3JEOVN5MzQwTnc3?=
 =?utf-8?B?M1VBVDNQQWFvUXVjazcvQXpiVzA0MjFFYzZRR2NrZHVWRmdBaURvd3B3Nkw4?=
 =?utf-8?B?NmdyTVdSN0xMa2ltMk5lOURwSHA0TTlvM2l6Wk5mc0haMVBTYVQ0ZmNkOUFH?=
 =?utf-8?B?RHJSK25RNFUxV1lOaUxtQ2dRTStBNS9hTWtvU1lETlZxRG5FZ3JKTE96T0M2?=
 =?utf-8?B?eXQvSFFUSW4zRzR1b0VFai9yQ0pRNGZSbTkyOU9iUUxlNFBsbGVUNjBZM1Zi?=
 =?utf-8?B?Zm5WVU5EWlZLWnBQTTdqa2dXOFM3eklZTlJmdVpBclkzOGFvNXN4cG1uTjhw?=
 =?utf-8?B?SHI1QTdEY2dGTDkxemdndFZUTDVENjF2YnZpWXlaYzJxOWZKVjFhbktYdU9B?=
 =?utf-8?B?SjkwYjdzYnpWT3NqQXlTamRKbjRHb2F6UDlZRjVtN2lzMjFQZDQvU2VxcjMw?=
 =?utf-8?B?UTNpeC9KUFJuVGIrSG82R1pUZHdsbFdQSXdCWEM3UWE4VUcvczFlKzdROXBa?=
 =?utf-8?B?R0U1OVI1QXFuajUyZ1lSS2FTUW1xeFVlWVFwbTlGeCszaUlnRzN0N1ZMSzQ1?=
 =?utf-8?B?eWNMeUh3enlONHJxUWNuN0xrNWtqVDFTcVNVTUlKbDZxcUdkMEwvanBhSEtt?=
 =?utf-8?B?SGVhS21OTG5jWmxNZ2N4dkoxVytYYWU4U3FrWkxzTzBTZGdlVFlielhlbWdC?=
 =?utf-8?B?Y0l2R0RkdEN0MFNmU0U5VE84L1o0OHpqOGJhZGZzYmxwMEJQd1VDREtaWWZH?=
 =?utf-8?B?SG9RZU1qeldRSDlPVHFkbnRsMXRmb3p3RU4zaUlxak1vNGRuc3k1WWpFa09v?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd2714f-64df-4c4b-b090-08db9ceedf8a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:49:57.0983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pQg1IJu30+KZuccO45Z2/U7cmR+l1oxrLU6V89GbuTrG6w1WxGS/X3ijb4JL1w6xmHflzUZJEXYY41MxtvrAbOHX813LCtpYZkGONOB46c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> struct resctrl_val_param contains span member. resctrl_val(), however,
> never uses it because the value of span is embedded into the default
> benchmark command and parsed from it by run_benchmark().
> 
> Remove span from resctrl_val_param. Provide DEFAULT_SPAN for the code
> that needs it. CMT and CAT tests communicate span that is different
> from the DEFAULT_SPAN between their internal functions which is
> converted into passing it directly as a parameter.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

If I understand correctly the custom benchmark has always been
required to operate on the same span as the default benchmark in
order for the results to be measured accurately.

Thank you for eliminating unnecessary code.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
