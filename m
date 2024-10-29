Return-Path: <linux-kselftest+bounces-20910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 418ED9B4460
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF81F1F23733
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE2A2038B6;
	Tue, 29 Oct 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ia16A8k1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD21F7565;
	Tue, 29 Oct 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191234; cv=fail; b=IgCFOk1ytN4OK9OHt8U7HOaLpdm8M4OnNZxzPE1S5DIKoFYWt7weReYteF1nSzT9rphxpHjM0q2dOGVI5RPKqPWMMse6SEAHh8Kb3Z3pGIZebgt9J5WZkady94qWauipaf5JRLGRJU1vE1XPmwTuCmj/0igO7k0O8TRqMaori+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191234; c=relaxed/simple;
	bh=KTcaGi7aGnbNK041e4I3H5I2hAvySQkcs8qbUMwUqHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XCnZOG1YmvU2wsL2sQfPlo6SnTD0qg4SL+MonH2sqiPgU5zIikzxCn18Dqe/v8Qzvl2YHWiVErXGV5mx9qzcOkmoMRK4FLMdPjryTGJ8RcsV4mgZ4VAxwlAziBGI9Mn0ys3ExWg4UVgBzAXXfX1BGpTZ09To9IwTVXW60VQleo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ia16A8k1; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730191231; x=1761727231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KTcaGi7aGnbNK041e4I3H5I2hAvySQkcs8qbUMwUqHQ=;
  b=Ia16A8k1PyKkZU0AMMLvTqkHCFp/jPXJ59Tq4XceVIWQUB/87aCIxlIG
   3MyEdu6MsywntrIqNJDM/oJRNzLqK+xt6oz18BLMN4h5F74GzC0E0gpF6
   bkLeMpSWuUWVESr5b0zyY2LkZma/RFEInldBVHYvI7tRMcpSKMV+8V0MP
   YUqJArF0Fc4B0xq3cnIniPNHSZ3oNfBJWxayVbUFCIhiuX866vOGTWzsb
   U8ZG5fVnDpqxKxM12uImla4hTSRiuUFCTzHtduLXob6XqnzBrQz3ocqlD
   Uvmt/+MSeuLziOynh02sQThm+OEJEJ9T9yBpVS7/H8lSOi8anWfhQeiHx
   g==;
X-CSE-ConnectionGUID: hb2fVyaEQFCXjoy0q0fRAg==
X-CSE-MsgGUID: eC/ZFPvGRtqMqlHJkAlY2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30003429"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30003429"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:40:31 -0700
X-CSE-ConnectionGUID: S7D5Dy4xS9el9MA2jECnVQ==
X-CSE-MsgGUID: fu7+A2SnRf2FG0rLes+SAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81958242"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 01:40:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 01:40:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 01:40:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 01:40:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcrWvhMwhWjayVM8Gfl+qgRG5oeCPbjMsv5HyTU2WwQqX8aasdMjjG8UzbVXANglSdgG4NlhU+wA0rlF4XavWhZBiFyMsZ1fGERjz3wg4sguuxYHArYMkM92H7krMFP+nIb6ssNyAnwEZ1WQshM0Tbxd6Z5jVFnGOz8V/wPD9jrmM1RzMDoRLhameG6+GSBZc3U6B5USoS0N405neKNuLHq2wmzwdLkKlJfzALCk2e9DhNqL9nCeYknDBE3z82B8zBLCgsfZb18cvjeGNGYSvp/pYIs7WYELkQamq/ZLiSCoYuEwukszlKDOEIh8a8TNwdbBoPFkBLXEb7p0G7EJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTcaGi7aGnbNK041e4I3H5I2hAvySQkcs8qbUMwUqHQ=;
 b=Gyn1V1F00YmlDiNgnbAzuq4ku5DgBF0r75v8pNlwmnHOyPRiLf4r6ILVHpGu49YW6kO11SmNZsZKt0XTx7/bis5/vZUVTyaTEwY+J67MfZoXERDdpjIzQM/aZ7TysSiUfskxgh3IrNZHJ8gB2fqmsauGeIyjTypGOZp0oM8qua/IviFA730JTukOLEwLZp2W7jJ7ijznM5FscQyJ8X0ZkNlcjdCxm2yrQJ33nlRVV44JBt1Hdv5Frrv7DRTZwBMhILKpQxSfpChPnnDaL/G0wbOnqHqcqzHkiUmcKNTgddMc5hLW+87AmFtUyrkCKhCjYbD2FL4yb7TU0Nvd8LW/LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM4PR11MB7376.namprd11.prod.outlook.com (2603:10b6:8:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 08:40:26 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 08:40:26 +0000
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
Subject: RE: [PATCH v5 11/13] Documentation: userspace-api: iommufd: Update
 vDEVICE
Thread-Topic: [PATCH v5 11/13] Documentation: userspace-api: iommufd: Update
 vDEVICE
Thread-Index: AQHbJzjOyUfccZYtIUqNHl/livHdPbKdbdww
Date: Tue, 29 Oct 2024 08:40:26 +0000
Message-ID: <BL1PR11MB5271D59E229C9E0BE7D4B5F68C4B2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <3e7166c065f767ff55c3207b12144a8aa4dc8ae3.1729897278.git.nicolinc@nvidia.com>
In-Reply-To: <3e7166c065f767ff55c3207b12144a8aa4dc8ae3.1729897278.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DM4PR11MB7376:EE_
x-ms-office365-filtering-correlation-id: e2a1ee8d-fb93-4f20-7152-08dcf7f5561b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kNqF/pS2HN4bN2FROHzd9M277/3+uSakym3LXJ4I8JCXrxbXuwg1d5zmxex9?=
 =?us-ascii?Q?XkV4bb5b9ue9VfeF2dqj7I+spnEgYBeN7IumbEExhk2BwUdpApGSVRT3Vtqj?=
 =?us-ascii?Q?MsAGz457wQ6v8f9uVU7jTKadNhnUnKuUfaF3veUIrWjJJ5rVqecaZGKphBM5?=
 =?us-ascii?Q?CwvpOMJvubpdlIlUToNktgCiNPUsO9I9He/GFgE5DWybPn/GClyHf/LC3Mk3?=
 =?us-ascii?Q?F5p8cQKV2afIk2SGgHyXMvH0zBq62pgDok4UeYMMZ166HzTTuXAsCRmjUBI8?=
 =?us-ascii?Q?GFXrXhZJs76wjSZAIx4+uv1ox5a1o6tI5U1YW3gnd6NdYkbCIDhVSzQSHA5x?=
 =?us-ascii?Q?Az94myq6ZHmHJmXEMP4Gy8W5jXdXBzzm86UJDTYbNyXHuO4GqzTRCvrpPOh5?=
 =?us-ascii?Q?jkO6RfZEtLH/51Yu3JtWvUgTeyGpz6Or/LJ4Qs2/RRf4HLxkVPGKyiZAcs3t?=
 =?us-ascii?Q?kkblbdRLiRZTxcuWk5UeFHX8Oc+dyLgc3kyZFhhSPpYK7ac391Nmqm4RAWhQ?=
 =?us-ascii?Q?5PuV8Dslvvnep9WyhGetwMfvXpi83jqBJxRlu1kk8+YDuW3gJhleoD4ygfqZ?=
 =?us-ascii?Q?wlWOtA9tAX6ouV/Ja6yUi9b4rm/Pp3NJLmR/lJehctxXKQMNcR6WzoF4gvJ4?=
 =?us-ascii?Q?iQm3q9mpfWVhR6cA+RVtJfzY5F5PoFBUdqOc0fw1w9MFmgOJCn1wA19TDlDx?=
 =?us-ascii?Q?rwzR/8VrQ6emE0eX3luoVUc7aaZdz368EIuEyRIYJVRG8NRnO69Ng2iQ1f+a?=
 =?us-ascii?Q?sFV1jXDEhRjHoknecL6gk1qpK9zAEk4Vcg1Vm1PSHbe5oMlAH5AthLU5h7yi?=
 =?us-ascii?Q?cbCJ2b/eK6Qh8NUbGvlvdqsLSJ3RDlXsAisqxBURnptzJJd8LQOsi5wkI/3f?=
 =?us-ascii?Q?7Ccz338cEdksSz7WtGeY3DZWkomrEJnoRhD9MIL9NoCUqba9Vp0uyOg+D/gL?=
 =?us-ascii?Q?CDdDLrWkkQ6nyq2dM3DE/YO85Nh5Jr06pIY/sgL4+sYXYju4Miqlb/69ASJY?=
 =?us-ascii?Q?/ISewHFvHYSeGBOk1+WBkqyvAQD2Kvb0XijTzYCgw4nIqMhM7J8bQYJhRauf?=
 =?us-ascii?Q?x3cJO8giU/da6wqsoFnBO40TGZfOBkz1FetaMZQx+EcTekU/a0txOQEahlAh?=
 =?us-ascii?Q?+fPEA7UfvVrubq7WNMrQy23bO56firW03XSn4FDdeo3aucGa+T68dpoyKUM3?=
 =?us-ascii?Q?WuaxW4FswZib1Ez+wT/MP9z2SDb1XsS4gcis6mflHH6IvU0PcPQQb2xjA+h7?=
 =?us-ascii?Q?SJRHgkymHWniiOlAjI2gKEPoqsKQXhI55Q0of1mYBUfwtyUcgTdgrzqqPSo+?=
 =?us-ascii?Q?KF3AMDySoMY2y7nvsZZ8dHTQeHMUVutGM/UlMIJ4ZkErrRa2lJy0ADi3e6KI?=
 =?us-ascii?Q?rrIb2sg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kWlozSgJotqH+9gd89zldU+6e6WLYDh0QkhLE3l/mhjmtXAy4NzSj2Kc7eoX?=
 =?us-ascii?Q?ACN1laBY78bD9nwvGaAvBG1stPzQ7Lr7QoFOYdkolB5oNiTQBlJV21Yfmq76?=
 =?us-ascii?Q?e1MsvwB6NZF0yBXWmn+82LgDkkJBiPN/HOB36Vsf8hXeL5zqQMSkDz6Uf0JN?=
 =?us-ascii?Q?SxKacX94z9aQqF/UUHfHpMao7Vi8ZSDVJcckawvkxY/Emg6udLjGvCHJFU1i?=
 =?us-ascii?Q?pjOvA0qqUejqINV93+/PesTsX/JxLjzl00Z7Biww50TycYRmTs83dQj4cAk0?=
 =?us-ascii?Q?esrVfvEsxKTVPy6gV/bSMhmdzUUlOqzORMPIt+d5RYsufGjBQtbeFUxOm/8i?=
 =?us-ascii?Q?3kmk1SHL2gIRZ6nYv0zkHMW1vm4xQ6KY4aVb2T0QutXZwyMjDmcQYuyznMWd?=
 =?us-ascii?Q?iAc5C/OfLZ1NjO8ePeruCJ5yaD87GSmu8+BongN1uOAW5bjIeOtu1ssFwOmz?=
 =?us-ascii?Q?i/Jf67EWKxR0zLjT/lhRrdLe/yxP7uyVPH1NtnQbNphtq6qIO+lMh7KDdzHt?=
 =?us-ascii?Q?g5Ty+MCYwMBtWdLYyjA56x/azFAg4Z7xew/p9t0xU6NW9Ahfh3FJuelaM/bn?=
 =?us-ascii?Q?i9z04wWGbS6JcxzFY0kgSuD8/UOFhLn5hxCRickDaHBr1vn7/b0WjfjSOVoK?=
 =?us-ascii?Q?C20EY3Sa7H2gFVqRbsMY2hbE8Lfwj/WHNyq443u1i8+aqjput1AT6/gmh9bl?=
 =?us-ascii?Q?v67P5avdLLimIA78TOrndimIi9eYjra3kMdr8xNlLZnXfXwdBS/yoq/Kx0Np?=
 =?us-ascii?Q?5oVE0iY9Vs2bTZc0IaJZeiQ4A7BBFF6OW8HKwLCFwWSqKScNHByKBxfgV4bd?=
 =?us-ascii?Q?4qXrrYxFXiiRNLbNH24YHl8xi7FHQ+UVNlUj2IcpEt2k90988GUN4aliQlJI?=
 =?us-ascii?Q?hkmuYqM8MwSpZbW4tYUlB/rAGDzfXYB7aHI/w8wThPZlnql9AZC3Kx7fLQ0N?=
 =?us-ascii?Q?zYIRwI6V+/LAVxaz0HGenrqb3kJo77U54DR3xU93lusbpxvNkFlJRI030sEa?=
 =?us-ascii?Q?ya3cRzecvH6KYqDynDm7HP1eEi34Eum7AHi0M66asbcvUvjSOFJVHtGOFTjs?=
 =?us-ascii?Q?YMBegyJaVEg1DCfZvMxp8h04te9rKK119zNjJWPUb2j6NgyboO/S7jdz58qw?=
 =?us-ascii?Q?fvpAK3Xtd5gNqmbshPJoxKteWIE15iyn4sp858ytPYrm11MlmII49D1n6hA9?=
 =?us-ascii?Q?hwa1tdDcfTJBtyu/1aMvMVNq5aEkeVoxM0YnMiebyBiWYhFnWYNYePJwIS1N?=
 =?us-ascii?Q?0LlzTjinBbSZvi/0498BQ6wxF9mhlbl0f+PPFXWXuYKf9PU3ER6yIQ3q8BOm?=
 =?us-ascii?Q?jY1KsT7qyvIq6ETcuDksTxen3vVsoRbb2HJRADHyMYbcct2nMierYon+88J+?=
 =?us-ascii?Q?yr+2Dcxc2aIRXdAD+YZkPwfvzDsPkVh7HlfXCO06uk9dOxD4vNZ7tqh8VOrJ?=
 =?us-ascii?Q?8pPgF2tMrpdemQ/fQEE1FqVIIU6p+pRP2QEbszIc3RqXoXP4IOJscmlj/QFH?=
 =?us-ascii?Q?ZZc5D8+y6OgSYdJS34Hebq5AQLnmFtoZ1uw+25aJbDUF2pDz4ViaDBVtygE9?=
 =?us-ascii?Q?/8cte3F+a+JfptaKLa+gl+94F44rz84ECjrukbQk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a1ee8d-fb93-4f20-7152-08dcf7f5561b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:40:26.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4+Ne+Q+sa018qluBYIeBFzP3ElEv692aqvkxCJgtGeN8NR4jU3QX6ya2GqBB4dkKsCrGLcdhu1wxENoK4Frlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7376
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:51 AM
>=20
> With the introduction of the new object and its infrastructure, update th=
e
> doc and the vIOMMU graph to reflect that.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

