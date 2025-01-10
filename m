Return-Path: <linux-kselftest+bounces-24184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886EAA088BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 08:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAFB166882
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 07:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3346620766D;
	Fri, 10 Jan 2025 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOHtUm0d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1212063D0;
	Fri, 10 Jan 2025 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736492835; cv=fail; b=fQqSOq0V/Rfu0SyYcDu4TxfcucXgsdPCz5lJ0luq1sOCo42ZO16uB5ynoS+hw7yMDn6SpBNJJJ7UrUHGq9TbT0Zys26AH3LXOY4RQW6nOGkKgDfUbfpiZyUf9J6pNg2KcaWwm1Fsr3z2+qayuqx7oESFAUPalLVBH6oSNmAJmcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736492835; c=relaxed/simple;
	bh=N0P2BlzKz96lLqGMqCNNnmMLmCO941bPGTn9tDg0jv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q+nvwaCWIi8g2m14hyjpW/dQZy43EYutKwJHnWPX51s6wpJFUAaivkMBUk/MNJ2BClVQ3UsBgLRgEK10ZpCaVbtS4RhKak46RcB9wPub/hMN77dr5MClUYPa7SaauAE4c9jETjy9SVdZouKccBGbB2vFa7s6X/yX+F9CQxXbQBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOHtUm0d; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736492834; x=1768028834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N0P2BlzKz96lLqGMqCNNnmMLmCO941bPGTn9tDg0jv0=;
  b=iOHtUm0dNQT6VnpU52y6ZxQt99fVauoo2nmjrCOzASD2EUIU+nnM6JaL
   jNEZ1cRw09WhqgEljYX0wKqDpeupfTTVCpDRgQcNa8Vohv1Z9CTGEeeA5
   mMbjLemWG++obIyxbP6SApwC6kz5NA247CTqP/Oh9BOANICWDiYovB1vV
   CobQGJ/+N9YG/fe7DD/zxJiSLaF3AvVRKrsE9NcbJiMvLPMsJF62KjmnY
   zCtBxBE2OBnzDj3D2H/F9ScOiUoxkvpWBv2qfYRSMQPXzMiW/vdcBansT
   xIh84ycizEx+DXjHaC/nSCMKP0UQcfuqffYslqzb+xUn9Z9wwH60YWhyk
   g==;
X-CSE-ConnectionGUID: Rq+1ZjLGTduXlZygtpeO4w==
X-CSE-MsgGUID: IfSVuk5VSr6HY6UHHTZ1iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36660830"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36660830"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 23:07:13 -0800
X-CSE-ConnectionGUID: HVtcgjKpRhKt5XmRqUUHwA==
X-CSE-MsgGUID: tAIPYfaqQXyUzKZiohpgjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108758816"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 23:07:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 23:07:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 23:07:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 23:07:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWLL9VkLBlUSVw4X6gUWp+MQHgvAoSRJ2goAO9yWSsGZcUuddEpx4gnwRjiy3Z468GKVdUERq9VX6X8PeKp6tQt5HR4e460XD0F5bGajA+FM4bTBk7wvzrmqeBuBAbQvip/1Pjqj+5/Os7I6Y0qyx3UyDFiqr6XO680wUis3g+OpYSrv2uuEq9BHy315AJF9a2F0vuVjXidfwH0RkKeXn91Eogah78EEwOxKe373mtAzvexczDZQyYjNbiZjp0LuV9HTqQ+8YUzgpUVHmtiRFWtyuHv2SUPMkXmeyTpEXp8albW3OO0d7KE9J573HccDoZrstI9kvdtfsr1FeID10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnWMwMpsI5owUfYHBXFkM+wA//trukX76PUIiGWI0+c=;
 b=QAih19yDvM9OjCn4YykK0g7eiTEmWK3IEmgeHMxIqqSdYj1Ywm43gTVBenccS8r3CM+XMEEhL8wHzDsV49jB1oHOCCTiIcheo8kD9O0a4gK1mDEwYs/LY8NYTFek7KnIm4FdtDZGHMoQFuVbCDID0dmkpsGLfNiEqoFA+4K8HKrA6fQtrlCOPCuDXzdIebmjkJqDRmMDf9ErEY4+D6MmMwdcLqOmnGu8RiMEWTDIRo7k4afQqYsehMfR9Oma07C1d5NmLegCDNB7iyqQ4Q/fvtb6WJ/K47vqci5Eb80tTtfl2VADNRlYctz/RFGbjw5NNEfIeV5Nu0PrTjZjiAGYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4852.namprd11.prod.outlook.com (2603:10b6:303:9f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Fri, 10 Jan
 2025 07:06:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 07:06:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Thread-Topic: [PATCH v5 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Thread-Index: AQHbYSc6iqK7HX06T0GpxaurMWOE+rMPlPbQ
Date: Fri, 10 Jan 2025 07:06:49 +0000
Message-ID: <BN9PR11MB52768B2EA84EDEFFB04662598C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
In-Reply-To: <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4852:EE_
x-ms-office365-filtering-correlation-id: 020fb9fe-ba18-49ae-3acc-08dd31455a4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zfxquVBD5ksFaXWrYxIQqknzrGZ3k5kqQNdeNJQIafXxqJjPC94YqvjROWnC?=
 =?us-ascii?Q?DzCcABXEq25CVyT860drdMdy9v/UkNmWzjBlp0SAc+RqGkP1OvUjNDbdfeHQ?=
 =?us-ascii?Q?2hzeeuyxjCHuDI6QpAVFnl2Y0XXGYJl82QLZk8vStmoNVRPugtnM683FYNBH?=
 =?us-ascii?Q?Yfd+44RorCs3vGDXjaPEb6dsWupoy4YIOWRzQDMSeQ+jJOeYh5MptcsA0vyR?=
 =?us-ascii?Q?McXi3Q5TDmjiskPAdaAs1PTfMCB/JXTQLdcAI6p8JXZbE5n0xMvkZJwyTZDz?=
 =?us-ascii?Q?nh5UtPTPi7RX2pLaoL7FxLfHT9kzP50L5K7q3cgMwtU5rtTXju1Pqy4BsdWX?=
 =?us-ascii?Q?2Jp1Tj/78JBj+G7amcDLKFcWFc1/uJtiDtyWhv2mj3K0tmhzIJKGZBMeKExR?=
 =?us-ascii?Q?jg2joz+fEmVNCXT7BWJB0E2F3JT9HTKUTXCLZg55MfSI6g7+pt5KZf70PAVx?=
 =?us-ascii?Q?dIVV95dlJ1Qwa+UBZYKXut3frqlP3w1thiy8+jzXTxy+vlQjBQvUyIVN2B6r?=
 =?us-ascii?Q?Wi1qdoHZSEXFjxyWVt7AmehXWAvthcSZmUUnuLOT6Xcv6b96Y6c3s3LD3ZGS?=
 =?us-ascii?Q?lhV/BUUYC0qmfIz900pMeBt3Zb4e9JmP+nN6fmsPUwXp6CxsQsZYa3vFH+iy?=
 =?us-ascii?Q?pgYcnd7AsjEwr7N6IsGkWwdedIAUCmwYLRrg7CyPxbu2W7Kw+zUay+EIKe1s?=
 =?us-ascii?Q?kg5f0NTOenShLQOk/+xw8NjmAZmeL+990wVKA4w9QmWQaeukA3fSbppu/Tam?=
 =?us-ascii?Q?4pljhNxBEiERUtxVb/s8T3g2DNnBhV/cTpWlUA756SLvcKKxIpefXN1VgYaE?=
 =?us-ascii?Q?RYcpGLTmltiFZG3b67hbFH0cneuwk8nLGINq470kqX1ZuP7G3GKbQNQD3F4+?=
 =?us-ascii?Q?XZxXZAUIUBZaA+UZcZAaEG9k1Mp83TN3I7W5wsatO/ieQ7lq/k5gpSXoVvMn?=
 =?us-ascii?Q?qVcNJo9kaUpNiAubTYF2eaa/AGKvsNWVU/UNiLYQE+FvlY4g/4WZLr+6ZyRc?=
 =?us-ascii?Q?V1xUaHhyvFHeA1Ic5T2+3p7PDDhrRiBF22jvtpYu7v/0nWJfIl5vgFP5ZYB2?=
 =?us-ascii?Q?RxPncAi0qkMJRJuRU9A1wDnV4b/lVR9n4gTYq1iQKsmlazIO639tnNRjEOmx?=
 =?us-ascii?Q?Odj7kBIVckzBP6IVTNJuia3txAmE7AY5td2aw373YYp5HHXeZgphT9FLgDcr?=
 =?us-ascii?Q?ChazeKQUlg9hbMJH246pj1IuCTuri6YEkuN2EGCJbNLEWs2I6TSqRry03iem?=
 =?us-ascii?Q?/xoTM/WdBy+dHE80s4mGqKaCtqjA2ObNHvWvEy51hfb9gD5ltypLG13O/LeX?=
 =?us-ascii?Q?LXnQFnO4S+kSj+NLFWO2noR6x1JHkURBnvvBpxuJCEaE1Nt8yQAyplyGcwaE?=
 =?us-ascii?Q?+rpdtQ83gDhaE2lhSampeM08dzHOhRQtU7dcl9uv3+PX1AdMcC/9/CZv2Owy?=
 =?us-ascii?Q?4x5tnXQs9TXR6D0+iQ57Xta3CeQHsjON?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Idk45Uu9peEE7OmGubPM9C69n1qa5Yah/1pIg3hiuGcMNiemPer5EKY+v+GO?=
 =?us-ascii?Q?bvFbllQ3IxFZBEeUzpI/Hcl2+b6qEVgEm3xQF2I33EQYbaXmqNlQ6XYnI4Yv?=
 =?us-ascii?Q?9yjU2kfszFb9stF8kEDmsXZy/oDVaiqcO/YHEr5sr1Z5hFMjRa3JiGIuoUP0?=
 =?us-ascii?Q?PgEWSOQhE64C1eXyU06/3GcxNzNvNbH2AhN78B4RZLEB9vbNeRqXSkWnv8RZ?=
 =?us-ascii?Q?YiaaNEqUc5Oz3ZdSTwySD+ouMOdu2vLLYtgGCow/DvVON7Qu6+Nh9e/3ENyR?=
 =?us-ascii?Q?IissdKxxwkhmy0mlXaJzbdgUR4AmowxCFKbIlpb6coXalVxWKIerGk9Ip5LS?=
 =?us-ascii?Q?VE+usgHopW/EoM/M9En9F8fn/3X3g6zRUvgSAQK1yy97DYIn4lYEFMjCsc/5?=
 =?us-ascii?Q?QTBCQQjvVDpUIBCubJ475ZPQ4aYhNmNhFvsdlNR8S7RKk6bgHnEMUjlPNxRW?=
 =?us-ascii?Q?hBsX7gBVjwA7oTC/KbiuOtSfoG8q8jcwjgnJPUQafUNSgNRUXZqUvodscDRb?=
 =?us-ascii?Q?GfzqWJxPTYJv1Xe9kzYAzCg5i2y5ABm4IqB0cOz5D+I8/JeBNKO9h6BJmFoZ?=
 =?us-ascii?Q?hh8SRa4LuQ4RmedVZGBcaLEU0F6TkjvyjhvPXXWNUH0dPrpR8N4QcjAdZhQq?=
 =?us-ascii?Q?HfUCAO7RJJWGrBdtlUDWK9sm4qsJKfyV4D663PjJQ0oatwoJM7lkAzW5ZDwS?=
 =?us-ascii?Q?HwNqR4v6rVjX8fst6DeObWKd0NG1ASiZ861X6+rl2hl+UCEI1mGm905pXB3X?=
 =?us-ascii?Q?eEBxw+D64hVrbxVxlllsXnnGu+EYEuzj12BXIz8cTg3rANiYDDeQW22YQuJM?=
 =?us-ascii?Q?+4QyF3vqQUGDACDcVY9I4Zu7c8vhW3DLjIM10IF7MiOw44X70YEHhcJNqNII?=
 =?us-ascii?Q?J9/2ou1mItdIrc6gfQjZ1/X5sf61mk4u9u0d550hkyTjoz8HvkP/hWnQvxHI?=
 =?us-ascii?Q?iHlEX4jhIuFGqqWgiZFU6BKEr62BxQ0HhM1ZDg/rdtc8TZoIZArLQnnfQFOQ?=
 =?us-ascii?Q?1k2mDac0hjYScgz94qp9olsOrEHC/t/S0qXgB/Vblcf4ia0CjaesAZzhEVed?=
 =?us-ascii?Q?2SUEyEygzTBJ68t13Sjddsgn2LbEGKJioyhc7Iai1PomKJ43TF1T5pyS4Eu5?=
 =?us-ascii?Q?m6tFoyWb87sB7al4ciAddK8a0fpv9zjESugGEd5p5j0XwYr9I1gQ0p3wJWlg?=
 =?us-ascii?Q?lFI33agaB76uaDOf7Nj6hmGspLRKxNbO0DuTYFThqS1GOYA5xh8j4L97Bs0q?=
 =?us-ascii?Q?VDkydy8iQr88OAO5J7LeuCs2S0+1857vxn+dLxiTLyIjel3rthXbm7EEya5E?=
 =?us-ascii?Q?oPjxpil0I9pdjUUAh+N7uBNSs7I275M691pUZ7qoj93aXx0WsX+g2806TXxP?=
 =?us-ascii?Q?daSzQE7wdWijiPUo0UJaNyFm23zedF2HFsjBShmATI+P3w2cdwmc15JGoW7j?=
 =?us-ascii?Q?5niTxJwaHGbXLXommcp/Azh2nK27e24TwdZmr31xTpNH3BHBZlPCWwcpO83Q?=
 =?us-ascii?Q?PJittBFLvcCDyjqxc/hjUsAgu2mVjtRh3WArNipoMgvTLWNR8wCct7W+WKSn?=
 =?us-ascii?Q?zDWjJ72hA41H4llSQpNcoOEx8XblcBgcumMA/OJX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 020fb9fe-ba18-49ae-3acc-08dd31455a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 07:06:49.4063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcPCwwd8RkKTO2EsJ6S89GQggtKcGtOBjMH3y767RKrEQx9MN5jfPlPjV6tUPHZn/gCer0fFcjRgThxYBI67Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4852
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, January 8, 2025 1:10 AM
> +
> +int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_veventq_alloc *cmd =3D ucmd->cmd;
> +	struct iommufd_veventq *veventq;
> +	struct iommufd_viommu *viommu;
> +	int fdno;
> +	int rc;
> +
> +	if (cmd->flags || cmd->type =3D=3D IOMMU_VEVENTQ_TYPE_DEFAULT)
> +		return -EOPNOTSUPP;
> +
> +	viommu =3D iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
> +
> +	if (!viommu->ops || !viommu->ops->supports_veventq ||
> +	    !viommu->ops->supports_veventq(cmd->type))
> +		return -EOPNOTSUPP;
> +

I'm not sure about the necessity of above check. The event queue
is just a software struct with a user-specified format for the iommu
driver to report viommu event. The struct itself is not constrained
by the hardware capability, though I'm not sure a real usage in
which a smmu driver wants to report a vtd event. But legitimately
an user can create any type of event queues which might just be
never used.

It sounds clearer to do the check when IOPF cap is actually enabled
on a device contained in the viommu. At that point check whether=20
a required type eventqueue has been created. If not then fail the
iopf enabling.

Then it reveals probably another todo in this series. Seems you still
let the smmu driver statically enable iopf when probing the device.=20
Sounds like iommufd_viommu_alloc_hwpt_nested() may accept
IOMMU_HWPT_FAULT_ID_VALID to refer to a event queue and
later dynamically enable/disable iopf when attaching a device to the
hwpt and check the event queue type there. Just like how the fault
object is handled.

