Return-Path: <linux-kselftest+bounces-8415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3A68AACB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 12:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46330B216AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 10:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3337CF25;
	Fri, 19 Apr 2024 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bu5qyPGA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1DF7BAF9;
	Fri, 19 Apr 2024 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522109; cv=fail; b=kKDnNjNBSdsRBHpdg0K8Bq2hDJWK03oSgKjKBOflPg8pBDTzN880vnl6yn083S7UKxw2PGqYMKJOcrNpj2pYBup+lUO3G06Bb9A3CV3mHhKJ4BK4GGycZe5+ZsinM/RC6Exa2kz/uO0FSKN/lUAaMB/bF3Uv0y9/LouHZBUOfRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522109; c=relaxed/simple;
	bh=cDQxxzPiT3+qvmQBZiEfjthw6j/h+skwbQTJ1lB2TWg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NZC2TJ5csUd2gY7NsVNbKrGj2AoOF4dx1j0if4Ld2+96dUO7tBkfi/afRUGMKdLNdhqXi+u/9AAFsyOvMflEkcW/+h3l50FUbemh8Uzm9NVxZVNtCKeR9wlTSwU7qzbGRLjUAT9HMLCWr50t4vb68WK1ZmbUYG/xnT2j8uEIMxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bu5qyPGA; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713522108; x=1745058108;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cDQxxzPiT3+qvmQBZiEfjthw6j/h+skwbQTJ1lB2TWg=;
  b=Bu5qyPGAGONB2qVVjmItik2WZI69g1nJmuOghuppgIWi7z2yoK1XWArs
   afwrx/YzuFpv5u6m1VzK2TVYbC5SM+9J3oaFNKAh1vmcPD+EG49jFaMhY
   xe0WPd5b+sTxX+NhNW4jl18RxB2U1F/VN+qrX0rqL5o6vuqvxqWsosG2v
   YH2bMca1fc5zyM0B+F7lASAt6Yupva3mtkvAj6Mth0C13w2vuuamsc13L
   0FRc8+RKaiJRNwEeq3UldG9GHtYIwVO34ovGBsjRM6x/aTp6JP1ZGJjR5
   gRDf0KGTCPqQUS8MPoIGeRy25cqVecRckkjkKX8bTzCNJFr84wPJHDkCL
   A==;
X-CSE-ConnectionGUID: HP5Tu35zTEutmyd3hPXYMA==
X-CSE-MsgGUID: TBvOVHb6Qx+CQKl4+UYSPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19726461"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="19726461"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 03:21:47 -0700
X-CSE-ConnectionGUID: uTIFFEqeRKu3qBfp5ZRxtQ==
X-CSE-MsgGUID: KkDeNWXCQHur6eR0qS4Byg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23275652"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 03:21:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 03:21:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 03:21:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 03:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b01ZU3zRqXj4OGH8oNXF6VJxbcyvruMJEcq6bY/JjpSLBuW5q/p/RWoy1eYBGRVFpc9pkFJVEo6d1qjb1K+68yIPoUNjbo6il4sp0+YMJfAKG2R0EVz8DD963OSQdNCM6rvxFozyiq9FZM1KQKG1OfP8nBk/xlFgoCd3ec5fe6yPAsO6PL93y+VS8w76L6IF8yIVPc3jr7LWhiQVZvtnLs0FcHmoEZrTZQTaviItmWKTintPlHixMc1BQBux4Qu2WifIOtwiNc6uwRMl6Rv2OCo9TXZVbMkAc6998CtI/zpPWvrkk5sYveXWTndwkcvf1nvTQKzxOhrkYwax+BqJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDQxxzPiT3+qvmQBZiEfjthw6j/h+skwbQTJ1lB2TWg=;
 b=nr3w9Y0YJhgR/h+2KRNdKFUeYXVGtNauHNvqtaUV37nFq8uzb5DzNa6MQ2v7KgVffVUr9rOrzfcfVOqhKloDehjt4IjyKb/LZWl77PfHd1E2t6R1+Iw6VNy+nGsZDhZDc660qGjToYHdDdgFZT1205lzbbXJ9vaV1f62gbm029l28f4AyNH3A/xKpofFktduxjBy7Fh8rs7F1MNkfhPfUoVd5NlT52PqqJuLP/3o1ukIUe4YVGYdCLOiLx/jZhvi6x970Ee5eyacDTkZYLqFAda7AjevaRGyRirUhFKVu52DREJP2r5CfcdHfwDI0tF92YC1ZanUutr9GDBoAFpGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SA2PR11MB4875.namprd11.prod.outlook.com (2603:10b6:806:11a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Fri, 19 Apr
 2024 10:21:43 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.010; Fri, 19 Apr 2024
 10:21:43 +0000
Date: Fri, 19 Apr 2024 18:21:31 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<shuah@kernel.org>, <vkuznets@redhat.com>, <peterz@infradead.org>,
	<ravi.v.shankar@intel.com>, <xin@zytor.com>
Subject: Re: [PATCH v2 03/25] KVM: VMX: Add support for the secondary VM exit
 controls
Message-ID: <ZiJFq2XFKEukLX8X@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-4-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-4-xin3.li@intel.com>
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SA2PR11MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e3305c-b1bd-4d8b-1ab6-08dc605a826b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info: mq2h1YxTNUh/hqHnrzA2xvdsfD/YrIYU4DISVmxZduGgtXyR0ZlEWms3MC7cOgmf7fuWMSIxefieOxuqVYX1LiOG6RgK8Mvz2akKB62BGfTtA3epFsp5a40GU6K9q164zt5d+3vo7qfDvkXNCxirGfpukd6ZeB8RccbXf8idknM+5DAh7hFhz3vW/cwLIV5575k/Sm2/5qT6naUXsSk/XoMQfYqoneBta0TiLrQdBEeS5grhT4UXEke/2/VJCGNyEQ5P+86IPsa+aUfuLNFkJgpdwPCAprb89aPb2fgvxiB7/++9njvJFiwsJ/VmntLbuN+0DCUALxm6yvmn9qtHlWw8GcQks9hr71dtpu485PesflXmBUeWsmE/fRKOA8DX4MVpsqgcOG8skokXS7XWu7XuCm+M+LgWpxPd+v1C3HXULwv0dbpSUKtj1Z6oaDaCsJrhJ/+VqLtxwIYPictm/l6U4SzAlvbak6hLYZRfeWNWMt5Pmx3LAhqzOzuWvG2wN4mjklBAeGfShyY60E+ucXZuMfCjHxw/vkGYHkT9cxk3PsDSrWzlJXts/xd8DuGHmq9QHhKpleNFAMa0rrUNQq9sGFLqyHJcu1AIKTN+Wrv/HgGizDfAOn5oUkLLUtHX0D2fYfdeX09w7KqBd3Tyfsixx1LaBQZlx1NZIyFn5og=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aDFeJb4thG32DpqXoMbtw9DHH+e0zxwiTfCWIs19N30xJwn11DLPyvntg6BT?=
 =?us-ascii?Q?zmsg87Y7SIlK78Jt28ZDrpEHO050/5mEj7IZaFF7MkJrWl9NyHfvy6/Kqvnb?=
 =?us-ascii?Q?Eb9IwT2Xett7N7tLgXCpAVdIERcSWJMoY9oKqJu9NXw6GuSR4VzVmt6IxuCF?=
 =?us-ascii?Q?oWv6pvHrTkL0Nu/kFk3hDJXuvx8HduzpN8OsOj0eJ3e36ta90yzoYkehqVTh?=
 =?us-ascii?Q?ZTGKPCzK+ZsSBMQmh6epnQMbkknCnFCh+CH899GPMkDOLsXqItfDPMvpzI86?=
 =?us-ascii?Q?EkM+bob9gDtwK1x3uoKfDp/oK6AXneOTYFcAzV6jCqXrEplHz3wr3LUNnsGz?=
 =?us-ascii?Q?Ye5hBwZe1LsrYN3jCp3vk19If9EiLW+UePLHlcmwCB95Fpb4UdGrSwN3tlqn?=
 =?us-ascii?Q?+ZbZTfItBe7Qz5L7tRCAa+Y2lFX3N2rjYcfp/CHd46NoeJv/EDNA920xlWNA?=
 =?us-ascii?Q?nAJP2lJQ7peLWQPYMQk3kRKTWGquSAOuNTYyGfaTGB/L+w1FmBZ3oBAmtxAB?=
 =?us-ascii?Q?yPd6NWWOxrWjG1Ek0KvWDiJMNI5ph7X719+agQ44CNtHeTKoDpdtet3OUg1+?=
 =?us-ascii?Q?2o6WFA9YmUlIwmzlAZv7uwtFr6312QRy1EVCfvDey6Qrh4EnMSlQwThNAv7F?=
 =?us-ascii?Q?EmPgcbEBs/FjC7J3HMHQcvo6Ed9Dk0mvmc5cV8qnIisBmJp8KWpCKYy41Lci?=
 =?us-ascii?Q?ZO1nwW+MW3Q1qviLbXCcz9RUiKK5wbs5vxk6NAsAoxKIJUPoLaqOR7ov5rSN?=
 =?us-ascii?Q?UDAwh1FGI9uMed0KpXv5vIxbik/OdmDXDYCq3Xf1ZB2oH5oJTj5Qf0gHFWUD?=
 =?us-ascii?Q?vUXEps69cmnXzBQaDi83h1/j6iVMBboolsG6A/9noh799NsxYOKedmNK8Np/?=
 =?us-ascii?Q?7LYrOlE5eQ3Jj7lqSZughtprEIEFce6j9jVrFoyEtO5674tzNlxh8f0OaYHC?=
 =?us-ascii?Q?B2MXsvKt+qAAB8Gfb2expmcZ6EbFirRPM5FfGXtnd71kni47/Z2arA0RiFrm?=
 =?us-ascii?Q?zvl3N+58H3lqQtBlajaGDlmuRFkdYyXrxAVwzmCQZo47MF52C/7SFsfMK2Wo?=
 =?us-ascii?Q?/RYGEF9Y5Y0IeaW/YbB+2dJO7zyJl6y35ueJSO6AKICjkDkx2B/5HHjWDCQW?=
 =?us-ascii?Q?B2X698z5JZ/bvrOkk02qtwM2ZD+sa4BSRxme93u28ScU7dPQycPJVqBle1XD?=
 =?us-ascii?Q?2KVHkqMkM26GY9AMcVg6m3QfVWmi22bI8ouGSbe8vfwk3HnBeuienMAqjrR8?=
 =?us-ascii?Q?OHkKz8yLOjiEKI2FdjcGtiDgBZlqx4ysGz2PbOG2qk8a+u+Tu2DbBQ4Ic6W2?=
 =?us-ascii?Q?nQMBE5pRAUku5Wo76BnQ2SK1pURx50o9E233OupMrXYCdlpdOzB81XkbhLY9?=
 =?us-ascii?Q?G08K1mRbk/SOt37ZR0HdrqhB9V097IV/iqcLiDM01XAESNPr+DzFwupYRxkf?=
 =?us-ascii?Q?e1cMy8CrYxiDsk6If3wGl87Olbv5SIiImYk4naO2TwHWhEZc64wWbARv2iTQ?=
 =?us-ascii?Q?T4+WlS8McVI5/vBY9aeDNsmnQ6utDJGcZFO1j4QFMAIlJ7cJ5gKwELdz0kJw?=
 =?us-ascii?Q?OYytJsm8UygfxMneV6oPx7636Fx8QeJoOpKCmZIy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e3305c-b1bd-4d8b-1ab6-08dc605a826b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 10:21:43.2465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngxMoHZVGjP6P1z2GZiHO9YM2u8FRTrPT6TnPlSk1cgOlzq6eA53/X8uZjm5kt0lUtcz3w8zkxRYy+PKoGzw6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4875
X-OriginatorOrg: intel.com

On Wed, Feb 07, 2024 at 09:26:23AM -0800, Xin Li wrote:
>Enable the secondary VM exit controls to prepare for FRED enabling.
>
>The activation of the secondary VM exit controls is off now, and it
>will be switched on when a VMX feature needing it is enabled.
>
>Signed-off-by: Xin Li <xin3.li@intel.com>
>Tested-by: Shan Kang <shan.kang@intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>


