Return-Path: <linux-kselftest+bounces-20911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC03D9B4471
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA831F23EAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E7D20493B;
	Tue, 29 Oct 2024 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZIaIRr9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C520492D;
	Tue, 29 Oct 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191332; cv=fail; b=A2GUKx5YvTMp1KKX1RwVeouiAG1SIaqrY9KclLrzI92F55J2rjIg3KntixAdx18it89CyajprI25Ovsqs3zzZyi1QOMFo1OnoK7c/A3fZ2aLqwEWbWcfjUG48+i8riiUlH5lULpsmGP5tBFY6n+kIM9AqVTQXFB8tAhWrykWU78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191332; c=relaxed/simple;
	bh=ieaRjjjo/K4QLmr+6PTNYVTSUtbgThT2KnhcAsSFAmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VZRq1NkFkWbf6T7RWsOJKpn6nrCIpYQVr7Z+CZOWrCiElVj8bABV6VTM94GKBFKdQqORPbntamaf9uyV8RIYs7fUSdYKP02rXfUC5aMqNxT4yNckNX42KpOLioBd0Basdlxq9Imvq9awxMqYLtTUv910cSN8ZPohn0hav9pFFn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZIaIRr9; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730191331; x=1761727331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ieaRjjjo/K4QLmr+6PTNYVTSUtbgThT2KnhcAsSFAmY=;
  b=BZIaIRr9gHoGzJQm8L4JgN0f/EtauJKJ61McLe4e8gl3lm6xcCWbBj8o
   /k+sKC2bZkI+KuGxsQtE6GJr3XgeCybCAs2JkwtPR7IpCgmKBD/PJsinz
   vWdjkpcWzl82QJWFytgNgf01+sBIg4dw/4pWEqRsWR/K8vZapQjzC94r8
   uz0duowkf4qq8skcuYEr3ZwD32dokvmRx5O9LfbxuNwpNLtNcwaUbNLUD
   3zVMT5rxYQm9fiO17yiYAyzv8bjMvkGPEQwGOLSdn4Kj12ax7gOTrWLLT
   kb79Rn0TTyXbQmVgcNq7+wFnwJN8rkSgvjFEbmgqD8lqxYFTJnLx9ygjj
   Q==;
X-CSE-ConnectionGUID: b0ly5mCTR6i5HOL2uYDYGw==
X-CSE-MsgGUID: T6yFy8KUSvi1ndkiqOwwGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41179580"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="41179580"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:42:10 -0700
X-CSE-ConnectionGUID: dpLKi0NyS7+r0riVJty4ow==
X-CSE-MsgGUID: to8X29zbQiiQcs4woPl9Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82216790"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 01:42:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 01:42:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 01:42:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 01:42:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsmSTNfRQi0u+dWr0NfkxJyav4xmURmDCzRFJ+KB2nWgeipwsf6m+EL7b1zf356ce6vuTHOelXhDIq7C640R56k8gKQkvRJitwBYLrHu3J7vqCube3ordc/kuktDCExSAVMMr4PtWuHVod63SNJs/je+rdB1RRkh4ZlNWTclRtQ6qbZE+U4NQmEmLXkHAGOwKqR78CAmkNP9kTxDNZf6Ttwvdk/EmMF/60QQw+MJyGn/gkZala7Vu5AJxeqx/Pv2z1fn1lxgCunDf5+voLhsHpkucL18dar8t2KU9yQipsQ1eQNKYd5cXA4ucyhj79sHZSuHvyOR/WaQpgbsEVi+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieaRjjjo/K4QLmr+6PTNYVTSUtbgThT2KnhcAsSFAmY=;
 b=sRr8PicI6YkCD/ZlogqERkO/33JYsyApMsZOrzBefSGFKtWSKF984kIhOisowQmZq7hMunL2zl0WndubTxyzgP0r/BS8Za2ZBlHUyb/MrqgyrZLCw1A0VNqrqkv4niDFmYPvJcwhLkcuTahKWHqEpQmVLRd95qjY86Gr5fKDwbNkjE6kWaYGx+IS47bNyBUfEXSWNJB/tT93HOP2p2jbitYqzESO+6X5NwCz9Zncb6x8Mg/+DyIi+JhlTiO/1looW02rD34Wwo4YkkORY717PdhkjRJPfK/cp4D4x3gQRgeTY0Isfr0fb1k5SpexPfQPUWzc9Rtc/O2oSE2/wxIxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM4PR11MB7376.namprd11.prod.outlook.com (2603:10b6:8:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 08:42:02 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 08:42:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 12/13] iommu/arm-smmu-v3: Add
 arm_vsmmu_cache_invalidate
Thread-Topic: [PATCH v5 12/13] iommu/arm-smmu-v3: Add
 arm_vsmmu_cache_invalidate
Thread-Index: AQHbJzjQMTZDZgrcTkiT7HaarLaWd7KdbjIA
Date: Tue, 29 Oct 2024 08:42:02 +0000
Message-ID: <BL1PR11MB52712FC3C5F8B3BDA085F52B8C4B2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <16cb47d80cfd37028f6d32231a785a3c486239f5.1729897278.git.nicolinc@nvidia.com>
In-Reply-To: <16cb47d80cfd37028f6d32231a785a3c486239f5.1729897278.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DM4PR11MB7376:EE_
x-ms-office365-filtering-correlation-id: 70e41c95-feb7-4135-f289-08dcf7f58f35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?U4zf0OzJ+00aQhzR22FdZ0Q0L1xTylRzTGlcPswBOj6JYnd2O2a66vI9sN3Q?=
 =?us-ascii?Q?vd4itbOpchqhRo3m94KjpBK6S6FWReD5OlTY/zSXXbYl6m6ikW/zmG/l+a1f?=
 =?us-ascii?Q?zaGNRbie+HDN5oH4js94Um+xDt7TkMFyGcb9GE8qR/Sd9tZJZaBBZh0lqmtf?=
 =?us-ascii?Q?McdMCMiW09lwqRs6QKZzo5IykMARJ0lxMeNs6MzpttcyTx72zeU5lDTQt96z?=
 =?us-ascii?Q?pzPYLiofJzWl/zb32dH+u5l9Ladj3bGL0+K673HgG1a+TP+MJqVs0pz/mI3s?=
 =?us-ascii?Q?xn7EzJkrT8mXl4/eO/GH6Qor4DqIIZKckEq9uBOd4urckoaseREGxu01/Kni?=
 =?us-ascii?Q?STC1CPe28gzlPAdE0xy+GQrERaa9mM1ywxywMULJ2Jt0G+idBCGYCj0bfBHN?=
 =?us-ascii?Q?eJT9RoF+SlwbFO/Mfy2O2aCTGUwywA49ur2NL0RFDIa2I9zm0sopFhArQMZF?=
 =?us-ascii?Q?J27lfeTC5EKyxoEycTMnSFA+7OldWHkAgrZ7X6n6t6IrNQs5LHt2SCVuqEnW?=
 =?us-ascii?Q?/U/rrq+1JZE/L0egTapQYdO+9tIUcwu6rDL2ATt+I6GEEh7I6SakJRfqEa+a?=
 =?us-ascii?Q?SLE1nCRSzG+4oG0xSJX4msnSBa2mblyAbPWtqxzkTs7BljZnxVLBRl59NYcS?=
 =?us-ascii?Q?2zVWhkrNr2UoMTceN9rQW7k3JVfkI5IbWuasQLIdDv0JNy8Uha4PgxFAENY3?=
 =?us-ascii?Q?qbcovJ45CXzs/gm7OWFcyjK5+5DuC8mL1KSVKJtTJBf6rhNYekAfQWDiGd62?=
 =?us-ascii?Q?LK7zOcpCyHhPRRGOQCpQd3F/Z3ucphkGd6Ox/LaNQqr/D3LpioOEGtjHu+DG?=
 =?us-ascii?Q?CzHWiRZGOzGBOlLlHi3xmSZNzu8a5Q+1N8sHWZ1AXuH46woHxJAXisRLxuBe?=
 =?us-ascii?Q?2UZLWhaO9a3nYBOlzXZsbfZUpXO7CKmiGua6ezXET00Uyt611yRAICbQ8Ioi?=
 =?us-ascii?Q?cKnm7bjtXHn2Nt47afAIymnTgODq1imHA+9//EICCE/iRDjT/wJCv4jIjWvG?=
 =?us-ascii?Q?7jCevBIfsq16pSVu+UmbgwZ3MSyOMm542ZGb99IIlE2RUEE8B/dnwle9Omr1?=
 =?us-ascii?Q?FNAyus6QF0wIk8e02CL8gy6uUEhn/9x/i8k0dzPJ/x3A0N2YmlZAXIxR2PB7?=
 =?us-ascii?Q?unORJd4XTB0i9MncIrPC2glpVgbW3PtmOWBhrSCoFHRKJSi/WWO7wQgl82L8?=
 =?us-ascii?Q?sra3LURGAClyQPecwajXRwbmIxc4WS32T4DxgJiF17+nQKwrQUPOku/1PhOB?=
 =?us-ascii?Q?GlHIiBYm4slDhaWH8dZ+fkHoNgI6/zaoyYJZ996Aq5dND7t5uBut57ph5DGe?=
 =?us-ascii?Q?3Ni5UN/X+PN9/vL3Ch8tNiUz2/wuudZPePDmuCFN12iUHHFsrsclBSjjl0/a?=
 =?us-ascii?Q?nFSa+pk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u8IOFazoLc3tPENHsOByELKs8oykgMJ45NtcDhjeEJfMVhVj20SE0RdUEBwh?=
 =?us-ascii?Q?akZ/TrrZ9ZbwwNYCmDV80PUGkDXlMip//sl1UQVQgZjAYCVTP2Me7EhFhC+u?=
 =?us-ascii?Q?T4I0U24h0PcBMQo78kjwa+2Z8i+NyORHQi2b1VX8fVEEyYWridNydiPp2jHi?=
 =?us-ascii?Q?HQZSZvPY0Eoa3GjJWxAwDApGYw4ze5ae5pdFdC3KlbNG5XzqmdQOoY1+hNJC?=
 =?us-ascii?Q?L3oi1iEEMaDzVHRBtgFINoWEdeuPHfBvAnvGXgMhMKssLYHAf2wjjNnCrJ57?=
 =?us-ascii?Q?B7PmNjsczgpvFOtCfs8rxrC6nBfjNXcwbraVsgt1Vqgfy3YJ4EuE24a5wOUb?=
 =?us-ascii?Q?mBNMefo/SQ0nhAQKL3Oj3yVq4BXze7nubTXAD/VSljQrZdCZcor3Rwe3vGgn?=
 =?us-ascii?Q?dHvIm/R3GjjKG9XJVsJChWHqBpIGp6S+GX8m2z3FU//Cvh7EdQbq0oDMnlUz?=
 =?us-ascii?Q?jjs6b+UBJpS9eGEtkhNIOD3ThXaE2VslLNHaDk3uwbKZt2MN4XKpviWL0P3c?=
 =?us-ascii?Q?wVte88gLY7bm+9wj0TOjR8fczSIz+CVH1581k6ttV0zoOsygY3YAbQsrkF3a?=
 =?us-ascii?Q?56Z/qZ3O51mXVtS1KFro6mdnjQtQnzDhTAL3rVK0R4SVP0iFahtzCZn/NFNK?=
 =?us-ascii?Q?rOuSkcUGllj5nog+FGyxReV+swBDDg0XCg/GLGyx8EUjAV4B0lInp5O5XT54?=
 =?us-ascii?Q?miOakuZPrlJnldTHLMe/GBvxj3M2ib3Suj30Hyj1jsfc3SOSpkHsem8r0Shv?=
 =?us-ascii?Q?qMbZsdXksy71AaB+vbEz5PttEt+D9fJUqNEeBqrNlD6odDGY1ZZpa+EOde8a?=
 =?us-ascii?Q?smj3ZqRJ8fI6FqwwBx5E7S6gOgoxWkT4PZi0kd1Tcs0doF8T9WbsLZiwm0w2?=
 =?us-ascii?Q?sn5ZMxxT4SkiujWqdEBvAZEqAShz1vO2CLQCckdtyPhbiBFXGHuczrBMz+di?=
 =?us-ascii?Q?9sVlC6YXXwlN2sF2waOmzGKHjzwXn2WZE5cQcvkssWBKEhMOkruRqyP/MytD?=
 =?us-ascii?Q?towiDNeqIYqnGLpP7v0PTNJzQWBaiK4YDx5JhSCtGT0vGp2OYAJ05THHjd3/?=
 =?us-ascii?Q?WXrdQkT/rGh4pR8x4Kp66aYqSgvzP9W+SslE07fQkYFrck+sJtr5KawIt+tM?=
 =?us-ascii?Q?dMgSKPQicOqlfMzNVcLxAGJqCyBntnelYFh6YR1gTLqczok7IG6+zavFBWq5?=
 =?us-ascii?Q?jIJCf7ehMiaRoqbCWF5I5Kqy1aUvowCvcyyiqtdxYVEqPA6uzh9+gTJp2S2a?=
 =?us-ascii?Q?zH8+XpqNnie1LWUiOvIqli8ZNWpB1uh0z0Tbqqh0SfQVsVlE8hKFpwvRXXFw?=
 =?us-ascii?Q?msrQnx9IzPPZIsZC67paWrI0FS7haO7R77ur4EaWEQsan7W/a1aXUwu/Q23P?=
 =?us-ascii?Q?YTkarnnmHlGaI/ZtdzDMqHnLTvsYKA5qyjcPwpcuVJQV5se8fybNFJtfR04C?=
 =?us-ascii?Q?gg+NFmMtSZHrGuAP96+vrFYZALjMglFeV/nkQTIFZDHzefZQ43OUI18EDQVP?=
 =?us-ascii?Q?15ItdRyGL7qRyh6C9S3dZNYY3q6oJ3j+gv1fNbGe9Kb2xMaaAULhj5boBOgs?=
 =?us-ascii?Q?7lidE9X01nR9B72U9SLk2F44IUqru3rYBbyugAt6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e41c95-feb7-4135-f289-08dcf7f58f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:42:02.0930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GycY7mi4ax2TzHutE8bGGPoTb8ZF0wL/3nuP4FOcbfoqAiX5UDFWnsWBxte6CdxhS0jpJ8lww+lleouYHd+5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7376
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:51 AM
>=20
> Implement the vIOMMU's cache_invalidate op for user space to invalidate
> the
> IOTLB entries, Device ATS and CD entries that are still cached by hardwar=
e.
>=20
> Add struct iommu_viommu_arm_smmuv3_invalidate defining invalidation

there are three 'iommu' in the name. What about:

arm_vsmmuv3_invalidate?

