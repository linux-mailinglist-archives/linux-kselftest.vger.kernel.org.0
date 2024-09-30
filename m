Return-Path: <linux-kselftest+bounces-18607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D8C989F83
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0861C224F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC2C18A930;
	Mon, 30 Sep 2024 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpbRdOkw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5118A926
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692567; cv=fail; b=K2JDcwyeXfiPUxsa/sRk5/8NuOQ8HyYrLo1DNJhnn3ovLdx/5lWHFUBhz10N7/vrCK7CoCW81ajrt1gWAlzsqe2eQGrx5fT/FBfu0I3jUzUMRrIKkuE61CeXZcB3maTro7f0EX2B+kiGjvlep4m0WOFnBdrPj7sbX6R2mtBMjrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692567; c=relaxed/simple;
	bh=V1CKut326fb866JCPnR0AcxdUeLpGNsvih0dez0xn5Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xv03nL1XEAtvGPzNJLnA6/sJRn+A1xtNpEYOZewBC8Tf9+VNEfBaxJhGBFDrliB3ojr1JRlI7DcrO/E56mxTFIhOFGeL+7G8YP3clN+QZ4isPIHY8bQr6jSIw4xPnViuGAjjVw/VhYwROpQ7ItO4OWKWW37H5GQUdSIRit4aTJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QpbRdOkw; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727692565; x=1759228565;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V1CKut326fb866JCPnR0AcxdUeLpGNsvih0dez0xn5Y=;
  b=QpbRdOkwt6vZPw/y5tr7X4afxK/Qig7HfC5wGRVw9BfHWJrp+pgHhKaa
   OESWOMpmj7eEqNrQpehjGbCdrewBFq9WSvEIMRUY3BVVqpmxmZjAccMWj
   V/njWNZoX/tnYmBEf/bvEyaR5GCFdEH2Cu7F5L+zU+UA8snzlLeJNJ6BQ
   +lSr0wdZS9EtZDdKR2ZyZl1nnVkk8FDs0HJoXjnKWRuvX7r9UcagLqKSS
   YBF1g9LoeHMDGxvCXfOolpHAncvsr0ynyfglrb5cA3Nc1MajArw8Cyf/E
   AOsHjd6xM5fzZo9sV20GZFYG3zo5diCG+xqUOXw5h2ShtvD5cGFMEgrA+
   Q==;
X-CSE-ConnectionGUID: UYrQ5l19Q1yO5lLOvXA0QA==
X-CSE-MsgGUID: N1QowmIHSGOEuRNAISOrGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26947771"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26947771"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 03:36:05 -0700
X-CSE-ConnectionGUID: cf3tAETnQAWr77TV2T3ybA==
X-CSE-MsgGUID: 6rmv7j5QRJGPlic1vDXpXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="96585674"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 03:36:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 03:36:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 03:36:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 03:36:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 03:36:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUhTUpVehoF0dnCEmTeH3HL83qXR9oRpV2mFdWiLbUcjGZZBbBwpmEXcaiIfo+qsl7J1MhMc78y+mU2JBcDP9xW6NwLVsDgvkK0j0CZA99BrZPmPiuHHZ0q3xOprJWIk9owAMDXWK/R+q71dTpoMuqKBMt9ItqdErboyLTF/qmlrPG3IB12vsx6udRsRl+GNGlHaLFJnKh1qdeDDw7/gPcJIqqJHbzFlW761MrFSa+HAiSlHYBRhM0u0cx44GSMIgTCeHewRSQ0Z0g8wjwSdLuh5Vuh0rSFCw+c+mAucn2xyzWv3TgtEo/oBwuBTvvDYQFBOY60s6uDAdAKZyJIXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9RB6+JOB9HyG3pCaeypxBfv9wC7pqivOI2VDPnZXiA=;
 b=R0pp7DyKTcWF698n3BoZB+ICg3dyQJzKV4BW6PNPKup6ODOVe6/d2PRwY2PeuBOvyQTLXkTN+NTu+fF6skaDpwYmLk2dq3xoneaMwNNoRlVboRNvR+hGylLTkeVF1Ap6VxSxSwc2N5dC8aKu0xJQtRwyzWleuFhGlTfYRkrftMv5EhCiXVHCDUAXNeZsu6OftRWel/2cHicc0/hBFAJyfHfJmXDR20tfeAyojVR0L4Zd4CWYMparGp+F33AUQBEPM+qSqOWWS7KtS0674eJVicRW6ieJlrl2l/VOc4QWKRtFDdXkpJXmgfx+Nv9/BIcOKYG5Ql3V7159M07RxfDxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV8PR11MB8533.namprd11.prod.outlook.com (2603:10b6:408:1e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 10:36:01 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 10:36:01 +0000
Message-ID: <d8fa1e63-6662-4939-b380-5ae64a23d58e@intel.com>
Date: Mon, 30 Sep 2024 18:40:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] iommufd: Move the iommufd_handle helpers to
 iommufd_private.h
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
References: <20240912131255.13305-1-yi.l.liu@intel.com>
 <20240912131255.13305-4-yi.l.liu@intel.com>
 <BN9PR11MB527657FC837DEE418875D0E98C762@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527657FC837DEE418875D0E98C762@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV8PR11MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ce318f-cd55-46bf-4a1a-08dce13badc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUFuQVBaMkFxN2F0TENTdURYTlp1d3cyeWUrL2VUeU03UUk0enRsK2JiSnN4?=
 =?utf-8?B?emlIMklubzNEL04zY3hKRUJvbjdhRXR5Z0JLbGlWMEVyU0xpUW9LcG9rNlRC?=
 =?utf-8?B?emlhZEVuMmh4MDdKVGVuczRIRGlmVE9kT012UERJay9VWkdlWFFzd3RCK1Rv?=
 =?utf-8?B?Y2hIM05TanUrOGdUeitvR3dvSlVaNWdST0RURTRiM3hBNTMrVmtaU3U4cEdI?=
 =?utf-8?B?OFRwc3NFWVJ3b2pIdUFJcHRIQkdRcE5WTXR6QkthOFRnV2RvenkyL2dKSGx5?=
 =?utf-8?B?Mms5dUhYMHlld1cwUFh3OWRHR0x4WWUyK1VkblQwZitrOXFJZ2V6MDJnUmdD?=
 =?utf-8?B?dzJHU2VUZm5RRmhHTU9CZDh2ZzUzekpNS2VnVnBEbElHSEpQc3Q4c0JlMDNr?=
 =?utf-8?B?WFpwbFlTMkRGZUtpU1QzK1Nwcm5sTEZsZWJZRG9DeUJibFdMTVFPRE5TRlRq?=
 =?utf-8?B?SzN2ZFpBNHFoYWdhZVZkQ1RONFZneTU1L2ZMaVBHMW0veWt6NGQ5MW50QjZl?=
 =?utf-8?B?R1kvUjF2K05PeW41aXhUU1dqSHR6UmVWbXJKNys2U0tRTlZFSWpEbDFCZFdr?=
 =?utf-8?B?NVdMMUxFTGdJUUZzV1pteXJUTkpvTWljZEV0SW5oczdDTldIS211cmdqeFFs?=
 =?utf-8?B?cEE2UUluMDRKdGRBQ2QvY0xwemoyMkIwZVZUdTdTNGVjUzlvKy9jd1hySGJ1?=
 =?utf-8?B?RXpacUdic3lRUnVsNndOaEV6c2xERFdGZjRrMU9Sbkh3RmxDS240OHZiRGRK?=
 =?utf-8?B?c0Q2MXdSa3grRjBuMlF2YmVOaVY1UGZWYUUranZyaHp2ZkZtcEhBNERzSlc0?=
 =?utf-8?B?N3lOM210Vk93c09OYkZnbG1mL2NjNHhFUEs5NVJIVnFEQzhiRWxCTkpadXJC?=
 =?utf-8?B?TFpIUFpEeHBXb09iMjN5U3FQVXkxeDVIL1JuTE0rS2REZXBCaUxMZ2F3dVZ1?=
 =?utf-8?B?UGxRbHhmTnhaV1NaaFNLY1c1VnpJZVk0TU5yVURFZFdTWlp3dVF1WGRBQU81?=
 =?utf-8?B?VCtNK0M0TmQwUUVhTEFvNk9aRWJUZGVSOE1hL3BJdFFCM28vdFArOUhGTmFx?=
 =?utf-8?B?bEVKa0NOckJSbGVqZlRDSURHMTRYeEtJS2UwWXh0RGFSK1BuZCtQZUUrc2kr?=
 =?utf-8?B?d2M5WkxrY2dwZHUybWJLM09EdVQ1cFE5NUxFb09MVzdPTnB5azk2bCtEV1hC?=
 =?utf-8?B?VXMxekRHQUtyY3ZvUmJpbFpTOHloTjhoZkNJWk9CdXNna2llMTQrSE9zU2ZS?=
 =?utf-8?B?V09lYkh4azVFUlp6SFUyQzQ0MjdYRWZnbHdYQnZkTHJmYlpEZkJzekVEdEJ5?=
 =?utf-8?B?UTc2RHN1Q2hjVTArWUZjc3F2bWgvL3lydzdxcDVuTXFFeXYveXg4TTU3ZjIz?=
 =?utf-8?B?bEMwZUpkNWlOQ2F2TUxhR0kyV3dPTFZkWGsvS1d0NVdoSE1tQ1lMMWQyQlU3?=
 =?utf-8?B?MC9VeExvOEp0eUVwb3VKcFBHUUl4eEprOGRjcHVuL2czaDZZMTBzRXJGM3VI?=
 =?utf-8?B?Sy8zRU9XbHRqWEFEd2ttVEJsclhMdkpHdHdZZGRDeEJaS1kyTENEM29FM1Bz?=
 =?utf-8?B?Q0FIekE4eGNiMlhlSlhoek9YN2tMdyt1cWJuVjF2c0toUThPN3d5RUV5Z2ZT?=
 =?utf-8?B?dHRURUN5TmRmd2I5QmtCN1RDVHl5SWhTZGZwK3NvdlV1ZHRyWnJ3TDNvdXBo?=
 =?utf-8?B?L3FrU1RRdGkvSFV6aUxNL0VOVVYwWkp2R0l2ajJGTTgzKzMzMW4rVGtRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG9LM1QwWmpLK1BaZERQRkl1dTFlWFhUakR4ZGplcjFPc2Y3MWJZWW1qUHJU?=
 =?utf-8?B?YVdGTURxaFVPNG9LbEVyRXN1NVJHdEl5WStYUHhyNUZUR0dPb3NXQUZRdFRu?=
 =?utf-8?B?Y3BvZjZxN2d3U2VtWm44Q0YraEVNZGVoR2dCUmIwSTlQak1OQ0tqcHdEc3or?=
 =?utf-8?B?bGNwc2Y0QTE0QjRhUDN0KzE4K1dPdHN3SG8rdDV3MlJycEkzUmZkdW9QbCsv?=
 =?utf-8?B?SVdkNU14K3RWdm1ZQkgxbm16SGhCaEZLSnVDZFRVQ2h6NEt6UHFEMjBSVUg3?=
 =?utf-8?B?QVRBd0wweStkWUNTTlpXeG5EYk9XWUxtNmFFajR3L01xUHZDTkdRUHVqMnoz?=
 =?utf-8?B?T203c0QvUzJadHEreFdoWkZhKzRadHgzeU0xQnlFcWpjS1JnUXFlWXlvYmMx?=
 =?utf-8?B?ME5ZaktmeTJMUURnUHZBd2ZaOWZKSElIanFuaFEvMTQyWEhnSCtTSHpnTFRN?=
 =?utf-8?B?UG5VZThxb01oOGxKMnYxZDZNaTkzeno2ZlN0RjhXQnk2MDVqemV0MjVwbkFk?=
 =?utf-8?B?bTVEZnkzVTk5blp3RCtBNjJYUnNCRUswbUl2Z09leXBCa0x4Ym1wZ053a1JH?=
 =?utf-8?B?dTc5YnQyTXM5dm1rQ05wTEFtVjFIeWpDZHVQN2NXUUxQS0VxUGltWENtNUxZ?=
 =?utf-8?B?V2Jaa1Q1WU9yQ0pDcWlDRW5FelBleTlBRFhVVDZSTWxhVTh3SExmVDc1Rnpl?=
 =?utf-8?B?VXZ3cldjSlUyT3J1VlRsTUxsQmFWY050RWd1N0F5ZTR0clFMTHF3Y3Q2OXlJ?=
 =?utf-8?B?R0llMW1WcDJVMzJHdTZYWEdBVkdSL3lacFFTZTc3ejJsSHp1LzR2OUg3YTVt?=
 =?utf-8?B?U2Foc2V4MDI0MnZUMTlOTDJWakZnTDFIMUJySnVSYzFwelZ2Q3JwdzZUWTJq?=
 =?utf-8?B?S3o0THhmRVBqZzJJYkppVFBUbUFLVEd0b3BpQVl1UkZ6NmVDT0svWXoyTnNO?=
 =?utf-8?B?aWs4aXlsNGdEZTBJeGFZZm5Yb3V4aVdYY0Y2ekJCcUNPT1JUNU9aMmNYNFVs?=
 =?utf-8?B?R2Z4cURVTzlpa0xBZ1p6bFNhUTgrV2FBT1VodnhxaE5tczFEQ1h1TnBFWG43?=
 =?utf-8?B?cU5WTEs5VUV1WENrSk5EVHVlK2EwdFV0Z0VxWkVIODZjMjJMdnJWa2JoRXNC?=
 =?utf-8?B?bWd6NnFDaUdKZUVPUzVsa3g5Vkx6U1p4bkVTVnZhZktTWEFNNDNjY20rZUZT?=
 =?utf-8?B?MmpwSm1SeFFHU0NETFoxVkVWUjRKVU9JbDc1ZTFpSGFod1YvS2Zrc1FETkt3?=
 =?utf-8?B?N0NoSkg3YjRpVXNyY3pKSzc5UDFrQ1lqYlc4OGRPajlkZ3dCMzQwNnNqaXBI?=
 =?utf-8?B?YVltZHRtTElwTGNTRGJhUmVlSWVhQ0JwbTBiOWs0Z0ZpZnhkcFNxaUJ4UkNi?=
 =?utf-8?B?OGZyNWdjNk1hVXVTN01sWEdGcGxsTGpmM3NNTGJZUHlsMXh4RExDTzNSNXFy?=
 =?utf-8?B?d2R1VnB5bWo0RWdaTEY0d1hRNVF5WkwydDlCUjdad2s1aCt1Z0MwdjlvK1hL?=
 =?utf-8?B?OTR4RUJ5R08vU0MyNjNXZmpOL1lCQ1hpWWpuVzNMclZrQm5OcTg0RThzRGpy?=
 =?utf-8?B?VmFUUWVoaWEyRnVrckg3dXJTVGl5dytkZVQ0WW5EeUhzTXMxM3p6WStxZjkx?=
 =?utf-8?B?WVFONGhJUWw3emFjVGtZMkpYc1o2UktaZHM0S25yc050bGZXb0RtWmlTV1lD?=
 =?utf-8?B?N1gvQjhKd284TEE0VG1Yb0N3K2ZiNmprN3p3ZS9BWE5wYkFaamxqOW5mTDRG?=
 =?utf-8?B?MnU5cWh6Q1lYb3M1KzkrTEN1bTRpdENDZ1htQU1sU0pQNkFqVEJrdjdkWlp2?=
 =?utf-8?B?bk9GNWpYSldMelhaa29FaXk0SW1HWnJIMVBCbk1pNGZncHpWVExnOUVPcWI3?=
 =?utf-8?B?KzZxNFNTc29nOGlWYzR3RDlEZ1ZKdVFsam5xRFA3MFc4RmJ5N0djNXFvMTNX?=
 =?utf-8?B?TFVUaDJMdCtwWHYzQmRRdTdVVFIySjJFNW9tdyt1MGUyY1c1QjRmTzVMRXVJ?=
 =?utf-8?B?dTdKaWgxN0dnM016ZDI2TFNwcWRZZTFtSmRJSTR0T3M2L01LM0ZqSTVpMDBQ?=
 =?utf-8?B?MGVGUGtnaHppenZxNXNiWTVKQTVtdG4rRjQ1NkpoN2FDRG8zbVVFdkt3RzZM?=
 =?utf-8?Q?13FgpXq/u+ahqWbd+irxrOdfK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ce318f-cd55-46bf-4a1a-08dce13badc5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 10:36:01.7316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Y70tlcc4rmAwFC3Rdpv7VZknq5dw3liXOFAvFduPIX53KlRwBJFdbafrVi7nhZRdvIhy/f0EkksXLLBrh2aWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8533
X-OriginatorOrg: intel.com

On 2024/9/30 15:44, Tian, Kevin wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>> Sent: Thursday, September 12, 2024 9:13 PM
>>
>> iommufd plans to always pass in an iommu_attach_handle to the iommu
>> core, so it's no longer fault specific, hence move the helpers out
>> of the fault.c
> 
> again please put the reason for why iommufd plans to do so.

how about the below?

The iommu_attach_handle tracks the attached domains in the
group->pasid_array, it is optional so far. But to support the
domain replacement for a pasid, it needs to get the attached
domain, so making iommufd always pass a handle is a choice.
Before that, we would need to decouple the handle allocation
and fault code as non-fault capable hwpt attach would also
allocate handle.

>> --- a/drivers/iommu/iommufd/iommufd_private.h
>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>> @@ -458,6 +458,63 @@ struct iommufd_attach_handle {
>>   /* Convert an iommu attach handle to iommufd handle. */
>>   #define to_iommufd_handle(hdl)	container_of(hdl, struct
>> iommufd_attach_handle, handle)
>>
>> +static inline struct iommufd_attach_handle *
>> +iommufd_device_get_attach_handle(struct iommufd_device *idev)
>> +{
>> +	struct iommu_attach_handle *handle;
>> +
>> +	handle = iommu_attach_handle_get(idev->igroup->group,
>> IOMMU_NO_PASID, 0);
>> +	if (IS_ERR(handle))
>> +		return NULL;
>> +
>> +	return to_iommufd_handle(handle);
>> +}
>> +
>> +static inline int iommufd_dev_attach_handle(struct
>> iommufd_hw_pagetable *hwpt,
>> +					    struct iommufd_device *idev)
>> +{
>> +	struct iommufd_attach_handle *handle;
>> +	int ret;
>> +
>> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>> +	if (!handle)
>> +		return -ENOMEM;
>> +
>> +	handle->idev = idev;
>> +	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup-
>>> group,
>> +					&handle->handle);
>> +	if (ret)
>> +		kfree(handle);
>> +
>> +	return ret;
>> +}
>> +
>> +/* Caller to free the old iommufd_attach_handle */
>> +static inline struct iommufd_attach_handle *
>> +iommufd_dev_replace_handle(struct iommufd_device *idev,
>> +			   struct iommufd_hw_pagetable *hwpt,
>> +			   struct iommufd_hw_pagetable *old)
>> +{
>> +	struct iommufd_attach_handle *handle, *curr;
>> +	int ret;
>> +
>> +	curr = iommufd_device_get_attach_handle(idev);
>> +
>> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>> +	if (!handle)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	handle->idev = idev;
>> +	ret = iommu_replace_group_handle(idev->igroup->group,
>> +					 hwpt->domain, &handle->handle);
>> +	if (ret) {
>> +		kfree(handle);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return curr;
>> +}
>> +
> 
> why putting them in header file instead of C file?

put it in device.c is also fine. :) but not in the fault.c as the non
fault path also needs to use handle.

-- 
Regards,
Yi Liu

