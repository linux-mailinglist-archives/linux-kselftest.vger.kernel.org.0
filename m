Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC746B543E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 23:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjCJWZs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 17:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCJWZr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 17:25:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2234CD30A;
        Fri, 10 Mar 2023 14:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678487146; x=1710023146;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0lIQm8VsD3Y2A1uW0iCCmeAjU2APEVyea4MjGoQ5EUw=;
  b=JjcCEFKNTnv5GpZX72pnfnLgvGTne75Y/kfwD+ipV5Qeaa/RSS3RDV3s
   obkmUWz8Frdmlfiz+0n9MdbEqw/w8716px3bNSOz32Cf564Flp2ej5hvj
   sCCfaAwOdkPvcdhEnNDhLjqwHy7a2bp8nPmOsOTBHuJgiqILmlxDWjrTg
   clhC6MukcxclZWkLnoXQyaTuUWsjvMVi0Jxsxjc4lymjppQZp2eiOoI/s
   Ev9oZsbQzK/NwFTqpau9wInISHGbANCkaLcRpPrSPboXRR3qXIt1E+FyB
   XgQygW7rO5JJ1YCJMag5h6vtKrVtCnBdWrD5nYr3aKJ95JTZb970lP2cE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336865328"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="336865328"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 14:25:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="655329395"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="655329395"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2023 14:25:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 14:25:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 14:25:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 14:25:35 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 14:25:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRQzkyn6CjuR/KbNnufggj0uh1UXIuoGvSiPKSriHxyn7S8xaz2UhyG5913vfpaXgKzuJ366kwDw+/S+X0WIF4Hj+NivdQ5wV/hrq3VpgM3BsupoKXlzVaGjLAsjLsuOdNvsrjIVmDSkp7X3OpR8k04jqOE2q8FNdTam8cHD76n8LmKgvE1nKV8qdFtjKPm4mC5MOmKHglSCgnBSH31b2MjgLERnbaXh0fkSiJkoQ8+ReyV8dQXaRhEh2AcIuerq6qaEL5ez77LTJBUmptE4bOCSZJlCGho6KQ7aDeTOV28leuTAf6eMvweFM+ONG7AHuPVnwiC+nNwkf6Kpmag5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJ+w966GUW01xz0rtXSZLT4UeGNpYWDFkMa7DG7qu3E=;
 b=T7SUtxQxVwUxZATkRl5J4tyyN3MD0jb7WvED4dIKwfxfBnY65V7IOuNj0EORaMXQY+M6Bi7Grz/wsjH/X3KZAH0uey/XoyEriodCRhot0zmstu1bVexhbEpZnITuuzgPSba8FfHgq08ajMfI6GmYtU97AD/ecMk6rj3trBfxe62wXxlY6myxbm5GUbgDGcXUPS8Pu62FvVtDtNzMM/CyWnlhvAzd3CJAklpxGJawb/qMfbJCrsK8c0Cvqi8ibCPz2E9eMeSFJ+IpO0kF91xm/4O09tlxSVFyB6EHGDjH+XTjSW0pv4v8dqU3Ca6oRTww9+qLlLvKo9RZIzuZACDTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1867.namprd11.prod.outlook.com (2603:10b6:3:10c::13)
 by SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:232::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Fri, 10 Mar
 2023 22:25:33 +0000
Received: from DM5PR11MB1867.namprd11.prod.outlook.com
 ([fe80::41a7:eb5c:741a:e84a]) by DM5PR11MB1867.namprd11.prod.outlook.com
 ([fe80::41a7:eb5c:741a:e84a%8]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 22:25:33 +0000
Message-ID: <7dcfc21e-9a17-65b1-6206-374cadb79973@intel.com>
Date:   Fri, 10 Mar 2023 14:25:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH v8 0/6] Some improvements of resctrl selftest
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To DM5PR11MB1867.namprd11.prod.outlook.com
 (2603:10b6:3:10c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1867:EE_|SA1PR11MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 980d09be-9a20-4c3b-6e85-08db21b65d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAM8qiYxr/I6qjjGA0nYhjG3sCF5L5y6UF/Qu17fXElDln+6nIVZrtfpH2d0VqUWEJg6NZsPj9umxawPqbDH5qlMJVFZtHbt95z73ofl5oljpK1Muul0L02YusPoQRKF8ZdxRdEUY/IXcqy0QdHI7ut6ywChOlmM1wblTbe+hWNrU8APdwMRJ/MnCt8EdUtgLzu+iU+LIXIk+iINiBlcHkknElXzelZ4GHNAsmsKFYoOozaCNgennfpiTSswjhnuKXlpkV+SPOPz06ata9HdPBCWu6UA3ffO3XV8kuITeb+gU+JJpdTrxe1dgkkKw8f9kEbtua6fyT8VR4tAExcRxsWG6DUL4BA+z9FcxCtsdqCUbS9+KLPAA59R9MojikJfm+3IbpU63mloey3RqusYWk13ZuM/94Exboluc3gr9busWWotzSzADhAtFtO8oiXcY5rROFVxy66JzxjMQhgHAKLg08KdnCP+Bk7sR4Yiw+5uR277ZSnrlABESfgkIs+TqYa6bG8mW/RPeyzxKjp7I2AvohV5B9OZDYx/nGYR1pmZcpPbP75F7eFFKEaLfhQXtx28FWrgyj5HYSjy6SMKDBszEK04FDn4gr6I3lNwfJOUzu4sHfNP0eY/fQhxA1ElRX2gaUTzvIoWFneT9bclPXIIcRhIQNkIHuLbUetA0EcLF5CXXAdp7k3AEISZBCU9Ed8AkZEyLcr/ehtpZhKPQSArL8AVKtCCALhYCTwcO1lzBYybFdgerCAKpWGU2jIr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1867.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(31686004)(82960400001)(83380400001)(36756003)(478600001)(38100700002)(316002)(110136005)(2616005)(6486002)(8936002)(6512007)(186003)(26005)(53546011)(966005)(6506007)(5660300002)(41300700001)(44832011)(2906002)(31696002)(8676002)(66476007)(66556008)(4326008)(66946007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmtPeCtFZkNzK054YTRQQjZ0cUc0eUh6V1ptWkd5S1RKRCtlem85c0lYTW9Y?=
 =?utf-8?B?MkV4TzVMRXJMczVUYVVyOU1oSGRTUjN1ZWp3YVdDdnhIN2loZFUvWXp6N0Nl?=
 =?utf-8?B?ZTVtKzNxWnBLNDVNVEI2WkxEZTJCNVEyQ09wU3ZJQWoyS044WENUZGtNMkQ3?=
 =?utf-8?B?ekpra2N4Z09raldFOWxOa3RGdnA2Qm1adFpUL3djejFVMnFTOFdDVTNuZmhO?=
 =?utf-8?B?aFpzb3RtbW93YXdKUTY1QWc3TUZFQjZ6RmhDV0lEVXRZTFZHL0ZqNUoyb1Vm?=
 =?utf-8?B?REd0Ny9qQk1rbnNBRHRYRjE3ZnRxNGVMeDRWYTU3UTUxbEhaYm01aEgvZzBh?=
 =?utf-8?B?V1FmWFc4ZVBEZjlTVFgyNWVNQ0VHNXNhUVh2WVZoT2JkRTZGZ1hSN1pZMFF5?=
 =?utf-8?B?ME42bDJHWTlKZzIvREJ4czA5L0JzeXEzYUdySUR5Yk5ITjcweGpWZUx0dnRB?=
 =?utf-8?B?NVRWa3FEb2d3b0ZPd2hGRG41RElyblVWR3Rra3hoR2srN2ZFbDU1ZGR4QmxS?=
 =?utf-8?B?QkdqUmtTeVFIMWRWcHZpTEVrVUNrSHNDRkdTdmQyTU55dk9VYytBMnRkQWNa?=
 =?utf-8?B?MytmNUFXV3VmK3lMcTRwZVMwMGhCSVFIQmpGVVM2YzVKUUlFWkQvaWpmNHI0?=
 =?utf-8?B?dG1uV1hrSCtzUEhod3BhS2hFY3N0T2hQME5xYW51Wk5QRmI1eGN3dWhFNWJh?=
 =?utf-8?B?YmhtbW1JVnhQeEFnOU90ZnVwYnF1MFFjQWdZRUJpdlcvY1YwUHFiS3JHQjRU?=
 =?utf-8?B?eStKUDQ2ZEJaTU0zT2F3Mi8vMG5tTkJEbkIweGpXd29SY1JZU0lVUXltUmJ1?=
 =?utf-8?B?Z0dKVmF3VXEyZ1FueVJ3R1I4Nk8yQ1R3MlBtNjFFR3plblViRStuc2ZLVnhq?=
 =?utf-8?B?V3EvVlYzQVpMZ25QVFE1QzFjQUx2N243YWxiUHI5L2ZURGI4K0s5cTVEaVZX?=
 =?utf-8?B?dXUvY3JjdG9xK3ZlaXhKUFVjU3krblRBSVNQQWlqa1JSTlY2bXd3NExNVURG?=
 =?utf-8?B?c2VBd0RVT3EvMjlWVXUwR2NZOWZGNUVEYzZ5dGYya2d6bGwrQ0xwaXhUeG1X?=
 =?utf-8?B?bFgrcUlTeVFCdUo3eXZoVGVoUysrNWIvbTZOT2E0eVZESXZEM2NWa0xuNmRu?=
 =?utf-8?B?NkxvQkd0RWo4bys1eXNWYzcyZXk0WGtOOHI2dmlNQTJkTkJXZlJ0MC9rdnYz?=
 =?utf-8?B?V1RqaXI2SUtMVldQMnpYemtzcDNMeG8wQkVxd2RCejQwYXhrNTY5TVhrTDRL?=
 =?utf-8?B?RUNvRUNhcGNRN0dNQ0xtZE8wSENDSFM2VUl5UExVTWRvN2xlTTc3SjhFY3Av?=
 =?utf-8?B?SjJuMHh0YmN5bmVhbmg5a250S2l1MFdWblMwTW8yMlZZdmdNWVhET3AzSm5J?=
 =?utf-8?B?YVBvMU1tVE1qOTRVZ21XYTBicXBwN2o4SXArQkh4eWx4U3VLaFljMDlGeUxi?=
 =?utf-8?B?eGtmYVVrZXVyQUJyd1BsdnlURGZOekNrano3WnpwZzdTRWJKLzlCWkIvcm80?=
 =?utf-8?B?bnYxNmVOcDZjQWJpVUNscFk5S2s1MzVtVTRLdzY3cDl3OTVTQVJJWmhIRVNL?=
 =?utf-8?B?bkFCeVpzS3RBM3pzNVFzWlA2WThRN1lGNFVkMjlOU1cwY25PdWlzMHlUSk52?=
 =?utf-8?B?a1NWUUdsSkMrT0doRkQzYkhPai9WNmE3MUNGejhQSTRUU0dMYjJjc2NMTDJ5?=
 =?utf-8?B?VXJOU1lnc0dlb01FV2trOXIzUHJjVFJoQTRwQ2M2K3ZSdURndnBLeWNxYXc2?=
 =?utf-8?B?a2o2M0JHNWk1MHRwMFg2dldFNHJOb2U0dVRYNm5WN1ZwRnlpQnRUOVpqNXlT?=
 =?utf-8?B?ZFZrbk1kT2p3RFFmNU5QbHRpOElRZnVLQWIvMUxqNXFhSW5SRGFyblg5U0hD?=
 =?utf-8?B?cU53QUlveHBhMEljMTlsR2c0dzZXOVF2SFNHMW1CNmRzd08zWFB5Tk00Sy90?=
 =?utf-8?B?WloxamhReEVKN09WcU9aTzgzS0wzSE5Ga2NjbGkxUUdtOExFcWdaVzdqbGh5?=
 =?utf-8?B?SGtyTzBFMGkxRjNUMC9WZHYrTlJMSDRaeHZ4enhINGxGSFdnbXVGM05hcXdJ?=
 =?utf-8?B?aHNheHh3ZUpkeC8zcFZJcWdya1pqbkpqbnVCV3FHaWFJTk9CanJVUFc1SmdK?=
 =?utf-8?B?b1pyNlBvcDYzb0tvVGpINkJnUXdaMkUzS3lXVjd2RDh1a2FIeWcyMEFvcTgz?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 980d09be-9a20-4c3b-6e85-08db21b65d12
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1867.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 22:25:33.5749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1lW6L3F04NmrFnHLxe7LEM3YHMDzpr1F46BZINscjDpholKV2q8yWjkVsIKESt1gzCQDjjd9Fy4SgalS/XAhzWE/sIr9uNHfbFkTLx30yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

Could you please consider taking this series in via the 
linux-kselftest tree?

Thank you very much

Reinette

On 2/15/2023 12:32 AM, Shaopeng Tan wrote:
> Hello,
> 
> The aim of this patch series is to improve the resctrl selftest.
> Without these fixes, some unnecessary processing will be executed
> and test results will be confusing. 
> There is no behavior change in test themselves.
> 
> [patch 1] Make write_schemata() run to set up shemata with 100% allocation
> 	  on first run in MBM test.
> [patch 2] The MBA test result message is always output as "ok",
> 	  make output message to be "not ok" if MBA check result is failed.
> [patch 3] When a child process is created by fork(), the buffer of the 
> 	  parent process is also copied. Flush the buffer before
> 	  executing fork().
> [patch 4] An error occurs whether in parents process or child process,
> 	  the parents process always kills child process and runs
> 	  umount_resctrlfs(), and the child process always waits to be
> 	  killed by the parent process.
> [patch 5] If a signal received, to cleanup properly before exiting the
> 	  parent process, commonize the signal handler registered for 
> 	  CMT/MBM/MBA tests and reuse it in CAT, also unregister the 
> 	  signal handler at the end of each test.
> [patch 6] Before exiting each test CMT/CAT/MBM/MBA, clear test result 
> 	  files function cat/cmt/mbm/mba_test_cleanup() are called
> 	  twice. Delete once.
> 
> This patch series is based on Linux v6.2-rc7.
> 
> Difference from v7:
> [patch 4] 
>   - Fix commitlog.
> [patch 5]
>   - Fix commitlog.
> 
> Pervious versions of this series:
> [v1] https://lore.kernel.org/lkml/20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com/
> [v2] https://lore.kernel.org/lkml/20221005013933.1486054-1-tan.shaopeng@jp.fujitsu.com/
> [v3] https://lore.kernel.org/lkml/20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com/
> [v4] https://lore.kernel.org/lkml/20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com/
> [v5] https://lore.kernel.org/lkml/20230111075802.3556803-1-tan.shaopeng@jp.fujitsu.com/
> [v6] https://lore.kernel.org/lkml/20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com/
> [v7] https://lore.kernel.org/lkml/20230213062428.1721572-1-tan.shaopeng@jp.fujitsu.com/
> 
> Shaopeng Tan (6):
>   selftests/resctrl: Fix set up schemata with 100% allocation on first
>     run in MBM test
>   selftests/resctrl: Return MBA check result and make it to output
>     message
>   selftests/resctrl: Flush stdout file buffer before executing fork()
>   selftests/resctrl: Cleanup properly when an error occurs in CAT test
>   selftests/resctrl: Commonize the signal handler register/unregister
>     for all tests
>   selftests/resctrl: Remove duplicate codes that clear each test result
>     file
> 
>  tools/testing/selftests/resctrl/cat_test.c    | 29 ++++----
>  tools/testing/selftests/resctrl/cmt_test.c    |  7 +-
>  tools/testing/selftests/resctrl/fill_buf.c    | 14 ----
>  tools/testing/selftests/resctrl/mba_test.c    | 23 +++----
>  tools/testing/selftests/resctrl/mbm_test.c    | 20 +++---
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +
>  .../testing/selftests/resctrl/resctrl_tests.c |  4 --
>  tools/testing/selftests/resctrl/resctrl_val.c | 67 ++++++++++++++-----
>  tools/testing/selftests/resctrl/resctrlfs.c   |  5 +-
>  9 files changed, 96 insertions(+), 75 deletions(-)
> 
