Return-Path: <linux-kselftest+bounces-14786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4651D947358
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 04:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E332B20CC2
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 02:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1B049650;
	Mon,  5 Aug 2024 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/eISF9I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E96C812;
	Mon,  5 Aug 2024 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722824688; cv=fail; b=cjogEzetCxONMaKOeZL1khcHV5JB6odAq6otcwcDMoXWE95RO24481FfpZwYRa212/h4nMVFsSgnDEUUilZ2BMhUY7lpO3qttGWHa3MwwVnN/3lSlhYdMkVeC6J73jJIk+i6wk1zOXEgwQRBcoA1Hq8HrZaxNi5ibei6dAeQU/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722824688; c=relaxed/simple;
	bh=tQAGNc8rtu969+9tu7VKBtgGX+Hsdcy6BLSPto5m0XM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lpcn1T8h8oRC7dfIXIKEaN5FyYyKHDWmGgNpkbTSxqb2xV+zw8CZiA2ZTku9itTiT540BwtUr9w451dwusI0nV8wG5u6KD20Jl9hXMSPllHSRCzDMHqb3dYw0vk1/yQhK1Ng5Ol6KKvkHxgiiatocmVyL0f2TcjDvug7f2Hkg8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/eISF9I; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722824687; x=1754360687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tQAGNc8rtu969+9tu7VKBtgGX+Hsdcy6BLSPto5m0XM=;
  b=i/eISF9I+YvRAvQBE8SOdjk3DN7P+oDYAOQuHWm2pI3AExOn6xSxdJ9I
   Ygr4AGcVMOlreODP+BLH1Y5ljat9Bv34oWy6ihmbjYymRO7L3geY513Fu
   OcMehhYtaase44EnG8DceQHjHcVVJUw98+dgG0e4KWfH9eMqO3N0hQEvj
   UmBvrsFL1swNzZVmsiGCgUDw917vpPxctbn46BVp7gXYXO3o2bHvUcSlO
   iO0XqBcmkTzuU6V0rTuKn6LgL/DYWAH/t7oy4xqm6aALB6sprJ8iP8MnZ
   HJ8qZafMJyJj/0izdR22Tv3CjZJI1/ZFENl6e6c7CPdIAGM267u25Risq
   w==;
X-CSE-ConnectionGUID: x7hguafZRsa1DKQxgEbbOw==
X-CSE-MsgGUID: vxbPMexYQVSLMJ/kLCkWsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="23681679"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="23681679"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 19:24:46 -0700
X-CSE-ConnectionGUID: UiNuAGdHS4mFag6MkQ6CdQ==
X-CSE-MsgGUID: wEwLojrfQpuwmdkGpNd7cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="55668033"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Aug 2024 19:24:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 4 Aug 2024 19:24:45 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 4 Aug 2024 19:24:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 4 Aug 2024 19:24:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 4 Aug 2024 19:24:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YelCPM8ZHYG7SbVTMxfvixo/JqTOWTl7TxtB7vSh+Bt4x0P1oXoqQHWUZQ86DNHgM5FEvca9X3LNQMSK8pYbtMLyigDZyYjzQ+micvKMC+EPRcbOsaG3MUa07QThMzKU599CxfeusqP6Ydigqdpn531ooEQDP5QjYnH26yblh98/jMRah4ZuIoOOfB0GvBw2OdOlq3agIiQHrgbasL42jtgAIUNlwwgwDoW5pnopj4W6GHS4u59DDOd5YMZRZgV56CaXrgL4XvICsTaNacm9oeJlLVo88okxKBwQ/cBtAGS2lm0IOj8X8NEASXQfRR1tM95hdsxUuWHBK5BKmEEqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJWk6Laa9kfSfXGlHNIjurc/YSMf0dIkj9n+y3aTHtI=;
 b=zUiKrHi2QRMNfQ4mdLo9L/V3Hggw4iCa1UHUqw3EplQp3hCbPJrCYTlieuRMA2K7foEBhMBdMaJDTWfQDq/K9wh2rNzZNeZLtyHXeHQcc0UFoETQS0cPAC7i436Isq6Vux64K9KRtnafHEvecoPeEiToGXAEVtv34phQshNOcbh53CFrObAfbV4t8JUMWJZouwi+ms9DGJVRpOlwzUlQGn4fT+VPB59a7v9dk1QaV9+taHOzeEmTWou2rgJrrSbyWsF2DzTKxPi5PUOtcj0vLQAn0XUlmOSvFgXR0RR7eceewlvAQHesF610XxRfwyr2BP5eKy4gT9Xyei7zZ99t/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 02:24:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 02:24:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: David Hildenbrand <david@redhat.com>, Mostafa Saleh <smostafa@google.com>,
	John Hubbard <jhubbard@nvidia.com>, Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, "maz@kernel.org" <maz@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Fuad Tabba <tabba@google.com>,
	"Xu, Yilun" <yilun.xu@intel.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
Subject: RE: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Thread-Topic: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Thread-Index: AQHawdyTbbj3CTyCxU2oU4wQ5oQq6rHOYY8AgABR7QCAAe6NAIAAEoqAgAAFggCAQyU6EIAAOWCAgAQfayA=
Date: Mon, 5 Aug 2024 02:24:42 +0000
Message-ID: <BN9PR11MB52763711D023C0A50171C2EB8CBE2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <ZnQpslcah7dcSS8z@google.com>
 <1ab73f42-9397-4fc7-8e62-2627b945f729@redhat.com>
 <20240620143406.GJ2494510@nvidia.com>
 <BN9PR11MB5276D7FAC258CFC02F75D0648CB32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240802112205.GA478300@nvidia.com>
In-Reply-To: <20240802112205.GA478300@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB7691:EE_
x-ms-office365-filtering-correlation-id: ff051e5f-90b2-45a2-dc16-08dcb4f5c3c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?uRoXZkb56CxIHnEem2KxN2DJR8Px2ZkREs9V57whFSC973Ijqp7ILBSGauf2?=
 =?us-ascii?Q?MFlWQN3M45PLXfXY17WEMVbzp1mrf7ojlSCJZOOPK/zrd/i8mgE1RpDgJquM?=
 =?us-ascii?Q?O1nx6fjZWFDLVPS903Y9bW4azAxm6Ek+wNKwX03Es7RR+/O/Fz1QmxuqD3Ia?=
 =?us-ascii?Q?Koe2ZM0Kob0MKLrUoAl5tssYfd4Q0Tlt5omxdMVdVqXfDipmz43l12/gLu07?=
 =?us-ascii?Q?+aRAtxDKtTKpeq6Nik4T38zqQ+ElZCMeIqulcI2XJv9lGZrGth8vmDitjAsY?=
 =?us-ascii?Q?iZjesSoR3la5zTvUGTDc5iKI3uxtnW02uwUNtZBIHVu9dJiV9GLWjCZ6YH0E?=
 =?us-ascii?Q?XDivfLFrbTrYGEM1GbXi8o2V2mCIa2dND8y+x4HTDDuw2hPoGRxEod59+le+?=
 =?us-ascii?Q?Xfd8VjEeYcXC1cfxAcfBaVSsbn8YjqDoIwcu9TREtowl+SnKLiuDKMc/fWVG?=
 =?us-ascii?Q?V1bV0IEUy02FnXOMOF/OgTkrI6NW+qDtQqvps3RQ6hVRytO5Lk5FLPQDb/+s?=
 =?us-ascii?Q?TvyThepmrv9RDa6BIPDiTtLQSSrfC4ZWY6Sp0Pkln7H9eGo3gFHo9iut5gqV?=
 =?us-ascii?Q?8ANlpAYGptXZ5NTyu4C5qJ0UZlwxtYSsKzGytub2HG4lc7RPFxsk86n5zXsc?=
 =?us-ascii?Q?lkb9xGIuDjwWWsuhopRcXFRvzCQccDwrfD1uozFEdEfrzhO9ZorBoeNNHRYY?=
 =?us-ascii?Q?U4PctclbtFvg+riH6RG97lxRZ8UrlAypr044Hgdj4drSJBwHDS9x8Q+1+Lbp?=
 =?us-ascii?Q?mIHV62tDAkLhdNhIzm2VecepdCrisi0VSIH57AUEG+H5cHf9l/3CsfH0TQaI?=
 =?us-ascii?Q?4oCLS4sXMQiWFEy9LsaKp1QlwkiHFOyFbXsuTaFoA7JPbo/mlmbuHqH1okzn?=
 =?us-ascii?Q?NaU60G/4V1PFsPFk5DdyXfzLxzyvJljOeboMiHfMVa60HMmCCO6LWhorwuXa?=
 =?us-ascii?Q?Z4p8IQIgLtNFZk7W9DySP1Nt1wzii2PC0AZomBZYlbUXdJDUk+mONrfzoR1/?=
 =?us-ascii?Q?4swDUABATteoaIQhDUzcYhNGScvAOnkBUpGtFC0KHOvDEnbDT2quRizCQ5uC?=
 =?us-ascii?Q?4vJFxEwiI7HcalFO5A4CXikVHOryd/6Y4oDrV5iiaUO6I2QQRhjUHkLpQJlj?=
 =?us-ascii?Q?4uE90nrjlwSvGwugkkUUFCaPzFKilQhc/5rkPWw+E74W44Kw8p2kb3UqBEwp?=
 =?us-ascii?Q?lY4K04we3HAWIgAxH/B3Tk/WHWbp9ugyNUQb0VNxVr03Hpy3OO0ttuErLlle?=
 =?us-ascii?Q?ul9eyxbbJ1NCSLhHbosdYkVoyqKB0eKB7ip3BCVz32nGDesjXQ+aQpy+6Wdn?=
 =?us-ascii?Q?Nnl7viEqzKMESCGZrI67+yb/pZEiNS8FwTeUTxdB9y41ACH3Nvgb/1uVgwUg?=
 =?us-ascii?Q?gs6MspA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TUqRvPe6Jtpvq04A24tl4gqvefanyXfWYi9MW43YDDydJZ/ipe4TlCFgalhB?=
 =?us-ascii?Q?SbD/H1DQDtOKlFA8oXXj1eaeyFHme7gbH4i9zM28jM9IBiP56U+6ZXxj5/xS?=
 =?us-ascii?Q?cdbIJzQw+azvuDI1btqZ31x/oeld1hTKKQbFDz6G2TflUSZvK5wo5kmQ1X0q?=
 =?us-ascii?Q?z+ZLs/lkXgBU2z7XGUXdcI6Mn8sgQ7O2MSf/NVJ5z7Xvgmq/Fr0YSMOwMhcN?=
 =?us-ascii?Q?QcFEs3hMwh+rik342Ee8l+WjyaTGG9XsHvhxSXDLoFTKT4qLR0ts49OEtrJY?=
 =?us-ascii?Q?OEcRIE82u5ru2m3mWrjay5vzGYV5VPWTBKZElezRMy1pgejbEavkaARb//3a?=
 =?us-ascii?Q?F1MQyIMdtfg2L4ApL5HkNtDMMHxzjtR1eqWoOcN0zpqP6Lsi0qtfG+Cao1fs?=
 =?us-ascii?Q?PQV44Su2fc05n8fx22Srvur4vuO7/81NpWBM3JrlmXp3RJOs98O5NF4HqURZ?=
 =?us-ascii?Q?ivTFUYJVgTFQd6Ej40HCB8hGhe1cq9G08oU2lK0uzctgYLdH4F9mig0/ioXp?=
 =?us-ascii?Q?UexOG1nLYs37PtwmbHnsCKuch8icOi7twp545C7KFPMHPVftx1gcJIR2+ZVw?=
 =?us-ascii?Q?hsl6n44bnGma0QduoZ51njs/cwWRBLqr05A0IDSTZHG/XmeItT4KFpUKvHdx?=
 =?us-ascii?Q?XM6HEkFprUVFq0JVr5Je8dOxigyVtnLezW+sC8TtHXMybVPZ+ymY37t8WAML?=
 =?us-ascii?Q?eoabtzceXuyLfHvkhpTWIdj+2KcKSyD/kLTyPrLcIIfLud0By4QemwQGX77v?=
 =?us-ascii?Q?HCp3xqWBbPiEFDWYOl+cMSlT2UmyzFz+sP3MMObyIo6U/iw5SVdOk2WcxXxe?=
 =?us-ascii?Q?xxXVy3o2WCEWTJ1Pxe1zJO0mh+HcmuXYroqEnSLbBvdI7qpdKPMfv7NQyQtI?=
 =?us-ascii?Q?wDSp0PrQ3SH/nWY714Q0I+LsyE4OzGsH6rgd7Q6rut/oxRn9hrFjtzI14UAh?=
 =?us-ascii?Q?Kg+lT91n3pgCtJa4gajdC8y1hb+HTtAhPOa9tQtKGElbtlD+tBY9YUdN3jC3?=
 =?us-ascii?Q?1WjDNtnugmnwQuio5zq+oVXYGsxlOVmxTeAFE7C1Dha8IkfTt/lUbNmlzTWo?=
 =?us-ascii?Q?KspmmZU6bJRFKV/deQyM0sC/XQWt9nZHpiQx8+Mc49aJ78rDJltJXKPTu8O4?=
 =?us-ascii?Q?a421a+6sRPzQm6cjGbhPWvnvb42wuzyOF1WOOaAKRLJe9UKJ8Py+DFyhYfQJ?=
 =?us-ascii?Q?MKTQlFcAihVyApDqsZCNuhXyTRsOTujDkKkGxp2Mt2yryhzW17HAaNAvYK1L?=
 =?us-ascii?Q?hEnGTGawkpMjNCofynfCd2KNWvDu49nNjRedz/LlaDzyq4N8rVlpAIE5os3c?=
 =?us-ascii?Q?mQ6Dv64MWeRvjRaiY+a4uSeaoUZxHlG6/rAui3bdZM0Nu+v5ClBs3dxyTEQs?=
 =?us-ascii?Q?9bcQF3bS+kDJu8orM6J4+6ST/hXgHbBgEnbYKFXq5oK+VoEXl4nERgoBMiQM?=
 =?us-ascii?Q?jQj5y6vZjp2F2rID+F2fZvuBLb9sP7HwX06lZnKCm3eDP17XYVMffaNvP0/q?=
 =?us-ascii?Q?MM6E+97ITn6Agycgu1CLighSI5wlx7ssrvKLCHVqnDM9x/pIo7YdPS99CQFS?=
 =?us-ascii?Q?Qfzs40016Q9TFZ4gyIPZcxNRAef/1EEWnOyJXYAw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff051e5f-90b2-45a2-dc16-08dcb4f5c3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 02:24:42.3909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3j50oFSVDZ6CUDCH796J1AALKIR5Ui0WyeWiSwAs3ALUNmQQjZpRyWp7v9dBOWceaq9DQztQQBRnLBJ1vqhowA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, August 2, 2024 7:22 PM
>=20
> On Fri, Aug 02, 2024 at 08:26:48AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, June 20, 2024 10:34 PM
> > >
> > > On Thu, Jun 20, 2024 at 04:14:23PM +0200, David Hildenbrand wrote:
> > >
> > > > 1) How would the device be able to grab/access "private memory", if
> not
> > > >    via the user page tables?
> > >
> > > The approaches I'm aware of require the secure world to own the
> IOMMU
> > > and generate the IOMMU page tables. So we will not use a GUP approach
> > > with VFIO today as the kernel will not have any reason to generate a
> > > page table in the first place. Instead we will say "this PCI device
> > > translates through the secure world" and walk away.
> > >
> > > The page table population would have to be done through the KVM path.
> >
> > Sorry for noting this discussion late. Dave pointed it to me in a relat=
ed
> > thread [1].
> >
> > I had an impression that above approach fits some trusted IO arch (e.g.
> > TDX Connect which has a special secure I/O page table format and
> > requires sharing it between IOMMU/KVM) but not all.
> >
> > e.g. SEV-TIO spec [2] (page 8) describes to have the IOMMU walk the
> > existing I/O page tables to get HPA and then verify it through a new
> > permission table (RMP) for access control.
>=20
> It is not possible, you cannot have the unsecure world control the
> IOMMU translation and expect a secure guest.
>=20
> The unsecure world can attack the guest by scrambling the mappings of
> its private pages. A RMP does not protect against this.
>=20
> This is why the secure world controls the CPU's GPA translation
> exclusively, same reasoning for iommu.
>=20

According to [3],

"
  With SNP, when pages are marked as guest-owned in the RMP table,
  they are assigned to a specific guest/ASID, as well as a specific GFN
  with in the guest. Any attempts to map it in the RMP table to a different
  guest/ASID, or a different GFN within a guest/ASID, will result in an RMP
  nested page fault.
"

With that measure in place my impression is that even the CPU's GPA
translation can be controlled by the unsecure world in SEV-SNP.

[3] https://lore.kernel.org/all/20240501085210.2213060-1-michael.roth@amd.c=
om/

