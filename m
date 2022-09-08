Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5BC5B2986
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 00:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiIHWnV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 18:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHWnU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 18:43:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ADB5072F;
        Thu,  8 Sep 2022 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662676999; x=1694212999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3h4Qb4S35TZT3WUv3bApSbXS2akKdpUg88AsgQWETfk=;
  b=g6BybHaoixkq3go4doPm6Wb11zmws7lKBsu4GuScbT0KDiXguPhY+2fg
   ZvyFUGjGHx6l8ct5+vdach6MvxE/LrfGjnJhvn+9OmmHkfytiI+MnQYW1
   R3q9tLqUL+O3vXWpVhZH50fBoDAVs3QI/eWZjbxYkRg6i5CtgLKCXclOs
   kU/rXXLk4qKS3uLPKH9VMYt4m9DzNY+NVD6NKwk+L8iIyk6spgWbPEliz
   6qTvubxUNF+8nS8B3TnXVIMYiQi4EVgwfaZELZb+p3xXeAp2CDkbo0oZ0
   JlpykXRn+X4YYBaiYPgIEuyT93iBa9jtGgb3P01SphRSA3hbAVO+Jcscc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="359069384"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="359069384"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="860210245"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 08 Sep 2022 15:43:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:43:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:43:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 15:43:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 15:43:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYjrPEwIhWg2MlwH6IOrr8+nVFCgpBe/VvGDXtXcpufbRU9lQ5bi5BkYh6asn/FwZ+IBDTCi7CHIWqHyd3mfgx7mhtz/J6jG01InnxZrCtMy7+V2XIfoTm67WiWgzc3cctYEm5VD4AmQ0VxBy5xqCxvbNT6kXZIR9PYarBnWbpS0SxoYrxqiyjMjRYQlg12XpO7uDwjdKviIYzvcMVt8g317dp3DUs0dqKvDZFuFxfsOqcSErW5H5CImDdNUBYYV0O4BrpErVlxVq172wL5eS+cv12gHey9nrEVUIyyZjnAMeynHStPtxfQOuTXNhjjKZ9eHegT92bBDZKe9PLvKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bE81C8pGe73+SsaEB41/PvMCd8zVBgRB333tVGYXmRs=;
 b=iLsLHCM0uzWR4WHwLjUrhGtxfIgtkA1CSKUWzFR3NfOT4LoChlmxFBgwQga5qF3gj0bUV5aAgAcsvNBGRHduJBrMe6d5ejrw5lobQwLHhqeNAgbbs8pzEniKqIepYse8Pt9yVdHmNjHiftkXC7yvyaQ1Wf20WjJhkk2Ki0o7fQIEdq0jzKfFgpUjucWUY7k/IARO6sDr+Z7Yn+MNusFALl/OA5P9DqUPhEi+DdVLC2tfbplay1fLieLr+k91F+RjPGzv/2jXzU5LsEG7u/2DFyj+2A/Ks0XUEqX4f9oJjqSpO1g99YgJd7mflU3Hi+amEO78U914ndVcJyYTKpEFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4075.namprd11.prod.outlook.com (2603:10b6:5:198::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 22:43:09 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 22:43:09 +0000
Message-ID: <fe0e7a0c-da41-5918-6ef4-8906598998a6@intel.com>
Date:   Thu, 8 Sep 2022 15:43:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.1
Subject: Re: [PATCH v2 1/5] selftests/sgx: Retry the ioctl()'s returned with
 EAGAIN
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220905020411.17290-1-jarkko@kernel.org>
 <20220905020411.17290-2-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220905020411.17290-2-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:74::26) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f34d4dac-aae2-46ec-50aa-08da91eb80aa
X-MS-TrafficTypeDiagnostic: DM6PR11MB4075:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJ6wFeNo676zovCl2wMjxiH9mMmDfGuhStLEXBjcllMViElnJWIhI+LAdFrjkTRWQ1snT5UvjNkQYpm8VYilTsJ9x9AhMZcjy8lJsdUU0DZtZjvkCYYVoBEaZ86O41/kTRMX1dKTjwb2fKUySd7+1Y+q0MWLl7Gj3R4afDhtQU0o+GIeKcuNpmZ9omkzvxCvzJ8T0S+uriZCQMMb+HPhKURDeeGvpW3fBaB52YPWwKZeXihJoAanQwz6xuKe1mZ0ktx10JiziX6wQRCzzBx7J+uHUKa5NKJ0UFF3WuGcroT5s7GKL+l/cld/hPgeUN/lrNfiBdYhLSAU61+Iw9beks7CvD4pLJV4RnH6Bu8bhKrd7ymHRKTq2+zgqqmauUqkfBl72kNDxj1wghlmimZuG++gn58eVHCuxOdCvvZ5SFK8dC0GUzFlMdWOS3smvMFRowuIcdSKNvIhh6m/aTKF7hpDGPAK//htA3sW0sW9PgOjoqAr9iMOb+ReOcotZfqvh/zsCEgk5hGRNxIFzWKRx/5Z49bVJCtfF+4T2xOvpUIbzcFNMmh4alxL4du+29/iVHQWbXbTt+7q8Wb2Ak/ZDc+lCIb5Kp0lWJB2Ppj+/3ZVBQMEOCfFxWK7l+7JxQAbe4vzesx5zB6+N07cWGemHond85tvjdi9IT7TmYbgiSphuqTyUdRwb7SeMzqQjTS6qdaX00/2J28N4YumRS3XWUHBl193RVPP42vl00MD/vCUeWVjDFOwyPrz82sjRO+ZCxgOTE4gUzeKiawmMS/K0FLIbH7ZFsXBA97k5DrXmyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(346002)(376002)(39860400002)(54906003)(478600001)(316002)(6666004)(6506007)(6512007)(26005)(31696002)(8936002)(36756003)(2906002)(53546011)(5660300002)(86362001)(66476007)(66556008)(4326008)(8676002)(83380400001)(31686004)(66946007)(44832011)(186003)(41300700001)(82960400001)(2616005)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TCtKWjVJQjkrdjMza25KeC8rTm5Qbm0vazJQZWtaNFlwb2hUWGhXOVFrQ3ZF?=
 =?utf-8?B?bEEzL2NkcDY4aVFsZ0hUbTBHYnBKZFBiR3RJMlI4S3doUUhJK2VVdTRRZmJj?=
 =?utf-8?B?cklGQzRqSnlNSWkxbWxuWGFZWHFlZDViZklNR2tIU1E3MjcybXlSdTh6OVcr?=
 =?utf-8?B?NmE4QVJONC9PSE9URXVyVUZKQkYvY01rRElJL1ZDdXZRZ3VCM3BNbGd4Q2tv?=
 =?utf-8?B?Y2l2U245SXdvY0Y3QmhPcE1rOHhrOWdkOEtHTi9yd0kyLzBzajRVWjNRYitk?=
 =?utf-8?B?dWcrd3BHL2NvYkpnN0R0aEJHWGEyaENtSkdxM1NnTGVtb1hwbm5GanZKbXJx?=
 =?utf-8?B?SnBIR0xoaVJEam5TbkptNWlWaGVuZlRJRmREZHpUQko5elJVWWwrNDMyMjRq?=
 =?utf-8?B?QUFMS3lQVzMxZWkzM0ROQU95TkU5ajlhNDV2UVBQUHo3ZnFoSWJYSUJ6dFpw?=
 =?utf-8?B?WnppNTVtRXNGRERocUVlZVV4WWhUSThHZEE2UDFpd0xsVkpEOE5SUzlIN29W?=
 =?utf-8?B?aEIwY1QwS1RGaUU4SjQxSGZkcEVLa2NqVythbWE0TFhDTXJ4ZXZKbTRkN3Ni?=
 =?utf-8?B?UjJJS3VjeWJyQU53RVRxVktqdVdBbGtqVVh5UmtZN1crTnBnVlpiVkFTSXpX?=
 =?utf-8?B?dWVJQ2dPN2tFTHZtWDNIakF1UGZUeVFEOU1aRzJYK0NuQkgxRlVwZS9JT3ds?=
 =?utf-8?B?QXVMb3RtWWYxclVmL01pU05FVVZFSFUzZ2IvcHhHTGdQSzZxdlc0M2ZiTWY3?=
 =?utf-8?B?UDc4V1BVZlJIU0tqN0xRS0JiT2l6WEcvRXkrVHU1M3pUeEU4dXFxd1lWN0FF?=
 =?utf-8?B?SDI3RWk0RHZkV3pGUUhWZUplZmlPaG9QbWJxaU0zWW1xTXVpWEpNVTdnYXNN?=
 =?utf-8?B?dkJSR2lyckM1dmV0eHR0a2lFU1dWUzNSNVRucTU2V3ZHWWJSV0pVand4ay9J?=
 =?utf-8?B?SGJzczUrTkJ3VWhKWHBaZ0MwU1VxZXFJOVMvQ2JpbmpCMDA2SG96SWcwcWx4?=
 =?utf-8?B?WGMyRnM0cG9WQW9tdDM1NEIwWkRQTFdYMXA0SUIyYjVveHlJZG1nSWJzWTFD?=
 =?utf-8?B?RzlrSmxPMmgzV0VKRjF5bUxqU211Nzduc3VicUhFdDA2OURSSFQzSkxnVmc1?=
 =?utf-8?B?NnJrU3VMVHNjd0RGazFPSk0ycFFFWnU1Kzc3bmp4eC8rYkJwbzBaNnZDdXpT?=
 =?utf-8?B?L2tKQ1ZwMmVtb1dBOWc2OGRKc3dBamV3Qm1La0pPcFh0L2swSzNDMUxVaUw0?=
 =?utf-8?B?elJoOTMxYUxHQXRNTHFYWEJNQVh6Q0sweWNOREs2c0tmTmlrVkczTm1GYTV3?=
 =?utf-8?B?OEFIeVE1QmNwTlBqKzZnbWtGVG5SMkVzY1NBTWtXUklXY1BUeWpaVGJ0RlB2?=
 =?utf-8?B?UndxOW1mRVVsQk05UEx0TWVReE5zNGkrNnpmUHVSOWFxbDZTMksvam5Yek4y?=
 =?utf-8?B?eE1xLytJZ09ETUpSOHlqczRDN2VuNTZmM2xuQ0xmT1Rua2ZmbFlsYjFvK1Mx?=
 =?utf-8?B?bjhvVDJ3bVZyNS9leERSR1RkQTE0cU1sWTUycmR5Tmcwekc1K3J3aDFqRm82?=
 =?utf-8?B?RXErbVE5TjR4VXoyVGQvL1FrOWw1a2UwblkvNnUvd1J0UWhxeDB0K0xmSlJl?=
 =?utf-8?B?TFoxQ2cwR2h2UEFTWlZkK3UxSjNWMEZEQi9SZEZqTUxtT3czZ1VST0pvQlN5?=
 =?utf-8?B?aUFBU0hWMlFnM1B4MUY1Z1kwVVJ6a05tOHd1c25HL1hMcWkzWVdVNmNEUFBa?=
 =?utf-8?B?L2FPNDRDS0JkTWtLbkp1M0dXYUs1L2lZZ0xMYVgzVkFYcHVwUTVjenQ3WmlV?=
 =?utf-8?B?MmRDZ2tSSWdGcENlcFpINHZvd1o5SFNMbTkxaWZ1QzMyZzA0ajZQQXQxb0Nm?=
 =?utf-8?B?MFZpR1dvVkdkV0x0MGdkczVveDUvZy9sMUJXa09hTC9MTmxuK2lJVSs0OTdU?=
 =?utf-8?B?RjF4eEl1bktwbXMwQldHa0ZBb3FmSzZIWVl6WlRSRFlBTFdmNTZiMldWQUVS?=
 =?utf-8?B?SXdPZkFzM1AraE53Rll5VHhnQWJQZnF6WVJqbDdrS25hN01ZV0ZSczFCN0Q5?=
 =?utf-8?B?WVJ5eU9XMlEwZ0VBQzNNZGU3NUU2TytGQ1VtOXhpWFVtUFpaWkJ2VzV2ak5v?=
 =?utf-8?B?ZThGNVZKMG5RWkJLOE5meDRlY3pCNmdJdE42S0hDNXBYTFJXOHlLQnRqTjRC?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f34d4dac-aae2-46ec-50aa-08da91eb80aa
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 22:43:09.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jildkCMvAVjpFzw8I3Hfder4yQSBXz7n+IzP4O2veCrTWSdO0iCKHvnQ5Q9wZtovEx9HJU/cw+nqJndHX3GDJrgQNPiLK7bUCDBo0pdG+8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4075
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko and Haitao,

On 9/4/2022 7:04 PM, Jarkko Sakkinen wrote:
> From: Haitao Huang <haitao.huang@linux.intel.com>
> 
> For EMODT and EREMOVE ioctl()'s with a large range, kernel
> may not finish in one shot and return EAGAIN error code
> and count of bytes of EPC pages on that operations are
> finished successfully.
> 
> Change the unclobbered_vdso_oversubscribed_remove test
> to rerun the ioctl()'s in a loop, updating offset and length
> using the byte count returned in each iteration.
> 
> Fixes: 6507cce561b4 ("selftests/sgx: Page removal stress test")

Should this patch be moved to the "critical fixes for v6.0" series?

> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v3:
> * Added a fixes tag. The bug is in v6.0 patches.
> * Added my tested-by (the bug reproduced in my NUC often).
> v2:
> * Changed branching in EAGAIN condition so that else branch
>   is not required.
> * Addressed Reinette's feedback:
> ---
>  tools/testing/selftests/sgx/main.c | 42 ++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 9820b3809c69..59cca806eda1 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -390,6 +390,7 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
>  	struct encl_segment *heap;
>  	unsigned long total_mem;
>  	int ret, errno_save;
> +	unsigned long count;
>  	unsigned long addr;
>  	unsigned long i;
>  
> @@ -453,16 +454,30 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
>  	modt_ioc.offset = heap->offset;
>  	modt_ioc.length = heap->size;
>  	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
> -
> +	count = 0;
>  	TH_LOG("Changing type of %zd bytes to trimmed may take a while ...",
>  	       heap->size);
> -	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
> -	errno_save = ret == -1 ? errno : 0;
> +	do {
> +		ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
> +
> +		errno_save = ret == -1 ? errno : 0;
> +		if (errno_save != EAGAIN)
> +			break;
> +
> +		EXPECT_EQ(modt_ioc.result, 0);

If this check triggers then there is something seriously wrong and in that case
it may also be that this loop may be unable to terminate or the error condition would
keep appearing until the loop terminates (which may be many iterations). Considering
the severity and risk I do think that ASSERT_EQ() would be more appropriate,
similar to how ASSERT_EQ() is used in patch 5/5.

Apart from that I think that this looks good.

Thank you very much for adding this.

Reinette
