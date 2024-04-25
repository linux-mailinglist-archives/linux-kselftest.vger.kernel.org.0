Return-Path: <linux-kselftest+bounces-8845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA8D8B19FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 06:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38DA28153C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 04:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DAE381DE;
	Thu, 25 Apr 2024 04:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fq3eJ0Rb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737F3B293;
	Thu, 25 Apr 2024 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714019953; cv=fail; b=XOC1qcPPMSlR/nmRPJ9G61hWToqt/JwjyGVitEH5GOD6OcAFMsBt0SGVj2l8qU55CTdWHlIonnX28Km8itY/DN9DIrdhkvJLjFxahGPGEocXT6d2SZ5Vl4E0w5nRuWFIDUttXXHQl2i8WUZF8q4OC8RJCo2qb30jiqgRv/3PWlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714019953; c=relaxed/simple;
	bh=SXMxfLKluiVuIm+KOu2J8ekRVqmmhRv8tbP43zG7bbI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OA2LrD1P7aYpLc2JIbX1n46Wwx2mJaX63PXwCScncud2FQcOpXd3XSJ9XiXmAdmc4cZv2PJWKU9IdHXF1gHBp5tfN6PBXo4TZfxtUSxoYBO7EnhyhIf5L86vqJYkFCDUS+nnl+Fe7WZAgfaGc8apHd74Ojve8vpTx7jeO1gLdtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fq3eJ0Rb; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714019953; x=1745555953;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SXMxfLKluiVuIm+KOu2J8ekRVqmmhRv8tbP43zG7bbI=;
  b=fq3eJ0RbvF1mnNYl4iRau9PZJxQlfBbe/e13rImYShMA0rb7MyXkKvq8
   l7uSO3N8/C3C7+kEBaB16Ir5kTZRIpcP/LjC8gpJYVeiSJLIJOsNj3til
   KbP/B9DBSPrlZ0ty5rQqU/LBvi3aLhmTezMR+IlpeGxbLedVkLhJZXYGG
   V7qZhWMsA6czLuWir48mtbnTUqlIBNfgLaZg1VViq1YH3H80Kb0INPm6G
   VL+mLE0ZU9AybgN8BYKtBWU8fcsKymhTeaAM7kDTCDA3XEFnlxAk+0iGu
   s/zs0vihraPRo6NTdVSaCejeGV5qFVip4pgGE9Kjob8ZHQ+wN076G5agk
   A==;
X-CSE-ConnectionGUID: m4mSQBQeQ3ac7mBWWzUmYw==
X-CSE-MsgGUID: c2Rg6p+qQDiH3jKHPLFTnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9795611"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9795611"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 21:39:11 -0700
X-CSE-ConnectionGUID: cpntFmLTTbGDnO276jbiCQ==
X-CSE-MsgGUID: 6xncZq50SjOA4iCB9YatQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="56113869"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 21:39:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 21:39:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 21:39:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 21:39:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:39:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxVLk6F2MwV7OvpRbAEGwTncc9Id5VuZWQsuoqQeWH0IiB3QleH2/eYUFq2W8PX1NsOs/pHkpaOZX6GP92xA3PiBrxuSmPzK/ZvulEqQoC+l8wMWdDyDxToJbAXAmxSx1lAIosOC2PvhZF7x7Zx4+V1dT5X7AOA9rF2INwSFOWDxCJaO1BnAaGZUEpX0C+FxgiaeTQyFK904xWFXX7+YIdHb92iJBQDmsJ3DZg6ffV8REG8FgSMQmcENlFCFoFG/MwWSa8elKw5cozOhG5xyy57xFpuYsQROdnDLWua0+1MCo+KuHYArXTMU70++hNXH3OlXM6dbU0v9Wcd8i8oLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5dW60t41HLuOEKKlXE0agUd5biLBfToMXJIBSg7n0A=;
 b=A1mLrzwfuLMMdzjxGFED2kvRucga2nwn6LYlksn42M2KiFUndT42cAidKEpoB7qrEkJXFOQigt/fsJBErHDFzBFkHf1+1vA6+XEVcf/C1V4KUYkKUZ0r5xXS6GWgJ35rGK11gzl8GSovGe8ouQ6oHCSIJc4z3ld0YFy05TmPqEm3UfX/DSc5/7zS0tiSVgIKhj3rNwgk2MnQllP2zeSvm5JhdOVd7jG7UEdUkp9TGroCnURRVYHswZ36SKubCJR3BM4WDFbr+zjpVWRq/0oGOtK7b8LWUOw3OQf8wdGfvbfBDhd4m5BkdmVtddlFIPMDexFgvT18cudFEPQp1nujPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 04:39:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 04:39:06 +0000
Message-ID: <21a1152d-2005-4883-bdd1-396b561aaea1@intel.com>
Date: Wed, 24 Apr 2024 21:39:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/16] selftests/resctrl: Add ->init() callback into
 resctrl_val_param
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
 <20240408163247.3224-12-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240408163247.3224-12-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:303:b9::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: a65e8c6e-2881-4792-4f43-08dc64e1a444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekdyaythVTI2SFQvNDhwNHFybSt1SnpkM1RaZGpEZkpkbUZXTU9Kd0NEWXlD?=
 =?utf-8?B?aENPUUdrSllGSS9UeWV3eXB6ODJCQ3ZOOUxGN3pXaHlDNCtaTUp2M0NhUnVG?=
 =?utf-8?B?Wk9sWnNoUXdrZkZWUW9Ycld3a1loSnoyVzR3cjM1U2Zqb29ScVFWbTl5WmFE?=
 =?utf-8?B?Rityd045Um1GWUVycU9UYTNHcEFXSGlMQnlPM3hLWTZpZ2g4Wjgrd1Iyd1JO?=
 =?utf-8?B?dFJGZWhjdGEzV3p3M0c2UTNISmhpbjl3RWVDSTk2d0g2Ykk0UEpJNDBscVhy?=
 =?utf-8?B?QXJra2VwSVFtTUkramFUV1gzNzNJTnBGdktnTjBiZ3YyalJQaWczbm1qb2JX?=
 =?utf-8?B?ZlZRUnR1aG43Y08vbnFJaWdnRkFzaURRcm9NaHA3WnRTaHJsWUEyUlErVGZZ?=
 =?utf-8?B?REtvQUg0elBaYkx5SFUyY3gyVU9NcmxQTXdSa3gwVStOWGNKR0l6TmJFMnpK?=
 =?utf-8?B?OXFYMGNtZ0ttVGRpQlowb2ZvT2N4d0JET2twMDhQMzhxcU5qWURoU2kyRWlv?=
 =?utf-8?B?YVllSEZsaDl5Yk9sZUg4aHBrTjAvOWFQR0I5WXB4Q1NuQm4wU3VJWnI4UlZT?=
 =?utf-8?B?b2ZxR3pUOHNiSEQrWTRTRXowK0loa1BUY2l5MVI2Tm8raS9MM29DN3o1YzVT?=
 =?utf-8?B?SS9ZZDdPUXY1ZGxGeW9EU3RVOW9HeHpiV0dMYXFoSkdxem5ZVm1kc29TZW9H?=
 =?utf-8?B?REdsdXJ4TFByZzQrODBlYWVtWWU3T095OUs5SFZEekoyanA2Q3I2azVMWjl5?=
 =?utf-8?B?MDhrWUE3d2J4VlhXbmIybkNQMGpTdXM4ZG9uaHNPOGhEaDkzMkZ3OE5SWHkw?=
 =?utf-8?B?TXI3cklDZlduRlhES2VDaVlRUFVicytIcmwvT0xlT1g2VXBRZHlYMnByRy8w?=
 =?utf-8?B?TmFIWk03V1NWcllYYXk1bkY1enQvbytiMmV0TVZMcENoZHljeG1ZbWwrNG1N?=
 =?utf-8?B?akIyYXpLRUVaZ3puREc5blhYTTZudWFxRGZRTzhZY3k1emE0VFBnY2pSbFJX?=
 =?utf-8?B?ZXovcmRteUNWV3R6bnkya2lUSXhIRjRhbkpFdHhsaEJ3TGFuUlI2bEtQcFJS?=
 =?utf-8?B?QllsTTNoSUhkSktQTkhtR2dNRkdRMVpZdCtzbzErWEsrVW95aDArckh3UE5O?=
 =?utf-8?B?ck5nbmtTUnJrNzRpNDZxVXNXaTY5anNNM0k0dlNBYzlId1MvZDg5bXJaNDFi?=
 =?utf-8?B?SGlMbnFzd0RkY2sxYjhsWHRUOGdyTzdSK1dUQ3lZVGxYSnk2VkI3YnRDVHRi?=
 =?utf-8?B?YmpRMzR2VUJTamZXM05kQmp0VjI5SmJPR3VxUnM2akw2U0ZJU2ZJcUJRcWhy?=
 =?utf-8?B?STFoVjhuZHJFODlwaFFNemJtV0VKbXNFNnpSYkpGWU11dysveWN1MkE5MDhM?=
 =?utf-8?B?QWdTdVRjM3QrYkhaM0p6b25lRHcwSmZrMy9iMGE2d3cydjZmT1kwdkR0eTRk?=
 =?utf-8?B?VytCTzdOcngySTRLa0JjdjFRM25YVDhCRG9kcG9jNWVoaFdJek8vWVp4a2ZR?=
 =?utf-8?B?TE9FTGljeG9rRVNJOXdDNng1RDJ3cUV2TE1aWDhBR01hbjFUVTFZemZjRXBS?=
 =?utf-8?B?SVBZZkQ5SG0vNitraSt4bkJRQmJrOTFqMjZNS0VDTU5YYTR1UEtlc2lQT3ZK?=
 =?utf-8?B?Ym1OR0JGQ2VKb3ZWS0NKVTNtaDEvZ1V6TGxoTXZIZVpBcHBhck05djVXSFQ0?=
 =?utf-8?B?dGR0Y3N3QmVnK2E0N09uWDFqSXh0LzdwYWF0eXBWbVErYlh3UGxMbW13PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2lPM1d5bUNFTUdXZFVXVmdNUG5DRjJaRUQ3SEpYcmxrSnIySERKenE5MlJR?=
 =?utf-8?B?bFNXQzFnTk1OVS92S3ptTUoyWmJVMTdCdU1VVENrczVpNktaeHMvSy9Yb3pP?=
 =?utf-8?B?Z3M5QjREOTZvRXJZd3ZiY3JUT0xSVWFSUWpLSzNScytwcEFyc0E5dVBhc1Zk?=
 =?utf-8?B?cSt6bUJUUTJiQklEbU1kaTlocHZabnJza1Yxejd2VVM3SmwxZzVBZlRjQVp3?=
 =?utf-8?B?cGRhb3VYMStrQ3VHOFFnMkppYjVsK2ZyQTlsRDlyTGJ5cXhmZE1xY25JQlox?=
 =?utf-8?B?ZXZuSFVvUVBsQ0VGQWFOTHZvcjhMaHRGWHhIWTBzeGZVaStneHgzZmEyYnRx?=
 =?utf-8?B?Wm1PaEJZalV5ZUhVM3BLTXB3c21sVEdPa25NR1RVTzlGd1Z3cVpYRlV2dlZ2?=
 =?utf-8?B?VlhrbkNBc3FMTnBpR2hnK283bTNrKzd2S1E2OW00UzZMZWJxd1dnZW9MQ0dT?=
 =?utf-8?B?MkpLVllLcXhzZ3poc2p3TlVxakYxMk1XNmpHS0oyNWFlSFVjYVpZZnZsUHgw?=
 =?utf-8?B?Z0hFL2Z6TkpmSndMeDFsOEl4L0phRzFwUmRoRlNac0d6SHUvMXNuNkEyNmp1?=
 =?utf-8?B?c1NDSnFVeGJYY0VCclpwalFTSFFub3NxMW1yeU1ZOWdncXIrR1JJMjR1L09B?=
 =?utf-8?B?elZhS3ROeHkxbHhyYlFJek1QY2tqZ3BjVVpITlN2Nm1zL3BPY3prcklmVVFq?=
 =?utf-8?B?a282TjhPNnhJby9wQWRtK0IwKzdEUGNEQ016WjhNY2ZxN1Y2QWx5T0hqczZS?=
 =?utf-8?B?alRZZFNjSVRuTjNrYTRUN0drcWFPYXdzZ3QyM0pucXpjcWZsZTNuUDREQmhY?=
 =?utf-8?B?M0hZSGVWMThsSTlzTkFHTTNGckRRSXpCWGMxZVc1Mk5tVHlPZ2I5UEU3ak1n?=
 =?utf-8?B?L3JuL3dhMHBwSlUyN2hVb0t0alpXZXRLNlQ5MnVYVENCeS9qY0pWU0RRVkxq?=
 =?utf-8?B?cU9pR2J4QTZaYkdJeUNUL01yekxOcXdQVzU3T2h0MGhaWko3UDRISS9NSnlD?=
 =?utf-8?B?TE1waHhTZm8wRDY0YTQ1YlRtQmxlRFYvOUdnanNtaVNnejJla1pvM3MrM3Yx?=
 =?utf-8?B?TWlRbllFUVNpalVJT3J0WWhGQ2tSd2ltVnRWZW1JWTArdzU0Q25EWFlnWFNE?=
 =?utf-8?B?cFAwekpsUWN3MklFRTV1ODMzNUY3WFJkQ3FoODUwbDVrSjZjekFDNG4yOWtJ?=
 =?utf-8?B?WExjZWFXdUNob2Nra0g1SlJncXI4MHRLMkJzVG9rWThrSXRDUEtkOFBJVWo0?=
 =?utf-8?B?M1doSEtJNW02eEUwS0ZhcHl4RUc1TERpb3FvbHI5VHcxZUZVWGt3VmFIejZ6?=
 =?utf-8?B?WHI1M2JuTWVINXc0Uk1EYjlGVlN2Rmp4bHpBdnM1cUx0Si96TU1remdzZFpn?=
 =?utf-8?B?M0V3bk1KOXhTc0daTnc4aFAzOWduNDltWnNmZE5VNFFLZ2RjcUNUSGhLeFQx?=
 =?utf-8?B?M0NOYlRpdTN3MFA1MXlkbHBlVXV2WmtzbmsyRzltV2UzRWRTbUVtOUUxR3Fl?=
 =?utf-8?B?OVp4WGJpK0Z4TkV3bHlGMU5wZVZDK0UyNmJoWWtrekJGMFg1OUtpbTduUHk0?=
 =?utf-8?B?cE1ZT2hmMVFFZFUra21wa2ZSMUp2OEd1N1ZBOHJIMk9tYldTem5kbTZBUitU?=
 =?utf-8?B?MVF2bHpLMjlmaEpVSVZaNHJBRmk5bkFkV2o2M0lUcGlmdEVNNXFWVVVFeEEw?=
 =?utf-8?B?YWxMZnhINjN0cXBYQjhNTFhEY2JRTHlMTEpZbFoxajJJRGoxcWxnUDlKTjJj?=
 =?utf-8?B?R1l6UXR5Z0RQN0pPd2Y2UG5mVzBmdUx0SHM2VXlqMXlyYzdNNE1iWmZ3dmcx?=
 =?utf-8?B?UE9CWmYwTGozeGVJWGpJbHlVeHRUd3BPYmllUTMyTVFlM3VuM29vdUZUcE1m?=
 =?utf-8?B?L1oreDd4TUN4Tkt3TFhkdHpJU25hZ1YxVkhYLyswYjZKZkh6aGJTVFRGWVhz?=
 =?utf-8?B?RmJ5ZjNSUjA3dHVzZEdWV3cvRnExMVFQRSs1Y3pyWnlyckZEVnZCTnI1MlE3?=
 =?utf-8?B?MVFncm1MdEFjMVJHWjgvczkrRWJpV1EzVUQ2dWo3RVArT041Wm8rcTV1L3Vz?=
 =?utf-8?B?QkZsU2NGNmdPNHNZWE9DdFlUQ2wwS2E0R04wdnhzc0lxWno2bXRTQzJzUEl4?=
 =?utf-8?B?WlRCYnlQdzZWSS9JWVVMeWdNaEhPV1NibitiUStQNDNOVTNlTXdxZENZVFV3?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a65e8c6e-2881-4792-4f43-08dc64e1a444
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 04:39:06.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DbmM+5sXU9ThLfE8Mu6RZPY2vIrH2xxPQVVUKPB35lzi+r8KlwNaPBaKmyZFVOht2ysaaZFb3suBtu9oIkDmeGxFDVi29dsxYLvvZ+iRPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
X-OriginatorOrg: intel.com

Hi Ilpo,

On 4/8/2024 9:32 AM, Ilpo Järvinen wrote:
> The struct resctrl_val_param is there to customize behavior inside
> resctrl_val() which is currently not used to full extent and there are
> number of strcmp()s for test name in resctrl_val done by resctrl_val().
> 
> Create ->init() hook into the struct resctrl_val_param to cleanly
> do per test initialization.
> 
> Remove also unused branches to setup paths and the related #defines
> for CMT test.

All these code being moved have a similar pattern to earlier code that
was deleted. It seems to me as though the CMT may also unnecessarily
create a monitor group and have the same opportunity to remove
some of the code being moved around here.

It is starting to look like resctrl_val_param->mongrp is not necessary.

Reinette

