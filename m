Return-Path: <linux-kselftest+bounces-33034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0975FAB7E07
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3313189D74A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 06:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ED9296705;
	Thu, 15 May 2025 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMI5V0ra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460701A08AB;
	Thu, 15 May 2025 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290677; cv=fail; b=NR4fgPCuxKfXb5h9bOMFOW/JfM+cQLhyBnLQ2uAJjuPxiOhqVHHHal36e9YWxOd1iD8iZ4vLzCdXDYiZavixDacknSYa/MhlFzEuIG64+00MBlRyl80Z+NXpS+fd+N4dD2Z9FS6g0zP+Mvuf/ys04YQ7hUt8kt2sL7dxC2DGtpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290677; c=relaxed/simple;
	bh=uO8ZveKd0kjgJuQdJmzq7YxCTzKlLOK36Eb/Facc7T8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=isCXPnjPmVYN/voA/lCay3jgQr07bASMk8RfRGQFXKfkHGFysh6yh+QtV2qLobUEwysjN22H4RLqUczpy0cCiwv1im8VHPPKPcvitJVaSm9heYom8Mpight/w32EQ5Q6DmHH90udpsm3qkkoDcFL5B78eK7tUb345+bLzoDm1ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMI5V0ra; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747290675; x=1778826675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uO8ZveKd0kjgJuQdJmzq7YxCTzKlLOK36Eb/Facc7T8=;
  b=fMI5V0raLw8y++vJkrM22076vzceUFcntGnMqXFB7HP5koaI7b3R4TR+
   uhEHNXcBE0T8QpKrU4lBzTmmCUVJoYkfYP0VOlmNQ4doH0ADZMwAtS1n4
   2ES4lRjHsdOLDFbCDMJ6Tn1WzhKSDJGjgOYXWdeGp8p3TEdi3pRkPqXVd
   Tng+x4au+MTgxhGGkpNwoN8MlTQk2wPUPEG6UhA+WJQAtU0qSIRZ95f+x
   2lNLgw7qcFMxq/XHYH0Ok6ul7uFpAyFrT7ZE2fsejDEO1uIoH+1XNMFYB
   EGsMWz8qc41DjRv7MjQuHioJvFXWZCkd+G/hH6ut5ImK37xHG9SoEv2Fy
   A==;
X-CSE-ConnectionGUID: gDlz2QeLTPmhgkyEQcbw8A==
X-CSE-MsgGUID: r3KjepDQTSmw2fh98yyEag==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="60549088"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="60549088"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 23:31:14 -0700
X-CSE-ConnectionGUID: FKc3in58RiqnZjNfk7BvMw==
X-CSE-MsgGUID: zq2K3L3+QRCWAfWAoAVM0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138140192"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 23:31:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 23:31:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 23:31:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 23:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sM4z/1IU5hwQxXFyJSeHS7a9KO8TfH/oc552diZxHLM2L84tT3skIDQcE2rm8odZxnspc1bQg9QPczhWh1+1ET6OyehUuabiJ1dUAmbQBr+v7fhQn67TmeId5m5x7gq091WI1ME6yNcr0YIp2O7hbLNukcBN+WgwydaB2WCYy7Ytk1TrHxmWQp1IRcLC8Te9fNUAB4T9O2qNUVoYp/i5pIj5uiARQuOq9hsIrap1BkwEc9yjt49HN73y+h2aLuanfSk3CVelAyBqUPexSCa4xgLNu/ewl4KOdQGLXi3pXUBIMBRDAeaLc3pGd+Wr7owS+5gla5ZRcOrIL9QrqUSIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3En00hcE74Vi/9qXMXmp4u6hYp4crmSNQhs45rn7a4=;
 b=n2QqhLUDk2B67YOOa52gIgyMB6fORkx02+HuguKolS28FI2oRHNJUVfXwCiquHYi9TW/caM7wt3V9jkVagAn3yLk4ZaCZJyh/d0Gk+0Yvrgc0dvML60XawiW4cjIPjX5SW/V1ckHH0lH6m1/zFT+3EfaruV2l5gGyQJFvfNyEfrYOl7tACiGx2CvzY3zYl24vCDuG+QpBbppyU1bur0/sDkmrdAgoenqgz7ohX9W6qoLkUZZeP0C1rIzIt/Ln/khMSo99zuogdkn5Xk95eRcKV6F0nSFzHD2VH/NZEBEeHeMYYeV94SXWlpBjEf0pnJfu0Ji3n0we4w0YU15kewb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4770.namprd11.prod.outlook.com (2603:10b6:303:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 06:30:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 06:30:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Thread-Topic: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Thread-Index: AQHbwI8AVK9WzAglbEaPfz4i9w6907PTP58w
Date: Thu, 15 May 2025 06:30:27 +0000
Message-ID: <BN9PR11MB52761EF8360BEF5C19C2382F8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4770:EE_
x-ms-office365-filtering-correlation-id: 1883266d-5b1c-49b8-5ea4-08dd9379fb8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Tsf0O7bZ6UDLKo0zGpzCMDYdIjuYqQxl1+HT2EODnh/WVQ0yAeP0fI9iy0Lf?=
 =?us-ascii?Q?kSiD6edd0y6FUgBnPheYyvQ8jSfBIH4jkNah1Go164TqnQrbAoj6dwnyNh4O?=
 =?us-ascii?Q?yehirVbtYjb3fnEUIPRBl35hJL7ePrQK0VeK29fuk0LvvEq8hJuiSq/ltx1U?=
 =?us-ascii?Q?8b31NNXDmq8NIIlIPxzOZ89BtISMC87ROUB37L4EMAYQurym8x/9jnzueeaF?=
 =?us-ascii?Q?SHTSEXgqQPNx00jUpYEfSNARPLWt8RrLYFuqtqsuDJC2SzufV3ICanN2251T?=
 =?us-ascii?Q?QP9H0gt19lZ7IsiNkQ4veCQXLRE855LU+V7gHJ9IjjXP2brbBsbDODxc2AGQ?=
 =?us-ascii?Q?sNkyrd4OIpjxCwTVYU7CwWYvq1h7ajhKAjqerPzfGmL/4bQxQ29tQvi1Aqrc?=
 =?us-ascii?Q?MsH5lpu0C8eo5iIq1v1Oi78XjAXtuZsB4R9Rf8wMYdasr9CFDhDTabtB9Tq1?=
 =?us-ascii?Q?npatkoUftkREQELi/645BfwQJfjEbUBEMXNMcYTrRDYeNrkZpj93p0gxfa2X?=
 =?us-ascii?Q?qJk/v19j/cENypK1tvHtUxfFPVnmAgRo5ehf8vVCeMyAgNgOW7r+x+jJx35G?=
 =?us-ascii?Q?ow8KvphwORnvN4y/HCfRKzGHKh6axzD1aHLvKv7KA79J5MxA9YtIh9bEPKKr?=
 =?us-ascii?Q?LWt5sDi1s6P3r6H6E3jKIc3EatYKhdEqqrfqA0c2dgqK9zQ9wIAEJ/OGX9S9?=
 =?us-ascii?Q?nUtUC7c+dCWMDLPhSNsgyfUyRWb4ciZWCgFpkTD7UYVi0fRhHoQVO5kHeLWq?=
 =?us-ascii?Q?nUao6a1i+OIJwi2P2q18t99MKIWjh06LZfctKu64LLFhLc7Ln4BhNdE1c2r2?=
 =?us-ascii?Q?EP+UEreM7dP2CxEhrgqyY3aS+jAXzYuPOLcgT/CveHzzubMq2CS5mzCCJIwE?=
 =?us-ascii?Q?3JHGY/zGpbFySbmG3Ve7kH4gQdIgG7jEHGw3vvIQccJJlgzAWsP51fMYOBO5?=
 =?us-ascii?Q?zC1mjPNEAw+vRVyPw0OKAch7J3ZtK3N1a3C779A5KOo3Pwux1Okh5Mza1Fq1?=
 =?us-ascii?Q?XUc/bWCrDUCwSdnYYAxhYUjk34Xea5GWsPIDyad02sMRhfVix9MVcYZziLyo?=
 =?us-ascii?Q?McKjCN5Ur8e2dHM1tm9ZR6Lc4dt745PtL94854H/OFlxRVnrzbUK7P4Ka0wi?=
 =?us-ascii?Q?cUkzxeKUow9LxuQiZ4vcctlRI6R1ncrL2lpz2e9MaJVuWHZKW3/ZQKDU60M2?=
 =?us-ascii?Q?BxgFy1biMlhRyyt8mS5pe+QALtNJb4Xm6NaeTq6FZ1VqKMpb8TfYSE20GSkn?=
 =?us-ascii?Q?8UTkLA+tEC+PgUqEEvACxgbNuaLBgBmNelyzldu31+3opRlwHpcgaBNwfIaE?=
 =?us-ascii?Q?W+jzEEa8eqkZZBOwWBVdNqb2c9j0dAx0k5MIYUk2AOQij4rS72X3np1BS9Xq?=
 =?us-ascii?Q?6A8T5bwpjO166Aehi1nQw1bIXVzRZsyY9mphD4UltvPiD+WNfJvdt0iLsYUx?=
 =?us-ascii?Q?in9kUK4BgH1bJ8uGdYzfAn1zAsbaiajy9iuvqzBXETN7/4fA6lHChTEtJwHb?=
 =?us-ascii?Q?u0lglMTLgGZrU8E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DbVwIiQqSa6Y6aR7JQTy4w0dbgBn/MqfFWgH80kVOKmIdUJEdWcpgyjCr98k?=
 =?us-ascii?Q?MwalF6k/wlHE3S/X3l0llKgONxrWFdA0Lop8MAXsilGYzwfmwaoxePey7NIg?=
 =?us-ascii?Q?Zy/pjn0fuAMCxCtB7mlyhNhWRWhKOPC1u9ivhW61QU4xF2UeKRFWtAaTeglR?=
 =?us-ascii?Q?Gbt+DCCBLrNm1m8ddqkEwmOOffIRhmn0pC6dnaHEBmbOwqyK4ckNQS5Qkf3e?=
 =?us-ascii?Q?1AeTh/12YICJOcbrSMKogq9Fsw5W4nvKWZXulWXis+5j0GyY14sx7PEgOO8e?=
 =?us-ascii?Q?p6tSHDezG3kgPI+KEcW0WykQomQUiXQjgMGJ47OmAiXKNRtQfdHJBOzr1y+a?=
 =?us-ascii?Q?gozK93XHdqYeZEhj+++vR9ucj/MjyYoI1c4g2qEaYbrUCwE416k6geg9Udeo?=
 =?us-ascii?Q?mi5yxj+/ZHs7ysXBPUuhoRe8NcBd9Hxctf7AowNXVbgSQaEr9bildoY9meXb?=
 =?us-ascii?Q?H2GW8KjM69deMYM/AJJTyxA7yGKjUOQdvEl/l9xS+fFcr85bNURMchhgSt4O?=
 =?us-ascii?Q?eyqWn0b4HxTuE4uWRK+5PoOm1dYRpecwi2ZNfnaWPtYbk3t5CarTuywi7opR?=
 =?us-ascii?Q?RbDWGfYGXxFWtSfT/Az2oTN5fWI3PhoBACwL4KeSW/TUqBuKnhU+oqbVmDM+?=
 =?us-ascii?Q?0To/NDj/xbyS+y2meXBzkm+MEqW4fDuz31Zo2PuKZ+EQP93GRF95IkGm52gN?=
 =?us-ascii?Q?eUJs+aFY0dWf2PUwBS4OWRwvB4ODLbhtdhSgWKQXJ6aQpUI56toGK880aVt0?=
 =?us-ascii?Q?Y8kFbIO7bCLvAXOGSUx/5TKKSfXMENOfakCC12pcttSaPzP219evY0yToyto?=
 =?us-ascii?Q?qWZs/2jUbDe47lEgezCs7rieCkawF0qwpXXzBYminrJFz8zZkwsopq3PD8kI?=
 =?us-ascii?Q?KzmNjeZF7AaMag0xfS42qpR9s9gkDLUf8QkhQ/vPSPtYtezjrbd19AIHnTSt?=
 =?us-ascii?Q?YwjnB/QymU3FbPs+lRC5kBaXZjDiCs3KSPhsINyoCsQmDJtCroxk9NdWwWJ1?=
 =?us-ascii?Q?cSFekJ71tH8FX+sIKVuPn5IVJjP+clkHWhwJCUGNvhH+eWBrqWzw25+hrerr?=
 =?us-ascii?Q?pLovQ/7rOl6/BGZu8mS04k6U3+glQa79d4MeVSrB8QoE08qBpHebp83GLKzE?=
 =?us-ascii?Q?0ORGrSHbijCf0l/2bKxe5wFEDhKO7gdIDqyAvxNdvkTiN+ah9/vBU4744CSE?=
 =?us-ascii?Q?07l4cjmGUnsQNP2z1+K/7EdO4nfoMcOK/WvqLvDcDJ52mgUtGQFKtOHsQjou?=
 =?us-ascii?Q?ePgLCeKZvEI7Czcs45hY84CMgvtL6MMMHe1TiDRS7XcuI+aY43E8+95MVjWV?=
 =?us-ascii?Q?Y+wF2JiIu2l+CWQsqcgzAIUNEk+jivcxUBDHcbOrKNzCdQ+TCjlCXRoMd0D5?=
 =?us-ascii?Q?EBSlcfDyLsG4vW9T3mD1qlQNWxthob5YLut1HLvrwpMVuKCRYoyleQmt+Fg0?=
 =?us-ascii?Q?ZAQHBDmdaQfAHb50K3ZthtBO3ONZBQD+x0sKVun+MD/1SXv5E4b/Kzyqan3A?=
 =?us-ascii?Q?ekikRIRyKxazbkoIKSdYjmj6UC+RThKKS1Or8FeuwkBH5w4anPtrWGq7uIfa?=
 =?us-ascii?Q?gMgurIR9B91SrHB3ROe+WxGilVPtwCiHY6aqrwiS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1883266d-5b1c-49b8-5ea4-08dd9379fb8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 06:30:27.6935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmIFJbNa3ZOhqS5h+nt34z44pStJ+M6k0Hs5VCb1xv5eHV4MSmtOK192/r7r8zZAdD+vTcavMLYtQtjeNtNnCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4770
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:03 AM
>=20
> +
> +/**
> + * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
> + * @size: sizeof(struct iommu_hw_queue_alloc)
> + * @flags: Must be 0
> + * @viommu_id: Virtual IOMMU ID to associate the HW queue with
> + * @type: One of enum iommu_hw_queue_type
> + * @index: The logical index to the HW queue per virtual IOMMU for a
> multi-queue
> + *         model

I'm thinking of an alternative way w/o having the user to assign index
and allowing the driver to poke object dependency (next patch).

Let's say the index is internally assigned by the driver. so this cmd is
just for allowing a hw queue and it's the driver to decide the allocation
policy, e.g. in ascending order.

Introduce a new flag in viommu_ops to indicate to core that the
new hw queue should hold a reference to the previous hw queue.

core maintains a last_queue field in viommu. Upon success return
from @hw_queue_alloc() the core increments the users refcnt of
last_queue, records the dependency in iommufd_hw_queue struct,
and update viommu->last_queue.

Then the destroy order is naturally guaranteed.

> + * @out_hw_queue_id: The ID of the new HW queue
> + * @base_addr: Base address of the queue memory in guest physical
> address space
> + * @length: Length of the queue memory in the guest physical address
> space

length is agnostic to address space.

> +int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hw_queue_alloc *cmd =3D ucmd->cmd;
> +	struct iommufd_hw_queue *hw_queue;
> +	struct iommufd_hwpt_paging *hwpt;
> +	struct iommufd_viommu *viommu;
> +	struct page **pages;
> +	int max_npages, i;
> +	u64 end;
> +	int rc;
> +
> +	if (cmd->flags || cmd->type =3D=3D IOMMU_HW_QUEUE_TYPE_DEFAULT)
> +		return -EOPNOTSUPP;
> +	if (!cmd->base_addr || !cmd->length)
> +		return -EINVAL;
> +	if (check_add_overflow(cmd->base_addr, cmd->length - 1, &end))
> +		return -EOVERFLOW;
> +
> +	max_npages =3D DIV_ROUND_UP(cmd->length, PAGE_SIZE);

what about [base_addr, base_addr+length) spanning two pages but
'length' is smaller than the size of one page?=20

> +	pages =3D kcalloc(max_npages, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;

this could be moved to right before iopt_pin_pages().

> +
> +	viommu =3D iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu)) {
> +		rc =3D PTR_ERR(viommu);
> +		goto out_free;
> +	}
> +	hwpt =3D viommu->hwpt;
> +
> +	if (!viommu->ops || !viommu->ops->hw_queue_alloc) {
> +		rc =3D -EOPNOTSUPP;
> +		goto out_put_viommu;
> +	}
> +
> +	/* Quick test on the base address */
> +	if (!iommu_iova_to_phys(hwpt->common.domain, cmd->base_addr))
> {
> +		rc =3D -ENXIO;
> +		goto out_put_viommu;
> +	}

this check is redundant. Actually it's not future proof, assuming that
S2 must be pinned before the user attempts to call this cmd. But what
if one day iommufd supports unpinned S2 (if a device is 100% PRI faultable)
then this path will be broken.

> +
> +	/*
> +	 * The underlying physical pages must be pinned to prevent them
> from
> +	 * being unmapped (via IOMMUFD_CMD_IOAS_UNMAP) during the
> life cycle
> +	 * of the HW QUEUE object.
> +	 */
> +	rc =3D iopt_pin_pages(&hwpt->ioas->iopt, cmd->base_addr, cmd-
> >length,
> +			    pages, 0);
> +	if (rc)
> +		goto out_put_viommu;
> +
> +	if (viommu->ops->flags &
> IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA) {
> +		/* Validate if the underlying physical pages are contiguous */
> +		for (i =3D 1; i < max_npages && pages[i]; i++) {
> +			if (page_to_pfn(pages[i]) =3D=3D
> +			    page_to_pfn(pages[i - 1]) + 1)
> +				continue;
> +			rc =3D -EFAULT;
> +			goto out_unpin;
> +		}
> +	}
> +
> +	hw_queue =3D viommu->ops->hw_queue_alloc(viommu, cmd->type,
> cmd->index,
> +					       cmd->base_addr, cmd->length);
> +	if (IS_ERR(hw_queue)) {
> +		rc =3D PTR_ERR(hw_queue);
> +		goto out_unpin;
> +	}
> +
> +	hw_queue->viommu =3D viommu;
> +	refcount_inc(&viommu->obj.users);
> +	hw_queue->ictx =3D ucmd->ictx;

viommu/ictx are already set by iommufd_hw_queue_alloc().

> +	hw_queue->length =3D cmd->length;
> +	hw_queue->base_addr =3D cmd->base_addr;
> +	cmd->out_hw_queue_id =3D hw_queue->obj.id;
> +	rc =3D iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		iommufd_object_abort_and_destroy(ucmd->ictx,
> &hw_queue->obj);
> +	else
> +		iommufd_object_finalize(ucmd->ictx, &hw_queue->obj);
> +	goto out_put_viommu;
> +
> +out_unpin:
> +	iopt_unpin_pages(&hwpt->ioas->iopt, cmd->base_addr, cmd-
> >length);
> +out_put_viommu:
> +	iommufd_put_object(ucmd->ictx, &viommu->obj);
> +out_free:
> +	kfree(pages);
> +	return rc;
> +}
> --
> 2.43.0


