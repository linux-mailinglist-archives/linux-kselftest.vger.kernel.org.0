Return-Path: <linux-kselftest+bounces-5431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2C4866FE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 11:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051332896BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 10:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C96224CE;
	Mon, 26 Feb 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdvdhD0D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127EF6024F;
	Mon, 26 Feb 2024 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940579; cv=fail; b=XBTEtS+0DDLZv4urmPspeBv40hybDWApZZL6iSX+x9wBr+DuGuOXi6na+UGvk5fWHEczAF9d1t7tNqQGhv4TQDzyQBRQN0pp9buGf77Mdb3iRAzU3ihVJ/hDhz+lsBv+u2Uj5B6e9NdBMh3+/R3LqOwYrGu9I6zZZ/smNy6htlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940579; c=relaxed/simple;
	bh=bz/rSXGY1RXTlpiBnB2Q8vf5fRR7WM24wm80qQ2s6Ec=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k39IdldFhlxLhEfdXBwAiTj08TBXgMu3A8OZqkvK21XJ7a/mbyXSWNNYrpoLHs4jPg2ZnOOw/pSzABaDKAzbbQ0Mf4QdZ/AzaK8f4aMsT5BJiexUnLlJzI8Au6M9Hdps6ieBoGj4dWB8mT3UHl4vUxWrrqaYVxRiJaji+sm4zwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdvdhD0D; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708940578; x=1740476578;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bz/rSXGY1RXTlpiBnB2Q8vf5fRR7WM24wm80qQ2s6Ec=;
  b=UdvdhD0DO0EAqEiAMDI+6Gj/VWrW45XbhZPcs8OoLcyKma5b9LA5cLKb
   KRFDxPZWXQjoNj3FfUUuczgsvpS9+4D0ETuT5G0AtHeS+0EFdOuvbRZTs
   bFG/wzHoQ5Y+A3iYgWy2zbZ8DTNWKdC4difdEMh0dOBnyoLjbBlMX+T3j
   agyQTXOGLiI48RDXg7F92o3D0zLodrD1wws/rpPifPZGlIsy9tny6agM+
   FuHevRK37J0cqKErC5nmQ3qzb46S6zSdY3kl999BvUI86rUFbzLFeCcqa
   omu1CvrHnsebCcY3KIgC0L2s2wSaI04PXnSzQFp1w9UiYcTKdTuIsa/tk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3056910"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3056910"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 01:42:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11254446"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 01:42:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 01:42:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 01:42:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 01:42:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB0FTy2tBNKG8jy4sQVh1G4JqLvokzWp7N8qCU2BaTa/1/P+IYzhAKOOgf/yVRXwZDD4gQyCbTE4RaKXklQzxcfi5p1ncbloEtwVehSv24hSl9GNlltpaAz02/ClH4/4NROzEtYEDXP8k4dXwYbnmoNZGDj23esQd42+PMa1FuxOdqjb7j730sslS1rQFu7xkzsIywayGX9iL4V+n0fur528on61YzQEAWDOOqw/EjgVG7sgK4xxETr+iBsBZovAOij++GUdpeh7M6/5hNzlrH0y2OW+a0OfaZUKOBVhbT1Rwuq4V+de6j4YCfm1y7uHxEVzHSDExxqrAAWH8cAGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khaCYhZVEUlMpWa0Ju75iRdJpjP2+351pC31iMhkJVc=;
 b=V/Guv76sh2PEYYKqTxl7BVDIztsIi4FOU6cVlU8itze3Et5Zo4SytyKCzlOjcMzz44juJOmhLDYXmQee+ppNg5ECl+5xRlxMMGg7H2rkus3zsNjPPSDPd0kZImwb9KUQuYPCTTOQ2aPQM6vNrDOCUhDClw4CempvrYsdLBr+//oZLI10K8JJ4iP43M/Bgobi6jVhT0ILJrfCxjAq/Yiz/AKFV1jalmXmYhI9nhLVu5pQxlk1CjFgG9JCJxQVIDZ3Cq8zIjpr6J+DhKPIBwKVgfSuj327idAR77SVMrFOH2g7Jrihi7B8mcYwi5HIBxAUUqq6llXzPliYnEUnJan6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CY5PR11MB6140.namprd11.prod.outlook.com (2603:10b6:930:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Mon, 26 Feb
 2024 09:42:54 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7339.024; Mon, 26 Feb 2024
 09:42:54 +0000
Date: Mon, 26 Feb 2024 10:42:44 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] selftests/resctrl: Move cleanups out of
 individual tests
Message-ID: <sryavktjx6eqavjseo7ktii3v2g7opfodsv42fdlsy4dm3dwy4@algmgqcm6m35>
References: <cover.1708599491.git.maciej.wieczor-retman@intel.com>
 <bc4a4fec20420fb792612be024473f31f40d7bca.1708599491.git.maciej.wieczor-retman@intel.com>
 <8caed6ce-808a-4d25-823a-fc4d6b56268d@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8caed6ce-808a-4d25-823a-fc4d6b56268d@intel.com>
X-ClientProxiedBy: WA2P291CA0042.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::14) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CY5PR11MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e33ed57-194b-4412-4c95-08dc36af4eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jn3sjVV5Y8UkhCdek4Ishm8FZjP0YYUjOTn0j4GaHr0OrEUixcGcYWAtakRflOz6JAAKo92Kf3PBYuHldy3TPEgAKpsDSyVMF0jTUwFilHaSKrtG1zylJzHHXGic/ix8W4p6vukoD6hQig1S/Lr4LxNsYS8BKWEmMBusjwEAHVrynD47DmL+Z6UkJuMSAq1SN+iF3U/9jS5QY/BqL/+eCK39sEjNj5V+5/UKyWyewu/iElTfzgx43lKWbDLMjobpfNxuIK3mPWmX6Q7OEb5r18tAVNJpmhl3ZGDpMr+vuOYxNgMO7fUCcd7b2zPRvZL0Sk+tXxYqt3kPg3t3OG4voVQ50o2OnltO5hnzdW2KU0Pz1wBCj04Jho6Y+3+ykliEKJvy7KibOJ5V+I5zn/N+i7c2vg3J/AsLuDCA4zYNXixr8OfD2+eOLX93HU7a+Bf1ts24w2gw/DRt5+2bITHUz26twsvS1vonJbTtTRGxIzw98QnVf/Qpt/XDj5vMRr2VqzPVXQb/yqsg/EVzvaQS+/PkcoVsuiSZqHJZ3pPYlt5VFiOT23fi7W+00jr8OHQGFe+xXrjVLKfI4kfwQIlZ2LUVgiHLrUE/UwC80aj7OP3V3eVYppwXrD8a7PqUrGEi8TQ/kqafi2vPr9PDEnwJJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XifY4e4Ur05epZuJsv7Mid6y53yjMmyfg/PHimXxC2w7a03nZVDUra1SSm?=
 =?iso-8859-1?Q?scitIC1A1WwqsNOZmeFsuuCZt5NgDLmNBRRxXCcl6m33Q/F+GBmvfDQTFv?=
 =?iso-8859-1?Q?CQwBiyjfbJWCQ/CJTPZfXUVRV8Sm9t6Cl/VAT70l6cEXSC8RLWdrxuC3F8?=
 =?iso-8859-1?Q?CqF+Hf0UoGsWVw/9d/jYzMfDefQEPlQVez2e/aUYWzueLlxnBIr8XGONI4?=
 =?iso-8859-1?Q?gaqyuB1fZsRd07cIHFeOXHAM1dvm2/mUqXEPP1/8ewoRs6lt/sZRKhSAB9?=
 =?iso-8859-1?Q?2ADc9QKRblW7WT8SHO+NXWH6FMd5eqY4oH9S9rqBjZrb7KTFoYoIzdlB+J?=
 =?iso-8859-1?Q?m8awG5odCaXlUIvSY+BL+LKGcgBy2usP7nK+7gcbjNZL/B3lRE1GM4d5fC?=
 =?iso-8859-1?Q?uKQiwy69apKeiPjE7xBTehimsWd3dPmsxAtaPveMKbStngviH92DvHFKrf?=
 =?iso-8859-1?Q?3+uU3Fyw2Uvr2sBQc+0TzDH1kjrg8gU8qryfyW12C1PFw907ktkhtsqOZy?=
 =?iso-8859-1?Q?CZUw07RPyRUOEQl94UJCT5yz+RRC6dfjSnoYTNRsAqTGDsxatYuhih8QjM?=
 =?iso-8859-1?Q?4P18uL17EeyVUT28NnPxMerqR4faMBWuxpLPQa3iEaHz2dryyvMceY9fjW?=
 =?iso-8859-1?Q?j6y+lztqYEDSo1naVa04OFag0p4kJx6PNI3mCS0STwJPbnSjXFEL3FVJta?=
 =?iso-8859-1?Q?SLDRrQeBIS29raPIA5QWuXTVM3TpNCS9cVcP9q8hasJcZ+jG8PxkflUuam?=
 =?iso-8859-1?Q?fh8w9WBEGkTfsYpWsynN8rn9YnUA5WNyAq3GBsb2fuAl/127N+sAWIvK69?=
 =?iso-8859-1?Q?1/anXTmnRjyesGs6PP36qbhh1rswoHug+CFIV+x8KB+YIni2L1NUFBBcbT?=
 =?iso-8859-1?Q?vU2sqySjYs3OIF1Bp4FZVZvicgnTD09hRdUyf6jBgWO3IeTEyWC0e0IZVs?=
 =?iso-8859-1?Q?KGQphBYkoEGld/QNS88ZBexoxILI/ZNYSuLhcu9ynPNHl2FtUOM5ktJ8/m?=
 =?iso-8859-1?Q?B03FT7bzxpamLscHd3JjduyL0xtwf9MIQdUUk3QLRxWs8tA7cWBtFL6+rY?=
 =?iso-8859-1?Q?2RVTbpmcvogJiSv/Ols3XMgtnUO4h1QXfnfgqn5r4Ia9YNrhpYM+2zqbEH?=
 =?iso-8859-1?Q?14TH5pbqcIXa88asU9+Txv2upnD4jifBiWyi/3jRm58ERLYD/Z96rZO4M9?=
 =?iso-8859-1?Q?pKou0M9F4hhliGsUhzneNre9qvN6gZ3vBJQ323Z02v2FEn1/yqAYhfQViY?=
 =?iso-8859-1?Q?1MM1jCifUYfcSpJHLuphvtpM5TG0skh+Zb1EYWBcUkYtZjThgz2wDtt/Sl?=
 =?iso-8859-1?Q?pGjZPLYVurR4Q3nGijsIqABAtFUIbz4XSN6+5DfmTjZ8ysN9WT/+ypYpoW?=
 =?iso-8859-1?Q?KYMJOR5wgRreBkq2ZlaqfOy9zmty+kRcRYXP3A/6OpMUY/l8M/Gbv0oa/1?=
 =?iso-8859-1?Q?Ceq1JgeRwtr3NExsr4EmAtODw5/mfwvete5iN+XkUmtouZiPUrbtMMj0Wq?=
 =?iso-8859-1?Q?+WSlc5QT9XG2HVylSn50Jb8Y1mFe1THZroFzTNmLnMjRayzzcH210JB6Bp?=
 =?iso-8859-1?Q?dehQB15zgjw/nwGY5hd0qJGDa7f6hj+SmipN7rap7uCPieUEoZL1LseQv9?=
 =?iso-8859-1?Q?TEd6bNupNz3Y2JloVUKh22IKBD0ar0okx/+/dds02TEwKVKHI/Bvf6ll2K?=
 =?iso-8859-1?Q?I7aybFD9jXdUtknr0T4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e33ed57-194b-4412-4c95-08dc36af4eab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 09:42:54.8735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sLD5gx+VjMbjDs0KTYWNgTqhMyj5znXcH19gZN9YQUSIXnFWUn4k7ETY6DdS77wltsNsv2Ld+6nO+xA3LWhUXiffCgsuJ6v4L3hL8FMf28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6140
X-OriginatorOrg: intel.com

On 2024-02-23 at 13:18:32 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 2/22/2024 4:07 AM, Maciej Wieczor-Retman wrote:
>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>> index 161f5365b4f0..bae08d1221ec 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> @@ -134,6 +134,8 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
>>  	}
>>  
>>  	ret = test->run_test(test, uparams);
>> +	if (test->cleanup)
>> +		test->cleanup();
>>  	ksft_test_result(!ret, "%s: test\n", test->name);
>>  
>>  cleanup:
>
>I think this can be potentially confusing to do cleanup here and
>then follow it with a test_cleanup(). Could this test specific
>cleanup perhaps be called from the general test_cleanup() instead?

Sure, that should look nicer, thanks!

>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

