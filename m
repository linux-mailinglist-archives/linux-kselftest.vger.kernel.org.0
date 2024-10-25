Return-Path: <linux-kselftest+bounces-20621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2069AFD1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 10:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141E51F213D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 08:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141881D365C;
	Fri, 25 Oct 2024 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnZcoCwW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04F1D2B3B;
	Fri, 25 Oct 2024 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846178; cv=fail; b=Al5R3RPRPB22z0kfGI9B/VuZu44SNE3D9XgNuP9A1vCP0CfFVjRo+N4GkxwHFCsyp2ZBxKfKZN1B+2BkwGxkODZKejowtTCibc3FJ2s10/tJRAxZlbTi0WqkTvXfVPQKur7fcwC+NgM2Jw2kgkV7JVhwCgllCoWSBaHcha0HuUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846178; c=relaxed/simple;
	bh=pD/CTdIc6c/qTnZO/nO8JMrZvc6gDkoarf70/hQRZIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ste8ZFvKq42dD4VbnusQ/NQ2sK+w3SUxV0DZgOuPyZY30STVh8FHfe4EvWo07cJ1hsNjuIYyIOl2470TGcANTEwEE00DB+45+UMtCYjWC9CPU/tkLlhElb4if5lStEsoFACDWRIJj+Tqu8DjbyWHspfffE66yKVU98t4hUTIV+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnZcoCwW; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729846176; x=1761382176;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pD/CTdIc6c/qTnZO/nO8JMrZvc6gDkoarf70/hQRZIA=;
  b=EnZcoCwWQMZ7ZL9cBxIL8I6l+KAu9XsxLTGSWiJj+OGCCWc9FhYs5mxx
   f550byozpV1J1CIh8XqzmQknmi8HVUrCX77s3/sNh4SIK3ClYyfV0RXgr
   FnoV4Le7YH0y6RYvW9pCsUQXCeI66dyiuScvar6zz057b2Z79ZWUFvgjZ
   O1yvrEHJ7NvKtlO7eePc3XVzo4lumHPo5IWbunhAvcY85dH6bsW7U4nNM
   DAJFAzUkPW+/zwpTzyN1rwW/vbZmz2MoM0FROL+x5FSyRE8hVIF74zgzO
   XTNPyoKLZeHi2kfHcXOikpSr6C9ulHB/oYb1/O3Uk8FkAKlTMPXIwddzJ
   w==;
X-CSE-ConnectionGUID: xIPLVTC4Toat1AGB9BTZ2g==
X-CSE-MsgGUID: pfVJpdWUStypWmsiI6VfWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52062524"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52062524"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:49:36 -0700
X-CSE-ConnectionGUID: WH6OFmU6TJGmN3HJE9szxw==
X-CSE-MsgGUID: qNVUA4DrQ7iduAmRz7Ju9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85437132"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:49:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:49:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:49:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:49:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyWTYTI0YKuNXpEQ2K3D3D77enyH/GJh7iJ2MkwCeL5lG1vp2HG7OQ7MieqzZh+Ke8F/2t1/3XNVeYk6nstTh/ipX9Qty9R2uCNOapuxd95sdOS4LSx3sMEhkonUYuHIrsZcj5Q29tQ/50i39PqNiXsh/omk8w/Bm8S794+IXH5B2QtaHcZaKyvYDdJAqDqEm1/VARkz+WlQkk1kWhrWpxcxmLTc5LJYpM3Vabhw9DQZm6QyPp0YttBIjPfcU9g1Gm9T4IoOIoNNoz2BQTCjpR/EAYUEKC+9XD1hVTbB1wS6mbXEaMVYak3dzm/HoUnT+mNHzxcCgnm5AGXGlcY/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pD/CTdIc6c/qTnZO/nO8JMrZvc6gDkoarf70/hQRZIA=;
 b=DT1We9tJNy0Okq9D5fIxlCtVUqt9dMg4++Qy6V37ti5IbPcP0NOJ1JYShziJcHHWG6UsBSZl5QBNrYW2aMdcXiaaaCPoyXo1p7V1veofb69Z8aKxl2grb7JZKWwe8zJifzaxdN5UVMC/iOhmLEW2fomBxYu/v3fCkgTvQlqKAsi9gE6F+8QBjth7rfsBvBR52obZX+FBMeh8ryfqf8g/TgsEIs64xDCZfmM32swF2KhKNxjOKq6pf1OVZeuLz87tF2LQDsmsO2X6DVKvsP6nyNrBSMsV07kYzfnrnwcx33V/kqwV1U4GCkW+GFHK77Y3xWJFkFmIFbLJmXZ1PPZxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5210.namprd11.prod.outlook.com (2603:10b6:806:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Fri, 25 Oct
 2024 08:49:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:49:32 +0000
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
Subject: RE: [PATCH v4 03/11] iommufd: Add iommufd_verify_unfinalized_object
Thread-Topic: [PATCH v4 03/11] iommufd: Add iommufd_verify_unfinalized_object
Thread-Index: AQHbJBg1XFlHnRX7K0mwniaSEJ02s7KXLVUw
Date: Fri, 25 Oct 2024 08:49:32 +0000
Message-ID: <BN9PR11MB52764BAD82997DB1B8954D508C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <b48254df9ee530bedaf436e5aff279d9a882a7ca.1729553811.git.nicolinc@nvidia.com>
In-Reply-To: <b48254df9ee530bedaf436e5aff279d9a882a7ca.1729553811.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5210:EE_
x-ms-office365-filtering-correlation-id: b0a7ec02-b11d-4a60-a4fb-08dcf4d1f1c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kzm4oguwjdTGOksvQZtQfMyCB6bvNS/AOAEF4WaIa5KZg5bC3MLElUKyDqHj?=
 =?us-ascii?Q?Hz6mdMjy4JdpQFz9HObZ72R/sCnMcZ45+b6WG4UOVNSylPCEVUuiAzbJ9Ei6?=
 =?us-ascii?Q?zz53CU+aTs2li1GPL+OmB9BOQNo9Wr8jwkoFybP7z+Z1YwqelPHEpemYPhA/?=
 =?us-ascii?Q?dgoIJTGqea54zc3H4IIAVSEG5Y+pYEi1JMP8Vq2/CYZCFFPfmGK9yYBTbBMk?=
 =?us-ascii?Q?9/SD9GDYGuR+5VkufAfJouUeaJcpRyoGVTwJ32EksOfLCcwn5+ke7bVVZkj7?=
 =?us-ascii?Q?9S1W9TkZzTlDblLQ2r5PEhfr81L9XdJwVxErHw7v81DTCHX22nx3xfCdyNwn?=
 =?us-ascii?Q?smec2hbvpHJqDv8t9Y92SXW3qbCQGOix4VmzDttvp3bW6OOLrho+mqd6GHQE?=
 =?us-ascii?Q?iIV0jP26acuc4hkLTBFoOhyShywCGlr50YjAvZFQpk48eowT+f4VA3Wz00K2?=
 =?us-ascii?Q?fr4Q8fDmx67ySP9jT9rL7/v1BxbVBW6TYfORvqM5+imew/6uwK9rSXg7sha2?=
 =?us-ascii?Q?9LZWbwHyEYmJi7p00PVPo03Eqp3biTK7EXHE69ImOeEeqjoY4xHK6hSHA/vH?=
 =?us-ascii?Q?FCPIGs8rnWzaK8bUKKADymPn13k+bgIwLPj3ABqddHoOq7ODGtbKcowP7tqe?=
 =?us-ascii?Q?IveOFnX/AtiFyDL3e+MB/7iYucwg0LD0P6oDmkR/lvjfu7iqwKbZF1zo2gWS?=
 =?us-ascii?Q?ykxfGbxW9jB5hsMJ+wTW/hVOqfzBK+XwLRVV4y/ddE8qF4IjqaVtsiCK9H3K?=
 =?us-ascii?Q?HUCD94cpDoGFhET/oOK8JGeg9peRBLGUbBNDXKn9QuOzejSq94CI6soBap/m?=
 =?us-ascii?Q?3K4d5pkfaHZgkrYsIbmRv4NEFexTnG8qx36gGgeJGchvvEuqItEFq6uHQQMb?=
 =?us-ascii?Q?0JP5lqRVSzevHkibrsoyShg20DOuE8Y10ODklhrIMD3uO8eQRrxmd+Kr/Y7s?=
 =?us-ascii?Q?I9BSQY9+bYPFxnScOseVyFaQCZONrfqAh9M8yFJ9IhUE/y97EbGdNn49u3Wx?=
 =?us-ascii?Q?zZB2Lw/fNeu06gznqKTbNdq/eFCx08/JOh4/BR55dB35do4HiWXDIY4R0QSV?=
 =?us-ascii?Q?QypOPfnO5ZMz1sf7bnyWgHp0WtO7lPa0wTSUNKTM4h7FFCdZSN1rRci7ZdAS?=
 =?us-ascii?Q?6JFJqJyHBeh9I1a+dMZIfXHZtOkT1IY4+V3CcINPVtwWs2OeSyEgDL4tljqn?=
 =?us-ascii?Q?8fYr6LzUkexCmmMbhkK1qjRE7C4i5dRZxbp72Dvtg5lus8Aueav8A08C2fI8?=
 =?us-ascii?Q?QSwUoOwGncXofDLpsQZmlfdNl6pofYP0WSYL4e/tJ870BDoQvqozS0IvGJ5Q?=
 =?us-ascii?Q?cgknMYtfyEuJMsvYn9C50xu2Gro9xux7vYitx/jcexhWxXd+vM+cKHmrDmyS?=
 =?us-ascii?Q?4uJVNdc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pjHWdzm4yOFP4c7kPgwdQc9myr9yWQ6GsVcIcEGlXIVBeUx9Vy7mqpeTDVeH?=
 =?us-ascii?Q?kfyZgWW2N4yophgOP7ajjrGlbGfO8a2xcNsh3P8gctzmJtQq/v5ZHi7hQpiZ?=
 =?us-ascii?Q?ag9DwEfOQgqqZr7W5uJ6Dwhc3pyswADNjcYuPzJ0gVyrsT98gYSa8rTj9Xc5?=
 =?us-ascii?Q?udfmLxOrCsW+Gf1k/ICqhXovQYM6dXMYGxmPfNWX+QYyFGwKcp/dpBuIMCX0?=
 =?us-ascii?Q?9OGDKG8sesOQ5kV91OmHwOWSNHFg8zYQR0MJTf7Ev9+lzVzUIV7XrWPXqNl9?=
 =?us-ascii?Q?uyWNnzVzI/S/yckxoTtkbWqtr5bB8BVaWKIJO70s+Oholg9Y66ZSfeo1ZNsS?=
 =?us-ascii?Q?LLfRM1mq1/P3+JURIlBJ9EXrYa2UhvCNd8YokW99d8q0/mkx1umHIlBQGbfv?=
 =?us-ascii?Q?x0vkCYuZeOYbeY4B4VpMpO471DF4BgNO8oNmKsz0vNqVl9LCor05Uzlhu/In?=
 =?us-ascii?Q?0uU3oYgT64A8yRz+2YbwaqCH7knSywPPQ22yDRKkrVIBTPJ5gJGQxDtq85rZ?=
 =?us-ascii?Q?1Y6hUgcor7C/EcE3LVibLhf4vSz6lEplMuFPLg/oMWvQds2XCvguGhCRRcep?=
 =?us-ascii?Q?UjsKdRaO6qgXY2JwtFNkFZSa+UJvoUMHWSvxBYq1sb//8LMrKGFpP/LHrYel?=
 =?us-ascii?Q?hNcP31bsWvRF++lSsI35VLRz3v7KtBtB2oVAIWHJbQMTD96Fdt6JhUyFGVdp?=
 =?us-ascii?Q?otBohfsbKn6dgDPoiYzUjTL6jflLRHKF66UWYusdYk0MrUJXEapITbvylexB?=
 =?us-ascii?Q?IOiX6IkpzxPPIeUZMostp6RbsQkPTrwLX20MgV/8QXxCmND2qy8zBK+XFq/O?=
 =?us-ascii?Q?3eFjkJ7ENo2RDlPJKs+cbtnCw/Yv21foYE6vYsGaVc7/rhAqsyDk/TumEtmO?=
 =?us-ascii?Q?PnnuNZPjzI78PGPo4v7fiLCRuPeWIObBhvalBw0mW0fE+wgv+TQjLrRSTVf5?=
 =?us-ascii?Q?HubofMkIU6BKxxJZE2sJSa8HQ8MKmHxmcDAiFeZhd2ghMuPr4pm9q7h36BNw?=
 =?us-ascii?Q?laFnY4GUxRpZ0OO+oGo8Yu7yJbyhrT1Ac7dM6pozRwR8eGFu3nA73bf+IRm0?=
 =?us-ascii?Q?PITgYN7XpzeghtYB5Tl8VOzdZKWwVN4tiVTICSWJThfKuKJ4tasi623D8kux?=
 =?us-ascii?Q?MMm8+gUTnuOYbBOLFip20whjD94BX9YMnvby1MXwefsj/EAQm9Tt03pEVAXH?=
 =?us-ascii?Q?e86CTz06f3aEOYnbo/lrLKmVjPTVKtO0/KCLCmr9Pe/Mozi5kCvTe069mgl5?=
 =?us-ascii?Q?8hpB/pBgDm1aFPP3DRB4Dp0uBVWw6q5m91vPE6HRsdPLhyhMv3J/sqluW0Ag?=
 =?us-ascii?Q?LLiUeCLB2Lv5JwLVL8g/eQL7xWLt6kV02R/kWZF6jEoZkX649VvYr85li8Pu?=
 =?us-ascii?Q?X4oM7W7cHkRZjcjNtBLKDKBRzR31KW52t4WLcd5bRpLPrZeFxl+m3TaJnGoe?=
 =?us-ascii?Q?vaYuP8xxp21tTwHtsBWJKnqo43kY6cv6cz2vtL+ArLs3foWXyGppjyJl/HfT?=
 =?us-ascii?Q?ClEtTnn6nhM/IgvDfxT74+fYHzMVpOCkNxE390CScMQ0ZFU5IDwwPKFlf0Fv?=
 =?us-ascii?Q?ut5czx2SG70LTJWzDxDbFUoLB+hEezMmTrPLxLKF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a7ec02-b11d-4a60-a4fb-08dcf4d1f1c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:49:32.0514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyQo7IIpNb5CybBuiVrDzHuf6RTBt41zENwi7zu2InUCY8iqw1qv9uAIGZd/tUoLP4h3Uk769XpM2Ktr2/9Ujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5210
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, October 22, 2024 8:19 AM
>=20
> To support driver-allocated vIOMMU objects, it's suggested to call the
> allocator helper in IOMMU dirvers. However, there is no guarantee that
> drivers will all use it and allocate objects properly.
>=20
> Add a helper for iommufd core to verify if an unfinalized object is at
> least reserved in the ictx.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

