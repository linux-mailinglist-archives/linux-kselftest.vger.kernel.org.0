Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6D7E0B4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 23:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjKCWus (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 18:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjKCWuq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 18:50:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7DBD6E;
        Fri,  3 Nov 2023 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699051843; x=1730587843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XCN87byAhEWMpEETod+AbrdTgWaQiNEz8LxhGPnt3EI=;
  b=BjC9J26Zhs4L8cRlTe+kg0iCB5gfGETP4a2TgUOrSYh2pQr1uwM8lwtj
   rLxyPefbukqTTOuvb/X9eoBJTaaxzXTdkttYlytijHnZpwt39ZIDKuYBq
   X3rsQpkqtEpZYq2LbGunkdBtwcljIRz8lCxbqW0yvkfxez0CyuPioPNXE
   C9QtNj9aYxxXfJ+vAghYxwd8pc+GNiLTp4CgLzga9AYQNmCKplL2fiyr/
   0zyiDcAIMAWg6r3uNVn2jql1rPvcIiBQQflRYY6LlluuZMTsBgb9o8pc5
   byGXIiRE/HVeoEuTnEmOkLHbmshx7cVLzVVaz1uXVYbecRX415t7rFeMA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="379430920"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="379430920"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1008957478"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1008957478"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 15:50:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 15:50:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 15:50:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 15:50:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPPMlZ0PwxQoaBbdH2jTLcSriHWvJzhMr8X0GJw2VAS1z76PNsviSrOaZE96s6oyZvPpX/32xZMWp5oZKDJ41ALajaJi2R0Idqd12CKbuRZL6S4AvMVm2M9v8/tXThlrNC5JX8wEP5T3pGKlsl+11bNBxySusq/COsZMlBhQg6JFx6f6svJe+rTwfjBcXFSc5emlYI+smsVL7qiT/C/GfSBwkr98YNOeQYEtM8flR+znKTEaAE1k1d533DBe2sIqJPLK9fZmoAB+9Er1OC1wx6bQtJwoSdNEyQt7yTLu5jdxa/a3WR5Epgnumfst9rKS8WxVJeF2s+6KLXPsUoLytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaxixK//5QRJBMdzL7EIbxWUgN34Ge3QBMLduZtO6ds=;
 b=eNh5KWr7xSUCt2y77d86u3R8xR11S7gAYZLFYM/hOejAEyySttpDgtznPR+FJ7xaMNuOkPjfnWx4WB3scWcM9x04SwC0U+/U2JAiyxGYGlSRHOcb2Wte0cht9NY4f/fy8CAkz5SaJSNfYhkAxidFi+zT1Xk1BrjYefhBeHwVDPzMdbtTC0vDB536e4wnoOTTq1JCn2uzJGnqaS+rJiTb04qXmEVxidanx6uWvbACwcbQx+uHHgVbWQSQoxM5UJUGQX6cDkaJR4cf4xiAKd7kah++8rBMbuunnRsvU86CKRi5kRQugqWUt2CrjAVjc+07a+948Z2QsqWQDpj8w+6bEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8723.namprd11.prod.outlook.com (2603:10b6:408:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 22:50:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 22:50:34 +0000
Message-ID: <ace11119-8de6-4e68-a966-431ccfa14b9d@intel.com>
Date:   Fri, 3 Nov 2023 15:50:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] selftests/resctrl: Create struct for input
 parameter
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-18-ilpo.jarvinen@linux.intel.com>
 <d22a4ce2-9e81-4d65-8381-e5ab5fa706ed@intel.com>
 <2e266bb-653f-2fe2-9dbc-db8388f6aff1@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2e266bb-653f-2fe2-9dbc-db8388f6aff1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcc5b20-62be-4c2d-86a8-08dbdcbf4a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TV8xwE0wjEFMVeEo/14lS3bwxJrXis5eOOcaMEA9LKHwBeSCC12TcvrfbvyYa9Zd5dg72YiHjk9Ko2FxB4kqLOAWWq96vcgJcQQgTGTznCoFA+XC2uLi0kXvbUuc1CiW9yAU9N6efdvfj7P3Hkmsoamz0q4P/KFd5OF7ZLqvh3gRlxVU1uAp580qBd7uFeV3Stywy/W0VztdTKvIK+/u/8yrUavBK76y5q6Vzo1jgAw7ZZFkDSYKuQ+xnMz3jI0qkB68VeW+M/sab0haB19NLSBMZloI/OOzyRFYmGF2SOJxEOTMPNjYEYDl4ZyGAiDjnEu6rxgIf9wy1esgVplE0QebqkO5xFi+0SMjLjKjp3maswjlwOkm1PqKuTj0qKpTgv0c3Pb6aYI9lGmbh5JkZ1Gwt9cqb8pW1tdr8KLplcQopAXpHtiJAZjFaHQvqzeXL8gpCBbrme4tvpxA820F6JmYBJthostgiPY4q2dU6uIRW4ND3WedwiuXgkMz+dijFSnbIRnEonjfc62sXlE6nZ7TSHV21RZ7DCH76no1bCM0Q2OMo0V0qgnNRXVLWcZ38m0lyNBVFFKGHMYMOKI6xgNmuGE+1nnq6iaxFvyGLWG9lorPql+eAY406d0tRyboYbLcr/Wg4sykUibvK22yNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(53546011)(6506007)(478600001)(54906003)(26005)(6486002)(31696002)(2906002)(66556008)(66946007)(66476007)(2616005)(31686004)(82960400001)(36756003)(6512007)(38100700002)(41300700001)(316002)(44832011)(5660300002)(6916009)(86362001)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzNLN1UzTVZXWkhHYkUvYmFPcm1iRFhZSkUrV2JlMzZ4dHpXVFQ1SVNMa2wx?=
 =?utf-8?B?NzlXdmhyM3NHRjB4ekJBUXVKdHdndUllK1lXNCtuRUl2Q05CYVNpbFZxNlZq?=
 =?utf-8?B?OHdwaVlkdmNsQm9oQ290Q092MndLR0ZDWSthTDFWOWdsOWFpbTFMNVRIcmll?=
 =?utf-8?B?SHBaYUxpODArdXgrMGJocElYMk5YZldZSnFZa29lR0F2N0NOYXd6WmIwMjFC?=
 =?utf-8?B?MHpKdHBvcHIvemN2Q3EvRmNHRis0ajdZdDJBRUNueVhDT1RvVGZDRzFZRmY0?=
 =?utf-8?B?a2lmelRzaXFGaWdKYlprNlFvMDBzd3Y3Z3J6emgxYWh2ZE52S2Y3UzR0TTlD?=
 =?utf-8?B?RjQwQ0NDZ0M0K3dSN2FUU0x4eisrNWxaQnBPUGhYMTRGRGdtTkxTdTJERlM2?=
 =?utf-8?B?VjdFQjQ0UnJoaUsxRk9YMTBGT0RMSXd6c2FvaHlIc1ZGMXc0TkN6cnlWZ3NG?=
 =?utf-8?B?VDlzL3dJZktwbzdyZVZyM1pSNVBRZVVPbXZOMDBRV3RsbGR3Skg5WWJxVGRB?=
 =?utf-8?B?ZmVGYVZxVlQrdjBHWkd4UGtubStNOXVuL0NzN2dSNVZSMHg1L211S09iM1pr?=
 =?utf-8?B?M0w2VkM4eXpERU1OQnB1R2Qxc2U0d3NJK01BYXhvU0kwTFo4UXcvd1BhWHNF?=
 =?utf-8?B?WnNDMnpRNENScVg2WUxKZTdEK01NSm1PNFAzZDhrKzBvQUxYcllCNVJUS3R2?=
 =?utf-8?B?cUVjOHVEeHZ5TkVITmQxNmw2U3FGUHErMThTWnRYU0t0Z2dnTGJXcFdCMVR1?=
 =?utf-8?B?RTI0TUhBdS9WTTl2ZDl1NFB0V0JoWG5zOFkxd2QyWldWcmh5V0YwMWZad1Fo?=
 =?utf-8?B?eTdIbzh6R3FDQTV4TmVablJJbk8wZmpSdHEzSUMyU21ReXJiNUJLb1B6alJU?=
 =?utf-8?B?ZG0yTkNNcDhQRGRwMG84SjE0cklJeVAySHNSbjhjdEdzd2dkTjdCWkJ5cHZm?=
 =?utf-8?B?SkF3b3hzZzJXZUV5NkpNckFEcWRxeXJWQkpsWTRVdEZQK0xEMmNCMnVTNXkr?=
 =?utf-8?B?NTlZM1lFMFNrdDRZaElXYlliZEdIdUx6TlRqUUFVdFRCT0hJc3oxR0hzM3Iv?=
 =?utf-8?B?d0lBSjZrYmJCbVo0TjZFOG1XUFRGYnI4cG5qTURUQ0MxV3hYSHRkL2JKc0hR?=
 =?utf-8?B?bjlRalpoeUJKZkxWcFY0cmYzOFZCcGxKZUw3YlFjdlZHLzNHcVh2WWw5dWc3?=
 =?utf-8?B?bTN5QUpGeUFYNVpEM2NDcTlZQ3ptaEx4K0JXRDNBNFpydHJVWDMzRkg5Mm0y?=
 =?utf-8?B?MjQwZytJS1NlKzd2VCt6OTdEcGw2TWFXSXVoTk9XeGNUNVg2a3JzWlFQeVJx?=
 =?utf-8?B?QWYxWEd2VWtVQnFHSXdtV3ZoZ29sQXN1eWVhTkxNVTJlOVBOQUhQazN5cWN0?=
 =?utf-8?B?UkppWit4YVVXK0s4alo5OGV2Zk81Qi9qeHE1bGRLaE9zd0hTL0I0UmVBRlRq?=
 =?utf-8?B?eU4xakRTQ3Y2b01mTE1sdGxCSWRHamlIdVRTQTRTRVVHZk5nQzZ6ZEtMRVE3?=
 =?utf-8?B?UzRrek91aFVBV0Z5ZlhoUFAxMkc2QjV2QjBLQmdLZG9QaXNERWF5dExkUnFs?=
 =?utf-8?B?aFpsUGJZVXQrSEViWUZFSnlTd3k3dWRHYnUxT3BTNE9aWEZtblE5UHA0YnJE?=
 =?utf-8?B?eGRyckNRQk8xdzJ5UlBxdFJ5d0JBWVp4dmI0cVk5Y3pvSU5rd3lFTit1bFNr?=
 =?utf-8?B?KytOeEIvVnVMMXZnUm9PSCtKT1l1UWxEY00vMnQ1RUVka0lCdURqK2tuT1dZ?=
 =?utf-8?B?NWRsMTNVcUtpMnY0aDJXaExBUUNWNVhXQng1Z1gwMng0cUpVKzI0UVBsUndr?=
 =?utf-8?B?d1g4UnJ6ZkRJS2VWMUdoeFMwM0UyN3NjMDhsL3Bpb0xaaUlSbHpvNktkYlIw?=
 =?utf-8?B?VmV4NkhGSzdVOGtOamV4SERDQjRIQlREMTN6RGU5TDhMNDMvZk4wWWUwNUJ5?=
 =?utf-8?B?a2hCcEc0Nm1nT3AyWFV4bVRvR2VVckZDemR3aU5IMXVvakVrbVVwN3JmYjla?=
 =?utf-8?B?VXczQ3pZZUFxdTZ1eHpVenFmLzZJcDhqWGl5SFdONjJWcG8ybVFIN0czSTJW?=
 =?utf-8?B?RlNTWTZWVjlJL292dkw0cWlqR29lN2xOOHFzVTVaM21IZG5PdkJHcFF5MUpJ?=
 =?utf-8?B?Ni9BY0ZCeVpiNFV1bS9RSFVXc0E3WG0xUnU1TzZ2ckVEZy9JSzlHY1F6K2t5?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcc5b20-62be-4c2d-86a8-08dbdcbf4a46
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 22:50:34.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GW8SMwqpLPwAtH6odGPi7M1naHP1F6eNHq9efi3ONr2coKcW8s15V64JePrQE5KK5r6++l+J2pFZrxVReTyYOBo8OPgOgvheXzeqZwCYuck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8723
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 11/3/2023 4:24 AM, Ilpo Järvinen wrote:
> On Thu, 2 Nov 2023, Reinette Chatre wrote:
>> On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
>>
>>> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
>>> index d3bf4368341e..5157a3f74fee 100644
>>> --- a/tools/testing/selftests/resctrl/mba_test.c
>>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>>> @@ -141,13 +141,13 @@ void mba_test_cleanup(void)
>>>  	remove(RESULT_FILE_NAME);
>>>  }
>>>  
>>> -int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd)
>>> +int mba_schemata_change(const struct user_params *uparams)
>>>  {
>>>  	struct resctrl_val_param param = {
>>>  		.resctrl_val	= MBA_STR,
>>>  		.ctrlgrp	= "c1",
>>>  		.mongrp		= "m1",
>>> -		.cpu_no		= cpu_no,
>>> +		.cpu_no		= uparams->cpu,
>>>  		.filename	= RESULT_FILE_NAME,
>>>  		.bw_report	= "reads",
>>>  		.setup		= mba_setup
>>> @@ -156,7 +156,7 @@ int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd)
>>>  
>>>  	remove(RESULT_FILE_NAME);
>>>  
>>> -	ret = resctrl_val(benchmark_cmd, &param);
>>> +	ret = resctrl_val(uparams->benchmark_cmd, &param);
>>>  	if (ret)
>>>  		goto out;
>>>  
>>
>> How about a new member of struct resctrl_val_param that points to 
>> uparams? That would remove cpu_no from resctrl_val_param
>> and have everything available when a test needs to run ... not copying
>> some user parameters into struct resctrl_val_param and passing
>> others as parameters.
> 
> I'm a bit allergic to adding more stuff into resctrl_val_param. It seems 
> a structure where random stuff has been thrown at just because it exists.
> In general, your point is very valid though because the members of 
> resctrl_val_param should be auditted through to see how many of them are 
> even useful after adding uparams and struct resctrl_test.
> 
> I could get rid of copying parameters from uparams to params and just 
> passing uparams instead of benchmark_cmd into resctrl_val(). Would you be 
> okay with that?

I am ok with that. I assume this implies that cpu_no will be removed from
resctrl_val_param?

> Oh, and I really should rename resctrl_val() one day to something more 
> meaningful too. :-) (but it won't be part of this series and will likely 
> be another conflicty nightmare because resctrl_val_param too needs to 
> be renamed...).

"Naming only" changes that are not part of something more substantive are not
very appealing though.

Reinette
