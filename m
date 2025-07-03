Return-Path: <linux-kselftest+bounces-36372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178FDAF6947
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 06:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504E04E053A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 04:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA11328EBE5;
	Thu,  3 Jul 2025 04:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jq77rba1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4E28DF46;
	Thu,  3 Jul 2025 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751518674; cv=fail; b=kPrrDjnXWDTUOYQGaWf0mFIc5EIIKtVXVLmV5EoHq6Wsj4rKEHbdGhvBdQuw3QgzkUnoAhWApYQow4bEXxiogs9evrC9wgZmkgWCdFm+ach8jyhjpMvEtSbKGUgSSxTdsO9nqFxz+Az4B6OrD6HF9MknKFhchRl0JJFZIBQ6IOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751518674; c=relaxed/simple;
	bh=Kf6qlfqmYsI5FK8/BIPHya48Slr2/LcvkGx9akd7ExA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mzJgA8ARg/u5lX2HoGS3ngvkMJ3oxz+GngUgXaWatdSnPUEb1/YFi9+aJhNJb/0WQsJ/obPwZMiXlhWXTQ70+1dEJVmMWp50XOoqGiOkC80QoF5e0xnGQdn3Y8tfAdOoY6hxolIIFXOW1JoGk07CCuMUezWDkm1YH8r0y0xCGcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jq77rba1; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751518673; x=1783054673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kf6qlfqmYsI5FK8/BIPHya48Slr2/LcvkGx9akd7ExA=;
  b=Jq77rba1aDqGcd8eFKLwYqMMnmmvJRiEvswX9n0iK7ffkQDKJUVFvZW9
   YORCtSx+HVcA5k34W2pukSn/zt98CJE/d2K0Gi5qOFjY5ORs9XeXRrRzf
   ur8wA7bxqwDONgCKExHZ6Z+Fyg6psMI2slMeA8aPlmmwYni9XVrTt83oz
   cm0pFjbHXnEoWaApaNgMFeBGveEDEqVzTi6MhrcRe9Xjb/+5+2OfVBvq+
   Xvw3aXAfpWEt+EpLab2WIx62zsIICB/b2kiren1BHA7CMJxA/n+kNxqVN
   PDhLP9HHXJ1Ks40Nn7DzIiq/lSvsrYvgMJ+dtLbUip5RuZy5LCVwdJmCT
   w==;
X-CSE-ConnectionGUID: ZgATuFIuRWedS/wV62g2lQ==
X-CSE-MsgGUID: 6qJPa54TT0mzdiEcegoeFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64879844"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="64879844"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 21:57:52 -0700
X-CSE-ConnectionGUID: aE/d+kC6R4WsviDuZ0g1zg==
X-CSE-MsgGUID: lrsrbHVWQ26TjnPZ9XzECA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="153674195"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 21:57:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 21:57:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 21:57:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 21:57:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8YUcZDrFv/kK36pSoqdl0p1JsY7mMFiWguMfegJ2nvv7LFVLFYz7yM51tbur1WP6+zxZ/6y3vJk5dgG8ojbtermxrS84gieRD8/cd2qULpfB3fO/eHa9sNDJ3Oc3IehMRJlz5PLsiVAItW+ZV7VRnGT5LptxNkOHnvZAgzevy9pOMJJZsyD4rJjdObkWApBq4J8IQ4H8kr8AB+sroif4dLG+YfcTz8PPTg4D7vmKiB5QTlZ8VJKuxO3+eW3DoxGWbz7RdYzFnhb/lkAoVY3LGdP1eU73c/nCHaB+xv2xlKzyZISfxygk5+q6t91lGtWm5+ymQNfPHOGjvFVm0AMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf6qlfqmYsI5FK8/BIPHya48Slr2/LcvkGx9akd7ExA=;
 b=NLdzaUnUyAEnR9wOjL/GkCOXr4SleNIXpk7+f7K11hoqRRYsHf8xqIU4I9dyaSG4goTcreMoZYuQLZ9mMalx7BPTlCdIha/boJ7g7+wiQkcJEhb26NHZdwhUOPATLcpMFCJHTUywrAyPuqHQ6oBiOZKvEFZAb/wDc2q2lC0pxJBQcwgL7NHY0u40h2vBvRbEcmeqmvFPq4ljWuuSP+O3DR9aoGyiwVIq5vlfI1m7hXTvjVVNdIwtOMN6lBwWTyvI3LTvSw8R0cF7lfYrvXCzuHJb0WINC+iWv1c1u+VYJzW8CFOxvJUyWpRTWjI2RQ2X8CDq0qcZ+A2d6/5Ze1yK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Thu, 3 Jul
 2025 04:57:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8880.029; Thu, 3 Jul 2025
 04:57:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
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
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v7 10/28] iommufd/access: Bypass access->ops->unmap for
 internal use
Thread-Topic: [PATCH v7 10/28] iommufd/access: Bypass access->ops->unmap for
 internal use
Thread-Index: AQHb5tGEgdXsGNB3/0a+rixMD5qoAbQenbIggACvzoCAAJBL0A==
Date: Thu, 3 Jul 2025 04:57:34 +0000
Message-ID: <BN9PR11MB5276BED9EC2F89E805F6BA678C43A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <a2b2a9704d7efff717448cbb76695e83f2fe67c9.1750966133.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F03CF1E97173E711A5288C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aGWSkRX4yUuuOVZ8@Asurada-Nvidia>
In-Reply-To: <aGWSkRX4yUuuOVZ8@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB6045:EE_
x-ms-office365-filtering-correlation-id: 0e686636-a42d-490f-c791-08ddb9ee2026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y24rYTlwOFQyN0xLSnB3RnpkTDVXc3BVOTVlSi84WkdqK3VSMnY4MmtCQzl2?=
 =?utf-8?B?bHZVOU1XWjJRRWxOQUJkZFNwQ3p4Skh3cFZFQk9WMFdhcUZWa2ZIYWdicC9k?=
 =?utf-8?B?c2tzMXdtQjdrRlE3L2E0MkdocnpjNHZJZG5hVFp5bWZTUEVjOVg4em1FQTI3?=
 =?utf-8?B?WmlaZC9DZUUvK3grbXlwbFJ5SWptNzY1SG5uMjdRWlpZZ1NwU0FvdVU3cmU4?=
 =?utf-8?B?Y0pHUEZ3TVI4N01Pcjl5bnlXQW9TN3hqZC8xOWdDMEJzeE9yQWdQNnI2U2l4?=
 =?utf-8?B?S2hkU1NsanIxcUJERW02a2s5cXFWa0dXZkxqbGRDcUtPdWttZVpsa3hoVVJS?=
 =?utf-8?B?NW4rOVVvU1pybVM1L05YRWtPWFgwclV3b0RPb1QxZ2xvUnpvWnBMUWJlMnRn?=
 =?utf-8?B?NDQwWk9yN0FOaXUzbGJVUmRLNk5qNVRRZUhrWVQzNTBVaWw0K0hDTm9nR1Yz?=
 =?utf-8?B?azVOTmQrelFpSGtUMU53U1k2aGRURTF4cWcvSEdWU0FHZytBdkZzanZ2Wjh0?=
 =?utf-8?B?eUZWc25Qa2dCUGJwaGVxcUFKbXBNeVFqenhDNWNBRmxnT2pMK3NSL1Ftd0hM?=
 =?utf-8?B?YVFXNzloMm0xU2dvVGs5bWFheDJ4TS9nM2lPeGowdWpHWDVpYW44bUhsRjA5?=
 =?utf-8?B?Zng4aFlOOWF5V2RzajYzdTc1Z0E2cU5WY1RGOVN4UnB5aDMzQ1dCNmVnckRB?=
 =?utf-8?B?anA5M3haUktDQk5SOEpOanZuY2tkUnBHZ01VRmFZV0pOZE1CMTVTSllMT1Bm?=
 =?utf-8?B?ZjJvTWNKQ2VucTlUVmZtYTlBdlN3QnE1eFE1NVFLZWs2WWxJSGtVSE5TbjVR?=
 =?utf-8?B?WjFDMTIzd0xCYkdKM0QyaDR0dysrdG9HUlo3TG13YUhJMUgzaDVxd05ZbHp6?=
 =?utf-8?B?ZjNDRzJUSzlHWE5mTFcvWUUvWFRudFBpS1JUQ0EwWWdnSG10cHFoTW9CazRi?=
 =?utf-8?B?UmxTbEdBZnNJSDhLRGY5d1l1eFdqWnh2TG02UHAxVTFrdGVnUVdHTjlGeWRX?=
 =?utf-8?B?aU9YNTRCdExhenJ3RHhmMkVvK3dYT2JEeGM4TGYrc1g4RDVEczNLY1ZjRHV6?=
 =?utf-8?B?UGl1UnBkQUVWVS9UY2pxRXpQSXl3ZTNqakcwSHhScS94Zi8ySm9aUnJZWVl5?=
 =?utf-8?B?c1ZVY21WTW1aVkNGQ0s4V2g5QTN1RTNvQzlhZHBxUW8waldzejJibWVDK2hI?=
 =?utf-8?B?c2Fyam9DTlgyWFJpbENCYVJ1YjY0ZEowMW1DQ2tsNVpJdnBzSmZwOVBwZVc5?=
 =?utf-8?B?aUJRdFEvL1cvUVg5T3diOGEvMURVSU8yY3d6SFhmYkE1eGdNWnZZSUZxOElI?=
 =?utf-8?B?am95cW1Qc2VTVVBpN1J6UUZyZFJxUFRIbk5QekhUem13aDRvVnNGZzhEM0Zx?=
 =?utf-8?B?cVdSRjNENmtVTkxHT3I5WXoyZ0QyQTlUd010VEZYM05CKzBmWUhJUGRVcCtO?=
 =?utf-8?B?TU9YeE5TNE5GL2xTOFN0UDBzSXJ2YTRBWUZ6K2hKZWVmZGxLd2F0a3E1blNz?=
 =?utf-8?B?d1VGcCtJSDVERHBiR3FjR0h1cmF1eGUxWm16Q2pGMVhxek02WUR0bEIxMEs5?=
 =?utf-8?B?OUE4RGQ0OXdnQjhsZ0E5ZllVY0ZmbUcrckhOcWRvOWo1dVVGTmg5ZFJ3Vmxj?=
 =?utf-8?B?S0t0MkJHbEo3Vy9HQ0ZqS0N6TmZDanR2WDZTNnk0cmhUa1FZK3MrSVcrRlNw?=
 =?utf-8?B?enY3cmFIWWswZHkwdURha1l2bDhGSXNMT1FuTUd2RDJCVUJ5TkE3WGNTcmNQ?=
 =?utf-8?B?dithcU9hcXZvdWZ5WC9FZW1RaTFlRWIrMzhtWGo0bTdDR3RzLzA2ZEUwcWtP?=
 =?utf-8?B?WldZSDZGM1JVT0RTQnNqdW94LzZ2WjYyczFYZ2owOHZ2eHYxYlByenIwdTZQ?=
 =?utf-8?B?aGNwb1h5WG1lRlczQ1dmSG91VUxEYXlnTW1WSzZlczVNa2MwVExGUUR1aDJC?=
 =?utf-8?B?SXdub3V3TGhabGdPNEJNVHdIck44UnhvYnEzOFhPdFM1WC9zTHFMV2xGTE5C?=
 =?utf-8?B?bmU1SXl6SXZ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkVqdDc0Z3lPeWo2dUNza0V0Z1NDd2hubmRkVUl0NGhQWXp3aEJ3NWt6eWpH?=
 =?utf-8?B?OGF0VW1UM1QybUpXSG11dTRHdUtTTVZ0MW9HemQ3bGJ5RTlBTVNQcm45Y2Zt?=
 =?utf-8?B?R1ZqaTlUcmJjbnlSeGJtUmIvdnlYSmNqbGltS2JzM0oxaHErY0h0Vmo4K1Ir?=
 =?utf-8?B?SHZCeVE2S3lmRFFxTTNhWFhBWVo2d2JqTUVFbk9vdHB5UGNMUmJTTXBxQVpG?=
 =?utf-8?B?eG9uV0Izc2RaZnA3dWc5eG1BZE9MeitsWUZXOVZDL0ovcW1ZYmR3V0NRT2RW?=
 =?utf-8?B?cDkwb0Q5WXhQWUQ5UDFaNitCNVhYc1l5V2lSUUpxOGFqUlpoM2FmcHE0NG84?=
 =?utf-8?B?UWl0T0dSemlMNGNKVUVDVmRWZFJaVHRNajYrdzFTNklUQmcvdHFsdSs2bVEv?=
 =?utf-8?B?aHlyQU9UMzE2VHl1V0FmQ21kaHhjOGs4QnNRN3RMaWdnbGhYUDVBSzBiQnZ0?=
 =?utf-8?B?THZ1U25zMjluWUFWL1RCbXlkUVBDNUhWVWpzNlAyY1NsLzlTeHZ2ZWlaY2s3?=
 =?utf-8?B?OTBhQUdKREVGMEhlMUxKTlpsa1gxOG9lRFlqUUg5VXVRdk5LRE1aK3R1QzAr?=
 =?utf-8?B?eDlFdEQzZkJPK3dUbXFsOEpFR2N2Z2ZiSTVUWGZPeHJDdkJHakhReEZ5L3Nt?=
 =?utf-8?B?QlUyMkYxbFJlYVQzRXM5U3lBYkRUSXNkd2xDd0dxQXJwMlF4R2V6RlVVYXBR?=
 =?utf-8?B?Nm9meHdOMThKMlgweEVRcmFobnlNekg0clpEYlNsbGhVRjdObGlFTGdBYUxY?=
 =?utf-8?B?SkJWbzQ2T2VHalRWbXhCNVF6TlUxWnFDdm0vQzM1T3ZRTFZmR3FNUEZ2OG5j?=
 =?utf-8?B?UWhDQ3c1SDRiV1FQcFFFV1pPaEFnYXVrbmR4Unh4aWhUSDd4dk5GY3hSanp1?=
 =?utf-8?B?c3lqSk5LNDJvZFY2Mk1YVEx2bXVSY3dhZWtWdkRDVHlrUXY2dDQrWjcrZ1o2?=
 =?utf-8?B?Mm5oQmFVbS9odTJmSnd3dGhrbVZ0SHhkeXV1bHBod3g5U2VyeDY2ZFNHUGJ1?=
 =?utf-8?B?WTM2cXVjMTNYUXJ0TjN1eVVNZzRtcysxS3g4MldVSmFMc2tqMmZUTWN2SXRF?=
 =?utf-8?B?VGxkc1pjbVZBc1BxRDMvRzFqTHgzbm9pOEdFWkxCeHpPSC94bkV3cGtDNGhl?=
 =?utf-8?B?WHVFRy9TazNoWnlIVnZVcWxKMHdyM0ZHL3lhN0liaGc2eDBkQTc5SHMySUFj?=
 =?utf-8?B?YzA2ZUtJeWpRL2wvWnBBbDduamhqOGJuMXlwNGxLRGFqd3JUSnJVamt2S2Rr?=
 =?utf-8?B?ZVpteXJlaVlhNzFGZzhEbkg1d09SU1JoWXdPZTQ0UzdxdEZiVDErZnc2aGZh?=
 =?utf-8?B?U2F2Vzgzbk9UQWZoUWxjd0R0cXhabjdaVStYNFR1MHRnWFVUelZzekpnV1g3?=
 =?utf-8?B?MDVtcTQyVXRaUkpLL0ZPMXQ5RnRlNGg3RUl6RTRuWFBQSVh6RDF4N2hleith?=
 =?utf-8?B?TTZDYm1Ecm5BOWlIWCtMNE1OTTlGcXY5eFZUaFVhVUVPSmlCTllsRDVKcDVj?=
 =?utf-8?B?U09YRUpDb0dRN3l5ak5oUktpakd5QllnQ1ByQzNlbzZwWm81SDc4S0dEMFNn?=
 =?utf-8?B?NE5qMDB1YlRTYzRWSnYxbHhWZ3hqVTZuWFAzZ2xjRGl0eUgvdk1XR0prMkpV?=
 =?utf-8?B?V3AvU04wYlNLbXFOak1iN0pQNml4WUsxR0xHY1hSMXU5dm1QTm5IdHV1U2F4?=
 =?utf-8?B?MVd5S1VvanBMSm9vVCtEUW92akV3ZE1Wb0ZSdFVHd004UzZhcU9rVEVOc3I3?=
 =?utf-8?B?bytYRDRJcXlyVDQ2VkZyNU80ZVpsVXlxQzNRdHhWVG41WklrVjNMSzEzSlRT?=
 =?utf-8?B?NkJheUNvSVhTQTFsUDZHTGxMWFVBdlVlNFRHNFlaUHFaUkxOR0ZEOFczNWxB?=
 =?utf-8?B?WjhYQlJXc3FZcGo2OThGTWQ1dThsakJJMDNYY2F5Uzl6S3A2Q0FkS2hsMXE5?=
 =?utf-8?B?NFVZM3lFT2dnVlJRNVBsdXVxdkNOc2tiQUlzWTBhL3Zjb2R5VlVTZnlyek8v?=
 =?utf-8?B?am5MaHV6TWRSaktLZ1hwcWIyWkI4SnJDejFLbEdlbmg1OGU0dkRiNEM4VWRR?=
 =?utf-8?B?QnR2Y2Z4OXg2d0xmM0U2VFB3anFoRGNaZ2VCTG1HaTZOa0VHY3RFZ2ZYWXY4?=
 =?utf-8?Q?Xpj3tbeOW1L+uuHD/9GVZy1xt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e686636-a42d-490f-c791-08ddb9ee2026
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 04:57:34.8750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lXNx3aNRLitXrjiOSa3opdAKSIcjMHFDFkG0ikkU1ePpgmU5MueaheHLXJL1D1m6v15h0jTt2ECJxN8f1mDKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6045
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBKdWx5IDMsIDIwMjUgNDoxMiBBTQ0KPiANCj4gT24gV2VkLCBKdWwgMDIsIDIwMjUgYXQg
MDk6NDU6MjZBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBOaWNvbGlu
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4gPiBTZW50OiBGcmlkYXksIEp1bmUgMjcs
IDIwMjUgMzozNSBBTQ0KPiA+ID4NCj4gPiA+ICtpbnQgaW9tbXVmZF9hY2Nlc3Nfbm90aWZ5X3Vu
bWFwKHN0cnVjdCBpb19wYWdldGFibGUgKmlvcHQsIHVuc2lnbmVkDQo+IGxvbmcNCj4gPiA+IGlv
dmEsDQo+ID4gPiArCQkJCXVuc2lnbmVkIGxvbmcgbGVuZ3RoKQ0KPiA+ID4gIHsNCj4gPiA+ICAJ
c3RydWN0IGlvbW11ZmRfaW9hcyAqaW9hcyA9DQo+ID4gPiAgCQljb250YWluZXJfb2YoaW9wdCwg
c3RydWN0IGlvbW11ZmRfaW9hcywgaW9wdCk7DQo+ID4gPiAgCXN0cnVjdCBpb21tdWZkX2FjY2Vz
cyAqYWNjZXNzOw0KPiA+ID4gIAl1bnNpZ25lZCBsb25nIGluZGV4Ow0KPiA+ID4gKwlpbnQgcmV0
ID0gMDsNCj4gPiA+DQo+ID4gPiAgCXhhX2xvY2soJmlvYXMtPmlvcHQuYWNjZXNzX2xpc3QpOw0K
PiA+ID4gKwkvKiBCeXBhc3MgYW55IHVubWFwIGlmIHRoZXJlIGlzIGFuIGludGVybmFsIGFjY2Vz
cyAqLw0KPiA+ID4gKwl4YV9mb3JfZWFjaCgmaW9hcy0+aW9wdC5hY2Nlc3NfbGlzdCwgaW5kZXgs
IGFjY2Vzcykgew0KPiA+ID4gKwkJaWYgKGlvbW11ZmRfYWNjZXNzX2lzX2ludGVybmFsKGFjY2Vz
cykpIHsNCj4gPiA+ICsJCQlyZXQgPSAtRUJVU1k7DQo+ID4gPiArCQkJZ290byB1bmxvY2s7DQo+
ID4gPiArCQl9DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPg0KPiA+IGhtbSBhbGwgdGhvc2UgY2hl
Y2tzIGFyZSBwZXIgaW9wdC4gQ291bGQgZG8gb25lLW9mZiBjaGVjayBpbg0KPiA+IGlvcHRfdW5t
YXBfaW92YV9yYW5nZSgpIGFuZCBzdG9yZSB0aGUgcmVzdWx0IGluIGEgbG9jYWwgZmxhZy4NCj4g
Pg0KPiA+IFRoZW4gdXNlIHRoYXQgZmxhZyB0byBkZWNpZGUgd2hldGhlciB0byByZXR1cm4gLUVC
VVNZIGlmDQo+ID4gYXJlYS0+bnVtX2FjY2Vzc2VzIGlzIHRydWUgaW4gdGhlIGxvb3AuDQo+IA0K
PiBJIGRvbid0IHF1aXRlIGZvbGxvdyB0aGlzLi4uDQo+IA0KPiBEbyB5b3Ugc3VnZ2VzdCB0byBt
b3ZlIHRoaXMgeGFfZm9yX2VhY2ggdG8gaW9wdF91bm1hcF9pb3ZhX3JhbmdlPw0KDQp5ZXMNCg0K
PiANCj4gV2hhdCdzIHRoYXQgbG9jYWwgZmxhZyB1c2VkIGZvcj8NCj4gDQoNCkkgbWVhbnQgc29t
ZXRoaW5nIGxpa2UgYmVsb3c6DQoNCmlvcHRfdW5tYXBfaW92YV9yYW5nZSgpDQp7DQoJYm9vbCBp
bnRlcm5hbF9hY2Nlc3MgPSBmYWxzZTsNCg0KCWRvd25fcmVhZCgmaW9wdC0+ZG9tYWluc19yd3Nl
bSk7DQoJZG93bl93cml0ZSgmaW9wdC0+aW92YV9yd3NlbSk7DQoJLyogQnlwYXNzIGFueSB1bm1h
cCBpZiB0aGVyZSBpcyBhbiBpbnRlcm5hbCBhY2Nlc3MgKi8NCgl4YV9mb3JfZWFjaCgmaW9wdC0+
YWNjZXNzX2xpc3QsIGluZGV4LCBhY2Nlc3MpIHsNCgkJaWYgKGlvbW11ZmRfYWNjZXNzX2lzX2lu
dGVybmFsKGFjY2VzcykpIHsNCgkJCWludGVybmFsX2FjY2VzcyA9IHRydWU7DQoJCQlicmVhazsN
CgkJfQ0KCX0NCg0KCXdoaWxlICgoYXJlYSA9IGlvcHRfYXJlYV9pdGVyX2ZpcnN0KGlvcHQsIHN0
YXJ0LCBsYXN0KSkpIHsNCgkJaWYgKGFyZWEtPm51bV9hY2Nlc3MpIHsNCgkJCWlmIChpbnRlcm5h
bF9hY2Nlc3MpIHsNCgkJCQlyYyA9IC1FQlVTWTsNCgkJCQlnb3RvIG91dF91bmxvY2tfaW92YTsN
CgkJCX0NCgkJCXVwX3dyaXRlKCZpb3B0LT5pb3ZhX3J3c2VtKTsNCgkJCXVwX3JlYWQoJmlvcHQt
PmRvbWFpbnNfcndzZW0pOw0KCQkJaW9tbXVmZF9hY2Nlc3Nfbm90aWZ5X3VubWFwKGlvcHQsIGFy
ZWFfZmlyc3QsIGxlbmd0aCk7CQ0KCQl9DQoJfQ0KfQ0KDQppdCBjaGVja3MgdGhlIGFjY2Vzc19s
aXN0IGluIHRoZSBjb21tb24gcGF0aCwgYnV0IHRoZSBjb3N0IHNob3VsZCBiZQ0KbmVnbGlnaWJs
ZSB3aGVuIHRoZXJlIGlzIG5vIGFjY2VzcyBhdHRhY2hlZCB0byB0aGlzIGlvcHQuIFRoZSB1cHNp
ZGUNCmlzIHRoYXQgbm93IHVubWFwIGlzIGRlbmllZCBleHBsaWNpdGx5IGluIHRoZSBhcmVhIGxv
b3AgaW5zdGVhZCBvZiANCnN0aWxsIHRyeWluZyB0byB1bm1hcCBhbmQgdGhlbiBoYW5kbGluZyBl
cnJvcnMuDQoNCmJ1dCB0aGUgY3VycmVudCB3YXkgaXMgYWxzbyBmaW5lLiBBZnRlciBhbm90aGVy
IHRob3VnaHQgSSdtIG5ldXRyYWwNCnRvIGl0LiDwn5iKDQo=

