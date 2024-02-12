Return-Path: <linux-kselftest+bounces-4496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EA3850E1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 08:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483C71C204BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 07:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81D6747F;
	Mon, 12 Feb 2024 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqdZAnex"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E4B7468;
	Mon, 12 Feb 2024 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707723505; cv=fail; b=qfBTafvh5Fc5GVG5umJ1hlXYRrX41ohvvnsE9HgNfRiM9f1WubyD9/lUQouaSfbYotlQmMLc9Rd9TrE9ao7XdtC5KkuwPT+qLEqs9tdf3hr0tYJhMFatc7KXAYmDVXzMFMUZ4WXOaFLpmg7LCNvqRNzmizqjuRfPNtrXWu9CT/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707723505; c=relaxed/simple;
	bh=baEYMm6HwjiE62vmEBMnk6o4pgjPKfHHrR+3Rz2TUII=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mB9rHuGrzwVxBJaOi4dldCdEpwJh/PZAw2P3nNyTVH2EW+nFNwF2a8USELMNHSSlQ6xYTVV+aZ4q+neqspjpyxC0zAbHdR7QEb1jVa7hpzYi2sbWmINRxXznuJxmdEvQjSQ0qsm68+N6klPoBQrGgC1fc/7kIVvaGVY/LrQoEBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqdZAnex; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707723504; x=1739259504;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=baEYMm6HwjiE62vmEBMnk6o4pgjPKfHHrR+3Rz2TUII=;
  b=BqdZAnex3rKzXZS1pCnZ5JQS7wl/PK9oSQTknkr9+RnwYKWJFpYW17M5
   i+snzjVNHwfJXj+8gSkT9B35b4lR85GArNUL8OxrUzHbnGzCCaCvtKrad
   G1hWw8t2SYRPbbg0ZedtvzWxychu2nXwwuI1LfEi4Bj82wgLqoCwim3e0
   jWhonT3hzhGssGqBFYNLJNef5lG4lahf2AJN+uv34pCXelGe/QKDeiCQg
   CAQg1yEf3woBFEvP8OP20h5CkogNTJnnStEW2gYqX+Ba+NszbJVaQ31yP
   AA8amSMWxlCFhgKawfLJx6oeTyiQLgYNLw5qk172KGDxZDQJai9TYbuTA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="27132070"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="27132070"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 23:38:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2833056"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2024 23:38:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 11 Feb 2024 23:38:22 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 11 Feb 2024 23:38:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 11 Feb 2024 23:38:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 11 Feb 2024 23:38:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/LwuSNyQz4jmHg/TpHkPXgmwEAfNh81Utqe5uNhHiUebuNc6icSoibVcCaAQCBovqD9Y0VU0qMTrQxHVoAYE6IpP5tnsRQvlGDtEjssL8akgrd4+6vTXZ2BqyWhG4fJksWf8lrBpY4Hf39rAxYCE08+8FuxOPgAJNeiO5l4ulEn8zXQV9iTzOziJVmt2IsUAD/XQpsCR4ZOOBor7lwXpkDmEl/osBf0y3sTqnZWdEas1NoyikUgR92+9BofeDEFAbTAxQivBXjFaADxO/pIf0/drYste7ha7dC/Dd5fLZrdgNPYezT1/QtAXAOZsqGNyjVExaTAcjGi9D/8anM1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NriBs8++27JDT+/6JbvR6LzrclQsbikJPsvVumDDXVI=;
 b=ACTJeD8zGJK9/n4VeJ5XiJ9sRl4INYsJ/SyN3W0nJ7ihdqsogThJpDz6KLmAvPAm9RRv7qa0Cnf6PObVSr7Tj4Wb3hlpoV9BmU88mlGnPMWNiFKS70EilCKDVdgAz+qtOv5cHSwEkMRe6/m2XiZhwOhk5ceY3HmyC9DTSg+COr2YmZgRKI8pcuOH7BD1ketkiboutcrRmH3+V0fhlKV8OAFbgR6eik76bOocTjdlqodsr4PkbQtNxww2cPHLQ618EPnAhcTnFQ99Z0qrm5B9JVhvtvTTZMdDOzLO6mU4bfVnj28mwEQhMc8xFzMQnYxTQlbeNuZMZy0kGBt/5UgnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 07:38:20 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7270.024; Mon, 12 Feb 2024
 07:38:20 +0000
Date: Mon, 12 Feb 2024 08:38:10 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <shuah@kernel.org>, <fenghua.yu@intel.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Message-ID: <gybtxxilnj3wychwz5cdzltwzhhazx2dvzkyk7r3afqnkilja3@e3btzsz6odc3>
References: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
 <2c1011e7630605365b67caa6ddfe4e8ee2ba5bff.1707487039.git.maciej.wieczor-retman@intel.com>
 <b63354ab-458a-46a5-a80a-971845f1de9d@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b63354ab-458a-46a5-a80a-971845f1de9d@intel.com>
X-ClientProxiedBy: WA1P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::29) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS0PR11MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 4046db4a-d8b5-44ab-681f-08dc2b9d959e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEeqItG/UuXM33nqKoF8u4dyHjOQA9Ak9PtzpQShY1Oyh7PA/EGd3W0avq+Aa3NTE4EOLB4W7e+e4BrYbCW91YsrnUYaAZyQdKRbj/scEpFWWuHH2jtjqN7cZkmS2Iwg0X9mO2R1k/0afowXjri1WSEqAlfa/18ny5kx+MIS8Y33pbsCIbT5pD5Zqq2aMlRLRPdrdjUubN4Axgn3loGrO+TStLyVMSLV7kjs8Z5XoQ7ARXoddejzzQr3nwIeRZRSNx7ht0KHMK+D33bUE8nfrnD9snsjJTu3glfGp9S99pp127yn0TicLvD+YRuLIphz5lnfkHI470Ik3ZXkRmcfJXwZKsWm08hRHr6y/LertKG4yKmR0cWZ/KAEX7FRqZQN5+U41MY1oO2kUCuekYOVKk7/+GeTNhEBd+S+bgs0N4amMdiZWxk02S7qvVcoxgXfWpm81+UbbbMYXnfrJAM2VPIGPBUUEQrVOEc4Ubz+epB5WhWrYlSCZvoXMwEW8RyVEPBe7Vz6rfsqxdpweCQkUwxpI9cThvJzUytsiCgjbrq1EEJM5LadT4eQgKqjk+gB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(41300700001)(33716001)(66946007)(5660300002)(4326008)(6862004)(8936002)(66476007)(2906002)(66556008)(8676002)(9686003)(316002)(6636002)(6512007)(6506007)(53546011)(478600001)(6486002)(6666004)(66574015)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fvI1AOJWsaJ5vAt8uQpYVKeXghCuexq9fo8nKYwaEjCpu/sFqVLhtnIkJ6?=
 =?iso-8859-1?Q?FThDqeUGHSaUC5e6jLRzq4viZk9H61FcDsUwroL4x7XEB6VsD+Z7eZY4OR?=
 =?iso-8859-1?Q?+gIqF9Ec5D2s3VgDsHWPF2TvONqCoJsE9+Uiqsp5WBKPgDM0DYq3uykGZZ?=
 =?iso-8859-1?Q?8H0jBbKzpOv//EG39AwCMPFbnonYd04QuFE8MortfsCxWjZOpi2EFAmHER?=
 =?iso-8859-1?Q?a0b/L+js1DvVTRkVR6Lp0jierQmfoyaMcfbilFTg5i9vPsduO+EoApxzU+?=
 =?iso-8859-1?Q?WqdjAQwd9e+3cyixQrN5ziYmwhEEJ4aDdajjgObWiVZCRhcCOQYZb4yKUs?=
 =?iso-8859-1?Q?+QNtsIkA5580EyG+OJq7AYGpCrvH2i4CnPjR2frMi3SBK8NwzqAV3JFGF7?=
 =?iso-8859-1?Q?YbxaoxevoB0AjcqWXJ3IxSHPQYOS80Fe7DGFmQAnhFUcAolA8eUhEM5wbz?=
 =?iso-8859-1?Q?zBsWXAvv5VUMSyaNsJg0y3vrpdKlM9osrMgnOH7pRBUIugDokQ2I1IpYUK?=
 =?iso-8859-1?Q?5TinEap5dKBGlb1ZqfVph5MuXU6uMOUaSuvUqeSbt2gVZ0NV+R9AJz5VOW?=
 =?iso-8859-1?Q?VBUT0gQeLAcipsnj7JQ85Rq1Vz3j2EeiIXZdkEsFGj/f8ydaGPJlQAQ+SH?=
 =?iso-8859-1?Q?Fxdqk8zweNF/JWLEF7hlK27cwgBmVGueJ4IjhODg3QqyLazBrHNRkAGDB3?=
 =?iso-8859-1?Q?kwNQM03msjUKnKQKq5jkeBSz5L0R4nRdxD1rzICr+jM4dTwmtQnfX68ze0?=
 =?iso-8859-1?Q?yqHuxh8cAxqt94L7mzhflBv9Or/KRIlku2+/Uz/r6dHjyxCzHNqJ9clmc4?=
 =?iso-8859-1?Q?EADX/SdAKtyZJvbn5i67+BunpDlNKEL3Ic5qeFtQ/jLHu6sDxoGNPI6Vkq?=
 =?iso-8859-1?Q?CI5yRoQ94XpZjqvZZyCdiA/lMzA6PWf+F6rAHGajfgKsjbCfwdvmU+FG55?=
 =?iso-8859-1?Q?jDzZ9Q5kkeccUoo6+Tpd7waeeJvB+Do2xIFWhPo6SowhlGYU9l5wDPevuW?=
 =?iso-8859-1?Q?ufoDA6IPYHiM7tEBKDL8vGGKZgeJHyTwqGzemRa9ye53Gj/ulN7I9pDnVv?=
 =?iso-8859-1?Q?BgRNU3SIctBQwwbnMkOemCS/74qDlT8DXtxt3kse6iU0Jlqvk8vxqI6YUH?=
 =?iso-8859-1?Q?NdLMVJFneHHhD3Csx5wH5HsObJl1TR777s5xuOGFXdqAaV58bbQXcniYbb?=
 =?iso-8859-1?Q?5ov0nJXvoaXhFV0XcVO5B8BOosPPhiy63hEtvsm/vlysKbRcYW9uMrDh7w?=
 =?iso-8859-1?Q?rnNX1UYUTj+jcbkzrxg3za0pkpu8xFMEEPA9l/tAx03OVZusACr149J+Zt?=
 =?iso-8859-1?Q?xV96YUzZNLAcl21vEfqPgCJkSZuBuTGlGerzMq9ouX0mf33cm4CgC815SE?=
 =?iso-8859-1?Q?7x7/gKQyrDl0z8z6Il3pnwsgG9Hu/wi9c9bKHkcKFSuoE+yRt8vAzsG+/r?=
 =?iso-8859-1?Q?lRseyQCNhBz2d8anv5pK9xxdxsl9Sunp0M7Ink+luHEnf8dVoADQktckmf?=
 =?iso-8859-1?Q?w4+234D+HY50obG28ZHYJ9BYv4pZcHH+/heC4E3AarHRUGgkwkmeTGGjbn?=
 =?iso-8859-1?Q?KJnnOZol6hi8pXBaTUZfo6oIPj6rRkl0yz5MJtNA7QT/iMCdin/r/ex0I8?=
 =?iso-8859-1?Q?HmRjdAIcbIxeY4B+g+PmD4REAgGZHckVqusTIEoayQCxTgwT8Fh0FdNh5m?=
 =?iso-8859-1?Q?suHLo8AwtNyfrDoukmE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4046db4a-d8b5-44ab-681f-08dc2b9d959e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 07:38:20.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/zINT5/fg0T/u28b1Sqc0IHK9rV5Dk8EN8+yP3FRwojt6v35SU5bPlJa0JRyhPq6sCxaGeAyre8XaAu5Y+3q1pa2UqiStdC+oyYm3MYCGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557
X-OriginatorOrg: intel.com

Hello!

On 2024-02-09 at 09:21:16 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 2/9/2024 6:02 AM, Maciej Wieczor-Retman wrote:
>
>...
>
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 39fc9303b8e8..d4b7bf8a6780 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -294,6 +294,71 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>  	return ret;
>>  }
>>  
>> +static int noncont_cat_run_test(const struct resctrl_test *test,
>> +				const struct user_params *uparams)
>> +{
>> +	unsigned long full_cache_mask, cont_mask, noncont_mask;
>> +	unsigned int eax, ebx, ecx, edx, ret, sparse_masks;
>
>I missed that "ret" is "unsigned int" while the test expects it to
>be signed ("if (ret < 0)") and it is used to have return value of functions
>that return < 0 on error.
>

Oh, sorry, I'll fix that.

>
>> +	char schemata[64];
>> +	int bit_center;
>> +
>> +	/* Check to compare sparse_masks content to CPUID output. */
>> +	ret = resource_info_unsigned_get(test->resource, "sparse_masks", &sparse_masks);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!strcmp(test->resource, "L3"))
>> +		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>> +	else if (!strcmp(test->resource, "L2"))
>> +		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>> +	else
>> +		return -EINVAL;
>> +
>> +	if (sparse_masks != ((ecx >> 3) & 1)) {
>> +		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
>> +		return 1;
>> +	}
>> +
>> +	/* Write checks initialization. */
>> +	ret = get_full_cbm(test->resource, &full_cache_mask);
>> +	if (ret < 0)
>> +		return ret;
>> +	bit_center = count_bits(full_cache_mask) / 2;
>
>It would be nice if no new static check issues are introduced into the
>resctrl selftests. I did a quick check and this is a problematic portion.
>We know that the full_cache_mask cannot have zero bits but it is not
>obvious to the checkers, thus thinking that bit_center may be zero
>resulting in a bit shift of "-2" bits attempt later on. Could you please
>add some error checking to ensure expected values to avoid extra noise from
>checkers when this code lands upstream?
>
>Thank you

Sure, I guess I could make the check 'if (bit_center < 3)' to also check if the
full_cache_mask isn't too short for some reason (since later 2 is substracted
from bit_center for the 'hole' bit shift).

Or would this need some comment as well (why exactly the '3' is there, maybe
write something about about the minimal full_cache_mask length for this test)?

>
>Reinette
>

-- 
Kind regards
Maciej Wieczór-Retman

