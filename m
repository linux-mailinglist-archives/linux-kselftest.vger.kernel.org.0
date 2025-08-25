Return-Path: <linux-kselftest+bounces-39826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A6B339BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 10:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A0D3B7ABA
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87942BD5BC;
	Mon, 25 Aug 2025 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXMGu2hG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF82C0F6A;
	Mon, 25 Aug 2025 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111290; cv=fail; b=gkkXaBg6IgM4Y+9LOvTlhgOoXG/VDPhQ0BwJozqN1A7llgvxBFvxLXTP9fObNKzgDqQMpEPBrLG+0gUkFK+LapdQrknEJ4aPhgACcnU491UXzcCLVvOO2Oma8cTJHTYn/N4syBOgoJL2pPtgqJpci1EahYj+FZVZpCQyUK9bSvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111290; c=relaxed/simple;
	bh=ufTZMnw3Cj1Q8f7Jj3YZSi3kagsOphZAtwoTmObiNdg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i4AEbTaUb+OqrI9Qgfny1aPEoPspo/pS75151xq5n2RQifjcNPIoUswGm+HVtvrOGWRWUSTiDjoKlRUGq3kmxJj86dTc1rqec8zeNTElgcis84AO6cC4XtK/a48rmfTa+xxdfBjdlnZRiTbD/M+yK8kgKPKg/FDPKXzcPB6jVhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXMGu2hG; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756111275; x=1787647275;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=ufTZMnw3Cj1Q8f7Jj3YZSi3kagsOphZAtwoTmObiNdg=;
  b=RXMGu2hG6xPVYvclbdD8WO/ReNBmnaKSCi3cCuGsSW3NRMdqIOfUGW1I
   WGVMcr6SAfopTKHr5Sm1zg6YYDxETZPFbWCyfVpR2NrM04fIO18woGz3M
   Ro7T3oNwBPI/M4cAjjcikJ6iF4xtV0XkxL/HvkkMN4rNqLEX2NlSeMvYc
   Bo+38iYW+x6rSMok/AyzVTASQkeUurBbotUzTjZMo7y6P2jfUuNsrGCLV
   FB7TdBrj+BvkfjGJaA2FA8+eHdu/iOZKDBIFdQIAwSz2ILtRLHBOv+DRL
   Zr+AA/9izMEEbU94Kr5ip/y9ORYOqpGYQmdWuVWOOvSdobBvjyc79d1U+
   w==;
X-CSE-ConnectionGUID: 5gR3ekx6QAuiGZhA/IjwJQ==
X-CSE-MsgGUID: aoAKljlGSbCKiequikCmtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58240899"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58240899"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 01:41:14 -0700
X-CSE-ConnectionGUID: WrIw+ltjR6S4PsQjC2sEJQ==
X-CSE-MsgGUID: EfJV7gDmTwm7xEF4/88yFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="192901112"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 01:41:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 01:41:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 01:41:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 01:41:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODAuFDVy10M4jgIGZX8pHh56o1m1YLgjOU0u3PmZkOhHTMrSctFWRYHWKh2Gwz21crj+Ufty24NknVYSdPpQGdruorcTg0WT7YVYgmgUHxH2jqe3vuYc4C9ohSI8OAtpfZIcWhFwycqGzCHJzXryCszpMPjrBmfQGyBCPJnSF0kNmsdsSN3J+Ek/cnlubVrERXkDPYx4eVka4v8fMn/QwqfABPRrsl/MqNoAnj6OuqZolZDGRJbf/ECiRjaR0VXltI8ss9ie9zrCWjU9c7GGlby4Ukfm2yoiS/mSJAgxDEjgpAAc7XTYUCPrA7gplJbBPfybTSPU+Kfm8Bxuj5/hHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCAINwf49/KPLTZd77uOTRqP8vkUuWppAhsNz7sxI3Q=;
 b=pjoqezDoj6c9B7Cl8FIqVTOnr/VtzqsUTE7YA+3Uyczp2V0Dm/8jvevxR/Jqy5GiKy/gSRCZJNwlIjFCreIyMO1YEF0P8j8jT70Z/hALG5cjBHh+IP5X8i73Xzk4OrnVerisCd363sT/noz5ujHD69AJmy9MPWi8SHlOUlm49b3MqABnwIEpc9ms/ERw9rbIbyEOUxHyX8p4FTJif33hYB7v3jV1wnNodIorr6QHNdvns3/FrheBA7M01aI43kplzs/16UUZf1BFXbUV6H0lwclgLZdoxRPkeGyP0vHUyqv8i6ELeZ/CYQbeEN92WwNlcz8kzBDiC8W+0BR/JpbfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 PH7PR11MB6053.namprd11.prod.outlook.com (2603:10b6:510:1d1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Mon, 25 Aug 2025 08:41:08 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%7]) with mapi id 15.20.9052.013; Mon, 25 Aug 2025
 08:41:08 +0000
Date: Mon, 25 Aug 2025 16:40:18 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v9 14/19] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
Message-ID: <aKwhchKBV1ts+Jhm@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-15-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821042915.3712925-15-sagis@google.com>
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|PH7PR11MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfffaf6-c857-414c-12d7-08dde3b3232b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ndEBJPjgdcKHuqCB6CF2sqy1TSpLQaDfuGM5yVgXdwOK8KQnINks8S8tObSf?=
 =?us-ascii?Q?XPVkTFC4PmUI0JG7jivSLw76TSOybnEAJJ22XI+9DTW/f7aQsOXc5KWBBYmn?=
 =?us-ascii?Q?2hsnI4Nh3FXlxdhPVdSwPF8sso/iOypOtLIbKLVajnvY8IppPbQB94Am8TTv?=
 =?us-ascii?Q?gs/eriPjVoBKv5YxBMzquwkScIrbYS9h9Ke+eZ6RCvaesXyXlHNDOuvP4jjG?=
 =?us-ascii?Q?angdGPUwdLRTfmTH9E0Er5mFdRuMYOgKyfRrmhBQQ3CEAwZtVRXofhpu2lWf?=
 =?us-ascii?Q?GfW1TsvFJ+qUebOBHf+8e5F0Xm5pWjowoY+Nuxa8AL570XTBKmPHL0RwWC5Z?=
 =?us-ascii?Q?VSPB2G2cnUeKSPp+LW41sUuglHldBfWSXlgeSpuJBf0WNKNAqTCPd8kjVD5z?=
 =?us-ascii?Q?fuhdA3Dw9+Wk4lGKkGHNNUZ2TC5BrQ965jsdOBo/d5q5IkqISppdW0GXQTFP?=
 =?us-ascii?Q?YiFF3PItw5LZcT6dn2c5g4mZ9GAoaS8xtpP/94uP99REVA7QxGlKU6mqN+xO?=
 =?us-ascii?Q?MfO7hYtRW/zQ4aZ3f//2wszGHbTU6uBnF1ikpMEtbmnk5VSm5fugu3/Im1Ik?=
 =?us-ascii?Q?dDyvm51VwDKQIW7kSX3kmsIK9bNTnkvOUT32Iz3Hy9eKchMhr0Nz6wbtGM4k?=
 =?us-ascii?Q?k6037J1Bk1fdthM1bFZbw8quDF/LIFhmHpBITfl4a7sZ5zZP7d+TP2aW9Pmw?=
 =?us-ascii?Q?QRlA5hwJ1HRFkX24Xyvk5Dqgbynw8y5lSAft8RrCis/Ldu6FlOK4CMshW1lZ?=
 =?us-ascii?Q?/hmB3hSQZk9MZo9CT9JbR6+I3Kxg6rjxkx0hvDp02fEPvgXytG3y/zxpvK9B?=
 =?us-ascii?Q?Yeiax2TnOLloehNFR2xjMoPxBcgM74+VTN0vo11c/GHIzkabNxo3YHPoR4u6?=
 =?us-ascii?Q?Pw65JHEVGzVfCDlCzeEPg78Kpye4AidonJ3n/cKzQleUYiuE4prDj1vCsqgG?=
 =?us-ascii?Q?HKhuv2PMGu8Chaun9lPGA7QpmiKQ8AekUA78KueGX1/BxuTo2oSBmEQbEc2M?=
 =?us-ascii?Q?BgwlDJ7Kt4s4ugVTCHzV+dJ9ByntUN+b/8K9tEtTq6CPZ70jH41rHBLiz1gr?=
 =?us-ascii?Q?6u0bpBNatRnJmS+YzKPDmUU1SJJHPuXjXcPHYrljv7cGpM4LtFxitQwq7xzd?=
 =?us-ascii?Q?JjsOo5clcXwkN5qrV9CA965sG1Sc9u3da4bdjABGwiBQeIOFzatFIJ7BdDT0?=
 =?us-ascii?Q?pC7sBp7PJRVdO45H6TBlPdtV6I9UmlFSDX3t5rDF8n0ZKiGYGOo3Ws/S8L0+?=
 =?us-ascii?Q?cb055CSJZlwTD9XeibNLkWzRufYNcAl/ZJmmtC89VCV9B/CyqwMFBQO+Cif0?=
 =?us-ascii?Q?y4LvtgJAPNgdNV2zDbvwOKpFulKpHZFTVJMZeY9wMuIUbKwupPAxJlH40EdE?=
 =?us-ascii?Q?8r8Jre8wvC1DoYZMWlCeMiR8YADj6fKK/4V22ch7GHhjvb8FjmCIbu2xWzVZ?=
 =?us-ascii?Q?fi9CLYA2c4w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e61VJL33GMdLyTCZ0QHmD6CGqgkvy5YfXQetBiRQ9gaOG2rJJGKgeHRGS3RW?=
 =?us-ascii?Q?b8s/j9TmQcl0qbETAxJ5p89CNz9BmDLq5vbCT735diAI7wpU5Apn+ufxLbCZ?=
 =?us-ascii?Q?a3006oVQPZNFD7qGOIMCrPSAaYzMmxPE1W9RZtBeT/wYHFTDqT8GtXLTFsDF?=
 =?us-ascii?Q?pZGkqp/7sahMT91bXQV27Rr6kXTCfaQPDsGwLDyGTn3aDI1VTvoem8vxQ6Fw?=
 =?us-ascii?Q?vVd1uUuqW6ypUIVI+ue/5YFFT35PJqMIrglLw1x+lKDwp7gHk2PnjMrv3vhd?=
 =?us-ascii?Q?TbTptlo3XiXEmhcykWLYlYIlzsgkR7sPzcbUxjFj0EbyRID91LW1ysz0TeLL?=
 =?us-ascii?Q?D0ZcbVWVg31pSoT9DIuv5FCG5XXzAO1bypJ5u0ZMQePeJPNo2EAb2uM2aapT?=
 =?us-ascii?Q?OMO+CbSRia6qCpgSYVOOM/RpcK1n41R0qZ9463Gdu57sOHF+zYtoQq43F13p?=
 =?us-ascii?Q?fwc7t0hdqvmcKMP8rQ2CNMz6pW7Rby1wNNYq7hE6n727sdHNN7m9xfwaRH9m?=
 =?us-ascii?Q?ZKqzV7M1pnFHsTQLpgNyB6f8JjtLdQIQ5O3NfFoCMN1Fu0OIbP1ZfPYLxpRn?=
 =?us-ascii?Q?Xt3plt1tRYTHIL/sTxAZ3zFMjtqrEqgOKLSYG5NOYnSknjKo91HGCFf0gsUs?=
 =?us-ascii?Q?BsgTJ6F38PYwAt+veX4sbmZ3/avEpybtvcG9dI9CXi5+Vl2mO1J21usewi+u?=
 =?us-ascii?Q?3pB8q7jCsViIZcu05NFNZODCBoQsOWsYJiPNqwyXTWC0BM6genUJYOhXhrs5?=
 =?us-ascii?Q?AqbNtMOdfAGxKr7evO994eMElgyMEp/5u61IeWUbh6AWa2k9oeyFTBRzXxls?=
 =?us-ascii?Q?yL8fz9phQ1boOCbZ70zf9ZZZVHeMcp6gpELvCw+86mkkEBg28qjS8jpru3Ii?=
 =?us-ascii?Q?OCUsAZRjXC27Z6rdRN/Bzda1XTo8AvHC6OS6/JA5a4zDf+DhO2UU1XbnsfAF?=
 =?us-ascii?Q?QeU94bfZDmMyKa0YnCZIOjjk4emx4Dk6uz45n1LC3zCqdswexAtznbnY/J+O?=
 =?us-ascii?Q?sJWBUDh6RIzDybDxxD3mVQwABdhykWuK5S5QM9Ogkh9Lp4cE9stJCXROf8v6?=
 =?us-ascii?Q?kfm7pKJRlJFAHjCe1jxAvhePtn7n+vW8UVqsUbXL8BIyToypfC2R0EzmbEdQ?=
 =?us-ascii?Q?3QDb0bT7wi54BTU7T4S1gUEOitVKrmYoqYQ6glt9u7hBM2Js7Becri+tk7j/?=
 =?us-ascii?Q?orGrg1GVevfrwVsq5/+yAgjJ2wapBw+T8BQTPWJ+siNDVkIzQ9ezmuW2ulUZ?=
 =?us-ascii?Q?uz4NS1FsFpAUoTf4w+Sm98dXzM58kX7MvBlu9rElPcVOtL2W8fHdxer6dhKD?=
 =?us-ascii?Q?qhuOH4Tr6Dmx9kMAkcePMdua4XcbrEAwVPAQ1UO5THPP3D4BUQpO96e+lWkC?=
 =?us-ascii?Q?eOy6K25L17KkBQ2bR05ACOgMqd9jFRAJ9Ig+3OrDujpSW3mKBWKwI0Lvaq4k?=
 =?us-ascii?Q?WUoB3VkpGMvaGV8CLVhG4iRyy/+3kTyR+HWgJYFUivlx5f0kAyNzbE7zeuDT?=
 =?us-ascii?Q?wVx8JeiVl5ug5kq1PRf3tc74cJopNYYpFQPNXWjx1dwgc7dRw5soyf/H7TPx?=
 =?us-ascii?Q?R5gyToGwFjIcPoFu6AJOdU1P4veuqmD1hwAUBu/V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfffaf6-c857-414c-12d7-08dde3b3232b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 08:41:08.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvCHfh8xlYKV3RCOEMyNjrNOApDoQt29LclYecDpwhGvC3jZ+6gp/t5I0PebdQfyE1mQzydGi0MOg6GUNr26IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6053
X-OriginatorOrg: intel.com

On Wed, Aug 20, 2025 at 09:29:07PM -0700, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> TDX protected memory needs to be measured and encrypted before it can be
> used by the guest. Traverse the VM's memory regions and initialize all
> the protected ranges by calling KVM_TDX_INIT_MEM_REGION.
> 
> Once all the memory is initialized, the VM can be finalized by calling
> KVM_TDX_FINALIZE_VM.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
>  .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 97 +++++++++++++++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index a2509959c7ce..2467b6c35557 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -71,4 +71,6 @@ void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
>  void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
>  void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
>  
> +void vm_tdx_finalize(struct kvm_vm *vm);
> +
>  #endif // SELFTESTS_TDX_TDX_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index d8eab99d9333..4024587ed3c2 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -274,3 +274,100 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
>  
>  	free(init_vm);
>  }
> +
> +static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
> +				uint64_t gpa, uint64_t size)
> +{
> +	uint32_t metadata = KVM_TDX_MEASURE_MEMORY_REGION;
> +	struct kvm_tdx_init_mem_region mem_region = {
> +		.source_addr = (uint64_t)source_pages,
> +		.gpa = gpa,
> +		.nr_pages = size / PAGE_SIZE,
> +	};
> +	struct kvm_vcpu *vcpu;
> +
> +	vcpu = list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, list);
> +
> +	TEST_ASSERT((mem_region.nr_pages > 0) &&
> +		    ((mem_region.nr_pages * PAGE_SIZE) == size),
> +		    "Cannot add partial pages to the guest memory.\n");
> +	TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) == 0,
> +		    "Source memory buffer is not page aligned\n");
> +	vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_MEM_REGION, metadata, &mem_region);
> +}
> +
> +static void tdx_init_pages(struct kvm_vm *vm, void *hva, uint64_t gpa,
> +			   uint64_t size)
> +{
> +	void *scratch_page = calloc(1, PAGE_SIZE);
> +	uint64_t nr_pages = size / PAGE_SIZE;
> +	int i;
> +
> +	TEST_ASSERT(scratch_page,
> +		    "Could not allocate memory for loading memory region");
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		memcpy(scratch_page, hva, PAGE_SIZE);
> +
> +		tdx_init_mem_region(vm, scratch_page, gpa, PAGE_SIZE);
> +
> +		hva += PAGE_SIZE;
> +		gpa += PAGE_SIZE;
> +	}
> +
> +	free(scratch_page);
> +}
> +
> +static void load_td_private_memory(struct kvm_vm *vm)
> +{
> +	struct userspace_mem_region *region;
> +	int ctr;
> +
> +	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
> +		const struct sparsebit *protected_pages = region->protected_phy_pages;
> +		const vm_paddr_t gpa_base = region->region.guest_phys_addr;
> +		const uint64_t hva_base = region->region.userspace_addr;
> +		const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
> +
> +		sparsebit_idx_t i;
> +		sparsebit_idx_t j;
> +
> +		if (!sparsebit_any_set(protected_pages))
> +			continue;
> +
> +		sparsebit_for_each_set_range(protected_pages, i, j) {
> +			const uint64_t size_to_load = (j - i + 1) * vm->page_size;
> +			const uint64_t offset =
> +				(i - lowest_page_in_region) * vm->page_size;
> +			const uint64_t hva = hva_base + offset;
> +			const uint64_t gpa = gpa_base + offset;
> +
> +			vm_set_memory_attributes(vm, gpa, size_to_load,
> +						 KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +
> +			/*
> +			 * Here, memory is being loaded from hva to gpa. If the memory
> +			 * mapped to hva is also used to back gpa, then a copy has to be
> +			 * made just for loading, since KVM_TDX_INIT_MEM_REGION ioctl
> +			 * cannot encrypt memory in place.
> +			 *
> +			 * To determine if memory mapped to hva is also used to back
> +			 * gpa, use a heuristic:
> +			 *
> +			 * If this memslot has guest_memfd, then this memslot should
> +			 * have memory backed from two sources: hva for shared memory
> +			 * and gpa will be backed by guest_memfd.
> +			 */
> +			if (region->region.guest_memfd == -1)
Why to pass !guest_memfd region to tdx_init_mem_region()? 


> +				tdx_init_pages(vm, (void *)hva, gpa, size_to_load);
> +			else
> +				tdx_init_mem_region(vm, (void *)hva, gpa, size_to_load);
> +		}
> +	}
> +}
> +
> +void vm_tdx_finalize(struct kvm_vm *vm)
> +{
> +	load_td_private_memory(vm);
> +	vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
> +}
> -- 
> 2.51.0.rc1.193.gad69d77794-goog
> 
> 

