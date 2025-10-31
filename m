Return-Path: <linux-kselftest+bounces-44488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFAAC2338F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F7E18888E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD3928642D;
	Fri, 31 Oct 2025 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lqn/u43W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179417A2F0;
	Fri, 31 Oct 2025 03:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761883015; cv=fail; b=czJdhOeADDyoDVr+TgWMKC0GTjp0IzEAAN6e27q0t/bdENHniOqOYQBE1oNtCUuNr9IPfTMEleJa+7DMCj8M73u0VqwwwAuU7aCoyuRjrmuKdoQ4zweXLzdAfAB+6/Wak0mNrcFtzy7rUC95dDDeNXoXRcHpprMEnjll+IdHj8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761883015; c=relaxed/simple;
	bh=RraaOVh7yBQgvaqyXZ2wI0kAfIeoqX8Ma2gPJPWZxRU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pEs4KmksSWLZb1jN5T9EFPG7JtsQ/EyKVr4fjwVoI4PIdIQSgvHZPA/9tOoV2IEpwty3ZxC8cqjDeDTU98yROaZl8AfOUDdtJhshmk5BCeb2aeMT7aR5+3MM2CijQrTyFXEEj7A+4mJChDbvO2HioeHJW9MbZJjZMOEtdiZC7u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lqn/u43W; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761883014; x=1793419014;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RraaOVh7yBQgvaqyXZ2wI0kAfIeoqX8Ma2gPJPWZxRU=;
  b=Lqn/u43WNfvcaVjKxTRQi43YXLc8dVdmhiCugcPltp6C/Z4TW2erinHx
   Zx9ovKHmcrAe87uppUVPUWGScnMDXHg7Nfz2uluvH0GDzNla/2UjfvA6p
   q5xGZpwbRskSx3rDXN6ZIa5QYFrYS9zRs/cRlss8NIWEpxZLZOaRbWzG6
   hb5pEpBaoPuijOWiFbgT1pOlikYRShsboDNTm7/teh6nU1csL8YVKOLuZ
   aj9F4poIAnjoEHTzCXkz8qHWhVs8lj9dou+ItbQ6g8eG9XjaIc9h1BA2j
   996aKY0ouACetCjwiY8fPuvh+S08F1VKhFMLDb6d+XnZJOJJxH9SbfPtd
   w==;
X-CSE-ConnectionGUID: 6qzZmOAPQQy/lZK5VulCFA==
X-CSE-MsgGUID: gCG7Hu7AR+2efqRndGgL2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="66651242"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="66651242"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:56:53 -0700
X-CSE-ConnectionGUID: OKOBaRk6Q0u+uj2Uqoc1qQ==
X-CSE-MsgGUID: DOKqRd7NSFWU6Udey4UnvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="185790230"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:56:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:56:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 20:56:52 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:56:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXB6ROSSXecjofKtgD3Q+Vp2+esPCp+us8ocX7+dWymp2tmp1DRgSUQNnmufId/2EttYBB1BaeCyZ1Ny1odC8cpZZLFsCV8BqZKMczI9EgAaX0y4hmpwU1S3NsY23N8bNReEePH+El2dK+sUOk83vym5oMFtkJxHkSAZ4G7iDM5wUz8nitFT6Tr+l1fHnrJmyrIsBqIFcGFopMVS+Aj5EejeQIoayvHaY3vRrH0nq9BKKEJIuVNHzJ8lo4laqWm4NrZxMOMDRg9Dkf8M8Z6wDrZtVMuj7dMkCFhXEblRRFd0hhZ4hJWIFi+V8VhdLgA9KPdzn5X5VLFTSBbsE4J7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9H5pOA4U+K2U0K6JAroTTqGVXjcGWN+xEhJQUC7n3E=;
 b=IeXW8rd6mUtg729gVgrNrkOzkQf4RefyNIQTkIHESla4x8kCWmW+boAg//2b4kISPwtK8GkQ4fd9C86TJ4wPOP2snrnKtwmOodUZuzF5z+kz+bbAThjRLFoT3lORNtlR6Xme6Y6LwW/v1833FoweaZSlBhieTswmvs9OmqhKYqCUUydLlsq9mJHvWOkzsQkTCrY3Xljl2NSO9T+msG36czk1qFfF2LnDTCHm0YrtKinrkX+mh8GaxTUwfAPdirLDi0+YBTlvEP9LgbU8hAcFaDUdXhg5VjeqOzYcZUKq3J6FlWbnbrMyogR2eKUUEswiikl7Z5rY56GWXwiTu/c+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:56:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 03:56:49 +0000
Message-ID: <1fcab4ed-eee5-4fa8-9171-01ab35cde11e@intel.com>
Date: Thu, 30 Oct 2025 20:56:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/23] KVM: selftests: Add kbuild definitons
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
 <20251028212052.200523-8-sagis@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251028212052.200523-8-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: b558fa37-14de-44e8-ae99-08de183184d0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjZIa0ovNUxVOHhML0M5ZSt6bVpsMElSVEFrTVM1MHc5NjZIQUc4QXhxRjQ3?=
 =?utf-8?B?ZjZTUFVPeTFTWXorSnJnQWM2NFdNRXFwMzduaXJpWXc4ZUpQU0lRb2pwMC9k?=
 =?utf-8?B?M1NvU0kyVWlGbXUvMU5xekQ2d0JCK3JrT01lK0Zoek5md2RCTFAxL3RYWmFi?=
 =?utf-8?B?NnA5bnY2TXB5WmVnYWJlTExPODNVTnpvRVZlZldmc1dzK0F5a01iY0FjZGVa?=
 =?utf-8?B?NXlpNWk5SURCejNoSkFHZHpQQXVGaEQ2YjZaTGdSVEVtUi9icDY1NDBnb3BI?=
 =?utf-8?B?R1NlcGtzbEdQOXFvR3BQdVVRMUtDcUpGNXlvRGJ6MWwybndMVzhBZE1iNS9W?=
 =?utf-8?B?MW4wc1huc3FuZmVSaTFmeVhJaEY5dnlsNy9kOFNIbkxFbXVpbHFWRjJkWHNV?=
 =?utf-8?B?N0h4UEFKUklRa2NSdVcrb0VPc2hpTUtZQnZsMHlvSmFjK0h5dDd2K1ByMFRV?=
 =?utf-8?B?dlpUN004dWxmc0lCdFY1akFmTjRFVGlVbE5tbEFjd1g2cGZncTEzV1VOUXV0?=
 =?utf-8?B?aDhPRmVJZWFYY3AwVlN3OU9VQlI2TS9PckJJWVV6cm1DSGVDOEFSYTVUQ3c0?=
 =?utf-8?B?T2JQZXk1TzlGd1djdVQyNEs1VE5DMEtNZnRzTWJqeTVqREJyVmdWcnh6ZCtz?=
 =?utf-8?B?YVpNeTlXNjMrejB0bjU1WEdnanJselhodDN2V0lSNXZxQi9OTGN0VXVSK05B?=
 =?utf-8?B?cGthTVpUV1d1VDJwSE5TWXNrSnBZOHQyOVhxcTFCSW9jbzBrY2JzUUZrQWNE?=
 =?utf-8?B?RTVMeWlsOTBrOHNIUzV1ZU5ncndOM1NrcEViT0RFeFFBNkk2OEEzSEFPemNI?=
 =?utf-8?B?OGE0d2JWeHo4OUhFcVJYVTFjTm9XdWtsdXp1THJ1RmlPWVJLY2NWcUNkbGNv?=
 =?utf-8?B?OXRaa1VHVkxPenZCUVUvV01qODdURC81NmxjMnN2ZTIrc0VuVUs1a0gvQSty?=
 =?utf-8?B?Q3l4Ykx2aTFOYjM5OVRTNUI1SnlWVXMvNGhPQWI5b3lLYmUvWDNJend1RUc0?=
 =?utf-8?B?RnZ0TXFwcytQUkc1VGl2bGRhaEFod0tYTlBXN3RVT01VR2VmT05jN3N3VGdq?=
 =?utf-8?B?SjZodythcEpSNnlaY2FXSS8yZ3VxaGlZbk4zcC8wdzNwSDRPSnZuQzNHOWZY?=
 =?utf-8?B?TGdGQlZEZm8zSGsyNHhqUlR4WmJ3SS9RUTZJWVVuN3d6N3pRYVBySFl5NWEv?=
 =?utf-8?B?Q29DUTBVTy8rVHFlSFovT1JPK1ZnRzVxb0ttdjI1aE1kZmdUa1BXY05oYW01?=
 =?utf-8?B?dTlPSi9GWkxvTnIvdEFoZE1XWEtyUURsL0dodkFCSm56YUhBdGU5N2g3N1Nu?=
 =?utf-8?B?NWo1eGNadkVKcnhNMzZLL294SkNXOXhiMis4VmNBbklNbHhnM1pScUpXZVBi?=
 =?utf-8?B?dHo0a2UvM3AyR3JjTjhXVFhMdjR5OHFQbWsxamEvSDlzVGliRWJsWmwyb25W?=
 =?utf-8?B?amVENTdMaW9ZRTJrYzNVNmpXZ2d5cU4vZlJDTTdDTHU5WUFsRTZ4bnhydUxv?=
 =?utf-8?B?djdZSFUyUFIzMytNL3NHajlxMndORkphRGkxWU52b2ZUbGFla3B0NEJNUk5F?=
 =?utf-8?B?eUhJVXRvbVc1MlhJMWhMZlk3eXJZYXIzYnE4NVlyaHNUVXNqbmRTaVNINlJE?=
 =?utf-8?B?ZkY2MVZxWjBHd2d4d1B4eDUzYVpydi9TM3U5UmRIeGxXa1NOVHpKQTd1UE80?=
 =?utf-8?B?NzMreWZWdGZmeC9CYU9CZ0VLazVOZlRJWDBObit1R3RXSmxwSVdpcDh4WkVi?=
 =?utf-8?B?UWl6OFRzMmpudTQxZEpoK05PY01ZT1ZGSzN2SmtyYlhCZmJGQy9GTXlLVGpE?=
 =?utf-8?B?QmxPcGRHSEFzTFhiSlNPblZLSUVIS2pBYk5rY3RmbWlqWFdyQXFRalhvRTJi?=
 =?utf-8?B?ME44RTM0R0tMTWI3dmY3dld6UDQwN2g0WHk1VW9QcENJdGxtZkk0a0JZb3dH?=
 =?utf-8?B?ejB2d2NOOE5jaTlzNUs2eFJST3dIVEIwQzFRWkFJNkpHUGgrOVJFREtLd1ow?=
 =?utf-8?Q?lLNt8m23Fqs1q/bNqzoylf1LBWdWtU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTdjeW5hUFc1Zk9sMDF4UDRkTTZNWGpwR2RRVnV3UzZwN2JEZTlDMC9XRjRL?=
 =?utf-8?B?RENTaHhxSE5hdVkxckZyUXQzMm1TaUpmRFIyNmlHV2kvRnVtYnFXZHRRSlZl?=
 =?utf-8?B?MDFFaEd6VXlTbTBxZVlNcDFNWFhEdDBHSnlibnBEcEcvR3FsTHppMkpXeGE3?=
 =?utf-8?B?RU1BRE9uZ1ZGZjVqTHEySmJRNVBaN3hvQXpDeSt5WHo4Ty9kaWdmYXZUMlJO?=
 =?utf-8?B?NGxsRURDNHFqU25jSjVvaVE2T0h2MXVRZGV4VUVLUEwwL1pvb3pQYWM0UWlu?=
 =?utf-8?B?bHFEMlpHVThUUGl6RVZBWjlYUmpHb1BMazlCMlVFTlI1VkxqN0lQN0FPRCtP?=
 =?utf-8?B?Y2cvbnhwbGdKUDF6dE9LTERKTGw1clhtQXUyN3N4WkRtQ1hIT0tzZ1FIaS9r?=
 =?utf-8?B?eDQzK2RTeTNsa2Y2RXRDRDFvNkxtSFpwU01kaVlXdzNIMnphNHBRaHdrNGts?=
 =?utf-8?B?Tk5jekZpdHJ4MTRISWYwSXNIbTNuNGJiV0JuV3lnaHFEZXJmMHhjb1pveXQ5?=
 =?utf-8?B?UXhXR2VTWlVQSUVhbTY3d1d2cjdLQ2E5ZmRwRXNnbktMelpaRUtjdWF2M29a?=
 =?utf-8?B?OUhMUFpwNW1GZ0lGaHdGbnlZUGZUS0JUdnljVitEREYzY3ZtbDN2Mzd6Qnlr?=
 =?utf-8?B?ZVpOWWEyOGJ0cnRRb2FjTFNtTnJ4U0x1NEV3bnFNaWNpejRCdGVJbE9qeDFx?=
 =?utf-8?B?ZWY2RC85aHIrRFRDZjQzd0hCMjJnVDJGU09nVEpvZE1EN2I3VUNIeC9abHl1?=
 =?utf-8?B?U0NOVy85STFhOGpuRm5TTHRjVXlTdm1SZldRVVhvYktCelJETXUrYU1vTitq?=
 =?utf-8?B?RGYvdlRWOGtzajloWEdMWHg0UXp3bng0RVpWdExQSm94Uk5qTld6ckN4ZWZB?=
 =?utf-8?B?NjcrZFNJM0NuOWRsaGhkQzM3YmZLOXh0RS9UREJrR05ZWWVHbExHU1hzZ2VR?=
 =?utf-8?B?RlM4WUVHbk44TjE5ZkxRVTNxaEE0T09mYjBnVGNEZWJVUGFweE1IRC96R281?=
 =?utf-8?B?cm84OGVnUjBCaEZjOGZ0WEExeTUwOXJrQU5UOEVVUSt4TnFyck9ZMURBYzBO?=
 =?utf-8?B?SjQvc3RUeVNJVEtDMXV2bmNYMGJlT054Z0swdks3YkdybGVMaXVWTFRkcWEz?=
 =?utf-8?B?amZNZEpmMm5BS05PVXhDNXE1Wi9aZzQvRnJIT05IY3VwOGVvWlFic0VER2JG?=
 =?utf-8?B?clNzNUxNZUF4R0NTcXptY0U4NGV6MzI3TG1pdjg0NGpUYzlhTk54MEhLdDBJ?=
 =?utf-8?B?alF6REQweGRjSDBKZ041M1lpRFdLZUQxUXJaaGVMREJpRHBJeEc5c2J3Z2RB?=
 =?utf-8?B?aFh3enhWcTNScXRKMGlUc0ExRDlXRTlNcTc2cW5pR1B1U1YwTzFiSEdoT2VS?=
 =?utf-8?B?ZEphVkwwQ0dWNGs5alpWT3dMOFR5S2czL21mOHhsRGZFYmlpZ084MjNsQTdq?=
 =?utf-8?B?bGtaK0FtOXBPNzZkMXhnRU9vODZYWkNHTERndGYxU3dJM0xWd1g2S0VWWG9Y?=
 =?utf-8?B?TWQwYmJCYUQxUXBIZkd6RXNmbjBnRUdjK0ZZR1BoemJSeTJvL3A4eHA2dnhS?=
 =?utf-8?B?ZDlWSW1sRFZaYzhQQjZLMHVKM3BWNWVBTkkwRExaZUNNUVEvVjdZekxVN2tB?=
 =?utf-8?B?L2lnZjJnMi94Ny96OFZJWThCQnd3OTczSHJOVWpPUTdtbnUycmVVZUhLVmhm?=
 =?utf-8?B?RllRY2NwMTlTWDVTNFcxb2VWbFZGU3EwbTNLcGdCSFhGY1RCc3B1ZHREL0l2?=
 =?utf-8?B?dkVVbFZVY1pXTm1XbFRlWHZaeEorLzZZWEtXdkNLeEk4UHU1VlBwQlF0QXpR?=
 =?utf-8?B?NmhQMG5kdTI1MkRXS25jT211azBlalRUaHZySk9IVGV4R1BuUmpVbmNQWi9u?=
 =?utf-8?B?UlVXcGh1NXBOMGh4WWczN2JXSGpGOVhHMjlGT0NTS3AvcjdzOCtRU1dQZ3lK?=
 =?utf-8?B?cm1aOGxMU1lJYWVkNzZCVW1zQjdTWGFOTU9DNjFtMEJ6d0Vxcng3V1dCb05y?=
 =?utf-8?B?Y3Fya3g3akZyZlgyWDQwS0xod2hoSm01VVVhaE5ET1RSSG9jRWdMOWtwWDls?=
 =?utf-8?B?cHlsb2kxZXRaRjB4VWtSVjdmbnBBZ0Jocmx4OHJDQ3JYVHcrQTJnOVV6WVJL?=
 =?utf-8?B?VExPakpZRUN1NlpqaktEN3pCWHdPWHEraFJjc2pFS0dWMWRBaUkybDNPQjA5?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b558fa37-14de-44e8-ae99-08de183184d0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:56:49.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNzOaq0mmP0IbkXKjERRqXx5cdV/JrV39/ndx200iNK9srRyqBr1Ir4B8PD46NPSC77fNlRMuBF4ecD5mVT19HdTsG3a/rjYdQXQmabys1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com

Hi Sagi,

typo in subject: definitons -> definitions

This is not actually a KVM selftest change though but an addition to
core tools. I do not know if such an addition can flow via the KVM tree but I
really do not think that it should be disguised as a KVM change as the
subject implies.

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> Add kbuild.h that can be used by files under tools/

Similar to earlier feedback this is obvious from the patch self.

> 
> Definitions are taken from the original definitions at
> include/linux/kbuild.h

Always write in imperative mood.

> 
> This is needed to expose values from c code to assembly code.

I do not think this description is a strong motivation.
Another draft for consideration:

	Add the kbuild definitions to enable a tool to use
	the kbuild filechk_offset script to generate C header files
	containing structure member offset information.
	
	Tools depending on assembly code that operates on structures
	need to hardcode the offsets of structure members. The kernel's
	kbuild scripts can instead generate C header files with offset
	information for inclusion into assembly code. 

Reinette


