Return-Path: <linux-kselftest+bounces-35728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D8EAE757B
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 05:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBC917F2EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 03:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CF21E9B29;
	Wed, 25 Jun 2025 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bh50RkgU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED18156237;
	Wed, 25 Jun 2025 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750822993; cv=fail; b=Ii6BKIljtjt89h1tOYVAMOHK1epp7Lcs7fvWYpfVWJTIe2N0386Mx2HOcTxCGHwSKtiZ1xmiXamP1I7+eAaQx5s6uT3nD+448fpjIktv0CNGG1oVs/aywgUVyjmhY1Wy5FPQonqou7LIf+YQC5dyxAzKI+OrAzDNsmRhzPVv7t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750822993; c=relaxed/simple;
	bh=j1EoUG/RZlJktbtNdmkKs8bJyfVh9xcnNMhSQwS1hBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eezs+NHvgyX/hATLzX7sYK7Ha6wnxq4ASncgbi6RwKm6fANHJzNBSa/n1LS6TPlqBb9+CM3EjFl7mStz2QZZd0t56ArC0HV83RhKvsdebNJaCDzJiEDRq8bq0J2AHD/gtEixxH5IypqLnpUpEbHhPCQ+fLoz+3aYsRgTSGzCgzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bh50RkgU; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750822993; x=1782358993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j1EoUG/RZlJktbtNdmkKs8bJyfVh9xcnNMhSQwS1hBg=;
  b=bh50RkgUoKUGKxCgiDbTzhjaER9NPkKdzmFo+tcLteIfrwIMP9QBPS/G
   Lj8MvPX4OaUh2uvssGd6DvtO2R1hF/KFGb0dal9KbD0aNpfG8WyMNLHBv
   WbaXjw21vP0dmvUZKMJwPL+9k21xkBSZCVnOPlE3zUKCEifikewKoTWR1
   vC2Qo9QCUcKiRQlXrfD79EEaMPsHszh5flGPHa3o7G9e9QreA9zMcd/uw
   mijHxAl+VUyUXLXVE2n6e++7+DpfuYZ3lKQdGvtyZpXH5kAdAf3wf4NPn
   DaUAccsrzYiNF+9KdyahWE09zdMGaQSBouPbGF7sZXq7wiQdu6SSaJdZD
   Q==;
X-CSE-ConnectionGUID: u5b96YqnQh6tx51wJNlCSw==
X-CSE-MsgGUID: KDZnCt34REePVpSbF64AAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52799421"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="52799421"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 20:43:12 -0700
X-CSE-ConnectionGUID: HNpPqoZpRSGv8sO2R6i6aw==
X-CSE-MsgGUID: pMWv6oWISoirJ3J0Zsx70w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="151845611"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 20:43:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 20:43:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 20:43:10 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 20:43:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1nLLz/YOE8RR5UiavLIyedTu9bhNPI6636MBlslK5fX4PhYuwIIvMkU6cRUwHApzDhMfpUVQZKgSNvyk3K+6oN9lbo4uBndxdBlDfQgm9O/i0Gj3Znvs1cjeymsFrPrLd9oFP2tKnyvEsrOZmWDkymW2db4tHxuF2KmK0O5SROTGxDMA8YsAVfniKm9tNwX2YbcgqB3R90Ff7oUpxzfpERc+b+QqXD5No7d2vYMCAYL7aqYXlR4Soma+zEz2ratpuFDfZGwde1VQF3M/T6A0dP1h1p41xDW4TYx4xnfP8vpRHub59LkJuG2RObpeiNXsEkUzpGXf7I8SJF+asmhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1EoUG/RZlJktbtNdmkKs8bJyfVh9xcnNMhSQwS1hBg=;
 b=fMsj8NWbRBuUB9KOEi3mufcNjHwNIidbPkstLsTgHugE/4Da7EEX7UwxhNQamUfOliIpYMPs5UI+TRKiKEkJRasXoZxqQ97RUPgLk4yGu6aQJG9NAXyKKtUcC8wcBrlPdBY394L56Dq8Hq9Rq8dmG5RNqcU4YlD2X7Thf/RuhRrBv/P5sEOL2A4e7jjVr/jmUpSnkInWVAIKLqh7eTfjbLR/dqRAg21tZD9lzMqKpDUSKOq28tC0h8jRxoXmfoOqXqtj+TGAopG8jKIxsmo1QuCvO+ORmVKNW8qryh+mhsueaBTKMjHciIijs8f0hfx+LsYKwHnsyPzddgRXvmPUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 03:43:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 03:43:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: RE: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Thread-Topic: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Thread-Index: AQHb3Pwk993zGbArDEiQjdZ3GEWFVrQFUTAAgAAJ0ICADfEcgA==
Date: Wed, 25 Jun 2025 03:43:08 +0000
Message-ID: <BN9PR11MB5276002043AF3D0970C7AEF58C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
 <1ab8030b-8d2f-4ebe-a280-6d0e4e1d17c7@linux.intel.com>
 <aE+976F9zPsjtfry@nvidia.com>
In-Reply-To: <aE+976F9zPsjtfry@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8449:EE_
x-ms-office365-filtering-correlation-id: c0406783-2c82-43eb-4a96-08ddb39a668d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZHNaQVduYkxxZ3RYazVSSlkwUkdxT1VlYWNXb2o0SkxSUFFEVlZjbUUrSHh0?=
 =?utf-8?B?S21DQ0xta05MRldTOURmeXpZZmlLTWVUd1hIaW9QOTdPekdPRE5EZlV3K3Ju?=
 =?utf-8?B?WW55Y1g0NFBXREo3bEVWYzdqaGNRdHk4aE5TMHVEYWpLUEluNE5nUGVuZ3Ux?=
 =?utf-8?B?T3J2cm1nR3RpbFA1V1lUdEtJZGNPTUNEYUd0dkZsWVBPcHk5WnRNNWFpVEJ5?=
 =?utf-8?B?LzJZQWtBQ2ttUHl5MGJ5ZzJaam9aOXNGMHdrZmtBKy85ZEJpTnJlc0YzcFhO?=
 =?utf-8?B?cjRZZjAxbnNFN3BnOGtOM0d5MktSaWxwOS9TRVVTcG5qdXdBUlgrNG5YenVG?=
 =?utf-8?B?c3hPdHVUN29ESU5WQko2Q24vd2pGVjV5YVZsdXdic1FYT256VHFRV0J5bkFR?=
 =?utf-8?B?NCs4LzJhUzdjVWo1TG1uK0x0ZFN5bW5WdnBpdVJ0MTRRKzdPZml0QmZSckhH?=
 =?utf-8?B?dzlYd1ZhS2orL2pncGo0OEIweWZlaEhXUWFKeVVVc1BZakxLOGduV0hGcXF5?=
 =?utf-8?B?MEJVaGh4dFNUZnFKYkxaUGd4R000clY3S0g0VUhJbWdUL0h3dXdvbVh0TDJN?=
 =?utf-8?B?OHZpRmhBU01ibC96cExjeTdUbDdJdUJ0UVdlUVNwR1hiUVpUQnp4SXo4MWdC?=
 =?utf-8?B?eVpDTHJ3bWtJQm8wNzkwQ3o1L3dCeW9Wd3ZrZFNYKzFWaFEwMDMyNGN6L1BD?=
 =?utf-8?B?RThVMVZadmlMbzJicUZFREtFcC9xbHlLNzNwVThyejYvMUo0eXdEL1N0M0Ix?=
 =?utf-8?B?Z2JQNldHSURQajBwbnRxM3hYV0ZlcjdRQXpFb2tQb25CUkxsUzZHSGZmQVJN?=
 =?utf-8?B?SEMrV25lQW0zcnpqb3dvM3AwbDg3TjJUTkdpaHFidDM2ek5oTnlHamxTTVVN?=
 =?utf-8?B?ZHpMZjF2R0RpdndDb2NPRklHN0NROUJoR1F3VXRxWFFua1VIclBIUmtLOXNh?=
 =?utf-8?B?eUhISTUxSFNnRzJPdDMzcnRhOHNOK0JIK0tDQnM1a2ZTT1dTM3RSUFg2djhQ?=
 =?utf-8?B?dlJDVUlXNXA1OEhFM3psNlh4UllsL2wwa3VTR0hjWlN6RmE3TWNCcVlHQ285?=
 =?utf-8?B?dDJxY0UzQWJySW5LTk1vVzNuT3dVbkl6ekYxRmxQMWM1ZTJUQUZMRWh3TURi?=
 =?utf-8?B?OERyeVc1K3Z5Mk1ESnZZVkxJYWRxcG5jaElJWCtUYnE1UEFBSlR1VlZiTUwr?=
 =?utf-8?B?a1FwL2hZSlprQVAzVERQSW5OZ0djbFo2Tk1lemtCaHZTZzhhNHJHTmxpR0xU?=
 =?utf-8?B?VzdPdHRyLzFOdURkN2tVeHUzYy91blM1VVh6dG1JRGVXSEF0NEEwREVPSS8w?=
 =?utf-8?B?MXRkaWRrSVZZQ1ZxckR6RnZGTXZRemZFKzY4elhURHdYUFNoZ2tmcEMrc0N1?=
 =?utf-8?B?MTZuSjVWNE01ZWxDOTh6dGc4Sm5HZFZwbmdIeEQ2YkdabFJHRkNDbjRKMDV6?=
 =?utf-8?B?bjVRL2xDakQ2NE5XWTc5T3E1dFBhcDFlWnJ6Y1YycEQ3V2N1emVqMnNmb2VB?=
 =?utf-8?B?NG9QWHZTaTVkYzhxUEFJbGZsZVE3ZmczWUVLblRHWnZ2RTMvOVRjVWFjTkJu?=
 =?utf-8?B?UHdzcWg2SXpzejN3T01YbzVYTGpBcDFJbDJJNGZiZHFMY3I2Y1VJRTRkSjFt?=
 =?utf-8?B?MVRxcmZpQUR1MTEvdTh4emF1YkZyZ29iQmoyRjA2MzkxeXFTUEliOUFqUmwr?=
 =?utf-8?B?cVh1cjRHYk1JelU5NHFMbkhPbmdrcXNDU3BsbW5ZcmhIN0FNSk5tWDdFOVZu?=
 =?utf-8?B?UjFHOXBpWXArcW1zWHJYVDdNeTdmbW0vQm5HVHZ6MDFSQW9DaUxLM0RBb1h3?=
 =?utf-8?B?S0dsVkZZaGd6aEljUHBncWRMd0Y2RDdUZ1BLZ0xBMlkzU1Z2a1h0SEhNS29T?=
 =?utf-8?B?dFFlZXFnOUFSN0pHWmpNRFR3eTl2RnhHUTFVUlNhTjIzRGQ5THF6aXJBemR4?=
 =?utf-8?B?YTZLNnlIWDVTdWJwcWJmaWVlc2g1dzBXUWRBdHhRTEZ5SEJMWnZsNXgwSkFr?=
 =?utf-8?Q?nWBEx3coKkfWmrEAnP5fjNi9MedxFw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEF3K3gzaDhESGxxNEdQa2ZIOEtUbHJNai9mVnFBVkc2Smt0ZkoyeHp6YW1p?=
 =?utf-8?B?QU1xSXFRZ0h2a1gzK1p4bW9kcVQ4aWFFV2kxNDFuZ2c2QlVva2toaEh0NGZD?=
 =?utf-8?B?VmJPQmVRVy9nVWhxTlpRS2JhQWZUSGNYUkk1OVk1K0MzTXROc3VXb3I1b1ZU?=
 =?utf-8?B?QnhVODJka3hKT3QzR2JnNTBGbVFMaGRsSGJmZEx2N0J4Z01aUGQxdmhDTFBT?=
 =?utf-8?B?UVRsQjRXZ0pheVdaZGpTL2xzUG1UdEwwdVI4Mnk2SFI0dmgrNXJQbTc3VjZp?=
 =?utf-8?B?M0FUQWdTNXBFZWNmSHdETys2NzVJWVJlUEhIZlptM0txazZNZklLV1YwTHpG?=
 =?utf-8?B?MWRCZGVEYkNCbHg4bk9lcm1iaCtjUGNob3doRG5rcmEwWjY4YTBmSEx2WXhy?=
 =?utf-8?B?QUpvUCtaRVExRzRTcGpmdkNZMDlsMkVEYTNpY3BvZWJpZTE3YUIyZXVGV0Qr?=
 =?utf-8?B?QkxMMXQyT2N4WWljQWVzUmtkRFRzWXppZUs5STd3OUpFYXI5dUkwZlBCVEhM?=
 =?utf-8?B?Lzk4WWM4MTF6UVdhTUdCNkk4OFdvOEZnc2dWV05UdGNQVmJycDZ6Y0JLcXY5?=
 =?utf-8?B?RThzY2l3TVZIbFZWbWR2WkdhUzM3eDhpS1ZMRG1JUkUrakZwS1Fkd3ZoVEFy?=
 =?utf-8?B?OE1pdmthcTVXNnYwSjJsNGljQkVqZ09WbExsRGhSYmUrOVV5ZGpWQmpkSEtz?=
 =?utf-8?B?dUtmbjRxcGkwOFhoVTFOTzBCTklmcE5PNmFhZHpaZTlKN1RtQjZRemFiTGsy?=
 =?utf-8?B?MUhXbm4vUXlzSGVFQXVHdDdPRjc2by9YeFBwdS91L0Q3b0FQNDZRZVFrMStq?=
 =?utf-8?B?SVhLODlCbXFVVlBRUDNrME51a3R4RFlxWGJWWDdmRkVGRnlSeHhRbnlZdkRF?=
 =?utf-8?B?bm9wYzA4Q2J6azEweElYUmxWNDk2VHBwR3VlWHMwZjIxdGkxQmNpUUhIS2lK?=
 =?utf-8?B?TncxLzdQSGFGVmJNNUNJZ0lNM3hSTmpaNWRYeHVxNjNYb3FKSjFZNHZxTWNo?=
 =?utf-8?B?Z2lzUEJFdEdUS3dnQkdPaWRWdmJlODBaUjl1eGxtUnRxd1huYlZjU1hqT0FV?=
 =?utf-8?B?cjVJNG1pVm1jZjh2L1p6R1RtVytTbFQ4UWN1U0pYMkNMWlBFMWNKQWdzdmF2?=
 =?utf-8?B?RzZYanV3WGtEMmd6M0p2V2IxTlBxNW43cXdEV3NUdHlpa3I2bXBiTk9mZ01L?=
 =?utf-8?B?TlVaT1pNeEJ6NkQ2MkJ0VGxlVTVOa3Qyb09JVzZaSEVxNDQ5OHRmcm4zOGow?=
 =?utf-8?B?TUNmalpkQ2x2V1NXSmxVRy9JNU9EMkwreStzazAybnRwYWZyWUM1OUV3MnFL?=
 =?utf-8?B?bkVXa1A1RFNkbkZYdENRenU1V0lTQXBuUGxPanpiMlFoMElzSEpwQVR2dWRq?=
 =?utf-8?B?Z1lZVlREQjdqVjFHMy9aL2dXQVREUjNOTno1MlhzU3ZONC9kOEUzaS9lQ09R?=
 =?utf-8?B?OUdVVjBqZDBub3JUT1IyVVVRVkk2NGFudUhLald1ME45bU9XTDBpaHZKa0lW?=
 =?utf-8?B?NitEWWpNNWtYUEl0d1AvbjNqb3pYZkszMkc4aVIzeUU2TUphY2RFaGVtaUk1?=
 =?utf-8?B?KzJtbmNrN0MycXJyUDFoZVhrNk1adzVJUE5may8zbkYxWEJUYTI0MFdEdWdO?=
 =?utf-8?B?R2djNWVpMnNJc05sTGMzTUN4N1I5M1o2TDZ5N0RCRXNHdVMvaFJBbENEOHVm?=
 =?utf-8?B?eGVQeXhjU3pvVXFIWHR4NGwwZDRsbk9ySTBoR2xHN1NZaVBoKzFEWUFjRHR2?=
 =?utf-8?B?SjhXZmllU1I3cGpxMXNvZHVqMnNySXI1d2NYbmFlRGNDVlE4aFRNa1pzYk1a?=
 =?utf-8?B?VkQ4elBNZmRrSnV2MnNrMXZPREI5S01wU3YvRWM4RWdiVk5DKzg3SXUrVWZa?=
 =?utf-8?B?STV1amN4bDZoUzg3Q1dqZUZOMTd4YjVoL1JYQ0FkaUsrV1BPRnVzSGtUTTgx?=
 =?utf-8?B?OVMzTGpHWWlOcTRvbWdNek82U3h1bGJkYWMzSjFiSFQ2dmUrTTZhRDk5SDds?=
 =?utf-8?B?S1RuN0tvUFZDOVBZRTBLNnlaWkszVmNnSitUTzFseGZ1aEJ3bkJldElMUTZh?=
 =?utf-8?B?SlNLUW96Z251ZkZTZDMyVVlBOHVCWVJXNUJHeW9UbksvbklDNXlBY3Q2dnV4?=
 =?utf-8?Q?5ELkNSojH2+/N8dtgUSr31kkf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0406783-2c82-43eb-4a96-08ddb39a668d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 03:43:08.2898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDLFlOIvUEuG1ywuDx52Oqyr1jDxNF1qYbDORjAk9g0+Blb1XoQd59Cczksng6kNJ+3ucCkj0nDMsU/SoboWcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgSnVuZSAxNiwgMjAyNSAyOjQ3IFBNDQo+ID4gTGVhdmUgb3RoZXIgbG9naWNzIHRvIHRoZSBw
YXRjaGVzIHRoYXQgaW50cm9kdWNlDQo+ID4gb3BzLT5od19xdWV1ZV9pbml0PyBJIGd1ZXNzIHRo
YXQgd291bGQgbWFrZSB0aGlzIHBhdGNoIG1vcmUgcmVhZGlibGUuDQo+IA0KPiBUaGUgcGF0Y2gg
aXMgZG9pbmcgaW4gdGhlIHdheSB0byBzdXBwb3J0IHRoZSBod19xdWV1ZV9pbml0X3BoeXMNCj4g
Y2FzZSBvbmx5LiBJdCBpcyBqdXN0IGFkZGluZyBzb21lIGV4dHJhIEZJWE1FcyBhcyB0aGUgZ3Vp
ZGVsaW5lDQo+IGZvciB0aGUgZnV0dXJlIHBhdGNoIGFkZGluZyBod19xdWV1ZV9pbml0IG9wLg0K
PiANCj4gSSBwZXJzb25hbGx5IGRvbid0IGZlZWwgdGhlc2UgYXJlIGNvbmZ1c2luZy4gTWF5YmUg
eW91IGNhbiBoZWxwDQo+IHBvaW50IG91dCB3aGF0IHNwZWNpZmljIHdvcmRpbmcgZmVlbHMgb2Rk
IGhlcmU/IE1heWJlICJGSVhNRSJzDQo+IHNob3VsZCBiZSAiVE9ETyJzPw0KPiANCj4gSSBjb3Vs
ZCBhbHNvIGRyb3AgYWxsIG9mIHRoZXNlIGd1aWRlbGluZSBpZiB0aGV5IGFyZSBjb25zaWRlcmVk
DQo+IHZlcnkgdW5uZWNlc3NhcnkuDQo+IA0KDQpQcm9iYWJseSB5b3UgY2FuIHB1dCBzb21lIGlu
Zm8gaW4gdGhlIGZ1bmN0aW9uIGNvbW1lbnQgaW5zdGVhZA0Kb2YgYmVpbmcgc2NhdHRlcmVkIGlu
IHRoZSBjb2RlPyBhbnl3YXkgd2hlbiB0aGUgMm5kIG1ldGhvZA0KaXMgYWRkZWQgaW4gZnV0dXJl
IHdlJ2xsIHJldmlldyBhbmQgbWFrZSBzdXJlIGl0IGFsaWduZWQgd2l0aCB0aGUNCmNhdmVhdCBo
ZXJlLiDwn5iKDQo=

