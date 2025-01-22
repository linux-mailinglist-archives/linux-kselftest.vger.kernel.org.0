Return-Path: <linux-kselftest+bounces-24919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3256A18E72
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 10:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CED23A13B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2331C4609;
	Wed, 22 Jan 2025 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBichNzt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AB1514CE;
	Wed, 22 Jan 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737538435; cv=fail; b=ZiVyzGS9YknTwdKl/nEbS2DyY4BlgK76ovk2xCcblhf3HruQU6ErlflhqmdoDURgEChpCbGMZO0DqHlfv/aDYDvXrWq4PweM40xgP9rneaWdvrut5xAL/fiN7ZeR6pYBIsOIqFO74vRe5HMSdxU86dsYsK0h78rCxzyVoWeiN8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737538435; c=relaxed/simple;
	bh=xwl5LUc/Q+ZxOmcnC8YVBDUYR2Of8tEEFfF7s+tCeKc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V3l5mB54Qx10oAjjid5kb7xyPMtScBp1ipiVdMv1STge342QLQwIDlkvoPF4Iyv7uG9mhP15aoJcUd7eBto0a3vULjm82LJ+p8YDhLTnf/bNQQynwvfjlxWJiqsXCw/MuQ3vFi0w/MbEmidvMR8xXR1jlHgTMta311m0D7ctuMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NBichNzt; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737538433; x=1769074433;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xwl5LUc/Q+ZxOmcnC8YVBDUYR2Of8tEEFfF7s+tCeKc=;
  b=NBichNztGh1oBvX8B/cpezLlKJElLNWj/zvkLA3XbBJLrMHwo5YT25Q7
   T+JAFwnU3fmhuU6T/zJZMC/LHO9zDQ/R/2fC5n1ePeyvKsY85Z0nlkcup
   Wue6aWT+botZ0wjlQxjVGOT4GGKRkRwVfhKadOuMlHe3aRTsa6Ej19PbU
   ZBN9DikLmcp2K5oltWrym4AuSNbWotVy3AgJeI9rha1M0HtepIF4ZdEUt
   NaAU8+UnTM1pRL9KeQHY23fGsqYaOOmh0gOyLhyB1R3AxaUOFs+EX6zH4
   z3vgLbSE8DvJBvfDiMqYTQFPvsFnN8alhbCI+1YH6nLB80jaZOHwrfBqg
   Q==;
X-CSE-ConnectionGUID: eA6lNOuiQRWwkmP7d1aujA==
X-CSE-MsgGUID: tvKpb+aSTCiaVTd6JY+bfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37683954"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="37683954"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 01:33:52 -0800
X-CSE-ConnectionGUID: q3rRBBa0SzifBpsmjA22WQ==
X-CSE-MsgGUID: Hzj/A5L+Qryg+P196T1p9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112067298"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 01:33:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 01:33:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 01:33:51 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 01:33:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUx8oLeH2d6YhdQxD0nqJYsSQTW/Xqr8K5wQbbX7rGYcmD0a5hpwnjWhUmLaaERgG23znGt3YcwuUsDoR0y6RvhzOuFg8o9sewxDRFhezfO0QwJmtCZ6oWRNg8mawbdGewMsNW2VHHghUYG49/p3Vn8S4A32LBVBV96R8P9Ti9yWUb7j6i9Ye7Kn5w8U7flDdhO9zOBysbE+y1FWXH2igPbjFyIF8f+7iUw3S5uzUKx9dDHYtSkTHWRkvhI8ggVDG8B+ObC2O1foWX6WE4TLVxcntylo0r1TPdO67A6KTVVwVQtn+jdE465b0U710tgVcf2ylD3ZcRznwFrndmZmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj5OErtbqvP2tCpIwE2US+8IAh5gGnrEZzUjdb11FwA=;
 b=fZaQUjwAZp1/+MT/j9g7Fcw2+CXfHCRNUDuMC0V6TUmaaolLdvzczI2fdcxV8YpAfq08uTldqZnK0M1ASUUnmIlJLAyElTnJWjSKRuSWMLiMeDmYgnHM4CTWkjItbd9cSwwb2hQERxR1kNTXZ/P5/Zo18eeMqVcj/uQMrSFfhWRkYZofAfdRwr9vNsGxp7MVZfs8Ta5yPo3JguBZ6cOlPyel0ZYDm5bmPful1+vtagnIDGOAkpMFs9Q7WCE7u0y3XcQ+mg/Tjyy6wJb/6akn5I9nX6MqpgyPyuHtLgKoj1oP6uP+yWNsfcA2Fq1h4/gCQlYfMLDJuijR64JxJXeOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 09:33:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 09:33:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Thread-Topic: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Thread-Index: AQHbYSdBMlcOcpQt3kG1noLochuwD7MQS3cAgAAP+QCAABREAIADyIOAgADmPQCAAAdNAIAAAd6AgAAN/YCAARw/AIAFRUmAgAR2FACAACrRgIABbFiAgAAWGACAAAPzAIAADsUAgAADTACAAAdFgIAALRcAgABztQCAACOA4A==
Date: Wed, 22 Jan 2025 09:33:35 +0000
Message-ID: <BN9PR11MB527600A5B8DC271075936A918CE12@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <Z4rVg1Xg5TCiFlSb@nvidia.com> <20250120181854.GQ5556@nvidia.com>
 <Z463eXfgNArCOfPn@nvidia.com> <20250121183611.GY5556@nvidia.com>
 <Z4/7pGx6F1mpAUuV@nvidia.com> <20250121200924.GZ5556@nvidia.com>
 <Z5ALWFVTOSC/8+ji@nvidia.com> <20250121211404.GB5556@nvidia.com>
 <Z5AUNVHzJPATVqAY@nvidia.com> <20250122002128.GC5556@nvidia.com>
 <Z5CbGKYbwy+qPjyh@nvidia.com>
In-Reply-To: <Z5CbGKYbwy+qPjyh@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4888:EE_
x-ms-office365-filtering-correlation-id: 384d5c07-ea37-4501-2636-08dd3ac7d84f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?q+MiHxTmF6miYvOQE5Pd7+iO0ljsPDMZ+cl4OBwdLVJv/oYE3lJsIUdID+Ei?=
 =?us-ascii?Q?WQOfIbZpQRf8iXgZ9cWm3Dh/Kp3DCocxZOVPOPX1yVuRDrR7ZOsr2VXnp0lJ?=
 =?us-ascii?Q?ziux12qpJfn7MP6f2OCaeHMp4b1qA1OSmdM0IHsXWCTqF8W3kHd+1PA5wrW+?=
 =?us-ascii?Q?zJ8xTut9+DbW4A4MAZ+kOVb9zSEfy+n8pa0DI9TLAA6/t/jVMujf1xijdzlr?=
 =?us-ascii?Q?dYsi1diJEdHwyOE82dF8PnGZima3TC/cMv9t+3WgCmC2NBS3M4TZHcTmRdyD?=
 =?us-ascii?Q?bE4ksvuqjrqteWMUoT7eFcpE7xfmrdooVeD6MGhuAitpcZSHLmghhE2cKE7g?=
 =?us-ascii?Q?F6ZqK3i+CO4if13a9AJAqGwI4tc/4xKG0n7XjiC/RciTv65wZEuw++ES15z7?=
 =?us-ascii?Q?Ro74paKOQ0H2/zPvFcrolUG9++dNh/P/cnls9suwqfL/urTTGtFKdpiDfIs9?=
 =?us-ascii?Q?GrqLwQpfYULusRgM8WNUXvRTiHG4HA4PQrFjl9y9vd6rW3+ZxOhaD54xAb27?=
 =?us-ascii?Q?Ei/mt/1ql1JJVrntnxOTyW0eCq2LSPRBKu8To5de8S67/rdoUycc4m179s3x?=
 =?us-ascii?Q?3xjgsFbv2BtDRsarUPNjo4XqS5Bo2cU9Z9pMTShFzT6A2ERmf9+r63249d6h?=
 =?us-ascii?Q?nWLdINGTd9HsmpDZ+Puj56GLPcxe8ylWWJRs8wWVc43ERjHFP2ryNoQJpV8n?=
 =?us-ascii?Q?ngSPK87X3syk3jGjM5GHHPKBzt/J4rGf7u3GJxWsPRSswSKuwl8HblUJdu0l?=
 =?us-ascii?Q?Xo++NpJ4n9BUoZiWRu28LjpZZo9lpYB8LWEw65w0RXiNLkmh+2XDNyZPtg1z?=
 =?us-ascii?Q?vkzbAvfDOOhV3wq46Dwhvdq/28+1rxNMjpQS/2tRHPaJZYgjtdxLpwa9FxEA?=
 =?us-ascii?Q?z0ZPf/dd0Cb7DB3Wb2SIgCHo7SpUi7zBWl7wAkIQrYT2/b0T4xLUMEhX/JRJ?=
 =?us-ascii?Q?waOeu2ayP8KWOUihRAVsWDrVDXamRCRWEFxmif01HzagTPS0bNSrJTbCRU7t?=
 =?us-ascii?Q?nQSbBtXGac1F3AVWH1owucoTavwGy8dIBWvzUyInRjRy2O0LsDwUdoAUXJ1/?=
 =?us-ascii?Q?LgGIvGTGsMEyx3LAlpGXzgwBNOZzmmsBIawShxbI7k8JfhNABh29m4ijDlak?=
 =?us-ascii?Q?2X0XrceQqGsu9zvOL8uCMYCxO3ayrXN1tmVHlID0mo/1g+XU3Kv6UQKdgZPG?=
 =?us-ascii?Q?2OVGt2YRE3LeavYCAOi6uUHqcOhBLVUYRoqilaXFTwI8aiTIuzHn0mzK1IWf?=
 =?us-ascii?Q?YJE0O0k3Ig9zkNth2G8nQw/Z1qmuut07VSBZBSA7ze7tw+1ucPLUJpXUpPxh?=
 =?us-ascii?Q?KG0rkypzghyFCwBuT78ylvYS+fKbvDDH8ELn2hKeapXj8ObjSVsOGuoK6DPo?=
 =?us-ascii?Q?U6L+PXVqoRRWK7gJCArTbqB+n9cQfAVvbbnQN/Cyt4gMNDNOus0+S9DXIOq7?=
 =?us-ascii?Q?L+fQnlpuykR1omyoR1uNWk+IiTeXrbuV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8xVf0X4kV2WRv7dj4T2xXy+bJ/hLnG0sU5+u3nS5XiXEI5J6wpTd3VPlr5EB?=
 =?us-ascii?Q?J/a+Ar/sdjvlUwXTmLslBCHefbA806fOoC/kwoZ2rIoV9hZBX7Yt6HyMywMe?=
 =?us-ascii?Q?fPI2mtoO3AcTNCrgf/0WmTu6ZSphoftZ+7zD83B5lCB7/ydZWs2MK/XkrIqB?=
 =?us-ascii?Q?kI0kEm6pw2aeIXBlutP2GVt3Th6xw76pDLwKRqE9dLrz+yZ3IJ46Pk09cqJi?=
 =?us-ascii?Q?AMedAyhHt5KGg970agbqZ3i8adDZQokJM2jVsLK46xOud1XqYXvunZcFjsM0?=
 =?us-ascii?Q?0ZrV0PSrv5Yv48rz+rGrThNMGwg+sSn6XzzOk3nKuNhnx3tVn1RebvxpmIPi?=
 =?us-ascii?Q?SfgO7jGopIM1UG2cohb07ZkSVT8CuVi5oE70B6URa7MCWAi6NPjPrqNf8XdH?=
 =?us-ascii?Q?X2ntdorcly+afX4zYXE8XjFhX9xa6FFqjlyGccYhCOni6ILsF2o2EbuC47BW?=
 =?us-ascii?Q?WC+i1b30+xfwTxmH60Opurctp/SLZ4xwByRvXDSdqRV2E8SvfWeq5SZM4Qxj?=
 =?us-ascii?Q?Uc0u24cu6SAr5I9KApIDie/ED1w0RWazBMdW1nWiTi5H0Objp6r6JTcC6nxH?=
 =?us-ascii?Q?TGMDKl2hpYL/mmbPe/+AmJrBMXBOVCco3e9mQ04xO6Nzi8rpt90jC2jjBao2?=
 =?us-ascii?Q?46ARto+Enf2Xs/YJpWyg7B1B1qLDqsC9QwBRf1V+V8BC7oRjiLACEnfZhDxf?=
 =?us-ascii?Q?FOJP2BjpCMMCxQkfvJ+mausLwLN9kc40qjzaptzNHK9/aWxuH8HOLNNTb6Tn?=
 =?us-ascii?Q?xneGX+dxnT4RYMG2/3731tbgNuAVV7gF06tpGOW6K0zH+oaRvyNixBiiedd2?=
 =?us-ascii?Q?hXZjqUS+95mPPvww4os5e6AzXDIQHA9q+9xVphx+Jab5TEBVv/5pz38vJhGX?=
 =?us-ascii?Q?5gaeNm39VP9xXNgr863lA5Nz1Hq7LLBbmSfiW9BiP3oHvuEhSbD099G91xLu?=
 =?us-ascii?Q?AODSLtLEYcJVzX9ciC0iiL0ebG+/glFE/lRt7GDSTRYqOBQHnls3g3QG2kB1?=
 =?us-ascii?Q?z2LbdHV4IkUu6HwY41cmZ3PbcH4RIlTNh45mPYnZ9C7UCxZd2zskcxA7uqdH?=
 =?us-ascii?Q?TNDykry/0F30oRjAWo5haZ47x+yHiVNEPm18ImYaL2O8RfNmkXNxxvv308Ly?=
 =?us-ascii?Q?kkco1mLDlNWNt6xNkuxLBzHwWdacJEdFs6imb4xNcg3ZiQNZc1izKB9BBPI0?=
 =?us-ascii?Q?1j8yQITdbWOjum5kxc0aHYH5jOM22SRiUbuOpAtuzPz36ArD6XrPeyTTvcDr?=
 =?us-ascii?Q?sNnWThhKO1FdWqlQkZkx1A5xuh9Bx81A8aRryzmbdkgEIGZrhyLof2kNu6Vm?=
 =?us-ascii?Q?6PjmHYE82hQIgXpHpV6gIAxnAIVYbDk33374r9gMOrCtgfxbIDJJwp4tmaqV?=
 =?us-ascii?Q?7njXSibSDetzAQ0hi6u5xqdYUtaOe09GCx8LCjZYhgXLLra+GaBzSgCpC784?=
 =?us-ascii?Q?jOZuIkPlnU9OpkiwUVPKJoQYoqjiFCy7hiwveTnRJhTPs8T8uYpu9w1aziQM?=
 =?us-ascii?Q?DjnEmBbbT9a3fBrEp1phJABeFJ+TWWWPJ48hgaWOa65wSmYtHyaEh7F7HQKs?=
 =?us-ascii?Q?fFdMOVi1lS/EGqXT+7HJygwEn1iIAbf8X02Ri800?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 384d5c07-ea37-4501-2636-08dd3ac7d84f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 09:33:35.7848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gw52n7Tyc9tDLdjMpK+DbWpM216bU8M/QiFSjC3CM7XzoPSnJueF6fn/FPepVaBdLKOW6UHPauECniOzRGkg7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, January 22, 2025 3:16 PM
>=20
> On Tue, Jan 21, 2025 at 08:21:28PM -0400, Jason Gunthorpe wrote:
> > On Tue, Jan 21, 2025 at 01:40:05PM -0800, Nicolin Chen wrote:
> > > > There is also the minor detail of what happens if the hypervisor HW
> > > > queue overflows - I don't know the answer here. It is security
> > > > concerning since the VM can spam DMA errors at high rate. :|
> > >
> > > In my view, the hypervisor queue is the vHW queue for the VM, so
> > > it should act like a HW, which means it's up to the guest kernel
> > > driver that handles the high rate DMA errors..
> >
> > I'm mainly wondering what happens if the single physical kernel
> > event queue overflows because it is DOS'd by a VM and the hypervisor
> > cannot drain it fast enough?
> >
> > I haven't looked closely but is there some kind of rate limiting or
> > otherwise to mitigate DOS attacks on the shared event queue from VMs?
>=20
> SMMUv3 reads the event out of the physical kernel event queue,
> and adds that to faultq or veventq or prints it out. So, it'd
> not overflow because of DOS? And all other drivers should do
> the same?
>=20

"add that to faultq or eventq" could take time or the irqthread
could be preempted for various reasons then there is always an
window within which an overflow condition could occur due to
the smmu driver incapable of fetching pending events timely.

On VT-d the driver could disable reporting non-recoverable fault
for a given device via a control bit in the PASID entry, but I didn't
see a similar knob for PRQ.

and the overflow situation on intel-iommu driver is higher than
arm. The irqthread reads head/tail once, batch-reports  the
events in-between, and then updates the head register...



