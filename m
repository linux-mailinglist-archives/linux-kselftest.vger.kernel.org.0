Return-Path: <linux-kselftest+bounces-41919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E847B88603
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292C22A2EE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 08:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749302EA721;
	Fri, 19 Sep 2025 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbKvXvCc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C7F2E7BC2
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269841; cv=fail; b=N7sF3+jPufcSUp+nfN5MjoidovzI2jo/mE1DIzljaLki/1XDW9E1xUxNgVS2zki/UWEbmBUoSD7ykikjyq+D2kN3KpRSHjiSzNz8vgee8gUprO5LKiM1dmplSPLPGy40rgiNXHL2hGQQiYy3bIg/p2b7BblasS0YiVkXAmNA57E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269841; c=relaxed/simple;
	bh=8FX31wIWSPhOHwU5cIdUGl02QYFycA65bdjhXGavX34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZaIjnJseNEHsTmTjGOCu05bs4auUz2hcyqtvWGpys0ljwFflDvmv45WQiT4Zi2g64L36hILmZ4fcRbMqkB4DL93vRZVtlYmFf5Vk5L+nsW1+e44wm/HWVaFhE6sYFXB830HYOYwfCzwQu0S0f6/U+haVVSSc6GH32ZKvT9gEy0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbKvXvCc; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758269840; x=1789805840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8FX31wIWSPhOHwU5cIdUGl02QYFycA65bdjhXGavX34=;
  b=IbKvXvCcG43xYQLhb72ghKEML38913sPFvf1DAMWENanPFE6gHStemdJ
   g6bNzj0ziwzQsXab7ZX1ZrOj6n2jzzj18YrsrNu+zr61bfETpeoXUZkbJ
   eECdqEk4rUEbxNZgucUB4oi0/hShrZIyaNT4aZbhBeH+1Byhh73GXJ+XB
   s3wz7LAYQTaxbPNGyplHFxf7KqlI68Jam6ZJG98Fpja4WMjJQdGPJA5c1
   xn6mKy/T6MaxXZ1a5dE5mvzoLH/ZXLhzYWLFTgVTYH64L0fFFVsAk92aW
   ZI0cIjCpeZ7gCJ2TKjEqLKiodo5ETK95QbOyuc0RudqT6XKcexj2TEK4J
   Q==;
X-CSE-ConnectionGUID: fYlQHt/cSoadJwpBTMea+w==
X-CSE-MsgGUID: 1k4hX1SZQkiq0hCebJROmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60676851"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="60676851"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:17:19 -0700
X-CSE-ConnectionGUID: BcKCikpTRKOsF1TC7KY8BQ==
X-CSE-MsgGUID: OJjnevP/Qo6s4hoZEVsz6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="176218348"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 01:17:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:17:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 01:17:18 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 01:17:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLlDYGdXPE0JtkIhcfUdvVwXWdA5uAwBKm19LVqv9CafROrMNGgwlBY5ZXV+T7RQs1dN6HLVBYkqlTzY1nYATvUIdnc5cJs0jH6Wj8CiCnyo7CUKk1sNFQUHdYrnIA9Kw/Ez8bnd3USwo69khOQ+TXtoT8vTL4xlop6AyzkRo7f6PfzxzXxO0w3Iu/hnEOHw6ijPwNOc8pBe2HXxlFMGEu/Kt6owv8A/KDGhHVnzuVDIPfI74hDHKWTWe+ZeKWqeNXa7ITp1NEbxxsrurEUOo5k2rKOhBkP/QN/7YeJyd+sMlVsO8+LmUq4cbAHLlprg5vKX2V5eFiZb/q3VWJtVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FX31wIWSPhOHwU5cIdUGl02QYFycA65bdjhXGavX34=;
 b=yu6bRIfF5NNQCEjZe1IH3CnDehDl932mVF7Z3sU7qZtvAeuiU21epi7QgiDWRoMJOvfIijFxXtaZHgkcWN1jOpR2mpwMApVi5+jBcgpucr7feMFmBDlb7D0tEboE7pazPh+tAMt4ecQ0b048Vh2cdk7M7JZpw8N46Hx+HOUk+bdejfW+fQTShAuQqRr8ofHrNIc+fZzbHWAhy97TjqFa6TAgRv8UnQXylpxSO+9Ov2YI3RPlFioCchm+LX+eatfNrQ3ud6/a8s5Vjf74H4FeEKBgYpkvDoF0SnSOfhi0U0Tvhk6Zd84CxLNOh0HViaKljbtbBggMBn25RbEBTDBPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5796.namprd11.prod.outlook.com (2603:10b6:510:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:17:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 08:17:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>,
	"syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com"
	<syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com>
Subject: RE: [PATCH 3/3] iommufd/selftest: Update the fail_nth limit
Thread-Topic: [PATCH 3/3] iommufd/selftest: Update the fail_nth limit
Thread-Index: AQHcKA351mFeqi8UzEyI3mk3FSBm4rSaK2QA
Date: Fri, 19 Sep 2025 08:17:14 +0000
Message-ID: <BN9PR11MB527693D00256306E37F7A2128C11A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <3-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
In-Reply-To: <3-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5796:EE_
x-ms-office365-filtering-correlation-id: 88556512-55f1-42d3-6b6d-08ddf754f0a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?jAnGDGI8DOPj4oRc+zCxo7zWYMMsTJtbpWwI2AV3erknKyBIrVVbtDN51oB8?=
 =?us-ascii?Q?zjle+py+3Y6d86EaxwM1u1mtMYIHZ/6AMAE9ODyxCnqqz+UWkV9kmap1Wnwp?=
 =?us-ascii?Q?EVyxcT5o8Gj7ksEaiC/TaEH776eIoAlwE0UOw51b9KDQxzQApZyTs0ubIJtl?=
 =?us-ascii?Q?EEH1u/u5Dlt/I9XDVloIfgb57z5FigOuDP4kWOsq9J0FE9peyX9ZxsysSY4Q?=
 =?us-ascii?Q?mug/MF4swvcc8QCea2quXsWeUzH1kO5S7iKna4ZQDsmzJjq1QI+YIxfP0tF5?=
 =?us-ascii?Q?hMw/4xnR6aBzmqwloWG0tT2t1zo/BCwKMenXjodMeRojHJ7+lf54lvYfP77C?=
 =?us-ascii?Q?lZxzeyYRa8a2/pSCP1RXXfz9eHjRpFRVAPUNWmUYZ97t7ZTnWbahNykp6I4r?=
 =?us-ascii?Q?VbU0fAUNDhQDzMNryjc56ZMS/MTBKysqjH2Q2CzVTyIiqloe1OXjwG0afJRL?=
 =?us-ascii?Q?TVvKhi0ATh3YjHoDamWfjGqLf5uSO8KHJR+eMckihcoFeHc1vEhIz+AmCHyb?=
 =?us-ascii?Q?E1fS8PxrwbHo2hVWHUyZiLCUX8ffN5wREpxS6fr7YvfPi2xB7X4sTIYOTLen?=
 =?us-ascii?Q?bXYSlLKO/GyVz1MGOi9YQF6yov4cfiKUIcl7hQ+/tBoyB2Hq6I1c/mwrQlYX?=
 =?us-ascii?Q?k1jDXkNjyoyRfb3HDQxorddb0S05ejMrftG9P3VcDhEr+uTPqwlVYOWHdQ7C?=
 =?us-ascii?Q?+IXqBW8n/eK/tBvQsR/qMjo7jOIKvUBTyULQxkYU8q4jtNuI+kPxMlH3fzCs?=
 =?us-ascii?Q?Jd7kXPVfqMa61/11Q5XbwpYGGg2X70VuiWUO/x52lDcn8MvMycEVwDSt7Bn/?=
 =?us-ascii?Q?nL7RG8gb2xaDE2xj8Ijn5mJWGw067rChj6KuqZnAseg24/OpISmVzVuE2hJ0?=
 =?us-ascii?Q?eD5/sdHkI42ttsQqSFmblKUuKcz+xjXJ0VOoDzEqmluzYd+jxAsop3MmDUjr?=
 =?us-ascii?Q?CuZnXaa24YCRuiVYtyQ866GSTT2s7gP6V/16gp9mE1WbLjnulpc4rhuZ45AB?=
 =?us-ascii?Q?nYnjnNxj3+7cGTrrNd3WR9nhLhPVukkjhRM0DT/TT1n3TsnJCvU2F10vI4r5?=
 =?us-ascii?Q?ruosvcAkpfhAl3GtW+5oI9NjraRgVAVtjZCnK4+FSz2vNsr5qOHGgem97+6t?=
 =?us-ascii?Q?bUVBXn4AOsbZkgjEz6thDw6cZir2TopNbxh72MJsSz8urhC80AmcFP2Ooa/+?=
 =?us-ascii?Q?l7xZxsndkGuxwGmwyF0KbB8Rhp8STJ4JhUEVjuWtDH8aneKTFb1bcWcUNKK7?=
 =?us-ascii?Q?i04xaNfkkHSY3qphnOeCcKh2RLWR37M3Mn+ahcJsNFARpZy02eoirdDt7TKw?=
 =?us-ascii?Q?sXwqJkeAnr9ohuhdgaSRMNOgp6bdyLocMOcqTiBlZkDZnvGkDdT2gawkfNf1?=
 =?us-ascii?Q?NEAJCCQ1RP5axbknEqCmXDvK4Ee6Q8Rf1mJLvYVzfYamaTGcqGcyJ08BQJ5l?=
 =?us-ascii?Q?fvNwfgP13/jXaOzu9vvjPLsKqFzXMtcEnCG14wTA0Vv9kYhEbCE95w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5gn+Gbhr0Vp+5q+/YG4hj7Tz1FQM9H6fHab/fu66m53LWe3UGO2zMYpdcJnU?=
 =?us-ascii?Q?dpzAyNGopbZ8Suo1yJdK3dwARu/1Q0CN6w2b5Bf/mCNMrE2TZCQ0oQjO7Cdx?=
 =?us-ascii?Q?tinY32nVdU9ZiQYhp3F7xrjRy/wgSSo+sU43thacuJ2DzHra+4raF8QAIWog?=
 =?us-ascii?Q?FAOigOk9Tj4uG/Vwt9NA7gSRismd7m2OwWrNSFL0WyXqjQv2uPaz8jBy2QWF?=
 =?us-ascii?Q?wkv0EdpaC71X3QRrYWBjOCB03X5ZMm/T7Gmmi8+Thw4QImpJz8UCdGFmvFPB?=
 =?us-ascii?Q?j4tWivPqUFxYUzhLBrOml6QkNTeDPDuQvbbO0mMqTNmKFBzJtRpvxTBSOYyx?=
 =?us-ascii?Q?WinFmTCCk2A04rg49X9a+5JpB759MM/1No22mVVZesGESPd6ktbLpJDX/UF8?=
 =?us-ascii?Q?VHlDlJojoCqiVMMrC8R20sKG9niDe7zzGWj7HqJJe0lvp81MnTuEneiHL52N?=
 =?us-ascii?Q?YI58bpNl7yvGj5OvyK/grSA9tqciwADvuLI0pg+ZWvJ6EEJ0z/2SL6AFd6WM?=
 =?us-ascii?Q?++YpoaC6kf4V3tSK+gS2fNuCuPsQpMcAIA6QKl7WHbdWRU/wCxlXKgve13Gw?=
 =?us-ascii?Q?yrQFCVyJ7Mw5JvfL12XnQsKJRBwipvgsQGAJtAizDeiNE3gGWyyYspO2amXK?=
 =?us-ascii?Q?YaBSSwhIkzEbCxfHUs6H6vUyeeRLKs5+OIH5EkW0tUrSd3ypS31mImbI+46H?=
 =?us-ascii?Q?vjFv30M+agLRRHrE4PjvQCrzp8psOrI/r0BXXG18LN2WqfUujSWgEnyN24fX?=
 =?us-ascii?Q?VeurAq0cVMd9lsscu+s503iZr+h01XQT7KGgsRpe0PiLOgoI1nfO3wsO7mQD?=
 =?us-ascii?Q?FVsiMTYUWyZWz+PXOJKv9hy7R/Hz0VAUUTMroRUFIpgrxLKkYyfgBCFGXvWv?=
 =?us-ascii?Q?FsPm+gEidnI5wFt3z7oz8Ri1bDfXllt+LkFP3g3WL1wKw30eWo0f1kQofUbS?=
 =?us-ascii?Q?C+HhALJt50E+JIqzX9GWncAmK8mLn5YWzme0xr5gAJ6icWtPz3EAK0eLKKiJ?=
 =?us-ascii?Q?q5CMBCIlVqDWIRQriCyb2l3jPoVYppi+++cqelJhapPkEfXu5/T9o67C7NoA?=
 =?us-ascii?Q?LwkYf11pnSYxPEghqFYt6Ig1bo5wPF/ZO8kJ4iKxbosuBxOfjWsFAi+kt/3Y?=
 =?us-ascii?Q?bkIlCxtMDDCv30qA6DyTgC75PsW4Vk8PesGBuiBdP7Wdirz6+OdvLv51fdZ5?=
 =?us-ascii?Q?/7i2dIb60euCpTLeck8c6HexJbM0EzkkBt3rtHCKIRvVWeQufHzqBysAaeMW?=
 =?us-ascii?Q?zJVVfQDaP9ZfGN/vZp6xPUs7yV9xTIXX9VXEA0kKNC6w+a8wee6v4hgUojwI?=
 =?us-ascii?Q?yMFOH7zfg7ct8msz0PLoZQqo/38+sIYmbrznjhe5MEMnseb3qCXuiYc3qSB3?=
 =?us-ascii?Q?Kx0ZCUeGc7yQoaq3nJi66IbQpFrstHpyXb7223F3S7Kv+91nGdE2aHEokZ8/?=
 =?us-ascii?Q?jBvdiKeEvbCN5+vER7srTuW8ZuXoSJPOqEa+Oem3KYKgkKioYnr6RjTbPhJY?=
 =?us-ascii?Q?N30585enQ/rm4anj3g43bZfbJgBwxF1M1o/HTtuxdW3LT0YSoGKWt62qH7Zr?=
 =?us-ascii?Q?SFXwg80N1Vt2uP8C5a07r03tH7ggbLEtYCDuzuAt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 88556512-55f1-42d3-6b6d-08ddf754f0a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 08:17:14.2657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qi/PXsdokc0WatY8B+nbAQrJvBctvACn+8IqCHNSfmsjQP3PvXwyAWCD4q+ijTMi20JIJEkn4HoBBrPdtGkO7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5796
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 18, 2025 4:02 AM
>=20
> There are more failure conditions now so 400 iterations is not enough pas=
s
> them all, up it to 1000. The limit exists so it doesn't infinite loop.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

