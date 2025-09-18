Return-Path: <linux-kselftest+bounces-41807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2BB83391
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 08:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0CE54E0489
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 06:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D002D9EF2;
	Thu, 18 Sep 2025 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQjwdVf5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96827B4F7;
	Thu, 18 Sep 2025 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178536; cv=fail; b=fieghikP3M8uqceTXv48JtObPu2KwnWfpi+q96wEkeIHT5m1dXL5u2L802uJJDNVchJ+hPPRdHc4MEINC1W0gkgQuunpe5SP9cfi7Q084SfQPMkl986hRwMYH538YgPqxiDi/Lltr1P/YTfAvdiBZ2Ocr+01R8Vy7PfzBnmEXN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178536; c=relaxed/simple;
	bh=V5jgV85VtN3AkUVaRlWsKBqGm+wy6hIBAnVxMD7hkSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1x16xzejB0aCnh0JbtWlOboo9J0hTXz9JA+jt5cIYsZfG4AQoQUdqhjVNcV6LxK54V4G5n7NhRST6RcEusamcSpWIYu9PhZ18od2Hr0duMoV/0pHcWKV4Rn9cLi/p4d8HObSiLXgzD637XbyzKaLTH/iHY6Qn13SKGuME6Zt5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQjwdVf5; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758178535; x=1789714535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V5jgV85VtN3AkUVaRlWsKBqGm+wy6hIBAnVxMD7hkSQ=;
  b=QQjwdVf57z/9KOOPcoK+96oanBSeVwIlxCwj+pErkIvXueFWnEfYFmQh
   0YXX5B5lsNA6Q3Y8Zwy4R9bPNMR9MIpRnaOz5redvM3B78Pf30DFbiGtD
   5xQ0gcHJRmfo8eBxUlLRE3WNXRP8JXmr+B5sITeXxZZA/avb6MQ2u35/d
   d5LgUEeKvGSEFVTvEQJ/Eiyro58RrHZCKyHokxFF7etwqaLE1um+I0ddh
   mkY9L/iGHdguRmnzm9IMAqL4g1mqU+XHcLYwYiJ3PS7kFAtRlWy11Gf8U
   R6zMlVQUseyEoNhWmc1IwUe1vYPKRLJ0u7emZq/oYVoaV9C0Kf8eVDN8H
   A==;
X-CSE-ConnectionGUID: K+IB6UjzQhek932nGLJ1Og==
X-CSE-MsgGUID: 2YKhLpbPQd6wsJjLK19a/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="71602388"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="71602388"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 23:55:34 -0700
X-CSE-ConnectionGUID: MABjtFibQKCcTOjvig2b7g==
X-CSE-MsgGUID: IJ5o1+zhQGW9IoihtwdBtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175260762"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 23:55:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 23:55:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 23:55:33 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 23:55:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1aFMvJ57i6sp6iehKrnAIdLbCpq7RBCYjRdl7j1oguvNYkeJZ1P/7VGe5omsbPWeOOwdGpAglHlBLvj6UqWSZs7hAWBVyzBH9E3bTF5sGiPichSlOsAqxkQAYbo5TY0wxmVdNczq059BqCrO1PadgVQYTvyJAg38KMKBF2puQoyd6s9x/c/Gb2PVvLAglWEXgkQvw9Dc4aWtvt8avJoW6EeJBpjsK20FXfrWycWakr1Ms00KukNbA//8zim/zA8WvwZXMVA4siiPkmupY9ynyxheLKb+ypAvAZs6bNldAZSwH23yDyxEb+1skbUKbsR4wa5w1CVDOFrhP9QHiaoOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKqsdKCKg65bhWzXj3K9U4KBD6WvMl8K+Jh6xa6k9tg=;
 b=snbZ2JMRrYNettaf2MccRilPCpsMri1AegP6QFJ3do4m6LzgplP4JzzUrTGH/blO4QstyCaMMYPRhhSh4K5tAAJoRLfWkOj7Nd2R0iCzO9uL/YcYa8ivBvXEO/jH1gxyqb/lMgJ86TQJ1+Pfpin+XLifBYXMKDmsO5y2wc8vOOLDgb8jHNBaesxPZZTOqi9W6qSSfPUTWcrN9pFneJHCr/89fXr57C0/zeiDx7Vo0QXV52sHUFujGN2cEG1Zbp5pgfcM8F7DU5oHELNXlCo+uRgARqX+8fYDIw5/1COMCS3g2HQ4/ZbMvh9CZv8lrzVyEYvrRmo6v/awSw+777RUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5010.namprd11.prod.outlook.com (2603:10b6:303:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 06:55:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 06:55:31 +0000
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
Subject: RE: [PATCH v5 02/15] genpt: Add Documentation/ files
Thread-Topic: [PATCH v5 02/15] genpt: Add Documentation/ files
Thread-Index: AQHcHPrENDh9ui0pkE68VASwqwN+0LSYlseQ
Date: Thu, 18 Sep 2025 06:55:31 +0000
Message-ID: <BN9PR11MB52765D0FE4A9CCFA3F2D73208C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <2-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <2-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5010:EE_
x-ms-office365-filtering-correlation-id: e98561e7-fbca-4761-2bec-08ddf6805bf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?GhdLYDpVw7Yh6yYq5yj6ZzOoEB1YRdbnPWCamO+HWDeMEPxVYTnAc6pF1rvc?=
 =?us-ascii?Q?5P8yBC509yKNB81IKFQvJ3TVarcNTkUuYl+MUH1tGS/NyWa97P4Ppb6j07t4?=
 =?us-ascii?Q?csHR7OQxBPTaFmR/rTi5vWHjr4fdM0gdv0aEeC+hwxos1MR4Kx9DjuC01ydx?=
 =?us-ascii?Q?QkDIrYSkR+a6vBTtcC0juMpXR4Jw87WUrPQKbQtTbbtkC3i2z5TPm0iqxfug?=
 =?us-ascii?Q?7cNniaNyRaiwnmws/nvAsMdJsmZkS8Rz4KV08sm6CNz2l9aPf78mPg20bdGH?=
 =?us-ascii?Q?/cmn4DWtCeWVSb3DDlZTxLcsjfeXZ6YiAUOE5tBL3nQ4hgJGHsQONXSvUa1s?=
 =?us-ascii?Q?51PJk9da7OxSm5PO5A32xRj08h2vDnlm5bogGUwSbOMbjm9cJLMi/EtOET1P?=
 =?us-ascii?Q?3zJcvqnYrVOpILpguYbCSngH9vRgKrlxq95RVDcyVxna3hxLWCBb6p4wgf8q?=
 =?us-ascii?Q?D1dq7RA+x+Us0eh4QNDagPH24IlAdMPg2oS861YVMMOeHaCoQbw0E2t3R+qv?=
 =?us-ascii?Q?6dBJppsQu50Vt2bnXbGqSHroK6zi4S8Lkq6YKXzgzGDlWEahJLdp8DKrl6N5?=
 =?us-ascii?Q?bHCJc05/dAtWccLiGctk+1kZDMtlH7Uf8it4hzEX+oM9kzVhjnWYygf6NIFy?=
 =?us-ascii?Q?5jBt0wdT6yzeAM3k9bcdQ1XaiUzOXxWs8EZ127uhuYY3OZv54Z2ZhJk9fH61?=
 =?us-ascii?Q?cPluVUVGdSFIJHfx/6t9L4hisKqwhHWGsk/ilijZPuOZ/fkwjD4WWYILyokb?=
 =?us-ascii?Q?DfrtFIicjXCb/pgZPwQM0HZyZ5/coTInuvgl6/eTMeCMnx0wq/LPpxujdOM/?=
 =?us-ascii?Q?c7DseSac7pl0PBVnl6OHjLuppmTzOJORin/gXGg+V4hAw4nf5MkTtRdmrO8u?=
 =?us-ascii?Q?P1UUeIugMAuYWj2ofYhtseBIzNKVBuQ8/7aH/s+y3QhejA/sXthXG1K8K0YF?=
 =?us-ascii?Q?HOCRc+Vx1zUNfeunpVAORb49MM8SWdVtxIf2e/BSbZ8OufMSijZabs5jH2c+?=
 =?us-ascii?Q?XESKj6ytxuTHQTsC/a9rzfNtX47vUXFgB04iCVxX+cOSvaUahuXNCSy/U0wr?=
 =?us-ascii?Q?bdM/enzEGbMer2AD4o70M5h6DMI5WmTnT2Yo2hy3OK2ziuq12v7O5zR2PRms?=
 =?us-ascii?Q?TAI26DDv49eJeg2NMH9SLs54PBTda0LlDE0LUS2i7D03RLAzA1uOXL/uFeWJ?=
 =?us-ascii?Q?/lTE51ysx9FZ7MKgSlfzx9N79ZnC5qHlFJf0HP6+FH7HT2ugpRxije3T/URU?=
 =?us-ascii?Q?hCx2CF9K9Af7y/gTWoJnRYXFYdmIc6NEwZhXfJV33SXhM4qcjvnLtskLYAyT?=
 =?us-ascii?Q?SSxMP11IQ2yEhuh9ks0cbEL38vCyj0eyC8Hin5NzmMYfulN02fg0oMhwIbly?=
 =?us-ascii?Q?O/1RiCVo8pyANkxc2T1n+uUFj3Eh99aeW/G3Z2g/o9k0wMcNmQVNLU2Wmq09?=
 =?us-ascii?Q?fBBvMF+vpuGSq5hSfuHQVMqsE7+vIQtdUULy0LXT3CvxA3N7SQ+IRZxeZk2H?=
 =?us-ascii?Q?zHw2oa7hNKTavqI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HrJx3xnsaLMi410OZQD5RjYsWKPi5gNLUR6vgqGJzyaZyna753Q8gDTGMWZV?=
 =?us-ascii?Q?6jirTSYPEJoGLJZ/Ng/YDUgqJxR2X7UKFT0mp6Qd5rRFQnDrhGsaBZbjfGT+?=
 =?us-ascii?Q?PPW/wT8aiVkJSug6du/2RYd8xlpKlCrCWPWf3WqaangP8zwEBWnrM/I5HYSm?=
 =?us-ascii?Q?RkpGbTxkguP8pUcJbpmxyjosDaq3vcQJOBRkBUCI7cIZEsNg5kSNlf9rGntg?=
 =?us-ascii?Q?2XtDI/4B0lTiaKucBOXZaet9F89hM+lxLdj6PE+ObpOI5cQ1x6D6pjWu/E5E?=
 =?us-ascii?Q?pWsvNDPNhmGt0qnWvmhJEc0ypGPRVRxhblRXmo8Ebl1S5aVJb0eQSKuI7p/D?=
 =?us-ascii?Q?csvFg1W+D/17TXlL0M56BMcoWIguCWhirq3DF7ujmGfXoaNLLcnaKGdqtEOZ?=
 =?us-ascii?Q?9Ptk7QngA5ZilsTQirrTSyaRW2HKC79OjGCJJGEE9DDFYcqw3f3IIER1SQUM?=
 =?us-ascii?Q?BON94PomCknHnSnIT2XsbRvWKT5RHuKBznFp3UdIqbc/RdQhAsO310+2uW9k?=
 =?us-ascii?Q?qv1RFmuEVLqc9ejcC9qYFrviI1sUz5oofqejnrKfUz5IvnEXp8aq2Bkn/0Ip?=
 =?us-ascii?Q?vRVZ6SJtuesohwAKzsPGknAVRabkB+wYNbtWPVCy7dC7KYsqQphGbsFhGeAj?=
 =?us-ascii?Q?EHBdzYX7/WyVnat6tpdwJOTR7rirmYiSplApmCNVf4OUSBex1vC/6JvGFsoP?=
 =?us-ascii?Q?nCN02PSQjDTgnR/TflQUDLh6hz+Dp2QzMYy9lulGVyjmugux1n2qO0qJlyfA?=
 =?us-ascii?Q?sZeFkRtq1KFbXmpqYJmkgUz3cB4IH9s5osde5yLZPC/UqbONitVry4g8AZb0?=
 =?us-ascii?Q?t8nisbmITvBw+rp26eN/OA+hX+eDEjLHHleRIAHddeZqF2mv4odpFIWYIwrZ?=
 =?us-ascii?Q?M1WHKaZY1SPJvBZSm7k55ntGjGAEst/JENqX7ZRIQEqFyF+cmnXvMN9sC1KS?=
 =?us-ascii?Q?connuMvkEJAVLV/aocphUbI7HzOICDxUHbA7aUuFnlkjc1R9oK90dlI4+mRi?=
 =?us-ascii?Q?OoRE6FLcqlENwScrarmi+V4K1H0qLE+a96O3BERftLQhVRh0qyfiQd7/GFlc?=
 =?us-ascii?Q?diwPlpL+wxYSd445qROtu/ezrW6QRjicr9d+U4iXvdCKyeXv+apJsRa1J82d?=
 =?us-ascii?Q?6FcT40N+KUkTzPk4DwPxKlP+2xNEpNac4XQebJFU6S8cD+fSuMB9UaWgGWLh?=
 =?us-ascii?Q?hpWc1g8I+stOUY3O62feLa67f2XG1sPdXzoLBrFKqhQ4u9gGcuZr2xbaoqx1?=
 =?us-ascii?Q?Lhxx1lRVXWk0tdEJX1vrT4r1lUBsLrPnFRkkPfJW3aOd9GO0iXWSm0V/EwXW?=
 =?us-ascii?Q?6pwp1jfR6iH3AXBFCqwCgFb0bjU3xNnI1+1XlUhsSnaA3zU+6oGdvH/vKKvc?=
 =?us-ascii?Q?gjkOgTuJ39KRmjtK+uQvhx7pAPiaw3h9VyD87Qg0IalzyyQf3WnO5q00NBgy?=
 =?us-ascii?Q?w6e4xJwn6cvstEAryBPKIrZYXHZHG4aKO1U/dQHW8Y+ZygPfAHkF6wrapaEH?=
 =?us-ascii?Q?rb8jyWS4Gs56W0qCwUzI54yB2DX0d2AoVYfsN9mamWU5fumxkGYb7ULmNTbs?=
 =?us-ascii?Q?FmxxpuAG0sbIELtBxCRPJxR5RWoM9xFPNA8lBeV3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e98561e7-fbca-4761-2bec-08ddf6805bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 06:55:31.4829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwpNXnXdIJzG1wZwBUK+dgYQCDl4GweUjWEWnnqLdYEhCef8rSFwKp/xSwPvCMvL10p6XsaR8WomP2Eu19Z8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5010
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 4, 2025 1:46 AM
>=20
> +For this to work the .c file for each compilation unit will include both=
 the
> +format headers and the generic code for the implementation. For instance
> in an
> +implementation compilation unit the headers would normally be included
> as
> +follows::
> +
> +	#include <linux/generic_pt/common.h>
> +	#include "fmt/defs_amdv1.h"
> +	#include "pt_defs.h"
> +	#include "fmt/amdv1.h"
> +	#include "pt_common.h"
> +	#include "pt_iter.h"
> +	#include "IOMMUt_pt.h"  /* The IOMMU implementation */

"iommu_pt.h"

btw in reality the C file (e.g. iommu_amdv1.c) is put under fmt/. From that
angle the path prefix above should be adjusted.

> +
> +PT_FEAT_FLUSH_RANGE
> +-------------------
> +
[...]
> +
> +PT_FEAT_FLUSH_RANGE_NO_GAPS
> +---------------------------

if it's agreed to keep just one feature, then this should be adjusted.

> diff --git a/drivers/iommu/generic_pt/pt_iter.h
> b/drivers/iommu/generic_pt/pt_iter.h
> index 6bd84f96f5ad6e..0956c8a45646c9 100644
> --- a/drivers/iommu/generic_pt/pt_iter.h
> +++ b/drivers/iommu/generic_pt/pt_iter.h
> @@ -21,7 +21,7 @@
>   * pt_check_range() - Validate the range can be iterated
>   * @range: Range to validate
>   *
> - * Check that va and last_va fall within the permitted range of VAs. If =
the
> + * Check that VA and last_va fall within the permitted range of VAs. If =
the
>   * format is using PT_FEAT_SIGN_EXTEND then this also checks the sign
> extension
>   * is correct.
>   */

not belong to this patch.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

