Return-Path: <linux-kselftest+bounces-32484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB7EAABA59
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099671C223A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 07:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B463D2CA8;
	Tue,  6 May 2025 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcGwXWbr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB504B1E71;
	Tue,  6 May 2025 04:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506815; cv=fail; b=goqM2eCMkrdjibg5nV+2802v9cuEdMmVhZG+svCmBmil6Q4Dt/aPd0l8ziHh8gc+ZHjf/QenlftpCBjXDweRSXRA9Q+ZD5AHvtODtTVBH8MUXXPpN8Xhn/0iUYYla2nYpom1uwz6SQDHWe//5kaJZg9yaMOgHd5X+wfS3uq5rfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506815; c=relaxed/simple;
	bh=xOKpXkiz6SAG9BjLIXO3C4vYZ5imwIc+9K2PIynp9tM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bH2QwB64Eioz4f9/97NkEqWkOBTmfk9f3VxzfBoo8TMq4T/VvTEplqitvRVLLU6R56QbPcTSsehkkIPg122qykYCklHE59RVS3QoSujtzHYL5MyyY84giRwVX1+/HHMs5g0cbad28z4rM1A+t0XP5n+Ji9aZnCVePsoNPWEfHFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcGwXWbr; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746506814; x=1778042814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xOKpXkiz6SAG9BjLIXO3C4vYZ5imwIc+9K2PIynp9tM=;
  b=ZcGwXWbrQqNg+lUnYzziowfzyfuOl3+erVpJXTdFWFC336zkq8lAKiXz
   nnVeXBR1YuQGU4Lg1o++kHBeo1/2vpUVoh1mAnDLHeXLpNocFsh1kMNdt
   M2DTymF1FgNJAHbqlYdlsp3PkI7Y+saURiZxBFGtQ1+sMwsnCprlwCSVy
   axdobW5NtbS5dGoijvzb33zm5mWOm2BlKdoL0bssgG05CG0rWn1b3X0Ar
   u/fRBTwhzHDIxraou/KgK91aSj+E+xafuGio+UXu8bMOPLas2VlF2kSIL
   NIRzo1sgx8NJj5QmWzp7CGS7O/T0my9WNrHt6TANOYNOPZxegobZMMnYt
   Q==;
X-CSE-ConnectionGUID: Y2N+1DLuQJSlW8URO48Nlw==
X-CSE-MsgGUID: r+dUlErNSyigYUdPSbSRKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="48289402"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="48289402"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 21:46:53 -0700
X-CSE-ConnectionGUID: tXlxZgJGS9KV6mN1nCSVVw==
X-CSE-MsgGUID: Em+TxqeaTKyLmx2ftgpaxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="135452879"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 21:46:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 21:46:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 5 May 2025 21:46:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 5 May 2025 21:46:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYGposaalBwpeikNH8ux83RrcM2L7uHMkTYCAQWi9pRlyLP7qQ74fCp1Blk6YRmknM1h/m7bE9l2Jf2JuFbYUKYcVEhYG0YyEFVNDPP6iIYr7n49+8pn0WBZlwhiMVM+udPK8E12oO5l+7oLbU0vGIAfEGSBJoTnqxz3qnCu+W4eJoaDlQMhK0yPAO6z7uQNogAjeYsozg/xGOqGwuM2DRUZV9+azburjaPOIdIgqksxMeaL+212KbXjE2VnU3/iXqxlaAMwWDXaUHdgrIN74edORssUk2JN8U49XFccSABQngj2zfFsv+IQJzs7vIcjoBbb2K3BAzi2RFAFBGBlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOKpXkiz6SAG9BjLIXO3C4vYZ5imwIc+9K2PIynp9tM=;
 b=KWXRHj9i1RU9hPc4LInTQp58y65J8Zk6I8XJderTGQ6GKJIxxn6MAIx5uRweToiE1uOuAY2QqwXow/PUBTTm/jKHcXyDLnnbvNeibEsuURmq0AKGDewqg477XPAgGAE8x0MOLOsPx5xSavJKfEXAk+jei3RrfCt7DOvEgLv9F5ggiKQqRf8Ekudew8ftydtOavhRn0C/Am+tYWwqdlEroSA4N5iHsu6MLLEWxnzkMhjMluDaDDxJqGYrSfxWT4OfncG7sCP6IKVUd/64AOYPq8Xt6SJGDYj7qscKoovgzW0ty8p4K1NzeJhOONtmMeZEZk7we8DBT8xkzmSlrsM6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7113.namprd11.prod.outlook.com (2603:10b6:806:298::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 04:46:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 04:46:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Alexey Kardashevskiy <aik@amd.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
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
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Thread-Topic: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Thread-Index: AQHa+KLxhE3fl2HTskGswxeJI90kSLJ2O5AAgAB384CBRqWHgIAAAReAgAh1I4CAAKOfAIAAHjHg
Date: Tue, 6 May 2025 04:46:19 +0000
Message-ID: <BN9PR11MB5276078BD0923AEEF15089AE8C892@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <95ab62fa-bb1c-4e4a-a210-b0bdba0d4ad2@amd.com>
 <aBHYN39FcH+NG5Ab@Asurada-Nvidia> <20250505170807.GP2260709@nvidia.com>
 <aBl5uLOFCntuIYYz@nvidia.com>
In-Reply-To: <aBl5uLOFCntuIYYz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7113:EE_
x-ms-office365-filtering-correlation-id: 0b234b67-3f15-4597-2a7d-08dd8c58f1c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?sG313Zd3mT+q2+s6xdaHst65usTUO+41keq9cRWZDlit1XXhMUQIFbDNAYIw?=
 =?us-ascii?Q?dx0reFhhEsz1Cmk1pvcsdJAgVYzDE1aZ1qRXd9iZtWgjidoOzWUVvPmtbXRB?=
 =?us-ascii?Q?LsSjS5CbeJcIzRMTK+OvjU1mk0a2D6BJkATzqzEr3f3iPuJJoqnKb4fkRwp1?=
 =?us-ascii?Q?lhh/SW0WqILlZ/IPWQJwCS4P6EZWHo/Q6nPwbFQOD+H1l6eTXZCuduhK76mf?=
 =?us-ascii?Q?R77Eq3QdkM2ulR76sKdklrIBYyxho+VNULNsUaPqtvTqVlwPKSQh1ROFTiK/?=
 =?us-ascii?Q?uA8R/0dnThrcMHWeOylOyuhRgNIpp2fiStCApl3LQvuJRo+DRt77KWFGnbxs?=
 =?us-ascii?Q?1M1Q2I4yVSTX7YHkhpRZn6Kl2kmQzMKSwna857ZQI0arvVOSRYknzsXNDHmK?=
 =?us-ascii?Q?rjpIF1677vC28BYQKOeYanSad9VfeCgzY/j1PZ+GkYkGADwOUPVDmLjkOZTJ?=
 =?us-ascii?Q?lPmacHeQBGOlh8rB3F8fMk292i9kFniBkdotde2hFKdNOpjrKPROfVkG2cob?=
 =?us-ascii?Q?apsQajZS/9a2jKgyq2BQjIDcIJXxPSWmUXgpKdpLQm1hHdmUjLppxSh9k0qE?=
 =?us-ascii?Q?obGBN4CBYrpu5Gs+5ECHl7LCZ/VIoBrj1STwgDGXue/RLmdZkJnKUoutA9Rm?=
 =?us-ascii?Q?szeNiF1lZtdqiYNm/VzkpeQqOqDRlw0HdjVIBH7tmFcUA4Lk84Pc0weJ4Cwp?=
 =?us-ascii?Q?Mwjin6unoV4KBcdVbo0ZsbFj8N1J2U0PyA+8mShgTTwbQhYjfX1sJteMZqw7?=
 =?us-ascii?Q?ehJofzim1jbhT6L4AXSqmHjq5TfcFI6FXMEDiA2IUDbyZrIS/TsRipgXt7Vy?=
 =?us-ascii?Q?JuMKXbyuuBMvVTdr+Hz2uVhxd0w4oxiYX5skxMr5M2Z1UiyPe3k9NpDXyeJR?=
 =?us-ascii?Q?xJtrFhADXyXftJXv8htv8wOmZx2EvmAe4ABEePNtp/CIo8vyWEd5k3meWDwC?=
 =?us-ascii?Q?WX/ovPZ5PxnuoD4tT9nAjsua44XkR5dhX4Nlf6g1AwOOv+/yKbynyrAQtceF?=
 =?us-ascii?Q?mcJ0pGhKH4QVNAZGzkrZFp5ut08VCh86NkJNEFam7igb5mLWYUrTzhL0EN2D?=
 =?us-ascii?Q?OyY/f8fk6i9L7M+1xJLo85Vcuv2DBqr6qMZCy7YnPp4FlWR2LhPT2tc0W+3M?=
 =?us-ascii?Q?GKIIc4wPY6qa5UGNXNYxS9cQ365VNpid0ModeXRp1JhVYZDhN/WGMdPlz+dn?=
 =?us-ascii?Q?FAsTRLaAGbRqDV8w139jBhuyy0i11c8tq6F5slVCN/XUh3Vv/KUXWXUiEniG?=
 =?us-ascii?Q?G5FENixmFhPRJxHJKN0U8bcwqLmhlELALYxxz5enZTVGRqbb0VCvlqfcVRzm?=
 =?us-ascii?Q?aKReLbMcDfnnpsi2V7XF/mNlNEzqM4GykaFo2Hura6CTGkyXNEmuRTsPrS4Z?=
 =?us-ascii?Q?Rmd88OtDc9JEnywW6eC/uLSyVXLB+ZIpEVjSXFLane+DA8+XN+w6sks7FWsC?=
 =?us-ascii?Q?gRI8pFypo5YzzeV9YR64eh0zM6r20sVfCjVlH/1meI+/BoSKFNfb4kkXQXzn?=
 =?us-ascii?Q?T/JOWSilYfvgtd0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1m0W+okQ48y+Iw6JQ2NDXp9LDzcMKUajdeZV1SOQymd9JlBW8/O7adlIcAqN?=
 =?us-ascii?Q?pbiUaSw/EKxSMU4aTu7otWe5jTVM8obs63mRmEgMpPfOJi6ssK8VM/6V1xrn?=
 =?us-ascii?Q?T2CSrrdLMjfRYLYAq6yle8opHEUPBF0IwtaQjeKwDzWQffuHG0gxHMyIMkOM?=
 =?us-ascii?Q?CVR9RH1aI3Fvv1gjr18YiYl6m4rPQm0B7quoBiLA4+Pp3KmKERNpdtgaQ3ou?=
 =?us-ascii?Q?cy65rvHtTSHOBlUV9tayyWniEexygVvn9J0DxWNZrW3BpY9BNDPMqwobgZlh?=
 =?us-ascii?Q?20fDEbP/IvsnM7GTlU1/gd+X02awBqhyudX91KEsqsMwuTUCOMiUOsnOXRKM?=
 =?us-ascii?Q?K+kpWP2SntQhKvq0Rpu0GCOFjV737YdxlyNsTuIidQuiCSseBqmd1Exsv4W9?=
 =?us-ascii?Q?My6VDMgL9x5GOdbn2qx2imhKusAPX2S8BKqbrhXfpH3YRRjeIZd/gyqfidLv?=
 =?us-ascii?Q?i8iNrolYwoup3UB3+DCpj3SEZNvzMRm6fFQKTtpCgV9Zyw7nKUMtkDKdRfys?=
 =?us-ascii?Q?L1NATZsx8Sx2VBeXMPXymfZTszWUHBsIA82e4hIe5W328QW4FbvzB/bMjUaI?=
 =?us-ascii?Q?tulGivkeuLWLI+pw+/1Lhm6Jlr6vPIpXk9yS8xPS4fKkEoJflrcB2w2zOrIY?=
 =?us-ascii?Q?jCnyDYVJuwPkaWdnwNuQq0650jAU4M/Ud0qxDH6whavmpERdYGwwnN3cfMDm?=
 =?us-ascii?Q?zsdT8+8OVUblwF9emVuy4Y3znKwykWU/d1ZjZOUxJNMT3RkEMzzKvUQhoZd+?=
 =?us-ascii?Q?G/4q6bbNF3Gb+vq92gBwTg3k2VL30xpmZ4agvbCTB3DWbJNQbAiu27oq0mcs?=
 =?us-ascii?Q?gHLXpDxAiPGoPwtmfUHfTGhMcXm+8U8VZF0++Iv8R1duXK6laKsb0l8zXjQe?=
 =?us-ascii?Q?jmclWKWKY1zqi/wPPrLpD+ydFn4vMjTwDJ2dtFS68fSvbrRUzZyH9t0xFe7p?=
 =?us-ascii?Q?ih0HTSl3hdqWLQ/lEfeYHDqDHFulEouzE3FMQd1sGyFzR3BtOXs5d3jqIG7Y?=
 =?us-ascii?Q?0dqsGn3B2UhLfyyXgbs0gXkK7UsGr9OctH/eJPmOpqOFUZ9f3GIc6yKtGMFS?=
 =?us-ascii?Q?u7zz77id+DPRQv0jHZr3Rlz2AoPPjE2kwpTV1XNNP06lycmoVzc7P4kHW1jM?=
 =?us-ascii?Q?FZsNF6EO2gxdLCkLSzV6hiMTUkBeF6p2Ob5ONHG+MRWLzDgKMoahrzJdq3hN?=
 =?us-ascii?Q?FG9SkbXb7ksq4I2DKftYm/LVZhUCRRr/CgYmjkv1hKhxJbmGXe0h4TiO8HGO?=
 =?us-ascii?Q?x4hdAyxvShq3lkpGm2DQX2N9F3wZKlL5NAUx/mW/cU0wUl7+ZKP8j6Ofgh6B?=
 =?us-ascii?Q?/p9d6wVCVzgFiAdPIf2s2MAIdrnLNLIrrxDK2AmO6cr2YNawjh2/QGH/unpz?=
 =?us-ascii?Q?wzQ6ZmQuMQukGg8WIWAiadxnJvuzbgorzRr6iYx7KoumZxAu/FnTSJepV5lW?=
 =?us-ascii?Q?MP668O/9G7h4PwGorXFYYUsTLXlaREOrltL5W6uGqHM8A48AmYBQMuXNQIy9?=
 =?us-ascii?Q?qn0XaYtqlnsFzv92mvmo1+NY7Uv1lqu/n6qOGO7/TCBwWo790cqLLyUFfR6N?=
 =?us-ascii?Q?EqlDh7ArDQPEzys9PPi3aRPu93ix0B1pcZLJowuZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b234b67-3f15-4597-2a7d-08dd8c58f1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 04:46:19.7343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7G30ppaiK1jfAxeG+zm0wjl9P5vqCYr4AuZf6k0S26NN9U2yGIHK2nQxgx/sOnCVAn2LV5Ubrwuzpr0DUop+xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7113
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, May 6, 2025 10:54 AM
>=20
> On Mon, May 05, 2025 at 02:08:07PM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 30, 2025 at 12:58:47AM -0700, Nicolin Chen wrote:
> >
> > > > ... and I just hit a problem with it - this is basically guest BDFn
> > > > and it works as long as I'm hotplugging the TEE-IO VF into an SNP V=
M
> > > > but does not when I pass through via the QEMU cmdline - bus numbers
> > > > are not assigned yet. So I have to postpone the vdevice allocation
> > > > till run time, did I miss something here? Thanks,
> > >
> > > I have a similar case with QEMU ARM64's VM: so vDEVICE on ARM is
> > > allocated at runtime as well because the BDF number isn't ready
> > > at the boot time.
> >
> > Oh that's ugly then.. So you'll need to add some kind of 'modify
> > sid/bdf' operation I think.
>=20
> But the initial vDEVICE would be still unusable. Its BDF number is
> literally 0 in my case. It can't be used for SID-based invalidation
> nor the reverse vSID lookup for fault injection..
>=20

Agree that it makes more sense to allocate vDEVICE at runtime until
it's assigned with a valid bus number. and destroy/recreation is
required when the bus number is changed.

