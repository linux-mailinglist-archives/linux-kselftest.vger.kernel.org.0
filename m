Return-Path: <linux-kselftest+bounces-47492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF053CB7F21
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 06:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 769103063F7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9418275870;
	Fri, 12 Dec 2025 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mn8BEOtC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88B72618;
	Fri, 12 Dec 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765517001; cv=fail; b=L3TNUyeXWSoY+rwTk4ZukbrxtnJV0W1dddfwv90bF0K9EMb2m77YRFXOT/ofdaWjdlHqhWXM0KFvmTCTspWPM8Mx3f1I64Mc7cEoCaNvE8hfnSyFk4EWm08B47l+jt4gbPqxyiCe+8BhFFj1ohXcINb4nZglT9DCuVjqhyahS8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765517001; c=relaxed/simple;
	bh=2TN79MP7ACly3g4xOPrvDJ3M33etNJqgd7EyEBrAjyE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J+YOlgD52hy2Fd2I82yd0+kz7wTC2nHdre0if1PJwOvyI2JDHb1LOP/lZ5TDjeBa+PQld8mWXJCAH6gVwG63DODNMU3cQNaAprvZxFKmOsiPYVyR0BGzNfdiZWwMlHu0oC51qwHEjFFlJBPgHYHymFeypTmq61gN2lF84vCqSCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mn8BEOtC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765517001; x=1797053001;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2TN79MP7ACly3g4xOPrvDJ3M33etNJqgd7EyEBrAjyE=;
  b=mn8BEOtCFOd7Q5YyxZBQXkJxQ3qUqb4GOsl/v9bug621lZ2L/3X86fhD
   AZyb1pUjsFF1XBF+9FdmSBmU98NWSzJY9k07MkmvpYe+WNa9F6zu//lCb
   1Diu5ZH68mwjQ28KV0BjK/RaD6TNf6CfGvW5ksw1VlHuMOfzikB/GkBOP
   4cuNELNPbgeNeuOGf7s3iP57rEJzJp3RTtH2VJV25X0XsGrfQwX4AJ0sr
   FDXAptah8oGYtFLIvX6sAT1wTkQ8O1vCJvwgtMazOYkGV1BftL+tN3nvn
   golWXMQGYE1EyLsVPNnUh+WavYrBocC1o6smzm8RCHrh1YmQIV0CAme36
   A==;
X-CSE-ConnectionGUID: fHWakIe1RhmanZ7R4GNgkw==
X-CSE-MsgGUID: wSOtnR1VSaiaGEGt7CNTQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67546460"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="67546460"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 21:23:20 -0800
X-CSE-ConnectionGUID: b9WIZZQbSeG8IGjWTmJxEA==
X-CSE-MsgGUID: 4/TVimbeRHuMEkZJ+piwlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="197474689"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 21:23:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 21:23:18 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 21:23:18 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 21:23:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rzk6mv9IzjVBRWWQnZkyXBMVG9tVYzsXkqm3Bf99Qbj8lt1vT9Tvy7dcso4Z4CvOK0ONR9qKOmnizNPNqCvFV2vIULAEqNVUFQLqwq6b4wBfUrviWUymWR/YP1alEQotCGRdYjjQi1Pc5nvpC8/cGhKi+y3Z4I+sSRCC0Ow/Amuttb+alPdzJnOpGD3MqQ987EUVIDxPs608SbJ5+pLPcvIGLFh6DyA+QYw4AgdWDhMRGo3Nx0h8X0I8Ri2z+I0i+dXThMH2P3JoxA9ybyeCzC6cKvGw7XRKeKaF4f4AI3Afr2PhOWf7TWn0zWb8W3wSuHlGwbSH3OgsMijBm1cOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNBjAGaMHeOdmrXKsvLNt8uYw3eFY07X3TRKOyuqKzc=;
 b=YK+S/n569/6kJxxAufUtahXle5oSfNo1MXqFjfQG4rNzJ+HlFCu1yh/E6xlKOypQ2pARJNGX9hbOtfaB7aYv1HIPwikDwvdC4kw/upLznJNW8KLeOfdhOkC8Af83sTUh66KPdVfG7M5y88ROvPUBPMXam8biScNGCcny0gH7a3QXYdwho2dmZ+dPo5AvRg0MQ7+L5zF8A19EmY/q2d6Ep50c7JKOlQSFSw3lrd6pvxkOmnbcwjDS0JayAQp52xWgzJ7E+1YHu+aqxxY9lyOq0UiUKfPYXLqZG3LS+FltENlOQywRDZeKoc4yGJaFZxScMCdrVHHxgFKb+/Sy1oEdCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7548.namprd11.prod.outlook.com (2603:10b6:a03:4cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 05:23:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 05:23:11 +0000
Message-ID: <43b8ec69-3a19-48c0-93cf-48f3142b091c@intel.com>
Date: Thu, 11 Dec 2025 21:23:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] selftests/resctrl: Add CPU vendor detection for
 Hygon
To: Xiaochen Shen <shenxiaochen@open-hieco.net>, <tony.luck@intel.com>,
	<bp@alien8.de>, <fenghuay@nvidia.com>, <shuah@kernel.org>,
	<skhan@linuxfoundation.org>
CC: <babu.moger@amd.com>, <james.morse@arm.com>, <Dave.Martin@arm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251211064632.2344393-1-shenxiaochen@open-hieco.net>
 <20251211064632.2344393-3-shenxiaochen@open-hieco.net>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251211064632.2344393-3-shenxiaochen@open-hieco.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 7678cab7-fdb6-4f18-0d82-08de393e8aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXZ3V1Q0ZWtaSlNVYnJjQi9wQ1FKZmVLY29rMUpTZGs4NEpWOHFJOENrdFY1?=
 =?utf-8?B?T3d6eUpCUkRFblc4QnBxQ1pEUTNiQ1ZPeTBtQzlOMGlYUGFsaHROeStWRUJR?=
 =?utf-8?B?bXlUTlJXT2t3NndKd0pQM2V1UU1jNVpxOFAvc0pzelh4ZlVFS3Z1b0x6UHFH?=
 =?utf-8?B?UVZpQ2FiSWQ3NnYzUnZoenBHWnlmanhjNUdma2VJa1FkbGd4TnY0U2pMMFoz?=
 =?utf-8?B?MkdKQXhHMHRzaS9Ub0Y5Zlp2NmRBdlBCSXc2cHJGTFM0b1dpTmxyRFltUDUy?=
 =?utf-8?B?eFV0L3Y0b1RFUER4c2VvaGJkOTZ1OXcxdDN6bDNoVW41YUxReDRwUFNVcEQ4?=
 =?utf-8?B?ZFlFYzgvbUIzbWExWlB2QXU2VERUUmYzSExubVVXNXd4eTlPRWkvMi9IckpU?=
 =?utf-8?B?OTFsbjR4dVJERjZRSVpLWjNwTjBlZnVpTU5TZnBYOG4vU3gxL2t5RFB6WCtE?=
 =?utf-8?B?QjBaT0xnN1FnN2IxcDJvSk1nWGREYlVVSXIvaWYrcjg3NVdXM1NnTzNuYkpn?=
 =?utf-8?B?MHhQVnIyZWpxTk5ySUpTbFB6ZjZVSnlNNTN0SCt0Y1lUK1dhUXZYaG9SVzVT?=
 =?utf-8?B?YWpXTm5NR01rUHY1UzlxbHpNRDZsUXMwSm1CNjlSMHRxMGlpUVNMblB6aWxm?=
 =?utf-8?B?VTQ2Sk9ES2hHSDd1ZmtBajRha0YrdjlBRmJFVG9DOEdsV0Jjb3dWVzhGemJl?=
 =?utf-8?B?NjdMM29Ba1FqZ3ptN1B6THBXelV5R1Jlc0l3ZUpiR3dRUmJhbVBraFNVb2Yv?=
 =?utf-8?B?bXBoMlllYkZoMWJQRWNuMWRIWk5FNUx1cFRONVZPS2tuZ1pyREh2Q2c3V1Rn?=
 =?utf-8?B?K1NjRTZZdkhBTnBXMU1HQk1vS204WjhKdjRseE1BQkpwWGJCMWVUbWNlbW9n?=
 =?utf-8?B?alcyM3BsT3pvNStBdkxrVEIzZlJTRUczVzgyNVdPMmJYQ00reG5rN0habDE4?=
 =?utf-8?B?cERKOVNHb2w3ZjdwUjRmTkhpVElaK0cxU0IxV29FNmZwUlRXcnhoMzRsY3hp?=
 =?utf-8?B?d1JRa05NajJpaEQ3cTBGNHcvd0pSSzdHU3MrNEgrbkdzTTh2Y1dVb0Q1VFVE?=
 =?utf-8?B?dURTcHZXcFk5OVJXeTRKa3h0MEFHZGVDREcwMWRReHlDY1Q1S1hEZlRQcjUv?=
 =?utf-8?B?V051enQ4enFOM1hCMmhnd2tVVnBNOVZweWNPc2VTd1FzM1o3SDdDTWs3eTUr?=
 =?utf-8?B?TllDR1YybzdjY0NVYmRaeUtrMzhkd1FZczcvTEFXTEtQaE1kaXBsLzkwZTVU?=
 =?utf-8?B?WTRxY0JCQ1Y2ZWZ2SnZlYlZpN0IzL3dwY0gvVHlTWjRtNjljNG9xdFNmdTVC?=
 =?utf-8?B?VzFmdElreGlZVUtCc0prNnNRejgwR01yR3FGMTY5cnFCb1NVak9lQzZGMkJN?=
 =?utf-8?B?cEJQd2dxRG8rZjl4REg2cit1VVFLRXJRaSthN245NHBPWmtmeWFEWUU1L0tx?=
 =?utf-8?B?MktXQzJtSVNYcmpkbmpXZ2ZIVDVVM0NqUkcwSmwwMDZ6TXk5eDlXcmdMalR6?=
 =?utf-8?B?bEloSG4rWU92MUZZVnQ4ck5NQ3hMQ1Jtakpwckl1QnF4VkRVTWZUdXhid0Zk?=
 =?utf-8?B?QUluYVgraWxIYjdUek9adklvbllLTWlNWDNHcHdITTdSVXljM1JNSzlOOWJh?=
 =?utf-8?B?NkRmYy9tWjJGT3pzQXNiekxiUW1nRzFtMC9WbDVaa2F1ZnZJYzluMlQyWU1r?=
 =?utf-8?B?aDRkYlNHVEY3Y0FjWFZrZGN4bU5lR3RjRG90eU9oeWduT3FXbUo4MHdpQll0?=
 =?utf-8?B?MllkTHl4cDlNQTh3eG5lb3NySGZWMjhyU1NpazBwMjR6Ky8zSk9ndFRrbWVD?=
 =?utf-8?B?ajdqOFFQaWFlS0YwZ1VzN1dnZ1VUejdzd0YwUlV2RWdHWXR6MHZINnRreFVB?=
 =?utf-8?B?Vmp5eEt2dWVKOWNHSFN0K2tqb21mVmZjTDJ5SmJDNmhVVEhDbDJEUWIrR21J?=
 =?utf-8?Q?6XDgQ9f+VcCkeil/VtTicFqmQxESCTMp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUdFU2JRN0JOMnBRWGcxZG1MWXJTVklkY2wzVXhlanFRM2RhL0Z3Wi9XODY4?=
 =?utf-8?B?cHFQT2hmVjJ0d3VqcDlmRmNMV0J6NDBXT3BDbmVTWEdwRFlFWVVGajVlOENy?=
 =?utf-8?B?cnNuUHNNYzdmRStZaVBIelpYNVpsMjJ5bHo3bzV4U2FIQkJNS3JCV1VhS2pk?=
 =?utf-8?B?MHFIdGZqTmNwQVdPTjl2WjBaWm80bkdtaVdCQUxVSHdpVUZtSzNvblJYTlVz?=
 =?utf-8?B?UngyTlB6RkdQS2c4N2dLbldkN3FOekUzbktTTDRYK0ZlVDhick0zeTRhY09r?=
 =?utf-8?B?NXJaQnd4cEVjcDVEbFFneTl6QUVFcmtJckl6d3pTTjVZaGRKZnhXTnVYUUJq?=
 =?utf-8?B?eTNwbEg5RzVaZlI5UWY5MDg5TVE4eXUrTkJVeUdBL1BaUFZCdTM0YVM4Wm44?=
 =?utf-8?B?YWQvWEdBT2VoUnFsZVAvMUprVVVkczZITitTVjkwOFJ4NWpaa2JHNUFYMHlw?=
 =?utf-8?B?VnRMYUxJMy95ZDJxUzNiU2hxYm5qMFVnQXFNYnlOREFJajBQNDB2MFVpSGhz?=
 =?utf-8?B?eG9VMFNBVlpLT0ozT0RRemFRL2EwMFRDOFhnNmhOellIUldiYzhLRjFmdk1Z?=
 =?utf-8?B?WVdNS2swQnV1VEhmTXMvWlgvVzlqYUVXcVhxZU0wZDBIV2NsL08wWG94OWF0?=
 =?utf-8?B?NHJjcFJDVHQrRnBZUTJ4cm02T3Q2N0hkbVdTNUwzcmZwR2h5RUEyYlZ1TktC?=
 =?utf-8?B?NHBTNC9XQklxcVh1SkxiMUNScDZzNGFoNkxVSGJrbVJMZVZCZENoTHV4VEhZ?=
 =?utf-8?B?MzRTYyt3cm13M0Z4bElQb09xTHdVazZwc0E2ZkJ0TVdmZHNyRUQyVVYzdHBG?=
 =?utf-8?B?LzBwRFpwOXdXYUFiWkEwUHB6SWhabm1tZlZNYzhyUWJLS0hacS85cHBIVG1Y?=
 =?utf-8?B?U2VCNjFxWGVKUXFGaVZYSDdNZkVrOVJwcXpBSGJzVkE2L1pCQm1TWmRRT2Y0?=
 =?utf-8?B?WkdkZkVIMzdXWWEvZUppY0x2U2t3VE9VdTh1aHM1UHZPcnZ3YjhsSC9weHV4?=
 =?utf-8?B?a1RtU3FSVnVmNk1KanhsSnVoTGhzMTRoV2d3eklDRm1mUk91VFhnZXI5N3VT?=
 =?utf-8?B?QUp5TncrQk9yMWJEZ0ZNWmM5ZDZrWHdOTi85SUNVelU3aVRCUzk2VkQ2QTAx?=
 =?utf-8?B?MFg2OWhuRG5KU3FKYlRvdFIzMHhqWllCMGFCU0NQU1VQUU5BdHd2TFJBcExx?=
 =?utf-8?B?L0Rvd3grbzlxN2UwTGVlYW5RZkRMRzY0TlJ2RXFQblpSVTQrbGdiTHkwNWs3?=
 =?utf-8?B?ZUExb1BTRHQzQThzT2gxSG5vUUxiTDFSOEFLb1VLVjBHM3dodEJ6UVZScWRT?=
 =?utf-8?B?Q3pmWWpVa0tTbXhESGRhOXpQZW5EeW5DS3YzY3VtZ0pVQXBZcy9sbENRYzhI?=
 =?utf-8?B?cDJ0Rk9BdENHK2JWNGdZdGEwNkxxbzFjRStnTmxkZ25WTFcxWXFLSEhNWVRO?=
 =?utf-8?B?YXYwQithbGZ0N1BBRjBCY05nRWdsSStOUnpWTHRVNURFYkNDemVEVDcvc1JQ?=
 =?utf-8?B?eldnakVKdEk5SjhPVCs2UnVBN2RYWFF1OXVBVHVFenpKRG14U2tGL2t3RmRS?=
 =?utf-8?B?cEh5TldoZThVL3lxWlhiMHU2MkhkNW45VjZPSzFBdElrUXRKRlFVL0swYm5M?=
 =?utf-8?B?TGJtWGhyTUY4eUwxQ2RxZ3BKTjlLVkplMDg2WnhsTjhJb3ZpcCtHbUhkeUxC?=
 =?utf-8?B?alJJZlpJY0E5WHJIZWdYT1BSQ25rWGdDUnhDYWxjWU9EOUt4WG5oM09vbFpq?=
 =?utf-8?B?ektQVTh4ZW9JWUNQSTBKYjJCR0I0MCtJdlk5cWpXNnVvK3ErV3NwL21pWUVS?=
 =?utf-8?B?UnROS2NDSFJab3YzandaYkVET2F6RFNUalNMUCtmTnFnZTgyWlBIelREZ0xk?=
 =?utf-8?B?ODUwMHJUZGZOUmRtalpLdDNBU3FsbjJ5RzdjWEVDVnM3Q2pGSmpkTWkxKzJy?=
 =?utf-8?B?Y2l2OTJQbzcyZ2tyS1N2TUcxSVl1NUFZRy9XTmYyU2FvZ1FRK09EblV4bHQ1?=
 =?utf-8?B?dFhEdFlTOXZIRWhDMHp0K0xSUWFIQ1FTYit6N2VpYmIwMHhBemtYZ1dLR3Yx?=
 =?utf-8?B?dTZRYVZ1U1I3Rnc1NVJPQjN1Mm1BeHZNVFdLUVJBaXU0aHYyUG1vd043LzVE?=
 =?utf-8?B?Zld3SnlYTzgvMmh6Qm9iNy8wWjBoZVJtekNET01pQjRyUTFuTnB0VzVmNkdG?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7678cab7-fdb6-4f18-0d82-08de393e8aed
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 05:23:11.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2QhZsqrLnZrYCZfFW2Y2+qCiEGzxxlLnJ6f7mImlcMjfHUI/GQKU9wjdEdDUAU6f1xBWl7u4R7gIuvmXWbTyDJ6BJXlpJRDwcADZeyKIa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7548
X-OriginatorOrg: intel.com

Hi Xiaochen,

On 12/10/25 10:46 PM, Xiaochen Shen wrote:
> The resctrl selftest currently fails on Hygon CPUs that support Platform
> QoS features, printing the error:
> 
>   "# Can not get vendor info..."
> 
> This occurs because vendor detection is missing for Hygon CPUs.
> 
> Fix this by extending the CPU vendor detection logic to include
> Hygon's vendor ID.
> 
> Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
> ---

Changelog is clear this is a fix, does patch need backport?

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

