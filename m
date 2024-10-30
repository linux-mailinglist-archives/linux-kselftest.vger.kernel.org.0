Return-Path: <linux-kselftest+bounces-21088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 619779B5E5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 10:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45371F239DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 09:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562571D3578;
	Wed, 30 Oct 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iai5eMaM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CF153812;
	Wed, 30 Oct 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278888; cv=fail; b=GJfs0lGQzGEBn03863BwLCgDTa9nJM1QVhOd0OuvdMPhD4WWfiNXffdkmyICtVPTptdIhTGRzCANd76KUnsToHxzmXOGIN+OjuBHVjTiwXi1buxJH/edov+dG5kI05XYhmAf9//Ggm+lzpYZGJtCAw+rWvPFLgKu9youDdX/LRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278888; c=relaxed/simple;
	bh=BfWO0YSaerVRV3+AUZgxCm32yCouwPlFUtB4MZqX75A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZlBo4OUxjPqQJDQyB0xlNVb/lXjIEOtj2HgE3VsiLriNsedROcQWYaEpfKzOeIHelabSQH/Q9jgvtawQ4jia2anjYzs2mhlrWGS+okxWvaoEMCkObEYXoEelZ8MqV0ywudN+Esoes64RrejyxHYiaCf1m6xngLkIbQvbogg/Wrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iai5eMaM; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730278885; x=1761814885;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BfWO0YSaerVRV3+AUZgxCm32yCouwPlFUtB4MZqX75A=;
  b=iai5eMaMoEtPn5tQvnFzUqIW31z4a+Q78kNzLYCOb0ujSv2QeI9Dwfbt
   Fg24Zr86+Y1dEgWjWWIKgUX3LOXmNPIfQWpM8wWZJnAfvmUYiXBt+SbZW
   DFhvxO5ZbAhUBWdG3WT0CgzRlbswu95NMGQK+tYi5gKPTdhzbr8c1o2mj
   T/QC5WocqzuEVk9SBQF3nlS4CCh0dcPGzCEX8zmdhDtklGCrQ8DuaJ5bR
   RWD5eQTeenLRoLAWStRfpZVjys4pqblxXjrP1X+t12gM0mMmG/5XjjPMF
   yYnv9gyVTtMM+cqAGAvTk9YY28DBOUHGbVO3qt/UwUp+mhaOFo2iwZgBA
   A==;
X-CSE-ConnectionGUID: P0TUA/tBQjOcokcZm80+xA==
X-CSE-MsgGUID: 8LEWidOnQrWghpv3bNw3ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="55373928"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="55373928"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 02:01:20 -0700
X-CSE-ConnectionGUID: r4ABqyhKTJyI4t68MBfFxg==
X-CSE-MsgGUID: OwwJXkC2QBCFm0IKeKWcyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="81889111"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 02:01:09 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 02:00:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 02:00:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 02:00:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLr+tVT+YzngHKtBUFI68xivW41r8hKiRTWNa9bEdYdgBqr6zA7xxkuxnmM3lEonHImlzHVql9d4hO67laKSh6g+r6haWm9Chey5BcDdVgk4UFJr7wZgzRm1sR9rUrA+X3N1edF6LMMv5Vhe8n8T2Nezvf1HQyyX+5pPUh2AaeDLknmNX99kN5ONI22oDfLCwrc5x519xSgXGT7zzAeNP9MQl8WYkyU5obrDqKJLDAQlfsgYLIXDt4Cs0hvSZ7ntooU+1UHSg33QlnZgoCbGLdP3qdx4u9muwHgyVaim8wVgnTrqT2dQvrFez8VyLquFrDLXdI4DkGtYwMWsWMZwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1zds2y4j2boQhX+VycpgrMIJxvCAnF64ATV9/LQimI=;
 b=jEuknInMfTcNhZhZPRL8mReGoaZIbYiR6VgOGF+DiO7Cjexbq3oEqaWMsCICt5U0i9Wb1zs+7yHvR5vPwOqQkoI3aLdew6lAiE+zXR/cXF9DRuR1cm4lZTWHB2JH2yQ/J3GLYBaw6VWbgPNkzj7voYzUJRjkIgB/AbdVfFE/X3cxXylltrr2cuQA5k4owqGg2NOec0kUM32Rp0Faw1zWKbIj3+RVNTsGR3O/pq7rxlk1xv6v05ruuJV9OJVFHZuWi6hUEe7KxSGR8mnwOaQItQ506mEBne5PG8uOQzK1L8FRq6ZiiaM49PEM4pccmEkVUL+W98tYfeBKvPlxf7HQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11)
 by IA1PR11MB6468.namprd11.prod.outlook.com (2603:10b6:208:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 09:00:41 +0000
Received: from PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f]) by PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:00:41 +0000
Message-ID: <b8fe391e-b573-8f84-0a4c-828e790dea34@intel.com>
Date: Wed, 30 Oct 2024 17:01:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 15/39] KVM: guest_memfd: hugetlb: allocate and
 truncate from hugetlb
Content-Language: en-US
To: Ackerley Tng <ackerleytng@google.com>, <tabba@google.com>,
	<quic_eberman@quicinc.com>, <roypat@amazon.co.uk>, <jgg@nvidia.com>,
	<peterx@redhat.com>, <david@redhat.com>, <rientjes@google.com>,
	<fvdl@google.com>, <jthoughton@google.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <zhiquan1.li@intel.com>, <fan.du@intel.com>,
	<isaku.yamahata@intel.com>, <muchun.song@linux.dev>,
	<mike.kravetz@oracle.com>
CC: <erdemaktas@google.com>, <vannapurve@google.com>, <qperret@google.com>,
	<jhubbard@nvidia.com>, <willy@infradead.org>, <shuah@kernel.org>,
	<brauner@kernel.org>, <bfoster@redhat.com>, <kent.overstreet@linux.dev>,
	<pvorel@suse.cz>, <rppt@kernel.org>, <richard.weiyang@gmail.com>,
	<anup@brainfault.org>, <haibo1.xu@intel.com>, <ajones@ventanamicro.com>,
	<vkuznets@redhat.com>, <maciej.wieczor-retman@intel.com>,
	<pgonda@google.com>, <oliver.upton@linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-fsdevel@kvack.org>, "Li, Zhiquan1"
	<zhiquan1.li@intel.com>, "Du, Fan" <fan.du@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <768488c67540aa18c200d7ee16e75a3a087022d4.1726009989.git.ackerleytng@google.com>
From: Jun Miao <jun.miao@intel.com>
In-Reply-To: <768488c67540aa18c200d7ee16e75a3a087022d4.1726009989.git.ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB8455:EE_|IA1PR11MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 445c047a-4a4b-4eea-bb70-08dcf8c154aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3NwMk1oVm1SbkxvdjVha1FSSDFlR0hNYlZZR2pEcFNMYkU2YlhlekNPYTBt?=
 =?utf-8?B?SURVYXpjTVR5anRLcWY2cWZDa3pTSXRIL3ZKYmd6d2U3elhIU3dleHJtTkNK?=
 =?utf-8?B?YWtta2psWXA4OFFxY0JLeldzaFZJL0VRKzZnTnA3dHMxOWhTQXlSSTgyMEtV?=
 =?utf-8?B?UmpJeC9XSTQybVlESW52cW1SdFlzQjNUamw0TVVDOGIxQmU5dVBTeFhldmtD?=
 =?utf-8?B?V1czK3pwMUZROEh2ajVJa3N5ckZLdUhXV016UXJWTUxRN1hFZ3BiK3VHbEVP?=
 =?utf-8?B?N1BFYXlDblNObXN2MTJQeU0wUm1naGtEajVWT0xLSXRxdGJZZm8zK0p2emZk?=
 =?utf-8?B?bXNUcTMxMWVxbnJ6MGJGeGRxcjVwV2FjV0VDbTIyNW0rSXZaUG56bVh6RmVv?=
 =?utf-8?B?TkNSWXhHN0lxWE1aMWlRS2ozUWtqbG4zeVlFWVcvaWhzU0lJUytib3laTFJ2?=
 =?utf-8?B?d0ZrVnJFVnNOZ0pDZm1Vclk4TGVZeXF5NmMzK002dy9qdjZFVjRJWS84QUdl?=
 =?utf-8?B?OHl0cktCN280L2VIbnUvTFUyUnp6YklhRXlDck5mRXg2L0o1Q240ZGJZL2Za?=
 =?utf-8?B?MTZxejhyK1ZDMUI5R3BOcm0zOGpNYzhZZ1pKVkI4VnVtc2pvNllWRG9YNlIx?=
 =?utf-8?B?eE92YTBxRGt1dHgrMXdqY0tFQ1RPZ3ZraHZGUnIrNTlaUjZNK0NBdE9uUzlr?=
 =?utf-8?B?UUtvMUhEYVBLczAyTFRvYktUVmYwMVhVZ0tQdHFEcGVzV1F1ZkcvSnE2OUp4?=
 =?utf-8?B?Tm1Ca3piYUoxV2lNeVk2c2gzeGlLNUxPK2tWdDlMUG5wL25VM2pWZ0YwLzNW?=
 =?utf-8?B?MzBaWFYyNWJ0RE9aTHVnckt4ZVdpZ0xzbkErNFlvNk03YU5vQzBweUE0OUF2?=
 =?utf-8?B?dlFDOHlTRWJWTWZDQjRRN05LTHd3NXlQQ2FGa2VuVUFaV3d3WlRkWTg5NFRI?=
 =?utf-8?B?aVpFSW9kY3lUOVpmYjZIVE1Oa21yUUxZbUZIaGpIS0xWOUZBMmo1MlJIZjNV?=
 =?utf-8?B?N29ESVkwd1VoaVZObFMvMkh6aTJTWVpTbFZHWFpCUHRvR2JqU3FEbURvU1px?=
 =?utf-8?B?RXU5SHlyS1lMSGRxNWhyVEtHN3BZbFovYVFId3p4bnFXS0FheGE5UWVhMEdW?=
 =?utf-8?B?cVZ5TjM1VjljakRCRzZqMG1wYWFXdFYwNGNaVit0MmtBZGt6dWRwYjVjaEdU?=
 =?utf-8?B?MytTejJaWmtNdkk0ZGZVdnFDL1c1a1RVSTlDN3dHRlBJWUlWVkEwQUVMS1Vk?=
 =?utf-8?B?emhtMzhqU0hQUldhbzZ6ZEJoZUt4bVlpbmhMYVJQT3R6N0Q5Z3dKYXdhelU4?=
 =?utf-8?B?U2QySHBpWjkxVitJb3JzZXl3NXAyeU9sTmhnTjFhZmt4dFV0eVdBYmwwT1Rm?=
 =?utf-8?B?bE9MRkJQUWdXM0pQVW53Y3l1T2RENWtCcktKYkY5aVplc2kzY29FMjBMSW9M?=
 =?utf-8?B?RUJsVFpGbk9tUjRhajkwWHZkKzVNUEx0aXNvRDUxc0JzZUFxQVk4WEVxZkZZ?=
 =?utf-8?B?OXlESkZFamRFWS9YeUFBR2hPWlk1UU1kd0xBL3dqcmNjOVgzQWU5dzlySnlG?=
 =?utf-8?B?NDMwQWZIbHRDRHE4UFBiOTNuVkFxZFVXTnVyNjdVdlRMOGJGMHVLKzRUcUti?=
 =?utf-8?B?UE5NOWQ4TytIMWlzQ3puRktYemh2U0RXNk9CZDJjQWRLL1ZjeTZKWnZzWGha?=
 =?utf-8?B?dHdxTXZ1TWM5TUlZOG1vbEpVWk90RndrSFlzeE5kOXY1RlpYUnRFV1Fyd0VC?=
 =?utf-8?B?NDlhQk0xeG4zdndQR29FcTgvZW9oRVVWRjZ0RnI5VGx1dkJWY05yTVFXSFlR?=
 =?utf-8?Q?vnGCrJaWAkPSk9tjoB3SVeKvYuzyAS0h8IXq8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHlZY1VpdENCdDlqa2RJcWdQUU83dkFxSnZQc1lOcW16Nzd6Y05VN0IxeUhy?=
 =?utf-8?B?eWlxQzJWVzQvTHZIZU1XeTFET2lyME1VZG5UazRwUVdEaFpocG8vK2ZaTUFu?=
 =?utf-8?B?eWxOWXZyRGtCY3U5ZWdWWGhPZ2YzWHZ6UmNpVDBhQ3hORUcreEUySC9zUHNN?=
 =?utf-8?B?elBxU0tSOW5VYnlUdXdNM1RqWEFJdWFHdFNNMWorWG51TjJnUVBaMFc5Z010?=
 =?utf-8?B?bDRIL0dNY3BUL0p1SzJYM0FURk51bzZlclJ3UnJ2aG5pL0FDM2NBN3g0dmxu?=
 =?utf-8?B?Z1RJOWNnMjhpY296bjdnNmhMT1NWT0pDbUJYZURtb1lwZmtxeDhoMjR2dFly?=
 =?utf-8?B?dU05ZWRaWmdxbHR4N2cyTUVHRS8wTCtDdFQyYnk5dDhWbVBGRWZNTSsvdXJq?=
 =?utf-8?B?VWQyV0pDZnNHVnhqQzE4ZlBGanl6S256Z3pteFo4YWQzWEZ4RWlzRFF6ZS9D?=
 =?utf-8?B?RXBLbmpjOUg1dTQvdnA3eFZLOWlOandOZWZlTTJiOGE5TmpVT2Q1MXNvazZa?=
 =?utf-8?B?M2dTM0VTaVpYRFFrZkpsTElDRWNRbWhjcHlOSGxaVUdhcHhEak1OU040aURu?=
 =?utf-8?B?cVZvYWhZSDJoMU1uVkQrNHdjaWlDV2c4bVVTUXFwczJDODVEbU9nZFFHUHJs?=
 =?utf-8?B?aWlBbVVNV0laNlRibEQ2N05GcmxNdU0xVFJXRzJsUUFaeFNGdnNSTU5FZkI0?=
 =?utf-8?B?ZmJDZ1RKTzY3KzdVdTFQaFZuY1kvNEp1RGdmd2dLaVlVcC9yRHR1dkpqaSsy?=
 =?utf-8?B?UGFKa2ljNzlobHVUdTFQd1htbWJJRXJYRHljM2JTbDAvQThTWTFFOGF3cEhE?=
 =?utf-8?B?YlpCbFl2bzRkT0IyWGgwaEUwL3lySjJkRW0xS29JbmE5MzVoU2RBeVNuVVE0?=
 =?utf-8?B?VjVERkE2c3R0KzFINFd5V2NFdDB4TXZMUFRTK0NHQURJemNpRG9zU0dZc0hZ?=
 =?utf-8?B?d0l6WTk5NUt5MEZFbFNlbzBIWUIrc2pUTjNaQXBEMmhkWG05aEZ4OW9EcGJV?=
 =?utf-8?B?eEJ5SllxWS9GbmRrOUoyL2dXdnNGUTRtN2lrbUY1eDlkZmQ4bklpOVVEblVF?=
 =?utf-8?B?eU42YTZwZ08xMGNMNncyWUdqVVpxNW9vNlg3UHV0TkNhMkdkdmF5ckFoVGRq?=
 =?utf-8?B?ZnBHeUVXdG82QTJJdTFwYzBCUTlsNzB3N3dkWnVlcGNXV0hsNEhhTEFVY2dC?=
 =?utf-8?B?Qk1KZXY2bS8yQ0t6UFlxbElRV2N1TGhaaVdRMVdtY0l4U3pyQjh6andDZndK?=
 =?utf-8?B?RWNvK0xGQkFkbW52VjdVbkhNSnh5MHU0bmFXa3dzNlhmalprTWUwdyt0VTdq?=
 =?utf-8?B?Rk9DcmdzMGJGa0tsT3NFd2xHYkhlQmVtTVNHWitXZUpqcTFQb2FicmJpT3BR?=
 =?utf-8?B?UjJMaS9mOUFuQ2oyekRpaGc3R01EQ3NnRHp2R0ZOWWorbnQ0cUdybU81Nldi?=
 =?utf-8?B?ZEVtM0cyVyt2dHFOMXRMTGxJNm12YlVrcFRGOHh0UkthWFNRSUx4N1ROU3Ew?=
 =?utf-8?B?L0FWejlPM1pleDMySWp0R1VDZkZkZ040Z3pGSktGM3ZEc2FVYktrd1JtelNh?=
 =?utf-8?B?YW8xb3NjdWU4cnZDOFBwcG1yOFhOcXh3cGs1RGN3QWlrcTNkN0svcG9nNWFj?=
 =?utf-8?B?QVBrZnlSM2FkbmlyWkt4TVZZeElRb0NnUTdwMVhyeU5vWjF6N3JoMHJ4eGhY?=
 =?utf-8?B?dDFrVkxid2NON1NrUHl0azNFeEM5cGJxS0lLMjJkNGFObjI4UnZHZGJIeVp4?=
 =?utf-8?B?WDFBOTIzQmc0UkxFM25ZTTZMUCszdmZPVXJpV0lkczRuREVyVk1IZTNmaVVW?=
 =?utf-8?B?dDlpNUdWazJTRW5RcEtyU3JiLzRFeUJIaXQzM2FKOWthdFFML2JXRkpIdE1v?=
 =?utf-8?B?Mk52VTZYUFdtUTVEdVd6TXpXcytwZ3VRbUdlMmJqRjRwQzlyc0E3QVZlazdV?=
 =?utf-8?B?dyt5QmZZM2Uxc0ljVnkrM1ZGdTc1czhlaUY3UHFPR0NLVHhEREl4NklNTXZS?=
 =?utf-8?B?cnFKWEd2amZ4Vy94ZVRrb2huZkNxSFZmTWV4RjF1Wnc1NmdWc0lscXB0NGR5?=
 =?utf-8?B?VmxUcXhTTDRpdmdZY3M2Z3ZPZjEvOFN4M0Y5dE4rMzQvVktJSUttM0psTktR?=
 =?utf-8?Q?seWLJ/jeVqNGszZIKqv4eqchS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 445c047a-4a4b-4eea-bb70-08dcf8c154aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:00:41.6081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojb+O5JJa6fgp4O2GfcOX1pGjbc6dX/rkKTcffHkJ2l3Tt74AJ7IO2S6ib3Fb8y0ZYpLn7b1laVtzEnjP9C2Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6468
X-OriginatorOrg: intel.com

Hi Ackerley,
Due to actual customer requirements(such as ByteDance), I have added 
support for NUMA policy based on your foundation.
Standing on the shoulders of giants, please correct me if there is 
anyting wrong.

--- Thanks Jun.miao

On 2024/9/11 07:43, Ackerley Tng wrote:
> If HugeTLB is requested at guest_memfd creation time, HugeTLB pages
> will be used to back guest_memfd.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>   virt/kvm/guest_memfd.c | 252 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 239 insertions(+), 13 deletions(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 31e1115273e1..2e6f12e2bac8 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -8,6 +8,8 @@
>   #include <linux/pseudo_fs.h>
>   #include <linux/pagemap.h>
>   #include <linux/anon_inodes.h>
> +#include <linux/memcontrol.h>
> +#include <linux/mempolicy.h>
>   
>   #include "kvm_mm.h"
>   
> @@ -29,6 +31,13 @@ static struct kvm_gmem_hugetlb *kvm_gmem_hgmem(struct inode *inode)
>   	return inode->i_mapping->i_private_data;
>   }
>   
> +static bool is_kvm_gmem_hugetlb(struct inode *inode)
> +{
> +	u64 flags = (u64)inode->i_private;
> +
> +	return flags & KVM_GUEST_MEMFD_HUGETLB;
> +}
> +
>   /**
>    * folio_file_pfn - like folio_file_page, but return a pfn.
>    * @folio: The folio which contains this index.
> @@ -58,6 +67,9 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
>   	return 0;
>   }
>   
> +/**
> + * Use the uptodate flag to indicate that the folio is prepared for KVM's usage.
> + */
>   static inline void kvm_gmem_mark_prepared(struct folio *folio)
>   {
>   	folio_mark_uptodate(folio);
> @@ -72,13 +84,18 @@ static inline void kvm_gmem_mark_prepared(struct folio *folio)
>   static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>   				  gfn_t gfn, struct folio *folio)
>   {
> -	unsigned long nr_pages, i;
>   	pgoff_t index;
>   	int r;
>   
> -	nr_pages = folio_nr_pages(folio);
> -	for (i = 0; i < nr_pages; i++)
> -		clear_highpage(folio_page(folio, i));
> +	if (folio_test_hugetlb(folio)) {
> +		folio_zero_user(folio, folio->index << PAGE_SHIFT);
> +	} else {
> +		unsigned long nr_pages, i;
> +
> +		nr_pages = folio_nr_pages(folio);
> +		for (i = 0; i < nr_pages; i++)
> +			clear_highpage(folio_page(folio, i));
> +	}
>   
>   	/*
>   	 * Preparing huge folios should always be safe, since it should
> @@ -103,6 +120,174 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>   	return r;
>   }
>   
> +static int kvm_gmem_get_mpol_node_nodemask(gfp_t gfp_mask,
> +					   struct mempolicy **mpol,
> +					   nodemask_t **nodemask)
> +{
> +	/*
> +	 * TODO: mempolicy would probably have to be stored on the inode, use
> +	 * task policy for now.
> +	 */
> +	*mpol = get_task_policy(current);
commit bbb0b86af11574516fe78bc1340f49c9e6b7e588 (HEAD -> 
my-gmem-hugetlb-rfc-v2)
Author: Jun Miao <jun.miao@intel.com>
Date:   Wed Oct 30 11:07:16 2024 -0400

     KVM: guest_memfd: add TDX numa policy in hugetlb support

     Support the numa policy in the gmem hugetlb. This function need the
     corresponding QEMU patch cooperate to work, and set the numa policy
     like this in qemu:
     "--object host-nodes=0,policy=bind".

     If no set in the Qemu, the policy uses current task policy for now.

     Signed-off-by: Jun Miao <jun.miao@intel.com>

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index a49631e47421..cf569fe0740d 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -91,6 +91,17 @@ static inline struct mempolicy *mpol_dup(struct 
mempolicy *pol)
         return pol;
  }

+struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
+                           nodemask_t *nodes);
+
+int mpol_set_nodemask(struct mempolicy *pol,
+                const nodemask_t *nodes, struct nodemask_scratch *nsc);
+
+int sanitize_mpol_flags(int *mode, unsigned short *flags);
+
+int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
+                unsigned long maxnode);
+
  static inline void mpol_get(struct mempolicy *pol)
  {
         if (pol)
@@ -202,6 +213,25 @@ static inline void mpol_cond_put(struct mempolicy *pol)
  {
  }

+struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
+                           nodemask_t *nodes);
+{
+}
+
+int mpol_set_nodemask(struct mempolicy *pol,
+                const nodemask_t *nodes, struct nodemask_scratch *nsc);
+{
+}
+
+int sanitize_mpol_flags(int *mode, unsigned short *flags);
+{
+}
+
+int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
+                unsigned long maxnode);
+{
+}
+
  static inline void mpol_get(struct mempolicy *pol)
  {
  }
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 1f9bb10d1a47..6ba4eb0935de 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -24,6 +24,7 @@ enum {
         MPOL_LOCAL,
         MPOL_PREFERRED_MANY,
         MPOL_WEIGHTED_INTERLEAVE,
+       MPOL_INVALID,   /* Invalid parameter passing, come from and keep 
consistent with QEMU */
         MPOL_MAX,       /* always last member of enum */
  };

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f3e572e17775..b465ed5091c2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -259,7 +259,7 @@ static int mpol_new_preferred(struct mempolicy *pol, 
const nodemask_t *nodes)
   * Must be called holding task's alloc_lock to protect task's mems_allowed
   * and mempolicy.  May also be called holding the mmap_lock for write.
   */
-static int mpol_set_nodemask(struct mempolicy *pol,
+int mpol_set_nodemask(struct mempolicy *pol,
                      const nodemask_t *nodes, struct nodemask_scratch *nsc)
  {
         int ret;
@@ -291,12 +291,13 @@ static int mpol_set_nodemask(struct mempolicy *pol,
         ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
         return ret;
  }
+EXPORT_SYMBOL_GPL(mpol_set_nodemask);

  /*
   * This function just creates a new policy, does some check and simple
   * initialization. You must invoke mpol_set_nodemask() to set nodes.
   */
-static struct mempolicy *mpol_new(unsigned short mode, unsigned short 
flags,
+struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
                                   nodemask_t *nodes)
  {
         struct mempolicy *policy;
@@ -339,6 +340,7 @@ static struct mempolicy *mpol_new(unsigned short 
mode, unsigned short flags,

         return policy;
  }
+EXPORT_SYMBOL_GPL(mpol_new);

  /* Slow path of a mpol destructor. */
  void __mpol_put(struct mempolicy *pol)
@@ -1429,7 +1431,7 @@ static int get_bitmap(unsigned long *mask, const 
unsigned long __user *nmask,
  }

  /* Copy a node mask from user space. */
-static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
+int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
                      unsigned long maxnode)
  {
         --maxnode;
@@ -1463,6 +1465,7 @@ static int get_nodes(nodemask_t *nodes, const 
unsigned long __user *nmask,

         return get_bitmap(nodes_addr(*nodes), nmask, maxnode);
  }
+EXPORT_SYMBOL(get_nodes);

  /* Copy a kernel node mask to user space */
  static int copy_nodes_to_user(unsigned long __user *mask, unsigned 
long maxnode,
@@ -1492,7 +1495,7 @@ static int copy_nodes_to_user(unsigned long __user 
*mask, unsigned long maxnode,
  }

  /* Basic parameter sanity check used by both mbind() and 
set_mempolicy() */
-static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
+inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
  {
         *flags = *mode & MPOL_MODE_FLAGS;
         *mode &= ~MPOL_MODE_FLAGS;
@@ -1509,6 +1512,7 @@ static inline int sanitize_mpol_flags(int *mode, 
unsigned short *flags)
         }
         return 0;
  }
+EXPORT_SYMBOL_GPL(sanitize_mpol_flags);

  static long kernel_mbind(unsigned long start, unsigned long len,
                          unsigned long mode, const unsigned long __user 
*nmask,
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f34aff971628..7570aa38e519 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -20,6 +20,7 @@ struct kvm_gmem {
         struct kvm *kvm;
         struct xarray bindings;
         struct list_head entry;
+       struct mempolicy *gmemfd_policy;
  };

  struct kvm_gmem_hugetlb {
@@ -154,21 +155,21 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, 
struct kvm_memory_slot *slot,
         return r;
  }

-static int kvm_gmem_get_mpol_node_nodemask(gfp_t gfp_mask,
+static int kvm_gmem_get_mpol_node_nodemask(struct kvm_gmem *gmem, gfp_t 
gfp_mask,
                                            struct mempolicy **mpol,
                                            nodemask_t **nodemask)
  {
         /*
-        * TODO: mempolicy would probably have to be stored on the 
inode, use
-        * task policy for now.
+        *  Mempolicy would probably have to be stored on the inode, if 
no setting in qeum
+        *  use task policy for now.
          */
-       *mpol = get_task_policy(current);
+       *mpol = gmem->gmemfd_policy;

         /* TODO: ignore interleaving (set ilx to 0) for now. */
         return policy_node_nodemask(*mpol, gfp_mask, 0, nodemask);
  }

-static struct folio *kvm_gmem_hugetlb_alloc_folio(struct hstate *h,
+static struct folio *kvm_gmem_hugetlb_alloc_folio(struct kvm_gmem 
*gmem, struct hstate *h,
                                                   struct 
hugepage_subpool *spool)
  {
         bool memcg_charge_was_prepared;
@@ -195,7 +196,7 @@ static struct folio 
*kvm_gmem_hugetlb_alloc_folio(struct hstate *h,
         if (hugepage_subpool_get_pages(spool, 1))
                 goto err_cancel_charge;

-       nid = kvm_gmem_get_mpol_node_nodemask(htlb_alloc_mask(h), &mpol,
+       nid = kvm_gmem_get_mpol_node_nodemask(gmem, htlb_alloc_mask(h), 
&mpol,
                                               &nodemask);
         /*
          * charge_cgroup_reservation is false because we didn't make 
any cgroup
@@ -268,10 +269,12 @@ static struct folio 
*kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
  {
         struct kvm_gmem_hugetlb *hgmem;
         struct folio *folio;
+       struct kvm_gmem *gmem;
         int ret;

         hgmem = kvm_gmem_hgmem(inode);
-       folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
+       gmem = inode->i_mapping->i_private_data;
+       folio = kvm_gmem_hugetlb_alloc_folio(gmem, hgmem->h, hgmem->spool);
         if (IS_ERR(folio))
                 return folio;

@@ -905,7 +908,7 @@ static struct file 
*kvm_gmem_inode_create_getfile(void *priv, loff_t size,
         return file;
  }

-static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
+static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags, 
struct mempolicy *new)
  {
         struct kvm_gmem *gmem;
         struct file *file;
@@ -927,6 +930,8 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t 
size, u64 flags)
                 goto err_gmem;
         }

+       file_inode(file)->i_mapping->i_private_data = gmem;
+       gmem->gmemfd_policy = new;
         kvm_get_kvm(kvm);
         gmem->kvm = kvm;
         xa_init(&gmem->bindings);
@@ -955,6 +960,40 @@ int kvm_gmem_create(struct kvm *kvm, struct 
kvm_create_guest_memfd *args)
  {
         loff_t size = args->size;
         u64 flags = args->flags;
+       nodemask_t nodes;
+       struct mempolicy *new;
+       int err, ret;
+       u64 mode = args->reserved[0];
+       u64 maxnode = args->reserved[1];
+       const unsigned long host_nodes = (unsigned long)args->reserved[2];
+       unsigned short mode_flags;
+       int lmode = mode;
+       NODEMASK_SCRATCH(scratch);
+       if(!scratch)
+               return -ENOMEM;
+
+       if (mode == MPOL_INVALID)
+               goto task_policy;
+       else {
+               err = sanitize_mpol_flags(&lmode, &mode_flags);
+               if (err)
+                       goto task_policy;
+
+               err = get_nodes(&nodes, &host_nodes, maxnode);
+               if (err)
+                       goto task_policy;
+
+               new = mpol_new(mode, mode_flags, &nodes);
+               if (IS_ERR(new))
+                       goto task_policy;
+               else
+                       goto numa_policy;
+}
+
+task_policy:
+       new = get_task_policy(current);
+numa_policy:
+       ret = mpol_set_nodemask(new, &nodes, scratch);

         if (flags & KVM_GUEST_MEMFD_HUGETLB) {
                 /* Allow huge page size encoding in flags */
@@ -975,7 +1014,7 @@ int kvm_gmem_create(struct kvm *kvm, struct 
kvm_create_guest_memfd *args)
         if (size <= 0)
                 return -EINVAL;

-       return __kvm_gmem_create(kvm, size, flags);
+       return __kvm_gmem_create(kvm, size, flags, new);
  }

  int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
(END)

> +
> +	/* TODO: ignore interleaving (set ilx to 0) for now. */
> +	return policy_node_nodemask(*mpol, gfp_mask, 0, nodemask);
> +}
> +
> +static struct folio *kvm_gmem_hugetlb_alloc_folio(struct hstate *h,
> +						  struct hugepage_subpool *spool)
> +{
> +	bool memcg_charge_was_prepared;
> +	struct mem_cgroup *memcg;
> +	struct mempolicy *mpol;
> +	nodemask_t *nodemask;
> +	struct folio *folio;
> +	gfp_t gfp_mask;
> +	int ret;
> +	int nid;
> +
> +	gfp_mask = htlb_alloc_mask(h);
> +
> +	memcg = get_mem_cgroup_from_current();
> +	ret = mem_cgroup_hugetlb_try_charge(memcg,
> +					    gfp_mask | __GFP_RETRY_MAYFAIL,
> +					    pages_per_huge_page(h));
> +	if (ret == -ENOMEM)
> +		goto err;
> +
> +	memcg_charge_was_prepared = ret != -EOPNOTSUPP;
> +
> +	/* Pages are only to be taken from guest_memfd subpool and nowhere else. */
> +	if (hugepage_subpool_get_pages(spool, 1))
> +		goto err_cancel_charge;
> +
> +	nid = kvm_gmem_get_mpol_node_nodemask(htlb_alloc_mask(h), &mpol,
> +					      &nodemask);
> +	/*
> +	 * charge_cgroup_reservation is false because we didn't make any cgroup
> +	 * reservations when creating the guest_memfd subpool.
> +	 *
> +	 * use_hstate_resv is true because we reserved from global hstate when
> +	 * creating the guest_memfd subpool.
> +	 */
> +	folio = hugetlb_alloc_folio(h, mpol, nid, nodemask, false, true);
> +	mpol_cond_put(mpol);
> +
> +	if (!folio)
> +		goto err_put_pages;
> +
> +	hugetlb_set_folio_subpool(folio, spool);
> +
> +	if (memcg_charge_was_prepared)
> +		mem_cgroup_commit_charge(folio, memcg);
> +
> +out:
> +	mem_cgroup_put(memcg);
> +
> +	return folio;
> +
> +err_put_pages:
> +	hugepage_subpool_put_pages(spool, 1);
> +
> +err_cancel_charge:
> +	if (memcg_charge_was_prepared)
> +		mem_cgroup_cancel_charge(memcg, pages_per_huge_page(h));
> +
> +err:
> +	folio = ERR_PTR(-ENOMEM);
> +	goto out;
> +}
> +
> +static int kvm_gmem_hugetlb_filemap_add_folio(struct address_space *mapping,
> +					      struct folio *folio, pgoff_t index,
> +					      gfp_t gfp)
> +{
> +	int ret;
> +
> +	__folio_set_locked(folio);
> +	ret = __filemap_add_folio(mapping, folio, index, gfp, NULL);
> +	if (unlikely(ret)) {
> +		__folio_clear_locked(folio);
> +		return ret;
> +	}
> +
> +	/*
> +	 * In hugetlb_add_to_page_cache(), there is a call to
> +	 * folio_clear_hugetlb_restore_reserve(). This is handled when the pages
> +	 * are removed from the page cache in unmap_hugepage_range() ->
> +	 * __unmap_hugepage_range() by conditionally calling
> +	 * folio_set_hugetlb_restore_reserve(). In kvm_gmem_hugetlb's usage of
> +	 * hugetlb, there are no VMAs involved, and pages are never taken from
> +	 * the surplus, so when pages are freed, the hstate reserve must be
> +	 * restored. Hence, this function makes no call to
> +	 * folio_clear_hugetlb_restore_reserve().
> +	 */
> +
> +	/* mark folio dirty so that it will not be removed from cache/inode */
> +	folio_mark_dirty(folio);
> +
> +	return 0;
> +}
> +
> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
> +							    pgoff_t index)
> +{
> +	struct kvm_gmem_hugetlb *hgmem;
> +	struct folio *folio;
> +	int ret;
> +
> +	hgmem = kvm_gmem_hgmem(inode);
> +	folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
> +	if (IS_ERR(folio))
> +		return folio;
> +
> +	/* TODO: Fix index here to be aligned to huge page size. */
> +	ret = kvm_gmem_hugetlb_filemap_add_folio(
> +		inode->i_mapping, folio, index, htlb_alloc_mask(hgmem->h));
> +	if (ret) {
> +		folio_put(folio);
> +		return ERR_PTR(ret);
> +	}
> +
> +	spin_lock(&inode->i_lock);
> +	inode->i_blocks += blocks_per_huge_page(hgmem->h);
> +	spin_unlock(&inode->i_lock);
> +
> +	return folio;
> +}
> +
> +static struct folio *kvm_gmem_get_hugetlb_folio(struct inode *inode,
> +						pgoff_t index)
> +{
> +	struct address_space *mapping;
> +	struct folio *folio;
> +	struct hstate *h;
> +	pgoff_t hindex;
> +	u32 hash;
> +
> +	h = kvm_gmem_hgmem(inode)->h;
> +	hindex = index >> huge_page_order(h);
> +	mapping = inode->i_mapping;
> +
> +	/* To lock, we calculate the hash using the hindex and not index. */
> +	hash = hugetlb_fault_mutex_hash(mapping, hindex);
> +	mutex_lock(&hugetlb_fault_mutex_table[hash]);
> +
> +	/*
> +	 * The filemap is indexed with index and not hindex. Taking lock on
> +	 * folio to align with kvm_gmem_get_regular_folio()
> +	 */
> +	folio = filemap_lock_folio(mapping, index);
> +	if (!IS_ERR(folio))
> +		goto out;
> +
> +	folio = kvm_gmem_hugetlb_alloc_and_cache_folio(inode, index);
> +out:
> +	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +
> +	return folio;
> +}
> +
>   /*
>    * Returns a locked folio on success.  The caller is responsible for
>    * setting the up-to-date flag before the memory is mapped into the guest.
> @@ -114,8 +299,10 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>    */
>   static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>   {
> -	/* TODO: Support huge pages. */
> -	return filemap_grab_folio(inode->i_mapping, index);
> +	if (is_kvm_gmem_hugetlb(inode))
> +		return kvm_gmem_get_hugetlb_folio(inode, index);
> +	else
> +		return filemap_grab_folio(inode->i_mapping, index);
>   }
>   
>   static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> @@ -240,6 +427,35 @@ static void kvm_gmem_hugetlb_truncate_folios_range(struct inode *inode,
>   	spin_unlock(&inode->i_lock);
>   }
>   
> +static void kvm_gmem_hugetlb_truncate_range(struct inode *inode, loff_t lstart,
> +					    loff_t lend)
> +{
> +	loff_t full_hpage_start;
> +	loff_t full_hpage_end;
> +	unsigned long hsize;
> +	struct hstate *h;
> +
> +	h = kvm_gmem_hgmem(inode)->h;
> +	hsize = huge_page_size(h);
> +
> +	full_hpage_start = round_up(lstart, hsize);
> +	full_hpage_end = round_down(lend, hsize);
> +
> +	if (lstart < full_hpage_start) {
> +		hugetlb_zero_partial_page(h, inode->i_mapping, lstart,
> +					  full_hpage_start);
> +	}
> +
> +	if (full_hpage_end > full_hpage_start) {
> +		kvm_gmem_hugetlb_truncate_folios_range(inode, full_hpage_start,
> +						       full_hpage_end);
> +	}
> +
> +	if (lend > full_hpage_end) {
> +		hugetlb_zero_partial_page(h, inode->i_mapping, full_hpage_end,
> +					  lend);
> +	}
> +}
>   
>   static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>   {
> @@ -257,7 +473,12 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>   	list_for_each_entry(gmem, gmem_list, entry)
>   		kvm_gmem_invalidate_begin(gmem, start, end);
>   
> -	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
> +	if (is_kvm_gmem_hugetlb(inode)) {
> +		kvm_gmem_hugetlb_truncate_range(inode, offset, offset + len);
> +	} else {
> +		truncate_inode_pages_range(inode->i_mapping, offset,
> +					   offset + len - 1);
> +	}
>   
>   	list_for_each_entry(gmem, gmem_list, entry)
>   		kvm_gmem_invalidate_end(gmem, start, end);
> @@ -279,8 +500,15 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>   
>   	filemap_invalidate_lock_shared(mapping);
>   
> -	start = offset >> PAGE_SHIFT;
> -	end = (offset + len) >> PAGE_SHIFT;
> +	if (is_kvm_gmem_hugetlb(inode)) {
> +		unsigned long hsize = huge_page_size(kvm_gmem_hgmem(inode)->h);
> +
> +		start = round_down(offset, hsize) >> PAGE_SHIFT;
> +		end = round_down(offset + len, hsize) >> PAGE_SHIFT;
> +	} else {
> +		start = offset >> PAGE_SHIFT;
> +		end = (offset + len) >> PAGE_SHIFT;
> +	}
>   
>   	r = 0;
>   	for (index = start; index < end; ) {
> @@ -408,9 +636,7 @@ static void kvm_gmem_hugetlb_teardown(struct inode *inode)
>   
>   static void kvm_gmem_evict_inode(struct inode *inode)
>   {
> -	u64 flags = (u64)inode->i_private;
> -
> -	if (flags & KVM_GUEST_MEMFD_HUGETLB)
> +	if (is_kvm_gmem_hugetlb(inode))
>   		kvm_gmem_hugetlb_teardown(inode);
>   	else
>   		truncate_inode_pages_final(inode->i_mapping);
> @@ -827,7 +1053,7 @@ __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
>   
>   	*pfn = folio_file_pfn(folio, index);
>   	if (max_order)
> -		*max_order = 0;
> +		*max_order = folio_order(folio);
>   
>   	*is_prepared = folio_test_uptodate(folio);
>   	return folio;

