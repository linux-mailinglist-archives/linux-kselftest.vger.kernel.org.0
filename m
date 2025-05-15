Return-Path: <linux-kselftest+bounces-33043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D944AB7F60
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 09:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771163B3AA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E67280CCD;
	Thu, 15 May 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfQ9xpfO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B328151B;
	Thu, 15 May 2025 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295667; cv=fail; b=a2CrNxMkEhUQ5yjEBS0rqJ61Z8KFLzOg5jW9KoyZY9gu4hOYaeWtVtOFyIe0NNPR4aq8CJPJAg0y1JQzdofcQJjIDj9xw0OBNUDIqvuPggdohdwuE5wSq9wzyTTgWHk7HuUSDzMRsFMS7Cw/Dab/+xnhqJvHnThFsnMCpo232kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295667; c=relaxed/simple;
	bh=6MqLdP4ZKDz58bi0NJtStpiqyaGEhB1ssvBSrHRaWPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=os4W257AdYOv7xwMSKvE9DwdQYNGDoUrSQP/x+ZF8pLxzA9Qb0X7jzLFNLadlPqLU8GjbJumxYsB986/pwfhT9Ptj3Jn8xr6nbA+LdNh11kANjDoFIJ8En+9DGNXlBDJaxlzOQlkQCuAixqqISTaqH/v5s5F9mZYnqL5wMv5MEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfQ9xpfO; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747295666; x=1778831666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6MqLdP4ZKDz58bi0NJtStpiqyaGEhB1ssvBSrHRaWPk=;
  b=AfQ9xpfOpiOYjjXjxg/ggExcgX5ThVDrk8tlR8yXjT7UhETGOEppxVaW
   9PavZBsKlm6YoQb2e9VWfQWiZtOW6oTJb9l7hjJWSbEINkg/GU3PV1XVr
   xxAvHDyWEOnNJ3ApwktSY0VkdzTgvP6Iv5BfHOc1tGdnWKhXstVNzmXLe
   pAXTMubV1FkgUFYPctQwnI5MQtQBCmj5X6A+eCnvuV69BgjbBWkbI4lKq
   6zGWYXVsuCyVnkLb44JE902/x2YrxIxD1GGGoXnSc6NOoTCbUEux6yX3V
   BWViAqpA0M/521A7CtZPuYSJecogYInqdQ4PK0a9CHebsPwmdC+cboQu6
   A==;
X-CSE-ConnectionGUID: byXx4f0MQBaw/AGZHCsqZQ==
X-CSE-MsgGUID: QpPO2vfyRrC4gVtVydRCLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48336479"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="48336479"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 00:54:25 -0700
X-CSE-ConnectionGUID: aODyB9VnSniuC34J/2Scgw==
X-CSE-MsgGUID: 7CCIuwOPRWy26fkAEuXhGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138029097"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 00:54:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 00:54:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 00:54:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 00:54:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBGFXS2fiOTOIicQet2QSSHAS1dw42DnL6l3Xrb3Qvby/pxIDCkoBbAuvwUHPHDa0bWzFg+aAgF8AeP8Nes8kLmAWRz5RUlek+hMpX3pGbzLBwPqillYXPIskHOgBrtugo7NIzkYA6wJsx039b+Yc2cFPNuUUw3fJpjq63SnmOFIztvTMLGO6FPTBHEouevkCILy8gLuWx+EENPdWx8WCA5zZa8ish15rvI3sF6NqSQ7U1dpNnb9R+aWIBPiYNTbthL+JJoBCtKJZ+NS1N/1hnDG3POjTyFHTQJFM4Aj1WSDD028I8wxqDoVgI2y6XB2+1y1JuOD6P8jnjBynenI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MqLdP4ZKDz58bi0NJtStpiqyaGEhB1ssvBSrHRaWPk=;
 b=BRGJIvgKr4nsLNZy7XJQjrrJcF08zqCUTZksIWD+4MUnS0m7nLQLjhZ/i1qWMmLH7SLTvu7EpKDZkBFWbXUaNIV5XH5PdZspmJxHNrGeQLm8W/k74FluT6i4Jn1LVgx9m5byUB7iU/6pPTVC8LqyOdowpP8EQ24kldNgOwUCbqtTY18r4U72fUKsblyK29erONlvnx+awdAok0CYLQgcWBo4+1OKI+rkdXwdqMcH0lIp1PhCgJTtdAGlCynn5B1tOEB9IpiiDmsmvhFgA0yNuifyVL8inDcRp7LCxIFE3tS6p0hWAC/SREF5MiEbhaMOvQ17FOnsYstJgVmdn/09iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM3PPF7C7D8332C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 07:54:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 07:54:21 +0000
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
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v4 18/23] iommu/arm-smmu-v3-iommufd: Support
 implementation-defined hw_info
Thread-Topic: [PATCH v4 18/23] iommu/arm-smmu-v3-iommufd: Support
 implementation-defined hw_info
Thread-Index: AQHbwI8KX/jPErlzDk6hslXJIG3WHLPTW+yg
Date: Thu, 15 May 2025 07:54:21 +0000
Message-ID: <BN9PR11MB52769C58B4E446E2022C60DB8C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f70cdcc21df7cf07ae1da02aba8a5aa932718a25.1746757630.git.nicolinc@nvidia.com>
In-Reply-To: <f70cdcc21df7cf07ae1da02aba8a5aa932718a25.1746757630.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM3PPF7C7D8332C:EE_
x-ms-office365-filtering-correlation-id: fc58ea87-7e03-4293-8e7f-08dd9385b3e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YzKyLh/UulyzrYw7Ofq2kJBQHdj9D8mpF8I3qWCfogG1h88NrNhFMoNYwJyY?=
 =?us-ascii?Q?sp/si8q/LvvuJxxW8ZyCtCl3IuyW/6Ogzq/krAQyIGZCveEQZ6AoGjiZtbZd?=
 =?us-ascii?Q?juWgIGa1DJ6SgPSFplEdV0CPRcpgy2nN1UM/yliy+6V9CKy31PfI3pMEfi49?=
 =?us-ascii?Q?8wsxOBoncEBPiZ6X38L2K1Svh8iDtPiWd3xZ2wJQukywxlYtcIwabYH+g5FM?=
 =?us-ascii?Q?PA+wBXG3rwqet8MEpT6MIcbg/Pv3/dO+BF/xC+POc1MYppQi5opwo1bqKwq/?=
 =?us-ascii?Q?LuU2aWTAwtl+jC+MRT9Vh59mYxZ6TrTdQfdH9ahYAj5mXLM4RHW1VvoyFkON?=
 =?us-ascii?Q?EnLAWhOOBcj1lo5vwWzmiDezbaoVY5TdQZVVwh/ugST70QSpT5vmcYwZvLZn?=
 =?us-ascii?Q?cFFB4LHQNPSttXa9a5A7Ix32SUfiEvNytpod0sQiGPWKnyf9NCy9QVdJREeB?=
 =?us-ascii?Q?Ll0OQRRH9z5lYbDN9qv/PtUKWc4rSzKVTwpFBgQhr4vCI0dmZgORGknV75db?=
 =?us-ascii?Q?f6VswzqIbWbPCfaMk8d+lXxg8xsVCKpCx0z8f6giG372d065g6aElCYjZ3m7?=
 =?us-ascii?Q?qY88jjpqNSC0bjDSyinwMIMSNrj6x6yA/WSWGvSHI8RqeiBMkn/HPpblj73u?=
 =?us-ascii?Q?O8baOvgYtyFK018oNwhHa/uyzxDNIA2Zv/RIlINrnpJVWMFdf9GBEjx4SMND?=
 =?us-ascii?Q?Mu+NrwZzhkSGJ8WzkK114RKJHJFANuwXLeAiNNk/zpRCvb+cbCTkpEviWQsY?=
 =?us-ascii?Q?G0Ys4XO8khAOjQIcRtix5xgOYF8MnDcpqlVmpaWDrzbKKzidVv8g6oBnyVZY?=
 =?us-ascii?Q?eerWxTf4rPl58QHQUwkUB8oiiP25iP0VdkuhFNEmLuFbI/due3cDoMsxzm7b?=
 =?us-ascii?Q?A/ECV7h7pzVKRuPfBJd/dgCUnJYZbiRc/3P6CyvaRl2dewVza6jinefh2LKM?=
 =?us-ascii?Q?YMamTUEe0+qgBlzBJr8zp81Zz+hJY1+JeXmFZ/5WSCfm45S+jrrCLbhkHSTK?=
 =?us-ascii?Q?QMN8qbB38NuPyPbdknXzF56EdhB37ER54K7gG/NMs4SpJV6inRWmHADjt9o8?=
 =?us-ascii?Q?piAJqRi5q4kPbRQbnClm1PCNPRbJZKAjPZlZOqfbQiph/y0i2Bf5tjkMKSuZ?=
 =?us-ascii?Q?/4nOgZATaaOyfFaO+7AQSB5GtU1PQLhlMDgDvelQ1rDeeFxDJXCxm9wy/M9/?=
 =?us-ascii?Q?MyH+pII9uvA5C9EH8AvKe8SSF9Br8RhqYOHJefldvmK5Qzih/QHEhcsdcqYb?=
 =?us-ascii?Q?4pm3Qr8pR4wOQ+T37rFEYaFRy6O86rqYeGqV4aCqjgq/dPSj7VNp1nv5cmqm?=
 =?us-ascii?Q?jazyfSUqjgEfZ0lpRjEPfx9YNAmctrBLXbQYR5nds0fI+ssHtCFNAhHUACjW?=
 =?us-ascii?Q?MhRZ7yedfUs0H8mjlrdEh1vZPYwTDrkEfAlJM0Cg3T3MUbZVkNbsvU9FE+gi?=
 =?us-ascii?Q?aGIorqZ8Ngt0cKEiOlcJgV7bos8LgCD1umpEpc9tIbgtjyoFEqgpkCct4lHz?=
 =?us-ascii?Q?7839rrDyK2WKlsw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VS3EhCHtqsznIrROuRnTLtzJywLGghcfarclBtci2B4ttWyls0tYXmj0o7PW?=
 =?us-ascii?Q?dJd11NPwZdP7ejthraUoBXYyi3hDzXA0+Bwpts9QNpYSyNGXNzwKFR2aMDzc?=
 =?us-ascii?Q?rLn5PouEAblhLxYU07+oV8EopZHEVg7Rwy+d3SW0QcaHMZTtNvgQbxpeet5N?=
 =?us-ascii?Q?E5qQMS9Vu7+UN0CtGQ/2Zojnomo/AY+nB6/TvE7WCc84dqmisLB4CCQr23ss?=
 =?us-ascii?Q?EjlNN4MK3CDLiHFinp9h+J+nMupvrG+NP5ykE2sJKgocdHPCTk7PIoh8wj+Y?=
 =?us-ascii?Q?ZuJk5gRd3G/NU6w+a27Cx8CcNnf/fjPolyGOQ6SGMf5j5qN6bG2G2Evfons5?=
 =?us-ascii?Q?zqGA6rW3vHYyCaoziahP/lA1VAvUoHT21arRPP6iSoZ+fNL2TeCszSxZz41U?=
 =?us-ascii?Q?P8HodGsoQ95PfT72ENQ1vH0Sko0di+9r7LTr8swU7v2jNyNgcfxsLIeYpuI5?=
 =?us-ascii?Q?4+BZY1hNPOcuE+yuKnuLHmKf36/ucram6c3PvOZEzcw+PrRJdfJGA2vus+V1?=
 =?us-ascii?Q?t6H5j4HF4vO9JWga0puTHh6E1mwH8OWnwFQLbuUhFZU4ki7JwiEFJzimwneI?=
 =?us-ascii?Q?rRc3ZYn/XT0sYyXCE0Kn5bE4S5jCATKx2MEsrHjqe3WiyhIpM+1eRELUYgp8?=
 =?us-ascii?Q?OTWZGT/SAfApnWOdU64bCu1RPkAO8XFSiewTqgh9qfJll2hXyW8g9NE3OXGm?=
 =?us-ascii?Q?mCW0+VzsN4rFUj6jADqR360c6ei943ffXuKF3Y/9onH+TfZ4kjnIWHeyxZ8E?=
 =?us-ascii?Q?Dtb+i2W8ntTCXy7QV+AhrhKObcby4Q2o8e4GZ77g6LeLvOCQXO6obZt2WLWd?=
 =?us-ascii?Q?QIY8QcYBfKrT2mV/eYhGgcejqQ69iePttHcTi7fM0UxnvKPPzAawGJaoWKl8?=
 =?us-ascii?Q?RjzRMWc+i8iO/nc5mEYq1+791lSiJg0LAC7ciuGduCTw86Fl7QvBRUhXCTE7?=
 =?us-ascii?Q?ja8nzmb81lVX8OoVoHj/aPOLXqdVLNUA79/zSp8vgR4WZEpRit2yTim7YQWJ?=
 =?us-ascii?Q?BaejEXPPfExZx9+CF7o53kiQ1/bDpzuix0a32Ky/2KPJ/Eds8HL2VoyqH/do?=
 =?us-ascii?Q?JgejTKYdp57rC1OKcIXubfe2yU5Z8zEvJGvBymRAWblrHHLdjMxFdpUxoJ4A?=
 =?us-ascii?Q?4yAQkP4z741OCza3S+5ZD3CqEVNPb/wcBX3tXJjjXm/XS3GLRkZ4buziwYvp?=
 =?us-ascii?Q?r7XLRX2KdhSGCCbRWnlSdUrw7R9grRlPNGe4eeZSHgvXblsDDjUR5DlOY1dQ?=
 =?us-ascii?Q?mvE5Lo4Ll2zERyIwIgig5EkiKLNWQeTMT9jOFjKW8NotjVB4SJp1DOfQOOoV?=
 =?us-ascii?Q?myjPZagwioa7+LNAwPFrTVcO2dyp/FCf7vwQo011TMipI/SE75deQJANxJfX?=
 =?us-ascii?Q?owQQCcjz7wtQgKNyjf9Br3QuzDp4gqcyh/VsisaiGv5hcqQ3/vZcG3si9A9Z?=
 =?us-ascii?Q?Odu7FatrvkkqGtwMOeGggq6Uf42/qVi0Pez2eDUhA0pyJr+MZTPQc8z/zTuc?=
 =?us-ascii?Q?GffabZbXgsLloFHCvNjgJe0hyEIBp4LxEJkf8ANsN0WcRUsPzaLzHVvjdtw9?=
 =?us-ascii?Q?cL2zQQqmtBr70vFWw6vGxAyjAdAx9+nX0HZZLbtR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc58ea87-7e03-4293-8e7f-08dd9385b3e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 07:54:21.4114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OylIApw3tvzR6TG/8h6FRNwpeQMkM0aXOxMWcW84zFuy/xSJk2CTtM6Mjrg+RSq43FlyBrYpJKu2rA+5LWCFgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7C7D8332C
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 9, 2025 11:03 AM
>=20
> Repurpose the @__reserved field in the struct
> iommu_hw_info_arm_smmuv3,
> to an HW implementation-defined field @impl.
>=20
> This will be used by Tegra241 CMDQV implementation on top of a standard
> ARM SMMUv3 IOMMU. The @impl will be only valid if @flags is set with an
> implementation-defined flag.
>=20
> Thus in the driver-level, add an hw_info impl op that will return such
> a flag and fill the impl field.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

