Return-Path: <linux-kselftest+bounces-6251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA08878D5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 04:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6520A1F22665
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 03:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044B38F51;
	Tue, 12 Mar 2024 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="marzLvEJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884F8BFA;
	Tue, 12 Mar 2024 03:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710212676; cv=fail; b=oYS0IA2iM4NYVKAI4jx2D8napdzoFLgT9IJe7GJIUxshwKwBT2MlcPPTNZhGfdk19S0BeMKqxbj1fsbNvfMvrcxtE/fUUvAFZI1lB4BaLIzpGESWGHk5jO88bLslWK9G4ghwNRRzfc2cXPS6K9QJbqrHoUqjiMfwQDXSgp+20oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710212676; c=relaxed/simple;
	bh=bN2cXZYklqtzoWUQo2JcVIu9WiayIoaMjmAFlr2DbFs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oEUPQldtuYWrTecSF8iUJ571WCKha+BcIHtBrjG+E+tl3HS0dOWrytIaOBT3CaUPuTnxXGuDhvXBoP6c4kMJvluIewqglpAXxTaw6K+d2T2XLMmq6aXUrpiYui/VrqqdNL9igR5aWuWCb3Ic2exusbUCcS1aa9VaKy/TsL+7K94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=marzLvEJ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710212675; x=1741748675;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bN2cXZYklqtzoWUQo2JcVIu9WiayIoaMjmAFlr2DbFs=;
  b=marzLvEJ6swVNY2EdTwOY+7RnEJ+rmwjQ6Gz1uAPu7rB6Plc2VdlUeSm
   vm+krj5Zw+tsnvuIKmiUpcpd9mnPQJD2tX0hLRmJuc2AaT9cJS+/5LnxJ
   6Jeusi/4Qd5Qt3mdxWNabuTh8B+F6pgXOjHD8gvkoD38/WhiHHLZY607a
   si0s19cqitduGLClnFCs5MSAXF8Oiyk26Z4Z0DvJjDBjhpBp4DkQe+7ZW
   l/fyFHGAl4bmlIm1d00RJ5o/HyIiKgh5G9n0ZwVfJmJRccgzR5xMABHvf
   J4wFno8NqIYnTTkjfsnG0uHFtx1VUO8YmEAfEbrM76cXBWoWroyjFUfaq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="16048931"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="16048931"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 20:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="42372596"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 20:04:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 20:04:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 20:04:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 20:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj8ZQ+dpGTs1LFEt5TNYox5QgT1Rjpd331PkLdXNJr8iJBAdVOM698INXWai24tGw0XuXxQWietOArTyfsQIxYSKHQkawdpb4DP7/LrQow1tX/MvudKzR0ibdHXhLaExpDhmaVhYvjikHHnxz1zL/2RaHxiWzz7WtgHSB2aZR0rPL1X23mVCL5mOb1plsRT8fxR4T8SrCS5sVNpYQJXlDLD+zUeiMBw2PAOPcZxaBFyK5nDaKmd52WZuEbPTHd0+pqR6+VuxlsVbut0UUZeEv468mVcyuLB4YFaI043jZf9qz6v1n/bGDuT/+9Gfj+xhiNtMMQ29jGTljxnwKsTwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaS3aIGBDovugWaJxcEj75fzaTl0wMwtgUdhnc0S4zg=;
 b=PltijHd5EDM4JG1tK+8x4muu2yE+LmeRNr8H7P2Q/48FH4uk5jXmS5pw0rWWtnvfZkI5s853ns42t9I9g8c4i5YBEyLIpQDAEHLWugzWs08DJzTgXNAnfOoADn1g6eov/u+zwxIQwPeGXE8TYofbLy+P6Vpt/53WfUcO8L+Gkg35YIAD4uAxulsd8r+FXcDXEj+O/HuVNnYE64tUiri8z/VWlBNjh86L2E16rQIiaU9OnGk+xMSg/zLWGh+PdIsQZrt2/fxYeUV3zbUFXQnRGdwiipF94itVCtnWFajk+vRYNIWPByvzcU6Q9y72UjqOr3+FT9SUaJaPsTvABW4zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Tue, 12 Mar
 2024 03:04:30 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c%3]) with mapi id 15.20.7386.015; Tue, 12 Mar 2024
 03:04:30 +0000
Message-ID: <585423de-9173-4c97-b596-71e1564d8b4e@intel.com>
Date: Tue, 12 Mar 2024 11:07:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-2-yi.l.liu@intel.com>
 <20240115171950.GL734935@nvidia.com>
 <c831bf5e-f623-402d-9347-8718987d1610@intel.com>
 <BN9PR11MB52766161477C2540969C83568C242@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52766161477C2540969C83568C242@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 3549fc76-5f7f-4e7d-9572-08dc424122be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBkb11NWfmnaCHY5Hp5927mTBc6reIndL886Ei4z49GdN+7woQjiOukmsyaTq05M0bLFLQuvRQKOjbFfYwwYim3uQ1aIgHpkayqw0l792ChLJUTixhvkA+HLfHVnuoDj9b/UwF8Gz/gVtvcK1BIKJlSmng9ORwKxKwNV4W5+LqMd4zl3ZkU/iIZDicuxGhcgoY4USfihWNi9w5Eo6ksr7WSyBPSN0F8SHC5SnYTyW8MKeV+en6z95WyKrWq47A9yr9gmgLG5gPUc0qgMNfZ/FoVMCSRJ6hbg+HzYqYpxTavPo5nn9EKuPnINGgqo8IgbyhXobnZ/kVqBtGqe1nSQQ3ECMv3CFIFCXbbntGlVPJFx0FJHe/dXcyfS988/+y+TAbdPFh/FmT0AMKRJ41TgchexsddrrTIfKaUtB7ujK4T2imMvsJSdGiXMEUq5Obg+NLNvnXjpS5HFLjR7aaaL6I8yjryYyhBSFvFJlaWrZCuNWO6PdoCbQMFi3SGLBqQbUjw1Z5PYg/OCV37N8i2J6cohlf5KOP28GLndRyxIQCWlllLK8vyus9spEsGZcfMaVqJxo0C80O/IB3FQbQhKpmksNSFWiy1Cn2vowt0RCow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjhMbEsyNm9TM2tFa0dzcW1SY3I2T0g4WUwzZ1JVa1B0c2dNSmg5WHhJTW9h?=
 =?utf-8?B?V0tweWg1MWtQTUY0dWpEVHliT0hFM1ZNaGhCUWVSbTU0bytYSXhIYXcxek51?=
 =?utf-8?B?VzliZTA1bDk1UWxKdWVHaFBtaFY0cmZtSUtEcEgzaXNIUHIwNnNhUzRUcllo?=
 =?utf-8?B?N3Vta0FGMm9Yak1uL2drQmVYdW4xZWVJUlVOem10ZVNoK29PM1JqMlUyL01i?=
 =?utf-8?B?cXNXd3VaV2VmUDU2TmtERmNwaFpIajhsa2gyVEoxUGdjK0kwYkhmejUveWNh?=
 =?utf-8?B?NFJBWlp3cCt2a2hrb0FGVlZlN1BsZ1FJbmloay9aaFpSRVoxdTYzSmQ4bFdj?=
 =?utf-8?B?Z2Y2WkhJQnNaVUhlRUd3L3VSZkxPbGxYdFRlT1JyL0hlU2dBeElhSWdwZzJi?=
 =?utf-8?B?ZG9OWlVRQzB2aUQyKzBhTkZ2cGVJOS9yZTdnMEhvZjhyVFVqR0JiSmw4MzBm?=
 =?utf-8?B?Q3dBK0V6QUZXMm5iMFI0dCt5TEg5T2dnZFBBdjczMzkyTkpza2xnV3A4cFZU?=
 =?utf-8?B?a21wSnVrRUhXTG8rQytMSXE5cWxyWFY4aWwzK2YyLzJBMFJoUmh1SGJHNFh2?=
 =?utf-8?B?U1d0RGFMNmdZZnJ0WkNKZURIYTg1TGNJWVJDR1dxRlpjM0h0Y05NWlZveFMz?=
 =?utf-8?B?MXkzNWFwNDhhVVFMTWUvbnd1Q0tCekprTEpRU0I4bCtnOWdDb3MzSmJpZytE?=
 =?utf-8?B?SG5QTG1VL1BNMS9IU1VoZXdPZlRaWnlrbFhwN0E1enNXR3drWXUwak9mNmZa?=
 =?utf-8?B?VDYwQ1JoWW54V1p4anZaSDlYYTRBbXBlK1lLRXFzdmt5Rk1TQ1FGQTVaQXVX?=
 =?utf-8?B?RHViWi9FSW01Q2hUaHBhcUgzRDd2ckRmZ0Y0SWhSR1VvTllVTDROcExpRVd2?=
 =?utf-8?B?cXFzSW5TMHA2MTAwUFFFY3FSSm5wYWRHeHY2NnhPck80NGhiRFh1LzZzZTdV?=
 =?utf-8?B?RU82WG1mU0VsOHZYdVpWOEdWVklPR09UeUw4TUd6WUdIdWd5TlJOMDFiZ2g1?=
 =?utf-8?B?TVlyZzBoU0hZT1JHT2lQQ0lGK0xPQzZkYklUNzBkb09BcVdUZzhDVHljbWhR?=
 =?utf-8?B?R21TT09tQVcwdWFORGFzOXQ2dW9jR0Fxd1VSNjRNbGFYVkRiQ2hwUWtxVW8y?=
 =?utf-8?B?cXgxR1ZYZWc1TUJ1T3lpaUwxZFZsbnh5aisraWVMcjJzMTd6YXRaa0dqQllT?=
 =?utf-8?B?Z0pubW95enVZVnVLTlZNUjdkRTFZTXQzdnROU1dOdXhiU1hwQjBZWlJtS0U5?=
 =?utf-8?B?a25NWTA1enFYb0Z3RERqWGVMNlRMUkNnUzJyaDl3b1cwekpoQU9McEFnS2Nk?=
 =?utf-8?B?QmpXMlN0YjIvS0xjN1pqOFNXckdMVHplcFJsdFpvNDJqVG9xcGo4ankvc2gr?=
 =?utf-8?B?UUlPVDQwVGhRNnhoMkVUbDZ1WVFXSm5CMzhzbGJOUzVIYnpLTjVsNU5BVFRi?=
 =?utf-8?B?WkJnQUxzekZza1oreWxkSUFPYW1DR2F0dkY4b1pMb3B1cmZPRGRUZG1ncDJX?=
 =?utf-8?B?VHprcGpRRlY0UHUzVGVvdmJabnZpRlJ2VEZoZmtPTXltaUpTVXRtM01Ga3hv?=
 =?utf-8?B?cThYN2dEY05JYjlIVytSS2JJeStZT3VQUDUwc0pUTEdPeFpSUURiOW5nc28v?=
 =?utf-8?B?UUcwL1JpRHNGSmY3MUZSVzhMaStzNHk2RGhieUVJMDQrQkNjRUlXWnpMQzZU?=
 =?utf-8?B?Z1YwcUFicnBMQllOVEo5Unc1ZWJoS0dBZlFabWRyejYwcnNIT29ySlJxYWZl?=
 =?utf-8?B?THpiNUJSeXFhenZRNzJlTGZ4RDFKVXBGTSt6V1JIN0hKcTJTajhXTTJoaFZC?=
 =?utf-8?B?ZHcvajZRcitCVGd2b2pZL1pnOTgySTEzempWYUd1Q0N6STFuOW5CMXg0WkV6?=
 =?utf-8?B?cVNsUUxDc2hxS1RqMWx0cFd5TmY2NVdsT2VOa1lYWEJJMFByVVlheXBFaVJH?=
 =?utf-8?B?YnVPdDdrejBMZXZuYSs2aGNPYkQ4NnRSR21hcHlHeW5US3F3dVRpNVZ6c2xq?=
 =?utf-8?B?SDhNSzc3L0UvS1J5ZERTU2JraTc2aVVGaUVwemllcGVWbzlaN0JIdmZISWlz?=
 =?utf-8?B?UFRXUjk3UlJsMDZ1Yk1ZYUsreDlqN0k3dmVkM1B6OFB2SzFnN243d2tVQndn?=
 =?utf-8?Q?lOm9eORvT5+SjSzFZq7ccO4Dm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3549fc76-5f7f-4e7d-9572-08dc424122be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 03:04:30.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTq+jviutkJO3V5ybtjVCraC0lhrVgIwe9P1fSFk3qeF+4x+naeQt3Oq6xwmBac4GA2mK1VOS2kFVNI3IpGrLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557
X-OriginatorOrg: intel.com

On 2024/3/11 17:26, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Sunday, March 10, 2024 9:06 PM
>>
>> On 2024/1/16 01:19, Jason Gunthorpe wrote:
>>> On Sun, Nov 26, 2023 at 10:34:21PM -0800, Yi Liu wrote:
>>>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>>>> +			       struct device *dev, ioasid_t pasid)
>>>> +{
>>>> +	struct iommu_group *group = dev->iommu_group;
>>>> +	struct iommu_domain *old_domain;
>>>> +	int ret;
>>>> +
>>>> +	if (!domain)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (!group)
>>>> +		return -ENODEV;
>>>> +
>>>> +	mutex_lock(&group->mutex);
>>>> +	__iommu_remove_group_pasid(group, pasid);
>>>
>>> It is not replace if you do remove first.
>>>
>>> Replace must just call set_dev_pasid and nothing much else..
>>
>> Seems uneasy to do it so far. The VT-d driver needs to get the old domain
>> first in order to do replacement. However, VT-d driver does not track the
>> attached domains of pasids. It gets domain of a pasid
>> by iommu_get_domain_for_dev_pasid(). Like
>> intel_iommu_remove_dev_pasid)
>> in link [1]. While the iommu layer exchanges the domain in the
>> group->pasid_array before calling into VT-d driver. So when calling into
>> VT-d driver, the domain got by iommu_get_domain_for_dev_pasid() is
>> already
>> the new domain. To solve it, we may need to let VT-d driver have its
>> own tracking on the domains. How about your thoughts? @Jason, @Kevin,
>> @Baoplu?
>>
>> [1]
>> https://github.com/torvalds/linux/blob/master/drivers/iommu/intel/iommu
>> .c#L4621C19-L4621C20
>>
> 
> Jason's point was that the core helper should directly call set_dev_pasid
> and underlying iommu driver decides whether atomic replacement
> can be implemented inside the callback. If you first remove in the core
> then one can never implement a replace semantics.

yeah, I got Jason's point. I'm raising an open to make the set_dev_pasid
callback to handle domain replacement. The existing intel iommu driver
does not track attached domains for pasid. But it's needed to know the
attached domain of a pasid and find the dev_pasid under the domain, hence
be able to clean up the old attachment and do the new attachment. Existing
code cannot work as I mentioned above. The group->pasid_xarray is updated
before calling set_dev_pasid callback. This means the underlying iommu
driver cannot get the old domain in the set_dev_pasid callback by the
iommu_get_domain_for_dev_pasid() helper.

As above, I'm considering the possibility to track attached domains for
pasid by an xarray in the struct device_domain_info. Hence, intel iommu
driver could store/retrieve attached domain for pasids. If it's
replacement, the set_dev_pasid callback could find the attached domain and
the dev_pasid instance in the domain. Then be able to do detach and clean
up the tracking structures (e.g. dev_pasid).

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e58263dcfadd..03a847a406e1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4398,6 +4398,7 @@ static struct iommu_device 
*intel_iommu_probe_device(struct device *dev)

  	info->dev = dev;
  	info->iommu = iommu;
+	xa_init(&info->pasid_array);
  	if (dev_is_pci(dev)) {
  		if (ecap_dev_iotlb_support(iommu->ecap) &&
  		    pci_ats_supported(pdev) &&
@@ -4464,6 +4465,7 @@ static void intel_iommu_release_device(struct device 
*dev)
  	mutex_unlock(&iommu->iopf_lock);
  	dmar_remove_one_dev_info(dev);
  	intel_pasid_free_table(dev);
+	WARN_ON(!xa_empty(&info->pasid_array));
  	intel_iommu_debugfs_remove_dev(info);
  	kfree(info);
  	set_dma_ops(dev, NULL);
@@ -4707,7 +4709,13 @@ static int intel_iommu_iotlb_sync_map(struct 
iommu_domain *domain,
  	return 0;
  }

-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+/*
+ * Clear the pasid table entries so that all DMA requests with specific
+ * PASID from the device are blocked. If the page table has been set, clean
+ * up the data structures.
+ */
+static void device_pasid_block_translation(struct device *dev, ioasid_t pasid,
+					   bool remove)
  {
  	struct device_domain_info *info = dev_iommu_priv_get(dev);
  	struct dev_pasid_info *curr, *dev_pasid = NULL;
@@ -4716,9 +4724,11 @@ static void intel_iommu_remove_dev_pasid(struct 
device *dev, ioasid_t pasid)
  	struct iommu_domain *domain;
  	unsigned long flags;

-	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
-	if (WARN_ON_ONCE(!domain))
+	domain = xa_erase(&info->pasid_array, pasid);
+	if (!domain) {
+		WARN_ON_ONCE(remove);
  		return;
+	}

  	/*
  	 * The SVA implementation needs to handle its own stuffs like the mm
@@ -4753,6 +4763,11 @@ static void intel_iommu_remove_dev_pasid(struct 
device *dev, ioasid_t pasid)
  	intel_drain_pasid_prq(dev, pasid);
  }

+static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	device_pasid_block_translation(dev, pasid, true);
+}
+
  static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
  				     struct device *dev, ioasid_t pasid)
  {
@@ -4772,6 +4787,9 @@ static int intel_iommu_set_dev_pasid(struct 
iommu_domain *domain,
  	if (context_copied(iommu, info->bus, info->devfn))
  		return -EBUSY;

+	/* Try to block translation if it already has */
+	device_pasid_block_translation(dev, pasid, false);
+
  	ret = prepare_domain_attach_device(domain, dev);
  	if (ret)
  		return ret;
@@ -4801,6 +4819,8 @@ static int intel_iommu_set_dev_pasid(struct 
iommu_domain *domain,
  	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
  	spin_unlock_irqrestore(&dmar_domain->lock, flags);

+	xa_store(&info->pasid_array, pasid, dmar_domain, GFP_KERNEL);
+
  	if (domain->type & __IOMMU_DOMAIN_PAGING)
  		intel_iommu_debugfs_create_dev_pasid(dev_pasid);

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 94e2ecc3c73f..a466555f61fe 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -767,6 +767,7 @@ struct device_domain_info {
  #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
  	struct dentry *debugfs_dentry; /* pointer to device directory dentry */
  #endif
+	struct xarray pasid_array; /* Attached domains per PASID */
  };

  struct dev_pasid_info {

-- 
Regards,
Yi Liu

