Return-Path: <linux-kselftest+bounces-41809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC989B83421
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 09:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D493BA1AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 07:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD8C2E9ED7;
	Thu, 18 Sep 2025 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lX3pgpJn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2882A1E87B;
	Thu, 18 Sep 2025 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179160; cv=fail; b=pPjEQnObYepag0Yh1YCtzgjVk5P3gvWqsUY6VccA/HZDkPrkTshZgMYHGhZcH6KLeTbmEblAGkORokFa5669tV1UcTss9S3YqhTKTGqdQrz7oJrk17/UtUj600Xvn0q54uexO16KezWwBJhLO8QHs75RCZdXH+Qvx0aC4mJSYrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179160; c=relaxed/simple;
	bh=k4fAopRPbQC7qorAMpWatcc3+20FHWikZtqYF7xUNQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lkkEYgbenkVYnEybSFJgc3H5dAiPpF43rXuZGknckWGcSkJmEk44FMn7lFiIO0X9kM2tHNuweKBg8Ki4LX16okkUiILBI5jbTx/jkODxhY3ValBduWyPZlnSpOpElQVe1tJ4llNMraYiFDyOf9cXZH3sYZibAdEj0E5nFZkSVh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lX3pgpJn; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758179157; x=1789715157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k4fAopRPbQC7qorAMpWatcc3+20FHWikZtqYF7xUNQI=;
  b=lX3pgpJnSfifIwxG1iqZmkTCM7G4R+Tz0XgnYL+2f1nY/4YjdQl/aVs5
   H4JY4NG3qkfk86Bwgep0Js6Nh7jkNsBYAS/n9bQ8UcReRnFSjGsR1iskX
   x6v93Mmrc1bHLC+cwaSzjb2NDoauadZ0hLe69A1iT4MSsfbQp/y9IGHlE
   knegjpfhO018+pHFd5BDyoF1hQg6ktJM7r1FC1bWlmUCvYGXCBD11SZVI
   Uie3oK9KP6Bpt2CVl8XAhGHzjNGtH74sZ6251LxDjeKf6fR3KnCXlUNwZ
   WnlwPJH/ZUVNqAUwwjhNRL5m6rCc7QFNk8X4K22H/Rtrv6aMMIKMdwPAD
   w==;
X-CSE-ConnectionGUID: gLCkwHoxTyecNM+yTjdP0A==
X-CSE-MsgGUID: P5KG20vOSBafrAhlOGo5Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60191487"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60191487"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 00:05:56 -0700
X-CSE-ConnectionGUID: O/orjCgESeSD/LIQQfuVWw==
X-CSE-MsgGUID: 6uggT3zIR8+HzMelrRg1AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175059654"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 00:05:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 00:05:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 00:05:53 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 00:05:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIUP3ruGEF02/r+izqoNVWbh+qFnSGlV9+/sHNUAwiRUyojUPteISin/xI+OpBmUeZsCPCuS8YUChnydsfDF1QG9+TXRgzUgAjc5wFC5j1XumU1p8ReliVpdNMh2YOlXWttdihIZNhvSkovIzAjAPOmo36KiyfMKKQfxIH2i9OBoJfiyA8wzOnLzah5v2wg6dSOY5JL4YmtXigYw1Iq+0W0nDnfat7IgYcXxPnthgI5sDB/cQKz+HYAZrBBbI0doE8gYR+tj7IK6K3O3FiWaRXnrL71We20LlJ07QCbEGcxuf6D31MIGhIjewaeWjZAGZT/9HOxFbAGeFWIYSt3/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4fAopRPbQC7qorAMpWatcc3+20FHWikZtqYF7xUNQI=;
 b=be26Ds23uNAg2J8yec0gEBB2AWspSyLmVtp5iP6wWk81wXTR5P6/5QQYHoyDk1G7bO1DR15BW1Kt+DaHVP6VoBv/yLeYawRggfx3ho4iMfI9NE/dM4nfvzFbSv8O/eV97jHsJuzPJ/h+mnbpBpQTvJhss9BegW8xvGixAV71+NOXreSTNY5HwXF9NWicDy/jBQhp80LF4AxaDJsCwX/Z1/QSfHAX7TKLOiQX/cr+WfLBJ/0tITH930sbizWT8YYtsHnGopzADURF7Q4ll4qDYzqqCTvkHegwUgqnpKk5OPMzsKRgwhGkdggX7lFklKavYYT2eUTRLw3hsfpYwUwhmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6886.namprd11.prod.outlook.com (2603:10b6:303:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 07:05:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:05:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>
CC: Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 04/15] iommupt: Add the AMD IOMMU v1 page table format
Thread-Topic: [PATCH v5 04/15] iommupt: Add the AMD IOMMU v1 page table format
Thread-Index: AQHcHPrPMyzf1al9LkeBGiVdXYVZSbSYmUxw
Date: Thu, 18 Sep 2025 07:05:50 +0000
Message-ID: <BN9PR11MB52764CB85A0C6814797DE6728C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <4-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <4-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6886:EE_
x-ms-office365-filtering-correlation-id: f52a48a1-26b0-4142-8a37-08ddf681cd1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aGd4MlczSHY5b084d1NEemZHampIZXpiZTdnU0ZZK0ZhUWNveCs4amN3aUpj?=
 =?utf-8?B?R1lTdTlUTGJHVDBiWnlLNStYUFRWOThtTWJhY2pob29qckordnQwRGt6cm1m?=
 =?utf-8?B?dUFaSTFzOENoaWZ2RHhWL0RBTElJOE9xeDVxdzBkeW9PZGVKL1hicTVKdWxJ?=
 =?utf-8?B?WE93UC94QkdXcG54NG85bXdYQWNGeE8yZEFIalZueHVKTURxdzVVcnBSOUhL?=
 =?utf-8?B?NDJleVBXTHNLOFVhNDhZcythQ1JhazN4TlFvaTl5U0xPdzJsNTdpeXRnc1ps?=
 =?utf-8?B?TjFzaWlRNG94TnhHTWZIOHF1TmRPc2dhWTFhMVE0L3hNcW56K0x4QW56dUlq?=
 =?utf-8?B?c2FMaGJ2TXFEaldtYnMxdkliNkcweURZL05NR3pCckhycWZYQjBSNmhITEdG?=
 =?utf-8?B?YjFZcTNwUVFqa3ZEa1Jkd1lYYUt4NFZJNkRyNERjc1hHamNwUlRjOGQyaHdD?=
 =?utf-8?B?TTdabkpWTnNMTjJLRkN6YjJ1UVFjcElwOWFpQ0s0ckh4UU5RZHVVYm1yb1FN?=
 =?utf-8?B?MW1EQlcyZ0tCWVNaMVFEY3BRMGR2Q1VGeE5rS09yQ29DaUNFKzJ5eHdtd1pL?=
 =?utf-8?B?NVZkYUhWaTk2cUwxMkdJcWdiRW82TFd0MUorWjV2L1M3OGVSU1VtNkl2WHd3?=
 =?utf-8?B?RkVYODY4MzgwVGI3YllIKzBIdGZvMVk0b0dDeWptWE83RS9EMEJIZ0tWTmFE?=
 =?utf-8?B?RGtQSklHSDg3aDB4Z3NXcFhHTDZGUU9KWWw4NWVreU5SYXhoMitYeDFUOWFW?=
 =?utf-8?B?bjFhMng5N20wUUhodmdZeWdISFd2T2w2K1M2QjJjZmxxa3B1WHRFcENkMXBa?=
 =?utf-8?B?SmxuektpWU1ESTk4OHlrQU9aYkx4UlV4bCtFQ21FM09yRjlqcUN1S2tPdFpR?=
 =?utf-8?B?cTB1MGlkRDA3TUZZdExtNnVaWXhEZFZZRTlzSENLNk9ZczhleitCbTZ2V1ZP?=
 =?utf-8?B?eHhQZ3dURGUzcjByNkFrU21XbjVFZU1lRWZybkpKYW9nTEFuQlh1N3dDSTFB?=
 =?utf-8?B?VWE5ZTRjcGExU2w0Y2pHR2hoVy9VTGluVmUrU0dUdVlwU0EvZ0pKTXZzenMz?=
 =?utf-8?B?YUV2L29yZXRLZzFUZUVFaElEL3pjNjdOL1NyOTdoMUZuU1pWaHRqVGEvYkFO?=
 =?utf-8?B?YUZka092clp6YVRxNTZjRWxUSmNTSGtsZ1B0RTl3UjRZczFzTm9ycTZFbHhR?=
 =?utf-8?B?ZzdqUVNJU3VlTmlDbTB5akpKNkt6aTkvSWJxVlhpQzBVbHNvdTh2VkRkc0Qv?=
 =?utf-8?B?V2ExTmJIdUt1WUtnZGc4M1VwL0VuelkwREhQc0hxVVFzOUU2eXZqdCtEcytx?=
 =?utf-8?B?VlBsNVlpV1kzSGVOYk9CRm5pYXhxSVJ4bW5yNGNuYW5jc0lQUHhPZ3NhcXp6?=
 =?utf-8?B?VElDaGE0bS9FRlorZ0l1TkU3bjFoUk9aRElIMWNWUEFRdS9meXdKWkdzS2p6?=
 =?utf-8?B?UG5YWFRJTHd1OFhSZDFibEJUMVl6K0FIOWpYdUFtWDkrK0QvNXFrUXZzcmZG?=
 =?utf-8?B?Y01RSHA4cFFZU3g1V1AvREIxTWNvZHg0NlFjYXRIUzNQNTBaYlJZczVMVUJG?=
 =?utf-8?B?cDNHVi9LMlYxb1lBckI0eUx0MllnRklrV0JxOEpHSGZraGI3QVUxdnQyTnFh?=
 =?utf-8?B?ZEpRd0xlQ1NPZk0yT2J3K0ZtTSthRHlPbi9WMTN1aDBCTFQ4WG1Wd0JSMHVu?=
 =?utf-8?B?a2lRRlYwWDkyWjZYbDNtUlEzYUZoRUg1SHE5RXFoUXN2cjZ2R0xiOEYwVXhI?=
 =?utf-8?B?SFZuc2RiSEpkZ1NzVUFaQmJYU0lGWGw3SVBNck1LamJwT0t1cGpRTk1waDVl?=
 =?utf-8?B?UU5jcGlvRUFrcVNiMmtqbS9XbUI5dzVHN0d6NTVZWExrcDlMYkg2czh0Sm5P?=
 =?utf-8?B?OER1UnBUblZLQ2xGUVJBeXk3ZVhhaFlyZzA1aDdmQVlJYnRGaU9NdjhQWm9F?=
 =?utf-8?B?MlE4blBRTmkyRUpqNFBobDdzdC9zb2w0OENCSW9QQVFIeEdjY0gwZ2k3eFZ0?=
 =?utf-8?Q?cbehFGeA+IiYi32nEcaDIuqGtmloAs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTlMN3ZGbFQ4b0l4b3g4ZkxRTDlwbC9QeEJwWFpRbGFtbnQ0aTAwYXRraU9E?=
 =?utf-8?B?OWI3SmJ3NzdYc3NJWUdpazdwY21qNkxjdjhwY3F3WGVMMkswUmVFWnNQRGhz?=
 =?utf-8?B?VDVGSU5wMEovRE8rSkRXV3NraGJ1anhmR2wrWDA0ZllXb2o0S2djMXZWbkNi?=
 =?utf-8?B?bVNtQUttc09ZTUIzM0RjRHV3UE8zUUtRY0Z6Zi9vUG5EckdiN1RZUnJJZ2Qz?=
 =?utf-8?B?VUVoWEFzWkdnVXB2dUloRlNJUjJEdkxjK2x2SWdHK25lYkh4a1NvWG5HSHNk?=
 =?utf-8?B?TTNjVXpzQmU1Yi9zYXJtT2VFejRHd1JVSEJwZk96N0tsU1M4c3FSVzFLdzBR?=
 =?utf-8?B?ZlhPZnEzY0xzUFAvcWpVczNwVm1oRDNuajRhdm5qT2UxVitmRUdYKzE2WHht?=
 =?utf-8?B?M0pxZ2w1Y0xoUEQvaWRiZjltNHpjZVYyMVRaR2M1aUwvc0V5YVFEaTgzRXM2?=
 =?utf-8?B?cnlicjdWcnIrZVozOXY2YkNid00xNm1CT0I2T00xb2Rwc1h4ejRTWVloK0Z6?=
 =?utf-8?B?aW5MeXRXaU5ZYlRyL1pKQSszUmQ1SUxBOTRHMUFxT3VXVkJiSW9OWDlyWG14?=
 =?utf-8?B?dC9IT1A2WlpXMUd4SVkzdHRqUlVZWlNIaFBlS1dnN3RrdnZsbTlaY1JxSVZs?=
 =?utf-8?B?Smt1eXlkQS9LdlQ0T2ZnU0lVSU54bkcvZXhjS0NHRG5nQitkMHFodENPMVBG?=
 =?utf-8?B?OWVkWEE1YzNpazlUanNlOGhZTXJMa1JrWW85Tytub3dFMHlITHhhdmp5Z2VV?=
 =?utf-8?B?RHRmQkQzR3hxcUZGdmdzckJpbVZGMXM4YjZRNW9BbFd4dEw3WTBISFR3MVlr?=
 =?utf-8?B?dlZWdGU5Qkc1RXB2ZmhxUXE1NVlZT3krSTZFMURqdmdaRVhnZ0RSN2FIZ0JI?=
 =?utf-8?B?eExGNng2ZDMwUW4wUFhUYUcyeDJneWlqeit1QmorMnl2Y21xcW5EVW1mK1V2?=
 =?utf-8?B?eDBBbHY0TzhVRnNqQWpCQW56cXQrNGU0dVM5R2pHQkJKR3BSWU1Ed1hxaDZt?=
 =?utf-8?B?djd1SmU2YkQ0NHpTNlU3L3EwcFArQU4yTTVkLzkxYnM0ODYzYml5bjR6Z2wz?=
 =?utf-8?B?REZvUGhnVzJibUJoL1JTM2orNUlUNTFaUThCcnJzUERVVndsRW9QTWFFcVI1?=
 =?utf-8?B?cmNLbTFUcjl0SFNSZ1JKV2hUY1Nya1RPaktBb2VmckZKaCtoTnJuS243OVhD?=
 =?utf-8?B?SXl0TElEV0s5cVZuQ1BKd2hFVnlic25JYmh4dERJazFUZEsxbE5UNjA1QWtF?=
 =?utf-8?B?Z2M1RndkRkp1VkR4SGlCaE02RjEwNkZEQjdBVGFKeGtpQWZ4VitBTXdvNWg4?=
 =?utf-8?B?Y3l4bHp4NVlHZ2VRSlloZDVjdlFFRjU1MFF0ME8rVEpYYVdKbGpEQ1ZuMmVH?=
 =?utf-8?B?eFpHcm54dkRUYTlTZW5xNitETDA1UGt5ZUF0TGhNWjM3U05hT1YxQWJXUjdw?=
 =?utf-8?B?L3NiQWY5Q3h3Z1lMV0RZMWF6cWV2YmtkQmV3QVhseXBVdGpnWTdwKzl6RVdk?=
 =?utf-8?B?a3JRbUNNZjBwdkxxTlFBcU83S05lOFh3TUlTZ01LUm51SFNhNm9ZZTgzdnNj?=
 =?utf-8?B?TUdLbnEvRnJldW15QVNTc2FBTlMxaFdjWkdkMlNaZlQvcEhYai9BSFUyVC9V?=
 =?utf-8?B?aE5rUjI1Qnk2c25ZZGVLSWpOZlNpNXhNdWErNUFuNllYYksxaFFsUUx5NkJt?=
 =?utf-8?B?NlBZeng2RElzMlBFbUt2UmhhNDBlQUREaGdhUUFxL0o2dmo3clZyakZmaGE4?=
 =?utf-8?B?Y0JsTE1lYis4amVtTjQrN3A3Y2ZDYklwMWs1RTFPYWJ5dEdFTDdBWW9aTVA1?=
 =?utf-8?B?RXNEcVZYd3RiVllBUW05NjcxRldlMTZvdGF2VW9waXptRERhbTJ0VDZ2L0JS?=
 =?utf-8?B?Wlhub09YaFR4cWV6ZjR4VjhmdkY3YWxMZ2Q2bmdxYjg4TFJWZ1FscHZUTnpl?=
 =?utf-8?B?NzVZdi9SRjhpRlBMYUt4bzFFeWgwWkJRcWhoUmIwZGxrRWJ6L3p4cm1obHY3?=
 =?utf-8?B?Q21KQ2orTWxybGVOem5wd09SSUl0TVdnL0NwYUpxUnNjZlRPdzVlV0lXd2xF?=
 =?utf-8?B?MDdHckwzbEZrSlBQMGVIdmRhSFZzVGlhOHlNUEdEUUlTbzEwZU95SXNTZGpu?=
 =?utf-8?Q?Yiuh5DFiZA+g5fULaLnvMP15k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52a48a1-26b0-4142-8a37-08ddf681cd1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 07:05:50.8875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WW17BwNWa6WvbWowOu6Y+oXbJ8r1M0BO18u3rh/1Dm9cZ8Y18hV0DhXrOFmYgXBc6KjeBcD1/rXQcowjW/OyOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6886
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgU2VwdGVtYmVyIDQsIDIwMjUgMTo0NyBBTQ0KPiANCj4gQU1EIElPTU1VIHYxIGlzIHVuaXF1
ZSBpbiBzdXBwb3J0aW5nIGNvbnRpZ3VvdXMgcGFnZXMgd2l0aCBhIHZhcmlhYmxlIHNpemUNCj4g
YW5kIGl0IGNhbiBkZWNvZGUgdGhlIGZ1bGwgNjQgYml0IFZBIHNwYWNlLiBVbmxpa2Ugb3RoZXIg
eDg2IHBhZ2UgdGFibGVzDQo+IHRoaXMgZXhwbGljaXRseSBkb2VzIG5vdCBkbyBzaWduIGV4dGVu
c2lvbiBhcyBwYXJ0IG9mIGFsbG93aW5nIHRoZSBlbnRpcmUNCj4gNjQgYml0IFZBIHNwYWNlIHRv
IGJlIHN1cHBvcnRlZC4NCj4gDQo+IFRoZSBnZW5lcmFsIGRlc2lnbiBpcyBxdWl0ZSBzaW1pbGFy
IHRvIHRoZSB4ODYgUEFFIGZvcm1hdCwgZXhjZXB0IHdpdGggYQ0KPiA2dGggbGV2ZWwgYW5kIHF1
aXRlIGRpZmZlcmVudCBQVEUgZW5jb2RpbmcuDQo+IA0KPiBUaGlzIGZvcm1hdCBpcyB0aGUgb25s
eSBvbmUgdGhhdCB1c2VzIHRoZSBQVF9GRUFUX0RZTkFNSUNfVE9QIGZlYXR1cmUgaW4NCj4gdGhl
IGV4aXN0aW5nIGNvZGUgYXMgdGhlIGV4aXN0aW5nIEFNRHYxIGNvZGUgc3RhcnRzIG91dCB3aXRo
IGEgMyBsZXZlbA0KPiB0YWJsZSBhbmQgYWRkcyBsZXZlbHMgb24gdGhlIGZseSBpZiBtb3JlIElP
VkEgaXMgbmVlZGVkLg0KPiANCj4gQ29tcGFyaW5nIHRoZSBwZXJmb3JtYW5jZSBvZiBzZXZlcmFs
IG9wZXJhdGlvbnMgdG8gdGhlIGV4aXN0aW5nIHZlcnNpb246DQo+IA0KPiBpb21tdV9tYXAoKQ0K
PiAgICBwZ3N6ICAsYXZnIG5ldyxvbGQgbnMsIG1pbiBuZXcsb2xkIG5zICAsIG1pbiAlICgrdmUg
aXMgYmV0dGVyKQ0KPiAgICAgIDJeMTIsICAgICA2NSw2NCAgICAsICAgICAgNjIsNjEgICAgICAs
ICAtMS4wMQ0KPiAgICAgIDJeMTMsICAgICA3MCw2NiAgICAsICAgICAgNjcsNjIgICAgICAsICAt
OC4wOA0KPiAgICAgIDJeMTQsICAgICA3Myw2OSAgICAsICAgICAgNzEsNjUgICAgICAsICAtOS4w
OQ0KPiAgICAgIDJeMTUsICAgICA3OCw3NSAgICAsICAgICAgNzUsNzEgICAgICAsICAtNS4wNQ0K
PiAgICAgIDJeMTYsICAgICA4OSw4OSAgICAsICAgICAgODYsODQgICAgICAsICAtMi4wMg0KPiAg
ICAgIDJeMTcsICAgIDEyOCwxMjEgICAsICAgICAxMjQsMTEyICAgICAsIC0xMC4xMA0KPiAgICAg
IDJeMTgsICAgIDE3NSwxNzUgICAsICAgICAxNzAsMTYzICAgICAsICAtNC4wNA0KPiAgICAgIDJe
MTksICAgIDI2NCwzMDYgICAsICAgICAyNjEsMjc5ICAgICAsICAgNi4wNg0KPiAgICAgIDJeMjAs
ICAgIDQ0NCw1MjUgICAsICAgICA0MzgsNDg5ICAgICAsICAxMC4xMA0KPiAgICAgIDJeMjEsICAg
ICA2MCw2MiAgICAsICAgICAgNTgsNTkgICAgICAsICAgMS4wMQ0KPiAgMjU2KjJeMTIsICAgIDM4
MSwxODMzICAsICAgICAzNjcsMTc5NSAgICAsICA3OS43OQ0KPiAgMjU2KjJeMjEsICAgIDM3NSwx
NjIzICAsICAgICAzNTYsMTU1NSAgICAsICA3Ny43Nw0KPiAgMjU2KjJeMzAsICAgIDM1NiwxMzM4
ICAsICAgICAzNDksMTI3NyAgICAsICA3Mi43Mg0KPiANCj4gaW9tbXVfdW5tYXAoKQ0KPiAgICBw
Z3N6ICAsYXZnIG5ldyxvbGQgbnMsIG1pbiBuZXcsb2xkIG5zICAsIG1pbiAlICgrdmUgaXMgYmV0
dGVyKQ0KPiAgICAgIDJeMTIsICAgICA3Niw4OSAgICAsICAgICAgNzEsODYgICAgICAsICAxNy4x
Nw0KPiAgICAgIDJeMTMsICAgICA3OSw4OSAgICAsICAgICAgNzUsODYgICAgICAsICAxMi4xMg0K
PiAgICAgIDJeMTQsICAgICA3OCw5MCAgICAsICAgICAgNzQsODYgICAgICAsICAxMy4xMw0KPiAg
ICAgIDJeMTUsICAgICA4Miw4OSAgICAsICAgICAgNzQsODYgICAgICAsICAxMy4xMw0KPiAgICAg
IDJeMTYsICAgICA3OSw4OSAgICAsICAgICAgNzQsODYgICAgICAsICAxMy4xMw0KPiAgICAgIDJe
MTcsICAgICA4MSw4OSAgICAsICAgICAgNzcsODcgICAgICAsICAxMS4xMQ0KPiAgICAgIDJeMTgs
ICAgICA5MCw5MiAgICAsICAgICAgODcsODkgICAgICAsICAgMi4wMg0KPiAgICAgIDJeMTksICAg
ICA5MSw5MyAgICAsICAgICAgODgsOTAgICAgICAsICAgMi4wMg0KPiAgICAgIDJeMjAsICAgICA5
Niw5NSAgICAsICAgICAgOTEsOTIgICAgICAsICAgMS4wMQ0KPiAgICAgIDJeMjEsICAgICA3Miw4
OCAgICAsICAgICAgNjgsODUgICAgICAsICAyMC4yMA0KPiAgMjU2KjJeMTIsICAgIDM3Miw2NTgz
ICAsICAgICAzNjQsNjI1MSAgICAsICA5NC45NA0KPiAgMjU2KjJeMjEsICAgIDM5OCw2MDMyICAs
ICAgICAzOTIsNTc1OCAgICAsICA5My45Mw0KPiAgMjU2KjJeMzAsICAgIDM5Niw1NjY1ICAsICAg
ICAzODksNTI1OCAgICAsICA5Mi45Mg0KDQpkYXRhIGhlcmUgbWlzbWF0Y2hlcyB0aG9zZSBpbiBj
b3ZlcmxldHRlciwgdGhvdWdoIHRoZSBkaWZmZXJlbmNlDQpkaWRuJ3QgYWZmZWN0IHRoZSBjb25j
bHVzaW9uLiDwn5iKDQoNCj4gKw0KPiAraWYgSU9NTVVfUFQNCj4gK2NvbmZpZyBJT01NVV9QVF9B
TURWMQ0KPiArCXRyaXN0YXRlICJJT01NVSBwYWdlIHRhYmxlIGZvciA2NC1iaXQgQU1EIElPTU1V
IHYxIg0KDQpyZW1vdmUgIjY0LWJpdCI/IEkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYSAzMi1iaXQg
Zm9ybWF0IGV2ZXIuDQoNCj4gKw0KPiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgYW1kdjFw
dF90YWJsZV9pdGVtX2xnMnN6KGNvbnN0IHN0cnVjdCBwdF9zdGF0ZQ0KPiAqcHRzKQ0KPiArew0K
PiArCXJldHVybiBQVF9HUkFOVUxFX0xHMlNaICsNCj4gKwkgICAgICAgKFBUX1RBQkxFTUVNX0xH
MlNaIC0gaWxvZzIoUFRfSVRFTV9XT1JEX1NJWkUpKSAqIHB0cy0NCj4gPmxldmVsOw0KPiArfQ0K
PiArI2RlZmluZSBwdF90YWJsZV9pdGVtX2xnMnN6IGFtZHYxcHRfdGFibGVfaXRlbV9sZzJzeg0K
DQp0aGlzIGlzIHRoZSBzYW1lIGFzIGluIHB0X2ZtdF9kZWZhdWx0cy5oDQoNCj4gK3N0YXRpYyBp
bmxpbmUgdm9pZA0KPiArYW1kdjFwdF9pbnN0YWxsX2xlYWZfZW50cnkoc3RydWN0IHB0X3N0YXRl
ICpwdHMsIHB0X29hZGRyX3Qgb2EsDQo+ICsJCQkgICB1bnNpZ25lZCBpbnQgb2Fzel9sZzIsDQo+
ICsJCQkgICBjb25zdCBzdHJ1Y3QgcHRfd3JpdGVfYXR0cnMgKmF0dHJzKQ0KPiArew0KPiArCXVu
c2lnbmVkIGludCBpc3pfbGcyID0gcHRfdGFibGVfaXRlbV9sZzJzeihwdHMpOw0KPiArCXU2NCAq
dGFibGVwID0gcHRfY3VyX3RhYmxlKHB0cywgdTY0KSArIHB0cy0+aW5kZXg7DQoNCmNoZWNrIHRo
YXQgdGhlIGluZGV4IGlzIGFsaWduZWQgdG8gb2Fzel9sb2cyDQoNClJldmlld2VkLWJ5OiBLZXZp
biBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCg==

