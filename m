Return-Path: <linux-kselftest+bounces-20904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B01D9B4417
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8235B21E00
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9985A203700;
	Tue, 29 Oct 2024 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+FjRPyH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E63202F64;
	Tue, 29 Oct 2024 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190218; cv=fail; b=XLvRHKthLIRSxHE9pk3+0KmvjLJ+1Froy6v42cCk23RT3tPiQf5ELVMAeC405xqwyUCNQFI/wYGh/mKZXIP5AkyWFy9u1bsotXgXpHBZIfDxRyx7h0UyTgC2fwEX/K/9v/acMoiGAyG5EqJrjYxhxuDmgPyaTXeprYs/Wsoev6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190218; c=relaxed/simple;
	bh=g4T6yae//uj5qG95ufkWMUQk3LvOgHDqxTZNVFvzusc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=An+JQBc98zzivL04U1hjSyRb9TkN5xGEH5oYI7BTaLL2OfKRU4bOUvT5tsAMKGgrtvhz4R4EbqoYysGbHRUDkYQBqxX6vIiil/w5K0wJ/5LW6QLB7LyElxioNfavyw89PHVHiiB0FvR72YijDdo+rtbDoyYTYPdjSpZUApyDjjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+FjRPyH; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730190217; x=1761726217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g4T6yae//uj5qG95ufkWMUQk3LvOgHDqxTZNVFvzusc=;
  b=i+FjRPyHZ2DhJSLJppvb7CRu676LlpizERKPzqDiOtgFook3CjuIzcZr
   0NBu0E+iZAUlHVpQfVzF2UEwsWCzypvGq5Cs02xLlyIOoupQTYomo7RVl
   nI2fzu+NeW7aItWzgAqDJPjG1LUSgzOFj0Km0Y7sCNJOcjiIaEOQUqmqo
   KRtkLBECIwTIJ/xy/q89hgK8VSD2ENMrZXD91FQi4DF/9exnaSD8VQJnA
   uSKvWHA6TxBE2TAfkrQrIk0zpKlhvHK4EY/Q8Qk4phLKtbRCst3esUfpF
   GP54aHLP7pTModX8jNzjrlHe6HmbeDr8kGr8kSmEAAlSxJJ0w0ftP54cw
   Q==;
X-CSE-ConnectionGUID: r4llO7n+QSukqhGazLEE3w==
X-CSE-MsgGUID: r8E9HHSMQT25cLgvyqCMRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40914371"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40914371"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:23:36 -0700
X-CSE-ConnectionGUID: PfQxIydcSYKeCwaeon3oDw==
X-CSE-MsgGUID: 1LEKTeODQ8Cbk24E2izY9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="85841697"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 01:23:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 01:23:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 01:23:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 01:23:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6s5WZv/OX3q9N7c3v9VBTbEG8Lv7o9ZkFYUEeGpu6e3TVbPEpAAjfj4/1ri8/oEDnTVLN+x5yeHq7hEo7EQKAj5nt2fBDv6xpeDyImIs5tHSs0D82wZaJsOjI+dlYpuNPMxlgDWWMf4CaR8yHFozRZF+lZmgBI3x/ah/NVq8I416kEj2Dzc4rom0WnTxiXWwbJdZj/DBeJOw2gdHEQjdNBYVam7NxwRT1Ysz/1PwlGPhEBhSk9ndeSRapfbnwXlAnoVFm6vwC6dS9vuxnIO9Z5k+p6hF1Wa3Ik9vah2s1vl6mWji6ywVoMaIuN4aKPLpxnFOfdCK8fACao75kEjKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4T6yae//uj5qG95ufkWMUQk3LvOgHDqxTZNVFvzusc=;
 b=nzaKH3GWh6kEHrjLWI+xk9ijk159Qrrt/sGf8k1bum3WUtWbR4hUaZq1zoJ8pjPWUxuffGBUGBeT6onpBVYPa96tX2IBMyKYx9hpYrv3RO+qK4o9LzgoxECkDjGsip6gyafermiS6bjA2bhN2bFCuHJh2w2bVsDnhMhIqJV24+JCmXDDr5SOjp7RU4rfIXeBeyegIZrs/JaNlszFYLhaPf7JWs/NTRxqzSpMYO0jm2rlXjmxHOjx/QfkoQTumKW2X+jW+ITrNRtJic3duo8mKDObTalfl4FUW5hIxSYM6ZJz8JkizgVI9tbE7E/kmKfLQZzX3Fp7/hMcqRdbWcYOyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5133.namprd11.prod.outlook.com (2603:10b6:a03:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 08:23:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 08:23:31 +0000
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
Subject: RE: [PATCH v5 05/13] iommufd: Allow hwpt_id to carry viommu_id for
 IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH v5 05/13] iommufd: Allow hwpt_id to carry viommu_id for
 IOMMU_HWPT_INVALIDATE
Thread-Index: AQHbJzjOmhSvQMQRKkSWN0caTEho17KdaSKg
Date: Tue, 29 Oct 2024 08:23:31 +0000
Message-ID: <BN9PR11MB527600E88DB9EBAEA9B010E28C4B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <6b8bb8f2319bf26ead928321f609105e4e5eecf4.1729897278.git.nicolinc@nvidia.com>
In-Reply-To: <6b8bb8f2319bf26ead928321f609105e4e5eecf4.1729897278.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5133:EE_
x-ms-office365-filtering-correlation-id: bbf521ee-3bc2-4bfa-e4ae-08dcf7f2f956
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?A9ZU1MiVoUqnYB+R/dIsi4xZGOoLvgmaFd/I+EA088RdHzYjKIJXYyxxI4NJ?=
 =?us-ascii?Q?RbBC2MsB7VcKcF6RAfNElIwpV+sylmAn+LIVBvBxKZHJPMenJ0xjIXQdbYqj?=
 =?us-ascii?Q?V6IS9roKTtjraC4hSh7jgrPMvpb7Une5qrpGDkvduCdaH464i3MpOTIhmB/t?=
 =?us-ascii?Q?PA706oXtYxN5W7k5RETAWFAAPFmxxau/cGVMXodIpYEYm2NOjUgm6HvrZVjL?=
 =?us-ascii?Q?lVzxw2qHNbnLmDebFgKqI6YWq1s3qeB8w4WSvDW9zXAnDoopmwKlK99s9wNo?=
 =?us-ascii?Q?HIbdtWtdl8JI2FrO+gTgdf4eZFH9iDPI1YvwVdsXgSUW4vtAaJDWEVaze+NI?=
 =?us-ascii?Q?r2jxBjxyXhRlSuOCRLb1RJtoHG8YER8/588/eQCB1yr+lbXuxKjGC0+6WqUE?=
 =?us-ascii?Q?NHpULuDc1pCcTvpWvqslYvWwyuOu8tM4vJDsygQ4QKqlCpypuGJxyWPdUtzR?=
 =?us-ascii?Q?pkGYReThOsSDKh/uQy521o+aNvvIltBvQPlZecli+jgPiTFeU4fFpB9bTMRV?=
 =?us-ascii?Q?8JdMytaf9Mbe+/WC8Majl202ksXgyTr/ocrZrIootr50fPeTMNyCqpg3XDo2?=
 =?us-ascii?Q?BwbOLVSk7O/JoMOV7ClR11HMxdZDK5gxrXb60Cpd89a/L2C3mTOWDYPjnB8A?=
 =?us-ascii?Q?0/7Scium0/redom9Pcqgx0D1XImTUoVYqoW+6L336yr5tCeVKrf93tmA3eZI?=
 =?us-ascii?Q?XTgc6dmp1Fh17c5D2wGn4JbqpTlfAMtw56RFHJLRYB6v6PxYYtVSF391EsnA?=
 =?us-ascii?Q?K4CiLYSNpgS3JViKX19k88aH8oa4LPISG1g1x1k6FGYw+zZkaodpdmek6q5+?=
 =?us-ascii?Q?nH0PEgqYeUIN5FPrsGLiji+0lnFJP4mqXw/RLXnw5aM3402EINVdvMnh1XQV?=
 =?us-ascii?Q?cVrP5cmqHhMH4is0RU+TXJYwnP56HBNAv5VcwUrw1eFCwK1IdXWXhuJFp5tD?=
 =?us-ascii?Q?1slJjDyKAs+AxKDzvLX0wR9I0Lj3MuZZ5dlfXhCurU2K7aTjjAe7Rw0oLBtT?=
 =?us-ascii?Q?eBGE2vWIHyEe6VR56u8FrfNX2YifZZAVLdSA4MZLJXSZRm9HMyqG8VION/dl?=
 =?us-ascii?Q?7QJlWttHuzgDT3ZV+MESI7aFCI5quRc17tQH3k+Cm6LovCnY4AsUY+fQ5bJI?=
 =?us-ascii?Q?+jxS4HXxSbqXiZW+zHinVUONvufQnwUo2flbIiTgVpbXP86deu1tZcfuNdeh?=
 =?us-ascii?Q?UNGkZ2V1RVQGI13qtR8TM1U3izo74Y6OgoLhZthwmvbrsFdgrZFS87erJIOC?=
 =?us-ascii?Q?Qlq18luxXKGF0XYudDm1fjngGCiOMTbL9UJE3DXwvQK87z1unvUGM6KW3/y1?=
 =?us-ascii?Q?wHVjEdLu59qYRS3rsqHQDt590sIp9bVeHIdCM45lWU3mM6KVAUe5w8HSKpNg?=
 =?us-ascii?Q?SP9YmP8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v+k+I0V4uFExKfo9i1Yh1ZsI8WoDUAvxEdj6QDY2XIwFysJITD/9wafroc5v?=
 =?us-ascii?Q?IHksbkzoeHyxf6wJv4jFTpuNFWK1NETasa8sKO0B7T5b9PfqQUB897++KkDi?=
 =?us-ascii?Q?SYeH/oLvebmSs6xRFBHrQbnqOVUlIkvNSJHmWRcWShPKWmSH9UPX13MMAd2n?=
 =?us-ascii?Q?6egX1hx4pZh2a/t9Awh24F0GmjEpwec2EmI1jlbstGT8bI3nXMndD/5Yv6z6?=
 =?us-ascii?Q?gzj82k/Uaq9Rck9bP8nuFYyj0FP5TTE0BBjEy6NfUaAWtyRHVl/ht/RlBwOa?=
 =?us-ascii?Q?F0lM07VGM4N6AfAxnKFcdBtux7X4axFhe6r4G9bkADwAHp5otCOVvkL1Z8mS?=
 =?us-ascii?Q?E4Hz0YLOvvQpqkbWXEJqNBLtgweBTUGgL0+U+IDtFP3UV6ZDDnmuy5zV3B/D?=
 =?us-ascii?Q?+E2uU5qrPwJGh13ak9oChOhuyU8CrEcv+oXCMELLrfWBw1MrT0HuZNkzdR9R?=
 =?us-ascii?Q?jmCfL4WOtJ2/0eUQW5RBgBNAbzMmWeMNGIfrbEoLM32qBnGEi3ZOF86MNlJ2?=
 =?us-ascii?Q?HuHDZk6n4Wvlvufd/EM5vxIg+qso47loh6z/gSzMoW/3K++KsTcg+EC5tX53?=
 =?us-ascii?Q?TaQl8jryJuRJWBk1Zs6KuGzZI165So5YKzBlynxl4lEcx83fCR+8DaI1Ftns?=
 =?us-ascii?Q?kkLnal28Q+lvXk3g20aaZcsb3xQoKY2HLBpLZP77H5+woIH61S6+JNrUmVcG?=
 =?us-ascii?Q?TD24hpm8AmNj+OnFvfSfu6w/nagc6NL3iatwMYk2zgGFtGLs4d+koH4tYIG9?=
 =?us-ascii?Q?aw0OJHPqNwfLS6KxobkVKyUAKrnsvTowSepe3zg4uDvpWsJLkuJQiEVK2gf9?=
 =?us-ascii?Q?azqsPa7p/0SplxnY68I/v2r8PeLQc/hA1e4OIATCke06F/Bqhgp4nZsOs6Zs?=
 =?us-ascii?Q?ordI7n93cnwqqVHtuj2U0dA/u1PjF/tkpWkfvqWVDtsCPlrs9Gahvx4EoXAJ?=
 =?us-ascii?Q?4EE7B3L8HIUm569rmeAocL3EeCNnqaU1aAHt6eC2fZyaTwONRpLMbxn2fycm?=
 =?us-ascii?Q?QhJPZnbeqK7TWKe0cghT+HvHzGnkZaMWIi9wS6tWX+s721JYD/zdXuQ6C2n7?=
 =?us-ascii?Q?veo/jAtiZIvfEbOkCMU8sN1qagz+IvsRfnG5aNMa02HwkHkZbKEX1wk7vg7l?=
 =?us-ascii?Q?kAL7tRAqHvwffB67v4ZL0he2hZQVQDjebAZWSZqAGWVchfFZw0Q482eSxNRl?=
 =?us-ascii?Q?JoSMtQbjCd8Ys2AuFwk0TLSsWq3oPEde2+/48A8yDl8qCfFepyoAJ3Aw1lJK?=
 =?us-ascii?Q?gd6DohGniwAk4lB9eixP8tS2IL1DvmTjyJQ60AUcSCy7J46GGdN2r7QKVuJM?=
 =?us-ascii?Q?eri+quZcgf77f634XIt7gzY8c0vi6HT6tUhdRy9clpZwI0XJWaSfsK0v+V6e?=
 =?us-ascii?Q?bvvRs5HhmqCqdE7schnbUhbWpcKyMgeVWGmsR2UNgXQYunMT/cFaOO92DTYk?=
 =?us-ascii?Q?c6wL7APsftv2MxWHRZKz12/j8JutwbT1TFIHGnHXubGE+6XlulP2OXm2v3NT?=
 =?us-ascii?Q?G/l9+zm+MmrQdsDJ4AQpkc3ZKwvjzmRBIKGgoXm1aO8TWTkoiau+0hrs1rTB?=
 =?us-ascii?Q?6yHX9F2JWGHv36fPAwvR++DXjHZOzTcy/IzXB/dh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf521ee-3bc2-4bfa-e4ae-08dcf7f2f956
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:23:31.6869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m33rkorG+SVJCsdXYyGZMS3QllClW9zv2FAccqPr0ceJRA3Z7dPJ2pTyZmxfguhZLQqGlXCE+aI9IwKf+O+ESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5133
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:51 AM
>=20
> With a vIOMMU object, use space can flush any IOMMU related cache that
> can
> be directed via a vIOMMU object. It is similar to the
> IOMMU_HWPT_INVALIDATE
> uAPI, but can cover a wider range than IOTLB, e.g. device/desciprtor cach=
e.
>=20
> Allow hwpt_id of the iommu_hwpt_invalidate structure to carry a viommu_id=
,
> and reuse the IOMMU_HWPT_INVALIDATE uAPI for vIOMMU invalidations.
> Drivers
> can define different structures for vIOMMU invalidations v.s. HWPT ones.
>=20
> Update the uAPI, kdoc, and selftest case accordingly.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

