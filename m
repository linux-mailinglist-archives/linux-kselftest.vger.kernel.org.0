Return-Path: <linux-kselftest+bounces-20777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4329B232F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 03:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652471F211DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 02:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221E017AE1D;
	Mon, 28 Oct 2024 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bC/yDvsG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287CE2C697;
	Mon, 28 Oct 2024 02:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083926; cv=fail; b=kSOajuOCLyufXNmPDiHOpphh2hEPJzmid1GpeuyvDCAtx982ARztO6NP6nTG9OxQMnEUd1QByapMuegypzLFdB/rObTEooiOqwUE2DWkYB0ZtgnBs2E2Kc2V0A31EP5jccsAEXmmvI/HZnpkv/JChQxUi6UtTMNKEhxLDWtfIJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083926; c=relaxed/simple;
	bh=OsG8eOCMv5oYwULGoq5nHzXpgk2zGvvQTIF0g7E3ITw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLoFtJAaWrrLBRtslFfeeps2MSXNsAz3wxygg2pVUsu+EoEGNEkoQIfzprlIL56cn4wKeVmE+W4KK+rFCQQ7i0Mbh/3kUfF3QYsAND3oECY/NMFSU9C/XZrjT77o3JOMyRxknqufmlwhOhyBq5Ql+I6nCQnBtVR9KY3nVFu3gYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bC/yDvsG; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730083924; x=1761619924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OsG8eOCMv5oYwULGoq5nHzXpgk2zGvvQTIF0g7E3ITw=;
  b=bC/yDvsGpKMc3eSVLnW7JvoQHUCyhxsH5wR41P8KCl6zSr9c7xlKDXUO
   Z+nKavcDlFF9YhZgmU/jbM3PIrahKifGMZWmgD0mnHcG84G6nIFtBf4RB
   VPW098jLrPVCz0uXC4qbtwwN5QbH5hHyXj9oBnX7sB6e5+G3BPd8w3Tt0
   1TJpHUIyNFEuaMeHI2I9ftvgk5/ySKD7jhztV3CZ25pOLhkdHcBYO7re0
   q8xpSqvS2IHS5Nyv7TPxvAkgOcMKasn31DXsuKb32aW6jKb67Y9ScHZ5u
   va5mpVpCvvHBYVBNpD9WHUFU8u9GT0L/7e80/ktPG5FNLldv+ZzakNfZo
   Q==;
X-CSE-ConnectionGUID: HQCXNuU1SsaCxFD/lzFCFQ==
X-CSE-MsgGUID: 9hs4DK8TRH6OF1cHexNO7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52227080"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52227080"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:52:03 -0700
X-CSE-ConnectionGUID: b4jYBwJqS1qs2PBgSVy+lw==
X-CSE-MsgGUID: NoezTgFeTOmhWPE4p46TkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86582570"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 19:52:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:51:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:51:38 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:51:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdjQ2nknGDZa3hKBB/ogrfh0r9S57ZQsk4cTJlPe4oSIqIcDnsBylWa1VllkW7G0LSibOCSADMWwkjYe0gORtQxBSMdRycR2Ud+mmeMJv4+QemJhTc/qnfQfF3Q+e79o4vtITocoEmjMpwbIVygllBCilgRo1atOKZJrkP651Squ6T4Skn9zd8bpbo/pBgo90q7egkwcSR3WW7PhrLfSdc67fswiDdMeG1JjRv+XJ3KoHuSelAuKxwZxOg2NFKH9pkzl3lN0adg76SMsaN1cfM1CykZqDj7hPBRMUt63lXdcDTmItu6dbc0oLf4uCdJ5DrQnxepye6iB2qqSFDSNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsG8eOCMv5oYwULGoq5nHzXpgk2zGvvQTIF0g7E3ITw=;
 b=pIv3FZukZVnmJGtmHuMJritPzdM3XePetW8SfmpIDeCet9ITLfAZnRtskh1Pim8DVReRfoCjLMNalxkWSYAJmEJyJfQ2QF2h/87dFKcK4+NkMNL1XihmAQ6YK/4ObyteP7l6lO7xtGT9WypT+vURqk8eOsrvNC5uNMvy92L+FrprhtDDy5dJnrd8UL7UzS+bPuvafDXLz9mvCBckmYeSatSjcVf0zo1WOvFufNXg3qNUkIfITPp3h57heyh5xvHtlu3ONqegr+YjEvBBuU3b2tHJYWPDWbt8txn4JtEV8/IOvF3V7aQwIcNMTgK6Hw7+nOz43Td1TNGnqTeVlUO1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:51:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 02:51:35 +0000
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
Subject: RE: [PATCH v5 10/13] iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
Thread-Topic: [PATCH v5 10/13] iommufd/selftest: Add
 IOMMU_VIOMMU_TYPE_SELFTEST
Thread-Index: AQHbJzi/H2irHPAnpE2yt9GG7qub8bKbehMA
Date: Mon, 28 Oct 2024 02:51:35 +0000
Message-ID: <BN9PR11MB5276FCB471918AE46201AA708C4A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <30f593e688e881b8cfee007e2ed2eb7a190a01d5.1729897352.git.nicolinc@nvidia.com>
In-Reply-To: <30f593e688e881b8cfee007e2ed2eb7a190a01d5.1729897352.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5810:EE_
x-ms-office365-filtering-correlation-id: 8b8b730f-4cbb-44eb-cb66-08dcf6fb6fbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AN6bJZ0PlPB8oezm/jQuB8/a1CmTT50PHpODvI4vHa0+t5sI9UAzzo4b8u9X?=
 =?us-ascii?Q?DIF9P+YST52PNF8QNIAWOSgQATrHEEB3AZjCb681spvX0grW0TSGglalXtKE?=
 =?us-ascii?Q?q9oo+K/zzZE6gzqz4G4hj9qHEMyYhMpD+nkYZfvwl8wijWGPGyhBI5h8hn5K?=
 =?us-ascii?Q?CPdWDpo29U7uW/++VGXUyAbfJpgUpYOplarcHV9dYHYhzTobhZjqPEu6tZiL?=
 =?us-ascii?Q?zvLej8+3hvCNfMstt+Obvs7X00iK/OIO/e4szPwIp0fNudVib/4gSSL9jKtU?=
 =?us-ascii?Q?gKSt0X/D+MYZuna1dlg/vLzafxaVdlWKlEfUk9vtLpuaIqyCopUNE/FcOiE4?=
 =?us-ascii?Q?rNm1f76/sisL4nf21wnbGRSRv0MFkjkN17jn4xZyy/nN4jpriZrwUVwt2PO/?=
 =?us-ascii?Q?73GKKBJuUCRDyRfElucTCGuOoj1nKmsN1bP6jFzZJg0isAcB0o4iMeidRbWV?=
 =?us-ascii?Q?aU53WdtZdUc38AsuaU9mJtTOW5gNTQL//7UOjXoxvD9sZFzmioJyWvs9ER0S?=
 =?us-ascii?Q?eCkQofKDnrDXHm8EBfnj3eRnny41F6HMXbXF4ORxgNfW9W/mGMYQkIFl7aU0?=
 =?us-ascii?Q?lIfuZk0tDcrazQdhVZKz44Am3ALuuvrupsVcmIJ0dXOTr6czp0zOlhoVQSwB?=
 =?us-ascii?Q?PZXsJeGmcwIZgLsgoqFq5xi/xsX5EiWRXtpC9ATrjTX2yg94oT6HZIuECxPD?=
 =?us-ascii?Q?kAb869UkHrZOkquJcDt7RrqGa1f1o0Wtxc69rsVsDnkf/4k0rPzeNBYbvw+W?=
 =?us-ascii?Q?TLs8vm0XpItQMxb8CepVsCDBq3AnLtDtEcJXJ8b24nrywYoxbBKAgfDESei1?=
 =?us-ascii?Q?4jcTWDfxr99ntzFYintsig4B5iS6B/IUmvFh+sc6E5LrcWQYU39j/Mx6AvZ2?=
 =?us-ascii?Q?mPQv7DWPtQwIfTGxUWE+yy2alQi9MNUAsUexXKh7NZni8EK4+g3SzKiDKU3H?=
 =?us-ascii?Q?l88GeTyqZ0/Z46JwxWMMf3TbOrHHTTw2lk+kvZMng1lUwGR01+HRYzGb9aBx?=
 =?us-ascii?Q?RjqEiz7SuVFUF9hto4A5Acjn7GnF9xFZk0VbtT3eKITTO9DCdPYzSWuzvNKQ?=
 =?us-ascii?Q?xwxE43+qK2Amt42KNawHcc5hfxkxRkNgCSrSbOXlPakq+XZc50iEADG470nQ?=
 =?us-ascii?Q?OhPVBk2zx/0H7IsGQcp7lnGdNyKdZfFSTdVL1Uo31uqwJ3JLE+3vvYaxxHTJ?=
 =?us-ascii?Q?7TTHOk7eJWQUnJSF20OwNNcpHafN01raOUDVFNHaImtNY6Mg17ccSiDrCG0/?=
 =?us-ascii?Q?mCLXDJDCD5z6gZHl5lSr6aoktwoVTo4TY2U/T5W3gWB3mUDJ0Xw/1tAETP9z?=
 =?us-ascii?Q?fnJLq58gmpTtvCJ2dIV+1jS4T0YatXRpU8XB2dxZY3wxDwc1JlhV5VRtDuh7?=
 =?us-ascii?Q?CxGWpNI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kaUlVs2nvCuNRVoEoWuSqL6ldlFNhdyLGWnTad/kIOneKdEdHxuLv3bmAiFq?=
 =?us-ascii?Q?iGwdipgutB82Git58wPgaAzssNRQYZb3xtqmJH2rqEkQ9m2aDt5V1uMVYUuD?=
 =?us-ascii?Q?CiUydcBVCh09xJqrCooILbaEnogdbAHxXkoPdJrHkat0eRDQrKlgoQjixW7E?=
 =?us-ascii?Q?X7mjndfWO6w+Owb/ls066ImHZJ5P8hiwVmu8mIOupYKzB43hzIxoZBql2MyS?=
 =?us-ascii?Q?U4ET0rLBcJkiFU/yLJkjr1zmT5cfGhQrXEWLYHL9HsPPIcnVAUZ0fIqO6pYF?=
 =?us-ascii?Q?NH0ywo26nPQfO0PsvuIVfeE7ZN8JrropIc8bTZPXrnL3quaKVKkDd7SlBDKF?=
 =?us-ascii?Q?ZpJQFHlKBf/gTre7qJpykH40OSMi1fu+UjE6B0tNXgwxpjGNbV615S80jlxr?=
 =?us-ascii?Q?NCFP1whnsChd3YROUrUcrqotHiTknKbedcn+GgGQKeOXLFpP/fbE5kATfSpO?=
 =?us-ascii?Q?4wciTmOXohVAv+A4OKtdMU2u+/sTlmfliDr8ch5luQbrxzJznMpk3D+PcwJO?=
 =?us-ascii?Q?UdXNt4HYXZo+v+kAjPu2w5fxl9HkJLHdrimr8SPEbVPahoZbS+EjF7slgqDX?=
 =?us-ascii?Q?UVSxr+5kF4QvA3mbfvfFlx5K7svljYgwWT3k+vg/6NaSF58bIYaM9OD485hX?=
 =?us-ascii?Q?uk182JU419FPaTm1af2/az9eJfCswnw1lPjNTuWNiT+JC/1dMx8G8w3VJxK4?=
 =?us-ascii?Q?D8K2Vb6MALmHD/HSHssrQDHqRpubnj6AcxNA/jFIRTqMDjTkIJNKFFZKMDha?=
 =?us-ascii?Q?UVpe7kIILZLf3H3+cL6CmdGXZAwnf5MWpWM91H3oRtaXyXV4qdf4jjiUSaxu?=
 =?us-ascii?Q?lpR+QGv9yG0TpGPwEf3l+eVPyJNUfA0ia2vH881ppsNPKYc7GeWva06xGg4c?=
 =?us-ascii?Q?MN9i9dzjDJyvw7h9a/cd7nBjRGfdjMu2hhAma5nEDyuHNdgKFKKYizcBSbES?=
 =?us-ascii?Q?0WF0NJXuZ9VeMfIEHuEePkDXzMW0LUaGG+3fmkae0X9a1ugCD1aWExuNKhtB?=
 =?us-ascii?Q?Yzcuv8RrpiU6luxFoISf0E0rgqysNejJTj+bbjb+XzjZ0YyHeWEYtgUfl38c?=
 =?us-ascii?Q?afzQzllaKj+ZGFsRqHMH1uKlqBEc40Chxp3YAUZNz0BEZNwBXhJiaBcM7EJy?=
 =?us-ascii?Q?TNF+M3zwKhuqJTj4VzjOQ36VxAgZg81+Cxz+iF6EZCG0HINMmMO+g/Imp8et?=
 =?us-ascii?Q?MxWRCCsSIKIXJWyOifJb8LuvnmOpKy4ixTKX68UywkB7P/SAU/LgEDZv7Pms?=
 =?us-ascii?Q?6EeabXF26hA4xXdHNQqJe1oBZHd9q/sve9HAcGLT1FUMzzXqKhEaOc3NuVdp?=
 =?us-ascii?Q?6b9ggWXp+qlG8Nr4Z6RC0tUzr/iJrqaunlGEopBhnphATE4eQCgYuJSCnDW+?=
 =?us-ascii?Q?SEbjatUJUDmwzb2SiLr+I/l8cTx/BSgh0t5/+z0yzVskmGpVFCWnH173Dnm9?=
 =?us-ascii?Q?hlCzQV/biQgaaWpdIbzTm54cNVCD6ugKw/ituBv9swrJnl9tYtWxO5uv8hAt?=
 =?us-ascii?Q?0+IUUR0lwg/5UVudHAR7MSx1l1plfAttZB69uvWjFUBeClkZvyULvkSyN6cP?=
 =?us-ascii?Q?X142dk+UCJx1tJf5Sd7FypxO/pjveq0DfXStjMKo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8b730f-4cbb-44eb-cb66-08dcf6fb6fbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:51:35.1320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WOW8HEjjcN8IKRcvNKe/aeFfPvmfRKAl29JpmnLLnz420nzkIwG4SThc/C5p/Pz6HqgqwdLinXSyIL0D40FSTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5810
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:50 AM
>=20
> Implement the viommu alloc/free functions to increase/reduce refcount of
> its dependent mock iommu device. User space can verify this loop via the
> IOMMU_VIOMMU_TYPE_SELFTEST.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

