Return-Path: <linux-kselftest+bounces-9115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460628B6CAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 10:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A4A1C21AF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 08:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C017BB01;
	Tue, 30 Apr 2024 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cx/k7uKA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C774E11;
	Tue, 30 Apr 2024 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465321; cv=fail; b=pYsbzcjH7oujMn+PTNMnYvnkz+HPTsH/+PEMDCdcQVsldPhb0ESYZpum1s/fYcxPFdli7kTXHLJTXyxKyyAiLAqJv4OenHFQJ1JFAHsH5IqgKGpU/PreUQvV5cnnFSfZhenxXOvos2otFNb+/AoHX0MkjHqSnQE5jIzPZHrKNtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465321; c=relaxed/simple;
	bh=8llgUIYEXYFGcd1RgWmYBw8vjU4Jmr8+wE7R/N3MmNU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bse9drlHjF/fEBO0NkaMPsvwITvm6dkoXRY3hAJxVn2T++oePnfcMiPq0FYZXwIORmHfYBgT6as+o0qhcHKUThu4Ee8vqbKT2MbzKiCsewCFUbwRI05YQPuSxjMzhfSncb4Pq48wOc2aFBaCJxY0NQT+C7xuJopU6wXHH15xx8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cx/k7uKA; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714465319; x=1746001319;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8llgUIYEXYFGcd1RgWmYBw8vjU4Jmr8+wE7R/N3MmNU=;
  b=Cx/k7uKASMpyplEoBmcPbRpi539yBaoYe7mheuO9vWw2lKeHgGbL7cjD
   SLW1uo2VEP8cUW37KMIbBckgpyLID5Xk/Px/CbJBeaUU+wIRbkSEsev/x
   bcuyvQHAx0CEXdVQfwcF/Tb6QCvO18jORiigbxhbX9eFMF3Upo2OD/ayK
   DwRdLZXAU//OKnKKpXM+kR/fyT+/50odv7lRHD5ff5oIk6JasmEVuYyxJ
   l1jyI1kz/vzvtJGBMy2n+S+G/1flXa4gTOji4AkK7fH6Yvj0FDxBinUVH
   W5t0H+b3IcFR53AI34xJl1yB5KPd4RE/gCJrKtbIjJRHPKIP2ij9K3KH7
   A==;
X-CSE-ConnectionGUID: TbYLUHlJRfSNCy9xEQwi/Q==
X-CSE-MsgGUID: /TmvmLwOSiuDd5f2sfZJLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21574523"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21574523"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:21:58 -0700
X-CSE-ConnectionGUID: wI7tyicORvacBuEovk5BDA==
X-CSE-MsgGUID: psjDpDBeQUqUCrX5lu84hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26380992"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 01:21:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 01:21:57 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 01:21:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 01:21:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 01:21:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeGx9BZgPzdgNnO0Ofh+XftHTM5yeEeYlLicLDhfl3FipAfheJaogzZQghwnL+9Hu3uweC3bWC5e6Y4uWvNqAex6SC5xQDkivEDQ1c9cEdJ0c8lxO62txu59D126vpECLBPRKCc19PHv9z42fiAMc1YqtkrdJHxvYPATWdZLPdOBaOw9nPp+1MJS0V9Qpl3zwDAnogZiNGjbRqWm8p2r5YeCajvwYD5Tec4yt/5Ymjw9/rGy29lQ+I/1pJW2e9rL7MLnq772J44gnfHBiYDREvHLtdIY2FgrWBdzipmK2a2SuBGtm0Kk3K6cca9CtXjPWKeGNAsZNdryEgR4x81DGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8llgUIYEXYFGcd1RgWmYBw8vjU4Jmr8+wE7R/N3MmNU=;
 b=RDhigJrGeJVAqjHoEjBZ+lTPTh8EDKEDGAtE42MrWGxNBMg1/7NnBWJN5YoZgOdhoH8K57bVXUWBHLlvbzmLNofZS711A8AE+5XpykBNJW2cTjNylR7OohfLO9ojMt+Zax2nhccgL7RGJUVEKJ1/oiZWA4GH8cnva76CF7X/4ooxHA4dPDJCawLvkvyt6Qlpduyv40lTpc5j2GnY+HD6nikbSgK8v2nRwZgRHL7I77dQaKtQgcr0kUYkEFvkJDF/++1YtTUv2o3GdHiD/6Nm3khFuM/BpZTTIwr8Vt4bEuaRbwTem+gnBXd2xJtJb+xsFX2VJg4XXZB9zFbAS+2d0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DS7PR11MB6079.namprd11.prod.outlook.com (2603:10b6:8:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 08:21:55 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::5135:2255:52ba:c64e%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 08:21:55 +0000
Date: Tue, 30 Apr 2024 16:21:43 +0800
From: Chao Gao <chao.gao@intel.com>
To: Xin Li <xin3.li@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Subject: Re: [PATCH v2 14/25] KVM: VMX: Disable FRED if FRED consistency
 checks fail
Message-ID: <ZjCqFxA+e8g43pCm@chao-email>
References: <20240207172646.3981-1-xin3.li@intel.com>
 <20240207172646.3981-15-xin3.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207172646.3981-15-xin3.li@intel.com>
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DS7PR11MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 789536ae-14c7-4d2f-23b8-08dc68ee98ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ARfhydUMoqD1uz5zPEphnsnWgAJcT2+EXI1M4e6ClZcJsW7c8mxzPPyGj/T4?=
 =?us-ascii?Q?b9GNcvS7Jef5ITKRZWtNa5p4uk76sYjEpMetfRNvQhVRjMxN43uSRu6Q/RCB?=
 =?us-ascii?Q?SzZjJ0/CW4sMhUaybPbosd5rGuEvbY9l7yeix5eZcLGW5EJGzWlC1LoSS8b/?=
 =?us-ascii?Q?AbiCMIirdIR2u165I2uig/vwd3eC/qwNfgxdJK9sl7BBXJLE+66zI4xmo8Bv?=
 =?us-ascii?Q?B0N8ceNfd9zbHGG502ACAeqrnyiPwrK12wUWphyjdhiVtbIuWI83GxB9aoby?=
 =?us-ascii?Q?2iw8gjogHVu+HdHnhNgTHAl3AdYElw5k+qsiPivCR109JP6ZwGL8RAjrZ5Zq?=
 =?us-ascii?Q?3DEdQljTCsOkWplg6vjt2ikEiNX/Ciho4bhGj0XEs6XKxseg6im7BUegiqkY?=
 =?us-ascii?Q?6Hjc9WMh1zAqGEXwF/9HaxE29ufYNQsmN/x1Eij3HJ/0cYjI4Dy0NPHLWiKa?=
 =?us-ascii?Q?g55y+OcxiYcHfbABkq1CwxM0qIPW0CjWrcKXqujmNKS9AzIx0C28+TkDXvW3?=
 =?us-ascii?Q?ixv35kQpu/wLFgv3Fq57Zq2x6Mb/kxe89NgWqPauZPICstlj4btbeqaVFnN2?=
 =?us-ascii?Q?yTkF98Wss01MnHfIavQc6rPrL93NuBi6GnXmqvTZKTxhbvNwiK0B4XO/oQET?=
 =?us-ascii?Q?CdYKdAt80/qdYsx1wRxdNtxXujNmeRQse82/Q3z4SNz44iyyKf8w9lkd3B7y?=
 =?us-ascii?Q?i6iTkw+N97qNWpmmPhI9udL2mUVVLO5R5tG859ZGrvBx5DPXZ1GzQYSKUJP6?=
 =?us-ascii?Q?gmKogXvyrlQYWwC8NvwAZdk2h07xqOx1agRZjJbQrA/zLyw/YJFaCYgjUvul?=
 =?us-ascii?Q?CitD/ywS7h84+MxxxDsdz3F16gAk5KUc3+LhFwtkVaHEZNmIQw52fjr6eCAE?=
 =?us-ascii?Q?GGo0jjw/cKARcPW9AR/DvW+dbvmZUpLxG8o3cB5KIrzobMysGIPobHVVF/JF?=
 =?us-ascii?Q?OttjVsiWuXgkkAKsx6VcRZeYINgw3kDcusQoASDVBtN9R9WU4kYmuaii/jfI?=
 =?us-ascii?Q?O1oXsWFGxLIrRbsAUlMZPTw2XGQUtL41hTfg67oQB8aUhnX6OoJyFX3vr8bz?=
 =?us-ascii?Q?KvzKzlpo6DVLdGXEFbJkIjsd73g/7HyeW3PSVbCczCppugj3uefGJFjdIIi5?=
 =?us-ascii?Q?Fuzblo4ocMaCrOIzemxwxgRYBNY21E+goXVK99OkKzCP0taebxVNJR1iyN6X?=
 =?us-ascii?Q?LnohdNPb9H5bJotfUjP7z0UvgfuEO/FMwVVI8a91EiBQCjToCJZkw4ryhA0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZUQA1BhNFOuYefpUDL4vgPiorOICWpAsQI18ah6RyHkYWrY3mvupDdu/H2M?=
 =?us-ascii?Q?/3CfrNAQhvDw76mkVMmwUX8ODuVTYK4XBv630h2C4e+E7VWjeUuKcdcooxRS?=
 =?us-ascii?Q?smGgkueGREviqpzKIvq/6k3NTjupUcmqtvYfX+eBF/ltsk0jURJR+8CzMlxC?=
 =?us-ascii?Q?7umOoNOKBJvSmGs/abY0U28A5qI97Ot9gJktMJcXopgofcFvL+Tw+Z4vPawO?=
 =?us-ascii?Q?6XAS8hL8OkdDqLAlQvfH2vkEskHrGU2nYMDJhJUc6cWmg96lmgd9nDzIkOFl?=
 =?us-ascii?Q?BD4B9HRL3xjnctEdo0B+Usr10JWAOtq+jbmld3BzdEQBX+TBu2N2Mqz3My6Y?=
 =?us-ascii?Q?qRSuropaGuRuer2lZrnwqYYJ3wAnsIxD07C58oKrt+NTNhB0bov8tkIAdRw/?=
 =?us-ascii?Q?B+VAfP0ZzwfRjXykcU8dGYxVjfoMZcmUGRYN3m/srjSHhEDC9AicpJhOyRw4?=
 =?us-ascii?Q?p9t9eE/77+ydshEGkt7sovX4hDf43FhEappd3qdihCq5O387NHEWY/cveKhA?=
 =?us-ascii?Q?GyVbgdGg5e3KzT1doCXj03wRGiYLX5YhyU03nKiah+J9spe8RcAkn9b9RQMn?=
 =?us-ascii?Q?nDmTfwmBkzrACl0ibo37nTBXyt5tylcsKpWUcA/dxyxC8cdtCQbZxj8K8puz?=
 =?us-ascii?Q?EHVq4YwmzPAfvwzz0dZOFTjvmb0pDhPYzyhAKeiydPEe0D5zZoCnSKOkHsM8?=
 =?us-ascii?Q?ECNmNiuIEyCJrAwaGqyeDZKCJeDUC/RTYY9drXKhESHCtOFX/95juEFyxMsr?=
 =?us-ascii?Q?fbzZw3tiZ/qPPgwqsFFhxJ/6FLc9tzFAX/tg3CM5mJD5ycVml65BwGmeVaZ1?=
 =?us-ascii?Q?V4XPDTJYf2PRZZyPq+u6zeHXJAdjvvF6UZz/BarkWNbGhi4cmhtE/xN/54/m?=
 =?us-ascii?Q?UlodVK893x7bdAbPEuzem4RlCVubSs58ClM3kLFzu0Iqt6nJV98I6E0Ae7+y?=
 =?us-ascii?Q?7rkh8OBdjxyz8UcH+9+Gyg6EHtEz0zvBAJGUfebfWluz+xlPhA4K5ou9kWUR?=
 =?us-ascii?Q?vp59VIoYp4EKoUJDnvYlgrXfF3snpujuiV7TdslgjfwPGdga+PpUER8JcSqw?=
 =?us-ascii?Q?akodR58Zjpyy6OHB0FLO0mpcfXmXL44p9/VuQY+dK5YJOuJD2pTTBxVO8ZQe?=
 =?us-ascii?Q?x3j/KwDmyW6XK0nDoZHjGg13BjckI8SKiLqsjBkQpzQWVJjPI2ybYnUH/j1V?=
 =?us-ascii?Q?b2WKnVHPxbhYfWoMYh1Axt1VI20Ef5PuFMDVTwoFJPbC7vBsmfvj3MM+BWZC?=
 =?us-ascii?Q?JG9Ycg9TvxstI3pLCDkthDvrVGBrSXaYHr04KXahmkVEYs0TwrF3135KNTzo?=
 =?us-ascii?Q?0C+MI97ewO7/idszuCivRK1UyDKzhg6roppjHpbSH0f1ZoJGThzXDVI/S6So?=
 =?us-ascii?Q?WHwNyBMqnfoPjW63hJ8+Vc1iezDUygxJr5HCyCg72lFgrIRbVSUkHwP5Lvyw?=
 =?us-ascii?Q?SHvBjoOkM5K+lmqnot5+oVMAm8togyz6iTZYESYxmqVXm1TNBVy9aFaJwczM?=
 =?us-ascii?Q?WIXB8fEIMWBJzSdVIDKf1YSZmKpFZnL3OIw89LQ76PPrESGawUIhvlRy9zFA?=
 =?us-ascii?Q?pTofBxsAMtxHiohlbdpvp2S1a4TfUUFoNJ7r72wr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 789536ae-14c7-4d2f-23b8-08dc68ee98ae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:21:55.3997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtSegFJ/IzFbtAp9Pha+KKv02oFwcByDEe5g9sZ4Z+OcWDrKMk+2unS2m3Mx6hjCFrCwaLBlpUzyTo9M48pMcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6079
X-OriginatorOrg: intel.com

On Thu, Feb 08, 2024 at 01:26:34AM +0800, Xin Li wrote:
>Refuse to virtualize FRED if FRED consistency checks fail.

After reading this, I realize some consistency checks are missing in
setup_vmcs_config(). Actually Sean requested some infrastructure for
vmcs_entry_exit_pairs to deal with secondary_vmexit_ctrl.

https://lore.kernel.org/kvm/ZU5F58_KRIHzxrMp@google.com/

