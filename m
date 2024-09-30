Return-Path: <linux-kselftest+bounces-18582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B3989BE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2029B21D18
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945D316EBE9;
	Mon, 30 Sep 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cxl7mrah"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2A169AE6;
	Mon, 30 Sep 2024 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682564; cv=fail; b=LMbDerrC+L7+RgS789pyg75KMUngB//20qfFtRlKTtM2jAL6grvfRhbUnPIvR/9iPJd8b5LEpZH8fxYeW4iaMUWLg6iwcY2IXXnfEiWeT5A9HSWb5jfCGoISFtAYdnBeTdgHWvk1h2NRBjUvITy6WkEs4w1jC0DShPXnpCPukN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682564; c=relaxed/simple;
	bh=7gSSZa/b2Q3vLd9CLLvehUevp8vzAVX4C9Qq6fEuwLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k72Qi6uwPI32YPS1QoL3o6qBEBfFk8LEn1JOLUcxlNsrtrBZZ884I2QGOrWjAmclYT7XHWTSf59vCHNR/kwLwlHpsOX/p89qHTJloL6Ot6B0nNbkY+Tm5ey7OjoOjSmqhqsDODFdYWxhU2Q2tiqoIiJ9mtiIYnPVWHATOr6R+bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cxl7mrah; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727682561; x=1759218561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7gSSZa/b2Q3vLd9CLLvehUevp8vzAVX4C9Qq6fEuwLc=;
  b=Cxl7mrahEi1gNKzWozWaOu2PPxW96sd3pQ/G1FkWKhASxdDAHsGT3Z2d
   M+/AD56MhCbShxvDoiNRC+30VULIAvXixSBVNxvGxFipcNAeKVszXMz/f
   XzNkj0qK3ycTKnzdU4GER9B1CiySgHeonhHYlVg3SyvdTCcL9MFnZKacB
   sOcNWQ1PwNl547FtnmWIZaPuXeQsPnkch6xhAkdN4gLbeZ2ey9M5shJ0D
   5matsjTwKhpcNlf523c3i4uuNA7mbp+Lqg/FjYoLinMvHdr9f1OhmsWnF
   OIb/jwYxG0k4UCGNH6ybp4WbWXdEo0Oqh8LLbm31GKJwcK89V4euRM7sa
   w==;
X-CSE-ConnectionGUID: 3nwVinM5RUayRprv5Oo39Q==
X-CSE-MsgGUID: Vd1nxYbXQuOpYX73yM8/9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="37316363"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="37316363"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:49:21 -0700
X-CSE-ConnectionGUID: aHhobB4GSw6aKax9i9uBgw==
X-CSE-MsgGUID: uu6lN3CRQgO6tqDfngGemA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="72800218"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:49:21 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:49:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:49:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:49:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbbdEaRYaEI51fXGsKYrQr75XUzMxe2N16+UJdsGE4kL6OZBASIuBAiXPHzF7OntVhwZiZRS/52jia1DKFwMIUcD6K3DXVpP5O7ETgPY4GTv6Bs1moJ2wlSe7HximnZu/q/mMdKWagx5De8LGSpbKRKb0sdsXhMSPftp56/6M3l4cZ4L648GpqY5rN/372rlfHT0J+2FypPgmC11kF79gcLQNZ/WevkDU6It4m8GgeWJQW80NrNG7FwzURpQhbSjoVKYTQQEotmL1/5+f8/RkT1oZjMlpVDYdSW+T+zM6n2LDJz9KBt4gBrkvJuI7d8NOvUGU9DX71CcpuX4uWJNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fI5DWCMliFgc68AHtqj84OTrAhjIcC8/7hwzeTZlEM=;
 b=OJIuvXGWxmIrgLIyq3POMvN2yLYmrSNePrtFWNm/SgboEmuWXO8u9lRNUN4rpwHU1MC199oAzATSPEwEsmnXMARd98dL6Rbr8zJgYpmN3SIF6LVsfElXg/lMq8m19ye6cBxhj7D1YXiV5g1eG3A9k1KLymtLCf+ZJdbmv40Eyq1wHxFsALtUaORp6tBctBVddrrJsSxONVNI7bOI0sQyRQ/OwKNbcn7D617935GadW4yLl9+3aeDk2Mibggi7IbpES3mXnGUM3GRUDIm5TkLXNsaMxQZPNNluwR3WUWYtTRHQ5XWWgd8kkJFQMBBP/1MAcJmwEcpUl6m0/g1I3kJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 30 Sep
 2024 07:49:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:49:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, Matthew Wilcox <willy@infradead.org>
Subject: RE: [PATCH v3 1/4] ida: Add ida_find_first_range()
Thread-Topic: [PATCH v3 1/4] ida: Add ida_find_first_range()
Thread-Index: AQHbBRYtyz451o0eFU+QSl/XoYeiXbJwECwQ
Date: Mon, 30 Sep 2024 07:49:16 +0000
Message-ID: <BN9PR11MB5276FB5E7917A110A25E4ACB8C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-2-yi.l.liu@intel.com>
In-Reply-To: <20240912131729.14951-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4587:EE_
x-ms-office365-filtering-correlation-id: d11a7110-0f06-4992-b48d-08dce124624e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JN6F7IFt/p+q+qe5ukzS24qOWLRBPkFcg8pphu3QZ8ZpxOcpKBtHRBiCd5yv?=
 =?us-ascii?Q?y97SshKkGD1GZV0GR+5lkmHM8NTmRZs42SQSHtIRyRVlTsSyk/5Rn1eV3uCC?=
 =?us-ascii?Q?RsNaJgL6vzyPa+ObEGFRMgMZzfopYMmy21V3WazhUPac8kFPthCZdR0LcXNF?=
 =?us-ascii?Q?VVQpVNeXm4KXktIFqAxpSAok1ZUOkO5+9jM8BbGc5LDQDMKyRHuWPzhjBeCY?=
 =?us-ascii?Q?Z4Lvk484JnfG/F5DlMUtHNAFXAqIthZO/StF6dJkxcawRIOtM/4G8jn8/MFW?=
 =?us-ascii?Q?n5Wg1rEZtHTydQUYJTULrhfbPtyOhvALj9eEep1UOAHpuhfypeUQjrd6lFoe?=
 =?us-ascii?Q?vadLxz/CWgtrePSKJqIykPhH5nBvbfC6ZEHLF2lqkzbLA7T+bYBGLIu1hqxc?=
 =?us-ascii?Q?SZxbp3IfOW2x+ZeAL6dnXV7Nyxa3ouW4vrc3uw19uWHPDtx6x1m5DEFTK51U?=
 =?us-ascii?Q?U+lVaJxvHMcA5oeoLvsQkbCNxl4Y2kzG1a+V8CcDfDjtsfBSsCeigWqek0A7?=
 =?us-ascii?Q?GPyvV22bwTxWeF1Z7Vbfj2YMjQBbcjKp4Kx78FoaWJsBdNNIzorBXWwblZAJ?=
 =?us-ascii?Q?jnPa/UbGbCuGrerc4wCNdBIoJuJmwRrMyHVDy7PAyHCtTEhr/6Jeq1YbWmPP?=
 =?us-ascii?Q?EGALpoKO9ZXpcJEIYZpqCDLExrWoVx0WzTPe+wcH86yVVoq9KzbynL3Qcx66?=
 =?us-ascii?Q?dZfcCQX5lKaOpP77XV7kWYI0JM1YM6LddAZ02HqBctIHlsa67Wtx7RKp8d3a?=
 =?us-ascii?Q?xxv0y5mdRa/25EagpzqeFJA9yre9qhD0Enxa5+uQJCFHWJ8zxZh0BiJBmlYj?=
 =?us-ascii?Q?uZldFU4gFigjLg0237yav9PAWKkciErMG72+LNyCWnnvQWrbuAbmESyUa5BT?=
 =?us-ascii?Q?Q5TzPlK5XAxiLTU5oZNjNfeVmF0IrNUe4HlfZrIfV6UQylvnwTJCFEAacc//?=
 =?us-ascii?Q?Fj/BB//sPU8eSMoMUTY3cMj6WE4PymUKVxFGO1mePrN4twADPzpuE7JcvW2J?=
 =?us-ascii?Q?SVRrt6l3R2r2LZf/K2KrKvgF+mKFAx7DFTRT1WJ3ZsFbqlCXB6TWGKCGQNDW?=
 =?us-ascii?Q?CUiiITBNf+BodLtUsoCxH4tGXBBOuT9vb0ldvRIAb19p24M9sIkCVZxz9DZi?=
 =?us-ascii?Q?haj5OM/mjNqlPnJrz/i55IW2r/g/nJdZe5Ty1ej+CGe6CgLBQpbJf92/tCBs?=
 =?us-ascii?Q?QlruRNKzwN90f93ECxTQMuTeJ64HIx/m5dtW9YUhCl0BlFUBKIXimjwzM/Bs?=
 =?us-ascii?Q?Ry8L36MKH5ZxBJn4v4i/zQomPq673M+nryO3N3pI0C6W6JSzp+FcnU8xDwGz?=
 =?us-ascii?Q?JywccBfYFvzZJ6vuiorKYKbGqk0hUDoRblQ6z6BeytPNoP2mYdQCcnXFwA1Q?=
 =?us-ascii?Q?XrXUDqMzrfiEGAi6RluR8EXMo2XtHmn2BBbSn7z0nWUcAotCcw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?28Zx5FXS3ma2U07jVNXBA3tKDFgsCEcDuXeYseNrrTuY/azI13auXrOCyR86?=
 =?us-ascii?Q?2aZ0rMsMoyQZhDKs2vVd/kQ1XCMqhCh94rfFuzurKziMErnU6rV9QJ5dHA22?=
 =?us-ascii?Q?IiRvSTSYAiDFMhYDUSRuuOD293EAgXeASR2SW67/3xmwZFQLJSTFgenu3GkV?=
 =?us-ascii?Q?LjaV8gC1Dr4nMwOLtaYpKkDeIOKLcseVuSLWPRpiw2TRNFNTA9F8NBz47AcY?=
 =?us-ascii?Q?ccsQdplStVO8OkKBkHG9j/H3UMAxBxpoXzfToCGDaL/Bey3z2WOPvWG44OgT?=
 =?us-ascii?Q?Xf8T4ElfNunB4NbbkMDB6pxpOcAkDPKTUoH1vlkqva132+XxdpabRrkZlQIs?=
 =?us-ascii?Q?+SWHsFMPqO3Pa7W4yNpuDdV76uC0BX4n8As3Wb8O6T8UMkH25/+l1M0sa6YB?=
 =?us-ascii?Q?R4PG53kchaSnJ1+2JJtM73vGf8U2HEE7b6dou5db3kh9oE2W9x6cz6LODajh?=
 =?us-ascii?Q?8VSZO+IKN7qSMWuYveqdRlpsXFUXnnrLEb32vMLqka9fX4y5sno7j2yS4MiO?=
 =?us-ascii?Q?I0wVMv20TA/wOyGzHuduGEyxtf+wLB441Q9eeI1VOAphSemChEMx1pnc9hIM?=
 =?us-ascii?Q?5z38JjjE12nHABpJCxp+7UnyzU9FX/OqW3YDdLnTwbOiP4yuz9ZUf37P/tkj?=
 =?us-ascii?Q?KW59AsW+nokSJQnsSJrSzCptHn5tTobtcxT8gYLev6akJq7bWufflgoqrn2N?=
 =?us-ascii?Q?ak8M7EBz+P52GTp9bgnrf3dgOBckvzw6orxBgBCuEB+SlURDKdixMaOu6FUK?=
 =?us-ascii?Q?+xiA5FN0MBOc/ZgUY+OtPT/twzGybJxjNL5u6ou0qs2q6yG9S+s8CgucExYk?=
 =?us-ascii?Q?W9hZX5+DeAJ6y8jh5+/ZnMxyQglZcwwN5E0ngmCi2y6uYf16IOuYFfwY6rf5?=
 =?us-ascii?Q?3Ci6pycmfS8yR5MJbmlknSzBaUwGMhklax7nuRv0XjzWeoo7Zn0q+ekBhPkp?=
 =?us-ascii?Q?D+haJX7nYYlOLUj/vBZp5tiwj1uYggV3bRn+GrDaLP/pRKtAusD3KTCA52g3?=
 =?us-ascii?Q?ZijYXGxtiNjhe/kF+YT1qn6eAoU5okopxlm5q3rZfRbWge/WIN1gl7ryde/E?=
 =?us-ascii?Q?wOoWUvJvKQ3YVKPkmNVQFcVMDKK4jio++T5SkQQbgvDV7qZdfLgJYFCF7o2x?=
 =?us-ascii?Q?GXXNyHLHfDeBfy3R/ZNaaes54BNhqWDlPlubrRlnRWSEf7kpgJxc0ZJ591+Z?=
 =?us-ascii?Q?9PgP0JnqiHIOXOIjVgjaAqQ7M2Kyn9Vtuhg2ziCM4bOMlCoSs7W1YCuyxQv7?=
 =?us-ascii?Q?0rQjjux4tXutlBsrADvTXfZQJu617cGqzJZb3xJQ1HeMynQVgqkQDMzsYJvC?=
 =?us-ascii?Q?7mZRL2bAY9RSuV85KsC//EXmY8fUVqtbErkMU1Um1pJGhxB86yVW22ZkczLo?=
 =?us-ascii?Q?Q5h6mK1kjP8ZjbV6O0uMIbIzvmG7CkjjSmaZc5lh6xEVa7tPzIpzIPSRfgu6?=
 =?us-ascii?Q?gjRMvTdprsKwOZji75/6sqBUsygE7aXL5ILa8+sDIvexeXKg1vxyMDEfiEEv?=
 =?us-ascii?Q?dOR83Ai+EoFca8H8cGoPYm769d2RWHtAcA0LSpkCY9U4gYfyGaEE64vKd/H9?=
 =?us-ascii?Q?ME43nVd06B0zhD4w5YaysS9USZ0IVmUkHAMKPaqe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d11a7110-0f06-4992-b48d-08dce124624e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:49:16.3965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/7VqH3YNxBAxskg+QrL6u7xso0BSlnmV/KbIc+jWls/ovTqSbrcB1ylTNeclUncQnTXxNf2IqzF4lERbSWRXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:17 PM
>=20
> There is no helpers for user to check if a given ID is allocated or not,
> neither a helper to loop all the allocated IDs in an IDA and do something
> for cleanup. With the two needs, a helper to get the lowest allocated ID
> of a range and two variants based on it.
>=20
> Caller can check if a given ID is allocated or not by:
>=20
> 	bool ida_exists(struct ida *ida, unsigned int id)
>=20
> Caller can iterate all allocated IDs by:
>=20
> 	int id;
> 	while ((id =3D ida_find_first(&pasid_ida)) > 0) {
> 		//anything to do with the allocated ID
> 		ida_free(pasid_ida, pasid);
> 	}
>=20
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

