Return-Path: <linux-kselftest+bounces-776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852FD7FC957
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81FF1C20B2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D36481D8;
	Tue, 28 Nov 2023 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDEN4THK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5448585;
	Tue, 28 Nov 2023 14:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701210004; x=1732746004;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vwdvbouqOcTgJhJV/CjMuuNp+XwMdlsXPGgLISZxVe8=;
  b=bDEN4THKIo0oNOwjBuCZovAug5hmuc9615eGGqR71V+OWHL6e1isNb8n
   it7jHw5J/at2QTxyOUBuTyxoN3EAczWMfw6Uck0JWMWtqRTl0m0u38KV8
   WXPGxLpTFQqoq/9JB10+cA7xYsg202rCmnuZgLd+1kFpqysXHoogwAD+U
   g2q1q6A0AGdqnRvVWsHK521gtpvkw8TlT0PhTLPDlWkql/IXeBbHK0zVb
   9lViWhYGtIBLcZrp9LQx+dL0CuFADrDCTqOuL80mKCTqwbOxcheYXMBv9
   nkVHkBkyFSHbabHfwUasFZ9uNYTywl9//fwfw3ugdH2fE8aWEIP/TUV9Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392792409"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="392792409"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="762079981"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="762079981"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:20:03 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:20:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:18:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:18:38 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:18:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2HiUVyQvfafesCweCBrwZjaqre1Rl+SKxLqH2p1KYq7f6pq8oPOGe+dkxtU5r6BqRPca86U0QYkWsXeHyqSIRiPRxe7gD6Cie6PIFMx23C3G3kZn4k7DeTmfO7HCqPjFhUh4ORGCmnD389lB6fZTVcTg8zJzDjX2FVamC/89W/AXBllxoeChqRQVS3ympA5fhQUbwznqf4wRLiZER9YX4fNAqWFX/wpjqnsFyzshr48tlBh/CzpnjEX2znzmcuFlRe+6DrX3TI8PVM5ao/nghmfAifUoz+VThG32Ll6xV9YnoNw5RgrbvNBt0EfQQE+eNWxfdrtRS+CEUppSvEHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAn599vZ6AkEScXZ5yERlJvi1m24Zq026qHStGuA1JI=;
 b=Ae7zQqow9F+/0mmTzl3DTyUPUBzlgAM2BnXWJqgTJDoAMnHxlGPTgd92rT+AEuYBXGMtmeYjqr1P5xEMAdjYIwwrZwr9slSTavtpvAE7F5pqd1Bt9iJKlYZi+NHpnPAuiVoeDLkC4B58c0SsEWR7kC0DG6EqRbp35GS4fW6tIie37cgqzvjFs3h68IlOWIUpnPxV74czMGlyW/h4dz4JvkoxD6wqm6Ci5Wbjad2A8LB+ay2M0p8Nik2kq7A6quomoee85HCLvjVKeLQ9ku1+9n0ZTbcmtKongHoHl/fI+j+niGcoWEDQ9AKPWx/fq9RkOK1D07iY9HiVBeEZ4b/tew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8024.namprd11.prod.outlook.com (2603:10b6:806:300::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:18:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:18:29 +0000
Message-ID: <82eb1ef0-3818-425f-8a0c-90f58bb49913@intel.com>
Date: Tue, 28 Nov 2023 14:18:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/26] selftests/resctrl: Create struct for input
 parameters
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-21-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-21-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:303:86::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: fd67835e-532a-4e1d-d644-08dbf05ff32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmHWIHml2How80PvW+DL8wv8Ni7T/TV9MpW0/LFwbSEKnNySvD/J1vfpQqFixvC9Kvu9s4c4WOPElZhDtRWNvLLW3aiHxfEzB2/k/8PfZh8SwEMUhtLgzB+kFQQPcwPavvduMEE3UX4UB2+4xnN/ILyfBAp0C01y1oHIlMXovvg6pl9TetfuMLaV3NK4Ie80pVm3y0iJ5fi/NF52s5/zPyopzd2pFEp+laXula3FZNLtiHOm2gj0nEXWA4gNIFrQDGlbB5/X2NvzaNeuc8sv+2Fmyz17ACv10nIEH6mJ1PkATMcmUr8Ac/nUlZGa67svfzHQKFmhfPaZkPnxNwFgVx9jsMSw78jP6il5Eq9O22A43vpGbCdWfLtS/52l+TD83YVw6lReL1rL510+Ev8GjOjTK3GLppNrkSlBh63lxdLrvqBmQE7UlvN/SEBBJjnk3Y88KjfkEYfEgPPVN6D8VihvcmnJro90lVJ4QS9nbc1kEobhve6fBi5Nl5KVDzTtekOuzajl6DbipBBUcZ/WLBtHtIUieyZBj+ZGbcoCnWopIa3VU63wpuz4U7OXB/vNxHqeDWxF0mLuFbYTOTkKk0zQhAQ0sWor2SauMJtV70boyBaKfgdZI9CL4ej41wR9bGdHbuuNJedLDuNW84OwUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(41300700001)(36756003)(31686004)(4744005)(5660300002)(82960400001)(26005)(86362001)(2616005)(2906002)(44832011)(6512007)(6506007)(53546011)(8936002)(4326008)(31696002)(8676002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(110136005)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0tEOWtwTk14dCt3Mis5dWFuOVZ4Y1B4R1Q1anFENnlFamx4S2x0ekpVRVhN?=
 =?utf-8?B?d3dXK0s4ZDVoM0xoUklnTDREWDFFdGlHaU1yVEU0c2wxUnRYbVh0SEFPK3Zl?=
 =?utf-8?B?QmtDcVJTMFJ0b1luN0pCQUUwb1ZFRWdPODFNUDVoZ256VGhMYTc0WEZ1bVdt?=
 =?utf-8?B?TUUwQk5DaE50MFljSUxUWTU2TjNWcnhiWWM4NHpubCtjRkJBMTZ6c3RVcjZI?=
 =?utf-8?B?ZS90d1ZUSm5VYVowdWVXUHdNbmc5OGxKYXh4UktjWWhWVWNoNThPc2t1aExR?=
 =?utf-8?B?RlNUMm5KSVNHMWw0UGF2akNxTDBmK2RzOUIxK3JpbUZTWGtDWldob3JlMmlC?=
 =?utf-8?B?MUpSYmhRemdwNzQxaVpPc0V4bmJSa0NZdlhkeFprL3RDdnovY3VHVGdMVnFi?=
 =?utf-8?B?TXBYZk00UnJsUDhDdUpGN1daUnk1ZC9lSTdydlN1SlJVNjlraW1lKzZPYkpu?=
 =?utf-8?B?Z1FscTloYmIyYWJUTEoxQVM1UmJWRFBOQ0E0V2JNUHIreVhLN2NweE1OMVZa?=
 =?utf-8?B?c25XVnNFYmI0MXM5Q3NzelpVTktIMWNaSy94VmdFa3ZRdVVqTE1GdC9JbVlI?=
 =?utf-8?B?NUxMZjdBQzgvVjhWTi84OVZCNExkZjJCUXlNZXZRNEFLVnRSdFlYTTU3clRU?=
 =?utf-8?B?Tzg0VFgwRUFmYTdWM0ZVWlgxSW8xVDY3M2hsb3cyMkRaRUlkQzc5dGxqTDBT?=
 =?utf-8?B?WjV6YytQMXJ5d3hJQVBkUWdaNHRORm5QSzNVR0hXdU90K0JYa0dpeDN5dTJR?=
 =?utf-8?B?UEJEK1Q3dVZOdUtNRWFScXVTZzA5UndIL1pMMWYrcXg0SjFvMy85SVp2cWxl?=
 =?utf-8?B?UkRjNEkzQ1E2S2RYQ0dTWTloSVVNRTRSVHpVZWUwM1JQbkFpSm9wUExMRmcr?=
 =?utf-8?B?N1ZLYkJQNzUxRlpCNUhGaUZ2bkdaaVpqTVI1aTViT3JaYVVwNXJEZ1FzbXhv?=
 =?utf-8?B?ZzArRWV0YmlRSTlua1NyYkZKaXJMZHdVeHN6SkdSMVZ0SWd5TWxnVTVCdSs3?=
 =?utf-8?B?OVhlbVV5bGFTMnZ1bFpMNVIrS29ScjVVZ1V2cjhLQ2tud3cwd2tVMHhjTnhX?=
 =?utf-8?B?SjhpWUdkVW1ZNUxwcDRJSDh5a3FZR2pOYWdGVkExRG9hNWZQZTN6VXZjWEVZ?=
 =?utf-8?B?V1dybjlhR3FJeGtvMHV0aldqVHZCczNvbjhDbmo5cEJ5cEpiYnhuZFpmSW1E?=
 =?utf-8?B?dFRzNDJlWS83WCt5N0JiK3FOcE8wcTRhZzhLdVp0NVBlK2pybzA3T0VOYUl3?=
 =?utf-8?B?eWtQZDdLQk15SkhwT3ZiZDArOCsxdDJ1SHg3OTBDOXlkZEJyTlk4RWVZSkNF?=
 =?utf-8?B?RGdtc1U1T2pvQzZGb29wZnNKazRQYkxCRnhyLzBpZzh2THNKcVg5UldFTllG?=
 =?utf-8?B?UElJa2wzUlNsVEJTVFRENkx3Y2U2YzN6MjhWMExsZlJ0ZHFCZW9HU3R2SVBW?=
 =?utf-8?B?bzE2STBMWnRVbmtoU3BBNWwyYkNEMGNLTU9tU3puc2UxWWNnbGRtaWNqTmJh?=
 =?utf-8?B?T083TGRnZU5lTEs4cStiRFlRSkVwK09nK1hwSmxJVTdTK3k5R3p6M3FRU3V6?=
 =?utf-8?B?b2IvTWZtZndVK0hwakdRTEhZM3ROdWY4N2N4eDJCZ0xnYTdNVGZicVBnWHVi?=
 =?utf-8?B?d29NWjBqYkJKdU9RWXNKL3MyZlBZaFRpb0c1aS8xL2VnOGFYdGgyYndtYnFQ?=
 =?utf-8?B?MmlTSHo2eDdoTnNTdXJOV2lVVGxib1JDRStjbXFWTFVMbmlOOFkzcU1SQWFm?=
 =?utf-8?B?OS9oZlh1aXh3NXBNVGVpREcwWjJiVGpZekNmWFg3aFhDL1JxUzZXYzd1dHBt?=
 =?utf-8?B?dDcvdy83R3ZqdGN1bjVMeHUxUEh4YXp6dWI4WmhlSFMvWkN3dmllWExOaHVL?=
 =?utf-8?B?ZTdXRHRtQVNLeE9nMExDSSt6R1RJS1B3QlJmK2U4WkxMdzNmbHZqc2RwUFVh?=
 =?utf-8?B?K0x1OVNHQmlWTnpqU0Vlblpsd2RvMWV2eEYyNTlGVHhralA1UzlMcnlBY0lM?=
 =?utf-8?B?dkRBSG9zWGhWRTBtdDE5dW1BaTAyMnAxRENzc3pkcEtNT0RpNFUyMUJsaUdH?=
 =?utf-8?B?V3Q3TTBzdjFWdC9weVNnSjFHVmhhSGRjTkZXcUtmU243VXVZL3d0QndjNEtm?=
 =?utf-8?B?QTVXYmdoVFBJLzViL1NQOU1TUXNkM0xhMzZMQzlmeEpKdGFjb1J4L1NsbFdn?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd67835e-532a-4e1d-d644-08dbf05ff32e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:18:29.6640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMmfhLBnXUIFgTxYxc1zgJsQ+/v/XHzipejWvqs7B97lx2lTQ+Xz6ejmUv1nNQjTp3cmzn8o9rWQ+6tV7I+W4OGH81y0Ozpw5Whn9tYHCaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8024
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:

...

>  
> +static void init_user_params(struct user_params *uparams)
> +{
> +	uparams->cpu = 1;
> +	uparams->bits = 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	bool mbm_test = true, mba_test = true, cmt_test = true;
> -	const char *benchmark_cmd[BENCHMARK_ARGS] = {};
> -	int c, cpu_no = 1, i, no_of_bits = 0;
> +	struct user_params uparams = {};
>  	char *span_str = NULL;
>  	bool cat_test = true;
>  	int tests = 0;
> -	int ret;
> +	int ret, c, i;
> +
> +	init_user_params(&uparams);
>  

It is unexpected that this uses a combination of designated
initializer (via {}) as well as an explicit init function to
initialize the struct. I think it would be simpler to do
all initialization in the init function.

Reinette


