Return-Path: <linux-kselftest+bounces-3197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835928318D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 13:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1B71F23048
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 12:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4699F24218;
	Thu, 18 Jan 2024 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBuTXohV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082202554D;
	Thu, 18 Jan 2024 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579380; cv=fail; b=a2//HtF/gFbA+wUYS2q9Mgd8HYghhS5U0Y/AAFGQukouD4RgwkO9CIlPbbY4E+Aul8csu33/jrzaU6MiO/dox5UaeIEXwOh1l3zRzl0KVhKhX9udd+rWdmTo2LU6kn5FupFWJoHfVaMWHsLln4ozV+wNeLAZpqjMN4HAX2t2xi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579380; c=relaxed/simple;
	bh=Xe+Za2XXqMhq6+p3nAa1Ze1zGSbJezs7DyilKyNgLTA=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=b8HcJurwSo5VuG+/uBVwLRuZJKGAVMkoXyQvsDfJrGpGJ3bC7Ok3FupuBFtbDs5w0QGRksRjc55MUrQ9mIZdhH0vcSH5LgBBqCfATYFc6OEKrghPrEaJUvfLTBVgk4j3PcsHsIvtAw7BIJLgLtcTl8Ab0t+nwg9ASNnXgPcj2Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBuTXohV; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705579378; x=1737115378;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Xe+Za2XXqMhq6+p3nAa1Ze1zGSbJezs7DyilKyNgLTA=;
  b=nBuTXohVGdYMTKebqbCgsuu9fsr12hN8GM+Rl3y1ygH5fGsFdVG+kqxK
   Bmp427Qg/sRUGrAyJJvPuCZ9yiyS/IZPLSevJAZ7UamMCF/Wirhb2KTEx
   /BkHgnBZGmeSFwUy0J0t1hRNrmj+Zmg9XbcAosa+jlfGKJOzN4XeEnPIb
   UOTKF8pgjMj68WGfLZyIjEfTjxAwyOQZCG+ASQEtcDiP1Z7A+JfKEkcBG
   LCZtTKlUbKaMoGqGWJHwbKC1IygSuNOJYkNBLbWJOLksEj4kXD6OxKlPG
   JeT+J1VaJYSPR6TtN3Ba7BoNxYjtibb2X8uFZYhS4j4l1glBY1KRONddc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7824846"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7824846"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 04:02:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="1031645284"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="1031645284"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 04:02:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 04:02:56 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 04:02:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 04:02:55 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 04:02:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwKjNeTc2XjjU3HyBqAlW87kf1C73OTafPiay/t2hxokrNmZQqF92hpHbbx0pcYWH9njKJKmxvqQi1g6NIrN9FxwlRPo1FTjUYNDZuXAQezMmLHSv57bAaMiEe0OciD0DkMsekzt+8FBhZOosjMKbeOUZeE1JmiiO1G25TtCn9qEvGuSVJpkRO/b9ViUNCe2GE8Br5VreknP1ZeYR8TeL6xTOagqV0wbFFA3QJhTI6GnljHrogRadGDiPB+/KZqX+b5ri0Ydy5BfFBDXP//x5Uh6pNMCUtOujxsR/BXIXppMr8LJ/048nPhP4753eLomlU2Wp6PtVqN09lhb6moFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouoEk4CZEvgO5V1Bb84krt4S1qi/ckfWnI7VzTq7Gtg=;
 b=aeEmlooD+aTQybcZIn+qKqfciF3oMAH4syCkRAbmq4/ZG6XqGbqJSQiKDg/PfX3bZ7SBsDsOai27Yc9sATxVnMPx1SB1EUobsAqtjgRfbBx/CnCZzETUjxri91t8f88p0fe8oa1LYajK1JcJ34Qq2kS4o5K7IaJqpFnBAkh92ZMvf/2kRD2LzYrwVD15SzkreUYrt9c8RfGJc+8hNqTBqGpUt1sqWzEqPHyqoZUA4/nZKzkJEcCKSIi/vcaW+OVenxNTBzrfaY/CMbQFxegnAdA68ZOQWCyJxh2BO3qDIJLWaa9rz1t/cuyhsGiHxWI6bThfyLbZqIvLPCwTkzLBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 12:02:53 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7159.013; Thu, 18 Jan 2024
 12:02:53 +0000
Date: Thu, 18 Jan 2024 13:02:43 +0100
From: Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Message-ID: <su2d6i22icynusoykmowfnzery6hlqugovaw4xcrhb7r3ymbx2@aeimvrxsc5xw>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
 <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
 <6v4hgra7bd5nwubcgtbsidmoohrgxdw7no4faa4a54g4vrxo63@c6qnujvwn5ej>
 <73cea732-3757-4aec-a39c-4f0e50f6fb70@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73cea732-3757-4aec-a39c-4f0e50f6fb70@intel.com>
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|LV3PR11MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 92434c2c-ba1e-499a-eb0f-08dc181d66a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzYJzzUA7C+al5qLRqIe5O2FzgqtUazDmx9Svt+20VHqfoqqHNQhm/v5sZnXaIrlu2eiAEPPsNfVQFLlSCQP2UlC10KYNXqcyCtSAaxo7A1UxRA9daXZHqlfN2UJo6ryOSG+iCW9uidnj2gNdEOQ37pzRL1J+jMFYfqE7VvpuySMHKKlMxC4K/rqc3a4CTubLzFyPHxemOaI43WSU5sYwhIuNKW2yeMhOpnwRdEx3OWYVVnFhQtUmhHmFT3xA4fkqT8956UCJSt8mVYtq7qRFFp3nt25yszf4ocBUlrqdIl28UKX9OaIuqyaUiplMqEH3ZVX3VhS5f0XsradBN6fD9y0mqS/k3sQPpHEW9sqIU7pZOBbI4urvsB4DlJEjZZ8UAMPVMZkUGwupw6ORMTEaW2F1Igt8Dde3LtcmG9J1Dbo08+nmW3SPb0kUfF8o3wgVyOQqE4OVDy8ZCLB8mybx/l/AixghK1IgSMFFsX7PDH6gpQJ5ccobRzjgGVNAkpPHHBK5RdIVdDbiAOLK6xi8lIknddNaCPfa6sBOiBBYedY8AxwO0ZvMXd+I50Lhoqi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(2906002)(6506007)(5660300002)(9686003)(66574015)(6512007)(6666004)(53546011)(66476007)(6636002)(66946007)(66556008)(8676002)(316002)(8936002)(54906003)(4326008)(83380400001)(38100700002)(6486002)(6862004)(478600001)(41300700001)(33716001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?C01U2tM8GamWk7Y+gqwR9gaEW+AjREylhdHDxGQeOfFoSNb30Wqo1EkBjh?=
 =?iso-8859-1?Q?B6JjgozEJNMO7zfSYdxAd7neJYmdN5dUaWpV7PfnZo3satJiBhhqDL7yE3?=
 =?iso-8859-1?Q?VDDdHhyMcwIsx7QQGIaWRqODJCRsPqN58RsLzfX62dfn1GEfLUCdHXl0rM?=
 =?iso-8859-1?Q?/KP7ZsT7H6qC+wJdINgpryLj1grBG5fKF6MrFKzTvWQ3BWbxLLqg0b0k4W?=
 =?iso-8859-1?Q?SVjihX6DQEV9m7s/NWXqBSubz2e2ieggfI4ohkVUPXTc8Pzl659faLpMEn?=
 =?iso-8859-1?Q?vXxs7f6II2PDw9r4rwydAzRdmnATC9x4Fgu1jnpPvsZpB8rQfg6XVNrq0X?=
 =?iso-8859-1?Q?rBeRsap0llc92LP5Va/OGOxQitHxrhnoUo6obh+CDcatVYDgTNNZJWUVF9?=
 =?iso-8859-1?Q?7Gtb7uWEXnwPl5wKtz1MvvLRq3uEKRbRgjJTe8iVVj3iqUEMrh10+bedhS?=
 =?iso-8859-1?Q?akwCq0f6MLcZUh2sOL+R2JsjgfE58BiZyn2+uf5g0fzDns59MQgkDQztWK?=
 =?iso-8859-1?Q?pQ2o+xKMisN3Ewtz+YfL8a5dD5LeVL0nsuA6AeCPuzbHA4lJp1b5BSCwEK?=
 =?iso-8859-1?Q?XcoV2yl6YhqHvl9cDtzR6LW5fGcsS6Y+H1ahaWsjeddv9id8J4q3aWX92C?=
 =?iso-8859-1?Q?It65JDTLvdF/8AhH76NgRN+pLImnWEPlQz0tNjbUGhaf9BzuAaW/6b0Pe7?=
 =?iso-8859-1?Q?KQbFZAXRaeDLpcPuP86T1zpY/dk/rVsKz92KEbNKJjNNEPnrVd5XVrwzbI?=
 =?iso-8859-1?Q?e3+gH2sCJOGVdwDZguIMCwVn0m0p8R3T04PLudBsHC00MqdJNvzseFBgA5?=
 =?iso-8859-1?Q?m/2vvSdA+a9AzmgfVfPVr6YjEPO2fCQi9hN6wM1ClFuayPmqusivL9A/o+?=
 =?iso-8859-1?Q?iRRnWQG6ImuSCR9ISzWa4mMNxlZKZhKG4UGskrVkK9NklzcIG/ns4CqCv8?=
 =?iso-8859-1?Q?SzxpYdcMrRHw7jlPg8WGsaTUFSMGSTDE8/NFCG042PkolOnlZwhtiwbFMC?=
 =?iso-8859-1?Q?g9ZFthsfU2IB6sfHbuN6XTfKBG9nLiq/c+ZLYE3NrgKyZ6o08TeZy353Eb?=
 =?iso-8859-1?Q?NB/PSogihM2ThoBACsxHk3wBr+kklbu4FBa15ar1ZYoFX13ipeQJ4WD8h5?=
 =?iso-8859-1?Q?jJtmXCeOhQgg03Rcuszd6WodasUv3OiQ6BlLL2ad9GObvj6UCCI506LiwP?=
 =?iso-8859-1?Q?zeyALI7bKMk28cPNc5OEvrmzQ1cXvnxFhk+3R4qxZtIYBqGrUTMOk08tz4?=
 =?iso-8859-1?Q?oLO78q/Fd297lxk1MkMhafnDCraShk8o8IEjxbnBk7tMM5HNaUXVgNnTWz?=
 =?iso-8859-1?Q?T+19nbt2uC4sheXFvHTXJiw7OsCE6rarTOABYf4j/YalHcUAxrrcLw35as?=
 =?iso-8859-1?Q?k7oloNxeo21/+XqWtNU5vWgykhDoFosBhz4w1pYYnDwKPzSu3XYN+CcAFO?=
 =?iso-8859-1?Q?aAcg9VHSSHefwAsk9uKm5DF2U/K4yMOnEGPj1Qn18EJx3deEB1U3RVXZE/?=
 =?iso-8859-1?Q?xr2CvmUbgbUZWIPcC4qi8BjW3qZlQdU+uLvq1uSWmmLaK6Z6AEIp3s21V8?=
 =?iso-8859-1?Q?BGRUyWy5ljq2p2G0XlcfrL/WxoA1KgfsFESm0GI1EVRPg9xfnIkM6wTNUW?=
 =?iso-8859-1?Q?rv8JLRfR9OfFD1dE8Zi2RPHXclerFJQ0newOt1MsOid7zVUaaV6dxADU96?=
 =?iso-8859-1?Q?0GBse7kbqohXiE3GDgY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92434c2c-ba1e-499a-eb0f-08dc181d66a2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 12:02:53.6215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgCYA6NTspAvzjGO7FXc7S8YI5ITEa+CrGBHxlBz6Kk1pioD05jAUG6qug0raSeCwcT/3xCKzHFuaBUbomsLkgWtLBNdnTigYx6rrFxzaKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8531
X-OriginatorOrg: intel.com

On 2024-01-17 at 10:49:06 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 1/17/2024 12:26 AM, Maciej Wieczór-Retman wrote:
>> On 2024-01-08 at 14:42:11 -0800, Reinette Chatre wrote:
>>> On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>
>
>>>> +
>>>> +	if (sparse_masks != ((ecx >> 3) & 1))
>>>> +		return -1;
>>>
>>> Can a message be displayed to support the debugging this test failure?
>> 
>> Sure, that is a very good idea. I'll add ksft_perror() here.
>
>I do not think ksft_perror() is appropriate since perror() is for
>system error messages (something that sets errno). Perhaps just
>ksft_print_msg().

Thanks for the suggestion!

>
>>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>>> +	cont_mask = full_cache_mask >> bit_center;
>>>> +
>>>> +	/* Contiguous mask write check. */
>>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>>> +	if (ret)
>>>> +		return ret;
>>>
>>> How will user know what failed? I am seeing this single test exercise a few scenarios
>>> and it is not obvious to me if the issue will be clear if this test,
>>> noncont_cat_run_test(), fails.
>> 
>> write_schemata() either succeeds with '0' or errors out with a negative value. If
>> the contiguous mask write fails, write_schemata should print out what was wrong
>> and I believe that the test will report an error rather than failure.
>
>Right. I am trying to understand whether the user will be able to decipher what failed
>in case there is an error. Seems like in this case the user is expected to look at the
>source code of the test to understand what the test was trying to do at the time it
>encountered the failure. In this case user may be "lucky" that this test only has
>one write_schemata() call _not_ followed by a ksft_print_msg() so user can use that
>reasoning to figure out which write_schemata() failed to further dig what test was
>trying to do. 

When a write_schemata() is executed the string that is being written gets
printed. If there are multiple calls in a single tests and one fails I'd imagine
it would be easy for the user to figure out which one failed.

On a side note I'm not sure if that's true but I'm getting a feeling that the
harder errors (not just test failures) are more of a clue for developers working
on the tests. Would you agree that it seems like users probably won't see
write_schemata() fail here (if the test execution managed to get to this point
without erroring out due to bad parameters or kernel compiled without required
options)?

>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

