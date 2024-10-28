Return-Path: <linux-kselftest+bounces-20779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A2E9B2352
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507012810CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 02:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F9618C03D;
	Mon, 28 Oct 2024 02:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="It72zijU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312F189915;
	Mon, 28 Oct 2024 02:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084085; cv=fail; b=jONCzsz5gc1s+b98OOKsUqn9GolgYZMS88qlnN7LJ5gi9r7HAN6Uud95UpgrJnnhPGlzyAKdgPNc8VI7FhoRHDTTGlrH49bb4LcmdSFrI0ZW29cg9bDdJ0fwk92bnkz+pthjY6qMRtIMpmvtVxZOm1+Sw9nh2CMapd/2cM6dtL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084085; c=relaxed/simple;
	bh=nBX0NyxWhtv8py5vP1f1f7XNpgJtfFUMQ+4Wvvsl7sU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tANBspZgTaa7TUqCexpiCOQE3MDxd3ht1D3Hjq9J0qokjW/uBUnwrTtuqn0pYG2jN+NmL4eYnUmUE92/Mfp4slhfCjLIyw1G/OOt25hT077FbN5X5oGgYp2majSenINV9ilPKNy0V1cBFHOYHu9I9o0jL3/Jc0NPfK7Lqvz2M1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=It72zijU; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730084083; x=1761620083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nBX0NyxWhtv8py5vP1f1f7XNpgJtfFUMQ+4Wvvsl7sU=;
  b=It72zijU4vRzktr+NZbJJe49ckQnUxuq2D4MEsub4zWj3M2rHTqnjw9m
   xvo29cCMT1DZpu8TjOiPjAIe+1StcXBGXhsd5qM3Xrh6ODypqeovZjzL/
   Bjy0FPQ4S5/cyGE1Mx2B0HvAedfagfsNKGp9fvX6OXijO4hCtOaUP9gHn
   l7GCIIA9PvT/s3FSya0l/tFHJVDksEkTHXmtDximHtL1XE5BnF8M1QefC
   AkBiZi2d9H2pdudHRmQIOZcR2rmcUV71jdZZFhHaFyV6mDHcRc1Luj3LC
   rmjaO1D/cDDJ42j6bhmmjjK4bv0bLAPOosqMezLjuESx7jWGROYdR7jdB
   Q==;
X-CSE-ConnectionGUID: fIVCW8MoSvSqOOKpC4f6vg==
X-CSE-MsgGUID: j8EmzJYFQxqz4RpkXSAhCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52227463"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52227463"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:54:43 -0700
X-CSE-ConnectionGUID: oq8LBIGuSGa78l6F/lrxnw==
X-CSE-MsgGUID: +n93uLpbR3+CoCAT0YXtvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="118944774"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 19:54:43 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:54:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:54:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:54:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qa6p9UJDd1Z1M4wb0L2hpD1nxr78wjuAzOg3FgqcnF/unaZMyMtZKsf/d8pQpbouRteke7kQjZIak4HltvZQ3Lv5UqzQg9PuTspfx7GT8CV58PECDCyFNUhTPPIy05cAAq26b5VtrwontVnpy2QKZx0WGW/OxkDee9ne2BCsknvbgtj8JA5FOExG2IordCdQKKbC+53lvzeaZGu0EuWU9iZJHjPRj65EyLzQ4BpfjEpwHW0FJ3bKEcne6u6uqosCvvkwWNcCIZrR8pNPJlYirqmHaMHqez8fFSTyFid+aa+6W4sM3gmHcHxIQTtupSAspEMVBjQOPALxTT7WnCrj0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBX0NyxWhtv8py5vP1f1f7XNpgJtfFUMQ+4Wvvsl7sU=;
 b=aLsOQpIIi1IQyHBL2oTmrxMMIARBBc4uFPGT4Oha5HzM2slpn6rEQQysA+8bmE8XXPmwUvc2+xSsTcCfxXGEHdxGEIlgxlI67iuZyjyVrVZ4o3RMuONcpLG2t3uGlF/EXLpnFk2GM+SqvLZCGZZG8pbx/297653CLNizUpKyxTmUJVgTjVERIKc2oghIYM77EYEJMJzfJoT0igt3LTo/g4qGNSxRks1pE/j1gRQixWgXIK5t3WKlFlfvssP9pHsYs520d4m0O1cSoF7su78xgVVHItsaLMxQibcL8l68eUR2lcjlOY7Fk0Ih50GbDfNHFBRvfeYNTiTC0J4dYllsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:54:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:54:39 +0000
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
Subject: RE: [PATCH v5 13/13] iommu/arm-smmu-v3: Add
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Thread-Topic: [PATCH v5 13/13] iommu/arm-smmu-v3: Add
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Thread-Index: AQHbJzjEFQGb3BMOBkuH6R9Jv9LrW7Kbesvw
Date: Mon, 28 Oct 2024 02:54:39 +0000
Message-ID: <BN9PR11MB5276DD5AC54621A71CDCC77C8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <20c85597e5d579e020f027da4fc36275adcc91bf.1729897352.git.nicolinc@nvidia.com>
In-Reply-To: <20c85597e5d579e020f027da4fc36275adcc91bf.1729897352.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5810:EE_
x-ms-office365-filtering-correlation-id: 6f385178-c89c-495d-6547-08dcf6fbdd70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dq8TC79lnymBKyBxuIFO0Y10xn0XEIbw0MeKnPVVzRAAUHb5XH8TABkUXjxq?=
 =?us-ascii?Q?HyQ0kJUQVTcjpL6EvVp2CkbHue+yregC9j8Ze83fleQdJmLPIkbCGUH3DR2L?=
 =?us-ascii?Q?OQyGTXhvw+Ap62/jzvu2f1vtah5qslnn2NOYGGNn/sYA4LOHnnGVs0DJIcWS?=
 =?us-ascii?Q?SW4LjGTJ69/n5Lh5F+ORng17zYNBd8p7U0YdmCXRoFz9wVTSM6sb8fiW4Xr2?=
 =?us-ascii?Q?CrYnXQUeAdzldNa3koqlxLu9p7bRimMRI9ehlh6V9ax8e93fsFjg8XH9ISdg?=
 =?us-ascii?Q?FvoL6PjO2BzHwEDrqSVAo3ehVqbK/65KB72MDUqPr29ashb1TJmxVhB9zYtU?=
 =?us-ascii?Q?+ckGOr5WCVDvItHjyTuvmoEez5aFDagUxvSBLw9wviKCLpgyA7fhS2HOdoJD?=
 =?us-ascii?Q?GlTuyNYhP25X837W6/ErFihGL4xOua5LayFMlTrJ4/6fi0Q9D1oA5FrFTdwF?=
 =?us-ascii?Q?drnPc5lpUhm0OtAzH8MSGt8F8j/l7Yh4NVrdsvJpZ0gccith2MEZZJ0fLeMt?=
 =?us-ascii?Q?VJUXQprkBqdcj1aMT9bWqTrqtBAhQkdLUoirvM2c4KT4z8d37ioTN5saoKLj?=
 =?us-ascii?Q?k3Rdbx/G7TBjyclmiUN6WR+bifxQ6it+834210klLGtYDY76G0Ef2WaqAJWL?=
 =?us-ascii?Q?tN8KqG9NBAv0YAjdPkUY4SQJRvxq8zkj7lMk1E3GSJ6uFykbWxlM9NC7vLhu?=
 =?us-ascii?Q?14yBV9qVWeEXR5D32m8bbUean0xxLt5o0NetpObbEQEI6gisRVln55KJONsB?=
 =?us-ascii?Q?c1QXng5MTByiZ5AZLbIKPsfVfdud7Yxcq2ycXtIvz472I+fcQJngpJq2Okqb?=
 =?us-ascii?Q?yuk2WbhZsNKKe+iEfN8QZ83YhNdEap3Rr11AOU8TGTixC2z3aYFUcX870piu?=
 =?us-ascii?Q?KUsVVltoDDd+QJ4pTQrZA8qdqj/YcoYqfpyH4nfyz9dvQahmNMDQDdHD6ZRM?=
 =?us-ascii?Q?UeLJKeFc3Az/9llmPVHIzNO5h7+RHmxd+kLCMzEg1tT/Sc7WSlXCdj72aYa1?=
 =?us-ascii?Q?cfm1AfGRFtGQzC43wtBplQoFcIxJMC3OunHRs0fLtNXRRujlY5XbPf18lTFj?=
 =?us-ascii?Q?vGNiBjUDQ/Km9NV3EYTVxBBUXavZJbtRzhwYzWHL2uI06PXgaGviilDq1z/K?=
 =?us-ascii?Q?32ccXaO/fmzqA+EV3pfEcK+fK82W3IviH5Z3V/7PcHVdzGzw6UDXYt2iUsTH?=
 =?us-ascii?Q?flsRl2HMdaaW/jXDR/wP2G4p/+dNRuqADp8b5DzI0qIn0c9lRKTmtkID53aw?=
 =?us-ascii?Q?aKJn3AW2H2bmvK4SafQCduFEXziY4JUrl4msfDSh3oh71UxwuVvGemUpSjgq?=
 =?us-ascii?Q?ey+aKctZTafEI+mzBXApElr3uTv29kWKDg5Vq2eoRPLEeDHkEEJexDyBrjBE?=
 =?us-ascii?Q?LGgQ4Fw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9aURIBuU6+w4bwMG7gZK/zBnJK87E/6j6u2VwzgUHjcm4RufJSEitXjivk1z?=
 =?us-ascii?Q?2fDBbiKLbnfrLfXrhYsBEBuTqbG5I5zw/5TDwXQBcq/Gi9h1eVIgj8AFzTqu?=
 =?us-ascii?Q?Bs7qltbrmIWnh57h+ZRB6KoHOu8cOh6NY4bPblYzsICBEsSwlKdaNp3OLqdP?=
 =?us-ascii?Q?CTJ+Yzj6IRcHAuTrmERNmsil0unMCY6auO09wT+VqfH+zdBxeXSo3dtgRQP7?=
 =?us-ascii?Q?TJ2VDFl6gZKxARefVKkVXoqJXhTPbCaK8Xyz1DbaOxXNOi1gY1CLXhD1i4K0?=
 =?us-ascii?Q?Td7TZyO3FQ5euPDZgX0BwUcTi0qUzVIY4eqvsbWW1M+ciIeUyO3JiDEpypiW?=
 =?us-ascii?Q?dFQK/84e8IyuNi2vueX9DbB28eFcX4CvOKSiv7DWmIVpacsQxDUZ4OkJlXTe?=
 =?us-ascii?Q?whkpz1tZiUgHHSbIfrq+IVyFdZWeRoRtv7qKnF/Lnr9sE/R6slRo3/YLNetH?=
 =?us-ascii?Q?ZrFeVRKubfNoXjb7Lu/Z8Z3cFXIy8GmUSlGdAllKV9iP1Zz/7g0RwXn/0lZ8?=
 =?us-ascii?Q?4j9WOSPzpJJ8aQRbUCIm2RWlXt1/V+MJJyBUNGdqb2EDuGjXB8MkJeW3Phrl?=
 =?us-ascii?Q?o/ztamXwN2InVm5OZsyYX3L3AKWBKxB+/VnCUSd7UdZRox6ptO03qDIeTZl7?=
 =?us-ascii?Q?RLm04I1ysxF18Jhx2QFKS7xJmzRrGpAtSiG74TZb8ngjjOAdQRjIHKaLenGa?=
 =?us-ascii?Q?7WgVgpP1USIiZ8qwvUSWw5wUTiSu8kxQXyFL9wsE9OyFJuaj2fR/2w0DjAwN?=
 =?us-ascii?Q?ymeA/HByekwJzZ3gg84PTc+Jvm+2vW/dhOMWP0LEVvIErgPwifu4Ft8H/1YD?=
 =?us-ascii?Q?Erw1CUNau9pEMJAU0VyLG+YIg3ZgyvPjfE8tJpT3uaO5COFtEEo0iiHgEq0q?=
 =?us-ascii?Q?I70bKxSMi4hfbM1kY/HRmqjGWifOveSngodtRbM/6onorCjH+hDWKHvFMvC2?=
 =?us-ascii?Q?44kWea32Zql1Me6ZDN4q0g5a9FPXGpJPybfUN4bJRke9ztDOfTWK/92l4ZKj?=
 =?us-ascii?Q?k7aJbPHJNIpY0sG+wpTKucybGKOvwO+xcL+2zhxmHruKOkcNuNhzYylgPlJZ?=
 =?us-ascii?Q?cVH2omk5i2EQu481Iw+AfcbefvkdY6F4hm+k0TPrFwOwWPbKle1aNZ2kSbnI?=
 =?us-ascii?Q?5iRWZ+vWVyRjbzQUXlorOHUnvh5eTbWa1kxNHrBxDn372zxX8PeMt4GXtLfd?=
 =?us-ascii?Q?UEWFt5ymWYSOwDLmy+Mf82RJm+4PeEcq7iRuycUe4tq5wFmPTSzivSyzK6aa?=
 =?us-ascii?Q?kP9D0cXE+/KVyNkNQRXp7129R7hxa+17cbNnBdZHZ2q6wWqQ0OgU3NgSuVVl?=
 =?us-ascii?Q?PbVPoFckgtD+jwLQi2fh1Cw2Zl4lJsCl5gduQgjlAmHq2FhvSxLFXiKZMmBG?=
 =?us-ascii?Q?NU3pqRD/W9VEJwHq24e5zFuILkTYwDLZ+R1BK0xeM/4TzCRgH+aEwdOebx0K?=
 =?us-ascii?Q?bswp+bjdYnTkoc9g1QTY7MZkNJfUfEWWuxOMg25+0yk6ihcxfEpxI1XjIIMr?=
 =?us-ascii?Q?hN18dAnMQNIuwI6tBdz0Kgjd4ec8KHAqYA0fPx/ZvDXUlJWJsmlS4XceuqwY?=
 =?us-ascii?Q?ya1Hv73XELbXlDmrmTLGCT2p4gfZm+qk0jcbnFna?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f385178-c89c-495d-6547-08dcf6fbdd70
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:54:39.1839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: phVYF4d8usmwcpn3HrS47A4+tcH+mR8H/4P2wfzd1qd3ZWHKnxv7Aywmw/z4HutlMHRod4fw+lJqFUkfQLPx6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5810
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:50 AM
>=20
> Add a new driver-type for ARM SMMUv3 to enum iommu_viommu_type.
> Implement
> an arm_vsmmu_alloc() with its viommu op
> arm_vsmmu_domain_alloc_nested(),
> to replace arm_smmu_domain_alloc_nesting(). As an initial step, copy the
> VMID from s2_parent. A later cleanup series is required to move the VMID
> allocation out of the stage-2 domain allocation routine to this.
>=20
> After that, replace nested_domain->s2_parent with nested_domain->vsmmu.
>=20
> Note that the validatting conditions for a nested_domain allocation are
> moved from arm_vsmmu_domain_alloc_nested to arm_vsmmu_alloc, since
> there
> is no point in creating a vIOMMU (vsmmu) from the beginning if it would
> not support a nested_domain.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

