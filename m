Return-Path: <linux-kselftest+bounces-6296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289CF87A5BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 11:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88897B21B59
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7937638DFB;
	Wed, 13 Mar 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEujxAeA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D83D54D;
	Wed, 13 Mar 2024 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325402; cv=fail; b=HtGz0a3GRZmFtOXTNoXUxQdER95Y/G1GRYLMWdCMbns2nyFkJXbX74d8QQOp89RKYvv3wloHJ028Mq5UuKk/mtjDi7qaMKrQ9pe6KCIdHUeXqlypKruaxenOWzkj6HFoBuL19J/HnE4Xy42y8JFxbtxfYQT7d1z8ooyo2fKG/8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325402; c=relaxed/simple;
	bh=05wjZac8eUi3LQZRdm6YYNQZd/Dhsf5zzkikI3DYoMo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PmtdsoK+WZhWS8glw0VW24ChEQUCuDLOKKzU4VCWOXjKf7oMXvYurEd04KOFjTTjaIKr0ySP0rYlTrgTtX74daNfqxbq27HH22Kp5B00nzt39krrnj80hQn6TTIjs4yoe2+OfrnbHUzDZGw8FQIw+KheLLtwN43Clo5LP3VJdbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEujxAeA; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710325400; x=1741861400;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=05wjZac8eUi3LQZRdm6YYNQZd/Dhsf5zzkikI3DYoMo=;
  b=dEujxAeAo0ZHowvZE55q6TXG8Xqn6AiL/9Sj4jGWi1XN+MH6R+w2UwNu
   2R42kaL9X+zlvHwR+Xo3lQHCWYuQu2GhbKMf/9RBFLeOPwAautEs1pgsg
   4OdL2yEF7VyPx9Nu3J5/lAhwKyDciHY5tJLFp6HjRAK/T+HNyJM88P89A
   hzbhV3X8qtkrMC6oCj9pjUF2BG1ytT/26Ysgf8P9tO/E0VpbKvzfTVblP
   hzXGz1n+JoAWDH5NqXLNkBrRH3CpYvcHZHE2w4lrFw2rhMDP2dmOjT6SE
   k/v/n01/7ErQtC0ZA0LgKVGVQwPjjn74QIiR2XtnLbpNgFjMYmkGJ4jB+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8850188"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="8850188"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 03:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16525405"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 03:23:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 03:23:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 03:23:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 03:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ujzikt5N3dTvGMc8IX0MHhWRXOXohZo16dceVJJNPgN8/+3yUhOCP01XYbwTP02dT2MtJHR2Q3AFTstvVNqvoO3QeiUJK+3jL0PxhqpgSNiX5NNQ7Ut6DE7qbCkgk5yXduNp9FyS8S96VERgMk9sOJo0BTIfer21DJZmPMxt6hpkQ7viuWo+ZqukrqNyEdL0bDsEyWMGtO9p28mbdnbAfFkWqRoSLwBv2ABxJzgVw81vvMnUMxqxdEiZdTEAQVDxZ+MtVuTJ9Ddi9W36T/34h09j7A0TxGvG115okypaaUzPoxrNC+99jDJM2nWJkuDcXO0MIxMm+dPdfR2UPXZULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8z+aUjlHlDgF3RqU0C5pMprF8HThnP6XP1uiuWL/Xs=;
 b=dBsZGXVi+Z6mwWZGMGHVGPHUDh1bJ00H0ujLJStUjKF7I4VyVfl9/zIyBEs+6oU0e1DVVL7SJuStZiocfSNI3euLqb5ZZENcIhdZM5hLuF6eiyd1gYQY9YwywD2wnQjBtopcCmpBxweMWMZsS8ReT5OSeiqz+8lJNgZ2D5u54qISy8W5RGsWVIJTg/tCAnRooI7F/d3T7SAVMtAX5HPIvlG2/nn15AWB7Df4zNLBm2X38E4hMrGas+0Zs2ZD1Y8RULDxZ4CgBJPlpoXpCcsD7Z0AiEEpkntpOwI9ar1bsDBZmUoTA6NCYZySrPblIiB6MTN4UW4tBTDWg8wZtJdGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DM4PR11MB6286.namprd11.prod.outlook.com (2603:10b6:8:a7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.17; Wed, 13 Mar 2024 10:23:13 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 10:23:13 +0000
Date: Wed, 13 Mar 2024 11:23:02 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>,
	<tony.luck@intel.com>, "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	LKML <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 2/4] selftests/resctrl: SNC support for CMT
Message-ID: <wsdxrn7hiovyzs7a7hom6yiwzucsdu2a4lpheblmhblscbkwjn@heyryn3cfiw6>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <75849cb145429798b21c23b6be4abd7ece9df57b.1709721159.git.maciej.wieczor-retman@intel.com>
 <6181937a-54b4-8b17-0c24-734764a205d1@linux.intel.com>
 <5983d1aa-6e1e-fb49-b95a-429a9decfe7f@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5983d1aa-6e1e-fb49-b95a-429a9decfe7f@linux.intel.com>
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DM4PR11MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 618d87eb-b5ee-4f90-af30-08dc43479695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /wcgHoSyVvVXmmUBHaTTSaB2jOcEr4mQzTg7Xj1mtHb54nvGOoOPRw+4DqVSxQ1jxfWekwQAiS1aCyVebZ0jV4Buer/06G0eJ+ABU3lKQ8xEHW5oeQotC2RwGGzKZ2d+wdkszF+QnL/09vxjJNpGttgFJW4LQJOn/cLvbmKTopIoHW/gG9aFaXLLKvhtdVHuYHI6usio1UOH8VYEquPNokxI4LqY1Uaxy3+zYQ61AqmHrr19nGVSlIjxVdgS8cJeyw833z4aBCFjks81z+4qnvytsQijrQSSCzTPx2hHMTSA1lA7JMUqjHFndJyN2UM3TjMTHF8/n1dB+ZR0f1nwoy1A5NJDSNaP/BJiwDdGioZN+xYhK7nKvAMXkU0125ACBbdFg73P7TluqN62nRo5UPa6ZcF/q3nkOO1MSJDX+4QcdT84gFmV6atyc83glu2JOCaveUCWOsh1zvBFdnXX7oa+KomgKvGrRIH0Er0o6fT1hH+j8TChAnG7vzOOueUWr3yHzbSKdBPd/PywQ6YBaI/jIXFnn1KSTBDz6ndqJYiTvk7CJ3ZPrx7VvfSTde8D3Q+YAL9TO7Wdan+OHZvBItdGG6xvkHs5ocue7xrg1vE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SzSnCFijkm3eAy+bSEIpOO8bXxh7X8xmdo3McQloGGEpPr6b8J24y2ZR4X?=
 =?iso-8859-1?Q?3ZNEtg0U+96S1k5zqiR0068g06nolQ9cXN0nLICmemoYTXfyjtCyDeuw2t?=
 =?iso-8859-1?Q?kObV9B7G4ckBZfnZTOtB5pG2WHLXcGP7iAhMxKfFGj1KnZlmZcSDo6jjqU?=
 =?iso-8859-1?Q?kvHgAP+WLUqOUPIDvzg+0KbObJ5W3wvQ/1sLHAyp12pZvGPbo7PM0eN6EL?=
 =?iso-8859-1?Q?6oUjOmV7nsE/iSLxBwpJyZH5+ktZvoCVnOz1KHq4r3H5S1FSo6EFpArKcP?=
 =?iso-8859-1?Q?efa9Xvp3SHB2/Q9jRhFXZJ9DISwEMHLRucEgYatnVDZQwytXW6vV0YyuOZ?=
 =?iso-8859-1?Q?fA6GfM9s/aeECaMdyuIzsLclRoOzmlFSAOEhbDkUnNGTRssK4JAfF799GC?=
 =?iso-8859-1?Q?sVqW3OZ/MzjB90vTk1BNe8caoME9vzk8YoWAp4LCreRAfHcE1eGUJosX5j?=
 =?iso-8859-1?Q?d5EXUJBlaGwgWOBEbK9WJKqR1UV56ho3AcaS8++urw7Kd1dN2dTlw3wQBu?=
 =?iso-8859-1?Q?+3wzmuNK0VGtfahYA6yMnVzikNhuL7IJvYLtq+k4ostqlUF7CFxqYbQKLv?=
 =?iso-8859-1?Q?GdCUvs61b6sH2DidMId6vVkI3E+403t7TpbBHZVEd24dlHrHu0Vu0ZYa/6?=
 =?iso-8859-1?Q?4LEvxrcuPMCRLT41xLsvwfMGdER+mWxc32EWubRWKwdwV0pbtCkwT5eD/I?=
 =?iso-8859-1?Q?lKeJdyb9aOPkf6HQkK0vJK8K5Cb/En3ACq8C185FLvrVC+XmmHlH2ODAoy?=
 =?iso-8859-1?Q?EJ2Zu/owwLRgRlzaXc2Pd2GKWoq7HYWsUbsIJQ8UPfNYNRcgSbfg6Z7UWI?=
 =?iso-8859-1?Q?AXSJQNyXBMl6ogM1zKwlLCIb7Zsswt03nQJLN9VBupcy0pGXdTEWQHayeF?=
 =?iso-8859-1?Q?5WEBKJ9sJF4Fj1vEY6ECjpe+I57bhGS/I7QuCJCRtAT1bk8+nD2vS+KMUS?=
 =?iso-8859-1?Q?ZhNhPNpeSAB1YGAvtqg1T51HqBuc4suTxLmSbM+7okXy25ZeIW5Gl3MRmQ?=
 =?iso-8859-1?Q?VMdj5Kl7qjwVqcajoCI1yS4wrHiLKxvQL0jnnbEpZNIvoA1ydAKKMl6EHu?=
 =?iso-8859-1?Q?sIPVjpimpkJ6RR99JagNzIniwOk+k/DOO87GjL3bp8w4LSQEQPJ1UtQW1E?=
 =?iso-8859-1?Q?L2FOQ6WXspeUHJtMPRALZ//3E6E37/YSO/XzyowAgve/GO7P8tzm0JPts7?=
 =?iso-8859-1?Q?eMmfthqr5oITAfTjR5+dpfHqRgo1/JVR30Sx7kIrFfHQkUNjl3tadnMl8K?=
 =?iso-8859-1?Q?+hMqstNN6L2tKnCW5kCtHDLiZu9nic6ncG1f3Y1TeVumiYAzplBW8UO53Q?=
 =?iso-8859-1?Q?KKffeKi4YeYb12uaSBmKXFGUv1efP74T5QQYq7aCtf1WGNwX6vYMXOQV5T?=
 =?iso-8859-1?Q?kRpXa+fN7vkJihXZuAxHsLZv/HJHGz1sqmXEPMXjvXiFw5nlQcIaakEoGO?=
 =?iso-8859-1?Q?rOFYxlobWe8aIEuMa7WtPha8Y3eywwMrU+DFUKl2cTU3NxsBIscHT7mHyD?=
 =?iso-8859-1?Q?/mDmXaGDr1Dlq1tFuxBx104VlmO+VT/44lyZGbZKga4Yc7RUW7yQymwrYt?=
 =?iso-8859-1?Q?bxvMntJMdkxWrPtUO/3ae4UcjsdE6va3nmsgGRIpeSxgw3MGzaz0InMYmb?=
 =?iso-8859-1?Q?CJR+L9c4d10VZIjR3qQ1eNzL/yyfNmJj0yjp66YabJi0gYatnYzr5iyto4?=
 =?iso-8859-1?Q?NJI5Fcv2jZ3bpznhXXA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 618d87eb-b5ee-4f90-af30-08dc43479695
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:23:12.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lOmZqliH5LtutJfEFo4ownYuXvEJ1n/ZCoLltqV7httDxXpA9ZSSYtTKKPvqOPBxdD4+z5hcL3q5y/agSAUkwT+JtduI1g5wHPCMT+Ckxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6286
X-OriginatorOrg: intel.com

On 2024-03-08 at 15:59:02 +0200, Ilpo Järvinen wrote:
>On Fri, 8 Mar 2024, Ilpo Järvinen wrote:
>
>> On Wed, 6 Mar 2024, Maciej Wieczor-Retman wrote:
>> 
>> > Cache Monitoring Technology (CMT) works by measuring how much data in L3
>> > cache is occupied by a given process identified by its Resource
>> > Monitoring ID (RMID).
>> > 
>> > On systems with Sub-Numa Clusters (SNC) enabled, a process can occupy
>> > not only the cache that belongs to its own NUMA node but also pieces of
>> > other NUMA nodes' caches that lie on the same socket.
>> > 
>> > A simple correction to make the CMT selftest NUMA-aware is to sum values
>> > reported by all nodes on the same socket for a given RMID.
>> > 
>> > Reported-by: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
>> > Closes: https://lore.kernel.org/all/TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com/
>> > Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> > ---
>
>> > @@ -828,6 +828,8 @@ int resctrl_val(const struct resctrl_test *test,
>> >  	sleep(1);
>> >  
>> >  	/* Test runs until the callback setup() tells the test to stop. */
>> > +	get_domain_id("L3", uparams->cpu, &res_id);
>> 
>> Hardcoding L3 here limits the genericness of this function. You don't even 
>> need to do it, get_domain_id() does "MB" -> "L3" transformation implicitly 
>> for you so you can just pass test->resource instead.
>> 
>> Also, I don't understand why you now again make the naming inconsistent 
>> with "res_id".
>> 
>> If you based this on top of the patches I just posted, resctl_val() 
>> already the domain_id variable.
>
>Ah, I retract what I said. I see you actually want it only from L3.
>
>> > +     res_id *= snc_ways();
>
>I don't understand what this is trying to achieve and how.

We exchanged some private messages on this but I'll post the explanation here
too if anyone else was looking for it.

get_domain_id("L3"...) essentially gives us the number of the socket (on
platforms that have one L3 cache per socket - I still have too look into other
ones). The problem here is that to get an accurate reading with SNC enabled we
need to collect values from all nodes on a single socket that has the CPU our
test is running on. So we need to find the first node on that socket so then we
can loop through all the nodes on that socket. To do that we multiply res_id by
the amount of SNC nodes per socket (res_id *= snc_ways()) and that's it.

I'll add some helper with an explaining comment on what it does in the next
version.

>
>-- 
> i.


-- 
Kind regards
Maciej Wieczór-Retman

