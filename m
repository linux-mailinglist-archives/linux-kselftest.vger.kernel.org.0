Return-Path: <linux-kselftest+bounces-16368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDAB960178
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5288B21455
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 06:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1272D13DB99;
	Tue, 27 Aug 2024 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ng05BjsN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2614DD51C;
	Tue, 27 Aug 2024 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739701; cv=fail; b=qfIIK543g1FGB/+ewZio1qrUoJ6asF0uWfJA0cC9DxQ9+E7/fjMW7dF0Yl9ATkvObpwoUn5utpeSFY0Fs/bX2FeN/wMHEkGn2RPtwstLfKF84HauVRy1GXQSx2jeTSIUwh9bsLOdsx3JOfmOMLgvVf/xMvY1mnEXt0A6+fPxPBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739701; c=relaxed/simple;
	bh=aX1/OykZTzxD43V3+uCPM0YZeM+4VKHqAzulx9Zna1k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E33Z9HHiyFtCbH5pj/H0czK0NCuPg9eJvRv37/yH2TrZ7UV9b3Iw9hs+O1PLslHM+Q4UjicqNJBIOwjvROJtwQS6rXXZEiowt5xbe8TxMAngS6PKsfKg9PAAGN5uOuQoWpPu8UFQ9T4edWDggT2DQC6F+7TW0cprmlO8PTucaZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ng05BjsN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724739699; x=1756275699;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aX1/OykZTzxD43V3+uCPM0YZeM+4VKHqAzulx9Zna1k=;
  b=ng05BjsN8MXiSypk4f78NMOAmvS65VMc2LZ4NP3NcS8u7gELg7crRkHP
   BlXCpRIpyLS/e20lX7Ku+d5dElQ39pHBaddCKMRTVcM+Jn5js436zr+8n
   HiE5OZCCK//1gHFHAfB2Nog77KkCF4km7ySO1bB7m3T42MiX8Y8VLuhGY
   tsO/hj5KJ9PAhE4auR2wC+pZAAobOYWHJ3sGJwZmamEh9JtYZjxloC61u
   Lx2P1Ndw+6jsg/Zr6nWX0aTgdwP3OFcxY0Zs9QpKiabhq4X+b5PrIcVk4
   LN98z/x79x5Z6znS8NBi5upbggZ3RUW1NDYfp/Ev4582LUzGYjiB2UvK7
   w==;
X-CSE-ConnectionGUID: gZ0QOsSDSM69VLXZ9I9fuA==
X-CSE-MsgGUID: QdG9xdJjQXO/V9Ni2zucEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33821266"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="33821266"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 23:21:38 -0700
X-CSE-ConnectionGUID: Z2yMzIh+ShGF8zqmKCkoHw==
X-CSE-MsgGUID: MxjtZBBjSwmjTViN5KR+zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="67098858"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 23:21:39 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 23:21:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 23:21:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 23:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilVeU5aK1IbwS7VeLVLweFhTenRJGLDHxdTfODv/RXz28OTqN7QwrIzy8N6PwNuvOapGIUSFIpRFtPFGUi/jjl9c47dedUp1ekwIhr9sC3GDBr5QMwEFwcDdtPzyExYcRuyi5ANp9ZTAZGKCksZB/IxM5jtlN0l1jMfxpQ6PQtf4nm0CUEnL48on2L5QIEs+fosjCBgo+ZtQ3DVhbJ9EE+nfC8L62NzduBeiD3fslDYpCZBVhKYRVnlNplY2iwjS2EtgNFFd1o7jH/RajJKUVohMLj1xUDhIDubMSMtK/zdjuBUB12RJwgfQ9n8lmkgFdKg2vh4poXy2kyLm3OYF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0uXYZT6Td2sgVvmc+cDIt7s5nJ0plTslypg1lA7KdA=;
 b=A1dhXBD9R/1X1GDtmZiV1iz4bezobyNlm2A2UH7DyZTTC+Gv4klNhbPtEA5CbXbxWbKsVa1Rr6Q7bG++WT7u1xdIaxJdU+ZNpeCHlUw87NpNouJmBRFQG/zGJ9uJmh15okV/N6F9Q1LQSxkl23ZFVMfvzG+tLVHMZACAMmAP40WVJs+AwBL+Rmb+8XjFkmLo4VgU3z+U6dHybIqK/L6GfgnqSpqr1Ppq20gpJoxPMWzsZsZFqYxApzeRRFYNcp8XZ83UVkNrPFKrMcFqOZk4IGTzmudqT8CpLOS2lN/VYJeSjeGFkfPuD24xH5JUfNz7qvo4HNxIjLnkkPAWxGavwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA1PR11MB8197.namprd11.prod.outlook.com (2603:10b6:208:446::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 06:21:35 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:21:35 +0000
Message-ID: <3312a4a6-97f5-4ae2-9527-c7b1b73da6d2@intel.com>
Date: Tue, 27 Aug 2024 08:21:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 1/5] selftests: forwarding: Introduce
 deferred commands
To: Petr Machata <petrm@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Benjamin Poirier
	<bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, <mlxsw@nvidia.com>
References: <cover.1724324945.git.petrm@nvidia.com>
 <d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
 <05b9caf6-ecf5-48a2-ab65-509b0d5b5fb0@intel.com> <87o75f8e0l.fsf@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <87o75f8e0l.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0143.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::27) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA1PR11MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d43803-dfba-4804-9601-08dcc660803e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djhJbXFqMit1c1FQQmpDSkdldTczb09YRjc5ZXpvNTV1andXYmd1Z21pdmU3?=
 =?utf-8?B?WDZGTmRWZGNKejJMS1VuODhpa0o2QWUyUm1uc0Fwa0FrejB4aE04MTNKUzRs?=
 =?utf-8?B?QjVxNVZacC9BUXBPeVFiaDU3VEpIZ3hnS0J6eExyUHRZSGlDODIyWG5qTXMr?=
 =?utf-8?B?Q2hjTzM2ZWFWZEpSTDVzU2o1b0ZUWGZNSXRYbjkzOENZMXUxcjVHcHRybVRu?=
 =?utf-8?B?Z0E4NCtHcG52Q3lPMVhTa1dIdEc1c1RwVm1LS2tDZjc0RXEyNm1OL0hNWkcx?=
 =?utf-8?B?OWdvQkh6SEhtdU9UdlpaR3hNWEp0Ky9ZQmpmYk80SFZHbEx3Rm00cGJFT1V5?=
 =?utf-8?B?K2c4T2hrNXE5Y292SklWL053QnN0d2Z2WUtFWDFZVUNpUXRGTXpSc0ZEbEhN?=
 =?utf-8?B?eWgxbDJaVEFUVGdxRks4WHJOa3RWM0pyN1hpYi9SNm9Ha3VONHZXd05ITTdo?=
 =?utf-8?B?ZC9lSmtRWjNwZ09acEwyc1dITEJKenMrK2lUaFBnR0hlYWdCWSswdnM2RnVL?=
 =?utf-8?B?eG5IazJPTmZ2aGpFVFpsRU51UjdkWnlqNWVLb2dYVDNMVjlGQmJMdHdRUEU0?=
 =?utf-8?B?RWdjT1cwMGE4Q0lYZlg5LzBXSVg2UVBicEZCSnc4L0FMbHBjaitJRWpCQVB1?=
 =?utf-8?B?OGJBUk9OUkt3YnQrUHNOblE2ZlVLNW00aFlQVlhNSFpHYWlrUW9XSVJIamYw?=
 =?utf-8?B?SVc0UEJCM3FUcU85b2pCaVVDSlNPSi95bDBuRnVveWZ4Uk9DeFNoY0RaaGk0?=
 =?utf-8?B?OCtQZHVxRnVmVU9sZGVtUW1SdTF0RmR1S1ozU2I5b1dYcVRYMFlEcWJTd05V?=
 =?utf-8?B?OW1LaFNsZnJZU1BnVmVLME02eFJzb2RZdy9lYUdoZExNOEJqNitOWmVya0hq?=
 =?utf-8?B?WDk2and3cWkyeU9KNHdtY1dzSWhaQ0QwYVlVUTlKcDJsTXQ1QjhDcnpwam1m?=
 =?utf-8?B?Z0FYY3d4LzR0SzR2VjBua29ZRUp5a09TbVVJbFkveUdTQUJXbmJ3QjNpaXpX?=
 =?utf-8?B?Vng4ZjlyS1QwcWNVSm5EOUpQdUQreklEYXgxOVNXZ1ZwaFViVU9xb2hjdzE3?=
 =?utf-8?B?OVd4RHZmNkdBd25oSi82cXBlcVFPZlNtV0NWR0JrRHQ3WkxWWXNQTnF1YVNH?=
 =?utf-8?B?WDMreFJaclhkM3kyRXh2cCtSd2JpelJISnR0eEhxakYvaFFZUEliUjQvQlc4?=
 =?utf-8?B?M1hKS2tMbWJlbVp3MGlDQjZqcTFhTzJLay9zMGNiQ3NETWppaVYwVVRWdkRJ?=
 =?utf-8?B?R2lodHlVWXhjRXpDaVN4QXNmVDE5MEpzRlVSeVVyc3RtWklFVDhhOVVKUk9n?=
 =?utf-8?B?SlRzcnlxdmhicEVSNTdPdFRZUTRqVzExQU5JQmk4RFpEbk16ZzdsVFo5N0Zi?=
 =?utf-8?B?Q0t4cEp4amJ2Z0grS0JmTytlT3BPaFBFNmk4aHlkM1dpR3ArR2Y4cWdtQUJX?=
 =?utf-8?B?VTYxN3dwL3QwMlJqTlNaTVZpMlNnUnNDcHI4UUdJeW5wYmxwN25oalU4Qndy?=
 =?utf-8?B?bStqNDBzdW92THJ5YkFlK1ZicktjVWloTFhHVmpKbURlSEhwZ3VXQytJZlZH?=
 =?utf-8?B?Ry9semZaVng2emdzOTd0bTM2emlvOVlQcVBET2Myd0ZkWnlHUVBXbWFsQTNP?=
 =?utf-8?B?T0tLNWVCZ05lQmdHbUhoc3FBZlhMUUVqSHNNRnlsc0x0SWo0SXhJWVE4RWcw?=
 =?utf-8?B?enl1VUNVbUNsbkhmMUt0VDBEVkI3QnNVaE9IbENycXJEVXB5bVNUcUZGMzBq?=
 =?utf-8?B?bVZ3VU1ITWxaTEJPOE9La3hXUnFKbmRlRmNORG5CN0hYOWlDVkMwZzhSRTBX?=
 =?utf-8?B?NTNzeTVzT005Nm9MdlZTUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NyZGJBVXNCS0FnZyt2Rm5EUkdzU3g3bjIyRG43L0o5V2FaRnFOZXp6WXNi?=
 =?utf-8?B?VzRLZ2VZTWRGcCs4TVFlZ2lEL054ajZoQ3psNFBsMUpndWxLczdWTW5TTytw?=
 =?utf-8?B?V0QwNHZ0L211cCtUM2lVSGlHenFIWHB5N25qRFgzMHc0VGNXZ25QbTA1cTVi?=
 =?utf-8?B?VEVPVEZ3UlYwT29PZmR2THBvVytMaGVyKzZvM2pWZWxZenZ5M2FQZzVUbjM2?=
 =?utf-8?B?YWdNcmZ2Q3hhVUxQSVZZUkJQd2VXUythdzZHQkpHOHRKbSt3ZlJvRVN5S0xJ?=
 =?utf-8?B?djV0STRVTGtXSmRwQVhsRkliY2d5dmduRTlqZWRxbGhzWG9xendkZkZabEVR?=
 =?utf-8?B?bWpjOE9pbm00SDB2QnJIcjZkRWY4MVBpUnIzZ3QxQWxCeEJFby9hQTFmUFFQ?=
 =?utf-8?B?OHJ5OFJiNTFCdS9uZXQxNXVNYUVuK01BN0tnVm5iUURIZDRiQUM4YUlhZzli?=
 =?utf-8?B?d2w2QXN0enhWWEt0cm8yQ3B0TWFsSFR0Y0x5eFhtdUtwMy9uZFczdnN6ck5p?=
 =?utf-8?B?cm8rR0Q3c1Rla3BTTDdvYUdmNk9RL0NnbjRCbkltUllrbGU2eDd6bXJDbkpl?=
 =?utf-8?B?NEQwV3hkb3VRVmlCT1M4RnB5TjB5cEIwaWtjV0M0UXMybklQckpZT3RJejBs?=
 =?utf-8?B?RkRkaUlJM0tVVmdmaXFCb0R2T09nOHVEankrNGxETWwzM1ExMjdsc2JmK1Ji?=
 =?utf-8?B?YU95UlFhdkFQZ1VTODJYZmw4b2JRTGJPWk5nQk9OeUd0aEdmMkN0U3N1S0VI?=
 =?utf-8?B?aTh5WTNIKzdoMm9BWVNLTEI0RWtYYVlMNWZVZWNTTmEvZHpoU1g5RVFBeWJu?=
 =?utf-8?B?Slh3YWkwN1oyTCt6WWFEYmJGdEVoak5VcjFLME5JdVdJaFVHNE8xSG9aVmQy?=
 =?utf-8?B?bjAxdDJWSE8xR0V0bGRTeTBmazhQYmJGZjR6amU3YnphcEs5dHlpVkRWeGtX?=
 =?utf-8?B?SzdmRHZmUUlyZXErUllFbXlyL1NuTzZKSnp1WjdrUjFFSUJIcmltZ1RJclZz?=
 =?utf-8?B?UGtjOThHNSs1dDZLOG05QUc4SEtOYjlvcGVvMU1UUGxaWjZXNFJPRVFCZUNL?=
 =?utf-8?B?b083NWJuc255VWtpVzJiYWoxb1BsREZkRXZ0WWtQdkVuUEVTMGFETjhYNzZw?=
 =?utf-8?B?TE1ZZkpEQ09KdzZ4eHFIZ1NXV0ZjTWd0bVI2NlFmWHNHczRlUWdZVHpCNW55?=
 =?utf-8?B?ZkxDK1ZQekJZNHpXOGRVOWRLY0hYMG5kSkorc2srLzlDUEtMUk40Q1dBU21B?=
 =?utf-8?B?ekNaWkJlbU1mcm1oTjhTQkx1cWpjOGxTTE1uWnlNWEsxK0tQRzdseUFkN1RO?=
 =?utf-8?B?T1M0WWFrWUNmc3NncXBPL0ZIdFVuMzUxLy92Ky8rNUkwVjRUT0g0MG5yNXIr?=
 =?utf-8?B?N3E5RVlhdmI0bHY2VGw4SkxyVi9zY1ViemRXTkJVSEVneEFoTTFLTEZPT1FO?=
 =?utf-8?B?aXVvQTE3b25TNndMdzRRS0pMK0tTaUh5RXpxWENRVVRzV3JkSHNFSVFHK3Rz?=
 =?utf-8?B?Z2luSG1GV2pnYktrQ0xNQnBKektaZXBYN04xcVdpZmdiQ0liVDlTVWx5WVRV?=
 =?utf-8?B?TWxNeXBiWXYwd05Xb3AxNkVCMjZvQ3c2SUh6Mm5OTDVlMG9sdmVuNXB6OXMx?=
 =?utf-8?B?VHdJZVJ3VWJXdlA5QXlEY0FKS0RZeHNUaGlQdmhmK0c1WW9ETFZFa2p0bXVL?=
 =?utf-8?B?NzZnL3UwZGJydmh6V2dkZjdURE5mWGJxMWRuU3BORWx5c0J2dXBGZFB1Y3Yw?=
 =?utf-8?B?Y3kxWllxdlJBS1Z1L2RseEtmRk5vMWRReWxXL3M3NFpvMVV2Qm1VV0lheGRU?=
 =?utf-8?B?bmR4VVpRSmRlU2pxYkpzYWo0SDlIbU9nL2hHQXdkSVZvK1BSVjEyeUJPVnpO?=
 =?utf-8?B?bGtucXBXZ2hnNzR1RU1aay9SZ0RwektBTmI4SUFhK0xXeUFQWG8wVzhjWmRR?=
 =?utf-8?B?cXdzemtqUjB4dWwrc0V2VDNzL05qWFR6T3JYSXdkOXlGbGlma3VsL3ArRUxK?=
 =?utf-8?B?UXBVQkNRcmtJS21zSkNEcjBPN25wMXAvSWpSdmdaeUorZ0hteWR2Qm4yWFFB?=
 =?utf-8?B?TFBWMnk1VDM3ZWlCc2pBYkNHUTV2dG9VQlJOK0dYQnpSbmJSVzNNMnBoR2Vo?=
 =?utf-8?B?OHFSTVQ2bjZhL3N0dGpWVG5TRDRjTGtkaVVrclJ6Rnp6WEtULzU5R2VuRlZz?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d43803-dfba-4804-9601-08dcc660803e
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:21:35.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9Wq/f4yiiDaenX6x83S5eeFbAOaLFU5kjwcMxOmo7PrfSbh7KvpA5Q6jMxyiMaOQ5O1C4NM0xt0vHRS5UzKliZvx/AIWww7Z39RUKDsdF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8197
X-OriginatorOrg: intel.com

On 8/26/24 17:20, Petr Machata wrote:
> 
> Przemek Kitszel <przemyslaw.kitszel@intel.com> writes:
> 
>> On 8/22/24 15:49, Petr Machata wrote:
>>> In commit 8510801a9dbd ("selftests: drv-net: add ability to schedule
>>> cleanup with defer()"), a defer helper was added to Python selftests.
>>> The idea is to keep cleanup commands close to their dirtying counterparts,
>>> thereby making it more transparent what is cleaning up what, making it
>>> harder to miss a cleanup, and make the whole cleanup business exception
>>> safe. All these benefits are applicable to bash as well, exception safety
>>> can be interpreted in terms of safety vs. a SIGINT.
>>> This patch therefore introduces a framework of several helpers that serve
>>> to schedule cleanups in bash selftests:
>>
>> Thank you for working on that, it would be great to have such
>> improvement for bash scripts in general, not limited to kselftests!
>>
>>>    tools/testing/selftests/net/forwarding/lib.sh | 83 +++++++++++++++++++
>>
>> Make it a new file in more generic location, add a comment section with
>> some examples and write down any assumptions there, perhaps defer.sh?
> 
> I can do it, but it's gonna be more pain in setting up those
> TEST_INCLUDES. People will forget. It will be a nuisance.
> 
> I'm thinking of just moving it to net/lib.sh, from forwarding.

what about separate file, but included from net/lib.sh?

> 
>>> - defer_scope_push(), defer_scope_pop(): Deferred statements can be batched > together in scopes.
>>> When a scope is popped, the deferred commands
>>>     schoduled in that scope are executed in the order opposite to order of
>>>     their scheduling.
>>
>> tldr of this sub-comment at the end
>>
>> such API could be used in two variants:
>>
>> 1)
>> function test_executor1() {
>> 	for t in tests; do
>> 		defer_scope_push()
>> 		exec_test1 $t
>> 		defer_scope_pop()
>> 	done
>> }
>>
>> 2)
>> function test_executor2() {
>> 	for t in tests; do
>> 		exec_test2 $t
>> 	done
>> }
>> function exec_test2() {
>> 	defer_scope_push()
>> 	do_stuff "$@"
>> 	defer_scope_pop()
>> }
>>
>> That fractals down in the same way for "subtests", or some special stuff
>> like "make a zip" sub/task that will be used. And it could be misused as
>> a mix of the two variants.
>> I believe that the 1) is the better way, rationale: you write normal
>> code that does what needs to be done, using defer(), and caller (that
>> knows better) decides whether to sub-scope.
> 
> But the caller does not know better. The cleanups can't be done
> "sometime", but at a predictable place, so that they don't end up
> interfering with other work. The callee knows where it needs the
> cleanups to happen. The caller shouldn't have to know.

The caller should not have to know what will be cleaned, but knows that
they are done with callee.
OTOH, callee has no idea about the "other work".

> 
>> As this defer is very similar to golang's in intention, I would give
>> yet another analogy from golang's world. It's similar to concurrency, you write normal code that
>> could be parallelized via "go" keyword,
>> instead of writing async code that needs to be awaited for.
> 
> Notice how in go, defer also runs at function exit. Similarly with C++
> destructors, run on scope exit. There's no caller-defined "collection
> point".
> 
> Putting off until "sometime" works for memory. Things like garbage
> collection, obstacks, autorelease pools, etc. work, because there's
> plenty of memory and we don't mind keeping stuff around until later. But
> that doesn't work for the sort of cleanups that selftests typically need
> to do.

That's true. But I still believe that it's the caller (or better, "glue
code") responsibility to take care of cleanup schedule.

> 
>> Going back to the use case variants, there is no much sense to have
>> push() and pop() dispersed by much from each other, thus I would like
>> to introduce an API that just combines the two instead:
>>
>> new_scope exec_test1 $t
>> (name discussion below)
>>
>>> - defer(): Schedules a defer to the most recently pushed scope (or the
>>>     default scope if none was pushed. >
>>> - defer_scopes_cleanup(): Pops any unpopped scopes, including the default
>>>     one. The selftests that use defer should run this in their cleanup
>>>     function. This is important to get cleanups of interrupted scripts.
>>
>> this should be *the* trap(1)
>>
>> with that said, it should be internal to the defer.sh script and it
>> should be obvious that developers must not introduce their own trap
>> (as of now we have ~330 in kselftests, ~270 of which in networking)
> 
> Yeah, we have 100+ tests that use their own traps in forwarding alone.
> That ship has sailed.
> 
> I agree that the defer module probably has the "right" to own the exit
> trap. Any other cleanups can be expressed in terms of defer, and I don't
> know if there are legitimate uses of exit trap with that taken out. But
> that's for sometime.

There could be multiple traps for ERR/EXIT/etc conditions, but for
simplicity it's best to rely on just EXIT trap.
So we should convert current scripts one by one to use your new API.

> 
>>>     Consistent use of defers however obviates the need for a separate cleanup
>>>     function -- everything is just taken care of in defers. So this patch
>>>     actually introduces a cleanup() helper in the forwarding lib.sh, which
>>>     calls just pre_cleanup() and defer_scopes_cleanup(). Selftests are
>>>     obviously still free to override the function.
>>> - defer_scoped_fn(): Sometimes a function would like to introduce a new
>>>     defer scope, then run whatever it is that it wants to run, and then pop
>>>     the scope to run the deferred cleanups. The helper defer_scoped_fn() can
>>>     be used to derive from one function its wrapper that pushes a defer scope
>>>     before the function is called, and pops it after it returns.
>>
>> It is basically a helper I would like to see as new_scope() mentioned
>> above, but it takes it upside down - it should really be the caller that
>> sub-scopes.
>>
>> I think that the name of the new_scope() would be better, still concise,
>> but more precise as:
>> subscope_defer(),
>> trapped(), or
>> sub_trap().

here I mean that "scope" is too broad without the word "trap" or "defer"
in name

>>
>> I have no idea how to make a sub-trapped, SIGSEGV isolated scope of bash
>> execution that has ability to still edit outer scope variables. Perhaps
>> we could relax the need for edit to have easier implementation? It is
>> "all ok or failure/rollback" mode of operation anyway most of the time.
> 
> I'm not sure what you have in mind.

	foo=1
	function bumpfoo {
		maybe-crash
		foo=2
	}
	new-defer-scope bumpfoo
	echo $foo

do you want this to print 2 or 1?


> 
>> After the above parts will be discussed out I will look more into the
>> details of the code more deeply.
> 


