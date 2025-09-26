Return-Path: <linux-kselftest+bounces-42446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95BCBA2D9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 09:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FFA177F64
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 07:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A0A27B33B;
	Fri, 26 Sep 2025 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgghUYg4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710817A2EB;
	Fri, 26 Sep 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872861; cv=fail; b=vFq6KHEEOTC4hBBVUxjzsZI+STaabXqxdA7etDREJX1jWd95tL55kzHwlgZCs/RltZvRwvT8oVRrdAy8m1EWARIyjf6E1eVBPXfuR5ZN/J9eoTZfMqu2o3EVXAv3G+QigU5OIpiAC9IK3Anex9pF2ZXVFcZc3JmgywhAIK/ynTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872861; c=relaxed/simple;
	bh=XkMLkxMeBULHven1fCGVrWSNXpM7etC5HO0PgyPgl98=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F58iGdDs3jn5dAAdZ2NUcNXLQzP7uo6Q5n/fkj4uH5Qqha/B4h6ZPfgdccVHtIFbpzgiArdwccXbFAGdFD2XUktSoTEikUZjPK4Kuq3EE9+vfnpuk+rv50VzxG2rRPK3ySYGJITyE6Pt8kFdf3iq7Tkqaq7vu7DAALuxYPjC+1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgghUYg4; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758872861; x=1790408861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XkMLkxMeBULHven1fCGVrWSNXpM7etC5HO0PgyPgl98=;
  b=bgghUYg4KSsAPzGLnn8aqbXlIJ1HhwCIk4M2F5WTfWcNMDJwqbs0Dr+M
   mXr1b73sZ1OPS9zGrD1it3IaWqdqyz1toMeswiBY07DlousELG8f1WFOc
   NIEEZB/PMf/6JJ9CTmXTZ/joZxHuT2Q4DayTGsBmkN/j8HPJqDDW03ZcZ
   XgwGvQLLRJE5G4q0si/mTh/vfN7wJbwYeaNL6IMrXKaoSR7y44pi4LxGl
   K53GY1kzYwMPqYNoVtrTbTkIHkPJU+4P9WJcjayu1AiCjmoetJ60r8BCD
   5E/n67IvJeYOQYK4W/zeP+KD+qrP0ehBt9eb9yUNQiADvvZIv7cVMj5My
   w==;
X-CSE-ConnectionGUID: l+f5O600SLGfqO78wAhpjw==
X-CSE-MsgGUID: QsFXb23eQc6XsKtquc07HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="83810295"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="83810295"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 00:47:40 -0700
X-CSE-ConnectionGUID: adREoGyiR9yvIbzj/Qr/9g==
X-CSE-MsgGUID: KSNvZ3XuRzuCNUgi9BbItQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="182824096"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 00:47:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:47:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 00:47:38 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 00:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4aPlx1k80okkQoPYih3KbujDai10kFbaBc7uxeqST0/4mUDW52+5oCK7a6vog8mlw/6dOhaXwemV3heXKA//D9vSqamaCZDfYPPtORHLwWj0r1GiN5Kw6R3sFy1vq2UJKmOuaDkiQen2J79peAnJNT3CUXO+ovp5E9ePbUZm5ZuXJN+dOwNhXMtzyAR1OgfGlDr+ufdjPLACYcT5aJDFT125ekGErPFXodAS2ni3S9qSvReOp1FtjPbUo+jamkkgBF0Q4+kpxr0ZAU5gFnn2JMlawZOKAWBWafqXQ8Rf3JWXI/LluQDmdn7cNHrgWfDkRhMDJOYwLIE4kg2n02gew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jJvz2kIImPpRs9lWd8v6WWlAnJpGgR8v+wnm8OeBU0=;
 b=kXFOduGd4+HHrkrcl3pBMPBw+Ss+Kxic1PucAN2E9KNrMb1jMilWiQ4H+ShOCnJqXywRcHcQLZFEQiauQV+Dy0ElovoKVVNLZUu+D3feTlzL/jeQj6gnjwz/umrc6e2cK2wzXMuh7bc9gy47BzdJnPgZIUB92lFK01qK+/CL+ACo9DqUACNykN37TBKzvi/CGfBow7SHsNVBM2pNEsH6gfFdl5IEHVPDlHQu6ctw/TswFg6AkgwMK7x4PPvpHz7bpSnPHXrLk5iVPtisoBHcOmve7zPt7vN7ljOzmMMtZ9UhXl3hOoZPX33L9PwD0FdEupT/wIUiek6T4OjykV8oJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH3PPF4E874A00C.namprd11.prod.outlook.com (2603:10b6:518:1::d1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 26 Sep
 2025 07:47:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9160.013; Fri, 26 Sep 2025
 07:47:31 +0000
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
Subject: RE: [PATCH v5 07/15] iommupt: Add map_pages op
Thread-Topic: [PATCH v5 07/15] iommupt: Add map_pages op
Thread-Index: AQHcHPrFe9xjNtgB8EuevUMyL4ijJbSlMv8A
Date: Fri, 26 Sep 2025 07:47:31 +0000
Message-ID: <BN9PR11MB527683EEF36AFD41500936C38C1EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <7-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <7-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH3PPF4E874A00C:EE_
x-ms-office365-filtering-correlation-id: d798e568-289e-4d06-71df-08ddfcd0f2bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?dNFSTGPHiQDgHBkGGpD8p6NyZuk1x3gDea8P428Jw6ZMIPNntKsly1ScF3vZ?=
 =?us-ascii?Q?H1s9GYzn0H6/Zh++Y3Rk0A780tRqpUZc1vBxYanVat2lnhNh4KFmshWbTyM8?=
 =?us-ascii?Q?ldVSUsCZIDKehMNbQ4fJ4gr1t8Tt0qJ7AgL7VSaAcZuBnkaZRzZNB7w/GoWX?=
 =?us-ascii?Q?UDd+CTvSW9uXjrySieC0A6vAdPVK67irmaHn7U1kWOoZqukJdAHtO3SkoLEX?=
 =?us-ascii?Q?giim259AtQcP5FQYMKoybXNqAHGLb5xALLjdML9AaAVEJEG/qblfUAL6c1Fd?=
 =?us-ascii?Q?nAvlAEHQch5xVkDZ+bE233ZC6NgDiPDVm7BNkgYUDSf/ubaNAilfG0yxC94R?=
 =?us-ascii?Q?Jmd7gnXU6toTlu9u5hq9OTXSs0wFwkGL899mCtyT33nQTd5QEf48gPvb7P3n?=
 =?us-ascii?Q?LV9xcSn+B6wRJRyEbjwr3Bx0Q6ShaCAAji1BSWsx1CniXngEZ2YsbstoCdC4?=
 =?us-ascii?Q?ZVCnlpAJSR5+Y1hME31YNCQMA4BOLheK6tR17g2hbEM0QRuP/n1SiDVNiLwS?=
 =?us-ascii?Q?mS8aQysxoNm9GprWMh3HFR8xFRWOmiCf0UHTkhFU+83DTH/Ctr6VIh1LFvPV?=
 =?us-ascii?Q?51VuMC0pSyur2gWsuA64P9A+29OPB5H6jz8MCvfhWsuc1atJjY49MVk6Xyrh?=
 =?us-ascii?Q?ohjaZY+bClgf0Jx/YNSpgyKLJ7lNygi//VJuqILcwa9eWFhAL3KzToZ2DukS?=
 =?us-ascii?Q?srclYT0pzvueJ5uYrrEgFKbdF1wIumaC5HKYrcVXV4zA5Vvf/k/caRfQL9kz?=
 =?us-ascii?Q?ryz+FcUTED+9aAWgfxvX+oNku2dLAyvbdPyl+lAYuRJyveueakQi344IcqsT?=
 =?us-ascii?Q?/WtIijDUKiSGTovHlydObOvldqOJAkpbBLKFebx/ujdTIK4q4ghsC9g0y72n?=
 =?us-ascii?Q?knT85azmZBJtXptEBWyNd618jgizHtYR7SUD0GhC2e70jS35DmgHO50F5lFn?=
 =?us-ascii?Q?MqUTheY1OyhAsjhEq41waqNvJU5k9oHywfkT9YkustREntq4rSyc6ysoZSno?=
 =?us-ascii?Q?hvF+gSl92yvzf7k1C6whVC5udaPZJZqBnIRpfp5TXzvc8hlZUERiAWrSkslf?=
 =?us-ascii?Q?D/RxA/cO9UcgVPMQCXDzYHiLCvkd8JZFtj+Oga+IqcY1AuPjJ0rn1UYg0l5W?=
 =?us-ascii?Q?di6IYCxvFmFxVehRJ6fjGAeOQ4/fTw4HJOX1DZaAtKi3EeIdXaF1ngsugC0I?=
 =?us-ascii?Q?vHixA6FI8eLTnUVQPmIhIgteeX20xI5+XgeEOtS29MWzp+MUOS8sHBpvKidI?=
 =?us-ascii?Q?b/0o3ApOeJ2ON+ummqruEP5o0ApMKtabJb7MXijz4a3rVJYUCfVb5KCooXPQ?=
 =?us-ascii?Q?mCNxV8Hy6rWqilW1hr1CAxanqCvd6ArzWEX81sNJq736FOlNXyOLLT9mQhKG?=
 =?us-ascii?Q?kuwaPCGdLqFs+EXrLZuuSHrvntWLvw01xhG+iZYai1ReacsDiwYCITLN1g12?=
 =?us-ascii?Q?mQhn6hPYaqYlDOp5yEwvUpoukZVNDVSir4d2URBqT2CELYXcQGO1zGEyi8ho?=
 =?us-ascii?Q?kK9pH3V4zt+vQqQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BLgoqNoMoPHs0OUpPZ9KRdZgg0br+pTKdhJOe2nUx4SMC0prqZYcJiW3NiOQ?=
 =?us-ascii?Q?tF9JJh/1VlUcJm8mtaF0FqeYF+/iHhaJZICBye8843cxDwsMOfqyIZ39e0QP?=
 =?us-ascii?Q?Nvt3eiynLe5da3slVpSiFcCNSG37sQF6ESbJ7fDoKKbOaxjwqAK33kA0YK1H?=
 =?us-ascii?Q?OnOdlN8njNLvWju2Tg0w4yBEiW7ldmOH+Sy6GI7neLKnLJVLPF8Mp1p0mZBx?=
 =?us-ascii?Q?TFqZF6Q51wFF+105exH4SxDiGvLv6eT0LRLX2g9kw2RKoWiSKibfc/L5lGf4?=
 =?us-ascii?Q?Ei/pDQYkF1NYl8ye26OUOyeT4kJjBdiePryvyK373g40Wmx4VJ+aJV2D7vid?=
 =?us-ascii?Q?u5X/nkl1Lg3CpIjRJuvee1U5KJn4SMi84EIk8wgjjqH0wkvFlWkczriBIX52?=
 =?us-ascii?Q?YjFy5fMp96ulftxiXKRaOjAykEc+/MH3b1noa0ARXV02AVr2bQ+lCWrWIxp7?=
 =?us-ascii?Q?u+dtMz3pGD4GHUVyzLnQ5x8s9P6HEzhAWyvjABwiOot7VFNx8+7Y+KIWdwXL?=
 =?us-ascii?Q?gznxUb0VghSPzS2kSTqvcr4Sn0x0DLQurWA4R3X1YAFJh6+d+Nbywe6ysB7M?=
 =?us-ascii?Q?HysFCNf/CixMvhT1Nt9mdXtHEcIaMDmlXdn3YWf0to9Dh3BoSsTasnDcJZVw?=
 =?us-ascii?Q?Scs5qRP14gLawtVllZhMEcdSB+n5gx2XvvcdfBCFA4g9dhyweqv7IXEpD0it?=
 =?us-ascii?Q?jDJekQ87hkV6jEeV2WjYZOs9j5Y66QBEdxlTtQiIbr9bmX3S4eQv2hD4UA1e?=
 =?us-ascii?Q?Yj+aRmw+Jw2+tXEw33d38/aZs49CCvkIlNGwP9lBogLM9Oga6NSJKe076TWH?=
 =?us-ascii?Q?UUBACDDwoyfeh3m9v4rGTpGQAbMJ9m2A74Lfo9hy/Itj0pmhYjP2VgAB0uQW?=
 =?us-ascii?Q?zk1Ydj54uQeHD8TvEPZmKfsqEk7Oa3YcksmdljkHTIAjc/jqEzqamzeCwZMY?=
 =?us-ascii?Q?aIbJ2wH72vqTtcih2KVH/mZ7jzK84sOpKer9cshhnzDAgI8jl3V5usHiA2/2?=
 =?us-ascii?Q?FmVo5w4XjgmYBrmKDaZAgTIp1NdM/tqG6waX1AlQXHzeN2cAA3cIk7/rUQAc?=
 =?us-ascii?Q?CWiYnEiG2fCR6rjPcCYuNMxRQkSN3daxxc2876aUcXDwnP+oTq+6lhOWSXlk?=
 =?us-ascii?Q?xlmguLakn0mupSCrXFv4XrWmhS/k4PhsvG/Fh3DMtZaYK0156YLouImjOTUi?=
 =?us-ascii?Q?O8EoGqm4iJ2Io5LdqGVxDCAGjVtf3kT2/p9OpvdPFSsCBh2kMM0/igvu6GzD?=
 =?us-ascii?Q?MayOxqTZK6Pnf5aKkhVE5sUTgI98Zc1rWWoPff2v/4W+IZV+oqRBgj4rCGez?=
 =?us-ascii?Q?BqxqEto4UJNAYaLe+DSOsHXoC8UptUFm0+TxD/OpNyy4lN10OGjsn+YxQfRQ?=
 =?us-ascii?Q?IpBKvtI9gS6+mVvnx6wPA59yzz6zBGnnEN3m3Woa8rsdtgCZNA1n6/x2YFYA?=
 =?us-ascii?Q?ZL6h4kDEO6FBXGuaAX8pQSG33CCkSTsMMOX2kL/PNIGTSSLq//mD5D5EFeuo?=
 =?us-ascii?Q?4jAOnEfnZGbW2pe3wndBpEy8qN5bkUy6ULp4PRwCLqgTON3LfSwuR/md2XY6?=
 =?us-ascii?Q?wVkieeQuKailVbb09cmztB5NWUFuCCmyZY/d4H+E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d798e568-289e-4d06-71df-08ddfcd0f2bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 07:47:31.2018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajBqGKPXjBQv2eTLx0Wuuj76lcmFEK283ZAhXO3F+F+JnZKJX9XGmqaVP8fKOv0y2Ae2/3nJX6+HCxDZnO74iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF4E874A00C
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 4, 2025 1:47 AM
>=20
> map is slightly complicated because it has to handle a number of special
> edge cases:
>  - Overmapping a previously shared table with an OA - requries validating
>    and freeing the possibly empty tables
>  - Doing the above across an entire to-be-created contiguous entry
>  - Installing a new shared table level concurrently with another thread
>  - Expanding the table by adding more top levels

what is 'shared table'? Looks this term doesn't appear in previous patches.

also it's unclear to me why overmapping a previously shared table can
succeed while overmapping leaf entries cannot (w/ -EADDRINUSE)

> +
> +	/* Calculate target page size and level for the leaves */
> +	if (pt_has_system_page(common) && pgsize =3D=3D PAGE_SIZE &&
> pgcount =3D=3D 1) {
> +		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
> +		if (log2_mod(iova | paddr, PAGE_SHIFT))
> +			return -ENXIO;
> +		map.leaf_pgsize_lg2 =3D PAGE_SHIFT;
> +		map.leaf_level =3D 0;
> +		single_page =3D true;
> +	} else {
> +		map.leaf_pgsize_lg2 =3D pt_compute_best_pgsize(
> +			pgsize_bitmap, range.va, range.last_va, paddr);
> +		if (!map.leaf_pgsize_lg2)
> +			return -ENXIO;
> +		map.leaf_level =3D
> +			pt_pgsz_lg2_to_level(common, map.leaf_pgsize_lg2);

Existing driver checks alignment on pgsize, e.g. intel-iommu:

        if (!IS_ALIGNED(iova | paddr, pgsize))
                return -EINVAL;

But pt_compute_best_pgsize() doesn't use 'pgsize' and only have checks
on calculated pgsz_lg2:

        pgsz_lg2 =3D log2_fls(pgsz_bitmap);
        if (!pgsz_lg2)
                return 0;

        pgsz_lg2--;

        PT_WARN_ON(log2_mod(va, pgsz_lg2) !=3D 0);
        PT_WARN_ON(oalog2_mod(oa, pgsz_lg2) !=3D 0);

Looks not identical.

> +/**
> + * struct pt_iommu_flush_ops - HW IOTLB cache flushing operations
> + *
> + * The IOMMU driver should implement these using
> container_of(iommu_table) to
> + * get to it's iommu_domain dervied structure. All ops can be called in
> atomic
> + * contexts as they are buried under DMA API calls.

s/dervied/derived/


