Return-Path: <linux-kselftest+bounces-33618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E60BAC1E45
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F7CA249E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 08:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90BD289830;
	Fri, 23 May 2025 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWIEj6SE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B886289344;
	Fri, 23 May 2025 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987665; cv=fail; b=H8LheroPvxxMJyW8RYMOAFnhNyFcDD3APqC3lua48VOjZ+IZGbtqvjdmDd3LPMiXEnBdSv2GfII8zjoqkqcqF9HjjmXcfW0uQLNsSqCUEmHCZ8mQG1UgcDweU0+HSY3jBlCsogabP8anMUWxK2Sy3reIHU6LIGLc9Cqsn0KWALg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987665; c=relaxed/simple;
	bh=10ozeeKineSX2SeCVYxiKhb705uLDHvFh4/JqEAQW8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OOpnJfcX6AHgZzznhFGtdE5pgSPu1i8Cn1ZXW7GOTbjwmGuKMlswbHakTli6yj2WhvO4VZ84shyf93d+6+ocMxw7hH++I1/WB4ZwIrUVeuhroyrN+IcAhx57icucYw40BXO62UAB1YV6av0L6MCxDnmII5Mp/5Q6WJqFYjPpWYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWIEj6SE; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747987664; x=1779523664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=10ozeeKineSX2SeCVYxiKhb705uLDHvFh4/JqEAQW8U=;
  b=dWIEj6SEyotYGGL7Sk0J+xAvYGUarbfB6qowR9pgyFIOzB+Nc4DH8k9a
   YmTBwQjOFnZjrIlSsW65bcRBFZHOPFl5BwwQGjSj/6mSjg3E9vJhYTooc
   9iQhRXym6f/67luDwMAwHPh2Goz1QchuC5hJRfTrVx3YCf8t1Ff1T/3vQ
   MwhkP5rrbxV09sltfNqCXvFWNMRBlfKyGye0iHcKvgjqtfuVuHnfw+Rxj
   3e3tQin4HQsVWcFfLG1CvDruFiOZJXgN/CZ3m+QIgW1j6nDI2yccCkYoR
   7BZV7DpX50xCW+TVmZq44hrvUrAuIA3KfOCwHlo104UszTib3tCs2npvU
   A==;
X-CSE-ConnectionGUID: Of9kLyfIQaOeI27ijqcVIw==
X-CSE-MsgGUID: dAL4MOq3RH+v9KhP+IUhPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49151363"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="49151363"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 01:07:42 -0700
X-CSE-ConnectionGUID: o7qtJqE2Rhy7gE2HqblHyA==
X-CSE-MsgGUID: +TdAZxOSSg+qemeCjDL6ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="141456963"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 01:07:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 01:07:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 01:07:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.60) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 01:07:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klRmOL3fkU25ZCW807QaAn4rlWSOz3sgfUCq1NbpoGwG/jR5/+b0N81ai6hES8OPIv6anLFxI8l7Upxr/PpLI2iko4oIPrJSvhHWK9PE0kO41ms+HFabKy2qpa7KLA6cUjn3bgGzL+mIeAb5u1QuZ/sl+SeBHlwsmH+mKSnTkSO2rv5tUYa6GmP2LnrqwYwawvoms0/21sbamzD1+Bk+TQJFvwiCNXK68dBfj9B0lbBcAwPe2SlzoFZkbTbKMvtUWdXfpRJnmS6WdTE+I+FuzRxftJx8j/6rNG7cBkLWCgXllHwebBtRGwtv/AV/Z/sJvYw1/FR3hMp0Ujml/etvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10ozeeKineSX2SeCVYxiKhb705uLDHvFh4/JqEAQW8U=;
 b=amCprlIJJAoGQqbWPiMiXcyoZHCnbiesIJJ42apSiqp4eV5g3z4pBwQSZSs8OM3QYGwyn+sGn5b9iX6QdzviVmq+6/EIegbjtGUdXf/Iwc3yOd1fZcAX0DZHynCRBYCxtvwEtBxmwv+zK0QH04mEsAKDhxppc8v8ZbtVSiSxbzeIFGHOP4DwAdGz2TdlHJ/azNvTZFvYIfzYFckCz4id/xLWbBNPOhCuXwWD8Ecf+SpjU/l/yjAzj+Hx5qCHekhnT88pkF0K9AmZGdnXSqRgQDRSskeibZykRonZo0XZnaXCe+0msNsqo2i+LL75LtX4b0DU2IN8qv7cVei2mz5JMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6414.namprd11.prod.outlook.com (2603:10b6:930:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 08:06:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 08:06:54 +0000
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
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v5 21/29] iommufd: Allow an input data_type via
 iommu_hw_info
Thread-Topic: [PATCH v5 21/29] iommufd: Allow an input data_type via
 iommu_hw_info
Thread-Index: AQHbx6Qou/L5JxbCF0Wl5qJ/he9J6LPf4+yA
Date: Fri, 23 May 2025 08:06:54 +0000
Message-ID: <BN9PR11MB5276909836BDADF0F36005AB8C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <a5781101aea86e223ab23e88062a82c95ee3c411.1747537752.git.nicolinc@nvidia.com>
In-Reply-To: <a5781101aea86e223ab23e88062a82c95ee3c411.1747537752.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6414:EE_
x-ms-office365-filtering-correlation-id: 7aca595f-1a15-4475-d9e2-08dd99d0c848
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?sqBxd01YN3KDgyDG4n1MdBEl2TYdXb0qfpm0dW3Oa2kRjbdtxPpk5mcfLEws?=
 =?us-ascii?Q?vxq1BtQIowwwhpSkIp1uqf/23V1OBIRXVh/P5wD7PzN3FHAE0nfU7uNTUxr/?=
 =?us-ascii?Q?VP6ssSeqkfl0NJzXgOxcv2R8UrqvNzxedDH/ojEzAHQupVtc8lDAqQUWhASE?=
 =?us-ascii?Q?Udkg1JkErwcb8qn6kl+kcBpm0k3+K8lF7ky2Kh4VIfrGwMBVac61AWWC7erU?=
 =?us-ascii?Q?8DIvMhEagUJ1HxVazQ8hLTUrOjgWqE/HVFWnpBlv/yV1pDgLtZ8pkMuhornl?=
 =?us-ascii?Q?h5EX9THdls9IApjl60kQwtLCCfxT6BbGKssJ3nHcSy7wA6QnE6ciwBjZyaNK?=
 =?us-ascii?Q?NikR5ujG4pfql5fZageOeNiLeo7qIQM/ZUzE0+QajLBbE6nUAqC64NlwXP17?=
 =?us-ascii?Q?eIhVvjsW3bbTofZKRSO9++XWsZK8n1u/IqQ+qkVtKt5HqYlPZaLNev9/QtTo?=
 =?us-ascii?Q?XbGP2qYWSAccDafe2thJkIbpCwxdVz3zwYxssQ597R6LZSJaVG0O8aKarY+t?=
 =?us-ascii?Q?bazBaCIVKNfWVJz48juPuM05Vpk2xtg6I0j12J853AI6jt6YinuIvluc4nbW?=
 =?us-ascii?Q?TbC5Rm/Ft4syMt3XDQnALEMguXCDI7GL64IwsCuVdEMATZRmHJni3ksvS2IR?=
 =?us-ascii?Q?CFtodXPCg23gKsoWtWvt0q5u9Gw+AogPvNgJ0Xc8fpfvB4s6PZuU/OEHo0d4?=
 =?us-ascii?Q?XBA6D8hsTKBe70yVbjgnRcPL2WGnd9DBcuePD1tmh7drLNJ0XwVFqKRqu2rg?=
 =?us-ascii?Q?q5arBDdvTpiphZTOnGHZm+UOrbj62PMDO2ja+Glt2l7oay9LutfzDqeEHv8f?=
 =?us-ascii?Q?MDfMpj3ZJQs4qzj7MdAmUjWU2Km10EtgdMS1dpDeyrdjJ0Gl/hNflyDIyftz?=
 =?us-ascii?Q?goeNA7g9RsrMV1qEGD/EmxVXFX/DedcsnchTwtahwSZgVT4M3Nv5/yZV6KRB?=
 =?us-ascii?Q?00QPaP2jEZs0EH1p3hgEcWsjfvrkwsozYRZf62qpHKkHAYhHyXWgsdIcIcG7?=
 =?us-ascii?Q?myAS7F8Lwa32+HApHy0ucepzrzVfisr2qiHtSF4QLlOoX0XIXkuLN3JzH6ai?=
 =?us-ascii?Q?s+z8Hge0z2JXYN43ReDZNqDVhi/BFr6cpHyZ4t5nC+OenK2mNDoZ4Vm8t0U/?=
 =?us-ascii?Q?o91MayvFKEg/UP0qjDP5wDglRUWIwXPCC4qo9yAYHnE5d9fat2z+HlAaj4DF?=
 =?us-ascii?Q?PzUXiqr/SWW038XRa2Q6SVscG0akht5Mev3kZn5U+A9aTyabnuWJ3MkuMbx+?=
 =?us-ascii?Q?AcdqFT6a6+Y3pHAbNe/xuJ2Wdwm0iro7aqfKTHiZq3fyrL2R8yssFErU083j?=
 =?us-ascii?Q?42/kJCLmYwdiPTrhaRHZZ7k+ULp3rCvg2/9Ow4BHqpaO86GOJhgje8QXVmae?=
 =?us-ascii?Q?iYPJW7hVdyRr3YsRMZ4MwdMknC2L76OE7MMhJZksf40GtrZL+t/vVcGQKNhW?=
 =?us-ascii?Q?xS6DW2fQRyPt+6VjZBwm6575gtnwXKNLJ/8SUw3rnpRp4/U10cbHJw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vBKQ8XiyGjx88wFNLPBTzchPsjO0Sn8TEXNBmuD8meYWjeMBMIqCgrehGZCX?=
 =?us-ascii?Q?3midIwvS/v7Db/hnQIC71Fq9Mb1OJXo7nPAIf8HTWOWxT6LKmodLcDebIeXk?=
 =?us-ascii?Q?aDbi6aXLUpW2Kw12IOEQOYDSpl8w8KY12bQqYu/dxaDPCaXmUAt27cTFONiG?=
 =?us-ascii?Q?k1bf7ryhzh55F3TxgZKF33id5cJ50u8uQUCd+L8ksVcDWIscT0dZWg/UXE3s?=
 =?us-ascii?Q?cyVBfcGOA+37/6+RUUOm7Hw4IlJ/upr+dR5belUYpi80b+OfYWCOHDNYt8FG?=
 =?us-ascii?Q?kemDJnlJHLQLXCxB4UbPVTDkMa6n70d3UshoZc6hEHZAMAdbek4Zp0VFdg0r?=
 =?us-ascii?Q?YcJ6Lqpf8bKZCHUyCQ229S8zqW5SwgvIAvYBkUguKX1u4zZ50Il8CzNFmbRh?=
 =?us-ascii?Q?ozCL2jWE/sB0gwA0LylJG4vDuKIlVBqOjH8nc8A8XNjkbhOWvC9hwPCbiLjG?=
 =?us-ascii?Q?oj8agosiJNnnOMbYt+oVu+QOQIuZ6R00i3OpKxsyg7UW59K/35AQfgbhGhYM?=
 =?us-ascii?Q?it24J3bdv0qACwTaocnz6GLejmkfq8RaxKYwYRA2aV38mnlhthijQU+QFtU9?=
 =?us-ascii?Q?jxFkKnAkSP+f20FCKPKggWM45yAx+/0JtaH/tt2UuxvNDnwNQjy4me6S7N05?=
 =?us-ascii?Q?eFo1pPdHR7bR3kI9CyxFixRDh8mVhmM/PNgU+1ZSP5vPUgF0vTSG7G0oF101?=
 =?us-ascii?Q?nZcZhY7Qe2DiBq1FuDpA4f8JQikbgDTFknNuJN5zh6mqmFyT2U5w1Gq6WgBD?=
 =?us-ascii?Q?MImzKT+GYleSKuEbWweOEzvrNef/pm7UGYS9OhZQZMVqm9fqb//7WRAxS9ZF?=
 =?us-ascii?Q?5qjdRR2YdmOJx4gFrCv4eZ7LrJAotUqgQWRzn/YhwbJ8SHQCrZ4VF3ZT5pE8?=
 =?us-ascii?Q?Ont8OIfcBj0Dxay/mz3cb4P6S7qDusxYb6c+f9sEpwKWLXx93eRRnUXH3fw1?=
 =?us-ascii?Q?yzASkupWsKSt+RwGOYoJx9oHVjTIk3Wh6zN8fcHVXJJPu5QobhrJ4kf3UxTc?=
 =?us-ascii?Q?WOAk6jR8a7lu/4Dr2BqLRPgB2AHs8XvA5qJeE3EUL8+L6/MHjGNQWIE2hkCJ?=
 =?us-ascii?Q?v3mAngI05m1KRY7ArmFIVolTqxpkEPsTkhJOiMdJwZvDL0FC4QXG+vqvBTlM?=
 =?us-ascii?Q?xIr8Jxy7oE7yNI+lpxup0q+FS7WlwzF7NoJ6E9hZjTFjIhrvqhRodXDo7kIa?=
 =?us-ascii?Q?Y+HXGRHolYypKpwCeGJZgtWkNkenMNkpRdt1+u71IdoHO9ACxMi1BJhiYeeU?=
 =?us-ascii?Q?6NCFGRSARsemuyu0/HQWOwRuFCuFDDN+7f2xBfL6xARWfyiZEVFlKEzbdx6t?=
 =?us-ascii?Q?cEEC8nDBgchXk8sWiycVrX4ZHKSjQz8ms551FOJ+l44aDZidzP36Qw56gyOE?=
 =?us-ascii?Q?1Ioe1ImXGJ0DIeSd9HreCkMqEY3A80wJEXBpCXkHwaifp620S5+6sLrpGzZA?=
 =?us-ascii?Q?glXVwSUCfqqot+G9Jn/239D40zh28Kiv55cqXn5gkIEcppDqwomXZbZ9vL3U?=
 =?us-ascii?Q?mfJr4rs2Ytjzl5ZziWr9Du+M/gUb2pMNSgLS9Tgh9rnUpvuqGd4Z01p7jGPC?=
 =?us-ascii?Q?difPr4xn501cAZ5d3RSXo2xZxZ2fyXcx5bT6NFnp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aca595f-1a15-4475-d9e2-08dd99d0c848
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 08:06:54.8923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyVHwwMjezYueWf2MIC+DGxlfptlcVjX5YXkqoLEeTMiU/SaK+delNfsYc30HKvCeGc0TS3dCZZx0vwQXPLNRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6414
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, May 18, 2025 11:22 AM
>=20
> The iommu_hw_info can output via the out_data_type field the vendor data
> type from a driver, but this only allows driver to report one data type.
>=20
> Now, with SMMUv3 having a Tegra241 CMDQV implementation, it has two
> sets
> of types and data structs to report.
>=20
> One way to support that is to use the same type field bidirectionally.
>=20
> Rename "out_data_type" to simply "data_type", to allow an input for user
> space to request for a specific type and to get the corresponding data.
>=20
> For backward compatibility, since the ioctl handler has never checked an
> input value, add a new IOMMU_HW_INFO_FLAG_INPUT_TYPE to switch
> between
> the old output-only field and the new bidirectional field.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

