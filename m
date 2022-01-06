Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282C8486E05
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jan 2022 00:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245695AbiAFXrD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jan 2022 18:47:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:33091 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245659AbiAFXrD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jan 2022 18:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641512823; x=1673048823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MlcIliNXnU/0YHbLtPYu2mdiKchWQF9DNScNEs7jEqQ=;
  b=HTsmvTdC2EQNKRh/vHrHAZlX11a4WQ2tF13/IGv765CMauNysF4sdWDM
   qrbJ8g3+iYbOmp0pXXALnqxZmqsYSIYgnK4tBGdG/phnpMPRUpx1hwvKz
   H17sKJaAjFfNwQI49qdZR5nqxGFW+KfiAgF6iXzIVCuc+A8KSJTzKIlId
   GpjH+em5js3XS7mFtSxZklTYLNffk8tzx2l4KBG1Gjv20nxoLzwYXc09S
   hmLmnHpQ0dUtYSpx6l677pwdJUY+P8i8bN7DBR0Lw8AMxobSxbm5yB/Nj
   1m8HpKqgr5/WowCtTD+EHK5oPCnCS8+EMAaDMWmq5eQ5hRNTxebKAs0Wf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240315740"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="240315740"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:47:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="763670111"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2022 15:47:02 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:47:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 6 Jan 2022 15:47:02 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 6 Jan 2022 15:47:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGxD93LkbcD1F7kp+KFctRc8ywVtOUB/KaGnRSiTj6yEghpJbEpxO2htCT/De1VZdc4vpQb/pNOx/g29wex1hSkryySQs2wNAine3Sy0MBI2MigEApuGsyYZhOyGcgrSnn+Ndstnrlw277Lp4mpl+XquPjw6oeYnnEYxYzpoUHGi9Vq1E0CVH9kVzgBKLxhMEgTzsqO7ZXWo5xwpwZRG60xc2tcPixo8PpAv7vjBowEbkX89V6bDfzLKR+VgSd5m3a9RMSXu+dEoDUcAqzBCLeZoc8ytKEujusP7SzGzuLloOmPh7DOJHRI6AdhhAZdsN8zVgSarUrcWSkT+GQElig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgFa+N1PqoIiuRHeDHmt7NjWX9x0NYUSM1IKVxCiy5o=;
 b=aoYk/lOrjW6XdzsbRcxgjf+Lm4prS34xrtp+53211pR6gl7B5v9/cbCMCHYZ36TOWXoU9LcRmPcBfDegoAMThm1kdn/72ZhjvS2etth+8sJJPOGbYC6sdUPxM0Elw8KsBQ8kaa1dxwXjzPEE28g7Hnf8y7tHSQqVvNwPQIqNqaEMI08cfknut8PZLVdp3RRjEr+yjPpV14E/8n6Xlq9VGZ+Rnpwbrq+kr+90gXTYJZlY3Rltg524zKA6k01EbIMKPQIDmYC58Kmwgk3VE3NfGUwt8nsk4FCB48pnFaCt10qul27kdPwAcMcV9FBkhzVZGMHpSDys+SESEx/DiyujcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1298.namprd11.prod.outlook.com (2603:10b6:404:48::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Thu, 6 Jan
 2022 23:47:00 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%6]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 23:47:00 +0000
Message-ID: <e10e4e8f-97a0-3fba-bd51-a2b14f40499e@intel.com>
Date:   Thu, 6 Jan 2022 15:46:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/5] selftests/resctrl: Kill the child process created
 by fork() when the SIGTERM signal comes
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
 <20211213100154.180599-2-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20211213100154.180599-2-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:300:116::30) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71443388-27f4-43d5-e771-08d9d16ed4b1
X-MS-TrafficTypeDiagnostic: BN6PR11MB1298:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1298C5C58539F7F5CDF5008CF84C9@BN6PR11MB1298.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcZOldSffMpcVml6jtqEiokTaEz+F3lhdd1B6GP2TsGkQRUSWCRM4YIeqm0W/J5rP0DitxeqECS7LuBb9NyHmhjZ0gJ4+tUVyvVJEwgEK+R7p7MF6Nngie+xy8fg+kxyrkaaeyKtRTgwJe6nBtezkYA5QC09rcrCpvPoTuE0Qv8MjmgT63ZMu9gQHb9kHcU76T1+q5svlfP3f3zEDaRjFxaVQYwYNcWvJmSWDN96SETYz00GK/g2cWGppw8k4XTya9d4qBteelLzjLXZWd6MU+b9poVljAP2465P9unNFbtZiUWyB44RJ8fWueuP0u5P2xKm9Du2CyZxPqJdIbcT8qunRIZURC22DuCISNejiD6NO3q5lVOcx0frmhh6d4Ceok8ZUBDRxRu4agxz8SxsjV9OWEu/04a5xZv6Y0Bp5x1tqv+OJnzk4OUVGnU1q1U8lFe4rchHCWYYFpWcW3RyLMrD8JYHzfyC3GQfa1JcexNexD6KJ643eGZw/v7ilCBfiOY424cCkfYeFfiG/+cgxiSKK/7aBkGt86MuYxLcEKvgl4TpZc4lexxD2DdteBGsqHx9bOYyKosgQask/cka0Po24V3XtTgfkbyN7rjO9OV95CvTA4u92AGwTRdZg/YSFgacXtVkiVWMwUUAIwD2DbviU9R3ahPjtlDXRudDVCazJ8guDGdwoDpDMLJEypvMPTa9fvhwF15TlLE+Ywy7gFrYOqKp3Y+w+XA59YZEjdgicHMFNKAVUNbzP1QplU/9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(36756003)(38100700002)(6666004)(53546011)(83380400001)(5660300002)(6486002)(31696002)(316002)(82960400001)(186003)(86362001)(110136005)(26005)(2616005)(6512007)(44832011)(66476007)(66556008)(66946007)(2906002)(31686004)(8676002)(8936002)(6506007)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXNMMmZzSHg0VzFWVVJnVWpDeEdjakZXclBhYlE2WWpaUHl1bnpLeHNYdHpE?=
 =?utf-8?B?M1BGRy9LQXQrL0FtcndaQldwWC9oLzYrZnZaZXhndXJVQzFyV3QxWjVFaGRy?=
 =?utf-8?B?ODFST015T1l4MmtJR3ZkZEVrclFwQ2xxNnJNZldIbDlTdzRwRjROSm1PQnZt?=
 =?utf-8?B?UFh6LzVLVHJ1R3pZT2JxWnJ4WU5SK0hJWWk4amZhSWs3Z2hkYzlWWTVoaW4z?=
 =?utf-8?B?UWhDenZQY09WeFBkSmlJMVl6UklKeWpHZTJpclBCRnNPSFg3clpVVEdaRmd5?=
 =?utf-8?B?bEVOZ1NQWGxlaWprSkcxT1gvS24vNHZGRTBia0JmSnhvYnJML1hjNUt4d0o0?=
 =?utf-8?B?ODM2WFliSVVORFMwdE5UZ0tPNXlYMUh5aTc3anBrV1VHbE04NjIxUFd0S0N3?=
 =?utf-8?B?eHpDUFB0M3JOVm5MSGNIb2FnRmt5RFlqZFgyekhPZWcxVmQ1Wm5QcnRXU3NM?=
 =?utf-8?B?ZDk1UW16QnMyUUhkMEZmdFJFYU5sVHpDcTlIWUI4STRlZ3J5MVhHRUVTMjBL?=
 =?utf-8?B?V2RkOVdKMUcvQS9wMlRITWRyQTZJaXk1SUd3a2tITGN1bUZseDZkb0txOVUz?=
 =?utf-8?B?NGlFQng0RnhMMUJLUkJHaFJSbGcxQnB0MThsT1dyMkEvWnFkTzFoQkV5cG9X?=
 =?utf-8?B?QU83NzYxNUhVVHpibXJEcEpYUXl6OFlXV2FGK0pZMUFXV0wwRWxUU2p1SGJU?=
 =?utf-8?B?Um9oa3ppTVBLZmt4OEI1MkNOTm1IQnB6Z2UybThyWCtFMlhTWkxYdUo4VnlE?=
 =?utf-8?B?S296ZUNIdkIwZGtiakswU0dzMHBjajdoUnZiNGh0TTJhc3Y1RlFSRklXZWtu?=
 =?utf-8?B?cEl6SE1UMEl2Y3IxNittQVdVNW8yUnBTalczQVB5MlpNWGxTeFlQZjNIRVQx?=
 =?utf-8?B?WXJVSDdJdmxzZW1sUWk4WStmSkF1OEVJUEljNUEycDZrQ3FEbGgxdVBtNXUw?=
 =?utf-8?B?Zk15Qk9SNDd3UzdwV0V1OElFOTZwZ2xjcXpNNHhuOWdBTHhMSExNeWQ5K0JY?=
 =?utf-8?B?RW9KSDV4UWhmSlB4YjZMZFphL29JZDl0Z2dqRGNCK2hMQ1o0LzR1ODV0Mzd2?=
 =?utf-8?B?b082a0h2ZTZPdDBPc2UyMG5wMmxnNURzT2Z2ODNNWlJtdFFveUVMQStTZk5D?=
 =?utf-8?B?VWpxTnRXMDJta2MyakNKQXI1NzRHRldUaHhGdHpTa0ZDSTJwcEpKd2tyVUVl?=
 =?utf-8?B?RVNMcUdoRjBTcUFaTCtaRlF5aldBcVNPN2ZsblF0MDhKcVFmODdST2dWTnJX?=
 =?utf-8?B?b0RGbW1zTjljU04rWTd3QVh1YytBZGJTOFZ2S3FYMjF0YTF0bm5WZEZObmMv?=
 =?utf-8?B?ZkFxak04RTZFVFNLNlZmU0VNWXpldW9COGI2NTBNNkNXcXFMRVFyaHc4MjFR?=
 =?utf-8?B?ZXVQMVR3MnJIVFNGRlhuVE9Tbm9jeC93Rm82R0pLNXNVSkd4b254S2FvK005?=
 =?utf-8?B?RmcyOFdiR2tjaVRZSUZOUDcxU3NTVnFHMGhHdkxuVmJUQTZyNG50UHlNSCtz?=
 =?utf-8?B?NnVIb0MwbExOM3dDazBobzRNZWl2OHZsVm9UZmMxR3l1cDFONUVlNWdXakI3?=
 =?utf-8?B?aVgycWdSTGo3Y3d3KzZGaFl5SWpLcHJNeWY3ZWN5NEdNR0Y3NGRJK1pqalZJ?=
 =?utf-8?B?dmIzZERPQVVWWC9BQngydWxKbkdXS09ZOG9xN0dzVEpyKzJZTDNzMyszOE1i?=
 =?utf-8?B?QlJkYXZlMzV2V3lyd3BjdUxtUnRhckpXdkl1NzRkS0drREJOdkd2Nm93amJu?=
 =?utf-8?B?bjRCUzUwU2lQV1FwMVJjT09LeGFxdEx1VW9RRjZZTGRzanlJUHJTTGw1dmlx?=
 =?utf-8?B?aTg3R3J6S3pUdkh3N3NDaWtPa3RMeVdtcjZTM2FXS2hHM2tKUjcxcEdURGtp?=
 =?utf-8?B?cXp5eFppL0tNazdnTnl6SFZSTkM4akkrWWpHdnhDSzJqMWhsRS9yNUpTRzdI?=
 =?utf-8?B?UnNyR0tMK0hRTlJuZW9CWXM1SjBYU0ZVTHVDblFiekNXcHk3eHdrQjZuQ2M2?=
 =?utf-8?B?bnV5UzJKMFlvdWJ2WXVDa0x1dllsSVMrY2ZPN3lsNHR0NldRZDNOK1F5amJs?=
 =?utf-8?B?YU82SnArbkMvVjdQRE9na2kvRkUxaGlWQVFqWmVkaDhWUS95WVkxaTU4b3Bo?=
 =?utf-8?B?NG1iTlVySGlmcjdQaWY1amVsT2puN25MdEZwTGQ5aFJ2WndVUkNWZi9idytS?=
 =?utf-8?B?VUF0QmFtUnN3b3gxck1VdEY1OTd0WDQyV3pva1lOWWNjWE5pSGc3dUJIajlo?=
 =?utf-8?Q?QvL2RJau49JXFpzoPliY8Zq5JSnYrXdH05NA0I5Prk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71443388-27f4-43d5-e771-08d9d16ed4b1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 23:46:59.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evb6g1qmz8Yb8NRqXfMXtmg6fK2nqigz42VNMGgcLiMV073XfU+VTeObmCrF5WuPAdGj4f8rUSebZphTbsWMPF9YFhQcWhO+WuVDZw0riAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1298
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng Tan, 

On 12/13/2021 2:01 AM, Shaopeng Tan wrote:
> In kselftest framework there is a limited time for each sub test,
> when the time limit comes SIGTEM signal will be sent to sub test by

SIGTEM -> SIGTERM ?

> "timeout --foregroup <seconds>" command.

foregroup?

This is a bit confusing though since it mentions that the "timeout" utility
is called after the test times out. Perhaps you can just describe that, if
present, the test is run using the timeout utility and it will
send SIGTERM to the test upon timeout.

> In resctrl_tests, fork() is used to create a child process.
> This commit ensures child process to be killed before parent process

Especially since I know you are planning more changes in the x86 area
where this is enforced more strictly, please do get into the habit of
describing your changes in imperative mood. Please search for
"This patch" in Documentation/process/submitting-patches.rst (your
usage of "This commit" is equivalent to "This patch") for more details.

Please address this in all your patches where "This commit" is frequently
used. 

> exiting if SIGTERM signal comes.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 95224345c78e..b32b96356ec7 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -678,6 +678,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  	sigemptyset(&sigact.sa_mask);
>  	sigact.sa_flags = SA_SIGINFO;
>  	if (sigaction(SIGINT, &sigact, NULL) ||
> +	    sigaction(SIGTERM, &sigact, NULL) ||
>  	    sigaction(SIGHUP, &sigact, NULL)) {
>  		perror("# sigaction");
>  		ret = errno;

The change looks good. Since this snippet is preceded with a comment
that describes its usage you could also update it with the expanded
use of the kselftest framework.

Reinette
