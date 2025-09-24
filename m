Return-Path: <linux-kselftest+bounces-42172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E21B9912D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 11:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37036166478
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695202D6630;
	Wed, 24 Sep 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5ihPtxT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494A2367AD;
	Wed, 24 Sep 2025 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705696; cv=fail; b=EcNW5l0TUZPgSBR57zVscONpkar8F0dXnPd5BmqyEcoit4lE15EkVKUQXAFmiQK0fOw1NK9GLCdaJAOlpMPDlAA3++JcFjwuYrnWvKPlYanwa5vHE960bouGHuwyu2TUmIylzVI2lxjtyztg5JRCXSRKpm3Of1SRj9rHMB0PNxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705696; c=relaxed/simple;
	bh=VePJFQSoiZaL5FC6BNkmMsyQzWB67r0A99bf0xrL0Y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cur2UcTA2phjqx6frc3hFX2NyJ+hVfE+f+35DF6CtVJhTokZtl7l0K8RkVeK0SzMbzFOaD2/H6rd5RN4jUoCdcpV497YUNQ3haFw0qvGqnmjyrLI01AzU5ovZ0YaVOL8w/wTlubOCofEU/Xj26H0QzaG4UCPCotzWHdJ3PbpV/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5ihPtxT; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758705691; x=1790241691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VePJFQSoiZaL5FC6BNkmMsyQzWB67r0A99bf0xrL0Y8=;
  b=I5ihPtxTsFZUcwFRqu01qBPoQMucKjJodrluQvsD5erhxZd4v+X2HS1q
   G1/snv2792hrLTzcGYKIAujaWT7TK8XsKM3rsVwhPkVJvGoXrD+2tWQu1
   /suVjHobhOjUICBatayGySbODPupS4DA5o0HBo6tlCa9TSgV1j1DfR1tm
   zadMvrgvGs6mnI5pz/wgaPuh0wg/616N27y+Oe7cUIpWSpOkElls7Rmhi
   A5ClNikrwjuRJ9rfmyDyq0mhs89mX2IQcsSrtcK2RtwC3lbRCbUZxz7V5
   HvmU0R0eec4/Uzste8Pgh3vy+hbCO6IMgH7AxAOVmua/ntuCX5WjP23HZ
   w==;
X-CSE-ConnectionGUID: +idFVvZZRoaoez/WBihLIQ==
X-CSE-MsgGUID: JaFwRMH6QrmEWHVdolfxZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60912402"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60912402"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 02:21:30 -0700
X-CSE-ConnectionGUID: Ep4E9g6vQ5iwS9uW8h1O4g==
X-CSE-MsgGUID: pd9lH6upRZeSnvHFzt75Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176113394"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 02:21:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 02:21:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 02:21:29 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 02:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjaIrC6E+iwYLpxk/H8P58w+zEHxgisH5AisvYL2IjNgfv7ezSi8ouBVeZix9dmUECYd5Yb2KWjMXoX2Ky1VUIt+KCvUH0VIOKRLGQM0VU4wZKKCCyXbuHI8RUcZ8+JGSIr/Fu1jEo5pgmZbM5oA//R07Zxk6ozPQUJ/06XiSeEOacSeyuieolsEFfzxOwGZqPNTxQwgRZ2Z9OE5w4smA8Kfwuqok6ReQieXhCAU9NGxZtBBAZcXOZ6Em/IjZUA8ni4LOe16y6gmAMs+2MBydO5MOP2t2MQDD4FaY7mOEAhO0BjjWr7kkIn3MHYBF37eJaZAx4+yruWtLicmt6EbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhAUzEemTVGTPOiJurakREEAmC128WNYVWcv8mYM0oE=;
 b=qaUm7bYKqGcRrKxPv743jsqzRFpQ2QJ/Y7/03s/WmM+q/Lr05/o0ysJm5DD1gLz/SyO9Yicr7sToH+Y/GIYFJoNRqPAEP4D7FeFMXw87uDj6fqL4GufgjitEMOAGpYh3DsxoCn3EGyN/ZsxkLwZLzu5ncfgEOLGoPqtEf/370JA9OpkJ11mpmMXOIBKKp/yzRfiFJHQ9rabFvGsPTwzs3iE183zSJYw7WfmklylLbnmW/WPmfMFEORoP3FiSHDxdQZW4snfwCIm6/7PH0wHDa6NzYeeCJmzosaa2QAbX+XKHRXxbQ6JLd/hKVPH7qmmjRd8xDHme2SOi4l+Jp7iyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7899.namprd11.prod.outlook.com (2603:10b6:930:7e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 09:21:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:21:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Justin Stitt
	<justinstitt@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, Bill Wendling <morbo@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 02/15] genpt: Add Documentation/ files
Thread-Topic: [PATCH v5 02/15] genpt: Add Documentation/ files
Thread-Index: AQHcHPrENDh9ui0pkE68VASwqwN+0LSYlseQgAIWbACAB4HUUA==
Date: Wed, 24 Sep 2025 09:21:26 +0000
Message-ID: <BN9PR11MB5276DF841B9274DCB2E6C5218C1CA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <2-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB52765D0FE4A9CCFA3F2D73208C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250919144210.GD2132010@nvidia.com>
In-Reply-To: <20250919144210.GD2132010@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7899:EE_
x-ms-office365-filtering-correlation-id: db575681-5d5f-4123-d575-08ddfb4bbcc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?xQVDxic4NpkSH6MATmwZe8d+iQt3KCrZr6YpeWOdD3Wl5AngY3rjBEc3IES5?=
 =?us-ascii?Q?PV8O8E8ZcluBtVLefoKDQQozW/H2xxEb4kf1dICQghnL4oBDZjL9odvPfUm4?=
 =?us-ascii?Q?KdNaHjJ1tLWqY23A/BsN04nd7T+mFfPK9Mwn48VDbbSbyawZchcTCf/9rKFj?=
 =?us-ascii?Q?vs2GH0YndhH97NtUPrAowamX2epYy7V6/nAkLjtjEq0br2qvO2WTZrUO+/yO?=
 =?us-ascii?Q?BKPOQDF2lfmB3fL4CDv0U/e3wrsmSdnogH6Grhb/CqEWkEXJc2TDVNpYtkmp?=
 =?us-ascii?Q?OfG2hRn8c4wQ5d43jbF4gbQyDJ0hJaAMtog1Wp12K6CIxHisNHksP45zaVWi?=
 =?us-ascii?Q?oc9KOhINiJDTsJ+dMAG2Mo9fOhxhe3/Sz4KnWap6CTjJd3CHZ5jJCrZwoASh?=
 =?us-ascii?Q?JmdW6vcIgpoKG252L/dAWn6KKpr7vNWjC2XKl4FES6qIQDyAVFrUS4nnxmWb?=
 =?us-ascii?Q?vjuDRaGsZEfRBlwDFpsVuN3bSjUzd3jQygKui8cjnq/2N/8hGNMpkWQkteoy?=
 =?us-ascii?Q?2J3UBognnliRqKUsAQoqNzevcKhB0DJzGin/svxY7dwLUnjvEuZrerVP0EDK?=
 =?us-ascii?Q?mrhuu11mCZJWhDzt6MqnqwmxWq+STDXFQ4hOXRF0pbw3AoeqQwgAbl7Kjaq1?=
 =?us-ascii?Q?HcCkwn5K+/Ll3LrnlBOTtH4wVmp2pW61SR7dXQz5LtYX8oARr/3eiWHbOYXV?=
 =?us-ascii?Q?xpwP7camAtg0Mr9cxl6t9q5MTU3Al3iyRbdDF7x7M/7Z0GbMIv/afc7wrv+K?=
 =?us-ascii?Q?NKqt6irJEZu/g8IIgmG4GjGkExLKwsMo5YPPaB+IDff2izul17VTVSCWg/As?=
 =?us-ascii?Q?DDK+ZZkGoxv+YdAJkJlq7+KkAXutMs6ezSSpgkoDDSUn5A1Dxjl+ihUTmDF2?=
 =?us-ascii?Q?hQXTd+zNqMhXjcyYJDMWXKtBzkQu13VuxU7FJ+WK7yciYD/ZArfuhX156fPB?=
 =?us-ascii?Q?6dDmGrpIp8HuyOKBkawT3c1Uo39skmVxUp0j3nuqZ9Ao5y6LyBwwP32t9A8e?=
 =?us-ascii?Q?jaqGJF2Gt1j3oxjneMTbWBbNcf6n0fxw0hz/RuEJ96p/e2KHwG9oP4JsVSH8?=
 =?us-ascii?Q?Isr4NWerL5LIaXZkqt3KL/7GgIvmeigzOAFjCP0+De4mmQWXhT/1nhOHwgkp?=
 =?us-ascii?Q?FEdR7ehb8m30MbpLyCJtkUBPRydVRVZHuR/MbUNl1MbCcLemga1JzPCBn0lx?=
 =?us-ascii?Q?9MFWF230SP9GK7Si+tzGaC4mIAEpKpVBHiciqXcohuryaZt9Pxr43K2CMu/w?=
 =?us-ascii?Q?krqOgVP4/VVdBtfailJJvEGwfEHzTnyfbabt3lxwWZ2CpsPBDle+K5bi8Wlo?=
 =?us-ascii?Q?WEXlcRjtg9D8HfDgrq0AyMRPgZm+UzeWDj8X0zggkgWcXO5KfTz1ijv5et3T?=
 =?us-ascii?Q?EKBViHPIXbK+kVRj29IQLkYCoMHlRq1NfL0ta0xDRESR+UuxD04h9eqgZXuD?=
 =?us-ascii?Q?2/ZPWPtUbmTk/SVtxp1tjRL3Ahmr2yGpZJYU/MRA9QgjHWPxu7cA9g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Shvodqblpk+Cc8PFbXNtQI1/1Auv7dGv2j+/EbJciyBEG7ZlWzzydnZcl8VW?=
 =?us-ascii?Q?VxFBm17Nurwd3ezWBOP7Kq6lGeD2MnpmeTXP/dj7qffZhruPjb849hqQ5J8Z?=
 =?us-ascii?Q?whLcJof2QR3aZfy+rBiTrGZ4b62mBJPJ5Q0Ro8Hf2IUylEh7FKKYSjtcECun?=
 =?us-ascii?Q?OoVpp5Ez0y/g/I8isKhh9w71L4dSF0+MUXsCCRPedxExL6MpH0UP1a51EF3X?=
 =?us-ascii?Q?E97mqYz5Ii1mFT2OALQa1PxzmbX8NjxAPwlQhc4sCW7NULShqO2NJW1ZhVNM?=
 =?us-ascii?Q?jody74CFSnBSoGvUdm9iMznuk/q/hMUhUtWKm2v46om3GIGWpP2kN0t1IRBu?=
 =?us-ascii?Q?tkCPAHGKvWEyv3xGvFVZB27W1gVEd/uezJEIHmZ6dP3NWDt//FDZgXwTTdum?=
 =?us-ascii?Q?65Lh43taVeqTD6CQ1hQMEkVnBVoF5yfOzN5Qw9l6MgKJ9Lq81N2M1DLRtiNc?=
 =?us-ascii?Q?ttJAR3pcWge0b9+DC+levIfjx8uPfOfAmSQj90mqLPM/3iCzVUoy19/QH/GF?=
 =?us-ascii?Q?UVtdr3XTqi6yYSMU7XNCCyu12tuZeemfKBcvNab49dqH8YhjniPU99y4GCQi?=
 =?us-ascii?Q?Q72AZfwy6ingASPi+p6trO/gUL++VBHhFT+MgKeAgJFyKCO7iDv3hY/+1Z4X?=
 =?us-ascii?Q?Zdbearwx7DjpKqFGfqLtDSpUPvgpmDa0eqdmC+7E8D0RR4XlWiu9E4gYJEY2?=
 =?us-ascii?Q?zgA/2oMxWVlbu4liCnEzBIZ4/Fb+ohiJtTJvoYVHjZs7IJX1zJnJ2Ir2zQwr?=
 =?us-ascii?Q?2S17oWxF80zRrCb4JiYb1PYDFxqBxHlCpE5ZSKomnsQnHZ5JXAsQcaEC22oB?=
 =?us-ascii?Q?iS/kvBxr+KryzbmeXtCN86vA8gF7GNR8/fNbUSDZLiTUR5kbM0sb9okjB1wX?=
 =?us-ascii?Q?Fu7ZqrIU56HJEOuasmCEEwMZOR22vH/0bF769rq/5RDlhpIiVhQ3VVPSAsI0?=
 =?us-ascii?Q?/feVStSC/ttJUfJGQNc7RZDC6c2LjFUSlarvAIbDGkP1fI6pd1o1KojdH8k8?=
 =?us-ascii?Q?9XnE0STN+yc35DBJu83Xzf+HBQdZ7WjjJgsowtwPLU6qAF2ScB4uVx/s2jcp?=
 =?us-ascii?Q?9I8BvYfxEJU4r857Oszzz3C5oc31KvL0cr242WEktAQvo2Q7jpdNAWOHJ4yF?=
 =?us-ascii?Q?ofsQwXXwAnGqlfRtwtoJPp3v5JYTt0QL1vtwURcTnkQhWv2BUegpRivbLBoy?=
 =?us-ascii?Q?ou2DtToxr1M2mTSVxNFM+6+3H9CVipzJoSPZSDbFtE9b5Q3rIF78fzJo2r+2?=
 =?us-ascii?Q?Ui7hA6FI3HsMWa3Ye0QyHUbcvkd4Ml4FG8fTUZ6FMsSbNhbzOsQLT+09dZrn?=
 =?us-ascii?Q?Uy/FFyEJcrhRZf9SRg5JQhvkuj3PoILCAc0KOOO9afQXSUJn0vSoUQvlXbuj?=
 =?us-ascii?Q?D6NPPEyVnCt+v+5iDhYMRL3t6c5MI9a8GLQc1UHS0W9++miHSduQiNhT/pWb?=
 =?us-ascii?Q?8UieGXRKNcFcr3XMjQMCliaYe2oo2XMZJ5y2m2MsvgOXI26ejFxWA7KtKkgm?=
 =?us-ascii?Q?3g0s/0ms5HTgHrY1YTQOzR57uY35DtscXu4E6lU45/Onf+fw08ELN6vwQ7Xj?=
 =?us-ascii?Q?f+O/4gHcOabE+vfu27cjxM4KOg3zJ0caF3IDwQ0P?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db575681-5d5f-4123-d575-08ddfb4bbcc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:21:26.4389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BxYChCeoEQ5VxBoOHSAV2HnFMjZ6cxGnEwBdXYyHmxSsMsL9f2iS/9mRMPO9C8QnE4JE6tMHW7D4aDuXbqzAFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7899
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, September 19, 2025 10:42 PM
>=20
> On Thu, Sep 18, 2025 at 06:55:31AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, September 4, 2025 1:46 AM
> > >
> > > +For this to work the .c file for each compilation unit will include =
both the
> > > +format headers and the generic code for the implementation. For
> instance
> > > in an
> > > +implementation compilation unit the headers would normally be
> included
> > > as
> > > +follows::
> > > +
> > > +	#include <linux/generic_pt/common.h>
> > > +	#include "fmt/defs_amdv1.h"
> > > +	#include "pt_defs.h"
> > > +	#include "fmt/amdv1.h"
> > > +	#include "pt_common.h"
> > > +	#include "pt_iter.h"
> > > +	#include "IOMMUt_pt.h"  /* The IOMMU implementation */
> >
> > "iommu_pt.h"
> >
> > btw in reality the C file (e.g. iommu_amdv1.c) is put under fmt/. From =
that
> > angle the path prefix above should be adjusted.
>=20
> Better?
>=20
> generic_pt/fmt/iommu_amdv1.c:
> 	#include <linux/generic_pt/common.h>
> 	#include "defs_amdv1.h"
> 	#include "../pt_defs.h"
> 	#include "amdv1.h"
> 	#include "../pt_common.h"
> 	#include "../pt_iter.h"
> 	#include "../iommu_pt.h"  /* The IOMMU implementation */
>=20

yes

