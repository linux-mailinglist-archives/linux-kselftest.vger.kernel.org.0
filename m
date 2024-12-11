Return-Path: <linux-kselftest+bounces-23164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C09EC688
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 09:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C655C1883584
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A051D7999;
	Wed, 11 Dec 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/HyBD+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C21D7985;
	Wed, 11 Dec 2024 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904352; cv=fail; b=FsNdZjpq8AmzxjWXj4WrsfHifpaBwIaqc0Qrruy955f4NId8RTXLevG5z1mJ21LFpFwe8eapKGn8DXpa3/BRH3PjkcU6MhAzUT852isRBgtSxzFibpqJbPVA8AEHbmHoMlkxiQVknyWXz1fPqqhhcr6wGGcBq3UNaYLU3K/4guU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904352; c=relaxed/simple;
	bh=bnQ6E8jYLcxeLA6OAovfXofUoIs3YttDVKfcfO3Aj6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VRSkpWKO4fWwqjlvgOfvPS/Y7Dcbhp7RZx3kK+vRTe5BZxZJ3Cy85XVDTWMxuN89ioB+7AYI+ckWg3zxhT030J9cax5h2NjoSK5vTFKyEs+LZ52onFW4WCInPZz3ET6hZbS2YXxMtQ4SodtrTU5w1u0H3CPhEph8RCAlA/b7Zqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/HyBD+z; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733904351; x=1765440351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bnQ6E8jYLcxeLA6OAovfXofUoIs3YttDVKfcfO3Aj6Q=;
  b=B/HyBD+zgL5AEgUbF58Xz3BmO/as9Vzw+Jlyfw4zL2Rt/NCPDjshYQHZ
   VB7hAAmR070j3wvcfS81/a/Y46A+KAo8qjp5w4IOP7UJ4jkrt/y7XN9Ov
   q7Z6nNme0OuRa2NL4DmUEvSeFkBAzZmTa0Gor1Fi2YmWY9+zKkMiBp7Q9
   owCtDmPZTq0G2cNSLDwSmSSlWtBhEg91O3/YQArJvvPnlooSNDWIbMZ4e
   l+6pKGmBdLFIAMgvaNLMAvr6Pfgk1jr/RF1QHBcHicyM5HJxSz0xRRMXk
   CE0sBFGvqn1Pb9yzQVsovwTy+EkT72fOqB6DtbNJBfPeAqr6fJbvBNUT6
   Q==;
X-CSE-ConnectionGUID: iZecZmSrTdSQg9WRD1El/w==
X-CSE-MsgGUID: WARj8nfITtqpQUQyabdrfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="44942810"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="44942810"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:05:50 -0800
X-CSE-ConnectionGUID: I7CQRUF+SC2jtV4UAnr6pQ==
X-CSE-MsgGUID: SyYmvsjtQDS/kXP0g2J1fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99793469"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 00:05:49 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 00:05:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 00:05:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 00:05:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iY1xye4fp6ZXKgLcl1a+hVEXRQFbXvJZ17bk31/qsGiJT9eFaAsAp04oUPGxcUpM0oVmmrzL4Hq8MjzY31kFI/yupWTB9saI3S8AUPn2zbFdlcZLO/lNpuz2GvTc4hop1bYm2WYKASQtQimWu3TBCEoyhHbfIqH6qZoh3BB8JwycWx4U7A49fxQi37G8C/npAKsPX4W15YBoJwc9W/chg6wyTsbP8kZZJD0BM+W3d7IZ16HHkDjRpW1Dmw9emwJc9xkGI9sMm2PT/bMxHtgqRKJ9trSXYxBrpdLIhwWjqpzUwsCUXiGG/vzx4kqQBP7fBtUOpW9UYzDWbIN7EHUOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abslWa72eDBHlLi0xGLsAavkJYxtwcokPLE6t9QaZec=;
 b=QVjs4nlef/DVsoAjIvEmJAY0fZq7mPqp865hR9MSicciLzgL0dp69a2qrGVpF/UDxw/UviwSJQRhdcyE7oTXSStbj51HHeUOOJsE4n1/YY9KruDoXr3zPwmqY3ZiX/SC73e9l6V/VNasJ/D+3p+KBtXhBu8ImF9SFTnKpn1kggZU/zh7OsNmono22AsDrsIuWqYeA3VHtUHNrTxKO6/rR+3+re77mYTwHRfyAL9C3runK0zNAj2JprbLmTcThmAH+oCfEn34IgyO02dxJe/y72dBfea+KOCPEURzZQIF5kWh3pc8xAUbSUIfeUHdvn0sQL8vgCFgtYh7hQezh1rLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8207.namprd11.prod.outlook.com (2603:10b6:8:164::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:05:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:05:45 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
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
	<yi.l.liu@intel.com>
Subject: RE: [PATCH v2 07/13] iommufd/viommu: Add iommufd_viommu_report_irq
 helper
Thread-Topic: [PATCH v2 07/13] iommufd/viommu: Add iommufd_viommu_report_irq
 helper
Thread-Index: AQHbRdBKuuVV7eowkUmumvMRSBFUwbLguu9w
Date: Wed, 11 Dec 2024 08:05:45 +0000
Message-ID: <BN9PR11MB52768F3CBE04513D1536EB9B8C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <7e9842376e6235d9e3471356d035afe2bfe8f33b.1733263737.git.nicolinc@nvidia.com>
In-Reply-To: <7e9842376e6235d9e3471356d035afe2bfe8f33b.1733263737.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8207:EE_
x-ms-office365-filtering-correlation-id: a241d8c1-6393-444b-736c-08dd19ba9dad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XbnfSQ57i0NX+qm/eHr0SchAIc3v4bReGwmWzCGdma3sxUxLgcWu+frzq9IG?=
 =?us-ascii?Q?SwkmJEWPK+x2zp46TlQM1+rjhL7JI+45pw6WD10ZASGLkPlTnwRpQb6qYFH8?=
 =?us-ascii?Q?26jpoMumAHQJcotr+sqbDmhmlhI1u1ZEqvA4iEjfQLzR6SQMYuJf7Mbwx+1C?=
 =?us-ascii?Q?7dKzOa6REVduwCp8+OPVqGsyJTfx+acQDe06Z/lOaga+374obC/UQ9snnayS?=
 =?us-ascii?Q?0ESWPjsiSUsiqL1qW0ugFzgF1O5kHZ8vuDXK4bEaipC6IlBtg2u+c4hDKUUT?=
 =?us-ascii?Q?RfXHFNz40JhhMqCH1J5MAbLOtySF6IxzzUYCMPPq2NH9ls/eKAGHKBqSd9ns?=
 =?us-ascii?Q?fBuOxalz9oBi1uMhgzSfHYVtb03+C+y2O+uf0Ooc5Lg4nqkP4+fxb+o7CCkk?=
 =?us-ascii?Q?6Ok0xoDeZd7/PO87OKXN3doeZN/1032gMdb0LOCO3fDTRsgdIx58/s2sd8W2?=
 =?us-ascii?Q?V8w6dy+v80jX8aoiizHaMTRXjMVDH6hjEMarC04gn+2vCagLQQTgsX4+oMYQ?=
 =?us-ascii?Q?7I0fs85UpwElkUBIUJoCmRDOJPFK6fSZVc3nty7dLJD1iEYtdtA1Z+9HxcrG?=
 =?us-ascii?Q?aKP9YUDWIKG1S2Yx9l2wRnZAAyb4if4mzjJeKj0OonnyXbEoNsOFHC3tkEAf?=
 =?us-ascii?Q?1sBqSrk23kg2gfhB7chTwt/hWwp/2jlXYjXnsyxmebN9XEMQYsACHhWcgZqA?=
 =?us-ascii?Q?KSXem6og7eZr4QkEPIZKR3ILwUzCoWaK291qKazW9rH1SByrmPJ2SqiTYmjR?=
 =?us-ascii?Q?TdWAP7rSueYApKwf+P7hU5qV94gNhbsFoA8kvJuVfnuXdq8A75ilmO0NMfeg?=
 =?us-ascii?Q?jiISRMIWnYZ4Jd6ycz01HKDls+BMZl6AOgQ8DxMpz63ioZPlA374ZmTzgKYp?=
 =?us-ascii?Q?wwzS7E/e0hoSGI1FsPLV8OOqcbxNaaPUp0DnG2C+wny3l0J421g8P+qVYDKn?=
 =?us-ascii?Q?qjTtRPHo+GZn0ERFw64jQX9jzoJnY+QXHTJKkYzDUd/DCB3iEMGOAipTVFGO?=
 =?us-ascii?Q?J/kKHcfUbGAk1EhW4a/R0Ha0B6LY4KKxbGBqKO1qmmHOqEu4C8vw3ToHIuv9?=
 =?us-ascii?Q?nRUXuEuue3eFonqJ9Zdd5u1cr1w+18mEyttly/xJz0WLVHM08O6iCm8P66og?=
 =?us-ascii?Q?OYf+KHEFVsCiGoB+9e1Z5AztY2lzgv7oLXrkwBsQx68mY4yxa0qbj7a/8SFN?=
 =?us-ascii?Q?WJ1psiKC4PV9jpFtBx2+yfyiMH+groto8vtdB6BvNmasjYvcZ2dRmdmE/7Bf?=
 =?us-ascii?Q?goPKdAmKmmmOoJ7uNDOFaw0TRPd3ZBbj1sCMimxxZebivuNiSJ5hPCQA9nMN?=
 =?us-ascii?Q?LTLeCSfEAiFPHcihOLTlADkCkDh1GflOvmOtCidJVd6zzcEUrPBK7z8DQEtD?=
 =?us-ascii?Q?6LMw5MiDiSUiLIMN1yb5IMS+Nw9YvD8J7X/4YAa28MI4GmVQzA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RsN01H/zTFNE2bmwlm7mD8SUgUsE0IWtn8uXfrvrtN2+DhnjADSJ6HQjUF7X?=
 =?us-ascii?Q?AJOBc0A/K9/VFlZDpHYxYqlFkR3g1M4NTu5E1QSMDmY+007+nnBT5fJOdJ0G?=
 =?us-ascii?Q?2bxCPc5S8gsql8Rz2USDc38mKXJGzP5b3rAxI1adANwfyRi8pF0571DJj8eu?=
 =?us-ascii?Q?YD8QbNItRNwsj6eYX4QH1HR0g6ghjn1gJmiwoxoidyVtRJa9SnywW2Xl+B9c?=
 =?us-ascii?Q?TfMxtFeN7ZW2dLzBy9dn6qO7I4aYTsLntXwJ3S/JtnXd3hx8xrZ7KlNGnKWi?=
 =?us-ascii?Q?RL1IvfQ89zgPUZzRUIwMlUOpghbJcb0HmziP1uDSQ+dLaGRI1eOzZXUqGF8m?=
 =?us-ascii?Q?0bTm/3gndvh/AXqW0i77slGRQLHpDjuPEK1y5wIJ59WKjEbURkLVZaDNTh0J?=
 =?us-ascii?Q?eO4s3fH3wg0xfmk8urUCV5Lm31QsOdVrQZlzZb0J5ZI1yc1Vk8x4Klv/P3Lk?=
 =?us-ascii?Q?l5Ldx/GY1TRl76ePtf3D+fz2PdIy4EhtPMyI7y1xJkWR3UcBwtJ8i8OMMs5R?=
 =?us-ascii?Q?3A4EfBOk+tkFZi7Pzo+hUTj5Vr/TYhCCRttzSQ6VXAsCV1v0b0ugTN94M4UD?=
 =?us-ascii?Q?l01+OWZmge8wP0NsVZXG4uCbHAb0HP2xMtYRxOZS0na1w/aYkwqh0tfIJjO/?=
 =?us-ascii?Q?9cjMLQpA7tLNrehzkdqbHc4dhBLttuUGbZC0nQP6WdOHidm1py9+2iLxGRV8?=
 =?us-ascii?Q?mhkONFojcrjwk9QEg/LpwBVQORSa16jpn1r4WtvlAu3aQDeMlJe5NjF3++ol?=
 =?us-ascii?Q?qr8E86NTc3gaM7i1Cn/C25shojro2rl5e2lcPKHo33kn0Mi6uSOdfYqJJ1zm?=
 =?us-ascii?Q?NFIJJpZITWREEsSPBxgPg4/DLHSYvmNE25ZfLC4d3Lu71tLxIO2Ukn9xFRhm?=
 =?us-ascii?Q?rxjgdYoSXD6HuFGOFCkHlLtPDHrFvlPfGTu9VknaM8oQYsrore8dnYfYiLVm?=
 =?us-ascii?Q?UF8wc5CKNcLiWVUeQvou9HC/MxNU+zIz8sx16aVz+euJkOZL2/cPGc4l8PYu?=
 =?us-ascii?Q?FWH8rIy4N8yT7FS5CnB3wJp5vzUyyzPRMFMVnV69IDgUQKtWRfL5tYBf9MOE?=
 =?us-ascii?Q?5ZUouPiWklw/aoGhGsDwbSNGOQVo7XUi1SDRxRJQtdzH3XOkkRcDqjh3TsSP?=
 =?us-ascii?Q?77rkmuAvDmx08EzjFfX+S31A69oq1z4p1UbGiZQV4Js5F+c7RsbgRdTBkV3r?=
 =?us-ascii?Q?3s8KQCEqk9zmAKGwGcDZeab85XGHj59qY8M9yFLKaDoadD6zKrfxUL23wXQ0?=
 =?us-ascii?Q?7ltaYF+qujRC5nvV+uGHfhQaRV6RCPHOVeGY+bvKrOp/514w7aI/bSAsg18e?=
 =?us-ascii?Q?PUlYHa6Do6azBLcBGH16z+0667lsGHIeUjuRzXV6bwOsXigbCxJRZMiuxupI?=
 =?us-ascii?Q?gKSqWzJmOky7MTE/fg3RBOkrjRvvqXweQwezPXL3WH0uyn4x7nM4ddVvyYxS?=
 =?us-ascii?Q?XjkWrYzwR0Zw6obTDcidb4Y9pYz2u+473+HtovkNFiOqXTBCCcQmvhL3RypN?=
 =?us-ascii?Q?MIHm6OCKJ06LuLHy2bdXg8YZNeGrgBiQpVUBqTdv1GEI/X2QqgooutjQSNsc?=
 =?us-ascii?Q?LBnTbHs54TsHdypz74qR10M6Lk7jMfL9xNVSST8u?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a241d8c1-6393-444b-736c-08dd19ba9dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 08:05:45.6373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lk7pVZniSfUZJYsEInu7ePEcxRP2xfd+jugMmOSx6lP0+vNTqQkU2Ubx9UG1cIT0FYe5KSCh2Ldlfu6md40Sjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8207
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, December 4, 2024 6:10 AM
>=20
> +/* Typically called in driver's threaded IRQ handler */
> +int iommufd_viommu_report_irq(struct iommufd_viommu *viommu,
> unsigned int type,
> +			      void *irq_ptr, size_t irq_len)
> +{
> +	struct iommufd_eventq_virq *eventq_virq;
> +	struct iommufd_virq *virq;
> +	int rc =3D 0;
> +
> +	might_sleep();

why is it required here but not in the iopf path?

> +
> +	if (!viommu)
> +		return -ENODEV;
> +	if (WARN_ON_ONCE(!irq_len || !irq_ptr))
> +		return -EINVAL;
> +
> +	down_read(&viommu->virqs_rwsem);
> +
> +	eventq_virq =3D iommufd_viommu_find_eventq_virq(viommu, type);
> +	if (!eventq_virq) {
> +		rc =3D -EOPNOTSUPP;
> +		goto out_unlock_vdev_ids;

s/out_unlock_vdev_ids/out_unlock_virqs/

> +	}
> +
> +	virq =3D kzalloc(sizeof(*virq) + irq_len, GFP_KERNEL);
> +	if (!virq) {
> +		rc =3D -ENOMEM;
> +		goto out_unlock_vdev_ids;
> +	}
> +	virq->irq_data =3D (void *)virq + sizeof(*virq);
> +	memcpy(virq->irq_data, irq_ptr, irq_len);
> +
> +	virq->eventq_virq =3D eventq_virq;
> +	virq->irq_len =3D irq_len;
> +
> +	iommufd_eventq_virq_handler(virq);
> +out_unlock_vdev_ids:
> +	up_read(&viommu->virqs_rwsem);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_viommu_report_irq, IOMMUFD);
> +
>  MODULE_DESCRIPTION("iommufd code shared with builtin modules");
>  MODULE_LICENSE("GPL");
> --
> 2.43.0


