Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E677A0878
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 17:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbjINPFp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 11:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbjINPFo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 11:05:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8735B1FDC;
        Thu, 14 Sep 2023 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694703940; x=1726239940;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Bt20cXlSsD/Wc9zplWOIxPlHdKaw0xrU/meKj10Na0=;
  b=d4U0H7SHZqexHJVW1G21jb+KeGMZ0dfotV8Xx4Sei6r+r2JPqfE6rj7e
   BHNpKgAn3AXVUZm8tm2pnbo/88H2AdYYNfcnfLxvIzO9/m703/q1EjeD0
   YT7HaLKzSkUXV6Qf2bayeAjTsKSZid2rUAtKX6jBuaor+mJt4km+qD3sA
   DE4qnvshV8vC/LscnnVNOpH9TDU0jpa0g+SdkU2A53GHi0Lstt0H2YUGK
   AwQ9G8qEUd2mbcTGc056DzLs1Muwbebm2ILOial8Zeeu8KPfM39SCvGg5
   7nZ8zeBQifDKY+UdTGbSC252rwnMUiY9L8btDI4yN4qXyTZqBCpnRNnDF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="382795674"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="382795674"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 08:04:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="918291443"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="918291443"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 08:04:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 08:04:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 08:04:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 08:04:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 08:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8FOsAUqsJl/kPMjkZQLyLlF+t2X1kmRJ3nwvG0poG60OEnyV2iD39qfpI/xSpaVGHRS0W/y6Segy4VrvMlLYypFn8aZD58o/cDp5z7JSgGOamDIu903ludabKr02CO4dOS5JJBfGPRwVLLKkTFU9+4tw2O10CCyB/2wTDBgq0KCpQe365zCyZzXBAzISemymySRjiHwlJkmg8fwdGfP59gsyvKV6VNn7itoNhQBhgus5qhWPSCf7yrXzTcl0HmPF/ARtFEhRqZZ5wPsyKhgU8a0GNpbkpRhKY8e6C+5G+jd260wuuPEfNEiw5uu/augAkQSKlLJGhscndTQxKTUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65Qav6RFkhDDhkVQemmaAz3EhjJ5lQ+IVqfOhkdRwaQ=;
 b=eXVBryLjeaUyeTNUj8F3tLrNcP6gwnRakVKI9Qw9a00CujxfSJ3CHyeJfw5xBSZQ5iK5fVmEEClm//PvGdGU5W4RAXY2CM5P+8URJxgwDQkDmsVj7MHpg+ZoyPstOWjHYeIya2YsDRs2ezmDlxytTaZB1ZIpK2TAADXIt0xcG22CUcw+7ugxjfnBDySnRzkzYLFy031jrQNosM3vIf4t80qZUGdc11vKCO+M/BPLF3HjMe2Sr/kVq3m89Y2PA24d4I6RS5OU8GEm4ieQ9VBOUfs6I1ECDBZ5uJGV6VdF2hnLrqXFwKWCh3OP3fLCWYVQ29c+MGF2C8ADLe1qfoyk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7087.namprd11.prod.outlook.com (2603:10b6:806:2b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.39; Thu, 14 Sep
 2023 15:04:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 15:04:49 +0000
Message-ID: <e1e818fb-a842-eafc-d365-bd1f9314852b@intel.com>
Date:   Thu, 14 Sep 2023 08:04:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 2/5] selftests/resctrl: Remove duplicate feature check
 from CMT test
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
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
 <20230911111930.16088-3-ilpo.jarvinen@linux.intel.com>
 <40ba8890-32d1-e440-29fd-b8f8db69acc5@intel.com>
 <80695068-4a6-b8e9-107f-8d29ab3543be@linux.intel.com>
 <fb32abc8-4381-00bf-c07e-b28066f51cdb@intel.com>
 <82c78269-324-5f49-e33f-55364d94c8cf@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <82c78269-324-5f49-e33f-55364d94c8cf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:303:16d::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 354587d1-6d25-400a-f354-08dbb533f127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PiVZr73o7w4BmM0YQYNjM3X6hXxNmnDAME+i8gSxw60NvRShPvL4uFujUw/UcV7wgAyz4tm0Lhr/zO2Uhl3HhoQ9soOOpQwW6dJe0EpYlP5IKIgb+9dEtv+f5uSEoitfgO7+MhTe4zjMDlOxDI5RXIdfCGj74PYAr9TtAxOAlOGDj3B9kptcJOxtMUlWaVrmuSQH2vcw+hI96ZIbzLmA6Zvqhke6/O07QKqaw+cxweN2nCku5rQ9k42Tp+hRPH1T+X19am09tDXZgDXU7Q7bYjFai0Znk/yMWh0GA+dw5uHzWmMbdQvXO6glSM/l5YkuJGmayGuhvWWxBeJck9me3kxprIil8xgdEuTCOFzqu7Tw/ez3ElXBPaCeApqea44QSziuS2INmpKz3gOuQOzrasReJhNHnHRLcTfVG7FCf6MFKpbxpg1lAkvzSVsniU9Cw+VNDnd0yXjPCF1Z+8zLwdd5eLFXXLFoCXQxqYid8ainGdtZfbRbmBtuhiwY/pZQBwMNJ18U1H8zxt/tVQHi/LCq0k02H+gU0J++uYwX9fbxaK15gNCv01xBQEa8hUIobIVFFF0ua8RWyUNE7uV/r75S2ffrK16MIImYswZD+zJdrTtG6oZDikBQuHjxfNaR1uFjiYPEme2qK0KxjhR/gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(1800799009)(451199024)(186009)(66946007)(31686004)(31696002)(36756003)(86362001)(66899024)(478600001)(38100700002)(82960400001)(316002)(66574015)(26005)(2616005)(83380400001)(2906002)(6512007)(5660300002)(41300700001)(53546011)(6506007)(6486002)(44832011)(66556008)(66476007)(54906003)(4326008)(6916009)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tzg0eFZUMTRmL1Q3NkdSdFRKWDVxQ0dzdkVSVTFCZGU0cGFEN3VrR0c3ME9k?=
 =?utf-8?B?a2hLUXZLcklieTc0R3kwTTJBZTZDYmRicDRYN0tjUjdGak56c0VPSEpjNzBk?=
 =?utf-8?B?b0QzU2NLQzFMOVArTE5nNDhHTFREaGlYRVo0UVMvSU9WYkpoUnJjRmVnTFRv?=
 =?utf-8?B?S1hsaW9GeldmaGFocDVGSG1JcTNkVll6N2dISXU5TzRlQVhpUzFnNlFvOTBv?=
 =?utf-8?B?cUJTYmFQdlFsT3RFUXlhbm9PVkQ2S1kyRXo4Nm0vUURDdkRGSWNQMVlHVEVi?=
 =?utf-8?B?RGFnY2ZYc1lOSTBtcHdZemF6bFlPVXU2UnF4Y3BSNnFGNFpiSVVoN0NJdkQ3?=
 =?utf-8?B?STdrODNkdXN5QmV5azgwRTZUeTl0T2hxM3pacEJFMlNHUWhkVnVJVmNIbU96?=
 =?utf-8?B?UzdKcnRUb04xSFZBZTZtd2RpTkpOQkE3T1g3WDJQV3BNUzZ1M3RFT3E3MkFD?=
 =?utf-8?B?bXpNN2tDRm1TR0V4b0FuTDZham5RaURiZldKamt5bms4QWFHV2NQU3pha1Zr?=
 =?utf-8?B?dE1SKzdQemZmZnVjRUowWHBoMWFpalZ0N1RSMkVWYk11OWpjZWRpZTVSaWR5?=
 =?utf-8?B?bmJ4TUh2eG9mNHZNaHJUb3JZZ09lNEJKNmRNeGE2bjdBUVd1Z0UzRTVYL3d1?=
 =?utf-8?B?VTFiWWxXcHEvZmxUWEJRVEpxWHdMZWV5VXlVdVV4Yi9vNTlmUURJTmtYRVVl?=
 =?utf-8?B?WVN0eGhKczBUK2Zhd2NNTkZrUnRlYmtTemJQQ3pLcjI0NFV1bFBGSk4xYXJB?=
 =?utf-8?B?K1dCbkEzb3ZkdndHQ21WSHg4Z1RlYThyVkNIQWkzM2JwZzVCeXUrcFpqeSts?=
 =?utf-8?B?MXFlNENnaEMwaENsa0w4Y0RiNnpMWE1oSTVacGxCWncxMVhDK3V2ZlZPSlBR?=
 =?utf-8?B?MStod0lUNHNpcmZnaFQybk1Xb21Fa2JrL2V5YkprekR4NFJGU3VBSWNGczM4?=
 =?utf-8?B?Nmxqb204Z3p1ZUFHUVVuSHh6Z1BMbTltZnNMMEhYU3BGMVNCN0ZGQ2kyeHlj?=
 =?utf-8?B?ZlRadWR4c29jcU15a1FmVzVvNmYrNDdidlM2ZDVhVERraDBpRDhHUjByQ3FH?=
 =?utf-8?B?UGNwNE5SVVRCcjEraTZ1REFXM1ZWcWg4bnV6bmJWcDgwOG5UVzRMMGk1K2tr?=
 =?utf-8?B?c09ObWVaeVBGeGt4WVVnQXdlOUtPY0ZVNEFTRzVIbkZnRDUzRlE5N21KM0hK?=
 =?utf-8?B?aW9wZTZjNFNPcGZScGsxeXljN204ckNibUxBdFc4eWJXNkFFVldpdCs0RE5W?=
 =?utf-8?B?cjdyYVlSams4NlFzN3ZtSE1kd2xoSjFIbG56bVQ3M1BRRTF3dXRna3UrZ01K?=
 =?utf-8?B?OFFTQmtUUC9QM0lTUE9YVnZpakd3OS84Y24wVVFaaldMaDR1OUo0T2hBYi9J?=
 =?utf-8?B?clNwNmVPbUgzbUxCWkpSUjRYMXZxUzlrM3VTaitUZCtyRWcweEhiZVFuakpM?=
 =?utf-8?B?UkRHclZpUG1zc3h1THhUL1RxM00wYTBGTHlFTUlCQ1NVcFZ2K0MxYWNwYlBy?=
 =?utf-8?B?eUJyZENCUERLZ0JQMFdqZk82TktwK09rdVVmZ0tMdUdjL1RSejdPZjNXcDZu?=
 =?utf-8?B?Qmk2UW1EZnprdjl1YmV3MTRwajhnSDcxckxyQm1yNm5zTTdCbUFiTTIvK1JS?=
 =?utf-8?B?VENIbkJ3TVhNQUtIbHRXUTJQWExnSWxmME9xV01YU3ZwY1ZmYm5hM3hrTXp2?=
 =?utf-8?B?djZIMzNEbzh4RjBZWStPMm5VN2JMWlhaOTY4VnQ1U2hldmJVVUdDUHlFUzBa?=
 =?utf-8?B?ajkwZUJtMG50SVEyc1VPU1lNYVk3UDBqekRkU3EzbVE3OEVyNUE2QjM0M0t3?=
 =?utf-8?B?QXBIcTdwNmhwTWVKZ3FtcVg0NDU5V1VNTG9icUlqVGpDSTJ6dENpMFBmenhl?=
 =?utf-8?B?d0xHM3dCREZ1bU9MS2UxU293eHlMU3hwdThPZlBSK1FiMnRZT3hZclpBdldP?=
 =?utf-8?B?ZEg2RWxNZWgyUHBZNkFNWjNTYnRQMSt1MTRoeWViU3B5MXhuenVIbjFnQS9t?=
 =?utf-8?B?ZkdvWnFxeWZzQ01hYnMyOFlydXF2SHZSYWdMZmNkZzVoUGRxY3hpNGFSVTk3?=
 =?utf-8?B?aURsd1lUOGw1QTNSRUJzRTBDUm8weWRPbXhpb0JWZ2xtUFRPbFh4anpxSDVN?=
 =?utf-8?B?Y3lCa3BFdjd3c3NFcW9kZWFtcDQzc3JhbVdTMXZjUVFJQU8waHZyS3ZHOGJh?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 354587d1-6d25-400a-f354-08dbb533f127
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 15:04:49.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GU0g5CZr2/fVej+gFed1yD4adn7wq8E2bEKQ8H/x2b9c3hBzWl/7ckrSi7fUv5TvujZWgQ2wXoPuR5AdkG9pjJMQHW0u9K+KLLBxwDTy2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7087
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/14/2023 2:58 AM, Ilpo Järvinen wrote:
> On Wed, 13 Sep 2023, Reinette Chatre wrote:
>> On 9/13/2023 4:11 AM, Ilpo Järvinen wrote:
>>> On Tue, 12 Sep 2023, Reinette Chatre wrote:
>>>> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
>>>>> The test runner run_cmt_test() in resctrl_tests.c checks for CMT
>>>>> feature and does not run cmt_resctrl_val() if CMT is not supported.
>>>>> Then cmt_resctrl_val() also check is CMT is supported.
>>>>>
>>>>> Remove the duplicated feature check for CMT from cmt_resctrl_val().
>>>>>
>>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>>> Cc: <stable@vger.kernel.org>
>>>>
>>>> This does not look like stable material to me. 
>>>
>>> I know but when constructing this series I had 2 options:
>>>
>>> Either convert also this when changing validate_resctrl_feature_request() 
>>> or remove this call entirely.
>>>
>>> Given it's duplicate of the other CMT check, I chose to just remove it 
>>> (which I'd do anyway). As patch 4/5 requires 3/5 which in turn requires 
>>> this, this has to go stable if 4/5 goes too.
>>>
>>
>> Understood. This makes it a dependency of an actual fix, which is addressed
>> in 4/5's sign-off area. This notation is new to me but it is not clear to me
>> that the dependency should also be tagged as stable material (without a 
>> fixes tag). Since it is not an actual fix by itself yet is sent to @stable
>> I think it may cause confusion. Is just listing it as a dependency of the
>> actual fix not sufficient (as you already do in 4/5)? Perhaps as compromise
>> this patch can also get a note to the stable team. Something like:
>>
>> 	Cc: <stable@vger.kernel.org> # dependency of "selftests/resctrl: Fix feature checks"
>>
>> I am not sure though - I would like to avoid confusion and not burden
>> the stable team. If this is a flow you have used before successfully I'd
>> defer to your experience.
> 
> I came across that dependency format when Greg KH replied to somebody how 
> to deal with the cases where there isn't yet a commit id 
> (the cases mentioned in Documentation/process/stable-kernel-rules.rst 
> assumes there is already a commit id). Unfortunately it's long time ago 
> so I cannot easily find the link.

I see, thank you. I was not aware of this custom.

Reinette
