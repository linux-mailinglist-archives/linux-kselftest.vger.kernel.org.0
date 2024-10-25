Return-Path: <linux-kselftest+bounces-20624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008459AFDA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 11:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229B51C254F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 09:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4791D222F;
	Fri, 25 Oct 2024 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XN3MUL39"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D41D88D1;
	Fri, 25 Oct 2024 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847061; cv=fail; b=ncS3GZ7gJ7a8X76yfUSjBwnlaDL2ZSlr0At7lCj/bgBTYP5ylbFnkwJ3+sdIiTbfYDkMdMrSanW8jR1mNaJVFIPYPPL3+8PHRRiW0sFv9ezAZc2xGu9s3ZTRneNxut/JD7r2cMk+T/NKiCdpZMBRGcQD15QKYQmy0K2wj/J7PEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847061; c=relaxed/simple;
	bh=WtDtX0kVqR5w0Y2MQgA/YawFAUeTJbe/LTaPX19n5wM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ICjpaPoXCwop9KwSwkAkPIsGqE7R9wt43tnkm4NUBbTlhrCYlUyx5sO5ZbnQgGI/yW+ncrVFts7Du0tELQbVLFigaDBC+skr7qiIPS3K7s/MS0TjwnUeuHaQ19OijwVPJzMmIs8UCltXq6s5GLW13YaSlDqyPGBnbftk+yoDI/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XN3MUL39; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729847060; x=1761383060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WtDtX0kVqR5w0Y2MQgA/YawFAUeTJbe/LTaPX19n5wM=;
  b=XN3MUL39ODFKXLBRGU/iVgP1DlOeiybnj3d+mxcCyPT2+Ru3jL6AmNiJ
   a8WlJuDLk8MFamY1rHzAZEau8UYuAbCp199CAjZhQdCpPhVutERVXzOcS
   2VAbVEIfbdSjKEgUHl9BiwNDU2bVYWlJv5UMNU9u6Ih2aRAX294zu6dOP
   vrB8so2Hx/1PZrrTwoUEVQDPibfJjJK0cV9FIp1tdy3EvDBZIpA7KjE45
   9lfFh/GN2duLo2qCaF3cM/TXPy8jO7vY/37Sfh4xRGMbKjsoIiYsrn6fP
   BXrtQIFn8nEg3oqTkx9dEbqNrEamwrpTBzwivTICodtMvFC96oaLvyR+D
   A==;
X-CSE-ConnectionGUID: mFjPLDu7TcmBblluMbaEcA==
X-CSE-MsgGUID: OTqLSwkyTyK57cVW5Q+ZOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52064958"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52064958"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 02:04:19 -0700
X-CSE-ConnectionGUID: 3vNWbaXNRvuMrKyiG7zlHg==
X-CSE-MsgGUID: s6wGC++TTFm8mg+ynEVfeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="85651406"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 02:04:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 02:04:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 02:04:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 02:04:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmRxP0P6TlGbJkmYYMgLD4mHP+DzVGhLvWwWc9og2wSRdJff79Nluh5/Iy0IwcvnvbEGE56iqmMWi6bvHnCUPgsuRyjblCVDEpbGzEwQ5J4wESCa9T4RV1T/OLkZaO/FR+g1L8I1CFrRFNtQCYRCuYutB4PvVKohrteOxf6nYHvFNc2WsO3UUuPLVgOx3wnu+wQPXrG8tdXS70VCEbUCg3SQlSyHJ9VJfwcbi7Fag9iWYkwS5XnG8zp2jVQAWscyr+N2zxNqPRp1TGWtE39T1okyz16EaycVaRr2zuISjoywqY8r2EUDwv4b/VocdPPUxrRvaIRsjQ0v1im6hs183Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUvjhaqWFz9546lafodPay89Na/B09CoftW5QVh6SwU=;
 b=nFYNTFsXNNqyfHQS6pcxb9hZm+0x3z2T9FZ74KqNVx58Vt3wFUiRKsx1nj6NM9cd/68WYfnBEFfJIyIxo7V/wDCdl8rfWA3vK5sZgrXoakuAYZPBaGcoHW3OlAjpzCnjmDHj8CaMjKVbwV6pACK5vkt5nxIylNbo4Y0fNW7wxkQLHTVmyJEfdehIolHBr6lo08LQEaZgwFJqb8Vxu0lhy6iqxPb6M7/lOx6I2gyCg4Oqrges9RQnz2VhPbnJYeAg+eUdH6klppTK49EfIXavsLnkRd0NffAG3gk5ryFP3pbNPK7Un1fkJAqDZwPRx8wI10rQVa/oM/X0YuhflG6npA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7433.namprd11.prod.outlook.com (2603:10b6:806:31e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 09:04:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:04:15 +0000
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
Subject: RE: [PATCH v4 06/11] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Thread-Topic: [PATCH v4 06/11] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Thread-Index: AQHbJBg51PY4d7qMI0yrivAhGqcj1bKXMN/A
Date: Fri, 25 Oct 2024 09:04:15 +0000
Message-ID: <BN9PR11MB5276BEF20579F3CE7DBA15908C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729553811.git.nicolinc@nvidia.com>
 <ba9ce9b3c8a93c9c790fee52961d075dfbb63ca7.1729553811.git.nicolinc@nvidia.com>
In-Reply-To: <ba9ce9b3c8a93c9c790fee52961d075dfbb63ca7.1729553811.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7433:EE_
x-ms-office365-filtering-correlation-id: c01a45bd-9b6b-4618-4ae2-08dcf4d4001a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JQxgBX21/3SVJl37Ye6PgnpfyjmGW9qj5pPlrtGh48RZ0HHO6dJRmm/5M1PG?=
 =?us-ascii?Q?GqfuybQ6sJyjCqWqMQouA3+4klP9z3WmNKWgyKo7gI9Zvzbr+gb8bHqfwLsx?=
 =?us-ascii?Q?foKpDcNlo7Y/zAc5uIYGyt1i2wZIeXBAmMA8V78d2D3rc41QrGvdJP0xZNxA?=
 =?us-ascii?Q?Xx7c6Kq9z54ZsfrKNq6sRSnrrZdMDfCpCqu35/SoWB8OrQAhFgMfIlQY3t3K?=
 =?us-ascii?Q?5bU8UMCtt2fwgxbKnbgeNRKtBe5d2qSiCtRvoxoUa1vsJkO0R4iVTuQicsqv?=
 =?us-ascii?Q?DyxouHizQT1vWK23d0WedQw2mNBmzte/w99p48C4qzoO+Q4qzuNGLYaxwc+8?=
 =?us-ascii?Q?UJlFp1zsLbGP8Ry2wR7jR/bUgM+CATQz5AeP9rsBPzzKRdIHM+MBU1Vp2cSi?=
 =?us-ascii?Q?JIccJVCgKcTKXgqmMBKO0EhxK7IajmDgtqrMiBuXbcVC7cCPXv2wlcLNRPLX?=
 =?us-ascii?Q?Aq7kowMz8dSvx6XCrHoSh3Vpxn6rKWVL3bFzq5puAgI9wF6ABUQ9Fj85nWg8?=
 =?us-ascii?Q?mwzVNdCnm3tVHZhpfKMSLa3Xs5CWcGZMjpYFIzB1MHD6d56TfT6JWLOyCIdF?=
 =?us-ascii?Q?xsYV73kpHOKJv/DhzBhDJvvVKV/LJQntDo2Pd68kcT6kUfnivNorCXPw4w8T?=
 =?us-ascii?Q?tYuMzbgQ4JQg5O+i7x+eur6biJGG17KiFyXDgOy0BnSKqcbr+WSoZdvCI6Zi?=
 =?us-ascii?Q?05/tN7qK4KOPwWFEA/AoM/+Xn7gBbu16eEpYgRfHiK5eo0adDm2US424uCSa?=
 =?us-ascii?Q?MyJ8blmFuUc8g4DHrG9Pvdd+ayJcMIw7UkWEsPdJXvs+QEdNGHRnlBCP4YGY?=
 =?us-ascii?Q?r4e04ikUX9qiq3EQTxiPbFJFtGxgPVtRlHKRRtzC8Jnra7LfbI0Rh9Dumbc2?=
 =?us-ascii?Q?rLKxs+AtARv5DkF8+Z71zZSg4rbVthQF11ipwNgFHx+Bi5gXDCoa3RbeYbPy?=
 =?us-ascii?Q?GPeQshhbsOGIWOQhOM2b/vT9by/nSfluWf6I/3YqoAQCKYUkiNB2cafZsA5q?=
 =?us-ascii?Q?tVj97zIQVLLw6jZoZXJhVjK+YNK5bC7EkgxjW2EoJ+kb7ZZ7XyBiYg+8hUw8?=
 =?us-ascii?Q?GJqSgB5iDNL3557TimkkjKmHliA5HU53zSM9oqIkj/LmLXIaMBMbwVMEAeKf?=
 =?us-ascii?Q?ESpb6aQ5fcAWT3XLQinyYvqG1Llixiri02GTEEvmjTXqFN22t/MSs7Kh4jUf?=
 =?us-ascii?Q?FpEhpvZHmgb4yx7SoTXpHbXOHyfybnJaPZxd+rOO524bmoJxj1jKqM3p6Jev?=
 =?us-ascii?Q?UqSw8xkHo2unRXy+Mj+ha9xZtB+L8AYsT1vKP72+f1XcKPp9zMSl7gCTjwa/?=
 =?us-ascii?Q?tyAYjgLRFORtD9V0iB0DO2Kp1ogWTUu/nLvu2+SEzAOPvkhTe0olV5TOM/6R?=
 =?us-ascii?Q?kWrFB5Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gU+C4sxZUjBre8Oz0MYMDi4HeoQsH0MOXSMlVMmOUaJn+j3zXHqOvli7motU?=
 =?us-ascii?Q?hfHTKybVZGNCIKL8/Wmp3dvyCj4ob7zYJ1VjG5f3z5G0wwr9A23CkwNiaUGa?=
 =?us-ascii?Q?3PNur4ZWbEl3bNTWD4TmaYBI6rsIV8oZ73elQYjK5sgrLOd8H3EA72mdeYm3?=
 =?us-ascii?Q?AB9CIu5h3xIa7h9NJx7za5r00CzdU5OL3B/3L8RRJX37nHvDfpjn9BXGzot1?=
 =?us-ascii?Q?u2URhE6COZHCN2kX759DnFplcIJQ/ArMnb84yr4nRAYVVD2UH7MQGf2sTlxF?=
 =?us-ascii?Q?339dilr8wzOByyje2jHqUDf1XN+j0w10xPXYVdxVs6VJ+7GiT8kUmCNLdfNZ?=
 =?us-ascii?Q?t6o3h9BiNyZ9Laitow5oduWneQFeiVdB4y7H8vXF4DmYKu470CF6BH83oFIF?=
 =?us-ascii?Q?EssFnk5vTa062D8fntawGkUsPhXhKCTkZsfOOLePfdojDatdbiv/r5ayM6BK?=
 =?us-ascii?Q?2VKxOagHzeONb//gvw4soXUy/CSX2oulkri6M0T3DJRNiFQ7l6WccFeNdkLD?=
 =?us-ascii?Q?H0g8m7J4CnVqHf7UasjmQQSPg5wi3uJ+fduoEP2kNd0l4J06fuR5CPVFiBM6?=
 =?us-ascii?Q?JBvVIozdLjYSq70nTIKpjMxIL/W2gMXbdzy0v6Abru2iRQMgRbzqQ/I0Ilqb?=
 =?us-ascii?Q?iUaonG+Iv8pgZ6art+w3iQphX4fc8z5lLBgcpsX84/1iQ/KFsEg1chhGscR4?=
 =?us-ascii?Q?ILtvwSucoaohRBYSv8S8lhXc6KrEG0Rqcw1/Cis79xKfo5udQmhhO3c8j6QH?=
 =?us-ascii?Q?0VHEkrAI/3pBQiMH4hogXRYtmUnWsGL6CdkvWyKJH5LuGgfq+5/4/CGOutDM?=
 =?us-ascii?Q?+aaaWh/bML0T3XWLyymXNc5Xwia558wfg+W7Hx7Lx5xZz7RBVAOsUsR4oTgT?=
 =?us-ascii?Q?RQdC1hwaBsL3A+CykJapyt3BGEnZrrjR1F8k6JPXnMiz88ebYhyrZH9U5edO?=
 =?us-ascii?Q?VzybvmA3wCUGa1d+VgMkil87vg+TKqo9K4k2qhGXT9MZMimpNyNs6+4loEwV?=
 =?us-ascii?Q?Pbls3lJUkvGWPr27YRXDfk63bu0/k70WmbCMjElCM0m3/eU8lAHTMHJzdUui?=
 =?us-ascii?Q?RSoQeG3TLh6/8RLyGqfjtYag4qBhQo5+qNJXcBvd9IRy36/lQQIdR2ETvDpv?=
 =?us-ascii?Q?cvlfbwb9S5FdPrhYx4Lm0ca/e3qYidmfozSNlJckQnlv2ukKpnbWMHp7E+4l?=
 =?us-ascii?Q?9tctQeH0/9ZYJE+7yqRU6dEaaLfGHiAITA1RxU4/Mh0juy2JbFnCaQo19775?=
 =?us-ascii?Q?GQWZ5tlTTzjNnZVFV+MWI6hAt8ZuJ71AmMTwDP8PSELBVYrRKYfJQ8S0K+1z?=
 =?us-ascii?Q?iU+BES6zLN3OtRKF8NyFq4twClqxW2jyO4Pxq8AIMfiqynihHwGio3YAuGk0?=
 =?us-ascii?Q?vJQlHwVn9u2u762fReZ4Lo2zkrVtR4mNjK/kCMvHYIs4v09M3CDFr30q4joQ?=
 =?us-ascii?Q?I97OxjCKPizkn+olACgKcoeuG8aetIRrVn7SxGGk87hVguoO/97CHVzsPQvd?=
 =?us-ascii?Q?xdqMZG6na0wROWcxbwkOIZiVie+V5CCj8iPmQPgcOUUoIAZ21XW2usYMJK5U?=
 =?us-ascii?Q?GZ2Jh83DeRw7fn4mE4vtiTpC0Ce1SYc9Lha0QIfW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c01a45bd-9b6b-4618-4ae2-08dcf4d4001a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 09:04:15.1610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gg8D4xzCg/WuXE4XHV4ITPeegzrZfa60OkFcw59bQaJHanzqH2JdW2SL489fCB/NsjV8BEzgxcDOCapMkCGXvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7433
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, October 22, 2024 8:19 AM
>
> +static struct iommufd_hwpt_nested *
> +iommufd_hwpt_nested_alloc_for_viommu(struct iommufd_viommu
> *viommu,
> +				     const struct iommu_user_data *user_data)

probably "_for" can be skipped to reduce the name length

> +{
> +	struct iommufd_hwpt_nested *hwpt_nested;
> +	struct iommufd_hw_pagetable *hwpt;
> +	int rc;
> +
> +	if (!viommu->ops || !viommu->ops->domain_alloc_nested)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	hwpt_nested =3D __iommufd_object_alloc(
> +		viommu->ictx, hwpt_nested, IOMMUFD_OBJ_HWPT_NESTED,
> common.obj);
> +	if (IS_ERR(hwpt_nested))
> +		return ERR_CAST(hwpt_nested);
> +	hwpt =3D &hwpt_nested->common;
> +
> +	hwpt_nested->viommu =3D viommu;
> +	hwpt_nested->parent =3D viommu->hwpt;
> +	refcount_inc(&viommu->obj.users);
> +
> +	hwpt->domain =3D viommu->ops->domain_alloc_nested(viommu,
> user_data);
> +	if (IS_ERR(hwpt->domain)) {
> +		rc =3D PTR_ERR(hwpt->domain);
> +		hwpt->domain =3D NULL;
> +		goto out_abort;
> +	}
> +	hwpt->domain->owner =3D viommu->iommu_dev->ops;
> +
> +	if (WARN_ON_ONCE(hwpt->domain->type !=3D
> IOMMU_DOMAIN_NESTED)) {
> +		rc =3D -EINVAL;
> +		goto out_abort;
> +	}
> +	return hwpt_nested;
> +
> +out_abort:
> +	iommufd_object_abort_and_destroy(viommu->ictx, &hwpt->obj);
> +	return ERR_PTR(rc);
> +}
> +

looks there missed a check on flags in this path.


