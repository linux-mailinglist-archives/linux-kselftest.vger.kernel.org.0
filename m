Return-Path: <linux-kselftest+bounces-24782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6A8A16A66
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 11:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA51B160642
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 10:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3950D1B425D;
	Mon, 20 Jan 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2WoXqKe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8BC1B4151;
	Mon, 20 Jan 2025 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367687; cv=fail; b=KzAXSPGX74J0ouAEshMcd+6XcV7LY/jXGChwSYGlbUcWsts6xaLu/MsjLElQOwsVmiUlLZxugWKiqVNJQeME6CDezSLj55LpnQ6EfSOuF9V6Op1S3QP1RDEKSGxKd1ACFnRxxg8586yM10GQ30nvOisrbU33UtRDzIQUqmFPhRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367687; c=relaxed/simple;
	bh=uAH8Gn5SfkujWa4ohJbxuDbzsz7UJ6FqzHIoJ440zIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jvHOJoeeMUG/rfuuoSfEXXh62gXSOXPizjZXOnsttY/zlVepjsPQ3jyZSKZBLE9nLQ4tKsm9t2eTfqmmtIu8T2+uaDZPwN7ph1eA7Up6Uuco4RbopIJKDwJSdfHl5tZ0pBRIjsM/njmmufugzR1MLEEQUdZ2SfbhZ3UN6yfONIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2WoXqKe; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737367686; x=1768903686;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uAH8Gn5SfkujWa4ohJbxuDbzsz7UJ6FqzHIoJ440zIo=;
  b=V2WoXqKex6fPBbaWBibi1ovnzx66vJF13wPCyK03G5olA52j8f1d7Tr8
   h0yCmBI/zk7HlkxIljph63oN8pC2ZhYlqnLPyzxL6ZrN+ZQAADhNPvRGG
   1xpAj5eA4NcuaThd/t16UKwP7YV7BnS1K1aDC3wC6w6jfGkUY4/cc4kXn
   YGHl6/sqjw8lrxvtILgKHZqIh6Qb/sp3HalY8TPmfMXHB1jiCYm+glc1f
   H696J+zDGcznMCSZLJ7yCQTEwBmWZaVHxl5hXSGvnqK2Xl9Ukr3ppOtzz
   MlkyVmdM8qNU61s3vdNKbOZOlHp9Y3WY5OWn0DATuOxclDdmviPDS371B
   g==;
X-CSE-ConnectionGUID: PIQnLKSiQRWc0vCP7GJJ3g==
X-CSE-MsgGUID: Kx9RHvUUQ+GUF//Bw3LYgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="25347147"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="25347147"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 02:08:04 -0800
X-CSE-ConnectionGUID: rtOG/N8wS/y4mMG5rS4TtQ==
X-CSE-MsgGUID: GtGHVkuWSymlNbB+mLybMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111083674"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jan 2025 02:08:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 02:08:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 02:08:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 02:08:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmCB9lrtCQXun8e8OmHdRblfiozrpncGMLYeMuM2l97khQMdqM8QHbH5G6OLqp4rG0kEVU6nTg2KRribcHt/GAu/6OzLfxu8qNS9zTCQsSDATdr8akCBU3y/HW2snp7/rmv7k0RQXm1ckYHyyCUhc2vZeAQ29fJNBvneJKR1TTdsCJ5tNwqbk0QW3GFIWO4REODsmSQ3AlVhyaXgk/GOEKeQwMEo/qPQHbQ1Gft4KZoqy61GxSXQdcwJWhs45DrG/TxEZmXl1P7LnYmsEaz50rEriJKhVEGOLaGszVxpXW+5ECLnOsw3RKTiLqlELYJvjfwfffDqnDwoVbPSKRO27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAH8Gn5SfkujWa4ohJbxuDbzsz7UJ6FqzHIoJ440zIo=;
 b=Wkzafm1eu2sUdgxGIqFX5sK5rQ/pM1S9hOf27MlXOztlGCYor74uE+826HeqAqfpz0ZGqCFNQ8faOBWpvIUIIOgTAZt5poSWQeTo5NatAVcHZlQ6O9yJTDf8IDZDB8jDq22JPwUHe0KRn1eyzBNcssqc7oGG/NCWyPq52Yx71lUhjlXqVjSj/JK46QWfsc1PbtlKt+NFzVuA8IoiJjlYwSv3Rv+++ty6ei8zB+0H+lEqPputShwJyqdEkvJsQ2yIuQGXw7z+fRd9qtlC9Tot2pGfYA9+AhfaxcEq8H4jVYGgP4DZxIXlF91DlBj9QETYEnxheokhQXU/ty1LeBfEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by DM4PR11MB6143.namprd11.prod.outlook.com (2603:10b6:8:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 10:08:00 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%7]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 10:08:00 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>, "Abdul Rahim,
 Faizal" <faizal.abdul.rahim@linux.intel.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Willem de Bruijn <willemb@google.com>, "Bezdeka, Florian"
	<florian.bezdeka@siemens.com>, Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Damato, Joe"
	<jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>, Andrii Nakryiko <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, "Jose
 Abreu" <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: RE: [PATCH bpf-next v6 4/4] igc: Add launch time support to XDP ZC
Thread-Topic: [PATCH bpf-next v6 4/4] igc: Add launch time support to XDP ZC
Thread-Index: AQHbaC8B2aD+Y8oJSU6tHVAr+g1K37MfN+iAgAAQfQCAAC0uEA==
Date: Mon, 20 Jan 2025 10:08:00 +0000
Message-ID: <PH0PR11MB58307F652287DE2D5D67D201D8E72@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250116155350.555374-1-yoong.siang.song@intel.com>
 <20250116155350.555374-5-yoong.siang.song@intel.com>
 <84770113-2546-4035-8bd4-bf9cedcfb00f@linux.intel.com>
 <20fa0b55-405c-4b7c-8c10-1f8d71c956b9@linux.intel.com>
In-Reply-To: <20fa0b55-405c-4b7c-8c10-1f8d71c956b9@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|DM4PR11MB6143:EE_
x-ms-office365-filtering-correlation-id: 5c10d1d8-1980-46e8-feca-08dd393a5242
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?VlRrMW9sdzllaUJIMy9TcW9uTlFhNzRGR1B5TFk1Y1ArMEVrV1Yvc1hUY2tF?=
 =?utf-8?B?cHF3ekxOdnptejN2K3BuU0lTWWdNcGxkZklqM3VWbHoyWVRyQThDczhuQmxy?=
 =?utf-8?B?Y3pRcVhzNXJ5NzJCYmRCZnlSQW1GdHFpV0l1V1hQdHdlSy93Yk5paFpCQ3U0?=
 =?utf-8?B?Y3NNdUVRRnVKdjIrN3Q4R2NyUTBnUzk0SzZYRi95NE5LanZrOHJBcFRDalRX?=
 =?utf-8?B?QUtDVmVFSUxmczZMbmNQMGx4UkNjR2ZCcko3RjFuMHpwODFNa0hSakRHQ2JD?=
 =?utf-8?B?ME9ORUxzK3lWdVNQZGplVEszUUcxeE5ZaU5EcUd4QURHT1VVQ2E3Z3ptT09r?=
 =?utf-8?B?bzRDWFcwSGxJTU5QUFA4K1J2S3RoZjVOamNxZnFBN2dOSktMY3NCMnNCODdE?=
 =?utf-8?B?Nm1BbWdvUDRKZ3hnU0k4SXJYVU80eitGY0hNRDNYVjhwajVycUZxSWFtVE9B?=
 =?utf-8?B?M2w4SkhRT3I2dHJtRkxiSkRseDdlbjVnRkFFcTEyaXJvSXFmQzV6dlNoblN6?=
 =?utf-8?B?bjgvUmxMTk1XQ3pVWlc4a3NTUzVxakNmMHZMMFRLdW54Z1RZMHVGbGM0RXpU?=
 =?utf-8?B?R0ZVblkwNFl6Rkk2dytsTm1XY1FMa3ZYVy9ZWW9NZU8rWGI2cjNaWnpRbDhU?=
 =?utf-8?B?Vm1RU1A2dXVmZ3AwaXpZLzFBZFJYTSt1aDJ2M3BldkU0d1hKZkxuVi8wcHBy?=
 =?utf-8?B?UVExZUFTZm42YWJzQStOc2pEMDRqeWpxMlJHUDc1UEw1TTlWOWZhWjJBai94?=
 =?utf-8?B?NW9ZdVFsRTNjd3FROG1rU0dabEE4bHc1SWVMb3pDU1RkL3VQZ3hhOHJBOWM0?=
 =?utf-8?B?TW9PV3p4RmJMMEYrT25SYlZibXFQYlVoVjg4U0J4eGpHZExSM2RELzhtSER1?=
 =?utf-8?B?WlJONWFxTTRNVExKSzFQNmJseFBGQkVQU1EwdjJsaW1obVRjWXJ4N0s5Q1ow?=
 =?utf-8?B?MWl6ZERTS0hYaWd0SDN4eG5qdTRzeG0vZ3pTNWc4RFg2cU5taGF6SWtwcUwv?=
 =?utf-8?B?SDFyWFpzbnl6MEwxbk1IL0YvZFFkbmp5aDJoQ0ZKRDdaRjhYOUxpeFFpKzRj?=
 =?utf-8?B?cVplcUZHWU1VYkhiS0dGQk0yNGRCOUt1Kyt1cDMxWDYvbXVtZlN2eXFxL0dr?=
 =?utf-8?B?YjRTdFhZRUFFdy9QdGorMHVVTGpJMnNRaDRMOUFjYXBuRHlCVGRLaVBGQ3Jv?=
 =?utf-8?B?YnlhQ3ZKdlJvU0Y4cXZrRGdjTklEWGx6NUtBdG96cDdtRHpkZk5mK1kyaEt6?=
 =?utf-8?B?eXpVT1NaU3BTdHZnQlNCbkhNaGViOW8vZm5mWDRmZSthZy9YUWVMY0lOY0ZT?=
 =?utf-8?B?NXRJbldRT1JEYUdURWVtb2wvbllRMHl5L2poOXYyL1lBNVZkazVQNHhQSDdD?=
 =?utf-8?B?KzEvZFRVMmdkVE1PaE1YWmwvbzFlOTQ5SkxDRWpnUHdla0NoTTZ4UGhEbDk1?=
 =?utf-8?B?S0NtNVRhUEd1dW1ibnI5R056VjJQeXJ0dlE5ZU9VSnhrZ0pGSWplU3NOWXcw?=
 =?utf-8?B?MlhvKytlMFNWbmRmNlB5dU42R1YrRGtoT2RSdGIvdW8rQWV3QlJ4eGVTcnJB?=
 =?utf-8?B?UEt5ZlFGS0xCdHlLUTFTR2RpL3E2UnVSOTlrdWJGdE1POUFObWo5RmVJMyti?=
 =?utf-8?B?cmVKOTJlUVpVMFU3WWF5aXdYR0xOOG1KKzRGamVUN1dpNlViUVVLa2pRc0JD?=
 =?utf-8?B?L0NTVC9Kb21VRldvMDRVUUFnOWpyYXdycGp2WGx1ZmpHcUZjRW1lQUxWVEdi?=
 =?utf-8?B?dEZlRll3Wm5hYURRZEhJUlRWSGxHQ0pKTTEyZGxiUUk0ak5zWnM1UWVXaXpH?=
 =?utf-8?B?dXhQWXFqckE5MUpMQ1Z2S1BLNWxxdFJtT2FSRUgzL3ZNY2pzeS9ZS3ZJNVNJ?=
 =?utf-8?B?NXZJYTJOWGlPMlBzbHdIVzBHSCt0TnZyUndUT0NrOXp4eUdLckFnVGVyeWlv?=
 =?utf-8?Q?EnsRKIjIaECfERD/sR4C7GvA6I9l8Fvt?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjYwWlZDS2dEenNkWW1GL1hRSzUyd2V3SmN4QS8zNng2ZHY2c3c2R28rT3Zq?=
 =?utf-8?B?UnloeGFLaHZYZkdnY3U2NmlOL2VXVjArbXcwcHQrbFhTTVJVLzBqVkhWeGpB?=
 =?utf-8?B?ZW9qOEJJdjdIa2dLaGlNVjJpNlJBUExFV0FIdlBFdGNqNnBoNlZPWkpFL2Ro?=
 =?utf-8?B?L3hPcURUUHlBREdkekpNbXBxaHM0YUJBcnFIZTNhVmhTaElQQU1HZ0dLc0F1?=
 =?utf-8?B?cjZBNk1SMVl5SDU0bVE1R0lleW9wRFJWMitzQlA1WE5kcDhrN291WGtRVW9J?=
 =?utf-8?B?QURERFBac213aVNBVUxkcmtWRjc3VVcvekY0bzJGNS9uV0x3Y3FZUEtWanVx?=
 =?utf-8?B?VmhCb0djU3hRMGZvbVFyY0Uvc1N1WEIrR3NlLzdPVTEzdWdmTkpQK3ZwS3FN?=
 =?utf-8?B?eDVkd1ZjTlQzeFYvVFA5ZFd5eEJOYjNSc2NJY0FUQ0R5dkRoZmh0emZDUjFp?=
 =?utf-8?B?REFEbjZ3ZkhMaDNCTDR5NWw3a1JJRE1kb2M1UTQ2ZFZ6d1piTnBlSWQzTTdR?=
 =?utf-8?B?ODBDKzhMZzRrNFphMXRWYVQ4Yjhnb1FleUZtOVpveDIvV2UrUjR1RkV3dWgy?=
 =?utf-8?B?U3dsTWJ6WFJYWlZxZ2huTUhWR3J5Z1NPa0g2QlZBYnFUemZSM3ZMRWppdXRo?=
 =?utf-8?B?bEFVUWRUQmV4K3ExdFpjWFNCVnVQeFV5Si9MVXFyKytiTzAyU1ZIdGR6RDE2?=
 =?utf-8?B?S0ZVVjk5Z1NCRnpCUnlMS1hiOGc1aGZhMXhpZm5xMTFUTjA2emp0VTQ1U3FH?=
 =?utf-8?B?RlFUcWxFY1dlcSsxUFVvL09DbjU1YWIvQm4vRXV0VGZtcTUzbno5Tmg5UXpx?=
 =?utf-8?B?MGl0dm5qeE00UDdUVTFEOHNNVHRWNSsxaWM1M0ozT1piYmY1OFZrR1NaYlNm?=
 =?utf-8?B?SWdHbEVtdGh2NnVwOWJweVFNdWorc29WT1V0WHVNMzVGUzJNZnhmOE9PTHJ4?=
 =?utf-8?B?RTRSSEUrTndEZjMxTzIyNXRmNDNaVUhPaVQzQ3RuSWZSN0FXdVNRZDB2c1Zk?=
 =?utf-8?B?bjFHbmRyZHdwUVVLV3VvUUkwck1FVGJINnFlYkZWY1FkTWtkdzZGUVRLY05k?=
 =?utf-8?B?MU9Vb0E1SFFRR05DRDlyZm5uT29oNEJkSSs1R0FWdnphT3MwYjA3MjVLZ3gx?=
 =?utf-8?B?TGhLS1NWb2JkQjJ3NUx3L2tKTWM4VFJNd0tMd0M1b1BCdnFyU2hRbTRGMWdv?=
 =?utf-8?B?MHZVNkpIY3FrcXY1ekc2MCtOTEhCMGtnSVM4MTRWbWJIRmtEb0tOcTkvQzIz?=
 =?utf-8?B?V0cveUw1dVBNazdkZjU4b25raDRnWlhZSFVRdmJKUnpqRFFyTmhKdDAreFJm?=
 =?utf-8?B?RUEzT21kczdqdUdDUStrZE1WYkxRT2RFTlZHMmJwdVo5OGNRVTNqaDFZK1Az?=
 =?utf-8?B?SHhRVjEzVzF5allpeDFPRTZGUm9IaGtOaFc1eEpNa2pLS3hmMFNldkUrY29a?=
 =?utf-8?B?QXJMTEVkcVJveTVETm5OMGsyTXVxMmo5c2ZLRXkwT0FkR3JQVlYzaEFIalBJ?=
 =?utf-8?B?Z1Q3akxabjYydE9Dc01WWTUzNThjaEFFcDJPNDNYTkdLWWlaL2Z3OS9wNmts?=
 =?utf-8?B?dWhFb1NlaGNvRkhsODhMRTJydVZYRzZzWFhUbUFsRmFCeGRYdWpxaVVyYVJW?=
 =?utf-8?B?VDVNSThTckcvTGJUSDh2b05vbnF6M2FZbVB0b1dOK3ZrZkhOQU96d1F2Tk1K?=
 =?utf-8?B?dGZZTmdLSkM5ckZCOEtxdXJIVVFzN0xVaW5Ud1dLTXpMbG9Ua3VPSGQvc2ZU?=
 =?utf-8?B?SGhXRThxcmlsY1ViblhIcVZJWG43MHgwZHliTlc1by9BMVlVbDRtSjlBM3Y4?=
 =?utf-8?B?Vnc1cVBKaUo4R0d6QmkvR1h2ZUZjc2J1bDhicEs0Qmg0cDBjUlV2Yk5CVFpl?=
 =?utf-8?B?TzAvS25Dc20xM0huVW9VNE9NTWhRQm5tdjNycFp0R2FFWHlxbVNHNDlrRDFn?=
 =?utf-8?B?MzV1eTB3dHQ4cUxvWjV3OWNFNTNmYlZZVW03WG1lVjJFTDVXWUR3MmlsU0V5?=
 =?utf-8?B?TFNHRVl2YXFRdFFSSGlUVEt4TTVrVktibkdxUWhjWWhUWDJGME9mVlM3akpB?=
 =?utf-8?B?YUdaVStoenpWMzNmb01wbDhuTE9Dd3RRZTY3cXV6d1MzT0Ftc3hEQ3NoQmNy?=
 =?utf-8?Q?AzYlE4EKdx5n9T8aBEENjlDdt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c10d1d8-1980-46e8-feca-08dd393a5242
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 10:08:00.7148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFglfmu+dqv6mwBOqQvTOUYLwXOgQ+3mDf5jNts6e9N6nbspn7Ag7g+ElwhcV+ykOMY6b//vjAmzGs0qnlsUu8S7IHOR1z0gQeuMgp+YS/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6143
X-OriginatorOrg: intel.com

T24gTW9uZGF5LCBKYW51YXJ5IDIwLCAyMDI1IDM6MjUgUE0sIENob29uZyBZb25nIExpYW5nIDx5
b25nLmxpYW5nLmNob29uZ0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPk9uIDIwLzEvMjAyNSAy
OjI1IHBtLCBBYmR1bCBSYWhpbSwgRmFpemFsIHdyb3RlOg0KPj4NCj4+IFRvIGJlIGNhdXRpb3Vz
LCBjb3VsZCB3ZSBwZXJmb3JtIGEgc3RyZXNzIHRlc3QgYnkgc2VuZGluZyBhIGhpZ2hlciBudW1i
ZXINCj4+IG9mIHBhY2tldHMgd2l0aCBsYXVuY2ggdGltZT8gRm9yIGV4YW1wbGUsIHdlIGNvdWxk
IHNlbmQgMjAwIHBhY2tldHMsIGVhY2gNCj4+IGNvbmZpZ3VyZWQgd2l0aCBhIGxhdW5jaCB0aW1l
LCBhbmQgdmVyaWZ5IHRoYXQgdGhlIGRyaXZlciBjb250aW51ZXMgdG8NCj4+IGZ1bmN0aW9uIGNv
cnJlY3RseSBhZnRlcndhcmQuDQo+Pg0KPkkgYWdyZWUgb24gdGhpcyBwb2ludC4gQ291bGQgeW91
IHBlcmZvcm0gdGhlIHNhbWUgc3RyZXNzIHRlc3Qgb24gdGhlIFNUTU1BQw0KPmRyaXZlciBhcyB3
ZWxsPw0KDQpIaSBZb25nIExpYW5nLA0KDQpTdXJlLiBJIHdpbGwgcGVyZm9ybSB0aGUgc2FtZSB0
ZXN0cyBvbiBzdG1tYWMgYW5kIHNoYXJlIHRoZSByZXN1bHRzLg0KDQpUaGFua3MgJiBSZWdhcmRz
DQpTaWFuZw0K

