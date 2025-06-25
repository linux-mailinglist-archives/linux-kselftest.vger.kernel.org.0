Return-Path: <linux-kselftest+bounces-35727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 155EDAE7549
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 05:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF9A1920A4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 03:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9031DE2DC;
	Wed, 25 Jun 2025 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mg1KAWrJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215A30748F;
	Wed, 25 Jun 2025 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750822706; cv=fail; b=qlHe4GEtCRljoup6RFY4jM1kDxEmL5onzBpvlsBc8MJ7vEqRWnLggf9jH+TCoe7UMVwSk0woVBpEwP1ZfdE+NQ3BL/Qrh+jszyi4ZTVuc6bC+ZTBAA0Iu7Hxc5vLEE7pHWs+96p7xJYP0UxbLqI4GwBrXEpXJpwOB1bwV6+7dRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750822706; c=relaxed/simple;
	bh=buzBB0kmo2qqa40fXyYLdtejoRUC1bmmNlqQPCwb8Po=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ioNZpoC4xeD733q1LguamrYeWwQVaKbqJwTDEaOOBlL4ny/1oQiO9Weo35t6AHTFpL+ymWgSqUVWTIX1Xd9S9Jf98Z/5Yv/jnt2dlGJox2HjGjDMloVW3/L7K8XX5CkpdwZDaE5QniiwZqYhPGXa8mhwor516ynRNKScCJ3pu80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mg1KAWrJ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750822705; x=1782358705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=buzBB0kmo2qqa40fXyYLdtejoRUC1bmmNlqQPCwb8Po=;
  b=mg1KAWrJ4feM9/mpSoonZN5Udz+XPmVXeV+tWQqGbdoaPwO/GSwv57x5
   LxCZb8j2eW2JbxgCsW8le6GP1J6mFtHsnu3EKNYtXxa8/Vup+yeJFZhkY
   JyrEUE6jx8FamC6e2av+yjOVYZR8rhLUdzGnWJQiAulPM+pJxkuF5Hy0X
   aZiVG2KJCWopwvoYFHbbgOuDoV40PHRhg1uAxc4DB6g60UGXTEbTAwFKS
   z4jQUhEdLNWP5LMpfLWSYqn0JVHkzSoRUnjpErfiR4Gw8c7SYIjb9YsFV
   0AKPHxSkEYUz/LIXx0y7nWcjPZ+tsiGQLXKJ4/e5JE7nJUfQhv8WG33Q/
   A==;
X-CSE-ConnectionGUID: fs/0kCoAQeqcflMj8dsukg==
X-CSE-MsgGUID: hZb3WsN1S8uhEtrFXAH0GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="63768521"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="63768521"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 20:38:24 -0700
X-CSE-ConnectionGUID: /DySXAkRTO+uI6ANcPwIIw==
X-CSE-MsgGUID: c5EGQ8w6SGuO6UGtwOdsnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="156127361"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 20:38:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 20:38:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 20:38:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 20:38:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7nckiSwBn1K6MCe7r8tVBdWJ94bWCXqVWL+2WEO9SmqJRz5PA+DdeSQcxVmnh+8pCi2hLbUCOFmdjIWb/6B6b1vcNb2b4IaldUgiinkkmvZHZjhK/VESl4sOU4N2ssoZQucahVLjfKEr1LvzgxBPQ9/INvN2taqBLv5jDRLJI80oDz119OfZEh1h4SXGArj5B8IGBrdETtqTdmGU8gudZ0DCCKVOg89/K98zoXlcV38svTeIXRX881a3S0QVJiAi87cQ/B0rfaTJennVOVlP7ah7H3UC79EYEIMYnpCuIGlqLpBfzjdWx8t6HS+TF2sAqyKPNc22r85TqffiRJukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srxi0TipO385XutJ9tfWuNzkqOFqEXaAfx+Q1zgbabY=;
 b=upz2EeXnJCHue9zYAhjhGg46GbDkMngZPVhnGnUAHTipCu5OcBLkSH6xR5DvS4QTYZ3wrOroUOEDaobExXx4Jghg/rF/onGa2issNyXxxLLId42MXYHmqRPWyXYKnTf72SmmE3GPMBl7kSYvrrWjXDtHwDiOncnFobW4hJSVEKgbG1c3y1pf6qmPEECYM0fYr29gW+0H3kYyB1XOLq/4+CC8z+ORI6R5HJQpnTWE4KBu1t4q8kCYBf5NEi/N9n8L40jQKn4TbjU+hacf9VLHJHyivMMorormXdK4vKcszE2373CamZZqMdf65GNm5XgcHgZzwdOObaN6YpIezfCF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6154.namprd11.prod.outlook.com (2603:10b6:a03:45f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 03:38:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 03:38:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
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
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v6 06/25] iommufd/access: Allow access->ops to be NULL for
 internal use
Thread-Topic: [PATCH v6 06/25] iommufd/access: Allow access->ops to be NULL
 for internal use
Thread-Index: AQHb3PwixsSBKEY500a4tk8lffzYrrQTSPmw
Date: Wed, 25 Jun 2025 03:38:19 +0000
Message-ID: <BN9PR11MB52766D0C0B12F1F10A6BE7548C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <e6a989c4dd9cb94aa4a98d46ed56a2afcb41b70d.1749884998.git.nicolinc@nvidia.com>
In-Reply-To: <e6a989c4dd9cb94aa4a98d46ed56a2afcb41b70d.1749884998.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6154:EE_
x-ms-office365-filtering-correlation-id: e56d750f-417a-4501-30e3-08ddb399ba56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bEDIcy4SJnCVM04j+pp58SQtpRxa8MF5Dqg0hq7ix1ROGbDnSdOUJTWAX6f7?=
 =?us-ascii?Q?IcDHm5/dOpRESkwHZbKdMiaTnxbUWDE4cER5HIc5FYG4FnbtTG8gh06eAlAZ?=
 =?us-ascii?Q?e8wcs3/bZgo9BpY2+klB8aWTyGIr3M4mesSG4JELhydiR4WYUUCB5v/i2H09?=
 =?us-ascii?Q?IReBvHdSeyz2KY0CYp25LtIkK8QoV5X123ahfZOgpATZ3Pdd/VXP31HMTVaE?=
 =?us-ascii?Q?HFR90NJP3lMmcSmGZZoqYNS1T7fYB0mBNDADmFOkXul5kuV1c8VIA5hglwfO?=
 =?us-ascii?Q?fQ9Jsdia/R19DnlN8rtnr7WOel4aSwse8mRoA468oCN/del9cE+xBoSQEyv/?=
 =?us-ascii?Q?XGGRxDZ569cvT2jNO439puMuQ8L3BeCVeE10dwpE/9g9eUgEmJ59i+Ierk16?=
 =?us-ascii?Q?DrpGIQ92YO+PxzT4a1a2Fa30wj7umiPMlYLTf6v9OPEC4oJGHq3DIYTTixx8?=
 =?us-ascii?Q?LOFKBfBTZNYbfWCHVadumUyZCm5Dt8PywTf6uj9LFYINvvvzsx1RU9p0N4XW?=
 =?us-ascii?Q?0XIQb2HN3IEj0S8UkZrTismVd8PGcp3nxS1sDTsl0rVfnVOrfiEJK5MpHNCh?=
 =?us-ascii?Q?gVaUUnCZbAt6dQWghhql8aDKoYYB8lbz9DKwYF1SIrycnsYPMjkn89jCLTGE?=
 =?us-ascii?Q?wvQvMmcXw92SAXKwnck6X3gc3VXv48ePo0BsuhSq4Fe3ewnYIozc1QnC86UG?=
 =?us-ascii?Q?eo3ZIypfy+px87cZfHsaBpapnMbdCIXMbGIIKdpHyZ4UwBHGe4xMdJXys4g/?=
 =?us-ascii?Q?22HsUiu/Wwzlk20o+qvrCS8Dx4uRQhMEdv5ANQEglg8ZiOgFIBqb7ltKNBgy?=
 =?us-ascii?Q?nxm7vXuB2nkb7cxNlfzPsBUVi/dsZ3T16twGr0YviczEdeCSq+GuJDCYWJ9G?=
 =?us-ascii?Q?Qbt4REK2gz2CSH+R4N2+/ONU1Bazjzd/vx+16ArqkJIAcTiPI0iN5pDJ85Sp?=
 =?us-ascii?Q?SxzFsBtN7GpsEgWAa73hFioYa0X4J1HTB7B+ygUBm9j1DgfWVMaCD/kZjUy0?=
 =?us-ascii?Q?wxDb08AJqvpbW7z1yo7UPI+EKKVitkW2YgDsPk/YGGDpDcK2CLFEjxKD9oSt?=
 =?us-ascii?Q?XUr8s1psAoDXv+pBwD00f6jEqJezq2br87ltt25HOUf5mAauSjBwICg1iQHc?=
 =?us-ascii?Q?hntGnrctbsUx5+Gi/89k/6we1PXQ2wOUJoaZAk5NmeZzR4uujERzNyvQdfJV?=
 =?us-ascii?Q?y+cUbqc8zZlFyRntn86d9OGqg6bXyVcK6hnTPuPjPl0BVkoiFiD0zUbGjLVy?=
 =?us-ascii?Q?FkJeHMQ+YkA9f5RVbHZsc8BTLSeNdY/3jH95Jt+PvdjsF2xXWoWn9pbXu4ar?=
 =?us-ascii?Q?1FCxZe+lMjawgLNZ4K1G3IHcfvS5twOt83y8jbq6VQ7YHWy9sQjhdizRYeK7?=
 =?us-ascii?Q?7pB7ZDPRwJTl1XtTlq4oq2+F8xhElJWv35eMSuLKmuwgyOMOZ+uC/DeiIz3L?=
 =?us-ascii?Q?mQ/Avu3mlZpqPkZZ545Mof4cUjoTLXjUfG5okS8pD4H28ND07pIc5wrlxB8K?=
 =?us-ascii?Q?g1MzR1hHb7J5SYM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UhdHqQTsLEZtzs9dB6jTO9xr+NfNaMhkq5dWzjxZbqCUond4xR5XKEnhp4jl?=
 =?us-ascii?Q?3+6a54frtvugQ9wH8uvYaQ13MQa098oOKEsfpi//Ob1YEaJeUNoFjQVy027D?=
 =?us-ascii?Q?WSiMR3hv6mEImF3YVASa4Y+mBv2SwIQl4ppckSAj3V2iLYrLLkDgtHfKbycb?=
 =?us-ascii?Q?9lEI7zicyzSwsgWncWxRN+Dr60pX2Z+2Mt//2o3v/4h/URgbMlTYB5AOn8U9?=
 =?us-ascii?Q?h76RHwHa9GnifVk1WY1IjUglKUBy6yz+BfoIO/5UWLn9knMVGZQbgXIFMPq4?=
 =?us-ascii?Q?1lUc0MExAStFnxgP0k5kvS6qradEM2bGeshjqPDwYGcPGuwIvg9xgqmX8W9h?=
 =?us-ascii?Q?qfW5Ilo1UvIse91EqY5Ka87UOztN2TQn6IFg5blwiM1QukF+bIlZWkWre/tP?=
 =?us-ascii?Q?SWLsvxQvrXUYbSZog2RUeqAFCUZ9aLe3bYQFCQVuYLpls1OSx1JnIfsMWjM7?=
 =?us-ascii?Q?vPh/qoJWNrMU19REJ08uzIvZD+nB3b+kflmalIh3Hw62FLYdYCrVnTAzE+BX?=
 =?us-ascii?Q?YPsKhd8+VrXMR6BB7obTfa61+zgiLXbZf6uSz4YfAc3WS6u4WxIyhjTFSQVL?=
 =?us-ascii?Q?bLKX7sL4sETlRAXfdH4brbZrWGLKqN+xSOMb2UPAxo43YlCWB3k9Evv3LZ6p?=
 =?us-ascii?Q?G6h5h+I9UZNt83r6hMeQ49+AmGdj8lZzR+aw2c3ntUFK6JjnvOm4mlzNE5Zx?=
 =?us-ascii?Q?QOUPvcZg7w4JXXpKfdtuz6oENBWwmfV/T2rW1+YzOkPA8ry19srGPuueEkDF?=
 =?us-ascii?Q?mAy6hVxSqeXGpS/1ACakG03cYX0Kzaw3LDGcZxXDlrgmxbxFNz9b9p65/XZ3?=
 =?us-ascii?Q?CDM+g4nbFaRcyS2EcRDx6aDhnfoGy9kJ8RF9JkvkFREBmOywg6tcJTiM32y7?=
 =?us-ascii?Q?4vvJvs8FLYhQRfsK1lDMPKruFVQXGLGlPRFinKQTOtkxtb0v1kOciPGJSbiY?=
 =?us-ascii?Q?4fXhH9d0Qjl6Ih/yMMAl5vLnvc6uU9Id0CEe/GcLZJsK0/Cg3yl0yjxO+mbc?=
 =?us-ascii?Q?NwutPhUGoBmW2E3Bi/Le8hgv6rGzRZWsyDEHfQd1HJLhRBQUIQ5/zwjBXdIg?=
 =?us-ascii?Q?ABxeBGMWZmDkjD08y6sOj0LE9UiButMWoFgajIFcd5iCW2+KJclpfgih5rP0?=
 =?us-ascii?Q?Wec9a6qg0orzPVacv0qfzZTJRYuB9Ar51JNQUa7LiO9ElXguPPqqxIG1g92t?=
 =?us-ascii?Q?6H2Kz4tV0gukRRRwEkUbjPDwXGwzPgLpMgU25WdMl2rJwmKGLfxL0fP0ETwC?=
 =?us-ascii?Q?IGFNPOltBnY4s8hoWV5H5GsEuH2W1QaWaSBgmJe7/oix5jywwiUZMZynQnFK?=
 =?us-ascii?Q?qqcBcHyCGVk0P18g6AbbMYQuLEf2x+CMX6maeWe8oHxNy9gAV0YbF8qDdOtm?=
 =?us-ascii?Q?sRuXiH+un/HgvaPt3juJL3dg9+E2b/M+7iC+DJL4dta336t4rU0qqOw+LeC5?=
 =?us-ascii?Q?TBuR47Q77z9pB8NJ8CJTwOcalioRvVZb2IiTnxnf5jn3zMCEjqvTw57Vnn3W?=
 =?us-ascii?Q?T1pYU9nBFjkE2dCu8qpxZs/2WynjM8g7a/zFScN032Bq2NPUosHepTxwRRUV?=
 =?us-ascii?Q?tjGqfLTULYffo9k7nNX6SPqNqpfUw9NwRGFpFl/+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e56d750f-417a-4501-30e3-08ddb399ba56
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 03:38:19.3540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1MeZyRl5rVtWjqK8H1R2rHB8pgb/pwG4NnBFtLIZHA+85OvfYmo45wiCtsFnuVgu4/D8L8lEidzt2UlS6UIaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6154
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, June 14, 2025 3:15 PM
>=20
> +int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long
> iova,
> +				unsigned long length)
>  {
>  	struct iommufd_ioas *ioas =3D
>  		container_of(iopt, struct iommufd_ioas, iopt);
>  	struct iommufd_access *access;
>  	unsigned long index;
> +	int ret =3D 0;
>=20
>  	xa_lock(&ioas->iopt.access_list);
>  	xa_for_each(&ioas->iopt.access_list, index, access) {
> +		if (!access->ops || !access->ops->unmap) {
> +			ret =3D -EBUSY;
> +			goto unlock;
> +		}

then accesses before this one have been notified to unpin the area
while accesses afterwards are left unnotified.

in the end the unmap fails but with some side-effect incurred.

I'm not sure whether this intermediate state may lead to any undesired
effect later. Just raise it in case you or Jason already thought about it.


>  			/* Something is not responding to unmap requests.
> */
>  			tries++;
> -			if (WARN_ON(tries > 100))
> -				return -EDEADLOCK;
> +			if (WARN_ON(tries > 100)) {
> +				rc =3D -EDEADLOCK;
> +				goto out_unmapped;
> +			}

this looks an unrelated fix?

