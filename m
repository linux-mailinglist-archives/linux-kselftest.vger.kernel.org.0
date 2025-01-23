Return-Path: <linux-kselftest+bounces-24990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D24A1A170
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 11:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7E6169EED
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBA520CCF3;
	Thu, 23 Jan 2025 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8fqAKm3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318220C481;
	Thu, 23 Jan 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737626882; cv=fail; b=a6dxcqL3ZUjRDWXkLqMXiSuEZsRAb5pPHcorF/w/gfpei/oq9KG0t+pcF/950/WopV9Q/ED+8jblX0pljb8+vE71OGWaA/GLwUT7WkAowlTA5z4Z02h2A3VpqkrrbcmDAyjNJ0S1M5XuZhyFHYFcyFpDTf/RfNHYCiGlrV+DKnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737626882; c=relaxed/simple;
	bh=k+XpKYn+jHW5zyCSAiokk9TL69AL7WdWreP+wEHd8U4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a7C5ltD2bhHTNMg8evvn/7nzTAGuTYemc0zDPgmvPit+WLviZXmiIfJCvbvTZA7nCl1TcgL3Z9P8/pDREVxEcWRsXe2vbiVIHEyDtl3E3r5+2DrZc8AfwHS17Bgkb4aqrmyPWwxdej0K4IyebKahfmqH2810DgQeJxzjxQrHHeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8fqAKm3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737626880; x=1769162880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k+XpKYn+jHW5zyCSAiokk9TL69AL7WdWreP+wEHd8U4=;
  b=e8fqAKm3rVsatVwbQ6z3WSyqE7NdgqNiBELx09UXzojINFSMnSVjdU+I
   nK+RDFF4Kzrq/VcKwRaMAqRfAnjQp5m5Yiapd0QFL+io2tKTx65EvFJSI
   EYHASD/qkErihfaH86GmUIrizeMhYfuqCs/9jvNdhsSdx2/i+tpSJZc1Z
   UsqYijgpONCxrgKsBrL8zSfpR5GhuN11L1BiFFTsChpTQbA3WD0ehlc2u
   nuiyOeky0SwchwQb2rBes/jM2dEy4ZSbgdVzeMq4w31uGxAK/gKeC06v+
   TAsVy06TH8Ipwd7NoolPNEX/CaCH7/nuZqYbDBHfpBU3zfOvYorhMGF3P
   A==;
X-CSE-ConnectionGUID: XwPQoHM/Q6id3p00Z/ZkLw==
X-CSE-MsgGUID: xthus9ZDRga9czxoQPj2SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="49511641"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="49511641"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 02:08:00 -0800
X-CSE-ConnectionGUID: kUkAq3dZQK2YQnnYurBgzQ==
X-CSE-MsgGUID: aJ2yjeNhSkWP0Kn1C+sZ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107524508"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 02:07:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 02:07:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 02:07:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 02:07:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEGjCernjmE9gHkbr9ScxSXD2Qla8DXxk295XVSbDe3IIsB6u+YuzSkLL5XSGo09lZ8PTucjIC7J8Gghux5P6l3ptOh8tp+VbuRIbZMt2HZTD8Fuf+8NnU8z9Wr9ExaBeft4CSuLPdVugtL419qsklTnTlicbGTmQBc2m3Lf+m08AdkWD8mRPInx41bpa7aNQwnSIDUMFW4Cs/EshLIllRNFXtk0ZN0TJdTKIGhSGt5WGC9xTuZq0dpkU1nKGTpAuvwueTKYm6PKEkksW+vjGye4L60kHUVqH4EnxtaUfBbxkBnuTlF0zdXDUWNSV1vb6ZDMCPtQZtlSRC8sjGUtXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtzrdqUjM2C2lItnIF+unxoYCqnMYuD2nMx6G9bOOXs=;
 b=r070k22VYQKFcCLG8/MzBJSVlXnqNxHHeNi4ByPv+/JNbp+vAgKaxUHOS5H3nzi7Cn8A99SYEtrje9phaZSxJxSti703y6iE6vC9TkXIz4Km21LWSVi157oJh7RM8joWrGEf5JoZCuej3b2NC0uzXg2k5QEiB+7S1kloHx1QV/RDUTUnHjL23oJ5Yht9wPI/CLRcEVBCrI5YlgEWWlmAqt/XltgvFyjExVZCnX8yHufb6BNE8QeT+61AxT3hgav+hs/GVD5i6qTIeZF2U+XkpniXvssdQRz/i8M83XYS+P1b03lxWmf0s0XFsuh2XV+EAH1TVDaFA1GhxDZy6VQETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 10:07:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 10:07:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "maz@kernel.org"
	<maz@kernel.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "yebin10@huawei.com"
	<yebin10@huawei.com>, "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
	"shivamurthy.shastri@linutronix.de" <shivamurthy.shastri@linutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "anna-maria@linutronix.de"
	<anna-maria@linutronix.de>, "yury.norov@gmail.com" <yury.norov@gmail.com>,
	"nipun.gupta@amd.com" <nipun.gupta@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>
Subject: RE: [PATCH RFCv2 09/13] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE
 ioctls
Thread-Topic: [PATCH RFCv2 09/13] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE
 ioctls
Thread-Index: AQHbY9mYUm9C6M8MQEmAe5nZdSx/ErMkMh1A
Date: Thu, 23 Jan 2025 10:07:13 +0000
Message-ID: <BN9PR11MB527616A2EA6C64824576E58F8CE02@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <d3cb1694e07be0e214dc44dcb2cb74f014606560.1736550979.git.nicolinc@nvidia.com>
In-Reply-To: <d3cb1694e07be0e214dc44dcb2cb74f014606560.1736550979.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4807:EE_
x-ms-office365-filtering-correlation-id: 793105a2-536a-4cb4-d697-08dd3b95b552
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2S+1H+nhEbyouS8/gQ0MFfZRHQQTZ32+A3Iqe22cfDw3MzlN9vWoFtJFad6n?=
 =?us-ascii?Q?7Pc6hrNTLocyN8MNlUhbn54KerJ9qjvHt4Z+K9Di/qO1swrPxKR65/pY+veG?=
 =?us-ascii?Q?FqbFsk2q2sabLA9Ffy8na75FsMXZnde15UwdwmoPfXZnF/IbLnirKPoiHei1?=
 =?us-ascii?Q?RSFTPtaR3UmneGV5gX2rrjdAubWz4OmJee4BOrBeZt8bMffQ9uKhrnlBpQvB?=
 =?us-ascii?Q?WDptq7evEpD4mIa/SLFZ6azVE4RVcC3jJTi7KN0TiSc9NLaisa7GzUzoSaMb?=
 =?us-ascii?Q?Cu9plFn+vOK12TQKBR5ppzpGEewK35lZz74J/jVAy1pRNgd63r5vspYQvf8j?=
 =?us-ascii?Q?qioNDPwc83xlzny4fxcFeUEYx1Wyv/hpy6NMzQuR3ZfXcL9bVhNUiwtF8qxV?=
 =?us-ascii?Q?LCNL5SQaR7roBQBexuqfJMUMfmUFe3Ig2N2lKIy4SBTOWfpwUAR+soxcYiex?=
 =?us-ascii?Q?AGTjpFulZp49Aqrkl1kEu0E4f0Vb04kyOhdoYZuDpT58TeO0TacaU7Jly/bz?=
 =?us-ascii?Q?NMw9imlR/e5yi/+6SgQw/rln8FrMJn2dXzJ94QQ7DBIMEDBpa+yJSaAkD0/Y?=
 =?us-ascii?Q?M6lMuUb/rSwOPbpB+6kNwVoXtj1KYjMeI4LOSfpoHPvKakqPV0VM4md7eCY9?=
 =?us-ascii?Q?2GYHp6mMRtvkZ1yYOB1Y1iyroBlsCE+EmoTz72I2OSKgTMSI6R/HvLFNRM9o?=
 =?us-ascii?Q?8Ed2C9pyLg594ANouSSXl+HQRBZTaPpjQGJ0nIjsvhqEwqAH4TUKzczcVfA4?=
 =?us-ascii?Q?ZjQIpew48ibMjZ/pMdgUfaZgV2F7FNzDjN7V4Y8ZaMc/yWfAcbCCLkZhK7XH?=
 =?us-ascii?Q?gG+G1hisDADiPhQs8xX2mcj/eyIKPZ4uMu2xRbEfm4iaIc9jtOYTmdcKQSiu?=
 =?us-ascii?Q?dj/D9eXcT7dB0juZ/nTcN05j507uUu4ryC4f0Q9/Unr5nCECJ3ooplxPZaNX?=
 =?us-ascii?Q?+zi/ik3TgtGivaCUQA2r/7+REDvxlG3QGTWTrgsBdcFMyUZuk0R3YYLuCcSA?=
 =?us-ascii?Q?BxrE9bEAZqE940KugX5N+cZJDQcbKP+WF9GqOjG4O3NvqK+nm0eFJ0GEfzlJ?=
 =?us-ascii?Q?hycbrm4lsIYRZ1tf0ZBPMLlU4kbpuv0iZ+Wp1E3OZg1JOOIsA+UzSwrdF/a9?=
 =?us-ascii?Q?4ATsr41tIIQqsSdr3vfXqM3XJuMPzi2gKdFkOqXxOVYy5dYiuAaO3alzOKD/?=
 =?us-ascii?Q?JQ24C0deSFK2fC/3Nvk+TUVfX7IsW/wtFPLbtdd3l7i8L7oHMCc0X1YpaBec?=
 =?us-ascii?Q?mnoIsK3VxxzDsNBmVMtZ+C6xuvSBMjQ2+knOzaFC+ai3Zr6S7d3eaJvg2pcR?=
 =?us-ascii?Q?0s7umaerDAODYRWDqt4p1zQNEnGiqT1vL3qPVbhJNrDtFL2KsF/kSnRkox8J?=
 =?us-ascii?Q?EM3Htu4e+kR8qbfDlWTqg5pfCGSrhVW2PpQPSnYeAl8Bey/pgwG5uakTQAA3?=
 =?us-ascii?Q?GMANafwILcru02PQPbWhgiLAdbxXlvf3?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+VJa7WJtQVWVF/NfhF+3DZhCBMofn9HDnNp1nBTLvex96saYt5jPn4UwpDsO?=
 =?us-ascii?Q?XtGLt1YwI7FAbh84tSCZsXPVQB9LPYJShWKDdDObsTrkm6PLJRPMTnur8g6V?=
 =?us-ascii?Q?51ED1Nh03Zz5XfFEvpH4tq0nqS8DZO3WOSY8iViyc67XtOpCkla/WSeBwPTe?=
 =?us-ascii?Q?BBY4ZqmB400GozSufXYj94yrFlzK7CFR+hTzAWnvumbfsz4mlBNnPEVulSZu?=
 =?us-ascii?Q?Dx6LMtSCpR7KLfg5zCgwFDMacfQL9JbZ6/TxgeKghsDHLIQL0w3OOLzVHxPU?=
 =?us-ascii?Q?ZIvwq1ijEZbceoC4sHFXHv0QKuQwKZArX07WLXSSJIjQozRFX6qsVk7aSggN?=
 =?us-ascii?Q?tiPYMHy9oARvjYUw2x1Ug3GmLYhWcdX62m6Sw9RKZcB+p1u+o5nim9lauCxN?=
 =?us-ascii?Q?5WduKtzWuVEcSgNWZtHYd+Bx/sVTN37gFkPl+qLOyOEbFERZj/Rhkj5qHqAU?=
 =?us-ascii?Q?80eNLf93CQC6DgXwpeAPARs/zUPh8bKmZUT0F9AnNCLcGM0PhXbt/uvo6PKU?=
 =?us-ascii?Q?O9fqD4ueBBBTpAijK4hnNbXB7xiFEm5CQCLr2JN89jLPj5SQhoWLFzbUlXKP?=
 =?us-ascii?Q?+tIVwNiuBQwmTz76Ezu2HAkmqTpD2SMrNyv+oVrhwPWYExMTYDsjUloNXtnG?=
 =?us-ascii?Q?UXKqLp+Xb3hOutwDuCGEJwqAv5GMP/3wB79NNshUxVG5wk5NvkFZUvxvfe88?=
 =?us-ascii?Q?+z7ItpqXFgidinYXHGan5IwKQjr/oLiEv67pKpsQxbrNSQhtwZTPqhEmYThn?=
 =?us-ascii?Q?d522y/OIg75k0GGiTLKA/MIwnC0qaVj5t2QDq4+lh8vuvumxQ4YqG3pqHYQX?=
 =?us-ascii?Q?epPjn/rU0q28KvdOg8/D+3QVJtYxK3SSTQcXDd8raUvIq2gwMpq08gQpvWDn?=
 =?us-ascii?Q?rltnD/9NURblwzplj6VptPjQDunS0Y095TOf/YFjkMu94OpGno9deuEuyRE4?=
 =?us-ascii?Q?FxQWE91eH+U96nQ8Ha3I+Hzdbo7lcg3lpOmT7F4KE1k+TbHctVq+jkq0CJtV?=
 =?us-ascii?Q?VN0l/5x1C+k/phEcMdL5JmcPYkOrZfTNZRqr2Ug/Zp9yDfJ2rQxzk59ZVvt6?=
 =?us-ascii?Q?82HIyKMm0szRdewNGG3xRJNPAA06lbzL385RGv5nMitsXWltbp8SqALHKfKy?=
 =?us-ascii?Q?+Va5mYZlF1O95Tweo8yYusF2SE1pJiolkbJsFzAM9plrILY4uAL9HVN2Sp1n?=
 =?us-ascii?Q?jAXLZCqqozduH8FNQImpqG49/893ly+ke0pq5Ge2cBuoGu5zLCF3ZhBX/jnq?=
 =?us-ascii?Q?7ccw02uYYcW1gmZ7b33bEtX11ldg4SIgD/jrXtcD3jwF6tu7fuPWgOcj/wMk?=
 =?us-ascii?Q?yK9+2FFnqqaAejxYEFjnTZSU12U5aJ6ThtfS7Iky4zpaAmscekid90GVqQEX?=
 =?us-ascii?Q?ZiKA9y+5Tm4Az+8oGmCoy4tnCGeufOFlSZeirxXR+34wc1Lc28pD/6sG0Dgu?=
 =?us-ascii?Q?aCddJprPWy4QIpscjn8gzzLY35N8Pc9VzyeaDSTtQWAMZMcmkp71nJ3WQB8u?=
 =?us-ascii?Q?lahuprrxgzxZSveOAwsDIlL7E/Ba2uYcfogRJd5LhZe0DQkmwpW3yTVzxFxq?=
 =?us-ascii?Q?K/XAVF3j8lR/e+9HWVNjAam7Yw01FU3jphNqKafn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 793105a2-536a-4cb4-d697-08dd3b95b552
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 10:07:13.4504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v1fI0e6TnYIqiustShhgbeXr1nUIwlFml3EeM5x6kJseaX10BqMHzmzanzesgRe0a2BsJGerpwJ9KAEkckJ4qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 11, 2025 11:32 AM
>=20
> @@ -294,7 +294,9 @@ struct iommu_ioas_unmap {
>=20
>  /**
>   * enum iommufd_option - ioctl(IOMMU_OPTION_RLIMIT_MODE) and
> - *                       ioctl(IOMMU_OPTION_HUGE_PAGES)
> + *                       ioctl(IOMMU_OPTION_HUGE_PAGES) and
> + *                       ioctl(IOMMU_OPTION_SW_MSI_START) and
> + *                       ioctl(IOMMU_OPTION_SW_MSI_SIZE)
>   * @IOMMU_OPTION_RLIMIT_MODE:
>   *    Change how RLIMIT_MEMLOCK accounting works. The caller must have
> privilege
>   *    to invoke this. Value 0 (default) is user based accounting, 1 uses=
 process
> @@ -304,10 +306,24 @@ struct iommu_ioas_unmap {
>   *    iommu mappings. Value 0 disables combining, everything is mapped t=
o
>   *    PAGE_SIZE. This can be useful for benchmarking.  This is a per-IOA=
S
>   *    option, the object_id must be the IOAS ID.
> + * @IOMMU_OPTION_SW_MSI_START:
> + *    Change the base address of the IOMMU mapping region for MSI
> doorbell(s).
> + *    It must be set this before attaching a device to an IOAS/HWPT,

remove 'this'

> otherwise
> + *    this option will be not effective on that IOAS/HWPT. User can=20

Do we want to explicitly check this instead of leaving it no effect
silently?

> choose to
> + *    let kernel pick a base address, by simply ignoring this option or =
setting
> + *    a value 0 to IOMMU_OPTION_SW_MSI_SIZE. Global option, object_id
> must be 0
> + * @IOMMU_OPTION_SW_MSI_SIZE:
> + *    Change the size of the IOMMU mapping region for MSI doorbell(s). I=
t
> must
> + *    be set this before attaching a device to an IOAS/HWPT, otherwise i=
t
> won't
> + *    be effective on that IOAS/HWPT. The value is in MB, and the minimu=
m
> value
> + *    is 1 MB. A value 0 (default) will invalidate the MSI doorbell base=
 address
> + *    value set to IOMMU_OPTION_SW_MSI_START. Global option, object_id
> must be 0

hmm there is no check on the minimal value and enable the effect
of value 0 in this patch.

>  iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>  				    struct iommufd_hwpt_paging
> *hwpt_paging)
>  {
> +	struct iommufd_ctx *ictx =3D idev->ictx;
>  	int rc;
>=20
>  	lockdep_assert_held(&idev->igroup->lock);
>=20
> +	/* Override it with a user-programmed SW_MSI region */
> +	if (ictx->sw_msi_size && ictx->sw_msi_start !=3D PHYS_ADDR_MAX)
> +		idev->igroup->sw_msi_start =3D ictx->sw_msi_start;
>  	rc =3D iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
>  						 idev->dev,
>  						 &idev->igroup-
> >sw_msi_start);

what about moving above additions into=20
iopt_table_enforce_dev_resv_regions() which is all about finding
a sw_msi address and can check the user setting internally?

> diff --git a/drivers/iommu/iommufd/io_pagetable.c
> b/drivers/iommu/iommufd/io_pagetable.c
> index 8a790e597e12..5d7f5ca1eecf 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -1446,7 +1446,9 @@ int iopt_table_enforce_dev_resv_regions(struct
> io_pagetable *iopt,
>  		if (sw_msi_start && resv->type =3D=3D IOMMU_RESV_MSI)
>  			num_hw_msi++;
>  		if (sw_msi_start && resv->type =3D=3D IOMMU_RESV_SW_MSI) {
> -			*sw_msi_start =3D resv->start;
> +			/* Bypass the driver-defined SW_MSI region, if preset
> */
> +			if (*sw_msi_start =3D=3D PHYS_ADDR_MAX)
> +				*sw_msi_start =3D resv->start;

the code is not about bypass. Instead it's to use the driver-defined
region if user doesn't set it.


