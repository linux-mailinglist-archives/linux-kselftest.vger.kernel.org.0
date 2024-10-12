Return-Path: <linux-kselftest+bounces-19588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3D799B0D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 06:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EECC1F22E4A
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 04:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4848712C499;
	Sat, 12 Oct 2024 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXj56KWI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE542069
	for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728707231; cv=fail; b=pNKVkflsgcRX6gJPPhm7dHO7u5kYkAmuB8SwofWacetK/GuyIYzeGbi6HfDBS75feIluCt7MG9Al/yV3DF4WjaK3LfXGfZam15dcrIkAJYjp0Vc/RxL3795CZyH4XsJc5KKJI+mxZ8xcaekTXWGfxumU2SK8ik4ZNT+dGo64fso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728707231; c=relaxed/simple;
	bh=RKidOfm3Pd8ZduiRRtRGTwA7uF9fuDmctMNmAg81z94=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c53gXPcrJnLBlDr1/XAxkII1rKjwf4P7ewWSMMfEj1bNi+Wp9a5ReRhERZ8+ONjB5U12SQKoaYFQZ/2frSMUVAbhNy9FBIsPEYjxwFyPy1H9UUj+K4MGyqa+a1B0f4SDzoRDyHJSijeqcXtW9fck9fuVJigKGdIx+FmITrrhzCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXj56KWI; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728707229; x=1760243229;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RKidOfm3Pd8ZduiRRtRGTwA7uF9fuDmctMNmAg81z94=;
  b=HXj56KWI6NAihP2xjLohGWj7R6LtB41VNnYGpRr0Oi2Hojmld/72/4y6
   EwBTBGZd0gadtWNX7LCVwjyXS17x96jCnN5TySReWvJ/ST2JkhCRHYhnZ
   t0or4c/GnoZePvIVw8fT03ZboM2xZWjU0UCNGmcyxqcIOeKr+2R4glaeh
   T/Ed1l83PbUY+o6nMz/I26j2nR8cGif5ieBEdoqmOoZ8RmAebKJRd/9ib
   eECePWplc8WonLjONPPUQJmDhRhDs5iExCuLnLO2s1OUR6rXH++UjHRdU
   87K/JOXI7DodYKn3IFHuiNnb6tyQsuF9TotX+JsLxkCIDonmvJkOkjOtO
   Q==;
X-CSE-ConnectionGUID: LOOTk6fKQs2uHrbmWZxwKQ==
X-CSE-MsgGUID: 2BL6WA3USCy/2sgxpMvLow==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45624839"
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="45624839"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 21:27:09 -0700
X-CSE-ConnectionGUID: US+BwwetSLiuob7XxqyPnA==
X-CSE-MsgGUID: RGZ6UkeuTTyiHV0a8OOkKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="81870756"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 21:27:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 21:27:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 21:27:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 21:27:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 21:27:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvwOQY5AG9s4WiQGupvifXT+NEqK0zjEaZbh7Y2cVHEAoTxvM3MVJkH51NZ+94sxPVyKCaf00DlZcbxsvJjg6haDPnYVrOYMmFyF/6OhF1DR21xrDWpHb1WmGHCLLqfyYs9EId+lVv4EsJhsCgMT7h1hQ9Iudf5zLLqVQ4ATrei+T4FyQjIUQjdi3LF4YFa0cjn5cDBDJaP0N6CEbH/G2xJFZU7YZdVOFnEFCnhiPLEZ0vQNZjXK51TXuxfGJWRJvnX45KDr2sul/GP5F9bqzeOmbsyAOt3seB+h98GVUZSru/u7swfuxqaRDw+RCF+6uuQwHKO09rIvSx2HDk/x9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXz47/41wPStgZegdUh5bJXrtYl1MgubkU8stsTvctA=;
 b=yyymQ6hxGYWl4sHHlkpkq7H5Obg+xf5MvNKL9JSXP7RAaua6ACe5sjoTc3+tY/6bUyx02NooJPANeTVWDyW9rqiuBU5gF12Y6P8/yG5NVE9uH7WgBQZE/ipJm6fXB88bBDGfK55Gz8PmnblkvRMbKHYhgyuJznDy8KMUPGvVKzUqKBB910gy936pVVqtus9HofC0QWXBzzzpRv9IS9d3zAdOoTmY4wKcCEjCkx9tqNlI1LLWcJ3bDOqe6KPuT2EwMbX/hVdL32oSLlH3o4g8W0fDdM1L4t81/kutiD2vYxp4A7OG535XYWqDzH2qLGlPs0/Gv9/U3EqC0gaQ3TvaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6431.namprd11.prod.outlook.com (2603:10b6:8:b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.22; Sat, 12 Oct 2024 04:27:05 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 04:27:05 +0000
Message-ID: <9aa131e8-c58c-455a-922a-721ee1f74ef1@intel.com>
Date: Sat, 12 Oct 2024 12:31:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] iommu: Introduce a replace API for device pasid
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
 <20240912131255.13305-2-yi.l.liu@intel.com>
 <BN9PR11MB5276B0F09778D03BDBD7FC768C762@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276B0F09778D03BDBD7FC768C762@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0041.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::29) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edec1ce-b731-47e7-0ad0-08dcea762042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REwvT0ZsV1ZDTStaZS9VMGdJUkR3ZFRhUGQydzkvMHp1RHExV1NCRHJjM3dI?=
 =?utf-8?B?WXBYQjIvKzJ0NlgzYXc0djd2U3Nhb042OER4SSt3ci9mbDNkZWtJVWNKV0I3?=
 =?utf-8?B?VUhrY0s0OS8rYXZONFlreHBqaDBPSk91c05SYjVnUUlOSThOTmRKUHgyUE5a?=
 =?utf-8?B?aW8wa2Y3TGZESURqa2pqNEZhZHRLb3hyYUk2eTIzaFk1b0lZenRtRUk5VS80?=
 =?utf-8?B?b0xoWTM4UFV0ZWN4ZFlFTXhvdnc0S1UzRHNCZFlKY0REY0JuQ0NmUTJMZlBj?=
 =?utf-8?B?VEc5Zi9VU0pLK3lFSjY3YXZUR0d6N044S2JVQW92MFFnQmVpWG9hQWRlakIx?=
 =?utf-8?B?UkZJL3JuRXlnSmdzaHdhUFlRS3dRaUpORDJQNDV6aXlEK1UzMEEyRHVMYkJn?=
 =?utf-8?B?UEhqNjFheThNSHhIWHNqNjl0d0hrejlpZWx6dnVab042RW5yWm5pMVFiNFJU?=
 =?utf-8?B?RnM2Q0FFR1ZhWThGY1VDSGl1ZTMvbllKL3RZWmlURVBLSVpjQmRUMTFGbXlJ?=
 =?utf-8?B?YUxiTXByR2J6d0xwV0NhUnpDV011Mks0aldwOVR6ckM2Qmd4Rm9QTWlpamdE?=
 =?utf-8?B?dExCVS91RVlrYlhVNEVvTEVFTEE0NnNjOTlHcmN6WWdscnJpdTJsL21BVVRK?=
 =?utf-8?B?dlQ0UU1lWmI3dHpNYzNoVC8zSk1HWmk2a2Y4dHllbnczVXJvaktiTktFT0ZP?=
 =?utf-8?B?bVN2eEJUNWhtUmpzTFBDdkp4d0Y0QlRNQXlEaUhQNkx2ZWNPVm0xSmFEaG1S?=
 =?utf-8?B?b1ZpNE55aTlLUVVKb0FoMXY4MUpCZzRQY3Z1VDFVbkplQU9kamlraUFLbkxL?=
 =?utf-8?B?RWU1QXZtU2d4UzRvanRRa1AvbUZzZlF5ODJmVXY5WU1VSDJFdnFhTEtaQSs4?=
 =?utf-8?B?d29KaXJPU3NoazZiTFY2OU9hd1pXQUlFVlNDQkl1YURPazNRYU83SXZML2l3?=
 =?utf-8?B?YlNhSDg4T1hhU2tNOGM2YTFZeWlQaDZNRzErSGpoTlVBMGtJc21KbDR6OFRu?=
 =?utf-8?B?ZWQwRXRnWFB5YlNacVphNGQ1eVRNdnVneTlmT0JSUkxUTWJqUDFRTDdqdkhO?=
 =?utf-8?B?RTVtK1d3ejdVQitBYzBLSUsyQVJoR0N5QTM5aXY3Qk1ZUkZybjZueVZ5azR6?=
 =?utf-8?B?WmpQWmJvOTNCcmFEbXdkRjdzK0w0bE5wcENJNVVXMEY2RytSWDk4YW92K0pE?=
 =?utf-8?B?NVlKNllQbytoeTl4emtKTDVOM0RSR2F1aUttVyt4bHFqMFk2Wm9pcUJmRWEw?=
 =?utf-8?B?cHdxdGh1Zmp0eFpHMHg1R05lMGpJd05pejNuSWVPM2Y4WUZ1dXdlNmpaSnNC?=
 =?utf-8?B?ays1OVE0NVhRMGVST3RVMFJrbmZac1ZRR2pxM2pKZEtYWEdEbUp5dVJSNG8v?=
 =?utf-8?B?eCtjQjlXWmc2WlRHc2NTMk52MVNudVZocE5aQkpnWEd4S3hsT2pockFabnV0?=
 =?utf-8?B?emZpanViWTI5bE5yK2gzempJY1ptRDlZeGdLZWxGeWxxZ0tTMmVyVHVlQURI?=
 =?utf-8?B?cFpqandueUw0WVN2N3FYOTJsYXh0UUM5aVY3T3Zwb1ZJU0FUQ2VlV1RSTmhP?=
 =?utf-8?B?cFRLakNQYWpvQTFjcmdYSThoM2VhYUJqcVUvakNHVDcybEdWUFBNMHhmMzJ4?=
 =?utf-8?B?UVBGa00zTjBZc3hQK08wS0Q0OTdZeG0rZmtoMU00MjVPU3dmK2RwTnhFUVFX?=
 =?utf-8?B?TyszaU9xUGd3OS9hbXl3QTVwOUdqNXcwT0lHMlB5WGcweU9McHFlYzZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzNleVpKZlVBQkdvYXp0WEt6aHp1QnlPWDU5d0RFRUpMQndlSzVXSHRaSzJD?=
 =?utf-8?B?WGRGaVVwZW93VVpURCtLTS9YenhsQnZpcFdIRXFWYUtXTmxWL3ppTzlQdkFx?=
 =?utf-8?B?VnZaQjhXNFNSQUZuTXVObmFIM3ZmUjRrbE5NNHBnWmZsTFovNGJ5NVhzdzN4?=
 =?utf-8?B?cEZ6YUVYckFTNUdlbzlWcXRDTGttWUNhbHl4VllIRUdHTzQ1c0dRcGlBajZ5?=
 =?utf-8?B?WjJZNGY0ZENlMzRSaG41N25Eclgycm1JZ1BMcGJLbzBLenU5OElNT1JialdR?=
 =?utf-8?B?bkNZcEp3SDd0aVlUckxCcmNLRHM3aUZQQTFYcjNqaWlFNHFqVllNeVBBV1kw?=
 =?utf-8?B?blpTTjhHbkxOaEMyOXpWYnBwTUttdGx4bzZ0aC9wODlCR0x2ZVdXd3lrNytQ?=
 =?utf-8?B?dWNOSzRxYllTdFBTM1FqbEIyMTBRQ0FDUk9WcFFLY01teU1OUlZ0bXl3QVVp?=
 =?utf-8?B?cUZoR0J5eHVWZm04L0wwbnplV0tQNndyUkFiaTNSeWQwMG4xWm1sb0wwSXhn?=
 =?utf-8?B?eUtBOWtWWXJTandhNlVmRHRxMml3RFFDdUtzMy9tOUpGS0tFb2pqNVRpS2lQ?=
 =?utf-8?B?eWJ2TXplQnBqUkZOdEtVMVpSOE1PN1FpOUhEZFJrRkxKcXNDdkVnQ2YyY1JW?=
 =?utf-8?B?Y0ZyZ3pPZHJqU1JjamhUM0hJd0hSNmpIQjl3Q214dm56RGVCMVYzdWF4S2pt?=
 =?utf-8?B?bEp6ZXdtZGFxbi9aUnpwQ3p4VUxrcXhiNThxSGhzWW5QUXVSQmJFK0FCN2N0?=
 =?utf-8?B?WS96V1pFMFhJV2swdVFiNFNNYXZnd1BuYWhmbHBNS2lqZEtKaGs3TEJoMDNp?=
 =?utf-8?B?bTZlRVJha3hQL1dNQWR3dTU0Um9Ic09MMUU4ZTJnTEp4ZlQzQloybXoxTGQ5?=
 =?utf-8?B?NG5FTVpqY0FqRFFuVG9qZDJqeTRKQkltdmRyOW53WUZBYmtZMExQOGlENFJH?=
 =?utf-8?B?MTRCS2x0N25OQmhWQWdaa3NTM0Y2ckc5YmFZSzF3aEpFdVRxQUJqUHB6cWR5?=
 =?utf-8?B?QURqUUtMeUd4bDJmdmUzYWRBQmljWk4wdVRQTFJNL2tlbUh5S3N4YTNVcE16?=
 =?utf-8?B?RUlqT2NJQWVkUFF6SENYWS82RmdvWWxBSXU0VmloM3BPazVjM0diMzd4Z0JE?=
 =?utf-8?B?T0dOaEN2RjFlSGZ2QnNrMmQxOVVZYk00bTljK0F3THVDa1BlMVluRUlCcDZ1?=
 =?utf-8?B?VTNkVlQrenpyVFpOTHF2UmdFUC9HN0tqMkppT0xuSlFIeTViV2lBNUxDSmUr?=
 =?utf-8?B?RmNiR2dJbWdBNHBEejh3YkZLRUE5L3pGRTR1clVwUTRJeURaaWZXMWk2OXBX?=
 =?utf-8?B?eHhzajVVK2h4aHQzcmtyN2hRVmE4NjBCY3JwTVhEL05lLzdmTWo5dWxjWGpI?=
 =?utf-8?B?OXU0dGVpczc1R0gxMDF6eDgvd25Cb3p2RGRoZlBycXNDcUdJc3NWSEtxWE1S?=
 =?utf-8?B?Y1VNTHVCdmE4cmk0cFJvdkg0MXZyai84bXJ5WUxSRFFoc0pjbTY4TjlZY1cr?=
 =?utf-8?B?U0lrMVpOYS8wSlNLeXA5V0hsRnlOQWlZbm1sbThTUEdUVStOdUJvamVXK1cx?=
 =?utf-8?B?eWR2VFZlVzhvVjVSWExyRmowOFdka2hKSTNiNEpvcVp3YnMzMktpa2xhOHJw?=
 =?utf-8?B?OVlub0ZVamFBaXEyK1Fub2liRi9SWG1PWHJNYkVkMWtTUWh1OXM0SUlRZGwx?=
 =?utf-8?B?bm9PcVByWHlMUjlVdmx5c1FySFdMaVJxT2I2RTFYK3FCZDFPTzZHTXZ6S3Vn?=
 =?utf-8?B?WlJyWEkzcitlSTU2VmwxUDlnQWQvWWwyRjRteVdudVBTQ3BRUVk4dThYZkRB?=
 =?utf-8?B?b1ptSi9QNUNYa2JGemRGRHhMa2xkS0cvWHdrcDd1UE5ZTnZUd25YbjlMa3Uw?=
 =?utf-8?B?MnMwZC9LWXZ3ZzZudW9PQU1mT2x0cDUvUEZWS091WjBCL0NUZU1uSk5ER2h2?=
 =?utf-8?B?K2JpOUIyYmJ4bm1SRThFWmZpcUdtUHI4cFJ5VnFyR3VLNnljcmJVVUZveXNW?=
 =?utf-8?B?WHRxbkR1dVhtVnVwbmhZeG9nQVFmT0VnMjlFU2pSK1hrUUFDOXNzZS9zRnBS?=
 =?utf-8?B?cGJwU2k0VTZnVFNzaENXcExKWXJyOVIwN1NENkZ3UktKTHhwNHhlR0psRG55?=
 =?utf-8?Q?wbum4kfQKo1TvNC+MhBojXU8b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edec1ce-b731-47e7-0ad0-08dcea762042
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 04:27:05.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvQ7zPk8R8vA4wKf0FBaeB2M0Dy5v6G+c6x6qJbTtvprv/bxQYU7wlCiqqmkcIYJNViTDBjEOczhbhhYOEt2Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6431
X-OriginatorOrg: intel.com

On 2024/9/30 15:38, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, September 12, 2024 9:13 PM
>>
>> +/**
>> + * iommu_replace_device_pasid - Replace the domain that a pasid is
>> attached to
>> + * @domain: the new iommu domain
>> + * @dev: the attached device.
>> + * @pasid: the pasid of the device.
>> + * @handle: the attach handle.
>> + *
>> + * This API allows the pasid to switch domains. Return 0 on success, or an
>> + * error. The pasid will keep the old configuration if replacement failed.
>> + * This is supposed to be used by iommufd, and iommufd can guarantee
>> that
>> + * both iommu_attach_device_pasid() and iommu_replace_device_pasid()
>> would
>> + * pass in a valid @handle.
> 
> this function assumes handle is always valid. So above comment
> makes it clear that iommufd is the only user and it will always
> pass in a valid handle.
> 
> but the code in iommu_attach_device_pasid() allows handle to
> be NULL. Then that comment is meaningless for it.

Actually, this is why I added the above comment. iommufd can ensure
it would pass valid handle to both iommu_attach_device_pasid() and
iommu_replace_device_pasid(), and iommu_replace_device_pasid() is
only used by iommufd, so iommu_replace_device_pasid() can assume
all the pasids have a valid handle stored in the pasid_array.

> 
> Also following patches are built on iommufd always passing in
> a valid handle as it's required by pasid operations but there is
> no detail explanation why it's mandatory or any alternative
> option exists. More explanation is welcomed.

There is more detail about it in the below link, but is it necessary
to add them in the comment as well, or is it ok to add more explanation
in commit message?

https://lore.kernel.org/linux-iommu/0bf383b7-ed96-49ca-b1da-d1fff48e161a@intel.com/

>> + */
>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>> +			       struct device *dev, ioasid_t pasid,
>> +			       struct iommu_attach_handle *handle)
>> +{
>> +	/* Caller must be a probed driver on dev */
>> +	struct iommu_group *group = dev->iommu_group;
>> +	struct iommu_attach_handle *curr;
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
>> +	    pasid == IOMMU_NO_PASID || !handle)
>> +		return -EINVAL;
>> +
>> +	handle->domain = domain;
>> +
>> +	mutex_lock(&group->mutex);
>> +	/*
>> +	 * The iommu_attach_handle of the pasid becomes inconsistent with
>> the
>> +	 * actual handle per the below operation. The concurrent PRI path
>> will
>> +	 * deliver the PRQs per the new handle, this does not have a function
>> +	 * impact. The PRI path would eventually become consistent when
> 
> s/function/functional/

got it.

>> the
>> +	 * replacement is done.
>> +	 */
>> +	curr = (struct iommu_attach_handle *)xa_store(&group->pasid_array,
>> +						      pasid, handle,
>> +						      GFP_KERNEL);
> 
> Could you elaborate why the PRI path will eventually becomes
> consistent with this path?

Because the handle stored in pasid_array would be consistent with the
configuration of pasid. So the PRI would be forwarded to the correct
domain.

-- 
Regards,
Yi Liu

