Return-Path: <linux-kselftest+bounces-2742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EE3827ABA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 23:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B406A1C22921
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 22:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010AD1E48B;
	Mon,  8 Jan 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDs/GYFh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D742904;
	Mon,  8 Jan 2024 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704753737; x=1736289737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WCUbF8Xd4MvfuMvuxcgUpIYNm/iaRMouAQnyVs2ZqhY=;
  b=CDs/GYFhkPwCYqKLs6MFoZNZGus4k9bT/vp/5A7oUuS+eRQO4542RW3+
   UV8zbREVOhNZMZXlGZ+2ljAYRdZphEszmz7J8K5vN/V/cdJaGwzslLKQm
   E7YCHRnhiP6eDe/ZrMiRKCi0U8ewqa1XYbO0dl1org4/l4T7+a20edKJ4
   rPJApPb1K7p6LCjk900K1dWe9sBGLmxqIC/7Etpb0grSX7O/2PT5r/cBr
   TWpA3a/Q9POWduePSTDshseUhRP+7hQmSSDukmrqR3gh+0xO2CLOQOaRT
   NvW+8LR7ZhQY+qym9q5hjw8raTq+zVYd+a1LVQj2PdaJXulGjKs46LaNL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4781733"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="4781733"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 14:42:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="29944973"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 14:42:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 14:42:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 14:42:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 14:42:15 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 14:42:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7Po2e9pNDVsEH6REz2BOLr+cRqu6/fSKLwE2abUI0nYgOpX13elEjx2FhStEINuF1/xvFyk00vqjFpS7V4/bCo+ezYgX1TFpIaeY+LFKfr+oPuHF9FOsRDR8o8ardnw3ZEcqlEWDMVd55s2IC1qxByiBcQcJVAETKh+GqxBAlhkIyCX3w+MbPEyVBlh7zViA7TWW44NscaDxKO2YuC+6M7XYk/bl1bt4gJLBd9pT6bNEsSYoNmSSXbbqgA9zjh4IW+nMvNGanbirF+njNC5B4HAlP8fA33olu+9XiZkxgTZUgSOIdDjjyXdGkl5K9lBPGHFTvpQSJWGGBrxSa0UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GErAzceKFeLRs/VrecrT5LGtQjuo7NWQ7NbIQ8QRCpc=;
 b=ImQB2uYqt8Dwa+hCZsUCBhxtmnGFSu3KHqkdUOtglWXtVfQ3w0IwcMyTjBZO2U+M6sodnBHt8HU6V2BYuKJ1ZulWpmx8KRa+PXzW3c4X05cUgUv7q44cG57CnqtKCml2rvepHSQmg8v8eZ94v/woy6yAOiHA1KAtlNgf5gSpXPzbNzDBm0qyGb0xLTZXyaa0zsuKDr/zaGiB6pKByDefJ8zN3gv5UzR9zchVRzJv5WpQSUq4Ebc+T17zxavmEt1ynEWBGT1qTAtGmuOvohr6wNOd3qFwE8WcRdT61GxazT3jHEdF96ycn3lDfk0qPWNxfUzG53I3bln1Ufu8fs3Iuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4935.namprd11.prod.outlook.com (2603:10b6:510:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 22:42:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 22:42:13 +0000
Message-ID: <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
Date: Mon, 8 Jan 2024 14:42:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>
CC: <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4935:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0e7ca6-261b-411f-0863-08dc109b0e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J5BvMmeNx8/82Cjb+WjXUl3gy/tA+L6L0Bw7n332ZX4FKFQlDn+1/jFdRnD+7BTJJHCw8diuLTvMLcIz6/qsw69Jn7OJmzlLRNksGHsXCSICFb1LMB0784ttw/9QRGMN0PnWNA8ww/LOKzzPvkqlOEHHCr0Cj7bPueltOxr4I3+ZGA9EmiMe7GJOig731tRK9eTXxPPNadLYOlnPpn5Qyy1g6NJxC4FytYsdD1d2yALMVx9yiQqiFp1p2YGYanNEiVIjkraQ3ZtrKMLGNZlcpWntYtSOM0EIY3o+YizhSTKW7RUEJnMxJ6luduRWWRStA+IP7th0Rwi0EFin10xz+7Ir7UMAd9VEhZRvTSO6/V285HtN3dpat+p2D227dxmtiYTdrnUFhS8YuEj0yVN0FJoPXWdUWU93B82TNiBbWR9OvnhDC6wrV75IghQZzadWtByjyHfNa7UZHyW6Y7t74tlChpWxN3eadE+NaZRFgbsRVo4igaecvcJasWf58xtCUDl13yiaaURkltTt6aCl6YtzMONiCh4oCjPiBtlDuMHXSXwMtqtXVutKEOixhP1+JFPRaTfVd9buL/Isuo6PY4NR229D5vYio0Fq0Axtolgh+S+VPTZMwtcAk7Icb6x792ZDQdaI0NJwNhQHLEvBWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(41300700001)(82960400001)(31686004)(2906002)(5660300002)(110136005)(6486002)(36756003)(44832011)(53546011)(86362001)(6512007)(6506007)(316002)(8676002)(8936002)(4326008)(66946007)(66476007)(66556008)(31696002)(83380400001)(26005)(478600001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1lXbjhSZmpuOWYzZTYxbndwbXZzMm5Ha0o1NmZsNmtRbmZzM2pCMk9Rdm8r?=
 =?utf-8?B?N2pVZ09GcWhYQU1uaFoyNVJUdjllUThURjZ4RE5JeG5HcnNhQ2pyTnpQWnJE?=
 =?utf-8?B?N1FCcHlXZ0w4OXVFMmhoYjVwZVM1VGF1eExvUTM5TFY0ZDU5NXhyeFNvQ2Np?=
 =?utf-8?B?SjB6L3NrRFdoVndISFFPZUttTGk3N0JLTGpNOExRR21kWUo4ZU5saDdiVnRa?=
 =?utf-8?B?M3lnMkFXNlpvZFUyTlhoM0JCL0NXNEZQalAwM09TeStRUjBwSTJTVTVCc1Iy?=
 =?utf-8?B?NzFYZDdDcVNlTFRhbEs5cGgwZnZHamNnbEFXcVpUREgvZURLbkwwV1RreUdr?=
 =?utf-8?B?MXlubzM5ditJYmhkaWRWRzB2SW9EQUxVU2Y5cGcySWJoUEZMcFZSazNZcmFV?=
 =?utf-8?B?Smg5dVhEOU5FSEtmL1hIa3Q0dmhhV2tGT0liNHJnd3BlSkFlSTAzNXNpZWlX?=
 =?utf-8?B?OVQ1Z3dVaWtVS0RmUXAxMHZHL1RlY09CUURUZGlMeUtKblFCMTMzZS92Y0d6?=
 =?utf-8?B?bWNrNlFyNG9qYjJqcmlaSURwMThtdlk4dUpPVVJnY3hndTd5NmYzeTk0SEc2?=
 =?utf-8?B?YTVxVms2VEhVUmFvWEVUUTVBSG9NQ2RJQURzQndobkF0WFRTcThER2g2OFNl?=
 =?utf-8?B?M0xCeWlWUHMvVWErWUVDRUppa2JqSjhBOWV5ZzJBY0FGUWk2UGhCM1dwcm4z?=
 =?utf-8?B?bEtMb3VtUzdGQVNZWUpDdktJenNPSXc1d0dIQUo1QjJOMFl5LzlXR0FsdjZ6?=
 =?utf-8?B?UnpoUzFCQnR1c0JnUVBCdUhucnM0ODg2SENSdUpMa2xpdXZOSHNLNjRoeFp6?=
 =?utf-8?B?QUVKYkhzb2d4WTlzZ1ZxY1gyd29WOWZ4QlBGSGp3WXBCbGhQQnRoeGR2aGtk?=
 =?utf-8?B?dXQ1Q2pvRFlCRW54QlovTjc1UGtFVm1xZzRlaFJ0THF1bndEa2tBblVERHk2?=
 =?utf-8?B?VkZkMkdOODlsZ1Fkcnk4cm1XS0IzWThDM21tSWg5OFpsK0NCWXJYYXQ2M1Zo?=
 =?utf-8?B?WmZOZnEyTjB6andWZDdrWC9POThGOEhiOUJkdmxQbDlZTWRyM0UxTDQzZFR6?=
 =?utf-8?B?U1Y0c3BySnFXZHFDVHl5Q0lGWXd1eis3b2szT016dkNqQ1dvdWZWaytpQmF3?=
 =?utf-8?B?R2tNSE4rNS9kY1hXYjB1K3paZkV1NTVldXEzcVhCL3loZEhFdGk1YmpwZ0RO?=
 =?utf-8?B?ZEhnQzZyVlhzeFNxWFBadWs5Z2pGeDVNZjQ4MzFpL2xlaSs3b3hqbGxBeXZI?=
 =?utf-8?B?TVZqcmI3TCtxQ1g2UDJiRituQzZ0eXZ0U3dlaGMvRmVrVEZPV2pIamowNEp1?=
 =?utf-8?B?dkZYNnV2cmVjUDFQRVlKMWZZcVpzcDU5ZHQvazVRVzBhaXJGRytsOEE0NVlY?=
 =?utf-8?B?cjA0ZHkrbHd6MXp4bk94c2hxYmZKV08xcXlJY1BBRFV4TXFWVzdsWTg4cXRx?=
 =?utf-8?B?VVUwM0FDS0ZFMlNxSEZnb0NJRVhnZm1YOW5mT3FGamtXaTFpMDdlV2hoVlBW?=
 =?utf-8?B?TUtlU08xS3pmRU1UMkl4WGphdjIwZERTTFNUS0s3TkpSamhYSGc2cWFsUmFF?=
 =?utf-8?B?cks0TDF6bEk3RDFQem1McjhQWjRFNHA0bWNkdjJzYmhMdWQ2SGFNZ2VRVmMz?=
 =?utf-8?B?czVMS3dTbHpwenB6ZjNCSGxiZkVlSUJhTjJwNWpkUS9CaE0vcW9zUlhxblpE?=
 =?utf-8?B?K0xDc3JOMWZndGxJOU02NkF2RkE1WEJNUFRkLzl1RTFhTEdYWElCTVczL1do?=
 =?utf-8?B?UlBjeHprUUpaSzlBcnhXWFBVUHNZUGZseUY4cVpDWkN2WkVjbjVOUEJ6Y0Y5?=
 =?utf-8?B?WFV3M3p2Qy9qZGJJRlJQdllnbzMwSWFzalFUQTlmRmZIanMwQzFZUklpQmd2?=
 =?utf-8?B?aFZtMitCQkM2UU9KaUlLUGpTa1ZXUG9oQVcvY3BWcEFyV0l1MnBRNXJuaUhV?=
 =?utf-8?B?MVBRNGJIZmc2L0R3TzdXdGx1WDdhTkFBSkZwaFQzNzlBSXRyaFpwTzFLNlVN?=
 =?utf-8?B?azNncThja3JOdTg3SHJwWU0zUHplbk1nbjVNVU9naS9PZExjcFNwODZ6Kzlx?=
 =?utf-8?B?MGpNUWNqd1VKYUxJdE1WaDZMOXcvTFpEWDRHeGg4aXQ2NUU1LzQ1cHI4ZlFW?=
 =?utf-8?B?cEQ4cWlSUWU5MnlJZmJ5ZHYwVjg2byttbUZ6a2FUNDFNT3hVMzJUTzJ0WGMz?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0e7ca6-261b-411f-0863-08dc109b0e86
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 22:42:13.1339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BmeE2Yz1ds8MsBGw3TIz5UEbA5Py4Wmo2P083A2URRO6zaCcd8Qs1TmvrBITWTs+zVGbWd2UNPxVQD0kGaqMpioEFr3m+kHPph/M/ymJQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4935
X-OriginatorOrg: intel.com

Hi Maciej,

On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
> Add tests for both L2 and L3 CAT to verify the return values
> generated by writing non-contiguous CBMs don't contradict the
> reported non-contiguous support information.
> 
> Use a logical XOR to confirm return value of write_schemata() and
> non-contiguous CBMs support information match.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v2:
> - Redo the patch message. (Ilpo)
> - Tidy up __cpuid_count calls. (Ilpo)
> - Remove redundant AND in noncont_mask calculations (Ilpo)
> - Fix bit_center offset.
> - Add newline before function return. (Ilpo)
> - Group non-contiguous tests with CAT tests. (Ilpo)
> - Use a helper for reading sparse_masks file. (Ilpo)
> - Make get_cache_level() available in other source files. (Ilpo)
> 
>  tools/testing/selftests/resctrl/cat_test.c    | 75 +++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrl.h     |  3 +
>  .../testing/selftests/resctrl/resctrl_tests.c |  2 +
>  tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
>  4 files changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 7dc7206b3b99..ecf553a89aae 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -292,6 +292,65 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>  	return ret;
>  }
>  
> +static int noncont_cat_run_test(const struct resctrl_test *test,
> +				const struct user_params *uparams)
> +{
> +	unsigned long full_cache_mask, cont_mask, noncont_mask;
> +	unsigned int eax, ebx, ecx, edx, ret;
> +	int level, bit_center, sparse_masks;
> +	char schemata[64];
> +
> +	/* Check to compare sparse_masks content to cpuid output. */

"cpuid" -> "CPUID" (to note it is an instruction)

> +	sparse_masks = read_info_res_file(test->resource, "sparse_masks");
> +	if (sparse_masks < 0)
> +		return sparse_masks;
> +
> +	level = get_cache_level(test->resource);
> +	if (level < 0)
> +		return -EINVAL;
> +	__cpuid_count(0x10, 4 - level, eax, ebx, ecx, edx);

Please do not invent relationships. Please replace the "4 - level" with
specific index used that depends on particular cache. The cache level
may not even be needed, just use the resource to determine the correct
index.

> +
> +	if (sparse_masks != ((ecx >> 3) & 1))
> +		return -1;

Can a message be displayed to support the debugging this test failure?

> +
> +	/* Write checks initialization. */
> +	ret = get_full_cbm(test->resource, &full_cache_mask);
> +	if (ret < 0)
> +		return ret;

I assume this test failure relies on the error message from get_bit_mask()
that is called via get_full_cbm()?

> +	bit_center = count_bits(full_cache_mask) / 2;
> +	cont_mask = full_cache_mask >> bit_center;
> +
> +	/* Contiguous mask write check. */
> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
> +	if (ret)
> +		return ret;

How will user know what failed? I am seeing this single test exercise a few scenarios
and it is not obvious to me if the issue will be clear if this test,
noncont_cat_run_test(), fails.

> +
> +	/*
> +	 * Non-contiguous mask write check. CBM has a 0xf hole approximately in the middle.
> +	 * Output is compared with support information to catch any edge case errors.
> +	 */
> +	noncont_mask = ~(0xf << (bit_center - 2)) & full_cache_mask;
> +	snprintf(schemata, sizeof(schemata), "%lx", noncont_mask);
> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
> +	if (ret && sparse_masks)
> +		ksft_print_msg("Non-contiguous CBMs supported but write failed\n");
> +	else if (ret && !sparse_masks)
> +		ksft_print_msg("Non-contiguous CBMs not supported and write failed as expected\n");
> +	else if (!ret && !sparse_masks)
> +		ksft_print_msg("Non-contiguous CBMs not supported but write succeeded\n");

Can these messages be made more specific with a "write" changed to "write of
non-contiguous CBM"

> +
> +	return !ret == !sparse_masks;

Please return negative on error. Ilpo just did a big cleanup to address this.

> +}
> +
> +static bool noncont_cat_feature_check(const struct resctrl_test *test)
> +{
> +	if (!resctrl_resource_exists(test->resource))
> +		return false;
> +
> +	return resctrl_cache_feature_exists(test->resource, "sparse_masks");
> +}
> +
>  struct resctrl_test l3_cat_test = {
>  	.name = "L3_CAT",
>  	.group = "CAT",
> @@ -299,3 +358,19 @@ struct resctrl_test l3_cat_test = {
>  	.feature_check = test_resource_feature_check,
>  	.run_test = cat_run_test,
>  };
> +
> +struct resctrl_test l3_noncont_cat_test = {
> +	.name = "L3_NONCONT_CAT",
> +	.group = "CAT",
> +	.resource = "L3",
> +	.feature_check = noncont_cat_feature_check,
> +	.run_test = noncont_cat_run_test,
> +};
> +
> +struct resctrl_test l2_noncont_cat_test = {
> +	.name = "L2_NONCONT_CAT",
> +	.group = "CAT",
> +	.resource = "L2",
> +	.feature_check = noncont_cat_feature_check,
> +	.run_test = noncont_cat_run_test,
> +};
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 74041a35d4ba..7b7a48d1fddd 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -165,6 +165,7 @@ unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
>  int get_full_cbm(const char *cache_type, unsigned long *mask);
>  int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
> +int get_cache_level(const char *cache_type);
>  int read_info_res_file(const char *resource, const char *filename);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>  int signal_handler_register(void);
> @@ -201,5 +202,7 @@ extern struct resctrl_test mbm_test;
>  extern struct resctrl_test mba_test;
>  extern struct resctrl_test cmt_test;
>  extern struct resctrl_test l3_cat_test;
> +extern struct resctrl_test l3_noncont_cat_test;
> +extern struct resctrl_test l2_noncont_cat_test;
>  
>  #endif /* RESCTRL_H */
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 3044179ee6e9..f3dc1b9696e7 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -19,6 +19,8 @@ static struct resctrl_test *resctrl_tests[] = {
>  	&mba_test,
>  	&cmt_test,
>  	&l3_cat_test,
> +	&l3_noncont_cat_test,
> +	&l2_noncont_cat_test,
>  };
>  
>  static int detect_vendor(void)
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 8546421f0940..8bd30973fec3 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -100,7 +100,7 @@ int umount_resctrlfs(void)
>   *
>   * Return: cache level as integer or -1 if @cache_type is invalid.
>   */
> -static int get_cache_level(const char *cache_type)
> +int get_cache_level(const char *cache_type)
>  {
>  	if (!strcmp(cache_type, "L3"))
>  		return 3;


Reinette

