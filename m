Return-Path: <linux-kselftest+bounces-1867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11234812100
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBDE282733
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 21:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9967FBB6;
	Wed, 13 Dec 2023 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7l7EQ4W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC4E100;
	Wed, 13 Dec 2023 13:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504534; x=1734040534;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4hW56SPNqC666DN/yq9bCW1lfLJES0VDLwur4NnPK80=;
  b=R7l7EQ4WYIQm3z8NWR26TLlubb7MIbQuImogdoqN2N1AGO1cZUvAme7H
   /QopYrHEfSrTHvn9xlwUWKbhIe1aAAwsHW6H7cVQ9UJQ3tyilk/zGFLrH
   tuwvc1mCKAlf9m5lBK6thR2pl3jue2ILQg8BPKP7fjJUJsAoNFJ3ncDkb
   5qORdztVBdC4P26pxM1Wz02FCt8JMumh3sn0BUAKXDoNAk/cslD1BlPJX
   KO4WPvaC8AuadqyxJ2PlQ1+ne1TB4HtWI7KEhsnWJyfbKJCRfGgNGpV/p
   GFqmBDL2qXwhY0DNRnCD3wGZFdCzNprxIRFBQBs6qVNfvZgEaEdzbpuiF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375186049"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="375186049"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:55:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="840046566"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="840046566"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 13:55:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:55:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:55:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 13:55:33 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 13:55:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBaHNmkc5BxS8oCN5p5fxp6z8i7//ZG7i4TcMRqr6DHRT3u1IWficK++s032wuE9pIOiPUM3w9rP2WGl+Wfkw6GzSpa8Jb1h+YsxdqSm9aLy/kThjbIFpxs2BiQFtn6bdpo7geOZSnJ4XL+ry6oI6W+HnxZX7Qhsm1EESOagN0smnA7INZWwWMUWXuhNeY+TYgn0k/4BEVffqk8plAxHTKH8LY9Nv5WJpm0J6BcLB3KkezYTsi5jy39ZqB1vBKX2EiZM1Uz15cJ9FdMSd+gBZBc9AncjewJrXZEFY3HUEijra6WSA12sXUnvcmTriy06BCss6QirxGDUzb6AUJ3Yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rvxkdg+9Oj1El4AG/6JNjuaetkwGSec/g3UiFm36vP8=;
 b=PwEvlS87UiXW7w4R3GFNha3OeBj4PmwrtJ4G85B8gv19m9/lw1SXzwDQN1tkG1hhN06Qy/tJbAIiTBUbgw/DJ6x3d3SGe08/kgMGTkNUKFsHq0oOfflTZA+2JbiQvyE0j00Sj73dHa3lSZoInZJHXRhnKCwBYq/wDW5hSDTnYv5zCDNvTDKcAJriRX8BtYcRhbqRItj47H3uPYIhEbHZp64vKdnM6mPMIr/YHyjtLnyAJXQBqZbzimNK2BejJ6IQxnqdtgoJVwboldW7yh8d5ZNR49igQFV3rqCWxCgODti+VAmoLTptA2VbiViuoAU+TF33XPmafCGVNn3ZJA3ffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 21:55:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 21:55:27 +0000
Message-ID: <150fbd26-cb36-48f8-bd23-fc2eb83f03f2@intel.com>
Date: Wed, 13 Dec 2023 13:55:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/29] selftests/resctrl: Refactor get_cbm_mask() and
 rename to get_full_cbm()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-8-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-8-ilpo.jarvinen@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 99aac726-773a-4fe9-ea45-08dbfc26375f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hhgVQb5bjllVr5IX+QZJo1r9KR29aYLEIXISYsoVJK8vTwf3TRjqZF//piDbb4/lcw38kXVmX6ApPqwZpajMpow7edH6zCOCmeOxiia7OmRW4GXn7DwKhMSW5sc5SSskVq9GhE31TzTGM6D3AH6VZ5jmUv7I2BACIye4V9mdA81hxZtPATvjwFVDP5owjAdQ0DwQfRimRcHGDkXDsy3ASDKItYNNOG+Vjsrcu6VMiSf8IlfmwKn8dg2F87LNDEQ/+/hA40w/juG6cp1pjE/v96NRYgzUw1UcHQ6nI3I8JwxWjjK1SHbT4cF4zl6Lo2lUEjkRI3SOXai2wGhh+gW2gxGhn+LzBVuyybn9KUdjQFGB48MABAot3PO11EAAV7cjqXqR0BMCvdNbF1GQKzLQYnWEdeJLa0XxzjDzHXpGqMlW5bwvogi0Gw2pVKrUmX+X9rX185lhHa3HbF6CIjVlaV4mmbdqaHzcvy2qQz0TehEbhFLzAVJvZUdyrMVBcpahKRRVgOnwAImLKS5NAkw5zHJfdVkxXM+dcdIwSJ/nRMKvNF4xX+ZGwnJLhuPAD9kFL22wbSZHl+8kEM9+69B5obuGLH/c8yXLpc0sDfhuXxbHO3e5V02trjiZJw8RcXVjNp1vqh8/Nb2DtTmIDqTjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(6506007)(53546011)(66556008)(4326008)(8936002)(8676002)(316002)(86362001)(31696002)(5660300002)(6512007)(478600001)(6636002)(66946007)(66476007)(6486002)(110136005)(44832011)(38100700002)(83380400001)(31686004)(82960400001)(2906002)(36756003)(41300700001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXhrQVdFcDFaSmRGeWJNNFR5M1pKOUVrdlp4M0RjYWhwRlQ2eHZ6M3AzUTRo?=
 =?utf-8?B?VzUwd1prNkhIYWdTa0MzN0RCSUpVRXJCeVA2d2FueTlKQ0QvU0dPQkVaT09Q?=
 =?utf-8?B?cit0dHlJcXd2bFRLb1BQQ3phNmdER004bFJ3b21Pc2NTcEtBdDZ4c0tmbzNv?=
 =?utf-8?B?U3NRTEVuci9UNHRTaHphVmk5TGVSaFlVT0krMDcxNG0wRmR6Q3B3NlFnRDU3?=
 =?utf-8?B?TW0zdmZJS1h0enhiOWhubFR5MXEyelRxNWRLUS9zRktiU0xRVHlLUlZwQVRs?=
 =?utf-8?B?a2hXemNNUjAwMlBJbnUvTHhzYzZHdU5EVXdFUlJoTElpSWh2RzQyS2ZmL2xK?=
 =?utf-8?B?ckR2S2pqNDhZcFZpTnYvSTJ5enBWZlE0TzQwUnprZHpXVnhaSDhkNkVKTVJG?=
 =?utf-8?B?cHN4WEZEcTZTNnNHbXphODhCdGMrVGlic2tQSEJJZ0x0SjBXZ3BkQThLWHo3?=
 =?utf-8?B?TGU1Z052SHJDZHQvNFFUdlR2anJURktzb2hnNEVYWDFUd3B6VFNPTHNNS0J5?=
 =?utf-8?B?U2NITyt6YTN1dzNIa0dzaXdJVUJOMmRZTjcyc0VTenlwMG56anFxb2Y0QTJj?=
 =?utf-8?B?LzhOVFdURG15ZWJOTndaUmxReHlucHJqTExza1BLVHBxSXJIZzhuby9HdGtk?=
 =?utf-8?B?SURWcmVKelk3cXdVVWVsTE9hTWNTcjN4TGh4YUtXMUh2eU9hdUZsWXpEcmph?=
 =?utf-8?B?T28rb2hlbzFDdGNYRStsbGppRzFFbnplQ2NuUVJJdGVnSldMcS9HMURaUExO?=
 =?utf-8?B?RDdrcXlqaEY1NDRYZER0SWVBRE9kdzEvTldTL3hFTkxpYk1KTzBEVDBkNnJy?=
 =?utf-8?B?b1VQRFM2M3I1dFg1b1hvMi9RQUFaS21kaXM3K1JnZW1FSmo4MUhLTFNyL1Av?=
 =?utf-8?B?MS9mb3hUS2FCYXYxVkc3WG8zRkxUKzQyS3JoV1lDcnhmRmtpSTVUNytSY0hT?=
 =?utf-8?B?NkhnK2NBdGhKbWpIWCtmQ3MyajYwZ0VId084U3kzejVCZlNFTGk2dk1oOXhM?=
 =?utf-8?B?VDQvSkNPaWFZVi9kUElkNVJ3bSsxN2lKZFF2VW5BTXZGMjUwNUhzQUpIRVBh?=
 =?utf-8?B?VFArUVdJTmw2djE1SHdmRkszdXJzWmRVQUtXOWkxR2hMNERZLzdkOWM4RHdp?=
 =?utf-8?B?ZE12eVpVY0lZQURnU2FydHd4dEVQOW1SQzFaVkh5K0gzWENJaVNtQnhteGNP?=
 =?utf-8?B?YWtkcit0NGNDYlRYOFF5TDJYVDNIb2MvZmhJS1Rpdml2ZHZmY1o4bDVJa290?=
 =?utf-8?B?V1ZUeGR5QVkySEhIUXdIZVUzWDZVTld2ejlnNlZwdXVTQm5ZalNkU01HenFp?=
 =?utf-8?B?bXFjSVcxWERXazdrNGFaUWx2TXBDNk9PLzN5STg3MVdOdXA5N2xGdXdEVWdZ?=
 =?utf-8?B?YjU4K2VuUVlDQjZTSE5jZWNyYzRabGU2eEp3ZlpYWlhiY0s2bmlUa3l1cHhy?=
 =?utf-8?B?U3BnZ1J6RWhrc0RsekRab0pXS010dHN3dHhzOE1pS2ozSUlVSFBqY3VFeXJn?=
 =?utf-8?B?WUxJY253c2tkSU9lUlB1T0d4OUpnU3gwcStheEo5bEhPMXhWWFIwVTEvQTdT?=
 =?utf-8?B?aDRVbzBDUHJQT2JyTThzZGxrekJGMFlkWE14aFhscDhoVU9jSGVlMFlkTEFC?=
 =?utf-8?B?UWRZOElrclNvcEM5aHh0d1RjQTJLQWZuZmp3Zmk5YTQ0di9XRVExRXZVZ3Jj?=
 =?utf-8?B?UjMwbFgxbDRUSk05VjMrOWZXdXh1ZUZkZDB2V3BaZGhja2lOaVlsWFhma09G?=
 =?utf-8?B?OGFFRUNCSWcybVJ3SGc3VVFOb1ZGTzdvMHRvK0ZWSGU1K093eUtUYVpXNy8w?=
 =?utf-8?B?ZVpaWkFJS1cwUHhJb1E3Tm9tVjQwc0hqbHpIQ3d1NUVtOFdFR3B3MURjWTR3?=
 =?utf-8?B?SjhnZ2VzVmVlY0tNQXRMMSs4cVQycXJrUGlUcmNSN3lwbmdJMWlHR2xiSzkx?=
 =?utf-8?B?OVJ5cUZ0UTVJZkxkVjl2ODQ5Tm9yYUREaUZsdDQxQ04zUk9vdnZSamVkTmtN?=
 =?utf-8?B?Q0tscjBvbWJ3ckJYNHZGYkorY2lxMTloaDAxeDR0RG1RbUdyR3NZU0xFRU1M?=
 =?utf-8?B?bHlIb0p2M1VOdUlFdjdyVE1ybXYrSDV3K25pTGJaanJrNTAvZ3pKd1hOUkpN?=
 =?utf-8?B?MkNvMHZmMmdHaERaSTJIblJUaUNTWkV6VjI3RW5NWTYzdFdmbllzNm5VdEdP?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99aac726-773a-4fe9-ea45-08dbfc26375f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:55:27.2590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqSVqx6LJnacfF+YmLFoJ0vPIZ8iI8PHSC1W+zJ76XuOO2PWD5sUKlEKQYr8ThhUyt62Q0btd5t0Zajbx7o1htbs95svXOjkuP1SPUwjdpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:

> -int get_cbm_mask(char *cache_type, char *cbm_mask)
> +static int get_bit_mask(const char *filename, unsigned long *mask)
>  {
> -	char cbm_mask_path[1024];
>  	FILE *fp;
>  
> -	if (!cbm_mask)
> +	if (!filename || !mask)
>  		return -1;
>  
> -	sprintf(cbm_mask_path, "%s/%s/cbm_mask", INFO_PATH, cache_type);
> -
> -	fp = fopen(cbm_mask_path, "r");
> +	fp = fopen(filename, "r");
>  	if (!fp) {
> -		ksft_perror("Failed to open cache level");
> -
> +		fprintf(stderr, "Failed to open bit mask file '%s': %s\n",
> +			filename, strerror(errno));
>  		return -1;
>  	}
> -	if (fscanf(fp, "%s", cbm_mask) <= 0) {
> -		ksft_perror("Could not get max cbm_mask");
> +
> +	if (fscanf(fp, "%lx", mask) <= 0) {
> +		fprintf(stderr, "Could not read bit mask file '%s': %s\n",
> +			filename, strerror(errno));
>  		fclose(fp);
>  
>  		return -1;

After seeing the new effort to correct the perror() messages it is
not obvious to me why this patch changes these particular messages to
use fprintf(stderr, ...).

Reinette


