Return-Path: <linux-kselftest+bounces-33161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F51AB9515
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 06:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316354E0FA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 04:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D001F8AC8;
	Fri, 16 May 2025 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/3Vh/T9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3249C7F9;
	Fri, 16 May 2025 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747368065; cv=fail; b=Y+rI0ZUL60uCleFxaMQTWBYj9Ggeqs7gOpjGhTRNAA45hvQIKIjJEDyNkQEEQb9BinDSBY+Lu8o/e/VPXXAazx3TkC6Bxc5rLqi/LYKr9MRDQDzBGPWrn7Hyy72mfv1vuZLWKvPlKQtAmzG/soOLeeuQ6MvNPZ0tRn6N1NPGGlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747368065; c=relaxed/simple;
	bh=jyA8WLTNiPx6JPxkzcDavuj8Lr3u4OzEUKHvGXv+kTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iFyz37h1dUfsdEg+eE7GAVcF3oGnnSosbuZqaV/t5Cg1c+dfiPeZpWfdfq2q36cEINcfsoAfPhyywDnO5tkB3WyHFTZFiUYrlJC4662psQvz5H2/WFUDZz+xq2hJqsSNtFy0XWK/uzky8hdbTiJ3N0gju8sY/8ZjLjAQ6EUfmME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/3Vh/T9; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747368064; x=1778904064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jyA8WLTNiPx6JPxkzcDavuj8Lr3u4OzEUKHvGXv+kTk=;
  b=h/3Vh/T947maSyUacQ8DQ/H7T6SJpwI6TyDz8XPaAaI9guneS66ilbha
   PppEOy/vgVCbXqsLjuy/JXc5LKUZ0txxOsD8ZrlWrCZNet5VhSav3C8Op
   1zkcy9UuMj8vvrWwD0nNzbEYRtKpTMY5Akon6TW9o3LXU4AECQGwDoUh1
   W3SPjBIkV1SZhZUqEe/6CQ+3hMIDf3OgwvB2dGFEbbT18Ql4/4duE9/OJ
   /qSZcsPXGf3FGhJuIKr/hFTPKoBt99OLq6E5Nh7+CoLTdSBv2o47GctQs
   p6s4Hm9a28MAwfrESXN8Q1XgwFkWMTcfyDmX/YNDmBQnX6cevO4IOx81o
   g==;
X-CSE-ConnectionGUID: BfOi6G7qQpKzyTryantHdw==
X-CSE-MsgGUID: itZR0sXqQ3ezc9spw8fTKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59970229"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="59970229"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 21:01:03 -0700
X-CSE-ConnectionGUID: kqUeqzY0RcuIIt/QUA53Tw==
X-CSE-MsgGUID: DZz7OextRxSTImK7Nge52Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143806560"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 21:01:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 21:01:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 21:01:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 21:01:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBRn80SOOAai9x8bQ9BiHqP82wdZR3/RebTkJ1xN/YaopnMOPZa2bYWF83SOf545UOTwAy0eD6/zghmbC0knIxEZgKisJbj30l4molR46V9a2QHmSmeI3cRAcV4QfnO5sxw5I0t9RJeHVACZ1q4bNEcCnMP2KDWzTtoea+hGkgyFa23mgVG1k8s5hgclVmu7LtgO9rMy0J2Ef98P0um4pLuMr+7GbHsxVSPa+a+dxACA+DmZSYce+d3rDfujfpc74nD+9blclGt5FicreLLbmjSjuMAUgiT2Ua5y/0960UqDBnhyhfJ6R6wxWbQiRIJGOcwqfkZ0CsYM30ztPEwoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSEaOkUtq5E13Wfxk/GZ7yiz5NrApkerfp54M1BC5iI=;
 b=tSDBPuK/K3+4Bn0jdXHDGbM1uKJ1WfYU8rnNLJeC80ThQkQTZx8/kYyGqKkpcM6d4V735ECEvY1HwjVImFS5ppFePSa6D85t3t3dxBrmnoGaHyMwBsakHIQKmkeCw6guISPG7NmJ5UzFnKncJ94Qyat4L5kpB77I9aAVFqh+Km2jO4zkUvvIlt7XbWt1c1NxoeXugA8LOFcrA7WTjY99+fSoaoAF2SN6dGXI29QK9S6wcv5+4ue4BisWkp2Bqvsfbtj/4cYSyJLNCre4+j1Ik2MbuXxnXSKzymDfLdSjwv/dlYcM+8EOjK8XOWNRrQDQP56QBycCr5+8BDk+vUubDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 04:00:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 04:00:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v4 22/23] iommu/tegra241-cmdqv: Add user-space use support
Thread-Topic: [PATCH v4 22/23] iommu/tegra241-cmdqv: Add user-space use
 support
Thread-Index: AQHbwI8TP7a7pfTA+Eqp5zIRRE0caLPTY4PQgACUzoCAALKU4A==
Date: Fri, 16 May 2025 04:00:58 +0000
Message-ID: <BN9PR11MB527611498E2EB3A93BFED51E8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <a06e91b8bb4a2966dbe7fc3349502d38c3ba38cb.1746757630.git.nicolinc@nvidia.com>
 <BN9PR11MB5276D8FF50750CF35D0DF1838C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aCYgyyHwJsQvLLOo@Asurada-Nvidia>
In-Reply-To: <aCYgyyHwJsQvLLOo@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4847:EE_
x-ms-office365-filtering-correlation-id: ef2cd6fa-515b-4d42-b03f-08dd942e443c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0lRzVUG5l4ll+tkfiM9aKGbIl+YVEHA5MvEAXyR//c5aHfEAL4QR+ZkKrLlf?=
 =?us-ascii?Q?cfyLLW5vpd5Cy9clWbEhwfIf3UEes1+5r4TYswgiVurdNx1o0VJjiXOhG9GV?=
 =?us-ascii?Q?XgYPHBld0Retb8zWb5ymO3xzuTy8P1GCBBp2G8yZJDetJRulAZJFIiZAEb3I?=
 =?us-ascii?Q?KyckCgswECD+muHCYarGtdNCvDwSfgIPHi4KhKD0shS650J4zvmMAl6qZxhm?=
 =?us-ascii?Q?RLbPGp+3U7mAKhT3ibX8U/qwKAa2L0041MNg7DMDXOzo978s3GgBdSFvbAjF?=
 =?us-ascii?Q?o6oIiS9qYAUn5kS/OAnYbOm7sJkQ/wMuK9YOMS5O+1J3vCh0mPRMEHX0kVMS?=
 =?us-ascii?Q?lEmB8P35CuqtCITsKFLkeJ4ZjurynlWDnZpw9/o8EQXvQ8cD8moth6UxyINf?=
 =?us-ascii?Q?sl0JhggX9ZAQHtK9Njs5bn47CgZljw2lQ3JWaR5yxrwfdPeX0YhvWx4fMwnV?=
 =?us-ascii?Q?kfoyf7OQbD4HiwljK0D8JAf6xNIUryjIKj3rmaVbn0dUfwj9RsOTZsGZ+lsp?=
 =?us-ascii?Q?kimmZVN2S74ZLoUnS/NP0X9pakaOXClzaF5Eycnd/P+6Dxi4/8sx4b+ATsz5?=
 =?us-ascii?Q?o8MOIgzIGDvNkpBg5S1Ga2Gbm2sQkIXHk8LBxqrQnjcBhD1HAwuGV0VOJ+LP?=
 =?us-ascii?Q?rt+X6oO4CVxzbZMHkPAPMayN4a+lZvoHAbJHBjUXRpW6V+7ozfQ/6L6ATj9g?=
 =?us-ascii?Q?UKvBODkFEI53CxmSHtUJ5mT8blA16QAgXlc55QBaTXjvV1h3UHBLIYa4JmRW?=
 =?us-ascii?Q?ctuO4G8g7Nl2+XyfPf+iF79S+oB2OsThQ5pNEtM/3EhF0iurKPVpU8AsENJk?=
 =?us-ascii?Q?Hq6pNpDlNYrFcZUIzojQBeItqMgKtNa4g9qXgvTPcPowUotjefYUfEr2FpdP?=
 =?us-ascii?Q?dxF7p2mUgKwsz/xCymLLagYT49DjDgaStLdfqcxrObFmE4Rm5XyI4qabkmxq?=
 =?us-ascii?Q?0MTPOzKSuJCNYhz35wW24T3kQiohk8dS/Y4wPqbjt9My28ollj5SBkFHqeNn?=
 =?us-ascii?Q?VDupacHQ4QtcZv+wUa2FG85DWnE24KsDO833aZ1shY3ogyIrJwsM17JB1Ifh?=
 =?us-ascii?Q?v9lZRuk4j+TdmdkcHIrbDwUNTX14CgBDDsWyyNKeWM33LqdJsDCrC31BWmI+?=
 =?us-ascii?Q?Chg8Ok+HH+2zL1rHVFEzkbbkziXYFO8twrQxPc9LOc7VYevuzYYRtD5nXzBa?=
 =?us-ascii?Q?KSJgLPwdV71ngf0zq7PPLXDcTnax/y7psPKw8aTxV65HduNAWCLjMTXybY6N?=
 =?us-ascii?Q?VrTPPLLzVlicJbhK57kMOlZ9QSMgy33AOgEYa/yREXMz4p3RPxL00mXWBxb6?=
 =?us-ascii?Q?egiUtqSRPyVUc1CsLG5hXedXpxFx3YX1lwWByKQ6uSvjVvDd3e/5pz+5rIjI?=
 =?us-ascii?Q?dmDvPQppnD6GytMqPjo4FJm7WTbCt+ER2ETxINd58eDIfxUfLctU6FAa4yJ8?=
 =?us-ascii?Q?f4V1rrnSLa7+L5XdalR/hUe89hI4eNZwpzZt2sijTcWp22TcZxRhug=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OiNeUXeEuIWYClU20GjzpRvbuVbQx22eEiS2fkvazwR6q/1YEN0lEH7HSJc3?=
 =?us-ascii?Q?WIS7H2Hknz0SbVDFY7kDzqLvdcQAykbTTWqnhsG2Xf8XKGpr6jC600dvfvbJ?=
 =?us-ascii?Q?bdm7G3V6Xm5v52sazCBQRbQn9rUDJPm/2gAxTb56O9B4ZlSQuEgYehEoNErF?=
 =?us-ascii?Q?pIE13LmpWBEQ/USgw8lG7nW4qRU1In7q9i/1XPvkqg9QzSkm4yxpMOgd575G?=
 =?us-ascii?Q?WialRPM34CmYLymtkseytk/LgWHUa1lC9bDL0gbJ0qjq8gOeoBMq1M1y22/H?=
 =?us-ascii?Q?+I8ziCnkISlqu0B/somcN3LextxFkFDRAsZcHY1ZVYzhPO6rhbkUn6xSaE12?=
 =?us-ascii?Q?15IQ850W1tM5rPiQq8qcM8TKuDbveZ7fAq9V7LyKa+X6hofTHW7huO2kz0UU?=
 =?us-ascii?Q?hmjA1eF4D655vQ9Kn1iNYuqNwBJ8S3OyP56ocFICaxCbkv/hiB/HpTKRIgzr?=
 =?us-ascii?Q?HDG+MOEkChN48g3SPF+43L/RjCmOqxiNtAF56BDLjSY3UmNZQ5RQyo/M+6+T?=
 =?us-ascii?Q?EHFFgzWux8XXIi+WGl6Nh/iP5W2bTjCx4/cRcbVHZyFO9mzxsCfccZXWD4F1?=
 =?us-ascii?Q?4daWHjvu1tJUZQcsEjCP4eUQNhql46DMXlEJ3Cy3c3jirq+DxQqJmFXv9gdq?=
 =?us-ascii?Q?4SVEDAcHcWa23fO2QnjHlSsvJSxo2SuLL9aW1b/OrtA2R+sJ9g5kSr71IL03?=
 =?us-ascii?Q?bUFF+9eiJx/pZKJV+5mF/IlXKiFGpyygRjttALRBGPgSyLIJxcF/Ji/oSUSV?=
 =?us-ascii?Q?GKJ4zCSEDwEyIbC3eD3TKE5fBr7Su/8wuaYjUlgfXUwm58jpbIxZTQOizhbo?=
 =?us-ascii?Q?N07+QgdZdkjwHkv72LBcYdDflDsfiS/GG1Z7sgsAWG6xcxF2iaQRx05+Z0Yd?=
 =?us-ascii?Q?6y2c83ViIwoLCbBG+OYW9yYdO5qjVm4WC+Z2GpEzma9YdSwrA5Dgy8CIty8h?=
 =?us-ascii?Q?0uGcvL2eDYVFwSmGK3yJhpC9Bfsc+ov5j/Ie+P6PN14IT7vnBDuDMqQ1Spom?=
 =?us-ascii?Q?bhW6zdiFClNi+TBgSAbgtgdaqgoA7iM0jBLM+OFRTX3LRLpAeB7arX5fC5Zz?=
 =?us-ascii?Q?wPyn1VGfUjk/q3JSI2S7uYOxCu+Xk7GlsJG2ODdGN/yk//DYpX07t2malIxW?=
 =?us-ascii?Q?kDKcnkWpBsGn5aBPEfqgpNkQLqz5Zxq6V7OrDQdCtp7nytLIZFbnjXYwYrk/?=
 =?us-ascii?Q?o90kQWADkYBWfs4H+b5tl+YG1vMEfIM/aezAw9ue9qO5ytYuPWj14dszBTv8?=
 =?us-ascii?Q?WZJKppZzlBiBEcIZIlUpNjjXUQ6E1wo14OdErWRCFkHXPh1jNQTbwYlJgfq3?=
 =?us-ascii?Q?vQ5B3taftVRh/sh7YYvx95GRf1oO0opfvreo1pXy1qpvvvurG7r1s8+NY/zy?=
 =?us-ascii?Q?SzFo7FomJ0F0/Mk5OhbtHkJqTfyKQVrzH5qmYCtzYtBlKRoZipJam8ioCUJX?=
 =?us-ascii?Q?SH/jbeeXsoAQ01U0EzHDP9lJgoslYvbZXM/we8utVMpPqEFuLICZwPOy0LfN?=
 =?us-ascii?Q?MBWZ0bgtursq3/NIUi2HO5k5YSWIiYEZ6aZSEoAkA5CoJ03DyA/WmWOjMHGC?=
 =?us-ascii?Q?2Z1YHhFve2CDpS9mMP3AzyV/Tsg4CPODSejOPt4T?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2cd6fa-515b-4d42-b03f-08dd942e443c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 04:00:59.0144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqTGmmanB/4QO71pyKWGU0fWYpJ8P5jkjaXhgQ7pT8b51YSzOsftYbj290wKIJGTFWPPiM9HHSJUr4vacFO3lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 16, 2025 1:14 AM
>=20
> On Thu, May 15, 2025 at 08:27:17AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Friday, May 9, 2025 11:03 AM
> > >
> > >  /**
> > >   * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware
> > > information
> > >   *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
> > >   *
> > > - * @flags: Must be set to 0
> > > - * @impl: Must be 0
> > > + * @flags: Combination of enum iommu_hw_info_arm_smmuv3_flags
> > > + * @impl: Implementation-defined bits when the following flags are s=
et:
> > > + *        - IOMMU_HW_INFO_ARM_SMMUV3_HAS_TEGRA241_CMDQV
> > > + *          Bits[15:12] - Log2 of the total number of SID replacemen=
ts
> > > + *          Bits[11:08] - Log2 of the total number of VINTFs per vIO=
MMU
> > > + *          Bits[07:04] - Log2 of the total number of VCMDQs per vIO=
MMU
> > > + *          Bits[03:00] - Version number for the CMDQ-V HW
> >
> > hmm throughout this series I drew an equation between VINTF
> > and vIOMMU. Not sure how multiple VINTFs can be represented
> > w/o introducing more objects. Do we want to keep such info here?
>=20
> You are right that VINTF=3DvIOMMU. This is a per SMMU instance ioctl.
> So, each VM should only have one VTINF/vIOMMU per SMMU instance.
>=20
> For multi-VINTF (multi-vIOMMU) case, there needs to be more SMMUs
> backing passthrough devices being assigned to the VM.
>=20
> What exactly the concern of keeping this info here?

First, you agreed that VINTF=3DvIOMMU, then "total number of VINTFs
per vIOMMU" doesn't make sense as it's fixed to 1 in concept.

Then, each VM can only get one VINTF/vIOMMU per SMMU instance,
and this ioctl is per SMMU instance. This also implies that only one
VINTF can be reported in the ioctl.

In multi-VINTF case, the VM should get 1VINTF per ioctl from each
SMMU backing passthrough devices.

Then what is the point of " Bits[11:08] - Log2 of the total number
of VINTFs per vIOMMU "?

>=20
> > > +	 * - suggest to back the queue memory with contiguous physical
> > > pages or
> > > +	 *   a single huge page with alignment of the queue size, limit
> > > vSMMU's
> > > +	 *   IDR1.CMDQS to the huge page size divided by 16 bytes
> > > +	 */
> > > +	IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV =3D 1,
> >
> > Not sure about the last sentence. 'limit' refers to a certain action
> > which the user should perform?
>=20
> Yes, set vSMMU's IDR1.CMDQS field up to the huge page size divided by
> 16 bytes, e.g. if using one 2MB huge page backing the queue memory,
> VMM should set IDR1.CMDQS no higher than 17:
> 	2MB =3D (1 << 17) * 16B
>=20
> Certainly, it can set to lower than 17. So it's an upper "limit".
>=20
> Or any better word in your mind that can be less confusing?

No. I misread 'vSMMU' as 'SMMU'.

