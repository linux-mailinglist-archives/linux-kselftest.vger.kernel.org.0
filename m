Return-Path: <linux-kselftest+bounces-11322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 492178FF85A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 01:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BE01F22774
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 23:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F113E05C;
	Thu,  6 Jun 2024 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAjRbokS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49C8821;
	Thu,  6 Jun 2024 23:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717718334; cv=fail; b=Y1dx5aYl1wzbDyxwzuZ4kE0Qli4y2ti8cCbMmHaWBtjrAUen6pPmdgBuIhDBArlsiZxq4X6csTPfrvorfQG791ZXgN0ktnPUQaUcNDR6EgFBzhNyUwpvMgiUnPzHh6g8pYqW7oYokihKtg2l6iApw3vY06Ej0bOGY5sbewdVB9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717718334; c=relaxed/simple;
	bh=5/sTRA2N3gTXEOQhfXPcMfp2yd7P9iI/rasMcUmF9z0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZXRefA+eZvDtChubfAQOnshftR5tm5NTZk1arYPxEIPo1ILiqHBDB5SVz+q03Jpmok6EppfMSdV0tM6t5w+9kVQ7wl9bS+ghlkJ8+6e6iPDluvXMgV1NTSL0utGrTmvWCd0k0OilXQQi9xSTe4IPgAyGJtUwvWLtw4ae1Jxxic0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAjRbokS; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717718332; x=1749254332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5/sTRA2N3gTXEOQhfXPcMfp2yd7P9iI/rasMcUmF9z0=;
  b=TAjRbokSgTzql9fiRQQuNxpq3qzxgKfTBu7KOoy0JgX/v7pxgblskrWs
   q6O0FQNW1xmW9q3kINzt8gkZAukXaojd52qnu5h5NlnDHjGbKHPslY3b+
   ghc8cDykS8M8M+l27qtQMaNTh/rMVttVerNO+buYQz8BvNf3ZF7zZKKQc
   +jspdI82tBQO6jqcJWGdfjdd2sufTF5BTPhxuTYG+qzNJpaRQMyaiexOL
   TfkjWqPG1mII4zrintTNzScUqDo7aKojqd6NvytWRwdR7tAjkPgqFshIc
   Ox6vZK/8xZ6pQPS2f2vY0LwDZ2aE6+wVR0qwZzICq2Siozf8fnTLvBGTH
   w==;
X-CSE-ConnectionGUID: 9XGkF7ZJQnKVvj7uUCEtrg==
X-CSE-MsgGUID: 1OUTs8eZRYOQPkDUCgbUHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25050782"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25050782"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 16:58:50 -0700
X-CSE-ConnectionGUID: ILGIJdVnRMWBJ7GdHzwLBg==
X-CSE-MsgGUID: 0lscCQSlTjOVkC1nIblNDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="75618266"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 16:58:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 16:58:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 16:58:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 16:58:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 16:58:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYZjdcQs79+ivjsQMC9J3aX2h8O42ULsWKLO+j2n/4/lSkY91IzrJWVME+PcWE4WcVx1ENRNcr/Fg0e6lqw62cQVsWTkwwKLRYnsxDlgit5zd3jEiRPylQS956UT8NPDZH10vrR+3DtrJga5VER/W2uj0FScUW+3vSnRUK8qcBAkZ0WDOctvEpql7ynfs7TUHCu3UCX94SPjRb0PDkD/vLpBC8yQ107C/2vTVxzgYaMN7CJ80e9ROmue+XSGgzGhvbDxeW1pL24uR8FRmJgIAzbSzwTxyp+hqRxqt/naH0Ss3YaY8/Zcv1XENUkzTWCcIICSxxpKqaKPLHBdPjboQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+L/z5A40oSA0TgRPvaiDAE76tIOlsBiYUaA6u1Nw4HE=;
 b=WpZh2Q+bKr7GQScl+hrrYqUd11ticinVP+mhZ1p0ZI0BVjxFfk1BjVCZZM7RbLdE8vZ8QTFDOOhzVyyRWE0DpiyQeHd7vtGN+V6WmOn+sflOHATkDCWhot8WdMU8bLfgYMuwTlkdjDrajeY8CkHwR2cRT2AqGpQG2NreycXWlnu14g2ZgRQWBzATUch20lQqMwvk1QMZU8Sz4Mv50r5VdxzoWghwosFoRfLK3ri3UDTYw6M6ORhqHkv6hLIhIpimeysC/qdpwdqAbZe1dg5MJW1iMMGeKsQWreko+u+pgfrdAk4I5lQ+M28l5PbCAjdeNQ3Wq3UZF22yeer9b0zoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB8098.namprd11.prod.outlook.com (2603:10b6:208:44b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 23:58:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Thu, 6 Jun 2024
 23:58:36 +0000
Message-ID: <8553ddc2-ee0f-447d-8fe4-5a7dd84375f2@intel.com>
Date: Thu, 6 Jun 2024 16:58:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/resctrl: Fix noncont_cat_run_test for AMD
To: <babu.moger@amd.com>, <fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <9a7213d2-a782-4342-93f2-acf191c745fd@intel.com>
 <3bd755d7-e5c7-3dc3-9875-4884c857e325@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3bd755d7-e5c7-3dc3-9875-4884c857e325@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0271.namprd04.prod.outlook.com
 (2603:10b6:303:89::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: b12ccc43-ec4d-493b-2b7b-08dc86849455
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXJVQ2htSVUzMzJHZEVoNU53Yi9WWGZCOW9BS0FlaTdKMWpVbWQvN1FWZEpW?=
 =?utf-8?B?bmcwcXltK0pUd1BDcmpTOWx6K1FDZlYzMXhqajE1WVBCRVVxSTZSTFBVMTBY?=
 =?utf-8?B?bHJsVGkzYnRPWk1wdkU4SDJ4RUZuZzFENWp4QldHclQraFE3TExNMmhJYXdr?=
 =?utf-8?B?WlFYcnk0N0JicDExWEVlVE9ZaEUzUkxmU2pEajhVWDFab2U4WmdyVVg0MFB2?=
 =?utf-8?B?V241NW82UkZ1eGF2VFpKQ1lhZUYwK1VRdm9DVUlHQ0RvTjRjYnAyNGhCTndu?=
 =?utf-8?B?ekVKMitYdEpFaEdwQ2ZMNmJFZ3pBN3lmUmx3SUVnYXVzTCtmd28zOWVIRHNh?=
 =?utf-8?B?ZWtFOTB3VmRSajhqNjBCb21TZ0g0OURhcFBsMDNlaGN2c2FQQUtZL0lld1F4?=
 =?utf-8?B?OW14THM4eU91M2FGMGgza3RTYUpOdk1QU0lndWMxamtpY091ZXMxMUF0TE1F?=
 =?utf-8?B?YnFxeXlpNERSYTdDQW02dUZmdHA5SWg3cktPOVJobHA5VEludytsOTVOell2?=
 =?utf-8?B?MGVMZXB2dkVsMlFDbS8xdmd0MTR0SXBFNVYxWExqM1VtQzdmb0plSXEreCtP?=
 =?utf-8?B?dkJGVkNhWGE1cDVBTGFheld4K21SdHJHL0YzT3VNdVRkaEVqMmpKWGRWbHk0?=
 =?utf-8?B?NjdocWdlOHFlZ0g5bFJIK1ljZExHRlRrUmdUVnd5YjcrNVVIYndBdjlBcEow?=
 =?utf-8?B?OXlRZjg3Yk55UmZIWi8rbzFxbXhMYWY0cUFKcCsyMDJDSXc2VEh5MWV2UzY2?=
 =?utf-8?B?QkhCYWFOQzhFVXBxcEI4TFQ1d3l3dHorRlZmZ2ppcTR1bDRBYktmTVpGNkt4?=
 =?utf-8?B?aGxEam1MK3VnNGkvenpOa0RuOXRlVDhIK0tzV28xODNQVk5aWC9uS0FTeGhp?=
 =?utf-8?B?SHc5dlNOU0huNzFPVlNkdzVaQW9ucWx6SjFrOVQxR3ZOUmVwVHlWd1JUZzR2?=
 =?utf-8?B?NkpyUmMySjhyc08zV3g3cUVBcnpvQmsyTGoyNHkxZHVxaFNNTmphelFXSzRS?=
 =?utf-8?B?RGpoUUFSK3NXVVNHRW9KZlNwWW1JMUh4NlZ2a2pBeFgrYjkweDY0ZVVpRHE1?=
 =?utf-8?B?UU9RbDdyc2tPazFZeFFDNzl2a0lEMzhlblNSY1p3MFdTdUhJTTFNelBxR3J3?=
 =?utf-8?B?Zk1jZWVDU3NNaWhMcndZQWNtQkVsMjMvUENxOWR3UDFoZkszdUt1UU80R2to?=
 =?utf-8?B?R1c3cXdJZ1lETHpqbTZJUkt5b0gwU3VTWnhrcytDNjA3OEgwVG5yK3dPZGVQ?=
 =?utf-8?B?aFB4UFU3WjFwNDE5OU5nTzU3NVpHMno1S1lrWGVkdDJlYmtwaTJrN2NtY3Bs?=
 =?utf-8?B?MGdqMWN4TTdYcWVHYzd4UUVrRk5wTllSVmhKeWxIbitkTy93Y1NVaHRMalJl?=
 =?utf-8?B?MFEzV1k0N3BnWkJEU2FjTFd1eWNrUThwSU1vR1FWWGJvTTMyQS92ODlEcTlR?=
 =?utf-8?B?cGdsb1hhZ0EzTlJRdUlpalJMbGdENncvNGhTb0Z5YTFNdDJWUjVxakhmM1dN?=
 =?utf-8?B?a01WSnRZUFdGUTM2bmxlTHVtaDRqY3F0dmFTb3hCOEZlcGNoSkZLbGJvZkg0?=
 =?utf-8?B?dEdLdDE5UWlxWVZrSG5SWkNESjNvSkpadkNRY04rUFRvV1hiQmM2VlpDRmRr?=
 =?utf-8?B?Wk13VTFPbEVwVUZGc2JiRk4wK3VZNFAxcTdDZDdSMkJWQTdGRFJhbnZvakIy?=
 =?utf-8?B?OWFWZWd2MHlLNThSK3FOcE9WVy9oV3R1YXFxbWZjM2NQR1VRZXJDaGdUVlZi?=
 =?utf-8?Q?vOxg1pPUvvH3ViGhY8hCy6L3nny+irYZyvxff1Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2dyVmxwRFd4UDNtM1hJRHltN3NuS1B3ZXluTmxHSC9pQ3pJTmpzbDhHYjhG?=
 =?utf-8?B?eERESWM5WWhEaktzSjExblh2Q3NiWTNaWk5kWWhVeFJMbDMzK1RkUXBMcDlJ?=
 =?utf-8?B?MThUMEl0azNEeWlzVWF1ZFhaQ1liQlFXQjhFdERIWGNNa21pdmJzQmZkeWxT?=
 =?utf-8?B?ekVDc1RQZkVwaHdNMC9iWEljMDdBeFVSUEN4cDd3TWtkbmxac243VXFBNVJC?=
 =?utf-8?B?ZzhRL3JLUXUxcjNjbi9MRStZaFNjNFVlRGlGYXJWcVEzYWVvcTNldXcxdUJ6?=
 =?utf-8?B?TVd2SWczQUhzYXdZZmJEU2lTeHUxNENaenhIWlczTmxJeEVOeDUwU1RERE8z?=
 =?utf-8?B?Z21ZTndVVnMvVFlRYUtNWS9oaHZQc2gvZkp3ekhoeEl5WUd5QUhIWGV5QjAz?=
 =?utf-8?B?Ukh5ZG5YUkNXd2I2S1NCcndseEJLQjk3M3kyaG1EWk1JQWRYdU9HWm9GYUdC?=
 =?utf-8?B?aDlUOXhGdUVDRnNCaHZKU2hQL0IyckxrdWVVTTRFYzZMdngyREVGY01wZGUr?=
 =?utf-8?B?a01pazN6SVVWNGNoSzVJTWM1dGRJWGN3OTdWL3Vnc0w2TE5zTGswblczZll6?=
 =?utf-8?B?L2dPUHNJdDk0d1lDd1FGcGlJbWZ0L0VlWENETlVJS3k1TTJMQjBVUEdrdGxF?=
 =?utf-8?B?aHFobklGdXJ4eDFmeXRTZ3ZOY2txZDNRY0k5NnNDUlBqbG04cFZtWHNodHBk?=
 =?utf-8?B?OVdDWENITG9ZU0lvQTJaKzBPeDZlTHhFakx1WllJbWRaR0o3STNUUXJkcStM?=
 =?utf-8?B?eTNsS2xhSDhmT0hrSHRqdEpxV215Sm1WRzR0N2Y2c2tNTkJzVmFsNmxvZjVP?=
 =?utf-8?B?ek1RcVFoWW1ScEEwWEpXZUhKc0E3N00wemlOYXZibGMzNGxBODBJQWtheE41?=
 =?utf-8?B?MVF2d2c3ei9VbWh0UE85Y3dxa3FFMWpGUkJVY1NwL3lwYmp1QkxsVmpUWHIw?=
 =?utf-8?B?cmRTM0VsZUQ1bjg4c244NUdOOEhkcmc0QWJKRUNZRlJjOTZaU1BHRHB6S0p5?=
 =?utf-8?B?OUJSZzROTXNIV1BNdktrTE9QbEJHeXNqa0JORGZ6QkNSc2dBSkJlbW4zbDJN?=
 =?utf-8?B?dlhVR29rVGVCV2pzQlEzUUNzelIydkN0KzdhRVZiTkVGazFwVGRWM1VvQnhQ?=
 =?utf-8?B?MkdNZVVLWk9XbEVub0toaXhHQnEyRk1FSjhRbC9uYWhXT3FuRmY4aDg1eVBs?=
 =?utf-8?B?dytMY3VOT25sUjRQL1MwOE10L0h2WllIZmI2QXF3SEtGY2V1a1oybloxM1F0?=
 =?utf-8?B?OHdJd01CSkd5R2Iwd1A5M1ppL1RTUnl0NGJEM08yaXFwbG5RaFBtMmt0YjYx?=
 =?utf-8?B?aWZBLzN0dVpnTkdyVXFEQ2VQQjIzQk1xWTdTOHdiWU5Jb2ZkMnVWanZtcG5q?=
 =?utf-8?B?R1dGbjZJTnRCc1B4VGlvd2p0R3g4b0lrU3lpR1ZJQkhNTGhhOFlFaU5wZjlp?=
 =?utf-8?B?bGdLMzRIUHZvTnp2VE4yRFRmYmhlZ3dSekZQcXMrMGxPZzdXZG9lWXpaVTQv?=
 =?utf-8?B?MStnaDZ2WWhIS0x4S1ZsQ0duZ3lvQ2FzRDJxUmlJU2p3TjlEbDVneVluTDNF?=
 =?utf-8?B?QXhmWGE3dEtET1dGZTJLNjhmOUtVbkd3VDJ3Um13YVJ1RVVGTXVDMGJGaGw1?=
 =?utf-8?B?YTNLempUMWp4NlFVcXNlVHVWT0FOKzJGMENUL2pEZjN3MjI2cHN4NTZBMU5V?=
 =?utf-8?B?L3Q1R3NMUDdwUDhJd0tNdDFqVTRpdTF1WGR1MnNLeHRoQldkZ1IvU2N0bm5O?=
 =?utf-8?B?ZGtGb09RcllWNVBXUjVsNmlTcDB3d3lYK1dJbm4vL3dsMXZmNGJRT1h4bW8x?=
 =?utf-8?B?bFVrTCtiNnJmMS9qTkUrU3ZZd1ZtT2hWZGU1NXUzZ1owSmRvVGcrdkFNNSth?=
 =?utf-8?B?N1VUcnVBdkNJTXp4N3E0RXJEcVo3OEVKbTQyeWZyekp6cHU2VUU0Q1BOaGlw?=
 =?utf-8?B?RWRUcDd0R3pTUjZmU0dZYmJjZXUwRDRjakhhaW9Yc2FLUzQyNGJiUURIdm9p?=
 =?utf-8?B?Sy9pZEVyTnVObVArWHB3cVBuUlpva0ltak1JdklmSm1qTTFiNnIyTmxFMUVn?=
 =?utf-8?B?bGlBMmxNUm0yRmx5R243eXp4STBNWHVSU25BZHJnU2VFUDNzUEZscU9DVGpN?=
 =?utf-8?B?bm5YOERmMUNWSXM5dnZ1bkpndmhsYXBiM2tmNGE1amVwOUVJRWZ3a2dkZlVV?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b12ccc43-ec4d-493b-2b7b-08dc86849455
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 23:58:36.3241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umj8PD7ETOln4OPF/PMQ27fpJgAuTyjVHIJBtmI9pK8ej5W7XsxbtVrMO27ZyYcOqB2CPFR9U3i+aAPgqcMQUAWeGYguiikjRtTZ0fv43fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8098
X-OriginatorOrg: intel.com

Hi Babu,

On 6/6/24 4:09 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> 
> On 6/6/2024 3:33 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 6/5/24 2:36 PM, Babu Moger wrote:
>>> The selftest noncont_cat_run_test fails on AMD with the warnings. Reason
>>> is, AMD supports non contiguous CBM masks but does not report it via CPUID.
>>>
>>> Update noncont_cat_run_test to check for the vendor when verifying CPUID.
>>>
>>> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>> This was part of the series
>>> https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
>>> Sending this as a separate fix per review comments.
>>> ---
>>>   tools/testing/selftests/resctrl/cat_test.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>> index d4dffc934bc3..b2988888786e 100644
>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>> @@ -308,7 +308,7 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
>>>       else
>>>           return -EINVAL;
>>> -    if (sparse_masks != ((ecx >> 3) & 1)) {
>>> +    if ((get_vendor() == ARCH_INTEL) && sparse_masks != ((ecx >> 3) & 1)) {
>>>           ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
>>>           return 1;
>>>       }
>>
>> Since AMD does not report this support via CPUID it does not seem
>> appropriate to use CPUID at all on AMD when doing the hardware check.
>> I think the above check makes it difficult to understand what is different
>> on AMD.
>>
>> What if instead there is a new function, for example,
>> "static bool arch_supports_noncont_cat(const struct resctrl_test *test)"
>> that returns true if the hardware supports non-contiguous CBM?
> 
> Sure.
> 
>>
>> The vendor check can be in there to make it obvious what is going on:
>>
>>      /* AMD always supports non-contiguous CBM. */
>>      if (get_vendor() == AMD)
>>          return true;
>>
>>      /* CPUID check for Intel here. */
>>
>> The "sparse_masks" from kernel can then be checked against
>> hardware support with an appropriate (no mention of CPUID)
>> error message if this fails.
>>
> 
> Something like this?
> 
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index d4dffc934bc3..b75d220f29f6 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -288,11 +288,30 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>          return ret;
>   }
> 
> +static bool arch_supports_noncont_cat(const struct resctrl_test *test)
> +{
> +       unsigned int eax, ebx, ecx, edx;
> +
> +       /* AMD always supports non-contiguous CBM. */
> +       if (get_vendor() == ARCH_AMD) {
> +               return true;
> +       } else {

The else can be dropped since it follows a return.
The rest of the code can be prefixed with a matching
comment like:
	/* Intel support for non-contiguous CBM needs to be discovered. */

(please feel free to improve)

> +               if (!strcmp(test->resource, "L3"))
> +                       __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> +               else if (!strcmp(test->resource, "L2"))
> +                       __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> +               else
> +                       return false;
> +
> +               return ((ecx >> 3) & 1);
> +       }
> +}
> +
>   static int noncont_cat_run_test(const struct resctrl_test *test,
>                                  const struct user_params *uparams)
>   {
>          unsigned long full_cache_mask, cont_mask, noncont_mask;
> -       unsigned int eax, ebx, ecx, edx, sparse_masks;
> +       unsigned int sparse_masks;
>          int bit_center, ret;
>          char schemata[64];
> 
> @@ -301,15 +320,8 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
>          if (ret)
>                  return ret;
> 
> -       if (!strcmp(test->resource, "L3"))
> -               __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> -       else if (!strcmp(test->resource, "L2"))
> -               __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> -       else
> -               return -EINVAL;
> -
> -       if (sparse_masks != ((ecx >> 3) & 1)) {
> -               ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
> +       if (!(arch_supports_noncont_cat(test) && sparse_masks)) {
> +               ksft_print_msg("Hardware does not support non-contiguous CBM!\n");

Please fix the test as well as the message. It is not an error if hardware does
not support non-contiguous CBM. It is an error if the hardware and kernel disagrees whether
non-contiguous CBM is supported.

Reinette

