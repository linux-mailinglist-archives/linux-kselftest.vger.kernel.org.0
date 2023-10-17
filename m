Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A7C7CC894
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 18:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJQQSE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjJQQSD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 12:18:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8F9E;
        Tue, 17 Oct 2023 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697559481; x=1729095481;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=8mLa1Xb9PgTW3pIGgTk2rPZm+pnTWK1HsOQ5zHgUQGU=;
  b=VV2NE+zu75ok1Yv+xNGROQeSCSsjjhHI3ZfaIqXwMS1YYUCwcKTMcAXM
   cWoEFwg9voYAdBG6aPiRiYLkAimD2Xy4PWhLPUV6ilZQ2q1BIIc/ytpVq
   9nP+QWxt8RfKT5Jx8YRQCKFjfjqqt7pK8RZcHedRy6z/oWwwZqUULmrEX
   p7lWCLc/c1Z6wjEuxkpGrFqJCvJVvgKmr7QIxeZZXHX9ksus5LfWJ7/d7
   yp7H6fSjGfi5XFpI5eeoWBTKrXMcMQBxy2kWoUixNfE8uvMOOB8+f6Mdm
   kifnnOTPUdSDzmTDQjk882CqtLLfdCWGTVhwklfZ6aGPRgFWZO6/DMpuw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="366080796"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="366080796"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:18:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822043986"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="822043986"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 09:18:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 09:18:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 09:17:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 09:17:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 09:17:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L84ucAQllJB8OInPGwUKJa9SgkJZn5h1ZjWOvNZe1AuLnb1zNM70S0CVuK3PJ6jCNsrHQ9OHHaif6pgBYOAdpNDO+tHyb2oTdTHWaQJNkqysyMO1nL9ZOHSt7xjvVRQ/O1hW5sP3Pg8H3oL/s+zb8fSm8pAUNMhWoU49HlIVfcpdw6vWVBGC5Xk3kGvccyB0QL+m7RAwSw7SxupNfQxg5n1UDwVEy06POp2bcW1xDuNfXqb7V/YXPP3k27aMPAh27bVWmw4QOaYua2FlyIEk3IZ6FP2j4JwikaspNWVFxSq3oitJ7cy/9UjhND70kAmziM6YIltxBcl64V1iVPK6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg0C05cC5QyYcJLZdfUxV4mN4aUSvFYZYGRZv24H4D0=;
 b=GxuKZ+kKxoGY3NXue0dsnh80WscXIWGjlwpIUizzlaeIzANgv8lVWKexRyHrnaWs4fvvz9ZiDu9m6eIpyX59lku5ngpkr3C1jfZfesKKlditWWi6ItoQuV1NGITpf6ew+kcXgwIUOKf8eVi+0Ik+gf6a//6f3eVuccplRMtEjD3lbnpDiI6qg5I0Ige0LOi4y3Q+5iOxKwrv5RCc3gpAdK//Om4XuHdUXBe1qHUYjFTTkJrB4MlV6AF7zXYmkSEZpfEGc5E6QSPeReAJU8L/sJG+fRm1C2a+42nq4O0Giy7p6OBVAbqAfw1w78DZjcW6Tj7NKufrImu+JaYkCGjg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7469.namprd11.prod.outlook.com (2603:10b6:510:286::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Tue, 17 Oct
 2023 16:17:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 16:17:57 +0000
Message-ID: <fc9266f3-ea4b-4df5-82ab-697ca6742176@intel.com>
Date:   Tue, 17 Oct 2023 09:17:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] selftests/resctrl: Don't fail MBM test when schemata
 doesn't support MB:x=x line
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20231017121750.15433-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231017121750.15433-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c98ed7-9e03-45bc-22be-08dbcf2ca04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etc5aH9AaKsD+ADBaoXSXgaQtJXzlBa472QahPD9OirF1md0LQYrO8sfQqqJuzbIR1tl+iF8ZNOajCHjD1UksEVoBvpjWIbAidWYZebmv+5NLmU2Kuug+r1bvN6+sdtq5UxWRJQSX+tjju1Mlm6V29BivOlF90WfwpCoYlR0P17657nlkSLBMd/ztWATWw4P6f/en7qVyiIcVaZBFwg4Yz2b3P2EgxeVqt4zjbmQ223MQ8sZypnka2r8K0cxf3yvBxkdBTP3qLDTT6/32/Vynkxeph9Mj/QrlQL3nl3bdTY+03ypEbr1rSm8oPuVowtGIrY95XsXMzvgPgh67GAhNUXxcr7rUOqkDAy+NVakuSjnrHEXjsK/mmus/7C/bckdxJxPdp6Jl6Oy6jMLH8PYCunwXrAFJn/jDcXU0mAPKgLLuNCXQ0cc+xy+AP44XrwFtaL8fdK4cW1QhzO2Qu5uTmRHgXsf4gFewJYiS+qpgPpmd3TPJcaFTdfFOyXBeeUPMPN2assNWmD5oftBsR3qXNe242Y+2xw1iP4kILGG91f2A6nDPF5qGRq0gaU0oqZLzWII87XDq2NpwC2EV+NT8HbZJztqKRWZwwusvtc3IaMIxz/9EUbvtUVhwtQ49VowhPSGfmu48wxULDGb4esN9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(2616005)(478600001)(6486002)(6506007)(31696002)(86362001)(53546011)(83380400001)(36756003)(41300700001)(8936002)(8676002)(66946007)(66476007)(31686004)(110136005)(316002)(66556008)(66574015)(6512007)(2906002)(44832011)(38100700002)(5660300002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVduQWtKMXExR1ptRlMyK0VLa1ZYV1l4c3Vyc3FEcjVqSXgrbTRnaVlkUTMr?=
 =?utf-8?B?Q2NGSlFQajlESURSbENpcS92ZGVGRnJjWGZ6bk9NYWFVNTI0TzZUZG5zTzJI?=
 =?utf-8?B?Z09GU3dmcG44RytkMDNjLzhuWm01SFJlZVk1NncxZFNPQXNhU2VOc04vcEMz?=
 =?utf-8?B?c01IYy9qU0g3RjB0emQ2eksyTkhBekxGazJKMnRaSDdWQnR5OXdzU1BZc0I5?=
 =?utf-8?B?ZWk3SHVFaG9wU0JBYW5SdVZhYjM0VE4ycU1ZNGxPMWtCeU9uTWRSMGZISlVX?=
 =?utf-8?B?bjJKa291VmxqWlVpRWFJbE4zR0d5U3ZiRDh3eE1UQ3NxRnBudGhRMUlTTVZP?=
 =?utf-8?B?T0FKaW9la2Q0bDZyNWJqdFdzdHZoUzIyaTZQd3p0cCs5OW8zQ2RVK3oxYW9Z?=
 =?utf-8?B?MlZpck9rc1hORUNFc2FOQzdQS0FDSDFEcitGQjlOK1cvWGZIUnMvQzFRWFRK?=
 =?utf-8?B?K3J2cFZ1OGVTRUZJcmplbFFCV1huc05EWDBhUVBEYlExVmtsS01WRnl4YWxL?=
 =?utf-8?B?VXNQR2VXYmFwVUFjN0MxZXJORDJVblV6ZCtaMjZPQzZIQ1FsUlB5Q29OOU82?=
 =?utf-8?B?NkYxcytOOXkyRS8xOFJFRUVkcHpJNlRGQkpiZFBOK0tzaWw2eFpHVnM3NXQ1?=
 =?utf-8?B?OE5NZXJ2Y2lJRFZtNjZLQ1dpOE13d0ZTQWNFYi9KMS9jVzBXZVBKbXRVN2Nl?=
 =?utf-8?B?dmJidnU2dzZ2MHp3cEdTQkI1TjgyMmh5WTdMTXQvbkZSZnU3bGxtVDhkZU9Y?=
 =?utf-8?B?dE5Da3A0UlBTa2dwRG41TUZHMzZ6ajBLL3NZcVV4ZHBPb3lUc0xyclVvd1JB?=
 =?utf-8?B?SFZkVGtnSHZFZWRWRHpIeGRGV0c4RDVka2VhSEZGbWtyZjA1M01aQ1h1NDNE?=
 =?utf-8?B?R2xieCt3MEVWY0xGczhBVlNNRXNCYmV0czhmZ3B1TUdNTk5DYi9TTlduR2c1?=
 =?utf-8?B?UnV5THJsQ1lmWXBRbVlRWWNCVWRoQXJhclJNc3owSExLWXp6SkxhZk83VDlZ?=
 =?utf-8?B?akhSaDA0cGhxOXBISTlIa0FBa0ZFNXVEUmFGZTRQdG9BS21CVHAzdVQ5WEJ5?=
 =?utf-8?B?VnV3dVVueXhOSlQ3SU1UOTBQK0FTaU4vRk9RVm5CbVpBMDRTalpXQ29TeExa?=
 =?utf-8?B?a0JVTnIwMktzQ2w2cVJ5VmpHODF0RlBsODFZOGMxcEtyckZmNFUwOTAxNmtL?=
 =?utf-8?B?NGZvL0hyMHJXVmJ1RjlqRGlNSXduaGhuZzQ1N3VOZ3hZdVV3SnVuT1M1c05i?=
 =?utf-8?B?WjlwZ1pQbFVhd21Uek9tS2VqVWtKM1hOUUpRRzFGbDZEelNSdCtDLzA5MW9w?=
 =?utf-8?B?Z0doZ0VhU2FOYmh0bGt1bkRFNFZnTi90cTJlZCtMRjdkYWdrbDhTSXB2ZHNM?=
 =?utf-8?B?K1RDZW1OS3RlRWpDTWJtcGRvVndSbEJFRmJUcmpqNTFib2x5bzRqVER6ZEpn?=
 =?utf-8?B?STVIelRNbTdMSXpJaUNxSjFwcWF0M3pFLy9oZlFhWnI3YmRvVDNIVEpGaHNW?=
 =?utf-8?B?cWYwTUJjeHNaTTJsOVV5Y0M4eVBQZXhKanBKMlVZOHpUSFFheC9LWDNKbjVy?=
 =?utf-8?B?WmxCdU55SlMyS3RkVHBPOFkxZTM5c0gvcDRJU1VNMzI4YitBMS9RU2FpRldJ?=
 =?utf-8?B?Q2NMUnRFSmFFN3pVdmNnUVgwTHFTZVdKRzNNTTR1dWkzSFhsT3V4L3pqeTgy?=
 =?utf-8?B?eEFQaHFubUNpUEVOWTJldlVOMy92dDh0ZmVaWTFDZVhDSjJ6dWZYOTZpUmxF?=
 =?utf-8?B?Y21BRmZLUnFkK2pkdTJvNzlzVmxwYjdteGJvN242ZmlsZE04YkQxWGh2ci9N?=
 =?utf-8?B?TmJyRHIrMFVLTUVKRlJCTFU2dldpSW5ORkRaK21wWjRkRVIxeE1SN2JqY0JV?=
 =?utf-8?B?cTFwT2tkZ2VVeGJxMzRIUm1qRWs0T3VtSmJ1MFhvS3krVi96ckluK2JYWW1W?=
 =?utf-8?B?SzRYemJFWnBWaGEzRFluOHhDZzhpTzZDNFViVEdIbUN2eXBhd2pUR0RPYzZF?=
 =?utf-8?B?dGZ3Z0xZeU1wRHZkemJLdFVhRmJoWDZGVCtQMTR5dEhHeGtZK2gyaXhzVk5v?=
 =?utf-8?B?a3JhcUZtTDVZWUZ0ZHhZaEJKQld4cWxnSVJRVHRBcG1kWkZnSmlSNDdLVTJp?=
 =?utf-8?B?eVgzUEhmZDFJSjNhbVQ4ek1oaDZVa0NiSHU2Zzd6dDRuaWpuQkJEMkxOYm83?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c98ed7-9e03-45bc-22be-08dbcf2ca04c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:17:57.9192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DS3yKfYQ7XbP2SfqrTSkp1gB+7K3Po36wKH0w56VHhwKU6WwBdblZyZrcxpey1D+ZeXxf/xSNysQu0RCuDXdZJ4pK2gGk+nCgW60DbzuZx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7469
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

The subject could be shortened to:
selftests/resctrl: Fix MBM test failure when MBA unavailable

On 10/17/2023 5:17 AM, Ilpo Järvinen wrote:
> Commit 20d96b25cc4c ("selftests/resctrl: Fix schemata write error
> check") exposed a problem in feature detection logic in MBM selftest.
> If schemata does not support MB:x=x entries, the schemata write to
> initialize 100% memory bandwidth allocation in mbm_setup() will now
> fail with -EINVAL due to the error handling corrected by 20d96b25cc4c.
> Commit 20d96b25cc4c just uncovers the failed write, it is not wrong
> itself.
> 
> If MB:x=x is not supported by schemata, it is safe to assume 100%
> memory bandwidth is always set. Therefore, the previously ignored error
> does not make the MBM test itself wrong.
> 
> Restore the previous behavior of MBM test by checking MB support before
> attempting to write it into schemata which results in behavior
> equivalent to ignoring the write error.
> 
> Fixes: 20d96b25cc4c ("selftests/resctrl: Fix schemata write error check")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/mbm_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index d3c0d30c676a..85987957e7f5 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -95,7 +95,7 @@ static int mbm_setup(struct resctrl_val_param *p)
>  		return END_OF_TESTS;
>  
>  	/* Set up shemata with 100% allocation on the first run. */
> -	if (p->num_of_runs == 0)
> +	if ((p->num_of_runs == 0) && validate_resctrl_feature_request("MB", NULL))
>  		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
>  				     p->resctrl_val);
>  

Thank you for catching this.

Could you please ensure that this patch passes a "checkpatch.pl --strict" check?
With that addressed:
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com> 

Reinette
