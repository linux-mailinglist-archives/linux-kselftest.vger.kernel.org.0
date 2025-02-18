Return-Path: <linux-kselftest+bounces-26833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C0AA39286
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 06:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0591E7A3193
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 05:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CBE1B042D;
	Tue, 18 Feb 2025 05:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+n/SUVr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7DF1922D4;
	Tue, 18 Feb 2025 05:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739856114; cv=fail; b=GdQlRLHbWoJD7uGQe2O0fpnHtLvop8XxmAmBl7vU+SPzyFKUHguzd2DShQf90SpCYqgXfjgaLFmY147VyM+I6aJ3afvq/OZIWrFU0GjlxUBioiK/uwoEywZ6ck5kAcgw/taH09QOYtc9//MR3G2UT1ikPDlh2XPwd813D7vUdUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739856114; c=relaxed/simple;
	bh=PQLrjdPXHdfK7dFKgPAfLZBCphqhJGe7kLN7XGNGASM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hk+foZZhay8k4AsnTrmZbl8qa1G2TxlNq9k+FSOApm4s/wAcezefrC7ZiYjAiraetO+hSFZR+RgdcXD9F3RId0NmhrbTk/5eGP7whlnMq0vMNnlOceetplAMJPl2KWQYYmrZas9HF2ZAxad0Gh7IilTN7OyrvyXhSfrwk9OeT3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+n/SUVr; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739856113; x=1771392113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PQLrjdPXHdfK7dFKgPAfLZBCphqhJGe7kLN7XGNGASM=;
  b=S+n/SUVr36iv5VABhCkNevAl3ZxDnHHZPaP3HRFRpPBprGnXN3FXjxV2
   pq2nD72RcAeyOhNJjTXb8YdhBDw/pNWMJsc+M8mqNShHqSjqPJ26si0W+
   eWDA2g3TU+vNyHIut/Ntt5LWm8XvOMB7UqaXxUD5QdbWtB58s5GWbjFlN
   Uep0Ge25OMrfr7ODr9hvH/Uuxi0xKCa5bSgh8sg+TwvMFN7xwJ8qTogyG
   Mbjq6te2A4gEyp2xKAonKfOvmbDUzGO4goTQ4QS3ti4YtDu4xrwD4KDtn
   fwbZ1En+JlmQMb4Vlz7YnyJ/LUmLgKYLSxL8i/AOVDBMUQtmyMYH8VBep
   A==;
X-CSE-ConnectionGUID: 5HCCbC00REaBZZ3gFe0UxQ==
X-CSE-MsgGUID: MGVKfBuQRY+jHQ3LHzyu5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40243047"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="40243047"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:21:52 -0800
X-CSE-ConnectionGUID: rgYrNzPxTACqp7GhN/l9lw==
X-CSE-MsgGUID: KWtm0FbSRl+9mFrlHG2cWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="119288430"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 21:21:52 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 21:21:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 21:21:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 21:21:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0spnkA9xrmoEig2GpQiASNmYXEi2jN/8Rkhp7+lhmdtT/6cAPqs36hEQWFrrhwwHZJ9OdeP0Vylt83I2DPl5gjqOt/PEhyT4EWk8nwF9qead/PIU0hb3WwPh76NCosou2UkrgPuCmuh3R4/eUj0UUi4gxb4Xs614ykkH7BQfBnJL+7AjPa0svzcWe9bZ4ATI5lVcCuYtAr8pdWU3SboYOY2oKLwuUdvuiQiUfYr5m8fOZMfVxhzZqaLMZ9UX5VdCL5d8xCvJ4QlgQSsJMxBR3qNkPPCV04SNfWY/vILfs7BfyIaVVISoIn1P2VxRdrc12ZpqH5hjoD5pc21b5eyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQLrjdPXHdfK7dFKgPAfLZBCphqhJGe7kLN7XGNGASM=;
 b=nqlyA/HEqHhB+8j5GzdyxQ16YF21ls1g/j9H0knolTCPCpwGfwbD0JIoMza7dUEI1DMtSuJR8WeN80hOWT1bZSjFqLXjmtVpKvOklpErbEznyPOsVGcyAMD1CSe5r+V8ISR0LOdB/S5jy83UblsjsNFDZSXfuNszZOrOHHScWWHcB3FVyytT/u2Ktsie3fJXF7k1vzJ0t1BYH4vRXCquvE9X4S44Kf9juhSaBytq288hy0ztgv9a3ubVAuMpIHIbySUQFenEE4xm0nICFW15uBZ7dx5JZ3UqEtrecpgoJIgf6WgsnEU3uHupC+Ll4I6iBAaDcqGA0KiSIIDMusnzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6142.namprd11.prod.outlook.com (2603:10b6:8:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 05:21:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 05:21:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
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
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v6 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Thread-Topic: [PATCH v6 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Thread-Index: AQHbbsCBPjGt+w3jJEeCRiZ6nDct0bNMrFUg
Date: Tue, 18 Feb 2025 05:21:29 +0000
Message-ID: <BN9PR11MB5276BCB2CCCD1A1A2C990A2E8CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <b71a5b132e8ba771998c5b810675f10b100d4ff3.1737754129.git.nicolinc@nvidia.com>
In-Reply-To: <b71a5b132e8ba771998c5b810675f10b100d4ff3.1737754129.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6142:EE_
x-ms-office365-filtering-correlation-id: f6af7d3e-8fd2-49a8-c845-08dd4fdc1996
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9vyZKxhJMG3DC/gO2M0JIz9PXjVGwS0+65MISvg38mkCeuXbmbi+0jYAmcWn?=
 =?us-ascii?Q?V/8oFFvkPi7UaZ+5zvvvg1rsSGoa77RboK3ef//vgHyG2pEceUQOEnPh8JNm?=
 =?us-ascii?Q?fJO5C3OcYtCd30ShIfY9rj/V3pz5++r3sXJGuVeomAR7cU5zkXza2w6y16Wh?=
 =?us-ascii?Q?sB1gG7ngfIktvvVf4Tw9ZWVNU5+5skE0+PEuA9u9mRR5Lil0ZFSwnfJPknyG?=
 =?us-ascii?Q?TO2i57voxf0hKTn2b5H96YVbSiu7GzvNx5Bgcp0lFJBEWoyCcVN+Hhmya1rX?=
 =?us-ascii?Q?1ssQiXTGEQIRAcM6xEhYl/zaMlGKIz9nZlqIbrTBSBm9HHLT9bicoh6R2soj?=
 =?us-ascii?Q?LdXZYjpuxjAOiwxG4TrhF4cJvxec6ES+9ptbmmvzMw1jyGY/4zKMGxq/AtmN?=
 =?us-ascii?Q?3bQqjTxAjX4OdASzNCkbaMQYPM1yardG99oj0L34AYRwjMVGy1shJIVozqmM?=
 =?us-ascii?Q?0bCR2BP+z0SEBKPHeKL1TVQv+8d1+dNu6xjHHQhlvlLmlVMUrFF60K52FV72?=
 =?us-ascii?Q?RO2N1CMB0isl2h7dFViXaTbpJLM+I/yX/LykP9k7MBsOKXlYkNdHW1Gi9koq?=
 =?us-ascii?Q?ubO1BSVXQbiz5cEVteJYb8Lgrs3Egfza4qtmtHL6heuIzIjOFKuStDjIgYr0?=
 =?us-ascii?Q?ySnXMG7g0dcWXSQgRrdGv52ExvCQxW0hPShyc8jjIrGzvyTtkd58V5G0mgJx?=
 =?us-ascii?Q?YmD+LlD+qHIjDxPxNIgqyGi8nh16ghXvZ+YcbFztABFWEP5QB24mT/LpRT5i?=
 =?us-ascii?Q?D/uL3csP6XWB8So/wTBwsdxFaRvPZJP7HJrNdNGANKipMlR5b0gIsH9wW7Kg?=
 =?us-ascii?Q?dru2Bo6Xd4nl9y7hgN5B/9o+L7Lc0pxKzcfPxKUvEdQ8gRAHTwzbhrtZDTPc?=
 =?us-ascii?Q?lLNfLIc+ZMDznFQgcBclgsiNjvId0qIabKT3tgcpfEAHBGrw5OHvfdirlvVT?=
 =?us-ascii?Q?yC1cg3Y3iTNwRJsfng/y9D65l3jn/uMdX6TvWrD3MP5tsuM68rdI/MKTo9rN?=
 =?us-ascii?Q?8w93zAN+QBDJeZYdY4kmuYC4g0KIpFdmFNZUntwxfb/3SD0ADP6gG0WfJ9B5?=
 =?us-ascii?Q?ot/WdP1sJXGKB3dgKI2mP4roHPeh5CRI+wDfBCDnapvm5KzZBpG6e/dm+aZ3?=
 =?us-ascii?Q?wQfVxMkum1HCJgKwsbSEnkPDkmdCNqJpSBxWQWUAGdo55fB7tnlGgz7nsStC?=
 =?us-ascii?Q?dkvJYdRzX/T0sY+TGzLwsPiYphn//bheknFOzJPmC95ZtGgNvA9UFMHtmLV4?=
 =?us-ascii?Q?QprijlSe61rJBhlru1M+LSMztoR3RLy+iWaOpjA5yHMFGpH5sVSBQquqwhbp?=
 =?us-ascii?Q?Vl5fRkGtGMWizIAJxBRrMUH2IyjD91O02R1Atjacpg52sIK9cu3a5SCFkFYw?=
 =?us-ascii?Q?U/yd6pCJi5GNZco8gmaJW1GsG8ayNIbU3jWRZow+c2L1VTS+QaXNOGM0wLn4?=
 =?us-ascii?Q?gm0VFuZDSQKbMAj+e2oaw2yBk82I8tgw?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ar9jhTD6OYm4Xgd4Tlc7Wd8ZlJpa9VG+zLINA7WwlWGgBtNG5eA6tCANG0xR?=
 =?us-ascii?Q?EasrIX/HZZ0x69UQIXTgnteg8VH20bkpo8HUWmBmFeFR5jGAv0ixiOn+yrOm?=
 =?us-ascii?Q?EfbiZESF5raRQcAy7sc8AKd3A60JQqztHyZqZqyNQ3FSawfD2I+SLxA7Avi7?=
 =?us-ascii?Q?sfN8HwJdR0BAIIGt904gIMR74p2X/4pWxiSB3+fYykScc8VYph1BfafItiW3?=
 =?us-ascii?Q?NEnHn0PblQOR9PJPG1S9lmTJZvHw9FYks4dmAtx4C0MVrgfE9Vc1P6QFelaE?=
 =?us-ascii?Q?/iUf/ijj6ugiBLDxP08cD9iazcsrCdN3x1FHADMYvNddkJhOQs2t4H2lUsdF?=
 =?us-ascii?Q?ZUdMxuWIlL4pyZYEUdwOyvuJZ5ghB9ujcKfq723+CSu35zfrlmKA8FR7Usk8?=
 =?us-ascii?Q?xq3kyL4rt9NSsA+GtiRregIYYNxG7sAKXwVyVTGfLAdF39ymA6q8Qykq48qb?=
 =?us-ascii?Q?LmL4iEbNAkzpexADy2rlELgvVVSqBqs18qVGWAEJxO6dqmQRxLB5vKiCx9MP?=
 =?us-ascii?Q?BZKxr3NqtekyoHAMgE6kZ585S28xXuKcmQT7FPD5tDv6dzG2no26jfOtYoja?=
 =?us-ascii?Q?AcLbMdNBKAfxu3vEk/93pUvwuIGJ/kKuYmMssnVpbupolNtFS9TcWSCishTS?=
 =?us-ascii?Q?gJyrJTpVtyhAYijJc7jNb+peMFizUJj5u1e5nXNIxhiDbeGmPiWFCwM4BHCq?=
 =?us-ascii?Q?F8H4eaZpDO9713fmAChh89EnFu9VHLUriAx/0hY+OyabDeg4yiR7zx7r8tvl?=
 =?us-ascii?Q?aOsNiOWjoize5x/l/tYrcRZc70ih3jrvenh8j4UT18nVNpS3lTwbxiwjfYxp?=
 =?us-ascii?Q?NAV7I1J2AkQLN4PYAcuk9Y1Nmla5wdVTAEf3GCygway7YKriDCNhVbPEP0+u?=
 =?us-ascii?Q?1fxTp1bLITwOyfBTkS3jXK1fOeEiqmnQxQ9gUyrpP8fYJvIhIEGI6rBFz3RS?=
 =?us-ascii?Q?5mwd/v/C1gTdnzZvQxzVSWfiNw7aGqSERLx8cbJCPJDyijfV2rLgxQjYcP7Q?=
 =?us-ascii?Q?PfkyrG9P36pyEKG7YkHxII2CFOVBRckD+lVrXraEEaBdp4+30jc7TeedP1h9?=
 =?us-ascii?Q?g+LNE2sFPZJZZ9H7wQil3RD6P6HEgJ6seHos1Ekox3pfsR83OiEch4yXevJ2?=
 =?us-ascii?Q?FIu5K6I5tmygC20KLEtZgQJPaqBwzYp4gP6u0i3X5+JwhXw7EOcplBsq/+kQ?=
 =?us-ascii?Q?EOtMaQSQJKhHk6nWyNKKsabaV/6NPW0Kz/XZKaYbeIHabasHfbKEmvI5J3nC?=
 =?us-ascii?Q?FVWYc7zzoDY44KDkSZ1f3plTJ+D0SKuCTgqnab4yMYWCfnjo1nJwp2U1exgW?=
 =?us-ascii?Q?zt19TYkHM92dlPiR6j568PlkevCqma5n6V+ed0I0JC+sOaZqHLwdYQgno9/E?=
 =?us-ascii?Q?hpBaIUimcc+VfgeJ7qVbuJCzaFQ+Kv6Zj2MWnKsIq434gzdSrodbGC+WYISc?=
 =?us-ascii?Q?p8Thg1NxO4QekIaY0kxzuwHUizvoIfcATCUL1aMOu7/LlphTP+ykQmZZktST?=
 =?us-ascii?Q?8H8s2YGGR/RNHc6kOLepH+POqorfGLOiPB7c6+nMtQeJkb0riSDBVAdpsRYJ?=
 =?us-ascii?Q?jsOgYhUhuB+rMg6qN4Hf+dAhOqqXvQskG/Z/ezM7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6af7d3e-8fd2-49a8-c845-08dd4fdc1996
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 05:21:29.6605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w54gQqwZGf868d/3eECNI9c96v6oRlSJoSQ9wHZ5OTPqNtq3VqMCfxxOGhVe8yJtR2Jrtsdz5EGVW0MNwCnV2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6142
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 25, 2025 8:31 AM
>=20
> Aside from the IOPF framework, iommufd provides an additional pathway to
> report hardware events, via the vEVENTQ of vIOMMU infrastructure.
>=20
> Define an iommu_vevent_arm_smmuv3 uAPI structure, and report stage-1
> events
> in the threaded IRQ handler.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

