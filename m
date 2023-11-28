Return-Path: <linux-kselftest+bounces-777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB277FC95B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D80D1C20B5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35652481DF;
	Tue, 28 Nov 2023 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWpJTZoM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4CF85;
	Tue, 28 Nov 2023 14:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701210013; x=1732746013;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gBpMmJQP6ovPXsfweOhWIXYN/KmykOLjSuUtJ2btcLg=;
  b=aWpJTZoMwpCpvbW9rcJaso8kR2KAmsO3JfTd0MFF35WPnCSG1bZqkGsn
   swiYpDf6UzVpglrTmEdeWj56caTNB100BFUgT1+3IK/BKH9ajfmsetFmS
   cEqWguIc/kZgBERfkDERTJpY4kpxceNRd4oZH7+8dQp/svG9OCo7GyLBD
   sbW8fgGqYrrxKNN4pepE5A31IuM/K66Uzd/ytG0LzoU0raVcBFStGhzuI
   vWDUK5KHoNiCrXALBGq0ctAuRmsLgi2JzPjKqnTiVHfFwDQ0UAZ9Qjl3R
   fotMEg2h7p5VXGy7HT1pReHPCnPRfHtfhnu1IsZEQ68GaXA/k+CdN+BIp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392792432"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="392792432"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:20:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="762080036"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="762080036"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:20:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:20:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:20:11 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:19:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nu7KQ7FxYyh/7iYj714kZAJO8DY605uI7VABfr2d95CVH6zW4ylV1Ol+Lf2kCqRiIynxw4Dd9snIGYkKlowCeASLj1xd5R63iSAYFTRniYfSfiCNdX04XErcQQ9/hLcKhb326uXgze0T2MUQBhcIoTbOXJy8gbAVjXqYpTDf99HrpDlerB7k1VoEvO0ld51JiAD7QiTG0of8aHF1RfeD2oVnYuLgKRrBrPrN9buaSzn6uUszyf5fmennHK/gVBMa3o0fSKzi/M0flIlrUMJIJwiyIrpjGTFx9JnzkwMC+5p3fbamEg4c+8dTCnPoxBJjrIezKaBM/mdkYbi5Wnoc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3dlalNCfQ//5GBejHzqEDrcJobae+aw5xwYKAhACWw=;
 b=ETDzVFHM8FEEYwpPhnrZ58E/IOPaNsrpcNejTy6HKnodP6mWE5opaRPmuywHxe0Kpgr3aOUIWY7O3u0o9/zcFlKFfOOyEe2j3FmUGYkpoB/jrxilkFJUDNXNn24S2Ggxnp83Tecgn7FP+sD8IFAU0WIB28r+OegoA6Cj0uUWRr1x3uGskpX4iTQAHz5xIpiApeoDkjb1/nq7tvotQshivOXlcQZo5sSWy1pkUUUjOC4isOVlMFFxmfMiS3BHmMCUR1xLJZMMwGnKm/dov4NiAVxjVSwK6wAcznV4GSKMunGOsZJHx0ZkoAd20BV4WExKZwQnrld/JC6XKRdaKUNGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8024.namprd11.prod.outlook.com (2603:10b6:806:300::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:19:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:19:18 +0000
Message-ID: <72a26cac-260a-4350-ba58-2651070f0246@intel.com>
Date: Tue, 28 Nov 2023 14:19:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/26] selftests/resctrl: Introduce generalized test
 framework
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-22-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-22-ilpo.jarvinen@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7b131409-cbfa-4388-1412-08dbf0601013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MbeWUgpRbyHh61Dc4IYMVh/iW8/bgHoijJ33gmUt5nso/opL4MYh6QEaWdOkKEoc29CMSHCm9aatOLnlTkBKS8FEdPBzfIIYVKEsD00mWhHVAzVjX0XsA+dOx0oG6oT3m1coBd5BSw3USQQwdiWD0E1mjWAfOd7MgiEWq8eSn89oKYtGWFPV0raUVmolZtefXUUed2+fWSpIZMjuPNzTFLviwWqlJPD6CDh7nQ7JZPRD0ZtUf5syIo3FkNAecCv69yURfHFh/n8QUOiBwaakbsScN5SXrPjYk0/nyBIfn2oYzsNw9qwSUwDFCSPuski5t4Oj+q91MuNZtyM7yNGrtRI7JTnF4R8XK8QGXEJw64eVvkLctmbAKTDvLnsH6MCQxxK/90eCBB+OBnuHlpCJmUnBQn/wEGBp/SODEVsVXMDVcaw2UBrE22vA35OCzOrYFFEuY2BzEu8x456svuEDWxTHaPNybCcSJpWQdEgu4k0G7Kxu91t20WM+mCGyPtFd/tKHv+qTcrefg9QSOcwKVol1yM76YoxwSIcglSOUS06qkNK/uKZJjFvwDr7IaIxmJBoeh/eU1YI89UU00vTQIL7blXSuBXTIiGKOAPQPC7lwFBFM70tqvT2uMF0h9qOwEx8YS0u71R4DjuEog26rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(41300700001)(36756003)(31686004)(83380400001)(5660300002)(82960400001)(66574015)(26005)(86362001)(2616005)(2906002)(44832011)(6512007)(6506007)(53546011)(8936002)(4326008)(31696002)(8676002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(110136005)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkppWEtpK29hNjkvYythV0M3YXl5RDVISUdPdkRtOEtxY0hOUVJoUEx0eE5S?=
 =?utf-8?B?ZzF0cW9xSlhiK202MjQ2NFBDRFE0REM3eTBHeFZvWE5rdFdGdzdsc1ljN01W?=
 =?utf-8?B?WDExVGhUK1pkL3lRN1JUbUpuZXB6V2FxQWh4RDU0RXdUTE8vazJVaVJ0Zk1a?=
 =?utf-8?B?Y3BraENvTVRLY0dOSkVCcEJiM3pEejlUc2hwbWZWRWNYcUxWSXpxczhJWlZJ?=
 =?utf-8?B?bzlJN1JpcUF1K2swVE8wemt4RzFrQWJRR1FHSThGM0VoTi9qQkZKZEc4MHFa?=
 =?utf-8?B?aUhLeU42MDI2RW05NU9MR2xVY2czQ0NuT3FKdCsxN2RjaGhlcndxdHNtNmQ4?=
 =?utf-8?B?UytJQmM1RDAvV00yWnJKNWNLSHVOKzJ4OWdrVnptb3J3NVFMRkg3RGxmOUp3?=
 =?utf-8?B?MFdtUG42WmN5dlcxdURVNkpoTjFmclREQ3FXUVdTQVFCazRNVDdJS0ZLelRV?=
 =?utf-8?B?Y0FrRkc3ZTJuRXhDd2tlZThURmt2azlYblowOEMwMy9maXBmaGQrWHVDM3ph?=
 =?utf-8?B?TUJod2QxVklZdzlUcEJLb2VVZUZuNFB6QVY3SGN2V2lXS3d1cmg2RG5Zdklr?=
 =?utf-8?B?OXRiNEg2K2hYSkZwc3YzVkFpV1lRZEFLdk9MUWlrL01JTmlYVTJiRXNKbTdO?=
 =?utf-8?B?cDArbnBFMzlpdGpMclZWSlViR09sdEV4d004VkNhSkQ5WFBOL2dOZzd0U2Ji?=
 =?utf-8?B?WGFsa2JZUnI2QUN0RFE2T1dQVEt0L295M3k0aVZEdFBIcWdubVptMkt5NmtX?=
 =?utf-8?B?MFpQbGM0YXlxVW5OOW1PVkFyeFNPaGpQNXdCc0FYTEREVk82UFN0UHB4Tjdm?=
 =?utf-8?B?clJCMXVnd1FESFhzem5MREM0NDEzbmg2dEh5REhUNVY5RFJRWVN6eUVjMXQ4?=
 =?utf-8?B?QjBOVGFmbHF3UkRxTllhL2pPQ0lOYmZKTnNQMDJaZFJpQ3VCclhVUmhtaWdV?=
 =?utf-8?B?TDJHcC9nZ1ZYaCs0aVRvRjhFaFJzK1JpV2U1VmxkcTgwZmtmT3k1SWdJZ1lr?=
 =?utf-8?B?Z1RaYTFJT3F1WU93eTNqZXIxYVJUblVuZnYxSFVFcmIrWlp5cWdxZkRhSXR0?=
 =?utf-8?B?VVVZcUkwZk92VGxYNWh1d2hsd2hRM2R3WXYrRnRxK0hpWlM0WFBQcDAzc3oy?=
 =?utf-8?B?NTZzOHJwcHFyYjE0RlBYUXdCZVFTNDR2RnRnUk9QQjUxQ2xpTWFCT0Q3OHZj?=
 =?utf-8?B?dGdoYVBKQkcyMEQyVUN3TFpubUF3TlFoclYrQTljeldvSUp6WnNpQ2dIeWVo?=
 =?utf-8?B?aHdUZWxmLzVUMXc2YnZ0OU56ZFFyM3orb3pEWVNiZk82QmV0VUovMW56R2kz?=
 =?utf-8?B?dXkwOFlGclNGdzVIcUxFcGZQN0VFeUgwYWZCR3QrVEZ3azhMTWs5ZVhYKzZI?=
 =?utf-8?B?S1N6TFJocldMREVCVjZuTUJtK1F4SVNCeXlDL0x1ZGNtQy93RWFMcWU0ajdT?=
 =?utf-8?B?VElIeXFkVTgxMXY3U0x5YXNsTUJUYVdNYkZDOVAyTTBWNHlGY3dpZWlQbWo4?=
 =?utf-8?B?THZIQ3V3T2JkTmw2SHhJbGd4NURYdFk5L1FCUUhLVUdoUWx1MTJNUUdWSFhR?=
 =?utf-8?B?M29nK0xpT2NCcTBzb3EvR1lUOUFZZlB4T3E5cytwQjA0dGhEWmtmSURxYzkz?=
 =?utf-8?B?K1pRMTFRRkxSMnFoY29UdHhnVkZ3VmEyOHVDM1h4aXVwM0VGR2xHQ2s2VExO?=
 =?utf-8?B?WlZ2ZURTUHdhWjM0bCtpNnJhMkFWRVprd0I0Uk5oMjhweDVCU3U4QjVoWjcv?=
 =?utf-8?B?U3BrcVJUS0lFTkpzbHdPTFQ0QlhpbTg3QUlJRFV3UWdhRVIxdjRqYzE1NU1K?=
 =?utf-8?B?dWIyWmt6QkQvTGZpSjQ4Ri9FK3U1ZTB6NUtoUThoVUdpUlIxYU1RQzBKMVNO?=
 =?utf-8?B?TXNra3BjcHYyU1ZKZnM3SEoxN1QwcjFVZytSanh0Q2tOWDIweG1uN1lvNkRY?=
 =?utf-8?B?THQ4WERJTjJPTmZOa1ZOaFZnMDRjcm8xOWJoS0FIYUpyYjh0OGhxWkpLNERM?=
 =?utf-8?B?ZkgzWm5VcnBWY3hRaXJzcDZLSDd5VlZ0MXpxd1lQMUxWdzhmbnNRYkNWeFRq?=
 =?utf-8?B?cW9scFZDT2lPUnliT0d1RHhKbmdqaE9WbkJrbE00UDY4WXdUMnZMUUpRSHAr?=
 =?utf-8?B?L1RKUnRKTGVlY3ZnRmFzdmlKZnpUZ1lyMTJZRDMyWjN6S1B6L0pJbmZIY2Za?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b131409-cbfa-4388-1412-08dbf0601013
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:19:18.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDkUgPz6z9jyynnHMwTMQlWaDCyhtuw9Xgu+t26HYRFmchTZr4YQDtYH18VgVaNY8d0VINHrcajfBX21MPyerWlWZ5WLdAg6dxWjcbyLIxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8024
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
...

> +
> +static bool cmt_feature_check(const struct resctrl_test *test)
> +{
> +	return validate_resctrl_feature_request("L3_MON", "llc_occupancy") &&
> +	       validate_resctrl_feature_request("L3", NULL);
> +}
> +
...

> +
> +static bool mba_feature_check(const struct resctrl_test *test)
> +{
> +	return test_resource_feature_check(test) &&
> +	       validate_resctrl_feature_request("L3_MON", "mbm_local_bytes");
> +}
> +

Could cmt_feature_check() not also use test_resource_feature_check(test)?
Why are cmt_feature_check() and mba_feature_check() different in this regard?

...

>  
> +/*
> + * resctrl_test:	resctrl test definition
> + * @name:		Test name
> + * @resource:		Resource to test (e.g., MB, L3, L2, etc.)
> + * @vendor_specific:	Bitmask for vendor-specific tests (can be 0 for universal tests)

I do not think these values were originally intended to be used in
a bitmask. The current values do make this possible but I would like to
suggest that their definition gets a comment to highlight how those
values are used.

The rest looks good to me. This is a good addition. Thank you.

Reinette

