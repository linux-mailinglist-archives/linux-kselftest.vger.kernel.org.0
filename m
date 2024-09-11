Return-Path: <linux-kselftest+bounces-17727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7008E974C5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 10:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C69ECB21A9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546F01547FB;
	Wed, 11 Sep 2024 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6HE1C0Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EBD1547CE;
	Wed, 11 Sep 2024 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042649; cv=fail; b=Tx4dXZrlhA7s3U62AsESK3DBaL/vG2bfr5cJkhSWX29TuiigK1aJu+ImA7TdNIMQpjOVwWc+xivh4kpyeY8BjgV6hO3pwqfqHmtyFC0HnevOgWZidTilCjFvr/Fupd61z7Kdt05Z4y+9SgUNJPVzMeWPiSFgmSQlU8psEJKo0F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042649; c=relaxed/simple;
	bh=7kDr3lI3t9VMU+e8dYijZQXoqhINuRUQwqwtbvshNOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PGqSKQJN6nN+atmZVUMufUeDChIGl5KDjgdY+uDVY2Myx6hGNxHcZv1NnOM8tfGHkp5rgbpPonYlBUGzds6FJhTCdD7+odOGQXzMdWWRzQ/oftlHNjzh92FXG6lDSrvj8C5BSILLrV2DtXdclZ9NJMGegXgIe++3YebsSanORCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6HE1C0Q; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726042648; x=1757578648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7kDr3lI3t9VMU+e8dYijZQXoqhINuRUQwqwtbvshNOw=;
  b=l6HE1C0Qbh7RLz1VB+MuriHrisq/4LZM+lhwTHDZmYdRt68jZu61m0X1
   YYw+GYd6pr2sALL6iKAsh/rbRX7ifh+TVEKyL3vTK5iE0Tk4fGHBBxOvq
   nlyXVrOnbrOTJdQGGlIihzvpYrzN9Z21Dl+N0yORyoZhcl86GstgqBTCk
   296rppXsEu/Qkz873JzwFtcvYCthpAU4Zj+Je8NAOBYvfJvV8RQok0S4S
   SNcLYpIcQguoEYkSWB4+lQhgd5RCmn4ChIVnlW7vosV372v6M1tq7GOz3
   9L5qtDvbWsfAg7mY8Tz9C6qH1wXHW6gIQ087hZ41tvZEZlJMwznwqBPCY
   w==;
X-CSE-ConnectionGUID: nvChglTHStWbf4YOulGqaQ==
X-CSE-MsgGUID: dvDeGoOCTFmeI6kh9VtYyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35397551"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35397551"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:17:27 -0700
X-CSE-ConnectionGUID: R2Rzdc38QSevW0W0E/xOMg==
X-CSE-MsgGUID: 1OxK/IJTQsOCIOQhUatbtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="72095002"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 01:17:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 01:17:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 01:17:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 01:17:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 01:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VL4Sjxny15PZbhWK9D/RiTe8uCxztRy2Rg6/1ofbWtd2udPW40tY6aI+csyDAxCJtWg78KBg8VtbggAhEAkmP6nUmDUZiar1FDlUUc2yYzVmbMqwMUblmd97ThdD7GZmN3HHWiloKRmcokouGrmwDlK+KGe7SPG44dG9xgkaEm5FRz3pqdy/YvDxa82Prn4d0PkI0y2y/F6nO17DWrR6+ip8xUdxdlSlfpd8wFUjL1RYVtsDmG5FhV4Xeb3l0TvQUHeyve2dUwaDA2GMlwZCeO1ug7vCNLqaxGjKvz4Vrt2GtM8ughtBigDawzUnmO4evjK2tNjZQtjSmrR8vvIxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kDr3lI3t9VMU+e8dYijZQXoqhINuRUQwqwtbvshNOw=;
 b=QdYntrh198KT63qLzsBNtEIAFzUPn4rICuvisTSr+Lc/0sTfNrzkEJ8EauXD1lSPEQ/Tk78T+n54KXAKaYV0l1iiFZ3ldbNoZu4oj0qtOMm51HW23LfE+tN88qho0p/t4KmxlmaOQak8tzOAnMPG2NC5QyYi3M/6f3kUg+787WeeUP3OH+ZkTCobs7hD1BG0FPf40d09tjPyYbASyCCVlI/7uCBGoDRhWDGqO8GXYz3lXkz1QRALB1XeI8G4k6JfvXf2lZl0JX2gEPzZrcb5ooeM8K7/d2HsBsuG/JPsrgErEoExMlSuhHZKe7yePmbim2tFuZlnJy0f/fuHIAAt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB7982.namprd11.prod.outlook.com (2603:10b6:a03:530::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 11 Sep
 2024 08:17:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 08:17:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Thread-Topic: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Thread-Index: AQHa+KLw6F1nSDclIE+ushKsvSKoLbJJbdGAgAAb/YCAAAXcAIAIpC/QgAARFYCAAAh6gIAABnbA
Date: Wed, 11 Sep 2024 08:17:23 +0000
Message-ID: <BN9PR11MB527623483A2C981ABCFEEFB38C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com> <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
 <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFEx7mp3v0/lY/g@nvidia.com>
 <bf0a3891-f7b5-4a19-a86d-c115ab2d6b88@linux.intel.com>
In-Reply-To: <bf0a3891-f7b5-4a19-a86d-c115ab2d6b88@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB7982:EE_
x-ms-office365-filtering-correlation-id: 8144cd5c-1be9-453a-91f5-08dcd23a2a11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OUg1NDNDaC94cURqZUtwVFVlaGlrOEtSL3lSWDFaVVNMZHMyeFBFWjBRYTlK?=
 =?utf-8?B?aXhwcCsyQ0hPZXdTYW8rcEVZS1paaXhsQ2FnZ3lBSS9RbnJjWnIxeWdzcE1o?=
 =?utf-8?B?OEZvaEVWSGh4Z1VQNU5FRjlRYWZXSTBINlRadFNpcmZTTnZ4eC9nSHJJbVRO?=
 =?utf-8?B?WXZUbk41MFJRUVU3SWVsQkJKSW9mcG9FZkkyWHdLVFptR1pFbzRKOUxHaVVh?=
 =?utf-8?B?WHg5QnJMT2pYMXh5TDFQQThLRGRUbmxGRzk5Z2JoRXRjTkY2V29naHU2Uk11?=
 =?utf-8?B?WG4rQXAyZHY0elFTVlVhdDgxM1VTRkpmaEVWYVZSd3RYRmlPSzQ4bEEyWEhh?=
 =?utf-8?B?L1ZDQ0EzMzFuMU1BWllKbGZUSGErMTRVd3E5M1hIT2lTeWllSjRZOThncml3?=
 =?utf-8?B?QnNvYUdsaXowTDNMWGpMdlArZXR4Y2VHck53UDRtRzdZOGJiTDlkNFd3NzRD?=
 =?utf-8?B?aTBQUncwbnBlUnpxN3ZwWkI5eWRWOXBCNlNQMlJzOFhZZ0lLcE1DL1lhU3J4?=
 =?utf-8?B?aGdaSTlnMGlVQjhHa0xRMVdNRno3QU1HVUdLZXJQMHlVbW9UUFlVNHpxeDVn?=
 =?utf-8?B?TnhjbERoMEl5UWw5d0ZUby9ZNVNmVDkrZVhyOVJRL3hiZW5UTGpzWXdNcTNy?=
 =?utf-8?B?S3Y1QjVSY2JtRFBNb25BWS83S2w3MndiTVo2NGZ1WVp3VW9GQURUczhYdlFq?=
 =?utf-8?B?bXBuaDZYVHV0Sm9iYXNxRFN4WEFmK3J4ejhxOGxQZnFtd1pVUW9qOUh2VVBF?=
 =?utf-8?B?NTdYQzdRWUFtbUJsQzNTVjA3UFJKbEhUOGY5ejVBUGlLRkR2U3RDQU9hOWFB?=
 =?utf-8?B?VDhrZVR4bDV1cnlyNEZHcDBTTy9oZU91RktaWUJxR0dwc3VNemwyUUdhUVpN?=
 =?utf-8?B?ZkMvanMzVTRianYrTE9PR3k5S2ZWVVZjM2ZqdmJ5K3NqWGRqeGRlY2I5OERG?=
 =?utf-8?B?WjVyL043cFZHay9idGhJTWdNQ29uUTFTQmpHYlkrMHZ1Y2tKaWd1VXZaZmlP?=
 =?utf-8?B?dC9iUG9VZG5FZi9NS3FsN1h6WTZScUpkTVZTU3F3U3YyWGs3Nk01aStLK2s5?=
 =?utf-8?B?UlJwS0xJNUUyMHNGTVZvdHRNeFZrMXF5UVNPbWlsN0pDYklyYUV3ZEtYMzVJ?=
 =?utf-8?B?VGp3Z3M5TWlnckR6Zis1ai8yTUJHUHc4NVhLSnJ1eWswQzJ0bWl1ZHFnUzlv?=
 =?utf-8?B?eU5XRVVSd2IxN3NCZFN6TjhyclNCRTZ5b1dKNWRubHN5aGxwUjN6RTFUZXRT?=
 =?utf-8?B?YVhCMS9EOHdheFQyNG9lcFpzZlJEcHR5ZTA5SWJEd0hteisvRzRZQ09nek1t?=
 =?utf-8?B?NGlMZVRkTnExQVlRdW5yTEpCU1VYOWJncVN0blZWL2JSWnlTM2NwTjZrNU5U?=
 =?utf-8?B?Njd5R0hja1pZS2RmdFBWMnBuOTdVSGIxSlRhSE1XK1FYbkpLa0JFYmVzTFFN?=
 =?utf-8?B?YldHZkdsVUR6NGNTYmtpQmd5WkJwbmZ6TEZTK2d6ZjdzN01jQXVtQ2JvbVBH?=
 =?utf-8?B?S2ZkMlJJVEg3WDdWcmNlc2kwYWNzTFdHektmWFQvQlJTZVBLNWh2REE2VnpT?=
 =?utf-8?B?K0FPVEQ4WHNyTDZBTStCU3dqMVZvZXZWS0F3TkVVUFNRNDQyQytJUGJtamQ5?=
 =?utf-8?B?MXRHSEk2akhFMFFjT2xRUW9CSmo1dnh4RVgxUXNiT3JhazZUcHFiNitjdDNz?=
 =?utf-8?B?MEljRDRaa0lZQTJoV2tXYXVmc2N3SU1VNDlieXFzVjc2U0tOQ0k2MXBtMGtm?=
 =?utf-8?B?OEQyalpOdzJwRElIbXE0ME9PY0c4a0JQRFAzb1RBZFNobWVCbWFHVE5qbVhO?=
 =?utf-8?B?YVdVclZaOFdXTEVwaXlVV3FlUmdXUVBoOGRicGRZaXh3ckRFRTUzS3JHajk0?=
 =?utf-8?B?TWlUSkgyVlEzT3J4NUsyeWFJeTRGU2ZaaXdNSVc3OGRHaGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXFDQm5iN0JFaEE5NWswUmtKZDB4Mng0bmRCTDJSNVRqVUlMTncybktKL3NF?=
 =?utf-8?B?Tkc4RlhRVytXSEFXYjl5R3RYQVJnZEVaN3BQTlUzc3JSbk5QWmpZVWdsalc3?=
 =?utf-8?B?NC93N2JRY3JqNy9uVVBycEpLOHV1cWovLzN5NnZqYm5YZ2ZXcDhQOU5wMkxJ?=
 =?utf-8?B?UG1iMS9KM2ZUSUFNalhlemRhb2kvbWlYUGZVQmJkZHdNU0FvaDVXWjNacHha?=
 =?utf-8?B?R2lTLy9wYmJkZWVRbVo0eU9DOTVkaC9UVlorVnlOMlZ0S1g1VGV3M0ZzWUtQ?=
 =?utf-8?B?ODA5T2ErekhEcTRVVkZGSG92aXU3dEdSMnFJdU5nQ0xrbDJRZFVpTTZ6UVVS?=
 =?utf-8?B?VmpTN2ZYUUhVa1c2UEpxNU9YNUZEWWxORU8zK1YrakFpMHl3UEMrdUpwK1NB?=
 =?utf-8?B?SUdMZTRoMEdCQ1BUcmhrTUFjdDFLakFHRTRqQlI4YVpzZWZYTDJEVkllckE1?=
 =?utf-8?B?R1BLd050K1NtaFVIaUplSWhhNUd1UUthYjJQU3dtQVFxUjBlQXUyNitjUHQ5?=
 =?utf-8?B?Q3lham1iQmQxVHF2YUJFOFZna0o3M0tTZ0lRampOMi9LTURCcTVSSnBzalho?=
 =?utf-8?B?dUhiUXdSZVl1dG1LRmhPS0ZiSnQzVjdzUXBnelpGSFJFM2llN2t2OXFiSTNY?=
 =?utf-8?B?RUVJbHNFd0JlWGpBMi9MaE5oL3RUNnJEQ3FGNHloeEtpZTZmQjJ0N21RV29P?=
 =?utf-8?B?UFI4c0xvWmsvSitOMDFvWGZpZ21oUHR2WTNQaUtGN0x3MXpVZmVuaW85Ly90?=
 =?utf-8?B?N1ZkeGNqZzF5TjVIUmlTOE8zSDdqamxxVjdnWjV2cVg5RWp3RlBubUlkUm5i?=
 =?utf-8?B?WUF1OXJPUzhCdVVRQzdCQmZmV0xRSGxORG5ycjA3NnhJdjl2ODQ3MUt6Ry9y?=
 =?utf-8?B?WStBd1lrNmwxSUdFS05Tc2xPdnd3RG0xRC9JcGVjMjFuOG9qeVNMOTYyZlY2?=
 =?utf-8?B?Qk9WTEd6MGZwKzkzNisrN3o0Slk2MEZQNURURTJ6VjVTSVRKUHp3UHcwU2tn?=
 =?utf-8?B?RWpsTGd4VWhIZWo2ZDJVZG1KNXdCb0krL0phUk55ZzNiZGQ4ZU5OVHNaYkVT?=
 =?utf-8?B?eUtlb0dVUnV2WkgyNUpuNE9LUTRTYzN1OEFZWjArUXYxSng4aVVSc3FlSmVS?=
 =?utf-8?B?em1VeXdFUWhYZEtyV1BUTi85MTc1dWJ6c3JPK2dGc2FtaXRiR3ViY0gyZkpq?=
 =?utf-8?B?M2EwQjNIVzJXMUtGdEdzYlg2T2E4Q25rODFvbzlYTGI2L3ZoQTZ0WVhhN3hp?=
 =?utf-8?B?M05CTXhXeXFublY4MFczUEdYV1pNSlVLVXVVd0o3TndwdERIOEV3MDRPN1J3?=
 =?utf-8?B?YXJMWUFiSkIrdnV6OURMS00xaXhETHNvNXM0QlRVSklJMUFxeE1BeWFySGpr?=
 =?utf-8?B?QTZCR0NUcDdIU3NyckwvTE9UKzJNQW5DekxjVitJbDdqNUFuREFmTnlnV3JK?=
 =?utf-8?B?SllvMVBQRUxXblF2TWxQeVBsRVFvR1pRQVluRjBnSnhFcG5jYk92TVVRNXht?=
 =?utf-8?B?U0N1RnFLTHBKZU5GbFo3U1dZMkpDUDNUbE9lSE8ySVFsc2xiNkJQL0VKd3VR?=
 =?utf-8?B?c3FVSFliaTQ1MTQ2dVRWSVRJZUdodWUzRm1aNEhzYXRBdUV1Sml2NkY0MW9j?=
 =?utf-8?B?Q2NaNjV4OHN1d0k2UnNNcnNtK2dpK0pya1doWGswcFBBRmhZVkR2VXdpaStD?=
 =?utf-8?B?SVpnRTRkemNRbGdNVTViQ2tuQUM2TWlnSnJpNGRPUWRscS96SkpwUVkvd1FK?=
 =?utf-8?B?a1VsN1R1Y1F3NStzaW5yVm9NMTkwOFQxcjIrVU9wUWlzN2xhbmN0M0dremhI?=
 =?utf-8?B?RkU5RU1lQ0paUTF0Vm9La2lEcWRuQ3JtdjZNWGViT2h1b2tVcGMwMzJYbmxX?=
 =?utf-8?B?U0hEYmhzdzY5Nm9SNjJNWlU0ODZTRStsNDRFa0pCQ1FRbDlTK1pqbU9ZZnRh?=
 =?utf-8?B?dFVqemEzOW8wb3pLbjNZNmw5MDhmTlUzcE5UVmkweWpGYUp0MFlvTjRYOE5D?=
 =?utf-8?B?MWdnbEVRWFdQZVFtUDBGRDk4RlJNZVNYTjQvbVpsNmZhSzl5eUFqNW0xakpM?=
 =?utf-8?B?TE55eVYvYVpZc0REc1QwTW1TQUY2WnM4MHB0bWMvbzRiUU16UENscTh4c1Nx?=
 =?utf-8?Q?XCk3uflQY1p5/MUYd6FdFEB8R?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8144cd5c-1be9-453a-91f5-08dcd23a2a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 08:17:23.5227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iax0ZzXmfAt3X263teSrz+Hi62c0ova/ObiiVpoIls7TEtN08/Qk9j+rb+QLTjKZ0BuJcMPjQvQo55wfTB9Zug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7982
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIFNlcHRlbWJlciAxMSwgMjAyNCAzOjUxIFBNDQo+IA0KPiBPbiAyMDI0LzkvMTEgMTU6
MjAsIE5pY29saW4gQ2hlbiB3cm90ZToNCj4gPiBPbiBXZWQsIFNlcCAxMSwgMjAyNCBhdCAwNjoy
NToxNkFNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4+IEZyb206IEphc29uIEd1bnRo
b3JwZTxqZ2dAbnZpZGlhLmNvbT4NCj4gPj4+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDYsIDIw
MjQgMjoyMiBBTQ0KPiA+Pj4NCj4gPj4+IE9uIFRodSwgU2VwIDA1LCAyMDI0IGF0IDExOjAwOjQ5
QU0gLTA3MDAsIE5pY29saW4gQ2hlbiB3cm90ZToNCj4gPj4+PiBPbiBUaHUsIFNlcCAwNSwgMjAy
NCBhdCAwMToyMDozOVBNIC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4+Pj4+IE9u
IFR1ZSwgQXVnIDI3LCAyMDI0IGF0IDA5OjU5OjU0QU0gLTA3MDAsIE5pY29saW4gQ2hlbiB3cm90
ZToNCj4gPj4+Pj4NCj4gPj4+Pj4+ICtzdGF0aWMgaW50IGFybV9zbW11X3Zpb21tdV9jYWNoZV9p
bnZhbGlkYXRlKHN0cnVjdA0KPiA+Pj4gaW9tbXVmZF92aW9tbXUgKnZpb21tdSwNCj4gPj4+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGlvbW11
X3VzZXJfZGF0YV9hcnJheQ0KPiA+Pj4gKmFycmF5KQ0KPiA+Pj4+Pj4gK3sNCj4gPj4+Pj4+ICsg
ICAgICAgc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluID0NCj4gPj4+IGlvbW11ZmRfdmlvbW11
X3RvX3BhcmVudF9kb21haW4odmlvbW11KTsNCj4gPj4+Pj4+ICsNCj4gPj4+Pj4+ICsgICAgICAg
cmV0dXJuIF9fYXJtX3NtbXVfY2FjaGVfaW52YWxpZGF0ZV91c2VyKA0KPiA+Pj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgdG9fc21tdV9kb21haW4oZG9tYWluKSwgdmlvbW11LCBhcnJheSk7
DQo+ID4+Pj4+IEknZCBsaWtlIHRvIGhhdmUgdGhlIHZpb21tdSBzdHJ1Y3QgZGlyZWN0bHkgaG9s
ZCB0aGUgVk1JRC4gVGhlIG5lc3RlZA0KPiA+Pj4+PiBwYXJlbnQgc2hvdWxkIGJlIHNoYXJhYmxl
IGJldHdlZW4gbXVsdGlwbGUgdmlvbW11cywgaXQgZG9lc24ndCBtYWtlDQo+ID4+Pj4+IGFueSBz
ZW5zZSB0aGF0IGl0IHdvdWxkIGhvbGQgdGhlIHZtaWQuDQo+ID4+Pj4+DQo+ID4+Pj4+IFRoaXMg
aXMgc3RydWdnbGluZyBiZWNhdXNlIGl0IGlzIHRyeWluZyB0b28gaGFyZCB0byBub3QgaGF2ZSB0
aGUNCj4gPj4+Pj4gZHJpdmVyIGFsbG9jYXRlIHRoZSB2aW9tbXUsIGFuZCBJIHRoaW5rIHdlIHNo
b3VsZCBqdXN0IGdvIGFoZWFkIGFuZA0KPiBkbw0KPiA+Pj4+PiB0aGF0LiBTdG9yZSB0aGUgdm1p
ZCwgdG9kYXkgY29waWVkIGZyb20gdGhlIG5lc3RpbmcgcGFyZW50IGluIHRoZSB2bWlkDQo+ID4+
Pj4+IHByaXZhdGUgc3RydWN0LiBObyBuZWVkIGZvciBpb21tdWZkX3Zpb21tdV90b19wYXJlbnRf
ZG9tYWluKCksDQo+IGp1c3QNCj4gPj4+Pj4gcmV3b3JrIHRoZSBBUElzIHRvIHBhc3MgdGhlIHZt
aWQgZG93biBub3QgYSBkb21haW4uDQo+ID4+Pj4gT0suIFdoZW4gSSBkZXNpZ25lZCBhbGwgdGhp
cyBzdHVmZiwgd2Ugc3RpbGwgaGF2ZW4ndCBtYWRlIG1pbmQNCj4gPj4+PiBhYm91dCBzaGFyaW5n
IHRoZSBzMiBkb21haW4sIGkuZS4gbW92aW5nIHRoZSBWTUlELCB3aGljaCBtaWdodA0KPiA+Pj4+
IG5lZWQgYSBjb3VwbGUgb2YgbW9yZSBwYXRjaGVzIHRvIGFjaGlldmUuDQo+ID4+PiBZZXMsIG1h
bnkgbW9yZSBwYXRjaGVzLCBhbmQgZG9uJ3QgdHJ5IHRvIGRvIGl0IG5vdy4uIEJ1dCB3ZSBjYW4g
Y29weQ0KPiA+Pj4gdGhlIHZtaWQgZnJvbSB0aGUgczIgYW5kIHBsYWNlIGl0IGluIHRoZSB2aW9t
bXUgc3RydWN0IGR1cmluZw0KPiA+Pj4gYWxsb2NhdGlvbiB0aW1lLg0KPiA+Pj4NCj4gPj4gZG9l
cyBpdCBhc3N1bWUgdGhhdCBhIHZpb21tdSBvYmplY3QgY2Fubm90IHNwYW4gbXVsdGlwbGUgcGh5
c2ljYWwNCj4gPj4gSU9NTVVzIHNvIHRoZXJlIGlzIG9ubHkgb25lIHZtaWQgcGVyIHZpb21tdT8N
Cj4gPiBJIHRoaW5rIHNvLiBPbmUgdGhlIHJlYXNvbnMgb2YgaW50cm9kdWNpbmcgdklPTU1VIGlz
IHRvIG1haW50YWluDQo+ID4gdGhlIHNoYXJlYWJpbGl0eSBhY3Jvc3MgcGh5c2ljYWwgSU9NTVVz
IGF0IHRoZSBzMiBIV1BUX1BBR0lORy4NCj4gDQo+IE15IHVuZGVyc3RhbmRpbmcgb2YgVk1JRCBp
cyBzb21ldGhpbmcgbGlrZSBkb21haW4gaWQgaW4geDg2IGFyY2gncy4gSXMNCj4gbXkgdW5kZXJz
dGFuZGluZyBjb3JyZWN0Pw0KDQp5ZXMNCg0KPiANCj4gSWYgYSBWTUlEIGZvciBhbiBTMiBod3B0
IGlzIHZhbGlkIG9uIHBoeXNpY2FsIElPTU1VIEEgYnV0IGhhcyBhbHJlYWR5DQo+IGJlZW4gYWxs
b2NhdGVkIGZvciBhbm90aGVyIHB1cnBvc2Ugb24gcGh5c2ljYWwgSU9NTVUgQiwgaG93IGNhbiBp
dCBiZQ0KPiBzaGFyZWQgYWNyb3NzIGJvdGggSU9NTVVzPyBPciB0aGUgVk1JRCBpcyBhbGxvY2F0
ZWQgZ2xvYmFsbHk/DQo+IA0KDQpJJ20gbm90IHN1cmUgdGhhdCdzIGEgcHJvYmxlbS4gVGhlIHBv
aW50IGlzIHRoYXQgZWFjaCB2SU9NTVUgb2JqZWN0IA0Kd2lsbCBnZXQgYSBWTUlEIGZyb20gdGhl
IFNNTVUgd2hpY2ggaXQncyBhc3NvY2lhdGVkIHRvIChhc3N1bWUNCm9uZSB2SU9NTVUgY2Fubm90
IHNwYW4gbXVsdGlwbGUgU01NVSkuIFdoZXRoZXIgdGhhdCBWTUlEDQppcyBnbG9iYWxseSBhbGxv
Y2F0ZWQgb3IgcGVyLVNNTVUgaXMgdGhlIHBvbGljeSBpbiB0aGUgU01NVSBkcml2ZXIuDQoNCkl0
J3MgdGhlIGRyaXZlcidzIHJlc3BvbnNpYmlsaXR5IHRvIGVuc3VyZSBub3QgdXNpbmcgYSBjb25m
bGljdGluZyBWTUlEDQp3aGVuIGNyZWF0aW5nIGFuIHZJT01NVSBpbnN0YW5jZS4NCg==

