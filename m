Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526DF4DE32A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 22:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbiCRVCR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 17:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbiCRVCQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 17:02:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E12DF3C7;
        Fri, 18 Mar 2022 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647637257; x=1679173257;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X4jpfg9FBpN+Ye7dP93KujGrEMPVA1lpD6WjGxOC/0w=;
  b=VHIpK+cFBfMVu7DtSzlcTosrJ7wvAI21qZpKcnZrGFU0FMWj/xABYG49
   39G0ykSbfGRU/ShF76f7KHOyhtuDGXSTwQUU3RPEUPj6Il1x1Q5AwCwC6
   VdFMEw9uLtDwMpn8uoOS1aINrd6eV6u4tDJqLZZgcTXhu1dNlDeVOZONo
   AtWb6H7vNRW8sAbN57+G5AB5fiYEsbNSJhbWDYPUKJbV99n0NjxrlnaCT
   XeeQ0FY1vj/ELfycnrtd2YFtfSTMTdKviSIXXYvgzVcoEnxwQGg0FcOGB
   uQA/eopGytiAkNieGHZeDzm7aX7JjRICDMkSwxwjPVu1bNKCjrOLfGNsB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="320432826"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="320432826"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 14:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="542034903"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2022 14:00:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 14:00:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 18 Mar 2022 14:00:55 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 18 Mar 2022 14:00:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYEsFNgPD3ZZWZku450oZ357EQyaDvgpXBIoV8SJCO4fQQakcm6fbU4EqLq7uOFEsuqlK+NvfAq+YPufe6IdBYp9dfS2sk04HGck8Txj9Pv+hRUeS1gAVspKLis5lCy1HoRk9oRuYA5PTEp7ogh0SCEKw8tit3o7VT5VEd+F/MHXZfPnqxOss8pn0RwgQA88AZ1V2NsZb8TThcjVop00U/aRKYIXLOCIsbLJfHL2ctqqX+6SxXB8+fKAx9otWZmTy0ERFiAtdNhq6wW/608VcTIGZHVR4mKSw6z/j08zlMUwktUaVsob/z9RXZ4lYiKyjhG4PZ7dfbDktQ9AapGEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgS7T5pvPOr+gVifdqtHiSQiL/a/HbDxfTgoJ7RUpWI=;
 b=eTxFipIQSVglqvWNvZeLIKz5CD4G8eE/E0/zgm0BAIlbMIryigvQhyc5JQmzg6uh5H2yK9XxdcjQBqGW/LNDvGVGD6HnIszD2rQMpIRzW5Fj5Vxy6vyWRjQ3kin4mkd2mM/Dj0/+6RSfr8XDaSnb44IyId+phXus3CFO3J/DeXZr4XRZN5CQ9sS1p4YCo0uTCs+aorVDEST8dPvVX/pJtgkev40zVzPzHgiNDsxjbv8YXxMm2ucc6USTt80Iz3NoTJXsngHsTFFNOVO36mDlDzJlARzw924i0QDxvnZyeGNWC/bJOcV5AYb1i2tzp1S7avUr0xXLXqMExtmoxDHGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR1101MB2146.namprd11.prod.outlook.com (2603:10b6:405:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 21:00:53 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 21:00:53 +0000
Message-ID: <a7b28139-c097-385d-be22-c61f82409626@intel.com>
Date:   Fri, 18 Mar 2022 14:00:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v6 0/6] selftests/resctrl: Add resctrl_tests into
 kselftest set
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:302:1::21) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49779a24-3c20-4bc7-1757-08da092263d5
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2146:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR1101MB214695355852295ADC2A81F2F8139@BN6PR1101MB2146.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yu8OQF7Ff2ChlsWwgRGwYYdybosSzIp+I9FOiRlAmVXSme4R+33/lyrztXLy/yh8DIhrpNb2gTZnY+D9zExn3okWOHMbT9oW7CXqHSjepOLcupkI5OVkpiTQ7HE01gZp5Unj40e+N0bvLlzAP2jdyprKBNh6oJL0SxcoaLzbsRu13S5E7WgAOaQ671MvA5UUgqKj0Gp1tET+/mOuBGLAFetra1jZ/pt84LNqNN4mclrSPKkM2pRuCJvAzoqJxuS+1Ek/J5YCSe/AGHOYDNSATj4vNrgq/xbzUs00y03wA7gbhsH7tDxLPXKLDtXdILCM8HQ5vYPu5do3EujS/0YcOAEOzwxMae9B3nwJdMY+FCTluU/Mr0e54Ba7HN9ma+jn5u5xicqg8F/KWvqZa7pIlu7FtQgaOlFi5yUW6JBlcDmk9widi+iC3L4MU20cwIpM9usL7N2WGzInG3/iZdyXKyReh/tOXD4MMCKSLy6C8BM3yOSF1cTL3+guuXBgltQtC0QcLQftQSoMjmxf3dhiMroIPA2+9acXUEbpdDimbkQDgLwOX4bdXPTZ8WjO7F6aNgv9gx28RMrngTbTyB6Gs7VF/fPwU36XzZFyzKeO5kUQpsMvInd2f3u4Zz9LkjbV4m69Eu/d6GiQ9TeJL1z8SsziPrUfGO4DnpSQI4LNZLW/o/BuOvO4un6PKbC1Ev0X3fCg5PN4uVqonzU/0DoDEzeasMq81tjbQbO6IyJ04/4YSg1dZar86X2ANduIIlYriBgoHc5c1IyH4suJUqvV41Dl1Sjh4IhZ1u2lLXCgAKdHY5RTyEiYJX+PRqR/LM5IvXOMlwdO0UIB53T8Kp6QYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(8936002)(5660300002)(186003)(53546011)(26005)(6666004)(31686004)(6512007)(316002)(83380400001)(6506007)(36756003)(2906002)(4326008)(66946007)(8676002)(66476007)(66556008)(508600001)(86362001)(31696002)(82960400001)(2616005)(966005)(6486002)(38100700002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REJha0ZIdHNCRDB2OXVEcGY5MTNEYS9wUUdhTCtYWjJhRGhoYVlmaitORjJG?=
 =?utf-8?B?TnhnVDJOSFUwU284VDViVlVRNGNnV294Y3hvVVpQdmxLWFFiTzNtZCtVVWFR?=
 =?utf-8?B?UlpuMmlzUlhjVkl0OCtyak94SWk1R2tlK3htdmc3S2ZrNVk3S2k3d0xHaklS?=
 =?utf-8?B?Umt5c0k4SjdsQmtOdFcwU2J5NUYzN3dKSm15aHpVVmU3WmRibFNUM09uZEwx?=
 =?utf-8?B?SFBuWmVsNk9LS0hSaFpRdHFtdUtUaE9pSWRWcTREQVdWeVpYdFNwTDFtOFRJ?=
 =?utf-8?B?THU5VmpWVFNhSk4wdVNIRlBiYzFFZkI3YjFyUUh5cnh2S3ZPY0JUQTBQMlJt?=
 =?utf-8?B?WU1qcVhXL2hUWDNXeHlIQVFBUDI0Q0NFN3pWcGV2RFhkNnBYM1d4bTVya29z?=
 =?utf-8?B?bDR3K0NmNG82MUhGWm5PZG1VQTEvK1VzZ0VKWUZxUjZSMEMzdHphRjhqNlY5?=
 =?utf-8?B?Z2R5Q0dvaFN6WUM1UW5JWDVKL0daQ1B0SWxyaFpyS2Iyc1lrend2NVVFdmZy?=
 =?utf-8?B?QitZSytMcGo2bnd2Y3lWQ2R3WnFZOHQyc0F2UVhuTGVyY1lQdSsxTmllSlhn?=
 =?utf-8?B?d2pueEZoL3ViWVV3YmF4dENjV1pVdDlWSWxMclkwUEpwbGsyR3pTWEJqTkdG?=
 =?utf-8?B?aGFUV3E1WTBKNWhYdGFxQ0gvQWdLSnp2Ym9IR2sycm9wcTBBVlBMc0o5ZHAw?=
 =?utf-8?B?aGNIRHlOVmdrY3o4ZFhvakI0am10Z2F6QXRIbEdtTTVHZUdDUWoycDE1OHVH?=
 =?utf-8?B?RUhJVG4zMWdZM080TzZDWm42TjE2VVpwV3hnaFVvOXo0Uzd0VnpZbXV5Z1da?=
 =?utf-8?B?YUNpRU9uR1hBcFVlY0dTSHZWT2Fwd1lTVDBtWVdSN2xTbkovZGVrV3BJZ3Za?=
 =?utf-8?B?M285dlhZcmNSUi80VkJWTEVJb2dVVG02SFRuNFNrRm9TeUc4TWMwNWZibC84?=
 =?utf-8?B?VTQxcW5rTWZHMS9OSFRKOVg4b3pFZmdyY2NHTDZ0bHh5TXBvMEtUTU9DZlps?=
 =?utf-8?B?L3RBNFY2eEJOeng3Rk5MY3FTa2dMcXIwL0tyYzU2dXA2aVV3Q0g3aXFpSUhD?=
 =?utf-8?B?a1dQSC9wUEJCM0RScm1QSUw0cWhpUjZuZG52aU5TOTRDNUFFc0lHcDlQbDhC?=
 =?utf-8?B?UDhjRVhsK1ZtUmdQSG1YZ3ZFbXp4b0E0TFM2RG1mNllxd1NOYkE2eS82d1Fj?=
 =?utf-8?B?ZEN2STU0WGFNWWhUQjlzSCthcVRCTFFWc0RXRDROYVk5YWRzYzhYVHQ3RGxJ?=
 =?utf-8?B?M2hxbm5mS1FIWU9VZ3NsQ29uT2NXbzN5OEtMM2tXVEpOM3Y3bFQzVm95b3Zv?=
 =?utf-8?B?cDc1SE5SWUt0cUM4OFVBc3dMTXdUSjhQZytiVGhwdTFFanlSQ0VKZVdtVURx?=
 =?utf-8?B?QlZqTGtkbkxnbDVBYUp1bXhtT1FTUmpYcUM3WDZkUXBkb21LRHFSZi8xOHUy?=
 =?utf-8?B?WDU0UTlIMEQvajFvOHcyNTJYQWZjV1RhUko4blU2ZW1FMWtwOFFHN3lqQThq?=
 =?utf-8?B?UFA2c1pUVjBYQVhLTmk1TXovbDZYWVUrYmY2YTRRNXBKQUp4V1k5bWxpdDdk?=
 =?utf-8?B?V3dVUzBXcmxoVit1Tzd4K1VkNW1TejBwWlpRZlVKbUtCWWZwNktINEZBT1ho?=
 =?utf-8?B?Y2xvVGJVL21IT1RnNWcyZk9Gd211V1E2WVdSOG1NUmdDNDVNOE1PeTlSeXAr?=
 =?utf-8?B?K1ZiVVRTcTVURWM2Q0FvOTlxK2pkSCtFdzJjRHVaT0djV2NFZnA0eDV6NU1h?=
 =?utf-8?B?OTlIN1d4cktLSXJIdUdrQzNTckJOb1FaNzBLUGJxR1o0Mi9hd2ZDMkYzREUv?=
 =?utf-8?B?OVgzZGd4NmVtK3Y4OFB4OFkyeENiUXhaQlpzWU51Tk4rdzMzcVkrRkNhSEhW?=
 =?utf-8?B?S0lhbG15YW1kWE1YK3cvdFdaYXJjT0d0ZXhwRWtRZGkvMER5RU5ZNGgyQTdJ?=
 =?utf-8?B?N01QdzdkWmd0Vjl4cE90Z0Jycm5INmRPcVNEeVpCOU4waDlhWVliSy9SaThr?=
 =?utf-8?B?VE9OOUhqZTNnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49779a24-3c20-4bc7-1757-08da092263d5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:00:53.6356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWTgsnCERPAwr3JTtI47ylL9IMTCSYS7UwcjvqmLu7EWy0MrLHSmlISiwHagkOY2XM5WHAq8khK4vmwkQ2lJ2hv/J60ZThqYfS2At2PvvH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan,

On 3/18/2022 12:58 AM, Shaopeng Tan wrote:
> Hello,
> 
> The aim of this series is to make resctrl_tests run by using
> kselftest framework.
> - I modify resctrl_test Makefile and kselftest Makefile,
>   to enable build/run resctrl_tests by using kselftest framework.
>   Of course, users can also build/run resctrl_tests without
>   using framework as before.
> - I change the default limited time for resctrl_tests to 120 seconds, to
>   ensure the resctrl_tests finish in limited time on different environments.
> - When resctrl file system is not supported by environment or
>   resctrl_tests is not run as root, return skip code of kselftest framework.
> - If resctrl_tests does not finish in limited time, terminate it as
>   same as executing ctrl+c that kills parent process and child process.
> 
> Difference from v5:
> - Changed skip message when resctrlfs is not supported. [PATCH v6 3/6]
> - Changed resctrl's Makefile to always build with latest kernel headers and
>   keep enabling gcc checks to detect buffer overflows. [PATCH v6 4/6]
> - Made README easier to understand. [PATCH v6 5/6]
> https://lore.kernel.org/lkml/20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com/ [PATCH V5]
> 
> This patch series is based on v5.17-rc8.
> 

I do not think this is accurate because the KHDR_INCLUDES you use in patch 4/6
does not yet exist in v5.17.rc8. It seems to be available on the "next" branch
of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git

Reinette
