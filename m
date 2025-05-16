Return-Path: <linux-kselftest+bounces-33168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBF5AB977F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 10:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9744A4DFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8F422AE7A;
	Fri, 16 May 2025 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEn/x3Wd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F551FECB1;
	Fri, 16 May 2025 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383870; cv=fail; b=gOwqNn2coks6TND41KHrcRoExivztWsvjr0JvoHSOhTUyjeQ2BUO7wV+Qk22FIuEgRrO9omCwhgzCc7S+MXl8Xnrsa5Dt+e5MttTdhEWoNVbwIMmpsZKmt4V0QDRyb62G33gIaBvfNQSUiQ7N+vihmlI3WC0yVLUs8/jbBhVENY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383870; c=relaxed/simple;
	bh=qxi4xrEeX30jTiJK9/EmTUCBB7NfcALGRZER/A24ups=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pXuMq5VkvwCRzn/Rr+oj04D9/qbwZTNYxp6R9Ixv+BE6jQ9JvwvOaR765AeMV6dO4+zUoJxEINEkwddB8PmT7yWIL6Q5E/l55l00L9XvyArfy7CmLl2TLJXO6XCNUOhcFcSbVsBjQI9gBp+9NZTIaXmkwbAq2OJAWy2HZz6VAxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEn/x3Wd; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747383869; x=1778919869;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qxi4xrEeX30jTiJK9/EmTUCBB7NfcALGRZER/A24ups=;
  b=NEn/x3Wdpq0yZCseUWS5WnPujKtLIyzhCquYvtP40mp0kyJAY42efDEb
   XmVZHVjWFNgj+OzdQGJ71k8OnxJ2+GByDhxM0FAjxlHkTWZTzK+yD+flm
   wcIz2CDJlbTgN4dM2Ml/l0Cl5MFS7atf8r9c26W0cVTTw8ASqA25+mmKt
   T/0Wku963SVYO36PYgqF2VDPL8c2OpwxGHMM/UqfPx40c3/gTLcz5WLRg
   K97XrGQIx62/nmqQhsUg1XWscwR1ry0j9ORwRodjv5D4DS3bwEONW6eI/
   MjZbGJDU/un43Dfvfdbs0HjGjCk/JMtHw8Ih1Axm60PSndhHTlt3mkmIR
   w==;
X-CSE-ConnectionGUID: FbGhnARVR02MU/oKCTwdng==
X-CSE-MsgGUID: QKxLrK4VS0W3/5ztHPlbTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49246695"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="49246695"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 01:24:29 -0700
X-CSE-ConnectionGUID: ABBMddyDT/Kk68r+F1MSBw==
X-CSE-MsgGUID: AxkIxnglSKC+xIFcy7DOow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139630151"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 01:24:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 01:24:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 01:24:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 01:24:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWVnoz/IBMtTc69f9i7wKVchaF87HtA7w9WcXnSxREbnL1I2mIr9sTO6dkOnYf1Rfmrebc18cXE5k42ui2Wa7SgycfGFz+eH4jiE3YyrooIOqqoPnIw0LIuwC3NLgkH/G7HCbyqc2vkxq1L6R7KvNRu2YvLp8zJMNI8pTZ3kNVmof2XjnMyMcg41kDR5YRDgQZaZj2Y8540KxsPxh8k4A+bJq8NqmM6DicQxPJ72gpmEGoZ0b9TwbZV756aGMMG5IhodRezvLnjXVr9DD7b2so/wmIleBIfutuSqq3w1OclOpphaqev6pO+L6c9CLZoLhKp509CSjwa6nJ1an/4phw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXwDhdnaQR+kPUks9lDVZLQ/JJGuRjFESlrDIkn+9s0=;
 b=bxs5esvupEp++nbjfffcDwiShUnPqNwer2dfV3bu4wk9Gso/VZsT5Gh0f4OLqQMsEv1gIbaXUznwfSZHUfGqKiX8wO+ERHkKfSLewg8vjNUmsBXoy6qSBlkTV5PhOpB2egi3yZvX9xnsPx4IGhbyjIpEn5id3BJSl3KuP9/dFzs1dEBwcaVtsYouf5B4HAWIyw9xV6hecYZdMIfXGyu3uQRKoqXODWmmN4nzUN1Vu90ea3D/9/Os53O7HIQvllHxvPHeFSiWCYinEEv8gp7faoMYPaqeNEdSjk9imvF837YSKU5+CifOr9aSdD5+DyP0DybCILCL40XEo7mUKN6rJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 08:24:24 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 08:24:24 +0000
Message-ID: <792fbcfc-430d-4d3b-aabe-51cfb6d689a2@intel.com>
Date: Fri, 16 May 2025 16:30:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] iommupt: Add the AMD IOMMU v1 page table format
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Justin Stitt
	<justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<llvm@lists.linux.dev>, Bill Wendling <morbo@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>
CC: Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	<patches@lists.linux.dev>
References: <4-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <4-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: edd27d41-99aa-43d6-bd90-08dd945310d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUN2eExaSXppOGdWRlBYZFlUUVN6Ym5mSEVBZXBUNDc0QVJBQTBXMERUc3pk?=
 =?utf-8?B?U254cEs4WU1YYnFSU2tjblRHdUs5Z3VZd256VFdPWE9ua040SGZXSTF2SWdp?=
 =?utf-8?B?ajlmMVRGRWovcmtxRkpWZVpQbWMxZyt3YWhvY1NxZC9IbW13c0xaM0x3ZStw?=
 =?utf-8?B?Z2NOME5HZEdpeS8xdFFRUEo3aXIwTkxPM0pGaUJvZ09TY3NtRGk5MHdaM1Rt?=
 =?utf-8?B?QjU4UmxPWmtwWlorbmUrUTk1dlRQejMxeXVZNy9POXFwWVo2SGRmM1hZODdW?=
 =?utf-8?B?TTU3VExFcTkwUkphcHZJcXh0NTF6Q3pYWm9BRDBCN1gzOVZqemlOTnVyeVBG?=
 =?utf-8?B?MzRaTkFmRjJPU280MWNHeGZCajFzeXV5bTN1SVlPZFRGQWpiOXdyMkd2dGYy?=
 =?utf-8?B?eEdVQjFobTI5SmE0SEpDM0V4b1BqNGlrR3owbHdGTm90UHU5NnpUa2hlQ0Rt?=
 =?utf-8?B?VS9qV0tZbVpYZVZtRHpjWnU1QjREN0NmS0gySzNNUXFnQXh2SWJQbEVOSTBB?=
 =?utf-8?B?TUlGWDdNS0pHbERHM1Ewc0NGVGpVWktkZkFXTmFscm1ZallIRE5QWmJQSHBi?=
 =?utf-8?B?RGpLMWJTUmFGaVphZGY5OHFNMXBiUWxJazVBckxDL2RpMzU5eFBOdW0wZHcw?=
 =?utf-8?B?WFc4d1gvWmpOcm9kRTQ4bjN1VGE1VGJHVUM5T3FHNXc4QW9GdUlGMWxGZE9U?=
 =?utf-8?B?ZUhjTkora0tnYVhxbUQzSURWc2RHcWNEM0JtdEl1MUlUUDQ4TUFTNWZEMW5a?=
 =?utf-8?B?RHJGK2hRMGJJc0FzbWdSSUlFNTRXUHUwMjQvS3dIZHA3elNySStGd2tmb1cy?=
 =?utf-8?B?N0sxdTNhOVFKMkhrL3BPUjVTRWxwRWxWSmVjZ3BDMnZieGdxcnhOU0xRQkFZ?=
 =?utf-8?B?dXlObHlRcTN5eUl4WW5WOHZtdnlVV1BkMTd3Y2ZKYWZld0VacW9ZYlpwR3Zw?=
 =?utf-8?B?MTZCc0FjL2lQbS9FcVFFT2dQTS9KSURhVkhwWktGUnlEc1ZHQ21BRXBZeFdv?=
 =?utf-8?B?UEVQNWs5WjNRSUtxUHNMVUs3ZkdVeE5IczJVWVVGdnZpRDJ4cDZwS21oKyt6?=
 =?utf-8?B?MFp1MjNzRk5hU0JQb2tkblNSdStYVDJIaG15ZE92cFJodlpGRENuVDg0Y2pQ?=
 =?utf-8?B?T2RnSk5wcWNiSkszOHVsdWlUMFBycm14SnM4SmltYmVHOVhBYTZTQlUwU2Vu?=
 =?utf-8?B?WllGL1dsZGVnSlRGT3Urc3pIS3U3WWVpMFpNQkc0a0l6V1FERGxtU0dBVG1p?=
 =?utf-8?B?V1plakV6alFXY09zQ3FFVEZkVEEzNmVHSDB3Z1V1TnB5QnJzZ0JWQzlFVmdI?=
 =?utf-8?B?WG5jWURCU09HeWo3dUgzZlB1c1lxbEEzZFVqZGxuMitKakVaWE1yOEtpWktS?=
 =?utf-8?B?c2d0YTBlWTQ5eUJkUG9JT0FUSWM2bzhqbUwrQ2lpQUlsbTQzZ1BjTElraVE0?=
 =?utf-8?B?QURQbnlkTVpLMnowT2g1OWVFZnNyZ05uN1VFMHpUNmx6d21IMThvV3Vaa2lB?=
 =?utf-8?B?ZllXOGVTZm01Qi9mcUdhdGRyd0lMZHIwbG5zNndJTXhTZjVpczFMMi9uenFw?=
 =?utf-8?B?cWxxaGhGQ0xyZDVNM0FLdXBjL2VzbWgzUkc4ZS9pR3BQYlRVNHVsUGJVaFZq?=
 =?utf-8?B?bC9xUFIxb3o5K090RFV5Z09aV3pEcTNlRTJCL1dLYnlLOENyTmI0OEhTbEVv?=
 =?utf-8?B?aVFQS3RiQ0I2ZGhIRVMxb3F2L1pBMVdzQ29UMFJ3bTAxK2N1Qm51dVFTTTdl?=
 =?utf-8?B?VHVUNVFGWmt3ZHBRL3FMY1pkbmhHZFpsL3FZbFVCZ3puMVdaaWs3NTVuZkZR?=
 =?utf-8?B?ZlhsSFBKY2RvZHlTc2F4aGk0emNRL0pVQmFnYTI2eTNzeDBRSkdnaC9Oc2pr?=
 =?utf-8?B?THNVM2RwMVB4NThTSUtKN1hRN0ZyZUxxQm9sYU9qSWw2d1ZqelFZWXFmUlpT?=
 =?utf-8?B?TWUvR0paM09ZeGR5c0RkQ0sxMjhRTVZhL3hwcXpwb2RwT083MGhTMVQ0VFlT?=
 =?utf-8?B?NmF5VENDWEx3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUFBMGhYWkhBVE51cGFJRGJlbzJheEdZczFxMkdPaEZkajY0UUZ4RGxSK3BN?=
 =?utf-8?B?U24zblZNWURXVXVYUDhaOG11SWhsNTEwM3hnVEM2dDMwR0xudWk5OVVQdVpq?=
 =?utf-8?B?UXRNSWNjSmZyS0hMRCtiSEhuVGVMcU5zVnZMQWhxTFI4K1AxbEdZQW9hOVlp?=
 =?utf-8?B?ZDhUbEs1RzUrbk1rT253dFFxTHdPdnZYZWZmcG5iUjM0bFRJWWtSTjdKeWlH?=
 =?utf-8?B?VVFOdnZrZm1lTGhtRzlMZ2hKemlYYnhTUWlwWkdTNDVWMGdOMXlMdm5vQmd6?=
 =?utf-8?B?R3NMRXprM1IyWXQ4UnhCallFRDZ4SDc5eTRHU1BYbmxsUGJQbXl1RVRxVHM5?=
 =?utf-8?B?ZzhGYjlPOFBWKzFWeHora3RiVzVwOUVZK1Rjb2taQWxvdjVhVWlGc3lYUUdS?=
 =?utf-8?B?MmNYc3lKZGdTbkt3c3lUMUFTa2x5anpKRjNGTExWcGIrZ1lMeER5a2g1ZFEr?=
 =?utf-8?B?U29IUHVjdHdxVnNjS25wMXVka0xZdHoyWjY1aG53VmY4dWMyVWFJTGd1STJE?=
 =?utf-8?B?ZWJZK0NJemdIT2tKalFTcVpvSzRJUzhOZEJDRTVCN1dyZTNDZDdJYXM2RGht?=
 =?utf-8?B?SDdHTmZMcXhIeDJzVHZPMktqeUd6WGhOSGZ2ZFgzclBzR3haaDRULzJRa1VK?=
 =?utf-8?B?NVhMOVJIRzhxTC9wTUxmbGlla0xkRER4K0Rna0tyM2tHUzVhdDg3NXV3aUJl?=
 =?utf-8?B?R0luYXNJRkovWjliWWpsL2FxVnNPelhzYVg5cHU1RHhOaXptU2Zlb0NTVHdZ?=
 =?utf-8?B?ZjkvMVBmSXhYQzlEZjJhMTI3Vk4wY3BMNjYvcUJ3OHIrR0VCbHpqd2k1SDNz?=
 =?utf-8?B?Q0o4ZjJ5RVJUZm9QMStCdmphSkFwQWdHZkJnVDlTQVNtZlQrZzFUOHF0Z21o?=
 =?utf-8?B?clozNXNVZE5UcEE1MDFzVmFETEtGVlZrZUZKWENzREZvbWxsZ2xrOWZNeFBo?=
 =?utf-8?B?L2c2RHBMZmRFR0ExY3dZMjh4L01YMGVXWHozWlJhTERpS1M2RisyMVJBRFho?=
 =?utf-8?B?WU5Mak1UclRxRnJGYW1ycUptM2RLQzg3d0t1RnRpK2tBL1lkcGtlL3lVKzdP?=
 =?utf-8?B?Y1BnS3ZteVViUTNObExFdDJwVXBzM09kRUFQQ2V4V1hPYTM4bUVzdW5kWGlD?=
 =?utf-8?B?cDAwbVdUa3BCZ3ByNUt6ZHFPbGxKcjVxUDR6MEZsQUwrZGxrU1ZZVVJQVU1s?=
 =?utf-8?B?ZkRMd1h5NG43R1J3MThlM2JrMkhGK0NuU2MxaGZUMXZrYWFCZ2VQZGIxZnZY?=
 =?utf-8?B?enFFY1NuOE5JYjczRFVZNTRTM0V6eGJTTU5lQzh1K3dRRjhtVWxKS050YURj?=
 =?utf-8?B?S3NiOU5USWZ0aitIVkU1YW04RWgxbzVWWkFqQVNTd0w1QjBOV0FHb0FsZ1Yw?=
 =?utf-8?B?QlMxdDU1Skw5OFlCMm9vVGNyejBnMzBycXJMY1A0eWRqQU95cWZ4b3VTRHd0?=
 =?utf-8?B?UTJKVzZaR2FKVG1vVGkwU0tkb2ZRUEcwcE82VFI1S0x1R09XN25FdkF2MTNs?=
 =?utf-8?B?V3lQOTRnc2pTSlFsWXpYMGxoMEdUWFcvay8zM0xSaFlZdHFMb0VnUlh4Tkxv?=
 =?utf-8?B?R0FnV2ZuaWtNOVhNWGdnWjVZWG13SWtoRnpUOWNaL0hDSXdWVUhnSjg1NkZy?=
 =?utf-8?B?UWZIcnBlakpVbUkyaURtM1BxU3N2TCtwMkxmYUZpZmFrVy9GMVloRUhUYjcy?=
 =?utf-8?B?c1UzQW1KOFMrbVltZHZjcUNMMEEyQ254U1E2Q054Q3dIUTcwTktSL29BMVJQ?=
 =?utf-8?B?VWN6c1NMYlM3bVZTZCtGWTVybzZHOWxFZHZIQ1IwSG5lTmpSdDhnNzBXTWwr?=
 =?utf-8?B?ZjNSOWNBZldCald1d0hLQ0lHNzBSaWg5NGNxTGx3eDdhRE4wYTlXVEo1bUlh?=
 =?utf-8?B?bHFEVTBuRi9vSUJLdjlBUi9FZS9VUG8vUysxZnZ3WDA3RkI1SzIrMUU4c3pV?=
 =?utf-8?B?NFhuWGVMQ2pkMlJUb2RPbTN0Y1Y3bk55YVdIRDJCdjJNb1JXSEc4K0VHdUN3?=
 =?utf-8?B?YkN5aCtLeUtjUndXemdNKzRJOXFNUnp0NENpZVRqWXd5ZFdOZy9jdkk0Y0xK?=
 =?utf-8?B?aUZ3d2NIak41RjZUblFVVzJCVFA4Vlh1ZEZHeE5hNXFLS1NWczA1blpKUHVS?=
 =?utf-8?Q?axBsxEkRlTMCBVfe8wwPEpEij?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edd27d41-99aa-43d6-bd90-08dd945310d0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 08:24:24.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gau2NLkIsHDjFRx4zIcoFd398LbqEkpSA/k/N7fT1i8FxTfimpVCtjtbrrLhNCUdptEsXRRj3UX4NeiKJJeLJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com

On 2025/5/5 22:18, Jason Gunthorpe wrote:
> AMD IOMMU v1 is unique in supporting contiguous pages with a variable size
> and it can decode the full 64 bit VA space. Unlike other x86 page tables
> this explicitly does not do sign extension as part of allowing the entire
> 64 bit VA space to be supported.

aha, do you mean the canonical requirement on the addresses when talking
the singn extension? Actually, VT-d 2nd-stage page tables does not require 
it as well.

"canonical address (i.e., address bits 63:N have the same value as address
bit [N-1], where N is 48 bits with 4-level paging and 57 bits with 5-level
paging"

-- 
Regards,
Yi Liu

