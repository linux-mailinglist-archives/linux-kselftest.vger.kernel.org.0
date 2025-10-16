Return-Path: <linux-kselftest+bounces-43291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F651BE1D37
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 08:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48F4189C69A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 06:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA12F0C71;
	Thu, 16 Oct 2025 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BF9pOBKf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837582EAB89;
	Thu, 16 Oct 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597740; cv=fail; b=XcplIUin8t2VgacLyfaPZm3uZdk2FgRnP5oXR4TFngtskH5qSQbdUUgWeYTAfEDCa9a8rCN+M0GXddPqBmzKlGsLpCKnLeOH/gT4FXy7eFprk46ksQg4KkRdk4EHrsQrWsJMFD8438j/1kCLuxphyd2Mw7VGPagbMlR2V2fK5cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597740; c=relaxed/simple;
	bh=BtMrSRB5TKm45lNgDG5hqCj4ckiBEAAl60ijvCPtQ/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJFklenu5zHtXT60UfZ/5umUKlQOYfYC5j4EncW6fLbH/iaP9EYqiXrAcxN20Vdu+7TWU3zot+vYEhQeMDANb/IMiXkOf78UQlS6qQ7Map9uDZHtAUeDXMWt5sYqZrrE72PMeHlwlD+mQUtUCkQ45HGNNmhApEGd+FK2Knieemk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BF9pOBKf; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760597739; x=1792133739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BtMrSRB5TKm45lNgDG5hqCj4ckiBEAAl60ijvCPtQ/E=;
  b=BF9pOBKfUURERSOspnOrl6hee42p3939vmOGWDI6ZeApkW8gqfDS7Dyz
   6/utqJp23qYuCnkXmYMiUioe5lxkDdwo/ZKTvJYdjAUKBV5NLzaP+MbEx
   4/NQ3Ki6uR4mT0e+pksKaEFf8pPp6gItuPCW9RIa0lzB7jPWKy/7jpjgP
   R0ZmXwWcu/3Do8Oo++MGrq2mGtU4OBt4Wx/QWVGh6Dq2o2/T9BUe1U43n
   W8ogX8OpIjr30E5zRMZN9k0sx9aJLHYIJa+8PdAhznjpwnp0PjbtmJTDx
   6gke/KIDtGXooQMeEPq/P4uYaPYgtJd9wIiAOFxra/mhKrDDOq2IaITn0
   g==;
X-CSE-ConnectionGUID: eab3PiAaSF2eJ0pV9vIG3Q==
X-CSE-MsgGUID: RBBTbkWFT6euYMXPG9XiXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73382850"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="73382850"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:55:38 -0700
X-CSE-ConnectionGUID: Tj9OOgdTSH+6iYfNJWamUw==
X-CSE-MsgGUID: 8AXGeR5PRVuqjWJw6AX6ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="187657948"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:55:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:55:37 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 23:55:37 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:55:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pR9u5T8aM7BtYwh9UHQOVITbfApyMe8YuD/yFG/3Fc08t+ObPIRZNeEEJSNu1EBygMsnJoIpZX+SlMGPTKeWMwoZEHrS//aBNc8ZqaG7lZau30NHPOsVyy2reWub8DR8wAZifZ+o0QSgHVSk9FEIC+6BbpPvh+7XMaAmyQQHcEIg9u+oQG7YXOsS1BpYyJWwodq6y4gKj4cyUQedtVn2PQRlW6g6+XlQS+cnKR2C0S5oeC0X9sW1vJj8a674DEdE0DfBvgPO2WVLzgk/Ik4gV+lmGNxEG5PSaffammkmoB/4VRyifNoQ425ZlK4Un6l4M+LqwXtHr+yHFoCnq9KKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJBMRIc3qsn33iQmCEBJdPmwPhAqUyueDhU/YakuNus=;
 b=ArWVAHzVpdp+/QE1PwcKRCInoY/ES6NcEWboYEUtD2dqzKIdGLwRMhmvT+5dQdp7auuU4MEeRQWhLc4vnGUkxhzYTZooc2T4SB9FEnQkJt1q4dDb+hVEUH6vfpKBy8v6DLxnD3N9Anj47ybEjY8to1mCkYfTMC043HD4nz+6jdv1zK1XUK2bX45IiLpavKpANTkFuMWL3q2INSU5X6Ty4wTWpVphGqe5B3DuQyHbjVZOCIxQLlMznPGT2R3KY3Mi24DgYAdxvUGpNn4473ryB/mWwaHLgGeydXRz1CV3EjOgWYW3+DGwETqTo7fQBvhcEWnl48dM2uYodAJq7T1SWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB8261.namprd11.prod.outlook.com (2603:10b6:806:26f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 06:55:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 06:55:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>
CC: Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v6 12/15] iommupt: Add the x86 64 bit page table format
Thread-Topic: [PATCH v6 12/15] iommupt: Add the x86 64 bit page table format
Thread-Index: AQHcN6Yp2RXy4Xswjk2KW+NUnEUzjbTEZCKg
Date: Thu, 16 Oct 2025 06:55:34 +0000
Message-ID: <BN9PR11MB5276AEA18D4E2BA4132B90458CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <12-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <12-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB8261:EE_
x-ms-office365-filtering-correlation-id: 72caa995-3900-4dff-f3d1-08de0c810139
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?1Cg0k6c0cK/w+qWtfKaUgA43eMeLHbyjFyPRyRle2nYxEudHfnhzKjMyitXr?=
 =?us-ascii?Q?pBVqFi+SssajN0yOGC5/TwUivH0xi9WzuwsONfyztpUaXHWiaFlI6+0PC5Yc?=
 =?us-ascii?Q?hox5piDDAkt6e5IgOnJPQrNTMORnrVn8dWncnYoVie9Y1RVUzMhzRqpcZ6LY?=
 =?us-ascii?Q?Cc/TYi8Z0eWxI+YLz9R5RhmLNoGn12Tx+TH4Wgqe1DfhdQc9FQl6FXL/fYPK?=
 =?us-ascii?Q?3/Pwll4cYJRpTmNTXVNv9mlIUdWgejI50KcvTJKsXJklPN5c6zFHpbWzxr3U?=
 =?us-ascii?Q?uUoOft8wa0vTDgxkotr1UU050nXJKPk6h5k/sqS8fqjZEK5SfwdyrcWnWhv2?=
 =?us-ascii?Q?jDTxdA/ipT5Z8v2rNvagROG9L7ul0zwxGDcjjEz1cqUao5aJQf5ZbuQr5gUS?=
 =?us-ascii?Q?ni+X0PZZcp8I6IkQF6wx65tFJxwCwr93+4z11zDzA5A0veiZPSaPVFatqBuq?=
 =?us-ascii?Q?FTCR+tMhlfm3xf74ThdrEHYXHQcOFEFLP2zwYuvDvXoQm+CbonykOtRR2fsg?=
 =?us-ascii?Q?CdIgIIGXBi3Cqed83YkY/mjaAedq+kbsRWsS1kVUwAImmjDERKlfcOdNzPLk?=
 =?us-ascii?Q?QPw2smorsyaTcc0CHSwB7wfZfy7+dpupPZvXwVnHvtbYlr5s0hRB9mXxtVOf?=
 =?us-ascii?Q?Y1pbmx7SyhtxllrDSHrHy09qx3Ao0YYOm6VMHKbDCBIQ1JyKyLwxwP+Yvw69?=
 =?us-ascii?Q?gkU1gh0REHbxN4uXa8gDWI5ogtKAvSmQyLuoZaamFe7q98kffoXcr9f8p/s4?=
 =?us-ascii?Q?glcFsbI50r5Ii3MfFcrsPeXPfYx3nbWJyUEzIZbaT0b+fQGwimVxhp/YudE3?=
 =?us-ascii?Q?DWjGKjf6TMO10dA2VAJ2KS2Z+pYunan+aeGi2zH/ZBPTs+A2kV+L62gqhUG/?=
 =?us-ascii?Q?iUBmLAGLDyMhErTUE7ArR1XbCQTmYUszkADfPWkQAUuz4FvYikh2KltItNuY?=
 =?us-ascii?Q?6nTc4WzFT0eRNMTMOhPXSbE/UuoVWzzZWaboe8ZJb+q6F6/NZGnvoiCK6fLv?=
 =?us-ascii?Q?LPWuflsSuAPW1l6+yVAsZ3FbZkKTX+pMNx7agqaRs1sddfifcG4d5fBQ2bYd?=
 =?us-ascii?Q?h6AcwB2GK19oS5FMKFy3jDAA+MtqLBSanctAi+CN/MSLU7hVoxhQFYJkOAr3?=
 =?us-ascii?Q?9GTxT41MCi4kR1EOYun0EPZyW5GCqXBKy3MINpvhBZCPWyVEiKtx3Dj4c9Ij?=
 =?us-ascii?Q?opb2SLbM3IsTsYvarFR4sSYS/B1r1NQd1pmpIM7XelnHjNNPA+sodQ91ulZS?=
 =?us-ascii?Q?ZT0VU29DJ6wFamjouE2B9wBLJFx6ruHwd/3+4dA7CC3Su4e67kZ50IzSfuqR?=
 =?us-ascii?Q?fdTEMWbdp/bHQ/QXmHByFEisOVSY1yZQTkFB97mTZMPNbpQmxQt1cRgdXj1m?=
 =?us-ascii?Q?0ijRplzdsTngUa5oWvRRMSq10CsDEyqFQjY6P5Ll4EWqjp3jwVjABTwZfwac?=
 =?us-ascii?Q?PNZv/o+LGhXJEeS5rPNG8UDatY9O4/CxBsF2luNKxc60YNrDQB4XC92oYvF6?=
 =?us-ascii?Q?wC/I/i3ei7Uv3Q2dc9I8E9ImvW/DLBOTsrgSEDTMHzIEQlOrxVau28qQ6g?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+GBY4ok02Fg0m03oD6x1W8ECBvogGehlq1jrMQQPgqRvAPWapvclMdmsnoqw?=
 =?us-ascii?Q?fLAXFhsCinyy3QGpiyvJNhKxXT7jT92ii3xu99BuBcLujSN6i48/euJ6RcO9?=
 =?us-ascii?Q?ENK37hq5CLfcQ5lzdy1s3F3iJnuT2VIxersd2MMQrRg+GyHl3u6T/jOKYX6r?=
 =?us-ascii?Q?F8Ll1/V2gRGPFiZGAMJhG7XqMWYJV5fOrG+wKChFw2s3FE4eGvE0aVuCOsKQ?=
 =?us-ascii?Q?bPrE035kalosHWw0fWuy43P+KTmoZOf3tfesUluNH78XfQbDSFyvRDmcTBtd?=
 =?us-ascii?Q?33+JT9ONUYc7ZPf9faLRL0rBCU7uggx9YKdhUOe18RnxnBdvoNICvQLAWrx2?=
 =?us-ascii?Q?AaGkY6LYMAts+g9WBWTkmR0gQZT4rzTgnJ1zkL1FUOMg2Eo6T3X+3qLThjUZ?=
 =?us-ascii?Q?8vp2CRx+3MkvZrVT1Yafi1+jljytRm43QaOfmMc/7X5js4Df1kjioglB9455?=
 =?us-ascii?Q?t+aVRxhit0JirvY2K6ozLgi4cBW5vJZuF6DHzzV6BN2a1ox6cZwubhcbA1+G?=
 =?us-ascii?Q?dt5zlvUAv9sJLCDivh9CiHFtEtaCiaV95p6jmoyI4S+a04tGLmuTU/7OFGX9?=
 =?us-ascii?Q?B5zn8G0ZNS03ahz4f40eeZw0kbRKEZwe0Nf3P2OgTTtr+yFNhhBzJjsct1ng?=
 =?us-ascii?Q?54lQncixadsTTNJtyDKKeGuwl3s2zrWQ2kncPbSnwYcj2/MTk9/SBYSGkiK9?=
 =?us-ascii?Q?PUD+puWiu5VvsXl4OrUYTBKruHgLUh0pUztpCW4pj6YoBYAzGtUsEcKVkk+1?=
 =?us-ascii?Q?zo+/UozuxujiUyqt2idHP0iKO9oXyMZJkrOxORQm8Fxrt/RWxPslQdBLqQpC?=
 =?us-ascii?Q?h5mimqG7NXPz7ZHvs8nig0q6smoxjSln0i7+16JGzoaKKhU2EO2KXno5ev2A?=
 =?us-ascii?Q?dKJaIs58cKlO72XLxK2tCvY3hiamJs5aVQbQzzLkC1B0SydmhgH5/c6xqYOy?=
 =?us-ascii?Q?AYYGe5hhyEqZe1cBZDAmh/c+s4iC9Gi+lWNNh31hoqg2haDput70Xm6AjuqQ?=
 =?us-ascii?Q?ERjltjhLM4tXxr0LbLPBhQ04cPfsOWOC0SfsjuUUWcGVvRG2JL8Z65PgSb+W?=
 =?us-ascii?Q?alYmFptF00B28PIq2G1Y+xbvkFLAXoSzFBmhZroqIKFELL851nMdHHXLa3Lk?=
 =?us-ascii?Q?q0grGlt7UTIjDcJ82EmicU+9BvZ9YMYuiRhddTLK9Dx1MruIUmYF1vXPKeFC?=
 =?us-ascii?Q?bBrheOcvif0NOlzSL9Ni3N9/z0cpHVEiKoPFE4LEdqILkRnZrIJJS3Ttp794?=
 =?us-ascii?Q?ufJhWeF2L6Gl3fLw9yzChsYnMQ3TVHQ+BEM7QVMcIoTqZJ/XK1AWDaPfPH9A?=
 =?us-ascii?Q?XZtzE2um1Vf8an4UqTJBuvwZglNda5U5DsYWoC+GwxGiujNf0+jp+1S5TvXW?=
 =?us-ascii?Q?EzEJWe0C1NVJFgkgRJFMMnViA3Lq12as7CE/2LZbxWmQJ3WBmzfTaFxyfpyJ?=
 =?us-ascii?Q?gKrhD8/vV6XynnOvDqd2BZZsv4cg54t3Z79/D4SMPJev4TvHBxX4BKTHoB4s?=
 =?us-ascii?Q?u0KhcXuDmirXBg0gVvNDGprJyT8LgpplFdKfPzDeeVrJTB4mYargCpp/kgKE?=
 =?us-ascii?Q?tW9qpAqXOuMGbuZK+sBeM15dCBD0gyN/Qk+TV/jg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72caa995-3900-4dff-f3d1-08de0c810139
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 06:55:34.3478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5NPdGA5xmQwNc+TF+jADraVn9DHLJXUNck6reQ+vwGcM0chON2SeBFQAE5n66inIhv2xgoSFz6OeHtRUVRdoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8261
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 8, 2025 12:12 AM
>=20
> This is used by x86 CPUs and can be used in AMD/VT-D x86 IOMMUs. When
> a
> x86 IOMMU is running SVA it is using this page table format.

SVA does use this format but mentioning it is a bit confusing here as
the SVA page table is managed by mm.=20

>=20
> This implementation follows the AMD v2 io-pgtable version.
>=20
> There is nothing remarkable here, the format can have 4 or 5 levels and
> limited support for different page sizes. No contiguous pages support.
>=20
> x86 uses a sign extension mechanism where the top bits of the VA must
> match the sign bit. The core code supports this through
> PT_FEAT_SIGN_EXTEND which creates and upper and lower VA range. All the
> new operations will work correctly in both spaces, however currently ther=
e
> is no way to report the upper space to other layers. Future patches can
> improve that.
>=20
> In principle this can support 3 page tables levels matching the 32 bit PA=
E
> table format, but no iommu driver needs this. The focus is on the modern
> 64 bit 4 and 5 level formats.
>=20
> Comparing the performance of several operations to the existing version:
>=20
> iommu_map()
>    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>      2^12,     71,61    ,      66,58      , -13.13
>      2^21,     66,60    ,      61,55      , -10.10
>      2^30,     59,56    ,      56,54      ,  -3.03
>  256*2^12,    392,1360  ,     345,1289    ,  73.73
>  256*2^21,    383,1159  ,     335,1145    ,  70.70
>  256*2^30,    378,965   ,     331,892     ,  62.62
>=20
> iommu_unmap()
>    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>      2^12,     77,71    ,      73,68      ,  -7.07
>      2^21,     76,70    ,      70,66      ,  -6.06
>      2^30,     69,66    ,      66,63      ,  -4.04
>  256*2^12,    225,899   ,     210,870     ,  75.75
>  256*2^21,    262,722   ,     248,710     ,  65.65
>  256*2^30,    251,643   ,     244,634     ,  61.61
>=20
> The small -ve values in the iommu_unmap() are due to the core code callin=
g
> iommu_pgsize() before invoking the domain op. This is unncessary with thi=
s
> implementation. Future work optimizes this and gets to 2%, 4%, 3%.
>=20
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

