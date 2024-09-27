Return-Path: <linux-kselftest+bounces-18444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AB3987DE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 07:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D118D1C22825
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 05:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E651482E2;
	Fri, 27 Sep 2024 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNJ0IUhL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0D4C9D;
	Fri, 27 Sep 2024 05:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727415224; cv=fail; b=MC9vIbfFD68gYB0rH2uZ0dMZq/bx4+WDcoM+i7/VYKzgUCpB+XaBpLMtJM2AVG0yE/fKKYlO1AvihoWpxILWAnNzA9cv5MN/QPYBppbPaMdpa40h42LxJd5pG/gM/TJZQSMRdtTKefZGQfaVsqvQzH740rZDXqLHGXq6MemYHv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727415224; c=relaxed/simple;
	bh=rHDBZS8D+vTZNUDKW2Dr53xF0lI/D4eWO5bM80AarS4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BVSXN87qspM0SBFqWbwFJGMayTxdoYh8esJ+8KKqgoDeeXKLCWr/GfUFnxpg0F0wb5Etof/fCpb55q3VCKK0HDDXM5PcboHTCxHXZnjS8Szo0NILtkiq4Ucara1augmh/YXUKDR+R6CoTVsR6R7e1ZhSYQrXnVhj0s45gDd7XZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNJ0IUhL; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727415222; x=1758951222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rHDBZS8D+vTZNUDKW2Dr53xF0lI/D4eWO5bM80AarS4=;
  b=KNJ0IUhLhrd/PfKDBQ22r1zM7jDVNWC9JElrJtAwX3QtcMI+bQAnxhMf
   rM9/+amOYOYAUa57zvtEXiBliswqmyjxH3SuP+uDss5m83WkL/JOYBRpo
   sFUGCDCjm25RpCtjpeEov7Brr9IVv4btVYBk1y+o1YpUz10UUtQKh0JUT
   uHUxMq4aIRMLlidoHN+s5T0sDKjJhryRSvDb+AufsFVzQb2ssan76zlRg
   L5dLZ5quh5nQL4xDp6RsIx8b8RFsH8XL8BID/sbBGxH5YScTwuA2vXtpX
   /pllNnFQi2lkNh/bn+d/lDP07smN6GxFBq/vl8mbSaFilgjHyM5uq2/et
   w==;
X-CSE-ConnectionGUID: OSjqGXxtTdeS1Tcw+skSzA==
X-CSE-MsgGUID: qQ853EinRT+7GgdMNmOlOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="14166345"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="14166345"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 22:33:42 -0700
X-CSE-ConnectionGUID: 9ak+2n8GRxSnCy1/W8yCLw==
X-CSE-MsgGUID: aJ6lTvJ7SzW27UzTJMctJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72306412"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 22:33:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 22:33:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 22:33:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 22:33:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 22:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lw8SXyZYKj+T9SkCKSEo8d8eaFYoCd+sSF+m+osP3WKPH7LUDthmSzyoYIjhs8i6O+C/7xdZaT1JBMqNqW/Kd8ONZWTDo4TqmNA9SBSUv3ajoXdDDQRRSgKD+EzLMUrli8S5P6mjJS6Wc678CGv/Lu6SaGBVD9QixyBI5h6JJzwA8oczMGscpNfgXzwz6NIivX5PHK16nJlIH74oVIV3Bhrtck1WXEKaJvOzrIi4x6S5/mm6vdnRmrM6azffGMzeC7tTG4PmsM8r5aZlTCQSlFv9F7r0PnX2Ll6WBt4uXNvR5ZdUKbeKNZlZSyLcbZsB1Jw2VfHqQGqaofDaVPefJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rglu2atBOk3/9K4If3BpdhDK+izl6irscx32SgwQji0=;
 b=i4BesnFoslZAZABUziozbULZzMttfp+2yvTxnJ0ETDkFMFnE6Q0qLpMF6lxK1YB/gm1D1S5AdnnGGDBPPMDYkgmsl1IwjN43G5MhJFkRhyuQXqYsm39WtfH08HMcJK1XnpZEr4Eu7AKQSOj7/+0eVjd8VfjipPlQYoJNb558fsq4qsD+CKPKHORlOJ+E7TyXq/DtPVaeD76mQvux140YEoonM93xNunqp9yQCZu673Txj2XgB9706MuTrFicgbP+Pef1oE551SygYWz7rwtvGaL3J1igkscQfHAq5no+ErKZc7we2gzpCcwtbYgxOCkQ3EmcgvkJUWXOeM0AB1WEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5006.namprd11.prod.outlook.com (2603:10b6:a03:2db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 05:33:37 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 05:33:37 +0000
Message-ID: <ac6c371b-857a-42f3-9b71-969ef19a54ba@intel.com>
Date: Fri, 27 Sep 2024 13:38:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
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
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
 <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
 <ZvW/vS5/vulxw3co@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZvW/vS5/vulxw3co@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: e88661a7-5ec2-498f-cf67-08dcdeb5f005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0pDY1IxNjN5ZklZdXVodGUzYk1vYzhQbDJUR1ZZSTg3OFNoWHpqTkp0Nkwy?=
 =?utf-8?B?c3JObkw4QlBZbUZXbUY4OFRVOFFORHU3THZFdmZGUWt6eFJzcjdSVDZlelZy?=
 =?utf-8?B?dFBHUGxTYTAybkFYby9jREUzZklsRi9xV2x1YWp0WnRVWUhvc2QzQzZncEZH?=
 =?utf-8?B?bzBKSk9RNWpuNDBVd3liZ2Uzb0NadElrWFZrSXgxZkVpOW5UZ0hhYlZwZUNW?=
 =?utf-8?B?Nm1XSUxGNVhpVVdYbVNURUFHY09iM1hjVjU1YUVWcSsvTEs2Y0lUbWhkanky?=
 =?utf-8?B?OEl6TkMrZ1hxemJ5K2RZcXgvc09hWGJVUFNYaGlNZmpXdHJuOG9WMEUvd0JE?=
 =?utf-8?B?NVNNMGlReWRjRVZTNHNaQnlzbC9pa2UySEJadUQyaVcvQWs2MXhnVmJQQ3pr?=
 =?utf-8?B?OFZqTng3OU80UU95UUQ2a2pWL3ovZDVRQXNZbFdwMVJOZXA2aDZZSUZTK0tX?=
 =?utf-8?B?bEdQcHM4WGYyZXorQ1NianBiajViek5UQzYxMjJLcm14bmhsSTIvVGJ0a082?=
 =?utf-8?B?NUZBcVJOazN5OEdZcU1zdXRqYmRWOWp0WnBscEY2RkVQMGNPd0RpZjlIc0Jm?=
 =?utf-8?B?TmlmREh4YUJoSmR0ZUtjT08zN1EyUmVTUFd0S0tFTEdOTy9DTmRjbmwvUGwz?=
 =?utf-8?B?bEhJNmgxR2Nzc05vVnpqVEZuQm1OL2x6MU0rOGJxaVZRRG5wbk1lRWpuSXNT?=
 =?utf-8?B?dE5ydEd3a3RUb3pUbjhXdTVTNmZZc3hwaVpvM2ZrdW9DTnRTbW1CR0U4NkJj?=
 =?utf-8?B?VXNIQ2ZNS3BENUduN3FIOXJpWEpMOE9TQ2lXeVMwQ3U3Y3ZBYTFMdUpkTDZi?=
 =?utf-8?B?Zkx2RC85c2Nsc0w0ZFh2VHFHUFVpcGJBWmtyQkZ4MnIyZlQwMEZNcldGZm9V?=
 =?utf-8?B?Sm9xSE1INnRxSC94ZEg3TFpFcG5HNTZiSzA0QnkxWlprTHlhU0RyckZOcGhF?=
 =?utf-8?B?dUVVUEYrMkVJdHpUYVdpR1JjdHlmV29hMXV6Qm0rcDl4VWdJaGczWlArWFc5?=
 =?utf-8?B?bzZoR2paUzJ4T0hmR3JlOStSUXBhdnJSWnNUS2l0NVpvSmlBajRwU2tTNGxI?=
 =?utf-8?B?VndPSmFQSll6UWNJQUI1VGdzUnNHdTF0Snl6ZjFQcWZWeFpIQVlIbGsrajd1?=
 =?utf-8?B?R0VJR3BFemlDZE1nYmRsYkdwS2s1LzdQdEFhVVRHQTJSL3QyaVlld000cHU0?=
 =?utf-8?B?SGZ0VVBjNURCZ0JYbG9IZllUay9BTnFIR1FFNVNEc3JNN2toVDMwc1pQTnZl?=
 =?utf-8?B?YmI4TXFjcjEydWJRU3A3empGeEdHTEFHak1yQW1BNHVCaWVjSmg5c0JPZ0dL?=
 =?utf-8?B?ZWhqcUZNanR4OUxISkRnWGpFa3k3Szdpb3N5U1dkWi9NSGxJYXRlZUlFcGQw?=
 =?utf-8?B?Z2pub1c3THM1QVlQUkZIYTQ4RTBXUEVqdnpIWS9BRDVKWnlRWDBRaE10YXZ3?=
 =?utf-8?B?NWdXbzQyQVZ4RlZXRldRNkdQRUduYkM3MkxocEtaM0pOdzMrWmhkMFVzM0Q3?=
 =?utf-8?B?a01TSjQ0VW5sK0UwN2t5UmNFdlU1aDVxY0IySWMzVEt3MHUwZ2xFQXBMRHVn?=
 =?utf-8?B?RS9qUE1wZEdoSHR0NkJ1d1BuV2d1SGJ6QzBUKzVMVlY1YWlSMDk1dk9kODdG?=
 =?utf-8?B?Ti9LRHRGWGZid0thVmYxMllObmw4RzB1aG41RmhHd2tQdzFVT1A5dzJEaUI1?=
 =?utf-8?B?TVF4Wm5iZWZZanlFK1BlN0RwYlBFVzJKNytoSG12NDh5Z2V2NEJwYUx3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1pJSklJWk1MZkgyYU1saldRamhGSnRlZmxiaEU4L0N5QUVGTHFDVjdQc2Fu?=
 =?utf-8?B?aU4xS0w1TmJWMktzQ2dqTk9rT2JwOXh3Tzh3S3FKTVJOWDZ4ZmRJUGRWZ3Rq?=
 =?utf-8?B?bTNuUkRLdzVDaUlzdWpUMmo1VkZZMURjU2JmMi9KOFJ4Q0J5M3pxb3huVmxw?=
 =?utf-8?B?NFNuUWJ2T1I3NCtxUzBOSkFlejcyY2NOWlZ6QXJsaFRleXBqL202eGZWMFY3?=
 =?utf-8?B?UXc0cGFRamp3clRocmxrWmwxT3RZWlY1RW9JWERwSlJ4d3NlbmxlN2p1TGxK?=
 =?utf-8?B?NW9uYmFwRWJraTUrMWRjd0VRWTNVSkkvL1l5OENWQVhreGxJUTdlcXNJc1dT?=
 =?utf-8?B?bVBNWEtFRzlFcjJTbnJLc1FieVpaNHhlckRaQ2U0VmZyMmNCZEgrVHUzMkVT?=
 =?utf-8?B?T2Nxa2FHd2dSUGJJWXN1bCtvZUo1S1hmQ2UxNkxrVDNmQ3N6OTJlb0ZXRytn?=
 =?utf-8?B?clJaVFg2cTJuVjkwdU5wZ0lVMytTZWl2KzdIZXdGdk9pOVZMS2IvVE80dFRG?=
 =?utf-8?B?SXRlWmJnSWRiVFNSaC90Yks1SmZ0cDdtTnJUemtNQkQySzMzK1RBN3BuMU1N?=
 =?utf-8?B?Zk1icDFxSk5abmdsQXYvV1owRlJEYkRBVjdSbDI2bjkvS0JTbldDZnpVTGdH?=
 =?utf-8?B?cGdBZThvS1I5YWsycDQvcDNZUjVNRHdpMUhITjdvU3pKeURxMWJGUXZKS2o4?=
 =?utf-8?B?NW8wdDdiL1BJWlhCZ0FaZmVNRGZCd3NSTjhvZU9tcjlZdFV4WG1RbS8xRjFX?=
 =?utf-8?B?dVJoY2QyVWxEOElUalhUV0dyUElyQjBlYkwrWVpBTDhOdXBBYktzTkt0M2ky?=
 =?utf-8?B?dDZmSEZGbHB5eUs1aTMxK01qY0NiN1A4NzRuc2toUnhaZm9kSFQrbWxNUDZD?=
 =?utf-8?B?WVduMCsxUEFrNGZyTWQyaUpXZFBPODd3WkpCZ0wrcUZNbTMvYnN4eEJudkcy?=
 =?utf-8?B?eEFpMjZxSk1lZ0pPV1NrclRHeGNJTUppaWR1WFpFemJhY0FrM3FsS2lSaDgx?=
 =?utf-8?B?YStBa1dNZXV0NXZEcjE4NUY5aUFKdWZPRkZCemhHTkZESTNzTHRucFFtVDlo?=
 =?utf-8?B?ZVhLSVdJKy9sZkFzZStWUElHS0RuTHUrTzdXWjZjVkpid3didXpsMWkrMEZk?=
 =?utf-8?B?Uk9lKzBFT28zUXdxczBHeTZtQy9adDlCR01CY2JqR1RTSWd1bmJCSCtyOHpy?=
 =?utf-8?B?dXBqOENXaGJLNyt5bFdnMmNCeExSbkdSWVhUUHdXcGJNN3VBNmVDQXlYbWQv?=
 =?utf-8?B?cnA3cXN6L0JuUFRxT3Axc3JmN1BTbEF5ZXNPNnZIU1gyOVNkWjd3UU9FcHBP?=
 =?utf-8?B?dFJxOWVGZituVWdPZlJXWWs1Mmw2RDFJenZKb01UY1NjUmdSMWdxWC9ka3ha?=
 =?utf-8?B?a2xQSW5renlVRmo3MEszTUdMTVl3UjhjSWlEbHNveUx2SjNjYmZZWjQySy84?=
 =?utf-8?B?SmhpeG1FN3ZPRDBRZWU3Qmx5RWZBaVN1YmNjd0Qvb3hlanNSUUU5RHZCR3NZ?=
 =?utf-8?B?OS9NL0IxZEh0WXBITm8rdmcraVpnZW1zVjljU3VTUlVtS1Awc2VuWkVIaU5K?=
 =?utf-8?B?K0lxcmI3ZjJKTXBrK1NxbWc4VGd4clNuQXZxRmIvU0g2VGRhSFpBZE5SaGVj?=
 =?utf-8?B?L2xkT1lvTUZiMUliMlFDNTJpcjhOejlXbzFjRVU4TjNvSzdGUUhzVnljWDgr?=
 =?utf-8?B?anRjaXp4eGhJQU1ZbGdkb1NyZUhJdkFKZzhWZ3FsbmJ0VVNlZkxWbi9VV2Fm?=
 =?utf-8?B?Wko5Sy96OG1rUnR6MG9HSEhHbXpvS0VJVzNSL2haUEpkMVdpTXUwcVcvUGJH?=
 =?utf-8?B?V3hya2hUNElRQnJDRjA3ajI1a3pjVWhVT3EyRHI1NWNpM1lkZDY4R0hvaGlk?=
 =?utf-8?B?R2F0d1dWTW52cDNnWFFZNGhzZ3ZIYnZmVGlVckY5NHhSS0NVVFpWcXcxcnJD?=
 =?utf-8?B?S0xncW1INmw3MWtLazNuZnpMbGNtTHNEMWlGc1JTS01Ha1BIRXZvbC9oRk5V?=
 =?utf-8?B?UStpU2p1MGIvRWdnZHlnQktmSTkwcDRETWtkSnR3ejBMUmhCd2FnUmlYMVNo?=
 =?utf-8?B?R1d1bWIydlVlVlZpeEtsdFphMlc2d05ZL2Y3YlZ0bEJYcnVTc2h4OFpvbTZQ?=
 =?utf-8?Q?8N4fnL9EyplRoqUJh+kk1LJvR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e88661a7-5ec2-498f-cf67-08dcdeb5f005
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 05:33:37.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8plZQ8q1NKD34IK4fYZBMl+VdJBIOuBX9HCbwbQYVefgOH1u+LjWQy+7ijjeqLkGYcVmwuZTmEE+P+RgvqwmHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5006
X-OriginatorOrg: intel.com

On 2024/9/27 04:10, Nicolin Chen wrote:
> On Thu, Sep 26, 2024 at 04:50:46PM +0800, Yi Liu wrote:
>> On 2024/8/28 00:59, Nicolin Chen wrote:
>>> Now a VIOMMU can wrap a shareable nested parent HWPT. So, it can act like
>>> a nested parent HWPT to allocate a nested HWPT.
>>>
>>> Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.
>>>
>>> Also, associate a viommu to an allocating nested HWPT.
>>
>> it still not quite clear to me what vIOMMU obj stands for. Here, it is a
>> wrapper of s2 hpwt IIUC. But in the cover letter, vIOMMU obj can instanced
>> per the vIOMMU units in VM.
> 
> Yea, the implementation in this version is merely a wrapper. I
> had a general introduction of vIOMMU in the other reply. And I
> will put something similar in the next version of the series,
> so the idea would be bigger than a wrapper.

yep. would be good to see it. Otherwise, it is really confusion what
vIOMMU obj exactly means in concept. :)

>> Does it mean each vIOMMU of VM can only have
>> one s2 HWPT?
> 
> Giving some examples here:
>   - If a VM has 1 vIOMMU, there will be 1 vIOMMU object in the
>     kernel holding one S2 HWPT.
>   - If a VM has 2 vIOMMUs, there will be 2 vIOMMU objects in the
>     kernel that can hold two different S2 HWPTs, or share one S2
>     HWPT (saving memory).

So if you have two devices assigned to a VM, then you may have two
vIOMMUs or one vIOMMU exposed to guest. This depends on whether the two
devices are behind the same physical IOMMU. If it's two vIOMMUs, the two
can share the s2 hwpt if their physical IOMMU is compatible. is it?

To achieve the above, you need to know if the physical IOMMUs of the
assigned devices, hence be able to tell if physical IOMMUs are the
same and if they are compatible. How would userspace know such infos?

-- 
Regards,
Yi Liu

