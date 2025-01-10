Return-Path: <linux-kselftest+bounces-24187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C29A088CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 08:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2111677CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 07:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD47206F38;
	Fri, 10 Jan 2025 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPlGN9yQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7152066C7;
	Fri, 10 Jan 2025 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736493216; cv=fail; b=TPxcHnaShdWRvIlTor5jA5BBGLuoTOcyJVwzl8swHCl9y7kN6rzbLFFjkG3t2NuKrJO8bo1di044husx65xr8ZvuBk11l+M8cMT/IiLGCEsSeP19CJEi9Z0JppGsI3jowna2rtmIkOt2UTIkzLc9sLbESNSChRFlRATCAQ/4fe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736493216; c=relaxed/simple;
	bh=MeGGYskInaSI94wOC+EH78KABL5WgNFw8eKDqa530ME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A4qobWiLcNVhjGMtu98K12L8G1q+ANarjDktShesC9f5xlJIo9c4oC7xQIAA7zhyeZG/XKAvp4SVNAo2Xa6hyVjKY0eHMO3ZBUZCDqgaai93xLMyYmbmNB00yXFzKF0F0iPusxAh1qodG3N11nhGkYvbNkO0AZ5FMiSS+mtxbCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPlGN9yQ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736493216; x=1768029216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MeGGYskInaSI94wOC+EH78KABL5WgNFw8eKDqa530ME=;
  b=QPlGN9yQZslNdxLKZIqrHT7mSkR4DDlSIcL8VzPWvR0EynSZBKWdrYmy
   hAbWYn2CD2rs7g76GOVnjiSbqXB7lPnVYSBs1WX9Brof/fJdVpTv2S3Ce
   jFk1n0hGND/DyAcNhuGxJ1pFWw7UUSmehSyUwhH3zhamRfHRVMUYLT70q
   UqmQnIIFFBz63/kcLLNq3fXOvlGLxyUj92ki65xaq4asAOmq1MRiKdFIR
   mmauL2LYakYulIfGhSuk/M/DcOZ21mtcE1+/PsPW63mGm8m0rUwfc0JfW
   VQPx71DsOq489QtREGvlbunnYNXEWbAyvFXAdg1ftMg0Hio+U8/YWrnBu
   Q==;
X-CSE-ConnectionGUID: GTWm8J3ZR02Af45IwKNsrg==
X-CSE-MsgGUID: yVQ1BauOS5qJ4K31kaNpuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36887663"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36887663"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 23:13:34 -0800
X-CSE-ConnectionGUID: 1E2lCYkZRi2f22VD/1YY3w==
X-CSE-MsgGUID: PFWWuk95R9+lQJ4EeDd5sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="108576257"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 23:13:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 23:13:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 23:13:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 23:13:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQfzwY7X3z7DMvYEo10jG+VyIZEN7z8qvwr1CN/caod73d7aCm6ufXmDooJOpSDCE9dp5x4nYNeWNRKt67zph8XWykY+q5+ENn9zMxc8idyMLeDN3z+KfKYMl09x1s1oU1R1uy4JMt0OLQ5z4a4gQBmh7gmv3yFlmQZxy5R2OFLUqERG0bv/bdMghOo5QmRxwRoh1OiI/G740Ot1xVxyLvk0E8xuqAhvlmLvcuIxvyXcgp2yNwyOvrADZ6zMYRrdPGleLHZTbQPVS55QXdrBGKicJmSbPJ9RIRttFKVMXLK8jV54YazBR2XCBYEQcRDai938F/jkTwVBi1WoLgBObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeGGYskInaSI94wOC+EH78KABL5WgNFw8eKDqa530ME=;
 b=rikPZlHMmmFaPGbj41H4XB407mVdPpn7ZSYdBDvkO7gnXVUY+dfV+mpLUSUsn92AuRY/qv31z1HmDpQunsE3APE9q5SEB5kSwQvML4QUU/xnbUhOEMqNYZqOb3svA4t8PwOUjoUeQhwx4uyCvdCkdIyE1kPqdbScLF+OLiT7Ly/41SjRXLw94Lo3o803zboKm18OcaczMJeHevtZZ0thYkqAlOckN7OcjTQmQFcU0P4jY2x6cEZv6z75plxY3awaQNhXqrZkG+Lo/2xFVx4RokwKbVFpHnmaGODOej8ZwqALN2KEAfILm3+SJRl1dLgppq0EyrtGf4oWeZ3AFdSojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 07:13:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 07:13:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 12/14] Documentation: userspace-api: iommufd: Update
 FAULT and VEVENTQ
Thread-Topic: [PATCH v5 12/14] Documentation: userspace-api: iommufd: Update
 FAULT and VEVENTQ
Thread-Index: AQHbYSc8Jat33VY7pUaPp9nqTwNzrrMPm9bw
Date: Fri, 10 Jan 2025 07:13:16 +0000
Message-ID: <BN9PR11MB5276697F4D8B15BE97FDE0228C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <02e47317606d0e6f1220596a98152f61f422167f.1736237481.git.nicolinc@nvidia.com>
In-Reply-To: <02e47317606d0e6f1220596a98152f61f422167f.1736237481.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN6PR11MB8196:EE_
x-ms-office365-filtering-correlation-id: a3cf0e75-d613-4cff-d61f-08dd3146414c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?sYTkCfGpWquuNSuVobrPMKzuK1P3BKrm53zB/2GghqJuqnl7gaXcHB/eA09J?=
 =?us-ascii?Q?35OchkCbpv3tGqDqjUqjxsjuvO1SLwCtEOXEVWV21uYL3XsFK8eoQ09njFQl?=
 =?us-ascii?Q?V3pUIpGTFDLczKY2Brb4bLjGf50DKBAl1p8GMVjGzZx3YnuULZPKq0Yst54g?=
 =?us-ascii?Q?I8NgF6MnOjgHSX/M83SahM7ko9Qu/7PciMwWswb6kQfy7BTG4404bVNsLoKh?=
 =?us-ascii?Q?p4/AHi6r3Z9QxSNtswfpmlbmSj4X4OnVsn6DMqSY43LUg4SsccmPMbfbs5Qp?=
 =?us-ascii?Q?al5rUfRPM73em7fv6yZb5YCPNIygxZ8sLtrMYfLs1+vPuJquQzdJp1O+KlKh?=
 =?us-ascii?Q?QBAM9lMr3hiFD/PD02fPLzY/5DKdXudL1hM5jfvrscdBPk/GbKTX1F2IWsVC?=
 =?us-ascii?Q?cK7ZPNcXwVNq59FtvPNJL3uDGoczUQqf/1Llykl7GJ07ajgi/UC3L7EvVMOQ?=
 =?us-ascii?Q?YEWtD4PbvLih4VD9nDWL1aAEINNrDDzjT6ow7MbmHTxw5qfSz1ClFW60vp+R?=
 =?us-ascii?Q?4Evtwkz+ePcuqcYI7Lvb0mZPxzdC34hB1DYRHHYy258gC3Xb35RYv+O9K/qe?=
 =?us-ascii?Q?YBCwcJydvPGHt6ZAhtSK6ys+F6CVnGofIPobmOuDLKMObrChd39mX2ZyC6Ad?=
 =?us-ascii?Q?wQJqcD1BXGh7UsGr9rtwejIKySBDPnOCYjoXLzjzZ8H+50tAOuwTN9v0Cvo/?=
 =?us-ascii?Q?HUKF6nW6Om36tpN3I6RHfpkCivBmZqXMOHfpncLhZuwLIXX7UCBYC9SbbV0R?=
 =?us-ascii?Q?xQ/zc7XVATLiY3HYbnRtGC+8fAsYFGJrBDAlQcOO3+dmRl4znrLSXyxjdR1C?=
 =?us-ascii?Q?5lARqmzCuHqfOserFJwCfGxSZuRcU1Xr3zrn0a2HKl3u5XYo4E2K6VIqblTS?=
 =?us-ascii?Q?KNusy7jM2woEW/yEIguJlXFkg+c2UKvLl9BBm90hbuI6y32L+daTsB+pKRvn?=
 =?us-ascii?Q?NDheYXd5I3ETDezptO3ns4TjQu6ltDwSBDrh8CQh6XTymIVtorNwHBZFItTo?=
 =?us-ascii?Q?4qqsoYGvphPPITEyu1wKwb9DLzG6U8msIaB9uKSRNFxJ/5qWP7rBryPlf+IS?=
 =?us-ascii?Q?ZN7n7zegGjPOiuOcVSIE2VO2Y2d3xoTAuDDGFnBQ/0SSuKHOUpUz1ZpDLoJC?=
 =?us-ascii?Q?4pS02t7PiHKiOkSvSm4GywVMjHaTZazoOMF1iM5+zVW6jQ01aMFqlGpcACgO?=
 =?us-ascii?Q?3i3Vi+hfrFXEHBTBmILPo00zMeJiPrn34RJjX2YF+loUrFkScmKVUWWPb6fn?=
 =?us-ascii?Q?MlkxjewDIwR5CNLfXht/RfVbMbXbeISg9z1eWtBeHI1jKcg9i6b25+40I3WR?=
 =?us-ascii?Q?DT5VZpebL/MY6uEhB4R+R4FAuCSkCj06qcBzrMXsMnO08MSgKctI4W31Sb31?=
 =?us-ascii?Q?2pCMjvIrsNQPnfmu0tSD/ZASwK17R17KY7fMinqhwiTInEJqJnkiZ3OMfLLw?=
 =?us-ascii?Q?i9/1V4VJ1LTqrDU3JKuX87/1gn77okLn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dqeDttZ5R8RrO9AOk7PvZzirXAsOheagYnlTV4MdwszR4Ydgzf4XTbTCrtZw?=
 =?us-ascii?Q?WXvDz/KxNfe63iqUbgKFpelJTXdrk5ghzDlxBsgsj6dClqi5rRPJZHocAluP?=
 =?us-ascii?Q?gXMfVEX3BMfQrcQ8dxzQ7mtmD/JiyvRGsejz8ne4LFB1UkvWF7Ug1jL+1seV?=
 =?us-ascii?Q?q+RqewWBvhLXn0O70njYWT+HAiyJHGPR/tV2Wx02Ij5VD7/bcSTM2HKLrPiT?=
 =?us-ascii?Q?tgTy9mrQn7Y+ZpGHegygMYSaF8mhulkPuVvhYYqElrcdxnrYQqevUrQuTvOl?=
 =?us-ascii?Q?iQlu9ei0rgxH37T9y5dNs7hZDpVxBPx6fbEt6Bonsoss7FcRdZ8kb8KxU1Xw?=
 =?us-ascii?Q?H3SluCepbqVMgKmGarNvNS+shKZJuQEyaCR4u+VztfyhHACMT+T+/x8jg+na?=
 =?us-ascii?Q?Uv90uHsaACHys8P5xXTMh+PRo36ytW7L5gG45NDwa9csKvXiwPccT9SydxVO?=
 =?us-ascii?Q?Yf1i9I4ZQt0ZxPHXeGfPytpgpMIfCH82mbDdTLUlwBzOxIxupZkFGGjJ8FFZ?=
 =?us-ascii?Q?D2pSgu+HI8YbGwJTiofnkj2Xu2FwVesZwieWCQMUyMy3BJsK1ktj8g7Tm1H1?=
 =?us-ascii?Q?KXzmMYYRLQ2QCJgbpR/7i3PESi6/oOofeiPd6KxSjDkg4odj0+jTXPC1Sm2T?=
 =?us-ascii?Q?tXxO4lPPwbjgO9RGh1meHkfl1TA0Gfe+pr/J3wUto/fP33zpXs4MSELWQ7O/?=
 =?us-ascii?Q?cGW2Q8JSGyDFZXnkWzwW6q2erm46oXLATETxEzRyS2OFCa0S+nOtquqvy9lX?=
 =?us-ascii?Q?HFD6UwZXzsLHDALVGQzB56tWvkY2wPDQBulQH1R+7HEXUTqKOmTnkqRnjAyJ?=
 =?us-ascii?Q?DWCfEdehnE6eyeGrmb7llViAmwgYEYbxskbeNJ2EUI+rEx37s694jMYx4T/E?=
 =?us-ascii?Q?F+zV7mORIUV9ldMVELUgGPyr1F39Iur8U66Bt28Ahabqkhaz1QBrsmDqmTxF?=
 =?us-ascii?Q?DqMwwW0xJT7kIALgMyR5TtzXJP7861Sv20iiwIqMaEPckOpXqxwlz6cfqHII?=
 =?us-ascii?Q?QNCA45RdEgl02rB0wjziSp61sqh91kk9siWvIN3gmU07nfl877YT+E7CWUbR?=
 =?us-ascii?Q?7ZLNuhpt0tJYZ2Etn5FESH2YUCEZIDbbugAfTfxxDT3+R4KUehNpE/tqpoon?=
 =?us-ascii?Q?KUlwzZjYqx3HflkRXVy4hDEo3r504AJM5O6VDBu1hbJ5qVfLAh62BZ0p/wqf?=
 =?us-ascii?Q?dDmzFiAh9vNui/+aQXsQjw5AOrq2X3na50eZIIA5YlKoUpsBw771P2KuYUUm?=
 =?us-ascii?Q?PodU0Y4T4on/7NdrqFOkP7UZ0j+qm1oM+zcAN8vbhOO8bLKBMNpFCwsyBkmc?=
 =?us-ascii?Q?hk41ffSyrzJIM3LhfLOdXgToHDNFnAxWgPJ5Apv/Gr4dig1yMVhpU2CtYd3Z?=
 =?us-ascii?Q?89yUcwzJTDqmSrCRRp7xPGXeOUnnTUtSQemLXQINjk7Qw4fnxJ5PYNu6/f4k?=
 =?us-ascii?Q?dJp4j/NI4FG5YYPA+DAKtqbp5mxA9IU5A9XrhD6jOxfEbw7CcP+pz4CdNhzT?=
 =?us-ascii?Q?caDCNPApWOWI/04MsNdEiqzpy0g6L+gQ3GNOegYnCQ5PLEHRa7iSFfHPd5Z+?=
 =?us-ascii?Q?hpj3BbKFhkWamLazOn52xDmzhx8pPTL6LNHFS6Ah?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cf0e75-d613-4cff-d61f-08dd3146414c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 07:13:16.9288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1t6PF10ctVivk+CS+3Ouwj58kj0Qx9WTRuBuRPbdIcdfjKgxnUaPclEkDcf1JGRjNNYRjwHnz11AV2rOFz4Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, January 8, 2025 1:10 AM
>=20
> With the introduction of the new objects, update the doc to reflect that.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

