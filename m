Return-Path: <linux-kselftest+bounces-32654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C482AAF68B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 11:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BFB3A6804
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 09:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E42638A6;
	Thu,  8 May 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDs5F7/W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384621CA03;
	Thu,  8 May 2025 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695754; cv=fail; b=SQfNv6y+DVinMGgYlJh8Ypo0Z+4rjL0CCQzA/J/EwVkXYt/7KhlosrlA2hl1A2CpZSC9PHvVXfJXVJIsfC9tTmZAXnz+Fpm26NWHdjZLPctTf40ac6MWXGlurhba82N0xVJ0zoudwEvN7md9zfmmTfJOvFawW2sARDvQQumbZi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695754; c=relaxed/simple;
	bh=9bo97mUoNEkawIZ8Z4SU6vAakDqh3SJyaDWeF+zzhzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oa00cAhNEwBCTm4d5Fql7jLiXdyp91BYeY5bo7XMNLfEMCiaQNt4x3HQqe2KfBika/YKaALdipmg9AeYWYLOYm/VP75TxPwD7Z9Of0vUTDbw7Wtda7CzALolBiUlsG+qjhMaLrtnnnbuVMEBqGZqMdmEdFyre8EykJTnGWRZOh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDs5F7/W; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746695752; x=1778231752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9bo97mUoNEkawIZ8Z4SU6vAakDqh3SJyaDWeF+zzhzo=;
  b=LDs5F7/WiniOKTM3wYECHKNlE68WeUH3cvJHqyC86TpXKKOi6snM+FNV
   ENmH0PTmhUCrfCKzQsyItlKU1XVqvugbTgjPGrlNbTlzuWw/O/4SoJn87
   zjIWmohRLps32urvt7ROSxXE9KWcEVcuZuny944g6I66AEma/Qij1M9Hl
   /nF7gp+r4ENuP5T1r/7HTNfY9DVbl85ikmHTq55+/goWdvXcYKE9Pyiz+
   x55l+W/cwxqsJs94K0NhS2gqwYQlotcNTmpi2rNXJpkuvG71zMSviwlMI
   qb8SOOr309iaaJNYrhiHY0maY40BQRYDmGEp8warUGRtulr50Tj3+qPJL
   w==;
X-CSE-ConnectionGUID: ny5L4rtvSkqyKq+Tl5pVlA==
X-CSE-MsgGUID: 511vqO3IRR2qwrP0sNjH1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48374213"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48374213"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 02:15:51 -0700
X-CSE-ConnectionGUID: REvcYVyKTAexW+o9it4oIw==
X-CSE-MsgGUID: lmPyJvoPSHSx0QdS8AbqkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="137167843"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 02:15:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 02:15:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 02:15:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 02:15:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjVVdOQ+Ia9idY2FtdAvR7ppxUgtsqRWkmDkFu6WNhHFMA7g7MFBleFY/PHXNUy+MonNy07YDGw56VsqtcwkeFyjUHvZOob39Zgqge8fATKOdZ5c32R3QHaqos9Zm1d5SmU7llwdljAajaDZZyKjTlZuOUFQwGkJx9pl2/va8tyStJk+UuAUjv1+YHalMvMz/0ONfULiQ0gtOAIBbnqOsmbtSU36Z0YrDHWE8XoAUHAITm69WGsM3NuE2PFeP1IfUMi+K8UTL0SJIwp0lAZMBTyKqvQ8KH1uCaWeNwClPAN7anRVzqF4keFJud4htI7OoMa3qDru44B927kJlzSd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bo97mUoNEkawIZ8Z4SU6vAakDqh3SJyaDWeF+zzhzo=;
 b=wdR1c4nmaP2+sU2SjAshPt23p406DBDiHqDA9bMq+JQw+LCyhM6cUqTyvByksqw6VEOsdmKuo/Fk3RdkSXH/wi8aaIT/aCAzML8JGYvdqnSLrHoLV4EbKh/uE1wjEupwZOO/Nucj30gKzhuhG17VjsGoTPAUzRShoWaEP6/ghqhFx1aYG5O9+gQGKxUUACLvugfYekX/du9sb9/p006CIPqFJQwfv573nT7T4QWmtdStYZhKKgvfiHdcOPV8nOVJ60tLCMw08INcO2GL72VIxVzx5FDilHTnwUoIp9GRnyxhirdpBGM700fU78jyyLRdMt3kJSPcVVvQB8nDoFjV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 09:15:48 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%4]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 09:15:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v2 13/22] iommufd: Add mmap interface
Thread-Topic: [PATCH v2 13/22] iommufd: Add mmap interface
Thread-Index: AQHbtnBluZ9uOQEPBUai7HCfuqREcrO7HI6AgAAC5wCAAAEugIAABKWAgAACogCAAAhcgIAAAyiAgAkczwCAAAjXAIAAAPuAgAAnGACAAR1iAIAAb1oAgAEfQICAAI6igIAAEGKAgABfZgCAAFqYcA==
Date: Thu, 8 May 2025 09:15:47 +0000
Message-ID: <BL1PR11MB52711314C2A6E1C55AE694288C8BA@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
 <20250505165552.GN2260709@nvidia.com> <aBj1Av6Xaj8flMN+@nvidia.com>
 <20250505173101.GT2260709@nvidia.com> <aBkWoH23VysYake3@nvidia.com>
 <20250506125222.GW2260709@nvidia.com> <aBpjbtRgR1nK/LIm@nvidia.com>
 <20250507123901.GF90261@nvidia.com> <aBvMC7dnYghoX5Aq@nvidia.com>
 <20250507220809.GB232705@nvidia.com> <aBwp0JviKskqbPXz@nvidia.com>
In-Reply-To: <aBwp0JviKskqbPXz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SJ2PR11MB8471:EE_
x-ms-office365-filtering-correlation-id: 7c47b29a-9f70-4c4f-ecdb-08dd8e10eb95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K3pTZ2FXVGo4RG05R1kvTGVIUjJxQnBNeDRzdmRFbHRuY1diWFdaWHFMMDB5?=
 =?utf-8?B?ZmJFTUdxS1g3WmtpWk9ENlJ3VTlmWjBuQUdGRkEyd3ZleFpGMjdlaHM0MEd3?=
 =?utf-8?B?QWV1aEoxekhzOE1wWUdHNGNId0xIdWpzOEJtRE9FemhnVHZlVmNHY1Y5M0x6?=
 =?utf-8?B?NnlmOE41OVA1Nm8xUWRRVEtKZ0VKYlY2RURqZDQ0ZFBIYlVTSU5vTE1Bdmpl?=
 =?utf-8?B?TmN4MDN1TU5nRU42WDhCZDFKWC9XenFBbzhydHRZRnRReTZ6OWIvSFYwSWts?=
 =?utf-8?B?K1dUenJmQXJUWkZuL1NkMXNkNEpybUhWTDVCc1JtbnBOWVhXMnh6RGtMYUtX?=
 =?utf-8?B?dDhtRWprN1Q3Q0pWZUtxYzRTcDJSVmJrUU5ienZFdjhma1dGLzVmUTdXS3FR?=
 =?utf-8?B?aU9SNGFwSHdWcFhPS1BzMHV4SitqdVBtNFJDNzVaeWtTTCtMcnFhM0NJZjky?=
 =?utf-8?B?S2ZZWFYrSEFqdzdCQTRXTEduNHMvOWlUcWVYa1hMYXlIUTBGc05qbG12T2Yw?=
 =?utf-8?B?TlJmKzBWc1U0Rm5LRU1nVlY3S2lPcEN1Tld3bWRKa2wzQmFDWndFTG9GNVJZ?=
 =?utf-8?B?Sk1MczJuRDFCNFg3MHBYemJLOGQydGIzY2pJVjhhWVFQZVJ5bXdhT3ZjWUoz?=
 =?utf-8?B?QUs3NThvV2VsNG03U2VDQ2hYMHRQVjV6TTZnalBzZ243aHhVOXBaK2ZGeURl?=
 =?utf-8?B?ZjlRblNTTlNhOWNqa1hvOVlVeW9RcXZ1Zng0SlVGSU5uOTdqdGJxd0c1Vy9Y?=
 =?utf-8?B?bkhhMFZrQkJaOWJqQ0pzRXl5Z3ZvcE1HaG1CeW9IMHZBRC9nSk1NejJ1SmlU?=
 =?utf-8?B?b2RmUWtlU3owZnV0cnNoTUtQOWNta1phUGkranZtVUxneWtaaEhKNUoxU0ww?=
 =?utf-8?B?cC9vSHNORHZhaUlaUUpkaTh1M2h4d1BsOGp3UGNCVElybmh5TFR0NnJCdGN1?=
 =?utf-8?B?RDJkUURuaG0yRnpuU2N0RFZDNjVPTXpCSU9yR0U3cWhPU3NtZUJtSjdmVU12?=
 =?utf-8?B?bk03cUN2U1dqMTZCUzhHMVlGWjNOOFYwcUkrTTE3VjBUaStydzdYZnhvY0Ra?=
 =?utf-8?B?WlU4RlMwdjVpV01acjFRazVJT2E2eTMrV2x5Z2pTMHRUc0Q5UDQyc2lURWZ4?=
 =?utf-8?B?ZjQzNkp5RmR1WjJ1MEllZGt4TWtDMGgwZU9QNnhEVUIxcnNnYlo3dFVUc2Zi?=
 =?utf-8?B?NytaaGR2WkFXMWY5QmF1UE9qcG1xODZIZGY2UGtPU0hBUStJZ2RJOXFybkMz?=
 =?utf-8?B?UFBOUHNDN3NDbDNEQnpGQUdTOE0ybkpyOFpQUGpVU2J4SVdVamErejNkOXh1?=
 =?utf-8?B?Q3JvS280cjBCWlFaUFFibzJGV1p4dUxOK2JibUNPRzNZN2lDZjlrS29ocjZa?=
 =?utf-8?B?MzJDNUNKc3htTE1LTEljSzlGTEcrUUFDdG1mT3dlNGpoRW1WaHNaVE1VZHhn?=
 =?utf-8?B?NHBpcEdvV3BJMWtBdm9vT1NlL1UwczNNYmgrVEg2SC9PbUZYbS93VGRpUUQ2?=
 =?utf-8?B?eW1rdWRTenkzUjB6WDEyL0crSlBBSEZMK2JzUDJwUGd6SkJUVGFZeFRia0Nx?=
 =?utf-8?B?THVMd0Z4NkRwTW0wc25HZUFQTWhuejE3OHhHdWdLK0t3OTl5a3pPQmFCV09Y?=
 =?utf-8?B?K1RuMlFiUWMzNUM1RERyRlVpMTVKT3RNa01nUmk1SjhZQ0JQaG8veGpBZ1pM?=
 =?utf-8?B?Y3J0cDE4WjJUZHF5WHkrL3dNckZmeWhPUlVRQkk1WXQySEd3Y2Fvcyt1VW1w?=
 =?utf-8?B?dE1EbGh2TDF4bU5wWDhDdzhWTTVtYmhqYlFKT29yZDNiNi9EaTdMVktEZHE3?=
 =?utf-8?B?ZjloR1pJNzNIQ3NRelJTdnN5dENYaVYxTm1PRlRJdUJTS3ZCWGpsQ2V2U3BU?=
 =?utf-8?B?a2FlNENRNHRMUWEwQVFLa0wxaTdDVGs1R1M5UnBUU3hLd3JVMU9GQzBIaDRL?=
 =?utf-8?B?RE9xWmhTeXY4eTVWcnlIb0pwRDYwOC9kOTY0cERURlJWSG9vZjNyVkhERjlo?=
 =?utf-8?B?S1htVkxMK3RBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak9CaEJWY24vQmkxcHFMc0pYNWpkZ2NGb2t4cm5BRzQwNWZ2YmVKTUpjMGxD?=
 =?utf-8?B?RjZLMWZ5SHJzWU9TeXl1ZjJlWEZvWTdPU3k3UGo4MFdPWGthSkV4Q2gwZXNt?=
 =?utf-8?B?NUFQMUlia2F2bEM0d1NRbzhTaDJwbEViNnIxaUxIc0Q1dE5hVlFDS2dpVXZG?=
 =?utf-8?B?RmlWSVFKTTZYNVdZK1p6SVN0eEs4Y053OUtEdmFQTG1uN2pYMnRzTFNqUlFy?=
 =?utf-8?B?ZlBXMmg4dnlVZFFSbS9BOXhKWkhSVjNrUXFiaUxjdjVLcndDOGcxaVZTRGsr?=
 =?utf-8?B?cTFmUXdMWFJqd1hKU2E4VGtXUjBEQzFYYWQ1WThLdU4zOU1YNVd3dlNmdkJV?=
 =?utf-8?B?d2RxelJHUnQ2Zk9nTk9uWUptNkd1UmZsWDVQR2pNQVN6b3BKbUc5NmR4Yjha?=
 =?utf-8?B?bkdwMlFEeUo3emJ6bGt0NWFIaHlEeHVUUlp5bXVqWU02enZHMVVudHYrTmZQ?=
 =?utf-8?B?MU9QTCtnVWljZVE1VGhpaFBYQUt2aEhOV0xxeGlSaSs3bUUrK01XVkl6Y1Bq?=
 =?utf-8?B?T0VIVXNaME9FNWR5ZTVrTkJySUIrMjF0QldnK3kvOWM0REdOYVk0NS8rY2JI?=
 =?utf-8?B?UlJ6QndwK1NTdXd0YWpsb0JzVzhOVFlPQ1FpY0R5QkhWWFZDblRudTJuRnRU?=
 =?utf-8?B?VTAraWEzaHRsSnZ0QzlibXJ2R0k4Sk9ub094NUJraGgrV0FZTzYwMks4azVn?=
 =?utf-8?B?ZUdldmxpMFB4TkhKVmZ4NTZTeTN6WEN4OEd5Q29DOEF3QXBrVUtOZ0hFTlI2?=
 =?utf-8?B?cjZSWTJOWkk3N2ZxdHlsaVZWWWFSKytlMTkvdzlGY0EyYm9ZYnUwcnltUFhF?=
 =?utf-8?B?UmVJbXplUzhJcUo4SVRMYnp2QWhYczJoUlVFR3g3UHgrUzQxUjFtanVFNldI?=
 =?utf-8?B?blFTYnFpSzFjeWw1eFJqZzk3VVJBcEhWRE1kKzRVUGVLdVZPQ0hRUStqU0dC?=
 =?utf-8?B?aWJSamF1aGlOSVVGLzl2dnBNcjBaZUZldHFkUU56czVZZ3FqSXR2NlNuVTJ2?=
 =?utf-8?B?dEd2ckxDSEoxQVF1b0tpTkdPUTR1cC9ZT2F6U09nc0p2b3JTV3VJWkRJUHd1?=
 =?utf-8?B?b01rZVNQSzVseDQwb3g2MGwydDJUT1pwM3M1ME1LTy9iTy9uNnFONE1zZ1Jp?=
 =?utf-8?B?YkhVc1l1a1c2YjNtc1pUbmcwckZFOU5zQ3V6YmhldFhQRkd2c0NPQ0kvLzBT?=
 =?utf-8?B?Vjg2Q29FTTMwUjlZb25MSCtqTGQ1VE5JNXh1MjFmWUdyQ3I3amxCZVlsVnRo?=
 =?utf-8?B?Sm81VExXVW03QUg3SkgzcXRvUVhBZnVxZmdndHhJNFYzc25xSUorS0RXWG82?=
 =?utf-8?B?WSs4eTZaVitreU9HWVZtSWJidm5VditQR2V6ZlRuZ20rbVFDYmFXbFRzYm9i?=
 =?utf-8?B?SUNWNDV5aTJjU0dHUWl2b0NFcEtHT1hNb1pJa2YvRUpIUWNBZytlYy9CSWhT?=
 =?utf-8?B?YVBIclhydC9lYnNaSnRBMmV5c3R3bzl4VkdyNzhBS2VWL0ZlM1k5cXZ3c0s4?=
 =?utf-8?B?UExVcTdGYjVtaXpOenJBTUk2SUtBWHd3RFdaSlFaTWZCQnY4dWNNZkdSNlNW?=
 =?utf-8?B?OXdWNkFVZDBReGl4MUNwRXMwWFZTWGJyN3VWRnVlUUI5dkE4YWZaUnZ5QitM?=
 =?utf-8?B?OFhTQ0R0V2lZZmR5MUNFbDFCY0ZLVDZnQk53UFJ0eEZISmI1UGVSbVRJR1Rs?=
 =?utf-8?B?Ui93cG9sZExKb05OSzJjTWVFejJWdmNuaEZ5THZ2dW9Gbzh0TS9jaFVNUUlQ?=
 =?utf-8?B?K2t2OFk1aHdaK2pNMVlta1VyNjhSSmtpUG1FbkU1Q1RUZjA5VHFYZ3ZqZ215?=
 =?utf-8?B?UDdmWDJsbER3NktwN20yaXMybjhLMnBzSGNJZHd5STExWThVSEFqMjRKWXhu?=
 =?utf-8?B?aGdSUENvUGNnUkZMa3pUelRLb0krb3hVaWpMU3RpRmFyY3JCWFZRRFoyTHQr?=
 =?utf-8?B?S1lUR2VSOWRvTmc1bWJkWlpnNTA0UnU3cGJPMDVUTlJnU0VzaWpJQlFieXNM?=
 =?utf-8?B?R2FXZ2J1VDhkL3pSS3ZBazNPR3JkS0E2b0pTVWpvMC9SVjJXZXVlRGFlWWFh?=
 =?utf-8?B?UkRLeDRNR3gxVUlkMjhCYXhrZVVLOEszb1BXWXBRb2xPWnZnbmxHQ3F3U0sw?=
 =?utf-8?Q?/8z8bdOexfPpmcOZiwQ0o2nQk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c47b29a-9f70-4c4f-ecdb-08dd8e10eb95
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 09:15:47.9200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jj3PbRvP0d6lZVhZHHkMPp6mtZQ6GYd/J6GQqo/N5GSXNAs5D6BymxDTjwwzYzJHxoG5QKXdkO42dz8+Po5I4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBNYXkgOCwgMjAyNSAxMTo1MCBBTQ0KPiANCj4gT24gV2VkLCBNYXkgMDcsIDIwMjUgYXQg
MDc6MDg6MDlQTSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+IE9uIFdlZCwgTWF5
IDA3LCAyMDI1IGF0IDAyOjA5OjMxUE0gLTA3MDAsIE5pY29saW4gQ2hlbiB3cm90ZToNCj4gPiA+
IEkgaGF2ZSBhbm90aGVyIHF1ZXN0aW9uOiB3aGlsZSBJIGRvbid0IHRoaW5rIG15IGNvZGUgaXMg
aGFuZGxpbmcNCj4gPiA+IHRoaXMgd2VsbCBlaXRoZXIsIGhvdyBzaG91bGQgd2UgdmFsaWRhdGUg
dGhlIGlucHV0IGFkZHJlc3MgaXMgYW4NCj4gPiA+IGFsbG93ZWQgb25lPw0KPiA+DQo+ID4gVGhl
IHBnb2ZmIHRvIG1tYXA/IElmIGl0IGlzbid0IGluIHRoZSBtYXBsZSB0cmVlIGl0IGlzIG5vdCBh
bGxvd2VkLCBpZg0KPiA+IGl0IGlzbid0IGF0IHRoZSBzdGFydCBvZiByYW5nZSBpdCBpcyBub3Qg
YWxsb3dlZCwgaWYgdGhlIHNpemUgaXMgbm90DQo+ID4gZXhhY3RseSB0aGUgc2FtZSBhcyB0aGUg
cmFuZ2UgaXQgaXMgbm90IGFsbG93ZWQuDQo+IA0KPiBLZXZpbiBzdWdnZXN0ZWQgdG8gYWxsb3cg
YSBwYXJ0aWFsIG1tYXAsIGkuZSBhbGxvdyB0aGUgc2l6ZSB0byBiZQ0KPiBzbWFsbGVyIHRoYW4g
d2hhdCB0aGUgY29va2llIGRlc2NyaWJlcy4gWWV0LCBzdXJlbHkgdGhlIG1tYXAgc2l6ZQ0KPiBz
aG91bGQgbm90IGFib3ZlIHRoZSBhbGxvY2F0ZWQgc2l6ZS4NCj4gDQoNCmxldCBtZSBjbGFyaWZ5
IC0gSSBkaWRuJ3Qgc3VnZ2VzdGVkIGl0LiBJbnN0ZWFkIGl0J3Mgd2hhdCB0aGUgY29kZSANCmRv
ZXMgaGVuY2UgSSBzdWdnZXN0ZWQgdG8gbWFrZSBpdCBleHBsaWNpdC4g8J+Yig0K

