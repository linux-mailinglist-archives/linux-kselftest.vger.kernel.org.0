Return-Path: <linux-kselftest+bounces-33919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434C9AC63DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 10:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6AA4E1E3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDCE26A096;
	Wed, 28 May 2025 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JraPDs+X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E5269B07;
	Wed, 28 May 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419874; cv=fail; b=dUT7mfs539rXp0SKx0OLNNECsuPBqpUEvQuuoEbaY/Ehdc7yVHU4+bOy6PzMQq4rsw7R86T3+yT8NwkIEGFWtm09ZW6zzJ+cXOnH36G1othKiT6i8R/vXYpRNAXWrG/GMdaBvOPKqu7dWm34oIRpMgQ+y3879NSsRqjFFWhXqWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419874; c=relaxed/simple;
	bh=oN0oXQgfNwXQngHEVdGFsMKygBps4pJXnMTe4ImxL9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZyHdls9HB7SRPoFKpBa/QcDmq/qbd/qVyNsfkKYxHCF+Q6B+2mUf7i3StnwQVVxj4aT/hC35TDLJumu1y7OI/rTWIvqi1zhN0zg/5tpbn6cZ+pEt7jkxwa1UXTqn1gQ0LiZ1qK1stBIUbDMA+mR4OATe2phyLA1VAazyNnvKBKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JraPDs+X; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748419872; x=1779955872;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oN0oXQgfNwXQngHEVdGFsMKygBps4pJXnMTe4ImxL9E=;
  b=JraPDs+XZSS+7GfuxWQcO0iRaQQM44vrQ3izQSGApIN1Cn0amSu1+WJF
   29YZ9x7/tVJdA4wwHVEQlGAzww3fVlAEF4yut1LDNXSP3u5kvjdSbP/+v
   lCUd3usCMmWQjQKnQcLpVklIaIcRMUH+d0eMWLnfMuW1KkaDq2DX52/U6
   TWYrE2cvgAFh9gn5rO2wU/vCVJ1x8logahiuRZA31CHwD8N+9H7CyBUgP
   /Y/0Zk0f7IJ0RZYJQ0ZlfNOnn6DN50pLKiR+ETBHbSpaGiNVHg4AL+goj
   Z/m3pGNz6vD8DESV5d5pzgMzrYOlRR9wIrIiusg22TbDa2IalibZmN1MR
   Q==;
X-CSE-ConnectionGUID: 3WS48B/HT4iODn1qgNEngQ==
X-CSE-MsgGUID: ZyU+OwjJT5meqiKvJvQcCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="49548839"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="49548839"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 01:11:11 -0700
X-CSE-ConnectionGUID: Xg9UQbI0Rgqob9awtU2mPw==
X-CSE-MsgGUID: CT9kbWDQT8mWBhFhUNVxQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="148297588"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 01:11:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 01:11:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 01:11:10 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.46)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 01:11:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoCwKq4bvfJCqkHRgOdUpaDE4Lf4hPwIVfmoEQxnGXBgtMwkqve29Gz18Kw8wY/b5do7WFK5l64sgxg/rz/r8JDwITo7YJeP1E5e/8N7wh6n+kvhuTjCO96/2GcSO46Lmswblf4wLHk7jBxsbFAi2LpbBPeKTiIwivKFnjxAFrEdpDs05F+t9VYJMOmqpjUVMKaX3Xun92X/ZO61eaNgtxBp4L0HP1Yj2XQawv62L2IWnTrmF+Djuzi4v8Usr9kZw66vvIv4bTRaeE3q3MZcyckY+6+yV/c0tg7HVn07IbWXyaq8Uw/uwsRgk7Ap4e6zl4CAKXwItoNYxLeWzkDA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP3g8TGu6WUKobopTENONswIBOcNRkEtJqJTkEmInrg=;
 b=AHlE+XlSlzW1hXgkRb62RVdAV5EMcNpqGdovS9eyugl5FkHiiPinsEIBN6t5oPALSW5axQtz9vJOcF4Jb/EzPWYY8hd47KwRcsoXzTzgqqQ1wS1ZAiqbIbCPoQ66zlw/+WbD0+oPvSun7DfpjkQga9hi8XbeWYxN0zG9GjwK8gaaM52Og4mQ2U7JzXCMeMJcZXJDiDKlhznn11aYf2o8tNzWS7vbi80pis8HaeBHCWaYdXIlfy6BNxu1jFQ7tR4vnNOXwnw9F8RfhO6N1inFybmlBPRLPyp4kF0cDXJLujubMye8w4oArTvAQE6vOhXNe6zjU5uVSo/eXxKx7mkCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 08:11:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 08:11:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v5 03/29] iommu: Apply the new iommufd_object_alloc_ucmd
 helper
Thread-Topic: [PATCH v5 03/29] iommu: Apply the new iommufd_object_alloc_ucmd
 helper
Thread-Index: AQHbx6QUab9gqVJWEE29OKdWGASVW7Pf3lGwgADnYICABvjTsA==
Date: Wed, 28 May 2025 08:11:06 +0000
Message-ID: <BN9PR11MB5276FD88B84112B9807DA0238C67A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <c01f145f9fd9a803a3154c3e7221dd76b4f8adfd.1747537752.git.nicolinc@nvidia.com>
 <BN9PR11MB527605018977CA291C0D8E018C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aDDp74yHGkhxHHJb@Asurada-Nvidia>
In-Reply-To: <aDDp74yHGkhxHHJb@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8498:EE_
x-ms-office365-filtering-correlation-id: 30640c81-45da-42a9-0c53-08dd9dbf3276
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jx+2Ez7X7VDnOfpqhFPN51/1eQwBGanxnfxcC/dML+2l59v0wiVCLYOPDi+K?=
 =?us-ascii?Q?ttlVzrcV8qyMxOgayIXHUDxLD9gM5Zq/ZcXHWkPE5jl1Y0qI+wmlSMs+QNSK?=
 =?us-ascii?Q?4JbYXvuEfzhdkO9i0UVaI3LhTGnVm9F8dd4CElO8pnNizgHgiDAqn/yc6lAL?=
 =?us-ascii?Q?/x5ppnMzLTaGaoJVeJIOAEcWVnLufK9s1wkTCB42rTyy+JQVDR2jHFCCRn5F?=
 =?us-ascii?Q?WQtf3B5Rfgp8BR03+aRab/5ej/mVxSxfPakzoBP8lgV1uCOtyTjLsmADweXA?=
 =?us-ascii?Q?GfHLPeauJDLTxbQQ01+lYkXsiN8fU6cN+TTuuMO9QyNkYT/6Ze86ZPGu0CJ9?=
 =?us-ascii?Q?GDOSeLP0hPjN4ADbeUrsuugEtFEsGDNCPMu4AnKpgfVqewlebLUFVdZ6Wq3A?=
 =?us-ascii?Q?lcOTURwy1VsRfNH2hZO3nE1iMCpTpysF8so5MwKz5zONMnW/TkvVkyvtj/ak?=
 =?us-ascii?Q?+c5a+JKwJwr5J6ysU6ANpFcwZpe1wPTyqyx0uwdyAJKfqDrJE0Gy8xBxC4UA?=
 =?us-ascii?Q?qVEWQSB+qp2e3t/MVs1gn+dMGkZvxikoh9/e5cBhbTfLITiHupmd7j+AAfVk?=
 =?us-ascii?Q?xqoXzMBiODnC5CyKPoN5RB0benqlyqpWAScAkuTRyE8VKDSkyzXH7wyeXqr2?=
 =?us-ascii?Q?5Gdg69v8XK6SdBCl0ZpONLsPG0Dxk4Vn3TU/aS9YpP+otMcLppw1qRc6tjqk?=
 =?us-ascii?Q?CZc2vdx/z/dmHvG7fZUU77QblbG3BNVSu5FdnDq1+iaNm94j5PhC7ZmB+odM?=
 =?us-ascii?Q?+5jqB4+qAABNv18c5+WwV+E9MkEKLqthXfDj4iFgq64kTF15F6xbetgkMojy?=
 =?us-ascii?Q?9cuZ6EWQmcZKBlOtOm+zrAqEiopplWyGVWKn0KxRlV7/D5/JZqDKUISUb+wY?=
 =?us-ascii?Q?xhUCY6/tymf3FK85DqQ7D6V4/hY7SXRoSZu7q0eGEvAFSzXWWCpoAFHq6Go5?=
 =?us-ascii?Q?0ZMlv6QaeHM1IbSX+SH/NLwBFfkgeOlNjjfmXmcgRXwSr2qfgqf4r9Uj6lcb?=
 =?us-ascii?Q?u65mayDe5OFDQP+a4g0XYirPd1VG4TuIOY3mS/b77tnnjSZc58E4VCqWYSek?=
 =?us-ascii?Q?ukVGaq3v15uieS+ILylF+CbEQrafNoT1XY2biBwwKucunep5bIlgCLqO2m4g?=
 =?us-ascii?Q?SLVjCQIjO4eGW2aBMg5+AWxIzDFLarRlDWvVUG02oYOEJde6J0ZKYMiZTriP?=
 =?us-ascii?Q?T0lFps7WXMg+zi8dQwBw3sBQIifrZc0OKEfgdIILNJGvNAiacw+CDmOcmv9x?=
 =?us-ascii?Q?+kea9EIrO8QQOvwU9BRuZhuXiFw9V5xQzk+1dwmyuzhFvNMQei6t1nfMB3cm?=
 =?us-ascii?Q?YxjYbW+o28kIX5idcgii28Knfud7h+v6qwVgZtnTLUpz8yoO1HhbkQjNLX2G?=
 =?us-ascii?Q?IkQI7hHrgno86LOL6TC0K9fxmXzuD1sVblMHd2Y62WCPlGIMItct+IbPZoQZ?=
 =?us-ascii?Q?ZIudp+6p1SYjwePFnTXFxeJU56DZk8yZ8K9tIE5Qlb+wylJPqMWV8g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ElHhm7TgHREYKmPswHqTiu1rgjdfBQsowGQFI7I4ECOw1u6Fyrn60ikdRk+o?=
 =?us-ascii?Q?kUnpFtYjNpnUKAeEZaMVXb8Nwcxr3NZ0J3iztRT9Q6eGnO4iqx1WOBhyimav?=
 =?us-ascii?Q?ZDADZ2OU8nwsqELjKMatTafCObBbVrMg+Ujk8pP3vavKkRE3BCQq07rLi70u?=
 =?us-ascii?Q?KE+MYYDq3f3/YMAxbNVbiSVXlW0NNoFWMf6UDn+L1AoI/tEG+Wif4hIxx6rD?=
 =?us-ascii?Q?ApZc9R19VHW/NpKnqAGs1L/3fmg8NBZIZJxXwW0KwCrZfwqtFdH3sJeODh4I?=
 =?us-ascii?Q?aougpG6A/gJTOkeTt6nNsBGqA69RkREeKzQDTtSQZ4zHN5J1KwzJcxj11VoH?=
 =?us-ascii?Q?cXe9U84ZTcFKgYDw+56b00PpvWnxU02812baK/6on799b3hC6lsn2pL0cfv6?=
 =?us-ascii?Q?OK5CqAHKOIpdZNZIVXSriP2KwTEEOA8YXRQQlKO+xXfjq/6GarYhXH49pIr8?=
 =?us-ascii?Q?2DaldAdjOGSIMyg8vaFM4Iu38dVoLId3jY44kjq0VJufJjm4Oxt3U0Ob9br3?=
 =?us-ascii?Q?2dhMka3EbHvJ9yhct6J734Ytq1krSkMP78JmzKODKR4+6tFehIFAzB8YQOFr?=
 =?us-ascii?Q?1zUko1wmo0CGbvVYUTwY0VfjOsWyJcT5Y/ETI4LYPyBSCGUPpP5oanwibXGb?=
 =?us-ascii?Q?0mMlMdkFZFFcweCQCF2lOv+Y+zjC72USkno3hkcNgdwwcgnaPGH25fO2Ru+g?=
 =?us-ascii?Q?7n4LQzjHWtwZf5UqPSDetujhahBnJpmzVIGnJ6j754WcydQjOfCZZcb8f+Gb?=
 =?us-ascii?Q?gJ8z/z1onOLCbuzL5+jsO7aJR56fspj72LaIS0yc4zBdJ1JA/VpiCrxCbvy+?=
 =?us-ascii?Q?lqcaV1g51miV+nCjG8fvknTmKQd2L4PWXbhunB80zRZ1J7i6BKxeb1IVHkAJ?=
 =?us-ascii?Q?Wf/JYomQL/hH3Gv9ZgMAmtagD2erdX6HZA6Dd8g9Iz6sheUiUKGWWaOWA6e+?=
 =?us-ascii?Q?Fq1MPKD2qaAtYHdMU1hSoWtZGAJiNNm5AUhD3s8uwrQ6Hnujr7xVp/YX6foh?=
 =?us-ascii?Q?X8Uqpyudrr8OfDqjZm76jF+MaefzQYGSp54sLZAt2tmZzCa3FQM5oNT1w0i9?=
 =?us-ascii?Q?TAwkysB7wvQUm/kUAheMSnhFwf577NYbv6YqrULTbTtFDAaHlzdFdUp89tBv?=
 =?us-ascii?Q?3VPQ7d/ZpRkoXrbC7eM4KmvSRZOiZYqtVvdmXh6Q8V4j+xyPzyodupQdQL2m?=
 =?us-ascii?Q?ePoj+v5oX9+ezBMYGta0mCxILrGWqTHRzhEh2SZk9OG/Q7i1spXI0fRwuRq9?=
 =?us-ascii?Q?cQ0Nc6xiaflCW5jucPFGCtwWVN7cedSmUePbfhXBzgsnZMoIsECX86afW2/z?=
 =?us-ascii?Q?dAtJ06qBr4S9U/PyoHhAwoiqZNVh4Lxxo0NIoBrvZsmrhGljMjE7qOpIILUH?=
 =?us-ascii?Q?IAIF8JsXHtkXmtW8SNRz8nlx1s4vK6KsvvnXl4ZNvZ2oSPWH5mtQzG7M5Jnq?=
 =?us-ascii?Q?NVyq2QNyMm1shZNofDqujqnO5KEcd+h5b+jE9nv2g03HUVDXmXKw98WmF7Un?=
 =?us-ascii?Q?RunJNO3tUZT6vUdmjYkPTzEFTAqly2VQsOLY3ihMmrHZmE0f77Kn0IdMra7+?=
 =?us-ascii?Q?El7QLFzVqw1KDeGNaesfV89DwDKBNgc9CoUEfFpo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30640c81-45da-42a9-0c53-08dd9dbf3276
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 08:11:06.7188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQk+AbK/5y19tevUc4qOhX32T1OghY+KB/AdUiaik9yGizge0xQY+ksfLNm4ZVFJ6ncU8cmnjYtYwrfNjiJ1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8498
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, May 24, 2025 5:35 AM
>=20
> On Fri, May 23, 2025 at 07:49:40AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Sunday, May 18, 2025 11:21 AM
> > >
> > > Now the new ucmd-based object allocator eases the finalize/abort
> routine,
> > > apply this to all existing allocators that aren't protected by any lo=
ck.
> > >
> > > Upgrade the for-driver vIOMMU alloctor too, and pass down to all
> existing
> > > viommu_alloc op accordingly.
> > >
> > > Note that __iommufd_object_alloc_ucmd() builds in some static tests t=
hat
> > > cover both static_asserts in the iommufd_viommu_alloc(). Thus drop
> them.
> >
> > I may overlook something, but at a quick glance the following check
> > Is not covered?
> >
> > -		static_assert(__same_type(struct iommufd_viommu,
> \
> > -					  ((drv_struct *)NULL)->member));
> \
>=20
> The container_of() inside __iommufd_object_alloc_ucmd() covers that:
>=20
> #define container_of(ptr, type, member) ({				\
> 	void *__mptr =3D (void *)(ptr);					\
> 	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
> <<=3D=3D here
> 		      __same_type(*(ptr), void),			\
> 		      "pointer type mismatch in container_of()");	\
> 	((type *)(__mptr - offsetof(type, member))); })

Yeah it's there.

