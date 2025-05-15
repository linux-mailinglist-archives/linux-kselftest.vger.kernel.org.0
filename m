Return-Path: <linux-kselftest+bounces-33029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0694DAB7D4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9851BA0E60
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0353295517;
	Thu, 15 May 2025 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQiMUZkV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FDC293759;
	Thu, 15 May 2025 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288198; cv=fail; b=STp6xJoYnwvK7ICA0eaucNoVBHzDOZ+Rr6TmYmkBzFU4+tWrCL7o08CndHTZr/2IVYS9MjHXxUYDa4Iw96jTrMjwoqQAA7wFknRnpxs7VGisTdf/J+x45GWl396o3tGNNfjbXjCfj9bgJBCakmFXZdnAd/gyeUsK3fYGi8kE+Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288198; c=relaxed/simple;
	bh=U+P0xXhsNzFGRKCTXipDkKUYqcaUw8uEr3Icwwh/fPs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SleLQDz6xS8N17w4ZIX1kXKy2tixh/unrnOQZOK/eNHg/UUrvi4SBd5sExoZZnln0ohpSfz1Dzd780eQzozI4dxuT70Cg9sg0pYRSEX3eg7p3UhdGQCaICnIq+p6dCny77zPDgYJVwqpDWZ7UlMbyw/9wniiQQ1iY+BUdC35ycI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQiMUZkV; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747288196; x=1778824196;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U+P0xXhsNzFGRKCTXipDkKUYqcaUw8uEr3Icwwh/fPs=;
  b=eQiMUZkVckidwwKP5CtzVayMzkA074JuQa8p29G1YQzooM44RSXP2ekt
   BDRwMt9nRmdeVdd57vkkJF/Jqjga5zj8r0kAoFYAFomVWphY0LgAvFsCf
   OSe94Nn1NpcwA3HM1MSzTju1SfTMsMWWR9co86NyuJuTghoxSaymItZEw
   vWm4T+rqGsHRIfjzmenMqUrZDvQBpTY9SxR5PT8C9Fy+VRKym6KReQ0/7
   boYVTm5SmTxMJeWNEdU/UHIsiu/d5/m6m/4klMykf+hzkJzK7pPfQW1fm
   sW50+A5pYvGRTnt4qE2KhBMWweNoTFZYroRsmwd5PKPNFWuvGzRIRufAo
   g==;
X-CSE-ConnectionGUID: JkbYptoGR2mAVQzyOQl3mw==
X-CSE-MsgGUID: Ueugph5aS+yu47D+rz3lHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59438727"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="59438727"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:49:55 -0700
X-CSE-ConnectionGUID: MtvOKRbRQ8GUuNpqEavyvA==
X-CSE-MsgGUID: +w2oDhrSRfOEsQgvvAIk2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="139257028"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:49:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 22:49:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 22:49:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 22:49:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEPf05NW0qJX/e60/AWXq1zdgxp/XQyZyHkjvwPDNlCTp2v2HE4UyhrrygQG7Z7j+OBsNQXeK8x8dZILQSgZA6P7Ts9bNosyxqExNKBKIadt/QCqF1datCZOepxUjlEZe/mJA9A8VCt86Dx4wiKR1tDJKZonk1p1MtjigU8KJ2j9HbTb/XgYinNmdlK+05fs//9jsytqPe4n1cf+zNNBjTh4yH1+EYWGrHh3hMsZi54ETz3BIbJMvboaPU8cqeBHsHTdT9RIdjivY0+9wkJ+iUg//32mFNDyoRbx/o2DPnWcDY6cR5T4L76YxxTNJc128YAdF04mIb8S09qcrKq/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+P0xXhsNzFGRKCTXipDkKUYqcaUw8uEr3Icwwh/fPs=;
 b=T954CEUyLy3D7plJ1k3dNsfZV8srG6Xg5njkuQ7H/BG67LxbctmPfsuXPu7+XhEIB6QkaedTeE9w3y5vab2BTDQTdQTKL5n+DReccSexApGvwMT9oMoKjt8Zx+ZHzc8WiA7UKD/vdDXiZMa3NDTXIKJcibZ41buL4sZc0ycFOz2K2vDZEutiKZuvilC3kiEC54jXKdmBsa3btdMDdbgKnMCeXBOmOnArwUBLtfZpWVUeZH3DmlYZ49PSywAnobgmCWsh72/pRrIVaAYVu26Op8vO/Ro/67XfdVeuBT01mwSJqhfURDduwNWYex89kJgxvHUZ496cI8dorMQGM/aQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Thu, 15 May
 2025 05:49:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 05:49:46 +0000
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
Subject: RE: [PATCH v4 07/23] iommufd/selftest: Support user_data in
 mock_viommu_alloc
Thread-Topic: [PATCH v4 07/23] iommufd/selftest: Support user_data in
 mock_viommu_alloc
Thread-Index: AQHbwI76/SA/GLQpNk6wlBFDajF7vbPTOP4Q
Date: Thu, 15 May 2025 05:49:46 +0000
Message-ID: <BN9PR11MB527687726B07997D4CFA34B78C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <7cc29f0d3617f464c108f730a3f611d1154e8cbf.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <7cc29f0d3617f464c108f730a3f611d1154e8cbf.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB5872:EE_
x-ms-office365-filtering-correlation-id: 577c5bf1-7f33-45b2-d11f-08dd93744c4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YWHUcjkudH/70RYjiCnS/NDCGmR6iBlxQ/w/cXV8VJdqhBiG/xyiZMK6lBxB?=
 =?us-ascii?Q?Wjly2HeSp31WAXRTO7DKcNJepFNfxtJTX00QcJUbhyp+2vZ1fzyGCKWR6I7O?=
 =?us-ascii?Q?4gD/qtoaNs1n2mOSoKxfp8+WneHlUwgs+UvNT4tQ2wqH8HLx7qgBHyQYBcZ6?=
 =?us-ascii?Q?9HWNGeSAgzFE2yYSNaD+2CSJFvQRWzFfMTH+45SV7AJzTPyJpB5hV7FMpKcr?=
 =?us-ascii?Q?5X+zOB+fq4YZwjkxcc0ImE/JC0rywRULY+oB/fd+d1HY2U+tbPqulUH5aBAM?=
 =?us-ascii?Q?b3Y4Ag5EdFypak+dwfPMcN9cKuqgDV2ByT4y+qMcAKgqJt0euPlka4BdzlB5?=
 =?us-ascii?Q?yuOLyBjyvGwbsjXBTZ1c32DXLc3xSRmqus9V2oB0OdJ5SWYkMZX/uoBCGhMP?=
 =?us-ascii?Q?vjiRb2RI/Spx3udGPpxJcQJDUTTgK+MPmYycl0SyRrKS9fmEAWKNuhSah1ac?=
 =?us-ascii?Q?Nbdq3m/cOCmJpFrxfpxZIclY2hv72MURF9a7S0BkvWQHayE+kmphYUjzKvHm?=
 =?us-ascii?Q?dzncpLMI7jtBa+geoUMC4/7oAfeeL9luh9lAdKsfiP1s6gNiO72ZAGoOF6cz?=
 =?us-ascii?Q?vSIrgCydIxi6ovpNqTwMA9dEQl0AS3+/lQE5Nw4wA2UjgE2/EVYXrcW2rmij?=
 =?us-ascii?Q?DxurPxsFT0g1XR9QqDzP0zC1Bb7gfcxNszByBb23+X+Xba1VJtBCuByty8eZ?=
 =?us-ascii?Q?R939/BpTMpijXmX4HhvI22XHJvABGSJX4+++PRK6Qp2HN/hjoOBSBUzGR4Zx?=
 =?us-ascii?Q?SQpHRf6ySG5v2b/1Szm38diDe9kNTsjfw6/hpn6W1Zw9M0AF3wGbgUsOPti2?=
 =?us-ascii?Q?9Z6MSLkiW9Rm7TZNAROqy0zfa1sxDS8fOhDSdAkNmwSLO+dUA6BMeaHXEKAh?=
 =?us-ascii?Q?QwllHpdGIKKplGzFuwDg/Kr2TkZhVCesOE5dO1hiFGygxWQjve6vsnLBQf+h?=
 =?us-ascii?Q?8iebz9GAILWfKKeEhku3m6VTSCut/L5NDMufiq0iFtW+WErvN+9JeX8cDUa4?=
 =?us-ascii?Q?8K8dgMXZZc7pjAVvw3mBWuctC7pjITcrRAg4RvMXuX7hkEVgHXxjGQIqYJYc?=
 =?us-ascii?Q?mXoKyoqVJDkvdXOnrPXhBdoSRvcd1jvUb0YlDFVirIEOe4aqMb2RiBSlo0IP?=
 =?us-ascii?Q?jtFecJqaRZStMr7/Or6bizeDtbxufEjze1ihRV/CxvoszCovxcC6MNOur1Zj?=
 =?us-ascii?Q?takBZ88HsfWyugHeoXL4VssKyMrNFPpbNjubfnZSBdQtgHlB1PE5Q6eHwNFA?=
 =?us-ascii?Q?84KFLY/5V1J2kUC3+vJSaUth8ne8duW0WEokK1WqnWsHhBPKvHvZPMn0vkmX?=
 =?us-ascii?Q?H54k7bIjNFN+ZLVpwKAX930G/haid3N6/A+KBNN/JXkX44UGsmztkli7iQXQ?=
 =?us-ascii?Q?Xt0Dn23BRFdGh47CG/uDxOOMy8tTv5fl+h9Ll56bqUJ1DYxbHfbnk3qx/28y?=
 =?us-ascii?Q?KzkuKxTm1wbdBbI+wtsAOyAGpC0rmJ9cXw+u2J8QpVXb/D+aJs/EVjw8yPxk?=
 =?us-ascii?Q?aqcZZxE5Lvy3Vyg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8CXoT7b1fV2BmHxFQpG8EfhfLDtxFGoSZUroFht/HKB4OZYqnYRaZlTBg9Np?=
 =?us-ascii?Q?VtLK6STARPo0GXlzKo7DpglXtGlVli2kigZTzVh/r0PlsokPHjQWlHyxmF+t?=
 =?us-ascii?Q?xqzGcoqADsLFFqnxI/ksCDLfiDVI4gKB0ekmTES46AQexa89jK3TCj0yw9fk?=
 =?us-ascii?Q?RrijJsRveC8l9zrfpDMTvdNERvjmRF277GMknXqQrsqGpyKWkQc6gCvdalXM?=
 =?us-ascii?Q?7BL3WSEE+i2M2fBssKJuBWoCY4RH2BgGDWgk1wR46Yt2QZuvjqQIohWO6X2C?=
 =?us-ascii?Q?W/00jtLJ3XryQVnorQ4KZdXyH3faiqXQ4mbVLbk9v/u2YkWPpoaBsFUGqXEU?=
 =?us-ascii?Q?NREjKe/GOfUBTc9SPE94oyAVIpBCPojU/m9BMpggcXxlh8N7CMqDQVqqbKQ5?=
 =?us-ascii?Q?hN3ZnDCO15OGD6xMAzxwrbs83lV4/ps8WEy8dg5ElVFvSH6ZDM2bMGAI/y5e?=
 =?us-ascii?Q?3nAkHD0KI59UN355QADVVZwwYZ9NVf7p8XtRobT4XcbCzMjvepCPHpAUZqLV?=
 =?us-ascii?Q?UGkCZez+jqdHvebsyVAE12ae8eMFYOYaS+8jV/2Ow9Ptk0cO+LjI/n9xkjn/?=
 =?us-ascii?Q?mz2rPiuWOAIQYfCydnvf705vN/TUnBP3t7pVpxA5XxqRY5EjprCT0aAGxWDr?=
 =?us-ascii?Q?4nDsCjTaRVojyCa/u8lLbRswukk3afDwbBj92s6joqUZOWkze7DsIXo8YVvU?=
 =?us-ascii?Q?0g7LhCZPWjX/rWjXyOYeMBOpp8rZWwFwQYTr7jHiQb7vK9KvzYk/KBBXwIXo?=
 =?us-ascii?Q?M4ZIueTkm8PTiSRJ3KEhHnSYlqCU2QVT8Y9azgO5wuiXURUTyyF/bsH5cLnR?=
 =?us-ascii?Q?oTDLEVOmsuZvUIadXYqofEu1W302OLlXtjdwcn0wBf7qssrSCHcG3yLETOY5?=
 =?us-ascii?Q?u/MVLKocwixT04gg2oKyqVbDbrEqjqRGYWIGu9gS+omn+PRkII8fkuVCUL1i?=
 =?us-ascii?Q?AFP7BT4P9LgEsE+kM5o8WxgIOXMq5CdDWFLsq1V+rJaqnlQd63D7Jkh4iEXG?=
 =?us-ascii?Q?57giCKpL2gryFcfUZM/5M8qYeyzyfkGVavEpL5ThCtPkM3KW5R0ykJ3UA/sT?=
 =?us-ascii?Q?t7z58wwdG5slUJmHECQATyUQeKEiq9IqcJ0ycHm85rWH4biPnW9YTxGNnWIg?=
 =?us-ascii?Q?6nY0KeCa6XsjF8n6DzaYpMj00F+0O/+yTvizaZuyEKI4wmZxlm9+8Dvi7V8n?=
 =?us-ascii?Q?0vyImB3VYN/svK8SpJemCI+3W89NUF/kG55UgM5TvXxEb4WewfOzBUxv6bdP?=
 =?us-ascii?Q?f2B1J/SUPkf5zjSZIbXrrybiuQGfRdpYGYO9uZmF2+L7pPJCkKDukJ3bay/q?=
 =?us-ascii?Q?/vxNqIB5jey+KbQc4TtwhEpPsqXZGZdODOSW0Ptl6l1E9SDklt7vuyn5mhbt?=
 =?us-ascii?Q?l0WvoKlauoNiR5247qiyEw0rG3uuywijxiAPQqMkF6cp9Fg60HsKFrOaI6u2?=
 =?us-ascii?Q?1TBgl+jVZPgtPGqU9mAdTuDlQlSrm1loIe/5HTxts7UFgSGBkn0CJ2sKqkgt?=
 =?us-ascii?Q?vLnZmmG4N9gMp5zm4/JPaKk0plstCg8pmmoUkkDYkFM0SHT0s9LyjwHGYzNN?=
 =?us-ascii?Q?1iydCil6iI6IRaYLdQAOwxDSU+YfnSAH4nPmY2mC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 577c5bf1-7f33-45b2-d11f-08dd93744c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 05:49:46.1595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/qRnig9Pg1SgXMD5lLUJ2+5XrAePv7z9GKcjYR1rsl9pjPgcyi2q5iLmXjZkQBUeBbMLkHgKP1VillRXTc8Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:02 AM
>=20
> Add a simple user_data for an input-to-output loopback test.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

