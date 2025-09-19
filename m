Return-Path: <linux-kselftest+bounces-41916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35697B88578
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 10:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A2B7ABE1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 08:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDB33054D4;
	Fri, 19 Sep 2025 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6tD1nDr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2C30507B;
	Fri, 19 Sep 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269478; cv=fail; b=JIAiTa+k1nvqOlP9sVyrVdQGViX5Ef23acKqlTW9A6WXb+U0phNTgUmw7/KfuFRKCYbNRhEgURCTy7NW/PRTmUnU9oflqlp8cj0k1p0Dllgk7XSKFW7AJ6sg3/sf6Yfy42CCCcBQ9JQoxT+Xo7IdMAcXQxzanwA1al8SH0t+XfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269478; c=relaxed/simple;
	bh=LZPTr6+7Oj8wfOF/nQHlAr5hxhGXi+hj4cmfg7ZAXEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bAK2kHRx9uPI9UG1NUedPQdiOlfAUTo1juJVdYzcRsTAj436JNmBzkzxs5VwWkq8OdCvTY6DJ74FJ4RCnDZ13P4uydcTty6wJQEvAImYoY/ModjVHmb2/np9HepxgD1Z9wDGWF8hnyI7NqAGcyC8fGp1+TVDYYFQPWEmZcZF25Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6tD1nDr; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758269475; x=1789805475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LZPTr6+7Oj8wfOF/nQHlAr5hxhGXi+hj4cmfg7ZAXEU=;
  b=K6tD1nDrKEkG+P7W+rDJKPnCmMo99ljIBZRq20PKKw2WZn5gqgyv7TuE
   uueAdelfZl4oweDUN7HlGILRV4G1RImMDWjEAKD4s19jjSntIK0oyWz/K
   VW/IRXnQu3VnbZrhRmpzOf6EhVPHg+7MuGtk6s8AUrsApAJYtdAGPOtYE
   l1GwPgRlU7SCrNG2u8h8UGLYhKaCieQjtmT9OyUQnxMs7n3P1ltj5dkZT
   go1glAsbU+tkb4vKGNfhDrMQT8acSK6sVRCxMGgc6p4WZ3MLvDM8DpG/d
   3X9o35OIP1xm7KdgdvAwq6sC2Z4xjkJSAxOuQUDByl4DCrPc8ycl8iUq5
   g==;
X-CSE-ConnectionGUID: NDEXzK9OQtCjSM9ojgwABw==
X-CSE-MsgGUID: cdrpzb4+SjC+EIkaZ0DAOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="59833170"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="59833170"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:11:15 -0700
X-CSE-ConnectionGUID: PtbecaS4Qi2gf4VnUbFnCw==
X-CSE-MsgGUID: UZ0DUozaSPiKTykdjzaEpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="206719779"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:11:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:11:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 01:11:13 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:11:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0xYXsBD16tJpZ1qLz5X8hW29W9kdgWfGgpfwJTtMTgMZK3/sReqgVcCe85XLQniJuMH2ZdxeLQZq+g5cGI3G37TKUX3x+f+KPn6d1PAqL/bVU+dBx3ZkWX7LHbo+nrqj0rM2q/2qUNmN29A5w4rEmYZgxBAyhwznJOsgmFMnRmMt2PxLXURNOs4AmaMiajgFFje9X4YEe8HgyseXGsYn53IJGFJyI4JjAiZ/CaHW1F3PxN8pkAIVTqlO6Xei12BGrIlj9T9QhoDeCEi6c7PLanh2pQL7Qyfj13Bgv6GWk3C5J1ZQNP8XBUU+jpI9Z9ClmIvUQdAbOabO/8WRx2r5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNOY0qQCYo3EjMARplP3KzRYzcvjGjFdeunpWtGVPZw=;
 b=xkqs2RS+ALThZ6ONT6XYfafvo6fD8d3x/UetfHrtUFkbxNwTW8ShWlQTCXwNtOY3e/oFUQNA/7heQwrUgJyNbZUE5av+bNHi/ZWQrjNVruZdUBIa+14m1Y88B/eqkmONxIkzPDN9EzJYIEP4E8yTLR3xGsRJRqeaZRt5YnfxdLRSyLsQfBCoBrkKu6l2VJL+rDn5fqTV7sp9XIlQxdONCoCLUWYN3S57Zx1KkSUxrVNT6c8X2rH6H4qwqajZekdzJc6AJ1w+HL2YAcL6pJMDkN85/MSWxNmhLESbCTIN0PYI8Hr75vADiUSskdzOBGNd2hE48P5pZRufoZWz7BTbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5256.namprd11.prod.outlook.com (2603:10b6:208:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Fri, 19 Sep
 2025 08:11:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 08:11:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Justin Stitt
	<justinstitt@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, Bill Wendling <morbo@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 01/15] genpt: Generic Page Table base API
Thread-Topic: [PATCH v5 01/15] genpt: Generic Page Table base API
Thread-Index: AQHcHPrLfNePWPa2q0qW7OShpmqDlbSXCZ4ggAJKd4CAAOIbQA==
Date: Fri, 19 Sep 2025 08:11:11 +0000
Message-ID: <BN9PR11MB5276A9B144DE3CE042A448D48C11A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB527669A84AD24A550FDDD85A8C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250918180657.GA2132010@nvidia.com>
In-Reply-To: <20250918180657.GA2132010@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5256:EE_
x-ms-office365-filtering-correlation-id: e2bad0de-d19e-4b42-d0cb-08ddf7541869
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?1wA3Vgl2FYytF7utbakItTW/90TzjRQq9DvjwpZmzfx8FFWuzCaRKUCwOmM9?=
 =?us-ascii?Q?njinE2mt5Qs2wfyFCOSKNFD4dk+LFv61rLXsrhJLMiJU+FrBFtI8EOOk742k?=
 =?us-ascii?Q?BhoTZG85IwlMBUY+2uKWYb35jprPlWjuCbvahkReVae5s7mbm7Q4DuAKuKKV?=
 =?us-ascii?Q?9rG4iCEpRKk5ezpBILVa7qJrrZF1RkxQSvkd93QB2HCq2JAzIqPxQWCLMYbT?=
 =?us-ascii?Q?Z3trQbwkOtlfUasPf8T2Koi0HzwTsZmjVcXFFYruMQuor3S/UjPTFdpi4yHy?=
 =?us-ascii?Q?9UDD91Fh80aWG6eeSgPh046N7BFRU9EojF/peK5p2RUgWHMPG4Ss1sKVEdAj?=
 =?us-ascii?Q?vJs9F0+6sJzDMNgkMxuNyZcoOjLc6zCsEGTZJAWUpGokpg4qWXYCYNKracWJ?=
 =?us-ascii?Q?bv3iprDVpzuSto/M+7k31F75wem19GiolWGBPiml4yOEFH/YGoAAruT7e6TN?=
 =?us-ascii?Q?D9FujVqifsIG+bZ9FnMpM/OZeCmQOI45AcYLutqppZpZEzfynLMbfL1jTCtx?=
 =?us-ascii?Q?tEgKbbxeLfMJndomh9OWChZNHIbeq5uiO5PT+I7nV09dVF+7c8NbvUKwyl+Z?=
 =?us-ascii?Q?RcGOATujqihKGpFZ/Y4TmQvkTz1JTh1naudNo9axryCUGCjpR2D2dJk56iY4?=
 =?us-ascii?Q?bNP3E6neYuyuztifuTH9JY26drUO1ERe7oCI3dBn2Ryq5f42gOieiWBFTk9G?=
 =?us-ascii?Q?BdwsSC39fCW7Po5GImZwdUdLSOfSbNqDTO6hNgdCvH/jgvmn1McWIlGzJtDb?=
 =?us-ascii?Q?8oLbryXPyuw+UkKGvC4vuxAb8KPfFXnpk8bwSd7oOsGNyi19VUUt5tyVaCem?=
 =?us-ascii?Q?8Ds1qoxeLbz6sTarx43YjD9AOMV8VzNwW3Nj8G3bU+VJbOo6vYwh7yIiEWGc?=
 =?us-ascii?Q?M2Tl8G7hkUrpl/m8W5Lrg94e1vdx6uZQJFzH4yLuapHD6HCL6dMilWE8dl94?=
 =?us-ascii?Q?JN/fy0f47U/4I+1nYqrYaUWXxPvnor1K94ZA9F5//PzVUy06bvP+dcVtIJxZ?=
 =?us-ascii?Q?9cm2Uv6t+0Ap5tFobZs+UaYsjOGQuR3p0OsJoRNJJvv6WMSp8xveRK8n2pUz?=
 =?us-ascii?Q?VHKZkDlA+qmb9g22/V8qz4reNv45UCBRIXe22RAsZekJLtwpiULNb5G9v/3E?=
 =?us-ascii?Q?hFtJQQxzFpbX49OVfcQ0WvM9HPQ4JsT2h2/FWjVI62nj4gnkxsUxN0MY6THD?=
 =?us-ascii?Q?PHhojzR9pfsoAx5iRMn9J+jwOtSFFm0WRKOk807J4KET9fIxEtg2FGQJ0vUU?=
 =?us-ascii?Q?nxd1ZlLjtl1m5uVtDUyG6vozddjKWMXWW7TtAHwF61C9d/K6CogTwdKvyQer?=
 =?us-ascii?Q?A+AJnT2kn5/E2dBzNYtglR12pDVpsELIxg244SAt1h/QVUn+jnHjkzHnG7rw?=
 =?us-ascii?Q?NxUvIoTokJMzUQWzXwyLWx9hX46ksF5tcuawZNhNIX4OdB4gx13E8fmXjQHD?=
 =?us-ascii?Q?sWe9uI2AovyojWURfXBHdrRiNc4ipXV/uTmFkNMbuwpcma7V7WoJJw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IsSFt4kUdJjugv29JKmB3KTyLmFYl7Yt0S1jB+1GWnT/lNuejR5svXmYyGwL?=
 =?us-ascii?Q?Ja5+bbpWW2vVCVGhBuciXEoizM1/seYISjvnK3kGpdbaH5KrtHmBM3lOL+tt?=
 =?us-ascii?Q?Y+rVBdD7SCbG+fqnaWYiPV/Stw4FLssDcOqru1cK0/syeRRj6DC+gfirvZc5?=
 =?us-ascii?Q?s5HNqb0uqaGYuePSuP48d/acJ1AGBMngAkByXarBsVvkNbTHrdQJMitmbM64?=
 =?us-ascii?Q?0DvmOR7ymn2zN9Mpw2dZvWRp2C19E3DvER2llSGCMYFEuOo0fXTztei+RQ2l?=
 =?us-ascii?Q?xeFcxoHaCI4NpxmxLT151pIGBPOqchQKh3ZOrb0hWqLU6YP+B5xoRNLr+kbj?=
 =?us-ascii?Q?zh+UmE2264DqKUY2iGwmzHYdnD/cd9g/Okt4NGPFoSL6FwloYGnVROlt2EO2?=
 =?us-ascii?Q?Qt3z65HeufrTDwdmm2nxjNtuMj9BXscPw5ajdoRhAYTEub26c9WtjGHgjBC3?=
 =?us-ascii?Q?Veyq2u/GmXh43aN8Yb1/8ZH7CphXV1CWaSDx7YLHTgc6o1v/Ye1hy303el7V?=
 =?us-ascii?Q?oyLiPPwMpQZPcmQB79Aux2lMXhFEU2ILQmI94edioqcoIYc7X02/V6FjjfDM?=
 =?us-ascii?Q?x9xIr4LVsqY5KP/lj7NqcjECYOzvgRzevPDmqCefuWMuV9NVnVSLkI5zc3X1?=
 =?us-ascii?Q?Z6gnz9LA/58Rb+oprlkuLi8ZOt5LXxVRIpJJW2esCE4qHeKvDaQQZc0NYiBe?=
 =?us-ascii?Q?vAC0YVlUxm2hRqLMvzD+dxZsPjhZQPLtvgG8u7bA5MU0fP4r+O/o+6/SRUu2?=
 =?us-ascii?Q?IKEKSdaK/biS7QiQJwV9LHjaXsPWR/ZR6T3d/JLSZZjA0TRkEJ2nLl+Ls6Wj?=
 =?us-ascii?Q?HB0UAh2bC0e7v8HxYr0gSDc658Xdx66CZ4ybvwsndtVa+ZXhsUyKpaou/DS0?=
 =?us-ascii?Q?x/LKXxP1Bc1pNyrTyBhSa9JB8jCZnitJPfypuHMiY8JEUCmMOZ89mM4uyg+c?=
 =?us-ascii?Q?cVJv10Wt+M9m35MmAI26MmHfXmkob2E9kCvBmfxLdsbaOkLcVd1kKibximOz?=
 =?us-ascii?Q?9zMRANjVzff7+Ux+mk7OARWNcK7tZP1doetg0dGjQ1c5obi1sADkqAiL0w8/?=
 =?us-ascii?Q?1/hLAk0YAkPF+XP/5OueFv/XNgUVnacjRAZ585rrGk0OBWg+YMIqVV7egNyw?=
 =?us-ascii?Q?4Ys0JVWQaq1eAOYiRr664DDgyHc/FIwLxuZ3BBwQe7QFnQJIKEgXHBVWC2VU?=
 =?us-ascii?Q?Os0ZYBLauLjg6eOYdCZUUt6lNCj7YOvLw7ubd+ePVisaV63sGNZ2ek8cyJqy?=
 =?us-ascii?Q?+q9yLfH39aYXyW6VHS+urTmwnJkK++rNgLo+L8aQ3PgV2q+VLXdan9hJtStQ?=
 =?us-ascii?Q?c9/I6h9E5LwszPl5EqG1hBJwP5wdTCYaWE4povUEytIUcVM9ZqHx/Ql5VWGB?=
 =?us-ascii?Q?nLQgqHU25MpyVpJWKhmO4xXDRRyLyHTmi+7DMLBZj+MGkxgqIgRv83YlUL0H?=
 =?us-ascii?Q?rD4NiTMaPkEpHqwnfawI1MgZGblIbDw5FIDkNDGh04WVtQo/JJabfPp5+GP7?=
 =?us-ascii?Q?33k9HJmb8U2ljVMzgt9eaPX1n2NaSUmEWRi+1BuVQSuOtQHNrxcFsqWoqCjT?=
 =?us-ascii?Q?YmXq//QepW1AuQNkX/Q4OWgq6qP769MMWJyE2lig?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bad0de-d19e-4b42-d0cb-08ddf7541869
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 08:11:11.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jyLjKqmOnNpFlDs1GtfHDD9L4Tj6IFDW839FIUroemevtoTnX2C10Jy0Z8R41mdj7f8A7CXh+0S65Vv4gH5KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5256
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, September 19, 2025 2:07 AM
>=20
> On Thu, Sep 18, 2025 at 06:49:08AM +0000, Tian, Kevin wrote:
> > > This is enough to implement the 8 initial format variations with all =
of
> > > their features:
> > >  * Entries comprised of contiguous blocks of IO PTEs for larger page
> > >    sizes (AMDv1, ARMv8)
> > >  * Multi-level tables, up to 6 levels. Runtime selected top level
> > >  * Runtime variable table level size (ARM's concatenated tables)
> > >  * Expandable top level (AMDv1)
> >
> > any more context about this one? how is it different from the earlier
> > "runtime selected top level"?
>=20
> How about:
>=20
>  * The size of the top table level can be selected at runtime (ARM's
>    concatenated tables)
>  * The number of levels in the table can optionally increase dynamically
>    during map (AMDv1)

clearer.

> > > + *  item/entry_size
> > > + *     The number of bytes of VA the table translates for.
> > > + *     If the item is a table entry then the next table covers
> > > + *     this size. If the entry is an output address then the
> >
> > s/is/translates/
>=20
> Don't follow?

entry is not an address. So I meant:

"If the entry translates to an output address"

> > > +/*
> > > + * PT_WARN_ON is used for invariants that the kunit should be checki=
ng
> > > can't
> > > + * happen.
> > > + */
> > > +#if IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)
> > > +#define PT_WARN_ON WARN_ON
> > > +#else
> > > +static inline bool PT_WARN_ON(bool condition)
> > > +{
> > > +	return false;
> > > +}
> > > +#endif
> >
> > Then call it PT_DBG_WARN_ON() to be more explicit?
>=20
> Ah, I'd rather leave it..
>=20
> > btw looks there is no plain WARN_ON() used in generic-pt. Just be curio=
us
> > about the rationale behind. Is it a new trend to contain all warnings u=
nder
> > a debug option?
>=20
> It is sort of like VM_WARN_ON(), the places that got put are largely
> performance path so you don't want it enabled unless doing debugging.
>=20
> Generally the idea is to use PT_WARN_ON() on performance path cases
> only, and leave normal stuff to normal WARN_ON.

Good to know

> > > +
> > > +/* If not supplied by the format then contiguous pages are not
> supported */
> > > +#ifndef pt_entry_num_contig_lg2
> > > +static inline unsigned int pt_entry_num_contig_lg2(const struct pt_s=
tate
> > > *pts)
> > > +{
> > > +	return ilog2(1);
> > > +}
> > > +
> > > +static inline unsigned short pt_contig_count_lg2(const struct pt_sta=
te
> *pts)
> > > +{
> > > +	return ilog2(1);
> > > +}
> >
> > what is the difference between above two helpers?
>=20
> Oh, pt_contig_count_lg2 didn't get kdocs because they are internal
> helpers to build other functions..
>=20
> Like this:
>=20
> /*
>  * If not supplied by the format then contiguous pages are not supported.
>  *
>  * If contiguous pages are supported then the format must also provide
>  * pt_contig_count_lg2() if it supports a single contiguous size per leve=
l,
>  * or pt_possible_sizes() if it supports multiple sizes per level.

could be simplified to require the format to always support pt_possible_siz=
es()
if contiguous sizes are supported, no matter being a single size or multipl=
e.

>  */
> #ifndef pt_entry_num_contig_lg2
> static inline unsigned int pt_entry_num_contig_lg2(const struct pt_state =
*pts)
> {
> 	return ilog2(1);
> }
>=20
> /*
>  * Return the number of contiguous OA items forming an entry at this tabl=
e
> level
>  */
> static inline unsigned short pt_contig_count_lg2(const struct pt_state *p=
ts)
> {
> 	return ilog2(1);
> }
> #endif
>=20
> > It's currently not implemented by any driver so will have the default v=
ersion
> > returning 0. and it is only used by default pt_possible_sizes(), which =
then
> > returns only one page size accordingly.
>=20
> ARM and RISCV use it. AMD is the only format that support more than
> one size of contiguous per level.

hmm I didn't find ARM/RISCV defining pt_contig_count_lg2(). So in all cases
it's the default version returning ilog2(1). Then what's the point of keepi=
ng
it instead of directly using ilog2(1) in default pt_possible_sizes? sorry t=
hat=20
I still didn't connect the dots here.

> > > +
> > > +/**
> > > + * pt_item_fully_covered() - Check if the item or entry is entirely
> contained
> > > + *                           within pts->range
> >
> > when using pts it's more accurate to call it pt_entry_fully_covered()
>=20
> Not so much related to PTS, as pts could be either, but it makes more
> sense to refer to table poitner as an entry than does it to refer to a
> contiguous entry an item.

make sense.

>=20
> > > +	PT_FEAT_FLUSH_RANGE,
> > > +	/**
> > > +	 * @PT_FEAT_FLUSH_RANGE_NO_GAPS: Like PT_FEAT_FLUSH_RANGE
> > > except that
> > > +	 * the optimization objective is to only flush IOVA that has been
> > > +	 * changed. This mode is suitable for cases like hypervisor shadowi=
ng
> > > +	 * where flushing unchanged ranges may cause the hypervisor to
> > > reparse
> > > +	 * significant amount of page table.
> > > +	 */
> > > +	PT_FEAT_FLUSH_RANGE_NO_GAPS,
> >
> > FLUSH_RANGE and FLUSH_RANGE_NO_GAPS are mutually exclusive but
> > one format must select one? then we could just keep one flag (NO_GAP)
> > then feature off means FLUSH_RANGE.
>=20
> I think at least one or two more flushing modes will be needed, and
> they would be mutually exclusive. It is setup with this one hot
> encoding because of how the pt_feature function compile optimization
> works.
>=20

clear now.

