Return-Path: <linux-kselftest+bounces-2087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7B5814EF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 18:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772E41F25317
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F4982EE3;
	Fri, 15 Dec 2023 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7F2fvru"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964B82EE1;
	Fri, 15 Dec 2023 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702661983; x=1734197983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rkBLkuq5ENjpb8VNZg3PH6t68xPZ+joQd4vRnvqz9/A=;
  b=b7F2fvruIJdeYrnLgX6v6L+GSzYzxvi/t0no03OwBT/L292oM/DIE2Bb
   nD5UXHx1O4oayBpSvNhAGvzPpnzw+WWB1fQdY1ECsxlXYW95UKzEI8w0j
   CkvuB4TXA4vg84a2kOrsdGTmz197lk6UWyjyevWowVkz4NUlmtqWyGozI
   tpHoSmSYzJybPK7Spe9OCdvJMA3dwTTNlv5hTeLkrhiyvJBhRhIoGofug
   EwIgnJTWanzbumZi957DuCUKjZasHkL6WJzNnnC21TuAKO4JoNTTUfOnv
   MvqPHu4I+RolyWcDCZEHM2qGn0FpZXq4U9wcAC0xMBRXyMZtE9seFAI8H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="399142665"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="399142665"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:39:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="774831622"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="774831622"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 09:39:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 09:39:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 09:39:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 09:39:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+VXG38bpsAJuYx1ZSE8N6ps90b3Nz8FN4aQms6mbDhcby19OgkDakdJJWpA6wsw99RvqDLJFD1jo4Dj+IQdUb4/hmrsnA0UK0jj4pDZ1F1x1QgbRguX3q09NCCeV+SpjNCpR2erBI9eMSAqAVCc9cEVIshzvgkVbH4OAUeZ5S01kl5+fjNgxhXej98aZ0b7bxhBE4jhwCB5Nq3cJHYGBSYNZlWGU1/HupMkTCDB7FQ2fOmjad8Mkwu4PqR6lTy9vIIAjiqsBPqrzfxByH8UYjkv5g/3e59jFywqefVE6sTjKwplXYjyUTNMUTBvZ36pPNblHJaKMEyhQVwnbU3Biw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVIJoOU6A2EOWeHG3ymdFM4OoOE2mJ4YbMU+khn3Pzc=;
 b=i/bVC4qEt+gkQOElMsvWB4mCU7JNV2BGV1SUZ9zQIq1foiDNy7HISVyqZvXnxR8d4u8RPFNc8nn/VOpD5YFDL5K66OCeAKOhuGlWqqbfA9zErvB+F05Pwa4liXk2Nxj1vuoa6bIYr9F2qxTEcJkxlgImu6/kH4HNFKujA48weR9/1hYqV4KXJRUf8vJvxDgbHWA7x8MAcWS6Nc6IOWpaz1e6tFT0tmunv2lb1L2RV7T3AYbgqjB3aV7eUNEmJFV0fea0N4Vj0T90rsiC0QeRJEvV+MssieT7o7wXhxkOvVGsqy/DnSyXtMnQdKgHgZJ6fryKN8r8z/ppgp4n4zv3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5878.namprd11.prod.outlook.com (2603:10b6:510:14c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 17:39:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 17:39:36 +0000
Message-ID: <1a05246e-4468-4ca2-96f5-95c137813440@intel.com>
Date: Fri, 15 Dec 2023 09:39:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/29] selftests/resctrl: Convert perror() to
 ksft_perror() or ksft_print_msg()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
 <20231215150515.36983-2-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231215150515.36983-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0374.namprd04.prod.outlook.com
 (2603:10b6:303:81::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e9b467-1fb8-4496-4afe-08dbfd94ce81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5v57Zyi+xiSOVkZg47FhKWJkQD/v5t1ytrIBbZoQojEGKDto9wM9st9ufCvHdWm8TCe8mWtr3Wkitlb2IX5zMMoopepFSGOlK1rtzY0LJKLRDeSxPs4xgjDmL1k6p/7PL4PM6ljoqrGm0rfLprynY84qIXBVbNA2Ous2ZzwDBQQav+wB5jTDKWG2/4DTp5XxI1rmnRWQ70JIcOq7vByGBLATaKsP2zretP/czi6knPlpxaP2PUeRQ7WaT9ABH47pLsXVIxwdJl1XiekBQ2tiGeR/hjzDm3B6RklKrvFhM+1JvD0RkEAyIeBHLKF5/wuS6JpJj4vNYEn9wkGMjELHeqZjN21EsSUp0k/X4FyI3Td+tmxhhWGcEsKI84CD27J2LrPyhhUxLc+Mh3W1oSoNWII0s8ItP8GtHIdxD+o+0LBTN1m5z+FxK65+OIky8XcT0ea6pbT01QOiECoA1Xm/2w5D31Uzj4bbBpEP5ohjT4wXB4H/Mua5hgp0I125BDDXiMM1m7nkzF+gZ4PMVH65iVsFbmImqAuYWWxN0aTExd07I527Ap5VwpIqIDwCd0NuNMf/bQTD3ejPErPRM2RhHYc2UhGr+5ZMlq31cMYhPzRU+RtVhMaLzOSKCTdddUFfIMGicrDRw8Beqn1pkU3og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(26005)(6506007)(2616005)(82960400001)(86362001)(31696002)(36756003)(38100700002)(83380400001)(5660300002)(4326008)(44832011)(6512007)(53546011)(6666004)(6636002)(316002)(66946007)(110136005)(8676002)(6486002)(8936002)(66556008)(66476007)(4744005)(2906002)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmZWc2pSb1VuRGZUdzRrcjVzREdGQS9wYkp3dHczVkNEMDJFR1pkZ280dmV3?=
 =?utf-8?B?d1orU2sxMWlVMkdxTUVXbXVoT1U1M1o3aGNURkRFQnQ4UjlQUW1OMUg1ZGFq?=
 =?utf-8?B?SFNCNTU3Q0Fxb2FHcTl4N3ptaWFvSnI1aGFaU0dEaFptSlNYaEpjUWtwWW9H?=
 =?utf-8?B?TUlHY2J1MG8rZS9vdVN0U2JSaGZPNDNJUVlOK2VUTThDem9rNktUakNVOTFo?=
 =?utf-8?B?TVppV2ZmUm5YVWFoTm8zRVJNSm9uQ2JQTi9oa3o3dmJCeDBmaHM2V2ErV1Nj?=
 =?utf-8?B?TmtzNTJOZ204emJ2aW01UTFmdEdpK3VCVmpaZ1pFZUZxQkVZQXhGSE05azRN?=
 =?utf-8?B?UGFtT3MzSExOZlFCVVlYanVPZnR2QTNzT0pOVGdLRDNmNHhaOWlvdWUyMTNm?=
 =?utf-8?B?eTkrVnExa2NTSGx5MmljVnpRa3FlbXFrVVhIK3c5c0tRcDBhUWtGYnlaR2lY?=
 =?utf-8?B?SzFqazY3bExQUGxuOC80N2pvajNDdFI1SGpYY2Y2M3NLU1hHa05oQlRFSnFY?=
 =?utf-8?B?bDExMUJRbWdZRXlPMitQSUN2dGpwcVkwVlJiR2h2U1krZjZ6aWE4ZWxsQXNo?=
 =?utf-8?B?empOMUkzOUVPNGV0R2JJV2VNblRSQnl4ZVU0Rk00eFFHV3d4MzgzQWdtMHBE?=
 =?utf-8?B?S01hRTAxTGVDRFN4SzlEZGh1Qzg1NjRPOC84OHQxL2hKN0ZES3I4UkVFdWZX?=
 =?utf-8?B?bkdkN1RPclQ2UmVpbC9GRi9OQkRrczI5dDNCVTF1V0RUUTdPZVN3aUFRbGV1?=
 =?utf-8?B?MVp3aXczajFFSHd3YnV0WllsUGFTMlVFUTdGS2lKSXJNOTJZOUhKdGFHQmY5?=
 =?utf-8?B?WHhIVGJPc2pNaUd5Mm55ZzV2NUJOMGRHTHBJUUtGUXFNQU10bW1QOTBuRTk2?=
 =?utf-8?B?MTB3WktrWlAyR0NyVnoydElySHVKbTJzK1R2NkRCcGhPdmZ2TFpkM1NleG5l?=
 =?utf-8?B?NmRhWUIyTnorR2xpZTBCcEZTbk5ML052Y1h1YU50bUJZL2NBL280VXZFbWNt?=
 =?utf-8?B?TUZIYmxkWlBiaHJTbVhJTGY5bG1hTGVRaGJBN2RUNWliRjRPRld6eFVZOG50?=
 =?utf-8?B?RUxqNEZTOXpvMlFUVVhjOXRFbXdXNVFHWWxmUVhObnhxZENaUUMxUWxvR2xo?=
 =?utf-8?B?bUxKZThzQUFJMkhTQ2lqUml3SVFsVVpBVVVMUWRxcXhldFRScENHMStUK25E?=
 =?utf-8?B?czY1Zlk3ZDR1L1lYZnpWaU0xT1IyZGlaMStDcDg3SFRnbUdaTW1KUkR0Y3BC?=
 =?utf-8?B?NWl6NFVqOW1jYmdNSWxVajBkK1FHY2d5Y3ZTdGxNMldFM0lHTFRtTFRLRHhj?=
 =?utf-8?B?ZHBmUW43aVorMjJ1Q0FuSmtqSVUrcEJIYjhNZG5VckViWktMRDM1b2owdW95?=
 =?utf-8?B?clp5VG14Mk1zOEY4MGg2THlVV3JNdEEwdUdJcXE1aXdNcXNwb3ZnTE14bUZM?=
 =?utf-8?B?a2FrVFJaZW9WaGlWa1Z4MDE5U21ZZ3V2b0s0MUpsd3JxL25pajM0aHlpak1w?=
 =?utf-8?B?SFlqU1A4Z3hlUGFlZEdzYU0vdWNBK21ZOTFvd0R1c1NFNEg4QU5iQ2s4ZGR1?=
 =?utf-8?B?bng4MFN2VVB2dHRueFA1OWMyUy9HTzAvSzkwUVVTaTh1b1E2eDgrWUFHb0Va?=
 =?utf-8?B?VE5ucFc5VnI3TFp6dFRTc3ErV0Rma2RZQ2o0Ylc4eVhyU2h0MktCY3E2dTRm?=
 =?utf-8?B?YVh1c0VNRnVhTXdmeXJ5Z2ZTb0NCZjRZQXBEU3MvZy9GSFg4WUtBN1VNV3Uv?=
 =?utf-8?B?MUZ2MkRKMUxSNFNLODBiSUViOHlqZnIvNloweVFVOTlZa1hORWdjV2lhKzh3?=
 =?utf-8?B?L1B6Wm1UUlE2VnBTRktJRTJxMlMrSUtTdEJhZzFkWHQ1R0VkODRuWXVvcm01?=
 =?utf-8?B?SjNCYWFDTXpTUU5ObEhyYTNRQUU1cUlDSGllZDJiWTl4eXk0U09jYldkdytK?=
 =?utf-8?B?ZDVrK29lamNtcFFZVThWV2dBZStyWmd6NDRKMG5pTnc0VzZlNzFsekU0VVEx?=
 =?utf-8?B?d3U5Q2hKT2d4WHVic1hMcWJUenpuaUMyWUY4ZlB1SSthY2NLYmphMXFSYWgv?=
 =?utf-8?B?UnloNXRJclFJWk5XUnBKbVBOZExzck1HbW9yL0poVFUyUkpMQXFXekZGYi84?=
 =?utf-8?B?VTVueEhYeGpsSlRwalhjNkdaRHVqd0VscG1HZDk4VGM3UmpXWW9RWTN3R2Rs?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e9b467-1fb8-4496-4afe-08dbfd94ce81
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:39:36.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipsWteSM5cAQqX3WrU9iDaGT1qVmD7M/UYtT1NsUH4CMJcQ0ifb+5YcPpUMDlcBmAxd1TEFC/VAFHiGAuub52vWlCU0i2x3BHcwYBD66T6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5878
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/15/2023 7:04 AM, Ilpo Järvinen wrote:
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
> - Small fixes/tweaks to typos & grammar of the messages
> - Extract error printing out of PARENT_EXIT() to be able to
>   differentiate
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

