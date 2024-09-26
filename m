Return-Path: <linux-kselftest+bounces-18384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD809986F1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 10:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865DD28B0AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85E1A38E6;
	Thu, 26 Sep 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBHRyIWF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4385588B;
	Thu, 26 Sep 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340159; cv=fail; b=Q4mzFGtg9fggOJEN3w1dQHQQzEozicgxyEXjuQT2HxhsGc1ISDmYXCiaqYg478S5bf368Iev1aKPqlKsrHBzonTTRyS6/RVxHZGcffFINrPi/MnlHKX290jlDtNzLtC+yrH3kfvzjyOmNPM/rOCuvxEdQEK+LMJ6JwH7kMhY1pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340159; c=relaxed/simple;
	bh=xuMwouY9DGGCbeY5FIFPK8Q8fO7S3p13PYMB9MsI4M8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmnPWz3T4NkUeNk8gzGwy4yfZ+BnB6xv96hRCWsvKJZocAQiDPv8OI6GQvKh9DIHodMjk99cNPB5bT0/+FZbf/02LUbOMmhfFAqqlFTicNRsz+N7jHwLXTiwTlHa2bdCLvKZJERjadh+ziGlQf45M3ID3GXfPDsbRhfsehrMtT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBHRyIWF; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727340158; x=1758876158;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xuMwouY9DGGCbeY5FIFPK8Q8fO7S3p13PYMB9MsI4M8=;
  b=UBHRyIWFr4beAS5jboE6aSclmMDUITs46oo6Woy6KkKpcxa7TrWtg++k
   KcwGovnGG1yWc0oT1tREWopLiDviRa+XY9ONqbaZ2eOv85MPPY8g+Uu6S
   7W8262px/pcgppjQ6JFj2yxbadSPwZ7UEdw3t4IxywJyDTrY/KuE/2+TP
   yCZl63Xuv4s13O+T5tsnZiSWRbqSlQiisypnCf6VSbfUcKGjW75k09COs
   MR5arAtZI7w0T3DkxVLg5aEsdFN0jptRNwtnpVxunwDWglGQpjDMa+WMG
   m1tzTRKVAob6KQxzxr7lpS528ACtOVq98ZBq1sZL1ZdL5lyBKsRsUVCmS
   g==;
X-CSE-ConnectionGUID: xdEXlcRLR2O/M9WPR1tgUA==
X-CSE-MsgGUID: Fc5jgb8LRuy1XKvzBYzpcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26575222"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="26575222"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 01:42:35 -0700
X-CSE-ConnectionGUID: U3VsR5tVQhuM8HB1YCGRSA==
X-CSE-MsgGUID: onwL+tChTYeJY2KWOC7ftw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="72206224"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 01:42:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 01:42:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 01:42:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 01:42:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 01:42:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLfUtTjKgIgHDswkQsdihzG0ITy40s+UiiS0dwRk3dLfNyvqgeGOjjj9RewLWWZnWCZ/2sUGsTJYyBezgULBSnXz7t9YJ2/KHYgzOoJAU1z9+b2Vw/RPzzHo5GnLNib3ZdyBA8fQpgRPudPXWBTeAh9omMeufuX7YrweNrAY0H/+dWZOvtYRNpwT4TtKqEPaolP8XvqVWW++nL0Df5tnofKLKUUgmeS1BvhyVN35MYX7/Q+SCQuMUowXTfg4HCpFOuNrJnkVh6gwdjOEXmvOBEah7cXXAzJjj3x9LYJ0nJWb/wl47aaj2P7BITNckga10PNgHtmS7yrc7kZVqUsCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CSO6l/J8sjdArkRWiNFqxt1pbKTBCDWLfgafekdPV0=;
 b=ZfwPvgCC9p9E/6KM0jT/DDtEAsKwwD3TNsF/HLkd12VaMSV16jXknPjCXNV9DCtfTLeBLu5kT0dXJvcWeylrmcCcWExJq7HN7JNNv5D0f7DL+sLckTfAFifdua6Ww7q7PwzeyxuMIg//X58c2MgRx/zQuefbja079uN2V0zuBEZNR7geAwgkOU/axDvziRbId3y2CCSiyNCkbbyK0Dr6JnnP2lT1/P03SIfmvpu9HMwDWwH1PWXbHbXsqtt1Iw/KVuj7Yoyoqr4lV43HjtBMQMgiZVoHM4nj5adBpNwFWcrrPthZ90vn+QhXdcTXiNMQ2VuYA73nPH4r53lb8mIrdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6673.namprd11.prod.outlook.com (2603:10b6:510:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 08:42:31 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 08:42:31 +0000
Message-ID: <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
Date: Thu, 26 Sep 2024 16:47:02 +0800
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
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f8a88b-01f3-4993-5187-08dcde07290b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzV4Q3IyVzdmMTlTaHJXQmxJMmpaWDBlbFAzaHEySngwS21rUVlZRzV6RWI1?=
 =?utf-8?B?UzFpS3pEek9qTm5tWTh0VGFSeDZrODd5TEIwd1VEVHZHY0U5MC9oYVFWZFFT?=
 =?utf-8?B?cEV3bDlqL2xZUlBlT2tsSFpGZllXY2NKQjgxdFpiNkdpbk5TZktwd0FYYWU1?=
 =?utf-8?B?VGQ0bUJVak9ZSXd1c1RKaC9tb3FkN3JYOVZMS3FtbTRkRUxUUkI3VTVhRWRR?=
 =?utf-8?B?Z1N4ZHJNTWI1aWorMmtoWFhtdGxpY3U2STNBVjdUQ05nTjBvNmlWZW9KVWk3?=
 =?utf-8?B?cE5XeHNpY1F3TWJjVHk5TFpRUHQ4bklVYUdjK1htZnRGcWR6Q0pWSW5SUVNN?=
 =?utf-8?B?WllQTVZVWjVnWEQ4WGMvMkFzdnZ5UGJCNWhXcmpUOThJc0s4L1VEVnBWRDdI?=
 =?utf-8?B?eXdrem0xQks0Tnc4ZE9YWEZOYUF0ZG5NQXVLSHJsZmcxNU5UdWFxS0k1WjFU?=
 =?utf-8?B?N0h4aGQ3c3g5V3RXRHJMclplekRxODA3SUF3ME43aE1pR1dXelBVWThrYmMz?=
 =?utf-8?B?bjBqcTVMWisxNm82UXhvSTYyT2EzenNSL3pDa2tPWlk1ZW5iOG9DNG9rU09W?=
 =?utf-8?B?STlDTWtyRHRxS1hSKzNpKytCOUFwNFpvZVBwTk80UEpnUDZIeHRpWEZwMGxp?=
 =?utf-8?B?czZmbnRUUHBzWUkyeWkzWVltUW5CUTVNUkgvSTBVeVdqYW40ak4zY05BQzdD?=
 =?utf-8?B?eTlNMHRSZldNeDg1eVJuU2RPUHFyZHRibDdpMTViT3Q0d0NlYmFSQjFpL2lL?=
 =?utf-8?B?ZC9XaHh5UzVBV3AwbEg3RkxoOTZ0OWhpL3o3dHBYaGRENVZ3Um93bGFhZXhv?=
 =?utf-8?B?enR2THZDenlpY2FKMjRya2ZDZUo1dktaa1lIeU01KzF4WU9LQ0t0OTNaSmdw?=
 =?utf-8?B?WmpET0JsWDZRVjRIVHVvWjI1dnlVV2ZHdnZmMjFmVGdGdVJIYXJRSzRBVmla?=
 =?utf-8?B?aGU4UHlaeUQzd2Uwck9CeGVsUGdETUhNRWx4Y2VLdFJ1ZTduSm9HOXZzMGRj?=
 =?utf-8?B?Y2RxemtpRW1iTGtOVEgyejV0UmR6TEJPNzdNUnpyVjdBTFVZNHo2ZUFxRjhL?=
 =?utf-8?B?clErZ3VDdUplbzEyd1BVeDNIQTVRNmp5ZEkyR3lOUjNSZGZ5VkdMNnNzVTdn?=
 =?utf-8?B?NGQvTk9DQmZlT2lJT0NiemtxQ3FPZkFkY2psRVQ0cXJwbzhZOEVxUnFTRWRD?=
 =?utf-8?B?TFZqZCszWmpDdzFvUXQvMmgvN09CQzNUU2FXQ09nZWVJbWI2QlVjK1ZUaU9o?=
 =?utf-8?B?SXd0MjBpZmNMWForcTlKdzYybmpvRHNOYk5OYU54NmhyY1lrN2F1dStzUjVQ?=
 =?utf-8?B?QVpRK2hndUI2K3JaTXU2TEUzUHY2RTVqMkkwQlJ0dkFqWVd3QzliMzBYcGRZ?=
 =?utf-8?B?QmhRMUJuQTRGaXFPa0llRjQ4d1JDSmZFWmcwUm5nMmk3WTNqZUt2TXg2SkVS?=
 =?utf-8?B?NVpyWFlUK0g4T2hPQ0UwbDJLVnNLd1Z6c1ZLd0ZXaXRDVG5xYXBkNFgyVzl5?=
 =?utf-8?B?cm5Yb2VnT2ZGT1RqMUUySGs4aUNXQTJBRXllSnYwMFlOSW95cnFDekFDb0hJ?=
 =?utf-8?B?SFlPNEFKTGluRnVBcERkaGxsdnVzVlg5V0g3dFlGWmZLUkRmZ292WUo5b3hX?=
 =?utf-8?B?dGlwaTE5VlB6WGwrR0pkQWFZRWpMNE9KdlhOdkRJRVN0NUlYWE5TK1VyL1JB?=
 =?utf-8?B?Rm5aNEJvTGs2V0l2Qm5WQWRuVHdWWDJYbHJOV2tMQ2JpMGtYalZ1a1RUdTZS?=
 =?utf-8?B?TEYxWXR3NzdmcTNOL2FCQjc5bG5CdzhhdWNOaUExZmZKOVdMMXllbVZ0Y0F2?=
 =?utf-8?B?YmNyS3gyME1DWHR2TWZ3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGtPVE4rWDVNdHcwanR1TFhCS0d1anlVSlB5Vy8wemU1R1g2b3ZFT2R2dnhQ?=
 =?utf-8?B?TTcrclJKekhnVVBVTEdtbllJeGVpVVRMcTI0Smt3dkkvSjF6YWxmeTJtN2Zw?=
 =?utf-8?B?WXR2c2RXeHdWK0tjK0lGeW9LZzRTWmV3Zmg4ZUF0V0VNcENBWXlHTFVTN2tG?=
 =?utf-8?B?SllIQW1Yc3Z5N3RzK0ZjN2lvb3FoV1o0U3U5Rk4yZGpHaHlnUXlXMWYyMHRG?=
 =?utf-8?B?Z2NqK3E4ek4xcmFVT20zSUVnSit1YnAzTjNIRXAzdmo4SENiTUNSclhqb3R6?=
 =?utf-8?B?WndkQVZORkNCd3dWR2JtRGNlMHg1QTJFbERwRFkxWDBNUnBKSVpvdkRTWVJu?=
 =?utf-8?B?SFJHQ1gzSExvayt5aWZuMkthamw0aFBYRzQ5U2ppTUNRNHM0YUdwd0RDRXdr?=
 =?utf-8?B?Qi93OHA5aGFGYnJyYmpoelZEcXpUY0dOMnRsOFprZ2dTOUYvVTAzNUVNR2Er?=
 =?utf-8?B?MXNBNGFEdndraDNrcTVPS3llNXdGVEJ1MmJmYi9velRxcEk0V0pkWnFjMWFo?=
 =?utf-8?B?Zk9sK1FhTjMrM29ROUNqMkpLSkJWaWFha3JTKzNReHF2MU05UTlETldvZlow?=
 =?utf-8?B?T2U4ZVhrS2FPRG1sQ1hPSSt3K2o4ZmtMZ2oraXlqQzdiMm41VVd0b1Rpbmlk?=
 =?utf-8?B?Qnprb1QxcDU3ektJS0t5a1NLRnNTTkVEUkNnYW4wNm1XYUYxZjVLSmdudW42?=
 =?utf-8?B?NnMxZkxRZmtqaXUwdFBFYWdQc2xrQ1QrUXlVUUxDMTZGNFc1ZE5qemNscGdo?=
 =?utf-8?B?OVpoeUl1WC8vd3YxYzVnUS9kb2VlNGdwTDFjZm5wOHd6QitySC9KaSsrVm9h?=
 =?utf-8?B?V0xEa0xUaS94b1RYTVoxUURnaExaRXhBVUdnb0Y1bFNkV0NUY0hGMVNtZTcz?=
 =?utf-8?B?SmpxcTE2N2JHOEQ2ZTRiWGhXOVB4czA2My9WT0xVTVFjTkhUL3B2R052MTlp?=
 =?utf-8?B?N1h6WjhtMVBRMy90YkdtNjdVRTlUUUVzNG5mbWs5MThwVndaZUZYcmR0YWJq?=
 =?utf-8?B?OTJmeExvRklxd1hZTGlPNlQrZ0pwQVV6bXdOS01PUG0rdjJmSW5GZUMyNG9I?=
 =?utf-8?B?d0RCOWNIOGxuN3pqTFo1dElLN09XMzRmUlArM2Q4NVk0NGppWVRrcFl2RXoz?=
 =?utf-8?B?RVgzUEtrME1HcEFrOW5TRGc1ZGJjc2h3UkxOYkZaUkYzSldmL0k0UUhNSy8v?=
 =?utf-8?B?Nzh4R0NjS01qVlFjT1VCNWhEbkIvWTFiWkJreWE2K2ZVTkJWWWFVQVFWeGFZ?=
 =?utf-8?B?RUE4NnhBZkRqaFBOanN6c1pDMldwZ2x4d002ZmQ4cnlqd1I5Z3VrallGbWs4?=
 =?utf-8?B?M0FuNk13WWRkcGU2VjUyNkNHSHBGMlBRK2N4dWxCa08vc2ZPZ2VaVnhEQU5i?=
 =?utf-8?B?aEVoSFo2dlNlS1RmRWUvNG5GYVlieWUvQmhoamNaSDRsZ2lBSU1rOG5pajJm?=
 =?utf-8?B?WlZ4eUVyY0RIZmMzcklBL2t1ODZvWE5KMXN3cjhOU2JBSVBTMUU4ZmZkR1Nr?=
 =?utf-8?B?L05YRU1hUUtTMEg3eGpoNkFwbWE2MUFkY1UrWFlRTnAxaURUenRqZ2VPaUli?=
 =?utf-8?B?Y2RpQWhjY1Z3SHAvWU82bDhEaTFESGhQZ1NYR2trSStyM2EwamdrT3N0N2Zs?=
 =?utf-8?B?ckZYT29BODFJNVR0SUZwR1dablB4cklUY0F5SnVaNzJZbzN2c0lNWEIranFU?=
 =?utf-8?B?Q29odk5KV3FQZU45K1V1UFVsYitWUnJ2QlVuK2F0RzNnc0c2b0hBdnk2cDlq?=
 =?utf-8?B?dEdQVTR6T1RMVDl0SktpMVcxbmJ2b1djREtHWHJ0czJLOHJkZnBZNDRlVSt2?=
 =?utf-8?B?UHdPTGc1OExIVUZwak1lWTFCOWFtMVV1MkZlTWN6N2JTRjdoVU9pWHRUenhW?=
 =?utf-8?B?cGdKT3lyc3NYQ21mQWFTQ1N4Y0VyY3FmRmlRSEMyN2VLYXp0ZlVWZzg1QTQw?=
 =?utf-8?B?d0thclZYaUhQKytUZG56Yytya0kzKzdaK2ZMT0xvV2lZUlI2RWxmS1dGejhi?=
 =?utf-8?B?d3IvYWpWVEorWGVLWkdHVG1TTERyaUk4blNWVnJKZkRRQUZzcHVDb0pxTmNn?=
 =?utf-8?B?ZW9TVE1lMHI3ZFFETDc0TjFrNUxqTWVBSzVFWDNKN3hMcjA3SzY1MTZuY3BO?=
 =?utf-8?Q?e5Btj3QW7W3xe5p6F06IAEU91?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f8a88b-01f3-4993-5187-08dcde07290b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 08:42:31.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+5XSQgkEJ0bi2AbpcE7yGGDjPYVFuDEKpp+XfPwRlohduaiOtOCEhFn7xzwjXbtWhKTnPFxFUH2RPoFIGflCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6673
X-OriginatorOrg: intel.com

On 2024/9/26 02:55, Nicolin Chen wrote:
> On Wed, Sep 25, 2024 at 06:30:20PM +0800, Yi Liu wrote:
>> Hi Nic,
>>
>> On 2024/8/28 00:59, Nicolin Chen wrote:
>>> This series introduces a new VIOMMU infrastructure and related ioctls.
>>>
>>> IOMMUFD has been using the HWPT infrastructure for all cases, including a
>>> nested IO page table support. Yet, there're limitations for an HWPT-based
>>> structure to support some advanced HW-accelerated features, such as CMDQV
>>> on NVIDIA Grace, and HW-accelerated vIOMMU on AMD. Even for a multi-IOMMU
>>> environment, it is not straightforward for nested HWPTs to share the same
>>> parent HWPT (stage-2 IO pagetable), with the HWPT infrastructure alone.
>>
>> could you elaborate a bit for the last sentence in the above paragraph?
> 
> Stage-2 HWPT/domain on ARM holds a VMID. If we share the parent
> domain across IOMMU instances, we'd have to make sure that VMID
> is available on all IOMMU instances. There comes the limitation
> and potential resource starving, so not ideal.

got it.

> Baolu told me that Intel may have the same: different domain IDs
> on different IOMMUs; multiple IOMMU instances on one chip:
> https://lore.kernel.org/linux-iommu/cf4fe15c-8bcb-4132-a1fd-b2c8ddf2731b@linux.intel.com/
> So, I think we are having the same situation here.

yes, it's called iommu unit or dmar. A typical Intel server can have
multiple iommu units. But like Baolu mentioned in that thread, the intel
iommu driver maintains separate domain ID spaces for iommu units, which
means a given iommu domain has different DIDs when associated with
different iommu units. So intel side is not suffering from this so far.

> Adding another vIOMMU wrapper on the other hand can allow us to
> allocate different VMIDs/DIDs for different IOMMUs.

that looks like to generalize the association of the iommu domain and the
iommu units?

-- 
Regards,
Yi Liu

