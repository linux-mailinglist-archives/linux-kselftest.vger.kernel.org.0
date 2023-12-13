Return-Path: <linux-kselftest+bounces-1870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06711812107
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 22:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826182823A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 21:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9353D7FBB8;
	Wed, 13 Dec 2023 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dubfUCRh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AADE3;
	Wed, 13 Dec 2023 13:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702504602; x=1734040602;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cKv0Owwjn3zISIXgMMNF30/vML8zg5euHQHZcF9qPxk=;
  b=dubfUCRhLAXMK7gPWo65rx4DCfqin9efT2laKyFeFv9ZEvNrdzoMWzPB
   uMScZ//sTTiUuYkJhLsSNZwipXsSQrfzmLbG4FZHZpJH+FjPLi9vFffqh
   Wq8jvY4TGITwlsk20tCVlniig8LVRoT6R2Wt4yl6avO3BHVbOKo2jio6x
   Uc9x42J+RXsHUs0JZVroJwsJZuY6S6cykwtKuIyXcB/WFBKUW6Wlf1/rj
   iVCDEwBA84RfBfV0p7WLWD4+0OfyU0IW8h7aqx8/l2qAfC0g6+cAdGpGd
   C2fHHnIT4x5SNZXgTK41+pW60DsttpBqNi2mJzKr824qKiqLStoVfAu/m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="16582811"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="16582811"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:56:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774096093"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="774096093"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 13:56:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:56:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 13:56:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 13:56:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 13:56:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mdylkj6mcV0UjspvFwjxj9NCbchHurEeMIKsSFBid2H1EpgJ9oWKAqwsIbE4eSrsMjbJKmRSk5h9GqkKKZD0/KF1QM1RMPVp11f9OIu/1UJsMO/XcAlIxIUqVUv65VfuLAQTeYxpcK7p76hG/Z4Oz0Azx6GFzqvkhNiAzJ3tsXG1LSX/irDmyiL8uF855ACAKLEY5vTuGTh6BcBuHopnZGRuK7arPAUGlpgSjmm++7U5psIZommOzgQXMNud/VOXlqcoWQ/ywG1L08cGh9YPr5ID7aolzXR/JMRNjDpzPkccrE9d9MqAJmumkln5kzLGI6WnU6YaaMFv9HUeXJxUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5cykyTdCqg1vZvwOn0QFcDsAGfMoir6oovVLFBrNs8=;
 b=d/AoRek96SJT/xq0fZ5IdHNuOK9ifrDwlMYbjCBl1fmdjcE7pQa+2dyAJcXRizVIUYPUeGJ2HnkLoe+9/yMGhKO0GLd33uuVA8lfeDfPRKExqEi0rXWYMYHx9YKQH+H1aHcKkAl52XQi+aicOoPFg0BzlumYgx52hJcnP//Jst6gP2R10lgm5WE2Lhtiw5vrR42WupRDrgyKLTBSDpu9KoVi7wjzsfFvLdEDF1/YqDaoLURs1knapNTEG/QDNLH1zLYcFlIgrs/UWt9IMJ+qQMIYMhsHfG61IDurDvmTIyeYfgXFt6d0r3by37ld4/zGz6zZXvSsNQoGXG2LAGeKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 21:56:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 13 Dec 2023
 21:56:33 +0000
Message-ID: <40574201-9f54-4da5-9d58-0b080c8c7b5b@intel.com>
Date: Wed, 13 Dec 2023 13:56:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/29] selftests/resctrl: Split measure_cache_vals()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-12-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231211121826.14392-12-ilpo.jarvinen@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c51045-b1bc-408a-e33d-08dbfc265e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWUfJyzpodGBNnAVdJiAUv2EDUiiOkEbka/fD/TaMthjtQGImsd7ahOlvYnVRnYxUvRkeyFm+40Y613yKwo4+z3CJ5OfE8PE4dMjlMWOSmiLkDd0NG3/ltdysQ6RkGGKpDVI88bAfUlE2jJcwX41+iXKHRSEJj4QoVjMzMDajR8cvDX8y31rVN7iY04C8PO9vfpiy82ve7NSgzPh0jR4LrUnHLQu5aluUxDnwl0Vt8221moyLtli3xPYcQ/OehqZT41IDbhqd3rPm/25F4Mz8FO7y4AncaxbP2nGBXle45busX/qyQyLe9eGJ37xwNDtPS4BcsoH7uvhs+o7z8Kj0n67klBli7Mnh6QlwBT7Pe86NkQ7L1EIi6JW3PI4KdOSCycfA6ijPeDJ8URVrSIuHUA7Dz8jYiwSYNAc1EXgavcdh3aPFfx3ZLcIG7oEy/rxAyEtFmlGI9jabJ+h/TdL7zl7mDEtHyBv5hlTNha1mcXGhdpF3EG18eouZHmuLeSwEaa2CpWMrQmcGXxSTMtk+bwmboqj89nD+o/L1AppdqDK+bL/FSBDoK6J8ivMfVW5wc9ot3tLBOmtSSWT+FiOPMhrof+/n4I/a94xt8iNiC5UAHLBIHgISR+RFZh/vfJDnWe5XOnZyjvvpxUQUGuKuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(2616005)(53546011)(31696002)(86362001)(82960400001)(36756003)(38100700002)(4326008)(5660300002)(6512007)(6506007)(316002)(6636002)(478600001)(66946007)(66556008)(66476007)(110136005)(41300700001)(44832011)(8936002)(8676002)(6486002)(2906002)(26005)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC9IbFY2V0lxZ2QwM1MvazF4Z3hlRGRzY2pNZmRlUUdtODRUdWErSm9IVERM?=
 =?utf-8?B?ZU0rR2JZQ0VjMWV6TUFKTW9LcERrbzVYdnZIRkwxbW5iWmEyTkpYT1orUU4w?=
 =?utf-8?B?MVc1Yko5Yk05cGFjdlVhT1hBc3FWbGpLempKWkxrTmROb2txZzMvaHI1a1h6?=
 =?utf-8?B?RmJZZFYrc0VPYUh1SlphUS9seDI3cjI2WHBEU2VITzBmY2IwSURVZER2VFFJ?=
 =?utf-8?B?OWxpdU4rMlV5ckMyMWZrbkEzcm1VWkFBYk5hNlM3RkhodTdheWpTQ0had2Mr?=
 =?utf-8?B?ckQ0VXd5M1hUa1ZKZXdFZzN1eXB1K0xUM3h5eTVvZHBJOUczb2wwZ1ZXVitr?=
 =?utf-8?B?TnpYT3c1SkY0YjNuYmNTYmpMaEdiZVdDYVR3RVM0RnRzRHdLc21LWjNJUUE1?=
 =?utf-8?B?Q0pXK2dkbFpkYjc3RW9NYW0xNGdWZXRCR2ZwcUhZeUt5NldpTFJLR1E2VzdU?=
 =?utf-8?B?ODJrVXVhT1puVDNEZ2xBZ1R4V0dMMTNBb0pLcCtDcUxYYzdLM1I0QjdRK0lI?=
 =?utf-8?B?ZGVOclBjd2g5ZVEvS1R4b0lxSW80cTFuaEdtcjVsdkhwdjMwWUtJRTBNZlNO?=
 =?utf-8?B?aVF4ckFBOWF2eEN2NEpCb3VBbzYwZGVnMCtwZXNWY2lrNE01VVhtZFBWb09F?=
 =?utf-8?B?di9YNjkxejd4aVVLMExXTGY3T01KNlRUTnpHa0VnbE9hakRTVjZRb0JKd0Rr?=
 =?utf-8?B?djVaNUtYelB2R21mTldoMlhtcGl0b0p3aE5GY1JocW1ERmZpV1BiaWVQVDh3?=
 =?utf-8?B?dG1HUWp0MTUzMUNpd3JZNHpneXdrRFFpV2FRRmkybEsxbjEzekxRdVRqRS9L?=
 =?utf-8?B?T2F1dzBZcG9BQVdTeVE5dzhGeCtRWHlZWXFPUjZXeUxoUVVkMkRMM3p0eXJj?=
 =?utf-8?B?ZHliejlncGdRcmxTZGZIR28wQ0tpWEk1Q05icmFUSFZneHc2eUtSYW0rblFX?=
 =?utf-8?B?RktURnRnTndzNzBWbG9FQnNRZ3RnUU9zKzBiWFJSYkZMeVA3eDFjNmRPaFRp?=
 =?utf-8?B?VEttbTI4NU5CUEs5L1dzZEFlOWpDZGNWTFdkY2tpa29jV2NEWTBUaUtmMUZy?=
 =?utf-8?B?SlJnMkJMdnFxUEFNL29wcjZ3WmJLeHZOQzFWYlFwaVZPMStiNmNpQXhIWU1G?=
 =?utf-8?B?a1BxU3N0M3lDY0Z2SlMwRWxoODV6R0xjbU5acERYNmhYL0RJVksrMTNpZ05j?=
 =?utf-8?B?cFpEYTVDWEZIVmNNcENRb1dYRzdSaUdOazloV0NjdEp0SmlnbmN6b3FhbEtZ?=
 =?utf-8?B?TUdBbzVUc1dWM2ZRelpoWjN6N1MzYTJ3emFnSUVQVVRUeXE2SzFwZFczdGN0?=
 =?utf-8?B?MWNZa2ExeTAxNnozdTF2TzQ5OFdiMGpQZTMveXN3SUloWS9jeWhiSnV5Q2Ev?=
 =?utf-8?B?TFQxV1NaamNDSld2WkN3YmJyNkl6dnJhampXcVN1OUZ5TE1UenF4V1lIUm56?=
 =?utf-8?B?bnlrRGg3eDZGNzZhbWp0L2wzTGNxdW5QajgvbTMzaHA0UmVzRVFXRWovd25v?=
 =?utf-8?B?TlpnMkdSOHIrdjBqcW4zM1pnSHN5WVJJZFRyZ3l2VVJ2ODdiUXp6TDduYWJU?=
 =?utf-8?B?Y09QSk5iZDByd3FPUDlST0E1OENEaVQzSmw4cUVaUXBBT3o2U0cxcWhIOU1n?=
 =?utf-8?B?VWRCZ3pNaU1JSGtwR001cFpmYnlKZlNhMFdaZE1HMUxVMXRCNnR3ZjVzL1JD?=
 =?utf-8?B?MnNTOFQ5eUVoMGVoTWVCSnFMMkFGZUF2bDRtTjRSS3pMUnJXd3diQjZaK0hN?=
 =?utf-8?B?ZHhiTzdkUGNDdjM4eW5PQjBDRW5Fb0VIWFZ0SjFucjFrWGVqTFNQMXRoNEpZ?=
 =?utf-8?B?Q3JUcnVpcnk3ZWQ0ZWNlYW80aXJ4ekpONE1uNHhGOGRVZitRQUlra2FtSlAv?=
 =?utf-8?B?K1dUY1hmVW5YQWY0cjhXdDlYSm9XdUQxenVLYzdxTmhVaWUxc1p4RTYxUXIz?=
 =?utf-8?B?UFpPMkNpTzJ0TUhDeUxpd2J0R01meCt5TG9tNmM2UXZCQVFwMFB6M3hiUk9Q?=
 =?utf-8?B?TEt6YzRwOTVhRGJwUUFtckx5REUyKzRVMFVHanVwVE5HSDNJZEw5NDQydmFp?=
 =?utf-8?B?NEFDUEltTGpPaUtNek93Ry9xNVAvbkM3Q05Hbm1oSW80bUtNTnBqeXhMREpD?=
 =?utf-8?B?VllESE9qMkRWUjQzR1JINVU1dWlCZy8wb2RwekpRK0E1bytzNDd2eHFXZ1Nn?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c51045-b1bc-408a-e33d-08dbfc265e8b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:56:32.9728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7GK9/UqSHhuVInhea0xw+460PGlWsvbOSGl8uTQ9I5bahSeKf/B7MfzQ5B0fjz2C3MRhV3KVTbDCv+yTm1Ylvwu4/q9jhaK/q6ima6u/6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/11/2023 4:18 AM, Ilpo Järvinen wrote:
> measure_cache_vals() does a different thing depending on the test case
> that called it:
>   - For CAT, it measures LLC misses through perf.
>   - For CMT, it measures LLC occupancy through resctrl.
> 
> Split these two functionalities into own functions the CAT and CMT
> tests can call directly. Replace passing the struct resctrl_val_param
> parameter with the filename because it's more generic and all those
> functions need out of resctrl_val.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

