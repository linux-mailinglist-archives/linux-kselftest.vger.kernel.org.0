Return-Path: <linux-kselftest+bounces-773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C60C7FC949
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A54B1B21174
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2EF481D2;
	Tue, 28 Nov 2023 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORY7WGjO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8354B19A4;
	Tue, 28 Nov 2023 14:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209792; x=1732745792;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uuAwbndLnT+qmksxxGZxb0B0+laWgCHvO9zx/yZEhnc=;
  b=ORY7WGjOROKWpdcGSfpoTOU/2gz6FrkJalXQa9HOaZUxsFDGUTnQIwzL
   RykmYulhMTStnzWnvsfHQZCmHBCSGv2McPf5NYXm4DF8j+YmsYyGTNeoB
   5kdDEXqcWxbnoDcCXrO0lyZTXIQ9JHPeEOlMC8tG1nrLOI9hjOYc7geVz
   W+j0+7l6H5pLKe4XXrxINYCiZwmmOWydyMHNmthHzTyElwqjUqY8mITKk
   GTNUpl/xWRxWS2ZH2wba1u/oexjC98MVqrYGRrU8KzVg6nf7ymDKCIdNP
   TL8lxZhoCct6OMz+RjVSNf95J+J/8rUtazIts8R38sBeAf7x5JmKtmydO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479234933"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="479234933"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:16:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="16770454"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:16:32 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:16:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:16:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:16:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2HsbqLBFrS08Mpc+G8bQFUhEKFDZShpVrp5LVftOZsvAql8bBGwvolDh6gCqEjQBWOngbIodzw/EQrbJHAkJ5jMGZMd3FVlA2Eivbg3jElKh/Sl7E9zShTRAT3hEzFTRV/TsdLSqvpXAZRk79zmELInhhVfPEiQP1saYduvBtT16LGWR1Tk981Lor2lDEuvDUO4jWhpPZ4CQZ0SrCkJd8FIiiS5BYdU2/ki3dBDpMT+Z0qBLzsgVve0IpDmX5oEQTSdNp9LdJX+bOgfxq2YiOOuLqlROtuInAB5OdNqVO7LjjcXfngHwOgFuG32uXOYdYnqlfyp4q3NKspw/8SN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ilZFv4m/jKOdEE9lxIFZ5xJe4XUxrlvs0fusNMkkl0=;
 b=CsPmpfMcQ+dxOmKIeNqy4BY02RZywsSnCc+fkxDGVxUreGhLKmLJH9et/I6Fw+QRZIHQYs6IJmWK/V+mwy0/52UaC2zpj6iPX6CZIbXAzFDwtEF2fLoEY7phyzVmsqWVPf+njBRaLzTYND4dIN3NqUjLL07lvCO2Bvc5CaUd4nXxiN46zDHlME6nTsOSZ9jxNfO2DglKOdzWCONMgv7+bQ3kU2aT6xtzieUOSYqdc7k9BhpnSQ7SUJEXPf7YcopIZwLfXirxrtLpxsLK8CylnzP7XRo8bh1OmW1VxPuRh37do0kmPRb+JTc31xvsPaYLSbJyBvBStEmouxJxGL5KlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:16:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:16:28 +0000
Message-ID: <6358c720-66a9-4727-a74d-b56100f01ac4@intel.com>
Date: Tue, 28 Nov 2023 14:16:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/26] selftests/resctrl: Replace file write with
 volatile variable
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-18-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-18-ilpo.jarvinen@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 307a56b4-4ba2-47d0-c1b6-08dbf05fab17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Mh7+tAWAYYkp7gFWaZqIkKpc7SGd9PYNiRrRIBO2t9lt+Lis7idVqre1hjCj9j044Di+k+iw4BhxaaJ9nARasCj65AUb1c3ilEdejiQ+kAzS5cA6NLXwFNrkLofScmIBbU68wOZdzrGItE6lWtnF4UCAhGMm9nH13n8BDs3giBJYR8raKRwqDf1Lb/AJw9HwP7jQOGr/6qlw/luE1ryq3bXRKK6t7Dg39U7Af5e51gHmTUvvSndeuk437NmTRtEMgkP4XyoYENrs4zMIe9bGl/XctPafmU99CRcitLYWlUscJt7Y/kvmnNENW3a/1pglmzM8u7dS9Sq1mlaoRc6PImilU1+A6v4EaHggR2ipviv6aSoxOBfSIYYcn4INjlJrS9PgcKwvrWAfOx1MPs3IDiKWZYmlmuXky+5LRzQI7XBfTVatu8Ns8J7/f/ZXTsSuBrLfI8lBxMr1UvuYGtW5ObI4OKYtdNcb7hWKLCoFmDQp5OJQSQIzsXjj5tqSJeVh6cFArB0TKK73vb60yqmQ7Rq/3aJegGtaOIWZ2dbSNnZUKbL+AC4OlRvScANaRsG9d9Bz0K9HCQFkJxo8eg3PbxVPa8OqdD1FVLjsgaJ5SMCW6Libc3o3X4tuSSlgwzL+gCZjRgc2KF2UHnSu8TcOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(2906002)(31696002)(86362001)(4744005)(26005)(316002)(6636002)(66946007)(8936002)(66556008)(4326008)(8676002)(2616005)(6512007)(6486002)(66476007)(110136005)(478600001)(6506007)(38100700002)(82960400001)(36756003)(53546011)(44832011)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUNhWnVBdFBQOEc0UmNWT2ZuTzhJdFQzMlROR0MzZkg3ajFDSmcvV3Q1Skl3?=
 =?utf-8?B?N1hHeXJUNXhPdC9RUjBNRVVORzlVSlhIWkdQbFFIMkJ3U1FrS2R0eUJwMFNv?=
 =?utf-8?B?NDlNMTBVOGkxL25aMllvV0h1bDRRSzJJc1ltMWErWGNZR0o4b2NtL1RMMjRp?=
 =?utf-8?B?R3RDekY3dUlBY1ZvUkxzdHZTZzVWSy93QkZGeHdpRVErL3NTa1FaMTJNVVFl?=
 =?utf-8?B?U0lPRFlEdCtxTjFMRWZaQnRUaEdNamQyY0dWN2VOY0pNMVNFb1lzVFpTMjFI?=
 =?utf-8?B?ZjFKazFzV0hDeFVpWk9QWjkzL2c4SStJV0dWdTkrYWtpcVUwZWU4NHZpOU1X?=
 =?utf-8?B?WDUvSUlwdWI2SGIxbnc5Z0dYby9TaGh6djN1TEFBVnp0STU2ZWlFNE1WWlRk?=
 =?utf-8?B?ejZZcEhDZVBZYlRwMmVIN2hIUHphbUdKNWtNaGl2Si9oUVlITWthQ28vRXlG?=
 =?utf-8?B?Z05BNEpMU1poL0N0dFhYcWFaWGVpUUdVbk1QYmtzcVFnZEZ6NW04TDlONy82?=
 =?utf-8?B?azRVLzN4d1pUWktXdlZyWVNWSUhLdUZydzNhZzVLVVQ5bFdIL2YrTW5Ea2w5?=
 =?utf-8?B?VTFLd25waEVsclY5SEV2ZmhuQVQ0SVhhZUtaNmRXb3JOUTZGU2JpdlpERkty?=
 =?utf-8?B?UGxXT2JqcTBQbW1sYXk5R3pZbDU1UEdxRlZPZjdVM2xUY3l6T0kyaG5OU2dh?=
 =?utf-8?B?V1lOOGdUdHUzUDJqZzNDbWwxb0FVODZUL2FzOUh1V2hsekl1elNkMzRaTUM1?=
 =?utf-8?B?ZFU3ZVp6Z1JzMVlJMjBsVkhWQXBXRG45TFRSdzJHc1dtREhyOUtQd1NFZ0lP?=
 =?utf-8?B?bEQ5S3MxV2FlOHVpVFA3OTlMLzNRL3BobjFYUlNRMFFOaXM3S1AwUGNyWVJk?=
 =?utf-8?B?VW1oRGtFajJvQTNqa2RGdUdnUkg3b0paQkVJRWN3RmFBNzIrbU1EVGppOTZP?=
 =?utf-8?B?cEhDczZVOU9QVExzdFIvd0R2R0hQSXdLUWhXR0tCYXhYemNtR01xQWN6YTM3?=
 =?utf-8?B?OU15bC9QYXlYR3c2Qmh5NXFkYW1tZlhtN1E1eStZL2tMNytTTmJNMmtXeWpn?=
 =?utf-8?B?WG4yNzhMQ0U3a3dtT3Nzcms1WGg3VGpMR21HWEZVT04zZjFCb0U5MUtWSUNV?=
 =?utf-8?B?cDBIRXFYREVJRUtBZnR3eERZaGpEWm5ETkFjanIvdFVCcUx1d0hKU2IzVmNF?=
 =?utf-8?B?TGNxVFZPN0JIZVZpTFFEc0FDamUzMmlhNWFyR1BZaEgvK2tUZ0dPTzZkMmYx?=
 =?utf-8?B?dXVxQVJTMnpRRUFDSCtpTG1rQ0RaT3VuMGhIb2hPNmlsSHJSaDBTdHFDYU5p?=
 =?utf-8?B?UEhHKzg5VlZ2b3Y5OFpyT3JPM3JSSDllT3A2bkFMZzhSQnE5UW1xQUdWRmZM?=
 =?utf-8?B?Qlg5N1RRd2FDajZTMkhUTEY2SzR2cTltZ2JHU3c1THBOTFI2WWRGQ3JJVFM0?=
 =?utf-8?B?ZDFJWWVzVkRWTURoa0Z4cFJ5S000ZXliOWZsTXJCWWJ4REN6eUtKWE1mMW8v?=
 =?utf-8?B?YXB2eUl1Qm5aSHVDVk9WSUJTMmhvWW1qUVAvaHdpWGQxeTJYa0JMbVJtb1Np?=
 =?utf-8?B?MjF6N1YrclF1MVRWZzFGeU4xY0djc2xad28wOWdDZi80b0xHWHo3dkdkVElH?=
 =?utf-8?B?V2lhTVplQmxubHRQcVkvMnJ3L2pFakkydi83L3JLY0hZMndwaVA3U0pqaDFk?=
 =?utf-8?B?TUF0TzgwNmM5REU5NXdud0g5UmVHdWU4M2xtZXN5eHNwTlJWd05VdHAzbC9B?=
 =?utf-8?B?d3Ztb3E3VjU1OGlFLzRnYXlPbmR6KzVyb3lpbFVjMjl6K2VGUXJ4OHdUbXRM?=
 =?utf-8?B?UkhJMlNvMnliNkJ1dXE3V0htR1ZidGpJeVE3MXdOS2pYMEVvRE45WlVOalV5?=
 =?utf-8?B?a2tQWlo0dEJ6QnoxblZIMUxOdXFVR29HOWtNaHRQSG5xWkRPaFFLOU13eXdD?=
 =?utf-8?B?dzg4Qy9HQzVXWnNka2d6THpBMmtkdkozbFk1d2doU0hoTzZjU0JxelFERmUv?=
 =?utf-8?B?ZWcycWlTUmVEZ09kZUJUMlZtSzYvTUVyTmVKM2RqdG11aHdLVW1EekNic04w?=
 =?utf-8?B?STZTcHhpbWVEWGR1WHNVbXBzcVBXanEzc1RKVlZKUjlIWStZOVRvVmdKQlpr?=
 =?utf-8?B?d1dXQ0tBMEpGNUhwMStOdVRFT3NOSHowZDBSMzRxYXFhRUJHLzhsS1lnOXFo?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 307a56b4-4ba2-47d0-c1b6-08dbf05fab17
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:16:28.7043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsEdCPXEGdhAMsbZsB4EGeQy2FkbVdcp+XNdPdVZJd/BKcOph/cGsq0/tDEQASzZ66+nij+JBCJRBSZPd2hpWXuXnjHZAP3Rz6i/JO7x/WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> The fill_buf code prevents compiler optimizating the entire read loop
> away by writing the final value of the variable into a file. While it
> achieves the goal, writing into a file requires significant amount of
> work within the innermost test loop and also error handling.
> 
> A simpler approach is to take advantage of volatile. Writing to a
> variable through a volatile pointer is enough to prevent compiler from
> optimizing the write away, and therefore compiler cannot remove the
> read loop either.
> 
> Add a volatile 'value_sink' into resctrl_tests.c and make fill_buf to
> write into it. As a result, the error handling in fill_buf.c can be
> simplified.
> 

The subject and changelog describes the need for a volatile variable.
The patch introduces two volatile variables. Could you please elaborate
why two volatile variables are needed?

Reinette

