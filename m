Return-Path: <linux-kselftest+bounces-24303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543FDA0AD95
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 03:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0AF1652C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 02:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479EA76025;
	Mon, 13 Jan 2025 02:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+D2DFQv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705E3EA98;
	Mon, 13 Jan 2025 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736736759; cv=fail; b=hDSVQfOZ6QAF8NAkbgP+XlyNwGtAqeKCSeeEYcT3+1XMXHRb8aQYZP8XlP1cToY5lnnkRGNylc5Q4y+EbQkVujzBoVeF78XF6p+iBp6Z5215d56rCjNsI4+fZW8vi0PFY+013rkiUcVQ1b9znzpQ1Up4REQBcFKaSGYlPdJJAZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736736759; c=relaxed/simple;
	bh=+LCx3/UvN7dGyDfHZDN5H64l3DqIbgdXfPmWn5EaaXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tdcbof+J31Z29KUz3x1CsmkoRaLAMk8DCfx044X4URAwpxnO0vq2hDGvazGTO9EfNJ1VnThNS1G0idNeTziUMXKDq9og8TdFUX1f39YFqCBN3HMXN3GqIOiJt95WURNP/042COOHCmoLwdiGajZ2/lt4EeQFrFOBTOG+RKeEw8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+D2DFQv; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736736758; x=1768272758;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+LCx3/UvN7dGyDfHZDN5H64l3DqIbgdXfPmWn5EaaXc=;
  b=D+D2DFQvI9cDfQBmxdyHsksklxniqeR4XF+2Qon9NUEGPNMLa+JdQSCh
   8bcGQFX4mG6b2nOFje3ro3Ww5iX3lMXLuSYBXD0EfuBd/crv56MH9Tt//
   kwEt9wqBFNTEuydk7DGJJJ7pWgo+9LtCp3jBnJMT4zhHHkjr3eAVWNqC7
   WA8kGmAbMOsTNQFV6ZlB3/JyHoF6tJBfPDulj6LU3gAIpoZ19e9s4i45/
   rPXJ9gej2luPLSjMgaaenSjMF0+Tq4+231m5SvUNKjAYzeP/k8EMicVR8
   laHJ+zCyp5BBqaEb8Eb31T4BzREwa0hZEwIfwWGvpA7ejMTfp1b7+kHmr
   w==;
X-CSE-ConnectionGUID: UTCPdZnoQSiGsHpCAqIh3Q==
X-CSE-MsgGUID: yQbol/mrT7e6NXOHxCnEYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40745517"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40745517"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 18:52:37 -0800
X-CSE-ConnectionGUID: ZIfbRLZuS3KqW2TsMM499A==
X-CSE-MsgGUID: 3vSQDneSSfCAZOYZ5TQRMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="109323083"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2025 18:52:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 12 Jan 2025 18:52:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 12 Jan 2025 18:52:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 12 Jan 2025 18:52:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5iyGZ+X5MRvqXORAEtJq9lV2DQj4KBZeGFuEP0zdjQElFMslFpCO4joId5l+HJA9/enAtZ+jdV+OAwmwUtL9F2wsd/Fq6E1l0CISDRaxNQkU1jrQKOGIYysh/VR2iUn1pxRS7VSjkkYVBgEDMS7Z1zXHHmoU2e/jVWvzsPA30KSm2MroVLBqOJbE7a6ELS4fC9cT7uSiJQMmqwTyMVBRSPJl+wHf+vnFQPGsDSu2kd/9FfGTvzYJoVp84UgShYOjlIo3uJK07JNaCstuaMCNik2O8nHP/ZXKCFGg1t1P7NmoomIfXcIsmugobLl5xw9ueedYDxiE4fLOUvRwcQdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8H7jW+OVU+wZt/73OCQDUOUljrx6CKgA0qcHgbWLkA=;
 b=IvTtJXaoMnREAJLKmS/LRTgIiGmj2qDDjsGLKYecKQaSFwfjV0R5ubqUcwoUZi0vBi/zzULV8rZoHXQpQfs9EASUnytw0EiMQLhSBFsbk3EgR6zYfzEruKhOW2QsWbCA4buzv3CyrazdAY+sJA4Wu2Y1woEQ3a/lsN2vRV7sYBobkTnta6mNyiqxAIogPkwgdqBuVi54POr/TsBCJfkGPC6GjP1/+aWemIe830XjIiMQ0xVnHz6FvWIMC3KhIVnQLdZQN2UHsrLWMenRLo8lFaGOHMiP/RKBmwr8c4hyttIFna3lFhYgkQ/Rjo2iaD2+tE+z3PjA5lAEqee6vmS37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH2PR11MB8865.namprd11.prod.outlook.com (2603:10b6:610:282::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 02:52:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 02:52:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
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
Thread-Index: AQHbYSc6iqK7HX06T0GpxaurMWOE+rMPlPbQgAD2JgCAA3pj4A==
Date: Mon, 13 Jan 2025 02:52:32 +0000
Message-ID: <BN9PR11MB5276AAC06F5B90D09923677F8C1F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
 <BN9PR11MB52768B2EA84EDEFFB04662598C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z4GRMEjAIoBjHnMe@Asurada-Nvidia>
In-Reply-To: <Z4GRMEjAIoBjHnMe@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH2PR11MB8865:EE_
x-ms-office365-filtering-correlation-id: b837ecb6-adc8-4c42-382e-08dd337d53a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3nzKxUV8NYspznyC7vDauH6eUyXM0cqG+Rq06MFs1+o402Z8JEP8/jdJTG9E?=
 =?us-ascii?Q?vUbDTTV8sIXogTExyemVzTirqHDMOsjK+leixf/8EXRLDeAnDr6w/X28GEL9?=
 =?us-ascii?Q?reej/ZmwtKqocYm87s57GH9YvOTKnKm7u4gkbR1OKCALfX4/FbXaPmmPob6V?=
 =?us-ascii?Q?DXpzYbMtHOJUWm8BDHSV/9R+cNRpoCOqV/Zxv5qh76ZEnBOD3ozwgcnRRruc?=
 =?us-ascii?Q?0+Dhxl0AXneNni926WibO6TFNIp+UNSmH7hoaj0OIxVcee4yMNeGieHHEm+r?=
 =?us-ascii?Q?iPP/8hT7duFuo4qYpLGHFDZrFUax4fEdRWL+aW4VYV3v4TD33U3zqrvToD5X?=
 =?us-ascii?Q?uV0Bg4rTv//jRuPSsu7CeiRrWoYvMydzUpLqQ5vKR2hibcN8nVGt7aDdvske?=
 =?us-ascii?Q?hUH3MAjZXICdF/9p6mqg4L90DSglivi+rq0NXkXEPoX8R4dxWHXnmZim4VQS?=
 =?us-ascii?Q?Si6TuXhK4OE1a3FoWQcaj10wH2vNmLeqIDLxQotKVyYpbY0py0oNzUQDE/ka?=
 =?us-ascii?Q?7TBSqi6FKpQ5B5nNpN9Y5ktsMS8TlHLW6TcWePuHa/+sNXgt2JCA/8CQ/QcT?=
 =?us-ascii?Q?Ou+AGsgNpBEaciDtq+2Gs1HVxCCCYWz6bLK9wkIv86SQhSsBH34FNSUaqoIB?=
 =?us-ascii?Q?E5J7K0oPYvLlogF2UFNGOwW1RF3JbrGjxwmq12/Ago7HvQqgkJ8mgJUcElRH?=
 =?us-ascii?Q?D+QSwNgrp0JeK4uJniUfpyzy/RpmjNyRq4/xCxdc2W1pGHpHc3copNvUzzfo?=
 =?us-ascii?Q?5+BPkumjI1dfFIZ0bCK6/g0lQBk1m4+5Vcd9+54//9U9T8vMWTwQq3nAmMas?=
 =?us-ascii?Q?XmHKhXll/ria0qfvdkZuZRUd66A+nNLHULtavxEvQy09A3RkZW7lgnhYAn+1?=
 =?us-ascii?Q?ycHL8KHOjrjocBk0HvE26JedQ+FbgUjcxF9Eu8/smJcpnsCil2Ly3yVR25hk?=
 =?us-ascii?Q?Or0WX3sPEAamJONp8AOzFxG/8CETFBpkO3Wew2pg6WwH/+ROpCxiUNrhrPcS?=
 =?us-ascii?Q?BMkiIC9r++HabXT7bnI+CObvC2jbEhKvq74ycZVeTj4emyymyzeB7oVWtt0C?=
 =?us-ascii?Q?E/rbILzEOGxZlr9vU5aObHUXejce3EEqo3Q3TfALzuftuH2djILesRyw87ID?=
 =?us-ascii?Q?PxlX7XOSvVilh9EGnlEPMWAw5r5LLEe6sH74s67BCawBj88MBRNgPPBqVO0q?=
 =?us-ascii?Q?c+sL06AXa2+/o9ERxnsRlJfqfms4SSCOaujFo4WuwuqnZPfDIesy6luQzbT/?=
 =?us-ascii?Q?/TD5hft54sPYJW/oFwGOHX7Lha+VFJf30HO64SnTk7ldmxBekTgokCDSXkqO?=
 =?us-ascii?Q?U/N1HYA7eIl79pSMOOkjzZlcwWLSbdi8vXIjjK2Sp7yFX4N/1biy6UFOIlIk?=
 =?us-ascii?Q?UEEkYND0e/YeOHWTamT1BX4iJbOzqi2PX/AC0bixb3oKdqt0U/ybgDRJUypW?=
 =?us-ascii?Q?Yd3FpYdCil+scquhUdHx38WGUdoW0yFN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FoW+hw96i8GEd90cTaeKl7USLlpyeJHkK1DUTQlgbzbBhkiM53J85TjHRmm/?=
 =?us-ascii?Q?fEWvhWSvvg3PMjQ24FNe5Xr/vZnklg1G6aowbOIo2pZIKIVoisFB6CFHstb8?=
 =?us-ascii?Q?9LoMfUFPbKpTGEdISiM4u3aYnoDIYPRswxykD54gJgtm1C80EasqJL59yB7q?=
 =?us-ascii?Q?5L7psyaWGiJYmNhWfKzwQUMTUx5n0A7docpeVRmEjvSJkPCn/DDpJxMDRJn/?=
 =?us-ascii?Q?NXDUEc7LvwRlDeSLfWfeMrsBRyrpv+ABgJRxP3P/r5F8lR2Dmp0b3S4P3f+U?=
 =?us-ascii?Q?3AW3vUHUtxjkrZT+oiBFp8OAWYEw9JDyKT4fplj9OlLikg5Y0+9DywKbHQGB?=
 =?us-ascii?Q?hhFBo/YhnybgeIrW0kTn8mTYqiOsMK7E2H1hk/X1w+EsygMPzRtPVtGJatHU?=
 =?us-ascii?Q?Q5zHIF2f7bxNvhku+zWkXXgepKMHQt3B0P7BLaqmPckFSEqTjs1oyBo+0lwx?=
 =?us-ascii?Q?K5Yl2eBMvcB1oL+rTNhkydQFQ4sv+BNMSazFMc9jTAFNdbPzykL+vPm5ogyc?=
 =?us-ascii?Q?HosZ56D+uZdRLsMJg3yit2hzM5F+qzmlB3wuQirbZo8vO1wntt6AKY1Yljbb?=
 =?us-ascii?Q?jaLQ4WDV3dmWHEXBs+F03wsvMPAvBAiVBe0k3eZuCW/82lwfGPz9um9pZ70i?=
 =?us-ascii?Q?7zcTEJhOWtUSGSmwvpaIJnSejY2pqvleUERq+P1ZBB1EiPGX0/RfA+F4bzxd?=
 =?us-ascii?Q?kpSiWUJjPvWc/0VVksmMaZ/dtATtp3CIHg+ET8BEdNRfQLyIR6GZrboP29as?=
 =?us-ascii?Q?A845qMD317yZSc2tW4pBshOCU+63LFCFwjyDWKRNggMXSAfYCn3WYmvX5qiH?=
 =?us-ascii?Q?9jNyeA05Q5StaMxjTVTrnVgUdOBOkNMGIOcWAgmwpXqd5yB+s/PrOrsbM2yV?=
 =?us-ascii?Q?zptSasRMlTAXuVDKeKfZtrVDQ2X1o+9TMEx0+p8XkSca1Aw7cCcx7xodiHCA?=
 =?us-ascii?Q?sSbWdTTjExsbIDCRii3+d3h0BRDtwU0Q8Mwk3Mavct8vq8CvcL4OvAAb41OX?=
 =?us-ascii?Q?RFgA8c9j2ycHdfAAlg2k0wx79PjerzblgRW0XBZUJGmoene6GFSfBnjZNWD+?=
 =?us-ascii?Q?4f06dbAitU+VMBM9GYOPZzB3XVMeTulZw1jK7d4+qVaSAsoK7aYgpjl6JQ8+?=
 =?us-ascii?Q?ggjakVXojar30Ym/hKM8zSUVhMWl9bowClYGIeGM+xm6MATWagtlk7FKmvwu?=
 =?us-ascii?Q?MAdPc2P1McGjWM9d5ADm9kssKsB/L2mkSPfBllkqdtMXn3YddSmYq5yCYioI?=
 =?us-ascii?Q?nQ11YbOrfQ+JkUbmxAzba1Uipl7WjIU6pdHjIPPoVPuC7YWjLQveAyZrI/Gi?=
 =?us-ascii?Q?GPdlqWdH680Qgjz33K2WuFCkWFFwSW2n/71aAFNgcECiEbnyjewS3/K1Kg6t?=
 =?us-ascii?Q?bKbgRK3Z24kk+/U8FQrudBInRpYVX/xmsbVqxb6/Rig0NSmU2FgC9xNP4OY7?=
 =?us-ascii?Q?Ob4p67wmkpWd2L0kT0QUiv7n74cHhrC0a2/7uR8oczEnTcBf23Dcv06HHc6U?=
 =?us-ascii?Q?sK9NELbdZkX+0/wq1kFr/b0c0crX+LOW/+6Y9incR99vRNlDvekw6XwiWIpP?=
 =?us-ascii?Q?4o6cQturhjK049QtkWzmCJQLj/0rVAEWhLUa0PtC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b837ecb6-adc8-4c42-382e-08dd337d53a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 02:52:32.3343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYne6osi6eHq6G9d7XY4FoHp8vXm9MPq5ZsY39MScWGT2DOO9HIXRJ49KsyeUvYQxKNubJ0oU/SA25V1OBR04A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8865
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 11, 2025 5:29 AM
>=20
> On Fri, Jan 10, 2025 at 07:06:49AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, January 8, 2025 1:10 AM
> > > +
> > > +int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
> > > +{
> > > +	struct iommu_veventq_alloc *cmd =3D ucmd->cmd;
> > > +	struct iommufd_veventq *veventq;
> > > +	struct iommufd_viommu *viommu;
> > > +	int fdno;
> > > +	int rc;
> > > +
> > > +	if (cmd->flags || cmd->type =3D=3D IOMMU_VEVENTQ_TYPE_DEFAULT)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	viommu =3D iommufd_get_viommu(ucmd, cmd->viommu_id);
> > > +	if (IS_ERR(viommu))
> > > +		return PTR_ERR(viommu);
> > > +
> > > +	if (!viommu->ops || !viommu->ops->supports_veventq ||
> > > +	    !viommu->ops->supports_veventq(cmd->type))
> > > +		return -EOPNOTSUPP;
> > > +
> >
> > I'm not sure about the necessity of above check. The event queue
> > is just a software struct with a user-specified format for the iommu
> > driver to report viommu event. The struct itself is not constrained
> > by the hardware capability, though I'm not sure a real usage in
> > which a smmu driver wants to report a vtd event. But legitimately
> > an user can create any type of event queues which might just be
> > never used.
>=20
> Allowing a random type that a driver will never use for reporting
> doesn't sound to make a lot of sense to me...
>=20
> That being said, yea..I guess we could drop the limit here, since
> it isn't going to break anything?
>=20
> > It sounds clearer to do the check when IOPF cap is actually enabled
> > on a device contained in the viommu. At that point check whether
> > a required type eventqueue has been created. If not then fail the
> > iopf enabling.
>=20
> Hmm, isn't IOPF a different channel?

We have a fault queue for delivering IOPF on hwpt, when vIOMMU is
not involved

Now with vIOMMU my understanding was that all events including
IOPF are delivered via the event queue in the vIOMMU. Just echoed
by the documentation patch:

+- IOMMUFD_OBJ_VEVENTQ, representing a software queue for a vIOMMU to repor=
t its
+  events such as translation faults occurred to a nested stage-1 and HW-sp=
ecific
+  events.

>=20
> And a vEVENTQ is per vIOMMU, not necessarily per vDEVICE/device..

Yes. My point was to verify whether the vEVENTQ type is compatible when
a nested faultable hwpt is created with vIOMMU as the parent. then when
attaching a device to the nested hwpt we dynamically turn on PRI on the
device just like how it's handled in the fault queue path.

>=20
> > Then it reveals probably another todo in this series. Seems you still
> > let the smmu driver statically enable iopf when probing the device.
> > Sounds like iommufd_viommu_alloc_hwpt_nested() may accept
> > IOMMU_HWPT_FAULT_ID_VALID to refer to a event queue and
> > later dynamically enable/disable iopf when attaching a device to the
> > hwpt and check the event queue type there. Just like how the fault
> > object is handled.
>=20
> You've lost me here :-/
>=20

Hope above explanation makes my point clearer. Then for a nested
hwpt created within a vIOMMU there is an open whether we want
a per-hwpt option to mark whether it allows fault, or assume that
every nested hwpt (and the devices attached to it) must be faultable
once any vEVENTQ is created in the vIOMMU.

