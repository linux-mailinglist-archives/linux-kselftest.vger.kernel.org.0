Return-Path: <linux-kselftest+bounces-32500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B6AABFC4
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 11:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A186B507417
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFFA26FD9E;
	Tue,  6 May 2025 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4LiLZ8H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A69138DEC;
	Tue,  6 May 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524212; cv=fail; b=YYGii6CEiWJND3jpZPReJHWVAelL6DwxiuDqlo19wEdDKoqksEA55u3AxGXzSV3w/thujB4MlB7kNVKgCcwV37YOT7vSFQ2nqskOiW46bQpJMmeQWpVn+20QgD1wROMTeqjOUdS6OSWTFqH1X/suLSGR0XamSLfSx0UGlpQ2++Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524212; c=relaxed/simple;
	bh=epyx/BipVlYeOMo+NxclpyzBT3fwK2bBOvoNDHF9ZXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PTljvVSHZQ3+cGMQKseA7KsCDqjTFVl8g8B67BMYw2SZTMHjCfrAQvWIdAqKR2nnyjw7qoXLPoZOtG0auA5Q6P77U1sYz378VNiWEvbMmd7KQz4xumR+dzyyUCPScddnluLMyD2hKY2q2nJFxj8DOzhJYEgTZX73ZY5q+OswSGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4LiLZ8H; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746524210; x=1778060210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=epyx/BipVlYeOMo+NxclpyzBT3fwK2bBOvoNDHF9ZXI=;
  b=b4LiLZ8H6HqQg/pJEhHXXvn5Ub4ippEFj4K75qpeDHTgVCHchlgAzVxc
   DefE79V92OaQYmLLxNmbCjTmtpe8HLTelgXxx/FDsynKodjLhP/vR8nX5
   5/LdpgTI63IlJgLH6mawrx18ouJxPpF0kvceQKhKdXI5jgdbSAw2cYu72
   N6S0lCqiIm+RKgRKydcBsONAyDqqhfLAs9RSf29uPksM0QGM4tIWqx0Sz
   2YRFiUicAltOmClQvlFS6RZSdh0D15DJbu1l3QPH2oTpLvFqx+PKHhu4V
   ixtOD5hVakzuk2IiFhwgEiueNpYiFx3xRhZclzb9ibXD10PYOtk1BdGzh
   Q==;
X-CSE-ConnectionGUID: SQQuXrsnTLWTWh3+wMo2Jg==
X-CSE-MsgGUID: ltPAm6NwSLeo0ReIkuHlYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="58810300"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="58810300"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 02:36:49 -0700
X-CSE-ConnectionGUID: +ezBBVQxT12Ezl0/jTnl1g==
X-CSE-MsgGUID: VYYM1YgPS/uTcC6QjICLGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="139619148"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 02:36:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 02:36:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 02:36:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 02:36:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGn7btlRj6/tFzI0rYEloesOKX1ZzH//MUNtjI/dMhQ2o14I8rKxqlv8nRyMt62zS3kmgMFOLGyLHb9zuxqNQ+Cpp11Ij30GJ2ygGDA/eMyRIOD9AZaLC9v3mPK2XN4gFhWFwlpqS+Sd89NpFbj/Yb3vmwKmbWp1++9gzrXitTge+vw1bbNE8b+uO8wVTq2rd2nyBEApSWs7o6CYWDo3Jwntgrtp49nV0ZBx0VXVu6lnz+pvo1iHhxHIIDHLP8IH+8uAAvsKsfByiKZANIJyvjlKmLCEwweI/LHovHj8wbzkprSQW+xrzdre13n9t8x4xJWShkMZdASZ2KJipfKpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epyx/BipVlYeOMo+NxclpyzBT3fwK2bBOvoNDHF9ZXI=;
 b=ympd8+FUWCdbpJtTwokqsvW4KHgtfHiNDt1/KtIggwswHFsT4aHCFNLBjtu6s78Cero355Gqx/kERYzeJrrcWoI5dX0F3IRt0K7jcF2nlu1WHLMziqCagEHfvQGdGd7If7rZshn39NCX1roNNM23ojvstw0hWUisUbU2gNFruupy+vT8DYPqRr/iiED68Lfe6w/hhDZ2lNadTzhsDNlV++Sk8MWE5mh62+rVVmgXZlrSHoFug0haME4cwVWQtDS87sCt4xl/5rnGC9Wt5QNTewK9Dg+oBlkOeEv06DUGpfinE1oAHBF5pTjIPaDPXaYP1Md+QZRc8fcUSwb9crO3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:36:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 09:36:38 +0000
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
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Thread-Topic: [PATCH v2 08/22] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Thread-Index: AQHbtnBgpkGgdbEd20qNTy9huUtOtLPFZrYQ
Date: Tue, 6 May 2025 09:36:38 +0000
Message-ID: <BN9PR11MB52762F5A464ACC68D78465578C892@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
In-Reply-To: <d44272c153e7596c3cef716044de3dc6c2a8254a.1745646960.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4904:EE_
x-ms-office365-filtering-correlation-id: 00f4dd6c-7b49-4ddf-249c-08dd8c818019
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?z8bHkyvURQaxxYAWyXiGqDuYQMzJfKL5yMnIyGRP5iCBDCIscWgCN5YET+YG?=
 =?us-ascii?Q?3/OU8nkVb/6qljyo3grB2V1zz58sEfZgtSbnJAkZydclfHeNMQZ9iWgDvefa?=
 =?us-ascii?Q?CanxHzsBUmbSJQDTofmuovyJ/7herQOCyaX8dhjR2M2JgGnUFHUkwLGNWC3X?=
 =?us-ascii?Q?SIRD+Ri5DYgq3nKoKMQcU9B53bdxmNkiAlAyRYWdgtSeeinx1V11nyYBBIrO?=
 =?us-ascii?Q?DCUSVHpmvAPkWMQONvjl+nUj2ahnOaQ5xOobFEIYUCJfZi2bzHlTH4WLX7Ti?=
 =?us-ascii?Q?M61/xgHx1drFooT7wdHlc1qsnQ0w45Q49bgs93kUHGFlXKWPqE/kSMONCYR1?=
 =?us-ascii?Q?2mDkqdBGi9GpXVHaoPNuq5GvObuKbCQ7CXND/Ps1Ld38rRqA2ZDF4q0r9jpu?=
 =?us-ascii?Q?kMhvpDZxgPtw1O4AUUpkCFWb6PLbjiCl7ZZ1ZfqF4GPupNJj/u2SxNITmHgH?=
 =?us-ascii?Q?UhR/ePW5wkVx2lHqlRS+VYf2Tc+MafHjfBFoDmcob6X8bVpVM/KkSkuTCPb9?=
 =?us-ascii?Q?FG6lq7iS6e9JfFMMeswZ5RHNhXVqp6HnMdrhGQHOKVpwaXSDQNI1TnJbriFI?=
 =?us-ascii?Q?QE2sw+Jf4vjwcHlU77S/uZHovH2Qi80LIUDjZoj5IdzW4Kxd28sv+cyLYp87?=
 =?us-ascii?Q?C1VnbQ1cLUoBgBcOm9Gvft382Zn5GuJ1ZKpV5gc/5Wyogsjf4njPbbFxywwz?=
 =?us-ascii?Q?NBUbYlneKbWPN+3/KRIpkn+R8HhonR118z+qifXbeZrl0Q92aJeT63vLVJ9o?=
 =?us-ascii?Q?t5IBngtIrwftShZSpGnFyHkrnxKZs8AxAT/hLzD3pB2jRNHM/I3xzpsUFPzh?=
 =?us-ascii?Q?KmyW3U9CCKw9RaDOVqhZKzNwpqwXIoWqo5BbmEpRKPa7ROc7qYPD5kyeYhv3?=
 =?us-ascii?Q?mgvAuXa3IEhax754Ah+lqGDnzcXRptgsQrXHDgI4d/PsQU7/18W09xo+9ie9?=
 =?us-ascii?Q?Ylpa29q/Ek+td3emssfLj7h2f+6HLMMhgHcqHfpqRkqcXQ7qTHUp5xoR4lH2?=
 =?us-ascii?Q?pQMejxoKZMAfwh2pG5AQK/EDr4tYvorMmUfJ7kKLVn9Ezm/EvBMigX5A7DGr?=
 =?us-ascii?Q?K5Hyh+rLxrydHiGcSCgwDEJiU60iWnP3HSHm3+fJ39v39ONnqxNwVtOASB1e?=
 =?us-ascii?Q?PC2MaHEJeXand4TqQ1M7NMceHKg7qGigyUq0wqwGJuwi0E486pH5eqdURGzK?=
 =?us-ascii?Q?1agxDKFVMqW9RNHWsY/BZwJ9klWPWXWDA9pbk6VNu4rmKnHhWWpXhgWpGwHv?=
 =?us-ascii?Q?vbatqluovHOvNOw2g13tUJS9FmGCk14dYEycQh7tPVfewD1bwhRxVFl7y/u3?=
 =?us-ascii?Q?DvE8sj4rwgBzoVTkKRqH/SxlG5qF7x9hce6f9lTI0K0CyuulVrVtcoPfOL0Q?=
 =?us-ascii?Q?xp1jLdfNcw5Ul/4B5zm3FGtNHwhAgpHWn5j37CeD1gLNioKZjAsm2EyRZZoq?=
 =?us-ascii?Q?twdYBZoPXDVlJPnCTFKv+QbIkkmwue/3RTSh1wC19fwHJLgWomUvNhA6GHaE?=
 =?us-ascii?Q?jf2rUdd7fszJYuo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8bgiHFIYkK/KDH9jJ4uXVqZlW/79lt+bho6RAt896qOLy5I4E35B6crVgGel?=
 =?us-ascii?Q?hHZFdvVQaiiNzXxGeKjSiknVrXCgsC6/kH0XuOPf2ZZWxcOk52asMCXu68kx?=
 =?us-ascii?Q?PX7H6SK6c5DzQLlolr1nOBrVoaawXnkIr++hGSQgWTkXIF304BoJy04nZpCp?=
 =?us-ascii?Q?GPKBTJk0S0KP+L4RT1Qy7jWfzBHA8Mqs7KRVdInDhPBzMCY8/aayv7x9zAgH?=
 =?us-ascii?Q?YMAFnCq2mz7oBN2xfd0ImueuttqiOgPYBuU278V92a447AsOmy5iGTQM6Brx?=
 =?us-ascii?Q?ni/h+Cb8HSF1V8crHe2aa0KTlXeoRWLWYcZYlK40cyZurSatihhuTzn4IOGK?=
 =?us-ascii?Q?Fd9pWDDLJSIKtr7kVHOIjN/OLNg5Z4aIjmd5q9gP/4uovHyubpTslCWzK4t3?=
 =?us-ascii?Q?9eDBXYDWUVH+dVrazxBKnSxjAjqIjQbhEVplQDfXORx7yl3w58jdRNd15YSk?=
 =?us-ascii?Q?xEGt0t1VhBsnCwAWvy/cVViyPQiV03Z4KUaXj7DsAs7p8hMLayiMbFZyv+8F?=
 =?us-ascii?Q?WfwGAccZXo2uY7GIbP9dKysjR7R7IzQ32x6blLl6NNkJxxD475s0YPAOQgsD?=
 =?us-ascii?Q?BM7Mfs2okZDf5yGy566yR/iPgxatwRQpFcA2mGtqU6i+PDAs9G4UONbK4j35?=
 =?us-ascii?Q?l2fu2y3ZVpHpqq4Fjqm4Wf8maqm8ILFfU2E+2uSIw/9r/zr4B3D9LBdf3SUl?=
 =?us-ascii?Q?xuJB8C952wxx7BFYYZ9S4cJnssigsb7VHLOZj3gHr5hIIp3A0YpmLb/rYUai?=
 =?us-ascii?Q?679NaukpWbh9lDPoXObncSn8cuEdNxUgbYDQWSgg5DtziVl6blqP+kqtmSEE?=
 =?us-ascii?Q?jcyxZPkuyzDx2QQHAWuGLoxue6Vrz0J74FV989+BCrLB+y5GYJixeearKlRZ?=
 =?us-ascii?Q?NY3msgyql2nenUY+PLSmXzVNYDlIWBWzDmoJlYYS6Y7FvwN6skoXD/yauqOi?=
 =?us-ascii?Q?ZaaK3w59looPDq4WSqnwcd2FZLZkowWZ4Ey7cNQvf+3bGCNzuFgE66+Ox2rS?=
 =?us-ascii?Q?sY0CguzovMU+kuusCalaZrijIjAqWknKvdDMM0Qpic5F5GHfkT+BygByEQuv?=
 =?us-ascii?Q?pEWgg2795bnEeWHReg0bv74ejxeMKg6l8ppn5sCKdEBY3gDchVX2JUuIr4io?=
 =?us-ascii?Q?61lKnihz8a4cJYS1GeFbqzi4eDWxWBLBFkQI52v7gfhACIswr3sH6yK5xxbO?=
 =?us-ascii?Q?zd2UFRSDk4l1ybuoWptUJkLGHLryXxuLD4MiLavnwF8E8gT/afzb4wtvWQz4?=
 =?us-ascii?Q?3YjJUd6UFCLxMcV+f7MkhFxi95Pp+4HcHevam2mS41KrP62jnPy2JeIy84Ef?=
 =?us-ascii?Q?Jj0H8D/OPIW4OKT5ljnvzMx5FyyzoBzPYyYmOfjVC9n8IYkdgWYlIVI105DX?=
 =?us-ascii?Q?4e/e4pPYLSyeofCpueMEIaNeymyOmVO3hI/+y915O/9U8tQK2wY8hzPPDCs1?=
 =?us-ascii?Q?U2HtP2IuflwDZ+LaLOVZTLPR08P8tNwOeScDzg/KgZuCwqcy7s9o2e8CgA1m?=
 =?us-ascii?Q?DjDCUwdE6mUo649KQ8Xmu1Vd6NlCZ1dALK/f5T9jIW7Curl4iNhKfa1Bk/jU?=
 =?us-ascii?Q?5RsJG+Wbo8mtv2G6YcjPUcnr0KuDqcBEkqBuhe2m?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f4dd6c-7b49-4ddf-249c-08dd8c818019
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 09:36:38.3546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCEVBPWLwjBqGPF7K0Cmri/Yoyj0PEY1EmvuHna5EiSKzDGEXNPg0wvsyyk0NQuxPAIPwLVtRtlLm4oBd3EM9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4904
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, April 26, 2025 1:58 PM
>=20
> The new vCMDQ object will be added for HW to access the guest memory for
> a
> HW-accelerated virtualization feature. It needs to ensure the guest memor=
y
> pages are pinned when HW accesses them and they are contiguous in
> physical
> address space.
>=20
> This is very like the existing iommufd_access_pin_pages() that outputs th=
e
> pinned page list for the caller to test its contiguity.
>=20
> Move those code from iommufd_access_pin/unpin_pages() and related
> function
> for a pair of iopt helpers that can be shared with the vCMDQ allocator. A=
s
> the vCMDQ allocator will be a user-space triggered ioctl function, WARN_O=
N
> would not be a good fit in the new iopt_unpin_pages(), thus change them t=
o
> use WARN_ON_ONCE instead.
>=20
> Rename check_area_prot() to align with the existing iopt_area helpers, an=
d
> inline it to the header since iommufd_access_rw() still uses it.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

any reason why this cannot be done by the core? all types of vcmd
queues need to pin the guest buffer pages, no matter the IOMMU
accesses GPA or HPA.

Jason made a similar comment earlier [1].=20

check of continuity is still done by the driver, if HPA is being accessed.

[1] https://lore.kernel.org/all/20250424134049.GP1648741@nvidia.com/

