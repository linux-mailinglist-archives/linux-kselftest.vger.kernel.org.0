Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AD56955A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 01:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBNA7l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 19:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjBNA7k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 19:59:40 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A100414226;
        Mon, 13 Feb 2023 16:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676336376; x=1707872376;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=1HoFawOkz3MrbuM09uhekJiVhverxvpevd+0wVFxyKM=;
  b=TtPNj6j9IaA6xva3MsJxTm5Ee9861UXNRafhhxzYg86wlPiAapQSVDXR
   26vHp9yVjz/7/tyMay0CjuGxcgB6aZXi6m9OAM2Cbsy3u4m87O0UFRP4+
   Z8hT06hH21kZNGut3CPIlgxh6+tLsPxBPvVH4t4PYt4jVuD0LEY7YfqAn
   WNKo2PIALTYd5aG4XjFbSec+XHbd1p2pvLqK5Pcht1DAXFussOp6mI8TI
   s/zqJ1gbphX9y2yjoYl3TmcUo2e8jj8zVLGGux0Fa60f9esIbDsdCux/g
   /uZ5eFIQ6mJJ0Cl9NqqySuex7XxL+r7okTfyAss73ZJ8Da3jrtFuObIZc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="331045845"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="331045845"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 16:59:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="732693676"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="732693676"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 13 Feb 2023 16:59:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 16:59:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 16:59:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 16:59:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N//ZFdcXx+DgCx1CFlI7LO9LRKpJTPwea8OcHUbLuwj38uanDHRJH65L7rFQOaUJv97CdWAQudg/W9fABZ1qHck9u4+goirbjkZ+Qf7TNFuCNwj8sL9UNRqKofZJknhCC4ykem3pqM9iwbh6f4E3SiBg0iUrWErBonvLpiTY5JhIL2Yj00tEFyC+u0vy1YPYDTOH/7nW8hZAWB8I3XZYuxrnlh6gLuLBq4qIEAlJyAN9LmJLCw5Wmgx/nMqD+ut14DvHe1QVsR7hJQ8VxOTEuWQTAM2nFOSmrmettPVbcX+nYSUrfVW13gxKbo+TiMilQe25iFhv8WfpgU9eXYe9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4Kqj4eQrmGof1TWr1Kb2Z/HIvEorZXQrTfADjvpO80=;
 b=RMBnaRncbejTViG+HPWMbK0hKyCvAM+njWXNP0/wTdQr88Q7jZ++JbU211iQIgaulfnNJas2OzhdAUW/wPsLHNbRn42lyzHkJYB4iwVronfbUFWSrkz3budGi0irTT/Wov8ZLZE5IoE8PoG9tvMAZqMeK+ojc47gpUcZaZTmQ535m0gW/ugxZMi9oeSo7K/H60kpC+3Kxwlv1hJQL5JF1I3q3vXthGay6qIlBcLe1+D49VE/7l7KXxbgZrEAe6hOZNqN+raDtIor824LXD/7DK6TQejM2geEYpPepkaloHgVPCHuK2J948fBd2ejl+nkzwoQQSF6GbOV90mBJXbnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 00:59:31 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.024; Tue, 14 Feb
 2023 00:59:31 +0000
Message-ID: <8ed0dcbd-86af-2658-95de-fdccffba7728@intel.com>
Date:   Mon, 13 Feb 2023 16:59:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 2/4] selftests/resctrl: Don't hard code divisor in MBM
 results
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com>
 <20230208094026.22529-3-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230208094026.22529-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:40::36) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW3PR11MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 22403a82-7b75-4c9c-f890-08db0e26bae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74g7E4sMbo9z2lQs42mxpAgEsOLpUump3PloJhomaKoLDqJJjDQZ9o7BgT9uah2j9h+o0d+BGipgMYhJumjxf0+wLpZXqBVngE2qSvC+hhx5aTCp97JeKdBZlcXve7INeTaw3KvLrZyBMhACzeHm0LxDuC3ccXA4sOZh9MWdUfHwu92WNvrFetQ2u9Vnv9WH+y6qKQr5h4iD5YB3y5RSAoWHE1NFt3luit4qFAd3fXfAyXbLHzvzmKB4DcaMlhKTm/9hmiPwX7YZDLJe1pqoYTGTiJzQ43IaQwmXIT4qEL1Iw38ZtQ/Nq1HoaYCuRqPrBNapk+Cwp35I9D3UFhDT7HKcbx3jUDM4bEQMlbZXP707mc0bhg+KwaRiaiEG1zz9q0L14DZgnYcO6VM+50sQ5rmt007Y2n72HHOCisNxNo+eJWAe7Lp6SCMHrtGbf4Npib0IVxHcNTrLrNdeVQPZKuj9EvBe4ysXNvZPGlRc1qNvCagRws0N1FcMzhmYtjl+HxWx+pIPwTLaP64YQcnxi7D+a9UOm4jHzL9wGHTV6IyxMxolL8Hs4JDGbhgEZ0CP/iDDIearbWA37t4gAZWaExCCs3oWSAf1lr8M+o+jdVSa7YThV37FUqX87sp0bqJB7S+QCJFGmpOH3aW/mVPGcKRiB1VeFT8FxgG1KqQX595+7pweZtR+sgqP5xFDvMhZMqT1dTD4Gr79QklAc6tUChOWPEBSXkaH33kMq5yofFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199018)(316002)(8676002)(2616005)(83380400001)(86362001)(82960400001)(31696002)(110136005)(53546011)(38100700002)(478600001)(36756003)(186003)(26005)(6512007)(6486002)(5660300002)(31686004)(41300700001)(8936002)(6506007)(2906002)(44832011)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?endvSll5UDJ0YzFFb2x3b1c0WlVKQVpwTEN0aUhQTndwSnBYQWNpSWZtay90?=
 =?utf-8?B?OTV6aThnVVRpeTg3andXUmZkT2JRWkNiR20yelZyQ2lDTDExOXBMcVZOY0N2?=
 =?utf-8?B?c005NlEzTCt2OXRKbmduSFN5ZFQrckdXSXA5YlVSdnRNK0c3a0x4UWY5UnNW?=
 =?utf-8?B?bEluYTZwclAxRmVCS1gyblRVTm41Q3FjZE1xcHBMWVBkd3RzUUd4clBRUm4r?=
 =?utf-8?B?ZWordGE0N0c1ekFnRHZrUUZxQ0ErNjUvSThRb0xNRFlOQmtJSFRLeFdHOStO?=
 =?utf-8?B?SitDVnhBcm14U0l3WE5yVnZoU0pyblhMaW1ReWF2bStpTWk0RHo1ckpqU1Ni?=
 =?utf-8?B?WitJUWkzcFc4Z3NiVUVka3UyV3dTZjNJLytBVVlIc1ZaTVRCQkwvalJIVzAy?=
 =?utf-8?B?ODZzVC83MGZpRmhTUFlEZmhSWW8yVEtOamJMdVNvRDlJc0NRZVpscEtraEkw?=
 =?utf-8?B?bFJvZVR2Wm5Ock1Vdy93WWhMZnR6cURHZXlsOUFvSEdabnBwT0FQdDJIUGIy?=
 =?utf-8?B?V09FQ21FUFI1MlZBWXJpemxucW1hZE5iZjVXWkE5N0x3OEcwYTZ4YWJJcXI4?=
 =?utf-8?B?a2tTclBvcGlkZ0dpSHYxUDhqZS9JWnVCTDJlc1B1QXdoR2VuRTNyc0VpaFo3?=
 =?utf-8?B?aGF5ZGh1dG00ZkNRZTRscTF0akEwaXZGdW5jMUY5dlhWM2x4cUVMMnVycWxI?=
 =?utf-8?B?UHN4bEJGY3JxUk5ZdnlxNU5VWG5WZUtXN0pBU1ZTenkwNHd3Z3FGQkhWM2lk?=
 =?utf-8?B?UTNrbDV1OVBMSlFrMnYrTXVEWFFFdnJJcGQreWNCUzZCVnVtWC9aSGoyZjdW?=
 =?utf-8?B?SmluV3d2alQrT0J3OVJCeHduRjhVd3FJS2FCN0JGZHpndVJkSnZBL2MrM0d5?=
 =?utf-8?B?blBURUcwQ1E5T2Z4am9FSURmZGVqQmJUVnllV2U1em5vTHRwd0RDc1FzWGhC?=
 =?utf-8?B?NTVLd2NKU1lIME0vQWQxaFdxK0RLM1h2VGxKTlpLYXAvdkxaNXBsYnFCU3cv?=
 =?utf-8?B?VWJ1QW8zSW4vK3ZEd25nQWlBR1ZrVURrWXo3K1AzUk1nUGQwSS85MFZIK1U1?=
 =?utf-8?B?UHZjVEZRcVpsUWJoS2lsMFpINW90dTRFV2RpRkVrb3FrdUM0T0tyTkphYkda?=
 =?utf-8?B?L0dyVWg4dGpBanJwc0RRNFpnczUyNU5sbjgxT0NEd05yRXpRdFlTOUEzV3lN?=
 =?utf-8?B?eGozT3gwbW1ybm5EMlV4blR6c1VPRjNJeTNWb05TdFlJcm8rdDJnYldPVmFu?=
 =?utf-8?B?UTd2SGVtQlBSRUtvcThLZlA2d1JBV3kxd09pQWFGR0UzQjdvL3lWdVZpLzlU?=
 =?utf-8?B?Tnc5Skd4bXZ0azgrWU9FbTFzQXdNcEUvT3lSeWpBaGZOa1RQUUpqRjYydk01?=
 =?utf-8?B?ZEt4cytnUzZENDNqZmRLQ1ZwVEZiQjVQdG5MSHU2cmh2MFZ6Y2cxbzhMZC8w?=
 =?utf-8?B?NmluSEN4dmx2YVN4U2cvQkZWTE9yckhvRDRpM0YzaDNKYS9jQXBmeXNtbEMx?=
 =?utf-8?B?Y3VVdzcyNEJGOUhqRGJrK0gyNDVaT0FUNXVEck9QSnVLalQzb3dycnptNHB0?=
 =?utf-8?B?d0N1RHNaQkRQYlMvbldjdEc4NnZmb2FwWlVEY0xKUENXLytva0svRXJGbkdS?=
 =?utf-8?B?bW40UmhjSE9zU2FSR2NUcGNBTFRncGxVSjBrcHJTdk03aDBSeUcxS0piL0ln?=
 =?utf-8?B?VUhTMHRzb0dzVytDYjVNS05FUERGTklFWnhFY1R2UkRJWGdVME5BNnNlR0dz?=
 =?utf-8?B?U0NDc1JyOHV5eHhVMHZIRno5VERSU1FyekVOVk5nSWNEd21JVWdTOEFDVnF0?=
 =?utf-8?B?L3QzcFpGdDdMWlIwdVV1WXd6cFFTeTRubk9MYmJzS2xUaHZyQ05UaklBVzB5?=
 =?utf-8?B?Wnh3Q29PRXFPSWdmTDA3eFl3cnlsd0xxV1JiVkk0ZWE5OHBKWUcydHFuVWFZ?=
 =?utf-8?B?OUxMVGdWMWxYZnJNbHVtMFhHckEraU1HYWtOL3BBSGlqRHM2OHhpVDkvUVEw?=
 =?utf-8?B?ajlPbTZkeVRUOThuNStNdTZZdXBCV0x3ci8xdENaa0EzZjM3endqNkhaTGYy?=
 =?utf-8?B?NVA3MkdmclNEYjFoOU5QcUtEV1JhbDVDM244VmVqS0VYUW5WUllzcEpJR2lS?=
 =?utf-8?B?THpmRzVIYW9qRHVxeW5JSnFXakJXK00yNXQ3MklyZk1IcHc0VFZGSEFWT0Yr?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22403a82-7b75-4c9c-f890-08db0e26bae9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 00:59:31.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFQY54AFhE68YI5ULOppGnA8QNnXKYn6+AYQ/CIZl/7Dw/DYucymL3guetzd+nwiOKaZRqxFPa7fI/0vd9gsIx/GvphS/rgnhqfsw9uW4hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

The subject is "Don't hard code divisor ..." yet it seems to me
that the hard coding persists. It is just changed from a magic
constant to a macro.

On 2/8/2023 1:40 AM, Ilpo Järvinen wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Presently, while calculating MBM results, the divisor is hard coded as 4.

"Presently" can be removed. Here and in the rest of the series the usage of
"presently" and "currently" can usually be removed to improve clarity.

> It's hard coded to 4 because "NUM_OF_RUNS" is defined as 5 and the test
> does not count first result and hence 4. So, instead of hard coding the
> value to 4, change it to NUM_OF_RUNS - 1.

Are there any plans surrounding using struct resctrl_val_param::num_of_runs
instead?

> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Missing your Signed-off-by?

> ---
>  tools/testing/selftests/resctrl/mbm_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 8392e5c55ed0..4f85cbbfd037 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -31,8 +31,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
>  		sum_bw_resc += bw_resc[runs];
>  	}
>  
> -	avg_bw_imc = sum_bw_imc / 4;
> -	avg_bw_resc = sum_bw_resc / 4;
> +	avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
> +	avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
>  	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>  	avg_diff_per = (int)(avg_diff * 100);
>  


Reinette
