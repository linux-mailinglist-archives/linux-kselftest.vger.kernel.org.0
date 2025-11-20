Return-Path: <linux-kselftest+bounces-46077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC2C72B06
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id C3AE92424F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 07:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0863093C6;
	Thu, 20 Nov 2025 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sa36MT/3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22E302144;
	Thu, 20 Nov 2025 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625569; cv=fail; b=JFcodoODwQhWYmqtU7yoIusNoD+xJgKKxf6PsY3cH9SmPq2x3Rbqu1gi75EoTDzL1v6tg8q1lDuMnptwO6b18mlugrUSmuKDQURx3hka1E+w0prso+wL/pTvWxUFubE0LVNlu4oM2X2/p6+poqzAi/qbHO2mPDZpIS487s2jlAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625569; c=relaxed/simple;
	bh=vfVSA4TRGlvTp6NSZoHWTsAWu7BBT0PH8fw8U0PgePo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iLGem+tcP+RJMLRtxEdF40o7XheBFXYI7+6X86TVe76nAz2XAeU01XVKd/Sso6rRAaIGntv2WMImTdt7GqI2AVb9aIHGAfdNF55prq5akxM0coQDLdJtwLChbmzws+9fTbawAAYUfWpzyL3NEHh0Fei9LLp1orqbPygfV7NVnr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sa36MT/3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763625568; x=1795161568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vfVSA4TRGlvTp6NSZoHWTsAWu7BBT0PH8fw8U0PgePo=;
  b=Sa36MT/35sk+J4WBu6szCS/fHYpeP/f/K9FJPYkpqQr8v39Sj0LX+wRJ
   bDEF+3EKDIlYiZ/w/bxM5fectpRewPZzbsmk7Kihf4ZdynqMAVkx8yLGN
   wltkXhc/RidWMJ048oYD09nNFXmW9lNJzjcAzgWuNbwVi+74dp07FLAtL
   eiOQ0jqRTsP0xACG/TOvSJSmF4O5WuVNpAC/3ufT3VvagDrLoNdwzF1ry
   4Gu+sbTNXkhhqiG2PJjmyXd9bYERltN4AmuQJT4KfSvvkL9wqqYhTV4jx
   TbhL6e6YNdX88JOZU393ClzkVhMsdTnLWiOefZS2RriV5MMZD8N0k9a5y
   A==;
X-CSE-ConnectionGUID: n/XHSSKVRQ6h0hObupCynA==
X-CSE-MsgGUID: kFfK38S5SxWgHviHQ1xUHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="77150616"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="77150616"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:59:27 -0800
X-CSE-ConnectionGUID: pRXBKYVrSvWTj6QS8FymoQ==
X-CSE-MsgGUID: CCtyL0lISPqi7BB2l5FWDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191316846"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:59:27 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 23:59:26 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 23:59:26 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 23:59:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSHi/Dwf6ruLbPDi/fo0++1P0ui3AiTWz5xxAPiw06tj80gUWXPg/KsGOX9CdjlQ3c0Xgwit2GbWJQZIHEsZ/NtLL6SN8U1wRimEsURiG6o5BWoMcpNOAAk1xUt36g/2nuqBvpJaNbV39JK+GzDIbHinqMx9VKkcSKvBDttXUGfhwPqQIVFwQpFRnIJf6GFOiSQ+eksgTVO8schpkAr0JirUqD9L4dVIHNPJhM6Og8pgbqDRiwRa6wh12Lg8AKCLKT/1xGoaJQ59Ki54XjCCd7Ndo6EePXR9guVN6rjwHkB8W+u9culy3cWf8n0M7Ti3DIBUuRzSsBJy3dwffsfmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IhAz6OmSEdHy/oG8tP7w3Gl/f44m8FHCEa20rsbnWU=;
 b=UQIkWNHCj7+uyuLRa6HcBSOlB1pW9AYGX29uBKT7pUDfaoKCBxklwdYtpHZLqP5te6LFBOj+OpNb4S0qzuOU9ypjOCQYrIVw9YTck/b/RambKIk8eC2MzJnjvDCrMEAqODQg3obahUHoNqqhJ/g0cnnaETgFso3twnvIReSbPd/9NaKLhJBR05LEp0T0oYk7W+/v3+A6pkzFodZpvVeH4e5w7FVnribfFhuxsdwWpQqSRRZF+1pr/L3TuEwokt0xX6MyJopTc3Hbr1YjN0CDRFXcXaGdFeC81nk9mZDJhDSex9559sGsGp6dadQzOo5ev8fS+kX1joiWF7OD73LBsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8840.namprd11.prod.outlook.com (2603:10b6:806:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:59:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 07:59:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
	=?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, Will Deacon <will@kernel.org>
CC: Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Simona Vetter
	<simona.vetter@ffwll.ch>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Subject: RE: [PATCH 5/9] iommufd: Allow MMIO pages in a batch
Thread-Topic: [PATCH 5/9] iommufd: Allow MMIO pages in a batch
Thread-Index: AQHcUAaVuNUYHthnDkai183hKqWI7LT7Rt9w
Date: Thu, 20 Nov 2025 07:59:19 +0000
Message-ID: <BN9PR11MB5276C73B3BA7E689EAB90F648CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <5-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <5-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8840:EE_
x-ms-office365-filtering-correlation-id: 285066fd-0436-4555-7e5d-08de280ab564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?KzMkMDAQjZWWSUpeyUTnLOYW+snptq7DDlwkYI4YSgHoKpBtRy1PVrceRH?=
 =?iso-8859-1?Q?xbNlNZ4dfa2rzil5gizq6mR4bKJUSZv6b2SpnUTZ8FCEnMMgK/B3p2zWuC?=
 =?iso-8859-1?Q?VW4rfT1jqNvrYykfVhWU/driBYR1J2OS5glWnKId7i7pP/q936kB/sev98?=
 =?iso-8859-1?Q?DGvucoZ+5RHdvfgRBRQHD2gbK3p++fhN6/H4kw00xKccU+FMWdYWYmLqo4?=
 =?iso-8859-1?Q?zf6m77kwXpR/gBOmRp0tqb6RroLsVcZmzATTEBvhNFH8+vDkpqxfuOOA+W?=
 =?iso-8859-1?Q?1pO90FqTVfgl5Rh1K2OdunRtTUfFxkTdv7O21S7jBQfII229YKwTEuRnc3?=
 =?iso-8859-1?Q?MVkC9wMlWlVRWIiNAuIMzSH4cPuyX2f812y0GJeUeu1pkcYZiC3O3fzvIa?=
 =?iso-8859-1?Q?6bnkRxu/u5ncxo7AB7ySrYbeGL5K8NLVAAqDwLuB+jvryofh51Yr5sXLmL?=
 =?iso-8859-1?Q?ZA3psLSpl3EzYdXyQwRa+QmfR06LX4UBKke2GN52xEeoKDOppE/LHY/C4l?=
 =?iso-8859-1?Q?R+DidO2dw1PKhkzw8cCNcuul9WnpKaxUdcYgkPLVMFO6s4Vu7fCzLxVyeV?=
 =?iso-8859-1?Q?BlRRn7G2K6qDeXeE1U26xRL6/UgSMAXCsihWipDbwxHiyEcAx0wi40yp7k?=
 =?iso-8859-1?Q?cKV5IJSWfjUrnUn4zzWWEX+7D0gEGht21LxjxPuhN2P9Oe7Slav3Q6K54m?=
 =?iso-8859-1?Q?VM3HuHGFTLoNrPYPW+glSYyKsQQuaEog2r8Y6TxqEr2XrpiHqHn8oMuPYJ?=
 =?iso-8859-1?Q?3UYC/FkPSPJmK8OkOymA8z67qwJFnRVyBwlf38cLcSUnJH91WyW9VX0mDy?=
 =?iso-8859-1?Q?KXNQPQWbF3/1Ln3KCP7VFPx6+gw4io4r2PNScTTwCQaXr/fNekz409Vm3S?=
 =?iso-8859-1?Q?AZhHkeqIgePlJIkcv3W8LRemOqvStTiKygilwRs6RWePfnZ5X6Btmvd72t?=
 =?iso-8859-1?Q?ivjqMvB/7yTnaDkLsBFkSJeOJXWFADhf53z7UT/r3ylKaQuw0gY8jNF3rx?=
 =?iso-8859-1?Q?L3cfMfzIsz9xCnpfJrqVHBTJClAxqsyRsuuTQa0gpTtqNK6yIVzATdZXxf?=
 =?iso-8859-1?Q?h6LyP5fISxoSs/kOJErp/nQ43DES6PKB6Hzy9ByRFnj8GOw80qQu+bRIi7?=
 =?iso-8859-1?Q?IBKTtWa+g6eWuRL9JTO56oO1kliVIgahCRDT45tNRigVvl2Xn3TlXA/lp3?=
 =?iso-8859-1?Q?NSiqYvpvaqnS6C3U6V8ZgWZaPN/2kuY/i1ATGm8TTG0XjbMfbTXoSh1n/j?=
 =?iso-8859-1?Q?6x/cffHbdjW0Ny+0RnLD1zJs0SUUR9nQs0PFdyo+Yv9PersQLzLM7Fire5?=
 =?iso-8859-1?Q?jJ0dSgsXweUkN1EOX05/dnnSWSuAq6RNumeiAzSU/50W9TSYu7j+ej6isf?=
 =?iso-8859-1?Q?/7TG3a3X38MkVEBZOKja5X40apYZ1jiZjSjtVGiibH291GB5IkLB5QMP+W?=
 =?iso-8859-1?Q?MMvs28a3QnJfCkM21wyqZ8GST8m81j764LtsT/ODP+k6iGYZWjtRkJAQOa?=
 =?iso-8859-1?Q?67Ix3IcuWQ1NSkH6dvAhBOwpaGnGeXKPpT5eI48862v1P21BIUBQ+vuTne?=
 =?iso-8859-1?Q?d/e2EpWDtS2SCOdVFSyTNYdBl9mnIb4MRAqOH+UogmVwX1gDAQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qmLMSvDJjAPEb4KLwDQtgb36T7yoXKpIzYWBneEy8gF2Yj1RhIi5wPDZ1D?=
 =?iso-8859-1?Q?NU/sVyYDvR/snQiOyH+1Ez0wbeKeFcnmJGLzfxMGckyC0PpaU35wHzS82n?=
 =?iso-8859-1?Q?TeRBnA9a3tqd5IyBBwNrU4/c99rOaKPkV4R62ZgTYnEpm93CwffyH854PQ?=
 =?iso-8859-1?Q?ZL9kyrlCK6bcihyUBpndsS8NnA2JAXpcKpzlS6TnKs5zpEXtAygJZS43uR?=
 =?iso-8859-1?Q?AEAX3xW2v0YXL6wiqSN0Y+SUMEEtYthIUFYosb/e4YRbsw0KGrzeIkWYxF?=
 =?iso-8859-1?Q?5pGJUSzpmVutqC2FGP1ozQ0zI7iqtvkCNcOPJwT8rseapSKLhIMOFk0MVV?=
 =?iso-8859-1?Q?hGUMNqtIWQK/kZR1x7uY22xsOfqEIM0/a76ImCZifsNWUTuTk/rpTGtlbX?=
 =?iso-8859-1?Q?qHAsWyWI2kQ5b/Mxkm0FqJ8PHYNDtCYRGNJ3PXKG9ejvNxPU/Xn7c2xjGz?=
 =?iso-8859-1?Q?NGlBBW6AEINcxPBxLnELH/sH5ufy6JrUl0x39ky1JihWSUg914saFRO+4D?=
 =?iso-8859-1?Q?6R3BhkfJGQq/yVwnWOoC/A7Fwhp/SKWynPtuhGwsUdVJg8WARqnitC2Fm/?=
 =?iso-8859-1?Q?VcHfqCD/RAzadqdAbfiKE8imWuTLeQ78tdAz/XFeB6AniLAC7iCDczFGF1?=
 =?iso-8859-1?Q?4G8wTLuRPRugw9disYyDO5ZQORB0igxK67tMhm1UsrKiwcGbkYmhd+4UwI?=
 =?iso-8859-1?Q?CgyTtqb39L/51lgQuX+mxzKB7+MPuRHqDVAGRmPgEfVZiI4TLPFcug/Fum?=
 =?iso-8859-1?Q?UKjDpdpO2FAfvXCSvmtT3vY5Iqw2CzvRRxW4o70ch26lhfgUzoCywt4YeN?=
 =?iso-8859-1?Q?WtFnH5ffwF3MfFv3aPx0sMzWSW5kik8MWM2O4671Ev+NclY1JJcJTh1S5Z?=
 =?iso-8859-1?Q?H2ZG9icEM23nWdYgsoPqG5R14uBY7Sexd/C74GEw3vGSp5CVFBxQxL8P37?=
 =?iso-8859-1?Q?tLfmA7HxfcrWrtad2AN+mN2pLEWkJbb3HAv0co1lyKhcYgHD+33/O9S/XN?=
 =?iso-8859-1?Q?VU3ZKgJyCJ24D34CYAKqNcyzk0uX1sh5F8FCqc8ZwduavXoeer4Q+7aUyn?=
 =?iso-8859-1?Q?NJuw9OlKIuI535Ppc3R0e1UddNoTLSUozvlgcKbQVTaol8kL2DEe+YI3CG?=
 =?iso-8859-1?Q?IbZ7efgZJ+h2qRyICY606YTwuWxop5XaZno10xuJLCVRTPlmVgXk6mqOmc?=
 =?iso-8859-1?Q?1uzV5BnSCKPt4d3W0vFrxWNQm0Hh+lkXQNPTmb+rAr5cc6koJG4ZGTdZ3H?=
 =?iso-8859-1?Q?DMjux9cTLWGk+GGoqsJNul7GGE/W/60qh+3o9GxvUZdxWGDIuv/1BJoDZ+?=
 =?iso-8859-1?Q?qrY+ocgA7QBuwmckr6cVKS6vb0qbQnoCE1/UCAH/wTKCQiB71kFZEFMIz4?=
 =?iso-8859-1?Q?x6ts9qp8REwlU+If6ydxSgg5yiuz+ffFUgElGw31B6axRP1CCpEXEcarhz?=
 =?iso-8859-1?Q?WXrXVOs6Bd0VTxhlssCUSFlMYWcRYRXv73xPxwyiGp/xBHWe+WHX9Z6FTU?=
 =?iso-8859-1?Q?HkgtMYHlSa0WqUtGJuAacEJNs2FrGKBTD/vajhBJGOadrNSTb/Lvai0ZUV?=
 =?iso-8859-1?Q?EHksqtzz4/OX+824SAncDBnbAytYoWnAfDC+y+U8zbAVZi/ROc/ZyOGEck?=
 =?iso-8859-1?Q?MMXLB95xPG4KXHsBKQchzZ2QvPsHQbCi6Y?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285066fd-0436-4555-7e5d-08de280ab564
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 07:59:19.0869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJsWQzjDR9+J18Qw0FP5MTCmBVa0RWftUNB/se6LRcWykQHQ0UJN1wFP8YllNAcLdtKP/gh9uZjhyRpITIBGTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8840
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, November 8, 2025 12:50 AM
>=20
> +enum batch_kind {
> +	BATCH_CPU_MEMORY =3D 0,
> +	BATCH_MMIO,
> +};

with 'CPU_MEMORY' (instead of plain 'MEMORY') implies future
support of 'DEV_MEMORY'?

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

