Return-Path: <linux-kselftest+bounces-18542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53717989363
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 09:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED0A2860CA
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 07:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5211386B4;
	Sun, 29 Sep 2024 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWn9nyHP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4912B9BB;
	Sun, 29 Sep 2024 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727593956; cv=fail; b=ACa5iuURJCbr29c+SK9ZKqXbk+Y8YvE4Duvk1gYt2DMudx74uAhkEPnaCRuBvaKNXUo0zoOReeEb3wlGByYNOJ71JXXRJVPovLuPaCd+3+M5VlbyyEodbD6FjosP7HlzEaB6TRKFmCsZ1TlQ4QCz5fVttwKLfqtr754PHCl28Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727593956; c=relaxed/simple;
	bh=Kq8iduZMxAxeBxk6cwF/iesAtGKUOEiZAU+iyNMMDmc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XLbaWyxbDqN2VzlzujJWLF4mNA0Mma4PjDFB0IUBPu7O1MUyo2+quzAcs5ebKQJGMm+RH6sYs8+PJGZW/FcRLiU6EBiih8OoWXlMhFamGPVjDkwOS3LLqaMcvNN5EWSP22z+qFoMyr2aKBgdEVA720nOZLOJ+83qy0kZ2X9TNek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWn9nyHP; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727593955; x=1759129955;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kq8iduZMxAxeBxk6cwF/iesAtGKUOEiZAU+iyNMMDmc=;
  b=QWn9nyHPUOtjjSSS1kRZuu/klmgSsp+5XLv0j2A/zqljzv6zLc9aPUR6
   iRNIoHPEJUaTzV75VdscBa1qYJVk5mw1wF6EfVeZKXvbWXhMh28fFim5N
   ZtX4ErUVEt82kRxYkvDX/6lNz0Qg18rc8aPwG1hRQ6IHGGYusTLYeV896
   0MeTYfRcgrMtCvR4997M9aMr0MM+ZjpSbtVKM1a8QhbXNM0m2zKQiGVd3
   PgkSpc9enpmCqlWlFnmHo8Xw7G4i48zGfIW7Y38NIo44H3aHlZMnkYCl5
   ugOLo3z/gAGzESQfyLwD97i8dwHToB90oYGwZBoJrPtUeg+oDBSMnD8is
   A==;
X-CSE-ConnectionGUID: VFpwcH8JRjGKgVylgr4u6Q==
X-CSE-MsgGUID: WoFDkdDgTS67XK94i0a/2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="37262534"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="37262534"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 00:12:34 -0700
X-CSE-ConnectionGUID: ILV+ZU3VTbmCZp11FNDLBg==
X-CSE-MsgGUID: rL4iL/8JRV+TOyHONBADEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; 
   d="scan'208";a="73756742"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 00:12:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 00:12:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 00:12:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 00:12:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 00:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2HAYjUdt/W4x1GBEu6Kh8RsihH5ZMBQR8x+GHlCwnzsiRGh3/4ih+l1WhsXVG6I/JnIWDUWKYLPaAdAmH9Sd/0UYwI8YCDd1HB1Cvn6X8W70JDQQCmREJ9bHe7dS8dDxrszmKkHUYcxtBId6IlWNID1BRPHbf//LajVyaeNwJyFdAFrAhy1xxDfE32RaSvZzLuNmXrah8wxiIMJG2mlXyy2u1eekU8a56U+hf5XNwSRDPE+NoqYaM11Hqb90RXdoZWWhlY8LQMk59KShnkoc2tuYhsFAz/0fRBSz1k35Nac0K8cZnL/itWWDNBWV5XNwMkE+H2GESjLBqlheAKTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFoOYk3D1jX0PoJl0NBm9zKniZqA7HXuzXhfW6t59W0=;
 b=M3rKZifNlIfLOWI05S/wSv3DizE83Ms7a5r+DklBkw54cDFIOIQAr1ZqCXz5HtalQEz6SU4L/Y0V9p280WmUOFjHryN/EueeFTZqkLY6oUgUWGVKn2Yz9mXbc3Kw8LWdU/pcgwxIIZmUySH+NVfmNI6iov3x2f3A1HaXftX2ioN4TMoysKyju1TJpl6Zc442N9JIsv3A+RoIRmLEZ/tTUjw4kj+zZQQcnVeHGiYhRaAPzCkSDMOHiOY6HfyoOnyBV06mHNRT5EGTTc4bkjGN5HcXLoLltjLRRplNE4gm2JtxYUsWHFklwZvctxdUq18Z+pBy3aIbfyvf2tIXbfTEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN0PR11MB6060.namprd11.prod.outlook.com (2603:10b6:208:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 07:12:25 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 07:12:24 +0000
Message-ID: <380fe58a-934a-4e57-aa18-f4e0841b5fb4@intel.com>
Date: Sun, 29 Sep 2024 15:16:55 +0800
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
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
 <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
 <ZvZRapZlAsEGDIge@Asurada-Nvidia>
 <8440cd72-ced6-4887-b724-ce6a1650db13@intel.com>
 <ZvcZFDqu6Xf5P0Xr@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZvcZFDqu6Xf5P0Xr@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN0PR11MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: b1272f1f-ba5f-495b-4090-08dce056114c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzNGUjRTOVRsdTdSZG5XR2ZGNXg2UUFtVkVESnI1b1EwVXErUGVycFIvZ2sv?=
 =?utf-8?B?VjI0ZFh1RnJFdVJuOW5oUG4vN3Z6MzBWTTBPM3F2dER0cms0VVhOcjlwZWEw?=
 =?utf-8?B?MXQ3eVA0eDVjV2RFTlJIUDBReUNzSHhqZXQ1UHZWOW83OGMyQmVUMUtPVVkz?=
 =?utf-8?B?RHoxRFFnejBVNk5wdjZoK20yWHJGSXVFQzFmMUNwQjU0QmRXMEl2SWY0NDJa?=
 =?utf-8?B?S2NOZnZsQlBFYmdCTDhpTmJEbDYrSnlkbzJYZlB4ZlhCVithQmkwN2h1aWJO?=
 =?utf-8?B?S3c2dWFBaGVKQitjSC9NYy8yZ05FSm9FNnZ4YmtSeDZvSnRDWkovaDdSMEJW?=
 =?utf-8?B?cU9aQTRGQTNPRDRqa0V4Z01RcDkzUEE3anc0UkxqRHJMZmVJZnVxaytQODhx?=
 =?utf-8?B?NnhCM2w4YSt2VmNtN2FwdzE1c3JiVjFpUkJ5TGJLVmxyTzAvUVVrNHQyK1FV?=
 =?utf-8?B?Vlplc1YzTnZPYWJxVEdPY0c4ZnVWNWZ1MDA0aTQxWXF6bVdsYkl1WUpTRlZz?=
 =?utf-8?B?cmlHQnJhRitCWWRpQkVZSmZPNmc2MFdpcmlRbTFTbEg2cllyUTRIekZ1NC9L?=
 =?utf-8?B?a3BxaTREeFFoKzZHdlQ3VXdObVRRZ3FOR2VoTzBQaitoT0p3Z3pCczZHc0pt?=
 =?utf-8?B?cGt3K3h5d0FtR21Ha3ozS3BQMEEvMDFlRktjRzNKbjRGOE8wUVBJTjZjZ0Iz?=
 =?utf-8?B?TitUcHhCb21TNDBQbi9rdFlveHMyL2NlR2FndjBhM3Zmb04vMXhHMFhHdEhD?=
 =?utf-8?B?OGw1b1AyZCszYzlsSVl1bGJibHFYdy9DaXByWXIrZEJWTEgxZlVLTEh0ZHRQ?=
 =?utf-8?B?MEVWTVJuVXovRU52WmdvZTEvd2JUV0RJRGlqQVBNNnlkeFh1TW9EVTlNaGtz?=
 =?utf-8?B?Sm9KSnZxMzhoYm5aQVhFMlRHUC8ydVVTZW9CeG45aTFTUkd1YnZ6Ylg3bEo5?=
 =?utf-8?B?WVoxRU96eTBqakFFMnZ1eTdLTktoaVg4QTJvdGI5YVJBWDJHUUx6VzZIL1ZC?=
 =?utf-8?B?WHRXMUFVS3p6blJIOVpoYk1weU0wZXgxU1NEVEtoSDlIc2dzY0ZzNzJhOFlI?=
 =?utf-8?B?NHZ5SFlvTHROeFZNc0t6MTh1YzkzU3Z0WGJXV1FOS1VpNkNFTG5GWXFzZEhK?=
 =?utf-8?B?blNUZklqQUtQSkJCeVZaNnNmb3ozdE13dGhLMHZIRGRwVjRacStYRElFZURK?=
 =?utf-8?B?MTBKdXJ5eXE0S2RDWWFRMUd1bkY1cDRDU1NnWlBzY1pCK1NZUnF0b3J0bHVG?=
 =?utf-8?B?TlNqOHdhcWJIR094VWFqUUtZeWZibEFqYnhRQ1NWUzNMWS92b1BqcHNkZ1V1?=
 =?utf-8?B?cVpjbmNlZ2EzWW8rcTNLcm9hSTV2OVNuTkR4RFk0aFhGcGowSWlKRG9zWG53?=
 =?utf-8?B?Ujl5MHZhaEpOS1kybDAzT21oVmYxTEo1ZnlFdEpZZms2SnZmOGJpckl6RDlv?=
 =?utf-8?B?ZDB4ZEI1bGFWL3RvVEpKL2VIbk9DbUtZak9sd3VDdXBCejBTZ0kzVUE4S2Fz?=
 =?utf-8?B?blU5R3NLVHZTalNVK0VoMUJLUnFlL2cxcU9hUnJiQ0xqZkpZZzVOaENCK1Uv?=
 =?utf-8?B?cHdLK0VzYU9UOGljMll3bG02OEV1TGpzelFycEtSdFZTY0pjeU5MMXhzMmpo?=
 =?utf-8?B?b012UXpmTlZGdGhZMXh3ZHZld3BlRUVpQ0poeWxqSldlM1RDcmhqY284amVi?=
 =?utf-8?B?TlE4T0Y1ai9LTmpPS3JGS2tKWXZCZm9WdmhSaDVvdTdOZjlNTjRvb3RhcHU2?=
 =?utf-8?Q?SjOiOQ837uirPTE+0w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjNKRlA2T2F6b2xOazZzYXZjYWE0ckpNNlB2ZGZ2V1dVK1RyWW4vMkZJWUtY?=
 =?utf-8?B?R0gxUSt1M1kvTisvaFM2RGJ5VjFXMVA3NTVFQW1NUEZnemc0YXkyNEhTU2py?=
 =?utf-8?B?SS85UFNWazhHU0hwcC81OFYwekR2bnlvUm90dWY1ZmN6NDBkRGwxUmFkejRh?=
 =?utf-8?B?R2JXZGpkMCtDTzhaay9TTExMYVI2cDN1YlBqV2p4TWJtbFRvTVhnblh3Vy8v?=
 =?utf-8?B?azEyU2o2dFRGclkwMWdMVm1FaVlUOXBIZm5ibThSOTNVYXJiVkV0cDRZYkgw?=
 =?utf-8?B?b3RnY2lNN01xVWdhdU9OMkluUWN2Z25VYkdRUmY3d1lOMGJIMi9PTEg4czdF?=
 =?utf-8?B?eStJVllZSWRpNTFYWnIxTHZ6aHM1ZEZERWQxUEhzWkhlMUNQNjMwMERGdGVW?=
 =?utf-8?B?VWhnT0RxQmVOL0l6RkNwa29ja1dnZFVHU0J3ekZQTWlwZVZOU1p5WFhHeWo1?=
 =?utf-8?B?eCtvSHhHT05TczVhemRZcUVOaUYxQ3Y1V3FYS29mNkpFZElNVVhnSzFpN0pw?=
 =?utf-8?B?V09qQWtkbGFsYjNDbzZjYi90UkRCZzdmZzBISURUV045RXRhSWJqbTZ2blhJ?=
 =?utf-8?B?bGhJcTd3TGRFYmRPaGEza3ZjZVRCMnpFdUtaNG9FZEtxUTFybmpuVVJrNUdG?=
 =?utf-8?B?UzloYWNWT1ZmdE9CSXROQ1lLR000OTIxbE0zNUo1MnhWazB5eThMQmZOVG92?=
 =?utf-8?B?ZmxHUlpVT2FnOUVRU2tPbHJVSSthVXRkb053b3hXYXR2ckVOb3JIYjAyZWdT?=
 =?utf-8?B?Q0U5SlRvVU1BWUNQbzRvbmV1Rmdsdm50ZDNlMDZVMFE4Qm8rbys4QTFnUkw4?=
 =?utf-8?B?MlRsdzNUenRoRmNwTzM0NUhkL2VCa3RMVm1TK0dsNEhya1kwM3p5ZFhBVEFX?=
 =?utf-8?B?SzNpOFBBaytidWl3QThYZWRvZ0N0MThDUGRsMXp5aHVHK0pLMlVSdmV5Sloy?=
 =?utf-8?B?TjRWZ0xJd1ArSXZjWUk5YkxCMXV5Vk9OSU1QNVk0TCs1NkF0aTFIamlKeStT?=
 =?utf-8?B?bDVpSVBLc0VmR3NEMXBZYzZUbUkvZjQrZitWZDVUb2YvNEI4MzkrdDlpYzNY?=
 =?utf-8?B?cXJqZ0t2OGxxYUczSmloanN5eTlmMHdiWTVvRUpYT2ZlT3FCQlFodnlVNk9X?=
 =?utf-8?B?MVFuUktoc0t4MW96ejJhUW5VQXZtcFBMT2FvRUs0bHVhQ3ZJRHRnMDMwclA2?=
 =?utf-8?B?aVlVMFB5cnVWNTJma0t6L0RyVjAxYlNZaXhSbDdyaVU3N2V4c1BWaG8way9y?=
 =?utf-8?B?UG5DdGJ2cWs5eHRSTXkrUUxjWE1iT1ZmeHhtd0Z6T0tjZWNKdFNDRjd1OFZk?=
 =?utf-8?B?enRNaTd4VnkwYms2cWJCY1NFRVZNcDk5cnNLeXdmOG9GNFoxd093SFFuUmR5?=
 =?utf-8?B?eDlteThSRkRhbGNqbnNCbWt5L2hkNC9ZNDdDVzhrWTh3eFdsaTh4UC9pWTMy?=
 =?utf-8?B?KzM1Yzk2aFdTM1dWcTN3Z3ZLU28yZ0ZQVlVuRjZxV1ZXS2RYOVd3ZjlMQktU?=
 =?utf-8?B?bVpyQnZyMzRXZ2psTUlEeGJMUDNyR29MYVpFSHk3SDFQeEp2ZHpOSmRicGJn?=
 =?utf-8?B?OU9GQUszaGdOTGtVWmxaSkIwRXV5bHJGelpBU0FzeXBnM3RRRGVUVlU0U0No?=
 =?utf-8?B?SjJmQ3ZHVytBaHJPVUFSMmkrZUMrYmhua0t0NmszNlhCNndLRjlVTm96UUxF?=
 =?utf-8?B?eElxWGpwVFE0VGV3RmhHVWkyVkZSVmJmNlpUSFZVUW9yQTdZOXhoU0VoaHlx?=
 =?utf-8?B?Vnd1dVBQdW5XaVZOOGRKRzlGajd5QkdBd2NlTnhxVTVUbHYxb24wVVk0d0dX?=
 =?utf-8?B?d1BFRG5UaTNGMDgxalc4MGxmdkFQck5zQlZ1U0ZCb1YraFFndk9oT1Bkblhr?=
 =?utf-8?B?SURVZUlxT1hTcndMekVqSTNBaDZXNVpsRUxESVdZeElFMkIyenFvZEFZUWZN?=
 =?utf-8?B?L0tOL0JhaE0yUEhwMFdwR3F4OTI4NTZVdCtNRldPdnhZTFpOZURKWlUxRWxF?=
 =?utf-8?B?V0F4ZWs2aTliNjJRZmltbmxSQTFRNEtxa011UmIzMlZPM1dET2huVHZNZk5G?=
 =?utf-8?B?VWgvNFA4Sk1CZ0YvckdQdFhDUzBDKzNZMnN4NWp4Uy90T0gxRjV5am8rYnBj?=
 =?utf-8?Q?MMq3Lx1Iq/e1raKhKreXwosIo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1272f1f-ba5f-495b-4090-08dce056114c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 07:12:24.4850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMQXQYR0MyIlk/kwhQrxLoCEzDZaivv54KLLRHMkijmpNXnehbBlbFhzhw+HT1tJ0AC1tqKYuL1s/jFu97gKcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6060
X-OriginatorOrg: intel.com

On 2024/9/28 04:44, Nicolin Chen wrote:
> On Fri, Sep 27, 2024 at 08:12:20PM +0800, Yi Liu wrote:
>> On 2024/9/27 14:32, Nicolin Chen wrote:
>>> On Fri, Sep 27, 2024 at 01:54:45PM +0800, Yi Liu wrote:
>>>>>>> Baolu told me that Intel may have the same: different domain IDs
>>>>>>> on different IOMMUs; multiple IOMMU instances on one chip:
>>>>>>> https://lore.kernel.org/linux-iommu/cf4fe15c-8bcb-4132-a1fd-b2c8ddf2731b@linux.intel.com/
>>>>>>> So, I think we are having the same situation here.
>>>>>>
>>>>>> yes, it's called iommu unit or dmar. A typical Intel server can have
>>>>>> multiple iommu units. But like Baolu mentioned in that thread, the intel
>>>>>> iommu driver maintains separate domain ID spaces for iommu units, which
>>>>>> means a given iommu domain has different DIDs when associated with
>>>>>> different iommu units. So intel side is not suffering from this so far.
>>>>>
>>>>> An ARM SMMU has its own VMID pool as well. The suffering comes
>>>>> from associating VMIDs to one shared parent S2 domain.
>>>>
>>>> Is this because of the VMID is tied with a S2 domain?
>>>
>>> On ARM, yes. VMID is a part of S2 domain stuff.
>>>
>>>>> Does a DID per S1 nested domain or parent S2? If it is per S2,
>>>>> I think the same suffering applies when we share the S2 across
>>>>> IOMMU instances?
>>>>
>>>> per S1 I think. The iotlb efficiency is low as S2 caches would be
>>>> tagged with different DIDs even the page table is the same. :)
>>>
>>> On ARM, the stage-1 is tagged with an ASID (Address Space ID)
>>> while the stage-2 is tagged with a VMID. Then an invalidation
>>> for a nested S1 domain must require the VMID from the S2. The
>>> ASID may be also required if the invalidation is specific to
>>> that address space (otherwise, broadcast per VMID.)
> 
>> Looks like the nested s1 caches are tagged with both ASID and VMID.
> 
> Yea, my understanding is similar. If both stages are enabled for
> a nested translation, VMID is tagged for S1 cache too.
> 
>>> I feel these two might act somehow similarly to the two DIDs
>>> during nested translations?
>>
>> not quite the same. Is it possible that the ASID is the same for stage-1?
>> Intel VT-d side can have the pasid to be the same. Like the gIOVA, all
>> devices use the same ridpasid. Like the scenario I replied to Baolu[1],
>> do er choose to use different DIDs to differentiate the caches for the
>> two devices.
> 
> On ARM, each S1 domain (either a normal stage-1 PASID=0 domain or
> an SVA PASID>0 domain) has a unique ASID.

I see. Looks like ASID is not the PASID.

> So it unlikely has the
> situation of two identical ASIDs if they are on the same vIOMMU,
> because the ASID pool is per IOMMU instance (whether p or v).
> 
> With two vIOMMU instances, there might be the same ASIDs but they
> will be tagged with different VMIDs.
> 
>> [1]
>> https://lore.kernel.org/linux-iommu/4bc9bd20-5aae-440d-84fd-f530d0747c23@intel.com/
> 
> Is "gIOVA" a type of invalidation that only uses "address" out of
> "PASID, DID and address"? I.e. PASID and DID are not provided via
> the invalidation request, so it's going to broadcast all viommus?

gIOVA is just a term v.s. vSVA. Just want to differentiate it from vSVA. :)
PASID and DID are still provided in the invalidation.

-- 
Regards,
Yi Liu

