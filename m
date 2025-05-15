Return-Path: <linux-kselftest+bounces-33031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94337AB7D5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B264A38C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6441295DB8;
	Thu, 15 May 2025 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2pZcmmO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0477295531;
	Thu, 15 May 2025 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288471; cv=fail; b=EAT178oiNGQ0ncMzg+IQjqvdHSahkV3D/Fkkmokf7M/vcT7cEOS6Io4KyQogdwmy0v0NZuYJKd9Hav0VUarpu5HFFOOsEuu06kqK6kTaAMZoQmEJ6o1ls0ym4DeOJwxr0FDPAlWDUxOK86WaaeL+sCCVl0JIzq4vNi5C9zDkz8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288471; c=relaxed/simple;
	bh=kaq3TxKCll4LYCz5rrKjWJLsdDfBBQRiZK4oSErJvTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o/48KM2jY+KsdDIY+ppYGXFTeJaIP7z6Y/HgfEoUHp3z/z5ec/vAMGMzR1GuXd5EEuWc3dRiQKK3sIpYV6kR3jhN7Iwoxd3XhTEnqVux/UNwrbuttku75GCRWdv2a5Y8gp0F/A8fmvOUZSDBzNW3PWz4t9p8ap8mCrNtoNjZpc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2pZcmmO; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747288471; x=1778824471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kaq3TxKCll4LYCz5rrKjWJLsdDfBBQRiZK4oSErJvTk=;
  b=e2pZcmmOqYSTsNQooN+0aXT2yG2MWaj2kWgvLZVDkdq3ZAJ5o8pbhTNq
   y04KXY0f2snvmscLQx/4yQdJYbtbxHwmfbhdTj38WChEadHSk8mUpWg+D
   P6+xda7mM5WZpp/nQgMnY/gWnq3x5J80lNa+l7wAQQpliDYZ0cDh/NlLu
   IU2Pbf85EzDxxUHzva6eqpBpnUJFuAhUMb45ho45SNFxU9LlNamKMyVQf
   AmWKm/AqvUaMr3F7Bg1pWAQbyg4i58nBf+5ty8sV8GwP0+gchmAf0un3z
   iacmc5svkVrIbXa/uN2Dwtt+c9Gz6vDh0sJfqAvEhbRg3EwEa3v8CjldU
   g==;
X-CSE-ConnectionGUID: pLs0HdpXRnSXpwa4zOb4og==
X-CSE-MsgGUID: hDk6FMrcRkC/ZvsRnI7eaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66614421"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="66614421"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:54:30 -0700
X-CSE-ConnectionGUID: 8f0L2vyOSrOSZ1YibdFS7Q==
X-CSE-MsgGUID: Qsfv81XRR0aO1DGNRJ5bgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="175391602"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:54:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 22:54:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 22:54:28 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 22:54:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzoI+lb5sLBSxFoziQYoJglvKYjEjq3SMlU97uAgUduWiP6zYCjUBRR+SATKSextjgyT9agSprkIamzhkWk8UYt2Jh65vZsC0Uf2nrQqEFxnrPFOOFOeFISkrtslHXOZPqAF42o3tZmomdn2DXNLoy+Xod2CtIgSD6EmR1bpwEWjns13eWcSWvsfwcJUnyNdG9wuMlGFc9mZhqd4QLrwfwbccFv6qmEzhHZmv2SKYdv1jeec6CC40AaqHLis+T/pmf7DpD/dzs9bwyoHPN07SWfJJXIUgbasbbbjzDazWrlQsCNAePtnjG0/YzPwvKUWZRGn1G69k5MzgO8SHUdi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaq3TxKCll4LYCz5rrKjWJLsdDfBBQRiZK4oSErJvTk=;
 b=Xh0dJzQoY+21lKd2QTZ4s2/RAcC5QK0ct6VITtqXNMNaC4RqBLAVZautyp5lKf7Jj73pCGbZAysuHP02M9CuMtqfZMOQfVwQfL9jkwIycLQrqRCuAbx9cxFiylrKpBt/uSpnzK7fs/vXJq10rI91yUr+/dld0pykBcvoaZlIKUp+EL7SESiZaKZtEHxGHDooh0x+tPPbxpPP79YXRKYtIBidhsJD1/MOcnKejojom191BLb4sipXiZARwZaFGPXREtMcz9avdunSbPNz/orhrdXwIU3CusAWifSYEmqUMJu1WJVr1EezPTLHZSftq6CubTRKPAwR+RQHxjXNqUNiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB8258.namprd11.prod.outlook.com (2603:10b6:510:1c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 05:54:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 05:54:25 +0000
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
Subject: RE: [PATCH v4 09/23] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Thread-Topic: [PATCH v4 09/23] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Thread-Index: AQHbwI7/9c02e3sMVUuIA4UsW2y+NLPTOjoA
Date: Thu, 15 May 2025 05:54:25 +0000
Message-ID: <BN9PR11MB52762B0EE49C84ACB60F3E848C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <88a0b17337897de8ca170afa1e9be26ff7442437.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <88a0b17337897de8ca170afa1e9be26ff7442437.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB8258:EE_
x-ms-office365-filtering-correlation-id: a26ac772-7fce-4d21-b382-08dd9374f2bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DqyKnItwKTAwCu7Y28GFWhYroeNMrwFcWuWwgHjkkcIDU2RROoAhwVVCzErY?=
 =?us-ascii?Q?o2IkaOQf9Cszivne3ghqjz03cH0Q+4/A1vlnr+uviUmI+0+X0tGt/zgmN9q0?=
 =?us-ascii?Q?bSCsnZzUBG/X0e3C8GFYltfSW8TUIWxH91bdb+3sHEY2+cdHfjjDLYcJM0HX?=
 =?us-ascii?Q?Qq4g/5agxn1C5PHqskGh1ySqVxoQ65PTRZaiz/4zPCvd7UvLecIiOF21YRWp?=
 =?us-ascii?Q?YgjILgnIvg3SvVHWB16+NndblYV7XEmNFbRRmlOCp8qJkpmVxiIfEP8A3Abp?=
 =?us-ascii?Q?cxzU0D9oeqXKyVBkZ84ckyEetTwr0Vp2XBvmOEs0UYx9+S3h+CSWkAUADXEe?=
 =?us-ascii?Q?FX5mYBmbp/dLxxOzn6DVS7MYlbbB91M/4XCXsIGarSi6vOYuKqu9+u1H/qMn?=
 =?us-ascii?Q?KXAOSIesjuwocznuY0fSTh94h7mXpojeSz1do+pRpLcUzFfFHGGjiU33kFZ1?=
 =?us-ascii?Q?UZh6Kw+S8b28bMJdcRo0xvbsm3Mt/IwcPNz15i7HGwVbnUwIuzNkE517pAN1?=
 =?us-ascii?Q?beQpIH+3c58To53RemcS15RhfnkZRz02PbdRMPDZwtUTc9tM42WbAXkMv1nQ?=
 =?us-ascii?Q?95Yk2m2lJKXZKEV6QEV1yMasUFtilR2nOjPyNNZCyZBMVn3AE7QaOz4yVpH1?=
 =?us-ascii?Q?mnxk0F2N9kOS1bflQuVLPvfulyH0kZ1rs6pgZLfo+zQ8IUdwdX2XKRG/zfTh?=
 =?us-ascii?Q?Q8pKtFXIvomvVRZTc/c0zOyW8fTvfHDLRmIrb+cvc9YtZ1T3m34OGo24+S3P?=
 =?us-ascii?Q?supnib8yJInkM3xIGTZa5uZhdCy4UehpgNElrdBmf2O1c+e5xhd8bquY8Soj?=
 =?us-ascii?Q?nibc8n8FjSs2GroR3E9Rj0t6eOjX101BhQwe8a0r9rf4qSDcoaPNjOtgMch6?=
 =?us-ascii?Q?HLTcQVPm/8rWFRKNGJVo+oY8Bx60b4kle5CbceodDcj3LL+f4BGMXRxIxiea?=
 =?us-ascii?Q?8Po8jxhD0vNXt79aUtZBgZ8DTOMvqZrLyQ1EWYo4g+bSQi5fI5p+ISVyXapA?=
 =?us-ascii?Q?WL3w3bvRFjjS74iYClHR5vQNGl39jUWmPSeNGtX//nvDO2fotRfnnhNcUsRL?=
 =?us-ascii?Q?RtWJF+FwlwIUodjIAJfh8QNRzkMeUdxHhzOal48pd8b6ROvxAUJQ0/zP6WG3?=
 =?us-ascii?Q?SwR87GRturhj2tPw4SZ5RZ3pGGzh6iSqoz1xOfHi4NRqDZT9zxYaeT5PD+44?=
 =?us-ascii?Q?+Qd5qyJ98LTj4nX+QPV5pznnFvvqL6p5s2110alEFZhttRcxPFLaXX9aY0qP?=
 =?us-ascii?Q?TpVuSI7g3d09ybHC1/cvREoztfAdbTXDIFxAfZ/FS64lAjPEbDlmuoW4/gkx?=
 =?us-ascii?Q?OX57t9VUTxwrdpNyj8Y8rTOVh3yRawjOmTJZDujjiSPoEdFc/PWtNTdWOmtU?=
 =?us-ascii?Q?/bJv7iNLnif06nnQTmSLFjkfOVjM1J6h7MzwScq5i0HQGrEHhgTJngUY3h7V?=
 =?us-ascii?Q?jvV6jVyDXgmqHM+K/WCQentNMc1JKRyWmrQC2AMwtf4IQcCnXeflDNVtKZ/E?=
 =?us-ascii?Q?5clcrtzy5DnhRrA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8ovF/i245y1ypSRbiZeI1e69stlgTo2oYhJMm5/wfgM0HD+qhJdZ1TY9gTAs?=
 =?us-ascii?Q?/7mibNMlUbYwBwjQWzjr65EmdY+f4WXQw0HnpiJ1P0BpG9ozvJDCQ3zTK6N3?=
 =?us-ascii?Q?EZoLFu3Qf4f5T1Vs7UdVKWVzUsbrkZe/9BHjN80F8ehLZVp9uuYR+q/RnM0X?=
 =?us-ascii?Q?yGxeLapE2aYwmT8Q40md9di+xKTrPNvS+cnH02E+IdXS0+F/QBnnsOQUjzTu?=
 =?us-ascii?Q?k37pKAz1ZMBCZFENVtbV/RiRI9Pm7FW81i64yoDytRz81IQ0/rut3YWE527H?=
 =?us-ascii?Q?eak/vyYxMbxOI0YW/1se8I+ArN3zdFH1KzNUXuJYO9711XUGOcjMFisRRuC9?=
 =?us-ascii?Q?zvuII/KcbjYGNgC7VJXnItcsZHewA+bK60oq6QLe+f/EixhcYMu/iGtWbKxr?=
 =?us-ascii?Q?2tqUOWED8KZijkWGMNwj1tAbbE7Zi7Bv06g5L97Bo5mO7U534KKixsuZsErq?=
 =?us-ascii?Q?TE/V8uPcWGqivFw04EwlG4y9lanEoN/y5tYjy5oaGAPj24Ga+dAQh+unv1KC?=
 =?us-ascii?Q?YYcUb984Y9R64bzrLaH8ltJOLcoWrFNarwOf/WvrXu4eoWqs1/qQheKYDb4Y?=
 =?us-ascii?Q?sGhYF+ehlDMm7QhUhGizbGnd/S+CPB3N84wD36BfpQLoQyF0D6VM6ZAhC1va?=
 =?us-ascii?Q?ilq4FD+r/AvNpnMACUyzfolVeH64X2rPdmxmNk50iQoOAfueNv6VaUr4xTAA?=
 =?us-ascii?Q?ngWtdGhyRtc7B11XE6XHeIpkFVtpE/CGBv+EYZF03VUoKxAU8U9Q9YE/gfjq?=
 =?us-ascii?Q?4T+VmxJ4pPRTz9ob1RcfMfyps///18VWNuqTy5/h2eG+C+uNztKqHFQhZ1Ud?=
 =?us-ascii?Q?zGVxe1/ayS5SMBQ0U4LN9VrfeoSFD1d9wfhh1HAD7VAJWzMbXLwZ49sTDllW?=
 =?us-ascii?Q?S0Yms19O6UAAQRfn6JkmyuQOGSkbLx9SlFsUOPXdY+tRdbZUu0sQRYrBUD3V?=
 =?us-ascii?Q?JJ6mKvAIQusK47MSPLl4jwuD9G+X6uuUZm//JmUXjxlZtvs6acnrTQ5kzbhT?=
 =?us-ascii?Q?Bs4HzR06BtV01tAhr+1KObKbeXOHvjnMoHiRx9Nf0PN9Ku0ZNlarNKxvuwv2?=
 =?us-ascii?Q?88C2+kP+04Ne/Iy7ykPYVEOjvd5cTDCH2pJawq9aFcNOUt+fu9kdDpGpJ2bf?=
 =?us-ascii?Q?S+WUqTWkHkKAmoERVvp/BBvK6tTh/X3+gAi5ZTJltxDXd/D+0tumQoY+PKP9?=
 =?us-ascii?Q?+EJKVo1KSmR/dXemzEEqIs7opXR5CfSKuJvSJjLHt2DE2+Ru/OTQ+aLM1Epi?=
 =?us-ascii?Q?KPX4K+2l51XaizUgb/QRSjiuU9Ni1fNvz9TVK58Hzvh/xr3mdqrYcNx356RA?=
 =?us-ascii?Q?MCaPFLziP6xHZBF72jmNXgguE0fWzKzaoS5NK/kIXHPQWZu3km23uSlgjalP?=
 =?us-ascii?Q?HDPg6lRtzz6qUYbEZlIDZv07NJnL0ZYgqCqndBFSrOdzndONOLYuR0RnfIp9?=
 =?us-ascii?Q?rUK8u10D89O4mc4/DEIn8JgZfXViEHRf9JfP84lvPu1zKn418u0auOE/ph9Q?=
 =?us-ascii?Q?dpQRTNoY1IaSTxwf0oxMszP584d63flu+yPpuO7N3pe3fRLvMzjidfmOhUmQ?=
 =?us-ascii?Q?pyb6okzrnA1AeMQXrHlqSdaEvDqMakd/E4t0aqpR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a26ac772-7fce-4d21-b382-08dd9374f2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 05:54:25.4058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FStZiqknWSyySOSrplH0FZb9uA92qIMXCA+BuQwn1+HwaAkV9Dxd/4jmFRD/AL6aZ0OueD6o0wHvHCgWuv9M6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8258
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:03 AM
>=20
> The new HW QUEUE object will be added for HW to access the guest queue
> for
> HW-accelerated virtualization feature. It needs to ensure the guest memor=
y
> pages are pinned when HW accesses them and they are contiguous in
> physical
> address space.

'pin' is the generic requirement but contiguity is vendor specific. Let's
make it clear.

>=20
> This is very like the existing iommufd_access_pin_pages() that outputs th=
e
> pinned page list for the caller to test its contiguity.
>=20
> Move those code from iommufd_access_pin/unpin_pages() and related
> function
> for a pair of iopt helpers that can be shared with the HW QUEUE allocator=
.
>=20
> Rename check_area_prot() to align with the existing iopt_area helpers, an=
d
> inline it to the header since iommufd_access_rw() still uses it.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

