Return-Path: <linux-kselftest+bounces-31524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30008A9A528
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 10:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604707A9CAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 08:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B431F5841;
	Thu, 24 Apr 2025 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LM0xbvEx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4AE19CCEA;
	Thu, 24 Apr 2025 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481908; cv=fail; b=QJi/Ql+rMXN+3siHFrZSu1jxnivXROhCDDbWApF6TcuL7YOdXY7A06JSajpWfKoQGq5709Dp2+3sKevqRilJpZspKI0tyUkLpPuZEYzH9cfX13qV9s1NlsE3h9/JKUOCIL9nRxc9+xP+IIUM5CFQk+FBAMu9Mci3iijeT1ajWy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481908; c=relaxed/simple;
	bh=JdorC2mtBcyXJLdNwEghXbxjjENtqOgogY4QWF4fsMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jhilu+xyQ+K3xOXBK8MNDDvXYQ3Z/4zXHRwplYbDNvNVfZ/UIUt6OwJDmwrUuhJCeh8k3lA+64KCnFZ+rse6ehEaSaJfRQEXyHGSqy71cgbaEfZmav0iWJoaBqMliGiZnDoy0aeTJVzurreQKQ24qgeoDWBxTQvGustDTD67Dkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LM0xbvEx; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745481907; x=1777017907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JdorC2mtBcyXJLdNwEghXbxjjENtqOgogY4QWF4fsMc=;
  b=LM0xbvExrRqCEg93RvdJtHxIP9m2XySJMZHebUCtHbnfiKKIjmPTktJ+
   8oDtEiL/EbL1Kxr6UTY2wQoiMgz2QJ+ZeZk8+qF4nFBZ0qIr+uw8bgOMR
   CzlpMtmDmCBO+/WBuiGJIXKvORYYNl0bPB2wqbP2VGs5x5ExW1d+XZtkB
   fiB1bMus7BG0bWoBb1iQpz4PjJLzG25DUlrTWUQAyHn/PPXMrq321vbuV
   FfOZfNKgoMM0TBcHDDhkwl67Srkatw5DQR1El0lw1HwPdBGJ+QL+IeOuw
   T2gTQmCAN1NoBHQziuhXEFEsuND23BZ+vQ4tZYaGEU1prHDuyanb9VjEo
   Q==;
X-CSE-ConnectionGUID: ZE/Pt9uPQVS9cSi1TcTcBQ==
X-CSE-MsgGUID: 8RMS9BW4Tau5Kw7O5eQLKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="72478064"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="72478064"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 01:05:06 -0700
X-CSE-ConnectionGUID: 8Z14SGiHQ2+uj6LZFZUF2g==
X-CSE-MsgGUID: MidFrH4cTeG7dsuuQ8W2hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="169760487"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 01:05:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 01:05:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 01:05:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 01:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9Ko780STrqhjW2gTDE3YDqNRTyOBHPUSo3QuTlc0sG6AbuWR0M7ar6si+LhW5NtwKcv4dzkLXl9gVK32RACVvsyFD3npPdIjFaxsRaWSVrQd3GuKK08shNgMVmQIxK6hXhbHLp4LI1bmxI7OepIdg76fUDPny9Vfn9olH3NyIsSyzbK/RD2usPHU4ILTMte9LGRZ6FXK2uTz7viERxdm8/tAiPVa1xOtPHwRrkpsh1Ov7xWcDUQu9xahzgooMREU9YCYWGivwbLBVflCkfP9SkpJHUhhnh4jkVTYF2XlRWL4u9QFqwySHfhvYcSdVSL5jPBj7PH6fcmGSF4XsloWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l39UC8NL80Ju8H7p682uZ6XP0HvEAxX4U2pNvyRZQhA=;
 b=RevfR28VKUALeJZAruVAR/k3Qm0StRC/dCtdXL8ikcIXAPmPlzOT7T2UJ3w742W7daFXMYo/zhWM7z1svYuubdVDHJxQ+9ThN27LTdJNPYvy3ZuGQOQUDcE5tuRqFRT8X0rRAc26wthWkUFTSwieRAvSzsyJlPp/8tgvz2gpThs2MjIpDB2B2YvmgNyHhmYbWoselYC+Laa81klDgeFUP7oMW/bR4SF2ORCaukO/VOkfq/bWecROuM49ghLo0pSjRfAlZP45JbaVkiKlKb1BOM/wbmQnNd1LfzLYStF0xq3rsg9ooFmi6kyZOKDbbpI9swC1nQamTQKxdA1u35s/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 08:04:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:04:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>, "jonathanh@nvidia.com"
	<jonathanh@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"praan@google.com" <praan@google.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"mshavit@google.com" <mshavit@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v1 15/16] iommu/tegra241-cmdqv: Add user-space use support
Thread-Topic: [PATCH v1 15/16] iommu/tegra241-cmdqv: Add user-space use
 support
Thread-Index: AQHbqqxzvBTEpSMJPEeJw9EUJl83NLOt2BuwgAC1oICAAlwGwIAATjeAgABuioCAAE7PgIAAgA+AgAATsuA=
Date: Thu, 24 Apr 2025 08:04:19 +0000
Message-ID: <BN9PR11MB52762DC01DCD12C16B72678D8C852@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <30c7aff68c35040ee637629cb9fc2b6e7f83f76c.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB52768197516FB895146A12078CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aAaY+f2/jw9NaIWF@Asurada-Nvidia>
 <BN9PR11MB5276220C7B2C5743DC8364CB8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250423115551.GC1648741@nvidia.com> <aAkyAbO5UQRySizN@Asurada-Nvidia>
 <20250423231333.GN1648741@nvidia.com> <aAnfiUk1TTlkpkRE@Asurada-Nvidia>
In-Reply-To: <aAnfiUk1TTlkpkRE@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7551:EE_
x-ms-office365-filtering-correlation-id: 6a2e9a6e-300d-465f-a371-08dd83069db1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RTU9DGR/Z+wOo/b5dZbCQ579OLPdjlIMpxdirbpX+6HrSqiQQkiLfmp1KzzN?=
 =?us-ascii?Q?rSZwHD/7NwSPomFxz46hpOK48ic6DFLbpm4Z8arQE2JLxI0dClk3XBbKH/Lk?=
 =?us-ascii?Q?WPJdO2ek2eoDk+GbxpgZqvwa6cdCNdTrtRBCad03Xd1M4xd3zirak4RCVdqF?=
 =?us-ascii?Q?SMv4Ymic7wbXocPgjuvq6FvPdd40KKfolcWzS2F5bgX2pYi0/l1MGgzMwA2y?=
 =?us-ascii?Q?blZ3S2kFp8TIsQM6TZJgFdWoXoEBBI/YSY/YVRQQcOIZjQ9vnNhoSkET1r7e?=
 =?us-ascii?Q?gThsjOPK+nJ/Y0wXylX+Ps33gv8j9p1xBULq6oZHwS15tMNlbk5DNpyduV5N?=
 =?us-ascii?Q?Ubo/Isc5ducl803QV7S6x11Y3UskyhlP9LmYXLJNZx8Xsgdb/UZbW323901/?=
 =?us-ascii?Q?JV3+jopoqHCRWAZzX6jAOs8w5hWqTGdRtc7n47Ai1vmLjn1YEBPmDOpbdNWm?=
 =?us-ascii?Q?nU93dp2cxl74Xo6IXjzQMb/8VLKZzUyJD3xoW/3rc3ikJgzPagJjci5KgsbB?=
 =?us-ascii?Q?iW+dWp4pdm9DI+b10j2V3LUs414Y0QVya8ExmlGM3EqWTw8pZNslGFLORv9w?=
 =?us-ascii?Q?aJ5wOIUUoDX4EQI1mjbuXbQDm54cA4VPpBOzJsXkB2y8zfJ8NL8kfWH/f2XL?=
 =?us-ascii?Q?l1z+7O4Bxw7b/z8nKZBmwJYjZy67ppsZLNXOWw7NBMNz+QNhY6SEpBHlNYLc?=
 =?us-ascii?Q?0/IB46Cim61p5SsoAdJzRIjEuhDBb+7oRxaKyIkOZOiknjzjDLNVio3h7cC4?=
 =?us-ascii?Q?a6LyLXxc9qdjHDb/7kTEoCGcmJrKOKcK0kmG1o4mRGP7zZOfywjb+Zn9XuJQ?=
 =?us-ascii?Q?3XuvHkPsD1R5MxqJwJJRbrPfe8cSIHh+h5AeYCGMBo4a5tOFtniAhUg6SWP4?=
 =?us-ascii?Q?wVzqvA5+FNhVGtAwUYT78RqN3SSIeLK2SI9rJxMBjTiFnqgN+eOli9gD56nd?=
 =?us-ascii?Q?Shr9qQL4bMRsjt38GVd+YallretCzW25ZS3az9X/vcDNthBSl+Vch/0Z2Av+?=
 =?us-ascii?Q?VWpeFLhf5xKpXC08JOEOOHGC17a4Zyl5haz9afTeH3+Nl2yIiVQlTFHpmdzn?=
 =?us-ascii?Q?jbzXj9u0EtZCfC4c2VZX0oTZMbYoXIU8CU3jFhlZ5/M4nI3lOYfNVrmR4qJ8?=
 =?us-ascii?Q?dTO0LmpuQ7R8nFZu6ZTh2TrNi68tmBcHppVFX2uzClX5Zwn57LY4TvSpLbjl?=
 =?us-ascii?Q?OyMoMI9AelmSOTA7dUvbKpBrgxqR5kfmE4EIxfSVE7I/t2asSnH+gLP4W9vY?=
 =?us-ascii?Q?XkRgMYNEqfz6sG13mFOqjym3rSEXyGxQJkldRgEitMkLC1K7OYFUczWmLk05?=
 =?us-ascii?Q?7q7ZRenV1MGNVnKgk8wUnq6IhT+5ncnCYHKPjUBAsvi24zcPiLOQ0ynoBjyY?=
 =?us-ascii?Q?j0UeC6VwdQc12RiFu/wgwYXLKAq15ILOWKJa8UBXzH7iJhO1uffaVNRlMWS7?=
 =?us-ascii?Q?k3Wopcthx8mYlbTClAR7NjHUtl4g9cMAqygp7wlrOgRIuSmgUdb91Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gnAz34kCQW7JxqOvYiuOWEgeUL8bjxx902+L7hfdZyhLOrp4VeG9B8YM1ZOa?=
 =?us-ascii?Q?7Ha505xB+FUbiFjPv6pC7evJbpoFnPNKUUvZOyHGTIkaK0Ck55UePjvp9PYl?=
 =?us-ascii?Q?Xy6kMafXaQAohOqIshPY8MUcv3wqiDMemKyiopSQW1vXfUEcNI5MpIq4Dn1X?=
 =?us-ascii?Q?ZFo9mQNRu3b+qYjDJg7QZIB+iIUn3LbLCEw84rf98+riVV5Lv7Ez2ImEy9rF?=
 =?us-ascii?Q?I1yNn5C8JbEidUei7mVRGeZkarFgbviLaSiHFjyhJCfHSDCiWC3PmOvtse47?=
 =?us-ascii?Q?u9bDe7yU04ChfFlXEsyeoS2YDuJJUpTmb/HILqpLDDZhmhihEQPNCB+AOTyo?=
 =?us-ascii?Q?ANvI628dNEOX5gntD9MhmZCIADoqvumgiLV/WGpVOmFUABkczkPNE5kJpXy2?=
 =?us-ascii?Q?Gelcgp79NPD8sQH66QsHLKXgkjui/b9hkWlBUaepOAkll/H9deCJ3rCwhzAP?=
 =?us-ascii?Q?A6d2RrzmGdF2IE+GNiYj0mMhXIVxbgqD4F+595jY+9R3XcUFyPK+VS/OQWhQ?=
 =?us-ascii?Q?zZ7k/z+q9Y+QMUzbwoblWeBWQAoc+0HG6BA2lYAIkDLfZObn96v9/IJqs+BP?=
 =?us-ascii?Q?tD3wShy0i41bMJ07p71kDJBjEvT9aBnFxSK3a6Zv99KOOIKTzgpaNCJKBtTx?=
 =?us-ascii?Q?zFaYCrAi+evuJfIO1QyZPiMnY7WjcPYycjftM5vIYauk9j6p5GUmij8iyIl3?=
 =?us-ascii?Q?hMAlYdltCLkqkQkhck/u9AWMtKahS/Eu6ew9GulZAVbtIMrRP/KpYaPV1qEM?=
 =?us-ascii?Q?Nv6FVV6cuz/kniaOsYD6kodp5aULjAYzciCeMvJ2mOnD5+d8appf4aCBxQKS?=
 =?us-ascii?Q?/LUjBJfLTLv5mHDg+3pFmgk7YvJGNqIYdAJfqXf3JqnwHWTT+uMPPbD12/vb?=
 =?us-ascii?Q?OLpLx1JQ1XUznc4nNquMMg+2RgWw5nHErw2qg6sOc6y/IiweMWd7e5I5tIHd?=
 =?us-ascii?Q?ELCD1ihpI40RTTgUyu1vkMYIxICxiE48fccuD+p0TeEsbWnqnQae3VOo95lo?=
 =?us-ascii?Q?VBv+k0Wksp7NM9vccXgpG4H93ZJ1Fjck7EGN3/KgV4xNBUmP7Mb5qwb7BsSu?=
 =?us-ascii?Q?RE6JIlo3gKUz+9+AO4dKcPvLHEW6VSzAFy5OcB7XzlgRUVqPPxrhlevwF2PJ?=
 =?us-ascii?Q?u/ylbPFxDy6hKUKbcwX+KIa0o+zOIEWZtv5C4zRkhUYxlIvBf4JmsMdV7/6l?=
 =?us-ascii?Q?j/BeuSLv5PWujg4O2ZxWBpVIbzR2uBLHGUCDIHg0zzl9Hzj/YBApQV1x3RfR?=
 =?us-ascii?Q?6C7ZmnZfWcL/97qGZe9U+df6hJthpRbaqIU+gOFUFYXX4sLP6GKxgR9tyTYI?=
 =?us-ascii?Q?Wr+6VsEXD2PGgChT6yxqK9Z9W0jybytnetj3djtWUTTA3JlwwKDP+198hBet?=
 =?us-ascii?Q?yUjabx7hW2Z6r2ap995w3sAYKcyetnZpRiotlmYxYy7noVgmF2sstqEfCA1H?=
 =?us-ascii?Q?sasn0e4Qxr6SD97gYiavDXxjzZLWS2vnPevp4ZBpM20XVhlRbf9KG3rp4YgF?=
 =?us-ascii?Q?Ne//t87UDAyKfOsNI5DUIs+cE1I+y9R9UkfgE9cBPt9l4aQkw7fwhgXOWIYl?=
 =?us-ascii?Q?nPme9+YlaVaBcrAJyR6KmmK4KDMxXgxwVUImmqeq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2e9a6e-300d-465f-a371-08dd83069db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 08:04:19.4558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNIgJSk3R2mgNqc/t7oIERcQnWQeUSFQPbKQdGTw8Jbpte+KghouzzA8y2GOtpnrApCJfNwJ0UcpGD4Mz8+a+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, April 24, 2025 2:52 PM
>=20
> On Wed, Apr 23, 2025 at 08:13:33PM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 23, 2025 at 11:31:29AM -0700, Nicolin Chen wrote:
> >
> > > > It also needs to act like a mdev and lock down the part of the IOAS
> > > > that provides that memory so the pin can't be released and UAF thin=
gs.
> > >
> > > If I capture this correctly, the GPA->PA mapping is already done
> > > at the IOAS level for the S2 HWPT/domain, i.e. pages are already
> > > pinned. So we just need to a pair of for-driver APIs to validate
> > > the contiguity and refcount pages calling iopt_area_add_access().
> >
> > Yes, adding an access is the key thing, the access will give you a
> > page list which you can validate, but it also provides a way to
> > synchronize if a hostile userspace does an unmap.
>=20
> The new APIs are very like iommufd_access_pin/unpin_pages(). But
> to reduce the amount of code that we have to share with driver.o,
> I added a smaller iopt_area_get/put_access() that gets an access
> and increases/decreases the refcounts only.
>=20
> Yet, this still inevitably doubled (-ish) the size of driver.o:
>    text	   data	    bss	    dec	    hex	filename
>    4429	    296	      0	   4725	   1275	drivers/iommu/iommufd/driver.o
>    text	   data	    bss	    dec	    hex	filename
>    8430	    783	      0	   9213	   23fd	drivers/iommu/iommufd/driver.o
>=20
> Meanwhile, I am thinking if we could use the known S2 domain to
> translate the GPAs to PAs for the contiguity test, which feels a
> little cleaner to do in an IOMMU driver v.s. with a page list?
>=20

but w/o adding an access to increase the refcounts, it's unsafe
to walk the S2 domain...

