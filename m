Return-Path: <linux-kselftest+bounces-17710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14E9974A53
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5568B1F22D09
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 06:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769F076048;
	Wed, 11 Sep 2024 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUPZAEuc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20DA7DA73;
	Wed, 11 Sep 2024 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035559; cv=fail; b=kqeSeCadSBF/duzwGsARzY9y3RXd+QFk3HvS//l42M4Vm/cc5GX7xNivfaLftcIRAr3UJJ6yCr4n+y1DfK1UeDcGzH9sZ7Qrc1ew6IsT/xKVJQkr7+xtjG/RCuG6hSZMwIDMnyvGhO5ZjM82OjUvZvfTYYVemsw30WU2UVco7V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035559; c=relaxed/simple;
	bh=sJ2EDXEjF42ZSK/65aDBhIalqylN44VZG/PPoBB/6po=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=snTeumR3ZNXJz5Myxpmrc7ZFD9VJLY1iqVR806UFgylfc90RCjrKsntFmTUv2VpeHIDaxomfgszlKCbd+Iv/WirZaHxZBjGrsgq3MDGDA2WfGceVm32yFc/DV0HAz2dmb7YWKzh+p8Aemh5xrhKf1ZpYhjekAg4s8LxYdpDRgwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUPZAEuc; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726035558; x=1757571558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sJ2EDXEjF42ZSK/65aDBhIalqylN44VZG/PPoBB/6po=;
  b=DUPZAEuc8Cg/g7pt3JgLuJgWUNtdSOz0V9mEYcv6SC8OOs5n29AvH1Kd
   PtSQcuM/3Wf5nyzszw984g/gdaxzAyfQdUYT4Bz8wjvwq2Rc/BEE4QU9K
   o5X5yn6CkU/nu66G8umgu2sE6g5wTOanFXPgOEpwJPwZk7wpg5MnO7i9F
   /URt/87+XpIirJyRznci3qwvVFRO6FJI+zGPcQ9R8VOdfdK7m82mt8mcQ
   c8MhrKwhZreTM6U7C1hhM7McLKqB94h7HflGSvIyE44VRI3Rvtv7bHgTR
   o2IRKnTZAhecPO9dJRtFJyI8NZkR3FbOA01iASqXamL5h0+93Mk/7nMlx
   A==;
X-CSE-ConnectionGUID: iHAK6ATAQDyd3NDMOf19Ow==
X-CSE-MsgGUID: 3y1H5wNQT0uCkpTQjl5jKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24692525"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24692525"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 23:19:13 -0700
X-CSE-ConnectionGUID: 5EqpizxaSw2nqyvPd8d/vw==
X-CSE-MsgGUID: uJNtkQoKQqGyXNFDxP20JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="71878170"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 23:19:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 23:19:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 23:19:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 23:19:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 23:19:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/5qJryCvgSzNbnTrBmZamJMl9k9Mwyb/a6MrefvQikmJiF+m/HoI7UCp3N0aVtj++SuAQhBJOuiU6OfinL2M9dUZ80iJ5KTXut8GIpVwCny2DZxUUUgrE/iz/7SKcO4Ko2VxzUfENqG6eEghEUSKLJgxUvElcFBoiQHlXu/8Zl3MKBsIoRx/0oH1IOkVbvPAqoXuJknKOJrehfOVlq+/wH6Pjm9QwZ+qIP0L98cMgvOV0bXdnirRGFVmqeWWMx9oD3FHE9FynhIUIMYlrh65blpBgs+X8dIOcESNsr1FX0XDfPiZOyOYBZlQTlb9qYtnrHZK3EQbzWQ2qovt5BGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ2EDXEjF42ZSK/65aDBhIalqylN44VZG/PPoBB/6po=;
 b=DaKV5FRbhsCd96fq2Ti2saOEUzqINb59Sw4f00afrAX5IzBVWifuS7/7cOnvJvq7qXt048+gPJyDX5LfHorg5/lWmgNNL0igbN77fa/SDhBffCkS3Fy2iVuKIvlMj3crTBdbMF8JJPEkSJybvBdocT71ISwf1Yxwsq0esdfDA/2B0sJZril0i2ISh+8QylZhPJ2AnmWL2q8EU3//jb9QpeltnOdXu6O4tEsaF7270HiS+MskCJXAbPftup4nxJJ3FQVk+/oMoiZayr/2t/QY/+ySNmsKWAbFpssgCCHjoUXTspkrVO7YMaI7h/XqdCXUJrKaDlsOl9TaUuRuVCO/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 06:19:10 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%2]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 06:19:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Williams, Dan J" <dan.j.williams@intel.com>, "will@kernel.org"
	<will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
Subject: RE: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Thread-Topic: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Thread-Index: AQHa+KLxhE3fl2HTskGswxeJI90kSLJJaSKAgAAaOoCAAAGWAIAAKj8AgAiDehA=
Date: Wed, 11 Sep 2024 06:19:10 +0000
Message-ID: <BL1PR11MB527144A489C069EAB8FB99578C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <20240905160353.GP1358970@nvidia.com> <ZtnsaWgeuuy7+cJG@nvidia.com>
 <20240905174326.GW1358970@nvidia.com> <ZtoRLlk3hLlP1c9Y@nvidia.com>
In-Reply-To: <ZtoRLlk3hLlP1c9Y@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|LV8PR11MB8509:EE_
x-ms-office365-filtering-correlation-id: f1626157-ed83-4c93-cbf6-08dcd229a655
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nIEz6CsUysgY0vp+o6LRgggaI+m+L8zFddndZACsVmgg5mR1YQoBLQ7IaC5G?=
 =?us-ascii?Q?SATEz6/UYmc8Ho48W4Eo4hqvcWe1hanuxajBYRD41iPFE10taDI4XriJrW5l?=
 =?us-ascii?Q?3FyR1FKuEMMI405xGVKyniQBhGcJLDOldeet3S4AN/IYXFK4sYOjYM3s+mJQ?=
 =?us-ascii?Q?9h3TTos7gc1EPl+bJ17lajXa/LdKzynpBWwSQ+9/D38WhexDrFwt0udVDEQA?=
 =?us-ascii?Q?/v54Y9L1QFMQwbYb4nF0ANiQnlPjJ0M0zy9m7zI2uMLvGxte4jL9gzs6TH2K?=
 =?us-ascii?Q?eocZJ0aqOBsqq9WJ7FB701kWQn0UY/RI8KS0oGXjWzwfTNCz67YZsQ7NZqO1?=
 =?us-ascii?Q?WCsxTNW6jeJL8hR828xze8LbZwLOLBeKYNFChzjdOREEPKqdxSrQPy5gEcsc?=
 =?us-ascii?Q?SzvSlqarVDbY7jNeaOmxsnysiYeX29hcAClyH0WaU5yljrgCfR5KTEtS8rWJ?=
 =?us-ascii?Q?bkL2iTfYD+HD/G9vvWw2iGmN4Jop+aR2WweyEEKy12kZPjVWeH8+/KOmoopZ?=
 =?us-ascii?Q?QdZk4EslVqvVXzPiaIjKHRfMo5FnCYackVMHnqJjblE/kwNtCbER9mD4UF9y?=
 =?us-ascii?Q?ak5/rmwdZgqkRF7VRzgQEwknSzMoyGX2oog7ETOsQffjmdZLwYoDvlhXhyXB?=
 =?us-ascii?Q?sVTAtVPfZhgvCdE1M5HRkQVKux7DXXNQZtNMPqjeEeXko/calOEGzGoB3Qng?=
 =?us-ascii?Q?VcGfr+75gTc/caIYT/5ne3WSppgzXx1pNlZrktCG2sl1XQAG/ZYKjPcvfJlY?=
 =?us-ascii?Q?orh75or3vD/aiYAHnESLHdw1UDmoYyUO7guSGgxg2H06jUzAn+wKZ7VN8in7?=
 =?us-ascii?Q?LvDaQcmYJIYr49tmzKC+UP+DrRTGs96q33cEPO6N6w987euoeS3892AqO3Bg?=
 =?us-ascii?Q?NxTzwrTjJhxgYGPAwawfSn0l8qf549wYblryP7Wa1S7bsxJ8leus9BDV8e1R?=
 =?us-ascii?Q?xnjB099rP5W+fyBeVFb+QQNX1VB+tNVMGKht3Yx7H9oW0SB4v9M3Do6fOH2x?=
 =?us-ascii?Q?9AH7qIVS1iPHYVz1C+ZlEUpgBvSf+KeR5mbr0Y64+I/nalqoYxQGK6VmJGr0?=
 =?us-ascii?Q?i8psdGyiJFjcYVA7Cnm6upHHeVWdHMN2IS78mLd6sj9I/Qz6vGYMHgTiHaav?=
 =?us-ascii?Q?tGOBPP8xyKgq3IKnxDo3KEzJHoFz6NGXIYdKuDqGnIZdSYb1ooeN7DU0UV9a?=
 =?us-ascii?Q?BX/vR2oJSR5+AW71iDZ+dEg3G8QiBV3jC4MAS0hEJlDqldlyDJoK4oROcG+J?=
 =?us-ascii?Q?CJ85f6w0a+4MF/aFeA8Wgk7Mujb0N1XYkEnhLyPmGN11Rlikb+88etxGp1K6?=
 =?us-ascii?Q?DZeo/4OfCTTjoyQLtPNcxP0fXVrBwh7IrsZVPzHBwX14cSFVg3iG+w/1cqSD?=
 =?us-ascii?Q?XlcF7zUtwnyp+QYSri4jvjHIoLE/7VN5JdfcFmxkxPRF+vFLwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LeDSYDFdKOiaJ5425YaCB4vcB9WnlOhcZjkZFTnMCEDwFbC+mSRdLRpESFvV?=
 =?us-ascii?Q?0PZrsXuYq3zNU6qn/R1UHx/TgRz9h6nO/2Bx7TiP5MI91pUogRURFDIinXXD?=
 =?us-ascii?Q?/xJavc1AhJyh7oUO6GusNtRfdFP95tNtAcByNymFY1fNI4ecpM9ZgtTxe0mV?=
 =?us-ascii?Q?6witYTNxvSF6KsOfJT26yeAheqcHyP2IJid9Khr4fLLq9+sWdL86Ki48SdN5?=
 =?us-ascii?Q?iYChOqjOBWAN5M7fDk7pBaUDzb3rouc7ju1tBgaFbLLWmwGEscqzIzAVZ3/h?=
 =?us-ascii?Q?SNU4J4ceWydALxx2ZDoMNKLEvFG0e0iz4hRt1f64SpDOPayPrx8rVTNHLOKi?=
 =?us-ascii?Q?A2HE3521rXoloP6jSDmq4qeBRWyzWHXdA6lZG8A3os8XQWZInzlKM56hqBBA?=
 =?us-ascii?Q?Mw1v1G/fn2KUUiGjHpG+HYWm7tMkVLzvOM7w01Makw1LfQ0jN7jWyj7r+VFX?=
 =?us-ascii?Q?YLyJekB7NSWKXzSurmL8bQtXSHP5ZQImlMLOAWf8TC1bZfVZR7OF0R3qzloX?=
 =?us-ascii?Q?/ibDhFv2gcppd3Y/GDSYJvOOqojDkv+BYHGddWD3XVvHqSyXsDFK4puG1UJ7?=
 =?us-ascii?Q?N5FKCVjT/sNhtOJ/x87YS4RvJPpd/RDVssWGdK+g3yZek5Eb2ljexqPRVF7E?=
 =?us-ascii?Q?mJ1GXlt1nSJFtvihwIrOOeJA7dMNmEvQTSV9T5BVUOzTqCPs8QPSPm0UPGWv?=
 =?us-ascii?Q?TClc7FMYgbqy3CU66HrfScrw1GiukU36t5nmuxYEZNvNM9R//4HPMok11ccF?=
 =?us-ascii?Q?8rve3HcJatOKegk0FxtbZzZdUsCn+/nEUGctqQPPCBnD49hQ+qwpyiS0GMiT?=
 =?us-ascii?Q?AMK+RNLEAxprYHq/PFy1MhkTy/f+pj8k4Gyvr9h+cbUXS3WEI4dbtgoIg9qx?=
 =?us-ascii?Q?KUYmAPg84+dpiZ996eYH0UFogvpMpNErNeTeolJakJsrl5y1pSN8nsfbSZHd?=
 =?us-ascii?Q?LNNDWQP+dcuNKKZf9KVa4nY6WcWvUmrcM6Sd3CULSU22gU9XdX9B+76X13dq?=
 =?us-ascii?Q?HqEwqvCtj35SbAhKe59Lbq9PmLUhtTmucurVDH5gHcWyA7lSj9rW6FuSJBP4?=
 =?us-ascii?Q?iNqQOSrsi+Wr8ja/OBEjuJjhoHGtJLx+zIus/aPRWlqKVwETd0qI59APMTXs?=
 =?us-ascii?Q?DM4PSru45rGgMPzYxYleX7IW6Lza+dxSnzM28DNKPppisgBSnZRkvhtG8hkP?=
 =?us-ascii?Q?K+lXe3IyPbS+T22hZ+BNsxjmos3z2IlrdlzQRWqFyGjqxJzHWcbCWvWpY/4h?=
 =?us-ascii?Q?oHNQ8V3ZfFP5CtH5OoeV6jfhOKkaXn82dPLlp0B0slq594qpAM+nTA9JjtNO?=
 =?us-ascii?Q?0RDyQN6yt/Fq1i0CX6R+C7ClqqlRFDVH+wH/fhaQcIuGNXFBz/lVVzvY+YnB?=
 =?us-ascii?Q?WYQDFFx1nqqWkoZcPFNWabiCYycDcq9P3AW68lkLrWS2r/xDFKqdJCX4/3W+?=
 =?us-ascii?Q?SR4w1iqLN7azWgXfX1TTfPAc06Sbr40e9ZHjo6ZVioxcy86sB0pE0wpekl1U?=
 =?us-ascii?Q?8dbH8lumqCU+YkArX1wjVVlClh4cjnDGJKLJUrgoOMmUGzeFJgCVd4zkoUWa?=
 =?us-ascii?Q?p03169dnVzZJR5wPvgooVmHAmW20lYCnb2vjTa0r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1626157-ed83-4c93-cbf6-08dcd229a655
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 06:19:10.5468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbuXdskAP3zPu4JIBEJsqIg45Gc1dGl45XpGG5gKwT/nFfADGyRWd69eaTkbJWtrn83oT8ejwNUAz0fGVUEstQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8509
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, September 6, 2024 4:15 AM
>=20
> On Thu, Sep 05, 2024 at 02:43:26PM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 05, 2024 at 10:37:45AM -0700, Nicolin Chen wrote:
> > > That being said, if we have a clear picture that in the long term
> > > we would extend it to hold more information, I think it could be
> > > a smart move.
> > >
> > > Perhaps virtual device can have its own "attach" to vIOMMU? Or
> > > would you still prefer attaching via proxy hwpt_nested?
> >
> > I was thinking just creating it against a vIOMMU is an effective
> > "attach" and the virtual device is permanently tied to the vIOMMU at
> > creation time.
>=20
> Ah, right! The create is per-viommu, so it's being attached.
>=20

presumably we also need check compatibility between the idev
which the virtual device is created against and the stage-2 pgtable,
as a normal attach required?

