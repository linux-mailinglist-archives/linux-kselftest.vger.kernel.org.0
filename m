Return-Path: <linux-kselftest+bounces-18579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16974989BBF
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6D6281EF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4902815CD74;
	Mon, 30 Sep 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGcyw6tw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1615C13A
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682189; cv=fail; b=eWTopxA9mDTqKIEVEOCSst6IUPMs5xKHlO3v1cJ6n2Akc+Linv8Jrnow5W+nybsXutGWX1xUA/nWgaL2cLyKpB+bvRWvx6tTeMlbLFDyjufdxeM4NctIT4/JVR7Ap0ZOVk0bwvvB+UiarPk/C49KBybYSVaRS0LQhd3AIJL6mnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682189; c=relaxed/simple;
	bh=wch+FrRTHWEEachD+InLxEuAWNlVyG+1BnxZUYwHoqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ipwIwV56GxXqbcjbtYkULizGUtlAgRzQo8l9YfTWa7lzs05+WGkhgdJAhtFSC1oeDVufezjXkN17zb+lF/glMrK9QShhO5uk71t0T+tbrFcJMm5v9alxYCdEOIYAJioiHcYRo4SE8cL3aTNXcSA6203PxhvbjCBOelf1pKU0FZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGcyw6tw; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727682187; x=1759218187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wch+FrRTHWEEachD+InLxEuAWNlVyG+1BnxZUYwHoqU=;
  b=BGcyw6twkbvK0D4TFaQf7Lt75uyq4wVsT7OO3kvZcIbj9h3wgVACIKO4
   8afUOv/dk/RKxeC8O1YImK14Vc/59zpLRgBsWJrF5crZ5Bu1S9Wj/kq54
   jsJR4fN9+46621fIxVdcwNG5jKBG/8vNZft0u2ZUGlcoHEP6LWjWGU0z1
   RWnY+zIh+GjVlhlFUNC0ZDxF8EQ+z8j4qMBop3dYg1Rr+YJQH/CJSc/JS
   q17Yc1G2gSdTdE8PfDIfhfnmvqHv1i27z9Bq7+eqfovIsEj38w4W+Yq2x
   v4ygJIZ4LE6iIt8lEFd/4ZC17ElshSF2tI8G+1XtSmQ2giE5KCgmtUW1R
   Q==;
X-CSE-ConnectionGUID: Fa6BmCINTsqQwAnGQYyKrg==
X-CSE-MsgGUID: C9JjWJK+RKGOqY59HWinNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="44218145"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44218145"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:42:07 -0700
X-CSE-ConnectionGUID: lkO/G9IwS+Oj7bF2nVlu3A==
X-CSE-MsgGUID: imyT3O6ESWeecY8xG7FzPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78033695"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:42:07 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:42:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:42:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:42:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:42:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNDLMVapvo1uACis0RXyTRWJNXo8vIGdfNId1GSCDeqWDHpPjENvR4nMYK3MRWQwI5I/O/82Jw96JraJ98rOo3Wg/U2Z1Zs5K5LsJlGoOtdvDsgxnG+VKzmWbkdY1YHffr/4YrHiMf5SptlbDBzOzo9h/SUJYLcexjvdezbfKrnOUWwkYsDgPlW3gp0RGMwbtTYcKaITQpbpy98bcN3FayrJRiBSOLZlk6Yvv/93zpMgOgU05CrGS1JbC0BkjQswTCkM6JT52ZdprLZSLjjYcmU2SbOkx2qW+nNkaVw7AdBG1Qvhe+GpZfPwQ8JJjrPEUx9+IHHnxjwxsrY2O+OMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNYhxqiHMUxT5VikaTBL6p0imsk9X8LsdGo0ffmdcQM=;
 b=FrF72N8gnzrU2pDiXyfCJ49gJ4qshd/ZZ8C+HOH2PENe1gGZspx6fsZjC+Z/JndqagAX2RHpDIoTS6QVl0hWgAa+OY2DIGmXHZnZeGsKJXjy4KKdQXvNczBNZqqEuFcLqk55vU/XONBlYBFvkJXlAZ0l58nSjK/2Zy1Iek+5kcRAr3jos54ZIAUm26lGsBLyTBlDVep97AYiF9k8RDiIBa4eKlRpyJfFayrboTly2JTQnwXWuQ3lmG9wdHCseCFvcFLBEtic5t1p58xMUAI6D64rybBf0hljDwFTJ3V3w6DaOYGYUoRv8+XJC2x7/u6SDqF+zrDJAAfbp/dli4WPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.24; Mon, 30 Sep 2024 07:42:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:42:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: RE: [PATCH v4 02/10] iommufd: Refactor __fault_domain_replace_dev()
 to be a wrapper of iommu_replace_group_handle()
Thread-Topic: [PATCH v4 02/10] iommufd: Refactor __fault_domain_replace_dev()
 to be a wrapper of iommu_replace_group_handle()
Thread-Index: AQHbBRWUqqeMU/uIP0Sjj866E7VnubJwDWQg
Date: Mon, 30 Sep 2024 07:42:03 +0000
Message-ID: <BN9PR11MB52762A627637B09C8A9175118C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912131255.13305-1-yi.l.liu@intel.com>
 <20240912131255.13305-3-yi.l.liu@intel.com>
In-Reply-To: <20240912131255.13305-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7786:EE_
x-ms-office365-filtering-correlation-id: a59cdf19-1a2a-4246-278f-08dce123608c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5vTk+Nh79jYCXrbDS3kpPvr/SEGPM4ezZzgptf4bYRxTzKz6a6UwDs+YIR5U?=
 =?us-ascii?Q?PxVKkwWrGq1rK46bgfJfoomkCSjmH656hsMZCrif+zyndCS+JBM2w/Q2EiFN?=
 =?us-ascii?Q?cv/Eb/+dtBlY1LI38nId43wdDOo40I/HI68EXk3x/mil2veDLEs4zHdWgwYV?=
 =?us-ascii?Q?h82FxRieThFSk1UpOcR5xeM2xd5HwOQXgujTQLowNZR9KI4jTtB3Ou+H8FlJ?=
 =?us-ascii?Q?0r3f0oJKssPHSYYnw5vBIrsUVHODE5HVF7+tKSnV3Xr7ZrfV761MnPiqwtEf?=
 =?us-ascii?Q?sSsky1vimJbqUCvUs8mcHfh1xPNtz7O5WrvDmhGZC3fL3UnssIOXNM+8n9NA?=
 =?us-ascii?Q?c/Zp8451KepvW17G4y+36wJ8e4ayhl0UUHzQ9rJf047ydwORCfu7xfJd+ilj?=
 =?us-ascii?Q?b4LfZn5wzy6Homb1zPe0dMu+sXyNSeZxB08Yr5/WcUmHZxuRQOqrJLsEShpq?=
 =?us-ascii?Q?xXQMjaF28+VCq5q1YfG0aFUoV7OCf7ejeECwltO5i4uqwVCxkGfKWc6f2Afg?=
 =?us-ascii?Q?SlOHbJ9JZBZsdAwhmdvP9QkFhX7L78mMWpq7psh/RtE1X4A4K0QYznC7laL8?=
 =?us-ascii?Q?xrZ6hkaJ+GG1nA2qVjyyWo4gALSDPHEwT+zBnUjUcxVAw/OoKsXI0bmAK4sK?=
 =?us-ascii?Q?8ucf/m+eVqcTW2jv8DIXe9p7wVbHTZdCwcw5Pq0RkWtWQhhgV/hCGMInmbIT?=
 =?us-ascii?Q?QQHt7xRbijpaGv/fhvLCHUHaRH5KjJPPRVcBhrO8D2AWiejdP6ytoJ1mr55Z?=
 =?us-ascii?Q?lkNNlz7rtdJ3qj7FS/jF352O2r08/N1VEzfAkIF+LKPmBq36FFV89erhg08N?=
 =?us-ascii?Q?CEeaZnYu7WDh4klYoR3xMIlI+M8o42a5vwWsPW4FYhvGvD4jGVZZtiMjPq6q?=
 =?us-ascii?Q?/GOQ2qhlQd/TbXh2wjMTU3RD2xInMOkpwrlhid82dE7MX7rndL1wxgHuXWzn?=
 =?us-ascii?Q?mIhbpQqcMvr+3Wk1GEkLGH9y1KeuSoZNG9CYa5pRcoyEakxEHUCD2azu0tFj?=
 =?us-ascii?Q?x4RTVe10QJNl1qlMabN8dN06nyl+0jahJtPB7jENOWtuiZdHNdzmRVVVfb5F?=
 =?us-ascii?Q?kd7ksI0aitM6A8924zSM6SsqooaMskhcAt9SpAr0tUzhVGcnsbII6R6EuEEq?=
 =?us-ascii?Q?EXLLdMiDJE4YDkeFRnv0+jPIoQFOVoqMG/GlIz5H5J3pi1pcbdGRuajJ/Jzs?=
 =?us-ascii?Q?sgBQ9LFJxtg4f1FijXQ8c4hopYN1oEEOQi2wydcMKdVJ1MMmsuimTzns38yt?=
 =?us-ascii?Q?+t97Rs/coHsLerCFiGkCi7T0PMdFL7nEUGwLPCbo3EPdt8Mmw4udlXeRHojK?=
 =?us-ascii?Q?HpSYfDrPzRZ7TZTnAwr8PJJWquaMSkIOLt/YYnlupzhPgfsM5kg1Ee5O/dZ2?=
 =?us-ascii?Q?Nf9Mob+pLwsglnMkR2mg8rQzOMH33t0kebUxpqSatrYfqY4XEQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4b05Cl1+BQTVLwKGzeG13WaNI34UpsaVYj6fEk0aS6rYhT9Z3URaBSlMfGuF?=
 =?us-ascii?Q?2oZD5OJ9dMwLzNlZOdZA9R7dhV4truQOYAsusCQWwyiX1KeVkC4oUWihtkd+?=
 =?us-ascii?Q?Avmp6Yrfm+KZuOcnYwL9QxiNhBx66h1iZ2zi8QOV/Sja6uElWVGAVbWZ7YNm?=
 =?us-ascii?Q?IAT5I9N93SQ5kB+Xl02xCGJemDLVU59QVrQXpTdlwziaY96Uq+CLZcBv+FnF?=
 =?us-ascii?Q?psYbCDAhG8xFzKnsdTAl54jQVcdhJB1L1G6aLLpfN5nWm2T8t58kNd08jnta?=
 =?us-ascii?Q?QRVbVCjQwXof+aUOTpAXNlTdOUlYMlJhFBRFnEuTGO9VJs3Bz1sSpk3gLEb2?=
 =?us-ascii?Q?5VIL3DE9xUVoqr0jYZcme7KbhXOAr9UyR933mgc1G4mHimtpvczUf3M8/Ko2?=
 =?us-ascii?Q?P1u6yyRwzYu4q5rZH2ins5XRxinqwAO1tFOdmDgrNH/f1e0nIgxhjr7O4G08?=
 =?us-ascii?Q?vyQryNi5wK5jPNzxBhWGCTOVPbkmOW/mj/B6hnPvR9jCcsqmccoj6EjTZYYf?=
 =?us-ascii?Q?OPjBkdQvuMidtDEXyfUbsOw+kJkfhQ8ST74MeNCZ/viGeSitEW0WAcjaT55M?=
 =?us-ascii?Q?14tGKBFLSJAaoVpaLu/jEAvtgNqJzt3t9r56RzN3JOEnGvz1cNqR6y7mSkhm?=
 =?us-ascii?Q?SNjzVWyrvvjimAImAgQfVItW7CaP77VW7bZSv2AXfi6ZU3DGCtPkLmEcWi1/?=
 =?us-ascii?Q?Pr0HybvPwquoqsS1zcrO6C5R8HIqrDY7frBV1ULVjK7xZ0fC1bG4u1xrdKID?=
 =?us-ascii?Q?ZXRdkszI1XiUCcRY6x9mkN8iQDWremOtWMbRqWyOfln+eiZpMzIUU6lvu5jB?=
 =?us-ascii?Q?SbEkhjsE+5EihvuE8QNnCocpvS9wGI8dQ+Wp/ArBGmtMSafiHbIvzsR4/zJj?=
 =?us-ascii?Q?m4NvF8RcClRKL3NU/37Tm58bx4OFND2DuLk3dLrzxSdpByfb51voFemakULk?=
 =?us-ascii?Q?wPOK4gkq9cgysCJjWbqxLoZs+6yLwutKp6YcGeuOgfLWGNgnz/HoFjMJqFvL?=
 =?us-ascii?Q?8ASrg5ZNDYGs6HcpPgDuFFKI1Xy033P1dLQkK5Un17mD2Qz73aO8Tgybm+mg?=
 =?us-ascii?Q?mggi9A2XpFXK/V+V49jM6pko7b30+9IZBgio4fPaKEDYIf7XY6QkIJ9L3h4a?=
 =?us-ascii?Q?AFvl3EAKLOwBMWVXSon40XXPsrtZl9npOhPAdRhVbOCV8D2FHnn0QrbvnnkU?=
 =?us-ascii?Q?SNCHf7l/ogBMx6EiGJGfO/N2kLIIaeF8u4zlcCuXARYzBYbPAn3Xpaj/Yjxe?=
 =?us-ascii?Q?XpfUL93yTMFRhdIuUdSJkVQB5XMf4H7GLcci7OAgcAqe6lkrNyem+hOZiEr+?=
 =?us-ascii?Q?05e7bUBGKcpNeMivN3P8o4jBWDK+CFbY1rTxWkZnvjs3SbLmBXQthC7OEGHB?=
 =?us-ascii?Q?X7AI47bMog2spudruxk1Tm4pULRhqnDUj1QLjYPGz9vT/BDJYtfICSnyUZmT?=
 =?us-ascii?Q?0ulbWilIKrlcTypiFSBTUOKaX9k0VY0y1xnglmGha49nVIX3fQalo2AyI0h7?=
 =?us-ascii?Q?bCNgGUNiqXy8WCbfgG0c8ZmtP5KAj94YTGN/3DkqZ8VyzVASmj/0ebQ1I4uU?=
 =?us-ascii?Q?Z/yhI2vBkld5c/3cS7JXuTagyiWyGdvmfE2QD6BM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a59cdf19-1a2a-4246-278f-08dce123608c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:42:03.9205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SULwEthk1ao8RdboTHH4j4EXa6fScWuqETEcBx/P28z7qI1OzvAiqwfYUWmB3RO2fTAdUE0UU5mG7YE0JMVEVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:13 PM
>=20
> @@ -191,13 +187,25 @@ int iommufd_fault_domain_replace_dev(struct
> iommufd_device *idev,
>  			return ret;
>  	}
>=20
> -	ret =3D __fault_domain_replace_dev(idev, hwpt, old);
> +	if (hwpt->fault) {
> +		curr =3D __fault_domain_replace_dev(idev, hwpt, old);
> +		ret =3D IS_ERR(curr) ? PTR_ERR(curr) : 0;
> +	} else {
> +		ret =3D iommu_replace_group_handle(idev->igroup->group,
> +						 hwpt->domain, NULL);
> +	}
> +
>  	if (ret) {
>  		if (iopf_on)
>  			iommufd_fault_iopf_disable(idev);
>  		return ret;
>  	}
>=20
> +	if (curr) {
> +		iommufd_auto_response_faults(old, curr);
> +		kfree(curr);
> +	}
> +

this is incorrect. The old code does auto response as long as
old->fault is true and replace succeeds. But now you make
it an operation only when hwpt->fault is true.

