Return-Path: <linux-kselftest+bounces-6297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC787A5D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 11:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993341F242FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C847F39AC3;
	Wed, 13 Mar 2024 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0grf9Q2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91E2E648;
	Wed, 13 Mar 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325638; cv=fail; b=PxnG6prOTTJz6h+G4ph60o9ULn+ck4vGXjFU9UmaRsKJaIZZbDSyO7X7aJMJVoagaj1Q5tkKCTGehcY7OLPhaO5NTGBbe3C4Qty1WdS1ouRIqxg7YO2cJt55w8hQ4ZfXyo4Yyhf4XaO1xpVoZ9htCneRS/rx0k80ytz0kKHbmKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325638; c=relaxed/simple;
	bh=i3jJhBaF3kCptyHzC19GD1pQBPYAbTzy8Ypc4emF9nI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LH9+VaEkiM674XaWgaGmd4UW5r2BqfemUMJPmuNcSD1QjQOnAlYe9SAXrvNFQEAAcB9AFVIT/tjZCp4VCrmRY7MK+p8935K3ToEO182bKsYaBZy8vBe5BCoiMjtuQ2LDKm95V7WQ0wxTKNi8rB0x83NmRWP7jt/MDSdX/C8Fkn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0grf9Q2; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710325637; x=1741861637;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=i3jJhBaF3kCptyHzC19GD1pQBPYAbTzy8Ypc4emF9nI=;
  b=f0grf9Q22JfhXu62LJP4H4Nx8amNu/rOKoRSjvQZ0l9WyReTpTyLw63M
   hm+t70169rbvgfi6+OmbKI/wwGm82DZPTt8taE8ILlMBjZ/iS0MTD1gRd
   DerqPjs3/6O+J1P2DpAm/XHZi5LmSqj4xQPfhd1EXBFJ5KofCX+gXAmgC
   +Sc5alRrAUH7fnKFispyFasd02+R7kr8YXlTS4d7C6zrx7LtLaLZ07e6P
   nt3r9hTS84huEgWP+111tvf3JKYfxN0p1nNCImPQ0XDkZZdJV6gGXPIvl
   0XcVzX5Wb6Kou2GI4pJt+GlVrO5NRsN9fxKz6ZFqUy+57W89XnojP0zRC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8023388"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="8023388"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 03:27:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="11795583"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 03:27:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 03:27:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 03:27:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 03:27:15 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 03:27:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntJE054fhgp9Kzpk64MW46MPEz+TChSgMxqFOxMSrsB7KZhAABMcWP9Wtv01r/DjGXjl+afSNvJJqa8jyZy4u4oY21sUEyrSMpEzHyTgAs3G9vCTpPdjYMSoEr5kgdrdrKbVgpqnIx2GkRxvKV13u2ZtDCox1vdEyyMZfaTTZSkFMNgvaDcHe//auMUUXM7ryiT8VjeYRNQ/7Irrx2k7LQS9BYuaDr30SFkCdna+YgEycuMWWKIj584QEIQSpTwFMqwwuKpbGEC1hS8ZUCuJgjEF8LsoNXt/20N3L7VqygydNZs2R+g+75kBXW2SOju8jnqIsU+Awy7QwaBK/0E9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swfQ36sX5ZE7jTNg6MZGeqvHcEEHzJKE4eG9AO+Hvrk=;
 b=fQVT19hvBB5PGxfW3/tm+Hu43qoDuVCtFLj3t34mTEDiaxUHxzevo+MX+JV3Kqu2LqA2cClgrGECaU5yhx3kXzkrZVGqRy+IXydi8ZoViTDJrNVEkyygroQfGcJYs4zREVtfw8qXcBHPi5N00eW42PYuDP3CkWLe59Q9lNY0+ofpJIofFKEByvZv8f4vmsVfDpY/vBCQweHR6cM9eCN5BMVFnD3e0J7yDaZqEuPSCGyMIStpDnCV4YEBZcp8NNf8BXRfXgnqHV9bHKCBpOXgQFH4uHIiVwtIclgpmcytpBKpP64NdGyc7h4qeEEmWivR9NabHhrRCRK45EOA3h9KDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 10:27:09 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 10:27:09 +0000
Date: Wed, 13 Mar 2024 11:26:58 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>,
	<tony.luck@intel.com>, "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	LKML <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 3/4] selftests/resctrl: SNC support for MBM
Message-ID: <jue4sarmmgp7i2vtx2kc5xmngp7oav6nihijvj4pkgpf5swz3k@mapj4w3vnq3m>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <def02de22a4747ed56ddc28f334e55872ba95f13.1709721159.git.maciej.wieczor-retman@intel.com>
 <37bd082c-a187-43de-892b-c5fa32a8b3f2@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37bd082c-a187-43de-892b-c5fa32a8b3f2@linux.intel.com>
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA1PR11MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: da64014b-c2ba-44cc-1dbc-08dc434823b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7gzUey5wBmeK06EhqmnLTJUOvsSFqUbJc694jYRaxbmHetUIiEhmhdMW3QE/glB6B2akn7GAb+fIyR7Om70GVk7zdLHvcjakLY+woXUTfQ7mlsh5IVxu3jiF0p4mmTXnJtxiR/ZaqVeycfMLeZO7kwiphMh3+XFJTrfDx2y+UIcPhq0+5utA70Q8AVpGgXrzH4e9NGfOMMSNhOiAdik5H+Mw6VyNe4V7/PRd4LY+c9oVvroC8L5Tu8HZgW0cIRflG/AEO6fS8wLWE+p5Uy7FZfsEv/dJKfSrqLHPkrJAIigahjL/AoWx1bTZ0fEO73lpF3Fmsx2VMp8p19IhbmDpmfgTwTqKDiytoh46mkg8U6ZnGRtc8244hjDCF+VyvAa39ahhTQmGCROc7RMazVyUTKEx3xSZNvcL2RvoK6sRnyJI5Rk7pMApgL14JVtuvvdkPZURxVT0RZ0WtuImqlLeBGKSErw7+uB2p9GExzzP4liQHGJsz54qFhsjsCksUdQDm3Jxbp6J2AGEmNyCNB7zuESWkjlI72HfTfeFpqy2S6XfFPwCP3lcCsZTEe8yFbCnOZtao88qUXe9OUjILL5o8V68OU55MK6BQSEiRev+aM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Pw8KlkJIQb1qzohZFQW9Ztct9RiaFJ6Ik2KmJk/gdazHj+r+kS1Zhew3Sf?=
 =?iso-8859-1?Q?Weav1658S8PmrWzjZZEa0tCFUxW9WzaxmW9ctgPP+eeaphjoLMTRkpJtqk?=
 =?iso-8859-1?Q?8S8Jqd5/7tJcs+MXOjE2Qi0/7UpS2YzfsBUDgRZjEa4I3ZpFXfOphJpXGZ?=
 =?iso-8859-1?Q?0jpoBHnYs+Bu0nagyrtNYYRpAYEzKtGCaXMMFFHFq0ocA4EP1oQSitbu1F?=
 =?iso-8859-1?Q?lZbjvQsfiAWt3QS+vqOy5Kw8pJq5cuYF3u7XZeH8Q2mMmTsbsSBVYupe2q?=
 =?iso-8859-1?Q?DlHjb3033bWn4tDl2ZL4nNLztqbE1enpgTahrLJBq8AthupOdDz//v/yVZ?=
 =?iso-8859-1?Q?95E35eEGomvbNo6sT7Xzme16owW8H1yiWBAovA0f3LuXVcjxQ4Ge2M06T7?=
 =?iso-8859-1?Q?NeRtJ3qP/jBeXD6ys5JouWLzTJqnaOB1mF+01miImuRduXd9mzhEe5FrD0?=
 =?iso-8859-1?Q?tEVGedfqMMVJiW8/ydzl0RnK4bSMOFd0bhk0N7CTQd4x7YeBfHGn6C4xqP?=
 =?iso-8859-1?Q?Dd8UCIA/iZEvSb5qRzdJ2WOr2sWV6SHqnZIzXd9fUzDHz8W+HkD6b/go2L?=
 =?iso-8859-1?Q?jXtIueAVtZ+a2azNIWwkRRaWqQ4sA8OyTECCqVEXT8UPb0mOxJ++KzZUwL?=
 =?iso-8859-1?Q?UDqw/5A1Q28F7dGG9Cqx3xfykCOj6N2o3aqOj2IOFlM8Sw2HiqfZ5+IZfe?=
 =?iso-8859-1?Q?MmavqUdPZ7rAT6zDQC3xkMEWtE0JevPU9oC7UCVhHegWOfnjpZk8V77t56?=
 =?iso-8859-1?Q?QqrCp8+HG4e1jtTYAfDAS1Qgh9DRUjWCJjPTiaIJ8UTCWlAbXz8rkOxJuf?=
 =?iso-8859-1?Q?R6MpWfT5VYA4CS7h5Ssnyeeyr35MilFSJdT0PmejmsvN57RKcX7v+37/L4?=
 =?iso-8859-1?Q?pbh5cy72Pzov5N+vJIA/1vPBf0aEo8WB1g3QVf2/w6xTdvvoibsupZ6uHq?=
 =?iso-8859-1?Q?2CEpOOVuTadybGWXRnpS+0qcqNo7Sj6DcvXSd3IUWrA7b8n6q3JM7MEE8g?=
 =?iso-8859-1?Q?GP+6XWQQFe6gaPYsyemB4lYhDPImVCxbpUT4/Frz3eZgV9QoYk8/aq0Avz?=
 =?iso-8859-1?Q?T8umNDViaHAIxGNiSeFV7Fc1A6G4BHA/mpofpHo25ICjWmVt/QuGhMbEf1?=
 =?iso-8859-1?Q?P0n9Px9gFiNO7GMQgjHFMuJM54vHdEZR2ss4bKebufC0gD25chQ5bounJh?=
 =?iso-8859-1?Q?FzZKZ98CI2FqDNBXA1TE/AtHbmslBy+eO/DpfDrvvwF/QZDoftEzeMB0QH?=
 =?iso-8859-1?Q?KmrcOg3YO8bR0LMttP3gzUHh7sMWRjp4gI075ldDSDKF4FOe/B6X8y4F/C?=
 =?iso-8859-1?Q?qprx9V7/MEYoUkb//n/7FO9GxWYRE9MOgcMsxJKER1Mi3HajBfnKZvirDV?=
 =?iso-8859-1?Q?6yych6+uhXzJO9Fdf8NuGvYmHYJT300fe8HGFZcDz7rv0r+zQj2hHXlcFN?=
 =?iso-8859-1?Q?0SHN9RyAPEsFvi9USi9ffB6L1RRWfL82YBJHqUVtBZtQGG16dKXO9Ljzcb?=
 =?iso-8859-1?Q?TD1qSLo//nqDY0M28e43n5inUwAvL48hBwPuCrPu9jNqo46OimXA9qg3H3?=
 =?iso-8859-1?Q?+WeICT7lo34Mic6p4COz4WI7TyOoKUJv9EHWo8GTNMivIUb2e8X9M/pPPA?=
 =?iso-8859-1?Q?IYiXjy8NjRrEYLoA2W8cjCjpMRWZ5pDvMNNc+Sx0U8vJDFsd2NqUVS9hjj?=
 =?iso-8859-1?Q?gM02o+9HjVfJtooL9RM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da64014b-c2ba-44cc-1dbc-08dc434823b9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:27:09.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fgvql4/aTg8Sq20LZygtEQY0RSmI3Ln+BDkgcWxvGjpGm3wSGW/YSYQtUKyCJyqzEvk+Q0lwXaikHDvacjf9Tp2xs9K0CdnhuKvTb6YIek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
X-OriginatorOrg: intel.com

On 2024-03-08 at 16:07:05 +0200, Ilpo Järvinen wrote:
>On Wed, 6 Mar 2024, Maciej Wieczor-Retman wrote:
>> @@ -697,12 +700,16 @@ int resctrl_val(const struct resctrl_test *test,
>>  		struct resctrl_val_param *param)
>>  {
>>  	char *resctrl_val = param->resctrl_val;
>> -	unsigned long bw_resc_start = 0;
>>  	int res_id, ret = 0, pipefd[2];
>> +	unsigned long *bw_resc_start;
>>  	struct sigaction sigact;
>>  	char pipe_message = 0;
>>  	union sigval value;
>>  
>> +	bw_resc_start = calloc(snc_ways(), sizeof(unsigned long));
>
>While correct, this seems a bit overkill given is MAX_SNC = 4, not 
>something large or unbounded.
>
>This patch would be be much simpler on top of my resctrl_val() cleanup 
>patches because bw_resc_start is only local to the measurement function.

You're right, the series will get a lot simpler rebased onto yours. I'll try out
some different approaches and comment any relevant points under your thread [1].

[1] https://lore.kernel.org/all/20240311135230.7007-1-ilpo.jarvinen@linux.intel.com/

>
>-- 
> i.

-- 
Kind regards
Maciej Wieczór-Retman

