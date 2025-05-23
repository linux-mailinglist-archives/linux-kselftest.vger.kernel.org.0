Return-Path: <linux-kselftest+bounces-33611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB9AC1DD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 09:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504DCA24BC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C39221D9A;
	Fri, 23 May 2025 07:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHm4GwQW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEC2036ED;
	Fri, 23 May 2025 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747986261; cv=fail; b=T8zZB6e7EEYlLKGFIK+Mshth0g1oPER580Uflndb+TzytbY3nj6LnVXHGiqdzE8BVmiGX48euAR6wmFtyJcs1fRJRn7K9YO1DxTiAMaTDACPKe8jlsS3BJPFeb4xL2DZT0+0TFI9F6kltXtScCVrp1ATp0Au02bTZ2mulKtaowY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747986261; c=relaxed/simple;
	bh=GtVS6vqcW+xoNaHQIDQ9qI4CIv0D1yh+2vQoTzrvYSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J+q50Z5tCfV8SDflyf7aMWRtEd618UHKdqrS7APt4xQwmDyAwkSciifmuUy6SEGuVZbBM0x6YCmQyThfQ6NSzDwwNtgX7X8R7rYWxN85xjFo1J7QutJGrnjNNMSv+PA4rsNVNxXCFfilWYGeK4JQZ/fGeYp6pgKiwV2pBY4xano=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHm4GwQW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747986260; x=1779522260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GtVS6vqcW+xoNaHQIDQ9qI4CIv0D1yh+2vQoTzrvYSo=;
  b=nHm4GwQWuOvAfVOWMXUEVmmeQ/8cos1mS/2WFcP6XalEo61pTWtFnw4U
   eVSbG53FYHi7g7GLKwgEznwxuOhO+jsl21jYyFEg4OARlYZMxf5VSDd0q
   TK3CxtQU6LyINSb6ukOK2822jBIyRU9ooLmpDDsY9QujqrFb53J3nyJGg
   bn5CUJwoNQPtfDKcFdN17OjRefSL/ivhZKGSiVrK+jw7a4IkEJdwHWREV
   NUSOxfhpJM0VH+VT4dzeVytQ24D2sXT5RzNJmuE1Ckx3ASIaf6BwgJJl1
   k+0gL5MGmz+TzL9LAD/qbiK6lqTX1tMoudzLDHLK+CS0KaED46eRkljyT
   g==;
X-CSE-ConnectionGUID: 8RhDAHhoS26kGwAKQI6jww==
X-CSE-MsgGUID: yQTFyyKaReG/sPEqHwBvmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49738631"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="49738631"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 00:44:18 -0700
X-CSE-ConnectionGUID: DYrTbnDyRV2XbYHBl9m+/g==
X-CSE-MsgGUID: JXbqqhcOQCiCHEG7s4NzJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="141528066"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 00:44:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 00:44:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 00:44:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.56)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 00:44:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeWRFAgDIU45RlI9fC/ntnDBpnAEMAemv8N5LsXqflYnCIH06Ee4EtIVAHMSgz58vlAsm4cp4zThebn2+Deje/teaTJC0MFy0CQTdjKYcDt1j5VdfgbgYQqmCW1p6Dm1rUCwsYh7uyZQltkKyhe1h12uBWDRugeGOw6mJ066fpw7qhr4y3D3d98kKAgjCwZnfLGfGcuZcYza4dB/fFx6Hu0AyovNROXjOkKOeTeZZuVr3h46NlNNRucXo7dy4GyctFQf7Py/ek1EW+yYNUQpCQcWsBtsX7Iqp1VW5bEco5q5ZdKVrKUrfKKz7LF37cdcz6BmjZrKoMTFbW0jm6UtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stfZIRxr/kc44EVoa+j76nHtS9Gyzulbx21m966XBZ0=;
 b=Rtsh9y/3dwypViczTfifiKEBofgFZFm96miNxQ/wb86Iroum/MwZsbNU+7DgZCjzcLLrRUdah2+IvzAU/hJ7P/w3ihqkUdIgNSFv/jQU3duGtmSBRUYs61dTJLJzdmqWCrcRN8ErHHpg/dRTAfIGW7bB56lvzenkOghweaE+DVteYG67GwlhGiRq5hCYPufovDfO0SBmoAo7H2WoZg6XTgA8KWTNgwp9h88AN/pp2lE8u07pG4Sj2JwmlmSk8ectK01rsMplbiuluGm1QfPWsQuJ29k4ZJj8klDVBlQUTeApdlI+UsuU1b5zvhC8BNv0rI0Z8sqcYdLjucJK+xzKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7252.namprd11.prod.outlook.com (2603:10b6:610:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 23 May
 2025 07:43:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 07:43:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v5 01/29] iommufd: Apply obvious cosmetic fixes
Thread-Topic: [PATCH v5 01/29] iommufd: Apply obvious cosmetic fixes
Thread-Index: AQHbx6QUcd/9Ev3eqUeRFS0ODPGL8rPf3X9w
Date: Fri, 23 May 2025 07:43:54 +0000
Message-ID: <BN9PR11MB52769D456ACC019937E447838C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <af4d5f74f9e4f1298624f230a7f6e430a9866acd.1747537752.git.nicolinc@nvidia.com>
In-Reply-To: <af4d5f74f9e4f1298624f230a7f6e430a9866acd.1747537752.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7252:EE_
x-ms-office365-filtering-correlation-id: edde0b3d-817f-4456-f181-08dd99cd9174
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PP1X6zVw/4MTBy34ocghvRqKRD9j/gMoo1gwbVENoaSCSTaQmn/pbaQ9nBL2?=
 =?us-ascii?Q?DuEL6UXdYrY4LGwsMx0G8Jx2b8DIFhHdfCcYXIjrVnP/HuyqSzWPcLEa+Lsd?=
 =?us-ascii?Q?ogEUjUDiTsnX0yhuPf+3FkiaOMXgn8R5PR8Xr2CMDHzfFAtJTof2PROT4BVM?=
 =?us-ascii?Q?otkyXxg4SceEZ38e1WlB8rWDyR53NmmT4RnBYWhptPAQwazB1muh0f2Klp4+?=
 =?us-ascii?Q?4Vj7puK3f4MeHjXXRtaytkN/abwcfcY24Yl7m3P6IUfNnLMNnY2h3g9p4TkQ?=
 =?us-ascii?Q?/xm/pqmVedBzhWmrKBcoqqUm7SN9Q+YgnTRNmdeUn13G28xxtwLbN1ZConXS?=
 =?us-ascii?Q?F/056oIBMkd7capGU1bguIwyp+xER3xQUqSqux0FkXClwdSy2XyLa0H1JFr1?=
 =?us-ascii?Q?3bi9Gf0C9EXMKqpfInDlXDNrmUZ7cS+4PIpKEPF8OdsjdPtEgXmMxL33ngKX?=
 =?us-ascii?Q?t/9vU3+cqQ1CviNTI383wAXErg6OpUMWKz5Sz+SCdNsdYqNnrhI/p4AJXV5I?=
 =?us-ascii?Q?qfBL5Ck+M0TUFdZtUZC6n/8hpAI+DugSwMhdXNawoQOKA+cjAKgq9/75HyU/?=
 =?us-ascii?Q?ET5FneTIghQfHEmvICHCS5RVHJ4aHm2+RXUI/HyRT7YwoohE6Uvj2sL1/BvP?=
 =?us-ascii?Q?/aUdTedYscwhT3LeJElrmjeX/iVKYF8X7CiR1lAENkIC64+fkSJh2ImZYmP2?=
 =?us-ascii?Q?/epoqsTA7keFwV6DT1fA8/wHQG3Gidzoeozg6ETEkYwQ+mmOMHa1FLWug45Y?=
 =?us-ascii?Q?S4ywoJ+swFmJj3/Ou1n15lO8HZFtLERHUkGcOsF2KDloz0AhGH9slHnu2XNO?=
 =?us-ascii?Q?l0n7Pm/qoTP8C9NKUA0QIIuzHLnbxUmBnG/trmYU3cOs/D5JnY+SRLRY4Ojh?=
 =?us-ascii?Q?oAYQ7Si1YM+aTRIyTbFYeqCD6RZBxCC4o6toJYf7rR76ht8KmXPa391ftx8P?=
 =?us-ascii?Q?4nKtvaP66SPgl4o05t8Fzc+qpYJ7dW0YDeoqNXaEhsl5g6Pi7Siii4GOtlPT?=
 =?us-ascii?Q?QIMgCPdB2d7FTC8HgwT/jXKpPVoWZ7Haz3Fv5QdjNbsvOREIR7fbxVxnmND/?=
 =?us-ascii?Q?GUYmDgGX+aW3CUPGx6NFwGswlFfPV+D/tRzOd1lf1GBJte/nwpSIJOFAjJOR?=
 =?us-ascii?Q?++I1hlQLAwkXcQgVwiH3zV3Nzx4L672A1h4yjcLeTSvnFeZSrzV2/I/ZpSwN?=
 =?us-ascii?Q?v929jB9rNMw+hrhO8gakAb0jU1/Rlch0/J96j1mMpkc+UtWVwcaJwtcs5x/l?=
 =?us-ascii?Q?9uaf6C1NxTvXucKgeTXFxoN1BqFlGNxflFDUrtNxE6kE4cL0JFjFo8Pf+IP2?=
 =?us-ascii?Q?TNNa9O7FHWz2B56QstLQMQO0YyoMNNwHik8ZgXb6Ns5nZRBSpXWzpwQkYehE?=
 =?us-ascii?Q?qCGvFZjTNQ7NTMJacgY84d1exDXxtGfmpLqXdS2nwC46U+0/xfTRf3nr/kef?=
 =?us-ascii?Q?PTID8jzf4raqx26aC1HR6fSfsqMoYkFzSDXyBMwp8s9q7XRUoydSxA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ud2bnfwXujuwIyv61IKPWDsmiRS0QTg00ExBX0gIdQmlZVathVb5m/LaAmCk?=
 =?us-ascii?Q?ifym92Rpi8mE4OI+TqjFhi0jOYkN9goIN6G1jRCU7uwpBTjKLFElmtvlan+O?=
 =?us-ascii?Q?53ZKZUlX5RqtUoGYddoI+/lTIRGEFL+slmuvMlSGKQV258dFifmD05k1wjdX?=
 =?us-ascii?Q?5Nc66XmM02WChAWNNxlAFOaGHotimXeiX+eFDwylF8CxB5IQ9H3oXBXs7NVH?=
 =?us-ascii?Q?USBPbATRdk+5DGexvjTLIXyx6vjM/n3ZsUwlY5Kfz1CajRft9MnliDCpxHTJ?=
 =?us-ascii?Q?iNwjckitvWsbsIEqm5OuUhwdrMZ/5O7CrtueWJ3evdq39SHiJzdF3hAEFqak?=
 =?us-ascii?Q?AnH9nQnodFRBwYAA/jw4FaI6LlpZOMtWx3iT5azqSPOKJFE3SJ3/JHry+/m+?=
 =?us-ascii?Q?6cFTLP1NwtrAvSyKZu8OpXRVMDgj6M3C5sEJdz0uaKE13DGNonWpuNpK+269?=
 =?us-ascii?Q?N87gOmAJMZplQbGyW4hvw+mDEY4MFdO9wM2DwUZ/RVKonjjNNRwDC0gDbg3b?=
 =?us-ascii?Q?7OqvVKP7KGMZ8yluYJqlyASw9m8KVlMOZ4FVXl+ucv4COwMQ2B0QNe08l9uu?=
 =?us-ascii?Q?ShNC6Yfqq7mTjkzoQ6M1q6/K2JC9o8ZnhQNl9hMr/QqPzoSxCgiTG2ykOpWr?=
 =?us-ascii?Q?U43gciXDoMdFQDoXiWAp0s/TTxf3kILg3OCnsI59KIkLkS30GsIn0ti/Rmnq?=
 =?us-ascii?Q?jtwkba0h+jWPr6cN1hiEA8y56sU1fhRGjO7Zm03S1eCmtENhpg5WdFGt/7vX?=
 =?us-ascii?Q?8FoxTYTbO94DN5bR6XEd/E0zxAPUAErKa43P7MKz3BQS3m8U2QHPyw/Q4IIL?=
 =?us-ascii?Q?v4YrCLT3B3ItvHMR23N8U1AXEjsCOFy3i/TRfdlOsndl87xaLPOLB4s+kKYL?=
 =?us-ascii?Q?PPA4n/2uTDFyXcWvc7NOLJe2G7IUS70ZRKiFZqE+xUxodKchVbvFZKvo58mG?=
 =?us-ascii?Q?Y3RNKcslZVIaMfgpwacyWYoEpDQ7eUoFGJQ/7vVta4CuycT8V3XymT8KmKJx?=
 =?us-ascii?Q?lPhFQDhngejUV1d5wizOtbPZk9jN+8S665uOr5XgpDrsVuhbAd9hg6I8Sj8a?=
 =?us-ascii?Q?bfKDN9+icPET9oa2/WsyQC+uhNQUnZ6uVEL6qnXKMXDbBGUW8uMHcASFoC2T?=
 =?us-ascii?Q?i9HqHKEJ1qD7Hi9/KokzPIpQQpVuzNhGBj55o0qz1SZmHMLYLVpTmCSmxGd1?=
 =?us-ascii?Q?OQC7s3OlPHnYWxDAFbZfZFjCjI+rLFFm2+ptmNOIyQxfTc4GK/FY/4hDe4wS?=
 =?us-ascii?Q?pNVuTpKpntuY+gkOs+CU8yy0ns2o60Mt9COJODnVoGJJOXvHVWrYRinlstuH?=
 =?us-ascii?Q?yCUTdHANrqsCSiPkZszFpjUnyO2i3wBSXix5Zph1KMJMDlueXanN5qiX06kT?=
 =?us-ascii?Q?P5eXZZIIQ/2Un3IhaiSlM7VxX9vaD1gG+l6pDFDugkkQz2QOYpZizXr6faOt?=
 =?us-ascii?Q?oBnwb1WUgj+wIKixm+YoHzc7UfGDm9vvzPQfoVnszDaDhX8OUb4vPTPcvaUW?=
 =?us-ascii?Q?C8wpJCYHwPCke+NuXtY0P2+czB9xOgytqQHQnNZeHVqFN6Itj8h2iXRhu5t3?=
 =?us-ascii?Q?7DVS5kVAmN0l9Abo2ewGGn7OcGzNffurjnLjTPc0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: edde0b3d-817f-4456-f181-08dd99cd9174
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 07:43:54.3894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbA8Qa60DRnNR+Ukfzol4wJnMJNUflkQlcxij4mtFT/6LM7MwAIU/DN2GYqrhUcDMzMxFSGss+8QDH0pIYzjhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7252
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, May 18, 2025 11:21 AM
>=20
> Run clang-format but exclude those not so obvious ones, which leaves us:
>  - Align indentations
>  - Add missing spaces
>  - Remove unnecessary spaces
>  - Remove unnecessary line wrappings
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

