Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E85F462089
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Nov 2021 20:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbhK2TeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 14:34:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:1552 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236353AbhK2TcX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 14:32:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="234783003"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="234783003"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:27:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458560699"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2021 11:27:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 11:27:49 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 11:27:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 11:27:49 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 29 Nov 2021 11:27:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+Dpg9NYzWuljmVq6im0GLtnoVwKVf6VJfE3tSwk8W8YD+Z+V2aCXr4hAv9jE2kMqCDWZOQ4wkDZ1OlGrei8TpPH/WV4SWZxSOj2yxxVqZF8DM82PUvVJsN1xpGkp5b17S9MZH7rhWnsSffq1jkJaNUqf/LfQUiOjLueVOBWx8zI3cNJEVtvw3F2jFJikZE3an+jz+MpBmbSNZ0TXxa+JJj3Fw/i2zuxin6qRLkmwgyD9gvEeVWlW5AnbAbtnE4M4EbUxtIz8y+IBxFNiGqP5J4JbPgrO6a0p0tnJSI+9L+Wd2sKqYEvuLtXakr0s4gg85J/7YZxzurWXcdUM1c2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyrgsUNDdI8C8m40cC4g3UsLCOqfG/B39GUL3a/qFM0=;
 b=d4R51jo2xMQt8s5TWR7Xl9D7GRi54rum2VeybiI9Khh6wzpWB6Sc2AguN0Hqfa2L7pzPLaHPL7mVXk7h2OVsWN5E6dnicj9K0Tvh15kSHHI4TmNOmAtpbZyFPwwP79thrsvDzdxhG5UJv+WmsCrDVogiOcUUe5vBkXan8X0ZKnoc1b7FhyvVhmkmXJvcWo/qZtfSAU7xkRgVRPR13JGtAhEGXydJlIXcOQkWzxWnYh4yrJ9qumlZrNJNRWTcbTNdvDrgJfP4q/m4FXYCThM6ojt3iSjLV1kWlsnklJ71THxY/nldQDBypK7Ty8TAcnbbtD3fsS3sNaqgpTSsdaddfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyrgsUNDdI8C8m40cC4g3UsLCOqfG/B39GUL3a/qFM0=;
 b=W7jdK0MEtSlvauXI6SDlo1kMTsljQiVwgLwb+JCdtpuFr59+/pqh84YUBj6ARZ4ql/JC6jFeBdIgLGejDZlgQWrM6x6eQWz3XfISEzZTzyONkxX2n9MI+6/UxStSkh8nGp2AZBrO/w39N8EkhzHc+/r6ZiYN6oyBjZTMHE2eODo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1844.namprd11.prod.outlook.com (2603:10b6:404:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 19:27:30 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4734.023; Mon, 29 Nov 2021
 19:27:30 +0000
Message-ID: <08708d7a-4d34-3817-032f-25698a30551c@intel.com>
Date:   Mon, 29 Nov 2021 11:27:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 1/3] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
 <20211110093315.3219191-2-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20211110093315.3219191-2-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:303:b4::16) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW4PR03CA0251.namprd03.prod.outlook.com (2603:10b6:303:b4::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 19:27:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b7977a0-396f-41cd-70d5-08d9b36e490c
X-MS-TrafficTypeDiagnostic: BN6PR11MB1844:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1844753F186F3FF68BACFD20F8669@BN6PR11MB1844.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3TRfkRFLv3i7iIRw/Mn7/A8zFQ6mWZGdP84TxPW8fA0dzbzO3fnaFnlgr/31SdbX91WEMrTvv6RJPJlDE0xLixoPGQnG+1OLEK411vxyU0IM5HCPobpimsjZEVeGeyTykpS2OwyFim4OunX3guixHSyce+dTBjG6sZV1ZyuhnY4GbXXW2bjBy2uEIFLfXfHfpHSajtsRQwCWtOBw/Kz79vrDXGxPY3UM5/dTa3Ol0LQDtxgJyOOrPrP6wKIMP6Y6ejNVYS17s2yXL23E6qJGcnWL5+TkEZfR3frlqmgTlp2zvrXD31Vg1wE0MJxTCDzaawBAxOvG/0n0TOzznUaw8XCIYD5Vog71BUBxQWbYATxQ611stLRZ2UGmZ4vvtWwNVO7EOGEEuHGPZssFUJ5RPNu7HwKpf7PamIinDysrrmF9o8JtSljkBpV3l9tZ8qRtP62M3mokeH4hR1CAywDztIENqCqjDap+SDk3ft0XDmZaBmM5zIS0fnJe5C0i5cfMjtzm81KYUQCqD5ir52c7Tv9OBcSjzdcmfTdRZgIERbwHLBX1Tsm3rKvglXlVN+/Y6twW3fjVTMMABrmNLHgasCKIVZpZzKIbxUHvMe2/b8+4McJAAi9a4XLuzBZLH/mqm4yRbbCV6bgjIMnVXwkscuShFavewl7MV465C5uDgZj2WuVgsOGE0Bl7NNgAoZKiYX784BZFbPx5zHe7zCksPqX/ySSME67ra8YDu5GoboM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(5660300002)(31696002)(8676002)(2906002)(508600001)(82960400001)(86362001)(4744005)(38100700002)(36756003)(83380400001)(110136005)(316002)(16576012)(31686004)(44832011)(26005)(186003)(2616005)(66476007)(66946007)(6486002)(53546011)(66556008)(956004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnhBVkIyMXhzY2lSVDJpOEFoZVN4dnNXMHhnS0E4aXJ0TTdQWTRBdlR3TWxu?=
 =?utf-8?B?WUdtQXlOQmlqemJTQnk3cWdJNFZMZUN1UkgxdkwvaDk5YUJ4L0lCNEIrSjVI?=
 =?utf-8?B?V1dYeVAxczRxTXJaanhRRFRQTTRNeHpsZkdOVHNrUkNzN0xOc25ScnJlT2x1?=
 =?utf-8?B?ckVyL1pHY21hNG5JR09OUlUvN0w3TmhkZU5SREMza0RLblJ3dy9OZHpBbVVX?=
 =?utf-8?B?VlY1anBFWGNuQjR4d0ZFZzRJSkRTVENwc1lRV2QwRkg5VmV5Z3VjbWhpQllS?=
 =?utf-8?B?UGQrenAzaDBxUDZQUUZHendqeXZxR3A3bzI4NEhMVHV1ZkYvbFVHRktiTG9K?=
 =?utf-8?B?ZmRiSTUxc3dTaDh1dCs0cUkrejdOd2k4VjVKYi9vdVI4RDJwL21KUUxEQjBs?=
 =?utf-8?B?akI4Mzl4UitlcC94VXlKa3hSTE4yZFBtYnBRa05FYkFXOC9YL3FJVTJtaDYy?=
 =?utf-8?B?YVpMMlMrVFJWaXAvY010a2hRTFgzM3R4YTNPN2kvUEI3NWRncEtyRHVkMGtZ?=
 =?utf-8?B?MURKN1JmTERMS2FHUS9CcjY2SUxTRzl2R3hvQzRIMWNNUUU1Rk9qaHFyb0lj?=
 =?utf-8?B?Vnp4RWJaakNEMFJ6cUZzU2gwZGtoZVBXYkRTNFJ3b0FTUGQ1UmpORzdQZHZh?=
 =?utf-8?B?elZkQXpaN2ZObm9xQTB2R3NFS1dXRkxUNVdsL0x5bWNGZWduYUJaZ3FHcGNz?=
 =?utf-8?B?bkllQVJJOVV1T2tmOWNlQkd1enYvUWxOQkoyT21JWDQyd3BONDhzZU5pK0xR?=
 =?utf-8?B?dkdmUWVscEl4NkcyODRLcElLZkhxSnVBU2ZPQ29lekIvZHNMNVU2ZTBoWFlP?=
 =?utf-8?B?TldZOVd6RjJVTGJ3ZEN4LzgwR3ZYdnJSeS95OHdEbGRQbVIwQndGMHc3ZEhx?=
 =?utf-8?B?eEEycXN3dmQ5Z2UrOE8vL1dXaXpxV0Nxb29IWmxmcmF2dzRIaFFZWloxaWUx?=
 =?utf-8?B?dHNHRUkzOHpuMWFKWHZpbUNOck91WExMOHd6WGJhUGhCNFV3emloVzc2WjZy?=
 =?utf-8?B?dDBISFA2THIzN0VKdkZOWDdpNWpFdEJ0VzBWYlFnOXoxVVB6Y05HemlpK0k0?=
 =?utf-8?B?UnR3UXZJUGpWdHBoT2pjMEtQMG55L2E3VitzTUtVZldVQTcybUljRWhHdnl5?=
 =?utf-8?B?aDF1d2RtcnRSYTVlTDJOZ3pDUkZjTkVPTWtkdi9nY0xWbU1lb1kwUjQ2RmRw?=
 =?utf-8?B?NFVjdG1taDFFZHdReDU0NXJsRmcwV0ZkRnU5RW5MeldhUE1nT3EvQmVxTjNj?=
 =?utf-8?B?MHN0K282YVhZL1RLVVk2SWhXa3JRaFBMMlV1MkVNcFFISkVNODJEdUg2VDdE?=
 =?utf-8?B?QWJMZEdUdEU3ZDNHTUZqOFNyaVpJUlR5THpyNC8yTGRvd1ZvemhmOXVud0hx?=
 =?utf-8?B?alBVK01iQjZLbkw4a204RGNrVy96ci9wcmUyODdtR0lvZ2JGdHk1eGpuaTV1?=
 =?utf-8?B?Q2E2YjJYUFBZZE8yWVBlSGM5V3hMM0IxVTUyZ3pEWjh5ZWg2bzR6eWh5anZj?=
 =?utf-8?B?R1k1RTR5RnRXbm1nZlE1aTI3djRPUEtsQVZPUFhXRzl4QU0rbUtVbVRmNGRp?=
 =?utf-8?B?VUxzOVlZNU85M3B1UCtoeHN2L085R3JwNVp5V05vYkoyNE1ickMwK2VENWlp?=
 =?utf-8?B?SWI3VlBDMDZhcWM3S296RzlJVCtiMWkxMmVxYVk1b1hCdWkrRytlM0d1emJS?=
 =?utf-8?B?T0h0TXV6TjF1RXZNNUxpNmFxQTQwaDJMcFo2N3FsektaUDJiQThQNVRiOXRC?=
 =?utf-8?B?RktyZXdMUi9LRXpWbTY4Zy9Qd2VoVitWKzNPdjFPeG9xK3V6R3FPNlZYeEdF?=
 =?utf-8?B?RFBxQnBzVFFVVjRyaCtXeFFNZ2pEOVdnVEgvTURIS08zMmRTdHRXMUQzblV2?=
 =?utf-8?B?QTBla3NMRnJEM3RLd0JsYjlrRGg2dERqRWRUNDJBV1lFYjMyRk15T2Zrazdr?=
 =?utf-8?B?bTZFZDRGRDdNS1RSYm02a002QU56TzcvY0Y4ZnRQRVMwODJvUUJ4SENjV1J2?=
 =?utf-8?B?OGl2TUdCaUx0RFZReXYrZFVEWnVrRlhMb0FsQzY4c2NpQlgxTjloNGdleGo0?=
 =?utf-8?B?dzdlNnMwUzJKb0ExNkxNZS91Nis1cnIrcjBMdjJ0VWpKVkFoNGoxNXVINXpv?=
 =?utf-8?B?SVpiby9hWFdPOTJHUnNMaVgyV3VBNjg3ZnNHbWx1Z3hOazY0aVBzTmJjZkYy?=
 =?utf-8?B?TGpYb3V3TjlNUmUvZ2lVc3J0akNSbTcyOWpIMlk4YUsrazFseXNaZnBLMkIz?=
 =?utf-8?B?YzloTnhQWktuNjV0cTVROGtwb1VnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7977a0-396f-41cd-70d5-08d9b36e490c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:27:30.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /noPhxtw4kE0+qwp78U6fQV8oniQDxmOe8zy7ykqcVUXUOxI8Rs7PKx0ABYcbyv5NolzJqB58blLKDGl+u2JFNOiQAvMZJ/5qZoaSt2OgBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1844
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 11/10/2021 1:33 AM, Shaopeng Tan wrote:
> From: "Tan, Shaopeng" <tan.shaopeng@jp.fujitsu.com>
> 
> This commit enables kselftest to be built/run in resctrl framework.
> Build/run resctrl_tests by build/run all tests of kselftest, or by using
> the "TARGETS" variable on the make command line to specify resctrl_tests.
> To make resctrl_tests run using kselftest framework, this commit modified
> the Makefile of kernel kselftest set and the Makefile of resctrl_tests.

The above sentence mentions that changes were made to the resctrl 
selftest Makefile but it does not describe what the change accomplish or 
why they are needed. Could you please elaborate?

> To ensure the resctrl_tests finish in limited time, this commit changed
> the default limited time(45s) to 120 seconds for resctrl_tests by adding
> "setting" file.

How is changing the timeout related to the resctrl framework changes? Is 
it not a separate change?

Thank you

Reinette
