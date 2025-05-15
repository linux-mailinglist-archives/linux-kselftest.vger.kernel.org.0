Return-Path: <linux-kselftest+bounces-33063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 171F0AB80B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55440189FD27
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4942293732;
	Thu, 15 May 2025 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jC70rgkp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183DC288CBA;
	Thu, 15 May 2025 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297685; cv=fail; b=jEcxSDZ10Qlev8s5NXJ6HVVAsNeFBNhuMdlZzuMg7M8O0QJ8iL4UPqvsQ1jsBZJkk4h0JRvLRo+mymcvMDo8z/9ZUhrpvThD7MQ4ZXH98qp/2vd5GDoXSjvjSI6P3VqoBxUw/aOCty2GlFxPT2srpALImmENWiMob2ZCkNSljjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297685; c=relaxed/simple;
	bh=9g9HZBOhOo3k1sKGB4K3JuigIr9FYmxblh4CVyZ7zvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JKG6TudL+Ml1DMtmHHyHLjYYh9OKknsdW7+IBL2GPgX9114yg7uhY5Y3BbbotRv1RtwzyjOAHoO4YX8YRb0gXuOmeN0Rq0RKwKsPpPQum1LAT8d95wDLHHfSJaAhxFXxXE8amkKE0HcBQsdHgnTSXoRTpceQvCmFb+Odv6l+Nn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jC70rgkp; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747297684; x=1778833684;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9g9HZBOhOo3k1sKGB4K3JuigIr9FYmxblh4CVyZ7zvk=;
  b=jC70rgkpNA5pxjNdgOnJOsA8elrJgjqBJ+6RjDN4e5EaNrRXgNohPxgA
   GLuC5lb0/5WIT/27qBjoisemFWB1Wf/yUGobALXVJzNWGR2qrsWRKO8ZD
   bBMrX5UnlfQTgW1khyUp4yyoEtuYipLCQcEoYPThwGiufhj5+PFjI3d0z
   ilE1DByiPv890tpfXVQ5WaKW1ZdclfNIrpdyKVPGMoNQ+MDYZLGeknAPu
   xzrXQWJGJds3jHEKliTKVV1AERWGSkuTUcFrmHScgSyB6U0IaGQDEbBUR
   3i4V6LR2gwp3P8nH1gplVnXczgl+BzQg7ttUX6iLRNG/nKkiKTR7SuGO+
   Q==;
X-CSE-ConnectionGUID: YCdvTLSNRDmgL9Zjuaa9Zw==
X-CSE-MsgGUID: PuibCT0jTnK8gJ+aQGoo8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="71731703"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="71731703"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:28:03 -0700
X-CSE-ConnectionGUID: 9wfhQZkKTrqnNs//aRi7qg==
X-CSE-MsgGUID: YyVB5OD8T/GdNSeJB682Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="143185843"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:28:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 01:28:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 01:28:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 01:28:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgxjsEU3M98op/9xYPmBY/mo2AOqWFY1hVofohhfR7bJyje+yQaDe+eXprh+cru4sLrEFwkISpAIw3Szap7PAfDl6W2yaPrYgNvwaZ1/95jxEvNB1WTyp2TJMHnZbaghCOITDRUPoKFw21ACzMF+i/dDeHq/vj9ejutYEHOqZQLkmCfSjk8rNK5gSoOYp350n3meKSXhimBr47Hn/m13Up/AKdlk3v8HNmRAjqzfQkq59jP+tR+EJUwzqNYaw9jtcBxA7QTPv63I3tznP2MxVjwfGgAgnST1SzsvvipdpeKALLIK0BhZldxIzKx7m7DGNjrHoBK49nNllgRbLGn25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lim6eoeiwl5IIqTfe9KxLrCvstMFuoWXmqzXZTej2fY=;
 b=S5W0i993MWW2TkOJf//JVyiIN7sK9v4H9eTe9nuWKYh1wC0CzISm2vtlgtQK/WLVH2/vtVuR0uCQ4AZ3k1Ry7gPMDNEQvwH6VoWrZt8pA8f6Fph4T/zRrDJ4oNETbzNc6ETDQaOCuL6WtCWAy3NxrwyEl7EWmQhZ8QcL7h8jMMTFBYYonY6rG6z01O4/KHn7p8KLoIH246nolyT8w7fnFwWRDAW/TGsqTulj11vIhQhmVFy9LTvTdLSwVCHQ/FUnVsQNll13KXTDm4Sy0bt3nihA6ell5nVXZupO1LsWMTB5Rjj1tohJNIfLxxHsF+qSqqQm/PcxUWcxUZLf5viOxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7411.namprd11.prod.outlook.com (2603:10b6:8:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 08:27:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 08:27:17 +0000
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
Subject: RE: [PATCH v4 22/23] iommu/tegra241-cmdqv: Add user-space use support
Thread-Topic: [PATCH v4 22/23] iommu/tegra241-cmdqv: Add user-space use
 support
Thread-Index: AQHbwI8TP7a7pfTA+Eqp5zIRRE0caLPTY4PQ
Date: Thu, 15 May 2025 08:27:17 +0000
Message-ID: <BN9PR11MB5276D8FF50750CF35D0DF1838C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <a06e91b8bb4a2966dbe7fc3349502d38c3ba38cb.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <a06e91b8bb4a2966dbe7fc3349502d38c3ba38cb.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7411:EE_
x-ms-office365-filtering-correlation-id: e95152d7-d6ea-4b73-1b32-08dd938a4de2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lq0M6LvoYXZ0fPjIoJy6JnknaMMw4HWC5bYYMIRzTKh4tGz6xf0T6YWaNZRk?=
 =?us-ascii?Q?my9BiazuwqiE5kRc+23j4IzdbF1Rur7SjlUGXb0z4IOwKfOOmWtErQoDXsHG?=
 =?us-ascii?Q?Ylo6GdSh29LeRgFbS9rveFNLcLUcra8aaZz8o27SbB1bSfwzhIDiC1hoZE6V?=
 =?us-ascii?Q?3Oe6YzNaL++BB+YrK+C2MF137+yOnrKRpYAQc83CPsDEuOP3oVJ/BigrRS7U?=
 =?us-ascii?Q?EGcXAN+ApI7smcK4vij6wf5JQfZt2gFu3ezPiO/MVpRMNUVTr9REpjHmFF1t?=
 =?us-ascii?Q?PfyQ/iikv+vEBCcrlqDq0vYwwdrnn+tJr86P0PtXZ3LoLFN013vm3UxZt8Oa?=
 =?us-ascii?Q?tLXiSgMZjI+eD8Hc/ReW2nr8WGUYwOBz5W7UD/uFx7luRNFCO+y9xa+H8sY7?=
 =?us-ascii?Q?BMNylg/2t75xq3hEdziE09P6xOdjxFpQ3efvFf5c4VnB9OvZbhNcBuewTASi?=
 =?us-ascii?Q?3IH3y5zWlp7XpJ03otzO0/5Av5BfeyGtdc+OPGI4Z2KxJsSf8F9taGsk9Vux?=
 =?us-ascii?Q?HMWFEVyFPFsMKHhBs5sh30TvLjny3mQptxAc6/7xMj1MV/ZpN4z83P/6q8Pz?=
 =?us-ascii?Q?P0A4iLqYAEfYyJrrQ1S3PZ8jbvQJicYPlb2sC534HzWnPUCOclzitLYeKroO?=
 =?us-ascii?Q?BipfrR4Sv0szUPxNEfdNjuc8UDxRUgazPPkQ/nKKvW2UY6gc9u1K2ofbLINv?=
 =?us-ascii?Q?ow3OFmYregSB/+DGFOjvH8javF40evZaXQtBhfC+JmG6lrlMx/Wg8RB0Fxqc?=
 =?us-ascii?Q?YvzCd8h5s79sN/B3NWs5d421Rvxr1fwHmbO9ZJh1rMI49qdw+lr4B9fDpq6N?=
 =?us-ascii?Q?pnuh5OHOQWfSGfPmap0mYcShqNJlWvIM1Z2bGtctk+LaLB6EqSbaCvnV4HHg?=
 =?us-ascii?Q?JsFSLLIyAbqjPCDqhNJJR0z9q1K3o6ZHSglgWukacdFweftlOzwUP0AgDMwn?=
 =?us-ascii?Q?gXHuDr0ocfDjq3iO/7FjHIfcNiujVnZCAEPJBDVncUyM4NvE/BPBQIudt61B?=
 =?us-ascii?Q?MZgR7h6BHnhOdTaIxMMcJ06Tth/Vu9dxCBFy6anmPYLAizj98+ezp2oq3Ph/?=
 =?us-ascii?Q?Huux7+bzeNltkZeMX3ALBRouLP6dxork7ZXSsz6LvmGjyn+ZVMfxeQTN2KVV?=
 =?us-ascii?Q?P+M2mjDMWRckMvYa0NncxroBaQnnlFF2hDgEAaBdNMXazgHHC+36lqTEMLn9?=
 =?us-ascii?Q?AVOdRYpjr+DLEU9zm6lynJa+1oP4illjl0mSRDJjlD/tIM9ItVkYM9KMP4XK?=
 =?us-ascii?Q?TUVTCW+9mgn7xFkKuU0BAmCmv4edplvWgHVo2WnTTMdngRUHxF7zs3yqmeRk?=
 =?us-ascii?Q?1+3T4MrblnB+/+6VvWJtbSbSwv24a1rH5KRmkGpJPMIyLj5UFWj77S7kQEUj?=
 =?us-ascii?Q?RWL1EH0UkHx0sWvI8SaCADaMDn/9XuAncZx56Sgs0bobyXp0ghOrW1TPUwSE?=
 =?us-ascii?Q?247sHQxlaP0fjIau+Qd8WDYl2/3SP2mcsdD6fgVWZafT2f6OfxK4Rfc8HLEF?=
 =?us-ascii?Q?474CgyU+OaXFd1A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rnp+ShQwR95ptUXS1qtKiax9Efiivzw9m+m/BaNRPDtjOkvNMX5WhodhTEKM?=
 =?us-ascii?Q?a/ChV6Xa4SUR+C9sLll6t0qfCjI7Y+x/T9YInyx8INu0s/V/tkCAqEFIF+VE?=
 =?us-ascii?Q?8y4CBJP9K1gI94zYh59HIyXejwDfgFZAPw/KWCWWzwjvYo50Zy1JSTdPNMyz?=
 =?us-ascii?Q?a4z2CsyCRY1aookSsSlMmihgMW7KJfG97Sk01Bi7eRfYTlbZLvq0dqnUXWvS?=
 =?us-ascii?Q?3tPtNHrbB9avgrA8sx3B96QvHIKOyebW5xeMv3rKezopPZ4cWBS3Kh5anJUZ?=
 =?us-ascii?Q?licqtn+52FaYRY31N+QE/gW30YEjrMuly331684zf/dLpIIjv8x9HuUw6O/T?=
 =?us-ascii?Q?V83kQD6xkO3Pyr6emA2ZTfa9nmuFJlnEYVG5rP6LyEfbIEM1Q6cAl0jCrJgO?=
 =?us-ascii?Q?nsXUuvJpp3sCmlm0WPMt3hEAi9b3o6C/0c02ButcvZrGNzhV++wo2lgHKQdC?=
 =?us-ascii?Q?P2KaZk/T8uVdnLVfavZHje7EUBtGz5eNvQATShdiDeQJBMXdO9o8jZSbZ8dl?=
 =?us-ascii?Q?ufjKmL+UkSKfKBjPl/QeBlHFCfLEP7ofXTJZ5AXL72lHlsAAAKp3iyYf5Wfk?=
 =?us-ascii?Q?7zpyNChWus8uOQMHD70boN9f33zidGN9P8BA48Q3v3NexIcLQVZHfHPPTwv9?=
 =?us-ascii?Q?Om4GUPXsJ8GcacHVeMexDPtXCPbNL8YplB8XEsmnw2JMRxASZF3A1z8rY1Qf?=
 =?us-ascii?Q?K9zaambXh2Q5Liycxxr31M3yD7H1o5MEdOthX+8rF0mBKqTEqozlm9h/BVaH?=
 =?us-ascii?Q?gUz6RzrCeY14vhoVguArnKifnFyizrUNgWthzp409qiC84PpJ+TEGfWk49OD?=
 =?us-ascii?Q?kpiI3g0ETytREVZOTk8izdccj4UWJzcaERMnbuUIikQRbz+XZEucw/+X7Mos?=
 =?us-ascii?Q?Fu60enxq5KNaammiM/cGNU6KFhM1c5pk1W/2K7RqpUNBRVCsiZL6qcCTDWHK?=
 =?us-ascii?Q?hkdkd/2jNnyXhhFwZoi5DX1slC+e08li6Oqkgo/qh03OAVZ7akv8OqCOdvru?=
 =?us-ascii?Q?8TurqbkvEupsz8keGZ6LlMYwnq1HDkaPBvHUEjsvZzNVrsXSRs/aabsLPlRU?=
 =?us-ascii?Q?trursEyh7h3O4d5a3XANP2B5VC0xShbAB5nVSF/RJpHRSo3cwbf9wLPeQik8?=
 =?us-ascii?Q?C6z/AJAaa0SSn8f46Y+ZIbY85qxkVMyjY++9cGwjR9zDz5fGPmc5pxgRNmIW?=
 =?us-ascii?Q?Ne3hh10Ws/9ZsyKdc5AZz655ZJtTSZt5PQUP4CkyqPUYz3/4ZvEm1+L/B4uT?=
 =?us-ascii?Q?O+93l1MNnZNBFio4gpSXb/qmn4VF8TRsRIm3JYwSunO3v1ZdCpipiYrDd3St?=
 =?us-ascii?Q?ZsX78UnbF28vuSW/VVu2f6xEB6quIt9mdzbrZVT41yXutCOvYpyixhFFF04h?=
 =?us-ascii?Q?I1hf7W3dYmK1qD+tUdKN5rZs/bK4D2e7DSiKqXqNaQs/jRU6T3ThLK3yeQAP?=
 =?us-ascii?Q?h58i0B5/LYTbPtOxgBDlwQnaMDpZsPypdElLNVNvxrOaWm2n4jlahkupK1uR?=
 =?us-ascii?Q?GXs/gmqdmtbzbST5sGY0y65MYOixJq0msxWEjg95GxUXWvVATOeC3Ht4Sw+k?=
 =?us-ascii?Q?S4My4gPIOfcw5pXoRrBtPIu3XluqQ4Uj3FWcVW2v?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e95152d7-d6ea-4b73-1b32-08dd938a4de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 08:27:17.7574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PdtrOKljI2xmGLYaFhgy9zySoHAmJKI/Ks7VlqLg6O8boCagm1xlhgZPliBY/qddJrk71pq0xqiCFvjGlCoTOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7411
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:03 AM
>=20
>  /**
>   * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware
> information
>   *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
>   *
> - * @flags: Must be set to 0
> - * @impl: Must be 0
> + * @flags: Combination of enum iommu_hw_info_arm_smmuv3_flags
> + * @impl: Implementation-defined bits when the following flags are set:
> + *        - IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV
> + *          Bits[15:12] - Log2 of the total number of SID replacements
> + *          Bits[11:08] - Log2 of the total number of VINTFs per vIOMMU
> + *          Bits[07:04] - Log2 of the total number of VCMDQs per vIOMMU
> + *          Bits[03:00] - Version number for the CMDQ-V HW

hmm throughout this series I drew an equation between VINTF
and vIOMMU. Not sure how multiple VINTFs can be represented
w/o introducing more objects. Do we want to keep such info here?

> +	 * - suggest to back the queue memory with contiguous physical
> pages or
> +	 *   a single huge page with alignment of the queue size, limit
> vSMMU's
> +	 *   IDR1.CMDQS to the huge page size divided by 16 bytes
> +	 */
> +	IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV =3D 1,

Not sure about the last sentence. 'limit' refers to a certain action
which the user should perform?

> +
> +	ret =3D tegra241_vintf_init_lvcmdq(vintf, lidx, vcmdq);
> +	if (ret)
> +		goto undepend_vcmdq;
> +
> +	dev_dbg(cmdqv->dev, "%sallocated\n",
> +		lvcmdq_error_header(vcmdq, header, 64));
> +
> +	tegra241_vcmdq_map_lvcmdq(vcmdq);
> +
> +	vcmdq->cmdq.q.q_base =3D q_base & VCMDQ_ADDR;
> +	vcmdq->cmdq.q.q_base |=3D log2size;
> +
> +	ret =3D tegra241_vcmdq_hw_init_user(vcmdq);
> +	if (ret)
> +		goto unmap_lvcmdq;
> +	vintf->lvcmdqs[lidx] =3D vcmdq;

this is already done in tegra241_vintf_init_lvcmdq().

