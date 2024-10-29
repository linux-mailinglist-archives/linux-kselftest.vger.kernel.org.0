Return-Path: <linux-kselftest+bounces-20912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BEA9B44E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4AE1C22341
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52502038DD;
	Tue, 29 Oct 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWH9nt3g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A6202F8E;
	Tue, 29 Oct 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191889; cv=fail; b=GDF81NIPj46/DcuFSPRdmmtWx++bbtoq5957Oxuz3jfCbeJoKxzArqrtw6thxYkdxsUqsTFPoQWWQn69oxUVyin8fifsl9hC6hvKg2rtj5zqoFpz4REJ4fpHnw1Ay+JLJEgVrjDn93U+wv6CLKlNJJ4s5Dc8W3mJezgu0f3baaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191889; c=relaxed/simple;
	bh=rcgeKlvAyIUwNOP9aERtAUAqupdUqd04pTsC24HWcwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eIY/HqEcLcXm3Ax/qlDINp6Er7SFvwxS4gltKFy3AYRnEDkhDlH610gfIDdwjs04eJ43S7p3a+S86a40SFss5wnz9GhIhBovWE9TvOmCikfBxxjgYLUo8IMPi7p1kX26eZpoPuKekgs1PKfMg2TYiKhqoIj51/wqvy8bGOd5CC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWH9nt3g; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730191888; x=1761727888;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rcgeKlvAyIUwNOP9aERtAUAqupdUqd04pTsC24HWcwI=;
  b=LWH9nt3g7sIfjCAngM5wBulM89gy+ESxZ4A4BeKBaT2PPp3Gr+M6q2bz
   LMN/ZmGS0Em4QSvjoZx+PBC+7aO+taswIAdf/sJgK2I8O8AEIJOWNU5Yx
   S+dRMYhHUHvo7W6QCsjiyxfaUY+8bWV7pN1jEuQziad6dYhI57j2xhUNU
   Vusf0jbTdlQtK6je4svtj6GPd7RHOWkYNnDoFhA+5/b87uwRzg9SH9kcF
   a/6NqLFz0ndx/DeBkta0UlC8QRQPuLP1BA+XbKKGW9clZD0PYJwfmG43a
   np6//l7qWiZ2JN4AmN+2ni/gU8KNM4n/G13nafFSFRJSuwqQEdOVzYZMw
   g==;
X-CSE-ConnectionGUID: dAGpPOZ1SlC3OBRCKYRLuA==
X-CSE-MsgGUID: oVUpsbxfT0iN5ZXyZ93+LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29593842"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29593842"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:51:26 -0700
X-CSE-ConnectionGUID: J1kg9Gk1TrmTrH6I7ufqfA==
X-CSE-MsgGUID: 3vCUSeSlTb6n6wweP6WIuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="85848851"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 01:51:25 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 01:51:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 01:51:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 01:51:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVfFV24adnnAoJWyAX1GOGzke4SN9/QemPxXMYSWtivgLnH4CII01WN+eTisa+bsN23gawnhmCFeAcjsdycBvdIyl50s0nw56nN/VXNPYLBwcnKtrjyNHnVWColr/EcGl1UNUAiFi+aT5l5lHNJ92hCuamf8NIHxbzpcbRKFQCuAjcbfdpUIjPlgdBCLTeYr+WYUpPxbrgTQYi1T7rAKoqB+o0Ys8id+3bLrFNsbIZb4k3lUO0tVGIEiK2f0BdmJUP4xTwXmJRLWyJaOz3XMSWf4bXQPEO6ZHolnFX16AgaikJnGm77NOU4Gf3Px4JvxiQH8e0whWV+R6SJCdtlaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcgeKlvAyIUwNOP9aERtAUAqupdUqd04pTsC24HWcwI=;
 b=xliO2tRIUKTkNDFrsPqBJw9cML9z4htwlKXMHmssjn8r+U93oRNSHjOgM1xdQzV4YFbxq1woFhegB8pEFy1hotEMcsseIlHN5E0fSyuvJlyTjP/8F8wcWGhXLU0qh6qz35w+4U2NWzZPbpt9w1CpEH6ZypJmbMmCc2oFC7u6omK2ZiAcKFkfMaAlwFpj+C8hMbA+fO3px1+hYrgQyEJ94QkvkKK5ZpU0NJm8V0soz/IycgmyOvR5/6gBnGldFF8/0mfPxZF3ZcRAPdASCP04N6y/+oZFOgErkATGLiyvLWfDkDv2RIUnqxxVtF6c5yNHjGGORHRWmpzlfqK0b6QPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by CO1PR11MB5185.namprd11.prod.outlook.com (2603:10b6:303:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 08:51:22 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 08:51:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
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
Subject: RE: [PATCH v5 00/13] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Thread-Topic: [PATCH v5 00/13] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Thread-Index: AQHbJzjDl1+fCVXsnEi2WCoYqtSYK7KbfMYggAC9AgCAATXJ0A==
Date: Tue, 29 Oct 2024 08:51:21 +0000
Message-ID: <BL1PR11MB527135D53410D86949F39FEB8C4B2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <BN9PR11MB5276FFE90D75B2146674E0BC8C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241028141726.GQ6956@nvidia.com>
In-Reply-To: <20241028141726.GQ6956@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|CO1PR11MB5185:EE_
x-ms-office365-filtering-correlation-id: e5cff7a3-7831-4d2d-88fd-08dcf7f6dca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6cSKCfmwWQC1NpmtrC/HT82/4FI/6yHnQRE3pD76pNunV1T0h348j9z5S/6J?=
 =?us-ascii?Q?o+08S1C4pYc+bmkHg8CjFrgwh47WGDZIM/iGzp0RlcsgHzHF+xCtbSnpyeZi?=
 =?us-ascii?Q?SzjfIyJ/iClb0WASAQACFQyMACH/QV9ropReitrs9c4H9Iwm0S2XEj89c/1M?=
 =?us-ascii?Q?oIUTbEZ5/z/Na6LBBUz6FbF269ooAqW3AepWnz+CELYqtXx7pv8+8S9SFYXG?=
 =?us-ascii?Q?DxjF3LOa1F6NiMHMorcZiEqsA8L1RzUaVL4m6ZDKvJ0Ul/X2dFXcwAckwFs9?=
 =?us-ascii?Q?tTBMCCvOvnXTZ1WHdtIa1/pezMOxnyNTp5UtnGnTfd0irx2mamLijFKsX2BR?=
 =?us-ascii?Q?o1D4g3xuE3eLIunB/RsFIiwU/+uaPODrnqzPg3h5Nf6wANSIdYWWBLJ9XBKP?=
 =?us-ascii?Q?LMddN0dj1Hz6FKqXVzbIXKu9b/P5cHBsH9wVl5eqlgBTMnLyl9dtVAkA7WvK?=
 =?us-ascii?Q?ZJp5FHgFht9iOVGUvPEgp092AVh67nhq+K+/turCEYm3P332DlOCWcj5jC7z?=
 =?us-ascii?Q?JI8g4kfdS2I43Rhov4RtqQ3DetV3W3Wr/qSb2WRynxMSN+U3U9HHpPe8rnsA?=
 =?us-ascii?Q?41A7QwQcExuOMavhIim0h3Zz8GJAyqalUs/1dOvHcgpejmEaVAAgkyymkpgU?=
 =?us-ascii?Q?bi1XKLxN2OiDLyChG0Mn7tSOaSGH7nspfuGzigo8g/FeWy+2Z8c1cnAtNUPN?=
 =?us-ascii?Q?KK+/4OhC1C2aO8byqR85qlQUNol3WWXvZ2FcqifTkyXd3hN6A7pqZKN3ZQiu?=
 =?us-ascii?Q?dBzqvnBB2j3SgH694/qXsUsw/1OcciC378AiPPwYK7LmCYwE6kF2SUIaNRZj?=
 =?us-ascii?Q?BIgZ8EE9gw0wqd5Oa2DHpT6ZlngwFM6Slqvx+YRmb09bP1XzJNNhVJNRE4aA?=
 =?us-ascii?Q?NtdkAFnae+WILMFfvJLK5gZawEctzhnvylgz9NRzqSibW16kSoTmKOj3DXsb?=
 =?us-ascii?Q?kfOOkCG728D0/1Y7jkf4USXg0nZz/wsLezZ0yeHl2XR1n82MGo3i9NPgA+zd?=
 =?us-ascii?Q?3xOp4RZBNilpDE1TvAOgu1IHh19lCCZ4Cr/r/UDNwVWVOZbfhHJXP4F0U+di?=
 =?us-ascii?Q?8CI9pTcuaI+fb5ezcLsVMVucnlmgUJS4awU7JDA/m9TDYL+0Yu88NBPEnY/i?=
 =?us-ascii?Q?msmeEXsnLCy9yIVUOCJbZGFGziQOJdiIOvVklm2FxaIscr0eZOpxKDsiOQR6?=
 =?us-ascii?Q?7HlDGpJU1Zh9lzafPIVwdNn/0snIedjQMNokiHujsVcy40eQbfuwvxwQTPXN?=
 =?us-ascii?Q?FUXfxyhscizOUrcRF0tTebEmwwnqY8rdCdj0y7YZeCUg+ExI/McdwPRjVnTe?=
 =?us-ascii?Q?x69ilte7t4yuo8CwcMQ9mQnEQIg+zlYhc4wqcWwPfb7BEJlazy5bbHonG15E?=
 =?us-ascii?Q?Nw1h7Fw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XMJVu+9lPyEJSnx/gZ07PiKey+hZtpmLiap5BnYHQcJ8P4nY7Pi6QTVbAh7r?=
 =?us-ascii?Q?XPikmDjCNxYo/xmZij2vagObQ3oT50BTK7p/xEGSsAmMW64/7ZGVsO2EUCzp?=
 =?us-ascii?Q?UpW8vBUUStLC6MslNA/bvwiN1MT6K052bc1qU7EGqgDyBH0c7KkpAUIszj4Z?=
 =?us-ascii?Q?ChpAMbqDKjQ9O1T0RiAt0aoUAu/a+M5D7x3Kp/cBmL9QMmWCtkpSEYNAOVBP?=
 =?us-ascii?Q?Vo2AT2msLH8t+wS8W+Fq6OlAk9/6admwllAMiAroub5mIGNBpLYfcAIrvL94?=
 =?us-ascii?Q?T3xL9sS9SU/3yxOdvb4Qvu6SZq2GkaozFyn6kXgU7X9ihwIJXYAjzAr3Oec1?=
 =?us-ascii?Q?H4XXzxUsajF0aEOmir746PxDEuDAjv2vqOhQWjXuiJc+4+vWQsVJMjc5o0su?=
 =?us-ascii?Q?LRFK/o6F0EZbaiWnyRKUeztjtWu/eBPXmnB/IS1I2AbmkoooCeSosD/WEctN?=
 =?us-ascii?Q?or53YyergXQizCezbKqN6MSdwE/YBlXF0RHNqGRHnUmNq0EEnAZtNLXVD3hp?=
 =?us-ascii?Q?XA++9SVwUHBhefC8iQKoskDxmaXpfZa6Ue1o8X0rhGbYuJ/e0Fu0j4NQPvX3?=
 =?us-ascii?Q?ovCTXQgJrGNQK1yWRlwzCGFmDsecNREV4LgpdH10JlBqf1NXAFjAKYyXT7Vq?=
 =?us-ascii?Q?zVFBTOxSsD31CpM6Ik957uRLFC1xdwxeCyCRl6QHtrYugynxp7y/ylAf9zuJ?=
 =?us-ascii?Q?y4i+wByPZFrBqZCTk+X7sNz0e2Iy7X3LXF1fd65NcpZ6T+rx9eliPZtKyQXO?=
 =?us-ascii?Q?/09vq0iQiYnVt4tRrFnZlv6B+Rc6Y5UBosUfvzHeabUarPkLtmfdKBwMJxm2?=
 =?us-ascii?Q?uLkMM/fP6h4oQ/gmy/yAi92kgHvAd7oKBsLMpUx4SGM8MFbwNJ9frhpAalxM?=
 =?us-ascii?Q?SKWwRda5V89/za42l5Ll29TmtiubE0/wNab1ughe0ZsFahrHJFckjBbeqlfq?=
 =?us-ascii?Q?M+LW+NQc9gXJE68HqfFSXFBiAyuPbo5PTeGiZDMDK3BNXNiAlLwQfmwJvy2E?=
 =?us-ascii?Q?QzWtzbwDf6q/mdnpezTtGlM4b3QDEfAT/aD6MV5fBLCVtKry2x4w3dx7Ml7n?=
 =?us-ascii?Q?AYYEcohd272bCpNEQXkyEJ2PY21DN4ZvNChnqkynmh9/qdG0UOVS/325AdBm?=
 =?us-ascii?Q?iNuZhIBEFHqp2yylCXTdNRPv2Jqem27+uq0hxkAyeY/aNJqK4mca2Q/RQrTH?=
 =?us-ascii?Q?7Y/Gvkvzk6ppHr9NFWz1FLoZqi8pXfjpqkAeuOsykaVY7sVrR6OhPBadla6l?=
 =?us-ascii?Q?o8Qj458hcVTUc6mUgFGe9xJyX8GauYElbv0l0nPBNpUm57mWF9z2gAbV1FeA?=
 =?us-ascii?Q?e/2VMOMNcHkNi5KrFnJFVjxncxAo5TEpyXjKC8eQpgFGuyd0dom7hlWOq3R7?=
 =?us-ascii?Q?1AD1KMAUHoFjr7y0UOY10kWVBSU55tGCnSnv/dDtmOjQoY4nkovGQe0kQN2G?=
 =?us-ascii?Q?L4Ua40v0Zo0nRcJoIJYw1D9c7m4ZpVsvNULpAcviBrqnCUm6Y6cIQ2/sgDdn?=
 =?us-ascii?Q?ppxhqqbX/FLAF9q3JJpP6crCVQL9KH3AHV10Kw5tMnsLq03NWO00rULrO+K3?=
 =?us-ascii?Q?jDlMVWvRo1PF1acK3yph3tyMAm7sFhCfGpWgYmck?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cff7a3-7831-4d2d-88fd-08dcf7f6dca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:51:21.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfsnSE1no5zcwbYv7tBKBDHhLH1qMHwrqMdoywzZiLWqwGJKiEk+Yay7tA/C5CKcSrN/P6vWIl23Z/bh8LL9gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5185
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, October 28, 2024 10:17 PM
>=20
> > > to
> > > a Context Table. This virt_id helps IOMMU drivers to link the vID to =
a pID
> > > of the device against the physical IOMMU instance. This is essential =
for a
> > > vIOMMU-based invalidation, where the request contains a device's vID
> for a
> > > device cache flush, e.g. ATC invalidation.
> >
> > probably connect this to vCMDQ passthrough? otherwise for sw-based
> > invalidation the userspace can always replace vID with pID before
> > submitting the request.
>=20
> You can't just do that, the ID in the invalidation command has to be
> validated by the kernel.

sure the ID must be validated to match the iommufd_device but not
exactly going through a vID indirectly.

>=20
> At that point you may as well just use the vID instead of inventing a
> new means to validate raw pIDs.

w/o VCMDQ stuff validating raw pID sounds the natural way while
vID is more like a new means and not mandatory.

I'm fine with this design but just didn't feel the above description
is accurate.=20


