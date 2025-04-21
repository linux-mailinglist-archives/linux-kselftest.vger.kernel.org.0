Return-Path: <linux-kselftest+bounces-31240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EF2A94E29
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 10:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23AE170634
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6151E212FAC;
	Mon, 21 Apr 2025 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCHp3uAA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186113C3F6;
	Mon, 21 Apr 2025 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745224694; cv=fail; b=bBbk+iLaknKhd+gNG9gY88D60uEqo0UzdpFFr7GX8XGl0oU7asNPoy4ru1Orrf3ZehUSVuOf4+nEzEW/FGM3T9K+xJJ+KXxAljDFKsmtpv5H6lFueAwmFEdWseWw/StZ5/BhDIkiBkeM1y9MAyecufEQF1QrD9PgyLQcwjnHSTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745224694; c=relaxed/simple;
	bh=PGAADeOvcD4w4y0LBZIvIkFtbMgUYirgTk1FjeSePvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qSp1m/+OECfIZsqXkAcBXfTPqthLxfRCfILXcLJhn+i8Z1Sz1R3HIDwnZL8YrNIwBkLKJ3jVqB5s6yELTOszP97rTspA4IrjnPtmrO74/BCWWOhHGaChgaebRK+OeUaXQ5Bt30kG8yJnMX3RGIYSUeFqY//XykBM0JiBelr/sck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCHp3uAA; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745224692; x=1776760692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PGAADeOvcD4w4y0LBZIvIkFtbMgUYirgTk1FjeSePvw=;
  b=JCHp3uAA3RZxDf40H6yS4/8/lA142YKl1PmC1iFnHvQkduHBNXpSLGNj
   RrYVV842Xmvu/MyA75LGChl/WZQYrxtenrKEJHsd2DBxkIc11qZ6OVWpQ
   8FVnFuMuHRlJJc2IidrDv+g26+fXPyQJ42N5UChC0pjQ2s8hp1eKsPc32
   xQq8bW8I1TFOJ+kXiE0paXKVO3wBmA6uOSz54Sknuu8w4+L5tq/x+oesa
   IKlYgM8Y9qVCRC1btyJrfETChF5Z6YhI2Mz7YQ06TLIbrRVlm2H0exkmc
   1hKxvEXCOxeVp1dSnFzJ+K6mqjVGFDUQEGUROl5eOURmNQPfiHnBj0QuT
   g==;
X-CSE-ConnectionGUID: BXFfQCJZQemIht9NzUf0og==
X-CSE-MsgGUID: d47WzJxqTJ6huFKvXKh/NQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="50551179"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="50551179"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 01:38:12 -0700
X-CSE-ConnectionGUID: AA4wZNLHR1WInVVnxYMWng==
X-CSE-MsgGUID: xzfYJOTXRimTunUUQ6si2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="136626062"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 01:38:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 01:38:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 21 Apr 2025 01:38:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 21 Apr 2025 01:38:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kx21pnwGA2+dnCuXWM+t4YXoxft9dT558BHDqnib3xZnXeQIVo5PL0dUEa5mrr/vxqvIWCWK774d9yTm0DZj7nAabK5pz9ok6qJspaSQPvZdMg1Pxq7yskUSnDVCailf1OAKmYQbvQuYZof0S1nQmzDRn1oYu5BMH8KlaeXp0LWatLvBWsT27fT1LKE4Po4Vc+90HIqZAJNsKBUfwv878puqt8gbDQ1nqPS93EsCCK5j/VTZEpD6bEZSftBaDI9+uNzD047xYE06yGNOJ8Ugclev5IHu34UHwVloYwsbCMVrkiSWgQIRWhZrwOBii2eoQ/ER0Z7n5CsDOGtm/IFI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bd+QKtcVHxggcLDyCR8yEIXHpl0XdsekvSOnA7G1llU=;
 b=WQqXkuCvxKe7a0n0qySP6zPdj3MGuCgF5CRpOc7mHi8pVfwegTkbRJz37S1FRSrbzi4apGrpJjHoepJfPAFsmKZ1P9fm7EXvpDo+ilJyLlu6fU45dOYS9hmdHuR0dvMGRxtV2Nz/mSOnIj6tWopksFMEBUGKMHYjLSFMeQ4rYHr4sO48+cV/7xlhXJBLGG9EEGs3NIlXx0vTj8I7bSCsJVvJGx9HjybRb01oU2dhONDgYwaqIMfJxm0gNQgvdGj6mxEvVwhFIP8E37XsfeeWclyNeCw6UWVVJPcZEkKi5nDSR/0PYQgIh4saCd3IypvXb3aTlR9QtOuGzqY/Fyvabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Mon, 21 Apr
 2025 08:37:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 08:37:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>, "jonathanh@nvidia.com"
	<jonathanh@nvidia.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"praan@google.com" <praan@google.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"mshavit@google.com" <mshavit@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v1 15/16] iommu/tegra241-cmdqv: Add user-space use support
Thread-Topic: [PATCH v1 15/16] iommu/tegra241-cmdqv: Add user-space use
 support
Thread-Index: AQHbqqxzvBTEpSMJPEeJw9EUJl83NLOt2Buw
Date: Mon, 21 Apr 2025 08:37:40 +0000
Message-ID: <BN9PR11MB52768197516FB895146A12078CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <30c7aff68c35040ee637629cb9fc2b6e7f83f76c.1744353300.git.nicolinc@nvidia.com>
In-Reply-To: <30c7aff68c35040ee637629cb9fc2b6e7f83f76c.1744353300.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5808:EE_
x-ms-office365-filtering-correlation-id: 19602da2-69fb-4f2b-ba1d-08dd80afc6f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7Mv5bsmiAonvEmqWktCt/c3bhSFjNT+i55oguXgRg1d6DQlg9lQAfptEO7Na?=
 =?us-ascii?Q?yTKHBaVjdXdYUe7o/YvTT1qqRvfCsNXULdEWUM2zEJVsF/hUIHI+cV142u7q?=
 =?us-ascii?Q?SfeZH9XUbXiBPHo45tZj2TrnfaNV3hNcwaSoKomUry0HsJR4+wAtVWPlaafe?=
 =?us-ascii?Q?FUExIYj+06N1KEvAqv9EpnTj8XpoTu3fpQA18yFGXuK6ui3d8Z5U7ZMp4Hnd?=
 =?us-ascii?Q?OHqRhumcTWD92CwdI+B+AlG6hzgjimQSA/s1jVqDM3e1MmBQypTAIQ389OCW?=
 =?us-ascii?Q?6o9Ad3aMxt4D9o+A1SFwVjiAcX9YHzVtf5sIpMc15a+ikm4UlF8/8nKzW+7a?=
 =?us-ascii?Q?u/0LG3xEZfQ/WjeP3KHl+hXWf1PrJ1hCfW10QmqOujrf1e/UlMJ/LEwHBooA?=
 =?us-ascii?Q?bgthcW/PDn5eaOU4UbygfwffiUogUV84JkeIg708PKRNql6eSmIyx0iKJ3Jn?=
 =?us-ascii?Q?Mu2FMjC34N/Dg9EuoTyTSof9iy5zPAeQiQ0J1JUCJO4SMrlWFWVo3ZA/ANfu?=
 =?us-ascii?Q?xsoxtrfRODr1VqD3020HKbjveGLeUrNHmFpb37cOxXH5MptksU5ETR9Ye2G+?=
 =?us-ascii?Q?5iN6Kqsa4ifPjJALrSQMozeycDS6d6LhFqaBRZSo2T3A3UZn965c85kDg762?=
 =?us-ascii?Q?cVU1hstnoW0XN6ovQM+jpYSCMfq+YJEAZbWDbj71BYsC1nCqF4sbZA6Rgzra?=
 =?us-ascii?Q?H3DE0F8vvgTofDKLqyOSOdyzbgYJnkgOYOSYV7M1pkoFxq6sjw3WXzmeWw0u?=
 =?us-ascii?Q?AmOcQLbl8cfj2kBXDcy6GzDIxn2P629LaGXc1oKMhMN63i2l5BlbYNGVh3R1?=
 =?us-ascii?Q?F+TdlWZGEAJWMsl+mn7XuzyynYS7erIvgyFZ56uoIDTPrxCDnjE/Ueykemuo?=
 =?us-ascii?Q?H0vlWlWAvOmnYg4LWyx7lAPWHWlOPd02sRKSMc+0mOS7KgZkS3SBdl10k6zj?=
 =?us-ascii?Q?bvnziN59I5v9Q42j3e1v9T49ia1h2L4nDQaSsq2/PzZSBt3g6OScKS0k1USU?=
 =?us-ascii?Q?d12P+FB4z6BRlSVXpE215i6lcW5twlLi0BzL9WArmUV93M3cL4/OoMD8fPzB?=
 =?us-ascii?Q?108cfKUveyBkJqBrugECC9tVCrJntTr/i0XxEl8JjckZtwHK8dQg8Bgh9OvF?=
 =?us-ascii?Q?4FIm1jg6JHVtESYK7VXbfRsL8Z3+iVrQUC03kghyIX4U/hU3XTwQlEiIxpd+?=
 =?us-ascii?Q?W2jzyej0+gU3oobIkt5XCRz7+icvqVVgppA9ybVKN/y0Am1xjR2OQq1/pFkb?=
 =?us-ascii?Q?eTEd9/4xfu1LRDRiviJNWWKQDk1jVBpZZiTfHHwD0fN4mIOA35MjPifVj8hZ?=
 =?us-ascii?Q?cbbeI508Ocz1trL1jvvEge6aU/mKZiGD2HFgU8oXG2RLLb4j09ZMRh0WBFse?=
 =?us-ascii?Q?ffIs/JNNO+3GWI9cUszCXrG0GjzjGHifJejXN81MIH1Mqq04lu1IZCds7OT4?=
 =?us-ascii?Q?EaoqwCvBG4sTEctCAccqVdDDaJ3DLfjb+qii7zIDPA1uQAFt45WAemudaDX8?=
 =?us-ascii?Q?ZUd7AtE/v2CaI0o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QHqlnlucRH7H1l9PMSfLFfLljwuGETufGzKgu38FcCvOE4tP+IUPmqoQouaI?=
 =?us-ascii?Q?Wh7ItEdBAmqE92O2GH3wLK8j48hocrmYWRZsNcbAP4behQwRQOr+CxQnN74L?=
 =?us-ascii?Q?AM8VhS5bYKN4XwVVrRlwK15CzZo7Tf5x3/K55WY+UM4IinOxhgRUr6fkGbF9?=
 =?us-ascii?Q?IidnPgDz8ujqvqZrjtglDvvu0L2D0fxo5/blC22LKgAW+AlAqoj6W8oq32tq?=
 =?us-ascii?Q?TFcvE0S69Me9AJ/Of0kEvd/ZvCrSdeHbqp0HSudxAQv6LN8IxLOdSBYj/d/P?=
 =?us-ascii?Q?9G0/ZRsoOzTNttHSd2OiVGjpg3JJjWAhu+TEBwB89yG89l7BaUFVlmLVC6ey?=
 =?us-ascii?Q?3SHSE0PKjGcRv0CIo05nVRAE3BcpnflxH7EVVJ+3tiefqjXVGfiVeXJxiXsP?=
 =?us-ascii?Q?ZXSCbNDDAJKgeGxZ33NujB3p2ImqXrRwzd+T7HuA/FiJJtML49wTfqzwEOX2?=
 =?us-ascii?Q?BcLkaNQQIhPACehb6kLbGZ+7P52dMgzjxNl5EOurpPB75h885k8lFsGz6xB4?=
 =?us-ascii?Q?R+6JVNF99gKNzB2ywj8S5OqiIPiCYKC01tRJ3xACMEsT6a2XfQopYPYGUVBp?=
 =?us-ascii?Q?tcprUUwsl8PH4s7wd1yQCjQNwnw5xXXE4hUvYeCYsdBkPvr1yOKtXcUDSJx2?=
 =?us-ascii?Q?0TRSkbLJqRAGezGt4hXplBJkITK4EROtoJHJMRoXMVl6MfXtNenjslhHajvg?=
 =?us-ascii?Q?lo4BOhIlKPlzwRGQGhmQj7FOlimdx9KnbBGzZQC4uWLTgItipf029zmfvf9t?=
 =?us-ascii?Q?rtUDYlAllvFBHEF5IdZ1sCuQmB7tOK0Y7wbJtEDyk209s80g1+MK4rzZD5+M?=
 =?us-ascii?Q?aDTm/lGyWwHWx8Wsk/QxpuJ8vc4dDNGCAANpQLuUYaLFyQlWVfQopV+l3IHg?=
 =?us-ascii?Q?CTjUb8vAsttCkmUYehn6LVPKQynaBlrFdX707zu+fH+B/8+v9AN+8OBqoKPs?=
 =?us-ascii?Q?j3Ry0M9p6RAM0F8/8Ei9Z8X1uey6QF0DI28bKfI+JmEr/ZYgWKaAYKuonvJP?=
 =?us-ascii?Q?o4q0QHW061xjP0ZIsdTR6ile9+x0C2o69Lae/bYGvcdVG5IT5L0Y6CpChU81?=
 =?us-ascii?Q?w/lK76nR09ZaeGJshyPvIumyyPvddbCtQzo4scup47U0LEzUG5nnexoDFk55?=
 =?us-ascii?Q?amVMp79MWxftwLzfkMDOMt5fyTbNYle/loMW0cWuUDva5No/YUIi/szFX6+2?=
 =?us-ascii?Q?gm/GqoiQD2Sosh98HMl0XARa7VPIClotvjYATTH0LzGHst2j7u6HlKY52oKJ?=
 =?us-ascii?Q?7QUf1VPEgvJ+JMexmXLYe63cItB0/wUu7POmhOP1MzSg8grlzFLv4nAZO+/C?=
 =?us-ascii?Q?qaSwsSgfINFPQTJz+nwT3whnS50ZMi2iWr76Jl1LGlHfD5ym3q8AbznJ1WAd?=
 =?us-ascii?Q?mXUGlbaVD/qUMcSqe5uek1ltk1GTMs/tmCrSly1Kmf9kXo5iPBuFRC8QpB8p?=
 =?us-ascii?Q?PjWcKY5+axfHUdaQB4szhKnb8HHIz1Ddk5+8KbDkG65v0E0o4/GDCZMyfzKq?=
 =?us-ascii?Q?JGEpylqajZFekGvWUFWgOqece8Q9z4mW5HM72r8c7cfIhL2Vd1ciwv1bFOKi?=
 =?us-ascii?Q?nfhNIanhl6STzPX3G9x6GH/RxSaP5Mja2Hodw2Dc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19602da2-69fb-4f2b-ba1d-08dd80afc6f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 08:37:40.1837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGj/1cdYMq9CxybzMDQhi9ntVPicGFeWRjhhxsg0brqfFt1VaxherXlViU3FsDJ1Ib/5/1Dxa30iM6ogTCUsVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, April 11, 2025 2:38 PM
>=20
> Add the support via vIOMMU infrastructure for virtualization use case.
>=20
> This basically allows VMM to allocate VINTFs (as a vIOMMU object) and
> assign VCMDQs (vCMDQ objects) to it. A VINTF's MMIO page0 can be
> mmap'd
> to user space for VM to access directly without VMEXIT and corresponding
> hypercall.

it'd be helpful to add a bit more context, e.g. what page0 contains, sid
slots, vcmdq_base (mapped in s2), etc. so it's easier for one to understand
it from start instead of by reading the code.

>=20
> As an initial version, the number of VCMDQs per VINTF is fixed to two.

so an user could map both VCMDQs of an VINTF even when only one
VCMDQ is created, given the entire 64K page0 is legible for mmap once
the VINTF is associated to a viommu?

no security issue given the VINTF is not shared, but conceptually if
feasible (e.g. two CMDQ's MMIO ranges sits in different 4k pages of
VINTF page0) does it make sense to do per-VCMDQ mmap control
and return mmap info at VCMDQ alloc?

> +static struct iommufd_vcmdq *
> +tegra241_cmdqv_vcmdq_alloc(struct iommufd_viommu *viommu,
> +			   const struct iommu_user_data *user_data)
> +{
> +	struct tegra241_vintf *vintf =3D viommu_to_vintf(viommu);
> +	struct tegra241_cmdqv *cmdqv =3D vintf->cmdqv;
> +	struct iommu_vcmdq_tegra241_cmdqv arg;
> +	struct tegra241_vcmdq *vcmdq;
> +	phys_addr_t q_base;
> +	char header[64];
> +	int ret;
> +
> +	ret =3D iommu_copy_struct_from_user(
> +		&arg, user_data, IOMMU_VCMDQ_TYPE_TEGRA241_CMDQV,
> vcmdq_base);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (!arg.vcmdq_base || arg.vcmdq_base & ~VCMDQ_ADDR)
> +		return ERR_PTR(-EINVAL);
> +	if (!arg.vcmdq_log2size || arg.vcmdq_log2size > VCMDQ_LOG2SIZE)
> +		return ERR_PTR(-EINVAL);
> +	if (arg.vcmdq_id >=3D cmdqv->num_lvcmdqs_per_vintf)
> +		return ERR_PTR(-EINVAL);
> +	q_base =3D arm_smmu_domain_ipa_to_pa(vintf->s2_domain,
> arg.vcmdq_base);
> +	if (!q_base)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (vintf->lvcmdqs[arg.vcmdq_id]) {
> +		vcmdq =3D vintf->lvcmdqs[arg.vcmdq_id];
> +
> +		/* deinit the previous setting as a reset, before re-init */
> +		tegra241_vcmdq_hw_deinit(vcmdq);
> +
> +		vcmdq->cmdq.q.q_base =3D q_base & VCMDQ_ADDR;
> +		vcmdq->cmdq.q.q_base |=3D arg.vcmdq_log2size;
> +		tegra241_vcmdq_hw_init_user(vcmdq);
> +
> +		return &vcmdq->core;
> +	}

why not returning -EBUSY here?

> +
> +	vcmdq =3D iommufd_vcmdq_alloc(viommu, struct tegra241_vcmdq,
> core);
> +	if (!vcmdq)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D tegra241_vintf_init_lvcmdq(vintf, arg.vcmdq_id, vcmdq);
> +	if (ret)
> +		goto free_vcmdq;
> +	dev_dbg(cmdqv->dev, "%sallocated\n",
> +		lvcmdq_error_header(vcmdq, header, 64));
> +
> +	vcmdq->cmdq.q.q_base =3D q_base & VCMDQ_ADDR;
> +	vcmdq->cmdq.q.q_base |=3D arg.vcmdq_log2size;

could the queue size be multiple pages? there is no guarantee
that the HPA of guest queue would be contiguous :/

