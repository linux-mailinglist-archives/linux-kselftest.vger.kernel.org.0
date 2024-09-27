Return-Path: <linux-kselftest+bounces-18464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A039883F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FB2282EA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002EC18BB86;
	Fri, 27 Sep 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsTZYkKF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A018BB80;
	Fri, 27 Sep 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439059; cv=fail; b=IwNW76cMoJUnyW89H4eXQ0EOocy20A0pLBI7UKj45Hqy9OuC8duRxoQlHkhnK1esOB2r1YXr7mOL3yXGJHLEYa6PL7IqgVSaPnerMlIkRjE26wv8fmpS8g/SuBlDGEyKhoS2mrsVCSG782fQzdwhB7fz6KIteyjcjYzeKClils8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439059; c=relaxed/simple;
	bh=x9ZMjmiZGvF6fkC2bEnDM0T5pbD0uJ4m6T7g2/95nH0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mdfdtvBAWiDdoxfmhBtwaWYTCENQPPa6Bh7MO2RU3VSyfkfbSww+sbZ/ctL/y6Ot+aG49xGegKkaZZsGL3TYx7mIYVNpH4fq4VCt9KVhNvr49uL1iWl+Q4//zVfOJMBn0np7DLdt2YU2svCsBuikAagJQxabFKJlNOXnE8IY9mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsTZYkKF; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727439058; x=1758975058;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x9ZMjmiZGvF6fkC2bEnDM0T5pbD0uJ4m6T7g2/95nH0=;
  b=MsTZYkKF0tjQbNTQaqGXMfWY7QzlBkex7Xb6dB5wgY63Psu68IIosLLY
   f2/Zrf5mOq5v/sdzmYDgkopQJ8aKVAsLVTiD6xV4QVnSR/5eCXgRU4sX4
   VNo77x1blxKOHzQIGAlkBKN1eT69YXbrYeRydQhzC0C1y8dfOrk07bg7C
   D7sB6eY05qC2PbE6GGonS+If0gmxnYIBwwPbFW6lzBcuWZcBXYv5Lbeu6
   o3wnZJPt5aBh28Q3KjwYbUGdLY7M9M73vAalslOTe/veviTmgUTdzk6aT
   tL6hhTlVEZiIsmfYq6MdQXO3xB+gux5T8h+d/B3PDZtrW4KAWBSS2jy+y
   g==;
X-CSE-ConnectionGUID: +f0xsVqTRtSNZ+ChvyGHeA==
X-CSE-MsgGUID: ywL8Xsz+SCeHcxfIPjsmMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="51994375"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="51994375"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 05:07:52 -0700
X-CSE-ConnectionGUID: HDQgeC0bT8ej/3dKBW42Kg==
X-CSE-MsgGUID: pcLCFyonQoqpM5Pf6TUodw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="77029763"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2024 05:07:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 05:07:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 05:07:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 05:07:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 05:07:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3pfdPOHI6Ud28LRvKASqPG7B5skF7TgHF8biVji8avisF3a4Ddu/GS5JO0KA9PARorbC4qtEIMHyCW2LjLLO8wGvLfaEJoz22ghWFVPqYnbPqe/Nh+jBu4kIh73x+EWQH7c3NOPFIGX946ai3a5TKLZFJDp/mGm/7Mg4Hutrl1N/JZq+pUJ7DKbJxJLuVHg5cVypk7hOTesvwLc7dLCR4gu5A5fgYoUn8OK+15ruJjS+1/uCYb4+bgEoVmO/Nm9sjQuavukokqZWAWRrq7x2cXUpLPcWAcZMUprHV/3sZxDrp+v7pugqERAhPvsy4YJ8vhknPlXQxbYG52pq2bhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odcAW3R7XODPlwUshtpoZbWfXeWsIZ0gC+NwevVN/OA=;
 b=m3BwZiz/j9upgHpqoZ/2huNLwTAQp1hj1BSIexQMTrszbPR6/rNoHGheoD1aqmWCJkbEJmTgbzhF2sn4BMKJWuZhLq4iG3laf7v/6mHUqmELKrZlRAy7tTiXWK6tqzoICMOr/Fmkz0SrvD2an1RGfYUdbRbX7ha/0C38XmChL5bjFRHFHI8hwwG1xNLFaPi7zN2RILWjN3k8bJTGLztofmS9Gh3As+OvJO8sTrPfAvNUNTOB6ki9lMyVzyEuVvYxnFetZ6nyaVEbp1LMnP/Q0aUJ73P0l2vATZo9aRdc7N1V6CdfOtPdfqAreOpiR8ivIN+mXA7xFd4zJN+Gt/6Mgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6477.namprd11.prod.outlook.com (2603:10b6:8:88::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 12:07:48 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 12:07:48 +0000
Message-ID: <8440cd72-ced6-4887-b724-ce6a1650db13@intel.com>
Date: Fri, 27 Sep 2024 20:12:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
 <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
 <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
 <ZvZRapZlAsEGDIge@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZvZRapZlAsEGDIge@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c43f502-d7ba-4970-d9f6-08dcdeed00a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnBMb09tTWNPRVFmRW4wOGxxeGRaQStDZmkvWk5FQ3hyOFZsOTAwa295cmtF?=
 =?utf-8?B?WnpWYlYrcHpHb1BRUVBtQ3dKbFZxczAyOXMzOFVsdTlwZHJUWVg5dTk3R3Bh?=
 =?utf-8?B?K0d3a29TeDVjWmsrMDBVU3ppWmVzNmdVanRGeXB2RzhKSEZ2UGthckhRQ3hC?=
 =?utf-8?B?RFpwTVo4SnNpank5K3JHV1Z5UTQ2aHFEVFpLM29qSTBqMWRtZEpEMTlieSsy?=
 =?utf-8?B?QzkxSHBpYVFpRGdNSUFkbDMwZ2dtRUVycFJTK1hLY2k4TDRXZTF5WTdmUkN6?=
 =?utf-8?B?RW9QeHNSNk8relJRK3pmUGZ5ZGZxNVdpZ1VWUWFKeERMeTM0aStBWlFMZE15?=
 =?utf-8?B?bmJ6MkgzaEVGNGlVZlRVaFdKcTBpMWVmSGNOejd1NXFYandNeGVrM3dLdVF0?=
 =?utf-8?B?QldvMkZ4RG94Y09LUGtOdWl6UFQvZ295NnorMW9XWWtyU3FWd3FrTUxBOGY4?=
 =?utf-8?B?cUI1c2JwTnY3SEhEL0VmcFJEbmpSVEJTRkFUYTlTZk9WN0dIWlUvZ2dTa0Np?=
 =?utf-8?B?b1poLzJ5bGZyYW14WmtOMmhGQ1JPTEpGOU9kM3BKckh5ZFhpZjdjQkpCTFZT?=
 =?utf-8?B?d0thWkxWUjRXNVEwTzMvMjVGeHQ5N0kxY2xhUW1PTElCVm4wV3RCaGF5MDEy?=
 =?utf-8?B?SXM0d1ZOSUt3NXdkRTdjSGRtakhpUWYyQW13MHMraVE1MzJQZDFBV3E4REFI?=
 =?utf-8?B?eDI3dEJzSTV2MUFtVHJnWG5ZUFlEaTkzR0RFYVZhNXBsUVlKS043WTNBTmlm?=
 =?utf-8?B?aGxlUnFzZ2NMT0h4NzhCeTYybTJsM09TUXRORCs2Z0U3blFMd0t1MlV2Ulkv?=
 =?utf-8?B?MWU4MlZ1TlAzMmJoYXJidzQ3TjMzSHFQYmgrNFdRVXNKSUEycy90VXRBdXlo?=
 =?utf-8?B?U2p3dE1zM0lXZzJPN3hzWVg3TzdIOU5ZQTZQU0lBT0V1Tkl2VkErMlZ5djNY?=
 =?utf-8?B?UXNYYXdoYXdvRDRJVDJlbFlXeXBVb0xyN1lvMldnRVdGakd6QysrVWpNZGZh?=
 =?utf-8?B?anNYM0F0R0cyU3E4WERUYXAyMVhPSWZrVUNQdFFsM0FnZDdwREsrVkxwaG13?=
 =?utf-8?B?MXNrcHhMdHZXR0I3WTNodkJNa211TkQvOVVBTUppUDkvdEVEVCtPNVZ5Z3BN?=
 =?utf-8?B?VTJseFV3dFlqSFZTSnlNZ3N2WERlckVpbzMzYVhqTVpBZ2Q1WWkwUG8xR0tH?=
 =?utf-8?B?UEd0V0FmL08xeXVVYlRxeloxV2pYZEhNczJmb1JaaTNhYk40N0huTjZjUXpn?=
 =?utf-8?B?a1kvWnpUazFvaHcwNHVZanJMOHRHdHhGN3FuL3prQjV5ai9VMFY5MUh1UjVV?=
 =?utf-8?B?dzRJMkRLZmJwQ29rL0Y0cXd2L01ocHF5UmlYL2VPVDdmSEpCK2JHSm12Vnkr?=
 =?utf-8?B?YkVHaEM4a215RUlTNzRUQmFqMHpVRUxmL0g3S085RDVnNjd4NFdWcFZiUG54?=
 =?utf-8?B?NC9rZkUzMnI4aXYvajhoSGNHUlpKcFdTMWFMVGUrRmFrYk53SEpFMUtORmpT?=
 =?utf-8?B?dGpjNk9KS1M1b29OWFRTbHRHWmlGcWNYUGFqZ0N6S3VVNDZ0Zzg5aTVsVUVy?=
 =?utf-8?B?UHVZeCtVaGxrNDVnL3hFTWtsTzNEc3JYRWs5TFVnbnE1OU02dUFnd0lPYlZx?=
 =?utf-8?B?am0vV093OVQrTzhnRFk0L2tERzZORzhPeDhLYjdac1M2ajJhQjRNV2lqSWkr?=
 =?utf-8?B?dUF5SkxSRFdYcGJib293c2RQZitRazJRYm1KTFhjSW80SCt4ZjZwRUM5bUN1?=
 =?utf-8?B?MW8wWmdMbjIwbmlicGp4RHBjNUI4QzBScEM0bGx2cGtENlRrV2xlV2x5MWRI?=
 =?utf-8?Q?h1FOMEB0YMUCEDVamNcTKJcn/d0Kiwv3ogOJ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hrWUcyMFluNHdMaUFyYWdUK3pCdStvZlNoYnNJUnBNb2g5QzVoTVFsa1N6?=
 =?utf-8?B?WWdzUVlRcHpSUmZyeVBYMUJvK2p4cFpiaWRqV0FYM0VNUnpiVExxbHduaWR1?=
 =?utf-8?B?SWhNM3dlcU8zdEFiT0dRcHkrcHNKUkpqV3dadC9ad3ZrV2JJeUNWZ2t2cVl0?=
 =?utf-8?B?QWY3bnc3azFOS2ZVUEdXdTk2MEQ3UjVQVXpnMTV3QkxXNnJPWEF2VXBkaTN3?=
 =?utf-8?B?T2ZGdU9TSUVXUDJHczB3YjRPMEVVZDhQenpORGw3L2F0QTl1dWhQUkkwNHln?=
 =?utf-8?B?Qm5ib1FRWjI1ZnVZdDJQaER1UE9rRXRiQlJkMC9mSkxkMXh5Tnp0N3YzbXJn?=
 =?utf-8?B?UnM4ZURNUEUvOXZmUC92UjkvNVEzRWROTmI0TU9PVVcxUWdyWU8yR2N1eWxX?=
 =?utf-8?B?S0ZVRXFMbUREb0x2eU1PZUVQWEtITFRzdm82ZzcvQ082RGIwMFZXS284RHBw?=
 =?utf-8?B?L0xLUy9EUkNSK2NKNFVPRHByN0t1TjRHYmttN2dHOGVtcmpoRUpSWXlTbnlk?=
 =?utf-8?B?SWUzNjhQYk93QXhGTzFiZGRHeXhaVGJEZld4bFpvZWgyQkhDOGFnM1gwMUp5?=
 =?utf-8?B?UFZwRVhNUnh5cmpaczc3emgxSFFMUGVzbFlFVXptT3VCTTkvOHpYNThrRGVK?=
 =?utf-8?B?OWJLTkxXQkhOYWpIWG5MVURHaktseS82TjZTY1NIMkNBQmdMaHpJWkIvZ0Np?=
 =?utf-8?B?VVExVnNERHNvVVh0Z1ZvaHRJQ3JlM0RaRUZ4bllrd2tMOTRralhVUnkvcDlK?=
 =?utf-8?B?TzJZNXZqdnlEV1lYR3EvcEpDU2NRYUJuNElJY2FkNTN6OHpWVzBmN3Y0bzBr?=
 =?utf-8?B?OG5HTFVvSVg4Nk4yUVNaOXRJN2dleUptKy82WmkxRDVlMU5EVE5TNGF0QVM4?=
 =?utf-8?B?L1ErdkZaN04xYWtIck9sRWdJVVdVMVJTV2paRHUvYkhwNkRjTGIvYnpvcWgy?=
 =?utf-8?B?TGpBUGlJZFFXbFJ0MEw3WEZ6QWZiTjFyKytLUW5wMTVjcVczNFo3WFNrMkY3?=
 =?utf-8?B?aENSOWJjTUxiZ1Z6MzN3aWQwNE8yY0lrNWlyVGxFRmZ5Um9IWE40MzhtNGtP?=
 =?utf-8?B?QkRyZjQ3Z3luRmx0K1FHcnpzd0VjSHRoUTFFaExuSzJUaGhVWll6bnQ5cnY0?=
 =?utf-8?B?R1daYS83MVpudFpUWFlwbm5RV2d6dyt1dU04RCtWQS81QTVYK2p5ZWdVc0tY?=
 =?utf-8?B?N1lKZjdwVkpOaGxFK0c3dldnNURHQVBuN29YeTFsTzJ4eWxYMXd1dVVrelBs?=
 =?utf-8?B?N3VnOXpmQUM1L0F4b0NoNUxXM3pRYzlZalgwNGNudGRYdjhwRmU2ZjJnd1du?=
 =?utf-8?B?WTQxQStCOFJ0N1Y5cklQZldwTEhlY3ZuL2xxNXdHK2R4QTRkSWhuOVE2L1VF?=
 =?utf-8?B?QnZodVQ5SVV4V3E1WWlia2FFZWZsdTFCaVRKMXZmMVI2aUF0NlBJS1FwamNG?=
 =?utf-8?B?Mm1iOW9xZzRoSG9DUzg4WmZxcVRFSnpudnBTS3FiY3VEcnoveVhsNEtNK0NH?=
 =?utf-8?B?QWJDcjlaM20vQzhHdk9kbnpEbCt1aGR5eUQ3U05kVFQ0TnRPRnNyMSswTlhv?=
 =?utf-8?B?d2c2alNzUDZZUE5GVWVnMDJaYUl5U0xQUnFrR1pVRUdWRlBnQzFVOVJyUmVa?=
 =?utf-8?B?Rk9rZDdGNU5wL0p3UXlHNWMvTTZLaVR2WHh0ajFkWmEvTWZHdDkwS3J4VE9i?=
 =?utf-8?B?djBOcGpZSnMxOGRxRnNOMXZVNmk5YUoyaUF0QW03dUhHSDR3K25rNlovZ1JE?=
 =?utf-8?B?ZUpSU2k5U1had1kvL0czSGpMaGZ4SUZKV2p5VHBva2d1azZyd2RqQzA4c3JN?=
 =?utf-8?B?YXd2ay9zRUNkQURPdFhUL3BwbWVpSVczL2RIekY4blRDMGc4eXRxNVY0eHZP?=
 =?utf-8?B?L1FCMXA2VXo2VDJ2VzYxZHJDeUpPOXRsZmUwK1oyeVhhem8zZXNVdDlLQmUw?=
 =?utf-8?B?azZTR3hvb0hMRklYK3daRVpzL1VIM1c4dmpOUnBUN080SHJqNWNFTFRucXdi?=
 =?utf-8?B?Z0RXSWNRb1poYVViaHpHWHl0OHlzc29UY2lsZTNvSy91VjFCcHRtUmVwN055?=
 =?utf-8?B?UjhzOVd2ZjhlK1JNNzdpNFdWNm94L0JKczh2SklKTEdOaUlUZUdETnlIMitk?=
 =?utf-8?Q?b3rRELO1NudxngrCblkbuFbfN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c43f502-d7ba-4970-d9f6-08dcdeed00a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 12:07:48.2101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kanUwXloyAS4NYhquBJuICzthDGyopk6kTbCM8+1A0XawNu8A2Ejz1SeOGAyM9AtIoHASv3vaSlZ6Ye4qOJ9YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6477
X-OriginatorOrg: intel.com

On 2024/9/27 14:32, Nicolin Chen wrote:
> On Fri, Sep 27, 2024 at 01:54:45PM +0800, Yi Liu wrote:
>>>>> Baolu told me that Intel may have the same: different domain IDs
>>>>> on different IOMMUs; multiple IOMMU instances on one chip:
>>>>> https://lore.kernel.org/linux-iommu/cf4fe15c-8bcb-4132-a1fd-b2c8ddf2731b@linux.intel.com/
>>>>> So, I think we are having the same situation here.
>>>>
>>>> yes, it's called iommu unit or dmar. A typical Intel server can have
>>>> multiple iommu units. But like Baolu mentioned in that thread, the intel
>>>> iommu driver maintains separate domain ID spaces for iommu units, which
>>>> means a given iommu domain has different DIDs when associated with
>>>> different iommu units. So intel side is not suffering from this so far.
>>>
>>> An ARM SMMU has its own VMID pool as well. The suffering comes
>>> from associating VMIDs to one shared parent S2 domain.
>>
>> Is this because of the VMID is tied with a S2 domain?
> 
> On ARM, yes. VMID is a part of S2 domain stuff.
> 
>>> Does a DID per S1 nested domain or parent S2? If it is per S2,
>>> I think the same suffering applies when we share the S2 across
>>> IOMMU instances?
>>
>> per S1 I think. The iotlb efficiency is low as S2 caches would be
>> tagged with different DIDs even the page table is the same. :)
> 
> On ARM, the stage-1 is tagged with an ASID (Address Space ID)
> while the stage-2 is tagged with a VMID. Then an invalidation
> for a nested S1 domain must require the VMID from the S2. The
> ASID may be also required if the invalidation is specific to
> that address space (otherwise, broadcast per VMID.)
Looks like the nested s1 caches are tagged with both ASID and VMID.

> I feel these two might act somehow similarly to the two DIDs
> during nested translations?

not quite the same. Is it possible that the ASID is the same for stage-1?
Intel VT-d side can have the pasid to be the same. Like the gIOVA, all
devices use the same ridpasid. Like the scenario I replied to Baolu[1],
do er choose to use different DIDs to differentiate the caches for the
two devices.

[1] 
https://lore.kernel.org/linux-iommu/4bc9bd20-5aae-440d-84fd-f530d0747c23@intel.com/

>>>>> Adding another vIOMMU wrapper on the other hand can allow us to
>>>>> allocate different VMIDs/DIDs for different IOMMUs.
>>>>
>>>> that looks like to generalize the association of the iommu domain and the
>>>> iommu units?
>>>
>>> A vIOMMU is a presentation/object of a physical IOMMU instance
>>> in a VM.
>>
>> a slice of a physical IOMMU. is it?
> 
> Yes. When multiple nested translations happen at the same time,
> IOMMU (just like a CPU) is shared by these slices. And so is an
> invalidation queue executing multiple requests.
> 
> Perhaps calling it a slice sounds more accurate, as I guess all
> the confusion comes from the name "vIOMMU" that might be thought
> to be a user space object/instance that likely holds all virtual
> stuff like stage-1 HWPT or so?

yeah. Maybe this confusion partly comes when you start it with the
cache invalidation as well. I failed to get why a S2 hwpt needs to
be part of the vIOMMU obj at the first glance.

> 
>> and you treat S2 hwpt as a resource of the physical IOMMU as well.
> 
> Yes. A parent HWPT (in the old day, we called it "kernel-manged"
> HWPT) is not a user space thing. This belongs to a kernel owned
> object.
> 
>>> This presentation gives a VMM some capability to take
>>> advantage of some of HW resource of the physical IOMMU:
>>> - a VMID is a small HW reousrce to tag the cache;
>>> - a vIOMMU invalidation allows to access device cache that's
>>>     not straightforwardly done via an S1 HWPT invalidation;
>>> - a virtual device presentation of a physical device in a VM,
>>>     related to the vIOMMU in the VM, which contains some VM-level
>>>     info: virtual device ID, security level (ARM CCA), and etc;
>>> - Non-PRI IRQ forwarding to the guest VM;
>>> - HW-accelerated virtualization resource: vCMDQ, AMD VIOMMU;
>>
>> might be helpful to draw a diagram to show what the vIOMMU obj contains.:)
> 
> That's what I plan to. Basically looks like:
>    device---->stage1--->[ viommu [s2_hwpt, vmid, virq, HW-acc, etc.] ]

ok. let's see your new doc.

-- 
Regards,
Yi Liu

