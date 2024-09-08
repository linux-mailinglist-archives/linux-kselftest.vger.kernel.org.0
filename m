Return-Path: <linux-kselftest+bounces-17449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0389707E6
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Sep 2024 15:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100C928240C
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Sep 2024 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5046F16FF37;
	Sun,  8 Sep 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RC+OXIHm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C4616F909
	for <linux-kselftest@vger.kernel.org>; Sun,  8 Sep 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725803836; cv=fail; b=fgTpiMe14u9U1F1N2p4yJGLNdlv+PfiepCxCEMda14Gz01JiLiCc8hNrY3x1pkvOUWsSDoPoSmDLF00EXxifqx2DohLJv1TaIO28G9tBvvuLtvHsUTDHDrHPEptcHRDviLfz8z6wD9g1DmKNO6c5DjQ0VXKtjJKujRe7ul9pB9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725803836; c=relaxed/simple;
	bh=74u+muz3Czwi1j/1FBO8DulTz7K1Ft+k2yCesYie0VE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QkyDaaCqcbUP8neHdcAcCMhDWGCHNx8KOCW3I56DuvN1wuCujgClpd2RXETTHnWAI2ew7DiCFqGwZmWXtZkm3DP7EASEDRPRv/bx2CuZPC1B1P/hf5VZ1bGIC8ig26FI/tHAmfK8UtepCHF4UKP6jc3KQiE64u/UJR6p+fH85Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RC+OXIHm; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725803835; x=1757339835;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=74u+muz3Czwi1j/1FBO8DulTz7K1Ft+k2yCesYie0VE=;
  b=RC+OXIHm924v+4Bt6tlvjhM8I83n95JGwRiY+Z2cD+HQF892gn7svnll
   rQ+6ueNUwaLbuL3onUDAnG1Rxjfyg/C0gE/ZEtb3qhkpLMOuQ2Gu/W5bT
   gXBEfdzbdmGzN49O/c5coeZ8mWhXRwH1I/b4A/kAigUPKrVYon8muAL//
   j746HKEhA6aTieqeZMT4W9ZgXRgpPDybw0iDrMQ83n5eBbQ0V6shwOt4W
   FfojRu5JxCG9l9ZNZsQ2zh65kZx8ozq9S9IDVyMfLvjt629wUXPyhsIFr
   T0n0Mk6V5JSnfcc7ypXnmVBhbv49XsifipGKzsj6nIZ90jg2Cp7wZrlVZ
   Q==;
X-CSE-ConnectionGUID: yySmhYxPRjGVm/w+K+LX1g==
X-CSE-MsgGUID: AI7myj1WRdKurAS2yURw0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28240464"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="28240464"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 06:57:15 -0700
X-CSE-ConnectionGUID: hlPpSvBRRq+5hQWjjirzew==
X-CSE-MsgGUID: 6QGkS7D+QJmEQDl+QL9luw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="66396462"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2024 06:57:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 06:57:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Sep 2024 06:57:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Sep 2024 06:57:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Sep 2024 06:57:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsGPZees/vsh87ysro++wN2V4PimqUXvksyaCwxI5Wl6LrHMkhC9prBb2Z2/BKMJ2qJXGJZT7tzWFZ6DKGn1A724V8txBSUNHF8DrZARJ/q6xVpXvUgtk+lrJmS8HBJOeXfczUV3Anz7jdp4q1O29BtS2gabckKTMHJ5wh5mFMrZcSH7pF6QNnSDkWlEjEUjCy873qzqpfvcD4EzensOYDCUwxvEEQLvAPkdiFMRgztS0Bzjpq7och0W4cM+pYdupHsgaBnBukybjNZcAz1Bfoc3MBr7qPnNvKYJuA9bobi4TthZFFK1nEFBPFjncYF0o4Jbz2lfceyArwROh7q2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iALtFVM5ss+dHU/Arpq0jeECrN3B8TCYiItSjUzxvtc=;
 b=F/3ufrrCAhy4/UssYkoaBzYVGxsTtUDrTbqzWALAZOUA6H/vTDB0hJTHTzw66hZ/tF6Tx8thhIDLzvRZYA37m7elWFdZakjsGhS+XIyRhipm9J+2miOKNDJ9cUC4ClFGXIRA80Vqgz+Bar03JvxIPTB55n4E9xtCUQWGKX8g7tNPDguJnN8twRYKSg2pSPkjVYicXfOKBoBc+CUk10JzGsmKj2DkmMJV2JPFTCbMejFKsVm8Gy6WfuMdHtsU7yxjiOtXV14dt10J2AOFhRXrKA0AZy+P6AG4lbf8V34XE/tBinPyphQrdEcvGP0KCwC88vaKYL2amErCNbVG+vfhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB6719.namprd11.prod.outlook.com (2603:10b6:a03:478::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sun, 8 Sep
 2024 13:57:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Sun, 8 Sep 2024
 13:57:10 +0000
Date: Sun, 8 Sep 2024 21:57:02 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <zx2c4@kernel.org>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, <linux-kselftest@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [crng-random:jd/arm64-vdso] [selftests]  f68b079b1d:
 kernel-selftests.vDSO.vdso_standalone_test_x86.fail
Message-ID: <202409082121.553d4c89-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 751053af-a65f-4618-b5d3-08dcd00e2274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PqIoMDo7ZfSXMhzAl82hX+k2VDMifY/2iE6nIxj8GTrr3qHn/2tAYA4pAu+Z?=
 =?us-ascii?Q?9YKuk6JUUMoyehBoNWOGqaHE1e068jHxoO8xsFnIEKCm/GawRN+qf9bJM0j0?=
 =?us-ascii?Q?WUNkN363HMQcdK67+gUg6C6R2zaToKNDsjyyBPmw61neEH00TexAtfYIkKyB?=
 =?us-ascii?Q?PijSlRCLbxWIfCkNor4ZwZAKkcKxWJ1Q8MGkWPJcWfLjzynSPLaPSIGlkil7?=
 =?us-ascii?Q?wtV+yzC90P3QGL02fHAZKE/bI7kue3B5+VrBnCqTykbIkuLiDIJwgviTuvZ5?=
 =?us-ascii?Q?e1nvVVuQKRxXHuKiNs8FlU9icJgX6uICwxgOqz4n6LvyZ0pxu3CNsBdeSnlo?=
 =?us-ascii?Q?2MvTEThTtAOQafDnDwp4Uxo+7N8X0d+jxMWMPND93aGd1KPlKPEryfJX6NX7?=
 =?us-ascii?Q?P9syjm9CRmfLfD8+A17KHiBS0mFxWqHHrHdQOfrl1CE9WHg9PSeWAQJdkkV/?=
 =?us-ascii?Q?kwiRAFNfAYGrQVWMyC+XEVOkzIn+lRzUbXwAjvXUxK5MTp+bhx+CZueyZu8D?=
 =?us-ascii?Q?p3YBmzhXoR+knclXjv1yGLtjsjwwjRW8f4lZXaBIdv/uV2EryQMIxXOmx2dx?=
 =?us-ascii?Q?tB/GvNSurStnhFr0MEGnABRiIUbmZMqRdxeC4gocnGyk/W8HjznzsFQ4lg7Z?=
 =?us-ascii?Q?XHvD3itjOrHjFKPmVhyfCJGEGCX4vxiozTDhRM74fZpoObUyWQQymKFBfPBj?=
 =?us-ascii?Q?067gEfj7rPMAXOMFy142xqArOonV38JIUhhKFLbUIvdrbtVPqlit/qHwrafF?=
 =?us-ascii?Q?Q+QAkvGkwnCm2DuiOpn+zvhZBUJ7OsUdb9g4YnyQ6h1Ex+tBr1+VnlcS8JFx?=
 =?us-ascii?Q?vGp0xt4c7DOQGy5bJU6L3FCSrnZ7/ItyUFCPMERi7agz+AJnUejn1HdFzTnE?=
 =?us-ascii?Q?2InWmtdnuM2hSAvXvCNUu9v7r69XhPWRdIzPvZAsJPnvNUdXp2iQGsBPL/YV?=
 =?us-ascii?Q?qD7+SaNmLu6zn0Bv60gRIlkyxAJhH8zMY1b4LAMm33qJFB3D1JhqnVFcljh1?=
 =?us-ascii?Q?UxslclscSrjAgm0AOvCe04cLyRMSq24/dEtrR+56VJMem6N9Tlx8W2tpLdyz?=
 =?us-ascii?Q?Hi+D5r8k+Mp8s4pt9l/fkMvNGikxm78IpH2dEIVxuzb5RzwBI//CLNYAirmw?=
 =?us-ascii?Q?pr2h2YHDR7VV3OFRri6wKkeDAJxt4IxQ7iWmx9ojGLtNURRIh9qUzTK/c4tU?=
 =?us-ascii?Q?54j3eUdwBqElzFCxsDao8CPSL8lbvvo8Ehi9Yf/n3w2Gh/4J9c9Hbn6JqIR0?=
 =?us-ascii?Q?RDTAADPWypTmtjrHcq0kxYII2owND66tRO0aDIhDv5i+LwRM4KGoMN2cOyGS?=
 =?us-ascii?Q?CZwV4MePZC0xjKv6i2F+ID+gRcTGtEFSIb0tHgtwYejHqDIfSdHHDr5Atocu?=
 =?us-ascii?Q?MTbGZuU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+tmP2UpGtz6aE/s9ph2MZfnEGbBQkn9ZlQS6liFD8GYrt29NlKYyz3B3NRUR?=
 =?us-ascii?Q?MIizaJRgi151Eru1rkF/LYIoWqAY7Q5/ifpL7Xj3LnJCB5FtDuL7THuEy7Rh?=
 =?us-ascii?Q?fkaBTkxQS8oRT7iBCpb6lowwmcUcUrz1XSbx6K3skE+f90AfQfmSH8/CtB8d?=
 =?us-ascii?Q?wEbwY3/mWqCIhYwpXrvq5e6cbQW0j1a0jIBk1BdNZdLPC1raZw3d/4WsNWlF?=
 =?us-ascii?Q?Ma9lqplWJRjqviv1j2vAvokoFczsfUaQuHzaxhrG54xuqvQjJcODh2Ps32Ih?=
 =?us-ascii?Q?FuC+jMboa77D1BgiDxiaXlRe9XKsw9R8iwJ37QtCR7PFuub0U1epYs669HTu?=
 =?us-ascii?Q?vk5Sv/TXX3lqBTueDVa2/tfOg3lJr6iN01YaUycehlzS7Z+0RQrtPw7hUJXt?=
 =?us-ascii?Q?NZTzpjENn8fY/QerI6gtcgB2cumZ6+cdWRmgdgOq/zd8iKSvfufHq3nyEL5m?=
 =?us-ascii?Q?ghGbvgg7j4JADkzykIwRz/EId4W6m+W+1QTJgYy2H93qhIIHfioapzJ++gsV?=
 =?us-ascii?Q?5pYqt0NFv2Ta8Ul26ZVNjgyiJaRyuUv6DSd/Jw2p6BH3K6tsyKw7GdARNy92?=
 =?us-ascii?Q?J85XW5JEPDU2OB+zIqLi6G8aBt4PMIuKJoXfTjOyupy/7mXLJJ+gBezHDLpY?=
 =?us-ascii?Q?RdLlNJpSCTmLtp1cT1mlISE67Kak7gAV3LPl5a6PMJK0jcz9Z+exTSK+SYBZ?=
 =?us-ascii?Q?H5WzR0xZLEDgiJ6udjcpuZqBj6bDYY4UmbgkU+4INnfoVGc0wqjzo6vDhbZ1?=
 =?us-ascii?Q?Lx7OBtKTgq7aPU9JW5GoZDtRhR3MDvTT4l8sPKi5Qdl/xrbWFbqRQ6qMddk1?=
 =?us-ascii?Q?KvrNEZZbmYcG/74ny8y322l8QqQSNCkt8sUgn241TR6nxC8T9tV9/Sl66G6V?=
 =?us-ascii?Q?9f4XX+fPeaqkHiFbc/U0bOoiPg19lCuU9pMeqqpfjL21mQ4HAc5pDS9Inaqp?=
 =?us-ascii?Q?mV3Y24g2IDY82VtpzdvXDKpcYxdGNsG7D5zMbJ2ioqxS47KfrWileKP7LAWw?=
 =?us-ascii?Q?Dw+BZRfDjkn80TvUDn4mqmF7LLiiECHCR3eAT6ajhgCY2COhKXP00RjZ5giP?=
 =?us-ascii?Q?aBQ4zYgO98JQRxcmLORE7hNQI31qU32sVMCtTkgIgRC78IgwEHJulitps4rM?=
 =?us-ascii?Q?BJ+jF0ohP16g23btjyAMLvqFYTA25v/HjQcv3ouHiFYMGLF0DEQY6hc3Sp22?=
 =?us-ascii?Q?Z1qfqghIsw9S+tE2nNN38wxHvmjtCMcrJ7vAEY4Qlqdm7M2kTPy7RKxMnpGQ?=
 =?us-ascii?Q?ArfckJYANzLj0Lzb0F3v+nCPo4h9kPUZ7VhVW4JFZqnyAry8qBTtbhfI7prS?=
 =?us-ascii?Q?tGV0bWQo17KUBIt6CJMMxdvisAOF+xqwCdZk/Kq803OMtZkrMuuo9jPcOUAJ?=
 =?us-ascii?Q?pG2oJUJUmXXh8UkKwYYyzjM/35Gz00Z1s/50QX2+zSXVMOcJx12dbi667Bng?=
 =?us-ascii?Q?LmeOiu2eheGm6acPeGvJVtpIpUxRf4LM9UoJm1YypBxAJ3GWdstHytRp2Joq?=
 =?us-ascii?Q?DHoCX24J2axsCDvcivHfYmcZPUxIQCFa+BCs9GVviHjP0m5WaVeHCvzcUAl0?=
 =?us-ascii?Q?z3SuLln6pW9mFOcnrjlLuCHLl1m1cu1KFVqpqv4jI1Ot6tUt3HVVp5/P9dT4?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 751053af-a65f-4618-b5d3-08dcd00e2274
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2024 13:57:10.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abiwBi3A+QJrZiLEpFk8PBkk3sqEKA5zQNqop5sT/yMX/q6kKaAcWaWgFrcKVxh1FyJBy8evY+joI5ZKUFSY4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6719
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.vDSO.vdso_standalone_test_x86.fail" on:

commit: f68b079b1d5ec46687a097347303b616927eb9ff ("selftests: vDSO: build tests with O2 optimization")
https://git.kernel.org/cgit/linux/kernel/git/crng/random.git jd/arm64-vdso


in testcase: kernel-selftests
version: kernel-selftests-x86_64-977d51cf-1_20240508
with following parameters:

	group: group-03



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409082121.553d4c89-oliver.sang@intel.com



# timeout set to 300
# selftests: vDSO: vdso_standalone_test_x86
# Segmentation fault
not ok 5 selftests: vDSO: vdso_standalone_test_x86 # exit=139



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240908/202409082121.553d4c89-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


