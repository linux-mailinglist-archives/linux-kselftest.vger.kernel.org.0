Return-Path: <linux-kselftest+bounces-32497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DACAABF5F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 11:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43F03A5F95
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC79265CDE;
	Tue,  6 May 2025 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D18fYOmb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB51262804;
	Tue,  6 May 2025 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523583; cv=fail; b=G4LvwE1DkXa0jrVfyFpkVC3LpH3+2LjoX6fr5SaDyV3VfruiH//dlorALnJ5F+AgZ2TVQe5xQFzSHMQ8uYdyqIGRvJXgX3ZbtGSR2+OdjF1ujqRIcBrexF9EhMDv0j8U412OkoFP526PzFCXxNNuH2LLGLVbGQN6wjF8p1GEOVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523583; c=relaxed/simple;
	bh=G2PKwI6jJp9M2RwBcVBqVtdKSy7ZKQicFF5sZIxr4Wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i2KKN9b9RkIGYUIjddFB4tMu8IDutFyTpkOixNTJnfW8IhjwPNwBhGn2Fos9qVyRtUZY+1r7jyVd/9vU31GynA20WkQcoWpnksq+16R5j/Abykd8JuyqQYVDwYjt06NLavpG3ALMMbWPOXcxH5qtlKBOFpLLl5QcgYc1xDOXpkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D18fYOmb; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746523582; x=1778059582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G2PKwI6jJp9M2RwBcVBqVtdKSy7ZKQicFF5sZIxr4Wk=;
  b=D18fYOmbJtUwWPuEMeFM2K/+MLPfo0P4vgGMt1LhMg75I2Yp7T35GrkR
   5GvNfFoxF+lcM82varVpOCklQEZPkeuEFt2R6Pthnaqv8ElUToSH3hHs5
   LO9WWQeGcyh76w2jbXQr5BDrOQ2Yg21U/GXvPLcvlqmnTDesPStOkNKxF
   HI4eIzoED8fd3af3EcNL7xCIZYsDMAjkiQJ6cxOZF2gbqfuVJyy/5i+qK
   OhCa46+w0wJlyPpPg0ktYH5auPiLCg+gcQWMClptxdVz0pP9wo1O9Ts8R
   MpPiErWjNrVfczPfHwbIqM0s5BejOizjYyH8O5aS53XUzLhMITDMfq+iC
   g==;
X-CSE-ConnectionGUID: 7xWInw82Qnu3vRzz4yZzsw==
X-CSE-MsgGUID: Xns+U2T7QYqXzM2zMDxZsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="48262949"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="48262949"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 02:26:09 -0700
X-CSE-ConnectionGUID: IZB6buFjQ6+f2oAnUvOA4g==
X-CSE-MsgGUID: MxS3uv6mT8SUSy8y/4RdOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="140741626"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 02:26:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 02:26:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 02:26:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 02:26:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmlFm2b5rqRqU5v08QufSRTF5kiho41kUZnxajyBu/xifxnApB7y1r5+C71ubWCU8QKvD/njDI/pUtYVROItdTuyObkmBC6ldIea40qAZ+KHbe31lbspAMFLDcNBh7FcjIX3Evm6GVGsIH051/xU8JSgsWRy6FbLpGWEx7/ULqCBWua8yk/NAP4NTE30TnSRon2kUY8M9xkE1o0DvUVAFF/CYhRM2ujf28b+G7cHFIuaNVZzaBvR27OQO+gebWo8905YKafz5rc+gNJ2PaEHt3kVr5tJDI05ucDqBM4LFzt8OcUASVol5N3J4U4YKGsiHfs4s9S8gAIGNwRS7Iq22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1GQ51dF+sL24hfe+KZmNVaw/lUx2ELX3cHrt3FOPfg=;
 b=cW4QtPE7GasekqjeksigHDCLQoOe53QUp+T9SdyfQhSrwLL1JtcqyHJjHU79jNajJRqwrUAEl+b42KvHK4N6bQAyYCBNO4adBt5eoHbd0e1qK0DqoRB4WlgCH/NqD9DMpLKsR/e8/oDoz4lBp3TQhsT3sAojJ+OTW+hdWkbwc+PEyorCbY4tUZdmYWT/Mbt34aVf81hIWTJ4B4MKVpVacvyQdjfYc8FsgqBZVXVoRqwY9Nu6xWtnS+GSI1J500/hJLMXq7bgwgdAxD2m0h6/fTbtZvBs5rcqOkDPwgT/WXgOMoMZ5IMsFTmRir061g1/TJLXqupnjkp4/naBsDLMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH3PPF740777B0C.namprd11.prod.outlook.com (2603:10b6:518:1::d2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 09:25:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 09:25:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	Vasant Hegde <vasant.hegde@amd.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
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
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Thread-Topic: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Thread-Index: AQHbtnBgWiXEiZpdnkyUfZOQGgZNUrO5ALyAgACDQoCAAJ/GAIAAE+cAgAA8wwCAAHMKgIAKfNsg
Date: Tue, 6 May 2025 09:25:59 +0000
Message-ID: <BN9PR11MB5276A00FDB2685B394FB9D4D8C892@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
 <aA/exylmYJhIhEVL@Asurada-Nvidia>
 <b8338b47-6fbf-44ac-9b99-3555997c9f36@amd.com>
 <aBB1gLfahnLmn0N1@Asurada-Nvidia>
 <a3860aed-5b6b-4e68-a8fd-1a6ee28ba022@amd.com>
 <aBEI+T7P+hV8Y6tU@Asurada-Nvidia>
In-Reply-To: <aBEI+T7P+hV8Y6tU@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH3PPF740777B0C:EE_
x-ms-office365-filtering-correlation-id: 91678bd2-f11e-4db8-ef7f-08dd8c80035b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?S2ALM/agTlKccCwiLiBgU1kEyl3bGFxU1VrYtUW4U9+SgiKpSe4aIxrWkvu4?=
 =?us-ascii?Q?r3E/lVc2Ti3qX+MutgZKkAevMLMFoO5hoYVnpfwp5VeBa+eSLOTHxiWcZuNk?=
 =?us-ascii?Q?PuWA1iSp6DwbN1vYj4y2xO0sRVEMi1nvJaxdGFGAuwlTHmf+qOnsrJ0ae8xO?=
 =?us-ascii?Q?ZLYiNp3PpcQ2nY+MUu2vR7xY3jBRinEUPuoE+EBzJwg7c3bmSF/iGDIofZ0I?=
 =?us-ascii?Q?jYSvI2jerQWu3VpLmmJ/hMG7e396lBR+wUZAH6HikfUHfYLpPxqxDXNCqd8i?=
 =?us-ascii?Q?eyOvV/vKejcdjuKQ9coWN89Iww5cTsgnUACoHcBT4tIetnFWBQ3LoOpU9XPX?=
 =?us-ascii?Q?0AsDw0vyshNbTYAXMU7XqgrtVxYH1qn5FV3Nc6ZUO5nj2/Kr4lLC3262T28H?=
 =?us-ascii?Q?1cNJMLZBq/ic8EdasT7nBJLs8rfmLBvIDIuzqfzXTEM8HtFCCWnGyiKg+DvM?=
 =?us-ascii?Q?P3vxb00TUccdzpsvoNvg9KUgi0dK38Bt6J/u9zXFRgNI7IyQ4xfzq7wq8XAi?=
 =?us-ascii?Q?e3tQdnSWBb8pvI7XYBrVvvXpxy0CSyCemVb/aLuat4hfC1SGs9SQFQBcFj/F?=
 =?us-ascii?Q?xTCkYjaY4bbUQ/aLcQqgq3keIhR0/BLR4Rv32hi3v2wDZ/umtbtz6teEhVEL?=
 =?us-ascii?Q?0fdOUjSwYSGq85ubxMXgb1JrTrtVkrC9+16KSW5mQZUwdCQHIuGSw3lRlCEe?=
 =?us-ascii?Q?e1g9s79VhincQQ+0Bfr/fjApo+0G22YpfRfHg/2oFJ2BSLQ0onkqbR6hK0KC?=
 =?us-ascii?Q?dSywinJ+S/xiJ62669LLOsM+9lyRrk7m8nMUjJqtwFBNqNCMSMKJMegfhmOg?=
 =?us-ascii?Q?z9vCMsWnRdnp1RU558Dbe/2XVVfdZKkRb2hPmsa34XGpRTHAuzx6Dy9xwxuj?=
 =?us-ascii?Q?pLhb0yC1Iud+ZiDocnNbnLHZ85JWTa336IaoeX3X2KkvJbKMl4gbPLdVmu8+?=
 =?us-ascii?Q?woP3MyDYFKXsyIduUxrdD+LrOW691nui4B1DI0gIBEpC+WEhZ+zlAW8arwVt?=
 =?us-ascii?Q?uvEoNgK721TxI5utsY3zZnZ5K0PBrq7+oFj/HHnsXjCSGwAt90LdGodlM6fI?=
 =?us-ascii?Q?Saz3ki2dqJd1GoqClFlRwki0wiE2rEpTBgK5sfG8mvoDE390gLx7Odh8KM6L?=
 =?us-ascii?Q?FzRmJL07iUMSqDfCMzbewat9FC7fw+y8nw/3PWpSG45VfTGIzeChW0mH6mvM?=
 =?us-ascii?Q?AuLircg+R1XdG34jTuMn9WSWxNLe7dDATxKAA/PQMmWyaWViCBuWoGoVHeFV?=
 =?us-ascii?Q?GKy9ADZUrx+Jce0pOUBW2T0+g1l7HB7UZdbjDGPfw+srtUfiXvkZwk/PrU3/?=
 =?us-ascii?Q?4c/Xc9WYG0DWrHUEgtw1rf2+82zM0hqzf+o6poyQmZdDEAQgHn0eZLN+t+VT?=
 =?us-ascii?Q?XdgYkpjxtSHl4JD2MD/C81YHcOLdMTVUjcEG+JO0XXhfXjKI6MZ105YeB+7Y?=
 =?us-ascii?Q?6JywS+7w6THhj9euJvRZCIDEFLCnWIy3ZXU12vxmRsUv8aG6Ka8x4Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wXO+IdG7I7rm4dUeemvymLCaQ4Z3E7WgA9CQFhsN8f3eiV9zWQtFhb3fvMfH?=
 =?us-ascii?Q?E0/qXLk0HY1bsAOI/k6AwMd7S04MhmUidqR7IlJex/Un0V4w7YR1V04WGMd3?=
 =?us-ascii?Q?PlVNpEpyOzde78st5V0vGAHzDE724Riuvi6wt9QKfCHFjZ1yTI33LaKTLERI?=
 =?us-ascii?Q?b6EaSTTR6LdJOUsJpMrgP0kXJAp1YHEa5de/Opw7mP28SggKJJgGzh0pwfDW?=
 =?us-ascii?Q?Vw4v2XXeT9NVGWjBNVGVJVdI6mg16cbOm0RvyONem5ccfWRnKGkCzM3tV/ts?=
 =?us-ascii?Q?il03+3Qa99mL8f5wf3Hv/LhP3ReEZvjONx7tPIrnB5nHTPQwfIhwTZjjl+lF?=
 =?us-ascii?Q?Sm1RNRcZo7Svv9lDSoXuB8PyInWQbrlfi7pUdjU+mRhMJQSQQHgY+MhrG83F?=
 =?us-ascii?Q?ueERncawZGEE9dtBfj9U+KTMQWabqA4jv6Qtu8/CgQVfvCQXgx4JyZtm/FgU?=
 =?us-ascii?Q?jJzgW2caSzGAyMEXg8v+egGguzZqHA/3lnF6ontF5kHccwEXp6uCTfAS6bt1?=
 =?us-ascii?Q?96/+8YCfHFNUNTmafDaD3t8J83nlKaF2NfREfENGek/gsTmcZg6W9G29624Z?=
 =?us-ascii?Q?pGXSdVf1lXg4bxuLS5YLJj7q4F7W+jj/n7JjfT0UXg2TXhfexWltOTiIEAjx?=
 =?us-ascii?Q?rE/iS/5QPxtV2oqnIqtsdmhFNzNy6cgvJPrkd2PIB9GZcK5bJPWvWIajbo7U?=
 =?us-ascii?Q?AV8Sz7Cilus32KGAlOf8fm8T8roOVIPXckTeYba63cUQJINJhSS686uWHaOD?=
 =?us-ascii?Q?H775iYvDC5XuV3d912W9r1QTYCfz8a8ETk6rFYule5BKv8+76plH9KqotdOn?=
 =?us-ascii?Q?N3vNZI8B6PhabUc/XgaSYbV7N6Z/6Bux6IiFuKyByV9mJGd4UBfU3V1xNx+3?=
 =?us-ascii?Q?kRwWVpksFOfmIl4juvuv4nlMHSDdZ8oYVQaR2aIrjvUcV8Yq3+S+H2Pae9dL?=
 =?us-ascii?Q?LmTNIQA2OAj/5u2NmPnzFgJGRHk1wr2W1DogrfhcCVPx9u/7p31a5EqEo5IU?=
 =?us-ascii?Q?mJviy57BnlczpsewWqR04K/3YYrM4Z4Ek2eqZ60VnLJ19FZ8nM2IZjt2Xenu?=
 =?us-ascii?Q?YpHDEIl1CSN6MDyhbSE8j1OcHyYVFqInzB9RPN2Msdyi5UiCO37mI+AEjNQv?=
 =?us-ascii?Q?C4jMHZdeyjwLovT8DEtT8XhlMT/doQlFAWCIQee5VMHI5YeWoTp5T5xYebh8?=
 =?us-ascii?Q?NhGdvq7QZsxHzvL9bw8k2HyNSAVi37gslpPB0Bs/T5ZN8Y3coi66Kkzp6uL9?=
 =?us-ascii?Q?IITLyo7NbbP+pPPru744mmwBlH1dbAkxAvDiGzVYwPBpEqtxEoe0AgWPBW65?=
 =?us-ascii?Q?HDoDEDVJToF9TKHeSUkTcNyFt2yhWslsPPHNrh+dW4UnYjq9eU9G7129m8Og?=
 =?us-ascii?Q?q1Nmua0P7VGwalKQ8YAgov+oHHS3QZk5YfN9kip0Z5klEiIlsbaSkLbx1XVO?=
 =?us-ascii?Q?dLQAdNj0wZ8XRKkJ2NBQCLJPK+8e80Xq/82lShw9IsMdQkSjFniBsoQSO5B3?=
 =?us-ascii?Q?KVfuAYTONbdawTCQhZZoxMwRBQz1uq62VpzfwKfUY+Eb61jtH+fiw6RvwExI?=
 =?us-ascii?Q?SGbbvMVDKtuGh3b3UYmwKWU2tD+SAQD9eqvy63No?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 91678bd2-f11e-4db8-ef7f-08dd8c80035b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 09:25:59.6086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCpJWYOy3H8v73PAtQXP69EgPn8AS0kmoglBlY1M0/iQZsIjiKz9WTkUleuHnUb7Y/5ic8WeERvm+d/p1T3qGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF740777B0C
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, April 30, 2025 1:15 AM
>=20
> On Tue, Apr 29, 2025 at 03:52:48PM +0530, Vasant Hegde wrote:
> > On 4/29/2025 12:15 PM, Nicolin Chen wrote:
> > > On Tue, Apr 29, 2025 at 11:04:06AM +0530, Vasant Hegde wrote:
> > >
> > > Will the hardware replace the physical device ID in the event with
> > > the virtual device ID when injecting the event to a guest event/PPR
> > > queue?
> > > If so, yea, I think you can define them separately using the> vCMDQ
> > infrastructures:
> > >  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_CMDBUF
> > >  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_EVENTLOG
> > >  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_PPRLOG
> > > (@Kevin @Jason Hmm, in this case we might want to revert the naming
> > >  "vCMDQ" back to "vQEUEUE", once Vasant confirms.)
>=20
> I think I should rename IOMMUFD_OBJ_VCMDQ back to
> IOMMUFD_OBJ_VQUEUE
> since the same object fits three types of queue now in the AMD case.
>=20
> Or any better naming suggestion?
>=20

What about IOMMUFD_OBJ_HQUEUE to differentiate from other
pure software queue structs? 'H" stands for direct hw access to
the queue object.

