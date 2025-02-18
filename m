Return-Path: <linux-kselftest+bounces-26831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B07A3927E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 06:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DDF3B3764
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 05:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08961ABEC1;
	Tue, 18 Feb 2025 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRLrqNE3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168681B042A;
	Tue, 18 Feb 2025 05:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739855798; cv=fail; b=GV8oAdtTNQM2TkO0SzhjyIBLwP/OPxLArlikxLUEdDistDnI4EAWj/APX0d5DN/fRoYitr7BBIx7mqT2RvfXDeyLmD8bUzLlvyzYtL+04HUM0Jk/OQE6bn5P3vgA4k9MDLOFT0a+ZcGbkVDWXh7x5qInUyAnDTBhe7CZFG3h0C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739855798; c=relaxed/simple;
	bh=H9RBV+U/PONFyoFaBtOc18wHbagy3CmRxQJU1IVgb1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ar0DObMHeZnh3ZuXKWIvDUIMVzuz9cNieyyF9Jumem0nvDegwuwoqdg/nl+5Cangx7vxEc2O65Gv/fPzNUD9bce3AWFm8abunXKbF/MOEDxu5A5T8Y9PauGp+o1m6Xj/xFFjXDB0en33YEYrypgnfDKlvRyjavFsTFfhJk7NpNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRLrqNE3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739855797; x=1771391797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H9RBV+U/PONFyoFaBtOc18wHbagy3CmRxQJU1IVgb1k=;
  b=LRLrqNE3PuLLXHe50w+9SRi0QJJ71CLLvG4gXrNj6mcH/CLuBlXCej4b
   bXLrG++D/7yw+f7FE58P75UQOmGfH6cbrp7R6oiCyd4WZbOhPYsb2jFxj
   07Po6z9Fbnw5VK+KzqOg0WP95q+gC11DiNhMpVxjCsqz05Nc+ggpLO/el
   D84prszA6VJmco51QuxOFecr24o7pWZoF8MLQcJzY0sstWSlYdljgeaj0
   gGjKhJaQUhl4uQyCBiuH0t7bi674WxVNz5DfbDApaBRoOudRf58dDlauf
   7rfmmCJO+E06ltX8CtM+Dl1hkQ3ahgWyMkbjWm9Qh5Bk9mXtHWtYGZL6s
   Q==;
X-CSE-ConnectionGUID: 1Qtl3TICRn2YY3qUrFd9Qw==
X-CSE-MsgGUID: Q/fd4il0RjK+v+mbbwQaRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40795448"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="40795448"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:16:37 -0800
X-CSE-ConnectionGUID: 0MURQLzJR3q3+uvVrgNi1g==
X-CSE-MsgGUID: xZ+vkxKcSWyWyMk/qrtc1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114036921"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:16:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 21:16:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 21:16:35 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 21:16:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKTPC8QvKuOYAhjNbYU5HISBxhUDhL5ZMt2ipqdQJQT+mhanA7uqqzOjDWqDc6oaFw4sFjiuw+1JlzNXDaAY6wv3/dINpzwm+HGe3Gpr4lDXyzPl4ThwG7887nO3wkT27ViR1nyXkbRupdTEMcX+3qnALh/AWsRd7pSO9IcYxI3QiQLzDqBaQbNoTBymtc+dQe8j/37BMDmyXfx9B6RulOpMXBYgN03V/sp77xQHTNW3nNAjIwIyHXaIPlDW7al0DW7hn/doO74LSaP/zXm7/gWCpBURMTCplx0Z5+zJHz6wMqKAgWsRl1lhtwcYpBiQj5g4VJZ/rVdyMd36FLfkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9RBV+U/PONFyoFaBtOc18wHbagy3CmRxQJU1IVgb1k=;
 b=byrKBkeJHo5lIyzJI1R27YFX2PaVQaKSB+U4jNGlGIfq0Hnj0N4hMIgDt0EyxzV26jMsJzg//UfnrX4vyGvW+l16HR7t3tjxO8bbR7Ed3/4e5drASTXm/s0sUIIXQuXzvpt8cPi5nbXbdlBc6st2QnHfbe+Nz1fT+HscJVLR61EuBhv1O7wFODkmEnFBwtnCCzNNykwENvTX+1BkJ7SEdurZTAO9tmz0Nb1aXDA2ALrXovnteEAXYVJHrBDO383Z/nPilmvZILikcuB8WALlC4N5iKFNd0A+sjDzfL9esDxs66rwv6x2ptZXfen9e6ArcJcVE4HslhMVnqhqljKLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 05:16:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 05:16:06 +0000
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
Subject: RE: [PATCH v6 09/14] iommufd/selftest: Add
 IOMMU_TEST_OP_TRIGGER_VEVENT for vEVENTQ coverage
Thread-Topic: [PATCH v6 09/14] iommufd/selftest: Add
 IOMMU_TEST_OP_TRIGGER_VEVENT for vEVENTQ coverage
Thread-Index: AQHbbsB/amja5T9a/U6QfuaXbWiGS7NMqtLA
Date: Tue, 18 Feb 2025 05:16:06 +0000
Message-ID: <BN9PR11MB5276AA0F3558234591CF52D88CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <0f5250dc0fd17234cce91d45a869c4f8dbace56e.1737754129.git.nicolinc@nvidia.com>
In-Reply-To: <0f5250dc0fd17234cce91d45a869c4f8dbace56e.1737754129.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7015:EE_
x-ms-office365-filtering-correlation-id: 301e1a3e-5028-4657-b6d8-08dd4fdb58d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZaH4Co1HFrCE3oyymbQhiplwQrSBjcsEER+j+31qV3n6VSbLyP5RwZIe1Kyo?=
 =?us-ascii?Q?86Z0b28205eJgeXNqCkDccNJw2lc95EGa0uUkKSgHR6MI91qLcDd/dpxTuyS?=
 =?us-ascii?Q?x+gDt+W5qfTgkVaaYGxWnyIxFyUIN88L13/7OZmEqkXdgB+cDH+4JSENshZg?=
 =?us-ascii?Q?FITT2yu2Fjcf1DiyhJ3esSKmCF1rYRL2UOP7sbpiSSc/psV78LJS9PyuT5zc?=
 =?us-ascii?Q?pfRkMB1TYEa4wKa7g2BWF84tqMnpbDWbN2dcYtsWrV7DdU4+377K1+fIvmFd?=
 =?us-ascii?Q?UvA0vqzIaOsWbCTDhNJmnprgHrK71cFXbtyQNN1BDrMzJs/BkurxyK6OOjy+?=
 =?us-ascii?Q?r5YSo+0LRfJ9POFqXhhVPxOTiJnkT94lZDytpNOUMPCSlAo/ZG9nRAwEz+mu?=
 =?us-ascii?Q?df20X6+zOhjcqoJD0mSa2+eY6IwD5xlj7xlzFjXtQdOCVREAkqRp+LMW+kf2?=
 =?us-ascii?Q?yaV1n6ewY918mmqQWVcsztcY1DcKHZe2JW22m1kWtDi6ihxwytvS7VlVkji+?=
 =?us-ascii?Q?BQurit+fiUGSLzIHq+4PZwMBVQxPGtUe8pjXr+TghhK1dh0epIcf7+LAVGFc?=
 =?us-ascii?Q?7rOSuy9A0cCYmh3IrWfPlRoHOlK9TVAN7s79Hum/yhk4PWvr3PGgsM8H/lO8?=
 =?us-ascii?Q?AeI43caeys/7B3Dfcwve53BWStZF2hCUQlsFMcwhfvHpA1/eJjC3yckVNut+?=
 =?us-ascii?Q?s8LviDLGiK8IAVYl34Dau8OM6Npg6woqNLI/CNLXvog/nrPyoTabBjGPn0vx?=
 =?us-ascii?Q?0okIwXStmOrHq5JrwrVKVpPyZhi3VJBmMki+Mwz4ggqT5WjZbuGTIbCRUtrR?=
 =?us-ascii?Q?bT3LfZ+qd9pck6QsZV1dbPBud7viqG4diFeJUYO1JNiknIjbA1NgVAYiLUdD?=
 =?us-ascii?Q?xkVmjPUBGM/NlvxT1bmbQYo+l0q+/YFQ6XrV+9C7vyiYnxccbFx2cvQmLscb?=
 =?us-ascii?Q?v3tSzxfCmlpQWEKD0DvMdWCIj1MhoUfx/ncNmARxUFFi2jaaZpN5b37c1Pmz?=
 =?us-ascii?Q?7yRDubK5EXaH2cjpIT9hJPXbRj6ykS9I/v0f9z7DvGHvj3Pmme2PYXwI772g?=
 =?us-ascii?Q?pkWFTKfGqteGtYVDJaRXgDbsLTQqiIzjEa+c828vMcW2O7kuk6FmN2lTLEUk?=
 =?us-ascii?Q?DsWM+ef+47NV4jEdxS57R6BOELkhwfFFErGhfoFY9JxPh3n21/eW2R1GZ3MM?=
 =?us-ascii?Q?v/31uMx7Jfo78h4dDQ+ahkhyRUgwOtvXCiGErwiOnH1RFSSKtykr86hLY5lq?=
 =?us-ascii?Q?4ZaqLxYTMr49oCmDY2J3e/kPgMCYqVww3I09SKja37VU1dG7/mHhSsr7kibE?=
 =?us-ascii?Q?7IGHq2LB5A6l1IS6H+wH5w4UWUbtMCVMZy/SkWiV8BPGx1GB+RhKiwVfWhV0?=
 =?us-ascii?Q?gkGK53ylu9Ql25y7wqyPyn3oBm8X2BG+i5v2VNdKIs/qjIusF3PFejynETaT?=
 =?us-ascii?Q?ZRa/JdCg+wqAK90tmVlqOY7LQvL5M2lB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NDepQwWzMSBn0Y8nrdZjp0cxsgVGKOy7qT9lI7rGkU85NCr618YRMRmzktA6?=
 =?us-ascii?Q?DJKg30ZUKXkjQSqWUNkPSL9IYmqhkvbVG1rx+KFykgbaB+OIFmyD55m4mRc3?=
 =?us-ascii?Q?valYwNXJhBRbBVkKuhlCuBQoQ9bF0oBjaJPtvjZq/zxLKOEVj6e5xkuuBS8I?=
 =?us-ascii?Q?jHYeXB7J4OS0rt8Nak/HBGrMpTBOgnts0S/fRbLpLgxEqvJwJG3tzSzFm736?=
 =?us-ascii?Q?hFHyVotd+Tdnw+6oy7r+1D6M9kJu5mfika9hluY7/JHkexHEyZvi07tdCUK5?=
 =?us-ascii?Q?ih8hfLrYu0EgvEKGpek1knGgrTNIjBddnuaPzFmWFaVcuBpfiSznlq2l4s4R?=
 =?us-ascii?Q?DiyJOWrKBY3gD3QzQHA3BL3KeqCaoFM5d1hWqCgECBl3ULF+B4SJw5wyYyLJ?=
 =?us-ascii?Q?Ol7ly33fsJocA+fW/o2lqduedksYDUTavOsBOoPVPD97dzVEqA6id3gt90Ib?=
 =?us-ascii?Q?MgdMvb64416g0k9lg/alL3oB/kAXScK43XtFkH4ZNCTdg0HOIPsY9caMUnYG?=
 =?us-ascii?Q?vSc2et66Qh5TDMmjApkRuGFRLYBarJXqUvxwzeShlIkp7CsmshTOmP9xffbs?=
 =?us-ascii?Q?3GpnHc55NzPeADGByG/exvSaQKVLtAoRNKBFQRzgWhvyr+8I405iOA9m4PkY?=
 =?us-ascii?Q?kaLdv0MQkaKE2CXoPgIHmNnVJFLTFPtxMQd9GLIo8DxcnJp2sjqY/0y1cXz/?=
 =?us-ascii?Q?3BZXJUUhRiBpx9CEDgFbsu8hX+OfbYDK5ZLIwOGRAUXJdgtuYZJFeMdA7DjX?=
 =?us-ascii?Q?rShCRnp6UpGo+Wefkr8sa1zvKz77SgCtGUFPkEUJ9ypZbr+RGj+Zru3yGQYU?=
 =?us-ascii?Q?hSqquQJznidZFmx/27R//Mnt47URdhhyglAmR8aeDeJwL8GlFTlW/GtHdw55?=
 =?us-ascii?Q?0suPWl4XlZzPhuYrf1ofAQt6yRWGtwL326BD4TgohYfyvmnrVjpPpdrXFyAt?=
 =?us-ascii?Q?VG0AnkmJso6jm/kkYe33nJzY40hqKvVFrfLPHVMh0uhM1fpFR6HCdE86yeBc?=
 =?us-ascii?Q?Ifhoj/7ELr8mMK87EOo8Ns+MCSeWdmwPIWnwBqL5WzT+MIFa4ENb+NxAc7YO?=
 =?us-ascii?Q?kYyaCqyXKvGvQU3tBIjgMeS+7V39wHLvIemD6lwqXqqgj6GPD93R0lDV0LSP?=
 =?us-ascii?Q?qBKwmTtxZz3a/1kUN+4kQN5IZy+buQPTWQqmBtR3u0hSpoeRBRmsghDYgHOo?=
 =?us-ascii?Q?UzvSZlX93A/3nNOJUiWp7hPwxPbZUG0SsG7xh/vbqcvprGra2KjVKlaPIMUX?=
 =?us-ascii?Q?q5NuVW8Sg6pavR5OHeMlgUpYL+CdbZjGRV+evxeKblX5JWWG76O/M0NDtEBc?=
 =?us-ascii?Q?PlWZi9Dx2r/DmHpxV+OR4V4jrWARNsanWdDPIgRvaaFoO4gbnK1IRdioPenP?=
 =?us-ascii?Q?hzeGx2MOSuk9yaU/9J8ZtjSByKyqTG5WifJI1sa1Kye5B2CB2/RpG+7RUqIn?=
 =?us-ascii?Q?UGPI0khhyD3fBeauooxFaq4KNaHzDwYqscy7ob71BXiyB47x2Bvr3vDSfqjz?=
 =?us-ascii?Q?BaoCIBRER8IHDLl53RSRrLaNIjikaUXq7jBn4t/O1JNd1U0jDuqqFYWczK23?=
 =?us-ascii?Q?r2Neh3v4D0+3w/Dd0eV5KNkl40aN7qkYkVk3TdaX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 301e1a3e-5028-4657-b6d8-08dd4fdb58d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 05:16:06.3175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svdU1xm4kXLMEhv2LSMQ2T2x8Aglm/Y3rBIYb1ZBj8hSFHYYqPRczLEtaWcgr4n55qfNuDsPXLdcEPGLEiP6hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 25, 2025 8:31 AM
>=20
> The handler will get vDEVICE object from the given mdev and convert it to
> its per-vIOMMU virtual ID to mimic a real IOMMU driver.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

