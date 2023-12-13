Return-Path: <linux-kselftest+bounces-1864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3885D8120EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFC428270E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 21:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66A87FBB1;
	Wed, 13 Dec 2023 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jM5S27aA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1A4AC;
	Wed, 13 Dec 2023 13:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504445; x=1734040445;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bIRjhrqfqJV2HzvuDoSyGnf/UKJxJ6zHaaK7szQy+B4=;
  b=jM5S27aAuTLQ7/8IbF/hbt4Aj7MjnacbTH0zWC17ZyX+JMbTCYD5XvCD
   ud3pHvLAVHXao7bNY10VZ2KAE2Le6IfeMOZIql83PGb4UFlvdS9YD7God
   LBxeffUJf44HlPcvFZXb8UfY+P4rB2VboHi6cdYxef+0910QrfvzWujEe
   rIutWVCvio07Q2R+RLMGFDm7Amk0ip+MhrOB0YutoDhbmIq6hjRxdx2qZ
   s8jaP211d3+iUaCiHyyjLxhb4N1sN7yWS2edSTcbgkOsaH/YVApIiONTJ
   1IiDLCjg9Zp5jw7BSJxUkjyWaMdL6filYxki7BUr8cln0KDk6b5gZcthM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="16582510"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="16582510"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:54:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774095426"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="774095426"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 13:54:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:54:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 13:54:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 13:54:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLN2VRdQ9GV0/LniFRpWo+FoCI+AgOt8E5zZxuTLg/3GtAQYlp5aHaD4slB+FLoWeUWl2kkLxWmIK4N1dOYoc4J6q7F6I2JcnGAcBMSkRQGgKuiBhhs8uVn07St49k+JvbLR9lZ858KbxsvBw4k2lgIqsGQMoG2AzxMH6u1PSiINKh511vj9tX7/wpkPBcpua3mBur2hNOkIrGDcXOD4op+CNCUW+wnhVc4dUQVJjPEJg9pIJpbfVsSmR+kFAawI6b71gRWY5U7dXpskaYhm/jav/sNacFhLaUmIFiSr69YqVl4s9W/HAWjYE7CDFvTuWecB7W/6qFzPiAZ8/nZftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnNtn9Q8cTVNJ0BqK8XkxHARUiIu9PR6eI0AKgEEfnU=;
 b=Sz/0trjsdPhThxypKyRdKETi7UWHcFRAXH9l2jxoxE/qxl+cdt8q13wsFl3utPn9Shh9PA1yn8YfbW2Gj9EjZ0bJtnmRRb5DLE4Q9n2CQhnLm0unk1Mfd5s9q6Uw7MT2bp5EkWQb2DOcz2figsfK+kM0bv1BKPV+Y9AdR9xTVgEW0FMcBh1cdEEL8Qk9DZ6IQ6zEBZUT0V7M20Stg9YCL0PqOQZ/TBCwehDsomL+7GGG4TckaBNWCKi93/derSSXVXU0MsQoAYhK/vVwXiTOYm3onZHl46nWbbeRWUJj+HlyckqMFlTXqr85KMZwuRzDpUb8JVaX98NKhvoFBxXbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 21:53:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 21:53:57 +0000
Message-ID: <1e7ede83-ac80-43aa-a452-0f95b32d849c@intel.com>
Date: Wed, 13 Dec 2023 13:53:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/29] selftests/resctrl: Convert perror() to
 ksft_perror() or ksft_print_msg()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-2-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:303:8d::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 72718896-2737-4dc0-586d-08dbfc2601d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqDGBm84mwBWIs/CxX6vq9v2tUfWfFPyVsfe7u5MV1WtwRSHb0WH2KBBOlhzKsE1uE1hu2dhGatJYgxYJiKISFZlzI7MoGbNyxRJup9TM9h8dGgMYWjXVaAYK1CSHmsn+t22tAv9GemTx5v3ownakHEMD80pE8k8JM/ZDExPsZKtX6jwLqNxQsTL7lHTPQeG0znIwkxU+wVJyPlmxcLhVx0ZQXBcCZKPhdhj+ySHhcySad/o5auJZscZuZrGuSEpNOQX5HdqUzNiKFyZNOLqxJtGqZuR+7ldqXPbpb3kNR47twlrcWwNJMAMdEmlZ/k5ygL8eg2clJ8dGz51H76O7Ndq8GK+1IFC0oMUHpAvzO6jjFkjsSlkCS9EGZAUbpQRsgipldIM1pVQvCb81G7wDcJ3S6i9iBj0D5VKmkAN0chmVcMTjY75sBQHmoCDyjlYJoQzGWkDBFpglxPFRCPgVlH5y/g5kTzDDA1oJP0VBnkkb9AxRCEoauIXdHltBbBmZcoMctc6VBbDkg4fMgvYyE8Ql4C6y8EPYSSzxLOH8M3ap5ozzMgCRJZ3K7brDexFU7uHg/0NDcgLitxzAUmCwRBLM3gmGVwNX3uQSPh+l28Gs6bdI1LWfckGcrBu4ti0iyQtRyZzWMEQ3dYNZSu0Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(6506007)(53546011)(66556008)(4326008)(66574015)(8936002)(8676002)(316002)(86362001)(31696002)(5660300002)(6512007)(478600001)(6636002)(66946007)(66476007)(6486002)(110136005)(44832011)(38100700002)(83380400001)(31686004)(82960400001)(2906002)(36756003)(41300700001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmpnVkMrZDMyN0QwVktnY2tRMGx0dE9yS2V5cWRkYzd4dFpDSkZ1WlAwMGVv?=
 =?utf-8?B?WllLeCtMSzZqYVpsaUkzQk1oYlI1LzVHMVE4ZmV6SFRiM1FySGVoSmdzbmk1?=
 =?utf-8?B?NDdyWitQMVNpSzlnTUwrTHo2Skt3VDZoeXN6Nnc5RXc2TVhBbUpQQWhkeWM0?=
 =?utf-8?B?UHhncnJTNXN5R3NQQTZXbXZEVENFa2lnYXJqLzZsb0NMQnBsTjdUL0MzeVNG?=
 =?utf-8?B?cTJHanhmUTU4YXlrT0hHVUczbkQwZGhBR0x3RkRmcnFpcFNUcjNtcUcxK1J1?=
 =?utf-8?B?eU81azdiQ3ZiV2E4eUtQc3pRWkJCZ0dLbkFvSmNtWld0bmtqZXFPSllBRktx?=
 =?utf-8?B?bWRQZVAzb2xqa29CMCsvTDR6OC9Jblp5SEVTT0xvUmdOVXAyMFJjbnRjZ3Zh?=
 =?utf-8?B?ZnN3TElFNlc5eEJqTWhlczJzRmhGakdLTmM2eUdyMzNLRlhyM1E2VUxiUmhS?=
 =?utf-8?B?QzJOSXB5a1lHOGF5b1JQMW9velJMRklUMksvK3h4V3B5MDNnakcxNk5IL1ZW?=
 =?utf-8?B?ZFg4M0RFd29wVzEzRUZ4aUZqL25yeVRvSytpNk53Y0VpWTlxdCtkem5yaXV0?=
 =?utf-8?B?bHlOUDAzTWFremNUZkhaV0lPLy9kdkplcmdhZWNRQXJ5RE9vVnByUktqSlhF?=
 =?utf-8?B?YW9PZ3YyQUNSNCs1Ri9LaHd2K3J3bTNYL2lLVG41SytxdTBMTHZsWU9TdFhM?=
 =?utf-8?B?WVFYOGJ4YVU3b3Q4a3FMMGRXQ0c2bXpzTTRCQ0MzNWU5cGQ3NlRvODNNS1Vx?=
 =?utf-8?B?Q0ZBT2dpT2xtVmkrSU5xRWxURXdqbW1TcnBEdENZT28xNTNYNFBlMnN4UnF1?=
 =?utf-8?B?YlNqNnA3RUoxTVJkZUtRMENmdmtRTlR0bjNuNmkwMnRlS3U3WEk3QjZ2M2lo?=
 =?utf-8?B?eGtRQWorTm5TcExxRDh2SXh0bFpBd01DZ3pHYkVuR0V2V3RMMkNiQ3prUTla?=
 =?utf-8?B?d1U0dlNtQ1grMzJtUW5XWHkyNldKbVRzaDJDSEV4TnVMSThhcEVqVi9MUVNm?=
 =?utf-8?B?WThjTnhLRWFvaVM4SUNkZ2JaeHpySGtZaXUrMEdTOXdpcGk1ODVBTGdwdG9D?=
 =?utf-8?B?N1lZc253S0RKNU5NeU84dC9XcllSV3dpdTBzcEtXcWljUjFDUmRSSm0rNzFX?=
 =?utf-8?B?WmRTakhOMVZkZzFjMHBENXRnbXNvMU9qYkthYzI3MUVVMCtFb01DV0FrbFJG?=
 =?utf-8?B?eGpyditweGc1ZUNLZzNOSVdBK3dSSGluQVIxMHdMUUg5bUVhNi9zeE4wUy9s?=
 =?utf-8?B?MndQYnI3RlNmYUh4ejdlR01JNUYyVENLVDAvaEs0aTZoMTdIYi90YWpSWUlp?=
 =?utf-8?B?U2wrNE9CUm5JakhuWGdKOUhkTTBvT21wb1BxVGhvTWoxV3kwVW1wRlVVTjJo?=
 =?utf-8?B?ekltaEJiUGllRWROK0JCdW12NkVNMjd4NHBXNnlMekl0VWFBWURoWjBkcVN4?=
 =?utf-8?B?TEJoTVRhZHRDUjk2eHF1N3htRWZkellxNzV5VEJTbkVBSGdwZnoxcUxDZnJR?=
 =?utf-8?B?amRTUkNxMWhGN1ZHZnM0RzVvSWt2M1ZvRjFhL2NEZDZQei9VOEcyK1IrZXpT?=
 =?utf-8?B?YnhiekJ2YWMwY2hJeVRhMStCNFpsRGN3ZFJaSFNOeVpLQitLajJ5bGxBbmVh?=
 =?utf-8?B?WFJWY0NxUWVoL0dLaE1BblJ2SDNCZ2YzYVhuZzNOTWU2MEc5Z2FaamtDOEQ4?=
 =?utf-8?B?bEJUM3lldTl4ZkZEQ0s1dG1BWkJ0M3pGK0xOWTVwL2NPT1FXbmpxMER0dDF2?=
 =?utf-8?B?QUFWYk1aWWs3SlV5QXlQMXduV01vZEFUYVRqZG0wc0JkMU5yYWZ0enlNWVhX?=
 =?utf-8?B?dmw1QjQycGE2UllFR0ZhdlJGUXU2UnI4ZkhUekprdjE1OHlWdmluS04vVDlT?=
 =?utf-8?B?WGl2a3BkMklvUnppNm83bTVHNTYrR1k2SHBPNmFSR0lzMjBIb3hRa2J1c29N?=
 =?utf-8?B?dHoyNCtFbGJablh6VElTbnJTVHFBcGdhVDNjcmNqc0JiZWFYYWp6WC9zT2pY?=
 =?utf-8?B?Y0JWekc1U3VuNUpqRjhTK1ZzMGMvYnpVMHdPZzVIZksrV0F3K3lsUCtTQ1lo?=
 =?utf-8?B?SFp5d1I2dkhENjdQcE5SY0x2RkFLWjFrSnpiU1RETFB2cGdxSlFBTTVyKzgy?=
 =?utf-8?B?SWFIemFQM1FKcUVCQXp0cFFxNlljUVozNEVmQmgwd051QkRXWEJGeWlQWk1K?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72718896-2737-4dc0-586d-08dbfc2601d0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:53:57.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcy02K6k73P+LpB3iZhlC+pODy6vAWn5OAzXDwH4it6yAsVnoJAFWhjpMyaGRVoouGAbBxDbtl37Xkhe6m5RU8NOlfOkeXEGDt0VUqnVWjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:17 AM, Ilpo Järvinen wrote:
> The resctrl selftest code contains a number of perror() calls. Some of
> them come with hash character and some don't. The kselftest framework
> provides ksft_perror() that is compatible with test output formatting
> so it should be used instead of adding custom hash signs.
> 
> Some perror() calls are too far away from anything that sets error.
> For those call sites, ksft_print_msg() must be used instead.
> 
> Convert perror() to ksft_perror() or ksft_print_msg().
> 
> Other related changes:
> - Remove hash signs
> - Remove trailing stops & newlines from ksft_perror()
> - Add terminating newlines for converted ksft_print_msg()
> - Use consistent capitalization
> 

Another great cleanup. Also thanks for fixing some non-sensical messages.

...

> @@ -149,7 +149,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	param.num_of_runs = 0;
>  
>  	if (pipe(pipefd)) {
> -		perror("# Unable to create pipe");
> +		ksft_perror("Unable to create pipe");
>  		return errno;
>  	}
>  
> @@ -185,7 +185,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  			 * Just print the error message.
>  			 * Let while(1) run and wait for itself to be killed.
>  			 */
> -			perror("# failed signaling parent process");
> +			ksft_perror("Failed signaling parent process");
>  

Partial writes are not actually errors and it cannot be expected that errno be set
in these cases. In these cases I think ksft_print_msg() would be more appropriate.

>  		close(pipefd[1]);
>  		while (1)
> @@ -197,7 +197,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  		while (pipe_message != 1) {
>  			if (read(pipefd[0], &pipe_message,
>  				 sizeof(pipe_message)) < sizeof(pipe_message)) {
> -				perror("# failed reading from child process");
> +				ksft_perror("Failed reading from child process");
>  				break;
>  			}

Same with partial reads.


...

  
> @@ -540,14 +540,14 @@ static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
>  	} else {
>  		fp = fopen(filename, "a");
>  		if (!fp) {
> -			perror("Cannot open results file");
> +			ksft_perror("Cannot open results file");
>  
>  			return errno;
>  		}
>  		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t Mem_BW_resc: %lu \t Difference: %lu\n",
>  			    bm_pid, bw_imc, bw_resc, diff) <= 0) {
> +			ksft_perror("Could not log results");
>  			fclose(fp);
> -			perror("Could not log results.");
>  
>  			return errno;

From what I can tell fprintf() does not set errno on error. Perhaps this
should rather be ksft_print_msg()?


...

> @@ -738,15 +743,17 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
>  		sigact.sa_flags = SA_SIGINFO;
>  
>  		/* Register for "SIGUSR1" signal from parent */
> -		if (sigaction(SIGUSR1, &sigact, NULL))
> -			PARENT_EXIT("Can't register child for signal");
> +		if (sigaction(SIGUSR1, &sigact, NULL)) {
> +			ksft_perror("Can't register child for signal");
> +			PARENT_EXIT();
> +		}
>  
>  		/* Tell parent that child is ready */
>  		close(pipefd[0]);
>  		pipe_message = 1;
>  		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
>  		    sizeof(pipe_message)) {
> -			perror("# failed signaling parent process");
> +			ksft_perror("Failed signaling parent process");
>  			close(pipefd[1]);
>  			return -1;

another partial write possibility

>  		}
> @@ -755,7 +762,8 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
>  		/* Suspend child until delivery of "SIGUSR1" from parent */
>  		sigsuspend(&sigact.sa_mask);
>  
> -		PARENT_EXIT("Child is done");
> +		ksft_perror("Child is done");
> +		PARENT_EXIT();
>  	}
>  
>  	ksft_print_msg("Benchmark PID: %d\n", bm_pid);
> @@ -796,7 +804,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
>  	while (pipe_message != 1) {
>  		if (read(pipefd[0], &pipe_message, sizeof(pipe_message)) <
>  		    sizeof(pipe_message)) {
> -			perror("# failed reading message from child process");
> +			ksft_perror("Failed reading message from child process");
>  			close(pipefd[0]);
>  			goto out;

another partial read possibility

...

> @@ -348,12 +348,12 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
>  
>  	fp = fopen(tasks, "w");
>  	if (!fp) {
> -		perror("Failed to open tasks file");
> +		ksft_perror("Failed to open tasks file");
>  
>  		return -1;
>  	}
>  	if (fprintf(fp, "%d\n", pid) < 0) {
> -		perror("Failed to wr pid to tasks file");
> +		ksft_perror("Failed to wr pid to tasks file");
>  		fclose(fp);
>  

another fprintf() that I do not think sets errno on error.


Reinette

