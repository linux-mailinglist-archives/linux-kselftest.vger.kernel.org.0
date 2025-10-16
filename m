Return-Path: <linux-kselftest+bounces-43290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79507BE1D2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 08:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 575EB4ED454
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 06:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89592EF65F;
	Thu, 16 Oct 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S10p32FJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA61AF0BB;
	Thu, 16 Oct 2025 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597668; cv=fail; b=kIBylDJrh0YGEIFz0fuW2fAIo3tksBpURjJF7J48zpVisrwFUJA7WgBbHTYKMiVqMooq9nH1NOSjUMmwMA8d6nOSXx8J+wz0/8v+RbSkN4f1SeAKaL1QhRNB+JUlhZRV4P6az7jfGrkEpdrHFyu1it9+m+mRV4doyCXkt0oKUck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597668; c=relaxed/simple;
	bh=RWjeb9LLshb8wCPMoLUqeAgZpYAqtaiXpTnISZAiqUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wsdm0uwfuypoyvr4sqp0LV7zcAqLl0VdoBm0qnHtFqY0pilbjuLIjyNAxBZKxxNIG71/DAkcBjwxdGRKNpwSd9Szl7wNhMCf64GwkNJDc3yUYI85AavzoCkEHMZ897xy686OmCjCW4WmBPVdcsxOT6/vTn/Dw/1ztGVY3ojdxUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S10p32FJ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760597667; x=1792133667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RWjeb9LLshb8wCPMoLUqeAgZpYAqtaiXpTnISZAiqUg=;
  b=S10p32FJ1MwjyZsUMFYSgolZkZnmTu0fqyuo/Z2N8fX3MoGagwjdyqH2
   bUdqPJzNtdGPKza82LOv6gkiWq3/PW1AXWh0f68GGnxG8ydy+DIpJR3II
   TkeGo7KxZuNsJxRemnD7FnIXPXtoL0YoITS3vchJhUZfrLj3O5qsBzf/v
   3PlD0+gZOfFOuTYd3qHd8aE6uaP3IIVhy2uKknKZ5zfsNx2UZSd/QQ3hg
   1JE7ZLHyaDfoOCDu/+F4ATKYV/chu4BGE6XHv+S5/uURJszWl2zBSo9Dp
   X6VQoh0oR3P6uMoXzqaTKnQnZyALZHetdplJnUn8ztHPz3UMvsRKd+eXl
   g==;
X-CSE-ConnectionGUID: AMQP5C2+Q2KxCt0f2MzVsA==
X-CSE-MsgGUID: iSK38BhPTOGCuKqY+nnRgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62689707"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62689707"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:54:26 -0700
X-CSE-ConnectionGUID: HlTUm4h4RX6XqLvBFVELkg==
X-CSE-MsgGUID: aN62Mg+bQ8OauMF6BUtxHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="182313965"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:54:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:54:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 23:54:25 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YguhhHKbK2R0DHXIKNEXwRpBhZThZzCUF/UrsIpMbkGN2gRhliPcJMS1Sqq/kz894BRDcqi0vngHA4HYgwQJr8wsWC4vBWF62NhL0ZT9I/s1H38YRliVWo2f0qNNpe9UxvRz3x7pvVdKz+n5f4b9qoNG+/sv1E5WVMstdRJB5RrpbP/1EvUSs35f5EWwZrsn0y8/5hRF4Iz7lD3eJ1r2nQTWZirkC9rL87Wnapl/bh3xq/nH8XwfPycwH8Pnc0NvRb9BPTwhe3NqIYExKaZwHtPnKRfVlF/5RF3Jx+xxc0exK4bo1aapQcDn+BJykXCpYy/Xj/xSqB7MVX2ckOVjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWjeb9LLshb8wCPMoLUqeAgZpYAqtaiXpTnISZAiqUg=;
 b=lHRHWlCTgpFvph4j9/xLIV0RFfc9W0+Od38iLnO7OlEcWddf/LN7hnNXrtcHhcbPyLamKogTQASHgMwkWMujg7z6PUHdh4EaSPmC+9Ff/x16vxsjd5JMTbDjbWEpw2JlfW2bvSVaw8go8kgoLuDmmpsKPMk+5/Cr6wEbNzyM00ZpKZSqOH9aEnWQVSNDryCFlg39hsSjF6zpIJfCvYv6gjJD3PK50DBUHttGbbW7I9s5rCENTGV7ETfIJkmocu4bUY6dcZXJwFy/vGc0xkgiUgEBZsBATgSCInf7NFLyl+lq9juDhRs7YxZrd+MFl2g54V/Hjhz3cxhmiqie0xvaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB8261.namprd11.prod.outlook.com (2603:10b6:806:26f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 06:54:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 06:54:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>
CC: Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v6 11/15] iommufd: Change the selftest to use iommupt
 instead of xarray
Thread-Topic: [PATCH v6 11/15] iommufd: Change the selftest to use iommupt
 instead of xarray
Thread-Index: AQHcN6UxLCwC54LM6UOgGK+Xffka5bTEZA1w
Date: Thu, 16 Oct 2025 06:54:22 +0000
Message-ID: <BN9PR11MB527681D241D5EB2B81D04AD38CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <11-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <11-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB8261:EE_
x-ms-office365-filtering-correlation-id: 30274ae6-ba32-4e61-122c-08de0c80d694
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?iFHtZnbE+IM8t4m395MVORbo53ZGESFAcwmGzqaY/jC+IsDp5JzAxuYWL9UV?=
 =?us-ascii?Q?ZQcGui/GMlzHCJnIRPJbOL1wYF9B0q4hwClbwf8igV8LQkIjqlOTLGXeer9N?=
 =?us-ascii?Q?PAvah3TIIxlYaFzIR4EqDEcInaqqZU/77abxzlFl2Bn9ExmMqYQ7QsiTlxhC?=
 =?us-ascii?Q?P+i07Gu7ET7dwOqdCqGhJ/Rmsvz0zrgV9AaApkVgDPJjJK2L96z1bMvmJk1m?=
 =?us-ascii?Q?lAnNuHOuv2pHMa6WwIs/Z21mWm+fgyc6ApFUtNg/uvBvBVVSJtfJLhKg80he?=
 =?us-ascii?Q?4S7eApxEtNmWd4bbSFZfwJPz56eI1Oa0U0fMVH9h9zITaEmgHmfcpgSmvphu?=
 =?us-ascii?Q?sICYb2/8D1aJG9JYHo02eMlyVRaw1D/yjXijzECZxGw9eqFJD3QOly0IoI9y?=
 =?us-ascii?Q?TZfWyqr0Tc931eC7zy/HQHwWAUBkkmcJ4/QBD/S0/rqW0hUQ+93OFqS3KbEe?=
 =?us-ascii?Q?3tiaouyXUtGrQrYPIP4W7TmNK6B1De0SOtDsN/OkC5I58AfETuccuiKFEMwd?=
 =?us-ascii?Q?hDUgzNYRe9vccO1CKG3nYWfuCUGQrVXu+o91qdCE9vMGW+OHjkk2tZg++GKA?=
 =?us-ascii?Q?7dyWzJS4/CHzR9bfGmgWdUyhwYMNCCK24YJD+K+4Lq1577b/tKhbSXZ3hnvi?=
 =?us-ascii?Q?SbmpRK4d2RQm+P6Ppwb3P0eFqBrUNo5LVQ6QaR8Cr3HnkNS8Fg3gsfioEAuQ?=
 =?us-ascii?Q?JdYIin/rTUeR+0/sVI8hAeGiE9QhPR0ZcpQ1V9U5X3VHkJyzci3Py41/eQww?=
 =?us-ascii?Q?KnzRzISyZPP2BmuteHOmOZSvzSt0FsMSBIm7X9H37pFru6KwDO3jsqt7xaPd?=
 =?us-ascii?Q?krFU3VlRqypTEdUnyj/yEEbbLpn80g/sB6lw9GuDikp/Y4zxVeT2DgLdlj+y?=
 =?us-ascii?Q?Oh7hPzTGysiUU+9WYbLvkhKLlmBF3dsDqoS3H3qTlLZlUGm32YpzoUqy3J/I?=
 =?us-ascii?Q?UzppV9ZOLAK4bya+56u8OP90SF0SGp72aG+M/s/bRMXmQF3/RkbsClZPNN4e?=
 =?us-ascii?Q?FRGbOIt1GOddFTorq9SuJO+dVabmguex+J7rchLhLEs0B5Ip/OJTCYNZlLRg?=
 =?us-ascii?Q?59VWqkFEYvx19bF2Q60hRHvbTDWfVgwODdD1M9+TS9q9on46dCUFveioRIMO?=
 =?us-ascii?Q?hyIrpzeqLWt+VM7L1Wfg3Gzqw46d0cYMZzmv0+CjWm0VtW9eDO+BDe0CPdOv?=
 =?us-ascii?Q?l8PRSHM5oUywO98qliUKWP7YFDzGc8J2sIqPekqad/GqexQQkABYGfBBfifG?=
 =?us-ascii?Q?D1/G2mcEVOmFEc7qf1AhOw79Xj0V2wK1idJ0riLe2FjJIBJ8uq6uP1KGrLk/?=
 =?us-ascii?Q?5tr879xxBEUpm4S89KwTqUjv99HUrWZuFqhr0sm4g0YlPmSwMNfDxRpN1Sve?=
 =?us-ascii?Q?fr5BuRgOZzHwI7BFlFOH5WXzUZuWIKlWqfQoRBAvzFpHtxLxmnftnA16a+Sc?=
 =?us-ascii?Q?dVRMZZIwqbFHSv5fqK0UcqlJp9iXOt/Xpxrglmi8e52NaB1mrUma8aLOFNZm?=
 =?us-ascii?Q?L1vHkz/dagxYBQqH4ZGYB74kbvVWqNvRGBWvNgmO8YEcl1HtEIjSWzMjrg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ipy2g+SwOHpsBTJjGly5miv5Ytzidnb9sshF7jFD2j4KcTBYpcWXWVdhq/RD?=
 =?us-ascii?Q?s0hqUrQAB5Rw6RL5Ma/rl7C/Rg94w+p2Hy25MSctlxw8hyze62MwygtQEDuF?=
 =?us-ascii?Q?5ekek8rOHHuFNbwIkkwJJ809VJinNGTZeYcluiFGQJtWEn4N5hDCHM6AtXFp?=
 =?us-ascii?Q?1j5owy7tGOqVZ46kTw/Nhokk4v+jQQrz7RbC+08Xor4T8wYdFkCLMbee2Pax?=
 =?us-ascii?Q?RPIKCs0EbjasujuBE1FZogFrAIAaNn81+7qWh8yJs7gSD+SCj7pn6PVZvS8K?=
 =?us-ascii?Q?o2ssZcxX5vqrqlJ5h6qwsC60gIdSiGv/BkItkaeWf5eFaX+jsF801m+B+Qbe?=
 =?us-ascii?Q?2Vb/ldaYpN0D8saiS9Xm3+Ie1VoBUk+CXwWm36S8GrairWLrGI/LvesYsyuS?=
 =?us-ascii?Q?tJyWahSUYvrAiHsHR6J+6+0qptM5UtuR89a+yPEEF3c0pKTOypzIgMeeeK9p?=
 =?us-ascii?Q?fUpG12A0ugRdBBpg06BBPzpcYtHaSsW7VFd+zG73qQK6VB9uibQLeQKbZ7aY?=
 =?us-ascii?Q?+JXyzMVwmOd3WQFZ7y4bI/tE0i9zY2HKZXG7qNh1dTFGZDm5LPj+8jR0Rdab?=
 =?us-ascii?Q?UNhVyccawbKjTaB5Sf6jjTho+qwUjpT8d4hTMvij3kPsrNHAa68SVEUhG00f?=
 =?us-ascii?Q?iUP0MiCLZMQ4kO0+kO/62yZt+iriOMpzZ1zgswhiiJIZcMv1ckUHKZbXf5+T?=
 =?us-ascii?Q?fQaJisUeDkx5h0BH+Y7rnGI4ULTqzsUctZlkj9oLs/xbJtSEyaN54AEG7Rtr?=
 =?us-ascii?Q?gTQTy1Avrmku7Lm9hxKsmFaXQ8kAfHTaJb/jrEgMUteOo9jFn/pwKZZfEPhX?=
 =?us-ascii?Q?KgmObJfzsrKeaFVNc72KkMqdD7PxR0biO4tkEKikDA9md8BrVpro6gZpTNyK?=
 =?us-ascii?Q?uF39R5Tbd5QrIwzm0lFeUDiPx5OjYv2HW3PxCNrNYmiUSqmRAB9533/ayqyz?=
 =?us-ascii?Q?h21896/CY8TK69zIHQ20arqP8OkE9xE/TmQWE2c5PqXw5brnSN6pU9nvZShO?=
 =?us-ascii?Q?XhIO3ZO0O4an0AAMZ8piyoYxHtpnmWRaKYgF0+n3EY6SSar7kPPvmi3J/CO0?=
 =?us-ascii?Q?D7cN0WT0erZt1u435XB9YIB16r1cyg3jy5uGm7P1XDBwMiz5wVCrtv2GrrwM?=
 =?us-ascii?Q?jpKGWbidwMIcoySZWogizL9UL+hdWr1zEcwTBOcREk5l3G3gHp15SoIQgphN?=
 =?us-ascii?Q?gUpQB1bsbl/Z4iDvWbx+k4HDWP7Tm7odCN5e3Tr4jjf7Uc+6xjfR8g6gS+MZ?=
 =?us-ascii?Q?9u8f/D1/WfTpaq2+mOyH9qb+kHIizZFV6K1A5fWx6ljVJ9jPIvCFwZrMauvy?=
 =?us-ascii?Q?qYWnCiwalg1GiP19kaQn8OHbCXsY0iDqyGB0WSznLmZCuPrnHHw4hXS1Hlxi?=
 =?us-ascii?Q?pzDZTJ16iPI4Drvmhmn5rPXegsgKKbtE2eGbED6H90lwCsgqFzOHTUF03lE1?=
 =?us-ascii?Q?uiYL2GwEluAfxGqE35sjk8uEBqvc3BJSb0rG+SU9Zr/SE9pUE5XkEF/LHK5k?=
 =?us-ascii?Q?dX8LDJvtIAynFNpdjJja7ouFKjxCXkhZNmLCmMhlxAa4lYtAMUn5F+BW6BH5?=
 =?us-ascii?Q?s3/4CstNgluTQW41jKubhN2nEPdrq5yWlGIrTV0e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30274ae6-ba32-4e61-122c-08de0c80d694
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 06:54:22.7966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jzOf8gcoog0fCuzgLPpBTLESpdVksEkL02C6jj5otGWtaVvXiWbt41RFNH4257HEku/qgUCz6kvQbVBi5KKhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8261
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 8, 2025 12:12 AM
>=20
> The iommufd self test uses an xarray to store the pfns and their orders t=
o
> emulate a page table. Make it act more like a real iommu driver by
> replacing the xarray with an iommupt based page table. The new AMDv1
> mock
> format behaves similarly to the xarray.
>=20
> Add set_dirty() as a iommu_pt operation to allow the test suite to
> simulate HW dirty.
>=20
> Userspace can select between several formats including the normal AMDv1
> format and a special MOCK_IOMMUPT_HUGE variation for testing huge page
> dirty tracking. To make the dirty tracking test work the page table must
> only store exactly 2M huge pages otherwise the logic the test uses
> fails. They cannot be broken up or combined.
>=20
> Aside from aligning the selftest with a real page table implementation,
> this helps test the iommupt code itself.
>=20
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

