Return-Path: <linux-kselftest+bounces-44537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A1C2605C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 17:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17FF64F5841
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FDD2FD1BF;
	Fri, 31 Oct 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjuXvgMU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE52EFD9E;
	Fri, 31 Oct 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926616; cv=fail; b=uBe/CRQIJv5HCkVHRcJxrFc6hDbZ1DkeQFw580dDjaa0S2fRkQJZH4J8WgH52EPeekvNY36XjTtU2SdyGtd9zU9gqyDvKP/rBz9zfTzCWcL0o0D3q8eGfu9JVn0aNzn19avuj62TniHJBmceOarx+uCfpUCPw//bqxUm71zkImw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926616; c=relaxed/simple;
	bh=jTSfWZ8LgYh1KvpBY4RIc6oMzz8rkWoG2gtwAbg6mCs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lU42FsHT6J/cp0dy2boD5xCwkH3l+3szHkRleeG+UXs2Xl3tFqXavdF5hKn7KyqduUOyLm8OFrc4phNgJo00AqTM5Au+8bUp5GBIWmKN+bTZjEhEsfQ1ac8wjFjX3MQDJhaB0lGdPKRkMFLNEzjNtQSmhfkGKrbzJwXPyMmPDzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjuXvgMU; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761926615; x=1793462615;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jTSfWZ8LgYh1KvpBY4RIc6oMzz8rkWoG2gtwAbg6mCs=;
  b=MjuXvgMUdxB3Zn3AorCgG6Dix//oNea1oBSm3H8xMFQGNvwL5ah7wTdp
   Fr4ZqBtu43O1+ETjNB+2p9f2ehqUReFcv8xjuApkF/IwUM1hEpM4cg5NE
   IC6Zpdw4VmRw1k4cd6malgbtawKRGkPLZ0DSDv3c1pftVzV6mWUrqoz7C
   nGudJKnQEtcFWWwPLEsOgUNrZP3JZI8LFYE5EBQ8IpbgFKOgRmWsjd8lV
   xfIV/aDvLxNdt67Taalp1u5yILJ54Dmgiqxlbba1AlhUvcTTfePrzvqMo
   dDNHhziQnl/stEee/yVkcbRsM8rXDM0hcBdw6UpdeIxGUuhw3cCEjG/0G
   w==;
X-CSE-ConnectionGUID: vxgpm1UzSjKMuEykt5rh/g==
X-CSE-MsgGUID: fLu45JiHTOGPkEQk+jxitw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="89553883"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="89553883"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 09:03:34 -0700
X-CSE-ConnectionGUID: 2Ykioob6SxqsXBoM5etbeQ==
X-CSE-MsgGUID: KameLVs5SEKv+D13sUWQvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186387603"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 09:03:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 09:03:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 09:03:34 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 09:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0Nr/KXMPFxXklnjU2qqYTX+Y5vN/7hvgn7+95eiuxrUr8cC2t15KVQtc89hmw3Y2Ak5gUKrvSf7GqK2r3DsRpPxYZTW6VdX7pYQ+a2CS3a5V2pDXC1MvrFMQiPwNaSR/pWt7KETraTHgGKjMr1IYoB4D+QnmUQwwBTWS7Z3THzJCdcPKjwUZG6GnS+Zv0fUe6AQiGeZOwLHhzb2K1LbNjTaqL/01dMe1AI1sL7O/tBKDyvXmdZ/PjSOeSZaL5RZuNCaET/rlyP/J4fzrvRJgGey2rcgD+Hiv3wSWFmaQ5mVmT+VyrI4XGwFs0yFvRENSqO77hqdtqek/wfOnV0dfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gQdYByfIeHJNLlf1fp0dxCHiQByCNXSKBkf6lgZQ5s=;
 b=DOwXItdWoFiEs/M7t/8MvbQqIAScidWeAelDhyXDFH+7xrK8XWuixbVfgM+lNKQfCjDUX4RWcGyiebwU6NNaBcRj4tRJi81Vb7GYfEj6aTrQlicoG+d3vwFnnkDgMD4R/1TeqoTYCvx9RkVsYU+1Z7qiN37ZXZpV9gJLWnxow1UrMPd0+fbFDyDkHWQBhSPyuupj6ueN9FM/3Rk+EN6eneI9sTJX9hP7gbt4lNGxb14hedzarkjU1THZ30glu9lFvQTlaZYDG0oSbluSrUkCZ8+kO13JJBPqLko+Ub1RA0TAR6P1s8dKdNR5YH6WK3gPABvhQ9jW8e9YjhVRWpSGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS4PPF46B98A11D.namprd11.prod.outlook.com (2603:10b6:f:fc02::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 31 Oct
 2025 16:03:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 16:03:28 +0000
Message-ID: <2bccd63f-78e3-40a1-bbd6-2c8e08d68f5c@intel.com>
Date: Fri, 31 Oct 2025 09:03:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/23] KVM: selftests: Call TDX init when creating a
 new TDX vm
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-16-sagis@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251028212052.200523-16-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0134.namprd04.prod.outlook.com
 (2603:10b6:303:84::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS4PPF46B98A11D:EE_
X-MS-Office365-Filtering-Correlation-Id: 839949b9-dd8e-49d6-50da-08de189707c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzhHMlNFeExmcWV2cFFWN0FqSWJ3Tkd1eEhNMmdsMVpLem5aSjZSc2JYQks2?=
 =?utf-8?B?bVZJdnUzaWhXQUVqcldvSVVQTUdGV3FNZU1OVVJrNW1odE1sN0tJeGdlMHhp?=
 =?utf-8?B?VXU4VDFxU2srQkFRMlIzV05sZWYrVW5RSDVtU04rSTFNQTlnRFRYSjBxT05U?=
 =?utf-8?B?VEtDczlkWFduK05iTU1kWU1LditRVm1ZNXAwWjFSZnpyWUVyZjJFWThrRjZq?=
 =?utf-8?B?Y2grZTYza1l4V1JScGljYnZDRmJJZzRiZ2c1ZDU4MW02WTFIZVdoWkE3aHB2?=
 =?utf-8?B?ak1oVWR1OFlBdzk2RkpFbGRJeVp6TTRxSUQ2bThwT0tHQVg4TkpWdUxRbTRE?=
 =?utf-8?B?eGVNZUNjOWZicjhIdHMxYTFtUzJlbE13OTI2L3lSMEFkckd0bU9SMVVwWFdk?=
 =?utf-8?B?MXM2dVM3K0JlUFR2OG1oYlpVTEh1OXkxMEJjSk9aNFBUQldnMmVMM1JvaUth?=
 =?utf-8?B?ZDVYbThDdzllVGpwdmx6R0FOT2duSWZxUi85YWxnUWZmTWFGbzRSVDZrU2dv?=
 =?utf-8?B?alo4enpDOExoSkJzc2VZbTJBWGNOS3ZkbGhuMThGblRJSm9qb09KdzZucnpz?=
 =?utf-8?B?enNmYWx0Y0UrQURoeXEwYW5GeisxM0g2c0pyT2FHaGswNVMyZDFrV2VnSmxy?=
 =?utf-8?B?UWVwY0V2S2hXNVE4emhmTFM2Yms1aWJQWGgzSzBNUk5sbHRZbFZhMVJUNzJD?=
 =?utf-8?B?OGZYSWJ5WXU2d3l5ei8veDdDNkxyNVpsL3RSdnd0R3RidGJMd3Qva25GZ3N2?=
 =?utf-8?B?eWpkUUtDbnk1dTJZdzFNR25DNU5rR05DaHFJa1cyM2lyWXMvaWV4eDBoM295?=
 =?utf-8?B?WHhQeHpXRjJOR3NraTNpbHV2dWh3R3dnc0RFOEhyVjZ1VUFQU2dMa0ltOC9K?=
 =?utf-8?B?UVl4WWprbkNSZEl1WmViL21lSWsySDVJY05oaXVDbmlwdC9PNTNrc1JUajFD?=
 =?utf-8?B?VkdvNGhUSW1uOFV3M3ZXM0M0VlVZYk56VWU3eW9JVjlNazdaVFBzRXA2TEhm?=
 =?utf-8?B?U0hRNkk2NmVtQTg2OGFNNUd4aFlDeDR1M3paSmJQYjY5ekoxWENVa3RQQ01G?=
 =?utf-8?B?SWtiQVQzaVlvQ2UxZXdvT1lvVHlvWTQxdXBsTUtFL3lNbmFaaGV5b0RBbzVB?=
 =?utf-8?B?YjZ3UmdVL0lWUTgrc292RisrM1lOT08xU1VzVm9NbFdLVDJpQi9FeXZIL0VM?=
 =?utf-8?B?ekduQmpKY1Y0NjZJUkgxR3Y2UzlIa1l2NitlQTREclZUYnZXZmhHK0s0dVhj?=
 =?utf-8?B?NHlVTUwwZHZGUHVLL0lSQ2RIaE5mcmR4UTJPU29BRGNaMWZrMnpYQUJCclNp?=
 =?utf-8?B?R0hXKytRTEJNbXFWWlRITmtKTHVKdXRMNDJ4R1NhMnk2Uzl3V3FvTnV5aVY5?=
 =?utf-8?B?MCtGYzJzeWJSR2h4MTJ2YkNmVG9lUjU5ZjU0RE4wa2huN0k0MzVpNXhEVjRM?=
 =?utf-8?B?ZC9wRDNDVDljQVdkOS9iWDNjalJTV3ljYVdBYUdha3k5a0dZMzZlT04wMGl3?=
 =?utf-8?B?UmdjKzNWSjdrdTh4KzM5UGdteXBSNW5nTGFQazViMWtRV20zWFlucC9BYTdI?=
 =?utf-8?B?RGlueExyT2RGU3dDSHJEaEpEZU5TcUZzNU0zS3NZc21xeHBjYS9NVmkrZzM3?=
 =?utf-8?B?ZmxuM0hYQzJZSVk4dkdINnduOFN4L0ZZSUFjc04rdnRqWDhtRElMUEdyRUsx?=
 =?utf-8?B?OEkwVzZ5Z1NsZFo5dmh0SGdPZGtGU0VJbmFUb1JnYnVOdC9XdWFFQVAyL09i?=
 =?utf-8?B?bjcyeEZLWTJvMW5Ha0JDQldWellEZ0JUNE14dGRrb3VGSVgrOUpiOU9hTVdK?=
 =?utf-8?B?NGxsVEtacENTZEdiQTMwQVFxdElCTGpwZUZkVHhQakRSbG5neDBidFFJT2hx?=
 =?utf-8?B?VVRnVUtqNlZwZVRCdk9xaTlQa1Q1d1h5TXRzblh1aTJjODhvc3NRdkZiUEFP?=
 =?utf-8?B?WFZsdUtoSlFyZzMzS2ZWcnVpYjRqNnVyZFN3RGJ3SWY2UWZNSlp1bUdVZzBF?=
 =?utf-8?Q?oLEGYcefIMvx3m2KIznjzp1n1pzHdE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXJhZjI2M3UwVHc2aEcvN1hYc0JLaDlVSHRDajd2MlFnWXVhSEZZaEpEQi9x?=
 =?utf-8?B?SWlvV1dMcS84QkxaRHRJanJxdXl3dHlLTnZnZ3U5ZTkvRWNiZnpTTy91UExx?=
 =?utf-8?B?SjU1eDdycXYxUHNXbWZrb0VMUUJWcjdtTGxGaG54VEVncmlKc3h4dVBmVTZI?=
 =?utf-8?B?TWVjZmZvaUJrVlFvOFZGdHZMbXJ1azArTXZ0c2JNZk0wZWpRRXByMncrOUdh?=
 =?utf-8?B?Ulp1dDh5UU1KUkE3OGRqR0JTVkZqME9BSjhRcHdKZEdETlh4MnMyMDUwc0tO?=
 =?utf-8?B?M2lSdmFpL0JxNXhQRFMxWGxTWitsUHNrdFNmaGRsTE84SzRvVzBNa1ZCVU0r?=
 =?utf-8?B?RVBhWlNEa3lKZFk4aW14aUdIRCtXUHdSN1RvVFhraTV1Y28zaGFyWVp5Rkxl?=
 =?utf-8?B?OUNYbTFoaWFsMzVaVlE3dEhNbFQ5YmZuUlBDRFJtMWVqSHphQXNaTDRvdGkw?=
 =?utf-8?B?bzdsSjdmNmhnTDlHQ1dZa2dSZHBvNFdTcGkwRy9DNnhIdlpKeWR0YWw3Y2dK?=
 =?utf-8?B?R090dEhlaGJWOFhZcVVWZGc2UjVUSStSVkc5TzR2TnA0NEFzOWJRRWVoaWtn?=
 =?utf-8?B?VFVxdG1oV3ZpQ1UxV0ZrYlpaSFU1dDlOVUNvWHl3SGFEbGN1S0YvbTNZUzh0?=
 =?utf-8?B?Ymw4UVY3UFFnR3hzMTI5Nld3QWE3OUNOR254V2lDV3hEa2FNTHVpOUdHeUJh?=
 =?utf-8?B?SFAycFNPTjVPMlBPb1dzZ0NkS08yZDNCcHhZNGNSVFUzMkFVQ2RURXFGTmFL?=
 =?utf-8?B?WDF6V1VwaTZGbU9rdGRXMStFOEUrNWZPb1p0Y3E0azJUUm05QU9Ic0N1Qmw1?=
 =?utf-8?B?aHphbTNLUGlveGUvL0ZaZ0lqaDRrczVlWXB3Rk4wQXJOZXBuWFpDYlcvbHhu?=
 =?utf-8?B?d2FYL05iQXJtYU1uN0tGOXpoRDVTZU9SQjE4ckxPOS9uQUNPZmx6MVVpNFcy?=
 =?utf-8?B?clY1L1RIb1JFT3Y2ODZPTngxemNra0J4S2VNRmJhY3hTK1d3TmpVaitTU2ZX?=
 =?utf-8?B?cjZoUXJrQ1NyS1J4RlQ3Ny8xaDNTTEIxeEJ3WnZSM1IwSWxhdzVsVzFBalBX?=
 =?utf-8?B?RE85RktLa0k4MGxPdWJCaytTak41VEFJQkhXeC9TZFRIUkZSeFF4OXBNSFhs?=
 =?utf-8?B?QzNHc1RsTjVYQi9NeFFIV2g0UTRscS9Na1dONFd6UzFlbkZXN1UxM01yTlVp?=
 =?utf-8?B?WE9ra1B4bVVsNjV1cHNjZFhPZ0RIUlJ6Zno5VGlTeC8vVklVbzhBdkpTdmpo?=
 =?utf-8?B?TFRHOVJWWmZRNHh5eStUZjdnWjFIMUh6SjJGYzBTbFRQaktSUXBWM2t2NSty?=
 =?utf-8?B?T3k0bWhQWlJEMUJ4c1VsYlpRc3NxeUJyWWtxSjdsQ21sWGtsSUxLdmxvcjhi?=
 =?utf-8?B?Y0RTcmloMC8yVWRNQms1cjhUdktNaUZrV1p5UHNzeDdXTmNjWHc1SXZxbjB2?=
 =?utf-8?B?VWhnYUxDUkZhZ1hFckFyVzV3eVBHeGNFRVZQQUlNUkprYjcvb0tGRzlnSmdh?=
 =?utf-8?B?QTJOUjU4cTBLR2VnK2lDa1FtTXZVdmdzWWxOY3piWmR5cDRWa3FvRVlqQUJ4?=
 =?utf-8?B?ZkR3cHRaSDh2VXNsb054SUJ3aHlUL0NOZTUrbDA2UnZSWm1ZWWxkQXhReWlC?=
 =?utf-8?B?OUIxVFgzSStqWktsOENzTE9mUEVtMGtKWlZrVnJQeldWQm9OT2FqRC95d3Z4?=
 =?utf-8?B?SmlvaTVwS0s2Zm1iekZ0QVZaRzlDNFIvRm1tdTUzYm1OL3VTOHBVck81R0tE?=
 =?utf-8?B?aGRpcGtKeWYzcE9PKzJOQW5OMDNwWUxlbmVZZ1NUcDUrMUwrTzFDVTdBWHh1?=
 =?utf-8?B?QW8xRi9SYjdicnd2RXVKaEtjRnZ2K1F6dEdQRHJyVXdoT1FMVUlkSVF1bWtO?=
 =?utf-8?B?YjYwRk54QVBHNzhFZk1GOWZYcm83N2xXVEhpZ0FDM3V4N0pIS1d3T3JPRWdL?=
 =?utf-8?B?c3k0VjhVUzZNVEtsN2lsK2RmRk1LS0RyU2ZMYWYxM3dodWdDQS85UVZUdE9D?=
 =?utf-8?B?dzkza1NFWFZDdzJNaDRkdEtGZWsxQnZ4ZnRuODhEY2MxMU1IdUV1S3VmTFJO?=
 =?utf-8?B?dW02bzlPNmRzZUE2eEpZVGszbEdHdFpjMkEycE1EeTU3em85QXd5Tm9kK0xq?=
 =?utf-8?B?bERVUUlJaGRwV2YzQ29jMXRDMzBpb3ZWelgyMnV4RnpTM1lqT1U5cEZ3cGdI?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 839949b9-dd8e-49d6-50da-08de189707c5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:03:28.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwLB5ICqtK0+MBPfOfn5CmhlY3UM0XvHGEUvVzAylk2Tt9GIZFW3dE8F1mC9P4xELtaZKlx2U3LqAnUThL7/vUblEaJQP3RiB/KL6D3rnNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF46B98A11D
X-OriginatorOrg: intel.com

Hi Sagi,

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> TDX VMs need to issue the KVM_TDX_INIT_VM ioctl after VM creation to
> initialize the TD. This ioctl also sets the cpuids and attributes for
> the VM.

"TDX VMs need to issue the KVM_TDX_INIT_VM ioctl" ... take care with the language
here since it is not the VM that issues the ioctl() (same in patch #17 changelog).

"after VM creation to initialize the TD" ... is the switching between terms
("VM" and "TD") necessary? Always referring to the same "thing" using the same
term really helps to make the text easier to read.

Finally, please do stick to imperative tone. For example,
	Initialize the VM with the TDX specific parameters, such as guest CPUIDs
	emulated by the TDX module, that the VM can support.

Reinette



