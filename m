Return-Path: <linux-kselftest+bounces-35729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B95BAE7583
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 05:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710F25A4D17
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 03:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F651DF26E;
	Wed, 25 Jun 2025 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCDLmK1s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DC1DE4DC;
	Wed, 25 Jun 2025 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750823114; cv=fail; b=R5FCvn52dxACpE4wX6JEdVfpwGZ5gcOchh9wYLYoV+TsogfeUyMglN4gC95qzoLpcytTttlXrVWIPFb8HgQfNyzS8Zgpu0HWhJufXouAZxyIY1qvMmVfaksIADXwQ3EGXeGnBqPN+TQYKCtJBF9brZ63X9cTvqyCLD9ZZGOsVB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750823114; c=relaxed/simple;
	bh=YQxIxWplmueF5QAVKIjjrX5GPcHPfXZS0uU10kCky0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=liKfOO2ZY5hpzBShh0E5E8IUjF5KV5c+wJu8HJ6LEAF+LB/++sEVEBL+sgcObnZBpjO/G1Be+0J5SKxhL4qeqxH1OPiglPfV9jTjuNLx8JHOCjfJlZsMvrBpOQbzRcdpJnn7IPm9lMU1gLF/ZIelIOYmudpmTRniIjpNG1kh+Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCDLmK1s; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750823113; x=1782359113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YQxIxWplmueF5QAVKIjjrX5GPcHPfXZS0uU10kCky0k=;
  b=QCDLmK1sKzxyP1u14SweNfHl2NBvkgjUqOWzEMS9d43YyKTXEHjqk0x7
   xZ3bkwZCaEGtFDGXP6CovNG3olWAMwMca/XfouHtUNOE3MJml6ybBxesd
   datdyw8gSsgO0v6W+hjMBJTsS1aHF32Pil/uZ0t3agdSuua1nXHqJPAV5
   wRQjyV9+NqRT6QLHiALhuYo1nXLAPAaLkNP86b/h9tY9Vsa4pCaOpbWjf
   7AaviAmdnds1xb/cV25SheXgAz45nNhhJ3/EIHE5N5KZNMBi3Gz2PB3QO
   OiNpQtTTuGgyK4DCWKuWXRLBVJhbXDnl1ySBLQKR8u5yf0kpJeP5xZvxE
   A==;
X-CSE-ConnectionGUID: M25h8lsESSO5oel1aXREYA==
X-CSE-MsgGUID: gPByC5RkQDijUNQoSgZkeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52799620"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="52799620"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 20:45:12 -0700
X-CSE-ConnectionGUID: fSBTyvyDTB6e8eYYYsKYSA==
X-CSE-MsgGUID: GOQmyQHRRvSjg2sJv003dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="151846370"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 20:45:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 20:45:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 20:45:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 20:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ned9qsZtbQAeR3hRWEUl/QRBuF2vGrGh786gainf7gUw1DbfBN2cVM8Tz6X6Nw2gS0DIpVS4izZ1VuizSFsF3lGegWyEQZ7HI12g88BtY3a/VLc0oGFydWJHSwe8VMkGbfjg7uzy5cv8/WKDiM2SgC2CGjM1Fd5HwvodQ+4SozXn8x7O862onUNxnO5OYOIootcR2s2vK/XtebwSpSIDPCVbKd9BSoTU/PyTlNJcBRupFPhLlewOUQIEr4aGL53glT93UtDQ96h2jhgTh6HqmMGDgoz7ra6/JOu5lpI2c9Tgs5B9Tbd7rfgEw8UBnL1cAmp7XkQSLEeL6J0eG3xYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uYG2mupYMdILfIoHucsSrAaPtc4SCz7llq7oQUKaRE=;
 b=eHk9jBbpeBr1IGH41aIFmtWRUnhqcn/MWyVVrT/sKBf4qQkRMcwA/72PE7f3vvwRcm/QVvkIgH2RXfqUtu0QdOjFR4Kp9H7Mu60vt0ijuyCYN1ukZQQlzbCUwOytKgXAhj1QFHmnqM1DC2hR7BKsOCHlTKnR5LIHXcrtNr5ysIczijp4OvJ66w5poa8Uw5OtrGgNktzf8MCy4E7vysNTIavzLUi49Atc4lMClpEhRImQULF3bxSHb87yTEhGoltzPP8GLu8TH/WX/pMNtauo1QyC2heMNnReVMTqatGKh0Y+2JDAGtfctLIldTTLZBgI/9Yg6nZLkYEi6hc7Rvo+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 03:45:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 03:45:08 +0000
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
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Thread-Topic: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Thread-Index: AQHb3Pwk993zGbArDEiQjdZ3GEWFVrQTTJ6Q
Date: Wed, 25 Jun 2025 03:45:08 +0000
Message-ID: <BN9PR11MB52763496C4A0066A77FED5B48C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
In-Reply-To: <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8449:EE_
x-ms-office365-filtering-correlation-id: 95371f71-3b68-4bd7-0a24-08ddb39aae44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lCQpJi/5upc3ViKm2sNI9jbsEXaqr5I4Ds43B3elt/GQDadflJRbN6oI1nrP?=
 =?us-ascii?Q?xBDuP81xqTQZ3yBiyZHGcJQ/HPydjfm73e92EcaqzEz86awD4H55euL4YSXK?=
 =?us-ascii?Q?I7IQYKQG5Csmaz1T5FeSlq3muLQ5cEBxG03vYd+SnvcRAIAaWlG9af+5/OQZ?=
 =?us-ascii?Q?zmlsccwIcxBfpK78wscY1OONAfDhOdgW2jj7sXaoAei59fo+4oonlFee6BTr?=
 =?us-ascii?Q?szaJkYTTKSvIJ4sRwTqgJ4vvdB1xb1vKemnzki8f7/Cg6CQhw/RgAiOhPPgS?=
 =?us-ascii?Q?k2gx7IcdPI9mM2GcljXrOap082no7PEb6GZ4+0Na+jIZ0A/GP4GaPu+Y1mT2?=
 =?us-ascii?Q?QQSfoqaA2r0NvHUENmOVi7MxP7ukyxy95AnfO8PCbnkEtOlCCAyQO+ZfgWhc?=
 =?us-ascii?Q?kqwRuSg7Yiz9HmP+EsZsJZqAglekd2QbR3/Zz/An38rxlxd3v8iQIG87f2LU?=
 =?us-ascii?Q?HJnrHzB+Vb1hS65BDMjImwfuvctSrN8CuszLWYF751UKrvfX7RBnV1piRq0m?=
 =?us-ascii?Q?f5CpFCcYtMXWUY345A9cZyDaoEq4XFB6krS9xHgxChtdqIaJ+G0pWI0i2mL8?=
 =?us-ascii?Q?A9KDrDc+KuT0QXdEGUYGVyMn8E5Jmt+W42oX6z8dS5BZVBnMtpd8a1bSKzna?=
 =?us-ascii?Q?xew+ufyapldQmCXa9szFZkk3CmYc1IAiNK/KtKO36UZ479snPnqCx9dMTfGp?=
 =?us-ascii?Q?WhWLXNcVTB729o9wTW503eoYboc8QhpxuzJeMd7Tm8nsIbNgcwyYCi9rPJ9w?=
 =?us-ascii?Q?XzJQ6JyUAne0A3kBPOc2U6RRtEeWn/bdDnXGVy3lD32rSdQyiAPuwwmipHZb?=
 =?us-ascii?Q?uObDFllITZkYeFpqP8ksVEYws5ol4olCspP1zjsWbkKVENNdfe+ZMPg7o4XQ?=
 =?us-ascii?Q?BIWb7svBeVFEwF7/oM37SbENlVpLABSknIZUy6GEAqR2kyKrQnTedVHllSBZ?=
 =?us-ascii?Q?SFwYE11AAOp7RuhNxl8ezBXJ1COyAXqzJdA/g/3JXeA/Ce/vTRvF1FavAoeX?=
 =?us-ascii?Q?Ah5oW/srJWK3LiYHb7hmh6eOqBuFqmQFOIz6pjjrLvokM3srR7lWUrpdoNsf?=
 =?us-ascii?Q?nEe8eqNPrpahKQr4mK8phzdI+8kRYpe2pXHpHQkO4psOe1nhiwC1JQ3zTg54?=
 =?us-ascii?Q?u2ORhgy4dYZpm0QcmhwN9/YpvLmbNSEVRO6W9rK0Q+idQ0X8u1LCbcybFK3H?=
 =?us-ascii?Q?17rVVRZ+Wja2q8Q86MBBwthHg454494z/KKTAA+uE1jblxLgmQXiID39VjxB?=
 =?us-ascii?Q?GOv1ugBojO1o2xY69sQyqv6Au/NrmbOpdhPdV1cJBWD8gFd5e+Dk+gyRAHb2?=
 =?us-ascii?Q?XTGkBi6ng7rUYdvNFqqGph8B8dKAulwdUmggTEEkABvURnLAqK9WjCpG7948?=
 =?us-ascii?Q?Uzd9xK4OSA0fA2t17dxDdFo41iz/roBOwmlMykkgwehifzOOucIHDwmbeCXc?=
 =?us-ascii?Q?Bzw0Xpo4dzG0v/0vRr1ujVIBDs8lIdUOF6u9XtYmJ6uzFXQqkXgdJAOJs7k/?=
 =?us-ascii?Q?aVz57AEQBRYzR5U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GHOkGcHu/uIazMX6oJtYalfoKSll4MBnByHhG9bhX5SeP7fjWGG6MHg8Uwzj?=
 =?us-ascii?Q?grg75L25rcN0zMZJJBYZjIJI2xOc1LcE3K4Gu4S6N+dZjp0mjISXDw/VwcDX?=
 =?us-ascii?Q?qXRD71C9QrMUMm2tLJhZKZ15wHrjqBptrgGa3lkdeGhV18E5V//h5wdK68TK?=
 =?us-ascii?Q?G42SCfNo+uRlte7bPQHPJTzofTUF37G1MHoNB99HIfdT6h28D4Bbrss9hAU5?=
 =?us-ascii?Q?t5oRQ4l2vM7QVVDqFkb7m7tmjRbHlmurGQ/XsAZc7xFucCH6dhUS+DWyrxaa?=
 =?us-ascii?Q?PA7/tBO4KWdjR5zl1B2+C+JGWwcIpVFwvvyVlPdM/9XQUrAyqYp0SoKlBG61?=
 =?us-ascii?Q?IT+65G8RoP6a7zZrIQswrm9UEqv5Xk6Taye20gm26G47rjYeHQ8ygYwjEi7x?=
 =?us-ascii?Q?sJqUgscj4PxKfoGRDklclisprHR4jqNs8Z0EM3AiZwP7DPAeDmfEmMD3HYC0?=
 =?us-ascii?Q?2/kVjOzcTUFPT9fjnMapGGjJtd1fwyQmXgTGZ2LORWhlR1cKY5hUuw0iIgCX?=
 =?us-ascii?Q?S9KJJBYg57/RdUVoIWDAUTNvSpn+KiIUQH6FARp6KfFze5OxM8JofrGVpkn/?=
 =?us-ascii?Q?3SRh7nJciwim7X5BHdtrWfTJOljOAtQ600LLt3uUK5Q+isdBsM1ICx/qCopS?=
 =?us-ascii?Q?4s+AHrPq2RGbfxKa5xCteVMRPcrPWtnR4yXKXPrOCTTELdpT6l8kNlsWKq/E?=
 =?us-ascii?Q?uYDxLsa4ZLv1CIxMYLREfj01i9UKCCkZIg7S4cDl3TmJF9nGaYCa2AMNwdYa?=
 =?us-ascii?Q?EphyFs35vxbm8EHtXTPuEbcvHe2beMTx1JndJH2Pug8Sp4BV1aTNh+IERUMR?=
 =?us-ascii?Q?DZAmlh0q3sBtHcg2xCUZ0lxUZGouaoPSDQoDAZXAqjlKT61JR1Uz4A9cFBXM?=
 =?us-ascii?Q?HSHL7VQEhjkgeU3snhIzjWpzfMirRCdvRIjatWoooeKL2luLHUVUZOM9y65n?=
 =?us-ascii?Q?ydHmFyGTGffJnbSfRg+JuVnxOkYFbLsK2Lk+5Q3VoTX6HCF6phC63vO+EuF5?=
 =?us-ascii?Q?1f3BnFkv3e6bE78MRTlhzkix1hGWZoDVb8GmtHClOd+XlUElkPiETXbo2J1f?=
 =?us-ascii?Q?zzvPQ83xjyIIreRcP/l25MmmC5vIX/Ac2X+T5Brf3j2s85OcyVXidy6NEg/3?=
 =?us-ascii?Q?gWnV+jt7WEuftaE8kR3RCjl/28rsHofrAzlIklhvr1UJZGDwU6cLpaGD8fk4?=
 =?us-ascii?Q?x2/ST9cTELADqANgdVlHBoEXwkyRzDpMiA+XWK2m3HF5zBmYdHgZ/ZXkjMsA?=
 =?us-ascii?Q?L6G/fBDOnFz23LcO7W7ByR8aarK5k0QRgOjO907ES1hHqSa94NevwifbSTUq?=
 =?us-ascii?Q?0hmV+hFHGTKhHMQJSp3n4ul32ReKb9F9dZ/boUuIjSHqdMA40y1fz+keslAR?=
 =?us-ascii?Q?b46FEggUpq0bft2fdpiZzd9KXk6sFyGaphjbwJcOlA2o1elm0gtsU9H4d1Kp?=
 =?us-ascii?Q?E1tm1hKmjljk9/hraZickBq1VIfGeCmNu5xXnsm5+uvUgZ44+cuidQ43U03n?=
 =?us-ascii?Q?Dl4FKok3PRKTFj5b7a0KkdtFMg0y0hmZ0ehgm0j2hed/F9OQvcDRE95qdf/B?=
 =?us-ascii?Q?ZAf2xxFr1Mfj2HdHqMzeI41NZ35c53W2mqF5I6s4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95371f71-3b68-4bd7-0a24-08ddb39aae44
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 03:45:08.6345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8X2LW0Lt5Yjm88x15kYvqH9o0NJ9Qdqjzieah+ca+3DnSXbbqKPbQeeNFvzmJLQ97OAhvwE2wezZHL8Dd1rHpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, June 14, 2025 3:15 PM
> +
> +	offset =3D
> +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd-
> >nesting_parent_iova);
> +	max_npages =3D DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);
> +
> +	/*
> +	 * FIXME allocation may fail when sizeof(*pages) * max_npages is
> +	 * larger than PAGE_SIZE. This might need a new API returning a
> +	 * bio_vec or something more efficient.
> +	 */
> +	pages =3D kcalloc(max_npages, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		return ERR_PTR(-ENOMEM);
> +

any allocation may fail... can you elaborate more here? How does
PAGE_SIZE become a boundary?

