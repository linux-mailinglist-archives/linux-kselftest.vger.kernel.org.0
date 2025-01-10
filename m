Return-Path: <linux-kselftest+bounces-24186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B76CAA088C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 08:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD497A3B97
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 07:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE091CDFD4;
	Fri, 10 Jan 2025 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnS8/2i/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C342054E7;
	Fri, 10 Jan 2025 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736493215; cv=fail; b=XRzqTxlvQDd2KBdEmq1EDZVxnsywqOgnusWOpJSTemyIvhqNUgGR3RC37Ro4p2uc5ANiwt47kkyTIzdpIiMwnAlfi2Kj7TJRFqyMPmtbMynZqWbtvXa902b4i/5AcDm96vbBuF2i3mtqcNoMlMRsYi0Fwsk6A4Zbtowy27NQoe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736493215; c=relaxed/simple;
	bh=KLOt9ndf7MnjEcz83gQ1q5mjwDBKt6BZ9lfpGfXrZEw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GXwYDAzygGBpFzvd8/UGMfKXS2M12IejGZmxb3xYsWxGGGG5jOQsUBoZk/jUpnhx1aUcRLUxzvXNtyL+m0hC6KXAuNTVwSu6FK84QDBYCB7IaHmivIhZ2LwE88PMO0Lvjvb1xkQIeHVRrpVpXQ/fLhNvG0+htFpVUCu1Fi2PmQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnS8/2i/; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736493214; x=1768029214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KLOt9ndf7MnjEcz83gQ1q5mjwDBKt6BZ9lfpGfXrZEw=;
  b=jnS8/2i/T4/DCXul15XbwqQXyon8kKagJf5lasPx//QSN0Kcd7MO2RM/
   UuoR3HP9+K/aq+E/WtBIgsNgBT++Cj/yed6oqPHGeJikWAgFYgQ1s1dXI
   5oelOwRHgGYsXV7m91Co0PpfFYviOAo8iKWv67en4DsHotZ5u4iPJDjMe
   qfRu3oZvqn5Fq93dmKsuxf11bDp8RlOvN4R78laEK0XohWmUfDEBjTACm
   Rwut9fEMyPhPF5hZPN7x6H9i+ecP56c7rIYEeeYkfk7f4lfKmgd5IKSz0
   DWpVlypGoVvH167EjG+wx6Bq46cWeHaCpeG/EIMValthyU6ks9pu4brCG
   Q==;
X-CSE-ConnectionGUID: K0hvnKbsTD+Z5V91VXTR3A==
X-CSE-MsgGUID: dIkUgS8YTc6qO6SDyWTC4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36887655"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36887655"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 23:13:33 -0800
X-CSE-ConnectionGUID: ErJjFkZXSxSDaeYIFYF8Kw==
X-CSE-MsgGUID: GxESqgWGQv+R0t+JvRKmNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="108576254"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 23:13:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 23:13:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 23:13:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 23:13:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj+T5B8yvsjYllk611Phs1yIcWDbk3yVLlgR3eSetIOYtgYqP/M+Af/M1bVtwNlpFKlg2bRdqtJ6VpDKGZdxfaDc7k/gXeptZl0/62qrEIahAuFELaoI6uJklEFVuWig0xNU0DpEeLMCejZ0aZ/M3OJVl1JEK5LjRGN07HqLTvgaxfZ3hnuqhwULCG8OzHyD5br+WXMHPPIlikPeeno0pTLNZrtGq+8DrIn3KMMne6BmVbV3XwtPz45w0Esa5cPvUEzP3KWcqBWQiz8PTTXVJ1ORCk2VpRflsza8LMx2oeRGXy+kNOw1JsxZ4dFt445V5NQgDGazv+uxdNvq8xEymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap/T3aSviQXp8jTE+JPdj4HVeET5zJ9Q+sfs/UiqGdU=;
 b=dlnu7Z6xrA8xdvw0P2IehijG60UvcR3/6Vs9xHwmi3WR6h8hPHmcKrMO6vmoTlnHQL9NcYwbt0mDOzocFey75UVDEl044ChsmuaSAZofGnPV5CF/ZJtZSjsiwS8yTxclrr9tZsINeByfZBTBvc4Jl3zMTwF2zSgJ5a3Sn4YE3/tMMD2Xp621KTPsU13vCDsi0HVTvfXClV6ro6w7k0l8+3l2ojyWYULVQM/ZTUszMcSkRQlgs1Fj0pJF13V/P6Yc0PG0m4Kw/xH8+WFgqF4CJmmyS/Dud51o/3oYIm/R1d02UEvVKCffB8TKeTb3th5dbNN6MqKQaaxPmCVqCp6f/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 07:12:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 07:12:46 +0000
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
Subject: RE: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Thread-Topic: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Thread-Index: AQHbYSdBMlcOcpQt3kG1noLochuwD7MPml8Q
Date: Fri, 10 Jan 2025 07:12:46 +0000
Message-ID: <BN9PR11MB527634DAD9FE43A6DD50A2348C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
In-Reply-To: <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN6PR11MB8196:EE_
x-ms-office365-filtering-correlation-id: bdc03eca-c2f1-4d6a-ed35-08dd31462f4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cUSJes0GyRGWca9FxqsLn8Z0uBqqft8SmQhtvFhzHW6CyyC9LlukjRfVizSK?=
 =?us-ascii?Q?muaM9JJvy0bkGShGh7ASU3UrJ+4wAhUSRe583Jg0gXbJ/MsWk5MaLKBf/QuR?=
 =?us-ascii?Q?/qqDsC2Zg4+qxOiFmJMBCYIdJV89gdzpPuU0otJoJRx2uXAHjcK15+oK0j5P?=
 =?us-ascii?Q?3UZqnld3mGIXlZQArAgLHPzfD9oWVQ3yILjuxGsikmiA+VG8+vIviBsXPhkq?=
 =?us-ascii?Q?XuuvEX14lN8frJ1dMAJCzcaK1SoTuBa4QSwOOcO6oy9fvcunV3AEmzUyBMiz?=
 =?us-ascii?Q?lIUDDVt9E5DVcJh4eNfQ4qLN/4fagC8Vuj5M3wU9ch3z/qIX0Kz0I51IL3wA?=
 =?us-ascii?Q?XtU4qC1L9/FfjWU5wQKGwQW+95P/ZEL0TePZu+RyOzczP61Fl43A+GkXkcZy?=
 =?us-ascii?Q?QgqahCfcSTZ/eIU1obo4h/AO88O2Okss9krkyExfVW+7OgXq8AJQrsF3NIrk?=
 =?us-ascii?Q?x/U1Ewu3/WcFompncwItJWcE1JejP3IfWpx7E4DD8yZujYQObdk2LyS7f34y?=
 =?us-ascii?Q?kGUPBJ/kyklXLmxAztS5To3fCw1DUYaVX8q55tDL92dYPHRvXxGkXfBI2ZqG?=
 =?us-ascii?Q?Qx139K9kgayiWpJhpE7RX/fXvQGdfIhUwTczeALvrWdoa1VuBhnF/XOH28EH?=
 =?us-ascii?Q?UViYLpfkO4ACUov96tWbNw/UZcnpCH8m8fYg8X/aTWCzLxEf5+NEX8zOcyvb?=
 =?us-ascii?Q?4ZI4nzMkq5FdF1q48rESXZ87yEIaAf6s5wCU8knohJxFiMPk1k+LK2FtSXZY?=
 =?us-ascii?Q?/83CREiD0Iig23COpP6ga1zZvoq+wgBnSQM8HtrxJapwIVWOz10bNzouHNPL?=
 =?us-ascii?Q?rvP6e2szpUMuVyiuGFGRNZGxaRwKA8KWq9Xoh718Yq+XTK5NbZd/90SVeqpc?=
 =?us-ascii?Q?cpJW8KIaefc41h8x9pTTcj6A3yjOieSpgBttdkQ26B4PpgO3PEdpAZ1lqaaa?=
 =?us-ascii?Q?dGqyiLsM77H8FrCrC+A+Zh5PwA5d+2dN0SS0KOHRorCQ77e/9gfLybh9HY6u?=
 =?us-ascii?Q?e9p/BVtogl8YpFRmVf6CgLkJLWtWrZpZwfFJevEVzxLjnNsxMEdRTbBfdNX1?=
 =?us-ascii?Q?jYB8GK2DzwdyP0Sqy+copeBRirNo2QJFWDHmJSN6aWdCp6/gGagNal6vgx0p?=
 =?us-ascii?Q?cCb3NZFJvYXkydB00qRBk2jgq793NUo/+vMnlituc7nxEfjmIo5k4jub1LSn?=
 =?us-ascii?Q?6ABYs9g/h7qO4BNQR+GxA3XjhbmiuhwtEspF5qa9/kvCKWmUkFLFRRm1z+uf?=
 =?us-ascii?Q?uzORgMAdWPIz03Jr/GhGvIINjE2YruUsGKmx7/bQZZLOpOrelcPA2ayoi81q?=
 =?us-ascii?Q?6aUxeWeyHdcb8q5YElyn0HLglUhignx5RoNSc6vRIv6OHgmMNI0zuzp43wxx?=
 =?us-ascii?Q?xoFpf96f1q3v9xFhSCiNy+YmqoZ5iaNNoZUdqpaXAJ1xoeHt/mVg7rxKbhzo?=
 =?us-ascii?Q?illDRfldBYr5Pk8uD0oiI8fMUS6b3rS1?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zl8XvnBpRbA4mvZ3IvbXfFtblQSqS9PhLymuR2KklOBMLqOmmP/KftoyN+N4?=
 =?us-ascii?Q?wzZ9OmWO/XIC/MF1JyevFrmL5jVaVHCALsnqk1oHz/i45VVhOy47ZUWrKmvs?=
 =?us-ascii?Q?HrLV02ldu2aJxZ4sCOnYveL0G6HB2R669InAvbVez+2UwAePC3UwECtNsj/p?=
 =?us-ascii?Q?HIR3hfxv4oTl62rKtacF2zR+mD4NfT5YoJy82jA2Rr5Pm3E38ZC/bI6eF7E9?=
 =?us-ascii?Q?CfKBIOABWyd93E4J/27OksV1P0QWwJyZaARNSs99+7G+bt2NiwC5Ti3NMsw1?=
 =?us-ascii?Q?azd6sLfMfRPDIVxFHplgb49HxjpwLxABVa3caBy6OVRQyVJHJY2g4jW6ea/k?=
 =?us-ascii?Q?M5Li7JBvP+exSEG2X/dx9ZdDT2uw3qZ17Nnz4jsP+cEkxd4j+psEPbJNLKlx?=
 =?us-ascii?Q?UWu1g4MQZQhvUlnpQtY6gOgwinrnTZycaOakcnp27Z75e9Ucx2LAWn8JE8ck?=
 =?us-ascii?Q?foMFfc1bVx4RgqlXldCpgWZXOIiYMCK82HYTEQaiOE9PXRpCbgVmtcNS3Qri?=
 =?us-ascii?Q?HI5xKhEO1X0LEC4C/2LLv/9yxBuyJFw3W7QfHgmyauez8meWtKKNaMCr+zts?=
 =?us-ascii?Q?pDOsPT2IjcPTI/hy0uCqp7EmkxQsqdqkuTuPwNkENftwki6BT84VzFA26oGx?=
 =?us-ascii?Q?/ZwcwkKUiwoF0kXOj30O1jKIWCtuyimtbZhRGF8bKfxncuizJ659dN+VouRr?=
 =?us-ascii?Q?a1MSjdIyn3/GQ15nJK0WMamFAceKhhN4WNgw4ivbyCOFvz001/qz2VkBdsop?=
 =?us-ascii?Q?+1cYQx+zYkKGf275nBFUxFGyW0NJRJW2wMhpLLvCMAhjGMBgcFntZAr9NNXT?=
 =?us-ascii?Q?ydUc8XQxf12OeSLGhoPxK/1wIJfkj3O9TN7DB2AAqWIeVZ7o0y5oXG023PCT?=
 =?us-ascii?Q?z4fqFYLfPQ5jjQET0fN+PLO13hmWteNXAzYI8t6KfrARLlE2bhXKpgT+WtE+?=
 =?us-ascii?Q?dKRARqKTPdjCa+555LBpI7z/k3WzUgQnGL/qibyiClEwGq/i2qo2kHt3HZ0o?=
 =?us-ascii?Q?WyF61Zodx3ctQIxvZ1tnyCcDbTZhT8TzaV544MqCDUEb039UNqgvygCqGfEj?=
 =?us-ascii?Q?oxZ55gw1s3OH2v2MyslaFdC2vibMJamWW/nz+7e464j1jar+x7KF/uOPFRS9?=
 =?us-ascii?Q?rt2J2GPbtYmxLuNsbvBlyLjAI7OIuyxwbRGR3/OtWqONjpvnLzXJ7PbRPqNE?=
 =?us-ascii?Q?QfzcY1IYKq0+80j/BugO4Wf4NNED7yb/9NdkcCmVjYBsWRM76tktuo6mhOi/?=
 =?us-ascii?Q?wRA+unp6XUU+Srru7N6hf8uRqKs9uSDTi6brY6KeVAYqVG+RYUSWhTvd+pTh?=
 =?us-ascii?Q?zD5tbnpIFUl7wF6TVDFUifqGnfKtSQiWYLrTbKd4+63aNAQP3MavBEN1/Uco?=
 =?us-ascii?Q?htSQp9hr/ffL7RQw2iKXzrrDG2Z2BN6xaQP/OuF4GyRS8hS2e9E5d+Fmux8g?=
 =?us-ascii?Q?HdSTzuiIcdZyT2bqERkh6MDtNii5UlSOCQO3y4SNDOrcMOvSCxFVeq07hMl2?=
 =?us-ascii?Q?Jn5Fzf8WsdyrHZMXnHvPLAEJx1Iy4VxNprxgMMC10MHaba6nSUwCLRScMrpw?=
 =?us-ascii?Q?6wAFn2KPx/+GGTEnIymcdWnTkTqJaQDFGucvwlk4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc03eca-c2f1-4d6a-ed35-08dd31462f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 07:12:46.6907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJSh9KFl4lXrwCjNfok0BN+jfrBstvz5vPRXke2FiKH/lVwS/GStlTVzX/FTRUBHNiAcl/SRQ50SbORJvINdLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, January 8, 2025 1:10 AM
>=20
> +/*
> + * Typically called in driver's threaded IRQ handler.
> + * The @type and @event_data must be defined in
> include/uapi/linux/iommufd.h
> + */
> +int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
> +				enum iommu_veventq_type type, void
> *event_data,
> +				size_t data_len)
> +{
> +	struct iommufd_veventq *veventq;
> +	struct iommufd_vevent *vevent;
> +	int rc =3D 0;
> +
> +	if (!viommu)
> +		return -ENODEV;
> +	if (WARN_ON_ONCE(!viommu->ops || !viommu->ops-
> >supports_veventq ||
> +			 !viommu->ops->supports_veventq(type)))
> +		return -EOPNOTSUPP;

Hmm the driver knows which type is supported by itself before
calling this helper. Why bother having the helper calling into
the driver again to verify?

