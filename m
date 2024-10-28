Return-Path: <linux-kselftest+bounces-20770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF569B22C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD151B217B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 02:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8DA15B54C;
	Mon, 28 Oct 2024 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MK8xNQEr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1522140E3C;
	Mon, 28 Oct 2024 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730082950; cv=fail; b=gog9uYozOb5Gbuen58wIaP7p5+CNftL+pecj6ucgLdxrx/48G+jbfsCSghYEszFB9f59L2k5tE+2cMg7yvob/oRXXytuXadaXvXaBut9rRcdL1RLDBfMACKqvbESy9GUG3JGa9WGNs/s+0jN83jyfICYMtg9BHwWQYwndHKKYmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730082950; c=relaxed/simple;
	bh=3URi9oSjsgH6/dROzjValsODTpNNL5/9mD7YZDBZCoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NLyW9MRVPjcVWZOU0e6P7Sv+CvPVx31je2Z9QEQFL719V4lzWNOIV+K74+e+Hk/FQGKH2exmpmnkmNsJRmzQc+t81hW68NM2M4Et6mssm2AMwEeN4GWRGWmNO+qEW2k4JWXwGB9dxhXAN99wTSinwB12mp52r24hGJ0boRo93U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MK8xNQEr; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730082949; x=1761618949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3URi9oSjsgH6/dROzjValsODTpNNL5/9mD7YZDBZCoE=;
  b=MK8xNQErhh7l4owYYoatb3K4kCaN341j4kYi+0wgeHN0OlQC6s72WeQF
   ht5CT6ArsGyXNmhSbyW9YUu7gviOS0Zb9BFDEkK1E/2r8JUUYXvGnPcu2
   TLpYLXbcmtMQHlj5OfyhTzMfQSNCJj1P3I4Scasm8aS8mMYKyt4Ksqplv
   DGi7pBsOTIAVywjmR3LADw1o0welzKrVJMSLBvAFW3Wou026/o3cPIP3g
   DoBhVCT9iz4onKD9vpJxGKiPFn9/z3jmYJLES3pTe19ouxia6CRaBP3l/
   4DlsSMBc4Akk7kzKq5OOQFd9phtVKvJBtVLrQxzqM3QRz1U99Wew8Cu8g
   w==;
X-CSE-ConnectionGUID: xajJIG1/QqqOKSLncz8nvw==
X-CSE-MsgGUID: HDZaE/A3Rgy24ErCppkbCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29129791"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29129791"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:35:48 -0700
X-CSE-ConnectionGUID: fJi29GQtRTqTQzM5AD/22A==
X-CSE-MsgGUID: Qcj5IweoQeKHS0ozAZhEog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86074539"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 19:35:47 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:35:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:35:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:35:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAMq+5wMalho3tN8U9ONlqXojCP2LVynGGEQPixHhiH7abcMIJOUyO2oCutpJBf5UMXKUneyCp/JNT70uUk42wddpUuC+8imh6fLLXIIWVKd/fgkJbqTbknbT1gAUb96d+VY8PtPmlduloiFsxsj0SWbHdYhoCtkdPyUKcc/4kFOXlwcN1QVAtc3ZPltiqWmV4I/oJH1ynO3SvLtxL6yiHdJ6Y6W8ij6K0NXlnx3MQork5JaW/+mHC1mhwYjAczcQFVjAMYmxGtJah1cFdT0N6XNVQCT1gXDBW0U9VAWCG9w6A0QE52YYw3SnAu7WdZDe7M9pb3Jbt9pe6OsvpqY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGyl5p10Brjh6nSouRToYmc5haa/9/8agwBQNu/ZHIs=;
 b=YzYTqSUpa++JU7WvsokxLnvVAxDSWDueWs/VVx5qOy9521Y1uZUcupW1fFrPXB+evbzxGpaij3jYKSMfW56UiUnhtKdiKwxLZSgsje3ntU3dmEB0lIexrMmJixwNGJRJoaOkZXbB1274j6nMhCEZLIflrdAa6C7K5BszSJBlcA1j6xvmeLgkW9IT9MOKkeTp6YOT9JnuzVFoiF56FHxXdj+KNgm9yYsURMoaiKQGSiN3QuteblWFmCoa5Wh1cr8i3N2dZ9TLaYHLvFikNuxJqq4dscnKfkKqiJFbxuvCUyeTL90tdd1UaAJxxASjNrw1TgVTm3cX5dI/D5VQNS8tng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:35:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:35:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
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
Subject: RE: [PATCH v4 00/11] iommufd: Add vIOMMU infrastructure (Part-1)
Thread-Topic: [PATCH v4 00/11] iommufd: Add vIOMMU infrastructure (Part-1)
Thread-Index: AQHbJBg8fdD1Yoa/lEC5WIlmiKckcrKXJuEQgAB5+YCAA9oUYA==
Date: Mon, 28 Oct 2024 02:35:38 +0000
Message-ID: <BN9PR11MB5276B0B63BB778461A7D98BA8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <BN9PR11MB52769BCEED1DC36DBCA75AF98C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241025154239.GJ6956@nvidia.com>
In-Reply-To: <20241025154239.GJ6956@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB4954:EE_
x-ms-office365-filtering-correlation-id: ca5264c6-d824-4a03-fffe-08dcf6f93568
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2r6xoGJi5k64DuvF2+TENm+xJQNV65TjiI6ajEWRKsUwlHmjhhlC0IMZCMor?=
 =?us-ascii?Q?83nZbNPqdZ9n1Y24ZN77rlwl41IJuj0AZW/IwCtTNePozGJrL9Qlyp0EVW9J?=
 =?us-ascii?Q?LtT4HFS80o5IHj65LUE1dds/VBDz2CyB+2amkJPbtYrhM+1BrmUByVJ6Ku7v?=
 =?us-ascii?Q?clvUKyW/qVCw9BsGc2pzncvU5zF8TNPRwpaBqsvzy+xRc9PUNnMXIrAmX5F6?=
 =?us-ascii?Q?Uxv//wp9LB0xSMkCZCKpr2cAhCpkp81hO1blqvRxEyZABz8gbSxwwWbTwefl?=
 =?us-ascii?Q?H0hRjp3IwUz2fZOC8apE0w/8PcarBRWUar2cHq1oIfqTyIBeIWTyFhxpL/B0?=
 =?us-ascii?Q?wdfu/Uz/KvPElpAUbO5pkInlE1u8p6qLonXJ8wDmbF1jmnTym8BBlrknIftv?=
 =?us-ascii?Q?b6qA/+yZfHfQiL8oy2+d/Riz05gzPMHrKCbYNi49ig+LxNCajeKjtMOsovXe?=
 =?us-ascii?Q?c6cVjLMSidiIfP6rSDBh/pSBCiFrCHEvi9SGfDRoXK/ILP4+qH58fLNm8wbx?=
 =?us-ascii?Q?7cmMTTtjeZkvKsm1oqithRi2+s50TX6veMV8Tn7J9kmoeLihKn0QY8oo6F2q?=
 =?us-ascii?Q?5MKw0yczy2TJrT+eGtk9hxKOjkwFYlU07FvIMcfnsslMmH0JzWsqom8TpT3Z?=
 =?us-ascii?Q?3k5aI+6n1gU31WVNdS6GRH0MC16J1vGl7rOxaFpuRYX42p5DleErivB+llSX?=
 =?us-ascii?Q?kidcKNWJ2zOt51eft3Rw5czumZSSnAPBMOCBHueo74URE9l2Pu11hKF6dheV?=
 =?us-ascii?Q?rsgpsiXEwTXhgFQo114Y+0sIa3wiGmajeSho2SbdqaqnwxeYNkDdUasYCgeZ?=
 =?us-ascii?Q?sjUc203syJ1055xEgg4ywTRtrA5mYFNPYQnDn2RBBRIDbC4dWJRxiNXPixk/?=
 =?us-ascii?Q?YUO6eYZtDmTKoEOpO0MchC5GnYjHD87DMBTkst6WI7/MMHUdLjMDbUS6s4IZ?=
 =?us-ascii?Q?YYhjeEbTBriqid3muVnk4MlY9Z1p2O1KjVo+/+gBWSrJURj/O1MBumeRFtI6?=
 =?us-ascii?Q?QpZeoAlduVKMZTzzAzk06+oUtaBkoZGTnJAUSLhv5POtq+Ys6fj5zMYOrhdC?=
 =?us-ascii?Q?I0bUpG/bs7yWUANbwvkLtKHRmoE9Lz9EXxP0wEep25lRE5wbqdO8q6Jwiebx?=
 =?us-ascii?Q?GoeuHZfhSMkMMi+326HE3MGZfpdISLUbbcqc379IbY0s9fX/HW9bpzwUxkz7?=
 =?us-ascii?Q?lcA8+jq1h8ZSxin39yRCuieqieAcK4e1conNg/braTZsn2HU0RB2CsqkS71Q?=
 =?us-ascii?Q?37PU4MddzMI+r/JzHFR6eG4Q0IQJqh7TLEMB6sOiLM73UAEJlE7TF9MgmYlu?=
 =?us-ascii?Q?AJVQQNwKKqKGFDLyLpOXKmWwIJKm/8947+nNrf+Sjc/2WeUU/XOz4m6HF5ia?=
 =?us-ascii?Q?IDqB23k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jzihl83tbYzJcomoHSKCiMQ/J4GpjrfZ3nz7bYfKtXmnK6s/ZSFnOjmNmnEV?=
 =?us-ascii?Q?K4TSAICpLgn4ltoV+utRJJM52aSjdxsR2au3PfOp5tz0eP1IrBrZGPSH/sbE?=
 =?us-ascii?Q?qykkNjzbvU9s8NZfa8hCRgDFd35TF3KmgpGS2BoUaJSDlaWnOoKg7/oY4Uv9?=
 =?us-ascii?Q?POD0wg7oCy/XNxFkyodp2sYeOVNLlGRwAgkV8TQcz0H8Tg29amD18CvxgSSw?=
 =?us-ascii?Q?6po/7Qu3KvZIV2RQtc5m7Z2gaOp79pbtgSDDjGYW6dW5zPCGJC88g1MtQKJ/?=
 =?us-ascii?Q?6/Sutg8YWWwDPVZUT2WU5XYE5rl2aWX22N8KKXeSqRfmcidkjw5s+YCibEyb?=
 =?us-ascii?Q?riORKAu5F+bY+VxJOxvLyELBrVTQW4SQL2nABuVMQ+1RD06a1hlN2K973S88?=
 =?us-ascii?Q?N3G+jiP7u0OjqNRlRzjrpmzq30Ea7fyO4FVtForgEX9MErGpkEXOBdft9SMQ?=
 =?us-ascii?Q?RYGuTuphD9yhoz32nUmQCQEosd736s47dQ5xkrF3EZImR+zjWNvh5zsqoKEF?=
 =?us-ascii?Q?dMuXdh4Ccqnclq6wjAuVy1WSAhcgwPC2W/D/qjLTa0Clqnw6iUVLi0Q/IRjw?=
 =?us-ascii?Q?jimmV/fEt5iPjKAHONyEIpfsZFnCkg5yRzgN9q6cT7u3u8eAIzbOGjIDxBN7?=
 =?us-ascii?Q?FjP7E4j3CBV6DWZv7CgfTz1jP/CrlvbO7XVhQvH5I0eostuJ/MbLAXEPhBdm?=
 =?us-ascii?Q?nxzFiKYZg9LyuVJzpCw4ULOCO5IGD4BhT+Q1+qVVe3WULlQfGr70+vUB11lL?=
 =?us-ascii?Q?zhMa2sBOxD2CxG2X6G9zhm0S5p1EWrP1U1ULQGVYTIGQLzTZri6WFQfB6k+P?=
 =?us-ascii?Q?TdrmqVUe6riMcEkvpk8/18l1FhgzrvXRa1dGD+lMLrvUDyK1NaDdnrgwp1gy?=
 =?us-ascii?Q?f2RfZiKKPkRlHqzFQBEqCtzBG48/V/AcVQDsZ1k4Y6xhlO9N6U63ezLYag+8?=
 =?us-ascii?Q?FTS2CKc4s4ioEOrJawOh3H0jV38ssv6unG78tmSOEr0nUUYoimfkteakPy1I?=
 =?us-ascii?Q?txBNrxcT4fVb7rfDqNC2PXNoGqpP2KnTKDGlpGyHpYAob7Rvm8IAucv/fVSk?=
 =?us-ascii?Q?zVJmOzcFvcn67NsJIwdaG7kCjRTSxAez9FvEUdZA2D/XAsuGk8ZedpQBY6qA?=
 =?us-ascii?Q?+3bGnnRtHjQTc9jhbZukE5s7vTBvm7OOhRXVmi67jRXAL/PNbwvxdNqV0yqQ?=
 =?us-ascii?Q?nhABiTC/pRVqHbHk7Yl70K0+wReI+otFbp+0gNMnQI1oJuymh48KzoD452LJ?=
 =?us-ascii?Q?OSQ4KJaOu3RCR+6GEibVO4yZfAswlXvsFZXjzYBnHkU0I+JRs/vaYAbB75yP?=
 =?us-ascii?Q?qp8mEvgwWER8BWFJbBonD9+jymJU/4VRBbri4fNf2+80CSuTzxt5ppM1cgeY?=
 =?us-ascii?Q?aUZgWi2HUkEWDFk53Qni6mDAiFC9Y0zO0Xtljzu9HROnY6DczrRj5IML5Z+c?=
 =?us-ascii?Q?58gOs9e+foRQk8qTC+ORC5a/dgPWybnE5unOZs1y84Ad737BCoEoQMzrLtsv?=
 =?us-ascii?Q?T0/wj3ePbkY8JZjwAVga+WasR+TVlcrqBUiGB9VCaT0xfiRMknySMoMLSEMk?=
 =?us-ascii?Q?Ub9VB5v664/+JkuWB29uKy/+yV6a3PI3JayDH82U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5264c6-d824-4a03-fffe-08dcf6f93568
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:35:38.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvR9HDe46VlTgLRTHiaqCSRkhNrWLX0X1Joju4WqzhRnGuWz66lMzFoHJquJJrc+3AXadCffCUKIGGphCDWI+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, October 25, 2024 11:43 PM
>=20
> On Fri, Oct 25, 2024 at 08:34:05AM +0000, Tian, Kevin wrote:
> > > The vIOMMU object should be seen as a slice of a physical IOMMU
> instance
> > > that is passed to or shared with a VM. That can be some HW/SW
> resources:
> > >  - Security namespace for guest owned ID, e.g. guest-controlled cache
> tags
> > >  - Access to a sharable nesting parent pagetable across physical IOMM=
Us
> > >  - Virtualization of various platforms IDs, e.g. RIDs and others
> > >  - Delivery of paravirtualized invalidation
> > >  - Direct assigned invalidation queues
> > >  - Direct assigned interrupts
> > >  - Non-affiliated event reporting
> >
> > sorry no idea about 'non-affiliated event'. Can you elaborate?
>=20
> This would be an even that is not a connected to a device
>=20
> For instance a CMDQ experienced a problem.
>=20


Okay, then 'non-device-affiliated' is probably clearer.

