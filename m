Return-Path: <linux-kselftest+bounces-32496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BABAAABF49
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 11:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F738188CB9D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F822673BF;
	Tue,  6 May 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WE5TQC7j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99F24A052;
	Tue,  6 May 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523388; cv=fail; b=IO++F/GvOcioVcm4DZY4AerIJGIH/MMTKysbCguUDBGNJ6AR21cxFvKC3/XxFM03pGYubo6WfcFqdlRy5LYnGmADKHAcJnglTGH7k4g7Y2+XozfPEGyK7FPrsE49oLk/hBlY2b9I4Y/DGewLqPOgA9CSJoKTqBdp+jSq8o9DKsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523388; c=relaxed/simple;
	bh=BcC27oVTMLZeNGex4GHU8upglt374V7F9E1LDAT+QVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=to36rwAdmtPea89OILuPef5dLMHJ3m1JNIebQlbwYsscecRI/d/wkTrhylqBVLSbBqr5mlMGjAtvAHx4QyKTGIqo2qUs4hAkbjbBnZMLtCb2BSMPX3lnw/5WRrQw5PT+ss3zK9rPD7qv+k/OhWu2c6lTJLBMWpaLteBSUnggB4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WE5TQC7j; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746523387; x=1778059387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BcC27oVTMLZeNGex4GHU8upglt374V7F9E1LDAT+QVc=;
  b=WE5TQC7jimUIBC2Yzz/onVu0MbxJ7MyyQ25YljytGO1yKoKs4HY0JfmZ
   PZPPhglu9Iy49iYgRBMYI4k2G5WspXUCKo3oeSf76BbVYyQzGHS7Pmcb7
   VF5a8Cugzb+MjngFUQ4HOLF79ybc5gjM7O9UKakDoIX5PtI/qmgjITh++
   TdQ34+H8+rjykHJZ1kErGjaIim4PBFHPjeEmgc+ebUqe/sWsv6s8BLTNI
   8kuob1k2nV0JXFkvdpRXdKlryKkssj53NaLHiCF0T7OLeX0NVAdE42l7/
   QMWXbVdJBXED6GtVnAani+foEjsvYMFbpRNXEgZlCBJmxzQ8IY0hA2svK
   g==;
X-CSE-ConnectionGUID: 7UfyfjQZRDiiD2FS2s3Ykw==
X-CSE-MsgGUID: 0Ny3PK69TvGf2uyta1MN1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="59570073"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59570073"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 02:23:04 -0700
X-CSE-ConnectionGUID: 4n3dy0kRTQeEaLYQOSFTtQ==
X-CSE-MsgGUID: u1H3xC4aRBOR041qXSnfuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135529736"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 02:23:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 02:23:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 02:23:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 02:23:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIMiD4MtrOa+DkWAt1I01404Xaq5n1tjQ7QH5NIVBZpHlvyUT7LJluQKVdjYYvpFIVbLjy0kkNeLQY1buG6EKHBBEB6th1qU8tQJgI83QjoaVr/PsoYDy9Nh4WnCK4u1DyJ36H3f4WB8TEzWuizZNBFwdNxPO2qcIgFT4O3STuk5Y7nJKpxZFRLhckpgamfs7xychwuRtgR/ehW3P4QY3QYKqK85ewqinBJgEyuy7rxeqo8C9PitmUtsLmzz6GURGuPRinR1hHSoCYBU/dF3DHcG8uqfNgLvSE097JD8reirUbMkfJ7TuK0De9kTJzC1C07nxdX98q2lJfeIIRAfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q/islsk1sUlS0u61zaPCoHkIzLTxsvUFvAbUyi2Nik=;
 b=W9C1nLIGQ/5nYuPIY5gtCLJ09kjyCBif/NDvFvmy1IDIjM3F8/DG7UUDvjmxwwYbNitxWamHrWFTbNvN2ZtKSkqlFh/NYoy60jEiJEt1se6oSYKjuWwKYxo93tSsSwuGfin6L7dv7DZKvSC7UIBXYYWfT1xIAIPIwkTqoqNL/xoiI61Ta2OlyesEaY0Gxh/46S+rnpQKRcPdHUt3S4iCWdvo9NJ9rF6A0EXfP1JWGUBYKCn5ahbpqUPzG/60kIx17kh9ZpKB058BZBeMWPoALdtDzRQSrtiY3F+73erbwyuL52qe0SwYmgsGO2+6tAa4+/7Y139X3bLJ0zP+dEBt0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH3PPF740777B0C.namprd11.prod.outlook.com (2603:10b6:518:1::d2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 09:22:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 09:22:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
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
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v2 13/22] iommufd: Add mmap interface
Thread-Topic: [PATCH v2 13/22] iommufd: Add mmap interface
Thread-Index: AQHbtnBluZ9uOQEPBUai7HCfuqREcrO4Y7wAgAvq9ICAAAiWgIAAAgGAgAAshgCAANzAkA==
Date: Tue, 6 May 2025 09:22:55 +0000
Message-ID: <BN9PR11MB5276BA11CB8BB5A46E118E558C892@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
 <20250505165019.GM2260709@nvidia.com> <aBjzf9PrYnwF5uZN@nvidia.com>
 <20250505172813.GS2260709@nvidia.com> <aBkahmXQGxFC0Fdw@nvidia.com>
In-Reply-To: <aBkahmXQGxFC0Fdw@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH3PPF740777B0C:EE_
x-ms-office365-filtering-correlation-id: 628e2ee0-990d-4a3e-049a-08dd8c7f9564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Lt74L7H/gEDtcmlJz2XRIC2a7zmB/5496wncJmUzOSwAAsoQRn8zcMqbnMVg?=
 =?us-ascii?Q?h8ZLKCzx0BBwbaJywbynpU0kr6g8RzcebqrmVqeBRfdhqydccAS09xXfbs87?=
 =?us-ascii?Q?H4NMORT6vhpjqQNQmmnc8bp7rH1JF4cxPTyT4927n7AnGb8lbEHN7imB+Eml?=
 =?us-ascii?Q?PWVpVP2YocA4zRxMFWoL6aVqot8R7FNlAw/B6kiLBHaZn+8/3b29DyGnWuV5?=
 =?us-ascii?Q?7GUVYF0HYI9htU2taXO/wb/IVij+NPPewjkv/kWaKBJYIbx30VnMthXma5E8?=
 =?us-ascii?Q?Ea4qB/H/TE5DgWgQZLa/e4SWQJKBUxTlJbzEZPaZGtggjSajYWsPMMlzbP1I?=
 =?us-ascii?Q?7pYd9aXr1F1Q8iSqkyhVOYU5Hnv3CIMCfRSiEnLzbRpVqPq6CJggcDctoRx4?=
 =?us-ascii?Q?o4z1M2N5h74BcV/Vi2iTOyYsTLCI+5IHY3C5wY4YN9fhwwpjGdfCFj1d6fUk?=
 =?us-ascii?Q?ZZGd/bMlX1pndRV+przRJZC+4W5Eph9fYBzm8KG9nuCuMRAn+VVVV0olPdw+?=
 =?us-ascii?Q?G1zFVXJBKlfrPFGAYHQ0/eC1sTNPLpgWAe8WbjKkdlLUxuz5AQdhNB6n1Skv?=
 =?us-ascii?Q?Lzg+OcsSqjWmxWSo/ucrxlBY9JVCGjcR8bliMQdxoF0xxcXsZSwk1c9ijBr0?=
 =?us-ascii?Q?+GCYwkK+zvG6dWjnwdiB3wLlyIfxRMzu+n3LG7Mma1GwqhrKZeMff7jMHbcd?=
 =?us-ascii?Q?Gr5hpYbn4f6vv+aEGMigqPUa+3k4FZboCrzABLXjXH8JCiW6UICDVYHUsynQ?=
 =?us-ascii?Q?Y3fmI8xjwXBGAzIPciKO0vNWIm4i1jvoNtwi3yfui0Xz3PkW+njGgyo/b0WH?=
 =?us-ascii?Q?kf73I34zkFAJXRRCGOmP0fi6YhOph6wD03NFvlLajzyrPz82bc/VMFaMkSXu?=
 =?us-ascii?Q?ioLOzgpFs0hwysfnypsCvC/juKZ9ehR2C76uirRqCBkDXZ/EYvA0FUbnfovW?=
 =?us-ascii?Q?ok3n+Qa/A27qKXRl9T/qftnPS4b+6o3vcmsHNmIfGIC271dYa7dS7zPE1tHi?=
 =?us-ascii?Q?MXu5wYQw4VlfFFZWTSlg4+CMYRhgK0nNfZCORFvvTXLRxOZHv9DxMu4DKeUS?=
 =?us-ascii?Q?IyoLzctSjuaEZKurHUeCuAH3Lsz3bvGN72ffJpMlws8HegYzAwppOBqcmlt5?=
 =?us-ascii?Q?0f9QmNgXg8xEMggiwyRzON53ovq04WNWZNhqFTD/OLJLnHwoR3qC0OHO25EV?=
 =?us-ascii?Q?r000y5FT53+Xv02NJw8aeAg3oOCzAvKyNMeiAb0ELSVpOmI73yzEdKjgttH2?=
 =?us-ascii?Q?FHaGwwmXxbMbbQrr7l/5+E2ESeoP6NZ7w+drEHpXvubfp6n8UKRCZUlSvLak?=
 =?us-ascii?Q?I0GmvvqF50vPZ+5tBjTznZ5HiHOd6QNSdY2SfdZ/kx9dwEHFN0A8ZNd9jYAs?=
 =?us-ascii?Q?AZ1lB0WdBp7guJuFv0YyM0xeuzFcDb7y2m9367LUh8EvXcyh0PjiCgjXmfsF?=
 =?us-ascii?Q?6Gv+QYIz2vfX6dEqJuOiOI/isrnv+cF4C+rrqkrPqNkCmqT59xS5F5Dn8Ssl?=
 =?us-ascii?Q?VkZlxmeLEO7qWrI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?srDGtF5hLTwVcY5klxaHh+G3GyGgoftnoXTCMikd9OgNghbYsqgU9+pede+o?=
 =?us-ascii?Q?fcD+nvAXWrLeWRRbrNgay3to53Jyd5vzahICM7JC2ptld/rd7vVlFsVNEkLh?=
 =?us-ascii?Q?KaZ0ae94vooCz7BscE8L2HA67Hx5Rnagexu/PYbujaI6fQR8hJ9FhSKRTOYK?=
 =?us-ascii?Q?Kdc8Gqefc+51q7FJhoEFEbGXgw/zOZvRESNJUmzJodIqolUbX33337f8kFbG?=
 =?us-ascii?Q?E8bLVUJkVdz5fXR8I4PDUFDIaLD9Qwz20E54dq41x62oWgKMYEiVuJnmmvmk?=
 =?us-ascii?Q?DeveRN7wEveXxq5xTroBcXuXKExyW9ysmgh8U4z6Lv6wKf/z7ItJISnlZjrN?=
 =?us-ascii?Q?4VJCktG6cCHrZ1ZjDOxpGpJvD4xJXtqlF1SMnvcdJ8r8hJAYuBsJCL817crR?=
 =?us-ascii?Q?QCxe5/0j5yWL6/FrNYYBHmEhNsbti9W8cNhz/NGlycjolKdBuRvCY4UlQiKg?=
 =?us-ascii?Q?BMqaMRXLJl6jkeR57piLv8CiVZSVDmecTBvbPEMO8dyPgiWYZd7/9LgO4mN2?=
 =?us-ascii?Q?EAbq5GxPC9WaBUnTvGmiUxJzEtjOV6FjppUJ/l/aSM5OfVlL/7WGA5st/ncD?=
 =?us-ascii?Q?rIXQRHjNc3Dp47epVUiM4W3lCiBp/tJndqAXN2nQI3VWrvN9RECzhifI3seX?=
 =?us-ascii?Q?i2lr952m7QfW0nag7Qg9ncVjpBH57aCZhI6qD0OxKBfI5IGNO8YYfQ/QW677?=
 =?us-ascii?Q?rmtsRYnBVLAL27J/1tBD5HuJZYhbwhE8LsoWabj03KzhnN/m7duT0dCnQfRe?=
 =?us-ascii?Q?fy0ojUGcDgo5RbaT9rE1mLoEG64IszH+LQlO9wiEA2g6OYUatXIQ7CH2fHlY?=
 =?us-ascii?Q?ilXNsMUONl553eYFIQ9ayH3ZMw4ByR1zu1ctffzljGpK6Ix/wLQbou4CbkML?=
 =?us-ascii?Q?b8S8gBht0lkYWdT2NUTd5n1Y5Cz3IHhQBqQ/RMkpaJoPSaMXhQIJy1QzHOmn?=
 =?us-ascii?Q?BjJxEruV9Akl3xoNR5fGoTh0kDwriBp0AHaGskawmgU/4u4y5jsUgPEcz9Kb?=
 =?us-ascii?Q?CQjwg6+6ar3KpSQA2XPWp82cW82l2BHxQAYBtKo93nt8enUAalkqYg+1kBCJ?=
 =?us-ascii?Q?83awL71dpsxjA46xPFx/NtLF5dyyRFRVjknTOtWG8od3Bzq7yhdE+aGSygOd?=
 =?us-ascii?Q?LdlHpOsSc5LZmhhJxezwiOrF2/2rVd1ZZuB+H9z91860naWwMPd7i+aM3NzI?=
 =?us-ascii?Q?i/wKpSXUt74r+BiFocDIVdWvgUWacxE9qiM7EW6oGNeM9uBwZqnXb8KATsoi?=
 =?us-ascii?Q?xOJ0Ce5Iovl7+dfynSYzPWgarA/ptkqMFIPpZUXgeXpyUNaKjp9CF8JXTnLr?=
 =?us-ascii?Q?hNumxUqZeLN1wJVkaScF63FzpwMPyq19hSgc/B2M+k05YL2iX+NuTfn3apWQ?=
 =?us-ascii?Q?KugoifhpuNOalyPl8R9EBZCi2h09ODDfGEDAj8lBKUX2ZwLiMJf32wn2PQu/?=
 =?us-ascii?Q?N6K9JtDSIglNyy8M6A00LuaDo6ic5CdCHtwgBQcDdDfW4e+HTqN0KQAb7Hom?=
 =?us-ascii?Q?Rngdmrdvm5SV8apTGElS4PXvjRXfoKyJObe4E+Ot8rJ/4nuy3xLpNUHnjZz+?=
 =?us-ascii?Q?8YVYil4YaGM/4eQYiGijdEvmR3AgI9CoINpPbv/W?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 628e2ee0-990d-4a3e-049a-08dd8c7f9564
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 09:22:55.0963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Fs248NhPXgK5+xwcHA42c8gYniMiMZdxiItTSLdiUNyifz/gKBdQfuXtopYNgkXYu8cG7367E73DoZbpiGmsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF740777B0C
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, May 6, 2025 4:08 AM
>=20
> On Mon, May 05, 2025 at 02:28:13PM -0300, Jason Gunthorpe wrote:
> > On Mon, May 05, 2025 at 10:21:03AM -0700, Nicolin Chen wrote:
> > > > > > +void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned
> long immap_id)
> > > > > > +{
> > > > > > +	kfree(mtree_erase(&ictx->mt_mmap, immap_id >>
> PAGE_SHIFT));
> > > > >
> > > > > MMIO lifecycle question: what happens if a region is removed from
> the
> > > > > maple tree (and is therefore no longer mappable), but is still ma=
pped
> > > > > and in use by userspace?
> > > >
> > > > I think we should probably zap it and make any existing VMAs
> > > > SIGBUS... Otherwise it is hard to reason about from the kernel side
> > >
> > > I added in v3 a pair of open/close op that would refcount the
> > > vIOMMU object (owner of the mmap region). This would EBUSY the
> > > vIOMMU destroy ioctl that would call this function.
> >
> > That's no good, we can't have VMAs prevent cleaning up iommufd
>=20
> Hmm, would you please elaborate why?
>=20

According to [1]:

" The mmap() function adds an extra reference to the file associated
with the file descriptor fildes which is not removed by a subsequent
close() on that file descriptor. This reference is removed when there
are no more mappings to the file. "

what Nicoline proposed in v3 adopts a similar policy. So it kind of
makes sense to me, except that we should not return -EBUSY in=20
vIOMMU destroy ioctl. Instead, just decrement the reference.

[1] https://pubs.opengroup.org/onlinepubs/7908799/xsh/mmap.html

