Return-Path: <linux-kselftest+bounces-767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E07FC93C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2EDAB20D91
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E617481C9;
	Tue, 28 Nov 2023 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9TOI1na"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050BCD42;
	Tue, 28 Nov 2023 14:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209707; x=1732745707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=igvxD1NRlkGwccISQiRxCmNoZvgdfP/3w+Vn579SOc8=;
  b=G9TOI1na5QEHFXIGl/p3657LXjq15J2iIZz6UucK0sqk+yQe3wB3lGUd
   ZkS9JsJaA6LPpE5zL+0+hm4ptpaR5oumYKQtydjDb58A2lWI3FKQ0FeUF
   yD1RB5jqt5jpNbTYFYuK7R5CJgB/kaphbuTmp6AFqeX4kwmcl7zRX+Vmi
   3CTCl3gK0AwdvuDeHWYWuOGZpNSEbyW/dIplKWixqcZe20Hlife1RH+gV
   cXZ4QvxNB163F9fEesJkL+3ycdBqucBtom50uPng9k3f3EasCqtjYR3Z6
   wDERgYfFwX/OKIOCHEAPkicBjftp8YktqFxJHM93EtwjS4t0LYzCrBL6t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="395858366"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="395858366"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:15:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="803080359"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="803080359"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:15:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:15:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:15:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:15:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:15:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD7Vt29yZKSdFmgwVxSpDxzVzZxopOVpWGSR6UKJ83PDlyV7jri6vyTPMW1Ui+YudqwxfiU8BLKpnuYRSUOoMS8N8lfrxF5vsMNRXUGOJdVijmHNcdemVxT9e8Mhtn5Fwue0XjmY4KOBtFqeBPl21gt8HeVswqXZxGndO2JrW6ebrj46avHm0apIwuqaUEIFjY3VBoTMCvKTKirpvjWCnqIwvbL65BD3EIX74QIXC/zgNc+CcBny7XEAxRrZ6NxBMweBGjNmy3Zx0M5qKtILQoCyvszyv0DU9+10kUJ6yF4oVl5+zbRVTLIZxY5QNY6TEUT7U255hAn4MUjpwPu/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdGQF6nExj9POR3g740KWcL/7F7mpgMqUEPiI+mYAIk=;
 b=XCNhSgBve2Npx77Y2lGpv7cJGHX4f7mBzLkuJuId6SZw0UG/NDl4uijc6/x5CLIt8jytEDdDQK7StiyRteOwfrBLxt73Bb26G+D+2QYC+IIPt6sJXnuB0HoKK7O1buZtdenqY79YrHAoPTgX7yl1T0ZRfNL1L2fWbSJrw2ckUdOSlpNbosFj098w26oNSMpHnKgi/O6e4M1WIC8i1Y4wuJowqSEa/l8kQlPZIO2JyC4k+SQHKyUxKCk0nRsbfDmntZQZC99CfE0Ma+fYqmM0gcLa1WCBjw7ldxPjvsrgfA8dALaNrUNdS0X6e9EOPAqtepHLtghV1HqPDSdeh0PnNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8024.namprd11.prod.outlook.com (2603:10b6:806:300::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:15:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:15:02 +0000
Message-ID: <4e804300-79e0-465e-aec7-b7a09efe004c@intel.com>
Date: Tue, 28 Nov 2023 14:15:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/26] selftests/resctrl: Remove nested calls in perf
 event handling
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-12-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-12-ilpo.jarvinen@linux.intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1093cd1-8335-4ddc-f98f-08dbf05f77eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PD2MP2KMlWUSfr3LwveusPMupEtXqHL4tLMIGaBXDcw2vk7LjkidXvvlFEG8mQp2QAhGGXxGVD1JXzZHW9c+MlZZiJDJ9CXZp4p1EfEiMmGxVVrTn/0/xVqJ4qRMxGsUThQ7jOl6wPtz4mcjxiP19TNIQQjj0e6CL5lxQj8/7Ww0PW12oMGQ/8glWUj7a1hF+WgmeQzZntxlJRuHN33UEZS2zGTyokoazJmajFYjfelN5Lj4ehOZs8jcPlKdV574nTFkxKF4H03hE1X2mC3gl4jmI4AQcF5S4XWkHZJDweiVTAmXvFkAHaL5gciLHfEIZc+29SV/wEm5HwRQKzaqtwRko4ikD7a9xxCycv2/H60JR/BZudkueJaCKABks+NT6c0uI+QeA7rB+ZIY9heN/rga7pFZkaw8lxFLonSUtxLBO4cXdk8ro9qXZWF0Xn3wfPaK0XGVAjX4yAn4+T1bFOGD90dXL9O/OEVXZJtSy3c6Gyx0FYVErSwqrbTCqeV2woUJqEQYdRRn8iWUnsV3dyPaWDJZKR/jCgJV9r1zDTULySaa7xooyLFh1Nl3q/bo9F93IWMuwA6OqbaZ4N8jRRVhqisChXqhNjY5l9MOSmpGs6E0+Uim6Fl8mhX/8ftAxK/hzrOv5d3Na54IR5MH8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(41300700001)(36756003)(31686004)(4744005)(5660300002)(82960400001)(26005)(86362001)(2616005)(2906002)(44832011)(6512007)(6506007)(53546011)(8936002)(4326008)(31696002)(8676002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(110136005)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFJNejR3OWFFQm9QQjRjRVF0WkFCYmNOb2YwZVA2WHBvbjQzNDZvNzJ3c09a?=
 =?utf-8?B?d0svMEdpY2Y3aENnSDI3eWVMR3p0YkhINExSVTlSWWRwbFl4eTZGd1haY0NN?=
 =?utf-8?B?V2l1OHVnbWlZL2xFQnUxcjVqSlFiZERBbXk4WEk2VDNDRnRjSDFQbW1Jdm5S?=
 =?utf-8?B?TjZRalJsVGpqVmxsdmhnd05MN0xTTkowekFlSUp1STkrdFdKTkVlNUlBejJ3?=
 =?utf-8?B?ck8xWU9TczQxTmM2NWJLRHVlOGFOV3NuUEZqUXhCODJhcEx4am5sM0lJSlI4?=
 =?utf-8?B?U0tMdTByNDlQSU5EZlZwQXRYVlE5RWoxNUQ0K0Jnc2RDc1owTEUzWEJITEhY?=
 =?utf-8?B?bVExRExKbTRBc29Fb3NROTNyMnhLV0Z4OFdraTR3blE5enMyTi8rQ2ZWTmRj?=
 =?utf-8?B?K1paampqSW5WQ2Z6NGc2Tm5aOSt2MG1OLzJGd1JvOFh5djhoVUZFMFVZRUc3?=
 =?utf-8?B?SFU0bjFqdkZNR3YyNVM5OFBKQ3F0K294SG1zbEtORXVJTnJyTTkyRWgrMHhx?=
 =?utf-8?B?TUFSVkw3MU9WWFZ1eXZJZnlSaFp0dGxSWTZUWFlzL2tYeTNHblNDYTkrVjJo?=
 =?utf-8?B?ZUNycU9SOTU0OEdpRnNyQUtEdStkV3pVNTkrMHNHNzFkcFpYVWJEcjRRbGtx?=
 =?utf-8?B?b1E3REF0Z1dCR0NTNndSalZQaS83aE1FWGRHSnVJNkVDVnRUbUNlMDVnbDlO?=
 =?utf-8?B?SUtmNzVJenl5RmVoMjBSVUtNaWxYOG9wYi95QkovY2Q4VnJJL1NhcFlNRmRH?=
 =?utf-8?B?VmtSaGZQdUZFK2pJeUdJUjRiM3YxTDljcWN3T3RkTWNYZ29GajN2ZzhHQWQw?=
 =?utf-8?B?Q043aU1SUkMxNHBsWU5XNThjZVVFb3plWEpuT09RK0NNRG1SaVVMNmt4bEQ2?=
 =?utf-8?B?Q0E4VUNQSVNTNFo0WjFZSlJUK2Y4RlNzbHoyZ25saGlaZGM3eGJSdi9DKzVx?=
 =?utf-8?B?ODZxMHQ3U2duVUxWaWdOZzlTdXRHSDZjcGh0S0ZOYmMyZ3BhdmRFUWNrY1ZE?=
 =?utf-8?B?eFR2V1lTS2lYSnFNTnFPYkN4eitTUnkxYWhSTFZ3dXdtVFZNWXhHWGtRa2th?=
 =?utf-8?B?dkNtQjU4RW5STWRod1hmMXpneG1IbVR1Vytkc1pPOFlYSG5BbHhldXVKaTlK?=
 =?utf-8?B?UWlYeTM1U0FnTURVOWU2YU5xc2twbk9DamVzbjB4dFlxbHQ3eGRMRUQ0bUZC?=
 =?utf-8?B?WGhVWE9MUHRjQkN4STlmMEZ0QVdCcVZsQTNQVi9kRURlejg5TVBHdndjM01i?=
 =?utf-8?B?R1BPNXJBSjFndTgvbzlxdVhTZUc5Kzlzb2JteDdDbVFqUW9QQy9vTFNhV2Q2?=
 =?utf-8?B?N3FrdkdlN0N6M1FROWlCSXIrNUZzRGZ4ZzBYM2lZQ2Y5N01oaVpyU1BDVWM5?=
 =?utf-8?B?L3pWaW9QM3pSUTdKb1lyMWJBZGhOUlZ2bmw4a3dud2hqNDZjVmRVVkNDanNa?=
 =?utf-8?B?Qm84RmNKSS9iTFFZa3FENlF5c0ROZ0hpYVY5VUlGMmd0ODNvUkZIbmF3VFV0?=
 =?utf-8?B?REttdzExRXQwVHgwOXpWZSs0a3VYdVBPZ2VZU3hDQjZUbjNZSWc0OVByZmxC?=
 =?utf-8?B?ZFlMa3lNeEovOWY0a1MzNHJJU1ZwZGM5dEVWUzlPMzFld21pVERuZWlUNGYv?=
 =?utf-8?B?WEp2RFRrT3pvdk9IaDFuYzZQTjlKcVlNZXF1cEdBeFRoVzJpcFE4citvNThu?=
 =?utf-8?B?VENoa1B2dHduWDQ5SUtFNk9LMGdqTENnK1FUTjZuVG9LK1Y0SG9hd2RWOE13?=
 =?utf-8?B?Y1FucjJITktoVkdjWVVvUTI2bW93b1h3S0NSL0QxMGVsd3FaaDBxL2JZRU44?=
 =?utf-8?B?aXVNajBBRUkxVXRUY0NnZlZGZHc3N2NtTnNjTzg0SS9DSHpYT1VsRSszSEFG?=
 =?utf-8?B?K3ZLaXd1bms3Z1BmTkREYXc4bm05VVlvT3hnRm5jNGJTZ3dJcmdPby92MHhx?=
 =?utf-8?B?S1pRdFZPZHBWT0FpZkNZNWprajNpVG10U1ROUUdlZEI4MkJrdFBBQWVNMDZC?=
 =?utf-8?B?Zys5T216ZlRFeWFJcWtlQkZCTXZUU1RJcFFXNkhqbTcrU1JPN3FQd0Jtd3Bt?=
 =?utf-8?B?WXpGa29KTzNXZVpIY2pTWHRFeUh5RCtnTElQUnZmMFhDQ2IzQ21RZkpTMVV6?=
 =?utf-8?B?UEYxVTdhVnRxZDU1QndmMVQyMERzSllIdVBRamszalhNWGlRNjhuK0JHL3FX?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1093cd1-8335-4ddc-f98f-08dbf05f77eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:15:02.8687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZqRpuEiGpzcm3nXK7aBeLaMOqbNsDMDErndg5jBUedcT7+41nIaJyhR8Rayl/VDYayw4Gg3IiumuZeYa1fnvE7/QmQe/4xzt6dI/NnoP3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8024
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> Perf event handling has functions that are the sole caller of another
> perf event handling related function:
>   - reset_enable_llc_perf() calls perf_event_open_llc_miss()
>   - perf_event_measure() calls get_llc_perf()
> 
> Remove the extra layer of calls to make the code easier to follow by
> moving the code into the calling function.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

