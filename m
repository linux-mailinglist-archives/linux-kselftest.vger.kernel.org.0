Return-Path: <linux-kselftest+bounces-20907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1559B4428
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6391C20DF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0F8204001;
	Tue, 29 Oct 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVGo38IU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708AE2038D2;
	Tue, 29 Oct 2024 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190345; cv=fail; b=odKKKclXE0Xl586FyWusI/yqWjCAzhyZhwGfCzThOMTsdrHrX2HapIsw6swosO8yTWlTixUwICJSe1ryPndID2a1N1lsMBywXzfm7wRCVelTMmuBV40jWB1p7UQLXGOd1X/6APQEi2vMeqbrxSpwXokA9pg7EwXjpCqqlp7b91A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190345; c=relaxed/simple;
	bh=nsGcCw6sWSV4H2z3/9E8dYuSKeRGFAKvM/iyyu7v3D0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oKEddp9rs80jttyt4lz+Efi45H9FX2M9p0IiXBXBxOlcOUUo+iO2N5LgArCYnFGsIQETxVqFYuRc5Ax+XboCvAn8EzrFpgOYTQ4I8q+Mzn67bzAzHmy6C13COXvozwoln4vKeQYir56KMm8+Lln6VhmjWbkoKKFMDk2KqmEpmMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVGo38IU; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730190344; x=1761726344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nsGcCw6sWSV4H2z3/9E8dYuSKeRGFAKvM/iyyu7v3D0=;
  b=FVGo38IU+WP0E99YWoSZkth8QFmwnZVAXnyc09jq4Wb71nixGBPNRyoW
   x4riAFMCBq8Y6PZcQ0+HG9VMyIZgFmvi9RLbKLWaFbJljBKwTGYc0t323
   OOiKUTJx9oCYYO5f6LHHKmcw9PmTxCpU1h0c+XJRygLTgsSf2m0fxmSS3
   ng/kpsrrZH4cq0x7ENLQggoxyxzufqQuuFJaon5td6cJQIJxB2zT2OjYk
   okjataK6599/+RSgwkBRZTRZJ1Ooz0/5iIsvlFJjQ8Zu5dJwrIr3ZT2lG
   U4clRs2kdACnzzWb/fovSuz5Bn47dqGHSCpvuAx61YciFnHrygp/ykH/t
   w==;
X-CSE-ConnectionGUID: maFuVNJ1RIKRq0LCxw/GaQ==
X-CSE-MsgGUID: CYRG+8BpQmGi41ThwUDsCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33515133"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33515133"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:25:43 -0700
X-CSE-ConnectionGUID: BZW2JyjtQXuReCjx9fkopw==
X-CSE-MsgGUID: llUJRsmiSKici5r8wrYT+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86494183"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 01:25:43 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 01:25:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 01:25:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 01:25:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ej5Lb8A4RRuOv82RPcCIYmMUWbAe9AANSwPAva5pDZSiLice8zZQwCfFca2WPNerntuncVYapNzo+VCAiizsKOV5X4E6KQ4w2W4QmAmB+D/YQbCealzm+0u6ZsiO5wuU+2RRe5V9hLCzvnQF6C7d/YwR4wpo/dYNb4Cb+b2RaoAexwWrZbKlhMLUqaNFBNUwuxziG1NOLh2FZQCNXybfBc8wop9l7t2VfnH0Xsp82gebD/JtPaXrcGh9torCpni398J89ViIjUL3yk/W4RDx3F/AgdydAFnV9OQrc1x4//YD5JNTid7lV2nt2+gYoaaxBWvNM3GgHt0TT1uZkzAyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsGcCw6sWSV4H2z3/9E8dYuSKeRGFAKvM/iyyu7v3D0=;
 b=LJmQQYDDUciM1TfZmBb22M4gKJvVYvcan3+EOCF3HfQR+5UzqFn/ZAj2L+1VFFzlSFu3JxT7B+HOPBEtjCSN2szI1hgi6l3iCdYIjkPBNARKOxTZTA85OMo/6QVgHn9XiX6+etSqZgkf02dN6YdP9fo5h//CcSiXM+2cwoknjAyi5XiEmZHKwid/LM5EgRuJybjip6Hj0FzT4+pP6T72JLIDs//vrzLOOgcBgKnUexFh6yov87oqGO4UWsOD+8Jh7o54yHkW+DxWN/pvwa3uAmsRhw+CoPw7HfoyJK8ClJsZ5Q4LSk8VRXUwolfCqXZRO8PssOjSTPNLUY1zjlr6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5133.namprd11.prod.outlook.com (2603:10b6:a03:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 08:25:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 08:25:39 +0000
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
Subject: RE: [PATCH v5 08/13] iommufd/selftest: Add
 mock_viommu_cache_invalidate
Thread-Topic: [PATCH v5 08/13] iommufd/selftest: Add
 mock_viommu_cache_invalidate
Thread-Index: AQHbJzjOMxTEueDmjESsr91O+xzkiLKdab+Q
Date: Tue, 29 Oct 2024 08:25:39 +0000
Message-ID: <BN9PR11MB5276362C5E38A346125C70FA8C4B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <6ecee6aff136af1a1b8c13adb0210a74c1974ee7.1729897278.git.nicolinc@nvidia.com>
In-Reply-To: <6ecee6aff136af1a1b8c13adb0210a74c1974ee7.1729897278.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5133:EE_
x-ms-office365-filtering-correlation-id: 70f3bf88-b5e4-4e94-a263-08dcf7f34585
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TF4Ie/lHweLc8G+Xk30UFTaZfVdn1SdkceJkQfYjScXL9Zx0YUUFfVIZ2p1l?=
 =?us-ascii?Q?thX/CWbTSTWgPOr8rO9b0LMR68xUOc2+HyqIoDoLK/15SbOohhz3yz5lXPqF?=
 =?us-ascii?Q?fYBZSiGqBcGMpp+42JlVVD5Er64klR9ZhL4NaeXx8Z5aX9RfmnHY/QXcSaF6?=
 =?us-ascii?Q?sxEkvY312D8gtt29qPJMNUHYuW6sVQm+8gYRwgktzI9YEtdEHNJsyYfdL5jp?=
 =?us-ascii?Q?CaDV2jKtsGo0aW1U/KxfgE0IHH+L0Xc06kkCEs+fWo6AHCZhbE+zo6JA0Cg9?=
 =?us-ascii?Q?tHm4dQ1X0zVmtXca/xpRqCLbrLdWtMdMbzDTV4C/R6txypgtYcu0A+KNWh3m?=
 =?us-ascii?Q?VMp92LSrlpG7aSb9qJ+5aXQRxJautlX17BLd+NJzDyH21/eLOO7SgxPdbb9J?=
 =?us-ascii?Q?LWV6vT1pFzHNCE5sh6eiGOnZzo0VsrzcbuY5smkH2WFrSIjwsC5xS3IOujt/?=
 =?us-ascii?Q?m0T3yFBfRtX+2w4pGM+LQmHQicN4jbi6XOR5SurZ9wh1VBKIUOh7jBs0SIG+?=
 =?us-ascii?Q?RDEqHfKk14Wxyosob+yBWVCZnHfcjty1LHgWlR/bbYGd4ppLbRBiHAYf9nn/?=
 =?us-ascii?Q?gLudgLWNkCsjLic7JjsYNTpFYVed+YUVvzeRBJJZ3TajBBW+7Ch4A1QkiycH?=
 =?us-ascii?Q?G2pnFklQlJwUy6U6k1TAmUo0YLWxL9r2MsTvlpVFhSxPVPN2YcRvsB4VF7sJ?=
 =?us-ascii?Q?e9IQQXW/LWjh5aW6dfsLR+N7IxrqN29kiCp0cFWbK8mFmEXbwa6d/WF7F10L?=
 =?us-ascii?Q?DfE5+PK0P4I3P7OO0FxexY1nrUanIT7fbGpX+9QLZHo0sAJ9cDBtRHTb4ei9?=
 =?us-ascii?Q?Vx+1V4TE7LjFdCkegDwZJrYq2Izqwp/loVKx8O0DSkiM06/rO7TSfA7Wd+7n?=
 =?us-ascii?Q?pU+pFWtjulb6G3SylAOouUE74qW0/otEHbuFQpxjrIgI6KPorQur98K30TYS?=
 =?us-ascii?Q?Q4WLVS8vhFyVSqQhB1akoN8zSK+FqaaSTNzEVFP7vaUUIjox81evYtYUyPZk?=
 =?us-ascii?Q?0eLgH5uFK33HmfcjVN322v0pLB+OwX/q7EmvTm0j6YN+MB1PpRS5Own4q4QG?=
 =?us-ascii?Q?6oCmaURqQHgGA4ey59xnfFjpMXqTNgnXjVnUIkSNvMV921NJ9U78Z/oOZ0De?=
 =?us-ascii?Q?arpkaoKMWbCmRSP6AH9GyjqUDNHtzt59WHus4lYLgUcuoZ791FCkvWQBrrHr?=
 =?us-ascii?Q?mywo8033tnmFXw8VrWuCQuB2xk2v7O7GQP8ybPIXbDLoIWmHc4mVNbk4pYuQ?=
 =?us-ascii?Q?Ev8GkFTdnzDLFX4K5yKs2W3psUyKyXoy5LA1NwIAgWx5k3fSvaq5H6AoJcM+?=
 =?us-ascii?Q?S79RYaxZu36cWqUntXBkp593sK2hReNsfL6ioFMRNAMN6G/+k7Rgtep2D0aL?=
 =?us-ascii?Q?QVOr9Q0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p34Phk5VVA6LbjUpVz3Ffr3pvID9hO7oImBTHkMOzC7jO+O/UaQh3q2ybkoK?=
 =?us-ascii?Q?VtVK3lDQRxzK0D9K7riI9VKoGxiFBaw/4AVNIxM3a9uO9p8arbeJ0nWgmvcj?=
 =?us-ascii?Q?/vIwr2J909EKmar6TMIb5qm17k13OAtGLfFlGlGx6AVGk5A4KvQd/rmvHMq3?=
 =?us-ascii?Q?KFEeOORdJl5fw2dEedQxJsnnGZjVUH4J9ywb3z9jkwgy0Iobs7lkN1lqZ8Hp?=
 =?us-ascii?Q?NOcLmWd44WbMQ1CacdZod+wBZAliKt6M0qQfbJ0PtMpHeITqmQqt8Jilx1yt?=
 =?us-ascii?Q?sp4Wzpjb+5G2u4dqtt9+esDoN5iww61BZ6eo3XY3VQAXsWop3e6e+485QHJF?=
 =?us-ascii?Q?LblwxTVg+qsz6FmRUA/W/G1Q7uH76ZE/exphHxL6PVWzyUkZ+yDCJyMlnd5g?=
 =?us-ascii?Q?6MtOWUdCBLgc+3Ws8yzqjJPy90BJ9vPRYj3AzXObdImCWtkYq0GWBzDy+krh?=
 =?us-ascii?Q?eqerY2Sx9ujFhgGV50aUanbAnxrlYcxwApTl00W/k8IdUJ2xroA6yKC9VjyX?=
 =?us-ascii?Q?zks3F8jecI5nS0OiHl0AyQMqE0rHSmL0zX74IhBO0CbtjHfBpXGWpR+OYtCH?=
 =?us-ascii?Q?XYM5auWFLlzHXKfuzThjpiOT0bGTvERcSPxNqBWRhJldxFXiGfUL6WchTLJw?=
 =?us-ascii?Q?RA3w5DkTlDhFuTsjzZ36pHC+f3z/EWHWXvNerZzJz9PYqA82swRNZk3dG3P6?=
 =?us-ascii?Q?hb6FOvwi4xWnMo5L5xnvHJCvmQcCYfanaSsxmvGarRtKtZ9LyaBctx49uCSD?=
 =?us-ascii?Q?1KTuErzKE5rd+Dzx5fpwgImujCq1gpiWDca1tQIhYJzoJXOUWQkU4yzWuCzy?=
 =?us-ascii?Q?eJSnSusSSQ7iYGTiif2iUry2LPjXJ9EMvudhbQAZcMe9RWxFCLXQ8T7uxJ4v?=
 =?us-ascii?Q?nnNg2ttWCpF7S2wo6XHpZ9t3q3bnAhRVCq/Y4hWMcJkp8i2ShMJzamEM6c2B?=
 =?us-ascii?Q?pEZrBw5jDvasV8SpY2/W+yVnQWc2SegN6qm0ipjMSnvA+SmQXScXYGBscCXP?=
 =?us-ascii?Q?JAZlEZdJYq7aeR61AvTJnKFsDlPcFZuhmhD3RudFmsDSyBheXq1k5P+nwgvN?=
 =?us-ascii?Q?bMXA7jwAWk/0eHosL8+acJHZNynlVGakcAmqU5OdqGoK5KBjtM/dUoS6urLe?=
 =?us-ascii?Q?SE63jszlZ0f29yEwc84YYvK6getuOWXEYgniucuM1jillldeheUUVyXTTpBa?=
 =?us-ascii?Q?lueXE1hqa7A0VMUR2RrquX8t18hPLQGoHzEWjru+WSzTWjOppHRvcTwhP9Xz?=
 =?us-ascii?Q?jNS8aF55pynhXuAysCSu5V+yUtqdNRHSOjRpWs6Ycr11KHKd1fLMgcR4xiWZ?=
 =?us-ascii?Q?DyK0DVd+RzdTBojrZpu+eTmfwJ1hymLXIWMPf/O8fcHnoq97w2WS07cvuIyH?=
 =?us-ascii?Q?YUXfoXpjiKos/uvSrZVo9JCOe2vGk4qE8QUNJywahKU9NkwGOQFRBJvlGxk9?=
 =?us-ascii?Q?BPlhYrhE0HYj9HCbW0qmXJ4bvhiMxj0bW91Ed6OTzJk2np3MiOYzpOOhOsdw?=
 =?us-ascii?Q?HXyLLmuL/cXVPq94GKAkJLjXRgzpIptQucVNqGuIs/g1bQGuerWsVq7mPPu0?=
 =?us-ascii?Q?xKIcTv/DqRM9dj5LozuVMdLI6p6o9qcjZXboygme?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f3bf88-b5e4-4e94-a263-08dcf7f34585
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:25:39.5127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fc5CKTxgcU7bA2OhLS+PobCxEU/5ExS+GjZfLII3/iLcI0NiW5G+7tQElpThU5PPKn1Z4/eFTGsYpZ4o4zYASA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5133
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 26, 2024 7:51 AM
>=20
> Similar to the coverage of cache_invalidate_user for iotlb invalidation,
> add a device cache and a viommu_cache_invalidate function to test it out.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

