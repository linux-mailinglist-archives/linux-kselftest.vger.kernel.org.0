Return-Path: <linux-kselftest+bounces-18445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB0F987DF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 07:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9D0B24698
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 05:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978E171E4F;
	Fri, 27 Sep 2024 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5k4+d1B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B7175D48;
	Fri, 27 Sep 2024 05:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416219; cv=fail; b=oGUPqvw+Nz8wT1wTgt8QjKeW/NRKEARPGEgK/THucaM8zQRtEzHNKxwvE+y46AXIZxvI6SX+QsWwEojfo4SW1JpLgfy4TlMAXB0f3bwgjNDfY5HSmkB8KR3ZITF/juPawMqL9xukXyPVXbl5UR0S70v8khYwxwjNOixozB8KgC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416219; c=relaxed/simple;
	bh=KYaa7izFhxsdpKw2l3MH4ykdDLB+DinPykEpEBvdMeE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TywPXbgG8aaHVVnOsi4He2jHCPa+LBiujC/OsFTLBHGv14GBTmW3Aip7djirCpFUbTMsUaGNCb1rp3EWsCOOi2x9pVO89KrYrS0OdajWSqsqUA38p6dE00YjtERvfXLZ1MqJvWVMH/HiKa5aRijKrD/+Z42qcJYEAt3WmzCTMVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5k4+d1B; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727416217; x=1758952217;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KYaa7izFhxsdpKw2l3MH4ykdDLB+DinPykEpEBvdMeE=;
  b=d5k4+d1BNQOy+qIyzwFoVRxnTkzudP3KXJgdF0J7174QtysAdXFBLDhz
   oLV62PetP0tOI5wQO+lL2p4KNA3ujSJVoX52zEKG4oill2ON/Ve3OXU8s
   SI7MgW209yuvY2gSN3yDC6Vghc6tXokMOo6qv7Ga5r2gE2YL+aFJln0UE
   oagt/5At1Yu4CmXiVcIzViMXcARwpuP6JvFAJNI03+eejCOH2VFDM1BPs
   PYux0ikQKuyc5smX3LcmjsH+tfs0cyEJtG1ynCVnu3FWCr3OTmn8klW4v
   iIeKy8yy/BjforjY4M46lrVKFTwXsVpJRQrzZUIoITafc1QQrxHgiLY1w
   A==;
X-CSE-ConnectionGUID: vERrYMuQSnK43IKxk6vUhw==
X-CSE-MsgGUID: YUUmw0Y8TASgU3XQuOqRaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30340637"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="30340637"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 22:50:17 -0700
X-CSE-ConnectionGUID: niS2G8NcT1q3z2SdrQ4ZvQ==
X-CSE-MsgGUID: pqPFVwe5Q/WecOq8hFj9YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72575390"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 22:50:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 22:50:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 22:50:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 22:50:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNeWh7qW1P6LMEF/AR0W2ZVVTO/Tc+ZHfpZgXHgS7DkvCzIcroZxTNoDpawQ07TnXqUekaPj13wc0qlLQQDAwBFBulhTwI30p++LAkRDRU8ZXFTEhE8r2le1tnPdrZSeNjMXO8VV8n5G42KsUBdRGqUcPf6wemSxhjYAILGVkJtp5/tWzqu7CfKJ7F4qtYGHtDKdwYN8wHT99Ilch7aV/t4zYxtFpUP2JjoJxii29ww+8YGu3boQLh2hWz2LxYjvEn74DYUk8HIAuSdKcioVBOqtajM+sMHUL+qkUf7vg4jyt9zCEG66h/udGiE5gMnutjw3NzpHEIvQUdfvkhBbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbMDAoqiKQEwsL1tHl4XeNMcLH5WT40Ylbj8WuFd1qE=;
 b=yv2lQS6v6HHpypHCdeDgB9VAeikq2ipsoYrqZtO7t3MRwHV+lhtRHJcgUQP2EsJv6xvdZMkYB8Q1C4kNo0DNd+cjj3xO9/+jStPRecFVlYuFXLw+phZb4mfMVjonLF0KHDordhfw+Kz4/3CTnSKA7YXM4zz3tx6Iwe07J/9fsGR/cOMnFPzq2U0b+f0jwGeD2GaVqiI93Znh7aO7KnkpvfbZARMZ7xEj6Ly0hm7AaFugBwP6dmjktJ3desG+DeewMpIpNj23+vRcOKW3UxpXSHGc6zzsLzMThtx51GAVnmeTJHp4FmrBiFUTNUTNy2gQ12dnPxMQXr9IwhCHWKQrQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB4810.namprd11.prod.outlook.com (2603:10b6:806:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23; Fri, 27 Sep
 2024 05:50:13 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 05:50:13 +0000
Message-ID: <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
Date: Fri, 27 Sep 2024 13:54:45 +0800
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
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB4810:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be5f3d3-379c-4c30-6145-08dcdeb84136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFhydWprbDhQTTE4LzkvR2ppbWEvaU9UM1M3bW5zNVNnUHl4YUFMU0kzUC9E?=
 =?utf-8?B?a3NmTTk2RWxiUjZoQW5KR3A5dlVmMFp3ZzR5ZWRQMC9nZk5TNTJlV2FrV21L?=
 =?utf-8?B?d0Vwa0NqaHNBRHVCN2lzcWdDMVZjdWpBaEptY21XNEdkYWZwUGFFYmRhenRO?=
 =?utf-8?B?b2RiWVdySWlzWk4vMkFnUmxZMDVKVFdCbFJva1hZcmRhTGhRelhmV1NEZ3JD?=
 =?utf-8?B?V1RpeUZHWEt6RWdXK1BZUUYzNk54TGx3MlBlcVZSZHlaRlVROGZuTXMySkJK?=
 =?utf-8?B?MWFDTmJIVklVM2JDbTF5NUh1c1NmSjBrcjdQUmFydzNZejRIMEZVS2t5ZnVz?=
 =?utf-8?B?dkQ3aEJEcDh0S3I4NjBmb04zelFzRkZmUWdoU3c5Y2t2NTQxVWE5RjdROU9u?=
 =?utf-8?B?Z2hFR2JwUnIzTHNBbjQxMWF1U1RiTWxkSG44QjBuSXUwTlpId2xMTGpHaGR6?=
 =?utf-8?B?NGpuWlV6dkt5RkxtUWRFNDlzT0dIT3gzTWIvbmlWczRlb2dvZ1I0ZHpWZzE0?=
 =?utf-8?B?K3ZUMndlQjVWS3R5N1ljbnZSc1g0R09RaVJON1JZeWNpSmZxbWpDeHVKL1Yr?=
 =?utf-8?B?S0RnNHJxMkFhVFVhWGs3a0pvbjNsWjdFRS9MSWNYZFhEQloydDB3ZklLNmU3?=
 =?utf-8?B?b0N1QytPak5pdHRBbkFYYXluWHo2NTQ0YlM3VHJ3OVg2WE1PZDc0WTk4Z3ZW?=
 =?utf-8?B?TzBtalVFYk9UV2FFOVJFNHZMZG5PWnVEem9ZcUpMNG9SK08zMUVYWGpSWGVV?=
 =?utf-8?B?b1hkSVdaZG5naFlEL2lUdG4rSlp4U3JrSlZuVmxnMCtZWEFIT2JETFdxL1JK?=
 =?utf-8?B?b3RORnVzeFZjak5XRHE5TnZQRkk5R3EwL0JWWXhTalJJbTByM3pkSy83cHgv?=
 =?utf-8?B?MFJ3YUZhOFRrdGZnUm9QTkIwdjJieDk0aTRtM2RucGJDc3M0V3V2SU9Kd2RE?=
 =?utf-8?B?S1ZMUHZVUFYzYWFaM0NvaGtKOWsxQWdXZVUzZVB0dmdSZFNCN3oxRi9KYUVz?=
 =?utf-8?B?UmJZRkdWdkFOZjQrVHFwdVBZT2JBQXpYN3pYa1BTaDQ2WElUd1dRT3dkMjVv?=
 =?utf-8?B?NCtNcXZlTXFuTW95Y2lHQ1FFZlJXNWtDaGdEa0hnNzV3Njc1Y1c2VDRuR0N3?=
 =?utf-8?B?UlFGajZsL1hLRmN6bDJ3NHVoMnVLUkVTV25YbDJwQ2FNRDVFWHM0K29GYVFB?=
 =?utf-8?B?SGFNcGhPOFM4ZytJUDFmSkdDSXk1WDBnUFdUTUN5M0dJa051bjBuYmp4NGEx?=
 =?utf-8?B?Zk9BSUtOZFRBRHVDVElYWjduUHFSZk11c0JQMitwYi9seC9lYjZjc0lYYTE2?=
 =?utf-8?B?YTFoaWpvVTZJUDZpRzk1UEdvd3I1L2dweDhSclZoNG5hWGhqMEhBQVVCOTlG?=
 =?utf-8?B?TUtOMVBzaFB6NHo3M3duOTJ0WTR2ZmFzbXVvSkZUWEVXVmtBbC84T1NjT004?=
 =?utf-8?B?eE14czFGZGUwZkpPOTlYbTVSTTcrRmxBUkFSd3h6dWxVbVlSWE0vMWhIalFJ?=
 =?utf-8?B?OHl0UFJJakpFRVVDRkxxNGR6NitQdmZYc1RsbXF2NHBMT0pOUzhaZnF5Uy9Q?=
 =?utf-8?B?T21QcSt6QnRXblFXYldhM3VWZ3ZVS29oN2tlT2xtTVBDTGs0Uy96bHphZHFC?=
 =?utf-8?B?WDAwTWdjcmZRWGwrM20rSHpMUCtVTE94ZVBTeUI2VFFkNmI5VkNrUEZ3VHZn?=
 =?utf-8?B?U01WUVl1ZC9NaUM5ck1rY2FuSFB2dmt1YUFwaGVDN3pzUVk3U0JFcE53PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WS81czU0K2F6WkZtaWZ2cmdKMFdZajRWWDB1VGJ2R2FLRFU0UkE1Nkx0Mmlr?=
 =?utf-8?B?TVBzam9sODRCd1lxSmZ6WHpnb2k1TVFhZkVuRitKWi9DUitqb2hKQ1h4UTNk?=
 =?utf-8?B?djI1eGtBWTQ2dkxTR2ZoQUMveTNiL1VkRTJoVjN5bnF3TzRFa285dHA4VFFD?=
 =?utf-8?B?TklDbTdwSVRtcEcxYS9yS0doL0Y0WGk5ZDBCV1RNMHpFVEZQUHdHUmo3U296?=
 =?utf-8?B?UzRDRkZOdndtVzNLL3d4QktucnhsVWl0WHdzZnVSV0lYK0c4L0hXL2wxWlNO?=
 =?utf-8?B?d0hCV2hJTGZFNlJJVXRPMFJUWHUxeEQyNVJkQ1lSb3oybThzUlVVWE9aTnpS?=
 =?utf-8?B?R2NjbG1zVXJyWmR6WXFGTnp4RlpycWR3WFk1SzUxRUNMUHFyVWxLV2dHQmN0?=
 =?utf-8?B?UUZGdzRuMk00dFQxVEY0dGhJUnhHNVpGeFExNDUzOWZkMlJ2ekdCZ1ZyM1lx?=
 =?utf-8?B?WEdvMVpuMXJGbnJBQlJGQ0dpVGFuKzVQN01CS3J4MjNLcDlPbmxUS2N5Yk1V?=
 =?utf-8?B?eUtpUHJmVmRybWUwYnA4SlQyNk9oTzZsMFhmaHMrMjI1alV5eHozNkVoNGhU?=
 =?utf-8?B?SWYxbnc1eEwxcVZvdHAwcCtoY2h1ZkVyR3Zaem13UThKZlBCYTd6U2Ryd3gz?=
 =?utf-8?B?MHJaYjY0VTFKN3l2RkkwYXdCNm5aVHJablFJS2VGU1AxSUFoRUZVcFZCTVkv?=
 =?utf-8?B?TkdkdFVFWXR2WmZmakdtTUR2V1hWZTYzbUtXMHhJd056UmhTUXdlQlZCZnBm?=
 =?utf-8?B?aGtoUEptRnV4NVVKSzV4UStpZ1VyWWJYckdvZTFCYnR5blE4amtuaE0zVGJS?=
 =?utf-8?B?SnZyQldZU2s1akVBcXNEcHF5dnRNblBCWm41OGc2dUMyZkdKK0tpWTV2UEFE?=
 =?utf-8?B?WnBPVEw4MEM3Mnl4RUZEanVnQktBdzAyNVorbVNncnVrQUJaSnNUQWZnWUxM?=
 =?utf-8?B?K0NGaWt0czZGQUhjWjJDQnFGTnBVYTZYdUQydEZwQW1pVnZPeE0wNkoveE5V?=
 =?utf-8?B?MW5zNzJMWGJtUFZTbFV0SGRaTnFreFAwN1BVWWxKS00xcTQwdUlqd0dzUWw4?=
 =?utf-8?B?RURTUXpDdURCSlBsL2x3OE9QQTE3a1dXcTU1NDkxckZtTE9MWGF0aGlpNjc4?=
 =?utf-8?B?dm1raUFXZnJxN1lCUkRhbDFFV2dRZmVVYzc1bHV4SE1GYi9HV1lJcDEzUEJ4?=
 =?utf-8?B?THZRbFZnQ2h0cTRWcjJiTlFNa2dKazV6dnExY2RLbW1GbkkwU0FVaDdHRHIy?=
 =?utf-8?B?K0pmNHNvOTNjR3pzWGhJclR6RmpBdGk1dUdBSnFLL0VCNkpNZlRvNWxSTXdx?=
 =?utf-8?B?ODY2SmFYMzkxVTdJV2FrMnlTRmZoTUxtajhDNjh1TTBHTC9ENWRqRHBPRFM3?=
 =?utf-8?B?TjVVMEEzZFJHcEo4NjBPUWU2ZlYrVHJIdDU0Z09OeE9jbkVsRzFLTTBPYTFD?=
 =?utf-8?B?amxMKy9rOVJyQjhiVGtHS1Vub2lnTHJ3ZlE5cEhqR3hxbFJvZ3VDVEc3UVVQ?=
 =?utf-8?B?eU0vR2hzKzUwbGdDOFVSYis1TnNUUzVvb3lwMkJla3pFTTJDMWpnWEQrTzhn?=
 =?utf-8?B?WXd6WDJ6L3ZBQ1NUVjExamFQdWZTQ3prcGhDNS9XQlo5OXlDTENQeFlDMTZH?=
 =?utf-8?B?Vk1sRHpyMEs4eW1CVWlCWlpGbEM1MTFuQ2hYNVZWN0FBcnVKa3IzOVRBTUg3?=
 =?utf-8?B?Y25FRm9mMlFLMkNyVDA5MzBHU1k1bytoeFNHd1RIdlRnd24zcVBXS28yei9Z?=
 =?utf-8?B?NWVhOVY0SmZWWUhDc1puMGR6OVNyUkRlajhsMTVOWUFsWGFlRXllN2Y1dGFF?=
 =?utf-8?B?T29lSW1tRTYxOUVQdWNudjRFYTNWMmVhTWhOWCtnVXhkbE9mNlpicHpOL0Qy?=
 =?utf-8?B?LzVUT0QxV0Vra0xpY2lrQlg5QnJiaEdJd2tieGZlYkZUWDNwY3ZVdmJsRmt2?=
 =?utf-8?B?eGNCdTFnTmtQVkNjT3k3bTdiTHBDb2hveWdteGYyZnc0c1RsVVlLaUFZRm51?=
 =?utf-8?B?ajRmWllaNWQ2SEFoKzc3ZDBWbVo4Ym5FSGptK3FMZzBUeWRaYVFtSHJaeUYz?=
 =?utf-8?B?N012ZjBIdkNxM3BnWW1kOVBGTFhNS0oxTDFONENiaTB5ZVFHd2NqNzhaRWxz?=
 =?utf-8?Q?gwPQ00liBlc/LiOJCvtlWh+h7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be5f3d3-379c-4c30-6145-08dcdeb84136
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 05:50:13.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZUA4s8fEWLR4Eg2kNffQfjBDc2MIZjZ/hEVQI1VwvZqLzPq22VOs5C+fzpcp0ZW0h+qvI2jYWBJcK+ox++vWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4810
X-OriginatorOrg: intel.com

On 2024/9/27 04:03, Nicolin Chen wrote:
> On Thu, Sep 26, 2024 at 04:47:02PM +0800, Yi Liu wrote:
>> On 2024/9/26 02:55, Nicolin Chen wrote:
>>> On Wed, Sep 25, 2024 at 06:30:20PM +0800, Yi Liu wrote:
>>>> Hi Nic,
>>>>
>>>> On 2024/8/28 00:59, Nicolin Chen wrote:
>>>>> This series introduces a new VIOMMU infrastructure and related ioctls.
>>>>>
>>>>> IOMMUFD has been using the HWPT infrastructure for all cases, including a
>>>>> nested IO page table support. Yet, there're limitations for an HWPT-based
>>>>> structure to support some advanced HW-accelerated features, such as CMDQV
>>>>> on NVIDIA Grace, and HW-accelerated vIOMMU on AMD. Even for a multi-IOMMU
>>>>> environment, it is not straightforward for nested HWPTs to share the same
>>>>> parent HWPT (stage-2 IO pagetable), with the HWPT infrastructure alone.
>>>>
>>>> could you elaborate a bit for the last sentence in the above paragraph?
>>>
>>> Stage-2 HWPT/domain on ARM holds a VMID. If we share the parent
>>> domain across IOMMU instances, we'd have to make sure that VMID
>>> is available on all IOMMU instances. There comes the limitation
>>> and potential resource starving, so not ideal.
>>
>> got it.
>>
>>> Baolu told me that Intel may have the same: different domain IDs
>>> on different IOMMUs; multiple IOMMU instances on one chip:
>>> https://lore.kernel.org/linux-iommu/cf4fe15c-8bcb-4132-a1fd-b2c8ddf2731b@linux.intel.com/
>>> So, I think we are having the same situation here.
>>
>> yes, it's called iommu unit or dmar. A typical Intel server can have
>> multiple iommu units. But like Baolu mentioned in that thread, the intel
>> iommu driver maintains separate domain ID spaces for iommu units, which
>> means a given iommu domain has different DIDs when associated with
>> different iommu units. So intel side is not suffering from this so far.
> 
> An ARM SMMU has its own VMID pool as well. The suffering comes
> from associating VMIDs to one shared parent S2 domain.

Is this because of the VMID is tied with a S2 domain?

> Does a DID per S1 nested domain or parent S2? If it is per S2,
> I think the same suffering applies when we share the S2 across
> IOMMU instances?

per S1 I think. The iotlb efficiency is low as S2 caches would be
tagged with different DIDs even the page table is the same. :)

>>> Adding another vIOMMU wrapper on the other hand can allow us to
>>> allocate different VMIDs/DIDs for different IOMMUs.
>>
>> that looks like to generalize the association of the iommu domain and the
>> iommu units?
> 
> A vIOMMU is a presentation/object of a physical IOMMU instance
> in a VM.

a slice of a physical IOMMU. is it? and you treat S2 hwpt as a resource
of the physical IOMMU as well.

> This presentation gives a VMM some capability to take
> advantage of some of HW resource of the physical IOMMU:
> - a VMID is a small HW reousrce to tag the cache;
> - a vIOMMU invalidation allows to access device cache that's
>    not straightforwardly done via an S1 HWPT invalidation;
> - a virtual device presentation of a physical device in a VM,
>    related to the vIOMMU in the VM, which contains some VM-level
>    info: virtual device ID, security level (ARM CCA), and etc;
> - Non-PRI IRQ forwarding to the guest VM;
> - HW-accelerated virtualization resource: vCMDQ, AMD VIOMMU;

might be helpful to draw a diagram to show what the vIOMMU obj contains.:)

-- 
Regards,
Yi Liu

