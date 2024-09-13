Return-Path: <linux-kselftest+bounces-17930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 947B0977EAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 13:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4A71F25B77
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123DF1D88AA;
	Fri, 13 Sep 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWVZPqEG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113121D88C1;
	Fri, 13 Sep 2024 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227714; cv=fail; b=HHQXYlIsBsjPB0EUBtDQeAJ8MvaZ8c/siVWg7Kqc+kETnKxpOX9aNJpYshpOHClWaR4OIT7X5KTtXNtHFfIBAUe0baZlUTdBQYwjfz+ErDFtA9vSeyCaO6brQRhoSJVUeYViuQGB/Mftd0uuwiPFzYO5s7hc4Rjkw0y366nh330=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227714; c=relaxed/simple;
	bh=uEOd1eZJsWPYnpTGHXsGQ/4A+qRuPYyyAaUj6fobTwA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dfn0/WvcJ/1t/wdNvO4h1RwWuBVRv/AM3dsQrVUqi6EBW6LdWTX429a/0GUfURkNV9qElTUAStfA2vzfuScwg7+TSwcRl1+/lb1sdr4wgmwXTVEOfQBRyghrJYgXRUisW6X6LTBfaTzF6xhlvGLzSYOG2hGdQmfaaGWGnIhEeEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWVZPqEG; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726227712; x=1757763712;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uEOd1eZJsWPYnpTGHXsGQ/4A+qRuPYyyAaUj6fobTwA=;
  b=HWVZPqEGJjPqHV6e+tE4++Q3pQXMN+/Kfec+wkg4osKOaFdnXls/G2NL
   Absg7l7D/w1YHrRFlSVXzatbj0eGelqkJszFue9YIlzAWTDvqbG5x6yGm
   MgoecUHWkpYqCnh08gynCPF6YX2NAzLwppKNTcLuvxFLMvoPZ7E60zVEE
   3/LCAvUhCOd0bUlR7QtV4mwaKyR4vIBCYD4OS7dh8AjNhaRsbhLhossu4
   oRYVv2r7U1hM6Prz5+Lx6ZL61AP/AVO4ZYQL5V2p2S5XIGgquDnCc7f0E
   d38TlzlIHS6rNx/HdLDWoVNgt1zoKKDUDmMUYesZm6xVeKLp7Dcl9dCDB
   A==;
X-CSE-ConnectionGUID: MpL0jjd5SU6Xce5uNVriiw==
X-CSE-MsgGUID: 4JruAGdTRYuJnnlCDQr93g==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25275337"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25275337"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 04:41:51 -0700
X-CSE-ConnectionGUID: 7thJE4tDRNWRnWUb2hJ8ag==
X-CSE-MsgGUID: opUj9Cr9TXOfUrbon5T00A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="73023215"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 04:41:51 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 04:41:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 04:41:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 04:41:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnw81c6YZBElauwQ04/6EgZCKk8pVxL5ITxBqSJrwJHPfcsAVvb1EzRtCV/Xv+aUgaZMGhm8kK7iv1DvC0l00zMvbMIP1cNhtADAB2UxQJFmxFIdjZ8nIaRgS2ZakoV4a5EWc3SsoFCasdETAsntNUVUHpTIFlYW6PAQjtp5fdNbjhqF0+GrzRNpJp2zOjUWIDQ3Tq51WS8N1yrCaL7Ny3GqY1qEjdm3lH8od9qhR+tLDdBcaH9EJe0WjHi9eieN4egEhVdlIzEYmP2rMkwIRqTwles2eX/i3d24zuCZz1UA4wZXyx8yoSanu0PtGlkTcliLGUQuSlZ44BBRlHW0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+kT6dugVp1uyX3trSuhagdv6HyCVyX+Pcnyc4cAuWA=;
 b=FyjJzuOhPtq3jFnCGimsVNEpRqkYh4PzqXI66MlWg1ExMhezQhALyHJ++nhehEmfFqJ8wqBrDEIjP55PD/2zbDl2ip6sfsswbnGJq8b0+Q18wuAq4SWzDC3/8JIVegybt1jGIwnnJW28XESfbOAFCgNAO1Xx9hUCMBDqKhzAak9ka1ebvE4X4rsiS2x2RfBrS2XfSthw3HYCwTdkG5h6Tfrtq9PDn2nXZ6fK39PsQjndEtM9GjmaUIuU/QglXzNewFb5OFyoLrZNa6hdWrxCTINH4JAKoVSzvixzj4GXT9ZUEPJIQrgjsH+93CFVOaSDaYXYlw36gGS9r0HdJAyBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 11:41:41 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 11:41:41 +0000
Message-ID: <a24aad52-3da6-49d3-9df9-f418fad36434@intel.com>
Date: Fri, 13 Sep 2024 19:45:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] ida: Add ida_find_first_range()
To: Matthew Wilcox <willy@infradead.org>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <alex.williamson@redhat.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<zhenzhong.duan@intel.com>, <linux-kselftest@vger.kernel.org>,
	<vasant.hegde@amd.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-2-yi.l.liu@intel.com>
 <ZuMEsybAnOi_uSfY@casper.infradead.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZuMEsybAnOi_uSfY@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0fdc13-56ed-4672-293c-08dcd3e9092a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SS9nWnFJTk9vUFZlSk9EbGtRQXk5MSs1UFRzRExCOFcrNjBQb2dyWDNLVzJN?=
 =?utf-8?B?SVJ6M2s5cEhENXpnVEc2UHltRTFtOFozWGM4a2JTZTRBUzZPMDF4OTlkSXJY?=
 =?utf-8?B?SWRQQ21tSWxCTm0rZU44bEJ6UG9SQlA2THRScnQ1Q1oybDVRWEY4aGZCcW4x?=
 =?utf-8?B?dGZuUG1rWngwQ0JUWUxwSWdGSGFxQmtuWk9pTlIwd0lUQXhKQU1lVkVYVEFk?=
 =?utf-8?B?b3oyTWw3SXYzRWR2V2tmeWl0em0rK0lGWk41SENHUk9SZG85MTZVMll0aklK?=
 =?utf-8?B?S25OSnI4V1BoenVNbVZDOUF3OEFhSmNRRWhqSWdkVm5QaU9Hai81dnRrWFNm?=
 =?utf-8?B?c0R6Q1VsVVpSU21vYk9BZzVhelNEckZXQmZsMVJISkE1eUVwZG5rYmtuaHlh?=
 =?utf-8?B?eWZpNFZDeW5WK0xWMU5FVlpCSWVRTHRBVjN2QWdZOEJWdGZuYjhxeFlxc29v?=
 =?utf-8?B?Z3BGWmkzbjZOd0JwZmxhR2t0dUFrOVhkdjQ5WnliQTNPcGp2WTFiY1M5WlZ1?=
 =?utf-8?B?ZHNTNjlUWDVEVHVJVHNSTmdXUkNuR09Kd3RuVzVrS3p5TWVLUVFKU1NYNFVO?=
 =?utf-8?B?VHB1emlCK2E5ampuNTdEekdPQ3NVV2MxcmhWc2xCWTFVSW9JSTh4eGVaai8v?=
 =?utf-8?B?VVhHVTdwbVh1YTBSZDQrcGdaTFQyVEJEYVFyTlpKQ1BUemFzYTdPTytmblU5?=
 =?utf-8?B?QzlhVTN5WUt6aGhaZjRORnl1Wm03cmNhbW1ya3BMQ0dLQzZObXVlWnhINlJv?=
 =?utf-8?B?UnZKWFVzWXk2am5WNittcW9OSUw2RzhWUmhFd0VzYStDenA1K3N3bE82Y054?=
 =?utf-8?B?M2pMRUhkQVE2VGNNUFJrc1pxR0dMdy9uUUkzMGo1K0F6cTNTdjRtcXRiamRu?=
 =?utf-8?B?MUNYQ3ZzQXRZcEZ1L2pTWFdxSzZmdS9rZzNTRG9ndVNacUliQm5VWThwZEhl?=
 =?utf-8?B?N3ZuVzcxWU9nNHdlb0lqZmNyaytmK0FVei92YzNSTEQyT3p1QW5GWVdDMCtr?=
 =?utf-8?B?SHRwUzl2dHRlUnMvU1RqTlh0Sy9DRkxiemNjbVBMYm5zUTZ4bDBFYmhEemdm?=
 =?utf-8?B?ZlI5K1dxTGdqNWhDM2ovZjcwUXo2MTRSRnpjQTIxcVRnQnk1MmJLTmZMd2dy?=
 =?utf-8?B?V29KQ004dVMydlNHRjVhSGZWSE9PUWNSUUJZUi9yUGwyOU5LVkF1VkF6NW51?=
 =?utf-8?B?aElrbDczR0dGZmZOcENHM3IxSXJBYnVzVmdvSjY4RlNSM2ZPZHRSbTJFWFFo?=
 =?utf-8?B?ckFRcFpVaGZFUGZkT1l6TFlmRXBZcWg3WnNVckJlNFJzK2pUUEtsZGdUWFJT?=
 =?utf-8?B?bit0TE93UEdNRU5JSVU2VHJzNy83SlljeGZJUnJnN1dWQXJtMmNYYzVwV1Bo?=
 =?utf-8?B?dnFPb2NyMWJTVXZISkRVSU1SVTh1bzhRWTRzcVUycXY3UUdsVVJsVmh4WUlF?=
 =?utf-8?B?ODJvMDJ6aFp4eW1wdFlHTTdrNDE0SDUxdEtPZXhCWEVVT012YmxMSERzejlC?=
 =?utf-8?B?Mld2QWFTRXd3Tno0MWhVbXpiOTF6T1Q0VDZTNy9sdmZ5amxvaHkxQlI3ZzFZ?=
 =?utf-8?B?UmxWNG5xaWNndWlMY0Q4TG1FMTEzK054dFl5ek1aZ3Vwa3ZpczdGWW9FQ1Q3?=
 =?utf-8?B?ayt3N1FadHM3Z1FQaUh3aXdBbTBKOTkxeFFPcVlzUjkySzBpSitUcUZLNkZ3?=
 =?utf-8?B?UVhETmRqaGNTV2RPeVBPVGNJcnNqV01BYVpsQytUNGFuS2pmVDhGeWhMWGJS?=
 =?utf-8?B?bWozUU0wNC9ONVdFMy9yNlNlMFZ6S3l2UGtveVRpTWpzQXc3dndaUGZUTC9V?=
 =?utf-8?B?Y1BTaC9Md1BCQ2pJeVhZZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V28zaG82TWZjUFlhQWdtOS9EN2VLemJib1JaYW1rQmtubmpDWGlSUjlBODBL?=
 =?utf-8?B?bEY5UEFXaC9RUGhYL0YwUy9uOHBuVmx0MVZFSFFBVnRsYTFlcVJSR0ZuQm02?=
 =?utf-8?B?T3p5cnlCcFp2NmR3dEswZGYxeHR0MHpjWFRTbjREeElVYXIvQ2k2UVcrOG50?=
 =?utf-8?B?c2hrRkx0eHFmRlBuWmt4UVJZY21aeHcwSW1sdDkxS3JUV3VSL0hnLzBGWTBS?=
 =?utf-8?B?M1Frc3VtTGpBWTdnVktyYVNSYm9MRElqTExLT0F4Y1F4L21LVm5GZ2MybnVw?=
 =?utf-8?B?NEdZRkQvWGpZT0VJUkxvcVNOa3JZRXFkbHlTcWNDaEJtdzZnQ0xJai9IRytZ?=
 =?utf-8?B?ZjlSS09mQjZtaXVFbVh3Y2g3OHVzUktMN1BuQkxzTlAyOWc2VUtkbXB0MXAr?=
 =?utf-8?B?QVViSit4b3FnMm45S2tqZ1pzTTI4bWZwWWVQWm5uMjBQcXdLUUNPWTJtVDlk?=
 =?utf-8?B?cUpBR1ZZaGhqNHBEWW5SUlEzODI5Y2JZWm5ZNWM3eDVpcTVaSlNneCtZOE9D?=
 =?utf-8?B?NlQxVzNsT2kyd1hlbk5KMEtxS05POG9YRmlwcHpzTm10M3h1YkduaXgzNDJi?=
 =?utf-8?B?Qy80bkZjbFAwUjVSamFvV09LN0lvVlBqLzhyNDVoS2NNNWJyU1BUdmZuTmc3?=
 =?utf-8?B?elVFL2FBRytMeXljRHU0ZTlXQ0xabVVFNVRtS3YzMTd0V29aRjd3dTNWZUNG?=
 =?utf-8?B?TzRrN3Y2WkdYWXRQL2Z0Z0lhVDRtU1JRVXJkR2FDQkdXSkhIZjh5SzlCWllW?=
 =?utf-8?B?bVpSVHJuNjBRMHVQdTdyVlhmS2tUWm5iazlwTmh6MWg1dDZWT1dKTjFCaUdl?=
 =?utf-8?B?ZGRrWEYwcDhMdjVWN29kT2NQc1RDL0cyV1JkRFlNdXdSQVNsZGthSmptVjY4?=
 =?utf-8?B?M1YrRkhWTDJBVGNpUWhvNmdaYlVmOXY5VTdrbHhlUmtscGlnSzVaaFoyWFo5?=
 =?utf-8?B?WmFIaWk0RUVPTWVyRm9YRTRXMnJ1cS9pRDYxdGl4dHhjbjZMbjR2YVA0azVy?=
 =?utf-8?B?UzIvU3NiSi9kamFKMTJ0MXVlWTZYYlpEOFE5UW9mMERnUW9EWThNNkdyYklG?=
 =?utf-8?B?SzdXNlhNbXh1dndHQTlMdGd2NUxTWXovNXUyUkZ0VmpCRXNIS2hWMWtld0lH?=
 =?utf-8?B?ZXd2bThEZTE4YzhGVG13bnYyamkrQ2ExWDJkOHh6cUhVUURPekg5UzZtVi8x?=
 =?utf-8?B?c3FlRDZ0SC91Z2dVVjR5MUxycFJMYXd0OStHTHhTTWgxckRSdk9wdnlKZ3pE?=
 =?utf-8?B?YlB4SE5RRFNGM3IvemplUWN4dk5DamNwTnlld3Z2TC85UXFsQUF5ekljSUty?=
 =?utf-8?B?R1hqRHJHMmhIZ21xaTZPYzRDU2lXN0kxVWlhZVJleHpxYWZzOGdseTBHRjRG?=
 =?utf-8?B?Z2xEb1BlWGFibnJWaklUNHpxR1c5K3hBUjIyL21KSHVzQUJNUC9YMy9LbGk3?=
 =?utf-8?B?VmFObmtqczFsT0JraklsQ2FiUXJTaEJQTjk3dFFvVlBHODEvN2tVb0pXd2dO?=
 =?utf-8?B?cndXYTZtcVBYMmdpUVRURHFBK09OajlPbTJXWEUvZzVYMEtLeWZxKys2U3pX?=
 =?utf-8?B?a29aSFpLRHNZYWgyczFXRmFKU2xOQzgwUFdnTTJXdDl3MTMvTlJXekc5ZmdO?=
 =?utf-8?B?RkplM0RrTFhscWlQMW0ycTZSZUVwRzJyc0NNQnFNcm82LzJDRytidklzdFhv?=
 =?utf-8?B?QUVqeWdOMmNtelFWRDQ5UGd6SWE1RjNjODJ0Z0VCV1pzcFlqVStGajNJVEhP?=
 =?utf-8?B?d3Zwb0U5MDY0Q2lEQ1B6QnljTlhZNjBCMzVTMU9LaDNnR2dHN28vcmRzVEFZ?=
 =?utf-8?B?bWY0cXZ6MlpOaG1rME1KM3FKRnZNZjU3eVlvZE9uZVU5V0hDS1RXQmJYWEMy?=
 =?utf-8?B?ZndWTzB5c1VsK2grTHpKODZEcDBSQyt3TG1jN1FlbnZ4ZlgwVkJubTlGN29h?=
 =?utf-8?B?SFphQTV0TklZdWFxOFZSNE1HU2RDRXdKWTUxZ2ZqR1BiOHRZSVYyWkN1eUxQ?=
 =?utf-8?B?cWtDN1hZTE9qY2xBK1dNMG1SK0g1VVBGSHRqRkcyOVRJQkwrcUk0SkRoNlB5?=
 =?utf-8?B?STFhUStwQmRUaGQzZFFqcVJBOU5iZXNkcElSZmV4UFM3OWQ1bHFRV0MvdjJE?=
 =?utf-8?Q?Jntmhf36STMEhcRpmVwb9l1sb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0fdc13-56ed-4672-293c-08dcd3e9092a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 11:41:41.5477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAUhirjsS4pkUkMUWLoQLyN9vqlyOBITujoOvGTvRqqnBM2dENDraRRygYC3ealdFVc/DA1Hv06HujLaD4doow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com

On 2024/9/12 23:11, Matthew Wilcox wrote:
> On Thu, Sep 12, 2024 at 06:17:26AM -0700, Yi Liu wrote:
>> There is no helpers for user to check if a given ID is allocated or not,
>> neither a helper to loop all the allocated IDs in an IDA and do something
>> for cleanup. With the two needs, a helper to get the lowest allocated ID
>> of a range and two variants based on it.
>>
>> Caller can check if a given ID is allocated or not by:
>>
>> 	bool ida_exists(struct ida *ida, unsigned int id)
>>
>> Caller can iterate all allocated IDs by:
>>
>> 	int id;
>> 	while ((id = ida_find_first(&pasid_ida)) > 0) {
>> 		//anything to do with the allocated ID
>> 		ida_free(pasid_ida, pasid);
>> 	}
>>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   include/linux/idr.h | 11 ++++++++
>>   lib/idr.c           | 67 +++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 78 insertions(+)
> 
> No test cases for the test suite?  ;-(

let me add something like the below. :)

diff --git a/lib/test_ida.c b/lib/test_ida.c
index c80155a1956d..d89554ff5719 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -189,6 +189,75 @@ static void ida_check_bad_free(struct ida *ida)
  	IDA_BUG_ON(ida, !ida_is_empty(ida));
  }

+/*
+ * Check ida_find_first_range() and varriants.
+ */
+static void ida_check_find_first(struct ida *ida)
+{
+	/* IDA is empty; all of the below should be not exist */
+	IDA_BUG_ON(ida, ida_exists(ida, 0));
+	IDA_BUG_ON(ida, ida_exists(ida, 3));
+	IDA_BUG_ON(ida, ida_exists(ida, 63));
+	IDA_BUG_ON(ida, ida_exists(ida, 1023));
+	IDA_BUG_ON(ida, ida_exists(ida, (1 << 20) - 1));
+	/* IDA contains a single value entry */
+
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 3, GFP_KERNEL) != 3);
+	IDA_BUG_ON(ida, ida_exists(ida, 0));
+	IDA_BUG_ON(ida, !ida_exists(ida, 3));
+	IDA_BUG_ON(ida, ida_exists(ida, 63));
+	IDA_BUG_ON(ida, ida_exists(ida, 1023));
+	IDA_BUG_ON(ida, ida_exists(ida, (1 << 20) - 1));
+
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 63, GFP_KERNEL) != 63);
+	IDA_BUG_ON(ida, ida_exists(ida, 0));
+	IDA_BUG_ON(ida, !ida_exists(ida, 3));
+	IDA_BUG_ON(ida, !ida_exists(ida, 63));
+	IDA_BUG_ON(ida, ida_exists(ida, 1023));
+	IDA_BUG_ON(ida, ida_exists(ida, (1 << 20) - 1));
+
+	/* IDA contains a single bitmap */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 1023, GFP_KERNEL) != 1023);
+	IDA_BUG_ON(ida, ida_exists(ida, 0));
+	IDA_BUG_ON(ida, !ida_exists(ida, 3));
+	IDA_BUG_ON(ida, !ida_exists(ida, 63));
+	IDA_BUG_ON(ida, !ida_exists(ida, 1023));
+	IDA_BUG_ON(ida, ida_exists(ida, (1 << 20) - 1));
+
+	/* IDA contains a tree */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, (1 << 20) - 1, GFP_KERNEL) != (1 << 
20) - 1);
+	IDA_BUG_ON(ida, ida_exists(ida, 0));
+	IDA_BUG_ON(ida, !ida_exists(ida, 3));
+	IDA_BUG_ON(ida, !ida_exists(ida, 63));
+	IDA_BUG_ON(ida, !ida_exists(ida, 1023));
+	IDA_BUG_ON(ida, !ida_exists(ida, (1 << 20) - 1));
+
+	/* Now try to find first */
+	IDA_BUG_ON(ida, ida_find_first(ida) != 3);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, -1, 2) != -EINVAL);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 0, 2) != -ENOENT); // no used ID
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 0, 3) != 3);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 1, 3) != 3);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 3, 3) != 3);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 2, 4) != 3);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 4, 3) != -ENOENT); // min > 
max, fail
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 4, 60) != -ENOENT); // no used ID
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 4, 64) != 63);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 63, 63) != 63);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 64, 1026) != 1023);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 1023, 1023) != 1023);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 1023, (1 << 20) - 1) != 1023);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, 1024, (1 << 20) - 1) != (1 << 
20) - 1);
+	IDA_BUG_ON(ida, ida_find_first_range(ida, (1 << 20), INT_MAX) != -ENOENT);
+
+	ida_free(ida, 3);
+	ida_free(ida, 63);
+	ida_free(ida, 1023);
+	ida_free(ida, (1 << 20) - 1);
+
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+}
+
  static DEFINE_IDA(ida);

  static int ida_checks(void)
@@ -202,6 +270,7 @@ static int ida_checks(void)
  	ida_check_max(&ida);
  	ida_check_conv(&ida);
  	ida_check_bad_free(&ida);
+	ida_check_find_first(&ida);

  	printk("IDA: %u of %u tests passed\n", tests_passed, tests_run);
  	return (tests_run != tests_passed) ? 0 : -EINVAL;

-- 
Regards,
Yi Liu

