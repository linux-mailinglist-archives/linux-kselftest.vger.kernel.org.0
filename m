Return-Path: <linux-kselftest+bounces-43288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CCABE1D01
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 08:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BAA423E01
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 06:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF72EF65C;
	Thu, 16 Oct 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ayw8F4NH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDBF239E63;
	Thu, 16 Oct 2025 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597535; cv=fail; b=UUWEOKooq1VoCp/WS8XmUWe/LDJi2gGvnhVBcIHySUDOpWZG6hTuYpOuW564MgMSZzSvlQglbkZLdpiK4jscQO8w7YHDXNhVkEQkPj0Nn6Dh5FNYBnPSaqD+Drur3JTJob3mb2Dh5TJ2bBVx8qUn8KXfFN4Be8cESfEdWv/n1vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597535; c=relaxed/simple;
	bh=DLaUy+KXlNfFB6u79FVG1dyXXgP9aqyT9Ddc+VRUQfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g55tp22msSmtXRBsLrI6e6uy6v2OHKXhrVr4Fw0K8LZnVlbkYecAQCa4PyLB4iM+3VbVwNsLviY4fMA5Ci0Bqs52bIZ8IBV6XOSmq4L4ZUP+//zCIlLmJ2UVvEZ5N69sFsU70HeDHs9E7U0DWcBmVSeBEVpvpETro9ta8+wWmiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ayw8F4NH; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760597534; x=1792133534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DLaUy+KXlNfFB6u79FVG1dyXXgP9aqyT9Ddc+VRUQfE=;
  b=Ayw8F4NHY6esjwSrl3tZ5LcYFRy2IfaEfld393p6WHUfXK3R4sihk4qI
   19/bf12KlFn8URT1ZBMbGSC+uBfu95/KnPmBpNe99lC/YJNAF04i5gran
   sAXfKubRRPNOL69QyjCNzpp8HhhsTOIvOoTs7gZ4g8+/JXAT+hMIUUvzy
   kBRjnB1EXCeU8Jg3/qnO4pD187vyXPRh2/e3tt603FdI4GWMIlZEHov/B
   px/J35DuIgqJwsfBWifKHZhP10Xn4TE4jifbiNLupAZuPEQKCOCsT/mxr
   nipIUJFfuZopvh3gcSAPs8EilCNR+R/3PYLvlbcY9IpM5a3ke8dCE99PI
   A==;
X-CSE-ConnectionGUID: Woe1NpHZSsyYsaR83BsJ4Q==
X-CSE-MsgGUID: nTb7NaJmRO62cVgHN4hxeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="80416645"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="80416645"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:52:13 -0700
X-CSE-ConnectionGUID: LT/E98DJRf+Q3Mv7GRl6gg==
X-CSE-MsgGUID: 47AtMAioT3SpWQ6Zo/17EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="182049382"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:52:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:52:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 23:52:11 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwtl7oTF80D/HLADJI7EzBtcIk+dY5zYGEvlID8rg9AS2onI4f+Ne+zcXN33NgFjaxIOnsUxSDQkJAC5X6lyTGLFDZh1BTO5EhdZpV+KDbp4fF3EsuUIFGj2HZo0HyA6yoO0z4zZaOhQq7vnjchz2t+zaORtXgwRxIh+chyvGAK0O9RXqu6qDHKClIAxbVAEycgm62JfiJKy1jqxP3TsD7ai/f9psTHKT5Z7rb9P3RTUM0+Bg5MjE2JMxUxVOBudVFiUBTs7/Ew81YCPGcytulh3jJS04bIBcv7k0XY/IuPVz19TvevytE9rvUhQT9yctMHlzieB1WWuK6CyZ6DT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdzHCzChJ5dQJf7LSJCvh1Y/hCvGKiQQ5QyBc7Cc6c8=;
 b=tiTDPRs80+BIZqiClyPidUOFMCzymZXdWvnXPf3H740gGa9XmnX5sm1JjGMxswqb6xvHBhIud2mMTSBXrnMFH4a6lY6sad5DDK3Ykmc21C4/Kmx1Y0/O3yef3OSkFg5xu2UUgzR4VO6y2Gk2TA7mhNJiGZVxarWknqBgRGyexPZMFZzERu7Y40TUqqfQBTaLZTuFfLGeM5rSScDLszOpArur29m6NEVcMCDHAmYXpkhxNIc6KAECQlK2SmansnM97m0cbNjp3prvMe+AkHCSuLLKQ0ySxzgmwEwjY+hFH57ldUCrinc304kXcG7hCHmDcuw4vaew0CSWfq5XtK2JJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5060.namprd11.prod.outlook.com (2603:10b6:303:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 06:52:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 06:52:09 +0000
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
Subject: RE: [PATCH v6 07/15] iommupt: Add map_pages op
Thread-Topic: [PATCH v6 07/15] iommupt: Add map_pages op
Thread-Index: AQHcN6Yiab75UJ4LVUejV/E9P+CUlrTEXBZw
Date: Thu, 16 Oct 2025 06:52:09 +0000
Message-ID: <BN9PR11MB5276271302BF0AAAE2C7085A8CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <7-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <7-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5060:EE_
x-ms-office365-filtering-correlation-id: bf84e17f-ad83-4f27-d166-08de0c808702
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?qzvYQsTWbaCxW88Fn7HbZfykojXx1PSdXPOhpJ7iD9cjaqoaoJ2TN9Q/gf2Y?=
 =?us-ascii?Q?S6aHWBX5k0Se/cCZ/ZgWAZ0fOvKi6130iHbkMNzskCfqAK6AyHm4N875CHqv?=
 =?us-ascii?Q?MnemvUWbcqA8quGKLJP4BUHd0lK/6+MvSZ4klwmP1qx/thF3SA0ygD3nAdOb?=
 =?us-ascii?Q?TGwd+IBJjjeCxNYomXI+6J173w2B1llyoXBt+kdpdWjiMup8kWfGZ7mVDUIj?=
 =?us-ascii?Q?mcsW3GURXzyEKNnWfk5Y0y+/AXhP9wkkPYgAGEd1ll6dx0MusaD5ER3o4I2F?=
 =?us-ascii?Q?mWbuzflQyoHnqvlZTyUdyEZyf8A49NAr3+BKagRioFgMvlL4PbAJECzzZ4+2?=
 =?us-ascii?Q?Q4pvxg5IodaoTag4wqdPHptGsi6LhZf5BS1W0k2ZsQRuhlJchXrRrari3Phz?=
 =?us-ascii?Q?EsznYwRM2DRrz6LCZpTn5eSA2tfu7Kxy3nSz9t9oZ2Mi2DMWFnT01V0VTTHx?=
 =?us-ascii?Q?M2cNgaOTU6/f5TpMRWGmn0PRXOvKuMo6YGOfg/WvvWR+uSDDAUYIiYWKWLl8?=
 =?us-ascii?Q?9MEZ7nj0uJHplC8rKxiLhCvFx0IXdJG0q5LcIgtGwLbI3O41EHLI4hux8fl3?=
 =?us-ascii?Q?tfvL13QjC6dFcu/GjTHKP2hYkz9pggLX1kO+KWFwrfzxdplNLuNZA6cGwNS5?=
 =?us-ascii?Q?Nxr7asaY1Kv6n3sZoNWW5n3+7F6iUzzOfHpqWNjBJueSCbT7G+VKaHEtXrE6?=
 =?us-ascii?Q?8tzlFR8NhvieMTUoxRGd5LbrWAMbKftW1oN62ifRmCumAXialFbFpN7iAnOI?=
 =?us-ascii?Q?pLpT7ns4xd+IIxHWRIhUCB6ahSaP8mzz8dzym7gQeeNaEy2ZkcacQWxIgkz2?=
 =?us-ascii?Q?c6PztPxpBuEwgavFFzymCcVeHgEeAN/tXH/lxBq+FByO9JBTeJ+xM+sBLyQY?=
 =?us-ascii?Q?iesjhbTgrj3jzzSwjZGUsiMsASWlzy/SseCJohKml4/YEEzNgJvpipgBRorE?=
 =?us-ascii?Q?fLW+TZT3T0T3MCBK1Ps1Bc4GtGs+MDESHXu2rrfhlOsQWEHptb+Xn8/WaZHn?=
 =?us-ascii?Q?RvMrbGa6aGSOPCkMdywOl5G9s5PlazVqgRRx6LPYVM167lpZb0QJKm2NGHVC?=
 =?us-ascii?Q?5NRfdyAATeloO+OkKMKNa2lBHtASeqQ+pUWoCxClYM/gLb3RT0dv02VfNpiw?=
 =?us-ascii?Q?kODEm7Gxab556LZx8EcgwX41b7/wD3jgUVomWJatJKDnlaEE81kx9856JOyA?=
 =?us-ascii?Q?pwfgIEyH3jgsmns2vZz7Wf5BqKi+M7+r2uRoXPmsjXfSySXSp7t12KHi4NKW?=
 =?us-ascii?Q?01uvz8I6lDoV14RrfcGfJmUl74AKt3u1agIbu2QWJT5FXWmAbrJ3svLpTnTW?=
 =?us-ascii?Q?1lC1QlvnbtjQK9FIqVaY/+iCvJ1sJt8EvXyiQsHZYFFA2n5AIzpcGRtIiWMp?=
 =?us-ascii?Q?e4EUJnOEilRTOwuQEB7YOK8vxf178aLu4OndchcTqyf+J1CieN6TPkQ2tozd?=
 =?us-ascii?Q?Ni2ju/euejPm6LGDJLh28jqxO1gPGYx2/QN3DSjafm1u7bjaMNNA8zOs4Ebn?=
 =?us-ascii?Q?qW7HP6TZQhKvptB34+Uhj+KlkCNFgDZALFxbSSkqXjxyZ7a7jneSRAlXEQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kSd1ttQ0eVeqw7axD23EzXKsu5YkyXLAH2cdekUuigJ109ApTX+XH8OMfZu2?=
 =?us-ascii?Q?e36P6JHskpg//ClAagqXg4dP3sVEwLNv4dOMs4RBuN9u7erf5fHLQ3Vxbefz?=
 =?us-ascii?Q?yuLSWM8mm1u0u0I3wmQF1TtHnNftmm7krFBNKrHDuJ0NXljJ8Ap1nElIdpT2?=
 =?us-ascii?Q?kUX5Z1gZ3lVUTx9q6+as5KMbx1SswjwFBOJa+RaoACLc1qqfT0RNJDKH1/oE?=
 =?us-ascii?Q?tzM5rtMqRVz9nKIbORR9dL5k3Ou7Xw1vLdnPPwsi4K0n3uafYfSYVfIlh/ax?=
 =?us-ascii?Q?GSxzqI3FmJUndBkynZ56Bua+mbGHZA2SY+OIxQy6+i0Q/bEFDewmVRMAlJXq?=
 =?us-ascii?Q?wogzerwoAZoKCAwelPHLh4oGzkEbHzBUJC5IsuOsrTIpsJrKZr6M+pmeFtpr?=
 =?us-ascii?Q?o4f5nXtrsYacJyWJZV5IywIh6N5VXpuqqvv6hN19RyyHJwDKAPiykyZDcUin?=
 =?us-ascii?Q?ItLEXCCf/aq6ioG2toGK/wALDJKiFtg3QgiwsvCY+E7alo/Ut/PMuRD13PMJ?=
 =?us-ascii?Q?HGu4xjmFvoOuvHYTt0t4IhDHXHg09SzJtHtDwFK17Kec4CRpe+L7Q+X/yIe4?=
 =?us-ascii?Q?s9JswQDzRO5hPvjpgZ/zNp+y7IbPSs6c74sMCoXEVq+bgqOHmTJXq64VTaip?=
 =?us-ascii?Q?Mq+c2/RvVC3wru/iZoYz4YEEtjgvxj++3j1BQjuVu6mbNlHdEmeQ3auhrE1g?=
 =?us-ascii?Q?7TqDNBnL8l2qSEguNpfNIW5KyhBJN76o+VJJgawEXlQ9vtI1t3eFLbqRDmG8?=
 =?us-ascii?Q?bbWWgNdTfToQ2clPIKgNljCIQTMf+ECPgLg5sv6KmRh2N0NuBvRK83g/CblC?=
 =?us-ascii?Q?D5PSt/k891l30q3PO7sHIsOYLsXVSRVivwVXoFW4OetOchHvKRrlgTfLKVJT?=
 =?us-ascii?Q?lf1i3Lfm8ep0t23dHibWzDg9QhxgX5vKFcg4hBFnF51clXxzNuCwE0OG8/Qb?=
 =?us-ascii?Q?CFM27PYTVfRGiBfC/9vFWTAGgUdSOCUKL8wFYkvS5oJm9en7OXZ79sX/r2yI?=
 =?us-ascii?Q?Zi4e+3Ng5hXqwse7wmA45+Zjs6eTv/v4qVFzBpHU4ueoA7fXkj0SzvsDsw0q?=
 =?us-ascii?Q?f9sQJPwLIY3Pbi8x9dEkkdScxQ+qss5xbcffOCXZoQhHGm8hjP+FqoibHGXz?=
 =?us-ascii?Q?2d62mX3z4Tdd9eml9MtBeNhUMhxkLxkJEDtUGUBVghgn/CNzqrzyZbuZkQos?=
 =?us-ascii?Q?YV5LPPy2tR/S4Lo3lIrCqF6Xb1kBp8fG4ipoIG2vOu7bLRzIRnQxsc8XGK0B?=
 =?us-ascii?Q?+JN7VIC5WWzghS6tmJ+RX9VCObfC4YYVLVjfUC5//11BGg+i+O5en4ctuOQ5?=
 =?us-ascii?Q?joqzaWeN7TlKPVvwNJusMflRQn1gGgtiFBCqvE/fItjCJFZYtw3YoLbL1kBt?=
 =?us-ascii?Q?UQB1c5wa4B/nDV4dBmZ4Q9a1siGc+phDJ015o27lUqJkrc2ywamLpAM3WNVp?=
 =?us-ascii?Q?AlTxP66xz2LqnOPLE0keiB9l6g6Vy8XyQI6INv6adgdh9EMD7P6271OCaYSb?=
 =?us-ascii?Q?ikOu2J4ndpUhkVf4MB0/Jtj05HtlUveNa7UhASoHaxLznhpoMiMDmrEWby3/?=
 =?us-ascii?Q?vgB43D9JM4YweiLOaO8VGEnOEZo+8PZ0dkK3/tQB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf84e17f-ad83-4f27-d166-08de0c808702
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 06:52:09.3454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKUpHXtY9TX709eKScXaETTgLhi9vb88Wu8403Jrfo4JO6lPDuXAY9Hobz4dVnjCc7/cPsToNhKs11EVkm0i1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5060
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 8, 2025 12:12 AM
> +
> +static inline int pt_iommu_new_table(struct pt_state *pts,
> +				     struct pt_write_attrs *attrs)
> +{
> +	struct pt_table_p *table_mem;
> +	phys_addr_t phys;
> +
> +	/* Given PA/VA/length can't be represented */
> +	if (unlikely(!pt_can_have_table(pts)))
> +		return -ENXIO;

PT_WARN_ON?

> +
> +/*
> + * Check that the items in a contiguous block are all empty. This will
> + * recursively check any tables in the block to validate they are empty =
and
> then
> + * free them through the gather.
> + */

the 1st sentence is redundant.

> +
> +	/* Descend to a child table */
> +	do {
> +		pts.type =3D pt_load_entry_raw(&pts);
> +
> +		if (pts.type !=3D PT_ENTRY_TABLE) {
> +			if (pts.type !=3D PT_ENTRY_EMPTY)
> +				return -EADDRINUSE;
> +			ret =3D pt_iommu_new_table(&pts, &map->attrs);
> +			if (ret) {
> +				/*
> +				 * Racing with another thread installing a
> table
> +				 */
> +				if (ret =3D=3D -EAGAIN)
> +					continue;
> +				return ret;
> +			}
> +		} else {
> +			pts.table_lower =3D pt_table_ptr(&pts);
> +		}
> +
> +		/*
> +		 * The already present table can possibly be shared with
> another
> +		 * concurrent map.
> +		 */
> +		if (map->leaf_level =3D=3D level - 1)
> +			ret =3D pt_descend(&pts, arg, __map_range_leaf);
> +		else
> +			ret =3D pt_descend(&pts, arg, __map_range);
> +		if (ret)
> +			return ret;
> +
> +		pts.index++;
> +		pt_index_to_va(&pts);
> +		if (pts.index >=3D pts.end_index)
> +			break;
> +		pts.type =3D pt_load_entry_raw(&pts);

redundant

> +static __always_inline int __do_map_single_page(struct pt_range *range,
> +						void *arg, unsigned int level,
> +						struct pt_table_p *table,
> +						pt_level_fn_t descend_fn)
> +{
> +	struct pt_state pts =3D pt_init(range, level, table);
> +	struct pt_iommu_map_args *map =3D arg;
> +
> +	pts.type =3D pt_load_single_entry(&pts);
> +	if (level =3D=3D 0) {
> +		if (pts.type !=3D PT_ENTRY_EMPTY)
> +			return -EADDRINUSE;
> +		pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT,
> +				      &map->attrs);
> +		map->oa +=3D PAGE_SIZE;
> +		return 0;
> +	}
> +	if (pts.type !=3D PT_ENTRY_TABLE)
> +		return -EAGAIN;

return -EADDRINUSE if PT_ENTRY_OA. No need to retry if no empty.

> +
> +/**
> + * map_pages() - Install translation for an IOVA range
> + * @domain: Domain to manipulate
> + * @iova: IO virtual address to start
> + * @paddr: Physical/Output address to start
> + * @pgsize: Length of each page
> + * @pgcount: Length of the range in pgsize units starting from @iova
> + * @prot: A bitmap of IOMMU_READ/WRITE/CACHE/NOEXEC/MMIO
> + * @gfp: GFP flags for any memory allocations
> + * @mapped: Total bytes successfully mapped
> + *
> + * The range starting at IOVA will have paddr installed into it. The cal=
ler
> + * must specify a valid pgsize and pgcount to segment the range into
> compatible
> + * blocks.
> + *
> + * On error the caller will probably want to invoke unmap on the range f=
rom
> iova
> + * up to the amount indicated by @mapped to return the table back to an
> + * unchanged state.
> + *
> + * Context: The caller must hold a write range lock that includes the wh=
ole
> + * range.
> + *
> + * Returns: -ERRNO on failure, 0 on success. The number of bytes of VA t=
hat
> were
> + * mapped are added to @mapped, @mapped is not zerod first.

hmm seems drivers are not consistent on this, e.g. Intel and several
others (virtio, rockchip. etc.) don't use addition. and there is no such
guidance from iommu.h.

Existing callers e.g. iommu_map_nosync() initializes mmaped to 0,
so this difference doesn't lead to observable problem so far. But it
may be good to unify drivers while at it.

> +
> +	/* Calculate target page size and level for the leaves */
> +	if (pt_has_system_page_size(common) && pgsize =3D=3D PAGE_SIZE &&
> +	    pgcount =3D=3D 1) {
> +		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
> +		if (log2_mod(iova | paddr, PAGE_SHIFT))
> +			return -ENXIO;
> +		map.leaf_pgsize_lg2 =3D PAGE_SHIFT;
> +		map.leaf_level =3D 0;
> +		single_page =3D true;
> +	} else {
> +		map.leaf_pgsize_lg2 =3D pt_compute_best_pgsize(
> +			pgsize_bitmap, range.va, range.last_va, paddr);
> +		if (!map.leaf_pgsize_lg2)
> +			return -ENXIO;
> +		map.leaf_level =3D
> +			pt_pgsz_lg2_to_level(common, map.leaf_pgsize_lg2);
> +	}
> +
> +	ret =3D check_map_range(iommu_table, &range, &map);
> +	if (ret)
> +		return ret;

single_page should aways pass the check then could skip it.

> +
> +	PT_WARN_ON(map.leaf_level > range.top_level);
> +
> +	do {
> +		if (single_page) {
> +			ret =3D pt_walk_range(&range, __map_single_page,
> &map);
> +			if (ret !=3D -EAGAIN)
> +				break;
> +		}
> +
> +		if (map.leaf_level =3D=3D range.top_level)
> +			ret =3D pt_walk_range(&range, __map_range_leaf,
> &map);
> +		else
> +			ret =3D pt_walk_range(&range, __map_range, &map);
> +	} while (false);

what is the point of do...while(false) compared to 'goto'?

>=20
> +/**
> + * struct pt_iommu_flush_ops - HW IOTLB cache flushing operations
> + *
> + * The IOMMU driver should implement these using
> container_of(iommu_table) to
> + * get to it's iommu_domain derived structure. All ops can be called in
> atomic
> + * contexts as they are buried under DMA API calls.
> + */
> +struct pt_iommu_flush_ops {

not sure it's appropriate to call it flush_ops. It's not purely about flush=
,
e.g. @change_top requires the driver to actually change the top.

and we already have helpers for purely flushing iotlb.

> +	/**
> +	 * @change_top: Update the top of table pointer
> +	 * @iommu_table: Table to operate on
> +	 * @top_paddr: New CPU physical address of the top pointer
> +	 * @top_level: IOMMU PT level of the new top
> +	 *
> +	 * Called under the get_top_lock() spinlock. The driver must update
> all
> +	 * HW references to this domain with a new top address and
> +	 * configuration. On return mappings placed in the new top must be
> +	 * reachable by the HW.
> +	 *
> +	 * top_level encodes the level in IOMMU PT format, level 0 is the
> +	 * smallest page size increasing from there. This has to be translated
> +	 * to any HW specific format. During this call the new top will not be
> +	 * visible to any other API.
> +	 *
> +	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
> +	 * enabled.
> +	 */
> +	void (*change_top)(struct pt_iommu *iommu_table, phys_addr_t
> top_paddr,
> +			   unsigned int top_level);
> +
> +	/**
> +	 * @get_top_lock: Return a lock to hold when changing the table top
> +	 * @iommu_table: Table to operate on
> +	 *

blank line

> +	 * page table from being stored in HW. The lock will be held prior
> +	 * to calling change_top() and released once the top is fully visible.
> +	 *
> +	 * Typically this would be a lock that protects the iommu_domain's
> +	 * attachment list.
> +	 *
> +	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
> +	 * enabled.
> +	 */
> +	spinlock_t *(*get_top_lock)(struct pt_iommu *iommu_table);
> +};
> +

