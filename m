Return-Path: <linux-kselftest+bounces-33163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC395AB952B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 06:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5B59E352D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 04:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4685423182D;
	Fri, 16 May 2025 04:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+Ud1/7L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDF1221FB5;
	Fri, 16 May 2025 04:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747368517; cv=fail; b=dxkzj5WXYcKYcOf0UYg5kxQqZrDruu68A/3eWxfBXfAQiXB8S42cOD7tzdTeAOUnBzuissjSqzrBG91m0IMhVW7n3ewu5ojnVTqc1U2k5P2e8rHzQb57TKZM21Vagh2JzPKQAfltkxQsHVaITeOIz/23MM+Iw4CUroIHDBmTK1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747368517; c=relaxed/simple;
	bh=CqMDnQH2CFayw4+sp6tqCLJ6OlCVXeeTjujISCQfGr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tl1MvFKVQsX6l53hGkwO7+ibrdfegV+zjJJ08jo/xh+jWamQ+HeFqPEb+Xm0aIgfDaQwH/G2rcJkFdeAo/iDoPNDJO/m7ylUN02d0ySRQ8gDtS4eI1xr4z56Iy4aihM1GQkQ48O5dhk6cr/jpafQWOyPtW1aUSd0Q/uj1OPSC1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+Ud1/7L; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747368516; x=1778904516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CqMDnQH2CFayw4+sp6tqCLJ6OlCVXeeTjujISCQfGr8=;
  b=Y+Ud1/7L9IXotd+MTo9wJV6rfHdvrQXLytRcH6ImYaVLJkQqUBt16S8B
   N2XLNuDCYYcCN1aNi9Zvue1Ei3O3/N4VbahWSDOOZG9ucQLLLeR1ITZYx
   pkgLsdFNNjPf5U9NEzmvzPQPR43VmEKncF8qNUS12Tx3aRtIxhnsIMsXe
   ZUsD3zhNWTuNLObXunFPXkhYUomzf3aSoBex5RBkZrux48FEKMq5Zhg+e
   I7s/Z14AUSzTvzV5hoN4JFYu+iv7TRpPbFp5aYeerY8JeMUJGrZNpHvAY
   l40Wc3g2yMSVEIayIPKNHRJ8PfOkOVGgasesozoYhPABVSXULcXyuyxP6
   g==;
X-CSE-ConnectionGUID: SON+0g/rQ6CQfML93O+Olg==
X-CSE-MsgGUID: oao4BBmFQhuTSCJEYzbQsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48446235"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="48446235"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 21:08:35 -0700
X-CSE-ConnectionGUID: F3PFgkOTRTiEsg1jx1ARsQ==
X-CSE-MsgGUID: azf2epLUSMKI+oR9x875nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143459161"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 21:08:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 21:08:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 21:08:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 21:08:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5ZwA8ab9KW7qXkjjyfpJOwwx8mz7FL6JY3R6NvAzUvG56VPwO1/9Z/LSLY/2JSesxpdusWy0WNm1TwtTceUi7auJeqLguHrOIrnXPVYHjbXGESkYVhVEs6Jg04KamEiKXnkZ5iCpHaHfcOzRJ2DGBpDudAbVde4oZNTlt09JwMlmDPo+gOzl3RsJrx59KcFdTChd4cpjLRQNecjgb2HBfxN8IKgqhwyZCAABgPF8TO3wyJjwsclEeD9z7snBKWkI04H10++ttB6OKJt6NZ/WmujpPdjOd98OxFHHbv8/W0gade/JGvMMW928d+24bhyQQxoQTCqK8gFrggfL0FtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ6MZdqOr8g98aYFXPznPaYKQOEqYHvkbeK1soidzL8=;
 b=eoocQnlD9h87acRKgZ9KS64EtdyCibjxAF7LoGl3enPfBHpgN05T3K8bYJ4Df/BVwV7JYkevLLD9DWKcIy7qUo/VAm+Ewh+QKRoimO9HAEl04Rqzp8pwtd1+bfdE29ydW/F3+uJd7aAL32zWn5GaTUtkPf6bU3ODimPOvOb5a0EC++9rlVtYCSJ2LYaRzo/SwhA00XCFcI9G/0Hpt/7SznRLn48CCJp4CTth+LrEH76doIdCzCE3Lw6hsWCPUrlg6LbIcYTZW8tovxC94yKXulY7sbLIZ1GCekivqe3VfQFwfkJ2Fcex3B5Q70J5gMjBbW5n1tWymo2VIOy8MKI8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB8091.namprd11.prod.outlook.com (2603:10b6:8:182::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 04:08:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 04:08:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
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
Subject: RE: [PATCH v4 14/23] iommufd: Add mmap interface
Thread-Topic: [PATCH v4 14/23] iommufd: Add mmap interface
Thread-Index: AQHbwI8VTngA5r6ko0WEuL66n25SVbPT8OqAgAC9nWA=
Date: Fri, 16 May 2025 04:08:25 +0000
Message-ID: <BN9PR11MB5276DD2F2CDC313FA04155C18C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc@nvidia.com>
 <20250515164717.GL382960@nvidia.com>
In-Reply-To: <20250515164717.GL382960@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB8091:EE_
x-ms-office365-filtering-correlation-id: aaf7d3bb-a33c-4a42-7a52-08dd942f4e50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5qk5SEjpcAk21xy6Ck/O+YkmgMlTmwlkL+ewcMXmzrv8VgFvQZ/xk7Zny3lJ?=
 =?us-ascii?Q?Fkl481EaQisOVTAMn3KrO4GkkcFBlrYIbn1rEyqQmo81g2mSAU0Z2WaPkq3x?=
 =?us-ascii?Q?oF+oipC2rW7hp9Lxd5b0M3JyITnUpStBkAABOx/zQEt0EOMGZ3Xf8SvmGorx?=
 =?us-ascii?Q?MXrdHK/OOJ2PHC2lChJ5KkkOmMoYyjJxnzpu7Dcp3ngBeazgJGPWZ9yeuDXI?=
 =?us-ascii?Q?CK8oTdJZMZpNwStRyxkYlZIl5R1LfMhhs5OXDqUOlFuP4xymClF+MLEJQJVq?=
 =?us-ascii?Q?T8drHn740kDl1/ze6ebaveYI88k9dXnXa6ifDhrqES7dtaJQ9lwl1sZ0EHWk?=
 =?us-ascii?Q?lJS8JfmNWBSdv8Ng/b8rZAEn2iC+qT7EQjaT2z2ri30fuYRTRrjdASRmcvrW?=
 =?us-ascii?Q?PGzPnN5pJcernibjYL+Zxe0zv6Z1zQOaK5URCmN4INzSkGIC8EYlMhL57/MB?=
 =?us-ascii?Q?6OJ6FjTAhKo4mtPVHv0m2ZgiDYXmVrXj2MxYUUU8ogBO3LkOFIcJvlHMuMcW?=
 =?us-ascii?Q?n/rBLb3fZPHEaTGth9QoJpqEF5iQb4MxTd4gj7jgWn/quUaTxQAYvT+H+NaG?=
 =?us-ascii?Q?DNd093Fsajmdz3AO7GH1Z8FUYW+mfdnacLolS3oSdFlbEKw+nYuGDX8xyo6l?=
 =?us-ascii?Q?w0qt3v9y9SDpu/vc/QWmmXMFlADSaPOnO+UhDlQOzO/+Ay8B6+cG7Uz4TpnC?=
 =?us-ascii?Q?DpJ7mMuKCZGZXwoKCtoqiKWFPMcE9YUh5Zvq3qcN1UJRsoAgKvO6LKE1MfA9?=
 =?us-ascii?Q?nqRlz/5008lddbTgywCyTwv7MqVhG4mIFaNodmZJFNkwzS/zbEKuYuprUFQn?=
 =?us-ascii?Q?UCqOeC+0qWCf+qHfSOT/pZD/drVvLCeJSQw/8xb162cHN9ahzu2OHe3ETOVh?=
 =?us-ascii?Q?rBCuue1WfdNZJuPjYd+nB1s2cj6nY7fS8YPongrTkxjyI+Ji2lejMhW9f7Vb?=
 =?us-ascii?Q?W0EjLcDnp0XiY74Nij76rzZNiO4Igv/TDUFzB5auOYOGb5XYpVwW5c5HhfOh?=
 =?us-ascii?Q?FifxEPUcmiMHieTbhKyjhgFoa3gYocaevRSfyzmTjaSKmlycjV8nD2keNRoe?=
 =?us-ascii?Q?Cd1jsX+TZBNY7DaI9Tr+852Q5gaH0NEXTbmOYrA7yd0fXAxX//6SJ8sJTJ6T?=
 =?us-ascii?Q?Xe0/jO6Sa0ckpxINAf7ucuH+2MuldGWz6jrABRTSLG67AumnGf8/kS5GZTwz?=
 =?us-ascii?Q?y0HljRXms3IoQcJ9jibKz8Yeo296Ks8belOx0ndj2NaPzACufO0uYtoIxnK1?=
 =?us-ascii?Q?Tc0KfmbnItaVd+SMQOauya+ukFLs9tP9/v4Ku4Pid7APkxVusNZPUNGQTalA?=
 =?us-ascii?Q?r4EhyhHGJ+lY0BjCFqBN5ATZqsoOALFFE1etEF+1RJQb74Y+rIusC8qCF5z4?=
 =?us-ascii?Q?hHhu225FCbBbZuXnXVDxSTCSZ4XG3Rr1vAYcG9BOMD5LtzCvymQb4F2YvCbj?=
 =?us-ascii?Q?n4n2xA1324GN1LMY7KH/EPEGavt4HjeXfFcKUaLMyft0latscl12gw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JAYZnc3BLZurKQVif25eS06noVtsn1uKOkrEGTQKwL0/ad7uw4+ZUh0ohDWp?=
 =?us-ascii?Q?4/S/9rpR/Yg4y/i3dQF6IQSIor6BXkAMpSjWB/Ct3rdpTkqMXV6QUjiXq09A?=
 =?us-ascii?Q?LBH2aHtDw8wyQAVl3k7RkNd0vNKzuzQqqOKZPr9+UcqrrAvvN6fFprrLiHnU?=
 =?us-ascii?Q?A/QaF8Wo1qdoScRbMoba+PnTjO8yUKOnxcOpPgiO/f6NIhAHfZjdoaVWblYT?=
 =?us-ascii?Q?cnO1B+pj8ACB4O34ow4IA+e8BVvUoMp59fZ36coWbXwNPgB8gPOBrxF+CD4h?=
 =?us-ascii?Q?7KTjvvjwoL5ZeVpYjQCPdtcfVdejSSuwnvk3mpGnMXnRZCOKgC2HHYFCY9Sw?=
 =?us-ascii?Q?9zkKQ6R+4/QR9cKEgHWSS8VhwG8Fbuv4aELVSGEXH7V6/Scl5vMGx9eSg2pK?=
 =?us-ascii?Q?V3jUDzJxJORRCclrMNWpzHazhqKGhAPUobRtbcTK6Njutm/FGUXinRECjoko?=
 =?us-ascii?Q?YO750HEsJizuccD7yVWr1z4kyumWTJDiOSFNS55V7g2N0cPy5ViATIOWfqSW?=
 =?us-ascii?Q?aueakaF/MR25uGf3TOvVac8H65DRb20cYy4lJa2sHRcYgxZvwP/8AIBN7TSV?=
 =?us-ascii?Q?l/2lyLDKWNgLQixYRk0xrAdf82TDakWIjHn7EJtUi1YjIp04gkbe+D5fBWxO?=
 =?us-ascii?Q?rAtePo5SzoDq5BZcyiS16bx9ZbJpdw1Cg/9LaFFxRe7btPNEunRaAouttFEK?=
 =?us-ascii?Q?mA1YR0jAksGo5LeJXVd/E+X9vupzIt2bRN5aYQfbXIBq6rFWfewnxuMYUXa/?=
 =?us-ascii?Q?69ir9D2ey6wrMtYXWE7EEI6900loTw3TPd6XCmfQqLyQCndOrEm/OtaLaAx8?=
 =?us-ascii?Q?ZgrGkK2dkMjlwVOdiOl6m5EuKUk8WBf1p625YteCU3vOaA2lThMO3uyL/OYb?=
 =?us-ascii?Q?OLp9RLslLz04HOnF2i++FGTzGhN77wDcOv+2wKuOvNvEZGLTRpGzVKHAPDO/?=
 =?us-ascii?Q?dH7hXCHufntwD8k/7Zg9uFt9TnlNgVnod5kq4Aqi9r8tspbv+laxnodS6vkn?=
 =?us-ascii?Q?91ziUyLIhIBCM6L5Z+9CLnwuBXb4SfAeJ1HkBSoK9KL14T9r0gDaprw+FfoU?=
 =?us-ascii?Q?f5we4MyphZ0l5RzDl3gh3dmkin/mrSjl4m3I9IxRBNyrXL2Q4sjyC4/t8U/l?=
 =?us-ascii?Q?Fk3o5yo6NJTsL2ASoBHTJwxXa0P91SI9bz3njxlaa7fj34oquVPdLAkegzIV?=
 =?us-ascii?Q?zMu1hh+YDLa17h7hgZRNfd0C7j7IwDea6LDHxvIYYLtnOf9FBn0yYJzvSJIZ?=
 =?us-ascii?Q?vjhBob9DOyMjVMZQkx/dQt/BZGCV74fCJQ3rdY9wA3dZEB+0dC2qnfHY6OB9?=
 =?us-ascii?Q?mxaQ/4xHXrOfBFaDDb6kfJ8cwWz8w5sl9yE9XaLUlHAmlPgRqmI2KH6fZzsX?=
 =?us-ascii?Q?B+eadsAHUiaHZwwQuEAwzEWrd5GGtIWTBJ18UCA4cIu3fsarwazKQxYIEH08?=
 =?us-ascii?Q?e8SO6sLFABMUsRSaVWBxFdi8IoaZG7Pzj9+wRXNbgAR7eNMduR1AJ2Ji5efQ?=
 =?us-ascii?Q?G21HGBP2jQXBOGMbiOEw2LAN+bf1VUcH95/WzQHkeh/ZQP9h9eq/x1sGgQaq?=
 =?us-ascii?Q?RotdDyfC4xe+qU2/9QKdKdKIiGclEmXHtF/Nhhsy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf7d3bb-a33c-4a42-7a52-08dd942f4e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 04:08:25.4387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYvC6a3FpPhY5C6KKwBHERQFIlAXQWHaUxbcnRQHge7LbY4RDQaHAmtQ1Ih2H1/0opQnWxE9QhBoeXM8a9t59Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8091
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, May 16, 2025 12:47 AM
>=20
> On Thu, May 08, 2025 at 08:02:35PM -0700, Nicolin Chen wrote:
> > +	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
> > +	immap =3D mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
> > +	if (!immap)
> > +		return -ENXIO;
> > +	if (length >> PAGE_SHIFT !=3D immap->num_pfns)
> > +		return -ENXIO;
>=20
> This needs to validate that vm_pgoff is at the start of the immap or
> num_pfns is the wrong thing to validate length against.
>=20

vm_pgoff is the index into mtree. If it's wrong mtree_load() will
fail already?

