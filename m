Return-Path: <linux-kselftest+bounces-33614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA4FAC1DF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 09:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2601BC7A94
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05481283FE0;
	Fri, 23 May 2025 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqu1VJ2X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843117A30F;
	Fri, 23 May 2025 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986822; cv=fail; b=CujJ8ZEz6NE4Sz+JkdFoQFR8XxptpA52xGppqWTY61h8SzzMYQawlG7IIhWZFSxWmmRcfHmjxH3lsA3Fm2U6T2w55nLSloso4z7hD7tfED2gcY1q2VohcyAwP3k1gIt2lmz3066yRsIre0vPoiAt53+K6mVvJo8AaVahcNdwcJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986822; c=relaxed/simple;
	bh=NWRSYGtntR2efisLY2Iv4xRv/gFCGPUoPAv2Xro94JA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E6CpF8Av/phNzrPbqVNHId+nLPIVNbeX/h+Iox+B+5zWOfLcGWa3FWe796bL7cL3QCRGCJJssTAbp9RnGuwuaoK7ZAOFtqsARTvtca0B6Vik55nw/c7wDOa0ZCw6jVltK/w3Kmtp/0kiGZRbpYPMCyzauDRraS2cNzAklPsThHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqu1VJ2X; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747986821; x=1779522821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NWRSYGtntR2efisLY2Iv4xRv/gFCGPUoPAv2Xro94JA=;
  b=gqu1VJ2XjVezw1R2SnVYo0SjVy6ojM+G2qeSQFRJbf4fAVDFw6nzE2MG
   3yBuENCO8b1MYF0SySTubdfvbMiV8cGvdUZRsIeQlgpKzPhu5JwlJ4mpQ
   vIZqg6wplLgXe+aJDe+30iCfkm8q246wGVHT5JK/gyuQ6HPsfsBVkWJvS
   dhyJDuAZBT8GmrVVGt7xQKMw8g3evlq3rqCSkPOliodvqq0ZZqRsCeXkn
   kfxXCNJJhplvUV59goL3fcoa+Kez/A/aQX0psI5KTW29M4dI3vOGgZq3P
   70cCO1cw5Trs+UtedaH1g7fyyuiz4S+MZ190Tqp/Iz21BbExOGNA5Xsgc
   A==;
X-CSE-ConnectionGUID: ifMFuf1WRdWMsAGOpj2oyw==
X-CSE-MsgGUID: jDsz3wFoRpS7jSN/kuNZmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60672425"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="60672425"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 00:53:40 -0700
X-CSE-ConnectionGUID: MCebFscXS3ORGXaxtBjSIA==
X-CSE-MsgGUID: fiJ5ixjlRy+R3OITw3fAqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="140891696"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 00:53:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 00:53:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 00:53:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.64) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 00:53:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhpLfkZ/G40e+g7YcQCJ8l+Bb0Ap46MlW36iDqVP661mXRfwSAtwmERkvOV/tKDG88bRRpj9K35syF8IVfJzQyvTJq/fQHDlQHqJd+7d3gIJK+ldGQGYl1XxicXqx4PGbJ06FFDuPSRilSj7q3bsX7HSDv5NG/U+7OcbNStMJ3OIZm2SgQJd1hMqNf+ECeF22sjpDvgMlpQLKQTT38NzJln9OvoqDBRjgJFm3ZVj/4QPcO0K2m3fJqUXJQVLBmBZCOdo4Nr+N2fyeCcBbSRCQAQqIA00etRv+CFU0Of//AK3f/jFfhVNU4e92m6jjU31O4rxsvqQhY14NEPcmKmpKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbvx5S1hHPcAWBpyUPudbci/nh0RDirZ0mGGPRXGGdI=;
 b=oQWqBy4I6Chq/4CmDp6A9LaXDW7j5bqlD+0NJW3/Ire59Psu5wVWF+I/V67A4Pzq8QYHSpD1C5gvYPQa0RiW3wzVfo8ULTdnD5chMNcM2Hu3+3WL+ZeQFzvc3w5e0xOZ8jpidBcoQrFWNzX8ntuxMzo8Npf93ItSpWzlydlZ9rq/3B2UOtmAGRXCHi88OJAG8Qd8NQfZuRn5eM792W4dpAZjKC+osrLdYxgfVR4Nhaqychh/HGd0LK7QdHqr4qTVfkmWrhtAm8c8ESLtvpQngN7ejayRMxAuX2xK4gAEuaJRwixtzpBLtAcaBrLalQeQhd0+10yVOM0QKMdsVSghNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7252.namprd11.prod.outlook.com (2603:10b6:610:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 23 May
 2025 07:53:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 07:53:37 +0000
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
Subject: RE: [PATCH v5 09/29] iommufd: Do not unmap an owned iopt_area
Thread-Topic: [PATCH v5 09/29] iommufd: Do not unmap an owned iopt_area
Thread-Index: AQHbx6QbZBNU1zJ6U0W6u/J4ktabNbPf30TA
Date: Fri, 23 May 2025 07:53:37 +0000
Message-ID: <BN9PR11MB5276A0EDB2CAF2C333372FA28C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <3ddc8c678406772a8358a265912bb1c064f4c796.1747537752.git.nicolinc@nvidia.com>
In-Reply-To: <3ddc8c678406772a8358a265912bb1c064f4c796.1747537752.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7252:EE_
x-ms-office365-filtering-correlation-id: ecdff8fa-9316-48fb-6369-08dd99ceecf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YJeWUXLTpG/jvdR3eZmcrYtIXEKQF88q2Lhh0Cizt1AzbXZB4wSveF0OR4hX?=
 =?us-ascii?Q?atAxkaenrPPnwnLQwvY64r2r6gYnYjZqOeT9cbFxCOaBs5ZiacJh2gWR6kus?=
 =?us-ascii?Q?IIuoI4ts8hV6cVsDnc0INysjMowAFPsTjdYyG6wCT1jW57VfD8ranF/7lpLT?=
 =?us-ascii?Q?mUdRT/wiCwFfb8p7jF7K/Vcb0oUYb2LVmoohU3aTG5Ga+0sF+ORJETl3IIG0?=
 =?us-ascii?Q?YI5EQ9AjuKYijPCJFZBRCi/X9J7OnHJRe9JUF9rGOGrlWJ6cUTHgmD5648wF?=
 =?us-ascii?Q?sBu3A42Tf2Fv0smZ2ZMB0/gsLcwU1VQkhZ0/CsGbKtZYO1DxVxBUBOnh+THf?=
 =?us-ascii?Q?D+4G9CSIQnXFY8Mlo9ltYDmQHGpbYj4ctNX9C12RNGlrKKB2I/6WxNRH3EN5?=
 =?us-ascii?Q?g7iHd3hBkKYYkAxsJhN/ajQPaW3BTeou99Q13Ws6vNQcytD35dd8TlY+siNl?=
 =?us-ascii?Q?E/eGB2KjgDmFDO6kAeYXTnarn9Uc1GOi1L8XGsianYVInKitEH/3VQGe2xWt?=
 =?us-ascii?Q?goQp/Ia0jG75Jsi88itujZT7IcIHgXNNQownU4+bU2ulOAdVOGgbeTkvtDfo?=
 =?us-ascii?Q?e1PLHA4Lv1nlhY5hNtZH4qeCd3EkD6NVNS1xJJbvO83X4aKR/NwKYWv80W+G?=
 =?us-ascii?Q?odX++QBcO0sjoJUCZcV3No2lNB3aY1fuNNRyjd1p57wsJiO17yMakfqBWDF8?=
 =?us-ascii?Q?aM9oeGafenRqTcS8WlThjVG2DuW+9/DSg3Y/fz8Om9BMPjNGrtCa3pE7ZzAQ?=
 =?us-ascii?Q?ImAn6v1tbBWBd3YbYHQzueCn9bAS9vBbC3/sTIIQ07GNxhcXor+BF3PsBEi1?=
 =?us-ascii?Q?zgtM76WrgUXb+xeNJw4eZNmAJqk7RQt6Ll7dzgD66B6zS8nGK0Tj/KbIXgE4?=
 =?us-ascii?Q?PowFnOTcMz5+DRHUarC74g1fVY7a+btRYPDTV2TH2LUYTI3zByyV85vnBfR5?=
 =?us-ascii?Q?UBxBxw8fJbii6Vlt3nvb0I9NepvAei1iZPl3QDYtWA11P988LCIbQZotd5dt?=
 =?us-ascii?Q?8qEiMHdtFbVhbkVllj3Z71r1w3KiJEf6d70lp8okl7LRVw9YCkbSGL+QIVRJ?=
 =?us-ascii?Q?QYsiFQl0tHSpZzpY4uNY2/Sjhax74mvruQu5nFgwgzGizXw/qjRkI0lTj4q1?=
 =?us-ascii?Q?KFgVdCbCFUU/JPz70AtbaTx94e4DDd3VRMfV+ePRhZzT4ypwEXNEPsH2lTfp?=
 =?us-ascii?Q?jw7IGjeDj08eshVlJcifuPxRtBCfRShHhdL+jCBrXKmEOKhEm6IoNIhlBDTX?=
 =?us-ascii?Q?PJBSWiJTtgNpWTUxvMt+BmFUFUF6b+DYhyYtzYywj/fwRyFraPko1Y6SQsIk?=
 =?us-ascii?Q?Ta5hPN+zuUcL818NtGo4lamT24r7zhCNwj0TaFAZR+l3mAirS1oAxE/djwU1?=
 =?us-ascii?Q?JFxJSMan0q3tF8q5B+cubdq5b8b066Okjes2Ugo2YrRPnM0por9ybuMCmqqu?=
 =?us-ascii?Q?jSvCrNNQHI/uujx01NPHBe/9o4ZiYaEDeEokTYUuVedxcXfAig/JfQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?apJCCSqLnLxvjFSYzUPEVuPtfBMnbE6XoMYAhDsx+SiJFMdDxG6DpsHaY4l/?=
 =?us-ascii?Q?DeS/xlGWYq63/4R6WP8w9jsAmkCw6XInw9x/AxEj/jMOfLeMmLqcEJ55zvIP?=
 =?us-ascii?Q?pvvdeN2CON3Dm9tibiQDefVdhOcvMpx/jfkGOfebg/skQBz/IeAV3FUrgX9u?=
 =?us-ascii?Q?T7Ye5F9t8E7TG1fFc9RKGSamjleYaHzcoNa2NzXR4VLQpcXhW3ZcIcNJL/yd?=
 =?us-ascii?Q?l16g+5oQc6y/zIKb1dau0kChYkKmQ9X1Ynqaa2sWhjMXucSPOzJF1wFrvfzj?=
 =?us-ascii?Q?sNToUjw8zQ/kc8Bx1KRQjaivIkiQKQW11uy/Y2zMVQF5Uypd68ImtxSD6q0y?=
 =?us-ascii?Q?u3MKN1hOHmohVvqjEOKMPvCuAuUrFzsLXgh7DGa1cdNYlvatFGPll/G7QVas?=
 =?us-ascii?Q?lPZ5PG3ntisQt2YvMV7BAb7Iq8ggB7VejBinxvrkWxJpo5eY3t6pTykR3U83?=
 =?us-ascii?Q?sZF7o8NtvSj0YmbiALDaglEeBmpQIW0geVVDKJwryI4SKbWKsELBK6DVJ/pB?=
 =?us-ascii?Q?v2AOylXJCjPGhJp3slwop3oQOMG6S1pgqN9OlZ7/ahlmR34M15YuGHlrsZGf?=
 =?us-ascii?Q?AsqQ4ipFcRWLkbMOL/6rV4RgJJcbzf0DxBgb+orzz0HJ3Uq3yuOph+CUQMVD?=
 =?us-ascii?Q?UkJNE1J1cVzLaBD6dndLtRqMwM6esFkMZtxWiJcoRxayOe5o4H7S3HDUUGh9?=
 =?us-ascii?Q?gmhHSOh3e/HezSM9gQTPN5EyP9WnTbABiHkSm3sf+PNFbLFhbKIjwHBmUZIv?=
 =?us-ascii?Q?WP0EKrfrjkVaTNgnUVAjvf0PU3YxZQeNOhfYQpVu8jcWogL6tC+YsRiKbvE9?=
 =?us-ascii?Q?Vhl8AtqmFyKO1rzzMq3woapkmlBcmxYOm1vxwXOu8hsA03uCNjpS+3H1hFz7?=
 =?us-ascii?Q?UqN4pqruAXoJCP1VFFt/P2bjsc250wD5yi8O5wmR4RTN315cKrnKYRYLX4Vd?=
 =?us-ascii?Q?dG2HuwnUzwOMsYNviXEDSwKjgH1S/tUVezlk6PEDu7QcGM27hdSaRcal0EMx?=
 =?us-ascii?Q?aObMxT32p3Q7m8liS3eUPZdaRkUIo60mCpN3pgUM7PACM7T7ULISsauew1Fa?=
 =?us-ascii?Q?Cc8sXK1FY3+HrZygxtAHz5BQhzosg9pIEqCEJktIngylxuHTedVP10/nWKRZ?=
 =?us-ascii?Q?E1TSObQtV8mrArTiNYnTJ2XQMCGCSBduYX2aPS1uNzpoAte40uONu001LlQx?=
 =?us-ascii?Q?kg3vKpbPUgexo0+c9GxI4yUYAudHezkyYbuZovOcrxG+0ICNWZRvUOZUp3q2?=
 =?us-ascii?Q?I41ZSFxn8SNnPQ05rcfUFm2MNkqMg60K6KRwH3HgVJtk3c8/4WjbM44eB3mO?=
 =?us-ascii?Q?Me8lxukpuN60nU2HQD8TC9rRY+vemuBjv93uj1QDmPcwN0XrLhrUwlEuKeZz?=
 =?us-ascii?Q?5qP8Xb+ldxozo5CwARV6s69LVJ4ZFuYVqFAxJCYjzcIS5qIQPjjj6okPsjxy?=
 =?us-ascii?Q?+V3vAooTeWpvFNJ64B0DqZahuk2GDH0FVAtkHu+ziuPPLet9dfLjd9UW5gF/?=
 =?us-ascii?Q?tkVFlFpkQzjZ8ntmmtrNZhfNLARBbeT/IdUZouG6W0yWC38cOeNZW5ClfNGw?=
 =?us-ascii?Q?Rthk87hsNjTaVnTRaysAEDm6HTKUFTJtnKezs8nz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdff8fa-9316-48fb-6369-08dd99ceecf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 07:53:37.4091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7usQCtjg7tFPipq2P+9J+t6x2lQUT5dUD5MIZCHqgWOZQY4YXTnAdXCHp+2JKGG8PtrtgGZKTjHHNJDkazDfmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, May 18, 2025 11:21 AM
>=20
> @@ -48,6 +48,7 @@ struct iopt_area {
>  	int iommu_prot;
>  	bool prevent_access : 1;
>  	unsigned int num_accesses;
> +	unsigned int num_owners;

What about 'num_locked' to directly mark out that this area
is locked hence cannot be removed?=20

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

