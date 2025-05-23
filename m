Return-Path: <linux-kselftest+bounces-33616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F81EAC1E22
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5DF189A8FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCD82676C9;
	Fri, 23 May 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnqzCAQO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479092DCBE6;
	Fri, 23 May 2025 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987229; cv=fail; b=VX5hDJGVbHmb8juKrGpkbjPGqWdfz+ACidcHbvDUjgPqmH9xBYBXV43XRsnBeIXOcfRA2X8zRbiBQtxW/0zfgHVkgbFekbEUaRI5tWz8sFLyvM5kWpiCAKEqOIO1E42hd71gijObRDeAXBP+DEHIH+wFeuglIXKQltUet5NnHJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987229; c=relaxed/simple;
	bh=mocace3oQ1u22gHeoIcX+zEGxBUOT/41xW+MzDjsObk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=It4J0yv5dHWExl9RKRcYqw65nXdXtvEoBv3VLpIkJxF+ndcCwpo6VDDhhKUvxib+VKIb33Qx00M638DK/SZSDvDLGBItrrp7RBq9twE5Y2/uCq6FRsJ4Heg+UbiY7G/vT02RcjIIqR5CO2Bsy9A3vw5nyO0LiuqoxFms6ERdpsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnqzCAQO; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747987227; x=1779523227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mocace3oQ1u22gHeoIcX+zEGxBUOT/41xW+MzDjsObk=;
  b=CnqzCAQOuzE74O9+NnXKISFEuPZXmOguk8lHYOJLRrFpF1/uhO4vabM8
   ULIutsh7jiU+ePAnpJWGlnT1H4JPHfLSJU4z34QeC0Q4rShJVprUi+UVN
   zBK9FMYdd5EkeziNtax6ipDb9WPoYrxA6qUOU1qaNBj/Hdgs+Wp1exR6f
   YTUI1YJOxUgcpHlu2H+P9AbzMDCuXK2VfyRRaGBnqlY8G/JCzksQcr8kP
   OeyECxgto1aZ+dP5pP5jX3aVw9v9OSiv7UdfwZYWHhuKESKVsxmGlFCst
   ps4IB0qRg8d7JBl8IF8I3fg14XKD699UjpGEw2RWvEIk3AtvxA6cCGjiF
   g==;
X-CSE-ConnectionGUID: rECNBTU+Qe2PKZvhzYrObg==
X-CSE-MsgGUID: 3GUtJmhhSU+snn/gfILHdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50181837"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="50181837"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 01:00:24 -0700
X-CSE-ConnectionGUID: XH/KZ+/rSfqPkcgcPtpcgA==
X-CSE-MsgGUID: UYhr7+QhSlKTBKaHV+Zq0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="145870158"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 01:00:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 01:00:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 01:00:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.73)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 01:00:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJ6PaAOrFNzqcUBnAaQoKYRJtIxxB2GX0HeatUwFmXyx04pbsj0NEya/NF8U1xJbLax3XsABKA+6hKY5xauPoAHjTrKLYjfA8ms5D0WhHiipI8SwcvvE1k3Zop1aH0n8sXnTUCXtAQzVuNiUZWFjG1zsm832+hetkedloP6ftS02dW5IYCCjm1kXF+umosXjczsEpsedjAKFGyakAhjE8s/mgGqeWSvU1XHu0V6qvhXNaMXYq+RTmbU7gOsvq91KAG21ZwIXZWF4SIGU5CExFaf8GVoadSYPyE5IJ4qu1fzQSNnS3ilEne0/r4YLIMyLA1WzXLWoZlFf2vvsuqGtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvuum9kReJV4BPQVFowh7Kg4vun78YXv4pzL3TL5qZI=;
 b=eNAOMFrQPo7SZKfdVjq1CsOATbhAC6gHYJ+I8OQyBFkghN3jfAfu9GYm7W7kCy7yYkuNVJxNOI0Mi8eQ+ZbkCZY11/Ufj88rPr7oCu43lnvs7Jhey+p+O/WeyWI4EUHx3mUrhusqiq2cxeT9qJ/7VG9QFtE7lA+OjeFzSX4+Djp5lDvJUr0FDf6P/P40vEs6CzhwQoZrZl/BOkJGVriRMVxWTUZydCRJePdxAA3bFwNmI8DAlpBqq/fSfXiPusq/lr7Xz5jC3sVSxbN4oqClajCf3juYN7Hme32dZyUE+1ma3jZwlsQ6BYYlnVlINzZ88OkqfZOMUyJuExpLDVttaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Fri, 23 May
 2025 08:00:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 08:00:02 +0000
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
Subject: RE: [PATCH v5 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Thread-Topic: [PATCH v5 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Thread-Index: AQHbx6Qgpfst1pCMt0ifWZ2pxAOpnLPf4Msg
Date: Fri, 23 May 2025 08:00:02 +0000
Message-ID: <BN9PR11MB5276B1C7B8827EE2102824998C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <5c509f092ba61d4c0852ba57b530888ffb864ccb.1747537752.git.nicolinc@nvidia.com>
In-Reply-To: <5c509f092ba61d4c0852ba57b530888ffb864ccb.1747537752.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4896:EE_
x-ms-office365-filtering-correlation-id: f4da8511-29d1-430d-b06b-08dd99cfd24e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BCxC8k24KO6oDuASCk5IwxOh43CvMGBDpEMYL6gVIwp621zzA/Gq4LB/JHEl?=
 =?us-ascii?Q?bEVVEWrYU+12baqzqcmqnF/O6ieGvpD1zGELX39GZVzlzk9/zrCTw6fDa44r?=
 =?us-ascii?Q?NMl2rLUkcaQItTsJtg7nC2rCMrPCWyTg9Qi90LEAmsJ8cu1iYlgrZoGe9uqi?=
 =?us-ascii?Q?Ma3CcHh8RFbvpVhytuqkr6gx0pvC6CNLfHlDk6kZHLtVbxTC436vEQxlFf6n?=
 =?us-ascii?Q?LzQaAJq+DqW2SD6L3J1tfv06wrVHu19QWovYH7ED74GJo9yvib+y5z2g7YWm?=
 =?us-ascii?Q?jDYzd3Q75lm6ZGjAPUyB/BJpfZuR7/zgykfvqhqc9w5QaaGNVFcuo91ZiDkM?=
 =?us-ascii?Q?6kyHoFhbpW9hN+Dr7IZu4Rp38h8NfNg30zBsOlSl2xOWSSen2C4DlG7Rx6J9?=
 =?us-ascii?Q?TO2Kopi3l9mXRbKX54/GzX38EzbzStwNY0e+Nzrzl9eJN0sh19271ilfFbYi?=
 =?us-ascii?Q?xh7+ZNsDho/Ae7eOkeUg2Aj9orumJ9vNSLTeSq0tryCsNOyq5pLiDYqD0dVX?=
 =?us-ascii?Q?a7TablqZfDMTqr4NjFjhEJt9ctGk+2LeF96L5vgkgcFRVUz8Cp1+QlNObK6B?=
 =?us-ascii?Q?A2KBQDjWmviyuQUpjOFql83qGFJc2yRbsvdM44ctxGi/UitNn+m3hpKpJIyA?=
 =?us-ascii?Q?l/E8HhoOZqyB/ZfvIFQ0MNV5uveAS04QIF5vYaaD8q0QwXKBrWDNF55b1BQ9?=
 =?us-ascii?Q?Mf2r4c3BKt69aM8vfm6fjXr2vzmtPOHI+Hai5XONmP1BbzEI2FH3ezlQvd6d?=
 =?us-ascii?Q?8xuBvAlgOx/FjjmDmi1osYZOt+2YuSr+fPWRhXpE4BYbL9rbm18Qj3zVMetP?=
 =?us-ascii?Q?g4oJsjV3JJyM6BryFAGCk1iuryArpfpoce8onhFcxRIxRQYVOVpn2qB6EMt1?=
 =?us-ascii?Q?FY+KLc7SAG145pP6nuU9YIPsAap4PaCGdSu6MVzX4UK676MMTtRkA+mf3hB+?=
 =?us-ascii?Q?QCxvOBRN513gYoecBEz4STAiMC7o494dD59bLX42wAU4Dxzjcowqorvpx5XO?=
 =?us-ascii?Q?R5XLwvTmSr8s47VriviWzKuO7f2I264dOrNNI/Mhw1sB0lOYivF5YEFnWBoZ?=
 =?us-ascii?Q?dtyrMenVuOlGxcqJnyZOosIdBDeGG+q3JG8yaS/0NOYh3n31iYpLu+laHrUy?=
 =?us-ascii?Q?B+nhHwn21HPCsw19GRPkeXBsKdtJiB0JQvD5NBDo7I0NpoigxrwIoudXlBC1?=
 =?us-ascii?Q?MENByEjlsXF9QHVezBCzORWQN7acpFLcZHd4WYHIeqy3Qe2WYC6+KHi3CZTf?=
 =?us-ascii?Q?uHJdVTCiXOR64xAD0OCFO4BsgZMxCeOL3ttgsnREFz3t20ZJyohvBJjOiSrr?=
 =?us-ascii?Q?5XksZ3NQJ+uVWbbzl3eItMnGtZkmdlyeywgvqHfIuhnoaiAjheEkobLuy0MY?=
 =?us-ascii?Q?h2lhDGFr22CGIxVIavf/IlQ4oKKZ9huF6n1rMGdN5m3nEIAQdsAw8k+5++4k?=
 =?us-ascii?Q?oJlPpF1vvwjBGdTZGgxgRY+0ue+4y8yh9dFLQULrx4/SYn0caistJA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LHdeqlraw13VvQr8W8A1tQD/weFc7v7PwT4SCuYaw8givHJQuQkNR3Y/ceX8?=
 =?us-ascii?Q?pJQu4AZcNKHtaGMEE2iaWiRR4LfQ28q3iKYDxgLIAAPy9oDFSbxkghEGg2es?=
 =?us-ascii?Q?LCql8kUIGuJoH0eYRloBNXYY4LTrvYfv+v3QFteoQlS3fSr4FARg2plCxEBm?=
 =?us-ascii?Q?sQDsx6/YKlsmTS2ASN2HuwIOnam33DALqhTWjXz0AoCKVeY6S0wLuhUTP9ic?=
 =?us-ascii?Q?7+cy+uTKK3yRfkeJaZpzxmOi3i4yqPbRz2AOgri7njQAddsBYEM0SmoJpEPG?=
 =?us-ascii?Q?ycGfQKz8KPAufYFSzGW3ZXHWTZb5fLy7kN9jiJ6u7ZSWl7oHzgAAfz/ce4Ov?=
 =?us-ascii?Q?/BjoLyLcmCrRFNivGUK9aDKDsAJ6pp8+L3sLAXzqQH6N8pxTLvlr3c5oHP0B?=
 =?us-ascii?Q?mXsPMae4JnJjn2ccnb+p965tt0XndJGNHSYwaTyyceTNx48iXwLzOA40sZkZ?=
 =?us-ascii?Q?fVsuJkRUIWa2VFGDVTDFqb2A0RLATL48419+EAc41KRlBcDLPJ/EDZ6cLHBS?=
 =?us-ascii?Q?8VZL4N77pbp9QTjFdMtic8uux/BxR0gBfHkNRDwrZYjaixh2Mq5pV0ILElNI?=
 =?us-ascii?Q?BODFfw60wwQxsR1KNP390C4aJbG+FZ4CVa4i5SaZATBXFTRIvK00pQ9e/mgT?=
 =?us-ascii?Q?DCbIv+ZaVLeGux37FGsQ3XEK4EdFivKYjdzy+/5IZpIDeyuDJ/6eVKyw/4Ta?=
 =?us-ascii?Q?QBvy/m2jylVJ03YwOkZeGRjK7rCkesECOPvkpK7eVDU+vr+EiV/K/xRhhBeL?=
 =?us-ascii?Q?nLaz6zM7glTXQhPXOOxI8JNtk0r2lmM1Re28g4wgLP85T7FDgngETXzu38MP?=
 =?us-ascii?Q?S1ab0k5lGMfC04AqhaE3k1a/fZPUGW1D+JiK62W5zsYXFEYbNfZMTLBs+7VH?=
 =?us-ascii?Q?QmtFfYsAdTl+O9oLxXY6Juu0RCr9p9Rj6mnlVE1ZpCbPQtchio/xix+tfEfH?=
 =?us-ascii?Q?F9u4UXaqfiuqc93TVUjoeTe1jICFtYufUHdjtqon57f6f6hZDca5O4Zkm3OR?=
 =?us-ascii?Q?3yLk/wXvsu3Bo+Hq55jKGtH/1Si2Z/v+JTv+afXuSSZCi6jM62yDdP8dTOGZ?=
 =?us-ascii?Q?y2OZ/7aEP4rTcmCWqVyxRC5BXGW9AKpA97NAgiTDIYfrKOh0BiO+Q1MdL5W8?=
 =?us-ascii?Q?29yr34Kyjdm4cvIb9bsPYoZjyBvuORyXBzkFQNfsYDiFbXtFIEm6fFtYJsg5?=
 =?us-ascii?Q?XULy3VO/VPB7ZRPyRWSiygJz5fqi+dcgUxF86Cqx3m9sVh3dsAHUH3ymlUDN?=
 =?us-ascii?Q?JWgtbJbI8Eptsqg8UZMwotS1Nk5maFMPdd505Q5LNUNGwfVpLOu+VqHR3GX9?=
 =?us-ascii?Q?7IngExFLTS29RhS4HF1u+EsjdH5OaCjjwihOKpQK1hNCBwlScU+aJDf2TIw9?=
 =?us-ascii?Q?83IcwuxacW/RAgWMaq/2Kr7g4D5PhdBkTTHxI2Pn6RhCf+QrXI7Kr87jkGsh?=
 =?us-ascii?Q?TawpgVDcqZeql4WP95QGVoB1BYr5yu2X6pUAfl1Cbxye2X0NiH0Hnb4MCviw?=
 =?us-ascii?Q?aH4LLncT+Ahk1cADdhXStYhWwrscoTugKFcy69IlneQDNX29U1FlflARmp3i?=
 =?us-ascii?Q?675WuAAbCUrcHJ5v2jZQ+1EM5C/PlH8PiE0sfv06?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4da8511-29d1-430d-b06b-08dd99cfd24e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 08:00:02.1634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZsvAaTR85WA8G34LaYyjHrb+glP1RhrTCP5Tk79iX1SIWsztC0r+rwqkA1jTCBAls1tNYZ+ZQHQ9EtAtgdRfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, May 18, 2025 11:22 AM
>=20
> + * @nesting_parent_iova: Base address of the queue memory in the guest
> physical
> + *                       address space

'nesting_parent' is a bit redundant. 'iova' should be sufficient as it
implies a s2 input address.


> + * @length: Length of the queue memory
> + *
> + * Allocate a HW queue object for a vIOMMU-specific HW-accelerated
> queue, which
> + * allows HW to access a guest queue memory described using
> @nesting_parent_iova
> + * and @length.
> + *
> + * Upon success, the underlying physical pages of the guest queue memory
> will be
> + * pinned to prevent VMM from unmapping them in the IOAS until the HW
> queue gets
> + * destroyed.

This is conditional.

> +void iommufd_hw_queue_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_hw_queue *hw_queue =3D
> +		container_of(obj, struct iommufd_hw_queue, obj);
> +	struct iommufd_viommu *viommu =3D hw_queue->viommu;
> +
> +	if (viommu->ops->hw_queue_destroy)
> +		viommu->ops->hw_queue_destroy(hw_queue);
> +	iopt_unpin_pages(&viommu->hwpt->ioas->iopt, hw_queue-
> >base_addr,
> +			 hw_queue->length, true);

Check the flag

> +
> +		/* Validate if the underlying physical pages are contiguous */
> +		for (i =3D 1; i < max_npages && pages[i]; i++) {

Page[i] must be valid otherwise it's a bug?

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

