Return-Path: <linux-kselftest+bounces-23154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEF19EC5B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB19C2849C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 07:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7621C5F14;
	Wed, 11 Dec 2024 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCV4HF0t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADB2451C0;
	Wed, 11 Dec 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902899; cv=fail; b=JNSI3fce+WG9v1xnWNm3qG6ctuUwhSSSXOlLrMWFNbRziyaDOHIZk5ewVz/Py0HupQt0RCmohPRCEDdB4S+M0uE6zYWyAb3TRQQSYIThljG8SlzjnYdrGd5QiyVwKawOwa32GKbJayVhyOKazlY09XGn7rt5wphpj33G9xlkabk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902899; c=relaxed/simple;
	bh=BZQI3Xg77ZhH5P9A5CS7kA2hpO4ybDLUOiphwIJyR54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uqohxrb/y8VNpIoLpisfIyaDAituOAvG94cMYGNVbW3GqjwOBg0C3iYSmfOZx3NN1CSju6zak6qsF3pxGWaFmnhi2aFLm4wxZzERUi/b+AQRZpTjcUa9PxzMyVLCieonvZ5pbwPXNAAWpR0wjRd37nQu+naVuFgQz+jueqglQ70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCV4HF0t; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733902898; x=1765438898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BZQI3Xg77ZhH5P9A5CS7kA2hpO4ybDLUOiphwIJyR54=;
  b=DCV4HF0t/yO2CEbBPYWeJ6k8ewWCvwcsTK6NW3bk6DkMIjmEh78tlb+K
   7dFi8v1Rd7g9HEfP2fLMRkUuiWAx0/KLiWtntIugvVvQaNjBrjge8VE81
   ioYVVD9f0x1mjwr81QqitPHP0t6HnEKdivmdGHihJMKdTbHFpeQJfqR4R
   qWt1bz5rpHyHbnHA5S8WqLDDW4Nmp+av3tCN3EVPy1oqhLfYT/p1xCQe+
   XvlQWeSMioFUePGPT6qGvafugynPt+wEpp8dHx7qO1UJwou7wQVJ3QTcO
   waO3tanIC0UFr2MnFpF4cyWXkqLPbYojmZBizFHxNfTnWy8NNkhkoDNTv
   g==;
X-CSE-ConnectionGUID: niioQVggTeWMovPW0B2KaA==
X-CSE-MsgGUID: jUiVwXXvTLK9m7qN71mcRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34173049"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="34173049"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 23:41:37 -0800
X-CSE-ConnectionGUID: zsXWb5/+TeWMelfWlG2g7w==
X-CSE-MsgGUID: oW69JUBjSLuePRpguQV2QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100524672"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 23:41:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 23:41:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 23:41:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 23:41:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4vQ9fjQzV9oykqqyjoynmkcVPA+DF8G8909HjhfeqxIpY8Tt9ktFYP8BrdemGxyowUd5fvcJ88iBP6qKLQmv1CkRMQuyvMkfsJ2k+9IbC0WTPmNYC/7+CpBhSDCgQUTieAGicSsBa6lbbG4Ofyu6jjQbyt6Tix3kHXFwXK5Qh4p0q/e9LSLq+D/3Ck5sCZy+kVvS5ozu+lnPPEsmrjp6D1kwmrb6wgF5cH1KEsorh+ux2GP+Y1nZwBDwUhHLeUiECVr9PfNwp+iTFys83sQxJUgMPByjvq8tMWHA8UCyD+r7m+/QXVauT4qdHBf1idwQzWRBwdc7cpnibg5Bz7xRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yc3TEMVSYktMmEsAW4oOAYqJjE3TwHFZUXmmDWFt4Bk=;
 b=T2QZd4a1rl0tLWHr6SRaZqtdlVpzq1UFHOe46bC7iWnXjKxAKB7X7gEnl0hNnmRsTH3QcTzXD+VjOZOVzNTwzxv4TamnQzWxhU8LT/BS2c0SYyWY/ObBs6uoNnyifWFD1KwuXIozCysKcF8nlI2lC9uSdqKrQLjTei08QqaGGzhfIk5gp9PPqNTSRaOgmcvKbp/yZrC13VgGkVo+VJtGW2YFWtnEvxs3uYV/e5eOpgVk9RbkFCcGtG25gJoR89A831yrwi+FzfdcSiiuqiyUwufQXjtSjGy7bCVKRprrWlGKAM41avzvvVLntGqZ3nCZMR/jW920e30OUBn8Pmp1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Wed, 11 Dec
 2024 07:40:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 07:40:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
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
	<yi.l.liu@intel.com>
Subject: RE: [PATCH v2 03/13] iommufd: Rename IOMMUFD_OBJ_FAULT to
 IOMMUFD_OBJ_EVENTQ_IOPF
Thread-Topic: [PATCH v2 03/13] iommufd: Rename IOMMUFD_OBJ_FAULT to
 IOMMUFD_OBJ_EVENTQ_IOPF
Thread-Index: AQHbRdB5m863GO/NIkK43O5c/RJOl7LgsgcQ
Date: Wed, 11 Dec 2024 07:40:52 +0000
Message-ID: <BN9PR11MB5276F92171A516C2A17839458C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <2e2dc5c9cd8013147d4a8ee0d6c9d59c9ebe1954.1733263737.git.nicolinc@nvidia.com>
In-Reply-To: <2e2dc5c9cd8013147d4a8ee0d6c9d59c9ebe1954.1733263737.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7925:EE_
x-ms-office365-filtering-correlation-id: 19850998-f959-49bd-a54d-08dd19b723b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zdNnWqb1mE+8JmfS+NNGSXKSkb3WIo8MuP0vkB9XtpSYJLMEjuSqzwRkPHp2?=
 =?us-ascii?Q?q+zzY+JjSOpYQUukJY31BOMH9WX1XcwwaATEPk9QyDA5xa4/Lq0uP7dLO7X/?=
 =?us-ascii?Q?mHk37Hl8lZ74Mw3RFpF/E2MM5rH8Xvz8pQLTiKJCT7AOfxXyknBjbgvCO0jH?=
 =?us-ascii?Q?AoSp162xek+qGYgN4ErokBNjwbgdmFOF3Pu/IHArNUiBhQp1rOeb7Ugd1cJT?=
 =?us-ascii?Q?07NXPkwfQ2Xmgci+FjS7jIFwiMqC7O0g5tafrL7ouqJD7p1kVbOge5BstuT+?=
 =?us-ascii?Q?VCGay+aBDvkOJLoS4oqYiAJceIxEgtJspXuosXmnGfGqeD+5449EyLuR/EQl?=
 =?us-ascii?Q?llh5RQJaVtFPUM9YFaHbAzpACJtJjL/RZl4iIet5sIkFP3FsE4gdwsmLMhIl?=
 =?us-ascii?Q?ncwnWqRMYILfHxMHVQ9xngqaRb6zuHJNT0bk0op2VQn1TPurjoVfaGiK2m60?=
 =?us-ascii?Q?dRVov1/9/ckW9YjH+geOAATMxFBhad48M/Q6r6pvcHNEzBLxDn5xv9iOTKaH?=
 =?us-ascii?Q?lQL5UM/p01sWwx34zL5VqI99ZGVfLYlm4c4/7OcTFM7xoJr77dvUPOBcR8sI?=
 =?us-ascii?Q?pWo2LgbQH0hrtBE9EP3iTflFkll5DfsXAy/FUyMtKDct15gCSqgaiLd/k3mj?=
 =?us-ascii?Q?7tvlKnynbqZodoMFBUbHV+zyJKorkXhOSwCBVz6KvYT1ydkAsCPrjL2haQpT?=
 =?us-ascii?Q?ZQU1dBAahER/YhV4NoLQbYXBAqGK3G7V3hHPuvJBNcHoLF+ecYVPRjJNwCpD?=
 =?us-ascii?Q?WebQmwZD05w9ZhK1pnmYvRAFBLp/GXD6jgxsxzbaVORMN7JEVITvzg2LFZZO?=
 =?us-ascii?Q?TVcutHOR7nN9Iq2wzEnDTjtZGeriaJj3y5Xex/CmgIM/IWVGt5gnlK/etTq/?=
 =?us-ascii?Q?ZuZXj1bR8X6cTayxIc8BYS8ihxjEt2iuhwGmGSycIEZ8QZDcfpv9/lqSu82A?=
 =?us-ascii?Q?heBSAXerY9//42Vn+MXcYlD9lk31aPGMB43DL63Iuxsk/tTNMKAP3ZAD2DEi?=
 =?us-ascii?Q?SmUUVh6o2QVkp9DW3H1xCtlPvfN5idWztaPaS+b4FhJB/Jjlaf9VJpZdc+FZ?=
 =?us-ascii?Q?P/9KFu1fF3NJ8hJbZtsYBjV9Dc+AyG7ojvTG8EVRe3ORO1EsAmVXQ7lR0Go0?=
 =?us-ascii?Q?Yxi7ztsvCDNAwdJFbA25+yka2nY2jdlbPs7dQZaf0XtHSBZMswOFF7npI8Xe?=
 =?us-ascii?Q?Wo32ZO2zSgNjs0CM5qxCjuzfS1N4TTXdlE4l6+iLnKXt9/ORqNGeaBzijmWc?=
 =?us-ascii?Q?FluZZ9xgcax1aNmg6gdNSfqoOzvYqooTvYHbMoAXuvMYdfa3ozKrBN+AKGLP?=
 =?us-ascii?Q?RC51pdnUe34713UkWgtOTy5Ap9x6U5Hzgu0A5pzLUR01KP8iGD3qbLnYeUMj?=
 =?us-ascii?Q?bbRcg2Egmhze9WlAnixHI9tUCx5pgVDxtjbpPd8o292kAUV+KQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nAoml2LF/tdK+eDRlCVMredaYK0j8l+hw2poOvBVGkI981G4PhDNlgHlSexK?=
 =?us-ascii?Q?2SZ9oQLqukBGUvOzwSUfPvfSf0YwzO8uHEuHPk5VWC1xYPQFLuqPV24JjWvq?=
 =?us-ascii?Q?zYUa64+A46O1QSUiMP4HB/kgXhPtBjQlN7nRNX0uZq4GVIux0UeVZyjOurWN?=
 =?us-ascii?Q?l/vm8rZCfJty4jTD0aQHhQnHR9PeUmLGdzcSMbQIPeZEgZGBZjHhznAr+qzo?=
 =?us-ascii?Q?+mx1ELORbnG1U0S5XkGLpDwmCGaj/tOfwsWYSEIQGUR/K0NW84Wqf+osqE0i?=
 =?us-ascii?Q?5ffx51pKon64eNY6ayGV9wbaRITexWKUtrkOvcWvZo7IK7BmxfDapli3Crem?=
 =?us-ascii?Q?4OV83LMfNbKfRx+AFjTmn97+sCdMTaLBRpRNPw3V2Tr5JIlbXzp0ZneaI5Xw?=
 =?us-ascii?Q?ZUx48IH/e+34ihrh6SWkLGxgWupqByuTvNfsCtJC4XdDA5/HawcaoHDIWOAF?=
 =?us-ascii?Q?LaHF4FaFXKLCOq2F61SHex1/Ae/gOEHySAc3XQKJKFz25mIIc8QKxI38jM/d?=
 =?us-ascii?Q?tJ26XMHOT0Jt8AtDS/OAJi45RNBQ6H4ffItCzDQrB5j1I64cLn0ojC4l2Vef?=
 =?us-ascii?Q?2Gp92gzsIEwqiAb1LsEC6ne9AIcIWhtLvKStxtALeeNRR1oJ2RMEda3UKjDC?=
 =?us-ascii?Q?W0U1W249VSwWTIyTWR9ZEzKWFgplnZE07+EhfHqsPYPfvf/DZ272iZu+axm9?=
 =?us-ascii?Q?TIdfS3gM85utqYrGAE7wU/xGinOcfXmcY3Po0PaU0AxzUBxPkLgOZ8jb4GdB?=
 =?us-ascii?Q?wLLpn/MaWJ3ycZ1fP155GTmWhvWnABJ+QlKPb1CdOBAok6KHLwYB8t+96T0B?=
 =?us-ascii?Q?0br2l2ze3Y2KN5yUh+qugCwuhIl1O6n1B3tzRbIm+xM7aYrABcd78vp4XGxQ?=
 =?us-ascii?Q?LVwW4F7ezrMzMtW49svFnAsFjhvfmq4MDHUjwzVsaJHp/n7px4E1etma8UvE?=
 =?us-ascii?Q?Okemwgnojy9ttrHcmHUaceD554DpLmpwHl4sHmAlepz4Xi/jsO97YKPdtpda?=
 =?us-ascii?Q?CKmom9r0gibgSwFp93tWBLnKm8wGPMBpG7DD94pqxTAH5mFTctDociWgohLl?=
 =?us-ascii?Q?Jfw6xwQL4Oc5RPk9YP2rdI6smpW12Cm6gjaHqNyFotYDXBR5AR/tyAKyPICf?=
 =?us-ascii?Q?BOsbN3wVJTLCGqsf5wctPiaRWi8Dq9nJhQ2/HLAgl74Mtu6fwQ3F29pjTQxj?=
 =?us-ascii?Q?amZB0J+7qdWUAaysY6rVWk8hipr3cEEJejZBWOlIQO3s7sEgUcGP2K8oRJjL?=
 =?us-ascii?Q?A/l0xfZ1eNM6NPU9arzA2CnYdSqfDtpwjTIYKMzOv9WcBHY4bDmyByclp/Q9?=
 =?us-ascii?Q?Fg8/y+z0u1ttfJu7cfYLnqp9SZjob3FOQLlAx4ccTAZXzJHnxDF/v0MUXj1S?=
 =?us-ascii?Q?J/IFx1dR6gaZinpr35KejERfw9+7xiP5V9HSfLswgEG9jTvR/pvULStQ0qv5?=
 =?us-ascii?Q?kbMGUZ5FqS9K6asAp6ixMRWXLjQDhfE3C1HXWA9kTLb9HXn62cBBmb7hKtzR?=
 =?us-ascii?Q?Kn06VD6MQR7NeH0y35eDILm/o3xtSGc+qOUjhdjr8ynGAGnRHSq/Aeu0nge+?=
 =?us-ascii?Q?J68HVdr2tCniUZ+0adHJeshEsEfgcf6/1pUmbcC1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19850998-f959-49bd-a54d-08dd19b723b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 07:40:52.4620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zAKF4xffwYDrS9pEeUZi7r6cPt1/7FOBtx14OIQV4MZLl5FMJWOtx9QwokQj8zKgjXgprAR5gbkrbLXGqlgew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7925
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, December 4, 2024 6:10 AM
>=20
> The fault object was designed exclusively for hwpt's IO page faults (PRI)=
.
> But its implementation can actually be reused for other purposes too, suc=
h
> as hardware IRQ and event injections to user space.
>=20
> Meanwhile, a fault object holds a list of faults. So it's more accurate t=
o
> call it a "fault queue". Combining the reusing idea above, a "fault queue=
"
> can further rephrase to an "Event Queue for IOPF".
>=20
> Rename the struct iommufd_fault to struct iommufd_eventq_iopf that holds
> a
> common Event Queue struct, similar to hwpt_paging holding a common
> hwpt.
>=20
> Roll out a minimal level of renamings to all the related functions.

could we keep iommufd_fault? Internally it will use the new eventq
common struct but external facing names are all still around fault.
the size of changed lines will be much smaller.

Then later for virq it could be iommufd_viommu_virq instead of
iommufd_eventq_virq to explicitly draw its connection to viommu.

this is unlike hwpt where 'paging' or 'nested' is just decorative while
'fault' or 'virq' is noun on its own.=20

> +static ssize_t iommufd_eventq_fops_read(struct file *filep, char __user =
*buf,
> +					size_t count, loff_t *ppos)
> +{
> +	struct iommufd_eventq *eventq =3D filep->private_data;
> +
> +	if (!eventq->ops || !eventq->ops->read)
> +		return -EOPNOTSUPP;
> +	return eventq->ops->read(eventq, buf, count, ppos);
> +}

the check on ops can be done in iommufd_eventq_init()

