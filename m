Return-Path: <linux-kselftest+bounces-20652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B969AFE10
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7EF1F241F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34201D364C;
	Fri, 25 Oct 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5/aKZg2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F311C174E;
	Fri, 25 Oct 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847892; cv=fail; b=S7bJ/htD48bHLa+Bu83j0b/0fPLKbBXQxlsbjrj0z0l2J6IhzuLpv4joUw6EAx31yC80kSczxbMMozrD7oODRikG1uawidyImIuYpwSkxG+HLMdDNzM5laiYO8+2MmiklygEr7RXDIpjnvdsIYI+eZ1ays88Zy06jWXq2M5wK7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847892; c=relaxed/simple;
	bh=j4lLfgTVUULlLXIPiw4AvYlIuhdTtA8mvXPFxjDGWcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JILKEuSJUIQDmj59WtC+fXJGM/GxtPx2/H238m1eGP+IApX2u2jHV5S94YOg+Vh6AqNY2CD+egZ9xwu3I3xleOvxwFn+RWH/UB+rYoavo+LjSfq5aEqrM52T5meH3ibnBdk5UYBr/vQKOas8Qy8NVeJDPOjuik+T1QH4lPbYqEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5/aKZg2; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729847889; x=1761383889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j4lLfgTVUULlLXIPiw4AvYlIuhdTtA8mvXPFxjDGWcQ=;
  b=f5/aKZg28h+Ibj/XW1YHZDNRWou6saUbowRK1+HlrSikYO0R/9qrZvBE
   0w5QRWx4ziWU3FgEO5YtwXttWutMo/Pe5I6TZot1huauiedIZAZzrOo8z
   X1UkENRX0g5zpStkJ4pLnaoDd77Xqijdip9VUQkusIvaF4/H/0DuGiRyf
   LcoMpYi1PrZ0wS/TZf2e5zkMCK8nGHaNp2f49ageJevy1zzdIw0X+QCKR
   Ffav6LX3JatFvg2PZQ3APfJNrKiFCSXeR14zm7GzguDJeM1Lw5WPWU5y9
   OHIum5cf9BVLLCXUk+W1GfdnnysUt/9htSacHtRPhC1qURojZ9LmPYAkK
   Q==;
X-CSE-ConnectionGUID: YOPYA6ZrT9ak3EB6Oc6aNA==
X-CSE-MsgGUID: hS42bvKJQnSk4SkBDyc5Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29641101"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29641101"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 02:18:09 -0700
X-CSE-ConnectionGUID: oWTD9XjOTn+VVXHTb8KnSg==
X-CSE-MsgGUID: gsOSZKqMSNm40nhJzAJNsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81183545"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 02:18:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 02:18:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 02:18:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 02:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnWQ0uQmdEvnYlJgTeTn4mHRarsnR9WxVCYvRp6mMnpduRfAPmnEUS7rIyNJbvzby3nDIftyzK5xscJUTUkB9B7MJV/VHi0jGrAkmc3mLEmc26jIHDLL7sF3/z8EfxoDR05gISrVGALBPkicIJhuj6HG2LTfMzlpqKH9mHFyeQ7bf7IhIjwV4+3ooEfA7ubpTWvIBxiyKhvL0B4khqMBv7yxN88EKgypDgVwgh9muz433fZ4mZNqR6iKTfNHu0PtMGHbaBT08vLZgK96I6km4eIYA7314q0SLJ4b+O0pKCXZamm8r8j9vuWW3p7Lvx6GXPvKFI7rw58Q45mkwgzONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4lLfgTVUULlLXIPiw4AvYlIuhdTtA8mvXPFxjDGWcQ=;
 b=dgzzXy+EHVHt2K2++nBh7RMVjA9ilHPIhVOcaT7u+woOvc0VOCHaI9WiR4buHzjw3nsXRirevY/h2XHdxBhHlZ/OvmiQ9e0HhzFRbzgch1wnBnBN0NtdSV2WnxZYj5zrM8xXvrQNDgweUOqgpu+SQ7uFMyvC75Nomelob523ORm1+la6igXsTsK5iId8JaOytI7ofJnJ0SUoZQomSIcEW7Z4QPOnCEO631FUR8bjbVGNf9WKDf0fsY8BEZRYIRE3cWSXkMgevUDeENs27+aP5cUC7TGPBvEY3lgiO1ELBbLGH5V5sSrwBpXvJaDrZnjXvVIJqwqBg7zEabTuDZV8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB7636.namprd11.prod.outlook.com (2603:10b6:510:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 09:18:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:18:05 +0000
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
Subject: RE: [PATCH v4 11/11] iommu/arm-smmu-v3: Add
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Thread-Topic: [PATCH v4 11/11] iommu/arm-smmu-v3: Add
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Thread-Index: AQHbJBg8SEstnmviUEes1cLxt+VtDrKXM7Yw
Date: Fri, 25 Oct 2024 09:18:05 +0000
Message-ID: <BN9PR11MB5276C3BC659CCCDF3A1189458C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <2180fdf423d0f2fcc5c031687690100b12c2ba51.1729553811.git.nicolinc@nvidia.com>
In-Reply-To: <2180fdf423d0f2fcc5c031687690100b12c2ba51.1729553811.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB7636:EE_
x-ms-office365-filtering-correlation-id: 1fde5b6e-15d2-435f-3b1c-08dcf4d5ef11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UFcoLYeCL4SIozGp2EB3Mf5EjRCtFp+i3QXyXh1b+5JhNzyvQxwUJ6CWuEbB?=
 =?us-ascii?Q?rhr2MX4y+ZOGUk8UpQq7nh9ld3DUgjwKsYrxa8BiukFYEAQu2swXBevmQws2?=
 =?us-ascii?Q?iAv33ewZ0r4572unQnt03y6nG7OlYKdk7HVkwcHGfQtd8nYyg7mJMwTeSjS7?=
 =?us-ascii?Q?FZadX0y29AwPv5VnJftTUrRGrLtBQZiNGTV3S/KbDG070qEVoiJSn18UTM3I?=
 =?us-ascii?Q?bs8wBSkCMcXcvGdn6hu/EW7siyTXG9Vco2DdPKs2k6D56MUtSFwJ+6dK3oRR?=
 =?us-ascii?Q?yHyjl5Qtris5hoYkfGq7Z3MiTLJ72krmyEsz5jgs6MkdYTGl3U2Y4kbhTDz9?=
 =?us-ascii?Q?drlPQxol0KWVtOclVHPEeo5ss1QGzxzT57xrBvZ5hTl8nU/WB9Ne23SEX3Z7?=
 =?us-ascii?Q?w+8NMHTQnBx8Q1UKxWA4KJgDe/zl21GxdkYQ81fkFOIq5+bciQOtAW/2Qefd?=
 =?us-ascii?Q?6dJoSjsMAinuZoks0+dMx6gwkSWaCRTAlRkg5vZIrxWoF2uJAjm95r2H/fFS?=
 =?us-ascii?Q?4evW3qd0lg/dIDBMm9fkSjFe9DfeIN5L+PjnuSfQg4oF8bzPvGSpYzmSbLrb?=
 =?us-ascii?Q?E+aqH8CixRXQz99zv3vdS7Nbsf0NOkfe6Te98NYNa7BOZkOZwPUxjaQYG6p8?=
 =?us-ascii?Q?8H/jwYS2J1ku9G2AVLRiXRAPpkewOYo7+0ehBPKjlAO44ARJurF3CRKZ5IXZ?=
 =?us-ascii?Q?pdhBdijuZVCkho/VvrYNonTciwFDA6NdR5z353aoSDUzpdDZ9KJ2VgQycxK8?=
 =?us-ascii?Q?dHyy6lpkssJLeekb3lfITgGo6izw8+I9QztFKiDAi0UQTXJ7NCsd7azVjJ8/?=
 =?us-ascii?Q?2GzDI2EgEK7fPe9oTDkA7xfJWUn1JtHxZOLZ4trUthLLyel75DJiwQet3Dbs?=
 =?us-ascii?Q?Ci0DJpWKDONd5SqOF0wQzYST16w3STyuME26AstiM3IsLLmDIhKvdJUEfTbD?=
 =?us-ascii?Q?rOKCU2ou+oaFnQwrvih8cet8hJYkLlH8Fz/UqKarh9parEbWr99R3MeaOX/T?=
 =?us-ascii?Q?a57jbqQ6p4pcxC6C8IeuB5WhlmQwfqUfZX7W7Yst+/qkhE1+aVG8vfx7TMl0?=
 =?us-ascii?Q?XrElxLSTR+V8J/gYnL+C7P6+OJms3Rh5dsAtrFRzkuHiJ8kMzcpztk9Sns9A?=
 =?us-ascii?Q?BUUSwljSHj2ujfBj/ke1nOGTNMcyGtJeZsSJAe0EjhWR5rHrt6VuAgPterJ3?=
 =?us-ascii?Q?UZ36F9rQTZig1HhUwBUTitTWazrbMUlRsNPCXPofkG3f8+3PMdA7YOVaq3Qk?=
 =?us-ascii?Q?00+UaEXkMHb2DTSi4hClQ4w6aIMPkrUkKsUDPljJBgRDe3uhQqOvW+nn8pe+?=
 =?us-ascii?Q?oYoCTERI6Yfr1u8kftmf8qLakJwrBepqjLMxuwRBru2pa/aJs0ZWhoD1F7Wi?=
 =?us-ascii?Q?tgJRjro=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jg1QMqq/l2x+6r/Ua0bqDe/luRkASYOhREe4XArfn7uQfpz1pD6k1a2wrpDy?=
 =?us-ascii?Q?Be5sC+XFO2ZgvZbBWmHCF2bV7cVdhkRc4BNSmxpiPVhrCUbyQJG6eg69OhXe?=
 =?us-ascii?Q?fu8z0CQPXoiuMBYGjXfEN3fcE9yM9b/zIka8OZWsibGk09N2ZZIx73EGW0zK?=
 =?us-ascii?Q?WHjx5N0AUXqmzZhocAN2u7HbWq/fnMnfVK10DyEWcW4AKFM/RiD+bGlVb4X5?=
 =?us-ascii?Q?DaO0B9ZwKXUOjvnkmZbyLPhaDNoBPvkUWOki0kaIHFsSNfIo1HkcmabrDx6N?=
 =?us-ascii?Q?Hstn4vzy1EOunSf0ciAhp8xpqxsxEiyUMaiDvHysTp5EuIEaWMGBYdmuNY6h?=
 =?us-ascii?Q?sfgTBtgKOTai1XOvPu88c+VPA8Bys4Ja94/mzw0erMjiahbT0hvGrkkFIcTH?=
 =?us-ascii?Q?JrfG6sVsa8YQWVYMFDyOkUe6bSvK4YHIlLQNTsbvKF8AlPpwTrShrZe06cGW?=
 =?us-ascii?Q?Hh7/5dlGtO1+0O6+U+hkH8n4j4TKB5AV+cXrOw8aBwGxcjl/Mao+U+ogEVKV?=
 =?us-ascii?Q?9kbP7n1EKrQ+nyf61wBZ0Xp3jRKBVXppyWUh+Yv89MgOn627fY2t1OQp7KDX?=
 =?us-ascii?Q?V7L9EMPro0Y0GxR5QZ6a4DhSXq+ngpfG7/g67p2GVAp7D2MLRgqkHkXN1SDX?=
 =?us-ascii?Q?HXpyKyrPOxi8AaMGP8OolT7jz48jjtfr9mEEBOfFsSNSBk49QZpuyn3kqnwb?=
 =?us-ascii?Q?1LreMS11Xfqx70vkjoivKt8mfgIiSm7p8GOpE37Xllw0qykeadfxR9Eyqyf8?=
 =?us-ascii?Q?i+wDJOJB/X6FSqSa03/8co7JA8jX/yX78Ij0W3EoHLg2B8Ylsh/oJpZXHEwa?=
 =?us-ascii?Q?uhxmxI1HzpT6Kji41Gnnwcxi5EIbSTZ0GDZCSLLlTX5XtftSNKEXQ1FMqz7O?=
 =?us-ascii?Q?D2dpkx7NZLD7jgbJAMmO0eAr2nL/bJ5e1pKxqbb4Iyya+bsi/RjnB0oNHk4H?=
 =?us-ascii?Q?+nr/h/EhT8F7uFzzAXzSzXMWu7g5+Xwp8tQXFtG0adQKqztFMQ369t7J1jBM?=
 =?us-ascii?Q?AeEHa2HunqfMuceV+iOjTxLnN4khoUoAmEBYArD/XAbkB9wiBAjI5zCqBx7S?=
 =?us-ascii?Q?VKL5Q6kG4sCfKIs6cXz24jLn/WtBrS4jw0YklIYEeTOGaEiikHgkhp4xVoWn?=
 =?us-ascii?Q?lRPMoC8tDd0pUntDf2r9o4W2laqlP4aTLGdT7fsDXOJFE16b83PhXrBAczV5?=
 =?us-ascii?Q?1OCRG86wbAt8MDg5Tl6uWkb8nh4+MZZEvIIXyVNRbIE3gkxbNl73VhUU8/OV?=
 =?us-ascii?Q?nN0zIOHfG+2BXImyNalKfPzwv9qBezEw/CR2bsx5o3NsXSYPKBMp1kQ4q+le?=
 =?us-ascii?Q?GdzIJ+MJvBrsUM9Iw0N/rHuoLVG8XenUGmODkiICka6dlmoAmtgCYwdKQEZ+?=
 =?us-ascii?Q?pGUK7HBnqc2CL9dcfVPlMsdTJRrXJ2DQ3ZQQt/yfKn2i1o6jD/fksoPNRSs1?=
 =?us-ascii?Q?qz1HmBOM+U10JfRrcaina83MpG6u6IwR326sOkMtQx/W8JFq0gtYOWZGfUVa?=
 =?us-ascii?Q?/v+cyl+9TekxEHeeJYrM8jEs9etWeDHX+rD8mA0fvLfsxj5CJQuC+pRgQaSO?=
 =?us-ascii?Q?FiS97i0mf84fmUJs6sTqVCJD8Pd+fWtvIk6HbTAX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fde5b6e-15d2-435f-3b1c-08dcf4d5ef11
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 09:18:05.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPhPy3jLsiG/x0Lz/HmnoQj+lhjaKLXCmgX65TVfvcS+BWBXFbdBsFFLEj+N0ZRXDT1o/+rHpaNVC7ho+IL41Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7636
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, October 22, 2024 8:20 AM
>=20
> Add a new driver-type for ARM SMMUv3 to enum iommu_viommu_type.
> Implement
> an arm_vsmmu_alloc() with its viommu op
> arm_vsmmu_domain_alloc_nested(),
> to replace arm_smmu_domain_alloc_nesting(). As an initial step, copy the
> VMID from s2_parent. A later cleanup series is required to move the VMID
> allocation out of the stage-2 domain allocation routine to this.
>=20
> After that, replace nested_domain->s2_parent with nested_domain->vsmmu.
>=20
> Note that the validatting conditions for a nested_domain allocation are
> moved from arm_vsmmu_domain_alloc_nested to arm_vsmmu_alloc, since
> there
> is no point in creating a vIOMMU (vsmmu) from the beginning if it would
> not support a nested_domain.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

hmm I wonder whether this series should be merged with Jason's
nesting series together and directly use vIOMMU to create nesting.
Otherwise it looks a bit weird for one series to first enable a uAPI
which is immediately replaced by another uAPI from the following
series. Even if both are merged in one cycle, logically it doesn't
sound clean when looking at the git history.




