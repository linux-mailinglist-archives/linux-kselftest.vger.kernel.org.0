Return-Path: <linux-kselftest+bounces-15488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E29545E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 11:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDACEB21EDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996114AD19;
	Fri, 16 Aug 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9MQDHja"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7141494AC;
	Fri, 16 Aug 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801158; cv=fail; b=FBZRjRHxyjOaBCwN26USSbvo/cbGGY0FCJBr3s8A8DdXZIoarojDSKwjewrAZSewmcbabDyIb7aCGOzVYAARZzTjgiNebJTP06p+3wphnNb7KuL8Ae8addVg8NNVbSGgDOrCZfA0rkAnYVH2T/DkZboCvFtOCTxD4q3g1bv6E6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801158; c=relaxed/simple;
	bh=18vgdwC2etmioBpwPTNwRWWBK49gqsyVoZfFIeAk3IQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WOMPcYKdfOPiBX0xkWyMURe7+ZnZ9pEFNizpXcd5Re+z09b7Vg7rMAEzpudG4ZoJZwky5qCgo/Z/kwxp7lLje0Wk39vRTRPHgTpm3GY8g6jrCsgt7IUsdaEts5CNwLVQksiR0Y/B/kIQXg13IEAjk2g3d7Fg5+trT/AEW4oYV9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9MQDHja; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723801154; x=1755337154;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=18vgdwC2etmioBpwPTNwRWWBK49gqsyVoZfFIeAk3IQ=;
  b=X9MQDHjamNmxiWScfUv3RcqW/14HaraLkUoCQi3inD+bNZiHRu1XMCtG
   BO2Z01PhEBlrwwajCWfaJKl92iK1a/YuhYHUt2f15vqf8GQOQJDorrPQs
   /pTEI0bp04HtkmPqmlwmV2noMzecynPsvORvBfmqWK8a7BHcYurf1zG30
   NLc5vJ4FHhEpEprnyT9oa4ke6nT37IKXmSatje5dtDiGfXDqDN1h9QXPd
   tC7p1H2HEqCZcS7UIhv0lrRN+u8APFQ8D1n8Bwl74mUwZvz3EvN3ENidX
   mSdBbIJD7oGPjTcKLtffTA1iZt2mu5K2m8xUg0OEePD7I+kmS/pDI/MMh
   A==;
X-CSE-ConnectionGUID: +Ta3SOdHRSy/7017TCAwOw==
X-CSE-MsgGUID: vGPir9RQQSySxRwJsrgdtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22265827"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22265827"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 02:39:13 -0700
X-CSE-ConnectionGUID: b77Q6zyyRzudAKr4tvimsw==
X-CSE-MsgGUID: qf70rqzuTFeolVKi6TmDEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="82830902"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 02:39:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 02:39:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 02:39:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 02:39:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puqqLK1lnL7JlYcCJFYn4tVdxMkXMa4BnOe6An6BDiAF2IANvM1sKVAC+A+bASEAwVgoIPXbsX1abo9q/WiVZr3fVdgDEXFvmeKAcyx+tIgIMRvC38FrThFpgEKSX8KWR8yZ5m3tTEccMIoyNp79yhR2mecYe/VtZDCPQM0APvYPJ6rAeO/BoFgvSLnUSzpmrUo5X4qv9KzQsytNY7D9exA7tRnLAvPZZJzr5P6Y5IcotHh/XCm6y5djSsiIEOrnqKqOb8NVzfJut1HcWDbT5ubQFUjxG0ps0iCUcA3By68lAIMefPhBS3uMX4SHySsbuxUNcPkkg5qfyCRBhmNoxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8/tF6GqlFMxT14hACSi8PpVR6FA86c/Alxx9atoWTM=;
 b=gonhnC31gvR7s8LguXDgsKxcnrrA4r3p54DRsRBPYYWCQBTCxUEYl1TAUrSTwm5KPeQeybSYCnTyqOeuUJ5FRLIH0l3QDh9E1pFDchu1lQwUa7TryqNqMlIwRHLS92cpNz5Hfa6j3XJMeL+wquRtynH+Wy0orVsWIVHB+zxybpoTf4cV+iiqBb1Dth2An1gSA+xA5LHynTnEaXynD4UkTMBIencJ0b/mPCweTYHZNx7CpZHCnpdCBre/IsMWzuTbSU0kkoyWCd4fsafPNLdal9a0cTYDaEObYVSq9FydsRUUyHMoOy1MrEfBLFLCmDsDt72Ea9MNC1I30Cpcl6EZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB6862.namprd11.prod.outlook.com (2603:10b6:303:220::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:39:04 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 09:39:04 +0000
Message-ID: <1a825f1b-be9d-4de1-948a-be0cce3175be@intel.com>
Date: Fri, 16 Aug 2024 17:43:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] iommu: Introduce a replace API for device pasid
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20240628090557.50898-1-yi.l.liu@intel.com>
 <20240628090557.50898-2-yi.l.liu@intel.com>
 <BN9PR11MB5276B4AF6321A083C3C2D2648CAC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276B4AF6321A083C3C2D2648CAC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad3582a-5fa9-4009-684c-08dcbdd74430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0xSeE8rV3BqblEvWGE4TFl0SzdrVjBONHNLM1FaTzdlZFQ4dmt2UzdmM0li?=
 =?utf-8?B?QUxpbDkreVNaT3JFaURRSWZveXU3cmF6MFpNaG50TjJodDJRZ1RQWSszd05Q?=
 =?utf-8?B?NmxzT0JBS1NEclJHbHJKOENvMmx3dkc4R2hXWDRWYVBNUVpWb1RSVjkrWXVL?=
 =?utf-8?B?WTcvWk5mbW9zTFpBeHRRSFFlY2dYWDdaZzg1UUVjdkVVOWtUdlphZUxQaTJE?=
 =?utf-8?B?ZFFjQ1FhaWJRdTFaQTdoSFN1dzRFTTlVbnBkSUVyWHFMa2JYRGs2WkRKeDdv?=
 =?utf-8?B?MWJxQXVtdTg0dlRLK2RtM08wN3ZTaDVKd2FLWGxoYzFDRlBsb2xGWUJQMWY1?=
 =?utf-8?B?eVhiay9rNnNpTXpZZkdnTm5LNHB2NisrdzJ3QWJNTnhtRjZmRURYdWNjd0xv?=
 =?utf-8?B?Y1R5VTI4T0JpSUxGTXhmK0NLMnJ3bURaWmErT21qVEFGNzl1MS9WTUN1NTZv?=
 =?utf-8?B?Mk1HWndyY3BqUXdHWWFhZExXRXgxZDR2ajhyWm9CKzNjLzltUjZlRjU4WStZ?=
 =?utf-8?B?a0xPSmpVM0NPMkgxRXJLV1RFUGNYTXYzZXQzU2FSMnQxclBlNXRBVjQ4MVRC?=
 =?utf-8?B?QWpUNjZ2SnhKazZFUzU0T2dSa1dLbmsxMjgzVnhOTTNuU0VIQUNHRmV2d0hp?=
 =?utf-8?B?UTZ4cWJEQ1ExbEFFVFlrUGJvYUNCUEM2NjBVRnZrWkNia0RaNDNwbmsvT2FK?=
 =?utf-8?B?bVBad1VUaFZvOXRPTzN6N1NmVHVqY2hqS1U4bjVMMFR6cFJSVzNnVjZ5WHIx?=
 =?utf-8?B?YTdIN1pzL0lDYUNRc2krc1hWbmwvaVlpU0I3SXFKWVNONkNPNitOVTlkK1dw?=
 =?utf-8?B?VkVnd0JoaDB4T1NMVUxzSzBlT29BNVBBOHhPUzJ0LytVekQwMGMvczVYNnEx?=
 =?utf-8?B?M0ZtVlZHa0s1K1VvZUdEMFBBbGZab2MwZWgyTit2Wlo0TDdCam5qMXIvUFR4?=
 =?utf-8?B?Q05wdWl2bjdxTFVWemtTbkxvUEVhemFNQ3kwdHpIU09XZzNyNURwY1MxL0k1?=
 =?utf-8?B?OGwrNXROU09EcjhTdEkyRmYzeEYwTi9XVTQ3ck1OSURxczlISUdObFI5TGUz?=
 =?utf-8?B?UlBWRWMyaktmWjRGeDBZUG9VOGExaHdzNENSeWh2TEt6YnVudFgxRHJFMVJY?=
 =?utf-8?B?UnUwZXNycCtOeExaZ1JWUlpEN3hKSFNvRkduYXNvb01hbXdEQi9IWHlUREZN?=
 =?utf-8?B?VmJDQWJJZHlsWUhwclo2amZXdkNFem90RzdYVGJ5d3MxZm40bllHSmRoVEVE?=
 =?utf-8?B?NXpFdGJma2Y2dS82K29EMkJmc3hxS0N6K2gwZXBuU2kydFh2L3k2UytveDNw?=
 =?utf-8?B?MjBxVTgvZUZoRkRpVEpiNzl5RHdpWlRmWTFzeW1RUDJVMzIrLzlnQVNlMGty?=
 =?utf-8?B?aDh2VHZ6N2h0eEF0cG10dVBFMXZXUXEwN1NkaHpKUkErRVpKUXRleEpOekZz?=
 =?utf-8?B?NmVudmk1cjZJTStRWm1vckpzT0o3c2k3aytkV0cwYjdXMnJtYy82azM3Nkxh?=
 =?utf-8?B?SVJrdzV3NmdVVHVMekl2WnNQd0FQcnZyamxkRkNGZFp2eHVqb3ViNDRVY2VI?=
 =?utf-8?B?WjNKNHYxMDNiQUhpdjI3Q2NaWSs0dy8rRWd4bDJDV3V5anlsR0pzRlA4ZDVj?=
 =?utf-8?B?YjZ1ZU5wRDh4eUpzdlNwNWFZMjZFMDRmVTFVcGV0bUwrZWRHSFRjVkhaSlho?=
 =?utf-8?B?eWFyMG56SElEcHJxTHEvM0c0SDF1VUYxdUM4ejc0LzEzUjUvL3p3bXBhT0RY?=
 =?utf-8?B?M21KVVUweVJ5VHVpWXp3cDh5eFZybXdOMCthUmt2ZXNhaXZtaGxwZnUrNnN5?=
 =?utf-8?Q?O8stWyXfkFFHrp3Uzjy7UAQUZLN/8n9/qqVls=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXV5dGdWY3kvNGZ3VzdtdnVMcW1GOWpiNU1QRTZVT2RzZDFDUFFXVTZXTlJw?=
 =?utf-8?B?YU9vblFwYkl6ai9LL0twZHZHQzk2TDJCeWpucWxnQmcyOTZUNURmNm9uenA3?=
 =?utf-8?B?TGk5azFXdHFUVlNYTmxDY2VnNysyVy93WkVvU29qWER4TDhCNGRKWWZ6bm1o?=
 =?utf-8?B?OGZuZHNqYkFPcE1zR2NuU3EwTmxxVjJvUFRKUWxNVUpCTVlCTlc3UkMrbndZ?=
 =?utf-8?B?N2pvNVJqY1VWQ0hiRjBlN1VxaFZScklKUEV2NDZWUzYreWh0QmJLc282Zzh3?=
 =?utf-8?B?WkdyaDlCL0ZUR1RaR2s4Y1ozV3ZGaWRiT1N2MkR0bGkrT0puc21xVXJzNGJF?=
 =?utf-8?B?ZmZIOXZEOHVkaStYbzRDWjlEYy9ZVWVma09KWHhYUmx0Q1g3M0ZtcFUxR3ht?=
 =?utf-8?B?VUZnS1Vrd3gzZlQxN3dXVUpmUzVVUjFwa1NYeEZJeCtobWF5dnVZY2RvWXFI?=
 =?utf-8?B?NkYvbEhkY1g1YmpvcE04OGFDam51bUNheGV5ZEltNVZidDlDNEZ0cXpxUE5G?=
 =?utf-8?B?eWFmd25FWUlhRUJ3VDVYMThITGowelUxaTB0WjM2cE1qeEFTR01XWHlSdE9E?=
 =?utf-8?B?cCtRRjNaTFVnaTM1MVc5YmVCZ3k1b20vSUVOTzdUVncvRDRiWWRUVm9Id294?=
 =?utf-8?B?WkJlQnNqUDJacndXVHRnZlM1NVlacGNUL2ZyOUQ4ZklueVY1Yjc3RVZ2NjY3?=
 =?utf-8?B?bUM0NEJZVFBrMzhjSzBYbS9WSXFjVzBFRHFpZUVjQlVYSW01eWd6bGVXRjNL?=
 =?utf-8?B?czVXSmJwWDVvYktXRTBkcUxrb0VLeG5mRVNTUTFoTTVIUWRMb3RGallrUlZJ?=
 =?utf-8?B?MFVacFBKeUNEWlB1bldKT0tsS2hzdkd5cGdnUERWdlBWWnRMTjVxMjc2dUh2?=
 =?utf-8?B?c2lFVkdmenVzVEIvd3hDKytkd3ZqUjdieTU4OXMzdCtUQkNDbmhjMVVlK3F3?=
 =?utf-8?B?TkdKOUkwQ0VsdTEvdVU4Ulo2UmtGblRPRnczdEswRVQ0RlVEZkkxYld6bk9Y?=
 =?utf-8?B?V3R2S3VTSy8yYzA2QVBnMUFqOGNrVlV5L2xXR2lwcTd1OFUycTB4Z3ZGWjBY?=
 =?utf-8?B?MlppY09SNmgrQ01nS1RrRXZpMkgydkt6ODlZdmxrSVd5NFNQbTZ4am1xZVEy?=
 =?utf-8?B?eS9JUUY2SER3eURQWGZjRWFWNWJSSlRaSWhtWi9NTHJCK0FiL29tRGdSd0xr?=
 =?utf-8?B?dmlUK2Q5ZGZjYVc3Mzkwb3NwaDYrdHc3bkRFTXhlN2kwYWdhUGE0T01ETFlM?=
 =?utf-8?B?bnBhQ2V2VUxrclFMb3Rqb0lBODFVRDlBMENOSFNTU1pLcFpEcDd0WDBmUkVr?=
 =?utf-8?B?YUNwSCtueXJlaVNTUGJkMTdqa2J6ZXk4enBiYXBKM09xLzZnNDNhcm9BOENW?=
 =?utf-8?B?UDRXdUZ5TGhrb2phTGRmOUkrcHpjWlBHQmJoYTBZc0JOa29jdUIxd0d5Rjl2?=
 =?utf-8?B?d2s4NDd2Z2lhNVdoM3lnZzd1a2pOd3ErUkZ3R00yQldrSlpLeXd0eUhNdWlh?=
 =?utf-8?B?WnA0M3JvOExQMWs4aVNrMW1tei9HZkd1dGZtc25TWnNCaDJqTE8yL09WQUhE?=
 =?utf-8?B?ckV2TCs1cU5jTGtnTGEwNm9WOUFNY3N5UTl3bTQ0c3NMVDRhK0NHVVRvRmov?=
 =?utf-8?B?dkl2ejBGbW8vem80WU02L3FDZEZZVE1PUWxHVWtCanUrVjdMejdOb3NyZm5R?=
 =?utf-8?B?bjhwK0w2TURmVkM3dmJsZXhDYXR6S1NaMVl2YUNlK20wRlZiaXdKcldmUGl0?=
 =?utf-8?B?M2Njc3pxdSs4ZzdiU1ZZWWtyYWRBTHFtZkhhd2NSZE42Z3RDMmZOVzV3MllS?=
 =?utf-8?B?QVdxOVJySEVOOG05Rkt3OERxZ1VWVzUwNzVoWUl5cGtTd0dBWEhoMGFka2JQ?=
 =?utf-8?B?QWIyMnp1WGZoRWVEL1pkaENMYXRIK040TVZmd1VUZjVJaHUxL0hUWHhNbnN2?=
 =?utf-8?B?MmM1NXMxMkNCR200K0Uya1RqdmdLSFpPeUk3aTVCbnBnN244S013cjVaSmhx?=
 =?utf-8?B?S29ZK1QxSWFVUm1iOU9tRC95RERScVNHQTFQTWZHS0hMVGlSN0Z5N1J6b1pN?=
 =?utf-8?B?WGdCNzRFZEdUU04zS3ZpS1pIYkZsSFc0MWdMTXIvQ2ZPTXFiTmNrclVZd0lT?=
 =?utf-8?Q?0GBU9AXHuMcxczNAZj2PgPRm4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad3582a-5fa9-4009-684c-08dcbdd74430
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:39:04.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPzOlHCu2V5QamLo6qaF86BPSYoM9JuIzlUKi69AEdqfnNmGWB5y2h8/vW4SvBtR7ZumhcQuANflxzV2zE/0PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6862
X-OriginatorOrg: intel.com

On 2024/7/18 16:27, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Friday, June 28, 2024 5:06 PM
>>
>> @@ -3289,7 +3290,20 @@ static int __iommu_set_group_pasid(struct
>> iommu_domain *domain,
>>
>>   		if (device == last_gdev)
>>   			break;
>> -		ops->remove_dev_pasid(device->dev, pasid, domain);
>> +		/* If no old domain, undo the succeeded devices/pasid */
>> +		if (!old) {
>> +			ops->remove_dev_pasid(device->dev, pasid, domain);
>> +			continue;
>> +		}
>> +
>> +		/*
>> +		 * Rollback the succeeded devices/pasid to the old domain.
>> +		 * And it is a driver bug to fail attaching with a previously
>> +		 * good domain.
>> +		 */
>> +		if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
>> +						    pasid, domain)))
>> +			ops->remove_dev_pasid(device->dev, pasid, domain);
> 
> I wonder whether @remove_dev_pasid() can be replaced by having
> blocking_domain support @set_dev_pasid?

how about your thought, @Jason?

>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>> +			       struct device *dev, ioasid_t pasid)
>> +{
>> +	/* Caller must be a probed driver on dev */
>> +	struct iommu_group *group = dev->iommu_group;
>> +	void *curr;
>> +	int ret;
>> +
>> +	if (!domain->ops->set_dev_pasid)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!group)
>> +		return -ENODEV;
>> +
>> +	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain-
>>> owner ||
>> +	    pasid == IOMMU_NO_PASID)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&group->mutex);
>> +	/*
>> +	 * The recorded domain is inconsistent with the domain pasid is
>> +	 * actually attached until pasid is attached to the new domain.
>> +	 * This has race condition with the paths that do not hold
>> +	 * group->mutex. E.g. the Page Request forwarding.
>> +	 */
> 
> so?

This is added per the below comment. Maybe I should have made it clearer.
Due to the order of this xa operations, the domain in the xarray does not
match the actual translation structure, but it will become consistent in
the end.

https://lore.kernel.org/linux-iommu/20240429135512.GC941030@nvidia.com/

>> +	curr = xa_store(&group->pasid_array, pasid, domain, GFP_KERNEL);
>> +	if (!curr) {
>> +		xa_erase(&group->pasid_array, pasid);
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	ret = xa_err(curr);
>> +	if (ret)
>> +		goto out_unlock;
>> +
>> +	if (curr == domain)
>> +		goto out_unlock;
>> +
>> +	ret = __iommu_set_group_pasid(domain, group, pasid, curr);
>> +	if (ret)
>> +		WARN_ON(domain != xa_store(&group->pasid_array, pasid,
>> +					   curr, GFP_KERNEL));
> 
> above can follow Jason's suggestion to iommu_group_replace_domain ()
> in Baolu's series, i.e. doing a xa_reserve() first.

yeah, I noticed it. But there is a minor difference. In Baolu's series
no need to retrieve the old domain, but this path needs to get it and
pass it to set_dev_pasid().

-- 
Regards,
Yi Liu

