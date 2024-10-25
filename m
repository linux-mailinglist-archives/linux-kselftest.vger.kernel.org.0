Return-Path: <linux-kselftest+bounces-20625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5089AFDA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D2C1F241C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C91D435C;
	Fri, 25 Oct 2024 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VL7v67Mm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E31CF295;
	Fri, 25 Oct 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847164; cv=fail; b=CJ/yFTvEws3dxQsWqeKhJ/kC95FlaYvPYA/yQUFG9fQAd3Hk0xXhfJIJSuqYdUMY/LWAe6dOKgQ9H94poQDB5/Cy6/179tMJMN5HNpLXW3Bo7SWs3btLx5vGap3tO58VOX+ofjrzHY8vGrPv7uCEjbr/I6QBAXzsktQCLYVby6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847164; c=relaxed/simple;
	bh=Nl8Pn4hWEdCcmDex+FLomi6koDT6z/UY2lVRbiGp9As=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O0XDvbBObAVeFmhAv/yOWKVcCjIUuTo+JpAwbGsmv8HwlSR3tSuxbb2gIMLWraSCCZLNwy19RO/SiBB2fj+dlsoQeBIG/9kwsBt0b6SiTmpVFuSF2ZLTI/7ftBWZCHSOH9koq9EniHKrplIVSPyo+Pz0JoQ/gouAF13+XU+tRjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VL7v67Mm; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729847163; x=1761383163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nl8Pn4hWEdCcmDex+FLomi6koDT6z/UY2lVRbiGp9As=;
  b=VL7v67MmmG4OvtDTNgT0raX1M96y20b0BS+xF5BQTZxgFVWNNZsUEPQo
   MeJ4Rt0VdbqCQqLENdaXaRbiDsxIh6pqw2psGCbxeMFwudmD5ppNZDUFV
   nhQxC/VcL+NHQM5okf/jSA6KSl/b5gSZ8L26IXCRg7MrWIobLcGFqXOLh
   8taiMN+Rvzhy3763E9M1OuWpMdU57HwiuuvupONEjW3UGi/xRmprjcFPJ
   vBx1xm23Ff0zV+5M9IGNEJq6pwm8hIYTyKrtvYjvTXHxk/FzOv2SM5g22
   PxFdqxOIOQHyQGjJVHwn3dFqu80As0QkqXEr3quTI9cFHckYMpCB3daYf
   g==;
X-CSE-ConnectionGUID: 63zlLXLXTV2H+uXkgne0VA==
X-CSE-MsgGUID: WuSTcs0JT7ebhViwkwMBSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52065267"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52065267"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 02:06:02 -0700
X-CSE-ConnectionGUID: bOK6FSiFTuyOkJ6nizKsnw==
X-CSE-MsgGUID: 9GGADU3nSICnkIgcmokBvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85651878"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 02:06:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 02:06:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 02:06:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 02:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFH2nyLc3aMeIOb+Vy+0FHk+/dXcITMjUbf15JBq1TqTX0cC1HYHZ3nB2I4kG/CL5hJuNALsJc5HLoLabk5iEH4uYJ9sAvEqykYNQMLkkljMlsOOa5M4tK/QZEwgyh7ZtqJlRXJ16RL9A6iAdzel0cG+pj03Tlce5s5FjbAili0BjzTyl2y3umXmGH4ey+lp8DRJo7ZcS72qtiYF4ADggVUn0ux7dGbLiDkvpEA+t+pGZs7wvxk07+N+ZWGqXSlkCz5mZEfEGEML2gUgv8338uT9DoBcBXIzK/wqGb1Av7gOTSizPbRTQ94SyNOucaDj4C2S78YFc6L8uXE9+KCZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI0xZwwGYTIA1XKvTLzuoULhd1e5h0lHNv3WUoR+ZoI=;
 b=ijrDqxMRCyHNle5RfbKbYX6uNuFI6cpD8y4Aifcdkbwj6SG30o3oyyv48O1LrQbqKPxv8eJogowLsbXf74qONZ/rtYWmSxgkPi3qCiE0jyF5A7sAd2kbSvy7XpKZFEIb8b7gLThcVE+89T/jRwCFp141SwTk61+eKyjnu92UyLWblkOJ6jnilsJjjejTKiTo4G4vdyeOHYziQbKaF4EY1gH/psBrSpoP/0vPbcWSGPEfxqpS4kEP+bes/UUYnYjFRv7FXySdKFXUJC4/4MNVcycgQ2S8AuOuhkvGV+6HSNXum8yUoZfgnresTaxMgEMM2UAgNA0M4hGRipsUp5qVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7433.namprd11.prod.outlook.com (2603:10b6:806:31e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 09:05:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:05:58 +0000
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
Subject: RE: [PATCH v4 04/11] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Thread-Topic: [PATCH v4 04/11] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Thread-Index: AQHbJBg1YAeYUD/RJEqxNQPpgn5DG7KXMcOA
Date: Fri, 25 Oct 2024 09:05:58 +0000
Message-ID: <BN9PR11MB5276528AB82E7C8AF53FBA1D8C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <9da2cf334a182ced4d4ffa578b87889e9c0856f3.1729553811.git.nicolinc@nvidia.com>
In-Reply-To: <9da2cf334a182ced4d4ffa578b87889e9c0856f3.1729553811.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7433:EE_
x-ms-office365-filtering-correlation-id: 984b71c0-8974-4e85-d094-08dcf4d43d96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nJpJCeN8y0jCFgzpJ17XDtMjF++Bw9Cjpqe1/m2NgOHXysdwDmL/5ZKYBdtq?=
 =?us-ascii?Q?Vnt/8qjblGYbhEZoezvGnN9/wecYa+FRpGuORw0BO6WFxKmpm3JyzTp1Fyj0?=
 =?us-ascii?Q?d09Mkg/mOE0sc2OP4yCz+lyxfbDqe1G487flBnI4w7Z5ro6RH6tkwGI4UEXl?=
 =?us-ascii?Q?CVRfgfsCDZsT0JT/iCGzqpPsqaMRTgEEz1+qs6LXNlCZIiIwU9L/Cvhv+vFb?=
 =?us-ascii?Q?ufr4SniIaPQyaUv+G7Fk3lULXZL8yjR1p5dZVye6hi1jgnvMhqlzfXLtM8QC?=
 =?us-ascii?Q?BxHo7dibUQHDlPvSapfRnl+q0sxByXvSA7KaPDLDor3vqF5NCai/3LNTIStu?=
 =?us-ascii?Q?JF/solNuuyecYISZFFYzjr/0Zd3Bew28qIhJY0s1JrTTU95yN/a+WoSpgU+I?=
 =?us-ascii?Q?VWknYtyPQaZSlXpWpk4w8PJ6O66Setj/d5v+pBWBN3QwsGPLPZprzJJp6cve?=
 =?us-ascii?Q?CBOhS8QbJlIABzCX3eOepKmAxPbYwBsUVLbmqFvXtf1hq2BlkfjHL4aN0E1K?=
 =?us-ascii?Q?nFMyxd9Y80pXg/dWwlJDLeIk5TmyzeVWbnn76Jn0zr5zDBtsm9MnQZIMyO6T?=
 =?us-ascii?Q?q4/8khNQHRFIIKZ2szCWNXOUNO4VnKQzWUgITFq7gC1GvKD3yujE95dOhuZf?=
 =?us-ascii?Q?Fcz76mQzyjeD7naFIu5sqVyngZWmNjjwKaqn7OsgSaSOz6bw5qThmMrAdjFk?=
 =?us-ascii?Q?MpgwCg8kjAt1DK1pggM9q8RWD5WkFYe1wi5mQP66Bw2T1sw9fDcqsxwpgIS8?=
 =?us-ascii?Q?z/qmTS+/ohU+on1J8JxnR1355RzkVsDnieMZAYY749JINmuAweHWIg+Wij//?=
 =?us-ascii?Q?BlY8ugKG/R6IRS6iXMmHLMJgx46AijOmVK+jv22tWlUVY1E9oRRBQ9JwbQ7i?=
 =?us-ascii?Q?WCo7ZZlEGjRWDbr5cHwaEjb3KTegqDBcP5OX0LSwvl6gZv6bRxqlCr0u8giy?=
 =?us-ascii?Q?HXzhEu1d2mVZJggDMWUpwX7DWxXd0FVyBVO6tyWFgZH75uOydQXfnbdCn+47?=
 =?us-ascii?Q?Ff9jPeBcfRhV1siFi0nLK5WX6UyyGOa/sBY1WHURXaVXt9JHLijTkxbanRDm?=
 =?us-ascii?Q?t9tLL04fRhBSDZK7+Lw0J6EVITK3w75Bmwwkd7Gmr58tWvCQb9QcwV/bl9bv?=
 =?us-ascii?Q?k1FHfKEeRp5RSSqSwnt/HSGnng0RYAx6l3tAMH/6utHNSNo0+IgNx4o78CLT?=
 =?us-ascii?Q?GjCeOydHmIsyXiT47VI+EdzPZU3P9p+rfos9VRA2t9YZ0ZHb4JDjSXfF9Aw6?=
 =?us-ascii?Q?vEec9abHZ4BCSxaZNv0A/sjAfSAgqNxyur4rKzk7YS9ct7IYtZ3mr2SC8s3W?=
 =?us-ascii?Q?Za9pSyFNud5sunXxOFnczBoI3P+95abiEkmtgnSr01VCVVLgj6tfmYqu+kPn?=
 =?us-ascii?Q?eMjaLsg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1OBLMO128Xk2r/0+e+TsntARzmkVazZPJMayStUgZKBL318Ji8n3bvmtoPqp?=
 =?us-ascii?Q?TcmY1UjJddhTpmSUXNA7+jEV7D9DfQxFLxUf2XOWHUbOOz6bp76pXzKVzP3u?=
 =?us-ascii?Q?8oIgAUKEZejTLKRCnpkKxDnFE6lfxmEdd/rWskosjpCCupe3QKf/x7vPYYPN?=
 =?us-ascii?Q?bmLo/MFlQraYXDetEvxg0AWuqdg9ywxYUWYKdthS3RblkJWSAxnWAQdLDzyJ?=
 =?us-ascii?Q?R+syUfOQ4lnfzGdWHCEkzuNb3y0HWDhCOzdkP3k50D1zJy8VpScvMQkrV33p?=
 =?us-ascii?Q?zHRHhPPIULy4kSJ7xRJlrluBw+8iS683mL34DAVG4vgtHSTdwg7kR4Whu2pZ?=
 =?us-ascii?Q?bALRwGe546RrvozRAenjHRF6mr/i+VGRQrK8UwRHfQyT7kJab8zOCrPEnN5k?=
 =?us-ascii?Q?SD0EFK9Y3ifjgmyYGkWBad75B6fsd4tD+aEd6EqgDMGsZuubWa+bmA15CMW2?=
 =?us-ascii?Q?mdKaNeae+LCTusUQHF1w3gHpofefVvYElPMDy5Hl3oO/7ihCseoBJ/pzSeSV?=
 =?us-ascii?Q?Qa9N6kn7qw3fy69uYANNt3KwdIGybWWk4OjrwSNWGEGfleYr4pteQ1hgtyEz?=
 =?us-ascii?Q?PpAnQuYqfy7qZdSN6z1GoX91b/FACzCg6yi1oEHR2+3okq+5/daoQtlpqIk/?=
 =?us-ascii?Q?dYQfr0Y/kIq5g2/W5A/MTFUZEsIVTMDRSxjGIQltbrmDNogkBQOchagUw00f?=
 =?us-ascii?Q?CnhrdWIKfiKfCiJfjQaU77Xs9aDvuRC+vPcaxCAMfi4WPpVYV50eyQY8swMB?=
 =?us-ascii?Q?MYyjVb2TObvaC03HDj9mJXB9sDBPKguU7ax+TK63umikoUuWV5P7e658fvis?=
 =?us-ascii?Q?uZ5qVV1yQh6BXWbgCy5BjBQN2cviRHA4M+15Plhb+Fnl/ToaELIgOfm8Qtyh?=
 =?us-ascii?Q?NVveaAQazNQyTQmslQff+Al9LayHfSzrkc6Dpd2kvS7iQChwccL7s75T6G1e?=
 =?us-ascii?Q?HJCzEFYvNGgvAHo7w8i5E4iH0GhJaFmwFN0rOqrW6Td1Z9dQH3pZxbxpGWPa?=
 =?us-ascii?Q?EgSfbXdtTfCl4u2Ut75TBkHh/jpzgWbMxfW1QgxEBDJCfKRiu8kqI7qM/gEO?=
 =?us-ascii?Q?KQykF8147Jabc65V5iLIsOVRUNGrGjBfDAm53L67wfH+pv9APbM0VtpO5Hl6?=
 =?us-ascii?Q?FS3NLGDU5RrP5HeRMysouFTyU0d2UN2f0TF6f6Y0aGTwuMHLZSN9oE4CfrwR?=
 =?us-ascii?Q?ClaVnaBHQAWy53Px0W3YG3LBDCkepU/9d3n0qdxl4U2987KE7zs5eFkYmA2X?=
 =?us-ascii?Q?LxykH6fNdJ1l8W1qkp9sP5ZOIQh/S4dRFqgdAYzGmPfj2GwXqgDaPMXcsDpV?=
 =?us-ascii?Q?d2dx6QuYZc6oUvfmzfJb/pzvVSwwLGVkF7HHZPldvZMg28wo0LLxe78pRtYV?=
 =?us-ascii?Q?TQkv5f5lc2dvccdc4J5T0NQJkeCZXDnJNrAPFoYmYwsrWkY9T260rRjgr4ur?=
 =?us-ascii?Q?U/3bhI30muDoE3jG5M1KwZVPou8cbBsaCwkGCI735YBXPby8mNtGAIWPKJST?=
 =?us-ascii?Q?VxqrXF48JiJNDQq2mHLIlFjxADJk9y++v8Gu9MeriwYCpPKInWz1446FopyC?=
 =?us-ascii?Q?nRmcw1whXA9j1Fk19i4BmGAvN8ZszeskxgK5jkA2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 984b71c0-8974-4e85-d094-08dcf4d43d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 09:05:58.3286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m53vk0Z/63N/M4BpI/lo006m5j3MGioV1UAhV8wor+vP//ya8LZb0kP6H+vxXapBzwv3aeARUip+HK9BQKlJRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7433
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, October 22, 2024 8:19 AM
> +
> +	viommu->type =3D cmd->type;
> +	viommu->ictx =3D ucmd->ictx;
> +	viommu->hwpt =3D hwpt_paging;
> +	/* Assume physical IOMMUs are unpluggable (the most likely case)
> */
> +	viommu->iommu_dev =3D __iommu_get_iommu_dev(idev->dev);
> +

so what would happen if this assumption breaks?

