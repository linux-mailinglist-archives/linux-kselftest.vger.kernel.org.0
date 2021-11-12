Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4DF44EC57
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Nov 2021 19:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhKLSD2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Nov 2021 13:03:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:31982 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235563AbhKLSD1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Nov 2021 13:03:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10166"; a="294002764"
X-IronPort-AV: E=Sophos;i="5.87,230,1631602800"; 
   d="scan'208";a="294002764"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 10:00:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,230,1631602800"; 
   d="scan'208";a="733736169"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 12 Nov 2021 10:00:30 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 10:00:30 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 12 Nov 2021 10:00:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 12 Nov 2021 10:00:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 12 Nov 2021 10:00:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eACXRI3JHt8Kk6XfBvgbaMvbRCc10ply0A4++oeN3JdLBOVtTMz/ehVE4B7If/2RhDFwhrtLmzP55q7rqyX66RLZvJuxjZIfJIq3Aps4n6Lzs+JKsVp2uLXr2k7GZdddHfmSZfk/FfaJ3gkRky0PlUOSzKJ+kjlMHwiWiiCY2JaG2+z2kMXF0LhLvVJBUDFTs+/uK0kjp06w0ySs1GU97yrtUnKy8ecicZW39b6s/99VltJkmaCt+9DA0Klg9nOKW9X7e9dpn6TDEUEUFLMTo/0Azy3YNRX7RDYVJ9JTEh2s3AW1PcnBiZkx/4l8ARxjDZ44c+igQ2rld2fMZGLJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aACVBPMvoZaBWNVbm0gJde9Jch79fTM6j6J9Ja6aBtg=;
 b=VBqNiI4o9nrNK/gzQEoXGD0JNFEXvzBGRsLQm0lrrx203xJTe0vSP4/jDHDvxVozDHLWneokrW8ZAj2FiH8t7bfknPySR3GOtbywS7wWQT/0eODbuMISZiyn6dxa3KPZscwA3dMswUhuQOS0WO8Lxw7IbJCO7h3uF1S9uBnGf61Ja8rw6uaA1TKgpNktuVPlYtAkADiVogvzqIBaW362CwgtdBQ2W0jg5LN6p+hlRuX51oYE1zZgE97Iz2eOJ8Hs6frfDW2JjuIFhUcYKf8A5FLc5oaefkk5cObsr1CN7c4bCHlhRJSTTtlYqddOaT6uVga1PwA3gMYEEG2jSPOc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aACVBPMvoZaBWNVbm0gJde9Jch79fTM6j6J9Ja6aBtg=;
 b=bg8F22U9HEppdXBHVfBZzXXeaqx36eoOoV0/0FdZq/Ae82/2yBa6cr/RJNTLVUTcrOrruKQnbHtMlDkmwf+YmSKWdzDaK8J1cwbZsZelloo3L3OtiOcLvPRzsugn0NQgb8A3Y7sojNu+Z9Ako8l8/JD10JmCISSULU7aKTWyPnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB0034.namprd11.prod.outlook.com (2603:10b6:405:6b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Fri, 12 Nov
 2021 18:00:28 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::494d:4194:b64e:c672]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::494d:4194:b64e:c672%8]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 18:00:28 +0000
Message-ID: <c23356c7-3af7-0aba-18b6-2e53ce18a164@intel.com>
Date:   Fri, 12 Nov 2021 10:00:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH] selftests/resctrl: Skip MBM&CMT tests when Intel Sub-NUMA
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20211110082734.3184985-1-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20211110082734.3184985-1-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1401CA0008.namprd14.prod.outlook.com
 (2603:10b6:301:4b::18) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR1401CA0008.namprd14.prod.outlook.com (2603:10b6:301:4b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 18:00:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84d1e3ba-ed45-46ab-0666-08d9a6064f62
X-MS-TrafficTypeDiagnostic: BN6PR11MB0034:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB0034A421FA1AF57E90C83192F8959@BN6PR11MB0034.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6N8cyEu2+wTOlshkZJiMXmyi31LEd+GbWe2f1zm273pTtn9xfdONVGU0xnUNL0KkcE2UyeuvDg4nqD9CKopyDo5E4PYddnW5K3nlregrjQPZl7M3Aad16N2zVCQrWJjyY8A4eBXmG8hZYvy2zYnRL+PAWyA+Kf2vGbyMHDERnubkjeX/5aXaMudFYwRhlCCmj5+qGjR9rk7WeSnoi/nDxu0rG834gSDGoLjc6NXUS5LlObNbxycuVYGd/5slTmB7qv8D9FvyBkWhg00E2aZPqL9Nor3YUAM7GG4GAxwM025aGPNOioNhsqCq81LwTAB/HG2bkoK2qRy23DhhPrOswd1awB7j2+TOGcU6Bca3fmHl9CEofB6JzbLIildR5HDGTL+XNMGevHI81pTg+V0OELDXlC1Nu/4dsraKH09P3vd3YFC6xWEhxghee1bHE3PD6AiKp0Hnw/TA5pFWDpOtt7xG7pjUUS+4tzXpW7gOyJ+YrRRdxfvcw1OUKbGqZamKfMg0D7g0fQjjxXP1sYxo0mI9FruWRUp++3uWeH6L8+B8tMAkfW9n+UBurFCzFB3i6frQG/4lq8twWbTmC3QfgA25AGXh4ERxhaEkg5eqf0n/ZzWjR7u9ErgZ7Hft0Hokat0IrPBun1BQ21pUIkQ8H9KNKd3YuizU3Ace9w9m3ndRQi1F4vD7HA+gvNPobi5lcItqGyWwGnCm+OPyJC8cjiEoDB0OsJTLcBANmT9lrP6anhxwPnLtCTRGcxM/eZfMPyHJn7SX6IVG2w55NipQyHOvOBBq7dzExCeKrFr658l41TA86Pu5dJbJh1YLm55
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(8936002)(6666004)(5660300002)(31686004)(38100700002)(53546011)(36756003)(86362001)(6486002)(110136005)(44832011)(2906002)(966005)(2616005)(956004)(26005)(66946007)(186003)(82960400001)(4326008)(66556008)(66476007)(31696002)(508600001)(16576012)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2dob1NHQzhHSjNMb2luK0N4MjR2d21oZVFtUzhEeWhKL3lkbjhPV2VDZXZ3?=
 =?utf-8?B?dWkwcGoyRk45Z2swd2owZFhWcFovM3ErbGlZZzlvRHVqL0lwKzZHaGFJQi9R?=
 =?utf-8?B?b1NqY1ZDTFpqa0FqK0NKOFBSV3pubUlaL2I3Y0V2VUNOWTdSaG9UczVGRzFM?=
 =?utf-8?B?bFhKR21OOGxaVzRjSXBtNldZNFdHS3dvQkZ2ejl3TVNOMGpNaythRnVpQkty?=
 =?utf-8?B?OHg0S2lrbXhzbEhVYVQ3bVhuM2F4TzlNWGRrOFNoVjEwbWh4MnhCMTZIaGtD?=
 =?utf-8?B?RWxOQzNBVXdacjFXTy9RQlBza3dQMms0d3AwRENwaU9qUjk4dzZuMVFjM1k3?=
 =?utf-8?B?TW41QkNHUTc2cndtWFA2UWdoSFdXWTNyMXo5aWhZUVNiR0NHN2hwdGFERTJs?=
 =?utf-8?B?M2o1dkdHc0RqTmt5VlFrUDlxQmE5SHFlTGhUVmpwaXR5V2QzbW93dVFjWnZR?=
 =?utf-8?B?K1N4aE5HYkNQb2JkQ2d6Y284S0dOZDZMZDl1N2ZBSjdESmg4dnVUUjRSQVNq?=
 =?utf-8?B?TW9vNWhjSmtaU2ZCT1FzZHFIdXB5MUFtTktpbjRsdzJDQTVjS3o3dHlWUXph?=
 =?utf-8?B?d3ZseFVEK0VTcHJHNmdTajQ0WWZBaU9qWEE5K1g0QkNtUFRFTGFkWDF3SUVi?=
 =?utf-8?B?MDVMUmMra0FPNUtOczBLclB3WHpZOFdHT1BLcGt6NTFXejJWR3dja0o3eGZV?=
 =?utf-8?B?ZnVvM1JTZWdzekR3UlpXRk5jcVBYYnVlT2JjYjZYajNyd2t1TktORk9LZlU4?=
 =?utf-8?B?L0dYQ2VCWFVGOEUxcjdlQ0RHMjE1cEFxdFJTSWcyMFdTRFA0YVR1M2FJOXJm?=
 =?utf-8?B?OWZpVFRlRTg2anMwYjcrSFJKeGZLSmlQMjhyVDNpT1hBUmxGTXUwU2pjdDMv?=
 =?utf-8?B?UzNUeWx1Kzd1ZUpCZDk5Y1A0SzN4azd0Mm14ZlM2U0pjOGFCTW8weWgvSjc3?=
 =?utf-8?B?NzJ5Z0lrOERENGV1a3lab1JEb1BHL2k3dFd1TlhFTVR3aXhib3FhWVZ2aHg5?=
 =?utf-8?B?YjBhaGxYcmIwVEFTd01HUElvbG1iK016MnZpRzRDZlB1R1lycXFLdGlmR3lB?=
 =?utf-8?B?blBHVDU3R3pwK3l1NUd4RU9VanBOaGRHL1BubEE0d3ByNmF5QUo2cU5JNVJo?=
 =?utf-8?B?MGxrckQvUW95ZlYyMFVHVmoxa0o4azZJZ205RXBQSGxqempSV0Q4RDBBN1pr?=
 =?utf-8?B?UUpmLzJtei9IbmxKcnBOdVg5djBVMnBMOGEybEgxRWd4Sis4MEQ0OGVKbnVG?=
 =?utf-8?B?R1lEUkZwVlgzUE1DNThxb25wL0F5Mk5OMWFpZHJScGkyYnpsMm9BK3YzRzN0?=
 =?utf-8?B?UjU0dzMwd3lKMnQ0OVNYY3EwY2hIN2FFKzZIR2R1djl5bkMzMDNmZUpSZFAr?=
 =?utf-8?B?UUVBT1ZFc1J5bXlqQmlaVk0ya25YdzNzSU91VEtpdit4alcrc3RrQjFLMS9h?=
 =?utf-8?B?RjV2bXNCMzBKSXJCaG5vajkza1dNZHpNSHJSR1NuenJlOUZhVUZtSzlESGor?=
 =?utf-8?B?cmJGdWptdGlESzhBUDVzT2pOWEhKbVlkZWlwTGxiMGFYWGx1YitBaXdwdFBz?=
 =?utf-8?B?dGQzYVNDaDR6a2dvZTZIV0lwMDlDc3VWZXNrZ3ppYms0bGgzSjQ1VmIwTSs0?=
 =?utf-8?B?b0VnUFhPZmUxbjF3R1VCZCtYN2J5Q0xUalg1QldJZUNRTk45MW1GVW1td0Nz?=
 =?utf-8?B?M1JmMEFzQ0FDZnhwOEs2Nmd5N2ZhNHFkTjA0MmxMb09vSUlPZ3IyUitnb2R6?=
 =?utf-8?B?NzA1R3RGZFQwREV2b1M4VEcvV3N4WGZYSE53ZnV4TGtCZVZWVytadlhmdmRJ?=
 =?utf-8?B?LzlwM3Z2WTF1R0ZTeEhpUmg1eFdBSVdzdEY5MDRML24vUDUyRDJUZkpzRUFx?=
 =?utf-8?B?UzlsYkhjSWc1UXkxM29RRStrcW83aklJa3dIUlF0c3lvZ01CMER0V2M5dHdE?=
 =?utf-8?B?TjE0NmlKVzZ6alZ1YmJUUkJhWTlFajUxeEVMclZDWWVDa0FxdFBtWGsxbHhL?=
 =?utf-8?B?Y1Y5eHVDZTJvZXJOK2Fhd3NBTHF0ekMwVk14dGJia3U1b1dHV1ppRENjMFFi?=
 =?utf-8?B?OURJZ3hPZ3JnWWZQM2I3bEdZR3dFRHBaancwcDM4MHdBVU4xdXkzMGlHWTB4?=
 =?utf-8?B?c2hzRlVIQUptUVZ0REtFV2Rzbmx0aUo2dzFoanlscnRnWFBLWXBPRGhVZ1Bw?=
 =?utf-8?B?endGN1htT1NvaHlqWHBjT2pZTnl5NWl3MDE1eVhISjlJbDBLNE43elY5SmY3?=
 =?utf-8?B?T0cxejlEeWxPSzdpc0lCblZUN3RRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d1e3ba-ed45-46ab-0666-08d9a6064f62
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 18:00:28.4073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suXSJAUA6hq5EzWP0ZIXqwHKp6TOFKjWBNNP3gtu4f/q8U+pd/rjGpwEzPWSY3dEABpFd7FULdWCPFHz17HXwuTf/HcHZZ9f7cSfRXHLOpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0034
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 11/10/2021 12:27 AM, Shaopeng Tan wrote:
> From: "Tan, Shaopeng" <tan.shaopeng@jp.fujitsu.com>
> 
> When the Intel Sub-NUMA Clustering(SNC) feature is enabled,
> the CMT and MBM counters may not be accurate.
> In this case, skip MBM&CMT tests.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Hello,
> 
> According to the Intel RDT reference Manual,
> when the sub-numa clustering feature is enabled, the CMT and MBM counters may not be accurate.
> When running CMT tests and MBM tests on Intel processor, the result is "not ok".
> So, fix it to skip the CMT & MBM test When the Intel Sub-NUMA Clustering(SNC) feature is enabled.
> 

It is not clear to me which exact document you refer to but I did find a 
RDT reference manual at the link below that describes the problem you 
mention:
https://www.intel.com/content/dam/develop/external/us/en/documents/180115-intel-rdtcascadelake-serverreferencemanual-806717.pdf

What is not mentioned in your description is that this is a hardware 
errata so the test is expected to fail on these systems and I find that 
disabling the test for all systems based on this hardware errata is too 
drastic.

Reinette



