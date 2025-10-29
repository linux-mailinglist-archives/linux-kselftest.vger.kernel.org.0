Return-Path: <linux-kselftest+bounces-44321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40999C1C465
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA843642185
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2D3325487;
	Wed, 29 Oct 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHn/Y8iJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687A3358C7;
	Wed, 29 Oct 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755864; cv=fail; b=Ug5YfLFRIe4zPmX0daoTaBrwWsTjIlKroo1Gas5dZh5ST9pqsT5ouHWTgcSFDNCGUdyUJj5ggT+zSjlzBtrrHjpfwBUDYrlxkJ8gObkKkcn0aD0YMEgb3TyGAvSbdu5zqqG9AgOZHrrbJ7txjpJ1EYdFs8obsrRUc0ZbTlLlUfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755864; c=relaxed/simple;
	bh=5lT+vH4xAZLnLJ3xY0YSvxrnBdY2qKJUhvchc/4hkac=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rC2UlPz8rz/doNkLwOD20PFhSR5zF1IaAo6HqCn6CrCuAumNtLc2UsEzoPPjKCKjDM5iZCmcWs8xcIpSNvNXSxvU6VnqfsjPrRBqEuUwRcIHF6NOm4fU9MklVJ11LHMEnpd6Uuu6VM6/OTckGYJIcLvI0DHu5EIiK9K8CziXXRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHn/Y8iJ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761755860; x=1793291860;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5lT+vH4xAZLnLJ3xY0YSvxrnBdY2qKJUhvchc/4hkac=;
  b=JHn/Y8iJ1nXZKhFfqQUv+uDmhpHTxC8oGZTkZvsBkP9oeoQtenBOyRnp
   QBByLBwoScLpw6Zzeh5ddZcj1dp+QPE/ygxNrNglM1WZfqhSaS/trD3u3
   w9T/a4z0Rhyvw3U9BseW4lNFnfzs0TCkaIQwU2XOgeiLR5I6v+Qz9S1LM
   zWaRuwhFQoQNod3ADqL1reiNuN8thKZSb9eadJZFgwi5dgFIFPNzBRYBv
   T/JsfAgKb7hcdsFaF1D83DF2I+j9eSfRTuJ1Gks+A5wi8WWGwnopzAiJH
   GXQ5sJk4VN4P75eWwXJtObG76jwMiuM9PQ3onI5ya31XbixKh/KPQMYAN
   g==;
X-CSE-ConnectionGUID: o/jbbgDrT1KQUlfbxuz5tw==
X-CSE-MsgGUID: X7zi5bn9SgOnjToZPNgJlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74482952"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="74482952"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:37:40 -0700
X-CSE-ConnectionGUID: 4mGLIe9hTeeHJmUVro/p8Q==
X-CSE-MsgGUID: zZN1/XsWQQmgnBIQSKB24w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="185597697"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:37:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 09:37:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 09:37:40 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 09:37:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+ttGbrUz9ID3rTYOHK3Bftr8/EuVHrnkk2UmBTHKSYu/zT4BaaGRjhQBCSCXSGnSclEspS4NzrN+0PBGPESN7vEk1vehZXpSlthHGnUzz01bX8781N2i6iiZIOxBlUXuLyh1TJ5favL2Kyp08u6HBsOfSYdNDTXvVy0rlpoGSiyz5qLL4r38aGq64lAmEQmdtV3FC/7cUjrXoEDF25HCRWdz5483qYWnY8TkImCnzeV12d1Hsv3bP3RYMTygcNVWbibVLxqBXrEUSkRf82+7XLdCrx0eT2sWhyXK7qp2JxVlRIE4smliuPxBhBH0vJwmUmSneChnY2G2TXCVqO5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/aMSXQM/QdjpNJdPPDM/wqLRh76C+2OXpt/4tIBLo0=;
 b=weNzsber8HEPYM41M/G6MiHadZzcTRgI/uZKUSHUjm1C2sCoxbaTZ3Zczsaoke6Vts12SVCiFx4U2agOyWF+ED3m1hgnF5qGYfzPAm7cHc+eAeTiyF3XrDkWYB/m/vcuidO/J9Wcub8o1S0IR1LtYnHpK3vsjcAaiaCG8HQ8wUqZDNBB0TrqC/KwuATg1mofn6H3OmDbOIkftNuAqoxDmCBIyupWRzsNlet8WQRkT8qkRph+vs52tPSabBWkSAbQ1DQZWkpFaTn/VA/DfFDO3sic8lGQnuL540Kle0/zx0QmFI7s4QZKJXqEwV5Ci4PILPhV6xGG+MMTIYVdMdnT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by IA4PR11MB9442.namprd11.prod.outlook.com (2603:10b6:208:55f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 16:37:32 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%5]) with mapi id 15.20.9228.015; Wed, 29 Oct 2025
 16:37:32 +0000
Message-ID: <d4813147-920e-40a4-a7f7-e93666c77cc1@intel.com>
Date: Wed, 29 Oct 2025 09:37:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/23] KVM: selftests: Define structs to pass
 parameters to TDX boot code
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-9-sagis@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251028212052.200523-9-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:303:b5::32) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|IA4PR11MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8ae3a1-5414-4f8b-abc5-08de1709754d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmJDcUZCRlZZNGpGaHh6Mk1xTEtIcVFMZ1Ztb0drb01iM0JBSnhjMlg1bHNq?=
 =?utf-8?B?YmNHQ2IveTBYeWVWS0RlYXhocnh2NzNxd3pXWFFBNEEyS09jVXJoK3RRNFlG?=
 =?utf-8?B?Z2ZFc09rdzhtV2tzRitXc09obm10cStkNDNhNElOcXZnb3NlNXRQVGVxMW0z?=
 =?utf-8?B?REt2R0lVdzE2SFhxSEhLMmh3cEEvVzlmQk1XM0FkZ1R3WkFLNWJScUJNSHZp?=
 =?utf-8?B?ejRhMkRWNGMzOEFJRWFQanJacjdzeE9CcEIxK1lEcDB3amlqTzFndTlTaU80?=
 =?utf-8?B?REZ2YnFjVkpjNTE2UXhmMExOd1FEMmFsbkJnUGppY0tkMWJPMEhiZlF0Qnc2?=
 =?utf-8?B?bGM1aTMzaDJRRURSdUsxc2pSMi9kZkNuM2N3bnRMWGhVM3RwdTNjcEdkWjJR?=
 =?utf-8?B?MzQ2VmJLTW1zZ1BLTlVWcWY4RVZEWG8xRFpyaXhYQ1BjSnJjYmExUkJmNG80?=
 =?utf-8?B?cUlOUWNtWEVVRjNrdnYrcnJNZmlONHBiZnJ3UXRkdHJ5ZjA3NVlCcTJ1Q3JF?=
 =?utf-8?B?TnBWRnkxMks5dEJ4M2VoRHBWVHFtbk1iNldMaEdSY1ozZ1ZHSVV1M2xJNUtm?=
 =?utf-8?B?RGlpeW5YZEVMYjNwdHZyQUs2S3dReFNydkFBUVlnbjZpVHVDYzBmT3ZsakxB?=
 =?utf-8?B?VWRqb1lzVnQreFlubUNTQW50U0ZZU1lzQjQ3VHNSajBRV0tnMTJPY2duNnRM?=
 =?utf-8?B?SXozSWxjQlUva1NiR3d4anZ4Wi9TRGtORmJCdUFWVXZycGE0YW9VaU5qUWUw?=
 =?utf-8?B?aUpkbGQxVDF0WTVRL0pDR2dNSmw4dWp0UnZZSWVEM2N3VWxSeUF1UjAzRWNl?=
 =?utf-8?B?Q0ZwWlNhVWkybUFqNHBydlk4N1FJMUJnK2JadklibSs1cDZ6VHQ4VWFIM2RO?=
 =?utf-8?B?bDcrbVFoUjc1clBtZ3hUc29HNERuaWNuMFJ5aVB6NGJPbkRhZTR6Mk04cnA5?=
 =?utf-8?B?MkYwTlN5ZmhKRXA3S3JQcDVJQndRTE5uVWtZYWF1OXl1N2p0VFdzUk5sSE42?=
 =?utf-8?B?NFp1Q0orV1lJanlPTE50bFFZZ3BvQjZDUzA3c3lWYkh1SFlxTU1PVUtrdXNh?=
 =?utf-8?B?Y2l2TGZ6OVlleXVnQyt5VTBXYWFURVFpb2gxeDJSTHlUVGZHcGxUNW5qY3JV?=
 =?utf-8?B?bmpHZDRleFpYR0U4KzltWU9aWEs2R2NmQy9MWDYvZWZreEo2aERyN0VxUkZ6?=
 =?utf-8?B?dEN2Sk4wL1BPaW1MdkFZdmdneU1Yb2VCWGM3S3Vxb05SaU0vQlpEMkdvYk1S?=
 =?utf-8?B?cUkwbVFURFFzSDFqNFQzSm9GRjdoanBVYmRHMURLWkt3TnNQeFFPYyttcFZ1?=
 =?utf-8?B?cTgzcWRkdUFLZWVKREE4QXpSTlNlWXBvU0lFMnBPc1NOb0k0TVh1em9vclpj?=
 =?utf-8?B?N1V0eXliVlR1UkMrS1NiZm02S2djejlicFl0dWhKeEluRE52VytsaFFPMkV5?=
 =?utf-8?B?UjdieFZyYzJVTlhXUDNpSXIyeUNCMlVFSmREdElJTkhyV2s2NWtGcytUR0dX?=
 =?utf-8?B?NTBob0tNdUtnaVhnbmNnVmRMVjNWbkdKMUNHZk94aEhJd0dQcXZ4RGd3dkU5?=
 =?utf-8?B?OThXL1NwdWppNU9iaXoxbzd4UjkwdDdxbW1FZGZ4YTBHZUx3VUlxejBwaUhQ?=
 =?utf-8?B?Y0xPU3dnaHJmNlNhTjg1eCtTanQ0STZPWDZOWmdXVW96dkVOTVhLKzVncjVF?=
 =?utf-8?B?eHMrVEFwaS9DQ0IrRng0dC9zMW5QKzVjRGlacU13dmswWUdsRWVmbk1EbE81?=
 =?utf-8?B?R0V5elA2UkF5dDR1MUNjbmE1aUE1cnJnTWtGVHR4NmY5ckZZcXpPdnI0aGFU?=
 =?utf-8?B?Qm9xVi82QkpUMldWRHhUVWVZdE9sZElLbG1xWG9TN3IwOXpOZjl4QUNiWUpO?=
 =?utf-8?B?VjRSeFQyNktmU1FzclZ3S1NhVkpidlMxNHJQSEZxemFyUEtSRjlidUVqZWNi?=
 =?utf-8?B?ZitsK3FUM1Q1MkJEcUx1elFHVEpMT2RJWDBabHQ5YnpzY0hvSmZSSm9FUk9R?=
 =?utf-8?Q?TdxjYUU3mqVEfV/J0eEx9RiwaH63Iw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkQ2MTYvSWp4OEtVRnF5ZHVYenRJL0psYTYwa3F3bXdsamhCSEtNL2dESHh6?=
 =?utf-8?B?ZXVRZy93b0hZMHJoMzNLN2xlbzc2cjNxaFBrbnNTZ1VRb0VDWG1vMHYxLzRh?=
 =?utf-8?B?WlpmMXRtVHZzdSt3SWlKNUdhQjRuUlRJQ0N3NnZLUEp6NWU0L3ZMcWNnWkFL?=
 =?utf-8?B?TzJlVVRiTkpQV2U3K3d6ZlgrMnB4emdQZ2l1TWIyUml0WTkxUjZrTHJJWjZv?=
 =?utf-8?B?MjhTZWs2ZGVaeTl4Z2dVbjRKR09wNWVDUnpEazljbWFyM0RhRS9zeWdFTXNS?=
 =?utf-8?B?WVNBd2V3T3NoNkoxc3llaTR2QUNWbURLREYzcnZacVZ5dU9jc2ZhemxEQVEv?=
 =?utf-8?B?NW9raERNWnl1WHJPcm8zS0MzcHJQaXdtUlZKaGtJbUxsMitVbGFNSW9oUHNL?=
 =?utf-8?B?SzNjRjBrb3lUM1QwZkJZNTIrNjBjTVFMTWlBb2oxbEpkaWU3VTcvSU4rYU9Z?=
 =?utf-8?B?N3dicVhrSElFYVZtTU9icWRKNllPVFduSUVCNXYwcS9oeGY3Wk5qRFcyaGVx?=
 =?utf-8?B?Ni9PSEdsWUp6Q2djWDhjLzJXaTVJRVlYZDErdDNqTnlQMWRFS1UwSlZXOXVS?=
 =?utf-8?B?Z0lGQnhlUEJCZk53RkNhcFFRZU9UTDZaaGNmQmkvNVNZYS8vdElidU56ZWhw?=
 =?utf-8?B?Z3Z1UVBtVEtOTm13a3VnYTRPZVFRUnlwT0RMbStSS1I4ZWU3ckxTUVFnOHNY?=
 =?utf-8?B?bSs3bXdjM1NMNE0rMXdLTFBZTjdnQkw2UE9VVG1VVkM0Qzg1bk4veVVNM2Vy?=
 =?utf-8?B?SW0zS1VaWStBZlBnZjdSMk1pU0lMR3V5RWtOV01HTlhUSjczSWc4d0g1VDVW?=
 =?utf-8?B?N3hKc0NabS9SZHhxZ29WWDRHYkpqaXJyeGJGR0F2YjdlMU5aWndaeW9jMkRU?=
 =?utf-8?B?MnJxVTlOazlJVllqdUIrUFlrZmIxT0Nwd3lRNjhSQUxYL1RBOTdmTzc3aGgx?=
 =?utf-8?B?dFBabEE2cDd1cUVqMzlmalhBMy9kRngreTlvUzkzakhYUU1QOHBpVWRzMG01?=
 =?utf-8?B?bE80KzRmdXFyaGRjY0l6TGNGWkhJNk9iUXNqNXNtamczWS8wbS9JMEMyKzBN?=
 =?utf-8?B?ZFZjMnlpYndPSllnSTNTNkhKa2RrZDg4UndSQ1R0eGdibHh3d0pJaEVxVmNE?=
 =?utf-8?B?Ullyei81NjRnN3ZRWC9FYlc4cUdsTmFxeDUweW9XMmw2Vi9pZzA3V05ERjcv?=
 =?utf-8?B?K2M2aktkL0hYdkw4aWplSWxJdVZndDhQY1FkTE1pN0I2d2crUXZ6NUo3V0k5?=
 =?utf-8?B?LzRSSjB2enJ3L3UzT2k1TWNHQkJoZHNQV3FiZnZidDc3Z2lqVVJyR1ZweExx?=
 =?utf-8?B?UFc4eTBaQm85ak1FQlpEVUVwMkxvR0pwZnJPSCtQSkcxaml6YW5qQSsxalB0?=
 =?utf-8?B?UzhPRUpZZWV3dFJ5d3JISnlDQkZSK2FxL001dWR6a0V2MW9BZzZ0VU5nRFZK?=
 =?utf-8?B?NVM0NnBzSVVxcFNyOGViR3lGVHVTcDJKWll0Z1JoVXJBUEk0MWh1Y3IwOVFJ?=
 =?utf-8?B?VUdkQ0ZIRktRb1hTdytRRnc0b2lEMW9LMHBjWTF2T0tqcS8wRlNzeGJ2aGhR?=
 =?utf-8?B?SnAxU1VNRmZ3OFcvZE1aMThoaDNEeE42dEFncmdtY1BaOWtGWHpmRjMraXJs?=
 =?utf-8?B?UThXNlpTQUR2bHk5bmpBNkxoUFhVZi9SN1BEbzB6SjVXUXVSYzd4S2w4QVR2?=
 =?utf-8?B?ZjUzdEl5RnV1U1hEcnpsOUlnL1B4cVl6WWtTMGg5UUxSTVg5TjAxWlBOU2Zt?=
 =?utf-8?B?LzA5VXJoUlZWeWdaYUlMMXdHRjNQUkx5ZVhkdWpWSlZIcGZKb1ljSTczcDk2?=
 =?utf-8?B?QUdsUEF4a3FKdEE4eFhZSXdOdkZWbzVuY2FkRDRQOHlLVC9sSmlOOG93S0p6?=
 =?utf-8?B?Umt2QTd3enFEdlZucnNnNnpGK2xDYlBORmpMSmZpT3RydkxFTTV3NGx5Nlk1?=
 =?utf-8?B?QnJmSjhtVGN0U2NXeVVNSnlZQ1hlSjFWcStUTVRqM0xRSi9mMUNNRkRZM2NQ?=
 =?utf-8?B?b1VBWDBWYnJHYjh4eXMvdi9oL2pvWGxGQ1Z6OUNyVm5lNmdROWlwdmJDVVYv?=
 =?utf-8?B?V21GaUs2YjIxck50ampYaFNSU1FjVU5kUGNxakFpVFI0UUlKa2FUZjJ2T1Yr?=
 =?utf-8?B?bkhYc3BnMUs4T1Y1cDlSdFQ3Vkw4VUdWK285TkgzY2pVeHMvdS9Jek1BM0Fw?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8ae3a1-5414-4f8b-abc5-08de1709754d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:37:32.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OC5XNTV/KXMiMOkkD6FnhYrDP3x7TcC4Z8uY7NatPnADnopEeQJSlv3Iu3bHrdDibsO8E4WpwKp4zspFSU90yWIaxjBEullTTH6tuR/+hmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9442
X-OriginatorOrg: intel.com

Hi Sagi,

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> TDX registers are inaccessible to KVM. Therefore we need a different
> mechanism to load boot parameters for TDX code. TDX boot code will read
> the registers values from memory and set the registers manually.
> 
> This patch defines the data structures used to communicate between c
> code and the TDX assembly boot code which will be added in a later
> patch.
> 

(sidenote: I do not know what the bar for this work is so I'll defer
comments related to local customs like using "we" and "this patch" in
changelog)

> Use kbuild.h to expose the offsets into the structs from c code to
> assembly code.
> 


> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 148d427ff24b..5e809064ff1c 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm

...

> @@ -328,18 +336,28 @@ $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
>  $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>  
> +$(LIBKVM_ASM_DEFS_OBJ): $(OUTPUT)/%.s: %.c FORCE
> +	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -S $< -o $@
> +
>  # Compile the string overrides as freestanding to prevent the compiler from
>  # generating self-referential code, e.g. without "freestanding" the compiler may
>  # "optimize" memcmp() by invoking memcmp(), thus causing infinite recursion.
>  $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
>  
> +$(OUTPUT)/include/x86/tdx/td_boot_offsets.h: $(OUTPUT)/lib/x86/tdx/td_boot_offsets.s FORCE
> +	$(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
> +

Some folks prefer to keep build output separate and may build tests using a command
line like:
	make O=<output dir> TARGETS=kvm -C tools/testing/selftests

This is a valid usage and will result in td_boot_offsets.h placed in <output dir> that
is not covered by current include path. A build with above command line thus fails:

lib/x86/tdx/td_boot.S:4:10: fatal error: tdx/td_boot_offsets.h: No such file or directory
    4 | #include "tdx/td_boot_offsets.h"
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.


Something like below may be needed to add the output directory to the include path:

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 2f49c8965df9..98bc40a7f069 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -262,7 +262,7 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -fno-strict-aliasing \
 	-I$(LINUX_TOOL_INCLUDE) -I$(LINUX_TOOL_ARCH_INCLUDE) \
 	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(ARCH) \
-	-I ../rseq -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
+	-I ../rseq -I.. -I$(OUTPUT)/include/$(ARCH) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 ifeq ($(ARCH),s390)
 	CFLAGS += -march=z10
 endif

Reinette

