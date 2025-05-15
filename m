Return-Path: <linux-kselftest+bounces-33032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBCFAB7D75
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F4E166CAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4A295DBB;
	Thu, 15 May 2025 05:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqEwgolP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C608C10E5;
	Thu, 15 May 2025 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288741; cv=fail; b=toA1JSrneTAJd3Og0CQ4Chxij2XDFUitXiKBuHBUvpdOptDKJW1Q1yi14LBVgZ8n1F6g++uM8EVHIss1UEFAB6IadJSXJ3hx7o1jyKtWSArZQ5OjKKi0gmh0TAUnMM4xtAwOSTHQP0fRsuNyTuEgbqMqW+ioiWR783phzz8+6a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288741; c=relaxed/simple;
	bh=qHbKNtRUneS/fEByz+5cFVgWpQwIjUpO/X0KmdyON0Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P8FHk7UJaX3MOtPHi1XX+JQ1tUGGY1El5moeGOrk8s5G4G7K63erMy1q7x8s8Qf3vGXuc9onInzZjW9oR+xmzN9LPED9yqcfKwEkPHDRyaUQxVL6qAm/OIRLht9B668rSy8uC3ubSxBlVg04Oe/GUbEpBMoAbLW2gmiLJ7xUcsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqEwgolP; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747288740; x=1778824740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qHbKNtRUneS/fEByz+5cFVgWpQwIjUpO/X0KmdyON0Y=;
  b=VqEwgolPynkzC2sxBl5ipYxQDZlD6FiYwda22209RgD5JqbyWbxLWyUb
   zZGvBeQllnv3PMMnd6LYi21Cmhz6JwdsMvPaq73ay/f+JJAyN2WcTGk1m
   nRVPa4xIGXSVgfw+UlDfHAlP7v4PtQfSnwKelfLvYzDqoZYy4n0JBQH2y
   UzfzToR7O7Fh3ORYN3sZUJ4zh29nnFbkFK6uNxXSfTApTmJd/DJDvyA66
   5xV98kgJmjMlzOPDdRnhml3hdPzOMMD1GgGrvGHZSENBa4UDMTeT6g/NN
   EYD4NafupSFMGMbvJylZfzari9sbwpLxT8duFNWO4gXuUWdDh4DoGevrc
   Q==;
X-CSE-ConnectionGUID: jPZLXKyJREiIDfKo0y8h6Q==
X-CSE-MsgGUID: b0ZoGmLOQfuMK3qEk4xkCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="60545824"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="60545824"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:58:59 -0700
X-CSE-ConnectionGUID: 03UHA1DiTdS9vz9aPMcnOg==
X-CSE-MsgGUID: wTaM32C/RvyRmr/sfjXNww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="143029344"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 22:58:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 22:58:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 22:58:57 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 22:58:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icvYWQmekxiFsXItMMuFuQF/y8bAjKBGkUrvpPEhlwfM2u9nb1BMznAh12Mg5bpFKBQpqVxFe6lteuAkrY883C9Iz4QDUcaEK+Yb0NOmVMRQj5/aiKRGcCox7YfvAY1svJMUo8rPOwDOCOPL194aFr1hD+MGW+/hIo6gtgcHTsE1DCeJt3MRHmKhgglljSjZ5GtH+r80oTbbRnNxHfKPepwPzmJs4Ol5LHCM7nCGq1GNtJrjUbWrj44iB4kfo1cClfm5psojHxZyp2tjzGAq4rGmOR6ifJT4hDPiO5Hm5PJZrg32oKwwDAPZ/960EXUkfqeRiK2LMSiLwhg00G5wTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzb3+Jh/Gy82FtOV9pcY3Eg0A13wh/bsKzezd96agJA=;
 b=PVZwvnyd+Z7/liNFU6jTWlz+qCyhjLSHI+k/cVa2VhgzproE+kPBlYSIZfUATkv4YJtGgtulKeKQRqUTuzoyTDONUEFF0yAz/qJWKEOwLT1yGbL2jUTYGcE4xznwp5WksBbhG0KVxuptGwa8J0apYCbJzSf6XLwtP8F6/BhArm0texk9wndRuh/28MLWz5hJCalyu1rKRimlBQ/L0+6PovnAqpPmBOBEnbceVvkvNnbmMWrAC56+RLIfltq0dOzGUY2xbtssF/GO5JTOC3dDvid6PGuiFAnnTIKJcvLse6gRtr7g9fAxnxLW8SL0QM4+DiCoZfVeUg2KOqkxSPBwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB8258.namprd11.prod.outlook.com (2603:10b6:510:1c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 05:58:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 05:58:41 +0000
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
Subject: RE: [PATCH v4 10/23] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Thread-Topic: [PATCH v4 10/23] iommufd/viommu: Introduce IOMMUFD_OBJ_HW_QUEUE
 and its related struct
Thread-Index: AQHbwI7/mLHDYSSXzEqugYzPZImI3bPTOyUw
Date: Thu, 15 May 2025 05:58:41 +0000
Message-ID: <BN9PR11MB52765915FACBF590E09EC46E8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <bedd9de4e24bb89f18f4b13b52c5fdb6db6bd889.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <bedd9de4e24bb89f18f4b13b52c5fdb6db6bd889.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB8258:EE_
x-ms-office365-filtering-correlation-id: def743c4-8849-4579-277d-08dd93758b1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PCHvY/svDUcrI9Feip8HNp6N4KPV8oDoe/Iw4+2C5AV5acAwCci+EkBqx+Vk?=
 =?us-ascii?Q?eY5MoPBehoCcv0KUV/YjpuiMRHFdWBiK+0RUtTxQaGx++1snkFs6McUZZCmz?=
 =?us-ascii?Q?FYeV0QEL5iqijxsAl8w1KMC+OllYKb1cgRWWtXULMu7oEds0kqlFt/uEmK4d?=
 =?us-ascii?Q?6xEqbLFkLw3Xto/XDivLy17pbm9edOU55AI47UsFpTJRES91SJmIrN9X4Dqr?=
 =?us-ascii?Q?eUB9JLZI0qfSqIO1cLWsbDXcH8yieq/ZWoab8yqvoOSn5/y4HQ1jzxEnm0OM?=
 =?us-ascii?Q?lUtLy8i0GHArGRDK2q6Se4l3xxreUOKRo1Srlknh2ITqnUkjvVRbrb0bZ7Cq?=
 =?us-ascii?Q?yg0CB259yFg/neoGwtwLCXYgHHjiedrLZ4SdjYDuhCe8QKSOcWKQKndsnqlM?=
 =?us-ascii?Q?IDlzT8/TQbwrgJSKYJdlnokC3Vd6bUQCR21aJCEVKAYFpKXovMMPbTDshEAI?=
 =?us-ascii?Q?PFb/QWRGd+Z9T36CE19HWW/FCj/e0pGJ35SSq7Hf+wGU0OugUoxWFilGgr6v?=
 =?us-ascii?Q?k0dzZg3YO+bcPTIDyj1Vyf0lRb68AOx6tVnlynrkMQlTRJuPIGs12hAOj7gp?=
 =?us-ascii?Q?glzdiVmFTXOCZrogORuWDX3fynL00JOLfX54Pbu8h8EihhULwzJWE7fgAXcp?=
 =?us-ascii?Q?JWl4I/Z+FLXhFguWNnGsKkIYD/F2MKHmaHbHGwOoq6SrZrKZgbxoq13nTJ26?=
 =?us-ascii?Q?tXS0sy5QrRZVCgjOsP7Rubp9YBKWwDWhgMZ93M5v9JSmBxro7r1nhdNS6udH?=
 =?us-ascii?Q?SKrfJ9EFb6Y4nchL8/DM72oo1LTwU7VG/+a9eR7Pi3aGNMCF9Wz+/DhrIpBN?=
 =?us-ascii?Q?EnZfi+aNigx7gCUXArGi/ygGWx7lL0uNalCh9vVxrgBfcK6/EwUCKp2e4Dg1?=
 =?us-ascii?Q?+JEyYCFTNJssxeSNl7OfbzNK4aWFBfhYEtpWxsuraDy0TMOmN6jSDHDFNnfo?=
 =?us-ascii?Q?whOEtoZ+/wHw8ejZVBE8H6V+EETOfGhc1puCiekjRBuELaI26XyHbtZXW/si?=
 =?us-ascii?Q?43X0ONM0u8lv4fVW4UQ2IV3nFpJLJHaA3rYrKHHdAtmhcY0N7jYMX7mgzsWL?=
 =?us-ascii?Q?c1YjW1VYS8GCDikVWTNqePujp9aooZb5TeosIZubxetYdSSo+I3GfpZ1DotX?=
 =?us-ascii?Q?LglncrALcP7xbw0UMU7iVgTG4YproSFjw5AmBL52phx6KyhCE483o4ybP3Ie?=
 =?us-ascii?Q?qA0PSzlPqpycOoTjsrsqN2y5JLjfIufMftmMpbC+/n1Ewyvs4ChOcPInDtQf?=
 =?us-ascii?Q?xfRi9ls/sxz5Qtq0/zBLSpBlRNMUsGtybFE2bq34aUB+jYBvsB8ZTiMoyhwg?=
 =?us-ascii?Q?7+kZJGFVaw6fFGrsBAA3NuGIj47Je9keT92gYQ4yfBNygk1EBsqndJdWCRvk?=
 =?us-ascii?Q?JXz9vX6J+gEAlS3OEzDwnydtp8jHoozGQjs8Oro9OmTxIKPffQrsSIzbZgVH?=
 =?us-ascii?Q?+84X1rZ4dnszvf3Ysb1PXV81miw/GgvEUf7AL6G+jQPNIqv3utWicyFntFdy?=
 =?us-ascii?Q?sDuS4F9rCW/SD3s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kq1khJb+krtZv8P/pM8B6aQHlR3mzFa5IkigxQ4jxVCW+R+llLGfQctuwMGZ?=
 =?us-ascii?Q?pHlVQNn3EK/QaVvBPZxNgZhWXeimXnBvDIN3ZIW3nEH9oOmrtX6VKVjM5s7Q?=
 =?us-ascii?Q?TgBDKE/WSBs/5QhbgTHn0XjDwiCppdNLjcfROXWoUZEJ8EnnZt6Y+1s9rgUW?=
 =?us-ascii?Q?i+1AMcC2An9KowfCFSy/lSiaVUrdjwyyZRyyYyRoYSayzJlSqQM+LobYYj/J?=
 =?us-ascii?Q?mv9MDNBFJHV8IypMs0w354oDbRcJIhuAWIKtYh3gwQZ/JUyfexD6AG3yY4Uw?=
 =?us-ascii?Q?XI9nlWK61Sr6CQ0AfjuHjJ6SMd4n+x7qb4K7w52UL/DKB992H/e0NUICkvUA?=
 =?us-ascii?Q?HpXbRA0ukaoMw6OAAmE8SJsIees5oiz8n8rEKktSN7yAW6FY0iQU5hq+rUY+?=
 =?us-ascii?Q?M7hf0s+Q+pIhjQrkS+aU/+hiGoX0xb74fIMW+oizraLhBp0nE2tNkzLYEnle?=
 =?us-ascii?Q?Jm5ke1zk+3odVYGMWbe5q1CNFoYHYG6A5H89spx4Hl/D5RlK3gl/e0OaZv2o?=
 =?us-ascii?Q?cQqJr4CcvBu098bckOmGFeMUChznWOA8cyJtBH3Xm16EsBhQcQu3XtcivvFo?=
 =?us-ascii?Q?i260zYZuDkhV9z58FozrrvTmzrnubXBV+kjFbPhUd6uztRfGeSIjZ9Y9BAvJ?=
 =?us-ascii?Q?CDJGWFAvXl64dEAK+Y57bDcAhmOmflcFGT1eD0Ott8siR2blNY+M6dpKl+Mi?=
 =?us-ascii?Q?fZJ6EYCExDPqGvliK0trwQR7Esrr20TSfpJeiKTVvjKnLAuQmSS2LDceM8Pc?=
 =?us-ascii?Q?rEvhqtB/a8OthkmfyhecAXfxcgn10uPAjn7V/kRU+rlfFKU1fYEKJJU0dDAd?=
 =?us-ascii?Q?M2mEhgsYkE349VzjGEHaAaamey95JTRvc/o1IepSquxJ/Kqp36qrjeReSP4i?=
 =?us-ascii?Q?UQznYuafGKUDViYmq9dypNDvlZr/6iHzBpHQWTal0kSOrXU0kRs5G2ANLOmZ?=
 =?us-ascii?Q?vO3wHPUvs1sAl/TC2yfhgZCiF7nM3rfKhCjOVZuBwsxdLmsjE73UtxxRqn/S?=
 =?us-ascii?Q?LI08oMaytgiR0x9HRMpys6M94PAQrRORp1XYb52t3vRLvbo0VIJrKo90kulZ?=
 =?us-ascii?Q?zzb0XzDjEJPgUtN8agZavpIDI1D4+uQ8JX002EvfYA7qFnJ2S3LSkVDsRsF1?=
 =?us-ascii?Q?QXtTBSl3RGXsepy5AqIAIHFUF1MoYTci5/xXj2uVaa8sYS9Z9kkujc+SWoEv?=
 =?us-ascii?Q?QWBCq6ZdrVlGE7ashOQdzR4yA7NIVspntXBsBMRLYQjgIoOBAZgrGt4gka8T?=
 =?us-ascii?Q?JLgPm1FcCx+tmXbeipY7k4yxvHajcWEUPQUTN0aSj/Zxp3FRVCur2QHD4a7+?=
 =?us-ascii?Q?HnmgBcUF7OL1WzFFZTKanQ796EagVS6fvYPt08y6KOkJsnNUvneE+w8ttgYS?=
 =?us-ascii?Q?RqunPPhRO0pRb7umDi1k6bPouK8wmmorVGSEWZO5+qEnmC6swofuwJYFRlCF?=
 =?us-ascii?Q?xVCgOVtXQEvNc/CgmKrFSszzQ+NptpEHAl0PwO+VCUlJ1yr8JoZS67QTR3L8?=
 =?us-ascii?Q?XLSPTl7A2H84lV1OYUXcXGpkBro2+6TritNivfBovyMGxKVvo0pWVoz2eCde?=
 =?us-ascii?Q?8WYKkh8QK8HoFQ3vJv/IneLmPd3VQQF68O2iGDe5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: def743c4-8849-4579-277d-08dd93758b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 05:58:41.0476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVm6MRbwNk3nzDnxd05tsmrlLXN4r1KeUP5NQtEukYajIjrIkt0auX2f6XxWEYsmzviDMdct/zCPY8Ox0Fm69w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8258
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:03 AM
>=20
> Add IOMMUFD_OBJ_HW_QUEUE with an iommufd_hw_queue structure,
> representing
> a HW-accelerated queue type of IOMMU's physical queue that can be passed
> through to a user space VM for direct hardware control, such as:
>  - NVIDIA's Virtual Command Queue
>  - AMD vIOMMU's Command Buffer, Event Log Buffer, and PPR Log Buffer
>=20
> Introduce an allocator iommufd_hw_queue_alloc(). And add a pair of
> viommu
> ops for iommufd to forward user space ioctls to IOMMU drivers.
>=20
> Given that the first user of this HW QUEUE (tegra241-cmdqv) will need to
> ensure the queue memory to be physically contiguous, add a flag property
> in iommufd_viommu_ops and
> IOMMUFD_VIOMMU_FLAG_HW_QUEUE_READS_PA to allow
> driver to flag it so that the core will validate the physical pages of a
> given guest queue.

'READS' is confusing here. What about xxx_CONTIG_PAS?

> + * @hw_queue_alloc: Allocate a HW QUEUE object for a HW-accelerated
> queue given
> + *                  the @type (must be defined in include/uapi/linux/iom=
mufd.h)
> + *                  for the @viommu. @index carries the logical HW QUEUE=
 ID per
> + *                  @viommu in a guest VM, for a multi-queue case; @addr=
 carries
> + *                  the guest physical base address of the queue memory;=
=20

s/@addr/@base_addr/

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

