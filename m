Return-Path: <linux-kselftest+bounces-17354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD696E98C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 07:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66ED01C230F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 05:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC5B13C670;
	Fri,  6 Sep 2024 05:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yk5wJs4/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580113BACB;
	Fri,  6 Sep 2024 05:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725602024; cv=fail; b=agVrkikpwM2cl3coNVYPALT1WFg4XAu2gfGcSuxpwTAHhkWngRneiUs13FPosVHCTXFyJ7BSE1jSO0vDJOgL2v+RdztMQ4islfHn5vbCWQzyV8e7dUyhScAVagTZmIDmQBXIPMeJ0/G+WuE5YZsOu3zDi+IphY67z4se1oXBgu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725602024; c=relaxed/simple;
	bh=yjd8xpliB068mWXPHJtImdvQyaZMKBNCAjQSZpdceR0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YtvLAHY6+gxXQyGJ5KalAIjBsNnfYt88sGFlenKqWtAY2fe0A8dAnpeitRDXWjGALMrC3/eggWVC95opCVC9VuBRfGvxyknkrOmmt9/T9qj3p2cqJS7UXlJrqgq/dqlYyQldqXF7C+l8eCs/6azsG+011I3Qa9oA9x7km1g/IR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yk5wJs4/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725602022; x=1757138022;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yjd8xpliB068mWXPHJtImdvQyaZMKBNCAjQSZpdceR0=;
  b=Yk5wJs4/CNYGMc9q+brPFOoDKylRcvSclWr2xw5LYYfQDlLTqW5lTxVT
   V/UbsUJGhMA/1YfgfF/cqyAlb97svwHBw2K+DkFfHQmnOzIVUMzEzYnX+
   gQ52wBcqbLvkHs7ZNkjozGGrOAXKw/vvW6cKuFfIMu6FTygnnSqVcEcnb
   Tkbn2GwiB/frfTwKVSF0m1n8TlAvFfu05+h8qjVwzg3BSKXxdveJW6X7Z
   fKZnBDeGH/x9vpBbaHLhzH9kU9aL+5avppYzKQasW0ngKLYx9fAQNWXo2
   5Y9ScebAHvL1tqnEiWi5VsNOc7ssFLe+uvqNROJU/D3s0Cm3gAfT/ZOQM
   A==;
X-CSE-ConnectionGUID: 65E+E2oPQq2glUznvWVNNw==
X-CSE-MsgGUID: RwddMBraR/qlrvHVfeQCeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24462184"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="24462184"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 22:53:42 -0700
X-CSE-ConnectionGUID: nOfdYybmRpCFHLzxTnNApQ==
X-CSE-MsgGUID: GspPgvTvRcem5q3Jyes9jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="70278229"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2024 22:53:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 22:53:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Sep 2024 22:53:40 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 22:53:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSsgpCLWB1DQNGu8SVe4EZW4JBr4IG1GXgT8hk5SqxUqKAS8IWdLOLYbpCorq3X/QrzUVvaTXxEn7mVH/vlzF/jaEypzLmTc8/u4tVkc5l0EcGmXo5Zz7hfkwBsXbbxbaoGVxis9myZCtygDd6VMFT8DeTMGZlb+21E7MIQtcyg747Nd06/Nu/czr9x6U/L1jPTrchZjaGwUFa7z87fqA4vHGwn6TGSTDtx/9k+vl37KqqEcS51yYvmazQW4qN+4dYPW9oa3dHCinhWmmYvMhwTQrf7ww9O9vR+/1a1Oydb6R4jSf6/XEX+qpL8ThDECHhQWg1LqDSsaXgqXlEJ4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoIa08ldjBLg6kk4wnkxHhoyxm9UoWAyNvWxvjuCPg0=;
 b=yIKSofkWcqB6NCo+6ofguFhNfcyqIsW+yuOSxMjGLSRXMTUOluMm5RqV/TyDRpnmWyR1kXtWi8c4dPxo4tUhnTjzq0jLTcr6GILT2dUgqVDG/yQieshHzICKK9im/BaMdGfBiTqmqC2OO4/QXajJCMEbViEAh2+Lb3mmAghUa1vubt1JAVvGtbWHy9LIIOPRN04J05WbJ3DaK3e/+enouWAyAqZ17E3ShOVQW5Vh3PfVswadg8JL3IGBLhxLKoZNL/0xXHucGp1m5XPcFndyMKwD14CVGH4MLenP19MBwVANXOmqRUdL7f/w8zOsyVYgLpofRiuO4+UnohuITq0J8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6288.namprd11.prod.outlook.com (2603:10b6:8:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 05:53:33 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 05:53:33 +0000
Message-ID: <6871e983-ae3a-42c8-ac63-570ba422df7e@intel.com>
Date: Fri, 6 Sep 2024 13:57:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] iommu: Introduce a replace API for device pasid
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Vasant Hegde <vasant.hegde@amd.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
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
 <7b8f09b1-5e0a-48d8-8585-27e4a69ef75d@intel.com>
 <456e9b67-aa20-4259-b8e1-9f20d4fa03af@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <456e9b67-aa20-4259-b8e1-9f20d4fa03af@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd0361e-6a4f-4a4b-2685-08dcce383ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTNDTnZ0K0VmT0h6RWViU0N3cVBnbVIxODU1OVFDR1JaTFhWV2NXQ3BLWTl6?=
 =?utf-8?B?Wjcyam5RK3dDOVJ6RkVqMWk3R1MyRVlWN0JPOERSL2NNVm1lN3pkVG55OFJY?=
 =?utf-8?B?dWJYSklRZXIyc2QxQ1hFN0dwTk5HNHlSRzI3aStUTEpDZjZDUFZuME1JL1I3?=
 =?utf-8?B?Nm1wNWFuZHJYUGVsU2FRSDhCT2FxcEhKWFhrM3E4eHVuYllHSWM2L1dpemUv?=
 =?utf-8?B?TmIxVHZyZW94WmduWDlLbTZDejUyZEJDOVhqQjVwSEVwMG1RUnNaMnZZMUZE?=
 =?utf-8?B?RExxMkVCc2NKRlRsRjFvSmYvdEV4S2hyUGhSb20wS2d2SEJkTXBxSmxVU3FJ?=
 =?utf-8?B?RDNHK0R0dkJTT0JVWGlzQ3BXM05PR0YvS0s3MElXdS9LeHZEa21XUEZpdEty?=
 =?utf-8?B?UlZvSkZ2MlZNQ044NStHb0JQOUdlaXlLTzd0L2JpcWRESUplVkhkaDhINVFT?=
 =?utf-8?B?RWppbHloaUJBenFUMVp2T2E3clpJMGNTUStUS3RYcmh0c2g5SkxsbkxIK2Va?=
 =?utf-8?B?MzFFY21DUlNvV2h4ZHV4VGczUWJLNmt0NEIxbDc0dVh1WW12WXloRmdpTk1s?=
 =?utf-8?B?K2hMamNPRXgwS1U2bFVDTFVOYUFHN2tDMEd1RysreVFZK09QQVJ3d1QyT3NK?=
 =?utf-8?B?MWF2YU9hVVdyZTdJQlRMbnBIaGZUWC9QNU0rbzdjT08zU09TcVRST2l3Sjc3?=
 =?utf-8?B?TGY4RXBwaVpmS0xKS3RUaW1WczFWQTZGallUZVBvUVZVak1ZNVdQbURQK1g3?=
 =?utf-8?B?VlNkelpHZnJiejhSVUllZkh3a2dSdEhaTjlPbWlzanhVNWcvemNzU0JRdXQy?=
 =?utf-8?B?a0ZkTUUxN3lPbU54eTAzbCtQWUpOcXdRR0lPL1loVDVOaHdRaWVpZTl3L0J0?=
 =?utf-8?B?SVFGM2d0L0VIWE0yT0JxMGZ5bHdZSFlOb2RyNnFydm85a0Vtdk1ucG5vUytM?=
 =?utf-8?B?RmZuc2M5b3AwMmVldC9sU2t2cDlvNUk5UzRTd0t1dnlpcXd0MVFuTi9zZzhn?=
 =?utf-8?B?NUZUQXJzMlhFWVRGbkdFb3F6Y0RzL2JhaDNRelVHWGVINXJPOVRwYWdLSzV6?=
 =?utf-8?B?bjJsbGVTY0NsWmp5NkxDWjBMdW9CQmgvMGZQSXF4bWxKckFreXRIZllxS1pj?=
 =?utf-8?B?eWQ4K1BlMk5GdUNGc2p3ckVzSjY0NlIwakcrWUczSGtUVFFyWE5aNDVQT0JW?=
 =?utf-8?B?MjFWLy9qb2k5YnYva1JxRFprK29rTUF3VGRRM0pQejVLVm9kK1FmbXRoclRW?=
 =?utf-8?B?YUEyWGE1S3dXQnl5aWVaQndQWC9qOXAwM055K05KT1BNZ3IwdlUvYkRmKzJZ?=
 =?utf-8?B?NG1EZDN0aTVyNDhtdmVlSnRiVlpXRWx4UHlMZEgyL25qTGZJRzlHcVhlUTVt?=
 =?utf-8?B?eDRLd05KcGpoZUw3Q1E2c0NUYVhtWFF2eTJJZ2dzTGZ5aTlzNzVEK0RoOU1X?=
 =?utf-8?B?a0JKVk9lMmg5U0JkTnBURy9NWEtvU3QvNnVIWUNLMkJ5N2M2WDVTTlZ6K0pQ?=
 =?utf-8?B?clFHaGVWWjJkZmFrd3hLaXcxUjJmSGF0VkczL283RElmWWVLNExHM2N4UEhG?=
 =?utf-8?B?OWV0bndzK0pyK01CMUt1NGtSUmRNWjFWR3pidFc0UWVqdTNUdm56MHZYTEwx?=
 =?utf-8?B?a1M1aHc1c0F5WWc3SHh0SXpLSXRVMk04OUdkMVRUUDNRb1dqWlFucy91VnJZ?=
 =?utf-8?B?UG1SM0JUQ05IUkZ5cFhXdnp1TVpzOWZGOVpLUmdsci85WHJvZ3krd3lVSWNn?=
 =?utf-8?B?a1FyeTNIRGl4NFNsRVF3ZHNMaDRYOVd5QVVZTlZBY0hYZjRWY0lzWDAxRFRY?=
 =?utf-8?B?dTdDQ0RsSkRxTzdtK2Rndz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0NFbm9KZmdVRTlvTkREMGVzbTgwNzRyQXBWbUZNUlVMalVaRldEZ3NkOVBN?=
 =?utf-8?B?OXlrdzloRisveElNY0VGMVQ4RDJIY1BaNnFzKzZnblBzUVR1Z1VJWjZKQkVt?=
 =?utf-8?B?UCtMajVyM295ZWYxVlkvYmJaczhVUVBNZHBGM1pYcHozRW01NVROOThEUkZF?=
 =?utf-8?B?dm10K084ZVVQUEdzZDV2ZlNjNTF5Y2hTaVFIY25xRHNxUXo3aXBXUHVFOFdZ?=
 =?utf-8?B?aHJMemsxdEYxZkpFcTBtR0h1Wi9MbHZrRklGWXBWSHRxRUlJUGN6TDZCaUd0?=
 =?utf-8?B?S3ZINUw3a2JQS2dEckY2MVVHaGFSbWlsWlByLzIwM2lMdTlxUmxFc3VaTTFm?=
 =?utf-8?B?Nm52Y0hPS0d1emlwRFR4Z29GeWRyYmRtUWJoZ2dwUUxHaUdNSlBacUFCb2FV?=
 =?utf-8?B?L2FnU0l5R1orbGh3bjIzU013cWh2RWFGWVJ0alFuRXJDTFVJcGNYN3RDejRK?=
 =?utf-8?B?Q2dsWmdYeGFUWEYycmdhS1ZNUHJHS09UTytEMFMxK082ajJzaWpQZGowQU1M?=
 =?utf-8?B?R21Zem0xNXpDRkZJYURxNVd1MjBmMHNkWi8yQmhsNWxkUmIyejVLc0Z5a1Mr?=
 =?utf-8?B?cDZCbGZtaUZQS2ltNktXaW9HR0x4UElmZVowQTFpL1E0VmZ4djFIT01ZKzFC?=
 =?utf-8?B?OVliRXhOR0VtREtQRHBNUDIwSUFJQ3hVWE05bm1vREUrK1VDQ0JqSG50dURZ?=
 =?utf-8?B?bldhK1lSK1RaT0NRVTNYNEZsRk5oMGt3THdMblFqQ3dWaDFUOVBCQjcwWGNV?=
 =?utf-8?B?MjNNdFpiN0FtN1FYQUZHMFRRTHBKODl5MWpjbGlHS3JIZWZYN01zZXVPNGll?=
 =?utf-8?B?bGlqRXFZdEgvVkErSkRtcFd6RHdiYUV4NDZRNjN6U2IxZnhTQndudmFPRUhL?=
 =?utf-8?B?QXk0UjROdFNKb3ZTUXBDSERPYUh5S2R2Mlc5QUdxL2hOb3F0MU12ZEM5ekhU?=
 =?utf-8?B?MjNORWY1U0ZZTUFKVzhQZUtybDFHTkxnNkxyMXV0NkMxLzVpTFFqRkJhZWwz?=
 =?utf-8?B?dUJVcTJ6YnhwUVB6QzFwcVRKTFhYMzJvWVlkOUhsQWVEUGd5KzI2b0dMYkJK?=
 =?utf-8?B?NGFDL3pKb0t1STU0cGhaUUtoQys1bWx3amw3Yk5ER2ZVOGxab2l5VkhSK1NK?=
 =?utf-8?B?dnhFQVNRRmpNQWJ2eTI4U2tjSlNzbk1YTC95YVk1enl1NkhGbnoxeTE0bzVr?=
 =?utf-8?B?NDFsdFlUeUZZVFkrVng2L1dsNnBUbk44cE1mZURoditMaXl0R1ZSU2tzc25o?=
 =?utf-8?B?MDFUQ3RYZkxjUUNkMkh0QWJGQUVmZ1AzVlJla1loOWxoMklPcktJRTFORm13?=
 =?utf-8?B?SjRvQm1PN2FkajlXaWFrRnBDRXdkMzBXQ29uVVVjMHoxSFN1Z3JTb2RDNEhI?=
 =?utf-8?B?TzVQanY2QW9YK0xxdnhXSnkwZEd0Q0NEY2hjR0ZsUVMvNW1zZVBBRmRFdmt0?=
 =?utf-8?B?L2tEMVB2S0NRKzdYbFk4ZnMzeUM1RG5yemhtMmRrR0JxWXF3aE4raWw0UHUy?=
 =?utf-8?B?UEFsL1lZckFzUUV5NExqcGhGOG5sSjBoaHpYZ2Z2a1hnWWNHOFB2WnZpMzdT?=
 =?utf-8?B?dGZWdjBBL0FEdXVvUkdqQ0tacjA5dXJseFdJcDZVdzAvSmFMME1HTWY1ZzFW?=
 =?utf-8?B?UGZPSzJaeW1nTUQxa01IR1FDWmdnaVNJRlo0OUM3ZDBpOEFvYnhVSnd4UlZZ?=
 =?utf-8?B?NXNWNDdoTVVlcW9EUVJRY1NJSnorZUo5Rjd0VW94TmM1bWtoMEY0eXhkazZh?=
 =?utf-8?B?TjY0OTlSYnJsUWU2Tmg5Zk03S0kyTnB6K1E4YVJsUWljY0dDd0h1bWVtMHdr?=
 =?utf-8?B?SWs3N1JtdWJld1ZoRHZ2aWtNQlc5VEwzYlUxKzFmTUJySVRYQ1l3elpqNVg0?=
 =?utf-8?B?bW9VZmRUcm9lM2RNTGowSXp5NkU1RkloMnk0V2NiNS9KcUZCQUw5cm03eDhZ?=
 =?utf-8?B?OFlySDRES1VIOUpCQmRNNmNVN3FDYzM3RkVVUkQ4MXJnMUhtbHFtdTVMRFhv?=
 =?utf-8?B?Sm5aRnU1cXRxSEkveSs3YVdsdjFjQmM3Uitvcm1FT01RN0p5MEtLc0JxNnFN?=
 =?utf-8?B?VmRtWk9GNFNraGV5TDZiMVdnVmhIbWFlZEZXOTQvWjZmZXRJVGhYMWs5Q3lE?=
 =?utf-8?Q?c76DmT+tZ9AYrq8pC2nyEWyQ2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd0361e-6a4f-4a4b-2685-08dcce383ddf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 05:53:33.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwV4DLMcJEF+ecCO2DAV7GDoX6ZIhRhPSPdJ+5TXJWqmckqJVO3WfsiUUMinN/1Cf7J0o/bBOrlhBDD9qaIu0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6288
X-OriginatorOrg: intel.com

On 2024/9/6 12:33, Baolu Lu wrote:
> On 9/6/24 12:21 PM, Yi Liu wrote:
>> On 2024/8/16 21:02, Jason Gunthorpe wrote:
>>> On Fri, Aug 16, 2024 at 05:43:18PM +0800, Yi Liu wrote:
>>>> On 2024/7/18 16:27, Tian, Kevin wrote:
>>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>>> Sent: Friday, June 28, 2024 5:06 PM
>>>>>>
>>>>>> @@ -3289,7 +3290,20 @@ static int __iommu_set_group_pasid(struct
>>>>>> iommu_domain *domain,
>>>>>>
>>>>>>            if (device == last_gdev)
>>>>>>                break;
>>>>>> -        ops->remove_dev_pasid(device->dev, pasid, domain);
>>>>>> +        /* If no old domain, undo the succeeded devices/pasid */
>>>>>> +        if (!old) {
>>>>>> +            ops->remove_dev_pasid(device->dev, pasid, domain);
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>> +        /*
>>>>>> +         * Rollback the succeeded devices/pasid to the old domain.
>>>>>> +         * And it is a driver bug to fail attaching with a previously
>>>>>> +         * good domain.
>>>>>> +         */
>>>>>> +        if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
>>>>>> +                            pasid, domain)))
>>>>>> +            ops->remove_dev_pasid(device->dev, pasid, domain);
>>>>>
>>>>> I wonder whether @remove_dev_pasid() can be replaced by having
>>>>> blocking_domain support @set_dev_pasid?
>>>>
>>>> how about your thought, @Jason?
>>>
>>> I think we talked about doing that once before, I forget why it was
>>> not done. Maybe there was an issue?
>>>
>>> But it seems worth trying.
>>
>> Since remove_dev_pasid() does not return a result, so caller does not
>> need to check the result of it. If we want to replace it with the
>> blocked_domain->ops->set_dev_pasid(), shall we enforce that the
>> set_dev_pasid() op of blocked_domain to be always success. Is it?
> 
> Yes. The semantics of blocking domain is that the iommu driver must
> ensure successful completion.

great. thanks for the confirmation.

-- 
Regards,
Yi Liu

