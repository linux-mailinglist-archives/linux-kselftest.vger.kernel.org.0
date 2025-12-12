Return-Path: <linux-kselftest+bounces-47477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F70BCB7D70
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E7933007E5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 04:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494A26FDA8;
	Fri, 12 Dec 2025 04:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdkzrSkM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46219067C
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 04:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765512691; cv=fail; b=GM/9AAxVMJKHr8YUSjFRlpAhIKKd8ZfH4x2LR2KIqKo+JWtO22tfK03YQnc+g4sGTZS2U1kGjhDWt1N9zJvOnL0TaPAZdW/5q28IUFbZ2wSQvvMPzXMY6FymxwtMaOsp2PHI/DHPZ+SNYDN5mAdagVFNQj/6Kzs2cQLXELs8V1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765512691; c=relaxed/simple;
	bh=NGIi5NvBMDAyJ4DsRgnLawAfCEaNb/itX0ANpmLRDbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jy/Ox575il7zlTV3OHTYRVA+x/OE3waZ/DfWu2bIGGrXUiQzWKmgaMdB1nIy5/PcIuxNA459/7bXDJgseI7jiCdODt3nPtPsHa7jZyiSKkj5bvI9iJ/w8IUwsDFgfok/WbGJAL0aV1zViOMu07fRHCs2F5xLqsp068Fr5HcuBcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdkzrSkM; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765512690; x=1797048690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NGIi5NvBMDAyJ4DsRgnLawAfCEaNb/itX0ANpmLRDbU=;
  b=VdkzrSkMYIYgK+e2pvV4VkHOycvofhWyP2Ws9HfsYIQyMzXYOCFy3qQY
   dg9s4xaZfDR2vpbHxzErsrdF9PnCAk146zWZOxHTBwU0rydqlcK7IkbFL
   edE2CmpIFTHust+ZnFVYmrOBL2o4XAhy1Q2LqpMQZZc4H3s/zoCPF5euW
   hbKfIGq723rnD9moFD4AZhVolwTKqLWXMH0hFD0mpNEstoybFBbOkwVSB
   3PfnsCaD1bfu0zf7d6EBTjNzzOdh3hk/CwQDOXDqZYZoltY0j2rcfbZUK
   1pu4tqHC7dS++YBdOD60Qj6kyJVMWggwipjV1nTDjNBXvKAJQkfA9Fa5Z
   Q==;
X-CSE-ConnectionGUID: W3Fe43YASiClQN4v1/DenA==
X-CSE-MsgGUID: zftAypSzRNqwNLHwGLiPOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="92980439"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="92980439"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 20:11:29 -0800
X-CSE-ConnectionGUID: 58gqhELyQsqmO4jZdu++BQ==
X-CSE-MsgGUID: rnoDG3aWT8SA+Gqc0IB/5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="196267108"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 20:11:30 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 20:11:28 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 20:11:28 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 20:11:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VC2AeDBU6waIQdF0Ld6kOtsD/13Pw2sqPRPVFnmXOtYVkkQ77xppdjZhEVfUwyVQI3du9/vICr9QmjNZFJ/JT0phkKIv/Rj17YvIhSGYil6YT8gNQXyZ9wCN9Oq9Cdv1D045HYUfUHuggO8c4aAgWuiFv5BgWI3ItxsuScKk5OQrLJo/22Xr1feLd/IauZWLPLbNvWBvbFXQDx3uJVes716Af6V2Z6dYVqMz6zx6h2tj5OhVRcwaPtcLhR3KVKPeddNVRITuo91y8CXVpB/3oZcL3GSljOEgWXGLGYUdfbOsJ1hX5q/Bc0otClFMK1AI8Ip1vtZKcTh4Er0HgAE7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGzjaKzztpLCvLBsdVlBvBTtoEneM+fCFDyFz+0jPdY=;
 b=w8u78mFP5XNRSn4qqub1iUiVxq3CY6jEhK0yIt7rt1kbndzZRXTlPnl7odcQNNeC10i0HaY9tBpWuWBG/zhikr81QArqnJU/TaUqA9bWiF15PoI+tXckEGWqkFUBNyAxdMfb65FbV23nay1c3M+N9NXIOxOLJJwwUGkBNHpiDGW3J+9SXT89w3zYXn5/NxpbSf0HhK1ismtQjgw+wPhEPFjrIwqCs+nkLDs22jg5XjC6OXKJEZrbrNlivT8cuDhah3GNQb+YGAG4c/PmOh29yhqYiMBoJKDa2vM8Tp0isLWPY/G4FKDc1xhTGSmXgFUgXFVX/uIuNINiDUjXcEAqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 04:11:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 04:11:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
CC: lkp <lkp@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH] iommufd/selftest: Make it clearer to gcc that the access
 is not out of bounds
Thread-Topic: [PATCH] iommufd/selftest: Make it clearer to gcc that the access
 is not out of bounds
Thread-Index: AQHcZkjofyPkDFX6oEaxO+CT3WQ8nLUdbiLg
Date: Fri, 12 Dec 2025 04:11:26 +0000
Message-ID: <BN9PR11MB52761FDCFBD3E58EB1B67DAD8CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-63a2cffb09da+4486-iommufd_gcc_bounds_jgg@nvidia.com>
In-Reply-To: <0-v1-63a2cffb09da+4486-iommufd_gcc_bounds_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6533:EE_
x-ms-office365-filtering-correlation-id: 88b2602d-d65d-4449-920e-08de393484b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?mIdfviNDeTZNWVw1RzhPO0VBPhxhAkcxXZlEQbfh2XSZ77OUW2I6nNYgh/p2?=
 =?us-ascii?Q?62iRe8koaif6FabERZH1Hfx6os45x14FSKmz2JgfF4RCyjuwjHY7qgmcwkLr?=
 =?us-ascii?Q?eGY4SmKcnwqpXikiBX5rV84RZslm60Iooq8zX9C7jYgRrKvFCqtMpskHWnoy?=
 =?us-ascii?Q?m47syyfVmOhVQ2+JzL8+ACca6bNKsdba6/gSzGw8r1kYC3T1zDMRtuZ5i4ZD?=
 =?us-ascii?Q?dpL19p0mAdmKzryHTbsqU26YOlxB2yPfcXKu94/n4u+IjZshzLfXHdfKir8x?=
 =?us-ascii?Q?rCsMZHGzyyOeLpJOLXkPEZF9X91IzOwoJEO8SNnPvltxWypt5VGpFCFHyjd5?=
 =?us-ascii?Q?qACZM8SUcJCEBgpWp+Dm1bnB69GKSr/z0MZWpXXCcsV2d2UpErO9sNM2Gf0Z?=
 =?us-ascii?Q?bkQAFTP6pqOQT3XXWwjVSOw9HPWcNPkMMy0YLudibsGbtMW3/Jivlt/dP+Mt?=
 =?us-ascii?Q?pg3Osj0ipJcYx6uF2Qj93kUW+Bu+YSNTvzAvFVEwLA6ZzJ6OQHtAJXG5zKll?=
 =?us-ascii?Q?ltj8Q5XT23DKVD9RkxIcX9rdzXE349iGru5516nV7KcWd8ux/ZjkLQG8dGLT?=
 =?us-ascii?Q?uPqTDPBJjAAcOa9/2NWfdeBHDOOfduDNuvgMWlOV191PMX7Fojx9UV7nA6tO?=
 =?us-ascii?Q?hjImZ0TRIKlmDslbuXyTLpNHWZ3UuRWtW8ZmtIyjN9KmwSeugqGLTJznlGvg?=
 =?us-ascii?Q?Pzme43JvCfzBgUYbIglV2b61KXpUnFx220LEmCywVXB8K5r2k7Yd9T0PIsZ8?=
 =?us-ascii?Q?XGLThy+SZcKdM/PXFUTcOnjRNdUG4ZOjpeWVXmvptHCA8J/ItAQ56j1hn4YM?=
 =?us-ascii?Q?xpzpGTUWdR9cfRhWioo8y3u5QGX3rZ9MIGjVa64p/5/t89qL6BLHLq7qasae?=
 =?us-ascii?Q?X5oFlJgqnuqqgoQf52fuTX51Nf12t3cvBV5RLgRiUHt7WN4vKHwGGUNPnuIZ?=
 =?us-ascii?Q?0bvM9TkF0fqYZUJzWM6VMkj/2JmW9gXqFwc5W9C5T/iO/W4DHaCyzGsdDLAU?=
 =?us-ascii?Q?sSYFX5ZzQdiy/cb8SvHz3+caKGWaYNfcme3TdA4Shbd84kXzFX93iiZ+ttJO?=
 =?us-ascii?Q?9GE1SnlzCGo6adLHZAjGJsNsd7WMBTUKB1wDyHubevFGqfDkQPqR/F+Q+h2U?=
 =?us-ascii?Q?fWwRydCPC/oo5xRP5Mt/2LVQaluE5c7+EuiaOPJ469EZ3xJ2DM/ECPytXVrW?=
 =?us-ascii?Q?v9VK57z6AL7g+IFq6TwE+Fz0AbbAL3gSdASQ7uJ0kT28hnR2O1h10jDVMno4?=
 =?us-ascii?Q?BFdCwvscw68mq46qU91l8pjx0E4w2q19x4cRR5zkdMqUgK4aKpxYsU2m9QQd?=
 =?us-ascii?Q?Y+B0BVrwMHlu1YYS3uvbOqLg/vCyDCvLlbpsEkKlzpozc2ct5aK0TZQB4sDN?=
 =?us-ascii?Q?5DlFqIGo23gFFlhArcgNMdu5aG1uR6jJR88+lViD07WxzIGputq4+iPtuIXg?=
 =?us-ascii?Q?aOMQnS6rficuIuvbq0SjRVQUGCtDvxgyIeHjC3juBtmurprhGRLQyss0tVb2?=
 =?us-ascii?Q?/n+Y72HsfwVzsQuGKYuMwilr6okkYyIJdCo0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DbIItIYqMXwY2tHZUdPCsTnOSZHikGbF8Z9UccFcJnGaVLpLlrUqCmLVouMd?=
 =?us-ascii?Q?5AjwvPM64UTPa+nOBxOQfGGeYpuNPhBugaabYUz9SLYkkPGWew9vDvScsl1K?=
 =?us-ascii?Q?PjTG2QFPncL+6+nUrEK4Y+wZRdXsdX7qVT5VVVdRikwFvyuO/1OLjVBWrfMz?=
 =?us-ascii?Q?tqfrK7YdWFgIkF1mSh0gAzbNgEFn7FLT6q4LEu2/+siHAO4Tpdm1cg9pDj1d?=
 =?us-ascii?Q?+trlRNXkFNR6cp4kwirvfiJ+Z1lhL7dz9IpGgIhWemIDncyqfUAMxA+WTvU8?=
 =?us-ascii?Q?ru4XKH13F7jDAnO0QV+Fb64CKqIAGUlBez6fT++ETjRNMLmQ+LD3NBH/TU9Q?=
 =?us-ascii?Q?f5iQrKY03XmdSy5welZi2hFuF2tTnlB+OMAVnaktBPkjrM04O4wq5+xpWOG5?=
 =?us-ascii?Q?cA+ERI08nFoJfBYLjJqgHR0T2lY/2xzQst7o61kjPqbucGpj3aGI1fwIJolH?=
 =?us-ascii?Q?VoMjjEHXj1n1eHUw+M6ANhpAzYD+4kaZ0vWV0cVzy1zZMCfKs1DWRe9bkm+X?=
 =?us-ascii?Q?GbV66R8UD6ujDY2dCAAe6eDm439icKrHOi+7mVvZgkNoIdH4Fm5nzey00LK2?=
 =?us-ascii?Q?znWJJonBFbm4AVcZS0lRjD4j7obduN+ZEe52aicHONskbN87EA+HkMoNF5Dg?=
 =?us-ascii?Q?NA/4BySnt5mIdlCeStMW6+ZandTcGtu9dl8llg6yy9oearJca4cUUI5hZ3NA?=
 =?us-ascii?Q?fsw6DLDoPI5Vf0eys62sXzWJMEdGyoSb0h3lLuw9EdqOLEKlyFpkIVO9Wqcr?=
 =?us-ascii?Q?1pV9sWyHYnbuZ/WXwTG1URx1qLimEHaA5Cnu4Qr4B7+FTBAYWOqX0vJ3dT+d?=
 =?us-ascii?Q?iOcrWr+G65PcVTAjEG3P8EoqwLEcoSjYg02wgGkoHO0sbkR+uJGPVBpF9WR1?=
 =?us-ascii?Q?o9nOMO64Ewv5SljE+UfNnt7Act0NfE8gJtYHhAB2uUhbpHRpSb2BWz6hqgZi?=
 =?us-ascii?Q?3JxmR/59+UcdMkhHKeAvME4c/ZSp1ZyLzPWs8M999axCbsju5o6PNg0mCsri?=
 =?us-ascii?Q?IymyWP7NbEdyVDkMxK1P0hnRRW9gzjh2BfDK6Z12a2fyFYYwvXP2enD/I6zL?=
 =?us-ascii?Q?quxaw0oB6fk+LW++dT4M9eQlw7/Bu43HzudtjVGz5QriHAavp5nsL8Vn5fwR?=
 =?us-ascii?Q?MSJMDFMjww9Ecg37ZHs0b+auoZQS97tHRnilGC+i+9AOGwfHS32J7IdGPlfG?=
 =?us-ascii?Q?b35t4UWtooz4iceWhb0GIchGmzeIN7TBa3ibdW2y5jEanXswD5iA+UGmQJRY?=
 =?us-ascii?Q?jdnPx+xaLmqohtQcHfp0n+f0Z0tOpl+DatcoBMaiNTGB5wdraf792RIjINr1?=
 =?us-ascii?Q?cXdYVm8iHRD+rCXgINCLZalcJ++aXWCFwLJdodFA8xZfLvCyAakeDGFSelfQ?=
 =?us-ascii?Q?rM53R1QnCZ3p4AWsfc1gxzMWjd+OrPcEA7JFLfkt070RVuJGCBQbMjRr310W?=
 =?us-ascii?Q?Q9iVF9ZFSIbpwRi+dPSabRMJjAvuvKvwDBURr1ybKCaR8a2fFRxonSkeKi06?=
 =?us-ascii?Q?lhgEkR/ey0NZ08KfDFDgB6tSVXQTvVOVi91F+RkpxfKlnRh17fy7d9M/czt5?=
 =?us-ascii?Q?1iCSzf7oja9K5j92eLWizVr6KMGmJ1azSIEtXK9e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b2602d-d65d-4449-920e-08de393484b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 04:11:26.0746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cg2YPXFS363LzDqaC6U6ALmgQ7eyA4FnvmjOHBrTS0kkk5g5bnjEXG7h9mhDNtEqXWBq61n4VT5ck0O5SasEsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, December 6, 2025 8:40 AM
>=20
> GCC gets a bit confused and reports:
>=20
>    In function '_test_cmd_get_hw_info',
>        inlined from 'iommufd_ioas_get_hw_info' at iommufd.c:779:3,
>        inlined from 'wrapper_iommufd_ioas_get_hw_info' at iommufd.c:752:1=
:
> >> iommufd_utils.h:804:37: warning: array subscript 'struct
> iommu_test_hw_info[0]' is partly outside array bounds of 'struct
> iommu_test_hw_info_buffer_smaller[1]' [-Warray-bounds=3D]
>      804 |                         assert(!info->flags);
>          |                                 ~~~~^~~~~~~
>    iommufd.c: In function 'wrapper_iommufd_ioas_get_hw_info':
>    iommufd.c:761:11: note: object 'buffer_smaller' of size 4
>      761 |         } buffer_smaller;
>          |           ^~~~~~~~~~~~~~
>=20
> While it is true that "struct iommu_test_hw_info[0]" is partly out of
> bounds of the input pointer, it is not true that info->flags is out of
> bounds. Unclear why it warns on this.
>=20
> Reuse an existing properly sized stack buffer and pass a truncated length
> instead to test the same thing.
>=20
> Fixes: af4fde93c319 ("iommufd/selftest: Add coverage for
> IOMMU_GET_HW_INFO ioctl")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512032344.kaAcKFIM-
> lkp@intel.com/
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

