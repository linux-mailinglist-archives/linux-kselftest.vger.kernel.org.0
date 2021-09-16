Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776FE40DE31
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 17:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhIPPhL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 11:37:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:25926 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238369AbhIPPhL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 11:37:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202088816"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="202088816"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 08:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="530210453"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2021 08:35:40 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 08:35:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 16 Sep 2021 08:35:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 16 Sep 2021 08:35:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYxQBWg+iyz4zQ5Xq5CzrgKh2ESt8md8GDhjloqpW7jNmakI5AZrWpreBI987H+6WbH+n1nmQf0aOZM6AQt7S1Xso6TwAR1mk2BDyVN1FM9v0RY8wYp+B2KZ47JVnvM6B01h6bcJqxYbr4wI3TYo3JW3uR0SraXzZJeca9t6eVaP/RYlhduGyGyQmIUJjNR7r0FmpQ296V09/N5D9gzX/rJOiTOB46G4rIS9Uvi5bLxYKHxSeWOCKs19qnnC6JDVq2DfRzfwvxtsaNF4EKOV8Lxs5nLTqUFhB2zRabnniaaXAh6JPbXl1WGr8APqoR5A0sxhHuQf6TkzZvfvosVneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=B4xVgZ2JD4jyDp+rN56PuW4+1x/7sok+pi9GTOpNRGo=;
 b=F6J7NTtRhkxOmWkZudZR8XfkAMArnyl9xAMaEzaPZq8iTAx1OpJya8qK2Rv62Y7oNTDK85Y/VhlK1/474smwLw5GMmF5I0qEHjmgJElc12C0IH07H2OTcF3lwq8ej+KD7wm00C2l0fcunN4w/PxScS94089zQ80hCF+GBIR3L7ET4jJRNeIXUpXe8D4pPTCDHJS1VWPFDdtktUsvkcI7hcGsRFS26qF32Bn9tjJIMxbh3lVofyMuK1IMsvOU8e1UR73bWjf+WjKKxBBW7cx0D0EIRlXkNmpbASDL8EMN7F3bwsXV6lYcwU1NvoD6EG1brdf1BLMYj7S1WpiZUUpb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4xVgZ2JD4jyDp+rN56PuW4+1x/7sok+pi9GTOpNRGo=;
 b=inhSIDBZE1p0eeIfsTwpUqg/UyrZhPL9DmmT0uZV+i01rLZ6KF8JsbMMyo/hcd7Yb7tZ5n/mAvJjqJx+r+BkFthf9c0Xdbz0izPHASt0UUzMZhpusuW9cVt0ZJdfAsvL6qVXFP7VLG/pFXu28ilt5IlBvQ+WePGREe1nB4tRmTo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 15:35:38 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 15:35:38 +0000
Subject: Re: [PATCH 02/14] x86/sgx: Add /sys/kernel/debug/x86/sgx_total_mem
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>,
        <shuah@kernel.org>
CC:     <seanjc@google.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1631731214.git.reinette.chatre@intel.com>
 <086aa5a16faf0d9b47ba9e0ebd2213713d0e76ff.1631731214.git.reinette.chatre@intel.com>
 <6f3cc681e10877e639b882eaabf1a5e21bd2fc94.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <26937e79-c7f7-ea08-a4dd-9386a44c4ff1@intel.com>
Date:   Thu, 16 Sep 2021 08:35:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <6f3cc681e10877e639b882eaabf1a5e21bd2fc94.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1701CA0005.namprd17.prod.outlook.com
 (2603:10b6:301:14::15) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR1701CA0005.namprd17.prod.outlook.com (2603:10b6:301:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 15:35:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98999420-4dd8-4f07-9aab-08d97927a255
X-MS-TrafficTypeDiagnostic: BN9PR11MB5244:
X-Microsoft-Antispam-PRVS: <BN9PR11MB5244BFF0D49D756306AB7887F8DC9@BN9PR11MB5244.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktPbME7oEA9+RzBc3FUqtN0GrKOvlr5wHd4f/fwRA+HGzS7PM5xQVwv+u5xmEvhAJcX3RRWoXtm9BQBRL22GCSi+zwl3aGmb7cCl7WVIE5cQogu/8HuMUpukTMM+k9iHtoLe+61KUetYBPxrlF9YmNkiTkrmcTauTCJjUaXHlsBz/mcRwtxPb80evf47xuvvDEpLFsa2s1jHXHv5/sYicfUIw6wuBtaRJiDnnJGnA5slqQJYQ4ii8vwbepV7y5VWuuVR7qNZYPB59VAcVDuBbCLZnUSVlnKt3XLeXuA9ddLLQpeF5X/868J6es6iFanAYJwrz2nxIZijQRQEDayqAHg0wJVV73dgiJ2cW+09zjMNef0HvjpAwb8RJXZ4a3nnl8lw8jWFLHiO0KX5k9x9jQe5nJu4nYNBr+L9XtNSVa661zF0WKIXfH38XL7nkLjDf/N07Wt3swKP9WTvzTUlkHQbvuTadOpc2Y4Imi7/jcW+J0PH1xfZiPcxtdeaKuWxe5dEFu/4eYu5cTCA1wLFG9CNWfZD/7XNXSw88NTdtqNgRbKpvyjI42dFyOhDpcQM5xYh3hSoy92T4JQjquCoU7sbREOdSWs6JEKPLR26pgEjoA7zPxhhRjeeBYJVltbU496C3CBS9uQiFOa9euX2R1m5jHNCbfwmHaMVHd+7r7L6XoyH4O0E2zAiYnyh0CPzKYiPfCCRWtPgaS1QupCkmkBEj+AMv4whzv1Noa5lMRzifc6MXNZGw0A7YE8rJEafzogmNLLBXSqqPru2TaLur0cx7DZncjqf6n664HTLDTHHFwbDOVHdbMpRTpynxXyR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(966005)(66946007)(36756003)(53546011)(31686004)(316002)(26005)(4326008)(5660300002)(8936002)(2616005)(956004)(478600001)(16576012)(83380400001)(66556008)(66476007)(44832011)(6486002)(86362001)(2906002)(31696002)(186003)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZESHg5TitYaVA0OGhxVUhQNC8xZmw1b1BNeVNVYkJuRXFZTytYZ2JZN0Va?=
 =?utf-8?B?UHdZUHZzcEJGOVk5SFB6VjliOVFzcThoSm9sQVlNNzhFakk4WXYwOEVKMTFo?=
 =?utf-8?B?SDB4bWtzTTVVb0lEbkZSWDM5TzNpOVdMazc5bG80cHh5bTZFTVJJM08zZENX?=
 =?utf-8?B?TlhuQk5BdzBOQmg5VnM1anVtbmxTSkVEbEd5UGttclVYY0w0ZlE1dDhQamtp?=
 =?utf-8?B?emZQeWZsVFVRcUs5VW5ZYUJ3TTN3VnJHZ2taNkNvU2Jqb3BIbDdqYm9zUXZE?=
 =?utf-8?B?VmNtUzIyZjdKOHRnbFJCU2hqbTVQR3JOZEdNUktsb0VManZvMkdlMWV1alB6?=
 =?utf-8?B?T04yMG5QakJpRS9sR2NVR2JUN25jbUdVQUpaN01aK3pnUnd3cS9hcHdrbGtv?=
 =?utf-8?B?N1ZaNnlkclp2OGVtZXJFbzRHRC95ekJzT1ZPOE5meXV0RFVwVjlJbEZRNUpL?=
 =?utf-8?B?MGo0ZFVBcktHdU5iZ2NlOHJnNFVScGR6R0dFQlVFam9BK3EyKzV2V1QwdytV?=
 =?utf-8?B?Q2FDWXhwVDZud2pqMTNFQUdqQ3V2QU5jWERwcW5hOEhnVU9tUmdsK3NQM2Rm?=
 =?utf-8?B?Y0NNY2NrSHY2WCt3YnQvZGhCbHk2aEs5K3E4Tk16aElPK3c2Uk5LSDFmWEF4?=
 =?utf-8?B?ZkVNMERjMDRtODllQmorcHBVOXRIZWZ5U3I5YmJpbzNLbVJXVFdlaGVPVTUw?=
 =?utf-8?B?Wnozc3p3Njd0bVZYT3AwalUxZ2hLTmhNR0t3eGx3UVROakRVOXNVN1RWbzNk?=
 =?utf-8?B?aTNhNWlBNGNxeVExQWxJUlZHWDlXQUk0WGFudXg0RVd2QkpicUlZdlVQRU1x?=
 =?utf-8?B?UUQrU3NMRHVoNzY3M2tzdUl0azN4ZXowVFJxT01mSUtqYTRmN0hmOTZUbVRM?=
 =?utf-8?B?S1ZscGZmN1phQUZyUk0zQ2JhY1A5SmR0WGtuYXJ4alloeE83SXRiVnUxN291?=
 =?utf-8?B?RHUyc01rY0ZCQ2FXZ21FMVV6dGhWWDhRaFJkNG1ETlU1WU9Fd0M1NnBSbERT?=
 =?utf-8?B?VEJWM2lXUHNnSmFXV2VRSlgwQ3Rvdk1OOTk5SS9Sd3NCZFF5TlN5QVdGek00?=
 =?utf-8?B?NG91UjB3a29RbTNnMms5M210c2FIYWt0bWRaQWRLM1JHZnBCaWJkOTZUdzRB?=
 =?utf-8?B?M3RYLzV0Vm9rMCtWZmJEQi9RbE42REVrYUpSMTRHSStpM0pvKzNrbVR3ZjRj?=
 =?utf-8?B?OWUvelNlTXhqaVdpU0hvTEdMUzhKeDFvajk2cW5HeHFpUE9nNEtPM294Q2s1?=
 =?utf-8?B?aktGc0xOVSt5QlpYWDY3N2pJNkNkQ2NLTjZ3MWQ1Qk5qWHgxMi9xazYvbGNN?=
 =?utf-8?B?LzhuVFB5Si9ZOFpFT0FpSTJ6bG5jRUtVaFlOUFBEN0JRVWR5NkIzTzIzdjVU?=
 =?utf-8?B?bHRtL0U2ZVorT1haS1lxOTErOU44UU8rM3VTZXpDMHY0QkRBbXpRejhEbmxv?=
 =?utf-8?B?YXF1bXVYYXc4U1VtUGZMRHA4OG9aOGR6d3dzUUE4K1NUUytkZUV6YlpUdXZy?=
 =?utf-8?B?ODNvZllmdFQzbnZXeGZKU3JESTJtZEtOYStkL1dvLzdkMXdndWgya1BDem5w?=
 =?utf-8?B?Yk9vMUMyeEp3TnVSN3Y2UFcrbFpmUi9rT1NNVHpBbWhDbWdBcUlJbU5aOFgz?=
 =?utf-8?B?QTliZFRGSHMwb2lSbFdaOVBzSVlicENoOVdTemF3bGp0V3JEUDFhelY0OXNr?=
 =?utf-8?B?cSs0dHhmME5rbTBaWWJkVDIzeUovbWU0ZXgvT2JqQU5NWEptWWxodHlLckpX?=
 =?utf-8?Q?yKnm9K0/3mIn81X0kZp+Jtsf4CRepCmoPfGchVd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98999420-4dd8-4f07-9aab-08d97927a255
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 15:35:38.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9rpmQi8tBHJvXcXxYEiTEvYLtIEzTnRTUr81qqYpZOuVWnZx6GkbURa96CDIRbC8v4E7I3c/JF7DeLsiTj1oqNJtntdnYQlfnMlpi88pOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 9/16/2021 7:09 AM, Jarkko Sakkinen wrote:
> On Wed, 2021-09-15 at 13:30 -0700, Reinette Chatre wrote:
>> From: Jarkko Sakkinen <jarkko@kernel.org>
>>
>> Just like normal memory, SGX memory can be overcommitted.  SGX has its
>> own reclaim mechanism which kicks in when physical SGX memory (Enclave
>> Page Cache / EPC) is exhausted.  That reclaim mechanism is relatively
>> rarely exercised and needs selftests to poke at it.
>>
>> The amount of EPC on the system is determined by the BIOS and it varies
>> wildly between systems.  It can be dozens of MB on desktops, or many GB
>> on servers.
>>
>> To run in a reasonable amount of time, the selftest needs to know how
>> much EPC there is in the system.
>>
>> Introduce a new debugfs file to export that information.
>>
>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> [reinette: Use as placeholder patch until other discussions complete]
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> This could be replaced with the following two patches:
> 
> https://lore.kernel.org/linux-sgx/20210914030422.377601-1-jarkko@kernel.org/T/#t
> 

Thank you very much. I will replace this patch and update the kselftest 
changes to use the information from the new source.

Reinette
