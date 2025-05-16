Return-Path: <linux-kselftest+bounces-33156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2156AB9429
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 04:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B0CA082F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 02:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B522B8AB;
	Fri, 16 May 2025 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3SV89th"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6922335BA;
	Fri, 16 May 2025 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747363791; cv=fail; b=gxoBW7l1GMGYaG4cGHMFzF5Ubic9XUv+E2IWHuK0CAWIjIlEs8ZEteAT/z66szv6Vj5BP7q4iLqrBfjWLRrqbC514/0lvC2HYhWhTtv/r8nSqFJtUKNUdGKxPwtPkOFj65uL5wknDku0wdqxCoXIAUNAuvlLnmeof90Q9DYRuF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747363791; c=relaxed/simple;
	bh=FICPPlyk3qY3cSMIISQI/HpIkLuoK2k96qnrZQqIHEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bDtRz71KgUdxToow0w+O7MFqvlIrM1sDhvLkpifthR+304w6QfLoonuqIrgmcPAa+f/mSZougWWUfV7OYncZ6TZNy0U3X5pFGriumASzaiTW/X1FNcP1vzDUi6i7q7D8mbrdqpjhAb4kpkXrLEXxIEGxbGsqbqsbBQa+82oeJvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3SV89th; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747363790; x=1778899790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FICPPlyk3qY3cSMIISQI/HpIkLuoK2k96qnrZQqIHEg=;
  b=M3SV89thmaFrUMI3/7VaRUbH6E8M0dH5tOHiVMwHafxMd9jY1+LYPbgf
   mHMgbMSI/6f38HH19Cq83cXUH41RnWW9E6L8L/eyp2gNCMEP1x8tx7iw3
   hmAoUhKHmp+JuZKVrZ/QS2kthFoPwbDnsWr1XZbYUXPVIwrLASq0JsMnc
   fn3hwZSxXYXPCNX2YTV/rjhLq42rBRM4VTpAOlkFE9NJpk4V4/+W7K5QK
   Tp/18WElIGEi0J+NOF1XhdB4OplcL4xecSlrz9i1CSRPRYsRSUoR0eJnC
   vtZXVD9lgKevqEEGt8mk2fTabw6FnO1gGZoo3lei9IeTTYB4ZVAPzFv4O
   w==;
X-CSE-ConnectionGUID: pgz3onUdRw+uych5qD1/Qg==
X-CSE-MsgGUID: xXGqAHEeSgiwu5xCfn5Cjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="36943702"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="36943702"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 19:49:49 -0700
X-CSE-ConnectionGUID: D6aK3mNJTdSy5YHQQRIP7g==
X-CSE-MsgGUID: UE5q9VWzS4qm2RIh87sYgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138602130"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 19:49:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 19:49:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 19:49:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 19:49:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfZiRZa5GW/E6hV9OTZJJ5vfT80zsWWX5X1GciECd0ymO49bNp3Gw3S/AoWIQs2iqqdAckjRAdcVNbsWNUqI1Bw0fi3doJWTumCLT2QMe0IoaGlgdFU4g4v8mYvv3NmE++u0fop864Il5nriW2r+1VekkS0mzirckaQI0ZLWITCsX4RBCKFiuGNtG9REX+wtNhuiscFc+cWHFbUbOZv+XehvBduS190Drm9sevrtC+uTCBUWP3Qs0C9H5ixwd9XooJxpupCD++BMZTX6R0/jZWzg8UB/QKOp0weUgba/McR3Wyd9Iio6OnOgj4/DfbNjQuIaQKkhIYdxW/k8aVLg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQuR/VOvBD9qGQzEOVYqX7UkpSEGTn+AJyf/NqdOdkQ=;
 b=JoAG1UC11jezmUJ3QfrHbPrrg8Av5b4wfYO4JlUTlNkD2crMZUDnTP5LVOgi9cTGR07skb6G2VJj9Pq/yPMvtrOC9NcREzDXSXFNKKZykDQUOpPgMKxiUrb03HM4OQYePQy2XkpUf6Ept3R/S9camNg9N4aQBBWSgDdNbVUEGn6zNOtZatJcu+vyj5F0bYb4PGDZAqglBzb+GmJC2aw0ionyWrf5jxYKbZm09EvaBekhwzqmF6c8s8GTs7wsn9OA0MV8qdKubcdpeuWccBCd07mD6mxDhd1PG/1KcDcJZdK45s1DZEa00ks55Z3xDyQFcJ8xmtQyNaZGBdVCwWpJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA4PR11MB9011.namprd11.prod.outlook.com (2603:10b6:208:56b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 02:49:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 02:49:45 +0000
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
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Thread-Topic: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Thread-Index: AQHbwI8AVK9WzAglbEaPfz4i9w6907PTP58wgADSFwCAAIWNcA==
Date: Fri, 16 May 2025 02:49:44 +0000
Message-ID: <BN9PR11MB52761839AABD5AA55DF3FE118C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB52761EF8360BEF5C19C2382F8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aCY2GKfMh6f+vXHj@Asurada-Nvidia>
In-Reply-To: <aCY2GKfMh6f+vXHj@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA4PR11MB9011:EE_
x-ms-office365-filtering-correlation-id: 51ae7e45-32a9-446c-f1f8-08dd942450b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BkH78QTz4ih4I14xlT3q1cL/YPXIPElJXB302dNe8wKZay//LIS6UI/0hb0q?=
 =?us-ascii?Q?5DI5z+BxhJZIRXRfEjXXTxq6yBqI/qLeAAVRTS6zGjoVJksbI5fBiFCQElii?=
 =?us-ascii?Q?/BlmcQykzJtY7s6pNp+oyJSB34/FHpV9JeZK/kmn3VV+Gth5M6RMRP2PRI/n?=
 =?us-ascii?Q?GIGBY0DM0l0L5VMuOrC5mDI+b7wA8bRWbUHuj3n6N1IC1OhWnfKS6N5CpsGH?=
 =?us-ascii?Q?MljBBVrxwMNMHSVUzb7H5MtfNMEfRA2h0L+tuzo+SOF6ztrRuG3h237zkjM9?=
 =?us-ascii?Q?MNfko/X981h4fliXtGx9gHVZAPH3uV21ynb4NPV12YP30uiUyTm39qFzb+Z7?=
 =?us-ascii?Q?Xd4iCiF05FOe8+8RnbpFmaHOsUUUKZ7X4jZ54t1nj+vJbo/U9fc8L0BjJdAR?=
 =?us-ascii?Q?RI3ZXvqZS2wi1CIBh/FnPjNJnjpOGBZUJ25+oaXa2NbLlioj7ZCHDgcO66qL?=
 =?us-ascii?Q?lwpKOShstJiNNYSQloFKHVtcoD+kgJ3QE2T42O0es54l2hePxMf4L7HlH3cL?=
 =?us-ascii?Q?WoK1Qy8GQxhODYeVKUhnzs82XEYUHXlFcELK2Aew6+YkwzNhnR2uwIk66+pT?=
 =?us-ascii?Q?R4AW9d0EdtEMfWW04SwDCkXmxV800CdQi/dnPtpzOsVumQnGoroDfTSFOs+6?=
 =?us-ascii?Q?uyv8rTFFa2jivvc0+HjcDfKUhHrAPO/Y4weeNnuCIbcmx59AnRP1mCJO5Fxz?=
 =?us-ascii?Q?VvIn6QvYKuxCC430VhlklOqgqEOAqL2fGP8QTAPrsYLMyd2kU4NaWeHDq1Ax?=
 =?us-ascii?Q?Xkn6Q3jEFPImB/orH40fw03iYL6eZ/NWZtzZ98G09ajE3Wbs57kPLZFUD/pa?=
 =?us-ascii?Q?Vvxy+h9kbpELbGnB59jhktJYIfriB8uhBKV+2EGt3gh+qJ1NSnQ5IzjTzZIs?=
 =?us-ascii?Q?urzs/af9OB8IGqtCzTH0ihb3gmsZQtE+1pFTclE56gqwcleO6kLcyG1v2Yu0?=
 =?us-ascii?Q?w3lmiGg3ncdtbeZqhI+GZUrvHsQWmUvWFrR/iOs9BuoE5PWQ1bJT5S8ar0Jj?=
 =?us-ascii?Q?r748c9PbGuQrLVYWAOPxkWZlzpMG0VoMJ4c7cOcJ5zFlMsMCqROrARlWom9R?=
 =?us-ascii?Q?6LThNOd3hDmatKb5P6ezcVBOhhtJRqyTMpWuNh/cYgxx7BFnNLKPqT+j1F83?=
 =?us-ascii?Q?/ihnxpnNv5WcBR6ZIAbQQj3H/n++8hpthm5XShiiXtTjAYY+LFhFUaN4Qtxs?=
 =?us-ascii?Q?q/ErwfVNrGukQQLSyOOqeJLWMbfMr2tf+e2sTBfy8NXwIFN4wFWiwg1ljSfQ?=
 =?us-ascii?Q?vYnryyQI0KlllBFR8gInEU/mldZDLP6udEM9OQto6HDU82rjDI3yJOmQUDKv?=
 =?us-ascii?Q?c1NhCEIowZecyvenH2mUtdvhEagysTd2Gns8cMPnNZ9r2Sucwp99Jhuq0ec+?=
 =?us-ascii?Q?gK2rZAMaIRFB1mz+tAnhCFtOlZs6XR4A23/6Rn3Aq77deYIei29tKI/pVy1D?=
 =?us-ascii?Q?HOLaLyBgyiyPVnjikK+/RHj5ycsS8vBGkiIZcxkmL7RtZGcvx+lp2A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xGJNTK/VAHoy6JS1lb+6sC5GDQhKfA3u2Ye669pS/bX6UAIn4CLBAygGkoC4?=
 =?us-ascii?Q?rUXN4leREhN3c81WaGebgn9Yl5xQtgMWfaBZCVhMQsMKkZMAjCp0LMqaAS4G?=
 =?us-ascii?Q?Cmio7g01P+qDU+Galfnd3cbgO25R565nnH5bkbVGfoBh4dfY2c7+14tnPbvV?=
 =?us-ascii?Q?0uQJKe78YH7kTV4XMreRnNCiUjBZjd35J28iNBlUzXW3Wcd3RsqejtmUUoyt?=
 =?us-ascii?Q?xmd/2ViSPoYsJ3epQnrE5fZoNAw47uObaeMO5C97P9sFZatV8POe/18tVHMB?=
 =?us-ascii?Q?UHRN/0s/AxY+gQE+ecyPGOCpkTUTvMvm3vd/1Ebyj0bTRq15FoahnQClrHX6?=
 =?us-ascii?Q?QSZh6TXvEMJQZ/s9ClMY0r6kvYwltnkYbND2tRiGH8yqZOtJHWa7jJwA3k+m?=
 =?us-ascii?Q?U/VXGrzXI8f136chsW/lGI9gBZY/NyW70HvHawZ9+LGbgT3MXbauXeg8JYNh?=
 =?us-ascii?Q?pqjEgxQTlV0rtbtrXCqDmtPbbkrT95O/nmAlxrBCnT9/9cYU1T+sgsF9q1Qx?=
 =?us-ascii?Q?Yzk3FSu6UidOyANkMKtZMpEmiwxvu3Z2NS1OGAmL4TeWnEwbN3x4NozBRuaY?=
 =?us-ascii?Q?YIb3W18J23etUi68rRurFdwJTGC3cZ0pSvEeYNs+Q7Ur23fgxRvnIWiFHJNn?=
 =?us-ascii?Q?hk+5bYh5XxjlkFAIafmDVeUi0mdspjGAdM/uLw3nue2l4zf/cqsCUIBcuknb?=
 =?us-ascii?Q?ggicpiofxsDZj1TymOvtgfogd4VDHlpeZPRzr8Tu5Tj6qbO7ts7SMyK/pR2X?=
 =?us-ascii?Q?HxnCRveKDQ4EvHjnUMiCxpUcmOv44Ae5NHEH7VFyaqwJb8gXUdBE42hsa9DL?=
 =?us-ascii?Q?P/Y35sPLQz6Y5v9JH9AmmALL1U+bQG0qyUDYJ7wu8lHRNENF8odWh+t2/EWt?=
 =?us-ascii?Q?176KA+2nR7EVjNWldZUqzVRtWH/2c4k/2Nc5260IYuPWKeEDtnSOGg77/7IZ?=
 =?us-ascii?Q?FJMoQ1ksHx0NMbgZ60zQ3lgLik2JIM/7RJ16A61P/wZtTWLKP8OjqmDurzfa?=
 =?us-ascii?Q?VRZkP1s/Kf6I2oddeRIkgUZBoMapQ0qPzNaCyA7cnzDXsOMfBAIxPgz8IDAO?=
 =?us-ascii?Q?FVbdhA5RbVIiV3FGIZx/CB1ZHo21zsDYT29PPuF6gMPldhlBxBZfEJ7/sb7S?=
 =?us-ascii?Q?FldPwsCuQxIUKXo/ZYt81+w90zN/G1s5k3gqHQOzap7YCEPpSFbPd4AapBog?=
 =?us-ascii?Q?M2IOSZADABvzQ+mJCZpL3MLARHH/81DbjmZeqd3SNzWN6Zvmr8l8Dj2BDKnS?=
 =?us-ascii?Q?KqD6WoYM4Nd+OVgEu6BSgCNDBLI+A4fwYjHnva3GyQLHAXV0/IXIn8d+7qRL?=
 =?us-ascii?Q?Xiib4QTGHnZQQqvjKZJKqp4+ilQy37EdCostVysIZu2pp6lV/3uzwAR9STTy?=
 =?us-ascii?Q?N61tXC18qasAkxWdzSdrpAkADbSJAooF3OuDdh1kGFKkN+Fhk6uTyaffJl6n?=
 =?us-ascii?Q?5WjFtcHd1EU8NbYE8qojVRAIUAn/zMTYQVMz5w7dttUpMLh8PVXJ45KzYQim?=
 =?us-ascii?Q?QB+X48e2EcgjpdqqryPv92XaS+/iwUb6Kfa07q66stkP+eNBa82MFrwZovju?=
 =?us-ascii?Q?85OUUaBgZOXrkdHt230kmS/hF5t0LeRv92O/lpk6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ae7e45-32a9-446c-f1f8-08dd942450b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 02:49:45.0069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aj2QcgruHqYJ1ZUXrnNPfk7VjbXpI3LnI/y23bpFhncRTb8dY5SipbnAOWlPu3nb8rVF5UDPczj8hStIuwz0fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9011
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 16, 2025 2:45 AM
>=20
> On Thu, May 15, 2025 at 06:30:27AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Friday, May 9, 2025 11:03 AM
> > >
> > > +
> > > +/**
> > > + * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
> > > + * @size: sizeof(struct iommu_hw_queue_alloc)
> > > + * @flags: Must be 0
> > > + * @viommu_id: Virtual IOMMU ID to associate the HW queue with
> > > + * @type: One of enum iommu_hw_queue_type
> > > + * @index: The logical index to the HW queue per virtual IOMMU for a
> > > multi-queue
> > > + *         model
> >
> > I'm thinking of an alternative way w/o having the user to assign index
> > and allowing the driver to poke object dependency (next patch).
> >
> > Let's say the index is internally assigned by the driver. so this cmd i=
s
> > just for allowing a hw queue and it's the driver to decide the allocati=
on
> > policy, e.g. in ascending order.
> >
> > Introduce a new flag in viommu_ops to indicate to core that the
> > new hw queue should hold a reference to the previous hw queue.
> >
> > core maintains a last_queue field in viommu. Upon success return
> > from @hw_queue_alloc() the core increments the users refcnt of
> > last_queue, records the dependency in iommufd_hw_queue struct,
> > and update viommu->last_queue.
> >
> > Then the destroy order is naturally guaranteed.
>=20
> I have thought about that too. It's nice that the core can easily
> maintain the dependency for the driver.
>=20
> But there would still need an out_index to mark each dynamically
> allocated queue. So VMM would know where it should map the queue.
>=20
> For example, if VMM wants to allocate a queue at its own index=3D1
> without allocating index=3D0 first, kernel cannot fail that as VMM
> doesn't provide the index. The only way left for kernel would be
> to output the allocated queue with index=3D0 and then wish VMM can
> validate it, which doesn't sound safe..
>=20

VMM's index is virtual which could be mapped to whatever queue
object created at its own disposal.

the uAPI just requires VMM to remember a sequential list of  allocated
queue objects and destroy them in reverse order of allocation, instead
of in the reverse order of virtual indexes.

