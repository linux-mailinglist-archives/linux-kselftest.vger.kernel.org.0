Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67BB7A0BC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjINRaM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 13:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjINRaL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 13:30:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A871FF2;
        Thu, 14 Sep 2023 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694712607; x=1726248607;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q75hdH2UBzDlmOVfQEkDE7H4bdikN+FRh39oy+axwjA=;
  b=gRmCFaeQOHCTULdYseJXQpHcFNa8nbHWBOqiioZzkQrpQM2E3xsHDLJM
   0MY1eB5GJ8Psk09f6ZANEB5UBpTDWZDZKIkVXtMoBNa9lnYQpMerXW+iG
   ud4dSEUQ4NqerDI5EBM3Zh8rCHDoEpCpcoZpaV7gFg4oFCcNZxTK6HL4J
   6TvpNTp8VNTT6mnp01XRFgPU/3bn59QFsSN/J5aZui/i865zEPCpze97s
   yhwnVtfkcrXOueb/FDwUyBHesl4ZIptj2FtizyDL0qLertVe5QGqggSL0
   Hm3Oj4wdroYby8+A4vRegZ0LgOF/5PZkQ4162HLAY0PRMvUIE7ExedbqB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="369322311"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="369322311"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="773962181"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="773962181"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 10:30:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 10:30:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 10:30:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 10:30:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 10:30:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oT82tqPA00KUiPEqQU8AylfSFnb0rzf2tuyq+IXmcMqo76Ratq2/x15RNwE0XUTzL5qlA8TcP+UAMfD6A4jSqCQNgobOpmQxELtEJVD8xgG2buhcZT7bn5uQYuDpuru8co8Uxog+TxsNFzGEfxTMJy0ddU3X50z5eX9aOh2aFQnWIhvLs80mHzvW74qhsV2Rv6Ud4O7OU7fg56T8lGhSJgkUCjsrhBGv8OxTw5AaTBOaDFZ/qY2fr9GP9qflvY/5RmdybS7pNKKPbYN8Glad76zPdNSL1MgWVylQp2NTJv1GR0euV5CR1544PnoJJZLFrdLTHJJGiqYHnDyMS1qEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRWDyCVL3JnGvkOpoMhCg1IvzBtoYL57shZIIfKg11Q=;
 b=VarWDM2JSFsNDOqOJ8rI3etecXZDBiCRlgQOjzricz9hDdSRv7oiYxnmMd7pT7xIIKRPL4qRlqw6idL3x1uG4tzD0NWg3GDSEV+AGlp+jx3NTDnWTiMoqwaNJjP226Fi9ifT3vqYuWNvJrIuCjphYBh7Yu59CnJNZUGMb9+Q5rK2q8F14F+qGpzpmjCPG9CSAxNmOAtssTG6+AeDYEo5r/PzwgwanPsTu9EnY8Zk2J5Qu01xEJagMmk2AC6/y0nNu4H0ekWMUqY48N0p6tmFqfGdADg7HyFe+AKbELqnHqOGVATTC0X2WD6w5/MAfUIZ8KP4RVzUE341zWm3CwmZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB7950.namprd11.prod.outlook.com (2603:10b6:8:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.39; Thu, 14 Sep
 2023 17:29:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 17:29:58 +0000
Message-ID: <68e2a732-3016-a8a6-3f16-3c9ea1a0f9f6@intel.com>
Date:   Thu, 14 Sep 2023 10:29:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH 1/5] selftests/resctrl: Extend signal handler coverage to
 unmount on receiving signal
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
 <20230911111930.16088-2-ilpo.jarvinen@linux.intel.com>
 <4176a620-4cec-5d57-42a3-a15c0fe3eb73@intel.com>
 <aab4b1cc-6eb5-c324-e97e-c6699e2d165@linux.intel.com>
 <d6cc3829-9b7d-6a0b-c734-c33f6a66959c@intel.com>
 <9dfe761f-6779-44c6-c227-5175d53ac25@linux.intel.com>
 <b32f4bd1-9e99-3daa-9d39-8f241b41170c@intel.com>
 <52478b0-15e6-9072-df34-612ec0ebfa@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <52478b0-15e6-9072-df34-612ec0ebfa@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0344.namprd04.prod.outlook.com
 (2603:10b6:303:8a::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c47fb68-749e-4e5e-dc00-08dbb54837ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQReZB24l/Bo4mZS5b5eSk82scDt2PfXCo20jQaio9zyTL6RT2A1PdjZVXYXGr96Sc0Ko4MLHNLVqxqSKoG8WvdQiLPO3TSEN6w8eHoAYA6bMp5wjIPzsCQUMIJcYBu+aqLFLbIBScaRSiw7QU/tQFS6YJkTfU1dFgBjLJTt3REhJRKwFRRuw/9Wj/6nTXCN5KU0UIM7O6OyRmvlbNI/byO6wNIF72vs3pgtFyRbgs/X4MvlIipM9JKOAPo16KtulyFroEd+g6ExhhKX0sZ9f0BuEbFA/hX/v8YAk0PaKhBdCcM+S/Uz1dKOJMeZ0N/COMx7xsrI3+ici7ikAgpPQlkDsrCkSEZMxitw1cqfdhEOUX2nUxQcvAlyTgmC7ZPg8WniOcM8qG1Ec5NwsSr8Wd10defQz8A0UzlbdEYcBQlhvkb4Cw7QBvSFK9EKEzc0Q8my0BnzELe3ql7ELwAefQ63njnpgSo95todAFB5FXiDCndNGYioVQ/irG//OqCT92puLCUmqRtCgLYvFSlaBtqdxvX3IAXpRwc2cTj+3q81+U194/QGe2YSjLkaEuq0bipvyVREUuTGQXpKmLQcRerXEdQKooSct2/o83RXk0Inj5GeTneAt7ZKCseP+zmUtJXSDLdWh8gzN7MlHL1j3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(186009)(1800799009)(451199024)(31686004)(6666004)(6506007)(6486002)(53546011)(2616005)(36756003)(31696002)(86362001)(38100700002)(82960400001)(26005)(66574015)(2906002)(6512007)(478600001)(83380400001)(4326008)(6916009)(5660300002)(316002)(8936002)(8676002)(41300700001)(66556008)(66476007)(44832011)(54906003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHg3amNrUUlsRFcxV1dGMStoeENBUlVnMDBVSFl3cDFEZC96bzBmclFSYWdl?=
 =?utf-8?B?WWl4dXFZeUlWWWFreEZIR1BjbnJCN291c21Kb1NHMERvTmVRbnVGK3kwUUdo?=
 =?utf-8?B?SmlaTVFIRmtkeUdVenh2emc5UXlBVW41OXN2MngvWGVPSHExa0dWbXQzRnpS?=
 =?utf-8?B?eVg1K01wdWhkUlprSGdrQVlZNDBiWGNaaVc1UUMwR3lpcjNqRTN1WGxKRXg4?=
 =?utf-8?B?TUdUY0hQOXZIWm81VU5mUlh2cEI0cURyMXlKam9UY0hCNGdXWHVqU3ZmaHE0?=
 =?utf-8?B?LzhUeDRMV3l1Y0ZaUUhaM1FFMll0TjFtejM5OVEvczZDNnJFLzB0bFBCSFZY?=
 =?utf-8?B?UjZlVm5jcDlZVUFYRFNLZGN5dGxXNDlxNzNIazJUWnBndWRPTDJjVU84UnlV?=
 =?utf-8?B?N2d4SVlUSVl6ajdMRytHZWdTdEFWNkJTMHRwNXNLTDh6QjNXSERZU2w0YTFG?=
 =?utf-8?B?UlRJa2FEa280YWNudXZHODhjVDBraGdYdkxHUDEyRW9ram1OV3VmUGJ5Qk9B?=
 =?utf-8?B?SXpQZC9MbHR1Yjd2MC9jNnJwNldxUFlEcXFBeThTakdTdThnSHN1VHFvejZw?=
 =?utf-8?B?UGZNcjZyNURvVVppSHZQZW0vd2Z0L0Jub0t5d1YvZmFQaEY5VU1pQ1J3UUxr?=
 =?utf-8?B?TldlRXlyNlBFN3BkaDlEbmNKcS9BaUF0eDNvZnAvNlVuUW9hd2dhRGljQjFH?=
 =?utf-8?B?bjU5ejR3OStTVGRoWDFKMXJHUzhiL2E5a0hudFYvM2JKQ2ZEaGpUS0hvV0M4?=
 =?utf-8?B?ME8rQWdabHh4ZWNiZWVMUlgyL3kyY0hWZWFMSE1pZGZnQlliRC85ZzZhR0Ey?=
 =?utf-8?B?VllIWk14NmplVURyRGZ2RDZXVDBnSTM4SlY2Yk1OQ3poNXlWTjhMc0FwOUlX?=
 =?utf-8?B?TW4zaFdqS3RtaEszd2RsSHVKS0dhTVhMZ2dTSitjWDdMcWg2cnF2NnNqMGZ0?=
 =?utf-8?B?enpUQmJJOEY5TzNFVGdUbFhFRmh4U0hiZ0RVbit0QmMvTzVqQVAwNmRrdFVO?=
 =?utf-8?B?WDZxSnA2ZkhXM3BTOWJPSUlob2hQaHdFM0p2OXIyVVpjdWR5dDdEMFpoVmxz?=
 =?utf-8?B?TFdGUE1hVXR0RHN2N0E2M1cwOWU1SVQ4Vk1qNEFpUkFQMElEQkFmak5kc0VQ?=
 =?utf-8?B?aWxaeStUZHBFOUFoVDRJZktnTjVibHY2bTFTWVd6dHFCU3V2bG4rT3NVd2Fo?=
 =?utf-8?B?MW1nSWNaYTZTWVR0QzJaM3NlZWM1WXE4bHc1MGw5c3h2M3BFclB0NGZ5UzRr?=
 =?utf-8?B?U3NxTzIxaXBtblgwakxOZGpLMlNkS21LVnpYZCtPQkJUYkVSd3hzNWZDQmxl?=
 =?utf-8?B?a2J3S1N3OHExSm9YdGhYQ1VTczNWR1d2YVR4QUxqd2pEejc3UWVqMWxYN3ZO?=
 =?utf-8?B?T0xvWlFPVS9TUndJdXVQUWh0eFhJYXAwM3czb1ozRk42SlYvSjRQOWhZaldG?=
 =?utf-8?B?NUdIWFBHa0hrdFpUVy9XMlJDSTBCalUxRktLdTFTdGFaRnlSK2FVaGxpdUZD?=
 =?utf-8?B?NkQ4dE1yU2N1NGJmNStTTmtkazR3KzRjSFZ0Ym1FaEZFK09Sb21MbmhHZmJH?=
 =?utf-8?B?Tjl4NDd2Q2tUcDdvVGxmQTlCbUx3K3BrTnc0YzdpN2VMS1ZYNlFSWldxN09x?=
 =?utf-8?B?QmFUVUg1RUFTcHBHck1YWlBTWnQ0YUVyUmJGRldnaTY3MGVaelhVZkwra2hu?=
 =?utf-8?B?UkkvOHE0OGZUTVdNa09LMkt4S3pYTml3V3AxaklSZFBnNVh4VSs4aXJpdWRi?=
 =?utf-8?B?cnp4L0Y5UkNlYm1ndE9tSHBjTDRCODRXa0tWWmRodnpGU2VyNXNMMTBXazhm?=
 =?utf-8?B?Wk84ZnFXTjJqeDRxMCtVazhVRjNpOGwwQXgwUVRrZDA1clU0Tk5pd1NqbjBE?=
 =?utf-8?B?dkVodW16alQ5Z3h2T0RTNStKRW1iVGc5TGZxL2ZYRTJ2Yy9Id0gxY2cyWGQ2?=
 =?utf-8?B?WEpUenp6cFRUaytTL2JyTFAxN0ROckZXeElnejJTVVZJWXJ2T3duYk5QZ1hv?=
 =?utf-8?B?TzdBNmgrUFFzWFFBbHBDZTZTbjBUZ3VSQ2ord01kRUxuWEVmRzVWMWxMWUxI?=
 =?utf-8?B?SUwwNjVJOFdTTHIvQXhhRnRFVU9ISXdyeUtzN2NpclZVb1pTOWZ6djVyYytP?=
 =?utf-8?B?ZUNKMmRrRHhwZzRZYW93dnpKKy9EUk1oSGZNN3lLTDA3K0VPYjdOb0VrNEZG?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c47fb68-749e-4e5e-dc00-08dbb54837ab
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:29:58.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJK9xu6iXQzdh55rs2/gk2+NeCE+twBu76N7p70t8xhvpzlcajdd/bfo5bOfkicg82zVYwwu8lSkblZBmlRC0NhsaRBo5/lslDb/9KZg7z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7950
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/14/2023 10:05 AM, Ilpo Järvinen wrote:
> On Thu, 14 Sep 2023, Reinette Chatre wrote:
>> On 9/14/2023 3:16 AM, Ilpo Järvinen wrote:
>>> On Wed, 13 Sep 2023, Reinette Chatre wrote:
>>>> On 9/13/2023 3:01 AM, Ilpo Järvinen wrote:
>>>>> On Tue, 12 Sep 2023, Reinette Chatre wrote:
>>>>>> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
>>>>>>> Unmounting resctrl FS has been moved into the per test functions in
>>>>>>> resctrl_tests.c by commit caddc0fbe495 ("selftests/resctrl: Move
>>>>>>> resctrl FS mount/umount to higher level"). In case a signal (SIGINT,
>>>>>>> SIGTERM, or SIGHUP) is received, the running selftest is aborted by
>>>>>>> ctrlc_handler() which then unmounts resctrl fs before exiting. The
>>>>>>> current section between signal_handler_register() and
>>>>>>> signal_handler_unregister(), however, does not cover the entire
>>>>>>> duration when resctrl FS is mounted.
>>>>>>>
>>>>>>> Move signal_handler_register() and signal_handler_unregister() call
>>>>>>> into the test functions in resctrl_tests.c to properly unmount resctrl
>>>>>>> fs. Adjust child process kill() call in ctrlc_handler() to only be
>>>>>>> invoked if the child was already forked.
>>>>>>
>>>>>> Thank you for catching this.
>>>>>>
>>>>>>>
>>>>>>> Fixes: caddc0fbe495 ("selftests/resctrl: Move resctrl FS mount/umount to higher level")
>>>>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>>>>> Cc: <stable@vger.kernel.org>
>>>>>>> ---
>>>>>>>  tools/testing/selftests/resctrl/cat_test.c    |  8 -------
>>>>>>>  .../testing/selftests/resctrl/resctrl_tests.c | 24 +++++++++++++++++++
>>>>>>>  tools/testing/selftests/resctrl/resctrl_val.c | 22 ++++++++---------
>>>>>>>  3 files changed, 34 insertions(+), 20 deletions(-)
>>>>>>>
>>>>>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>>>>>> index 97b87285ab2a..224ba8544d8a 100644
>>>>>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>>>>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>>>>>> @@ -167,12 +167,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>>>>>>  		strcpy(param.filename, RESULT_FILE_NAME1);
>>>>>>>  		param.num_of_runs = 0;
>>>>>>>  		param.cpu_no = sibling_cpu_no;
>>>>>>> -	} else {
>>>>>>> -		ret = signal_handler_register();
>>>>>>> -		if (ret) {
>>>>>>> -			kill(bm_pid, SIGKILL);
>>>>>>> -			goto out;
>>>>>>> -		}
>>>>>>>  	}
>>>>>>>  
>>>>>>>  	remove(param.filename);
>>>>>>> @@ -209,10 +203,8 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>>>>>>  		}
>>>>>>>  		close(pipefd[0]);
>>>>>>>  		kill(bm_pid, SIGKILL);
>>>>>>> -		signal_handler_unregister();
>>>>>>>  	}
>>>>>>>  
>>>>>>> -out:
>>>>>>>  	cat_test_cleanup();
>>>>>>>  
>>>>>>>  	return ret;
>>>>>>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>>>>>>> index 823672a20a43..3d66fbdc2df3 100644
>>>>>>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>>>>>>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>>>>>>> @@ -73,8 +73,13 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>>>>>>>  
>>>>>>>  	ksft_print_msg("Starting MBM BW change ...\n");
>>>>>>>  
>>>>>>> +	res = signal_handler_register();
>>>>>>> +	if (res)
>>>>>>> +		return;
>>>>>>> +
>>>>>>>  	res = mount_resctrlfs();
>>>>>>>  	if (res) {
>>>>>>> +		signal_handler_unregister();
>>>>>>>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>>>>>>>  		return;
>>>>>>>  	}
>>>>>>> @@ -91,6 +96,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>>>>>>>  
>>>>>>>  umount:
>>>>>>>  	umount_resctrlfs();
>>>>>>> +	signal_handler_unregister();
>>>>>>>  }
>>>>>>>  
>>>>>>>  static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>>>>>> @@ -99,8 +105,13 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>>>>>>  
>>>>>>>  	ksft_print_msg("Starting MBA Schemata change ...\n");
>>>>>>>  
>>>>>>> +	res = signal_handler_register();
>>>>>>> +	if (res)
>>>>>>> +		return;
>>>>>>> +
>>>>>>>  	res = mount_resctrlfs();
>>>>>>>  	if (res) {
>>>>>>> +		signal_handler_unregister();
>>>>>>>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>>>>>>>  		return;
>>>>>>>  	}
>>>>>>> @@ -115,6 +126,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>>>>>>  
>>>>>>>  umount:
>>>>>>>  	umount_resctrlfs();
>>>>>>> +	signal_handler_unregister();
>>>>>>>  }
>>>>>>>  
>>>>>>
>>>>>> This adds more duplicated code for every test. Have you considered a
>>>>>> single test setup function that can be used to mount resctrl FS and setup
>>>>>> the signal handler paired with a single test teardown function?
>>>>>
>>>>> Yes. Consolidating all these is among my not-yet submitted patches.
>>>>> I just had to do a backport-friendly Fixes patch first for this.
>>>>>
>>>>
>>>> Could you please help me understand how the duplicate calls are more
>>>> backport friendly?
>>>
>>> Hi,
>>>
>>> It's simply because the refactoring that has to be done to be able to 
>>> introduce the generalized test framework is much more invasive and far 
>>> reaching than this patch. Essentially, all the call signatures of the test 
>>> functions need to match and the feature checks need to be done in new per 
>>> test functions too. This is the diffstat of those changes alone:
>>>
>>>  tools/testing/selftests/resctrl/cat_test.c      |  21 +++--
>>>  tools/testing/selftests/resctrl/cmt_test.c      |  26 +++--
>>>  tools/testing/selftests/resctrl/mba_test.c      |  20 +++-
>>>  tools/testing/selftests/resctrl/mbm_test.c      |  20 +++-
>>>  tools/testing/selftests/resctrl/resctrl.h       |  43 ++++++++-
>>>  tools/testing/selftests/resctrl/resctrl_tests.c | 220 +++++++++++++++----------------------------
>>>  tools/testing/selftests/resctrl/resctrlfs.c     |   5 +
>>>
>>> (tools/testing/selftests/resctrl/resctrl_tests.c --- part would 
>>> be slightly less if I'd reorder this patch but that only 24 lines off as 
>>> per diffstat of this patch).
>>>
>>> But that's not all.... To be able to push the generalized test framework 
>>> to stable, you need to also count in the benchmark cmd changes which 
>>> worked towards making the call signatures identical. So here's the 
>>> diffstat for that series for quick reference:
>>>
>>>  tools/testing/selftests/resctrl/cache.c       |   5 +-
>>>  tools/testing/selftests/resctrl/cat_test.c    |  13 +--
>>>  tools/testing/selftests/resctrl/cmt_test.c    |  34 ++++--
>>>  tools/testing/selftests/resctrl/mba_test.c    |   4 +-
>>>  tools/testing/selftests/resctrl/mbm_test.c    |   7 +-
>>>  tools/testing/selftests/resctrl/resctrl.h     |  16 +--
>>>  .../testing/selftests/resctrl/resctrl_tests.c | 100 ++++++++----------
>>>  tools/testing/selftests/resctrl/resctrl_val.c |  10 +-
>>>
>>> That's ~500 lines changed vs ~50 so it's a magnitude worse and much less 
>>> localized.
>>>
>>> And rest assured, I did not like introducing the duplicated calls any more 
>>> than you do (I did not write the generalized test framework for nothing, 
>>> after all) but the way taken in this patch seemed the most reasonable 
>>> option under these circumstances.
>>>
>>
>> hmmm ... I did not expect that a total refactoring would be needed.
>>
>> I was thinking about a change from this:
>>
>>
>> 	testX(...) 
>> 	{
>> 	
>> 		res = signal_handler_register();
>> 		/* error handling */
>> 		res = mount_resctrlfs();
>> 		/* error handling */
>> 		
>> 		/* test */
>>
>> 		unmount_resctrlfs();
>> 		signal_handler_register();
>>
>> 	}
>>
>>
>> to this:
>>
>>
>> 	int test_setup(...)
>> 	{
>> 		res = signal_handler_register();
>> 		/* error handling */
>> 		res = mount_resctrlfs();
>> 		/* error handling */
>> 	}
>>
>>
>> 	void test_cleanup(...)
>> 	{
>> 		unmount_resctrlfs();
>> 		signal_handler_register();
>> 	}
>>
>>
>> 	testX(...)
>> 	{
>>
>> 		res = test_setup(..);
>> 		/* error handling */
>>
>> 		/* test */
>>
>> 		test_cleanup();
>> 	}
>>
>> I expect this to also support the bigger refactoring.
> 
> Okay, I'll do so then.
> 
> However, having already written the generic run_single_test() function 
> that is part of the generic test framework, I definitely don't feel those 
> helpers would be that helpful for it. It more feels like they'd make the 
> flow less obvious by adding those two extra calls there but that's of 
> course matter of taste.

Sounds like there is some room for improvement here, perhaps open coding
the test_setup() and test_cleanup() helpers within run_single_test().
This is purely speculation on my part as I have not seen the code.

Reinette
 
