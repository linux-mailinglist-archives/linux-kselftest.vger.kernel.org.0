Return-Path: <linux-kselftest+bounces-40232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9215B3AD63
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 00:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465BE582970
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 22:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2925DB1A;
	Thu, 28 Aug 2025 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NayFvqdb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048A1E5718;
	Thu, 28 Aug 2025 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419572; cv=fail; b=IErRX1Xvj+7rAERq29/kMslJsaHgHXdqdF6X/XHi8hzhQ2z+rgL9uRlOQRh6DXMtB5z0hofacwuExwQMjNQRwaKxOxjpC9DiqTz7ryzeIqpb03F8eizsUN/RDkfhGnmbcfeWXq/DZMnFh+0Oww98sLHDVeQw4VZbQ4RKs9DQ5Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419572; c=relaxed/simple;
	bh=2c4FZ/tc1BF6ahumV09AeX3ytF/YbxFUQ1M4LUH/MNU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tppmJehfT5Ur7uLYZgQxz3hLMrNjgL/q3/AoBrSydf9PXtA0MYDfJRvbOkWEtD48K+83logZwZq/+iImDs26fyop6ROlUAJZ2dzpEIe140mQuQxnrsgR750NoNpzZAMx+wKq+v2eBvT8rx53S9rUquylhMu2R9CLJm5a18HCwxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NayFvqdb; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756419570; x=1787955570;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2c4FZ/tc1BF6ahumV09AeX3ytF/YbxFUQ1M4LUH/MNU=;
  b=NayFvqdbahYtP5R5gzQYNOPhl/LZbXusXjVYRg3eZyASpdlRFvqpRNBZ
   0+3cOEUKwIS0aD9MeE69kh1gPaxmPzsaM8WcMrklxl8pqUxGhWr3W19zI
   fi7ZX60c4Qq3G4FXk5Aq6UoTxbWp+FCIp4FFti1Pajiyk+orOwP8be9hk
   dd7YsqzrxJetu2wJChCf/e1XgRCu1w3nm23X7//uJ3v9GFtaXnpeg7cWP
   owCntY+K02YM+fN0zFtIgP5sw2+p2phRFbhhqMQJWJiHWt3tvO99dYaAZ
   hO1DSJz+2f9tWZjtr9aVfVDKvgAVlXI6vWPhiqnslZ4lICvPDRPl3gp4U
   Q==;
X-CSE-ConnectionGUID: 2higqw+ySJmcrgrEwkoEBg==
X-CSE-MsgGUID: CWel4UCGSDGuaJittf3cYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69413137"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69413137"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:19:30 -0700
X-CSE-ConnectionGUID: e8uTlS/MRCWblVdkWJtlng==
X-CSE-MsgGUID: 4phzg57SSvedcZHohshQNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169526984"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:19:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 15:19:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 15:19:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.62)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 15:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blFcmyOHMIegT+P7maNM92yyd+JpV2YYSLDtPcqPcwH5bXDIW4zXAjcVHF0oXsvhDXPnoKBbGgDNSdRweDSWXkEQWJtLtmgXNgXZTLcg+VmHM158Jjdw7jEvq2PaAmFDgndju+JQETaPxSq8motTdqrcPE241HNcoYta2PLtMUz4z/j/Wr40Q6JYS1dFY8P43ztNY23uQlo3EbnEQQZ3uRuRM4fw19E4gRsbt7Ho16acLqpuk0R6jrOavfRuIDg5CjoVSEuGfmKZEIN+xf3Q9D4z9Z+IFyG7n4xPizlhdQ+vGbroARoGKER+4ft3x143BGhXVY2OA4MPc5yLXhOMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQL9EQEUUYdfAZ8wX7X8kP9E7X0HxSr6dojoF/DVgtc=;
 b=Uvte1YSVBwUiyzOgu8+ihmolJYiHz1aEntAvch0LKPCnTm5YhKam8FzKTS5NuQE9Pv7kvwao67DiRgddkq5Hv/SMIEwH36bixoc/cYhgsBW9BpXD8dzN+lL3yj4ntD2knBwnwHleLjXIkpBuKB6b80x+xW0vWOUBSvCeh93pl80crieJCpgYopPvtnzmDWN7dS6w0/xJ+L0w0pMCmBbi4TvJaLZzOy1kxUAWezcN43dOebwLVP9ZWKvCuy9F+0UTp17Pgj9QaPnc88cAFRjckWLhQVEaDvClJtahmV1YlBkfuCeGXOWFNzNDF0CpcS3NKZTj9oCz7zJjXPnneRcr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA1PR11MB7823.namprd11.prod.outlook.com (2603:10b6:208:3f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Thu, 28 Aug
 2025 22:19:22 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 22:19:22 +0000
Date: Thu, 28 Aug 2025 17:19:19 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: David Gow <davidgow@google.com>
CC: Marie Zhussupova <marievic@google.com>, <marievictoria875@gmail.com>,
	<rmoar@google.com>, <shuah@kernel.org>, <brendan.higgins@linux.dev>,
	<mark.rutland@arm.com>, <elver@google.com>, <dvyukov@google.com>,
	<thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>,
	<linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
	<kasan-dev@googlegroups.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH v4 3/7] kunit: Pass parameterized test context to
 generate_params()
Message-ID: <lfplzm3dmmkployo2bw2oyhbzwhev4hriamd64th6my2xpsrkv@obol3k6z4u2z>
References: <20250826091341.1427123-1-davidgow@google.com>
 <20250826091341.1427123-4-davidgow@google.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20250826091341.1427123-4-davidgow@google.com>
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA1PR11MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 73269f2f-084a-4676-fcca-08dde680f04a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?td12V4NaoWwqlpzbmfjb+KSkCPJrHnEoVXM4lPmcNQKSqJG1wnrwD91Ha5+U?=
 =?us-ascii?Q?CAlKO8xRUZUMba2m0cGslDnd5xIzWfxJlq+9pf+hUB5OI9XAZGI2qQ8ddv11?=
 =?us-ascii?Q?HCjke/C3mFXdnLSlxQYIhy+v7PErTKD0NSG3p+wzyma3RzuC199HcZlschrP?=
 =?us-ascii?Q?MGfnKxoQrTwNi+l/7zY/UoAYecGAeCzQebWo8r/Zj+OKnaGJL4x3fkAlejsK?=
 =?us-ascii?Q?4CjDrACjnk6SVs1K3OYB9CGhmcqztr5h1Rn+j6IKOgfjyTqN/OCrZjjDlDDZ?=
 =?us-ascii?Q?Dfcd8E2U0Yx6YQb0cAsOkGnbCp/zG/NWMhotKsBCBRlszb4YKlM7u8btnbUc?=
 =?us-ascii?Q?v6bQxrcE9HPoCPQlfJfs1js6EmtiRwbRZkvHjB6gNXhohONfzjKRs2e0edN1?=
 =?us-ascii?Q?1Wxw+Pc65fue55oWUCVXwlQfJ29PGgn/CXA3ZY2SpgQ2Mjb7rMPg1ukXTb7L?=
 =?us-ascii?Q?SGiz4eCCz7DYo7cQSWx86a33zeGzeTn9ddKX6FxTHCO9IotqJc3+DyXgmakx?=
 =?us-ascii?Q?xffAkPMRB+i+U2n3MpQiFVCZky/v5BB+zO9Ps3Rlnf33zv/TyYaLeop7oRhy?=
 =?us-ascii?Q?XWbY4qjyfmhdhLpgfE/DuYLDCwrog85IN2ttY0fLtcsuCuVQyuMqGv0aAr1Y?=
 =?us-ascii?Q?YB7Nr5k2h2PF/Pf3IpxWGkVEvBuLXtC0m3Xia9+vsQ3xpJNQZv8SMf3sb0Qk?=
 =?us-ascii?Q?F7SdsIljk/B49demKOXb+Qyqu9jn87v6wO+5mMHEoAlkfiptwMG07tNSnnkl?=
 =?us-ascii?Q?AurNYJvuInzm/cXM12Q9yjQhWOGyvqzF9/pCXulMhWo3AJjZg6mYvpXzG0Mc?=
 =?us-ascii?Q?VXO23U1FAgcgPX4FQKq7fdzJonF8Kw6qoEwoAfOYMEFPKbS93BqmwRZAu4x2?=
 =?us-ascii?Q?kzACIMKSGmAm/kkW/aF/cNLhBkwfwMPQULj0jr+SUV0T6QOY6MUAECfJ/3cZ?=
 =?us-ascii?Q?o77XjaEt8KFs22U6nHd6ccSmQZF3AZ96D+PbSIdBLWwHhVmj8fGLEx1S88ZB?=
 =?us-ascii?Q?OzBAzHl+6JJbagnX9XQwMC1Miyrij8/YWL0PNw6s+h/lz+vHGmqKWEzI8sV6?=
 =?us-ascii?Q?4f+yKma+O8Df6H5PCEujH3cyhSBr6MjscDP78ro3RYwNrFCXwglZRrFiDraK?=
 =?us-ascii?Q?KMlDXUIw+xAMtpyyWQKEew6ptqG9D4R02CWlb4XbxPbg1qKurzNTmtzKUSUr?=
 =?us-ascii?Q?yAluxko37vpTAU8RjwiBFfpaaYd9mfZEaQiGMYRj0Xc6bfJjtpx8VaH/hko/?=
 =?us-ascii?Q?lhWdJCrzCK1fLmPi4+UF8EWUfj7/95mybHMgkPUa5m1h8r5m5kbTuYi6S0Po?=
 =?us-ascii?Q?/LOHgYN5/KSclUUbOqSXJBPPJ35b08zXFvCFgKy+kj0YDWAqpUXIaMyOAZvG?=
 =?us-ascii?Q?xA4vJiEzHytBNGCuTxoFRcGCnU0fgIpUpS2l142ocsQXuGQ8CtOYD5v8eAZb?=
 =?us-ascii?Q?g8UmadlqpHc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ws5s9AbzGmXvHrHVO18r1j4H3in/9gmbm3Dfzfm1qUrDU7n+YuTSdcY4UEi?=
 =?us-ascii?Q?Gj/0og/L0xYC2PO9GYtC7MoZ/hD9X4H8NttgMUbpDMmF4+SImhGqSYL0U3qm?=
 =?us-ascii?Q?LfHVmPHlKaOSBk3cBcBoIrTdeEGjIkUPY6FiSk2A3J5hXvWivv5ciACTVfYJ?=
 =?us-ascii?Q?WV3dSwqThdMwG1HwDnj/jQHwUz5WQBBbVHnCzj1RxzrsDNNO7a+ssDEecfBK?=
 =?us-ascii?Q?bMce0FTDXcvziReQIrTsXhBBuLIuCJX4x9pvD5MxBzk9Jqj+/Iqyyabp0fSG?=
 =?us-ascii?Q?T8aJQmrKKZLF1IJlBnN55c4Hfbq1DmFFDsSEi32+6CS0Gnck2MviGltfaDxf?=
 =?us-ascii?Q?q090Pjlghd8eoN0kcjrNhAEkao8zou7FREh68HUaB9GJvaWVjtY9NAnJJkSd?=
 =?us-ascii?Q?YcJMaEWJ/K+X/7e0NBhYUFv61HqyNZGYqo2/OVVPoGNDlKu5R/yPuwboHZw/?=
 =?us-ascii?Q?uVRhI3UMNo9E6qz8u1hj9u4KDZLDjSE0TTiADYbUhqhmdM+xLd70wf3ELOC7?=
 =?us-ascii?Q?YYAVbtQgOmCipcbtnV5zph1PfC1o9NwScU0gJDPH/6vwY+J7g8pqTLGi/P1T?=
 =?us-ascii?Q?yxr5/D49ckhCm4K3zdwU8U0tTPKTyOFpzYcScxdxbHvWfQ24lPDNpOyR3gcK?=
 =?us-ascii?Q?C2lF9cLErPFXJGHsfXXowLrvY4piuv4iv/MwD5Qrqz/pZqMfc0TJ4XoxqlYm?=
 =?us-ascii?Q?GR97bMEOBvKrJQLwfnYE/705xMECM85HiHamBdPbxGeWL4SJItGtjOECPZZ6?=
 =?us-ascii?Q?0M+xL56g1ab3BK8N7j6pwbCvW70jm+XTlbPr19woGIo165ydyGDxjpgLXdv9?=
 =?us-ascii?Q?JnswTJE7hxFmbdixgQ74EQQmwevHEKbwaRtrtr/viJlJ8X642GBZyLIrArK3?=
 =?us-ascii?Q?7QpAIyeNnH85M5aDtCm7/LhWJR24RiBRrwG2+imnIs9iLAKTmnqFZnEfKczK?=
 =?us-ascii?Q?fpdF6uucE6ZP0qIuWfgNs0cQA6ynX2Gqo+hRjtLbdAQSPpUsbx6piBMhfhxI?=
 =?us-ascii?Q?k4m6pV3HK2JHQTdvkw08shiEdL1LGd36JdRIFo6NQWPKB2/40lpn4HJdHf6l?=
 =?us-ascii?Q?bP6ji9vEXX9Fknqbh3OKpRxnIocUete3Liy4W9ucRPmQUq9JPBcDWpUwgmSP?=
 =?us-ascii?Q?nSODT0ALhJ9YJUBZlf+2FDtDY6471zkcnO08+QLfysLmu97cZH8ZVS1+i2Me?=
 =?us-ascii?Q?SYbWsLp+wia8ZjeKFSR9EtGUoWLect3U6VP0wjosAcNRyFb3+dKO+dUejSbG?=
 =?us-ascii?Q?Coi9nVU6I58Bd23RNZIAB7bp3vADyvL0tUlew6rXGlVNe9qsFG57AkUeXWVh?=
 =?us-ascii?Q?QWM5eXdhyh6awzOqXPpv9y+Wpx2zgh67f/lZtk441Vre44mI28rmafWXPtVs?=
 =?us-ascii?Q?EIOhOasPSE6p8dhpSS7WdQ2mMNhSaLiS6GI1PPqnizpIh3L3oGFOt/vL7Sdh?=
 =?us-ascii?Q?ZEavgd/A2fFGpwUaSsc0EMP6R/52q3Pu3+977BQD0nb++Xfqvm+JdPytzUg8?=
 =?us-ascii?Q?EFYt8NYC1U5AnfiAqyISmFiOmmw7dy2wGomB7CPnUS382MvSFvye6KrD/jWI?=
 =?us-ascii?Q?RNyfArY4r2rU94M7n6aDPyOQn9L+cOhs8o7hNtgY/PeZjhdphsz1earz1ME4?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73269f2f-084a-4676-fcca-08dde680f04a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 22:19:22.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYJ1PVKhOlrArAZnTo9K+s8RwRjm7dRdFWW7FO22bpw/k6QkX7L9rrqGjur0jN4M7eEcVSvtTmuaFvs/Dg7bktYm/TLjU5ZXukz5NJ5xfro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7823
X-OriginatorOrg: intel.com

On Tue, Aug 26, 2025 at 05:13:33PM +0800, David Gow wrote:
>From: Marie Zhussupova <marievic@google.com>
>
>To enable more complex parameterized testing scenarios, the
>generate_params() function needs additional context beyond just
>the previously generated parameter. This patch modifies the
>generate_params() function signature to include an extra
>`struct kunit *test` argument, giving test users access to the
>parameterized test context when generating parameters.
>
>The `struct kunit *test` argument was added as the first parameter
>to the function signature as it aligns with the convention of other
>KUnit functions that accept `struct kunit *test` first. This also
>mirrors the "this" or "self" reference found in object-oriented
>programming languages.
>
>This patch also modifies xe_pci_live_device_gen_param() in xe_pci.c
>and nthreads_gen_params() in kcsan_test.c to reflect this signature
>change.
>
>Reviewed-by: David Gow <davidgow@google.com>
>Reviewed-by: Rae Moar <rmoar@google.com>
>Acked-by: Marco Elver <elver@google.com>
>Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>Signed-off-by: Marie Zhussupova <marievic@google.com>
>[Catch some additional gen_params signatures in drm/xe/tests --David]
>Signed-off-by: David Gow <davidgow@google.com>
>---
>
>Changes in v4:
>v3: https://lore.kernel.org/linux-kselftest/20250815103604.3857930-4-marievic@google.com/
>- Fixup some additional generate_params signature changes in xe_pci.
>- These are also available as a separate patch here:
>  https://lore.kernel.org/linux-kselftest/20250821135447.1618942-1-davidgow@google.com/
>
>Changes in v3:
>v2: https://lore.kernel.org/all/20250811221739.2694336-4-marievic@google.com/
>- Commit message formatting.
>
>Changes in v2:
>v1: https://lore.kernel.org/all/20250729193647.3410634-4-marievic@google.com/
>    https://lore.kernel.org/all/20250729193647.3410634-5-marievic@google.com/
>    https://lore.kernel.org/all/20250729193647.3410634-6-marievic@google.com/
>- generate_params signature changes in xe_pci.c and kcsan_test.c were
>  squashed into a single patch to avoid in-between breakages in the series.
>- The comments and the commit message were changed to reflect the
>  parameterized testing terminology. See the patch series cover letter
>  change log for the definitions.
>
>---
> drivers/gpu/drm/xe/tests/xe_pci.c      | 14 +++++++-------
> drivers/gpu/drm/xe/tests/xe_pci_test.h |  9 +++++----


Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

> include/kunit/test.h                   |  9 ++++++---
> kernel/kcsan/kcsan_test.c              |  2 +-
> lib/kunit/test.c                       |  5 +++--
> 5 files changed, 22 insertions(+), 17 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests/xe_pci.c
>index 9c715e59f030..f707e0a54295 100644
>--- a/drivers/gpu/drm/xe/tests/xe_pci.c
>+++ b/drivers/gpu/drm/xe/tests/xe_pci.c
>@@ -44,9 +44,9 @@ KUNIT_ARRAY_PARAM(pci_id, pciidlist, xe_pci_id_kunit_desc);
>  *
>  * Return: pointer to the next parameter or NULL if no more parameters
>  */
>-const void *xe_pci_graphics_ip_gen_param(const void *prev, char *desc)
>+const void *xe_pci_graphics_ip_gen_param(struct kunit *test, const void *prev, char *desc)
> {
>-	return graphics_ip_gen_params(prev, desc);
>+	return graphics_ip_gen_params(test, prev, desc);
> }
> EXPORT_SYMBOL_IF_KUNIT(xe_pci_graphics_ip_gen_param);
>
>@@ -61,9 +61,9 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_graphics_ip_gen_param);
>  *
>  * Return: pointer to the next parameter or NULL if no more parameters
>  */
>-const void *xe_pci_media_ip_gen_param(const void *prev, char *desc)
>+const void *xe_pci_media_ip_gen_param(struct kunit *test, const void *prev, char *desc)
> {
>-	return media_ip_gen_params(prev, desc);
>+	return media_ip_gen_params(test, prev, desc);
> }
> EXPORT_SYMBOL_IF_KUNIT(xe_pci_media_ip_gen_param);
>
>@@ -78,9 +78,9 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_media_ip_gen_param);
>  *
>  * Return: pointer to the next parameter or NULL if no more parameters
>  */
>-const void *xe_pci_id_gen_param(const void *prev, char *desc)
>+const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, char *desc)
> {
>-	const struct pci_device_id *pci = pci_id_gen_params(prev, desc);
>+	const struct pci_device_id *pci = pci_id_gen_params(test, prev, desc);
>
> 	return pci->driver_data ? pci : NULL;
> }
>@@ -159,7 +159,7 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_fake_device_init);
>  * Return: pointer to the next &struct xe_device ready to be used as a parameter
>  *         or NULL if there are no more Xe devices on the system.
>  */
>-const void *xe_pci_live_device_gen_param(const void *prev, char *desc)
>+const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc)
> {
> 	const struct xe_device *xe = prev;
> 	struct device *dev = xe ? xe->drm.dev : NULL;
>diff --git a/drivers/gpu/drm/xe/tests/xe_pci_test.h b/drivers/gpu/drm/xe/tests/xe_pci_test.h
>index ce4d2b86b778..6d8bc56f7bde 100644
>--- a/drivers/gpu/drm/xe/tests/xe_pci_test.h
>+++ b/drivers/gpu/drm/xe/tests/xe_pci_test.h
>@@ -7,6 +7,7 @@
> #define _XE_PCI_TEST_H_
>
> #include <linux/types.h>
>+#include <kunit/test.h>
>
> #include "xe_platform_types.h"
> #include "xe_sriov_types.h"
>@@ -25,9 +26,9 @@ struct xe_pci_fake_data {
>
> int xe_pci_fake_device_init(struct xe_device *xe);
>
>-const void *xe_pci_graphics_ip_gen_param(const void *prev, char *desc);
>-const void *xe_pci_media_ip_gen_param(const void *prev, char *desc);
>-const void *xe_pci_id_gen_param(const void *prev, char *desc);
>-const void *xe_pci_live_device_gen_param(const void *prev, char *desc);
>+const void *xe_pci_graphics_ip_gen_param(struct kunit *test, const void *prev, char *desc);
>+const void *xe_pci_media_ip_gen_param(struct kunit *test, const void *prev, char *desc);
>+const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, char *desc);
>+const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc);
>
> #endif
>diff --git a/include/kunit/test.h b/include/kunit/test.h
>index fc8fd55b2dfb..8eba1b03c3e3 100644
>--- a/include/kunit/test.h
>+++ b/include/kunit/test.h
>@@ -128,7 +128,8 @@ struct kunit_attributes {
> struct kunit_case {
> 	void (*run_case)(struct kunit *test);
> 	const char *name;
>-	const void* (*generate_params)(const void *prev, char *desc);
>+	const void* (*generate_params)(struct kunit *test,
>+				       const void *prev, char *desc);
> 	struct kunit_attributes attr;
> 	int (*param_init)(struct kunit *test);
> 	void (*param_exit)(struct kunit *test);
>@@ -1703,7 +1704,8 @@ do {									       \
>  * Define function @name_gen_params which uses @array to generate parameters.
>  */
> #define KUNIT_ARRAY_PARAM(name, array, get_desc)						\
>-	static const void *name##_gen_params(const void *prev, char *desc)			\
>+	static const void *name##_gen_params(struct kunit *test,				\
>+					     const void *prev, char *desc)			\
> 	{											\
> 		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
> 		if (__next - (array) < ARRAY_SIZE((array))) {					\
>@@ -1724,7 +1726,8 @@ do {									       \
>  * Define function @name_gen_params which uses @array to generate parameters.
>  */
> #define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)					\
>-	static const void *name##_gen_params(const void *prev, char *desc)			\
>+	static const void *name##_gen_params(struct kunit *test,				\
>+					     const void *prev, char *desc)			\
> 	{											\
> 		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
> 		if (__next - (array) < ARRAY_SIZE((array))) {					\
>diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
>index 49ab81faaed9..a13a090bb2a7 100644
>--- a/kernel/kcsan/kcsan_test.c
>+++ b/kernel/kcsan/kcsan_test.c
>@@ -1383,7 +1383,7 @@ static void test_atomic_builtins_missing_barrier(struct kunit *test)
>  * The thread counts are chosen to cover potentially interesting boundaries and
>  * corner cases (2 to 5), and then stress the system with larger counts.
>  */
>-static const void *nthreads_gen_params(const void *prev, char *desc)
>+static const void *nthreads_gen_params(struct kunit *test, const void *prev, char *desc)
> {
> 	long nthreads = (long)prev;
>
>diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>index 0fe61dec5a96..50705248abad 100644
>--- a/lib/kunit/test.c
>+++ b/lib/kunit/test.c
>@@ -700,7 +700,7 @@ int kunit_run_tests(struct kunit_suite *suite)
> 			/* Get initial param. */
> 			param_desc[0] = '\0';
> 			/* TODO: Make generate_params try-catch */
>-			curr_param = test_case->generate_params(NULL, param_desc);
>+			curr_param = test_case->generate_params(&test, NULL, param_desc);
> 			test_case->status = KUNIT_SKIPPED;
> 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> 				  "KTAP version 1\n");
>@@ -731,7 +731,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>
> 				/* Get next param. */
> 				param_desc[0] = '\0';
>-				curr_param = test_case->generate_params(curr_param, param_desc);
>+				curr_param = test_case->generate_params(&test, curr_param,
>+									param_desc);
> 			}
> 			/*
> 			 * TODO: Put into a try catch. Since we don't need suite->exit
>-- 
>2.51.0.261.g7ce5a0a67e-goog
>

