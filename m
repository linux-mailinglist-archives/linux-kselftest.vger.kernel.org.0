Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7651672DBD
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jan 2023 01:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjASA5x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 19:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjASA5w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 19:57:52 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88202683CF;
        Wed, 18 Jan 2023 16:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674089869; x=1705625869;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YqRqttqmsDPiMcpp7WOirSJvw3qFtsl7UfN/FesOc9Y=;
  b=H9O5CC0O69utXWlmekPFnDEEYB4u8AizHtuZE26nfsiG0axWtNB0ShEy
   L7qSJk9QkcLsXyWrc80d1nZ52vm7MOd1+ecbXyFTOpEwgZBJM+ZuZUWxV
   YSm+CLrioJ0ioTowBgkyWHwtzJaHh4pQAl+C250JX0y5y1/fxMPXebKl2
   rTXA9vpCq1wtx/Il+R5B8arrVvyepOj7EbpA3QIFvB9h6uFMraa6JG6a1
   YL009M0FcA4yn9shpj1CWTopR2maeHh0JoZwLFEUUKgPejpB/+MpaaPOg
   ReTyT+Rr4mpVUadbDzjgjXUKHbLeSBwmSxBJrS7/MvwTYRcHNtnauWa3M
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="308713276"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="308713276"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 16:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="723305099"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="723305099"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jan 2023 16:57:48 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 16:57:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 16:57:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 16:57:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTQTrFoIndB0pXlV1U4jeKJMO3LtYsRreDkP2sBeTxlidmzpsEfwlYHDMAIDuEGEf5fwCoPHj6eyT1xzqlViRuZVy1WAxXZSb1oqP8UfKMhKZORnzCJY2SJVf3Q6+gJxDM7ZVCBqf6BdXHb73mCnLlZ7VfMpyldriiGUgicgLKNV1/IMznqe5RiM9yZlJNpxD6Jef6HOFhtff1DAKLn0XaF7UViVUOHsKy9P0yiLaAKTMT3divA03m/0YMkwnNFUAm2g2AGJWKuk7ldW5IUkeRNqISv4DHyEPhfLajEczopt6zSdCE3DJ2Fv2dGw0iJiGCqiBYoOLPyEEzTPnL+WCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42yJpXkgw7S45yMcPNTxb11eXMboah5GzdZv6PxBj58=;
 b=DAZ3PSfsExLpyh17H9Pl5j+pQ1nCanT9vyIdp/DINVdSJz6d785s17QDZJZQmADU6QSwgmB2b39zpGZjHvzSRRG4mavFtTdAxVVdlzPElGQ3PWx1O5mbylNoAVRgwm0OVHOW25UetpqGCd5SwEZeRcyJXbnGhFpd4gFjExnvsX/9uy/8z3waqx2HrQ7/kRsX4fNqCFHgGX1OLeNGAONR0TR5BdJQdokS+rO9YJdupq1JwHjydRxpa445L1ManBc8a/7IpURlPvOejhJlhyWkzOqdp8V0JMTtulU+4cvpUQleMHSk1Wr+ZrfjTXqTuZdzTRYtepFa7wCboVXnhhpYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH0PR11MB5347.namprd11.prod.outlook.com (2603:10b6:610:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 00:57:46 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 00:57:45 +0000
Message-ID: <3201c461-2f46-f354-6019-94ce8978fb46@intel.com>
Date:   Wed, 18 Jan 2023 16:57:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v5 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230111075802.3556803-1-tan.shaopeng@jp.fujitsu.com>
 <20230111075802.3556803-5-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230111075802.3556803-5-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:332::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH0PR11MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a0a81c-1183-4264-d2fe-08daf9b82d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: moGqsWoOX6X5ZXK11jfuprfXByrN9vlC7NBPEVkcOFfx94HT1/7FwvXWojlD+y69JK0gzcST+hqYMOox9kTyYUqgu3lMUN20mjuH+gmyLHyzxqPZsHUEQjF7tzWw3dRa2TiFSICQgqEgXlvYjzVmWGeeu+hoEIPVz2DOmpKf+GtKdhasDHdZWG6soGKQBlIJIcajOMpDxQmGUoBJHNG0sOiDx6/vsV+FlpvMokqwaMFqMMHcmwjZM5gLvFhosW+DknO46BISKzlPgIU2uxS1EobAUuGFZVuUyJaKVm6os95k+pMfqVhafhVKhO8Y8oPpY0EXs/G4CwHEvIMoeO2pp6qGUTthpyi/xf3cgCkaRqv0glPcR5zICoserPG7ZdLfhXs4lcA7xB2nhR/RG5JfzYtvqJ2qUlw/ZIcnoEVhObs8vd0WXIhEIHRutOPkkudJH2ZCpp02zLKGDA8POFxr7OWLSz85iGiOWvyX5EoMdWdQWYsAZT4L6n5phz4vhLQBB4ZRstmsQg7i2hgtWbt16vYauhZJ5ZWk6fynJx5E/UswQU+V8KUp0IWRr3h5rB7NN1qqVzqzf2o9R1FK6iPBR9SdNy5v3xFGCnv3VNGs99BSqKv8rZH1GxypftM6ORIFh+8VvpjlcgGAFjBC7Lq06oN8/8TrNa7Uk4HtmqeMN9qTIqKKdJFy/0ftRug3uLeyfy18TMzFHnqZsQpn5nZftxsjuZNiT/+yssM12+OWDuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199015)(6506007)(2906002)(36756003)(5660300002)(6666004)(53546011)(8676002)(44832011)(31686004)(4326008)(83380400001)(8936002)(6512007)(38100700002)(478600001)(26005)(82960400001)(41300700001)(6486002)(66476007)(66946007)(31696002)(186003)(66556008)(2616005)(86362001)(316002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXFZaUYzNWFSazdwYXM2L1hraUNrcFd1VzBvVVpTeXVSUWQwNC9mY3FiK24v?=
 =?utf-8?B?NW5CeVU0bGFuN0crenk5Y2VMWUhZcmg5YWRoakRLemdIUEN2NUtkeVNhalh3?=
 =?utf-8?B?UlVVeTlQcU16SFpoaXRBRFFzaDdsNnA2dHE0VUFpYURReGNiZ1VVWVgwN1dr?=
 =?utf-8?B?Z2l2T3JqT1JNRUY3Q1pWWjc3YllTRW5mYkcxbjd1emx6QmZCR3U0RkZUOHI2?=
 =?utf-8?B?eHhZMHpTZGZvdllQOVg3ZFZZZjFLZFY3SU9xazdCR3RpaWZXOTNzaW1tL0tv?=
 =?utf-8?B?TVFpS0EvYjh4b3Fpd2t5VEtZdkNRbU9QbXZ4ZitPaVgveWVUU01xV0liK1Y5?=
 =?utf-8?B?RUMyKzNCeWFZam43ckRjRlVISGdVWWtZbkg0bmFaaGlvcHVRajRQN2JCd2dY?=
 =?utf-8?B?OGxpZUs3b3dxY3NFb0tQZExDU3N1Yk81N3lkRExlcDc5R3BEY1ZFUW5uMXUv?=
 =?utf-8?B?ZVJEdVFQRDJPMzE5bFlndmxQbFpTelVVRkMvTFpscTRtUHBHZ2Q0dkVkcldX?=
 =?utf-8?B?UHQzUlBYUGxlZUsrRmNFSnB0YWNxbVFrQ3lhbGduR3BGRFRMKzBabGZEYmJq?=
 =?utf-8?B?MjR1V3B6ZUVnOVo2R2wydHM4WCtWQ3JHSnlnTVRGa0pRelFhdXZURWhwb24z?=
 =?utf-8?B?RG1qenpWM3ZSMjJHZko5b2M2czc3Z25POVozNE9vVjdCelcxQ0tjNng2bk13?=
 =?utf-8?B?TEZGM1l0VXR4TkY1TWtZWHVieDVHMHhIVnJwZjMyMXM5VVR3ZlpScG0vb2dH?=
 =?utf-8?B?Z1loTk9BNTBjOWNxcXdTVGU4elgvTmJiK3d3YlV0NkJLN09vZmNqenBNNFFs?=
 =?utf-8?B?MFdmYVFXcExqcytHcmFwczNYcDMxVmMxR3lXemtLZndrcUFBSllWd05JY3hD?=
 =?utf-8?B?dUVJbTNnZXhCMStFZUtRT0xDSHdEZDhDeHI3SkdvdGR5aFQ2aFIwOW84em9S?=
 =?utf-8?B?bUh1MmdrOVJDM2RzT05WNng4cmd5dGNjRmpHTW44RmRoVjduYjNIc00xdUJj?=
 =?utf-8?B?cVdXTjVPa2ZsQnRodkxKc3JZVXlQQ05zeDhvOXdLZ3Q5WlI2dU1sRUVXRytZ?=
 =?utf-8?B?S1ZITWlpMG1yc3BVQjZTdDlxeVN4USsxNnRrcnA3bkw2REVCV3B2RGxXYXN3?=
 =?utf-8?B?bUlacmsyVXpQM1M5bVE5NjJ2cURIVlo2TTAwdWZkclNiZEdzT0JUeEp6T2lk?=
 =?utf-8?B?bUVoRHlRalA0RTFtWHZScG45Uy9UODhraXdQaGYvSjZlZE1oaWFTc2kxZGlO?=
 =?utf-8?B?aExUTzJRS1czVFFEQzUzc0dwWDlVTll6c0k3WU55MUhLNzNJQWtWVSt4bE96?=
 =?utf-8?B?WGlHOTQ4Uzl1K05SZndlaU9xNFF2RDJkc05QMmU2THFnZHRGRVFDNlE2VkRB?=
 =?utf-8?B?SWNYbVB6ajk1b2ptcG9wK2ovdGI1QVdMWFE3WVNMZ043K1JOY29ST0N3T09q?=
 =?utf-8?B?bEwwa1VPTTFxR3JhSXRPTWI1TzdZTzU3V1M5WW9kZlF2TW1FQnZlTnlQd0Ny?=
 =?utf-8?B?aVRBODZOZnNkZGVpeUY2MjJkWHZMYk9mUDkyRGY4TnB4YTh0cjdiTmhacTVE?=
 =?utf-8?B?a21lVnlmcmVrR1pySEp6aWZWc3A0WHZLUDJyTm1PZWc0SVhnS1NYOUJRMWJ6?=
 =?utf-8?B?cDErN0VncGxVY0l6RFdCa2NkeE41OThBWU9UWkhPRGFRc2J6ZElQQ1RwNHZv?=
 =?utf-8?B?UEQzT1V0c3BIU25ycll1V2x5QnJiYmtmOTFXZ3NLTjRNUWhnMjNIMUdqcG5M?=
 =?utf-8?B?OXFKTDEzeTBkWXJ3Y2dwSnVyOWdMSEw0MER6dWxhdjZJSDNPWGdvYkpWUVlQ?=
 =?utf-8?B?UUJrM2JOWDlwU2lmbXlDTEVxUmp2eWpwdmR0ek96UWJYak1nSW9Nb2pMeHFQ?=
 =?utf-8?B?K3ZVTGV4NTQ1VkRralZESDlCTUdOY0s1VWhQay80aGNrdmROTTNqQ0U3cDRn?=
 =?utf-8?B?QXJTeDQvNWJJZmtVUXpwSVp3U1VvMm1PbHBOSFZpTjZkQVZwekNRcXNTS2U4?=
 =?utf-8?B?d29XY01WeUo1TWlzQkt4NFY3cTNYQVJoSlNtL085ZENCaFdIa0FEL3daWjlz?=
 =?utf-8?B?RERzQTBBdHUvaU9EN0ZReHladDVxUER1TGdqRDNCelFZR1FPNTREdGE4TVY1?=
 =?utf-8?B?d0syZ1RzOVRIbWdVWTcwcnlBSjd1V3JBczQxVkZzNEFMbW5NM2tLM2g3MDlQ?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a0a81c-1183-4264-d2fe-08daf9b82d49
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 00:57:45.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKOeKF9sQdeki4JwjyjG82Hg0cBdeMPEIPS9fKpjkPrsd6KXkTQ2bcZ93Zq2hxwBN1/GiDyGNFMo8A0nVEuaRmo0/iWj52wmfarHVdbSBM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5347
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 1/10/2023 11:58 PM, Shaopeng Tan wrote:
> After creating a child process with fork() in CAT test, if there is an

Please delete the "there is" so that it reads  "if an error occurs"

> error occurs or a signal such as SIGINT is received, the parent process
> will be terminated immediately, and therefor the child process will not
> be killed and also resctrlfs is not unmounted.
> 
> There is a signal handler registered in CMT/MBM/MBA tests, which kills
> child process, unmount resctrlfs, cleanups result files, etc., if a
> signal such as SIGINT is received.
> 
> Commonize the signal handler registered for CMT/MBM/MBA tests and reuse
> it in CAT too.
> 
> To reuse the signal handler, make the child process in CAT wait to be
> killed by parent process in any case (an error occurred or a signal was
> received), and when killing child process use global bm_pid instead of
> local bm_pid.
> 
> Also, since the MBA/MBA/CMT/CAT are run in order, unregister the signal
> handler at the end of each test so that the signal handler cannot be
> inherited by other tests.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c    | 26 +++++----
>  tools/testing/selftests/resctrl/fill_buf.c    | 14 -----
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +
>  tools/testing/selftests/resctrl/resctrl_val.c | 56 ++++++++++++++-----
>  4 files changed, 59 insertions(+), 39 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 6a8306b0a109..87302b882929 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -103,7 +103,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	unsigned long l_mask, l_mask_1;
>  	int ret, pipefd[2], sibling_cpu_no;
>  	char pipe_message;
> -	pid_t bm_pid;
>  
>  	cache_size = 0;
>  
> @@ -181,28 +180,29 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		strcpy(param.filename, RESULT_FILE_NAME1);
>  		param.num_of_runs = 0;
>  		param.cpu_no = sibling_cpu_no;
> +	} else {
> +		ret = signal_handler_register();
> +		if (ret)
> +			goto out;

The "goto" will unregister the signal handler. Is that necessary if
the registration failed?

Also, if signal_handler_register() fails then the child will
keep running and run its test ... would child not then run forever?

>  	}
>  
>  	remove(param.filename);
>  
>  	ret = cat_val(&param);
> -	if (ret)
> -		return ret;
> -
> -	ret = check_results(&param);
> -	if (ret)
> -		return ret;
> +	if (ret == 0)
> +		ret = check_results(&param);
>  
>  	if (bm_pid == 0) {
>  		/* Tell parent that child is ready */
>  		close(pipefd[0]);
>  		pipe_message = 1;
>  		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
> -		    sizeof(pipe_message)) {
> -			close(pipefd[1]);
> +		    sizeof(pipe_message))
> +			/*
> +			 * Just print the error message.
> +			 * Let while(1) run and wait for itself to be killed.
> +			 */
>  			perror("# failed signaling parent process");
> -			return errno;
> -		}
>  
>  		close(pipefd[1]);
>  		while (1)
> @@ -226,5 +226,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	if (bm_pid)
>  		umount_resctrlfs();
>  
> -	return 0;
> +out:
> +	ret = signal_handler_unregister();
> +	return ret;

Be careful here ... any earlier value of "ret" will be overwritten with
the result of signal_handler_unregister(). I think the return of
signal_handler_unregister() can be ignored. There will be an
error message if it failed.

>  }
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 56ccbeae0638..322c6812e15c 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -33,14 +33,6 @@ static void sb(void)
>  #endif
>  }
>  
> -static void ctrl_handler(int signo)
> -{
> -	free(startptr);
> -	printf("\nEnding\n");
> -	sb();
> -	exit(EXIT_SUCCESS);
> -}
> -
>  static void cl_flush(void *p)
>  {
>  #if defined(__i386) || defined(__x86_64)
> @@ -198,12 +190,6 @@ int run_fill_buf(unsigned long span, int malloc_and_init_memory,
>  	unsigned long long cache_size = span;
>  	int ret;
>  
> -	/* set up ctrl-c handler */
> -	if (signal(SIGINT, ctrl_handler) == SIG_ERR)
> -		printf("Failed to catch SIGINT!\n");
> -	if (signal(SIGHUP, ctrl_handler) == SIG_ERR)
> -		printf("Failed to catch SIGHUP!\n");
> -
>  	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
>  			 resctrl_val);
>  	if (ret) {
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index f0ded31fb3c7..14a5e21497e1 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -107,6 +107,8 @@ void mba_test_cleanup(void);
>  int get_cbm_mask(char *cache_type, char *cbm_mask);
>  int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
> +int signal_handler_register(void);
> +int signal_handler_unregister(void);
>  int cat_val(struct resctrl_val_param *param);
>  void cat_test_cleanup(void);
>  int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 6948843bf995..91a3cf8b308b 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -476,6 +476,46 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>  	exit(EXIT_SUCCESS);
>  }
>  
> +struct sigaction sigact;
> +
> +/*
> + * Register CTRL-C handler for parent, as it has to kill
> + * child process before exiting
> + */
> +int signal_handler_register(void)
> +{
> +	int ret = 0;
> +	struct sigaction sigact;

Why is there a global sigact as well as a local sigact?

Also, please do keep using reverse fir-tree format.

> +
> +	sigact.sa_sigaction = ctrlc_handler;
> +	sigemptyset(&sigact.sa_mask);
> +	sigact.sa_flags = SA_SIGINFO;
> +	if (sigaction(SIGINT, &sigact, NULL) ||
> +	    sigaction(SIGTERM, &sigact, NULL) ||
> +	    sigaction(SIGHUP, &sigact, NULL)) {
> +		perror("# sigaction");
> +		ret = errno;

I understand that you copied from the original code here but I
do think there is an issue here in that errno is undefined after
a library call. perror() will print errno message so keeping
it (errno) around may not be useful. Please do keep the custom
of returning negative value as error though. I think just
returning -1 would work.

> +	}
> +	return ret;
> +}
> +
> +/* reset signal handler to SIG_DFL. */
> +int signal_handler_unregister(void)
> +{
> +	int ret = 0;
> +	struct sigaction sigact;
> +
> +	sigact.sa_handler = SIG_DFL;
> +	sigemptyset(&sigact.sa_mask);
> +	if (sigaction(SIGINT, &sigact, NULL) ||
> +	    sigaction(SIGTERM, &sigact, NULL) ||
> +	    sigaction(SIGHUP, &sigact, NULL)) {
> +		perror("# sigaction");
> +		ret = errno;

Same comment about errno and returning -1 on failure.

> +	}
> +	return ret;
> +}
> +
>  /*
>   * print_results_bw:	the memory bandwidth results are stored in a file
>   * @filename:		file that stores the results
> @@ -671,20 +711,9 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  
>  	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
>  
> -	/*
> -	 * Register CTRL-C handler for parent, as it has to kill benchmark
> -	 * before exiting
> -	 */
> -	sigact.sa_sigaction = ctrlc_handler;
> -	sigemptyset(&sigact.sa_mask);
> -	sigact.sa_flags = SA_SIGINFO;
> -	if (sigaction(SIGINT, &sigact, NULL) ||
> -	    sigaction(SIGTERM, &sigact, NULL) ||
> -	    sigaction(SIGHUP, &sigact, NULL)) {
> -		perror("# sigaction");
> -		ret = errno;
> +	ret = signal_handler_register();
> +	if (ret)
>  		goto out;
> -	}
>  
>  	value.sival_ptr = benchmark_cmd;
>  
> @@ -764,6 +793,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  out:
>  	kill(bm_pid, SIGKILL);
>  	umount_resctrlfs();
> +	ret = signal_handler_unregister();
>  
>  	return ret;

Same here ... any earlier value of ret will be overwritten with result
of signal_handler_unregister().


Reinette

>  }
