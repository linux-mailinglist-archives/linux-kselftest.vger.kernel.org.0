Return-Path: <linux-kselftest+bounces-33042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A81AB7F51
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED3F1BA31BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F46281537;
	Thu, 15 May 2025 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LCILHb3E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9E628001E;
	Thu, 15 May 2025 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295575; cv=fail; b=UZa5GUpwsI/fWZ7AtbHenTGTLIHtSLf9ECdwRD8TufUeRueh3H+1TpWyjjgt2xjoBlnSReSzQMbbUKG4/qcN/y5nopKrhrsqD8JfJQTEyT10PLBT/mt9l8sV6yjnxbnlBpAkDodTJhJOXx3RDi4dNJWBsJaq5qbtfmWiYGaursA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295575; c=relaxed/simple;
	bh=FAmEczLZJXBJ2ChQB22RPkEiaVbmtwCjr8CYFog/qVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MINy8cBpDuDjb6uBo5VGnk3sbOpv6UvLSpHl5i95hQ8aagvXMX3rShHPiBRU54d4wD2X2z7RxySCXc5898xYFzIw+HGgjHGRPpjnL1iCWMPePwk+ydaAsTgF9DTZWQyo/BVo2NWZv2py5DtVKA5Xyj69wWLdE7cBAdknVmJMGs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LCILHb3E; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747295573; x=1778831573;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FAmEczLZJXBJ2ChQB22RPkEiaVbmtwCjr8CYFog/qVQ=;
  b=LCILHb3EV/Zsc5/YMON1+M81DT2aFbvJQp4HWBsL1BYFW0bY2lGr5Y0v
   BHFcXhtUw0xq4teLXrWTTbijy2aGGZb6mMh18J0KAvyPaZm2e02/Bthpz
   uKFSSRgZ1KyXEwB57eDbJcLoq+QkwYtlkg/u4Z8wiCPzE0Mv5bJRKXJex
   Mp5DbG0GAuNoA0VOFX7C6Bz+Lw5sFLnUfsKCs9qUXi0RNc7Xtzu4Qwgbq
   0JdC0viNdl3BtvOV+gGQPZH9/E2jUsPLeGSOT47n/hnr7mZNggbUwEhhU
   jP3i7ez7t1c8C0+27LcSHwSVlqR7Yyh1HE3Ly+xPIBi8d8J2P5lyuIahf
   A==;
X-CSE-ConnectionGUID: BBJzOJ9eQ6m8m1dinlqEJw==
X-CSE-MsgGUID: NKxIAzqpSFKgwqks8NNMRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="53030402"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="53030402"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 00:52:51 -0700
X-CSE-ConnectionGUID: +K4I505HSM+kcJ7CZav+LA==
X-CSE-MsgGUID: NVhGdlmyTnmKKWfcr38/Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="169225023"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 00:52:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 00:52:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 00:52:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 00:52:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W67k5Vn7LZc5E2nyiXA8gen4kadAJEhQ4jmBTgEwYz4g3TOulx2nNPJ42SYzN/GCmrRzTVmN8abCJbgy5oou9KnNVFc4D4gAo7CeRGMaVcDaqjuM9qcGSznbNcma6922li2k43v6hdAzFhwWkpNNWZTMF5ZH/4ObP1jnKlpFU4qKGhrjl1sGXlk670Tu0FGMCXnX5HsNFoqiVeE8pKwnYgDYVMFrBcSkwPgV+kSi5OSesVE1xSZY3vHcL1x9jNBFxYfghilPX7PJwLhcuYESjguzK96DdA4iDZPlUESMH1dx6da9Vtrcj4wpLcVbg/tN1NwxKqbRLQlK/t5B/WoRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAmEczLZJXBJ2ChQB22RPkEiaVbmtwCjr8CYFog/qVQ=;
 b=MuKg1OAtHLQiUJK71YHJKotra+82M3KLdqbXzZn8M8yJ8v+2tZVuCSt1c9khjFVZI5YAWGHP0Byfe1YB61EAVmxtddZGHpfY8t1EEm5Ki7YFY2UMSW4sOP9V6YoqxB+oj+G+QjWR4vp/IwiqYm8m520Jt8TZ7IIafLW3KA6KL3VLITuBAzWDvHQJFh1LIHZGeQituYx5voMZ6Ck+kVU22ZDTngs91bsqa40j5kjgeYxZQEz02ay5nzVphEJzlYaaHsVRmByEJP3nuWbJAK23K0nXtPHN56UwFE1GPce6JzElQ2aRBxny7r5Taxj7GPsl8aTgYrq+meqIoe4vpELDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM3PPF7C7D8332C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 07:52:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 07:52:05 +0000
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
Subject: RE: [PATCH v4 17/23] iommu/arm-smmu-v3-iommufd: Add vsmmu_alloc impl
 op
Thread-Topic: [PATCH v4 17/23] iommu/arm-smmu-v3-iommufd: Add vsmmu_alloc impl
 op
Thread-Index: AQHbwI8Fu5ijC01iOEKBaD2kC33D+7PTW0yA
Date: Thu, 15 May 2025 07:52:05 +0000
Message-ID: <BN9PR11MB5276E45A0E79C75BCABD81098C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <80465bf197e1920a4c763244fab7577614c34700.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <80465bf197e1920a4c763244fab7577614c34700.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM3PPF7C7D8332C:EE_
x-ms-office365-filtering-correlation-id: ade755e1-765b-4df7-7595-08dd938562c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cGuswz7CULYmSZrrR52HHaTMbs/ojUEVUhVtLFO6ia5r/tysVzqxqlRYlGq9?=
 =?us-ascii?Q?s8+3Jjy6TJhtBJuKWzYTuAqUE1lCQUFpocsDKysQYfWdkxif0qe/zP1WuJW7?=
 =?us-ascii?Q?M8P7FhmMd583O3OzSon+Usav4ToAIafRCQ26KIDFMFnzBWNcTLozTt63V1MJ?=
 =?us-ascii?Q?tmH4TQNTFkH7k6hrg/1nZGgy+dJai6ZsDnPqUwpHHnNcz7W/pHt7gLyLQ+DB?=
 =?us-ascii?Q?voivR4GN1lYzc4Hmomv+mlnfxOCn+8Y3KiTau2gDWkfiHkga+HlHUNsrOhGh?=
 =?us-ascii?Q?ad+Vg42upQMnQpkTKeV0pXHG/0vWbiyHPrPGDjcpjtujZ3XtBUHbRonksgRL?=
 =?us-ascii?Q?GakrUpt/q+ypIE8BWUj5XgthtlU6/HP35NWKcEBM20LOxkkejn+xCaEacn6n?=
 =?us-ascii?Q?wts4onpErVEXGp9PbSbfcRWflfH8usnl6Rh6E3nGd9MFEiSRgyN+cgem6Zv9?=
 =?us-ascii?Q?QpTp7VqnmoDjSvl0Fnkbxn7oTySpS3ZOljjsA5jmOJe4AIHKIPAXOkOmMVuM?=
 =?us-ascii?Q?TAMXT3FwCadirvjWbvMf3trkfaycBACnLOFoePgMMF/uN2/OuC68P/m08Y75?=
 =?us-ascii?Q?bCwm/l1NsfSSbvBysXk8Yb9u6uo4JoXRzpn6qb5gknkaPitNtLFmXthDds/M?=
 =?us-ascii?Q?DI2zh8b0FqpEpuMqQXQdKcV/5N0Sj4ABg7xjnqSr5Lix8Kck4PuKXCUZRZMC?=
 =?us-ascii?Q?zPL2yBQwySa/LUaI3avPoHCtxtRY447dDgD4TZ3LkGOZo3zSWHH8UYCIQ5Vy?=
 =?us-ascii?Q?E4D+u8Q+ordJWyNVpn3XL60pRSXlyvGvmulxcm2Fw2Lgjtk9k9Nac9uUI/Ws?=
 =?us-ascii?Q?AUG54Pb7aDAumFeje7PitSUp9MMij+Q5iUx1p9XbgPgeGzgoX8bg9HShf/r1?=
 =?us-ascii?Q?Kym+5BmUYFlNnYLF0yYyVAzfJKN6lLNfUG2OrvCBiBPb4j15h/bkbkmeCepN?=
 =?us-ascii?Q?qeA/bzCtIA8oLJr+UL00T/CE2rrxcUE4d4dhPZnbzJVfnFTlukNIgK3aupIe?=
 =?us-ascii?Q?TcW3EeVYMsjXb2bGwyT2CixnwQkh405g+LoicI3fZ6yLinyiIa0WW+yCD/Rl?=
 =?us-ascii?Q?Jp7l5aVUYrcj7UPxmPb3yydoSSiaBYw7Sfoo0jVc2DbpoAuVMkHUhxsLyYCA?=
 =?us-ascii?Q?SbbNfdbaNkClLvU1QCXw5mpweMZg5ouNuDyE49j94LmzTULzh18graraQ7zU?=
 =?us-ascii?Q?WfQCTv6iM7AQPT4FZFsIZJT6HZD6MRBMqLVH1RmfjSmf/LF7dcyb7ilQiXCi?=
 =?us-ascii?Q?MnSNyJH2j+TPSR7wS/Zh+8IUbA216h/APzmLEgk/Vk/s4k5kMRSNCHGIx2ZW?=
 =?us-ascii?Q?7ZjpDmUiW+ILgHk1HBG0KecSkw0RmI7Xbcb7tIzwSR+70RXK3B+8Cl0t7kGW?=
 =?us-ascii?Q?7cwK3iNVUqOHwMpbEbXYPCYCOfDXcNrrTQZBa+0LtcGWyELh+fracS1le68Q?=
 =?us-ascii?Q?vE8rZ8J4xRVp/FSMQ7N/Vw57RDHUD+X7EaTx+oRX8I/JkQk3L730qw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DSoROR8bocGcXb99VTaxPYWudYnhClhnJ4az40i+KaOE5ZuXkGJk0oIk2Jxs?=
 =?us-ascii?Q?XKLipZ4H6BxBoRM2spQ5zNt+yVVD/UKJR2Dkfus8Aw0/iVcKaWY6SDDDg8Qh?=
 =?us-ascii?Q?bYV5j4RWTVkRlrLf4XU+vER4e+TVsrXaxLFF1LV1lslsy94vrNDeK7KqvkKq?=
 =?us-ascii?Q?KMMB0Ow3C9Sgob4QD0lFM/ulD8M0TBr+3X0JTZwisO8b0T4Nt8VHuWzfKl65?=
 =?us-ascii?Q?6pbe6zLez5r2bztvxx827u5c3eSW32F2mrIQqT0Rx8HqZt1WXoMs4MtDTBw4?=
 =?us-ascii?Q?5ApaMN2FtgRA/XqQIbUZcOxn2vUkvnV2akU3SDJWBg33MsTXmtT4owzwp/+N?=
 =?us-ascii?Q?e8QZQZpfw2H7etW4NAPmlMul6PQm6lWG+WcQhoiRSKWxrOHt+1zV0wOycJvH?=
 =?us-ascii?Q?2fnJUn+Pk1zSTmgw1RXBZGgJ8QP0B7T2vRSj7hzUVjDo+18Z1D1CXPunLKOq?=
 =?us-ascii?Q?u8jJmO5bd4IT8nLprHAomhK/gbpOpedF2wD49M7vwPgE0/oqPlVDMTvopF9e?=
 =?us-ascii?Q?Iaoc3Cdb6qn1kcXIjzWvwM+dK4cOd2/09gVI7l7SFTb3PMxM1Hf3KMvpLEu2?=
 =?us-ascii?Q?5XOnxpTH50MIeQTkB0Y0miwMwHkGxAmhFRz5D7bSAYHC6Ds0en5fou6kBOm5?=
 =?us-ascii?Q?4/ijJaRq3oAOsYDLBEGJdbHIWzOlDYC8nspwwG4uJgXAKClGw5OQDNEREACm?=
 =?us-ascii?Q?Ip4PNHlsWszgsCIUuoW1RK59NTDVtgzLMwz+o9faWlhwYwexCfSWmPzLBdWF?=
 =?us-ascii?Q?7MJCP0TdxyRq0NS46RXus3mKf88kXITo5QYBWL5G3qrm865NiRAdE/dRaoBD?=
 =?us-ascii?Q?HwbIKi3rz5x9wel6WpI7uSVdnReG88DXjmYga8VNddSSPQ7D72ng/x2tWpd0?=
 =?us-ascii?Q?aCe+R2h/NFZxtfXncmrrNrbwlVHfE4IfWKHHcBnJ3lyDc0l2Gkk++90n8tJ/?=
 =?us-ascii?Q?F5oRC9clkIOeTAjtSM8+O3vdQx/P+wCT46ozDuFjBGHMhhmXQ98kaXUsm8BN?=
 =?us-ascii?Q?56dffSXTRMc8M9Inl9yG5/LQY+egN8kg4jZXRFORbkunj1u1H44W2p9EWzP0?=
 =?us-ascii?Q?bK2WJHzvgkpW3ZRj8RbU3AFUck+X8SRrgiwyTGjPHpumDzcUaENvc7LslVy8?=
 =?us-ascii?Q?fYk0uYta7Z4gdTK738StHO10qaBYV2lfc6/JfWTljJfJYEIFK1Z1JnQMvp/K?=
 =?us-ascii?Q?Hn4CzoJQpdDcjOnpwGvUBoPR+MXnMJPG/jDW+A6RhGeswd9U/Akq4CQEXhiP?=
 =?us-ascii?Q?AifIrCLyomAA+YqzAPttZ2smGfidgRPwBrHQ9D9DINxg2IUvaEtwS9lFiTAD?=
 =?us-ascii?Q?Abrr5HEn+J3zyYt6vR1s4mCnrhK3flfsC97bjjz35SrVA8tjwhNbsvU7Cv39?=
 =?us-ascii?Q?jtaCnsQ7y2zSwQ/Q6qZR/aVy3JvSs2xt1WnK++e+PGYObpZWGMwA87X1M6lD?=
 =?us-ascii?Q?AUffExzIsXix6ysDtFJnI4zr5hbPOoZaW4OybjNp6VW2IUq/biDHMObjbFvH?=
 =?us-ascii?Q?Ej2QAUEGlVjKnCzG/xgtVywMYmtqXZo9c4mJTp9F05/+5gnmFLMYTdzyd7Zg?=
 =?us-ascii?Q?vzrCexpqNLGlfUP+HMZUp7fo0oRPtc7FquWRuKRT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ade755e1-765b-4df7-7595-08dd938562c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 07:52:05.3116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iy7wJ957LBXygb2ot3UlLqcCBlbAXKB+Yk770W17Ppvm0aHjp3vaaFdJr1j/3JoCsEuaNXP8OEeSFXUb+iXBiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7C7D8332C
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:03 AM
>=20
> An impl driver might want to allocate its own type of vIOMMU object or th=
e
> standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3 by setting up its own
> SW/HW bits, as
> the tegra241-cmdqv driver will add
> IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV.
>=20
> Add a vsmmu_alloc op and prioritize it in arm_vsmmu_alloc().
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

