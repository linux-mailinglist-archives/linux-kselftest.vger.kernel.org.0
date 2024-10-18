Return-Path: <linux-kselftest+bounces-20163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B9C9A44C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 19:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4965A1F24165
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D022022D6;
	Fri, 18 Oct 2024 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moBPUYs5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2A126C18;
	Fri, 18 Oct 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272867; cv=fail; b=ktlCBIZkBhMqFZy0o0zZqynW+y9vkNxhevjMWUwCaPaGyJVv3zlOwz1SWOfV0n6IcqWGzrfMxXl3JVck5s61NVclC4z93yCI1f1xorS7ZeRJ5M1eCoa170Lo9VtBNx0rnTYtD1hIGPHGVHtflVbdfnyr6idRm+MfMteaU4266fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272867; c=relaxed/simple;
	bh=39ukFVx/whlsn16wyN0UM5EJn12kF2mNINMw+vSu3VA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dblLSZkbVM4FwXLrfxR5MxZPIBw8enCxBgMnJiA7XPhRVULu/ExAk75rE6k8DTSF4Fi+Y77YI+7Vws9RcFygtRVZZ4kT7DfXUskSp1uffOBQjbG1okxPYdUsdWa0ZoZY+lFmA76Xrg6LgN8jPv3TYvtwzAZq1GOtsiZ/FtmeOO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moBPUYs5; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729272866; x=1760808866;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=39ukFVx/whlsn16wyN0UM5EJn12kF2mNINMw+vSu3VA=;
  b=moBPUYs5PzyLhG+R7GCeaVc/1cKwzwrjYtWnmsd1N8I7I6azF25NHNox
   pky1hjhPnHoQC4SOuTfioVsPFv5dXLsJTXqU9j/4yaIHNrFxCPVlOAAsQ
   fnfBjV+BqZ6WiDH4AVY094XFRQb8Y6x3jaDfNqYOy2hkmxq412+8TocLD
   zjUlMeK6e+b/8frrST+S+4uYOB9TO+3a86tHJtw+cnY75dujh7n0ZyAFI
   O5vgE58tWSLhict7Xwz7hc0ExzQumAv4BNPh/I1OIwpxMzj89uzsIH8Vc
   mXmEIV1t8tRlGV+d5kcDYVeaR2rlb145AlPy/zA6rx4ppni6BctaifSfF
   Q==;
X-CSE-ConnectionGUID: sax3+25JS6uGg8c1Qdsgfg==
X-CSE-MsgGUID: gRcTku3mRO+3sx/fGjwI4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="39439440"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="39439440"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 10:34:25 -0700
X-CSE-ConnectionGUID: uoBnr/RiSvyk4LVts/a+mg==
X-CSE-MsgGUID: X1Ql1BXeRLCMt6EvFeNHNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83556283"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 10:34:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 10:34:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 10:34:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 10:34:24 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 10:34:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsdSNE3dt7r22+nmkgW8IZvmbMvnYKdKrnDNPlqaTtbXlci7hSYfUc6/qX1LLw5ad88j76iDV17WM6lmWHkoB+crA/+6PvAWaMGSilYPJ3d2BaPQm8sCwlHlxc868WuJq+RG5UxB+yeONDM5TQsiV4GF5nOYXVrxWXqcmpXYT0Xz2ENo7k9lrkLvJx80y/IAq/UR6QxdPyyXTrDbxljsS8gwX5o00pczmLY7ejpU9Vu5dDKZeQvCWFpFlDo25v/k6b6LChvmpFMxh82LWLTm4mV9MT8Nv0M6lWE+ulM5ltrfCBEkZSqzq02gfj9jyql/yKvsDMc/HhSmM0xZ5A+McQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Utn+PxRlmP0m1eS34aNG4Xb5G3LJ6q+ZYS+gCHW4570=;
 b=qVagpPbZ9j7oML3uIBFXzrA2D0W4XsiHUqmB7AJtYeSV+unyhwXpX3LXTlgrpnfsQdBt6t0nzqXYLhYCZ+Fp87GY5+KqE39EUlSYbaiZ1py+lX8DylJExO5neWA8hLPfbeWtZX4KrteCHJwFm7iRZoN9j0pr+hCdD6QX0km09CLCTEsMYnV8Ihbz3HVhuKMrPX/aat7142WIfxzawkPod9C+lDtWvMahip1ClqWBgTFYXo0AbRIfNQpAyVZezeQt+eIowQlOQmn00tlA0sPngRWoUQO8RZiKnuKegEvY5A6rS1xzZtOqnZkFdyhTJmliKK8D9S5sogpJ8yyD1gH9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7016.namprd11.prod.outlook.com (2603:10b6:806:2b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 17:34:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 17:34:15 +0000
Message-ID: <42afcd9f-48a3-4d31-a39b-df8c42f2e5ff@intel.com>
Date: Fri, 18 Oct 2024 10:34:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 02/15] selftests/resctrl: Print accurate buffer size as
 part of MBM results
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1729218182.git.reinette.chatre@intel.com>
 <f7c200b42bf514e587e88e5be6e866fa797eed66.1729218182.git.reinette.chatre@intel.com>
 <68a7ff59-289c-1d50-d454-ab2fcf6baf22@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <68a7ff59-289c-1d50-d454-ab2fcf6baf22@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:303:b7::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 4701904a-2178-47fa-a4c7-08dcef9b1638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmdwdS9mSHdHaFl2VmpiTVdMUzFNQjhVTFd1RFpaZzYyUzdYVE95SkxnNGo0?=
 =?utf-8?B?aXRLNzhoSDRDTHh1TElaK1dLSExSMk56dk93c21jT3VoVHlha1RRb2RDcHZs?=
 =?utf-8?B?WWZTd3Bta3dEeHQzOHMyU3QvVjdkVzdEeHF0dVNBTStzRkpEZWdtNUNCbHkz?=
 =?utf-8?B?cW9SbmhocWVGYnFBcXR6bUdCZnBoOHI2LzdNWjBMQUsxUXNzYWJMN3Zuclc4?=
 =?utf-8?B?dlU1elJURnoxdTNSbmxVcUEwRUlmYld0SExkcmJhdkFWRWdTT3lTd2JCZ1VM?=
 =?utf-8?B?OVBudWFXVFd3ZTc1M0I4aG00cTNRWXQzK2M0QXJMTklJYmlkbWV2eFoxR3dN?=
 =?utf-8?B?K1R2ellyWlEvWFd2ckNJVklzMDFEV012MW1TNUUwc0tVZTlEOW4wN0xCUUZo?=
 =?utf-8?B?cnFIT0ZNNHQ1RlEwRkE5QXh5UFpiNzVFdmZHKzlTWEN3K1lwejhSaWZoZzlK?=
 =?utf-8?B?UFk5YWdXMmIzbWJ5NUxQVDZQa05QZVlBK1psam9ydFJ0UlNweThHUjNsbkJt?=
 =?utf-8?B?bG1MakFHME1XQ2pnRUdDRFQwSXpid2hSSjF6Y080SlVaUDdUVFl1UjVHVHQ4?=
 =?utf-8?B?T1daT2VPYW53SThJZ2M1Y283WGd4TTVjM0xMQUE4emRjeDBWV0laREdBcmhw?=
 =?utf-8?B?ckMyQndoa0dQaXY1VE5JNjNYSXYzL3p1eTJINWFCUVRPbHN5OWxLTUN2VEx4?=
 =?utf-8?B?NWNRdllPNzVSME1mbjhXak5xaVFodGk3dy9CVmJBL2xZYnd1Q1FMNGdTdHN5?=
 =?utf-8?B?UEl3NnVrMkFrOXRZckRuK1FsajRySGxPZmhJRGNnRUJYMXM3cC9WRWlYeE1C?=
 =?utf-8?B?T2JHUk01NkVvOXM2dGxVNTgySEpqTWlKYVBDQTJrWitEZmtFY0dTTkVHZVE1?=
 =?utf-8?B?WEhCVVMrUEpEQUwyVS9lcWNvWFo2eFphcVNSSlkrZWgvWFkxaTYxTmphS2FT?=
 =?utf-8?B?N1NqNGFLTzY3OEFsdU9MZkVaYXU0MTQrc3pWZW5VdzBUMWNJSkZHQWgwejRL?=
 =?utf-8?B?dkpuakZZUHRzTW5acjMxcHhNeTlxSi9WL3VzTjN2dWs3MWRkb1YxYUxZcHV0?=
 =?utf-8?B?RFFmdUk5dThzR25OWEpuZ0lnZlNYWW1PWGM0b3YzREl0OFJjU1BaejZSY3Er?=
 =?utf-8?B?MUhMNVRxQ3hmYVZiMWRZOWRaUXlIbVVmTysxSHhSR3BoS1FreUEzS0orQlYz?=
 =?utf-8?B?UTE5aCtjWXhOVTVxRXVrOWpLbWgzNDJFUEhQWTM0M3Z2Q0NyVGhFUlFSc3p0?=
 =?utf-8?B?NUF3RHRzRkpVYVBnYmdZai9vbVJmOExaV2MvQlN3bENNSDQrLzdoTFA3T1dJ?=
 =?utf-8?B?RnVnNmxBajgxakFBZ3pHRTFMRzlSbUttNS9XZTlTbWxnVlJZSmhNdlBsVWRr?=
 =?utf-8?B?K0IyUzcrYlJKZ1JlMDg2SFF0WmdSNGkweFo4RUxERWlsSkQvTENOaUkzeDhh?=
 =?utf-8?B?SUhFNWNpTUJzeGZkRUhabE1TWGl2bE9jbzFVRlZFQVVCbzNyelBBQUhKZkhG?=
 =?utf-8?B?SllYK2RhdEdUTVRaZy9WTk4zNDdlZlVKUDJiTFg0czFyU2wyWHpONCs0S25E?=
 =?utf-8?B?WGVZamZkS005Myt6NFJ6VjEzSUYzbktjcDNDamQ4L0huTnRVOXV5clp0YjE1?=
 =?utf-8?B?NHpRclFOeHFDQ3EwajFhSHhPOFVnRzQ0ZTJGQW1SbkhjREdGa2xIZWd6aWU1?=
 =?utf-8?B?bHdub3VzTUdYOHNPZ0VqYWY3TmRFK3AwMk9yQ1hXQjdwWCtGVlhDNmM2Y2JM?=
 =?utf-8?Q?qXuF1xsezYds99B9wodKiYUZCNFKhkPLvOXLEhl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bitmZFl0KzhGTmZvWTNNb3JhazViQmpMMFFlVWRsMkxaWUhvcm5iazRTZEln?=
 =?utf-8?B?VkR2VXk2VExmaWpTVGIzc0Q4S2d5SmRxaVBibVo3a2c1QWxwVWxiQnpadXE4?=
 =?utf-8?B?enlzNU5YMjNvVTEzMnJTQll4Zml3NnJXR090Q0l5cXhKVGxzbUN3OGZRWE1H?=
 =?utf-8?B?OE1OYmlVT0RFQU5NQlNLQzc5QnFNdzlNZFp6b25GbnpOWUl0THZqcUdZSWtr?=
 =?utf-8?B?cVpUai9XUVgzemoxMkFYazZ3UTFhN3R6M3JLSWZzYWxOVE00YlE4QkxFd0lt?=
 =?utf-8?B?OFlHY1BzU3F1cUhTQ3Q1RWZJN3hKRXdGalJ1RGVaZWFMQ215MkRLRWtYTUc5?=
 =?utf-8?B?Q0s0Z25BZ3o3VCs4YkpWVW9zbkxEdlNsVnRNYnIvMGd4bU4zNHZMcnJKQkVT?=
 =?utf-8?B?RnRkc3M1WlJpTlJMM2JjNEFKdFhsNU9ZMEdpZlFlQzFBTzZJaTcyRlVnb0J3?=
 =?utf-8?B?Rzk5VXJSazc2eGZJazFidTArSmt6cmpnQXdxaEFuWXUyWlFwVjFRaVNNK0F0?=
 =?utf-8?B?eGZadUVzMCs5d3I1N3AwN09IV0lhTFFCS2M5R1d1cDdQdWNrU1FldHVJRzZj?=
 =?utf-8?B?SU1oT2laL1pQc1BVa01UK2ZoV3Q4Uno3eExlZXlURnlqeG5Ic0RaSE5QakVT?=
 =?utf-8?B?Vm1xaHZEU3JIYWhqbWN6OTB1VmkvOU16NUZ3NFJLNmZtdUNWRWVackxXK0lh?=
 =?utf-8?B?MktMLzhGbHVYeURNeE9LL3M3WFZ3YjZLa3lHZGVwUTh5NGxmUk54eURLZVh0?=
 =?utf-8?B?a3lqdkdXdERqUDRkOEdGM256SWNQeEJFcXp0WXhWa3lxTmRjeGhVOGwxTUh6?=
 =?utf-8?B?WTVIcWNrY1ltcDdXbTRQRExpZjlqNDZCL2VpdmdaODNRWmV3RmlrN2d4UUU2?=
 =?utf-8?B?cmNBZ0JaTzU1K21sb3J6VGIvYVZXMXN6MTUwMWJYc1F6bWlhK01rMGtocFMz?=
 =?utf-8?B?by8wT3M4S1BQajhMNFFsN1VBNDZ3SDNqRERUNVRBS09DaWIrcUIxUnBnd2cv?=
 =?utf-8?B?aFc0bG1mRitOVnJxVTBNbmxPQnZwNjJnTW85UzEzczlienhoYjhZQmhjeElR?=
 =?utf-8?B?ZUh0bHFCMGdOYmxjWUVpb2JHakZhOE0wcStDcFo2cXVJZ29hK09sTE50L29E?=
 =?utf-8?B?Y29HQ0tzWUhPVmJnNjcvMW53NE1sYktSVmc2b2VRWTBpdy9zaTR3a2s0NzQ4?=
 =?utf-8?B?UU5UdmRQU1o3WityU1pQaUFDcDRGamxBMHZkMFl4bjhMcmVORVhCbGtUOG9Y?=
 =?utf-8?B?NDZoOHVuL1kvcTdCVGwwOW5wcnZoOFRhQ2M5VVlpdzRjS1FBSVlpN2tqZTdR?=
 =?utf-8?B?M1phQlY5MVYxRmZGdnZmNkNZQjlTc1JpaTRhSm9tYVVab2daMlhKVGFqeUFQ?=
 =?utf-8?B?emQ0K05sa3kxbGEraXlJbW1KNkxpTjhsYlVPNjNVaERVUVdSd01jNitXenBJ?=
 =?utf-8?B?SFROQnE5UEdzcHFjdGJ1KzVRVUEzUXgxdVVzb1cxMnh0NkhkMmxadmIvNXlG?=
 =?utf-8?B?OWVxS2EzbEZaaFA3Nnk5NnNhNWNDb0FXaEoyazY1UU5MbmNWZm51Nk5BOE90?=
 =?utf-8?B?UlU1STZwWExyOXAySEhlQ1BjTllIdnhKc1NncnRieEVHL1lzLy9GZUVBczlE?=
 =?utf-8?B?WjBFQnNhdDVRQ1huRVdQek1wMHgrQVVuWlowbU5oSGoydndicE9tenpKNHNM?=
 =?utf-8?B?c1NWTTY4dGpyRUJ4QTllaTlRVHN3eHdncmVnY2I0TVpyZE1QVU9sRXpIL09t?=
 =?utf-8?B?NGRsd1hhUURtZUt3MFpFRnpwUStSRy9CV0V2L2x6SWZnOU0ySU43V1ZBTERh?=
 =?utf-8?B?OGpKNXk1VEFyaDZPN2ZQak5OSWQwK2lzaWhpcGVFdGtYdllvc3FzUEZFdDJJ?=
 =?utf-8?B?RUdIbEtuOXpOQzAvUVVwWkV1UFk3UWRtczByaXREOHl3MW54SGRUbEtSdFND?=
 =?utf-8?B?c21uS21HUnhWOUpKa254VnlScUdFNHBXaklIeDRyeVZHWmROSmpvK3FtVVpo?=
 =?utf-8?B?eFpDc2JRcGFvUDlOMWVabGpGdWhTQU1nNDlpbnRuRU5oRHhDQVZPU1pFZURs?=
 =?utf-8?B?MGVaOWlHU3JGTDF3SEViMjVZMkdPVDZBMHlDRXVZZkVGSWlOVTRMOXVmMXRa?=
 =?utf-8?B?RE11T3ZXQmhSOXlyMGlTZlBxRVNObnlpWEozMHFXNHVmbXZpNy94MUtpZkJN?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4701904a-2178-47fa-a4c7-08dcef9b1638
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 17:34:15.2579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXw4eGTtzJqI9zWDAfpEjHq31On3J4MhULq6JltkfzVeHHi0JGxFxA/gBEjLehuniVukU6Zmf6eVxay4Xlq8ZbohRGOdik1c4iF0azKSHcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7016
X-OriginatorOrg: intel.com

Hi Ilpo,

On 10/18/24 1:46 AM, Ilpo Järvinen wrote:
> On Thu, 17 Oct 2024, Reinette Chatre wrote:

>> @@ -138,15 +139,26 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
>>  		.setup		= mbm_setup,
>>  		.measure	= mbm_measure,
>>  	};
>> +	char *endptr = NULL;
>> +	size_t span = 0;
>>  	int ret;
>>  
>>  	remove(RESULT_FILE_NAME);
>>  
>> +	if (uparams->benchmark_cmd[0] && strcmp(uparams->benchmark_cmd[0], "fill_buf") == 0) {
>> +		if (uparams->benchmark_cmd[1]) {
>> +			errno = 0;
>> +			span = strtoul(uparams->benchmark_cmd[1], &endptr, 10);
>> +			if (errno || *endptr != '\0')
> 
> This no longer catches "" string as error. I tested strtoul() with an 
> empty string and errno remains at 0.
> 
>> +				return -errno;
> 
> Another issue is that in cases where errno=0 (both *endptr != '\0' and 
> endptr == uparams->benchmark_cmd[1]), this function doesn't return 
> a proper error code but -0.
> 

Thank you for catching this. I addressed it with the fixup below:

@@ -146,11 +146,11 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 	remove(RESULT_FILE_NAME);
 
 	if (uparams->benchmark_cmd[0] && strcmp(uparams->benchmark_cmd[0], "fill_buf") == 0) {
-		if (uparams->benchmark_cmd[1]) {
+		if (uparams->benchmark_cmd[1] && *uparams->benchmark_cmd[1] != '\0') {
 			errno = 0;
 			span = strtoul(uparams->benchmark_cmd[1], &endptr, 10);
 			if (errno || *endptr != '\0')
-				return -errno;
+				return -EINVAL;
 		}
 	}

The above does not address all that can go wrong when user, for example, runs:
		resctrl_tests -t mbm fill_buf ""
The above snippet will ignore the invalid value and focus on the issue addressed in
this patch, which is to not print DEFAULT_SPAN when that is not the size used.

At this point of the series run_benchmark() still uses strtoul() to parse the
empty string. This is fixed in the later patch "selftests/resctrl: Make benchmark
parameter passing robust" that will also be fixed to handle the empty string.

Reinette

