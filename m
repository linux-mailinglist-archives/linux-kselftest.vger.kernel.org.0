Return-Path: <linux-kselftest+bounces-18608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9B1989F90
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EEB1F21772
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890D918A959;
	Mon, 30 Sep 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P34fT7c/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF62417C9AC
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692747; cv=fail; b=SWxJVvlpZ3RwgVy32BMiAsmhE9oTCpEahPSDJySVTf1Q/3zxnSeZFgwLxTXsYlClK2r+ZBiwDC7fwc8N5nQl5ET+JqrNJbsYdPMkH2cqCqnGMRFr/Ty3U9BVvvePuh67xk3EXhKd0jJJGnnOTQ7OHiJBxFJIiyxXkmGW3x7Ascs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692747; c=relaxed/simple;
	bh=8zv0Uv+hf5OaphMG08tKoSOJshw8K6Ld43i7+Gtl8K8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X7Gy69oKvimos3CS5rh03ZyfsEXrB2fUv6crNPV71aPEZez4u1ylxpbwrS1nIWWYHM+qEejY4U3VYOblw4hcYolp/Aq0u7TuRFsVV+M8uFHF1DhGW1GLT+Hq60uYM4lFa/CofTTVkj5IzUsL9lI/tkC1+JOEdMGeQtddOgG+PT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P34fT7c/; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727692746; x=1759228746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8zv0Uv+hf5OaphMG08tKoSOJshw8K6Ld43i7+Gtl8K8=;
  b=P34fT7c/PZsrRj7dZX9vxif7H6PAOA2FF3d8wAFilm+g3ZH6nq6UBGmw
   o361XZRQNQmLbO8Ecw1kWxPh1tLioWasBhmNBOQ6AQ1ajrSFttrd+cs24
   UuO86kkOWb85kjurhSujhsrkxCzO6rRCiU73e8PgrcJExVNq+EHVn5FkP
   NoeoNx8pmvF6R2Kara7BISMgtivYIkPnYZzcmorO9NE3Be+jZj5/HBPTc
   +obVL/LCjPIdVOxL6LM4Jf9PU8ZrRxplWNxWHIblTLOh4mNQXizmrFzeI
   jJnMWCJIvrf1C/aNIDtFbl0IhVE0yYxDH41oTIaFuRg885qohHUg6Pc4x
   A==;
X-CSE-ConnectionGUID: GruJ7+XOS76Q+QoIB9Qq5A==
X-CSE-MsgGUID: G95gB0xgQime8P79Zp3VDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="14399189"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="14399189"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 03:39:05 -0700
X-CSE-ConnectionGUID: MEH9I+sURpC0X0TogTZ/+A==
X-CSE-MsgGUID: TsRVQxQlRCyu92W2+w5Xiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78017259"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 03:39:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 03:39:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 03:39:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 03:39:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 03:39:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cj0wdnGhZx9JDxI8nZKhBnzRE4nOlLdkrNmyQtA5OHkgD5JLBCje5l6N9Ae2bJgPxK9C+ubx5m7cBmQcMok/1GrWeFsCgPmGB9/Sv0SJ7Tb3tSzyLpVmPuaYwjeqQDGwK0LGiyUxGbYkxESszntUAqmxCHL1+KBYiacmgy7l+rQdpkYzBVOBgifarqybI+Ep7JHTIs/J8mblW1eTqftP+613dMzCODmtoYhmXcy3Rau77qyH5Iunh7R0/s4sUVmp61Nsv+1RiTbW5qnVErDRupsl6grXsTnuWKGIRGZcEzqQk4BldmK/m1ESwjna7OtY2fvdIQwV2QOkSqZVzBslIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDsCWHnWwTGX5cVRo9gQZT3iLPybPPkKOD55WUS/y5I=;
 b=EBrFLKVF7YrXZxbdbEtPVD+iZNrcDiRKDGFvZ8nDHV0FIpKWAruHGHrTkyJLdjqBuP3u5S10ixSLAuz00o6SRlBcO2tc6AYf3lDXo1aAWg13q9Ao/ze70nl27k/vD99cs4651HwIJ8UGxovAwBaeBUEhbQy7EE9HUZ4Mfbv+HkpS4lz51uLP9WfbGy7YAHzNpzLfpZWYRj1DydTGicme6aGAgQI7ixKAXpYlT3HQADxTqBqpUntoUhos+l2SMKDXzMEcs8QZA7zN93k9KiIMJ/td1n4HaGl1z/MVBWY1an+2kzeDcNTzPQOUyEJcU4DYB92Umh94r3MSVJDAiSaJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV8PR11MB8533.namprd11.prod.outlook.com (2603:10b6:408:1e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 10:38:56 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 10:38:56 +0000
Message-ID: <352acd97-f027-4f15-a9aa-e22ac71671b2@intel.com>
Date: Mon, 30 Sep 2024 18:43:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] iommufd: Always pass iommu_attach_handle to
 iommu core
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
 <20240912131255.13305-5-yi.l.liu@intel.com>
 <BN9PR11MB527688239D992F80D77756C38C762@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527688239D992F80D77756C38C762@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV8PR11MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: a0558af8-0eb6-4f82-4767-08dce13c1609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejdpT0N1azJoWnhVQ2tNaVR3RlZyRnd2WFNaNStEOXNFanJLc2hqS01UNi9h?=
 =?utf-8?B?Q2ZxL05CcER6a3QvTk85MnViYVZwSUxxVkZzSTJuM1FIdWxvQUJPQXpLZ3N4?=
 =?utf-8?B?VFMwcmkrV3NNOHlmV2k5TmRvaE1sTHhlc05lS0I2MTFHMjIxWjdBaHczRWJB?=
 =?utf-8?B?Qm0wdGZnR1ZPTVhMSzhISERseFB4Zk9vRkRxb21ZRk1ocXJxdU9ZN2V0R1li?=
 =?utf-8?B?UGNxSzR2by9PRkRzTXE1QmpyYnY4Tkt3Rk1selpGdnFOVlZ1cURiMzZFSy9m?=
 =?utf-8?B?TkszZWNROExkT1liOEVTRTM0WUJ3U0hwYlVCamxrK1lYUy9uU011RjY2eVpL?=
 =?utf-8?B?RzNZMDJpL3BIWlNlWDdPamNGak9BbzZIZjRsSE04ZjExUjhTaTY4UjZsR0tx?=
 =?utf-8?B?UDRtWkxpcm45dVNwUjgwaHA3aUdqdTA2U3oxY0ZiZTFQa3dzVC9XM3pBdkE1?=
 =?utf-8?B?NmN6d0NBb2pDaU5vSnd1bThuczBRb1pZeS81Wm5MWEdrMWs4Z2N6dFdSaS84?=
 =?utf-8?B?Umt1NnY1Z3FPZmhvMkhQc2tnWHpYWlZsbS9Qc1lidWE4cWdJRVRyY0h6MHVL?=
 =?utf-8?B?K3JQMVVmTStQR0NNQ28rRU5zZGxxL0VGMCtVNHBnY2lVTmw3elhRTHZkMVha?=
 =?utf-8?B?anZoWWphcnBRRW8yMzYvNUpBTEoyaVJaZDNtWEs1UWg0UUZYMXljNWN6L3Fu?=
 =?utf-8?B?UC9DdlBpdjRub0VyOHFaNlpudERuYk9UT0RZNGEzQ1huc3FMdG44bW1nbjlr?=
 =?utf-8?B?NjJ0N25hdVJoYnJzWXJHRXFnbnpVNnFOTzZBcGl1eldhMyt6Y1RKdEhBa0Vp?=
 =?utf-8?B?Z2FqYzNBOVMwMWROaFpTak5zclVDQjVjVk1FZnFleVlRUmRiL213UFFyS0Iz?=
 =?utf-8?B?UFd2UGRMUXBuM0oyS3lOZVcyVXN4UU1zMk9EUzhYQ3hsWHN6ZklPUzJodjJX?=
 =?utf-8?B?ZVlzTmVsVVMxcjRhUDBlRE1Ha2lZbFVUVk9taXc0ZjNIWG5wMERsODAvWHJF?=
 =?utf-8?B?dVhjaFVHWHIxcGUwZGNmbkpZK1dtdUJmeS9oTDVxTzlYWTd0WTdSZ2pyNFFV?=
 =?utf-8?B?Q0UvZThIWUx3eEY2RllXMTlWUkp3cGJjSGNWcEQ2Y0pQZDY0cXZKQi9aakxG?=
 =?utf-8?B?UWo4Y3h6eGw0ZUZobzZWb0d5Q2huUi85TWp0Tk5MRW4yUDBISEVRYlk2NytN?=
 =?utf-8?B?a3NkS2Fud1NBckNrQ2wxaUpYSUUzTkVhWlY4MkdRamJpWSt4M1pDNmNWVEpY?=
 =?utf-8?B?aE00cmdsRnFzbytTcjFtSmkxSlM1Q2Z1N2JTVXR6K1FtUVZQYW5TeUhxQmJh?=
 =?utf-8?B?WGRKeEpqTzM3OWROS1QraTFUZExDQnVXaVZHbGt3NGw1QjR6UjYyYnVscjAx?=
 =?utf-8?B?cjdQQXBkd0djYWpwbTlmRkJzZ0wyWTdvMWtRc0JDNzd6dHlZaVZhSFpFWUJz?=
 =?utf-8?B?Zi9RRzBKeVYyVjFIbHBTeFcrcVRPQmJ5Y3ZTSXhvN3k3NkR3NXEwNlZTN2Y4?=
 =?utf-8?B?ZWZOUk4vUjZkSmZSUU9TR2dXYnBKaXFkWk54aFBqR2h6bDlyVGV3RW9FakxP?=
 =?utf-8?B?dlNWSlFzSnArbTVqb3MvYmZhSlpYTTMvS0dNaThNbUxSakgySnFKTTZXclFP?=
 =?utf-8?B?cE5tRUZpV25ScXZwckl5QW9VMndudFRqQUFuSXZHVkxIdjYvQ3N4dWxIbndo?=
 =?utf-8?B?VjlQdXZmQ2tKMXJ5N2NIN2RlWmdsSno4TGtxMlAyTDdhSTJzblNzU3pBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9nTUN5N1ZxM1Q2WC9UMEdoTGxkaUhyeWNSV1ZoSStBaHhabFRpcUV6VEp1?=
 =?utf-8?B?WmRnM3NHQysxdVZsY3F6T2E2aTJtTzQxTTdDQ3A3QmxSTWQveTRvRURLRTN2?=
 =?utf-8?B?MzVqb1dTTDBRNS9zVUw2cGVpQzdYUU1LakVJZjBySmJzVWpxZ040Snc4Uy9W?=
 =?utf-8?B?NW50QytIV1RxOXNZTkFaKy9aaVNOR2llUDFReUlCNmx2YUJQblpyZFBHbXlD?=
 =?utf-8?B?Y21YOWN5eXdwM3dDV1d2Y0ViS0RpcUlBaTNWVUpSeWdycHhJcy9vSXg5RnpM?=
 =?utf-8?B?L1NoemIrUFh2RUhlZnhkcWhQVmNlc2ZobTFMeWtxRDFmQzBNZDBKdWhaVVlH?=
 =?utf-8?B?RFEzY2J3elp4WkJyYmRJSHpnOG5mR3czcUg4K01oNU00T2Y3ajNRWldPbTF6?=
 =?utf-8?B?YXJPZWo5aVltQXEvVGN1K3NQaTNVVUtOQlNiSk9sZ29GY0NsWXo2N2gzR0VQ?=
 =?utf-8?B?Sld5dTQ5Q3hjNjVtTVlSWTBqMG1MQ1c5S05kK3pzajh0aUpiTWVYcmJVdFJm?=
 =?utf-8?B?QnhVOTkvR21YVXM3VXVUemJ6dUNpbHlieVRybEVjU3gzT0VSbzd2SFlhd1JB?=
 =?utf-8?B?OWRaQTVCdTZ2eldReUlpSzluSUZQMUtZTzFFYnNDVG1QMkRYUHhFQmVwc1dL?=
 =?utf-8?B?Z0hxVEpiMGhremE0UFE0MXp0TnoybGdRV29nMnMxNWt3RTVYcForWDAwVU5n?=
 =?utf-8?B?d2NsN2lHaVFYazh4WEw0LzlYQnhiVVdHZU4rdWRDS1JQR05yQVgvNHYyby9t?=
 =?utf-8?B?emlPYjJhRzdseEJyZ0FwMm4vcFhMczIzdXZKaGNlUGVCaVJmcE9EYjlFcUpz?=
 =?utf-8?B?Wnl4Z0N2UFl2ZUlZUk5ZMjhxSEVyb0s5czVXV3lLbUU2SEJjc2N5YUtPUXVj?=
 =?utf-8?B?V2J5TzJObVIwVklXSDhxalhha2Naa1dQVnJQMisxVG1qQzVSRE1oWW1SZGFL?=
 =?utf-8?B?Qkk3a2tERlB0VEZrM1YxRmROQ2ZKWVN6VWprZ3o1Qk0vbURFckQ0WHB4NWpG?=
 =?utf-8?B?UzBVTTVEeGxqQ1JZNksrWFlheDBHQXp2UmpzY1JKZ1ZLajRwbmgrbDN3Y3pa?=
 =?utf-8?B?UDNkODRjaG9WMGtETklSeG10MnFNMTVnOUgyUk1teGNUeWdzMlIwR2lXV0hx?=
 =?utf-8?B?S3ZuZkNmVmRZWHRUWHlGR0ZERitQNFNhRkN4T1BqaVdYcXhVVVVuamN1ZTV2?=
 =?utf-8?B?aGlPck1lTm9xSmVUVm4zSE9oTkgzMnEwdm8zdTBIdVYvKzYyeTd2RUFLWnpD?=
 =?utf-8?B?bmhGTFJ1ZXZ5U1V1ZjByYzlNTlExY3pyVjFWRGU0NlpXWFVDYmp3alVqTnA1?=
 =?utf-8?B?SEJiZVZ2MGRvU1g2cHdjcVAxdzRKeWlLMmpITUZXQ2doMWFON3hqcWpkQTMw?=
 =?utf-8?B?aGhGQlJwOG9tZ2xHbmZzUk5HSk56NDVhYXVVb20xUTNsQmtiVitOc2hLQkE3?=
 =?utf-8?B?U3F3SVNmd3JFVnlIQ1A3WGIwQmFWZHFlaHRENm4zNXhYRFIwTzJpZi9xb1dJ?=
 =?utf-8?B?ZjB5cVFrMEpwVTJFMEhrUmVDTklSNXhnK0VCbW1tYjNZODRtUDBUU2dJWkZ4?=
 =?utf-8?B?NndvQUtLajB4SHhERFFETXJ0cHByYllGazhYTkFBemlEdU5SRExuZzBHNDZn?=
 =?utf-8?B?VmhwNWJscFRRV1A2Tm9DSWlhMVd4T3l4K0xSNm5JSnJDa082U1FuNGpPK2F1?=
 =?utf-8?B?aGRMd3ZQRkN1bzhpWU82NFBvTjhiMExFSTY4Ri83cjdrME9HOFhwbTlrL0d5?=
 =?utf-8?B?MW1jVWFBeXpvcjBkOVlKN0FuOXJuN2czbzVQcFpBcUJHUGIzZW1IUW5FNE44?=
 =?utf-8?B?SnN3cmlzY3VaT1pDS2dHM0VQeHJxQjhZOG01czBQd1M0dFFrOFV1TFIxb0dz?=
 =?utf-8?B?VUs4Yi8zZWplZzlyRW82QmUrL2hIdmVkM2ZSV0xxSjY5M3ZzblpONVVZY002?=
 =?utf-8?B?bEtiYm53YU9YNEFoRmhTT2JwTEhkcDlnSU5FVUdCY1BIa2pNMndhZHBZcmYy?=
 =?utf-8?B?dmhPQ2YwZE1qNUVLRCt6VGE2WThKSm9vNlJ1ZmdxbGJINk9MM1U4QS9PMzEx?=
 =?utf-8?B?aGhrVjBXelVwWXdDa2YyWW1Xa2RrUk5ZRDMvcGt2Yjd1VldpNTRBK0VzdTVK?=
 =?utf-8?Q?AAyhgyADSCsHq3jC5Tq2/nvjX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0558af8-0eb6-4f82-4767-08dce13c1609
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 10:38:56.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaSGE1EMIOABCyYGP9TrigFEnwT6cx/vZoQ9MOMBc9mdfh8qxgURRTbnfsyQqPahtJ989RuPyPfPTUX4QMD4ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8533
X-OriginatorOrg: intel.com

On 2024/9/30 15:45, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, September 12, 2024 9:13 PM
>>
>> The iommu_attach_handle is optional in the RID attach/replace API and the
>> PASID attach APIs. But it is a mandatory argument for the PASID replace API.
>> Without it, the PASID replace path cannot get the old domain. Hence, the
>> PASID path (attach/replace) requires the attach handle. As iommufd is the
>> major user of the RID attach/replace with iommu_attach_handle, this also
>> makes the iommufd always pass the attach handle for the RID path as well.
>> This keeps the RID and PASID path much aligned.
>>
> 
> hmm this looks more like a design choice instead of mandatory
> requirement, e.g. as Baolu commented you can also pass in the
> old domain. though I'm OK with what this patch does...

yes, it is a choice. I think it was agreed in the below link.

https://lore.kernel.org/linux-iommu/20240816124707.GZ2032816@nvidia.com/

-- 
Regards,
Yi Liu

