Return-Path: <linux-kselftest+bounces-17943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30808977FB0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 14:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCF71C212C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C27A1D88D3;
	Fri, 13 Sep 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fr58V7bj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908601D86D9
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229915; cv=fail; b=eoImGNfxxXjCHZ8XR2QtxvICmV71vub9yXaM+mrM84WYIjx2yhy1wAXRCIWXudrUE2nkvON81tVHygUXjzHq8Wk7C523p03umaeSZE3/hgfINE6KBz6lGyZivFykp74L+bLY6ZSFt9iHwpwjDbNak9KsnA819yjbzEJxCHXu8kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229915; c=relaxed/simple;
	bh=ZuyQY+DXcAOftK5w2m1kBE0kcIsOJ56iDNqVjEOdFQ0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B8D1i2tHfs0XgxbISy8WohWZTkriVLx+MuD6m5riTi2PbmNlsqJiYseAtPvIUg8l/jMw5b94XY/umr1uo3gEOmpQputd/jF69MSJKEePpDdA8C2tU7MhRpwTLF4B8buAxy3tfPqCnMIwfSNYd3AYFIYFyDTQeEAgBn1bUvXjcxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fr58V7bj; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726229913; x=1757765913;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZuyQY+DXcAOftK5w2m1kBE0kcIsOJ56iDNqVjEOdFQ0=;
  b=Fr58V7bjL/4vF3wixIVVF7xQSu8Uo/JKSUHz9llm2JXIa0oeAO3vTSE9
   fzOWeIH6aQm5IO1bG1tfWfoECr0RvIaRx+i9EFuJBhx3/elrbS+4cz3Tl
   oT79ltuPfolDb5o2Grl9ic5QG1RwjwAV5/DhrhaL8RlE3vLbn8rpdz9mo
   +NbhzcAY7XHmt+57AEy/2U85ZpEvxrX2qT4YjqLowN7mMs5P0yZjCGlBg
   p8uG5AbChQ0dUlENGpnjkR9BpjmsUo06iyPzMgN9w25W334NQC7d2ZDZW
   yI3y48oZObw4cf0BJ8bJxP+tJpzfkaI4gEysGt93ymM0xJAlnSZBFUn5L
   A==;
X-CSE-ConnectionGUID: LQYbkGNORrKY0g5OCMP+YQ==
X-CSE-MsgGUID: TwUv29xKRTyARUvMMRlxBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24615675"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24615675"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:18:33 -0700
X-CSE-ConnectionGUID: rfNKmHu6TYSDuNP0+YxB+w==
X-CSE-MsgGUID: EW+VUBvzSCWPgGYDGUIB1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72802944"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 05:18:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 05:18:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 05:18:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 05:18:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 05:18:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZIIPT+54OOjFTKoLS7FSNkfoq5YwLZ0+1wWG7RtXuCIkGJpT6mHJAHZZQLYzPmWI35MZnwyc2IBYavh/OoMGwRG1xTGYGdCjZ15+jJP323UdJkMGKCUxHwQFIVRNiblDMSouWAV027FcNrjROsfzz2VCG4Q0ZB8YOOpkQ3au/BctpVGTZyzNnFePQGBz3EREuRd5MxC11cLPOg700VPwtc9oOhbP0jQDS5mlusFzQ8ctG3vGAaOImvxNsA7qKHkKzE5bSDv/0g4CouaGygA5SFJrRV84CyxLFdrMXqQvSE0JXN02d+0azsnJFT+pjuIpcptOYqi/gm+m2mMZkC98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64AyzsKuFMppdck8Fj2AWO099xkiSz0L8sd2FTPJgIo=;
 b=gqtUemZ/kA2DlGebywqqLvW4IkRdO3/+Nq2rL7RKVvN4DYo4Ljur271bPI3t9wOmRKsl38Xh/nWpZNg1u0rvDYDMUA9unAsLZBa0AvKmzvmYn9SKNzz6A5RCZk0Mk7vS7kV7vbfRmM+S4m6R717zSHzAtqPAY74YudGwKQNLpg7Wkk3/ezE39t/wcDu+Jy9lSpMDuNYo7kQGmOdRzK8C6qNEfTe/F5MBIDhGqGnuiVn/9zMfdL8+1PYOmPuOUFXPpiYiJ80LfM+Fn5tacvyCgwe/289qwGYYahgcnSk4+Xc9/xx+MKov9It60kihqz0mcD8klbbOQMrgM8mS9uWcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB7154.namprd11.prod.outlook.com (2603:10b6:a03:48d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Fri, 13 Sep
 2024 12:18:29 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 12:18:29 +0000
Message-ID: <1543ffbe-5597-4ea3-b77f-f98fea00d126@intel.com>
Date: Fri, 13 Sep 2024 20:22:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
	<nicolinc@nvidia.com>, <chao.p.peng@linux.intel.com>,
	<iommu@lists.linux.dev>, <zhenzhong.duan@intel.com>,
	<linux-kselftest@vger.kernel.org>, <vasant.hegde@amd.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-5-yi.l.liu@intel.com>
 <5df26703-012a-4c06-af59-0ccc193d250f@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <5df26703-012a-4c06-af59-0ccc193d250f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: b179f95a-f8f9-4c92-7112-08dcd3ee2d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UThhOTJTRWsrRWVzcEkyVzdXd212Q1NCV01yQkRIYjV1SWFSbTJlWk5FZHh4?=
 =?utf-8?B?UlE2SkVtMEg4NjI5c1UyRlkvbkxMeFd0V214ZG9aazUzK1AvRitiaGF4VTg2?=
 =?utf-8?B?aXo0c3FaSlZkT2pONjBmbFFEMlJYV2R4dC96TWZDVkFFbkgwR1BtUjl2QUIw?=
 =?utf-8?B?dzdaZzBwekZKNWRxcENoVDRsTU1GOXRqcjFBeDdhNFZBTlNXZ3VUVG02ZFl1?=
 =?utf-8?B?WlJhZHB6bksxSnNKd3E5M285eW5QSjExVGduMlRVZGQ1TzhWdmwvZDVnV2Yr?=
 =?utf-8?B?Y1kzUU1NZEY1VGpEakZBT1lxNjhIOFJ6aGNUZGFaMFhpazZjbWRJYnFoVkYr?=
 =?utf-8?B?dDQ2OXJqcFNUVEZuNE96Zk53bWNVdlpTWUlNQkxPcWNVemt2b1gxNjRlUFdG?=
 =?utf-8?B?Rlp3dlhDYU5NSG1pNUtXRUs0NDA2TFVjWTA3endqWWhpWXRVamlTUzc0b2lv?=
 =?utf-8?B?MjZIOUVpQkUva2svcHQ2b3VWb0pzK2w1SEtMNmZma1NqdjBWcEs4eUtkZ3g3?=
 =?utf-8?B?c29pcTNYWHFpZU9hbUFDd3dKWThtbFFtMVNwUkFLTzFTb2xYNGVKUm00VTI3?=
 =?utf-8?B?SXN2TmRjY1JGSUVGd0RZcXB0N0pFWHdSd2NHQ3B0Yy9BUUM5SnpQUEc0UWJ0?=
 =?utf-8?B?LzJiUkZ4cXhuK1dLa2c2K1Z1WTkxVU1leFZCNzN2am5sS0pTMFN6OHEvMVUr?=
 =?utf-8?B?YU1tdmZzVkExaGVpVksySkpvSzlsZStxK0JlNWV4emxuMGh0cDNoVkNjcUlW?=
 =?utf-8?B?NHpRaEs3QXFQOWhFSjJiaURqWVc1M0FLdXdGYTZ0anJlOVRsbWE0Q0p3QXJk?=
 =?utf-8?B?TWpWSERjd050Ynd1c3NQbjg4VzMvYklDOWx6LzBSV0FOcFFxaXhhYVpqVjYy?=
 =?utf-8?B?Y0Y1SWxvUEw3UU44MDIwZE5NaTBPMVN1V1cvamJrWVVzT0hUbmVIUHhKZmdB?=
 =?utf-8?B?d2M0VTlZVnpnY2c3SlQ4OGkzUmt6TlNybUZNRUVnMmJOdGxuZ2hnbUtTcEpa?=
 =?utf-8?B?dGl4cFF5eHV5d2wwNmJCZVk3UmZBbEZhL2xQWG1la0did2hVdWNyZ291bm9k?=
 =?utf-8?B?Q21FMFpiZDVlV3cvVDBEL0RBdXNQVkdWOU1haW1UZHdBV3pqU1l4NzlWa3pL?=
 =?utf-8?B?OFp1ZzZWYlg5REZGTlI2aFlMKzltTGNVMWRDT09rcEpXREdIcWhoRWgrSTNn?=
 =?utf-8?B?aWYxR0hFOG9NclhYS0QvRzhlQkVYUjViVHRuV08yVXlBTEhaVVZETHQyWHdP?=
 =?utf-8?B?SGJRMDhURFRNckp2VnNVQW0wWnQ1T0wrRmFWZWtJbnRIMTR1LzVUb0RSZGpm?=
 =?utf-8?B?ak1oalkwMWp5YTA1NG04Mkd2TUhjc01qRDZzVDRFSHpXdjRFanhEbE44WFpO?=
 =?utf-8?B?WU5DZEhxVW9iOVExZmdVbzNmQUg1eTh5TkJrL1JiSDhYdEI2ZzJ1Zys3OUk1?=
 =?utf-8?B?Q3VnVUd6YmFXT0UyWTJkSUtDVUN2ZHBhdG9mYWRYbjF2Nnpvdnc0MStGK2kr?=
 =?utf-8?B?UVJ4ZDJpSkNOU0NpVUcvaERvaXdCN1VrYXE5TmJPT204ekd6V1dwVmZmamV1?=
 =?utf-8?B?TFJoLzdEUTZDcmx0cVlGSFc4VzI4cWVBK1M4Vy9yRVFsM0QvRnhvdXIremhF?=
 =?utf-8?B?ZE01ZCtmZGxDY0NqejdMQzg3SWhZZ2Q0T1ZiVUxSSVVabGNwM2RZUjI1d2pU?=
 =?utf-8?B?QkI5KzNkTWZ3bmx2eXh0cENOQWx1YWxRUUtlbkZPUFJwd1hZWk9IV01Dd20x?=
 =?utf-8?B?MnVLd0FWQ0dSTVR6RkltM3ZqdXBTVXZkZEY2QTl1V01ma3o0QXdMTnJqZWJz?=
 =?utf-8?B?VjMzTXByS2dab2ZLeWtVQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXhlRHNtOWhJTDF6UTlYS21xaEI1NTVDRnMxU0RrcDVmY2xTTEc4R2RpbGxG?=
 =?utf-8?B?ZjBCOHJucEE3QkVqOHJhY0U3VWVPUFFOb0NhdzB2aVoxRTBQQlZIcGxJSjAx?=
 =?utf-8?B?YTZld0ptOEdDc0hFQTdtTXpHa2IvbEpKb05uQkhTZXNHTHZ1QnkzSGVubU1L?=
 =?utf-8?B?bk93Z0ZqbFEzc3NzaUlxSnNDNnBVNTI4cWRRbW5zRE1DZ0Q3RWdhZjVIdzIx?=
 =?utf-8?B?Sml4TlRES3dyQkNDblJqUW1mcUlxc1cvZUE3aW0wZGVNcjBWNktqRDdKL05x?=
 =?utf-8?B?NXV6ZitxbzU5aXNqMkxOYXFydkZrTktOUVRTS3BJRnlzYk5ZckpDaEpjUWtD?=
 =?utf-8?B?U1hUOHdWT24vV1JRME9vaVRWb0FFMkR0cEJEYlpVN1JuMjJ6MVV2cDZwT2Fv?=
 =?utf-8?B?d2lkckhReFhKaFFDMWFqajgyV0xBcXo3SGExcE9qa2s4bXlFNk1venZ6cTJj?=
 =?utf-8?B?ZjhsZmlhcHk5L09qcDNNVUtLUzZwUWpWc1pZQjBFMC9RTExxdUpmQ1JnTzdF?=
 =?utf-8?B?Z0dueEtJRFU3NFpiWHFzSjBOTlJuQjUrV21JOW5KTkgvbm1HY24wdzdVY3h6?=
 =?utf-8?B?RGk4ODJuZVRYMloraWdxRGl1TGZOcVpuRVJPdTFOVGRUVE5YSnF0bTRiY3JV?=
 =?utf-8?B?ZzFqRDliQ3NNVEYra2hsUzdDYUloeVROSVZ5SlJ4RWtoQitkRGlKTVZmLzRR?=
 =?utf-8?B?Sk9HTEJUeHhjTEtuaktHVGE2Tm4rcG1lS2s3VnQwK1V6Q3pEeGlsTXdEYXcw?=
 =?utf-8?B?ZEhXWWJ3UzcvWjJIU2FUb0ZBOWQzdGhjZTBIcGpuNExCMm80UlBKdDFaTmN0?=
 =?utf-8?B?eUFsZmVBclJhR3JUTTY4T1ArUzJGQ1lzUWpxNVZqREtSY2pvT0t5cDhFOEdL?=
 =?utf-8?B?cHNMMytreXdGMDhCVGQ2TEtzTk1hSjVweVZEd1QvNUE0NVdzTE5VM0RwVmVk?=
 =?utf-8?B?QmJVZ2pOYjJpSXpKTVZ0ZGUrY0k4a2NWYVlTcGRrZm5KL04zcE1taXhNM21O?=
 =?utf-8?B?bk0vMmRYTW8vZDZzdWZveW5DRmRUalVINTk0NU5uZUV5MFpYUENvalJ3NEdD?=
 =?utf-8?B?cVFQSGtoa1NnaFhIQTdqT1hET2FmbHJlWCtuSlRaL3YwNXJhUDVhZEZVR0wz?=
 =?utf-8?B?bDY2aG9zWGJSVFVjVGtQT0s5cUJHR1NuWWlMOERXTVNNakw2ZG5INjgxWUFu?=
 =?utf-8?B?T3FIak5Wb3A1NE50RE8rS0hPb1I5cHdoMHAwV25tMzlwb3MrOExjY056OWln?=
 =?utf-8?B?WjdoaEtudG1VNVdvRVBETUZ1TldmdUZ3YXNKRWJ1azlOOGxDcnV5SGlHWE5U?=
 =?utf-8?B?L1QzaDBwY2cvK2dnTmlWSHJ2ZVY0ZG8rcUM0Sml0aTkvYi9VNVFTV3dXODEw?=
 =?utf-8?B?RlZTcVBYcVdMdmcxWGRtS2p6VWlOVlJ2SEt5Y05xRWkrK2x1RzVYT29HZjRD?=
 =?utf-8?B?bTEwaWtyWlVzSTRuOFp0eUhReEF2bmN5c0RGRFh2cGVDeUVkMFI2OERQTHhB?=
 =?utf-8?B?NERuZ0Q3ZWVNN2xrbHk3eWdYY1RML0ExS0hhRElEODRqMzhnKzFMTXE3cFRj?=
 =?utf-8?B?aHA2OHdDRmdZSUhRYjB6Zm94c2Q3RzJJM0p3eTZaeDRFTlFWK0RBMkMrb1c1?=
 =?utf-8?B?WURDQXFORjA5SUhIaVQ5R0g3UWthVm9TRmozYkVtS0pkWHhDTXlLMER4WXM0?=
 =?utf-8?B?dE12cU0rYVNLK2h0UWhlV1RDcXdXUU00QWlhOElSNnFYOGpDVXVZOTIycG12?=
 =?utf-8?B?azY5T1h4V0ZsTXVIWXVGM2pTM3dCTkZ2YitENFVoRnR5S3psSFYzTXFabEVz?=
 =?utf-8?B?bTlaZGRsdTJaWkhGbURBMzZiRmtHOTJJa3cwcnhiVlQ1ZjJyeEpqRk4rUHdS?=
 =?utf-8?B?S3IrQ1VKbERYWGRMU0kzd1pieU9nQUcrZ2tnRlEyUUN0T2szSDJVWEtHTEZq?=
 =?utf-8?B?aVYrRU83M0VFb1FOZVpGeDFWUVd6RTlvTXM2MVNiUzFMc2Y0alJUUDBjNzNI?=
 =?utf-8?B?dkZXRmZJN0NYUjF6b3d1eFoydXhBcG5QUi9ReU54WS90TUQzdDJlUk1rNk9M?=
 =?utf-8?B?OGFCTWE5ODJzUkRqbTJnbjV6dWtwa01ycHBTR3l3d3MvWGJqZ3h3M1pIL3pU?=
 =?utf-8?Q?MI2UxZ6ENs2yW8Lld0O7Jtbmo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b179f95a-f8f9-4c92-7112-08dcd3ee2d45
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 12:18:29.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iosuSv1ZqzOfmHnFi/ZTLDXhjX+q7sYDVNGtoe270kzw1pqafu9pHvklOsW6UX5Vh3T6fEd8XPd9WzCz//5uKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7154
X-OriginatorOrg: intel.com

On 2024/9/13 09:52, Baolu Lu wrote:
> On 9/12/24 9:04 PM, Yi Liu wrote:
>> @@ -4299,7 +4304,12 @@ domain_prepare_dev_pasid(struct iommu_domain *domain,
>>       unsigned long flags;
>>       int ret;
>> -    ret = prepare_domain_attach_device(domain, dev);
>> +    /* Nested type domain should prepare its parent domain */
>> +    if (domain_type_is_nested(dmar_domain))
>> +        ret = prepare_domain_attach_device(
>> +                &dmar_domain->s2_domain->domain, dev);
>> +    else
>> +        ret = prepare_domain_attach_device(domain, dev);
>>       if (ret)
>>           return ERR_PTR(ret);
> 
> 'prepare' is a bit confusing in this context. It actually means checking
> whether a domain is compatible with the hardware capabilities of RID or
> PASID. Or not?
> 
> I know this confusion comes from the naming of
> prepare_domain_attach_device(). Hence, do you mind renaming this helper
> in a small patch?

good suggestion.

-- 
Regards,
Yi Liu

