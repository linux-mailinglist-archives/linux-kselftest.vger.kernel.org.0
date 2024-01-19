Return-Path: <linux-kselftest+bounces-3225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53925832526
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 08:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0474C28662F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 07:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99131208DF;
	Fri, 19 Jan 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ModiBi4j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32FFCA4E;
	Fri, 19 Jan 2024 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650227; cv=fail; b=I1LLp1g5nJMDb5oj4fU9ObUsluTWYACxsgKU50KMaiNbO6BytV4R+RvFWsqVEzWGIeJye9oqagBZq0x+8OJQSPPlyU5SE0HY7qmBk9Q9hrqC4wg5nKY735BIWWo/o0ZJgyNhBaKVyZpLexxtrbRWmXCCRFugI5acllhCDYYasRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650227; c=relaxed/simple;
	bh=Gnh14a0C9FBDZhftLnoJRbf/FDaNdiBJqcw03LO0S5U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IuSeNM46V02CqZ09gx1orbHzf3I96+JmgjTOcUuFzjxb80kuQ72doFAuBB+C7+ptbiTrM+80kOFMpONDEhNjOZ/aiYvDT34s9Ofn5rfay2Ip+PBvocd4J2Jr5w2dHEEiLobffok20A017oR8YyI5T5KJFUXqugvxCWt7skg0UpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ModiBi4j; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705650226; x=1737186226;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Gnh14a0C9FBDZhftLnoJRbf/FDaNdiBJqcw03LO0S5U=;
  b=ModiBi4jDW7PgmiXlExc+60ti8DVTlw4ze8+mOH2/GQ6W4Jt1F7Idczk
   7F4BuFnx8nbocQu01GxXDqgeUoZPxo4QiPF9Em9ouCvvYOCmbCEwDsb0c
   FeAcmeaW6cXzEdmmAoeomReyCYhXBb1dnhDGb+IrY0JM1zE8uREeofEST
   +u/6ZOChMWV2Ae1K0+aQnWWPc5iYPApqAwywdQ0sZ0JU5YiAkUeRg04jE
   yNYTRxJGMX+iT8zAWw1rgy2Eycrv+S0izOgoeSkKm7GZsw7TJCcpSTj7J
   LrKHejbNW6bjIzeUhMwKcaM9PuUA+cgoKcau2OtoLGyLYp51+aUw68j8h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7373121"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="7373121"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 23:37:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="510410"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 23:37:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 23:37:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 23:37:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 23:37:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ods6sNVVylpRFn5TyKgkWfKpcksyPFpIVPMw3erMk4nqum8sWTfkjYNgf0dCYVRYavmziqK8dWOe0aUKV6Gr/dHhphQOWjdsf4XqFY94kevEViHVDokBMf4QC1I+Ck6FMfUGTTj5JAZBDh7udSe/yCwaqnR5wkY4sH404KYk891AsOAtiNTP5HFmhQE8Ago6MuUInjZ8Fc6lPbYQdk1oJywxS1otHdddwOIdF8kcwBE2M2H6QUwlAAfwMscpothycuumTPDSQCgLivlEXEqFZj1i9BkYivF7b7HNiz+tBF5YHyk6V0vX/HTiU3f/c0ytcSSLzEk/N/CtTfdt4s9NuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA8IXK63psIASeQnfBhuvq4x/gNuwK2HSwVgwBM5468=;
 b=axtgd2KeuURAcBniH54DA0a+i7z5AtQuE0w1e25Z/pHzW+ASsc9tTPGauKaIt82lAT7b+Xxx/uTYGsxvUXQKpCidCjn/adZ9Fe+/8890V4zVfuPpysV/nFbM5HJa1KeDQhSGkbbXjBgNJVaiCguqQZdxk5H+XqhACBS5BUnsJhewXOLtXrcl825yImjSQP6gDMsgQQkSWnGkP+GvNekFjJMIuCOOmd6ALJQTryRnGB2oJudbT2Yv9g/WA+0JPiWjse47yrtv1vKb/j9nIb45NA22AYcJ+hbiJ2h3uOC7iU3u4SZ2IypI2i9xJasUP+y1oowgJjqICIvdLdQoDfMypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH3PR11MB8493.namprd11.prod.outlook.com (2603:10b6:610:1bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 07:37:33 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7159.013; Fri, 19 Jan 2024
 07:37:33 +0000
Date: Fri, 19 Jan 2024 08:37:25 +0100
From: Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Message-ID: <wvehk3j2dcf3lkuantb7shefymxj2mnzv4pgbiqbk4jkmmzeid@lurk3dam5tb6>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <10c3afd7f62c63db31a3d4af86529144a5d7bbf9.1702392177.git.maciej.wieczor-retman@intel.com>
 <fd6acf6a-2610-406b-b363-220121a45aee@intel.com>
 <6v4hgra7bd5nwubcgtbsidmoohrgxdw7no4faa4a54g4vrxo63@c6qnujvwn5ej>
 <73cea732-3757-4aec-a39c-4f0e50f6fb70@intel.com>
 <su2d6i22icynusoykmowfnzery6hlqugovaw4xcrhb7r3ymbx2@aeimvrxsc5xw>
 <05db3bdc-9d54-44d2-8aae-07d66053892e@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05db3bdc-9d54-44d2-8aae-07d66053892e@intel.com>
X-ClientProxiedBy: VI1PR0202CA0028.eurprd02.prod.outlook.com
 (2603:10a6:803:14::41) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CH3PR11MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 71fb576e-d8c4-40b4-dc7a-08dc18c17fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5FgsO31vkguDl2p/ef7s+EzW9lzoVsNm8DdyQweS7iSV5Dkl6H0SJQbJtAuXsrT9kWp+DEnKwlX4K5Sq10PPVJvyIfMLiIEC0s3KSdpaoMILe5DAsnVR6ImZwKQS8E8bq2wnswtcihu+p6ETCnwZfZtNvyIUEe9j2RYm1Lbo+CnPhMJs3BYl5dp0o1MAdN9wKJEc4bcmOD1wrNK2GnAYohJ52WuSdAg3nq2kccN7LdZtv6n5VvNLXLBJVU+SDnLoN/+HGRGvaHbfeLYjcpngxA61kPXGRyh7yOS8zAG847CAIEOykfM3Nb870YvsSF19sXQg85VhlmEGAupiCn8gmModXJQdT400jJhj/Y64iFqQ0t7Urfz89N6uilg9tHgisstWhm33vrGeECRdkeKsEeDC+rH2Yo3G0Wb7nMXVTqbuZlUYLvfZQIf8nVzNGViTCWBkfOrnLCTXZgf0Bfps69CSyKgQN8pPBieseSHOU8k04kt7guFbtovRkN6tSfHiG1xdAE4CNGu/UjZbJnlOcZzu+Fgaq6Rf4Dm+afI/9DKVVNGlPn+R//WiMssEF9P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(4326008)(6862004)(8676002)(8936002)(38100700002)(82960400001)(33716001)(86362001)(41300700001)(2906002)(54906003)(5660300002)(53546011)(6506007)(26005)(6486002)(66574015)(478600001)(6666004)(83380400001)(66476007)(66556008)(316002)(6636002)(66946007)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7weSkVE78NIxdDe0hJSj2FgOVThhret3LAjj0a4baEE2VgjuZWVW8JlXVs?=
 =?iso-8859-1?Q?65D4YMNLHEFwwFt1OemAmjNHhJKTTGI/80+pFmoWSM/vNAtm72s1mLGAhb?=
 =?iso-8859-1?Q?TCwK2Fk8U2emq+V06ua0abep2BTJbaw8BGNV9Yf63STJuRPgfYuqYNsovR?=
 =?iso-8859-1?Q?S8Ob47jWTIvLtq0PqRoRP+KVXfpeciGXQTHUbFxjPUUcjfqXnxnFfCroLG?=
 =?iso-8859-1?Q?VYV9pPFNnH3rN77hN22raF0FsISfE4DoBENlbziJfMWgKpkGfsCFxjhqYJ?=
 =?iso-8859-1?Q?zxcX3J14uIXmho5ar0ZCqOMNgB4sBFTD7fqW2mD4qvZDjAk7tsqs0XDcnb?=
 =?iso-8859-1?Q?rfbvw4u16GbyDjEmQCJKD6PhX1AB26bh3TcijTAfGwZNTb+8r0fkssB2tK?=
 =?iso-8859-1?Q?7aOWauqUVglj1oVimEcTRFZJvG439UGRNOZOCDg5mN5lhXErOPX4Usi0DF?=
 =?iso-8859-1?Q?8z11w8uyATE9qCiCpUo67AxUJ1ADbEaDrGwNZS1AGBGw54owJ6s1wdBMYm?=
 =?iso-8859-1?Q?4QTmUNCMuvg/UEjqcVAxpI/1EXxAKqrTlqXhhoEgJBHnmGFF/lkyxA9daj?=
 =?iso-8859-1?Q?RodWIIAvWbQK+ZAewYElpvqkA5UH+ZcnrahFC2GsqOPt5Y5E1M0gJ2/EWk?=
 =?iso-8859-1?Q?EejeI4eI4q+n8fAK09Zyfgz6HhMU5p5g6/50QpvVP+DXdgM1RwpNUubKWw?=
 =?iso-8859-1?Q?fQokL+20+edpynIWuNprnBhC7jMRaWw9A+z3ZjP//51TLyO7bQJJeyl6jJ?=
 =?iso-8859-1?Q?U3zE9/CcDS3BtJ+6BK/z3W79ocggHr8K/lOQiVRpSXHhh5gAqXR2+iCK3T?=
 =?iso-8859-1?Q?r/7pu/WlNljrv37dc4A9g5ofC5dgbmpxiCjOYcB82shT512/1fnxDjZJVf?=
 =?iso-8859-1?Q?AJVPUqxvyi9aEpwFuyp9OTjEICHm4ttIrUaPv7Z2FKkF1YnUIYrbscrTMj?=
 =?iso-8859-1?Q?GdDSlDEJ0riBB45CONKI2NY0jqstSkXXN5MIjwuHLmSK+nVGbUtsPHxjvy?=
 =?iso-8859-1?Q?Q9bqvZSIbHfvJnpopwBNbDaqACFh4xvQkGadTND/haeV5JqzLIvV3eJrdo?=
 =?iso-8859-1?Q?FZIVPbSbIKyohTCcHUxP0JsLUsnUGoKt7ZQtCUNWZ9eALxdTmiyJRdg0p7?=
 =?iso-8859-1?Q?na3/IOxsyve6m72QAQ+pzYK4T2Lz2Yn/uYHegym3lLyx9JKtpb6FCZjRDH?=
 =?iso-8859-1?Q?hQP8Wx/JTupFXWnb6upVIlE1bVzrMAhR86zqhhCHFaLFzn3/YJzj0SZXdk?=
 =?iso-8859-1?Q?sdXUGfFDOGgIOR4tMTuFdULmXCxa2eb1rw9IaCgHATBRodrzYfe/0SK0n7?=
 =?iso-8859-1?Q?0lRXGWa+n9HCQ1T0/ygVnogDWuaRkCWVqhozJY/+nB0+qsVVBN6RVQ417y?=
 =?iso-8859-1?Q?R0kRRqEMQKPzsJAXPXF/iclONQDLgbyeuXqmPL269+GW3XSf/k4M65CLSn?=
 =?iso-8859-1?Q?aW+CjRBroOjH1Eps5Vfe8qfNejaPZkrpZ/qPffob0PHRsvAUtgd+ZV5oEG?=
 =?iso-8859-1?Q?rSdoMue0huESsRMRpU97ct+Tj18BclYuf+DDlcrVxaDm1tEIOZsLSpsvMY?=
 =?iso-8859-1?Q?qURKOVZa+Lr/mvXSNXngvcUVUjCuvoARvaXetm+0yhnZ8ZsZ0q/aHwveQP?=
 =?iso-8859-1?Q?bq1/fdnxW7idU+4Wv7TTNF7tvmNeRyE8IlSVhWpmcniS3e6QhvQHoMDCVu?=
 =?iso-8859-1?Q?eiE06OoBt/RuLDVps6c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fb576e-d8c4-40b4-dc7a-08dc18c17fd2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 07:37:33.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16BRCpd/AXY12ZP0RXWOu9TlJZQ6oFfaHxCvvWiF2jk93aGc8dYOiMZ4BdrnzOtndfjozlfGxxtJuST7/Ma09Ad0PWsJnBMHfqhuzcPrN1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8493
X-OriginatorOrg: intel.com

Hello!

On 2024-01-18 at 09:15:46 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 1/18/2024 4:02 AM, Maciej Wieczór-Retman wrote:
>> On 2024-01-17 at 10:49:06 -0800, Reinette Chatre wrote:
>>> On 1/17/2024 12:26 AM, Maciej Wieczór-Retman wrote:
>>>> On 2024-01-08 at 14:42:11 -0800, Reinette Chatre wrote:
>>>>> On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
>
>>>>>> +	bit_center = count_bits(full_cache_mask) / 2;
>>>>>> +	cont_mask = full_cache_mask >> bit_center;
>>>>>> +
>>>>>> +	/* Contiguous mask write check. */
>>>>>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>>>>>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>>>>>> +	if (ret)
>>>>>> +		return ret;
>>>>>
>>>>> How will user know what failed? I am seeing this single test exercise a few scenarios
>>>>> and it is not obvious to me if the issue will be clear if this test,
>>>>> noncont_cat_run_test(), fails.
>>>>
>>>> write_schemata() either succeeds with '0' or errors out with a negative value. If
>>>> the contiguous mask write fails, write_schemata should print out what was wrong
>>>> and I believe that the test will report an error rather than failure.
>>>
>>> Right. I am trying to understand whether the user will be able to decipher what failed
>>> in case there is an error. Seems like in this case the user is expected to look at the
>>> source code of the test to understand what the test was trying to do at the time it
>>> encountered the failure. In this case user may be "lucky" that this test only has
>>> one write_schemata() call _not_ followed by a ksft_print_msg() so user can use that
>>> reasoning to figure out which write_schemata() failed to further dig what test was
>>> trying to do. 
>> 
>> When a write_schemata() is executed the string that is being written gets
>> printed. If there are multiple calls in a single tests and one fails I'd imagine
>> it would be easy for the user to figure out which one failed.
>
>It would be easy for the user the figure out if (a) it is obvious to the user
>what schema a particular write_schema() call attempted to write and (b) all the
>write_schema() calls attempt to write different schema.

Okay, your comment made me wonder if on error the schemata still is printed. I
double checked in the code and whether write_schemata() fails or not it has a
goto path where before returning it will print out the schema. So I believe that
satisfies your (a) condition.

As for (b) depends on what you meant. Other tests that run more than one
write_schemata() use different ones every time (CAT, MBM, MBA). Do you suggest
that the non-contiguous test should attempt more schematas? For example shift
the bit hole from one side to the other? I assumed one CBM with a centered bit
hole would be enough to check if non-contiguous CBM feature works properly and
more CBMs would be redundant.

>
>> On a side note I'm not sure if that's true but I'm getting a feeling that the
>> harder errors (not just test failures) are more of a clue for developers working
>> on the tests. Would you agree that it seems like users probably won't see
>> write_schemata() fail here (if the test execution managed to get to this point
>> without erroring out due to bad parameters or kernel compiled without required
>> options)?
>
>I do agree that users probably won't see such failures. I do not think these
>errors are clues to developers working on the tests though, but instead clues
>to resctrl developers or kernel development CI systems.

Right, I agree, the target group I mentioned was too narrow.

>
>Reinette
>

-- 
Kind regards
Maciej Wieczór-Retman

