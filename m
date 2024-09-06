Return-Path: <linux-kselftest+bounces-17350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A6D96E88F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 06:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79594286AB5
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 04:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A703770D;
	Fri,  6 Sep 2024 04:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gx5xJacC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D6946F;
	Fri,  6 Sep 2024 04:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725596218; cv=fail; b=mT43pBh59Nprm1Wumo9P8V0lp38D51EmwjgtTFCaGiytgfYglxbAjur2X9oRHa1Jip71LGLiW6oUXwlK8jhW6XD3C7JIcxy/uTfEFpyaioc6e5aH3vB1gArVLAN8R5AdZ/60FXeddHHJlHrDrI9ULMSnAFQViL2cJxs8PIpUoeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725596218; c=relaxed/simple;
	bh=CCqihRAtvrbnpbAfwQkchx4fGEy0ft/7VOZzEycE8kY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mnd0VCBpWI66KLVdYagevqulcOMNZxYiSkr2nSLVBVY8kpXh+XRsU7FaCU1Ie9LQ7aQtC2OzKqqKAaLl4BTQAYik2hkV62KLQyVD0WJ/j9R7UknSU/ErM7FUDXbbcA1onDKeUMEXvN/GhOx/oEXYPo+4/v9I3R1etXzRsPX9UBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gx5xJacC; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725596216; x=1757132216;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CCqihRAtvrbnpbAfwQkchx4fGEy0ft/7VOZzEycE8kY=;
  b=gx5xJacC1dZ68HVd0ky158OB1frPWa6bdL6l065BKpZcX4zw9gHoTb+Z
   PkOBvMGsPvmSiMyoept2ta2vYT+e9l2s7CeAJ0CZq1opPCl7SVcuEpah8
   f6cxRMm1BBMVnWxkoBsW1hkfIst98WHXSr0BDdJGZVz1klJGl/kjCSYbv
   lieIAYScj5euNA5Tb6Jj2Bukv0WFZWwbcHnKBJ2HqOFt2F7BySXiGlPKH
   EHLEQhzmyuZ7wiZFpameZXVRArhRVjhbgEYfM1G0XpNfenKFNjhwAVVa2
   TFYgrlMipg9RkBTUML6muy7www0v4CNFpB3Yyw8yTtHephVY8VULFNUsM
   g==;
X-CSE-ConnectionGUID: kNvGZXrMTmO2Gb1jh7+Hvw==
X-CSE-MsgGUID: 5rvQM5uPS3+K7RvtGN/VBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="35492901"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="35492901"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 21:16:55 -0700
X-CSE-ConnectionGUID: 3HadcxlIT5e4+C8ETmcwKg==
X-CSE-MsgGUID: cBjAdWEJQrOr7F3LC3B9Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="66168390"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2024 21:16:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 21:16:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 21:16:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Sep 2024 21:16:54 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 21:16:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBuyeNZnnAHrR63kPk91d6O/M8DTgi9dctqz+haXaIZ7V9EK5lzh+eGbfyMM+LfpRP+m/e37OLvepsLEHabOt5poqCMNxJwsHxYG9kMbgihB43h80n22OfyaAtCxQXobSUtbJvntiHu0JaIp6sSz4yWjS16sIaUn0bh50uT5fEs9DMunt1iK3CdmH1H+DCVE7zrBNoro+HHZKX6J9JqhPZIRVWyqJpJSUIISG+QF/0axAijIZ85xOYtkWzFOOM6WYqE0/Ny6/zjuTOmcTw7gBf0i6hMmtslR2HsCDEXsDh6zKILZWddl+DvVZ+zfzAptTRSyyphyaGBirwmAN1cdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABhffNT1E115aGO4VwogZ3DeZ/KnzndCGtREJyOWyOY=;
 b=fSE90Oje2UX/2LqV9rDDdVOvhbThLGymVZV44iznHuR6Rk15rLUHbLS489A/P0aqA8eevEtboQvxHvnpnt69YXNFHfRORWu1jNLxPj8Rz1yZo3aAWe1t/ndwSrA+BLe8QrxmUoUkp/EN5alW6PzmuXD+qMu5adN3VQwU6z6BL46mZWmYsVdieMeRbHwQRa6ag+JhrD4GGGu+RSQNo+qNNB7b5dUEoaJE2KifaiGiMlTvO5jPvDBjCDPVxkSS9qwfcotHsHl03QDX3Ye+xJfsUOXWi865D6hhqkiVJ4usMTjaLEbasBJWVbu+PeqjcwrtjOqtGCvMRY+LADqk89NIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 04:16:52 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 04:16:52 +0000
Message-ID: <7b8f09b1-5e0a-48d8-8585-27e4a69ef75d@intel.com>
Date: Fri, 6 Sep 2024 12:21:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] iommu: Introduce a replace API for device pasid
To: Jason Gunthorpe <jgg@nvidia.com>, Vasant Hegde <vasant.hegde@amd.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20240628090557.50898-1-yi.l.liu@intel.com>
 <20240628090557.50898-2-yi.l.liu@intel.com>
 <BN9PR11MB5276B4AF6321A083C3C2D2648CAC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1a825f1b-be9d-4de1-948a-be0cce3175be@intel.com>
 <20240816130202.GB2032816@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240816130202.GB2032816@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f57dc0-db15-4add-078b-08dcce2abbf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2lRbkpYLzJtOVNwNEtsUWtEMldRTzZzaDRUd1MxbS92dmdvSVdkanVKOUEz?=
 =?utf-8?B?dVB3cnpyRXUxR3U5QmlwZkF0UXlqRVZTSzdPa0xVdEpURmVPYWsyOC9YOFYr?=
 =?utf-8?B?L1BHTCtPSTJ1WXhkYlRFUFQ2VWErU0ZRNmZwQkFnVm1OcDc1TVpoRDNLUmJV?=
 =?utf-8?B?R1lJYkxWN3JtTDFGbWNnQ0VGT0d5Y2RiaE1OZHhOVGVPTEFObS93VDhubjFn?=
 =?utf-8?B?ZWRvUSt5SlI4bzZpS1BlVS9yZiszY2NOS2psbXNDSFgvS2l3K2E5ZHZSdVBj?=
 =?utf-8?B?UU9maENLQ1FySExRZ3NCazllS2pPem5USUdwRCt1dTE2cExRRzZDdDRxWFhI?=
 =?utf-8?B?dVhpZ05QUDlwSzM1SmRJVnZNQ2h6ZmMrY2lIOUVDMEh6Sm5kOFFjbzRnYkgx?=
 =?utf-8?B?RUdCdHIyRWk5N1czSW45ckNHMkV1TDZhV1RxQk52N1lkamVCVklVR0poVVhw?=
 =?utf-8?B?QjZQaUY0MG1SZGRzYjJqTFk3aWd3cjVIWjk0UnJYdmh0aGoxQ2ZTck9RRmI4?=
 =?utf-8?B?UDlpOFJCeFhReUFkY0lXcldnSzNqc3hSNUdNeWI4bm90c1lwWHRJR2FPdVJE?=
 =?utf-8?B?UmJDOGdUVEQvQXNYTFhXNkpEVkt1YjA5M1pDZnpxWDFrQXorMXZ4eGtsMXVD?=
 =?utf-8?B?NWt1dGJJS2g4bXJObGNxSDVaZDRHc3NJT1JuaUhBcWlBZGVWYk5oY0FJa3F2?=
 =?utf-8?B?bW5SZ1J2SENnUG9CbmFPNlNuUVhlSTNlZm1xQTk0QkM4NzNaVDgyT091eDFN?=
 =?utf-8?B?LzQ4bHI3b0EwVDM5OElaYzllS3JuZVFPTDVtTWtuNUR5ZWZhSHR1aXFRZktl?=
 =?utf-8?B?dHBBbDdZTkhUNG1kQXBuMkRzeHdwUGxHeXJBdkhENVJEQUFMY05VUThtUlB4?=
 =?utf-8?B?Q05vYjhFNzczQmE2bVkxSUxUWlllQUtpV2FDaUxzTHRVZVgvemtMZVNnMVdp?=
 =?utf-8?B?NDBDaW14Um5SdmxlYm1KZlJrOWNlSHpqMDBESW5CRmcxaStGQ0M3dDlobHR3?=
 =?utf-8?B?R092SXpob09pRFd5V0NoL1JWR2s0UHFNZ0FEUDZ6VE13d2dCdklranRCa1Ez?=
 =?utf-8?B?Z205WXUxNjNGdSsrZktidFlEeXpvWTBqcmprSlZnK1hWczVsdGxPR0NuSEoy?=
 =?utf-8?B?cTM5WnFIbDVvVHBDb0xsQm5sTDhXNmV1aFRTY0djY0lxaWlCSGNjNW9LcmdP?=
 =?utf-8?B?L3NvcEV0ZitBRjVJWXh5NXo3OGl6NHBtVnNuWUNJZHdzV0VJL0dkYTR1VzN3?=
 =?utf-8?B?RlZKR1pleFdPR3NmYkhrWXlxZjU0Wmt6cW9LRzRwbDFUNTdkRXNNOGM4WHZs?=
 =?utf-8?B?cjFSZHY5azUva1VjYzhDZjJISmVlMUlKcjd6RStJK2ZTZEc2aDM2Z2hRbk4z?=
 =?utf-8?B?eUtNcDhIcVlVMlVHODZvb05zVjJPWG9nWVZoRzBvSU1NczYvL3V1cnNReUlj?=
 =?utf-8?B?d3ZJQ1VJTjJNT01jOTN5MnVTcHZ4WTlYemEwVERTdVhvMkN4QWFvcDZVNGpr?=
 =?utf-8?B?d3VqeW9CMmZ1dmVTa0pRNDhjZHhZTWZlTU5ZZGtJUFlDQmg4RFFVZnV4RFpO?=
 =?utf-8?B?ZGZTanIzV25URkFIWXgxL09MVW81RzNGRG0ydUJmTm00bFNldkNJa0NnYWNr?=
 =?utf-8?B?SklwZC9MUDlhSDNibUVZVXJsZ3N0UTlSN05NTCtXSW9KbFMydWRHbkdMSGMx?=
 =?utf-8?B?SlQ1S1JmWmZtYmJwbm8wMWNFRFpJRWNPM1kxSXZJTmdoS0t5NnNzckxqdFFt?=
 =?utf-8?B?MmNsLzJETm55WW45L1hkL1RLVkJucU5CSmNMV2VHOGNjZWJrVitsSGJ1N3ow?=
 =?utf-8?B?VHV5YWZrcXZwL21ueDc4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE92SlZNeXllRWxCajNKK21idStVQ05QY1lTOVgrbEhsd2NJTmlnRXVTRFNz?=
 =?utf-8?B?OTdPVjUwYW1aL0lOUDJIRVVybDl1OURwWDliQVNMKzBUZFRHUnUzRHNhQ3d1?=
 =?utf-8?B?L28vU1MweGNtWlBWaUhtT2NWMzV3Ymdsc05GN0I1NkpsY1JnRmxnbS82T0tZ?=
 =?utf-8?B?WnhkdS94Q1lJSFJoWTMxelZqWUkyTDhPdElJZCs4b2xYUWZIdm9RTUFsMmNT?=
 =?utf-8?B?UEFxT3dSV3c3V0JyZTFuaHFQUC9tVHNQQ2R2WFBYMTlrZGpoaWdWc0hhUmox?=
 =?utf-8?B?NHZqTTg1SGE0MWE0UXg5NnNwMUVtZlQyakswNnhwcm5Vc3k0RzRGOHBOWkkv?=
 =?utf-8?B?NUtTc01SVFhsaStCOFlDYjRkWUJOaWxCUHF1cUsvV2M4QXNLVmU0VGxTK2x2?=
 =?utf-8?B?UnpRckRTdktOQTdUa3pZWG54STBqYmdjOFRqMXN1V0s0bUE0S2xORExRRG5l?=
 =?utf-8?B?bUZuRE9rNXlKdTVLR2Y2REFRYm4vUU9mVWdNemNxb0Q3TmY5S1NVd1duUk5D?=
 =?utf-8?B?UFV5WkN3VnpXZ09ZeHpDd0VieGw0S2NvbzZZTVF6b0QxZzlubTN4U05OOU9p?=
 =?utf-8?B?U0Uyc1BCTTRqTExxcFlYNjZsN1d3MmFUbHRCejlPcTJ1ZkRUM2xIN3dIbXRj?=
 =?utf-8?B?YnFFT1Jvazk5QTUrVnJtV1phU1hJckxwTW9Vclp0d0pEOEhUVHAyNytVUWho?=
 =?utf-8?B?MEJybDgvT2RMTHJxd1hTU3NmRWcwNHdWTHVqQiszYkdjcFNERTBqT2NsY0R0?=
 =?utf-8?B?M2ppaDRnUXh4UXFGamxQOFIxeVNaQk5QNXp3RTcydHNScU1tRFM5Y1NmMklt?=
 =?utf-8?B?SnFTYlRWYXpvdkg0SHJ4QUN3MUNNVGJLZ1cxUEVGM2RpODRzZWVvQzZFODRS?=
 =?utf-8?B?YXFxWDNJNk42Tk9NMjVaZnhwWFNJYzhQcXN0S0w5RVp5U0VDUTZSVnhQZXhN?=
 =?utf-8?B?cGxQa3BKY01EZndFa1ZYdjV4WDhWVkx6aTUrOXpjYlJTYlBQUmUyUHh1cVpM?=
 =?utf-8?B?VWZYa0ZXUWQ2VFd4T3B3ZFNlZ2pBbEVpeExKL2tUWDFTOUtTQmlla0wyNUpY?=
 =?utf-8?B?RHNpbUVob3ZXekYwVUdxUnJyVUx0ckpQazJVTDNRLzMzdmtJaFFBNEJwNHAw?=
 =?utf-8?B?MHY1K3ZuQzJQU3pjOVdWa3pyVm83a3lyc3VJRlRlUHNaMzBuTkMzSDNsQmJW?=
 =?utf-8?B?aXlpU1BoaVY0bGlsczJYcW5zWmJkVXVrc05WbUdUc1hRcHluYW1TWll0TjNZ?=
 =?utf-8?B?d1M3d21CUXhaTGlEMzNkR2ZkbEozWXhOdzdPZEJGZXJjeWdPaFp3dzBxenJq?=
 =?utf-8?B?bTBGVHNyVkJDbFFkblhKRkpnTkhjMExuaGRvOElUZk9nZWlTcDE2N2NSODhS?=
 =?utf-8?B?V2pyOUpkYUhkZUNSb0E3c3ZnbVlKaHI3NTVUNkEvNUNaSkQrQTVuNXlHamtS?=
 =?utf-8?B?ZkZZZ1B0WXdpeEFpcENTWGtUU3FsV2xYaE0zL3E3QjZZbklOL05PdmdxYk9n?=
 =?utf-8?B?V0hMcWlmV3FWdXBzd1hyNjc3K1ZzVy9LV1pxTXhUdWN4cmtqRXYrU25CZUZ3?=
 =?utf-8?B?WE93ZkJOdkEvSG1NZFFjd1VHSlNNcHdOWHl0QXYycnp0ekZkS1VIRWdQTkU3?=
 =?utf-8?B?VUJGZUhWR1hSWU9TWnpscmlTWXdjODNZZFNwQjBXNVcydFV6NFBNcGVEamRB?=
 =?utf-8?B?WVhDV2NuNXp4ZEJEcnk3S3JrTmY2WnBRSDlCK0NINFJjNjEvL3ptUm1INHVJ?=
 =?utf-8?B?SE5YeG44RVRja3l1Znh0K1kyd1NPOWFWQmk3VUQ5ODdzYUx4bVRicWVNdmhx?=
 =?utf-8?B?ZzVOWGtMRG9LZTUyQnpCeU0rTVdSOVptc1lXRDVrcENmR1JSU2V2dTZIdFBY?=
 =?utf-8?B?SUNvMlduSUduRGlGSTJkNENkOFY1WlBiRmhHRWJHWkdCdm1vVGE2ejJmOEVs?=
 =?utf-8?B?bDIvWnJNVnRLdUtNaElxeE9JTXo5UU1hOElvWW5UY0FOb0FGOEhFMFJYRnBw?=
 =?utf-8?B?R2M0bnNxRTlFM2YzOWVvNVZ3Z1QrSTNkY05hR0p6cVJPR09Kdk9PeGRHeFlk?=
 =?utf-8?B?a3k1dUpGVzBGZUNSaUpVekNhNE9RbSt5RHNobS9FSjNpcFdOYU1CMGhBS3Ix?=
 =?utf-8?Q?P4dJm9yB1lLHGBNgV3FrNmKrF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f57dc0-db15-4add-078b-08dcce2abbf4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 04:16:51.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeY3bRpYbqi/68XK7+iFioGJlKr/VsOvDMwRLhOQMfERl06E4sC1462Q8cLFGfx7c7cZVo8sddW+8o4Ka5PRTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4893
X-OriginatorOrg: intel.com

On 2024/8/16 21:02, Jason Gunthorpe wrote:
> On Fri, Aug 16, 2024 at 05:43:18PM +0800, Yi Liu wrote:
>> On 2024/7/18 16:27, Tian, Kevin wrote:
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Sent: Friday, June 28, 2024 5:06 PM
>>>>
>>>> @@ -3289,7 +3290,20 @@ static int __iommu_set_group_pasid(struct
>>>> iommu_domain *domain,
>>>>
>>>>    		if (device == last_gdev)
>>>>    			break;
>>>> -		ops->remove_dev_pasid(device->dev, pasid, domain);
>>>> +		/* If no old domain, undo the succeeded devices/pasid */
>>>> +		if (!old) {
>>>> +			ops->remove_dev_pasid(device->dev, pasid, domain);
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		/*
>>>> +		 * Rollback the succeeded devices/pasid to the old domain.
>>>> +		 * And it is a driver bug to fail attaching with a previously
>>>> +		 * good domain.
>>>> +		 */
>>>> +		if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
>>>> +						    pasid, domain)))
>>>> +			ops->remove_dev_pasid(device->dev, pasid, domain);
>>>
>>> I wonder whether @remove_dev_pasid() can be replaced by having
>>> blocking_domain support @set_dev_pasid?
>>
>> how about your thought, @Jason?
> 
> I think we talked about doing that once before, I forget why it was
> not done. Maybe there was an issue?
> 
> But it seems worth trying.

Since remove_dev_pasid() does not return a result, so caller does not
need to check the result of it. If we want to replace it with the
blocked_domain->ops->set_dev_pasid(), shall we enforce that the
set_dev_pasid() op of blocked_domain to be always success. Is it?
Otherwise, this is not an apple-to-apple replacement.

> I would like to see set_dev_pasid pass in the old domain first:
> 
> 	int (*set_dev_pasid)(struct iommu_domain *new_domain,
>                               struct iommu_domain *old_domain,
>                               struct device *dev,
> 			     ioasid_t pasid);
> 
> Replace includes the old_domain as an argument and it is necessary
> information..

sure. Intel iommu driver should be able to support it as well. While
AMD iommu driver does no have the blocking domain stuff yet. Vasant
may keep me honest.

> A quick try on SMMUv3 seems reasonable:
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9bc50bded5af72..f512bfe5cd202c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2931,13 +2931,12 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>          return ret;
>   }
>   
> -static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
> -                                     struct iommu_domain *domain)
> +static void arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
> +                                           struct iommu_domain *old_domain,
> +                                           struct device *dev, ioasid_t pasid)
>   {
>          struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> -       struct arm_smmu_domain *smmu_domain;
> -
> -       smmu_domain = to_smmu_domain(domain);
> +       struct arm_smmu_domain *smmu_domain = to_smmu_domain(old_domain);
>   
>          mutex_lock(&arm_smmu_asid_lock);
>          arm_smmu_clear_cd(master, pasid);
> @@ -3039,6 +3038,7 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
>   
>   static const struct iommu_domain_ops arm_smmu_blocked_ops = {
>          .attach_dev = arm_smmu_attach_dev_blocked,
> +       .set_dev_pasid = arm_smmu_blocked_set_dev_pasid,
>   };
>   
>   static struct iommu_domain arm_smmu_blocked_domain = {
> @@ -3487,7 +3487,6 @@ static struct iommu_ops arm_smmu_ops = {
>          .device_group           = arm_smmu_device_group,
>          .of_xlate               = arm_smmu_of_xlate,
>          .get_resv_regions       = arm_smmu_get_resv_regions,
> -       .remove_dev_pasid       = arm_smmu_remove_dev_pasid,
>          .dev_enable_feat        = arm_smmu_dev_enable_feature,
>          .dev_disable_feat       = arm_smmu_dev_disable_feature,
>          .page_response          = arm_smmu_page_response,
> 
> Jason
> 

-- 
Regards,
Yi Liu

