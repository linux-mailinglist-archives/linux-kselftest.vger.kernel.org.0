Return-Path: <linux-kselftest+bounces-26829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C377CA3927D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 06:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D1A188EDA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 05:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9931B0F18;
	Tue, 18 Feb 2025 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gH1qTC14"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A11B0424;
	Tue, 18 Feb 2025 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739855746; cv=fail; b=adu1zbrtcw6/B3GgXK4Q+oL8VQ8lf9P0F0GkxI3AHU9Vpad3DLdD7J2zLCZEE0zglsfpTfpgjDo6QSOifpTuX3Qz/4w7FfI2R8WVE+Q5f20sngWHXFg72XIs9uT78+JzXDDM4w1y6jjgeFaL/tD7iy2CffrbU1q0s2VFrtHNaa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739855746; c=relaxed/simple;
	bh=x2x9Hp9pxaYTqBpBklK6k4Ygy63MZ55+2t9noqV0Bfg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Du2dxwz+T+khMLqnD3qaIHTRBDEk0M1jlyAv3RbqtR7t/0pK3PC8rbKfDDS2N8yJe8PMol5KEKPTJY/lXD19ttJieJMjzijbVLwTWzMxG60bFdLOTxkIyreBwbX/nWDp4eCbv/+y1NjDaGcx5s63+ZoUB7GIWQijtalPp4DDWc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gH1qTC14; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739855744; x=1771391744;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x2x9Hp9pxaYTqBpBklK6k4Ygy63MZ55+2t9noqV0Bfg=;
  b=gH1qTC14JUxseYOchaP2uab/CH5AjS/8g1GWrHBn/GyMVdYUBC9Zg8Np
   032semWj0EqeTgkHo3Gu6sWS91CWAzH/3eirho1CJ/vbn5A/gG/1VU3R5
   Zw4aiTSP29IrybuXeQeRcOpxeX2d72Ey5dcTR5X7zVJo4FJ39sdyZA4n2
   3KJrOCegrMzIXEkrq1wD7wVl0U6TgqlkcVqaPISQxA1qD0Rs7nAn7IAFe
   aSFGm8yfxZY2R4HUYdEHERTw/CfBTo24CUIITQ23oKLiheyWWxPgbNKHZ
   +ta0FhSKfu2NiIkg6T1dyi92i1GqZvPx+z5jfAj6dWfcJe7gXWIElnQ/J
   Q==;
X-CSE-ConnectionGUID: 3bFeR7J0RE2zzS/V7m9n/w==
X-CSE-MsgGUID: hdtV9+EzQKmRTSFc6XZN1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40562679"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="40562679"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:15:43 -0800
X-CSE-ConnectionGUID: A5la2b9aRgu706nV/nUInw==
X-CSE-MsgGUID: VPMwfF0eQlakjFgNYTkHhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114937807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 21:15:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 21:15:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 17 Feb 2025 21:15:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 21:15:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3H6EcOp8elxAhr27BbzR6S4b3Ra1FVNsP1P1mYShZKwPZq4SpF2aIM2O3+llCeWJLvRSmoKtIHTW6UiDWmvCPNxWvaj3Fgs2pR2ewmD9u8txET1pucJFLhLPi8QkGQByi9rtHtaK3uHOifE/6W7cIHkSpYjY/eJ6n34uPC1asGc8qnkb4tzujkV2a/Z4aW6uhoGIxUACZ20vls014TLQVWEqlUeF1j30mUG/Ge5Frg9zAvU43uKoStX+a9YJTbKP+rt1sgJI4O/ZxZKDAncfQY3/fVXgR0oA8UeWh68q4Df7p+lPdY31y9J8RT71p1twr8aevPQt8Tcp9RGXfQ9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2x9Hp9pxaYTqBpBklK6k4Ygy63MZ55+2t9noqV0Bfg=;
 b=sNK9WRQ8o3T9LO836Rm5doruqnGodkA3IMwbcv/fI4ST5eEruRPW861V1J1NFY2HpsBcxfaHboJQNYlh/eGrSNUEpFf8DeXNhbV5LwB9v6KAmg6ZADj9FqHVS5nAG13Oe9pc9Jqy/6WIMT82YIl/NT9CB8LkjV5KkdNzXZcI8YOYVlhtD72nTBrKjsVgNqDAxk+z0HJQrAMdaLId9GC2dHBtBltcpMpoVJRQbtJJEX6zOBf0DiKzMqHD5QnZe/nRnkb5tQGRHHr1dxwt4k5vD9rx3+skgIGY1HpZKlWDoHPzaDoxTZyw700kmEOPiohystJ27WOHbJWcjVdL5ypgJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Tue, 18 Feb
 2025 05:14:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 05:14:58 +0000
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
Subject: RE: [PATCH v6 07/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Thread-Topic: [PATCH v6 07/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Thread-Index: AQHbbsB7HR9yJhey206dG82i6PAMFLNMqoNQ
Date: Tue, 18 Feb 2025 05:14:58 +0000
Message-ID: <BN9PR11MB527680CE91000E5FC9F93B3B8CFA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <3d952137a7935608f9cc6b05bd561a58a0c5da16.1737754129.git.nicolinc@nvidia.com>
In-Reply-To: <3d952137a7935608f9cc6b05bd561a58a0c5da16.1737754129.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7015:EE_
x-ms-office365-filtering-correlation-id: 6ae8df90-5599-44c1-cc59-08dd4fdb3036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vErPZonQjeV4z3MTJZXoMXU9rkvoROCZi7BlO2iQBrseThl5hjNrOYr4HCPF?=
 =?us-ascii?Q?/QseAFDIR9ze5LYhj8ZdNhwJsOcuYSk1bLkVRpVtKPdolEfscjIjavE5VPzW?=
 =?us-ascii?Q?N63HgP7RmFEvFlbVaPLGbKrmhWczz6ndbcQ5u5EiFvQdUzqR2nAb0rO710Dz?=
 =?us-ascii?Q?ppsW4BA5NzcVtk2XiVNMJYQWAuHSILYx3I9l0MCCGmfs3Is+Egp4tQG3xLwq?=
 =?us-ascii?Q?2a3rWjUd88m4B4Kxb8lLOKGyUhccfwNxW+wJYQIf/rOId+Y3oTX8S8l/GW9/?=
 =?us-ascii?Q?fT+/H2Y9lp8fIvX9OcDXiBjNJkFxZgS7oSCgPBpvlbEKC5kaoYAJEnCbHP2w?=
 =?us-ascii?Q?21MN7PiCKt0HeAC2dBGFZZLlquK+7y/YV9jMU4iXfHQv8Ar1L+Iq7KSqssj1?=
 =?us-ascii?Q?ET+IXx75sRUktdTM0O9nGiNAx28kVCVn8tkff3X1SBY/g3TOSQ0bEEVxawv+?=
 =?us-ascii?Q?i8FBheEY10vLxQZu8XFu2xb21jO0LKPDbE4xSopahV6X6/6Vrw2wvNK3aDv5?=
 =?us-ascii?Q?ME5nmLqHC5lqN0pRGVfdIyT2m4X9bbRsrl20b55LG+hJ6dQPzQRIDtK+9zWP?=
 =?us-ascii?Q?0I4vCDQUOd/nEF5iY9KVJ0uA9CIlOY9gEBSTNOXxQR/+uvkYK6Cyn0n4Cwbp?=
 =?us-ascii?Q?FXX+cY/cuDYWDjiQSK4ZVPR1VOPCspqyv2LjtA83u4mPbc/HKuFrSq9fGRUz?=
 =?us-ascii?Q?8Yc7Cf/0A/gAQnetS8Gy/KPmLxFfXFns4a4GK/bm4Ekekn9n4uHSr6a/a48b?=
 =?us-ascii?Q?XqRRYIuvz9Z8U8WOOUxfkKsMy6Ixf2dNsPpEL/ESB9ugg8MTOVEVBpK/9QvH?=
 =?us-ascii?Q?AtqJVhaRtiT24Ndt9u5g/rmnvlEYA/ymeLB1YEaRuL0I4/ztrIYJCrcgSqVo?=
 =?us-ascii?Q?qwlwthwjOO6uGO8/86EbqL4Mf18LFu8FSeX1ZW3WNCaFp6oCwOur0ds7IZhG?=
 =?us-ascii?Q?wBBuI5BwIDZxFe5+70mXQH00nAIMl9IT4a5QPxDThTHrx28AUqAAiHDGk7gq?=
 =?us-ascii?Q?L122Ky5dX/h/Vmxan469VV9xRUNMWBgvRk5otF05P7dC0gk8dcD1IEjMWPof?=
 =?us-ascii?Q?N4t9BgILqggWlqilslCk+5ESQ2aUhb7+kKwXOdDvw7Muj3f5GTh2K9g8iZwB?=
 =?us-ascii?Q?FC2KT/yp5OX0XdNXqvTwbAzUKK9bLeAiLX+QqFE//OfGdL7jVh4PN4DIhG4Z?=
 =?us-ascii?Q?Cxcl47yiYvCmKR6LSoJETbDL6sQ/EXgr6saENVRzo95yTqIeuFHN9cw1zYhD?=
 =?us-ascii?Q?lf2yOi4oJhHg9X2PJc0m05+pO3C/9YIRmxaFyXDygebPOU+Vg0RjdoNY3kGK?=
 =?us-ascii?Q?2DJdyCxRKtH7iU/YL5MnT3VTL1+vDbA41U7a2M6DzNCZUEXpJLi4ZmlfMXsO?=
 =?us-ascii?Q?xb8hyTR3QFNlVbjmjIkgG1GFEOG8qCsfLviw7ovWCTsGHop8IvNpDbNm68aU?=
 =?us-ascii?Q?Qcc7Uy91d2RjZDRebDsuC16Hjnrz5giq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XHd44gHAamWbAl6imM3RftKTvepLWoUWYcNJACh7byOY3LLM1uUmvQUulk1s?=
 =?us-ascii?Q?yxwonKoWoHDO9rjn7yGUF35kBECrmYKipki+i6jNj3OdaFU7xpR2W+UrW38x?=
 =?us-ascii?Q?IYMHWSmV+/M7OBqaRYfb02iQKOuz6JheDsIYUxRSkPR6WAmF0VSYfcSr3Oz8?=
 =?us-ascii?Q?SavgHBkgGwmDbIqYAMyoxBFPhW7RZzATMm7g2O8JADoCSo5rmsjaSHAvNGP2?=
 =?us-ascii?Q?GO0NalT07xur0/KAtzUJwoWHDR1Q6H9Pe/YG4BspZ4albTpQsYcLAVXmZULy?=
 =?us-ascii?Q?c8ESXU4wd6i2otRH9BV4OZKd66T76NDUJ66QqbNvp8UhRrgSzJ1Ov37gGalS?=
 =?us-ascii?Q?YF2749ChYdlusqyv8klH4ArDWpofCnVeYAGQ9/tknf3SAZqZXVOlBCVy+IcD?=
 =?us-ascii?Q?l2A9H5gDhSMPUvZV3OlZaMQe7xQyJ9mQnn40WoIiK5Mf2ANU9rzWejIs4ETv?=
 =?us-ascii?Q?MT/xdHmxl5EsMK1p/0ZNGt1tbw9jDQLM0kV1pv/vKNOFgpfmZvsn3UeA5Ldt?=
 =?us-ascii?Q?tyGpFuuImJ5u4h9NKudnT5OCDJN2wVwqP2vAds91I73GGWuduwlLvMcbsCmI?=
 =?us-ascii?Q?pnzn9REmTPLk8nzjG7Gpi5/Z91P2QZvQ/cC28elQG41E0S0CdcnAs+QAy+yd?=
 =?us-ascii?Q?rdcNnd6Qhi9sKgZsrfH7UND26PpGTDU4/+btNuOMod9eTCXaLd+9ctlpJBND?=
 =?us-ascii?Q?PkxNdUrSMdcFNP5DE7gkjyaldqAl+iJKyUegccTQnKVTU/9OwfK/xmtjoarg?=
 =?us-ascii?Q?dhYmKCjveJoGG2RDAt2hSelbevxLXaqd3VNzoqK9c7w/KeHm0NfXTGrdJWys?=
 =?us-ascii?Q?8W69Uoh9GwucULAcR39Gv9DjN5AOn60bdxJaX77FnuruxZIsO95gCPHDR+jg?=
 =?us-ascii?Q?CEtF7xUTJRWgSwkx08tgoMbzHvoZq+A/LDwe//F2K0q6HS61V465/ndEtnwc?=
 =?us-ascii?Q?Uv2tGgiS9RW/6/7bcePU9CkzlamPga8dalVOrrdujwvYSTSuE/N5Po6QYA2/?=
 =?us-ascii?Q?fC5KVLqiT7GxhHDx+T8JM7YiPnp1mJLlcdth799hQNZLYdBnoQiMqXgYCP+C?=
 =?us-ascii?Q?ZNVvUDUokK6GfQ+SpjeWIjtNz3GbGdawRtBG3htUXvJMLmlbWn8xWt1+iTho?=
 =?us-ascii?Q?eIsPIF08N1WIQGKPwxQsPE64iwDwEmFyBM9rXa+rcfSIo1ejAObVLlM88VNL?=
 =?us-ascii?Q?uh8L4D0bgY5CagOnBlgkHgXTrNbN4tXojg/tIVEpIUVg6e7CjupJTcT6JXLN?=
 =?us-ascii?Q?FCyl4/z13RwBEILNONOKwM7irl82E3ZjCPxOUiNKqf59tDlIaNYyd8XTZZAc?=
 =?us-ascii?Q?9R6BfmIV6FVFex2ToMJLm2cmdkX+mb/2nUEvsCVVdGTn2mU9ZS/kWaIsbfZ/?=
 =?us-ascii?Q?lYGq4XeythF/uhzwJ2pWQnAdKqtfBfUPcXGGu/0WKdR3bKFe69ttsU0+X7qn?=
 =?us-ascii?Q?Y8AaCg6bnvKkB0PWSFNV2Fyk6ZKfbfzQIJKFHcyJdZpwrKAv9IkCNYckBEuA?=
 =?us-ascii?Q?cXxzrjU//51VJ9jnXwkn76C4fKX1sJWKGJtH9o9uJVgc/XCJbKEjaxvvpuzN?=
 =?us-ascii?Q?VTDa3rbnwpUSFc4QiZaTbV2RMnMntxOHupdbe6OR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae8df90-5599-44c1-cc59-08dd4fdb3036
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 05:14:58.1783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcL49MSLPMeaNAR3p8rVCH6Dn3qkb1HQWxATX5DcI14jpVGPdKlLggHS3lmgJe7DAtekOB+zWN1+0r6qbW/xDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 25, 2025 8:31 AM
>=20
> Similar to iommu_report_device_fault, this allows IOMMU drivers to report
> vIOMMU events from threaded IRQ handlers to user space hypervisors.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

