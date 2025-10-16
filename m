Return-Path: <linux-kselftest+bounces-43292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627ABE1D3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 08:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D483189C72E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 06:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072C52F533E;
	Thu, 16 Oct 2025 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdwKS7WO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3062ED871;
	Thu, 16 Oct 2025 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597760; cv=fail; b=fq7nmcPTxMP2d+kdTuFFZls/6O4j/eqSOKKSv5tGGEwao4E3Lq9efoygFmhWKGB7au/H6IajQD5czhj1PZnaBUzIJUL6VXl5+bxaynPk+7imKlZLtRHkKDg9ctawighFUhKHGY7p7rKBsDqmh8LhnqvyYFIuQF1RtLGH76/dKwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597760; c=relaxed/simple;
	bh=0QB5o0ZzK6+Z8e6WXa4H1+B0YH3u88s9yMKrkAq5OWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+/aWGbnD4g/9dSVtkbtOb5ig+pJIyAZRSPHZd/zMrQ2SXA9JFErl5g2F1Bjs6oAVeBaWcanj88fN7DPBJ0pnqO+kgteAk9JTZ0tOU4gdZ4Tyk0I2X36XWVk67LcQ+Zg1Gb5FZ9yINkd2wWFq087BoIGHJe+91EZFsXZwlFSprE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdwKS7WO; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760597759; x=1792133759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0QB5o0ZzK6+Z8e6WXa4H1+B0YH3u88s9yMKrkAq5OWo=;
  b=MdwKS7WOLE//e4AjEu/tIAp7AkWKmuVwGPPyjuCbVWWVZhHDrJvnDhRA
   7AnB2UwtQ5Qw+yXHaqvG+16KaF1pVP+PZ9MLviOEgRl+muPZYLQ/OBHGe
   5yExBMRcruI7D9MylUVwrQ1zrUOejrgATl0cJWa89UPZp3RRCyf49SjVO
   Sl1hHwsuf7bpPoQHlydsI26VrwFuE0XhHHAL1+sFBQA12dR/px4FK16yA
   a7jtGQppxFK9PkrjUSpU9pmo8IIxD64XBlnV1NzAZL1bXefJTK6WcwxvU
   B+ObhEU4X1K/TvvoMJaKniO2NXcphmTNGNJdoDS4bFtaw7tNdphfdlv5R
   A==;
X-CSE-ConnectionGUID: waPDF8AyTwWRLsmKSFukkQ==
X-CSE-MsgGUID: IelIHFsmTzy34AcsUjSEUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62712720"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62712720"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:55:59 -0700
X-CSE-ConnectionGUID: tqu2VVjqQdm3F/VOliEy/Q==
X-CSE-MsgGUID: 6NsogB7lRkS8RMqTrliJ2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="186776770"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 23:55:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:55:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 23:55:58 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 23:55:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmphrvAOpPcGvEeyzp19ERnfQ+H0fGkGMf0ow5hqN6WFg9I2npKdLxgjbbZq1752fK4KYhvGFLUUsHDhlIhgPRGJBmjHPTHPxu+9MdDdBW7GNnHu4j1VdZM74Ir110VCGLjBrWSF/UXtCNAAVlhWwxGgISsxC4nlSGd6JxEv680qs+hPOJUSC4Ctg5TOkZuH3q/kQKG3CzNsqL/Mxhx/vwYu0ySzSn4aRutvCMhuo+s1nvJij4DVE3mAw+j2a7sDM63QupW9SDj6Cg31idDOITmvBJZa1hsS6ojnSToWGileLII00L20NzZnP+jUpQptFrXrIFTmnJRKZU/55beOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/Y1/DqxEYn5nIYFyruTyiD6BKvQuWz14YIIBM9pAZ0=;
 b=KxJPL4EI8ZlKJ2DIn3g7/sf/o3AdJEzJgtwqrzLPQaNec3oGUL2/lVFiGFZsuPv0Yew4jYozZO+u5xzuxfdncXUs6ZGndl5th4PLfP1MCloXAvAVbynoX8c6Gw/AiudFNNfzeZzmK7btIthy7eeQMgXdH4t+G5PlMJFsuo00STCzn1tMuT/0v5miv78IHflT6+N7jXXEcnr6PFckewVJj9EnEQ87g83SvQ+9ZqKx6u9sr36hvwbxT//bC4HRJaAqnLOZV2eiFjxWVOoNjoFVhFJUsZuWlx412Wla2zaaKvSMPEMGjcghkN6AlKOE/qUqg16lJZ386ezrmbRAVAnAEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB8261.namprd11.prod.outlook.com (2603:10b6:806:26f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 06:55:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 06:55:55 +0000
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
Subject: RE: [PATCH v6 15/15] iommupt: Add a kunit test for the IOMMU
 implementation
Thread-Topic: [PATCH v6 15/15] iommupt: Add a kunit test for the IOMMU
 implementation
Thread-Index: AQHcN6UvPQ3cjMoOUkGzo3qunDKEGbTEZHvA
Date: Thu, 16 Oct 2025 06:55:55 +0000
Message-ID: <BN9PR11MB52762A0DD0AAD658EE57D3A98CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
 <15-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <15-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB8261:EE_
x-ms-office365-filtering-correlation-id: d0c11b6b-9aed-4685-ad79-08de0c810db9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?OhulDxyAudvm9vDTBr8xEsxIssdZHRrl0ObUNhDskTCMNY11n4GdWZHyLPh9?=
 =?us-ascii?Q?TossmeVBQF2fC3Se9tzy4O+9oVjMohn4LRYB7DLKMZgG8f75OQuHZtJ1g60R?=
 =?us-ascii?Q?M9W9inrtq9iwLvSwJ9crAqaBUuqn16DvPayESkrgjfP2tfXJaYCo79N7beiB?=
 =?us-ascii?Q?6wJgc5eJpPgZ8Paxo3wFbeU2Y8sAv3lOSENnOyWoxJdy8amJjzeb0eDUgy44?=
 =?us-ascii?Q?XVgJWfA2m/36fGugO0j7R11oxpyE8f1q6mISpACAl6XWoqsQJpu5JOPbcDV9?=
 =?us-ascii?Q?KqhXC6XYuey1giEE8Xv2AnNns5k9vHzlKoiBakOod9k9z3j3rY8qxTprfw63?=
 =?us-ascii?Q?/JfChlXPxv32Cot+NhHAprjEHPrb0mp9CUt7KudUKV0Xp6Hn2JaHLe/VJ/rO?=
 =?us-ascii?Q?f1V5ObDYuazBdq9bQkXF/2EtYmXDyNVWm92ek5tdsab39XIOuBIbXVt+T+e+?=
 =?us-ascii?Q?i0Ap7w/jWV8ktw/OD4dFC6GcodhklMz/TKv0/tTaVfB9ed6UddEZLKrVV5wH?=
 =?us-ascii?Q?eBrEb2ofDajFE8T0SaGHqi4cJZgg1kiiF1fBAWXz7IUNWcvpEyiLXj1CI7DH?=
 =?us-ascii?Q?cuannvl9otI4iY53RUELPw8H0b1hqoDvjluqltIxb6OLdMibFmEHaR6pbW8R?=
 =?us-ascii?Q?Eipo9yqBFikaIouk0V4rttdqhC8OvoTRWTM2FuFlKnaMdnCQnhd0mMgmswrg?=
 =?us-ascii?Q?b1kc3wGb5uG9ugUJJuSpAXsiuLcsYSG1xKCZqHdMlsxE2ah2fwKatzabVW8v?=
 =?us-ascii?Q?0AitVfaKOLXlgu7e6oXIeE7ZM7kY2HGs6Y7eh+GJZO8wzbfQNR8SEMIqiEXK?=
 =?us-ascii?Q?McCsODnHyEShdmNWGyZwd4dsHxM3CfVcydxSB9PQzFk8Fuh3hPJvmYB5jVs3?=
 =?us-ascii?Q?XVkM4NuOVNxC5UxUXwNDoNACnfg53kJj6VIsNocmp4o2mmlkfZ/C8Wgpj3xc?=
 =?us-ascii?Q?hN1scqElbNkIygnP9vWFNXIMDgEk9a8HQcxsXCJlskteN4VWAmM/G6oAwTKI?=
 =?us-ascii?Q?hqXa2N8ubhrZFawzobxNL7PbD8yAt27eEQxm4Bo1Kc0ziSxOsx+GV+nleWh2?=
 =?us-ascii?Q?dwstQG6/szQ0ha+QR95WtcG8dsAPTyZOmC80LZXT+97N1Od5ns4mHbwBGxD9?=
 =?us-ascii?Q?D0NF9YISU9DZ7oJPTY0br0z0jFxlbbnccI9dOuRE0KpN7eCIxBJ1g0IzuJcJ?=
 =?us-ascii?Q?6VFxeUTyj3z03MycP0eyPA11wpMqLed7P6Pyt3TwmhT1yL0swYgtNE+9KpPa?=
 =?us-ascii?Q?kJJdx7hj38IGp0e3gjOR+JhPH4WetbIhU0iAeZiaDfd5JAATMsiyffZH2N0l?=
 =?us-ascii?Q?aoOYQY47nNV9ubx1sYG81TX0h7Y4akSTlnFcGU4+LrJKQm8PDq7niDLwJ1pU?=
 =?us-ascii?Q?BbhGmlE2gtBXYe5RQqGXwzx5OSclUsvuKfKJT4khWkG7ozBl9Cyv+ZYAczSF?=
 =?us-ascii?Q?pIvzUklFevBRwmWE/IbGeR5Pij9KVJfplshOh9nWpeam7XIE0WhWJviprNoF?=
 =?us-ascii?Q?6/PR+zdaRtSJQ/JYM0OYj/gBvRuIb0jLNZQ5veEklddKS2tam/mpPZZvKw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oBhqRiXzOI2XmCselQEr7FMQC0EnUiUxaVi4tBkN+Rlg3FBgqmip9I0+IZ/T?=
 =?us-ascii?Q?6JD83dKcIoU+lpmy5WXoocqowM2X+i6S6P79FhyaNwBalDQPq49WTwYH2d8t?=
 =?us-ascii?Q?wQ7bc6S+lg0MIpSbH9bujKg+deUqCyofUoQy+TfKfrZGIkT4rdWXzEIekOW8?=
 =?us-ascii?Q?vP3ViAgx+vg4VxE2+59ci4uS5+cknMk52T73kk/uDZ0RkwTB4B6FB8slGL6b?=
 =?us-ascii?Q?uQhkj3FNg7m/928D6qEEsbxBTNaStwQRVPwso895V0NgOqfOz5PyyFYRKEt9?=
 =?us-ascii?Q?sqxfemCXIEXYwUT+7CHI7nyd8C3e9hR9OEGE6CJ8Q2gVIYszh33m0htn3dmC?=
 =?us-ascii?Q?/0W1wOBTNLp6mXTNqx3lwzZOwUlsKgF6oHL+gH+pcvkRYlEvGo8Y6+s/eBuP?=
 =?us-ascii?Q?viEigjh0N3qxEe67FdW7tmrmoDJG0nK6UwnJGkoMW3o2ekRiFc5WjCNH+FqZ?=
 =?us-ascii?Q?32Bw8lzRqdSc/ug2TiggqjellEToIKQYsPeaabzdj199QWR8s77NIMsD18Sk?=
 =?us-ascii?Q?rDueRfjs8qqvuox8HeTPErxqjjtBe0BVgdO2Gq/LiCBF343TTl5mu1R07ilF?=
 =?us-ascii?Q?ra7M3XufQ//GOkkPaooU9Q4Kts9523Xc0hOeMcc7TgbufNu9DcNeVADzDE8J?=
 =?us-ascii?Q?Xy1+otWtnNAphQ5lt89Rv7mi1LNgCkhAkYHU5eqsjTHJiCRSnlN2M9M6XZ+x?=
 =?us-ascii?Q?jDYAw9HsMeoEqvUjs/HHiC4c1TQWf7PNXCWyTo6PfRM/r+gPzQwqMONDAVSI?=
 =?us-ascii?Q?mtA/xQFeDU1drYVMNCTW3pU6pqVt+rtBd3+TP4cPnutonTO1BMQFNWiAClgG?=
 =?us-ascii?Q?W36AV2XQVJnDH7iUhRIaibPi1kHhsUieJBdawvEsH9/jRTSbzmovTR3gZh+u?=
 =?us-ascii?Q?DewB/zBGouEH1cgqTGUtcg/lQRJnlWlB4DyQHnyy05ik3qSqc+KwtkYzOfx1?=
 =?us-ascii?Q?Nug0+cJiVEj26/UaJv3pxUPmvRQUUIfKeOfxGUu5L4mocqfEg6FQ780JF+Ls?=
 =?us-ascii?Q?Rnsw5odnnBOrpEgVf0V3I+OTm4v4u0cjeo1Mbn0xkaZvnJ2Y1DDI9HSWb+sq?=
 =?us-ascii?Q?fr0foQXWYabvhSUfWgwHRpJhDGjrK1wASNhzRge9WjApShFn92o8JekH2GGP?=
 =?us-ascii?Q?+skchPi6tgjrcfFwPxVrp6pLUj0uLVvju8RLzJT9OHTCkYydXoaIiyVexPRN?=
 =?us-ascii?Q?fSl4HBUzrUaors4sZDKEZo4NQ+YYShgkq/mnLpLOisf2RO/k4icNsDV5lPCG?=
 =?us-ascii?Q?WKKxfudOfgEBJX4G1hsfPxu/SEsDU9tyAimOv21ingtypdYwynaHTuYDrCkL?=
 =?us-ascii?Q?jynpQhDtBaVgUHRtL+cCaqsfn/8R163o0o8Y44cO1fYtAmRIADNNFD9lSAg5?=
 =?us-ascii?Q?E3GGKtR+p/Wo4iY03SlIB7TmEV5hEx5vwNyR/LNWECOL71ZdgvaTefamXXsY?=
 =?us-ascii?Q?SqP7s2+Xv+zRK7c88wp1k47jHd5MKKXD4nLwI817wNhVCBOv4fIPuYR9KmeZ?=
 =?us-ascii?Q?y0wnaTvBeOFeyndfkfRQBmtL9WrsOR9uXs+fkRSuTXKhkeU6wooyFaTs+TvJ?=
 =?us-ascii?Q?GX/ZvxLLOkcAt56157ds72TE6fekySMWjALGxlxo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c11b6b-9aed-4685-ad79-08de0c810db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 06:55:55.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBt4cjP/wPCFLAXu9ePfcCjqj9d3k7vdIVgmxclhdz84IAcWDU+zotDtllgI5+8hR6NifsPeRhmVXXUoeERwmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8261
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 8, 2025 12:12 AM
>=20
> This intends to have high coverage of the page table format functions and
> the IOMMU implementation itself, exercising the various corner cases.
>=20
> The kunit tests can be run in the kunit framework, using commands like:
>=20
> tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm=
64 -
> -make_options LLVM=3D-19 --
> kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> tools/testing/kunit/kunit.py run --build_dir build_kunit_uml --
> kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add
> CONFIG_WERROR=3Dn --kconfig_add
> CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID=3D100
> tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x8=
6_64
> --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> tools/testing/kunit/kunit.py run --build_dir build_kunit_i386 --arch i386=
 --
> kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> tools/testing/kunit/kunit.py run --build_dir build_kunit_i386pae --arch i=
386 --
> kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add
> CONFIG_X86_PAE=3Dy
>=20
> There are several interesting corner cases on the 32 bit platforms that
> need checking.
>=20
> Like the generic tests, these are run on the format's configuration list
> using kunit "params". This also checks the core iommu parts of the page
> table code as it enters the logic through a mock iommu_domain.
>=20
> The following are checked:
>  - PT_FEAT_DYNAMIC_TOP properly adds levels one by one
>  - Every page size can be iommu_map()'d, and mapping creates that size
>  - iommu_iova_to_phys() works with every page size
>  - Test converting OA -> non present -> OA when the two OAs overlap and
>    free table levels
>  - Test that unmap stops at holes, unmap doesn't split, and unmap returns
>    the right values for partial unmap requests
>  - Randomly map/unmap. Checks map with random sizes, that map fails
> when
>    hitting collisions doing nothing, unmap/map with random intersections =
and
>    full unmap of random sizes. Also checks iommu_iova_to_phys() with
> random
>    sizes
>  - Check for memory leaks by monitoring NR_SECONDARY_PAGETABLE
>=20
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

